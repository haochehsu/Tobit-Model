# Tobit-Model

I use the following data generating process:

<img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+y_i+%3D+x_i%27%5Cbeta+%2B+%5Cepsilon_i" 
alt="y_i = x_i'\beta + \epsilon_i">

where <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbeta%3D0.25" 
alt="\beta=0.25">, <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cepsilon%5Csim+N%280%2C1%29" 
alt="\epsilon\sim N(0,1)">. And <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+x_i" 
alt="x_i"> is generated from N(1,1) distribution. The observed data <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+z_i" 
alt="z_i">  is characterized by the following

<img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+z_i+%3D+%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%0Ay_i%2C+%26%5Ctext%7Bif+%7Dy_i%3E1+%5C%5C%0A0%2C+%26+%5Ctext%7Bif+%7Dy_i%5Cleq+0%0A%5Cend%7Bmatrix%7D%5Cright." 
alt="z_i = \left\{\begin{matrix}
y_i, &\text{if }y_i>1 \\
0, & \text{if }y_i\leq 0
\end{matrix}\right.">

with 20000 observations. This will generate a 40.7% censored data.

### Maximize likelihood estimation
 
<img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cln+f+%5Cleft%28z_i%7C%5Cbeta%2C+%5Csigma_2%5Cright%29%3D%5Csum_%7Bi%3D1%7D%5En+%5Cln+f%5Cleft%28z_i%7C%5Cbeta%2C+%5Csigma_2%5Cright%29%3D%5Csum_%7Bi%3Az_i%3D0%7D+%5Cln+%5CPhi%5Cleft%28-%5Cdfrac%7Bx_i%5E%7B%5Cprime%7D%5Cbeta%7D%7B%5Csigma%7D%5Cright%29%2B%5Csum_%7Bi%3Az_i%3E0%7D+%5Cln+f_N%5Cleft%28z_i%7Cx_i%5E%7B%5Cprime%7D%5Cbeta%2C+%5Csigma%5E2%5Cright%29" 
alt="\ln f \left(z_i|\beta, \sigma_2\right)=\sum_{i=1}^n \ln f\left(z_i|\beta, \sigma_2\right)=\sum_{i:z_i=0} \ln \Phi\left(-\dfrac{x_i^{\prime}\beta}{\sigma}\right)+\sum_{i:z_i>0} \ln f_N\left(z_i|x_i^{\prime}\beta, \sigma^2\right)">

The estimates are <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Chat%7B%5Cbeta%7D%3D0.2586%2C+%5C+%5C+%5C+%5Chat%7B%5Csigma%5E2%7D%3D0.9980" 
alt="\hat{\beta}=0.2586, \ \ \ \hat{\sigma^2}=0.9980"> and the standard errors of the estimators are <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+se%28%5Chat%7B%5Cbeta%7D%29%3D0.0053%2C+%5C+%5C+%5C+se%28%5Chat%7B%5Csigma%5E2%7D%29%3D0.0067" 
alt="se(\hat{\beta})=0.0053, \ \ \ se(\hat{\sigma^2})=0.0067">.

### Bayesian estimation

<img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbeta" 
alt="\beta"> and <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Csigma%5E2" 
alt="\sigma^2"> are drawn from the prior distributions

<img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0A%5Cbeta+%26%5Csim+N%28%5Cbeta_0%2C+B_0%29%5C%5C%0A%5Csigma%5E2+%26%5Csim+IW%28%5Cdelta_0%2C+%5Cnu_0%29%0A%5Cend%7Balign%2A%7D" 
alt="\begin{align*}
\beta &\sim N(\beta_0, B_0)\\
\sigma^2 &\sim IW(\delta_0, \nu_0)
\end{align*}">

where <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbeta_0+%3D+0" 
alt="\beta_0 = 0">, <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+B_0%3D10" 
alt="B_0=10">, <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cdelta_0%3D2" 
alt="\delta_0=2">, and <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cnu_0%3D2" 
alt="\nu_0=2">. Then the Gibbs sampler is initiated as follows:

