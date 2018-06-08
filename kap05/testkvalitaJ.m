clc; clear all;

A=[1 1; 0 1.1]; B=[0 0.01]'; C=[-1 1]; % Dynamika                        
Q=C'*C; R=0.01; x=[0.5 -0.5]';         % Vahy, x0
np=2;                                  % Horizont
                                    
% Offline cast
P=Q;                                   % Koncove vah.
[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P);  % Ucelova f.

% Online cast
for i=1:30                             % Trvanie sim.
 upr=-inv(H)*G*x;                      % Predikcia u
 u=upr(1);                             % Prvy clen
 q=kvalitaJ(x,upr,H,G,F);              % Ratanie indik.
 x=A*x+B*u;                            % Model 
end
 q











