#############################################################################
##
##                  CAPPresentationCategory
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Convenience methods
##
#############################################################################



####################################################################################
##
##  Section Powers of objects and morphisms
##
####################################################################################

# for convenience allow "*" to indicate the tensor product on objects
InstallMethod( \*,
               "powers of presentations",
               [ IsCAPPresentationCategoryObject, IsCAPPresentationCategoryObject ],
  function( presentation_object1, presentation_object2 )

    return TensorProductOnObjects( presentation_object1, presentation_object2 );
  
end );

# for convenience allow "*" to indicate the tensor product on morphisms
InstallMethod( \*,
               "powers of presentations",
               [ IsCAPPresentationCategoryMorphism, IsCAPPresentationCategoryMorphism ],
  function( presentation_morphism1, presentation_morphism2 )

    return TensorProductOnMorphisms( presentation_morphism1, presentation_morphism2 );
  
end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of an object with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsCAPPresentationCategoryObject, IsInt ],
  function( presentation_object, power )
    local res, i;
    
      if power < 0 then
      
        return Error( "The power must be non-negative! \n" );
            
      elif power = 0 then
      
        return ZeroObject( CapCategory( presentation_object ) );
      
      elif power = 1 then
      
        return presentation_object;
        
      else
      
        res := presentation_object;
        
        for i in [ 1 .. power ] do
          res := res * presentation_object;
        od;
      
        return res;
      
      fi;

end );

# allow "^p" to indicate the p-th power, i.e. p-times tensor product of a morphism with itself
InstallMethod( \^,
               "powers of presentations",
               [ IsCAPPresentationCategoryMorphism, IsInt ],
  function( presentation_morphism, power )
    local res, i;

      if power < 0 then

        return Error( "The power must be non-negative! \n" );

      elif power = 0 then

        return ZeroObject( CapCategory( presentation_morphism ) );
      
      elif power = 1 then
      
        return presentation_morphism;
        
      else
      
        res := presentation_morphism;
        
        for i in [ 1 .. power ] do
          res := res * presentation_morphism;
        od;
      
        return res;
      
      fi;

end );



####################################################################################
##
##  Section Embeddings in projective modules
##
####################################################################################

# represent ideal of graded ring as graded left-presentation
InstallMethod( EmbeddingInProjectiveObject,
               "for a CAPPresentationCategoryObject",
               [ IsCAPPresentationCategoryObject ],
  function( presentation_object )
    local cokernel_projection, range_object;

    # compute the cokernel projection of the presentation_object
    cokernel_projection := CokernelProjection( UnderlyingMorphism( presentation_object ) );

    # we are thus looking at the following diagram:
    #
    # presentation_object_source ----- zero_morphism -------------- 0
    #            |                                                  |
    # underlying_morphism                                    zero_morphism
    #            |                                                  |
    #            v                                                  v
    # presentation_object_range ---- cokernel_projection ----> cokernel_object
    #
    # the right column is the projective_module that we embed the left column into

    range_object := CAPPresentationCategoryObject( 
                         ZeroMorphism( ZeroObject( CapCategory( cokernel_projection ) ), Range( cokernel_projection ) ) );

    return CAPPresentationCategoryMorphism( presentation_object, cokernel_projection, range_object );

end );