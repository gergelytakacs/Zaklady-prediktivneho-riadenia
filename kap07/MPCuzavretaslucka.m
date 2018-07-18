clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
Q=C'*C; R=0.01; np=10;                   % Vahy a horizont                       
uh=0.01; ul=-uh;                       % Obmedzenia

% Offline cast
[K,P]=iterdlqr(A,B,Q,R,100);           % Koncove vah.  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova f.
[Ac bc]=obmedzenia(ul,uh,np);          % Obmedzenia na u

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
vykreslitXU(X,U(1,:));                 % Zobrazenie
line([0,run],[uh uh],'Color','k','LineStyle','--')
line([0,run],[-uh -uh],'Color','k','LineStyle','--')

% Overenie ucinnosti riadenia
Xo=X;                                  % Pociatocna pod.
for i=1:run                            % Slucka sim.
    Xo(:,i+1)=A*Xo(:,i)+B*0;           % Bez riadenia.    
end                                    % Koniec slucky
figure(2)                              % Novy obrazok                            
plot(C*X); hold on; plot(C*Xo);        % Kreslenie
xlabel('Cas (-)'); ylabel('\Delta x (m)')
grid on; legend('MPC','Bez riadenia'); % Mriezka, legn.
