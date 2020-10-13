function cq = affineTransform(cp,R,ct)
cq = cp+ct';%translate
cq = (R*cq(:,1:3)')';%rotate
end

