%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/spc2pt.m $
% $Id: spc2pt.m 5 2023-03-14 21:48:38Z jb $
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
function outvec = spc2pt(Vec)
% spc2pt(Vec)
%   Transfor space vector to origin vector
%   Vec     = 4 compnent space vector
% returns
%   outvec  = 2 component origin vector

    outvec      = [Vec(3)-Vec(1),Vec(4)-Vec(2)];
    if size(outvec,2) ~= 2
         fprintf('spc2pt outvec elements = %d, should be 2\r\n',size(outvec,2));
    end
end
