#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

##
InstallMethod( PresentationCategory,
               [ IsCapCategory ],
               
  function( projective_category )
    local category;
    
    # set up the category
    category := CreateCapCategory( Concatenation( "Presentation category over ", Name( projective_category ) ) );    
    category!.underlying_projective_category := projective_category;

    # tell the category that it is an Abelian category
    SetIsAbelianCategory( category, true );
    
    # does this category have these properties?
    #SetIsSymmetricClosedMonoidalCategory( category, true );
    #SetIsStrictMonoidalCategory( category, true );
    
    # now add basic functionality for the category
    ADD_FUNCTIONS_FOR_PRESENTATION_CATEGORY( category );

    # add the category to the family of presentation categories
    AddCategoryToFamily( category, "PresentationCategory" );
    
    ## TODO: ADD LOGICAL IMPLICATIONS & clean old logic files by avoiding code duplication (see RightPresentations)
    #AddTheoremFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
    #    "PropositionsForGeneralModuleCategories.tex" )
    #);    
    #AddPredicateImplicationFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
    #    "PredicateImplicationsForGeneralModuleCategories.tex" )
    # );    
    #AddEvalRuleFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
    #    "RelationsForGeneralModuleCategories.tex" )
    #);
    
    # now finalise this category
    Finalize( category );
    
    # and return it
    return category;
    
end );

######################################
##
## Tech stuff
##
######################################

##############################################
##
## Install the basic functionality
##
##############################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_PRESENTATION_CATEGORY,
                       
  function( category )
    
    ADD_KERNEL( category );
    
    ADD_PRECOMPOSE( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM( category );
    
    ADD_EQUAL_FOR_MORPHISMS( category );
    
    ADD_COKERNEL( category );
    
    ADD_DIRECT_SUM( category );
    
    ADD_ZERO_OBJECT( category );
    
    ADD_IDENTITY( category );
    
    ADD_EQUAL_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM( category );
    
    ADD_IS_IDENTICAL_FOR_MORPHISMS( category );

    # can I install these functions?
    #ADD_TENSOR_PRODUCT_ON_OBJECTS( category );
    #ADD_TENSOR_PRODUCT_ON_MORPHISMS( category );      
    #ADD_TENSOR_UNIT( category );      
    #ADD_INTERNAL_HOM_ON_OBJECTS( category );      
    #ADD_INTERNAL_HOM_ON_MORPHISMS( category );      
    #ADD_BRAIDING_LEFT( category );      
    #ADD_EVALUATION_MORPHISM( category );      
    #ADD_COEVALUATION_MORPHISM( category );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_OBJECTS,
                       
  function( category )
    
    AddIsWellDefinedForObjects( category,
      
      function( object )
        
        return IsWellDefinedForMorphisms( UnderlyingMorphism( object ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        local source_matrix, range_matrix, morphism_matrix;
        
        # we should first check that source, range and the mapping itself are well-defined...
        if not IsWellDefinedForObjects( Source( morphism ) ) then
        
          return false;
          
        elif not IsWellDefinedForObjects( Range( morphism ) ) then
        
          return false;
        
        elif not IsWellDefinedForMorphisms( UnderlyingMorphism( morphism ) ) then
        
          return false;
        
        fi;
        
        # in case this is the case, we try to compute the necessary lift
        if Lift( UnderlyingMorphism( Range( morphism ) ), 
                        Precompose( UnderlyingMorphism( Source( morphism ) ), UnderlyingMorphism( morphsim ) ) ) = false then
        
          # there is no such lift, thus the mapping is not well-defined
          return false;
        
        fi;
        
        # otherwise all checks have been passed, so return true        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_IDENTICAL_FOR_MORPHISMS,
                              
  function( category )
    
    AddIsEqualForMorphisms( category,
    
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphisms( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_OBJECTS,
                       
  function( category )
    
    AddIsEqualForObjects( category,
                   
      function( object1, object2 )
        
        return IsEqualForMorphisms( UnderlyingMorphism( object1 ), UnderlyingMorphism( object2 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE,
                       
  function( category )
    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return CAPPresentationCategoryMorphism( 
                                     Source( left_morphism ), 
                                     PreCompose( UnderlyingMorphism( left_morphism ), UnderlyingMorphism( right_morphism ) ),
                                     Range( right_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITION_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditionForMorphisms( category,
                             
      function( morphism_1, morphism_2 )
        
        return CAPPresentationCategoryMorphism( 
                                     Source( morphism1 ), 
                                     AdditionForMorphism( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) ),
                                     Range( morphism2 ) 
                                     );
                                     
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITIVE_INVERSE_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( morphism )
        
        return CAPPresentationCategoryMorphism( 
                                           Source( morphism ),
                                           AdditiveInverseForMorMorphisms( UnderlyingMorphism( morphism ) ),
                                           Range( morphism )
                                           );
        
    end );
    
end );

##
#InstallGlobalFunction( ADD_IS_ZERO_FOR_MORPHISMS,
                       
#  function( category )
    ## FIXME: Use DecideZeroRows here (and DecideZeroColumns for the case of right modules)
#     AddIsZeroForMorphisms( category,
#                            
#       function( morphism )
#         
#         return IsZero( UnderlyingMatrix( morphism ) );
#         
#     end );
    
#end );










##
InstallGlobalFunction( ADD_ZERO_MORPHISM,
                       
  function( category )
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );


##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroRows( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );










##
InstallGlobalFunction( ADD_KERNEL,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsLeftPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddLift( category,
      
      function( alpha, beta )
        local lift;
        
        lift := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( beta ) ) );
        
        if lift = fail then
            return fail;
        fi;
        
        return PresentationMorphism( Source( alpha ), lift, Source( beta ) );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_COKERNEL,
                       
  function( category )
    
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsLeftPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_DIRECT_SUM,
                       
  function( category )
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsLeftPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> 
                            HomalgZeroMatrix( i, dimension_of_factor, category!.ring_for_representation_category ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfRows( projection_matrix, projection[ i ] );
            
        od;
        
        return PresentationMorphism( direct_sum_object, projection_matrix, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfColumns( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrColumns( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_cofactor, i, category!.ring_for_representation_category ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], category!.ring_for_representation_category );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfColumns( injection_matrix, injection[ i ] );
            
        od;
        
        return PresentationMorphism( objects[ component_number ], injection_matrix, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
                                                         
      function( diagram, product_morphism, direct_sum )
        local components, number_of_components, map_into_product, i;
        
        components := product_morphism;
        
        number_of_components := Length( components );
        
        map_into_product := UnderlyingMatrix( components[ 1 ] );
        
        for i in [ 2 .. number_of_components ] do
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( direct_sum, map_into_product, Range( components[ 1 ] ) );
        
    end );
    
end );




##
InstallGlobalFunction( ADD_ZERO_OBJECT,
                       
  function( category )
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, category!.ring_for_representation_category );
        
        return AsLeftPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_columns, 0, category!.ring_for_representation_category );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_columns, category!.ring_for_representation_category );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_IDENTITY,
                       
  function( category )
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( object ) ), category!.ring_for_representation_category );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS,
                      
  function( category )
    
    AddTensorProductOnObjects( category,
      
      function( object_1, object_2 )
        local identity_1, identity_2, presentation_matrix_1, presentation_matrix_2, presentation_matrix;
        
        presentation_matrix_1 := UnderlyingMatrix( object_1 );
        
        presentation_matrix_2 := UnderlyingMatrix( object_2 );
        
        identity_1 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_1 ), category!.ring_for_representation_category );
        
        identity_2 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_2 ), category!.ring_for_representation_category );
        
        presentation_matrix := UnionOfRows(
                                 KroneckerMat( identity_1, presentation_matrix_2 ),
                                 KroneckerMat( presentation_matrix_1, identity_2 )
                               );
        
        return AsLeftPresentation( presentation_matrix );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_MORPHISMS,
                      
  function( category )
    
    AddTensorProductOnMorphisms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return PresentationMorphism( new_source, 
                                     KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
                                     new_range );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_TENSOR_UNIT,
                      
  function( category )
    
    AddTensorUnit( category,
      
      function( )
        local homalg_ring;
        
        homalg_ring := category!.ring_for_representation_category;
        
        return AsLeftPresentation( HomalgZeroMatrix( 0, 1, homalg_ring ) );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 ) );
    
    end );
    
end );



