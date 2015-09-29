#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

DeclareRepresentation( "IsLeftPresentationWithDegreesMorphismRep",
                       IsLeftPresentationWithDegreesMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfLeftPresentationWithDegreesMorphisms",
            NewFamily( "TheFamilyOfLeftPresentationWithDegreesMorphisms" ) );

BindGlobal( "TheTypeOfLeftPresentationWithDegreesMorphisms",
            NewType( TheFamilyOfLeftPresentationWithDegreesMorphisms,
                     IsLeftPresentationWithDegreesMorphismRep ) );


DeclareRepresentation( "IsRightPresentationWithDegreesMorphismRep",
                       IsRightPresentationWithDegreesMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfRightPresentationWithDegreesMorphisms",
            NewFamily( "TheFamilyOfRightPresentationWithDegreesMorphisms" ) );

BindGlobal( "TheTypeOfRightPresentationWithDegreesMorphisms",
            NewType( TheFamilyOfRightPresentationWithDegreesMorphisms,
                     IsRightPresentationWithDegreesMorphismRep ) );

#############################
##
## Constructors
##
#############################

##
InstallMethod( PresentationMorphism,
               [ IsLeftOrRightPresentationWithDegrees, IsHomalgMatrix, IsLeftOrRightPresentationWithDegrees ],
               
  function( source, matrix, range )
    local category, left, morphism, type;
    
    category := CapCategory( source );
    
    # check if we are dealing with a left-presentation
    left := IsLeftPresentationWithDegrees( source );

    # now check that the input is valid
    if not IsCapCategory( source ) = IsCapCategory( range ) then
      
      Error( "source and range must lie in the same category" );
      return false;
      
    elif not IsIdenticalObj( UnderlyingHomalgGradedRing( source ), HomalgRing( matrix ) ) then
        
      Error( "matrix cannot present a morphism between these objects" );
      return false;
      
    fi;
    
    # now do a check specific to a left presentation
    if left then
      
      if NrRows( matrix ) <> NrColumns( UnderlyingMatrix( source ) ) then
          
        Error( "the number of rows of the given matrix is incorrect" );
        return false;
          
      elif NrColumns( matrix ) <> NrColumns( UnderlyingMatrix( range ) ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        return false;
        
      fi;

    # and one specific to a right presentation
    else
      
      if NrColumns( matrix ) <> NrRows( UnderlyingMatrix( source ) ) then
        
        Error( "the number of columns of the given matrix is incorrect" );
        return false;
        
      elif NrRows( matrix ) <> NrRows( UnderlyingMatrix( range ) ) then
        
        Error( "the number of rows of the given matrix is incorrect" );
        return false;
       
      fi;
      
    fi;
    
    # also need to compare the degrees
    
    # given that we passed all these test, let us construct the morphism
    morphism := rec( );
    
    # install the correct 'type'
    if left then
        type := TheTypeOfLeftPresentationWithDegreesMorphisms;
    else
        type := TheTypeOfRightPresentationWithDegreesMorphisms;
    fi;
    
    ObjectifyWithAttributes( morphism, type,
                             Source, source,
                             Range, range,
                             UnderlyingHomalgGradedRing, HomalgRing( matrix ),
                             UnderlyingMatrix, matrix );
    
    #Add( category, morphism );
    
    return morphism;
    
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
