function ret = PlotToFileDir(h,Directory,PlotName,Caption,Width,Height,LeftMargin)

latex_fl = sprintf('%s/%s.tex',Directory,PlotName);
[status, msg, msgid] = mkdir(Directory);
if(status == 0)
	printf('Plot to File - Could Not Create Directory %s - Aborting\r\n',Directory);
	return
end
ltx = fopen (latex_fl, "w", "ieee-le");
if(ltx<0)
	printf('Plot to File - Could Not Create File %s - Aborting\r\n',latex_fl);
	return
end
printf('This is Plot to File - %s\r\n',PlotName);
%legend off
H 			= Height/72;
fprintf(ltx,'\\begingroup\r\n');
fprintf(ltx,'\\tiny\r\n');
fprintf(ltx,'\\begin{Figure}\r\n');
fprintf(ltx,'\\hspace*{%dpt}\r\n',LeftMargin);

fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt, height=%dpt]{%s/%s.png}',Width,Height,Directory,PlotName));
if Width != 0
	W 			= Width/72;
	else
	fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[height=%dpt]{%s/%s.png}',Height,Directory,PlotName));
end
fprintf(ltx,'\\captionsetup[figure]{justification=raggedright,singlelinecheck=false}');
fprintf(ltx,'%s\r\n',sprintf('\\captionof{figure}{\\fontsize{8}{12}\\selectfont %s}',Caption));
fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',PlotName));
fprintf(ltx,'\\end{Figure}\r\n');
fprintf(ltx,'\\endgroup\r\n');
fclose(ltx);
	

if 1
FN 		= findall(h,'-property','FontName');
FS 		= findall(h,'-property','FontSize');
set(FN,'FontName','Arial');
set(FS,'FontSize',6);	
end


set(h,'PaperUnits','inches')
set(h,'PaperOrientation','landscape')
set(h,'PaperSize',[W,H])
set(h,'PaperPosition',[0,0,W,H])
img_fl = sprintf('%s/%s.png',Directory,PlotName);
print(h,'-dpng','-color',img_fl);
pltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
if 1
txt = sprintf('[\\input{%s/%s.tex}]',Directory,PlotName);
fprintf(pltx,'======================= %s =======================\r\n',PlotName);
fprintf(pltx,'%s\r\n%s\r\n',sprintf('Fig. \\ref{fig:%s}',PlotName),txt);
fprintf(pltx,'%s\r\n',sprintf('\\input{%s/%s.tex}\r\n',Directory,PlotName));
fprintf(pltx,'======================= %s =======================\r\n',PlotName);
if(pltx<0)
	printf('Plot to File - Could Not Create File %s - Aboting\r\n',latex_fl);
	return
end
end
fflush(pltx);
fclose(pltx);
