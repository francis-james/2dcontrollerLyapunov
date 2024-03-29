function [M, coeffmat, Kd, Ks, res, Keff]=getSSdot(X,Xr,model)
%% Function to give input based on:
% theta = ArcTan[x - xc, y - yc];
% epsilontgt = 
%   Dot[{xr - x, yr - y}, {Cos[theta + Pi/2], Sin[theta + Pi/2]}];
% epsilonnorm = 
%   Dot[{xc + r0*Cos[theta] - x,  yc + r0*Sin[theta] - y}, {-Cos[theta], -Sin[theta]}];

x=X(1);
y=X(2);
xd=X(3);
yd=X(4);
xr=Xr(1);
yr=Xr(2);
xrd=Xr(3);
yrd=Xr(4);
xrdd=Xr(5);
yrdd=Xr(6);

dx=0;
dy=0;

xc=model.spPos(1);
yc=model.spPos(2);
r0=model.spRad;

theta=atan2(-model.spPos(2)+y,-model.spPos(1)+x);


epsilonn =  dot(-[xc+r0*cos(theta);yc+r0*sin(theta)]+[x;y],[-cos(theta); -sin(theta)])+dot(-[xr;yr]+[x;y],[-cos(theta); -sin(theta)]);%+...
%             dot([xc+r0*cos(theta);yc+r0*sin(theta)]-[x;y],[-cos(theta); -sin(theta)]);
epsilont =  dot(-[xr;yr]+[x;y],[cos(theta+pi/2);sin(theta+pi/2)]);
% [xr;yr]
% [x;y]
T=[-sin(theta) -cos(theta); cos(theta) -sin(theta)];
kt=1000;
kn=10;


cx=model.cx;
cy=model.cy;
mx=1;%model.mx;
my=1;%model.my;

M=[model.mx 0; 0 model.my];
Kp=[5 0; 0 5];
Kd=[0.5 0; 0 0.5];
Ks=[10 0;0 2];

