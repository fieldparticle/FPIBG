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
function PlotPoint(obj,rx,ry,rz,radius,CLR)
% CalcAccel(obj,P)
% P =   Particle number

       
    % Make unit sphere
    [x,y,z] = sphere;
    % Scale to desire radius.
    
    x = x * radius;
    y = y * radius;
    z = z * radius;
    % Translate sphere to new location.
    % Plot as surface.
    h = surf(x+rx,y+ry,z+rz,'FaceColor',CLR,'FaceAlpha',1.0);%,'LineStyle',"none") ;
    if 0 %======================== EVAL-DBG =====================
         t=text(rx,ry+radius+0.03,rz,sprintf('%d',P));
        t.FontSize = 14;
    end %======================== EVAL-DBG =====================
end
