#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Graded submodules of projective graded modules over a graded ring
##
#############################################################################


##############################################################################################
##
##  Section GAP category of graded submodules for CAP
##
##############################################################################################

# install graded left submodules for CAP
DeclareRepresentation( "IsGradedLeftSubmoduleForCAPRep",
                       IsGradedLeftSubmoduleForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftSubmodulesForCAP",
            NewFamily( "TheFamilyOfGradedLeftSubmodulesForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftSubmoduleForCAP",
            NewType( TheFamilyOfGradedLeftSubmodulesForCAP,
                     IsGradedLeftSubmoduleForCAPRep ) );

# install graded right submodules for CAP
DeclareRepresentation( "IsGradedRightSubmoduleForCAPRep",
                       IsGradedRightSubmoduleForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightSubmodulesForCAP",
            NewFamily( "TheFamilyOfGradedRightSubmodulesForCAP" ) );

BindGlobal( "TheTypeOfGradedRightSubmoduleForCAP",
            NewType( TheFamilyOfGradedRightSubmodulesForCAP,
                     IsGradedRightSubmoduleForCAPRep ) );



##############################################################################################
##
#! @Section Constructors for graded submodules
##
##############################################################################################

# constructor for graded left submodules
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               
    local graded_left_submodule, matrix, range, alpha, pres, embedding;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    fi;

    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrColumns( matrix ) = 1 then
    
      return GradedLeftIdealForCAP( generator_list, homalg_graded_ring );
    
    else
      
      # construct the range
      range := CAPCategoryOfProjectiveGradedLeftModulesObject( 
                         [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrColumns( matrix ) ] ],
                         homalg_graded_ring 
                         );
    
      # now define alpha
      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );

      # we are thus looking at the following diagram
      #     ?                           0
      #     |                           |
      # ?-mapping (=pres)         zero_morphism
      #     |                           |
      #     v                           v
      #     ? -------- alpha -------> range
      #
      # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
      # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.
    
      # now compute the presentation of the ideal
      pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );
    
      # compute the embedding
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, alpha, range );
    
      # now define graded_left_submodule
      graded_left_submodule := rec( );
      ObjectifyWithAttributes( graded_left_submodule, TheTypeOfGradedLeftSubmoduleForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # finally return this ideal
      return graded_left_submodule;
    
    fi;

end );

# constructor for graded left submodules with given range
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a projective graded left module",
               [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( generator_list, range )               
    local homalg_graded_ring, graded_left_submodule, matrix, alpha, pres, embedding;

    # extract the graded ring
    homalg_graded_ring := UnderlyingHomalgGradedRing( range );
    
    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrColumns( matrix ) = 1 then
    
      return GradedLeftIdealForCAP( generator_list, homalg_graded_ring );
    
    else
      
      # now define alpha
      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );

      # we are thus looking at the following diagram
      #     ?                           0
      #     |                           |
      # ?-mapping (=pres)         zero_morphism
      #     |                           |
      #     v                           v
      #     ? -------- alpha -------> range
      #
      # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
      # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.
    
      # now compute the presentation of the ideal
      pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );
    
      # compute the embedding
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, alpha, range );
    
      # now define graded_left_submodule
      graded_left_submodule := rec( );
      ObjectifyWithAttributes( graded_left_submodule, TheTypeOfGradedLeftSubmoduleForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # finally return this ideal
      return graded_left_submodule;
    
    fi;

end );

# constructor for graded right-ideals
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               
    local graded_right_submodule, matrix, range, alpha, pres, embedding;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    fi;

    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrRows( matrix ) = 1 then
    
      return GradedRightIdealForCAP( generator_list, homalg_graded_ring );
      
    else
    
      # compute the range
      range := CAPCategoryOfProjectiveGradedRightModulesObject( 
                            [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrRows( matrix ) ] ],
                            homalg_graded_ring 
                          );
    
      # now define alpha
      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );

      # we are thus looking at the following diagram
      #     ?                           0
      #     |                           |
      # ?-mapping (=pres)         zero_morphism
      #     |                           |
      #     v                           v
      #     ? -------- alpha -------> range
      #
      # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
      # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.
    
      # now compute the presentation of the ideal
      pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );
    
      # compute the embedding
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, alpha, range );
    
      # now define graded_left_ideal
      graded_right_submodule := rec( );
      ObjectifyWithAttributes( graded_right_submodule, TheTypeOfGradedRightSubmoduleForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # finally return this ideal
      return graded_right_submodule;

    fi;

end );

