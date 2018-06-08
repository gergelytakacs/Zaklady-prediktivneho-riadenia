clc; clear;

load dron; A=dron.a; B=dron.b; np=3         % Model
xh=[20 10 5 1.5 1.5 1.5 15 15 15 1 1 1]';   % Obmedzenia
xl=[0 0 0 -1.5 -1.5 -1.5 -15 -15 -15 -1 -1 -1]'; 
[Ac b0 B0] = obmedzeniastavov(xl,xh,np,A,B) % Funkcia