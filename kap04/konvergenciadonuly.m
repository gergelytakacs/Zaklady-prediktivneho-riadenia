clc; clear;

sys=drss(2);                    % Nahodna stab. sustava
A=sys.A; B=sys.B;               % Matice A, B
[nx nu]=size(B);                % Rozmer sustavy

Q=eye(nx); R=eye(nu);           % Penalizacia
K=-dlqr(A,B,Q,R);               % LQ zakon

for k=1:20                      % Zvysujuce k
   Psi=(A+B*K)^k;               % Dynamika riad. sústavy
   PSI(k,:)=[Psi(1,1) Psi(2,1) Psi(1,2) Psi(2,2)];
end

plot(PSI)                       % Vykreslenie vysledku
grid on                         % Mriezka
xlabel('Cas (kroky)')           % Os X
ylabel('Hodnota elementov (-)') % Os Y a legenda
legend('(A+BK)(1,1)','(A+BK)(2,1)','(A+BK)(1,2)','(A+BK){(2,2)')