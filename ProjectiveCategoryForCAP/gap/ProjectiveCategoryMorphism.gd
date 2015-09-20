#############################################################################
##
##                                LinearAlgebraForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsProjCategoryMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Constructors
##
####################################

DeclareOperation( "ProjCategoryMorphism",
                  [ IsProjCategoryObject, IsHomalgMatrix, IsProjCategoryObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsProjCategoryMorphism );

DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsProjCategoryMorphism );
