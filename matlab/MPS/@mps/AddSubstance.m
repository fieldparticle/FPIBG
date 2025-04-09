%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/AddSubstance.m $
% $Id: AddSubstance.m 5 2023-03-14 21:48:38Z jb $
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
function ret = AddSubstance(obj,Name,...        % gas name
                                MolarMass,...   % Molar Mass g/mol
                                AtomicRadius,...% Radius of one mcl in pm
                                R,...           % Gas constant J/(mol-K)
                                VapTemp)      % Vaporization tem K
                                   

    
    obj.tot_subst                   = obj.tot_subst + 1; 
    ii = obj.tot_subst;
    obj.sl(ii).name         = Name;
    obj.sl(ii).molar_matter = MolarMass;
    obj.sl(ii).matter       = MolarMass/obj.avgdr;
    obj.sl(ii).radius       = AtomicRadius;
    obj.sl(ii).R            = R;
    obj.sl(ii).gamma        = 0.0;
    obj.sl(ii).fus_temp     = 0.0;
    obj.sl(ii).vap_temp     = VapTemp;
    if obj.dt == 0
        fprintf('Error - Set time step before adding substance\r\\n')
        return;
    end
    obj.sl(ii).dt           = obj.dt;

    %fprintf('beta=%0.6f, k_B=%0.6f\r\n',... 
    %        obj.sl(ii).beta,...
    %        obj.sl(ii).k_B);
    ret = 0;

end