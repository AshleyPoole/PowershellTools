########################################################################
# Created By Ashley Poole - http://www.ashleypoole.co.uk               #
# Opens solution file(s) within a specified repository                 #
# SourceTree_OpenSolutions.ps1                                         #
########################################################################

Param(
    [string]
    $Repo
)

# Get and open solution files
Get-ChildItem $Repo -Recurse -Filter '*.sln' | Select { Start $_.FullName }