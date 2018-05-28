clc; clear;

H=[2,-1;                       % Konstanty
   1, 2];   
G=[1  2];                      % Konstanty
u = sym('u', [2 1]);           % Symbolicky vektor
J(u)=u.'*H*u+G*u;              % Definica funkcie
J=simplify(J)                  % Zjednodusenie
nablaJ=gradient(J,u)           % Gradient
[u1ast u2ast]=solve(nablaJ==0) % Vyries pre u

[u1,u2] = meshgrid(-2:0.25:1,-2:0.25:1);
surf(u1,u2,double(J(u1,u2)));   % Vykreslenie
hold on                         % Podrzanie grafu
plot3(u1ast,u2ast,J(u1ast,u2ast),'o','MarkerSize',10) 
xlabel('u_1 (-)')               % Znacenie osi x
ylabel('u_2 (-)')               % Znacenie osi y
zlabel('J(u) (-)')              % Znacenie osi z
