function [ret,vel]  = DoCubeWall(obj,P,len)

    ret = 0;
    
    vel = [0.0,0.0,0.0];
    
    velFTOT = zeros(6,3);
    
    % Detect wall
    xTmax = obj.p(P).rx+obj.p(P).radius;
    yTmax = obj.p(P).ry+obj.p(P).radius;
    zTmax = obj.p(P).rz+obj.p(P).radius;
    
    xTmin = obj.p(P).rx-obj.p(P).radius;
    yTmin = obj.p(P).ry-obj.p(P).radius;
    zTmin = obj.p(P).rz-obj.p(P).radius;

    count = 1;
    if(xTmin < 0.5)
        fprintf("Wall Collision xTmin(%d) \r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [0.5,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [-obj.p(P).vx,obj.p(P).vy,obj.p(P).vz]);
        velFTOT(count,1) = velF(1);
        count = count+1;
        ret = 1;
    end
    if(yTmin < 0.5 )
        fprintf("Wall Collision yTmin(%d)\r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).rx,0.05,obj.p(P).rz],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [obj.p(P).vx,-obj.p(P).vy,obj.p(P).vz]);
        velFTOT(count,2) = velF(2);
        count = count+1;
        ret = 1;
    end
    if(zTmin < 0.5)
        fprintf("Wall Collision zTmin(%d)\r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).rx,obj.p(P).ry,0.5],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [obj.p(P).vx,obj.p(P).vy,-obj.p(P).vz]);
        velFTOT(count,3) = velF(3);
        count = count+1;
        ret = 1;
    end
    if(xTmax > len+0.5)
        fprintf("Wall Collision xTmax(%d) \r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [1.5,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [-obj.p(P).vx,obj.p(P).vy,obj.p(P).vz]);
        velFTOT(count,1) = velF(1);
        count = count+1;
        ret = 1;
    end
    if(yTmax > len+0.5 )
        fprintf("Wall Collision yTmax(%d)\r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).rx,1.5,obj.p(P).rz],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [obj.p(P).vx,-obj.p(P).vy,obj.p(P).vz]);
        velFTOT(count,2) = velF(2);
        count = count+1;
        ret = 1;
    end
    if(zTmax > len+0.5)
        fprintf("Wall Collision zTmax(%d)\r\n",P)
        [velF,velT] = obj.CalcMom(1,1,...
                            [obj.p(P).rx,obj.p(P).ry,obj.p(P).rz],...
                            [obj.p(P).rx,obj.p(P).ry,1.5],...
                            [obj.p(P).vx,obj.p(P).vy,obj.p(P).vz],...
                            [obj.p(P).vx,obj.p(P).vy,-obj.p(P).vz]);
        velFTOT(count,3) = velF(3);
        count = count+1;
        ret = 1;
    end
    totx=0.0;
    toty=0.0;
    totz=0.0;
    for ii=1:count-1
        totx = totx+velFTOT(ii,1);
        toty = toty+velFTOT(ii,2);  
        totz = totz+velFTOT(ii,3);
    end
    vel = [totx,toty,totz];    
    
end