function [P,D] = projectCamera(w,cv,cx,cy,p)

cz = cross(cx,cy);
pCCS = systemTransform(p,cx,cy,cz,cv);
P = zeros(2,length(pCCS(1,:)));
D = zeros(length(pCCS(1,:)),1);
for i=1:length(pCCS(1,:))
P(:,i) = (w/(pCCS(3,i)))*[pCCS(1,i) pCCS(2,i)]; %3d to 2d points
D(i) = pCCS(3,i); %depth
end
end

