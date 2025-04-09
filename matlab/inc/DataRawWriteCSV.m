% Equation

function ret = DataRawWriteCSV(CSVArray,FileName,KeyNum,KeyVal)

	key 		= -1;
	new_file 	= 0;
	rec_found		= 0;
	printf('This is DataRawWriteCSV\r\n');
	%read the whole file
	if exist(FileName,'file') == 2
		temp =  dlmread(FileName,',');
		if(size(temp)(2) != length(CSVArray))
			printf('Requested record is not the same length of file record.Press Enter.\r\n');
		end
	else
		new_file = 1;
	end
	new_file = 1;
	if new_file != 1
		for ii = 1:size(temp)(1)
			if(temp(ii,KeyNum) == KeyVal)
				rec_found 	= 1;
				key 	= ii;
				for d=1:size(temp)(2)
					temp(ii,d)=CSVArray(d);
				end
			
			end
		end
	end
	ltx = fopen (FileName, "w", "ieee-le");
	if(ltx<0)
		printf('DataRawWriteCSV - Could Not Create File %s - Aborting\r\n',FileName);
		return
	end
	
	%New file
	if new_file == 1
		for ii = 1:size(CSVArray)(2)
			if(isalpha(CSVArray{ii})(1) == 1)
				fprintf(ltx,'\"%s\"',CSVArray{ii})
			else
				fprintf(ltx,'%s',num2str(CSVArray{ii}))
			end
			if ii!=size(CSVArray)(2)
				fprintf(ltx,',');
			else
				fprintf(ltx,'\r\n')
			end
		end
	%existing file, record found write temp.
	elseif new_file == 0 && rec_found == 1
		for ii = 1:size(temp)(1)
			for jj = 1:size(temp)(2)
				fprintf(ltx,'%s',temp(ii,jj));
				if jj!=size(temp)(2)
					fprintf(ltx,',');
				end
			end
		fprintf(ltx,'\r\n')
		end
	elseif new_file == 0 && rec_found == 0
		for ii = 1:size(CSVArray)
			fprintf(ltx,'%s',CSVArray{ii});
			if ii!=size(CSVArray)
				fprintf(ltx,',');
			else
				fprintf(ltx,'\r\n')
			end
		end
		
		for ii = 1:size(temp)(1)
			for jj = 1:size(temp)(2)
				fprintf(ltx,'%s',temp(ii,jj));
				if jj!=size(temp)(2)
					fprintf(ltx,',');
				else
					fprintf(ltx,'\r\n')
				end
			end
		end
	end
	fclose(ltx);
end
