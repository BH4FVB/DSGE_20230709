
var y c n r w mc a;

varexo etaa;
parameters beta sigma varphi omega epsilon mu rho sigmaa;
beta = 0.99;
set_param_value('sigma',sigma);
//sigma = 2.10;
varphi = 1.20;
omega = 1.20;
epsilon = 4.1;
rho = 0.88;
sigmaa = 0.01;
mu = (epsilon - 1)/epsilon; 

model(linear);
-sigma*c(1)+sigma*c=-r;
varphi*n + sigma*c = w;
mc = 0;
mc = w-a;
y = c;
y = a+n;
a = rho*a(-1)+etaa;
end;

initval;
r = 0;
w = 0;
a = 0;
mc = 0;
y = 0;
c = 0;
n = 0;
end;

steady;
check;

shocks;
var etaa = sigmaa^2;
end;

stoch_simul(irf = 40, order = 1, periods = 20000, drop = 400);
//noprint, nograph, 