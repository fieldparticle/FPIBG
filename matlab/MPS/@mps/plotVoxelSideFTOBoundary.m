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
function   plotVoxelSideFTOBoundary(obj,...
                                        AsPoints,...
                                        NumberParticles,...
                                        dimAry,...
                                        orgAry,...
                                        cellAry,...    
                                        from,...
                                        to)
    rng(0,'twister');
    a   = 0.0;
    b   = 1.0;
    
    if length(from) == 1
        for P = from:to
	        if(P==obj.ptot)
		        break;
	        end
            if(AsPoints == false)
                obj.PlotParticleNum(P,NumberParticles);
            else
                obj.PlotParticlePointSingle(P);
            end
        end
     else
        for ii = 1:length(from)
		    if(ii==obj.ptot)
			    break;
		    end
            if(AsPoints == false)
                obj.PlotParticleNum(from(ii),NumberParticles);
            else
                obj.PlotParticlePoint(from(ii));
            end
        end
    end
  for ii=0:cellAry(1)-1
    for jj=0:cellAry(2)-1
        for kk=0:cellAry(3)-1
            plotcube([1.0,1.0,1.0],...
            [ii+0.5,jj+0.5,kk+0.5],...
            0.3,...
            [(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a]);
        end
    end

    plotcube(dimAry,...
    orgAry,...
    0.3,...
    [(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a]);

    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on
    axis 'square';
    %axis([-5.0,dimAry(1)+5.0,-5.0,dimAry(2)+5.0,-5.0,dimAry(3)+5.0]);

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
    
    

end