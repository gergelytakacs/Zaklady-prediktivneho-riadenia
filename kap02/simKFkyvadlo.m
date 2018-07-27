clear; clc; close all
clear kalmanfilter     % Odstranenie funkcie z pamate
load param
load sysd              % Nacitanie diskr. stav. modelu
[A,B,C,~]=ssdata(sysd);% Vycit. matic disk. stav. modelu
nx=length(A);                   % Pocet stavov
ny=size(C,1);                   % Pocet vystupov

x0=[0;0;7*pi/8;0];     % Pociatocny stav systemu
xlin=[0;0;pi;0];       % Pracovny (linearizacny) bod
dx0=x0-xlin;           % Transf. stavu do odchylk. tvaru

w_var=[0 0 0 1e-4]';   % Rozptyl procesneho sumu
v_var=[5e-3 5e-3]';    % Rozptyl sumu merania
Q=diag(w_var);         % Kovariancna matica proces. sumu
R=diag(v_var);         % Kovariancna matica sumu merania

T=10;                         % Konecny cas simulacie
cas=0:Ts:T-Ts;                % Trvanie a krok simulacie
N=T/Ts;                       % Pocet krokov simulacie
dx=zeros(nx,N);% Prealok. matice pre ukladanie stavov
dx(:,1)=dx0;   % Zapis pociatocneho stavu do matice dx
dy=zeros(ny,N);% Prealok. matice pre ukladanie vystupov
dxhat=zeros(nx,N);          % - / / - odhadnutych stavov

w=sqrt(w_var).*randn(nx,N);% Nahodny vektor proces. sumu
v=sqrt(v_var).*randn(ny,N);% Nahodny vektor sumu merania

dx0=zeros(nx,1);    % Pociatocny apriorny odhad stavu 
P0=eye(nx);         % Poc. odhad apriornej kov. matice P

for k=1:N
    dx(:,k+1)=A*dx(:,k)+w(:,k);
      dy(:,k)=C*dx(:,k)+v(:,k);
   dxhat(:,k)=kalmanfilter(dy(:,k),0,dx0,P0,sysd,Q,R); 
end

x=dx+xlin;              % Transf. stavov z dx na x
y=dy+xlin([1 3]);       % Transf. vystupov z dy na y
xhat=dxhat+xlin;        % Transf. odhadu z dxhat na xhat

% Vykreslenie stavov kyvadla v case a vstupu
figure('color','w')      % Otvorenie grafickeho okna
subplot(4,1,1)           % Prvy z podgrafov
plot(cas,y(1,:));        % Vykresli meranie y1
hold on; grid on         % Podrz graf a zobraz mriezku
plot(cas,x(1,1:end-1));  % Vykresli skutocny stav x1
plot(cas,xhat(1,:));     % Vykresli odhadnuty stav xhat1
ylabel('y_1, x_1 (m)');  % Oznacenie osi y
legend('stav-odhadnuty','stav-skutocny','meranie')% leg.
subplot(4,1,2)           % Druhy z podgrafov
plot(cas,x(2,1:end-1));  % Vykresli skutocny stav x2
hold on; grid on
plot(cas,xhat(2,:));     % Vykresli odhadnuty stav xhat2
ylabel('x_2 (ms^{-1})');
legend('stav-odhadnuty','stav-skutocny')
...
xlabel('t (s)');         % Oznacenie osi x
subplot(4,1,3)
plot(cas,xhat(3,:),'linewidth',1.5);
hold on
plot(cas,x(3,1:end-1),'-','linewidth',1.5);
plot(cas,y(2,:),'-','linewidth',0.75);
grid on
ylabel('y_2, x_3 (rad)');
subplot(4,1,4)
plot(cas,xhat(4,:),'linewidth',1.5);
hold on
plot(cas,x(4,1:end-1),'-','linewidth',1.5);
grid on;
xlabel('t (s)');
ylabel('x_4 (rads^{-1})');

% dxhat(:,1)=zeros(nx,1);     % Pociatocny odhad stavu
% y=dy;
% y(2,:)=y(2,:)+pi; 


