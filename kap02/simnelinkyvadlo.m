clear; clc

m1=0.4;         % Hmotnost vozika [kg]
m2=0.08;        % Hmotnost kyvadla [kg]
l=0.2;          % Vzdialenost taziska od osi rotacie [m]
g=9.81;         % Tiazove zrychlenie [m/s2]
b=0.1;          % Koeficient trenia [m/s]
cas=0:0.01:10;  % Trvanie a krok simulacie [s]
x0=[0;0;pi/6;0];% Pociatocne podmienky (hodnoty stavov)

% Riesenie systemu diferencialnych rovnic
[t,x]=ode45(@(t,x)nelinkyvadlo(t,x,m1,m2,l,g,b),cas,x0);

% Vykreslenie stavov kyvadla v case a vstupu
figure('color','w')         % Otvorenie grafickeho okna
subplot(5,1,1)              % Prvy z podgrafov
plot(t,x(:,1)); grid on;    % Posunutie vozika + mriezka
ylabel('x_1 (m)');          % Oznacenie osi y
subplot(5,1,2)
plot(t,x(:,2)); grid on;    % Rychlost vozika
ylabel('x_2 (ms^{-1})');
subplot(5,1,3)
plot(t,x(:,3)); grid on;    % Uhlova vychylka kyvadla
ylabel('x_3 (rad)');
subplot(5,1,4)
plot(t,x(:,4)); grid on;    % Uhlova rychlost kyvadla
ylabel('x_4 (rads^{-1})');
subplot(5,1,5)              
plot(t,zeros(length(t),1)); grid on;% Sila apl. na vozik
xlabel('t (s)'); ylabel('u (N)');  % Oznacenie osi x a y