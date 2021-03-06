function [st,fr] = matrixfr(re)
% evaluate regenerator mesh matrix stanton number, friction factor
% Israel Urieli, 7/22/2002
% Arguments:
%   re - Reynolds number
% Returned values: 
%   st - Stanton number
%   fr - Reynolds friction factor ( = re*fanning friction factor)

global prandtl % Prandtl number

% equations taken from Kays & London (1955 edition)
st = 0.46*re^(-0.4)/prandtl;
fr = 54 + 1.43*re^0.78;
