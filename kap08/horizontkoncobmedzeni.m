function [n,KPsi] = horizontkoncobmedzeni(K,Psi,uh,ul)
o=optimoptions('linprog','Display','none');% Vypn. vypis
KPsi=K; KPsi(nu+1:2*nu,:)=K*Psi;         % Obmedzenia LP
n=0; umax=uh+1; umin=ul-1; nu=length(uh);% Inicializacia
while (umax>uh | umin<ul)         % Podmienka behu cyklu
    n=n+1;                        % Inkrementuj horizont
    f=K*Psi^(n+1);                % Gradient pre LP
    Ac=[ KPsi(1:(n+1)*nu,:);      % Lava str. obm. v LP
        -KPsi(1:(n+1)*nu,:)];     % ...
    b=[ repmat(eye(nu),n+1,1)*uh; % Prava str. obm. v LP
       -repmat(eye(nu),n+1,1)*ul];% ...
    for j=1:nu                    % Ries. LP pre kazde u
        x=linprog(-f(j,:),Ac,b,[],[],[],[],[],o);   %LP1
        umax(j,1)=f(j,:)*x;       % Vypocet umax,j
        if ul~=-uh;               % Asymetr. obm. vstupu
            x=linprog(f(j,:),Ac,b,[],[],[],[],[],o);%LP2
            umin(j,1)=f(j,:)*x;   % Vypocet umin,j
        else                      % Symetr. obm. vstupu
            umin(j,1)=-umax(j,1); % Vypocet umin,j
        end
    end
    KPsi(nu*(n+1)+1:nu*(n+2),:)=f;% K*Phi^(n+1) do KPhi 
end                               % Ukoncenie cyklu
KPsi=KPsi(1:nu*(n+1),:);          % Uloz KPsi^i,i=0,..,n
end                               % Ukoncenie funkcie