%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.
function [hdata]= PlotBars(h,x,y,RGBColor) 
	hdata = bar(x,y,'facecolor',RGBColor) ;
	set(gca,'TickDir','out')	
	set(gca, "xaxislocation", 'zero')
	set(gca, "yaxislocation", 'left')
	
	
end	
