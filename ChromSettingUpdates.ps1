#jq '.profile.content_settings.exceptions.cookies ={"[*.]microsoftonline.com,*": {"expiration": "0","last_modified": "13242370390164654","model": 0,"setting": 2}}' Preferences-old > output
$LocalAppData = [Environment]::GetFolderPath( [Environment+SpecialFolder]::LocalApplicationData )
$ChromeDefaults = Join-Path $LocalAppData "Google\Chrome\User Data\Default"
$ChromePrefFile = Join-Path $ChromeDefaults "Preferences"

#simple find and repleace
((Get-Content -path $ChromePrefFile -Raw) -replace '"cookies":{}','"cookies":{"[*.]microsoftonline.com,*": {"expiration": "0","last_modified": "13242370390164654","model": 0,"setting": 2}}') | Set-Content -Path "$ChromeDefaults\Preferences-edited-v1"  -Encoding Default -NoNewline

#run this jq command
jq '.profile.block_third_party_cookies = false | .profile.cookie_controls_mode  = 0 | .profile.default_content_setting_values = { "cookies": 4 }' $ChromeDefaults\Preferences-edited-v1 > $ChromeDefaults\Preferences-edited-v2

#Then change to raw file and ANSI(Default) format
Get-Content "$ChromeDefaults\Preferences-edited-v2" -Raw | Out-File -NoNewline -FilePath $ChromePrefFile -Encoding Default
