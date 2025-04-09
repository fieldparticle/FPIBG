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
function DoWallCollision(obj,P)
% DoSphereCollision(obj,P,T)
%   P   = Source particle.

% Debug a selected frame.
if P == 4
    1;
end
    T=1;
    % If no potential wall collsision don't waste time.
    if sum(obj.p(P).wary) == 0
        return
    end

    % Find all wall collisions in the wall array return as a 
    % single array in wall.
    wall = find(obj.p(P).wary>0);

    % Get the length of the resulting array
    wend = length(wall);

    % For each intersectiong wall process the collision.
    for ww = 1:wend
        if(wall(ww) == obj.XMAX)
            xT = obj.p(P).wary(obj.XMAX);
            yT = obj.p(P).ry;
            zT = obj.p(P).rz;
        elseif(wall(ww) == obj.XMIN)
            if P == 3
                1;
            end
            xT = obj.p(P).wary(obj.XMIN);
            yT = obj.p(P).ry;
            zT = obj.p(P).rz;
        elseif(wall(ww) == obj.YMAX)
            yT = obj.p(P).wary(obj.YMAX);
            xT = obj.p(P).rx;
            zT = obj.p(P).rz;
        elseif(wall(ww) == obj.YMIN)
            yT = obj.p(P).wary(obj.YMIN);
            xT = obj.p(P).rx;
            zT = obj.p(P).rz;
        elseif(wall(ww) == obj.ZMAX)
            zT = obj.p(P).wary(obj.ZMAX);
            xT = obj.p(P).rx;
            yT = obj.p(P).ry;
        elseif(wall(ww) == obj.ZMIN)
            zT = obj.p(P).wary(obj.ZMIN);
            xT = obj.p(P).rx;
            yT = obj.p(P).ry;
        else 
            return;
        end
        
        % Get source position
        xP = obj.p(P).rx;
        yP = obj.p(P).ry;
        zP = obj.p(P).rz;
        
        % Get distance between centers
        dsq = ((xP-xT)^2+(yP-yT)^2+(zP-zT)^2);
       % dsq = round(pdsq, 4, 'significant');
        % Get combined radii
        rsq = (obj.p(P).radius)^2;
        
        % if distance is less than cobined radii there is a collision.
        if (dsq<rsq)

            % Add new collision instance for source
            obj.p(P).nc = obj.p(P).nc+1;
            NP = obj.p(P).nc;
            obj.p(P).cs(NP) =  StructColls();     
        
            % Find difference between radii*distance
            % for depth of penetration
            sqdiff = rsq-dsq;
if 1 %======================== EVAL-DBG =====================
    if sqdiff < 0.0
        fprintf('Particle P%d outside boundary\r\n',P);
    end
end
            
            obj.p(P).cs(NP).Phi = sqdiff/(obj.p(P).radius);    
            
if 0 %======================== EVAL-DBG =====================
            if P == 3
            fprintf("Wall Collision P%d,N:%d, PPhi:%0.6f,dsq:%0.6f,rsq:%0.6f,diff=%0.6f\r\n",...
                P,NP,obj.p(P).cs(NP).Phi,dsq,rsq,sqdiff);
            end
end %======================== EVAL-DBG =====================
            % No trival solution for walls due to how 
            % vectors are calulated.
            obj.p(P).cs(NP).rphix = 50.0;
            obj.p(P).cs(NP).rphiy = 50.0;
            obj.p(P).cs(NP).rphiz = 50.0;

if 0 %======================== EVAL-DBG =====================
            fprintf(" Radius P%d, [%0.3f,%0.3f,%0.3f]\r\n",...
                P,obj.p(P).cs(NP).rphix,...
                obj.p(P).cs(NP).rphix,...
                obj.p(P).cs(NP).rphix);
end
            
                
            % DOP can never exceed 1.0. Particles can only intersect 
            % to where the outside edge of coliding particle meets 
            % the center of the particle it is colliding with.
            if obj.p(P).cs(NP).Phi > 0.35
                fprintf('Penetration depth violation: Exceeds 1.0\r\n');
                return;
            end
                
            % Create a point (origin) vector for direction vector of source
            outvec = spc2pt3([xP,yP,zP],[xT,yT,zT]);
            
            % Get all the angles for source. Only requires xy and xz. 
            % xz for testing.
            obj.p(P).cs(NP).ang_xy = atan2piPt([outvec(1),outvec(2)]);
            obj.p(P).cs(NP).ang_yz = atan2piPt([outvec(2),outvec(3)]);
            obj.p(P).cs(NP).ang_xz = atan2piPt([outvec(1),outvec(3)]);
if 0
        if(P==1)
            fprintf("Ang%d xy=%0.6f,yz=%0.6f,xz=%0.6f\r\n",...
                P,obj.p(P).cs(NP).ang_xy,...
                obj.p(P).cs(NP).ang_yz,...
                obj.p(P).cs(NP).ang_xz);
        end
end
                
            obj.CalcAccel(P,NP);
        end
    end    
end
