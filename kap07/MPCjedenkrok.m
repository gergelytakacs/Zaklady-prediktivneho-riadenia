clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
Q=C'*C; R=10; np=20;                   % Vahy a horizont                       
uh=0.01; ul=-uh;                       % Obmedzenia

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.
[Ac bc]=obmedzenia(ul,uh,np);          % Obmedzenia na u

% MPC pre dany stav
x=[0.1 0 0 0]';                        % Odhadnuty stav
uopt=quadprog(H,G*x,Ac,bc)             % MPC v case k
ulq=-K*x                               % LQ pre stav x

% Graficka ilusrtacia vysledkov
stairs(uopt,'.-')                      % MPC
hold on                                % Podrz graf
stairs(ulq,'o')                        % LQ 
line([0,np],[uh uh],'Color','k','LineStyle','--')
line([0,np],[-uh -uh],'Color','k','LineStyle','--')
xlabel('Cas (-)')                      % Os X
ylabel('Vstupy u_k (-)')               % Os Y
legend('u_k^{\ast}','u_{lq}','u_h','u_l')
grid on                                % Mriezka