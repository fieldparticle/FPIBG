% Convert a group of tab delimited text files to comma separated
% 	Where:
%	StartRow - the beginning row at which the conversion will start - used to skip titles.

function ret = FileTab2CSV(StartRow,File)
		fprintf('FileTab2CSV Converting:%s\r\n',File);
		outfile_nm = sprintf('%s.csv',File);
		outfile = fopen(outfile_nm, 'w', 'ieee-le');
		if (outfile < 0)
			fprintf('FileTab2CSV cant open :%s - press enter\r\n',outfile_nm);
			pause
			return
		end
		infile = fopen (File);
		if (infile < 0)
			fprintf('FileTab2CSV cant open :%s\r\n',File);
			pause
			return
		end
		count = 0;
		do
			str = fgetl(infile);
			if count > StartRow
				for p = 1:length(str)
					num_paren = findstr(str,"\t");
					if(length(num_paren) == 0)
						break;
					end
					str(num_paren(1)) = ',';
				end 
				if(length(str) >1)
					fprintf(outfile,'%s\r\n',str);	
				end
			end
		count++;
		until(str<0)
		count = 0;
		fclose(infile);
		fclose(outfile);
end