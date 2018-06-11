clc; clear;

H=[2  0; 0 18];                     % Matica H
g=[-10 -54]';                       % Vektor g
u = sym('u', [2 1]);                % Nezavisla premenna
f(u) = 1/2*u'*H*u+g'*u;             % Kvadrat. funkcia

nablaf=gradient(f,u);               % Gradient
uast=solve(nablaf==0);              % Vyries pre u

hranice=[-20 20];                   % Zobrazenie
fsurf(f,hranice)                    % Kvadraticka 3D
grid on;  hold on;                  % Mriezka, podrzanie
xlabel('u_1'); ylabel('u_2')        % Oznacenie osi
zlabel('f(u)');                     % Oznacenie osi
colorbar                            % Znacenie
plot(uast.u1,uast.u2,'wo')          % Opt. bez obmedz.           
fcontour(f,hranice);                % Kontury
