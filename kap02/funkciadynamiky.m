function x = funkciadynamiky(x,u)
Ts=0.01;                                % Vzork. perioda
m1=0.4; m2=0.08; l=0.2; g=9.81; b=0.1;  % Parametre
x=x+[x(2);
    (-m2*g*sin(x(3))*cos(x(3))+m2*l*((x(4))^2)*sin(x(3))+b*m2*x(4)*cos(x(3))+u)/(m1+(sin(x(3))^2)*m2);
     x(4);
    ((m1+m2)*(g*sin(x(3))-b*x(4))-(m2*l*((x(4))^2)*sin(x(3))+u)*cos(x(3)))/(l*(m1+(sin(x(3))^2)*m2))]*Ts;

% Eulerova diskretizacia dynamiky