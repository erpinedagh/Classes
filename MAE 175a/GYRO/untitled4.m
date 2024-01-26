t = Experiment12000mV(:,1)
y = Experiment12000mV(:,3)
velocity = diff(y)/t(2)
plot(t(1:end-1), velocity)

%% [P,S] = poyfit(t(:,1))

% Use Sample 40 as desired linear section to calc Knew and BetaNew
U2 = 1; % U = Step input = 1
yinf = min(velocity);
acc = diff(velocity)/t(2);
plot(t(1:end-2), acc)
%% 

K2 = (1/U2)*velocity(40);
K3 = (1/U2)*acc(1);
Beta2 = (K2/yinf)*U2;
Beta3 = (K3/yinf)*U2;