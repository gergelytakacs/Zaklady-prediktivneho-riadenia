function [At,Bt,Ct] =  rozsirenieintegrator(A,B,C)
[ny nx]=size(C);                 % Pocet vystupov
[nx nu]=size(B);                 % Pocet stavov, vstupov

At=[eye(ny,nx) -C;               % Rozsirene A    
    zeros(nx)  A];               % Dynamika + integrator
Bt=[zeros(nx,nu); B];            % Rozsirene B
Ct=[zeros(ny,nx) C];             % Rozsirene C
