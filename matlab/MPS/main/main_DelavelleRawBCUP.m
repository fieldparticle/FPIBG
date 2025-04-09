clc
clear all
%close all
clf
addPathCD('matlab/MPS/main')
pipe_L = 64;
pipe_W = 20;
pipe_H = 20;
Center = 11.0;
Radius = pipe_W/2.0;
if 0
st = [];
ct = [];
cz = [];
figure
hold on
for z = 1:1:pipe_L
    Radius = GetDevalleRadius(z);
    for t = 0:pi/100:2*pi
        colx = Radius*cos(t)+Center;
        rowy = Radius*sin(t)+Center;
        cz(end+1) = z;
        st(end+1) = rowy;
        ct(end+1) = colx;
       
    end
    plot3(cz,st,ct);
    st = [];
    ct = [];
    cz = [];
end

hold off
end
%figure
clf
hold on
r = [];
for z = 1:1:pipe_L
    r(end+1) = GetDevalleRadius(z);
end

%Set up cylinder
[SX,SY,SZ] = cylinder(r);
SZ=SZ*pipe_L;
SX=SX+11;
SY=SY+11;

pointB = [];
pointMass = [];

%##### Set starting point and Angle
zpt = 12.0;
angxy = pi()/4.0;
% Divisor for point B
divisorPointD = 1024;
velvec = [0.0,10.0,10.0];
%##### Set starting point and Angle

%# Set location of point A
Radius = GetDevalleRadius(zpt);
pointA(1) = Radius*cos(angxy)+Center;
pointA(2) = Radius*sin(angxy)+Center;
pointA(3) = zpt;

%# Set location of point croos product vect
pointCRS(1) = Radius*cos(angxy)+Center;
pointCRS(2) = Radius*sin(angxy)+Center;
pointCRS(3) = zpt+2;

% Plot vector from center to point A in black
XX = [Center,pointA(1)];
YY = [Center,pointA(2)];
ZZ = [pointA(3),pointA(3)];
plot3(XX,YY,ZZ,'-k','LineWidth',2)
plot3(pointA(1),pointA(2),pointA(3),'*k','MarkerSize',5)

%angxy = atan2piPt([pointA(1)-Center,pointA(2)-Center]);

%# Set location of point mass
zpt =  pointA(3)-1;
Radius = GetDevalleRadius(zpt);
pointMass(1) = Radius*cos(angxy)+Center;
pointMass(2) = Radius*sin(angxy)+Center;
pointMass(3) = zpt;

%# Set location of point B
zpt = pointA(3)-2;
Radius = GetDevalleRadius(zpt);
pointB(1) = Radius*cos(angxy)+Center;
pointB(2) = Radius*sin(angxy)+Center;
pointB(3) = zpt;

% Plot vector from center to point B in red
XX = [Center,pointB(1)];
YY = [Center,pointB(2)];
ZZ = [pointB(3),pointB(3)];
plot3(XX,YY,ZZ,'-r','LineWidth',2)
plot3(pointB(1),pointB(2),pointB(3),'*r','MarkerSize',5)

%# Set location of point D
Radius = GetDevalleRadius(pointA(3));
pointD(1) = Radius*cos(angxy+pi()/divisorPointD)+Center;
pointD(2) = Radius*sin(angxy+pi()/divisorPointD)+Center;
pointD(3) = pointA(3);

% Plot vector from center to point D in black
XX = [Center,pointD(1)];
YY = [Center,pointD(2)];
ZZ = [pointD(3),pointD(3)];
plot3(XX,YY,ZZ,'-','Color',[0.5,0.5,0.5],'LineWidth',2)
plot3(pointD(1),pointD(2),pointD(3),'o',...
    'Color',[0.5,0.5,0.5],'MarkerSize',5)


%-------------------- END POINTS

