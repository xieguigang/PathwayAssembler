imports "SMILES" from "mzkit";

require(HDS);

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
    let hds_pack = file.path(workdir, "molecular_vector.hds")
    |> HDS::openStream(readonly = FALSE,
            allowCreate = TRUE,
            meta_size = 32 * 1024 * 1024
    );
    let vector = list();

    # filter the reference metabolite which has smiles strucutre data.
    refmet = refmet[nchar(trim(refmet$smiles, ' "')) > 0,];
    refmet[,"smiles"] = gsub(refmet$smiles, "%10","");

    # assign the tqdm progress label
    rownames(refmet) <- make.names(refmet$refmet_name, 
        unique = TRUE, allow_ = TRUE);
    
    for(let meta in tqdm(as.list(refmet, byrow = TRUE))) {
        let met_struct = SMILES::parse(trim(meta$smiles, '" '), strict = FALSE);
        let atoms_vec = SMILES::atoms(met_struct);

        atoms_vec = atoms_vec 
        |> groupBy("group") 
        |> lapply(grp -> sum(grp$links))
        ;

        atoms_vec$name = meta$refmet_name;
        vector[[meta$refmet_name]] = atoms_vec;

        let dir = substr(meta$refmet_name,1,2);
        let filename = gsub(meta$refmet_name,"[/\\]","_",regexp = TRUE);

        hds_pack |> writeText(`/${dir}/${filename}.json`, 
            text = JSON::json_encode(atoms_vec));
    }

    HDS::flush(hds_pack);
    close(hds_pack);

    vector = bind_rows(vector);
    rownames(vector) = vector$name;
    vector;
}