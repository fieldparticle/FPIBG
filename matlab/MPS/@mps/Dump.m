%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/PlotParticles.m $
% $Id: PlotParticles.m 5 2023-03-14 21:48:38Z jb $
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
function Dump(obj,DirName,FileName)

     datafl = sprintf('%s\\%s.csv',DirName,FileName);
     data_handle = fopen(datafl, "w", "ieee-le");
     if(data_handle<0)
	    fprintf('Dump - Could Not Create File %s - Aboting\r\n',datafl)
        ret = 1;
	    return
     end

    fprintf(data_handle,'P,');
    for ii=1:8
            fprintf(data_handle,'P.zlink[%d].x,P.zlink[%d].x,P.zlink[%d].y,P.zlink[%d].TO,',...
            ii,ii,ii,ii);
    end
    fprintf(data_handle,'\r\n');
    for P = 1:obj.ptot-1
      if 1
          fprintf(data_handle,'%d,',P-1);
      end
        for ii=1:8
           
            fprintf(data_handle,'%d,%d,%d,%d,',...
            uint32(obj.p(P).zlink(ii,1)),...
            uint32(obj.p(P).zlink(ii,2)),...
            uint32(obj.p(P).zlink(ii,3)),...
            uint32(obj.p(P).zlink(ii,4)));
        end
        fprintf(data_handle,'\r\n');

    end
    fclose(data_handle);

end