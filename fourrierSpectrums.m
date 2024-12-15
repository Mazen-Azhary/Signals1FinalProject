t_start = 0;
t_end = pi;
n = -4:4;
j = 1i;
x = @(t) exp(-t);

Dn_val = zeros(size(n));
for k = 1:length(n)
    Dn_val(k) = (1/pi) * integral(@(t) x(t) .* exp(-2 * n(k) * t * j), t_start, t_end);
end

figure;
stem(n, abs(Dn_val));
title('Magnitude of Dn');
xlabel('n');
ylabel('|Dn|');
grid on;

figure;
stem(n, angle(Dn_val)./(pi).*(180));
title('Angle of Dn');
xlabel('n');
ylabel('Angle(Dn)');
grid on;