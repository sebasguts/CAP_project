#############################################################################
##
##                  CAPPresentationCategory
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Convenience methods
##
#############################################################################


####################################################################################
##
#! @Section Powers of objects and morphisms
##
####################################################################################

#!
DeclareOperation( "\*",
               [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

#!
DeclareOperation( "\^",
               [ IsCAPPresentationCategoryObject, IsInt ] );

#!
DeclareOperation( "\*",
               [ IsCAPPresentationCategoryMorphism, IsCAPPresentationCategoryMorphism ] );

#!
DeclareOperation( "\^",
               [ IsCAPPresentationCategoryMorphism, IsInt ] );


####################################################################################
##
#! @Section Embeddings in projective modules
##
####################################################################################
                  
#! @Description
#! The argument is a CAPPresentationCategoryObject <A>M</A>, which we embed into a projective module 
#! (canonically embedded into the respective presentation category). For details can be found in the source code.
#! @Returns a presentation category morphism
#! @Arguments M
DeclareOperation( "EmbeddingInProjectiveObject",
                  [ IsCAPPresentationCategoryObject ] );
