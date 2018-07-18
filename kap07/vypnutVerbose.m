clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
Q=C'*C; R=10; np=20;                   % Vahy a horizont                       
uh=0.01; ul=-uh;                       % Obmedzenia
x=[0.1 0 0 0]';                        % Odhadnuty stav

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.
[Ac bc]=obmedzenia(ul,uh,np);          % Obmedzenia na u

% Vypnut varovania
H=(H+H')/2;                                  % Symetr.Ak 
o=optimoptions('quadprog','Display','none'); % Vypnut 
uopt=quadprog(H,G*x,Ac,bc,[],[],[],[],[],o)  % MPC v k
