clc; clear;

A=[0 1; -0.5 1]; % Matica dynamiky
x0=[1; 0];       % Pociatocny stav
np=10;           % Horizont

X=[];                % Prazdna premmenna
for i=1:np           % Cyklus
    X(:,i+1)=A^i*x0; % Model
end                  % Koniec cyklu


figure(1)              % Prazdny obrazok
plot(X')               % X nakreslit
xlabel('Cas (vzorky)') % Popis X
ylabel('Stavy (-)')    % Popis Y
legend('x_1','x_2')    % Legenda
grid on                % Mriezka