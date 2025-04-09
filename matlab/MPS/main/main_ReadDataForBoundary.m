clc
clear all
close all
addPathCD('matlab/MPS/main')

outdir = "../../../RCCDData/perfdataM/0000CollisionDataSet64X0X3";
    mp      = mps();
    %newname = extractBefore(files(ii).name,".bin");
    [ret sidelen] = mp.ParticleDataReadBIN("",outdir,1,640);
   

    if 0
       %ary = [24,23,29,30];
        ary = [30,22,20,32,26,29,32,21,25,26,23,24,5];
        %ary = [16,17,25,26];
    else
        ary=1;
    end
    mcols = 0;


if 0
    mcols = mp.CountCollisions();
end
if 1
    clf
    mp.VPLType = mp.VPLTCUSTOM;
    mp.VViewAngle = [0,90]; %XY
    mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE
    
   [H,sidelenc] = mp.plotVoxelSideFTBoundary(  false,... % As points
                                            false,... % Plot AARB -- remove in this
                                            false,... % Plot axis remove this
                                            true,...  % plot voxel cubes
                                            sidelen,... % sidlentgh
                                            ary,...     % array of particles to drae        
                                            mp.ptot-1); % number of paeticle to draw
end
    
    fprintf('Total particles:%d, Total Collsions %d, Sidelength %d\r\n',mp.ptot-1,mcols,sidelen)
    
fclose all;
