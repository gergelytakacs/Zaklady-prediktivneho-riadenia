clc; clear;                 

A=[1.1 2; 0 0.95]; B=[0; 0.0787];    % Model
[nx nu]=size(B);                     % Rozmery
Q=eye(nx); R=eye(nu);                % Vahovanie
K=-dlqr(A,B,Q,R);                    % LQ zosilnenie

P = dlyap([A+B*K]',[Q+K'*R*K])       % Koncove vahovanie