Param(
    [String] $Path = "",
    [String] $Prefix = "",
    [String] $Output = "../output/"
)

$temp = "../temp/";

$files = Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.Extension -eq '.svg' }

$ouputSizes = @(16, 24, 32, 48, 64, 128)

$colors = @{
    black = "#000000"
    red   = "#BE0000"
    green = "#008000"
    blue  = "#4200D7"
}

$colors.Keys | ForEach-Object {
    $colorName = $_
    $colorFolder = $Output + $Prefix + $colorName
    New-Item -Path $colorFolder -ItemType Directory
    $ouputSizes | ForEach-Object {
        #Create folder for output images
        $folder = $colorFolder + "\\" + $_.ToString() + "x" + $_.ToString()
        New-Item -Path $folder -ItemType Directory
    }
}



$files | ForEach-Object {
    $inputPath = $_.FullName
    Write-Host $_.FullName
    $filename = $_.Name.Replace(".svg", ".png")

    #intermediate conversion to square png
    [xml]$XmlDocument = Get-Content -Path $inputPath
    [String]$SvgContent = Get-Content -Path $inputPath -Raw
    Write-Host $XmlDocument.svg.viewBox
    $split = $XmlDocument.svg.viewBox.split(" ")
    $x = $split[2]
    $y = $split[3]

    $max = $x
    if ($y -gt $max) {
        $max = $y
    }

    $tempXml = $temp + "temp.svg"
    $colors.Keys | ForEach-Object {
        $colorName = $_
        $colorValue = $colors.Item($colorName)

        if ($Prefix -eq "mui-") {
            & .\MuiIcon.ps1 -SvgContent $SvgContent -ColorValue $colorValue -ColorName $colorName -OutputPath $tempXml
            $inputPath = $tempXml
        }

        if ($Prefix -eq "fa-") {
            $outputPath = $temp + "temp.png"
            & .\FaIcon.ps1 -SvgContent $SvgContent -ColorValue $colorValue -ColorName $colorName -TempSvg $tempXml -OutputPath $outputPath
            $inputPath = $outputPath
        }
        
        
        $ouputSizes | ForEach-Object {
            $size = $_.ToString() + "x" + $_.ToString()
            $folder = $output + "\\" + $Prefix + $colorName + "\\" + $size
            $outputPath = $folder + "\\" + $filename
            ../tools/imagemagick/convert $inputPath -transparent white -resize $size $outputPath
        }
    }
}