#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

DeclareRepresentation( "IsCAPPresentationCategoryMorphismRep",
                       IsCAPPresentationCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfCAPPresentationCategoryMorphisms",
            NewFamily( "TheFamilyOfCAPPresentationCategoryMorphisms" ) );

BindGlobal( "TheTypeOfCAPPresentationCategoryMorphism",
            NewType( TheFamilyOfCAPPresentationCategoryMorphisms,
                     IsCAPPresentationCategoryMorphismRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( CAPPresentationCategoryMorphism,
               [ IsCAPPresentationCategoryObject, IsCapCategoryMorphism, IsCAPPresentationCategoryObject ],
               
  function( source, morphism, range )
    #local category, presentation_morphism;
    local presentation_morphism, category; 
    
    # check fi the input data is valid
    if not IsIdenticalObj( CapCategory( UnderlyingMorphism( source ) ), CapCategory( morphism ) ) then
    
      Error( "The morphism and the source do not belong to the same category. \n" );
      return false;
    
    elif not IsIdenticalObj( CapCategory( UnderlyingMorphism( range ) ), CapCategory( morphism ) ) then
    
      Error( "The morphism and the range do not belong to the same category. \n" );
      return false;
    
    elif not IsEqualForObjects( Range( UnderlyingMorphism( source ) ), Source( morphism ) ) then
    
      Error( "The source of the morphism and the range of the presentation morphism of the source do not match. \n" );
      return false;
    
    elif not IsEqualForObjects( Range( UnderlyingMorphism( range ) ), Range( morphism ) ) then
    
      Error( "The range of the morphism and the range of the presentation morphism of the range do not match. \n" );
      return false;
    
    fi;
    
    # we found that the input is valid - although we have not yet checked that it is well-defined as well, i.e.
    # that there is a morphism of the sources that makes the following diagram commute
    # source: A --> B
    #               ^
    # mapping:      morphism
    #               |
    # range:  C --> D
    
    # this is to be checked in the well-defined methods
    
    # that said, let us construct the morphism
    presentation_morphism := rec( );       
    ObjectifyWithAttributes( presentation_morphism, TheTypeOfCAPPresentationCategoryMorphism,
                             Source, source,
                             Range, range,
                             UnderlyingMorphism, morphism );

    # then add it to the corresponding category
    category := CapCategory( source );
    Add( category, presentation_morphism );
    
    # and return the object
    return presentation_morphism;
    
end );


####################################
##
## View
##
####################################

InstallMethod( String,
              [ IsCAPPresentationCategoryMorphism ],
              
  function( presentation_category_morphism )
    
     return Concatenation( "A morphism of the presentation category over the ", 
                           Name( CapCategory( UnderlyingMorphism( presentation_category_morphism ) ) )
                           );
                    
end );


####################################
##
## Display
##
####################################

InstallMethod( Display,
               [ IsCAPPresentationCategoryMorphism ], 999, # FIX ME FIX ME FIX ME
               
  function( presentation_category_morphism )

     Print( Concatenation( "A morphism of the presentation category over the ", 
                            Name( CapCategory( UnderlyingMorphism( presentation_category_morphism ) ) ),
                            ". Presentation: \n"
                            ) );
  
     Display( UnderlyingMorphism( presentation_category_morphism ) );
     
end );


####################################
##
## ViewObj
##
####################################

InstallMethod( ViewObj,
               [ IsCAPPresentationCategoryMorphism ],
  function( presentation_category_morphism )

    Print( Concatenation( "<", String( presentation_category_morphism ), ">" ) );

end );


##############################################
##
## Non categorical methods
##
##############################################

##
#InstallMethod( StandardGeneratorMorphism,
#               [ IsLeftPresentation, IsPosInt ],
               
#  function( module_presentation, i_th_generator )
#    local tensor_unit, homalg_ring, number_of_generators, matrix;
    
#    number_of_generators := NrColumns( UnderlyingMatrix( module_presentation ) );
    
#    if i_th_generator > number_of_generators then
      
#      Error( Concatenation( "number of standard generators is ", 
#                            String( number_of_generators ), ", which is smaller than ", String( i_th_generator ) ) );
      
#    fi;
    
#    tensor_unit := TensorUnit( CapCategory( module_presentation ) );
    
#    homalg_ring := UnderlyingHomalgRing( tensor_unit );
    
#    matrix := List( [ 1 .. number_of_generators ], i -> 0 );
    
#    matrix[ i_th_generator ] := 1;
    
#    matrix := HomalgMatrix( matrix, 1, number_of_generators, homalg_ring );
    
#    return PresentationMorphism( tensor_unit, matrix, module_presentation );
    
#end );

##
#InstallMethod( StandardGeneratorMorphism,
#               [ IsRightPresentation, IsPosInt ],
               
#  function( module_presentation, i_th_generator )
#    local tensor_unit, homalg_ring, number_of_generators, matrix;
    
#    number_of_generators := NrRows( UnderlyingMatrix( module_presentation ) );
    
#    if i_th_generator > number_of_generators then
      
#      Error( Concatenation( "number of standard generators is ", 
#                            String( number_of_generators ), ", which is smaller than ", String( i_th_generator ) ) );
      
#    fi;
    
#    tensor_unit := TensorUnit( CapCategory( module_presentation ) );
    
#    homalg_ring := UnderlyingHomalgRing( tensor_unit );
    
#    matrix := List( [ 1 .. number_of_generators ], i -> 0 );
    
#    matrix[ i_th_generator ] := 1;
    
#    matrix := HomalgMatrix( matrix, number_of_generators, 1, homalg_ring );
    
#    return PresentationMorphism( tensor_unit, matrix, module_presentation );
    
#end );
