clc; clear;

A=[1 2; 0 0.5]; B=[0; 0.05];         % Model
C=[-1 1];                            % Model
np=5;                                % Horizont             
Q=C'*C;                              % Vahovanie stavu
R=0.1;                               % Vahovanie vstupov
P=Q;                                 % Koncove vahovanie
[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P) % Ucelova funkcia