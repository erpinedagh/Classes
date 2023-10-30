
norm_transfer_vec = ((transfer_vec.^(-2))-1).^(1/2);
norm_f_vec = f_vec.*(2*pi);
y = norm_transfer_vec;
x = norm_f_vec;

%%%%%%%%%%%%%Q1%%%%%%%%%%%%%%%%

coefficients = polyfit(x, y, 1);
% Create a new x axis with exactly 1000 points (or whatever you want).
xFit = linspace(min(x), max(x), 1000);
% Get the estimated yFit value for each of those 1000 new x locations.
yFit = polyval(coefficients , xFit);

% Plot everything
figure(5)
hold on
scatter(norm_f_vec, norm_transfer_vec, 'LineWidth', 3);
plot(xFit, yFit, 'r-', 'LineWidth', 2); % Plot fitted line.
set(gca,'FontSize',16,'LineWidth',2);
xlabel('Frequency [rad/s]')
ylabel('Normalized Gain [Amplitude]');
xl = xlim;
yl = ylim;
xt = 0.05 * (xl(2)-xl(1)) + xl(1);
yt = 0.75 * (yl(2)-yl(1)) + yl(1);
caption = sprintf('y = %f * x + %f', coefficients(1), coefficients(2));
text(xt, yt, caption, 'FontSize', 16, 'Color', 'r', 'FontWeight', 'bold');
grid on
title("Normalized Gain vs Frequency");
legend ("Experimental Data", "Line Best Fit", 'Location','northwest' );
hold off
