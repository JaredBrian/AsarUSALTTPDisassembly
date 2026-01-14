; ==============================================================================
; Symbols for the audio processing unit
; ==============================================================================

; Shorthand legend:
; Acc = Accumulator
; Addr = Address
; Calc = Calculation
; Chan = Channel
; CMD = Command
; IPL = Initial Program Load
; Mult = Multiplier
; Q = Queue
; Ptr = Pointer
; SFX = Sound Effect
; Src = Source
; Trem = Tremolo
; Vbr = Vibrato
; Vol = Volume

struct ARAM $0000
{
    ; ===========================================================================
    ; Direct Page 0x00
    ; ===========================================================================
    
    ; $00[0x01] - (I/O, Song)
    .InputSong: skip $01
        ; The song input value from from the 5A22.

    ; $01[0x01] - (I/O, Ambient)
    .InputAmbient: skip $01
        ; The ambient input value from from the 5A22.

    ; $02[0x01] - (I/O, SFX2)
    .InputSFX2: skip $01
        ; The SFX2 input value from from the 5A22.

    ; $03[0x01] - (I/O, SFX3)
    .InputSFX3: skip $01
        ; The SFX3 input value from from the 5A22.


    ; $04[0x01] - (I/O, Song)
    .CurrentSong: skip $01
        ; The currently playing song sent back to the 5A22 over I/O.

    ; $05[0x01] - (I/O, Ambient)
    .CurrentAmbient: skip $01
        ; The currently playing Ambient sent back to the 5A22 over I/O.

    ; $06[0x01] - (I/O, SFX2)
    .CurrentSFX2: skip $01
        ; The currently playing SFX2 sent back to the 5A22 over I/O.

    ; $07[0x01] - (I/O, SFX3)
    .CurrentSFX3: skip $01
        ; The currently playing SFX3 sent back to the 5A22 over I/O.


    ; $08[0x01] - (Song)
    .LastSong: skip $01
        ; The last song that the APU was told to play.

    ; $09[0x01] - (Ambient)
    .LastAmbient: skip $01
        ; The last Ambient that the APU was told to play.

    ; $0A[0x01] - (SFX2)
    .LastSFX2: skip $01
        ; The last SFX2 that the APU was told to play.

    ; $0B[0x01] - (SFX3)
    .LastSFX3: skip $01
        ; The last SFX3 that the APU was told to play.


    ; $0C[0x01] - (Song)
    .SongDelay: skip $01
        ; Provides a short delay when changing songs.

    ; $0D[0x01] - (Free)
    .Free_0D: skip $01
        ; Free RAM.

    ; $0E[0x02] - (Main)
    .Zero: skip $02
        ; Always expected to hold the value 0x0000. Used to give YA a value
        ; of 0x0000. Also used to un-key off every channel each loop.

    ; $10[0x01] - (Main)
    .Work_10: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $11[0x01] - (Main)
    .Work_11: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $12[0x01] - (Main)
    .Work_12: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $13[0x01] - (Pitch)
    .DoPitch: skip $01
        ; Flags that some sort of pitch change is being made.
        ; p... ....
        ; p - Run change

    ; $14[0x01] - (Main)
    .Work_14: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $15[0x01] - (Main)
    .Work_15: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $16[0x01] - (Main)
    .Work_16: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $17[0x01] - (Main)
    .Work_17: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $18[0x01] - (Junk)
    .Junk_18: skip $01
        ; Manipulated every loop, but to seemingly no effect.

    ; $19[0x01] - (Junk)
    .Junk_19: skip $01
        ; Manipulated every loop, but to seemingly no effect.

    ; $1A[0x01] - (Channel)
    .ChannelsInUse: skip $01
        ; Flags channels currently in use by ambient, SFX, or songs.

    ; $1B[0x01] - (Song)
    .SongMute: skip $01
        ; Disables currently playing song. TODO: When non-zero?

    ; $1C[0x04] - (Free)
    .Free_1C: skip $04
        ; Free RAM.

    ; $20[0x01] - (SFX, Pan)
    .SFXPan: skip $01
        ; Indicates pan of current SFX. The left takes priority.
        ; lr.. ....
        ; l - pan left
        ; r - pan right

    ; $21[0x0B] - (Free)
    .Free_21: skip $0B
        ; Free RAM.

    ; $2C[0x02] - (SFX)
    .SFXPtr: skip $02
        ; The SFX data pointer.

    ; $2E[0x02] - (Free)
    .Free_2E: skip $02
        ; Free RAM.

    ; $30[0x02] - (Channel, Song)
    .Chan0_Ptr: skip $02
        ; The song pointer for channel 0.

    ; $32[0x02] - (Channel, Song)
    .Chan1_Ptr: skip $02
        ; The song pointer for channel 1.

    ; $34[0x02] - (Channel, Song)
    .Chan2_Ptr: skip $02
        ; The song pointer for channel 2.

    ; $36[0x02] - (Channel, Song)
    .Chan3_Ptr: skip $02
        ; The song pointer for channel 3.

    ; $38[0x02] - (Channel, Song)
    .Chan4_Ptr: skip $02
        ; The song pointer for channel 4.

    ; $3A[0x02] - (Channel, Song)
    .Chan5_Ptr: skip $02
        ; The song pointer for channel 5.

    ; $3C[0x02] - (Channel, Song)
    .Chan6_Ptr: skip $02
        ; The song pointer for channel 6.

    ; $3E[0x02] - (Channel, Song)
    .Chan7_Ptr: skip $02
        ; The song pointer for channel 7.

    ; $40[0x02] - (Segment)
    .SegmentPtr: skip $02
        ; The pointer to current song's segments.

    ; $42[0x01] - (Segment)
    .SegmentLoop: skip $01
        ; The number of times to loop the current song segment.

    ; $43[0x01] - (SFX, Timer)
    .SFXTimer: skip $01
        ; This has 0x38 Added to it for every tick that passes on timer 0.
        ; If the result added is greater than 0xFF, we need to take new sfx
        ; input from the 5A22 and handle the current SFX.

    ; $44[0x01] - (Channel)
    .ChannelOffset: skip $01
        ; Caches channel offset index when the X register (which usually holds
        ; the channel offset) is required.

    ; $45[0x01] - (DSP, I/O)
    .KeyOnQ: skip $01
        ; The DSP.KON (Key on) queue.

    ; $46[0x01] - (DSP, I/O)
    .KeyOffQ: skip $01
        ; The DSP.KOFF (Key off) queue.

    ; $47[0x01] - (Channel)
    .ChanBit: skip $01
        ; This is the current channel offset but represented by an individual bit.
        ; Only one bit will ever be set at a time.
        ; This is equal to 2^(ChannelOffset or the channel number).
        ; 7654 3210
        ; # - The channel number.

    ; $48[0x01] - (DSP, I/O)
    .FlagQ: skip $01
        ; The DSP.FLG (Flag) queue.

    ; $49[0x01] - (DSP, I/O)
    .NoiseOnQ: skip $01
        ; The DSP.NON (Noise Enable) queue.

    ; $4A[0x01] - (DSP, I/O, Echo)
    .EchoOnQ: skip $01
        ; The DSP.EON (Echo Enable) queue.

    ; $4B[0x01] - (DSP, I/O, Pitch)
    .PitchModQ: skip $01
        ; The DSP.PMON (Pitch Modulation) queue.

    ; $4C[0x01] - (Echo, Timer)
    .EchoTimer: skip $01
        ; A timer to prevent certain things until it reaches the same 
        ; value as $4D (EchoDelayQ).

    ; $4D[0x01] - (DSP, I/O, Echo)
    .EchoDelayQ: skip $01
        ; The DSP.EDL (Echo Delay) queue.

    ; $4E[0x01] - (DSP, I/O, Echo)
    .EchoFeedbackQ: skip $01
        ; The DSP.EFB (Echo Feedback) queue.

    ; $4F[0x01] - (Free)
    .Free_4F: skip $01
        ; Free RAM.

    ; $50[0x01] - (Transposition)
    .GlobalTransposition: skip $01
        ; The global transposition.

    ; $51[0x01] - (Song, Timer)
    .SongTimer: skip $01
        ; This has the Tempo high byte ($53) Added to it for every tick that 
        ; passes on timer 0. If the result added is greater than 0xFF, we need
        ; to take new song input from the 5A22 and handle the current song.

    ; $52[0x02] - (Song, Tempo)
    .SongTempo: skip $02
        ; The song tempo.

    ; $54[0x01] - (Song, Tempo, Timer)
    .TempoSlideTimer: skip $01
        ; The tempo slide duration.

    ; $55[0x01] - (Song, Tempo)
    .TempoSlideTarget: skip $01
        ; The target tempo slide value.

    ; $56[0x02] - (Song, Tempo)
    .TempoSlideIncrement: skip $02
        ; The tempo slide increment.

    ; $58[0x02] - (Song, Volume)
    .GlobalVol: skip $02
        ; The global volume.

    ; $5A[0x01] - (Song, Volume, Timer)
    .GlobalVolTimer: skip $01
        ; The global volume slide timer.

    ; $5B[0x01] - (Song, Volume)
    .GlobalVolTarget: skip $01
        ; Global volume slide target.

    ; $5C[0x02] - (Song, Volume)
    .GlobalVolIncrement: skip $02
        ; Global volume slide increment.

    ; $5E[0x01] - (Song, SFX, Ambient)
    .SpecialEffects: skip $01
        ; Flags channels that have some special effect being applied to it.

    ; $5F[0x01] - (Song, Precussion)
    .PrecussionBaseNote: skip $01
        ; The base note that will be added to the percussion commands (0xCA-0xDF)
        ; When playing a percussion note.

    ; $60[0x02] - (DSP, I/O, Echo)
    .EchoVolLeftQ: skip $02
        ; The DSP.EVOLL (Echo Volume Left) queue.

    ; $62[0x02] - (DSP, I/O, Echo)
    .EchoVolRightQ: skip $02
        ; The DSP.EVOLR (Echo Volume Right) queue.

    ; $64[0x02] - (Echo)
    .EchoPanLeftIncrement: skip $02
        ; Echo volume left panning Increment.

    ; $66[0x02] - (Echo)
    .EchoPanRightIncrement: skip $02
        ; Echo volume right panning Increment.

