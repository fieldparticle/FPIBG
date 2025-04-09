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
%close all
ret = 0;
more off
%addpath('J:/sandboxR7/svnmatlab/Latex')
%addpath('J:/sandboxR9/svnmatlab')
%addpath('J:/sandboxR9/svnmatlab/mps/common')
%addpath('J:/sandboxR9/svnmatlab/latex/export_fig')
%addpath('J:/sandboxR9/svnmatlab/mps/main')
clf
MaxRay = 3;

lgtray = struct('angle',0.0,'slope',0.0,'xin',0.0,'yin',0.0,'xout',0.0,'yout',0.0);

drawArrow = @(x,y) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0 ) ;   
rad2ang = @(rad) (180/pi())*rad;

XL = [0.0,0.0];
YL = [0.0,20.0];

XR = [4.0,4.0];
YR = YL;
phi = 200*pi()/180;

hold on 
plot(XL,YL,'-b');
plot(XR,YR,'-b');


lgtray(1).anglei = 0;
lgtray(1).slopei = 0;
lgtray(1).angler = phi;   
lgtray(1).sloper = tan(lgtray(1).angler);
lgtray(1).xin = 5.0;
lgtray(1).yin = 25.0;
lgtray(1).xout = XL(1);
lgtray(1).yout = lgtray(1).sloper*(XL(1)-lgtray(1).xin)+lgtray(1).yin;

for ii = 1:10
    if ii ~= 1
        lgtray(ii).anglei = lgtray(ii-1).angler-pi();
        
        lgtray(ii).slopei = tan(lgtray(ii).anglei);

        lgtray(ii).angler = 2*pi()-lgtray(ii).anglei;   
        lgtray(ii).sloper = tan(lgtray(ii).angler);


        if( lgtray(ii).angler < pi()/2 || lgtray(ii).angler > 3*pi()/2)
            lgtray(ii).xout = XR(1);
        else
            lgtray(ii).xout = XL(1);
        end

       
        lgtray(ii).xin = lgtray(ii-1).xout;
        lgtray(ii).yin = lgtray(ii-1).yout;
        lgtray(ii).yout = lgtray(ii).sloper*(lgtray(ii).xout-lgtray(ii).xin)+lgtray(ii).yin;
    end
    fprintf("Ray%d thetain=%0.4f;thetaout=%0.4f;xout=%0.2f,yout%0.2f\n",...
        ii,...
        rad2ang(lgtray(ii).anglei),...
         rad2ang(lgtray(ii).angler),lgtray(ii).xout,lgtray(ii).yout);

    
    h = drawArrow([lgtray(ii).xin,lgtray(ii).xout],[lgtray(ii).yin,lgtray(ii).yout]);
    set(h,'MaxHeadSize',0.05,'AutoScaleFactor',1);
end

hold off
