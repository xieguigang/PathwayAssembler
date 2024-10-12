// export R# source type define for javascript/typescript language
//
// package_source=PathwayAssembler

declare namespace PathwayAssembler {
   module _ {
      /**
      */
      function onLoad(): object;
   }
   /**
     * @param kappa default value Is ``3``.
   */
   function embedding_vec(sort_seqs: any, kappa?: any): object;
   /**
     * @param dims default value Is ``9``.
   */
   function molecular_tree(refmet: any, dims?: any): object;
   /**
     * @param workdir default value Is ``./``.
   */
   function molecular_vector(refmet: any, workdir?: any): object;
   /**
   */
   function refmet(): object;
}
