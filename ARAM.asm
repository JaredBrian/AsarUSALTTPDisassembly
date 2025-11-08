; ==============================================================================
; Symbols for the audio processing unit
; ==============================================================================

; Shorthand legend:
; Accum = Accumulator
; CMD = Command
; Q = Queue
; SFX = Sound Effect
; Trem = Tremolo
; Vbr = Vibrato
; Vol = Volume

struct ARAM $0000
{
    ; ===========================================================================
    ; Page 0x00
    ; ===========================================================================
    
    ; Input values from APU ports.
    ; $0000[0x01] - (???)
    .InputSong: skip $01

    ; $0001[0x01] - (???)
    .InputAmbient: skip $01

    ; $0002[0x01] - (???)
    .InputSFX2: skip $01

    ; $0003[0x01] - (???)
    .InputSFX3: skip $01


    ; $0004[0x01] - (???)
    .CurrentSong: skip $01
        ; The currently playing song sent back to the SNES CPU over I/O.

    ; $0005[0x01] - (???)
    .CurrentAmbient: skip $01
        ; The currently playing Ambient sent back to the SNES CPU over I/O.

    ; $0006[0x01] - (???)
    .CurrentSFX2: skip $01
        ; The currently playing SFX2 sent back to the SNES CPU over I/O.

    ; $0007[0x01] - (???)
    .CurrentSFX3: skip $01
        ; The currently playing SFX3 sent back to the SNES CPU over I/O.


    ; $0008[0x01] - (???)
    .LastSong: skip $01
        ; The last song that the APU was told to play.

    ; $0009[0x01] - (???)
    .LastAmbient: skip $01
        ; The last Ambient that the APU was told to play.

    ; $000A[0x01] - (???)
    .LastSFX2: skip $01
        ; The last SFX2 that the APU was told to play.

    ; $000B[0x01] - (???)
    .LastSFX3: skip $01
        ; The last SFX3 that the APU was told to play.


    ; $000C[0x01] - (???)
    .Delay: skip $01
        ; Provides a short delay when changing songs.

    ; $000D[0x01] - (Free)
    .Free_0D: skip $01
        ; Free RAM.

    ; $000E[0x02] - (???)
    .Zero: skip $02
        ; Always expected to hold the value 0x0000. Used to give YA a value
        ; of 0x0000. Also used to un-key off every channel each loop.

    ; $0010[0x01] - (Main)
    .Work_10: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0011[0x01] - (Main)
    .Work_11: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0012[0x01] - (Main)
    .Work_12: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0013[0x01] - (???)
    .DoPitch: skip $01
        ; Flags pitch changes via commands.
        ; p... ....
        ; p - Run change

    ; $0014[0x01] - (Main)
    .Work_14: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0015[0x01] - (Main)
    .Work_15: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0016[0x01] - (Main)
    .Work_16: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0017[0x01] - (Main)
    .Work_17: skip $01
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $0018[0x01] - (Junk)
    .Junk_18: skip $01
        ; Manipulated every loop, but to seemingly no effect.

    ; $0019[0x01] - (Junk)
    .Junk_19: skip $01
        ; Manipulated every loop, but to seemingly no effect.

    ; $001A[0x01] - (???)
    .SFXChannelUse: skip $01
        ; Flags channels currently in use by sound effects.

    ; $001B[0x01] - (???)
    .Mute: skip $01
        ; Disables all music.

    ; $001C[0x04] - (Free)
    .Free_1C: skip $04
        ; Free RAM.

    ; $0020[0x01] - (???)
    .SFXPan: skip $01
        ; Indicates pan of current SFX. The left takes priority.
        ; lr.. ....
        ; l - pan left
        ; r - pan right

    ; $0021[0x0B] - (Free)
    .Free_21: skip $0B
        ; Free RAM.

    ; $002C[0x02] - (???)
    .SFXPointer: skip $02
        ; The SFX data pointer.

    ; $002E[0x02] - (Free)
    .Free_2E: skip $02
        ; Free RAM.

    ; $0030[0x02] - (???)
    .Track0Pointer: skip $02
        ; The track pointer for channel 0.

    ; $0032[0x02] - (???)
    .Track1Pointer: skip $02
        ; The track pointer for channel 1.

    ; $0034[0x02] - (???)
    .Track2Pointer: skip $02
        ; The track pointer for channel 2.

    ; $0036[0x02] - (???)
    .Track3Pointer: skip $02
        ; The track pointer for channel 3.

    ; $0038[0x02] - (???)
    .Track4Pointer: skip $02
        ; The track pointer for channel 4.

    ; $003A[0x02] - (???)
    .Track5Pointer: skip $02
        ; The track pointer for channel 5.

    ; $003C[0x02] - (???)
    .Track6Pointer: skip $02
        ; The track pointer for channel 6.

    ; $003E[0x02] - (???)
    .Track7Pointer: skip $02
        ; The track pointer for channel 7.

    ; $0040[0x02] - (???)
    .SegmentPointer: skip $02
        ; Pointer to current song's segments.

    ; $0042[0x01] - (???)
    .SegmentLoop: skip $01
        ; Used to build up segment pointers during new songs.

