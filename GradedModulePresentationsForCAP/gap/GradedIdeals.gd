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
#! The GAP category of graded left ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedLeftIdealForCAP",
                 IsObject );

#! @Description
#! The GAP category of graded right ideals for CAP.
#! @Returns true or false
#! @Arguments object
DeclareCategory( "IsGradedRightIdealForCAP",
                 IsObject );



##############################################################################################
##
#! @Section Constructors for graded ideals
##
##############################################################################################

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



##############################################################################################
##
#! @Section Attributes for graded ideals
##
##############################################################################################

#! @Description
#! The argument is a graded left ideal <A>I</A>. We then return a left presentation of this ideal.
#! @Returns a graded left presentation for CAP
#! @Arguments I
DeclareAttribute( "PresentationForCAP",
                  IsGradedLeftIdealForCAP );

#! @Description
#! The argument is a graded right ideal <A>I</A>. We then return a right presentation of this ideal.
#! @Returns a graded right presentation for CAP
#! @Arguments I
DeclareAttribute( "PresentationForCAP",
                  IsGradedRightIdealForCAP );

#! @Description
#! The argument is a graded left ideal <A>I</A>. We then return the list of generators of this ideal.
#! @Returns a list
#! @Arguments I
DeclareAttribute( "Generators",
                  IsGradedLeftIdealForCAP );
                  
#! @Description
#! The argument is a graded right ideal <A>I</A>. We then return the list of generators of this ideal.
#! @Returns a list
#! @Arguments I
DeclareAttribute( "Generators",
                  IsGradedRightIdealForCAP );

#! @Description
#! The argument is a graded left ideal <A>I</A> in a graded ring. We then return this graded ring.
#! @Returns a homalg graded ring
#! @Arguments I
DeclareAttribute( "HomalgGradedRing",
                  IsGradedLeftIdealForCAP );

#! @Description
#! The argument is a graded right ideal <A>I</A> in a graded ring. We then return this graded ring.
#! @Returns a homalg graded ring
#! @Arguments I
DeclareAttribute( "HomalgGradedRing",
                  IsGradedRightIdealForCAP );

#! @Description
#! The argument is a graded left ideal <A>I</A> in a graded ring. We return the embedding of this ideal into
#! the graded ring.
#! @Returns a CAP presentation category morphism
#! @Arguments I
DeclareAttribute( "EmbeddingInSuperObjectForCAP",
                  IsGradedLeftIdealForCAP );

#! @Description
#! The argument is a graded right ideal <A>I</A> in a graded ring. We return the embedding of this ideal into
#! the graded ring.
#! @Returns a CAP presentation category morphism
#! @Arguments I
DeclareAttribute( "EmbeddingInSuperObjectForCAP",
                  IsGradedRightIdealForCAP );

#! @Description
#! The argument is a graded left ideal <A>I</A> in a graded ring. We return the superobject.
#! @Returns a CAP presentation category object
#! @Arguments I
DeclareAttribute( "SuperObjectForCAP",
                  IsGradedLeftIdealForCAP );

#! @Description
#! The argument is a graded right ideal <A>I</A> in a graded ring. We return the superobject.
#! @Returns a CAP presentation category object
#! @Arguments I
DeclareAttribute( "SuperObjectForCAP",
                  IsGradedRightIdealForCAP );


##############################################################################################
##
#! @Section Ideal powers
##
##############################################################################################

#!
DeclareOperation( "\*",
                  [ IsGradedLeftIdealForCAP, IsGradedLeftIdealForCAP ] );

#!
DeclareOperation( "\^",
                  [ IsGradedLeftIdealForCAP, IsInt ] );

#!
DeclareOperation( "\*",
                  [ IsGradedRightIdealForCAP, IsGradedRightIdealForCAP ] );

#!
DeclareOperation( "\^",
                  [ IsGradedRightIdealForCAP, IsInt ] );


                  
##############################################################################################
##
#! @Section Frobenius powers for ideals
##
##############################################################################################

#!
DeclareOperation( "FrobeniusPower",
                  [ IsGradedLeftIdealForCAP, IsInt ] );

#!
DeclareOperation( "FrobeniusPower",
                  [ IsGradedRightIdealForCAP, IsInt ] );
