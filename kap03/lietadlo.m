clear; clc; clf;

Ts=0.5;                       % [s] Vzorkovanie
u=0.1;                        % [rad] Vstup
x=[0 0 0]';                   % Pociatocny stav
np=5;                         % Horizont
upr=u*ones(np,1);             % Buduca sekvencia vstupov

Ac = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0]; 
Bc = [0.232; 0.0203; 0];      % Matica vstupu
C = [0 0 1];                  % Matica vystupu
b777 = ss(Ac,Bc,C,[]);        % "Skutocna" dynamika

beta=0.0005;                  % Neistota modelu
model=ss(Ac+ones(3)*beta,Bc+ones(3,1)*beta,C,[]);
model=c2d(model,Ts);          % Diskretizacia
A=model.a; B=model.b;         % Matice A a B disk. mod.

step(b777*u)                  % "Skutocna" odozva
hold on; grid on              % Podrz graf, mriezka
step(model*u)                 % Odozva modelu
axis([0 10 0 0.4])            % Nastavenie osi
xlabel('Cas')                 % Os x
ylabel('Uhol (rad)')          % Os y

[M,N]=predikcia(A,B,np);      % Predikcne matice
dlzka=20;                     % Dlzka simulacie
for i=1:dlzka                 % For cyklus
  xpr=M*x+N*upr;              % Predikcia
  stairs((i-1)*Ts,x(3),'kx-') % "Skutocny" stav
  stairs([i:i+np-1]*Ts,xpr(3:3:end,:)','o-','Color', (ones(3,1)*dlzka/(i+1))/dlzka)
  [Y,T,X]=lsim(b777,[u u],[(i-1) i]*Ts,x);      
  x=X(end,:)';                % Dalsi "Skutocny" stav
  pause                       % Cakaj
end



