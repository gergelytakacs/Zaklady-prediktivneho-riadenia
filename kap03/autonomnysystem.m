clc; clear;

A=[0 1; -0.5 1];
x0=[1; 0];

X=[];
for i=0:10
    X(:,i+1)=A^i*x0;
end

figure(1)
plot(X')
xlabel('Cas (vzorky)')
ylabel('Stavy (-)')
legend('x_1','x_2')
grid on