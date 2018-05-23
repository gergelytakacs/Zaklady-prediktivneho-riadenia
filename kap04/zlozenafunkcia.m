clc; clear;

A=[1 2; 0 0.5]; B=[0; 0.05];         % Model
C=[-1 1];                            % Model
np=5; Q=C'*C; R=0.1;                 % Horizont a vahy             

K=-dlqr(A,B,Q,R);                    % LQ zosilnenie
P = dlyap([A+B*K]',[Q+K'*R*K]);      % Koncove vahovanie

[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P) % Ucelova funkcia