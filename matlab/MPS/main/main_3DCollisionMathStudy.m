clc
clear all
close all
addPathCD('matlab/MPS/main')


THORX         = 1;        % Horizontal X-Axis
THORY         = 2;        % Horizontal X-Axis
THORZ         = 3;   
THORXY        = 4;        % Horizontal Z Axis
THORXYZ       = 5;        % Horizontal Z Axis
THORSKIP      = 6;  
TBOUNDARY     = 7;        % Verticle Yaxis
TDEG45        = 8;        % 45 Degree 
TDEG453       = 9;        % 45 Degree 3D
TREFLECT45    = 10;        % 45 degree reflection
TMULTI        = 11;        % Test multiple concurrent collisions
THORBIN       = 12;

SIDELEN = 2;

TSType = THORX;

F = 1;
T = 2;
mp              = mps();
mp.SetTimeStep(0.001);
mp.SetSystemTemp(250);
% Set the range over which particle properties
% will be calxualted
mp.SetTempRangeLow(1);        % Base temerature low
mp.SetTempRangeHigh(400);        % Base temerature high
% Add the substances.
mp.AddSubstance("He",4.0026022,28,8.3145,-268.9+273.15);
mp.AddSubstance("He2",2*4.0026022,28,8.3145,-268.9+273.15);
H = figure(1);
clf
H.WindowState = 'maximized';

mp.CalcSubstanceProperties();
mp.AddParticle( 2.25,...    % X position
                    1.75,...     % Y Position
                    1.75,...     % Z Position
                    0.20,...    % Radius
                    0.003,...     % x velocity
                    -0.003,...     % y velocity
                    0.003,...     % z velocity
                    0.0,...     % attraction coefficient
                    0.0,...     % repulsion coefficient
                    "He");    % Substance    
                    
mp.PlotParticleCircle(1);

