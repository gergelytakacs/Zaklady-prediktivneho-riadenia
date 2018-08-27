clc; clear all;
% Zadanie prikladu
load bus.mat                         % Nacitaj model
A=bus.a; B=bus.b(:,2);  C=bus.c;     % Model autobusu
nx=length(A);                        % Pocet stavov
Q=C'*C; R=10; np=20;                 % Vahy a horizont                       
uh=0.01; ul=-uh;                     % Obmedzenia vstupu

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);         % Koncove vahovanie
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);  % Ucelova funkcia
[Ac bc]=obmedzenia(ul,uh,np);        % Obmedzenia na u

% Vypnut varovania
H=(H+H')/2;                                  % Symetr.Ak 
o=optimoptions('quadprog','Display','none'); % Vypnut 

% Pociatocny stav
run=20;                                % Dlzka sim.
X=[0.05 0 0 0]';                       % Poc, stav
for i=1:run                            % Slucka sim.
    U(:,i)=quadprog(H,G*X(:,i),Ac,bc,[],[],[],[],[],o);
    X(:,i+1)=A*X(:,i)+B*U(1,i);        % MPC sim.    
end

% Zobrazenie vysledkov
vykreslitXU(X,U(1,:));                 % Vykreslenie x,u
line([0,run],[uh uh],'Color','k','LineStyle','--')  % uh
line([0,run],[ul ul],'Color','k','LineStyle','--')  % ul

% Overenie ucinnosti riadenia
Xo=X;                                 % Pociat. stav
for i=1:run                           % Slucka simulacie
    Xo(:,i+1)=A*Xo(:,i)+B*0;          % Bez riadenia    
end                                   % Koniec slucky
figure(2)                             % Nove graf. okno                          
plot(C*X); hold on; plot(C*Xo);       % Vystup
xlabel('Cas (-)'); ylabel('\Delta x (m)')   % Oznac. osi
grid on                                     % Mriezka
legend('MPC','Bez riadenia')                % Legenda
