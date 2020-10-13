function [P2d,D] = photographObject(p,M,N,H,W,w,cv,ck,cu)
[Pc,D] = projectCameraKu(w,cv,ck,cu,p);%project points to camera space
P2d = rasterize(Pc,M,N,H,W);%project points to screen space
end

