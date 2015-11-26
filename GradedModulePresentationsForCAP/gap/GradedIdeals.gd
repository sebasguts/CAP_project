#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
#! @Chapter Graded ideals of a graded ring as graded left or right presentations
##
#############################################################################


##############################################################################################
##
#! @Section GAP category of graded ideals for CAP
##
##############################################################################################

#! @Description
#! The GAP category of graded left or right ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftOrRightIdealForCAP",
                 IsCapCategoryObject );

#! @Description
#! The GAP category of graded left ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftIdealForCAP",
                 IsGradedLeftOrRightIdealForCAP );

#! @Description
#! The GAP category of graded right ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedRightIdealForCAP",
                 IsGradedLeftOrRightIdealForCAP );



##############################################################################################
##
#! @Section Constructors for graded ideals from a list list and a graded ring
##
##############################################################################################

# a function that computes a graded ideal from a listlist and a graded ring
DeclareGlobalFunction( "GradedIdealFromListListAndGradedRing" );

#! @Description
#! The arguments are a graded ring <A>R</A> and a list <A>L</A> of homogeneous elements of <A>R</A> which define 
#! the ideal. The method then returns the corresponding left ideal.
#! @Returns a graded left ideal for CAP
#! @Arguments L, R
DeclareOperation( "GradedLeftIdealForCAP",
                  [ IsList, IsHomalgGradedRing ] );

#! @Description
#! The arguments are a graded ring <A>R</A> and a list <A>L</A> of homogeneous elements of <A>R</A> which define 
#! the ideal. The method then returns the corresponding right ideal.
#! @Returns a graded right ideal for CAP
#! @Arguments L, R
DeclareOperation( "GradedRightIdealForCAP",
                  [ IsList, IsHomalgGradedRing ] );



###############################################################################################
##
#! @Section Constructors for graded submodules from a list of lists and a specified superobject
##
###############################################################################################

# a function that computes a graded ideal from a listlist and a given superobject
DeclareGlobalFunction( "GradedIdealFromListListAndGivenRange" );

#! @Description
#! The arguments are a projective graded left ideal <A>I</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the ideal. The method then returns the corresponding graded left ideal of <A>I</A>.
#! @Returns a graded left ideal for CAP
#! @Arguments L, I
DeclareOperation( "GradedLeftIdealForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedLeftModulesObject ] );

#! @Description
#! The arguments are a projective graded right ideal <A>I</A> defined over a graded ring <A>R</A>
#! and a list of lists <A>L</A> of homogeneous elements from <A>R</A> which 
#! generate the ideal. The method then returns the corresponding graded right ideal of <A>I</A>.
#! @Returns a graded right ideal for CAP
#! @Arguments L, I
DeclareOperation( "GradedRightIdealForCAP",
                  [ IsList, IsCAPCategoryOfProjectiveGradedRightModulesObject ] );



##############################################################################################
##
#! @Section Constructors for graded ideal from a morphism
##
##############################################################################################

# a function that computes a graded ideal from a morphism
DeclareGlobalFunction( "GradedIdealFromMorphism" );

#! @Description
#! The argument is a morphism of projective graded left modules <A>a</A>, whose range is of rank 1. 
#! The kernel embedding of $a$ is then used to define a left presentation that we embed into the 
#! projective module $\text{Range} \left( a \right)$. Thereby we constructed a graded left ideal.
#! @Returns a graded left ideal for CAP
#! @Arguments a
DeclareOperation( "GradedLeftIdealForCAP",
                  [ IsCAPCategoryOfProjectiveGradedLeftModulesMorphism ] );

#! @Description
#! The argument is a morphism of projective graded right modules <A>a</A>, whose range is of rank 1. 
#! The kernel embedding of $a$ is then used to define a right presentation that we embed into the 
#! projective module $\text{Range} \left( a \right)$. Thereby we constructed a graded right ideal.
#! @Returns a graded left ideal for CAP
#! @Arguments a
DeclareOperation( "GradedRightIdealForCAP",
                  [ IsCAPCategoryOfProjectiveGradedRightModulesMorphism ] );



##############################################################################################
##
#! @Section Attributes for graded ideals
##
##############################################################################################

#! @Description
#! The argument is a graded left or right ideal <A>I</A>. We then return a left or right presentation respectively.
#! @Returns a graded left or right presentation for CAP
#! @Arguments I
DeclareAttribute( "PresentationForCAP",
                  IsGradedLeftOrRightIdealForCAP );

#! @Description
#! The argument is a graded left or right ideal <A>I</A>. We then return the list of generators of this ideal.
#! @Returns a list
#! @Arguments I
DeclareAttribute( "Generators",
                  IsGradedLeftOrRightIdealForCAP );
                  
#! @Description
#! The argument is a graded left or right ideal <A>I</A> in a graded ring. We then return this graded ring.
#! @Returns a homalg graded ring
#! @Arguments I
DeclareAttribute( "HomalgGradedRing",
                  IsGradedLeftOrRightIdealForCAP );

#! @Description
#! The argument is a graded left or right ideal <A>I</A> in a graded ring. We return the embedding of this ideal into
#! the graded ring.
#! @Returns a CAP presentation category morphism
#! @Arguments I
DeclareAttribute( "EmbeddingInSuperObjectForCAP",
                  IsGradedLeftOrRightIdealForCAP );

#! @Description
#! The argument is a graded left or right ideal <A>I</A> in a graded ring. We return the superobject.
#! @Returns a CAP presentation category object
#! @Arguments I
DeclareAttribute( "SuperObjectForCAP",
                  IsGradedLeftOrRightIdealForCAP );



##############################################################################################
##
#! @Section Full information of an ideal
##
##############################################################################################

#! @Description
#! The argument is a graded left or right ideal $I$. This method displays $I$ in great detail.
#! @Returns detailed information about I
#! @Arguments I
DeclareOperation( "FullInformation",
                 [ IsGradedLeftOrRightIdealForCAP ] );

                  

##############################################################################################
##
#! @Section Ideal powers
##
##############################################################################################

#!
DeclareOperation( "\*",
                  [ IsGradedLeftOrRightIdealForCAP, IsGradedLeftOrRightIdealForCAP ] );

#!
DeclareOperation( "\^",
                  [ IsGradedLeftOrRightIdealForCAP, IsInt ] );



##############################################################################################
##
#! @Section Frobenius powers for ideals
##
##############################################################################################

#!
DeclareOperation( "FrobeniusPower",
                  [ IsGradedLeftOrRightIdealForCAP, IsInt ] );