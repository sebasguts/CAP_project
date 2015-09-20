#############################################################################
##
##                                ProjCategoryForCAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareCategory( "IsProjCategoryObject",
                 IsCapCategoryObject );

####################################
##
## Constructors
##
####################################

DeclareOperation( "ProjCategoryObject",
                  [ IsList, IsHomalgGradedRing ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsProjCategoryObject );

DeclareAttribute( "Rank",
                  IsProjCategoryObject );

DeclareAttribute( "DegreeList",
                  IsProjCategoryObject );