
input_freq = [300 370 400 450 470 600 720];
max_Arduino_freq = [305.626 376.181 406.427 458.194 477.968  425.586 303.523];
max_Oscope_freq = [300 366.6667 400 450 466.6667 600 716.667];

figure(1)
scatter(input_freq, max_Arduino_freq, 'ob', 'filled')
hold on
scatter(input_freq, max_Oscope_freq, 'or', 'filled')
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Inputted frequency [Hz]')
xlim([250 750])
ylim([250 750])
grid on
title("Q8a Identified Frequency vs Inputted Frequency")
legend ("Identified Arduino Frequency", "Identified Oscilloscope Frequency", 'Location','northwest' )
ylabel('Identified frequency [Hz]');

% figure(1)
% plot(input_freq, max_Arduino_freq, '-ob','LineWidth',1,'MarkerSize',6)
% hold on
% plot(input_freq, max_Oscope_freq, '-or','LineWidth',1,'MarkerSize',6)
% %     '-ob','LineWidth',2,'MarkerSize',4);
% set(gca,'FontSize',16,'LineWidth',2);
% xlabel('Inputed frequency [Hz]')
% xlim([250 750])
% ylim([250 750])
% grid on
% legend ("Indentified Arduino Frequency", "Indentified Oscilloscope Frequency", 'Location','northwest' )
% ylabel('Indentified frequency [Hz]');