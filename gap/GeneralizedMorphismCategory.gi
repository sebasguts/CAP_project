#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsGeneralizedMorphismCategoryObjectRep",
                       IsHomalgCategoryObjectRep and IsGeneralizedMorphismCategoryObject,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphismCategoryObject",
        NewType( TheFamilyOfHomalgCategoryObjects,
                IsGeneralizedMorphismCategoryObjectRep ) );

DeclareRepresentation( "IsGeneralizedMorphismRep",
                       IsHomalgCategoryMorphismRep and IsGeneralizedMorphism,
                       [ ] );

BindGlobal( "TheTypeOfGeneralizedMorphism",
        NewType( TheFamilyOfHomalgCategoryMorphisms,
                IsGeneralizedMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallGlobalFunction( CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( )
    local prop_list_pairs, prop_list_solo, i, concat_string, i_concat;
    
    prop_list_pairs := [ ];
    
    prop_list_solo := [ ];
    
    concat_string := "InUnderlyingHonestCategory";
    
    for i in CATEGORIES_FOR_HOMALG_CAN_COMPUTE_FILTER_LIST do
        
        i_concat := Concatenation( i, concat_string );
        
        ## FIXME: This syntax needs to be fixed.
        Add( prop_list_pairs, [ i, [ i, i_concat ] ] );
        
        Add( prop_list_solo, i_concat );
        
        DeclareProperty( i_concat, IsHomalgCategory );
        
        DeclareProperty( i_concat, IsHomalgCategoryCell );
        
    od;
    
    InstallValue( GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST, prop_list_pairs );
    
    InstallValue( GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST, prop_list_solo );
    
end );

CREATE_PROPAGATION_LISTS_FOR_GENERALIZED_MORPHISM_CATEGORY( );

##
InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY,
                       
  function( category )
    local entry;
    
    ## Entries between honest and generalized morphism category
    
    entry := ToDoListEntryToMaintainFollowingAttributes( [ [ category, "UnderlyingHonestCategory" ] ],
                                                         [ [ UnderlyingHonestCategory, category ], category ],
                                                         GENERALIZED_MORPHISM_CATEGORY_PROPAGATION_LIST
                                                       );
    
    AddToToDoList( entry );
    
    category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_OBJECTS := GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST;
    
    category!.PROPAGATE_FILTERS_FROM_CATEGORY_TO_MORPHISM := GENERALIZED_MORPHISM_CATEGORY_CELL_PROPAGATION_LIST;
    
    return;
    
end );

##
InstallMethod( GeneralizedMorphismCategory,
               [ IsHomalgCategory ],
               
  function( category )
    local name, generalized_morphism_category;
    
    name := Name( category );
    
    name := Concatenation( "Generalized morphism category of ", name );
    
    generalized_morphism_category := CreateHomalgCategory( name );
    
    SetUnderlyingHonestCategory( generalized_morphism_category, category );
    
    INSTALL_FUNCTIONS_FOR_GENERALIZED_MORPHISM_CATEGORY( generalized_morphism_category );
    
    SetIsEnrichedOverCommutativeRegularSemigroup( generalized_morphism_category, true );
    
    SetFilterObj( generalized_morphism_category, WasCreatedAsGeneralizedMorphismCategory );
    
    return generalized_morphism_category;
    
end );

InstallMethod( GeneralizedMorphismObject,
               [ IsHomalgCategoryObject ],
                                       
  function( object )
    local gen_object, generalized_category;
    
    gen_object := rec( );
    
    ObjectifyWithAttributes( gen_object, TheTypeOfGeneralizedMorphismCategoryObject,
                             UnderlyingHonestObject, object );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( object ) );
    
    Add( generalized_category, gen_object );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( gen_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    return gen_object;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphism,
##               [ IsHomalgCategoryMorphism, IsSubobject, IsFactorobject ], we wont check this for performance reasons.
                                       [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ],
                                       
  function( source_aid, associated_morphism, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Source( source_aid ), Source( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    elif not IsIdenticalObj( Range( range_aid ), Range( associated_morphism ) ) then
        
        Error( "range of range aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := rec( );
    
    ObjectifyWithAttributes( generalized_morphism, TheTypeOfGeneralizedMorphism,
                             Source, GeneralizedMorphismObject( Range( source_aid ) ),
                             Range, GeneralizedMorphismObject( Source( range_aid ) ) );
    
    SetSourceAid( generalized_morphism, source_aid );
    
    SetRangeAid( generalized_morphism, range_aid );
    
    SetAssociatedMorphism( generalized_morphism, associated_morphism );
    
    generalized_category := GeneralizedMorphismCategory( HomalgCategory( associated_morphism ) );
    
    Add( generalized_category, generalized_morphism );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithSourceAid,
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( source_aid, associated_morphism )
    local generalized_morphism;
    
    if not IsIdenticalObj( Source( source_aid ), Source( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( source_aid, associated_morphism, IdentityMorphism( Range( associated_morphism ) ) );
    
    SetHasHonestRange( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( GeneralizedMorphismWithRangeAid,
                                  [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism, IsHomalgCategoryMorphism ],
               
  function( associated_morphism, range_aid )
    local generalized_morphism, generalized_category;
    
    if not IsIdenticalObj( Range( range_aid ), Range( associated_morphism ) ) then
        
        Error( "source of source aid and associated morphism must be the same object" );
        
    fi;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( associated_morphism ) ), associated_morphism, range_aid );
    
    SetHasHonestSource( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethod( AsGeneralizedMorphism,
               [ IsHomalgCategoryMorphism and CanComputeIdentityMorphism ],
               
  function( associated_morphism )
    local generalized_morphism;
    
    generalized_morphism := GeneralizedMorphism( IdentityMorphism( Source( associated_morphism ) ), associated_morphism, IdentityMorphism( Range( associated_morphism ) ) );
    
    SetIsHonest( generalized_morphism, true );
    
    return generalized_morphism;
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism 
                                    and HasHonestRange
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                    IsGeneralizedMorphism and HasHonestSource ],
                                    
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return GeneralizedMorphism( SourceAid( mor1 ), PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ), RangeAid( mor2 ) );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                       [ IsGeneralizedMorphism 
                                         and HasHonestRange
                                         and CanComputePreComposeInUnderlyingHonestCategory
                                         and CanComputePullbackInUnderlyingHonestCategory,
                                         IsGeneralizedMorphism and HasHonestRange ],
                                       
  function( mor1, mor2 )
    local category, pullback, new_source_aid, new_associated_morphism;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pullback := FiberProduct( AssociatedMorphism( mor1 ), SourceAid( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_associated_morphism := PreCompose( ProjectionInFactor( pullback, 2 ), AssociatedMorphism( mor2 ) );
    
    return GeneralizedMorphismWithSourceAid( new_source_aid, new_associated_morphism );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism
                                    and HasHonestSource
                                    and CanComputePreComposeInUnderlyingHonestCategory
                                    and CanComputePushoutInUnderlyingHonestCategory,
                                  IsGeneralizedMorphism and HasHonestSource ],
                                  
  function( mor1, mor2 )
    local category, pushout, new_associated_morphism, new_range_aid;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    pushout := Pushout( RangeAid( mor1 ), AssociatedMorphism( mor2 ) );
    
    new_associated_morphism := PreCompose( AssociatedMorphism( mor1 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphismWithRangeAid( new_associated_morphism, new_range_aid );
    
end );

##
InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism
                                    and IsHonest
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                  IsGeneralizedMorphism and IsHonest ],
                                  
  function( mor1, mor2 )
    local category;
    
    category := HomalgCategory( mor1 );
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    return AsGeneralizedMorphism( PreCompose( AssociatedMorphism( mor1 ), AssociatedMorphism( mor2 ) ) );
    
end );

##
InstallTrueMethod( CanComputePreCompose,
                   CanComputeGeneralizedMorphismFromFactorToSubobjectInUnderlyingHonestCategory
                   and CanComputePullbackInUnderlyingHonestCategory
                   and CanComputePushoutInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( PreCompose,
                                  [ IsGeneralizedMorphism 
                                    and CanComputeGeneralizedMorphismFromFactorToSubobjectInUnderlyingHonestCategory
                                    and CanComputePullbackInUnderlyingHonestCategory
                                    and CanComputePushoutInUnderlyingHonestCategory
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                    IsGeneralizedMorphism ],
                                    
  function( mor1, mor2 )
    local generalized_mor_factor_sub, pullback, pushout, new_associated, new_source_aid, new_range_aid;
    
    if not IsIdenticalObj( Range( mor1 ), Source( mor2 ) ) then
        
        Error( "morphisms are not composable" );
        
    fi;
    
    generalized_mor_factor_sub := GeneralizedMorphismFromFactorToSubobject( RangeAid( mor1 ), SourceAid( mor2 ) );
    
    pullback := FiberProduct( AssociatedMorphism( mor1 ), SourceAid( generalized_mor_factor_sub ) );
    
    pushout := Pushout( RangeAid( generalized_mor_factor_sub ), AssociatedMorphism( mor2 ) );
    
    new_source_aid := PreCompose( ProjectionInFactor( pullback, 1 ), SourceAid( mor1 ) );
    
    new_associated := PreCompose( ProjectionInFactor( pullback, 2 ), InjectionOfCofactor( pushout, 1 ) );
    
    new_range_aid := PreCompose( RangeAid( mor2 ), InjectionOfCofactor( pushout, 2 ) );
    
    return GeneralizedMorphism( new_source_aid, new_associated, new_range_aid );
    
end );

##
InstallTrueMethod( CanComputeGeneralizedMorphismFromFactorToSubobject,
                   CanComputePreCompose
                   and CanComputeEpiMonoFactorization
                   and CanComputeIdentityMorphism);

InstallMethodWithCacheFromObject( GeneralizedMorphismFromFactorToSubobject,
                                  [ IsHomalgCategoryMorphism
                                    and CanComputePreCompose
                                    and CanComputeEpiMonoFactorization
                                    and CanComputeIdentityMorphism,
                                    IsHomalgCategoryMorphism ],
                                    
  function( factor, subobject )
    local composition, epi_mono_factorization;
    
    composition := PreCompose( subobject, factor );
    
    epi_mono_factorization := EpiMonoFactorization( composition );
    
    return GeneralizedMorphism( epi_mono_factorization[2], IdentityMorphism( Range( epi_mono_factorization[1] ) ), epi_mono_factorization[1] );
    
end );

##
InstallTrueMethod( CanComputeEqualityOfMorphisms,
                   CanComputeEqualityOfSubobjectsInUnderlyingHonestCategory
                   and CanComputeEqualityOfFactorobjectsInUnderlyingHonestCategory
                   and CanComputeMonoAsKernelLiftInUnderlyingHonestCategory
                   and CanComputeEpiAsCokernelColiftInUnderlyingHonestCategory
                   and CanComputeEqualityOfMorphismsInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( EqualityOfMorphisms,
                                  [ IsGeneralizedMorphism
                                    and CanComputeEqualityOfSubobjectsInUnderlyingHonestCategory
                                    and CanComputeEqualityOfFactorobjectsInUnderlyingHonestCategory
                                    and CanComputeMonoAsKernelLiftInUnderlyingHonestCategory
                                    and CanComputeEpiAsCokernelColiftInUnderlyingHonestCategory
                                    and CanComputeEqualityOfMorphismsInUnderlyingHonestCategory
                                    and CanComputePreComposeInUnderlyingHonestCategory,
                                    IsGeneralizedMorphism ],
                                  
  function( generalized_morphism1, generalized_morphism2 )
    local subobject1, subobject2, factorobject1, factorobject2, isomorphism_of_subobjects, isomorphism_of_factorobjects;
    
    if IsIdenticalObj( generalized_morphism1, generalized_morphism2 ) then
    
      return true;
      
    fi;
    
    subobject1 := SourceAid( generalized_morphism1 );
    
    subobject2 := SourceAid( generalized_morphism2 );
    
    factorobject1 := RangeAid( generalized_morphism1 );
    
    factorobject2 := RangeAid( generalized_morphism2 );
    
    if not IsEqualAsSubobject( subobject1, subobject2 ) or
       not IsEqualAsFactorobject( factorobject1, factorobject2 ) then
      
      return false;
      
    fi;
    
    isomorphism_of_subobjects := MonoAsKernelLift( subobject2, subobject1 );
    
    isomorphism_of_factorobjects := EpiAsCokernelColift( factorobject2, factorobject1 );
    
    return EqualityOfMorphisms( AssociatedMorphism( generalized_morphism1 ), PreCompose( PreCompose( isomorphism_of_subobjects, AssociatedMorphism( generalized_morphism2 ) ), isomorphism_of_factorobjects ) );
    
end );

##
InstallTrueMethod( CanComputeHonestRepresentative,
                   CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeInverseInUnderlyingHonestCategory );

InstallMethod( HonestRepresentative,
               [ IsGeneralizedMorphism
                 and CanComputePreComposeInUnderlyingHonestCategory
                 and CanComputeInverseInUnderlyingHonestCategory ],
               
  function( generalized_morphism )
    
    return PreCompose(
             PreCompose( Inverse( SourceAid( generalized_morphism ) ), AssociatedMorphism( generalized_morphism ) ), 
             Inverse( RangeAid( generalized_morphism ) ) 
           );
    
end );

##
InstallTrueMethod( CanComputeAdditionForMorphisms,
                   CanComputePullbackInUnderlyingHonestCategory
                   and CanComputeProjectionInFactorInUnderlyingHonestCategory
                   and CanComputePushoutInUnderlyingHonestCategory
                   and CanComputeInjectionOfCofactorInUnderlyingHonestCategory
                   and CanComputePreComposeInUnderlyingHonestCategory
                   and CanComputeAdditionForMorphismsInUnderlyingHonestCategory );

InstallMethodWithCacheFromObject( \+,
                                 [ IsGeneralizedMorphism
                                   and CanComputePullbackInUnderlyingHonestCategory
                                   and CanComputeProjectionInFactorInUnderlyingHonestCategory
                                   and CanComputePushoutInUnderlyingHonestCategory
                                   and CanComputeInjectionOfCofactorInUnderlyingHonestCategory
                                   and CanComputePreComposeInUnderlyingHonestCategory
                                   and CanComputeAdditionForMorphismsInUnderlyingHonestCategory, IsGeneralizedMorphism ],
                                 
  function( mor1, mor2 )
    local return_value, pullback_of_sourceaids, pushout_of_rangeaids, restricted_mor1, restricted_mor2;
    
    if not IsIdenticalObj( Source( mor1 ), Source( mor2 ) ) or not IsIdenticalObj( Range( mor1 ), Range( mor2 ) ) then
        
        Error( "morphisms are not addable" );
        
    fi;
    
    pullback_of_sourceaids := FiberProduct( SourceAid( mor1 ), SourceAid( mor2 ) );
    
    pushout_of_rangeaids := Pushout( RangeAid( mor1 ), RangeAid( mor2 ) );
    
    restricted_mor1 := PreCompose( ProjectionInFactor( pullback_of_sourceaids, 1 ), AssociatedMorphism( mor1 ) );
    
    restricted_mor1 := PreCompose( restricted_mor1, InjectionOfCofactor( pushout_of_rangeaids, 1 ) );
    
    restricted_mor2 := PreCompose( ProjectionInFactor( pullback_of_sourceaids, 2 ), AssociatedMorphism( mor2 ) );
    
    restricted_mor2 := PreCompose( restricted_mor2, InjectionOfCofactor( pushout_of_rangeaids, 2 ) );
    
    return_value := GeneralizedMorphism( 
                      PreCompose( ProjectionInFactor( pullback_of_sourceaids, 1 ), SourceAid( mor1 ) ),
                      restricted_mor1 + restricted_mor2,
                      PreCompose( RangeAid( mor1 ), InjectionOfCofactor( pushout_of_rangeaids, 1 ) )
                    );
    
    return return_value;
    
end );

###########################
##
## IsWellDefined
##
###########################

##
InstallTrueMethod( CanComputeIsWellDefinedForObjects, CanComputeIsWellDefinedForObjectsInUnderlyingHonestCategory );

InstallMethod( IsWellDefined,
               [ IsGeneralizedMorphismCategoryObjectRep
                 and CanComputeIsWellDefinedForObjectsInUnderlyingHonestCategory ],
               
  function( object )
    
    return IsWellDefined( UnderlyingHonestObject( object ) );
    
end );

##
InstallTrueMethod( CanComputeIsWellDefinedForMorphisms, CanComputeIsWellDefinedForMorphismsInUnderlyingHonestCategory );

InstallMethod( IsWellDefined,
               [ IsGeneralizedMorphismRep
                 and CanComputeIsWellDefinedForMorphismsInUnderlyingHonestCategory ],
               
  function( generalized_morphism )
    local category;
    
    category := HomalgCategory( SourceAid( generalized_morphism ) );
    
    if not ForAll( [ AssociatedMorphism( generalized_morphism ), RangeAid( generalized_morphism ) ],
                 x -> IsIdenticalObj( HomalgCategory( x ), category ) ) then
      
      return false;
      
    fi;
    
    if not ( ForAll( [ SourceAid( generalized_morphism ), AssociatedMorphism( generalized_morphism ), RangeAid( generalized_morphism ) ],
             IsWellDefined ) ) then
      
      return false;
      
    fi;
    
    return true;
    
end );