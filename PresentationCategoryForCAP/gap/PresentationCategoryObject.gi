#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

DeclareRepresentation( "IsLeftPresentationWithDegreesRep",
                       IsLeftPresentationWithDegrees and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftPresentationsWithDegrees",
            NewFamily( "TheFamilyOfLeftPresentationsWithDegrees" ) );

BindGlobal( "TheTypeOfLeftPresentationsWithDegrees",
            NewType( TheFamilyOfLeftPresentationsWithDegrees,
                     IsLeftPresentationWithDegreesRep ) );


DeclareRepresentation( "IsRightPresentationWithDegreesRep",
                       IsRightPresentationWithDegrees and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightPresentationsWithDegrees",
            NewFamily( "TheFamilyOfRightPresentationsWithDegrees" ) );

BindGlobal( "TheTypeOfRightPresentationsWithDegrees",
            NewType( TheFamilyOfRightPresentationsWithDegrees,
                     IsRightPresentationWithDegreesRep ) );

#############################
##
## Constructors
##
#############################

InstallGlobalFunction( AsLeftOrRightPresentationWithDegrees,
               
  function( degrees_of_source, matrix, left )
    local graded_ring, projective_category, first_source_degree, i, j, graded_module, type, presentation_category,
         degrees_of_mapping_matrix_entries, degrees_of_range, source, range;
         
    # construct the underlying projective category 
    graded_ring := HomalgRing( matrix );
    projective_category := ProjectiveCategory( graded_ring );
    
    # flatten the degrees_of_source
    first_source_degree := degrees_of_source[ 1 ][ 1 ];

    # compute the degree of the range
    degrees_of_mapping_matrix_entries := NonTrivialDegreePerColumn( matrix );
    degrees_of_range := List( Length( degrees_of_mapping_matrix_entries ), 
         i -> [ UnderlyingListOfRingElements( degrees_of_mapping_matrix_entries[ i ] ) + first_source_degree, 1 ] );
        
    # initialise the graded_module
    graded_module := rec( );
    
    # now construct an object
    if left = true then
    
        type := TheTypeOfLeftPresentationsWithDegrees;
        #presentation_category := LeftPresentations( ring );
    
    else

        type := TheTypeOfRightPresentationsWithDegrees;
        #presentation_category := RightPresentations( ring );
    
    fi;
    
    # now compute the source and range objects in the underlying ProjectiveCategoryForCAP
    source := ProjectiveCategoryObject( degrees_of_source, graded_ring );
    range := ProjectiveCategoryObject( degrees_of_range, graded_ring );
    
    # and represent the module as a morphism in the ProjectiveCategoryForCAP
    ObjectifyWithAttributes( graded_module, type,
                             UnderlyingMatrix, matrix,
                             UnderlyingHomalgGradedRing, graded_ring,
                             UnderlyingMorphism, ProjectiveCategoryMorphism( source, matrix, range )
                           );
    
    #Add( presentation_category, module );
    
    return graded_module;
    
end );

##
InstallMethod( AsLeftPresentationWithDegrees,
               [ IsList, IsHomalgMatrix ],
  function( degrees_of_source, matrix )
  
    return AsLeftOrRightPresentationWithDegrees( degrees_of_source, matrix, true );

end );    
    
##
InstallMethod( AsRightPresentationWithDegrees,
               [ IsList, IsHomalgMatrix ],
  function( degrees_of_source, matrix )
               
    return AsLeftOrRightPresentationWithDegrees( degrees_of_source, matrix, false );

end );
    
##
InstallMethod( FreeLeftPresentationWithDegrees,
               [ IsList, IsHomalgGradedRing ],
               
  function( degrees_of_source, homalg_graded_ring )
    local rank;    

    # compute the rank of the module
    rank := Sum( List( degrees_of_source, k -> degrees_of_source[ k ][ 2 ] ) );

    # and then construct this object
    return AsLeftPresentationWithDegrees( HomalgZeroMatrix( 0, rank, homalg_graded_ring ), degrees_of_source );
    
end );

##
InstallMethod( FreeRightPresentationWithDegrees,
               [ IsList, IsHomalgGradedRing ],
               
  function( degrees_of_source, homalg_graded_ring )
    local rank;
    
    # compute the rank of the module
    rank := Sum( List( degrees_of_source, k -> degrees_of_source[ k ][ 2 ] ) );

    # and then construct this object    
    return AsRightPresentationWithDegrees( HomalgZeroMatrix( rank, 0, homalg_graded_ring ), degrees_of_source );
    
end );

##############################################
##
## Non categorical methods
##
##############################################

##
#InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT,
#                                  [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
                                  
#  function( object_1, object_2 )
#    local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
#          free_module_source, free_module_range, differential;
    
#    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
#    transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
    
#    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
#    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
#    homalg_ring := UnderlyingHomalgRing( object_1 );
    
#    free_module_source := FreeLeftPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
    
#    free_module_range := FreeLeftPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
    
#    differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
#                                           differential_matrix,
#                                           TensorProductOnObjects( free_module_range, object_2 )
#                                         );
    
#    return KernelEmbedding( differential );
    
#end );

##
#InstallMethodWithCacheFromObject( INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT,
#                                  [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ],
                                  
#  function( object_1, object_2 )
#    local underlying_matrix_1, transposed_underlying_matrix_1, identity_matrix_2, differential_matrix, homalg_ring,
#          free_module_source, free_module_range, differential;
    
#    underlying_matrix_1 := UnderlyingMatrix( object_1 );
    
#    transposed_underlying_matrix_1 := Involution( underlying_matrix_1 );
    
#    identity_matrix_2 := UnderlyingMatrix( IdentityMorphism( object_2 ) );
    
#    differential_matrix := KroneckerMat( transposed_underlying_matrix_1, identity_matrix_2 );
    
#    homalg_ring := UnderlyingHomalgRing( object_1 );
    
#    free_module_source := FreeRightPresentation( NrRows( underlying_matrix_1 ), homalg_ring );
    
#    free_module_range := FreeRightPresentation( NrColumns( underlying_matrix_1 ), homalg_ring );
    
#    differential :=  PresentationMorphism( TensorProductOnObjects( free_module_source, object_2 ),
#                                           differential_matrix,
#                                           TensorProductOnObjects( free_module_range, object_2 )
#                                         );
    
#    return KernelEmbedding( differential );
    
#end );