function h = PlotStart(FigNum)
	h 			= figure(FigNum);
	clf
	if 0
        FN 			= findall(h,'-property','FontName');
        W 			= 7;
        H 			= 4.5;
        FS 			= findall(h,'-property','FontSize');


        set(FN,'FontName','Arial');
        set(FS,'FontSize',12);

        set(h,'PaperUnits','inches')
        set(h,'PaperOrientation','landscape')

        set(h,'PaperSize',[H,W])
        set(h,'PaperPosition',[0,0,W,H])
    end
        
        clf
        hold on
end

