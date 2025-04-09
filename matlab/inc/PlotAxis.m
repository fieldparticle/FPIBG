
%FontName 	: is the Name of the font.
%FontSize 	: is the size of the font
%Legend		: is a cell(1) containing the lines of the legend.
% 			: on the order they were plotted.
%Example 
%		plot(twp_strain,twp_line,'marker','.','color',[1 0 0]);
%		plot(d_strain_L,d_stress,'linestyle','-','marker','o','color',[red green blue]);
%		plot(twp_strain,mod_line,'marker','d','color',[0 1 0]);
%		lf = cell;
%		lf{1} = sprintf('%s Zoomed Stress-Strain Profile For Thursday 3:30',type_txt);
%		lf{2} = sprintf('Linear fit stress = strain(%0.2e)+(%0.2e) Pa',theta(2),theta(1));
%		lf{3} = sprintf('Linear fit stress = strain(%0.2e-0.002)+(%0.2e) Pa',theta(2),thet%%a(1));
%	 	PlotLegend('Arial',8,lf)
%	
%	Complains about setting font size for courier but does it anyway.
function r = PlotAxis(FontName,FontSize,XAxisText,YAxisText)
	
	hy =  ylabel(YAxisText);
	
	set(hy, "fontsize", FontSize);
	set(hy, "fontname", FontName);
	set(hy, "fontweight",'bold');
    
	
	hx =  xlabel(XAxisText);
	
	set(hx, "fontsize", FontSize);
	set(hx, "fontname", FontName);
	set(hx, "fontweight",'bold');
    
	
end