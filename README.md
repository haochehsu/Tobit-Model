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

<center><img src="./images/convergence.pdf" width="90%"></center>

<center><img src="./images/mean.pdf" width="90%"></center>

<center><img src="./images/sigma.pdf" width="90%"></center>
