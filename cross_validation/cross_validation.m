function cross_validation(max_num,is_shuffle,data,ori_path,pair_path,ori_labelpath,pair_labelpath)
%2017-9-7
%Han Liu
%cross validation for 10 times
posPair=makePosPair(max_num,is_shuffle,data,76150,103626);
negPair=makeNegPair(max_num,is_shuffle,data,76150,103626);
Pair=[posPair negPair];
r=randperm(length(Pair));
Pair=Pair(r);
fid=fopen(ori_path,'wt');
fid2=fopen(pair_path,'wt');
fid3=fopen(ori_labelpath,'wt');
fid4=fopen(pair_labelpath,'wt');
for i=1:length(Pair)
    fprintf(fid,'%s %d\n',Pair(i).ori_name,Pair(i).label);
    fprintf(fid2,'%s %d\n',Pair(i).pair_name,Pair(i).label);
    fprintf(fid3,'%s %d\n',Pair(i).ori_name,Pair(i).ori_label);
    fprintf(fid4,'%s %d\n',Pair(i).pair_name,Pair(i).pair_label);
end
fclose(fid);
fclose(fid2);
fclose(fid3);
fclose(fid4);
