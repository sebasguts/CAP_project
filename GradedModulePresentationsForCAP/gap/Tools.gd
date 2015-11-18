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
#! @Section Tools to make GradedModulePresentationsForCAP more useable
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
