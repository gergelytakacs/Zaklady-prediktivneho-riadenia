clc; clear;

load dron; A=dron.a; B=dron.b;            % Model
[nx nu]=size(B);                          % Rozmery
np=3;                                     % Horizont
xh=[20 10 5 1.5 1.5 1.5 15 15 15 1 1 1]'; % Obmedzenia
xl=[0 0 0 -1.5 -1.5 -1.5 -15 -15 -15 -1 -1 -1]'; 

[M,N]=predikcia(A,B,np);                  % Predikcne m.
Ac=[ N; -N]                               % Matica Ac
B0=[-M;  M]                               % Matica B0

One=[];                                   % Prazdna 1
for i=1:np                                % Cez horizont 
    One=[One; eye(nx)];                   % Vyplnenie 1
end                                       % Koniec cyklu
b0=[One*xh;-One*xl];                      % Matica b0



