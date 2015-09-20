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

DeclareRepresentation( "IsProjCategoryMorphismRep",
                       IsProjCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfProjCategoryMorphisms",
        NewFamily( "TheFamilyOfProjCategoryMorphisms" ) );

BindGlobal( "TheTypeOfProjCategoryMorphisms",
        NewType( TheFamilyOfProjCategoryMorphisms,
                IsProjCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( ProjCategoryMorphism,
               [ IsProjCategoryObject, IsHomalgMatrix, IsProjCategoryObject ],
               
  function( source, homalg_matrix, range )
    local proj_category_morphism, homalg_graded_ring, category;
    
    category := CapCategory( source );
    
    if not IsIdenticalObj( category, CapCategory( range ) ) then
      
      return Error( "source and range are not defined over identical categories" );
      
    fi;
    
    homalg_graded_ring := HomalgRing( homalg_matrix );
    
    if not IsIdenticalObj( homalg_graded_ring, UnderlyingHomalgGradedRing( source ) ) then
      
      return Error( "the matrix is defined over a different ring than the objects" );
      
    fi;
    
    if NrRows( homalg_matrix ) <> Rank( source ) then
      
      return Error( "the number of rows has to be equal to the rank of the source" );
      
    fi;
    
    if NrColumns( homalg_matrix ) <> Rank( range ) then
      
      return Error( "the number of columns has to be equal to the rank of the range" );
      
    fi;
    
    proj_category_morphism := rec( );
    
    ObjectifyWithAttributes( proj_category_morphism, TheTypeOfProjCategoryMorphisms,
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, homalg_graded_ring,
                             UnderlyingHomalgMatrix, homalg_matrix
    );

    Add( category, proj_category_morphism );
    
    return proj_category_morphism;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewObj,
               [ IsProjCategoryMorphism ],

  function( proj_category_morphism )

    Print( "A proj category morphism over ", 
    RingName( UnderlyingHomalgGradedRing( proj_category_morphism ) ),
    " with matrix: \n" );
    
    Display( UnderlyingHomalgMatrix( proj_category_morphism ) );
    
end );
