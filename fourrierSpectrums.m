To = pi;%% periodic time
Wo = 2*pi/To;
n = linspace(-4, 4, 9);
an = (0.6 ./ (1 + (4 * n .^ 2)));
%The .^ operator ensures element-wise squaring of 𝑛, and the ./ operator ensures element-wise division.
bn = 0.6 * (2 * n ./ (1 + 4 * n .^ 2));
cn = ((an .^ 2 + bn .^ 2) .^ (1/2));
theta = atan(-2 * n);%tan inverse
figure;
subplot(2,1,1)
stem(n , abs(cn))%discrete plot 

subplot(2,1,2)
stem(n , theta)


