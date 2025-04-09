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
function ParticleDataWriteCSV(obj,P)
% writeParticleData(obj,P)
%   write data to an open particle data file.
%   P = particle number.
  
    fprintf(obj.data_handle,'%d,%0.2f,%0.2f,%0.2f,%0.2f,%0.2f,%0.2f,%0.2f,%0.2f,%0.2f\r\n',...
            P,...
            obj.p(P).rx,...
            obj.p(P).ry,...
            obj.p(P).rz,...
            obj.p(P).radius,...
            obj.p(P).vx,...
            obj.p(P).vy,...
            obj.p(P).vz,...
            obj.p(P).acc_r,...
            obj.p(P).acc_a);
end