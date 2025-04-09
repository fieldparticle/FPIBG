clc
clear all
P = [2.532,12.977,14.970]
R = 0.20;
Center = 11.0;
PR = P-Center
Rad = PR(1)^2+PR(2)^2
PRW = (P-R)-Center
RadW = PRW(1)^2+PRW(2)^2
SRadW = sqrt(RadW)
