function I = paintObject(shader,D,F,p,Vn,Pc,C,S,ka,kd,ks,ncoeff,Ia,I0,X)
%Sioppidis Athanasios 9090

s = numel(F(:,1));
Vtriangle = zeros(s,3,2);%contains s triangles their 3 peaks and each peak's x,y values 
Dtriangle = zeros(s,1);%contains the depth that the triangles are being drawn
%set values using F as index
V=p;
kaTriangle = zeros(s,3,3);
kdTriangle = zeros(s,3,3);
ksTriangle = zeros(s,3,3);
normalsTriangle = zeros(s,3,3);
for i=1:s    
Vtriangle(i,:,:) = V(F(i,:),:);
Dtriangle(i,1) = sum(D(F(i,:)))/3;
kaTriangle(i,:,:) = ka(:,F(i,:));
kdTriangle(i,:,:) = kd(:,F(i,:));
ksTriangle(i,:,:) = ks(:,F(i,:));
normalsTriangle(i,:,:) = Vn(:,F(i,:));
end

%sort the depths of triangle in descending order and get the index
[~,In] = sort(Dtriangle,'descend');
%sort Arrays using the index
VSorted = Vtriangle(In,:,:);
kaSorted = kaTriangle(In,:,:);
kdSorted = kdTriangle(In,:,:);
ksSorted = ksTriangle(In,:,:);
normalsSorted = normalsTriangle(In,:,:);
PcSorted = Pc(In,:,:);
%swap the dimensions of the arrays
V2 = permute(VSorted,[2 3 1]);
ka2 = permute(kaSorted,[2 3 1]);
kd2 = permute(kdSorted,[2 3 1]);
ks2 = permute(ksSorted,[2 3 1]);
normals2 = permute(normalsSorted,[2 3 1]);
Pc2 = permute(PcSorted,[2 3 1]);
I = X;
%shade object depending on shader value
if shader ==1
    for i=1:s
        I = shadeGouraud(V2(:,:,i),normals2(:,:,i),Pc2(:,:,i),C,S,ka2(:,:,i),kd2(:,:,i),ks2(:,:,i),ncoeff,Ia,I0,I);  
    end
else
    for i=1:s
        I = shadePhong(V2(:,:,i),normals2(:,:,i),Pc2(:,:,i),C,S,ka2(:,:,i),kd2(:,:,i),ks2(:,:,i),ncoeff,Ia,I0,I);  
    end
end
end