    ; $0043[0x01] - (???)
    .SFXTimer: skip $01
        ; This has 0x38 Added to it for every tick that passes on timer 0.
        ; If the result added is greater than 0xFF, we need to take new sfx
        ; input from the 5A22 and handle the current SFX.

    ; $0044[0x01] - (???)
    .ChannelOffset: skip $01
        ; Saves channel offset index when the X register is required.

    ; $0045[0x01] - (???)
    .KeyOnQ: skip $01
        ; The DSP.KON (Key on) queue.
        ; TODO: What are these queues used for?

    ; $0046[0x01] - (???)
    .KeyOffQ: skip $01
        ; The DSP.KOFF (Key off) queue.

    ; $0047[0x01] - (???)
    .ChannelBit: skip $01
        ; Current channel bit for bitfield writes.

    ; $0048[0x01] - (???)
    .FlagQ: skip $01
        ; The DSP.FLG (Flag) queue.

    ; $0049[0x01] - (???)
    .NoiseQ: skip $01
        ; The DSP.NON (Noise Enable) queue.

    ; $004A[0x01] - (???)
    .EchoQ: skip $01
        ; The DSP.EON (Echo Enable) queue.

    ; $004B[0x01] - (???)
    .PitchModQ: skip $01
        ; The DSP.PMON (Pitch Modulation) queue.

    ; $004C[0x01] - (???)
    .EchoTimer: skip $01
        ; A timer to prevent certain things until it reaches the same 
        ; value as $4D (EchoDelayQ).

    ; $004D[0x01] - (???)
    .EchoDelayQ: skip $01
        ; The DSP.EDL (Echo Delay) queue.

    ; $004E[0x01] - (???)
    .EchoFeedbackQ: skip $01
        ; The DSP.EFB (Echo Feedback) queue.

    ; $004F[0x01] - (Free)
    .Free_4F: skip $01
        ; Free RAM.

    ; $0050[0x01] - (???)
    .GlobalTransposition: skip $01
        ; The global transposition.

    ; $0051[0x01] - (???)
    .SongTimer: skip $01
        ; This has the Tempo high byte ($53) Added to it for every tick that 
        ; passes on timer 0. If the result added is greater than 0xFF, we need
        ; to take new song input from the 5A22 and handle the current song.

    ; $0052[0x02] - (???)
    .Tempo: skip $02
        ; The song tempo.

    ; $0054[0x01] - (???)
    .TempoTimer: skip $01
        ; The tempo sweep duration.

    ; $0055[0x01] - (???)
    .TempoTarget: skip $01
        ; The target tempo for sweep.

    ; $0056[0x01] - (???)
    .TempoSweep: skip $01
        ; The tempo slide sweep amount.

    ; $0058[0x02] - (???)
    .GlobalVol: skip $02
        ; The global volume.

    ; $005A[0x01] - (???)
    .GlobalVolTimer: skip $01
        ; The global volume slide timer.

    ; $005B[0x01] - (???)
    .GlobalVolTarget: skip $01
        ; Global volume slide target.

    ; $005C[0x02] - (???)
    .GlobalVolIncrament: skip $02
        ; Global volume slide increment per loop.

    ; $005E[0x01] - (???)
    .Slide: skip $01
        ; Flags channels for pitch slide.

    ; $005F[0x01] - (???)
    .Drum: skip $01
        ; Base SRCN for percussion commands.

    ; $0060[0x02] - (???)
    .EchoVolLeftQ: skip $02
        ; The EVOLL (Echo Volume Left) queue.

    ; $0062[0x02] - (???)
    .EchoVolRightQ: skip $02
        ; The EVOLR (Echo Volume Right) queue.

    ; $0064[0x02] - (???)
    .EchoPanLeft: skip $02
        ; Echo volume left panning steps.

    ; $0066[0x02] - (???)
    .EchoPanRight: skip $02
        ; Echo volume right panning steps.

    ; $0068[0x01] - (???)
    .EchoPanTimer: skip $01
        ; The echo pan timer.

    ; $0069[0x01] - (???)
    .EchoPanLeftTarget: skip $01
        ; The echo pan target Left.

    ; $006A[0x01] - (???)
    .EchoPanRightTarget: skip $01
        ; The echo pan target Right.

    ; $006B[0x05] - (Free)
    .Free_6B: skip $05
        ; Free RAM.


    ; TODO: Figure out the difference between the 2. The CMDTimer seems to always
    ; be one lower than the duration.
    ; $0070[0x01] - (???)
    .Channel0Duration: skip $01
        ; The countdown for next note playing on channel 0.

    ; $0071[0x01] - (???)
    .Channel0CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 0.

    ; $0072[0x01] - (???)
    .Channel1Duration: skip $01
        ; The countdown for next note playing on channel 1.

    ; $0073[0x01] - (???)
    .Channel1CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 1.

    ; $0074[0x01] - (???)
    .Channel2Duration: skip $01
        ; The countdown for next note playing on channel 2.

    ; $0075[0x01] - (???)
    .Channel2CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 2.

    ; $0076[0x01] - (???)
    .Channel3Duration: skip $01
        ; The countdown for next note playing on channel 3.

