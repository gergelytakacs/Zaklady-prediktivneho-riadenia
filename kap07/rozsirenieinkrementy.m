function [At,Bt,Ct] = rozsirenieinkrementy(A,B,C)

[nx nu]=size(B);                    % Rozmery modelu
ny=size(C,1);                       % ...                                 
At=[eye(nu)  zeros(nu,nx);          % Rozsirene A    
    B        A ];                   % Dynamika+inkrement
Bt=[eye(nu); zeros(nx,nu)];         % Rozsirene B
Ct=[zeros(nu,ny) C];                % Rozsirene C