    ; $68[0x01] - (Echo, Timer)
    .EchoPanTimer: skip $01
        ; The echo pan timer.

    ; $69[0x01] - (Echo)
    .EchoPanLeftTarget: skip $01
        ; The echo pan target Left.

    ; $6A[0x01] - (Echo)
    .EchoPanRightTarget: skip $01
        ; The echo pan target Right.

    ; $6B[0x05] - (Free)
    .Free_6B: skip $05
        ; Free RAM.


    ; $70[0x01] - (Channel, Timer)
    .Chan0_Timer: skip $01
        ; The countdown for next note or how long the current note has been
        ; playing on channel 0.

    ; $71[0x01] - (Channel, Timer)
    .Chan0_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 0.

    ; $72[0x01] - (Channel, Timer)
    .Chan1_Timer: skip $01
        ; The countdown for next note or how long the current note has been
        ; playing on channel 1.

    ; $73[0x01] - (Channel, Timer)
    .Chan1_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 1.

    ; $74[0x01] - (Channel, Timer)
    .Chan2_Timer: skip $01
        ; The countdown for next note or how long the current note has been
        ; playing on channel 2.

    ; $75[0x01] - (Channel, Timer)
    .Chan2_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 2.

    ; $76[0x01] - (Channel, Timer)
    .Chan3_Timer: skip $01
        ;; The countdown for next note or how long the current note has been
        ; playing on channel 3.

    ; $77[0x01] - (Channel, Timer)
    .Chan3_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 3.

    ; $78[0x01] - (Channel, Timer)
    .Chan4_Timer: skip $01
        ;; The countdown for next note or how long the current note has been
        ; playing on channel 4.

    ; $79[0x01] - (Channel, Timer)
    .Chan4_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 4.

    ; $7A[0x01] - (Channel, Timer)
    .Chan5_Timer: skip $01
        ;; The countdown for next note or how long the current note has been
        ; playing on channel 5.

    ; $7B[0x01] - (Channel, Timer)
    .Chan5_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 5.

    ; $7C[0x01] - (Channel, Timer)
    .Chan6_Timer: skip $01
        ;; The countdown for next note or how long the current note has been
        ; playing on channel 6.

    ; $7D[0x01] - (Channel, Timer)
    .Chan6_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 6.

    ; $7E[0x01] - (Channel, Timer)
    .Chan7_Timer: skip $01
        ;; The countdown for next note or how long the current note has been
        ; playing on channel 7.

    ; $7F[0x01] - (Channel, Timer)
    .Chan7_ReleaseTimer: skip $01
        ; The countdown for release/staccato timing on channel 7.


    ; $80[0x02] - (Channel, Part)
    .Chan0_PartCounter: skip $02
        ; The channel 0 part loop counters. The high byte is unused.

    ; $82[0x02] - (Channel, Part)
    .Chan1_PartCounter: skip $02
        ; The channel 1 part loop counters. The high byte is unused.

    ; $84[0x02] - (Channel, Part)
    .Chan2_PartCounter: skip $02
        ; The channel 2 part loop counters. The high byte is unused.

    ; $86[0x02] - (Channel, Part)
    .Chan3_PartCounter: skip $02
        ; The channel 3 part loop counters. The high byte is unused.

    ; $88[0x02] - (Channel, Part)
    .Chan4_PartCounter: skip $02
        ; The channel 4 part loop counters. The high byte is unused.

    ; $8A[0x02] - (Channel, Part)
    .Chan5_PartCounter: skip $02
        ; The channel 5 part loop counters. The high byte is unused.

    ; $8C[0x02] - (Channel, Part)
    .Chan6_PartCounter: skip $02
        ; The channel 6 part loop counters. The high byte is unused.

    ; $8E[0x02] - (Channel, Part)
    .Chan7_PartCounter: skip $02
        ; The channel 7 part loop counters. The high byte is unused.


    ; $90[0x01] - (Channel, Volume, Timer)
    .Chan0_VolTimer: skip $01
        ; The channel 0 volume slide timer.

    ; $91[0x01] - (Channel, Pan, Timer)
    .Chan0_PanTimer: skip $01
        ; The channel 0 pan slide timer.

    ; $92[0x01] - (Channel, Volume, Timer)
    .Chan1_VolTimer: skip $01
        ; The channel 1 volume slide timer.

    ; $93[0x01] - (Channel, Pan, Timer)
    .Chan1_PanTimer: skip $01
        ; The channel 1 pan slide timer.

    ; $94[0x01] - (Channel, Volume, Timer)
    .Chan2_VolTimer: skip $01
        ; The channel 2 volume slide timer.

    ; $95[0x01] - (Channel, Pan, Timer)
    .Chan2_PanTimer: skip $01
        ; The channel 2 pan slide timer.

    ; $96[0x01] - (Channel, Volume, Timer)
    .Chan3_VolTimer: skip $01
        ; The channel 3 volume slide timer.

    ; $97[0x01] - (Channel, Pan, Timer)
    .Chan3_PanTimer: skip $01
        ; The channel 3 pan slide timer.

    ; $98[0x01] - (Channel, Volume, Timer)
    .Chan4_VolTimer: skip $01
        ; The channel 4 volume slide timer.

    ; $99[0x01] - (Channel, Pan, Timer)
    .Chan4_PanTimer: skip $01
        ; The channel 4 pan slide timer.

    ; $9A[0x01] - (Channel, Volume, Timer)
    .Chan5_VolTimer: skip $01
        ; The channel 5 volume slide timer.

    ; $9B[0x01] - (Channel, Pan, Timer)
    .Chan5_PanTimer: skip $01
        ; The channel 5 pan slide timer.

    ; $9C[0x01] - (Channel, Volume, Timer)
    .Chan6_VolTimer: skip $01
        ; The channel 6 volume slide timer.

    ; $9D[0x01] - (Channel, Pan, Timer)
    .Chan6_PanTimer: skip $01
        ; The channel 6 pan slide timer.

    ; $9E[0x01] - (Channel, Volume, Timer)
    .Chan7_VolTimer: skip $01
        ; The channel 7 volume slide timer.

    ; $9F[0x01] - (Channel, Pan, Timer)
    .Chan7_PanTimer: skip $01
        ; The channel 7 pan slide timer.


    ; $A0[0x01] - (Channel, Pitch, Timer)
    .Chan0_PitchSlideTimer: skip $01
        ; The channel 0 pitch slide timer.

    ; $A1[0x01] - (Channel, Pitch, Timer)
    .Chan0_PitchDelay: skip $01
        ; The channel 0 pitch slide delay for operation.

    ; $A2[0x01] - (Channel, Pitch, Timer)
    .Chan1_PitchSlideTimer: skip $01
        ; The channel 1 pitch slide timer.

    ; $A3[0x01] - (Channel, Pitch, Timer)
    .Chan1_PitchDelay: skip $01
        ; The channel 1 pitch slide delay for operation.

    ; $A4[0x01] - (Channel, Pitch, Timer)
    .Chan2_PitchSlideTimer: skip $01
        ; The channel 2 pitch slide timer.

    ; $A5[0x01] - (Channel, Pitch, Timer)
    .Chan2_PitchDelay: skip $01
        ; The channel 2 pitch slide delay for operation.

    ; $A6[0x01] - (Channel, Pitch, Timer)
    .Chan3_PitchSlideTimer: skip $01
        ; The channel 3 pitch slide timer.

    ; $A7[0x01] - (Channel, Pitch, Timer)
    .Chan3_PitchDelay: skip $01
        ; The channel 3 pitch slide delay for operation.

    ; $A8[0x01] - (Channel, Pitch, Timer)
    .Chan4_PitchSlideTimer: skip $01
        ; The channel 4 pitch slide timer.

    ; $A9[0x01] - (Channel, Pitch, Timer)
    .Chan4_PitchDelay: skip $01
        ; The channel 4 pitch slide delay for operation.

    ; $AA[0x01] - (Channel, Pitch, Timer)
    .Chan5_PitchSlideTimer: skip $01
        ; The channel 5 pitch slide timer.

    ; $AB[0x01] - (Channel, Pitch, Timer)
    .Chan5_PitchDelay: skip $01
        ; The channel 5 pitch slide delay for operation.

    ; $AC[0x01] - (Channel, Pitch, Timer)
    .Chan6_PitchSlideTimer: skip $01
        ; The channel 6 pitch slide timer.

    ; $AD[0x01] - (Channel, Pitch, Timer)
    .Chan6_PitchDelay: skip $01
        ; The channel 6 pitch slide delay for operation.

    ; $AE[0x01] - (Channel, Pitch, Timer)
    .Chan7_PitchSlideTimer: skip $01
        ; The channel 7 pitch slide timer.

    ; $AF[0x01] - (Channel, Pitch, Timer)
    .Chan7_PitchDelay: skip $01
        ; The channel 7 pitch slide delay for operation.


    ; $B0[0x01] - (Channel, Vibrato)
    .Chan0_VbrStrength: skip $01
        ; The channel 0 vibrato strength.

    ; $B1[0x01] - (Channel, Vibrato)
    .Chan0_VbrIntensity: skip $01
        ; The channel 0 vibrato intensity.

    ; $B2[0x01] - (Channel, Vibrato)
    .Chan1_VbrStrength: skip $01
        ; The channel 1 vibrato strength.

    ; $B3[0x01] - (Channel, Vibrato)
    .Chan1_VbrIntensity: skip $01
        ; The channel 1 vibrato intensity.

    ; $B4[0x01] - (Channel, Vibrato)
    .Chan2_VbrStrength: skip $01
        ; The channel 2 vibrato strength.

    ; $B5[0x01] - (Channel, Vibrato)
    .Chan2_VbrIntensity: skip $01
        ; The channel 2 vibrato intensity.

    ; $B6[0x01] - (Channel, Vibrato)
    .Chan3_VbrStrength: skip $01
        ; The channel 3 vibrato strength.

    ; $B7[0x01] - (Channel, Vibrato)
    .Chan3_VbrIntensity: skip $01
        ; The channel 3 vibrato intensity.

    ; $B8[0x01] - (Channel, Vibrato)
    .Chan4_VbrStrength: skip $01
        ; The channel 4 vibrato strength.

