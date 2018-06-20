clear; clc;

H=[2  0; 0 18];   g=[-10 -54]';           % H, g
exitflag=1                                % Riadne o.k.
while exitflag~=0                         % Kym nezast.
    Ac=rand(2);                           % Nahodne Ac
    bc=rand(2,1);                         % Nahodne bc
    [u,f,exitflag]=quadprog(H,g,Ac,bc);   % Vypocet QP
end                                       % Koniec cyklu