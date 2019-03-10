#################################################################
#################################################################
#! @Chapter Examples on graded rows and columns
#################################################################
#################################################################

LoadPackage( "FreydCategoriesForCAP" );;



#################################################################
#! @Section Constructors of objects and reduction of degree lists
#################################################################

#! @Example
S := HomalgRingOfIntegers();
#! Z
cols := CategoryOfColumns( S );
#! Columns( Z )
obj1 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
obj2 := CategoryOfColumnsObject( 8, cols );
#! <A column module over Z of rank 8>
#! @EndExample


#####################################
#! @Section Constructors of morphisms
#####################################

#! @Example
obj3 := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
IsWellDefined( obj1 );
#! true
obj4 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
mor := CategoryOfColumnsMorphism( obj3, HomalgMatrix( [[1],[2]], S ), obj4 );
#! <A morphism in Columns( Z )>
IsWellDefined( mor );
#! true
Display( Source( mor ) );
#! A column module over Z of rank 1
Display( Range( mor ) );
#! A column module over Z of rank 2
Display( UnderlyingMatrix( mor ) );
#! [ [  1 ],
#!   [  2 ] ]
#! @EndExample





########################################################################
#! @Section A few categorical constructions for projective right modules
########################################################################

#! @Example
ZeroObject( cols );
#! A column module over Z of rank 0
obj5 := CategoryOfColumnsObject( 2, cols );
#! <A column module over Z of rank 2>
Display( ZeroMorphism( ZeroObject( cols ), obj5 ) );
#! (an empty 2 x 0 matrix)
#! 
#! A zero, split monomorphism in Columns( Z )
obj6 := CategoryOfColumnsObject( 1, cols );
#! <A column module over Z of rank 1>
Display( IdentityMorphism( obj6 ) );
#! [ [  1 ] ]
#! 
#! An identity morphism in Columns( Z )
directSum := DirectSum( [ obj5, obj6 ] );
#! <A graded column of rank 3>
Display( directSum );
#! A column module over Z of rank 3
i1 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
Display( i1 );
#! [ [  1,  0 ],
#!   [  0,  1 ],
#!   [  0,  0 ] ]
#! 
#! A morphism in Columns( Z )
i2 := InjectionOfCofactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
Display( i2 );
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! A morphism in Columns( Z )
proj1 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 1 );
#! <A morphism in Columns( Z )>
Display( proj1 );
#! [ [  1,  0,  0 ],
#!   [  0,  1,  0 ] ]
#! 
#! A morphism in Columns( Z )
proj2 := ProjectionInFactorOfDirectSum( [ obj5, obj6 ], 2 );
#! <A morphism in Columns( Z )>
Display( proj2 );
#! [ [  0,  0,  1 ] ]
#! 
#! A morphism in Columns( Z )
k := WeakKernelEmbedding( proj1 );
#! <A morphism in Columns( Z )>
Display( k );
#! [ [  0 ],
#!   [  0 ],
#!   [  1 ] ]
#! 
#! A morphism in Columns( Z )
ck := WeakCokernelProjection( k );
#! <A morphism in Columns( Z )>
Display( ck );
#! [ [   0,   1,   0 ],
#!   [  -1,   0,   0 ] ]
#! 
#! A morphism in Columns( Z )
IsMonomorphism( k );
#! true
IsEpimorphism( k );
#! false
IsMonomorphism( ck );
#! false
IsEpimorphism( ck );
#! true
mor1 := CategoryOfColumnsMorphism( obj5, HomalgMatrix( [[ 1, 2 ]], S ), obj6 );
#! <A morphism in Columns( Z )>
Display( mor1 );
#! [ [  1,  2 ] ]
#! 
#! A morphism in Columns( Z )
mor2 := IdentityMorphism( obj6 );
#! <A morphism in Columns( Z )>
Display( mor2 );
#! [ [  1 ] ]
#! 
#! A morphism in Columns( Z )
lift := Lift( mor1, mor2 );
#! A morphism in Columns( Z )
Display( lift );
#! [ [  1,  2 ] ]
#! 
#! A morphism in Columns( Z )
source := CategoryOfColumnsObject( 1, cols );
#! A column module of over Z of rank 1
range := CategoryOfColumnsObject( 2, cols );
#! A column module of over Z of rank 2
mor := CategoryOfColumnsMorphism( source, HomalgMatrix( [[ 2 ], [ 3 ]], S ), range );
#! A morphism in Columns( Z )
colift := Colift( mor2, mor );
#! A morphism in Columns( Z )
Display( colift );
#! [ [  2 ],
#!   [  3 ] ]
#!
#! A morphism in Columns( Z )
fp := FiberProduct( [ mor1, mor2, IdentityMorphism( Range( mor2 ) ) ] );

Error( "Test" );

fpR := FiberProduct( [ m1R, m2R, IdentityMorphism( Range( m2R ) ) ] );
#! <A graded column of rank 2>
fp_proj1R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
fp_proj2R := ProjectionInFactorOfFiberProduct( [ m1R, m2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( fp_proj2R ) );
#! x_1, x_2
#! (over a graded ring)
poR := Pushout( morR, m2R );
#! <A graded column of rank 2>
inj1R := InjectionOfCofactorOfPushout( [ morR, m2R ], 1 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj1R ) );
#! 1,0,
#! 0,1 
#! (over a graded ring)
inj2R := InjectionOfCofactorOfPushout( [ morR, m2R ], 2 );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( UnderlyingHomalgMatrix( inj2R ) );
#! x_1,
#! x_2
#! (over a graded ring)
tensorProductR := TensorProductOnObjects( O1R, O2R );
#! <A graded column of rank 2>
Display( tensorProductR );
#! A graded column over Q[x_1,x_2,x_3,x_4] (with weights 
#! [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 2 and degrees: 
#! [ [ ( 1, 0 ), 2 ] ]
tensorProductMorphismR := TensorProductOnMorphisms( m2R, morR );
#! <A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ])>
Display( tensorProductMorphismR );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2
#! (over a graded ring)
Display( DualOnObjects( TensorProductOnObjects( ObjectR, Object2R ) ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) of rank 16 and degrees: 
#! [ [ ( -2, 0 ), 5 ], [ ( -1, -1 ), 2 ], [ ( -2, 0 ), 6 ], [ ( -1, -1 ), 2 ], 
#! [ ( -2, 0 ), 1 ] ]
Display( DualOnMorphisms( m1R ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! with matrix: 
#! x_1,
#! x_2 
#! (over a graded ring)
Display( EvaluationForDualWithGivenTensorProduct( TensorProductOnObjects( 
         DualOnObjects( ObjectR ), ObjectR ), ObjectR, TensorUnit( categoryR ) ) );
#! A morphism in the category of graded columns over 
#! Q[x_1,x_2,x_3,x_4] (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [0, 1 ] ]) 
#! with matrix: 
#! 1,0,0,1
#! (over a graded ring)
Display( InternalHomOnObjects( ObjectR, ObjectR ) );
#! A graded column over Q[x_1,x_2,x_3,x_4] 
#! (with weights [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ]) 
#! of rank 4 and degrees: 
#! [ [ 0, 4 ] ]

#! @EndExample
