clc; clear;

H=[2  0; 0 18];                               % Matica H
g=[-10 -54]';                                 % Vektor g
vykreslitkontury(H,g,[-30 30],500)            % Kontury
legend('Kontúry f(u)','Minimum bez obm.')     % Legenda



