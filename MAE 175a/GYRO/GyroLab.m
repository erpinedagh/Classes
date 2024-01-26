

x = Experiment21500mV(:,1);
y = Experiment21500mV(:,3);
coefficients(1, 1:3) = polyfit(x, y, 2);


x = Experiment51750mV(:,1);
y = Experiment51750mV(:,3);
coefficients(2, 1:3) = polyfit(x, y, 2);


x = Experiment12000mV(:,1);
y = Experiment12000mV(:,3);
coefficients(3, 1:3) = polyfit(x, y, 2);

x = Experiment42250mV(:,1);
y = Experiment42250mV(:,3);
coefficients(4, 1:3) = polyfit(x, y, 2);

x = Experiment32500mV(:,1);
y = Experiment32500mV(:,3);
dydt=diff(y)./diff(x);
coefficients(5, 1:3) = polyfit(x, y, 2);

d2y = -2 * coefficients(:,1)
U = [mean(Experiment12000mV(2:end,4)), mean(Experiment21500mV(2:end,4)), mean(Experiment32500mV(2:end,4)), mean(Experiment42250mV(2:end,4)), mean(Experiment51750mV(2:end,4)) ];

K = [d2y(1)/U(1), d2y(2)/U(2), d2y(3)/U(3), d2y(4)/U(4), d2y(5)/U(5)]