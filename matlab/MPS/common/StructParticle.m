%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/StructParticle.m $
% $Id: StructParticle.m 5 2023-03-14 21:48:38Z jb $
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
function outstruct = StructParticle()

                pstruct           = struct(...  		
			    'pnum',			    0,...   % Particle number.
				'rx',               0,...   % float x position
                'ry',               0,...   % float y Position
                'rz',               0,...   % float z Position
				'vx',               0.0,...   % x velocity  
                'vy',               0.0,...   % y velocity  
                'vz',               0.0,...   % z velocity  
				'ptype',			0,...	% 1 = bundary, 0 = partivle
                'seq',              0.0,... %Sequence    
                'inCol',            0,...   % in Collision flag
			    'xpos',             0,...   % uint x position
                'ypos',             0,...   % uint y Position
                'zpos',             0,...   % uint z Position
               	'color',			[0.0,1.0,1.0],...
				'molar_matter',		0.0,...
                'ang_xy',           0.0,... % xy plane angle for velocity
                'ang_yz',           0.0,... % yz plane angle for velocity
                'ang_xz',           0.0,... % xz plane angle for velocity
                'vel_vec',          [0.0,0.0,0.0],... % Original vel vector
                'acc_x',            0.0,... % Total acceleration x
                'acc_y',            0.0,... % Total acceleration y
                'acc_z',            0.0,... % Total acceleration z
				'radius',			0,...   % Radius
                'zlink',           zeros(1,8),... % Front link list
				'nc',				0,...	% Number of collisions
                'cs',				StructColls(),... % collision structure
                'loc',              [0,0],... % store braod detection
                'acc_r',            0.0,...   % Rejection accelration  
                'acc_a',            0.0,...   % Attraction accelration  
                'vtemp',             0.0,...  % Original velocity magnitude  
                'vxt',               0.0,...  % Original velocity x
                'vyt',               0.0,...  % Original velocity y  
                'vzt',               0.0,...  % Original velocity z
                'cflg',             0,...       % In collision flag
                'sang_xy',           0.0,...  % not used  
                'sang_yz',           0.0,...  % "  
                'sang_xz',           0.0,...  % "    
                'wary',              [0,0,0,0,0,0,0,0],... % link list...
                'vxary',            [],...  % Storage variable for ploting
                'vyary',            [],...  % Storage variable for ploting
                'vzary',            [],...  % Storage variable for ploting
                'vary',             [],...
                'phiary',           [],...
                'sln',              0,... % Index pointing to the substance type of this particle
                'strend',		        0); 
				
				outstruct = pstruct;

end