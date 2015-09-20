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

InstallMethod( ProjCategory,
               [ IsHomalgGradedRing ],
               
  function( homalg_graded_ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "Proj category over ", RingName( homalg_graded_ring ) ) );
    
    category!.homalg_graded_ring_for_proj_category := homalg_graded_ring;
    
    SetIsAdditiveCategory( category, true );
        
    INSTALL_FUNCTIONS_FOR_PROJ_CATEGORY( category );
    
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

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_PROJ_CATEGORY,
  
  function( category )
    
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
    ##
    AddIdentityMorphism( category,
      
      function( object )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( object );
        
        return ProjCategoryMorphism( object, HomalgIdentityMatrix( Rank( object ), homalg_graded_ring ), object );
        
    end );
    
    ##
    AddPreCompose( category,

      function( morphism_1, morphism_2 )
        local composition;

        composition := UnderlyingHomalgMatrix( morphism_1 ) * UnderlyingHomalgMatrix( morphism_2 );

        return ProjCategoryMorphism( Source( morphism_1 ), composition, Range( morphism_2 ) );

    end );
    
    ## Basic Operations for an Additive Category
    ##
    AddIsZeroForMorphisms( category,
      function( morphism )
        
        return IsZero( UnderlyingHomalgMatrix( morphism ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( morphism_1, morphism_2 )
        
        return ProjCategoryMorphism( Source( morphism_1 ),
                                    UnderlyingHomalgMatrix( morphism_1 ) + UnderlyingHomalgMatrix( morphism_2 ),
                                    Range( morphism_2 ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( morphism )
        
        return ProjCategoryMorphism( Source( morphism ),
                                    (-1) * UnderlyingHomalgMatrix( morphism ),
                                    Range( morphism ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( source, range )
        local homalg_graded_ring;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( source );
        
        return ProjCategoryMorphism( source,
                                    HomalgZeroMatrix( Rank( source ), Rank( range ), homalg_graded_ring ),
                                    range );
        
    end );
    
    ##
    AddZeroObject( category,
      function( )
        
        return ProjCategoryObject( 0, category!.homalg_graded_ring_for_proj_category );
        
    end );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( category,
      function( sink, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := ProjCategoryMorphism( sink, HomalgZeroMatrix( Rank( sink ), 0, homalg_graded_ring ), zero_object );
        
        return morphism;
        
    end );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( category,
      function( source, zero_object )
        local homalg_graded_ring, morphism;
        
        homalg_graded_ring := UnderlyingHomalgGradedRing( zero_object );
        
        morphism := ProjCategoryMorphism( zero_object, HomalgZeroMatrix( 0, Rank( source ), homalg_graded_ring ), source );
        
        return morphism;
        
    end );
        
end );