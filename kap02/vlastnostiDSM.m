clear; clc; close all
load sysd              % Nacitanie diskr. stav. modelu
[A,B,C,D]=ssdata(sysd);% Vycit. matic disk. stav. modelu

lambda=eig(A)          % Vlastne cisla matice dynamiky A

abs(lambda)                    % Velkost vlastnych cisel

isstable(sysd)                 % Test stability systemu

figure('color','w')    % Otvor. noveho grafickeho okna
zplane(lambda)         % Znazor. vlast. cisel v z-rovine
xlabel('Re(\lambda)');                 % Oznacenie osi x
ylabel('Imag(\lambda)');               % Oznacenie osi y

...
Co = ctrb(sysd)         % Matica riaditelnosti
length(A)-rank(Co)      % Pocet neriaditelnych stavov

Ob = obsv(sysd)         % Matica pozorovatelnosti
length(A)-rank(Ob)      % Pocet nepozorovatelnych stavov


return
% zgrid
% plot(real(lambda),imag(lambda),'r+',...
%     'LineWidth',1.5,...
%     'MarkerSize',8)
%,...
    %'MarkerEdgeColor','red'%),...
    %MarkerFaceColor','red')