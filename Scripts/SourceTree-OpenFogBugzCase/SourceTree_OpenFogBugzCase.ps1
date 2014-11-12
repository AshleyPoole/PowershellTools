##################################################################
# Created By Ashley Poole - http://www.ashleypoole.co.uk         #
# Opens FogBugz case (BugzID) if specified in the commit message #
# SourceTree_OpenFogBugzCase.ps1                                 #
##################################################################
 
Param(
    [string]
    $Repo,
 
    [string]
    $SHA
)
 
$CommitMessage = git -C $Repo log --format=%B -n 1 $SHA
$BugzID = $CommitMessage | Select-String -pattern "BugzID\s*:\s*\d*" | select-object -expand Matches
$BugzID = $BugzID -replace "[^0-9]"
 
If ($BugzID.length -ne 0)
{
    start ('http://fogbugz/?' + $BugzID)
} else {
    $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
    $wshell.Popup("No BugzID could be found for this commit :(",7,"I'm Sorry!",0)
}