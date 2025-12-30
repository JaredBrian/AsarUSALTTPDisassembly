; ==============================================================================
; A US ASAR Disassembly for The Legend of Zelda: A Link to the Past
; ==============================================================================
; Made by Jared_Brian_

;     The purpose of this dissasembly is to provide a buildable assembly using 
; the Asar SNES assembler, to provide further code clarification from other
; disassemblies, to provide comprehensive RAM maps, and to reorganize data and
; code in a more human readable way. This disassembly is based off of the
; MathOnNapkins' disassembly but has been cleaned up with additional notes,
; labels, and missing data from the original. This disassembly has also been
; cross referenced with Kan's USDASM assembly and has additional notes marking
; places and code that the Zcream ALTTP editor by Zarby89 has changed and or
; moved.

;     This project is mostly just for my own personal use. The way the code and
; data are formatted are that way becuase it roughly follows coding standards
; that I like and that I personally find the most readable. If you prefer a more
; traditional single "opcode per line" or "address on every line" disassembly, I
; reccomend taking a look at Kan's USA disassembly. All of the code comments and
; labels changed are based on my own research, testing, and educated guesswork.
; Nothing should be taken as gospel. There are bound to be plenty of errors, bad
; code comments, or RAM descriptions that are just plain wrong. If you find any
; such issues please let me know by creating an issue here on github or on
; Discord TODO: INSERT DISCORD LINK. However, regaurdless of bad code labels,
; once completed, the final re-assembled product from this disasembly will be an
; exact working copy of a vanilla ALTTP ROM with no bytes differences.

; Contributors: Scawful, Zarby89
; ==============================================================================

lorom

; ==============================================================================

incsrc "General/HardwareRegisters.asm"

incsrc "Gerneral/WRAM.asm"
incsrc "General/ARAM.asm"

; ==============================================================================

org $008000
Bank00:
{
    incsrc "Bank00.asm"
}
warnpc $018000

; ==============================================================================

org $018000
Bank01:
{
    incsrc "Bank01.asm"
}
warnpc $028000

; ==============================================================================

org $028000
Bank02:
{
    incsrc "Bank02.asm"
}
warnpc $038000

; ==============================================================================

org $0038000
Bank03:
{
    incsrc "Bank03.asm"
}
warnpc $058000

; ==============================================================================

org $0048000
Bank04:
{
    incsrc "Bank04.asm"
}
warnpc $058000

; ==============================================================================

org $058000
Bank05:
{
    incsrc "Bank05.asm"
}
warnpc $068000

; ==============================================================================

org $068000
Bank06:
{
    incsrc "Bank06.asm"
}
warnpc $078000

; ==============================================================================

org $078000
Bank07:
{
    incsrc "Bank07.asm"
}
warnpc $088000

; ==============================================================================

org $088000
Bank08:
{
    incsrc "Bank08.asm"
}
warnpc $098000

; ==============================================================================

org $098000
Bank09:
{
    incsrc "Bank09.asm"
}
warnpc $0A8000

; ==============================================================================

org $0A8000
Bank0A:
{
    incsrc "Bank0A.asm"
}
warnpc $0B8000

; ==============================================================================

org $0B8000
Bank0B:
{
    incsrc "Bank0B.asm"
}
warnpc $0C8000

; ==============================================================================

org $0C8000
Bank0C:
{
    incsrc "Bank0C.asm"
}
warnpc $0D8000

; ==============================================================================

org $0D8000
Bank0D:
{
    incsrc "Bank0D.asm"
}
warnpc $0E8000

; ==============================================================================

org $0E8000
Bank0E:
{
    incsrc "Bank0E.asm"
}
warnpc $0F8000

; ==============================================================================

org $0F8000
Bank0F:
{
    incsrc "Bank0F.asm"
}
warnpc $108000

; ==============================================================================

org $108000
Bank10:
{
    incsrc "Bank10.asm"
}
warnpc $118000

; ==============================================================================

org $118000
Bank10:
{
    incsrc "Bank11.asm"
}
warnpc $128000

; ==============================================================================

org $128000
Bank10:
{
    incsrc "Bank12.asm"
}
warnpc $138000

; ==============================================================================

org $138000
Bank10:
{
    incsrc "Bank13.asm"
}
warnpc $148000

; ==============================================================================

org $148000
Bank10:
{
    incsrc "Bank14.asm"
}
warnpc $158000

; ==============================================================================

org $158000
Bank10:
{
    incsrc "Bank15.asm"
}
warnpc $168000

; ==============================================================================

org $168000
Bank10:
{
    incsrc "Bank16.asm"
}
warnpc $178000

; ==============================================================================

org $178000
Bank10:
{
    incsrc "Bank17.asm"
}
warnpc $188000

; ==============================================================================

org $188000
Bank10:
{
    incsrc "Bank18.asm"
}
warnpc $198000

; ==============================================================================

org $198000
Bank10:
{
    incsrc "Bank19.asm"
}
warnpc $1A8000

; ==============================================================================

org $1A8000
Bank10:
{
    incsrc "Bank1A.asm"
}
warnpc $1B8000

; ==============================================================================

org $1B8000
Bank10:
{
    incsrc "Bank1B.asm"
}
warnpc $1C8000

; ==============================================================================

org $1C8000
Bank10:
{
    incsrc "Bank1C.asm"
}
warnpc $1D8000

; ==============================================================================

org $1D8000
Bank10:
{
    incsrc "Bank1D.asm"
}
warnpc $1E8000

; ==============================================================================

org $1E8000
Bank10:
{
    incsrc "Bank1E.asm"
}
warnpc $1F8000

; ==============================================================================

org $1F8000
Bank10:
{
    incsrc "Bank1F.asm"
}
warnpc $208000

; ==============================================================================
