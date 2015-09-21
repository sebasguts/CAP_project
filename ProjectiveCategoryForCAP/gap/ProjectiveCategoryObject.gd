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

DeclareCategory( "IsProjectiveCategoryObject",
                 IsCapCategoryObject );

####################################
##
## Constructors
##
####################################

DeclareOperation( "ProjectiveCategoryObject",
                  [ IsList, IsHomalgGradedRing ] );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "UnderlyingHomalgGradedRing",
                  IsProjectiveCategoryObject );

DeclareAttribute( "DegreeList",
                  IsProjectiveCategoryObject );
                  
DeclareAttribute( "RankOfObject",
                  IsProjectiveCategoryObject );