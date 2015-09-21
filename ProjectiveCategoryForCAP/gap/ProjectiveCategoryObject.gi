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

DeclareRepresentation( "IsProjectiveCategoryObjectRep",
                       IsProjectiveCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfProjectiveCategoryObjects",
        NewFamily( "TheFamilyOfProjectiveCategoryObjects" ) );

BindGlobal( "TheTypeOfProjectiveCategoryObjects",
        NewType( TheFamilyOfProjectiveCategoryObjects,
                IsProjectiveCategoryObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( ProjectiveCategoryObject,
               [ IsList, IsHomalgGradedRing ],
               
  function( degree_list, homalg_graded_ring )
    local A, i, category, projective_category_object, rank;
    
    # check that the degree group is free
    A := DegreeGroup( homalg_graded_ring );
    if not IsFree( A ) then
    
      return Error( "Currently the projective category is only supported for free graded rings \n" );
    
    fi;
    
    # next check that the degrees lie in the degree group
    for i in [ 1 .. Length( degree_list ) ] do
    
      if not Length( degree_list[ i ] ) = 2 then
      
        Error( "The entries of the degree list have to consist of two entries - the degree and its multiplicity. \n" );
        return false;
      
      elif not ( Length( degree_list[ i ][ 1 ] ) = Rank( A ) ) then
      
        Error( Concatenation( "The first entry of the ", String( i ), "-th entry in the degree list has to lie in the degree group of the homalg graded ring. \n" ) );
        return false;
            
      elif ( not IsInt( degree_list[ i ][ 2 ] ) ) or ( degree_list[ i ][ 2 ] < 0 ) then
      
        Error( Concatenation( "The second entry of the ", String( i ), "-th entry in the degree list has to be a non-negative integer. \n" ) );
        return false;
      
      fi;
        
    od;
    
    # define category
    category := ProjectiveCategory( homalg_graded_ring );
    
    projective_category_object := rec( );
    
    rank := Sum( List( degree_list, x -> x[ 2 ] ) );
    
    ObjectifyWithAttributes( projective_category_object, TheTypeOfProjectiveCategoryObjects,
                             DegreeList, degree_list,
                             RankOfObject, rank,
                             UnderlyingHomalgGradedRing, homalg_graded_ring
    );

    Add( category, projective_category_object );
    
    return projective_category_object;
    
end );

####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsProjectiveCategoryObject ],
              
  function( projective_category_object )
    
    return Concatenation( "A projective category object over ",
                          RingName( UnderlyingHomalgGradedRing( projective_category_object ) ),
                          " of rank ", String( RankOfObject( projective_category_object ) )
                          #" and degrees ", String( DegreeList( projective_category_object ) ) 
                          );

end );

##
InstallMethod( ViewObj,
               [ IsProjectiveCategoryObject ],

  function( projective_category_object )

    Print( Concatenation( "<", String( projective_category_object ), ">" ) );

end );

######################################
##
## Convenience method to access "Rank" more easily
##
######################################

InstallMethod( Rank,
               [ IsProjectiveCategoryObject ],

  RankOfObject );