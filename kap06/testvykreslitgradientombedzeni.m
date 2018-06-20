clc; clear;

H=[2  0; 0 18]; g=[-10 -54]';          % H, g                  
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4];  % Ac, bc
vykreslitkontury(H,g,[-1 6],5)         % Kontury funkcie
vykreslitobmedzenia(Ac,bc,[-1 6])      % Obmedzenia
vykreslitgradobm(Ac,bc,3,[-1 6])       % Grad. obmedz.
axis([-1 6 -1 5])                      % Zobrazenie
legend('Kontury','Min. bez obm.','Obmedzenie')