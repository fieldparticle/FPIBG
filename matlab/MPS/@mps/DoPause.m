%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/DoPause.m $
% $Id: DoPause.m 5 2023-03-14 21:48:38Z jb $
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
function ret = DoPause(obj,F_Wait,EndIter)
    if F_Wait == 1
    mnuanum=input('Continue (q =quit):','s');
        if mnuanum == 'q'
            ret = 1;
            return
        end
    end

    if EndIter > 0
        if (obj.iter == 40)
            ret = 0;
            return
        end
    end
    ret = 0;
end