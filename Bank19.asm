; ==============================================================================

; Bank 19
; $0C8000-$0CFFFF
org $198000

; The instrament brr samples
; The first half of the SPC engine

; ==============================================================================

SPC_ENGINE          = $0800
SFX_DATA            = $17C0
CREDITS_AUX_POINTER = $2900
SONG_POINTERS_AUX   = $2B00
SAMPLE_POINTERS     = $3C00
INSTRUMENT_DATA     = $3D00
INSTRUMENT_DATA_SFX = $3E00
SAMPLE_DATA         = $4000
SONG_POINTERS       = $D000

; ==============================================================================

; $0C8000-$0C8073 DATA
SamplePointers:
{
    ; Transfer size, transfer address
    dw $0070, SAMPLE_POINTERS

    ; SPC $D000-$D06F DATA
    ; $0C8004-$0C8073 DATA
    base SAMPLE_POINTERS

    dw $4000, $4012 ; 0x00 - Noise
    dw $4048, $4063 ; 0x01 - Rain
    dw $47F2, $5395 ; 0x02 - Timpani
    dw $5395, $53B0 ; 0x03 - Square wave
    dw $53D4, $53EF ; 0x04 - Saw wave
    dw $5413, $542E ; 0x05 - Clink
    dw $5476, $54A3 ; 0x06 - Wobbly lead
    dw $550F, $5521 ; 0x07 - Compound saw
    dw $55B1, $5B2D ; 0x08 - Tweet
    dw $5B2D, $60BB ; 0x09 - Strings A
    dw $5B2D, $60BB ; 0x0A - Strings B
    dw $68AD, $6C9D ; 0x0B - Trombone
    dw $6CD3, $7A65 ; 0x0C - Cymbal
    dw $7A65, $7BFA ; 0x0D - Ocarina
    dw $7C03, $7C78 ; 0x0E - Chimes
    dw $7CDB, $7EA6 ; 0x0F - Harp
    dw $7EC1, $867D ; 0x10 - Splash
    dw $867D, $8D6A ; 0x11 - Trumpet
    dw $8D85, $944E ; 0x12 - Horn
    dw $948D, $A1BC ; 0x13 - Snare A
    dw $948D, $A1BC ; 0x14 - Snare B
    dw $A1BC, $A6E7 ; 0x15 - Choir
    dw $AEB5, $B0D1 ; 0x16 - Flute
    dw $B0EC, $B32C ; 0x17 - Oof
    dw $B32C, $BA61 ; 0x18 - Piano
    dw $FFFF, $FFFF ; 0x19 - null
    dw $FFFF, $FFFF ; 0x1A - null
    dw $FFFF, $FFFF ; 0x1B - null

    base off
}

; ==============================================================================

; $0C8074-$0CFB17 DATA
BRRSampleData:
{
    ; Transfer size, transfer address
    dw $7AA0, SAMPLE_DATA

    ; SPC $4000-$BA9F DATA
    ; $0C8078-$0CFB17 DATA
    base SAMPLE_DATA

    ; SPC $4000-$4047 DATA
    ; $0C8078-$0C80BF DATA
    .Noise
    incbin "Data/BRR/00_noise.brr"

    ; SPC $4048-$47F1 DATA
    ; $0C80C0-$0C8869 DATA
    .Rain
    incbin "Data/BRR/01_rain.brr"

    ; SPC $47F2-$5394 DATA
    ; $0C886A-$0C940C DATA
    .Timpani
    incbin "Data/BRR/02_timpani.brr"

    ; SPC $5395-$53D3 DATA
    ; $0C940D-$0C944B DATA
    .Square
    incbin "Data/BRR/03_square.brr"

    ; SPC $53D4-$5412 DATA
    ; $0C944C-$0C948A DATA
    .Saw
    incbin "Data/BRR/04_saw.brr"

    ; SPC $5413-$5475 DATA
    ; $0C948B-$0C94ED DATA
    .Clink
    incbin "Data/BRR/05_clink.brr"

    ; SPC $5476-$550E DATA
    ; $0C94EE-$0C9586 DATA
    .Wobbly
    incbin "Data/BRR/06_wobbly.brr"

    ; SPC $550F-$55B0 DATA
    ; $0C9587-$0C9628 DATA
    .CompoundSaw
    incbin "Data/BRR/07_compoundSaw.brr"

    ; SPC $55B1-$5B2C DATA
    ; $0C9629-$0C9BA4 DATA
    .Tweet
    incbin "Data/BRR/08_tweet.brr"

    ; SPC $5B2D-$68AC DATA
    ; $0C9BA5-$0CA924 DATA
    .Strings
    incbin "Data/BRR/09_strings.brr"

    ; SPC $68AD-$6CD2 DATA
    ; $0CA925-$0CAD4A DATA
    .Trombone
    incbin "Data/BRR/0A_trombone.brr"

    ; SPC $6CD3-$7A64 DATA
    ; $0CAD4B-$0CBADC DATA
    .Cymbal
    incbin "Data/BRR/0B_cymbal.brr"

    ; SPC $7A65-$7C02 DATA
    ; $0CBADD-$0CBC7A DATA
    .Ocarina
    incbin "Data/BRR/0C_ocarina.brr"

    ; SPC $7C03-$7CDA DATA
    ; $0CBC7B-$0CBD52 DATA
    .Chime
    incbin "Data/BRR/0D_chime.brr"

    ; SPC $7CDB-$7EC0 DATA
    ; $0CBD53-$0CBF38 DATA
    .Harp
    incbin "Data/BRR/0E_harp.brr"

    ; SPC $7EC1-$867C DATA
    ; $0CBF39-$0CC6F4 DATA
    .Splash
    incbin "Data/BRR/0F_splash.brr"

    ; SPC $867D-$8D84 DATA
    ; $0CC6F5-$0CCDFC DATA
    .Trumpet
    incbin "Data/BRR/10_trumpet.brr"

    ; SPC $8D85-$948C DATA
    ; $0CCDFD-$0CD504 DATA
    .Horn
    incbin "Data/BRR/11_horn.brr"

    ; SPC $948D-$A1BB DATA
    ; $0CD505-$0CE233 DATA
    .Snare
    incbin "Data/BRR/12_snare.brr"

    ; SPC $A1BC-$AEB4 DATA
    ; $0CE234-$0CEF2C DATA
    .Choir
    incbin "Data/BRR/13_choir.brr"

    ; SPC $AEB5-$B0EB DATA
    ; $0CEF2D-$0CF163 DATA
    .Flute
    incbin "Data/BRR/14_flute.brr"

    ; SPC $B0EC-$B32B DATA
    ; $0CF164-$0CF3A3 DATA
    .Oof
    incbin "Data/BRR/15_oof.brr"

    ; SPC $B32C-$BA9F DATA
    ; $0CF3A4-$0CFB17 DATA
    .Piano
    incbin "Data/BRR/16_piano.brr"

    base off
}

; ==============================================================================

; $0CFB18-$0CFBC9 DATA
InstrumentData:
{
    ; TODO: Format transfer block better.
    ; Transfer size, transfer address
    dw $00AE, INSTRUMENT_DATA

    ; SPC $3D00-$3D95 DATA
    ; $0CFB1A-$0CFBB1 DATA
    base INSTRUMENT_DATA

    ; TODO: Define all of these.
    ; SRCN, ADSR1, ADSR2, GAIN, MULT (big endian)
    db $00, $FF, $E0, $B8, $04, $70 ; 0x00 - Noise
    db $01, $FF, $E0, $B8, $07, $90 ; 0x01 - Rain
    db $02, $FF, $E0, $B8, $09, $C0 ; 0x02 - Timpani
    db $03, $FF, $E0, $B8, $04, $00 ; 0x03 - Square wave
    db $04, $FF, $E0, $B8, $04, $00 ; 0x04 - Saw wave
    db $05, $FF, $E0, $B8, $04, $70 ; 0x05 - Clink
    db $06, $FF, $E0, $B8, $04, $70 ; 0x06 - Wobbly lead
    db $07, $FF, $E0, $B8, $04, $70 ; 0x07 - Compound saw
    db $08, $FF, $E0, $B8, $07, $A0 ; 0x08 - Tweet
    db $09, $8F, $E9, $B8, $01, $E0 ; 0x09 - Strings A
    db $0A, $8A, $E9, $B8, $01, $E0 ; 0x0A - Strings B
    db $0B, $FF, $E0, $B8, $03, $00 ; 0x0B - Trombone
    db $0C, $FF, $E0, $B8, $03, $A0 ; 0x0C - Cymbal
    db $0D, $FF, $E0, $B8, $01, $00 ; 0x0D - Ocarina
    db $0E, $FF, $EF, $B8, $0E, $A0 ; 0x0E - Chimes
    db $0F, $FF, $EF, $B8, $06, $00 ; 0x0F - Harp
    db $10, $FF, $E0, $B8, $03, $D0 ; 0x10 - Splash
    db $11, $8F, $E0, $B8, $03, $00 ; 0x11 - Trumpet
    db $12, $8F, $E0, $B8, $06, $F0 ; 0x12 - Horn
    db $13, $FD, $E0, $B8, $07, $A0 ; 0x13 - Snare A
    db $14, $FF, $E0, $B8, $07, $A0 ; 0x14 - Snare B
    db $15, $FF, $E0, $B8, $03, $D0 ; 0x15 - Choir
    db $16, $8F, $E0, $B8, $03, $00 ; 0x16 - Flute
    db $17, $FF, $E0, $B8, $02, $C0 ; 0x17 - Oof
    db $18, $FE, $8F, $B8, $06, $F0 ; 0x18 - Piano

    ; TODO: Wtf is stacc?
    ; stacc and attack table
    ; SPC $3D96-$3D9D DATA
    ; $0CFBB2-0CFBB8 DATA
    NoteStacc:
    {
        db $32, $65, $7F, $98, $B2, $CB, $E5, $FC
    }

    ; SPC $3D9E-$3DAD DATA
    ; $0CFBB8-$0CFBCA
    NoteAttack:
    {
        db $19, $32, $4C, $65, $72, $7F, $8C, $98
        db $A5, $B2, $BF, $CB, $D8, $E5, $F2, $FC  
    }

    base off
}

; ==============================================================================

