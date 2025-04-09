function r = EndPre()
ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
%fprintf(ltx,'\r\n\r\n\\end{verbatim}\r\n');
fprintf(ltx,'\r\n\r\n\r\n');
fclose(ltx);
end