require(PathwayAssembler);

# atoms = molecular_vector(refmet(), workdir = @dir);

write.csv(molecular_vector(refmet(), workdir = @dir), file  = file.path(@dir, "atoms_vec.csv"));
