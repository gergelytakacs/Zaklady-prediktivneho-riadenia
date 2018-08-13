function vykreslitobmedzenia(Ac,bc,hranice)

u = sym('u', [2 1]);               % Nezavisla premenna
hold on; grid on;                  % Podrzanie grafu
for i=1:length(bc)                 % Pre vsetky obmedz.
    if Ac(i,2)==0                  % Je to zvisla ciara?
        l=line([bc(i)/Ac(i,1) bc(i)/Ac(i,1)],hranice);
        l.Color='k'; l.LineStyle='--'; l.LineWidth=1;
    else                           % inak nakresli ciaru
        u2=(bc(i)-Ac(i,1)*u(1))/Ac(i,2); 
        fplot(u2,hranice,'LineWidth',1.5,'Color','k');
    end
end






