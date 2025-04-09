function EndEqTex()

latex_fl = sprintf('..\\rpt\\equations.tex');
ltx = fopen (latex_fl, "a", "ieee-le");
if(ltx<0)
	printf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl);
	return
end

fprintf(ltx,'\\end{document}\r\n');

 
fclose(ltx);
end