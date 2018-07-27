clc; clear;

H=[2  0; 0 18]; g=[-10 -54]';         % H, g                  
Ac=[-1  0;  0 -1;  1  1];             % Matica Ac 
bc=[0 0 4];                           % Vektor bc
vykreslitvrstevnice(H,g,[-1 6],5)     % Vrstevn. funkcie
vykreslitobmedzenia(Ac(3,:),bc(3),[-1 6]) % Obmedzenia
axis([-1 6 -1 5])                     % Zobrazenie
[u,f]=quadprog(H,g,Ac,bc)             % Riesenie QP
plot(u(1),u(2),'k^')                  % Zobrazenie u*

Ac=Ac(3,:); bc=bc(3);                 % Ac, bc (iba i=3)
[u,f]=quadprog(H,g,Ac,bc)             % Riesenie QP
plot(u(1),u(2),'k.')                  % Zobrazenie u*

Ae=Ac; be=bc;                         % Rovnosti
[u,f]=quadprog(H,g,[],[],Ae,be)       % Riesenie QP 
plot(u(1),u(2),'kx')                  % Zobrazenie u*
legend('Vrstevnice','Min. bez obm.','Obmedzenie','Povodne QP','QP nerovnost=3','QP rovnost i=3')

