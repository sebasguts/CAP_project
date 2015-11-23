#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Graded ideals of a graded ring as graded left or right presentations
##
#############################################################################


##############################################################################################
##
## Section GAP category of graded ideals for CAP
##
##############################################################################################

# install graded left ideals for CAP
DeclareRepresentation( "IsGradedLeftIdealForCAPRep",
                       IsGradedLeftIdealForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedLeftIdealsForCAP",
            NewFamily( "TheFamilyOfGradedLeftIdealsForCAP" ) );

BindGlobal( "TheTypeOfGradedLeftIdealForCAP",
            NewType( TheFamilyOfGradedLeftIdealsForCAP,
                     IsGradedLeftIdealForCAPRep ) );

# install graded right ideals for CAP
DeclareRepresentation( "IsGradedRightIdealForCAPRep",
                       IsGradedRightIdealForCAP and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfGradedRightIdealsForCAP",
            NewFamily( "TheFamilyOfGradedRightIdealsForCAP" ) );

BindGlobal( "TheTypeOfGradedRightIdealForCAP",
            NewType( TheFamilyOfGradedRightIdealsForCAP,
                     IsGradedRightIdealForCAPRep ) );



##############################################################################################
##
#! @Section Constructors for graded ideals
##
##############################################################################################

# constructor for graded left-ideals
InstallMethod( GradedLeftIdealForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               
    local graded_left_ideal, matrix, range, alpha, pres, embedding;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    elif Length( generator_list ) = 0 then
    
      # the zero module is to be considered as an ideal

      # define the zero modules as ideal
      graded_left_ideal := rec( );
      pres := ZeroMorphism( ZeroObject( CAPCategoryOfProjectiveGradedLeftModules( homalg_graded_ring ) ), 
                            ZeroObject( CAPCategoryOfProjectiveGradedLeftModules( homalg_graded_ring ) ) );
      pres := CAPPresentationCategoryObject( pres );
      range := CAPCategoryOfProjectiveGradedLeftModulesObject( 
                              [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 1 ] ],                                                              
                              homalg_graded_ring 
                            );
      embedding := ZeroMorphism( ZeroObject( CAPCategoryOfProjectiveGradedLeftModules( homalg_graded_ring ) ),
                                 range 
                                );
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, embedding, range );
      ObjectifyWithAttributes( graded_left_ideal, TheTypeOfGradedLeftIdealForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # and return the result
      return graded_left_ideal;
      
    fi;

    # check if a list of lists or just a lists has been given to us
    # then react to it
    # this is purely for user convenience
    if IsList( generator_list[ 1 ] ) and not IsString( generator_list[ 1 ] ) then
    
      # construct the graded module morphism encoded by 'generator_list'
      matrix := HomalgMatrix( generator_list, homalg_graded_ring );
        
    else
    
      # construct the graded module morphism encoded by 'generator_list'
      matrix := HomalgMatrix( TransposedMat( [ generator_list ] ), homalg_graded_ring );
    
    fi;

    # now compute the range
    range := CAPCategoryOfProjectiveGradedLeftModulesObject( 
                              [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 1 ] ],                                                              
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
    
    # now define graded_left_ideal
    graded_left_ideal := rec( );
    ObjectifyWithAttributes( graded_left_ideal, TheTypeOfGradedLeftIdealForCAP,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                           );

    # finally return this ideal
    return graded_left_ideal;

end );

