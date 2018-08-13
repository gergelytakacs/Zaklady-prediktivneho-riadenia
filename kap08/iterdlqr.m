function [K P]=iterdlqr(A,B,Q,R,n)
P=eye(length(A));                       % Inicializacia
for i=1:n                               % Iterujeme
 K=inv(R+B'*P*B)*B'*P*A;                % LQ zosilnenie
 P=A'*P*A-A'*P*B*inv(R+B'*P*B)*B'*P*A+Q;% Riccatiho rov.
end





