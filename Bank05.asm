; ==============================================================================
; Bank 0x05
; ==============================================================================
; APU Data and Engine

SPC_ENGINE          = $0800
SFX_DATA            = $17C0
SONG_FAIRY_POINTER  = $2880
CREDITS_AUX_POINTER = $2900
SONG_POINTERS_AUX   = $2B00
SAMPLE_POINTERS     = $3C00
INSTRUMENT_DATA     = $3D00
INSTRUMENT_DATA_SFX = $3E00
SAMPLE_DATA         = $4000
SONG_POINTERS       = $D000

print "Start of Bank 0x05: $", pc

; ==============================================================================

APUInitTransfer:

SamplePointers:
{
    ; Transfer size, transfer address
    dw .endOfPointers-SAMPLE_POINTERS, SAMPLE_POINTERS

    base SAMPLE_POINTERS

    ;  Start,  Loop
    dw BRRSampleData_Noise,       BRRSampleData_Noise+$0012       ; 0x00
    dw BRRSampleData_Rain,        BRRSampleData_Rain+$001B        ; 0x01
    dw BRRSampleData_Timpani,     BRRSampleData_Timpani+$0BA3     ; 0x02
    dw BRRSampleData_Square,      BRRSampleData_Square+$001B      ; 0x03
    dw BRRSampleData_Saw,         BRRSampleData_Saw+$001B         ; 0x04
    dw BRRSampleData_Clink,       BRRSampleData_Clink+$001B       ; 0x05
    dw BRRSampleData_Wobbly,      BRRSampleData_Wobbly+$002D      ; 0x06
    dw BRRSampleData_CompoundSaw, BRRSampleData_CompoundSaw+$0012 ; 0x07
    dw BRRSampleData_Tweet,       BRRSampleData_Tweet+$057C       ; 0x08
    dw BRRSampleData_Strings,     BRRSampleData_Strings+$058E     ; 0x09
    dw BRRSampleData_Strings,     BRRSampleData_Strings+$058E     ; 0x0A
    dw BRRSampleData_Trombone,    BRRSampleData_Trombone+$03F0    ; 0x0B
    dw BRRSampleData_Cymbal,      BRRSampleData_Cymbal+$0D92      ; 0x0C
    dw BRRSampleData_Ocarina,     BRRSampleData_Ocarina+$0195     ; 0x0D
    dw BRRSampleData_Chime,       BRRSampleData_Chime+$0075       ; 0x0E
    dw BRRSampleData_Harp,        BRRSampleData_Harp+$01CB        ; 0x0F
    dw BRRSampleData_Splash,      BRRSampleData_Splash+$07BC      ; 0x10
    dw BRRSampleData_Trumpet,     BRRSampleData_Trumpet+$06ED     ; 0x11
    dw BRRSampleData_Horn,        BRRSampleData_Horn+$06C9        ; 0x12
    dw BRRSampleData_Snare,       BRRSampleData_Snare+$0D2F       ; 0x13
    dw BRRSampleData_Snare,       BRRSampleData_Snare+$0D2F       ; 0x14
    dw BRRSampleData_Choir,       BRRSampleData_Choir+$052B       ; 0x15
    dw BRRSampleData_Flute,       BRRSampleData_Flute+$021C       ; 0x16
    dw BRRSampleData_Oof,         BRRSampleData_Oof+$0240         ; 0x17
    dw BRRSampleData_Piano,       BRRSampleData_Piano+$0735       ; 0x18
    dw BRRSampleData_SleighBell,  BRRSampleData_SleighBell+$05CD  ; 0x19
    dw BRRSampleData_MusicBox,    BRRSampleData_MusicBox+$0F6F    ; 0x1A
    dw BRRSampleData_Pizzicato,   BRRSampleData_Pizzicato+$0288   ; 0x1B
    dw BRRSampleData_Pizzicato2,  BRRSampleData_Pizzicato2+$0000  ; 0x1C
    dw BRRSampleData_Testing,     BRRSampleData_Testing+$001B     ; 0x1D

    .endOfPointers

    assert pc() <= $3D00, "SamplePointers exceeds INSTRUMENT_DATA: ", pc

    base off
}

; ==============================================================================

BRRSampleData:
{
    ; Transfer size, transfer address
    dw .endSampleData-SAMPLE_DATA, SAMPLE_DATA

    base SAMPLE_DATA

    ; SPC $4000-$4047 DATA
    .Noise
    incbin "Data/BRR/00_noise.brr"

    ; SPC $4048-$47F1 DATA
    .Rain
    incbin "Data/BRR/01_rain.brr"

    ; SPC $47F2-$5394 DATA
    .Timpani
    incbin "Data/BRR/02_timpani.brr"

    ; SPC $5395-$53D3 DATA
    .Square
    incbin "Data/BRR/03_square.brr"

    ; SPC $53D4-$5412 DATA
    .Saw
    incbin "Data/BRR/04_saw.brr"

    ; SPC $5413-$5475 DATA
    .Clink
    incbin "Data/BRR/05_clink.brr"

    ; SPC $5476-$550E DATA
    .Wobbly
    incbin "Data/BRR/06_wobbly.brr"

    ; SPC $550F-$55B0 DATA
    .CompoundSaw
    incbin "Data/BRR/07_compoundSaw.brr"

    ; SPC $55B1-$5B2C DATA
    .Tweet
    incbin "Data/BRR/08_tweet.brr"

    ; SPC $5B2D-$68AC DATA
    .Strings
    incbin "Data/BRR/09_strings.brr"

    ; SPC $68AD-$6CD2 DATA
    .Trombone
    incbin "Data/BRR/0A_trombone.brr"

    ; SPC $6CD3-$7A64 DATA
    .Cymbal
    incbin "Data/BRR/0B_cymbal.brr"

    ; SPC $7A65-$7C02 DATA
    .Ocarina
    incbin "Data/BRR/0C_ocarina.brr"

    ; SPC $7C03-$7CDA DATA
    .Chime
    incbin "Data/BRR/0D_chime.brr"

    ; SPC $7CDB-$7EC0 DATA
    .Harp
    incbin "Data/BRR/0E_harp.brr"

    ; SPC $7EC1-$867C DATA
    .Splash
    incbin "Data/BRR/0F_splash.brr"

    ; SPC $867D-$8D84 DATA
    .Trumpet
    incbin "Data/BRR/10_trumpet.brr"

    ; SPC $8D85-$948C DATA
    .Horn
    incbin "Data/BRR/11_horn.brr"

    ; SPC $948D-$A1BB DATA
    .Snare
    incbin "Data/BRR/12_snare.brr"

    ; SPC $A1BC-$AEB4 DATA
    .Choir
    incbin "Data/BRR/13_choir.brr"

    ; SPC $AEB5-$B0EB DATA
    .Flute
    incbin "Data/BRR/14_flute.brr"

    ; SPC $B0EC-$B32B DATA
    .Oof
    incbin "Data/BRR/15_oof.brr"

    ; SPC $B32C-$BA9F DATA
    .Piano
    incbin "Data/BRR/16_piano.brr"

    .SleighBell
    ;incbin "Data/BRR/SleighBell.brr"

    .MusicBox
    incbin "Data/BRR/MusicBox.brr"

    .Pizzicato
    ;incbin "Data/BRR/PizzicatoStrings.brr"

    .Pizzicato2
    ;incbin "Data/BRR/PizzicatoStrings2.brr"

    .Testing
    ;incbin "Data/BRR/StringEnsemble.brr"

    .endSampleData

    assert pc() <= $D000, "BRRSampleData exceeds SONG_POINTERS: ", pc

    base off
}

; ==============================================================================

InstrumentData:
{
    ; Transfer size, transfer address
    dw .instrumentDataEnd-INSTRUMENT_DATA, INSTRUMENT_DATA

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
    db $19, $EB, $93, $B8 : dw $D004 ; 0x19 - Sleigh Bell
    db $1A, $FF, $EF, $B8 : dw $D503 ; 0x1A - Music Box
    db $1B, $FF, $F6, $B8 : dw $0003 ; 0x1B - Pizzicato Strings
    db $1C, $FF, $E0, $B8 : dw $8E04 ; 0x1C - Pizzicato Strings 2
    db $1D, $FA, $E4, $B8 : dw $2804 ; 0x1C - Testing

    .instrumentDataEnd

    assert pc() <= $3E00, "InstrumentData exceeds INSTRUMENT_DATA_SFX: ", pc

    base off
}

; ==============================================================================

