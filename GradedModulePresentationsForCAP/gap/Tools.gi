####################################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Tools
##
####################################################################################


####################################################################################
##
#! @Section Submodule presentations
##
####################################################################################

# represent ideal of graded ring as graded left-presentation
InstallMethod( SubmoduleAsGradedLeftModulePresentation,
               "for a list and a homalg graded ring",    
               [ IsList, IsHomalgGradedRing ],
  function( list, homalg_graded_ring )
    local matrix, range, alpha, pres;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    fi;

    # construct the range of this map
    matrix := HomalgMatrix( list, homalg_graded_ring );
    range := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 
                                                              NrColumns( matrix ) ] ],
                                                         homalg_graded_ring );
    
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
    pres := KernelEmbedding( alpha );
    
    # and return pres considered as presentation
    return CAPPresentationCategoryObject( pres );

end );

# represent ideal of graded ring as graded left-presentation
InstallMethod( SubmoduleAsGradedRightModulePresentation,
               "for a list and a homalg graded ring",    
               [ IsList, IsHomalgGradedRing ],
  function( list, homalg_graded_ring )
    local matrix, range, alpha, pres;
    
    # check for valid input
    if not IsHomalgGradedRing( homalg_graded_ring ) then
    
      return Error( "The ring must be graded! \n" );
    
    elif not IsFree( DegreeGroup( homalg_graded_ring ) ) then
    
      return Error( "Currently this operation is only defined for rings with a free degree_group. \n" );
    
    fi;

    # construct the range of this map
    matrix := HomalgMatrix( list, homalg_graded_ring );
    range := CAPCategoryOfProjectiveGradedRightModulesObject( [ [ TheZeroElement( DegreeGroup( homalg_graded_ring ) ), 
                                                              NrRows( matrix ) ] ],
                                                         homalg_graded_ring );
    
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
    pres := KernelEmbedding( alpha );
    
    # and return pres considered as presentation
    return CAPPresentationCategoryObject( pres );

end );



####################################################################################
##
##  Section Frobenius powers of presentations
##
####################################################################################

# Frobenius power of a matrix
InstallGlobalFunction( FrobeniusPowerOfMatrix,
  function( matrix, power )
    local new_mapping_matrix, i, j;
    
    # check the input
    if not IsHomalgMatrix( matrix ) then
    
      return Error( "The first argument must be a homalg matrix! \n" );
    
    elif not IsInt( power ) then
    
      return Error( "The power must be a non-negative integer! \n" );
      
    elif power < 0 then
    
      return Error( "The power must be a non-negative integer! \n" );
    
    fi;
    
    # now compute the Frobenius power
    new_mapping_matrix := EntriesOfHomalgMatrixAsListList( matrix );
    
    for i in [ 1 .. Length( new_mapping_matrix ) ] do
      
      for j in [ 1 .. Length( new_mapping_matrix[ i ] ) ] do
      
        new_mapping_matrix[ i ][ j ] := new_mapping_matrix[ i ][ j ]^power;
      
      od;
      
    od;
    
    # and return the result
    return HomalgMatrix( new_mapping_matrix, HomalgRing( matrix ) );

end );

# install Frobenius power of a module presentation
InstallMethod( FrobeniusPower,
               "Frobenius powers of presentation",
               [ IsCAPPresentationCategoryObject, IsInt ],
  function( presentation_object, power )
    local left, embedding, range, matrix, new_mapping_matrix, i, j, alpha;

    if power < 0 then

      return Error( "The power must be non-negative! \n" );

    #elif power = 0 then
     
      # determine if we are dealing with left or right presentation
      #left :=  IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_object ) );
          
      # now construct the truncated module "0 -> S" with S = homalg_graded_ring
      #if left then
              
        #alpha := ZeroMorphism( ZeroObject( CapCategory( UnderlyingMorphism( presentation_object ) ) ),
        #                       CokernelObject( UnderlyingMorphism( presentation_object ) )
        #                      );
        #return CAPPresentationCategoryObject( alpha );
      
      #else

        #alpha := ZeroMorphism( ZeroObject( CapCategory( UnderlyingMorphism( presentation_object ) ) ),
        #                       CokernelObject( UnderlyingMorphism( presentation_object ) )
        #                      );
        #return CAPPresentationCategoryObject( alpha );
        
      #fi;
      
    elif power = 1 then
    
      return presentation_object;
      
    else
    
      # determine if we are dealing with left or right presentation
      left :=  IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_object ) );
    
      # look at the following diagram
      # R_A                    0
      #  |                     |
      # alpha                  |
      #  |                     |
      #  v                     v
      #  A -- matrix --> projective_module
      #
      # alpha = presentation_object and we can compute the embedding into the projective module.
    
      # We compute the matrix from "EmbeddingInProjectiveModule". 
      # Then we power all entries of this matrix by power (<-> Frobenius power).
      # Then we deduce from this a mapping with range "projective_module" but in general new source.
      # Subsequently we compute the kernel embedding of this map.
      # Finally we turn this kernel embedding into a presentation_category_object and return it.
    
      # compute the matrix
      embedding := EmbeddingInProjectiveObject( presentation_object );
      range := Range( UnderlyingMorphism( embedding ) );
      matrix := UnderlyingHomalgMatrix( UnderlyingMorphism( embedding ) );
    
      # now compute the power of the mapping matrix
      new_mapping_matrix := FrobeniusPowerOfMatrix( matrix, power );

      # compute alpha
      if left then
    
        alpha := KernelEmbedding( DeduceMapFromMatrixAndRangeLeft( new_mapping_matrix, range ) );
    
      else
    
        alpha := KernelEmbedding( DeduceMapFromMatrixAndRangeRight( new_mapping_matrix, range ) );
    
      fi;
            
      # and return the corresponding object in the presentation category
      return CAPPresentationCategoryObject( alpha );

    fi;
      
