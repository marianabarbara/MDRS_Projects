function [totalEnergy, sleepingLinks] = computeNetworkEnergy(linkLoads, L)

nNodes = size(L,1);
totalEnergy = 0;
sleepingLinks = [];

%% -------- Routers --------
for n = 1:nNodes
    % Sum traffic in both directions for router load
    traffic = sum(linkLoads(n,:)) + sum(linkLoads(:,n));
    t = traffic / 500; % router capacity
    En = 10 + 90 * t^2;
    totalEnergy = totalEnergy + En;
end

%% -------- Links ----------
for i = 1:nNodes
    for j = i+1:nNodes
        if L(i,j) < inf
            % Link is active if there's traffic in either direction
            if linkLoads(i,j) > 0 || linkLoads(j,i) > 0
                % active link (50 Gbps)
                El = 6 + 0.2 * L(i,j);
            else
                % sleeping link
                El = 2;
                sleepingLinks = [sleepingLinks; i j];
            end
            totalEnergy = totalEnergy + El;
        end
    end
end
end
