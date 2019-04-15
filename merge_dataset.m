% merge two datasets into a joint dataset 
% input the top and bottom boundaries of the latitude 

top_latitude=86.5;   % the top boundary of the latitude mesh for idealised jet condition [degree]
bottom_latitude=65; % the bottom boundary of the latitude mesh for idealised jet condition [degree]

load('C20U100H1440.mat');
part1_h_save = h_save;
part1_u_save = u_save;
part1_v_save = v_save;
part1_t_save = t_save;
part1_forecast_length_days = forecast_length_days;
part1_forecast_length = forecast_length;
clear h_save u_save v_save t_save forecast_length_days forecast_length;

load('C20U100H1440_1680.mat');
part2_h_save = h_save;
part2_u_save = u_save;
part2_v_save = v_save;
part2_t_save = t_save;
part2_forecast_length_days = forecast_length_days;
part2_forecast_length = forecast_length;
clear h_save u_save v_save t_save forecast_length_days forecast_length;

load('C20U100H1680_1920.mat');
part3_h_save = h_save;
part3_u_save = u_save;
part3_v_save = v_save;
part3_t_save = t_save;
part3_forecast_length_days = forecast_length_days;
part3_forecast_length = forecast_length;
clear h_save u_save v_save t_save forecast_length_days forecast_length;

% clear duplicated data
part2_h_save(:,:,1) = [];
part2_u_save(:,:,1) = [];
part2_v_save(:,:,1) = [];
part2_t_save(:,1) = [];
part3_h_save(:,:,1) = [];
part3_u_save(:,:,1) = [];
part3_v_save(:,:,1) = [];
part3_t_save(:,1) = [];


part3_t_save=part3_t_save+part2_t_save(:,end)+part1_t_save(:,end);
h_save=cat(3,part1_h_save,part2_h_save,part3_h_save);
u_save=cat(3,part1_u_save,part2_u_save,part3_u_save);
v_save=cat(3,part1_v_save,part2_v_save,part3_v_save);
t_save=cat(2,part1_t_save,part2_t_save,part3_t_save);
forecast_length_days=part1_forecast_length_days+part2_forecast_length_days+part3_forecast_length_days;
forecast_length=part1_forecast_length+part2_forecast_length+part3_forecast_length;

clear part1_h_save part2_h_save part3_h_save;
clear part1_u_save part2_u_save part3_u_save;
clear part1_v_save part2_v_save part3_v_save;
clear part1_t_save part2_t_save part3_t_save;
clear part1_forecast_length_days part2_forecast_length_days part3_forecast_length_days;
clear part1_forecast_length part2_forecast_length part3_forecast_length;


