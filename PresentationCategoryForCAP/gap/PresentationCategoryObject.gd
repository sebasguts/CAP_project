#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

#############################
##
## Category
##
#############################

DeclareCategory( "IsLeftOrRightPresentationWithDegrees",
                 IsCapCategoryObject );

DeclareCategory( "IsLeftPresentationWithDegrees",
                 IsLeftOrRightPresentationWithDegrees );

DeclareCategory( "IsRightPresentationWithDegrees",
                 IsLeftOrRightPresentationWithDegrees );

#############################
##
## Constructors
##
#############################

DeclareGlobalFunction( "AsLeftOrRightPresentationWithDegrees" );

DeclareOperation( "AsLeftPresentationWithDegrees",
                  [ IsList, IsHomalgMatrix ] );

DeclareOperation( "AsRightPresentationWithDegrees",
                  [ IsList, IsHomalgMatrix ] );

DeclareOperation( "FreeLeftPresentationWithDegrees",
                  [ IsList, IsHomalgGradedRing ] );

DeclareOperation( "FreeRightPresentationWithDegrees",
                  [ IsList, IsHomalgGradedRing ] );

#############################
##
## Properties
##
#############################


DeclareFamilyProperty( "IsFree",
                       IsCapCategoryMorphism,
                       "PresentationCategory",
                       "object" );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentationWithDegrees );

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsLeftOrRightPresentationWithDegrees );

DeclareAttribute( "UnderlyingMorphism",
                  IsLeftOrRightPresentationWithDegrees );

##############################################
##
## Non-categorical methods
##
##############################################

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );