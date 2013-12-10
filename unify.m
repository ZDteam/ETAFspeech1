function [ t ] = unify( s,range_start,range_end )
%UNIFY Summary of this function goes here
%   Detailed explanation goes here
maxn = max(s);
minn = min(s);
if(maxn == minn)
    t=s;
    return;
end


t =  range_start+(s - minn)*(range_end-range_start)/(maxn-minn);


end

