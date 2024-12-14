t=linspace(-5e3,5e3,1e4);
fs = 1/(t(2) - t(1)); 
mt = sinc(10^(-3) * t).^2;
M_w = fftshift(fft(mt));
frequencies = linspace(-fs/2, fs/2, length(M_w)); 

figure;

subplot(2, 1, 1);
plot(t, mt, 'LineWidth', 1.5);
grid on;
xlabel('Time (t)');
ylabel('m(t)');
title('Time-domain Signal m(t) = sinc^2(10^{-3}t)');

subplot(2, 1, 2);
plot(frequencies, abs(M_w), 'LineWidth', 1.5);
xlim([-0.01 0.01]);
grid on;
xlabel('Frequency (Hz)');
ylabel('|M(f)|');
title('Fourier Transform of m(t)');

%b
fs = 1e6;
t = -5e-3:1/fs:5e-3;

m_t = sinc(1000 * t);

f_c = 1e5;
r_t = m_t .* cos(2 * pi * f_c * t);
figure;
subplot(2, 1, 1);
plot(t, r_t, 'b'); 
title('Time-domain Signal r(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

R_w = fftshift(fft(r_t));
f = linspace(-fs/2, fs/2, length(t));

subplot(2, 1, 2);
plot(f, abs(R_w)/max(abs(R_w)), 'r');
title('Fourier Transform of r(t)');
xlabel('Frequency (Hz)');
ylabel('Normalized Magnitude');
grid on;