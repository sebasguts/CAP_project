#############################################################################
##
##                  GradedModulePresentationsForCAP
##
##  Copyright 2015,  Martin Bies,       ITP Heidelberg
##
##  Chapter Graded module presentations for CAP
##
#############################################################################

######################################
##
## Section CAP categories
##
######################################

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodLeft,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )

    # finally construct the presentation category
    return PresentationCategory( CAPCategoryOfProjectiveGradedLeftModules( graded_ring ) );

end );

# compute the category S-fpgrmod for a toric variety
InstallMethod( SfpgrmodRight,
                " for graded rings ",
                [ IsHomalgGradedRing ],
  function( graded_ring )

    # finally construct the presentation category
    return PresentationCategory( CAPCategoryOfProjectiveGradedRightModules( graded_ring ) );

end );