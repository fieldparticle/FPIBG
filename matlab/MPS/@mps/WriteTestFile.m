function WriteTestFile(obj,...
                        SideLength,...
                        PInCell,...
                        CountedParticles)
   datafl = sprintf('%s/%s.tst',obj.data_dir,obj.data_name);
    binfl = sprintf('%s/%s.bin',obj.data_dir,obj.data_name);
    rptfl = sprintf('%s/%s.csv',obj.data_dir,obj.data_name);
	ltx = fopen (datafl, "w", "ieee-le");
	if(ltx<0)
		fprintf('TstFile - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
index = 0;

fprintf(ltx,'index = %d;\r\n',index);
fprintf(ltx,'Sidelen = %d;\r\n',SideLength);
fprintf(ltx,'radius = %0.1f;\r\n',0.2);
fprintf(ltx,'PartPerCell = %d;\r\n',PInCell);
fprintf(ltx,'pcount = %d;\r\n',CountedParticles);
fprintf(ltx,'colcount = %d;\r\n',0);
fprintf(ltx,'dataFile = "%s";\r\n',binfl);
fprintf(ltx,'aprFile = "%s";\r\n', rptfl);
fprintf(ltx,'density = %0.1f;\r\n',0.0);
fprintf(ltx,'pdensity = %0.1f;\r\n',0.0);
fprintf(ltx,'dispatchx =  %d;\r\n',(CountedParticles+1));
fprintf(ltx,'dispatchy = %d;\r\n',1);
fprintf(ltx,'dispatchz = %d;\r\n',1);
fprintf(ltx,'workGroupsx = %d;\r\n',1);
fprintf(ltx,'workGroupsy = %d;\r\n',1);
fprintf(ltx,'workGroupsz = %d;\r\n',1);
fprintf(ltx,'ColArySize = %d;\r\n',64);
fprintf(ltx,'MaxSingleCollisions = %d;\r\n',8);
fclose(ltx);
end