% sea (stirling engine analysis) - main program
%Israel Urieli 7/20/02
clc;
clear all;
%close all;
%define a specific engine


%{
while(~strncmp(choice,'q',1))
	fprintf('Choose simulation:\n');
	choice = input('a)diabatic, s)imple q)uit: ','s');
    if(strncmp(choice,'a',1))
		[var,dvar] = adiabatic;
	elseif(strncmp(choice,'s',1))
		[var,dvar] = simple;
	end
end
fprintf('quitting simulation...\n');
%}

%{
define('realistic - aug 20.dat');

[actWpower,actQhpower,acteff] = simple;

define('realistic - aug 20 - b.dat');

[actWpower1,actQhpower1,acteff1] = simple;
%}


define('inputFile - gamma - baseline - report.txt');

[var, dvar, actWpower, actQhpower, acteff] = simple;

theta = 0:10:360;



tot_vol = var(10,:)*1e6 +  var(11,:)*1e6 + 300.0;
pres    = var(9,:)/1e5;


figure
subplot(2,2,1)
plot(tot_vol, pres)
hold('on')
%plot(tot_vol(9), pres(9), 'c*')
%plot(tot_vol(18), pres(18), 'r*')
%plot(tot_vol(27), pres(27), 'g*')
%plot(tot_vol(36), pres(36), 'b*')
xlabel('Volume (cc)')
ylabel('Pressure (bar)')
title('PV diagram')
grid on



Tcomp = var(1,:);
Texp  = var(2,:);
subplot(2,2,2)
hold('on')
plot(theta,Tcomp,'b-',theta,Texp,'r-');
xlabel('Crank angle, deg.')
ylabel('Temperature, K')
title('Compresssion and Expansion Space Temperature')
grid on
plot(theta(9), Tcomp(9), 'c*')
plot(theta(18), Tcomp(18), 'r*')
plot(theta(27), Tcomp(27), 'g*')
plot(theta(36), Tcomp(36), 'b*')

plot(theta(9), Texp(9), 'c*')
plot(theta(18), Texp(18), 'r*')
plot(theta(27), Texp(27), 'g*')
plot(theta(36), Texp(36), 'b*')
legend({'Compression Space Temp', 'Expansion Space Temp'}, 'Location','east')

P = var(9,:);
subplot(2,2,3)
hold('on')
plot(theta,P/1e5,'b-');
%plot(theta(9), P(9)/1e5, 'c*')
%plot(theta(18), P(18)/1e5, 'r*')
%plot(theta(27), P(27)/1e5, 'g*')
%plot(theta(36), P(36)/1e5, 'b*')
xlabel('Crank angle, deg.')
ylabel('Pressure, bar')
title('Pressure')
grid on

subplot(2,2,4)
plot(Tcomp,pres,'b-',Texp,pres,'r-');
hold('on')
xlabel('Temperature')
ylabel('Pressure (bar)')
title('PT diagram')
grid on
legend({'Compression Space Temp', 'Expansion Space Temp'}, 'Location','east')
plot(Tcomp(9), pres(9), 'c*')
plot(Tcomp(18), pres(18), 'r*')
plot(Tcomp(27), pres(27), 'g*')
plot(Tcomp(36), pres(36), 'b*')

plot(Texp(9), pres(9), 'c*')
plot(Texp(18), pres(18), 'r*')
plot(Texp(27), pres(27), 'g*')
plot(Texp(36), pres(36), 'b*')

%{
WC = var(6,:);
WE = var(7,:);

figure
hold('on')
plot(theta,WC,'b-',theta,WE,'r-');
plot(theta(9), WC(9), 'c*')
plot(theta(18), WC(18), 'r*')
plot(theta(27), WC(27), 'g*')
plot(theta(36), WC(36), 'b*')

plot(theta(9), WE(9), 'c*')
plot(theta(18), WE(18), 'r*')
plot(theta(27), WE(27), 'g*')
plot(theta(36), WE(36), 'b*')
xlabel('Crank angle, deg.')
ylabel('Work, J')
title('Compression and Expansion work')
legend({'Compression Work', 'Expansion Work'}, 'Location','north')
grid on


MC = var(12,:)*1e3;
MK = var(13,:)*1e3;
MR = var(14,:)*1e3;
MH = var(15,:)*1e3;
ME = var(16,:)*1e3;

m_tot = (MC + MK + MR + MH + ME);


figure
hold('on')
plot(theta,MC,'r-',theta,MK,'g-',theta, MR, 'b-', theta, MH, 'c-', theta, ME, 'm-', theta, m_tot, 'k-' );

plot(theta(9), MC(9), 'c*')
plot(theta(18), MC(18), 'r*')
plot(theta(27), MC(27), 'g*')
plot(theta(36), MC(36), 'b*')

plot(theta(9), ME(9), 'c*')
plot(theta(18), ME(18), 'r*')
plot(theta(27), ME(27), 'g*')
plot(theta(36), ME(36), 'b*')

xlabel('Crank angle, deg.')
ylabel('Mass, g ')
title('Mass of gas')
grid on
legend({'Compression space', 'Cooler', 'Regenerator', 'Heater', 'Expansion space', 'Total'}, 'Location','east')

%}
