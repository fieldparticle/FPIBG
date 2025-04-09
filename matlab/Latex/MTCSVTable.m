%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/Latex/MTCSVTable.m $
% $Id: MTCSVTable.m 5 2023-03-14 21:48:38Z jb $
%*******************************************************************
%***                         DESCRIPTION                         ***
%*******************************************************************
%@doc
%@module
%			@author: Jackie Michael Bell
%			COPYRIGHT <cp> Jackie Michael Bell
%			Property of Jackie Michael Bell<rtm>. All Rights Reserved.
%			This source code file contains proprietary
%			and confidential information.
%
%
%@head3 		Description. |
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 5 $
%*
%*
%******************************************************************/
function ret = MTCSVTable(  FldAry,...
                            InCSVDir,...
                            OutCSVDir,...
                            PreDir,...
                            CSVFileName,...
                            Title,...
                            Caption,...
                            Labels)

    fprintf('This is MTCSVTable - %s\r\n',CSVFileName) ;

	pretxt = sprintf('%s/pre.tex',PreDir);
    ptx = fopen(pretxt, "a", "ieee-le");
    if(ptx<0)
		fprintf('MTCSVTable - Could Not Create File %s - Aboting\r\n',CSVFileName);
		return
    end
	txt = sprintf('\\input{%s/%s.tex}',OutCSVDir,CSVFileName);
	fprintf(ptx,'======================= %s =======================\r\n',CSVFileName);
	fprintf(ptx,'%s\r\n%s\r\n',sprintf('\\ref{tab:%s}',CSVFileName),txt);
	fprintf(ptx,'======================= %s =======================\r\n',CSVFileName);
	fclose(ptx);

	dirc = sprintf('%s/%s.tex',OutCSVDir,CSVFileName);
	ltx = fopen (dirc, "w", "ieee-le");
	if(ltx<0)
		fprintf('MTCSVTable - Could Not Create File %s - Aboting\r\n',CSVFileName);
		return
	end
    
    tblstruct =  StructSubstance();
    retStruct = CSVFileReadToStruct(InCSVDir, CSVFileName, tblstruct);
    rsz = size(retStruct);
    rows = rsz(2);
    fields = fieldnames(tblstruct);
    csz = size(fields);
    csz = csz(1);
    fsx = length(FldAry);
    

    % Fix the table captions to sit directly on the table, but figures do NOT sit directly on the figure.
    fprintf(ltx,'\\begin{table}[htbp]\r\n');
    fprintf(ltx,'\\captionof{table}{%s}\\label{%s}\r\n',Caption,CSVFileName);
    X = repmat('X',1,fsx);
    fprintf(ltx,'\\begin{tabularx}{6.5in}{%s}\r\n',X);
    fprintf(ltx,'\\hline\r\n');

    % Column Headings
    for ii = 1:fsx
        fmttxt = sprintf('%s',string(Labels{1,FldAry(ii)}{1,2}));
        fprintf(ltx,fmttxt,Labels{1,FldAry(ii)}{1,1});
         if ii ~= fsx
             fprintf(ltx,' & ');
         else
             fprintf(ltx,' \\\\ ');
         end
    end
    fprintf(ltx,'\r\n');
    fprintf(ltx,'\\hline\r\n');

    % Data
    for ii = 1:rows
        for jj = 1:fsx
            fmttxt = sprintf('%s',string(Labels{1,FldAry(jj)}{1,3}));
            val = retStruct(ii).(fields{FldAry(jj)});
            fprintf(ltx,fmttxt,val);
            if jj ~= fsx
                fprintf(ltx,' & ');
            else
                fprintf(ltx,' \\\\ ');
            end
        end
        fprintf(ltx,'\r\n');
    end
    
    fprintf(ltx,'\\hline\r\n');
    fprintf(ltx,'\\end{tabularx}\r\n');
    fprintf(ltx,'\\end{table}\r\n');
    fprintf(ltx,'\r\n\r\n');

    fclose(ptx);
end