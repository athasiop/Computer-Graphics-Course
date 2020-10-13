function dp = systemTransform(cp,b1,b2,b3,c0)
dp = zeros(3,length(cp(:,1)));
for i=1:length(cp(:,1))
    dp(:,i) = (inv([b1 b2 b3]))*(cp(i,:)-c0')';
end
end