    ; $B9[0x01] - (Channel, Vibrato)
    .Chan4_VbrIntensity: skip $01
        ; The channel 4 vibrato intensity.

    ; $BA[0x01] - (Channel, Vibrato)
    .Chan5_VbrStrength: skip $01
        ; The channel 5 vibrato strength.

    ; $BB[0x01] - (Channel, Vibrato)
    .Chan5_VbrIntensity: skip $01
        ; The channel 5 vibrato intensity.

    ; $BC[0x01] - (Channel, Vibrato)
    .Chan6_VbrStrength: skip $01
        ; The channel 6 vibrato strength.

    ; $BD[0x01] - (Channel, Vibrato)
    .Chan6_VbrIntensity: skip $01
        ; The channel 6 vibrato intensity.

    ; $BE[0x01] - (Channel, Vibrato)
    .Chan7_VbrStrength: skip $01
        ; The channel 7 vibrato strength.

    ; $BF[0x01] - (Channel, Vibrato)
    .Chan7_VbrIntensity: skip $01
        ; The channel 7 vibrato intensity.


    ; $C0[0x01] - (Channel, Tremolo, Timer)
    .Chan0_TremTimer: skip $01
        ; The channel 0 tremolo timer.

    ; $C1[0x01] - (Channel, Tremolo)
    .Chan0_TremIntensity: skip $01
        ; The channel 0 tremolo intensity.

    ; $C2[0x01] - (Channel, Tremolo, Timer)
    .Chan1_TremTimer: skip $01
        ; The channel 1 tremolo timer.

    ; $C3[0x01] - (Channel, Tremolo)
    .Chan1_TremIntensity: skip $01
        ; The channel 1 tremolo intensity.

    ; $C4[0x01] - (Channel, Tremolo, Timer)
    .Chan2_TremTimer: skip $01
        ; The channel 2 tremolo timer.

    ; $C5[0x01] - (Channel, Tremolo)
    .Chan2_TremIntensity: skip $01
        ; The channel 2 tremolo intensity.

    ; $C6[0x01] - (Channel, Tremolo, Timer)
    .Chan3_TremTimer: skip $01
        ; The channel 3 tremolo timer.

    ; $C7[0x01] - (Channel, Tremolo)
    .Chan3_TremIntensity: skip $01
        ; The channel 3 tremolo intensity.

    ; $C8[0x01] - (Channel, Tremolo, Timer)
    .Chan4_TremTimer: skip $01
        ; The channel 4 tremolo timer.

    ; $C9[0x01] - (Channel, Tremolo)
    .Chan4_TremIntensity: skip $01
        ; The channel 4 tremolo intensity.

    ; $CA[0x01] - (Channel, Tremolo, Timer)
    .Chan5_TremTimer: skip $01
        ; The channel 5 tremolo timer.

    ; $CB[0x01] - (Channel, Tremolo)
    .Chan5_TremIntensity: skip $01
        ; The channel 5 tremolo intensity.

    ; $CC[0x01] - (Channel, Tremolo, Timer)
    .Chan6_TremTimer: skip $01
        ; The channel 6 tremolo timer.

    ; $CD[0x01] - (Channel, Tremolo)
    .Chan6_TremIntensity: skip $01
        ; The channel 6 tremolo intensity.

    ; $CE[0x01] - (Channel, Tremolo, Timer)
    .Chan7_TremTimer: skip $01
        ; The channel 7 tremolo timer.

    ; $CF[0x01] - (Channel, Tremolo)
    .Chan7_TremIntensity: skip $01
        ; The channel 7 tremolo intensity.


    ; $D0[0x20] - (Free)
    .Free_D0: skip $20
        ; Free RAM.

    ; ==========================================================================
    ; SPC hardware registers at $F0-$FF
    ; See HardwareRegisters.asm
    skip $10
    ; ==========================================================================

    ; ===========================================================================
    ; End of Direct Page 0x00
    ; ===========================================================================

    ; ===========================================================================
    ; Direct Page 0x01
    ; ===========================================================================
    ; The direct page 0x01 is only used in one place in the SPC engine and only
    ; very briefly. Most references to this section of RAM are absolute calls.

    ; $0100[0x01] - (Channel, Vibrato, Timer)
    .Chan0_VbrSlideTimer: skip $01
        ; The channel 0 vibrato intensity slide timer.

    ; $0101[0x01] - (Free)
    .Free_0101: skip $01
        ; Free RAM.

    ; $0102[0x01] - (Channel, Vibrato, Timer)
    .Chan1_VbrSlideTimer: skip $01
        ; The channel 1 vibrato counter.

    ; $0103[0x01] - (Free)
    .Free_0103: skip $01
        ; Free RAM.

    ; $0104[0x01] - (Channel, Vibrato, Timer)
    .Chan2_VbrSlideTimer: skip $01
        ; The channel 2 vibrato counter.

    ; $0105[0x01] - (Free)
    .Free_0105: skip $01
        ; Free RAM.

    ; $0106[0x01] - (Channel, Vibrato, Timer)
    .Chan3_VbrSlideTimer: skip $01
        ; The channel 3 vibrato counter.

    ; $0107[0x01] - (Free)
    .Free_0107: skip $01
        ; Free RAM.

    ; $0108[0x01] - (Channel, Vibrato, Timer)
    .Chan4_VbrSlideTimer: skip $01
        ; The channel 4 vibrato counter.

    ; $0109[0x01] - (Free)
    .Free_0109: skip $01
        ; Free RAM.

    ; $010A[0x01] - (Channel, Vibrato, Timer)
    .Chan5_VbrSlideTimer: skip $01
        ; The channel 5 vibrato counter.

    ; $010B[0x01] - (Free)
    .Free_010B: skip $01
        ; Free RAM.

    ; $010C[0x01] - (Channel, Vibrato, Timer)
    .Chan6_VbrSlideTimer: skip $01
        ; The channel 6 vibrato counter.

    ; $010D[0x01] - (Free)
    .Free_010D: skip $01
        ; Free RAM.

    ; $010E[0x01] - (Channel, Vibrato, Timer)
    .Chan7_VbrSlideTimer: skip $01
        ; The channel 7 vibrato counter.

    ; $010F[0xC0] - (Free)
    .Free_010F: skip $C0
        ; Free RAM.

    ; ==========================================================================
    ; SPC700 stack
    ; Starts here, for whatever reason
    ; ==========================================================================

    ; $01CF[0x30] - (Main)
    .APUStack: skip $30
        ; The initial stack location.

    ; $01FF[0x01] - (Main)
    .IPLStack: skip $01
        ; The initial stack location for the IPL boot ROM.

    ; ===========================================================================
    ; End of Direct Page 0x01
    ; ===========================================================================

    ; ===========================================================================
    ; Absolute RAM
    ; ===========================================================================

    ; $0200[0x01] - (Channel, Note)
    .Chan0_Duration: skip $01
        ; The channel 0 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0201[0x01] - (Channel, Note)
    .Chan0_Staccato: skip $01
        ; Note release duration.

    ; $0202[0x01] - (Channel, Note)
    .Chan1_Duration: skip $01
        ; The channel 1 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0203[0x01] - (Channel, Note)
    .Chan1_Staccato: skip $01
        ; Note release duration.

    ; $0204[0x01] - (Channel, Note)
    .Chan2_Duration: skip $01
        ; The channel 2 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0205[0x01] - (Channel, Note)
    .Chan2_Staccato: skip $01
        ; Note release duration.

    ; $0206[0x01] - (Channel, Note)
    .Chan3_Duration: skip $01
        ; The channel 3 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0207[0x01] - (Channel, Note)
    .Chan3_Staccato: skip $01
        ; Note release duration.

    ; $0208[0x01] - (Channel, Note)
    .Chan4_Duration: skip $01
        ; The channel 4 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0209[0x01] - (Channel, Note)
    .Chan4_Staccato: skip $01
        ; Note release duration.

    ; $020A[0x01] - (Channel, Note)
    .Chan5_Duration: skip $01
        ; The channel 5 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020B[0x01] - (Channel, Note)
    .Chan5_Staccato: skip $01
        ; Note release duration.

    ; $020C[0x01] - (Channel, Note)
    .Chan6_Duration: skip $01
        ; The channel 6 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020D[0x01] - (Channel, Note)
    .Chan6_Staccato: skip $01
        ; Note release duration.

    ; $020E[0x01] - (Channel, Note)
    .Chan7_Duration: skip $01
        ; The channel 7 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020F[0x01] - (Channel, Note)
    .Chan7_Staccato: skip $01
        ; Note release duration.


    ; $0210[0x01] - (Channel, Note)
    .Chan0_Attack: skip $01
        ; The channel 0 note attack.

    ; $0211[0x01] - (Channel, Instrument)
    .Chan0_Instrument: skip $01
        ; The channel 0 instrument ID.

    ; $0212[0x01] - (Channel, Note)
    .Chan1_Attack: skip $01
        ; The channel 1 note attack.

    ; $0213[0x01] - (Channel, Instrument)
    .Chan1_Instrument: skip $01
        ; The channel 1 instrument ID.

    ; $0214[0x01] - (Channel, Note)
    .Chan2_Attack: skip $01
        ; The channel 2 note attack.

    ; $0215[0x01] - (Channel, Instrument)
    .Chan2_Instrument: skip $01
        ; The channel 2 instrument ID.

    ; $0216[0x01] - (Channel, Note)
    .Chan3_Attack: skip $01
        ; The channel 3 note attack.

    ; $0217[0x01] - (Channel, Instrument)
    .Chan3_Instrument: skip $01
        ; The channel 3 instrument ID.

    ; $0218[0x01] - (Channel, Note)
    .Chan4_Attack: skip $01
        ; The channel 4 note attack.

    ; $0219[0x01] - (Channel, Instrument)
    .Chan4_Instrument: skip $01
        ; The channel 4 instrument ID.

    ; $021A[0x01] - (Channel, Note)
    .Chan5_Attack: skip $01
        ; The channel 5 note attack.

    ; $021B[0x01] - (Channel, Instrument)
    .Chan5_Instrument: skip $01
        ; The channel 5 instrument ID.

    ; $021C[0x01] - (Channel, Note)
    .Chan6_Attack: skip $01
        ; The channel 6 note attack.

