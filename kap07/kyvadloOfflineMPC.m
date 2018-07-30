
load kyvadlo.mat               % Linearizovany model
A=kyvadlo.a; B=kyvadlo.b; C=kyvadlo.d; 
[nx nu]=size(B);               % Rozmery modelu
Ts=kyvadlo.Ts;                 % [s] Vzorkovanie modelu

np=50;                         % krokov 
Q=C'*C;                        % Vahovanie stavov
Q=C'*C; Q(1)=100;               % Vahovanie stavov
Q=eye(nx); Q(1)=10;
R=1;                           % Vahovanie vstupu

%% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);       % Koncove vah.  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);% Ucelova f.
H=(H+H')/2;                                  % Symetr.Ak 

% Obmedzenia
uh=5;                          % [N] max sila do vozika
ul=-uh;                        % [N] min sila do vozika
x1h=0.50;                       % [m] max draha vozika
x1l=-x1h;                      % [m] min draha vozika
xh=[x1h 1E8 1E8 1E8]';         % Obm na vsetky stavy
xl=-xh;                                     % Symetricke 
[Ac b0 B0]=obmedzenia(ul,uh,xl,xh,np,A,B); % Obmedzenia