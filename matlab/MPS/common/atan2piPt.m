%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/atan2piPt.m $
% $Id: atan2piPt.m 5 2023-03-14 21:48:38Z jb $
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
function angle = atan2piPt(Pt)
% atan2piPt(Pt)
%   Get angle on 0-360deg scale so we don't have to use sperical 
%   coordinates.
% Pt    = origin vector 
      
    angle = mod(atan2(Pt(2),Pt(1)),2*pi());
    if size(angle,2) > 1
         fprintf('atan2piPt angle elements = %d, should be 1\r\n',size(angle,2));
    end
end
