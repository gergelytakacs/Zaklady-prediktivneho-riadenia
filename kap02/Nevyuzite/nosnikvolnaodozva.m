clc; clear;
load nosnik
Ts=0.005;
y=y(1000:2000)
u=zeros(length(y),1)
data=iddata(y,y,Ts);         % Create an iddata object input/output

m=0.203; %l x w x h x dens [kg]  % Mass
k=400;   %470 [n/m]              % Initial guess of spring constant
b=0.01;  %0.08344 [N.s/m]        % Initial guess of damping

A = [0 1;-k/m -b/m];
B = [0;1/m];
C = [1 0];           % C is the same as the bottom part of A
D = 0;
K = [0;0];                     % No noise
x0 = [y(1);0];                  % Roughly 3 cm is the initial deflection
m = idss(A,B,C,D,K,x0,0);        % Ts here is zero = continuous system

%% Create unknown model with given structure
m.As = [NaN NaN;NaN NaN]; % The indicator (see idss help) As is used to have the same structure as...
m.Bs = [0;0];
m.Cs=  C;     % m.Cs = [NaN NaN];
m.x0s = [NaN;NaN];
m.Ts=0;
%m.NoiseVariance = 0.1^2;

%% ========================================================================
%% This is the second class
%% ========================================================================

%% Identify this model with PEM
mod = pem(data,m)      % PEM command                                  
modD=c2d(mod,Ts);

%% Simulate and compare with a plot
compare(data,modD)
[YH, FIT, x0] = compare(data,modD)

A=modD.A;
save model A x0
