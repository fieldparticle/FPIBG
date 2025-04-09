%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/StructColls.m $
% $Id: StructColls.m 5 2023-03-14 21:48:38Z jb $
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
function [outstruct, labels] = StructColls()
% Collision structure holding a single instance collsion

                outstruct           = struct(...  		
...% Intersection Variables i
                'Phi',			    0.0,...			% Depth of penetration
                'rphix',		    0.0,...			% Depth of penetration
                'rphiy',		    0.0,...			% Depth of penetration
                'rphiz',		    0.0,...			% Depth of penetration
                'nc',               0,...           % Collsion instance counter
                'ang_xy',           0.0,...         % xy plane angle
                'ang_yz',           0.0,...         % yz plane angle
                'ang_xz',           0.0,...         % xz plane angle
                'acc_x',            0.0,...         % x acceleration
                'acc_y',            0.0,...         % y accelration
                'acc_z',            0.0,...         % z allectration
                'LastTo',           0,...
				'end',		        0); 
	
end