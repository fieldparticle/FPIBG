clear all;
%% ========================================================
%% ===          HCL, HSV and HSL color spaces           ===
%% ===  3D HCL color space Visualization and animation  ===
%% ===    Sarifuddin Madenda : Gunadarma University     ===
%% ========================================================

%% ==== Create a 256-by-256-by-3 HSV color to texture the cone with ====
H = repmat(linspace(0, 1, 256), 256, 1);       % 256-by-256 hues
S = repmat([linspace(0, 1, 128) ...            % 256-by-256 saturations
            linspace(1, 0, 128)].', 1, 256);   
V = repmat([ones(1, 128) ...                   % 256-by-256 values
            linspace(1, 0, 128)].', 1, 256);  
hsvSpace = cat(3, H, S, V);                    % Create an HSV space
HSV = hsv2rgb(hsvSpace);                       % Convert it to an RGB space

%% ==== Create a 3D HCL, HSV and HSL coordinates ====
Max=255;
gamma=20;                
if gamma ==1                     %% gamma = 1, HSV color space
    Min=0;
elseif gamma ==34                %% gamma = 34, HSL color space
    Min=255;
else
    Min=gamma*(255/30);          %% 1 < gamma < 34, HCL color space,
end
Q=exp((Min*gamma)/(Max*100.0));
H = linspace(0, 2*pi, 256);      %% Angular points
C=Max*Q/(3.0);
L=(Q*Max+(Q-1.0)*Min)/2.0;

X = [zeros(1, 256); ...          %% X coordinates
     C.*cos(H); ...
     zeros(1, 256)];
Y = [zeros(1, 256); ...          %% Y coordinates
     C.*sin(H); ...
     zeros(1, 256)];
Z = [L.*ones(1,256); (127.5).*ones(1,256); zeros(1, 256)]; % Z coordinates

%% ==== Plot a 3D HCL, HSV and HSL coordinates ====
h = surf(X, Y, Z, HSV,...
 'FaceColor', 'texturemap',...
 'FaceAlpha',1.0,...
 'EdgeColor', 'none',...
 'LineStyle','-');

axis equal
