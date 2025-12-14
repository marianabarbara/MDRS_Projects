function worstLoad = evaluateWorstLinkLoad(sol, paths, Tu, L, nNodes)
% Computes worst link load for a routing solution

linkLoad = zeros(nNodes);

for f = 1:length(sol)
    path = paths{f}{sol(f)};
    bw = Tu(f,3) + Tu(f,4);  % symmetric traffic

    for i = 1:length(path)-1
        a = path(i);
        b = path(i+1);
        linkLoad(a,b) = linkLoad(a,b) + bw;
        linkLoad(b,a) = linkLoad(b,a) + bw;
    end
end

% Extract only existing links
loads = [];
for i = 1:nNodes
    for j = i+1:nNodes
        if L(i,j) < inf
            loads = [loads linkLoad(i,j)];
        end
    end
end

worstLoad = max(loads) / 50; % normalize by 50 Gbps capacity
end
