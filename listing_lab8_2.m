close all;
%% Generate the random signal
ek = randn(1000,1);
vk_arima = filter([1 0.3],[1 -1.51 0.97*0.54],ek);

%% Plot the series
plot(vk_arima); grid on;
title('White-noise input');

% Plot the ACF & PACF
figure; autocorr(vk_arima,20,1);
figure; parcorr(vk_arima,20,1);

%% Estimate an AR(3) model for the original series
modar_vk = ar(vk_arima,3,'ls');
figure; resid(modar_vk,vk_arima);	% ACF of  residuals 

% Difference the series, plot its ACF and PACF
vkd = diff(vk_arima);
figure; plot(vkd);
title('Series difference');
figure; autocorr(vkd,20,1);
title('ACF of series difference');

% Estimate an ARMA(1,1) model for the differenced series
modarma_vkd = armax(vkd,[1 1]); present(modarma_vkd)
figure; resid(modarma_vkd,vkd);	% ACF of  residuals 
title('Residuals of ARMA(1,1) model for the differenced series');

% Estimate an AR(2) model for the differenced series
modar_vkd = ar(vkd,2); present(modar_vkd)
figure; resid(modar_vkd,vkd);	% ACF of  residuals 
title('Residuals of AR(2) model for the differenced series');