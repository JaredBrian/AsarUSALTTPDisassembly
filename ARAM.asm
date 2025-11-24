; ==============================================================================
; Symbols for the audio processing unit
; ==============================================================================

; Shorthand legend:
; Accum = Accumulator
; Addr = Address
; CMD = Command
; Mult = Multiplier
; Q = Queue
; Ptr = Pointer
; SFX = Sound Effect
; Trem = Tremolo
; Vbr = Vibrato
; Vol = Volume

struct ARAM $0000
{
    ; ===========================================================================
    ; Direct Page 0x00
    ; ===========================================================================
    
    ; Input values from APU ports.
    ; $00[0x01] - (???)
    .InputSong: skip $01

    ; $01[0x01] - (???)
    .InputAmbient: skip $01

    ; $02[0x01] - (???)
    .InputSFX2: skip $01

    ; $03[0x01] - (???)
    .InputSFX3: skip $01


    ; $04[0x01] - (???)
    .CurrentSong: skip $01
        ; The currently playing song sent back to the SNES CPU over I/O.

    ; $05[0x01] - (???)
    .CurrentAmbient: skip $01
        ; The currently playing Ambient sent back to the SNES CPU over I/O.

    ; $06[0x01] - (???)
    .CurrentSFX2: skip $01
        ; The currently playing SFX2 sent back to the SNES CPU over I/O.

    ; $07[0x01] - (???)
    .CurrentSFX3: skip $01
        ; The currently playing SFX3 sent back to the SNES CPU over I/O.


    ; $08[0x01] - (???)
    .LastSong: skip $01
        ; The last song that the APU was told to play.

    ; $09[0x01] - (???)
    .LastAmbient: skip $01
        ; The last Ambient that the APU was told to play.

    ; $0A[0x01] - (???)
    .LastSFX2: skip $01
        ; The last SFX2 that the APU was told to play.

    ; $0B[0x01] - (???)
    .LastSFX3: skip $01
        ; The last SFX3 that the APU was told to play.


    ; $0C[0x01] - (???)
    .Delay: skip $01
        ; Provides a short delay when changing songs.

    ; $0D[0x01] - (Free)
    .Free_0D: skip $01
        ; Free RAM.

    ; $0E[0x02] - (???)
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

    ; $13[0x01] - (???)
    .DoPitch: skip $01
        ; Flags pitch changes via commands.
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

    ; $1A[0x01] - (???)
    .ChannelsInUse: skip $01
        ; Flags channels currently in use by ambient, SFX, or music.

    ; $1B[0x01] - (???)
    .Mute: skip $01
        ; Disables all music.

    ; $1C[0x04] - (Free)
    .Free_1C: skip $04
        ; Free RAM.

    ; $20[0x01] - (???)
    .SFXPan: skip $01
        ; Indicates pan of current SFX. The left takes priority.
        ; lr.. ....
        ; l - pan left
        ; r - pan right

    ; $21[0x0B] - (Free)
    .Free_21: skip $0B
        ; Free RAM.

    ; $2C[0x02] - (???)
    .SFXPtr: skip $02
        ; The SFX data pointer.

    ; $2E[0x02] - (Free)
    .Free_2E: skip $02
        ; Free RAM.

    ; $30[0x02] - (???)
    .Channel0Ptr: skip $02
        ; The track pointer for channel 0.

    ; $32[0x02] - (???)
    .Channel1Ptr: skip $02
        ; The track pointer for channel 1.

    ; $34[0x02] - (???)
    .Channel2Ptr: skip $02
        ; The track pointer for channel 2.

    ; $36[0x02] - (???)
    .Channel3Ptr: skip $02
        ; The track pointer for channel 3.

    ; $38[0x02] - (???)
    .Channel4Ptr: skip $02
        ; The track pointer for channel 4.

    ; $3A[0x02] - (???)
    .Channel5Ptr: skip $02
        ; The track pointer for channel 5.

    ; $3C[0x02] - (???)
    .Channel6Ptr: skip $02
        ; The track pointer for channel 6.

    ; $3E[0x02] - (???)
    .Channel7Ptr: skip $02
        ; The track pointer for channel 7.

    ; $40[0x02] - (???)
    .SegmentPtr: skip $02
        ; The pointer to current song's segments.

    ; $42[0x01] - (???)
    .SegmentLoop: skip $01
        ; Used to build up segment pointers during new songs.

    ; $43[0x01] - (???)
    .SFXTimer: skip $01
        ; This has 0x38 Added to it for every tick that passes on timer 0.
        ; If the result added is greater than 0xFF, we need to take new sfx
        ; input from the 5A22 and handle the current SFX.

    ; $44[0x01] - (???)
    .ChannelOffset: skip $01
        ; Caches channel offset index when the X register (which usually holds
        ; the channel offset) is required.

    ; $45[0x01] - (???)
    .KeyOnQ: skip $01
        ; The DSP.KON (Key on) queue.
        ; TODO: What are these queues used for?

    ; $46[0x01] - (???)
    .KeyOffQ: skip $01
        ; The DSP.KOFF (Key off) queue.

    ; $47[0x01] - (???)
    .ChannelBit: skip $01
        ; Current channel bit for bitfield writes. TODO: What?

    ; $48[0x01] - (???)
    .FlagQ: skip $01
        ; The DSP.FLG (Flag) queue.

    ; $49[0x01] - (???)
    .NoiseQ: skip $01
        ; The DSP.NON (Noise Enable) queue.

    ; $4A[0x01] - (???)
    .EchoQ: skip $01
        ; The DSP.EON (Echo Enable) queue.

    ; $4B[0x01] - (???)
    .PitchModQ: skip $01
        ; The DSP.PMON (Pitch Modulation) queue.

    ; $4C[0x01] - (???)
    .EchoTimer: skip $01
        ; A timer to prevent certain things until it reaches the same 
        ; value as $4D (EchoDelayQ).

    ; $4D[0x01] - (???)
    .EchoDelayQ: skip $01
        ; The DSP.EDL (Echo Delay) queue.

    ; $4E[0x01] - (???)
    .EchoFeedbackQ: skip $01
        ; The DSP.EFB (Echo Feedback) queue.

    ; $4F[0x01] - (Free)
    .Free_4F: skip $01
        ; Free RAM.

    ; $50[0x01] - (???)
    .GlobalTransposition: skip $01
        ; The global transposition.

    ; $51[0x01] - (???)
    .SongTimer: skip $01
        ; This has the Tempo high byte ($53) Added to it for every tick that 
        ; passes on timer 0. If the result added is greater than 0xFF, we need
        ; to take new song input from the 5A22 and handle the current song.

    ; $52[0x02] - (???)
    .Tempo: skip $02
        ; The song tempo.

    ; $54[0x01] - (???)
    .TempoTimer: skip $01
        ; The tempo sweep duration.

    ; $55[0x01] - (???)
    .TempoTarget: skip $01
        ; The target tempo for sweep.

    ; $56[0x01] - (???)
    .TempoSweep: skip $01
        ; The tempo slide sweep amount.

    ; $58[0x02] - (???)
    .GlobalVol: skip $02
        ; The global volume.

    ; $5A[0x01] - (???)
    .GlobalVolTimer: skip $01
        ; The global volume slide timer.

    ; $5B[0x01] - (???)
    .GlobalVolTarget: skip $01
        ; Global volume slide target.

    ; $5C[0x02] - (???)
    .GlobalVolIncrament: skip $02
        ; Global volume slide increment per loop.

    ; $5E[0x01] - (???)
    .Slide: skip $01
        ; Flags channels for pitch slide.

