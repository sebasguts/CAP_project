#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

##
InstallMethod( LeftPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "The category of left presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    SetIsAbelianCategory( category, true );
    
    if IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetIsStrictMonoidalCategory( category, true );
    
    fi;
    
    ADD_FUNCTIONS_FOR_LEFT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    
    ## TODO: avoid code duplication (see RightPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RightPresentations,
               [ IsHomalgRing ],
               
  function( ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "The category of right presentations of ", RingName( ring ) ) );
    
    category!.ring_for_representation_category := ring;
    
    SetIsAbelianCategory( category, true );
    
    if IsCommutative( ring ) then
      
      SetIsSymmetricClosedMonoidalCategory( category, true );
      
      SetIsStrictMonoidalCategory( category, true );
    
    fi;
    
    ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION( category );
    
    AddCategoryToFamily( category, "ModuleCategory" );
    
    ## TODO: avoid code duplication (see LeftPresentations)
    AddTheoremFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PropositionsForGeneralModuleCategories.tex" )
    );
    
    AddPredicateImplicationFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "PredicateImplicationsForGeneralModuleCategories.tex" )
     );
    
    AddEvalRuleFileToCategory( category,
      Filename(
        DirectoriesPackageLibrary( "ModulePresentationsForCAP", "LogicForModulePresentations" ),
        "RelationsForGeneralModuleCategories.tex" )
    );
    
    Finalize( category );
    
    return category;
    
end );

######################################
##
## Tech stuff
##
######################################

