% Equation
function ret = Heading(Text)
	fprintf('This is Heading\r\n');
	latex_fl = sprintf('..\\rpt\\%s.tex','heading');
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		printf('Heading - Could Not Create File %s - Aborting\r\n',latex_fl);
		return;
	end
	fprintf(ltx,'%s,',Text);
	fclose(ltx);
end