# ==============================================================================
# BRR Extraction script
# Used to extrac the BRR data out of a vanilla US ALTTP ROM.
# By Jared_Brian_
# Version 1.0
# 10/28/25
# ==============================================================================

param
(
    # Define an optional integer parameter for the starting address
    # If not provided, it defaults to 0x008010
    [string]$arg1 = "y"
)

# Define the relative paths from the script's location.
$sourceRomPath = 'alttp.sfc'

$defaultNames = "00_noise", "01_rain", "02_timpani", "03_square", "04_saw", "05_clink", "06_wobbly", "07_compoundSaw", "08_tweet", "09_strings", "0A_trombone", "0B_cymbal", "0C_ocarina", "0D_chime", "0E_harp", "0F_splash", "10_trumpet", "11_horn", "12_snare", "13_choir", "14_flute", "15_oof", "16_piano"

$useDefaultNames = $true
if ($args.Count -gt 0)
{
    if ("-noDefaulNames" -eq $args[0])
    {
        $useDefaultNames = $false
    }
}

Write-Host "========================================================="
Write-Host "Extracting BRR files from $sourceFile"
Write-Host "========================================================="

# Combine the script's directory with the relative paths.
$sourceFile = Join-Path -Path $PSScriptRoot -ChildPath $sourceRomPath

try
{
    # Open the source file for reading.
    $fileStream = [System.IO.File]::OpenRead($sourceFile)

    # Move the file stream's cursor to the correct position.
    $fileStream.Seek(0x0C8000, [System.IO.SeekOrigin]::Begin) | Out-Null
    $buffer = New-Object byte[](2)
    $bytesRead = $fileStream.Read($buffer, 0, 2)

    if ($bytesRead -ne 2)
    {
        throw "Pointer size read failed $_"
    }

    $pointerCount = [System.BitConverter]::ToUInt16($buffer, 0)

    # Check the size of the transfer here to figure out how many pointers are here.
    $pointerCount = $pointerCount / 4

    # Find the pointers for all of the samples.
    $addresses = [System.Collections.Generic.List[int]]::new()
    $sizes = [System.Collections.Generic.List[int]]::new()
    $previousAddress = 0x0000
    for ($i = 0; $i -lt $pointerCount; $i++)
    {
        # Move the file stream's cursor to the correct position.
        $fileStream.Seek(0x0C8004 + ($i * 4), [System.IO.SeekOrigin]::Begin) | Out-Null

        $buffer = New-Object byte[](2)
        $bytesRead = $fileStream.Read($buffer, 0, 2)

        if ($bytesRead -ne 2)
        {
            throw "Pointer read failed $_"
        }

        # Convert the 2 bytes to a 16-bit signed integer (UInt16)
        $int16Value = [System.BitConverter]::ToUInt16($buffer, 0)

        if ($int16Value -eq 0xFFFF)
        {
            continue
        }

        # Adjust the pointer from the SPC poitner to a SNES one.
        $int16Value = $int16Value - 0x4000 + 0x0C8078

        $size = 0xFFFF

        if ($i -ne 0)
        {
            $size = $int16Value - $previousAddress
            
            # Check if this pointer and the last one are the same.
            # If they are check which one has bigger size and use that
            # as the correct size.
            if ($int16Value -eq $previousAddress)
            {
                if ($size -gt $sizes[$sizes.Count - 1])
                {
                    $temp = $sizes.Count
                    Write-Host "$i $temp"
                    $sizes[$sizes.Count - 1] = $size 
                }
            }
            else
            {
                $sizes.Add($size)

                $addresses.Add($int16Value)
                $previousAddress = $int16Value
            }
        }
        else
        {
            $addresses.Add($int16Value)
            $previousAddress = $int16Value
        }

        if ($size -ne 0xFFFF)
        {
            #Write-Host "Size:       0x$('{0:X4}' -f $size)`n"
        }

        #Write-Host "Instrament: 0x$('{0:X2}' -f $i)"
        #Write-Host "Address:    0x$('{0:X6}' -f $int16Value)"
    }

    # Get the size for the very last one
    $sizes.Add(0x0CFB18 - $previousAddress)

    # Get the data for each instrament:
    for ($i = 0; $i -lt $addresses.Count; $i++)
    {
        # Move the file stream's cursor to the correct position.
        $fileStream.Seek($addresses[$i], [System.IO.SeekOrigin]::Begin) | Out-Null

        # Read the data from the current position in the file into the buffer.
        $buffer = New-Object byte[]($sizes[$i])
        $bytesRead = $fileStream.Read($buffer, 0, $sizes[$i])

        # Handle cases where fewer bytes were read than requested.
        if ($bytesRead -lt $sizes[$i])
        {
            $buffer = $buffer | Select-Object -First $bytesRead
        }

        $name = ""
        if ($useDefaultNames)
        {
            $name = $defaultNames[$i] + ".brr"
        }
        else
        {
            $name = "Instrament_0x$('{0:X2}' -f $i)" + ".brr"
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
    Write-Host "Successfully extracted all BRR files"
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