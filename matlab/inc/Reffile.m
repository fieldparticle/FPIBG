function Reffile(Task,Citation)
strfl 	= 1;
addfl	= 2;
endfl	= 3;
	if Task == strfl
		fprintf('Erase references.tex\r\n');
		ltx = fopen ('..\\rpt\\references.tex', "w", "ieee-le");
		fprintf(ltx,'\\begin{thebibliography}{9}\r\n');
		fprintf(ltx,'\\fontsize{8}{12}\\selectfont\r\n');
		fclose(ltx);
	end
	if Task == addfl
		ltx = fopen ('..\\rpt\\references.tex', "a", "ieee-le");
		fprintf(ltx,'%s',sprintf('\\input{../citations/%s.tex}\r\n',Citation));
		fclose(ltx);
	end
	if Task == endfl
		ltx = fopen ('..\\rpt\\references.tex', "a", "ieee-le");
		fprintf(ltx,'\r\n\\end{thebibliography}\r\n');
		fclose(ltx);
	end
end