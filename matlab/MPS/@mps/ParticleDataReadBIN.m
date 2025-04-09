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
function [ret, sidelen]  = ParticleDataReadBIN(obj,dirName,fileName,pstart,pend)
% readParticleData(obj,dirName,fileName,numParts)
% Open for reading a particle data file.
%   dirName =  source directory
%   fileName = file name
%   numParts =  number of particles to read
    count = 0;
    sideleng = 0;
    obj.data_name = fileName;
    obj.data_dir = dirName;
    datafl = sprintf('%s/%s.bin',obj.data_dir,obj.data_name);
    obj.data_handle = fopen(datafl, "r");
    if(obj.data_handle<0)
	    fprintf('MPS Data - Could Not Open File %s - Aboting\r\n',datafl)
        ret = 1;
	    return
    end
	    ret = 0;

   
    pary = [0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0,...
            0.0];
    len = length(pary);
    while ~feof(obj.data_handle)
        if (count == pend)
            break;
        end
        pary = fread(obj.data_handle, len,'double');
        count = count + 1;
        if ~isempty(pary) && count >= pstart
            
           P = obj.AddParticle( pary(2),... %rx->X
                            pary(3),...     %ry->Y
                            pary(4),...     %rz->Z
                            pary(5),...     %radius->R
                            pary(6),...     %vx->vx
                            pary(7),...     %vy->vy
                            pary(8),...     %vz->vz
                            pary(10),...     %ptpte
                            pary(11),"He");
        obj.p(P).ptype =  pary(9);
        obj.p(P).ang_xy = pary(11);
        obj.p(P).ang_xz = pary(12);
        obj.p(P).pnum = pary(1);
       
        if(pary(1) ~= count-1)
            fprintf("Lost. Count is %d, Particle number is:%d\r\n",count,pary(1)); 
            %return;
        end
        
            if (obj.p(P).rx > sideleng)
                 sideleng = obj.p(P).rx;
            end
        
            if (obj.p(P).ry > sideleng)
                 sideleng = obj.p(P).ry;
            end
        
            if (obj.p(P).rz > sideleng)
                 sideleng = obj.p(P).rz;
            end
        end
            
    end
  
    
    sidelen = sideleng;   
    obj.ParticleDataCloseBIN();
end

