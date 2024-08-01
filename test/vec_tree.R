require(PathwayAssembler);

molecular_tree(refmet = read.csv(file.path(@dir, "atoms_vec.csv"), row.names = 1, check.names = FALSE), @dir);