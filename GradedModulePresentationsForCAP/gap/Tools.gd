#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Tools
##
#############################################################################


####################################################################################
##
#! @Section Submodule presentations
##
####################################################################################

#! @Description
#! The argument are a list <A>L</A> and a graded ring <A>S</A>. We then turn <A>L</A> into a matrix $M$ with entries from
#! <A>S</A> and interpret this matrix as a mapping of a f.p. graded left $S$-module into the projective 
#! graded <A>S</A>-module $S^n$ (with $n$ the number of columns of the matrix $M$). We return the source of this mapping.
#! @Returns a presentation category object
#! @Arguments M
DeclareOperation( "SubmoduleAsGradedLeftModulePresentation",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The argument are a list <A>L</A> and a graded ring <A>S</A>. We then turn <A>L</A> into a matrix $M$ with entries from
#! <A>S</A> and interpret this matrix as a mapping of a f.p. graded left $S$-module into the projective 
#! graded <A>S</A>-module $S^n$ (with $n$ the number of rows of the matrix $M$). We return the source of this mapping.
#! @Returns a presentation category object
#! @Arguments M
DeclareOperation( "SubmoduleAsGradedRightModulePresentation",
                  [ IsList, IsHomalgGradedRing ] );


####################################################################################
##
#! @Section Frobenius powers of presentations
##
####################################################################################

# Frobenius power of matrix
DeclareGlobalFunction( "FrobeniusPowerOfMatrix" );

#! @Description
#! The arguments are a CAPPresentationCategoryObject $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category object
#! @Arguments M, p
DeclareOperation( "FrobeniusPower",
                  [ IsCAPPresentationCategoryObject, IsInt ] );

#! @Description
#! The arguments are a CAPPresentationCategoryMorphism $M$ and a non-negative integer $p$. This method
#! then computes the $p$-th Frobenius power of $M$.
#! @Returns a presentation category morphism
#! @Arguments M, p
DeclareOperation( "FrobeniusPower",
                  [ IsCAPPresentationCategoryMorphism, IsInt ] );


####################################################################################
##
#! @Section Saturation
##
####################################################################################

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and $I$. We check that the letter can be embedded into 
#! the underlying graded ring $S$, i.e. can be viewed as an ideal in $S$. We then compute the 
#! saturation of $M$ with respect to $I$.
#! @Returns a presentation category object
#! @Arguments M, I
DeclareOperation( "Saturate",
                  [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );

#! @Description
#! The arguments are two CAPPresentationCategoryObject $M$ and $I$. We check that the letter can be embedded into 
#! the underlying graded ring $S$, i.e. can be viewed as an ideal in $S$. We then compute the embedding of $M$ into its 
#! saturation with respect to $I$.
#! @Returns a presentation category morphism
#! @Arguments M, I
DeclareOperation( "EmbeddingInSaturatedGradedModulePresentation",
                  [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ] );
