% contour_plot
% output a contour plot of any variable (U OR V wind, vorticity)


% Do not print filename in the title if it does not exist. 
if exist('file_name')==0
	file_name='';
end

[r,c,p]=size(u_save);

figure('renderer','painters'); %maxfigsize
switch plot1
	case 'vort'
		for i=1:p
			vorticity=cal_vorticity(u_save,v_save,Re,dtheta,dphi,theta,phi,i);
			vorticity_save(:,:,i)=vorticity(:,:);          
		end

		contour(phi./pi.*180,theta./pi.*180,vorticity_save(:,:,plot_series_number)','LevelStep',1e-5);
		title({[file_name,'  ','Relative Vorticity Field'];['after ',num2str(t_save(plot_series_number)./3600),' simulated hours ']})
		xlabel('Longitde (\circ)')
		ylabel('Latitude (\circ)')
		colorbar
		object_colorbar = colorbar;
		caxis([-1.4,1.4].*1e-4);
		colorbar_name="Relative Vorticity (s^{-1})";
		object_colorbar.Label.String = colorbar_name;
		object_colorbar.Ticks = [-1.4:0.2:1.4].*1e-4;	
	case 'u'
		contour(phi./pi.*180,theta./pi.*180,u_save(:,:,plot_series_number)');
		title({[file_name,'  ','U wind Field'];['after ',num2str(t_save(plot_series_number)./3600),' simulated hours ']})
		xlabel('Longitde (\circ)')
		ylabel('Latitude (\circ)')
		colorbar
		object_colorbar = colorbar;
		colorbar_name="U wind (m/s)";
		object_colorbar.Label.String = colorbar_name;
	case 'v'
		contour(phi./pi.*180,theta./pi.*180,v_save(:,:,plot_series_number)');
		title({[file_name,'  ','V wind Field'];['after ',num2str(t_save(plot_series_number)./3600),' simulated hours ']})
		xlabel('Longitde (\circ)')
		ylabel('Latitude (\circ)')
		colorbar
		object_colorbar = colorbar;
		colorbar_name="V wind (m/s)";
		object_colorbar.Label.String = colorbar_name;
end
	
%OUTPUT METHODS
if print_series == true
	saveas(gcf,[num2str(plot_series_number),'.jpg'],'jpeg')
	hold off
else
	pause;
end