    ; $0077[0x01] - (???)
    .Channel3CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 3.

    ; $0078[0x01] - (???)
    .Channel4Duration: skip $01
        ; The countdown for next note playing on channel 4.

    ; $0079[0x01] - (???)
    .Channel4CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 4.

    ; $007A[0x01] - (???)
    .Channel5Duration: skip $01
        ; The countdown for next note playing on channel 5.

    ; $007B[0x01] - (???)
    .Channel5CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 5.

    ; $007C[0x01] - (???)
    .Channel6Duration: skip $01
        ; The countdown for next note playing on channel 6.

    ; $007D[0x01] - (???)
    .Channel6CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 6.

    ; $007E[0x01] - (???)
    .Channel7Duration: skip $01
        ; The countdown for next note playing on channel 7.

    ; $007F[0x01] - (???)
    .Channel7CMDTimer: skip $01
        ; The countdown for continuing sustained commands on channel 7.


    ; $0080[0x02] - (???)
    .Channel0PartCounter: skip $02
        ; The channel 0 part loop counters. The high byte is unused.

    ; $0082[0x02] - (???)
    .Channel1PartCounter: skip $02
        ; The channel 1 part loop counters. The high byte is unused.

    ; $0084[0x02] - (???)
    .Channel2PartCounter: skip $02
        ; The channel 2 part loop counters. The high byte is unused.

    ; $0086[0x02] - (???)
    .Channel3PartCounter: skip $02
        ; The channel 3 part loop counters. The high byte is unused.

    ; $0088[0x02] - (???)
    .Channel4PartCounter: skip $02
        ; The channel 4 part loop counters. The high byte is unused.

    ; $008A[0x02] - (???)
    .Channel5PartCounter: skip $02
        ; The channel 5 part loop counters. The high byte is unused.

    ; $008C[0x02] - (???)
    .Channel6PartCounter: skip $02
        ; The channel 6 part loop counters. The high byte is unused.

    ; $008E[0x02] - (???)
    .Channel7PartCounter: skip $02
        ; The channel 7 part loop counters. The high byte is unused.


    ; $0090[0x01] - (???)
    .Channel0VolTimer: skip $01
        ; The channel 0 volume slide timer.

    ; $0091[0x01] - (???)
    .Channel0PanTimer: skip $01
        ; The channel 0 pan slide timers.

    ; $0092[0x01] - (???)
    .Channel1VolTimer: skip $01
        ; The channel 1 volume slide timer.

    ; $0093[0x01] - (???)
    .Channel1PanTimer: skip $01
        ; The channel 1 pan slide timers.

    ; $0094[0x01] - (???)
    .Channel2VolTimer: skip $01
        ; The channel 2 volume slide timer.

    ; $0095[0x01] - (???)
    .Channel2PanTimer: skip $01
        ; The channel 2 pan slide timers.

    ; $0096[0x01] - (???)
    .Channel3VolTimer: skip $01
        ; The channel 3 volume slide timer.

    ; $0097[0x01] - (???)
    .Channel3PanTimer: skip $01
        ; The channel 3 pan slide timers.

    ; $0098[0x01] - (???)
    .Channel4VolTimer: skip $01
        ; The channel 4 volume slide timer.

    ; $0099[0x01] - (???)
    .Channel4PanTimer: skip $01
        ; The channel 4 pan slide timers.

    ; $009A[0x01] - (???)
    .Channel5VolTimer: skip $01
        ; The channel 5 volume slide timer.

    ; $009B[0x01] - (???)
    .Channel5PanTimer: skip $01
        ; The channel 5 pan slide timers.

    ; $009C[0x01] - (???)
    .Channel6VolTimer: skip $01
        ; The channel 6 volume slide timer.

    ; $009D[0x01] - (???)
    .Channel6PanTimer: skip $01
        ; The channel 6 pan slide timers.

    ; $009E[0x01] - (???)
    .Channel7VolTimer: skip $01
        ; The channel 7 volume slide timer.

    ; $009F[0x01] - (???)
    .Channel7PanTimer: skip $01
        ; The channel 7 pan slide timers.


    ; $00A0[0x01] - (???)
    .Channel0PitchTimer: skip $01
        ; The channel 0 pitch slide timer.

    ; $00A1[0x01] - (???)
    .Channel0PitchDelay: skip $01
        ; The channel 0 pitch slide delay for operation.

    ; $00A2[0x01] - (???)
    .Channel1PitchTimer: skip $01
        ; The channel 1 pitch slide timer.

    ; $00A3[0x01] - (???)
    .Channel1PitchDelay: skip $01
        ; The channel 1 pitch slide delay for operation.

    ; $00A4[0x01] - (???)
    .Channel2PitchTimer: skip $01
        ; The channel 2 pitch slide timer.

    ; $00A5[0x01] - (???)
    .Channel2PitchDelay: skip $01
        ; The channel 2 pitch slide delay for operation.

    ; $00A6[0x01] - (???)
    .Channel3PitchTimer: skip $01
        ; The channel 3 pitch slide timer.

    ; $00A7[0x01] - (???)
    .Channel3PitchDelay: skip $01
        ; The channel 3 pitch slide delay for operation.

