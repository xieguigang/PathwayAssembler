require(umap);

#' Make metabolite clustering based on their structures similarity
#' 
#' @param refmet the vector embedding result of the reference metabolites, which is 
#'    parsed via the ``molecular_vector`` function.
#'  
const molecular_tree = function(refmet, workdir = "./") {


    # make clusters
    
}

const embedding_vec = function(refmet, workdir = "./") {
    let [labels, umap] = umap(refmet, dimension = 10);
    refmet = as.data.frame(umap, labels = labels);

    # view of the vector embedding result
    print(refmet);
    write.csv(refmet, file = file.path(workdir, "umap_embedding.csv"));
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