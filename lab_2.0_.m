load dryer2;
dry = iddata(y2, u2, 0.08);

get(dry);

dry.InputName = 'Heater Voltage';
dry.OutputName = 'Thermocouple Voltage';
dry.TimeUnit = 'seconds';
dry.InputUnit = 'V';
dry.OutputUnit = 'V';

ze = dry(1:300);

figure;
plot(ze(200:300));

ze = detrend(ze);
figure;
plot(ze(200:300))

clf;
mi = impulseest(ze); % non-parametric (FIR) model
showConfidence(impulseplot(mi),3); %impulse response with 3 standard
%deviations confidence region



