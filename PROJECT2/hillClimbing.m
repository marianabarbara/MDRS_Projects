function [bestSol, bestCost] = hillClimbing(sol, paths, Tu, L, nNodes)
% Hill Climbing optimization for worst link load minimization

bestSol = sol;
bestCost = evaluateWorstLinkLoad(sol, paths, Tu, L, nNodes);

improved = true;

while improved
    improved = false;

    for f = 1:length(sol)
        for p = 1:length(paths{f})

            if p ~= bestSol(f)

                newSol = bestSol;
                newSol(f) = p;

                cost = evaluateWorstLinkLoad(newSol, paths, Tu, L, nNodes);

                if cost < bestCost
                    bestSol = newSol;
                    bestCost = cost;
                    improved = true;
                end
            end
        end
    end
end
end
