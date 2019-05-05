function [vorticity] = cal_vorticity(u_save,v_save,Re,dtheta,dphi,theta,phi,plot_series_number)

%	CAL_VORTICITY calculate vorticity field from U and V wind fields
%
%	Input arguments:
%		u_save,v_save: U and V wind field
%		Re: radius of the planet
%		dtheta,dphi: intervals of latitude and longitude [units:rad]
%		theta,phi: vectors that store the points of latitude and longitude [units:rad]
%		plot_series_number: index (time) of the wind fields you focus
%
%	Output argument:
%		vorticity: relative vorticity field [unit: s^-1]
%
%	Wang,Zijian , University of Manchester, April 2019

if nargin == 8
	vorticity = zeros(size(u_save(:,:,1)));
	vorticity(2:end-1,2:end-1) = (u_save(2:end-1,1:end-2,plot_series_number)-u_save(2:end-1,3:end,plot_series_number))./(Re.*dtheta) ...
	+ (v_save(3:end,2:end-1,plot_series_number)-v_save(1:end-2,2:end-1,plot_series_number))./(Re.*cos(theta(2:end-1)).*dphi);

	%periodic
	vorticity(1,2:end-1) = (u_save(1,1:end-2,plot_series_number)-u_save(1,3:end,plot_series_number))./(Re.*dtheta)+ ...
	(v_save(2,2:end-1,plot_series_number)-v_save(end,2:end-1,plot_series_number))./(Re.*cos(theta(1)).*dphi);
	vorticity(end,2:end-1) = (u_save(end,1:end-2,plot_series_number)-u_save(end,3:end,plot_series_number))./(Re.*dtheta)+ ...
	(v_save(1,2:end-1,plot_series_number)-v_save(end-1,2:end-1,plot_series_number))./(Re.*cos(theta(end)).*dphi);
	
else
	disp('argurment number mismatch')
	
end