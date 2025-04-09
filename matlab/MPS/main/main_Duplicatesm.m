clc
clear all
close all
[pfxdrv,pfxdir] = addPathCD('matlab/MPS/main');
ary=1;
mcols = 0;

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

%=========================== 3 sided

%=========================== 1 sided
sidelen  = 4;

%sidelen  = 10;
sl = sidelen-1;
mp.Corner3Sides(sl,0.1);
mp.Corner2Sides(sl,0.1);
mp.Center1Sides(sl,0.1);
totbparts = mp.ptot-1;



if 0


posx = 1.2;
posy = 1.2;
posz = 1.2;
picnt = 0;
endcount = 4;

for layers = 1:endcount
    posz = posz+0.45;
    posx = 1.2;
    posy = 1.2;
    for rows = 1:endcount
        posy = posy+0.45;
        posx = 1.2;
        for cols = 1:endcount
            posx = posx+0.45;
            picnt = picnt + pi()/16;
            vx = 0.03*cos(picnt);
            vy = 0.03*sin(picnt);
            vz = 0.03*cos(picnt);
            mp.AddParticle(posx,posy,posz,0.20,vx,vy,vz,0,0.0,0.0,"He");
        end
    end
end
end
if 1
mp.AddParticle( 1.5,...    % X position
                1.5,...     % Y Position
                1.5,...     % Z Position
                0.20,...    % Radius
                0.000,...     % x velocity
                0.000,...     % y velocity
                0.000,...     % z velocity
                0,...
                0.0,...     % attraction coefficient
                0.0,...     % repulsion coefficient
                "He");    % Substance    
                

mp.AddParticle( 1.2,...    % X position
                1.5,...     % Y Position
                1.5,...     % Z Position
                0.20,...    % Radius
                0.000,...     % x velocity
                0.000,...     % y velocity
                0.000,...     % z velocity
                0,...
                0.0,...     % attraction coefficient
                0.0,...     % repulsion coefficient
                "He");    % Substance    
if 1
mp.AddParticle( 1.8,...    % X position
                1.5,...     % Y Position
                1.5,...     % Z Position
                0.20,...    % Radius
                0.000,...     % x velocity
                0.000,...     % y velocity
                0.000,...     % z velocity
                0,...
                0.0,...     % attraction coefficient
                0.0,...     % repulsion coefficient
                "He");    % Substance    
end
end
mp.VPLType = mp.VPLTCUSTOM;
mp.VViewAngle = [0,90]; %XY
mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE
ary = 1;
[H,sidelenc] = mp.plotVoxelSideFTBoundary(  false,... % As points
                                            true,... % draw boundary    
                                            false,... % Plot AARB -- remove in this
                                            false,... % Plot axis remove this
                                            true,...  % plot voxel cubes
                                            sidelen,... % sidlentgh
                                            ary,...     % array of particles to drae        
                                            mp.ptot-1); % number of paeticle to draw

fprintf('Total All particles:%d, Total Boundary parts %d, Total non boundary %d,Sidelength %d\r\n',...
mp.ptot-1,totbparts,mp.ptot-1-totbparts,64)

dirFile = sprintf("%s/%s/%s",pfxdrv,"RCCDData","perfdataM");

flnm = "CubeBoundaryTest";
mp.SaveDataWTSTV2(dirFile,... % directory
                flnm,... % file name without suffix
                5,...
                5,...
                5,...
                0.0,...
                0.20,...
                8,...
                128,...
                mp.ptot-1); 

fclose all;
