function ret = PlotToFile(h,PlotName,Caption,Width,Height,LeftMargin)
PlotName
latex_fl = sprintf('..\\images\\%s.tex',PlotName);
PlotName
ltx = fopen (latex_fl, "w", "ieee-le");
if(ltx<0)
	printf('Plot to File - Could Not Create File %s - Aborting\r\n',latex_fl);
	return
end
fprintf('This is Plot to File - %s\r\n',PlotName);
%legend off
W 			= Width/72;
H 			= Height/72;
fprintf(ltx,'\\begingroup\r\n');
fprintf(ltx,'\\tiny\r\n');
fprintf(ltx,'\\begin{Figure}\r\n');
fprintf(ltx,'\\hspace*{%dpt}\r\n',LeftMargin);
if Width ~= 0
	fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%dpt, height=%dpt]{../images/%s.png}',Width,Height,PlotName));
else
	fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[height=%dpt]{../images/%s.png}',Height,PlotName));
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
set(FS,'FontSize',8);	
end


set(h,'PaperUnits','inches')
set(h,'PaperOrientation','landscape')
set(h,'PaperSize',[W,H])
set(h,'PaperPosition',[0,0,W,H])
img_fl = sprintf('..\\images\\%s.png',PlotName);
%saveas(h,img_fl,'png')
print(h,'-dpng',img_fl);
pltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
if 1
txt = sprintf('[\\input{../images/%s.tex}]',PlotName);
fprintf(pltx,'======================= %s =======================\r\n',PlotName);
fprintf(pltx,'%s\r\n%s\r\n',sprintf('Fig. \\ref{fig:%s}',PlotName),txt);
fprintf(pltx,'%s\r\n',sprintf('\\input{../images/%s.tex}\r\n',PlotName));
fprintf(pltx,'======================= %s =======================\r\n',PlotName);
if(pltx<0)
	printf('Plot to File - Could Not Create File %s - Aboting\r\n',latex_fl);
	return
end
end
fclose(pltx);
