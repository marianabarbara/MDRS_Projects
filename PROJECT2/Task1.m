%% Task 1.a - Shortest Path Routing
% Modelação e Desempenho de Redes e Serviços
% MPLS Network - Task 1.a

clear;
clc;

% Load input data
load('InputDataProject2.mat');

% L  -> Link length matrix (Km)
% Tu -> Unicast flows: [src dst up down] (Gbps)
% Ta -> Anycast flows: [src up down] (Gbps)

nNodes = size(L,1);
C = 50;                 % Link capacity (Gbps)
anycastNodes = [5 12];  % Anycast nodes

% Build graph (using link lengths)
Adj = inf(nNodes);
Adj(L > 0) = L(L > 0);
Adj(1:nNodes+1:end) = 0;

G = graph(Adj);

%% Initialize link load matrix (Gbps)
linkLoad = zeros(nNodes);

% -------------------------------
% Unicast traffic (shortest path)
% -------------------------------
for f = 1:size(Tu,1)

    s = Tu(f,1);
    d = Tu(f,2);
    up = Tu(f,3);
    down = Tu(f,4);

    % s -> d
    pathSD = shortestpath(G, s, d);
    for k = 1:length(pathSD)-1
        i = pathSD(k);
        j = pathSD(k+1);
        linkLoad(i,j) = linkLoad(i,j) + up;
        linkLoad(j,i) = linkLoad(j,i) + up;
    end

    % d -> s
    pathDS = shortestpath(G, d, s);
    for k = 1:length(pathDS)-1
        i = pathDS(k);
        j = pathDS(k+1);
        linkLoad(i,j) = linkLoad(i,j) + down;
        linkLoad(j,i) = linkLoad(j,i) + down;
    end
end

% --------------------------------
% Anycast traffic (shortest path)
% --------------------------------
for f = 1:size(Ta,1)

    s = Ta(f,1);
    up = Ta(f,2);
    down = Ta(f,3);

    % Shortest path to each anycast node
    [path5, d5]   = shortestpath(G, s, anycastNodes(1));
    [path12, d12] = shortestpath(G, s, anycastNodes(2));

    if d5 <= d12
        acNode = anycastNodes(1);
        pathUp = path5;
    else
        acNode = anycastNodes(2);
        pathUp = path12;
    end

    % s -> anycast (upstream)
    for k = 1:length(pathUp)-1
        i = pathUp(k);
        j = pathUp(k+1);
        linkLoad(i,j) = linkLoad(i,j) + up;
        linkLoad(j,i) = linkLoad(j,i) + up;
    end

    % anycast -> s (downstream)
    pathDown = shortestpath(G, acNode, s);
    for k = 1:length(pathDown)-1
        i = pathDown(k);
        j = pathDown(k+1);
        linkLoad(i,j) = linkLoad(i,j) + down;
        linkLoad(j,i) = linkLoad(j,i) + down;
    end
end

% -------------------------------
% Compute link loads and worst load
% -------------------------------
linkLoadVec = [];
linkIndex = [];

for i = 1:nNodes
    for j = i+1:nNodes
        if L(i,j) > 0
            linkLoadVec(end+1) = linkLoad(i,j);
            linkIndex(end+1,:) = [i j];
        end
    end
end

[worstLinkLoad, idx] = max(linkLoadVec);
worstUtilization = worstLinkLoad / C * 100;

% -------------------------------
% Display results
% -------------------------------
fprintf('--- Task 1.a Results ---\n');
fprintf('Worst link load: %.2f Gbps\n', worstLinkLoad);
fprintf('Worst link utilization: %.2f %%\n', worstUtilization);
fprintf('Worst link: (%d - %d)\n', linkIndex(idx,1), linkIndex(idx,2));

% Optional: Display all link loads
disp('Link loads (Gbps):');
for k = 1:length(linkLoadVec)
    fprintf('Link %2d-%2d : %6.2f Gbps\n', ...
        linkIndex(k,1), linkIndex(k,2), linkLoadVec(k));
end


%% Task 1.b - Network Energy Consumption
% Requires linkLoad from Task 1.a

% Parameters
routerCapacity = 500;  % Gbps
nNodes = size(linkLoad,1);

% -------------------------------
% Router energy consumption
% -------------------------------
routerLoad = zeros(nNodes,1);

% Sum all traffic passing through each router
for i = 1:nNodes
    routerLoad(i) = sum(linkLoad(i,:));
end

% Compute router energy
routerEnergy = zeros(nNodes,1);
for i = 1:nNodes
    t = routerLoad(i) / routerCapacity;
    routerEnergy(i) = 10 + 90 * t^2;
end

totalRouterEnergy = sum(routerEnergy);

% -------------------------------
% Link energy consumption
% -------------------------------
linkEnergy = 0;
sleepingLinks = [];

for i = 1:nNodes
    for j = i+1:nNodes
        if L(i,j) > 0   % existing link

            if linkLoad(i,j) > 0
                % Active link (50 Gbps)
                El = 6 + 0.2 * L(i,j);
            else
                % Sleeping link
                El = 2;
                sleepingLinks(end+1,:) = [i j];
            end

            linkEnergy = linkEnergy + El;
        end
    end
end

% -------------------------------
% Total network energy
% -------------------------------
totalEnergy = totalRouterEnergy + linkEnergy;

% -------------------------------
% Display results
% -------------------------------
fprintf('\n--- Task 1.b Results ---\n');
fprintf('Total router energy: %.2f\n', totalRouterEnergy);
fprintf('Total link energy: %.2f\n', linkEnergy);
fprintf('Total network energy: %.2f\n', totalEnergy);

fprintf('\nSleeping links:\n');
if isempty(sleepingLinks)
    fprintf('None\n');
else
    for k = 1:size(sleepingLinks,1)
        fprintf('Link %d-%d\n', sleepingLinks(k,1), sleepingLinks(k,2));
    end
end





%% Task 1.c - Multi Start Hill Climbing
% Minimization of worst link load
% Using Yen's k-shortest path algorithm

clear;
clc;

% Load data
load('InputDataProject2.mat');

k = 6;              % number of candidate paths
timeLimit = 30;     % seconds
nNodes = size(L,1);
nFlows = size(Tu,1);

% Build cost matrix (link lengths)
netCostMatrix = inf(nNodes);
netCostMatrix(L > 0) = L(L > 0);
netCostMatrix(1:nNodes+1:end) = 0;

% Compute k-shortest paths for each unicast flow
paths = cell(nFlows,1);

for f = 1:nFlows
    s = Tu(f,1);
    d = Tu(f,2);

    [sp, ~] = kShortestPath(netCostMatrix, s, d, k);
    paths{f} = sp;
end

% Multi Start Hill Climbing
bestGlobalCost = inf;
bestGlobalSolution = [];
bestTime = 0;

tStart = tic;

while toc(tStart) < timeLimit

    % Initial greedy randomized solution
    sol0 = greedyRandomInitialSolution(paths);

    % Hill Climbing optimization
    [sol, cost] = hillClimbing(sol0, paths, Tu, L, nNodes);

    % Update global best
    if cost < bestGlobalCost
        bestGlobalCost = cost;
        bestGlobalSolution = sol;
        bestTime = toc(tStart);
    end
end

% Display results
fprintf('--- Task 1.c Results ---\n');
fprintf('Worst link load: %.2f Gbps\n', bestGlobalCost);
fprintf('Best solution found at %.2f seconds\n', bestTime);


