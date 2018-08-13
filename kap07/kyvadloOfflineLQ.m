
load kyvadlo.mat              % Linearizovany model
A=kyvadlo.a; B=kyvadlo.b; C=kyvadlo.c; 
[nx nu]=size(B);              % Rozmery stavoveho modelu
Ts=kyvadlo.Ts;                % Vzorkovacia perioda [s]
uh=5;                         % Max. sila na vozik [N]
ul=-uh;                       % Min. sila na vozik [N]
x1h=0.5;                      % Max. draha vozika [m]
x1l=-x1h;                     % Min. draha vozika [m]

%Qlq=eye(nx); Qlq(1)=10;     % Vahovanie koncoveho stavu
Qlq=C'*C;                    % Vahovanie stavov
Rlq=1;                       % Vahovanie vstupu
Klq=dlqr(A,B,Qlq,Rlq);       % LQ zosilnenie
