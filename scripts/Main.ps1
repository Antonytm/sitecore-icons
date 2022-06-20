$output = "../output/"

# Clean up the output directory
if(Test-Path -Path $output) {
  Remove-Item -Path $output -Force -Recurse
}
New-Item -Path $output -ItemType Directory

# Process MUI Icons
# There are 5 types of MUI icons: regular, sharp, outlined, rounded, two tones. To decrease amount of icons to process, we'll only process regular icons.
# If you want to use other type of icons change -Match parameter
& .\Generic.ps1 -Prefix "mui-" -Path "../input/mui/material-ui/packages/mui-icons-material/material-icons" -Match "^image_search_24px.*$"
# Process FA Icons
& .\Generic.ps1 -Prefix "fa-" -Path "../input/fa/Font-Awesome/svgs" -Match "^bookmark.*$"

# ZIP icons

& .\ZipIcons.ps1 -Path $output -ThemeLocation "../package/files/sitecore/shell/Themes/Standard"
