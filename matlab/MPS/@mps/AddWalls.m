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
function AddWalls(obj,Xmax,Xmin,Ymax,Ymin,Zmax,Zmin)
% AddWalls(obj,Xmax,Xmin,Ymax,Ymin,Zmax,Zmin)
%   Xmax,Xmin,Ymax,Ymin,Zmax,Zmin mins and maxes of borders.

    % Set location specific wall data.
    obj.wary = [Xmax,Xmin,Ymax,Ymin,Zmax,Zmin];
end