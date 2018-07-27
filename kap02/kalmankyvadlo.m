clear; clc; close all
load param
load linearnySM           % Nacitanie matic stav. modelu
sys=ss(Ac,Bc,Cc,Dc);      % Vytvor. objektu stav. modelu

Ts=0.01;                    % Vzorkovacia perioda [s]
sysd=c2d(sys,Ts,'zoh');     % Diskretizacia stav. modelu
[A,B,C,D]=ssdata(sysd);% Vycit. matic disk. stav. modelu
x0=[0;0;5*pi/6;0];        % Pociatocny stav systemu
xlin=[0;0;pi;0];
ylin=C*xlin;
ulin=0;
dx0=x0-xlin;                % Pociatocny stav systemu

w=1e-3;
v=[5e-4;5e-4];
