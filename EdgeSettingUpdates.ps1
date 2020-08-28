#jq '.profile.content_settings.exceptions.cookies ={"[*.]microsoftonline.com,*": {"expiration": "0","last_modified": "13242370390164654","model": 0,"setting": 2}}' Preferences-old > output
$LocalAppData = [Environment]::GetFolderPath( [Environment+SpecialFolder]::LocalApplicationData )
$edgeDefaults = Join-Path $LocalAppData "Microsoft\Edge\User Data\Default"
$edgePreferenceFile = Join-Path $edgeDefaults "Preferences"

#simple find and repleace
((Get-Content -path $edgePreferenceFile -Raw) -replace '"cookies":{}','"cookies":{"[*.]microsoftonline.com,*": {"expiration": "0","last_modified": "13242370390164654","model": 0,"setting": 2}}') | Set-Content -Path "$edgeDefaults\Preferences-edited-v1"  -Encoding Default -NoNewline

# #run this jq command
# jq '.profile.block_third_party_cookies = false | .profile.cookie_controls_mode  = 0 | .profile.default_content_setting_values = { "cookies": 4 }' $edgeDefaults\Preferences-edited-v1 > $edgeDefaults\Preferences-edited-v2

# #Then change to raw file and ANSI(Default) format
Get-Content "$edgeDefaults\Preferences-edited-v1" -Raw | Out-File -NoNewline -FilePath $edgePreferenceFile -Encoding Default
