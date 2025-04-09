function plotCenters(obj,X,Y,Z)
        
    X=X+0.5;
    Y=Y+0.5;
    Z=Z+0.5;
    axlen = 20;
    axspan = 0.02;
    xax = [X-axlen*axspan,X+axlen*axspan];
    yax = [Y-axlen*axspan,Y+axlen*axspan];
    zax = [Z-axlen*axspan,Z+axlen*axspan];
    plot3(xax,[Y,Y],[Z,Z],'linewidth',2,'color',[0.0,0.0,0.0])
    plot3([X,X],yax,[Z,Z],'linewidth',2,'color',[0.0,0.0,0.0])
    plot3([X,X],[Y,Y],zax,'linewidth',2,'color',[0.0,0.0,0.0])
    obj.PlotPoint(X,Y,Z,0.01,[1.0,0.0,0.0]);
end