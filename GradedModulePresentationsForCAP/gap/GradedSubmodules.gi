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
#! @Section Constructors for graded submodules from a list list and a graded ring
##
##############################################################################################

# compute graded submodules from morphisms of projective modules
InstallGlobalFunction( GradedSubmoduleFromListListAndGradedRing,
  function( generator_list, homalg_graded_ring, left )
    local graded_submodule, matrix, range, alpha, pres, embedding, type;
    
    if not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    fi;

    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrColumns( matrix ) = 1 and left then
    
      return GradedLeftIdealForCAP( generator_list, homalg_graded_ring );
    
    elif NrRows( matrix ) = 1 and not left then
    
      return GradedRightIdealForCAP( generator_list, homalg_graded_ring );
    
    fi;
      
    # construct the range and alpha
    if left then
      range := CAPCategoryOfProjectiveGradedLeftModulesObject(
                         [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrColumns( matrix ) ] ],
                         homalg_graded_ring
                         );
      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );
    else
      range := CAPCategoryOfProjectiveGradedRightModulesObject(
                         [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), NrRows( matrix ) ] ],
                         homalg_graded_ring
                         );
      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );                         
    fi;
    
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
    graded_submodule := rec( );
    if left then
      type := TheTypeOfGradedLeftSubmoduleForCAP;
    else
      type := TheTypeOfGradedRightSubmoduleForCAP;
    fi;
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                            );

    # finally return this submodule
    return graded_submodule;

end );

# constructor for graded left submodules
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               
  
    return GradedSubmoduleFromListListAndGradedRing( generator_list, homalg_graded_ring, true );

end );


# constructor for graded right-ideals
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               

    return GradedSubmoduleFromListListAndGradedRing( generator_list, homalg_graded_ring, false );

end );



###############################################################################################
##
#! @Section Constructors for graded submodules from a list of lists and a specified superobject
##
###############################################################################################

# a function that computes a graded submodule from a list of generators and a specified superobject
InstallGlobalFunction( GradedSubmoduleFromListListAndGivenRange,
  function( generator_list, range, left )
    local homalg_graded_ring, graded_submodule, matrix, alpha, pres, embedding, type;
    
    # extract the graded ring
    homalg_graded_ring := UnderlyingHomalgGradedRing( range );
    
    # construct the graded module morphism encoded by 'generator_list'
    matrix := HomalgMatrix( generator_list, homalg_graded_ring );
    
    # check if we are dealing with an ideal
    if NrColumns( matrix ) = 1 and left then
    
      return GradedLeftIdealForCAP( generator_list, range );
    
    elif NrRows( matrix ) = 1 and not left then
    
      return GradedRightIdealForCAP( generator_list, range );
    
    fi;
      
    # now define alpha
    if left then
      alpha := DeduceMapFromMatrixAndRangeLeft( matrix, range );
    else
      alpha := DeduceMapFromMatrixAndRangeRight( matrix, range );
    fi;
    
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
    graded_submodule := rec( );
    if left then
      type := TheTypeOfGradedLeftSubmoduleForCAP;
    else
      type := TheTypeOfGradedRightSubmoduleForCAP;
    fi;
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                            );

      # finally return this submodule
      return graded_submodule;  

end );

# constructor for graded right submodules with given range
InstallMethod( GradedLeftSubmoduleForCAP,
               " a list of generators and a projective graded left module",
               [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ],
  function( generator_list, range )               

    return GradedSubmoduleFromListListAndGivenRange( generator_list, range, true );

end );

# constructor for graded right submodules with given range
InstallMethod( GradedRightSubmoduleForCAP,
               " a list of generators and a projective graded right module",
               [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ],
  function( generator_list, range )               

    return GradedSubmoduleFromListListAndGivenRange( generator_list, range, false );

end );



##############################################################################################
##
#! @Section Constructors for graded submodules from a morphism
##
##############################################################################################

# compute graded submodules from morphisms of projective modules
InstallGlobalFunction( GradedSubmoduleFromMorphism,
  function( alpha, left )
    local pres, range, embedding, graded_submodule, type;

    # check if we are dealing with an ideal
    if Rank( Range( alpha ) ) = 1 and left then
      
      return GradedLeftIdealForCAP( alpha );
    
    elif Rank( Range( alpha ) ) = 1 and not left then
      
      return GradedRightIdealForCAP( alpha );

    fi;
    
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
    range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( alpha ) ), Range( alpha ) ) );
    embedding := CAPPresentationCategoryMorphism( pres, alpha, range );
    
    # now define graded_left_submodule
    graded_submodule := rec( );
    if left then
      type := TheTypeOfGradedLeftSubmoduleForCAP;
    else
      type := TheTypeOfGradedRightSubmoduleForCAP;
    fi;
    ObjectifyWithAttributes( graded_submodule, type,
                             PresentationForCAP, pres,
                             Generators, EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( alpha ) ),
                             HomalgGradedRing, UnderlyingHomalgGradedRing( alpha ),
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                             );

    # finally return this submodule
    return graded_submodule;  

