clc; clear all;

np=3;                             % [-] Horizont
ul=2;                             % [V] Horne obmedzenie
uh=6;                             % [V] Dolne obmedzenie

Ac=[eye(np); -eye(np)]            % Matica Ac
One=ones(np,1);                   % Matica (vektor) 1
b0=[One*uh;-One*ul]               % Matica b0