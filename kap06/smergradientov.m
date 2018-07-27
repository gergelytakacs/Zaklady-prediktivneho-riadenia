clc; clear; close all;

H=[2  0; 0 18]; g=[-10 -54]';              % H, g                  
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4];      % Ac, bc
hranice=[-6 6];                            % Hranice
[uast,f]=quadprog(H,g,Ac,bc)               % Riesenie QP
plot(uast(1),uast(2),'k^')                 % Zobraz u*
hold on                                    % Podrz graf

vykreslitvrstevnice(H,g,hranice,100)       % Vrstevn. f
vykreslitobmedzenia(Ac(3,:),bc(3),hranice) % Obmedzenie
vykreslitgradient(H,g,hranice,f)           % Gradient f
vykreslitgradobm(Ac,bc,3,hranice)          % Gradient g
axis([hranice [-5 6]])                     % Zobrazenie

nf = H*uast+g;                             % nf f(uast)
quiver(uast(1),uast(2), nf(1),nf(2),0);    % Zobraz nf.
ng = Ac(3,:);                              % ng g3(uast)
quiver(uast(1),uast(2), ng(1),ng(2),0);    % Zobraz ng.
legend('u^{\ast}','Vrstevnice f(u)','u^{\circ}','Obmedzenie i=3','Vrstevnica v f(u^{\ast})','\nabla f(u)','\nabla g_3(u)','\nabla f(u^{\ast})','\nabla g_3(u^{\ast})')

