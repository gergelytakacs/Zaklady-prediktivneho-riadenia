clc; clear all; 

load motor.mat; A=motor.a; B=motor.b;   % Model
np=3;                                   % Horizont
[nx,nu]=size(B);                        % Rozmery
xk=[0.1 0.5 0.5]';                      % Aktualny stav
ul=3; uh=6;                             % Obmedz. vstupu
xl=[-1.57 -10 -1]'; xh=-xl;             % Obmedz. stavov

[Acu b0u]     = obmedzeniavstupov(ul,uh,np)    % Obm. u
[Acx b0x B0x] = obmedzeniastavov(xl,xh,np,A,B) % Obm. x

Ac=[Acu;Acx]                            % Kombin. Ac
b0=[b0u; b0x]                           % Kombin. b0
B0=[zeros(2*np*nu,nx); B0x]             % Kombin. B0

bc=b0+B0*xk                             % Vzdy podla xk