end );

InstallMethod( GradedLeftSubmoduleForCAP,
               " a morphism of projective graded right modules ",
               [ IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ],
  function( alpha )

    return GradedSubmoduleFromMorphism( alpha, true );

end );

InstallMethod( GradedRightSubmoduleForCAP,
               " a morphism of projective graded right modules ",
               [ IsCAPCategoryOfProjectiveGradedRightModulesMorphism ],
  function( alpha )

    return GradedSubmoduleFromMorphism( alpha, false );

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
#! @Section Full information of a submodule
##
##############################################################################################

InstallMethod( FullInformation,
               " for an ideal ",
               [ IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule )
  
    return FullInformation( PresentationForCAP( submodule ) );
  
end );



##############################################################################################
##
#! @Section Submodule powers
##
##############################################################################################


# for convenience allow "*" to indicate the (tensor) product on left submodules
InstallMethod( \*,
               "powers of submodules",
               [ IsGradedLeftOrRightSubmoduleForCAP, IsGradedLeftOrRightSubmoduleForCAP ],
  function( submodule1, submodule2 )
    local left1, left2, new_presentation, new_embedding, generators, range, new_graded_submodule, type;
    
    # check that the homalg_graded_rings are identical
    left1 := IsGradedLeftSubmoduleForCAP( submodule1 );
    left2 := IsGradedLeftSubmoduleForCAP( submodule2 );    
    if not IsIdenticalObj( HomalgGradedRing( submodule1 ), HomalgGradedRing( submodule2 ) ) then
    
      return Error( "The submodules have to be defined over the same graded ring. \n" );
    
    elif left1 <> left2 then
    
      return Error( "The submodules must be either both left submodules or both right submodules. \n" );
    
    fi;
    
    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( submodule1 ), 
                                                PresentationForCAP( submodule2 ) 
                                               );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrixAsListList( UnderlyingHomalgMatrix( new_embedding ) );
    
    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject(
                         ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation, new_embedding, range );
    
    # now compute the new submodule
    new_graded_submodule := rec( );
    if left1 then
      type := TheTypeOfGradedLeftSubmoduleForCAP;
    else
      type := TheTypeOfGradedRightSubmoduleForCAP;
    fi;
    ObjectifyWithAttributes( new_graded_submodule, type,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( submodule1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_submodule;

end );


# for convenience allow "^" to indicate the n-th (tensor) power of left ideals
InstallMethod( \^,
               "powers of submodules",
               [ IsGradedLeftOrRightSubmoduleForCAP, IsInt ],
  function( submodule, power )
    local submodule_power, presentation, generators, range, range_presentation, embedding, type, i;
    
    if not ( power > 0 ) then
    
      return Error( "The power must be non-negative! \n" );
    
    elif power = 0 then
    
      # construct identity_submodule
      submodule_power := rec();
      range := Range( UnderlyingMorphism( Range( EmbeddingInSuperObjectForCAP( submodule ) ) ) );
      presentation := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      generators := EntriesOfHomalgMatrixAsListList( 
                                     HomalgIdentityMatrix( Rank( range ), HomalgGradedRing( submodule ) ) );
      embedding := CAPPresentationCategoryMorphism( presentation, IdentityMorphism( range ), presentation );
      if IsGradedLeftSubmoduleForCAP( submodule ) then
        type := TheTypeOfGradedLeftSubmoduleForCAP;
      else
        type := TheTypeOfGradedRightSubmoduleForCAP;
      fi;
      ObjectifyWithAttributes( submodule_power, type,
                             PresentationForCAP, presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( submodule ),
                             EmbeddingInSuperObjectForCAP, embedding 
                             );
      
      # and return this submodule
      return submodule_power;

    else
    
      submodule_power := submodule;
      for i in [ 2 .. power ] do
      
        submodule_power := submodule_power * submodule;
      
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
               [ IsGradedLeftOrRightSubmoduleForCAP, IsInt ],
  function( submodule, power )
    local generator_matrix;
    
    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( [ Generators( submodule ) ], HomalgGradedRing( submodule ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );
    
    # then return the associated ideal
    if IsGradedLeftSubmoduleForCAP( submodule ) then
      return GradedLeftSubmoduleForCAP( 
                   EntriesOfHomalgMatrixAsListList( generator_matrix ), HomalgGradedRing( submodule ) );
    else
      return GradedRightSubmoduleForCAP( 
                   EntriesOfHomalgMatrixAsListList( generator_matrix ), HomalgGradedRing( submodule ) );
    fi;

end );