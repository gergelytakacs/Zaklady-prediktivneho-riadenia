clc; clear;

H=[2  0; 0 18];                        % Matica H
g=[-10 -54]';                          % Vektor g
Ac=[-1  0;  0 -1;  1  1];              % Matica Ac 
bc=[0 0 4];                            % Vektor bc

vykreslitvrstevnice(H,g,[-1 6],5)         % Vrstev. funkcie
vykreslitobmedzenia(Ac,bc,[-1 6])      % Obmedzenia
axis([-1 6 -1 5])

[u,f]=quadprog(H,g,Ac,bc)              % Riesenie QP
plot(u(1),u(2),'k^')                   % Zobrazenie u*
