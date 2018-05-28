function [N] = predikciaN(A,B,np) % Funkcia na N
    [nx nu]=size(B);              % Rozmer sustavy
    N=zeros(nx*np,nu*np);         % Vyplnit N nulami
    NN=zeros(nx*np,nu);           % Vyplnit NN nulami
% Vytvorenie pomocnej matice
for i=1:np % Prvy stlpec matice N
    NN(i*nx-nx+1:i*nx,:)=[A^(i-1)*B];
end
% Dokoncenie celej matice N
for i=1:np % Cela matica N posunom dole
    N(i*nx-nx+1:end,i*nu-nu+1:i*nu)=NN(1:np*nx-(i-1)*nx,:);
end