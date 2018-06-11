function vykreslitgradient(H,g,hranice,fu)

u = sym('u', [2 1]);                       % Premenna u
f(u) = 1/2*u'*H*u+g'*u;                    % Kvadrat. f.
F=f==fu;                                   % Elipsa
fc=fimplicit(F,hranice,'k','LineWidth',1); % Isociara
hold on                                    % Podrz graf

h = findobj(gca,'Type','ImplicitFunctionLine');
U1=get(h,'Xdata');                         % Uloz x                
U2=get(h,'Ydata');                         % Uloz y
U1=downsample(U1,10);                      % Menej vz.
U2=downsample(U2,10);                      % Menej vz.

nf1=gradient(f, u(1));                     % Grad. u1
nf2=gradient(f, u(2));                     % Grad. u2
NF1 = subs(nf1, [u(1), u(2)], {U1,U2});    % Dosadenie
NF2 = subs(nf2, [u(1), u(2)], {U1,U2});    % Dosadenie
quiver(U1, U2, NF1, NF2);                  % Zobrazenie g.



