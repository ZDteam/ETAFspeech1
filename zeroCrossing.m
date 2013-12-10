function [ zcr ] = zeroCrossing( data, frameLen, frameInc )
%	write by Antmon Liu 2011-11-27
%   [function]:   计算过零率
%   [parameters]
%   energyData：    短时能量序列
%   frameLen:   帧长
%   frameInc：  帧移
%   axis([1 length(data) 0 max(data)]); %设置坐标轴
tmp1  = enframe(data(1:end-1), frameLen, frameInc);
tmp2  = enframe(data(2:end)  , frameLen, frameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr = sum(signs.*diffs, 2);
end

