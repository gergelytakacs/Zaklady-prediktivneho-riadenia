function q = kvalitaJ(x,upr,H,G,F)    % Ratanie kvality
 persistent j                         % Trvale premenne
 if isempty(j)                        % Ak este neexist.
  j=0;                                % Inicializuj
 end                                  % Koniec podm.
 j=j+upr'*H*upr+2*x'*G'*upr+x'*F*x;   % Ucelova funkcia     
 q=j;                                 % Vratit vysledok
end                                   % Koniec funkcie