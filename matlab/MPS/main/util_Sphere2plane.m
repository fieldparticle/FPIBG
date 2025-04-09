clc
clear all
close all

more off
run('addPath.m');
pointA = [12.5,12,1.5]
pointB = [12.5,12.5,1.0]
pointC = [12.5,11.5,0.2]

normal = cross(pointA-pointB,pointA-pointC)
%normal = cross(pointC-pointB,pointC-pointA)
dist = dot(normal, pointA)

if 1
normal = cross(pointA-pointB, pointA-pointC); 
x = [pointA(1) pointB(1) pointC(1)];  
y = [pointA(2) pointB(2) pointC(2)];
z = [pointA(3) pointB(3) pointC(3)];  
A = normal(1); B = normal(2); C = normal(3);
D = -dot(normal,pointA);
zLim = [min(z) max(z)];
yLim = [min(y) max(y)];
[Y,Z] = meshgrid(yLim,zLim);
X = (C * Z + B * Y + D)/ (-A)
reOrder = [1 2  4 3];
hold on

% Plot as surface.


% Make unit sphere
[x,y,z] = sphere;
% Scale to desire radius.
radius = 0.10;
x = x * radius;
y = y * radius;
z = z * radius;
% Translate sphere to new location.
h = surf(x+12.55,y+12.0,z+1.0) ;
plotcube([1.0,1.0,1.0],[11.5,11.5,0.5],0.3,[0.0,1.0,0.0]);

grid on;
axis 'square'
alpha(0.3);
hold off
end