    ; $5F[0x01] - (???)
    .PrecussionBaseNote: skip $01
        ; The base note that will be added to the percussion commands (0xCA-0xDF)
        ; When playing a percussion note.

    ; $60[0x02] - (???)
    .EchoVolLeftQ: skip $02
        ; The EVOLL (Echo Volume Left) queue.

    ; $62[0x02] - (???)
    .EchoVolRightQ: skip $02
        ; The EVOLR (Echo Volume Right) queue.

    ; $64[0x02] - (???)
    .EchoPanLeft: skip $02
        ; Echo volume left panning steps.

    ; $66[0x02] - (???)
    .EchoPanRight: skip $02
        ; Echo volume right panning steps.

    ; $68[0x01] - (???)
    .EchoPanTimer: skip $01
        ; The echo pan timer.

    ; $69[0x01] - (???)
    .EchoPanLeftTarget: skip $01
        ; The echo pan target Left.

    ; $6A[0x01] - (???)
    .EchoPanRightTarget: skip $01
        ; The echo pan target Right.

    ; $6B[0x05] - (Free)
    .Free_6B: skip $05
        ; Free RAM.


    ; TODO: Figure out the difference between the 2. The CMDTimer seems to always
    ; be one lower than the duration.
    ; $70[0x01] - (???)
    .Channel0Duration: skip $01
        ; The countdown for next note playing on channel 0.

    ; $71[0x01] - (???)
    .Channel0CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 0.

    ; $72[0x01] - (???)
    .Channel1Duration: skip $01
        ; The countdown for next note playing on channel 1.

    ; $73[0x01] - (???)
    .Channel1CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 1.

    ; $74[0x01] - (???)
    .Channel2Duration: skip $01
        ; The countdown for next note playing on channel 2.

    ; $75[0x01] - (???)
    .Channel2CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 2.

    ; $76[0x01] - (???)
    .Channel3Duration: skip $01
        ; The countdown for next note playing on channel 3.

    ; $77[0x01] - (???)
    .Channel3CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 3.

    ; $78[0x01] - (???)
    .Channel4Duration: skip $01
        ; The countdown for next note playing on channel 4.

    ; $79[0x01] - (???)
    .Channel4CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 4.

    ; $7A[0x01] - (???)
    .Channel5Duration: skip $01
        ; The countdown for next note playing on channel 5.

    ; $7B[0x01] - (???)
    .Channel5CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 5.

    ; $7C[0x01] - (???)
    .Channel6Duration: skip $01
        ; The countdown for next note playing on channel 6.

    ; $7D[0x01] - (???)
    .Channel6CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 6.

    ; $7E[0x01] - (???)
    .Channel7Duration: skip $01
        ; The countdown for next note playing on channel 7.

    ; $7F[0x01] - (???)
    .Channel7CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 7.


    ; $80[0x02] - (???)
    .Channel0PartCounter: skip $02
        ; The channel 0 part loop counters. The high byte is unused.

    ; $82[0x02] - (???)
    .Channel1PartCounter: skip $02
        ; The channel 1 part loop counters. The high byte is unused.

    ; $84[0x02] - (???)
    .Channel2PartCounter: skip $02
        ; The channel 2 part loop counters. The high byte is unused.

    ; $86[0x02] - (???)
    .Channel3PartCounter: skip $02
        ; The channel 3 part loop counters. The high byte is unused.

    ; $88[0x02] - (???)
    .Channel4PartCounter: skip $02
        ; The channel 4 part loop counters. The high byte is unused.

    ; $8A[0x02] - (???)
    .Channel5PartCounter: skip $02
        ; The channel 5 part loop counters. The high byte is unused.

    ; $8C[0x02] - (???)
    .Channel6PartCounter: skip $02
        ; The channel 6 part loop counters. The high byte is unused.

    ; $8E[0x02] - (???)
    .Channel7PartCounter: skip $02
        ; The channel 7 part loop counters. The high byte is unused.


    ; $90[0x01] - (???)
    .Channel0VolTimer: skip $01
        ; The channel 0 volume slide timer.

    ; $91[0x01] - (???)
    .Channel0PanTimer: skip $01
        ; The channel 0 pan slide timers.

    ; $92[0x01] - (???)
    .Channel1VolTimer: skip $01
        ; The channel 1 volume slide timer.

    ; $93[0x01] - (???)
    .Channel1PanTimer: skip $01
        ; The channel 1 pan slide timers.

    ; $94[0x01] - (???)
    .Channel2VolTimer: skip $01
        ; The channel 2 volume slide timer.

    ; $95[0x01] - (???)
    .Channel2PanTimer: skip $01
        ; The channel 2 pan slide timers.

    ; $96[0x01] - (???)
    .Channel3VolTimer: skip $01
        ; The channel 3 volume slide timer.

    ; $97[0x01] - (???)
    .Channel3PanTimer: skip $01
        ; The channel 3 pan slide timers.

    ; $98[0x01] - (???)
    .Channel4VolTimer: skip $01
        ; The channel 4 volume slide timer.

    ; $99[0x01] - (???)
    .Channel4PanTimer: skip $01
        ; The channel 4 pan slide timers.

    ; $9A[0x01] - (???)
    .Channel5VolTimer: skip $01
        ; The channel 5 volume slide timer.

    ; $9B[0x01] - (???)
    .Channel5PanTimer: skip $01
        ; The channel 5 pan slide timers.

    ; $9C[0x01] - (???)
    .Channel6VolTimer: skip $01
        ; The channel 6 volume slide timer.

    ; $9D[0x01] - (???)
    .Channel6PanTimer: skip $01
        ; The channel 6 pan slide timers.

    ; $9E[0x01] - (???)
    .Channel7VolTimer: skip $01
        ; The channel 7 volume slide timer.

    ; $9F[0x01] - (???)
    .Channel7PanTimer: skip $01
        ; The channel 7 pan slide timers.


    ; $A0[0x01] - (???)
    .Channel0PitchTimer: skip $01
        ; The channel 0 pitch slide timer.

    ; $A1[0x01] - (???)
    .Channel0PitchDelay: skip $01
        ; The channel 0 pitch slide delay for operation.

    ; $A2[0x01] - (???)
    .Channel1PitchTimer: skip $01
        ; The channel 1 pitch slide timer.

    ; $A3[0x01] - (???)
    .Channel1PitchDelay: skip $01
        ; The channel 1 pitch slide delay for operation.

    ; $A4[0x01] - (???)
    .Channel2PitchTimer: skip $01
        ; The channel 2 pitch slide timer.

    ; $A5[0x01] - (???)
    .Channel2PitchDelay: skip $01
        ; The channel 2 pitch slide delay for operation.

    ; $A6[0x01] - (???)
    .Channel3PitchTimer: skip $01
        ; The channel 3 pitch slide timer.

    ; $A7[0x01] - (???)
    .Channel3PitchDelay: skip $01
        ; The channel 3 pitch slide delay for operation.

    ; $A8[0x01] - (???)
    .Channel4PitchTimer: skip $01
        ; The channel 4 pitch slide timer.

    ; $A9[0x01] - (???)
    .Channel4PitchDelay: skip $01
        ; The channel 4 pitch slide delay for operation.

    ; $AA[0x01] - (???)
    .Channel5PitchTimer: skip $01
        ; The channel 5 pitch slide timer.

    ; $AB[0x01] - (???)
    .Channel5PitchDelay: skip $01
        ; The channel 5 pitch slide delay for operation.

    ; $AC[0x01] - (???)
    .Channel6PitchTimer: skip $01
        ; The channel 6 pitch slide timer.

    ; $AD[0x01] - (???)
    .Channel6PitchDelay: skip $01
        ; The channel 6 pitch slide delay for operation.

