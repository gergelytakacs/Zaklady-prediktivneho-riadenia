function P = ljapiter(A,B,Q,R,n);

[nx nu]=size(B);                     % Rozmery
K=-dlqr(A,B,Q,R);                    % LQ zosilnenie
P=eye(2);                            % Inicializacia

for i=1:n                            % Iterujeme
P=(A+B*K)'*P*(A+B*K)+Q+K'*R*K;       % Lyapunova rovnica
end