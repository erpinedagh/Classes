clc 
clear all
close all
%% 
Ixx = 15000;
b = 11.4;
S = 22.2;
rho = 1.22;
V = 53;
h = 0.05;
t = 0:h:120;
p = zeros(1,length(t));
phi = p;
phi(1) = 5*pi/180;
for i = 1:length(t)-1
    p_norm = (p(i))*b/2/V;
    Cl1 = -0.06*phi(i) + 0.033*p_norm + 0.073*p_norm^3 - 0.36*p_norm*phi(i)^2 + 1.47*p_norm^2*phi(i);
    r1 = 0.5*rho*V^2*S*b*(Cl1)/Ixx;
  
    p_norm = (p(i) + r1*h/2)*b/2/V;
    Cl2 = -0.06*phi(i) + 0.033*p_norm + 0.073*p_norm^3 - 0.36*p_norm*phi(i)^2 + 1.47*p_norm^2*phi(i);
    r2 = 0.5*rho*V^2*S*b*(Cl2)/Ixx;
    
    p_norm = (p(i) + r2*h/2)*b/2/V;
    Cl3 = -0.06*phi(i) + 0.033*p_norm + 0.073*p_norm^3 - 0.36*p_norm*phi(i)^2 + 1.47*p_norm^2*phi(i);
    r3 = 0.5*rho*V^2*S*b*(Cl3)/Ixx;
    
    p_norm = (p(i) + r3*h)*b/2/V;
    Cl4 = -0.06*phi(i) + 0.033*p_norm + 0.073*p_norm^3 - 0.36*p_norm*phi(i)^2 + 1.47*p_norm^2*phi(i);
    r4 = 0.5*rho*V^2*S*b*(Cl4)/Ixx;

    p(i+1) = p(i) + h*(r1 + 2*r2 + 2*r3 +r4)/6;

    phi(i+1) = phi(i) + h*p(i+1);
end

figure(1) 
plot(p*180/pi, phi*180/pi, 'LineWidth', 1);
title("Roll Rate vs  Roll Angle");
xlabel("Roll Rate (deg/s)");
ylabel("Roll Angle (deg)");


