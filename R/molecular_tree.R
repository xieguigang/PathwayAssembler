require(umap);
require(igraph.builder);
require(igraph);

imports "visualizer" from "igraph";

#' Make metabolite clustering via UMAP algorithm
#' 
#' @param refmet the sgt vector embedding result of the reference metabolites, which is 
#'    parsed via the ``molecular_vector`` and ``embedding_vec`` function.
#'  
const molecular_tree = function(refmet, dims = 9) {
    let [umap, labels] = umap(refmet, dimension = dims,numberOfNeighbors = 64,
            spectral_cos= TRUE);
    let embedding = as.data.frame(umap, labels = labels);
    let g = umap::as.graph(umap,
                           labels = labels,
                           threshold = 0.1,
                        make_abstract = FALSE);

    g <- setColors(g, color = "dotnet.colors");

    list(embedding, graph = g);
}
