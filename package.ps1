$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = $PSScriptRoot
$temporaryArchive = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName() + '.zip')
$files = @(
    'main.lua', 'conf.lua', 'config.lua',
    'objects/earth.lua', 'objects/mars.lua',
    'systems/scaling.lua', 'systems/stars.lua'
) | ForEach-Object { Get-Item -LiteralPath (Join-Path $root $_) }

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
    Write-Output 'Updated game.love (seven active runtime sources only).'
} finally {
    if (Test-Path -LiteralPath $temporaryArchive) {
        Remove-Item -LiteralPath $temporaryArchive
    }
}
