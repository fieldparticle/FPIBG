clc
clear all
close all

more off
addpath('J:/sandboxR6/svnmatlab/Latex')
addpath('J:/sandboxR6/svnmatlab/mps')
addpath('J:/sandboxR6/svnmatlab/mps/common')

outvec = [12,13]
r = sqrt(outvec(1)^2+outvec(2)^2)
ovec = outvec/r
ang_xy = atan2piPt([ovec(1),ovec(2)])
xx = r*cos(ang_xy)
yy = r*sin(ang_xy)

outvec = [13,14]
r = sqrt(outvec(1)^2+outvec(2)^2)
ovec = outvec/r
ang_yz = atan2piPt([ovec(1),ovec(2)])
%zz = r*cos(ang_xy)
zz = r*sin(ang_yz)

