
xx = 7.0;
yy = 19.0;
for ii = 1:10
    
   mp.AddParticle(  xx,...    % X position
                    yy,...     % Y Position
                    4.00,...     % Z Position
                    0.20,...    % Radius
                    0.0,...     % x velocity
                    0.0,...     % y velocity
                    0.5,...     % z velocity
                    1.0,...     %seq
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    
    xx = xx+1;
    yy = yy-1;        
end
   