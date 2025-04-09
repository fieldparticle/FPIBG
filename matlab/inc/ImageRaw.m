%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = ImageRaw(FileName,Width,Height,Angle)

	Name = '';
	[pth,Name,ext] 	= fileparts(FileName);
	printf('This is ImageRaw - %s\r\n',Name);
	
	latex_fl = sprintf('..\\images\\%s.tex',Name);
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'\\begingroup\r\n');
	fprintf(ltx,'\\begin{Figure}\r\n');
	fprintf(ltx,'\\begin{center}\r\n');
	if(Angle ~= 0)
		fprintf(ltx,'\\begin{turn}{90}\r\n');
	end
	fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt]{../images/%s}',Width,FileName));
	if(Angle ~= 0)
		fprintf(ltx,'\\end{turn}\r\n');
	end
	%fprintf(ltx,'\37 The label tag must always be below the caption since it\r\n \37 will cause references to come out in roman numerals');
	fprintf(ltx,'\\end{center}\r\n');
	fprintf(ltx,'\\end{Figure}\r\n');
	fprintf(ltx,'\\endgroup\r\n');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	fprintf(ltx,'%%============================================= Image %s \r\n',Name);
	fprintf(ltx,'%s',sprintf('\\input{../images/%s.tex}\r\n',Name));
	fprintf(ltx,'%s',sprintf('\\ref{fig:%s}\r\n',Name));
	
	
	if(ltx<0)
		printf('ImageRaw - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fclose(ltx);
	end


