% Linearizovany model kvadrokoptery
% https://www.kth.se/polopoly_fs/1.588039!/Thesis%20KTH%20-%20Francesco%20Sabatino.pdf
% https://cse.sc.edu/~yiannisr/774/2014/Lectures/15-Quadrotors.pdf

g=9.81;                            % [m/s^2]
m=0.5;                             % [kg]
Ix=5E-3;                            % [kgm^2 ]ZotrvaËnosù
Iy=5E-3;                           % [kgm^2 ]ZotrvaËnosù
Iz=9E-3;                           % [kgm^2 ]ZotrvaËnosù
Ts=0.1;                            % [s] Vzorkovanie
Phi=[0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 1 0 0 0 0 0 0 0;
   0 0 0 0 0 1 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0;
   0 -g 0 0 0 0 0 0 0 0 0 0;
   g 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 1 0 0 0 0 0;
   0 0 0 0 0 0 0 1 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0;];

Gamma=[0   0    0    0,
       0   0    0    0,
       0   0    0    0,
       0   1/Ix 0    0,
       0   0    1/Iy 0,
       0   0    0    1/Iz,
       0   0    0    0,
       0   0    0    0,
       1/m 0    0    0,
       0   0    0    0,
       0   0    0    0,
       0   0    0    0];

dronC=ss(Phi,Gamma,eye(12),[]);
dron=c2d(dronC,Ts);
save dron dron
