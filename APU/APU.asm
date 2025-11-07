; ==============================================================================
; This is the boot ROM of the SPC700, which is executed on power on and reset.
; This is executed reguardless of of the game you play and is hardcoded into
; the SPC700 hardware.
; Source:
; https://www.romhacking.net/documents/197
; Documentation cross-referenced with:
; https://youtu.be/zrn0QavLMyo?si=HEXF1BE-RoMJtQVD
;
; This is not actually included in the build of the disasembly and is just here
; for reference. See Sound_LoadSongBank in bank 0x00 for the function that does
; most of the communication with the SPC700 and this boot program.
; ==============================================================================

arch SPC700

org $FFC0
SPC700_BootROM_Hex:
{
    db $CD, $EF, $BD, $E8, $00, $C6, $1D, $D0
    db $FC, $8F, $AA, $F4, $8F, $BB, $F5, $78

    db $CC, $F4, $D0, $FB, $2F, $19, $EB, $F4
    db $D0, $FC, $7E, $F4, $D0, $0B, $E4, $F5

    db $CB, $F4, $D7, $00, $FC, $D0, $F3, $AB
    db $01, $10, $EF, $7E, $F4, $10, $EB, $BA

    db $F6, $DA, $00, $BA, $F4, $C4, $F4, $DD
    db $5D, $D0, $DB, $1F, $00, $00, $C0, $FF
}

org $FFC0
SPC700_BootROM:
{
    ; *** INIT ***
    ; SPC $FFC0

    ; Setup the stack pointer.
    mov.b X, #$EF : mov SP, X 

    ; Clear the 0 page ARAM.  
    mov.b A, #$00

    .zeroLoop 

        mov (X), A    
    dec X : bne .zeroLoop 

    ; Signal "ready" to the 5A22 (APUIOPort0-1 ($2140-1) will return #$BBAA).
    mov.b SMP.CPUIO0, #$AA
    mov.b SMP.CPUIO1, #$BB

    .replyLoop

        ; Wait for the 5A22 to reply by writing #$CC to APUIOPort0 ($2140).
    cmp.b SMP.CPUIO0, #$CC : bne .replyLoop
    
    bra .start

    ; *** TRANSFER ROUTINE ***
    ; SPC $FFD6
    .block
        .waitLoop

            ; First, wait for the 5A22 to indicate that it is ready on
            ; APUIOPort0 ($2140).
        mov.b Y, SMP.CPUIO0 : bne .waitLoop

        .data

                ; Start loop: wait for "next byte/end" signal on APUIOPort0
                ; ($2140).
                cmp.b Y, SMP.CPUIO0 : bne .retry
                    ; Got "next byte" (APUIOPort0 ($2140) matches expected byte index).

                    ; Read byte-to-write from APUIOPort1 ($2141).
                    mov.b A, SMP.CPUIO1

                    ; Echo the index back to APUIOPort0 ($2140) to signal ready.
                    mov.b SMP.CPUIO0, Y

                    ; Write the byte and update the counter.
                    mov.b ($00)+Y, A
                    inc Y : bne .data
                        ; Handle $xxFF->$xx00 overflow case on increment.
                        inc.b $01

                .retry
            bpl .data

            ; If "next byte/end" is more than the expected next byte index,
            ; drop back into the main loop.
        cmp.b Y, SMP.CPUIO0 : bpl .data

        ; *** MAIN LOOP ***
        ; SPC $FFEF
        .start
        
        ; If mode 0 this will be the starting address from 5A22's APUIOPort2-3
        ; ($2142-3). If not a mode 0 this will be the ARAM address to transfer to.
        movw.b YA, SMP.CPUIO2 : movw.b $00, YA

        ; Get the mode from APUIOPort1 ($2141), and echo APUIOPort0 ($2140) back.
        movw.b YA, SMP.CPUIO0 : mov.b SMP.CPUIO0, A

        mov A, Y : mov X, A
    ; If the mode is non-0, begin a block transfer.
    bne .block

    ; if mode 0, jump to address.
    ; SPC $FFFB
    jmp.w ($0000+X)

    ; RESET vector
    ; SPC $FFFE
    dw SPC700_BootROM
}

arch 65816

; ==============================================================================
