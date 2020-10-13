%Sioppidis Athanasios 9090
load('duck_hw1.mat')
I = paintObject(V_2d,F,C,D,'Gouraud');
imwrite(I,'GouraudDuck.png')