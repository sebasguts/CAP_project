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
        local lift;
        
        # we should first check that source, range and the mapping itself are well-defined...
        if not IsWellDefinedForObjects( Source( morphism ) ) then
        
          return false;
          
        elif not IsWellDefinedForObjects( Range( morphism ) ) then
        
          return false;
        
        elif not IsWellDefinedForMorphisms( UnderlyingMorphism( morphism ) ) then
        
          return false;
        
        fi;
        
        # check if a SourceLiftMorphism has been computed
        if not HasSourceLiftMorphism( morphism ) then
        
          # no SourceLiftMorphism has been computed thus far, so do it now 
          lift := SourceLiftMorphism( morphism );
          
          if lift = fail then
            
            # there is no such lift, thus the mapping is not well-defined and we should thus return fail
            return false;
        
          fi;
        
        elif SourceLiftMorphism( morphism ) = fail then
        
          # it has been tried to compute a SourceLiftMorphism, but this operation failed, so the morphism is not well-defined
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
        
        return CAPPresentationCategoryMorphism( source, 
                                 ZeroMorphism( Range( UnderlyingMorphism( source ) ), Range( UnderlyingMorphism( range ) ) ), 
                                 range 
                                 );
        
    end );
    
    AddZeroObject( category,
                   
      function( )
        local projective_category;

        projective_category := category!.underlying_projective_category;
        
        return CAPPresentationCategoryObject( IdentityMorphism( ZeroObject( projective_category ) ), projective_category );
        
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
        local source_objects, range_objects, directSum_of_range_objects, diagram, list_of_projections, morphism;

        # form lists of the sources and ranges, i.e. of objects in the underlying Proj-Category
        source_objects := List( [ 1 .. Length( objects ) ], k -> Source( UnderlyingMorphism( objects[ k ] ) ) );
        range_objects := List( [ 1 .. Length( objects ) ], k -> Range( UnderlyingMorphism( objects[ k ] ) ) );
        
        # take the direct sum of the source and range objects in the underlying Proj-Category
        directSum_of_range_objects := DirectSum( range_objects );
        
        # now construct the list of projections into the range_objects
        # (we will use these projections and the universal property of directSum2 to construct the map from
        # directSum1 -> directSum2 as the universal morphism into directSum2)
        list_of_projections := List( [ 1 .. Length( objects ) ], i ->  ProjectionInFactorOfDirectSum( source_objects, i ) );
        list_of_projections := List( [ 1 .. Length( objects ) ], 
                                           i -> PreCompose( list_of_projections[ i ], UnderlyingMorphism( objects[ i ] ) ) );        
        diagram := range_objects;
        morphism := UniversalMorphismIntoDirectSumWithGivenDirectSum( diagram, list_of_projections, 
                                                                                                directSum_of_range_objects );
        
        # then return the corresponding object in the presentation category
        return CAPPresentationCategoryObject( morphism, category!.underlying_projective_category );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
                                                 
      function( objects, component_number, direct_sum_object )
        local range_objects, range_direct_sum_object, projection;
                
        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( UnderlyingMorphism( objects[ i ] ) ) );
        range_direct_sum_object := Range( UnderlyingMorphism( direct_sum_object ) );
        
        # now compute the projection of these objects in the underlying category
        projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( range_objects, component_number, 
                                                                                                   range_direct_sum_object );
        
        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( direct_sum_object, projection, objects[ component_number ] );
        
    end );
    
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
                                                                 
      function( diagram, sink, direct_sum )
        local underlying_sink, diagram_ranges, underlying_morphism;
        
        # construct the morphism of the test_object_range into direct_sum_range via universal property
        underlying_sink := List( [ 1 .. Length( sink ) ], i -> UnderlyingMorphism( sink[ i ] ) );
        diagram_ranges := List( [ 1 .. Length( sink ) ], i -> Range( UnderlyingMorphism( sink[ i ] ) ) );
        underlying_morphism := UniversalMorphismIntoDirectSumWithGivenDirectSum( diagram_ranges, underlying_sink,
                                                                                 Range( UnderlyingMorphism( direct_sum ) ) );
        
        # and construct the morphism in the presentation category
        return CAPPresentationCategoryMorphism( Source( sink[ 1 ] ), underlying_morphism, direct_sum ); 
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
           
      function( objects, component_number, coproduct_object )      
        local range_objects, range_direct_sum_object, injection;

        # extract the range objects in the underlying projective category
        range_objects := List( [ 1 .. Length( objects ) ], i -> Range( UnderlyingMorphism( objects[ i ] ) ) );
        range_direct_sum_object := Range( UnderlyingMorphism( coproduct_object ) );
        
        # now compute the projection of these objects in the underlying category
        injection := InjectionOfCofactorOfDirectSumWithGivenDirectSum( range_objects, component_number, 
                                                                                                   range_direct_sum_object );
        
        # and construct the projection the presentation category
        return CAPPresentationCategoryMorphism( objects[ component_number ], injection, coproduct_object );
        
    end );
    
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )                                                         

        local underlying_sink, diagram_sources, underlying_morphism;
        
        # construct the morphism of the test_object_range into direct_sum_range via universal property
        underlying_sink := List( [ 1 .. Length( sink ) ], i -> UnderlyingMorphism( sink[ i ] ) );
        diagram_sources := List( [ 1 .. Length( sink ) ], i -> Source( UnderlyingMorphism( sink[ i ] ) ) );
        underlying_morphism := UniversalMorphismFromDirectSumWithGivenDirectSum( diagram_sources, underlying_sink,
                                                                                 Range( UnderlyingMorphism( coproduct ) ) );
        
        # and construct the morphism in the presentation category
         return CAPPresentationCategoryMorphism( coproduct, underlying_morphism, Range( sink[ 1 ] ) ); 
              
    end );

    # (4) enrich with Abelian structure
    # (4) enrich with Abelian structure
    
    # kernel
    AddKernelObject( category,
      function( morphism )
        local kernel_embedding, underlying_morphism_of_kernel;
          
        kernel_embedding := ProjectionInFactorOfFiberProduct( [ UnderlyingMorphism( morphism ), 
                                                                UnderlyingMorphism( Range( morphism ) ) ], 1 );
        
        underlying_morphism_of_kernel := ProjectionInFactorOfFiberProduct( [ kernel_embedding, 
                                                                             UnderlyingMorphism( Source( morphism ) ) ], 1 );
            
      return CAPPresentationCategoryObject( underlying_morphism_of_kernel, CapCategory( underlying_morphism_of_kernel ) );
      
    end );
    
    AddKernelEmbedding( category,
      function( morphism )
        local kernel_embedding, underlying_morphism_of_kernel, kernel_object;
          
        kernel_embedding := ProjectionInFactorOfFiberProduct( [ UnderlyingMorphism( morphism ), 
                                                                UnderlyingMorphism( Range( morphism ) ) ], 1 );
        
        underlying_morphism_of_kernel := ProjectionInFactorOfFiberProduct( [ kernel_embedding, 
                                                                             UnderlyingMorphism( Source( morphism ) ) ], 1 );
            
        kernel_object := CAPPresentationCategoryObject( underlying_morphism_of_kernel, 
                                                                              CapCategory( underlying_morphism_of_kernel ) );
        
        return CAPPresentationCategoryMorphism( kernel_object, kernel_embedding, Source( morphism ) );
        
    end );
    
    AddKernelEmbeddingWithGivenKernelObject( category,      
      function( morphism, kernel_object )
        local kernel_embedding, underlying_morphism_of_kernel;
        
        kernel_embedding := ProjectionInFactorOfFiberProduct( [ UnderlyingMorphism( morphism ), 
                                                                UnderlyingMorphism( Range( morphism ) ) ], 1 );
        
        return CAPPresentationCategoryMorphism( kernel_object, kernel_embedding, Source( morphism ) );
    
    end );

    AddLiftAlongMonomorphism( category,
      function( monomorphism, test_morphism )
        local lift;
        
        # try to compute a lift (this should actually always work since we are in an Abelian category, i.e. every
        # mono is a kernel and the construction of kernels guarantees the existence of this lift)
        lift := Lift( UnderlyingMorphism( monomorphism ), UnderlyingMorphism( test_morphism ) );
        
        if lift = fail then
        
          Error( "The lift along a mono could not be computed. Something went seriously wrong! \n" );
        
        fi;
        
        # otherwise everything is fine, so return the result        
         return CAPPresentationCategoryMorphism( Source( test_morphism ),
                                                 lift,
                                                 Source( monomorphism ) );
        
    end );
  
    # kernel-lift should be derived from this
        
    # cokernel
    AddCokernelObject( category,
      function( morphism )
        local coproduct, sink, diagram, universal_morphism;
        
        # compute coproduct
        coproduct := DirectSum( [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ] );        
        # fix sink and diagram
        sink := [ UnderlyingMorphism( morphism ), UnderlyingMorphism( Range( morphism ) ) ];
        diagram := [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ];
        # and compute the universal morphism of the coproduct
        universal_morphism := UniversalMorphismFromDirectSumWithGivenDirectSum( diagram, sink, coproduct );
        
        # and then  turn this morphism into an object of the presentation category - the cokernel
        return CAPPresentationCategoryObject( universal_morphism, CapCategory( universal_morphism ) );
      
    end );
    
    AddCokernelProjection( category,
      function( morphism )
        local coproduct, sink, diagram, universal_morphism, cokernel_object;
        
        # compute coproduct
        coproduct := DirectSum( [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ] );
        # fix sink and diagram
        sink := [ UnderlyingMorphism( morphism ), UnderlyingMorphism( Range( morphism ) ) ];
        diagram := [ Range( UnderlyingMorphism( Source( morphism ) ) ), 
                                                                       Source( UnderlyingMorphism( Range( morphism ) ) ) ];        
        # and compute the universal morphism of the coproduct
        universal_morphism := UniversalMorphismFromDirectSumWithGivenDirectSum( diagram, sink, coproduct );
        
        # and then  turn this morphism into an object of the presentation category - the cokernel
        cokernel_object := CAPPresentationCategoryObject( universal_morphism, CapCategory( universal_morphism ) );
        
        # now return the cokernel projection
        return CAPPresentationCategoryMorphism( Range( morphism ), 
                                                IdentityMorphism( Range( UnderlyingMorphism( Range( morphism ) ) ) ),
                                                cokernel_object 
                                               );
    end );
    
    AddCokernelProjectionWithGivenCokernelObject( category,
      function( morphism, cokernel_object )

        # in this case we can immediately return the cokernel projection
        return CAPPresentationCategoryMorphism( Range( morphism ), 
                                                IdentityMorphism( Range( UnderlyingMorphism( Range( morphism ) ) ) ),
                                                cokernel_object 
                                               );            
    end );
        
    AddColiftAlongEpimorphism( category,
      function( epimorphism, test_morphism )
        local colift;

        colift := Colift( UnderlyingMorphism( epimorphism ), UnderlyingMorphism( test_morphism ) );
        
        if colift = fail then
        
          Error( "The colift along an epi could not be computed. Something went seriously wrong! \n" );
        
        fi;
        
        # otherwise everything is fine, so return the result        
         return CAPPresentationCategoryMorphism( Range( epimorphism ),
                                                 colift,
                                                 Range( test_morphism ) );
      
      
    end );
    
    # cokernel-colift should be derived from this
    
    #AddLift( category,
      
      #function( alpha, beta )
        #local lift;
        
        #lift := RightDivide( UnderlyingMatrix( alpha ), UnderlyingMatrix( beta ), UnderlyingMatrix( Range( beta ) ) );
        
        #if lift = fail then
        #    return fail;
        #fi;
        
        #return PresentationMorphism( Source( alpha ), lift, Source( beta ) );
        #return "Yet to come \n";
    #end );  

    # potentially more moethods to be added - see the 'open_methods' file
    
end );