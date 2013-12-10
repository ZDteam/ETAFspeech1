function main()
%MAIN Summary of this function goes here

close all;
% clc;
open_multiple_thread();
clear all;
door_num = 8;
people_num = 3;
train_num = 3; 
test_people = 38;
test_num = 3;
train_set = 'trainv2';
test_set = 'testv2';
test_ans_mat = 'test_ans2.mat';

% door_num = 6;
% people_num = 3;
% train_num = 3; 
% test_people = 7;
% test_num = 2;
% train_set = 'trainv1';
% test_set = 'testv1';
% test_ans_mat = 'test_ans1.mat';


load(test_ans_mat,'test_ans');

[feature_mat, thresholds] = train(train_set,door_num,people_num,train_num);
tic
test(test_set,test_people,test_num,feature_mat,thresholds,test_ans);
toc
end