    ; $AE[0x01] - (???)
    .Channel7PitchTimer: skip $01
        ; The channel 7 pitch slide timer.

    ; $AF[0x01] - (???)
    .Channel7PitchDelay: skip $01
        ; The channel 7 pitch slide delay for operation.


    ; $B0[0x01] - (???)
    .Channel0VBRStrength: skip $01
        ; The channel 0 vibrato strength.

    ; $B1[0x01] - (???)
    .Channel0VBRIntensity: skip $01
        ; The channel 0 vibrato max intensity.

    ; $B2[0x01] - (???)
    .Channel1VBRStrength: skip $01
        ; The channel 1 vibrato strength.

    ; $B3[0x01] - (???)
    .Channel1VBRIntensity: skip $01
        ; The channel 1 vibrato max intensity.

    ; $B4[0x01] - (???)
    .Channel2VBRStrength: skip $01
        ; The channel 2 vibrato strength.

    ; $B5[0x01] - (???)
    .Channel2VBRIntensity: skip $01
        ; The channel 2 vibrato max intensity.

    ; $B6[0x01] - (???)
    .Channel3VBRStrength: skip $01
        ; The channel 3 vibrato strength.

    ; $B7[0x01] - (???)
    .Channel3VBRIntensity: skip $01
        ; The channel 3 vibrato max intensity.

    ; $B8[0x01] - (???)
    .Channel4VBRStrength: skip $01
        ; The channel 4 vibrato strength.

    ; $B9[0x01] - (???)
    .Channel4VBRIntensity: skip $01
        ; The channel 4 vibrato max intensity.

    ; $BA[0x01] - (???)
    .Channel5VBRStrength: skip $01
        ; The channel 5 vibrato strength.

    ; $BB[0x01] - (???)
    .Channel5VBRIntensity: skip $01
        ; The channel 5 vibrato max intensity.

    ; $BC[0x01] - (???)
    .Channel6VBRStrength: skip $01
        ; The channel 6 vibrato strength.

    ; $BD[0x01] - (???)
    .Channel6VBRIntensity: skip $01
        ; The channel 6 vibrato max intensity.

    ; $BE[0x01] - (???)
    .Channel7VBRStrength: skip $01
        ; The channel 7 vibrato strength.

    ; $BF[0x01] - (???)
    .Channel7VBRIntensity: skip $01
        ; The channel 7 vibrato max intensity.


    ; $C0[0x01] - (???)
    .Channel0TremTimer: skip $01
        ; The channel 0 tremolo timer.

    ; $C1[0x01] - (???)
    .Channel0TremIntensity: skip $01
        ; The channel 0 tremolo intensity.

    ; $C2[0x01] - (???)
    .Channel1TremTimer: skip $01
        ; The channel 1 tremolo timer.

    ; $C3[0x01] - (???)
    .Channel1TremIntensity: skip $01
        ; The channel 1 tremolo intensity.

    ; $C4[0x01] - (???)
    .Channel2TremTimer: skip $01
        ; The channel 2 tremolo timer.

    ; $C5[0x01] - (???)
    .Channel2TremIntensity: skip $01
        ; The channel 2 tremolo intensity.

    ; $C6[0x01] - (???)
    .Channel3TremTimer: skip $01
        ; The channel 3 tremolo timer.

    ; $C7[0x01] - (???)
    .Channel3TremIntensity: skip $01
        ; The channel 3 tremolo intensity.

    ; $C8[0x01] - (???)
    .Channel4TremTimer: skip $01
        ; The channel 4 tremolo timer.

    ; $C9[0x01] - (???)
    .Channel4TremIntensity: skip $01
        ; The channel 4 tremolo intensity.

    ; $CA[0x01] - (???)
    .Channel5TremTimer: skip $01
        ; The channel 5 tremolo timer.

    ; $CB[0x01] - (???)
    .Channel5TremIntensity: skip $01
        ; The channel 5 tremolo intensity.

    ; $CC[0x01] - (???)
    .Channel6TremTimer: skip $01
        ; The channel 6 tremolo timer.

    ; $CD[0x01] - (???)
    .Channel6TremIntensity: skip $01
        ; The channel 6 tremolo intensity.

    ; $CE[0x01] - (???)
    .Channel7TremTimer: skip $01
        ; The channel 7 tremolo timer.

    ; $CF[0x01] - (???)
    .Channel7TremIntensity: skip $01
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

    ; $0100[0x01] - (???)
    .Channel0VbrCounter: skip $01
        ; The channel 0 vibrato counter.

    ; $0101[0x01] - (Free)
    .Free_0101: skip $01
        ; Free RAM.

    ; $0102[0x01] - (???)
    .Channel1VbrCounter: skip $01
        ; The channel 1 vibrato counter.

    ; $0103[0x01] - (Free)
    .Free_0103: skip $01
        ; Free RAM.

    ; $0104[0x01] - (???)
    .Channel2VbrCounter: skip $01
        ; The channel 2 vibrato counter.

    ; $0105[0x01] - (Free)
    .Free_0105: skip $01
        ; Free RAM.

    ; $0106[0x01] - (???)
    .Channel3VbrCounter: skip $01
        ; The channel 3 vibrato counter.

    ; $0107[0x01] - (Free)
    .Free_0107: skip $01
        ; Free RAM.

    ; $0108[0x01] - (???)
    .Channel4VbrCounter: skip $01
        ; The channel 4 vibrato counter.

    ; $0109[0x01] - (Free)
    .Free_0109: skip $01
        ; Free RAM.

    ; $010A[0x01] - (???)
    .Channel5VbrCounter: skip $01
        ; The channel 5 vibrato counter.

    ; $010B[0x01] - (Free)
    .Free_010B: skip $01
        ; Free RAM.

    ; $010C[0x01] - (???)
    .Channel6VbrCounter: skip $01
        ; The channel 6 vibrato counter.

    ; $010D[0x01] - (Free)
    .Free_010D: skip $01
        ; Free RAM.

    ; $010E[0x01] - (???)
    .Channel7VbrCounter: skip $01
        ; The channel 7 vibrato counter.

    ; $010F[0xC0] - (Free)
    .Free_010F: skip $C0
        ; Free RAM.

    ; ==========================================================================
    ; SPC700 stack
    ; Starts here, for whatever reason
    ; ==========================================================================

    ; $01CF[0x30] - (???)
    .APUSTACK: skip $30

    ; $01FF[0x01] - (???)
    .IPLSTACK: skip $01

    ; ===========================================================================
    ; End of Direct Page 0x01
    ; ===========================================================================

    ; ===========================================================================
    ; Absolute RAM
    ; ===========================================================================

    ; $0200[0x01] - (???)
    .Channel0Duration: skip $01
        ; The channel 0 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0201[0x01] - (???)
    .T0STACC: skip $01
        ; Note release duration
        ; TODO: Document.

    ; $0202[0x01] - (???)
    .Channel1Duration: skip $01
        ; The channel 1 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0203[0x01] - (???)
    .T1STACC: skip $01

    ; $0204[0x01] - (???)
    .Channel2Duration: skip $01
        ; The channel 2 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0205[0x01] - (???)
    .T2STACC: skip $01

    ; $0206[0x01] - (???)
    .Channel3Duration: skip $01
        ; The channel 3 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0207[0x01] - (???)
    .T3STACC: skip $01

    ; $0208[0x01] - (???)
    .Channel4Duration: skip $01
        ; The channel 4 note duration reset value. How long a single note will
        ; play on this channel.

    ; $0209[0x01] - (???)
    .T4STACC: skip $01

    ; $020A[0x01] - (???)
    .Channel5Duration: skip $01
        ; The channel 5 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020B[0x01] - (???)
    .T5STACC: skip $01

