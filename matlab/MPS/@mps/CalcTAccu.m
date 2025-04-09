%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/CalcTAccu.m $
% $Id: CalcTAccu.m 5 2023-03-14 21:48:38Z jb $
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
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 5 $
%*
%*
%******************************************************************/
function us_acc = CalcTAccu(obj,N,T)
    % Calculate unit acceleration for the acceleration field.
    % The acceleration field is large for small particles.
    vel = ( (3*obj.sl(obj.p(N).sln).R.*T)/obj.sl(obj.p(N).sln).molar_matter ).^(1/2);
    us_acc = vel/obj.dt;
    us_acc = us_acc/obj.base_acc_a;
    
end