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
= function [vx,vy,vz] = CorrectVelocity(obj,P,vtemp,ivx,ivy,ivz)
% CalcVelocity(obj,P)
% P         =   Particle number
% vtemp     = magnitude of original velcoity
% ivx       = current x velocity
% ivy       = current y velocity
% ivx       = current z velocity

    % Calulate angles of current velocity.
    obj.p(P).ang_xy = atan2piPt([ivx,ivy]);
    obj.p(P).ang_yz = atan2piPt([ivy,ivz]);
    obj.p(P).ang_xz = atan2piPt([ivx,ivz]);
if 0 %======================== EVAL-DBG =====================
     
    fprintf("OutAng:%d [%0.4f,%0.4f,%0.4f]\r\n",...
            P,...
            obj.p(P).ang_xy,...
            obj.p(P).ang_yz,...
            obj.p(P).ang_xz);
end %======================== EVAL-DBG =====================
    
    % Detect trival solution.
    rphix = 0.0;
    rphiy = 0.0;
    rphiz = 0.0;
    if(abs(ivx) > 1E-8), rphix = 1.0; end    
    if(abs(ivy) > 1E-8), rphiy = 1.0; end    
    if(abs(ivz) > 1E-8), rphiz = 1.0; end   

    % Calulate and return new veocity from orginal velocity
    vx = rphix*vtemp*cos(obj.p(P).ang_xy);
    vy = rphiy*vtemp*sin(obj.p(P).ang_xy);
    vz = rphiz*vtemp*sin(obj.p(P).ang_xz);

if 0 %======================== EVAL-DBG =====================
    fprintf("P%d,InVel:[%0.4f,%0.4f,%0.4f],CoorVel:[%0.4f,%0.4f,%0.4f]\r\n",...
            P,...
            ivx,...
            ivy,...
            ivz,...
            vx,...
            vy,...
            vz);
end %======================== EVAL-DBG =====================

end