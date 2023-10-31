%%%%%%%%%%%% Q3 %%%%%%%%%%%%%%%%%%%%
plot(f_vec,transfer_vec,'r--o','LineWidth',2,'MarkerSize',4);
    set(gca,'FontSize',16,'LineWidth',2);    
    xlabel('Frequency [Hz]'); % x-axis label name
    ylabel('Gain [Amplitude]'); % y-axis label name
    title('Gain Op. Amp'); % set title as sampling rate
    grid on
    ylim([1.5 2.2]);
    legend("Experimental Data")
    
    