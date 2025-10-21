%% Task 1 a)

P = 1e5;        % stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e6;
lambda = [1100 1300 1500 1700 1900];

PL = zeros(1, N);
APD = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

PL_values = zeros(1, length(lambda));
PL_term = zeros(1, length(lambda));
APD_values = zeros(1, length(lambda));
APD_term = zeros(1, length(lambda));

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator1(lambda(i),C,f,P);
    end
    
    fprintf('Valor de lambda: %d\n', lambda(i));
    mediaPL = mean(PL);
    termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
    PL_values(i) = mediaPL;
    PL_term(i) = termPL;
    fprintf('Packet Loss (%%) = %.2e +- %.2e\n', mediaPL, termPL);
    
    mediaAPD = mean(APD);
    termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
    APD_values(i) = mediaAPD;
    APD_term(i) = termAPD;
    fprintf('Average Packet Delay (ms) = %.2e +- %.2e\n', mediaAPD, termAPD);
end

fprintf('\nSimulation ended!\n');



figure(1);
hold on;
grid on;
bar(lambda, PL_values);
er = errorbar(lambda, PL_values, PL_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('Packet Loss (%)');
hold off

figure(2);
hold on;
grid on;
bar(lambda, APD_values);
ylim([0 9]);
er = errorbar(lambda, APD_values, APD_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('Average packet delay (ms)');
hold off


%% Task 1b)
P = 1e5;     %stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e4;
lambda = [1100 1300 1500 1700 1900];

PL = zeros(1, N);
APD = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

PL_values = zeros(1, length(lambda));
PL_term = zeros(1, length(lambda));
APD_values = zeros(1, length(lambda));
APD_term = zeros(1, length(lambda));

for i = 1:length(lambda)
    for it = 1:N
        [PL(it), APD(it), MPD(it), TT(it)] = Simulator1(lambda(i),C,f,P);
    end
    
    fprintf('Valor de lambda: %d\n', lambda(i));
    mediaPL = mean(PL);
    termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
    PL_values(i) = mediaPL;
    PL_term(i) = termPL;
    fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL, termPL);
    
    mediaAPD = mean(APD);
    termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
    APD_values(i) = mediaAPD;
    APD_term(i) = termAPD;
    fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD, termAPD);
end

fprintf('\nSimulation ended!\n');



figure(1);
hold on;
grid on;
bar(lambda, PL_values);
er = errorbar(lambda, PL_values, PL_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('PacketLoss (ms)');
hold off

figure(2);
hold on;
grid on;
bar(lambda, APD_values);
ylim([0 9]);
er = errorbar(lambda, APD_values, APD_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

%% TASK 1d
P = 1e5;     %stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e6;
lambda = 1900;

PL = zeros(1, N);
PL_64 = zeros(1, N);
PL_110 = zeros(1, N);
PL_1518 = zeros(1, N);
APD = zeros(1, N);
APD_64 = zeros(1, N);
APD_110 = zeros(1, N);
APD_1518 = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

for it = 1:N
    [PL(it) , PL_64(it), PL_110(it), PL_1518(it), APD(it) , APD_64(it), APD_110(it), APD_1518(it), MPD(it) , TT(it)] = Simulator1A(lambda,C,f,P);
end

mediaPL = mean(PL);
termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL, termPL);
    
mediaAPD = mean(APD);
termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD, termAPD);

mediaPL_64 = mean(PL_64);
termPL_64 = norminv(1-alfa/2) * sqrt(var(PL_64)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_64, termPL_64);
    
mediaAPD_64 = mean(APD_64);
termAPD_64 = norminv(1-alfa/2) * sqrt(var(APD_64)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_64, termAPD_64);

mediaPL_110 = mean(PL_110);
termPL_110 = norminv(1-alfa/2) * sqrt(var(PL_110)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_110, termPL_110);
    
mediaAPD_110 = mean(APD_110);
termAPD_110 = norminv(1-alfa/2) * sqrt(var(APD_110)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_110, termAPD_110);

mediaPL_1518 = mean(PL_1518);
termPL_1518 = norminv(1-alfa/2) * sqrt(var(PL_1518)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_1518, termPL_1518);
    
mediaAPD_1518 = mean(APD_1518);
termAPD_1518 = norminv(1-alfa/2) * sqrt(var(APD_1518)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_1518, termAPD_1518);


fprintf('\nSimulation ended!\n');


PL_means  = [mediaPL,  mediaPL_64,  mediaPL_110,  mediaPL_1518];
PL_terms  = [termPL,   termPL_64,   termPL_110,   termPL_1518];
APD_means = [mediaAPD, mediaAPD_64, mediaAPD_110, mediaAPD_1518];
APD_terms = [termAPD,  termAPD_64,  termAPD_110,  termAPD_1518];

labels = {'All','64 B','110 B','1518 B'};
lambda = 1900;  % just for titles