SPCEngine:
{
    ; Transfer size, transfer address
    dw SPC_ENGINE_end-SPC_ENGINE, SPC_ENGINE

    arch SPC700

    base SPC_ENGINE

    ; ==========================================================================

    EngineStart:
    {
        ; Set the dp to 0.
        clrp

        ; Set the stack pointer.
        mov.b X, #$CF : mov SP, X

        ; Clear $0000-$00EF in ARAM. This needs to be done separately from the
        ; other loop as to not write to the SMP hardware registers at $F0-$FF.
        mov.b A, #$00
        mov.b X, #$00

        .dpZeroLoop

            mov.b $00+X, A
        inc X : cmp.b X, #$F0 : bcc .dpZeroLoop

        ; Clear $0100-$03FF in ARAM.
        mov.b A, #$00
        mov.b X, #$00

        .absZeroLoop

            mov.w $0100+X, A
            mov.w $0200+X, A
            mov.w $0300+X, A
        inc X : bne .absZeroLoop

        ; A = 1
        inc A
        call ConfigureEcho

        ; Disable echo for now.
        mov A, #$20 : mov.b ARAM.FlagQ, A

        ; Set the DSP left and right main volume.
        mov.b A, #$60 : mov.b ARAM.MasterVolLeftQ, A
                        mov.b ARAM.MasterVolRightQ, A

        ; Tell the DSP the high byte of where the BRR samples are.
        mov.b A, #SAMPLE_POINTERS>>8 : mov.b ARAM.DirQ, A

        ; Set $FFC0 to ROM, clear ports all 5A22 input ports, and stop
        ; all timers.
        mov.b A, #$F0 : mov.b SMP.CONTROL, A

        ; Set the timer 0 target and the tempo high byte.
        mov.b A, #$10 : mov.b SMP.T0TARGET, A
                        mov.b ARAM.SongTempo+1, A

        ; Start timer 0.
        mov.b A, #$01 : mov.b SMP.CONTROL, A

        ; Bleeds into the next function.
    }

    ; ==========================================================================

    ; This is the main sound engine loop. The SMP will continuously loop here,
    ; until the SNES is reset or powered off.
    EngineMain:
    {
        ; This section is almost like a SMP version of NMI. Its not actually
        ; triggered by an interrupt, but it performs a similar purpose of
        ; updating hardware registers that should only be updated once a
        ; "frame".

        ; Check 0x0D register "queues" to see if we need to send any updates
        ; to the DSP. DSP.KOFF is written to twice, once from its queue
        ; and another time from a RAM value which is always 0.
        mov.b Y, #$0D

        .nextRegister

            ; Always update the DSP.FLG register.
            cmp.b Y, #$05 : beq .FLGRegister
                bcs .notEchoRegister
                    ; If it is an echo register, don't update it if there
                    ; is not a different echo delay.
                    cmp.b ARAM.EchoTimer, ARAM.EchoDelayQ : bne .skipEchoRegister

            .FLGRegister

            ; If bit 7 is set in the echo timer, don't update the
            ; DSP.FLG register or any of the echo registers.
            bbs7.b ARAM.EchoTimer, .skipEchoRegister
                .notEchoRegister

                ; Get the DSP register to write to.
                mov.w A, DSPQueueRegisters-1+Y : mov.w SMP.DSPADDR, A

                ; Get the RAM value to get the value we will write to the
                ; DSP register.
                mov.w A, DSPQueueRegisters_From-1+Y : mov X, A
                mov A, (X) : mov.w SMP.DSPDATA, A

            .skipEchoRegister
        ; TODO: Change to dbnz when that is fixed.
        dec y : bne .nextRegister

        ; Set both the key on and key off queues to 0 so that the DSP registers
        ; do not get written to again next frame.
        mov.b ARAM.KeyOnQ, Y
        mov.b ARAM.KeyOffQ, Y

        .timerWait

            ; Wait for SMP timer 0 to not be 0.
        mov.w Y, SMP.T0OUT : beq .timerWait

        ; This is the end of the "NMI" section.

        push Y

        ; TODO: Speed test line.
        ;bra .waitForSFX

        ; SMP.T0OUT * #$38
        ; If the result added is greater than 0xFF, we need to take new SFX
        ; and ambient input from the 5A22 and handle the current ambient/SFX.
        mov.b A, #$38
        mul YA : clrc : adc.b A, ARAM.SFXTimer : mov.b ARAM.SFXTimer, A
                                       bcc .waitForSFX
            ; TODO: Handle ambient and SFX here.

            cmp.b ARAM.EchoTimer, ARAM.EchoDelayQ : beq .dontIncrementEchoTimer
                inc.b ARAM.EchoArtificialTimer
                mov.b A, ARAM.EchoArtificialTimer : cmp.b A, #$02 : bcc .notThisFrame
                    ; Increment the echo timer.
                    inc.b ARAM.EchoTimer

                    mov.b ARAM.EchoArtificialTimer, #$00

                .notThisFrame
            .dontIncrementEchoTimer
        .waitForSFX

        pop Y

        ; TODO: Store the tick value in some temp ram.
        push Y : pop X
        mov.w A, ARAM.TEMPTickRate+X : inc A : mov.w ARAM.TEMPTickRate+X, A
        
        ; SMP.T0OUT * ARAM.SongTempo+1
        ; If the result added is greater than 0xFF, we need to take new song
        ; input from the 5A22 and handle the current song.
        mov.b A, ARAM.SongTempo+1
        mul YA : clrc : addw.b YA, ARAM.SongTimer : mov.b ARAM.SongTimer, A
                                    cmp.b Y, #$00 : beq .notOnTempo
                                  ;bcc .notOnTempo ; Vanilla method
            .onTempo

            ; Check if we need to take new song input:
            mov.b A, ARAM.InputSong : beq .noNewSongInput
                call NewSongInput
                
                bra .newSong

            .noNewSongInput

            ; If no new song was given, run the next note of the song.
            mov.b A, ARAM.CurrentSong : beq .noSongPlaying
                .beatLoop

                    push Y
                    call RunMusic
                    pop Y
                dec Y : cmp.b Y, #$00 : bne .beatLoop

            .noSongPlaying

            .newSong

            ; Check for new song input.
            mov.b X, #$00
            call Get5A22Input

            ; TODO: Speed test line.
            call TransferNotesTo5A22

        .notOnTempo

        mov.b ARAM.ChanInUse, ARAM.ChanInUseSong

        ; Perform some global background tasks:

        ; TODO: Speed test line.
        ;bra .noVolumeSlide

        ; Check if we are performing a global volume slide:
        mov.b A, ARAM.GlobalVolTimer : beq .noVolumeSlide
            ; Add the global volume increment to the global volume.
            movw.b YA, ARAM.GlobalVol : addw.b YA, ARAM.GlobalVolInc
            ; Decrement the global volume slide timer and check if we
            ; need to reset it:
            ; TODO: Change to dbnz when thats fixed.
            dec.b ARAM.GlobalVolTimer : bne .volumeSlideNotDone
                ; Set the global volume to the target volume.
                movw.b YA, ARAM.GlobalVolTarget-1

            .volumeSlideNotDone

            movw.b ARAM.GlobalVol, YA

            ; Mark that each channel needs to have its volume updated.
            mov.b ARAM.ChanUpdateVol, #$FF

        .noVolumeSlide

        ; TODO: Speed test line.
        ;bra .noTempoSlide

        ; Check if we are performing a tempo slide.
        mov.b A, ARAM.TempoSlideTimer : beq .noTempoSlide
            ; Add the temp increment to the tempo.
            movw.b YA, ARAM.SongTempo : addw.b YA, ARAM.TempoSlideInc
            
            ; Check if the tempo slide timer is done:
            dec.b ARAM.TempoSlideTimer : bne .tempoSlideNotDone
                ; Set the tempo to the tempo slide target.
                movw.b YA, ARAM.TempoSlideTarget-1

            .tempoSlideNotDone

            movw.b ARAM.SongTempo, YA

        .noTempoSlide

        ; Perform some channel specific background tasks:

        ; Loop through each channel:
        mov.b X, #$00 : mov.b ARAM.ChannelOffset, X
        mov.b ARAM.ChanBit, #$01

        .nextChannel

            ; Check if the current channel is in use:
            mov.b A, ARAM.ChanInUse : and.b A, ARAM.ChanBit : beq .ChannelNotUsed
                call PerformVolumeAdjustments

                ; Check if we need to update the channel volume:
                mov.b A, ARAM.ChanUpdateVol : and.b A, ARAM.ChanBit : beq .noVolume
                    call CalculateVolume

                .noVolume

                call PerformPitchAdjustments

                ; Check if we need to update the channel pitch:
                mov.b A, ARAM.ChanUpdatePitch : and.b A, ARAM.ChanBit : beq .noPitch
                    call CalculatePitch

                .noPitch

            .ChannelNotUsed
                
            inc X : inc X : mov.b ARAM.ChannelOffset, X
        asl.b ARAM.ChanBit : bne .nextChannel

        mov.b A, #$00 : mov.b ARAM.ChanUpdateVol, A
                        mov.b ARAM.ChanUpdatePitch, A

        ; Loop.
        jmp EngineMain
    }

    DSPQueueRegisters:
    {
        db DSP.EVOLL ; 0x00
        db DSP.EVOLR ; 0x01
        db DSP.EFB   ; 0x02
        db DSP.EON   ; 0x03
        db DSP.FLG   ; 0x04
        db DSP.MVOLL ; 0x05
        db DSP.MVOLR ; 0x06
        db DSP.PMON  ; 0x07
        db DSP.KON   ; 0x08
        db DSP.KOFF  ; 0x09
        db DSP.NON   ; 0x0A
        db DSP.DIR   ; 0x0B
        db DSP.KOFF  ; 0x0C
    
        .From
        db ARAM.EchoVolLeftQ+1  ; 0x00 DSP.EVOLL
        db ARAM.EchoVolRightQ+1 ; 0x01 DSP.EVOLR
        db ARAM.EchoFeedbackQ   ; 0x02 DSP.EFB
        db ARAM.EchoOnQ         ; 0x03 DSP.EON
        db ARAM.FlagQ           ; 0x04 DSP.FLG
        db ARAM.MasterVolLeftQ  ; 0x05 DSP.MVOLL
        db ARAM.MasterVolRightQ ; 0x06 DSP.MVOLR
        db ARAM.PitchModQ       ; 0x07 DSP.PMON
        db ARAM.KeyOnQ          ; 0x08 DSP.KON
        db ARAM.Zero            ; 0x09 DSP.KOFF
        db ARAM.NoiseOnQ        ; 0x0A DSP.NON
        db ARAM.DirQ            ; 0x0B DSP.DIR
        db ARAM.KeyOffQ         ; 0x0C DSP.KOFF
    }

    ; ==========================================================================

    WriteToDSP:
    {
        mov.w SMP.DSPADDR, Y
        mov.w SMP.DSPDATA, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     A - The difference between the source and target value.
    ;     X - The amount of steps.
    ; Uses: $00-$03
    ; Create an increment value for X steps in A.
    MakeIncrement:
    {
        !negative = $00
        !flip = $02

        ; Before calling this function, we should have done a subtract to get 
        ; the difference between the 2 values. If that subtraction ended up 
        ; being negative the carry bit will have been set. We then rotate that 
        ; bit into some work RAM so that we can flip the input for the math.
        notc : ror.b !negative : bpl .positiveInput
            ; * -1
            eor.b A, #$FF : inc A

        .positiveInput

        ; Get the high byte of the increment.
        mov.b Y, #$00
        div YA, X : push A

        ; Get the low byte of the increment by dividing the remainder again as
        ; the high byte this time.
        mov.b A, #$00
        div YA, X

        pop Y

        ; Reload the current channel offset.
        mov.b X, ARAM.ChannelOffset

        ; Bleeds into the next function:
    }

    ; Input:
    ;     YA - The value to flip.
    ;    $00 - Bit 7 high if we need to flip YA.
    ; Uses: $00-$03
    ; This function flips the given YA value if the 7th bit of $00 is set. 
    YASignFlip:
    {
        !negative = $00
        !flip = $02

        ; If the given value was negative, flip it to be negative again.
        bbc7.b !negative, .keepPositive
            ; 0 minus the positive increment.
            movw.b !flip, YA
            movw.b YA, ARAM.Zero : subw.b YA, !flip

        .keepPositive

        ret
    }

    ; Input:
    ;     YA  - The base incrememnt.
    ;     $00 - Bit 7 high if we need to flip the increment.
    ; Uses: $00-$03
    ; This function flips the given YA value if the 7th bit of $00 is set. 
    AdjustValueByFrames:
    {
        !negative = $00
        !increment = $02

        ; Flip the incement to a positive value if needed.
        mov.b !negative, Y
        call YASignFlip : push Y

        ; Multiply the increment low byte by the song timer in case more than
        ; one frame has passed.
        mov.b Y, ARAM.SongTimer
        mul YA : mov.b !increment+0, Y
        mov.b !increment+1, #$00

        ; Do the same for the high byte.
        pop A
        mov.b Y, ARAM.SongTimer
        mul YA : addw.b YA, !increment

        call YASignFlip

        ret
    }

    ; ==========================================================================

    Get5A22Input:
    {
        ; Tell the 5A22 the current song or SFX being played.
        mov.b A, ARAM.CurrentArray+X : mov.w SMP.CPUIO0+X, A

        .wait

            ; TODO: Verify and reenable?
            ; Just in case the 5A22 was in the process of writing a new song
            ; or SFX to the APU, check it again to make sure it didn't change.
            mov.w A, SMP.CPUIO0+X
        ;cmp.w A, SMP.CPUIO0+X : bne .wait

        mov Y, A

        ; Check if we are already playing the same song/SFX.
        mov.b A, ARAM.LastArray+X
        mov.b ARAM.LastArray+X, Y
        ; TODO: Change to cbne when that is fixed.
        cmp.b A, ARAM.LastArray+X : bne .change
            ; If we are playing the same thing, don't play it again.
            mov.b Y, #$00 : mov.b ARAM.InputArray+X, Y

            ret

        .change

        ; Set the input song or SFX to the new song/SFX from the 5A22.
        mov.b ARAM.InputArray+X, Y

        ret
    }

    TransferNotesTo5A22:
    {
        mov.b A, $D0 : beq .transfer
            dec.b $D0

            ret

        .transfer

        ; Send the init message.
        mov.b A, #$69 : mov.w SMP.CPUIO2, A
                        mov.w SMP.CPUIO1, A
                        mov.b $00, A

        .waitForInit
            ; Wait for the SNES to initialize with the message #$69.
        cmp.w A, SMP.CPUIO1 : beq .SNESIsReady ; bne .waitForInit
            ret

        .SNESIsReady

        mov.b X, #$00

        .readLoop

            mov.w A, .ReadValues+0+X : mov.b $01, A
            mov.w A, .ReadValues+1+X : mov.b $02, A
            and.b A, $01 : cmp.b A, #$FF : beq .endOfReadLoop
                inc X : inc X : push x

                mov.b X, #$00
                mov.b Y, #$00

                bra .startReadLoop

                .loop
                    .waitForSNES
                        ; Wait for the SNES to initialize with the index of
                        ; the data.
                    cmp.w X, SMP.CPUIO2 : bne .waitForSNES

                    inc X

                    .startReadLoop

                    ; Send the data and its index.
                    mov.b A, ($01)+Y : mov.w SMP.CPUIO3, A
                    mov.w SMP.CPUIO2, X
                inc Y : inc Y : cmp.b Y, #$10 : bne .loop

                dec.b $00
                mov.b A, $00 : mov.w SMP.CPUIO1, A

                .waitForNext
                    ; Wait for the SNES to move on.
                cmp.w A, SMP.CPUIO1 : bne .waitForNext

                pop X
        bra .readLoop

        .endOfReadLoop

        ; Send the end message.
        ;dec.b $00
        ;mov.b A, $00 : mov.w SMP.CPUIO1, A

        ;.waitForEnd
            ; Wait for the SNES to end.
        ;cmp.w A, SMP.CPUIO1 : bne .waitForEnd

        ; TODO: DON'T SET CPUIO0!
        mov.b A, #$00 ;: mov.w SMP.CPUIO0, A
                        ;mov.w SMP.CPUIO1, A
                        mov.w SMP.CPUIO2, A
                        mov.w SMP.CPUIO3, A

        mov.b $D0, #$03

        ret

        .ReadValues
        dw ARAM.Chan_Note
        dw ARAM.Chan_Duration
        dw ARAM.Chan_Staccato
        dw ARAM.Chan_Instrument
        dw ARAM.Chan_FinalVol
        dw $FFFF
    }

    ; ==========================================================================

    NewSongInput:
    {
        ; TODO: check for song commands such as fade in and out.

        call ResetForNewSong

        ret
    }

    ; Reset various global and channel specific values for starting a new song.
    ResetForNewSong:
    {
        ; Set the current song.
        mov.b ARAM.CurrentSong, A

        ; Get the song pointer and set it to the current song segment.
        asl A : mov X, A
        mov.w A, SONG_POINTERS-1+X : mov Y, A
        mov.w A, SONG_POINTERS-2+X : movw.b ARAM.SegmentPtr, YA

        ; Set the channels that are being used by music to key off.
        mov.b A, ARAM.ChanInUseSong : eor.b A, #$FF : tset.w ARAM.KeyOffQ, A
        mov.b ARAM.ChanInUseSong, #$00
        
        call GetNextSegment

        mov.b X, #$00
        call NextSegmentSetup_skipCommandCheck
        
        ; Loop through each channel.
        mov.b X, #$00
        mov.b ARAM.ChanBit, #$01

        .nextChannel

            ; Set the current channel pan settings to equal on both sides.
            mov.b A, #$0A
            call TrackCommandE1_ChangePan_skipParameter

            ; Set the channel timers so that they will trigger next frame.
            mov.b A, #$01 : mov.b ARAM.Chan_Timer+X, A
                            mov.b ARAM.Chan_ReleaseTimer+X, A

            ; Set the channel note duration to a default value.
            mov.b A, #$20 : mov.w ARAM.Chan_Duration+X, A

            ; Set the channel staccato and attack to a default value.
            mov.b A, #$20 : mov.w ARAM.Chan_Staccato+X, A
            mov.b A, #$FC : mov.w ARAM.Chan_Attack+X, A

            ; Set the channel volume to max.
            mov.b A, #$FF : mov.w ARAM.Chan_Vol+1+X, A 

            ; Set a bunch of channel specific settings to 0.
            mov A, #$00 : mov.b ARAM.Chan_PartCounter+X, A
                          mov.w ARAM.Chan_Note+X, A
                          mov.w ARAM.Chan_Instrument+X, A
                          mov.w ARAM.Chan_TuneMult+X, A
                          mov.w ARAM.Chan_Transposition+X, A
                          mov.w ARAM.Chan_Tuning+X, A

                          mov.b ARAM.Chan_VolTimer+X, A
                          mov.w ARAM.Chan_Vol+0+X, A
                          ;mov.w ARAM.Chan_VolTarget+X, A
                          mov.w ARAM.Chan_Mute+0+X, A
                          mov.w ARAM.Chan_Mute+1+X, A
                          ;mov.w ARAM.Chan_VolInc+X, A

                          mov.b ARAM.Chan_PanTimer+X, A
                          mov.w ARAM.Chan_PanTarget+X, A
                          ;mov.w ARAM.Chan_PanInc+X, A
                          
                          mov.b ARAM.Chan_VbrSlideTimer+X, A
                          mov.b ARAM.Chan_VbrTemp+X, A
                          mov.w ARAM.Chan_VbrCalc+0+X, A
                          mov.w ARAM.Chan_VbrCalc+1+X, A
                          mov.w ARAM.Chan_VbrDelay+X, A
                          mov.w ARAM.Chan_VbrStrength+X, A
                          mov.w ARAM.Chan_VbrAcc+X, A
                          mov.w ARAM.Chan_VbrInc+X, A
                          mov.w ARAM.Chan_VbrIntensity+X, A
                          mov.w ARAM.Chan_VbrMaxIntensity+X, A
                          mov.w ARAM.Chan_VbrSlideWait+X, A
                          mov.w ARAM.Chan_VbrSlideInc+X, A

                          mov.b ARAM.Chan_TremTimer+X, A
                          ;mov.w ARAM.Chan_TremDelay+X, A
                          ;mov.w ARAM.Chan_TremInc+X, A
                          ;mov.w ARAM.Chan_TremIntensity+X, A
                          mov.w ARAM.Chan_TremAcc+X, A

                          mov.b ARAM.Chan_PitchSlideTimer+X, A
                          mov.b ARAM.Chan_PitchSlideWait+X, A
                          mov.b ARAM.Chan_PitchSlideTemp+X, A
                          ;mov.w ARAM.Chan_PitchSlideType+X, A
                          ;mov.w ARAM.Chan_PitchSlideDelay+X, A
                          ;mov.w ARAM.Chan_PitchSlideDuration+X, A
                          ;mov.w ARAM.Chan_PitchSlideTarget+X, A
                          mov.w ARAM.Chan_PitchSlideCalc+0+X, A
                          mov.w ARAM.Chan_PitchSlideCalc+1+X, A
                          ;mov.w ARAM.Chan_PitchSlideInc+0+X, A
                          ;mov.w ARAM.Chan_PitchSlideInc+1+X, A

            inc X : inc X
        asl.b ARAM.ChanBit : bne .nextChannel

        ; A will be 0 after the loop above.
        ; Set some global settings.
        mov.b ARAM.GlobalTransposition, A
        mov.b ARAM.GlobalVol+0, A
        mov.b ARAM.SongTempo+0, A
        mov.b ARAM.SongMute, A
        mov.b ARAM.PercussionBaseNote, A

        mov.b ARAM.TempoSlideTimer, A
        mov.b ARAM.TempoSlideTarget, A
        mov.b ARAM.TempoSlideInc+0, A
        mov.b ARAM.TempoSlideInc+1, A

        mov.b ARAM.EchoPanTimer, A

        mov.b ARAM.GlobalVol+1, #$FF
        mov.b ARAM.SongTempo+1, #$20
        mov.b ARAM.SongDelay, #$02

        ret
    }

    ; ==========================================================================

    ; Uses: $00-$01
    NextSegmentSetup:
    {
        !CurrentChanSegPtr = $00
        !CurrentChanDur = $00

        push X

        .attemptNextSegment

        ; Check the high byte for a command:
        call GetNextSegment : bne .notACommand
            ; Check the low byte for a valid command (0x00FF):
            mov Y, A : bne .validCommand
                pop X

                ; If not a valid command, mute the song.
                setc

                ret

            .validCommand

            ; Mute all music if #$80:
            cmp.b A, #$80 : beq .setMute
                ; Unmute all music if #$81:
                cmp.b A, #$81 : bne .setNumLoops
                    mov.b A, #$00

                    .setMute

                    mov.b ARAM.SongMute, A

                    ; Key off all channels currently being used by a song.
                    or.b ARAM.KeyOffQ, ARAM.ChanInUseSong

                    bra .attemptNextSegment

            .setNumLoops

            ; If anything else, use that as the number of times to loop the
            ; current segment:

            ; Decrement the number of segment loops. If the result is
            ; positive, don't set the number of loops again.
            dec.b ARAM.SegmentLoop : bpl .loopInProgress
                ; If the result is negative, set the number of loops again.
                ; Meaning that if the command low byte was 0x82-0xFF the
                ; segment will loop forever.
                mov.b ARAM.SegmentLoop, A

            .loopInProgress

            ; Get the pointer of the loop segment.
            call GetNextSegment

            mov.b ARAM.TEMPCurrentSegment, #$00

            ; If the segment loop counter is 0, that means we are done looping
            ; this segment and we need to move on to the next one.
            mov.b X, ARAM.SegmentLoop : beq .attemptNextSegment
                ; Set the sgement pointer to the loop segment.
                movw.b ARAM.SegmentPtr, YA

                bra .attemptNextSegment

        .notACommand

        pop X

        ; ALTERNATE ENTRY POINT
        .skipCommandCheck

        inc.b ARAM.TEMPCurrentSegment

        movw.b !CurrentChanSegPtr, YA

        ; Load the track pointer for each channel:
        mov.b Y, #$0F

        .loadPoiterTableLoop

            mov.b A, (!CurrentChanSegPtr)+Y : mov.w ARAM.Chan_SongPtr+Y, A
                                              mov.w ARAM.Chan_PartReturn+Y, A
        dec Y : bpl .loadPoiterTableLoop

        ; Save the current channel's timer so we can make the rest of 
        ; the channels reset as well later and Make sure the timer set
        ; is at least 1.
        mov.b A, ARAM.Chan_Timer+X : bne .notZero
            inc A
        
        .notZero
        mov.b !CurrentChanDur, A

        mov.b ARAM.ChanInUseSong, #$00

        ; Loop through each channel.
        mov.b X, #$00
        mov.b ARAM.ChanBit, #$01

        .nextChannel

            ; Check if the current channel will be in use for this segment:
            mov.b A, ARAM.Chan_SongPtr+1+X : bne .channelInUse
                ; If not, key off the current channel.
                or.b ARAM.KeyOffQ, ARAM.ChanBit

            .channelInUse

            ; Set the channel timers to the timer of the channel that triggered
            ; the next segment so that they don't become desynced.
            mov.b A, !CurrentChanDur : mov.b ARAM.Chan_Timer+X, A

            ; Make sure the release timer is at least 1.
            mov.b A, ARAM.Chan_ReleaseTimer+X : bne .notZeroRelease
                mov.b A, #$01 : mov.b ARAM.Chan_ReleaseTimer+X, A

            .notZeroRelease

            inc X : inc X
        asl.b ARAM.ChanBit : bne .nextChannel

        clrc

        ret
    }

    GetNextSegment:
    {
        ; Get the first segment pointer from the song data.
        mov.b Y, #$00
        mov.b A, (ARAM.SegmentPtr)+Y : push A
        incw.b ARAM.SegmentPtr
        
        mov.b A, (ARAM.SegmentPtr)+Y
        incw.b ARAM.SegmentPtr

        mov Y, A
        pop A

        ret
    }

    ; ==========================================================================

    RunMusic:
    {
        ; Check if we need to wait to play the song:
        mov.b A, ARAM.SongDelay : beq .noDelay
            dec.b ARAM.SongDelay
            
            ret

        .noDelay
        
        .redoChannels

        ; Loop through each channel:
        mov.b X, #$00 : mov.b ARAM.ChannelOffset, X
        mov.b ARAM.ChanBit, #$01

        .nextChannel

            ; Check if the current channel is in use by the song:
            mov.b A, ARAM.Chan_SongPtr+1+X : beq .channelNotUsed
                ; Check if the note has already been released:
                mov.b A, ARAM.Chan_ReleaseTimer+X : beq .alreadyReleased
                    ; Check if the note needs to be released:
                    dec.b ARAM.Chan_ReleaseTimer+X : beq .release
                        ; If the channel timer has hit 2 and the note has not
                        ; already been released we need to release it.
                        mov.b A, ARAM.Chan_Timer+X : cmp.b A, #$02 : bne .alreadyReleased
                            .release

                            call CheckForTie

                .alreadyReleased
                
                ; Check if the next note needs to be played:
                dec.b ARAM.Chan_Timer+X : bne .noteNotDone
                    ; Move on to the next note in the song. If carry
                    ; set, we hit the end of a segment and need to redo 
                    ; all of the channels.
                    call Tracker : bcs .redoChannels
                        ; If the song is muted, mute the note.
                        mov.b A, ARAM.SongMute : bne .mute
                            ; Key on queue the current channel.
                            mov.b A, ARAM.KeyOnQQ : and.b A, ARAM.ChanBit
                            or.b A, ARAM.KeyOnQ : mov.b ARAM.KeyOnQ, A

                            ; Remove the KeyOnQQ for the channel.
                            mov.b A, ARAM.ChanBit : tclr.w ARAM.KeyOnQQ, A

                        .mute
                        
                        ; Reset the note timer based on the channel duration.
                        mov.w A, ARAM.Chan_Duration+X : mov.b ARAM.Chan_Timer+X, A
                                                        mov.b Y, A

                        mov.w A, ARAM.Chan_Staccato+X
                        mul YA : mov.b A, Y
                                bne .notZero
                            inc A
                            
                        .notZero

                        ; TODO: Speed test line.
                        ;dec A : dec A

                        ; Set the channel release/staccato timer.
                        mov.b ARAM.Chan_ReleaseTimer+X, A

                .noteNotDone
            .channelNotUsed

            inc X : inc X : mov.b ARAM.ChannelOffset, X
        asl.b ARAM.ChanBit : bne .nextChannel

        ret
    }

    ; ==========================================================================

    ; Skim through the next bytes until we hit one with an actual duration
    ; and then check if it is a tie. If it is, we should not key off.
    ; Input:
    ;     X - The current channel.
    CheckForTie:
    {
        !tempPtr = $02

        mov.b A, ARAM.Chan_SongPtr+1+X : mov.b Y, A
        mov.b A, ARAM.Chan_SongPtr+0+X : movw.b !tempPtr, YA

        mov.b Y, #$00

        bra .nextByte

        .addParams

            mov.b X, A
            mov.b A, Y : clrc : adc.w A, TrackCommandParamCount-$E0+X : mov.b Y, A

            .nextByte
                
                mov.b A, (!tempPtr)+Y

                inc Y
            ; Check if the next byte is a duration or an end command.
            cmp.b A, #$80 : bcc .nextByte
        ; Check if the next byte is a command.
        cmp.b A, #$E0 : bcs .addParams

        ; Everything except for the tie should key off.
        cmp.b A, #$C8 : beq .tie
            or.b ARAM.KeyOffQ, ARAM.ChanBit

        .tie

        mov.b X, ARAM.ChannelOffset

        ret
    }

    TrackCommandParamCount:
    {
        db 1 ; TrackCommandE0_ChangeInstrument
        db 1 ; TrackCommandE1_ChangePan
        db 2 ; TrackCommandE2_PanSlide
        db 3 ; TrackCommandE3_SetVibrato
        db 0 ; TrackCommandE4_VibratoOff
        db 1 ; TrackCommandE5_GlobalVolume
        db 2 ; TrackCommandE6_GlobalVolumeSlide
        db 1 ; TrackCommandE7_SetTempo

        db 2 ; TrackCommandE8_TempoSlide
        db 1 ; TrackCommandE9_GlobalTranspose
        db 1 ; TrackCommandEA_ChannelTranspose
        db 3 ; TrackCommandEB_SetTremolo
        db 0 ; TrackCommandEC_TremoloOff
        db 1 ; TrackCommandED_ChannelVolume
        db 2 ; TrackCommandEE_ChannelVolumeSlide
        db 3 ; TrackCommandEF_CallPart

        db 1 ; TrackCommandF0_VibratoGradient
        db 3 ; TrackCommandF1_PitchSlideTo
        db 3 ; TrackCommandF2_PitchSlideFrom
        db 0 ; TrackCommandF3_PitchSlideStop
        db 1 ; TrackCommandF4_FineTuning
        db 3 ; TrackCommandF5_EchoBasicControl
        db 0 ; TrackCommandF6_EchoSilence
        db 3 ; TrackCommandF7_EchoFilter

        db 3 ; TrackCommandF8_EchoSlide
        db 3 ; TrackCommandF9_SlideOnce
        db 1 ; TrackCommandFA_PercussionOffset

        db 2 ; 0xFB
        db 0 ; 0xFC
        db 0 ; 0xFD
        db 0 ; 0xFE
    }

    ; Input:
    ;     X - The current channel.
    Tracker:
    {
        ; The current note is done, go to the next one.

        .instantNextByte

        ; Get the next note/command value from the song data.
        call GetTrackByte

        ; Check if the value is the end of the part/segment/song (0x00):
        bne .notEnd
            ; Check if we are running a part subroutine:
            mov.b A, ARAM.Chan_PartCounter+X : beq .notEndPart
                ; Decrease the part loop counter.
                dec.b ARAM.Chan_PartCounter+X : beq .endPart
                    ; Loop the part again by setting the track pointer to
                    ; the start of the part.
                    call IteratePartLoop

                    bra .instantNextByte

                .endPart

                ; If the part loop counter is 0, return from the part.
                mov.w A, ARAM.Chan_PartReturn+0+X : mov.w ARAM.Chan_SongPtr+0+X, A
                mov.w A, ARAM.Chan_PartReturn+1+X : mov.w ARAM.Chan_SongPtr+1+X, A

                bra .instantNextByte

            .notEndPart

            mov.b A, #$00 : mov.w ARAM.Chan_Note+X, A

            call NextSegmentSetup : bcc .notSongEnd
                ; The song has ended, mute the music.
                call MusicCommand_Mute

                ; Cancel the tracker loop.
                mov.b ARAM.ChanBit, #$00
                mov.b ARAM.ChannelOffset, #$00

                clrc

                ret

            .notSongEnd

            setc

            ret

        .notEnd
        
        ; Check if the value is a duration value for the channel
        ; (<= 0x7F > 0x00).
        bmi .notDuration
            ; Set the new duration value for the channel.
            mov.w ARAM.Chan_Duration+X, A
                
            ; Check the next byte for a staccato/attack setting: #$80 and 
            ; greater are notes or commands.
            mov.b A, (ARAM.Chan_SongPtr+X) : bmi .notAttackStaccato
                ; NOTE: Because this is in a nested if, that means the only way
                ; to set the staccato and attack is by doing it after setting
                ; the note duration.

                call SkipTrackByte
                                    
                push A

                ; Use bits 4-6 as the index to get the note staccato.
                xcn A : and.b A, #$07 : mov Y, A
                mov.w A, .NoteStaccato+Y : mov.w ARAM.Chan_Staccato+X, A

                ; Use bits 0-3 as the index to get the note
                ; attack.
                pop A : and.b A, #$0F : mov Y, A
                mov.w A, .NoteAttack+Y : mov.w ARAM.Chan_Attack+X, A

            .notAttackStaccato

            bra .instantNextByte

        .notDuration

        ; Check if the value is a command (>= 0xE0):
        cmp.b A, #$E0 : bcc .notCommand
            ; It is a command, execute it.
            call ExecuteTrackCommand

            bra .instantNextByte

        .notCommand

        ; Check if the value is a percussion value (>= 0xCA and <= 0xDF):
        cmp.b A, #$CA : bcc .notPercussion
            call TrackCommandE0_ChangeInstrument

            mov.b A, #$A4 ; Note C4

        .notPercussion

        ; Check if the note is a tie (0xC8).
        cmp.b A, #$C8 : beq .tie
            ; Check if the note is a rest (0xC9).
            cmp.b A, #$C9 : beq .rest
                ; If we got here, the value is a note ( >= 0x80 and <= 0xC7):
                and.b A, #$7F

                ; Add the channel transposition.
                clrc : adc.w A, ARAM.Chan_Transposition+X

                ; Apply global transposition.
                clrc : adc.b A, ARAM.GlobalTransposition

                ; Set the note value for the channel.
                mov.w ARAM.Chan_Note+X, A

                ; Reset some channel vibrato, tremolo, and pitch slide settings.
                mov.b A, #$00 : mov.w ARAM.Chan_VbrStrength+X, A
                                mov.w ARAM.Chan_VbrSlideTimer+X, A
                                mov.w ARAM.Chan_TremAcc+X, A
                                mov.b ARAM.Chan_TremTimer+X, A
                                mov.w ARAM.Chan_PitchSlideCalc+0+X, A
                                mov.w ARAM.Chan_PitchSlideCalc+1+X, A

                ; TODO: Speed test line.
                ;bra .noPitchSlideToFrom

                ; Set the current channel's pitch slide timer and check if it
                ; is 0:
                mov.w A, ARAM.Chan_PitchSlideDuration+X
                mov.b ARAM.Chan_PitchSlideTimer+X, A
                beq .noPitchSlideToFrom
                    ; Reset the pitch slide delay timer.
                    mov.w A, ARAM.Chan_PitchSlideDelay+X
                    mov.b ARAM.Chan_PitchSlideWait+X, A

                    ; Get the slide type. 0 for slide from and 1 for slide to.
                    mov.w A, ARAM.Chan_PitchSlideType+X : bne .notSlideFrom
                        ; Change the current note to be the target note.
                        mov.w A, ARAM.Chan_Note+X
                        setc : sbc.w A, ARAM.Chan_PitchSlideTarget+X
                        mov.w ARAM.Chan_Note+X, A

                    .notSlideFrom

                    ; Add the target offset to the current note, then calculate
                    ; the pitch slide increment.
                    mov.w A, ARAM.Chan_PitchSlideTarget+X
                    clrc : adc.w A, ARAM.Chan_Note+X
                    call TrackCommandF9_SlideOnce_calculateIncrement

                .noPitchSlideToFrom

                ; Mark that the channel is in use.
                or.b ARAM.ChanInUseSong, ARAM.ChanBit

                ; Mark that the channel needs to have its volume updated.
                or.b ARAM.ChanUpdateVol, ARAM.ChanBit

                ; Mark that the channel needs to have its pitch updated.
                or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

                ; Mark that we need to key on queue when the next timer
                ; runs out.
                or.b ARAM.KeyOnQQ, ARAM.ChanBit

                bra .note

            .rest

            mov.b A, #$00 : mov.w ARAM.Chan_Note+X, A

            ; Mark that the channel is not in use.
            mov.b A, ARAM.ChanBit : tclr.w ARAM.ChanInUseSong, A

            .note
        .tie

        ; Pitch slide once commands happen after handling a note instead of 
        ; before like all the rest of the commands.
        ; If there is an active pitch timer on the current channel, don't
        ; do anything.
        mov.b A, ARAM.Chan_PitchSlideTimer+X : bne .timerActive
            ; Get the next track command, if its not a slide once command, exit.
            mov.b A, (ARAM.Chan_SongPtr+X) : cmp.b A, #$F9 : bne .notSlideOnce
                ; We read the current byte eariler so now we need to skip it.
                call SkipTrackByte

                call TrackCommandF9_SlideOnce

            .notSlideOnce
        .timerActive

        clrc

        ret

        .NoteStaccato
        db $32, $65, $7F, $98, $B2, $CB, $E5, $FC

        .NoteAttack
        db $19, $32, $4C, $65, $72, $7F, $8C, $98
        db $A5, $B2, $BF, $CB, $D8, $E5, $F2, $FC  
    }

    GetTrackByte:
    {
        ; Get the current channel track pointer.
        mov.b A, (ARAM.Chan_SongPtr+X)

        ; Bleeds into the next function.
    }

    SkipTrackByte:
    {
        ; Increase the track pointer to the next byte.
        inc.b ARAM.Chan_SongPtr+X : bne .dontIncrementHigh
            inc.b ARAM.Chan_SongPtr+1+X

        .dontIncrementHigh

        mov Y, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The channel number.
    ; Uses: $00-$03
    ; Perform channel pitch related tasks such as channel pitch slide, vibrato,
    ; and vibrato slides.
    PerformPitchAdjustments:
    {
        !negative = $00
        !pitchCalc = $02

        ; TODO: Speed test line.
        ;bra .noPitchSlide

        ; Check if we are performing a pitch slide on the current channel:
        mov.b A, ARAM.Chan_PitchSlideTimer+X : beq .noPitchSlide
            ; TODO: Remove.
            ; Artificially slow down the pitch slide.
            mov.b A, ARAM.Chan_PitchSlideTemp+X : bne .slowPitch
                ; Check if we need to wait to perform the pitch slide:
                mov.b A, ARAM.Chan_PitchSlideWait+X : beq .delayFinished
                    ; Decrement the pitch slide wait timer.
                    dec.b ARAM.Chan_PitchSlideWait+X

                    mov.b A, #$06 : mov.b ARAM.Chan_PitchSlideTemp+X, A

                    bra .noPitchSlide

                .delayFinished

                ; Decrement the pitch slide timer.
                dec.b ARAM.Chan_PitchSlideTimer+X

                ; Add the increment to the pitch slide calc.
                mov.w A, ARAM.Chan_PitchSlideCalc+0+X
                clrc : adc.w A, ARAM.Chan_PitchSlideInc+0+X
                mov.w ARAM.Chan_PitchSlideCalc+0+X, A

                mov.w A, ARAM.Chan_PitchSlideCalc+1+X
                    adc.w A, ARAM.Chan_PitchSlideInc+1+X
                mov.w ARAM.Chan_PitchSlideCalc+1+X, A

                ; Mark that the channel needs to have its pitch updated.
                or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

                mov.b A, #$05 : mov.b ARAM.Chan_PitchSlideTemp+X, A

            .slowPitch

            dec.b ARAM.Chan_PitchSlideTemp+X
                    
        .noPitchSlide

        ; TODO: Speed test line.
        ;bra .noVibrato

        ; Check if there is a channel vibrato intensity set:
        mov.w A, ARAM.Chan_VbrIntensity+X : beq .noVibrato
            ; Check if there is a channel vibrato delay:
            mov.w A, ARAM.Chan_VbrStrength+X
            cmp.w A, ARAM.Chan_VbrDelay+X : bne .vibratoDelay
                ; Check if we want to gradually increase the intenisty instead
                ; of just setting it to the max:
                mov.w A, ARAM.Chan_VbrSlideTimer+X
                cmp.w A, ARAM.Chan_VbrSlideWait+X : bne .increment
                    ; Get the channel max vibrato intensity.
                    mov.w A, ARAM.Chan_VbrMaxIntensity+X

                    bra .setIntensity

                .increment
                
                inc.b ARAM.Chan_VbrSlideTimer+X

                mov Y, A : beq .initializing
                    mov.b A, ARAM.Chan_VbrIntensity+X

                .initializing

                ; Add the channel vibrato intensity slide increment.
                clrc : adc.w A, ARAM.Chan_VbrSlideInc+X

                .setIntensity
                
                ; Reset the vibrato intensity.
                mov.w ARAM.Chan_VbrIntensity+X, A

                ; TODO: Remove.
                ; Artificially slow down the vibrato.
                mov.b A, ARAM.Chan_VbrTemp+X : bne .dontAdd
                    mov.b A, #$03 : mov.b ARAM.Chan_VbrTemp+X, A

                    ; Add the channel vibrato increment to the vibrato
                    ; accumulator.
                    mov.w A, ARAM.Chan_VbrAcc+X
                    clrc : adc.w A, ARAM.Chan_VbrInc+X
                    mov.w ARAM.Chan_VbrAcc+X, A

                    ; TODO: This is an alternate way to calculate the vibrato
                    ; that also appears in alttp depending on the circumstance.
                    ; I am currently unsure of when each one occurs.
                    ;mov.b Y, ARAM.SongTimer
                    ;mov.w A, ARAM.Chan_VbrInc+X
                    ;mul YA : mov A, Y : clrc : adc.w A, ARAM.Chan_VbrAcc+X
                    ;mov.w ARAM.Chan_VbrAcc+X, A

                    bra .skip

                .dontAdd

                dec.b ARAM.Chan_VbrTemp+X

                mov.w A, ARAM.Chan_VbrAcc+X

                .skip

                ; Save the vibrato accumulator for later.
                mov.b !negative, A

                ; If negative, flip it:
                asl A : asl A : bcc .accNotNegative
                    ; TODO: Why do we not inc A here as well?
                    eor.b A, #$FF

                .accNotNegative

                mov Y, A

                ; Check if the intensity is negative:
                ; NOTE: I guess 0xF1-0xFF are the only values considered a
                ; valid negative.
                mov.w A, ARAM.Chan_VbrIntensity+X : cmp.b A, #$F1 : bcc .intenistyNotNegative
                    ; Make roughly not negative:
                    and.b A, #$0F

                    ; Multiply the vibrato accumulator by the intensity.
                    mul YA

                    bra .continue

                .intenistyNotNegative

                ; Multiply the vibrato accumulator by the intensity.
                mul YA : mov A, Y
                mov.b Y, #$00

                .continue

                call YASignFlip

                ; TODO: Change this to work RAM?
                             mov.w ARAM.Chan_VbrCalc+0+X, A
                mov.b A, Y : mov.w ARAM.Chan_VbrCalc+1+X, A

                ; Mark that the channel needs to have its pitch updated.
                or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

                bra .skipVibrato

            .vibratoDelay

            ; Increase the channel vibrato strength.
            inc.b A : mov.w ARAM.Chan_VbrStrength+X, A

            .skipVibrato

        .noVibrato

        ret
    }

    ; Input:
    ;     A - The instrument ID to change to.
    ;     X - The current channel.
    ; Uses: $00-$05
    CalculatePitch:
    {
        !firstPitchCalc = $00
        !secondPitchCalc = $02
        !finalPitchCalc = $04

        ; Apply the channel vibrato.
        mov.w A, ARAM.Chan_Tuning+X : clrc : adc.w A, ARAM.Chan_VbrCalc+0+X
        mov.b !firstPitchCalc+0, A
        mov.w A, ARAM.Chan_Note+X          : adc.w A, ARAM.Chan_VbrCalc+1+X
        mov.b !firstPitchCalc+1, A

        ; TODO: Speed test line.
        ; Apply the channel pitch slide value.
        mov.w A, ARAM.Chan_PitchSlideCalc+1+X : mov.b Y, A
        mov.w A, ARAM.Chan_PitchSlideCalc+0+X
        addw.b YA, !firstPitchCalc : movw.b !firstPitchCalc, YA

        mov.b Y, #$00

        ; TODO: Why?
        ; Adjust the note based on whether it is a high note, middle note, or
        ; low note.
        ; Check if the note is 𝅘𝅥𝅮E5 (the note, NOT the hex value) or higher:
        mov.b A, !firstPitchCalc+1 : setc : sbc.b A, #$34 : bcs .highNote
            ; Check if the note is 𝅘𝅥𝅮G2 or higher:
            mov.b A, !firstPitchCalc+1 : setc : sbc.b A, #$13 : bcs .middleNote
                ; Low note
                dec Y
                asl A

        .highNote

        ; Apply the adjustment to the pitch value if its high or low.
        addw.b YA, !firstPitchCalc : movw.b !firstPitchCalc, YA

        .middleNote

        ; Save the channel index.
        push X

        ; Take the high byte of the calculated pitch value x2 and divide it 
        ; by 0x18 to extract the note without its octave as the remainder. X 
        ; will  be the octave value.
        mov.b A, !firstPitchCalc+1 : asl A
        mov.b Y, #$00
        mov.b X, #$18
        div YA, X : asl A : mov X, A

        ; Get the difference between the tuning value for the note and the 
        ; next note on the scale. Example: If the note is Ds, get the 
        ; difference  between Ds and E.
        mov.w A, .NotePitchValues+1+Y : mov.b !secondPitchCalc+1, A
        mov.w A, .NotePitchValues+0+Y : mov.b !secondPitchCalc+0, A

        mov.w A, .NotePitchValues+3+Y : push A
        mov.w A, .NotePitchValues+2+Y

        pop Y
        subw.b YA, !secondPitchCalc+0

        ; Multiply the result of the difference by the low byte of the pitch
        ; value.
        mov.b Y, !firstPitchCalc
        mul YA : mov A, Y

        ; Add the result to the tuning value of the original note.
        mov.b Y, #$00
        addw.b YA, !secondPitchCalc+0 : mov.b !secondPitchCalc+1, Y

        ; Multiply the whole pitch value by 2.
        ;asl A
        ;rol.b !secondPitchCalc+1

        ; Crazy jump table to apply the octave shift that gemini came up with
        ; that avoids usinga loop.
        jmp (.pitchShiftTable+X)

        .pitchShiftTable
        dw .shift5, .shift4, .shift3, .shift2, .shift1, .noShifts

        .shift5
        lsr.b !secondPitchCalc+1
        ror A

        .shift4
        lsr.b !secondPitchCalc+1
        ror A

        .shift3
        lsr.b !secondPitchCalc+1
        ror A

        .shift2
        lsr.b !secondPitchCalc+1
        ror A

        .shift1
        lsr.b !secondPitchCalc+1
        ror A

        .noShifts

        ;bra .startOctaveLoop

        ; Divide the calculated pitch by 2 for every octave we need to go down
        ; starting at octave 6.
        ;.octaveLoop

            ;lsr.b !secondPitchCalc+1
            ;ror A

            ;inc X

            ;.startOctaveLoop
        ;cmp.b X, #$06 : bne .octaveLoop
        ; NOTE: You would think that this should be bcc instead of bne, but
        ; changing this to a bcc causes a bug where certain low notes can 
        ; become an extremly high pitched ring. I guess by making this loop 
        ; around 0xFF times to get back to a 0x06 fixes this.

        mov.b !secondPitchCalc+0, A

        ; Get the channel index back.
        pop X

        ; Apply some instrument high-level tuning.
        mov.w A, ARAM.Chan_TuneMult+0+X
        mov.b Y, !secondPitchCalc+1
        mul YA : movw.b !finalPitchCalc, YA

        mov.w A, ARAM.Chan_TuneMult+0+X
        mov.b Y, !secondPitchCalc+0
        mul YA : push Y

        mov.w A, ARAM.Chan_TuneMult+1+X
        mov.b Y, !secondPitchCalc+0
        mul YA : addw.b YA, !finalPitchCalc : movw.b !finalPitchCalc, YA

        mov.w A, ARAM.Chan_TuneMult+1+X
        mov.b Y, !secondPitchCalc+1
        mul YA : mov Y, A
        pop A : addw.b YA, !finalPitchCalc : movw.b !finalPitchCalc, YA

        ; Write to the DSP.VxPITCHL for the channel.
        mov A, X : xcn A : lsr A : or.b A, #$02 : mov Y, A
        mov.b A, !finalPitchCalc+0 : mov.w ARAM.Chan_FinalPitch+0+X, A
        call WriteToDSP

        ; Write to the DSP.VxPITCHH for the channel.
        inc Y
        mov.b A, !finalPitchCalc+1 : mov.w ARAM.Chan_FinalPitch+1+X, A
        call WriteToDSP

        ret

        .NotePitchValues
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

    ; Input:
    ;     X - The channel number.
    ; Uses: $00-$01
    ; Perform channel volume related tasks such as channel volume slide, 
    ; tremolo, tremolo slides, and pan slides.
    PerformVolumeAdjustments:
    {
        !addValue = $00

        ; TODO: Speed test line.
        ;bra .noChanVolumeSlide

        ; Check if we are performing a volume slide on the channel:
        mov.b A, ARAM.Chan_VolTimer+X : beq .noChanVolumeSlide
            mov.b A, ARAM.Chan_VolTemp+X : bne .noChanVolumeSlideTemp
                ; Decrement the channel volume slide timer and check if we
                ; need to stop the slide:
                dec.b ARAM.Chan_VolTimer+X : bne .chanVolSlideNotDone
                    ; Set the channel volume to the target volume.
                    mov.b A, #$00                  : mov.w ARAM.Chan_Vol+0+X, A
                    mov.w A, ARAM.Chan_VolTarget+X : mov.w ARAM.Chan_Vol+1+X, A

                    bra .chanVolSlideDone

                .chanVolSlideNotDone

                ; Add the increment to the volume.
                mov.w A, ARAM.Chan_Vol+0+X
                clrc : adc.w A, ARAM.Chan_VolInc+0+X
                mov.w ARAM.Chan_Vol+0+X, A

                mov.w A, ARAM.Chan_Vol+1+X
                    adc.w A, ARAM.Chan_VolInc+1+X
                mov.w ARAM.Chan_Vol+1+X, A

                .chanVolSlideDone

                ; Mark that the channel needs to have its volume updated.
                or.b ARAM.ChanUpdateVol, ARAM.ChanBit

                mov.b A, #$03 : mov.b ARAM.Chan_VolTemp+X, A

            .noChanVolumeSlideTemp

            dec.b ARAM.Chan_VolTemp+X

        .noChanVolumeSlide

        ; TODO: Speed test line.
        ;bra .noChanPanSlide

        ; Check if we are performing a pan slide on the channel:
        mov.b A, ARAM.Chan_PanTimer+X : beq .noChanPanSlide
            ; Decrement the channel pan slide timer and check if we
            ; need to stop the slide:
            dec.b ARAM.Chan_PanTimer+X : bne .chanPanSlideNotDone
                ; Set the channel volume to the target volume.
                mov.b A, #$00                  : mov.w ARAM.Chan_PanValue+0+X, A
                mov.w A, ARAM.Chan_PanTarget+X : mov.w ARAM.Chan_PanValue+1+X, A

                bra .chanPanSlideDone

            .chanPanSlideNotDone

            ; Make an incrament adjustment based on the frames passed.
            mov.w A, ARAM.Chan_PanInc+1+X : mov Y, A
            mov.w A, ARAM.Chan_PanInc+0+X
            call AdjustValueByFrames

            ; Add the increment to the pan value.
            clrc : adc.w A, ARAM.Chan_PanValue+0+X
            mov.w ARAM.Chan_PanValue+0+X, A

            mov.w A, Y
                   adc.w A, ARAM.Chan_PanValue+1+X
            mov.w ARAM.Chan_PanValue+1+X, A

            .chanPanSlideDone

            ; Mark that the channel needs to have its volume updated.
            or.b ARAM.ChanUpdateVol, ARAM.ChanBit
            
        .noChanPanSlide

        ; TODO: Speed test line.
        ;bra .noTremolo

        ; Check if we are perfomring a tremolo on the current channel:
        mov.w A, ARAM.Chan_TremIntensity+X : mov.b Y, A
                                             beq .noTremolo
            mov.b A, ARAM.Chan_TremTimer+X
            cmp.w A, ARAM.Chan_TremDelay+X : bne .tremoloNotReady
                ; Check if the tremolo accumulator is positive:
                mov.w A, ARAM.Chan_TremAcc+X : bpl .tremoloAccumulate
                    inc Y : bne .tremoloAccumulate
                        mov.b A, #$80

                        bra .skipIncrement

                .tremoloAccumulate

                ; Add the tremolo increment.
                clrc : adc.w A, ARAM.Chan_TremInc+X

                .skipIncrement

                ; Set the tremolo accumulator.
                mov.w ARAM.Chan_TremAcc+X, A

                ; Mark that the channel needs to have its volume updated.
                or.b ARAM.ChanUpdateVol, ARAM.ChanBit

                bra .skipTimer

            .tremoloNotReady

            ; Increase the tremolo timer.
            inc.b ARAM.Chan_TremTimer+X

            .skipTimer
        .noTremolo

        ret
    }

    ; Input:
    ;     X - The channel number.
    ; Uses: $00-$05
    ; Calculate the given channel volume based on the global volume, channel 
    ; volume, tremolo, attack, and pan settings. Then write the calculated
    ; volume to the DSP.
    CalculateVolume:
    {
        !addrWrite = $00
        !panValue = $02
        !calcVolume = $04

        mov.w A, ARAM.Chan_TremIntensity+X : beq .noTremolo
            mov.b Y, A

            ; TODO: Do some math I don't understand.
            mov.w A, ARAM.Chan_TremAcc+X : asl A : bcc .noPhaseInversion1
                eor.b A, #$FF

            .noPhaseInversion1

            ; Multiply the tremolo intensity for the current channel by
            ; the current tremolo accumulator.
            mul YA : mov A, Y : eor.b A, #$FF

            bra .tremolo

        .noTremolo

        mov.b A, #$FF

        .tremolo

        ; Multiply the calculated volume by the global volume.
        mov.b Y, ARAM.GlobalVol+1
        mul YA

        ; Multiply the calculated volume by the channel attack.
        mov.w A, ARAM.Chan_Attack+X
        mul YA

        ; Multiply the calculated volume by the channel volume.
        mov.w A, ARAM.Chan_Vol+1+X
        mul YA : mov A, Y

        ; Square the high byte of the result.
        mul YA : mov.w !calcVolume, Y

        ; Setup !addrWrite to point to DSP.VxVOLL.
        mov A, X : xcn A : lsr A : mov.b !addrWrite, A

        mov.w A, ARAM.Chan_PanValue+1+X : mov.b !panValue+1, A
        mov.w A, ARAM.Chan_PanValue+0+X : mov.b !panValue+0, A

        .volumeRight

            ; Do a bunch of math that applies the pan settings to the volume.
            mov.b Y, !panValue+1
            mov.w A, .LogisticFunc+1+Y : setc : sbc.w A, .LogisticFunc+0+Y

            mov.b Y, !panValue+0
            mul YA : mov A, Y

            mov.b Y, !panValue+1
            clrc : adc.w A, .LogisticFunc+0+Y : mov Y, A
            mov.w A, !calcVolume
            mul YA
            
            ; TODO: Do some math I don't understand.
            mov A, Y : bcc .noPhaseInversion2
                eor.b A, #$FF : inc A

            .noPhaseInversion2

            mov.w ARAM.Chan_FinalVol+X, A

            ; Ends up writing to DSP.VxVOLL and DSP.VxVOLR.
            mov.b Y, !addrWrite
            call WriteToDSP

            .volumeSame

            mov.b Y, #$14
            mov.b A, #$00
            subw.b YA, !panValue : movw.b !panValue+0, YA

            inc.b !addrWrite
        ; Repeat everything one more time for the right volume.
        bbc1.b !addrWrite, .volumeRight

        ;mov.b X, ARAM.ChannelOffset

        ret

        .LogisticFunc
        db $00, $01, $03, $07, $0D, $15, $1E, $29
        db $34, $42, $51, $5E, $67, $6E, $73, $77
        db $7A, $7C, $7D, $7E, $7F
    }

    ; ==========================================================================

    ConfigureEcho:
    {
        ; Set the echo delay queue.
        mov.b ARAM.EchoDelayQ, A

        ; Check if the current echo delay is the same:
        mov.b Y, #DSP.EDL : mov.w SMP.DSPADDR, Y
        mov.w A, SMP.DSPDATA : cmp.b A, ARAM.EchoDelayQ : beq .EchoDelaySame
            ; TODO: Do some math I don't understand to set the echo delay timer.
            and.b A, #$0F : eor.b A, #$FF
            bbc7.b ARAM.EchoTimer, .bufferReady
                clrc : adc.b A, ARAM.EchoTimer

            .bufferReady

            mov.b ARAM.EchoTimer, A

            mov.b Y, #$04

            ; Loop through 4 echo related DSP registers and zero them out.
            .writeRegisters

                ; Choose the DSP register to write to.
                mov.w A, DSPQueueRegisters-1+Y : mov.w SMP.DSPADDR, A

                ; Write 0 to that register.
                mov.b A, #$00 : mov.w SMP.DSPDATA, A
            ; TODO: Change to dbnz when thats fixed.
            dec y : bne .writeRegisters

            ; Write the flag queue to the DSP flag register.
            mov.b A, ARAM.FlagQ : or.b A, #$20
            mov.b Y, #DSP.FLG
            call WriteToDSP

            ; Write the echo delay queue to the DSP echo delay register.
            mov.b A, ARAM.EchoDelayQ
            mov.b Y, #DSP.EDL
            call WriteToDSP

        .EchoDelaySame

        ; TODO: I think this reference is wrong. I think its not actually meant
        ; to reference the song pointer here.
        ; Calculate the echo source address.
        asl A : asl A : asl A : eor.b A, #$FF
        setc : adc.b A, #SONG_POINTERS>>8

        ; Set the DSP echo source address.
        mov.b Y, #DSP.ESA 
        jmp WriteToDSP
    }

    ; ==========================================================================

    ExecuteTrackCommand:
    {
        ; Get the pointer for the command. The address is -0xC0 from the actual
        ; address of the command vectors because the commands index starts at 
        ; 0xE0. 0xE0 x2 is 0x01C0 and the 7th bit will get cut off by the asl
        ; leaving only 0xC0.  
        asl A : mov Y, A
        mov.w A, .TrackCommandVectors+1-$C0+Y : push A
        mov.w A, .TrackCommandVectors+0-$C0+Y : push A

        ret

        .TrackCommandVectors
        dw TrackCommandE0_ChangeInstrument
        dw TrackCommandE1_ChangePan
        dw TrackCommandE2_PanSlide
        dw TrackCommandE3_SetVibrato
        dw TrackCommandE4_VibratoOff
        dw TrackCommandE5_GlobalVolume
        dw TrackCommandE6_GlobalVolumeSlide
        dw TrackCommandE7_SetTempo

        dw TrackCommandE8_TempoSlide
        dw TrackCommandE9_GlobalTranspose
        dw TrackCommandEA_ChannelTranspose
        dw TrackCommandEB_SetTremolo
        dw TrackCommandEC_TremoloOff
        dw TrackCommandED_ChannelVolume
        dw TrackCommandEE_ChannelVolumeSlide
        dw TrackCommandEF_CallPart

        dw TrackCommandF0_VibratoGradient
        dw TrackCommandF1_PitchSlideTo
        dw TrackCommandF2_PitchSlideFrom
        dw TrackCommandF3_PitchSlideStop
        dw TrackCommandF4_FineTuning
        dw TrackCommandF5_EchoBasicControl
        dw TrackCommandF6_EchoSilence
        dw TrackCommandF7_EchoFilter

        dw TrackCommandF8_EchoSlide
        dw TrackCommandF9_SlideOnce
        dw TrackCommandFA_PercussionOffset
        dw TrackCommandFB ; 0xFB - Future Expansion
        dw TrackCommandFC ; 0xFC - Future Expansion
        dw TrackCommandFD ; 0xFD - Future Expansion
        dw TrackCommandFE ; 0xFE - Future Expansion
        dw TrackCommandFF ; 0xFF - Future Expansion
    }

    ; ==========================================================================

    ; Input:
    ;     A - The instrument ID to change to (If using the skipParameter).
    ;     X - The current channel.
    ; Uses: $00-$01
    ; Uses one byte parameter:
    ;     Byte 0: The index of the intrument to set.
    ; Track command 0xE0. Changes the channel instrument.
    TrackCommandE0_ChangeInstrument:
    {
        !InstrDataPtr = $00

        call GetTrackByte

        ; ALTERNATE ENTRY POINT
        .skipParameter

        ; TODO: Remove test code. Music Box
        ;mov.b A, #$1A

        ; Set the channel's instrument ID and check if it is a percussion value:
        mov.w ARAM.Chan_Instrument+X, A : bpl .notPercussion
            ; Add the percussion base note.
            setc : sbc.b A, #$CA : clrc : adc.b A, ARAM.PercussionBaseNote

        .notPercussion

        ; Get the index for the INSTRUMENT_DATA.
        mov.b Y, #$06
        mul YA : movw.b !InstrDataPtr, YA

        ; Get the address for the INSTRUMENT_DATA.
        clrc : adc.b !InstrDataPtr+0, #INSTRUMENT_DATA>>0
               adc.b !InstrDataPtr+1, #INSTRUMENT_DATA>>8

        push X

        ; Setup X to point to DSP.VxSRCN.
        mov A, X : xcn A : lsr A : or.b A, #$04 : mov X, A

        ; Get the ID (DSP.SRCN) for the intrument. If positive, its a normal
        ; sample.
        ; TODO: All of the IDs in the INSTRUMENT_DATA are positive so figure 
        ; out how percussion changes that.
        mov.b Y, #$00
        mov.b A, (!InstrDataPtr)+Y : bpl .normalSample
            ; TODO: What is this?
            and.b A, #$1F

            ; Reset everything except echo.
            and.b ARAM.FlagQ, #$20 : tset.w ARAM.FlagQ, A

            ; Enable noise generation on this channel.
            or.b ARAM.NoiseOnQ, ARAM.ChanBit

            mov A, Y

            bra .percussionStartLoop

        .normalSample

        ; Disable noise generation on the current channel.
        mov.b A, ARAM.ChanBit : tclr.w ARAM.NoiseOnQ, A

        ; Loop through the rest of the first 4 btyes of INSTRUMENT_DATA and
        ; write them to some DSP registers.
        ; This will write to: DSP.VxSRCN, VxADSR1, VxADSR2, and VxGAIN.
        mov.b Y, #$00
        
        .DSPWriteLoop

            mov.b A, (!InstrDataPtr)+Y

            .percussionStartLoop

            mov.w SMP.DSPADDR, X
            mov.w SMP.DSPDATA, A

            inc X
        inc Y : cmp.b Y, #$04 : bne .DSPWriteLoop

        ; Get the instrument high-level tuning multiplier.
        pop X
        mov.b A, (!InstrDataPtr)+Y : mov.w ARAM.Chan_TuneMult+1+X, A
        inc Y
        mov.b A, (!InstrDataPtr)+Y : mov.w ARAM.Chan_TuneMult+0+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     A - The pan setting to change to (If using the skipParameter).
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The pan setting.
    ; Track command 0xE0. Changes the channel instrument.
    TrackCommandE1_ChangePan:
    {
        call GetTrackByte

        ; ALTERNATE ENTRY POINT
        .skipParameter
        
        ; Set the channel pan settings.
                        mov.w ARAM.Chan_PanSetting+X, A
        and.b A, #$1F : mov.w ARAM.Chan_PanValue+1+X, A
        mov.b A, #$00 : mov.w ARAM.Chan_PanValue+0+X, A

        ret
    }

    ; Input:
    ;     X - The current channel.
    ; Uses two byte parameters:
    ;     Byte 0: The channel pan timer.
    ;     Byte 1: The channel pan target.
    ; Track command 0xE2. Sets up a channel pan slide.
    TrackCommandE2_PanSlide:
    {
        call GetTrackByte : mov.b ARAM.Chan_PanTimer+X, A
                            push A

        call GetTrackByte : mov.w ARAM.Chan_PanTarget+X, A

        ; Get the difference between the current pan value and the target
        ; and make an incrament based on the timer.
        setc : sbc.w A, ARAM.Chan_PanValue+1+X
        pop X
        call MakeIncrement : mov.w ARAM.Chan_PanInc+0+X, A
        mov A, Y           : mov.w ARAM.Chan_PanInc+1+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0: The channel vibrato delay.
    ;     Byte 1: The channel vibrato increment.
    ;     Byte 2: The channel vibrato max intensity.
    ; Track command 0xE3. Sets up channel vibrato.
    TrackCommandE3_SetVibrato:
    {
        call GetTrackByte : mov.w ARAM.Chan_VbrDelay+X, A
        call GetTrackByte : mov.w ARAM.Chan_VbrInc+X, A
        
        call GetTrackByte : mov.w ARAM.Chan_VbrIntensity+X, A
                            mov.w ARAM.Chan_VbrMaxIntensity+X, A

        mov.b A, #$00 : mov.w ARAM.Chan_VbrSlideWait+X, A

        ret
    }

    ; Input:
    ;     X - The current channel.
    ; Track command 0xE4. Turns off any channel vibrato.
    TrackCommandE4_VibratoOff:
    {
        mov.b A, #$00 : mov.w ARAM.Chan_VbrIntensity+X, A
                        mov.w ARAM.Chan_VbrMaxIntensity+X, A
                        mov.w ARAM.Chan_VbrSlideWait+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The high byte of the global volume.
    ; Track command 0xE5. Sets the high byte of the global volume.
    TrackCommandE5_GlobalVolume:
    {
        call GetTrackByte
        mov.b A, #$00 : movw.b ARAM.GlobalVol, YA

        ; Mark that each channel needs to have its volume updated.
        mov.b ARAM.ChanUpdateVol, #$FF

        ret
    }

    ; Uses two byte parameters:
    ;     Byte 0: The global volume slide timer.
    ;     Byte 1: The global volume slide target.
    ; Track command 0xE6. Sets up a global volume slide timer.
    TrackCommandE6_GlobalVolumeSlide:
    {
        call GetTrackByte

        ; TODO: Temp code to artificially extend the length of the global
        ; volume slide timer.
        asl A : asl A : asl A : mov.b ARAM.GlobalVolTimer, A
                                push A

        call GetTrackByte : mov.b ARAM.GlobalVolTarget, A

        ; Get the increment between the current global volume and 
        ; the target based on the timer.
        setc : sbc.b A, ARAM.GlobalVol+1
        pop X
        call MakeIncrement : movw.b ARAM.GlobalVolInc, YA

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The high byte of the song tempo.
    ; Track command 0xE7. Sets the high byte of the song tempo.
    TrackCommandE7_SetTempo:
    {
        ; Set the song tempo high byte and zero out the low byte.
        call GetTrackByte

        mov.b A, #$00 : movw.b ARAM.SongTempo, YA

        ret
    }

    ; Uses two byte parameters:
    ;     Byte 0: The tempo timer.
    ;     Byte 1: The tempo target.
    ; Track command 0xE2. Sets up a tempo slide.
    TrackCommandE8_TempoSlide:
    {
        call GetTrackByte : mov.b ARAM.TempoSlideTimer, A
                            push A

        call GetTrackByte : mov.b ARAM.TempoSlideTarget, A

        ; Get the tempo slide increment between the current tempo and the target
        ; based on the timer.
        setc : sbc.b A, ARAM.SongTempo+1
        pop X
        call MakeIncrement : movw.b ARAM.TempoSlideInc, YA

        ret
    }

    ; ==========================================================================

    ; Uses one byte parameter:
    ;     Byte 0: The global transposition.
    ; Track command 0xE9. Sets the song global transposition.
    TrackCommandE9_GlobalTranspose:
    {
        call GetTrackByte : mov.b ARAM.GlobalTransposition, A

        ; Mark that the channel needs to have its pitch updated.
        or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

        ret
    }

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The channel transposition.
    ; Track command 0xEA. Sets the given channel's transposition.
    TrackCommandEA_ChannelTranspose:
    {
        call GetTrackByte : mov.w ARAM.Chan_Transposition+X, A

        ; Mark that the channel needs to have its pitch updated.
        or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0: The channel tremolo delay.
    ;     Byte 1: The channel tremolo increment.
    ;     Byte 2: The channel tremolo intensity.
    ; Track command 0xEB. Sets up channel tremolo.
    TrackCommandEB_SetTremolo:
    {
        call GetTrackByte : mov.w ARAM.Chan_TremDelay+X, A
        call GetTrackByte : mov.w ARAM.Chan_TremInc+X, A
        call GetTrackByte : mov.w ARAM.Chan_TremIntensity+X, A

        ret
    }

    ; Input:
    ;     X - The current channel.
    ; Track command 0xEC. Cancels channel tremolo.
    TrackCommandEC_TremoloOff:
    {
        mov.b A, #$00 : mov.w ARAM.Chan_TremIntensity+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The high byte of the volume to set.
    ; Track command 0xED. Sets the channel volume.
    TrackCommandED_ChannelVolume:
    {
        ; Set the channel volume high byte and zero out the low byte.
        call GetTrackByte : mov.w ARAM.Chan_Vol+1+X, A
        mov.b A, #$00     : mov.w ARAM.Chan_Vol+0+X, A

        ; Mark that the channel needs to have its volume updated.
        or.b ARAM.ChanUpdateVol, ARAM.ChanBit

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses two byte parameters:
    ;     Byte 0: The channel volume slide timer
    ;     Byte 1: The channel volume slide target.
    ; Track command 0xE6. Sets up a channel volume slide timer.
    TrackCommandEE_ChannelVolumeSlide:
    {
        call GetTrackByte : mov.b ARAM.Chan_VolTimer+X, A
                            push A

        call GetTrackByte : mov.w ARAM.Chan_VolTarget+X, A

        ; Get the increment between the current channel volume and 
        ; the target based on the timer.
        setc : sbc.w A, ARAM.Chan_Vol+1+X
        pop X
        call MakeIncrement : mov.w ARAM.Chan_VolInc+0+X, A
        mov A, Y           : mov.w ARAM.Chan_VolInc+1+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0-1: The address of the part to call.
    ;     Byte   2: The number of times to loop the part.
    ; Track command 0xEF. Sets up a part call.
    TrackCommandEF_CallPart:
    {
        ; Set the current channel part address.
        call GetTrackByte : mov.w ARAM.Chan_PartAddr+0+X, A
        call GetTrackByte : mov.w ARAM.Chan_PartAddr+1+X, A

        ; Set the current channel loop count. (How many times the part
        ; will loop.)
        call GetTrackByte : mov.b ARAM.Chan_PartCounter+X, A

        ; Take the current track pointer and save it as the return address for
        ; when the part is completed.
        mov.b A, ARAM.Chan_SongPtr+0+X : mov.w ARAM.Chan_PartReturn+0+X, A
        mov.b A, ARAM.Chan_SongPtr+1+X : mov.w ARAM.Chan_PartReturn+1+X, A

        ; Bleeds into the next function.
    }

    ; Input:
    ;     X - The current channel.
    ; Sets the channel track pointer to the start of the channel part.
    IteratePartLoop:
    {
        ; Set the current channel pointer to the start of the channel's
        ; part address.
        mov.w A, ARAM.Chan_PartAddr+0+X : mov.b ARAM.Chan_SongPtr+0+X, A
        mov.w A, ARAM.Chan_PartAddr+1+X : mov.b ARAM.Chan_SongPtr+1+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The gradient wait.
    ; Track command 0xF0. Sets up a channel vibrato gradient.
    TrackCommandF0_VibratoGradient:
    {
        call GetTrackByte : mov.w ARAM.Chan_VbrSlideWait+X, A
                            push A

        ; Get the channel vibrato intensity and divide it by gradient wait.
        mov.b Y, #$00
        mov.w A, ARAM.Chan_VbrIntensity+X
        pop X
        div YA, X

        ; Reload the channel offset and set the vibrato increment.
        mov.b X, ARAM.ChannelOffset
        mov.w ARAM.Chan_VbrSlideInc+X, A

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0: The pitch slide delay.
    ;     Byte 1: The pitch slide timer.
    ;     Byte 2: The pitch slide target.
    ; Track command 0xF1. Sets up a continual pitch slide to.
    TrackCommandF1_PitchSlideTo:
    {
        mov.b A, #$01

        bra TrackCommandF2_PitchSlideFrom_start
    }

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0: The pitch slide delay.
    ;     Byte 1: The pitch slide timer.
    ;     Byte 2: The pitch slide target.
    ; Track command 0xF2. Sets up a continual pitch slide from.
    TrackCommandF2_PitchSlideFrom:
    {
        mov.b A, #$00

        ; ALTERNATE ENTRY POINT
        .start

        mov.w ARAM.Chan_PitchSlideType+X, A
        
        call GetTrackByte : mov.w ARAM.Chan_PitchSlideDelay+X, A
        call GetTrackByte : mov.w ARAM.Chan_PitchSlideDuration+X, A
        call GetTrackByte : mov.w ARAM.Chan_PitchSlideTarget+X, A

        ret
    }

    ; Input:
    ;     X - The current channel.
    ; Track command 0xF3. Stops a continual pitch slide from or from.
    TrackCommandF3_PitchSlideStop:
    {
        mov.b A, #$00 : mov.w ARAM.Chan_PitchSlideDuration+X, A
                        mov.w ARAM.Chan_PitchSlideDelay+X, A
        
        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses one byte parameter:
    ;     Byte 0: The fine tuning value to set.
    ; Track command 0xF4. Sets the channel fine tuning.
    TrackCommandF4_FineTuning:
    {
        ; Set the current channel fine pitch tuning.
        call GetTrackByte : mov.w ARAM.Chan_Tuning+X, A

        ; Mark that the channel needs to have its pitch updated.
        or.b ARAM.ChanUpdatePitch, ARAM.ChanBit

        ret
    }

    ; ==========================================================================
    
    ; Uses three byte parameters:
    ;     Byte 0: The channels to enable echo on.
    ;     Byte 1: The left echo volume.
    ;     Byte 2: The right echo volume.
    ; Track command 0xF5. Sets up echo.
    TrackCommandF5_EchoBasicControl:
    {
        ; Enable echo on the given channels.
        call GetTrackByte : mov.b ARAM.SongEchoEnable, A
                            mov.b ARAM.EchoOnQ, A

        ; Set the echo volume left queue.
        call GetTrackByte
        mov.b A, #$00 : movw.b ARAM.EchoVolLeftQ, YA

        ; Set the echo volume right queue.
        call GetTrackByte
        mov.b A, #$00 : movw.b ARAM.EchoVolRightQ, YA

        ; Clear the DSP.FLG queue disable echo flag.
        clr5.b ARAM.FlagQ

        ret
    }

    ; Track command 0xF6. Stops all echo.
    TrackCommandF6_EchoSilence:
    {
        ; Set the left and right echo volume queues to 0.
        mov.b A, #$00 : mov.b ARAM.EchoVolLeftQ+0, A
                        mov.b ARAM.EchoVolLeftQ+1, A
                        mov.b ARAM.EchoVolRightQ+0, A
                        mov.b ARAM.EchoVolRightQ+1, A

        ; Set the DSP.FLG queue disable echo flag.
        set5.b ARAM.FlagQ

        ret
    }

    ; Uses three byte parameters:
    ;     Byte 0: The echo delay.
    ;     Byte 1: The echo feedback.
    ;     Byte 2: The echo filter parameter.
    ; Track command 0xF7. Sets up the echo filter.
    TrackCommandF7_EchoFilter:
    {
        ; Set the echo delay queue and setup a bunch of other settings based
        ; on that.
        call GetTrackByte

        call ConfigureEcho

        ; Get the next byte and set the echo feedback queue.
        call GetTrackByte : mov.b ARAM.EchoFeedbackQ, A

        ; Get the next byte as the echo filter parameter index.
        call GetTrackByte
        mov.b Y, #$08
        mul YA : mov X, A

        ; Loop through each of filter parameters and write them to each of
        ; the coefficients.
        mov.b Y, #DSP.FIR

        .setNextFilter

            mov.w A, .EchoFilterParameters+X
            call WriteToDSP

            inc X

            mov A, Y : clrc : adc.b A, #$10 : mov Y, A
        bpl .setNextFilter

        ; Reload the channel offset.
        mov.b X, ARAM.ChannelOffset

        ret

        .EchoFilterParameters
        db $7F, $00, $00, $00, $00, $00, $00, $00
        db $58, $BF, $DB, $F0, $FE, $07, $0C, $0C
        db $0C, $21, $2B, $2B, $13, $FE, $F3, $F9
        db $34, $33, $00, $D9, $E5, $01, $FC, $EB
    }

    ; Uses three byte parameters:
    ;     Byte 0: The echo pan timer.
    ;     Byte 1: The left echo pan target.
    ;     Byte 2: The right echo pan target.
    ; Track command 0xF8. Sets an echo pan slide.
    TrackCommandF8_EchoSlide:
    {
        ; Set the echo pan timer.
        call GetTrackByte : mov.b ARAM.EchoPanTimer, A

        ; Set the echo left target.
        call GetTrackByte : mov.b ARAM.EchoPanLeftTarget, A

        ; Calculate the echo slide left increment.
        setc : sbc.b A, ARAM.EchoVolLeftQ+1
        mov.b X, ARAM.EchoPanTimer
        call MakeIncrement : movw.b ARAM.EchoPanLeftInc, YA

        ; Set the echo right target.
        call GetTrackByte : mov.b ARAM.EchoPanRightTarget, A

        ; Calculate the echo slide right increment.
        setc : sbc.b A, ARAM.EchoVolRightQ+1
        mov.b X, ARAM.EchoPanTimer
        call MakeIncrement : movw.b ARAM.EchoPanRightInc, YA

        ret
    }

    ; ==========================================================================

    ; Input:
    ;     X - The current channel.
    ; Uses three byte parameters:
    ;     Byte 0: The pitch slide delay.
    ;     Byte 1: The pitch slide timer.
    ;     Byte 2: The pitch slide target.
    ; Track command 0xF9. Sets up a pitch slide once instance.
    TrackCommandF9_SlideOnce:
    {
        ; Set the channel pitch slide wait.
        call GetTrackByte : mov.b ARAM.Chan_PitchSlideWait+X, A

        ; Set the channel pitch slide timer.
        call GetTrackByte : mov.b ARAM.Chan_PitchSlideTimer+X, A

        ; Get target note, add the channel transposition, global transposition,
        ; and then set the note value for the channel.
        call GetTrackByte : and.b A, #$7F
        clrc : adc.w A, ARAM.Chan_Transposition+X
        clrc : adc.b A, ARAM.GlobalTransposition

        ; ALTERNATE ENTRY POINT
        .calculateIncrement

        ; Make the difference positive, then subtract the current note.
        setc : sbc.w A, ARAM.Chan_Note+X

        ; Get the channel pitch slide timer. Theres no mov X, Y, so instead
        ; use the stack to move the timer into Y without touching A.
        mov.b Y, ARAM.Chan_PitchSlideTimer+X : push Y : pop X

        ; Make an increment between the target note and the current pitch value.
        call MakeIncrement : mov.w ARAM.Chan_PitchSlideInc+0+X, A
        mov A, Y           : mov.w ARAM.Chan_PitchSlideInc+1+X, A

        ; ALTERNATE ENTRY POINT
        .exit

        ret
    }

    ; ==========================================================================

    ; Uses one byte parameter:
    ;     Byte 0: The percussion base note.
    ; Track command 0xFA. Sets the percussion base note.
    TrackCommandFA_PercussionOffset:
    {
        ; Set the percussion base note.
        call GetTrackByte : mov.b ARAM.PercussionBaseNote, A

        ret
    }

    ; ==========================================================================

    ; TODO: Future Expansion.
    TrackCommandFB:
    TrackCommandFC:
    TrackCommandFD:
    TrackCommandFE:
    TrackCommandFF:
    {
        ret
    }

    ; ==========================================================================

    MusicCommand_Mute:
    {
        ; Key off queue the channels being used by the music.
        or.b ARAM.KeyOffQ, ARAM.ChanInUseSong

        ; Mark that all channels are not in use by the music.
        mov.b A, #$00 : mov.b ARAM.ChanInUseSong, A

        ; Set the current and last song to 0.
        mov.b ARAM.CurrentSong, A
        mov.b ARAM.LastSong, A

        ret
    }

    ; ==========================================================================
    print "End of SPC Engine:  $", pc

    SPC_ENGINE_end:

    assert pc() <= $17C0, "SPC Engine exceeds SFX_DATA: ", pc

    base off

    arch 65816
}

; ==============================================================================

print "End of Bank 0x05:   $", pc
print " "