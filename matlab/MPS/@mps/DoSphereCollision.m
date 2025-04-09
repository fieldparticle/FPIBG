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
function cret = DoSphereCollision(obj,P,T)
% DoSphereCollision(obj,P,T)
%   P   = Source particle.
%   T   = Target particle.

if(P==T)
        cret = 0;
        return;
end
% Debug a selected frame.
if P == 22
    1;
end
    cret = 0;
    if obj.p(P).nc > 0
        if obj.p(P).cs(obj.p(P).nc).LastTo == T
            return
        end
    end
    % Get target position
    xT = obj.p(T).rx;
    yT = obj.p(T).ry;
    zT = obj.p(T).rz;

    % Get source position
    xP = obj.p(P).rx;
    yP = obj.p(P).ry;
    zP = obj.p(P).rz;


    % Get distance between centers
    dsq = ((xP-xT)^2+(yP-yT)^2+(zP-zT)^2);
    %dsq = round(pdsq, 4, 'significant');
    
    
    % Get combined radii
    rsq = (obj.p(T).radius+obj.p(P).radius)^2;
    
    % if distance is less than cobined radii there is a collision.
    if (dsq<rsq)
        obj.p(P).inCol = 1;
        obj.p(P).cflg = 1;
   
        
        obj.collisionCount = obj.collisionCount+1;
        obj.colary(obj.collisionCount,1) = P;
        obj.colary(obj.collisionCount,2) = T;
       
        cret = 1;
        fprintf("HColNum %d, FRM:%d,TO:%d\r\n",obj.collisionCount,P,T);
    
    end
end
