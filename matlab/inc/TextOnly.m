%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = TextOnly(Name, TextMatter)

	
	printf('This is TextOnly - %s\r\n',Name);
	latex_fl = sprintf('..\\text\\%s.tex',Name);
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'%s',TextMatter);
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	fprintf(ltx,'=======================text %s =======================\r\n',Name);
	
	fprintf(ltx,'%s',sprintf('\\input{../equations/%s.tex}\r\n',Name));
		if(ltx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fclose(ltx);
end