    ; $021D[0x01] - (Channel, Instrument)
    .Chan6_Instrument: skip $01
        ; The channel 6 instrument ID.

    ; $021E[0x01] - (Channel, Note)
    .Chan7_Attack: skip $01
        ; The channel 7 note attack.

    ; $021F[0x01] - (Channel, Instrument)
    .Chan7_Instrument: skip $01
        ; The channel 7 instrument ID.


    ; $0220[0x02] - (Channel, Tune)
    .Chan0_TuneMult: skip $02
        ; The channel 0 instrument high-level tuning multiplier.

    ; $0222[0x02] - (Channel, Tune)
    .Chan1_TuneMult: skip $02
        ; The channel 1 instrument high-level tuning multiplier.

    ; $0224[0x02] - (Channel, Tune)
    .Chan2_TuneMult: skip $02
        ; The channel 2 instrument high-level tuning multiplier.

    ; $0226[0x02] - (Channel, Tune)
    .Chan3_TuneMult: skip $02
        ; The channel 3 instrument high-level tuning multiplier.

    ; $0228[0x02] - (Channel, Tune)
    .Chan4_TuneMult: skip $02
        ; The channel 4 instrument high-level tuning multiplier.

    ; $022A[0x02] - (Channel, Tune)
    .Chan5_TuneMult: skip $02
        ; The channel 5 instrument high-level tuning multiplier.

    ; $022C[0x02] - (Channel, Tune)
    .Chan6_TuneMult: skip $02
        ; The channel 6 instrument high-level tuning multiplier.

    ; $022E[0x02] - (Channel, Tune)
    .Chan7_TuneMult: skip $02
        ; The channel 7 instrument high-level tuning multiplier.


    ; $0230[0x02] - (Channel, Part)
    .Chan0_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 0.

    ; $0232[0x02] - (Channel, Part)
    .Chan1_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 1.

    ; $0234[0x02] - (Channel, Part)
    .Chan2_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 2.

    ; $0236[0x02] - (Channel, Part)
    .Chan3_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 3.

    ; $0238[0x02] - (Channel, Part)
    .Chan4_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 4.

    ; $023A[0x02] - (Channel, Part)
    .Chan5_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 5.

    ; $023C[0x02] - (Channel, Part)
    .Chan6_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 6.

    ; $023E[0x02] - (Channel, Part)
    .Chan7_PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 7.


    ; $0240[0x02] - (Channel, Part)
    .Chan0_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 0.

    ; $0242[0x02] - (Channel, Part)
    .Chan1_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 1.

    ; $0244[0x02] - (Channel, Part)
    .Chan2_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 2.

    ; $0246[0x02] - (Channel, Part)
    .Chan3_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 3.

    ; $0248[0x02] - (Channel, Part)
    .Chan4_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 4.

    ; $024A[0x02] - (Channel, Part)
    .Chan5_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 5.

    ; $024C[0x02] - (Channel, Part)
    .Chan6_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 6.

    ; $024E[0x02] - (Channel, Part)
    .Chan7_PartAddr: skip $02
        ; The Subroutine address for part calls for channel 7.

    ; $0250[0x30] - (Free)
    .Free_0250: skip $30
        ; Free RAM.

    ; ==========================================================================

    ; $0280[0x01] - (Channel, Pitch, Timer)
    .Chan0_PitchSlideTimerQ: skip $01
        ; The channel 0 pitch slide timer queue.

    ; $0281[0x01] - (Channel, Pitch, Timer)
    .Chan0_PitchSlideDelayQ: skip $01
        ; The channel 0 pitch slide delay queue.

    ; $0282[0x01] - (Channel, Pitch, Timer)
    .Chan1_PitchSlideTimerQ: skip $01
        ; The channel 1 pitch slide timer queue.

    ; $0283[0x01] - (Channel, Pitch, Timer)
    .Chan1_PitchSlideDelayQ: skip $01
        ; The channel 1 pitch slide delay queue.

    ; $0284[0x01] - (Channel, Pitch, Timer)
    .Chan2_PitchSlideTimerQ: skip $01
        ; The channel 2 pitch slide timer queue.

    ; $0285[0x01] - (Channel, Pitch, Timer)
    .Chan2_PitchSlideDelayQ: skip $01
        ; The channel 2 pitch slide delay queue.

    ; $0286[0x01] - (Channel, Pitch, Timer)
    .Chan3_PitchSlideTimerQ: skip $01
        ; The channel 3 pitch slide timer queue.

    ; $0287[0x01] - (Channel, Pitch, Timer)
    .Chan3_PitchSlideDelayQ: skip $01
        ; The channel 3 pitch slide delay queue.

    ; $0288[0x01] - (Channel, Pitch, Timer)
    .Chan4_PitchSlideTimerQ: skip $01
        ; The channel 4 pitch slide timer queue.

    ; $0289[0x01] - (Channel, Pitch, Timer)
    .Chan4_PitchSlideDelayQ: skip $01
        ; The channel 4 pitch slide delay queue.

    ; $028A[0x01] - (Channel, Pitch, Timer)
    .Chan5_PitchSlideTimerQ: skip $01
        ; The channel 5 pitch slide timer queue.

    ; $028B[0x01] - (Channel, Pitch, Timer)
    .Chan5_PitchSlideDelayQ: skip $01
        ; The channel 5 pitch slide delay queue.

    ; $028C[0x01] - (Channel, Pitch, Timer)
    .Chan6_PitchSlideTimerQ: skip $01
        ; The channel 6 pitch slide timer queue.

    ; $028D[0x01] - (Channel, Pitch, Timer)
    .Chan6_PitchSlideDelayQ: skip $01
        ; The channel 6 pitch slide delay queue.

    ; $028E[0x01] - (Channel, Pitch, Timer)
    .Chan7_PitchSlideTimerQ: skip $01
        ; The channel 7 pitch slide timer queue.

    ; $028F[0x01] - (Channel, Pitch, Timer)
    .Chan7_PitchSlideDelayQ: skip $01
        ; The channel 7 pitch slide delay queue.


    ; $0290[0x01] - (Channel, Pitch)
    .Chan0_PitchSlideType: skip $01
        ; The channel 0 pitch slide type (0: from | 1: to).

    ; $0291[0x01] - (Channel, Pitch)
    .Chan0_PitchSlideTarget: skip $01
        ; The channel 0 pitch slide target.

    ; $0292[0x01] - (Channel, Pitch)
    .Chan1_PitchSlideType: skip $01
        ; The channel 1 pitch slide type (0: from | 1: to).

    ; $0293[0x01] - (Channel, Pitch)
    .Chan1_PitchSlideTarget: skip $01
        ; The channel 1 pitch slide target.

    ; $0294[0x01] - (Channel, Pitch)
    .Chan2_PitchSlideType: skip $01
        ; The channel 2 pitch slide type (0: from | 1: to).

    ; $0295[0x01] - (Channel, Pitch)
    .Chan2_PitchSlideTarget: skip $01
        ; The channel 2 pitch slide target.

    ; $0296[0x01] - (Channel, Pitch)
    .Chan3_PitchSlideType: skip $01
        ; The channel 3 pitch slide type (0: from | 1: to).

    ; $0297[0x01] - (Channel, Pitch)
    .Chan3_PitchSlideTarget: skip $01
        ; The channel 3 pitch slide target.

    ; $0298[0x01] - (Channel, Pitch)
    .Chan4_PitchSlideType: skip $01
        ; The channel 4 pitch slide type (0: from | 1: to).

    ; $0299[0x01] - (Channel, Pitch)
    .Chan4_PitchSlideTarget: skip $01
        ; The channel 4 pitch slide target.

    ; $029A[0x01] - (Channel, Pitch)
    .Chan5_PitchSlideType: skip $01
        ; The channel 5 pitch slide type (0: from | 1: to).

    ; $029B[0x01] - (Channel, Pitch)
    .Chan5_PitchSlideTarget: skip $01
        ; The channel 5 pitch slide target.

    ; $029C[0x01] - (Channel, Pitch)
    .Chan6_PitchSlideType: skip $01
        ; The channel 6 pitch slide type (0: from | 1: to).

    ; $029D[0x01] - (Channel, Pitch)
    .Chan6_PitchSlideTarget: skip $01
        ; The channel 6 pitch slide target.

    ; $029E[0x01] - (Channel, Pitch)
    .Chan7_PitchSlideType: skip $01
        ; The channel 7 pitch slide type (0: from | 1: to).

    ; $029F[0x01] - (Channel, Pitch)
    .Chan7_PitchSlideTarget: skip $01
        ; The channel 7 pitch slide target.


    ; $02A0[0x01] - (Channel, Vibrato)
    .Chan0_VbrAcc: skip $01
        ; The channel 0 vibrato accumulator.

    ; $02A1[0x01] - (Channel, Vibrato)
    .Chan0_VbrIncrement: skip $01
        ; The channel 0 vibrato increment.

    ; $02A2[0x01] - (Channel, Vibrato)
    .Chan1_VbrAcc: skip $01
        ; The channel 1 vibrato accumulator.

    ; $02A3[0x01] - (Channel, Vibrato)
    .Chan1_VbrIncrement: skip $01
        ; The channel 1 vibrato increment.

    ; $02A4[0x01] - (Channel, Vibrato)
    .Chan2_VbrAcc: skip $01
        ; The channel 2 vibrato accumulator.

    ; $02A5[0x01] - (Channel, Vibrato)
    .Chan2_VbrIncrement: skip $01
        ; The channel 2 vibrato increment.

    ; $02A6[0x01] - (Channel, Vibrato)
    .Chan3_VbrAcc: skip $01
        ; The channel 3 vibrato accumulator.

    ; $02A7[0x01] - (Channel, Vibrato)
    .Chan3_VbrIncrement: skip $01
        ; The channel 3 vibrato increment.

    ; $02A8[0x01] - (Channel, Vibrato)
    .Chan4_VbrAcc: skip $01
        ; The channel 4 vibrato accumulator.

    ; $02A9[0x01] - (Channel, Vibrato)
    .Chan4_VbrIncrement: skip $01
        ; The channel 4 vibrato increment.

    ; $02AA[0x01] - (Channel, Vibrato)
    .Chan5_VbrAcc: skip $01
        ; The channel 5 vibrato accumulator.

