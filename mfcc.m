function ccc = mfcc(x,fs)

[nf,frameSize] = size(x);

% ???mel??????
filter_num = 24; %???????
coef_num = 16; %??
bank=melbankm(filter_num,frameSize,fs,0,0.5,'tz');
% bank=full(bank);
% bank=bank/max(bank(:));

% DCT??,coef_num*filter_num;
for k=1:coef_num
  n=1:filter_num;
  dctcoef(k,:)=cos((n-0.5)*k*pi/(filter_num));
end

% ?????????
w = 1 + 6 * sin(pi * [1:coef_num] ./ coef_num);
w = w/max(w);

% % ??????
% xx=double(x);
% xx=filter([1 -0.9375],1,xx);

% % ??????
% [x1,x2]= vad(xx);
% xx=enframe(xx,256,80);

% ?????MFCC??

for i=1:nf
  y = x(i,:);

  s = y' .* hamming(frameSize);
  t = abs(fft(s));
  t = t.^2;
  c1=dctcoef * log(bank * t(1:1+floor(frameSize/2)));
  c2 = c1.*w';
  m(i,:)=c2';
end

%% ????
dtm = zeros(size(m));
for i=3:size(m,1)-2
  dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
dtm = dtm / 3;

%% ???????
% dtm2 = zeros(size(dtm));
% for i=3:size(dtm,1)-2
%   dtm2(i,:) = -2*dtm(i-2,:) - dtm(i-1,:) + dtm(i+1,:) + 2*dtm(i+2,:);
% end
% dtm2 = dtm2 / 3;

%% ??mfcc???????mfcc??
ccc = [m dtm];
%????????????????????0
% ccc = ccc(3:size(m,1)-2,:);