end );


# install Frobenius power of a module presentation morphism
InstallMethod( FrobeniusPower,
               "Frobenius powers of presentation morphism",
               [ IsCAPPresentationCategoryMorphism, IsInt ],
  function( presentation_morphism, power )
    local left, i1, i1_matrix, i1_matrix_frob_power, frob_power_i1, i2, i2_matrix ,i2_matrix_frob_power, frob_power_i2,
         mu_prime, mu_prime_prime, new_source, new_range;
    
    # look at the following diagram:
    # R_A                              R_B
    #  |                    		|
    # alpha                	       beta
    #  |                    		|
    #  v                    		v
    #  A -------------- mu -----------> B
    #  |                    		|
    #  i1                   	        i2
    #  |                    		|
    #  V                    		v
    # X_A ------------ mu' ----------> X_B
    #  ^                    		^
    #  |                    		|
    # FrobPower( i1 )     	   FrobPower( i2 )
    #  |                    		|
    #  A'------------  mu'' ----------> B'
    #  ^                    		^
    #  |                    		|
    # Ker( FrobPower( i1 )) 	Ker( FrobPower( i2 ) )
    #  |                    		|
    # R_A'                 		R_B'
    #
    # The presentation morphism mu is the input and has alpha, beta as source and range respectively.
    #
    # In this diagram i1 and i2 are the respective 'EmbeddingInProjectiveModule', which happen to be the cokernel mappings
    # of alpha and beta. Therefore we can compute the induced mapping mu' between the cokernel modules.
    #
    # The lower half of the diagram then describes the probenius powers of source and range of mu. We then compute mu''
    # from FrobPower( i1), mu' and FrobPower( i2 ) via a (co)lift.
    
    # are we working with left or right presentations?
    left := IsCAPCategoryOfProjectiveGradedLeftModulesMorphism( UnderlyingMorphism( presentation_morphism ) );
    
    # compute i1, FrobPower( i1 ), i2, FrobPower( i2 )
    i1 := CokernelProjection( UnderlyingMorphism( Source( presentation_morphism ) ) );
    i1_matrix := UnderlyingHomalgMatrix( i1 );
    i1_matrix_frob_power := FrobeniusPowerOfMatrix( i1_matrix, power );
    
    if left then
      frob_power_i1 := DeduceMapFromMatrixAndRangeLeft( i1_matrix_frob_power, Range( i1 ) );
    else
      frob_power_i1 := DeduceMapFromMatrixAndRangeRight( i1_matrix_frob_power, Range( i1 ) );
    fi;
    
    i2 := CokernelProjection( UnderlyingMorphism( Range( presentation_morphism ) ) );
    i2_matrix := UnderlyingHomalgMatrix( i2 );
    i2_matrix_frob_power := FrobeniusPowerOfMatrix( i2_matrix, power );

    if left then
      frob_power_i2 := DeduceMapFromMatrixAndRangeLeft( i2_matrix_frob_power, Range( i2 ) );
    else
      frob_power_i2 := DeduceMapFromMatrixAndRangeRight( i2_matrix_frob_power, Range( i2 ) );
    fi;
    
    # compute mu' and mu''
    mu_prime := Colift( i1, PreCompose( UnderlyingMorphism( presentation_morphism ), i2 ) );
    mu_prime_prime := Lift( PreCompose( frob_power_i1, mu_prime ), frob_power_i2 );
    
    # compute kernel embeddings and corresponding objects
    new_source := CAPPresentationCategoryObject( KernelEmbedding( frob_power_i1 ) );
    new_range := CAPPresentationCategoryObject( KernelEmbedding( frob_power_i2 ) );
    
    # and return the final morphism
    return CAPPresentationCategoryMorphism( new_source, mu_prime_prime, new_range );

end );