clear; clc; close all

load param
load sysd              % Nacitanie diskr. stav. modelu
[A,B,C,~]=ssdata(sysd);% Vycit. matic disk. stav. modelu
nx=length(A);                   % Pocet stavov
ny=size(C,1);                   % Pocet vystupov

x0=[0;0;0;0];     % Pociatocny stav systemu
xlin=[0;0;pi;0];       % Pracovny (linearizacny) bod
dx0=x0-xlin;           % Transf. stavu do odchylk. tvaru

w_var=[0 0 0 1e-4]';   % Rozptyl procesneho sumu
v_var=[5e-3 5e-3]';    % Rozptyl sumu merania
Q=diag(w_var);         % Kovariancna matica proces. sumu
R=diag(v_var);         % Kovariancna matica sumu merania

T=10;                         % Konecny cas simulacie
cas=0:Ts:T-Ts;                % Trvanie a krok simulacie
N=T/Ts;                       % Pocet krokov simulacie

w=sqrt(w_var).*randn(nx,N);% Nahodny vektor proces. sumu
v=sqrt(v_var).*randn(ny,N);% Nahodny vektor sumu merania

x0=[0;0;0;0];     % Pociatocny stav systemu

xhat0=[0;0;0;0];
dxhat0=xhat0-xlin;
P0=eye(nx)*1e0;         % Poc. odhad apriornej kov. matice P
