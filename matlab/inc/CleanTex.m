
function ret = CleanTex()

delete (sprintf('%s%s','..\rpt\','*.aux'))
delete (sprintf('%s%s','..\rpt\','*.gz'))
delete (sprintf('%s%s','..\rpt\','*.out'))
delete (sprintf('%s%s','..\rpt\','*.log'))
delete (sprintf('%s%s','..\rpt\','*.toc'))
