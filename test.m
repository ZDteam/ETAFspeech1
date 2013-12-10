function test( test_set,test_people, test_num , feature_mat, thresholds,test_ans )
%TEST Summary of this function goes here
%   Detailed explanation goes here


[door_num,people_num,train_num,feature_num] = size(feature_mat);

train_people = door_num*people_num;
fprintf('testing......\n');
false_reject = 0;
false_accept = 0;
total_accept = 0;
total_reject = 0;
p1c0 = 0;
p0 = 0;
parfor p=1:test_people
    for t=1:test_num
        waveFile = [test_set,'/',num2str(p),'/',num2str(t),'.wav'];
        [y,fs,nbits] = wavread(waveFile);
        %         fprintf('%d %d\n',fs,nbits);
        [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
        [v1,v2,mfcc_feature] =  feature_extract(x,fs,zcr,shortEnergy);
        best_dist = inf;
        ansi=0;
        ansj=0;
        ansk=0;
        
        for i =1:door_num
            for j = 1:people_num
                for k = 1:train_num                    
                    dist = dtw(feature_mat{i,j,k,3},mfcc_feature);

                    if(best_dist>dist)
                        best_dist = dist;
                        ansi=i;
                        ansj=j;
                        ansk=k;
                    end
                end
            end
        end
        
        %reject or accept
        if(best_dist > thresholds(ansi,ansj,3))
            if( p<=train_people &&  t == 1 && ansi == test_ans(p,t,1) && ansj == test_ans(p,t,2) )
                false_reject  = false_reject + 1;
            end
            total_reject = total_reject + 1;
%             fprintf('%dth people %dth voice was rejected. threshold=%f ,dist=%f\n',p,t,thresholds(ansi,ansj,3),best_dist);
        else
            if( confirm(v1,v2,ansi,ansj,ansk,feature_mat,thresholds));
                if(t~=1 || p>train_people || ansi ~= test_ans(p,t,1) || ansj ~= test_ans(p,t,2))
                    if(t~=1 && p<25 && ansi == test_ans(p,1,1) && ansj == test_ans(p,1,2))
                        p1c0 = p1c0+1;
                        fprintf('people right content wrong: %dth test people %dth voice misrecognized as %dth door %dth people %dth voice\n',p,t,ansi,ansj,ansk);
                    elseif(ansi ~=test_ans(p,t,1) || ansj ~= test_ans(p,t,2))
                        fprintf('people wrong: %dth test people %dth voice misrecognized as %dth door %dth people %dth voice\n',p,t,ansi,ansj,ansk);
                        p0 = p0+1;
                    end
                    
                    false_accept = false_accept + 1;
                end
                total_accept = total_accept + 1;
%                 fprintf('%dth people %dth voice was accepted.\n',p,t);
                
            else
                %    finally reject
                if( p<25 &&  t == 1 && ansi == test_ans(p,t,1) && ansj == test_ans(p,t,2) )
                    false_reject  = false_reject + 1;
                end
                total_reject = total_reject + 1;
%                  fprintf('%dth people %dth voice was rejected. confirm failed\n',p,t);
            end
        end
%         fprintf('%dth people %dth voice recognized as the: %d door ,%dth people %dth voice\n',p,t,ansi,ansj,ansk);
    end
end


fprintf('========================test result========================\n');
now_time = [num2str(hour(now)),':',num2str(minute(now)),' ',num2str(year(now)),'-',num2str(month(now)),'-',num2str(day(now))];
fprintf(['test_report at ',now_time,'\n']);
fprintf('train set:\n');
fprintf('door number:%d, people in each door:%d, voice of each people:%d \n',door_num,people_num,train_num);
fprintf('test set:\n');
fprintf('total test voice num:%d,test people: %d,each people test %d voice\n',test_people*test_num,test_people,test_num);
fprintf('---------------------\n');
fprintf('false accept rate:%.2f%%\n',false_accept/(test_people*test_num)*100);
fprintf('false reject rate:%.2f%%\n',false_reject/(test_people*test_num)*100);
fprintf('---------------------\n');
fprintf('false accepted:%d, right accepted:%d, total accepted:%d\n',false_accept,total_accept-false_accept,total_accept);
fprintf('false rejected:%d, right rejected:%d, total rejected:%d\n',false_reject,total_reject-false_reject,total_reject);
fprintf('---------------------\n');
fprintf('In false accept :\n');
fprintf('people right && content wrong ,but accepted:%d\n',p1c0);
fprintf('people worng ,but accepted:%d\n',p0);
fprintf('========================test end ===========================\n');

fp = fopen('test_report.txt','a+');
fprintf(fp,'========================test result========================\n');
fprintf(fp,['test_report at ',now_time,'\n']);
fprintf(fp,'train set:\n');
fprintf(fp,'door number:%d, people in each door:%d, voice of each people:%d \n',door_num,people_num,train_num);
fprintf(fp,'test set:\n');
fprintf(fp,'total test voice num:%d,test people: %d,each people test %d voice\n',test_people*test_num,test_people,test_num);
fprintf(fp,'---------------------\n');
fprintf(fp,'false accept rate:%.2f%%\n',false_accept/(test_people*test_num)*100);
fprintf(fp,'false reject rate:%.2f%%\n',false_reject/(test_people*test_num)*100);
fprintf(fp,'---------------------\n');
fprintf(fp,'false accepted:%d, right accepted:%d, total accepted:%d\n',false_accept,total_accept-false_accept,total_accept);
fprintf(fp,'false rejected:%d, right rejected:%d, total rejected:%d\n',false_reject,total_reject-false_reject,total_reject);
fprintf(fp,'---------------------\n');
fprintf(fp,'In false accept :\n');
fprintf(fp,'people right && content wrong ,but accepted:%d\n',p1c0);
fprintf(fp,'people worng ,but accepted:%d\n',p0);
fprintf(fp,'========================test end ===========================\n');

fclose(fp);
