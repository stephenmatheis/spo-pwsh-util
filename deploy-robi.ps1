# # Variables
$site = 'https://intellible.sharepoint.com/sites/robi/'
$app = "measures-library"
$source = "/Users/steve/GitHub/${app}/dist"
$docLib = "App"
 
# # Connect to PnP Online
Connect-PnPOnline -Url $site -Interactive
 
$items = Get-ChildItem -Path $source -Directory -Force -Recurse

# $parentDir = ''
# $currentDir = '';

function Get-Tabs {
    param (
        $Count
    )

    $tabs = ''

    for ($i = 0; $i -lt $count; $i++) {
        $tabs += "`t"
    }

    Return $tabs
}

ForEach ($item in $items) {
    $currentDir = $item.FullName.Split($source)[1]
    $parentDir = $currentDir.split('/')
    $dirToCreate = $parentDir[-1];
    $parentDir = $parentDir[0..($parentDir.count - 2)] -Join '/'
    
    # How many deep? (subtract one for root /)
    # $previousDepth = $parentDir.split('/').Count - 1
    # $currentDepth = $currentDir.split('/').Count - 1

    # Write-Host "$(Get-Tabs -Count $previousDepth)Previous Directory: ${parentDir} (${previousDepth})"
    # Write-Host "$(Get-Tabs -Count $currentDepth)Create Directory: ${dirToCreate} (${currentDepth})"

    Add-PnPFolder -Name $dirToCreate -Folder "${docLib}${parentDir}"

    $files = Get-ChildItem -Path "${source}${currentDir}" -File

    ForEach ($file in $files) {
        # Write-Host "$(Get-Tabs -Count ($currentDepth + 1))Create File: ${$file.name}";

        Add-PnPFile -Path "${source}${currentDir}/$($file.Name)" -Folder "${docLib}${currentDir}" -Values @{'Title' = $($file.Name)}
    }
}
