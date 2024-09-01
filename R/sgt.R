imports "dataset" from "MLkit";

#' make sgt embedding of the molecule strcutre data
#' 
#' @param sort_seqs the sorted graph sequence data
#' 
#' @return a dataframe data that contains the sgt embedding result. each row names is 
#'   the identifier of the metabolite, example as the metabolite name or metabolite 
#'   reference id, the row values is the sgt embedding vector.
#' 
const embedding_vec = function(sort_seqs,kappa = 3) {
    let sgt = SGT(alphabets = estimate_alphabets(unlist(sort_seqs)),
        kappa = kappa,
        length_sensitive = TRUE);
    let embedding = lapply(tqdm(sort_seqs), s -> sgt |> fit_embedding(s));

    # returns the sgt embedding dataframe
    bind_rows(embedding);
}