    ; $020C[0x01] - (???)
    .Channel6Duration: skip $01
        ; The channel 6 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020D[0x01] - (???)
    .T6STACC: skip $01

    ; $020E[0x01] - (???)
    .Channel7Duration: skip $01
        ; The channel 7 note duration reset value. How long a single note will
        ; play on this channel.

    ; $020F[0x01] - (???)
    .T7STACC: skip $01


    ; $0210[0x01] - (???)
    .Channel0Attack: skip $01
        ; The channel 0 note attack.

    ; $0211[0x01] - (???)
    .Channel0Instrument: skip $01
        ; The channel 0 instrument ID.

    ; $0212[0x01] - (???)
    .Channel1Attack: skip $01
        ; The channel 1 note attack.

    ; $0213[0x01] - (???)
    .Channel1Instrument: skip $01
        ; The channel 1 instrument ID.

    ; $0214[0x01] - (???)
    .Channel2Attack: skip $01
        ; The channel 2 note attack.

    ; $0215[0x01] - (???)
    .Channel2Instrument: skip $01
        ; The channel 2 instrument ID.

    ; $0216[0x01] - (???)
    .Channel3Attack: skip $01
        ; The channel 3 note attack.

    ; $0217[0x01] - (???)
    .Channel3Instrument: skip $01
        ; The channel 3 instrument ID.

    ; $0218[0x01] - (???)
    .Channel4Attack: skip $01
        ; The channel 4 note attack.

    ; $0219[0x01] - (???)
    .Channel4Instrument: skip $01
        ; The channel 4 instrument ID.

    ; $021A[0x01] - (???)
    .Channel5Attack: skip $01
        ; The channel 5 note attack.

    ; $021B[0x01] - (???)
    .Channel5Instrument: skip $01
        ; The channel 5 instrument ID.

    ; $021C[0x01] - (???)
    .Channel6Attack: skip $01
        ; The channel 6 note attack.

    ; $021D[0x01] - (???)
    .Channel6Instrument: skip $01
        ; The channel 6 instrument ID.

    ; $021E[0x01] - (???)
    .Channel7Attack: skip $01
        ; The channel 7 note attack.

    ; $021F[0x01] - (???)
    .Channel7Instrument: skip $01
        ; The channel 7 instrument ID.


    ; $0220[0x02] - (???)
    .Channel0TuneMult: skip $02
        ; The channel 0 instrument high-level tuning multiplier.

    ; $0222[0x02] - (???)
    .Channel1TuneMult: skip $02
        ; The channel 1 instrument high-level tuning multiplier.

    ; $0224[0x02] - (???)
    .Channel2TuneMult: skip $02
        ; The channel 2 instrument high-level tuning multiplier.

    ; $0226[0x02] - (???)
    .Channel3TuneMult: skip $02
        ; The channel 3 instrument high-level tuning multiplier.

    ; $0228[0x02] - (???)
    .Channel4TuneMult: skip $02
        ; The channel 4 instrument high-level tuning multiplier.

    ; $022A[0x02] - (???)
    .Channel5TuneMult: skip $02
        ; The channel 5 instrument high-level tuning multiplier.

    ; $022C[0x02] - (???)
    .Channel6TuneMult: skip $02
        ; The channel 6 instrument high-level tuning multiplier.

    ; $022E[0x02] - (???)
    .Channel7TuneMult: skip $02
        ; The channel 7 instrument high-level tuning multiplier.


    ; $0230[0x02] - (???)
    .Channel0PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 0.

    ; $0232[0x02] - (???)
    .Channel1PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 1.

    ; $0234[0x02] - (???)
    .Channel2PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 2.

    ; $0236[0x02] - (???)
    .Channel3PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 3.

    ; $0238[0x02] - (???)
    .Channel4PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 4.

    ; $023A[0x02] - (???)
    .Channel5PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 5.

    ; $023C[0x02] - (???)
    .Channel6PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 6.

    ; $023E[0x02] - (???)
    .Channel7PartReturn: skip $02
        ; The address to return to after the current part is done looping on
        ; channel 7.


    ; $0240[0x02] - (???)
    .Channel0PartAddr: skip $02
        ; The Subroutine address for part calls for channel 0.

    ; $0242[0x02] - (???)
    .Channel1PartAddr: skip $02
        ; The Subroutine address for part calls for channel 1.

    ; $0244[0x02] - (???)
    .Channel2PartAddr: skip $02
        ; The Subroutine address for part calls for channel 2.

    ; $0246[0x02] - (???)
    .Channel3PartAddr: skip $02
        ; The Subroutine address for part calls for channel 3.

    ; $0248[0x02] - (???)
    .Channel4PartAddr: skip $02
        ; The Subroutine address for part calls for channel 4.

    ; $024A[0x02] - (???)
    .Channel5PartAddr: skip $02
        ; The Subroutine address for part calls for channel 5.

    ; $024C[0x02] - (???)
    .Channel6PartAddr: skip $02
        ; The Subroutine address for part calls for channel 6.

    ; $024E[0x02] - (???)
    .Channel7PartAddr: skip $02
        ; The Subroutine address for part calls for channel 7.

    ; $0250[0x30] - (Free)
    .Free_0250: skip $30
        ; Free RAM.

    ; ==========================================================================

    ; $0280[0x01] - (???)
    .Channel0PitchSlideTimerQ: skip $01
        ; The channel 0 pitch slide timer queue.

    ; $0281[0x01] - (???)
    .Channel0PitchSlideDelayQ: skip $01
        ; The channel 0 pitch slide delay queue.

    ; $0282[0x01] - (???)
    .Channel1PitchSlideTimerQ: skip $01
        ; The channel 1 pitch slide timer queue.

    ; $0283[0x01] - (???)
    .Channel1PitchSlideDelayQ: skip $01
        ; The channel 1 pitch slide delay queue.

    ; $0284[0x01] - (???)
    .Channel2PitchSlideTimerQ: skip $01
        ; The channel 2 pitch slide timer queue.

    ; $0285[0x01] - (???)
    .Channel2PitchSlideDelayQ: skip $01
        ; The channel 2 pitch slide delay queue.

    ; $0286[0x01] - (???)
    .Channel3PitchSlideTimerQ: skip $01
        ; The channel 3 pitch slide timer queue.

    ; $0287[0x01] - (???)
    .Channel3PitchSlideDelayQ: skip $01
        ; The channel 3 pitch slide delay queue.

    ; $0288[0x01] - (???)
    .Channel4PitchSlideTimerQ: skip $01
        ; The channel 4 pitch slide timer queue.

    ; $0289[0x01] - (???)
    .Channel4PitchSlideDelayQ: skip $01
        ; The channel 4 pitch slide delay queue.

    ; $028A[0x01] - (???)
    .Channel5PitchSlideTimerQ: skip $01
        ; The channel 5 pitch slide timer queue.

    ; $028B[0x01] - (???)
    .Channel5PitchSlideDelayQ: skip $01
        ; The channel 5 pitch slide delay queue.

    ; $028C[0x01] - (???)
    .Channel6PitchSlideTimerQ: skip $01
        ; The channel 6 pitch slide timer queue.

    ; $028D[0x01] - (???)
    .Channel6PitchSlideDelayQ: skip $01
        ; The channel 6 pitch slide delay queue.

    ; $028E[0x01] - (???)
    .Channel7PitchSlideTimerQ: skip $01
        ; The channel 7 pitch slide timer queue.

    ; $028F[0x01] - (???)
    .Channel7PitchSlideDelayQ: skip $01
        ; The channel 7 pitch slide delay queue.


