clear; clc; %close all
load linearnySM           % Nacitanie matic stav. modelu
sys=ss(Ac,Bc,Cc,Dc);      % Vytvor. objektu stav. modelu

Ts=0.01;                    % Vzorkovacia perioda [s]
sysd=c2d(sys,Ts,'zoh');     % Diskretizacia stav. modelu
[A,B,C,D]=ssdata(sysd);% Vycit. matic disk. stav. modelu

T=10;                         % Konecny cas simulacie
cas=0:Ts:T;                   % Trvanie a krok simulacie
N=T/Ts;                       % Pocet krokov simulacie
dx0=[0;0;0;0];                % Pociatocny stav systemu

[nx,nu]=size(B);                % Pocet stavov a vstupov
ny=size(C,1);                   % Pocet vystupov
dx=zeros(nx,N);% Prealok. matice pre ukladanie stavov
du=zeros(nu,N);% Prealokacia vektoru vstupov
dy=zeros(ny,N);% Prealok. matice pre ukladanie vystupov
dx(:,1)=dx0;   % Zapis pociatocneho stavu do matice dx
du(:,1)=50;    % Definov. impulzu na zaciatku simulacie

for k=1:N
    dx(:,k+1)=A*dx(:,k)+B*du(:,k);
      dy(:,k)=C*dx(:,k)+D*du(:,k);
end

u=du; x=dx;           % Transf. suradnic z du/dx na u/x
x(3,:)=x(3,:)+pi;     % ...
y=C*x;                % Transf. y pomocou matice vystupu
save sysd             % Uloz. diskretneho stav. modelu 

% Vykreslenie stavov kyvadla v case a vstupu
figure('color','w')         % Otvorenie grafickeho okna
subplot(4,1,1)              % Prvy z podgrafov
hold on
plot(cas,x(1,:)); grid on;    % Posunutie vozika + mriezka
ylabel('x_1 (m)');          % Oznacenie osi y
% ylim([0 0.04])
subplot(4,1,2)
hold on
plot(cas,x(2,:)); grid on;    % Rychlost vozika
% ylim([-0.2 0.2])
ylabel('x_2 (ms^{-1})');
subplot(4,1,3)
hold on
plot(cas,x(3,:)); grid on;    % Uhlova vychylka kyvadla
ylabel('x_3 (rad)');
% ylim([-1 1])
subplot(4,1,4)
hold on
plot(cas,x(4,:)); grid on;    % Uhlova rychlost kyvadla
ylabel('x_4 (rads^{-1})');
% ylim([-4 4])
xlabel('t (s)'); ylabel('u (N)');  % Oznacenie osi x a y

return
A=expm(Ac*Ts);
B=Ac\(A-eye(length(A)))*Bc;