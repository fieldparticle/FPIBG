%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.
function [pp htrend hdata] = PlotWithSpline(x,y,RGBColor,Marker,breaks, pieces) 
	s	= length(x);
	z 	= x;
	pp	= splinefit (x, y, pieces);  % 11 breaks, 10 pieces
	xx 	= linspace (0,x(1), breaks);
	y2 	= ppval (pp, xx);
	set (gca, "xaxislocation", "zero");
	set (gca, "yaxislocation", "zero");
	%set(gca,'TickDir','out')
	hdata = plot(x,y,'color',RGBColor,'marker',Marker,'linestyle', 'none');
	htrend = plot(xx,y2,'color',RGBColor,'linewidth', 2,'linestyle','-');
	
	
end	