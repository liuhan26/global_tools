function posPair=makePosPair(max_num,is_shuffle, data, preIndex, posIndex)
%to build negtive pair by randomly choose the images in ori_txt and
%       pair_txt.The particular ratio of some specal class to some other
%       class is determined by the number of them in ori_txt and pair_txt.
%input:
%  max_num         --the max number of the final positive pair;
%  is_shuflle      --randomly permute the positive pair
%
%output:
%  posPair         --it has field ori_
%Jun Hu
%2017-3
%modified by Han Liu
%2017-9

% pre=evalin('base','pre');
% ori_name=pre(1:22476,1);
% ori_label=pre(1:22476,2);
%
% pair_name=pre(1:22476,1);
% pair_label=pre(1:22476,2);

ori_name=cat(1,data(1:preIndex,1),data(posIndex:end,1));
ori_label=cat(1,data(1:preIndex,2),data(posIndex:end,2));

pair_name=cat(1,data(1:preIndex,1),data(posIndex:end,1));
pair_label=cat(1,data(1:preIndex,2),data(posIndex:end,2));


ori_label_num = cell2mat(ori_label);
pair_label_num = cell2mat(pair_label);
[u_ori_label,ia,ic] = unique(ori_label_num);
[u_pair_label, ia_p,ic_p] = unique(pair_label_num);
total_pos_pair=0;
for i_o = 1:length(ia)-1
    total_pos_pair = total_pos_pair + (ia(i_o + 1)-ia(i_o))^2;
end

rand_thre=single(max_num)/total_pos_pair;
pos_pair_count=1;
tic
for i_o=1:length(ori_label)
    i_o
    %     tic
    label = ori_label{i_o};
    all_pair_idx = find (pair_label_num == label);
    
    for i_a = 1:length(all_pair_idx)
        i_p = all_pair_idx(i_a);
        if ori_label{i_o,1}==pair_label{i_p,1}
            if rand()<rand_thre
                posPair(pos_pair_count).ori_name=ori_name{i_o};
                posPair(pos_pair_count).pair_name=pair_name{i_p};
                posPair(pos_pair_count).ori_label=ori_label{i_o};
                posPair(pos_pair_count).pair_label=pair_label{i_p};
                posPair(pos_pair_count).label=1;
                if pos_pair_count>= max_num
                    break; % we can acclerate by set a stop flag
                end
                pos_pair_count=pos_pair_count+1;
            end
        end
    end
    %     toc
end
toc
if is_shuffle
    r=randperm(length(posPair));
    posPair=posPair(r);
end
end