clear
clc
close all

%% Tobit model MLE

global positive
global negative

% Generate data
beta_DGP = 0.25;
datapoint = 20000;
sigma = 1;
x_i = normrnd(1, 1, [1, datapoint])';
epsilon_i = normrnd(0, sigma, [1, datapoint])';

y_i = x_i * beta_DGP + epsilon_i;
z_i = y_i;
z_i(z_i<0)=0;

% partition data
yixi_matrix = [y_i x_i];

y_positive = y_i(y_i > 0);
x_positive = x_i(y_i > 0);
positive = [y_positive, x_positive];

y_negative = y_i(y_i <= 0);
x_negative = x_i(y_i <= 0);
negative = [y_negative, x_negative];

options = optimset('MaxFunEvals', 10000);
[beta_MLE,~,~,~,~,neghesMLE] = fminunc(@MLE, [-10, 10], options);
beta_se = sqrt(diag(inv(neghesMLE)));

%% Tobit model Gibbs Sampler
p = 1;
n = datapoint;
X = x_i;

LB = -inf(n,1);
LB(y_i > 0) = 0;
UB = zeros(n, 1);
UB(y_i > 0) = inf;

sig_square = 1;
delta_0 = 2;
nu_0 = 2;

maxiter = 6000; 
burn = 1000;
postsize = maxiter - burn;
betas = NaN(p, postsize);
Bpre = 10 * eye(p);
bpre = zeros(p, 1);
sigmas = NaN(p, postsize);
z = zeros(n,1);

beta = 1;
Bpost = inv(inv(Bpre) + X' * X);

for iter = 1:maxiter
    z_i = y_i;
    GGG = norminv(...
        unifrnd(...
        normcdf(LB , X * beta, sig_square*ones(n,1)), ...
        normcdf(UB , X * beta, sig_square*ones(n,1))), ...
        X * beta, sig_square*ones(n,1));
    
    z_i(y_i == 0) = GGG(y_i == 0) ;
    e = z_i - X * beta;
    sig_square = iwishrnd(delta_0 + e' * e, nu_0 + n);
    bpost = Bpost * (Bpre\bpre + X' * z_i/sig_square);
    beta = mvnrnd(bpost, Bpost)';
    Bpost = inv(inv(Bpre) + X' * X/sig_square);
    
    if iter > burn
        betas(:, iter-burn) = beta;
        sigmas(:,iter-burn) = sig_square;
    end
end

figure; 
plot(betas'); % trace plot
beta_mean = mean(betas, 2);
beta_std = std(betas, [], 2);

figure;
plot(sigmas'); % trace plot
sigma_mean = mean(sigmas, 2);
sigma_std = std(sigmas, [], 2);