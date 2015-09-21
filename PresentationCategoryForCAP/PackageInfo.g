SetPackageInfo( rec(

PackageName := "PresentationCategoryForCAP",
Subtitle := "The presentation category constructed from a projective category",
Version := Maximum( [
           "2015.09.21", # Martin version
           ##
           ] ),

Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    WWWHome := "http://wwwb.math.rwth-aachen.de/~gutsche/",
    Email := "gutsche@mathematik.uni-kl.de",
    PostalAddress := Concatenation(
               "Department of Mathematics\n",
               "University of Kaiserslautern\n",
               "67653 Kaiserslautern\n",
               "Germany" ),
    Place := "Kaiserslautern",
    Institution := "TU Kaiserslautern",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "http://wwwb.math.rwth-aachen.de/Mitarbeiter/posur.php",
    Email := "sposur@momo.math.rwth-aachen.de",
    PostalAddress := Concatenation(
               "Lehrstuhl B für Mathematik RWTH - Aachen\n",
               "Templergraben 64\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "RWTH Aachen University",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Martin",
    LastName := "Bies",
    WWWHome := "",
    Email := "bies@thphys.uni-heidelberg.de",
    PostalAddress := "",
    Place := "Heidelberg",
    Institution := "ITP Heidelberg",
  ),  
],

PackageWWWHome := "",

ArchiveURL     := Concatenation( ~.PackageWWWHome, "PresentationCategoryForCAP-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "PresentationCategoryForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Presentation category for CAP constructed from a projective category",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ],
                           [ "MatricesForHomalg", ">=0" ],
                           [ "GradedRingForHomalg", ">=0 " ], ## CHECK AGAIN FOR CORRECT VERSION NUMBER
                           [ "ProjectiveCategoryForCAP", ">=0 " ], ## CHECK AGAIN FOR CORRECT VERSION NUMBER
                           [ "CAP", ">=0" ]
  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));