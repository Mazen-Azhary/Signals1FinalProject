Fs = input('enter sampling frequency: ');%sampling frequency
startingTime = input('enter the start of time axis: ');
endingTime = input('enter end of time axis: ');
numberOfBreakPoints = input('enter the number of break points: ');
break_points = zeros(1, numberOfBreakPoints);% a row vector is like an array 


for i = 1:numberOfBreakPoints%specify positions of break points which separate signals regions
    %fprintf('enter the position of break point ' num2str(i) ': ');
    break_points(i) = input(['enter the position of break point ' num2str(i) ': ']);
end

break_points = [startingTime, sort(break_points), endingTime]; % Include start and end in segments

total_samples = round(Fs * (endingTime - startingTime));
signal = zeros(1, total_samples);
time = linspace(startingTime, endingTime, total_samples);

current_index = 1;

for i = 1:length(break_points)-1
    % Determine the number of samples for the current region
    region_samples = round(Fs * (break_points(i+1) - break_points(i)));
    t = linspace(break_points(i), break_points(i+1), region_samples);
    fprintf('Region %d: Time [%g, %g]\n', i, break_points(i), break_points(i+1));
    
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
    
    % Fill the preallocated arrays
    signal(current_index:current_index + region_samples - 1) = region_signal;
    time(current_index:current_index + region_samples - 1) = t;
    
    % Update the index tracker
    current_index = current_index + region_samples;
end

% Step 3: Display Original Signal
figure;
plot(time, signal, 'b', 'LineWidth', 1.5);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Step 4: Signal Operations
disp('Choose an operation to perform on the signal:');
disp('1. Amplitude Scaling');
disp('2. Time Reversal');
disp('3. Time Shift');
disp('4. Expanding the Signal');
disp('5. Compressing the Signal');
disp('6. None');
operation = input('Enter your choice (1-6): ');

switch operation
    case 1 % Amplitude Scaling
        scale_value = input('Enter scale value: ');
        signal = scale_value * signal;
    case 2 % Time Reversal
        time = -time;
    case 3 % Time Shift
        shift_value = input('Enter shift value: ');
        time = time + shift_value;
    case 4 % Expanding the Signal
        expand_value = input('Enter expanding value: ');
        time = time * expand_value;
    case 5 % Compressing the Signal
        compress_value = input('Enter compressing value: ');
        time = time / compress_value;
    case 6 % None
        disp('No operation performed.');
    otherwise
        error('Invalid choice!');
end

% Step 5: Display Modified Signal
figure;
plot(time, signal, 'r', 'LineWidth', 1.5);
title('Modified Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
