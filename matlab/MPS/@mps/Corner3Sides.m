function Corner3Sides(obj,sl,R)

if 1
    for layer = 0:sl:sl
        for row = 0:sl:sl
            for col = 0:sl:sl
                obj.AddParticleBoundary( col+1.0,row+1.0,layer+1.0,...
                                    R,...
                                   col+1.0,row+1.0,layer+1.0);
            end
        end
    end
end



end