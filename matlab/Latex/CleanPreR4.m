function r = CleanPreR4(OutDir)
	fprintf('This is Erase pre.tex\r\n');
    prename = sprintf('%s/pre.tex',OutDir);
	ltx = fopen (prename, "w", "ieee-le");
	if (ltx < 0)
		return
    end
	%fprintf(ltx,'\\newpage \r\n \\clearpage \r\n \\begin{verbatim} \r\nStart Pre....\r\n');
	fprintf(ltx,'\\newpage \r\n \\clearpage \r\n \r\nStart Pre....\r\n');
	fprintf(ltx,'\\hfill\r\n');
	fprintf(ltx,'\\break\r\n');
	fprintf(ltx,'\\newline\r\n');
	%fprintf(ltx,'\\input{nl.tex}\r\n');
	fclose(ltx);
end