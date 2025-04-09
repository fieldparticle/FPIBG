function side = CalcSideLen(obj,ppercell,numparts)

    ii = 0;
    while(1)
        ii = ii+1;
        if(ii*ii*ii*ppercell>=numparts)
            side = ii;
            return;
        end
    end
    side =0;
    return;
end