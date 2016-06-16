#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Serre Quotients Subcategory
##
#############################################################################

DeclareRepresentation( "IsSerreQuotientSubcategoryFunctionHandlerRep",
                       IsSerreQuotientSubcategoryFunctionHandler and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSerreQuotientSubcategoryFunctionHandler",
        NewFamily( "TheFamilyOfSerreQuotientSubcategoryFunctionHandler" ) );

BindGlobal( "TheTypeOfSerreQuotientSubcategoryFunctionHandler",
        NewType( TheFamilyOfSerreQuotientSubcategoryFunctionHandler,
                IsSerreQuotientSubcategoryFunctionHandlerRep ) );

InstallMethod( FullSubcategoryByMembershipFunction,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local handler;
    
    handler := rec( );
    
    ObjectifyWithAttributes( handler, TheTypeOfSerreQuotientSubcategoryFunctionHandler,
                             MembershipFunction, func,
                             ContainingCategory, category );
    
    return handler;
    
end );

InstallMethod( Subcategory,
               [ IsCapCategory, IsFunction ],
               
  FullSubcategoryByMembershipFunction );

InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategory( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospans,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryByCospans( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryBySpans,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryBySpans( category, MembershipFunction( handler ) );
    
end );

InstallMethod( SerreQuotientCategoryByThreeArrows,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( category, handler )
    
    if not IsIdenticalObj( category, ContainingCategory( handler ) ) then
        Error( "containing category is not the same as category" );
    fi;
    
    return SerreQuotientCategoryByThreeArrows( category, MembershipFunction( handler ) );
    
end );

InstallMethod( \/,
               [ IsCapCategory, IsSerreQuotientSubcategoryFunctionHandler ],
               
  SerreQuotientCategory );

InstallMethod( ViewObj,
               [ IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( handler )
    
    Print( "<Subcategory of " );
    Print( CAP_INTERNAL_GUESS_BEGINNING_OF_STRING_AND_MAKE_LOWERCASE( Name( ContainingCategory( handler ) ) ) );
    Print( " by " );
    Print( NameFunction( MembershipFunction( handler ) ) );
    Print( ">" );
    
end );

InstallMethod( Display,
               [ IsSerreQuotientSubcategoryFunctionHandler ],
               
  function( handler )
    
    Print( "Subcategory of " );
    Print( CAP_INTERNAL_GUESS_BEGINNING_OF_STRING_AND_MAKE_LOWERCASE( Name( ContainingCategory( handler ) ) ) );
    Print( " by " );
    Print( NameFunction( MembershipFunction( handler ) ) );
    Print( "." );
    
end );
