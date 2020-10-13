function I = paintObject(V,F,C,D,painter)
%Sioppidis Athanasios 9090

s = numel(F(:,1));
Vtriangle = zeros(s,3,2);%contains s triangles their 3 peaks and each peak's x,y values 
Ctriangle= zeros(s,3,3);%contains the color of the peaks of each triangle
Dtriangle = zeros(s,1);%contains the depth that the triangles are being drawn
%set values using F as index
for i=1:s    
Vtriangle(i,:,:) = V(F(i,:),:);
Ctriangle(i,:,:) = C(F(i,:),:);
Dtriangle(i,1) = sum(D(F(i,:)))/3;
end
%sort the depths of triangle in descending order and get the index
[~,In] = sort(Dtriangle,'descend');
%sort Vtriangle and Ctriangle using the index
VSorted = Vtriangle(In,:,:);
CSorted  = Ctriangle(In,:,:);
%swap the dimensions of the arrays
V2 = permute(VSorted,[2 3 1]);
C2 = permute(CSorted,[2 3 1]);
%initialize a white picture
I = ones(1200,1200,3);
%paint the picture depending on value of painter
if(painter == "Flat") 
for i=1:1:s
    I = triPaintFlat(I,V2(:,:,i),C2(:,:,i));  
end
elseif(painter == "Gouraud")
for i=1:1:s
    I = triPaintGouraud(I,V2(:,:,i),C2(:,:,i));  
end
else
    fprintf("Wrong Input");
end
end

