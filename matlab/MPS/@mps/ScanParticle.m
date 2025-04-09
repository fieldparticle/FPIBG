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
function ScanSubDivision(obj,P)
% LinkList(obj,P)
% P =   Particle number

array = zeros(1,24);
tindex = 0; 
skip 	= false;
count = 1;    
doneFlag    = false;
P
 if(P==13)
        1;
 end
 dups = []; 
 acount = 0;
    % For each vcube location in zlink
    for ii = 1:obj.MAX_OCCUPANCY
        % if firat zlink location 0 then break
        if(obj.p(P).zlink(ii) ~= 0)
            row = obj.p(P).zlink(ii)+1;
            %fprintf('P:%d,Row:%d \r\n',P,row);
            
            
            % For each particle location in the sub div table
            for col=2:obj.MAX_ARY
                % get the to index
                tindex = obj.SubDivTable{row,col}
                if(tindex == 0)
                    break;
                end
                for dd = 1:acount
                    if (dups(dd) == tindex)
                        skip = true;
                    end
                end
                if(tindex ~= 0 && skip == false)
                    %fprintf('P:%d,Row:%d,Col:%d,Val:%d\r\n',P,row,col,tindex)
                    if(obj.DoSphereCollision(P,tindex) == 1)
                        acount = acount + 1;
                        dups(acount) = tindex;
                      
                    end
                end
                skip = false;
            end
           % fprintf('Row:%d [%d,%d,%d,%d,%d,%d,%d,%d]\r\n',row,aryz);
        end
    end
    




end