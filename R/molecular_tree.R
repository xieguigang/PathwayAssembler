require(umap);
require(igraph.builder);
require(igraph);

#' Make metabolite clustering via UMAP algorithm
#' 
#' @param refmet the sgt vector embedding result of the reference metabolites, which is 
#'    parsed via the ``molecular_vector`` and ``embedding_vec`` function.
#'  
const molecular_tree = function(refmet) {
    let [umap, labels] = umap(refmet, dimension = 3);
    let embedding = as.data.frame(umap, labels = labels);
    let g = umap::as.graph(umap,
                           labels = labels,
                           threshold = 0,
                        make_abstract = FALSE);

    list(embedding, graph = g);
}
