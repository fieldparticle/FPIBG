function StartEqTex()

latex_fl = sprintf('..\\rpt\\equations.tex');
ltx = fopen (latex_fl, "w", "ieee-le");
if(ltx<0)
	fprintf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl);
	return
end
fprintf(ltx,'------------------\r\n');
%fprintf(ltx,'\\input{S:/__LatexProject/include/MastersHeader.tex}\r\n');
%fprintf(ltx,'\\begin{document}\r\n');

 
fclose(ltx);
end