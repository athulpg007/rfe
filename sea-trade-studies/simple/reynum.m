function [mu,kgas,re] = reynum(t,g,d)
% evaluate dynamic viscosity, thermal conductivity, Reynolds number
% Israel Urieli, 7/22/2002 (mu units correction 2/13/2011)
% Arguments:
%   t - gas temperature [K]
%   g - mass flux [kg/m^2.s]
%   d - hydraulic diameter [m]
% Returned values: 
%   mu - gas dynamic viscosity [kg/m.s]
%   kgas - gas thermal conductivity [W/m.K]
%   re - Reynolds number

global cp % specific heat capacity at constant pressure [J/kg.K]
global mu0 % dynamic viscosity at reference temp t0 [kg.m/s]
global t0 t_suth % reference temperature [K], Sutherland constant [K]
global prandtl % Prandtl number

mu = mu0*(t0 + t_suth)/(t + t_suth)*(t/t0)^1.5;
kgas = cp*mu/prandtl;
re = abs(g)*d/mu;

if(re < 1)
   re = 1;
end
