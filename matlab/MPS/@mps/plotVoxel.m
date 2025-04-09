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
function  plotVoxel(obj,numVox)

    figure(1)
    clf
    hold on
    for P = 1:obj.ptot-1
        obj.PlotParticle(P);
    end
    
   
    
    if obj.voxCnt == 8
         plotcube([1.0,1.0,1.0],[11.5,11.5,0.5],0.3,[0.0,1.0,0.0]);
        plotcube([1,1,1],[11.5,11.5,1.5],0.3,[0.0,0.0,1.0]);
        plotcube([1,1,1],[12.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        plotcube([1,1,1],[12.5,12.5,1.5],0.3,[1.0,0.0,1.0]);
    
        plotcube([1,1,1],[12.5,11.5,0.5],0.3,[0.0,1.0,0.0]);
        plotcube([1,1,1],[12.5,11.5,1.5],0.3,[0.0,0.0,1.0]);
        plotcube([1,1,1],[11.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        plotcube([1,1,1],[11.5,12.5,1.5],0.3,[1.0,0.0,1.0]);
    end
    
    if obj.voxCnt == 4
        %plotcube([1.0,1.0,1.0],[11.5,11.5,0.5],0.3,[0.0,1.0,0.0]);
        %plotcube([1,1,1],[11.5,11.5,1.5],0.3,[0.0,0.0,1.0]);
        
        
        
        
        %plotcube([1,1,1],[11.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        %plotcube([1,1,1],[11.5,12.5,1.5],0.3,[1.0,0.0,1.0]);

        plotcube([1,1,1],[12.5,11.5,1.5],0.3,[0.0,0.0,1.0]);
        plotcube([1,1,1],[12.5,11.5,0.5],0.3,[0.0,1.0,0.0]);    
        plotcube([1,1,1],[12.5,12.5,1.5],0.3,[1.0,0.0,1.0]);
        plotcube([1,1,1],[12.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        axis([11.5,13.5,12.0,13.5,0.0,2.0]);
    end
    if obj.voxCnt == 2
        %plotcube([1.0,1.0,1.0],[11.5,11.5,0.5],0.3,[0.0,1.0,0.0]);
        %plotcube([1,1,1],[11.5,11.5,1.5],0.3,[0.0,0.0,1.0]);
        
        
        
        
        %plotcube([1,1,1],[11.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        %plotcube([1,1,1],[11.5,12.5,1.5],0.3,[1.0,0.0,1.0]);

        plotcube([1,1,1],[4.5,5.5,1.5],0.3,[0.0,0.0,1.0]);
        %plotcube([1,1,1],[12.5,11.5,0.5],0.3,[0.0,1.0,0.0]);    
       % plotcube([1,1,1],[12.5,12.5,1.5],0.3,[1.0,0.0,1.0]);
       % plotcube([1,1,1],[12.5,12.5,0.5],0.3,[1.0,1.0,0.0]);
        axis([11.5,13.5,12.0,13.5,0.0,2.0]);
    end

    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on
    axis 'padded';
    axis 'square';
    if obj.VPLType == obj.VPLTXY
    %view xy
    view([0 90]);
    end
    if obj.VPLType == obj.VPLT3D1
    %3-D
    view([25 25]);
    end
    if obj.VPLType == obj.VPLTYZ
    %view yz
    view([90 0]);
    end
    if obj.VPLType == obj.VPLTCUSTOM
        view(obj.VViewAngle);
    end
    margin = 0.25;
   
    if 0
    axis([obj.wary(obj.XMIN)-margin,obj.wary(obj.XMAX)+margin,...
          obj.wary(obj.YMIN)-margin,obj.wary(obj.YMAX)+margin,...
          obj.wary(obj.ZMIN)-margin,obj.wary(obj.ZMAX)+margin]);
    end
    hold off
    obj.MovieSavePlot();


end