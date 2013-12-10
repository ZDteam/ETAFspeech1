%% generate test_ans2.mat

% test_ans = zeros(100,3,2);
% for i = 1:24
%     test_ans(i,1,1)=floor((i-1)/3)+1;
%     test_ans(i,1,2)=mod(i-1,3)+1;
%     test_ans(i,2,1)=-1;
%     test_ans(i,2,2)=-1;
%     test_ans(i,3,1)=-1;
%     test_ans(i,3,2)=-1;
% end
% 
% 
% for i=25:100
%     for j=1:3
%         test_ans(i,j,1)=-1;
%         test_ans(i,j,2)=-1;
%     end
% end
% % 
% % for i=1:38
% %     for j=1:3
% %         fprintf('%dth people %dth voice should be : door %d people %d\n',i,j,test_ans(i,j,1),test_ans(i,j,2));
% %     end
% % end
% % 
% % 
% save('test_ans2.mat','test_ans');

%% generate test_ans1.mat
test_ans = zeros(100,3,2);

test_ans(1,1,1) = 2;
test_ans(1,1,2) = 3;
test_ans(2,1,1) = 3;
test_ans(2,1,2) = 2;
test_ans(3,1,1) = 4;
test_ans(3,1,2) = 3;
test_ans(4,1,1) = 3;
test_ans(4,1,2) = 3;
test_ans(5,1,1) = 1;
test_ans(5,1,2) = 2;
test_ans(6,1,1) = 1;
test_ans(6,1,2) = 3;
test_ans(7,1,1) = 3;
test_ans(7,1,2) = 1;
for i=1:7
    test_ans(i,2,1) = -1;
    test_ans(i,2,2) = -1;
end
 save('test_ans1.mat','test_ans');