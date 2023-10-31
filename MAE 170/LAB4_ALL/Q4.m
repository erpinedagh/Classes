 %%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%

norm_transfer_vec = ((transfer_vec.^(-2))-1).^(1/2);
norm_f_vec = f_vec.*(2*pi);
expctdRC = 0.010;
expect_AmpFil_vec = 2.*(1+(norm_f_vec.*expctdRC).^2).^(-0.5);

figure(8)
hold on
scatter(f_vec,transfer_vec, 'r', 'LineWidth', 2)
plot(f_vec, expect_AmpFil_vec, '-k','LineWidth', 2)
grid on
yline(2*0.707, '--bl', 'LineWidth', 2);
xline(16.4, '-mag', 'LineWidth', 2);
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Frequency [Hz]')
ylabel('Gain [Amplitude]');
title("Gain RC Low-Pass Filter & Op. AMP");
legend("Experimental Data", "Expected Gain", "Gain at Half Power", "Cutoff Freq (16.4Hz)", 'Location','northeast')
hold off
