$output = "../output/"

# Clean up the output directory
if(Test-Path -Path $output) {
  Remove-Item -Path $output -Force -Recurse
}
New-Item -Path $output -ItemType Directory

# Process MUI Icons
& .\Generic.ps1 -Prefix "mui-" -Path "../input/mui/material-ui/packages/mui-icons-material/material-icons" -Match "^(?!.*(_sharp_|_outlined_|_rounded_|_two_tone_)).*$"
# Process FA Icons
& .\Generic.ps1 -Prefix "fa-" -Path "../input/fa/Font-Awesome/svgs"

# ZIP icons

& .\ZipIcons.ps1 -Path $output -ThemeLocation "../package/files/sitecore/shell/Themes/Standard"
