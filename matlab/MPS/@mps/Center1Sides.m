function Center1Sides(obj,sl,R)
if 1
%#1
for layer = 2:1:sl
    for row = 0:sl:sl
        for col = 2:1:sl
            obj.AddParticleBoundary( col,row+1,layer,...
                                R,...
                                0.0,row+1.0,0.0);
        end
    end
end
end
if 1
%#2
for layer = 0:sl:sl
    for row = 2:1:sl
        for col = 2:1:sl
            obj.AddParticleBoundary( col,row,layer+1,...
                                R,...
                                0.0,0.0,layer+1.0);
        end
    end
end
end

if 1
%#3
for layer = 2:1:sl
    for row = 2:1:sl
        for col = 0:sl:sl
            obj.AddParticleBoundary( col+1,row,layer,...
                                R,...
                                col+1.0,0.0,0.0);
        end
    end
end
end


end