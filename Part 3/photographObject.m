function Im = photographObject(shader,f,C,K,u,bC,M,N,H,W,R,F,S,ka,kd,ks,ncoeff,Ia,I0)
normals = findVertNormals(R,F);
s = numel(F(1,:));
Pc = zeros(s,3,1);
%find center of mass of triangle
for i=1:s 
Pc(i,1,1) = sum(R(1,F(:,i)))/3;
Pc(i,2,1) = sum(R(2,F(:,i)))/3; 
Pc(i,3,1) = sum(R(3,F(:,i)))/3; 
end
Im = zeros(M,N,3);
%set background colour
for i=1:3
    Im(:,:,i) = bC(i); 
end
S=S';
[Pcam,D] = projectCameraKu(f,C,K,u,R');%project on camera
P2d = rasterize(Pcam,M,N,H,W);%rasterize points to screen
Im = paintObject(shader,D,F',P2d',normals,Pc,C,S,ka,kd,ks,ncoeff,Ia,I0,Im);%paint image

end

