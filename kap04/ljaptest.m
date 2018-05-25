clc; clear;

A=[1.1 2; 0 0.95]; B=[0; 0.0787];    % Model
Q=eye(2); R=1;                       % Vahovanie
P=ljapiter(A,B,Q,R,20)               % Iteracne riesenie             