    ; $00A8[0x01] - (???)
    .Channel4PitchTimer: skip $01
        ; The channel 4 pitch slide timer.

    ; $00A9[0x01] - (???)
    .Channel4PitchDelay: skip $01
        ; The channel 4 pitch slide delay for operation.

    ; $00AA[0x01] - (???)
    .Channel5PitchTimer: skip $01
        ; The channel 5 pitch slide timer.

    ; $00AB[0x01] - (???)
    .Channel5PitchDelay: skip $01
        ; The channel 5 pitch slide delay for operation.

    ; $00AC[0x01] - (???)
    .Channel6PitchTimer: skip $01
        ; The channel 6 pitch slide timer.

    ; $00AD[0x01] - (???)
    .Channel6PitchDelay: skip $01
        ; The channel 6 pitch slide delay for operation.

    ; $00AE[0x01] - (???)
    .Channel7PitchTimer: skip $01
        ; The channel 7 pitch slide timer.

    ; $00AF[0x01] - (???)
    .Channel7PitchDelay: skip $01
        ; The channel 7 pitch slide delay for operation.


    ; $00B0[0x01] - (???)
    .Channel0VBRStrength: skip $01
        ; The channel 0 vibrato strength.

    ; $00B1[0x01] - (???)
    .Channel0VBRIntensity: skip $01
        ; The channel 0 vibrato max intensity.

    ; $00B2[0x01] - (???)
    .Channel1VBRStrength: skip $01
        ; The channel 1 vibrato strength.

    ; $00B3[0x01] - (???)
    .Channel1VBRIntensity: skip $01
        ; The channel 1 vibrato max intensity.

    ; $00B4[0x01] - (???)
    .Channel2VBRStrength: skip $01
        ; The channel 2 vibrato strength.

    ; $00B5[0x01] - (???)
    .Channel2VBRIntensity: skip $01
        ; The channel 2 vibrato max intensity.

    ; $00B6[0x01] - (???)
    .Channel3VBRStrength: skip $01
        ; The channel 3 vibrato strength.

    ; $00B7[0x01] - (???)
    .Channel3VBRIntensity: skip $01
        ; The channel 3 vibrato max intensity.

    ; $00B8[0x01] - (???)
    .Channel4VBRStrength: skip $01
        ; The channel 4 vibrato strength.

    ; $00B9[0x01] - (???)
    .Channel4VBRIntensity: skip $01
        ; The channel 4 vibrato max intensity.

    ; $00BA[0x01] - (???)
    .Channel5VBRStrength: skip $01
        ; The channel 5 vibrato strength.

    ; $00BB[0x01] - (???)
    .Channel5VBRIntensity: skip $01
        ; The channel 5 vibrato max intensity.

    ; $00BC[0x01] - (???)
    .Channel6VBRStrength: skip $01
        ; The channel 6 vibrato strength.

    ; $00BD[0x01] - (???)
    .Channel6VBRIntensity: skip $01
        ; The channel 6 vibrato max intensity.

    ; $00BE[0x01] - (???)
    .Channel7VBRStrength: skip $01
        ; The channel 7 vibrato strength.

    ; $00BF[0x01] - (???)
    .Channel7VBRIntensity: skip $01
        ; The channel 7 vibrato max intensity.


    ; $00C0[0x01] - (???)
    .Channel0TremTimer: skip $01
        ; The channel 0 tremolo timer.

    ; $00C1[0x01] - (???)
    .Channel0TremIntensity: skip $01
        ; The channel 0 tremolo intensity.

    ; $00C2[0x01] - (???)
    .Channel1TremTimer: skip $01
        ; The channel 1 tremolo timer.

    ; $00C3[0x01] - (???)
    .Channel1TremIntensity: skip $01
        ; The channel 1 tremolo intensity.

    ; $00C4[0x01] - (???)
    .Channel2TremTimer: skip $01
        ; The channel 2 tremolo timer.

    ; $00C5[0x01] - (???)
    .Channel2TremIntensity: skip $01
        ; The channel 2 tremolo intensity.

    ; $00C6[0x01] - (???)
    .Channel3TremTimer: skip $01
        ; The channel 3 tremolo timer.

    ; $00C7[0x01] - (???)
    .Channel3TremIntensity: skip $01
        ; The channel 3 tremolo intensity.

    ; $00C8[0x01] - (???)
    .Channel4TremTimer: skip $01
        ; The channel 4 tremolo timer.

    ; $00C9[0x01] - (???)
    .Channel4TremIntensity: skip $01
        ; The channel 4 tremolo intensity.

    ; $00CA[0x01] - (???)
    .Channel5TremTimer: skip $01
        ; The channel 5 tremolo timer.

    ; $00CB[0x01] - (???)
    .Channel5TremIntensity: skip $01
        ; The channel 5 tremolo intensity.

    ; $00CC[0x01] - (???)
    .Channel6TremTimer: skip $01
        ; The channel 6 tremolo timer.

    ; $00CD[0x01] - (???)
    .Channel6TremIntensity: skip $01
        ; The channel 6 tremolo intensity.

