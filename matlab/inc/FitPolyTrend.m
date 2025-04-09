%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.
function [p xx yy]= PolyTrend(x,y,Degree) 
	s	= length(x);
	length(y);
	z 	= x;
	p 	= polyfit(z,y,Degree);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% p(1) x^2 + P(2) x +p(3) is form
	%%%%%%%%%%%%%%%%%%%%
	f 	= polyval(p,x);
	xx	= 0:0.01:s;
	yy 	= erf(xx);
	
	xx = linspace (min(x), max(x), 101);
	yy = polyval (p, xx); 
end	