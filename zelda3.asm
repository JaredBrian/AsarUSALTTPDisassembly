; The Legend of Zelda: A Link to the Past Source Code
; Courtesy of MathOnNapkins
; Completed and adjusted for use with ASAR by Jared_Brian_.
; Contributors: scawful, Zarby89

lorom

; Game Initialization

org $008000

incsrc "Bank00.asm"

warnpc $018000

; Dungeon Data

org $018000

incsrc "Bank01.asm"

warnpc $028000

; Overworld and Dungeon Modules

org $028000

incsrc "Bank02.asm"

warnpc $038000

org $0048000

incsrc "Bank04.asm"

warnpc $058000

org $058000

incsrc "Bank05.asm"

warnpc $068000

org $068000

incsrc "Bank06.asm"

warnpc $078000

; Player Control Logic

org $078000

incsrc "Bank07.asm"

warnpc $088000

org $088000

incsrc "Bank08.asm"

warnpc $098000

org $098000

incsrc "Bank09.asm"

warnpc $0A8000

org $0A8000

incsrc "Bank0A.asm"

warnpc $0B8000

org $0B8000

incsrc "Bank0B.asm"

warnpc $0C8000

org $0C8000

incsrc "Bank0C.asm"

warnpc $0D8000

; Player OAM Data, HUD, Item Menu

org $0D8000

incsrc "Bank0D.asm"

warnpc $0E8000

org $0E8000

incsrc "Bank0E.asm"

warnpc $0F8000

org $0F8000

incsrc "Bank0F.asm"

warnpc $108000

; Graphics and Music Data Banks
; TODO: Add the tables or include a way to import gfx data

; org $108000

; incsrc "Bank10.asm"

; warnpc $118000

; org $118000

; incsrc "Bank11.asm"

; warnpc $128000

; org $128000

; incsrc "Bank12.asm"

; warnpc $138000

; org $138000

; incsrc "Bank13.asm"

; warnpc $148000

; org $148000

; incsrc "Bank14.asm"

; warnpc $158000

; org $158000

; incsrc "Bank15.asm"

; warnpc $168000

; org $168000

; incsrc "Bank16.asm"

; warnpc $178000

; org $178000

; incsrc "Bank17.asm"

; warnpc $188000

; org $188000

; incsrc "Bank18.asm"

; warnpc $198000

; org $198000

; incsrc "Bank19.asm"

; warnpc $1A8000

org $1A8000

incsrc "Bank1A.asm"

warnpc $1B8000

org $1B8000

incsrc "Bank1B.asm"

warnpc $1C8000

org $1C8000

incsrc "Bank1C.asm"

warnpc $1D8000

org $1D8000

incsrc "Bank1D.asm"

warnpc $1E8000

org $1E8000

incsrc "Bank1E.asm"

