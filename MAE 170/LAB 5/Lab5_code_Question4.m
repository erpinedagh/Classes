clc;
clear all;
close all;
instrreset;
warning('off','all');

%% parameters to set
f_tone = 5E3; % frequency of tone to be generated [Hz]
pointsx=30; % number of points x axis to scan
pointsy=15; % number of points y axis to scan
move=10; % distance per step (spatial resolution) [mm]
TmLong=6; % move time long [s]
TmShort=2; % move time short [s]
Navg=1; % number of averages

%% setup recording matrix, gcode initial properties, and open serial objects
s_speaker = serialport('COM7',115200); % Serialport connection
% create serial object for speaker Arduino
pause(2); % pause while serial connection established
s_move = serialport('COM51',115200);
% create serial object for Rambo Arduino
pause(2); % pause for 2 seconds while the serial object is opened

writeline(s_move,'G90'); % set movement to be in absolute coordinates
writeline(s_move,'G92 X0 Y0'); % set current position as origin
writeline(s_move,'G0 F4000'); % set move speed

% writeline(s_move,'G0 Y0 X0'); % backup line to move back to origin
% writeline(s_move,'G0 Y150 X300'); % backup line to move to nearest to speaker position

pause(5); % pause for 5 seconds while the serial object is opened


figure(01); % open a figure

x=[0:pointsx-1]*move; % create the x movement vector [mm]
y=[0:pointsy-1]*move; % create the y movement vector [mm]

%% Initialize Oscope, Acquire signal to initialize vectors
buffer=2048; % buffer size

% set oscilloscope visa object
oscObj = visa('NI', 'USB0::0x1AB1::0x0588::DS1ET201302578::INSTR');
oscObj.InputBufferSize = buffer;
fopen(oscObj);
fprintf(oscObj,':wav:data? CHAN1'); % acquire dummy signal to get time vector length

[data,len] = fread(oscObj, buffer);
wave=data(12:len-1)';
mylen=length(wave);

recMatrix_ref=zeros(mylen,pointsx,pointsy); % initialize recording matrix for sweep
recMatrix_sig=zeros(mylen,pointsx,pointsy); % initialize recording matrix for sweep

timebase=str2double(query(oscObj,':TIMebase:SCALe?')); %get timescale

%get vertical scale and offset
verticalscale1=str2double(query(oscObj,':CHANnel1:SCALe?'));
verticaloffset1=str2double(query(oscObj,':CHANnel1:OFFSet?'));

% optional channel 2 scale/offset reads - in case they are not set the same
verticalscale2=str2double(query(oscObj,':CHANnel2:SCALe?'));
verticaloffset2=str2double(query(oscObj,':CHANnel2:OFFSet?'));

T=timebase*12; % calculate total time
dt=T/mylen; % calculate time step
t=[0:dt:T-dt]; % setup time vector

