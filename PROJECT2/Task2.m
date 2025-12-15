%% =========================================================
% Task 2.a – Energy Minimization with Constraints
% =========================================================

clear; clc;
load('InputDataProject2.mat');

% ---------------- Parameters ----------------
linkCapacity   = 50;   % Gbps (constraint)
k = 6;
timeLimit = 30;        % seconds

L(L==0) = inf;
nNodes = size(L,1);
nFlows = size(Tu,1);

fprintf('\n========== Task 2.a: Multi Start Hill Climbing ==========\n');
fprintf('Algorithm Development:\n');
fprintf('  - k-shortest path algorithm (k = %d)\n', k);
fprintf('  - Greedy randomized initial solutions\n');
fprintf('  - Energy minimization objective\n');
fprintf('  - Link load constraint: <= 100%%\n\n');

% ---------------- Step 1: k-shortest paths ----------------
fprintf('Step 1: Determining candidate routing paths for each unicast flow:\n');
paths = cell(nFlows,1);
nSP   = zeros(nFlows,1);

for f = 1:nFlows
    s = Tu(f,1);
    d = Tu(f,2);
    [p, ~] = kShortestPath(L, s, d, k);
    paths{f} = p;
    nSP(f) = length(p);
    fprintf('  Flow %2d (%2d -> %2d): %d candidate paths\n', f, s, d, length(p));
end

% ---------------- Step 2: Run Multi Start Hill Climbing ----------------
fprintf('\nStep 2: Running Multi Start Hill Climbing for %d seconds...\n\n', timeLimit);

bestEnergy = inf;
bestSol = [];
bestTime = 0;

tStart = tic;

while toc(tStart) < timeLimit

    % Greedy randomized initial solution
    sol0 = greedyRandomInitialSolution(paths);

    % Hill Climbing (Task 2 energy objective)
    [sol, energy] = hillClimbingEnergyTask2( ...
        sol0, paths, Tu, L, nNodes);

    % Update global best
    if energy < bestEnergy
        bestEnergy = energy;
        bestSol = sol;
        bestTime = toc(tStart);
    end
end

% ---------------- Final evaluation ----------------
linkLoads = computeLinkLoads(bestSol, paths, Tu, nNodes);
worstLinkLoad = max(linkLoads(:)) / linkCapacity;

[totalEnergy, sleepingLinks] = computeNetworkEnergy(linkLoads, L);

% ---------------- Task 2.a Results ----------------
fprintf('========== Task 2.a Results ==========\n');
fprintf('Worst link load      : %.4f (%.2f%%)\n', worstLinkLoad, worstLinkLoad*100);
fprintf('Network energy (W)   : %.2f\n', totalEnergy);
fprintf('Sleeping links       : %d\n', size(sleepingLinks,1));
fprintf('Best solution time(s): %.2f\n', bestTime);

% Display sleeping links
if ~isempty(sleepingLinks)
    fprintf('\nLinks in sleeping mode:\n');
    for i = 1:size(sleepingLinks,1)
        fprintf('  Link %2d - %2d\n', sleepingLinks(i,1), sleepingLinks(i,2));
    end
end

% Store Task 2.a results for comparison (2.a = 2.b since same parameters)
task2ab_worstLoad = worstLinkLoad;
task2ab_energy = totalEnergy;
task2ab_sleepingLinks = size(sleepingLinks,1);
task2ab_bestTime = bestTime;


%% =========================================================
% Task 2.b – Run Algorithm and Report Results
% =========================================================
% Note: Task 2.b has same requirements as 2.a (k=6, 30 seconds)
% Results are already shown above in Task 2.a output


%% =========================================================
% Task 2.c – Run with All Possible Paths
% =========================================================

fprintf('\n\n========== Task 2.c: All Possible Paths ==========\n');
fprintf('Computing all possible candidate paths...\n');

% Compute all possible paths (use large k to get all paths)
kAll = 100;  % large enough to get all simple paths
pathsAll = cell(nFlows,1);

for f = 1:nFlows
    s = Tu(f,1);
    d = Tu(f,2);
    [p, ~] = kShortestPath(L, s, d, kAll);
    pathsAll{f} = p;
    fprintf('  Flow %d (%d->%d): %d paths\n', f, s, d, length(p));
end

fprintf('\nRunning algorithm for %d seconds...\n', timeLimit);

% Start with shortest path (greedy) solution as initial best
bestSol = ones(nFlows, 1);  % Select first (shortest) path for each flow
[bestEnergy, feasible] = evaluateEnergyTask2(bestSol, pathsAll, Tu, L, nNodes);
if ~feasible
    bestEnergy = inf;
    bestSol = [];
end
bestTime = 0;
iterations = 0;
feasibleCount = feasible;

tStart = tic;

while toc(tStart) < timeLimit

    % Greedy randomized initial solution (biased towards shorter paths)
    sol0 = zeros(nFlows, 1);
    for f = 1:nFlows
        % Bias towards first (shortest) paths: 70% chance for first 3 paths
        if rand() < 0.7 && length(pathsAll{f}) >= 3
            sol0(f) = randi(min(3, length(pathsAll{f})));
        else
            sol0(f) = randi(length(pathsAll{f}));
        end
    end

    % Hill Climbing (Task 2 energy objective)
    [sol, energy] = hillClimbingEnergyTask2( ...
        sol0, pathsAll, Tu, L, nNodes);

    % Update global best
    if ~isinf(energy) && energy > 0
        feasibleCount = feasibleCount + 1;
        if energy < bestEnergy
            bestEnergy = energy;
            bestSol = sol;
            bestTime = toc(tStart);
        end
    end

    iterations = iterations + 1;
end

fprintf('Total iterations: %d (feasible: %d)\n\n', iterations, feasibleCount);

% Check if we found a valid solution
if isempty(bestSol)
    fprintf('WARNING: No valid solution found! Using last feasible solution...\n');
    % Try to get any feasible solution
    for attempt = 1:100
        sol0 = greedyRandomInitialSolution(pathsAll);
        [sol, energy] = hillClimbingEnergyTask2(sol0, pathsAll, Tu, L, nNodes);
        if ~isinf(energy) && energy > 0
            bestSol = sol;
            bestEnergy = energy;
            break;
        end
    end
end

% ---------------- Final evaluation ----------------
linkLoads = computeLinkLoads(bestSol, pathsAll, Tu, nNodes);
worstLinkLoad = max(linkLoads(:)) / linkCapacity;

[totalEnergy, sleepingLinks] = computeNetworkEnergy(linkLoads, L);

% ---------------- Results ----------------
fprintf('========== Task 2.c Results ==========\n');
fprintf('Worst link load      : %.4f (%.2f%%)\n', worstLinkLoad, worstLinkLoad*100);
fprintf('Network energy (W)   : %.2f\n', totalEnergy);
fprintf('Sleeping links       : %d\n', size(sleepingLinks,1));
fprintf('Best solution time(s): %.2f\n', bestTime);

% Display sleeping links
if ~isempty(sleepingLinks)
    fprintf('\nLinks in sleeping mode:\n');
    for i = 1:size(sleepingLinks,1)
        fprintf('  Link %2d - %2d\n', sleepingLinks(i,1), sleepingLinks(i,2));
    end
end
