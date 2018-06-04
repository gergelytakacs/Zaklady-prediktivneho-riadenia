clear; clc;

load zotrvacnik                       % Model a matice
A=zotrvacnik.a; B=zotrvacnik.b; C=zotrvacnik.c; 
X0=[0.2 0.1 0.1]';                    % Pociatocny stav
umax=0.5; umin=-umax;                 % Obmedzenia
Q=C'*C; R=0.01;                       % Vahovanie nom.
K=-dlqr(A,B,Q,R);                     % LQ nom.

Xlq=X0;                               % Pomocna prem.
for i=1:100                           % Dlzka sim.
    Ulq(i)=K*Xlq(:,i);                % LQ riadenie u
    Xlq(:,i+1)=A*Xlq(:,i)+B*Ulq(i);   % Stavy x
    Ylq(i)=C*Xlq(:,i);                % Vystupy y
end

Xsat=X0;                              % Pomocna prem.
for i=1:100                           % Dlzka sim.
    Usat(i)=K*Xsat(:,i);              % LQ riadenie u
    if Usat(i)>=umax                  % u viac ako max
        Usat(i)=umax;                 % u je max
    end
    if Usat(i)<=umin                  % u menej ako min
        Usat(i)=umin;                 % u je min
    end    
    Xsat(:,i+1)=A*Xsat(:,i)+B*Usat(i);% Stavy x
    Ysat(i)=C*Xsat(:,i);              % Vystupy y
end

subplot(2,1,1)                        % Vystupy
plot(Ylq); hold on; plot(Ysat); grid on
xlabel('Cas (-)'); ylabel('Vystup y (rad)')
legend('y_{LQ}','y_{LQ-Sat}')

subplot(2,1,2);                       % Vstupy
plot(Ulq); hold on; plot(Usat); grid on
xlabel('Cas (-)'); ylabel('Vstup u (N/m)');
legend('u_{LQ}','u_{LQ-sat}')


