clc; clear all;

load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
Q=C'*C; R=10; np=5;                    % Vahy a horizont                       
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.

Kcal=-inv(H)*G                         % K kaligraficke
K=-K;                                  % Spatna vazba
Ki=[];                                 % Prazdna matica
for i=1:np                             % Horizont
 Ki=[Ki; K*(A+B*K)^(i-1)]              % LQ ekvivalencia                             
end



