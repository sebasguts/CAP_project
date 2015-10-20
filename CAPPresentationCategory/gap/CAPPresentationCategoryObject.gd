#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Objects
##
#############################################################################

##############################
##
#! @Section The GAP Category
##
##############################

#! @Description
#! The GAP category of objects in the presentation category over a proj-category $P$.
#! @Arguments object
DeclareCategory( "IsCAPPresentationCategoryObject",
                 IsCapCategoryObject );

#############################
##
#! @Section Constructors
##
#############################

#! @Description
#! The arguments are a CAPCategoryMorphism $m$ and a CAPCategory $P$. $P$ must be a proj-category and $\alpha$ must be a
#! morphism in $P$.That said, the morphism $\alpha$ can be viewed as an object in the presentation category. The output
#! is this very object of the presentation category.
#! @Returns a CAPCategoryObject
#! @Arguments m, P
DeclareOperation( "CAPPresentationCategoryObject",
                  [ IsCapCategoryMorphism, IsCapCategory ] );

#############################
##
#! @Section Attributes
##
#############################

#! @Description
#! The argument is an object $A$ of the presentation category over a proj-category $P$. Every such object
#! is encoded by a morphism in the underlying proj-category. The output is such a morphism in the proj-category.
#! @Returns a CAPCategoryMorphism
#! @Arguments A
DeclareAttribute( "UnderlyingMorphism",
                  IsCAPPresentationCategoryObject );

####################################################
##
#! @Section Printing all information about an object
##
####################################################

#! @Description
#! The argument is an object $A$ in the presentation category. For such an object it can be tedious 
#! to work out all the details of the underlying defining morphism (such a source, ranges and the mapping matrix). 
#!  To encompass this shortcoming, this method produces all this information with just a single command.
#! @Returns detailed information about the object A
#! @Arguments A
DeclareOperation( "FullInformation",
                 [ IsCAPPresentationCategoryObject ] );

##############################################
##
## Non-categorical methods
##
##############################################

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_LEFT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );

#DeclareOperationWithCache( "INTERNAL_HOM_EMBEDDING_IN_TENSOR_PRODUCT_RIGHT",
#                           [ IsLeftOrRightPresentation, IsLeftOrRightPresentation ] );