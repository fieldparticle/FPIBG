function [X,Y,Z,NT] = followF(obj,P,x,y,z)

    if P ~= 0
        for ii = 1:8
            if (obj.p(P).zlink(ii,1) == x ...	
                    && obj.p(P).zlink(ii,2) == y ...
                        && obj.p(P).zlink(ii,3) == z)
                    
                X = obj.p(P).zlink(ii,1);
                Y = obj.p(P).zlink(ii,2);
                Z = obj.p(P).zlink(ii,3);
                NT = obj.p(P).zlink(ii,4);
                return;
             end
        end
    end
     X = 0;
     Y = 0;
     Z = 0;
    NT = 0;
end