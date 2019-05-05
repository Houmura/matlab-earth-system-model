% variable_T_plot.m
% output varibale (height OR relative vorticity) field vs Time pcolor plot at a latitude

% Do not print filename in the title if it does not exist. 
if exist('file_name')==0
	file_name='';
end

figure('renderer','painters'); %maxfigsize

if viscous_dissipation == false
    vis=0.;
end

warning off;
[r,c,p]=size(u_save);
lon=length(phi);
phi2=[phi(lon/2+1:lon)-360.*pi./180 phi(1:lon/2)];
PHI2=[PHI(lon/2+1:lon,:)-360.*pi./180; PHI(1:lon/2,:)];

switch plot1
	case 'h'
		h_time=h_save([lon/2+1:lon 1:lon/2],(plot_latitude-bottom_latitude)/(dtheta/(pi/180)),:);   %extract height data at the latitude 
		h_time=permute(h_time,[3,1,2]);
		pcolor(h_time(:,:,:));
		shading flat;
		colorbar;
		colorbar_name="Height Field (m)";
		title({[file_name,'  ',char(strrep(colorbar_name,'Height Field (m)','Height Field ')),' at ',num2str(plot_latitude),'\circ N']});
		xlabel('Longitude (\circ)');
		ylabel('Hours');
		xticks(0:60:360);
		xlim([0 360]);				ylim([0 p]);
	case 'vort'
        vorticity = zeros(size(u_save(:,:,1)));
		vorticity_save=zeros([size(vorticity),p]);

		for i=1:p
			vorticity=cal_vorticity(u_save,v_save,Re,dtheta,dphi,theta,phi,i);
			vorticity_save(:,:,i)=vorticity(:,:);          
		end

		vorticity_time=vorticity_save([lon/2+1:lon 1:lon/2],(plot_latitude-bottom_latitude)/(dtheta/(pi/180)),:);   %extract height data at the latitude 
		vorticity_time=permute(vorticity_time,[3,1,2]);
		pcolor(vorticity_time(:,:,:));
		shading flat;
		colorbar;
		colorbar_name="Relative Vorticity Field (s^{-1})";
		title({[file_name,'  ',char(strrep(colorbar_name,'Relatice Vorticity Field (s^{-1})','Relative Vorticity Field ')),' at ',num2str(plot_latitude),'\circ N']});
		xlabel('Longitude (\circ)');
		ylabel('Hours');
		xticks(0:60:360);
		xlim([0 360]);
		ylim([0 p]);
	otherwise
		disp(['error ']);
		return;	
end
object_colorbar = colorbar;    %return the Colorbar object and use this object to set properties after creating the colorbar		object_colorbar.Label.String = colorbar_name;