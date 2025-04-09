function [X,Y,Z] = index2loc(index,L)
if 0
  X = (mod((index),(L)));
  Y = ((mod((index/L),(L))));
  Z = ((index)/(L*L));
end
  X = uint32(index/L^2);
  Y = (index-X*L^2)/L;
  Z = index-X*L^2-Y*L

end
