Param(
  [String] $ColorName = "Black",
  [String] $ColorValue = "#000000",
  [String] $SvgContent = "",
  [String] $OutputPath = "temp.svg"
)
  
$newXml = $SvgContent

$match = Select-String -Pattern "<path[^\/]*\/>|<polygon[^\/]*\/>|<rect[^\/]*\/>" -InputObject $SvgContent -AllMatches
if($null -ne $match){
  $match.Matches | ForEach-Object {
    if ($_.ToString().IndexOf("fill=") -eq -1) {
      $from = $_
      $to = $from.ToString().Replace("<path", "<path fill=`"$colorValue`"")
      $to = $to.ToString().Replace("<polygon", "<polygon fill=`"$colorValue`"")
      $to = $to.ToString().Replace("<rect", "<rect fill=`"$colorValue`"")
      $newXml = $newXml.Replace($from, $to)
    }
  }
}
$newXml = $newXml.Replace("height=`"24`" viewBox=`"0 0 24 24`" width=`"24`"", "height=`"512`" viewBox=`"0 0 24 24`" width=`"512`"")

if(Test-Path -Path $OutputPath) {
  Remove-Item -Path $OutputPath -Force
}
New-Item -Path $OutputPath -ItemType File -Value $newXml

  