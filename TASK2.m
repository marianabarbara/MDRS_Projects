%% Task 2b)

P = 1e5;    	% stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e6;
lambda = 1500;
b = 10^-5;
n = [10 20 30 40];

PLd = zeros(1,N);
APDd = zeros(1,N);
MPDd = zeros(1,N);

PLv = zeros(1,N);
APDv = zeros(1,N);
MPDv = zeros(1,N);
TT = zeros(1,N);

for i = 1:length(n)
    for it = 1:N
        [PLd(it) , APDd(it) , MPDd(it) , PLv(it) , APDv(it) , MPDv(it), TT(it)] = Simulator3A(lambda,C,f,P, n, b);
    end
   
    fprintf('Valor de n: %d\n', n(i));
    mediaPLd = mean(PLd);
    termPLd = norminv(1-alfa/2) * sqrt(var(PLd)/N);
    fprintf('PacketLoss of data(%%)\t  = %.2e +- %.2e\n', mediaPLd, termPLd);
    
    mediaPLv = mean(PLv);
    termPLv = norminv(1-alfa/2) * sqrt(var(PLv)/N);
    fprintf('PacketLoss of VoIP (%%)\t  = %.2e +- %.2e\n', mediaPLv, termPLv);
    
    mediaAPDd = mean(APDd);
    termAPDd = norminv(1-alfa/2) * sqrt(var(APDd)/N);
    fprintf('Ag. Packet Delay of data (ms)\t = %.2e +- %.2e\n', mediaAPDd, termAPDd);
    
    mediaAPDv = mean(APDv);
    termAPDv = norminv(1-alfa/2) * sqrt(var(APDv)/N);
    fprintf('Ag. Packet Delay of VoIP (ms)\t = %.2e +- %.2e\n', mediaAPDv, termAPDv);
    
    mediaMPDd = mean(MPDd);
    termMPDd = norminv(1-alfa/2) * sqrt(var(MPDd)/N);
    fprintf('Max. Packet Delay of data (ms)\t = %.2e +- %.2e\n', mediaMPDd, termMPDd);
    
    mediaMPDv = mean(MPDv);
    termMPDv = norminv(1-alfa/2) * sqrt(var(MPDv)/N);
    fprintf('Max. Packet Delay of VoIP (ms)\t = %.2e +- %.2e\n', mediaMPDv, termMPDv);
    
    mediaTT = mean(TT);
    termTT = norminv(1-alfa/2) * sqrt(var(TT)/N);
    fprintf('Througtput (Mbps)\t = %.2e +- %.2e\n', mediaTT, termTT);
end
