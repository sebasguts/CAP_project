#############################################################################
##
##                                ProjCategoryForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       IPT Heidelberg
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsProjCategoryObjectRep",
                       IsProjCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfProjCategoryObjects",
        NewFamily( "TheFamilyOfProjCategoryObjects" ) );

BindGlobal( "TheTypeOfProjCategoryObjects",
        NewType( TheFamilyOfProjCategoryObjects,
                IsProjCategoryObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( ProjCategoryObject,
               [ IsList, IsHomalgGradedRing ],
               
  function( degree_list, homalg_graded_ring )
    local A, i, category, proj_category_object;
    
    # check that the degree group is free
    A := DegreeGroup( homalg_graded_ring );
    if not IsFree( A ) then
    
      return Error( "Currently the Proj-category is only supported for free graded rings \n" );
    
    fi;
    
    # next check that the degrees lie in the degree group
    for i in [ 1 .. Length( degree_list ) ] do
    
      if not ( Length( degree_list[ i ] ) = Rank( A ) ) then
      
        return Error( Concatenation( "The ", String( i ), "-th degree lies not in the degree group of the homalg graded ring. \n" ); )
      
      fi;
    
    od;
    
    # define category
    category := ProjCategory( homalg_graded_ring );
    
    proj_category_object := rec( );
    
    ObjectifyWithAttributes( proj_category_object, TheTypeOfProjCategoryObjects,
                             DegreeList, degree_list,
                             Rank, Length( degree_list ),
                             UnderlyingHomalgGradedRing, homalg_graded_ring
    );

    Add( category, proj_category_object );
    
    return proj_category_object;
    
end );

####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsProjCategoryObject ],
              
  function( proj_category_object )
    
    return Concatenation( "A proj category object over ",
                          RingName( UnderlyingHomalgGradedRing( proj_category_object ) ),
                          " of rank ", String( Rank( proj_category_object ) ), 
                          " and degrees ", String( Degrees( proj_category_object ) ) );
    
end );

##
InstallMethod( ViewObj,
               [ IsProjCategoryObject ],

  function( proj_category_object )

    Print( Concatenation( "<", String( proj_category_object ), ">" ) );

end );

