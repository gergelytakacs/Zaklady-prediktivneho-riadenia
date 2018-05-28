function vykreslitXU(x,u)  % Funkcia na vykreslenie x,x

 persistent X U                       % Trvale premenne
 if isempty(X)                        % Ak este neexist.
  X=[]; U=[];                         % Inicializuj
 end                                  % Koniec podm.
 X=[X x];                             % Skladovat x v X
 U=[U u];                             % Skladovat u v U
  
 wid='MATLAB:legend:IgnoringExtraEntries';
 warning('off',wid)                    % Vypnut varovan.
 
 subplot(2,1,1)                         % Cast obrazku
 plot(X','LineWidth',1,'Marker','.')    % Stavy
 xlabel('Cas (-)')                      % Os x
 ylabel('Stavy x_k (-)')                % Os y
 legend('x_1','x_2','x_3','x_4','x_5')  % Legenda
 grid on                                % Mriezka

 subplot(2,1,2)                         % Cast obrazku
 plot(U','LineWidth',1,'Marker','.')    % Vstupy
 xlabel('Cas (-)')                      % Os x
 ylabel('Vstupy u_k (-)')               % Os y
 legend('u_1','u_2','u_3','u_4','u_5')  % Legenda
 grid on                                % Mriezka
end