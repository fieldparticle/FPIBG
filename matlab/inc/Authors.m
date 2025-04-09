% Equation
function ret = Authors(AuthorList)
AUTH_FIRST						= 1;
AUTH_LAST						= 2;
AUTH_POSITION					= 3;
AUTH_ORGANIZATION				= 4;

	fprintf('This is AuthorList\r\n');
	latex_fl = sprintf('..\\authors\\%s.tex','Authors');
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('Authors - Could Not Create File %s - Aborting\r\n',latex_fl);
		return
	end
	%fprintf(ltx,'\\begin{center}');
    nn = size(AuthorList)
	for i = 1:nn(1)
		fprintf(ltx,' \\centering %s, ',AuthorList{i,AUTH_LAST});
		fprintf(ltx,' %s, ',AuthorList{i,AUTH_FIRST});
		fprintf(ltx,'\\textit{%s, ',AuthorList{i,AUTH_POSITION});
		fprintf(ltx,'%s \\\\}',AuthorList{i,AUTH_ORGANIZATION});
		
	end
	%fprintf(ltx,'\\end{center}')
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	fprintf(ltx,'%%============================================= Authors \r\n');
	fprintf(ltx,'%s',sprintf('\\input{../authors/%s.tex}\r\n','Authors'));
%	fprintf(ltx,'======================= %s =======================\r\n','Authors');
	if(ltx<0)
		printf('Authors - Could Not Create File %s - Aborting\r\n',latex_fl);
		return
	end
	fclose(ltx);
end