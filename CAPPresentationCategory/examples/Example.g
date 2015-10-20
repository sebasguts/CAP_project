#! @Chapter Examples and tests of the presentation category over the category of projective graded modules

#! @Section Constructors of objects

LoadPackage( "ToricVarieties" );;
LoadPackage( "CAPCategoryOfProjectiveGradedModules" );;
LoadPackage( "CAPPresentationCategory" );;

#! We first construct objects of the presentation category over the category of projective graded left $S$-modules, where
#! $S$ is the Coxring of $\mathbb{P}^1 \times \mathbb{P}^1$.

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
Q1 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
Q3 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
Q4 := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
m1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q2, HomalgMatrix( [[1,0],[0,1]], S ) ,Q3 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q4, HomalgMatrix( [["x_1","x_2"], ["x_1","x_2"]], S ) ,Q3 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
left_category := CapCategory( Q1 ); 
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
presentation1l := CAPPresentationCategoryObject( m1, left_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation2l := CAPPresentationCategoryObject( m3, left_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>

#! @EndExample

#! Next we repeat these steps for right modules instead.

#! @Example

P1 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
P2 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
P3 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
P4 := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
n1 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P1, HomalgMatrix( [["x_1"],["x_2"]], S ) ,P2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
n2 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P2, HomalgMatrix( [[1,0],[0,1]], S ) ,P3 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
n3 := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      P4, HomalgMatrix( [["x_1","x_2"], ["x_1","x_2"]], S ) ,P3 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
right_category := CapCategory( P1 ); 
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
presentation1r := CAPPresentationCategoryObject( n1, right_category );
#! <An object of the presentation category over the CAP category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
presentation2r := CAPPresentationCategoryObject( n3, right_category );
#! <An object of the presentation category over the CAP category of projective
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>

#! @EndExample




#! @Section All information about an object

#! To see all the data that defines an object in the presentation category, the command $\text{FullInformation}$ 
#! can be used.

#! @Example

FullInformation( presentation1l );
#!
#! =================================================================================
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
#!
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!  
#! =================================================================================
#!

#! @EndExample





#! @Section Morphisms in the presentation category

#! @Example

presentation_morphisml := CAPPresentationCategoryMorphism( 
                          presentation1l, m2, presentation2l );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( presentation_morphisml );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded left modules over
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! --------------------------------------------------------------------------------- 
#! 
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!
#! Range: 
#! ------ 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#! 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
#! 
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!
#! ================================================================================= 
#!
presentation_morphismr := CAPPresentationCategoryMorphism( 
                          presentation1r, n2, presentation2r );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded right modules over Q[x_1,x_2,x_3,x_4]
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
FullInformation( presentation_morphismr );
#! 
#! ================================================================================= 
#!  
#! Source: 
#! ------- 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
#! 
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Mapping matrix: 
#! --------------- 
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! 1,0,
#! 0,1 
#! (over a graded ring)
#! 
#! --------------------------------------------------------------------------------- 
#!  
#! Range: 
#! ------ 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
#!  
#! A morphism in the category of projective graded right modules over Q[x\
#! _1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ]\
#!  ]) with matrix: 
#! x_1,x_2,
#! x_1,x_2 
#! (over a graded ring)
#! 
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights\
#!  [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
#!  
#! ================================================================================= 
#! 

#! @EndExample





#! @Section A few categorical constructions for the presentation category over the left modules

#! @Example
dSl := DirectSum( [ presentation1l, presentation2l ] );
#! <An object of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
p1l := ProjectionInFactorOfDirectSumWithGivenDirectSum( [ presentation1l, presentation2l ], 1, dSl );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p1l );
#! A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]). Presentation: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,
#! 0,1,
#! 0,0,
#! 0,0 
#! (over a graded ring)
p2l := ProjectionInFactorOfDirectSumWithGivenDirectSum( [ presentation1l, presentation2l ], 2, dSl );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( p2l );
#! A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]). Presentation: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 0,0,
#! 0,0,
#! 1,0,
#! 0,1 
#! (over a graded ring)
i1l := InjectionOfCofactorOfDirectSumWithGivenDirectSum( [ presentation1l, presentation2l ], 1, dSl );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i1l );
#! A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]). Presentation: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1,0,0,0,
#! 0,1,0,0 
#! (over a graded ring)
i2l := InjectionOfCofactorOfDirectSumWithGivenDirectSum( [ presentation1l, presentation2l ], 2, dSl );
#! <A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])>
Display( i2l );
#! A morphism of the presentation category over the CAP category of 
#! projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1,0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]). Presentation: 
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 0,0,1,0,
#! 0,0,0,1 
#! (over a graded ring)
IsEqualForMorphisms( i1, i1 );
#! true
source_l := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0], 3 ] ], S );
#! <A projective graded left module of rank 3>


#! @EndExample




#! @Section A few categorical constructions for the presentation category over the right modules

asdf