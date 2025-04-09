clc
clear all
close all
 
N = 1;
a = -1; b = 1;
for i = 1:100
    r = a + (b-a) .* rand(N,1)
end