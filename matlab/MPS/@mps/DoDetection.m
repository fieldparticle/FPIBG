%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/DetectWallIsect.m $
% $Id: DetectWallIsect.m 5 2023-03-14 21:48:38Z jb $
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
%@head3 		Description. | Perform broad detection. For each particle
%               detect which voxel in which it resides.
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 5 $
%*
%*
%******************************************************************/
function DoDetection(obj,P)
% DoDetection(obj,P)
%   P   = Particle number.

 if P == 4 || P == 191
     1;
 end
    % Get the position of the particle in whole numbers.
    obj.p(P).xpos               = uint32(obj.p(P).rx);
    obj.p(P).ypos               = uint32(obj.p(P).ry);
    obj.p(P).zpos               = uint32(obj.p(P).rz);
    obj.p(P).zpos               = uint32(obj.p(P).rz);

    cx               = obj.p(P).rx;
    cy               = obj.p(P).ry;
    cz               = obj.p(P).rz;
    R                = obj.p(P).radius;
    

    loc = zeros(6,3);

    CX = 1;
    CY = 2;
    CZ = 3;
  
    ploc = [0,0,0];

    
    loc(1,:) = round([cx+R,cy+R,cz+R]);
    loc(2,:) = round([cx-R,cy+R,cz+R]);
    loc(3,:) = round([cx+R,cy-R,cz+R]);
    loc(4,:) = round([cx-R,cy-R,cz-R]);
    loc(5,:) = round([cx+R,cy+R,cz-R]);
    loc(6,:) = round([cx-R,cy-R,cz+R]);
    loc(7,:) = round([cx-R,cy+R,cz-R]);
    loc(8,:) = round([cx+R,cy-R,cz-R]);

 
	if P == 3
    for jj = 1:obj.MAX_CORNERS
        for kk = 1:obj.MAX_CORNERS
            if (jj ~= kk)
                if(loc(jj,1) == loc(kk,1) && loc(jj,2) == loc(kk,2) && loc(jj,3) == loc(kk,3))
                    loc(kk,1) = 0;
                    loc(kk,2) = 0;
                    loc(kk,3) = 0;
                end

            end					
        end
    end
    end
    
    for ii=1:obj.MAX_CORNERS
        if(loc(ii,CX) ~= 0 && loc(ii,CY) ~= 0 && loc(ii,CZ) ~= 0)
        
            % If particle number stored at current vcube is not
            % equal to this particle number and is not zero, then 
            % build link list
            if (obj.m_C(loc(ii,CX),loc(ii,CY),loc(ii,CZ)) ~= obj.p(P).pnum) 
    
                % Dont duplicate and only write if loc is not equal to zero.
                %if (obj.m_C(loc(ii,CX),loc(ii,CY),loc(ii,CZ)) ~= 0) 
                        obj.p(P).zlink(ii,1) = loc(ii,CX);
                        obj.p(P).zlink(ii,2) = loc(ii,CY);
                        obj.p(P).zlink(ii,3) = loc(ii,CZ);
                        obj.p(P).zlink(ii,4) = ...
                                obj.m_C(loc(ii,CX),loc(ii,CY),loc(ii,CZ));
                        ploc(:) = loc(ii,:);
                %end
            end
                
            
           obj.m_C(loc(ii,CX),loc(ii,CY),loc(ii,CZ)) = obj.p(P).pnum;
        end
    end    

    



end
