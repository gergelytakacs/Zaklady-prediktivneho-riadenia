clc; clear;

nx=2;             % Rad
np=3;             % Horizont
sys=drss(2);      % Nahodny system
A=sys.A           % Iba matica A

nx=length(A);     % Zistime rozmer A
M=[];             % Prazdna premenna
for i=1:np        % Cyklus
    M = [M; A^i]; % Predikcna matica
end               % Koniec cyklu