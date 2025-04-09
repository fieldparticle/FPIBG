%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


function ret = SimplePlotFigure(Name,Handle,x,y,LineStyle,Marker,RGBColor,Caption,Legend,LegPos)
	
	printf('This is SimplePlotFigure %s\r\n',Name);
	no_print = 0
	length(Name)
	if length(Name) == 0
		no_print = 1
	else	
		img_fl = sprintf('..\\images\\%s.png',Name);
		latex_fl = sprintf('..\\images\\%s.tex',Name);
		ltx = fopen (latex_fl, "w", "ieee-le");
		if(ltx<0)
			printf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl);
			return
		end
	endif
	if 1
	s = length(x);
	LS		= findall(Handle,'-property','linestyle');
	set(LS,'linestyle',LineStyle);
	if(length(Marker)~=0)
		MS		= findall(Handle,'-property','marker');
		set(MS,'marker',Marker);
	end
	endif
	
	plot(x,y,'color',RGBColor,'linewidth', 2);
if 1
	grid on

	LEGEND_BCENTER	 	= 1;
	LEGEND_TCENTER 		= 2;
	LEGEND_BLEFT 		= 3;
	LEGEND_TLEFT 		= 4;
	LEGEND_BRIGHT	 	= 5;
	LEGEND_TRIGHT 		= 6;
	
	if(no_print	~= 1)
		if (length(Legend) ~= 0) 
				
				hx = legend(Legend);
				set(hx, 'fontsize', 10);
				set(hx, 'fontname', 'Arial');
				if LegPos == LEGEND_BCENTER
					set(hx,'location', 'south');
				elseif LegPos == LEGEND_TCENTER
					set(hx,'location', 'north');
				elseif LegPos == LEGEND_BLEFT
					set(hx,'location', 'southwest');
				elseif LegPos == LEGEND_TLEFT
					set(hx,'location', 'northwest');		
				elseif LegPos == LEGEND_BRIGHT
					set(hx,'location', 'northeast');			
				elseif LegPos == LEGEND_TRIGHT
					set(hx,'location', 'northeast');				
				end
			end
		legend boxoff	
		

		pt_W 		= 500;
		pt_H		= 300;	
		LeftMargin	= -20;
		W 			= pt_W/72;
		H 			= pt_H/72;
		fprintf(ltx,'\\begingroup\r\n');
		fprintf(ltx,'\\tiny\r\n');
		fprintf(ltx,'\\begin{Figure}\r\n');
		fprintf(ltx,'\\hspace*{%dpt}\r\n',LeftMargin);
		fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt, height=%dpt]{../images/%s.png}',pt_W,pt_H,Name));
		fprintf(ltx,'\\captionsetup[figure]{justification=raggedright,singlelinecheck=false}');
		fprintf(ltx,'%s\r\n',sprintf('\\captionof{figure}{\\fontsize{10}{12}\\selectfont %s}',Caption));
		fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));
		fprintf(ltx,'\\end{Figure}\r\n');
		fprintf(ltx,'\\endgroup\r\n');
		fclose(ltx);

			

		if 1
		FN 		= findall(Handle,'-property','FontName');
		FS 		= findall(Handle,'-property','FontSize');
		set(FN,'FontName','Arial');
		set(FS,'FontSize',8);	
		endif
		set(Handle,'PaperUnits','inches')
		set(Handle,'PaperOrientation','landscape')
		set(Handle,'PaperSize',[W,H])
		set(Handle,'PaperPosition',[0,0,W,H])
		img_fl = sprintf('..\\images\\%s.png',Name);
		print(Handle,'-dpng','-color',img_fl);
		ptx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
		txt = sprintf('[\\input{../images/%s.tex}]',Name);
		fprintf(ptx,'======= PLOT %s \r\n',Name);
		fprintf(ptx,'%s\r\n%s\r\n',sprintf('Fig. \\ref{fig:%s}',Name),txt);
		fprintf(ptx,'%s\r\n',sprintf('\\input{../images/%s.tex}\r\n',Name));
		fprintf(ptx,'======= PLOT %s \r\n',Name);
		if(ptx<0)
			printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
			return
		end
		fclose(ptx);
	end
endif
