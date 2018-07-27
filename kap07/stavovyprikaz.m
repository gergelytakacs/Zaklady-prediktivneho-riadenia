clear all; clc; clf;

% Modelovanie
Ac = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0]; 
Bc = [0.232; 0.0203; 0];                % Matica vstupu
C = [0 0 1];                            % Matica vystupu
Ts=0.5;                                 % [s] Vzork.
b777 = ss(Ac,Bc,C,[]);                  % Spojita dyn.
model=c2d(b777,Ts);                     % Diskretizacia
A=model.a; B=model.b;                   % Matice A a B

Nx=C';                                  % Stavovy prikaz
rr=[0.25 0];                            % [rad] Ziadane
X=[0 0 0]';                             % Poc. stav

run=150;                                % Dlzka sim.
[nx nu]=size(B);                        % Rozmery
Q=eye(nx); R=1; np=25;                  % Vahy a horiz.
uh=0.1; ul=-uh;                         % Obmedzenia

% Offline MPC
[K,P]=iterdlqr(A,B,Q,R,100);            % Koncove vah.  
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);     % Ucelova f.
[Ac bc]=obmedzenia(ul,uh,np);           % Obmedzenia u

% Vypnut varovania
H=(H+H')/2;                                     % Symetr
o=optimoptions('quadprog','Display','none');    % Vypnut
warning('off','Control:analysis:LsimStartTime') % Lsim

% Simulacia (a online MPC)                              
for i=1:run                              % Slucka sim.
 if i<=run/2; r=rr(1); else r=rr(2); end % Referencia        
 U(:,i)=quadprog(H,G*(X(:,i)-Nx*r),Ac,bc,[],[],[],[],[],o);
 [y,t,x]=lsim(b777,[U(1,i) U(1,i)],[(i-1) i]*Ts,X(:,i));
 X(:,i+1)=x(end,:)';                     % Aktualny stav
end


% Zobrazenie vysledkov
vykreslitXU(X,U(1,:));                   % Zobrazenie
line([0,run],[uh uh],'Color','k','LineStyle','--')
line([0,run],[-uh -uh],'Color','k','LineStyle','--')


