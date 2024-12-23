fs =1000;
ts=1/fs;
t = linspace(-6000, 6000, fs*12000);
x=(10^-3)*t;
mt = (sin(x)./x).^2;
ft = (ts)*fftshift(fft(mt));
n=length(mt);
frequencies = (-n/2:(n/2-1))*(fs/n);
w=2*pi*frequencies;

figure;
subplot(2, 1, 1);
plot(t, mt);
grid on;
xlabel('t');
ylabel('m(t)');
title('Time Domain');
subplot(2, 1, 2);
plot(w, abs(ft));
xlim([-0.004 0.004]);
grid on;
xlabel('Frequency (rad/sec)');
ylabel('|M(f)|');
title('Fourier Transform');


fs =50;
ts=1/fs;
t = linspace(-10000, 10000, fs*20000);
x=(10^-3)*t;
mt = (sin(x)./x).^2;
y=2*pi*(10^5)*t;
rt=mt.*cos(y);
n=length(rt);
ft = (ts)*fftshift(fft(rt));
frequencies = (-n/2:(n/2-1))*(fs/n);
w=2*frequencies*pi;
figure;
subplot(2, 1, 1);
plot(t, rt);
grid on;
xlabel('t');
ylabel('m(t)');
title('Time Domain');
subplot(2, 1, 2);
plot(w, abs(ft));
xlim([-1,1]);
grid on;
xlabel('Frequency (rad/sec)');
ylabel('|M(f)|');
title('Fourier Transform');
