function vykreslitkontury(H,g,hranice,level)

u = sym('u', [2 1]);                   % Nezavisla prem.
f(u) = 1/2*u'*H*u+g'*u;                % Kvadrat. funk.
nablaf=gradient(f,u);                  % Gradient f(u)
uast=solve(nablaf==0);                 % Vyries pre u

fcontour(f,hranice,'LevelStep',level); % Kontury f(u)
colorbar                               % Legenda kont.
grid on;                               % Mriezka
hold on;                               % Podrzanie grafu
xlabel('u_1'); ylabel('u_2')           % Oznacenie osi
plot(uast.u1,uast.u2,'ko')             % Bez obmedz.





