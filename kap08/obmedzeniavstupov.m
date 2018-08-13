function [Ac b0] = obmedzeniavstupov(ul,uh,np) % Funkcia

nu=length(uh);                    % Pocet vstupov
Ac=[eye(np*nu); -eye(np*nu)];     % Matica Ac
One=[];                           % Prazdna matica 1
for i=1:np                        % Cez horizont 
    One=[One; eye(nu)];           % Vyplnenie matice 1
end                               % Koniec cyklu
b0=[One*uh;-One*ul];              % Matica b0