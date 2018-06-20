clc; clear; close all;

H=[2  0; 0 18]; g=[-10 -54]';           % H, g                  
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4]';  % Ac, bc

AC=Ac; BC=bc;                           % Vsetky obmedz.
[no n]=size(AC);                        % Pocet obm.
W=[H  AC'      ;                        % Lava strana
   AC zeros(no)]
V=[-g;                                  % Prava strana
    BC]
z=inv(W)*V                              % Riesenie

pause                                   % Pockat
AC=Ac(2:3,:); BC=bc(2:3);               % Posledne 2 ob.
[no n]=size(AC);                        % Pocet obm.
W=[H  AC'      ;                        % Lava strana
   AC zeros(no)]
V=[-g;                                  % Prava strana
    BC]
z=inv(W)*V                              % Riesenie

pause                                   % Pockat
AC=Ac(3,:); BC=bc(3);                   % Iba posledne.
[no n]=size(AC);                        % Pocet obm.
W=[H  AC'      ;                        % Lava strana
   AC zeros(no)]
V=[-g;                                  % Riesenie
    BC]
z=inv(W)*V
