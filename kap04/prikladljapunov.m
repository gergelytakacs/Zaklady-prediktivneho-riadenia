clc; clear;

A=[1.1 2; 0 0.95]; B=[0; 0.0787];  % Model
[nx nu]=size(B);                   % Rozmery
Q=eye(nx); R=eye(nu);              % Vahovanie
K=-dlqr(A,B,Q,R);                  % LQ zosilnenie

n=20;                              % Iteracie
P=eye(2);                          % Inicializacia

for i=1:n                          % Iterujeme
P=(A+B*K)'*P*(A+B*K)+Q+K'*R*K      % Lyapunova rovnica
Px(:,i)=[P(1,1);P(1,2);P(2,2)];    % Ulozenie do vektora         
end

plot(Px')                          % Vykreslit elementy
grid on                            % Mriezka
legend('P(1,1)','P(1,2)=P(2,1)','P(2,2)')
xlabel('Iteracia i (-)')           % Os x
ylabel('Hodnota elementov (-)')    % Os y



