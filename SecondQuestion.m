function y = Sinc(x)
    y = ones(size(x));
    idx = x ~= 0; 
    y(idx) = sin(pi * x(idx)) ./ (pi * x(idx));
end
t = linspace(-4000, 4000, 5001);
fs = 1 / (t(2) - t(1)); 
mt = Sinc(10^(-3) * t).^2;

ft = fftshift(fft(mt)) / length(mt);
frequencies = linspace(-fs/2, fs/2, length(ft));

figure;
subplot(2, 1, 1);
plot(t, mt);
grid on;
xlabel('t');
ylabel('m(t)');
title('Time Domain');

subplot(2, 1, 2);
plot(frequencies, abs(ft));
xlim([-0.01 0.01]);
grid on;
xlabel('Frequency (Hz)');
ylabel('|M(f)|');
title('Fourier Transform');

% Define time vector
t = linspace(-0.05, 0.05, 1000);

% Define the signal r(t)
r = Sinc(10^(-3) * t).^2 .* cos(2*pi*1e5*t);

% Compute the sampling frequency
fs = 1 / (t(2) - t(1));  % Sampling frequency

% Fourier Transform and shift
ft = fftshift(fft(r)); % Fourier transform and shift

% Frequency axis
frequencies = linspace(-fs/2, fs/2, length(ft)); % Frequency axis

% Plot r(t) and its Fourier Transform
figure;

% Time domain plot
subplot(2,1,1);
plot(t, r);
title('Time Domain Signal r(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency domain plot
subplot(2,1,2);
plot(frequencies, abs(ft));
title('Magnitude of Fourier Transform of r(t)');
xlabel('Frequency (Hz)');
ylabel('|R(f)|');
grid on;