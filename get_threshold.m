function threshold = get_threshold(vs)
n = size(vs,1);
% maxn = -1;
% minn =  inf;
dist = zeros(3,1);
maxn = zeros(3,1);
minn = zeros(3,1);
minn(:) = inf;
for i =1:n
    for j=i+1:n
        for k = 1:3
            dist(k) = dtw(vs{i,k},vs{j,k});
            maxn(k) = max(dist(k),maxn(k));
        end
    end
    %       threshold = minn*1.5*minn/maxn;
    threshold = maxn;

    %         threshold = (minn+maxn)/2;
end