##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphisms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( Source( morphism_1 ), Range( morphism_2 ) );
        
        morphism_between_tensor_products := 
          PresentationMorphism(
            Range( internal_hom_embedding_source ),
            KroneckerMat( Involution( UnderlyingMatrix( morphism_1 ) ), UnderlyingMatrix( morphism_2 ) ),
            Range( internal_hom_embedding_range )
          );
        
        return LiftAlongMonomorphism( internal_hom_embedding_range,
                                 PreCompose( internal_hom_embedding_source, morphism_between_tensor_products ) );
        
    end );

end );



##
InstallGlobalFunction( ADD_BRAIDING,
                      
  function( category )
    
    AddBraiding( category,
      
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        rank := NrColumns( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        
        return PresentationMorphism( object_1_tensored_object_2,
                                     HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ),
                                     object_2_tensored_object_1 );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM,
  
  function( category )
    
    AddEvaluationMorphism( category,
      
      function( object_1, object_2, internal_hom_tensored_object_1 )
        local homalg_ring, internal_hom_embedding, rank_1, morphism, free_module,
              column, zero_column, i, matrix, rank_2, lifted_evaluation;
        
        homalg_ring := category!.ring_for_representation_category;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeLeftPresentation( rank_1, homalg_ring );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
        
        morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
        
        ## Computation of F^{\vee} \otimes F \rightarrow 1
        column := [ ];
        
        zero_column := List( [ 1 .. rank_1 ], i -> 0 );
        
        for i in [ 1 .. rank_1 - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if rank_1 > 0 then 
          
          Add( column, 1 );
          
        fi;
        
        matrix := HomalgMatrix( column, rank_1 * rank_1, 1, homalg_ring );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
        
        lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );



##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM,
  
  function( category )
    
    AddCoevaluationMorphism( category,
      
      function( object_1, object_2, internal_hom )
        local homalg_ring, object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              row, zero_row, i, matrix, rank_1, lifted_coevaluation;
        
        homalg_ring := category!.ring_for_representation_category;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrColumns( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeLeftPresentation( rank_2, homalg_ring );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
        
        ## Construction of 1 \rightarrow F \otimes F^{\vee}
        
        row := [ ];
        
        zero_row := List( [ 1 .. rank_2 ], i -> 0 );
        
        for i in [ 1 .. rank_2 - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if rank_2 > 0 then 
          
          Add( row, 1 );
          
        fi;
        
        matrix := HomalgMatrix( row, 1, rank_2 * rank_2, homalg_ring );
        
        rank_1 := NrColumns( UnderlyingMatrix( object_1 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
        
        lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );