 seq = 0.0;
 a = 0.01; b = -0.01;
    quitFlag = false;
    divpi = 55.0;
    radius = Radius-1;
    endpt = 128;
    endpt = 60;    
if 1
    for z = 1:1:endpt
        
        if(quitFlag == true)
            break;
        end
        divpi = 55.0;
        for radius = Radius-1:Radius-1 
            if(quitFlag == true)
                break;
            end
           for t = pi()/2.0 : pi()/divpi : pi()/2.0+5*pi()/divpi
                colx = radius*cos(t)+Center;
                rowy = radius*sin(t)+Center;
                vx = 0.0;
                vy = 0.0;
                if 0
                vy =  a + (b-a) .* rand(1,1);
                vx =  a + (b-a) .* rand(1,1);
                end
                if 0
                if(mod(Radius,2)==0)
                    vx = -0.5;
                    vy = 0.5;
                elseif(mod(Radius,3)==0)
                    vx = 0.5;
                    vy = -0.5;
                else
                    vx = 0.5;
                    vy = 0.5;
                end
                end
                vz = 0.5;
                P = mp.AddParticle(colx,...
                        rowy,1,0.20,...
                        vx,vy,vz,...
                        seq,...
                        0.0,0.0,"He");
                if(P == 5797)
                  quitFlag = false;
                   break;
                end
            end
            divpi = divpi-(1.6)^2;
        end
    seq = seq+150;
    end
end

%#################################################
seq = 0.0;
 a = 0.01; b = -0.01;
    quitFlag = false;
    divpi = 55.0;
    radius = Radius-1;
    endpt = 128;
    endpt = 60;    
for z = 1:1:endpt
        
        if(quitFlag == true)
            break;
        end
        divpi = 55.0;
        for radius = Radius-1:Radius-1 
            if(quitFlag == true)
                break;
            end
           for t = (6/4)*pi() : pi()/divpi : (6/4)*pi()+5*pi()/divpi
                colx = radius*cos(t)+Center;
                rowy = radius*sin(t)+Center;
                vx = 0.0;
                vy = 0.0;
                if 0
                vy =  a + (b-a) .* rand(1,1);
                vx =  a + (b-a) .* rand(1,1);
                end
                if 0
                if(mod(Radius,2)==0)
                    vx = -0.5;
                    vy = 0.5;
                elseif(mod(Radius,3)==0)
                    vx = 0.5;
                    vy = -0.5;
                else
                    vx = 0.5;
                    vy = 0.5;
                end
                end
                vz = 0.5;
                P = mp.AddParticle(colx,...
                        rowy,1,0.20,...
                        vx,vy,vz,...
                        seq,...
                        0.0,0.0,"He");
                if(P == 5797)
                  quitFlag = false;
                   break;
                end
            end
            divpi = divpi-(1.6)^2;
        end
    seq = seq+150;
    end