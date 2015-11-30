#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
## @Chapter Serre Quotients
##
#############################################################################

DeclareCategory( "IsSerreQuotientCategoryByCospansObject",
                 IsSerreQuotientCategoryObject );

DeclareCategory( "IsSerreQuotientCategoryByCospansMorphism",
                 IsSerreQuotientCategoryMorphism );

##############################################
##
## Attributes for serre category
##
##############################################

DeclareFilter( "WasCreatedAsSerreQuotientCategoryByCospans" );

##############################################
##
## Attributes
##
##############################################

DeclareOperation( "AsSerreQuotientByCospansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

##############################################
##
## Constructor
##
##############################################

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategoryByCospans",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AsSerreQuotientCategoryByCospansObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsGeneralizedMorphismByCospan ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AsSerreQuotientCategoryByCospansMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

