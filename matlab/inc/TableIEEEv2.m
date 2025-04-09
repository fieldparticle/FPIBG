function ret =  TableIEEEv2(List, Title, Caption,Name,Col,height, FontSize, VertSpacing, CapWidth, LeftMargin)

dirc = sprintf('..\\tables\\%s.tex',Name);

lenCol = 0;

		printf('This is TableIEEEv2 - %s\r\n',Name) 
		ptx = fopen ('..\\rpt\\pre.tex', "a", "ieee-le");
		writng = 0;
		txt = sprintf('\\input{../tables/%s.tex}',Name);
		fprintf(ptx,'======================= %s =======================\r\n',Name);
		fprintf(ptx,'%s\r\n%s\r\n',sprintf('\\ref{tab:%s}',Name),txt);
		%fprintf(ltx,'%s\r\n',sprintf('\\input{../equations/%s.tex}\r\n',Name));
		fprintf(ptx,'======================= %s =======================\r\n',Name);
		if(ptx<0)
			printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
			return
		end
		fclose(ptx);

		dirc = sprintf('..\\tables\\%s.tex',Name);
		ltx = fopen (dirc, "w", "ieee-le");
		if(ltx<0)
			printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
			return
		end
		fprintf(ltx,'\\begin{center}');
		fprintf(ltx,'%s\r\n','\begingroup');
	
		fprintf(ltx,'%s\r\n','\begin{tablehere}');
		fprintf(ltx,'\\centering\r\n\\hspace*{%dpt}\r\n',LeftMargin);
		%fprintf(ltx,'%s\r\n','\tiny');
		fprintf(ltx,'%s\r\n',sprintf('\\fontsize{%d}{%d}\\selectfont',FontSize,VertSpacing));
		fprintf(ltx,'\\renewcommand{\\arraystretch}{%0.2f}',height);

		fprintf(ltx,'%s\r\n',sprintf('\\captionsetup[table]{justification=raggedright,singlelinecheck=true,width=%0.2f\\textwidth}',CapWidth))	
		fprintf(ltx,'%s\r\n',sprintf('%s%s}','\captionof{table}{ \\ ',Title));
		fprintf(ltx,'%s\r\n',sprintf('\\label{tab:%s}',Name));
		fprintf(ltx,'%s\r\n','\begin{tabular}');

	%=========== Column definition =================
	fprintf(ltx,'%s\r\n','{');
	for c = 1:length(Col)
		fprintf(ltx,' m{%dpt}',Col{1,c});
		lenCol = lenCol + Col{1,c};
	end

	fprintf(ltx,'}\r\n%s\r\n','\hline \hline ');

	%============ Header ============================
	for c = 1:size(Col)(2)
		txt = sprintf('%s',Col{2,c});
		fprintf(ltx,'%s',Col{2,c});
		if(c ~= size(Col)(2))
			fprintf(ltx,' & ');
		end
	end
	fprintf(ltx,'%s\r\n',' \\ \hline  ');


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
		fprintf(ltx,'\\\\   \r\n');
	end

	%==================Footer=========================
	fprintf(ltx,'\\hline  \r\n');
	fprintf(ltx,'%s\r\n','\begin{tabular}');
	fprintf(ltx,'{\r\n');
	fprintf(ltx,'m{%dpt}}',lenCol+50);
	fprintf(ltx,'%s\r\n','\fontsize{11}{12}\selectfont');
	fprintf(ltx,'%s\r\n',sprintf('\\\\  %s',Caption));
	fprintf(ltx,'%s\r\n','\end{tabular}');
	fprintf(ltx,'%s\r\n','\end{tabular}');
	%fprintf(ltx,'%s\r\n','\centering');
	fprintf(ltx,'%s\r\n','\fontsize{9}{12}\selectfont');
	%fprintf(ltx,'%s\r\n','\break \\ \begin{center} ');
	%fprintf(ltx,'%s\r\n','\end{center}');
	fprintf(ltx,'%s\r\n','\end{tablehere}');
	fprintf(ltx,'%s\r\n','\endgroup');
	fprintf(ltx,'\\end{center}')
	fclose(ltx);
	end
