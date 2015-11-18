#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Tools
##
#############################################################################


####################################################################################
##
##  Section Tools to make GradedModulePresentationsForCAP more useable
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
    return CAPPresentationCategoryObject( pres, CapCategory( pres ) );

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
    return CAPPresentationCategoryObject( pres, CapCategory( pres ) );

end );
