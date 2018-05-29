clf; clc; clear all

Phi=[0 1; 0 0]; Gamma=[0 1]';          % Dynamika                        
Q=eye(2); R=1; x=[1 1]'; Ts=1; np=5;   % Vahy, parametre
[A,B,C,D] = c2dm(Phi,Gamma,[1 1],0,Ts);% Diskretizacia

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.

% Online cast
delta=1.2 *eye(2);                     % Nepresnost mod
for i=1:10                             % Trvanie sim.
 upr=-inv(H)*G*x;                      % Predikcia u
 u=upr(1);                             % Prvy clen
 vykreslitXpred(x,upr,A,B,np);         % Priebeh Xpred
 pause                                 % Pauza
 x=A*delta*x+B*u;                      % Model 
end









