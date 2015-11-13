#! @Chapter Examples and Tests



#! @Section Constructors of objects and reduction of degree lists

LoadPackage( "ToricVarieties" );;
LoadPackage( "CAPCategoryOfProjectiveGradedModules" );;

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
ObjectL := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
DegreeList( ObjectL );
#! [ [ ( 1, 0 ), 2 ] ]
Object2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A projective graded left module of rank 8>
DegreeList( Object2L );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]
ObjectR := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
DegreeList( ObjectR );
#! [ [ ( 1, 0 ), 2 ] ]
Object2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2], 
           [[1,0],3],[[0,1],2],[[1,0],1] ], S );
#! <A projective graded right module of rank 8>
DegreeList( Object2R );
#! [ [ ( 1, 0 ), 5 ], [ ( 0, 1 ), 2 ], [ ( 1, 0 ), 1 ] ]

#! @EndExample



#! @Section Constructors of morphisms

#! @Example
Q1L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],1] ], S );
#! <A projective graded left module of rank 1>
Q2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],2] ], S );
#! <A projective graded left module of rank 2>
m1L := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1L, HomalgMatrix( [["x_1","x_2"]], S ) ,Q2L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( Source( m1L ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
Display( Range( m1L ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
Display( UnderlyingHomalgMatrix( m1L ) );
#! x_1,x_2
#! (over a graded ring)
Q1R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],1] ], S );
#! <A projective graded right module of rank 1>
Q2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],2] ], S );
#! <A projective graded right module of rank 2>
m1R := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
      Q1R, HomalgMatrix( [["x_1"],["x_2"]], S ) ,Q2R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( Source( m1R ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
Display( Range( m1R ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ 0, 2 ] ]
Display( UnderlyingHomalgMatrix( m1R ) );
#! x_1,
#! x_2
#! (over a graded ring)

#! @EndExample



#! @Section The GAP categories

#! @Example

categoryL := CapCategory( Q1L );
#! CAP category of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
categoryR := CapCategory( Q1R );
#! CAP category of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])

#! @EndExample



#! @Section A few categorical constructions for projective left modules

#! @Example

ZeroObject( categoryL );
#! <A projective graded left module of rank 0>
O1L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[1,0],2] ], S );
#! <A projective graded left module of rank 2>
Display( ZeroMorphism( ZeroObject( categoryL ), O1L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! (an empty 0 x 2 matrix)
O2L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[0,0],1] ], S );
#! <A projective graded left module of rank 1>
Display( IdentityMorphism( O2L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
directSumL := DirectSum( [ O1L, O2L ] );
#! <A projective graded left module of rank 3>
Display( directSumL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i1L ) );
#! 1,0,0,
#! 0,1,0 
#! (over a graded ring)
i2L := InjectionOfCofactorOfDirectSum( [ O1L, O2L ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i2L ) );
#! 0,0,1
#! (over a graded ring)
proj1L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj1L ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
proj2L := ProjectionInFactorOfDirectSum( [ O1L, O2L ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj2L ) );
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
kL := KernelEmbedding( proj1L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( kL ) );
#! 0,0,1
#! (over a graded ring)
ckL := CokernelProjection( kL );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( ckL ) );
#! 1,0,
#! 0,1,
#! 0,0 
#! (over a graded ring)
IsMonomorphism( kL );
#! true
IsEpimorphism( kL );
#! false
IsMonomorphism( ckL );
#! false
IsEpimorphism( ckL );
#! true
m1L := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( O1L, 
      HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O2L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2L := IdentityMorphism( O2L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
liftL := Lift( m1L, m2L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( liftL ) );
#! x_1,
#! x_2 
#! (over a graded ring)
O3L := CAPCategoryOfProjectiveGradedLeftModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded left module of rank 2>
morL := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       O2L, HomalgMatrix( [[ "x_1, x_2" ]], S ), O3L );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
coliftL := Colift( m2L, morL );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( coliftL ) );
#! x_1,x_2
#! (over a graded ring)
fpL := FiberProduct( [ m1L, m2L, IdentityMorphism( Range( m2L ) ) ] );
#! <A projective graded left module of rank 2>
fp_proj1L := ProjectionInFactorOfFiberProduct( [ m1L, m2L ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2L := ProjectionInFactorOfFiberProduct( [ m1L, m2L ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj2L ) );
#! x_1,
#! x_2 
#! (over a graded ring)
poL := Pushout( morL, m2L );
#! <A projective graded left module of rank 2>
inj1L := InjectionOfCofactorOfPushout( [ morL, m2L ], 1 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj1L ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2L := InjectionOfCofactorOfPushout( [ morL, m2L ], 2 );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj2L ) );
#! x_1,x_2
#! (over a graded ring)
tensorProductL := TensorProductOnObjects( O1L, O2L );
#! <A projective graded left module of rank 2>
Display( tensorProductL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismL := TensorProductOnMorphisms( m2L, morL );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( tensorProductMorphismL );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectL, Object2L ) ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1L ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,x_2
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectL ), ObjectL ), ObjectL, TensorUnit( categoryL ) ) );
#! A morphism in the category of projective graded left modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,
#! 0,
#! 0,
#! 1 
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectL, ObjectL ) );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample









#! @Section A few categorical constructions for projective right modules

