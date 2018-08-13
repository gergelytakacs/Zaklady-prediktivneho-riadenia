clear all; clc; clf;

% Modelovanie
Ac = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0]; 
Bc = [0.232; 0.0203; 0];               % Matica vstupu
C = [0 0 1];                           % Matica vystupu
Ts=0.5;                                % Vzorkovanie [s]
b777 = ss(Ac,Bc,C,[]);                 % Spojity model
model=c2d(b777,Ts);                    % Diskretizacia
A=model.a; B=model.b;                  % Matice A a B

Nx=C';                                 % Stavovy prikaz
rr=[0.25 0];                           % Ziad. hodnoty y
X=[0 0 0]';                            % Pociatocny stav

run=150;                               % Dlzka simulacie
[nx nu]=size(B);                       % Pocet x a u
Q=eye(nx); R=1; np=25;                 % Vahy a horizont
uh=0.1; ul=-uh;                        % Min a max vstup

% Offline MPC
[K,P]=iterdlqr(A,B,Q,R,100);           % Konc. vahovanie
[H,G]=ucelovafunkcia(A,B,np,Q,R,P);    % Ucelova funkcia
[Ac bc]=obmedzenia(ul,uh,np);          % Obmedzenia u

% Vypnut varovania
H=(H+H')/2;                                     % Sym. H
o=optimoptions('quadprog','Display','none');    % Vypnut
warning('off','Control:analysis:LsimStartTime') % Lsim

% Simulacia (a online MPC)                              
for i=1:run                              % Simul. slucka
 if i<=run/2; r=rr(1); else r=rr(2); end % Referencia        
 U(:,i)=quadprog(H,G*(X(:,i)-Nx*r),Ac,bc,[],[],[],[],[],o);
 [y,t,x]=lsim(b777,[U(1,i) U(1,i)],[(i-1) i]*Ts,X(:,i));
 X(:,i+1)=x(end,:)';                     % Aktualny stav
end


% Zobrazenie vysledkov
vykreslitXU(X,U(1,:));                 % Vykreslenie x,u
line([0,run],[uh uh],'Color','k','LineStyle','--')  % uh
line([0,run],[ul ul],'Color','k','LineStyle','--')  % ul