    ; $00CE[0x01] - (???)
    .Channel7TremTimer: skip $01
        ; The channel 7 tremolo timer.

    ; $00CF[0x01] - (???)
    .Channel7TremIntensity: skip $01
        ; The channel 7 tremolo intensity.


    ; $00D0[0x20] - (Free)
    .Free_D0: skip $20
        ; Free RAM.

    ; ==========================================================================
    ; SPC hardware registers at $F0-$FF
    ; See HardwareRegisters.asm
    skip $10
    ; ==========================================================================

    ; Vibrato counter and unused variable
    ; $0100[0x01] - (???)
    .T0VBRCT: skip $01

    ; $0101[0x01] - (???)
    .T0U101: skip $01

    ; $0102[0x01] - (???)
    .T1VBRCT: skip $01

    ; $0103[0x01] - (???)
    .T1U101: skip $01

    ; $0104[0x01] - (???)
    .T2VBRCT: skip $01

    ; $0105[0x01] - (???)
    .T2U101: skip $01

    ; $0106[0x01] - (???)
    .T3VBRCT: skip $01

    ; $0107[0x01] - (???)
    .T3U101: skip $01

    ; $0108[0x01] - (???)
    .T4VBRCT: skip $01

    ; $0109[0x01] - (???)
    .T4U101: skip $01

    ; $010A[0x01] - (???)
    .T5VBRCT: skip $01

    ; $010B[0x01] - (???)
    .T5U101: skip $01

    ; $010C[0x01] - (???)
    .T6VBRCT: skip $01

    ; $010D[0x01] - (???)
    .T6U101: skip $01

    ; $010E[0x01] - (???)
    .T7VBRCT: skip $01

    ; $010F[0xC0] - (???)
    .T7U101: skip $C0


    ; ==========================================================================
    ; SPC700 stack
    ; Starts here, for whatever reason
    ; ==========================================================================

    ; $01CF[0x30] - (???)
    .APUSTACK: skip $30

    ; $01FF[0x01] - (???)
    .IPLSTACK: skip $01

    ; ==========================================================================

    ; Note duration reset value and release duration
    ; $0200[0x01] - (???)
    .T0DUR0: skip $01

    ; $0201[0x01] - (???)
    .T0STACC: skip $01

    ; $0202[0x01] - (???)
    .T1DUR0: skip $01

    ; $0203[0x01] - (???)
    .T1STACC: skip $01

    ; $0204[0x01] - (???)
    .T2DUR0: skip $01

    ; $0205[0x01] - (???)
    .T2STACC: skip $01

    ; $0206[0x01] - (???)
    .T3DUR0: skip $01

    ; $0207[0x01] - (???)
    .T3STACC: skip $01

    ; $0208[0x01] - (???)
    .T4DUR0: skip $01

    ; $0209[0x01] - (???)
    .T4STACC: skip $01

    ; $020A[0x01] - (???)
    .T5DUR0: skip $01

    ; $020B[0x01] - (???)
    .T5STACC: skip $01

    ; $020C[0x01] - (???)
    .T6DUR0: skip $01

    ; $020D[0x01] - (???)
    .T6STACC: skip $01

    ; $020E[0x01] - (???)
    .T7DUR0: skip $01

    ; $020F[0x01] - (???)
    .T7STACC: skip $01


    ; Note attack and instrument ID
    ; $0210[0x01] - (???)
    .T0ATCK: skip $01

    ; $0211[0x01] - (???)
    .T0INSTR: skip $01

    ; $0212[0x01] - (???)
    .T1ATCK: skip $01

    ; $0213[0x01] - (???)
    .T1INSTR: skip $01

    ; $0214[0x01] - (???)
    .T2ATCK: skip $01

    ; $0215[0x01] - (???)
    .T2INSTR: skip $01

    ; $0216[0x01] - (???)
    .T3ATCK: skip $01

    ; $0217[0x01] - (???)
    .T3INSTR: skip $01

    ; $0218[0x01] - (???)
    .T4ATCK: skip $01

    ; $0219[0x01] - (???)
    .T4INSTR: skip $01

    ; $021A[0x01] - (???)
    .T5ATCK: skip $01

    ; $021B[0x01] - (???)
    .T5INSTR: skip $01

    ; $021C[0x01] - (???)
    .T6ATCK: skip $01

    ; $021D[0x01] - (???)
    .T6INSTR: skip $01

    ; $021E[0x01] - (???)
    .T7ATCK: skip $01

    ; $021F[0x01] - (???)
    .T7INSTR: skip $01


    ; Instrument high-level tuning multiplier
    ; $0220[0x01] - (???)
    .T0MULTL: skip $01

    ; $0221[0x01] - (???)
    .T0MULTH: skip $01

    ; $0222[0x01] - (???)
    .T1MULTL: skip $01

    ; $0223[0x01] - (???)
    .T1MULTH: skip $01

    ; $0224[0x01] - (???)
    .T2MULTL: skip $01

    ; $0225[0x01] - (???)
    .T2MULTH: skip $01

    ; $0226[0x01] - (???)
    .T3MULTL: skip $01

    ; $0227[0x01] - (???)
    .T3MULTH: skip $01

