function r = PlotLegend(HandleArray,TextCell,Location)

	hx	= legend(HandleArray,TextCell);
	legend('left');
	legend boxoff;
	set(hx,'location', Location);
end