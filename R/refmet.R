#' load the internal refmet dataset
#' 
const refmet = function() {
    "data/refmet.csv" 
    |> system.file(package = "PathwayAssembler")
    |> read.csv(row.names = NULL, check.names = FALSE)
    ;
}