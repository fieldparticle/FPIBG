
clc
clear all
close all

addPathCD('matlab/MPS/main')


T = readtable("J:/VCUBEData/frameview/Collision.csv");
F = readtable("J:/VCUBEData/frameview/Collision01.csv");

if(size(T,1) ~= size(F,1))
    fprintf("1st Size Mismatch\r\n");
end

TTots = zeros(1,size(T,1));
FTots = zeros(1,size(F,1));

if(size(T,2) ~= size(F,2))
    fprintf("2nd Size Mismatch\r\n");
end
%================================ DUPCheck
dupline = [];
breakflg = 0;
    for kk = 1:size(T,1)
        kk;
       % if breakflg ==1
       %     break;
      %  end
        for ii=1:size(T,2)
            for jj=1:size(T,2)
                if(jj~=ii)
                    if(T{kk,ii} == T{kk,jj} && T{kk,ii} ~= 0 && T{kk,jj} ~= 0 )
                        fprintf("Duplicate T(%d,%d)=%d,",kk,ii,T{kk,ii});
                        fprintf("Duplicate T(%d,%d)=%d.\r\n",kk,jj,T{kk,jj});
                        breakflg=1;
                    end
                end
            end
        end
    end





for ii=1:size(T,1)
    for jj=1:size(T,2)
        TTots(ii) = TTots(ii)+T{ii,jj};
    end

end


for ii=1:size(F,1)
    for jj=1:size(F,2)
        FTots(ii) = FTots(ii)+F{ii,jj};
    end

end

for kk=1:1:size(FTots,1)
    if(FTots(kk) ~= TTots(kk) )
        fprintf("Totals mismatch at %d where T(kk)=%d and F(kk) = %d\r\n",kk,TTots(ii),FTots(ii));
    end

end
