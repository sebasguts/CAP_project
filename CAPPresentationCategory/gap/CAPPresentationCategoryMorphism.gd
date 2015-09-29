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

DeclareCategory( "IsCAPPresentationCategoryMorphism",
                 IsCapCategoryMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "CAPPresentationCategoryMorphism",
                  [ IsCAPPresentationCategoryObject, IsCapCategoryMorphism, IsCAPPresentationCategoryObject ] );

#############################
##
## Attributes
##
#############################

DeclareAttribute( "UnderlyingMorphism",
                  IsCAPPresentationCategoryMorphism );
                  
##############################################
##
## Non categorical methods
##
##############################################

# StandardGeneratorMorphism -> this is what? Do I need it here?