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
function CalcVelocity(obj,P)
% CalcVelocity(obj,P)
% P =   Particle number

% Debug a selected frame.
if obj.m_iter == 44
    1;
end 

    % Assign current instance to shorter version.
    N=obj.p(P).nc;

    % Clear the last total accelerations.
    obj.p(P).acc_x = 0.0;
    obj.p(P).acc_y = 0.0;
    obj.p(P).acc_z = 0.0;

    % If this is being called during a collision then
    % add the all collison instance acceleration components and assign
    % to total change in acceleration.
    if N ~= 0
        obj.p(P).inCol = 1;
        for ii = 1:N
            obj.p(P).acc_x = round(obj.p(P).acc_x+obj.p(P).cs(ii).acc_x,6,'decimals');   
            obj.p(P).acc_y = round(obj.p(P).acc_y+obj.p(P).cs(ii).acc_y,6,'decimals');   
            obj.p(P).acc_z = round(obj.p(P).acc_z+obj.p(P).cs(ii).acc_z,6,'decimals');   

if 0 %======================== EVAL-DBG =====================
                if P == 1
                fprintf("Accel P%d,N:%d[%0.6f,%0.6f,%0.6f]\r\n",...
                   P,ii,obj.p(P).acc_x,obj.p(P).acc_y,obj.p(P).acc_z);
                end
end %======================== EVAL-DBG =====================
        end
        % If in collision increment cflg
        obj.p(P).cflg = obj.p(P).cflg+1;
        if obj.p(P).cflg == 1 
            obj.p(P).sang_xy = obj.p(P).cs(N).ang_xy;
            obj.p(P).sang_yz = obj.p(P).cs(N).ang_yz; 
            obj.p(P).sang_xz = obj.p(P).cs(N).ang_xz; 
        end
    % If out of collision and cflg > 1 set cflg to -1    
    elseif (obj.p(P).cflg > 0)
        obj.p(P).inCol = 0;
        obj.p(P).cflg = -1;

if 0 %======================== EVAL-DBG =====================     
    fprintf('Num InColl:%d\r\n',obj.p(P).cflg); 
end %======================== EVAL-DBG =====================
 
if 0 %======================== EVAL-DBG =====================
        if P==1
         fprintf("Velocity Out Collision P%d,[%0.6f,%0.6f,%0.6f]\r\n",...
                   P,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);
         fprintf("Ang Out Coll P%d xy=%0.4f,yz=%0.4f,xz=%0.4f\r\n",...
            P,obj.p(P).sang_xy,...
            obj.p(P).sang_yz,...
            obj.p(P).sang_xz);
        end
end %======================== EVAL-DBG =====================

    end


if 0  %======================== EVAL-DBG =====================  
        if (obj.p(P).cflg == 1)
            
            fprintf("Velocity In Collision P%d,[%0.4f,%0.4f,%0.4f]\r\n",...
                   P,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);
            fprintf("Ang In Coll P%d xy=%0.4f,yz=%0.4f,xz=%0.4f\r\n",...
            P,obj.p(P).cs(N).ang_xy,...
            obj.p(P).cs(N).ang_yz,...
            obj.p(P).cs(N).ang_xz);
        
        end
end  %======================== EVAL-DBG =====================
if 0 %======================== EVAL-DBG =====================
    %if P == 1
    fprintf("Velocity IN P%d,[%0.6f,%0.6f,%0.6f]\r\n",...
               P,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);
    %end
end %======================== EVAL-DBG =====================

    % Calulate change in velocity vector components by adding themselves to
    % total acceleration components.
    obj.p(P).vx = round(obj.p(P).vx+obj.p(P).acc_x,4,'decimals');   
    obj.p(P).vy = round(obj.p(P).vy+obj.p(P).acc_y,4,'decimals');   
    obj.p(P).vz = round(obj.p(P).vz+obj.p(P).acc_z,4,'decimals');   

if 0 %======================== EVAL-DBG =====================
    %if P == 1
    fprintf("Velocity OUT P%d,[%0.6f,%0.6f,%0.6f]\r\n",...
               P,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);
    %end
end %======================== EVAL-DBG =====================

if 1 %======================== EVAL-DBG =====================
    obj.p(P).vxary(obj.m_iter) = obj.p(P).vx;
    obj.p(P).vyary(obj.m_iter) = obj.p(P).vy;
    obj.p(P).vzary(obj.m_iter) = obj.p(P).vz;
end %======================== EVAL-DBG =====================

    magv = norm([obj.p(P).vx,obj.p(P).vy,obj.p(P).vz]);
    obj.p(P).loc(1,obj.m_iter) = magv;   
    
    % if out of collision check to see momentum is conserved
    % if not correct it.
    if (obj.p(P).cflg < 0)
        obj.p(P).cflg = 0;
        
 
        if(magv ~= obj.p(P).vtemp)
            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz]...
             = obj.CorrectVelocity(P,obj.p(P).vtemp,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);    
                
if 0 %======================== EVAL-DBG =====================
            fprintf("Velocity Mag Not restored P%d,in:%0.4f,out:%0.4f,[%0.4f,%0.4f,%0.4f]\r\n",...
               P,obj.p(P).vtemp,magv,obj.p(P).vx,obj.p(P).vy,obj.p(P).vz);
end %======================== EVAL-DBG =====================

        end
    end
    
    
    % Move particle positoon based on velocity and times step.
    obj.p(P).rx = round(obj.p(P).rx+obj.p(P).vx*obj.dt,6,'significant');   
    obj.p(P).ry = round(obj.p(P).ry+obj.p(P).vy*obj.dt,6,'significant');
    obj.p(P).rz = round(obj.p(P).rz+obj.p(P).vz*obj.dt,6,'significant');
    
if 0 %======================== EVAL-DBG =====================
    fprintf("Pos P%d,[%0.4f,%0.4f,%0.4f]\r\n",...
           P,obj.p(P).rx,obj.p(P).ry,obj.p(P).rz);
end %======================== EVAL-DBG =====================

    % Reset collison instance structure.
    obj.p(P).nc = 0;
    obj.p(P).cs = StructColls();
    

    
end