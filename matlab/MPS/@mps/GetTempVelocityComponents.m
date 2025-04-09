function [vel,velary] = GetTempVelocityComponents(obj,P)

    xvel = 0.515;
    yvel = 0.515;
    zvel = 0.515;
    
    vel = obj.CalcTAccu(P,250);
    veltmp = xvel^2 + yvel^2 + zvel^2;
    velary(1) = xvel;
    velary(2) = yvel;
    velary(3) = zvel;
    fprintf("Temperature Velocity:%0.6f, Calulated velocity %0.6f, Velocity components <%0.6f,%0.6f,%0.6f>\r\n",...
        vel,veltmp,xvel,yvel,zvel);
end