% Figure 1 — Average Packet Loss (%)
figure(1); clf; hold on; grid on;
b1 = bar(PL_means);
% center positions of the bars are 1:4 for a single-series bar chart
errorbar(1:4, PL_means, PL_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Packet loss (%)');
title(sprintf('Average Packet Loss at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
% Optional cosmetics

box on; hold off;

%Figure 2 — Average Packet Delay (ms)
figure(2); clf; hold on; grid on;
b2 = bar(APD_means);
errorbar(1:4, APD_means, APD_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Average packet delay (ms)');
title(sprintf('Average Packet Delay at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
box on; hold off;

%% Task 1e - Teórica

%% Task 1f
P = 1e5;     %stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e4;
lambda = 1900;

PL = zeros(1, N);
PL_64 = zeros(1, N);
PL_110 = zeros(1, N);
PL_1518 = zeros(1, N);
APD = zeros(1, N);
APD_64 = zeros(1, N);
APD_110 = zeros(1, N);
APD_1518 = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

for it = 1:N
    [PL(it) , PL_64(it), PL_110(it), PL_1518(it), APD(it) , APD_64(it), APD_110(it), APD_1518(it), MPD(it) , TT(it)] = Simulator1A(lambda,C,f,P);
end

mediaPL = mean(PL);
termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL, termPL);
    
mediaAPD = mean(APD);
termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD, termAPD);

mediaPL_64 = mean(PL_64);
termPL_64 = norminv(1-alfa/2) * sqrt(var(PL_64)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_64, termPL_64);
    
mediaAPD_64 = mean(APD_64);
termAPD_64 = norminv(1-alfa/2) * sqrt(var(APD_64)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_64, termAPD_64);

mediaPL_110 = mean(PL_110);
termPL_110 = norminv(1-alfa/2) * sqrt(var(PL_110)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_110, termPL_110);
    
mediaAPD_110 = mean(APD_110);
termAPD_110 = norminv(1-alfa/2) * sqrt(var(APD_110)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_110, termAPD_110);

mediaPL_1518 = mean(PL_1518);
termPL_1518 = norminv(1-alfa/2) * sqrt(var(PL_1518)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_1518, termPL_1518);
    
mediaAPD_1518 = mean(APD_1518);
termAPD_1518 = norminv(1-alfa/2) * sqrt(var(APD_1518)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_1518, termAPD_1518);


fprintf('\nSimulation ended!\n');


PL_means  = [mediaPL,  mediaPL_64,  mediaPL_110,  mediaPL_1518];
PL_terms  = [termPL,   termPL_64,   termPL_110,   termPL_1518];
APD_means = [mediaAPD, mediaAPD_64, mediaAPD_110, mediaAPD_1518];
APD_terms = [termAPD,  termAPD_64,  termAPD_110,  termAPD_1518];

labels = {'All','64 B','110 B','1518 B'};
lambda = 1900;  % just for titles

% Figure 1 — Average Packet Loss (%)
figure(1); clf; hold on; grid on;
b1 = bar(PL_means);
% center positions of the bars are 1:4 for a single-series bar chart
errorbar(1:4, PL_means, PL_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Packet loss (%)');
title(sprintf('Average Packet Loss at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
% Optional cosmetics

box on; hold off;

%Figure 2 — Average Packet Delay (ms)
figure(2); clf; hold on; grid on;
b2 = bar(APD_means);
errorbar(1:4, APD_means, APD_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Average packet delay (ms)');
title(sprintf('Average Packet Delay at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
box on; hold off;


%% Task 1h
P = 1e5;     %stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e6;
lambda = 1900;

PL = zeros(1, N);
PL_64 = zeros(1, N);
PL_110 = zeros(1, N);
PL_1518 = zeros(1, N);
APD = zeros(1, N);
APD_64 = zeros(1, N);
APD_110 = zeros(1, N);
APD_1518 = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

for it = 1:N
    [PL(it) , PL_64(it), PL_110(it), PL_1518(it), APD(it) , APD_64(it), APD_110(it), APD_1518(it), MPD(it) , TT(it)] = Simulator1B(lambda,C,f,P);
end

mediaPL = mean(PL);
termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL, termPL);
    
mediaAPD = mean(APD);
termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD, termAPD);

mediaPL_64 = mean(PL_64);
termPL_64 = norminv(1-alfa/2) * sqrt(var(PL_64)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_64, termPL_64);
    
mediaAPD_64 = mean(APD_64);
termAPD_64 = norminv(1-alfa/2) * sqrt(var(APD_64)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_64, termAPD_64);

mediaPL_110 = mean(PL_110);
termPL_110 = norminv(1-alfa/2) * sqrt(var(PL_110)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_110, termPL_110);
    
mediaAPD_110 = mean(APD_110);
termAPD_110 = norminv(1-alfa/2) * sqrt(var(APD_110)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_110, termAPD_110);

mediaPL_1518 = mean(PL_1518);
termPL_1518 = norminv(1-alfa/2) * sqrt(var(PL_1518)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_1518, termPL_1518);
    
mediaAPD_1518 = mean(APD_1518);
termAPD_1518 = norminv(1-alfa/2) * sqrt(var(APD_1518)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_1518, termAPD_1518);


fprintf('\nSimulation ended!\n');


PL_means  = [mediaPL,  mediaPL_64,  mediaPL_110,  mediaPL_1518];
PL_terms  = [termPL,   termPL_64,   termPL_110,   termPL_1518];
APD_means = [mediaAPD, mediaAPD_64, mediaAPD_110, mediaAPD_1518];
APD_terms = [termAPD,  termAPD_64,  termAPD_110,  termAPD_1518];

labels = {'All','64 B','110 B','1518 B'};
lambda = 1900;  % just for titles

% Figure 1 — Average Packet Loss (%)
figure(1); clf; hold on; grid on;
b1 = bar(PL_means);
% center positions of the bars are 1:4 for a single-series bar chart
errorbar(1:4, PL_means, PL_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Packet loss (%)');
title(sprintf('Average Packet Loss at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
% Optional cosmetics

box on; hold off;

%Figure 2 — Average Packet Delay (ms)
figure(2); clf; hold on; grid on;
b2 = bar(APD_means);
errorbar(1:4, APD_means, APD_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Average packet delay (ms)');
title(sprintf('Average Packet Delay at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
box on; hold off;

%% Task 1i
P = 1e5;     %stopping criteria
N = 50;         % number of runs
alfa = 0.1;     % 90% confidence intervals
C = 10;         % C = 10 Mbps
f = 1e4;
lambda = 1900;

PL = zeros(1, N);
PL_64 = zeros(1, N);
PL_110 = zeros(1, N);
PL_1518 = zeros(1, N);
APD = zeros(1, N);
APD_64 = zeros(1, N);
APD_110 = zeros(1, N);
APD_1518 = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

for it = 1:N
    [PL(it) , PL_64(it), PL_110(it), PL_1518(it), APD(it) , APD_64(it), APD_110(it), APD_1518(it), MPD(it) , TT(it)] = Simulator1B(lambda,C,f,P);
end

mediaPL = mean(PL);
termPL = norminv(1-alfa/2) * sqrt(var(PL)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL, termPL);
    
mediaAPD = mean(APD);
termAPD = norminv(1-alfa/2) * sqrt(var(APD)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD, termAPD);

mediaPL_64 = mean(PL_64);
termPL_64 = norminv(1-alfa/2) * sqrt(var(PL_64)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_64, termPL_64);
    
mediaAPD_64 = mean(APD_64);
termAPD_64 = norminv(1-alfa/2) * sqrt(var(APD_64)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_64, termAPD_64);

mediaPL_110 = mean(PL_110);
termPL_110 = norminv(1-alfa/2) * sqrt(var(PL_110)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_110, termPL_110);
    
mediaAPD_110 = mean(APD_110);
termAPD_110 = norminv(1-alfa/2) * sqrt(var(APD_110)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_110, termAPD_110);

mediaPL_1518 = mean(PL_1518);
termPL_1518 = norminv(1-alfa/2) * sqrt(var(PL_1518)/N);
fprintf('PacketLoss (%%)\t  = %.2e +- %.2e\n', mediaPL_1518, termPL_1518);
    
mediaAPD_1518 = mean(APD_1518);
termAPD_1518 = norminv(1-alfa/2) * sqrt(var(APD_1518)/N);
fprintf('Ag. Packet Delay (ms)\t = %.2e +- %.2e\n', mediaAPD_1518, termAPD_1518);


fprintf('\nSimulation ended!\n');


PL_means  = [mediaPL,  mediaPL_64,  mediaPL_110,  mediaPL_1518];
PL_terms  = [termPL,   termPL_64,   termPL_110,   termPL_1518];
APD_means = [mediaAPD, mediaAPD_64, mediaAPD_110, mediaAPD_1518];
APD_terms = [termAPD,  termAPD_64,  termAPD_110,  termAPD_1518];

labels = {'All','64 B','110 B','1518 B'};
lambda = 1900;  % just for titles

% Figure 1 — Average Packet Loss (%)
figure(1); clf; hold on; grid on;
b1 = bar(PL_means);
% center positions of the bars are 1:4 for a single-series bar chart
errorbar(1:4, PL_means, PL_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Packet loss (%)');
title(sprintf('Average Packet Loss at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
% Optional cosmetics

box on; hold off;

%Figure 2 — Average Packet Delay (ms)
figure(2); clf; hold on; grid on;
b2 = bar(APD_means);
errorbar(1:4, APD_means, APD_terms, 'k', 'LineStyle','none', 'LineWidth',1);
set(gca,'XTick',1:4,'XTickLabel',labels);
ylabel('Average packet delay (ms)');
title(sprintf('Average Packet Delay at \\lambda = %d pps (C=10 Mbps, f=1 MB)', lambda));
box on; hold off;