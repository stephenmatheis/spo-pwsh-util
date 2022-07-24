# Variables
$site = 'https://intellible.sharepoint.com/sites/robi';

# Log in
Connect-PnPOnline -Url $site -Interactive

# NOTE: Only use one option

# Option 1
Set-PnPSite -Identity $site -DenyAddAndCustomizePages $false   

# Option 2
Set-PnPSite -Identity $site -DenyAddAndCustomizePages 0 -NoScriptSite $false

# Option 2
Set-PnPSite -Identity $site -DenyAddAndCustomizePages $false -NoScriptSite $false

