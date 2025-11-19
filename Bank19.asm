; ==============================================================================

; Bank 0x19
; $0C8000-$0CFFFF
org $198000

; The instrument brr samples
; The first half of the SPC engine

; ==============================================================================

SPC_ENGINE          = $0800
SF_DATA             = $17C0
CREDITS_AUX_POINTER = $2900
SONG_POINTERS_AUX   = $2B00
SAMPLE_POINTERS     = $3C00
INSTRUMENT_DATA     = $3D00
INSTRUMENT_DATA_SFX = $3E00
SAMPLE_DATA         = $4000
SONG_POINTERS       = $D000

; ==============================================================================

; $0C8000-$0C8073 DATA
SongBank_Intro_Main:
SamplePointers:
{
    ; Transfer size, transfer address
    dw .end-SAMPLE_POINTERS, SAMPLE_POINTERS

    ; SPC $3C00-$3C6F DATA
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

    .end

    base off
}

; ==============================================================================

; $0C8074-$0CFB17 DATA
BRRSampleData:
{
    ; Transfer size, transfer address
    dw .end-SAMPLE_DATA, SAMPLE_DATA

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

    .end

    base off
}

; ==============================================================================

; $0CFB18-$0CFBC9 DATA
InstrumentData:
{
    ; Transfer size, transfer address
    dw .end-INSTRUMENT_DATA, INSTRUMENT_DATA

    ; SPC $3D00-$3DAD DATA
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

    InstrumentData_end:

    base off
}

; ==============================================================================

