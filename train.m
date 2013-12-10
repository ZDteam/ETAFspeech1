function  [feature_mat,thresholds] = train(train_set,door_num,people_num,train_num)

fprintf('======================== training ========================\n');
feature_mat = cell(door_num,people_num,train_num,3);
thresholds = zeros(door_num,people_num,3);
vs = cell(train_num,3);

for i =1:door_num
    for j = 1:people_num
        for k = 1:train_num
            waveFile = [train_set,'/',num2str(i),'/',...
                num2str(j),'/',...
                num2str(k),'.wav'];
            [y,fs,nbits] = wavread(waveFile);
            %             fprintf('%d %d\n',fs,nbits);
            [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
            [feature_mat{i,j,k,1},feature_mat{i,j,k,2},feature_mat{i,j,k,3}]= feature_extract(x,fs,zcr,shortEnergy);
        end
        for k = 1:train_num
            for tt = 1:3
                vs{k,tt} = feature_mat{i,j,k,tt};
            end
        end
        thresholds(i,j,:) = get_threshold(vs);
    end
end
fprintf('======================== trained successfully ============\n');
end