%% Main loop
for i=1:pointsx
   % flip the Y-coordinate array if in an even X row (return zag)
   if mod(i,2) == 0
       j_array = flip(1:pointsy);
   else
       j_array = 1:pointsy;
   end
   for q=1:pointsy
       j = j_array(q);
       
       pause(1);
      
       % tell Rambo Arduino to move to measurement position
       writeline(s_move,...
           ['G0 Y' num2str(y(j)) ' X' num2str(x(i))]);      
       pause(TmShort);
      
       for k=1:Navg
           pause(.1*rand); % pause for random time from 0 -> 0.1 s
          
           writeline(s_speaker,int2str(f_tone)); 
    % write the signal frequency % play 10 cycle, 5 kHz tone
           pause(1);
           fprintf(oscObj,':wav:data? CHAN1'); % get data from ch1 oscilloscope
           [data_ref,l] = fread(oscObj, buffer);
           fprintf(oscObj,':wav:data? CHAN2'); % get data from ch2 oscilloscope
           [data_sig,l] = fread(oscObj, buffer);
			
	    wave_ref=(125-data_ref(12:len-1)')*verticalscale1/25-verticaloffset1;
	    wave_sig=(125-data_sig(12:len-1)')*verticalscale2/25-verticaloffset2;
			
           % measured data of running averages at each measurement location
           recMatrix_ref(:,i,j)=(recMatrix_ref(:,i,j)*(k-1)+wave_ref')/k;
           recMatrix_sig(:,i,j)=(recMatrix_sig(:,i,j)*(k-1)+wave_sig')/k;
          
           %% plotting
           subplot(311)
         
           plot(t*1e3,wave_ref/max(abs(wave_ref)),'-o',...
               t*1e3,wave_sig/max(abs(wave_sig)),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           grid on
           ylabel('amp. (A.U.)')
           ylim([-1.1 1.1])
           title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(312)
           plot(t*1e3,recMatrix_ref(:,i,j),'-o',...
               'MarkerSize',2)
           grid on
           xlabel('time (ms)')
           ylabel('amp. (V)')
           title('Average ref');
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(313) 
          
           plot(t*1e3,recMatrix_sig(:,i,j),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (V)')
           grid on
           title('Average sig');
           set(gca,'FontSize',20,'LineWidth',2)
          
           set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
           % set position of figure on screen [distance from left, top, width, height]
           set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
           drawnow;
          %%
       end
   end
end

w = waitforbuttonpress;
% move back to beginning
writeline(s_move,'G0 X0 Y0'); % tell Rambo Arduino to move back to origin
pause(TmLong);

%% save the data and close objects
fclose(oscObj);
delete(oscObj);
clear s_move;
clear s_speaker; % close the serial connection for speaker

save(['acousticscan' num2str(floor(now*1E3)) '.mat']); % save data

%% Question 3 Plotting

           figure(2);



            % plotting
           subplot(311)
           plot(t*1e3,wave_ref/max(abs(wave_ref)),'-o',...
               t*1e3,wave_sig/max(abs(wave_sig)),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (A.U.)')
           ylim([-1.1 1.1])
           title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(312)
           plot(t*1e3,recMatrix_ref(:,i,j),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (V)')
           title('Average ref');
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(313)
           plot(t*1e3,recMatrix_sig(:,i,j),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (V)')
           title('Average sig');
           set(gca,'FontSize',20,'LineWidth',2)
          
           set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
           % set position of figure on screen [distance from left, top, width, height]
           set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
           drawnow;
%% 
%% Question 2

 figure(1);
 hold on;
           plot(t*1e3,wave_sig/max(abs(wave_sig)),'-ro', 'MarkerSize',2)
           xlabel('time (ms)');
           ylabel('amp. (A.U.)');
           ylim([-1.1 1.1]);
%            title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
           set(gca,'FontSize',20,'LineWidth',2)
          
          
            plot(t*1e3,(recMatrix_sig(:,i,j)/max(abs(recMatrix_sig(:,i,j)))),'-bo','MarkerSize',2)
            plot(t*1e3,(recMatrix_sig/max(abs(recMatrix_sig))),'-bo','MarkerSize',2)
           xlabel('time (ms)');
           ylabel('amp. (V)');
%            title('Average sig');
           set(gca,'FontSize',25,'LineWidth',2);

          legend('last acquired microphone signal', 'averaged signal');

           set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
           % set position of figure on screen [distance from left, top, width, height]
           set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
           drawnow;
hold off;


%% Question 4
i = 3;
j = 1;
subplot(311)
           plot(t*1e3,wave_ref/max(abs(wave_ref)),'-o',...
               t*1e3,wave_sig/max(abs(wave_sig)),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (A.U.)')
           ylim([-1.1 1.1])
           title(['Single Acq. ' num2str(k) ', Position (' num2str(i) ',' num2str(j) ')']);
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(312)
           plot(t*1e3,recMatrix_ref(:,i,j),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (V)')
           title('Average ref');
           set(gca,'FontSize',20,'LineWidth',2)
          
           subplot(313)
           plot(t*1e3,recMatrix_sig(:,i,j),'-o',...
               'MarkerSize',2)
           xlabel('time (ms)')
           ylabel('amp. (V)')
           title('Average sig');
           set(gca,'FontSize',20,'LineWidth',2)
          
           set(gcf, 'units', 'normalized'); % set plot sizing to normalized units
           % set position of figure on screen [distance from left, top, width, height]
           set(gcf, 'Position', [0.1, 0.1, .6, 0.8]);
           drawnow;





%% Question 4 plot x position vs time delay


% manually record delta t's
timedelay = [0.00208696 0.00207692 0.00206089 0.00205686 0.00202676 0.0020669 0.00198662 0.00195652 0.00194649 0.00190635 0.00188629 0.00187625 ...
    0.00186622 0.00181605 0.00180602 0.00179599 0.00178595 0.00174582 0.00173579 0.00171572 0.00170596 ...
    0.00169565 0.00169500 0.00165552 0.00164548 0.00161538 0.00160535 0.00157525 0.00160535 0.00154515] - 0.0010034;

timedelay = fliplr(timedelay);
format long
linewidth = 2;

xpos = (1:1:30) * 0.01;
p = polyfit(xpos, timedelay, 1);
% x1 = 0:xpos;
y1 = polyval(p, xpos);

speedofsound = p(1)^(-1) / 100; %m/s

actualspeedofsound = @(x)  (1/340) * (x + 0.10);

yneg = [0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187 0.000187];
xneg = [0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025 0.0025];

figure(3)
hold on;
box on;

errorbar(xpos, timedelay, yneg, yneg ,xneg, xneg, '.', 'LineWidth', 1.5);
plot(xpos, timedelay, '-o', 'LineWidth', linewidth, 'Color', 'black', 'MarkerFaceColor','black');
plot(xpos, y1, '--', 'LineWidth', linewidth, 'Color', '#77AC30');
plot(xpos, actualspeedofsound(xpos), '-o', 'LineWidth', linewidth, 'Color', '#D95319');

legend('Error Bar', 'Data Points', 'Line of Best Fit to Data', 'Theoretical Speed of Sound Line', 'Location', 'southeast')

xlabel('X Position (m)');
ylabel('Time Delay (seconds)');
set(gca,'FontSize',25,'LineWidth',2);

str = sprintf('Line of best fit: \n y = (%f)x + %f ',p(1),p(2));
text(0.1,0.4e-3,str);
% 1222
hold off;
% xlim([0 32]);
% ylim([0 0.0015]);


%% Question 6 

figure(4);

% yval = 15; %use signals aquired at same y value on grid
index = 1; %cut off beginning of measured signal because of random spike




% normalize amplitudes
maximums = max(abs(recMatrix_sig(index:end, :, 15)));
normalizedsig = recMatrix_sig(index:end, :, 15)./maximums;


actualspeedofsound = @(x) - (1/340)*(x - 0.9);


linewidth = 2;

hold on;
box on;
pcolor(xpos, t(index:end), normalizedsig);
shading flat;
c = colorbar;
set(c,'FontSize', 20);

plot(xpos, actualspeedofsound(xpos), 'LineWidth', 1.5*linewidth, 'Color', '#D95319');

xlabel('x Position (m)');
ylabel('Time (s)');
set(gca,'FontSize',22,'LineWidth',2);

legend('', 'sound speed of air');

% xlim([1 30]);
axis([0 0.3 0 0.006]);

hold off;

%% Question 7 

figure(5);
hold on;
xpos = 1:30;
ypos = 1:15;

t_pcolor = 0.002; %s
t_index = find(t > t_pcolor);
t_index = t_index(1);


% normalize amplitudes
maximums = max(abs(recMatrix_sig(t_index, :, :)));
normalizedsig = recMatrix_sig(t_index, :, :)./maximums;

slice = zeros(30,15);
for x=1:30
    for y=1:15
        slice(x,y) = normalizedsig(1, x, y);
    end
end

% plot
linewidth = 2;

hold on
box on
pcolor(xpos, ypos, slice');
shading flat
c = colorbar;
set(c,'FontSize', 20);

xlabel('X Position (cm)');
ylabel('Y Position (cm)');
set(gca,'FontSize',22,'LineWidth',2);
% title('Time t = 2 ms');

xlim([1 30]);
ylim([1 15]);
 hold off; 


%% Question 8 

filename = 'scanning.gif';

index = 20;
t_pcolor = t(index:end);

for k=1:length(t_pcolor)

%---------------------------------------------------------------
    xpos = 1:30;
    ypos = 1:15;
    t_index = find(t==t_pcolor(k));

    % normalize amplitudes
    maximums = max(abs(recMatrix_sig(t_index, :, :)));
    normalizedsig = recMatrix_sig(t_index, :, :)./maximums;

    slice = zeros(30,15);
    for x=1:30
        for y=1:15
            slice(x,y) = normalizedsig(1, x, y);
        end
    end

    % plot
    linewidth = 2;
    
    figure(6);
    h = figure(6);
    hold on;
    box on;
    pcolor(xpos, ypos, slice');
    shading flat
    c = colorbar;
    set(c,'FontSize', 20);

    xlabel('x position (cm)');
    ylabel('y position (cm)');
   
%     string = strcat('Time = ', num2str(t(t_index)));
%     string = strcat(string, ' ms');
%     title('the spatiotemporal sound field generated by the speaker',string)
    set(gca,'FontSize',25,'LineWidth',2);
   

    xlim([1 30]);
    ylim([1 15]);
%---------------------------------------------------------------   

    caxis([-1 1]);
    pause(0.5);
    drawnow;

    frame = getframe(h); % You can either remove the argument h
    % or define a figure above, e.g., h=figure(01);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);

    % Write to the GIF File
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
