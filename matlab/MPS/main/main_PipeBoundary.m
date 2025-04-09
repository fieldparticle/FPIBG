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
Center = 11.0;
Radius = pipe_W/2.0;

st = [];
ct = [];
cz = [];
close all
H = figure(1);
clf
hold on
old_col = 0;
old_row = 0;
for z = 1:1:pipe_L
    old_col = round((pipe_W/2.0)*cos(0)+10);
    old_row = round((pipe_H/2.0)*sin(0)+10);
    for t = 0:pi/100:2*pi
        colx = Radius*cos(t)+Center;
        rowy = Radius*sin(t)+Center;
        layer = z;
        if(z == 1)
            st(end+1) = rowy;
            ct(end+1) = colx;
            cz(end+1) = z;
        end
        col = round(colx);
        row = round(rowy);
        
        if(col ~= old_col || row ~= old_row)
            mp.AddParticleBoundary(layer,row,col,...
                                   R,1,...
                                   round(layer),round(row),round(col),0.0,0.0,"He");
            old_col = col;
            old_row = row;
        end
    end
end

plot3(cz,st,ct,'LineWidth',2,'Color',[0.0,1.0,0.0]);
totbparts = mp.ptot-1;
%########################################################################
if 0
   mp.AddParticle( 1.0,...    % X position
                    11.00,...     % Y Position
                    11.00,...     % Z Position
                    0.20,...    % Radius
                    0.5,...     % x velocity
                    0.5,...     % y velocity
                    0.000,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    
                    
    if 0
    mp.AddParticle( 1.0,...    % X position
                    11.00,...     % Y Position
                    11.00,...     % Z Position
                    0.20,...    % Radius
                    0.000,...     % x velocity
                    0.000,...     % y velocity
                    0.000,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    

    mp.AddParticle( 12.85,...    % X position
                    13.00,...     % Y Position
                    12.00,...     % Z Position
                    0.20,...    % Radius
                    0.000,...     % x velocity
                    0.000,...     % y velocity
                    0.000,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    

end
else

    a = 0.01; b = -0.01;
    
    divpi = 55.0;
    radius = Radius-1;
    for z = 1:1:1
        for radius = Radius-1:-0.42:0
            for t = 0:pi()/divpi:2*pi()
                colx = radius*cos(t)+Center;
                rowy = radius*sin(t)+Center;
                vy =  a + (b-a) .* rand(1,1);
                vz =  a + (b-a) .* rand(1,1);
                vx = 0.5;
                mp.AddParticle(z,rowy,colx,0.20,vx,vy,vz,0.0,0.0,"He");
            end
            divpi = divpi-(1.6)^2;
        end
    end
   
end
%#########################################################################
mp.VPLType = mp.VPLTXY;
%mp.VPLType = mp.VPLTCUSTOM;
%mp.VViewAngle = [0,90]; %XY
mp.VPLType = mp.VPLTXZ;
mp.VPLType = mp.VPLTYZ;
%mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE
ary = 1;
mp.plotVoxelSideFTOBoundary(  false,... % As points
                                false,...
                                            [pipe_L,pipe_H+1,pipe_W+1],... % Cell array boundary
                                            [0.5,0.5,0.5],... %orign
                                            [1.0,pipe_H+1,pipe_W+1],... %individual cells to draw    
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
                Center,...
                Radius,...
                8,...
                mp.ptot-1); 

fclose all;