# constructor for graded right-ideals
InstallMethod( GradedRightIdealForCAP,
               " a list of generators and a homalg graded ring",
               [ IsList, IsHomalgGradedRing ],
  function( generator_list, homalg_graded_ring )               
    local graded_right_ideal, matrix, range, alpha, pres, embedding;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    elif Length( generator_list ) = 0 then
    
      # the zero module is to be considered as an ideal

      # define the zero modules as ideal
      graded_right_ideal := rec( );
      pres := ZeroMorphism( ZeroObject( CAPCategoryOfProjectiveGradedRightModules( homalg_graded_ring ) ), 
                            ZeroObject( CAPCategoryOfProjectiveGradedRightModules( homalg_graded_ring ) ) );
      pres := CAPPresentationCategoryObject( pres );
      range := CAPCategoryOfProjectiveGradedRightModulesObject( 
                              [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 1 ] ],                                                              
                              homalg_graded_ring 
                            );
      embedding := ZeroMorphism( ZeroObject( CAPCategoryOfProjectiveGradedRightModules( homalg_graded_ring ) ),
                                 range
                                );
      range := CAPPresentationCategoryObject( ZeroMorphism( ZeroObject( CapCategory( range ) ), range ) );
      embedding := CAPPresentationCategoryMorphism( pres, embedding, range );
      ObjectifyWithAttributes( graded_right_ideal, TheTypeOfGradedRightIdealForCAP,
                               PresentationForCAP, pres,
                               Generators, generator_list,
                               HomalgGradedRing, homalg_graded_ring,
                               EmbeddingInSuperObjectForCAP, embedding,
                               SuperObjectForCAP, Range( embedding )
                             );

      # and return the result
      return graded_right_ideal;
      
    fi;

    # check if a list of lists or just a lists has been given to us
    # then react to it
    # this is purely for user convenience
    if IsList( generator_list[ 1 ] ) and not IsString( generator_list[ 1 ] ) then
    
      # construct the graded module morphism encoded by 'generator_list'
      matrix := HomalgMatrix( generator_list, homalg_graded_ring );
        
    else
    
      # construct the graded module morphism encoded by 'generator_list'
      matrix := HomalgMatrix( [ generator_list ], homalg_graded_ring );
    
    fi;
    
    # now compute the range
    range := CAPCategoryOfProjectiveGradedRightModulesObject( 
                       [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 1 ] ],
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
    graded_right_ideal := rec( );
    ObjectifyWithAttributes( graded_right_ideal, TheTypeOfGradedRightIdealForCAP,
                             PresentationForCAP, pres,
                             Generators, generator_list,
                             HomalgGradedRing, homalg_graded_ring,
                             EmbeddingInSuperObjectForCAP, embedding,
                             SuperObjectForCAP, Range( embedding )
                             );

    # finally return this ideal
    return graded_right_ideal;

end );



################################################
##
## Section String methods for the new categories
##
################################################

InstallMethod( String,
              [ IsGradedLeftIdealForCAP ],
  function( graded_left_ideal )
    
     return Concatenation( "A graded left ideal in ", RingName( HomalgGradedRing( graded_left_ideal ) ) );

end );

InstallMethod( String,
              [ IsGradedRightIdealForCAP ],
  function( graded_right_ideal )
    
     return Concatenation( "A graded right ideal in ", RingName( HomalgGradedRing( graded_right_ideal ) ) );

end );



#################################################
##
## Section Display methods for the new categories
##
#################################################

InstallMethod( Display,
              [ IsGradedLeftIdealForCAP ],
  function( graded_left_ideal )
    
     Print( Concatenation( "A graded left ideal in ", 
                           RingName( HomalgGradedRing( graded_left_ideal ) ),
                           " generated by ",
                           String( Generators( graded_left_ideal ) )
                          ) 
                        );

end );

InstallMethod( Display,
              [ IsGradedRightIdealForCAP ],
  function( graded_right_ideal )
    
     Print( Concatenation( "A graded right ideal in ", 
                           RingName( HomalgGradedRing( graded_right_ideal ) ),
                           " generated by ",
                           String( Generators( graded_right_ideal ) )
                          ) 
                        );

end );



#################################################
##
## Section ViewObj methods for the new categories
##
#################################################

InstallMethod( ViewObj,
              [ IsGradedLeftIdealForCAP ],
  function( graded_left_ideal )

    Print( Concatenation( "<", String( graded_left_ideal ), ">" ) );

end );

InstallMethod( ViewObj,
              [ IsGradedRightIdealForCAP ],
  function( graded_right_ideal )

    Print( Concatenation( "<", String( graded_right_ideal ), ">" ) );

end );



##############################################################################################
##
#! @Section Ideal powers
##
##############################################################################################