##############################################
##
## LEFT
##
##############################################

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_LEFT_PRESENTATION,
                       
  function( category )
    
    ADD_KERNEL_LEFT( category );
    
    ADD_PRECOMPOSE_LEFT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_LEFT( category );
    
    ADD_EQUAL_FOR_MORPHISMS_LEFT( category );
    
    ADD_COKERNEL_LEFT( category );
    
    ADD_DIRECT_SUM_LEFT( category );
    
    ADD_ZERO_OBJECT_LEFT( category );
    
    ADD_IDENTITY_LEFT( category );
    
    ADD_EQUAL_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT( category );
    
    ADD_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    if IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_TENSOR_PRODUCT_ON_OBJECTS_LEFT( category );
      
      ADD_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_TENSOR_UNIT_LEFT( category );
      
      ADD_INTERNAL_HOM_ON_OBJECTS_LEFT( category );
      
      ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT( category );
      
      ADD_BRAIDING_LEFT( category );
      
      ADD_EVALUATION_MORPHISM_LEFT( category );
      
      ADD_COEVALUATION_MORPHISM_LEFT( category );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_FUNCTIONS_FOR_RIGHT_PRESENTATION,
                       
  function( category )
    
    ADD_KERNEL_RIGHT( category );
    
    ADD_PRECOMPOSE_RIGHT( category );
    
    ADD_ADDITION_FOR_MORPHISMS( category );
    
    ADD_ADDITIVE_INVERSE_FOR_MORPHISMS( category );
    
    ADD_IS_ZERO_FOR_MORPHISMS( category );
    
    ADD_ZERO_MORPHISM_RIGHT( category );
    
    ADD_EQUAL_FOR_MORPHISMS_RIGHT( category );
    
    ADD_COKERNEL_RIGHT( category );
    
    ADD_DIRECT_SUM_RIGHT( category );
    
    ADD_ZERO_OBJECT_RIGHT( category );
    
    ADD_IDENTITY_RIGHT( category );
    
    ADD_EQUAL_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_OBJECTS( category );
    
    ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT( category );
    
    ADD_IS_IDENTICAL_FOR_MORPHISMS( category );
    
    if IsCommutative( category!.ring_for_representation_category ) then
      
      ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT( category );
      
      ADD_TENSOR_PRODUCT_ON_MORPHISMS( category );
      
      ADD_TENSOR_UNIT_RIGHT( category );
      
      ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT( category );
      
      ADD_INTERNAL_HOM_ON_MORPHISMS_RIGHT( category );
      
      ADD_BRAIDING_RIGHT( category );
      
      ADD_EVALUATION_MORPHISM_RIGHT( category );
      
      ADD_COEVALUATION_MORPHISM_RIGHT( category );
      
    fi;
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_OBJECTS,
                       
  function( category )
    
    AddIsWellDefinedForObjects( category,
      
      function( object )
        
        return IsHomalgMatrix( UnderlyingMatrix( object ) ) and IsHomalgRing( UnderlyingHomalgRing( object ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_LEFT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrColumns( source_matrix ) = NrRows( morphism_matrix )
                 and NrColumns( morphism_matrix ) = NrColumns( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if RightDivide( source_matrix * morphism_matrix, range_matrix ) = fail then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_WELL_DEFINED_FOR_MORPHISM_RIGHT,
                       
  function( category )
    
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        
        local source_matrix, range_matrix, morphism_matrix;
        
        source_matrix := UnderlyingMatrix( Source( morphism ) );
        
        range_matrix := UnderlyingMatrix( Range( morphism ) );
        
        morphism_matrix := UnderlyingMatrix( morphism );
        
        if not ( NrRows( source_matrix ) = NrColumns( morphism_matrix )
                 and NrRows( morphism_matrix ) = NrRows( range_matrix ) ) then
          
          return false;
          
        fi;
        
        if LeftDivide( range_matrix, morphism_matrix * source_matrix ) = fail then
          
          return false;
          
        fi;
        
        return true;
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_IDENTICAL_FOR_MORPHISMS,
                              
  function( category )
    
    AddIsEqualForMorphisms( category,
    
      function( morphism_1, morphism_2 )
        
        return UnderlyingMatrix( morphism_1 ) = UnderlyingMatrix( morphism_2 );
        
    end );
    
    AddIsEqualForCacheForObjects( category, IsIdenticalObj );
    
    AddIsEqualForCacheForMorphisms( category, IsIdenticalObj );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_OBJECTS,
                       
  function( category )
    
    AddIsEqualForObjects( category,
                   
      function( object1, object2 )
        
        return UnderlyingMatrix( object1 ) = UnderlyingMatrix( object2 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_KERNEL_LEFT,
                       
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
InstallGlobalFunction( ADD_KERNEL_RIGHT,
                       
  function( category )
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local kernel, embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        kernel := SyzygiesOfColumns( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        kernel := AsRightPresentation( kernel );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local embedding;
        
        embedding := SyzygiesOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        return PresentationMorphism( kernel, embedding, Source( morphism ) );
        
    end );
    
    AddLift( category,
      
        ## TODO: Reference for the conventions for Lift
#       function( alpha, beta )
        function( beta, alpha )
        local lift;
        
        lift := LeftDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( alpha ) ) );
        
        if lift = fail then
            return fail;
        fi;
        
        return PresentationMorphism( Source( beta ), lift, Source( alpha ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddPreCompose( category,
                   
      [ 
        [ function( left_morphism, right_morphism )
            
            return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( left_morphism ) * UnderlyingMatrix( right_morphism ), Range( right_morphism ) );
            
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        [ function( left_morphism, zero_morphism )
            
            return PresentationMorphism( Source( left_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( left_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_ring ),
                                         Range( zero_morphism ) );
          
          end, [ , IsIdenticalToZeroMorphism ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return PresentationMorphism( Source( zero_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( right_morphism ) ), homalg_ring ),
                                         Range( right_morphism ) );
          
          end, [ IsIdenticalToZeroMorphism, ] ],
      ]
      
    );
    
end );

##
InstallGlobalFunction( ADD_PRECOMPOSE_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddPreCompose( category,
      
      [ 
        
        [ function( left_morphism, right_morphism )
          
          return PresentationMorphism( Source( left_morphism ), UnderlyingMatrix( right_morphism ) * UnderlyingMatrix( left_morphism ), Range( right_morphism ) );
          
          end, [ , ] ],
        
        [ function( left_morphism, identity_morphism )
            
            return left_morphism;
            
          end, [ , IsIdenticalToIdentityMorphism ] ],
        
        [ function( identity_morphism, right_morphism )
            
            return right_morphism;
            
          end, [ IsIdenticalToIdentityMorphism, ] ],
        
        
        [ function( left_morphism, zero_morphism )
            
            return PresentationMorphism( Source( left_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( zero_morphism ) ), NrColumns( UnderlyingMatrix( left_morphism ) ), homalg_ring ),
                                         Range( zero_morphism ) );
          
          end, [ , IsIdenticalToZeroMorphism ] ],
        
        [ function( zero_morphism, right_morphism )
            
            return PresentationMorphism( Source( zero_morphism ),
                                         HomalgZeroMatrix( NrRows( UnderlyingMatrix( right_morphism ) ), NrColumns( UnderlyingMatrix( zero_morphism ) ), homalg_ring ),
                                         Range( right_morphism ) );
          
          end, [ IsIdenticalToZeroMorphism, ] ],
      ]
      
    );
    
end );

##
InstallGlobalFunction( ADD_ADDITION_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditionForMorphisms( category,
                             
      function( morphism_1, morphism_2 )
        
        return PresentationMorphism( Source( morphism_1 ), UnderlyingMatrix( morphism_1 ) + UnderlyingMatrix( morphism_2 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ADDITIVE_INVERSE_FOR_MORPHISMS,
                       
  function( category )
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( morphism_1 )
        
        return PresentationMorphism( Source( morphism_1 ), - UnderlyingMatrix( morphism_1 ), Range( morphism_1 ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IS_ZERO_FOR_MORPHISMS,
                       
  function( category )
    ## FIXME: Use DecideZeroRows here (and DecideZeroColumns for the case of right modules)
#     AddIsZeroForMorphisms( category,
#                            
#       function( morphism )
#         
#         return IsZero( UnderlyingMatrix( morphism ) );
#         
#     end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrColumns( UnderlyingMatrix( source ) ), NrColumns( UnderlyingMatrix( range ) ), homalg_ring );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_MORPHISM_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroMorphism( category,
                     
      function( source, range )
        local matrix;
        
        matrix := HomalgZeroMatrix( NrRows( UnderlyingMatrix( range ) ), NrRows( UnderlyingMatrix( source ) ), homalg_ring );
        
        return PresentationMorphism( source, matrix, range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_LEFT,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroRows( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EQUAL_FOR_MORPHISMS_RIGHT,
                       
  function( category )
    
    AddIsCongruentForMorphisms( category,
                            
      function( morphism_1, morphism_2 )
        local result_of_divide;
        
        result_of_divide := DecideZeroColumns( UnderlyingMatrix( morphism_1 ) - UnderlyingMatrix( morphism_2 ), UnderlyingMatrix( Range( morphism_1 ) ) );
        
        return IsZero( result_of_divide );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsLeftPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COKERNEL_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        cokernel_object := UnionOfColumns( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        cokernel_object := AsRightPresentation( cokernel_object );
        
        projection := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        projection := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( Range( morphism ) ) ), homalg_ring );
        
        return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_DIRECT_SUM_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
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
                            HomalgZeroMatrix( i, dimension_of_factor, homalg_ring ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
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
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_cofactor, i, homalg_ring ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
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
InstallGlobalFunction( ADD_DIRECT_SUM_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddDirectSum( category,
                  
      function( product_object )
        local objects, direct_sum;
        
        objects := product_object;
        
        objects := List( objects, UnderlyingMatrix );
        
        direct_sum := DiagMat( objects );
        
        return AsRightPresentation( direct_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_factor, projection, projection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_factor := object_column_dimension[ component_number ];
        
        projection := List( object_column_dimension, i -> HomalgZeroMatrix( dimension_of_factor, i, homalg_ring ) );
        
        projection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        projection_matrix := projection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            projection_matrix := UnionOfColumns( projection_matrix, projection[ i ] );
            
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
            
            map_into_product := UnionOfRows( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( Source( components[ 1 ] ), map_into_product, direct_sum );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( product_object, component_number, direct_sum_object )
        local objects, object_column_dimension, dimension_of_cofactor, injection, injection_matrix, i;
        
        objects := product_object;
        
        object_column_dimension := List( objects, i -> NrRows( UnderlyingMatrix( i ) ) );
        
        dimension_of_cofactor := object_column_dimension[ component_number ];
        
        injection := List( object_column_dimension, i -> HomalgZeroMatrix( i, dimension_of_cofactor, homalg_ring ) );
        
        injection[ component_number ] := HomalgIdentityMatrix( object_column_dimension[ component_number ], homalg_ring );
        
        injection_matrix := injection[ 1 ];
        
        for i in [ 2 .. Length( objects ) ] do
            
            injection_matrix := UnionOfRows( injection_matrix, injection[ i ] );
            
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
            
            map_into_product := UnionOfColumns( map_into_product, UnderlyingMatrix( components[ i ] ) );
            
        od;
        
        return PresentationMorphism( direct_sum, map_into_product, Range( components[ 1 ] ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_OBJECT_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, homalg_ring );
        
        return AsLeftPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_columns, 0, homalg_ring );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local nr_columns, morphism;
        
        nr_columns := NrColumns( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_columns, homalg_ring );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_ZERO_OBJECT_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddZeroObject( category,
                   
      function( )
        local matrix;
        
        matrix := HomalgZeroMatrix( 0, 0, homalg_ring );
        
        return AsRightPresentation( matrix );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( 0, nr_rows, homalg_ring );
        
        return PresentationMorphism( object, morphism, terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        local nr_rows, morphism;
        
        nr_rows := NrRows( UnderlyingMatrix( object ) );
        
        morphism := HomalgZeroMatrix( nr_rows, 0, homalg_ring );
        
        return PresentationMorphism( initial_object, morphism, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_LEFT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( object ) ), homalg_ring );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_IDENTITY_RIGHT,
                       
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddIdentityMorphism( category,
                         
      function( object )
        local matrix;
        
        matrix := HomalgIdentityMatrix( NrRows( UnderlyingMatrix( object ) ), homalg_ring );
        
        return PresentationMorphism( object, matrix, object );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS_LEFT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorProductOnObjects( category,
      
      function( object_1, object_2 )
        local identity_1, identity_2, presentation_matrix_1, presentation_matrix_2, presentation_matrix;
        
        presentation_matrix_1 := UnderlyingMatrix( object_1 );
        
        presentation_matrix_2 := UnderlyingMatrix( object_2 );
        
        identity_1 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_1 ), homalg_ring );
        
        identity_2 := 
          HomalgIdentityMatrix( NrColumns( presentation_matrix_2 ), homalg_ring );
        
        presentation_matrix := UnionOfRows(
                                 KroneckerMat( identity_1, presentation_matrix_2 ),
                                 KroneckerMat( presentation_matrix_1, identity_2 )
                               );
        
        return AsLeftPresentation( presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_OBJECTS_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorProductOnObjects( category,
      
      function( object_1, object_2 )
        local identity_1, identity_2, presentation_matrix_1, presentation_matrix_2, presentation_matrix;
        
        presentation_matrix_1 := UnderlyingMatrix( object_1 );
        
        presentation_matrix_2 := UnderlyingMatrix( object_2 );
        
        identity_1 := 
          HomalgIdentityMatrix( NrRows( presentation_matrix_1 ), homalg_ring );
        
        identity_2 := 
          HomalgIdentityMatrix( NrRows( presentation_matrix_2 ), homalg_ring );
        
        presentation_matrix := UnionOfColumns(
                                 KroneckerMat( identity_1, presentation_matrix_2 ),
                                 KroneckerMat( presentation_matrix_1, identity_2 )
                               );
        
        return AsRightPresentation( presentation_matrix );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_PRODUCT_ON_MORPHISMS,
                      
  function( category )
    
    AddTensorProductOnMorphismsWithGivenTensorProducts( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return PresentationMorphism( new_source, 
                                     KroneckerMat( UnderlyingMatrix( morphism_1 ), UnderlyingMatrix( morphism_2 ) ),
                                     new_range );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_UNIT_LEFT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorUnit( category,
      
      function( )
        
        return AsLeftPresentation( HomalgZeroMatrix( 0, 1, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_TENSOR_UNIT_RIGHT,
                      
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddTensorUnit( category,
      
      function( )
        
        return AsRightPresentation( HomalgZeroMatrix( 1, 0, homalg_ring ) );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_OBJECTS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnObjects( category,
      
      function( object_1, object_2 )
        
        return Source( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 ) );
    
    end );
    
end );

##
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS_LEFT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
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
InstallGlobalFunction( ADD_INTERNAL_HOM_ON_MORPHISMS_RIGHT,
                      
  function( category )
    
    ## WARNING: The given function uses basic operations.
    AddInternalHomOnMorphismsWithGivenInternalHoms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        local internal_hom_embedding_source, internal_hom_embedding_range, morphism_between_tensor_products;
        
        internal_hom_embedding_source := 
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Range( morphism_1 ), Source( morphism_2 ) );
        
        internal_hom_embedding_range :=
          INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( Source( morphism_1 ), Range( morphism_2 ) );
        
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
InstallGlobalFunction( ADD_BRAIDING_LEFT,
                      
  function( category )
    
    AddBraidingWithGivenTensorProducts( category,
      
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
InstallGlobalFunction( ADD_BRAIDING_RIGHT,
                      
  function( category )
    
    AddBraidingWithGivenTensorProducts( category,
      
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_ring, permutation_matrix, rank_1, rank_2, rank;
        
        homalg_ring := UnderlyingHomalgRing( object_1 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        rank := NrRows( UnderlyingMatrix( object_1_tensored_object_2 ) );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. rank ], i -> ( RemInt( i - 1, rank_2 ) * rank_1 + QuoInt( i - 1, rank_2 ) + 1 ) ) ),
                                rank 
                              );
        
        return PresentationMorphism( object_1_tensored_object_2,
                                     Involution( HomalgMatrix( permutation_matrix, rank, rank, homalg_ring ) ), ## transposed of the left case
                                     object_2_tensored_object_1 );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddEvaluationMorphismWithGivenSource( category,
      
      function( object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              column, zero_column, i, matrix, rank_2, lifted_evaluation;
        
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
InstallGlobalFunction( ADD_EVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddEvaluationMorphismWithGivenSource( category,
      
      function( object_1, object_2, internal_hom_tensored_object_1 )
        local internal_hom_embedding, rank_1, morphism, free_module,
              row, zero_row, i, matrix, rank_2, lifted_evaluation;
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_1, object_2 );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        free_module := FreeRightPresentation( rank_1, homalg_ring );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_2 ) );
        
        morphism := TensorProductOnMorphisms( morphism, IdentityMorphism( object_1 ) );
        
        ## Construction of F^{\vee} \otimes F \rightarrow 1
        row := [ ];
        
        zero_row := List( [ 1 .. rank_1 ], i -> 0 );
        
        for i in [ 1 .. rank_1 - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if rank_1 > 0 then 
          
          Add( row, 1 );
          
        fi;
        
        matrix := HomalgMatrix( row, 1, rank_1 * rank_1, homalg_ring );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_2, homalg_ring ), matrix );
        
        lifted_evaluation := PresentationMorphism( Range( morphism ), matrix, object_2 );
        
        return PreCompose( morphism, lifted_evaluation );
        
    end );
    
end );

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_LEFT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCoevaluationMorphismWithGivenRange( category,
      
      function( object_1, object_2, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              row, zero_row, i, matrix, rank_1, lifted_coevaluation;
        
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

##
InstallGlobalFunction( ADD_COEVALUATION_MORPHISM_RIGHT,
  
  function( category )
    local homalg_ring;
    
    homalg_ring := category!.ring_for_representation_category;
    
    AddCoevaluationMorphismWithGivenRange( category,
      
      function( object_1, object_2, internal_hom )
        local object_1_tensored_object_2, internal_hom_embedding, rank_2, free_module, morphism,
              column, zero_column, i, matrix, rank_1, lifted_coevaluation;
        
        object_1_tensored_object_2 := TensorProductOnObjects( object_1, object_2 );
        
        internal_hom_embedding := INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT( object_2, object_1_tensored_object_2 );
        
        rank_2 := NrRows( UnderlyingMatrix( object_2 ) );
        
        free_module := FreeRightPresentation( rank_2, homalg_ring );
        
        morphism := PreCompose( internal_hom_embedding, Braiding( free_module, object_1_tensored_object_2 ) );
        
        ## Construction of 1 \rightarrow F \otimes F^{\vee}
        
        column := [ ];
        
        zero_column := List( [ 1 .. rank_2 ], i -> 0 );
        
        for i in [ 1 .. rank_2 - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if rank_2 > 0 then 
          
          Add( column, 1 );
          
        fi;
        
        matrix := HomalgMatrix( column, rank_2 * rank_2, 1, homalg_ring );
        
        rank_1 := NrRows( UnderlyingMatrix( object_1 ) );
        
        matrix := KroneckerMat( HomalgIdentityMatrix( rank_1, homalg_ring ), matrix );
        
        lifted_coevaluation := PresentationMorphism( object_1, matrix, Range( morphism ) );
        
        return LiftAlongMonomorphism( morphism, lifted_coevaluation );
        
    end );
    
end );

