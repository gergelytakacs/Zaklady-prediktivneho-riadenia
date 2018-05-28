clc; clear;

a=2; b=-2; c=3;          % Konstanty
syms J(u)                % Symbolicka funkcia
J(u)=a*u.^2+b*u+c;       % Definica funkcie
Jd=diff(J(u))            % Derivacia
uast=solve(Jd,u)         % Vyries pre u
juast=J(uast)            % funkcna hodnota

u=-2:0.1:3;              % Premenna u
plot(u,J(u))             % Vykreslenie funkcie
hold on                  % Nechaj graf
plot(uast,J(uast),'o')   % Vykreslenie minima
grid on                  % Mriezka
xlabel('u (-)')          % Znacenie osi x
ylabel('J(u) (-)')       % Znacenie osi y
legend('J(u)','Minimum') % Legenda