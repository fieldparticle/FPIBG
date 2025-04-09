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
function [L,X,Y,NT] = follow(obj,L,x,y,P)
% [L,X,Y,NT] = follow(obj,L,x,y,P)
% Read the link list for a leaf particle to determine if it links to
% another leaf. Each particle has a 4x4 link list that may contain up to
% four different links. This searches for a link that matches the
% downstream link by comparing, z,x,y to see if it is at the same pixel. If
% it is not it returns all zeros.

    if P ~= 0
        for ii = 1:4
            if obj.p(P).zlink(ii,1) ~= 0 || obj.p(P).zlink(ii,2) ~= 0
                if (obj.p(P).zlink(ii,1) == L ...
                    && obj.p(P).zlink(ii,2) == x ...
                        && obj.p(P).zlink(ii,3) == y)
                    
                    L = obj.p(P).zlink(ii,1);
                    X = obj.p(P).zlink(ii,2);
                    Y = obj.p(P).zlink(ii,3);
                    NT = obj.p(P).zlink(ii,4);
                    return;
                end
            end
        end
    end
        L = 0;
     X = 0;
     Y = 0;
    NT = 0;
end