# constructor for graded right submodules with given range
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a projective graded right module",
               [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( generator_list, range )               
    local homalg_graded_ring, graded_right_submodule, matrix, alpha, pres, embedding;

    # extract the graded ring
    homalg_graded_ring := UnderlyingHomalgGradedRing( range );
    
    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrRows( matrix ) = 1 then
    
      return GradedRightIdealForCAP( generator_list, homalg_graded_ring );
    
    else
      
      # now define alpha
      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );

      # we are thus looking at the following diagram
      #     ?                           0
      #     |                           |
      # ?-mapping (=pres)         zero_morphism
      #     |                           |
      #     v                           v
      #     ? -------- alpha -------> range
      #
      # We construct the two ? and the ?-mapping as the pullback of zero_morphism and alpha. This amounts to computing the
      # kernel embedding of alpha and identifying it with ?-mapping. This is therefore what we do.
    
      # now compute the presentation of the ideal
      pres := CAPPresentationCategoryObject( KernelEmbedding( alpha ) );
    
      # compute the embedding
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, alpha, range );
    
      # now define graded_left_submodule
      graded_right_submodule := rec( );
      ObjectifyWithAttributes( graded_right_submodule, TheTypeOfGradedRightSubmoduleForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # finally return this ideal
      return graded_right_submodule;
    
    fi;

end );

################################################
##
## Section String methods for the new categories
##
################################################

InstallMethod( String,
              [ IsGradedLeftSubmoduleForCAP ],
  function( graded_left_submodule )
    
     return Concatenation( "A graded left submodule over ", RingName( HomalgGradedRing( graded_left_submodule ) ) );

end );

InstallMethod( String,
              [ IsGradedRightSubmoduleForCAP ],
  function( graded_right_submodule )
    
     return Concatenation( "A graded right submodule over ", RingName( HomalgGradedRing( graded_right_submodule ) ) );

end );



#################################################
##
## Section Display methods for the new categories
##
#################################################

InstallMethod( Display,
              [ IsGradedLeftSubmoduleForCAP ],
  function( graded_left_submodule )
    
     Print( Concatenation( "A graded right submodule over ", 
                           RingName( HomalgGradedRing( graded_left_submodule ) ),
                           " generated by ",
                           String( Generators( graded_left_submodule ) )
                          ) 
                        );

end );

InstallMethod( Display,
              [ IsGradedRightSubmoduleForCAP ],
  function( graded_right_submodule )
    
     Print( Concatenation( "A graded right ideal in ", 
                           RingName( HomalgGradedRing( graded_right_submodule ) ),
                           " generated by ",
                           String( Generators( graded_right_submodule ) )
                          ) 
                        );

end );



#################################################
##
## Section ViewObj methods for the new categories
##
#################################################

