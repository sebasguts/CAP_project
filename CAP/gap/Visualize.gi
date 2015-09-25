#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

InstallValue( CAP_INTERNAL_VISUAL_DATA, rec( level_list := [ ], intendation := 0 ) );

BindGlobal( "CAP_INTERNAL_INDENT",
  
  function( )
    
    return ListWithIdenticalEntries( CAP_INTERNAL_VISUAL_DATA.intendation * 2, ' ' );
    
end );

InstallGlobalFunction( CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST,
  
  function( arg_list, category )
    local current_arg, return_string;
    
    return_string := "";
    
    for current_arg in arg_list do
        
        if IsList( current_arg ) then
            
            Append( return_string, Concatenation( "[ ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( current_arg, category ), " ], " ) );
            
        elif IsCapCategory( current_arg ) then
            
            Append( return_string, Concatenation( Name( current_arg ), ", " ) );
            
        elif IsCapCategoryObject( current_arg ) then
            
            Append( return_string, Concatenation( "object_", String( current_arg!.cap_object_counter ), ", " ) );
            
        elif IsCapCategoryMorphism( current_arg ) then
            
            Append( return_string, Concatenation( "morphism_", String( current_arg!.cap_morphism_counter ), ", " ) );
            
        elif IsInt( current_arg ) then
            
            Append( return_string, Concatenation( String( current_arg ), ", " ) );
            
        elif IsBool( current_arg ) then
            
            Append( return_string, Concatenation( String( current_arg ), ", " ) );
            
        else
            
            Append( return_string, Concatenation( "unknown, " ) );
            
        fi;
        
    od;
    
    return_string := return_string{[ 1 .. Length( return_string ) - 2 ]};
    
    return return_string;
    
end );

InstallGlobalFunction( CAP_VISUAL_SEARCH_FOR_CATEGORY_RECURSIVE,
  
  function( arg_list )
    local i, ret_val;
    
    for i in [ 1 .. Length( arg_list ) ] do
        
        if IsCapCategory( arg_list[ i ] ) then
        
            return arg_list[ i ];
        
        elif IsCapCategoryCell( arg_list[ i ] ) and HasCapCategory( arg_list[ i ] ) then
            
            return CapCategory( arg_list[ i ] );
            
        elif IsList( arg_list[ i ] ) then
            
            ret_val := CAP_VISUAL_SEARCH_FOR_CATEGORY_RECURSIVE( arg_list[ i ] );
            
            if ret_val <> fail then
                
                return ret_val;
                
            fi;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallGlobalFunction( TRACE_FUNCTION_IN_CAP_VISUALISATION,
  
  function( current_method, record_entry, info_class )
        local new_current_method;
        
        MakeReadWriteGlobal( current_method );
        
        new_current_method := Concatenation( "CAP_INTERNAL_", current_method );
        
        BindGlobal( new_current_method, ValueGlobal( current_method ) );
        
        BindGlobal( current_method, 
                      
          function( arg )
            local i, pop_category, func_call, return_value, func_as_string, func_stream, func, category;
            
            category := CAP_VISUAL_SEARCH_FOR_CATEGORY_RECURSIVE( arg );
            
            if category = fail or not IsBound( category!.is_visualized ) then
                
                return CallFuncList( ValueGlobal( new_current_method ), arg );
                
            fi;
            
            pop_category := false;
            
            if Length( CAP_INTERNAL_VISUAL_DATA.level_list ) = 0
              or not IsIdenticalObj( category, CAP_INTERNAL_VISUAL_DATA.level_list[ Length( CAP_INTERNAL_VISUAL_DATA.level_list ) ] ) then
                
                Add( CAP_INTERNAL_VISUAL_DATA.level_list, category );
                
                pop_category := true;
                
            fi;
            
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                  " calls ", record_entry, "( ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( arg, category ), " )" );
            
            CAP_INTERNAL_VISUAL_DATA!.intendation := CAP_INTERNAL_VISUAL_DATA!.intendation + 1;
            
            return_value := CallFuncList( ValueGlobal( new_current_method ), arg );
            
            if not IsBound( return_value ) then Error( "Something happend" ); fi;
            
            CAP_INTERNAL_VISUAL_DATA!.intendation := CAP_INTERNAL_VISUAL_DATA!.intendation - 1;
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                  " call of ", record_entry, "( ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( arg, category ), " )", " -> ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( [ return_value ], category ) );
            
            if pop_category then
                
                Remove( CAP_INTERNAL_VISUAL_DATA.level_list );
                
            fi;
            
            return return_value;
            
        end );
        
