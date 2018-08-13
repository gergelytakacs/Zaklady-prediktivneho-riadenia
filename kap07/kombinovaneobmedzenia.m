clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nacitaj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
Q=C'*C; R=0.01; np=10;                 % Vahy a horizont                

[At,Bt,Ct] = rozsirenieinkrementy(A,B,C);
Qt=diag([R C]);                        % Rozsirene Q
Rt=1;                                  % Rozsirene R

% Offline cast
[K,P]=iterdlqr(At,Bt,Qt,Rt,100);       % Vahovanie xnp    
[H,G]=ucelovafunkcia(At,Bt,np,Qt,Rt,P);% Ucelova funkcia

% Obmedzenia na amplitudy
duh=0.01; dul=-duh;                        % Prirastky
uh= 0.01;                                  % Amplituda
xh=[uh 1E8 1E8 1E8 1E8]';                  % Stavy
xl=-xh;                                    % Symetr. x
[Ac b0 B0]=obmedzenia(dul,duh,xl,xh,np,At,Bt);% Obmedz.

% Vypnut varovania
H=(H+H')/2;                                 % Symetr. H
o=optimoptions('quadprog','Display','none');% Vyp. vypis

% Pociatocny stav
run=20;                                % Dlzka simulacie
X=[0.05 0 0 0]';                       % Pociatocny stav
U=0;                                   % Pociatoc. vstup
for i=1:run                            % Simul. slucka
    dU(:,i)=quadprog(H,G*[U(i); X(:,i)],Ac,(b0+B0*[U(i); X(:,i)]),[],[],[],[],[],o);
    U(i+1)=U(i)+dU(1,i);               % Inkrementuj u
    X(:,i+1)=A*X(:,i)+B*U(1,i);        % Simul. dynamiky   
end

% Zobrazenie vysledkov
subplot(3,1,1); plot(C*X); grid on     % Vystup
ylabel('Vyska y_k (m)');               % Os y, znacenie
subplot(3,1,2); plot(dU(1,:)); grid on % Inkr. vstupu
ylabel('Inkr.  \Delta u_k (m)');       % Os y, znacenie
line([0,run],[duh duh],'Color','k','LineStyle','--')
line([0,run],[-duh -duh],'Color','k','LineStyle','--')
subplot(3,1,3); plot(U); grid on       % Vstup
line([0,run],[uh uh],'Color','k','LineStyle','--')
line([0,run],[-uh -uh],'Color','k','LineStyle','--')
ylabel('Vstup  u_k (m)');              % Os y, znacenie
xlabel('Cas (-)');                     % Os x, znacenie

% Upravenie vysledkov
subplot(3,1,1)
axis([0,20,-0.04,0.04])
subplot(3,1,2)
legend('\Delta u_k','\Delta u_h','\Delta u_l')
axis([0,20,-0.0125,0.0125])
subplot(3,1,3)
legend('u_k','u_h','u_l')
axis([0,20,-0.0125,0.0125])

