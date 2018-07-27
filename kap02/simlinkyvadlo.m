clear; clc; close all
load linearnySM           % Nacitanie matic stav. modelu
sys=ss(Ac,Bc,Cc,Dc);      % Vytvor. objektu stav. modelu

cas=0:0.01:10;                % Trvanie a krok simulacie
dx0=[0;0;-pi/6;0];            % Pociatocny stav systemu
u=0;

[dy,t,dx]=initial(sys,dx0,cas);% Simulacia volnej odozvy
x=dx;                        % Transf. suradnic na x a y
x(:,3)=dx(:,3)+pi;           % ...manualne
y=(Cc*x')';                  % ...pomocou matice vystupu

% Vykreslenie stavov kyvadla v case a vstupu
figure('color','w')         % Otvorenie grafickeho okna
subplot(4,1,1)              % Prvy z podgrafov
plot(t,x(:,1)); grid on;    % Posunutie vozika + mriezka
ylabel('x_1 (m)');          % Oznacenie osi y
subplot(4,1,2)
plot(t,x(:,2)); grid on;    % Rychlost vozika
ylabel('x_2 (ms^{-1})');
subplot(4,1,3)
plot(t,x(:,3)); grid on;    % Uhlova vychylka kyvadla
ylabel('x_3 (rad)');
subplot(4,1,4)
plot(t,x(:,4)); grid on;    % Uhlova rychlost kyvadla
ylabel('x_4 (rads^{-1})');
xlabel('t (s)'); ylabel('u (N)');  % Oznacenie osi x a y

return
subplot(5,1,5)           
plot(t,zeros(length(t),1)); grid on;% Sila apl. na vozik

[y,t,x]=impulse(sys,cas);
[y,t,x]=lsim(sys,u,cas,x0); 

