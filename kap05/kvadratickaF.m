clc; clear;

h=1; g=0.5; f=rand(1);              % Konstanty, vyraz f
u=-1:0.01:0.5;                      % Premenna u
j=h*u.^2+g*u+f;                     % Funkcia j

plot(u,j)                           % Vykreslenie
xlabel('u (-)')                     % Znacenie osi x
ylabel('J(u) (-)')                  % Znacenie osi y
grid on                             % Mriezka
hold on                             % Podrzat graf

uast=-0.25                          % Minimum je uast
ju=h*uast^2+g*uast+f                % Hodnota j(uast)
plot(uast,ju,'k*')                  % Tu je minimum
line([uast,uast],[0,ju],'Color','k','LineStyle','--')
line([0,uast],[ju,ju],'Color','k','LineStyle','--')
