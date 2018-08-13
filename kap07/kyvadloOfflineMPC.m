
load kyvadlo.mat              % Linearizovany model
A=kyvadlo.a; B=kyvadlo.b; C=kyvadlo.c; 
[nx nu]=size(B);              % Rozmery stavoveho modelu
Ts=kyvadlo.Ts;                % Vzorkovacia perioda [s]

np=50;                        % Predikcny horizont
Q=C'*C;                       % Vahovanie stavov
%Q=eye(nx); Q(1)=10;          % Ine vahovanie
R=1;                          % Vahovanie vstupu

%% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);       % Vah. koncov. stavu  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);% Ucelova funkcia
H=(H+H')/2;                        % Symetrizacia H

% Obmedzenia
uh=5;                         % Max. sila na vozik [N]
ul=-uh;                       % Min. sila na vozik [N]
x1h=0.50;                     % Max. draha vozika [m]
x1l=-x1h;                     % Min. draha vozika [m]
xh=[x1h 1E8 1E8 1E8]';        % Obmedzenia stavov
xl=-xh;                       % Symetricke 
[Ac b0 B0]=obmedzenia(ul,uh,xl,xh,np,A,B); % Obmedzenia