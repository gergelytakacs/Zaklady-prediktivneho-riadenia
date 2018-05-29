function vykreslitUpred(u,upr)        % Porovnanie u/upr

 persistent U nu np k                 % Trvale premenne
 if isempty(U)                        % Ak este neexist.
  U=[]; k=1;                          % Inicializuj U, k
  nu=length(u);                       % Pocet vstupov
  np=length(upr);                     % Predikcny hor.
 end                                  % Koniec podmienky
 U=[U u];                             % Skladovat x v X

 ax = gca; ax.ColorOrderIndex = 1;    % Restart farieb
for j=1:nu                            % "Skutocne" stavy
 plot(U(j,:),'LineWidth',1,'Marker','o','LineStyle','-')   
end                                   % Koniec for
 ax = gca; ax.ColorOrderIndex = 1;    % Restart farieb
for j=1:nu                            % Predik stavy
 plot(k:k+np-1,upr','LineWidth',0.3,'Marker','x','LineStyle','--')
end                                   % Koniec for
 k=k+1;                               % Dalsi krok                 
 
 hold on                              % Neprekreslit
 grid on                              % Mriezka
 xlabel('Cas (-)')                    % Os x
 ylabel('Vstup u_k (-)')              % Os y
end