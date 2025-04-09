%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2022-10-06 14:07:09 -0400 (Thu, 06 Oct 2022) $
% $HeadURL: https://jbworkstation/svn/svnrootr4/svnmatlab/FieldParticle/@Scene/CalcParticleSubs.m $
% $Id: CalcParticleSubs.m 32 2022-10-06 18:07:09Z jb $
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
%*$Revision: 32 $
%*
%*
%******************************************************************/
function CalcSubstanceProperties(obj)

    % Do velocity/acceleration fields. Each substance divided 
    % by the fastest field. Slower particles will have smaller
    % fields relative to the highest velocity substance.


    % G = 6.673 x 10-11 N m2/kg2
    Gu = 6.673E-11;
    n   = 1.0;    % Number of moles
    Vol = 1.0;    % 1m^3
    rg = (3/(4*pi()))^(1/3);


    % Sort substance structure by asecdning molar matter
    [blah, order] = sort([obj.sl(:).molar_matter],'ascend');
    obj.sl = obj.sl(order);
    % The first in the list is the lightest
    obj.ra = 1;
    % The last is the heavest.
    obj.rs = obj.tot_subst;
    
    %------------------------------------------------------------------
    % Calulate Actual acceration and velocity for each substance
    %------------------------------------------------------------------
    for ii = 1:obj.tot_subst

        obj.slv(ii)             = repmat(StructSubstanceVel(), 1, 1 );
        
        obj.slv(ii).TK          = obj.base_ts:obj.base_te;
        obj.sl(ii).k_B          = obj.sl(ii).R/obj.avgdr;
       
        % Calc ACTUAL most prob. velocity at temp range
        obj.slv(ii).vel     = ( (3*obj.sl(ii).R.*obj.slv(ii).TK)/obj.sl(ii).molar_matter ).^(1/2);
        obj.slv(ii).acc     = obj.slv(ii).vel./obj.dt;

        Fg = (2*obj.sl(ii).molar_matter)/rg^2; 
        ag = Fg/obj.sl(ii).molar_matter;

        %obj.slv(ii).ke_mol  = (1/2)*obj.sl(ii).molar_matter*obj.slv(ii).vel.^2;
        %obj.slv(ii).P_mol   = (2/3)*(n/Vol).*obj.slv(ii).ke_mol;
        %obj.slv(ii).P_p     = obj.slv(ii).P_mol./obj.avgdr;
    end
    
    % The maximum accerlation is the lighest partcile at max temp.
    obj.base_acc_a = obj.slv(obj.ra).acc(end);
    % The maximum velocity is the lighest partcile at max temp.
    obj.base_vel_a     = obj.slv(obj.ra).vel(end);
    % The maximum size is the heaviest particle.
    obj.base_acc_s = obj.sl(end).molar_matter;

    for ii = 1:obj.tot_subst
        
        % Calulate NORMAL accelaration and velocity are all
        % values divided by the maximums
        obj.slv(ii).accu  = obj.slv(ii).acc./obj.base_acc_a;
        obj.slv(ii).velu  = obj.slv(ii).vel./obj.base_vel_a;
  
        % Velocity and acceraltion at vapor phase.
        obj.sl(ii).vel_vap    =...
          ( (3*obj.sl(ii).R.*obj.sl(ii).vap_temp)/obj.sl(ii).molar_matter ).^(1/2);
        obj.sl(ii).acc_vap = obj.sl(ii).vel_vap/obj.dt;
        obj.sl(ii).vel_vapu    = obj.sl(ii).vel_vap/obj.base_vel_a;
        obj.sl(ii).acc_vapu = obj.sl(ii).acc_vap/obj.base_acc_a;
        obj.sl(ii).mu       = obj.sl(ii).molar_matter/obj.sl(end).molar_matter;
        obj.sl(ii).acc_gravu = ag/obj.base_acc_a;
        gidx = find(obj.slv(ii).accu>=obj.sl(ii).acc_gravu);
        obj.sl(ii).acc_gravt = gidx(1)-1;

    end
end


