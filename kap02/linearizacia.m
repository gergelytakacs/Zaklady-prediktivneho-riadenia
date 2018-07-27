clear; clc
load param.mat                    % Nacitanie parametrov
syms dxdt y x1 x2 x3 x4 u         % Symbolicke premenne

dxdt=[x2;                              % Stavova rovnica
      (-m2*g*sin(x3)*cos(x3)+m2*l*((x4)^2)*sin(x3)+b*m2*x4*cos(x3)+u)/(m1+((sin(x3))^2)*m2);
      x4;
      ((m1+m2)*(g*sin(x3)-b*x4)-(m2*l*((x4)^2)*sin(x3)+u)*cos(x3))/(l*(m1+((sin(x3))^2)*m2))];
   y=[x1;                              % Rovnica vystupu
      x3];

Alin=jacobian(dxdt,[x1 x2 x3 x4]);
Blin=jacobian(dxdt,u);
Clin=jacobian(y,[x1 x2 x3 x4]);
Dlin=jacobian(y,u);

xlin=[0 0 pi 0];
ulin=0;

Ac=eval(subs(Alin,[x1 x2 x3 x4 u],[xlin ulin]));
Bc=eval(subs(Blin,[x1 x2 x3 x4 u],[xlin ulin]));
Cc=eval(subs(Clin,[x1 x2 x3 x4],xlin));
Dc=eval(subs(Dlin,[x1 x2 x3 x4],xlin));
save('linearnySM','Ac','Bc','Cc','Dc')  % Ulozenie matic