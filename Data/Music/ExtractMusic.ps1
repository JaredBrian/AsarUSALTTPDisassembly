# ==============================================================================
# Music Extraction script
# Used to extract the Music data out of a vanilla US ALTTP ROM.
# By Jared_Brian_
# Version 1.0
# 01/05/26
# ==============================================================================
# Use the "-noDefaulNames" flag to not name the music base on what they
# are in vanilla and instead give them a generic name.
# ==============================================================================

param
(
    # Define an optional string parameter for the default names.
    [string]$arg1 = ""
)

$useDefaultNames = $true
if ($args.Count -gt 0)
{
    if ("-noDefaulNames" -eq $args[0])
    {
        $useDefaultNames = $false
    }
}

$sourceRomPath = 'alttp.sfc'

$SongDataStartAddresses = 0x0D1F2F, 0x0D1FF8, 0x0D2763, 0x0D2BA0, 0x0D2DDE, 0x0D3263, 0x0D37D5, 0x0D3D0A, 0x0D3E66, 0x0D470C, 0x0D1CE9, 0x0D47EF, 0x0D4CAB, 0x0D5151, 0x0D49F3, 0x0D804A, 0x0D8BF0, 0x0D913E, 0x0D9435, 0x0D96FD, 0x0D9922, 0x0D9C0F, 0x0DA1D5, 0x000000, 0x0DA308, 0x0DA584, 0x0DA90D, 0x0DAB6E, 0x0DACC7, 0x0DB120, 0x0DAD7A, 0x0D53CA, 0x0D63E8, 0x0D5681 

$SongDataEndAddresses = 0x0D1FF7, 0x0D2762, 0x0D2B9F, 0x0D2DDD, 0x0D3262, 0x0D37D4, 0x0D3D09, 0x0D3E65, 0x0D470B, 0x0D47EE, 0x0D1EF4, 0x0D49F2, 0x0D5150, 0x0D5332, 0x0D4CA7, 0x0D8BEF, 0x0D913D, 0x0D9434, 0x0D96FC, 0x0D9921, 0x0D9C0E, 0x0DA1D4, 0x0DA307, 0x000000, 0x0DA583, 0x0DA90C, 0x0DAB6D, 0x0DACC2, 0x0DAD79, 0x0DB1D2, 0x0DB11F, 0x0D5680, 0x0D741F, 0x0D63E3

$defaultNames = "01_TriforceIntro", "02_LightWorldOverture", "03_Rain", "04_BunnyTheme", "05_LostWoods", "06_LegendsTheme_Attract", "07_KakarikoVillage", "08_MirrorWarp", "09_DarkWorld", "0A_PullingTheMasterSword", "0B_FairyTheme", "0C_Fugitive", "0D_SkullWoodsMarch", "0E_MinigameTheme", "0F_IntroFanfare", "10_HyruleCastle", "11_PendantDungeon", "12_Cave", "13_Fanfare", "14_Sanctuary", "15_Boss", "16_CrystalDungeon", "17_Shop", "test", "19_ZeldaRescue", "1A_CrystalMaiden", "1B_BigFairy", "1C_Suspense", "1D_AgahnimEscapes", "1E_MeetingGanon", "1F_KingOfThieves", "20_TriforceRoom", "21_EndingTheme", "22_Credits"

# Combine the script's directory with the relative paths.
$sourceFile = Join-Path -Path $PSScriptRoot -ChildPath $sourceRomPath

Write-Host "========================================================="
Write-Host "Extracting Music files from $sourceFile"
Write-Host "========================================================="

try
{
    # Open the source file for reading.
    $fileStream = [System.IO.File]::OpenRead($sourceFile)

    # Get the data for each song:
    for ($i = 0; $i -lt $SongDataStartAddresses.Count; $i++)
    {
        if ($SongDataStartAddresses[$i] -eq 0x000000)
        {
            continue;
        }

        # Move the file stream's cursor to the correct position.
        $fileStream.Seek($SongDataStartAddresses[$i], [System.IO.SeekOrigin]::Begin) | Out-Null

        $size = $SongDataEndAddresses[$i] - $SongDataStartAddresses[$i] + 1

        # Read the data from the current position in the file into the buffer.
        $buffer = New-Object byte[]($size)
        $bytesRead = $fileStream.Read($buffer, 0, $size)

        # Handle cases where fewer bytes were read than requested.
        if ($bytesRead -lt $size)
        {
            $buffer = $buffer | Select-Object -First $bytesRead
        }

        $name = ""
        if ($useDefaultNames)
        {
            $name = $defaultNames[$i] + ".bin"
        }
        else
        {
            $name = "Song_0x$('{0:X2}' -f $i)" + ".bin"
        }
        
        $destinationFile = Join-Path -Path $PSScriptRoot -ChildPath $name

        # Ensure the destination directory exists.
        $destinationDirectory = Split-Path -Path $destinationFile -Parent
        if (-not (Test-Path -Path $destinationDirectory))
        {
            New-Item -Path $destinationDirectory -ItemType Directory | Out-Null
        }

        # Write the copied bytes to the new file.
        [System.IO.File]::WriteAllBytes($destinationFile, $buffer)
        Write-Host "`nCopied 0x$('{0:X4}' -f $bytesRead) bytes from '$sourceRomPath' to '$name'."
    }

    # Close the file stream.
    $fileStream.Close()

    Write-Host "`n"
    Write-Host "========================================================="
    Write-Host "Successfully extracted all music files"
    Write-Host "========================================================="
}
catch
{
    Write-Error "An error occurred: $_"

    # Wait for the user to input something.
    Write-Host "Press any key to exit..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    Exit 1
}

# ==============================================================================