    ; $0290[0x01] - (???)
    .Channel0PitchSlideType: skip $01
        ; The channel 0 pitch slide type (0: from | 1: to).

    ; $0291[0x01] - (???)
    .Channel0PitchSlideTarget: skip $01
        ; The channel 0 pitch slide target.

    ; $0292[0x01] - (???)
    .Channel1PitchSlideType: skip $01
        ; The channel 1 pitch slide type (0: from | 1: to).

    ; $0293[0x01] - (???)
    .Channel1PitchSlideTarget: skip $01
        ; The channel 1 pitch slide target.

    ; $0294[0x01] - (???)
    .Channel2PitchSlideType: skip $01
        ; The channel 2 pitch slide type (0: from | 1: to).

    ; $0295[0x01] - (???)
    .Channel2PitchSlideTarget: skip $01
        ; The channel 2 pitch slide target.

    ; $0296[0x01] - (???)
    .Channel3PitchSlideType: skip $01
        ; The channel 3 pitch slide type (0: from | 1: to).

    ; $0297[0x01] - (???)
    .Channel3PitchSlideTarget: skip $01
        ; The channel 3 pitch slide target.

    ; $0298[0x01] - (???)
    .Channel4PitchSlideType: skip $01
        ; The channel 4 pitch slide type (0: from | 1: to).

    ; $0299[0x01] - (???)
    .Channel4PitchSlideTarget: skip $01
        ; The channel 4 pitch slide target.

    ; $029A[0x01] - (???)
    .Channel5PitchSlideType: skip $01
        ; The channel 5 pitch slide type (0: from | 1: to).

    ; $029B[0x01] - (???)
    .Channel5PitchSlideTarget: skip $01
        ; The channel 5 pitch slide target.

    ; $029C[0x01] - (???)
    .Channel6PitchSlideType: skip $01
        ; The channel 6 pitch slide type (0: from | 1: to).

    ; $029D[0x01] - (???)
    .Channel6PitchSlideTarget: skip $01
        ; The channel 6 pitch slide target.

    ; $029E[0x01] - (???)
    .Channel7PitchSlideType: skip $01
        ; The channel 7 pitch slide type (0: from | 1: to).

    ; $029F[0x01] - (???)
    .Channel7PitchSlideTarget: skip $01
        ; The channel 7 pitch slide target.


    ; Vibrato accumulator and rate
    ; $02A0[0x01] - (???)
    .T0VBRC: skip $01

    ; $02A1[0x01] - (???)
    .T0VBRV: skip $01

    ; $02A2[0x01] - (???)
    .T1VBRC: skip $01

    ; $02A3[0x01] - (???)
    .T1VBRV: skip $01

    ; $02A4[0x01] - (???)
    .T2VBRC: skip $01

    ; $02A5[0x01] - (???)
    .T2VBRV: skip $01

    ; $02A6[0x01] - (???)
    .T3VBRC: skip $01

    ; $02A7[0x01] - (???)
    .T3VBRV: skip $01

    ; $02A8[0x01] - (???)
    .T4VBRC: skip $01

    ; $02A9[0x01] - (???)
    .T4VBRV: skip $01

    ; $02AA[0x01] - (???)
    .T5VBRC: skip $01

    ; $02AB[0x01] - (???)
    .T5VBRV: skip $01

    ; $02AC[0x01] - (???)
    .T6VBRC: skip $01

    ; $02AD[0x01] - (???)
    .T6VBRV: skip $01

    ; $02AE[0x01] - (???)
    .T7VBRC: skip $01

    ; $02AF[0x01] - (???)
    .T7VBRV: skip $01


    ; TODO: What is the gradient wait?
    ; Vibrato delay and gradient wait
    ; $02B0[0x01] - (???)
    .T0VBRWT: skip $01

    ; $02B1[0x01] - (???)
    .T0VBRGD: skip $01

    ; $02B2[0x01] - (???)
    .T1VBRWT: skip $01

    ; $02B3[0x01] - (???)
    .T1VBRGD: skip $01

    ; $02B4[0x01] - (???)
    .T2VBRWT: skip $01

    ; $02B5[0x01] - (???)
    .T2VBRGD: skip $01

    ; $02B6[0x01] - (???)
    .T3VBRWT: skip $01

    ; $02B7[0x01] - (???)
    .T3VBRGD: skip $01

    ; $02B8[0x01] - (???)
    .T4VBRWT: skip $01

    ; $02B9[0x01] - (???)
    .T4VBRGD: skip $01

    ; $02BA[0x01] - (???)
    .T5VBRWT: skip $01

    ; $02BB[0x01] - (???)
    .T5VBRGD: skip $01

    ; $02BC[0x01] - (???)
    .T6VBRWT: skip $01

    ; $02BD[0x01] - (???)
    .T6VBRGD: skip $01

    ; $02BE[0x01] - (???)
    .T7VBRWT: skip $01

    ; $02BF[0x01] - (???)
    .T7VBRGD: skip $01


    ; TODO: What is the vibrato step?
    ; Vibrato step and max intensity
    ; $02C0[0x01] - (???)
    .T0VBRST: skip $01

    ; $02C1[0x01] - (???)
    .T0VBRMX: skip $01

    ; $02C2[0x01] - (???)
    .T1VBRST: skip $01

    ; $02C3[0x01] - (???)
    .T1VBRMX: skip $01

    ; $02C4[0x01] - (???)
    .T2VBRST: skip $01

    ; $02C5[0x01] - (???)
    .T2VBRMX: skip $01

    ; $02C6[0x01] - (???)
    .T3VBRST: skip $01

    ; $02C7[0x01] - (???)
    .T3VBRMX: skip $01

    ; $02C8[0x01] - (???)
    .T4VBRST: skip $01

    ; $02C9[0x01] - (???)
    .T4VBRMX: skip $01

    ; $02CA[0x01] - (???)
    .T5VBRST: skip $01

    ; $02CB[0x01] - (???)
    .T5VBRMX: skip $01

    ; $02CC[0x01] - (???)
    .T6VBRST: skip $01

    ; $02CD[0x01] - (???)
    .T6VBRMX: skip $01

    ; $02CE[0x01] - (???)
    .T7VBRST: skip $01

    ; $02CF[0x01] - (???)
    .T7VBRMX: skip $01


    ; Tremolo accumulator and rate
    ; $02D0[0x01] - (???)
    .T0TREMC: skip $01

    ; $02D1[0x01] - (???)
    .T0TREMV: skip $01

    ; $02D2[0x01] - (???)
    .T1TREMC: skip $01

    ; $02D3[0x01] - (???)
    .T1TREMV: skip $01

    ; $02D4[0x01] - (???)
    .T2TREMC: skip $01

    ; $02D5[0x01] - (???)
    .T2TREMV: skip $01

    ; $02D6[0x01] - (???)
    .T3TREMC: skip $01

    ; $02D7[0x01] - (???)
    .T3TREMV: skip $01

    ; $02D8[0x01] - (???)
    .T4TREMC: skip $01

    ; $02D9[0x01] - (???)
    .T4TREMV: skip $01

    ; $02DA[0x01] - (???)
    .T5TREMC: skip $01

    ; $02DB[0x01] - (???)
    .T5TREMV: skip $01

    ; $02DC[0x01] - (???)
    .T6TREMC: skip $01

    ; $02DD[0x01] - (???)
    .T6TREMV: skip $01

    ; $02DE[0x01] - (???)
    .T7TREMC: skip $01

    ; $02DF[0x01] - (???)
    .T7TREMV: skip $01


    ; Tremolo delay and unused variable
    ; $02E0[0x01] - (???)
    .T0TREMD: skip $01

    ; $02E1[0x01] - (???)
    .T0U2E1: skip $01

