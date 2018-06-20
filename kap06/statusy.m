clc; clear;

H=[2  0; 0 18];  g=[-10 -54]';          % H, g
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4]';  % Ac, bc
[u,f,e]=quadprog(H,g,Ac,bc)             % Riesenie QP

pause; clc;                             % Stlac klaves
nastavenia = optimoptions('quadprog','MaxIter',2);
[u,f,e]=quadprog(H,g,Ac,bc,[],[],[],[],[],nastavenia)

pause; clc;                             % Stlac klaves
Acx=[Ac; -1 0]; bcx=[bc; -5];           % Nezlucitelne
[u,f,e]=quadprog(H,g,Acx,bcx)           % Status -2

pause; clc;                             % Stlac klaves
Hx=-H;                                  % Zap. definitne
[u,f,e]=quadprog(Hx,g,Ac,bc)            % Varovanie

pause; clc;
Hx=[2  1; 0 18];                        % Nesymetricke H
[u,f,e]=quadprog(Hx,g,Ac,bc)            % Varovanie
Hx=(Hx+Hx')/2                           % Nove H




