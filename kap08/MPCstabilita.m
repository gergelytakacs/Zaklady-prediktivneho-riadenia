clear; close all; clc
A=[1.1 2;0 0.95]; B=[0;0.0787]; C=[-1 1];% Stavovy model
nx=length(A);                            % Pocet stavov
uh=1; ul=-uh;                        % Obmedzenia vstupu
Q=C'*C; R=1; np=5;                   % Vahy a horizont
[K,P]=iterdlqr(A,B,Q,R,100);% Vahovanie koncoveho stavu
K=-K; Psi=A+B*K;            % Dynamika uzav. reg. obvodu

[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P);        % Ucelova f
[nc,KPsi]=horizontkoncobmedzeni(K,Psi,uh,ul);% Horiz. nc
[Ac,b0,B0]=obmedzeniastabilita(A,B,np,nc,KPsi,ul,uh);

H=(H+H')/2;                                 % Symetr. H 
o=optimoptions('quadprog','Display','none');% Vyp. vypis

n=25;                                % Trvanie simulacie
x=[-7 0.5]';                         % Pociat. stav x(0)
for k=1:n                            % Simulacna slucka
    u(:,k)=quadprog(H,G*x(:,k),Ac,b0+B0*x(:,k),[],[],[],[],[],o);           % Riesenie QP MPC
    x(:,k+1)=A*x(:,k)+B*u(1,k);      % Simulacia modelu
end

[M,N]=predikcia(A,B,np);              % Predikcne matice
xpr=M*x(:,1)+N*u(:,1);                % Predikcia z x(0)
xnp=xpr(end-nx+1:end);                % Koncovy stav
for i=1:n-np
    xpr=[xpr;Psi^(i)*xnp];            % Predik. traj. x
end
xpr=[x(:,1);xpr];                     % Pridaj poc. stav

Jus=0;
for j=1:n                 % Hodnota J v uzavretej slucke
    Jus=Jus+x(:,j)'*Q*x(:,j)+u(1,j)'*R*u(1,j);
end
Jpr0=u(:,1)'*H*u(:,1)+2*x(:,1)'*G'*u(:,1)+x(:,1)'*F*x(:,1);                % Predikovana J v x(0)
disp(['Jus = ',num2str(Jus)])               % Vypis Jcl
disp(['J(0) = ',num2str(Jpr0)])             % Vypis J(0)

figure('color','w')                      % Obrazok
plot(xpr(1:nx:end-1),xpr(2:nx:end),'-bo')% Pred. traj. x
hold on; grid on                   % Podrz graf, mriezka 
plot(x(1,:),x(2,:),'-r+')          % Skutoc. stav. traj.
xlabel('x_1'); ylabel('x_2');      % Oznacenie osi x a y
legend('Predikcia v x_0','Uzavreta slucka')% Legenda
axis([-7 1 -0.1 0.8])                      % Hran. grafu