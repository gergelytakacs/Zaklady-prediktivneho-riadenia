function vykreslitgradobm(Ac,bc,i,hranice)

N=10;                                 % Rozlisenie
U1=linspace(hranice(1),hranice(2),N); % Body
if Ac(i,2)==0                         % Zvisla priamka?
   U2=U1; U1=zeros(1,N);              % Zvisla priamka
   quiver(U1, U2, ones(1,N)*Ac(i,1), ones(1,N)*Ac(i,2));
else                                  % Nie je zvisla
   U2=bc(i)-Ac(i,1).*U1./Ac(i,2);     % Priamka
   quiver(U1, U2, ones(1,N)*Ac(i,1), ones(1,N)*Ac(i,2));
end