; $0CFBCA-$0D0B6B DATA
SPCEngine:
{
    ; Transfer size, transfer address
    dw $0F9E, SPC_ENGINE

    ; ==========================================================================

    arch SPC700

    ; SPC $0800-$179E
    ; $0CFBCE-$0D0B6B
    base SPC_ENGINE

    ; SPC $0800-$0843 JUMP LOCATION
    ; $0CFBCE-$0CFC11 DATA
    Engine_Start:
    {
        ; Set the dp to 0.
        clrp

        ; Set the stack pointer.
        mov.b X, #$CF : mov SP, X

        ; Clear $0000-$00E0 in ARAM.
        mov.b A, #$00 : mov X, A

        .zeroing_loop_1

            mov (X+), A
        cmp.b X, #$E0 : bne .zeroing_loop_1

        mov.b X, #$00

        ; Clear $0200-$0300 in ARAM.
        .zeroing_loop_2

            mov.w $0200+X, A

            inc X
        bne .zeroing_loop_2

        ; Clear $0300-$0400 in ARAM.
        .zeroing_loop_3

            mov.w $0300+X, A

            inc X
        bne .zeroing_loop_3

        ; A = 1
        inc A
        call ConfigureEcho

        set5.b $48

        mov.b A, #$60
        mov.b Y, #MVOLL
        call WriteToDSP

        mov.b Y, #MVOLR
        call WriteToDSP

        mov.b A, #SAMPLE_POINTERS>>8
        mov.b Y, #DIR
        call WriteToDSP

        ; Set $FFC0 to ROM, clear ports 0123, stop timer 0
        mov.b A, #$F0 : mov.w CONTROL, A

        mov.b A, #$10 : mov.w T0DIV, A
                        mov.b $53, A

        ; Start timer 0
        mov.b A, #$01 : mov.w CONTROL, A

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0844-$08E2 JUMP LOCATION
    ; $0CFC12-$0CFCB0 DATA
    Engine_Main:
    {
        mov.b Y, #$0A

        .next_register

            cmp.b Y, #$05 : beq .FLG_register
                bcs .not_echo_register
                    cmp.b $4C, $4D
                    bne .skip

            .FLG_register

            bbs7.b $4C, .skip
                .not_echo_register

                mov.w A, RegisterList-1+Y : mov.w DSPADDR, A

                mov.w A, LoadValueFrom-1+Y : mov X, A
                mov A, (X) : mov.w DSPDATA, A

            .skip
        dbnz Y, .next_register

        mov.b $45, Y
        mov.b $46, Y

        mov.b A, $18 : eor.b A, $19 : lsr A : lsr A

        notc
        ror.b $18
        ror.b $19

        .timer_wait

            mov.w Y, T0OUT
        beq .timer_wait

        push Y

        mov.b A, #$38 : mul YA : clrc : adc.b A, $43 : mov.b $43, A : bcc .wait_for_SFX
            call Handle_SFX1
            call HandleInput_SFX1

            mov.b X, #$01
            call Synchronize

            call Handle_SFX2
            call HandleInput_SFX2

            mov.b X, #$02
            call Synchronize

            call Handle_SFX3
            call HandleInput_SFX3

            mov.b X, #$03
            call Synchronize

            cmp.b $4C, $4D : beq .wait_for_SFX
                inc.w $03C7 : mov.w A, $03C7
                lsr A : bcs .wait_for_SFX
                    inc.b $4C

        .wait_for_SFX

        mov.b A, $53
        pop Y
        mul YA

        clrc : adc.b A, $51 : mov.b $51, A
                              bcc .ignore_tracker
            call HandleInput_Song

            mov.b X, #$00
            call Synchronize

            jmp Engine_Main

        .ignore_tracker

        mov.b A, $04 : beq .no_song
            mov.b X, #$00
            mov.b $47, #$01

            .next_track

                mov.b A, $31+X : beq .skip_voice
                    call BackgroundTasks

                .skip_voice

                inc X : inc X

                asl.b $47
            bne .next_track

        .no_song

        jmp Engine_Main
    }

    ; ==========================================================================

    ; SPC $08E3-$0901 JUMP LOCATION
    ; $0CFCB1-$0CFCCF DATA
    Synchronize:
    {
        mov.b A, $04+X : mov.w CPUIO0+X, A

        .wait

            mov.w A, CPUIO0+X
        cmp.w A, CPUIO0+X : bne .wait

        ; OPTIMIZE: Useless branch.
        mov Y, A : bne .dumb

        .dumb

        mov.b A, $08+X
        mov.b $08+X, Y : cbne.b $08+X, .change
            mov.b Y, #$00 : mov.b $00+X, Y

            ret

        .change

        mov.b $00+X, Y

        ; SPC $0901 ALTERNATE ENTRY POINT
        ; $0CFCCF DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0902-$096B JUMP LOCATION
    ; $0CFCD0-$0CFD39 DATA
    HandleNote:
    {
        ; Check if percussion hit:
        cmp.b Y, #$CA : bcc .not_percussion
            call TrackCommand_E0_ChangeInstrument

            mov.b Y, #$A4 ; note C4

        .not_percussion

        ; Check if tie:
        cmp.b Y, #$C8 : bcs Synchronize_exit
            mov.b A, $1A : and.b A, $47 : bne Synchronize_exit
                mov A, Y : and.b A, #$7F : clrc : adc.b A, $50
                clrc : adc.w A, $02F0+X : mov.w $0361+X, A

                mov.w A, $0381+X : mov.w $0360+X, A

                ; Move the lowest bit into the carry flag.
                mov.w A, $02B1+X : lsr A

                ; Move the carry flag into the highest bit.
                mov.b A, #$00 : ror A : mov.w $02A0+X, A

                mov.b A, #$00 : mov.b $B0+X, A
                                mov.w $0100+X, A
                                mov.w $02D0+X, A
                                mov.b $C0+X, A

                or.b $5E, $47
                or.b $45, $47

                mov.w A, $0280+X : mov.b $A0+X, A
                                   beq .no_pitch_slide
                    mov.w A, $0281+X : mov.b $A1+X, A

                    mov.w A, $0290+X : bne .do_slide_to
                        mov.w A, $0361+X
                        setc : sbc.w A, $0291+X : mov.w $0361+X, A

                    .do_slide_to

                    mov.w A, $0291+X : clrc : adc.w A, $0361+X
                    call PitchSlide_calc_frames

                .no_pitch_slide

                call GetTempPitch

                ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $096C-$09EE JUMP LOCATION
    ; $0CFD3A-$0CFDBC DATA
    HandleNote_external:
    {
        mov.b Y, #$00
        mov.b A, $11

        setc : sbc.b A, #$34 : bcs .high_note
            mov.b A, $11 : setc : sbc.b A, #$13 : bcs .middle_note
                dec Y
                asl A

        .high_note

        addw.b YA, $10 : movw.b $10, YA

        .middle_note

        push X

        mov.b A, $11 : asl A
        mov.b Y, #$00
        mov.b X, #$18
        div YA, X : mov X, A

        mov.w A, TuningValues+1+Y : mov.b $15, A

        mov.w A, TuningValues+0+Y : mov.b $14, A

        mov.w A, TuningValues+3+Y : push A

        mov.w A, TuningValues+2+Y

        pop Y
        subw.b YA, $14

        mov.b Y, $10
        mul YA : mov A, Y

        mov.b Y, #$00 : addw.b YA, $14 : mov.b $15, Y
        asl A

        rol.b $15

        mov.b $14, A

        bra .proceed

        .pitch_loop

            lsr.b $15
            ror A

            inc X

            .proceed
        cmp.b X, #$06 : bne .pitch_loop

        mov.b $14, A

        pop X

        mov.w A, $0220+X
        mov.b Y, $15
        mul YA : movw.b $16, YA

        mov.w A, $0220+X
        mov.b Y, $14
        mul YA : push Y

        mov.w A, $0221+X
        mov.b Y, $14
        mul YA : addw.b YA, $16

        movw.b $16, YA

        mov.w A, $0221+X
        mov.b Y, $15
        mul YA : mov Y, A

        pop A : addw.b YA, $16 : movw.b $16, YA

        mov A, X : xcn A : lsr A : or.b A, #$02

        mov Y, A
        mov.b A, $16
        call WriteToDSP_Checked

        inc Y

        mov.b A, $17

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; Writes value A to DSP register Y.
    ; if the channel is enabled
    ; SPC $09EF-$09F6 JUMP LOCATION
    ; $0CFDBD-$0CFDC4 DATA
    WriteToDSP_Checked:
    {
        push A

        mov.b A, $47 : and.b A, $1A

        pop A
        bne WriteToDSP_exit
            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; Writes value A to DSP register Y.
    ; SPC $09F7-$09FD JUMP LOCATION
    ; $0CFDC5-$0CFDCB DATA
    WriteToDSP:
    {
        mov.w DSPADDR, Y
        mov.w DSPDATA, A

        ; SPC $09FD ALTERNATE ENTRY POINT
        ; $0CFDCB DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; Mutes everything then prepares for transfer.
    ; SPC $09FE-$0A28 JUMP LOCATION
    ; $0CFDCC-$0CFDF6 DATA
    SongCommand_FF_TransferData:
    {
        mov.b A, #$00
        mov.b Y, #EVOLL
        call WriteToDSP

        mov.b A, #$00
        mov.b Y, #EVOLR
        call WriteToDSP

        mov.b A, #$FF
        mov.b Y, #KOFF
        call WriteToDSP

        call Data_Loader

        mov.b A, #$00 : mov.w $03CA, A
                        mov.b $04, A
                        mov.w $03CF, A
                        mov.w $03CB, A
                        mov.w $03CD, A
                        mov.b $1A, A

        ret
    }

    ; ==========================================================================

    ; SPC $0A29-$0A3E JUMP LOCATION
    ; $0CFDF7-$0CFE0C DATA
    SongCommand_F1_Fadeout:
    {
        mov.b X, #$80 : mov.b $5A, X
                        mov.w $03CA, X

        mov.b A, #$00 : mov.b $5B, A

        setc : sbc.b A, $59
        call MakeFraction : movw.b $5C, YA

        jmp HandleInput_Song_no_new_song
    }

    ; ==========================================================================

    ; SPC $0A3F-$0A4F JUMP LOCATION
    ; $0CFE0D-$0CFE1D DATA
    SongCommand_F2_HalfVolume:
    {
        mov.w A, $03E1 : bne SongCommand_F3_MaxVolume_exit
            mov.b A, $59 : mov.w $03E1, A

            mov.b A, #$70 : mov.b $59, A

            jmp HandleInput_Song_no_new_song
    }

    ; ==========================================================================

    ; SPC $0A4E-$0A62 JUMP LOCATION
    ; $0CFE1E-$0CFE30 DATA
    SongCommand_F3_MaxVolume:
    {
        mov.w A, $03E1 : beq .exit
            mov.w A, $03E1 : mov.b $59, A

            mov.b A, #$00 : mov.w $03E1, A

            jmp HandleInput_Song_no_new_song

        ; SPC $0A62 ALTERNATE ENTRY POINT
        ; $0CFE30 DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0A63-$0A78 JUMP LOCATION
    ; $0CFE31-$0CFE46 DATA
    Song_Commands:
    {
        ; SONG FF - transfer
        cmp.b A, #$FF : beq SongCommand_FF_TransferData
            ; SONG F1 - fade
            cmp.b A, #$F1 : beq SongCommand_F1_Fadeout
                ; SONG F2 - half volume
                cmp.b A, #$F2 : beq SongCommand_F2_HalfVolume
                    ; SONG F3 - max volume
                    cmp.b A, #$F3 : beq SongCommand_F3_MaxVolume
                        ; SONG F0 - mute
                        cmp.b A, #$F0 : beq SongCommand_F0_Mute
                            bra Song_NewJam
    }

    ; ==========================================================================

    ; SPC $0A79-$0A80 JUMP LOCATION
    ; $0CFE47-$0CFE4E DATA
    PerformFadeout:
    {
        dec.w $03CA
        beq SongCommand_F0_Mute
            jmp HandleInput_Song_dont_fade_out
    }

    ; ==========================================================================

    ; SPC $0A81-$0A8E JUMP LOCATION
    ; $0CFE4F-$0CFE5C DATA
    SongCommand_F0_Mute:
    {
        mov.b A, $1A : eor.b A, #$FF : tset.w $0046, A

        mov.b $04, #$00
        mov.b $47, #$00

        ret
    }

    ; ==========================================================================

    ; SPC $0A8F-$0A9C JUMP LOCATION
    ; $0CFE5D-$0CFE6A DATA
    GetNextPart:
    {
        mov.b Y, #$00
        mov.b A, ($40)+Y
        incw.b $40

        push A
        mov.b A, ($40)+Y
        incw.b $40

        mov Y, A
        pop A

        ret
    }

    ; ==========================================================================

    ; Drops a new track.
    ; SPC $0A9D-$0ABD JUMP LOCATION
    ; $0CFE6B-$0CFE8B DATA
    Song_NewJam:
    {
        clrc

        mov.b X, #$00 : mov.w $03CA, X
                        mov.w $03E1, X

        mov.b $04, A

        asl A : mov X, A
        mov.w A, SONG_POINTERS-1+X : mov Y, A
        mov.w A, SONG_POINTERS-2+X : movw.b $40, YA

        mov.b $0C, #$02

        ; SPC $0AB6 ALTERNATE ENTRY POINT
        ; $0CFE84 DATA
        .key_off

        mov.b A, $1A : eor.b A, #$FF : tset.w $0046, A

        ret
    }

    ; ==========================================================================

    ; SPC $0ABE-$0AF8 JUMP LOCATION
    ; $0CFE8C-$0CFEC6 DATA
    EngineStartDelay:
    {
        mov.b X, #$0E
        mov.b $47, #$80

        .next_channel

            mov.b A, #$FF : mov.w $0301+X, A

            mov.b A, #$0A
            call TrackCommand_E1_ChangePan

            mov.w $0211+X, A
            mov.w $0381+X, A
            mov.w $02F0+X, A
            mov.w $0280+X, A
            mov.w $03FF+X, A

            mov.b $B1+X, A
            mov.b $C1+X, A

            dec X : dec X

            lsr.b $47
        bne .next_channel

        mov.b $5A, A
        mov.b $68, A
        mov.b $54, A
        mov.b $50, A
        mov.b $42, A
        mov.b $5F, A

        mov.b $59, #$C0
        mov.b $53, #$20

        ; SPC $0AF8 ALTERNATE ENTRY POINT
        ; $0CFEC6 DATA 
        .exit

        ret
    }

    ; ==========================================================================

    ; The bank 0x19 boundary is crossed in this function.
    ; SPC $0AF9-$0C49 JUMP LOCATION
    ; $0CFEC7-$0D0017 DATA
    HandleInput_Song:
    {
        mov.b A, $00 : beq .no_new_song
            jmp Song_Commands

        .no_new_song

        mov.b A, $04 : beq EngineStartDelay_exit
            mov.w A, $03CA : beq .dont_fade_out
                jmp PerformFadeout

            .dont_fade_out

            mov.b A, $0C : beq .no_delay
                dbnz.b $0C, EngineStartDelay
                    .loop

                                call GetNextPart : bne .valid_pointer
                                    mov Y, A : bne .valid_command
                                        jmp SongCommand_F0_Mute

                                    .valid_command

                                    cmp.b A, #$80 : beq .disable_d_s_p
                                        cmp.b A, #$81 : bne .set_num_loops
                                            mov.b A, #$00

                                    .disable_d_s_p

                                    mov.b $1B, A
                            bra .loop

                            .set_num_loops

                            dec.b $42 : bpl .loop_in_progress
                                mov.b $42, A

                            .loop_in_progress

                            call GetNextPart
                        mov.b X, $42 : beq .loop

                        movw.b $40, YA
                    bra .loop

                    .valid_pointer

                    movw.b $16, YA
                    mov.b Y, #$0F

                    .load_pattern_table_loop

                        mov.b A, ($16)+Y : mov.w $0030+Y, A

                        dec Y
                    bpl .load_pattern_table_loop

                    mov.b X, #$00
                    mov.b $47, #$01

                    .next_channel

                        mov.b A, $31+X : beq .dont_make_noise
                            mov.w A, $0211+X : bne .dont_make_noise
                                mov.b A, #$00
                                call TrackCommand_E0_ChangeInstrument

                        .dont_make_noise

                        mov.b A, #$00 : mov.b $80+X, A
                                        mov.b $90+X, A
                                        mov.b $91+X, A
                        inc A : mov.b $70+X, A

                        inc X : inc X

                        asl.b $47
                    bne .next_channel

            .no_delay

            mov.b X, #$00 : mov.b $5E, X
            mov.b $47, #$01

            .loop_2

                mov.b $44, X
                mov.b A, $31+X : beq .next_channel_2
                    dec.b $70+X : bne .empty_track
                        .try_again

                                call GetTrackByte : bne .non_terminating
                                    mov.b A, $80+X : beq .loop
                                        call IteratePartLoop

                                        dec.b $80+X
                            bne .try_again

                            mov.w A, $0230+X : mov.b $30+X, A

                            mov.w A, $0231+X : mov.b $31+X, A
                        bra .try_again

                        .non_terminating

                        bmi .note_or_command
                            mov.w $0200+X, A

                            call GetTrackByte : bmi .note_or_command
                                push A

                                xcn A : and.b A, #$07 : mov Y, A
                                mov.w A, NoteStacc+Y : mov.w $0201+X, A

                                pop A : and.b A, #$0F : mov Y, A
                                mov.w A, NoteAttack+Y : mov.w $0210+X, A

                                call GetTrackByte

                        .note_or_command

                        ; first command
                        cmp.b A, #$E0 : bcc .note
                            call ExecuteCommand
                            bra .try_again

                        .note

                        mov.w A, $03FF+X : or.b A, $1B : bne .disabled_channel
                            mov A, Y : push A

                            mov.b A, $47 : and.b A, $1A

                            pop A : bne .disabled_channel
                                call HandleNote

                        .disabled_channel

                        mov.w A, $0200+X : mov.b $70+X, A

                        mov Y, A
                        mov.w A, $0201+X
                        mul YA : mov A, Y
                                 bne .non_zero
                            inc A

                        .non_zero

                        mov.b $71+X, A

                        bra .continue

                    .empty_track

                    mov.b A, $1B : bne .next_channel_2
                        call Tracker

                        .continue
                        call PitchSlide

                .next_channel_2

                inc X : inc X

                asl.b $47 : beq .done_with_channels

            jmp .loop_2

            .done_with_channels

            mov.b A, $54 : beq .no_tempo_slide
                movw.b YA, $56 : addw.b YA, $52 : dbnz.b $54, .temp_slide_not_done
                    movw.b YA, $54

                .temp_slide_not_done

                movw.b $52, YA

            .no_tempo_slide

            mov.b A, $68 : beq .no_echo_pan_slide
                movw.b YA, $64 : addw.b YA, $60 : movw.b $60, YA

                movw.b YA, $66 : addw.b YA, $62 : dbnz.b $68, .pan_slide_not_done
                    movw.b YA, $68 : movw.b $60, YA

                    mov.b Y, $6A

                .pan_slide_not_done

                movw.b $62, YA

            .no_echo_pan_slide

            mov.b A, $5A : beq .no_volume_slide
                movw.b YA, $5C
                addw.b YA, $58 : dbnz.b $5A, .volume_slide_not_done
                    movw.b YA, $5A

                .volume_slide_not_done

                movw.b $58, YA
                mov.b $5E, #$FF

            .no_volume_slide

            mov.b X, #$00
            mov.b $47, #$01

            .volume_settings_loop

                mov.b A, $31+X : beq .inactive_track
                    call WritePitch

                .inactive_track

                inc X : inc X

                asl.b $47
            bne .volume_settings_loop

            ret
    }

    ; ==========================================================================

    ; SPC $0C4A-$0C5B JUMP LOCATION
    ; $0D0018-$0D0029 DATA
    ExecuteCommand:
    {
        asl A : mov Y, A

        mov.w A, TrackCommand_Vectors+1-$C0+Y : push A
        mov.w A, TrackCommand_Vectors+0-$C0+Y : push A

        mov A, Y : lsr A : mov Y, A

        mov.w A, TrackCommandParamCount-$60+Y : beq NoParameters
            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C4A-$0C5D JUMP LOCATION
    ; $0D002A-$0D002B DATA
    GetTrackByte:
    {
        mov.b A, ($30+X)

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C5E-$0C63 JUMP LOCATION
    ; $0D002C-$0D0031 DATA
    SkipTrackByte:
    {
        inc.b $30+X
        bne NoParameters
            inc.b $31+X

            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C64-$0C65 JUMP LOCATION
    ; $0D0032-$0D0033 DATA
    NoParameters:
    {
        mov Y, A

        ret
    }

    ; ==========================================================================

    ; SPC $0C64-$0CBE JUMP LOCATION
    ; $0D0034-$0D008C DATA
    TrackCommand_E0_ChangeInstrument:
    {
        mov.w $0211+X, A : mov Y, A
        bpl .no_percussion
            ; Percussion base
            setc : sbc.b A, #$CA : clrc : adc.b A, $5F

        .no_percussion

        mov.b Y, #$06
        mul YA : movw.b $14, YA

        clrc : adc.b $14, #INSTRUMENT_DATA>>0 : adc.b $15, #INSTRUMENT_DATA>>8

        mov.b A, $1A : and.b A, $47 : bne .exit
            push X

            mov A, X : xcn A : lsr A : or.b A, #$04 : mov X, A

            mov.b Y, #$00
            mov.b A, ($14)+Y : bpl .normal_sample
                and.b A, #$1F
                and.b $48, #$20 : tset.w $0048, A

                or.b $49, $47

                mov A, Y

                bra .resume

            .normal_sample

            mov.b A, $47 : tclr.w $0049, A

            .dsp_write_loop

                mov.b A, ($14)+Y

                .resume

                mov.w DSPADDR, X
                mov.w DSPDATA, A

                inc X
                inc Y
            cmp.b Y, #$04 : bne .dsp_write_loop

            pop X

            mov.b A, ($14)+Y : mov.w $0221+X, A

            inc Y
            mov.b A, ($14)+Y : mov.w $0220+X, A

        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0CBF-$0CCC JUMP LOCATION
    ; $0D008D-$0D009A DATA
    TrackCommand_E1_ChangePan:
    {
        mov.w $0351+X, A
        and.b A, #$1F : mov.w $0331+X, A

        mov.b A, #$00 : mov.w $0330+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0CCD-$0CE5 JUMP LOCATION
    ; $0D009B-$0D00B3 DATA
    TrackCommand_E2_PanSlide:
    {
        mov.b $91+X, A

        push A
        call GetTrackByte

        mov.w $0350+X, A : setc : sbc.w A, $0331+X

        pop X
        call MakeFraction

        mov.w $0340+X, A
        mov A, Y : mov.w $0341+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0CE6-$0CF1 JUMP LOCATION
    ; $0D00B4-$0D00BF DATA
    TrackCommand_E3_SetVibrato:
    {
        mov.w $02B0+X, A
        call GetTrackByte

        mov.w $02A1+X, A
        call GetTrackByte

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0CF2-$0CFC JUMP LOCATION
    ; $0D00C0-$0D00CA DATA
    TrackCommand_E4_VibratoOff:
    {
        mov.b $B1+X, A
        mov.w $02C1+X, A

        mov.b A, #$00 : mov.w $02B1+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0CFD-$0D0C JUMP LOCATION
    ; $0D00CB-$0D00DA DATA
    TrackCommand_F0_VibratoGradient:
    {
        mov.w $02B1+X, A
        push A

        mov.b Y, #$00
        mov.b A, $B1+X
        pop X
        div YA, X

        mov.b X, $44
        mov.w $02C0+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D0D-$0D1B JUMP LOCATION
    ; $0D00DB-$0D00E9 DATA
    TrackCommand_E5_GlobalVolume:
    {
        mov.w A, $03CA : bne .exit
            mov.w A, $03E1 : bne .exit
                mov.b A, #$00 : movw.b $58, YA

        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0D1C-$0D2D JUMP LOCATION
    ; $0D00EA-$0D00FB DATA
    TrackCommand_E6_GlobalVolumeSlide:
    {
        mov.b $5A, A
        call GetTrackByte

        mov.b $5B, A

        setc : sbc.b A, $59
        mov.b X, $5A
        call MakeFraction

        movw.b $5C, YA

        ret
    }

    ; ==========================================================================

    ; SPC $0D2E-$0D32 JUMP LOCATION
    ; $0D00FC-$0D0100 DATA
    TrackCommand_E7_SetTempo:
    {
        mov.b A, #$00 : movw.b $52, YA

        ret
    }

    ; ==========================================================================

    TrackCommand_E8_TempoSlide:
    #_1A8101: #_0D33: mov.b $54, A

    #_1A8103: #_0D35: call GetTrackByte
    #_1A8106: #_0D38: mov.b $55, A

    #_1A8108: #_0D3A: setc
    #_1A8109: #_0D3B: sbc.b A, $53
    #_1A810B: #_0D3D: mov.b X, $54
    #_1A810D: #_0D3F: call MakeFraction

    #_1A8110: #_0D42: movw.b $56, YA

    #_1A8112: #_0D44: ret

    ; ==========================================================================

    TrackCommand_E9_GlobalTranspose:
    #_1A8113: #_0D45: mov.b $50, A

    #_1A8115: #_0D47: ret

    ; ==========================================================================

    TrackCommand_EA_ChannelTranspose:
    #_1A8116: #_0D48: mov.w $02F0+X, A

    #_1A8119: #_0D4B: ret

    ;===================================================================================================

    TrackCommand_EB_SetTremelo:
    #_1A811A: #_0D4C: mov.w $02E0+X, A

    #_1A811D: #_0D4F: call GetTrackByte
    #_1A8120: #_0D52: mov.w $02D1+X, A

    #_1A8123: #_0D55: call GetTrackByte

    ;===================================================================================================

    TrackCommand_EC_TremeloOff:
    #_1A8126: #_0D58: mov.b $C1+X, A

    #_1A8128: #_0D5A: ret

    ;===================================================================================================

    TrackCommand_F1_PitchSlideTo:
    #_1A8129: #_0D5B: mov.b A, #$01

    #_1A812B: #_0D5D: bra TrackCommand_F2_PitchSlideFrom_start

    ;===================================================================================================

    TrackCommand_F2_PitchSlideFrom:
    #_1A812D: #_0D5F: mov.b A, #$00

    .start
    #_1A812F: #_0D61: mov.w $0290+X, A

    #_1A8132: #_0D64: mov A, Y
    #_1A8133: #_0D65: mov.w $0281+X, A

    #_1A8136: #_0D68: call GetTrackByte
    #_1A8139: #_0D6B: mov.w $0280+X, A

    #_1A813C: #_0D6E: call GetTrackByte
    #_1A813F: #_0D71: mov.w $0291+X, A

    #_1A8142: #_0D74: ret

    ;===================================================================================================

    TrackCommand_F3_PitchSlideStop:
    #_1A8143: #_0D75: mov.w $0280+X, A

    #_1A8146: #_0D78: ret

    ;===================================================================================================

    TrackCommand_ED_ChannelVolume:
    #_1A8147: #_0D79: mov.w $0301+X, A

    #_1A814A: #_0D7C: mov.b A, #$00
    #_1A814C: #_0D7E: mov.w $0300+X, A

    #_1A814F: #_0D81: ret

    ;===================================================================================================

    TrackCommand_EE_ChannelVolumeSlide:
    #_1A8150: #_0D82: mov.b $90+X, A
    #_1A8152: #_0D84: push A

    #_1A8153: #_0D85: call GetTrackByte
    #_1A8156: #_0D88: mov.w $0320+X, A

    #_1A8159: #_0D8B: setc
    #_1A815A: #_0D8C: sbc.w A, $0301+X

    #_1A815D: #_0D8F: pop X

    #_1A815E: #_0D90: call MakeFraction
    #_1A8161: #_0D93: mov.w $0310+X, A

    #_1A8164: #_0D96: mov A, Y
    #_1A8165: #_0D97: mov.w $0311+X, A

    #_1A8168: #_0D9A: ret

    ;===================================================================================================

    TrackCommand_F4_FineTuning:
    #_1A8169: #_0D9B: mov.w $0381+X, A

    #_1A816C: #_0D9E: ret

    ;===================================================================================================

    TrackCommand_EF_CallPart:
    #_1A816D: #_0D9F: mov.w $0240+X, A

    #_1A8170: #_0DA2: call GetTrackByte
    #_1A8173: #_0DA5: mov.w $0241+X, A

    #_1A8176: #_0DA8: call GetTrackByte
    #_1A8179: #_0DAB: mov.b $80+X, A

    #_1A817B: #_0DAD: mov.b A, $30+X
    #_1A817D: #_0DAF: mov.w $0230+X, A

    #_1A8180: #_0DB2: mov.b A, $31+X
    #_1A8182: #_0DB4: mov.w $0231+X, A

    ;===================================================================================================

    IteratePartLoop:
    #_1A8185: #_0DB7: mov.w A, $0240+X
    #_1A8188: #_0DBA: mov.b $30+X, A

    #_1A818A: #_0DBC: mov.w A, $0241+X
    #_1A818D: #_0DBF: mov.b $31+X, A

    #_1A818F: #_0DC1: ret

    ;===================================================================================================

    TrackCommand_F5_EchoBasicControl:
    #_1A8190: #_0DC2: mov.w $03C3, A
    #_1A8193: #_0DC5: mov.b $4A, A

    #_1A8195: #_0DC7: call GetTrackByte
    #_1A8198: #_0DCA: mov.b A, #$00
    #_1A819A: #_0DCC: movw.b $60, YA

    #_1A819C: #_0DCE: call GetTrackByte
    #_1A819F: #_0DD1: mov.b A, #$00
    #_1A81A1: #_0DD3: movw.b $62, YA

    #_1A81A3: #_0DD5: clr5.b $48

    #_1A81A5: #_0DD7: ret

    ;===================================================================================================

    TrackCommand_F8_EchoSlide:
    #_1A81A6: #_0DD8: mov.b $68, A

    #_1A81A8: #_0DDA: call GetTrackByte
    #_1A81AB: #_0DDD: mov.b $69, A

    #_1A81AD: #_0DDF: setc
    #_1A81AE: #_0DE0: sbc.b A, $61
    #_1A81B0: #_0DE2: mov.b X, $68

    #_1A81B2: #_0DE4: call MakeFraction
    #_1A81B5: #_0DE7: movw.b $64, YA

    #_1A81B7: #_0DE9: call GetTrackByte
    #_1A81BA: #_0DEC: mov.b $6A, A

    #_1A81BC: #_0DEE: setc
    #_1A81BD: #_0DEF: sbc.b A, $63
    #_1A81BF: #_0DF1: mov.b X, $68

    #_1A81C1: #_0DF3: call MakeFraction
    #_1A81C4: #_0DF6: movw.b $66, YA

    #_1A81C6: #_0DF8: ret

    ;===================================================================================================

    TrackCommand_F6_EchoSilence:
    #_1A81C7: #_0DF9: movw.b $60, YA
    #_1A81C9: #_0DFB: movw.b $62, YA

    #_1A81CB: #_0DFD: set5.b $48

    #_1A81CD: #_0DFF: ret

    ;===================================================================================================

    TrackCommand_F7_EchoFilter:
    #_1A81CE: #_0E00: call ConfigureEcho

    #_1A81D1: #_0E03: call GetTrackByte
    #_1A81D4: #_0E06: mov.b $4E, A

    #_1A81D6: #_0E08: call GetTrackByte
    #_1A81D9: #_0E0B: mov.b Y, #$08
    #_1A81DB: #_0E0D: mul YA
    #_1A81DC: #_0E0E: mov X, A
    #_1A81DD: #_0E0F: mov.b Y, #FIR0

    .set_next_filter
    #_1A81DF: #_0E11: mov.w A, EchoFilterParameters+X
    #_1A81E2: #_0E14: call WriteToDSP

    #_1A81E5: #_0E17: inc X

    #_1A81E6: #_0E18: mov A, Y
    #_1A81E7: #_0E19: clrc
    #_1A81E8: #_0E1A: adc.b A, #$10
    #_1A81EA: #_0E1C: mov Y, A

    #_1A81EB: #_0E1D: bpl .set_next_filter

    #_1A81ED: #_0E1F: mov.b X, $44

    #_1A81EF: #_0E21: ret

    ;===================================================================================================

    ; SPC $0E22-$0E67 JUMP LOCATION
    ; $0D01F0-$0D0235 DATA
    ConfigureEcho:
    {
        mov.b $4D, A
        mov.b Y, #EDL

        mov.w DSPADDR, Y
        mov.w A, DSPDATA
        cmp.b A, $4D : beq .edl_same
            and.b A, #$0F : eor.b A, #$FF : bbc7.b $4C, .buffer_ready
                clrc
                adc.b A, $4C

            .buffer_ready

            mov.b $4C, A
            mov.b Y, #$04

            .write_register

                mov.w A, RegisterList-1+Y
                mov.w DSPADDR, A

                mov.b A, #$00
                mov.w DSPDATA, A
            dbnz Y, .write_register

            mov.b A, $48 : or.b A, #$20
            mov.b Y, #FLG
            call WriteToDSP

            mov.b A, $4D
            mov.b Y, #EDL
            call WriteToDSP

        .edl_same

        asl A : asl A : asl A : eor.b A, #$FF
        setc : adc.b A, #SONG_POINTERS>>8
        mov.b Y, #ESA

        jmp WriteToDSP
    }

    ;===================================================================================================

    TrackCommand_FA_PercussionOffset:
    #_1A8236: #_0E68: mov.b $5F, A

    #_1A8238: #_0E6A: ret

    ;===================================================================================================

    DummyCommand:
    #_1A8239: #_0E6B: call SkipTrackByte

    #_1A823C: #_0E6E: ret

    ;===================================================================================================

    ChannelStop:
    #_1A823D: #_0E6F: inc A
    #_1A823E: #_0E70: mov.w $03FF+X, A

    #_1A8241: #_0E73: ret

    ;===================================================================================================

    SongStop:
    #_1A8242: #_0E74: inc A

    ;===================================================================================================

    SongContinue:
    #_1A8243: #_0E75: mov.b $1B, A

    #_1A8245: #_0E77: jmp Song_NewJam_key_off

    ;===================================================================================================

    PitchSlide:
    #_1A8248: #_0E7A: mov.b A, $A0+X
    #_1A824A: #_0E7C: bne .exit

    #_1A824C: #_0E7E: mov.b A, ($30+X)
    #_1A824E: #_0E80: cmp.b A, #$F9
    #_1A8250: #_0E82: bne .exit

    #_1A8252: #_0E84: mov.b A, $47
    #_1A8254: #_0E86: and.b A, $1A
    #_1A8256: #_0E88: beq .do_pitch_slide

    #_1A8258: #_0E8A: mov.b $10, #$04

    .skip_loop
    #_1A825B: #_0E8D: call SkipTrackByte

    #_1A825E: #_0E90: dbnz.b $10, .skip_loop
    #_1A8261: #_0E93: bra .exit

    .do_pitch_slide
    #_1A8263: #_0E95: call SkipTrackByte
    #_1A8266: #_0E98: call GetTrackByte

    ;---------------------------------------------------------------------------------------------------

    #TrackCommand_F9_SlideOnce:
    #_1A8269: #_0E9B: mov.b $A1+X, A

    #_1A826B: #_0E9D: call GetTrackByte
    #_1A826E: #_0EA0: mov.b $A0+X, A

    #_1A8270: #_0EA2: call GetTrackByte
    #_1A8273: #_0EA5: clrc
    #_1A8274: #_0EA6: adc.b A, $50
    #_1A8276: #_0EA8: adc.w A, $02F0+X

    .calc_frames
    #_1A8279: #_0EAB: and.b A, #$7F
    #_1A827B: #_0EAD: mov.w $0380+X, A

    #_1A827E: #_0EB0: setc
    #_1A827F: #_0EB1: sbc.w A, $0361+X
    #_1A8282: #_0EB4: mov.b Y, $A0+X

    #_1A8284: #_0EB6: push Y
    #_1A8285: #_0EB7: pop X
    #_1A8286: #_0EB8: call MakeFraction

    #_1A8289: #_0EBB: mov.w $0370+X, A

    #_1A828C: #_0EBE: mov A, Y
    #_1A828D: #_0EBF: mov.w $0371+X, A

    .exit
    #_1A8290: #_0EC2: ret

    ;===================================================================================================

    GetTempPitch:
    #_1A8291: #_0EC3: mov.w A, $0361+X
    #_1A8294: #_0EC6: mov.b $11, A

    #_1A8296: #_0EC8: mov.w A, $0360+X
    #_1A8299: #_0ECB: mov.b $10, A

    #_1A829B: #_0ECD: ret

    ;===================================================================================================

    MakeFraction:
    #_1A829C: #_0ECE: notc
    #_1A829D: #_0ECF: ror.b $12
    #_1A829F: #_0ED1: bpl .positive_input

    #_1A82A1: #_0ED3: eor.b A, #$FF
    #_1A82A3: #_0ED5: inc A

    .positive_input
    #_1A82A4: #_0ED6: mov.b Y, #$00
    #_1A82A6: #_0ED8: div YA, X

    #_1A82A7: #_0ED9: push A

    #_1A82A8: #_0EDA: mov.b A, #$00
    #_1A82AA: #_0EDC: div YA, X

    #_1A82AB: #_0EDD: pop Y

    #_1A82AC: #_0EDE: mov.b X, $44

    ;---------------------------------------------------------------------------------------------------

    #MakeFraction_abs:
    #_1A82AE: #_0EE0: bbc7.b $12, .keep_positive

    #_1A82B1: #_0EE3: movw.b $14, YA

    #_1A82B3: #_0EE5: movw.b YA, $0E
    #_1A82B5: #_0EE7: subw.b YA, $14

    .keep_positive
    #_1A82B7: #_0EE9: ret

    ;===================================================================================================

    TrackCommand_Vectors:
    #_1A82B8: #_0EEA: dw TrackCommand_E0_ChangeInstrument
    #_1A82BA: #_0EEC: dw TrackCommand_E1_ChangePan
    #_1A82BC: #_0EEE: dw TrackCommand_E2_PanSlide
    #_1A82BE: #_0EF0: dw TrackCommand_E3_SetVibrato

    #_1A82C0: #_0EF2: dw TrackCommand_E4_VibratoOff
    #_1A82C2: #_0EF4: dw TrackCommand_E5_GlobalVolume
    #_1A82C4: #_0EF6: dw TrackCommand_E6_GlobalVolumeSlide
    #_1A82C6: #_0EF8: dw TrackCommand_E7_SetTempo

    #_1A82C8: #_0EFA: dw TrackCommand_E8_TempoSlide
    #_1A82CA: #_0EFC: dw TrackCommand_E9_GlobalTranspose
    #_1A82CC: #_0EFE: dw TrackCommand_EA_ChannelTranspose
    #_1A82CE: #_0F00: dw TrackCommand_EB_SetTremelo

    #_1A82D0: #_0F02: dw TrackCommand_EC_TremeloOff
    #_1A82D2: #_0F04: dw TrackCommand_ED_ChannelVolume
    #_1A82D4: #_0F06: dw TrackCommand_EE_ChannelVolumeSlide
    #_1A82D6: #_0F08: dw TrackCommand_EF_CallPart

    #_1A82D8: #_0F0A: dw TrackCommand_F0_VibratoGradient
    #_1A82DA: #_0F0C: dw TrackCommand_F1_PitchSlideTo
    #_1A82DC: #_0F0E: dw TrackCommand_F2_PitchSlideFrom
    #_1A82DE: #_0F10: dw TrackCommand_F3_PitchSlideStop

    #_1A82E0: #_0F12: dw TrackCommand_F4_FineTuning
    #_1A82E2: #_0F14: dw TrackCommand_F5_EchoBasicControl
    #_1A82E4: #_0F16: dw TrackCommand_F6_EchoSilence
    #_1A82E6: #_0F18: dw TrackCommand_F7_EchoFilter

    #_1A82E8: #_0F1A: dw TrackCommand_F8_EchoSlide
    #_1A82EA: #_0F1C: dw TrackCommand_F9_SlideOnce
    #_1A82EC: #_0F1E: dw TrackCommand_FA_PercussionOffset

    ;===================================================================================================

    TrackCommandParamCount:
    #_1A82EE: #_0F20: db 1 ; E0
    #_1A82EF: #_0F21: db 1 ; E1
    #_1A82F0: #_0F22: db 2 ; E2
    #_1A82F1: #_0F23: db 3 ; E3
    #_1A82F2: #_0F24: db 0 ; E4
    #_1A82F3: #_0F25: db 1 ; E5
    #_1A82F4: #_0F26: db 2 ; E6
    #_1A82F5: #_0F27: db 1 ; E7
    #_1A82F6: #_0F28: db 2 ; E8
    #_1A82F7: #_0F29: db 1 ; E9
    #_1A82F8: #_0F2A: db 1 ; EA
    #_1A82F9: #_0F2B: db 3 ; EB
    #_1A82FA: #_0F2C: db 0 ; EC
    #_1A82FB: #_0F2D: db 1 ; ED
    #_1A82FC: #_0F2E: db 2 ; EE
    #_1A82FD: #_0F2F: db 3 ; EF
    #_1A82FE: #_0F30: db 1 ; F0
    #_1A82FF: #_0F31: db 3 ; F1
    #_1A8300: #_0F32: db 3 ; F2
    #_1A8301: #_0F33: db 0 ; F3
    #_1A8302: #_0F34: db 1 ; F4
    #_1A8303: #_0F35: db 3 ; F5
    #_1A8304: #_0F36: db 0 ; F6
    #_1A8305: #_0F37: db 3 ; F7
    #_1A8306: #_0F38: db 3 ; F8
    #_1A8307: #_0F39: db 3 ; F9
    #_1A8308: #_0F3A: db 1 ; FA

    ; extraneous
    #_1A8309: #_0F3B: db 2 ; FB
    #_1A830A: #_0F3C: db 0 ; FC
    #_1A830B: #_0F3D: db 0 ; FD
    #_1A830C: #_0F3E: db 0 ; FE

    ;===================================================================================================

    WritePitch:
    #_1A830D: #_0F3F: mov.b A, $90+X
    #_1A830F: #_0F41: beq .no_volume_slide

    #_1A8311: #_0F43: mov.b A, #$0300>>0
    #_1A8313: #_0F45: mov.b Y, #$0300>>8
    #_1A8315: #_0F47: dec.b $90+X

    #_1A8317: #_0F49: call IncrementSlide

    .no_volume_slide
    #_1A831A: #_0F4C: mov.b Y, $C1+X
    #_1A831C: #_0F4E: beq .no_tremelo

    #_1A831E: #_0F50: mov.w A, $02E0+X
    #_1A8321: #_0F53: cbne.b $C0+X, .tremelo_not_ready

    #_1A8324: #_0F56: or.b $5E, $47

    #_1A8327: #_0F59: mov.w A, $02D0+X
    #_1A832A: #_0F5C: bpl .tremelo_accumulate

    #_1A832C: #_0F5E: inc Y
    #_1A832D: #_0F5F: bne .tremelo_accumulate

    #_1A832F: #_0F61: mov.b A, #$80
    #_1A8331: #_0F63: bra .skip_accumulate

    .tremelo_accumulate
    #_1A8333: #_0F65: clrc
    #_1A8334: #_0F66: adc.w A, $02D1+X

    .skip_accumulate
    #_1A8337: #_0F69: mov.w $02D0+X, A
    #_1A833A: #_0F6C: call VolumeModulation_external
    #_1A833D: #_0F6F: bra .handle_pan_slide

    .tremelo_not_ready
    #_1A833F: #_0F71: inc.b $C0+X

    .no_tremelo
    #_1A8341: #_0F73: mov.b A, #$FF
    #_1A8343: #_0F75: call VolumeModulation_final_volume

    .handle_pan_slide
    #_1A8346: #_0F78: mov.b A, $91+X
    #_1A8348: #_0F7A: beq .no_pan_slide

    #_1A834A: #_0F7C: mov.b A, #$0330>>0
    #_1A834C: #_0F7E: mov.b Y, #$0330>>8
    #_1A834E: #_0F80: dec.b $91+X

    #_1A8350: #_0F82: call IncrementSlide

    .no_pan_slide
    #_1A8353: #_0F85: mov.b A, $47
    #_1A8355: #_0F87: and.b A, $5E
    #_1A8357: #_0F89: beq .exit

    #_1A8359: #_0F8B: mov.w A, $0331+X
    #_1A835C: #_0F8E: mov Y, A

    #_1A835D: #_0F8F: mov.w A, $0330+X
    #_1A8360: #_0F92: movw.b $10, YA

    ;===================================================================================================

    #WritePitch_external:
    #_1A8362: #_0F94: mov A, X
    #_1A8363: #_0F95: xcn A
    #_1A8364: #_0F96: lsr A
    #_1A8365: #_0F97: mov.b $12, A

    .vol_right
    #_1A8367: #_0F99: mov.b Y, $11
    #_1A8369: #_0F9B: mov.w A, LogisticFunc+1+Y
    #_1A836C: #_0F9E: setc
    #_1A836D: #_0F9F: sbc.w A, LogisticFunc+0+Y

    #_1A8370: #_0FA2: mov.b Y, $10
    #_1A8372: #_0FA4: mul YA

    #_1A8373: #_0FA5: mov A, Y
    #_1A8374: #_0FA6: mov.b Y, $11
    #_1A8376: #_0FA8: clrc
    #_1A8377: #_0FA9: adc.w A, LogisticFunc+0+Y
    #_1A837A: #_0FAC: mov Y, A

    #_1A837B: #_0FAD: mov.w A, $0321+X
    #_1A837E: #_0FB0: mul YA

    #_1A837F: #_0FB1: mov.w A, $0351+X
    #_1A8382: #_0FB4: asl A

    #_1A8383: #_0FB5: bbc0.b $12, .vol_left

    #_1A8386: #_0FB8: asl A

    .vol_left
    #_1A8387: #_0FB9: mov A, Y
    #_1A8388: #_0FBA: bcc .no_phase_inversion

    #_1A838A: #_0FBC: eor.b A, #$FF
    #_1A838C: #_0FBE: inc A

    .no_phase_inversion
    #_1A838D: #_0FBF: mov.b Y, $12
    #_1A838F: #_0FC1: call WriteToDSP_Checked

    #_1A8392: #_0FC4: mov.b Y, #$14
    #_1A8394: #_0FC6: mov.b A, #$00

    #_1A8396: #_0FC8: subw.b YA, $10
    #_1A8398: #_0FCA: movw.b $10, YA

    #_1A839A: #_0FCC: inc.b $12
    #_1A839C: #_0FCE: bbc1.b $12, .vol_right

    .exit
    #_1A839F: #_0FD1: ret

    ;===================================================================================================

    IncrementSlide:
    #_1A83A0: #_0FD2: or.b $5E, $47

    .quiet
    #_1A83A3: #_0FD5: movw.b $14, YA
    #_1A83A5: #_0FD7: movw.b $16, YA

    #_1A83A7: #_0FD9: push X
    #_1A83A8: #_0FDA: pop Y

    #_1A83A9: #_0FDB: clrc
    #_1A83AA: #_0FDC: bne .still_sliding

    #_1A83AC: #_0FDE: adc.b $16, #$1F

    #_1A83AF: #_0FE1: mov.b A, #$00
    #_1A83B1: #_0FE3: mov.b ($14)+Y, A

    #_1A83B3: #_0FE5: inc Y
    #_1A83B4: #_0FE6: bra .add

    .still_sliding
    #_1A83B6: #_0FE8: adc.b $16, #$10
    #_1A83B9: #_0FEB: call .add_slide_amount

    #_1A83BC: #_0FEE: inc Y

    .add_slide_amount
    #_1A83BD: #_0FEF: mov.b A, ($14)+Y

    .add
    #_1A83BF: #_0FF1: adc.b A, ($16)+Y
    #_1A83C1: #_0FF3: mov.b ($14)+Y, A

    #_1A83C3: #_0FF5: ret

    ;===================================================================================================

    Tracker:
    #_1A83C4: #_0FF6: mov.b A, $71+X
    #_1A83C6: #_0FF8: beq .time_left

    #_1A83C8: #_0FFA: dec.b $71+X
    #_1A83CA: #_0FFC: beq .times_up

    #_1A83CC: #_0FFE: mov.b A, #$02
    #_1A83CE: #_1000: cbne.b $70+X, .time_left

    .times_up
    #_1A83D1: #_1003: mov.b A, $80+X
    #_1A83D3: #_1005: mov.b $17, A

    #_1A83D5: #_1007: mov.b A, $30+X
    #_1A83D7: #_1009: mov.b Y, $31+X

    .load_pointer
    #_1A83D9: #_100B: movw.b $14, YA
    #_1A83DB: #_100D: mov.b Y, #$00

    .next_byte
    #_1A83DD: #_100F: mov.b A, ($14)+Y
    #_1A83DF: #_1011: beq .terminate_track
    #_1A83E1: #_1013: bmi .command

    .read_track_data
    #_1A83E3: #_1015: inc Y
    #_1A83E4: #_1016: bmi .call_loop_over

    #_1A83E6: #_1018: mov.b A, ($14)+Y
    #_1A83E8: #_101A: bpl .read_track_data

    .command
    #_1A83EA: #_101C: cmp.b A, #$C8 ; tie
    #_1A83EC: #_101E: beq .time_left

    #_1A83EE: #_1020: cmp.b A, #$EF ; call part
    #_1A83F0: #_1022: beq .call_loop_command

    #_1A83F2: #_1024: cmp.b A, #$E0 ; instrument change
    #_1A83F4: #_1026: bcc .call_loop_over

    #_1A83F6: #_1028: push Y
    #_1A83F7: #_1029: mov Y, A

    #_1A83F8: #_102A: pop A
    #_1A83F9: #_102B: adc.w A, TrackCommandParamCount-$E0+Y
    #_1A83FC: #_102E: mov Y, A

    #_1A83FD: #_102F: bra .next_byte

    ;---------------------------------------------------------------------------------------------------

    .terminate_track
    #_1A83FF: #_1031: mov.b A, $17
    #_1A8401: #_1033: beq .call_loop_over

    #_1A8403: #_1035: dec.b $17
    #_1A8405: #_1037: bne .call_loop_notdone

    #_1A8407: #_1039: mov.w A, $0231+X
    #_1A840A: #_103C: push A

    #_1A840B: #_103D: mov.w A, $0230+X
    #_1A840E: #_1040: pop Y

    #_1A840F: #_1041: bra .load_pointer

    .call_loop_notdone
    #_1A8411: #_1043: mov.w A, $0241+X
    #_1A8414: #_1046: push A

    #_1A8415: #_1047: mov.w A, $0240+X
    #_1A8418: #_104A: pop Y

    #_1A8419: #_104B: bra .load_pointer

    .call_loop_command
    #_1A841B: #_104D: inc Y
    #_1A841C: #_104E: mov.b A, ($14)+Y

    #_1A841E: #_1050: push A
    #_1A841F: #_1051: inc Y

    #_1A8420: #_1052: mov.b A, ($14)+Y

    #_1A8422: #_1054: mov Y, A
    #_1A8423: #_1055: pop A

    #_1A8424: #_1056: bra .load_pointer

    .call_loop_over
    #_1A8426: #_1058: mov.b A, $47
    #_1A8428: #_105A: mov.b Y, #KOFF
    #_1A842A: #_105C: call WriteToDSP_Checked

    .time_left
    #_1A842D: #_105F: clr7.b $13

    #_1A842F: #_1061: mov.b A, $A0+X
    #_1A8431: #_1063: beq .no_pitch_slide

    #_1A8433: #_1065: mov.b A, $A1+X
    #_1A8435: #_1067: beq .delay_finished

    #_1A8437: #_1069: dec.b $A1+X
    #_1A8439: #_106B: bra .no_pitch_slide

    .delay_finished
    #_1A843B: #_106D: mov.b A, $1A
    #_1A843D: #_106F: and.b A, $47
    #_1A843F: #_1071: bne .no_pitch_slide

    #_1A8441: #_1073: set7.b $13

    #_1A8443: #_1075: mov.b A, #$0360>>0
    #_1A8445: #_1077: mov.b Y, #$0360>>8

    #_1A8447: #_1079: dec.b $A0+X
    #_1A8449: #_107B: call IncrementSlide_quiet

    .no_pitch_slide
    #_1A844C: #_107E: call GetTempPitch

    #_1A844F: #_1081: mov.b A, $B1+X
    #_1A8451: #_1083: beq Tracker_no_vibrato

    #_1A8453: #_1085: mov.w A, $02B0+X
    #_1A8456: #_1088: cbne.b $B0+X, .set_point_wait

    #_1A8459: #_108B: mov.w A, $0100+X
    #_1A845C: #_108E: cmp.w A, $02B1+X
    #_1A845F: #_1091: bne .increment

    #_1A8461: #_1093: mov.w A, $02C1+X
    #_1A8464: #_1096: bra .set_intensity

    .increment
    #_1A8466: #_1098: setp
    #_1A8467: #_1099: inc.b $0100+X
    #_1A8469: #_109B: clrp

    #_1A846A: #_109C: mov Y, A
    #_1A846B: #_109D: beq .initializing

    #_1A846D: #_109F: mov.b A, $B1+X

    .initializing
    #_1A846F: #_10A1: clrc
    #_1A8470: #_10A2: adc.w A, $02C0+X

    .set_intensity
    #_1A8473: #_10A5: mov.b $B1+X, A
    #_1A8475: #_10A7: mov.w A, $02A0+X

    #_1A8478: #_10AA: clrc
    #_1A8479: #_10AB: adc.w A, $02A1+X
    #_1A847C: #_10AE: mov.w $02A0+X, A

    ;---------------------------------------------------------------------------------------------------

    #Tracker_handle_pitch:
    #_1A847F: #_10B1: mov.b $12, A
    #_1A8481: #_10B3: asl A
    #_1A8482: #_10B4: asl A
    #_1A8483: #_10B5: bcc .low_enough

    #_1A8485: #_10B7: eor.b A, #$FF

    .low_enough
    #_1A8487: #_10B9: mov Y, A

    #_1A8488: #_10BA: mov.b A, $B1+X
    #_1A848A: #_10BC: cmp.b A, #$F1
    #_1A848C: #_10BE: bcc .too_small

    #_1A848E: #_10C0: and.b A, #$0F
    #_1A8490: #_10C2: mul YA

    #_1A8491: #_10C3: bra .continue

    .too_small
    #_1A8493: #_10C5: mul YA
    #_1A8494: #_10C6: mov A, Y
    #_1A8495: #_10C7: mov.b Y, #$00

    .continue
    #_1A8497: #_10C9: call AdjustPitch

    .change_pitch
    #_1A849A: #_10CC: jmp HandleNote_external

    .set_point_wait
    #_1A849D: #_10CF: inc.b $B0+X

    ;---------------------------------------------------------------------------------------------------

    #Tracker_no_vibrato:
    #_1A849F: #_10D1: bbs7.b $13, .change_pitch

    #_1A84A2: #_10D4: ret

    ;===================================================================================================

    BackgroundTasks:
    #_1A84A3: #_10D5: clr7.b $13

    #_1A84A5: #_10D7: mov.b A, $C1+X
    #_1A84A7: #_10D9: beq .no_tremelo

    #_1A84A9: #_10DB: mov.w A, $02E0+X
    #_1A84AC: #_10DE: cbne.b $C0+X, .no_tremelo

    #_1A84AF: #_10E1: call VolumeModulation

    .no_tremelo
    #_1A84B2: #_10E4: mov.w A, $0331+X
    #_1A84B5: #_10E7: mov Y, A

    #_1A84B6: #_10E8: mov.w A, $0330+X
    #_1A84B9: #_10EB: movw.b $10, YA

    #_1A84BB: #_10ED: mov.b A, $91+X
    #_1A84BD: #_10EF: beq .no_pan_slide

    #_1A84BF: #_10F1: mov.w A, $0341+X
    #_1A84C2: #_10F4: mov Y, A

    #_1A84C3: #_10F5: mov.w A, $0340+X
    #_1A84C6: #_10F8: call AdjustPitchByFrames

    .no_pan_slide
    #_1A84C9: #_10FB: bbc7.b $13, .pitch_unchanged

    #_1A84CC: #_10FE: call WritePitch_external

    .pitch_unchanged
    #_1A84CF: #_1101: clr7.b $13

    #_1A84D1: #_1103: call GetTempPitch

    #_1A84D4: #_1106: mov.b A, $A0+X
    #_1A84D6: #_1108: beq .no_pitch_slide

    #_1A84D8: #_110A: mov.b A, $A1+X
    #_1A84DA: #_110C: bne .no_pitch_slide

    #_1A84DC: #_110E: mov.w A, $0371+X
    #_1A84DF: #_1111: mov Y, A

    #_1A84E0: #_1112: mov.w A, $0370+X
    #_1A84E3: #_1115: call AdjustPitchByFrames

    .no_pitch_slide
    #_1A84E6: #_1118: mov.b A, $B1+X
    #_1A84E8: #_111A: beq Tracker_no_vibrato

    #_1A84EA: #_111C: mov.w A, $02B0+X
    #_1A84ED: #_111F: cbne.b $B0+X, Tracker_no_vibrato

    #_1A84F0: #_1122: mov.b Y, $51
    #_1A84F2: #_1124: mov.w A, $02A1+X

    #_1A84F5: #_1127: mul YA
    #_1A84F6: #_1128: mov A, Y
    #_1A84F7: #_1129: clrc
    #_1A84F8: #_112A: adc.w A, $02A0+X

    #_1A84FB: #_112D: jmp Tracker_handle_pitch

    ;===================================================================================================

    AdjustPitchByFrames:
    #_1A84FE: #_1130: set7.b $13

    #_1A8500: #_1132: mov.b $12, Y
    #_1A8502: #_1134: call MakeFraction_abs

    #_1A8505: #_1137: push Y

    #_1A8506: #_1138: mov.b Y, $51
    #_1A8508: #_113A: mul YA
    #_1A8509: #_113B: mov.b $14, Y
    #_1A850B: #_113D: mov.b $15, #$00

    #_1A850E: #_1140: mov.b Y, $51

    #_1A8510: #_1142: pop A
    #_1A8511: #_1143: mul YA
    #_1A8512: #_1144: addw.b YA, $14

    ;===================================================================================================

    AdjustPitch:
    #_1A8514: #_1146: call MakeFraction_abs

    #_1A8517: #_1149: addw.b YA, $10
    #_1A8519: #_114B: movw.b $10, YA

    #_1A851B: #_114D: ret

    ;===================================================================================================

    VolumeModulation:
    #_1A851C: #_114E: set7.b $13

    #_1A851E: #_1150: mov.b Y, $51
    #_1A8520: #_1152: mov.w A, $02D1+X

    #_1A8523: #_1155: mul YA
    #_1A8524: #_1156: mov A, Y
    #_1A8525: #_1157: clrc
    #_1A8526: #_1158: adc.w A, $02D0+X

    ;===================================================================================================

    #VolumeModulation_external:
    #_1A8529: #_115B: asl A
    #_1A852A: #_115C: bcc .no_phase_invert

    #_1A852C: #_115E: eor.b A, #$FF

    .no_phase_invert
    #_1A852E: #_1160: mov.b Y, $C1+X
    #_1A8530: #_1162: mul YA
    #_1A8531: #_1163: mov A, Y
    #_1A8532: #_1164: eor.b A, #$FF

    .final_volume
    #_1A8534: #_1166: mov.b Y, $59
    #_1A8536: #_1168: mul YA

    #_1A8537: #_1169: mov.w A, $0210+X
    #_1A853A: #_116C: mul YA

    #_1A853B: #_116D: mov.w A, $0301+X
    #_1A853E: #_1170: mul YA

    #_1A853F: #_1171: mov A, Y
    #_1A8540: #_1172: mul YA

    #_1A8541: #_1173: mov A, Y
    #_1A8542: #_1174: mov.w $0321+X, A

    #_1A8545: #_1177: ret

    ;===================================================================================================

    LogisticFunc:
    #_1A8546: #_1178: db $00, $01, $03, $07, $0D, $15, $1E, $29
    #_1A854E: #_1180: db $34, $42, $51, $5E, $67, $6E, $73, $77
    #_1A8556: #_1188: db $7A, $7C, $7D, $7E, $7F

    ;===================================================================================================
    ; Contains values for each of the 8 bytes of filter
    ;===================================================================================================
    EchoFilterParameters:
    #_1A855B: #_118D: db $7F, $00, $00, $00, $00, $00, $00, $00
    #_1A8563: #_1195: db $58, $BF, $DB, $F0, $FE, $07, $0C, $0C
    #_1A856B: #_119D: db $0C, $21, $2B, $2B, $13, $FE, $F3, $F9
    #_1A8573: #_11A5: db $34, $33, $00, $D9, $E5, $01, $FC, $EB

    ;===================================================================================================

    RegisterList:
    #_1A857B: #_11AD: db EVOLL
    #_1A857C: #_11AE: db EVOLR
    #_1A857D: #_11AF: db EFB
    #_1A857E: #_11B0: db EON
    #_1A857F: #_11B1: db FLG
    #_1A8580: #_11B2: db KON
    #_1A8581: #_11B3: db KOFF
    #_1A8582: #_11B4: db NON
    #_1A8583: #_11B5: db PMON
    #_1A8584: #_11B6: db KOFF

    ;===================================================================================================

    LoadValueFrom:
    #_1A8585: #_11B7: db $61 ; EVOLL
    #_1A8586: #_11B8: db $63 ; EVOLR
    #_1A8587: #_11B9: db $4E ; EFB
    #_1A8588: #_11BA: db $4A ; EON
    #_1A8589: #_11BB: db $48 ; FLG
    #_1A858A: #_11BC: db $45 ; KON
    #_1A858B: #_11BD: db $0E ; KOFF
    #_1A858C: #_11BE: db $49 ; NON
    #_1A858D: #_11BF: db $4B ; PMON
    #_1A858E: #_11C0: db $46 ; KOFF

    ;===================================================================================================

    TuningValues:
    #_1A858F: #_11C1: dw $085F
    #_1A8591: #_11C3: dw $08DE
    #_1A8593: #_11C5: dw $0965
    #_1A8595: #_11C7: dw $09F4
    #_1A8597: #_11C9: dw $0A8C
    #_1A8599: #_11CB: dw $0B2C
    #_1A859B: #_11CD: dw $0BD6
    #_1A859D: #_11CF: dw $0C8B
    #_1A859F: #_11D1: dw $0D4A
    #_1A85A1: #_11D3: dw $0E14
    #_1A85A3: #_11D5: dw $0EEA
    #_1A85A5: #_11D7: dw $0FCD
    #_1A85A7: #_11D9: dw $10BE

    ;===================================================================================================

    UNREACHABLE_11DB:
    #_1A85A9: #_11DB: db $2A
    #_1A85AA: #_11DC: db $56
    #_1A85AB: #_11DD: db $65
    #_1A85AC: #_11DE: db $72
    #_1A85AD: #_11DF: db $20
    #_1A85AE: #_11E0: db $53
    #_1A85AF: #_11E1: db $31
    #_1A85B0: #_11E2: db $2E
    #_1A85B1: #_11E3: db $32
    #_1A85B2: #_11E4: db $30
    #_1A85B3: #_11E5: db $2A

    ;===================================================================================================

    Data_Loader:
    #_1A85B4: #_11E6: mov.b A, #$AA
    #_1A85B6: #_11E8: mov.w CPUIO0, A

    #_1A85B9: #_11EB: mov.b A, #$BB
    #_1A85BB: #_11ED: mov.w CPUIO1, A

    .wait_data_start
    #_1A85BE: #_11F0: mov.w A, CPUIO0
    #_1A85C1: #_11F3: cmp.b A, #$CC
    #_1A85C3: #_11F5: bne .wait_data_start
    #_1A85C5: #_11F7: bra .begin_transfer

    .loop
    #_1A85C7: #_11F9: mov.w Y, CPUIO0
    #_1A85CA: #_11FC: bne .loop

    .reread
    #_1A85CC: #_11FE: cmp.w Y, CPUIO0
    #_1A85CF: #_1201: bne .coherence_error

    #_1A85D1: #_1203: mov.w A, CPUIO1
    #_1A85D4: #_1206: mov.w CPUIO0, Y
    #_1A85D7: #_1209: mov.b ($14)+Y, A

    #_1A85D9: #_120B: inc Y
    #_1A85DA: #_120C: bne .reread

    #_1A85DC: #_120E: inc.b $15
    #_1A85DE: #_1210: bra .reread

    .coherence_error
    #_1A85E0: #_1212: bpl .reread

    #_1A85E2: #_1214: cmp.w Y, CPUIO0
    #_1A85E5: #_1217: bpl .reread

    .begin_transfer
    #_1A85E7: #_1219: mov.w A, CPUIO2
    #_1A85EA: #_121C: mov.w Y, CPUIO3
    #_1A85ED: #_121F: movw.b $14, YA

    #_1A85EF: #_1221: mov.w Y, CPUIO0
    #_1A85F2: #_1224: mov.w A, CPUIO1
    #_1A85F5: #_1227: mov.w CPUIO0, Y
    #_1A85F8: #_122A: bne .loop

    ; clear ports 0123, start timer 0
    #_1A85FA: #_122C: mov.b X, #$31
    #_1A85FC: #_122E: mov.w CONTROL, X

    #_1A85FF: #_1231: ret

    ;===================================================================================================

    SFX2_HandleEcho:
    #_1A8600: #_1232: mov.b A, $02
    #_1A8602: #_1234: and.b A, #$3F
    #_1A8604: #_1236: mov X, A

    #_1A8605: #_1237: mov.w A, SFX2_Echo-1+X
    #_1A8608: #_123A: mov.w $03E2, A

    #_1A860B: #_123D: mov.b Y, #$0E
    #_1A860D: #_123F: mov.b X, #$80
    #_1A860F: #_1241: mov.w $03C1, X

    .loop_back
    #_1A8612: #_1244: mov.w A, $03CB
    #_1A8615: #_1247: and.w A, $03C1
    #_1A8618: #_124A: beq .SFX2_next_slot

    #_1A861A: #_124C: clrc
    #_1A861B: #_124D: mov.w A, $03A0+Y
    #_1A861E: #_1250: adc.w A, $03D0+Y

    #_1A8621: #_1253: cmp.b A, $02
    #_1A8623: #_1255: beq SFX3_HandleEcho_match

    .SFX2_next_slot
    #_1A8625: #_1257: dec Y
    #_1A8626: #_1258: dec Y

    #_1A8627: #_1259: lsr.w $03C1
    #_1A862A: #_125C: bne .loop_back

    #_1A862C: #_125E: bra SFX3_HandleEcho_no_slot

    ;===================================================================================================

    SFX3_HandleEcho:
    #_1A862E: #_1260: mov.b A, $03
    #_1A8630: #_1262: and.b A, #$3F
    #_1A8632: #_1264: mov X, A

    #_1A8633: #_1265: mov.w A, SFX3_Echo-1+X
    #_1A8636: #_1268: mov.w $03E2, A

    #_1A8639: #_126B: mov.b Y, #$0E
    #_1A863B: #_126D: mov.b X, #$80
    #_1A863D: #_126F: mov.w $03C1, X

    .SFX3_loop_point
    #_1A8640: #_1272: mov.w A, $03CD
    #_1A8643: #_1275: and.w A, $03C1
    #_1A8646: #_1278: beq .SFX3_next_slot

    #_1A8648: #_127A: clrc
    #_1A8649: #_127B: mov.w A, $03A0+Y
    #_1A864C: #_127E: adc.w A, $03D0+Y

    #_1A864F: #_1281: cmp.b A, $03
    #_1A8651: #_1283: beq .match

    .SFX3_next_slot
    #_1A8653: #_1285: dec Y
    #_1A8654: #_1286: dec Y

    #_1A8655: #_1287: lsr.w $03C1
    #_1A8658: #_128A: bne .SFX3_loop_point
    #_1A865A: #_128C: bra .no_slot

    .match
    #_1A865C: #_128E: mov.w $03C0, Y
    #_1A865F: #_1291: bra .enabled

    .no_slot
    #_1A8661: #_1293: clrc
    #_1A8662: #_1294: mov.b X, #$1A

    #_1A8664: #_1296: mov.b A, #$80
    #_1A8666: #_1298: mov.w $03C1, A

    #_1A8669: #_129B: mov.b Y, #$0E

    .loop_back_2
    #_1A866B: #_129D: and A, (X)
    #_1A866C: #_129E: beq .enabled

    #_1A866E: #_12A0: dec Y
    #_1A866F: #_12A1: dec Y

    #_1A8670: #_12A2: lsr.w $03C1
    #_1A8673: #_12A5: lsr A
    #_1A8674: #_12A6: bcc .loop_back_2

    .enabled
    #_1A8676: #_12A8: mov.w $03C0, Y
    #_1A8679: #_12AB: mov.w $03C8, Y

    #_1A867C: #_12AE: mov.w A, $03C1
    #_1A867F: #_12B1: mov.w $03C9, A

    #_1A8682: #_12B4: or.b A, $1A
    #_1A8684: #_12B6: mov.b $1A, A

    #_1A8686: #_12B8: mov.w X, $03E2
    #_1A8689: #_12BB: beq .disabled

    #_1A868B: #_12BD: or.w A, $03E3
    #_1A868E: #_12C0: mov.w $03E3, A

    .disabled
    #_1A8691: #_12C3: mov.w A, $0004
    #_1A8694: #_12C6: and.b A, #$10
    #_1A8696: #_12C8: beq .lower_bank

    #_1A8698: #_12CA: mov.w A, $03C1
    #_1A869B: #_12CD: and.w A, $03E3
    #_1A869E: #_12D0: beq .echo_off

    .lower_bank
    #_1A86A0: #_12D2: mov.w A, $03C1
    #_1A86A3: #_12D5: and.b A, $4A
    #_1A86A5: #_12D7: beq .echo_off

    #_1A86A7: #_12D9: mov.b A, $4A
    #_1A86A9: #_12DB: setc
    #_1A86AA: #_12DC: sbc.w A, $03C1
    #_1A86AD: #_12DF: mov.b $4A, A

    #_1A86AF: #_12E1: mov.b Y, #EON
    #_1A86B1: #_12E3: call WriteToDSP

    .echo_off
    #_1A86B4: #_12E6: ret

    ;===================================================================================================

    Unused_Function:
    #_1A86B5: #_12E7: mov.w X, $03C4
    #_1A86B8: #_12EA: mov.w $03C0, X

    #_1A86BB: #_12ED: mov.w Y, $03C5
    #_1A86BE: #_12F0: mov.w $03C1, Y

    #_1A86C1: #_12F3: mov.w A, $03C1
    #_1A86C4: #_12F6: mov.b Y, #KOFF
    #_1A86C6: #_12F8: call WriteToDSP

    #_1A86C9: #_12FB: call ResumeMusic

    #_1A86CC: #_12FE: ret

    ;===================================================================================================

    InitSFX1:
    #_1A86CD: #_12FF: mov.b $05, A
    #_1A86CF: #_1301: cmp.b A, #$05
    #_1A86D1: #_1303: bne .initialize

    #_1A86D3: #_1305: mov.w X, $03CF
    #_1A86D6: #_1308: bne .initialize

    #_1A86D8: #_130A: ret

    .initialize
    #_1A86D9: #_130B: mov.b X, #$00
    #_1A86DB: #_130D: mov.w $03E4, X

    #_1A86DE: #_1310: mov.b X, #$0E

    #_1A86E0: #_1312: mov.b A, $01
    #_1A86E2: #_1314: mov.w $03A0+X, A

    #_1A86E5: #_1317: mov.b A, #$03
    #_1A86E7: #_1319: mov.w $03A1+X, A

    #_1A86EA: #_131C: mov.b A, #$00
    #_1A86EC: #_131E: mov.w $0280+X, A

    #_1A86EF: #_1321: mov.b A, #$80
    #_1A86F1: #_1323: mov.w $03CF, A

    #_1A86F4: #_1326: mov.b Y, #KOFF
    #_1A86F6: #_1328: call WriteToDSP

    #_1A86F9: #_132B: set7.b $1A

    #_1A86FB: #_132D: mov.b X, $01
    #_1A86FD: #_132F: mov.w A, SFX1_Accomp-1+X

    #_1A8700: #_1332: mov.b $01, A
    #_1A8702: #_1334: bne .also_use_chan_6

    #_1A8704: #_1336: ret

    .also_use_chan_6
    #_1A8705: #_1337: mov.b X, #$0C

    #_1A8707: #_1339: mov.b A, $01
    #_1A8709: #_133B: mov.w $03A0+X, A

    #_1A870C: #_133E: mov.b A, #$03
    #_1A870E: #_1340: mov.w $03A1+X, A

    #_1A8711: #_1343: mov.b A, #$00
    #_1A8713: #_1345: mov.w $0280+X, A

    #_1A8716: #_1348: set6.b $1A

    #_1A8718: #_134A: mov.b A, #$40
    #_1A871A: #_134C: mov.b Y, #KOFF
    #_1A871C: #_134E: call WriteToDSP

    #_1A871F: #_1351: mov.b A, #$C0
    #_1A8721: #_1353: mov.w $03CF, A

    #_1A8724: #_1356: or.w A, $03E3
    #_1A8727: #_1359: mov.w $03E3, A

    #_1A872A: #_135C: mov.b A, #$3F
    #_1A872C: #_135E: and.w A, $03CB
    #_1A872F: #_1361: mov.w $03CB, A

    #_1A8732: #_1364: mov.b A, #$3F
    #_1A8734: #_1366: and.w A, $03CD
    #_1A8737: #_1369: mov.w $03CD, A

    #_1A873A: #_136C: ret

    ;===================================================================================================

    HandleInput_SFX1:
    #_1A873B: #_136D: mov.b A, $01
    #_1A873D: #_136F: bmi .SFX1_negative

    #_1A873F: #_1371: bne InitSFX1

    #_1A8741: #_1373: ret

    .SFX1_negative
    #_1A8742: #_1374: mov.b $05, A

    #_1A8744: #_1376: mov.w A, $03CF
    #_1A8747: #_1379: beq .channels_not_used

    #_1A8749: #_137B: mov.b A, #$78
    #_1A874B: #_137D: mov.w $03E4, A

    .channels_not_used
    #_1A874E: #_1380: ret

    ;===================================================================================================

    SFX1_FadeHandler:
    #_1A874F: #_1381: dec.w $03E4

    #_1A8752: #_1384: mov.w A, $03E4
    #_1A8755: #_1387: bne .still_fading

    #_1A8757: #_1389: mov.b A, #$05
    #_1A8759: #_138B: mov.b $01, A
    #_1A875B: #_138D: call InitSFX1_initialize

    #_1A875E: #_1390: mov.b A, #$00
    #_1A8760: #_1392: mov.b $01, A

    #_1A8762: #_1394: ret

    .still_fading
    #_1A8763: #_1395: lsr A
    #_1A8764: #_1396: mov.w $03E5, A
    #_1A8767: #_1399: mov.b Y, #V7VOLL
    #_1A8769: #_139B: call WriteToDSP

    #_1A876C: #_139E: inc Y ; V7VOLR
    #_1A876D: #_139F: mov.w A, $03E5
    #_1A8770: #_13A2: call WriteToDSP

    #_1A8773: #_13A5: mov.b Y, #V6VOLL
    #_1A8775: #_13A7: mov.w A, $03E5
    #_1A8778: #_13AA: call WriteToDSP

    #_1A877B: #_13AD: inc Y ; V6VOLR
    #_1A877C: #_13AE: mov.w A, $03E5
    #_1A877F: #_13B1: call WriteToDSP

    #_1A8782: #_13B4: jmp Handle_SFX1_no_fadeout

    ;===================================================================================================

    HandleInput_SFX2:
    #_1A8785: #_13B7: mov.b A, $02
    #_1A8787: #_13B9: bne HandleValidSFX2

    #_1A8789: #_13BB: ret

    ;===================================================================================================

    HandleInput_SFX3:
    #_1A878A: #_13BC: mov.b A, $03
    #_1A878C: #_13BE: bne .valid

    #_1A878E: #_13C0: ret

    .valid
    #_1A878F: #_13C1: mov.b A, #$FF
    #_1A8791: #_13C3: cbne.b $1A, .not_all_muted
    #_1A8794: #_13C6: bra .exit

    .not_all_muted
    #_1A8796: #_13C8: call SFX3_HandleEcho

    #_1A8799: #_13CB: mov.w X, $03C0

    #_1A879C: #_13CE: mov.b A, $03
    #_1A879E: #_13D0: and.b A, #$C0
    #_1A87A0: #_13D2: mov.w $03D0+X, A

    #_1A87A3: #_13D5: mov.b A, $03
    #_1A87A5: #_13D7: and.b A, #$3F
    #_1A87A7: #_13D9: mov.w $03A0+X, A

    #_1A87AA: #_13DC: mov.b A, #$03
    #_1A87AC: #_13DE: mov.w $03A1+X, A

    #_1A87AF: #_13E1: mov.b A, #$00
    #_1A87B1: #_13E3: mov.w $0280+X, A

    #_1A87B4: #_13E6: mov.w A, $03C1
    #_1A87B7: #_13E9: or.w A, $03CD
    #_1A87BA: #_13EC: mov.w $03CD, A

    #_1A87BD: #_13EF: mov.w A, $03C1
    #_1A87C0: #_13F2: mov.b Y, #KOFF
    #_1A87C2: #_13F4: call WriteToDSP

    #_1A87C5: #_13F7: mov.w A, $03A0+X
    #_1A87C8: #_13FA: mov X, A

    #_1A87C9: #_13FB: mov.w A, SFX3_Accomp-1+X
    #_1A87CC: #_13FE: mov.b $03, A
    #_1A87CE: #_1400: bne .valid

    .exit
    #_1A87D0: #_1402: ret

    ;===================================================================================================

    HandleValidSFX2:
    #_1A87D1: #_1403: mov.b A, #$FF
    #_1A87D3: #_1405: cbne.b $1A, .not_all_muted

    #_1A87D6: #_1408: bra .exit

    .not_all_muted
    #_1A87D8: #_140A: call SFX2_HandleEcho

    #_1A87DB: #_140D: mov.w X, $03C0

    #_1A87DE: #_1410: mov.b A, $02
    #_1A87E0: #_1412: and.b A, #$3F
    #_1A87E2: #_1414: mov.w $03A0+X, A

    #_1A87E5: #_1417: mov.b A, $02
    #_1A87E7: #_1419: and.b A, #$C0
    #_1A87E9: #_141B: mov.w $03D0+X, A

    #_1A87EC: #_141E: mov.b A, #$03
    #_1A87EE: #_1420: mov.w $03A1+X, A

    #_1A87F1: #_1423: mov.b A, #$00
    #_1A87F3: #_1425: mov.w $0280+X, A

    #_1A87F6: #_1428: mov.w A, $03C1
    #_1A87F9: #_142B: or.w A, $03CB
    #_1A87FC: #_142E: mov.w $03CB, A

    #_1A87FF: #_1431: mov.w A, $03C1
    #_1A8802: #_1434: mov.b Y, #KOFF
    #_1A8804: #_1436: call WriteToDSP

    #_1A8807: #_1439: mov.w A, $03A0+X
    #_1A880A: #_143C: mov X, A

    #_1A880B: #_143D: mov.w A, SFX2_Accomp-1+X
    #_1A880E: #_1440: mov.b $02, A

    #_1A8810: #_1442: bne HandleValidSFX2

    .exit
    #_1A8812: #_1444: ret

    ;===================================================================================================

    ; SPC $1445-$14AC JUMP LOCATION
    ; $0D0813-$0D087A DATA
    Handle_SFX1:
    {
        mov.w A, $03E4 : beq .no_fadeout
            jmp SFX1_FadeHandler

        .no_fadeout

        mov.w A, $03CF : mov.w $03E0, A
                         beq .exit
            mov.b X, #$0E

            mov.b A, #$80 : mov.w $03C1, A

            .next_channel

                asl.w $03E0 : bcc .to_next_channel
                    mov.w $03C0, X
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    mov.w A, $03D0+X : mov.b $20, A

                    mov.w A, $03A1+X : bne .delayed
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                .to_next_channel

                lsr.w $03C1

                dec X : dec X
            cmp.b X, #$0A : bpl .next_channel

        .exit

        ret

        .delayed

        mov.w $03C0, X

        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .initialize
            jmp .to_next_channel

        .initialize

        mov.w A, $03A0+X : asl A : mov Y, A
        mov.w A, SFX1_Pointers-1+Y : mov.w $0391+X, A
                                     mov.b $2D, A

        mov.w A, SFX1_Pointers-2+Y : mov.w $0390+X, A
                                     mov.b $2C, A

        jmp SFXControl_process_byte
    }

    ;===================================================================================================

    Handle_SFX2:
    #_1A887B: #_14AD: mov.w A, $03CB
    #_1A887E: #_14B0: mov.w $03CC, A
    #_1A8881: #_14B3: beq .exit

    #_1A8883: #_14B5: mov.b X, #$0E
    #_1A8885: #_14B7: mov.b A, #$80
    #_1A8887: #_14B9: mov.w $03C1, A

    .next_channel
    #_1A888A: #_14BC: asl.w $03CC
    #_1A888D: #_14BF: bcc .to_next_channel

    #_1A888F: #_14C1: mov.w $03C0, X
    #_1A8892: #_14C4: mov A, X
    #_1A8893: #_14C5: xcn A
    #_1A8894: #_14C6: lsr A
    #_1A8895: #_14C7: mov.w $03C2, A

    #_1A8898: #_14CA: mov.w A, $03D0+X
    #_1A889B: #_14CD: mov.b $20, A

    #_1A889D: #_14CF: mov.w A, $03A1+X
    #_1A88A0: #_14D2: bne .delayed

    #_1A88A2: #_14D4: mov.w A, $03A0+X
    #_1A88A5: #_14D7: beq .to_next_channel

    #_1A88A7: #_14D9: jmp SFXControl

    .to_next_channel
    #_1A88AA: #_14DC: lsr.w $03C1
    #_1A88AD: #_14DF: dec X
    #_1A88AE: #_14E0: dec X
    #_1A88AF: #_14E1: bpl .next_channel

    .exit
    #_1A88B1: #_14E3: ret

    ;---------------------------------------------------------------------------------------------------

    .delayed
    #_1A88B2: #_14E4: mov.w $03C0, X

    #_1A88B5: #_14E7: mov.w A, $03A1+X
    #_1A88B8: #_14EA: dec A
    #_1A88B9: #_14EB: mov.w $03A1+X, A
    #_1A88BC: #_14EE: beq .initialize

    #_1A88BE: #_14F0: jmp .to_next_channel

    .initialize
    #_1A88C1: #_14F3: mov.w A, $03A0+X
    #_1A88C4: #_14F6: asl A
    #_1A88C5: #_14F7: mov Y, A

    #_1A88C6: #_14F8: mov.w A, SFX2_Pointers-1+Y
    #_1A88C9: #_14FB: mov.w $0391+X, A
    #_1A88CC: #_14FE: mov.b $2D, A

    #_1A88CE: #_1500: mov.w A, SFX2_Pointers-2+Y
    #_1A88D1: #_1503: mov.w $0390+X, A
    #_1A88D4: #_1506: mov.b $2C, A

    #_1A88D6: #_1508: jmp SFXControl_process_byte

    ;===================================================================================================

    Handle_SFX3:
    #_1A88D9: #_150B: mov.w A, $03CD
    #_1A88DC: #_150E: mov.w $03CE, A
    #_1A88DF: #_1511: beq .exit

    #_1A88E1: #_1513: mov.b X, #$0E
    #_1A88E3: #_1515: mov.b A, #$80
    #_1A88E5: #_1517: mov.w $03C1, A

    .next_channel
    #_1A88E8: #_151A: asl.w $03CE
    #_1A88EB: #_151D: bcc .to_next_channel

    #_1A88ED: #_151F: mov.w $03C0, X
    #_1A88F0: #_1522: mov A, X
    #_1A88F1: #_1523: xcn A
    #_1A88F2: #_1524: lsr A
    #_1A88F3: #_1525: mov.w $03C2, A

    #_1A88F6: #_1528: mov.w A, $03D0+X
    #_1A88F9: #_152B: mov.b $20, A

    #_1A88FB: #_152D: mov.w A, $03A1+X
    #_1A88FE: #_1530: bne .delayed

    #_1A8900: #_1532: mov.w A, $03A0+X
    #_1A8903: #_1535: beq .to_next_channel

    #_1A8905: #_1537: jmp SFXControl

    .to_next_channel
    #_1A8908: #_153A: lsr.w $03C1
    #_1A890B: #_153D: dec X
    #_1A890C: #_153E: dec X
    #_1A890D: #_153F: bpl .next_channel

    .exit
    #_1A890F: #_1541: ret

    ;---------------------------------------------------------------------------------------------------

    .delayed
    #_1A8910: #_1542: mov.w $03C0, X

    #_1A8913: #_1545: mov.w A, $03A1+X
    #_1A8916: #_1548: dec A
    #_1A8917: #_1549: mov.w $03A1+X, A

    #_1A891A: #_154C: beq .initialize

    #_1A891C: #_154E: jmp .to_next_channel

    .initialize
    #_1A891F: #_1551: mov.w A, $03A0+X
    #_1A8922: #_1554: asl A
    #_1A8923: #_1555: mov Y, A

    #_1A8924: #_1556: mov.w A, SFX3_Pointers-1+Y
    #_1A8927: #_1559: mov.w $0391+X, A
    #_1A892A: #_155C: mov.b $2D, A

    #_1A892C: #_155E: mov.w A, SFX3_Pointers-2+Y
    #_1A892F: #_1561: mov.w $0390+X, A
    #_1A8932: #_1564: mov.b $2C, A

    #_1A8934: #_1566: jmp SFXControl_process_byte

    ;===================================================================================================

    ResumeMusic:
    #_1A8937: #_1569: mov.b A, #$00
    #_1A8939: #_156B: mov.w X, $03C0
    #_1A893C: #_156E: mov.w $03A0+X, A

    #_1A893F: #_1571: mov.b A, $1A
    #_1A8941: #_1573: setc
    #_1A8942: #_1574: sbc.w A, $03C1
    #_1A8945: #_1577: mov.b $1A, A

    #_1A8947: #_1579: mov.w A, $03C1
    #_1A894A: #_157C: and.w A, $03CB
    #_1A894D: #_157F: beq .not_on_SFX_2

    #_1A894F: #_1581: mov.w A, $03CB
    #_1A8952: #_1584: setc
    #_1A8953: #_1585: sbc.w A, $03C1
    #_1A8956: #_1588: mov.w $03CB, A

    #_1A8959: #_158B: bra .resume

    .not_on_SFX_2
    #_1A895B: #_158D: mov.w A, $03C1
    #_1A895E: #_1590: and.w A, $03CD
    #_1A8961: #_1593: beq .not_on_SFX_3

    #_1A8963: #_1595: mov.w A, $03CD
    #_1A8966: #_1598: setc
    #_1A8967: #_1599: sbc.w A, $03C1
    #_1A896A: #_159C: mov.w $03CD, A

    #_1A896D: #_159F: bra .resume

    .not_on_SFX_3
    #_1A896F: #_15A1: mov.w A, $03CF
    #_1A8972: #_15A4: setc
    #_1A8973: #_15A5: sbc.w A, $03C1
    #_1A8976: #_15A8: mov.w $03CF, A

    .resume
    #_1A8979: #_15AB: mov.b $44, X
    #_1A897B: #_15AD: mov.w A, $0211+X
    #_1A897E: #_15B0: call TrackCommand_E0_ChangeInstrument

    #_1A8981: #_15B3: mov.w A, $03C1
    #_1A8984: #_15B6: and.w A, $03C3
    #_1A8987: #_15B9: beq .exit

    #_1A8989: #_15BB: and.b A, $4A
    #_1A898B: #_15BD: bne .exit

    #_1A898D: #_15BF: mov.b A, $4A
    #_1A898F: #_15C1: clrc
    #_1A8990: #_15C2: adc.w A, $03C1
    #_1A8993: #_15C5: mov.b $4A, A

    #_1A8995: #_15C7: mov.b Y, #EON
    #_1A8997: #_15C9: call WriteToDSP

    #_1A899A: #_15CC: mov.w A, $03E3
    #_1A899D: #_15CF: setc
    #_1A899E: #_15D0: sbc.w A, $03C1
    #_1A89A1: #_15D3: mov.w $03E3, A

    .exit
    #_1A89A4: #_15D6: mov.w X, $03C0

    #_1A89A7: #_15D9: ret

    ;===================================================================================================

    DisableSFX:
    #_1A89A8: #_15DA: mov.w A, $03C1
    #_1A89AB: #_15DD: and.w A, $03CF
    #_1A89AE: #_15E0: bne .used_by_SFX_1

    #_1A89B0: #_15E2: mov.w A, $03C1
    #_1A89B3: #_15E5: and.w A, $03CB
    #_1A89B6: #_15E8: bne .used_by_SFX_2

    #_1A89B8: #_15EA: call ResumeMusic
    #_1A89BB: #_15ED: jmp Handle_SFX3_to_next_channel

    .used_by_SFX_1
    #_1A89BE: #_15F0: call ResumeMusic
    #_1A89C1: #_15F3: jmp Handle_SFX1_to_next_channel

    .used_by_SFX_2
    #_1A89C4: #_15F6: call ResumeMusic
    #_1A89C7: #_15F9: jmp Handle_SFX2_to_next_channel

    ;===================================================================================================

    SFXControl:
    #_1A89CA: #_15FC: call SFX3_HandleEcho_disabled

    #_1A89CD: #_15FF: mov.w $03C0, X
    #_1A89D0: #_1602: mov.w A, $0391+X
    #_1A89D3: #_1605: mov Y, A

    #_1A89D4: #_1606: mov.w A, $0390+X
    #_1A89D7: #_1609: movw.b $2C, YA

    #_1A89D9: #_160B: mov.w A, $03B0+X
    #_1A89DC: #_160E: dec A
    #_1A89DD: #_160F: mov.w $03B0+X, A

    #_1A89E0: #_1612: beq .next_byte
    #_1A89E2: #_1614: jmp .do_pitch_slide

    .next_byte
    #_1A89E5: #_1617: incw.b $2C

    .process_byte
    #_1A89E7: #_1619: mov.w A, $03C0
    #_1A89EA: #_161C: xcn A
    #_1A89EB: #_161D: lsr A
    #_1A89EC: #_161E: mov.w $03C2, A

    #_1A89EF: #_1621: mov.b X, #$00
    #_1A89F1: #_1623: mov.b A, ($2C+X)

    #_1A89F3: #_1625: beq DisableSFX
    #_1A89F5: #_1627: bmi .note_or_command

    #_1A89F7: #_1629: mov.w Y, $03C0
    #_1A89FA: #_162C: mov.w $03B1+Y, A

    #_1A89FD: #_162F: incw.b $2C
    #_1A89FF: #_1631: mov.b A, ($2C+X)
    #_1A8A01: #_1633: mov.b $10, A
    #_1A8A03: #_1635: bmi .note_or_command

    #_1A8A05: #_1637: mov X, A
    #_1A8A06: #_1638: mov.w A, $03C1
    #_1A8A09: #_163B: and.w A, $03CF
    #_1A8A0C: #_163E: beq .not_SFX_1

    #_1A8A0E: #_1640: mov A, X
    #_1A8A0F: #_1641: beq .zero_byte

    #_1A8A11: #_1643: mov.w X, $03E5
    #_1A8A14: #_1646: bne .next_byte_2

    .zero_byte
    #_1A8A16: #_1648: mov.b $10, A
    #_1A8A18: #_164A: mov.w Y, $03C2
    #_1A8A1B: #_164D: call WriteToDSP

    #_1A8A1E: #_1650: mov.b X, #$00
    #_1A8A20: #_1652: incw.b $2C
    #_1A8A22: #_1654: mov.b A, ($2C+X)
    #_1A8A24: #_1656: bpl .volume_command

    #_1A8A26: #_1658: mov X, A
    #_1A8A27: #_1659: mov.b A, $10
    #_1A8A29: #_165B: mov.w Y, $03C2
    #_1A8A2C: #_165E: inc Y
    #_1A8A2D: #_165F: call WriteToDSP

    #_1A8A30: #_1662: mov A, X
    #_1A8A31: #_1663: bra .note_or_command

    .volume_command
    #_1A8A33: #_1665: mov.w Y, $03C2
    #_1A8A36: #_1668: inc Y
    #_1A8A37: #_1669: call WriteToDSP

    #_1A8A3A: #_166C: bra .next_byte_2

    .not_SFX_1
    #_1A8A3C: #_166E: mov A, X
    #_1A8A3D: #_166F: mov.w X, $03C0

    #_1A8A40: #_1672: asl A
    #_1A8A41: #_1673: mov.w $0321+X, A

    #_1A8A44: #_1676: mov.b A, #$0A
    #_1A8A46: #_1678: mov.w $0351+X, A

    #_1A8A49: #_167B: bbs7.b $20, .left_pan
    #_1A8A4C: #_167E: bbs6.b $20, .right_pan

    #_1A8A4F: #_1681: mov.b $11, #$0A
    #_1A8A52: #_1684: bne .set_pan

    .left_pan
    #_1A8A54: #_1686: mov.b $11, #$10
    #_1A8A57: #_1689: bne .set_pan

    .right_pan
    #_1A8A59: #_168B: mov.b $11, #$04

    .set_pan
    #_1A8A5C: #_168E: mov.b $10, #$00
    #_1A8A5F: #_1691: call WritePitch_external

    #_1A8A62: #_1694: mov.b X, #$00

    .next_byte_2
    #_1A8A64: #_1696: incw.b $2C
    #_1A8A66: #_1698: mov.b A, ($2C+X)

    .note_or_command
    #_1A8A68: #_169A: cmp.b A, #$E0 ; instrument change
    #_1A8A6A: #_169C: bne .not_instrument_change

    #_1A8A6C: #_169E: jmp .change_instrument

    .not_instrument_change
    #_1A8A6F: #_16A1: cmp.b A, #$F9 ; slide once
    #_1A8A71: #_16A3: beq .pitch_slide_command

    #_1A8A73: #_16A5: cmp.b A, #$F1 ; slide to
    #_1A8A75: #_16A7: beq .pitch_slide_to_command

    #_1A8A77: #_16A9: cmp.b A, #$FF ; SFX loop trigger
    #_1A8A79: #_16AB: bne .not_loop

    #_1A8A7B: #_16AD: mov.w X, $03C0
    #_1A8A7E: #_16B0: jmp Handle_SFX1_initialize

    .not_loop
    #_1A8A81: #_16B3: mov.w X, $03C0
    #_1A8A84: #_16B6: mov Y, A
    #_1A8A85: #_16B7: call HandleNote

    #_1A8A88: #_16BA: mov.w A, $03C1
    #_1A8A8B: #_16BD: call KeyOnSoundEffects

    .setup_pitch_slide
    #_1A8A8E: #_16C0: mov.w X, $03C0

    #_1A8A91: #_16C3: mov.w A, $03B1+X
    #_1A8A94: #_16C6: mov.w $03B0+X, A

    .do_pitch_slide
    #_1A8A97: #_16C9: clr7.b $13

    #_1A8A99: #_16CB: mov.w X, $03C0
    #_1A8A9C: #_16CE: mov.b A, $A0+X
    #_1A8A9E: #_16D0: beq .no_pitch_slide

    #_1A8AA0: #_16D2: call PitchSlideSFX
    #_1A8AA3: #_16D5: bra .dont_key_off

    .no_pitch_slide
    #_1A8AA5: #_16D7: mov.b A, #$02
    #_1A8AA7: #_16D9: cmp.w A, $03B0+X
    #_1A8AAA: #_16DC: bne .dont_key_off

    #_1A8AAC: #_16DE: mov.w A, $03C1
    #_1A8AAF: #_16E1: mov.b Y, #KOFF
    #_1A8AB1: #_16E3: call WriteToDSP

    .dont_key_off
    #_1A8AB4: #_16E6: mov.w X, $03C0

    #_1A8AB7: #_16E9: mov.b A, $2D
    #_1A8AB9: #_16EB: mov.w $0391+X, A

    #_1A8ABC: #_16EE: mov.b A, $2C
    #_1A8ABE: #_16F0: mov.w $0390+X, A

    #_1A8AC1: #_16F3: mov.w A, $03C1
    #_1A8AC4: #_16F6: and.w A, $03CF
    #_1A8AC7: #_16F9: bne .on_SFX_1

    #_1A8AC9: #_16FB: mov.w A, $03C1
    #_1A8ACC: #_16FE: and.w A, $03CB
    #_1A8ACF: #_1701: bne .on_SFX_2
    #_1A8AD1: #_1703: jmp Handle_SFX3_to_next_channel

    .on_SFX_1
    #_1A8AD4: #_1706: jmp Handle_SFX1_to_next_channel

    .on_SFX_2
    #_1A8AD7: #_1709: jmp Handle_SFX2_to_next_channel

    ;---------------------------------------------------------------------------------------------------

    .pitch_slide_command
    #_1A8ADA: #_170C: mov.b X, #$00
    #_1A8ADC: #_170E: incw.b $2C
    #_1A8ADE: #_1710: mov.b A, ($2C+X)

    #_1A8AE0: #_1712: mov.w X, $03C0

    #_1A8AE3: #_1715: mov.b $44, X
    #_1A8AE5: #_1717: mov Y, A
    #_1A8AE6: #_1718: call HandleNote

    #_1A8AE9: #_171B: mov.w A, $03C1
    #_1A8AEC: #_171E: call KeyOnSoundEffects

    ;---------------------------------------------------------------------------------------------------

    .pitch_slide_to_command
    #_1A8AEF: #_1721: mov.b X, #$00
    #_1A8AF1: #_1723: incw.b $2C
    #_1A8AF3: #_1725: mov.b A, ($2C+X)

    #_1A8AF5: #_1727: mov.w X, $03C0

    #_1A8AF8: #_172A: mov.b $A1+X, A
    #_1A8AFA: #_172C: mov.b X, #$00

    #_1A8AFC: #_172E: incw.b $2C
    #_1A8AFE: #_1730: mov.b A, ($2C+X)
    #_1A8B00: #_1732: mov.w X, $03C0

    #_1A8B03: #_1735: mov.b $A0+X, A
    #_1A8B05: #_1737: push A

    #_1A8B06: #_1738: mov.b X, #$00
    #_1A8B08: #_173A: incw.b $2C
    #_1A8B0A: #_173C: mov.b A, ($2C+X)

    #_1A8B0C: #_173E: pop Y
    #_1A8B0D: #_173F: mov.w X, $03C0
    #_1A8B10: #_1742: mov.b $44, X

    #_1A8B12: #_1744: call PitchSlide_calc_frames

    #_1A8B15: #_1747: jmp .setup_pitch_slide

    ;---------------------------------------------------------------------------------------------------

    .change_instrument
    #_1A8B18: #_174A: mov.b X, #$00
    #_1A8B1A: #_174C: incw.b $2C
    #_1A8B1C: #_174E: mov.b A, ($2C+X)

    #_1A8B1E: #_1750: mov.b Y, #$09
    #_1A8B20: #_1752: mul YA
    #_1A8B21: #_1753: mov X, A

    #_1A8B22: #_1754: mov.w Y, $03C2
    #_1A8B25: #_1757: mov.b $12, #$08

    .write_loop
    #_1A8B28: #_175A: mov.w A, INSTRUMENT_DATA_SFX+X
    #_1A8B2B: #_175D: call WriteToDSP

    #_1A8B2E: #_1760: inc X
    #_1A8B2F: #_1761: inc Y
    #_1A8B30: #_1762: dbnz.b $12, .write_loop

    #_1A8B33: #_1765: mov.w A, INSTRUMENT_DATA_SFX+X

    #_1A8B36: #_1768: mov.w Y, $03C0
    #_1A8B39: #_176B: mov.w $0221+Y, A

    #_1A8B3C: #_176E: mov.b A, #$00
    #_1A8B3E: #_1770: mov.w $0220+Y, A

    #_1A8B41: #_1773: jmp .next_byte

    ;===================================================================================================

    PitchSlideSFX:
    #_1A8B44: #_1776: set7.b $13

    #_1A8B46: #_1778: mov.b A, #$0360>>0
    #_1A8B48: #_177A: mov.b Y, #$0360>>8

    #_1A8B4A: #_177C: dec.b $A0+X
    #_1A8B4C: #_177E: call IncrementSlide_quiet

    #_1A8B4F: #_1781: mov.w A, $0361+X
    #_1A8B52: #_1784: mov Y, A
    #_1A8B53: #_1785: mov.w A, $0360+X
    #_1A8B56: #_1788: movw.b $10, YA

    #_1A8B58: #_178A: mov.b $47, #$00
    #_1A8B5B: #_178D: jmp HandleNote_external

    ;===================================================================================================

    KeyOnSoundEffects:
    #_1A8B5E: #_1790: push A

    #_1A8B5F: #_1791: mov.b Y, #KOFF
    #_1A8B61: #_1793: mov.b A, #$00
    #_1A8B63: #_1795: call WriteToDSP

    #_1A8B66: #_1798: pop A
    #_1A8B67: #_1799: mov.b Y, #KON

    #_1A8B69: #_179B: jmp WriteToDSP

    ;===================================================================================================

    base off

    arch 65816
}

; NOTE: The SPC engine crosses the border into bank 1A here.
; TODO: Figure out how to represent that.

; ==============================================================================

warnpc $1A8000