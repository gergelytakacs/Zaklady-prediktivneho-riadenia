function [M] = predikciaM(A,np) % Funkcia na M
 nx=length(A);                  % Zistime rozmer A
 M=zeros(np*nx,nx);             % Prealokacia
 for i=1:np                     % Cyklus
    M(i*nx-nx+1:i*nx,:)=A^i;    % Predikcia
 end                            % Koniec cyklu