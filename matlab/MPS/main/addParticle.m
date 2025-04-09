%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date:  $
% $HeadURL:  $
% $Id:  $
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
%               
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision:  $
%*
%*
%******************************************************************/
function [count,pcount] = addParticle(mp,colfrm,colto,xx,yy,zz,RR,cell_numx,cell_numy,cell_numz,num_parts,totparts,pincell,cincell,pcount)

    num_parts =num_parts + 1;
    if(count <= pincell)
        xx = 1.5+cell_numx;
        yy = 1.5+cell_numy;
        zz = 1.5+cell_numz;
        mp.AddParticle(xx,yy,zz,RR,0.0,0.0,0.0,-1.9,0.0,"HE");
    end
    if(count == pincell ||num_parts > totparts )
        return;
    end


end


