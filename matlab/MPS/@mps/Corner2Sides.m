function Corner2Sides(obj,sl,R)

if 1
% #1
    for layer = 2:1:sl
        for row = 0:sl:sl
            for col = sl:sl:sl
                obj.AddParticleBoundary(col+1,row+1,layer,...
                                    R,...
                                    col+1,row+1.0,0.0);
            end
        end
    end
end
if 1
% #2
    for layer = 2:1:sl
        for row = 0:sl:sl
            for col = 1:sl:sl
                obj.AddParticleBoundary(col,row+1,layer,...
                                    R,...
                                    col,row+1.0,0.0);
                %obj.AddParticleBoundary(col+1,row+1,layer,...
                %                    R,1,...
                %                    col+1.0,row+1.0,0.0,0.0,0.0,"He");
            end
        end
    end
end
if 1
% #3
    for layer = 0:sl:sl
        for row = 0:sl:sl
            for col = 2:1:sl
                obj.AddParticleBoundary(col,row+1,layer+1,...
                                    R,...
                                    0.0,row+1,layer+1.0);
            end
        end
    end
end
if 1
% #4
    for layer = 0:sl:sl
        for row = 2:1:sl
            for col = 0:sl:sl
                obj.AddParticleBoundary( col+1,row,layer+1,...
                                    R,...
                                    col+1.0,0,layer+1.0);
            end
        end
    end
end

end