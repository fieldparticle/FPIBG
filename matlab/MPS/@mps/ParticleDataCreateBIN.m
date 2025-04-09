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
function ret = ParticleDataCreateBIN(obj,DirName,FileName)
% createParticleData(obj,DirName,FileName)
% Create a particle data file for writing
% DirName = target directory for file
% FileName = file name

    obj.data_name = FileName;
    obj.data_dir = DirName;
    datafl = sprintf('%s/%s.bin',obj.data_dir,obj.data_name);
    if not(isfolder(obj.data_dir))
            mkdir(obj.data_dir)
    end
    obj.data_handle = fopen(datafl, "w");
    if(obj.data_handle<0)
	    fprintf('MPS Data - Could Not Create File %s - Aboting\r\n',datafl)
        ret = 1;
	    return
    end
	    ret = 0;
 
end