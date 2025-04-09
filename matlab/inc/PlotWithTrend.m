%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.
function [p htrend hdata]= PlotWithTrend(x,y,RGBColor,Marker,Degree) 
	legend boxoff
	s	= length(x);
	z 	= x;
	p 	= polyfit(z,y,Degree);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% p(1) x^2 + P(2) x +p(3) is form
	%%%%%%%%%%%%%%%%%%%%
	f 	= polyval(p,x);
	xx	= 0:0.01:s;
	yy 	= erf(xx);
	legend boxoff  	
	set (gca, "xaxislocation", "zero")
	set (gca, "yaxislocation", "zero")
	%set(gca,'TickDir','out')
	htrend = plot(x,f,'color',RGBColor,'linewidth', 1,'linestyle','-');
	hdata = plot(x,y,'color',RGBColor);
	
	
end	