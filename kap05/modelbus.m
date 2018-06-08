% Na zaklade http://ctms.engin.umich.edu/CTMS/index.php?example=Suspension&section=SystemModeling
m1 = 2500;   % [kg]   1/4 hmotnost autobusu
m2 = 320;    % [kg]   Hmotnost zavesenia
k1 = 80000;  % [N/m]  Pruzinova konstanta zavesenia
k2 = 500000; % [N/m]  Pruzinova konstanta kolesa a pneu.
b1 = 350;    % [Ns/m] Pruzinova konstanta zavesenia
b2 = 15020;  % [Ns/m] Pruzinova konstanta kolesa a pneu.

Phi=[0                 1   0                                              0
  -(b1*b2)/(m1*m2)   0   ((b1/m1)*((b1/m1)+(b1/m2)+(b2/m2)))-(k1/m1)   -(b1/m1)
   b2/m2             0  -((b1/m1)+(b1/m2)+(b2/m2))                      1
   k2/m2             0  -((k1/m1)+(k1/m2)+(k2/m2))                      0];
Gamma=[0                 0
   1/m1              (b1*b2)/(m1*m2)
   0                -(b2/m2)
   (1/m1)+(1/m2)    -(k2/m2)];
C=[0 0 1 0];
D=[0 0];
busC=ss(Phi,Gamma,C,D); % Tvorba modelu
bus=c2d(busC,0.1);      % Diskretizacia
save bus bus            % Ulozenie modelu
