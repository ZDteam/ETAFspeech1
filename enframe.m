function out = enframe(y, frameSize, overlap)
% enframe: Perform frame blocking on given signals
%
%	Usage:
%		out = enframe(y, frameSize, overlap)
%
%	Description:
%		out=enframe(y, frameSize, overlap) splits given signals into frames, with each row being a frame.
%
%	Example:
%		waveFile='what_movies_have_you_seen_recently.wav';
%		[y, fs]=wavread(waveFile);
%		frameSize=256;
%		overlap=128;
%		frameMat=enframe(y, frameSize, overlap);
%		mesh(frameMat);


if nargin<1, selfdemo; return; end
if nargin<3, overlap=0; end
if nargin<2, frameSize=256; end

step = frameSize-overlap;
frameCount = floor((length(y)-overlap)/step);

out = zeros( frameCount,frameSize);
for i=1:frameCount,
	startIndex = (i-1)*step+1;
	out(i, :) = y(startIndex:(startIndex+frameSize-1));
end

% ====== Self demo
function selfdemo
mObj=mFileParse(which(mfilename));
strEval(mObj.example);
