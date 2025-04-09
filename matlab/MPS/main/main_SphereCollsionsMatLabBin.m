clc
clear all
close all

addPathCD('matlab/MPS/main')
THORX         = 1;        % Horizontal X-Axis
THORY         = 2;        % Horizontal X-Axis
THORZ         = 3;   
THORXY        = 4;        % Horizontal Z Axis
THORXYZ       = 5;        % Horizontal Z Axis
THORSKIP      = 6;  
TBOUNDARY     = 7;        % Verticle Yaxis
TDEG45        = 8;        % 45 Degree 
TDEG453       = 9;        % 45 Degree 3D
TREFLECT45    = 10;        % 45 degree reflection
TMULTI        = 11;        % Test multiple concurrent collisions
THORBIN       = 12;

SIDELEN = 2;

TSType = THORXYZ;

F = 1;
T = 2;
mp              = mps();
mp.SetTimeStep(0.001);
mp.SetSystemTemp(250);
% Set the range over which particle properties
% will be calxualted
mp.SetTempRangeLow(1);        % Base temerature low
mp.SetTempRangeHigh(400);        % Base temerature high
% Add the substances.
mp.AddSubstance("He",4.0026022,28,8.3145,-268.9+273.15);
mp.AddSubstance("He2",2*4.0026022,28,8.3145,-268.9+273.15);

mp.CalcSubstanceProperties();

[ret ] = mp.ParticleDataReadBIN("J:/RCCDData/perfdataM","XYZCollisionDataSet",1,0);


 ary=1;

for ii=0:500
    for P=1:mp.ptot-1
        mp.p(F).rx = mp.p(F).rx+mp.p(F).vx;
        mp.p(F).ry = mp.p(F).ry+mp.p(F).vy;
        mp.p(F).rz = mp.p(F).rz+mp.p(F).vz;
    
        mp.p(T).rx = mp.p(T).rx+mp.p(T).vx;
        mp.p(T).ry = mp.p(T).ry+mp.p(T).vy;
        mp.p(T).rz = mp.p(T).rz+mp.p(T).vz;
    
        xT = mp.p(F).rx;
        yT = mp.p(F).ry;
        zT = mp.p(F).rz;
	    
	    xP = mp.p(T).rx;
        yP = mp.p(T).ry;
        zP = mp.p(T).rz;
    
        % Get distance between centers
        dsq = ((xP-xT)^2+(yP-yT)^2+(zP-zT)^2);
        %dsq = round(pdsq, 4, 'significant');
    
        % Get combined radii
        rsq = (mp.p(F).radius+mp.p(T).radius)^2;
        
        % if distance is less than cobined radii there is a collision.
        if (dsq<rsq)
           % fprintf("Collisions at ii=%d\r\n",ii);
    
            [velF,velT] = mp.CalcMom(1,1,...
                                [mp.p(F).rx,mp.p(F).ry,mp.p(F).rz],...
                                [mp.p(T).rx,mp.p(T).ry,mp.p(T).rz],...
                                [mp.p(F).vx,mp.p(F).vy,mp.p(F).vz],...
                                [mp.p(T).vx,mp.p(T).vy,mp.p(T).vz]);
    
            mp.p(F).vx = velF(1);
            mp.p(F).vy = velF(2);
            mp.p(F).vz = velF(3);
            mp.p(T).vx = velT(1);
            mp.p(T).vy = velT(2);
            mp.p(T).vz = velT(3);
        end
        
        [ret,vel] = mp.DoCubeWall(T,SIDELEN);
        if(ret==1)
            mp.p(T).vx = vel(1);
            mp.p(T).vy = vel(2);
            mp.p(T).vz = vel(3);
        end
    
        [ret,vel] = mp.DoCubeWall(F,SIDELEN);
        if(ret==1)
            mp.p(F).vx = vel(1);
            mp.p(F).vy = vel(2);
            mp.p(F).vz = vel(3);
        end
    end
    mp.plotVoxelSideFT(false,false,false,SIDELEN,ary,mp.ptot-1);
end


