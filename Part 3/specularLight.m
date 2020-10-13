function I = specularLight(P,N,C,ks,ncoeff,S,I0)

I = zeros(3,1);
V = P-C;
V = V/norm(V);
for i=1:length(S(:,1))
L = P'-S(i,:);
L = L/norm(L);
R = 2*N*(dot(L,N))-L;
R = R/norm(R);
I = I0.*ks*max(((dot(R,V))^ncoeff),0)+I;%I=0 when dot(R,V) return less than 0
end
end

