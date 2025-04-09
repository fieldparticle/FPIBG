%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = ImageSingleThesisR2(Name,SingleImage,CapTitle,Caption,Width)

	
	fprintf('This is Single Image Thesis - %s\r\n',Name);
	latex_fl = sprintf('..\\images\\%s.tex',Name);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'\\begin{figure}[htbp]\r\n');
	fprintf(ltx,'\\centering\r\n');
	fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%0.2fin]{%s}',Width,SingleImage));
    
	fprintf(ltx,'%s\r\n',sprintf('\\caption[%s]{%s}',CapTitle,Caption));
	fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));
	
	fprintf(ltx,'\\end{figure}\r\n');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	fprintf(ltx,'%%============================================= Image %s \r\n',Name);
	fprintf(ltx,'%s',sprintf('Fig. \\ref{fig:%s}\r\n',Name));
	fprintf(ltx,'%s',sprintf('\\input{../images/%s.tex}\r\n',Name));
	
	
	
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return
	end
	fclose(ltx);
	end


