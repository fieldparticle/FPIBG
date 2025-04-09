%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = ImageFigure(FileName,Caption,Width,Height,Angle,PlcFlg)

	Name = '';
	[pth,Name,ext] 	= fileparts(FileName);
	fprintf('This is ImageFigure - %s\r\n',Name);
	
	latex_fl = sprintf('..\\images\\%s.tex',Name);
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'\\begingroup\r\n');
	fprintf(ltx,'\\tiny\r\n');
	fprintf(ltx,'\\begin{figure}[%s]\r\n',PlcFlg);
	fprintf(ltx,'\\begin{center}\r\n');
	if(Angle ~= 0)
		fprintf(ltx,'\\begin{turn}{90}\r\n');
	end
	if Height ~= 0
		fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt, height=%dpt]{%s}',Width,Height,FileName));
	else
		fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt]{%s}',Width,FileName));
	end
	if(Angle ~= 0)
		fprintf(ltx,'\\end{turn}\r\n');
	end
	fprintf(ltx,'%s\r\n',sprintf('\\captionof{figure}{ %s}',Caption));
	%fprintf(ltx,'\37 The label tag must always be below the caption since it\r\n \37 will cause references to come out in roman numerals');
	fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));
	fprintf(ltx,'\\end{center}\r\n');
	fprintf(ltx,'\\end{figure}\r\n');
	fprintf(ltx,'\\endgroup\r\n');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	fprintf(ltx,'%%============================================= Image %s \r\n',Name);
	fprintf(ltx,'%s',sprintf('Fig. \\ref{fig:%s}\r\n',Name));
	fprintf(ltx,'%s',sprintf('\\input{../images/%s.tex}\r\n',Name));
	
	
	
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fclose(ltx);
	end


