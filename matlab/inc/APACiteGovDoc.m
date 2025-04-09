% https://owl.english.purdue.edu/owl/resource/560/9/

function ret = APACiteGovDoc(Name,Orgnization,Title,PublicationNumber,Date,PrintingOffice)
	fprintf('APACiteGovDoc %s\r\n',Name);
	latex_fl = sprintf('..\\citations\\%s.tex',Name);
	
	ptx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	if(ptx<0)
		printf('APACiteGovDoc - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
				%123456789012345678901234567890123456789012345

	fprintf(ptx,'============================================= APACiteGovDoc %s \r\n',Name);
	fprintf(ptx,'%s',sprintf('\\input{../citations/%s.tex}\r\n',Name));
	fprintf(ptx,'%s',sprintf('%s\\cite{bib:%s}\r\n','%',Name));
	fclose(ptx);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('APACiteGovDoc - Could Not Create File %s - Aborting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'%s',sprintf('\r\n%s\\cite{bib:%s}\r\n','%',Name));
	fprintf(ltx,'\\bibitem{bib:%s}\r\n',Name)	;	
	fprintf(ltx,'%s. ',Orgnization);
	fprintf(ltx,'\\textit{%s}, ',Title);
	fprintf(ltx,'%s, ',PublicationNumber);
	fprintf(ltx,'%s, ',Date);
	fprintf(ltx,'%s.\r\n\r\n',PrintingOffice);
	fclose(ltx);
	
end