1. Let <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+y_i+%5C+%5C+%5C+%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%0A%5Ctext%7Bdraw+from+%7D+%5C+%5C+%5C+%5C+TN_%7B%28-%5Cinfty%2C0%29%7D%28X%27%5Cbeta%2C+%5Csigma%5E2%29%2C+%26%5Ctext%7Bif+%7Dz_i%3D0+%5C%5C%0A%5Ctext%7Bbe+%7D+%5C+%5C+%5C+%5C+%5C+%5C+%5C+%5C+%5C+%5C+%5C+z_i%2C+%26+%5Ctext%7Bif+%7Dz_i%3E+0%0A%5Cend%7Bmatrix%7D%5Cright." 
alt="y_i \ \ \ \left\{\begin{matrix}
\text{draw from } \ \ \ \ TN_{(-\infty,0)}(X'\beta, \sigma^2), &\text{if }z_i=0 \\
\text{be } \ \ \ \ \ \ \ \ \ \ \ z_i, & \text{if }z_i> 0
\end{matrix}\right.">

2. The updating process

- <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cleft%5B%5Cbeta+%7C+z%2C+y%2C%5Csigma%5E2%5Cright%5D%5Csim+N%28%5Chat%7B%5Cbeta%7D%2C+%5Chat%7BB%7D%29++%5C+%5C+%5C+%5Ctext%7Bwhere%7D++%5C+%5C+%5C+%5C+%5Chat%7BB%7D%3D%5Cleft%28B_0%5E%7B-1%7D%2B%5Cdfrac%7BX%27X%7D%7B%5Csigma%5E2%7D%5Cright%29%5E%7B-1%7D++%5C+%5C+%5C+%5Ctext%7Band%7D+%5C+%5C+%5C+%5Chat%7B%5Cbeta%7D%3D%5Chat%7BB%7D%5Cleft%28B_0%5E%7B-1%7D%5Cbeta_0%2B%5Cdfrac%7BX%27Z%7D%7B%5Csigma%5E2%7D%5Cright%29" 
alt="\left[\beta | z, y,\sigma^2\right]\sim N(\hat{\beta}, \hat{B})  \ \ \ \text{where}  \ \ \ \ \hat{B}=\left(B_0^{-1}+\dfrac{X'X}{\sigma^2}\right)^{-1}  \ \ \ \text{and} \ \ \ \hat{\beta}=\hat{B}\left(B_0^{-1}\beta_0+\dfrac{X'Z}{\sigma^2}\right)">

- <img src=
"https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cleft%5B%5Csigma%5E2+%7C+z%2C+y%2C%5Cbeta%5Cright%5D%5Csim+IG%5Cleft%28%5Cdfrac%7B%5Cnu_0%2Bn%7D%7B2%7D%2C%5Cdfrac%7B%5Cdelta_0%2B+e%27+e%7D%7B2%7D%5Cright%29+%5C+%5C+%5C++%5Ctext%7Bwhere%7D++%5C+%5C+%5C+e%3Dz-X%27%5Cbeta" 
alt="\left[\sigma^2 | z, y,\beta\right]\sim IG\left(\dfrac{\nu_0+n}{2},\dfrac{\delta_0+ e' e}{2}\right) \ \ \  \text{where}  \ \ \ e=z-X'\beta">

- The process converges in 3 iterations:

<center><img src="./images/convergence.pdf" width="90%"></center>

- After 1000 burn-in periods (6000 total iterations), the posterior mean is 0.2574 and the standard deviation is 0.0061.

<center><img src="./images/mean.pdf" width="90%"></center>

- The posterior standard deviation is 1.0016 and the standard deviation is 0.0098.

<center><img src="./images/sigma.pdf" width="90%"></center>