    ; $02AB[0x01] - (Channel, Vibrato)
    .Chan5_VbrIncrement: skip $01
        ; The channel 5 vibrato increment.

    ; $02AC[0x01] - (Channel, Vibrato)
    .Chan6_VbrAcc: skip $01
        ; The channel 6 vibrato accumulator.

    ; $02AD[0x01] - (Channel, Vibrato)
    .Chan6_VbrIncrement: skip $01
        ; The channel 6 vibrato increment.

    ; $02AE[0x01] - (Channel, Vibrato)
    .Chan7_VbrAcc: skip $01
        ; The channel 7 vibrato accumulator.

    ; $02AF[0x01] - (Channel, Vibrato)
    .Chan7_VbrIncrement: skip $01
        ; The channel 7 vibrato increment.


    ; $02B0[0x01] - (Channel, Vibrato, Timer)
    .Chan0_VbrDelay: skip $01
        ; The channel 0 vibrato delay.

    ; $02B1[0x01] - (Channel, Vibrato, Timer)
    .Chan0_VbrSlideWait: skip $01
        ; This is the value the channel 0 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02B2[0x01] - (Channel, Vibrato, Timer)
    .Chan1_VbrDelay: skip $01
        ; The channel 1 vibrato delay.

    ; $02B3[0x01] - (Channel, Vibrato, Timer)
    .Chan1_VbrSlideWait: skip $01
        ; This is the value the channel 1 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02B4[0x01] - (Channel, Vibrato, Timer)
    .Chan2_VbrDelay: skip $01
        ; The channel 2 vibrato delay.

    ; $02B5[0x01] - (Channel, Vibrato, Timer)
    .Chan2_VbrSlideWait: skip $01
        ; This is the value the channel 2 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02B6[0x01] - (Channel, Vibrato, Timer)
    .Chan3_VbrDelay: skip $01
        ; The channel 3 vibrato delay.

    ; $02B7[0x01] - (Channel, Vibrato, Timer)
    .Chan3_VbrSlideWait: skip $01
        ; This is the value the channel 3 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02B8[0x01] - (Channel, Vibrato, Timer)
    .Chan4_VbrDelay: skip $01
        ; The channel 4 vibrato delay.

    ; $02B9[0x01] - (Channel, Vibrato, Timer)
    .Chan4_VbrSlideWait: skip $01
        ; This is the value the channel 4 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02BA[0x01] - (Channel, Vibrato, Timer)
    .Chan5_VbrDelay: skip $01
        ; The channel 5 vibrato delay.

    ; $02BB[0x01] - (Channel, Vibrato, Timer)
    .Chan5_VbrSlideWait: skip $01
        ; This is the value the channel 5 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02BC[0x01] - (Channel, Vibrato, Timer)
    .Chan6_VbrDelay: skip $01
        ; The channel 6 vibrato delay.

    ; $02BD[0x01] - (Channel, Vibrato, Timer)
    .Chan6_VbrSlideWait: skip $01
        ; This is the value the channel 6 vibrato intensity slide timer needs to
        ; reach to be complete.

    ; $02BE[0x01] - (Channel, Vibrato, Timer)
    .Chan7_VbrDelay: skip $01
        ; The channel 7 vibrato delay.

    ; $02BF[0x01] - (Channel, Vibrato, Timer)
    .Chan7_VbrSlideWait: skip $01
        ; This is the value the channel 7 vibrato intensity slide timer needs to
        ; reach to be complete.


    ; $02C0[0x01] - (Channel, Vibrato)
    .Chan0_VbrSlideIncrement: skip $01
        ; The channel 0 vibrato intensity slide increment.

    ; $02C1[0x01] - (Channel, Vibrato)
    .Chan0_VbrMaxIntensity: skip $01
        ; The channel 0 max vibrato intensity.

    ; $02C2[0x01] - (Channel, Vibrato)
    .Chan1_VbrSlideIncrement: skip $01
        ; The channel 1 vibrato intensity slide increment.

    ; $02C3[0x01] - (Channel, Vibrato)
    .Chan1_VbrMaxIntensity: skip $01
        ; The channel 1 max vibrato intensity.

    ; $02C4[0x01] - (Channel, Vibrato)
    .Chan2_VbrSlideIncrement: skip $01
        ; The channel 2 vibrato intensity slide increment.

    ; $02C5[0x01] - (Channel, Vibrato)
    .Chan2_VbrMaxIntensity: skip $01
        ; The channel 2 max vibrato intensity.

    ; $02C6[0x01] - (Channel, Vibrato)
    .Chan3_VbrSlideIncrement: skip $01
        ; The channel 3 vibrato intensity slide increment.

    ; $02C7[0x01] - (Channel, Vibrato)
    .Chan3_VbrMaxIntensity: skip $01
        ; The channel 3 max vibrato intensity.

    ; $02C8[0x01] - (Channel, Vibrato)
    .Chan4_VbrSlideIncrement: skip $01
        ; The channel 4 vibrato intensity slide increment.

    ; $02C9[0x01] - (Channel, Vibrato)
    .Chan4_VbrMaxIntensity: skip $01
        ; The channel 4 max vibrato intensity.

    ; $02CA[0x01] - (Channel, Vibrato)
    .Chan5_VbrSlideIncrement: skip $01
        ; The channel 5 vibrato intensity slide increment.

    ; $02CB[0x01] - (Channel, Vibrato)
    .Chan5_VbrMaxIntensity: skip $01
        ; The channel 5 max vibrato intensity.

    ; $02CC[0x01] - (Channel, Vibrato)
    .Chan6_VbrSlideIncrement: skip $01
        ; The channel 6 vibrato intensity slide increment.

    ; $02CD[0x01] - (Channel, Vibrato)
    .Chan6_VbrMaxIntensity: skip $01
        ; The channel 6 max vibrato intensity.

    ; $02CE[0x01] - (Channel, Vibrato)
    .Chan7_VbrSlideIncrement: skip $01
        ; The channel 7 vibrato intensity slide increment.

    ; $02CF[0x01] - (Channel, Vibrato)
    .Chan7_VbrMaxIntensity: skip $01
        ; The channel 7 max vibrato intensity.


    ; $02D0[0x01] - (Channel, Tremolo)
    .Chan0_TremAcc: skip $01
        ; The channel 0 tremolo accumulator.

    ; $02D1[0x01] - (Channel, Tremolo)
    .Chan0_TremIncrement: skip $01
        ; The channel 0 tremolo increment.

    ; $02D2[0x01] - (Channel, Tremolo)
    .Chan1_TremAcc: skip $01
        ; The channel 1 tremolo accumulator.

    ; $02D3[0x01] - (Channel, Tremolo)
    .Chan1_TremIncrement: skip $01
        ; The channel 1 tremolo increment.

    ; $02D4[0x01] - (Channel, Tremolo)
    .Chan2_TremAcc: skip $01
        ; The channel 2 tremolo accumulator.

    ; $02D5[0x01] - (Channel, Tremolo)
    .Chan2_TremIncrement: skip $01
        ; The channel 2 tremolo increment.

    ; $02D6[0x01] - (Channel, Tremolo)
    .Chan3_TremAcc: skip $01
        ; The channel 3 tremolo accumulator.

    ; $02D7[0x01] - (Channel, Tremolo)
    .Chan3_TremIncrement: skip $01
        ; The channel 3 tremolo increment.

    ; $02D8[0x01] - (Channel, Tremolo)
    .Chan4_TremAcc: skip $01
        ; The channel 4 tremolo accumulator.

    ; $02D9[0x01] - (Channel, Tremolo)
    .Chan4_TremIncrement: skip $01
        ; The channel 4 tremolo increment.

    ; $02DA[0x01] - (Channel, Tremolo)
    .Chan5_TremAcc: skip $01
        ; The channel 5 tremolo accumulator.

    ; $02DB[0x01] - (Channel, Tremolo)
    .Chan5_TremIncrement: skip $01
        ; The channel 5 tremolo increment.

    ; $02DC[0x01] - (Channel, Tremolo)
    .Chan6_TremAcc: skip $01
        ; The channel 6 tremolo accumulator.

    ; $02DD[0x01] - (Channel, Tremolo)
    .Chan6_TremIncrement: skip $01
        ; The channel 6 tremolo increment.

    ; $02DE[0x01] - (Channel, Tremolo)
    .Chan7_TremAcc: skip $01
        ; The channel 7 tremolo accumulator.

    ; $02DF[0x01] - (Channel, Tremolo)
    .Chan7_TremIncrement: skip $01
        ; The channel 7 tremolo increment.


    ; $02E0[0x01] - (Channel, Tremolo, Timer)
    .Chan0_TremDelay: skip $01
        ; The channel 0 tremolo delay.

    ; $02E1[0x01] - (Free)
    .Free_02E1: skip $01
        ; Free RAM.

    ; $02E2[0x01] - (Channel, Tremolo, Timer)
    .Chan1_TremDelay: skip $01
        ; The channel 1 tremolo delay.

    ; $02E3[0x01] - (Free)
    .Free_02E3: skip $01
        ; Free RAM.

    ; $02E4[0x01] - (Channel, Tremolo, Timer)
    .Chan2_TremDelay: skip $01
        ; The channel 2 tremolo delay.

    ; $02E5[0x01] - (Free)
    .Free_02E5: skip $01
        ; Free RAM.

    ; $02E6[0x01] - (Channel, Tremolo, Timer)
    .Chan3_TremDelay: skip $01
        ; The channel 3 tremolo delay.

    ; $02E7[0x01] - (Free)
    .Free_02E7: skip $01
        ; Free RAM.

    ; $02E8[0x01] - (Channel, Tremolo, Timer)
    .Chan4_TremDelay: skip $01
        ; The channel 4 tremolo delay.

    ; $02E9[0x01] - (Free)
    .Free_02E9: skip $01
        ; Free RAM.

    ; $02EA[0x01] - (Channel, Tremolo, Timer)
    .Chan5_TremDelay: skip $01
        ; The channel 5 tremolo delay.

    ; $02EB[0x01] - (Free)
    .Free_02EB: skip $01
        ; Free RAM.

    ; $02EC[0x01] - (Channel, Tremolo, Timer)
    .Chan6_TremDelay: skip $01
        ; The channel 6 tremolo delay.

