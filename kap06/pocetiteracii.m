clear; clc;

H=[2  0; 0 18];   g=[-10 -54]';         % H, g
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4]';  % Ac, bc
[u,f,e,v]=quadprog(H,g,Ac,bc);          % Vypocet QP
v                                       % Iteracie

Ac = [0.0094 0.1798;                    % Ine Ac
      0.1868 0.5021]
bc = [0.1922 0.7321]'                   % Ine bc
[u,f,e,v]=quadprog(H,g,Ac,bc);          % Vypocet QP
v                                       % Iteracie


