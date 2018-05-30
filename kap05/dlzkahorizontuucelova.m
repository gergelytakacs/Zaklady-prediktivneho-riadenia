clf; clc; clear all

A=[1 1; 0 1.1]; B=[0 0.01]'; C=[-1 1]; % Dynamika                        
Q=C'*C; R=0.01; x=[0.5 -0.5]';         % Vahy, x0
np=2;                                 % Horizont
                                    
% Offline cast
P=Q;                                   % Koncove vah.
[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P);  % Ucelova f.

% Inspekcia zosilnenia a stability
K=dlqr(A,B,Q,R)                        % Riesenie LQ
Kcal=inv(H)*G;                         % K kaligraficke
K=Kcal(1,:)                            % Prvy blok
Psi=A-B*K; eig(Psi)                    % Stabilita

% Online cast
for i=1:30                             % Trvanie sim.
 upr=-inv(H)*G*x;                      % Predikcia u
 u=upr(1);                             % Prvy clen
 vykreslitJ(x,upr,H,G,F)               % Kreslenie J
 x=A*x+B*u;                            % Model 
end









