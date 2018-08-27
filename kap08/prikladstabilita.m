clear; close all; clc
A=[1.1 2;0 0.95]; B=[0;0.0787]; C=[-1 1];% Stavovy model
uh=1; ul=-uh;                            % Obmedzenia
Q=C'*C; R=0.01; np=2;                    % Vahy a horiz.
[K,P]=iterdlqr(A,B,Q,R,100);          % Vah. konc. stavu

[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P); % Ucelova funkcia
[Ac,bc]=obmedzenia(ul,uh,np);     % Formulacia obmedzeni

H=(H+H')/2;                                 % Symetr. H 
o=optimoptions('quadprog','Display','none');% Vyp. vypis

run=100;                             % Trvanie simulacie
x=[0.5 -0.5]';                       % Pociatocny stav 
for i=1:run                          % Simulacna slucka
    u(:,i)=quadprog(H,G*x(:,i),Ac,bc,[],[],[],[],[],o);
    x(:,i+1)=A*x(:,i)+B*u(1,i);      % Simulacia modelu
    J(i)=u(:,i)'*H*u(:,i)+2*x(:,i)'*G'*u(:,i)+x(:,i)'*F*x(:,i);                       % Hod. ucelovej f.
end

figure('color','w')                      % Obrazok
subplot(3,1,1)                           % Graf 1
plot(C*x,'LineWidth',1,'Marker','.')     % Vystup
ylabel('Vystup y_k (-)')                 % Oznac. osi y
grid on                                  % Mriezka
subplot(3,1,2)                           % Graf 2
stairs(u(1,:),'LineWidth',1,'Marker','.')% Vstup
hold on; grid on                         % Podrz+mriezka
line([0,run],[uh uh],'Color','k','LineStyle','--')  % uh
line([0,run],[ul ul],'Color','k','LineStyle','--')  % ul
xlabel('Cas (-)')                        % Oznac. osi x
ylabel('Vstup u_k (-)')                  % Oznac. osi y
legend('u_k','u_h','u_l')                % Legenda
subplot(3,1,3)                           % Graf 3
plot(J,'LineWidth',1,'Marker','.')       % Hod. ucel. f.
grid on                                  % Mriezka
xlabel('Cas (-)')                        % Oznac. osi x
ylabel('Ucelova funkcia J_k (-)')        % Oznac. osi y