epsilon=[((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-1/2).*(xr.*((-1).*y+yc)+xc.*(y+( ...
  -1).*yr)+x.*((-1).*yc+yr)),(-1).*r0+((x+(-1).*xc).^2+(y+(-1).*yc).^2).^( ...
  1/2)].';

epsilond=[((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-3/2).*(xc.^2.*(xd.*y+(-1).*xrd.*y+ ...
  (-1).*xd.*yc+xrd.*yc+(-1).*xr.*yd)+(-1).*(y+(-1).*yc).^2.*(xrd.*y+xd.* ...
  yc+(-1).*xrd.*yc+(-1).*xd.*yr)+xc.^3.*(yd+(-1).*yrd)+x.^3.*yrd+x.^2.*( ...
  xrd.*((-1).*y+yc)+xc.*yd+(-1).*xr.*yd+(-3).*xc.*yrd)+(-1).*xc.*(y+(-1).* ...
  yc).*(xd.*xr+yc.*yd+(-1).*yd.*yr+y.*yrd+(-1).*yc.*yrd)+x.*(xc.*((-1).* ...
  xd.*y+2.*xrd.*y+xd.*yc+(-2).*xrd.*yc+2.*xr.*yd)+xc.^2.*((-2).*yd+3.*yrd) ...
  +(y+(-1).*yc).*(xd.*xr+yc.*yd+(-1).*yd.*yr+y.*yrd+(-1).*yc.*yrd))),((x+( ...
  -1).*xc).^2+(y+(-1).*yc).^2).^(-1/2).*(x.*xd+(-1).*xc.*xd+(y+(-1).*yc).* ...
  yd)].';

coeffmat=[(-1).*mx.^(-1).*((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-3/2).*(y+(-1).*yc) ...
  .*((-1).*xc.^2+x.*(xc+(-1).*xr)+xc.*xr+(y+(-1).*yc).*(yc+(-1).*yr)), ...
  my.^(-1).*(x+(-1).*xc).*((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-3/2).*((-1) ...
  .*xc.^2+x.*(xc+(-1).*xr)+xc.*xr+(y+(-1).*yc).*(yc+(-1).*yr));mx.^(-1).*( ...
  x+(-1).*xc).*((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-1/2),my.^(-1).*((x+( ...
  -1).*xc).^2+(y+(-1).*yc).^2).^(-1/2).*(y+(-1).*yc)];

rem=[mx.^(-1).*my.^(-1).*((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-5/2).*(cx.* ...
  my.*xd.*(x.^2+(-2).*x.*xc+xc.^2+(y+(-1).*yc).^2).*(y+(-1).*yc).*((-1).* ...
  xc.^2+x.*(xc+(-1).*xr)+xc.*xr+(y+(-1).*yc).*(yc+(-1).*yr))+mx.*((-1).* ...
  cy.*(x+(-1).*xc).*(x.^2+(-2).*x.*xc+xc.^2+(y+(-1).*yc).^2).*yd.*((-1).* ...
  xc.^2+x.*(xc+(-1).*xr)+xc.*xr+(y+(-1).*yc).*(yc+(-1).*yr))+my.*(xc.^4.*( ...
  xrdd.*((-1).*y+yc)+2.*(xd+(-1).*xrd).*yd)+(y+(-1).*yc).^3.*(xd.^2.*xr+( ...
  -1).*xrdd.*(y+(-1).*yc).^2+2.*xd.*((-1).*yd.*yr+yc.*(yd+(-1).*yrd)+y.* ...
  yrd))+(-1).*xc.^2.*(y+(-1).*yc).*(2.*xd.^2.*xr+2.*xrdd.*(y+(-1).*yc).^2+ ...
  yd.*(2.*xrd.*y+(-2).*xrd.*yc+(-3).*xr.*yd)+2.*xd.*(2.*y.*yd+(-2).*yd.* ...
  yr+(-1).*y.*yrd+yc.*yrd))+x.^5.*yrdd+(-1).*xc.^5.*yrdd+(-1).*x.^4.*( ...
  xrdd.*(y+(-1).*yc)+2.*xrd.*yd+5.*xc.*yrdd)+x.^3.*(yc.*yd.^2+2.*xd.*( ...
  xrd.*(y+(-1).*yc)+((-1).*xc+xr).*yd)+4.*xc.*(xrdd.*y+(-1).*xrdd.*yc+2.* ...
  xrd.*yd)+(-1).*yd.^2.*yr+(-2).*y.*yd.*yrd+2.*yc.*yd.*yrd+10.*xc.^2.* ...
  yrdd+2.*y.^2.*yrdd+(-4).*y.*yc.*yrdd+2.*yc.^2.*yrdd)+(-1).*xc.*(y+(-1).* ...
  yc).^2.*(2.*xd.*(xrd.*(y+(-1).*yc)+(-2).*xr.*yd)+xd.^2.*(y+2.*yc+(-3).* ...
  yr)+2.*yd.^2.*yr+(-2).*y.*yd.*yrd+y.^2.*yrdd+yc.^2.*yrdd+(-2).*yc.*( ...
  yd.^2+(-1).*yd.*yrd+y.*yrdd))+xc.^3.*(2.*xd.^2.*(y+(-1).*yc)+2.*yc.* ...
  yd.^2+(-2).*xd.*(xrd.*(y+(-1).*yc)+xr.*yd)+yd.^2.*yr+(-2).*yc.*yd.*yrd+( ...
  -2).*y.^2.*yrdd+(-2).*yc.^2.*yrdd+y.*((-3).*yd.^2+2.*yd.*yrd+4.*yc.* ...
  yrdd))+x.*(xc.^3.*(4.*xrdd.*(y+(-1).*yc)+(-6).*xd.*yd+8.*xrd.*yd)+2.* ...
  xc.*(y+(-1).*yc).*(2.*xd.^2.*xr+2.*xrdd.*(y+(-1).*yc).^2+yd.*(2.*xrd.*( ...
  y+(-1).*yc)+(-3).*xr.*yd)+2.*xd.*((-2).*yd.*yr+y.*(yd+(-1).*yrd)+yc.*( ...
  yd+yrd)))+5.*xc.^4.*yrdd+(y+(-1).*yc).^2.*(2.*xd.*(xrd.*(y+(-1).*yc)+( ...
  -2).*xr.*yd)+3.*xd.^2.*(yc+(-1).*yr)+2.*yd.^2.*yr+(-2).*y.*yd.*yrd+ ...
  y.^2.*yrdd+yc.^2.*yrdd+(-2).*yc.*(yd.^2+(-1).*yd.*yrd+y.*yrdd))+xc.^2.*( ...
  (-4).*xd.^2.*(y+(-1).*yc)+(-3).*yc.*yd.^2+6.*xd.*(xrd.*(y+(-1).*yc)+xr.* ...
  yd)+(-3).*yd.^2.*yr+6.*yc.*yd.*yrd+6.*y.^2.*yrdd+6.*yc.^2.*yrdd+6.*y.*( ...
  yd.^2+(-1).*yd.*yrd+(-2).*yc.*yrdd)))+(-1).*x.^2.*(6.*xc.^2.*(xrdd.*y+( ...
  -1).*xrdd.*yc+(-1).*xd.*yd+2.*xrd.*yd)+(y+(-1).*yc).*(2.*xd.^2.*xr+2.* ...
  xrdd.*(y+(-1).*yc).^2+yd.*(2.*xrd.*y+(-2).*xrd.*yc+(-3).*xr.*yd)+2.*xd.* ...
  ((-2).*yd.*yr+(-1).*y.*yrd+yc.*(2.*yd+yrd)))+10.*xc.^3.*yrdd+xc.*((-2).* ...
  xd.^2.*(y+(-1).*yc)+6.*xd.*(xrd.*(y+(-1).*yc)+xr.*yd)+3.*((-1).*yd.^2.* ...
  yr+2.*yc.*yd.*yrd+2.*y.^2.*yrdd+2.*yc.^2.*yrdd+y.*(yd.^2+(-2).*yd.*yrd+( ...
  -4).*yc.*yrdd))))))),mx.^(-1).*my.^(-1).*((x+(-1).*xc).^2+(y+(-1).*yc) ...
  .^2).^(-3/2).*((-1).*cx.*my.*(x+(-1).*xc).*xd.*(x.^2+(-2).*x.*xc+xc.^2+( ...
  y+(-1).*yc).^2)+mx.*((-1).*cy.*(x.^2+(-2).*x.*xc+xc.^2+(y+(-1).*yc).^2) ...
  .*(y+(-1).*yc).*yd+my.*(xd.*(y+(-1).*yc)+((-1).*x+xc).*yd).^2))].';

% res=inv(coeffmat)*(inv(Kd)*(-inv(eye(2))*Ks*(Kp*epsilon+Kd*epsilond)-Kp*epsilond)-rem);
S=Kp*epsilon+Kd*epsilond;
delta=eye(2)-[model.mx 0; 0 model.my]*inv([mx 0; 0 my]);
res=S.'*(-Ks*S-Kd*coeffmat*delta*inv(coeffmat)*Ks*S+Kd*coeffmat*delta*inv(coeffmat)*rem);
U=inv(coeffmat)*(inv(Kd)*(-inv(eye(2))*Ks*(Kp*epsilon+Kd*epsilond)-Kp*epsilond)-rem);
Keff=dot(U,[-cos(theta);-sin(theta)])/epsilonn;