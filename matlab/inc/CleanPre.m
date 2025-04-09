function r = CleanPre()
	fprintf('This is Erase pre.tex\r\n');
	ltx = fopen ('..\rpt\pre.tex', "w", "ieee-le");
	if (ltx < 0)
		return
	endif
	%fprintf(ltx,'\\newpage \r\n \\clearpage \r\n \\begin{verbatim} \r\nStart Pre....\r\n');
	fprintf(ltx,'\\newpage \r\n \\clearpage \r\n \r\nStart Pre....\r\n');
	fprintf(ltx,'\\hfill\r\n');
	fprintf(ltx,'\\break\r\n');
	fprintf(ltx,'\\newline\r\n');
	%fprintf(ltx,'\\input{nl.tex}\r\n');
	fclose(ltx);
end