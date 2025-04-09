function ret = GetCaptionText(dir,Name)

	
	fprintf('This is Image Thesis 10 get captiuon text. \r\n');
	latex_fl = sprintf('%s/%s.txt',dir,Name);
	
	ltx = fopen (latex_fl);
	if(ltx<0)
		fprintf('GetCaptionText - Could Not Open File %s - Aboting\r\n',latex_fl)
		return
	end
    endtext = '';
    tline = "";
	while ~feof(ltx)
		tline = fgets(ltx);
        endtext = strcat(endtext,tline);
	end
	ret = endtext;
	fclose(ltx);
end