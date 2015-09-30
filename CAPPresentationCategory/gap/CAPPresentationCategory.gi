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
  
    # (1) methods to check if objects/morphisms are well-defined
    # (1) methods to check if objects/morphisms are well-defined
    AddIsWellDefinedForObjects( category,
      
      function( object )
        
        return IsWellDefinedForMorphisms( UnderlyingMorphism( object ) );
        
    end );
        
    AddIsWellDefinedForMorphisms( category,
      
      function( morphism )
        
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
                       PreCompose( UnderlyingMorphism( Source( morphism ) ), UnderlyingMorphism( morphism ) ) ) = fail then
        
          # there is no such lift, thus the mapping is not well-defined
          return false;
        
        fi;
        
        # otherwise all checks have been passed, so return true        
        return true;
        
    end );    


    # (2) implement elementary operations for categories
    # (2) implement elementary operations for categories
    
    # implement equality for objects and morphisms
    AddIsEqualForObjects( category,
                   
      function( object1, object2 )
        
        return IsEqualForMorphismsOnMor( UnderlyingMorphism( object1 ), UnderlyingMorphism( object2 ) );
        
    end );

    AddIsEqualForMorphisms( category,
    
      function( morphism_1, morphism_2 )
        
        return IsEqualForMorphismsOnMor( UnderlyingMorphism( morphism_1 ), UnderlyingMorphism( morphism_2 ) );
        
    end );

    # implement congruence of morphisms
    AddIsCongruentForMorphisms( category,
                            
      function( morphism1, morphism2 )
        local lift, difference;
        
        difference := AdditionForMorphisms( AdditiveInverseForMorphisms( UnderlyingMorphism( morphism2 ) ), 
                                                                                           UnderlyingMorphism( morphism1 ) );
        lift := Lift( UnderlyingMorphism( Range( morphism1 ) ), difference );
        
        # if the lift exists, then the morphisms are congruent, so
        if lift = fail then
        
          return false;
          
        else
        
          return true;
          
        fi;
        
    end );    
    
    # implement PreCompose    
    AddPreCompose( category,
                   
      function( left_morphism, right_morphism )
        
        return CAPPresentationCategoryMorphism( 
                                     Source( left_morphism ), 
                                     PreCompose( UnderlyingMorphism( left_morphism ), UnderlyingMorphism( right_morphism ) ),
                                     Range( right_morphism ) );
        
    end );

    # identity morphism for objects
    AddIdentityMorphism( category,
                         
      function( object )
        
        return CAPPresentationCategoryMorphism( object, IdentityMorphism( Range( UnderlyingMorphism( object ) ) ), object );
        
    end );
    
    # (3) enrich with additive structure
    # (3) enrich with additive structure
    
    # group structure for morphisms
    AddAdditionForMorphisms( category,
                             
      function( morphism1, morphism2 )
        
        return CAPPresentationCategoryMorphism( 
                                    Source( morphism1 ), 
                                    AdditionForMorphisms( UnderlyingMorphism( morphism1 ), UnderlyingMorphism( morphism2 ) ),
                                    Range( morphism2 ) 
                                    );
                                     
    end );
    
    AddAdditiveInverseForMorphisms( category,
                                    
      function( morphism )
        
        return CAPPresentationCategoryMorphism( 
                                           Source( morphism ),
                                           AdditiveInverseForMorphisms( UnderlyingMorphism( morphism ) ),
                                           Range( morphism )
                                           );
        
    end );

    AddIsZeroForMorphisms( category,
                            
      function( morphism )
         
        return IsZero( UnderlyingMorphism( morphism ) );
         
    end );

    # zero objects and zero morphisms
    AddZeroMorphism( category,
                     
      function( source, range )
        
        return CAPPresentationCategoryMorphism( source, ZeroMorphism( Range( source ), Range( range ) ), range );
        
    end );
        
    AddZeroObject( category,
                   
      function( )
        local projective_category;

        projective_category := category!.underlying_projective_category;
        
        return CAPPresentationCategoryObject( 
             IdentityMorphism( ZeroObject( projective_category ), ZeroObject( projective_category ) ), projective_category );
        
    end );
    
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
                                                                   
      function( object, terminal_object )

        return CAPPresentationCategoryMorphism( object,
                                                UniversalMorphismIntoZeroObject( Range( UnderlyingMorphism( object ) ) ),
                                                terminal_object );
        
    end );
    
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
                                                                 
      function( object, initial_object )
        
        return CAPPresentationCategoryMorphism( initial_object,
                                                UniversalMorphismFromZeroObject( Range( UnderlyingMorphism( object ) ) ),
                                                object );
        
    end );

    # direct sum    
    AddDirectSum( category,
                  
      function( objects )
        local directSum1, directSum2, diagram, list_of_projections, morphism;
        
        # take the direct sum of the source and range objects
        directSum1 := DirectSum( List( [ 1 .. Length( objects ) ], k -> Source( objects[ k ] ) ) );
        directSum2 := DirectSum( List( [ 1 .. Length( objects ) ], k -> Range( objects[ k ] ) ) );
        
        # and construct the universal morphism from the direct sum of the source to the direct sum of the range
        # THESE LINES COULD BE BUGGY BECAUSSE THE PRECISE REQUIREMENTS OF THE INPUT OF E.G. PROJECTIONINFACTOR... IS 
        # NOWHERE SPECIFIED!
        diagram := [];
        list_of_projections := List( [ 1 .. Length( objects ) ], 
           i ->  ProjectionInFactorOfDirectSumWithGivenDirectSum( objects, i, directSum1 ) );
        morphism := UniversalMorphismIntoDirectSumWithGivenDirectSum( diagram, list_of_projections, directSum2 );
        
        # then return the corresponding object in the presentation category
        return CAPPresentationCategoryObject( morphism, category!.underlying_projective_category );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( objects, component_number, direct_sum_object )
        local range_objects, range_direct_sum_object, projection;
        
        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( objects[ i ] ) );
        range_direct_sum_object := Range( direct_sum_object );
        
        # now compute the projection of these objects in the underlying category
        projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( range_objects, 
                                                                                 component_number, range_direct_sum_object );
        
        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( direct_sum_object, projection, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, product_morphism, direct_sum )

        return "Yet to come, one the input is clear to me. \n";
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
                                              
      function( objects, component_number, direct_sum_object )

        local range_objects, range_direct_sum_object, injection;
        
        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( objects[ i ] ) );
        range_direct_sum_object := Range( direct_sum_object );
        
        # now compute the projection of these objects in the underlying category
        injection := InjectionOfCofactorOfDirectSumWithGivenDirectSum( range_objects, 
                                                                                 component_number, range_direct_sum_object );
        
        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( objects[ component_number ], injection, direct_sum_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
                                                         
      function( diagram, product_morphism, direct_sum )
      
        return "Yet to come, one the input is clear to me. \n";
        
    end );

    # (4) enrich with Abelian structure
    # (4) enrich with Abelian structure

    # kernel
    AddKernelEmbedding( category,
      
      function( morphism )
        local kernel, embedding;
        
        #embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        #kernel := SyzygiesOfRows( embedding, UnderlyingMatrix( Source( morphism ) ) );
        
        #kernel := AsLeftPresentation( kernel );
        
        #return PresentationMorphism( kernel, embedding, Source( morphism ) );
        return "Yet to come \n";
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,
      
      function( morphism, kernel )
        local embedding;
        
        #embedding := SyzygiesOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        #return PresentationMorphism( kernel, embedding, Source( morphism ) );
        return "Yet to come \n";
    end );
    
    AddLift( category,
      
      function( alpha, beta )
        local lift;
        
        #lift := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( beta ) ) );
        
        #if lift = fail then
        #    return fail;
        #fi;
        
        #return PresentationMorphism( Source( alpha ), lift, Source( beta ) );
        return "Yet to come \n";
    end );    

    # is this method needed or can it be derived?
    #AddKernelLiftWithGivenKernelObject( category,
      
    #  function( morphism, test_morphism, cokernel_object )
        
        #return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
    #    return "Yet to come \n";        
    #end );
        
    # cokernel 
    AddCokernelProjection( category,
                     
      function( morphism )
        local cokernel_object, projection;
        
        #cokernel_object := UnionOfRows( UnderlyingMatrix( morphism ), UnderlyingMatrix( Range( morphism ) ) );
        
        #cokernel_object := AsLeftPresentation( cokernel_object );
        
        #projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        #return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        return "Yet to come \n";
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
                     
      function( morphism, cokernel_object )
        local projection;
        
        #projection := HomalgIdentityMatrix( NrColumns( UnderlyingMatrix( Range( morphism ) ) ), category!.ring_for_representation_category );
        
        #return PresentationMorphism( Range( morphism ), projection, cokernel_object );
        return "Yet to come \n";
    end );
    
    AddCokernelColiftWithGivenCokernelObject( category,
      
      function( morphism, test_morphism, cokernel_object )
        
        #return PresentationMorphism( cokernel_object, UnderlyingMatrix( test_morphism ), Range( test_morphism ) );
        return "Yet to come \n";        
    end );
    
    # potentially more moethods to be added - see the 'open_methods' file
    
end );