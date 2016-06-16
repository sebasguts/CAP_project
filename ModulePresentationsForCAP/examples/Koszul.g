#! @Chapter Examples and Tests

#! @Section Koszul Complex

LoadPackage( "ModulePresentationsForCAP" );

LoadPackage( "RingsForHomalg" );

#! @Example
Q := HomalgFieldOfRationalsInSingular();;
R := Q * "x,y,z";;
M := HomalgMatrix( [ [ "x" ], [ "y" ], [ "z" ] ], 3, 1, R );;
Ml := AsLeftPresentation( M );;
eps := CoverByFreeModule( Ml );;
iota1 := KernelEmbedding( eps );;
Display( iota1 );
#! x,
#! y,
#! z 
#! 
#! A mono morphism in The category of left presentations of Q[x,y,z]
Display( Source( iota1 ) );
#! 0, -z,y,
#! -y,x, 0,
#! -z,0, x 
#! 
#! An object in The category of left presentations of Q[x,y,z]
pi1 := CoverByFreeModule( Source( iota1 ) );;
d1 := PreCompose( pi1, iota1 );;
Display( d1 );
#! x,
#! y,
#! z 
#! 
#! A morphism in The category of left presentations of Q[x,y,z]
iota2 := KernelEmbedding( d1 );;
Display( iota2 );
#! 0, -z,y,
#! -y,x, 0,
#! -z,0, x 
#! 
#! A mono morphism in The category of left presentations of Q[x,y,z]
Display( Source( iota2 ) );;
#! x,z,-y
#! 
#! An object in The category of left presentations of Q[x,y,z]
pi2 := CoverByFreeModule( Source( iota2 ) );;
d2 := PreCompose( pi2, iota2 );;
Display( d2 );
#! 0, -z,y,
#! -y,x, 0,
#! -z,0, x 
#! 
#! A morphism in The category of left presentations of Q[x,y,z]
iota3 := KernelEmbedding( d2 );;
Display( iota3 );
#! x,z,-y
#! 
#! A mono morphism in The category of left presentations of Q[x,y,z]
Display( Source( iota3 ) );
#! (an empty 0 x 1 matrix)
#! 
#! An object in The category of left presentations of Q[x,y,z]
pi3 := CoverByFreeModule( Source( iota3 ) );;
d3 := PreCompose( pi3, iota3 );;
Display( d3 );
#! x,z,-y
#! 
#! A morphism in The category of left presentations of Q[x,y,z]
N := HomalgMatrix( [ [ "x" ] ], 1, 1, R );;
Nl := AsLeftPresentation( N );;
d2Nl := TensorProductOnMorphisms( d2, IdentityMorphism( Nl ) );;
d1Nl := TensorProductOnMorphisms( d1, IdentityMorphism( Nl ) );;
IsZero( PreCompose( d2Nl, d1Nl ) );
#! true
cycles := KernelEmbedding( d1Nl );;
boundaries := ImageEmbedding( d2Nl );;
boundaries_in_cyles := LiftAlongMonomorphism( cycles, boundaries );;
homology := CokernelObject( boundaries_in_cyles );;
LessGenFunctor := FunctorLessGeneratorsLeft( R );;
homology := ApplyFunctor( LessGenFunctor, homology );;
StdBasisFunctor := FunctorStandardModuleLeft( R );;
homology := ApplyFunctor( StdBasisFunctor, homology );;
Display( homology );
#! z,
#! y,
#! x 
#! 
#! An object in The category of left presentations of Q[x,y,z]
#! @EndExample