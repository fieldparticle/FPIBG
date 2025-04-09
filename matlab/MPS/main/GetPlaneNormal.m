function [A,B,C,D] = GetPlaneNormal(P1,P2,P3)
   parm1 =  P1-P2
    parm2 = P1-P3
    normal = cross(P1-P2, P1-P3); %# Calculate plane normal
    %Find all coefficients of plane equation    
    A = normal(1); B = normal(2); C = normal(3);
    D = -dot(normal,P1)


end