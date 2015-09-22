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
    
    install_function := function( current_method, current_filters, category, record_entry )
        
        InstallMethod( ValueGlobal( current_method ),
                      current_filters,
                      2*SUM_FLAGS+12,
                      
          function( arg )
            local i, pop_category, func_call, return_value, func_as_string, func_stream, func;
            
            pop_category := false;
            
            if Length( CAP_INTERNAL_VISUAL_DATA.level_list ) = 0
              or not IsIdenticalObj( category, CAP_INTERNAL_VISUAL_DATA.level_list[ Length( CAP_INTERNAL_VISUAL_DATA.level_list ) ] ) then
                
                Add( CAP_INTERNAL_VISUAL_DATA.level_list, category );
                
                pop_category := true;
                
            fi;
            
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                  " calls ", record_entry, "( ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( arg, category ), " )" );
            
            CAP_INTERNAL_VISUAL_DATA!.intendation := CAP_INTERNAL_VISUAL_DATA!.intendation + 1;
            
            func_call := ApplicableMethod( ValueGlobal( current_method ), arg, 0, "all" );
            
            for func in func_call do
                
                func_as_string := "";
                
                func_stream := OutputTextString( func_as_string, false );
                
                PrintTo( func_stream, func );
                
                CloseStream( func_stream );
                
                if PositionSublist( func_as_string, "TRY_NEXT_METHOD" ) = fail then
                    
                    return_value := CallFuncList( func, arg );
                    
                    break;
                    
                fi;
                
            od;
            
            if not IsBound( return_value ) then Error( "Something happend" ); fi;
            
            CAP_INTERNAL_VISUAL_DATA!.intendation := CAP_INTERNAL_VISUAL_DATA!.intendation - 1;
            
            Info( info_class, 1, CAP_INTERNAL_INDENT(), "In ", Name( category ), " at level ", Length( CAP_INTERNAL_VISUAL_DATA.level_list ),
                  " call of ", record_entry, "( ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( arg, category ), " )", " -> ", CAP_INTERNAL_TRANSLATE_ARGUMENT_LIST( [ return_value ], category ) );
            
            if pop_category then
                
                Remove( CAP_INTERNAL_VISUAL_DATA.level_list );
                
            fi;
            
            return return_value;
            
        end );
        
    end;
    
    for record_entry in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) do
        
        if record_entry in [ "HorizontalPreCompose",
                                "HorizontalPostCompose",
                                "VerticalPreCompose",
                                "VerticalPostCompose",
                                "IdentityTwoCell",
                                "IsomorphismFromImageObjectToKernelOfCokernel",
                                "IsEqualForObjects",
                                "IsEqualForMorphisms",
                                "IsEqualForMorphismsOnMor" ] then
            continue;
        fi;
        
        if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.( record_entry ).installation_name ) then
            
            current_method := CAP_INTERNAL_METHOD_NAME_RECORD.( record_entry ).installation_name;
            
        else
            
            current_method := record_entry;
            
        fi;
        
        current_filters := CAP_INTERNAL_METHOD_NAME_RECORD.( record_entry ).filter_list;
        
        current_filters := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( current_filters, category );
        
        install_function( current_method, current_filters, category, record_entry );
        
    od;
    
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
    