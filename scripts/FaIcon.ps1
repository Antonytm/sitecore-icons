Param(
  [String] $ColorName = "Black",
  [String] $ColorValue = "#000000",
  [String] $SvgContent = "",
  [String] $TempSvg = "temp.svg",
  [String] $OutputPath = "temp.svg",
  [String] $Size = "512"
)
  
$newXml = $SvgContent

$newXml = $SvgContent.Replace("<path", "<path fill=`"$colorValue`"")            

Remove-Item -Path $TempSvg -Force
New-Item -Path $TempSvg -ItemType File -Value $newXml

$size = $Size + "x" + $Size

$newXml = $newXml.Replace("height=`"24`" viewBox=`"0 0 24 24`" width=`"24`"", "height=`"512`" viewBox=`"0 0 24 24`" width=`"512`"")

Remove-Item -Path $TempSvg -Force
New-Item -Path $TempSvg -ItemType File -Value $newXml

../tools/imagemagick/convert $TempSvg -gravity center -transparent white -extent $size $OutputPath