# for convenience allow "*" to indicate the (tensor) product on left ideals
InstallMethod( \*,
               "powers of ideals",
               [ IsGradedLeftIdealForCAP, IsGradedLeftIdealForCAP ],
  function( left_ideal1, left_ideal2 )
    local new_presentation, new_embedding, generators, range, new_graded_left_ideal;
    
    # check that the homalg_graded_rings are identical
    if not IsIdenticalObj( HomalgGradedRing( left_ideal1 ), HomalgGradedRing( left_ideal2 ) ) then
    
      return Error( "The ideals have to be defined in the same graded ring. \n" );
    
    fi;
    
    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( left_ideal1 ), PresentationForCAP( left_ideal2 ) );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrix( UnderlyingHomalgMatrix( new_embedding ) );
    
    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject(
                         ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation, new_embedding, range );
    
    # now compute the new ideal
    new_graded_left_ideal := rec( );
    ObjectifyWithAttributes( new_graded_left_ideal, TheTypeOfGradedLeftIdealForCAP,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( left_ideal1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_left_ideal;
  
end );


# for convenience allow "^" to indicate the n-th (tensor) power of left ideals
InstallMethod( \^,
               "powers of ideals",
               [ IsGradedLeftIdealForCAP, IsInt ],
  function( left_ideal, power )
    local ideal_power, i;
    
    if not ( power > 0 ) then
    
      return Error( "The power must be non-negative! \n" );
    
    elif power = 0 then
    
      return GradedLeftIdealForCAP( [ 1 ], HomalgGradedRing( left_ideal ) );
    
    else
    
      ideal_power := left_ideal;
      for i in [ 2 .. power ] do
      
        ideal_power := ideal_power * left_ideal;
      
      od;

      return ideal_power;
    
    fi;

end );
  

# for convenience allow "*" to indicate the (tensor) product on right ideals
InstallMethod( \*,
               "powers of ideals",
               [ IsGradedRightIdealForCAP, IsGradedRightIdealForCAP ],
  function( right_ideal1, right_ideal2 )
    local new_presentation, new_embedding, generators, range, new_graded_right_ideal;
    
    # check that the homalg_graded_rings are identical
    if not IsIdenticalObj( HomalgGradedRing( right_ideal1 ), HomalgGradedRing( right_ideal2 ) ) then
    
      return Error( "The ideals have to be defined in the same graded ring. \n" );
    
    fi;
    
    # compute the new_presentation and the new_embedding
    new_presentation := TensorProductOnObjects( PresentationForCAP( right_ideal1 ), PresentationForCAP( right_ideal2 ) );
    new_embedding := CokernelProjection( UnderlyingMorphism( new_presentation ) );

    # extract the entries of the embedding matrix to identify the generators
    generators := EntriesOfHomalgMatrix( UnderlyingHomalgMatrix( new_embedding ) );
    
    # compute the range and thereby compute the embedding properly
    range := CAPPresentationCategoryObject( 
                           ZeroMorphism( ZeroObject( CapCategory( Range( new_embedding ) ) ), Range( new_embedding ) ) );
    new_embedding := CAPPresentationCategoryMorphism( new_presentation, new_embedding, range );
    
    # now compute the new ideal
    new_graded_right_ideal := rec( );
    ObjectifyWithAttributes( new_graded_right_ideal, TheTypeOfGradedRightIdealForCAP,
                             PresentationForCAP, new_presentation,
                             Generators, generators,
                             HomalgGradedRing, HomalgGradedRing( right_ideal1 ),
                             EmbeddingInSuperObjectForCAP, new_embedding 
                             );

    # finally return this object
    return new_graded_right_ideal;
  
end );


# for convenience allow "^" to indicate the n-th (tensor) power of right ideals
InstallMethod( \^,
               "powers of ideals",
               [ IsGradedRightIdealForCAP, IsInt ],
  function( right_ideal, power )
    local ideal_power, i;
    
    if not ( power > 0 ) then
    
      return Error( "The power must be non-negative! \n" );
    
    elif power = 0 then
    
      return GradedRightIdealForCAP( [ 1 ], HomalgGradedRing( right_ideal ) );
    
    else
    
      ideal_power := right_ideal;
      for i in [ 2 .. power ] do
      
        ideal_power := ideal_power * right_ideal;
      
      od;
    
      return ideal_power;
    
    fi;

end );



##############################################################################################
##
#! @Section Frobenius powers for ideals
##
##############################################################################################

# Frobenius power of left ideals
InstallMethod( FrobeniusPower,
               "n-th Frobenius powers of ideals",
               [ IsGradedLeftIdealForCAP, IsInt ],
  function( left_ideal, power )
    local generator_matrix;
    
    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( [ Generators( left_ideal ) ], HomalgGradedRing( left_ideal ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );
    
    # then return the associated ideal
    return GradedLeftIdealForCAP( EntriesOfHomalgMatrix( generator_matrix ), HomalgGradedRing( left_ideal ) );

end );

# Frobenius power of right ideals
InstallMethod( FrobeniusPower,
               "n-th Frobenius powers of ideals",
               [ IsGradedRightIdealForCAP, IsInt ],
  function( right_ideal, power )
    local generator_matrix;
    
    # extract the generators and take their individual powers via "FrobeniusPowerOfMatrix"
    generator_matrix := HomalgMatrix( [ Generators( right_ideal ) ], HomalgGradedRing( right_ideal ) );
    generator_matrix := FrobeniusPowerOfMatrix( generator_matrix, power );
    
    # then return the associated ideal
    return GradedLeftIdealForCAP( EntriesOfHomalgMatrix( generator_matrix ), HomalgGradedRing( right_ideal ) );

end );