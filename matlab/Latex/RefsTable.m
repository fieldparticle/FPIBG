
clc
clear all
close all
fclose all

addpath('J:/sandboxR8/svnmatlab/mps')
addpath('J:/sandboxR8/svnmatlab/mps/common')
addpath('J:/sandboxR8/svnmatlab/mps/main')
addpath 'J:\sandboxR8\svnmatlab\Latex'
latex_fl = sprintf('%s','J:\sandboxR8\Thesis\bib\VCUBE.bib');
ptx = fopen (latex_fl, "r", "ieee-le");
if(ptx<0)
    fprintf('MatlabTableIEEE - Failed to open pre.tex - aborting\r\n',latex_fl);
    return
end
csv_fl = sprintf('%s','J:\sandboxR8\Thesis\bib\VCUBE.csv');
csvhndl = fopen (csv_fl, "w", "ieee-le");
if(csvhndl<0)
	fprintf('MatlabTableIEEE - Failed to open pre.tex - aborting\r\n',latex_fl);
	return
end
ignoreditor = false;
newrecord = true;
hasnote = false;
while(~feof(ptx))
    tline = fgetl(ptx);
    if(tline == "")
        newrecord = true;
        ignoreditor = false;
        if(hasnote == false)
             fprintf(csvhndl,',tbd\r\n',newStr);
        else
             fprintf(csvhndl,'\r\n',newStr);
        end
        hasnote = false;
    end
    if(contains(tline, '\')) 
        index = find(tline == '\')
        tline(index) = ' ';
    end
    if(contains(tline, '&')) 
        index = find(tline == '&');
        tline(index) = ' ';
    end
    if(contains(tline, '@article{')) 
       newStr = extractAfter(tline,"@article{");
       newStr = erase(newStr,",");
       fprintf(csvhndl,'\\citep{%s}',newStr);
       newrecord = false;
    end
    if(contains(tline, '@incollection{')) 
       newStr = extractAfter(tline,"@incollection{");
       newStr = erase(newStr,",");
       fprintf(csvhndl,'\\citep{%s}',newStr);
       newrecord = false;
    end
    if(contains(tline, '@inproceedings{')) 
       newStr = extractAfter(tline,"@inproceedings{");
       newStr = erase(newStr,",");
       fprintf(csvhndl,'\\citep{%s}',newStr);
       newrecord = false;
    end
    if(contains(tline, '@book{')) 
       newStr = extractAfter(tline,"@book{");
       newStr = erase(newStr,",");
       fprintf(csvhndl,'\\citep{%s}',newStr);
       newrecord = false;
    end
    if(contains(tline, '  title')) 
        newStr = extractAfter(tline,"title = {");
        newStr = erase(newStr,"{");
        newStr = erase(newStr,"}");
        newStr = erase(newStr,",");
        newStr = erase(newStr,"\n")
        %firstchar = newStr(1);
       % newStr = lower(newStr(2:end));
       % newStr = [firstchar, newStr];
        fprintf(csvhndl,'%s,',newStr);
        newrecord = false;
    end

    if(contains(tline, '  author')) 
        newStr = extractAfter(tline,"author = {");
        newStr = erase(newStr,"{");
        newStr = erase(newStr,"}");
        newStr = erase(newStr,",");
        newStr = erase(newStr,"\n");
        fprintf(csvhndl,'%s',newStr);
        newrecord = false;
        ignoreditor = true;
    end
    if(contains(tline, '  note = {')) 
        newStr = extractAfter(tline,"note = {");
        newStr = erase(newStr,"{");
        newStr = erase(newStr,"'");
        newStr = erase(newStr,"}");
        newStr = erase(newStr,",");
        newStr = erase(newStr,"\n");
        fprintf(csvhndl,',%s',newStr);
        hasnote = true;
    end
     
    if(contains(tline, '  editor = {')) 
        if(ignoreditor == false)
            newStr = extractAfter(tline,"  editor = {");
            newStr = erase(newStr,"{");
            newStr = erase(newStr,"}");
            newStr = erase(newStr,",");
            fprintf(csvhndl,'%s',newStr);
        end
         ignoreditor = false;    
        newrecord = false;
    end
 
  
  
    
    
end

fclose(ptx);
fclose(csvhndl);

filelist = ["J:\sandboxR8\Thesis\bib\VCUBE.csv",...
            "J:/VCUBEData/analysis/ParticleFrame2.csv"];

LatexTable = readtable(filelist(1));


LatexTable.Properties.Description = 'Table or collision detection research.';
LatexTable.Properties.VariableNames =  {'Title', 'Author', 'note'};
LatexTable.Properties.VariableUnits = {'%s', '%s', '%s'};
LatexTable.Properties.UserData = {  'Name','GPUParallelProcessing01',...
                                    'Height',1.3,...
                                    'FontSize',6,...
                                    'VertSpacing',10,...
                                    'CapWidth', 1,...
                                    'LeftMargin',0,...
                                    'Title', 'GPUParallelProcessing',...
                                    'Directory','J:/sandboxR8/Thesis',...
                                    'Alignment','| m{3in} | m{3in}| m{2in}| ',...
                                    'HorzLine','true',...
                                    'RowStart',1,...
                                    'RowEnd',25;
                                    };
LatexTable.Properties

MatlabTableIEEE(LatexTable);

LatexTable.Properties.UserData = {  'Name','GPUParallelProcessing02',...
                                    'Height',1.3,...
                                    'FontSize',6,...
                                    'VertSpacing',10,...
                                    'CapWidth', 1,...
                                    'LeftMargin',0,...
                                    'Title', 'GPUParallelProcessing',...
                                    'Directory','J:/sandboxR8/Thesis',...
                                    'Alignment','| m{3in} | m{3in}| m{2in}| ',...
                                    'HorzLine','true',...
                                    'RowStart',26,...
                                    'RowEnd',50;
                                    };

MatlabTableIEEE(LatexTable);

LatexTable.Properties.UserData = {  'Name','GPUParallelProcessing03',...
                                    'Height',1.3,...
                                    'FontSize',6,...
                                    'VertSpacing',10,...
                                    'CapWidth', 1,...
                                    'LeftMargin',0,...
                                    'Title', 'GPUParallelProcessing',...
                                    'Directory','J:/sandboxR8/Thesis',...
                                    'Alignment','| m{3in} | m{3in}| m{2in}| ',...
                                    'HorzLine','true',...
                                    'RowStart',51,...
                                    'RowEnd',75;
                                    };

MatlabTableIEEE(LatexTable);
LatexTable.Properties.UserData = {  'Name','GPUParallelProcessing04',...
                                    'Height',1.3,...
                                    'FontSize',6,...
                                    'VertSpacing',10,...
                                    'CapWidth', 1,...
                                    'LeftMargin',0,...
                                    'Title', 'GPUParallelProcessing',...
                                    'Directory','J:/sandboxR8/Thesis',...
                                    'Alignment','| m{3in} | m{3in}| m{2in}| ',...
                                    'HorzLine','true',...                                    'RowStart',76,...
                                    'RowEnd',100;
                                    };

MatlabTableIEEE(LatexTable);