clear; close all; clc
A=[1.1 2;0 0.95]; B=[0;0.0787]; C=[-1 1];% Stavovy model
uh=1; ul=-uh;                        % Obmedzenia vstupu
Q=C'*C; R=1; np=2;                   % Vahy a horizont
[K,P]=iterdlqr(A,B,Q,R,100);      % Vahov. koncov. stavu
K=-K;                             % Zaporna spatna vazba
Psi=A+B*K;                 % Dynamika uzavr. reg. obvodu
figure('color','w')                     % Graficke okno
n=9;                                   % Pocet iteracii
for i=0:n
    Ac=[ K*Psi^i;        % Lava strana obmedzeni vstupu
        -K*Psi^i];
    bc=[ uh;             % Prava strana obmedzeni vstupu
        -ul];
    vykreslitobmedzenia(Ac,bc,[-5 5])% Vykresl. nadrovin
end
axis([-5 5 -0.8 0.8])                    % Hranice grafu
xlabel('x_1'); ylabel('x_2');            % Oznacenie osi