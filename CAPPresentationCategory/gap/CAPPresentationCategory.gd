#############################################################################
##
##                  CAPPresentationCategory package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##                  Martin Bies,       ITP Heidelberg
##
#! @Chapter Presentation Category
##
#############################################################################

############################################
##
#! @Section Projective categories
##
############################################

#! @Description
#! Presentation categories can only be constructed over categories that are additive, have weak kernels and weak lifts.
#! This method checks if a given CapCategory $C$ is indeed such a projective category. It returns true if this is the case
#! and false otherwise.
#! @Returns true or false
#! @Arguments C
DeclareProperty( "IsProjCategory",
                 IsCapCategory );

##############################################
##
#! @Section Constructor
##
##############################################

#! @Description
#! The argument is a so-called proj-category $P$. That is an additive category with weak lifts and weak kernels.
#! The output is then the presentation category over this proj-category.
#! @Returns a category
#! @Arguments P
DeclareAttribute( "PresentationCategory",
                  IsProjCategory );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_PRESENTATION_CATEGORY" );

#DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_OBJECTS" );

#DeclareGlobalFunction( "ADD_INTERNAL_HOM_ON_MORPHISMS" );

#DeclareGlobalFunction( "ADD_BRAIDING" );

#DeclareGlobalFunction( "ADD_EVALUATION_MORPHISM" );

#DeclareGlobalFunction( "ADD_COEVALUATION_MORPHISM" );

#DeclareGlobalFunction( "ADD_TENSOR_UNIT" );

#DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_OBJECTS" );

#DeclareGlobalFunction( "ADD_TENSOR_PRODUCT_ON_MORPHISMS" );


