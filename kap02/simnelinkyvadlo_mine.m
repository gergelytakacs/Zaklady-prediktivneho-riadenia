clear; clc
% load simnonlinresfree
load simnonlinresforced

Ts=0.01;
m1=0.4;         % Hmotnost vozika [kg]
m2=0.08;        % Hmotnost kyvadla [kg]
l=0.2;          % Vzdialenost taziska od osi rotacie [m]
g=9.81;         % Tiazove zrychlenie [m/s2]
b=0.1;          % Koeficient trenia [m/s]
cas=0:Ts:10;    % Trvanie a krok simulacie [s]
x0=[0;0;pi/6;0];% Pociatocne podmienky (hodnoty stavov)

% Riesenie systemu diferencialnych rovnic
[t,x]=ode45(@(t,x)nelinkyvadlo(t,x,m1,m2,l,g,b),cas,x0);

% Vykreslenie stavov kyvadla v case a vstupu
figure('color','w')         % Otvorenie grafickeho okna
subplot(10,1,1:2)              % Prvy z podgrafov
plot(t,x(:,1),'-','linewidth',1.5); grid on;    % Posunutie vozika + mriezka
hold on
plot(t,res.signals(1).values,'linewidth',1.5);
set(gca,'xticklabel','')
set(gca,'ylim',[-0.3 0.2])
ylabel('x_1 (m)');          % Oznacenie osi y
subplot(10,1,3:4)
plot(t,x(:,2),'linewidth',1.5); grid on;    % Rychlost vozika
hold on
plot(t,res.signals(2).values,'linewidth',1.5);
set(gca,'xticklabel','')
ylabel('x_2 (ms^{-1})');
subplot(10,1,5:6)
plot(t,x(:,3),'linewidth',1.5); grid on;    % Uhlova vychylka kyvadla
hold on
plot(t,res.signals(3).values,'linewidth',1.5);
set(gca,'xticklabel','')
set(gca,'ylim',[0 2*pi])
set(gca,'ytick',0:pi:2*pi)
set(gca,'yticklabel',{'0','\pi','2\pi'})
ylabel('x_3 (rad)');
subplot(10,1,7:8)
plot(t,x(:,4),'linewidth',1.5); grid on;    % Uhlova rychlost kyvadla
hold on
plot(t,res.signals(4).values,'linewidth',1.5);
set(gca,'xticklabel','')
ylabel('x_4 (rads^{-1})');
subplot(10,1,9:10)              
plot(t,zeros(length(t),1)+0.03,'linewidth',1.5); grid on;% Sila apl. na vozik
hold on
plot(t,res.signals(5).values,'linewidth',1.5);
set(gca,'ylim',[-1.2 0.2])
xlabel('t (s)'); ylabel('u (N)');  % Oznacenie osi x a y
legend('vo?ná odozva (MATLAB, Simulink)','vynútená odozva (Simulink)','location','southeast')

set(gcf,'Position',[200 100 600 600])
tightfig



