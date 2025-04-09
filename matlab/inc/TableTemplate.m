function ret =  TableTemplate(List,Title,Caption,Name,Col)

dirc = sprintf('..\\tables\\%s.tex',Name);
ltx = fopen (dirc, "w", "ieee-le");
lenCol = 0;
	ptx = fopen ('..\\rpt\\pre.tex', "a", "ieee-le");
	writng = 0;
	txt = sprintf('\\input{../tables/%s.tex}',Name);
	fprintf(ptx,'======================= %s =======================\r\n',Name);
	fprintf(ptx,'%s\r\n%s\r\n',sprintf('\\ref{tab:%s}',Name),txt);
	fprintf(ptx,'======================= %s =======================\r\n',Name);
	if(ptx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return
	end
	fclose(ptx)
for c = 1:2
	if(c == 1)
		dirc = sprintf('..\\tables\\%s.tex',Name);
		ltx = fopen (dirc, "w", "ieee-le");
	end
	

	fprintf(ltx,'%s\r\n','\begingroup');
	fprintf(ltx,'%s\r\n','\begin{tablehere}');
	fprintf(ltx,'%s\r\n','\tiny');

	fprintf(ltx,'%s\r\n','\renewcommand{\arraystretch}{1.3}');
	fprintf(ltx,'%s\r\n',sprintf('%s%s}','\caption{\scshape\fontsize{10}{12}\selectfont \\ ',Title));
	fprintf(ltx,'%s\r\n',sprintf('\\label{tab:%s}',Name));
	fprintf(ltx,'%s\r\n','\begin{tabular}');

	%=========== Column definition =================
	fprintf(ltx,'%s\r\n','{');
	for c = 1:length(Col)
		fprintf(ltx,' m{%dpt}',Col{1,c});
		lenCol = lenCol + Col{1,c};
	end

	fprintf(ltx,'}\r\n%s\r\n','\hline \hline \\ ');

	%============ Header ============================

	for c = 1:length(Col)
		fprintf(ltx,'%s',Col{2,c});
		if(c ~= length(Col))
			fprintf(ltx,' & ');
		end
	end
	fprintf(ltx,'%s\r\n',' \\ \hline  ');


	%=================Data===========================
	k = size(List);
	for i = 1:k(2)
		%txt = sprintf('%s',Col{3,i});
		for a = 1:k(1)
			txt = sprintf('%s',Col{3,a});
			fprintf(ltx,'%s ',sprintf(txt,List{a,i}));
			if(a ~= k(1))
				fprintf(ltx,' & ');
			end
		end
		fprintf(ltx,'\\\\ \r\n');
	end

	%==================Footer=========================
	fprintf(ltx,'\\hline \\\\ \r\n');
	fprintf(ltx,'%s\r\n','\begin{tabular}');
	fprintf(ltx,'{\r\n');
	fprintf(ltx,'m{%dpt}}',lenCol);
	fprintf(ltx,'%s\r\n',sprintf(' %s',Caption));
	fprintf(ltx,'%s\r\n','\end{tabular}');
	fprintf(ltx,'%s\r\n','\end{tabular}');
	fprintf(ltx,'%s\r\n','\centering');
	fprintf(ltx,'%s\r\n','\fontsize{8}{12}\selectfont');
	fprintf(ltx,'%s\r\n','\break \\ \begin{center} ');
	fprintf(ltx,'%s\r\n','\end{center}');
	fprintf(ltx,'%s\r\n','\end{tablehere}');
	fprintf(ltx,'%s\r\n','\endgroup');
	fclose(ltx);
	end
	
end