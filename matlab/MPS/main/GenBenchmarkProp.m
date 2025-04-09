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
function ret = GenBenchmarkProp()
    clc
    fprintf("1.  0.05 \r\n");
    fprintf("2.  0.1 \r\n");
    fprintf("3.  0.2 \r\n");
    fprintf("4.  0.3 \r\n");   
    fprintf("5.  0.4 \r\n");   
    fprintf("6.  0.5 \r\n");   
    fprintf("7.  0.6 \r\n");   
    fprintf("8.  0.7 \r\n"); 
    fprintf("9.  0.8 \r\n");   
    fprintf("10. 0.9 \r\n");   
    fprintf("11. 1 \r\n");   
    mnu = input("Enter Menu Item #:");
    switch mnu
        case 1
            ret = 0.05;
        case 2
            ret = 0.10;
        case 3
            ret = 0.20;
        case 4
            ret = 0.30;
        case 5
            ret = 0.40;
        case 6
            ret = 0.50;
        case 7
            ret = 0.60;
        case 8
            ret = 0.70;
        case 9
            ret = 0.80;
        case 10
            ret = 0.90;
        case 11
            ret = 1.0;
    end
    return;
end