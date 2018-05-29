function vykreslitXpred(x,upr,A,B,np)  % Predikcia

 persistent X M N k nx                % Trvale premenne
 if isempty(X)                        % Ak este neexist.
  X=[]; k=1;                          % Inicializuj X,k
  nx=length(x);                       % Pocet stavov
  [M,N] = predikcia(A,B,np);          % Predikcne matice
 end                                  % Koniec podmienky
 X=[X x];                             % Skladovat x v X
 xpr=M*x+N*upr;                       % Predikcna rovn.

 ax = gca; ax.ColorOrderIndex = 1;    % Restart farieb
for j=1:nx                            % "Skutocne" stavy
 plot(X(j,:),'LineWidth',1,'Marker','o','LineStyle','-')   
end                                   % Koniec for
 ax = gca; ax.ColorOrderIndex = 1;    % Restart farieb
for j=1:nx                            % Predik stavy
 plot(k+1:k+np,xpr(j:nx:end,:)','LineWidth',0.3,'Marker','x','LineStyle','--')
end                                   % Koniec for
 k=k+1;                               % Dalsi krok                 
 
 hold on                              % Neprekreslit
 grid on                              % Mriezka
 xlabel('Cas (-)')                    % Os x
 ylabel('Stavy x_k (-)')              % Os y
end