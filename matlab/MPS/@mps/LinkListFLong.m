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
function LinkListFLong(obj,P)
% LinkList(obj,P)
% P =   Particle number
if   P == 156
    1;
end
    skip = false;
    dupchk = [0];
    chknum = 1;
    for ii = 1:8
          
          if   P == 156
                fprintf('Follow P%d to T%d [%d,%d,%d,%d]\r\n',...
                            P,...
                            obj.p(P).zlink(ii,4),...
                            obj.p(P).zlink(ii,1) ,...
                            obj.p(P).zlink(ii,2) ,...
                            obj.p(P).zlink(ii,3) ,...
                            obj.p(P).zlink(ii,4)) ;
            end
        % Assign the index varible
        T = P;
         if(T == 114&& P == 156)
               1;
           end
        if obj.p(T).zlink(ii,4) ~= 0
          
            for dd = 1:chknum-1
                    if obj.p(P).zlink(ii,4) == dupchk(dd) 
                        skip = true;
                    end
                end
            % Collision from P to T
            if(skip ~= true)
                if(obj.DoSphereCollision(P,obj.p(T).zlink(ii,4)) == 1)
                    dupchk(chknum) = obj.p(T).zlink(ii,4);
                    chknum = chknum + 1;
                end
            else
                skip = false;
            end
            X = obj.p(T).zlink(ii,1);    
            Y = obj.p(T).zlink(ii,2);    
            Z = obj.p(T).zlink(ii,3);
            T = obj.p(T).zlink(ii,4);
        
            while 1
                [X,Y,Z,T] = obj.followF(T,X,Y,Z);
                 if(T == 114 && P == 156)
               1;
           end
                 if P == 156
                        fprintf('Front Follow P%d to T%d [%d,%d,%d,%d]\r\n',...
                                P,...
                                T,...
                                X,...    
                                Y,...
                                Z,...
                                T);
                    end
                for dd = 1:chknum-1
                    if T == dupchk(dd) 
                        skip = true;
                    end
                end

                
                if T == 0 
                    break;
                else
                    if (skip ~= true)
                        if (obj.DoSphereCollision(P,T) == 1)
                            dupchk(chknum) = T;
                            chknum = chknum +1;
                        end
                    end
                    
                   
                end
            skip = false;       
            end
            
            
        end

    end

end