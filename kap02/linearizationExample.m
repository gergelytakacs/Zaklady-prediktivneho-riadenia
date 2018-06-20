clear; clc
close all

x = linspace(-3,3);
y = x.^2;
y2 = 2.*x-1;

figure('color','w')
plot(x,y,'linewidth',1.5)
grid on
hold on
plot(x,y2,'linewidth',1.5)
plot([1,1],[1,1],'marker','.','markersize',20)
plot([-3 3],[0 0],':k')
plot([0 0],[-2 9],':k')
xlabel('x')
ylabel('y')
legend('nelineárna funkcia','lineárna funkcia','pracovný bod','oblast dobrej aproximácie','location','north')
axis([-3 3 -2 9])


return
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



