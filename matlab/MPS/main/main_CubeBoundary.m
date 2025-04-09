clc
clear all
close all
addPathCD('matlab/MPS/main')
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


if 0
    ary = 1;

    sidelen  = 4;
    sl = sidelen-1;
    mp.Corner3Sides(sl,0.1);
    mp.Corner2Sides(sl,0.1);
    mp.Center1Sides(sl,0.1);
    totbparts = mp.ptot-1;
    
    mp.AddParticle( 2.85,...    % X position
                    1.85,...     % Y Position
                    1.75,...     % Z Position
                    0.20,...    % Radius
                    -0.005,...     % x velocity
                    0.000,...     % y velocity
                    0.000,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    
                    
    
    mp.AddParticle( 1.85,...    % X position
                    1.85,...     % Y Position
                    1.75,...     % Z Position
                    0.20,...    % Radius
                    0.005,...     % x velocity
                    0.000,...     % y velocity
                    0.000,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    
    if 1
    mp.AddParticle( 1.85,...    % X position
                    3.00,...     % Y Position
                    2.00,...     % Z Position
                    0.20,...    % Radius
                    0.005,...     % x velocity
                    0.005,...     % y velocity
                    -0.005,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    

end
else
    ary = [538 539 ];
    sidelen  = 10;
    sl = sidelen-1;
    mp.Corner3Sides(sl,0.1);
    mp.Corner2Sides(sl,0.1);
    mp.Center1Sides(sl,0.1);
    totbparts = mp.ptot-1;
    picnt = 0;
    endcount = 7.0;
    %endcount = 4.0;
    posall = 1.2;
    posz = posall;
    for layers = 1:endcount
        posz = posz+0.45;
        posx = posall;
        posy = posall;
        for rows = 1:endcount
            posy = posy+0.45;
            posx = posall;
            for cols = 1:endcount
                posx = posx+0.45;
                picnt = picnt + pi()/16;
                vx = 0.3*cos(picnt);
                vy = 0.3*sin(picnt);
                vz = 0.3*cos(picnt);
                mp.AddParticle(posx,posy,posz,0.20,vx,vy,vz,0.0,0.0,"He");

            end
        end
    end
end
mp.VPLType = mp.VPLTCUSTOM;
mp.VViewAngle = [0,90]; %XY
mp.VPLType = mp.VPLTXZ;
mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE

[H,sidelenc] = mp.plotVoxelSideFTBoundary(  false,... % As points
                                            true,... % draw boundary    
                                            false,... % Plot AARB -- remove in this
                                            false,... % Plot axis remove this
                                            true,...  % plot voxel cubes
                                            sidelen,... % sidlentgh
                                            ary,...     % array of particles to drae 
                                            488);
                                            %mp.ptot-1); % number of paeticle to draw

fprintf('Total All particles:%d, Total Boundary parts %d, Total non boundary %d,Sidelength %d\r\n',...
mp.ptot-1,totbparts,mp.ptot-1-totbparts,sidelen)

dirFile = "J:/RCCDData/perfdataM";
flnm = "CubeBoundaryTest";
mp.SaveDataWTST(dirFile,... % directory
                flnm,... % file name without suffix
                sidelen,...
                8,...
                mp.ptot-1); 

fclose all;
