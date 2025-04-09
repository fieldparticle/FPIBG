%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-03-14 17:48:38 -0400 (Tue, 14 Mar 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnmatlab/FieldParticle/@Scene/SetMonitor.m $
% $Id: SetMonitor.m 5 2023-03-14 21:48:38Z jb $
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
function SetMonitor(obj,GPUNum,MNum, Height, Width)

    if (obj.gpu_num == GPUNum) ...
       &&  (obj.height == Height)...
       &&  (obj.width == Width)
        return;
    end

    n = gpuDeviceCount("available");
    if (GPUNum > n)
        fprintf("GPU Number %d not available, only %d installed.\r\n",GPUNum,n);
        obj.ErrPause();
    else    
        gp = gpuDeviceTable();
        if strcmp(obj.gpu_name,gp(GPUNum,2).Name) ~= 0
            obj.gpu_num = GPUNum;
            %ax = gca;
           % info = rendererinfo(ax);
            gpuDevice(obj.gpu_num);
            %ax = gca;
           %info = rendererinfo(ax);
        end
    end
    if 1
    p = get(0, "MonitorPositions");
    if (size(p,1) < MNum)
        fprintf("Monitor Number %d not available, only %d installed.\r\n",MNum,n);
        obj.monitor_num = 1;
        obj.ErrPause();
    else
        obj.monitor_num = MNum;
    end

    position = p(obj.monitor_num, :) ;
    scrnsz  = get(0, 'Screensize');
    if (Height == scrnsz(4) && Width == scrnsz(3))
        return
    end

    if Height == 0
        Height = scrnsz(4);
    end
    if Width == 0
        Width = scrnsz(3);
    end

    if Height > scrnsz(4)
        fprintf("Height of %d not supported, setting to max=%d.\r\n",Height,scrnsz(4));
        obj.ErrPause();
        obj.height = scrnsz(4);
    else
        obj.height = Height;
    end
    if Width > scrnsz(3)
        fprintf("Width of %d not supported, setting to max=%d.\r\n",Width,scrnsz(3));
        obj.ErrPause();
        obj.width = scrnsz(3);
    else
        obj.width = Width;
    end

    %set(0, "DefaultFigurePosition", position);
    set(0,'defaultfigurecolor',[1 1 1]);
    set(0,'defaultfigureposition',[1, 1, obj.width, obj.height]);

    end



end