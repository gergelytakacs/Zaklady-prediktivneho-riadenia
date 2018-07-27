clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nahraj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
[nx nu]=size(B);                       % Rozmery
[ny nx]=size(C);                       % Rozmery                     

[At, Bt, Ct] =  rozsirenieinkrementy(A,B,C);
Q=C'*C; R=10; np=10;                 % Vahy a horizont
Qt=diag([R C]);                        % Rozsirene Q
Rt=10;                                  % Rozsirene R

% Offline cast
[K,P]=iterdlqr(At,Bt,Qt,Rt,100);       % Koncove vah.  
[H,G]=ucelovafunkcia(At,Bt,np,Qt,Rt,P);% Ucelova f.

% Obmedzenia na amplitudy
duh=0.004; dul=-duh;                         % Inkrement
uh=0.002;                                  % Amplituda
xh=[uh 1E8 1E8 1E8 1E8]';                   % Stav
xl=-xh;                                     % Symetricke 
[Ac bc]=obmedzenia(dul,duh,xl,xh,np,At,Bt); % Obmedzenia

% Vypnut varovania
H=(H+H')/2;                                  % Symetr.Ak 
o=optimoptions('quadprog','Display','none'); % Vypnut 

% Pociatocny stav
run=40;                                % Dlzka sim.
X=[0.05 0 0 0]';                       % Poc. stav
U=0;                                   % Poc. vstup.
for i=1:run                            % Slucka sim.
    [dU(:,i),J,e(i)]=quadprog(H,G*[U(i); X(:,i)],Ac,bc,[],[],[],[],[],o);
    U(i+1)=U(i)+dU(1,i);               % Inkrement
    X(:,i+1)=A*X(:,i)+B*U(1,i);        % MPC sim.    
end

% Zobrazenie vysledkov
subplot(3,1,1); plot(C*X); grid on     % Vystup
ylabel('Vyska y_k (m)');               % Os y, zn
subplot(3,1,2); plot(dU(1,:)); grid on % Inkr. vstupu
ylabel('Inkr.  \Delta u_k (m)');       % Os y, znacenie
line([0,run],[duh duh],'Color','k','LineStyle','--')
line([0,run],[-duh -duh],'Color','k','LineStyle','--')
subplot(3,1,3); plot(U); grid on       % Vstup
line([0,run],[uh uh],'Color','k','LineStyle','--')
line([0,run],[-uh -uh],'Color','k','LineStyle','--')
ylabel('Vstup  u_k (m)');              % Os y, znacenie
xlabel('Cas (-)');                     % Os x, znacenie

beep
