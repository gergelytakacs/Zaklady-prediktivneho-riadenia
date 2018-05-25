clc; clear;

A=[1.1 2; 0 0.95]; B=[0; 0.0787];       % Model
[nx nu]=size(B);                        % Rozmery
Q=eye(nx); R=eye(nu);                   % Vahovanie
P=eye(2);                               % Inicializacia
n=50;                                   % Iteracie

for i=1:n                               % Iterujeme
 K=inv(R+B'*P*B)*B'*P*A;                % LQ zosilnenie
 P=A'*P*A-A'*P*B*inv(R+B'*P*B)*B'*P*A+Q;% Riccatiho rov.
end

P,K                                     % Vypis
Kx=dlqr(A,B,Q,R)                        % Kontrola




