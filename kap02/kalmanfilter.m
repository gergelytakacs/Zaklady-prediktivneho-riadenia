function x = kalmanfilter(y,u,x0,P0,sysd,Q,R) 
[A,B,C,~]=ssdata(sysd);% Vycit. matic disk. stav. modelu
nx=length(A);

% Inicializacia
persistent x_pred P_pred                
if isempty(x_pred)
    x_pred = x0;    % Pociatocny apriorny odhad stavu         
    P_pred = P0;    % Poc. odhad apriornej kov. matice P
end

% Korektor (aktualizacia s novym meranim)
K = (P_pred*C')/(C*P_pred'*C'+R);% Optim. Kalman. zosil.
x_odh = x_pred + K*(y-C*x_pred); % Aposter. odhad stavu
P_odh = (eye(nx)-K*C)*P_pred;%Aposter. kov. chyby odhadu

% Prediktor (casova aktualizacia)
x_pred = A*x_odh + B*u;     % Apriorny odhad stavu
P_pred = A*P_odh*A' + Q;    % Apriorna kov. chyby odhadu

x = x_odh;                    % Odhadnuty stavovy vektor
end    