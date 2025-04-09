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
function CalcAccel(obj,P,N)
% CalcAccel(obj,P)
% P =   Particle number


% Debug a selected frame.
if obj.m_iter == 44
    1;
end
    % NOTE:For Vulkan have it sum instances instead of building a collision
    % structure.
    
    % get the number of the current collision instance.
   %N =obj.p(P).nc;
    obj.p(P).cs(N).acc_x = 0.0;
    obj.p(P).cs(N).acc_y = 0.0;
    obj.p(P).cs(N).acc_z = 0.0;

    % Get the change in velocity in the x-direction.
    % Multiply the magnitude of x-direction vector times
    % the DOP, times the cosine of the xy angle times
    % the force of rejection.
    obj.p(P).cs(N).acc_x =...
    round(obj.p(P).cs(N).rphix*obj.p(P).cs(N).Phi*cos(obj.p(P).cs(N).ang_xy)*obj.p(P).acc_r,2,'decimals');   

    % Get the change in velocity in the y-direction.
    % Multiply the magnitude of y-direction vector times
    % the DOP, times the sine of the xy angle times
    % the force of rejection.
    obj.p(P).cs(N).acc_y =...
    round(obj.p(P).cs(N).rphiy*obj.p(P).cs(N).Phi*sin(obj.p(P).cs(N).ang_xy)*obj.p(P).acc_r,2,'decimals');   
    
    % Get the change in velocity in the z-direction.
    % Multiply the magnitude of z-direction vector times
    % the DOP, times the sine of the xz angle times
    % the force of rejection.
    obj.p(P).cs(obj.p(P).nc).acc_z =...
    round(obj.p(P).cs(N).rphiz*obj.p(P).cs(N).Phi*sin(obj.p(P).cs(N).ang_xz)*obj.p(P).acc_r,2,'decimals');   

if 0 %======================== EVAL-DBG =====================
    if P == 1
    fprintf('P%d, C:%d,[%0.5f,%0.5f,%0.5f]\r\n',...
        P,...
        N,...
        obj.p(P).cs(obj.p(P).nc).acc_x,...
        obj.p(P).cs(obj.p(P).nc).acc_y,...
        obj.p(P).cs(obj.p(P).nc).acc_z);
    end
end %======================== EVAL-DBG =====================

    % Clear trival solution flags
    obj.p(P).cs(N).rphix = 0.0;
    obj.p(P).cs(N).rphiy = 0.0;
    obj.p(P).cs(N).rphiz = 0.0;
end