clc; clear;
% Obmedzenia
Ac=[-1  0;                          % Matica Ac
     0 -1;
     1  1];
bc=[0 0 4];                         % Vektor bc
u = sym('u', [2 1]);                % Nezavisla premenna

xmin=-1; xmax=5                     % Zobrazenie
hold on; grid on;                   % Podrzanie grafu
xlabel('u_1'); ylabel('u_2')        % Oznacenie osi

H=[2  0;                            % Matica H
   0 18]
g=[-10 54]';                        % Vektor g
f(u) = 1/2*u'*H*u+g'*u;             % Kvadrat. funkcia
fcontour(f,[xmin xmax]);            % Kontury
colorbar

for i=1:length(bc)
if Ac(i,2)==0
    l=line([0 0],[xmin xmax])
    l.Color='k'; l.LineStyle='--'
else
    u2=bc(i)-Ac(i,1)*u(1)/Ac(i,2);
    fplot(u2,'k--',[xmin xmax]);
end
end




