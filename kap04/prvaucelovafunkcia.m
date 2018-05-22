clc; clear;

A=[1 2; 0 0.5]; B=[0; 0.05];    % Model
C=[-1 1];                       % Model
np=5;                           % Horizont             
Q=C'*C;                         % Vah. stavu
R=0.1;                          % Vah. vstupov
P=Q;                            % Konc. vah.
[M N]=predikcia(A,B,np);        % Predikcne mat.

[nx nu]=size(B);                % Pocet stavov a vstupov
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
H,G,F                           % Vypis