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
function ParticleDataReadCSV(obj,dirName,fileName,numParts)
% readParticleData(obj,dirName,fileName,numParts)
% Open for reading a particle data file.
%   dirName =  source directory
%   fileName = file name
%   numParts =  number of particles to read
    obj.data_name = fileName;
    obj.data_dir = dirName;
    datafl = sprintf('%s/%s.csv',obj.data_dir,obj.data_name);
    M = readtable(datafl);
    
    for rr = 1:numParts
    
        obj.AddParticle(M{rr,2},...
                        M{rr,3},...
                        M{rr,4},...
                        M{rr,5},...
                        M{rr,6},...
                        M{rr,7},...
                        M{rr,8},...
                        M{rr,9},...
                        M{rr,10},"He");
    end

end

