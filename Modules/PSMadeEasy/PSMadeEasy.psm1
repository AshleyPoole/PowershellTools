Function compare-directory
{
    Param($SourcePath, $DestinationPath)

    Try
    {
        $SourcePathContents = Get-ChildItem $SourcePath
        $DestinationPathContents = Get-ChildItem $DestinationPath
        Compare-Object -ReferenceObject $SourcePathContents -DifferenceObject $DestinationPathContents
    }
    Catch
    {
        Write-Host Unable to compare directories. Check paths are valid.
    }
}