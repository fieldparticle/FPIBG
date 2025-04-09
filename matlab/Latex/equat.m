% Equation
function ret = equat(Name, eqtxt, valstr, valact, valdigits)
	fprintf('This is equat - %s\r\n',Name);
	npt = 1;
	latex_fl = sprintf('..\\equations\\%s.tex',Name);
	
	ptx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	if(ptx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
		
	fprintf(ptx,'%%============================================= Equation %s\r\n',Name);
	fprintf(ptx,'\\begin{verbatim}{Equation = %s}\\end{verbatim}\r\n',Name);
	fprintf(ptx,'%s',sprintf('(\\ref{eqn:%s})\r\n',Name));
	fprintf(ptx,'%s',sprintf('\\input{../equations/%s.tex}\r\n',Name));
	fclose(ptx);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
			fprintf('Equation - Could Not Create File %s - Aborting\r\n',latex_fl)
		return
	end
	
	fprintf(ltx,'\\begin{equation}\r\n ');
	fprintf(ltx,'\\begin{aligned}\r\n ');
	fmta.txt = '';


	if iscell (valstr) ~= 0
		for(i=1:length(valact))
			txtd = sprintf('%s',valdigits{1,i});
			%fprintf(ltx,'%s ',sprintf(txt,valact{i}));
            pos=strchr(valdigits{1,i},'s');
			if(pos ~= 0)
				pps = substr(valdigits{1,i},1,pos-1);
				digits =  str2num(pps);
				txt = exptxt(valact{i},digits,1);
			else
				txt = sprintf(txtd,valact{i});
			end
			fnd = sprintf('{%s}',valstr{i});
			ntxt = strrep (eqtxt,fnd,txt);
			eqtxt = ntxt ;
		end
	eqtxt	;
	else
		%fprintf('Not a cell\r\n')
		npt = 0;
    end	
	%fputs(ltx,eqtxt);
    fprintf(ltx,'%s',eqtxt);
	fprintf(ltx,fmta.txt);
	%fprintf(ltx,'\\end{split}\r\n ');
	fprintf(ltx,'\\label{eqn:%s} \r\n',Name);
    fprintf(ltx,'\\end{aligned}\r\n');
	fprintf(ltx,'\\end{equation}\r\n');
	fclose(ltx);
	
	eqtex_fl = sprintf('..\\rpt\\equations.tex');
	etx = fopen (eqtex_fl, "a", "ieee-le");
	if(etx<0)
		fprintf('Equation - Could Not Create File %s - Aborting\r\n',eqtex_fl);
		return
	end
	fprintf(etx,'\\newline\r\n%s\\newline\r\n',Name);
	fprintf(etx,'\\begin{equation*}\r\n ');
	fprintf(etx,'\\begin{split}\r\n ');
	fprintf(etx,'%s',eqtxt);
	fprintf(etx,fmta.txt);
	fprintf(etx,'\\end{split}\r\n ');
	fprintf(etx,'\\end{equation*}');
	fprintf(etx,'\newline');
	fprintf(etx,'\r\n------------------\r\n');
	fclose(etx);

	
	
	
	
	
	
	
	ret = 0;
	
end