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

    ;  Start,  Loop
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

    ; The first 4 values are instrument specific DSP values and the last word
    ; is a instrument high-level tuning multiplier. All of which will be read
    ; from when an instrument change occurs.
    ; DSP.SRCN, DSP.ADSR1, DSP.ADSR2, DSP.GAIN, ChanX_TuneMult
    db $00, $FF, $E0, $B8 : dw $7004 ; 0x00 - Noise
    db $01, $FF, $E0, $B8 : dw $9007 ; 0x01 - Rain
    db $02, $FF, $E0, $B8 : dw $C009 ; 0x02 - Timpani
    db $03, $FF, $E0, $B8 : dw $0004 ; 0x03 - Square wave
    db $04, $FF, $E0, $B8 : dw $0004 ; 0x04 - Saw wave
    db $05, $FF, $E0, $B8 : dw $7004 ; 0x05 - Clink
    db $06, $FF, $E0, $B8 : dw $7004 ; 0x06 - Wobbly lead
    db $07, $FF, $E0, $B8 : dw $7004 ; 0x07 - Compound saw
    db $08, $FF, $E0, $B8 : dw $A007 ; 0x08 - Tweet
    db $09, $8F, $E9, $B8 : dw $E001 ; 0x09 - Strings A
    db $0A, $8A, $E9, $B8 : dw $E001 ; 0x0A - Strings B
    db $0B, $FF, $E0, $B8 : dw $0003 ; 0x0B - Trombone
    db $0C, $FF, $E0, $B8 : dw $A003 ; 0x0C - Cymbal
    db $0D, $FF, $E0, $B8 : dw $0001 ; 0x0D - Ocarina
    db $0E, $FF, $EF, $B8 : dw $A00E ; 0x0E - Chimes
    db $0F, $FF, $EF, $B8 : dw $0006 ; 0x0F - Harp
    db $10, $FF, $E0, $B8 : dw $D003 ; 0x10 - Splash
    db $11, $8F, $E0, $B8 : dw $0003 ; 0x11 - Trumpet
    db $12, $8F, $E0, $B8 : dw $F006 ; 0x12 - Horn
    db $13, $FD, $E0, $B8 : dw $A007 ; 0x13 - Snare A
    db $14, $FF, $E0, $B8 : dw $A007 ; 0x14 - Snare B
    db $15, $FF, $E0, $B8 : dw $D003 ; 0x15 - Choir
    db $16, $8F, $E0, $B8 : dw $0003 ; 0x16 - Flute
    db $17, $FF, $E0, $B8 : dw $C002 ; 0x17 - Oof
    db $18, $FE, $8F, $B8 : dw $F006 ; 0x18 - Piano

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
    dw SPC_ENGINE_end-SPC_ENGINE, SPC_ENGINE

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

        ; Set $FFC0 to ROM, clear ports all 5A22 input ports, and stop all timers.
        mov.b A, #$F0 : mov.w SMP.CONTROL, A

        ; Set the timer 0 target and the tempo high byte.
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
        ; This section is almost like a SMP version of NMI. Its not actually
        ; triggered by an interrupt, but it performs a similar purpose of
        ; updating hardware registers that should only be updated once a "frame".

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

                ; Get the DSP register to write to.
                mov.w A, RegisterList-1+Y : mov.w SMP.DSPADDR, A

                ; Get the RAM value to get the value we will write to the
                ; DSP register.
                mov.w A, RegisterValueFrom-1+Y : mov X, A
                mov A, (X) : mov.w SMP.DSPDATA, A

            .skip
        dbnz Y, .next_register

        ; Set both the key on and key off queues to 0 so that the DSP registers
        ; do not get written to again next frame.
        mov.b $45, Y
        mov.b $46, Y

        ; OPTIMIZE: Do a bunch of math that seemingly has no impact on
        ; anything else. $18 and $19 seem to be junk.
        mov.b A, $18 : eor.b A, $19 : lsr A : lsr A
        notc : ror.b $18 : ror.b $19

        .timer_wait

            ; Wait for SMP timer 0 to not be 0.
        mov.w Y, SMP.T0OUT : beq .timer_wait

        ; This is the end of the "NMI" section.

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
            call Get5A22Input

            call Handle_SFX2
            call HandleInput_SFX2

            ; Check for new SFX2 input.
            mov.b X, #$02
            call Get5A22Input

            call Handle_SFX3
            call HandleInput_SFX3

            ; Check for new SFX3 input.
            mov.b X, #$03
            call Get5A22Input

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
        mul YA : clrc : adc.b A, $51 : mov.b $51, A
                                       bcc .notOnTempo
            ; Handle the next note in the current song.
            call HandleInput_Song

            ; Check for new song input.
            mov.b X, #$00
            call Get5A22Input

            ; TODO: I think this means that we always skip the "fancy" effects
            ; on the first frame of the note.
            jmp Engine_Main

        .notOnTempo

        ; Are we currently playing a song?
        mov.b A, $04 : beq .no_song
            mov.b X, #$00
            mov.b $47, #$01

            .next_channel

                ; Is this channel enabled?
                mov.b A, $31+X : beq .skip_voice
                    ; If so, even though we haven't hit the next note, we still
                    ; need to handle the special effects like tremolo, vibrato,
                    ; pitch slides and echo.
                    call BackgroundTasks

                .skip_voice

                inc X : inc X
            asl.b $47 : bne .next_channel

        .no_song

        jmp Engine_Main
    }

    ; ==========================================================================

    ; SPC $08E3-$0901 JUMP LOCATION
    ; $0CFCB1-$0CFCCF DATA
    Get5A22Input:
    {
        ; Tell the 5A22 the current song or SFX being played.
        mov.b A, $04+X : mov.w SMP.CPUIO0+X, A

        .wait

            ; TODO: Verify:
            ; Just in case the 5A22 was in the process of writing a new song
            ; or SFX to the APU, check it again to make sure it didn't change.
            mov.w A, SMP.CPUIO0+X
        cmp.w A, SMP.CPUIO0+X : bne .wait

        ; OPTIMIZE: Useless branch.
        mov Y, A : bne .dumb

        .dumb

        ; Check if we are already playing the same song/SFX.
        mov.b A, $08+X
        mov.b $08+X, Y
        cbne.b $08+X, .change
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
        cmp.b Y, #$C8 : bcs Get5A22Input_exit
            ; Check if the channel is in use by the music:
            mov.b A, $1A : and.b A, $47 : bne Get5A22Input_exit
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

                ; Reset some channel vibrato and tremolo settings.
                mov.b A, #$00 : mov.b $B0+X, A
                                mov.w $0100+X, A
                                mov.w $02D0+X, A
                                mov.b $C0+X, A

                ; Mark that we are using a special effect on the current channel.
                or.b $5E, $47

                ; Enable key on queue for the current channel.
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

        ; TODO: Why?
        ; Get the pitch value after pitch slide, global transposition, and
        ; channel transpositions are applied and adjust it based on whether it
        ; is a high note, middle note, or low note.
        ; Check if the note is !E5 (the note, NOT the hex value) or higher:
        mov.b A, $11 : setc : sbc.b A, #$34 : bcs .high_note
            ; Check if the note is !G2 or higher:
            mov.b A, $11 : setc : sbc.b A, #$13 : bcs .middle_note
                ; Low note
                dec Y
                asl A

        .high_note

        ; Apply the adjustment to the pitch value if its high or low.
        addw.b YA, $10 : movw.b $10, YA

        .middle_note

        ; Save the channel index.
        push X

        ; Take the high byte of the calculated pitch value x2 and divide it by 0x18
        ; to extract the note without its octave as the remainder. X will be the
        ; octave value.
        mov.b A, $11 : asl A
        mov.b Y, #$00
        mov.b X, #$18
        div YA, X : mov X, A

        ; Get the difference between the tuning value for the note and the next
        ; note on the scale. Example: If the note is Ds, get the difference between
        ; Ds and E.
        mov.w A, NotePitchValues+1+Y : mov.b $15, A
        mov.w A, NotePitchValues+0+Y : mov.b $14, A

        mov.w A, NotePitchValues+3+Y : push A
        mov.w A, NotePitchValues+2+Y

        pop Y
        subw.b YA, $14

        ; Multiply the result of the difference by the low byte of the pitch value.
        mov.b Y, $10
        mul YA : mov A, Y

        ; Add the result to the tuning value of the original note.
        mov.b Y, #$00 : addw.b YA, $14 : mov.b $15, Y

        ; Multiply the whole pitch value by 2.
        asl A
        rol.b $15

        ; OPTIMIZE: This is done again right after the octave_loop.
        mov.b $14, A

        bra .start_octave_loop

        ; Divide the calculated pitch by 2 for every octave we need to go down
        ; starting at octave 6.
        .octave_loop

            lsr.b $15
            ror A

            inc X

            .start_octave_loop
        cmp.b X, #$06 : bne .octave_loop

        mov.b $14, A

        ; Get the channel index back.
        pop X

        ; Apply some instrument high-level tuning.
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

        ; Write to the DSP.VxPITCHL for the channel.
        mov A, X : xcn A : lsr A : or.b A, #$02 : mov Y, A
        mov.b A, $16
        call WriteToDSP_Checked

        ; Setup the next DSP write. It will be DSP.VxPITCHH for the channel.
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

        mov.b $47, #$00

        ret
    }

    ; ==========================================================================

    ; Get the current channel's next segment pointer.
    ; Input:
    ; $40 - The pointer to current song's segments.
    ; SPC $0A8F-$0A9C JUMP LOCATION
    ; $0CFE5D-$0CFE6A DATA
    GetNextSegment:
    {
        ; There is no mov.b A, ($dp) without a +X or +Y so just set Y to 0.
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
    ResetForNewSong:
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
        mov.b A, $04 : beq ResetForNewSong_exit
            ; Check the music fade timer:
            mov.w A, $03CA : beq .dont_fade_out
                ; If the fade out timer is not 0, perform the fade.
                jmp PerformFadeout

            .dont_fade_out

            ; Check if there is a music start delay:
            mov.b A, $0C : beq .no_delay
                dbnz.b $0C, ResetForNewSong
                    ; On the first frame of no delay:

                    .setupSegmentLoop

                                ; Get the pointer of the next segment and check if
                                ; it is valid:
                                call GetNextSegment : bne .valid_pointer
                                    ; Handle and invalid pointer:

                                    mov Y, A : bne .valid_command
                                        ; If not a valid command, mute the song.
                                        jmp SongCommand_F0_Mute

                                    .valid_command

                                    ; Mute all music if #$80:
                                    cmp.b A, #$80 : beq .hardMute
                                        ; If anything else, use that as the number of
                                        ; times to loop the current segment:
                                        cmp.b A, #$81 : bne .set_num_loops
                                            ; Unmute all music if #$81:
                                            mov.b A, #$00

                                    .hardMute

                                    mov.b $1B, A
                            bra .setupSegmentLoop

                            .set_num_loops

                            ; Decrement the number of setup segment loops and see 
                            ; if a loop is still in progress:
                            dec.b $42 : bpl .loop_in_progress
                                ; Set the number of setup segment loops.
                                mov.b $42, A

                            .loop_in_progress

                            ; Get the pointer of the next segment.
                            call GetNextSegment
                        mov.b X, $42 : beq .setupSegmentLoop

                        movw.b $40, YA
                    bra .setupSegmentLoop

                    .valid_pointer

                    movw.b $16, YA
                    mov.b Y, #$0F

                    ; Load the track pointer for each channel:
                    .load_poiter_table_loop

                        mov.b A, ($16)+Y : mov.w $0030+Y, A
                    dec Y : bpl .load_poiter_table_loop

                    ; Loop through each channel starting with channel 0.
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

                        ; Set the channel timer to 1.
                        inc A : mov.b $70+X, A

                        inc X : inc X
                    asl.b $47 bne .initChannelLoop

            .no_delay

            ; Disable all special effects on the current channel.
            mov.b X, #$00 : mov.b $5E, X

            ; Setup the channel bit offset for another loop.
            mov.b $47, #$01

            .loop_2

                ; Cache the channel offset.
                mov.b $44, X

                ; If the channel's pointer is 0, skip the channel.
                mov.b A, $31+X : beq .silentChannel
                    ; If the channel duration is 0, skip it because the current
                    ; note is still being played.
                    dec.b $70+X : bne .stillPlayingNote
                        ; Execute the next command or play the next note.

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
                                call GetTrackByte : bmi .notAttackStacc
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
                                    
                                .notAttackStacc

                            .note_or_command
                        ; Check if we are playing a note or executing a command:
                        ; Everything #$80 to #$DF is a note.
                        cmp.b A, #$E0 : bcc .note
                            call ExecuteCommand

                            bra .readNextByte_AfterCommand

                        .note

                        ; OPTIMIZE: The channel mute is never actually used.
                        ; Check if this channel is muted.
                        mov.w A, $03FF+X : or.b A, $1B : bne .disabled_channel
                            ; OPTIMIZE: Why not just push Y?
                            mov A, Y : push A

                            ; Check if the channel is enabled.
                            mov.b A, $47 : and.b A, $1A
                            pop A : bne .disabled_channel
                                call HandleNote

                        .disabled_channel

                        ; Set the channel timer with the channel duration.
                        mov.w A, $0200+X : mov.b $70+X, A

                        ; Get the channel attack and multiply it by the timer.
                        mov Y, A
                        mov.w A, $0201+X
                        mul YA : mov A, Y
                                 bne .non_zero
                            inc A

                        .non_zero

                        ; TODO: Figure out WTF this is.
                        ; Set the channel CMD timer.
                        mov.b $71+X, A

                        bra .continue

                    .stillPlayingNote

                    ; Check if the music is disabled.
                    mov.b A, $1B : bne .next_channel_2
                        call Tracker

                        .continue

                        call PitchSlide

                    .next_channel_2
                .silentChannel

                inc X : inc X
            ; Check if we are done with each channel.
            asl.b $47 : beq .done_with_channels
            jmp .loop_2

            .done_with_channels

            ; Check if we are performing a tempo slide.
            mov.b A, $54 : beq .no_tempo_slide
                ; Add the temp incrament to the tempo and see if the tempo
                ; timer is done.
                movw.b YA, $56 : addw.b YA, $52 : dbnz.b $54, .tempo_slide_not_done
                    ; Set the tempo to the tempo slide target.
                    movw.b YA, $54

                .tempo_slide_not_done

                movw.b $52, YA

            .no_tempo_slide

            ; Check if we are performing a echo pan.
            mov.b A, $68 : beq .no_echo_pan_slide
                ; Add the echo pan left incrament to the echo pan left queue.
                movw.b YA, $64 : addw.b YA, $60 : movw.b $60, YA

                ; Add the echo pan right incrament to the echo pan right queue.
                movw.b YA, $66 : addw.b YA, $62 : dbnz.b $68, .pan_slide_not_done
                    ; If the slide is done, set the left queue to the target value.
                    movw.b YA, $68 : movw.b $60, YA

                    ; And set the right pan queue to the right target value.
                    mov.b Y, $6A

                .pan_slide_not_done

                movw.b $62, YA

            .no_echo_pan_slide

            ; Check if we are performing a global volume slide.
            mov.b A, $5A : beq .no_volume_slide
                ; Add the global volume incrament to the global volume.
                movw.b YA, $5C
                addw.b YA, $58 : dbnz.b $5A, .volume_slide_not_done
                    ; Set the global volume to the target volume.
                    movw.b YA, $5A

                .volume_slide_not_done

                movw.b $58, YA

                ; Mark that we are using a special effect on all channels.
                mov.b $5E, #$FF

            .no_volume_slide

            ; Setup the channel bit offset for another loop.
            mov.b X, #$00
            mov.b $47, #$01

            .volume_settings_loop

                ; Check if there is an active pointer on this channel.
                mov.b A, $31+X : beq .inactive_track
                    call WritePitch

                .inactive_track

                inc X : inc X
            asl.b $47 : bne .volume_settings_loop

            ret
    }

    ; ==========================================================================

    ; SPC $0C4A-$0C5B JUMP LOCATION
    ; $0D0018-$0D0029 DATA
    ExecuteCommand:
    {
        ; Get the pointer for the command. The address is -0xC0 from the actual
        ; address of the command vectors because the commands index starts at 
        ; 0xE0. 0xE0 x2 is 0x01C0 and the 7th bit will get cut off by the asl
        ; leaving only 0xC0.
        asl A : mov Y, A
        mov.w A, TrackCommand_Vectors+1-$C0+Y : push A
        mov.w A, TrackCommand_Vectors+0-$C0+Y : push A

        ; OPTIMIZE: Why not just push A earlier and then pop Y?
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

    ; Input:
    ; A - The instrament ID to change to.
    ; X - The current channel.
    ; SPC $0C64-$0CBE JUMP LOCATION
    ; $0D0034-$0D008C DATA
    TrackCommand_E0_ChangeInstrument:
    {
        ; Set the channel's instrument ID and check if it is a precussion value:
        mov.w $0211+X, A : mov Y, A
                           bpl .no_percussion
            ; Add the precussion base note.
            setc : sbc.b A, #$CA : clrc : adc.b A, $5F

        .no_percussion

        ; Get the index for the instrument data.
        mov.b Y, #$06
        mul YA : movw.b $14, YA

        ; Get the address for the instrument data.
        clrc : adc.b $14, #INSTRUMENT_DATA>>0 : adc.b $15, #INSTRUMENT_DATA>>8

        ; Check if the current channel is being used:
        mov.b A, $1A : and.b A, $47 : bne .exit
            push X

            ; Setup X to point to DSP.VxSRCN.
            mov A, X : xcn A : lsr A : or.b A, #$04 : mov X, A

            ; Get the ID (DSP.SRCN) for the intrument. If positive, its a normal
            ; sample.
            ; TODO: All of the IDs in the INSTRUMENT_DATA are positive so figure 
            ; out how precussion changes that.
            mov.b Y, #$00
            mov.b A, ($14)+Y : bpl .normal_sample
                ; TODO: Precussion?
                and.b A, #$1F
                and.b $48, #$20 : tset.w $0048, A

                ; TODO: Enable noise generation on this channel?
                or.b $49, $47

                mov A, Y

                bra .precussionStartLoop

            .normal_sample

            ; Disables noise generation on the current channel.
            mov.b A, $47 : tclr.w $0049, A

            ; Loop through the rest of the first 4 btyes of INSTRUMENT_DATA and
            ; write them to some DSP registers.
            ; This will write to: DSP.VxSRCN, VxADSR1, VxADSR2, and VxGAIN.
            .dsp_write_loop

                mov.b A, ($14)+Y

                .precussionStartLoop

                mov.w SMP.DSPADDR, X
                mov.w SMP.DSPDATA, A

                inc X
            inc Y : cmp.b Y, #$04 : bne .dsp_write_loop

            ; Get the instrument high-level tuning multiplier.
            pop X
            mov.b A, ($14)+Y : mov.w $0221+X, A
            inc Y
            mov.b A, ($14)+Y : mov.w $0220+X, A

        .exit

        ret
    }

    ; ==========================================================================

    ; Input:
    ; A - The pan setting.
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

    ; Input:
    ; A - The instrament ID to change to.
    ; SPC $0CCD-$0CE5 JUMP LOCATION
    ; $0D009B-$0D00B3 DATA
    TrackCommand_E2_PanSlide:
    {
        ; Set the pan slide timer for the channel.
        mov.b $91+X, A

        push A

        ; Get the pan target.
        call GetTrackByte : mov.w $0350+X, A

        ; TODO: Do some math I don't understand.
        setc : sbc.w A, $0331+X
        pop X
        call MakeFraction

        ; Set the pan sweep value for the channel.
        mov.w $0340+X, A
        mov A, Y : mov.w $0341+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0CE6-$0CF1 JUMP LOCATION
    ; $0D00B4-$0D00BF DATA
    TrackCommand_E3_SetVibrato:
    {
        ; Set the channel vibrato wait for the channel.
        mov.w $02B0+X, A

        ; TODO: What is the vibrato rate?
        ; Set the vibrato rate.
        call GetTrackByte : mov.w $02A1+X, A

        ; Get the vibrato intensity.
        call GetTrackByte

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0CF2-$0CFC JUMP LOCATION
    ; $0D00C0-$0D00CA DATA
    TrackCommand_E4_VibratoOff:
    {
        ; Set the channel vibrato intensity and max intensity.
        mov.b $B1+X, A
        mov.w $02C1+X, A

        ; Set the channel vibrato gradient wait.
        mov.b A, #$00 : mov.w $02B1+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0CFD-$0D0C JUMP LOCATION
    ; $0D00CB-$0D00DA DATA
    TrackCommand_F0_VibratoGradient:
    {
        ; Set the channel vibrato gradient wait.
        mov.w $02B1+X, A
        push A

        ; Get the channel vibrato intensity and divide it by gradient wait.
        mov.b Y, #$00
        mov.b A, $B1+X
        pop X
        div YA, X

        ; Reload the channel offset and set the vibrato step.
        mov.b X, $44
        mov.w $02C0+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D0D-$0D1B JUMP LOCATION
    ; $0D00DB-$0D00E9 DATA
    TrackCommand_E5_GlobalVolume:
    {
        ; If we are fading out the music, don't change the global volume.
        mov.w A, $03CA : bne .exit
            ; If we have cached the music volume, don't change the global volume.
            mov.w A, $03E1 : bne .exit
                ; Set the global volume.
                mov.b A, #$00 : movw.b $58, YA

        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $0D1C-$0D2D JUMP LOCATION
    ; $0D00EA-$0D00FB DATA
    TrackCommand_E6_GlobalVolumeSlide:
    {
        ; Set the global volume slide timer.
        mov.b $5A, A

        ; Set the global volume slide target.
        call GetTrackByte : mov.b $5B, A

        ; Get the global volume incrament between the current global volume and 
        ; the target based on the timer.
        setc : sbc.b A, $59
        mov.b X, $5A
        call MakeFraction : movw.b $5C, YA

        ret
    }

    ; ==========================================================================

    ; SPC $0D2E-$0D32 JUMP LOCATION
    ; $0D00FC-$0D0100 DATA
    TrackCommand_E7_SetTempo:
    {
        ; Set the song tempo.
        mov.b A, #$00 : movw.b $52, YA

        ret
    }

    ; ==========================================================================

    ; SPC $0D33-$0D44 JUMP LOCATION
    ; $0D0101-$0D0112 DATA
    TrackCommand_E8_TempoSlide:
    {
        ; Set the tempo sweep duration.
        mov.b $54, A

        ; Set the tempo target.
        call GetTrackByte : mov.b $55, A
        
        ; Get the tempo sweep incrament between the current tempo and the target
        ; based on the timer.
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
        ; Set the global transposition.
        mov.b $50, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D48-$0D4B JUMP LOCATION
    ; $0D0116-$0D0119 DATA
    TrackCommand_EA_ChannelTranspose:
    {
        ; Set the channel transposition.
        mov.w $02F0+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D4C-$0D57 JUMP LOCATION
    ; $0D011A-$0D0125 DATA
    TrackCommand_EB_SetTremolo:
    {
        ; Set the tremolo delay.
        mov.w $02E0+X, A

        ; Set the tremolo rate.
        call GetTrackByte : mov.w $02D1+X, A

        ; Get the tremolo intensity.
        call GetTrackByte

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $0D58-$0D5A JUMP LOCATION
    ; $0D0126-$0D0128 DATA
    TrackCommand_EC_TremoloOff:
    {
        ; Set the tremolo intensity.
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

        ; Set channel the pitch slide type (0: from | 1: to).
        mov.w $0290+X, A

        ; Set channel the pitch slide delay queue.
        mov A, Y : mov.w $0281+X, A

        ; Set channel the pitch slide timer queue.
        call GetTrackByte : mov.w $0280+X, A

        ; Set channel the pitch slide target.
        call GetTrackByte : mov.w $0291+X, A

        ret
    }

    ; ==========================================================================

    ; OPTIMIZE: You could reorganize the parameters from the previous function
    ; to reuse this one.
    ; SPC $0D75-$0D78 JUMP LOCATION
    ; $0D0143-$0D0146 DATA
    TrackCommand_F3_PitchSlideStop:
    {
        ; Set channel the pitch slide timer queue.
        mov.w $0280+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D79-$0D81 JUMP LOCATION
    ; $0D0147-$0D014F DATA
    TrackCommand_ED_ChannelVolume:
    {
        ; Set the channel volume.
        mov.w $0301+X, A

        ; Zero the low byte of the channel volume.
        mov.b A, #$00 : mov.w $0300+X, A

        ret
    }

    ; ==========================================================================

    ; SPC $0D82-$0D9A JUMP LOCATION
    ; $0D0150-$0D0168 DATA
    TrackCommand_EE_ChannelVolumeSlide:
    {
        ; Set the channel volume slide timer.
        mov.b $90+X, A
        push A

        ; Set the channel volume slide target.
        call GetTrackByte : mov.w $0320+X, A

        ; Caluclate the volume slide incrament.
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
        ; Set the current channel fine pitch tuning.
        mov.w $0381+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ; X - The current channel.
    ; Sets up a subroutine call for a track part command (0xFE).
    ; SPC $0D9F-$0DB6 JUMP LOCATION
    ; $0D016D-$0D0184 DATA
    TrackCommand_EF_CallPart:
    {
        ; Set the current channel subroutine address.
        mov.w $0240+X, A
        call GetTrackByte : mov.w $0241+X, A

        ; Set the current channel loop count. (How many times the part will loop.)
        call GetTrackByte : mov.b $80+X, A

        ; Take the current track pointer and save it as the return address for
        ; when the part is completed.
        mov.b A, $30+X : mov.w $0230+X, A
        mov.b A, $31+X : mov.w $0231+X, A

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; Input:
    ; X - The current channel.
    ; Sets the channel track pointer to the start of the channel part subroutine.
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
        ; Enable echo on the given channels.
        mov.w $03C3, A
        mov.b $4A, A

        ; Set the echo volume left queue.
        call GetTrackByte
        mov.b A, #$00 : movw.b $60, YA

        ; Set the echo volume right queue.
        call GetTrackByte
        mov.b A, #$00 : movw.b $62, YA

        ; Clear the DSP.FLG queue disable echo flag.
        clr5.b $48

        ret
    }

    ; ==========================================================================

    ; SPC $0DD8-$0DF8 JUMP LOCATION
    ; $0D01A6-$0D01C6 DATA
    TrackCommand_F8_EchoSlide:
    {
        ; Set the echo pan timer.
        mov.b $68, A

        ; Set the echo left target.
        call GetTrackByte : mov.b $69, A

        ; Calculate the echo slide left incrament.
        setc : sbc.b A, $61
        mov.b X, $68
        call MakeFraction : movw.b $64, YA

        ; Set the echo right target.
        call GetTrackByte : mov.b $6A, A

        ; Calculate the echo slide right incrament.
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
        ; NOTE: Because command F6 does not have any parameters, YA will always
        ; be 0 by the time we get here.
        ; Set the left and right echo volume queues to 0.
        movw.b $60, YA
        movw.b $62, YA

        ; Set the DSP.FLG queue disable echo flag.
        set5.b $48

        ret
    }

    ; ==========================================================================

    ; SPC $0E00-$0E21 JUMP LOCATION
    ; $0D01CE-$0D01EF DATA
    TrackCommand_F7_EchoFilter:
    {
        ; Set the echo delay queue and setup a bunch of other settings based
        ; on that.
        call ConfigureEcho

        ; Get the next byte and set the echo feedback queue.
        call GetTrackByte : mov.b $4E, A

        ; Get the next byte as the echo filter parameter index.
        call GetTrackByte
        mov.b Y, #$08
        mul YA : mov X, A

        ; Loop through each of filter parameters and write them to each of
        ; the coefficients.
        mov.b Y, #DSP.FIR0

        .set_next_filter
            mov.w A, EchoFilterParameters+X
            call WriteToDSP

            inc X

            mov A, Y : clrc : adc.b A, #$10 : mov Y, A
        bpl .set_next_filter

        ; Reload the channel offset.
        mov.b X, $44

        ret
    }

    ; ==========================================================================

    ; SPC $0E22-$0E67 JUMP LOCATION
    ; $0D01F0-$0D0235 DATA
    ConfigureEcho:
    {
        ; Set the echo delay queue.
        mov.b $4D, A

        ; Check if the current echo delay is the same:
        mov.b Y, #DSP.EDL : mov.w SMP.DSPADDR, Y
        mov.w A, SMP.DSPDATA : cmp.b A, $4D : beq .edl_same
            ; TODO: Do some math I don't understand to set the echo delay timer.
            and.b A, #$0F : eor.b A, #$FF
            
            bbc7.b $4C, .buffer_ready
                clrc : adc.b A, $4C

            .buffer_ready

            mov.b $4C, A

            mov.b Y, #$04

            ; Loop through 4 DSP registers and zero them out.
            .write_register

                ; Choose the DSP register to write to.
                mov.w A, RegisterList-1+Y : mov.w SMP.DSPADDR, A

                ; Write 0 to that register.
                mov.b A, #$00 : mov.w SMP.DSPDATA, A
            dbnz Y, .write_register

            ; Write the flag queue to the DSP flag register.
            mov.b A, $48 : or.b A, #$20
            mov.b Y, #DSP.FLG
            call WriteToDSP

            ; Write the echo delay queue to the DSP echo delay register.
            mov.b A, $4D
            mov.b Y, #DSP.EDL
            call WriteToDSP

        .edl_same

        ; TODO: Do some math I don't understand.
        asl A : asl A : asl A : eor.b A, #$FF

        ; TODO: I think this reference is wrong. I think its not actually meant
        ; to reference the song pointer here.
        setc : adc.b A, #SONG_POINTERS>>8

        ; Set the DSP echo source address.
        mov.b Y, #DSP.ESA
        jmp WriteToDSP
    }

    ; ==========================================================================

    ; SPC $0E68-$0E6A JUMP LOCATION
    ; $0D0236-$0D0238 DATA
    TrackCommand_FA_PercussionOffset:
    {
        ; Set the percussion base note.
        mov.b $5F, A

        ret
    }

    ; ==========================================================================

    ; UNUSED: Not referenced anywhere.
    ; SPC $0E6B-$0E6E JUMP LOCATION
    ; $0D0239-$0D023C DATA
    UNUSED_DummyCommand:
    {
        call SkipTrackByte

        ret
    }

    ; ==========================================================================

    ; UNUSED: Not referenced anywhere.
    ; SPC $0E6F-$0E73 JUMP LOCATION
    ; $0D023D-$0D0241 DATA
    UNUSED_ChannelStop:
    {
        inc A
        mov.w $03FF+X, A

        ret
    }

    ; ==========================================================================

    ; UNUSED: Not referenced anywhere.
    ; SPC $0E74-$0E74 JUMP LOCATION
    ; $0D0242-$0D0242 DATA
    UNUSED_SongStop:
    {
        inc A

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; UNUSED: Not referenced anywhere.
    ; SPC $0E75-$0E79 JUMP LOCATION
    ; $0D0243-$0D0247 DATA
    UNUSED_SongContinue:
    {
        mov.b $1B, A

        jmp Music_ChangeSong_key_off
    }

    ; ==========================================================================

    ; SPC $0E7A-$0E9A JUMP LOCATION
    ; $0D0248-$0D0269 DATA
    PitchSlide:
    {
        ; If theres no active pitch timer on the current channel, don't do
        ; anything.
        mov.b A, $A0+X : bne TrackCommand_F9_SlideOnce_exit
            ; Get the next track command. If it is a slide once command, exit.
            mov.b A, ($30+X) : cmp.b A, #$F9 : bne TrackCommand_F9_SlideOnce_exit
                ; Check if the current channel is enabled.
                mov.b A, $47 : and.b A, $1A : beq .do_pitch_slide
                    ; If not, skip the next 4 bytes of the track.
                    mov.b $10, #$04

                    .skip_loop

                        call SkipTrackByte
                    dbnz.b $10, .skip_loop

                    bra TrackCommand_F9_SlideOnce_exit

                .do_pitch_slide

                ; We read the current byte eariler so now we need to skip it.
                call SkipTrackByte

                ; Get the channel pitch delay.
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
        ; Get the current channel pitch calculation and store it in some temp
        ; work RAM.
        mov.w A, $0361+X : mov.b $11, A
        mov.w A, $0360+X : mov.b $10, A

        ret
    }

    ; ==========================================================================

    ; The purpose of this function is to create incraments between 2 given values.
    ; TODO: Document inputs.
    ; SPC $0ECE-$0EDF JUMP LOCATION
    ; $0D029C-$0D02AD DATA
    MakeFraction:
    {
        ; TODO: Do a whole bunch of main I don't understand.
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

        ; Reload the current channel offset.
        mov.b X, $44

        ; Bleeds into the next function.
    }

    ; SPC $0EE0-$0EE9 JUMP LOCATION
    ; $0D02AE-$0D02B8 DATA
    MakeFraction_abs:
    {
        ; TODO: Do a bunch of math I don't understand.
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
        dw TrackCommand_EB_SetTremolo
        dw TrackCommand_EC_TremoloOff
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

    ; These are the amount of parameters that each track command above has.
    ; SPC $0F20-$0F3E JUMP LOCATION
    ; $0D02EE-$0D030C DATA
    TrackCommandParamCount:
    {
        db 1 ; TrackCommand_E0_ChangeInstrument
        db 1 ; TrackCommand_E1_ChangePan
        db 2 ; TrackCommand_E2_PanSlide
        db 3 ; TrackCommand_E3_SetVibrato
        db 0 ; TrackCommand_E4_VibratoOff
        db 1 ; TrackCommand_E5_GlobalVolume
        db 2 ; TrackCommand_E6_GlobalVolumeSlide
        db 1 ; TrackCommand_E7_SetTempo

        db 2 ; TrackCommand_E8_TempoSlide
        db 1 ; TrackCommand_E9_GlobalTranspose
        db 1 ; TrackCommand_EA_ChannelTranspose
        db 3 ; TrackCommand_EB_SetTremolo
        db 0 ; TrackCommand_EC_TremoloOff
        db 1 ; TrackCommand_ED_ChannelVolume
        db 2 ; TrackCommand_EE_ChannelVolumeSlide
        db 3 ; TrackCommand_EF_CallPart

        db 1 ; TrackCommand_F0_VibratoGradient
        db 3 ; TrackCommand_F1_PitchSlideTo
        db 3 ; TrackCommand_F2_PitchSlideFrom
        db 0 ; TrackCommand_F3_PitchSlideStop
        db 1 ; TrackCommand_F4_FineTuning
        db 3 ; TrackCommand_F5_EchoBasicControl
        db 0 ; TrackCommand_F6_EchoSilence
        db 3 ; TrackCommand_F7_EchoFilter

        db 3 ; TrackCommand_F8_EchoSlide
        db 3 ; TrackCommand_F9_SlideOnce
        db 1 ; TrackCommand_FA_PercussionOffset

        ; TODO: Extra values for commands that don't exist?
        db 2 ; 0xFB
        db 0 ; 0xFC
        db 0 ; 0xFD
        db 0 ; 0xFE
    }

    ; ==========================================================================

    ; SPC $0F3F-$0F93 JUMP LOCATION
    ; $0D030D-$0D0361 DATA
    WritePitch:
    {
        ; Check if we are performing a volume slide on the current channel:
        mov.b A, $90+X : beq .no_volume_slide
            ; TODO: Change to Channel0Vol reference.
            ; Set up the volume slide address pointer for IncrementSlide.
            mov.b A, #$0300>>0
            mov.b Y, #$0300>>8

            ; Decrement the timer.
            dec.b $90+X

            call IncrementSlide

        .no_volume_slide

        ; Check if we are perfomring a tremolo on the current channel.
        mov.b Y, $C1+X : beq .no_tremolo
            mov.w A, $02E0+X : cbne.b $C0+X, .tremolo_not_ready
                ; Mark that we are using a special effect on the current channel.
                or.b $5E, $47

                ; Check if the tremolo accumulator is positive:
                mov.w A, $02D0+X : bpl .tremolo_accumulate
                    inc Y
                    bne .tremolo_accumulate
                        mov.b A, #$80

                        bra .skip_accumulate

                .tremolo_accumulate

                ; Add the tremolo incrament.
                clrc : adc.w A, $02D1+X

                .skip_accumulate

                ; Set the tremolo accumulator.
                mov.w $02D0+X, A

                ; Calculate the final volume with tremolo.
                call VolumeModulation_external

                bra .handle_pan_slide

            .tremolo_not_ready

            ; Increase the tremolo timer.
            inc.b $C0+X

        .no_tremolo

        ; Calculate the final volume without any tremolo.
        mov.b A, #$FF
        call VolumeModulation_final_volume

        .handle_pan_slide

        ; Check if we are performing a pan sweep on the current channel:
        mov.b A, $91+X : beq .no_pan_slide
            ; Set up the pan address pointer for IncrementSlide.
            mov.b A, #$0330>>0
            mov.b Y, #$0330>>8

            ; Decrement the timer.
            dec.b $91+X

            call IncrementSlide

        .no_pan_slide

        ; Check if there are any special effects playing on the current channel.
        mov.b A, $47 : and.b A, $5E : beq WriteVolume_exit
            ; Get the channel pan value and store it in some work ram.
            mov.w A, $0331+X : mov Y, A
            mov.w A, $0330+X : movw.b $10, YA

            ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; TODO: Come back to this and document it.
    ; Input:
    ; X The channel number.
    ; $10[0x02] the pan setting.
    ; SPC $0F94-$0FD1 JUMP LOCATION
    ; $0D0362-$0D039F DATA
    WriteVolume:
    {
        ; Setup $12 to point to DSP.VxVOLL.
        mov A, X : xcn A : lsr A : mov.b $12, A

        .vol_right

            ; Do a bunch of math that applies the pan settings to the final
            ; volume.
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

            ; TODO: Verify.
            ; Just in case the final volume ended up being negative:
            mov A, Y : bcc .no_phase_inversion
                eor.b A, #$FF : inc A

            .no_phase_inversion

            ; Ends up writing to DSP.VxVOLL and DSP.VxVOLR.
            mov.b Y, $12
            call WriteToDSP_Checked

            mov.b Y, #$14
            mov.b A, #$00
            subw.b YA, $10 : movw.b $10, YA

            inc.b $12
        ; Repeat everything one more time for the right volume.
        bbc1.b $12, .vol_right

        ; SPC $0FD1 ALTERNATE ENTRY POINT
        ; $0D039F DATA
        .exit

        ret
    }

    ; ==========================================================================

    ; Input:
    ; YA - The address to slide.
    ; X  - The current channel.
    ; SPC $0FD2-$0FF5 JUMP LOCATION
    ; $0D03A0-$0D03C3 DATA
    IncrementSlide:
    {
        ; Mark that we are using a special effect on the current channel.
        or.b $5E, $47

        ; SPC $0FD5 ALTERNATE ENTRY POINT
        ; $0D03A3 DATA
        .quiet

        ; Get the address pointer.
        movw.b $14, YA
        movw.b $16, YA

        ; Move the current channel offset to Y.
        push X : pop Y

        clrc
        bne .still_sliding
            ; Move the address pointer to the slide target.
            adc.b $16, #$1F

            ; Set the value low byte to 0.
            mov.b A, #$00 : mov.b ($14)+Y, A

            ; Move on to the high byte of the value.
            inc Y

            bra .doneSliding

        .still_sliding

        ; Move the address pointer to the slide incrament.
        adc.b $16, #$10

        ; Write the low byte of the volume.
        call .add_slide_amount

        ; Move on to the high byte of the value.
        inc Y

        ; SPC $0FEF ALTERNATE ENTRY POINT
        ; $0D03BD DATA
        .add_slide_amount

        ; Get the current channel value.
        mov.b A, ($14)+Y

        .doneSliding

        ; Add the slide incrament to the current channel value or if we are done
        ; sliding, set the high byte of value to the target value.
        adc.b A, ($16)+Y : mov.b ($14)+Y, A

        ret
    }

    ; ==========================================================================

    ; TODO: Investigate why this is needed when a bunch of similar logic
    ; exists in HandleInput_Song.
    ; SPC $0FF6-$10B0 JUMP LOCATION
    ; $0D03C4-$0D047E DATA
    Tracker:
    {
        ; TODO: Figure out in what scenarios we are waiting to read the next
        ; note or command.
        mov.b A, $71+X : beq .time_left
            dec.b $71+X : beq .times_up
                mov.b A, #$02 : cbne.b $70+X, .time_left

            .times_up
            
            ; Get the channel part count.
            mov.b A, $80+X : mov.b $17, A

            ; Get the channel pointer.
            mov.b A, $30+X
            mov.b Y, $31+X

            .next_byte_with_pointer

            movw.b $14, YA
            mov.b Y, #$00

            .next_byte
            
                ; Get the next byte in the track and check if it is an end byte:
                mov.b A, ($14)+Y : beq .terminate_track
                    ; Check if the byte was a command:
                    bmi .command
                        .read_track_data

                            inc Y : bmi .part_loop_over
                        mov.b A, ($14)+Y : bpl .read_track_data

                    .command

                    ; Check for a tie:
                    cmp.b A, #$C8 : beq .time_left
                        ; Check for a call part command:
                        cmp.b A, #$EF : beq .part_loop_command
                            ; Check for an instrument change command:
                            cmp.b A, #$E0 : bcc .part_loop_over
                                ; Get the amount of parameters the command has and
                                ; add them to Y so that we skip over them when we
                                ; move on to the next byte.
                                push Y
                                mov Y, A
                                pop A
                                adc.w A, TrackCommandParamCount-$E0+Y : mov Y, A
            bra .next_byte

            .terminate_track

            ; Check if we are in a part loop:
            mov.b A, $17 : beq .part_loop_over
                ; Check if this is the last loop:
                dec.b $17 : bne .part_loop_notdone
                    ; OPTIMIZE: Why not just mov Y, A?
                    ; If it is the last loop, get the part return address.
                    mov.w A, $0231+X : push A
                    mov.w A, $0230+X
                    pop Y

                    bra .next_byte_with_pointer

                .part_loop_notdone

                ; OPTIMIZE: Why not just mov Y, A?
                ; Get the part address.
                mov.w A, $0241+X : push A
                mov.w A, $0240+X
                pop Y

                bra .next_byte_with_pointer

                .part_loop_command

                inc Y

                ; Get the next 2 bytes which will be the address of the part.
                mov.b A, ($14)+Y : push A
                inc Y
                mov.b A, ($14)+Y : mov Y, A
                pop A

                bra .next_byte_with_pointer

            .part_loop_over

            ; Set the current channel key off.
            mov.b A, $47
            mov.b Y, #DSP.KOFF
            call WriteToDSP_Checked

        .time_left

        ; Mark that we are not doing any pitch chanes.
        clr7.b $13

        ; Check if we are performing a pitch slide on the current channel:
        mov.b A, $A0+X : beq .no_pitch_slide
            ; Check if we need to wait to perform the pitch slide:
            mov.b A, $A1+X : beq .delay_finished
                ; Decrement the pitch slide wait timer.
                dec.b $A1+X

                bra .no_pitch_slide

            .delay_finished

            ; Check if we are currently using the channel.
            mov.b A, $1A : and.b A, $47 : bne .no_pitch_slide
                ; Mark that we are doing a pitch change.
                set7.b $13

                ; Set up the pitch calculation address pointer for IncrementSlide.
                mov.b A, #$0360>>0
                mov.b Y, #$0360>>8

                ; Decrement the pitch slide timer.
                dec.b $A0+X

                call IncrementSlide_quiet

        .no_pitch_slide

        call GetTempPitch

        ; Check if there is a channel vibrato intensity set:
        mov.b A, $B1+X : beq Tracker_no_vibrato
            ; Check if there is a channel vibrato delay:
            mov.w A, $02B0+X : cbne.b $B0+X, Tracker_handle_pitch_set_point_wait
                ; Check if we want to gradually increase the intenisty instead
                ; of just setting it to the max:
                mov.w A, $0100+X : cmp.w A, $02B1+X : bne .increment
                    ; Get the channel max vibrato intensity.
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

                ; Add the channel vibrato intensity slide incrament.
                clrc : adc.w A, $02C0+X

                .set_intensity

                ; Set the channel vibrato intensity.
                mov.b $B1+X, A

                ; Add the channel vibrato incrament to the vibrato accumulator.
                mov.w A, $02A0+X : clrc : adc.w A, $02A1+X : mov.w $02A0+X, A

                ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $10B1-$10D0 JUMP LOCATION
    ; $0D047F-$0D049E DATA
    Tracker_handle_pitch:
    {
        ; TODO: Do a bunch of math I don't understand.
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

        ; Increase the channel vibrato strength.
        inc.b $B0+X

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; SPC $10D1-$10D4 JUMP LOCATION
    ; $0D049F-$0D04A2 DATA
    Tracker_no_vibrato:
    {
        ; Check if a pitch change needs to be made:
        bbs7.b $13, Tracker_handle_pitch_change_pitch
            ret
    }

    ; ==========================================================================

    ; SPC $10D5-$112F JUMP LOCATION
    ; $0D04A3-$0D04FD DATA
    BackgroundTasks:
    {
        ; Mark that no pitch changes are being made.
        clr7.b $13

        ; Check if there is any tremolo on this channel:
        mov.b A, $C1+X : beq .no_tremolo
            ; Check if the tremolo needs to be delayed:
            mov.w A, $02E0+X : cbne.b $C0+X, .no_tremolo
                call VolumeModulation

        .no_tremolo

        ; Get the channel panning value and store it into some work RAM.
        mov.w A, $0331+X : mov Y, A
        mov.w A, $0330+X : movw.b $10, YA

        ; Check if we are performing a pan sweep on this channel:
        mov.b A, $91+X : beq .no_pan_slide
            mov.w A, $0341+X : mov Y, A
            mov.w A, $0340+X
            call AdjustPitchByFrames

        .no_pan_slide

        ; Check if we are making any pitch changes:
        bbc7.b $13, .pitch_unchanged
            call WriteVolume

        .pitch_unchanged

        ; Mark that no pitch changes are being made.
        clr7.b $13

        call GetTempPitch

        ; Check if we are performing a pitch slide on this channel:
        mov.b A, $A0+X : beq .no_pitch_slide
            ; Check if the pitch slide needs to be delayed:
            mov.b A, $A1+X : bne .no_pitch_slide
                mov.w A, $0371+X : mov Y, A
                mov.w A, $0370+X
                call AdjustPitchByFrames

        .no_pitch_slide

        ; Check if we are performing any vibrato:
        mov.b A, $B1+X : beq Tracker_no_vibrato
            ; Check if the vibrato needs to be delayed:
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
        ; Mark that we are making a pitch change:
        set7.b $13

        ; TODO: Do a bunch of math that I don't understand.
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
        ; Mark that a pitch change is being made.
        set7.b $13

        ; TODO: Do some math I don't understand.
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
        ; TODO: Do some math I don't understand.
        asl A : bcc .no_phase_invert
            eor.b A, #$FF

        .no_phase_invert

        ; Get the tremolo intensity for the current channel and multiply it by
        ; the current tremolo accumulator.
        mov.b Y, $C1+X
        mul YA : mov A, Y : eor.b A, #$FF

        ; SPC $1166 ALTERNATE ENTRY POINT
        ; $0D0534 DATA
        .final_volume

        ; Multiply the calculated tremolo volume by the global volume.
        mov.b Y, $59
        mul YA

        ; Multiply the calculated tremolo volume by the channel attack.
        mov.w A, $0210+X
        mul YA

        ; Multiply the calculated tremolo volume by the channel volume.
        mov.w A, $0301+X
        mul YA : mov A, Y

        ; Square the result and store it as the final volume.
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
    RegisterValueFrom:
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

    ; These are the pitch values for octave 5 for each note.
    ; SPC $11C1-$11DA DATA
    ; $0D058F-$0D05A8 DATA
    NotePitchValues:
    {
        dw $085F ; 0x00 - Note: C
        dw $08DE ; 0x01 - Note: Cs
        dw $0965 ; 0x02 - Note: D
        dw $09F4 ; 0x03 - Note: Ds
        dw $0A8C ; 0x04 - Note: E
        dw $0B2C ; 0x05 - Note: F
        dw $0BD6 ; 0x06 - Note: Fs
        dw $0C8B ; 0x07 - Note: G
        dw $0D4A ; 0x08 - Note: Gs
        dw $0E14 ; 0x09 - Note: A
        dw $0EEA ; 0x0A - Note: As
        dw $0FCD ; 0x0B - Note: B
        dw $10BE ; 0x0C - Note: C (next octave)
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

    ; This is similar to the SMP IPL boot ROM. Its purpose to communicate with
    ; the 5A22 when transmitting new song banks.
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
        ; Get the SFX2 input and get its echo settings.
        mov.b A, $02 : and.b A, #$3F : mov X, A
        mov.w A, SFX2_Echo-1+X : mov.w $03E2, A

        ; Setup a loop to see which channels are in use by SFX2:
        mov.b Y, #$0E
        mov.b X, #$80 : mov.w $03C1, X

        .loop_back

            ; See if the channel is in use by a SFX or ambient:
            mov.w A, $03CB : and.w A, $03C1 : beq .SFX2_next_slot
                ; Check if we are already playing the same sound with the same
                ; pan settings.
                clrc
                mov.w A, $03A0+Y : adc.w A, $03D0+Y : cmp.b A, $02 : beq SFX3_HandleEcho_match

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
        ; Get the SFX3 input and get its echo settings.
        mov.b A, $03 : and.b A, #$3F : mov X, A
        mov.w A, SFX3_Echo-1+X : mov.w $03E2, A

        ; Setup a loop to see which channels are in use by SFX3:
        mov.b Y, #$0E
        mov.b X, #$80 : mov.w $03C1, X

        .SFX3_loop_point

            ; See if the channel is in use by a SFX or ambient:
            mov.w A, $03CD : and.w A, $03C1 : beq .SFX3_next_slot
                ; Check if we are already playing the same sound with the same
                ; pan settings.
                clrc
                mov.w A, $03A0+Y : adc.w A, $03D0+Y : cmp.b A, $03 : beq .match

            .SFX3_next_slot

            dec Y : dec Y
        lsr.w $03C1: bne .SFX3_loop_point

        bra .no_slot

        ; SPC $128E ALTERNATE ENTRY POINT
        ; $0D065C
        .match

        ; OPTIMIZE: This is done again right after the bra.
        mov.w $03C0, Y

        bra .enabled

        ; SPC $1293 ALTERNATE ENTRY POINT
        ; $0D0661
        .no_slot

        clrc
        
        ; Setup a loop that finds the first channel that is in use by a SFX
        ; or ambient.
        mov.b X, #$1A
        mov.b A, #$80 : mov.w $03C1, A
        mov.b Y, #$0E

        .findSFXChannelLoop

            ; NOTE: Ther is no regular and A, X so we use and A, (X) instead.
            and A, (X) : beq .enabled
                dec Y : dec Y

                lsr.w $03C1
        lsr A : bcc .findSFXChannelLoop

        .enabled

        mov.w $03C0, Y
        mov.w $03C8, Y

        ; Mark that the channel is in use by and SFX or ambient.
        mov.w A, $03C1 : mov.w $03C9, A
        or.b A, $1A : mov.b $1A, A

        ; Check if echo is enabled on this channel.
        mov.w X, $03E2 : beq .disabled
            ; Mark that echo is enabled on this channel.
            or.w A, $03E3 : mov.w $03E3, A

        .disabled

        ; OPTIMIE: Why use the $0004 word?
        ; Check if we are playing an "indoor" song:
        mov.w A, $0004 : and.b A, #$10 : beq .notIndoors
            ; Check if any channel is using echo:
            mov.w A, $03C1 : and.w A, $03E3 : beq .echo_off

        .notIndoors

        ; Check if any channels don't already have their echo on bit set:
        mov.w A, $03C1 : and.b A, $4A : beq .echo_off
            ; Remove the channels that already had their echo on bits set and
            ; turn on the rest.
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
        ; Check if the SFX3 is non-0:
        mov.b A, $03 : bne .valid
            ret

        .valid

        .accompanying

            ; OPTIMIZE: cbeq.b $1A, .exit
            ; Check if all channels are muted:
            mov.b A, #$FF : cbne.b $1A, .not_all_muted
                bra .exit

            .not_all_muted

            call SFX3_HandleEcho

            ; Set the channel SFX ID and pan settings.
            mov.w X, $03C0
            mov.b A, $03 : and.b A, #$C0 : mov.w $03D0+X, A
            mov.b A, $03 : and.b A, #$3F : mov.w $03A0+X, A

            ; Set a little bit of a delay for the SFX to start.
            mov.b A, #$03 : mov.w $03A1+X, A

            ; Set the pitch slide queue for the channel to 0.
            mov.b A, #$00 : mov.w $0280+X, A

            ; Mark which channels are being used by a SFX3.
            mov.w A, $03C1 : or.w A, $03CD : mov.w $03CD, A

            ; Write the key off for the channel.
            mov.w A, $03C1
            mov.b Y, #DSP.KOFF
            call WriteToDSP
        ; Check if the SFX has an accompanying channel that also needs to be
        ; played.
        mov.w A, $03A0+X : mov X, A
        mov.w A, SFX3_Accomp-1+X : mov.b $03, A : bne .accompanying

        .exit

        ret
    }

    ; ==========================================================================

    ; SPC $1403-$1444 JUMP LOCATION
    ; $0D07D1-$0D0812 DATA
    HandleValidSFX2:
    {
        .accompanying
            ; OPTIMIZE: cbeq.b $1A, .exit
            ; Check if all channels are muted:
            mov.b A, #$FF : cbne.b $1A, .not_all_muted
                bra .exit

            .not_all_muted

            call SFX2_HandleEcho

            ; Set the channel SFX ID and pan settings.
            mov.w X, $03C0
            mov.b A, $02 : and.b A, #$3F : mov.w $03A0+X, A
            mov.b A, $02 : and.b A, #$C0 : mov.w $03D0+X, A

            ; Set a little bit of a delay for the SFX to start.
            mov.b A, #$03 : mov.w $03A1+X, A

            ; Set the pitch slide queue for the channel to 0.
            mov.b A, #$00 : mov.w $0280+X, A

            ; Mark which channels are being used by a SFX2.
            mov.w A, $03C1 : or.w A, $03CB : mov.w $03CB, A

            ; Write the key off for the channel.
            mov.w A, $03C1
            mov.b Y, #DSP.KOFF
            call WriteToDSP
        ; Check if the SFX has an accompanying channel that also needs to be
        ; played.
        mov.w A, $03A0+X : mov X, A
        mov.w A, SFX2_Accomp-1+X : mov.b $02, A : bne .accompanying

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
                    ; Calculate the channel specific DSP address.
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

                    ; Calculate the channel specific DSP address.
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

                    ; Calculate the channel specific DSP address.
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
        ; Cancel the currently playing SFX or ambient playing on the channel
        ; that is playing one.
        mov.b A, #$00
        mov.w X, $03C0
        mov.w $03A0+X, A

        ; Mark that the channels that were being used by SFX are no longer
        ; being used.
        mov.b A, $1A : setc : sbc.w A, $03C1 : mov.b $1A, A

        ; Check if the channels were being used by a SFX2:
        mov.w A, $03C1 : and.w A, $03CB : beq .not_on_SFX_2
            ; Mark them as no longer being used by a SFX2.
            mov.w A, $03CB : setc : sbc.w A, $03C1 : mov.w $03CB, A

            bra .resume

        .not_on_SFX_2

        ; Check if the channels were being used by a SFX3:
        mov.w A, $03C1 : and.w A, $03CD : beq .not_on_SFX_3
            ; Mark them as no longer being used by a SFX3.
            mov.w A, $03CD : setc : sbc.w A, $03C1 : mov.w $03CD, A

            bra .resume

        .not_on_SFX_3

        ; Mark that the channels that were being used by ambients are no longer
        ; being used by ambients.
        mov.w A, $03CF : setc : sbc.w A, $03C1 : mov.w $03CF, A

        .resume

        ; Set the instrament back to what the music was using.
        mov.b $44, X
        mov.w A, $0211+X
        call TrackCommand_E0_ChangeInstrument

        ; Check if the channel already had echo enabled:
        mov.w A, $03C1 : and.w A, $03C3 : beq .exit
            ; Check if the echo was already set to be enabled:
            and.b A, $4A : bne .exit
                ; Mark that the echo needs to be enabled on this channel.
                mov.b A, $4A : clrc : adc.w A, $03C1 : mov.b $4A, A
                mov.b Y, #DSP.EON
                call WriteToDSP

                ; Reset the bitfield for SFX echo.
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
        ; Check if the current channel is being used by an ambient:
        mov.w A, $03C1 : and.w A, $03CF : bne .used_by_ambient
            ; Check if the current channel is being used by an SFX2:
            mov.w A, $03C1 : and.w A, $03CB : bne .used_by_SFX_2
                ; If we got here that means its a SFX3.
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
            ; Calculate the channel specific DSP address.
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
                                ; DSP channel address +1.
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
                        call WriteVolume

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

                        ; Handle the note on the given channel.
                        mov.w X, $03C0
                        mov Y, A
                        call HandleNote

                        ; Key on the channels being used.
                        mov.w A, $03C1
                        call KeyOnSoundEffects

                        .setup_pitch_slide

                        ; Set the note countdown.
                        mov.w X, $03C0
                        mov.w A, $03B1+X : mov.w $03B0+X, A

                        .do_pitch_slide
                        
                        ; Mark that there are no pitch changes currently
                        ; taking place.
                        clr7.b $13

                        ; Check if we are performing a pitch slide on the channel.
                        mov.w X, $03C0
                        mov.b A, $A0+X : beq .no_pitch_slide
                            call PitchSlideSFX

                            bra .dont_key_off

                        .no_pitch_slide

                        ; On frame 0x02 of the SFX note timer, key off the note.
                        mov.b A, #$02 : cmp.w A, $03B0+X : bne .dont_key_off
                            mov.w A, $03C1
                            mov.b Y, #DSP.KOFF
                            call WriteToDSP

                        .dont_key_off

                        ; Set the SFX data pointer for the channel to the current
                        ; SFX data pointer.
                        mov.w X, $03C0
                        mov.b A, $2D : mov.w $0391+X, A
                        mov.b A, $2C : mov.w $0390+X, A

                        ; Check if the current channel is being used by an ambient:
                        mov.w A, $03C1 : and.w A, $03CF : bne .ambient
                            ; Check if the current channel is being used by
                            ; an SFX2:
                            mov.w A, $03C1 : and.w A, $03CB : bne .on_SFX_2
                                ; Its being used by an SFX3.
                                jmp Handle_SFX3_to_next_channel

                        .ambient

                        jmp Handle_AmbientAndSFX_to_next_channel

                        .on_SFX_2
                        
                        jmp Handle_SFX2_to_next_channel

                .pitch_slide_command

                ; Get the next byte of the SFX or ambient.
                mov.b X, #$00
                incw.b $2C
                mov.b A, ($2C+X)

                ; Handle the current note of the SFX.
                mov.w X, $03C0 : mov.b $44, X
                mov Y, A
                call HandleNote

                mov.w A, $03C1
                call KeyOnSoundEffects

                .pitch_slide_to_command
                
                ; Get the next byte and set it as the pitch slide delay.
                mov.b X, #$00
                incw.b $2C
                mov.b A, ($2C+X)

                mov.w X, $03C0
                mov.b $A1+X, A

                ; Get the next byte and set it as pitch slide timer.
                mov.b X, #$00
                incw.b $2C
                mov.b A, ($2C+X)

                mov.w X, $03C0
                mov.b $A0+X, A
                push A

                ; Get the next byte and use it as the base for the next pitch
                ; slide calculation.
                mov.b X, #$00
                incw.b $2C
                mov.b A, ($2C+X)

                pop Y

                mov.w X, $03C0 : mov.b $44, X
                call TrackCommand_F9_SlideOnce_calc_frames

                jmp .setup_pitch_slide

                .change_instrument

                ; Get the next byte and use it as the index to get the
                ; INSTRUMENT_DATA_SFX.
                mov.b X, #$00
                incw.b $2C
                mov.b A, ($2C+X)
                mov.b Y, #$09
                mul YA : mov X, A

                mov.w Y, $03C2

                ; Loop through each channel:
                mov.b $12, #$08

                .write_loop
                    mov.w A, INSTRUMENT_DATA_SFX+X
                    call WriteToDSP

                    inc X
                    inc Y
                dbnz.b $12, .write_loop

                ; Use the last byte in the INSTRUMENT_DATA_SFX as the channel
                ; pitch tuning multiplier.
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
        ; Mark that we are performing a pitch change.
        set7.b $13

        ; Setup the address for the channel pitch calculation as a pointer and
        ; perform the pitch slide.
        mov.b A, #$0360>>0
        mov.b Y, #$0360>>8

        ; Decrement the pitch slide timer.
        dec.b $A0+X

        call IncrementSlide_quiet

        mov.w A, $0361+X : mov Y, A
        mov.w A, $0360+X : movw.b $10, YA
        
        mov.b $47, #$00
        jmp HandleNote_external
    }

    ; ==========================================================================

    ; Input:
    ; A - The channel bits to channel on.
    ; SPC $1790-$179D JUMP LOCATION
    ; $0D0B5E-$0D0B6B DATA
    KeyOnSoundEffects:
    {
        push A

        ; Make sure none of the key off bits are set.
        mov.b Y, #DSP.KOFF
        mov.b A, #$00
        call WriteToDSP

        ; Key on the given channels.
        pop A
        mov.b Y, #DSP.KON

        jmp WriteToDSP
    }

    ; ==========================================================================

    SPC_ENGINE_end:

    base off

    arch 65816
}

; ==============================================================================

; TODO: Currently this will fail.
warnpc $1A8000