clc
clear all
close all
more off
addpath('J:/sandboxR6/svnmatlab/Latex')
addpath('J:/sandboxR6/svnmatlab/mps')
addpath('J:/sandboxR6/svnmatlab/mps/common')
addpath('J:/sandboxR6/svnmatlab/mps/main')
if 1
mp      = mps();
mp.gpu_name = 'Quadro M3000M';
mp.SetMonitor(1,3,0,0);
end
% move figure to mintor and run
%pos = get (gcf, 'position');
%set(0, 'DefaultFigurePosition', pos)
figure2(3)