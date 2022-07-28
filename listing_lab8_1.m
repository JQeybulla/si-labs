% [1 1.3 0.4];
%% Generate the white-noise input
ek = randn(2000,1);
figure;plot(ek); grid on;
title('White-noise input');

%% Set up the MA(2) model coefficients
cvec = [1 1.3 0.4];

% Filter the white-noise with the MA model
vk = filter(cvec,1,ek);
figure,plot(vk);grid on;
title('White-noise input, filtered with the MA model');

% Plot the ACF
figure,autocorr(vk,20,1);

% Create the iddata object
vkdata = iddata(vk,[],1);

% Estimate the MA(2) parameters
mod_ma = armax(vkdata,'na',0,'nc',2);
present(mod_ma)
figure; resid(mod_ma,vk);	% ACF of  residuals 
