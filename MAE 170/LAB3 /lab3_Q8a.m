
input_freq = [300 370 400 450 470 600 720];
max_Arduino_freq = [305.626 376.181 406.427 458.194 477.968  425.586 303.523];
max_Oscope_freq = [300 366.6667 400 450 466.6667 600 716.667];

figure(1)
scatter(input_freq, max_Arduino_freq, 'ob', 'filled')
hold on
scatter(input_freq, max_Oscope_freq, 'or', 'filled')
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Inputted frequency [Hz]')
ylabel('Identified frequency [Hz]');
xlim([250 750])
ylim([250 750])
grid on
title("Q8a Identified Frequency vs Inputted Frequency")
legend ("Identified Arduino Frequency", "Identified Oscilloscope Frequency", 'Location','northwest' )
hold off

for i = 1:length(input_freq)
    N=0;
    if input_freq(i) > f_SAMP/2
        N = 1;
    end
    predict_alias(i) = abs(input_freq(i) - N*f_SAMP);
end    

figure(2)
hold all
plot(input_freq, max_Arduino_freq, 'b--o','LineWidth',1,'MarkerSize',6)
plot(input_freq, max_Oscope_freq, 'r--o','LineWidth',1,'MarkerSize',6)
plot(input_freq, predict_alias, 'g--o','LineWidth',1,'MarkerSize',6)
xline(f_nyquist, '-k', 'LineWidth', 3);
legend ("Identified Arduino Frequency", "Identified Oscilloscope Frequency", "Predicted Aliasing","Nyquist Frequency",'Location','northwest')
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Inputted frequency [Hz]')
xlim([250 750])
ylim([250 750])
grid on
title("Q8b Identified Frequency vs Inputted Frequency")
ylabel('Identified frequency [Hz]');