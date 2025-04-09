%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the latest version of table. The header requires
% the following in the header. Just input 
% \input{Z:/__LatexProject/IncludeUFFluidsLab/header.tex}
%\usepackage{dcolumn} % for alining decimal places
%\newcolumntype{d}[1]{D{.}{.}{#1}}
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ret =  TableSciUF(List,Title,Caption,Name,Col,height, FontSize, VertSpacing, CapWidth)
	

	%There are types
	COL_LENGTH		= 1;
	COL_HEADER		= 2;
	COL_TYPE		= 3;
	COL_DIGITS		= 4;
	COL_STRING		= 5;

	%These are assigned
	COL_TYPE_LEFT	= 1;
	COL_TYPE_RIGHT	= 2;
	COL_TYPE_CENTER	= 3;
	COL_TYPE_DIGITS	= 4;
	COL_TYPE_TEXT	= 5;
	
	%dirc 	= sprintf('..\\tables\\%s.tex',Name);
	%ltx 	= fopen (dirc, "w", "ieee-le");
	lenCol 	= 0;
	printf('This is TableSciUF - %s\r\n',Name) 
	dirc 	= sprintf('..\\tables\\%s.tex',Name);
	ltx 	= fopen (dirc, "w", "ieee-le");
	
	if 1
		fprintf(ltx,'%s\r\n','\begingroup');
		fprintf(ltx,'%s\r\n','\begin{tablehere}');
		fprintf(ltx,'\\hspace*{%dpt}\r\n',LeftMargin);
		%fprintf(ltx,'%s\r\n','\tiny');
		fprintf(ltx,'%s\r\n',sprintf('\\fontsize{%d}{%d}\\selectfont',FontSize,VertSpacing));
		fprintf(ltx,'\\renewcommand{\\arraystretch}{%0.2f}',height);

		fprintf(ltx,'%s\r\n',sprintf('\\captionsetup[table]{justification=raggedright,singlelinecheck=false,width=%0.2f\\textwidth}',CapWidth))	
		fprintf(ltx,'%s\r\n',sprintf('%s%s}','\captionof{table}{',Caption));
		fprintf(ltx,'%s\r\n',sprintf('\\label{tab:%s}',Name));
		fprintf(ltx,'%s\r\n','\begin{tabular}');
	end
	
	%============= Need to run through and get the number of digits 
	%============= for S[table-format=0.digits]. If the table does not have this
	%============= it will center the numbers on the digit and not the whole number.
	digitArray = '';
	
	
	r1	=	size(List)(1);
	r2  = 	size(Col)(2);
	if size(List)(2) < 2 
		printf('There are no data rows in table : %s\r\n',Name);
		break
	end
	
	
	if r1 ~= r2 
		printf('Header cols (=%d) do not equal data cols (=%d) in table : %s\r\n',r2,r1,Name);
		break;
	end
	
	
	kk = size(List);
	for i = 2:2
		for a = 1:kk(1)
			c = List{a,i};
			txt = sprintf('%s',c{1,2});
			if ((ii = index(txt,'f'))>0)
				jj = index(txt,'.')+1;
				digits = substr(txt,jj,ii-jj);
				digitArray(end+1) = digits;
			else
				digitArray(end+1) = '0';
			endif
			
		end
	end

	
	%=========== Column definition =================
	fprintf(ltx,'%s','{');
	cc = 1;
	spec = '';
	while (cc <= size(Col)(2))
	
		%%%%%%%%%%%%%%
		%Do the type
			if digitArray(cc) == '0'
				fprintf(ltx,' | S[table-column-width=%dpt]\r\n',Col{COL_LENGTH,cc});
			else
				fprintf(ltx,' | S[table-column-width=%dpt,table-format=0.%s]\r\n',Col{COL_LENGTH,cc},digitArray(cc));
			end
		lenCol = lenCol + Col{1,cc};
		cc++;
	end
	fprintf(ltx,'|}%s\r\n','\hline ');
	
	
	%============ Header ============================
	hh = 1;
	while (hh <= length(Col))
		
		%fprintf(ltx,' $\\mathbf{%s}$',Col{2,c});
		fprintf(ltx,'{\\bf{\\makecell[c]{%s}}}\r\n',Col{COL_HEADER,hh});
		if(hh ~= length(Col))
			fprintf(ltx,' & ');
		end
		hh++;
	end
	if hh != cc
		fprintf('The number of columns %d do not equal the number of headers %d\r\n',cc,hh)
		return
	end
	fprintf(ltx,'%s\r\n',' \\   ');
		
	
	%=================Data===========================
	kk = size(List);
	for i = 1:kk(2)
		for a = 1:kk(1)
			i;
			a;
			c = List{a,i};
			txt = sprintf('%s',c{1,2});
			if digitArray(a) == '0'
				fprintf(ltx,'{%s}\r\n',sprintf(txt,c{1,1}));
			else
				fprintf(ltx,'%s\r\n',sprintf(txt,c{1,1}));
			end
			if(a ~= kk(1))
				fprintf(ltx,' & ');
			end
		end
		fprintf(ltx,'\\\\ \\hline  \r\n');
	end
	%==================Footer=========================


	fprintf(ltx,'%s\r\n','\end{tabular}');
	fprintf(ltx,'%s\r\n','\centering');
	fprintf(ltx,'\r\n%s\r\n','\end{tablehere}');
	fprintf(ltx,'%s\r\n','\endgroup');
	fclose(ltx);
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
	writng = 0;
	txt = sprintf('\\input{../tables/%s.tex}',Name);
				%123456789012345678901234567890123456789012345
	fprintf(ltx,'============================================= TableSciUF %s \r\n',Name);
	fprintf(ltx,'%s\r\n%s\r\n',txt,sprintf('Table \\ref{tab:%s}',Name));
		if(ltx<0)
		printf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl);
		return;	
	end

	fclose(ltx);
end
