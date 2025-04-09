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
function [H,sideLen] =  plotVoxelSideFTBoundary(obj,AsPoints,...
                                        drawb,...
                                        AARB,...
                                        PlotAxis,...
                                        plotCells,...
                                        sideleng,...
                                        from,...
                                        to)
    rng(0,'twister');
    a   = 0.0;
    b   = 1.0;
    H = figure(1);
    clf
    hold on
    if 1
    if length(from) == 1
        for P = from:to
		    if(P==obj.ptot)
			    break;
		    end
            %if (obj.p(P).ptype == 1)
                if(AsPoints == false)
                    obj.PlotParticle(P);
                else
                    obj.PlotParticlePointSingle(P);
                end
            %end
        end
    else
        for ii = 1:length(from)
		    if(ii==obj.ptot)
			    break;
		    end
            if(AsPoints == false)
                obj.PlotParticle(from(ii));
            else
                obj.PlotParticlePoint(ii);
            end
        end
    end
    end


    loc = zeros(6,3);
   

    if(AARB ~= 0)
        cx               = obj.p(AARB).rx;
        cy               = obj.p(AARB).ry;
        cz               = obj.p(AARB).rz;
        R                = obj.p(AARB).radius;
        plotcube([2*obj.p(AARB).radius,2*obj.p(AARB).radius,2*obj.p(AARB).radius],...
        [obj.p(AARB).rx-obj.p(AARB).radius,...
        obj.p(AARB).ry-obj.p(AARB).radius,...
        obj.p(AARB).rz-obj.p(AARB).radius],0.3,[0.0,0.0,1.0]);
        loc(1,:) = [cx+R,cy+R,cz+R];
        loc(2,:) = [cx-R,cy+R,cz+R];
        loc(3,:) = [cx+R,cy-R,cz+R];
        loc(4,:) = [cx-R,cy-R,cz-R];
        loc(5,:) = [cx+R,cy+R,cz-R];
        loc(6,:) = [cx-R,cy-R,cz+R];
        loc(7,:) = [cx-R,cy+R,cz-R];
        loc(8,:) = [cx+R,cy-R,cz-R];
        for ii = 1:8
           obj.PlotPoint(loc(ii,1),loc(ii,2),loc(ii,3),0.01,[1.0,0.0,0.0]);
        end
    end
    if plotCells == true
      sideleng = round(sideleng);
      for ii=0:sideleng-1
        for jj=0:sideleng-1
            for kk=0:sideleng-1
                plotcube([1.0,1.0,1.0],...
                [ii+0.5,jj+0.5,kk+0.5],...
                0.3,...
                [(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a]);
            end
        end
    end
end
    if (PlotAxis == true)
        obj.plotCenters(0.5,1.5,0.5);
    end
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on
   % axis 'padded';
    %axis([0.5,1.5,0.5,1.5]); 'square';

    %axis([0.5, sideleng+1 ,0.5, sideleng+1 ,0.5, sideleng+1]);
    if obj.VPLType == obj.VPLTXY
    %view xy
    view([0 90]);
    end
    if obj.VPLType == obj.VPLTXZ
    %view xy
    view([0 0]);
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
        if(~isempty(obj.VViewAngle))
            view(obj.VViewAngle);
        end
    end
    ax = gca;
    if(~isempty(obj.CameraPos))
        ax.CameraPosition = obj.CameraPos;
    end
    if(~isempty(obj.CameraTarget))
        ax.CameraTarget = obj.CameraTarget;
    end
    if(~isempty(obj.CameraViewAngle))
        ax.CameraViewAngle = obj.CameraViewAngle;
    end
    
    hold off
    


    %obj.MovieSavePlot();

    sideLen = round(sideleng);
end