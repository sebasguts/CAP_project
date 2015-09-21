    ##
    AddMonoAsKernelLift( category,
      function( monomorphism, test_morphism )
        local right_divide;
        
        right_divide := RightDivide( UnderlyingHomalgMatrix( test_morphism ), UnderlyingHomalgMatrix( monomorphism ) );
        
        if right_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Source( test_morphism ),
                                    right_divide,
                                    Source( monomorphism ) );
        
    end );
    
    ##
    AddCokernel( category,
      function( morphism )
        local homalg_field, homalg_matrix;
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        homalg_matrix := UnderlyingHomalgMatrix( morphism );
        
        return VectorSpaceObject( NrColumns( homalg_matrix ) - RowRankOfMatrix( homalg_matrix ), homalg_field );
        
    end );
    
    ##
    AddCokernelProj( category,
      function( morphism )
        local cokernel_proj, homalg_field, cokernel_obj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        homalg_field := UnderlyingFieldForHomalg( morphism );
        
        cokernel_obj := VectorSpaceObject( NrColumns( cokernel_proj ), homalg_field );
        
        return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel_obj );
        
    end );
    
    ##
    AddCokernelProjWithGivenCokernel( category,
      function( morphism, cokernel )
        local cokernel_proj;
        
        cokernel_proj := SyzygiesOfColumns( UnderlyingHomalgMatrix( morphism ) );
        
        return VectorSpaceMorphism( Range( morphism ), cokernel_proj, cokernel );
        
    end );
    
    ##
    AddEpiAsCokernelColift( category,
      function( epimorphism, test_morphism )
        local left_divide;
        
        left_divide := LeftDivide( UnderlyingHomalgMatrix( epimorphism ), UnderlyingHomalgMatrix( test_morphism ) );
        
        if left_divide = fail then
          
          return fail;
          
        fi;
        
        return VectorSpaceMorphism( Range( epimorphism ),
                                    left_divide,
                                    Range( test_morphism ) );
        
    end );

    
    ## Basic Operation Properties
    ##
    
    ##
    AddIsMonomorphism( category,
      function( morphism )
      
        return RowRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Source( morphism ) );
      
    end );
    
    ##
    AddIsEpimorphism( category,
      function( morphism )
        
        return ColumnRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    ##
    AddIsIsomorphism( category,
      function( morphism )
        
        return Dimension( Range( morphism ) ) = Dimension( Source( morphism ) )
               and ColumnRankOfMatrix( UnderlyingHomalgMatrix( morphism ) ) = Dimension( Range( morphism ) );
        
    end );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ## Basic Operations for Monoidal Categories
    ##
    AddTensorProductOnObjects( category,
      [ 
        [ function( object_1, object_2 )
            local homalg_field;
            
            homalg_field := UnderlyingFieldForHomalg( object_1 );
            
            return VectorSpaceObject( Dimension( object_1 ) * Dimension( object_2 ), homalg_field );
            
          end,
          
          [ ] ],
        
        [ function( object_1, object_2 )
            
            return object_1;
            
          end,
          
          [ IsZero, ] ],
         
        [ function( object_1, object_2 )
            
            return object_2;
            
          end,
          
          [ , IsZero ] ]
      ]
    
    );
    
    ##
    AddTensorProductOnMorphisms( category,
      
      function( new_source, morphism_1, morphism_2, new_range )
        
        return VectorSpaceMorphism( new_source,
                                    KroneckerMat( UnderlyingHomalgMatrix( morphism_1 ), UnderlyingHomalgMatrix( morphism_2 ) ),
                                    new_range );
        
    end );
    
    ##
    AddTensorUnit( category,
      
      function( )
        local homalg_field;
        
        homalg_field := category!.field_for_matrix_category;
        
        return VectorSpaceObject( 1, homalg_field );
        
    end );
    
    ##
    AddBraiding( category,
      function( object_1_tensored_object_2, object_1, object_2, object_2_tensored_object_1 )
        local homalg_field, permutation_matrix, dim, dim_1, dim_2;
        
        homalg_field := UnderlyingFieldForHomalg( object_1 );
        
        dim_1 := Dimension( object_1 );
        
        dim_2 := Dimension( object_2 );
        
        dim := Dimension( object_1_tensored_object_2 );
        
        permutation_matrix := PermutationMat( 
                                PermList( List( [ 1 .. dim ], i -> ( RemInt( i - 1, dim_2 ) * dim_1 + QuoInt( i - 1, dim_2 ) + 1 ) ) ),
                                dim 
                              );
        
        return VectorSpaceMorphism( object_1_tensored_object_2,
                                    HomalgMatrix( permutation_matrix, dim, dim, homalg_field ),
                                    object_2_tensored_object_1
                                  );
        
    end );
    
    ##
    AddDualOnObjects( category, space -> space );
    
    ##
    AddDualOnMorphisms( category,
      function( dual_source, morphism, dual_range )
        
        return VectorSpaceMorphism( dual_source,
                                    Involution( UnderlyingHomalgMatrix( morphism ) ),
                                    dual_range );
        
    end );
    
    ##
    AddEvaluationForDual( category,
      function( tensor_object, object, unit )
        local homalg_field, dimension, column, zero_column, i;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        dimension := Dimension( object );
        
        column := [ ];
        
        zero_column := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( column, 1 );
          
          Append( column, zero_column );
          
        od;
        
        if dimension > 0 then 
          
          Add( column, 1 );
          
        fi;
        
        return VectorSpaceMorphism( tensor_object,
                                    HomalgMatrix( column, Dimension( tensor_object ), 1, homalg_field ),
                                    unit );
        
    end );
    
    ##
    AddCoevaluationForDual( category,
      
      function( unit, object, tensor_object )
        local homalg_field, dimension, row, zero_row, i;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        dimension := Dimension( object );
        
        row := [ ];
        
        zero_row := List( [ 1 .. dimension ], i -> 0 );
        
        for i in [ 1 .. dimension - 1 ] do
          
          Add( row, 1 );
          
          Append( row, zero_row );
          
        od;
        
        if dimension > 0 then 
          
          Add( row, 1 );
          
        fi;
        
        return VectorSpaceMorphism( unit,
                                    HomalgMatrix( row, 1, Dimension( tensor_object ), homalg_field ),
                                    tensor_object );
        
    end );
    
    ##
    AddMorphismToBidual( category,
      function( object, bidual_of_object )
        local homalg_field;
        
        homalg_field := UnderlyingFieldForHomalg( object );
        
        return VectorSpaceMorphism( object,
                                    HomalgIdentityMatrix( Dimension( object ), homalg_field ),
                                    bidual_of_object
                                  );
        
    end );