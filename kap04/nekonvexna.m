clc; clear;

[X,Y,Z] = peaks(25); % Nekonvexna funkcia
surf(X,Y,Z);         % Vykreslenie
xlabel('u_1 (-)')    % Znacenie osi x
ylabel('u_2 (-)')    % Znacenie osi y
zlabel('J(u) (-)')   % Znacenie osi z