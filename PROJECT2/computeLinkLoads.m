function linkLoads = computeLinkLoads(sol, paths, Tu, nNodes)
% Computes link loads for Task 2 (symmetrical routing)
% For each flow, the same path carries both upstream and downstream traffic

linkLoads = zeros(nNodes);

for f = 1:length(sol)
    path = paths{f}{sol(f)};
    up = Tu(f,3);    % upstream bandwidth
    down = Tu(f,4);  % downstream bandwidth

    % Path carries upstream traffic (s -> d)
    for i = 1:length(path)-1
        a = path(i);
        b = path(i+1);
        linkLoads(a,b) = linkLoads(a,b) + up;
    end

    % Path carries downstream traffic (d -> s) - reverse direction
    for i = length(path):-1:2
        a = path(i);
        b = path(i-1);
        linkLoads(a,b) = linkLoads(a,b) + down;
    end
end
end
