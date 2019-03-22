% an example plotting program with m_map
plot1='h';
print1='no';
print_series=false;
time_variable=false;
plot_latitude=77; %latitude of the peak [degree]

figure('renderer','painters');%maxfigsize
if viscous_dissipation == false
    vis=0.;
end
warning off;
[r,c,p]=size(u_save);
lon=length(phi);
phi2=[phi(lon/2+1:lon)-360.*pi./180 phi(1:lon/2)];
PHI2=[PHI(lon/2+1:lon,:)-360.*pi./180; PHI(1:lon/2,:)];

if time_variable == false
    for i=1:p
    vorticity = zeros(size(u_save(:,:,1)));
    vorticity(2:end-1,2:end-1) = (u_save(2:end-1,1:end-2,i)-u_save(2:end-1,3:end,i)) ...
        + (v_save(3:end,2:end-1,i)-v_save(1:end-2,2:end-1,i));
%    m_proj('robinson','long',[-180 180],'lat',[-90 90]);
    m_proj('stereographic','lat',90,'lon',0,'radius',30)
%    m_proj('ortho','long',180,'lat',60);
    hold off;
    switch plot1
        case 'h'
            F1=h_save([lon/2+1:lon 1:lon/2],:,i); 
            colorbar_name="Height Field (m)";
        case 'vort'
            F1=vorticity([lon/2+1:lon 1:lon/2],:); 
            colorbar_name="Vorticity Field (s^{-1})";
        otherwise
            disp(['error ']);
            return;
    end
    m_pcolor(phi2.*180./pi,theta.*180./pi,F1');shading flat
    m_grid('fontsize',6,'xticklabels',[],'xtick',[-180:30:360],... 
        'ytick',[-80:20:60 78 80],'yticklabels',[],'linest','-','color',[0 0 0],'linewidth',0.1);
    hold on;
%     m_gshhs_c('color','k');
%     m_quiver(PHI2(1:3:end,1:3:end)'.*180./pi,THETA(1:3:end,1:3:end)'.*180./pi,...
%         u_save([91:3:180 1:3:90],1:3:end,i)',v_save([91:3:180 1:3:90],1:3:end,i)')
    title({[colorbar_name];['Time (hrs): ',num2str(t_save(i)./3600)],
        [num2str(i),' of ',num2str(p),'; viscosity: ',num2str(vis)]});
    object_colorbar = colorbar;    %return the Colorbar object and use this object to set properties after creating the colorbar
    object_colorbar.Label.String = colorbar_name;

    
%   OUTPUT METHODS
    if print_series == false
        pause; %(0.1);
    else
        saveas(gcf,[num2str(i),'.jpg'],'jpeg')
        hold off
    end
    end    
    
    if strcmp(print1,'yes')
        eval(['print -dpng -r25 aframe',num2str(i,'%03d'),'.png']);
    end
    
else
    switch plot1
        case 'h'
            h_time=h_save(:,(plot_latitude-bottom_latitude)/(dtheta/(pi/180)),:);   %extract height data at the latitude 
            h_time=permute(h_time,[3,1,2]);
            pcolor(h_time(:,:,:));
            shading flat;
            colorbar;
            colorbar_name="Height Field (m)";
            title({[char(strrep(colorbar_name,'Height Field (m)','Height Field ')),' at ',num2str(plot_latitude),'\circ']});
            
            
        case 'vort'
            vorticity = zeros(size(u_save(:,:,1)));
            vorticity_save=zeros([size(vorticity),p]);
            for i=1:p
                vorticity = zeros(size(u_save(:,:,1)));
                vorticity(2:end-1,2:end-1) = (u_save(2:end-1,1:end-2,i)-u_save(2:end-1,3:end,i)) ...
                + (v_save(3:end,2:end-1,i)-v_save(1:end-2,2:end-1,i));
                vorticity_save(:,:,i)=vorticity(:,:);
            end
            vorticity_time=vorticity_save(:,(plot_latitude-bottom_latitude)/(dtheta/(pi/180)),:);   %extract height data at the latitude 
            vorticity_time=permute(vorticity_time,[3,1,2]);
            pcolor(vorticity_time(:,:,:));
            shading flat;
            colorbar;
            colorbar_name="Vorticity Field (s^{-1})";
            title({[char(strrep(colorbar_name,'Vorticity Field (s^{-1})','Vorticity Field ')),' at ',num2str(plot_latitude),'\circ']});
    end
    object_colorbar = colorbar;    %return the Colorbar object and use this object to set properties after creating the colorbar
    object_colorbar.Label.String = colorbar_name;
    
end
