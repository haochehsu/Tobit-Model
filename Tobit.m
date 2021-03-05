clear
clc
close all

% DGP

n = 400; % sample size
T = 5; % each indicidual's time points
k = 5;
q = 1;

beta = (1:k)';
sigma = 1;
D = eye(q);
X = cell(n, 1);
W = cell(n, 1);
b = cell(n, 1);
y = cell(n, 1);

for i = 1:n
    X{i} = [ones(T, 1) mvnrnd(ones(1, k-1), eye(k-1), T)];
    W{i} = X{i}(:, 1:q); % Wi a subset of Xi (Wi is in Xi)
    b{i} = mvnrnd(zeros(1, 1), D)';
    y{i} = X{i} * beta + W{i} * b{i} + mvnrnd(0, sigma, T);
end

%% Fixed effect estimation by OLS
ybar= zeros(n);
xbar= zeros(n, T);

for j =1:n
    ybar(j) = mean(y{j});
    xbar(j, :) = mean(cell2mat(X(j)), 1);
end
for i = 1:n
    ystar{i, 1} = y{i} - ybar(j);
    xstar{i, 1} = X{i} - xbar(j);
end

for i = 1:n
    temp_y = cell2mat(ystar(i, 1));
    temp_x = cell2mat(xstar(i, 1));
    for j = 1:T
        ystar_stack((i - 1) * T + j, :) = temp_y(j, :);
        xstar_stack((i - 1) * T + j, :) = temp_x(j, :);
    end
end
xstar_stack = xstar_stack(:, 2:5);
beta_hat = (xstar_stack' * xstar_stack)^(-1) * xstar_stack' * ystar_stack;

%% Random effect estimation by MLE

global yi_stack
global Xi_stack
global Wi_stack

for i = 1:n
    temp_yi = cell2mat(y(i, 1));
    temp_Xi = cell2mat(X(i, 1));
    temp_Wi = cell2mat(W(i, 1));
    for j = 1:T
        yi_stack((i - 1) * T + j, :) = temp_yi(j, :);
        Xi_stack((i - 1) * T + j, :) = temp_Xi(j, :);
        Wi_stack((i - 1) * T + j, :) = temp_Wi(j, :);
    end
end

options = optimset('MaxFunEvals', 10000);
[beta_MLE_panelData,~,~,~,~,neghesMLE_panelData] = fminunc(...
    @MLE_panelData, [1.1, 2.1, 3.1, 4.1, 5.1, 1.1, 1.1], options);
beta_se_panelData = sqrt(diag(inv(neghesMLE_panelData)));

%% Random effect estimation by MCMC

% Gibbs

maxiter = 6000; 
burn = 1000;
post = maxiter - burn;
B0 = 100*eye(k);
invB0 = inv(B0);
b0 = zeros(k,1);
d0 = q + 2;
D0 = eye(q)/100;
nu0 = 2;
delta0 = 2;
betas = NaN(k,post);
sig2s = NaN(1,post);
Ds = NaN(q,post);
D = eye(q);
invD = inv(D);
sig2 = 1;
beta = b0;

for iter = 1:maxiter
    
    temp1 = 0; 
    temp2 = 0; 
    temp3 = 0; 
    temp4 = 0;
    
    for i = 1:n
        Bihat = inv(invD+W{i}'*W{i}/sig2); 
        Bihat = (Bihat+Bihat')/2;
        bihat = Bihat*W{i}'*(y{i}-X{i}*beta)/sig2;
        b{i} = mvnrnd(bihat,Bihat)';
        temp1 = temp1 + b{i}*b{i}';
        temp2 = temp2 + (y{i}-X{i}*beta-W{i}*b{i})'*(y{i}-X{i}*beta-W{i}*b{i});
    end
    
    D = iwishrnd(D0+temp1,d0+n); 
    invD = inv(D); 
    sig2 = iwishrnd(delta0+temp2,nu0+n*T);
    
    for i = 1:n
         temp3 = temp3 + X{i}'/(W{i}*D*W{i}'+sig2*eye(T))*X{i};
         temp4 = temp4 + X{i}'/(W{i}*D*W{i}'+sig2*eye(T))*y{i};
%        temp3 = temp3 + X{i}'*X{i}/sig2;
%        temp4 = temp4 + X{i}'*(y{i}-W{i}*b{i})/sig2;
    end
    Bhat = inv(invB0+temp3); 
    Bhat = (Bhat+Bhat')/2; 
    bhat = Bhat*(invB0*b0+temp4);
    beta = mvnrnd(bhat,Bhat)';

    if iter > burn
        betas(:,iter-burn) = beta; 
        sig2s(:,iter-burn) = sig2; 
        Ds(:,iter-burn) = D; 
    end
end

% Trace plot for beta
figure(1)
plot(betas')

figure(2)
plot(sig2s')

figure(3)
plot(Ds')

% Posterior means & sd

beta_est = mean(betas,2); sig2_est = mean(sig2s); D_est = mean(Ds);
beta_sd = std(betas,[],2); sig2_sd = std(sig2s); D_sd = std(Ds,[],3);
