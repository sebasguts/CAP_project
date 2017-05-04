#############################################################################
##
##                                GroupRepresentationsForCAP package
##
##  Copyright 2016, Sebastian Posur, University of Siegen
##
#! @Chapter Semisimple Categories
##
#############################################################################

DeclareCategory( "IsSemisimpleCategory",
                 IsCapCategory );

#! @Section Introduction

#! Let $k$ be a field and $I$ be a totally ordered set.
#! We denote the matrix category of $k$ by $k\mathrm{-vec}$
#! (see the package $\texttt{LinearAlgebraForCAP}$).
#! The semisimple category
#! $\bigoplus_{i \in I} k\mathrm{-vec}$
#! associated to $k$ and $I$ is defined as the
#! full subcategory of the product category
#! $\prod_{i \in I} k\mathrm{-vec}$
#! generated by those $I$-indexed tuples
#! having only finitely many non-zero entries.
#! By $\chi^i$, we denote the object which
#! is $1$ at entry $i$ and $0$ otherwise.
#! Thus, an arbitrary object in $\bigoplus_{i \in I} k\mathrm{-vec}$
#! can be written as
#! $\oplus_{i \in I}a_i \chi^i$
#! for non-negative numbers $a_i$ for which
#! only finitely many are non-zero.

####################################
##
#! @Section Constructors
##
####################################

#! @Description
#! The arguments are:
#! - a homalg field $k$,
#! - a membership function $m$ sending any GAP object to a boolean,
#! - a GAP object $u$,
#! - a string $s$ containing a filename in the folder "/gap/AssociatorsDatabase/" of this package,
#! - a boolean $b$,
#! - a list $L$ containing 4 entries, where the first 3 are filters and the last one is a string.
#! The output is a CAP category modelling
#! $\bigoplus_{i \in I} k\mathrm{-vec}$,
#! where $I$ is the set defined by the membership function $m$.
#! Note that objects in $I$ are expected to be equipped
#! with operations enlisted in the chapter "Irreducible Objects".
#! Furthermore, this CAP category is a
#! rigid symmetric closed monoidal Abelian category.
#! Its tensor product is defined by the data of the file $s$,
#! where the boolean $b$ is true if the associator stored in $s$
#! was computed for all triples, and false otherwise (cf. chapter "Associators").
#! Its braiding and duality comes from the additional structure required for $I$.
#! Its tensor unit is modelled by $u$.
#! The three filters of the $L$ are filters for the resulting category,
#! its objects, and its morphisms. $L_4$ is the name of the resulting category.
#! @Returns a category
#! @Arguments k, m, u, s, b, L
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool, IsList ] );

#! @Description
#! The arguments are:
#! - a homalg field $k$,
#! - a membership function $m$ sending any GAP object to a boolean,
#! - a GAP object $u$,
#! - a string $s$ containing a filename in the folder "/gap/AssociatorsDatabase/" of this package,
#! - a boolean $b$.
#! This function calls SemisimpleCategory on the six arguments
#! [ k, m, u, s, b, [ IsObject, IsObject, IsObject, automatically generated name ] ]
#! @Returns a category
#! @Arguments k, m, u, s, b
DeclareOperation( "SemisimpleCategory",
                  [ IsFieldForHomalg, IsFunction, IsObject, IsString, IsBool ] );

####################################
##
#! @Section Attributes
##
####################################

#! @Description
#! The argument is a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is its underlying membership function $m$ for $I$.
#! @Returns a function
#! @Arguments C
DeclareAttribute( "MembershipFunctionForSemisimpleCategory",
                  IsSemisimpleCategory );

#! @Description
#! The argument is a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is its underlying category $k\mathrm{-vec}$.
#! @Returns a category
#! @Arguments C
DeclareAttribute( "UnderlyingCategoryForSemisimpleCategory",
                  IsSemisimpleCategory );

#! @Description
#! The argument is a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is its underlying field $k$.
#! @Returns a homalg field
#! @Arguments C
DeclareAttribute( "UnderlyingFieldForHomalgForSemisimpleCategory",
                  IsSemisimpleCategory );


#! @Description
#! The argument is a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is its object filter which could be specified in the constructor of $C$.
#! @Returns a filter
#! @Arguments C
DeclareAttribute( "GivenObjectFilterForSemisimpleCategory",
                  IsSemisimpleCategory );

#! @Description
#! The argument is a semisimple category $C = \bigoplus_{i \in I} k\mathrm{-vec}$.
#! The output is its morphism filter which could be specified in the constructor of $C$.
#! @Returns a filter
#! @Arguments C
DeclareAttribute( "GivenMorphismFilterForSemisimpleCategory",
                  IsSemisimpleCategory );


####################################
##
#! @Section Internals
##
####################################

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorOnIrreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorFromCoherenceAxiomLeft", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject,
                             IsSemisimpleCategoryMorphism, IsSemisimpleCategoryMorphism ] );

##
DeclareOperationWithCache( "CAP_INTERNAL_AssociatorFromCoherenceAxiomRight", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject, IsSemisimpleCategoryObject,
                             IsSemisimpleCategoryMorphism, IsSemisimpleCategoryMorphism ] );
##
DeclareOperationWithCache( "CAP_INTERNAL_Braiding_On_Irreducibles", 
                           [ IsSemisimpleCategoryObject, IsSemisimpleCategoryObject ] );

##
DeclareAttribute( "CAP_INTERNAL_EvaluationForDualOnIrreduciblesAsString", IsSemisimpleCategoryObject );


##
DeclareOperation( "CAP_INTERNAL_DirectSumForPermutationLists",
                  [ IsList, IsList ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromRight",
                  [ IsList, IsInt ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationWithIdentityFromLeft",
                  [ IsList, IsInt ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromRight",
                  [ IsList, IsSemisimpleCategoryObject, IsList ] );

##
DeclareOperation( "CAP_INTERNAL_TensorProductOfPermutationListWithObjectFromLeft",
                  [ IsList, IsSemisimpleCategoryObject, IsList ] );

##
DeclareGlobalFunction( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareGlobalVariable( "CAP_INTERNAL_FIELD_FOR_SEMISIMPLE_CATEGORY" );

##
DeclareOperationWithCache( "CAP_INTERNAL_ExpandSemisimpleCategoryObjectList",
                           [ IsList ] );

##
DeclareGlobalFunction( "CAP_INTERNAL_Create_Sparse_String" );

##
DeclareGlobalFunction( "CAP_INTERNAL_Create_Sparse_Identity_String" );