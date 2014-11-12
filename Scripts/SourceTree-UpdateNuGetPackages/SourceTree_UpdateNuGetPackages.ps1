########################################################################
# Created By Ashley Poole - http://www.ashleypoole.co.uk               #
# Updates NuGet package(s) for solutions within a specified repository #
# SourceTree_UpdateNuGetPackage.ps1                                    #
########################################################################

Param(
    [string]
    $Repo,

    [string]
    $Package
)

# Get NuGet location and Solution files location
$NuGetExe = Get-ChildItem $Repo -Recurse -Filter 'NuGet.exe' | Select-Object -First 1
$NuGetExe = $NuGetExe.FullName
$SolutionFiles = Get-ChildItem $Repo -Recurse -Filter '*.sln'

# Only run package update if NuGet exists, else alert user
If ($NuGetExe)
{
    Foreach ($SolutionFile In $SolutionFiles)
    {
        # Getting solution file's full path
        $SolutionFile = $SolutionFile.FullName

        $ArgsUpdate = 'update ' + $SolutionFile

        # Checking if we are updating one or all packages
        If ($Package.ToUpper() -ne 'ALL')
        {
            $ArgsUpdate = $ArgsUpdate + ' -id ' + $Package
        }

        # Setting-up parameter for NuGet arguments
        $ArgsSelfUpdate = 'update -self'
        $ArgsRestore = 'restore ' + $SolutionFile

        # Update NuGet
        Start-Process $NuGetExe $ArgsSelfUpdate -NoNewWindow -Wait

        # Restore Packages
        Start-Process $NuGetExe $ArgsRestore -NoNewWindow -Wait

        # Update Package
        Start-Process $NuGetEx $ArgsUpdate -NoNewWindow -Wait
    }
}
else
{
    $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
    $wshell.Popup("NuGet.exe couldn't found. No Packages have been updated! :(",7,"I'm Sorry!",0)
}