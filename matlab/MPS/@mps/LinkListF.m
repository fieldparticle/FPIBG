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
function LinkListF(obj,P)
% LinkList(obj,P)
% P =   Particle number
breakpoint = false;
if (P == 343)
    breakpoint = true;
end
    count = 0;
    skip = false;
    dupchk = [0];
    chknum = 0;
    for ii = 1:8
          
          X = obj.p(P).zlink(ii,1);    
          Y = obj.p(P).zlink(ii,2);    
          Z = obj.p(P).zlink(ii,3);
          T = obj.p(P).zlink(ii,4);

          if (breakpoint == true)
               fprintf('Follow ii:%d P%d to T%d [%d,%d,%d,%d]\r\n',ii,P,T,X,Y,Z,T) ;
          end
         % Assign the index varible
         if T ~= 0
            while count < 60
                count = count +1;
                 for dd = 1:chknum-1
                    if T == dupchk(dd) 
                        skip = true;
                    end
                 end
                 chknum = chknum + 1;
                 dupchk(chknum) = T;
                 if 1
                 if(P == T || T == 0)
                       break;
                 end
                 end
                 
                    % Collision from P to T
                if(skip ~= true && P ~= T && T ~= 0)
                    if(obj.DoSphereCollision(P,T) == 1)
                        
                        if (breakpoint == true)
                            fprintf('Collision ii=%d %d\r\n',ii,dupchk(chknum));
                        end
                        
                        
                    end
                else
                    skip = false;
                end

                [X,Y,Z,T] = obj.followF(T,X,Y,Z);

                    if (breakpoint == true)
                        fprintf('Follow ii:%d P%d to T%d [%d,%d,%d,%d]\r\n',ii,P,T,X,Y,Z,T) ;
                    end
                
                
                skip = false;       
            end
        end

    end

end