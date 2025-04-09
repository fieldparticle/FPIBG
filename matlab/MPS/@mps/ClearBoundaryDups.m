function ClearBoundaryDups(obj)

T = struct2table(obj.p); 
sortedT = sortrows(T, [2,3,4],{'ascend','ascend','ascend'}); 
len = size(sortedT,1)
dellist = [];
for ii = 2:len-1 
    if( table2array(sortedT(ii-1,2)) == table2array(sortedT(ii,2)) &&...
            table2array(sortedT(ii-1,3)) == table2array(sortedT(ii,3)) &&...
                table2array(sortedT(ii-1,4)) == table2array(sortedT(ii,4)))
    %sortedT(ii,:) = [];
   % len=len-1;
    dellist(end+1) = ii;
    fprintf("Dup at:<%d,%d,%d>\r\n:",...
                        table2array(sortedT(ii,2)),...
                        table2array(sortedT(ii,3)),...
                        table2array(sortedT(ii,4)));
    end

end
sortedT(dellist,:)=[];
obj.p = table2struct(sortedT);

nelen = size(obj.p,1);
obj.ptot = 1;
for jj = 1:nelen
    obj.p(jj).pnum = jj;
    obj.ptot = obj.ptot+1;
end

1;


end