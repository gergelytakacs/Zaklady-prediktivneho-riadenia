clc; clear;

H=[2  0; 0 18];                             % Matica H
g=[-10 -54]';                               % Vektor g
vykreslitvrstevnice(H,g,[-30 30],500)       % Vrstevnice
legend('Vrstevnice f(u)','Minimum bez obm.')% Legenda



