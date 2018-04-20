clc; clear;

a=1; b=0; c=10;    % Konstanty
u=-10:10;          % Premenna u
J=a*u.^2+b*u+c;    % Funkcia J
plot(u,J)          % Vykreslenie
grid on            % Mriezka
xlabel('u (-)')    % Znacenie osi x
ylabel('J(u) (-)') % Znacenie osi y