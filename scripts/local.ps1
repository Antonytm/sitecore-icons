Set-Alias -Name 7z -Value "C:\Program Files\7-Zip\7z.exe"
Set-Alias -Name msbuild -Value "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"

& msbuild ../src/SitecoreIcons/SitecoreIcons/SitecoreIcons.csproj /p:Configuration=Debug /p:DeployOnBuild=true /p:PublishProfile=FolderProfile
if(Test-Path -Path "../package/files/bin/roslyn") {
  Remove-Item -Path "../package/files/bin/roslyn" -Force -Recurse
}

#& curl https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-portable-Q16-x64.zip -o ..\tools\imagemagick.zip

#& 7z x tools\imagemagick.zip -o..\tools\imagemagick

& .\main.ps1

7z ${$env.paths}

cd ..

cd output
& 7z a -tzip fa-black.zip fa-black
& 7z a -tzip fa-blue.zip fa-blue
& 7z a -tzip fa-green.zip fa-green
& 7z a -tzip fa-red.zip fa-red
& 7z a -tzip mui-black.zip mui-black
& 7z a -tzip mui-blue.zip mui-blue
& 7z a -tzip mui-green.zip mui-green
& 7z a -tzip mui-red.zip mui-red
if(Test-Path -Path "../package/files/sitecore/shell/Themes/Standard/*") {
  Remove-Item -Path "../package/files/sitecore/shell/Themes/Standard/*" -Force -Recurse
}
Move-Item -Path "*.zip" -Destination "../package/files/sitecore/shell/Themes/Standard"
cd ..


cd package

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files
& 7z a -tzip SitecoreIconsFull.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!mui-*"
& 7z a -tzip SitecoreIconsFontAwesome.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*"
& 7z a -tzip SitecoreIconsMUI.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*" "-xr!mui-green*" "-xr!mui-red*" "-xr!mui-blue*"
& 7z a -tzip SitecoreIconsMUIBlack.zip package.zip 

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*" "-xr!mui-black*" "-xr!mui-red*" "-xr!mui-blue*"
& 7z a -tzip SitecoreIconsMUIGreen.zip package.zip 

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*" "-xr!mui-green*" "-xr!mui-black*" "-xr!mui-blue*"
& 7z a -tzip SitecoreIconsMUIRed.zip package.zip 

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*" "-xr!mui-green*" "-xr!mui-red*" "-xr!mui-black*"
& 7z a -tzip SitecoreIconsMUIBlue.zip package.zip 

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!fa-*" "-xr!mui-green*" "-xr!mui-red*" "-xr!mui-blue*"
& 7z a -tzip SitecoreIconsMUIBlack.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!mui-*" "-xr!fa-green*" "-xr!fa-red*" "-xr!fa-blue*"
& 7z a -tzip SitecoreIconsFontAwesomBlack.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!mui-*" "-xr!fa-black*" "-xr!fa-red*" "-xr!fa-blue*"
& 7z a -tzip SitecoreIconsFontAwesomGreen.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!mui-*" "-xr!fa-green*" "-xr!fa-black*" "-xr!fa-blue*"
& 7z a -tzip SitecoreIconsFontAwesomRed.zip package.zip

if(Test-Path -Path "package.zip") {
  Remove-Item -Path "package.zip"
}
& 7z a -tzip package.zip installer metadata files "-xr!mui-*" "-xr!fa-green*" "-xr!fa-red*" "-xr!fa-black*"
& 7z a -tzip SitecoreIconsFontAwesomBlue.zip package.zip