    ; $0228[0x01] - (???)
    .T4MULTL: skip $01

    ; $0229[0x01] - (???)
    .T4MULTH: skip $01

    ; $022A[0x01] - (???)
    .T5MULTL: skip $01

    ; $022B[0x01] - (???)
    .T5MULTH: skip $01

    ; $022C[0x01] - (???)
    .T6MULTL: skip $01

    ; $022D[0x01] - (???)
    .T6MULTH: skip $01

    ; $022E[0x01] - (???)
    .T7MULTL: skip $01

    ; $022F[0x01] - (???)
    .T7MULTH: skip $01


    ; Return address for part calling
    ; $0230[0x01] - (???)
    .T0PRETL: skip $01

    ; $0231[0x01] - (???)
    .T0PRETH: skip $01

    ; $0232[0x01] - (???)
    .T1PRETL: skip $01

    ; $0233[0x01] - (???)
    .T1PRETH: skip $01

    ; $0234[0x01] - (???)
    .T2PRETL: skip $01

    ; $0235[0x01] - (???)
    .T2PRETH: skip $01

    ; $0236[0x01] - (???)
    .T3PRETL: skip $01

    ; $0237[0x01] - (???)
    .T3PRETH: skip $01

    ; $0238[0x01] - (???)
    .T4PRETL: skip $01

    ; $0239[0x01] - (???)
    .T4PRETH: skip $01

    ; $023A[0x01] - (???)
    .T5PRETL: skip $01

    ; $023B[0x01] - (???)
    .T5PRETH: skip $01

    ; $023C[0x01] - (???)
    .T6PRETL: skip $01

    ; $023D[0x01] - (???)
    .T6PRETH: skip $01

    ; $023E[0x01] - (???)
    .T7PRETL: skip $01

    ; $023F[0x01] - (???)
    .T7PRETH: skip $01


    ; Subroutine address for part calls
    ; $0240[0x01] - (???)
    .T0PADDL: skip $01

    ; $0241[0x01] - (???)
    .T0PADDH: skip $01

    ; $0242[0x01] - (???)
    .T1PADDL: skip $01

    ; $0243[0x01] - (???)
    .T1PADDH: skip $01

    ; $0244[0x01] - (???)
    .T2PADDL: skip $01

    ; $0245[0x01] - (???)
    .T2PADDH: skip $01

    ; $0246[0x01] - (???)
    .T3PADDL: skip $01

    ; $0247[0x01] - (???)
    .T3PADDH: skip $01

    ; $0248[0x01] - (???)
    .T4PADDL: skip $01

    ; $0249[0x01] - (???)
    .T4PADDH: skip $01

    ; $024A[0x01] - (???)
    .T5PADDL: skip $01

    ; $024B[0x01] - (???)
    .T5PADDH: skip $01

    ; $024C[0x01] - (???)
    .T6PADDL: skip $01

    ; $024D[0x01] - (???)
    .T6PADDH: skip $01

    ; $024E[0x01] - (???)
    .T7PADDL: skip $01

    ; $024F[0x01] - (???)
    .T7PADDH: skip $01


    ; $0250[0x30] - (Free)
    .Free_0250: skip $30
        ; Free RAM.

    ; ==========================================================================

    ; Channel pitch slide timer and delay, before written to GLSTM and GLSWT
    ; $0280[0x01] - (???)
    .T0SLDTM: skip $01

    ; $0281[0x01] - (???)
    .T0SLDWT: skip $01

    ; $0282[0x01] - (???)
    .T1SLDTM: skip $01

    ; $0283[0x01] - (???)
    .T1SLDWT: skip $01

    ; $0284[0x01] - (???)
    .T2SLDTM: skip $01

    ; $0285[0x01] - (???)
    .T2SLDWT: skip $01

    ; $0286[0x01] - (???)
    .T3SLDTM: skip $01

    ; $0287[0x01] - (???)
    .T3SLDWT: skip $01

    ; $0288[0x01] - (???)
    .T4SLDTM: skip $01

    ; $0289[0x01] - (???)
    .T4SLDWT: skip $01

    ; $028A[0x01] - (???)
    .T5SLDTM: skip $01

    ; $028B[0x01] - (???)
    .T5SLDWT: skip $01

    ; $028C[0x01] - (???)
    .T6SLDTM: skip $01

    ; $028D[0x01] - (???)
    .T6SLDWT: skip $01

    ; $028E[0x01] - (???)
    .T7SLDTM: skip $01

    ; $028F[0x01] - (???)
    .T7SLDWT: skip $01


    ; SLDTP - slide type (0: from | 1: to)
    ; SLDTG - slide target
    ; $0290[0x01] - (???)
    .T0SLDTP: skip $01

    ; $0291[0x01] - (???)
    .T0SLDTG: skip $01

    ; $0292[0x01] - (???)
    .T1SLDTP: skip $01

    ; $0293[0x01] - (???)
    .T1SLDTG: skip $01

    ; $0294[0x01] - (???)
    .T2SLDTP: skip $01

    ; $0295[0x01] - (???)
    .T2SLDTG: skip $01

    ; $0296[0x01] - (???)
    .T3SLDTP: skip $01

