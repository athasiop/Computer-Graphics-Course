function Y = triPaintFlat(X, V, C)
%Sioppidis Athanasios 9090

%k=edge
ykmin = zeros(3, 1);%min y of the edge
ykmax = zeros(3, 1);%max y of the edge
xkmin = zeros(3, 1);%x of peak with y=ykmin
xkmax = zeros(3, 1);%x of peak with y=ykmax
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
            xkmin(i + j - 2) = min(V(i, 1), V(j, 1)); 
            xkmax(i + j - 2) = max(V(i, 1), V(j, 1)); 
        else
            xkmin(i + j - 2) = V(I1, 1); 
            xkmax(i + j - 2) = V(I2, 1); 
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
%y is the scanline from the lowest to highest peak
for y = ymin:ymax
    %if y is at the highest point and there is a horizontal line there then
    %fill the last line depending only on x values
    if y == ymax && any(ykmin == y)
        for i = max(xkmin(ykmin == y)):max(xkmax(ykmin == y))
            X(y, i, :) = sum(C) / 3;
        end
        break
    end
    %if y is just at the highest point paint the last pixel
    if y == ymax
        X(y, max(xkmax(ykmax == y)), :) = sum(C) / 3;
        break
    end
    %if at the start there is a horizontal line get rid of it and then set
    %as active points the xmin of the one edge that touches the horizontal
    %line and xmin of the other edge that touches the horizontal line
    if (length(activeEdges(:, 1)) == 3)
        activeEdges(activeEdges(:, 1) == activeEdges(:, 2), :) = [];
        activePoints = [activeEdges(1, 3) activeEdges(2, 3)];
    end
    %scan between active points and draw pixels
    for i = round(min(activePoints)):round(max(activePoints))
        X(y, i, :) = sum(C) / 3;
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

