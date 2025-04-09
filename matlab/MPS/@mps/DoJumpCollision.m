function DoJumpCollision(obj,P1,P2)

    xT = obj.p(P1).rx;
    yT = obj.p(P1).ry;
    zT = obj.p(P1).rz;
    
    % Get source position
    xP = obj.p(P2).rx;
    yP = obj.p(P2).ry;
    zP = obj.p(P2).rz;

    % Get distance between centers
    dsq = (((xP-xT)^2+(yP-yT)^2+(zP-zT)^2));
   
    % Get combined radii
    rsq = ((obj.p(P1).radius+obj.p(P2).radius)^2);
    
    sqdist = rsq-dsq;
    dist = sqrt(sqdist);
    obj.CalcMom(1,1,InPosF,InPosT,InVelF,InVelT)
    fprintf('Squared distance:%0.4f, Acutal Dist:%0.4f\r\n',sqdist,dist);

            

end