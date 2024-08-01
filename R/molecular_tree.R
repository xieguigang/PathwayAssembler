require(umap);

#' Make metabolite clustering based on their structures similarity
#' 
#' @param refmet the vector embedding result of the reference metabolites, which is 
#'    parsed via the ``molecular_vector`` function.
#'  
const molecular_tree = function(refmet, workdir = "./") {
    let [labels, umap] = umap(refmet, dimension = 10);
    refmet = as.data.frame(umap, labels = labels);

    # view of the vector embedding result
    print(refmet);
    write.csv(refmet, file = file.path(workdir, "umap_embedding.csv"));

    # make clusters
    
}