

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
function DoDetectWall(obj,P)
return;
% DoDetectWall(obj,P)
%  See if particle is close to a wall.
% P = Particle number.
    tol = 0.05;
    obj.p(P).wary = [0.0,0.0,0.0,0.0,0.0,0.0];

    % If the particle is close to a boundary record it 
    % in the location specific wary[].
    if obj.p(P).rx+obj.p(P).radius > obj.wary(obj.XMAX)-tol
       obj.p(P).wary(obj.XMAX) =  obj.wary(obj.XMAX);
    end
    if obj.p(P).rx-obj.p(P).radius < obj.wary(obj.XMIN)+tol
       obj.p(P).wary(obj.XMIN) =  obj.wary(obj.XMIN);
    end
    if obj.p(P).ry+obj.p(P).radius > obj.wary(obj.YMAX)-tol
       obj.p(P).wary(obj.YMAX) =  obj.wary(obj.YMAX);
    end
    if obj.p(P).ry-obj.p(P).radius < obj.wary(obj.YMIN)+tol
       obj.p(P).wary(obj.YMIN) =  obj.wary(obj.YMIN);
    end
    if obj.p(P).rz+obj.p(P).radius > obj.wary(obj.ZMAX)-tol
       obj.p(P).wary(obj.ZMAX) =  obj.wary(obj.ZMAX);
    end
    if obj.p(P).rz-obj.p(P).radius < obj.wary(obj.ZMIN)+tol
       obj.p(P).wary(obj.ZMIN) =  obj.wary(obj.ZMIN);
    end
end