    ; $02E2[0x01] - (???)
    .T1TREMD: skip $01

    ; $02E3[0x01] - (???)
    .T1U2E1: skip $01

    ; $02E4[0x01] - (???)
    .T2TREMD: skip $01

    ; $02E5[0x01] - (???)
    .T2U2E1: skip $01

    ; $02E6[0x01] - (???)
    .T3TREMD: skip $01

    ; $02E7[0x01] - (???)
    .T3U2E1: skip $01

    ; $02E8[0x01] - (???)
    .T4TREMD: skip $01

    ; $02E9[0x01] - (???)
    .T4U2E1: skip $01

    ; $02EA[0x01] - (???)
    .T5TREMD: skip $01

    ; $02EB[0x01] - (???)
    .T5U2E1: skip $01

    ; $02EC[0x01] - (???)
    .T6TREMD: skip $01

    ; $02ED[0x01] - (???)
    .T6U2E1: skip $01

    ; $02EE[0x01] - (???)
    .T7TREMD: skip $01

    ; $02EF[0x01] - (???)
    .T7U2E1: skip $01


    ; $02F0[0x01] - (???)
    .Channel0Transposition: skip $01
        ; The channel 0 transposition.

    ; $02F1[0x01] - (Free)
    .Free_02F1: skip $01
        ; Free RAM.

    ; $02F2[0x01] - (???)
    .Channel1Transposition: skip $01
        ; The channel 1 transposition.

    ; $02F3[0x01] - (Free)
    .Free_02F3: skip $01
        ; Free RAM.

    ; $02F4[0x01] - (???)
    .Channel2Transposition: skip $01
        ; The channel 2 transposition.

    ; $02F5[0x01] - (Free)
    .Free_02F5: skip $01
        ; Free RAM.

    ; $02F6[0x01] - (???)
    .Channel3Transposition: skip $01
        ; The channel 3 transposition.

    ; $02F7[0x01] - (Free)
    .Free_02F7: skip $01
        ; Free RAM.

    ; $02F8[0x01] - (???)
    .Channel4Transposition: skip $01
        ; The channel 4 transposition.

    ; $02F9[0x01] - (Free)
    .Free_02F9: skip $01
        ; Free RAM.

    ; $02FA[0x01] - (???)
    .Channel5Transposition: skip $01
        ; The channel 5 transposition.

    ; $02FB[0x01] - (Free)
    .Free_02FB: skip $01
        ; Free RAM.

    ; $02FC[0x01] - (???)
    .Channel6Transposition: skip $01
        ; The channel 6 transposition.

    ; $02FD[0x01] - (Free)
    .Free_02FD: skip $01
        ; Free RAM.

    ; $02FE[0x01] - (???)
    .Channel7Transposition: skip $01
        ; The channel 7 transposition.

    ; $02FF[0x01] - (Free)
    .Free_02FF: skip $01
        ; Free RAM.

    ; ==========================================================================

    ; $0300[0x02] - (???)
    .Channel0Vol: skip $02
        ; The volume for channel 0.

    ; $0302[0x02] - (???)
    .Channel1Vol: skip $02
        ; The volume for channel 1.

    ; $0304[0x02] - (???)
    .Channel2Vol: skip $02
        ; The volume for channel 2.

    ; $0306[0x02] - (???)
    .Channel3Vol: skip $02
        ; The volume for channel 3.

    ; $0308[0x02] - (???)
    .Channel4Vol: skip $02
        ; The volume for channel 4.

    ; $030A[0x02] - (???)
    .Channel5Vol: skip $02
        ; The volume for channel 5.

    ; $030C[0x02] - (???)
    .Channel6Vol: skip $02
        ; The volume for channel 6.

    ; $030E[0x02] - (???)
    .Channel7Vol: skip $02
        ; The volume for channel 7.


    ; $0310[0x01] - (???)
    .Channel0VolIncrament: skip $01
        ; The channel 0 volume slide incrament.

    ; $0312[0x01] - (???)
    .Channel1VolIncrament: skip $01
        ; The channel 1 volume slide incrament.

    ; $0314[0x01] - (???)
    .Channel2VolIncrament: skip $01
        ; The channel 2 volume slide incrament.

    ; $0316[0x01] - (???)
    .Channel3VolIncrament: skip $01
        ; The channel 3 volume slide incrament.

    ; $0318[0x01] - (???)
    .Channel4VolIncrament: skip $01
        ; The channel 4 volume slide incrament.

    ; $031A[0x01] - (???)
    .Channel5VolIncrament: skip $01
        ; The channel 5 volume slide incrament.

    ; $031C[0x01] - (???)
    .Channel6VolIncrament: skip $01
        ; The channel 6 volume slide incrament.

    ; $031E[0x01] - (???)
    .Channel7VolIncrament: skip $01
        ; The channel 7 volume slide incrament.


    ; $0320[0x01] - (???)
    .Channel0VolTarget: skip $01
        ; The channel 0 volume slide target.

    ; $0321[0x01] - (???)
    .T0VOLF: skip $01
        ; TODO: finalized volume of channel

    ; $0322[0x01] - (???)
    .Channel1VolTarget: skip $01
        ; The channel 1 volume slide target.

    ; $0323[0x01] - (???)
    .T1VOLF: skip $01

    ; $0324[0x01] - (???)
    .Channel2VolTarget: skip $01
        ; The channel 2 volume slide target.

    ; $0325[0x01] - (???)
    .T2VOLF: skip $01

    ; $0326[0x01] - (???)
    .Channel3VolTarget: skip $01
        ; The channel 3 volume slide target.

    ; $0327[0x01] - (???)
    .T3VOLF: skip $01

    ; $0328[0x01] - (???)
    .Channel4VolTarget: skip $01
        ; The channel 4 volume slide target.

    ; $0329[0x01] - (???)
    .T4VOLF: skip $01

    ; $032A[0x01] - (???)
    .Channel5VolTarget: skip $01
        ; The channel 5 volume slide target.

    ; $032B[0x01] - (???)
    .T5VOLF: skip $01

    ; $032C[0x01] - (???)
    .Channel6VolTarget: skip $01
        ; The channel 6 volume slide target.

    ; $032D[0x01] - (???)
    .T6VOLF: skip $01

    ; $032E[0x01] - (???)
    .Channel7VolTarget: skip $01
        ; The channel 7 volume slide target.

    ; $032F[0x01] - (???)
    .T7VOLF: skip $01


    ; Panning
    ; high byte is TxPANS AND 0x1F
    ; $0330[0x01] - (???)
    .T0PANL: skip $01

    ; $0331[0x01] - (???)
    .T0PAN: skip $01

    ; $0332[0x01] - (???)
    .T1PANL: skip $01

    ; $0333[0x01] - (???)
    .T1PAN: skip $01

    ; $0334[0x01] - (???)
    .T2PANL: skip $01

    ; $0335[0x01] - (???)
    .T2PAN: skip $01

    ; $0336[0x01] - (???)
    .T3PANL: skip $01

    ; $0337[0x01] - (???)
    .T3PAN: skip $01

    ; $0338[0x01] - (???)
    .T4PANL: skip $01

    ; $0339[0x01] - (???)
    .T4PAN: skip $01

    ; $033A[0x01] - (???)
    .T5PANL: skip $01

    ; $033B[0x01] - (???)
    .T5PAN: skip $01

    ; $033C[0x01] - (???)
    .T6PANL: skip $01

    ; $033D[0x01] - (???)
    .T6PAN: skip $01

    ; $033E[0x01] - (???)
    .T7PANL: skip $01

    ; $033F[0x01] - (???)
    .T7PAN: skip $01