#! @Example
ZeroObject( categoryR );
#! <A projective graded right module of rank 0>
O1R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[1,0],2] ], S );
#! <A projective graded right module of rank 2>
Display( ZeroMorphism( ZeroObject( categoryR ), O1R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! (an empty 2 x 0 matrix)
O2R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[0,0],1] ], S );
#! <A projective graded right module of rank 1>
Display( IdentityMorphism( O2R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! 1
#! (over a graded ring)
directSumR := DirectSum( [ O1R, O2R ] );
#! <A projective graded right module of rank 3>
Display( directSumR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 3 and degrees:
#! [ [ ( 1, 0 ), 2 ], [ 0, 1 ] ]
i1R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i1R ) );
#! 1,0,
#! 0,1,
#! 0,0
#! (over a graded ring)
i2R := InjectionOfCofactorOfDirectSum( [ O1R, O2R ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ],[ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( i2R ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
proj1R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj1R ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
proj2R := ProjectionInFactorOfDirectSum( [ O1R, O2R ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( proj2R ) );
#! 0,0,1
#! (over a graded ring)
kR := KernelEmbedding( proj1R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( kR ) );
#! 0,
#! 0,
#! 1
#! (over a graded ring)
ckR := CokernelProjection( kR );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( ckR ) );
#! 1,0,0,
#! 0,1,0
#! (over a graded ring)
IsMonomorphism( kR );
#! true
IsEpimorphism( kR );
#! false
IsMonomorphism( ckR );
#! false
IsEpimorphism( ckR );
#! true
m1R := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( O1R, 
      HomalgMatrix( [[ "x_1", "x_2" ]], S ), O2R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
m2R := IdentityMorphism( O2R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
liftR := Lift( m1R, m2R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( liftR ) );
#! x_1,x_2
#! (over a graded ring)
O3R := CAPCategoryOfProjectiveGradedRightModulesObject( [ [[-1,0],2] ], S );
#! <A projective graded right module of rank 2>
morR := CAPCategoryOfProjectiveGradedLeftOrRightModulesMorphism( 
       O2R, HomalgMatrix( [[ "x_1" ], [ "x_2" ]], S ), O3R );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
coliftR := Colift( m2R, morR );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( coliftR ) );
#! x_1,
#! x_2
#! (over a graded ring)
fpR := FiberProduct( [ m1R, m2R, IdentityMorphism( Range( m2R ) ) ] );
#! <A projective graded right module of rank 2>
fp_proj1R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( fp_proj2R ) );
#! x_1, x_2
#! (over a graded ring)
poR := Pushout( morR, m2R );
#! <A projective graded right module of rank 2>
inj1R := InjectionOfCofactorOfPushout( [ morR, m2R ], 1 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2R := InjectionOfCofactorOfPushout( [ morR, m2R ], 2 );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( inj2R ) );
#! x_1,
#! x_2
#! (over a graded ring)
tensorProductR := TensorProductOnObjects( O1R, O2R );
#! <A projective graded right module of rank 2>
Display( tensorProductR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismR := TensorProductOnMorphisms( m2R, morR );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( tensorProductMorphismR );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectR, Object2R ) ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1R ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! A morphism in the category of projective graded right modules over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,0,1
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectR, ObjectR ) );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample



#! @Section Truncations of projective graded modules


#! @Example
S;
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])
D := DegreeGroup( S );
#! <A free left module of rank 2 on free generators>
IsFree( D );
#! true
NewObjectL := CAPCategoryOfProjectiveGradedLeftModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded left module of rank 3>
tL := TruncationOfProjectiveGradedModule( NewObjectL, [[1,0],[0,1]] );
#! <A projective graded left module of rank 1>
Display( tL );
#! A projective graded left module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
embL := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectL, 
        [[1,0],[0,1]] );
#! A morphism in the category of projective graded left 
#! modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( embL ) );
#! 1, 0, 0
#! (over a graded ring)
projL := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectL, 
         [[ 1,0 ], [ 0,1 ]] );
#! A morphism in the category of projective 
#! graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( projL ) );
#! 1,
#! 0,
#! 0 
#! (over a graded ring)
TruncationFunctorForProjectiveGradedLeftModules( S, [[ 1,0 ], [ 0,1 ]] );
#! Truncation functor for CAP category of projective graded 
#! left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ]
NaturalTransformationFromTruncationToIdentityForProjectiveGradedLeftModules( 
S, [[1,0],[0,1]] );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded left modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ] to id
NewObjectR := CAPCategoryOfProjectiveGradedRightModulesObject( 
              [ [[1,0],1], [[-1,-1],2] ], S );
#! <A projective graded right module of rank 3>
tR := TruncationOfProjectiveGradedModule( NewObjectR, [[1,0],[0,1]] );
#! <A projective graded right module of rank 1>
Display( tR );
#! A projective graded right module over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 1 and degrees: 
#! [ [ ( 1, 0 ), 1 ] ]
embR := EmbeddingOfTruncationOfProjectiveGradedModule( NewObjectR, 
        [[1,0],[0,1]] );
#! A morphism in the category of projective graded right 
#! modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
Display( UnderlyingHomalgMatrix( embR ) );
#! 1,
#! 0,
#! 0
#! (over a graded ring)
projR := ProjectionOntoTruncationOfProjectiveGradedModule( NewObjectR,
         [[ 1,0 ], [ 0,1 ]] );
#! A morphism in the category of projective 
#! graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])
Display( UnderlyingHomalgMatrix( projR ) );
#! 1, 0, 0
#! (over a graded ring)
TruncationFunctorForProjectiveGradedRightModules( S, [[ 1,0 ], [ 0,1 ]] );
#! Truncation functor for CAP category of projective graded 
#! right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ]
NaturalTransformationFromTruncationToIdentityForProjectiveGradedRightModules(
S, [[1,0],[0,1]] );
#! Natural transformation from Truncation functor for CAP category 
#! of projective graded right modules over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! to the cone [ [ 1, 0 ], [ 0, 1 ] ] to id

#! @EndExample