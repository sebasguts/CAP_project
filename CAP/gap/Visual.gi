#############################################################################
##
##                                               CAP package
##
##  Copyright 2016, Sebastian Gutsche, Universität Siegen
##                  Sebastian Posur,   Universität Siegen
##
#############################################################################

InstallValue( CAP_INTERNAL_OBJECT_NAMES,
              rec( object_names := [ ],
                   morphism_names := [ ],
                   object_name_counter := 1,
                   morphism_name_counter := 1 ) );

InstallGlobalFunction( CAP_INTERNAL_GET_OBJECT_NAME,
  function( object )
    local current_object, user_g_vars, new_name, name_string, counter_string, add_string;
    
    if IsInt( object ) then
        return object;
    elif IsCapCategory( object ) then
        return object;
    elif IsList( object ) then
        return List( object, CAP_INTERNAL_GET_OBJECT_NAME );
    elif IsCapCategoryObject( object ) then
        name_string := "object_names";
        counter_string := "object_name_counter";
        add_string := "object_";
    elif IsCapCategoryMorphism( object ) then
        name_string := "morphism_names";
        counter_string := "morphism_name_counter";
        add_string := "morphism_";
    fi;
    
    for current_object in CAP_INTERNAL_OBJECT_NAMES.(name_string) do
        if IsIdenticalObj( current_object[ 1 ], object ) then
            return current_object[ 2 ];
        fi;
    od;
    
    user_g_vars := NamesUserGVars();
    
    for current_object in user_g_vars do
        if IsIdenticalObj( ValueGlobal( current_object ), object ) then
            Add( CAP_INTERNAL_OBJECT_NAMES.(name_string), [ object, current_object ] );
            return current_object;
        fi;
    od;
    
    new_name := Concatenation( add_string, String( CAP_INTERNAL_OBJECT_NAMES.(counter_string) ) );
    CAP_INTERNAL_OBJECT_NAMES.(counter_string) := CAP_INTERNAL_OBJECT_NAMES.(counter_string) + 1;
    Add( CAP_INTERNAL_OBJECT_NAMES.(name_string), [ object, new_name ] );
    return new_name;
    
end );

InstallGlobalFunction( CAP_INTERNAL_CLEANUP_VISUAL,
  
  function( )
    
    return CAP_INTERNAL_CLEANUP_VISUAL_RECURSIVE( CAP_VISUAL );
    
end );

InstallGlobalFunction( CAP_INTERNAL_CLEANUP_VISUAL_RECURSIVE,
  
  function( record )
    
    if record!.type = "master" then
        
        return rec( type := "master",
                    all_operations := List( record!.all_operations, CAP_INTERNAL_CLEANUP_VISUAL_RECURSIVE ) );
        
    elif record!.type = "object" then
        
        return rec( type := "object",
                    object := CAP_INTERNAL_GET_OBJECT_NAME( record!.object ) );
    
    elif record!.type = "morphism" then
        
        return rec( type := "morphism",
                    object := CAP_INTERNAL_GET_OBJECT_NAME( record!.object ),
                    source := CAP_INTERNAL_GET_OBJECT_NAME( Source( record!.object ) ),
                    range := CAP_INTERNAL_GET_OBJECT_NAME( Range( record!.object ) ) );
    
    elif record!.type = "operation" then
        
        if record!.name = "IsEqualForCache" then
            return rec( );
        fi;
        
        return rec( type := "operation",
                    arguments := List( record!.arguments, CAP_INTERNAL_GET_OBJECT_NAME ),
                    children := List( record!.children, CAP_INTERNAL_CLEANUP_VISUAL_RECURSIVE ),
                    result := CAP_INTERNAL_GET_OBJECT_NAME( record!.result ),
                    name := record!.name );
    
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_TRAVERSE_VISUAL_RECORD,
  
  function( visual_record )
    local traversed_list;
    
    if visual_record = rec( ) then
        
        return [ ];
        
    fi;
    
    if visual_record!.type = "master" then
        
        return Concatenation( List( visual_record!.all_operations, CAP_INTERNAL_TRAVERSE_VISUAL_RECORD ) );
        
    elif visual_record!.type = "object" or visual_record!.type = "morphism" then
        
        return [ visual_record ];
        
    elif visual_record!.type = "operation" then
        
        traversed_list := Concatenation( List( visual_record!.children, CAP_INTERNAL_TRAVERSE_VISUAL_RECORD ) );
        
        Add( traversed_list, visual_record );
        
        return traversed_list;
        
    fi;
    
end );

