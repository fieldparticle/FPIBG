function ret =  MatlabTableIEEE(matlbtbl)
        
        datalen =  length(matlbtbl.Properties.UserData);
        if (mod(datalen,2) ~= 0)
            printf('MatlabTableIEEE - unbalanced input data - aborting\r\n',latex_fl);
			return
        end
        colary = [];
        datalen = datalen;
        Name = "";
        landscape       = false;
        alignauto       = true;
        LeftMargin      = 0;
        height          = 0;
        FontSize        = 0;
        VertSpacing     = 0;
        CapWidth        = 0;
        Title           = "";
        tdir            = "";
        Align           = "";
        boolhorz        = "";
        RowStart        = 0;
        RowEnd          = 0;
        placement       = false;
        anghdr          = false;
        float           = "";
        tcount          = 0;
        horzLines = false;
        subtable        = false;
        for ii = 1:2:datalen
            if (strcmp('Name',matlbtbl.Properties.UserData{ii}))
                Name = matlbtbl.Properties.UserData{ii+1};
            elseif(strcmp('AlignAuto',matlbtbl.Properties.UserData{ii}))
                alignauto = matlbtbl.Properties.UserData{ii+1};
                
            elseif(strcmp('LeftMargin',matlbtbl.Properties.UserData{ii}))
                LeftMargin = matlbtbl.Properties.UserData{ii+1};
            elseif(strcmp('FontSize',matlbtbl.Properties.UserData{ii}))
                FontSize = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('VertSpacing',matlbtbl.Properties.UserData{ii}))
               VertSpacing = matlbtbl.Properties.UserData{ii+1};
            elseif(strcmp('Height',matlbtbl.Properties.UserData{ii}))
                height = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('CapWidth',matlbtbl.Properties.UserData{ii}))
               CapWidth = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('Title',matlbtbl.Properties.UserData{ii}))
               Title = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('Alignment',matlbtbl.Properties.UserData{ii}))
               Align = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('Directory',matlbtbl.Properties.UserData{ii}))
               tdir = matlbtbl.Properties.UserData{ii+1};
            elseif (strcmp('RowStart',matlbtbl.Properties.UserData{ii}))
               RowStart = matlbtbl.Properties.UserData{ii+1}; 
            elseif (strcmp('RowEnd',matlbtbl.Properties.UserData{ii}))
               RowEnd = matlbtbl.Properties.UserData{ii+1}; 
            elseif (strcmp('placement',matlbtbl.Properties.UserData{ii}))
               placement = matlbtbl.Properties.UserData{ii+1}; 
            elseif (strcmp('float',matlbtbl.Properties.UserData{ii}))
               float = matlbtbl.Properties.UserData{ii+1}; 
            elseif (strcmp('HorzLine',matlbtbl.Properties.UserData{ii}))
               horzLines = matlbtbl.Properties.UserData{ii+1};               
            elseif (strcmp('subtable',matlbtbl.Properties.UserData{ii}))
               subtable = matlbtbl.Properties.UserData{ii+1};               
            elseif (strcmp('tablenum',matlbtbl.Properties.UserData{ii}))
               tcount = matlbtbl.Properties.UserData{ii+1};  
            elseif (strcmp('angleheader',matlbtbl.Properties.UserData{ii}))
               anghdr = matlbtbl.Properties.UserData{ii+1};  
            elseif (strcmp('cols',matlbtbl.Properties.UserData{ii}))
               colary = matlbtbl.Properties.UserData{ii+1};  
            elseif (strcmp('landscape',matlbtbl.Properties.UserData{ii}))
               landscape = matlbtbl.Properties.UserData{ii+1};  
            end
        end
        
        
         %============================
        %=========== BEGINPRE =================
        %============================
        %% Write reference to pre.tex
		fprintf('This is MatlabTableIEEE - %s\r\n',Name) 
        latex_fl = sprintf('%s/tablespre.tex',tdir);
		ptx = fopen (latex_fl, "a", "ieee-le");
        if(ptx<0)
            fprintf('MatlabTableIEEE - Failed to open pre.tex - aborting\r\n');
            return
        end
		
		txt = sprintf('\\input{../tables/%s.tex}',Name);
		fprintf(ptx,'======================= %s =======================\r\n',Name);
		fprintf(ptx,'%s\r\n%s\r\n',sprintf('\\ref{tab:%s}',Name),txt);
		%fprintf(ltx,'%s\r\n',sprintf('\\input{../equations/%s.tex}\r\n',Name));
		fprintf(ptx,'======================= %s =======================\r\n',Name);
		
		fclose(ptx);

        %============================
        %=========== Create table =================
        %============================
		dirc = sprintf('%s/%s.tex',tdir,Name);
		ltx = fopen (dirc, "w", "ieee-le");
		if(ltx<0)
			fprintf('Table - Could Not Create File %s - Aboting\r\n',latex_fl);
			return
        end
        
        fprintf(ltx,'%s\r\n','\begin{flushleft}');
        
        %============================
        %=========== Begin Table =================
        %============================
        
        if(float)
            if(~landscape)
                fprintf(ltx,'%s%s\r\n','\begin{table*}',placement);
            else
                fprintf(ltx,'%s%s\r\n','\begin{sidewaystable}',placement);
            end
        else
            if(~landscape)
                fprintf(ltx,'%s%s\r\n','\begin{table}',placement);
            else
                fprintf(ltx,'%s%s\r\n','\begin{sidewaystable}',placement);
            end
        end
        if(tcount < subtable)
            fprintf(ltx,'%s','\begin{subtable}[c]{0.5\textwidth}\r\n');
        end
        %============================
        %=========== Font =================
        %============================
        fprintf(ltx,'%s\r\n',sprintf('\\fontsize{%d}{%d}\\selectfont',FontSize,VertSpacing));
        fprintf(ltx,'\\renewcommand{\\arraystretch}{%0.2f}',height);
        %============================
        %=========== Caption =================
        %============================
        fprintf(ltx,'%s\r\n',sprintf('\\caption{%s}',matlbtbl.Properties.Description));
        fprintf(ltx,'%s\r\n',sprintf('\\label{tab:%s}',Name));
        if(Align == "")
		    fprintf(ltx,'\\centering');
        end
        fprintf(ltx,'\\hspace*{%0.2fpt}\r\n',1.5);

        %============================
        %=========== Begin Tabluar =================
        %============================
        fprintf(ltx,'%s\r\n','\begin{NiceTabular}');
        lenCol = 0;

        %============================
        %=========== Column definition =================
        %============================
        advec = "";
        fprintf(ltx,'%s','{');
        if(alignauto)
            for tt= 1:size(matlbtbl,2)
                matlbtbl.Properties.VariableUnits{1,tt} = '%s'; 
                if(horzLines)
                    if(tt == 1)
                        advec = advec + sprintf('|%s|',Align);
                    else
                        advec = advec + sprintf('%s|',Align);
                    end
                else
                    advec = advec + Align;
                end
            end
            if(anghdr)
                fprintf(ltx,'%s}\r\n',advec);    
            else
                fprintf(ltx,'%s}%s\r\n',advec,' \hline');    
            end
        end
        if(~alignauto)
             fprintf(ltx,'%s}\r\n',Align); 
        end
        %============================
        %=========== Header =================
        %============================
        if(~anghdr)
            for cc = 1:length(matlbtbl.Properties.VariableNames)
		        txt = sprintf('%s',matlbtbl.Properties.VariableNames{cc});
		        fprintf(ltx,'%s',txt);
                if(cc ~= length(matlbtbl.Properties.VariableNames))
		            fprintf(ltx,'&');
                end
    	    end
        else
            for cc = 1:length(matlbtbl.Properties.VariableNames)
                txt = sprintf('%s',matlbtbl.Properties.VariableNames{cc});
                fprintf(ltx,'\\Rot{%s}',txt);
                if(cc ~= length(matlbtbl.Properties.VariableNames))
                    fprintf(ltx,'&');
                end
            end
        end
        

	    fprintf(ltx,'%s\r\n',' \\ \hline ');
        %============================
        %=========== Calc rows/cols  =================
        %============================
	    cols = size(matlbtbl,2);
        rows = size(matlbtbl,1);
        if(RowStart ~= 0)
            rowstart = RowStart;
            rowstend = RowEnd;
            if(RowEnd > rows)
                rowstend = rows;
            end
        else    
            rowstend = rows;
            rowstart = 1;
        end
        %============================
        %=========== Fill Tables  =================
        %============================
        for rr = rowstart:rowstend
            for cc = 1:cols
               frmt = sprintf('%s',matlbtbl.Properties.VariableUnits{cc});
               val = matlbtbl{rr,cc};
               classOfElement = class(val);
               if strcmp(classOfElement,'double')
                    if (isnan(val))
                         val = " ";
                    end
                    fprintf(ltx,'%s',sprintf(frmt,val));
               elseif strcmp(classOfElement,'cell')
					if(string(val) ~= ':')
						fprintf(ltx,'%s',sprintf(frmt,string(val)));
					end
               end
               if(cc ~= cols)
                    fprintf(ltx,'&');
               end
            end
               fprintf(ltx,'\\\\ \\hline      \r\n');
          
        end
   
    %==================Footer=========================
	fprintf(ltx,' \r\n');
    if(tcount < subtable)
        fprintf(ltx,'%s','\subcaption{subtable no. 1}\r\n\end{subtable}\r\n');
    end
    %============================
    %=========== Rotation codes =================
    %============================
    
    if(anghdr)
		fprintf(ltx,'\\CodeAfter  \r\n');
        for rc = 1:cols
            fprintf(ltx,'\\MixedRule{%d} \r\n',rc);
        end
    end

    %============================
    %=========== End Tabluar =================
    %============================
	fprintf(ltx,'%s\r\n','\end{NiceTabular}');
    if(tcount == subtable && subtable ~= 0)
         fprintf(ltx,'%s','\end{subtable}\r\n');
    end
    %============================
    %=========== End Table =================
    %============================
	
    
    if(float)
        if(~landscape)
	        fprintf(ltx,'%s\r\n','\end{table*}');
        else
            fprintf(ltx,'%s\r\n','\end{sidewaystable}');
        end
    else
        if(~landscape)
	        fprintf(ltx,'%s\r\n','\end{table}');
        else
            fprintf(ltx,'%s\r\n','\end{sidewaystable}');
        end
    end
	fprintf(ltx,'%s%s\r\n','\end{flushleft}');
    fclose(ltx);
end