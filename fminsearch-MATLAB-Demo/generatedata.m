% synthetic_logistic_data.m
% generalized logistic: dx/dt = lambda*x*(1 - (x/theta)^alpha)

theta  = 100;
lambda = 0.6;
alpha  = 1.2;      % set to 1 for classical logistic
x0     = 2;

t_data = linspace(0, 10, 40).';

f = @(tt,xx) lambda .* xx .* (1 - (xx./theta).^alpha);

[~, x_clean] = ode45(f, t_data, x0);

rng(7);                 % remove or change for different noise
noise_std = 2;
x_data   = x_clean + noise_std * randn(size(x_clean));

plot(t_dat,x_dat)
save('synthetic_logistic_data.mat', 'x_data', 't_data');     