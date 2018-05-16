clc; clear; clf;

F=[0 1; 0 0];                        % Matica dynamiky
G=[0 1]';                            % Matica vstupov
H=[1 0];                             % Matica vystupov
x0=[1 1]'; Ts=1; np=10;              % Parametre
    
[A,B,C,D] = c2dm(F,G,H,0,Ts);        % Diskretizacia
[M,N] = predikcia(A,B,np);           % Predikcne matice

upr=ones(np,1);                      % Vstup (skok)
xpr=M*x0+N*upr                       % Predikovane stavy
Xpr=[xpr(1:2:end,:),xpr(2:2:end,:)]; % Vektor stavov
plot(Xpr,'.-');                      % Vykreslit pred.
hold on;                             % Podrzat graf
   
i=5;                                 % Index stavu
nx=length(A);                        % Pocet stavov
xi=M((i-1)*nx+1:i*nx,:)*x0 +N((i-1)*nx+1:i*nx,:)*upr

plot(i,xi(1),'ko')                   % i-ty stav x1
plot(i,xi(2),'ko')                   % i-ty stav x2
grid on                              % Mriezka
xlabel('Cas (s)')                    % Os x
ylabel('Stavy (-)')                  % Os y
legend('x_1','x_2')                  % Legenda
