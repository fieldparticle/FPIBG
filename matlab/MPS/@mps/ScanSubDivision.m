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
function ScanSubDivision(obj)
% LinkList(obj,P)
% P =   Particle number

    array       = zeros(1,24);
    tindex      = 0; 
    skip 	    = false;
    count       = 1;    
    doneFlag    = false;

 
   lenTbl = size(obj.SubDivTable,1);
   % For each row
   for row=1:lenTbl
       
       if row == 2
           1;
       end
       rowary = obj.SubDivTable{row,:}; 
       if(rowary(2) ~= 0)
            for tt = 2:obj.MAX_ARY
                findex = rowary(tt);
                for ss = 2:obj.MAX_ARY
                    if(tt ~= ss)
                        tindex = rowary(ss);
                       
                        if( findex ~= 0 && tindex ~= 0)
                            obj.DoSphereCollision(findex,tindex);
                        end
                    end
                end
            end
       end
   end
 end