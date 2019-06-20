clc;
clear all; 
close all;
no_of_frames = (18.5731*1000)/(20);
u_v=zeros(1,no_of_frames);

for i=1:no_of_frames
    if(energy_frame > decision_factor)
        u_v(i)=1;
    end
end 
