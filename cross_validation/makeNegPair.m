function negPair=makeNegPair(max_num,is_shuffle, ori_path, pair_path)
%to build negtive pair by randomly choose the images in ori_txt and
%       pair_txt.The particular ratio of some specal class to some other
%       class is determined by the number of them in ori_txt and pair_txt.
%input:
%  ori_txt         --the gallery file that contains image name and its label
%  pair_txt        --the probe file that contains image name and its label
%  max_num         --the max number of the final negitive pair;
%  is_shuflle      --randomly permute the negitive pair
%  output_txt      --if this parameter exists, this function writes negtive
%                    pair to txt.
%
%output:
%  posPair         --it has field ori_name,pair_name,label
%Jun Hu
%2017-3

%modified by Han Liu
%2017-9
fid = fopen(ori_path,'r');
fid2 = fopen(pair_path,'r');
color = textscan(fid,'%s %d');
depth = textscan(fid2, '%s %d');
ori_name = color{1}(:,1);
ori_label = color{2}(:,1);
pair_name = depth{1}(:,1);
pair_label = depth{2}(:,1);


total_neg_pair=length(ori_name);
neg_pair_count=1;
for j = 1:2
    for i_o=1:length(ori_label)
        %tic      
        while(1)
            i_p=int32(rand()*total_neg_pair);
            if ori_label(i_o)~=pair_label(i_p)
                break;
            end
        end
        negPair(neg_pair_count).ori_name=ori_name{i_o};
        negPair(neg_pair_count).pair_name=pair_name{i_p};
        negPair(neg_pair_count).ori_label=ori_label(i_o);
        negPair(neg_pair_count).pair_label=pair_label(i_p);
        negPair(neg_pair_count).label=0;
        if neg_pair_count>= max_num
            break; % we can acclerate by set a stop flag
        end
        neg_pair_count=neg_pair_count+1
    end
    %toc
    
end

if is_shuffle
    r=randperm(length(negPair));
    negPair=negPair(r);
end

end