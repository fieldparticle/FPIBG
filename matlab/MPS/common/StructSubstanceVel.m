%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/StructSubstanceVel.m $
% $Id: StructSubstanceVel.m 5 2023-03-14 21:48:38Z jb $
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
function outstruct  = StructSubstanceVel()

outstruct       = struct(...
                'dt',   		0.0,...   	% Time step size
                'TK',         	[],...   	% Temperature K starting from 1K
				'vel',			[],... 		% Array of actual velocity
				'velu',			[],...		% Array normalized velocity		
                'acc',          [],...      % Array actual acceleration.
                'accu',			[],... 		% Array normalized acceleration
				'end',           0);


end       