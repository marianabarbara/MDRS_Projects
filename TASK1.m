%% Task 1 a)

P = 1e6;     %stopping criteria
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
bar(lambda, PL_values');
er = errorbar(lambda, PL_values, PL_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('PacketLoss (ms)');
hold off

figure(2);
hold on;
grid on;
bar(lambda, APD_values');
ylim([0 9]);
er = errorbar(lambda, APD_values, APD_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('Average packet delay (ms)');
hold off

%% Task 1b)
P = 1e4;     %stopping criteria
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
bar(lambda, PL_values');
er = errorbar(lambda, PL_values, PL_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('PacketLoss (ms)');
hold off

figure(2);
hold on;
grid on;
bar(lambda, APD_values');
ylim([0 9]);
er = errorbar(lambda, APD_values, APD_term);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xlabel('Packet Rate (pps)');
ylabel('Average packet delay (ms)');
hold off