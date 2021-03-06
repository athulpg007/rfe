function [ht,fr]=pipefr(d,mu,re);
% evaluate heat transfer coefficient, Reynolds friction factor
% Israel Urieli, 7/22/2002 (corrected header 2/20/2011)
% Arguments:
%   d - hydraulic diameter [m]
%   mu - gas dynamic viscosity [kg.m/s]
%   re - Reynolds number
% Returned values: 
%   ht - heat transfer coefficient [W/m^2.K]
%   fr - Reynolds friction factor ( = re*fanning friction factor)

global cp % specific heat capacity at constant pressure [J/kg.K]
global prandtl % Prandtl number

% Personal communication with Alan Organ, because of oscillating
% flow, we assume that flow is always turbulent. Use the Blasius
% relation for all Reynolds numbers:
fr=0.0791*re^0.75;
% From Reynolds simple analogy:
ht=fr*mu*cp/(2*d*prandtl);