    ; $02ED[0x01] - (Free)
    .Free_02ED: skip $01
        ; Free RAM.

    ; $02EE[0x01] - (Channel, Tremolo, Timer)
    .Chan7_TremDelay: skip $01
        ; The channel 7 tremolo delay.

    ; $02EF[0x01] - (Free)
    .Free_02EF: skip $01
        ; Free RAM.


    ; $02F0[0x01] - (Channel, Transposition)
    .Chan0_Transposition: skip $01
        ; The channel 0 transposition.

    ; $02F1[0x01] - (Free)
    .Free_02F1: skip $01
        ; Free RAM.

    ; $02F2[0x01] - (Channel, Transposition)
    .Chan1_Transposition: skip $01
        ; The channel 1 transposition.

    ; $02F3[0x01] - (Free)
    .Free_02F3: skip $01
        ; Free RAM.

    ; $02F4[0x01] - (Channel, Transposition)
    .Chan2_Transposition: skip $01
        ; The channel 2 transposition.

    ; $02F5[0x01] - (Free)
    .Free_02F5: skip $01
        ; Free RAM.

    ; $02F6[0x01] - (Channel, Transposition)
    .Chan3_Transposition: skip $01
        ; The channel 3 transposition.

    ; $02F7[0x01] - (Free)
    .Free_02F7: skip $01
        ; Free RAM.

    ; $02F8[0x01] - (Channel, Transposition)
    .Chan4_Transposition: skip $01
        ; The channel 4 transposition.

    ; $02F9[0x01] - (Free)
    .Free_02F9: skip $01
        ; Free RAM.

    ; $02FA[0x01] - (Channel, Transposition)
    .Chan5_Transposition: skip $01
        ; The channel 5 transposition.

    ; $02FB[0x01] - (Free)
    .Free_02FB: skip $01
        ; Free RAM.

    ; $02FC[0x01] - (Channel, Transposition)
    .Chan6_Transposition: skip $01
        ; The channel 6 transposition.

    ; $02FD[0x01] - (Free)
    .Free_02FD: skip $01
        ; Free RAM.

    ; $02FE[0x01] - (Channel, Transposition)
    .Chan7_Transposition: skip $01
        ; The channel 7 transposition.

    ; $02FF[0x01] - (Free)
    .Free_02FF: skip $01
        ; Free RAM.

    ; ==========================================================================

    ; $0300[0x02] - (Channel, Volume)
    .Chan0_Vol: skip $02
        ; The volume for channel 0.

    ; $0302[0x02] - (Channel, Volume)
    .Chan1_Vol: skip $02
        ; The volume for channel 1.

    ; $0304[0x02] - (Channel, Volume)
    .Chan2_Vol: skip $02
        ; The volume for channel 2.

    ; $0306[0x02] - (Channel, Volume)
    .Chan3_Vol: skip $02
        ; The volume for channel 3.

    ; $0308[0x02] - (Channel, Volume)
    .Chan4_Vol: skip $02
        ; The volume for channel 4.

    ; $030A[0x02] - (Channel, Volume)
    .Chan5_Vol: skip $02
        ; The volume for channel 5.

    ; $030C[0x02] - (Channel, Volume)
    .Chan6_Vol: skip $02
        ; The volume for channel 6.

    ; $030E[0x02] - (Channel, Volume)
    .Chan7_Vol: skip $02
        ; The volume for channel 7.


    ; $0310[0x02] - (Channel, Volume)
    .Chan0_VolIncrement: skip $02
        ; The channel 0 volume slide increment.

    ; $0312[0x02] - (Channel, Volume)
    .Chan1_VolIncrement: skip $02
        ; The channel 1 volume slide increment.

    ; $0314[0x02] - (Channel, Volume)
    .Chan2_VolIncrement: skip $02
        ; The channel 2 volume slide increment.

    ; $0316[0x02] - (Channel, Volume)
    .Chan3_VolIncrement: skip $02
        ; The channel 3 volume slide increment.

    ; $0318[0x02] - (Channel, Volume)
    .Chan4_VolIncrement: skip $02
        ; The channel 4 volume slide increment.

    ; $031A[0x02] - (Channel, Volume)
    .Chan5_VolIncrement: skip $02
        ; The channel 5 volume slide increment.

    ; $031C[0x02] - (Channel, Volume)
    .Chan6_VolIncrement: skip $02
        ; The channel 6 volume slide increment.

    ; $031E[0x02] - (Channel, Volume)
    .Chan7_VolIncrement: skip $02
        ; The channel 7 volume slide increment.


    ; $0320[0x01] - (Channel, Volume)
    .Chan0_VolTarget: skip $01
        ; The channel 0 volume slide target.

    ; $0321[0x01] - (Channel, Volume)
    .Chan0_FinalVol: skip $01
        ; The channel 0 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $0322[0x01] - (Channel, Volume)
    .Chan1_VolTarget: skip $01
        ; The channel 1 volume slide target.

    ; $0323[0x01] - (Channel, Volume)
    .Chan1_FinalVol: skip $01
        ; The channel 1 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $0324[0x01] - (Channel, Volume)
    .Chan2_VolTarget: skip $01
        ; The channel 2 volume slide target.

    ; $0325[0x01] - (Channel, Volume)
    .Chan2_FinalVol: skip $01
        ; The channel 2 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $0326[0x01] - (Channel, Volume)
    .Chan3_VolTarget: skip $01
        ; The channel 3 volume slide target.

    ; $0327[0x01] - (Channel, Volume)
    .Chan3_FinalVol: skip $01
        ; The channel 3 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $0328[0x01] - (Channel, Volume)
    .Chan4_VolTarget: skip $01
        ; The channel 4 volume slide target.

    ; $0329[0x01] - (Channel, Volume)
    .Chan4_FinalVol: skip $01
        ; The channel 4 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $032A[0x01] - (Channel, Volume)
    .Chan5_VolTarget: skip $01
        ; The channel 5 volume slide target.

    ; $032B[0x01] - (Channel, Volume)
    .Chan5_FinalVol: skip $01
        ; The channel 5 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $032C[0x01] - (Channel, Volume)
    .Chan6_VolTarget: skip $01
        ; The channel 6 volume slide target.

    ; $032D[0x01] - (Channel, Volume)
    .Chan6_FinalVol: skip $01
        ; The channel 6 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.

    ; $032E[0x01] - (Channel, Volume)
    .Chan7_VolTarget: skip $01
        ; The channel 7 volume slide target.

    ; $032F[0x01] - (Channel, Volume)
    .Chan7_FinalVol: skip $01
        ; The channel 7 finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and local channel volume
        ; changes are applied.


    ; $0330[0x02] - (Channel, Pan)
    .Chan0_PanValue: skip $02
        ; The channel 0 panning value.

    ; $0332[0x02] - (Channel, Pan)
    .Chan1_PanValue: skip $02
        ; The channel 1 panning value.

    ; $0334[0x02] - (Channel, Pan)
    .Chan2_PanValue: skip $02
        ; The channel 2 panning value.

    ; $0336[0x02] - (Channel, Pan)
    .Chan3_PanValue: skip $02
        ; The channel 3 panning value.

    ; $0338[0x02] - (Channel, Pan)
    .Chan4_PanValue: skip $02
        ; The channel 4 panning value.

    ; $033A[0x02] - (Channel, Pan)
    .Chan5_PanValue: skip $02
        ; The channel 5 panning value.

    ; $033C[0x02] - (Channel, Pan)
    .Chan6_PanValue: skip $02
        ; The channel 6 panning value.

    ; $033E[0x02] - (Channel, Pan)
    .Chan7_PanValue: skip $02
        ; The channel 7 panning value.


    ; $0340[0x02] - (Channel, Pan)
    .Chan0_PanIncrement: skip $02
        ; The pan slide value for channel 0.

    ; $0342[0x02] - (Channel, Pan)
    .Chan1_PanIncrement: skip $02
        ; The pan slide value for channel 1.

    ; $0344[0x02] - (Channel, Pan)
    .Chan2_PanIncrement: skip $02
        ; The pan slide value for channel 2.

    ; $0346[0x02] - (Channel, Pan)
    .Chan3_PanIncrement: skip $02
        ; The pan slide value for channel 3.

    ; $0348[0x02] - (Channel, Pan)
    .Chan4_PanIncrement: skip $02
        ; The pan slide value for channel 4.

    ; $034A[0x02] - (Channel, Pan)
    .Chan5_PanIncrement: skip $02
        ; The pan slide value for channel 5.

    ; $034C[0x02] - (Channel, Pan)
    .Chan6_PanIncrement: skip $02
        ; The pan slide value for channel 6.

    ; $034E[0x02] - (Channel, Pan)
    .Chan7_PanIncrement: skip $02
        ; The pan slide value for channel 7.


    ; $0350[0x01] - (Channel, Pan)
    .Chan0_PanTarget: skip $01
        ; The channel 0 target pan slide value.

    ; $0351[0x01] - (Channel, Pan)
    .Chan0_PanSetting: skip $01
        ; The channel 0 pan raw settings value.

    ; $0352[0x01] - (Channel, Pan)
    .Chan1_PanTarget: skip $01
        ; The channel 1 target pan slide value.

    ; $0353[0x01] - (Channel, Pan)
    .Chan1_PanSetting: skip $01
        ; The channel 1 pan raw settings value.

    ; $0354[0x01] - (Channel, Pan)
    .Chan2_PanTarget: skip $01
        ; The channel 2 target pan slide value.

    ; $0355[0x01] - (Channel, Pan)
    .Chan2_PanSetting: skip $01
        ; The channel 2 pan raw settings value.

    ; $0356[0x01] - (Channel, Pan)
    .Chan3_PanTarget: skip $01
        ; The channel 3 target pan slide value.

    ; $0357[0x01] - (Channel, Pan)
    .Chan3_PanSetting: skip $01
        ; The channel 3 pan raw settings value.

    ; $0358[0x01] - (Channel, Pan)
    .Chan4_PanTarget: skip $01
        ; The channel 4 target pan slide value.

    ; $0359[0x01] - (Channel, Pan)
    .Chan4_PanSetting: skip $01
        ; The channel 4 pan raw settings value.

