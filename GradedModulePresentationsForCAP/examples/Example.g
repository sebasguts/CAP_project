#! @Chapter Examples and Tests

#! @Section The category SfpgrmodLeft

LoadPackage( "ToricVarieties" );;
LoadPackage( "GradedModulePresentationsForCAP" );;

#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
P1xP1 := P1*P1;
#! <A projective toric variety of dimension 2 which is a product of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
S := CoxRing( P1xP1 );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
category_left := SfpgrmodLeft( S );
#! Presentation category over CAP category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor1_left := FunctorLessGradedGeneratorsLeft( S );
#! Less generators for Presentation category over CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor2_left := FunctorGradedStandardModuleLeft( S );
#! Standard module for Presentation category over CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
natural_transformation_left := 
NaturalIsomorphismFromIdentityToGradedStandardModuleLeft( S );
#! Natural isomorphism from Id to Standard module for Presentation category over 
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample

#! @Section The category SfpgrmodLeft

#! @Example
category_right := SfpgrmodRight( S );
#! Presentation category over CAP category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor1_right := FunctorLessGradedGeneratorsRight( S );
#! Less generators for Presentation category over CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
functor2_right := FunctorGradedStandardModuleRight( S );
#! Standard module for Presentation category over CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
natural_transformation_right := 
NaturalIsomorphismFromIdentityToGradedStandardModuleRight( S );
#! Natural isomorphism from Id to Standard module for Presentation category over 
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
#! @EndExample