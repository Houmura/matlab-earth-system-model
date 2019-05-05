% a plotting program with m_map

% OUTPUT SETTING
contour_plotting=false;
variable_T_plotting=false;
map_plotting=true;
plot1='u';
print_series=false;



plot_latitude=77; %the latitude you want to extract from the data[degree]
plot_series_number=5; %index (time) of the fields you focus, ignore this if time_variable OR plot_series==true
plot_series=false;
bottom_latitude=65;


if map_plotting==true
	if plot_series == false
		run('map_plot.m')	
	else
		for plot_series_number=1:p 
            run('map_plot.m')	
		end    
	end	
end

if contour_plotting == true
	if plot_series == false
		run('contour_plot.m')	
	else
		for plot_series_number=1:p 
            run('contou r_plot.m')	
		end    
	end	
end

if variable_T_plotting==true
	run('variable_T_plot.m')
end