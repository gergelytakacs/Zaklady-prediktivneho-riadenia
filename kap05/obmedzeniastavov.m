funkcia [Ac b0 B0] = obmedzeniastavov(xl,xh,np,A,B)

[nx nu]=size(B);                          % Rozmery
[M,N]=predikcia(A,B,np);                  % Predikcne m.
Ac=[ N; -N]                               % Matica Ac
B0=[-M;  M]                               % Matica B0
One=[];                                   % Prazdna 1
for i=1:np                                % Cez horizont 
    One=[One; eye(nx)];                   % Vyplnenie 1
end                                       % Koniec cyklu
b0=[One*xh;-One*xl];                      % Matica b0



