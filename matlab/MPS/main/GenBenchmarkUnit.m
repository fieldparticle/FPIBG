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
% mp = scene object
% RR    = radius
% sidelen = length of a side
% pincell   = 
function GenBenchmarkUnit(mp,RR,sidelen,pincell,cincell,totparts)

    mp.totparts = totparts;
    mp.centerlen = RR/4+RR;
    mp.pinrow = floor(0.5/mp.centerlen);
    mp.pinlayer = mp.pinrow^2;
    mp.pincell = mp.pinlayer*mp.pinrow;
    if(mp.pincell > mp.totparts)
        mp.pincell = mp.totparts;
    end
    %The 0.5 is becasue collsi9ons come in pairs
    mp.cincell = 0.5*(mp.cdensity)*mp.pincell;
    mp.SideLen = mp.CalcSideLen(mp.pincell,mp.totparts);

    fprintf("Centerlength:%0.4f,Particle in row:%d,particles in layer:%d\r\n",...
            mp.centerlen,mp.pinrow ,mp.pinlayer);
    fprintf("Paricles in cell:%d,sidelength:%d\r\n",...
            mp.pincell,mp.SideLen);    
    
    mp.pincellcount = 0;
    mp.ptotcount = 0;
    mp.cincellcount = 0;
   
    for zcell=0:mp.SideLen-1
       for ycell=0:mp.SideLen-1
            for xcell=0:mp.SideLen-1
                    mp.pincellcount = 0;
                    mp.cincellcount = 0;
                    ret = 0;
                    layer=0;
                    while(ret == 0)
                        ret = GenBenchmarkAddPattern001(mp,RR,...
                                        layer,...
                                        xcell,...
                                        ycell,...
                                        zcell,...
                                        totparts-1,...
                                        pincell,...
                                        cincell);
                        if(mp.ptotcount >= totparts)
                            return
                        end
                        
                        layer=layer + 1 ;
                    end
          
            end
        end
    end    
end














