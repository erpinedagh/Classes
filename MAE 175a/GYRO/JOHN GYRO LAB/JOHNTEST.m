%%JOHN TEST

x = Trail3Gyro1500mV(:,1);
y = Trail3Gyro1500mV(:,3);
coefficients(1, 1:3) = polyfit(x, y, 2);

x = Trail4Gyro1700mV(:,1);
y = Trail4Gyro1700mV(:,3);
coefficients(2, 1:3) = polyfit(x, y, 2);

x = Trial12000mV(:,1);
y = Trial12000mV(:,3);
coefficients(3, 1:3) = polyfit(x, y, 2);

x = Trail5Gyro2300mV(:,1);
y = Trail5Gyro2300mV(:,3);
coefficients(4, 1:3) = polyfit(x, y, 2);


x = Trail2Gyro2500mV(:,1);
y = Trail2Gyro2500mV(:,3);
coefficients(5, 1:3) = polyfit(x, y, 2);

d2y = -2 * coefficients(:,1)
U = [mean(Experiment12000mV(2:end,4)), mean(Experiment21500mV(2:end,4)), mean(Experiment32500mV(2:end,4)), mean(Experiment42250mV(2:end,4)), mean(Experiment51750mV(2:end,4)) ];

K = [d2y(1)/U(1), d2y(2)/U(2), d2y(3)/U(3), d2y(4)/U(4), d2y(5)/U(5)]