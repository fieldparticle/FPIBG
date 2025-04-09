%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = ImageThesisR9(Name,...
							Images,...
							SubCaps,...
							SubLabels,...
							CapTitle,...
							capdir,...
							Zoom,...
							ImgAry,...
							placement,...
							float)

	
	fprintf('This is Single Image Thesis - %s\r\n',Name);
	
	Caption = GetCaptionText(capdir,Name);
	latex_fl = sprintf('..\\images\\%s.tex',Name);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	rows = ImgAry(1);
	cols = ImgAry(2);
	
	if (float == true)
	    fprintf(ltx,'\\begin{figure*}[%s]\r\n',placement);
    else
        fprintf(ltx,'\\begin{figure}[%s]\r\n',placement);
    end
	fprintf(ltx,'\\centering\r\n');
    imgnum = 1;
	if size(Images,2) > 1
		for rr = 1:rows
    	fprintf(ltx,'\\vfill\r\n');
	
			for cc = 1:cols
				if imgnum > size(Images,2)
					break;
				end
				fprintf(ltx,'\\begin{subfigure}{%0.2f\\linewidth}\r\n %s\r\n',...
					Zoom,...
					sprintf('\\includegraphics[width=\\textwidth]{%s}',...
						string(Images(imgnum))));
				fprintf(ltx,'\\caption{%s}\r\n',string(SubCaps(imgnum)));
				fprintf(ltx,'\\label{subfig:%s}\r\n',string(SubLabels(imgnum)));
				fprintf(ltx,'\\end{subfigure}\r\n');
				fprintf(ltx,'\\qquad\r\n');
	
				imgnum =imgnum +1;
			end
			%fprintf(ltx,'}\r\n');
		end	
	else
		
		fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%0.2fin]{%s}',Zoom,string(Images(1))));
	end
			
	
	fprintf(ltx,'%s\r\n',sprintf('\\caption[%s]{%s}',CapTitle,Caption));
	fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));
    if (float == true)
	    fprintf(ltx,'\\end{figure*}\r\n');
    else
         fprintf(ltx,'\\end{figure}\r\n');
    end
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


