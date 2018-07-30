
load kyvadlo.mat               % Linearizovany model
A=kyvadlo.a; B=kyvadlo.b; C=kyvadlo.c; 
[nx nu]=size(B);               % Rozmery modelu
Ts=kyvadlo.Ts;                 % [s] Vzorkovanie modelu
uh=5;                          % [N] max sila do vozika
ul=-uh;                        % [N] min sila do vozika
x1h=0.5                        % [m] max draha vozika
x1l=-x1h;                      % [m] min draha vozika

%Qlq=eye(nx); Qlq(1)=10;        % Konz. vahovanie stavov
Qlq=C'*C;                      % Vahovanie stavov
Rlq=1;                         % Vahovanie vstupu
Klq=dlqr(A,B,Qlq,Rlq);         % LQ zosilnenie
