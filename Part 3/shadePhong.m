function Y = shadePhong(p,Vn,Pc,C,S,ka,kd,ks,ncoeff,Ia,I0,X)
%Sioppidis Athanasios 9090

%k=edge
ykmin = zeros(3, 1);%min y of the edge
ykmax = zeros(3, 1);%max y of the edge
xkmin = zeros(3, 1);%x of peak with y=ykmin
xkmax = zeros(3, 1);%x of peak with y=ykmax
normalMin = zeros(3, 3);%normal of peak with y=ymin
normalMax = zeros(3, 3);%normals of peak with y=ymax
kdMin = zeros(3, 3);%diffuse of peak with y=ymin
kdMax = zeros(3, 3);%diffuse of peak with y=ymax
ksMin = zeros(3, 3);%specular of peak with y=ymin
ksMax = zeros(3, 3);%specular of peak with y=ymax
kaMin = zeros(3, 3);%ambient of peak with y=ymin
kaMax = zeros(3, 3);%ambient of peak with y=ymax
V = p;
Normals = Vn;
kd = kd';
ks = ks';
ka = ka';

%Compare all elements with each other and find ykmin etc
for i = 1:3
    for j = i + 1:3
        [ykmin(i + j - 2), I1] = min([V(i, 2), V(j, 2)]); 
        [ykmax(i + j - 2), I2] = max([V(i, 2), V(j, 2)]); 
        %check if the first or the second value has the max/min y and 
        %assign I1 to the respective element
        if (I1 == 1) 
            I1 = i; 
        else
            I1 = j;
        end
        if (I2 == 1)
            I2 = i;
        else
            I2 = j;
        end
        %if the edge is horizontal
        if (ykmin(i + j - 2) == ykmax(i + j - 2))
            [xkmin(i + j - 2), indexMin] = min([V(i, 1) V(j, 1)]); 
            xkmax(i + j - 2) = max([V(i, 1), V(j, 1)]); 
            if indexMin == 1
                normalMin(i + j - 2, :) = Normals(:, i);               
                normalMax(i + j - 2, :) = Normals(:, j);
                kaMin(i + j - 2, :) = ka(i, :);
                kaMax(i + j - 2, :) = ka(j, :);
                kdMin(i + j - 2, :) = kd(i, :);
                kdMax(i + j - 2, :) = kd(j, :);
                ksMin(i + j - 2, :) = ks(i, :);
                ksMax(i + j - 2, :) = ks(j, :);
            else
                normalMin(i + j - 2, :) = Normals(:, j);
                normalMax(i + j - 2, :) = Normals(:, i);
                kaMin(i + j - 2, :) = ka(j, :);
                kaMax(i + j - 2, :) = ka(i, :);
                kdMin(i + j - 2, :) = kd(j, :);
                kdMax(i + j - 2, :) = kd(i, :);
                ksMin(i + j - 2, :) = ks(j, :);
                ksMax(i + j - 2, :) = ks(i, :);
            end
        else
            xkmin(i + j - 2) = V(I1, 1); 
            xkmax(i + j - 2) = V(I2, 1);
            normalMin(i + j - 2, :) = Normals(:,I1);
            normalMax(i + j - 2, :) = Normals(:,I2);
            kaMin(i + j - 2, :) = ka(I1, :);
            kaMax(i + j - 2, :) = ka(I2, :);
            kdMin(i + j - 2, :) = kd(I1, :);
            kdMax(i + j - 2, :) = kd(I2, :);
            ksMin(i + j - 2, :) = ks(I1, :);
            ksMax(i + j - 2, :) = ks(I2, :);
        end
    end
end