end );

InstallGlobalFunction( CAP_INTERNAL_INITIALIZE_VISUAL,
  
  function( info_class )
    local record_entry, current_method;
    
    
    if IsBound( CAP_INTERNAL_VISUAL_DATA!.is_initialized ) then
        
        return;
        
    fi;
    
    CAP_INTERNAL_VISUAL_DATA!.is_initialized := true;
    
        InstallMethod( Add,
                   [ IsCapCategory, IsCapCategoryObject ],
                   SUM_FLAGS,
                   
      function( category, object )
        
        if HasCapCategory( object ) then TryNextMethod(); fi;
        
        if not IsBound( category!.object_count ) then
            category!.object_count := 0;
        fi;
        
        object!.cap_object_counter := ShallowCopy( category!.object_count );
        
        category!.object_count := category!.object_count + 1;
        
        if Length( CAP_INTERNAL_VISUAL_DATA.level_list ) > 0 then
            
            Info( info_class, 1, CAP_INTERNAL_INDENT() , "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                      " added object_", String( object!.cap_object_counter ) );
                      
        else
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ),
                      " user added object_", String( object!.cap_object_counter ) );
            
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( Add,
                   [ IsCapCategory, IsCapCategoryMorphism ],
                   SUM_FLAGS,
                   
      function( category, morphism )
        
        if HasCapCategory( morphism ) then TryNextMethod(); fi;
        
        if not IsBound( category!.morphism_count ) then
            category!.morphism_count := 0;
        fi;
        
        morphism!.cap_morphism_counter := ShallowCopy( category!.morphism_count );
        
        category!.morphism_count := category!.morphism_count + 1;
        
        if Length( CAP_INTERNAL_VISUAL_DATA.level_list ) > 0 then
            
            Info( info_class, 1, CAP_INTERNAL_INDENT() , "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                      " added morphism_", String( morphism!.cap_morphism_counter ) );
                      
        else
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ),
                      " user added morphism_", String( morphism!.cap_morphism_counter ) );
            
        fi;
        
        TryNextMethod();
        
    end );
    
     for record_entry in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) do
        
        if record_entry in [ "HorizontalPreCompose",
                                "HorizontalPostCompose",
                                "VerticalPreCompose",
                                "VerticalPostCompose",
                                "IdentityTwoCell",
                                "IsomorphismFromImageObjectToKernelOfCokernel",
                                "IsEqualForObjects",
                                "IsEqualForMorphisms",
                                "IsEqualForMorphismsOnMor",
                                "IsEqualForCacheForObjects",
                                "IsEqualForCacheForMorphisms" ] then
            continue;
        fi;
        
        if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.( record_entry ).installation_name ) then
            
            current_method := CAP_INTERNAL_METHOD_NAME_RECORD.( record_entry ).installation_name;
            
        else
            
            current_method := record_entry;
            
        fi;
        
        TRACE_FUNCTION_IN_CAP_VISUALISATION( current_method, record_entry, info_class );
        
    od;
    
end );


InstallGlobalFunction( PRINT_CATEGORY_VISUALIZATION_INFO,
  
  function( category, recursive_strategy, info_class )
    local current_method, current_filters, record_entry, attributes_list, i, install_function;
    
    ## Install stuff
    
    if recursive_strategy <> true then
        recursive_strategy := false;
    fi;
    
    if IsBound( category!.is_visualized ) then
        return;
    else
        category!.is_visualized := true;
    fi;
    
    category!.object_count := 0;
    
    CAP_INTERNAL_INITIALIZE_VISUAL( info_class );
    
    if recursive_strategy = true then
        
        attributes_list := KnownAttributesOfObject( category );
        
        for i in attributes_list do
            
            if IsCapCategory( ValueGlobal( i )( category ) ) then
                
                PRINT_CATEGORY_VISUALIZATION_INFO( ValueGlobal( i )( category ), true, info_class );
                
            fi;
            
        od;
        
    fi;
    
end );

InstallGlobalFunction( PrintCategoryVisualization,
  
  function( category, filename, recursive_strategy )
    local info_class;
    
    info_class := NewInfoClass( Name( category ) );
    
    SetInfoLevel( info_class, 1 );
    
    SetInfoOutput( info_class, filename );
    
    PRINT_CATEGORY_VISUALIZATION_INFO( category, recursive_strategy, info_class );
    
end );
    