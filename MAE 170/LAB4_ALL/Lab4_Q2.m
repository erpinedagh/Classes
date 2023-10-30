%%%%%%%%%%% Q2 %%%%%%%%%%%%%%
norm_transfer_vec = ((transfer_vec.^(-2))-1).^(1/2);
norm_f_vec = f_vec.*(2*pi);
y = norm_transfer_vec;
x = norm_f_vec;
%%MAKE EXPECTED DATA
expctdRC = 0.010;
expectTF_vec = (1+(norm_f_vec.*expctdRC).^2).^(-0.5);

%%CREATE PLOT
figure(6)
hold on
scatter(f_vec,transfer_vec, 'k', 'LineWidth', 2)
plot(f_vec, expectTF_vec, '-r','LineWidth', 2)
grid on
yline(0.707, '--gr', 'LineWidth', 2);
xline(15.92, '--bl', 'LineWidth', 2);
xline(18, '--mag', 'LineWidth', 2);
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Frequency [Hz]')
ylabel('Gain [Amplitude]');
title("Gain vs Frequency");
legend("Experimental Data", "Expected Gain", "Gain at Half Power", "Expected Cutoff Freq","Identified Cutoff Freq", 'Location','northeast')
hold off
 
