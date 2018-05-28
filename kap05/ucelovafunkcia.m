function [H,G,F]=ucelovafunkcia(A,B,np,Q,R,P);

[nx nu]=size(B);                % Pocet stavov a vstupov
[M N]=predikcia(A,B,np);        % Predikcne mat.

RR=kron(eye(np),R);             % Kaligraficke R

H=zeros(np*nu,np*nu);           % Prva nula N0'*Q*N0=0
G=zeros(np*nu,nx);              % Prva nula N0'*Q*M0=0
F=Q;                            % Prva je M0*Q=Q;

for i=1:np-1;                   % Prvy clen az do np-1
    H=H+N((i-1)*nx+1:i*nx,:)'*Q*N((i-1)*nx+1:i*nx,:);
    G=G+N((i-1)*nx+1:i*nx,:)'*Q*M((i-1)*nx+1:i*nx,:);
    F=F+M((i-1)*nx+1:i*nx,:)'*Q*M((i-1)*nx+1:i*nx,:);
end
i=np;                           % Posledny riadok
H=H+N((i-1)*nx+1:i*nx,:)'*P*N((i-1)*nx+1:i*nx,:)+RR;
G=G+N((i-1)*nx+1:i*nx,:)'*P*M((i-1)*nx+1:i*nx,:);
F=F+M((i-1)*nx+1:i*nx,:)'*P*M((i-1)*nx+1:i*nx,:);