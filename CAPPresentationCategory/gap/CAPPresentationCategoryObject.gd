#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

#############################
##
## Category
##
#############################

DeclareCategory( "IsCAPPresentationCategoryObject",
                 IsCapCategoryObject );

#############################
##
## Constructors
##
#############################

DeclareOperation( "CAPPresentationCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingMorphism",
                  IsCAPPresentationCategoryObject );

##############################################
##
## Non-categorical methods
##
##############################################

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );