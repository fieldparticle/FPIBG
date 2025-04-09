clc
clear all

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
sidelen  = 1;
mp.AddParticle( 1.17,...    % X position
                0.75,...     % Y Position
                0.93,...     % Z Position
                0.20,...    % Radius
                0.003,...     % x velocity
                0.003,...     % y velocity
                0.0,...     % z velocity
                0.0,...     % attraction coefficient
                0.0,...     % repulsion coefficient
                "He");    % Substance    
                
mp.AddParticle(1.15,1.0,1.0,0.20,0.0,0.0,0.0,0.0,0.0,"He");
[H,sidelenc] = mp.plotVoxelSideFT(  false,... % As points
                                            false,... % Plot AARB -- remove in this
                                            false,... % Plot axis remove this
                                            true,...
                                            sidelen,... % sidlentgh
                                            ary,...     % array of particles to drae        
                                            mp.ptot-1); % number of paeticle to draw


mp.DoJumpCollision(1,2);