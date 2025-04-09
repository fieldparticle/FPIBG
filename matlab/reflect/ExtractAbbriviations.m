clc
clear all
close all

Filename = 'ch001_Introduction';
latex_fl = sprintf('..\\rpt_thesis\\%s.tex',Filename);
ptx = fopen (latex_fl, "r", "ieee-le");
if(ptx<0)
    fprintf('Failed to Open BIB file\r\n',latex_fl);
    return
end
csv_fl = sprintf('%s.csv',Filename);
csvhndl = fopen (csv_fl, "w", "ieee-le");
if(csvhndl<0)
	fprintf('MatlabTableIEEE - Failed to open pre.tex - aborting\r\n',latex_fl);
	return;
end
fprintf(csvhndl,'Name,Description\r\n');
while(~feof(ptx))
    tline = fgetl(ptx);
    if(contains(tline, '(')) 
        newStr = extractBetween(tline,"(",")");
        fprintf(newStr);
    end
end

fclose(ptx);
fclose(csvhndl);