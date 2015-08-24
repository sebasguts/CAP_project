#############################################################################
##
##                  GeneralizedMorphismsForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryByCospansObjectRep",
                       IsCapCategoryObjectRep and IsGeneralizedMorphismCategoryByCospansObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryByCospansObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsGeneralizedMorphismCategoryByCospansObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismByCospanRep",
                       IsCapCategoryMorphismRep and IsGeneralizedMorphismByCospan,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismByCospan",
        NewType( TheFamilyOfCapCategoryMorphisms,
                IsGeneralizedMorphismByCospanRep ) );

####################################
##
## Installer
##
####################################

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS,
                       
  function( category )
    local entry, underlying_honest_category;
    
    underlying_honest_category := UnderlyingHonestCategory( category );
    
    AddIsEqualForObjects( category,
      
      function( object_1, object_2 )
          
          return IsEqualForObjects( UnderlyingHonestObject( object_1 ), UnderlyingHonestObject( object_2 ) );
          
    end );
    
    AddIsCongruentForMorphisms( category,
                                
      function( morphism1, morphism2 )
        local arrow_tuple, pullback_diagram1, pullback_diagram2, subobject1, subobject2;
        
        arrow_tuple := [ Arrow( morphism1 ), ReversedArrow( morphism1 ) ];
        
        pullback_diagram1 := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
        
        arrow_tuple := [ Arrow( morphism2 ), ReversedArrow( morphism2 ) ];
        
        pullback_diagram2 := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
        
        subobject1 := UniversalMorphismIntoDirectSum( pullback_diagram1 );
        
        subobject2 := UniversalMorphismIntoDirectSum( pullback_diagram2 );
        
        return IsEqualAsSubobjects( subobject1, subobject2 );
        
    end );
    
    ## PreCompose
    
    
    AddPreCompose( category, [
      
      [ function( morphism1, morphism2 )
          local pushout_diagram, injection_left, injection_right;
          
          pushout_diagram := [ ReversedArrow( morphism1 ), Arrow( morphism2 ) ];
          
          injection_left := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
          
          injection_right := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
          
          return GeneralizedMorphismByCospan( PreCompose( Arrow( morphism1 ), injection_left ), PreCompose( ReversedArrow( morphism1 ), injection_right ) );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          local arrow, reversed_arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return AsGeneralizedMorphismByCospan( arrow );
          
      end, [ IsHonest, IsHonest ] ],
      
      [ function( morphism1, morphism2 )
          local arrow;
          
          arrow := PreCompose( Arrow( morphism1 ), Arrow( morphism2 ) );
          
          return GeneralizedMorphismByCospan( arrow, ReversedArrow( morphism2 ) );
          
      end, [ IsHonest, ] ] ] );
    
    
    ## AdditionForMorphisms
    
    AddAdditionForMorphisms( category, [
                             
      [ function( morphism1, morphism2 )
          local pushout_diagram, pushout_left, pushout_right, arrow, reversed_arrow;
          
          pushout_diagram := [ ReversedArrow( morphism1 ), ReversedArrow( morphism2 ) ];
          
          pushout_left := InjectionOfCofactorOfPushout( pushout_diagram, 1 );
          
          pushout_right := InjectionOfCofactorOfPushout( pushout_diagram, 2 );
          
          arrow := PreCompose( Arrow( morphism1 ), pushout_left ) + PreCompose( Arrow( morphism2 ), pushout_right );
          
          reversed_arrow := PreCompose( pushout_diagram[ 1 ], pushout_left );
          
          return GeneralizedMorphismByCospan( arrow, reversed_arrow );
          
      end, [ ] ],
      
      [ function( morphism1, morphism2 )
          
          return AsGeneralizedMorphismByCospan( Arrow( morphism1 ) + Arrow( morphism2 ) );
          
      end, [ IsHonest, IsHonest ] ] ] );
      
    AddAdditiveInverseForMorphisms( category, [
                                    
      [ function( morphism )
           
         return GeneralizedMorphismByCospan( - Arrow( morphism ), ReversedArrow( morphism ) );
         
      end, [ ] ],
      
      [ function( morphism )
          
          return AsGeneralizedMorphismByCospan( - Arrow( morphism ) );
          
      end, [ IsHonest ] ] ] );
    
    AddZeroMorphism( category,
      
      function( obj1, obj2 )
        local morphism;
        
        morphism := ZeroMorphism( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
        return AsGeneralizedMorphismByCospan( morphism );
        
    end );
    
    
    ## identity
    
    AddIdentityMorphism( category,
    
      function( generalized_object )
        local identity_morphism;
        
        identity_morphism := IdentityMorphism( UnderlyingHonestObject( generalized_object ) );
        
        return AsGeneralizedMorphismByCospan( identity_morphism );
        
    end );
    
    if CurrentOperationWeight( underlying_honest_category!.derivations_weight_list, "IsWellDefinedForObjects" ) < infinity then
        
        AddIsWellDefinedForObjects( category,
          
          function( object )
              
              return IsWellDefined( UnderlyingHonestObject( object ) );
              
          end );
          
    fi;
    
    if CurrentOperationWeight( underlying_honest_category!.derivations_weight_list, "IsWellDefinedForMorphisms" ) < infinity then
        
        AddIsWellDefinedForMorphisms( category,
                                      
          function( generalized_morphism )
            local category;
            
            category := CapCategory( Arrow( generalized_morphism ) );
            
            if not ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                        x -> IsIdenticalObj( CapCategory( x ), category ) ) then
              
              return false;
              
            fi;
            
            if not ( ForAll( [ Arrow( generalized_morphism ), ReversedArrow( generalized_morphism ) ],
                    IsWellDefined ) ) then
              
              return false;
              
            fi;
            
            return true;
            
        end );
        
    fi;
    
    
    ## Additional method for a category, when generalized morphism category is present.
    
    InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobject,
                                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ),
                                    IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                                    
      function( factor, subobject )
        local pushout_diagram;
        
        factor := AsGeneralizedMorphismByCospan( factor );
        
        subobject := AsGeneralizedMorphismByCospan( subobject );
        
        return PreCompose( PseudoInverse( factor ), PseudoInverse( subobject ) );
        
    end );
    
    InstallMethod( IdempotentDefinedBySubobject,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( subobject )
        
        return GeneralizedMorphismWithSourceAid( subobject, subobject );
        
    end );
    
    InstallMethod( IdempotentDefinedByFactorobject,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( factorobject )
        
        return GeneralizedMorphismWithRangeAid( factorobject, factorobject );
        
    end );
    
    InstallMethod( GeneralizedInverse,
                  [ IsCapCategoryMorphism and MorphismFilter( underlying_honest_category ) ],
                  
      function( morphism )
        
        return PseudoInverse( AsGeneralizedMorphism( morphism ) );
        
    end );
    
    return;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( GeneralizedMorphismCategoryByCospans,
               [ IsCapCategory ],
               
  function( category )
    local name, generalized_morphism_category, category_weight_list, i, preconditions;
    
    if not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        
        return;
        
    elif not IsAbelianCategory( category ) then
        
        Error( "the category must be abelian" );
        
        return;
      
    fi;
    
    preconditions := [ "IsEqualAsSubobjects",
                       "IsEqualAsFactorobjects",
                       "MonoAsKernelLift",
                       "EpiAsCokernelColift",
                       "PreCompose",
                       "IdentityMorphism",
                       "FiberProduct",
                       "Pushout",
                       "ProjectionInFactorOfFiberProduct",
                       "InjectionOfCofactorOfPushout",
                       "AdditionForMorphisms",
                       "CoastrictionToImage",
                       "ImageEmbedding" ];
    
    category_weight_list := category!.derivations_weight_list;
    
    for i in preconditions do
        
        if CurrentOperationWeight( category_weight_list, i ) = infinity then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "Cospan generalized morphism category of ", name );
    
    generalized_morphism_category := CreateCapCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY_BY_COSPANS( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategoryByCospans );
    
    Finalize( generalized_morphism_category );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismByCospansObject,
               [ IsCapCategoryObject ],
                                       
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryByCospansObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategoryByCospans( CapCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismByCospan,
                                  [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( arrow, reversed_arrow )
    local generalized_morphism, generalized_category;
    
    if not IsEqualForObjects( Range( arrow ), Range( reversed_arrow ) ) then
        
        Error( "Ranges of morphisms must coincide" );
        
    fi;

    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphism,
                             Source, GeneralizedMorphismByCospansObject( Source( arrow ) ),
                             Range, GeneralizedMorphismByCospansObject( Source( reversed_arrow ) ) );
    
    SetArrow( generalized_morphism, arrow );
    
    SetReversedArrow( generalized_morphism, reversed_arrow );
    
    generalized_category := GeneralizedMorphismCategoryByCospans( CapCategory( arrow ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphismByCospan,
               [ IsCapCategoryMorphism ],
               
  function( arrow )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphismByCospan( arrow, IdentityMorphism( Range( arrow ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

#################################
##
## Additional methods
##
#################################

InstallMethod( IsHonest,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    local reversed_arrow;
    
    reversed_arrow := ReversedArrow( morphism );
    
    if not IsEqualForObjects( Source( reversed_arrow ), Range( reversed_arrow ) ) then
        
        return false;
        
    fi;
    
    return IsCongruentForMorphisms( reversed_arrow, IdentityMorphism( Source( reversed_arrow ) ) );
    
end );

InstallMethod( NormalizedCospanTuple,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    local arrow_tuple, pullback_diagram;
    
    arrow_tuple := [ Arrow( morphism ), ReversedArrow( morphism ) ];
    
    pullback_diagram := [ ProjectionInFactorOfFiberProduct( arrow_tuple, 1 ), ProjectionInFactorOfFiberProduct( arrow_tuple, 2 ) ];
    
    return [ InjectionOfCofactorOfPushout( pullback_diagram, 1 ), InjectionOfCofactorOfPushout( pullback_diagram, 2 ) ];
    
end );

InstallMethod( NormalizedCospan,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    
    return CallFuncList( GeneralizedMorphismByCospan, NormalizedCospanTuple( morphism ) );
    
end );

InstallMethod( PseudoInverse,
               [ IsGeneralizedMorphismByCospan ],
               
  function( morphism )
    
    return GeneralizedMorphismByCospan( ReversedArrow( morphism ), Arrow( morphism ) );
    
end );

InstallMethod( GeneralizedInverseByCospan,
               [ IsCapCategoryMorphism ],
               
  function( morphism )
    
    return GeneralizedMorphismByCospan( IdentityMorphism( Range( morphism ) ), morphism );
    
end );