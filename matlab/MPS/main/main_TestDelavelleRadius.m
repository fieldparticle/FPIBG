clc
clear all
%close all
clf
addPathCD('matlab/MPS/main')
pz = [];
x = [];
for z=1:1:55
    pz(end+1) = GetDevalleRadius(z);
    x(end+1) = z;
end
hold on
plot(x,pz);
plot(x,pz,'.r');
hold off
