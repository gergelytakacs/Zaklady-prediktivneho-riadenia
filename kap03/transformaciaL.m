function [L] = transformaciaL(C,np) % Funkcia na L
 [ny nx]=size(C);               % Rozmer sustavy
 L=zeros(ny*np,nx*np);          % Prealokacia
 for i=1:np                     % Cyklus
    L(i*ny-ny+1:i*ny,i*nx-nx+1:i*nx)=C';   
 end                            % Koniec cyklu