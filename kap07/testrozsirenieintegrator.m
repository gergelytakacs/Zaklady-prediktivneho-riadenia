clc; clear all; clf;

Ts=5;                                 % (s) Vzorkovanie
run=150;                              % Dlzka sim.
rr=[80 50];                           % (C) Ziadana tep.
Q=eye(2); R=1; np=15;                 % Vahy a horiz.
uh=10; ul=0;                          % Obmedzenia

k=10; tau=60;                         % Parametre modelu
Ac=-1/tau; Bc=k/tau; Cc=1; Dc=0;      % Spojity model
[A,B,C,D]=c2dm(Ac,Bc,Cc,Dc,Ts);       % Diskretny model
vymennik=ss(Ac,Bc,Cc,Dc);             % Objekt modelu

[At, Bt, Ct] =  rozsirenieintegrator(A,B,C);
X=0; xI=0;                            % Pociatocne stavy
% Offline MPC
[K,P]=iterdlqr(At,Bt,Q,R,100);        % Koncove vah.  
[H,G]=ucelovafunkcia(At,Bt,np,Q,R,P); % Ucelova f.
[Ac bc]=obmedzenia(ul,uh,np);         % Obmedzenia u

% Vypnut varovania
H=(H+H')/2;                                     % Symetr
o=optimoptions('quadprog','Display','none');    % Vypnut
warning('off','Control:analysis:LsimStartTime') % Lsim

% Simulacia (a online MPC)                              
for i=1:run                              % Slucka sim.
 if i<=run/2; r=rr(1); else r=rr(2); end % Referencia   
 xI=xI+(r-X(i));                         % Integrator
 U(:,i)=quadprog(H,G*[xI; X(:,i)],Ac,bc,[],[],[],[],[],o);
 [y,t,x]=lsim(vymennik,[U(1,i) U(1,i)],[(i-1) i]*Ts,X(:,i));
 X(:,i+1)=x(end,:)';                     % Aktualny stav
end

% Zobrazenie vysledkov
vykreslitXU(X,U(1,:));                   % Zobrazenie
line([0,run],[uh uh],'Color','k','LineStyle','--')
line([0,run],[ul ul],'Color','k','LineStyle','--')


