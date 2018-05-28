function vykreslitXpred(x,upr,A,B,np)  % Predikcia

 persistent X M N k nx                % Trvale premenne
 if isempty(X)                        % Ak este neexist.
  X=[]; k=1;                          % Inicializuj
  nx=length(x);                       % Pocet stavov
  [M,N] = predikcia(A,B,np);          % Predikcne matice
 end                                  % Koniec podm.
 X=[X x];                             % Skladovat X
 xpr=M*x+N*upr;                       % Predikcna rov.
 
 wid='MATLAB:legend:IgnoringExtraEntries';
 warning('off',wid)                    % Vypnut varovan.


 ax = gca; ax.ColorOrderIndex = 1;
for j=1:nx % "Skutocne" stavy
 plot(X(j,:),'LineWidth',1,'Marker','o','LineStyle','-')   
end
 ax = gca; ax.ColorOrderIndex = 1;
for j=1:nx % Predikovane stavy
 plot(k+1:k+np,xpr(j:nx:end,:)','LineWidth',0.3,'Marker','x','LineStyle','--')
end 
 k=k+1;
 
 hold on                                     % Neprekreslit
 grid on                                     % Mriezka
 xlabel('Cas (-)')                           % Os x
 ylabel('Stavy x_k (-)')                     % Os y
 if nx==2                                    % Iba pre nx=2
 legend('x_1','x_2','Pred. x_1','Pred. x_2') % Legenda
 end
end