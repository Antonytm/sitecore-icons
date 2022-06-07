$path = "../input/fa/Font-Awesome/svgs";
$output = "../output/"
$prefix = "fa-";
$temp = "../temp/";
$files = Get-ChildItem -Path $path -Recurse -File | Where-Object { $_.Extension -eq '.svg' }


Remove-Item -Path $output -Force -Recurse
New-Item -Path $output -ItemType Directory

$ouputSizes = @(16, 24, 32, 48, 64, 128)


$colors = @{
    black = "#000000"
    red = "#BE0000"
    green = "#008000"
    blue = "#4200D7"
}

$colors.Keys | ForEach-Object {
    $colorName = $_
    $colorFolder = $output + $prefix + $colorName
    New-Item -Path $colorFolder -ItemType Directory
    $ouputSizes | ForEach-Object{
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
        
        $newXml = $SvgContent.Replace("<path", "<path fill=`"$colorValue`"")
        #Write-Host $newXml
        #Write-Host $SvgContent
        Remove-Item -Path $tempXml -Force
        New-Item -Path $tempXml -ItemType File -Value $newXml

        $outputPath = $temp + "temp.png"
        $size = $max + "x" + $max
        ../tools/magick/convert $tempXml -gravity center -transparent white -extent $size $outputPath
        $inputPath = $outputPath

        $ouputSizes | ForEach-Object {
            $size = $_.ToString() + "x" + $_.ToString()
            $folder = $output + "\\" + $prefix + $colorName + "\\" + $size
            $outputPath = $folder + "\\" + $filename
            ../tools/magick/convert $inputPath -transparent white -resize $size $outputPath
        }
    }

    
}