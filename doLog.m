function [] = doLog( fp,str )
%DOLOG Summary of this function goes here
%   Detailed explanation goes here

now_time = [num2str(hour(now)),':',num2str(minute(now)),' ',num2str(year(now)),'-',num2str(month(now)),'-',num2str(day(now))];

fprintf(fp,'%s:\t%s\r\n',now_time,str);
end