    ; $0297[0x01] - (???)
    .T3SLDTG: skip $01

    ; $0298[0x01] - (???)
    .T4SLDTP: skip $01

    ; $0299[0x01] - (???)
    .T4SLDTG: skip $01

    ; $029A[0x01] - (???)
    .T5SLDTP: skip $01

    ; $029B[0x01] - (???)
    .T5SLDTG: skip $01

    ; $029C[0x01] - (???)
    .T6SLDTP: skip $01

    ; $029D[0x01] - (???)
    .T6SLDTG: skip $01

    ; $029E[0x01] - (???)
    .T7SLDTP: skip $01

    ; $029F[0x01] - (???)
    .T7SLDTG: skip $01


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


    ; Channel transposition and unused variable
    ; $02F0[0x01] - (???)
    .T0TRAN: skip $01

    ; $02F1[0x01] - (???)
    .T0U2F1: skip $01

    ; $02F2[0x01] - (???)
    .T1TRAN: skip $01

    ; $02F3[0x01] - (???)
    .T1U2F1: skip $01

    ; $02F4[0x01] - (???)
    .T2TRAN: skip $01

    ; $02F5[0x01] - (???)
    .T2U2F1: skip $01

    ; $02F6[0x01] - (???)
    .T3TRAN: skip $01

    ; $02F7[0x01] - (???)
    .T3U2F1: skip $01

    ; $02F8[0x01] - (???)
    .T4TRAN: skip $01

    ; $02F9[0x01] - (???)
    .T4U2F1: skip $01

    ; $02FA[0x01] - (???)
    .T5TRAN: skip $01

    ; $02FB[0x01] - (???)
    .T5U2F1: skip $01

    ; $02FC[0x01] - (???)
    .T6TRAN: skip $01

    ; $02FD[0x01] - (???)
    .T6U2F1: skip $01

    ; $02FE[0x01] - (???)
    .T7TRAN: skip $01

    ; $02FF[0x01] - (???)
    .T7U2F1: skip $01

    ; ==========================================================================

    ; Channel volume
    ; $0300[0x01] - (???)
    .T0VOLL: skip $01

    ; $0301[0x01] - (???)
    .T0VOLH: skip $01

    ; $0302[0x01] - (???)
    .T1VOLL: skip $01

    ; $0303[0x01] - (???)
    .T1VOLH: skip $01

    ; $0304[0x01] - (???)
    .T2VOLL: skip $01

    ; $0305[0x01] - (???)
    .T2VOLH: skip $01

    ; $0306[0x01] - (???)
    .T3VOLL: skip $01

    ; $0307[0x01] - (???)
    .T3VOLH: skip $01

    ; $0308[0x01] - (???)
    .T4VOLL: skip $01

    ; $0309[0x01] - (???)
    .T4VOLH: skip $01

    ; $030A[0x01] - (???)
    .T5VOLL: skip $01

    ; $030B[0x01] - (???)
    .T5VOLH: skip $01

    ; $030C[0x01] - (???)
    .T6VOLL: skip $01

    ; $030D[0x01] - (???)
    .T6VOLH: skip $01

    ; $030E[0x01] - (???)
    .T7VOLL: skip $01

    ; $030F[0x01] - (???)
    .T7VOLH: skip $01


    ; Volume sweep amount
    ; $0310[0x01] - (???)
    .T0VOLVL: skip $01

    ; $0311[0x01] - (???)
    .T0VOLVH: skip $01

    ; $0312[0x01] - (???)
    .T1VOLVL: skip $01

    ; $0313[0x01] - (???)
    .T1VOLVH: skip $01

    ; $0314[0x01] - (???)
    .T2VOLVL: skip $01

    ; $0315[0x01] - (???)
    .T2VOLVH: skip $01

    ; $0316[0x01] - (???)
    .T3VOLVL: skip $01

    ; $0317[0x01] - (???)
    .T3VOLVH: skip $01

    ; $0318[0x01] - (???)
    .T4VOLVL: skip $01

    ; $0319[0x01] - (???)
    .T4VOLVH: skip $01

    ; $031A[0x01] - (???)
    .T5VOLVL: skip $01

    ; $031B[0x01] - (???)
    .T5VOLVH: skip $01

    ; $031C[0x01] - (???)
    .T6VOLVL: skip $01

    ; $031D[0x01] - (???)
    .T6VOLVH: skip $01

    ; $031E[0x01] - (???)
    .T7VOLVL: skip $01

    ; $031F[0x01] - (???)
    .T7VOLVH: skip $01


    ; Target volume for sweeps and finalized volume of channel
    ; $0320[0x01] - (???)
    .T0VOLTG: skip $01

    ; $0321[0x01] - (???)
    .T0VOLF: skip $01

    ; $0322[0x01] - (???)
    .T1VOLTG: skip $01

    ; $0323[0x01] - (???)
    .T1VOLF: skip $01

    ; $0324[0x01] - (???)
    .T2VOLTG: skip $01

    ; $0325[0x01] - (???)
    .T2VOLF: skip $01

    ; $0326[0x01] - (???)
    .T3VOLTG: skip $01

    ; $0327[0x01] - (???)
    .T3VOLF: skip $01

