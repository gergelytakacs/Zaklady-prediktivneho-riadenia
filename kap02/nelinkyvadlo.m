function dxdt = nelinkyvadlo(t,x,m1,m2,l,g,b)
dxdt = [x(2);
        (-m2*g*sin(x(3))*cos(x(3))+m2*l*((x(4))^2)*sin(x(3))+b*m2*x(4)*cos(x(3)))/(m1+(1-(cos(x(3)))^2)*m2);
        x(4);
        ((m1+m2)*(g*sin(x(3))-b*x(4))-(m2*l*((x(4))^2)*sin(x(3)))*cos(x(3)))/(l*(m1+(1-(cos(x(3)))^2)*m2))];