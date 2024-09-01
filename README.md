# PathwayAssembler
 
De-Novol assembling metabolic pathway based on the metabolite structure clustering.

## How it works

Reconstruct of the metabolic pathway is based on the spectrum molecular networking method. For make the metabolic pathway de-novol assembling, the algorithm is implemeneted:

1. Parse the molecule strcuture into graph data
    
   A SMILES metabolite structure parser was implemented in mzkit package for parse the metabolite structure as network graph object.
   And the atom group node was sorted in duplicated number in asceding order for make a sequence.

2. Make molecule structure graph embedding as vector
  
   The SGT embedding algorithm was apply on the generated sequence data for make the vector embedding.

3. Make knn network clustering of the embedding result

   Make networking reconstruct via the knn networking method(UMAP implements algorithm).

4. Generates the metabolic network reconstrction result based on the knn result

   Export the umap graph as the metabolick network reconstruct result. And then make the reconstructed global metabolic network visualization.

## 20240901 The very first trial run



