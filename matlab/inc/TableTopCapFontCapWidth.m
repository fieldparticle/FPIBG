%20160-05-28 - Active
% This is the first revision of TableTopCap.m which boxes 

function ret =  TableTopCapFontCapWidth(List,Title,Caption,Name,Col,height, FontSize, VertSpacing, CapWidth)
	LeftMargin = -20;
	
	%dirc 	= sprintf('..\\tables\\%s.tex',Name);
	%ltx 	= fopen (dirc, "w", "ieee-le");
	lenCol 	= 0;
	printf('This is TableTopCapFontCapWidth - %s\r\n',Name) ;
	dirc 	= sprintf('..\\tables\\%s.tex',Name);
	ltx 	= fopen (dirc, "w", "ieee-le");
	fprintf(ltx,'%s\r\n','\begingroup');
	fprintf(ltx,'%s\r\n','\begin{tablehere}');
	fprintf(ltx,'\\hspace*{%dpt}\r\n',LeftMargin);
	%fprintf(ltx,'%s\r\n','\tiny');
	fprintf(ltx,'%s\r\n',sprintf('\\fontsize{%d}{%d}\\selectfont',FontSize,VertSpacing));
	fprintf(ltx,'\\renewcommand{\\arraystretch}{%0.2f}',height);
	fprintf(ltx,'%s\r\n',sprintf('\\captionsetup[table]{justification=raggedright,singlelinecheck=false,width=%0.2f\\textwidth}',CapWidth))	
	fprintf(ltx,'%s\r\n',sprintf('%s%s}','\captionof{table}{',Caption));
	
	
	fprintf(ltx,'%s\r\n',sprintf('\\label{tab:%s}',Name));
	fprintf(ltx,'%s\r\n','\begin{tabular}');
	%=========== Column definition =================
	fprintf(ltx,'%s\r\n','{');
	c = 1;
	while (c <= size(Col)(2))
		fprintf(ltx,'| m{%dpt}',Col{1,c});
		lenCol = lenCol + Col{1,c};
		c++;
	endwhile
	fprintf(ltx,'|}%s\r\n','\hline ');
	if 1
	%============ Header ============================
	c = 1;
	while (c <= length(Col))
		%fprintf(ltx,' $\\mathbf{%s}$',Col{2,c});
		fprintf(ltx,' \\bf{%s}',Col{2,c});
		if(c ~= length(Col))
			fprintf(ltx,' & ');
		end
		c++;
	endwhile
	fprintf(ltx,'%s\r\n',' \\   \hline');
	%=================Data===========================
	k = size(List);
	for i = 1:k(2)
		for a = 1:k(1)
			i;
			a;
			c = List{a,i};
			txt = sprintf('%s',c{1,2});
			fprintf(ltx,'%s ',sprintf(txt,c{1,1}));
			if(a ~= k(1))
				fprintf(ltx,' & ');
			end
		end
		fprintf(ltx,'\\\\ \\hline  \r\n');
	end
	%==================Footer=========================
	
	end
	fprintf(ltx,'%s\r\n','\end{tabular}');
	fprintf(ltx,'%s\r\n','\centering');
	fprintf(ltx,'\r\n%s\r\n','\end{tablehere}');
	fprintf(ltx,'%s\r\n','\endgroup');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	writng = 0;
	txt = sprintf('\\input{../tables/%s.tex}',Name);
	fprintf(ltx,'============================================= TableTCFCW  %s \r\n',Name);
	fprintf(ltx,'%s\r\n%s\r\n',sprintf('Table \\ref{tab:%s}',Name),txt);
	
	if(ltx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return;
	end
	fclose(ltx);
end
