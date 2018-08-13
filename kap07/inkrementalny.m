clc; clear all;
% Zadanie prikladu
load bus.mat                           % Nacitaj model
A=bus.a; B=bus.b(:,2);  C=bus.c;       % Model autobusu
Q=C'*C; R=0.01; np=10;                 % Vahy a horizont

[nx nu]=size(B);                       % Rozmery modelu
ny=size(C,1);                          % ...                    
duh=0.01; dul=-duh;                    % Obmedzenia du

At=[eye(nu)  zeros(nu,nx);             % Rozsirene A    
    B        A ];                      % Dynamika+inkr.
Bt=[eye(nu); zeros(nx,nu)];            % Rozsirene B
Ct=[zeros(nu,ny) C];                   % Rozsirene C

Qt=[R zeros(nu,nx);                    % Rozsirene Q
    zeros(nx,nu) Q];                   % ...
Rt=1;                                  % Rozsirene R

% Offline cast
[K,P]=iterdlqr(At,Bt,Qt,Rt,100);       % Vahovanie xnp  
[H,G]=ucelovafunkcia(At,Bt,np,Qt,Rt,P);% Ucelova funkcia
[Ac bc]=obmedzenia(dul,duh,np);        % Obmedzenia na u

% Vypnut varovania
H=(H+H')/2;                                 % Symetr. H 
o=optimoptions('quadprog','Display','none');% Vyp. vypis

% Pociatocny stav
run=20;                                % Dlzka simulacie
X=[0.05 0 0 0]';                       % Pociatocny stav
U=0;                                   % Pociatoc. vstup
for i=1:run                            % Simul. slucka
    dU(:,i)=quadprog(H,G*[U(i); X(:,i)],Ac,bc,[],[],[],[],[],o);
    U(i+1)=U(i)+dU(1,i);               % Inkrementuj u
    X(:,i+1)=A*X(:,i)+B*U(1,i);        % Simul. dynamiky    
end

% Zobrazenie vysledkov
subplot(3,1,1); plot(C*X); grid on    % Vystup, mriezka
ylabel('Vyska y_k (m)');              % Os y, znacenie
subplot(3,1,2); plot(dU(1,:)); grid on% Prirastok vstupu
ylabel('Inkr.  \Delta u_k (m)');      % Os y, znacenie
line([0,run],[duh duh],'Color','k','LineStyle','--')
line([0,run],[-duh -duh],'Color','k','LineStyle','--')
subplot(3,1,3); plot(U); grid on      % Vstup u
ylabel('Vstup  u_k (m)');             % Os y, znacenie
xlabel('Cas (-)');                    % Os x, znacenie

