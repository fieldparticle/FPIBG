function colCount = CountCollisions(obj)
    
    collisionCount = 0;
    for ii=1:obj.ptot-1
        
        for jj=1:obj.ptot-1
            if(ii == 9 && jj == 191)
                1;
            end
            if (jj~=ii)
                  % Get target position
                xT = obj.p(jj).rx;
                yT = obj.p(jj).ry;
                zT = obj.p(jj).rz;
            
                % Get source position
                xP = obj.p(ii).rx;
                yP = obj.p(ii).ry;
                zP = obj.p(ii).rz;
            
                % Get distance between centers
                dsq = (((xP-xT)^2+(yP-yT)^2+(zP-zT)^2));
               
                % Get combined radii
                rsq = ((obj.p(ii).radius+obj.p(jj).radius)^2);
                
                % if distance is less than cobined radii there is a collision.
                if (dsq<rsq)
                    obj.p(jj).cflg = 1;
                    obj.p(ii).cflg = 1;
                    collisionCount= collisionCount+1;
                    %if mod(ii,1000) == 0
                        
                       fprintf("ColNum %d, FRM:%d,TO:%d dsq=%0.3f rsq = %0.3f \r\n",...
                           collisionCount,ii,jj,dsq,rsq);
                       fprintf("-->FRM:%d,xt=%0.3f,yt=%0.3f,xt=%0.3f\r\n",...
                           ii,xT,yT,zT);
                       fprintf("-->TO:%d,xp=%0.3f,yp=%0.3f,xp=%0.3f\r\n",...
                           ii,xP,yP,zP);

                    %end
                    colary(collisionCount,1) = ii;
                    colary(collisionCount,2) = jj;
                end
            end
        end
    end
    colCount=collisionCount;
end