ymin = min(ykmin);%smallest y of triangle
ymax = max(ykmax);%largest y of triangle
%activeEdges is 2by4 array that contains the values of edge k
%[ykmin ykmax xkmin xkmax]
activeEdges = [ykmin(ykmin == ymin) ykmax(ykmin == ymin) xkmin(ykmin == ymin) xkmax(ykmin == ymin)];
%activePoints is a 1by2 array that contains the x value of the lowest peak
%at start and the active points of the active edges later
activePoints = [min(xkmin(ykmin == ymin)) min(xkmin(ykmin == ymin))];
%Cab is an 1b2 array that contains the interpolated color of each
%activePoint. At the start it contains the color of the lowest peak
Cnormals = normalMin(ykmin == ymin, :);
Cka = kaMin(ykmin == ymin, :);
Ckd = kdMin(ykmin == ymin, :);
Cks = ksMin(ykmin == ymin, :);
%y is the scanline from the lowest to highest peak
for y = ymin:ymax
    %if y is at the highest point and there is a horizontal line there then
    %fill the last line depending only on x values
    if y == ymax && any(ykmin == y)
        %find color of active point with interpolation
        Cnormals(1, :) = colorInterp(normalMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), normalMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y);
        Cnormals(2, :) = colorInterp(normalMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), normalMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y);
        Cka(1, :) = colorInterp(kaMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), kaMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y);
        Cka(2, :) = colorInterp(kaMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), kaMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y);
        Ckd(1, :) = colorInterp(kdMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), kdMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y);
        Ckd(2, :) = colorInterp(kdMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), kdMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y);
        Cks(1, :) = colorInterp(ksMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), ksMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y);
        Cks(2, :) = colorInterp(ksMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), ksMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y);
        %fill the area between the active points with interpolation
        for i = linspace(round(activePoints(1, 1)), round(activePoints(1, 2)), abs(round(activePoints(1, 1)) - round(activePoints(1, 2))) + 1)
            normalsIn = colorInterp(Cnormals(1, :), Cnormals(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
            kaIn = colorInterp(Cka(1, :), Cka(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
            kdIn = colorInterp(Ckd(1, :), Ckd(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
            ksIn = colorInterp(Cks(1, :), Cks(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
            X(y, i, :) = ambientLight(kaIn',Ia)+diffuseLight(Pc,normalsIn,kdIn',S,I0)+specularLight(Pc,normalsIn,C,ksIn',ncoeff,S,I0);
        end
        break
    end
    %if y is just at the highest point paint the last pixel with the peak's
    %color
    if y == ymax
        nmax = normalMax(find(ykmax == y & xkmax == max(xkmax(ykmax == y)), 1), :);
        kaInmax = kaMax(find(ykmax == y & xkmax == max(xkmax(ykmax == y)), 1), :);
        kdInmax = kdMax(find(ykmax == y & xkmax == max(xkmax(ykmax == y)), 1), :);
        ksInmax = ksMax(find(ykmax == y & xkmax == max(xkmax(ykmax == y)), 1), :);
        X(y, max(xkmax(ykmax == y)), :) = ambientLight(kaInmax',Ia)+diffuseLight(Pc,nmax,kdInmax',S,I0)+specularLight(Pc,nmax,C,ksInmax',ncoeff,S,I0);
        break
    end
    %if at the start there is a horizontal line get rid of it and then set
    %as active points the xmin of the one edge that touches the horizontal
    %line and xmin of the other edge that touches the horizontal line
    if (length(activeEdges(:, 1)) == 3)
        activeEdges(activeEdges(:, 1) == activeEdges(:, 2), :) = [];
        activePoints = [activeEdges(1, 3) activeEdges(2, 3)];
    end
    %find color of active point with interpolation
    
    Cnormals(1, :) = colorInterp(normalMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), normalMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y);
    Cnormals(2, :) = colorInterp(normalMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), normalMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y);
   
    Cka(1, :) = colorInterp(kaMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), kaMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y)';
    Cka(2, :) = colorInterp(kaMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), kaMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y)';
    Ckd(1, :) = colorInterp(kdMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), kdMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y)';
    Ckd(2, :) = colorInterp(kdMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), kdMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y)';
    Cks(1, :) = colorInterp(ksMin(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), ksMax(find(ykmin == activeEdges(1, 1) & ykmax == activeEdges(1, 2), 1, 'first'), :), activeEdges(1, 1), activeEdges(1, 2), y)';
    Cks(2, :) = colorInterp(ksMin(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), ksMax(find(ykmin == activeEdges(2, 1) & ykmax == activeEdges(2, 2), 1, 'last'), :), activeEdges(2, 1), activeEdges(2, 2), y)';
    %fill the area between the active points with interpolation
    for i = linspace(round(activePoints(1, 1)), round(activePoints(1, 2)), abs(round(activePoints(1, 1)) - round(activePoints(1, 2))) + 1)
        normalsIn = colorInterp(Cnormals(1, :), Cnormals(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
        
        kaIn = colorInterp(Cka(1, :), Cka(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);        
        kdIn = colorInterp(Ckd(1, :), Ckd(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
        ksIn = colorInterp(Cks(1, :), Cks(2, :), round(activePoints(1, 1)), round(activePoints(1, 2)), i);
        X(y, i, :) = ambientLight(kaIn',Ia)+diffuseLight(Pc,normalsIn,kdIn',S,I0)+specularLight(Pc,normalsIn,C,ksIn',ncoeff,S,I0);
    end
    %if we reach the y=ykmax of an edge we get rid of that edge and replace
    %it with the edge that has y=ykmin
    if (any(activeEdges(:, 2) == y))
        activeEdges(activeEdges(:, 2) == y, :) = [ykmin(ykmin == y) ykmax(ykmin == y) xkmin(ykmin == y) xkmax(ykmin == y)];
    end
    %a is a 1b2 matrix that contains the slope of the active edges(Called
    %mk in the notes)
    a = (activeEdges(:, 2) - activeEdges(:, 1)) ./ (activeEdges(:, 4) - activeEdges(:, 3));
    %active points are set from previous active points adding 1/a(1/mk) as
    %step
    activePoints(1, 1) = activePoints(1, 1) + 1 / a(1);
    activePoints(1, 2) = activePoints(1, 2) + 1 / a(2);
end
%set return value
Y = X;
end

