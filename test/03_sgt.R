require(PathwayAssembler);
require(JSON);

setwd(@dir);

let sort_seq = "./sorts.json" |> readText()
|> JSON::json_decode()
;

str(sort_seq);

let sgt = embedding_vec(sort_seq);

print(sgt);

write.csv(sgt, file = "./sgt_embedding.csv");