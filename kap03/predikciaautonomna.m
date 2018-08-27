clc; clear;

nx=2; np=3;       % Rad sys. a horizont
sys=drss(2);      % Nahodny system
A=sys.A           % Matica dynamiky

nx=length(A);     % Zistime rozmer A
M=[];             % Prazdna premenna
for i=1:np        % Cyklus
    M = [M; A^i]; % Predikcna matica
end               % Koniec cyklu