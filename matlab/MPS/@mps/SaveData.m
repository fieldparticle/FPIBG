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
function SaveData(obj, DirName, FileName)

    obj.ParticleDataCreateBIN(DirName,FileName);
    for P = 1:obj.ptot-1
        pary = [P,...
                obj.p(P).rx,...
                obj.p(P).ry,...
                obj.p(P).rz,...
                obj.p(P).radius,...
                obj.p(P).vx,...
                obj.p(P).vy,...
                obj.p(P).vz,...
                obj.p(P).acc_r,...
                0.0,...
                0.0,...
                0.0...
                ];
         obj.ParticleDataWriteBIN(pary);
    end
    fprintf("Total count:%d\r\n",obj.ptot-1)
    obj.ParticleDataCloseBIN();

end

