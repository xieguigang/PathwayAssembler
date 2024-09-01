require(umap);
require(igraph.builder);
require(igraph);

#' Make metabolite clustering based on their structures similarity
#' 
#' @param refmet the vector embedding result of the reference metabolites, which is 
#'    parsed via the ``molecular_vector`` function.
#'  
const molecular_tree = function(refmet, workdir = "./") {
    refmet = Builder::small_network(refmet);
    refmet = similarity_graph(refmet, cutoff = 0.0);

    save.network(refmet, file = file.path(workdir, "molecular_tree"));
}

const align_score = function(a, b) {
    append(names(a), names(b)) 
    |> unique() 
    |> sapply(i => {
        let ai = ifelse(i in a, a[[i]], 0);
        let bi = ifelse(i in b, b[[i]], 0);

        min(ai,bi)/max(ai,bi);
    })
    |> mean()
    ;
}