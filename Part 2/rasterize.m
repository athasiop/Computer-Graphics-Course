function Prast = rasterize(P,M,N,H,W)
Prast(1,:) = (P(1,:)+W/2)./W;
Prast(2,:) = (P(2,:)+H/2)./H;
Prast(1,:) = floor((Prast(1,:)).*N);%changing it to 1-Prast(1,:) will make the duck look right
Prast(2,:) = floor((1-Prast(2,:)).*M);
end