BindGlobal( "FlattenStringListList",
  function( list )
    local new_list, current, i;
    
    new_list := [ ];
    
    for current in list do
        
        if IsString( current ) then
            Add( new_list, current );
        elif IsList( current ) then
            Append( new_list, current );
        fi;
        
    od;
    
    return new_list;
    
end );

BindGlobal( "CAP_INTERNAL_STRIP_WITH_GIVEN_OP",
  function( string )
    
    if PositionSublist( string, "WithGiven" ) <> fail then
        return string{[ 1 .. PositionSublist( string, "WithGiven" ) - 1 ]};
    elif EndsWith( string, "Op" ) then
        return string{[ 1 .. Length( string ) - 2 ]};
    else
        return string;
    fi;
    
end );

InstallGlobalFunction( CAP_INTERNAL_RECORD_TO_JS,
  
  function( record, filename )
    local filestream, traversed_list, current_record, next_record, delete_list, i;
    
    filestream := OutputTextFile( filename, false );
    AppendTo( filestream, "//CAP visual data\n" );
    
    traversed_list := CAP_INTERNAL_TRAVERSE_VISUAL_RECORD( record );
    
    delete_list := [ ];
    
    for i in [ 1 .. Length( traversed_list ) - 1 ] do
        
        current_record := traversed_list[ i ];
        next_record := traversed_list[ i + 1 ];
        
        if current_record!.type = "operation" and next_record!.type = "operation" then
            current_record := CAP_INTERNAL_STRIP_WITH_GIVEN_OP( current_record.name );
            next_record := CAP_INTERNAL_STRIP_WITH_GIVEN_OP( next_record!.name );
            if current_record = next_record then
                Add( delete_list, i + 1 );
            fi;
        fi;
        
    od;
    
    for i in Reversed( delete_list ) do
        
        Remove( traversed_list, i );
        
    od;
    
    AppendTo( filestream, "var graph_data = [\n" );
    
    for current_record in traversed_list do
        
        if current_record!.type = "object" then
            AppendTo( filestream, "{ type: \"object\", name: \"", current_record!.object, "\"},\n" );
        
        elif current_record!.type = "morphism" then
            AppendTo( filestream, "{ type: \"morphism\", name: \"", current_record!.object, 
                                  "\", source: \"", current_record!.source, "\", range: \"", current_record!.range, "\"},\n" );
        
        elif current_record!.type = "operation" then
            
            AppendTo( filestream, "{ type: \"operation\", name: \"", current_record!.name, "\", result: \"", current_record!.result,
                                  "\", arguments: ", String( FlattenStringListList( current_record!.arguments ) ), "},\n" );
        
        fi;
        
    od;
    
    AppendTo( filestream, "];\n" );
    
    CloseStream( filestream );
    
end );

InstallGlobalFunction( CAP_INTERNAL_VISUALIZE_COMPUTATION,
  function( )
    local temp_dir, files_to_copy, style_files, visrec, stream;
    
    temp_dir := DirectoryTemporary();
    
    #copy files
    
    style_files := DirectoriesPackageLibrary( "CAP", "visual_helper_files" )[ 1 ];
    
    for files_to_copy in [ "vis.min.js", "vis.min.css", "CAPGraph.html" ] do
        stream := StringFile( Filename( style_files, files_to_copy ) );
        FileString( Filename( temp_dir, files_to_copy ), stream );
    od;
    
    visrec := CAP_INTERNAL_CLEANUP_VISUAL();

    CAP_INTERNAL_RECORD_TO_JS( visrec, Filename( temp_dir, "test.js" ) );
    
    Exec( Concatenation( "chromium ", Filename( temp_dir, "CAPGraph.html" ) ) );
    
end );
    