    ; $0340[0x02] - (???)
    .Channel0PanSweep: skip $02
        ; The pan sweep value for channel 0.

    ; $0342[0x02] - (???)
    .Channel1PanSweep: skip $02
        ; The pan sweep value for channel 1.

    ; $0344[0x02] - (???)
    .Channel2PanSweep: skip $02
        ; The pan sweep value for channel 2.

    ; $0346[0x02] - (???)
    .Channel3PanSweep: skip $02
        ; The pan sweep value for channel 3.

    ; $0348[0x02] - (???)
    .Channel4PanSweep: skip $02
        ; The pan sweep value for channel 4.

    ; $034A[0x02] - (???)
    .Channel5PanSweep: skip $02
        ; The pan sweep value for channel 5.

    ; $034C[0x02] - (???)
    .Channel6PanSweep: skip $02
        ; The pan sweep value for channel 6.

    ; $034E[0x02] - (???)
    .Channel7PanSweep: skip $02
        ; The pan sweep value for channel 7.


    ; Target pan sweep value and raw settings value
    ; $0350[0x01] - (???)
    .T0PANTG: skip $01

    ; $0351[0x01] - (???)
    .T0PANS: skip $01

    ; $0352[0x01] - (???)
    .T1PANTG: skip $01

    ; $0353[0x01] - (???)
    .T1PANS: skip $01

    ; $0354[0x01] - (???)
    .T2PANTG: skip $01

    ; $0355[0x01] - (???)
    .T2PANS: skip $01

    ; $0356[0x01] - (???)
    .T3PANTG: skip $01

    ; $0357[0x01] - (???)
    .T3PANS: skip $01

    ; $0358[0x01] - (???)
    .T4PANTG: skip $01

    ; $0359[0x01] - (???)
    .T4PANS: skip $01

    ; $035A[0x01] - (???)
    .T5PANTG: skip $01

    ; $035B[0x01] - (???)
    .T5PANS: skip $01

    ; $035C[0x01] - (???)
    .T6PANTG: skip $01

    ; $035D[0x01] - (???)
    .T6PANS: skip $01

    ; $035E[0x01] - (???)
    .T7PANTG: skip $01

    ; $035F[0x01] - (???)
    .T7PANS: skip $01


    ; Pitch calculation
    ; $0360[0x01] - (???)
    .T0PCLCL: skip $01

    ; $0361[0x01] - (???)
    .T0PCLCH: skip $01

    ; $0362[0x01] - (???)
    .T1PCLCL: skip $01

    ; $0363[0x01] - (???)
    .T1PCLCH: skip $01

    ; $0364[0x01] - (???)
    .T2PCLCL: skip $01

    ; $0365[0x01] - (???)
    .T2PCLCH: skip $01

    ; $0366[0x01] - (???)
    .T3PCLCL: skip $01

    ; $0367[0x01] - (???)
    .T3PCLCH: skip $01

    ; $0368[0x01] - (???)
    .T4PCLCL: skip $01

    ; $0369[0x01] - (???)
    .T4PCLCH: skip $01

    ; $036A[0x01] - (???)
    .T5PCLCL: skip $01

    ; $036B[0x01] - (???)
    .T5PCLCH: skip $01

    ; $036C[0x01] - (???)
    .T6PCLCL: skip $01

    ; $036D[0x01] - (???)
    .T6PCLCH: skip $01

    ; $036E[0x01] - (???)
    .T7PCLCL: skip $01

    ; $036F[0x01] - (???)
    .T7PCLCH: skip $01


    ; Multiframe pitch adjustment
    ; $0370[0x01] - (???)
    .T0MPADDL: skip $01

    ; $0371[0x01] - (???)
    .T0MPADDH: skip $01

    ; $0372[0x01] - (???)
    .T1MPADDL: skip $01

    ; $0373[0x01] - (???)
    .T1MPADDH: skip $01

    ; $0374[0x01] - (???)
    .T2MPADDL: skip $01

    ; $0375[0x01] - (???)
    .T2MPADDH: skip $01

    ; $0376[0x01] - (???)
    .T3MPADDL: skip $01

    ; $0377[0x01] - (???)
    .T3MPADDH: skip $01

    ; $0378[0x01] - (???)
    .T4MPADDL: skip $01

    ; $0379[0x01] - (???)
    .T4MPADDH: skip $01

    ; $037A[0x01] - (???)
    .T5MPADDL: skip $01

    ; $037B[0x01] - (???)
    .T5MPADDH: skip $01

    ; $037C[0x01] - (???)
    .T6MPADDL: skip $01

    ; $037D[0x01] - (???)
    .T6MPADDH: skip $01

    ; $037E[0x01] - (???)
    .T7MPADDL: skip $01

    ; $037F[0x01] - (???)
    .T7MPADDH: skip $01


    ; Channel note for calculations and tuning
    ; $0380[0x01] - (???)
    .T0NCALC: skip $01

    ; $0381[0x01] - (???)
    .T0TUNE: skip $01

    ; $0382[0x01] - (???)
    .T1NCALC: skip $01

    ; $0383[0x01] - (???)
    .T1TUNE: skip $01

    ; $0384[0x01] - (???)
    .T2NCALC: skip $01

    ; $0385[0x01] - (???)
    .T2TUNE: skip $01

    ; $0386[0x01] - (???)
    .T3NCALC: skip $01

    ; $0387[0x01] - (???)
    .T3TUNE: skip $01

    ; $0388[0x01] - (???)
    .T4NCALC: skip $01

    ; $0389[0x01] - (???)
    .T4TUNE: skip $01

    ; $038A[0x01] - (???)
    .T5NCALC: skip $01

    ; $038B[0x01] - (???)
    .T5TUNE: skip $01

    ; $038C[0x01] - (???)
    .T6NCALC: skip $01

    ; $038D[0x01] - (???)
    .T6TUNE: skip $01

    ; $038E[0x01] - (???)
    .T7NCALC: skip $01

    ; $038F[0x01] - (???)
    .T7TUNE: skip $01


    ; $0390[0x02] - (???)
    .Channel0SFXPtr: skip $02
        ; The channel 0 SFX pointer.

    ; $0392[0x02] - (???)
    .Channel1SFXPtr: skip $02
        ; The channel 1 SFX pointer.

    ; $0394[0x02] - (???)
    .Channel2SFXPtr: skip $02
        ; The channel 2 SFX pointer.

    ; $0396[0x02] - (???)
    .Channel3SFXPtr: skip $02
        ; The channel 3 SFX pointer.

    ; $0398[0x02] - (???)
    .Channel4SFXPtr: skip $02
        ; The channel 4 SFX pointer.

    ; $039A[0x02] - (???)
    .Channel5SFXPtr: skip $02
        ; The channel 5 SFX pointer.

    ; $039C[0x02] - (???)
    .Channel6SFXPtr: skip $02
        ; The channel 6 SFX pointer.

    ; $039E[0x02] - (???)
    .Channel7SFXPtr: skip $02
        ; The channel 7 SFX pointer.


    ; SFX ID playing on channel and delay
    ; $03A0[0x01] - (???)
    .T0SFXID: skip $01

    ; $03A1[0x01] - (???)
    .T0SFXWT: skip $01

    ; $03A2[0x01] - (???)
    .T1SFXID: skip $01

    ; $03A3[0x01] - (???)
    .T1SFXWT: skip $01

    ; $03A4[0x01] - (???)
    .T2SFXID: skip $01

    ; $03A5[0x01] - (???)
    .T2SFXWT: skip $01

    ; $03A6[0x01] - (???)
    .T3SFXID: skip $01

    ; $03A7[0x01] - (???)
    .T3SFXWT: skip $01

