#############################################################################
##
##                                       ModulePresentationsForCAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#############################################################################

DeclareCategory( "IsLeftOrRightPresentationWithDegreesMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLeftPresentationWithDegreesMorphism",
                 IsLeftOrRightPresentationWithDegreesMorphism );

DeclareCategory( "IsRightPresentationWithDegreesMorphism",
                 IsLeftOrRightPresentationWithDegreesMorphism );

#############################
##
## Constructors
##
#############################

DeclareOperation( "PresentationMorphism",
                  [ IsLeftOrRightPresentationWithDegrees, IsHomalgMatrix, IsLeftOrRightPresentationWithDegrees ] );

#############################
##
## Matrix
##
#############################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsLeftOrRightPresentationWithDegreesMorphism );

DeclareAttribute( "UnderlyingMatrix",
                  IsLeftOrRightPresentationWithDegreesMorphism );

##############################################
##
## Non-categorical methods
##
##############################################

#DeclareOperation( "StandardGeneratorMorphism",
#                  [ IsLeftOrRightPresentation, IsInt ] );