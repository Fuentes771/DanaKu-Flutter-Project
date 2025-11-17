Add-Type -AssemblyName System.Drawing

$bitmap = New-Object System.Drawing.Bitmap(512, 512)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Background color (teal brand color)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(11, 162, 138))
$graphics.FillRectangle($brush, 0, 0, 512, 512)

# Draw circle
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 8)
$graphics.DrawEllipse($pen, 100, 100, 312, 312)

# Draw text "DK"
$font = New-Object System.Drawing.Font('Arial', 72, [System.Drawing.FontStyle]::Bold)
$stringBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$graphics.DrawString('DK', $font, $stringBrush, 180, 190)

# Save files
$bitmap.Save("$PSScriptRoot\assets\logo.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bitmap.Save("$PSScriptRoot\assets\logo_splash.png", [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$bitmap.Dispose()

Write-Output "PNG files created successfully"
