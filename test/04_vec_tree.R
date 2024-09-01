require(PathwayAssembler);
require(igraph);

setwd(@dir);

let vec = read.csv("./sgt_embedding.csv", row.names = 1, 
    check.names = FALSE);
let [embedding, graph] = molecular_tree(refmet = vec);

write.csv(embedding, file = "./umap_embedding.csv");

igraph::save.network(graph, file = "./molecular_tree", _3d = TRUE);