clc; clear;

Ac=[0 1; 0 0]; Bc=[0 1]';                % Dynamika                        
Q=eye(2); R=1;                           % Vahy
x0=[1 1]'; Ts=1; np=5;                   % Parametre
[A,B,C,D] = c2dm(Ac,Bc,[1 1],0,Ts);      % Diskretizacia

[K,P]=iterdlqr(A,B,Q,R,100);             % Koncove vah.
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);      % Ucelova f.

upr=-inv(H)*G*x0                         % Predikcia u
