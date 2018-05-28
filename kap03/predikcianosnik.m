clc; clear;
load nosnik          % Nahraj data
load model           % Nahraj A a pociatocny stav
Ts=0.005;            % Vzorkovanie
y=y(1000:1500);      % Vyber casti merania

M=predikciaM(A,500); % Matica M, horizont 500
xp=M*x0;             % Predikovany stav

figure(1)                     % Novy obrazok
plot(y);                      % Nakresli meranie
hold on                       % Nechat graf
plot(xp(1:2:end,:),'.-');     % Neparne elementy
grid on                       % Mriezka
xlabel('Cas (vzorky)')        % Os X
ylabel('Posunutie (mm)')      % Os Y
legend('Meranie','Predikcia') % Legenda