function  PlotDegAxis(x,y,N)

min_y	= min(y);
max_y	= max(y);
len_yy	= max_y-min_y;
inc_yy	= linspace(min_y,max_y,10);
inc_xx  = x(end)*ones(1,10)-(.1*x(end));
plt_yaxis = [];
for yy = 1:1:length(inc_yy)
	txt = sprintf('%0.2f',inc_yy(yy)*180/pi);
	text(inc_xx(yy),inc_yy(yy),txt)	;
end

end