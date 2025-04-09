function ret = EquationMatrix(Name, Symbol, Val, FontSize)
[rows cols] = size(Val);
	dirc = sprintf('..\\matricies\\%s.tex',Name);
	ltx = fopen (dirc, "w", "ieee-le");
	fprintf(ltx,'\\begin{equation}\r\n ');
	fprintf(ltx,'\\fontsize{%d}{%d}\\selectfont\r\n',FontSize,FontSize);
	fprintf(ltx,'\\begin{split}\r\n ');
	fprintf(ltx,'%s=%s\r\n',Symbol,'\begin{bmatrix}');
	for row = 1:rows
		for col = 1:cols
		fprintf(ltx,'%f',Val(row,col))
			if cols ~= col
				fprintf(ltx,'&')
			end
		end
		fprintf(ltx,'\\\\')
	end
	fprintf(ltx,'\r\n%s\r\n','\end{bmatrix}');
	fprintf(ltx,'\\end{split}\r\n ');
	fprintf(ltx,'\\label{eqn:%s} \r\n',Name);
	fprintf(ltx,'\\end{equation}');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	txt = sprintf('\\input{../matricies/%s.tex}',Name);
	fprintf(ltx,'======================= %s =======================\r\n',Name);
	fprintf(ltx,'%s\r\n%s\r\n',sprintf('(\\ref{eqn:%s})',Name),txt);
	%fprintf(ltx,'%s\r\n',sprintf('\\input{../equations/%s.tex}\r\n',Name));
	%fprintf(ltx,'======================= %s =======================\r\n',Name);
	if(ltx<0)
		printf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl);
		return
	end
	fclose(ltx);

end