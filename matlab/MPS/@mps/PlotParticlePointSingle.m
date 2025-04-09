%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/PlotParticles.m $
% $Id: PlotParticles.m 5 2023-03-14 21:48:38Z jb $
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
function PlotParticlePointSingle(obj,P)
% CalcAccel(obj,P)
% P =   Particle number
    cllr = [];
    if(obj.p(P).ptype == 1)
        cllr = [1.0,0.0,0.0];
    else
        cllr = [0.0,0.0,1.0];
    end
    plot3(obj.p(P).rx,obj.p(P).ry,obj.p(P).rz,'.','Color',cllr);
    
end