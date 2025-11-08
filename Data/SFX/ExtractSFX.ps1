# ==============================================================================
# SFX Extraction script
# Used to extract the SFX data out of a vanilla US ALTTP ROM.
# By Jared_Brian_
# Version 1.0
# 11/01/25
# ==============================================================================
# Use the "-ignoreUnused" flag to instead include the unused data as part of the
# SFX they are closest to.
# ==============================================================================

param
(
    # Define an optional string parameter.
    [string]$arg1 = ""
)

$includeUnused = $true
if ($args.Count -gt 0)
{
    if ("-ignoreUnused" -eq $args[0])
    {
        $includeUnused = $false
    }
}

$sourceRomPath = 'alttp.sfc'

$SFXCounts = 0x1F, 0x3E , 0x3E
$pointerAddresses = 0x0D0B70, 0x0D0BD0, 0x0D0CCC
$startOfSFXDataAddress = 0x0D0DC8
$endOfSFXDataAddress = 0x0D1C00

# The vanilla ROM has a bunch of unused sound effect data that have no pointer.
# So to keep track of them we have to hardcode them.
$vanillaUnused = 0x0D0E0B, 0x0D10CC, 0x0D1292, 0x0D12C3, 0x0D18DD, 0x0D18E3, 0x0D1A07, 0x0D1A2C, 0x0D1A52, 0x0D1B2E, 0x0D1B4D, 0x0D1B79, 0x0D1BA6, 0x0D1BB7, 0x0D1BC8, 0x0D1BD9, 0x0D1BE1, 0x0D1BFA

$vanillaUnusedNames = 0x1A5B, 0x1D1C, 0x1EE2, 0x1F13, 0x252D, 0x2533, 0x2657, 0x267C, 0x26A2, 0x277E, 0x279D, 0x27C9, 0x27F6, 0x2807, 0x2818, 0x2829, 0x2831, 0x284A

# Combine the script's directory with the relative paths.
$sourceFile = Join-Path -Path $PSScriptRoot -ChildPath $sourceRomPath

Write-Host "========================================================="
Write-Host "Extracting SFX files from $sourceFile"
Write-Host "========================================================="

try
{
    # Open the source file for reading.
    $fileStream = [System.IO.File]::OpenRead($sourceFile)

    # Move the file stream's cursor to the correct position.
    $fileStream.Seek($pointerAddresses[0], [System.IO.SeekOrigin]::Begin) | Out-Null
    $buffer = New-Object byte[](2)
    $bytesRead = $fileStream.Read($buffer, 0, 2)

    # Make sure the file opened properly.
    if ($bytesRead -ne 2)
    {
        throw "Pointer size read failed $_"
    }

    $addresses = [System.Collections.Generic.List[PSCustomObject]]::new()

    # Get the pointers for each SFX.
    for ($k = 0; $k -lt $pointerAddresses.Count; $k++)
    {
        for ($i = 0; $i -lt $SFXCounts[$k]; $i++)
        {
            # Move the file stream's cursor to the correct position.
            $fileStream.Seek($pointerAddresses[$k] + ($i * 2), [System.IO.SeekOrigin]::Begin) | Out-Null

            $buffer = New-Object byte[](2)
            $bytesRead = $fileStream.Read($buffer, 0, 2)

            if ($bytesRead -ne 2)
            {
                throw "Pointer read failed $_"
            }

            # Convert the 2 bytes to a 16-bit signed integer (UInt16)
            $int16Value = [System.BitConverter]::ToUInt16($buffer, 0)

            if ($int16Value -eq 0x0000)
            {
                continue
            }

            # Adjust the pointer from the SPC poitner to a PC one.
            $int16Value = $int16Value - 0x1A18 + $startOfSFXDataAddress

            $temp1 = $k + 1
            $temp2 = $i + 1

            if ($k -eq 0)
            {
                $addressTuple = [PSCustomObject]@{
                    Address = $int16Value
                    Name    = "Ambient_" + "$('{0:X2}' -f $temp2)"
                    Size    = 0x0000
                }
            }
            else
            {
                $addressTuple = [PSCustomObject]@{
                    Address = $int16Value
                    Name    = "SFX$temp1" + "_" + "$('{0:X2}' -f $temp2)"
                    Size    = 0x0000
                }
            }

            $addresses.Add($addressTuple)
        }
    }

    # Add the unused addresses if we need to.
    if ($includeUnused)
    {
        for ($i = 0; $i -lt $vanillaUnused.Count; $i++)
        {
            $addressTuple = [PSCustomObject]@{
                Address = $vanillaUnused[$i]
                Name    = "UnusedSFX" + "_" + "$('{0:X4}' -f $vanillaUnusedNames[$i])"
                Size    = 0x0000
            }

            $addresses.Add($addressTuple)
        }
    }

    # Remove duplicates:
    $toRemove = [System.Collections.Generic.List[PSCustomObject]]::new()
    for ($k = 0; $k -lt $addresses.Count; $k++)
    {
        for ($i = $k; $i -lt $addresses.Count; $i++)
        {
            if ($k -eq $i)
            {
                continue
            }

            if ($addresses[$k].Address -eq $addresses[$i].Address)
            {
                $toRemove.Add($addresses[$i])
            }
        }
    }

    for ($i = 0; $i -lt $toRemove.Count; $i++)
    {
        $addresses.Remove($toRemove[$i])
    }

    # Sort the addresses so we can get their size.
    $addresses = $addresses | Sort-Object -Property Address

    # Calculate the size for each SFX.
    for ($i = 0; $i -lt $addresses.Count - 1; $i++)
    {
        $size = $addresses[$i + 1].Address - $addresses[$i].Address
        $addresses[$i].Size = $size
    }

    $size = $endOfSFXDataAddress - $addresses[$addresses.Count - 1].Address
    $addresses[$addresses.Count - 1].Size = $size

    #$addresses | Format-Table -Property @{
    #    Name       = 'Address'
    #    Expression = { '0x{0:X6}' -f $_.Address }
    #}, Name, @{
    #    Name       = 'Size'
    #    Expression = { '0x{0:X4}' -f $_.Size }
    #}
    
    # Get the data for each SFX and write them to a file:
    for ($i = 0; $i -lt $addresses.Count; $i++)
    {
        # Move the file stream's cursor to the correct position.
        $fileStream.Seek($addresses[$i].Address, [System.IO.SeekOrigin]::Begin) | Out-Null

        # Read the data from the current position in the file into the buffer.
        $buffer = New-Object byte[]($addresses[$i].Size)
        $bytesRead = $fileStream.Read($buffer, 0, $addresses[$i].Size)

        # Handle cases where fewer bytes were read than requested.
        if ($bytesRead -lt $addresses[$i].Size)
        {
            $buffer = $buffer | Select-Object -First $bytesRead
        }

        $name = $addresses[$i].Name + ".sfx"
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
    Write-Error "An error occurred:`n$_"

    # Wait for the user to input something.
    Write-Host "Press any key to exit..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    Exit 1
}

# ==============================================================================