function f=objfun(x,mu,H,g,Ac,bc)
f=(mu*((1/2)*x'*H*x+g'*x)+(-log(bc(1)-Ac(1,:)*x)-log(bc(2)-Ac(2,:)*x)-log(bc(3)-Ac(3,:)*x)));