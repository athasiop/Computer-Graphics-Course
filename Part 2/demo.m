clc
clear

%% Load data %%
load('hw2.mat');

%% Step 0 -Initial position 
% 0.1 Photograph object with photographObject
[P2d,D] = photographObject(V,M,N,H,W,w,cv,ck,cu);
% 0.2 Paint object with ObjectPainter with gouraud
I0 = paintObject(P2d',F,C,D,"Gouraud");
% Save result
imwrite(I0, '0.jpg');

%% Step 1 - Translate by t1
% 1.1 Apply translation
V  = affineTransform(V,eye(3),t1);
% 1.2 Photograph object with photographObject
[P2d,D] = photographObject(V,M,N,H,W,w,cv,ck,cu);
% 1.3 Paint object with ObjectPainter with gouraud
I1 = paintObject(P2d',F,C,D,"Gouraud");
% Save result
imwrite(I1, '1.jpg');

%% Step 2 - Rotate by theta around given axis
% 2.1 Apply rotation
R = rotationMatrix(theta,g);
V  = affineTransform(V,R,0);
% 2.2 Photograph object with photographObject
[P2d,D] = photographObject(V,M,N,H,W,w,cv,ck,cu);
% 2.3 Paint object with ObjectPainter with gouraud
I2 = paintObject(P2d',F,C,D,"Gouraud");
% Save result
imwrite(I2, '2.jpg');

%% Step 3 - Translate back
% 3.1 Apply translation
V  = affineTransform(V,eye(3),t2);
% 3.2 Photograph object with photographObject
[P2d,D] = photographObject(V,M,N,H,W,w,cv,ck,cu);
% 3.3 Paint object with ObjectPainter with gouraud
I3 = paintObject(P2d',F,C,D,"Gouraud");
% Save result
imwrite(I3, '3.jpg');
