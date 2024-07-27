imports "SMILES" from "mzkit";

#' Parse the structure of molecular and then convert to atom link vector
#' 
#' @param refmet a dataframe object of the reference metabolite, should 
#'     contains the ``refmet_name`` of the metabolite as identifier and 
#'     the ``smiles`` structure data for do molecular vector embedding.
#' 
#' @return a hds package that contains tuple list of the atom link vector 
#'     data of each reference metabolite which have the smiles structure data.
#' 
const molecular_vector = function(refmet, workdir = "./") {
    let hds_pack = file.path(workdir, "molecular_vector.hds");

    # filter the reference metabolite which has smiles strucutre data.
    refmet = refmet[nchar(refmet$smiles) > 0,];
    # assign the tqdm progress label
    rownames(refmet) <- make.names(refmet$refmet_name, 
        unique = TRUE, allow_ = TRUE);
    
    for(let meta in tqdm(as.list(refmet, byrow = TRUE))) {
        let met_struct = SMILES::parse(meta$smiles, strict = FALSE);
        let atoms_vec = SMILES::atoms(met_struct);

        atoms_vec = atoms_vec 
        |> groupBy("group") 
        |> lapply(grp -> sum(grp$links))
        ;

        str(atoms_vec);
        stop();
    }
}