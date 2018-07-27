clc; clear; close all;

% Vykreslenie prikladu
H=[2  0; 0 18]; g=[-10 -54]';            % Povodny prob.
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4]';   % Obmedzenia
hr=[-0.5, 4.5];                          % Hranice graf. 
vykreslitvrstevnice(H,g,hr,5)            % Vrstev. funk.
vykreslitobmedzenia(Ac,bc,hr)            % Obmedzenia
legend('Vrst.','u^{\circ}','g_i(u)','AutoUpdate','off')
axis([hr hr])                            % Zobrazenie
uQP=quadprog(H,g,Ac,bc)                  % Kontrola
plot(uQP(1),uQP(2),'k^')                 % Nakreslit uQP
 
up=[4/3 4/3]';                           % Pociatocne up
plot(up(1),up(2),'k+')                   % Nakreslit up
mu=logspace(-4,2,20);                    % Logaritmicke

for i=1:length(mu)
    f = @(up)objfun(up,mu(i),H,g,Ac,bc); % Obj. funkc.
    [up fup]=fminsearch(f,up);           % Minimaliz.
    plot(up(1),up(2),'k+')               % Nakreslit up
end



