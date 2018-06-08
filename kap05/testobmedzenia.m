clc; clear all; 

load motor.mat; A=motor.a; B=motor.b;   % Model
np=3;                                   % Horizont
[nx,nu]=size(B);                        % Rozmery
xk=[0.1 0.5 0.5]';                      % Aktualny stav
ul=3; uh=6;                             % Obmedz. vstupu
xl=[-1.57 -10 -1]'; xh=-xl;             % Obmedz. stavov

[Ac b0]     = obmedzenia(ul,uh,np)           % Iba u
[Ac b0 B0]  = obmedzenia(xl,xh,np,A,B)       % Iba x
[Ac b0 B0]  = obmedzenia(ul,uh,xl,xh,np,A,B) % Komb.