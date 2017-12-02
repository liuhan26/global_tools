function makePosNeg(max_num,shuffle,ori_path,pair_path, write_ori, write_pair)
posPair = makePosPair(max_num,shuffle,ori_path,pair_path);
negPair = makeNegPair(max_num,shuffle,ori_path,pair_path);
pair = [posPair negPair];
r = randperm(length(pair));
pair = pair(r);

fn =fopen(write_ori,'w');
fn2 = fopen(write_pair,'w');

for i = 1: length(pair)
   fprintf(fn, '%s %d\n',pair(i).ori_name,pair(i).label);
   fprintf(fn2, '%s %d\n',pair(i).pair_name,pair(i).label);
   
end

fclose(fn);
fclose(fn2);