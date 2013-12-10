function [v] = get_det(m)
len = size(m,1);
v = zeros(len,size(m,2));

for i=3:len-2
    v(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
v = v/3;

% v = v(3:len-2,:);