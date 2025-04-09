% Convert a group of tab delimited text files to comma separated
% 	Where:
%	StartRow - the beginning row at which the conversion will start - used to skip titles.
%	WildCard - the suffix of the files to be converted
%	TargetDir - the directory containing the group of files.

function ret = GroupTab2CSV(StartRow, WildCard, TargetDir,DelPrev)
	PatFrom		= {[TargetDir,WildCard]}	% pattern for 1st level
	if DelPrev ~= 0
		delete (sprintf('%s%s',TargetDir,'*.csv'));
	end
	readings		= glob({PatFrom})
	if size(readings) ==0
		printf('No files were found\r\n');
		return
	end
	
	count = 0;
	str = '';

	for i = 1:length(readings)
		fprintf('GroupTab2CSV Converting:%s\r\n',readings{i});
		outfile_nm = sprintf('%s.csv',readings{i});
		outfile = fopen(outfile_nm, 'w', 'ieee-le');
		infile = fopen (readings{i});
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
	ret = 0;
end