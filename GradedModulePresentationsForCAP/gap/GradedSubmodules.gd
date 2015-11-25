#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Graded submodules of projective graded modules over a graded ring
##
#############################################################################


##############################################################################################
##
#! @Section GAP category of graded submodules for CAP
##
##############################################################################################

#! @Description
#! The GAP category of graded left or right submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightSubmoduleForCAP",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of graded left submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftSubmoduleForCAP",
                 IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The GAP category of graded right submodules for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedRightSubmoduleForCAP",
                 IsGradedLeftOrRightSubmoduleForCAP );



##############################################################################################
##
#! @Section Constructors for graded submodules
##
##############################################################################################

#! @Description
#! The arguments are a graded ring <A>R</A> and a list of lists <A>L</A> of homogeneous elements of <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded left submodule.
#! @Returns a graded left submodule for CAP
#! @Arguments L, R
DeclareOperation( "GradedLeftSubmoduleForCAP",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The arguments are a projective graded left module <A>M</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded left submodule of <A>M</A>.
#! @Returns a graded left submodule for CAP
#! @Arguments L, M
DeclareOperation( "GradedLeftSubmoduleForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );
                  
#! @Description
#! The arguments are a graded ring <A>R</A> and a list of lists <A>L</A> of homogeneous elements of <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded right submodule.
#! @Returns a graded right submodule for CAP
#! @Arguments L, R
DeclareOperation( "GradedRightSubmoduleForCAP",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The arguments are a projective graded right module <A>M</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the submodule. The method then returns the corresponding graded right submodule of <A>M</A>.
#! @Returns a graded right submodule for CAP
#! @Arguments L, M
DeclareOperation( "GradedRightSubmoduleForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ] );


##############################################################################################
##
#! @Section Attributes for graded submodules
##
##############################################################################################

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We then return a left or right presentation of this submodule, respectively.
#! @Returns a graded left presentation for CAP
#! @Arguments M
DeclareAttribute( "PresentationForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We then return the list of generators of this submodule.
#! @Returns a list
#! @Arguments M
DeclareAttribute( "Generators",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. We then return this graded ring.
#! @Returns a graded homalg ring
#! @Arguments M
DeclareAttribute( "HomalgGradedRing",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> over a graded ring. 
#! We return the embedding of this module into the corresponding projective graded module.
#! @Returns a CAP presentation category morphism
#! @Arguments I
DeclareAttribute( "EmbeddingInSuperObjectForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );

#! @Description
#! The argument is a graded left or right submodule <A>M</A> in a graded ring. We return the superobject.
#! @Returns a CAP presentation category object
#! @Arguments I
DeclareAttribute( "SuperObjectForCAP",
                  IsGradedLeftOrRightSubmoduleForCAP );


##############################################################################################
##
#! @Section Submodule powers
##
##############################################################################################

#!
DeclareOperation( "\*",
                  [ IsGradedLeftOrRightSubmoduleForCAP, IsGradedLeftOrRightSubmoduleForCAP ] );

#!
DeclareOperation( "\^",
                  [ IsGradedLeftOrRightSubmoduleForCAP, IsInt ] );



##############################################################################################
##
#! @Section Frobenius powers for submodules
##
##############################################################################################

#!
DeclareOperation( "FrobeniusPower",
                  [ IsGradedLeftOrRightSubmoduleForCAP, IsInt ] );