clc; clear;

A=[0 1; -0.5 1]; % Matica dynamiky
B=[0 1]';        % Matica vstupu
x0=[1; 0];       % Pociatocny stav
np=10;           % Horizont
u=ones(np,1);    % Jednotokovy skok

M=predikciaM(A,np);   % Matica M
N=predikciaN(A,B,np); % Matica N
xpr=M*x0+N*u;         % Predikcna rov.

sys=ss(A,B,[],[],1);          % Stavovy objekt
t=1:1:np;                     % Casovy vektor
[y,t,Xsim]=lsim(sys,u',t,x0); % Linearna simulacia

Xpr=[[NaN;xpr(1:2:end,:)],[NaN;xpr(2:2:end,:)]];
  
figure(1)               % Nový obrazok 
plot(Xsim,'Color',[0.8 0.8 0.8],'LineWidth',3)
hold on                 % Neprekreslit graf
ax = gca;               % Objekt oznacujuci os obrazku
ax.ColorOrderIndex = 1; % Farebny index od zaciatku
plot(Xpr,'--')          % Nakreslit predikciu
xlabel('Cas (-)')       % Os x
ylabel('Stavy (-)')     % Os y, legenda
legend('x_1 (Simulacia)', 'x_2 (Simulacia)', 'x_1 (Predikcia)', 'x_2 (Predikcia)')
grid on                 % Mriezka
