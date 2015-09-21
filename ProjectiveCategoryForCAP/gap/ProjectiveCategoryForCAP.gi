#############################################################################
##
##                                ProjCategoryForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
##
#############################################################################

####################################
##
## Constructors
##
####################################

InstallMethod( ProjectiveCategory,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "Projective category over ", RingName( homalg_graded_ring ) ) );
    
    category!.homalg_graded_ring_for_projective_category := homalg_graded_ring;
    
    SetIsAdditiveCategory( category, true );
        
    INSTALL_FUNCTIONS_FOR_PROJECTIVE_CATEGORY( category );
    
    ## TODO: Logic for MatrixCategory
    #AddPredicateImplicationFileToCategory( category,
    #  Filename(
    #    DirectoriesPackageLibrary( "LinearAlgebraForCAP", "LogicForMatrixCategory" ),
    #    "PredicateImplicationsForMatrixCategory.tex" )
    #);
     
    Finalize( category );
    
    return category;
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_PROJECTIVE_CATEGORY,
  
  function( category )
    
    ## Equality Basic Operations for Objects and Morphisms
    ## Equality Basic Operations for Objects and Morphisms

    ##
    AddIsEqualForObjects( category,
      function( object_1, object_2 )
      
        return DegreeList( object_1 ) = DegreeList( object_2 );
      
    end );
    
    ##
    AddIsCongruentForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return UnderlyingHomalgMatrix( morphism_1 ) = UnderlyingHomalgMatrix( morphism_2 );
        
    end );
    
    ## Basic Operations for a Category
    ## Basic Operations for a Category
    
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return ProjectiveCategoryMorphism( object, HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_1 ) * UnderlyingHomalgMatrix( morphism_2 );

        return ProjectiveCategoryMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

    end );
    
    ## Basic Operations for an Additive Category
    ## Basic Operations for an Additive Category

    ##
    AddIsZeroForObjects( category,
      function( object )
      
        return Rank( object ) = 0;
      
      end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return ProjectiveCategoryMorphism( Source( morphism_1 ),
                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                    Range( morphism_2 ) 
                                    );
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return ProjectiveCategoryMorphism( Source( morphism ),
                                           (-1) * UnderlyingHomalgMatrix( morphism ),
                                           Range( morphism )
                                          );
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return ProjectiveCategoryMorphism( source,
                                           HomalgZeroMatrix( RankOfObject( source ), RankOfObject( range ), homalg_graded_ring ),
                                           range
                                          );
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return ProjectiveCategoryObject( [ [ Zero( DegreeGroup( category!.homalg_graded_ring_for_projective_category ) ), 0 ] ], 
                                         category!.homalg_graded_ring_for_projective_category 
                                        );
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := ProjectiveCategoryMorphism( sink, 
                                                HomalgZeroMatrix( RankOfObject( sink ), 0, homalg_graded_ring ), 
                                                zero_object 
                                               );
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := ProjectiveCategoryMorphism( zero_object, 
                                                HomalgZeroMatrix( 0, RankOfObject( source ), homalg_graded_ring ), 
                                                source
                                               );
        return morphism;
        
    end );

    ##
    AddDirectSum( category,
      function( object_list )
      local homalg_graded_ring, degree_list_list, degree_list_of_direct_sum_object;
      
      # first extract the underlying graded ring
      homalg_graded_ring := UnderlyingHomalgGradedRing( object_list[ 1 ] );

      # then the degree_list of the direct sum object
      degree_list_list := List( object_list, x -> DegreeList( x ) );
      degree_list_of_direct_sum_object := Concatenation( degree_list_list );
      
      # and then return the corresponding object
      return ProjectiveCategoryObject( degree_list_of_direct_sum_object, homalg_graded_ring ); 
      
    end );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, projection_number, direct_sum_object )
        local homalg_graded_ring, rank_pre, rank_post, rank_factor, number_of_objects, projection_in_factor;
        
        # extract the underlying graded ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( direct_sum_object );
        
        # and the number of objects that were 'added'
        number_of_objects := Length( object_list );
        
        # collect necessary data to construct the mapping matrix
        rank_pre := Sum( object_list{ [ 1 .. projection_number - 1 ] }, c -> Rank( c ) );
        rank_post := Sum( object_list{ [ projection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );        
        rank_factor := Rank( object_list[ projection_number ] );
        
        # construct the mapping as homalg matrix
        projection_in_factor := HomalgZeroMatrix( rank_pre, rank_factor, homalg_graded_ring );        
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgIdentityMatrix( rank_factor, homalg_graded_ring ) );
        projection_in_factor := UnionOfRows( projection_in_factor, 
                                             HomalgZeroMatrix( rank_post, rank_factor, homalg_graded_ring ) );
        
        # and return the corresonding morphism
        return ProjectiveCategoryMorphism( direct_sum_object, projection_in_factor, object_list[ projection_number ] );
        
    end );    

    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( diagram, sink, direct_sum )
        local underlying_matrix_of_universal_morphism, morphism;
        
        # construct the homalg matrix to represent the universal morphism
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfColumns( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        # and then construct from it the corresponding morphism
        return ProjectiveCategoryMorphism( Source( sink[ 1 ] ), underlying_matrix_of_universal_morphism, direct_sum );      
    end );

    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      function( object_list, injection_number, coproduct )
        local homalg_graded_ring, rank_pre, rank_post, rank_cofactor, number_of_objects, injection_of_cofactor;
        
        # extract the underlying graded ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( coproduct );
        
        # and the number of objects
        number_of_objects := Length( object_list );

        # now collect the data needed to construct the injection matrix
        rank_pre := Sum( object_list{ [ 1 .. injection_number - 1 ] }, c -> Rank( c ) );        
        rank_post := Sum( object_list{ [ injection_number + 1 .. number_of_objects ] }, c -> Rank( c ) );        
        rank_cofactor := Rank( object_list[ injection_number ] );
        
        # now construct the mapping matrix
        injection_of_cofactor := HomalgZeroMatrix( rank_cofactor, rank_pre ,homalg_graded_ring );        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor, 
                                             HomalgIdentityMatrix( rank_cofactor, homalg_graded_ring ) );        
        injection_of_cofactor := UnionOfColumns( injection_of_cofactor,
                                             HomalgZeroMatrix( rank_cofactor, rank_post, homalg_graded_ring ) );
        
        # and construct the associated morphism
        return ProjectiveCategoryMorphism( object_list[ injection_number ], injection_of_cofactor, coproduct );
        
    end );

    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( diagram, sink, coproduct )
        local underlying_matrix_of_universal_morphism, morphism;
        
        underlying_matrix_of_universal_morphism := UnderlyingHomalgMatrix( sink[1] );
        
        for morphism in sink{ [ 2 .. Length( sink ) ] } do
          
          underlying_matrix_of_universal_morphism := 
            UnionOfRows( underlying_matrix_of_universal_morphism, UnderlyingHomalgMatrix( morphism ) );
          
        od;
        
        return ProjectiveCategoryMorphism( coproduct, underlying_matrix_of_universal_morphism, Range( sink[1] ) );
        
    end );

    ## Weak kernels (added as kernels)
    ## Weak kernels (added as kernels)

    ##
    AddKernelObject( category,
      function( morphism )
        local homalg_graded_ring, morphism_matrix, kernel_matrix, degrees_of_kernel_matrix_rows, degrees_of_source_compact,
             degrees_of_source_flattened, i, j, degrees_of_kernel_object;
        
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # and the underlying homalg matrix of this morphism
        morphism_matrix := UnderlyingHomalgMatrix( morphism );
        
        # then compute the syzygies of rows, which forms the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( morphism_matrix );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );

        # flatten out the degrees of the source of morphism
        degrees_of_source_compact := DegreeList( Source( morphism ) );
        degrees_of_source_flattened := [];
        for i in [ 1 .. Length( degrees_of_source_compact ) ] do
        
          for j in [ 1 .. degrees_of_source_compact[ i ][ 2 ] ] do
          
            Add( degrees_of_source_flattened, degrees_of_source_compact[ i ][ 1 ] );
          
          od;
        
        od;
        
        # from this we can compute the degrees of the kernel_object
        degrees_of_kernel_object := List( degrees_of_kernel_matrix_rows, 
                                          i -> [ degrees_of_source_flattened[ i ] - UnderlyingListOfRingElements( i ), 1 ] );
               
        # and return the kernel_object
        return ProjectiveCategoryObject( degrees_of_kernel_object, homalg_graded_ring );
        
    end );

    ##
    AddKernelEmbedding( category,
      function( morphism )

        local homalg_graded_ring, morphism_matrix, kernel_matrix, degrees_of_kernel_matrix_rows, degrees_of_source_compact,
             degrees_of_source_flattened, i, j, degrees_of_kernel_object, kernel_object;
        
        # extract the underlying homalg_graded_ring
        homalg_graded_ring := UnderlyingHomalgGradedRing( morphism );        
        
        # and the underlying homalg matrix of this morphism
        morphism_matrix := UnderlyingHomalgMatrix( morphism );
        
        # then compute the syzygies of rows, which forms the 'kernel matrix'
        kernel_matrix := SyzygiesOfRows( morphism_matrix );
        
        # compute the degrees of the rows of the kernel matrix
        degrees_of_kernel_matrix_rows := NonTrivialDegreePerRow( kernel_matrix );

        # flatten out the degrees of the source of morphism
        degrees_of_source_compact := DegreeList( Source( morphism ) );
        degrees_of_source_flattened := [];
        for i in [ 1 .. Length( degrees_of_source_compact ) ] do
        
          for j in [ 1 .. degrees_of_source_compact[ i ][ 2 ] ] do
          
            Add( degrees_of_source_flattened, degrees_of_source_compact[ i ][ 1 ] );
          
          od;
        
        od;
        
        # from this we can compute the degrees of the kernel_object
        degrees_of_kernel_object := List( degrees_of_kernel_matrix_rows, 
                                          i -> [ degrees_of_source_flattened[ i ] - UnderlyingListOfRingElements( i ), 1 ] );
        kernel_object := ProjectiveCategoryObject( degrees_of_kernel_object, homalg_graded_ring );
               
        # and return the kernel embedding
        return ProjectiveCategoryMorphism( kernel_object, kernel_matrix, Source( morphism ) );
    end );

    ##
    AddKernelEmbeddingWithGivenKernelObject( category,
      function( morphism, kernel )
        local kernel_matrix;
        
        kernel_matrix := SyzygiesOfRows( UnderlyingHomalgMatrix( morphism ) );
        
        return ProjectiveCategoryMorphism( kernel, kernel_matrix, Source( morphism ) );
        
    end );
    
    ##
    AddMonoAsKernelLift( category,
      function( monomorphism, test_morphism )
        local right_divide;
        
        # try to find a lift
        right_divide := RightDivide( UnderlyingHomalgMatrix( test_morphism ), UnderlyingHomalgMatrix( monomorphism ) );

        # check if this failed
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        # and if not, then construct the lift-morphism
        return ProjectiveCategoryMorphism( Source( test_morphism ),
                                    right_divide,
                                    Source( monomorphism ) );
        
    end );
    
    ## Weak cokernels (added as cokernels)
    ## Weak cokernels (added as cokernels)

    
    
    
    ## Lifts
    ## Lifts
    
    
end );

