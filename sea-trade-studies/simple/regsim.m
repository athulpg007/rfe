function qrloss = regsim(var)
% Evaluate the effectiveness and performance of the regenerator
% Israel Urieli, 7/23/2002 - Modified 2/15/2010
% modified 11/27/2010 to include 'no regenerator matrix'
% Arguments:
%   var(22,37) array of variable values every 10 degrees (0 - 360)
% Returned value: 
%   qrloss - regenerator net enthalpy loss [J]

% Row indices of the var array:
 TC = 1;  % Compression space temperature [K]
 TE = 2;  % Expansion space temperature [K]
 QK = 3;  % Heat transferred to the cooler [J]
 QR = 4;  % Heat transferred to the regenerator [J]
 QH = 5;  % Heat transferred to the heater [J]
 WC = 6;  % Work done by the compression space [J]
 WE = 7;  % Work done by the expansion space [J]
 W  = 8;  % Total work done (WC + WE) [J]
 P  = 9;  % Pressure [Pa]
 VC = 10; % Compression space volume [m^3]
 VE = 11; % Expansion space volume [m^3]
 MC = 12; % Mass of gas in the compression space [kg]
 MK = 13; % Mass of gas in the cooler [kg]
 MR = 14; % Mass of gas in the regenerator [kg]
 MH = 15; % Mass of gas in the heater [kg]
 ME = 16; % Mass of gas in the expansion space [kg]
 TCK = 17; % Conditional temperature compression space / cooler [K]
 THE = 18; % Conditional temeprature heater / expansion space [K]
 GACK = 19; % Conditional mass flow compression space / cooler [kg/rad]
 GAKR = 20; % Conditional mass flow cooler / regenerator [kg/rad]
 GARH = 21; % Conditional mass flow regenerator / heater [kg/rad]
 GAHE = 22; % Conditional mass flow heater / expansion space [kg/rad]

global matrix_type % m)esh or f)oil
global ar % regen internal free flow area [m^2]
global awgr % regen internal wetted area [m^2]
global dr % regen hydraulic diameter [m]
global tr % regen temperature [K]
global freq omega % cycle frequency [herz], [rads/s]

% Reynolds number over the cycle
for(i = 1:1:37)
    gar(i) = (var(GAKR,i) + var(GARH,i))*omega/2;
    gr = gar(i)/ar;
    [mu,kgas,re(i)] = reynum(tr,gr,dr);
end

% average and maximum Reynolds number
sumre = 0;
remax = re(1);
for(i = 1:1:36)
    sumre = sumre + re(i);
    if(re(i) > remax)
        remax = re(i);
    end
end

reavg = sumre/36;

% Stanton number, number of transfer units, regenerator effectiveness
if (strncmp(matrix_type,'m',1))
    [st,fr] = matrixfr(reavg);
elseif (strncmp(matrix_type,'f',1))
    [st,ht,fr] = foilfr(dr,mu,reavg);
elseif (strncmp(matrix_type,'n',1))
    [st,ht,fr] = foilfr(dr,mu,reavg);
end

ntu = st*awgr/(2*ar);
effect = ntu/(ntu + 1);

% Calculate qrloss
for (i=1:1:37)
    qreg(i) = var(QR,i);
end
qrmin = min(qreg);
qrmax = max(qreg);
qrloss = (1 - effect)*(qrmax - qrmin);

% Regenerator simple analysis results:
% fprintf('============ Regenerator Simple analysis =============\n')
% fprintf('Average Reynolds number: %.1f\n', reavg);
% fprintf('Maximum Reynolds number: %.1f\n', remax);
% fprintf('Stanton number(Average Re): %.3f\n',st);
% fprintf('Number of transfer units: %.1f\n',ntu);
% fprintf('Regenerator effectiveness : %.3f\n',effect);
% fprintf('Regenerator net enthalpy loss: %.1f[W]\n', qrloss*freq);



