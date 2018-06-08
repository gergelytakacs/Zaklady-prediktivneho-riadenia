% Na zaklade http://ctms.engin.umich.edu/CTMS/index.php?example=MotorPosition&section=ControlStateSpace

J = 3.2284E-6;
b = 3.5077E-6;
K = 0.0274;
R = 4;
L = 2.75E-6;

Phi =  [0 1 0
        0 -b/J K/J
        0 -K/L -R/L];
Gamma = [0 ; 0 ; 1/L];
C = [1  0  0];
D = 0;
Ts=0.01;                     % s Vzorkovanie
motorC = ss(Phi,Gamma,C,D); % Stavovy model
motor = c2d(motorC,Ts);     % Diskretizacia
save motor motor