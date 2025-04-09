%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = ImageThesis(Name,OutDir,Images,CapTitle,Caption,Zoom)

	
	fprintf('This is Single Image Thesis - %s\r\n',Name);
	latex_fl = sprintf('%s/%s.tex',OutDir,Name);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'\\begin{flushleft}\r\n');
	fprintf(ltx,'\\begin{multiFigure}\r\n');
	
	fprintf(ltx,'\\begin{center}\r\n');
	
	
    for ii = 1:size(Images,2)
       string(Images(ii));
	    fprintf(ltx,'%s\r\n',sprintf('\\addFigure{%0.2f}{%s}',Zoom,string(Images(ii))));
        
    end

	fprintf(ltx,'%s\r\n',sprintf('\\captionof{figure}[%s]{%s}',CapTitle,Caption));
	fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));
	fprintf(ltx,'\\end{center}\r\n');
	fprintf(ltx,'\\end{multiFigure}\r\n');
	fprintf(ltx,'\\end{flushleft}\r\n');
	fclose(ltx);
    prename = sprintf('%s/pre.tex',OutDir);
	ltx = fopen (prename, "a", "ieee-le");
	fprintf(ltx,'%%============================================= Image %s \r\n',Name);
	fprintf(ltx,'%s',sprintf('Fig. \\ref{fig:%s}\r\n',Name));
	fprintf(ltx,'%s',sprintf('\\input{../plots/%s.tex}\r\n',Name));
	
	
	
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return
	end
	fclose(ltx);
	end


