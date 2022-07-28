B = [0 1 0.5]
A = [1 -1.5 0.7]
D =  [1 -1 0.2]

% Define a model with a set of given coefficients
m0 = idpoly(A, B, [1 -1 0.2], 'Ts', 0.25, 'variable', 'q^-1')

% Simulate the model. Generate an input signal u and simulate
% the response of a model to these inputs
prevRng = rng(12, 'v5normal')
u = idinput(350, 'rbs')
u = iddata([], u, 0.25)
y = sim(m0, u, 'noise')

rng(prevRng)

z = [y, u]

% Plot the first 100 values of the input u and output y. Use the plot command on the iddata
% object.
plot(z(1:100))

ze = z(1:200)
zv = z(201:350)


% On base of obtained simulated data, estimate models and make comparisons. Perform
% Spectral Analysis. Using bodeplot command plot frequency response of system.
GS = spa(ze)
h = bodeplot(GS)
showConfidence(h, 3)

% Estimate Parametric State Space Models
m = ssest(ze)
bodeplot(m, GS)

% Estimate Simple Transfer Function. Compare the Performance of Estimated Models
mft = tfest(ze, 2, 2)
mx = arx(ze, [2 2 1])
compare(zv, m, mft, mx)

md1 = tfest(ze, 2, 2, 'Ts', 0.25)
md2 = oe(ze, [2 2 1])
compare(zv, md1, md2)

% Calculate residuals in time and frequency domains
resid(zv, md2)