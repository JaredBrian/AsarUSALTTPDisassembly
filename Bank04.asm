; ==============================================================================
; Bank 0x04
; ==============================================================================
; Text Data

print "Start of Bank 0x04: $", pc

; The text data to be read by the text module.
Text:
{
    .Pointers
    dw .text000
    dw .sampleText
    ;dw .text001
    ;dw .text002
    ;dw .text003
    ;dw .text004
    ;dw .text005

    ; Establish the table.
    incsrc "Data/Text/TextMacros.asm"
    incsrc "Data/Text/SmallFont.asm"

    ; Key:
    ; Action means after the command is executed it goes to end the frame.
    ; Instant means it moves immediately to the next command to execute it.

    ; dw $XX00-$XX7F - Action
    ; Valid display chr followed by the high byte for that chr.

    ; db $80 - Instant
    ; Make action / Make instant. If placed After an action command, the next
    ; command/ tile is placed immediately. If place After and instant command,
    ; the next command/tile is placed the next frame.

    ; db $81 : dw $WRAM : db $VV - Instant
    ; Writes a given value to a give WRAM address.

    ; db $82 : dw $WRAM : db $VV - Instant
    ; Writes a given value to a give WRAM2 address.

    ; db $83 : dw $WRAM, $VVVV - Instant
    ; Writes a given value to a give WRAM address.

    ; db $84 : dw $WRAM, $VVVV - Instant
    ; Writes a given value to a give WRAM2 address.

    ; db $85 - Instant
    ; Moves the cursor up one tile.

    ; db $86 - Instant
    ; Moves the cursor down one tile.

    ; db $87 - Instant
    ; Moves the cursor left one tile.

    ; db $88 - Instant
    ; Moves the cursor right one tile.

    ; db $89 : dw $WWWW - Action
    ; Wait the specified amout of time.

    ; db $8A - Action
    ; Clears the BG1 tilemap.

    ; db $8B - Action
    ; Clears the BG2 tilemap.

    ; db $8C - Action
    ; Clears the BG3 tilemap.

    ; db $8D : dw $IIII - Action
    ; Wait until the user presses the given button.

    ; db $8E, $PP - Action
    ; A minecraft §k jumbled text character. $PP is the properties of the tile.

    ; TODO: Add input text box command.

    ; db $FF - Action
    ; End of the text, move on to the next one.

    .sampleText
    %TextSetDestination($0000)
    %TextSetProperties($0000)
    %TextSetSpeed($0001)
    dw " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-+.,`!?:;""''=_/<*([#${>^%&@|~"

    !EndText

    .text000
    %TextSetDestination($0086)
    %TextSetProperties($0000)
    %TextSetSpeed($0001)
    dw """DO YOU THINK GOD STAYS IN"

    %TextSetProperties($0800)

    %TextSetDestination($0100)
    %TextSetProperties($0400)
    dw "HEAVEN"
    %TextWait($0040)
    dw " BECAUSE HE" : !Comma : dw "TOO" : !Comma : dw "LIVES IN"

    %TextSetDestination($0182)
    %TextSetProperties($0800)
    dw "FEAR OF WHAT HE`S CREATED HERE"

    %TextSetDestination($0216)
    %TextSetProperties($1000)
    dw "ON EARTH?""" ;: dw $108E

    %TextSetDestination($048A)
    dw "1."
    %TextSetDestination($049A)
    dw "2."
    %TextSetDestination($050A)
    dw "3."
    %TextSetDestination($051A)
    dw "4."
    %TextSetDestination($058A)
    dw "5."
    %TextSetDestination($059A)
    dw "6."

    %CreateOptions($0003, $0006, $0486, $0496, $04A6, $0506, $0516, $0526)

    !EndText

    !WaitForAnyInput

    ;%TextSetDestination($0000)
    ;!ClearBG3TileMap
    ;!GoToMatrix

    cleartable
}

; ==============================================================================

print "End of Bank 0x04:   $", pc
print " "