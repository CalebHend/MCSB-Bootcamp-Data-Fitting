function [phat, xfit] = fit_logistic_fminsearch(t, x)
% Minimal fit of generalized logistic ODE using fminsearch + ode45.
% Model: dx/dt = lambda * x * (1 - (x/theta)^alpha)
% Returns phat = struct(theta, lambda, alpha, x0) and xfit at times t.

t = t(:); x = x(:);
[ t, idx ] = sort(t); x = x(idx);                 % ensure increasing time

% simple positive initial guesses (log-param)
u0 = log([1.1*max(x); 1; 1; max(x(1), eps)]);     % [theta; lambda; alpha; x0]

% optimize sum of squared errors
u_hat = fminsearch(@(u) sse(u, t, x), u0, optimset('Display','off'));

% unpack, simulate final fit
p = exp(u_hat);                                   % [theta lambda alpha x0]
ode = @(tt,xx) p(2).*xx.*(1 - (xx./p(1)).^p(3));
[~, xfit] = ode45(ode, t, p(4));
xfit = xfit(:);

phat = struct('theta',p(1),'lambda',p(2),'alpha',p(3),'x0',p(4));
end

% -------- helper --------
function val = sse(u, t, x)
p = exp(u);                                       % enforce positivity
ode = @(tt,xx) p(2).*xx.*(1 - (xx./p(1)).^p(3));
try
    [~, xm] = ode45(ode, t, p(4));
    r = xm(:) - x(:);
    val = sum(r.^2);
catch
    val = Inf;                                    % if solver fails, penalize
end
end
