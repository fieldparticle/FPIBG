clc
clear all

addPathCD('matlab/MPS/main')
ary=1;
mcols = 0;
R = 0.20;
mp      = mps();
mp.SetTimeStep(0.001);
mp.SetSystemTemp(250);
% Set the range over which particle properties
% will be calxualted
mp.SetTempRangeLow(1);        % Base temerature low
mp.SetTempRangeHigh(400);        % Base temerature high
% Add the substances.
mp.AddSubstance("He",4.0026022,28,8.3145,-268.9+273.15);
mp.AddSubstance("He2",2*4.0026022,28,8.3145,-268.9+273.15);

pipe_L = 64;
pipe_W = 20;
pipe_H = 20;

st = [];
ct = [];
cz = [];
close all
H = figure(1);
clf
hold on
old_col = 0;
old_row = 0;
for z = 1:1:64
    old_col = round((pipe_W/2.0)*cos(0)+10);
    old_row = round((pipe_H/2.0)*sin(0)+10);
    for t = 0:pi/100:2*pi
        colx = (pipe_W/2.0)*cos(t)+11;
        rowy = (pipe_H/2.0)*sin(t)+11;
        layer = z;
        if(z == 64)
            st(end+1) = rowy;
            ct(end+1) = colx;
            cz(end+1) = z;
        end
        col = round(colx);
        row = round(rowy);
        
        if(col ~= old_col || row ~= old_row)
            mp.AddParticleBoundary(col,row,layer,...
                                   R,1,...
                                   col,row,layer,0.0,0.0,"He");
            old_col = col;
            old_row = row;
        end
    end
end

plot3(ct,st,cz,'LineWidth',2);
totbparts = mp.ptot-1;

mp.VPLType = mp.VPLTXY;
%mp.VPLType = mp.VPLTCUSTOM;
%mp.VViewAngle = [0,90]; %XY
mp.VPLType = mp.VPLTXZ;
%mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE

mp.plotVoxelSideFTOBoundary(  true,... % As points
                                            [pipe_W+1,pipe_H+1,pipe_L],... % Cell array boundary
                                            [0.5,0.5,0.5],... %orign
                                            [pipe_W+1,pipe_H+1,2.0],... %individual cells to draw    
                                            ary,...     % array of particles to drae 
                                            mp.ptot-1); % number of paeticle to draw
hold off
fprintf('Total All particles:%d, Total Boundary parts %d, Total non boundary %d,Sidelength %d\r\n',...
mp.ptot-1,totbparts,mp.ptot-1-totbparts,64)

dirFile = "J:/RCCDData/perfdataM";
flnm = "PipeBoundaryTest";
mp.SaveDataWTSTV2(dirFile,... % directory
                flnm,... % file name without suffix
                pipe_W+1,...
                pipe_H+1,...
                pipe_L,...
                8,...
                mp.ptot-1); 

fclose all;
