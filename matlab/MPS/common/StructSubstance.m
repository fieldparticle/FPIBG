%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/common/StructSubstance.m $
% $Id: StructSubstance.m 5 2023-03-14 21:48:38Z jb $
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
function [outstruct, labels]  = StructSubstance()

outstruct       = struct(...
                'name',           "",...  % Name of particle
                'molar_matter',   0,...   % Molarmass of particle [kg/mol]
                'mu',             0.0,... Unit mass
                'matter',         0,...   % Matter one molecule [kg] 
				'radius',		  0.0,... % atomic radius
                'R',              0,...   % Molar gas constant [J/(mol K)
                'k_B',            0.0,... % Boltzman [ (kg m^2)/(s^2 K) ]
				'm_rate',			0,...
			    'vap_temp',       0.0,... % Vaporization temp [K].
                'vel_vap',        0.0,... % Velocity at vaporization. 
                'acc_vap',        0.0,... % Normalized accerlation at vap
                'vel_vapu',        0.0,... % Velocity at vaporization. 
                'acc_vapu',        0.0,... % Normalized accerlation at vap
                'acc_gravu',       0.0,... % Normalized gravity
                'acc_gravt',        0.0,... % Temperature of gravity
                'end',            0);

    labels = {  {'Name','%s','$%s$'},... 
                {'Molar Matter','%s','$%0.3f$'},...
                {'Matter','%s','$%0.3f$'},...
				{'Radius','%s','$%0.3f$'},...
                {'R','$%s$','$%0.3f$'},...
                {'k_B','$%s$','$%0.3f$'},...
                {'\beta','$%s$','$%0.3f$'},...
                {'\gamma','$%s$','$%0.3f$'},...
                {'T_V','$%s$','$%0.3f$'},...
                {'v_V','$%s$','$%0.3f$'},...
                {'T_F','$%s$','$%0.3f$'},...
                {'end','',''}};

end       