InstallMethod( ViewObj,
              [ IsGradedLeftSubmoduleForCAP ],
  function( graded_left_submdule )

    Print( Concatenation( "<", String( graded_left_submdule ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsGradedRightSubmoduleForCAP ],
  function( graded_right_submodule )

    Print( Concatenation( "<", String( graded_right_submodule ), ">" ) );

end );



##############################################################################################
##
#! @Section Submodule powers
##
##############################################################################################


# for convenience allow "*" to indicate the (tensor) product on left submodules
InstallMethod( \*,
               "powers of submodules",
               [ IsGradedLeftSubmoduleForCAP, IsGradedLeftSubmoduleForCAP ],
  function( left_submodule1, left_submodule2 )
    local new_presentation, new_embedding, generators, range, new_graded_left_submodule;
    
    # check that the homalg_graded_rings are identical
    if not IsIdenticalObj( HomalgGradedRing( left_submodule1 ), HomalgGradedRing( left_submodule2 ) ) then
    
      return Error( "The submodules have to be defined over the same graded ring. \n" );
    
    fi;
    
    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( left_submodule1 ), 
                                                PresentationForCAP( left_submodule2 ) 
                                               );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( new_embedding ) );
    
    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject(
                         ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation, new_embedding, range );
    
    # now compute the new submodule
    new_graded_left_submodule := rec( );
    ObjectifyWithAttributes( new_graded_left_submodule, TheTypeOfGradedLeftSubmoduleForCAP,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( left_submodule1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_left_submodule;

end );


# for convenience allow "^" to indicate the n-th (tensor) power of left ideals
InstallMethod( \^,
               "powers of submodules",
               [ IsGradedLeftSubmoduleForCAP, IsInt ],
  function( left_submodule, power )
    local submodule_power, presentation, generators, range, range_presentation, embedding, i;
    
    if not ( power > 0 ) then
    
      return Error( "The power must be non-negative! \n" );
    
    elif power = 0 then
    
      # construct identity_submodule
      submodule_power := rec();
      range := Range( UnderlyingMorphism( Range( EmbeddingInSuperObjectForCAP( left_submodule ) ) ) );
      presentation := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      generators := EntriesOfHomalgMatrixAsListList( 
                                     HomalgIdentityMatrix( Rank( range ), HomalgGradedRing( left_submodule ) ) );
      embedding := CAPPresentationCategoryMorphism( presentation, IdentityMorphism( range ), presentation );
      ObjectifyWithAttributes( submodule_power, TheTypeOfGradedLeftSubmoduleForCAP,
                             PresentationForCAP, presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( left_submodule ),
                             EmbeddingInSuperObjectForCAP, embedding 
                             );
      
      # and return this submodule
      return submodule_power;

    else
    
      submodule_power := left_submodule;
      for i in [ 2 .. power ] do
      
        submodule_power := submodule_power * left_submodule;
      
      od;

      return submodule_power;
    
    fi;

end );


# for convenience allow "*" to indicate the (tensor) product on right submodules
InstallMethod( \*,
               "powers of submodules",
               [ IsGradedRightSubmoduleForCAP, IsGradedRightSubmoduleForCAP ],
  function( right_submodule1, right_submodule2 )
    local new_presentation, new_embedding, generators, range, new_graded_right_submodule;
    
    # check that the homalg_graded_rings are identical
    if not IsIdenticalObj( HomalgGradedRing( right_submodule1 ), HomalgGradedRing( right_submodule2 ) ) then
    
      return Error( "The submodules have to be defined over the same graded ring. \n" );
    
    fi;
    
    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( right_submodule1 ), 
                                                PresentationForCAP( right_submodule2 ) 
                                               );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( new_embedding ) );
    
    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject(
                         ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation, new_embedding, range );
    
    # now compute the new submodule
    new_graded_right_submodule := rec( );
    ObjectifyWithAttributes( new_graded_right_submodule, TheTypeOfGradedRightSubmoduleForCAP,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( right_submodule1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_right_submodule;

end );


# for convenience allow "^" to indicate the n-th (tensor) power of left ideals
InstallMethod( \^,
               "powers of submodules",
               [ IsGradedRightSubmoduleForCAP, IsInt ],
  function( right_submodule, power )
    local submodule_power, presentation, generators, range, range_presentation, embedding, i;
    
    if not ( power > 0 ) then
    
      return Error( "The power must be non-negative! \n" );
    
    elif power = 0 then
    
      # construct identity_submodule
      submodule_power := rec();
      range := Range( UnderlyingMorphism( Range( EmbeddingInSuperObjectForCAP( right_submodule ) ) ) );
      presentation := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      generators := EntriesOfHomalgMatrixAsListList( 
                                     HomalgIdentityMatrix( Rank( range ), HomalgGradedRing( right_submodule ) ) );
      embedding := CAPPresentationCategoryMorphism( presentation, IdentityMorphism( range ), presentation );
      ObjectifyWithAttributes( submodule_power, TheTypeOfGradedRightSubmoduleForCAP,
                             PresentationForCAP, presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( right_submodule ),
                             EmbeddingInSuperObjectForCAP, embedding 
                             );
      
      # and return this submodule
      return submodule_power;

    else
    
      submodule_power := right_submodule;
      for i in [ 2 .. power ] do
      
        submodule_power := submodule_power * right_submodule;
      
      od;

      return submodule_power;
    
    fi;

end );


##############################################################################################
##
#! @Section Frobenius powers for submodules
##
##############################################################################################

# Frobenius power of left ideals
InstallMethod( FrobeniusPower,
               "n-th Frobenius powers of ideals",
               [ IsGradedLeftSubmoduleForCAP, IsInt ],
  function( left_submodule, power )
    local generator_matrix;
    
    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( [ Generators( left_submodule ) ], HomalgGradedRing( left_submodule ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );
    
    # then return the associated ideal
    return GradedLeftSubmoduleForCAP( 
                   EntriesOfHomalgMatrixAsListList( generator_matrix ), HomalgGradedRing( left_submodule ) );

end );

# Frobenius power of right ideals
InstallMethod( FrobeniusPower,
               "n-th Frobenius powers of ideals",
               [ IsGradedRightSubmoduleForCAP, IsInt ],
  function( right_submodule, power )
    local generator_matrix;
    
    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( [ Generators( right_submodule ) ], HomalgGradedRing( right_submodule ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );
    
    # then return the associated ideal
    return GradedLeftSubmoduleForCAP( EntriesOfHomalgMatrix( generator_matrix ), HomalgGradedRing( right_submodule ) );

end );