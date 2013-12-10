function [v1,v2,v3] = feature_extract(x,fs,zcr,shortEnergy)
v1 = get_det(zcr);
v2 = get_det(shortEnergy);
% v2 = get_det(shortEnergy);
v3 = mfcc(x,fs);

% v3 = [v3 unify(v1,min(min(v3)),max(max(v3))) unify(v2,min(min(v3)),max(max(v3)))];

end