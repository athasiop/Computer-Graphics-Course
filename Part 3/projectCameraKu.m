function [P,D] = projectCameraKu(w,cv,ck,cu,p)
CK = ck-cv;
zc = (1/norm(CK))*CK; %normalize
t = cu - dot(cu,zc)*zc;
yc = (1/(norm(t)))*t; %normalize
xc = cross(yc,zc);
[P,D] = projectCamera(w,cv,xc,yc,p);
end

