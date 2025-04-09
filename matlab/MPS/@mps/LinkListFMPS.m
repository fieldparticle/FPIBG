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
function LinkListSeq(obj,P)
% LinkList(obj,P)
% P =   Particle number
breakpoint = false;
if (P == 164)
    breakpoint = true;
end
    skip = false;
    dupchk = [0];
    chknum = 1;
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
            while 1
                 for dd = 1:chknum-1
                    if T == dupchk(dd) 
                        skip = true;
                    end
                 end

                    % Collision from P to T
                if(skip == true)
                    break;
                end

                    if(obj.DoSphereCollision(P,T) == 1)
                        dupchk(chknum) = T;
                        if (breakpoint == true)
                            fprintf('Collision ii=%d %d\r\n',ii,dupchk(chknum));
                        end
                        chknum = chknum + 1;
                        
                    end
                    skip = false;
               

                [X,Y,Z,T] = obj.followF(T,X,Y,Z);

                if (breakpoint == true)
                    fprintf('Follow ii:%d P%d to T%d [%d,%d,%d,%d]\r\n',ii,P,T,X,Y,Z,T) ;
                end
                

                
                if T == 0 || T == P
                    break;
                end
                skip = false;       
            end
        end

    end

end