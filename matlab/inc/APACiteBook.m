% Equation
function ret = APACiteBook(Name,Author,BookJournal,Publisher,Date,Page)
	fprintf('APACiteBook %s\r\n',Name);
	latex_fl = sprintf('..\\citations\\%s.tex',Name);
	
	ptx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	if(ptx<0)
		printf('APACiteBook - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
				%123456789012345678901234567890123456789012345

	fprintf(ptx,'============================================= APACiteBook %s \r\n',Name);
	fprintf(ptx,'%s',sprintf('\\input{../citations/%s.tex}\r\n',Name));
	fprintf(ptx,'%s',sprintf('%s\\cite{bib:%s}\r\n','%',Name));
	fclose(ptx);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('APACiteBook - Could Not Create File %s - Aborting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'%s',sprintf('\r\n%s\\cite{bib:%s}\r\n','%',Name));
	fprintf(ltx,'\\bibitem{bib:%s}\r\n',Name)	;	
	fprintf(ltx,'%s, ',Author);
	fprintf(ltx,'\\textit{%s}, ',BookJournal);
	fprintf(ltx,'%s, ',Publisher);
	fprintf(ltx,'%s',Date);
	if 1
	if length(Page) ~= 0
		fprintf(ltx,', %s.\r\n\r\n',Page);
	else
		fprintf(ltx,'.\r\n\r\n',Page);
		end

	fclose(ltx);
	
end