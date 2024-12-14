
Fs = input('enter sampling frequency: ');%sampling frequency
startingTime = input('enter the start of time axis: ');
endingTime = input('enter end of time axis: ');
numberOfBreakPoints = input('enter the number of break points: ');
breakPtsArr = zeros(1, numberOfBreakPoints);% a row vector is like an array 


for i = 1:numberOfBreakPoints%specify positions of break points which separate signals regions
    %fprintf('enter the position of break point ' num2str(i) ': ');
    breakPtsArr(i) = input(['enter the position of break point ' num2str(i) ': ']);
end

breakPtsArr = [startingTime, sort(breakPtsArr), endingTime]; 

approximatedNumOfSamples = round(Fs * (endingTime - startingTime));
signal = zeros(1, approximatedNumOfSamples);%y axis to be plotted
time = linspace(startingTime, endingTime, approximatedNumOfSamples);%x axis to be plotted

currentIndexInLoop = 1;

for i = 1:length(breakPtsArr)-1
    % Determine the number of samples for the current region
    numOfSamplesInCurrentRegion = round(Fs * (breakPtsArr(i+1) - breakPtsArr(i)));
    t = linspace(breakPtsArr(i), breakPtsArr(i+1), numOfSamplesInCurrentRegion);
    %fprintf('hi');
    fprintf('interval %d: Time [%g, %g]\n', i, breakPtsArr(i), breakPtsArr(i+1));
    
    disp('Choose signal type for this region:');
    disp('1. DC signal');
    disp('2. Ramp signal');
    disp('3. General order polynomial');
    disp('4. Exponential signal');
    disp('5. Sinusoidal signal');
    signal_type = input('Enter your choice (1-5): ');
    
    switch signal_type
        case 1 % DC signal
            amplitude = input('Enter amplitude: ');
            region_signal = amplitude * ones(size(t));
        case 2 % Ramp signal
            slope = input('Enter slope: ');
            intercept = input('Enter intercept: ');
            region_signal = slope * t + intercept;
        case 3 % General order polynomial
            amplitude = input('Enter amplitude: ');
            power = input('Enter power: ');
            intercept = input('Enter intercept: ');
            region_signal = amplitude * t.^power + intercept;
        case 4 % Exponential signal
            amplitude = input('Enter amplitude: ');
            exponent = input('Enter exponent: ');
            region_signal = amplitude * exp(exponent * t);
        case 5 % Sinusoidal signal
            amplitude = input('Enter amplitude: ');
            frequency = input('Enter frequency: ');
            phase = input('Enter phase (in radians): ');
            region_signal = amplitude * sin(2 * pi * frequency * t + phase);
        otherwise
            error('Invalid choice!');
    end
    
    signal(currentIndexInLoop:currentIndexInLoop + numOfSamplesInCurrentRegion - 1) = region_signal;
    time(currentIndexInLoop:currentIndexInLoop + numOfSamplesInCurrentRegion - 1) = t;
    currentIndexInLoop = currentIndexInLoop + numOfSamplesInCurrentRegion;
end

%displaying the original signal
figure;
plot(time, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%modifying the signal
disp('Choose an operation to perform on the signal:');
disp('1- Amplitude Scaling');
disp('2- Time Reversal');
disp('3- Time Shift');
disp('4- Expanding the Signal');
disp('5- Compressing the Signal');
operation = input('Enter your choice (1-6): ');

switch operation
    case 1 
        scale = input('Enter scale value: ');
        signal = scale * signal;
    case 2 
        time = -time;
    case 3 
        shift = input('Enter shift value: ');
        time = time + shift;
    case 4 
        expand = input('Enter expanding value: ');
        time = time * expand;
    case 5 
        compress = input('Enter compressing value: ');
        time = time / compress;
    otherwise
        error('invalid choice');
end
%displaying the signal after modifications
figure;
plot(time, signal);
title('Modified Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
