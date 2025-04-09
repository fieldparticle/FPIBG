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
function  plotVoxelVarSide(obj,Xlen,Ylen,Zlen,YAry)
    a   = 0.7;
    b   = 1.0;
     
for ii=0:Xlen-1
    for jj=0:Ylen-1
        for kk=0:Zlen-1
            if(kk > YAry(1) && kk < YAry(2))
                if 1
                    if(RCCDBoundaryTestCases(ii,jj,kk)==true)
                        plotcube([1.0,1.0,1.0],...
                        [ii+0.5,jj+0.5,kk+0.5],...
                        0.7,...
                        [1.0,0.5,0.5]);
                    else
                        plotcube([1.0,1.0,1.0],...
                        [ii+0.5,jj+0.5,kk+0.5],...
                        0.3,...
                        [(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a,(b-a).*rand(1,1) + a]);
                    end
                end
                if 0
                    text(ii,jj+1.0,kk+0.5,sprintf("%d,%d,%d",ii,jj,kk))
                end
            end
        end
    end
end 
    %xlabel('X');
    %ylabel('Y');
   % zlabel('Z');
    set(gca,'XColor', 'none','YColor','none','ZColor','none')
    %grid on
    axis([0.0 28, 0.0, 4.0, 2.0,8.0]);
   % axis 'padded';
    % axis 'square';

    
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