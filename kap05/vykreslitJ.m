function vykreslitJ(x,upr,H,G)% Funkcia na vykreslenie J

 persistent Jk                        % Trvale premenne
 if isempty(Jk)                       % Ak este neexist.
  Jk=[];                              % Inicializuj
 end                                  % Koniec podm.
 j=upr'*H*upr+2*x'*G'*upr;            % Ucelova funkcia
 Jk=[Jk j];                           % Skladovanie Jk  
  
 wid='MATLAB:legend:IgnoringExtraEntries';
 warning('off',wid)                    % Vypnut varovan.
        
 plot(Jk,'LineWidth',1,'Marker','.')    % Stavy
 xlabel('Cas (-)')                      % Os x
 ylabel('Ucelova f. J_k (-)')           % Os y
 legend('J_k')  % Legenda
 grid on                                % Mriezka
end