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

#! @Section The category SfpgrmodRight

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


#! @Section Truncations in SfpgrmodLeft

#! @Example
Q1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[2,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1], [[-1,0],1] ], S );
#! <A projective graded left module of rank 2>
Q3 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q4 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
m1l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1, HomalgMatrix( [["x_1","x_2^3"]], S ) ,Q2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q2, HomalgMatrix( [[1],[0]], S ) ,Q3 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m3l := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q4, HomalgMatrix( [[1]], S ) ,Q3 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
left_category := CapCategory( Q1 ); 
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
left_presentation1 := CAPPresentationCategoryObject( m1l, left_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
left_presentation2 := CAPPresentationCategoryObject( m2l, left_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
left_presentation3 := CAPPresentationCategoryObject( m3l, left_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
truncation_functor_left := TruncationFunctorLeft( S, [[1,0],[0,1]] );
#! Truncation functor for Presentation category over CAP category of projective
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ]
truncation1l := ApplyFunctor( truncation_functor_left, left_presentation1 );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation1l );
#! ================================================================================= 
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and 
#! degrees: 
#! [  ]
#!
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 1 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
truncation2l := ApplyFunctor( truncation_functor_left, left_presentation2 );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation2l );
#! ================================================================================= 
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and 
#! degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! 1
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
morl := CAPPresentationCategoryMorphism( left_presentation1, m2l, left_presentation3 );
#! <A morphism of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
trmorl := ApplyFunctor( truncation_functor_left, morl );
#! <A morphism of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( trmorl );
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! (an empty 0 x 1 matrix)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
#!
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
#!
#! @EndExample


#! @Section Truncations in SfpgrmodRight

#! @Example
P1 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[2,0],1] ], S );
#! <A projective graded right module of rank 1>
P2 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1], [[-1,0],1] ], S );
#! <A projective graded right module of rank 2>
P3 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
P4 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
m1r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P1, HomalgMatrix( [["x_1"],["x_2^3"]], S ) ,P2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P2, HomalgMatrix( [[1,0]], S ) ,P3 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m3r := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P4, HomalgMatrix( [[1]], S ) ,P3 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
right_category := CapCategory( P1 ); 
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
right_presentation1 := CAPPresentationCategoryObject( m1r, right_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
right_presentation2 := CAPPresentationCategoryObject( m2r, right_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
right_presentation3 := CAPPresentationCategoryObject( m3r, right_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
truncation_functor_right := TruncationFunctorRight( S, [[1,0],[0,1]] );
#! Truncation functor for Presentation category over CAP category of projective
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ]
truncation1r := ApplyFunctor( truncation_functor_right, right_presentation1 );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation1r );
#! =================================================================================
#!  
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! =================================================================================
truncation2r := ApplyFunctor( truncation_functor_right, right_presentation2 );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( truncation2r );
#! ================================================================================= 
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and 
#! degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix:
#! 1
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#!
#! ================================================================================= 
morr := CAPPresentationCategoryMorphism( right_presentation1, m2r, right_presentation3 );
#! <A morphism of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
trmorr := ApplyFunctor( truncation_functor_right, morr );
#! <A morphism of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( trmorr );
#! ================================================================================= 
#!
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 0 and degrees: 
#! [  ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 1 x 0 matrix)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#! 
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix:
#! 1
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! =================================================================================
#!
#! @EndExample


#! @Section Convenience methods for SfpgrmodLeft

#! @Example
irrelIdealLeft := SubmoduleAsGradedLeftModulePresentation( 
              [ [ "x_1" ],[ "x_2" ],[ "x_3" ],[ "x_4" ] ], S );
#! <An object of the presentation category over the CAP category 
#! of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( irrelIdealLeft );
#!
#! ================================================================================= 
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 6 and degrees: 
#! [ [ ( 0, 2 ), 1 ], [ ( 1, 1 ), 2 ], [ ( 2, 0 ), 1 ], [ ( 1, 1 ), 2 ] ]
#!
#! A morphism in the category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) with matrix: 
#! 0, 0, -x_4, x_3,
#! 0, -x_3, x_2, 0,  
#! 0, -x_4, 0, x_2,
#! -x_2, x_1, 0, 0,  
#! -x_3, 0, x_1, 0,  
#! -x_4, 0, 0, x_1 
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 0 ), 2 ], [ ( 0, 1 ), 2 ] ]
#! 
#! ================================================================================= 
#!

#! @EndExample


#! @Section Convenience methods for SfpgrmodRight

#! @Example
irrelIdealRight := SubmoduleAsGradedRightModulePresentation( 
              [ [ "x_1", "x_2", "x_3", "x_4" ] ], S );
#! <An object of the presentation category over the CAP category 
#! of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( irrelIdealRight );
#!
#! ================================================================================= 
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 6 and degrees:
#! [ [ ( 0, 2 ), 1 ], [ ( 1, 1 ), 2 ], [ ( 2, 0 ), 1 ], [ ( 1, 1 ), 2 ] ]
#!
#! A morphism in the category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) with matrix:
#! 0, 0, 0, -x_2, -x_3, -x_4,
#! 0, -x_3, -x_4, x_1, 0, 0,
#! -x_4, x_2, 0, 0, x_1, 0,
#! x_3, 0, x_2, 0, 0, x_1
#! (over a graded ring)
#!
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 4 and degrees: 
#! [ [ ( 1, 0 ), 2 ], [ ( 0, 1 ), 2 ] ]
#! 
#! ================================================================================= 
#!

#! @EndExample