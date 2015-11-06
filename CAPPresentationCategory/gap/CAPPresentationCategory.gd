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
                  IsCapCategory );

##############################################
##
## Add methods
##
##############################################

DeclareGlobalFunction( "ADD_FUNCTIONS_FOR_PRESENTATION_CATEGORY" );

#DeclareGlobalFunction( "ADD_EVALUATION_MORPHISM" );

#DeclareGlobalFunction( "ADD_COEVALUATION_MORPHISM" );