    ; $0328[0x01] - (???)
    .T4VOLTG: skip $01

    ; $0329[0x01] - (???)
    .T4VOLF: skip $01

    ; $032A[0x01] - (???)
    .T5VOLTG: skip $01

    ; $032B[0x01] - (???)
    .T5VOLF: skip $01

    ; $032C[0x01] - (???)
    .T6VOLTG: skip $01

    ; $032D[0x01] - (???)
    .T6VOLF: skip $01

    ; $032E[0x01] - (???)
    .T7VOLTG: skip $01

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


    ; Pan sweep values
    ; $0340[0x01] - (???)
    .T0PANVL: skip $01

    ; $0341[0x01] - (???)
    .T0PANVH: skip $01

    ; $0342[0x01] - (???)
    .T1PANVL: skip $01

    ; $0343[0x01] - (???)
    .T1PANVH: skip $01

    ; $0344[0x01] - (???)
    .T2PANVL: skip $01

    ; $0345[0x01] - (???)
    .T2PANVH: skip $01

    ; $0346[0x01] - (???)
    .T3PANVL: skip $01

    ; $0347[0x01] - (???)
    .T3PANVH: skip $01

    ; $0348[0x01] - (???)
    .T4PANVL: skip $01

    ; $0349[0x01] - (???)
    .T4PANVH: skip $01

    ; $034A[0x01] - (???)
    .T5PANVL: skip $01

    ; $034B[0x01] - (???)
    .T5PANVH: skip $01

    ; $034C[0x01] - (???)
    .T6PANVL: skip $01

    ; $034D[0x01] - (???)
    .T6PANVH: skip $01

    ; $034E[0x01] - (???)
    .T7PANVL: skip $01

    ; $034F[0x01] - (???)
    .T7PANVH: skip $01


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


    ; Channel pointers for SFX
    ; $0390[0x01] - (???)
    .T0SFXPTL: skip $01

    ; $0391[0x01] - (???)
    .T0SFXPTH: skip $01

    ; $0392[0x01] - (???)
    .T1SFXPTL: skip $01

    ; $0393[0x01] - (???)
    .T1SFXPTH: skip $01

    ; $0394[0x01] - (???)
    .T2SFXPTL: skip $01

    ; $0395[0x01] - (???)
    .T2SFXPTH: skip $01

    ; $0396[0x01] - (???)
    .T3SFXPTL: skip $01

    ; $0397[0x01] - (???)
    .T3SFXPTH: skip $01

    ; $0398[0x01] - (???)
    .T4SFXPTL: skip $01

    ; $0399[0x01] - (???)
    .T4SFXPTH: skip $01

    ; $039A[0x01] - (???)
    .T5SFXPTL: skip $01

    ; $039B[0x01] - (???)
    .T5SFXPTH: skip $01

    ; $039C[0x01] - (???)
    .T6SFXPTL: skip $01

    ; $039D[0x01] - (???)
    .T6SFXPTH: skip $01

    ; $039E[0x01] - (???)
    .T7SFXPTL: skip $01

    ; $039F[0x01] - (???)
    .T7SFXPTH: skip $01


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
    .SFXOFF: skip $01
        ; SFX channel pointer in use.

    ; $03C1[0x01] - (???)
    .SFXBIT: skip $01
        ; SFX channel bit for bitfields.

    ; $03C2[0x01] - (???)
    .BITASL3: skip $01
        ; Contains channel<<3 for easier calculation.

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


    ; Copies SFXOFF and SFXBIT, but never used. Junk?
    ; $03C8[0x01] - (???)
    .SFXOFF2: skip $01

    ; $03C9[0x01] - (???)
    .SFXBIT2: skip $01


    ; $03CA[0x01] - (???)
    .SONGFADE: skip $01
        ; Music fade out timer


    ; Channel bits for SFX2, playing and operating
    ; $03CB[0x01] - (???)
    .SFX2BIT: skip $01

    ; $03CC[0x01] - (???)
    .SFX2FIND: skip $01


    ; Channel bits for SFX3, playing and operating
    ; $03CD[0x01] - (???)
    .SFX3BIT: skip $01

    ; $03CE[0x01] - (???)
    .SFX3FIND: skip $01


    ; $03CF[0x01] - (???)
    .AmbientBIT: skip $01
        ; Channel bits for Ambient


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
    .AmbientFIND: skip $01
        ; Used to find Ambient channel

    ; $03E1[0x01] - (???)
    .SONGOVOL: skip $01
        ; Caches song volume between half and max volume commsnds

    ; $03E2[0x01] - (???)
    .SFXECHOV: skip $01
        ; Holds value from echo table for SFX

    ; $03E3[0x01] - (???)
    .SFXECHOS: skip $01
        ; Bitfield for SFX echos

    ; $03E4[0x01] - (???)
    .AmbientFADE: skip $01
        ; Ambient fade timer.

    ; $03E5[0x01] - (???)
    .AmbientFDVOL: skip $01
        ; Ambient volume.

    ; $03E6[0x19] - (???)
    .Free_03E6: skip $19
        ; Free RAM.


    ; Appears to mute channels via an unreachable command
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
