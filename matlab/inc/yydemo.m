clf;
 x = 0:0.1:2*pi;
 y1 = sin (x);
 y2 = exp (x - 1);
 ax = plotyy (x,y1, x-1,y2, @plot, @semilogy);
 xlabel ("X");
 ylabel (ax(1), "Axis 1");
 ylabel (ax(2), "Axis 2");
 lcolor = get (gca, "ColorOrder")(1,:);
 rcolor = get (gca, "ColorOrder")(2,:);
 text (0.5, 0.5, "Left Axis", ...
       "color", lcolor, "horizontalalignment", "center", "parent", ax(1));
 text (4.5, 80, "Right Axis", ...
       "color", rcolor, "horizontalalignment", "center", "parent", ax(2));
 title ({"plotyy() example"; "left axis uses @plot, right axis uses @semilogy"});