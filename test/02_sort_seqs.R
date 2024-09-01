require(PathwayAssembler);
require(JSON);

setwd(@dir);

let struct_data = read.csv("./atoms_vec.csv", row.names = 1, check.names = FALSE);

print(struct_data);

let sorts = Builder::sort_groups(struct_data);

JSON::json_encode(sorts)
|> writeLines(con = "./sorts.json")
;