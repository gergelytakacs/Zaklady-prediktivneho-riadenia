clc; clear;

A=[1.1 2; 0 0.95]; B=[0; 0.0787];        % Model
Q=eye(2); R=1;                           % Vahovanie
[K,P]=iterdlqr(A,B,Q,R,50)               % Nase riesenie
[Kx,Px]=dlqr(A,B,Q,R)                    % Kontrola
max(max(abs(P-Px)))                      % Max rozdiel P
max(max(abs(K-Kx)))                      % Max rozdiel K