    ; $035A[0x01] - (Channel, Pan)
    .Chan5_PanTarget: skip $01
        ; The channel 5 target pan slide value.

    ; $035B[0x01] - (Channel, Pan)
    .Chan5_PanSetting: skip $01
        ; The channel 5 pan raw settings value.

    ; $035C[0x01] - (Channel, Pan)
    .Chan6_PanTarget: skip $01
        ; The channel 6 target pan slide value.

    ; $035D[0x01] - (Channel, Pan)
    .Chan6_PanSetting: skip $01
        ; The channel 6 pan raw settings value.

    ; $035E[0x01] - (Channel, Pan)
    .Chan7_PanTarget: skip $01
        ; The channel 7 target pan slide value.

    ; $035F[0x01] - (Channel, Pan)
    .Chan7_PanSetting: skip $01
        ; The channel 7 pan raw settings value.


    ; $0360[0x02] - (Channel, Pitch)
    .Chan0_PitchCalc: skip $02
        ; The channel 0 pitch calculation.

    ; $0362[0x02] - (Channel, Pitch)
    .Chan1_PitchCalc: skip $02
        ; The channel 1 pitch calculation.

    ; $0364[0x02] - (Channel, Pitch)
    .Chan2_PitchCalc: skip $02
        ; The channel 2 pitch calculation.

    ; $0366[0x02] - (Channel, Pitch)
    .Chan3_PitchCalc: skip $02
        ; The channel 3 pitch calculation.

    ; $0368[0x02] - (Channel, Pitch)
    .Chan4_PitchCalc: skip $02
        ; The channel 4 pitch calculation.

    ; $036A[0x02] - (Channel, Pitch)
    .Chan5_PitchCalc: skip $02
        ; The channel 5 pitch calculation.

    ; $036C[0x02] - (Channel, Pitch)
    .Chan6_PitchCalc: skip $02
        ; The channel 6 pitch calculation.

    ; $036E[0x02] - (Channel, Pitch)
    .Chan7_PitchCalc: skip $02
        ; The channel 7 pitch calculation.


    ; $0370[0x01] - (Channel, Pitch)
    .Chan0_MultiframePitchAdjustment: skip $01
        ; The channel 0 multiframe pitch adjustment.
        ; TODO: I don't actually understand what this does.

    ; $0372[0x01] - (Channel, Pitch)
    .Chan1_MultiframePitchAdjustment: skip $01
        ; The channel 1 multiframe pitch adjustment.

    ; $0374[0x01] - (Channel, Pitch)
    .Chan2_MultiframePitchAdjustment: skip $01
        ; The channel 2 multiframe pitch adjustment.

    ; $0376[0x01] - (Channel, Pitch)
    .Chan3_MultiframePitchAdjustment: skip $01
        ; The channel 3 multiframe pitch adjustment.

    ; $0378[0x01] - (Channel, Pitch)
    .Chan4_MultiframePitchAdjustment: skip $01
        ; The channel 4 multiframe pitch adjustment.

    ; $037A[0x01] - (Channel, Pitch)
    .Chan5_MultiframePitchAdjustment: skip $01
        ; The channel 5 multiframe pitch adjustment.

    ; $037C[0x01] - (Channel, Pitch)
    .Chan6_MultiframePitchAdjustment: skip $01
        ; The channel 6 multiframe pitch adjustment.

    ; $037E[0x01] - (Channel, Pitch)
    .Chan7_MultiframePitchAdjustment: skip $01
        ; The channel 7 multiframe pitch adjustment.


    ; $0380[0x01] - (Channel, Note)
    .Chan0_NoteCalc: skip $01
        ; The channel 0 note for calculations.
        ; TODO: I don't actually understand what this does.

    ; $0381[0x01] - (Channel, Tune)
    .Chan0_Tuning: skip $01
        ; The channel 0 fine pitch tuning.

    ; $0382[0x01] - (Channel, Note)
    .Chan1_NoteCalc: skip $01
        ; The channel 1 note for calculations.

    ; $0383[0x01] - (Channel, Tune)
    .Chan1_Tuning: skip $01
        ; The channel 1 fine pitch tuning.

    ; $0384[0x01] - (Channel, Note)
    .Chan2_NoteCalc: skip $01
        ; The channel 2 note for calculations.

    ; $0385[0x01] - (Channel, Tune)
    .Chan2_Tuning: skip $01
        ; The channel 2 fine pitch tuning.

    ; $0386[0x01] - (Channel, Note)
    .Chan3_NoteCalc: skip $01
        ; The channel 3 note for calculations.

    ; $0387[0x01] - (Channel, Tune)
    .Chan3_Tuning: skip $01
        ; The channel 3 fine pitch tuning.

    ; $0388[0x01] - (Channel, Note)
    .Chan4_NoteCalc: skip $01
        ; The channel 4 note for calculations.

    ; $0389[0x01] - (Channel, Tune)
    .Chan4_Tuning: skip $01
        ; The channel 4 fine pitch tuning.

    ; $038A[0x01] - (Channel, Note)
    .Chan5_NoteCalc: skip $01
        ; The channel 5 note for calculations.

    ; $038B[0x01] - (Channel, Tune)
    .Chan5_Tuning: skip $01
        ; The channel 5 fine pitch tuning.

    ; $038C[0x01] - (Channel, Note)
    .Chan6_NoteCalc: skip $01
        ; The channel 6 note for calculations.

    ; $038D[0x01] - (Channel, Tune)
    .Chan6_Tuning: skip $01
        ; The channel 6 fine pitch tuning.

    ; $038E[0x01] - (Channel, Note)
    .Chan7_NoteCalc: skip $01
        ; The channel 7 note for calculations.

    ; $038F[0x01] - (Channel, Tune)
    .Chan7_Tuning: skip $01
        ; The channel 7 fine pitch tuning.


    ; $0390[0x02] - (Channel, SFX)
    .Chan0_SFXPtr: skip $02
        ; The channel 0 SFX pointer.

    ; $0392[0x02] - (Channel, SFX)
    .Chan1_SFXPtr: skip $02
        ; The channel 1 SFX pointer.

    ; $0394[0x02] - (Channel, SFX)
    .Chan2_SFXPtr: skip $02
        ; The channel 2 SFX pointer.

    ; $0396[0x02] - (Channel, SFX)
    .Chan3_SFXPtr: skip $02
        ; The channel 3 SFX pointer.

    ; $0398[0x02] - (Channel, SFX)
    .Chan4_SFXPtr: skip $02
        ; The channel 4 SFX pointer.

    ; $039A[0x02] - (Channel, SFX)
    .Chan5_SFXPtr: skip $02
        ; The channel 5 SFX pointer.

    ; $039C[0x02] - (Channel, SFX)
    .Chan6_SFXPtr: skip $02
        ; The channel 6 SFX pointer.

    ; $039E[0x02] - (Channel, SFX)
    .Chan7_SFXPtr: skip $02
        ; The channel 7 SFX pointer.


    ; $03A0[0x01] - (Channel, SFX)
    .Chan0_SFXID: skip $01
        ; The SFX ID playing on channel 0.

    ; $03A1[0x01] - (Channel, SFX)
    .Chan0_SFXDelay: skip $01
        ; The channel 0 SFX delay.

    ; $03A2[0x01] - (Channel, SFX)
    .Chan1_SFXID: skip $01
        ; The SFX ID playing on channel 1.

    ; $03A3[0x01] - (Channel, SFX)
    .Chan1_SFXDelay: skip $01
        ; The channel 1 SFX delay.

    ; $03A4[0x01] - (Channel, SFX)
    .Chan2_SFXID: skip $01
        ; The SFX ID playing on channel 2.

    ; $03A5[0x01] - (Channel, SFX)
    .Chan2_SFXDelay: skip $01
        ; The channel 2 SFX delay.

    ; $03A6[0x01] - (Channel, SFX)
    .Chan3_SFXID: skip $01
        ; The SFX ID playing on channel 3.

    ; $03A7[0x01] - (Channel, SFX)
    .Chan3_SFXDelay: skip $01
        ; The channel 3 SFX delay.

    ; $03A8[0x01] - (Channel, SFX)
    .Chan4_SFXID: skip $01
        ; The SFX ID playing on channel 4.

    ; $03A9[0x01] - (Channel, SFX)
    .Chan4_SFXDelay: skip $01
        ; The channel 4 SFX delay.

    ; $03AA[0x01] - (Channel, SFX)
    .Chan5_SFXID: skip $01
        ; The SFX ID playing on channel 5.

    ; $03AB[0x01] - (Channel, SFX)
    .Chan5_SFXDelay: skip $01
        ; The channel 5 SFX delay.

    ; $03AC[0x01] - (Channel, SFX)
    .Chan6_SFXID: skip $01
        ; The SFX ID playing on channel 6.

    ; $03AD[0x01] - (Channel, SFX)
    .Chan6_SFXDelay: skip $01
        ; The channel 6 SFX delay.

    ; $03AE[0x01] - (Channel, SFX)
    .Chan7_SFXID: skip $01
        ; The SFX ID playing on channel 7.

    ; $03AF[0x01] - (Channel, SFX)
    .Chan7_SFXDelay: skip $01
        ; The channel 7 SFX delay.


    ; $03B0[0x01] - (Channel, SFX, Timer)
    .Chan0_SFXTimer: skip $01
        ; The channel 0 SFX timer.

    ; $03B1[0x01] - (Channel, SFX, Timer)
    .Chan0_SFXDuration: skip $01
        ; The channel 0 SFX duration.

    ; $03B2[0x01] - (Channel, SFX, Timer)
    .Chan1_SFXTimer: skip $01
        ; The channel 1 SFX timer.

    ; $03B3[0x01] - (Channel, SFX, Timer)
    .Chan1_SFXDuration: skip $01
        ; The channel 1 SFX duration.

    ; $03B4[0x01] - (Channel, SFX, Timer)
    .Chan2_SFXTimer: skip $01
        ; The channel 2 SFX timer.

    ; $03B5[0x01] - (Channel, SFX, Timer)
    .Chan2_SFXDuration: skip $01
        ; The channel 2 SFX duration.

    ; $03B6[0x01] - (Channel, SFX, Timer)
    .Chan3_SFXTimer: skip $01
        ; The channel 3 SFX timer.

