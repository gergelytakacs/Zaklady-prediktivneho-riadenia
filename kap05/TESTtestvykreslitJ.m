clc; clear all;


A=[1.1 2; 
    0 0.95]; 
B=[0 0.0787]';        
C=[-1 1];
Q=C'*C; R=0.01;  np=4;   
[K P]=dlqr(A,B,Q,R);
[H,G,F]=ucelovafunkcia(A,B,np,Q,R,P); 

% URCITE SPRAVNE ^^^^^^^^
x=[0.5 -0.5]';


jj=[]
% Online cast
for i=1:100                            % Trvanie sim.
 upr=-inv(H)*G*x;                     % Predikcia u
 u=upr(1);                            % Prvy clen
 J=upr'*H*upr+2*x'*G'*upr+x'*F*x       % Dosadim do ucelovky
 
% Treba dosadit za F!!!!!
% J(k) je cela v kvadratickom tvare a je stale kladna
% ale posledny clen treba!
% Posledny clen vypadne iba ak hovorime o optimalizacii

% Treba zratat posledny clen, inac to nema zmysel

%Jsumyatd=Jkvadratickytvar.
%Obrovsky rozdiel robi!

% Ako indexovat od nuly??? Pre vsetky graficke funkcie?

 x=A*x+B*u;                           % Aplikacia u
end








