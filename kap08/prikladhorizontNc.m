clear; clc
A=[1.1 2;0 0.95]; B=[0;0.0787]; C=[-1 1];% Stavovy model
uh=1; ul=-uh;                        % Obmedzenia vstupu
Q=C'*C; R=1; np=2;                   % Vahy a horizont
[K,P]=iterdlqr(A,B,Q,R,100);      % Vahov. koncov. stavu
K=-K;                             % Zaporna spatna vazba
Psi=A+B*K;                 % Dynamika uzavr. reg. obvodu
[nc,KPsi]=horizontkoncobmedzeni(K,Psi,uh,ul);% Vypoc. nc
disp(['nc = ',num2str(nc)])                  % Zobraz nc