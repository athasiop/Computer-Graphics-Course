function I = diffuseLight(P,N,kd,S,I0)
I = zeros(3,1);
for i=1:length(S(:,1))
L = P'-S(i,:);
L = L/norm(L);
X = [P';S(i,:)];
d = pdist(X,'euclidean');
fatt = 1/(d^2);
I = I0.*kd*fatt*max(dot(N,L),0)+I;%I=0 when dot(N,L) return less than 0
end
end

