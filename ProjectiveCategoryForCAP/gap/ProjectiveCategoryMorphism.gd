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

DeclareCategory( "IsProjectiveCategoryMorphism",
                 IsCapCategoryMorphism );

####################################
##
## Constructors
##
####################################

DeclareOperation( "ProjectiveCategoryMorphism",
                  [ IsProjectiveCategoryObject, IsHomalgMatrix, IsProjectiveCategoryObject ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsProjectiveCategoryMorphism );

DeclareAttribute( "UnderlyingHomalgMatrix",
                  IsProjectiveCategoryMorphism );