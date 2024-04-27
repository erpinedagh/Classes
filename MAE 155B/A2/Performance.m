% Performance Section
% Last Update: 4/19

%% Takeoff Analysis 
% Asumptions
Fc = 0.03;  % Rolling friction coeffiecent
% Wo = ; %Gross Weight
% CL_Max = %Max Lift Coefficent
CL_TO = CL_Max * 0.8;% Takeoff Lift Coefficent
V_TO =  sqrt(2*Wo/CL_TO/rho/S); % Takeoff Speed
a_mean = g*((T-D) - Fc*(Wo-L))/Wo; %Mean Acceleration
S_g = (V_TO^2)/2/a_mean;

%% Thrust and Drag vs Airspeed (Steady Level Flight)
C_do = 0.03;    %Form Drag
e = 0.70;       %Oswald Efficiency Factor
AR = 6;         %Aspect Ratio
% C_Lift = ;    %Lift Coefficent
S = 0.5;        %Wing Area m^2
%Vo =;          %Velocity o
%To =;          %Static Thrust     
V = linspace(0,25,1000);
C_Drag = C_do + (C_Lift^2)/pi/e/AR;
q = 0.5*rho*V^2;                    %Dynamic Pressure
Drag = C_Drag*q*S;                  % DRAG ARRAY
Thrust = To*(1-V/Vo);               %Thrust Array
% figure(1)
% plot(V,Drag);
% plot(V,Thrust);


