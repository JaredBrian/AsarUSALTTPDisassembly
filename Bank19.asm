; ==============================================================================

; Bank 19
; $0C8000-$0CFFFF
org $198000

; The instrament brr samples
; The first half of the SPC engine

; ==============================================================================

SPC_ENGINE          = $0800
SF_DATA            = $17C0
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
    ; $0CFBB8-$0CFBC9
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
                    cmp.b $4C, $4D : bne .skip

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

    ; NOTE: The bank 0x19 boundary is crossed in the middle of this function.
    ; TODO: Figure out how to represent that.
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
        call GetTrackByte : mov.w $0350+X, A
        
        setc : sbc.w A, $0331+X

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

        call GetTrackByte : mov.w $02A1+X, A

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

        call GetTrackByte : mov.b $5B, A

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

    ; SPC $0D33-$0D44 JUMP LOCATION
    ; $0D0101-$0D0112 DATA
    TrackCommand_E8_TempoSlide:
    {
        mov.b $54, A
        call GetTrackByte : mov.b $55, A
        
        setc : sbc.b A, $53
        mov.b X, $54
        call MakeFraction : movw.b $56, YA

        ret
    }

    ; ==========================================================================

    ; SPC $0D45-$0D47 JUMP LOCATION
    ; $0D0113-$0D0115 DATA
    TrackCommand_E9_GlobalTranspose:
    {
        mov.b $50, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D48-$0D4B JUMP LOCATION
    ; $0D0116-$0D0119 DATA
    TrackCommand_EA_ChannelTranspose:
    {
        mov.w $02F0+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D4C-$0D57 JUMP LOCATION
    ; $0D011A-$0D0125 DATA
    TrackCommand_EB_SetTremelo:
    {
        mov.w $02E0+X, A

        call GetTrackByte : mov.w $02D1+X, A

        call GetTrackByte

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0D58-$0D5A JUMP LOCATION
    ; $0D0126-$0D0128 DATA
    TrackCommand_EC_TremeloOff:
    {
        mov.b $C1+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D5B-$0D5E JUMP LOCATION
    ; $0D0129-$0D012C DATA
    TrackCommand_F1_PitchSlideTo:
    {
        mov.b A, #$01

        bra TrackCommand_F2_PitchSlideFrom_start
    }

    ; ==========================================================================

    ; SPC $0D5F-$0D74 JUMP LOCATION
    ; $0D012D-$0D0142 DATA
    TrackCommand_F2_PitchSlideFrom:
    {
        mov.b A, #$00

        ; SPC $0D61 ALTERNATE ENTRY POINT
        ; $0D012F DATA
        .start
        mov.w $0290+X, A

        mov A, Y : mov.w $0281+X, A

        call GetTrackByte : mov.w $0280+X, A

        call GetTrackByte : mov.w $0291+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D75-$0D78 JUMP LOCATION
    ; $0D0143-$0D0146 DATA
    TrackCommand_F3_PitchSlideStop:
    {
        mov.w $0280+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D79-$0D81 JUMP LOCATION
    ; $0D0147-$0D014F DATA
    TrackCommand_ED_ChannelVolume:
    {
        mov.w $0301+X, A

        mov.b A, #$00 : mov.w $0300+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D82-$0D9A JUMP LOCATION
    ; $0D0150-$0D0168 DATA
    TrackCommand_EE_ChannelVolumeSlide:
    {
        mov.b $90+X, A
        push A

        call GetTrackByte : mov.w $0320+X, A

        setc : sbc.w A, $0301+X

        pop X
        call MakeFraction : mov.w $0310+X, A

        mov A, Y : mov.w $0311+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D9B-$0D9E JUMP LOCATION
    ; $0D0169-$0D016C DATA
    TrackCommand_F4_FineTuning:
    {
        mov.w $0381+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D9F-$0DB6 JUMP LOCATION
    ; $0D016D-$0D0184 DATA
    TrackCommand_EF_CallPart:
    {
        mov.w $0240+X, A

        call GetTrackByte : mov.w $0241+X, A

        call GetTrackByte : mov.b $80+X, A

        mov.b A, $30+X : mov.w $0230+X, A

        mov.b A, $31+X : mov.w $0231+X, A
    }

    ; ==========================================================================

    ; SPC $0DB7-$0DC1 JUMP LOCATION
    ; $0D0185-$0D018F DATA
    IteratePartLoop:
    {
        mov.w A, $0240+X : mov.b $30+X, A

        mov.w A, $0241+X : mov.b $31+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0DC2-$0DD7 JUMP LOCATION
    ; $0D0190-$0D01A5 DATA
    TrackCommand_F5_EchoBasicControl:
    {
        mov.w $03C3, A
        mov.b $4A, A

        call GetTrackByte
        mov.b A, #$00 : movw.b $60, YA

        call GetTrackByte
        mov.b A, #$00 : movw.b $62, YA

        clr5.b $48

        ret
    }

    ; ==========================================================================

    ; SPC $0DD8-$0DF8 JUMP LOCATION
    ; $0D01A6-$0D01C6 DATA
    TrackCommand_F8_EchoSlide:
    {
        mov.b $68, A
        call GetTrackByte : mov.b $69, A
        setc : sbc.b A, $61

        mov.b X, $68
        call MakeFraction : movw.b $64, YA

        call GetTrackByte : mov.b $6A, A
        setc : sbc.b A, $63

        mov.b X, $68
        call MakeFraction : movw.b $66, YA

        ret
    }

    ; ==========================================================================

    ; SPC $0DF9-$0DFF JUMP LOCATION
    ; $0D01C7-$0D01CD DATA
    TrackCommand_F6_EchoSilence:
    {
        movw.b $60, YA
        movw.b $62, YA

        set5.b $48

        ret
    }

    ; ==========================================================================

    ; SPC $0E00-$0E21 JUMP LOCATION
    ; $0D01CE-$0D01EF DATA
    TrackCommand_F7_EchoFilter:
    {
        call ConfigureEcho

        call GetTrackByte : mov.b $4E, A

        call GetTrackByte

        mov.b Y, #$08
        mul YA : mov X, A

        mov.b Y, #FIR0

        .set_next_filter
            mov.w A, EchoFilterParameters+X
            call WriteToDSP

            inc X

            mov A, Y : clrc : adc.b A, #$10 : mov Y, A
        bpl .set_next_filter

        mov.b X, $44

        ret
    }

    ; ==========================================================================

    ; SPC $0E22-$0E67 JUMP LOCATION
    ; $0D01F0-$0D0235 DATA
    ConfigureEcho:
    {
        mov.b $4D, A
        mov.b Y, #EDL

        mov.w DSPADDR, Y

        ; OPTIMIZE: Why not "mov.w A, Y"?
        mov.w A, DSPDATA : cmp.b A, $4D : beq .edl_same
            and.b A, #$0F : eor.b A, #$FF : bbc7.b $4C, .buffer_ready
                clrc : adc.b A, $4C

            .buffer_ready

            mov.b $4C, A
            mov.b Y, #$04

            .write_register

                mov.w A, RegisterList-1+Y : mov.w DSPADDR, A

                mov.b A, #$00 : mov.w DSPDATA, A
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

    ; ==========================================================================

    ; SPC $0E68-$0E6A JUMP LOCATION
    ; $0D0236-$0D0238 DATA
    TrackCommand_FA_PercussionOffset:
    {
        mov.b $5F, A

        ret
    }

    ; ==========================================================================

    ; SPC $0E6B-$0E6E JUMP LOCATION
    ; $0D0239-$0D023C DATA
    DummyCommand:
    {
        call SkipTrackByte

        ret
    }

    ; ==========================================================================

    ; SPC $0E6F-$0E73 JUMP LOCATION
    ; $0D023D-$0D0241 DATA
    ChannelStop:
    {
        inc A
        mov.w $03FF+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0E74-$0E74 JUMP LOCATION
    ; $0D0242-$0D0242 DATA
    SongStop:
    {
        inc A
    }

    ; ==========================================================================

    ; SPC $0E75-$0E79 JUMP LOCATION
    ; $0D0243-$0D0247 DATA
    SongContinue:
    {
        mov.b $1B, A

        jmp Song_NewJam_key_off
    }

    ; ==========================================================================

    ; SPC $0E7A-$0E9A JUMP LOCATION
    ; $0D0248-$0D0269 DATA
    PitchSlide:
    {
        mov.b A, $A0+X : bne TrackCommand_F9_SlideOnce_exit
            mov.b A, ($30+X) : cmp.b A, #$F9 : bne TrackCommand_F9_SlideOnce_exit
                mov.b A, $47 : and.b A, $1A : beq .do_pitch_slide
                    mov.b $10, #$04

                    .skip_loop

                        call SkipTrackByte
                    dbnz.b $10, .skip_loop

                    bra TrackCommand_F9_SlideOnce_exit

                .do_pitch_slide

                call SkipTrackByte
                call GetTrackByte

                ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0E9B-$0EC2 JUMP LOCATION
    ; $0D0269-$0D0290 DATA
    TrackCommand_F9_SlideOnce:
    {
        mov.b $A1+X, A

        call GetTrackByte : mov.b $A0+X, A

        call GetTrackByte
        clrc : adc.b A, $50 : adc.w A, $02F0+X

        .calc_frames

        and.b A, #$7F : mov.w $0380+X, A

        setc : sbc.w A, $0361+X
        mov.b Y, $A0+X

        push Y
        pop X
        call MakeFraction : mov.w $0370+X, A
        mov A, Y : mov.w $0371+X, A

        ; SPC $0EC2 ALTERNATE ENTRY POINT
        ; $0D0290 DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0EC3-$0ECD JUMP LOCATION
    ; $0D0291-$0D029B DATA
    GetTempPitch:
    {
        mov.w A, $0361+X : mov.b $11, A

        mov.w A, $0360+X : mov.b $10, A

        ret
    }

    ; ==========================================================================

    ; SPC $0ECE-$0EDF JUMP LOCATION
    ; $0D029C-$0D02AD DATA
    MakeFraction:
    {
        notc : ror.b $12 : bpl .positive_input
            eor.b A, #$FF
            inc A

        .positive_input

        mov.b Y, #$00
        div YA, X

        push A

        mov.b A, #$00
        div YA, X

        pop Y

        mov.b X, $44

        ; Bleeds into the next function.
    }

    ; SPC $0EE0-$0EE9 JUMP LOCATION
    ; $0D02AE-$0D02B8 DATA
    MakeFraction_abs:
    {
        bbc7.b $12, .keep_positive
            movw.b $14, YA

            movw.b YA, $0E : subw.b YA, $14

        .keep_positive

        ret
    }

    ; ==========================================================================

    ; SPC $0EEA-$0F1F JUMP LOCATION
    ; $0D02B8-$0D02ED DATA
    TrackCommand_Vectors:
    {
        dw TrackCommand_E0_ChangeInstrument
        dw TrackCommand_E1_ChangePan
        dw TrackCommand_E2_PanSlide
        dw TrackCommand_E3_SetVibrato

        dw TrackCommand_E4_VibratoOff
        dw TrackCommand_E5_GlobalVolume
        dw TrackCommand_E6_GlobalVolumeSlide
        dw TrackCommand_E7_SetTempo

        dw TrackCommand_E8_TempoSlide
        dw TrackCommand_E9_GlobalTranspose
        dw TrackCommand_EA_ChannelTranspose
        dw TrackCommand_EB_SetTremelo

        dw TrackCommand_EC_TremeloOff
        dw TrackCommand_ED_ChannelVolume
        dw TrackCommand_EE_ChannelVolumeSlide
        dw TrackCommand_EF_CallPart

        dw TrackCommand_F0_VibratoGradient
        dw TrackCommand_F1_PitchSlideTo
        dw TrackCommand_F2_PitchSlideFrom
        dw TrackCommand_F3_PitchSlideStop

        dw TrackCommand_F4_FineTuning
        dw TrackCommand_F5_EchoBasicControl
        dw TrackCommand_F6_EchoSilence
        dw TrackCommand_F7_EchoFilter

        dw TrackCommand_F8_EchoSlide
        dw TrackCommand_F9_SlideOnce
        dw TrackCommand_FA_PercussionOffset
    }

    ; ==========================================================================

    ; SPC $0F20-$0F3E JUMP LOCATION
    ; $0D02EE-$0D030C DATA
    TrackCommandParamCount:
    {
        db 1 ; E0
        db 1 ; E1
        db 2 ; E2
        db 3 ; E3
        db 0 ; E4
        db 1 ; E5
        db 2 ; E6
        db 1 ; E7
        db 2 ; E8
        db 1 ; E9
        db 1 ; EA
        db 3 ; EB
        db 0 ; EC
        db 1 ; ED
        db 2 ; EE
        db 3 ; EF
        db 1 ; F0
        db 3 ; F1
        db 3 ; F2
        db 0 ; F3
        db 1 ; F4
        db 3 ; F5
        db 0 ; F6
        db 3 ; F7
        db 3 ; F8
        db 3 ; F9
        db 1 ; FA

        ; extraneous
        db 2 ; FB
        db 0 ; FC
        db 0 ; FD
        db 0 ; FE
    }

    ; ==========================================================================

    ; SPC $0F3F-$0F93 JUMP LOCATION
    ; $0D030D-$0D0361 DATA
    WritePitch:
    {
        mov.b A, $90+X : beq .no_volume_slide
            mov.b A, #$0300>>0
            mov.b Y, #$0300>>8
            dec.b $90+X

            call IncrementSlide

        .no_volume_slide

        mov.b Y, $C1+X : beq .no_tremelo
            mov.w A, $02E0+X : cbne.b $C0+X, .tremelo_not_ready
                or.b $5E, $47

                mov.w A, $02D0+X : bpl .tremelo_accumulate
                    inc Y
                    bne .tremelo_accumulate
                        mov.b A, #$80

                        bra .skip_accumulate

                .tremelo_accumulate

                clrc : adc.w A, $02D1+X

                .skip_accumulate

                mov.w $02D0+X, A
                call VolumeModulation_external

                bra .handle_pan_slide

            .tremelo_not_ready

            inc.b $C0+X

        .no_tremelo

        mov.b A, #$FF
        call VolumeModulation_final_volume

        .handle_pan_slide

        mov.b A, $91+X : beq .no_pan_slide
            mov.b A, #$0330>>0
            mov.b Y, #$0330>>8
            dec.b $91+X

            call IncrementSlide

        .no_pan_slide

        mov.b A, $47 : and.b A, $5E : beq WritePitch_external_exit
            mov.w A, $0331+X
            mov Y, A

            mov.w A, $0330+X
            movw.b $10, YA

            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; TODO: HERE
    ; SPC $0F94-$0FD1 JUMP LOCATION
    ; $0D0362-$0D039F DATA
    WritePitch_external:
    {
        mov A, X : xcn A : lsr A : mov.b $12, A

        .vol_right

            mov.b Y, $11
            mov.w A, LogisticFunc+1+Y : setc : sbc.w A, LogisticFunc+0+Y

            mov.b Y, $10
            mul YA : mov A, Y

            mov.b Y, $11
            clrc : adc.w A, LogisticFunc+0+Y : mov Y, A
            mov.w A, $0321+X
            mul YA
            
            mov.w A, $0351+X : asl A : bbc0.b $12, .vol_left
                asl A

            .vol_left

            mov A, Y : bcc .no_phase_inversion
                eor.b A, #$FF : inc A

            .no_phase_inversion

            mov.b Y, $12
            call WriteToDSP_Checked

            mov.b Y, #$14
            mov.b A, #$00
            subw.b YA, $10 : movw.b $10, YA

            inc.b $12
        bbc1.b $12, .vol_right

        ; SPC $0FD1 ALTERNATE ENTRY POINT
        ; $0D039F DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0FD2-$0FF5 JUMP LOCATION
    ; $0D03A0-$0D03C3 DATA
    IncrementSlide:
    {
        or.b $5E, $47

        ; SPC $0FD5 ALTERNATE ENTRY POINT
        ; $0D03A3 DATA
        .quiet

        movw.b $14, YA
        movw.b $16, YA

        push X
        pop Y

        clrc
        bne .still_sliding
            adc.b $16, #$1F

            mov.b A, #$00 : mov.b ($14)+Y, A

            inc Y

            bra .add

        .still_sliding

        adc.b $16, #$10
        call .add_slide_amount

        inc Y

        ; SPC $0FEF ALTERNATE ENTRY POINT
        ; $0D03BD DATA
        .add_slide_amount

        mov.b A, ($14)+Y

        .add

        adc.b A, ($16)+Y : mov.b ($14)+Y, A

        ret
    }

    ; ==========================================================================

    ; SPC $0FF6-$10B0 JUMP LOCATION
    ; $0D03C4-$0D047E DATA
    Tracker:
    {
        mov.b A, $71+X : beq .time_left
            dec.b $71+X
            beq .times_up
                mov.b A, #$02
                cbne.b $70+X, .time_left

            .times_up
            
            mov.b A, $80+X : mov.b $17, A

            mov.b A, $30+X
            mov.b Y, $31+X

            .load_pointer

            movw.b $14, YA
            mov.b Y, #$00

            .next_byte
            
                mov.b A, ($14)+Y : beq .terminate_track
                    bmi .command
                        .read_track_data

                            inc Y : .call_loop_over
                                mov.b A, ($14)+Y
                        bpl .read_track_data

                    .command

                    ; tie
                    cmp.b A, #$C8 : beq .time_left
                        ; call part
                        cmp.b A, #$EF : beq .call_loop_command
                            ; instrument change
                            cmp.b A, #$E0 : bcc .call_loop_over
                                push Y
                                mov Y, A
                                pop A
                                adc.w A, TrackCommandParamCount-$E0+Y : mov Y, A
            bra .next_byte

            .terminate_track

            mov.b A, $17 : beq .call_loop_over
                dec.b $17
                bne .call_loop_notdone
                    mov.w A, $0231+X : push A
                    mov.w A, $0230+X
                    pop Y

                    bra .load_pointer

                .call_loop_notdone

                mov.w A, $0241+X : push A
                mov.w A, $0240+X
                pop Y

                bra .load_pointer

                .call_loop_command

                inc Y

                mov.b A, ($14)+Y : push A
                inc Y
                mov.b A, ($14)+Y : mov Y, A
                pop A

                bra .load_pointer

            .call_loop_over

            mov.b A, $47
            mov.b Y, #KOFF
            call WriteToDSP_Checked

        .time_left

        clr7.b $13

        mov.b A, $A0+X : beq .no_pitch_slide
            mov.b A, $A1+X : beq .delay_finished
                dec.b $A1+X
                bra .no_pitch_slide

            .delay_finished

            mov.b A, $1A : and.b A, $47 : bne .no_pitch_slide
                set7.b $13

                mov.b A, #$0360>>0
                mov.b Y, #$0360>>8

                dec.b $A0+X
                call IncrementSlide_quiet

        .no_pitch_slide

        call GetTempPitch

        mov.b A, $B1+X : beq Tracker_no_vibrato
            mov.w A, $02B0+X : cbne.b $B0+X, Tracker_handle_pitch_set_point_wait
                mov.w A, $0100+X : cmp.w A, $02B1+X : bne .increment
                    mov.w A, $02C1+X
                    bra .set_intensity

                .increment
                
                ; TODO: Verify this byte. We are setting the direct page but then
                ; it still says .b $0100? i'm pretty sure this can just be .b $00.
                setp
                inc.b $0100+X
                clrp

                mov Y, A : beq .initializing
                    mov.b A, $B1+X

                .initializing

                clrc : adc.w A, $02C0+X

                .set_intensity

                mov.b $B1+X, A

                mov.w A, $02A0+X : clrc : adc.w A, $02A1+X : mov.w $02A0+X, A

                ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $10B1-$10D0 JUMP LOCATION
    ; $0D047F-$0D049E DATA
    Tracker_handle_pitch:
    {
        mov.b $12, A
        asl A : asl A : bcc .low_enough
            eor.b A, #$FF

        .low_enough

        mov Y, A

        mov.b A, $B1+X : cmp.b A, #$F1 : bcc .too_small
            and.b A, #$0F
            mul YA

            bra .continue

        .too_small

        mul YA : mov A, Y
        mov.b Y, #$00

        .continue

        call AdjustPitch

        ; SPC $10CC ALTERNATE ENTRY POINT
        ; $0D049A DATA
        .change_pitch

        jmp HandleNote_external

        ; SPC $10CF ALTERNATE ENTRY POINT
        ; $0D049D DATA
        .set_point_wait

        inc.b $B0+X
    }

    ; ==========================================================================

    ; SPC $10D1-$10D4 JUMP LOCATION
    ; $0D049F-$0D04A2 DATA
    Tracker_no_vibrato:
    {
        bbs7.b $13, Tracker_handle_pitch_change_pitch
            ret
    }

    ; ==========================================================================

    ; SPC $10D5-$112F JUMP LOCATION
    ; $0D04A3-$0D04FD DATA
    BackgroundTasks:
    {
        clr7.b $13

        mov.b A, $C1+X : beq .no_tremelo
            mov.w A, $02E0+X : cbne.b $C0+X, .no_tremelo
                call VolumeModulation

        .no_tremelo

        mov.w A, $0331+X : mov Y, A

        mov.w A, $0330+X : movw.b $10, YA

        mov.b A, $91+X : beq .no_pan_slide
            mov.w A, $0341+X : mov Y, A

            mov.w A, $0340+X
            call AdjustPitchByFrames

        .no_pan_slide

        bbc7.b $13, .pitch_unchanged
            call WritePitch_external

        .pitch_unchanged

        clr7.b $13

        call GetTempPitch

        mov.b A, $A0+X : beq .no_pitch_slide
            mov.b A, $A1+X : bne .no_pitch_slide
                mov.w A, $0371+X : mov Y, A

                mov.w A, $0370+X
                call AdjustPitchByFrames

        .no_pitch_slide

        mov.b A, $B1+X : beq Tracker_no_vibrato
            mov.w A, $02B0+X : cbne.b $B0+X, Tracker_no_vibrato
                mov.b Y, $51
                mov.w A, $02A1+X
                mul YA : mov A, Y : clrc : adc.w A, $02A0+X

                jmp Tracker_handle_pitch
    }

    ; ==========================================================================

    ; SPC $1130-$1145 JUMP LOCATION
    ; $0D04FE-$0D0513 DATA
    AdjustPitchByFrames:
    {
        set7.b $13

        mov.b $12, Y
        call MakeFraction_abs

        push Y

        mov.b Y, $51
        mul YA : mov.b $14, Y

        mov.b $15, #$00

        mov.b Y, $51
        pop A
        mul YA : addw.b YA, $14

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $1146-$114D JUMP LOCATION
    ; $0D0514-$0D051B DATA
    AdjustPitch:
    {
        call MakeFraction_abs

        addw.b YA, $10 : movw.b $10, YA

        ret
    }

    ; ==========================================================================

    ; SPC $114E-$115A JUMP LOCATION
    ; $0D051C-$0D0528 DATA
    VolumeModulation:
    {
        set7.b $13

        mov.b Y, $51
        mov.w A, $02D1+X
        mul YA : mov A, Y : clrc : adc.w A, $02D0+X

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $115B-$1177 JUMP LOCATION
    ; $0D0529-$0D0545 DATA
    VolumeModulation_external:
    {
        asl A : bcc .no_phase_invert
            eor.b A, #$FF

        .no_phase_invert

        mov.b Y, $C1+X
        mul YA : mov A, Y : eor.b A, #$FF

        ; SPC $1166 ALTERNATE ENTRY POINT
        ; $0D0534 DATA
        .final_volume

        mov.b Y, $59
        mul YA

        mov.w A, $0210+X
        mul YA

        mov.w A, $0301+X
        mul YA : mov A, Y
        mul YA : mov A, Y : mov.w $0321+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $1178-$118C JUMP LOCATION
    ; $0D0546-$0D055A DATA
    LogisticFunc:
    {
        db $00, $01, $03, $07, $0D, $15, $1E, $29
        db $34, $42, $51, $5E, $67, $6E, $73, $77
        db $7A, $7C, $7D, $7E, $7F
    }

    ; ==========================================================================
    
    ; Contains values for each of the 8 bytes of filter
    ; SPC $118D-$11AC DATA
    ; $0D055B-$0D057A DATA
    EchoFilterParameters:
    {
        db $7F, $00, $00, $00, $00, $00, $00, $00
        db $58, $BF, $DB, $F0, $FE, $07, $0C, $0C
        db $0C, $21, $2B, $2B, $13, $FE, $F3, $F9
        db $34, $33, $00, $D9, $E5, $01, $FC, $EB
    }

    ; ==========================================================================

    ; SPC $11AD-$11B6 DATA
    ; $0D057B-$0D0584 DATA
    RegisterList:
    {
        db EVOLL
        db EVOLR
        db EFB
        db EON
        db FLG
        db KON
        db KOFF
        db NON
        db PMON
        db KOFF
    }

    ; ==========================================================================

    ; SPC $11B7-$11C0 DATA
    ; $0D0585-$0D058E DATA
    LoadValueFrom:
    {
        db $61 ; EVOLL
        db $63 ; EVOLR
        db $4E ; EFB
        db $4A ; EON
        db $48 ; FLG
        db $45 ; KON
        db $0E ; KOFF
        db $49 ; NON
        db $4B ; PMON
        db $46 ; KOFF
    }

    ; ==========================================================================

    ; SPC $11C1-$11DA DATA
    ; $0D058F-$0D05A8 DATA
    TuningValues:
    {
        dw $085F
        dw $08DE
        dw $0965
        dw $09F4
        dw $0A8C
        dw $0B2C
        dw $0BD6
        dw $0C8B
        dw $0D4A
        dw $0E14
        dw $0EEA
        dw $0FCD
        dw $10BE
    }

    ; ==========================================================================

    ; SPC $11DB-$11E5 DATA
    ; $0D05A9-$0D05B3 DATA
    UNREACHABLE_11DB:
    {
        db $2A
        db $56
        db $65
        db $72
        db $20
        db $53
        db $31
        db $2E
        db $32
        db $30
        db $2A
    }

    ; ==========================================================================

    ; SPC $11E6-$1231 JUMP LOCATION
    ; $0D05B4-$0D05FF DATA
    Data_Loader:
    {
        mov.b A, #$AA : mov.w CPUIO0, A

        mov.b A, #$BB : mov.w CPUIO1, A

        .wait_data_start

            ; Loop
        mov.w A, CPUIO0 : cmp.b A, #$CC : bne .wait_data_start

        bra .begin_transfer

        .loop

                mov.w Y, CPUIO0
            bne .loop

            .reread

                cmp.w Y, CPUIO0 : bne .coherence_error
                    mov.w A, CPUIO1
                    mov.w CPUIO0, Y
                    mov.b ($14)+Y, A

                    inc Y
                    bne .reread
                        inc.b $15

                        bra .reread

                .coherence_error

                bpl .reread
            cmp.w Y, CPUIO0 : bpl .reread

            .begin_transfer

            mov.w A, CPUIO2
            mov.w Y, CPUIO3
            movw.b $14, YA

            mov.w Y, CPUIO0
            mov.w A, CPUIO1

            ; TODO: Why move Y back into CPUIO0? Probably because it will set
            ; the Zero flag again. Verify.
            mov.w CPUIO0, Y
        bne .loop

        ; clear ports 0123, start timer 0
        mov.b X, #$31
        mov.w CONTROL, X

        ret
    }

    ; ==========================================================================

    ; SPC $1232-$125F JUMP LOCATION
    ; $0D0600-$0D062D DATA
    SFX2_HandleEcho:
    {
        mov.b A, $02 : and.b A, #$3F : mov X, A

        mov.w A, SFX2_Echo-1+X : mov.w $03E2, A

        mov.b Y, #$0E
        mov.b X, #$80 : mov.w $03C1, X

        .loop_back

            mov.w A, $03CB : and.w A, $03C1 : beq .SFX2_next_slot
                clrc
                mov.w A, $03A0+Y
                adc.w A, $03D0+Y

                cmp.b A, $02
                beq SFX3_HandleEcho_match

            .SFX2_next_slot

            dec Y : dec Y
        lsr.w $03C1 : bne .loop_back

        bra SFX3_HandleEcho_no_slot
    }

    ; ==========================================================================

    ; SPC $1260-$12E6 JUMP LOCATION
    ; $0D062E-$0D06B4 DATA
    SFX3_HandleEcho:
    {
        mov.b A, $03 : and.b A, #$3F : mov X, A
        mov.w A, SFX3_Echo-1+X : mov.w $03E2, A

        mov.b Y, #$0E

        mov.b X, #$80 : mov.w $03C1, X

        .SFX3_loop_point
            mov.w A, $03CD : and.w A, $03C1 : beq .SFX3_next_slot
                clrc
                mov.w A, $03A0+Y : adc.w A, $03D0+Y : cmp.b A, $03 : beq .match

            .SFX3_next_slot

            dec Y : dec Y
        lsr.w $03C1: bne .SFX3_loop_point

        bra .no_slot

        .match

        mov.w $03C0, Y

        bra .enabled

        .no_slot

        clrc
        mov.b X, #$1A

        mov.b A, #$80 : mov.w $03C1, A

        mov.b Y, #$0E

        .loop_back_2

            and A, (X) : beq .enabled
                dec Y : dec Y

                lsr.w $03C1
        lsr A : bcc .loop_back_2

        .enabled

        mov.w $03C0, Y
        mov.w $03C8, Y

        mov.w A, $03C1 : mov.w $03C9, A
        or.b A, $1A : mov.b $1A, A

        mov.w X, $03E2 : beq .disabled
            or.w A, $03E3 : mov.w $03E3, A

        .disabled

        mov.w A, $0004 : and.b A, #$10 : beq .lower_bank
            mov.w A, $03C1 : and.w A, $03E3 : beq .echo_off

        .lower_bank

        mov.w A, $03C1 : and.b A, $4A : beq .echo_off
            mov.b A, $4A : setc : sbc.w A, $03C1 : mov.b $4A, A

            mov.b Y, #EON
            call WriteToDSP

        .echo_off

        ret
    }

    ; ==========================================================================

    ; SPC $12E7-$12FE JUMP LOCATION
    ; $0D06B5-$0D06CC DATA
    Unused_12E7:
    {
        mov.w X, $03C4 : mov.w $03C0, X

        mov.w Y, $03C5 : mov.w $03C1, Y

        mov.w A, $03C1
        mov.b Y, #KOFF
        call WriteToDSP

        call ResumeMusic

        ret
    }

    ; ==========================================================================

    ; SPC $12FF-$136C JUMP LOCATION
    ; $0D06CD-$0D073A DATA
    InitSFX1:
    {
        mov.b $05, A : cmp.b A, #$05 : bne .initialize
            mov.w X, $03CF : bne .initialize
                ret

        .initialize

        mov.b X, #$00 :  mov.w $03E4, X

        mov.b X, #$0E
        mov.b A, $01  : mov.w $03A0+X, A
        mov.b A, #$03 : mov.w $03A1+X, A
        mov.b A, #$00 : mov.w $0280+X, A
        mov.b A, #$80 : mov.w $03CF, A

        mov.b Y, #KOFF
        call WriteToDSP

        set7.b $1A

        mov.b X, $01
        mov.w A, SFX1_Accomp-1+X : mov.b $01, A
                                   bne .also_use_chan_6
            ret

        .also_use_chan_6

        mov.b X, #$0C
        mov.b A, $01  : mov.w $03A0+X, A
        mov.b A, #$03 : mov.w $03A1+X, A
        mov.b A, #$00 : mov.w $0280+X, A

        set6.b $1A

        mov.b A, #$40
        mov.b Y, #KOFF
        call WriteToDSP

        mov.b A, #$C0 : mov.w $03CF, A
        or.w A, $03E3 : mov.w $03E3, A

        mov.b A, #$3F : and.w A, $03CB : mov.w $03CB, A

        mov.b A, #$3F : and.w A, $03CD : mov.w $03CD, A

        ret
    }

    ; ==========================================================================

    ; SPC $136D-$1380 JUMP LOCATION
    ; $0D073B-$0D074E DATA
    HandleInput_SFX1:
    {
        mov.b A, $01 : bmi .SFX1_negative
            bne InitSFX1
                ret

        .SFX1_negative

        mov.b $05, A

        mov.w A, $03CF : beq .channels_not_used
            mov.b A, #$78
            mov.w $03E4, A

        .channels_not_used

        ret
    }

    ; ==========================================================================

    ; SPC $1381-$13B6 JUMP LOCATION
    ; $0D074F-$0D0784 DATA
    SFX1_FadeHandler:
    {
        dec.w $03E4
        mov.w A, $03E4 : bne .still_fading
            mov.b A, #$05 :  mov.b $01, A
            call InitSFX1_initialize

            mov.b A, #$00 : mov.b $01, A

            ret

        .still_fading

        lsr A : mov.w $03E5, A
        mov.b Y, #V7VOLL
        call WriteToDSP

        inc Y ; V7VOLR
        mov.w A, $03E5
        call WriteToDSP

        mov.b Y, #V6VOLL
        mov.w A, $03E5
        call WriteToDSP

        inc Y ; V6VOLR
        mov.w A, $03E5
        call WriteToDSP

        jmp Handle_SFX1_no_fadeout
    }

    ; ==========================================================================

    ; SPC $13B7-$13BB JUMP LOCATION
    ; $0D0785-$0D0789 DATA
    HandleInput_SFX2:
    {
        mov.b A, $02 : bne HandleValidSFX2
            ret
    }

    ; ==========================================================================

    ; SPC $13BC-$1402 JUMP LOCATION
    ; $0D078A-$0D07D1 DATA
    HandleInput_SFX3:
    {
        mov.b A, $03 : bne .valid
            ret

        .valid

            mov.b A, #$FF : cbne.b $1A, .not_all_muted
                bra .exit

            .not_all_muted

            call SFX3_HandleEcho

            mov.w X, $03C0
            mov.b A, $03 : and.b A, #$C0 : mov.w $03D0+X, A
            mov.b A, $03 : and.b A, #$3F : mov.w $03A0+X, A

            mov.b A, #$03 : mov.w $03A1+X, A
            mov.b A, #$00 : mov.w $0280+X, A

            mov.w A, $03C1 : or.w A, $03CD : mov.w $03CD, A

            mov.w A, $03C1
            mov.b Y, #KOFF
            call WriteToDSP

            mov.w A, $03A0+X : mov X, A

            mov.w A, SFX3_Accomp-1+X : mov.b $03, A
        bne .valid

        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $1403-$1444 JUMP LOCATION
    ; $0D07D1-$0D0812 DATA
    HandleValidSFX2:
    {
            mov.b A, #$FF : cbne.b $1A, .not_all_muted
                bra .exit

            .not_all_muted

            call SFX2_HandleEcho

            mov.w X, $03C0
            mov.b A, $02 : and.b A, #$3F : mov.w $03A0+X, A
            mov.b A, $02 : and.b A, #$C0 : mov.w $03D0+X, A

            mov.b A, #$03 : mov.w $03A1+X, A
            mov.b A, #$00 : mov.w $0280+X, A

            mov.w A, $03C1 : or.w A, $03CB : mov.w $03CB, A

            mov.w A, $03C1
            mov.b Y, #KOFF
            call WriteToDSP

            mov.w A, $03A0+X : mov X, A
            mov.w A, SFX2_Accomp-1+X : mov.b $02, A
        bne HandleValidSFX2

        .exit

        ret
    }

    ; ==========================================================================

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

    ; ==========================================================================

    ; SPC $14AD-$150A JUMP LOCATION
    ; $0D087B-$0D08D8 DATA
    Handle_SFX2:
    {
        mov.w A, $03CB : mov.w $03CC, A
                         beq .exit
            mov.b X, #$0E

            mov.b A, #$80 : mov.w $03C1, A

            .next_channel

                asl.w $03CC : bcc .to_next_channel
                    mov.w $03C0, X
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    mov.w A, $03D0+X : mov.b $20, A

                    mov.w A, $03A1+X : bne .delayed
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                .to_next_channel

                lsr.w $03C1

                dec X : dec X
            bpl .next_channel

        .exit

        ret

        .delayed

        mov.w $03C0, X

        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .initialize
            jmp .to_next_channel

        .initialize

        mov.w A, $03A0+X : asl A : mov Y, A
        mov.w A, SFX2_Pointers-1+Y : mov.w $0391+X, A
                                     mov.b $2D, A
        mov.w A, SFX2_Pointers-2+Y : mov.w $0390+X, A
                                     mov.b $2C, A

        jmp SFXControl_process_byte
    }

    ; ==========================================================================

    ; SPC $150B-$1568 JUMP LOCATION
    ; $0D08D9-$0D0936 DATA
    Handle_SFX3:
    {
        mov.w A, $03CD : mov.w $03CE, A
                         beq .exit
            mov.b X, #$0E
            mov.b A, #$80 : mov.w $03C1, A

            .next_channel
                
                asl.w $03CE : bcc .to_next_channel
                    mov.w $03C0, X
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    mov.w A, $03D0+X : mov.b $20, A

                    mov.w A, $03A1+X : bne .delayed
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                .to_next_channel

                lsr.w $03C1

                dec X : dec X
            bpl .next_channel

        .exit

        ret

        .delayed

        mov.w $03C0, X
        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .initialize
            jmp .to_next_channel

        .initialize

        mov.w A, $03A0+X : asl A : mov Y, A
        mov.w A, SFX3_Pointers-1+Y : mov.w $0391+X, A
                                     mov.b $2D, A
        mov.w A, SFX3_Pointers-2+Y : mov.w $0390+X, A
                                     mov.b $2C, A

        jmp SFXControl_process_byte
    }

    ; ==========================================================================

    ; SPC $1569-$15D9 JUMP LOCATION
    ; $0D0937-$0D09A7 DATA
    ResumeMusic:
    {
        mov.b A, #$00
        mov.w X, $03C0
        mov.w $03A0+X, A

        mov.b A, $1A : setc : sbc.w A, $03C1 : mov.b $1A, A

        mov.w A, $03C1 : and.w A, $03CB : beq .not_on_SFX_2
            mov.w A, $03CB : setc : sbc.w A, $03C1 : mov.w $03CB, A

            bra .resume

        .not_on_SFX_2

        mov.w A, $03C1 : and.w A, $03CD : beq .not_on_SFX_3
            mov.w A, $03CD : setc : sbc.w A, $03C1 : mov.w $03CD, A

            bra .resume

        .not_on_SFX_3

        mov.w A, $03CF : setc : sbc.w A, $03C1 : mov.w $03CF, A

        .resume

        mov.b $44, X
        mov.w A, $0211+X
        call TrackCommand_E0_ChangeInstrument

        mov.w A, $03C1 : and.w A, $03C3 : beq .exit
            and.b A, $4A : bne .exit
                mov.b A, $4A : clrc : adc.w A, $03C1 : mov.b $4A, A

                mov.b Y, #EON
                call WriteToDSP

                mov.w A, $03E3 : setc : sbc.w A, $03C1 : mov.w $03E3, A

        .exit

        mov.w X, $03C0

        ret
    }

    ; ==========================================================================

    ; SPC $15DA-$15FB JUMP LOCATION
    ; $0D09A8-$0D09C6 DATA
    DisableSFX:
    {
        mov.w A, $03C1 : and.w A, $03CF : bne .used_by_SFX_1
            mov.w A, $03C1 : and.w A, $03CB : bne .used_by_SFX_2
                call ResumeMusic
                jmp Handle_SFX3_to_next_channel

        .used_by_SFX_1

        call ResumeMusic
        jmp Handle_SFX1_to_next_channel

        .used_by_SFX_2

        call ResumeMusic
        jmp Handle_SFX2_to_next_channel
    }

    ; ==========================================================================

    ; SPC $15FC-$1775 JUMP LOCATION
    ; $0D09CA-$0D0B43 DATA
    SFXControl:
    {
        call SFX3_HandleEcho_disabled

        mov.w $03C0, X
        mov.w A, $0391+X : mov Y, A
        mov.w A, $0390+X : movw.b $2C, YA

        mov.w A, $03B0+X : dec A : mov.w $03B0+X, A

        beq .next_byte
            jmp .do_pitch_slide

        .next_byte

        incw.b $2C

        ; SPC $1619 ALTERNATE ENTRY POINT
        ; $0D09E7 DATA
        .process_byte

        mov.w A, $03C0 : xcn A : lsr A : mov.w $03C2, A

        mov.b X, #$00
        mov.b A, ($2C+X) : beq DisableSFX
            bmi .note_or_command
                mov.w Y, $03C0
                mov.w $03B1+Y, A

                incw.b $2C
                mov.b A, ($2C+X) : mov.b $10, A
                                   bmi .note_or_command
                    mov X, A
                    mov.w A, $03C1 : and.w A, $03CF : beq .not_SFX_1
                        mov A, X : beq .zero_byte
                            mov.w X, $03E5 : bne .next_byte_2

                        .zero_byte
                        
                        mov.b $10, A
                        mov.w Y, $03C2
                        call WriteToDSP

                        mov.b X, #$00
                        incw.b $2C
                        mov.b A, ($2C+X) : bpl .volume_command
                            mov X, A
                            mov.b A, $10
                            mov.w Y, $03C2 : inc Y
                            call WriteToDSP

                            mov A, X

                            bra .note_or_command

                        .volume_command

                        mov.w Y, $03C2 : inc Y
                        call WriteToDSP

                        bra .next_byte_2

                    .not_SFX_1

                    mov A, X
                    mov.w X, $03C0

                    asl A : mov.w $0321+X, A

                    mov.b A, #$0A : mov.w $0351+X, A

                    bbs7.b $20, .left_pan
                        bbs6.b $20, .right_pan
                            mov.b $11, #$0A : bne .set_pan

                    .left_pan

                    mov.b $11, #$10 : bne .set_pan
                        .right_pan

                        mov.b $11, #$04

                    .set_pan

                    mov.b $10, #$00
                    call WritePitch_external

                    mov.b X, #$00

                    .next_byte_2

                    incw.b $2C
                    mov.b A, ($2C+X)

            .note_or_command

            ; instrument change
            cmp.b A, #$E0 : bne .not_instrument_change
                jmp .change_instrument

            .not_instrument_change

            ; slide once
            cmp.b A, #$F9 : beq .pitch_slide_command
                ; slide to
                cmp.b A, #$F1 : beq .pitch_slide_to_command
                    ; SFX loop trigger
                    cmp.b A, #$FF : bne .not_loop
                        mov.w X, $03C0
                        jmp Handle_SFX1_initialize

                    .not_loop

                    mov.w X, $03C0
                    mov Y, A
                    call HandleNote

                    mov.w A, $03C1
                    call KeyOnSoundEffects

                    .setup_pitch_slide

                    mov.w X, $03C0

                    mov.w A, $03B1+X : mov.w $03B0+X, A

                    .do_pitch_slide
                    
                    clr7.b $13

                    mov.w X, $03C0
                    mov.b A, $A0+X : beq .no_pitch_slide
                        call PitchSlideSFX

                        bra .dont_key_off

                    .no_pitch_slide

                    mov.b A, #$02 : cmp.w A, $03B0+X : bne .dont_key_off
                        mov.w A, $03C1
                        mov.b Y, #KOFF
                        call WriteToDSP

                    .dont_key_off

                    mov.w X, $03C0
                    mov.b A, $2D : mov.w $0391+X, A
                    mov.b A, $2C : mov.w $0390+X, A

                    mov.w A, $03C1 : and.w A, $03CF : bne .on_SFX_1
                        mov.w A, $03C1 : and.w A, $03CB : bne .on_SFX_2
                            jmp Handle_SFX3_to_next_channel

                    .on_SFX_1

                    jmp Handle_SFX1_to_next_channel

                    .on_SFX_2
                    
                    jmp Handle_SFX2_to_next_channel

            .pitch_slide_command

            mov.b X, #$00
            incw.b $2C
            mov.b A, ($2C+X)

            mov.w X, $03C0 : mov.b $44, X

            mov Y, A
            call HandleNote

            mov.w A, $03C1
            call KeyOnSoundEffects

            .pitch_slide_to_command
            
            mov.b X, #$00
            incw.b $2C
            mov.b A, ($2C+X)

            mov.w X, $03C0
            mov.b $A1+X, A

            mov.b X, #$00

            incw.b $2C
            mov.b A, ($2C+X)

            mov.w X, $03C0
            mov.b $A0+X, A
            push A

            mov.b X, #$00
            incw.b $2C
            mov.b A, ($2C+X)

            pop Y

            mov.w X, $03C0 : mov.b $44, X

            call PitchSlide_calc_frames

            jmp .setup_pitch_slide

            .change_instrument

            mov.b X, #$00
            incw.b $2C
            mov.b A, ($2C+X)
            mov.b Y, #$09
            mul YA : mov X, A

            mov.w Y, $03C2

            mov.b $12, #$08

            .write_loop
                mov.w A, INSTRUMENT_DATA_SFX+X
                call WriteToDSP

                inc X
                inc Y
            dbnz.b $12, .write_loop

            mov.w A, INSTRUMENT_DATA_SFX+X

            mov.w Y, $03C0
            mov.w $0221+Y, A

            mov.b A, #$00 : mov.w $0220+Y, A

            jmp .next_byte
    }

    ; ==========================================================================

    ; SPC $1776-$178F JUMP LOCATION
    ; $0D0B44-$0D0B5D DATA
    PitchSlideSFX:
    {
        set7.b $13

        mov.b A, #$0360>>0
        mov.b Y, #$0360>>8

        dec.b $A0+X
        call IncrementSlide_quiet

        mov.w A, $0361+X : mov Y, A
        mov.w A, $0360+X : movw.b $10, YA

        mov.b $47, #$00
        jmp HandleNote_external
    }

    ; ==========================================================================

    ; SPC $1790-$179D JUMP LOCATION
    ; $0D0B5E-$0D0B6B DATA
    KeyOnSoundEffects:
    {
        push A

        mov.b Y, #KOFF
        mov.b A, #$00
        call WriteToDSP

        pop A
        mov.b Y, #KON

        jmp WriteToDSP
    }

    ; ==========================================================================

    base off

    arch 65816
}

; ==============================================================================

warnpc $1A8000