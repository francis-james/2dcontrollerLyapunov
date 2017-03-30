T=[(-1).*sin(theta),cos(theta);(-1).*cos(theta),(-1).*sin(theta)];
Td=[(-1).*thetad.*cos(theta),(-1).*thetad.*sin(theta);thetad.*sin(theta),( ...
  -1).*thetad.*cos(theta)];
Tdd=[(-1).*thetadd.*cos(theta)+thetad.^2.*sin(theta),(-1).*thetad.^2.*cos( ...
  theta)+(-1).*thetadd.*sin(theta);thetad.^2.*cos(theta)+thetadd.*sin( ...
  theta),(-1).*thetadd.*cos(theta)+thetad.^2.*sin(theta)];
epsilon=[((-1).*y+yr).*cos(theta)+(x+(-1).*xr).*sin(theta),(x+(-1).*xr).*cos( ...
  theta)+(y+(-1).*yr).*sin(theta)];
epsilond=[thetad.*(x+(-1).*xr).*cos(theta)+((-1).*yd+yrd).*cos(theta)+(xd+(-1).* ...
  xrd).*sin(theta)+(-1).*thetad.*((-1).*y+yr).*sin(theta),(xd+(-1).*xrd).* ...
  cos(theta)+thetad.*(y+(-1).*yr).*cos(theta)+(-1).*thetad.*(x+(-1).*xr).* ...
  sin(theta)+(yd+(-1).*yrd).*sin(theta)];
theta=atan(x+(-1).*xc,y+(-1).*yc);
thetad=xd.*((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-1).*((-1).*y+yc)+(x+(-1).*xc).* ...
  ((x+(-1).*xc).^2+(y+(-1).*yc).^2).^(-1).*yd;
