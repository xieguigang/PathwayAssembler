require(PathwayAssembler);

# atoms = molecular_vector(refmet(), workdir = @dir);

# create the molecule strcutre dataset
write.csv(molecular_vector(refmet(), workdir = @dir), file  = file.path(@dir, "atoms_vec.csv"));
