#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsProjectiveCategoryMorphismRep",
                       IsProjectiveCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfProjectiveCategoryMorphisms",
        NewFamily( "TheFamilyOfProjectiveCategoryMorphisms" ) );

BindGlobal( "TheTypeOfProjectiveCategoryMorphisms",
        NewType( TheFamilyOfProjectiveCategoryMorphisms,
                IsProjectiveCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( ProjectiveCategoryMorphism,
               [ IsProjectiveCategoryObject, IsHomalgMatrix, IsProjectiveCategoryObject ],
               
  function( source, homalg_matrix, range )
    local projective_category_morphism, homalg_graded_ring, category;
    
    category := CapCategory( source );
    
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      return Error( "source and range are not defined over identical categories" );
      
    fi;
    
    homalg_graded_ring := HomalgRing( homalg_matrix );
    
    if not IsIdenticalObj( homalg_graded_ring, UnderlyingHomalgGradedRing( source ) ) then
      
      return Error( "the matrix is defined over a different ring than the objects" );
      
    fi;
    
    if NrRows( homalg_matrix ) <> RankOfObject( source ) then
      
      return Error( "the number of rows has to be equal to the rank of the source" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> RankOfObject( range ) then
      
      return Error( "the number of columns has to be equal to the rank of the range" );
      
    fi;
    
    projective_category_morphism := rec( );
    
    ObjectifyWithAttributes( projective_category_morphism, TheTypeOfProjectiveCategoryMorphisms,
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    Add( category, projective_category_morphism );
    
    return projective_category_morphism;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsProjectiveCategoryMorphism ],

  function( projective_category_morphism )

    Print( "A projective category morphism over ", 
    RingName( UnderlyingHomalgGradedRing( projective_category_morphism ) ),
    " with matrix: \n" );
    
    Display( UnderlyingHomalgMatrix( projective_category_morphism ) );
    
end );
