close all; %close all open windows
clear all; %clear all variables
clc; %clear output screen
instrreset; % reset interface objects
%% Parameters to set
sampleT=1;%Set sampling time in seconds
% create the serial object 'dataLogger'
% you must replace the port name with the port on your machine
% you can find this through the arduino interface (tools->port)
% the baud rate must match what you selected in your serial read ...
% Ardino code
dataLogger=serialport('COM5',115200);%Connect to arduino
%% Arduino data capture
newV=0;%intialize variables
newT=0;%intialize variables
tempText=readline(dataLogger);
startV = str2double(extractBefore(tempText,','));
startT = str2double(strtrim(extractAfter(tempText,',')));
vArduino = [startV*5.0/1023];
tArduino = [0];
while newT<sampleT
tempText=readline(dataLogger);
newV=str2double(extractBefore(tempText,','))*5.0/1023;
newT=(str2double(strtrim(extractAfter(tempText,',')))-startT)/1E6;
vArduino = [vArduino newV];
tArduino = [tArduino newT];
end
clear dataLogger;%delete dataLogger variable so you can use the com port again

%% Read oscilloscope data
[vOscope,tOscope]=oscread();

function [wave,time] = oscread()

%% may need to use tmtool to scan for oscilloscope resource
buffer=2048; % buffer size
% set oscilloscope visa object
oscObj = visa('NI', 'USB0::0x1AB1::0x0588::DS1ET202003895::0');
oscObj.InputBufferSize = buffer; % Set the buffer size
fopen(oscObj) % Open oscilloscope connection
fprintf(oscObj,':wav:data?'); % Pull data from Channel 1
[data,len]=fread(oscObj,buffer); % Read data to matlab
timebase=str2double(query(oscObj,':TIMebase:SCALe?')); %get timescale
%get vertical scale and offset
verticalscale=str2double(query(oscObj,':CHANnel1:SCALe?'))
verticaloffset=str2double(query(oscObj,':CHANnel1:OFFSet?'))
wave=(125-data(12:len-1)')*verticalscale/25-verticaloffset;
% calibration determined by inspection
T=timebase*12; % calculate total time
dt=T/length(wave); % calculate time step
time=[0:dt:T-dt]; % setup time vector
fclose(oscObj); % close oscilloscope connection
delete(oscObj); % delete oscilloscope object
clear oscObj; % clear oscilloscope object
end

