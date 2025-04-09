function [velF,velT] = CalcMom(P1,P2)

    
    xT = InPosF(1);
    yT = InPosF(2);
    zT = InPosF(3);
	
	xP = InPosT(1);
    yP = InPosT(2);
    zP = InPosT(3);

    x = [xP-xT,yP-yT,zP-zT];
        
    x = x/norm(x);
    v1 = InVelF;
    x1 = dot(x,v1);
    v1x = x * x1;
    v1y = v1 - v1x;
    

    x = x*-1;
    v2 = InVelT;
    x2 = dot(x,v2);
    v2x = x * x2;
    v2y = v2 - v2x;
    

    velF = v1x*(m1-m2)/(m1+m2) + v2x*(2*m2)/(m1+m2) + v1y;
    
    
    velT = v2x*(m2-m1)/(m1+m2) + v1x*(2*m1)/(m1+m2) + v2y;
    


end