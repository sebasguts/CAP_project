####################################################################################
##
##                  CAPCategoryOfProjectiveGradedModules package
##
##  Copyright 2015, Martin Bies,       ITP Heidelberg
##
#! @Chapter Wrapper for generators of semigroups and hyperplane constraints of cones
##
####################################################################################

############################################
##
#! @Section GAP Categories
##
############################################

#! @Description
#! The GAP category of lists of integer-valued lists, which encode subsemigroups of $Z^n$.
#! @Arguments object
DeclareCategory( "IsSemigroupGeneratorList",
                 IsObject );

#! @Description
#! The GAP category of lists of integer-valued lists, which encode H-presentations of cones in $Z^n$.
#! @Arguments object
DeclareCategory( "IsConeHPresentationList",
                 IsObject );


############################################
##
#! @Section Constructors
##
############################################

#! @Description
#! The argument is a list $L$. We then check if this list could be the list of generators of a subsemigroup of $Z^n$.
#! If so, we create the corresponding SemigroupGeneratorList.
#! @Returns a SemigroupGeneratorList
#! @Arguments L
DeclareOperation( "SemigroupGeneratorList",
                  [ IsList ] );

#! @Description
#! The argument is a list $L$. We then check if this list could be the list of hyperplane constraints of a cone in $Z^n$.
#! If so, we create the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments L
DeclareOperation( "ConeHPresentationList",
                  [ IsList ] );

#! @Description
#! The argument is an NmzCone $C$. We then try to compute an H-presentation of $C$. In case this was successfully 
#! done, we construct the corresponding ConeHPresentationList.
#! @Returns a ConeHPresentationList
#! @Arguments C
DeclareOperation( "ConeHPresentationList",
                  [ IsNormalizCone ] );



############################################
##
#! @Section Attributes
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsSemigroupGeneratorList );

#! @Description
#! The argument is a ConeHPresentationList $L$. We then return the underlying list.
#! @Returns a list
#! @Arguments L
DeclareAttribute( "UnderlyingList",
                  IsConeHPresentationList );

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We try to convert $L$ into a ConeHPresentationList. If this
#! succeeds, the result will be a ConeHPresentationList. If the conversion is not possible
#! (because the given semigroup is not the semigroup of a cone or because Normaliz cannot perform the conversion), 
#! the result will be fail.
#! @Returns AConeHPresentationList or fail
#! @Arguments L
DeclareAttribute( "TurnIntoConeHPresentationList",
                  IsSemigroupGeneratorList );



############################################
##
#! @Section Property
##
############################################

#! @Description
#! The argument is a SemigroupGeneratorList $L$. We then check if this is the semigroup of a cone. In this case we 
#! return true, otherwise false.
#! @Returns true or false
#! @Arguments L
DeclareProperty( "IsConeSemigroup",
                  IsSemigroupGeneratorList );