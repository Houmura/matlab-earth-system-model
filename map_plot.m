% map_plot.m 
% output a map of a varibale (U or V winds, height, relative vorticity) field 

figure('renderer','painters'); %maxfigsize

if viscous_dissipation == false
    vis=0.;
end

% Do not print filename in the title if it does not exist. 
if exist('file_name')==0
	file_name='';
end

warning off;
[r,c,p]=size(u_save);
lon=length(phi);
phi2=[0:dphi:2.*pi];
m_proj('stereographic','lat',90,'lon',0,'radius',25)
hold off;

switch plot1
	case 'u'
		F1=u_save([lon/2+1:lon 1:lon/2],:,plot_series_number);
		F1=[F1;F1(1,:)];    %periodic 
		colorbar_name="U Wind-Field (m/s)"; 
	case 'v'
		F1=v_save([lon/2+1:lon 1:lon/2],:,plot_series_number);
		F1=[F1;F1(1,:)];    %periodic 
		colorbar_name="V Wind-Field (m/s)";
	case 'vort'
		vorticity=cal_vorticity(u_save,v_save,Re,dtheta,dphi,theta,phi,plot_series_number);
		F1=vorticity([lon/2+1:lon 1:lon/2],:);        
		F1=[F1;F1(1,:)]; 
		colorbar_name="Relative Vorticity Field (s^{-1})"; 			   
	case 'h'
		F1=h_save([lon/2+1:lon 1:lon/2],:,plot_series_number);
		F1=[F1;F1(1,:)];    %periodic 
		colorbar_name="Height Field (m)";	
	otherwise
		disp(['error ']);
		return;
end
	
	%m_gshhs_c('color','k');
	%m_quiver(PHI2(1:3:end,1:3:end)'.*180./pi,THETA(1:3:end,1:3:end)'.*180./pi,...
    %u_save([91:3:180 1:3:90],1:3:end,i)',v_save([91:3:180 1:3:90],1:3:end,i)')

m_pcolor(phi2.*180./pi,theta.*180./pi,F1');shading flat
m_grid('fontsize',8,'xticklabels',[-150:30:180],'xtick',[-150:30:180],... 
		'ytick',[70 75 80 85],'yticklabels',[70 75 80 85],'linest',':','color',[0 0 0],'linewidth',0.1);
title({[file_name,'  ',colorbar_name];['Time (hrs): ',num2str(t_save(plot_series_number)./3600)];[num2str(plot_series_number),' of ',num2str(p),'; viscosity: ',num2str(vis)];[]});
object_colorbar = colorbar;    %return the Colorbar object and use this object to set properties after creating the colorbar
object_colorbar.Label.String = colorbar_name;
object_colorbar.Location = 'westoutside';

%OUTPUT METHODS
if print_series == true
	saveas(gcf,[num2str(plot_series_number),'.jpg'],'jpeg')
	hold off
else
	pause;
end