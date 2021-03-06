<# 
Written By: Ashley Poole
Date: 21/04/2014
Description: Designed to removed old builds from the web server
#>
param($delete='False')

Import-Module WebAdministration -ErrorAction Stop

# Pulling list of websites from IIS where it's not the default website and the physical path ends in content. The word content indicates a powerdeployed website.
$websites = Get-Website | where {$_.Name -ne "Default Web Site" -and $_.PhysicalPath -like "*content"}

foreach ($website in $websites)
{
	$parentFolderPath = (Get-Item $website.physicalpath).parent.parent.fullname
	$currentFolderName = (Get-Item $website.physicalpath).parent.Name
	
	Write-Host "***** EVALUATING WEBSITE :" $website.name "*****" -ForegroundColor Cyan
	Write-Host "Parent Folder Path:" $parentFolderPath -ForegroundColor Yellow
	Write-Host "Live Folder Name:" $currentFolderName -ForegroundColor Yellow
	
	# Sorting by LastWriteTIme rather than Name due to the same build could be deployed mutiple times caused by a rollback
	$websiteFolders = Get-ChildItem $parentFolderPath | where {$_.Name -ne $currentFolderName  -and $_.Name -notlike "*.config"} | sort -Property LastWriteTime
	
	$websiteFoldersCount = $websiteFolders.Length -1
	$count = 2
	
	foreach ($folder in $websiteFolders)
	{
		# Only run if we have 3 or more folders lefts
		if ($count -le $websiteFoldersCount)
		{
			# Final check to ensure the folder being deleted isn't the live folder
			if ($folder -ne $website.physicalpath)
			{	
				if ($delete -eq 'true')
				{
					Write-Host "Deleting :" $parentFolderPath\$folder
					# Removing folder recursively
					Remove-Item $parentFolderPath\$folder -Force -Recurse
				}
				else
				{
					Write-Host "Deleting (PREVIEW):" $parentFolderPath\$folder
				}
			}
		}
		
		$count++
	}
}