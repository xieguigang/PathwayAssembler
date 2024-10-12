setwd(@dir);

let metabolite_groups = read.csv("./molecular_tree/nodes.csv", row.names = 1, check.names = FALSE);

metabolite_groups[,"NodeType"] = `Pathway_${metabolite_groups$NodeType}`;

print(metabolite_groups);

let pathways = metabolite_groups |> groupBy("NodeType") |> lapply(function(block) {
    block$label;
});

str(pathways);

let docs = lapply(names(pathways), function(name) {
    append(name, pathways[[name]]) |> append(["" ""]);
}) |> unlist();

writeLines(docs, con = "./pathways.txt");
