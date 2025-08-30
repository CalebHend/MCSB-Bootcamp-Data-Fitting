% Will fit the generalized logistic growth equation to loaded data. 
% First load synthetic_logistic_data.mat, then run the code. 
[phat, xfit] = fit_logistic_fminsearch(t_data, x_data);
plot(t_data, x_data, 'o', t_data, xfit, '-'); grid on;
ylabel('x(t)')
xlabel('t')
% parameter value outputs
phat
