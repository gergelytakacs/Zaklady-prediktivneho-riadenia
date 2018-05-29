clc; clear all;

Phi=[0 1; 0 0]; Gamma=[0 1]';          % Dynamika                        
Q=eye(2); R=1; x=[1 1]'; Ts=1; np=5;   % Vahy, parametre
[A,B,C,D] = c2dm(Phi,Gamma,[1 1],0,Ts);% Diskretizacia

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);          % Koncove vah.
[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P); % Ucelova f.

% Online cast
for i=1:10                            % Trvanie sim.
 upr=-inv(H)*G*x;                     % Predikcia u
 u=upr(1);                            % Prvy clen
 vykreslitJ(x,upr,H,G,F)              % Priebeh j
 x=A*x+B*u;                           % Aplikacia u
end








