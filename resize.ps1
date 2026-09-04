Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem -Path "bg_*.png"
foreach ($file in $files) {
    $img = [System.Drawing.Image]::FromFile($file.FullName)
    $newWidth = $img.Width / 2
    $newHeight = $img.Height / 2
    
    $newImg = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
    $g = [System.Drawing.Graphics]::FromImage($newImg)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, 0, 0, $newWidth, $newHeight)
    
    $img.Dispose()
    $g.Dispose()
    
    # Save over the original
    $newImg.Save($file.FullName, [System.Drawing.Imaging.ImageFormat]::Png)
    $newImg.Dispose()
    
    Write-Host "Resized $($file.Name) to $newWidth x $newHeight"
}
