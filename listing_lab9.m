close all
%% Generate the measurement
kvec = (0:499)';
vk = sin(2*pi*0.1*kvec) + sin(2*pi*0.25*kvec) + 2.25.*randn(500,1);
figure,plot(vk); grid on;
xlabel('Series');
ylabel('Amplitude');
title('Generated signal');
%% Compute periodogram
N = length(vk);
[Pxx,wvec] = periodogram(vk-mean(vk),[],N,1);
figure; plot(wvec,Pxx/sum(Pxx));
title('Periodogram');
xlabel('Frequency (cycles/sample)');
ylabel('Spectral density');

% Take Fourier Transform
vkf = fft(vk);
magvkf = abs(vkf(1:end/2)); phasevk = phase(vkf(1:end/2));

%% Estimate the signal
% Zero out the contributions (assumed to be) due to noise
magvkf2 = zeros(length(magvkf),1);
magvkf2(50:52) = magvkf(50:52); 
magvkf2(125:127) = magvkf(125:127);
vkfmod = magvkf2.*exp(i*phasevk);
vkfmod2 = [vkfmod ; 0 ; flipud(conj(vkfmod(2:end)))];
% Estimate the signal
vkhat = ifft(vkfmod2);

%% Plot against the true deterministic signal
xk = sin(2*pi*0.1*kvec) + sin(2*pi*0.25*kvec);
figure; plot((0:99),xk(1:100),'r-',(0:99),vkhat(1:100),'b--');
xlabel('Series');
ylabel('Amplitude');
legend('True','Estimated');
