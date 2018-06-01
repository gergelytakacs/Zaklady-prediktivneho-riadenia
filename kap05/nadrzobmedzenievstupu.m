clc; clear all;

np=4;                               % [-] Horizont
ul=[0.2 60]';                       % [m,C] Horne obm.
uh=[0.4 90]';                       % [m,C] Dolne obm.
nu=length(uh);                      % Pocet vstupov

Ac=[eye(np*nu); -eye(np*nu)]        % Matica Ac
One=[];                             % Prazdna matica 1
for i=1:np                          % Cez horizont 
    One=[One; eye(nu)];             % Vyplnenie matice 1
end                                 % Koniec cyklu
b0=[One*uh;-One*ul]                 % Matica B0