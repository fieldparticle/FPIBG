%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date:  $
% $HeadURL:  $
% $Id:  $
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
%               
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision:  $
%*
%*
%******************************************************************/


clc
clear all
close all
fclose all

addPathCD('matlab/MPS/main')
mp      = mps();
FILESELECT = 2;
mp.MAX_ARY = 30;
SubDivFilelist = [  "J:/VCUBEData/analysis/27SubDivFile.csv",...
                    "J:/VCUBEData/analysis/343SubDivFile.csv"];
opts = detectImportOptions(SubDivFilelist(FILESELECT));
mp.SubDivTable = readtable(SubDivFilelist(FILESELECT),opts);




filelist = ["J:/VCUBEData/analysis/27ParticleFile.csv",...
            "J:/VCUBEData/analysis/343ParticleFile.csv"];
opts = detectImportOptions(filelist(FILESELECT));
opts.DataLines = 3;
opts.VariableNamesLine = 1;
T = readtable(filelist(FILESELECT),opts);
mp.ptot = size(T,1);
 for P = 1:mp.ptot
     % Assign new element to particle structure
    mp.p(P)             = StructParticle();
    mp.p(P).pnum        = P;
   
    
    % Set particle number.
    
    

    % Assign positon
    mp.p(P).rx                 = T{P,2};
    mp.p(P).ry                 = T{P,3};
    mp.p(P).rz                 = T{P,4};

    % Assign radius.
    mp.p(P).radius             = T{P,5};

    span = 4;
    for jj = 1:8
        mp.p(P).zlink(jj)    = T{P,17+jj};
        
        
    end
    %mp.DeDup(P);
 end

 if 0
    mp.ScanSubDivision();
 else   
   
    for P = 1:mp.ptot
        mp.ScanParticle(P);
    end
 end
    fprintf('%d collisions, %d particles\r\n',length(mp.colary),mp.ptot);
