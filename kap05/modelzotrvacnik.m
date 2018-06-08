%http://lpsa.swarthmore.edu/Representations/SysRepSS.html

Kr=50;
Br1=0.1;
Br2=0.2;
J1=1;
J2=2;
Ts=0.1;

Phi=[0      1        0 ;         
    -Kr/J1 -Br1/J1   Br1/J1;
     0      Br1/J2 -(Br2+Br1)/J2];
Gamma=[0   -1/J1     0    ]';
C=[1 0 0];
zotrvacnikC=ss(Phi,Gamma,C,[]);
zotrvacnik=c2d(zotrvacnikC,Ts);
save zotrvacnik zotrvacnik


