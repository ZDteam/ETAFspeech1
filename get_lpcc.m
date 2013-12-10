function ccc = get_lpcc(x)
nf = size(x,1);
for i = 1:nf
    ccc(i,:) = lpcc(x(i,:));
end

end 