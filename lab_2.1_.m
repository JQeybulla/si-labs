mod_p = idpoly(1,[0 0.6 -0.2], 1, 1, [1 -0.5],'Noisevariance',1);

uk = idinput(1275,'prbs',[0 1/5],[-1 1]);
xk = sim(mod_p,uk); mod_p.Noisevariance = var(xk)/10;
yk = sim(mod_p,uk,simOptions('AddNoise',true));
%% Collect the input-output data
Z = iddata(yk,uk,1); Ztrain = detrend(Z,0);

% Estimation of FIR model
mod_fir = impulseest(detrend(Ztrain,0));
[irest,kvec,~,sd_ir] = impulse(mod_fir,10);
figure; stem(kvec,irest); hold on
plot(kvec,sd_ir,'k--',kvec,-sd_ir,'g--');

% Compute the true values of FIR and plot them
ir_act = filter([0 0.6 -0.2],[1 -0.5],[1 zeros(1,9)]);
stem((0:9),ir_act,'ro','filled');

% Estimation of step-response model
[stepres,kvec] = step(mod_fir,15);
figure; plot(kvec,stepres,'b-');

% Compute the true values of step-response and plot them
sr_act = filter([0 0.6 -0.2],[1 -0.5],ones(15,1));
plot((0:14),sr_act,'r--');
plot((0:14),sr_act,'ro','MarkerFaceColor','red');