% Plot velcoity vector.
XX = [pointMass(1)-velvec(1),pointMass(1)];
YY = [pointMass(2)-velvec(2),pointMass(2)];
ZZ = [pointMass(3)-velvec(3),pointMass(3)];
plot3(XX,YY,ZZ,'-','Color',[1.0,0.0,1.0],'LineWidth',2)
%plot3(XX(2),YY(2),ZZ(2),'Color',[0.5,0.5,0.5],'MarkerSize',5)

%#---------- Cross vec
crossvec = pointB-pointA;
rescrs = cross(crossvec,pointMass-Center);
XX = [pointMass(1),rescrs(1)];
YY = [pointMass(2),rescrs(2)];
ZZ = [pointMass(3),rescrs(3)];
plot3(XX,YY,ZZ,'--','Color',[0.0,0.0,0.0],'LineWidth',2)
plot3(pointD(1),pointD(2),pointD(3),'o',...
    'Color',[0.0,0.0,0.0],'MarkerSize',5)
pointE = pointMass+rescrs;

% Get normal vector
[A,B,C,D] = GetPlaneNormal(pointA,pointMass,pointE);

% Draw normal vector
normvec = [A,B,C];
XX = [pointMass(1),15*normvec(1)+pointMass(1)];
YY = [pointMass(2),15*normvec(2)+pointMass(2)];
ZZ = [pointMass(3),normvec(3)+pointMass(3)];
plot3(XX,YY,ZZ,'-','Color',[127.0/255.0,0.0,1.0],'LineWidth',2)
plot3(XX(2),YY(2),ZZ(2),'-*','Color',[127.0/255.0,0.0,1.0],'MarkerSize',5)

% Check normvec 
dx = pointA(2)-pointB(2);
dy = pointA(3)-pointB(3);
slpchk = dx/dy;


% Plot slope vector black
slopevec = pointA-pointB;
XX = [pointA(1),pointB(1)];
YY = [pointA(2),pointB(2)];
ZZ = [pointA(3),pointB(3)];
plot3(XX,YY,ZZ,'-','Color',[0.0,0.0,0.0],'LineWidth',2)
plot3(pointD(1),pointD(2),pointD(3),'o',...
    'Color',[0.0,0.0,0.0],'MarkerSize',5)


res = dot(slopevec,normvec);
if(res > 1E-10)
    fprintf('Dot Product failed:%d\r\n',res);
else
    fprintf('Dot Product Correct:%d\r\n',res);
end


I = [1.0,1.0,1.0];
nvec = normvec/norm(normvec);
reflected = velvec - 2.0.*(dot(velvec,nvec).*nvec);
%reflected = cross(normvec,velvec);
rvelvec = reflected;

%Calc angle of incedence
u = slopevec;
v = velvec;
angi = atan2(norm(cross(u,v)),dot(u,v));

%Angle of reflection
v = slopevec;
u = rvelvec;
angr = atan2(norm(cross(u,v)),dot(u,v));



% Draw reflected velocity vector
XX = [pointMass(1),rvelvec(1)+pointMass(1)];
YY = [pointMass(2),rvelvec(2)+pointMass(2)];
ZZ = [pointMass(3),rvelvec(3)+pointMass(3)];
plot3(XX,YY,ZZ,'-*','Color',[0.0,1.0,0.0],'LineWidth',2)

if 1
%Draw plane
x = [pointA(1) pointB(1) pointD(1)];  
y = [pointA(2) pointB(2) pointD(2)];
z = [pointA(3) pointB(3) pointD(3)];
xLim = [min(x)-2.0 max(x)+2.0];
zLim = [min(z) max(z)];
[X,Z] = meshgrid(xLim,zLim);
Y = (A * X + C * Z + D)/ (-B);
reOrder = [1 2  4 3];
patch(X(reOrder),Y(reOrder),Z(reOrder),'b','LineWidth',2);
end

if 1
    surf(SX,SY,SZ);
    axis([0,22,0,22,0,64]);
else
    axis([0,22,0,22,5,20]);
end
view([0 0]);
%daspect([2 2 1])
%camup([0 1 0]);
hold off

