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
function ret = GenBenchmarkPart()
    clc
    fprintf("1.  30\r\n");
    fprintf("2.  256 \r\n");
    fprintf("3.  4,096 \r\n");
    fprintf("4.  32,768 \r\n");   
    fprintf("5.  117,649 \r\n");   
    fprintf("6.  287,496 \r\n");   
    fprintf("7.  551,368 \r\n");   
    fprintf("8.  970,299 \r\n"); 
    fprintf("9. 2,299,968 \r\n");   
    fprintf("10. 3,307,949 \r\n"); 
    fprintf("11.  4,574,296 \r\n");   
    fprintf("12. 10,077,696 \r\n");   
    
    mnu = input("Enter Menu Item #:");
    switch mnu
        case 1
            ret = 3;
        case 2
            ret = 64;
        case 3
            ret = 256;
        case 4
            ret = 1024;
        case 5
            ret = 32768;
        case 6
            ret = 174080;
        case 7
            ret = 286720;
        case 8
            ret = 550912;
        case 9
            ret = 1004544;
        case 10
            ret = 2008064;
        case 11
            ret = 5008384;
        case 12
            ret = 7506944;
        case 13
            ret = 10005504;
        case 14
            ret = 15002624;
        case 15
            ret = 20009984;
        case 16
            ret = 30004224;
        case 17
            ret = 40008704;
        case 18
            ret = 50002944;
        otherwise
            fprintf("Not a valid response.\r\n");
            return
    end
    return;
end