    ; $03A8[0x01] - (???)
    .T4SFXID: skip $01

    ; $03A9[0x01] - (???)
    .T4SFXWT: skip $01

    ; $03AA[0x01] - (???)
    .T5SFXID: skip $01

    ; $03AB[0x01] - (???)
    .T5SFXWT: skip $01

    ; $03AC[0x01] - (???)
    .T6SFXID: skip $01

    ; $03AD[0x01] - (???)
    .T6SFXWT: skip $01

    ; $03AE[0x01] - (???)
    .T7SFXID: skip $01

    ; $03AF[0x01] - (???)
    .T7SFXWT: skip $01


    ; SFX note countdown and duration
    ; $03B0[0x01] - (???)
    .T0SFXTM: skip $01

    ; $03B1[0x01] - (???)
    .T0SFXDUR: skip $01

    ; $03B2[0x01] - (???)
    .T1SFXTM: skip $01

    ; $03B3[0x01] - (???)
    .T1SFXDUR: skip $01

    ; $03B4[0x01] - (???)
    .T2SFXTM: skip $01

    ; $03B5[0x01] - (???)
    .T2SFXDUR: skip $01

    ; $03B6[0x01] - (???)
    .T3SFXTM: skip $01

    ; $03B7[0x01] - (???)
    .T3SFXDUR: skip $01

    ; $03B8[0x01] - (???)
    .T4SFXTM: skip $01

    ; $03B9[0x01] - (???)
    .T4SFXDUR: skip $01

    ; $03BA[0x01] - (???)
    .T5SFXTM: skip $01

    ; $03BB[0x01] - (???)
    .T5SFXDUR: skip $01

    ; $03BC[0x01] - (???)
    .T6SFXTM: skip $01

    ; $03BD[0x01] - (???)
    .T6SFXDUR: skip $01

    ; $03BE[0x01] - (???)
    .T7SFXTM: skip $01

    ; $03BF[0x01] - (???)
    .T7SFXDUR: skip $01

    ; ==========================================================================

    ; $03C0[0x01] - (???)
    .SFXAmbientOffest: skip $01
        ; The SFX or ambient channel index offset. Used to index through SFX
        ; and ambient arrays.

    ; $03C1[0x01] - (???)
    .SFXChannel: skip $01
        ; The channels in use by SFX/Ambient.

    ; $03C2[0x01] - (???)
    .SFXAmbientDSPAddr: skip $01
        ; This contains the DSP address for the current channel in use by SFX
        ; or ambient sounds.

    ; $03C3[0x01] - (???)
    .EONM: skip $01
        ; Music channels flagged for echo enable.


    ; Only referenced in an unused function, but it appears to relate to
    ; SFXOFF and SFXBIT. Junk?
    ; $03C4[0x01] - (???)
    .SFXOFFRT: skip $01

    ; $03C5[0x01] - (???)
    .SFXBITRT: skip $01

    ; $03C6[0x01] - (Free)
    .Free_03C6: skip $01
        ; Free RAM.

    ; $03C7[0x01] - (???)
    .ECHOFLIP: skip $01
        ; Used as a flip flop for toggling incrementing of EchoDelayCache.


    ; Copies AmbientOFF and AmbientBIT, but never used. Junk?
    ; $03C8[0x01] - (???)
    .AmbientOFF2: skip $01

    ; $03C9[0x01] - (???)
    .AmbientBIT2: skip $01


    ; $03CA[0x01] - (???)
    .MusicFade: skip $01
        ; The music fade out timer.
    
    ; $03CB[0x01] - (???)
    .SFX2BIT: skip $01
        ; Channel bits for SFX2, playing and operating

    ; $03CC[0x01] - (???)
    .SFX2FIND: skip $01
        ; TODO: What is this?

    ; $03CD[0x01] - (???)
    .SFX3BIT: skip $01
        ; Channel bits for SFX3, playing and operating

    ; $03CE[0x01] - (???)
    .SFX3FIND: skip $01
        ; TODO: What is this?

    ; $03CF[0x01] - (???)
    .AmbientChannelsInUse: skip $01
        ; The channels in use for Ambient.


    ; SFX channel pan values and unused variable
    ; $03D0[0x01] - (???)
    .T0SFXPAN: skip $01

    ; $03D1[0x01] - (???)
    .T0U3D1: skip $01

    ; $03D2[0x01] - (???)
    .T1SFXPAN: skip $01

    ; $03D3[0x01] - (???)
    .T1U3D1: skip $01

    ; $03D4[0x01] - (???)
    .T2SFXPAN: skip $01

    ; $03D5[0x01] - (???)
    .T2U3D1: skip $01

    ; $03D6[0x01] - (???)
    .T3SFXPAN: skip $01

    ; $03D7[0x01] - (???)
    .T3U3D1: skip $01

    ; $03D8[0x01] - (???)
    .T4SFXPAN: skip $01

    ; $03D9[0x01] - (???)
    .T4U3D1: skip $01

    ; $03DA[0x01] - (???)
    .T5SFXPAN: skip $01

    ; $03DB[0x01] - (???)
    .T5U3D1: skip $01

    ; $03DC[0x01] - (???)
    .T6SFXPAN: skip $01

    ; $03DD[0x01] - (???)
    .T6U3D1: skip $01

    ; $03DE[0x01] - (???)
    .T7SFXPAN: skip $01

    ; $03DF[0x01] - (???)
    .T7U3D1: skip $01


    ; $03E0[0x01] - (???)
    .AmbientFind: skip $01
        ; Used to find Ambient channel.

    ; $03E1[0x01] - (???)
    .MusicVolumeCache: skip $01
        ; Caches song volume between half and max volume commands.

    ; $03E2[0x01] - (???)
    .SFXECHOV: skip $01
        ; Holds value from echo table for SFX

    ; $03E3[0x01] - (???)
    .SFXEchos: skip $01
        ; Bitfield for SFX echos.

    ; $03E4[0x01] - (???)
    .AmbientFade: skip $01
        ; The ambient sound fade timer. If non-0, the ambient sound will fade.

    ; $03E5[0x01] - (???)
    .AmbientFadeVol: skip $01
        ; The ambient sound fade volume. While the ambient fade timer is non-0
        ; this will be divided by 2 until its 0.

    ; $03E6[0x19] - (???)
    .Free_03E6: skip $19
        ; Free RAM.


    ; Appears to mute channels.
    ; $03FF[0x01] - (???)
    .T0STOP: skip $01

    ; $0400[0x01] - (???)
    .T0U400: skip $01

    ; $0401[0x01] - (???)
    .T1STOP: skip $01

    ; $0402[0x01] - (???)
    .T1U400: skip $01

    ; $0403[0x01] - (???)
    .T2STOP: skip $01

    ; $0404[0x01] - (???)
    .T2U400: skip $01

    ; $0405[0x01] - (???)
    .T3STOP: skip $01

    ; $0406[0x01] - (???)
    .T3U400: skip $01

    ; $0407[0x01] - (???)
    .T4STOP: skip $01

    ; $0408[0x01] - (???)
    .T4U400: skip $01

    ; $0409[0x01] - (???)
    .T5STOP: skip $01

    ; $040A[0x01] - (???)
    .T5U400: skip $01

    ; $040B[0x01] - (???)
    .T6STOP: skip $01

    ; $040C[0x01] - (???)
    .T6U400: skip $01

    ; $040D[0x01] - (???)
    .T7STOP: skip $01

    ; $040E[0x01] - (???)
    .T7U400: skip $01

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

    ; $2880-$2A8C SongBlock_1
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

    ; $FFC0-$FFFF Boot ROM
}

; ==============================================================================
