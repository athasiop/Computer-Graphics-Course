function Normals = findVertNormals(R,F)
s = numel(F(1,:));
NormalsTriangles = zeros(3,s);
Vtriangle = zeros(s,3,3);
%set values using F as index
for i=1:s 
Vtriangle(i,:,:) = R(:,F(:,i));
end
V2 = permute(Vtriangle,[2 3 1]);
for i=1:s
NormalsTriangles(:,i) = cross((V2(:,1,i)-V2(:,2,i)),(V2(:,2,i)-V2(:,3,i)));%find normal of trianlge
end
Normals = zeros(3,length(R));
for i=1:s
    for j=1:length(R)
        if(any(F(:,i)==j))
            Normals(:,j) = NormalsTriangles(:,i)+Normals(:,j);%find normals of each peak
        end
    end
end
for i=1:length(R)
Normals(:,i) = Normals(:,i)/norm(Normals(:,i));%normalize normals
end
end

