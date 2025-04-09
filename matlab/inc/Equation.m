% Equation
function ret = Equation(Name, eqtxt)

	printf('This is Equation %s\r\n',Name);
	latex_fl = sprintf('..\\equations\\%s.tex',Name);
	

	ptx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	if(ptx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return
	end
	fprintf(ptx,'%%=======================Equation=%s =======================\r\n',Name);
	fprintf(ptx,'%s',sprintf('\\input{../equations/%s.tex}\r\n',Name));
	fprintf(ptx,'%s',sprintf('(\\ref{eqn:%s})\r\n',Name));
	fclose(ptx);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
			printf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl);
		return
	end
	
	
	fprintf(ltx,'\\begin{equation}\r\n ');
	fprintf(ltx,'\\begin{split}\r\n ');
	fmt_txt = '';
	
	fputs(ltx,eqtxt);
	

	if  0
	for i = 1:length(eqtxt)
		
		toascii(eqtxt(i));
		if(toascii(eqtxt(i)) == 92)
			fprintf(ltx,'\\')
		else
			fprintf(ltx,eqtxt(i))
		end
	end
	end
	fprintf(ltx,fmt_txt);
	fprintf(ltx,'\r\n\\label{eqn:%s} \r\n',Name);
	fprintf(ltx,'\\end{split}\r\n ');
	fprintf(ltx,'\\end{equation}');
	fclose(ltx);

	
	
	
end