function outary = DeDup(obj,P)

 
    for jj =1:8
        for kk = 1:8
            if (jj ~= kk)
                if (obj.p(P).zlink(jj,4) == obj.p(P).zlink(kk,4) )
	                obj.p(P).zlink(kk,:) = zeros(1,4);
            end
        end
    end
end