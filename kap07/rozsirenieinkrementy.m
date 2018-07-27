function [At, Bt, Ct] =  rozsirenieinkrementy(A,B,C);

[nx nu]=size(B);                       % Rozmery
[ny nx]=size(C);                       % Rozmery                     
At=[eye(nu)  zeros(nu,nx);             % Rozsirene A    
    B        A ];                      % Dynamika+inkr.
Bt=[eye(nu); zeros(nx,nu)];            % Rozsirene B
Ct=[zeros(nu,ny) C];                   % Rozsirene C