; $0CFBCA-$0D0B6B DATA
SPCEngine:
{
    ; Transfer size, transfer address
    dw SPCEngine_end-SPC_ENGINE, SPC_ENGINE

    ; ==========================================================================

    arch SPC700

    ; SPC $0800-$179D
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

        ; Clear $0000-$00DF in ARAM.
        ; TODO: Why not $E0-$EF?
        mov.b A, #$00 : mov X, A

        .zeroing_loop_1

            mov (X+), A
        cmp.b X, #$E0 : bne .zeroing_loop_1

        ; TODO: Why not $0100 to $01FF?

        mov.b X, #$00

        ; Clear $0200-$02FF in ARAM.
        .zeroing_loop_2

            mov.w $0200+X, A
        inc X : bne .zeroing_loop_2

        ; OPTIMIZE: This could have been done at the same time as the other loop.
        ; Clear $0300-$03FF in ARAM.
        .zeroing_loop_3

            mov.w $0300+X, A
        inc X : bne .zeroing_loop_3

        ; A = 1
        inc A
        call ConfigureEcho

        ; Disable echo buffer writes.
        set5.b $48

        ; Set the left main volume.
        mov.b A, #$60
        mov.b Y, #DSP.MVOLL
        call WriteToDSP

        ; Set the right main volume.
        mov.b Y, #DSP.MVOLR
        call WriteToDSP

        ; Tell the DSP the high byte of where the BRR samples are.
        mov.b A, #SAMPLE_POINTERS>>8
        mov.b Y, #DSP.DIR
        call WriteToDSP

        ; Set $FFC0 to ROM, clear ports 0123, stop timer 0.
        mov.b A, #$F0 : mov.w SMP.CONTROL, A

        ; Set the timer 0 target and the tempo.
        mov.b A, #$10 : mov.w SMP.T0TARGET, A
                        mov.b $53, A

        ; Start timer 0.
        mov.b A, #$01 : mov.w SMP.CONTROL, A

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0844-$08E2 JUMP LOCATION
    ; $0CFC12-$0CFCB0 DATA
    Engine_Main:
    {
        ; Check 0x0A register "queues" to see if we need to send any updates
        ; to the DSP. DSP.KOFF is written to twice, once from its queue at $46
        ; and another time from $0E which is always 0.
        mov.b Y, #$0A

        .next_register

            ; Always update the DSP.FLG register.
            cmp.b Y, #$05 : beq .FLG_register
                bcs .not_echo_register
                    ; If it is an echo register, don't update it if there
                    ; is not a different echo delay.
                    cmp.b $4C, $4D : bne .skip

            .FLG_register

            ; If bit 7 is set in the echo timer, don't update the
            ; DSP.FLG register or any of the echo registers.
            bbs7.b $4C, .skip
                .not_echo_register

                ; Choose the DSP register to write to.
                mov.w A, RegisterList-1+Y : mov.w SMP.DSPADDR, A

                ; Choose the RAM value to get the value we will write to the
                ; DSP register.
                mov.w A, LoadValueFrom-1+Y : mov X, A
                mov A, (X) : mov.w SMP.DSPDATA, A

            .skip
        dbnz Y, .next_register

        ; Set both the key on and key off queues to 0.
        mov.b $45, Y
        mov.b $46, Y

        ; OPTIMIZE: Do a bunch of math that seemingly has not impact on
        ; anything else. $18 and $19 seem to be junk.
        mov.b A, $18 : eor.b A, $19 : lsr A : lsr A
        notc : ror.b $18 : ror.b $19

        .timer_wait

            ; Wait for SMP timer 0 to not be 0.
        mov.w Y, SMP.T0OUT : beq .timer_wait

        push Y

        ; SMP.T0OUT * #$38
        ; If the result added is greater than 0xFF, we need to take new SFX
        ; and ambient input from the 5A22 and handle the current ambient/SFX.
        mov.b A, #$38
        mul YA : clrc : adc.b A, $43 : mov.b $43, A
                                       bcc .wait_for_SFX
            call Handle_AmbientAndSFX
            call HandleInput_Ambient

            ; Check for new Ambient input.
            mov.b X, #$01
            call Synchronize

            call Handle_SFX2
            call HandleInput_SFX2

            ; Check for new SFX2 input.
            mov.b X, #$02
            call Synchronize

            call Handle_SFX3
            call HandleInput_SFX3

            ; Check for new SFX3 input.
            mov.b X, #$03
            call Synchronize

            cmp.b $4C, $4D : beq .wait_for_SFX
                ; Every other frame:
                inc.w $03C7
                mov.w A, $03C7 : lsr A : bcs .wait_for_SFX
                    ; Incrament the echo timer.
                    inc.b $4C

        .wait_for_SFX

        ; SMP.T0OUT * Tempo
        ; If the result added is greater than 0xFF, we need to take new song
        ; input from the 5A22 and handle the current song.
        mov.b A, $53
        pop Y
        mul YA
        clrc : adc.b A, $51 : mov.b $51, A
                              bcc .ignore_tracker
            ; TODO: Verify.
            ; Handle the next note in the current song.
            call HandleInput_Song

            ; Check for new song input.
            mov.b X, #$00
            call Synchronize

            ; TODO: I think this means that we always skip the "fancy" effects
            ; on the first frame of the note.
            jmp Engine_Main

        .ignore_tracker

        ; Are we currently playing a song?
        mov.b A, $04 : beq .no_song
            mov.b X, #$00
            mov.b $47, #$01

            .next_track

                ; Is this channel enabled?
                mov.b A, $31+X : beq .skip_voice
                    ; If so, even though we haven't hit the next note, we still
                    ; need to handle the special effects like tremelo, vibrato,
                    ; pitch slides and echo.
                    call BackgroundTasks

                .skip_voice

                inc X : inc X
            ; TODO: Verify.
            ; Go until we find a channel that is disabled.
            asl.b $47 : bne .next_track

        .no_song

        jmp Engine_Main
    }

    ; ==========================================================================

    ; SPC $08E3-$0901 JUMP LOCATION
    ; $0CFCB1-$0CFCCF DATA
    Synchronize:
    {
        ; Tell the 5A22 the current song or SFX being played.
        mov.b A, $04+X : mov.w SMP.CPUIO0+X, A

        .wait

            ; Just in case the 5A22 was in the process of writing a new song
            ; or SFX to the APU, check it again to make sure it didn't change.
            mov.w A, SMP.CPUIO0+X
        cmp.w A, SMP.CPUIO0+X : bne .wait

        ; OPTIMIZE: Useless branch.
        mov Y, A : bne .dumb

        .dumb

        ; Check if we are already playing that same song/SFX.
        mov.b A, $08+X
        mov.b $08+X, Y : cbne.b $08+X, .change
            ; If we are playing the same thing, don't play it again.
            mov.b Y, #$00 : mov.b $00+X, Y

            ret

        .change

        ; Set the input song or SFX to the new song/SFX from the 5A22.
        mov.b $00+X, Y

        ; SPC $0901 ALTERNATE ENTRY POINT
        ; $0CFCCF DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; Input:
    ; Y - The note or command
    ; X - The channel
    ; SPC $0902-$096B JUMP LOCATION
    ; $0CFCD0-$0CFD39 DATA
    HandleNote:
    {
        ; Check if the note is a percussion hit:
        cmp.b Y, #$CA : bcc .not_percussion
            call TrackCommand_E0_ChangeInstrument

            mov.b Y, #$A4 ; Note C4

        .not_percussion

        ; Check if the note is a tie:
        cmp.b Y, #$C8 : bcs Synchronize_exit
            mov.b A, $1A : and.b A, $47 : bne Synchronize_exit
                ; Apply the global transposition and the channel transposition
                ; to the note:
                mov A, Y : and.b A, #$7F : clrc : adc.b A, $50
                clrc : adc.w A, $02F0+X : mov.w $0361+X, A

                ; Get the current channel tuning and apply it to the channel
                ; pitch calculation.
                mov.w A, $0381+X : mov.w $0360+X, A

                ; Move the lowest bit of the channel gradient wait into the
                ; carry flag.
                mov.w A, $02B1+X : lsr A

                ; Move the carry flag into the highest bit.
                mov.b A, #$00 : ror A : mov.w $02A0+X, A

                ; Reset some channel vibrato and tremelo settings.
                mov.b A, #$00 : mov.b $B0+X, A
                                mov.w $0100+X, A
                                mov.w $02D0+X, A
                                mov.b $C0+X, A

                ; Enable pitch slide and key on queue for used channels.
                or.b $5E, $47
                or.b $45, $47

                ; Get the current channel's pitch slide timer.
                mov.w A, $0280+X : mov.b $A0+X, A
                                   beq .no_pitch_slide
                    ; TODO: The descriptions of these ram values are bad.
                    ; idk what this does.
                    mov.w A, $0281+X : mov.b $A1+X, A

                    ; Get the slide type. 0 for slide from and 1 for slide to.
                    mov.w A, $0290+X : bne .do_slide_to
                        ; Slide from.
                        mov.w A, $0361+X
                        setc : sbc.w A, $0291+X : mov.w $0361+X, A

                    .do_slide_to

                    ; Perform the slide calculation.
                    mov.w A, $0291+X : clrc : adc.w A, $0361+X
                    call TrackCommand_F9_SlideOnce_calc_frames

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

        ; Get the final pitch value after pitch slide, global transposition, and
        ; channel transpositions are applied.
        mov.b A, $11 : setc : sbc.b A, #$34 : bcs .high_note
            mov.b A, $11 : setc : sbc.b A, #$13 : bcs .middle_note
                dec Y
                asl A

        .high_note

        addw.b YA, $10 : movw.b $10, YA

        .middle_note

        push X

        ; TODO: Do a lot of math I don't understand.
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

        ; Apply some instrument level tuning.
        mov.w A, $0220+X
        mov.b Y, $15
        mul YA : movw.b $16, YA

        mov.w A, $0220+X
        mov.b Y, $14
        mul YA : push Y

        mov.w A, $0221+X
        mov.b Y, $14
        mul YA : addw.b YA, $16 : movw.b $16, YA

        mov.w A, $0221+X
        mov.b Y, $15
        mul YA : mov Y, A

        pop A : addw.b YA, $16 : movw.b $16, YA

        ; TODO: Figure out what DSP register ends up getting written to here.
        mov A, X : xcn A : lsr A : or.b A, #$02 : mov Y, A
        mov.b A, $16
        call WriteToDSP_Checked

        ; Setup the nexxt DSP write.
        inc Y
        mov.b A, $17

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; Writes value A to DSP register Y if the channel is enabled.
    ; SPC $09EF-$09F6 JUMP LOCATION
    ; $0CFDBD-$0CFDC4 DATA
    WriteToDSP_Checked:
    {
        push A

        ; Check if any channels are enabled.
        mov.b A, $47 : and.b A, $1A

        pop A

        ; Only go to write if no channels are enabled.
        bne WriteToDSP_exit
            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; Writes value A to DSP register Y.
    ; SPC $09F7-$09FD JUMP LOCATION
    ; $0CFDC5-$0CFDCB DATA
    WriteToDSP:
    {
        mov.w SMP.DSPADDR, Y
        mov.w SMP.DSPDATA, A

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
        ; Set the left and right echo volumes to 0.
        mov.b A, #$00
        mov.b Y, #DSP.EVOLL
        call WriteToDSP

        ; OPTIMIZE: We don't need to set A again.
        mov.b A, #$00
        mov.b Y, #DSP.EVOLR
        call WriteToDSP

        ; Turn off all channels.
        mov.b A, #$FF
        mov.b Y, #DSP.KOFF
        call WriteToDSP

        ; Transfer the new data block.
        call Data_Loader

        ; Stop all music, ambient, and SFX playing.
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
        ; Set the global volume and music fade timers.
        mov.b X, #$80 : mov.b $5A, X
                        mov.w $03CA, X

        ; Set the global volume fade target.
        mov.b A, #$00 : mov.b $5B, A

        ; Set the value that will be subtracted from the volume every time the
        ; fade timer hits 0.
        setc : sbc.b A, $59
        call MakeFraction : movw.b $5C, YA

        ; Go to the usual song handling.
        jmp HandleInput_Song_run_song
    }

    ; ==========================================================================

    ; SPC $0A3F-$0A4F JUMP LOCATION
    ; $0CFE0D-$0CFE1D DATA
    SongCommand_F2_HalfVolume:
    {
        ; Don't set the volume to half if the volume has already been modified.
        mov.w A, $03E1 : bne SongCommand_F3_MaxVolume_exit
            ; Cache the global volume.
            mov.b A, $59 : mov.w $03E1, A

            ; Set the volume to half.
            mov.b A, #$70 : mov.b $59, A

            ; Go to the usual song handling.
            jmp HandleInput_Song_run_song
    }

    ; ==========================================================================

    ; SPC $0A4E-$0A62 JUMP LOCATION
    ; $0CFE1E-$0CFE30 DATA
    SongCommand_F3_MaxVolume:
    {
        ; Only set the volume to full if the cached value is not 0.
        mov.w A, $03E1 : beq .exit
            ; Set the global volume back to the cached value.
            mov.w A, $03E1 : mov.b $59, A

            ; Reset the cache.
            mov.b A, #$00 : mov.w $03E1, A

            ; Go to the usual song handling.
            jmp HandleInput_Song_run_song

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
                            bra Music_ChangeSong
    }

    ; ==========================================================================

    ; SPC $0A79-$0A80 JUMP LOCATION
    ; $0CFE47-$0CFE4E DATA
    PerformFadeout:
    {
        ; Decrement the music fade timer.
        dec.w $03CA

        ; Check if the timer is 0:
        beq SongCommand_F0_Mute
            jmp HandleInput_Song_dont_fade_out
    }

    ; ==========================================================================

    ; SPC $0A81-$0A8E JUMP LOCATION
    ; $0CFE4F-$0CFE5C DATA
    SongCommand_F0_Mute:
    {
        ; Set the channels that are being used to key off.
        mov.b A, $1A : eor.b A, #$FF : tset.w $0046, A

        ; Set the current song to 0.
        mov.b $04, #$00

        ; TODO: I don't understand what $47 does.
        mov.b $47, #$00

        ret
    }

    ; ==========================================================================

    ; Input:
    ; $40 - The pointer to current song's segments.
    ; SPC $0A8F-$0A9C JUMP LOCATION
    ; $0CFE5D-$0CFE6A DATA
    GetNextSegment:
    {
        ; Thers no mov.b A, ($dp) with out a +X or +Y so just set Y to 0.
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

    ; Input:
    ; A - The song to play.
    ; Starts a new song from the input.
    ; SPC $0A9D-$0ABD JUMP LOCATION
    ; $0CFE6B-$0CFE8B DATA
    Music_ChangeSong:
    {
        clrc

        ; Set the music fade out timer and volume cache to 0.
        mov.b X, #$00 : mov.w $03CA, X
                        mov.w $03E1, X

        ; Set the current song.
        mov.b $04, A

        ; Get the song pointer and set it to the current song segment.
        asl A : mov X, A
        mov.w A, SONG_POINTERS-1+X : mov Y, A
        mov.w A, SONG_POINTERS-2+X : movw.b $40, YA

        ; Set the pre start song delay.
        mov.b $0C, #$02

        ; SPC $0AB6 ALTERNATE ENTRY POINT
        ; $0CFE84 DATA
        .key_off

        ; Set the channels that are being used to key off.
        mov.b A, $1A : eor.b A, #$FF : tset.w $0046, A

        ret
    }

    ; ==========================================================================

    ; This function is run while the pre start song delay is non-0.
    ; SPC $0ABE-$0AF8 JUMP LOCATION
    ; $0CFE8C-$0CFEC6 DATA
    EngineStartDelay:
    {
        mov.b X, #$0E
        mov.b $47, #$80

        ; Loop through each channel.
        .next_channel

            ; Set the channel volume to full.
            mov.b A, #$FF : mov.w $0301+X, A

            ; Set the current channel pan settings to equal on both sides.
            mov.b A, #$0A
            call TrackCommand_E1_ChangePan

            ; A will be 0 after the call above.
            ; Set a bunch of channel specific settings to 0. Instrument ID,
            ; tuning, transposition, pitch slide timer, mute settings, vibrato
            ; intensity, and tremolo intensity.
            mov.w $0211+X, A
            mov.w $0381+X, A
            mov.w $02F0+X, A
            mov.w $0280+X, A
            mov.w $03FF+X, A
            mov.b $B1+X, A
            mov.b $C1+X, A

            dec X : dec X
        lsr.b $47 : bne .next_channel

        ; A will be 0 after the loop above.
        ; Set a bunch of channel specific settings to 0. Global volume slide
        ; timer, echo pan timer, tempo sweep timer, global transposition,
        ; the segment loop counter, and the precussion command.
        mov.b $5A, A
        mov.b $68, A
        mov.b $54, A
        mov.b $50, A
        mov.b $42, A
        mov.b $5F, A

        ; Set the global volume and tempo.
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
        ; Check if we have been sent a new song command from the 5A22.
        mov.b A, $00 : beq .no_new_song
            ; If we have been sent a new song to play or command, go set that up:
            jmp Song_Commands

        .no_new_song

        ; SPC $0B00 ALTERNATE ENTRY POINT
        ; $0CFECE DATA
        .run_song

        ; If there is no current song, do nothing.
        mov.b A, $04 : beq EngineStartDelay_exit
            ; Check the music fade timer:
            mov.w A, $03CA : beq .dont_fade_out
                ; If the fade out timer is not 0, perform the fade.
                jmp PerformFadeout

            .dont_fade_out

            ; Check if there is a music start delay:
            mov.b A, $0C : beq .no_delay
                dbnz.b $0C, EngineStartDelay
                    ; On the first frame of no delay:

                    .setupSegmentLoop

                                ; Get the current segment pointer:
                                call GetNextSegment : bne .valid_pointer
                                    ; Handle and invalid pointer:

                                    mov Y, A : bne .valid_command
                                        ; If not a valid command, mute the song.
                                        jmp SongCommand_F0_Mute

                                    .valid_command

                                    ; TODO: Also mute the song if #$80?
                                    ; Investigate.
                                    cmp.b A, #$80 : beq .disable_dsp
                                        ; TODO: If not #$81 set the number of
                                        ; setup segment loops?
                                        cmp.b A, #$81 : bne .set_num_loops
                                            mov.b A, #$00

                                    .disable_dsp

                                    mov.b $1B, A
                            bra .setupSegmentLoop

                            .set_num_loops

                            ; Decrement the number of setup segment loops and see 
                            ; if a loop is still in progress.
                            dec.b $42 : bpl .loop_in_progress
                                ; Set the number of setup segment loops.
                                mov.b $42, A

                            .loop_in_progress

                            call GetNextSegment
                        mov.b X, $42 : beq .setupSegmentLoop

                        movw.b $40, YA
                    bra .setupSegmentLoop

                    .valid_pointer

                    movw.b $16, YA
                    mov.b Y, #$0F

                    ; Load the track pointer for each channel:
                    .load_pattern_table_loop

                        mov.b A, ($16)+Y : mov.w $0030+Y, A
                    dec Y : bpl .load_pattern_table_loop

                    mov.b X, #$00
                    mov.b $47, #$01

                    .initChannelLoop

                        ; If the track pointer is 0:
                        mov.b A, $31+X : beq .dont_make_noise
                            ; If the track instrument is 0:
                            mov.w A, $0211+X : bne .dont_make_noise
                                ; Setup the instrument as having none.
                                mov.b A, #$00
                                call TrackCommand_E0_ChangeInstrument

                        .dont_make_noise

                        ; Set the channel part loop counter, channel volume slide
                        ; timer, and channel pan timer to 0.
                        mov.b A, #$00 : mov.b $80+X, A
                                        mov.b $90+X, A
                                        mov.b $91+X, A

                        ; Set the channel duration to 1.
                        inc A : mov.b $70+X, A

                        inc X : inc X
                    ; Loop through each channel starting with channel 0.
                    asl.b $47 bne .initChannelLoop

            .no_delay

            ; Disable all pitch slides.
            mov.b X, #$00 : mov.b $5E, X

            mov.b $47, #$01

            .loop_2

                ; Cache the channel offset.
                mov.b $44, X

                ; If the channel's pointer is 0, skip the channel.
                mov.b A, $31+X : beq .silentChannel
                    ; If the channel duration is 0, skip it because the current
                    ; note is still being played.
                    dec.b $70+X : bne .stillPlayingNote
                        .readNextByte_AfterCommand
                            .readNextByte_AfterReturn
                                .readNextByte_AfterEnd

                                    ; Check if we are hitting an end part or end
                                    ; segment #$00 byte.
                                    call GetTrackByte : bne .notEndByte
                                        ; If we do not need to loop the current 
                                        ; part, that means the #$00 byte came from 
                                        ; the end of the current segment and we 
                                        ; need to move on to the next one.
                                        mov.b A, $80+X : beq .setupSegmentLoop
                                            ; If the segment counter was non-0, 
                                            ; that means the #$00 came from the 
                                            ; end of a part and we need to repeat
                                            ; the part.
                                            call IteratePartLoop
                                            
                                ; Decrease the amount of times we need to loop
                                ; the current part. If 0, instantly go to the
                                ; next byte.
                                dec.b $80+X : bne .readNextByte_AfterEnd

                                ; If 0, move on to the next byte instead of looping
                                ; the part again.

                                ; Get the return address for the part.
                                mov.w A, $0230+X : mov.b $30+X, A
                                mov.w A, $0231+X : mov.b $31+X, A

                                ; Instantly go to the next byte.
                            bra .readNextByte_AfterReturn

                            .notEndByte

                            ; #$80 and greater are notes or commands.
                            bmi .note_or_command
                                ; Set the channel note duration reset value.
                                mov.w $0200+X, A

                                ; Instantly go to the next byte.
                                ; #$80 and greater are notes or commands.
                                call GetTrackByte : bmi .note_or_command
                                    ; NOTE: Because this is in a nested if, that 
                                    ; means the only way to set the stacc and 
                                    ; attack is by doing it after setting the
                                    ; note duration.
                                    
                                    push A

                                    ; TODO: What is stacc?
                                    ; Use bits 4-6 as the index to get the note
                                    ; stacc.
                                    xcn A : and.b A, #$07 : mov Y, A
                                    mov.w A, NoteStacc+Y : mov.w $0201+X, A

                                    ; Use bits 0-3 as the index to get the note
                                    ; attack.
                                    pop A : and.b A, #$0F : mov Y, A
                                    mov.w A, NoteAttack+Y : mov.w $0210+X, A

                                    call GetTrackByte

                                    ; NOTE: We always assume the next byte is a 
                                    ; note or command.

                            .note_or_command
                        ; Check if we are playing a note or executing a command:
                        ; Everything #$80 to #$DF is a note.
                        cmp.b A, #$E0 : bcc .note
                            call ExecuteCommand

                            bra .readNextByte_AfterCommand

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

                    .stillPlayingNote

                    mov.b A, $1B : bne .next_channel_2
                        call Tracker

                        .continue
                        call PitchSlide

                    .next_channel_2
                .silentChannel

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
        ; Get the pointer for the command. The address is -0xC0 from the actual
        ; address of the command vectors because the commands index start at 0xC0.
        asl A : mov Y, A
        mov.w A, TrackCommand_Vectors+1-$C0+Y : push A
        mov.w A, TrackCommand_Vectors+0-$C0+Y : push A

        ; OPTIMIZE: Why not just push a earlier and then pop Y?
        mov A, Y : lsr A : mov Y, A

        ; Get the number of parameters the command has from a table. The address
        ; is -0x60 for the same reason as above but divided by 2.
        ; If there is at least one parameter, load the first one and then after
        ; a ret is hit, it will return to given TrackCommand_Vectors instead.
        mov.w A, TrackCommandParamCount-$60+Y : beq .NoParameters
            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C4A-$0C5D JUMP LOCATION
    ; $0D002A-$0D002B DATA
    GetTrackByte:
    {
        ; Get the current channel track pointer.
        mov.b A, ($30+X)

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C5E-$0C63 JUMP LOCATION
    ; $0D002C-$0D0031 DATA
    SkipTrackByte:
    {
        ; Increase the track pointer to the next byte.
        inc.b $30+X : bne .dontIncramentHigh
            inc.b $31+X

        .dontIncramentHigh

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0C64-$0C65 JUMP LOCATION
    ; $0D0032-$0D0033 DATA
    ExecuteCommand_NoParameters:
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

                mov.w SMP.DSPADDR, X
                mov.w SMP.DSPDATA, A

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
        ; Set the current channel pan settings.
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
        ; Set the current channel pointer to the start of the channel's
        ; subroutine part address.
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

        mov.b Y, #DSP.FIR0

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
        mov.b Y, #DSP.EDL : mov.w SMP.DSPADDR, Y

        mov.w A, SMP.DSPDATA : cmp.b A, $4D : beq .edl_same
            and.b A, #$0F : eor.b A, #$FF : bbc7.b $4C, .buffer_ready
                clrc : adc.b A, $4C

            .buffer_ready

            mov.b $4C, A
            mov.b Y, #$04

            .write_register

                mov.w A, RegisterList-1+Y : mov.w SMP.DSPADDR, A

                mov.b A, #$00 : mov.w SMP.DSPDATA, A
            dbnz Y, .write_register

            mov.b A, $48 : or.b A, #$20
            mov.b Y, #DSP.FLG
            call WriteToDSP

            mov.b A, $4D
            mov.b Y, #DSP.EDL
            call WriteToDSP

        .edl_same

        asl A : asl A : asl A : eor.b A, #$FF
        setc : adc.b A, #SONG_POINTERS>>8
        mov.b Y, #DSP.ESA
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

    ; UNUSED: Doesn't appear to be referenced anywhere.
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

        jmp Music_ChangeSong_key_off
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
        ; Set the channel pitch delay.
        mov.b $A1+X, A

        ; Get the next track byte and store it into the channel pitch timer.
        call GetTrackByte : mov.b $A0+X, A

        ; Get the next track byte, add the global transposition, and the
        ; channel transposition.
        call GetTrackByte : clrc : adc.b A, $50 : adc.w A, $02F0+X

        ; SPC $0EAB ALTERNATE ENTRY POINT
        ; $0D0279 DATA
        .calc_frames

        ; TODO: Do some math I don't understand.
        and.b A, #$7F : mov.w $0380+X, A
        setc : sbc.w A, $0361+X

        mov.b Y, $A0+X
        
        ; Theres no mov X, Y, so use the stack instead.
        push Y : pop X

        ; TODO: Do some math I don't understand.
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
            ; * -1
            eor.b A, #$FF : inc A

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

    ; TODO: Come back to this and document it.
    ; Input:
    ; X The channel number.
    ; $10[0x02] the pan setting.
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
            mov.b Y, #DSP.KOFF
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
                
                ; There is no Absolute indexed by X variant of inc, so we have to
                ; switch the page for a second.
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

        ; Bleeds into the next function.
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
        db DSP.EVOLL
        db DSP.EVOLR
        db DSP.EFB
        db DSP.EON
        db DSP.FLG
        db DSP.KON
        db DSP.KOFF
        db DSP.NON
        db DSP.PMON
        db DSP.KOFF
    }

    ; SPC $11B7-$11C0 DATA
    ; $0D0585-$0D058E DATA
    LoadValueFrom:
    {
        db $61 ; DSP.EVOLL
        db $63 ; DSP.EVOLR
        db $4E ; DSP.EFB
        db $4A ; DSP.EON
        db $48 ; DSP.FLG
        db $45 ; DSP.KON
        db $0E ; DSP.KOFF
        db $49 ; DSP.NON
        db $4B ; DSP.PMON
        db $46 ; DSP.KOFF
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

    ; This is similar to the SMP boot ROM. Its purpose to communicate with the
    ; 5A22 when transmitting new song banks.
    ; SPC $11E6-$1231 JUMP LOCATION
    ; $0D05B4-$0D05FF DATA
    Data_Loader:
    {
        ; Tell the 5A22 we are ready for a transfer.
        mov.b A, #$AA : mov.w SMP.CPUIO0, A
        mov.b A, #$BB : mov.w SMP.CPUIO1, A

        .wait_data_start

            ; Wait for the 5A22 to reply back.
        mov.w A, SMP.CPUIO0 : cmp.b A, #$CC : bne .wait_data_start

        bra .begin_transfer

        .loop

                ; Wait for the 5A22 to reply with #$00 to use as the starting
                ; address.
                mov.w Y, SMP.CPUIO0
            bne .loop

            .reread

                ; Check if the 5A22 has updated the index yet.
                cmp.w Y, SMP.CPUIO0 : bne .indexDoesntMatch
                    ; If it has update the index, grab the next byte and
                    ; store it.

                    ; Grab the next byte.
                    mov.w A, SMP.CPUIO1

                    ; Send the index back to the 5A22 to let it know its been
                    ; recieved.
                    mov.w SMP.CPUIO0, Y

                    ; Store the byte to the set ARAM adress.
                    mov.b ($14)+Y, A

                    ; Increase the address high byte if need be.
                    inc Y : bne .reread
                        inc.b $15

                        bra .reread

                .indexDoesntMatch

                bpl .reread

            ; If "next byte/end" is more than the expected next byte index,
            ; drop back into the main loop.
            cmp.w Y, SMP.CPUIO0 : bpl .reread

            .begin_transfer

            ; This will be the ARAM address to transfer to.
            mov.w A, SMP.CPUIO2
            mov.w Y, SMP.CPUIO3
            movw.b $14, YA

            ; Get a byte that we need to send back to the 5A22 later.
            mov.w Y, SMP.CPUIO0

            ; Get the mode. If 0, we do not have any more data to transfer.
            mov.w A, SMP.CPUIO1

            ; Send the byte back so the 5A22 to let it know we've received the
            ; transfer address and mode.
            mov.w SMP.CPUIO0, Y
        ; See if we have another block to transfer.
        bne .loop

        ; Clear ports 0123, start timer 0.
        mov.b X, #$31 : mov.w SMP.CONTROL, X

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

            mov.b Y, #DSP.EON
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
        mov.b Y, #DSP.KOFF
        call WriteToDSP

        call ResumeMusic

        ret
    }

    ; ==========================================================================

    ; SPC $12FF-$136C JUMP LOCATION
    ; $0D06CD-$0D073A DATA
    InitAmbient:
    {
        ; Check if we are loading silence:
        mov.b $05, A : cmp.b A, #$05 : bne .notSilence
            ; Check if any of the channels are enabled for ambient sounds:
            mov.w X, $03CF : bne .initializeSilence
                ; If none of the channels are enable we don't need to do
                ; anything more.

                ret

            .initializeSilence
        .notSilence

        ; SPC $130B ALTERNATE ENTRY POINT
        ; $0D06D9 DATA
        .skipSilenceCheck

        ; Set the ambient fade timer to 0.
        mov.b X, #$00 :  mov.w $03E4, X

        ; Set the channel 7 SFX ID, delay, and pitch slide timer.
        mov.b X, #$0E
        mov.b A, $01  : mov.w $03A0+X, A
        mov.b A, #$03 : mov.w $03A1+X, A
        mov.b A, #$00 : mov.w $0280+X, A

        ; Enable the ambient sound on channel 7.
        mov.b A, #$80 : mov.w $03CF, A

        mov.b Y, #DSP.KOFF
        call WriteToDSP

        ; Mark that we are using channel 7.
        set7.b $1A

        ; Check if the ambient sound has a part 2 to play on channel 6. If
        ; we are playing the part 1, they all should have a part 2.
        mov.b X, $01
        mov.w A, Ambient_Part2-1+X : mov.b $01, A
                                      bne .also_use_chan_6
            ret

        .also_use_chan_6

        ; Set the channel 6 SFX ID, delay, and pitch slide timer.
        mov.b X, #$0C
        mov.b A, $01  : mov.w $03A0+X, A
        mov.b A, #$03 : mov.w $03A1+X, A
        mov.b A, #$00 : mov.w $0280+X, A

        ; Mark that we are using channel 6.
        set6.b $1A

        mov.b A, #$40
        mov.b Y, #DSP.KOFF
        call WriteToDSP

        ; Enable the ambient sound on channels 6 and 7.
        mov.b A, #$C0 : mov.w $03CF, A

        ; Enable echo on channels 6 and 7.
        or.w A, $03E3 : mov.w $03E3, A

        ; NOTE: Weird that this isn't done for channel 7 if we arn't using a
        ; part 2. I guess it doesn't matter since we're always using a part 2.
        ; Block SFX2 and SFX3 from playing on channels 6 and 7.
        mov.b A, #$3F : and.w A, $03CB : mov.w $03CB, A
        mov.b A, #$3F : and.w A, $03CD : mov.w $03CD, A

        ret
    }

    ; ==========================================================================

    ; SPC $136D-$1380 JUMP LOCATION
    ; $0D073B-$0D074E DATA
    HandleInput_Ambient:
    {
        ; Check the ambient input:
        mov.b A, $01 : bmi .Ambient_negative
            bne InitAmbient
                ; Return if the input is 0.
                ret

        .Ambient_negative

        ; Set the current ambient to the recieved input.
        mov.b $05, A

        ; Check if any channels are in use by an ambient sound:
        mov.w A, $03CF : beq .channels_not_used
            ; Set the ambient fade timer.
            mov.b A, #$78 : mov.w $03E4, A

        .channels_not_used

        ret
    }

    ; ==========================================================================

    ; SPC $1381-$13B6 JUMP LOCATION
    ; $0D074F-$0D0784 DATA
    Ambient_FadeHandler:
    {
        ; Decrement the ambient fade timer.
        dec.w $03E4
        mov.w A, $03E4 : bne .still_fading
            ; Change the ambient sound to silence.
            mov.b A, #$05 :  mov.b $01, A
            call InitAmbient_skipSilenceCheck

            mov.b A, #$00 : mov.b $01, A

            ret

        .still_fading

        ; Set the right and left volumes of channels 6 and 7.
        lsr A : mov.w $03E5, A
        mov.b Y, #DSP.V7VOLL
        call WriteToDSP

        ; OPTIMIZE: We don't need to be reloading $03E5 into A every time.
        inc Y ; DSP.V7VOLR
        mov.w A, $03E5
        call WriteToDSP

        mov.b Y, #DSP.V6VOLL
        mov.w A, $03E5
        call WriteToDSP

        inc Y ; DSP.V6VOLR
        mov.w A, $03E5
        call WriteToDSP

        ; Go back to the function we came from.
        jmp Handle_AmbientAndSFX_no_fadeout
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
            mov.b Y, #DSP.KOFF
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
            mov.b Y, #DSP.KOFF
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
    Handle_AmbientAndSFX:
    {
        ; If the ambient fade timer is not 0:
        mov.w A, $03E4 : beq .no_fadeout
            jmp Ambient_FadeHandler

        ; SPC $144D ALTERNATE ENTRY POINT
        ; $0D081B DATA
        .no_fadeout

        ; Check which channels the ambient sounds are using. If none, move on.
        mov.w A, $03CF : mov.w $03E0, A
                         beq .exit
            mov.b X, #$0E

            ; Mark that the ambient sound is using channel 7.
            mov.b A, #$80 : mov.w $03C1, A

            .next_channel

                ; Shift the channels we're using until we find one that
                ; is being used.
                asl.w $03E0 : bcc .to_next_channel
                    mov.w $03C0, X
                    ; Calculate the DSP address for the channel.
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    ; Get the current channel pan setting.
                    mov.w A, $03D0+X : mov.b $20, A

                    ; Check if there is a delay to play the ambient on
                    ; this channel.
                    mov.w A, $03A1+X : bne .delayed
                        ; Check if there is a ambient currently being played on
                        ; this channel.
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                ; SPC $147C ALTERNATE ENTRY POINT
                ; $0D084A DATA
                .to_next_channel

                ; Mark that we no longer are using the current channel.
                lsr.w $03C1
            ; We only need to check channel 6 and 7.
            dec X : dec X : cmp.b X, #$0A : bpl .next_channel

        .exit

        ret

        .delayed

        mov.w $03C0, X

        ; Decrement the delay timer and check if it has hit 0 yet.
        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .timerDone
            ; If we have a delay, move on to the next channel.
            jmp .to_next_channel

        .timerDone

        ; SPC $1495 ALTERNATE ENTRY POINT
        ; $0D0863 DATA
        .initialize

        ; Get the ambient ID and then get the data pointer for that sound.
        mov.w A, $03A0+X : asl A : mov Y, A
        mov.w A, Ambient_Pointers-1+Y : mov.w $0391+X, A
                                        mov.b $2D, A
        mov.w A, Ambient_Pointers-2+Y : mov.w $0390+X, A
                                        mov.b $2C, A

        jmp SFXControl_process_byte
    }

    ; ==========================================================================

    ; SPC $14AD-$150A JUMP LOCATION
    ; $0D087B-$0D08D8 DATA
    Handle_SFX2:
    {
        ; Check if any channels are being used by A SXF2:
        mov.w A, $03CB : mov.w $03CC, A
                         beq .exit
            mov.b X, #$0E

            ; Set channel 7 as in use by SFX2.
            mov.b A, #$80 : mov.w $03C1, A

            .next_channel

                ; Shift the channels we're using until we find one that
                ; is being used.
                asl.w $03CC : bcc .to_next_channel
                    mov.w $03C0, X

                    ; Calculate the DSP address for the channel.
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    ; Get the current channel pan setting.
                    mov.w A, $03D0+X : mov.b $20, A

                    ; Check if there is a delay to play the SFX on this channel.
                    mov.w A, $03A1+X : bne .delayed
                        ; Check if there is a SFX currently being played on
                        ; this channel.
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                .to_next_channel

                ; Mark that we no longer are using the current channel.
                lsr.w $03C1
            ; Loop through each channel.
            dec X : dec X : bpl .next_channel

        .exit

        ret

        .delayed

        ; Decrement the delay timer and check if it has hit 0 yet.
        mov.w $03C0, X
        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .timerDone
            ; If we have a delay, move on to the next channel.
            jmp .to_next_channel

        .timerDone

        ; Get the SFX2 ID and then get the data pointer for that sound.
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
        ; Check if any channels are being used by A SXF3:
        mov.w A, $03CD : mov.w $03CE, A
                         beq .exit
            mov.b X, #$0E

            ; Set channel 7 as in use by SFX2.
            mov.b A, #$80 : mov.w $03C1, A

            .next_channel
                
                ; Shift the channels we're using until we find one that
                ; is being used.
                asl.w $03CE : bcc .to_next_channel
                    mov.w $03C0, X

                    ; Calculate the DSP address for the channel.
                    mov A, X : xcn A : lsr A : mov.w $03C2, A

                    ; Get the current channel pan setting.
                    mov.w A, $03D0+X : mov.b $20, A

                    ; Check if there is a delay to play the SFX on this channel.
                    mov.w A, $03A1+X : bne .delayed
                        ; Check if there is a SFX currently being played on
                        ; this channel.
                        mov.w A, $03A0+X : beq .to_next_channel
                            jmp SFXControl

                .to_next_channel

                ; Mark that we no longer are using the current channel.
                lsr.w $03C1
            dec X : dec X : bpl .next_channel

        .exit

        ret

        .delayed

        ; Decrement the delay timer and check if it has hit 0 yet.
        mov.w $03C0, X
        mov.w A, $03A1+X : dec A : mov.w $03A1+X, A
                                   beq .timerDone
            ; If we have a delay, move on to the next channel.
            jmp .to_next_channel

        .timerDone

        ; Get the SFX3 ID and then get the data pointer for that sound.
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

                mov.b Y, #DSP.EON
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
        mov.w A, $03C1 : and.w A, $03CF : bne .used_by_ambient
            mov.w A, $03C1 : and.w A, $03CB : bne .used_by_SFX_2
                call ResumeMusic
                jmp Handle_SFX3_to_next_channel

        .used_by_ambient

        call ResumeMusic
        jmp Handle_AmbientAndSFX_to_next_channel

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

        ; Get the pointer for the current SFX.
        mov.w $03C0, X
        mov.w A, $0391+X : mov Y, A
        mov.w A, $0390+X : movw.b $2C, YA

        ; Decrement the delay timer and check if it has hit 0 yet.
        mov.w A, $03B0+X : dec A : mov.w $03B0+X, A
                                   beq .timerDone
            jmp .do_pitch_slide

        .timerDone

        .next_byte

            incw.b $2C

            ; SPC $1619 ALTERNATE ENTRY POINT
            ; $0D09E7 DATA
            .process_byte

            ; OPTIMIZE: This being here, calculating the same value every loop
            ; is a little goofy.
            ; Calculate the DSP address for the channel.
            mov.w A, $03C0 : xcn A : lsr A : mov.w $03C2, A

            mov.b X, #$00

            ; Load the next byte. If it is 0, stop the sound effect.
            mov.b A, ($2C+X) : beq DisableSFX
                ; If the byte is a negative value, it is a note or a command.
                bmi .note_or_command
                    ; Store the duration for the current note.
                    mov.w Y, $03C0
                    mov.w $03B1+Y, A

                    ; Load the next byte. Check if it is a note or a command.
                    incw.b $2C
                    mov.b A, ($2C+X) : mov.b $10, A
                                       bmi .note_or_command
                        ; OPTIMIZE: We already saved the byte in $10, why do both?
                        ; Save the current byte.
                        mov X, A

                        ; Check if any channels are being used by both SFX and
                        ; Ambient sounds.
                        mov.w A, $03C1 : and.w A, $03CF : beq .ambient
                            ; If any channels are being used by both:

                            ; If the current byte is 0:
                            mov A, X : beq .zero_byte
                                ; Check if the ambient sound is fading:
                                mov.w X, $03E5 : bne .next_byte_2

                            .zero_byte
                            
                            ; OPTIMIZE: $10 is already the current byte. Why
                            ; write it again?
                            mov.b $10, A

                            ; Write the current byte to the SFX/Ambient DSP
                            ; channel address.
                            mov.w Y, $03C2
                            call WriteToDSP

                            mov.b X, #$00
                            incw.b $2C
                            ; If the next byte is positive, read it as a volume
                            ; change command.
                            mov.b A, ($2C+X) : bpl .volume_command
                                ; Save A.
                                mov X, A

                                ; Write the previous byte to the SFX/Ambient 
                                ; DSP channel address again.
                                mov.b A, $10
                                mov.w Y, $03C2 : inc Y
                                call WriteToDSP

                                ; Reload A.
                                mov A, X

                                bra .note_or_command

                            .volume_command

                            ; Write the current byte to the SFX/Ambient DSP
                            ; channel address +1.
                            mov.w Y, $03C2 : inc Y
                            call WriteToDSP

                            bra .next_byte_2

                        .ambient

                        ; Write the current byte as the volume of the current
                        ; channel.
                        mov A, X
                        mov.w X, $03C0
                        asl A : mov.w $0321+X, A

                        ; TODO: What does the setting mean?
                        ; Set the pan setting for the current channel.
                        mov.b A, #$0A : mov.w $0351+X, A

                        ; Check if pan is enabled on the left channel:
                        bbs7.b $20, .left_pan
                            ; Check if pan is enabled on the right channel:
                            bbs6.b $20, .right_pan
                                ; TODO: Check if the mov sets the Z flag.
                                ; No pan setting.
                                mov.b $11, #$0A : bne .set_pan

                        .left_pan

                        ; Left pan setting.
                        mov.b $11, #$10 : bne .set_pan
                            .right_pan

                            ; Right pan setting.
                            mov.b $11, #$04

                        .set_pan

                        mov.b $10, #$00
                        call WritePitch_external

                        mov.b X, #$00

                        .next_byte_2

                        ; Load the next byte.
                        incw.b $2C
                        mov.b A, ($2C+X)

                .note_or_command

                ; Check if the next byte is an instrument change command.
                cmp.b A, #$E0 : bne .not_instrument_change
                    jmp .change_instrument

                .not_instrument_change

                ; Check if the next byte is a slide once command.
                cmp.b A, #$F9 : beq .pitch_slide_command
                    ; Check if the next byte is a slide to command.
                    cmp.b A, #$F1 : beq .pitch_slide_to_command
                        ; Check if the next byte is a SFX loop trigger.
                        cmp.b A, #$FF : bne .not_loop
                            ; Restart the ambient or SFX.
                            mov.w X, $03C0
                            jmp Handle_AmbientAndSFX_initialize

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
                            mov.b Y, #DSP.KOFF
                            call WriteToDSP

                        .dont_key_off

                        mov.w X, $03C0
                        mov.b A, $2D : mov.w $0391+X, A
                        mov.b A, $2C : mov.w $0390+X, A

                        mov.w A, $03C1 : and.w A, $03CF : bne .ambient
                            mov.w A, $03C1 : and.w A, $03CB : bne .on_SFX_2
                                jmp Handle_SFX3_to_next_channel

                        .ambient

                        jmp Handle_AmbientAndSFX_to_next_channel

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

                call TrackCommand_F9_SlideOnce_calc_frames

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

        mov.b Y, #DSP.KOFF
        mov.b A, #$00
        call WriteToDSP

        pop A
        mov.b Y, #DSP.KON

        jmp WriteToDSP
    }

    ; ==========================================================================

    SPCEngine_end:

    base off

    arch 65816
}

; ==============================================================================

; TODO: Currently this will fail.
warnpc $1A8000