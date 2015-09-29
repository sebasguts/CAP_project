#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

DeclareRepresentation( "IsCAPPresentationCategoryObjectRep",
                       IsCAPPresentationCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryObjects",
            NewFamily( "TheFamilyOfCAPPresentationCategoryObjects" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryObject",
            NewType( TheFamilyOfCAPPresentationCategoryObjects,
                     IsCAPPresentationCategoryObjectRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( AsCAPCategoryPresentation,
               [ IsCapCategoryMorphism, IsCapCategory ],
  function( presentation_morphism, projective_category )
    local A, nrGenerators, i, buffer, buffer_homalg_module_element, category, presentation_category_object, 
         rank;
  
    # check that the input is valid
    if not IsIdenticalObj( CapCategory( presentation_morphism ), projective_category ) then
    
      Error( "The morphism is not defined in the projective category. \n" );
      return false;
    
    fi;
    
    # then construct the object
    presentation_category_object := rec( );    
    ObjectifyWithAttributes( presentation_category_object, TheTypeOfCAPPresentationCategoryObject,
                             UnderlyingMorphism, presentation_morphism
    );

    # add it to the presentation category
    #category := PresentationCategory( projective_category );
    #Add( category, projective_category_object );
    
    # and return the result
    return projective_category_object;    

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