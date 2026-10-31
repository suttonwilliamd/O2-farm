$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = $PSScriptRoot
$temporaryArchive = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName() + '.zip')
$files = @(Get-ChildItem -LiteralPath $root -File -Filter '*.lua')
$files += Get-Item -LiteralPath (Join-Path $root 'NotoEmoji-Regular.ttf')
foreach ($directory in @('objects', 'systems')) {
    $files += Get-ChildItem -LiteralPath (Join-Path $root $directory) -Recurse -File -Filter '*.lua'
}

try {
    $archive = [System.IO.Compression.ZipFile]::Open($temporaryArchive, 'Create')
    try {
        foreach ($file in ($files | Sort-Object FullName)) {
            $entry = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $archive, $file.FullName, $entry, [System.IO.Compression.CompressionLevel]::Optimal
            ) | Out-Null
        }
    } finally {
        $archive.Dispose()
    }
    Move-Item -LiteralPath $temporaryArchive -Destination (Join-Path $root 'game.love') -Force
    Write-Output 'Updated game.love (runtime sources and font only).'
} finally {
    if (Test-Path -LiteralPath $temporaryArchive) {
        Remove-Item -LiteralPath $temporaryArchive
    }
}
