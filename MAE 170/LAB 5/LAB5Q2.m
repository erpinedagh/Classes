%%%%%%LAB5%%%Q2%%%%%%
figure(1);
 hold on;
           grid off
           plot(t*1e3,wave_sig/max(abs(wave_sig)),'-ro', 'MarkerSize',2)
           grid on
           xlabel('Time (ms)');
           ylabel('Amp. (A.U.)');
           ylim([-1.1 1.1]);
           title(["Q2 Last Signal and Averaged Signal"]);
           set(gca,'FontSize',20,'LineWidth',2)
          
          
%            plot(t*1e3,(recMatrix_sig(:,i,j)/max(abs(recMatrix_sig(:,i,j)))),'-bo','MarkerSize',2)
            plot(t*1e3,(recMatrix_sig/max(abs(recMatrix_sig))),'-bo','MarkerSize',2)
           xlabel('Time (ms)');
           ylabel('Amp. (V)');
%            title('Average sig');
           set(gca,'FontSize',25,'LineWidth',2);

          legend('Last Acquired Microphone Signal', 'Averaged Signal');

           set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
           % set position of figure on screen [distance from left, top, width, height]
           set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
           drawnow;
hold off;