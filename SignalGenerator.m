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
totalSignal = zeros(1, approximatedNumOfSamples);%y axis to be plotted
totalTime = linspace(startingTime, endingTime, approximatedNumOfSamples);%x axis to be plotted

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
    signalType = input('Enter your choice (1-5): ');
    
    switch signalType
        case 1 %DC/unit step
            amplitude = input('Enter amplitude: ');
            regionSignal = amplitude * ones(size(t));
        case 2 %ramp
            slope = input('Enter slope: ');
            intercept = input('Enter intercept: ');
            regionSignal = slope * t + intercept;
        case 3 %polynomial
            highestPower = input('enter the highest power of the polynomial: '); 
            coefficientsArr = zeros(1, highestPower + 1);
            for j = highestPower:-1:0
                coefficientsArr(highestPower - j + 1) = input(['Enter the coefficient for t^', num2str(j), ': ']);
            end

            regionSignal = 0; 
            for it = 0:highestPower%set each coef to its required term
                regionSignal = regionSignal + coefficientsArr(highestPower - it + 1) * t.^it;
            end

        case 4 %exponential
            amplitude = input('Enter amplitude: ');
            exponent = input('Enter exponent: ');
            regionSignal = amplitude * exp(exponent * t);
        case 5 % sinusoidal 
            choice = input('Do you want "sin" or "cos"? (Enter sin/cos): ', 's'); 
            amplitude = input('Enter amplitude: ');
            frequency = input('Enter frequency: ');
            phase = input('Enter phase (in radians): ');    
            x = 2 * pi * frequency * t + phase;
    if strcmpi(choice, 'cos')%strcmp(lower(choice),'cos') gives compile error so I used strcmpi(choice,'cos')
        regionSignal = amplitude * cos(x);
    else
        %default choice be sin(x) if invalid input
        regionSignal = amplitude * sin(x);
    end
        otherwise%default case in switch
            error('invalid entry,no signal in this region');
    end
    
    totalSignal(currentIndexInLoop:currentIndexInLoop + numOfSamplesInCurrentRegion - 1) = regionSignal;
    totalTime(currentIndexInLoop:currentIndexInLoop + numOfSamplesInCurrentRegion - 1) = t;
    currentIndexInLoop = currentIndexInLoop + numOfSamplesInCurrentRegion;
end

%displaying the original signal
figure;
plot(totalTime, totalSignal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

inputChoice = 0;
while inputChoice ~= -1 %do{}while(inp!=-1)
    
    disp('choose an operation to perform on the signal:');
    disp('1- Amplitude Scaling');
    disp('2- Time Reversal');
    disp('3- Time Shift');
    disp('4- Expanding the Signal');
    disp('5- Compressing the Signal');
    disp('-1- Exit'); 
    inputChoice = input('Enter your choice (1-5, or -1 to exit): ');

    if inputChoice == -1
        break; 
    end

    switch inputChoice
        case 1 %scale the signal in y axis
            scale = input('Enter scale value: ');
            totalSignal = scale * totalSignal;
        case 2 %time axis reversed
            totalTime = -totalTime;
        case 3 %shift in time axis
            shift = input('Enter shift value: ');
            totalTime = totalTime + shift;
        case 4 %expand time axis
            expand = input('Enter expanding value: ');
            totalTime = totalTime * expand;
        case 5 %expand time axis
            compress = input('Enter compressing value: ');
            totalTime = totalTime / compress;
        otherwise
            disp('invalid choice,please enter a valid option.');
            continue; 
    end

    figure;
    plot(totalTime, totalSignal);
    title('Modified Signal');
    xlabel('Time');
    ylabel('Amplitude');
    grid on;
end

