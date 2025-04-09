if exist(SpecFl,'file') != 2
	fprintf('Data Specs - Could Not Open File %s - Aborting\r\n',SpecFl);
	return;
else
	run(SpecFl)
end