    ; $03B7[0x01] - (Channel, SFX, Timer)
    .Chan3_SFXDuration: skip $01
        ; The channel 3 SFX duration.

    ; $03B8[0x01] - (Channel, SFX, Timer)
    .Chan4_SFXTimer: skip $01
        ; The channel 4 SFX timer.

    ; $03B9[0x01] - (Channel, SFX, Timer)
    .Chan4_SFXDuration: skip $01
        ; The channel 4 SFX duration.

    ; $03BA[0x01] - (Channel, SFX, Timer)
    .Chan5_SFXTimer: skip $01
        ; The channel 5 SFX timer.

    ; $03BB[0x01] - (Channel, SFX, Timer)
    .Chan5_SFXDuration: skip $01
        ; The channel 5 SFX duration.

    ; $03BC[0x01] - (Channel, SFX, Timer)
    .Chan6_SFXTimer: skip $01
        ; The channel 6 SFX timer.

    ; $03BD[0x01] - (Channel, SFX, Timer)
    .Chan6_SFXDuration: skip $01
        ; The channel 6 SFX duration.

    ; $03BE[0x01] - (Channel, SFX, Timer)
    .Chan7_SFXTimer: skip $01
        ; The channel 7 SFX timer.

    ; $03BF[0x01] - (Channel, SFX, Timer)
    .Chan7_SFXDuration: skip $01
        ; The channel 7 SFX duration.

    ; ==========================================================================

    ; $03C0[0x01] - (SFX, Ambient)
    .SFXAmbientOffest: skip $01
        ; The SFX or ambient channel index offset. Used to index through SFX
        ; and ambient arrays.

    ; $03C1[0x01] - (SFX)
    .SFXChannel: skip $01
        ; The channels in use by SFX/Ambient.

    ; $03C2[0x01] - (SFX, Ambient)
    .SFXAmbientDSPAddr: skip $01
        ; This contains the DSP address for the current channel in use by SFX
        ; or ambient sounds.

    ; $03C3[0x01] - (Song, Echo)
    .SongEchoEnable: skip $01
        ; Song channels flagged for echo enable.


    ; Only referenced in an unused function, but it appears to relate to
    ; SFXOFF and SFXBIT. Junk?
    ; $03C4[0x01] - (SFX)
    .SFXOFFRT: skip $01

    ; $03C5[0x01] - (SFX)
    .SFXBITRT: skip $01

    ; $03C6[0x01] - (Free)
    .Free_03C6: skip $01
        ; Free RAM.

    ; $03C7[0x01] - (Echo)
    .EchoFlip: skip $01
        ; Used as a flip flop for toggling incrementing of EchoDelayCache.


    ; TODO: Copies AmbientOFF and AmbientBIT, but never used. Junk?
    ; $03C8[0x01] - (Ambient)
    .AmbientOFF2: skip $01

    ; $03C9[0x01] - (Ambient)
    .AmbientBIT2: skip $01


    ; $03CA[0x01] - (Song)
    .SongFade: skip $01
        ; The song fade out timer.
    
    ; $03CB[0x01] - (SFX)
    .SFX2Bit: skip $01
        ; Channel bits for SFX2, playing and operating.

    ; $03CC[0x01] - (SFX)
    .SFX2Find: skip $01
        ; A temp var used to find channels in use by a SFX2.

    ; $03CD[0x01] - (SFX)
    .SFX3Bit: skip $01
        ; Channel bits for SFX3, playing and operating.

    ; $03CE[0x01] - (SFX)
    .SFX3Find: skip $01
        ; A temp var used to find channels in use by a SFX3.

    ; $03CF[0x01] - (Ambient)
    .AmbientChannelsInUse: skip $01
        ; The channels in use for Ambient.


    ; $03D0[0x01] - (Channel, SFX, Pan)
    .Chan0_SFXPan: skip $01
        ; The channel 0 SFX pan value.

    ; $03D1[0x01] - (Free)
    .Free_03D1: skip $01
        ; Free RAM.

    ; $03D2[0x01] - (Channel, SFX, Pan)
    .Chan1_SFXPan: skip $01
        ; The channel 1 SFX pan value.

    ; $03D3[0x01] - (Free)
    .Free_03D3: skip $01
        ; Free RAM.

    ; $03D4[0x01] - (Channel, SFX, Pan)
    .Chan2_SFXPan: skip $01
        ; The channel 2 SFX pan value.

    ; $03D5[0x01] - (Free)
    .Free_03D5: skip $01
        ; Free RAM.

    ; $03D6[0x01] - (Channel, SFX, Pan)
    .Chan3_SFXPan: skip $01
        ; The channel 3 SFX pan value.

    ; $03D7[0x01] - (Free)
    .Free_03D7: skip $01

    ; $03D8[0x01] - (Channel, SFX, Pan)
    .Chan4_SFXPan: skip $01
        ; The channel 4 SFX pan value.

    ; $03D9[0x01] - (Free)
    .Free_03D9: skip $01
        ; Free RAM.

    ; $03DA[0x01] - (Channel, SFX, Pan)
    .Chan5_SFXPan: skip $01
        ; The channel 5 SFX pan value.

    ; $03DB[0x01] - (Free)
    .Free_03DB: skip $01
        ; Free RAM.

    ; $03DC[0x01] - (Channel, SFX, Pan)
    .Chan6_SFXPan: skip $01
        ; The channel 6 SFX pan value.

    ; $03DD[0x01] - (Free)
    .Free_03DD: skip $01
        ; Free RAM.

    ; $03DE[0x01] - (Channel, SFX, Pan)
    .Chan7_SFXPan: skip $01
        ; The channel 7 SFX pan value.

    ; $03DF[0x01] - (Free)
    .Free_03DF: skip $01
        ; Free RAM.


    ; $03E0[0x01] - (Ambient)
    .AmbientFind: skip $01
        ; Used to find Ambient channel.

    ; $03E1[0x01] - (Song, Volume)
    .SongVolumeCache: skip $01
        ; Caches song volume between half and max volume commands.

    ; $03E2[0x01] - (SFX, Echo)
    .SFXEchoTable: skip $01
        ; Holds value from echo table for SFX.
        ; TODO: I don't actually understand what this does.

    ; $03E3[0x01] - (SFX, Echo)
    .SFXEchos: skip $01
        ; Bitfield for SFX echos.

    ; $03E4[0x01] - (Ambient)
    .AmbientFade: skip $01
        ; The ambient sound fade timer. If non-0, the ambient sound will fade.

    ; $03E5[0x01] - (Ambient, Volume)
    .AmbientFadeVol: skip $01
        ; The ambient sound fade volume. While the ambient fade timer is non-0
        ; this will be divided by 2 until its 0.

    ; $03E6[0x19] - (Free)
    .Free_03E6: skip $19
        ; Free RAM.


    
    ; $03FF[0x01] - (Channel, Volume)
    .Chan0_Mute: skip $01
        ; When non-0, mutes channel 0. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $0400[0x01] - (Free)
    .Free_0400: skip $01
        ; Free RAM.

    ; $0401[0x01] - (Channel, Volume)
    .Chan1_Mute: skip $01
        ; When non-0, mutes channel 1. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $0402[0x01] - (Free)
    .Free_0402: skip $01
        ; Free RAM.

    ; $0403[0x01] - (Channel, Volume)
    .Chan2_Mute: skip $01
        ; When non-0, mutes channel 2. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $0404[0x01] - (Free)
    .Free_0404: skip $01
        ; Free RAM.

    ; $0405[0x01] - (Channel, Volume)
    .Chan3_Mute: skip $01
        ; When non-0, mutes channel 3. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $0406[0x01] - (Free)
    .Free_0406: skip $01
        ; Free RAM.

    ; $0407[0x01] - (Channel, Volume)
    .Chan4_Mute: skip $01
        ; When non-0, mutes channel 4. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $0408[0x01] - (Free)
    .Free_0408: skip $01
        ; Free RAM.

    ; $0409[0x01] - (Channel, Volume)
    .Chan5_Mute: skip $01
        ; When non-0, mutes channel 5. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $040A[0x01] - (Free)
    .Free_040A: skip $01
        ; Free RAM.

    ; $040B[0x01] - (Channel, Volume)
    .Chan6_Mute: skip $01
        ; When non-0, mutes channel 6. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $040C[0x01] - (Free)
    .Free_040C: skip $01
        ; Free RAM.

    ; $040D[0x01] - ((Channel, Volume)
    .Chan7_Mute: skip $01
        ; When non-0, mutes channel 7. This var never actually has a non-0
        ; value written to it and is only set in an unused function.

    ; $040E[0x01] - (Free)
    .Free_040E: skip $01
        ; Free RAM.


    ; $040F[0x03F0] - (Free)
    .Free_040F: skip $03F0
        ; Free RAM.

    ; Some of this data can move around depending on what sound bank is
    ; loaded but all of the free RAM labled here is unused reguardless of
    ; the sound bank loaded.

    ; $0800-$179D SPC Engine Code
    ; $179E-$17BF Free RAM

    ; $17C0-$284F SFX_DATA
    ; $2850-$287F Free RAM

    ; $2880-$2A8C SongBank_Fairy
    ; $2900-$3937 CREDITS_AUX_POINTER
    ; $2B00-$3188 SONG_POINTERS_AUX
    ; $3938-$3BFF Free RAM

    ; $3C00-$3C6F SAMPLE_POINTERS
    ; $3C70-$3CFF Free RAM

    ; $3D00-$3DAD INSTRUMENT_DATA
    ; $3DAE-$3DFF Free RAM

    ; $3E00-$3EE0 INSTRUMENT_DATA_SFX
    ; $3EE1-$3FFF Free RAM

    ; $4000-$BA9F SAMPLE_DATA
    ; $BAA0-$BFFF Free RAM

    ; $C000-$CFFF TODO: The echo buffer? (pretty sure)

    ; $D000-$D035 SONG_POINTERS (Overworld)
    ; $D000-$E05F SONG_POINTERS (Credits)
    ; $D000-$FCBF SONG_POINTERS (Underworld)

    ; $FCC0-$FDAD TODO: Some sort of data is here but idk what.
    ; $FDAE-$FFBF Free RAM

    ; $FFC0-$FFFF IPL Boot ROM
}
endstruct

; ==============================================================================
