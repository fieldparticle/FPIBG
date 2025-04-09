%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date:  $
% $HeadURL:  $
% $Id:  $
%*******************************************************************
%***                         DESCRIPTION                         ***
%*******************************************************************
%@doc
%@module
%			@author: Jackie Michael Bell
%			COPYRIGHT <cp> Jackie Michael Bell
%			Property of Jackie Michael Bell<rtm>. All Rights Reserved.
%			This source code file contains proprietary
%			and confidential information.
%
%
%@head3 		Description. | 
%               
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision:  $
%*
%*
%******************************************************************/
clc
clear all
%close all
ret = 0;
more off





mp      = mps();
% Set the gpu name
%mp.SetGPUName('Quadro M3000M');
% Set the monitor
if 0
    mp.SetMonitor(1,3,0,0);
end
%opengl software;
% Set the number and size of z-layers
mp.SetLayers(20,25);
% Start movie if required.
mp.MovieStartPlot();
% Run configuration file.
%mp.SetTestFile('mpresent')

%mp.SetTestFile('mtest001')
%mp.SetTestFile('mtest002')
mp.SetTestFile('mtest003')
%mp.SetTestFile('mtest004')
run(mp.testName);
if (ret == 1)
    return
end

% Iterate from start frame to end frame
for mm = 1:mp.endFrame

    % set the object iteration value
    mp.m_iter = mm;

 % Report iteration
if 1 %======================== EVAL-DBG =====================    
    fprintf('Iteration:%d\r\n',mp.m_iter);
end 

    % Create/Erase LayersNum layers of 2D amtrix 
    % LayersSize in the Z-direction
    mp.m_C=zeros(mp.LayersSize,mp.LayersSize,mp.LayersSize);
   


if 1% Iterate through all particles and perform
    % chromatic spatial sub division detection.
    for P = 1:mp.ptot-1
        mp.DoDetection(P);
    end
end
    

    % Iterate through all particles
    % Read each link list and process
    % collisions, then set new velocity.
if 1 %======================== EVAL-DBG =====================    
    for P = 1:mp.ptot-1
        mp.LinkList(P);
    end
end
   
    % Iterate through all particles
    % Read each link list and process
    % collisions, then set new velocity.
if 1 %======================== EVAL-DBG =====================
    for P = 1:mp.ptot-1
       mp.CalcVelocity(P);
    end
end

% plot the voxel(s)
if 1 %======================== EVAL-DBG =====================
    mp.VViewAngle = [-39.997172236503850,19.636503856041131]; %ANGLE
    sidelength = CalcSideLen(30,mp.ptot-1)+1;
    [H,sidelenc] = mp.plotVoxelSideFT(false,false,false,sidelength,ary,mp.ptot-1);
end

% Do pause (on/off,endframe) 

    if(mp.DoPause(0,0))
        break;
    end
end
mp.Dump("J:/VCUBEData/analysis",'DUMP343');
fprintf("Collision Count %d\r\n", mp.collisionCount);
% Close and save movie if required.
mp.MovieClosePlot();



