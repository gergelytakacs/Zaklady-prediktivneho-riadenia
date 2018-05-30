clc; clear all;

load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
Q=C'*C; R=10; np=5;                    % Vahy a horizont                       
xlq=[0.05 0.05 0.05 0.05]'; xmpc=xlq;  % Pociatocny stav    
Ud=[];                                 % Rozdiel v u

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.

% Online cast
for i=1:25                             % Trvanie sim.
 ulq=-K*xlq;                           % LQ zakon
 xlq=A*xlq+B*ulq;                      % Aplikacia u
 % MPC    
 upr=-inv(H)*G*xmpc;                   % Predikcia u
 umpc=upr(1:nu,:);                     % Prvy clen pred.
 xmpc=A*xmpc+B*umpc;                   % Aplikacia u  
 %Zobrazenie
 figure(1)                             % Prvy obrazok
 vykreslitXU(xlq,ulq)                  % Priebeh x,u
 figure(2)                             % Druhy obrazok
 vykreslitXU(xmpc,umpc)                % Priebeh x,u
 figure(3)                             % Treti obrazok
 Ud=[Ud ulq-umpc];                     % Skladuj rozdiel
 plot(Ud,'k')                          % Vykresli rozd.                   
 xlabel('Cas (-)')                     % Os x
 ylabel('Rozdiel v u_k (m)')           % Os y
 grid on; hold on;                     % Mriezka, podrz.
end
