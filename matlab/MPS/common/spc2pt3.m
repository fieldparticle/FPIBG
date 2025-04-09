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
function outvec = spc2pt3(VecF,VecT)
% spc2pt3(Vec)
%   Transfor space vector to origin vector
%   Vec     = 6 compnent space vector
% returns
%   outvec  = 3 component origin vector

    outvec      = [VecT(1)-VecF(1),VecT(2)-VecF(2),VecT(3)-VecF(3)];
    if size(outvec,2) ~= 3
         fprintf('spc2pt3 outvec elements = %d, should be 3.\r\n',size(outvec,2));
    end
end
