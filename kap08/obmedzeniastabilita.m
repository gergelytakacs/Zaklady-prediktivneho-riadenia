function [Ac,b0,B0] = obmedzeniastabilita(A,B,np,nc,KPsi,ul,uh)
[nx,nu]=size(B);              % Pocet stavov a vstupov
[M,N] = predikcia(A,B,np);    % Predikcne matice M a N
Mnp = M(nx*np-(nx-1):nx*np,:);% Posledny blok. riadok M
Nnp = N(nx*np-(nx-1):nx*np,:);% Posledny blok. riadok N
Ac=eye(np*nu);                % Inic. lavej strany obm.
B0=zeros(np*nu,nx);           % Inic. pravej strany obm.
for i=0:nc           % Pridaj konc. obm. na horizonte nc
    Ac(nu*(np+i)+1:nu*(np+i+1),:)= KPsi(i*nu+1:(i+1)*nu,:)*Nnp;           % Lava str. konc. obmedzeni
    B0(nu*(np+i)+1:nu*(np+i+1),:)=-KPsi(i*nu+1:(i+1)*nu,:)*Mnp;           % B0 na pravej str. konc. obm.
end
Ac=[Ac;-Ac];                 % Pridaj dolne obm. u a xnp
B0=[B0;-B0];                 % ...
b0=[ repmat(eye(nu),np+nc+1,1)*uh;  % b0 obm. na u a xnp
    -repmat(eye(nu),np+nc+1,1)*ul]; % ...
end                                 % Ukoncenie funkcie