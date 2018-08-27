clc; clear all;
% Zadanie prikladu
load bus.mat                         % Nacitaj model
A=bus.a; B=bus.b(:,2);  C=bus.c;     % Model autobusu
nx=length(A);                        % Pocet stavov
Q=C'*C; R=10; np=20;                 % Vahy a horizont                       
uh=0.01; ul=-uh;                     % Obmedzenia vstupu

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);         % Koncove vahovanie
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);  % Ucelova funkcia
[Ac,bc]=obmedzenia(ul,uh,np);        % Obmedzenia na u

% MPC pre dany stav
x=[0.1 0 0 0]';                             % Poc. stav
uopt=quadprog(H,G*x,Ac,bc);                 % MPC
ulq=-K*x;                                   % LQ

% Graficka ilustracia vysledkov
stairs(uopt,'.-')                           % MPC vstupy
hold on                                     % Podrz graf
stairs(ulq,'o')                             % LQ vstup
line([0,np],[uh uh],'Color','k','LineStyle','--') % uh
line([0,np],[ul ul],'Color','k','LineStyle','--') % ul
xlabel('Cas (-)')                           % Os X
ylabel('Vstupy u_k (-)')                    % Os Y
legend('u_k^{\ast}','u_{lq}','u_h','u_l')   % Legenda
grid on                                     % Mriezka