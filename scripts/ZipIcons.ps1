Param(
  [String] $Path = "..\output",
  [String] $ThemeLocation = ""
)

#Get-ChildItem -Path $Path -Directory | ForEach-Object {
#  Write-Host $_.Name
#  $zip = $Path + "\" + $_.Name + ".zip"
#  Write-Host $zip
#  Compress-Archive -Path $_.FullName -Destination $zip
#}

Get-ChildItem -Path $Path -File | Where-Object { $_.Extension -eq ".zip" } | ForEach-Object {
  Write-Host "Moving archive with icons from $($_.FullName) to $($ThemeLocation)"
  Move-Item -Path $_.FullName -Destination $ThemeLocation
}