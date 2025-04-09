%linestyle
%"-" Solid line. [default]
%"--" Dashed line.
%":" Dotted line.
%"-." A dash-dot line.
%"none" No line. Points will still be marked using the current Marker Style.

%marker A character indicating a plot marker to be place at each data point,
% 		or "none", meaning no markers should be displayed.


%function ret = ImageThesisR9(Name,Images,CapTitle,Caption,Zoom,ImgAry,placement,float)
function ret =  FigureR9STEP(matlbtbl)
        
        datalen =  length(matlbtbl.FigData);
        if (mod(datalen,2) ~= 0)
            printf('MatlabTableIEEE - unbalanced input data - aborting\r\n',latex_fl);
			return
        end
		
		
        datalen = datalen;
        Name = "";
        
        Scale          = 0;
        FontSize        = 0;
        Title           = "";
        tdir            = "";
        placement       = "";
        float           = "";
        
        for ii = 1:2:datalen
            if (strcmp('Name',matlbtbl.FigData{ii}))
                Name = matlbtbl.FigData{ii+1};
            elseif(strcmp('FontSize',matlbtbl.FigData{ii}))
                FontSize = matlbtbl.FigData{ii+1};
            elseif(strcmp('Scale',matlbtbl.FigData{ii}))
                Scale = matlbtbl.FigData{ii+1};
            elseif (strcmp('Title',matlbtbl.FigData{ii}))
               Title = matlbtbl.FigData{ii+1};
            elseif (strcmp('Directory',matlbtbl.FigData{ii}))
               tdir = matlbtbl.FigData{ii+1};
            elseif (strcmp('placement',matlbtbl.FigData{ii}))
               placement = matlbtbl.FigData{ii+1}; 
            elseif (strcmp('float',matlbtbl.FigData{ii}))
               float = matlbtbl.FigData{ii+1}; 
            end
        end


    if(~isempty(matlbtbl.ImageHandles))
    %---------------------------------------
    % BYHANDLES
    %---------------------------------------
    if(~isempty(matlbtbl.ImageHandles))
        numImages = size(matlbtbl.ImageHandles,2);
        flnam = "";
        for ii =1:numImages
            flnam(ii) = sprintf('%s/%s%d.png',tdir,Name,ii);
            f = matlbtbl.ImageHandles(ii);
            exportgraphics(f,flnam(ii),'Resolution',300)
        end
    %---------------------------------------
    % BYNAMES
    %---------------------------------------    
    else
        numImages = size(matlbtbl.ImagesNames,2);
        flnam = "";
        for ii =1:numImages
            flnam(ii) = sprintf('%s',string(matlbtbl.ImagesNames(ii)));
        end
    end
    
	
	fprintf('This is FigureR9 - %s\r\n',Name);
	latex_fl = sprintf('%s/%s.tex',tdir,Name);
	
	ltx = fopen (latex_fl, "w", "ieee-le");
	if(ltx<0)
		fprintf('Equation - Could Not Create File %s - Aboting\r\n',latex_fl)
		return
	end
	rows = 1;
	cols = 2;

    %---------------------------------------
    % BEGIN FIGURE
    %---------------------------------------	
    if (numImages > 1)
        if (float == 1)
	        fprintf(ltx,'\\begin{multiFigure*}\r\n');
        else
            fprintf(ltx,'\\begin{multiFigure}\r\n');
        end
    else
        if (float == 1)
	        fprintf(ltx,'\\begin{figure*}[%s]\r\n',placement);
        else
            fprintf(ltx,'\\begin{figure}[%s]\r\n',placement);
        end
    end
	fprintf(ltx,'\\centering\r\n');

    %---------------------------------------
    % MULTIFIGURE
    %---------------------------------------
	imgnum = 1;
	if numImages > 1
        fprintf(ltx,'{\r\n');
		for rr = 1:rows
			for cc = 1:cols
				%fprintf(ltx,'%s\r\n',sprintf('\\addFigure[width=%0.2fin]{%s} \\qquad',height,flnam(cc)));
                fprintf(ltx,'%s\r\n',sprintf('\\addFigure{%0.2f}{%s} \\qquad',Scale,flnam(cc)));
				imgnum =imgnum +1;
			end
			
        end	
        fprintf(ltx,'}\r\n');
	else
	%---------------------------------------
    % SINGLEFIGURE
    %---------------------------------------	
		%fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%0.2fin]{%s}',height,flnam(1)));
        scl = Scale*8.5;
        fprintf(ltx,'%s\r\n',sprintf('\\includegraphics[width=%0.2fin]{%s}',scl,flnam(1)));
	end
	

	%---------------------------------------
    % CAPTION LABEL
    %---------------------------------------		
	fprintf(ltx,'%s\r\n',sprintf('\\captionof{figure}[%s]{\\textit{%s}}',Title,matlbtbl.Caption));
	fprintf(ltx,'%s\r\n',sprintf('\\label{fig:%s}',Name));

    %---------------------------------------
    % END FIGURE
    %---------------------------------------	
    if (numImages > 1)
        if (float == 1)
	        fprintf(ltx,'\\end{multiFigure*}\r\n');
        else
            fprintf(ltx,'\\end{multiFigure}\r\n');
        end
    else
        if (float == 1)
	        fprintf(ltx,'\\end{figure*}\r\n');
        else
            fprintf(ltx,'\\end{figure}\r\n');
        end
    end
	fclose(ltx);
	

    %---------------------------------------
    % WRITE TO PRE
    %---------------------------------------	
	ltx = fopen ('..\rpt\pre.tex', "a", "ieee-le");
    if(ltx<0)
		fprintf('Equation - Could Not Create File prefile - Aboting\r\n',latex_fl)
		return
	end
	fprintf(ltx,'%%============================================= Image %s \r\n',Name);
	fprintf(ltx,'%s',sprintf('Fig. \\ref{fig:%s}\r\n',Name));
	fprintf(ltx,'%s',sprintf('\\input{../images/%s.tex}\r\n',Name));
	
	
	
	fclose(ltx);
	end


