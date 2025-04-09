%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/MovieStartPlot.m $
% $Id: MovieStartPlot.m 5 2023-03-14 21:48:38Z jb $
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
function MovieStartPlot(obj)
    
    
    if obj.movie_flg == false
        return
    end
    if not(isfolder(obj.movie_dir))
        mkdir(obj.movie_dir)
    end
    MovName = sprintf('%s/%s.avi',obj.movie_dir,obj.movie_name);  
    obj.writerObj = VideoWriter(MovName);
    obj.writerObj.FrameRate = 10;
    open(obj.writerObj);
   

    fprintf('Start Movie %s.\r\n',MovName);
end



