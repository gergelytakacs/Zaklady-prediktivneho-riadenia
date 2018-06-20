clc; clear; close all;

% Odkomentujte zelany priklad
% Vykreslenie prikladu
% H=[2  0; 0 10]; g=[-10 -54]';        % 2 aktivne obm.
% H=[2  1; 1 2]; g=[-10 -54]';         % Zacyklenie
H=[2  0; 0 18]; g=[-10 -54]';          % Povodny probl.
Ac=[-1  0;  0 -1;  1  1]; bc=[0 0 4]'; % Obmedzenia
hr=[-1, 6];                            % Hranice graf. 
vykreslitkontury(H,g,hr,5)             % Kontury funkcie
vykreslitobmedzenia(Ac,bc,hr)          % Obmedzenia
legend('Kont.','u^{\circ}','g_i(u)','AutoUpdate','off')
axis([hr -1 5])                        % Zobrazenie
uQP=quadprog(H,g,Ac,bc)                % Kontrola
plot(uQP(1),uQP(2),'k^')               % Pociatocne rie.

% Pociatocne podmienky
riesenie=0;                            % Nemame riesenie
[no n]=size(Ac);                       % Pocet obm.
a=false(no,1);                         % Poc. aktivna mn
up=[1 1]';                             % Poc. riesenie
plot(up(1),up(2),'k+')                 % Pociatocne rie.

% QP
while(riesenie~=1)                     % Kym nemame rie.
    AC=Ac(a==1,:);                     % Obmedzenia v ap
    gp=(g'+up'*H)';                    % Inkr. grad. gp
    [NO n]=size(AC);                   % Pocet obmedzeni
    W=[H  AC'; AC zeros(NO)];          % Lava strana
    V=[-gp; zeros(NO,1)];              % Prava strana
    z=inv(W)*V;                        % du, lambda
    du=z(1:n);                         % Zmena v delta u
    upp=up+du;                         % Novy smer v up
    % Kontrola porusenia obmedzenia
    if (any(~(Ac*(up+du)<=bc)));       % Porusene obm.
        plot(upp(1),upp(2),'k+')       % Vykreslit up  
        da=Ac*(up+du)>=bc;             % Porusene teraz
        dc=bitxor(a,da);               % z toho nove        
        a=bitor(a,da);                 % Nova akt. mn.
        alpha=(bc(dc,:)-Ac(dc,:)*up)./(Ac(dc,:)*du);               
        up=up+min(alpha)*du;           % Nove up.
        plot(up(1),up(2),'k+');        % Vykreslit up  
    % Ak sme neporusili obmedzenia prekontrolujme
    else                               % Zlucitelne ries
        up=up+du;                      % Neporusene obm.
        plot(up(1),up(2),'k+');        % Vykreslit up         
        AC=Ac(a==1,:);                 % Obmedzenia v ap
        BC=bc(a==1);                   % Obmedzenia v ap
        [NO n]=size(AC);               % Pocet obm.
        WW=[H  AC'; AC zeros(NO)];     % Lava strana
        VV=[-g; BC];                   % Prava strana
        zz=inv(WW)*VV;                 % u, lambda        
        if min(z(n+1:end))>=0          % ak lambda>=0
            riesenie=1;                % Mame riesenie
            u=up                       % Toto je ries.
            return                     % Vratenie z cyk.
        end                            % Koniec if
    end                                % Koniec if
end                                    % Koniec while



