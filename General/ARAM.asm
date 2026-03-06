; ==============================================================================
; Symbols for the audio processing unit
; ==============================================================================

; Shorthand legend:
; Acc = Accumulator
; Addr = Address
; Calc = Calculation
; Chan = Channel
; CMD = Command
; Inc = Increment
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

    ; $00[0x10] - (Main)
    .Work_10: skip $10
        ; Generic work RAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $10[0x01] - (I/O)
    .InputArray:
        ; The song/SFX input value from from the 5A22.

    ; $10[0x01] - (I/O, Song)
    .InputSong: skip $01
        ; The song input value from from the 5A22.

    ; $11[0x01] - (I/O, Ambient)
    .InputAmbient: skip $01
        ; The ambient input value from from the 5A22.

    ; $12[0x01] - (I/O, SFX2)
    .InputSFX2: skip $01
        ; The SFX2 input value from from the 5A22.

    ; $13[0x01] - (I/O, SFX3)
    .InputSFX3: skip $01
        ; The SFX3 input value from from the 5A22.

    ; $14[0x04] - (I/O)
    .CurrentArray:
        ; The currently playing song/SFX sent back to the 5A22 over I/O.

    ; $14[0x01] - (I/O, Song)
    .CurrentSong: skip $01
        ; The currently playing song sent back to the 5A22 over I/O.

    ; $15[0x01] - (I/O, Ambient)
    .CurrentAmbient: skip $01
        ; The currently playing Ambient sent back to the 5A22 over I/O.

    ; $16[0x01] - (I/O, SFX2)
    .CurrentSFX2: skip $01
        ; The currently playing SFX2 sent back to the 5A22 over I/O.

    ; $17[0x01] - (I/O, SFX3)
    .CurrentSFX3: skip $01
        ; The currently playing SFX3 sent back to the 5A22 over I/O.

    ; $18[0x01] - (I/O)
    .LastArray:
        ; The last song/SFX that the APU was told to play.

    ; $18[0x01] - I/O, (Song)
    .LastSong: skip $01
        ; The last song that the APU was told to play.

    ; $19[0x01] - (I/O, Ambient)
    .LastAmbient: skip $01
        ; The last Ambient that the APU was told to play.

    ; $1A[0x01] - (I/O, SFX2)
    .LastSFX2: skip $01
        ; The last SFX2 that the APU was told to play.

    ; $1B[0x01] - (I/O, SFX3)
    .LastSFX3: skip $01
        ; The last SFX3 that the APU was told to play.


    ; $1C[0x01] - (DSP, I/O, Echo)
    .MasterVolLeftQ: skip $01
        ; The DSP.EVOLL (Echo Volume Left) queue.

    ; $1D[0x01] - (DSP, I/O, Echo)
    .MasterVolRightQ: skip $01
        ; The DSP.EVOLR (Echo Volume Right) queue.

    ; $1E[0x02] - (DSP, I/O, Echo)
    .EchoVolLeftQ: skip $02
        ; The DSP.EVOLL (Echo Volume Left) queue.

    ; $20[0x02] - (DSP, I/O, Echo)
    .EchoVolRightQ: skip $02
        ; The DSP.EVOLR (Echo Volume Right) queue.

    ; $22[0x01] - (DSP, I/O)
    .KeyOnQ: skip $01
        ; The DSP.KON (Key on) queue.

    ; $23[0x01] - (DSP, I/O)
    .KeyOnQQ: skip $01
        ; The DSP.KON (Key on) queue queue. TODO: Kinda goofy, maybe rework.

    ; $24[0x01] - (DSP, I/O)
    .KeyOffQ: skip $01
        ; The DSP.KOFF (Key off) queue.

    ; $25[0x01] - (DSP, I/O)
    .FlagQ: skip $01
        ; The DSP.FLG (Flag) queue.

    ; $26[0x01] - (DSP, I/O, Echo)
    .EchoFeedbackQ: skip $01
        ; The DSP.EFB (Echo Feedback) queue.

    ; $27[0x01] - (DSP, I/O, Pitch)
    .PitchModQ: skip $01
        ; The DSP.PMON (Pitch Modulation) queue.

    ; $28[0x01] - (DSP, I/O)
    .NoiseOnQ: skip $01
        ; The DSP.NON (Noise Enable) queue.

    ; $29[0x01] - (DSP, I/O, Echo)
    .EchoOnQ: skip $01
        ; The DSP.EON (Echo Enable) queue.

    ; $2A[0x01] - (DSP, I/O)
    .DirQ: skip $01
        ; The DSP.DIR (Sample Directory) queue.

    ; $2B[0x01] - (DSP, I/O, Echo)
    .EchoSrcAddrQ: skip $01
        ; The DSP.ESA (Echo Source Address) queue.

    ; $2C[0x01] - (DSP, I/O, Echo)
    .EchoDelayQ: skip $01
        ; The DSP.EDL (Echo Delay) queue.

    ; $2D[0x02] - (Main)
    .Zero: skip $02
        ; Always expected to hold the value 0x0000. Used to give YA a value
        ; of 0x0000. Also used to un-key off every channel each loop.


    ; $2F[0x01] - (Channel)
    .ChannelOffset: skip $01
        ; Caches channel offset index when the X register (which usually holds
        ; the channel offset) is required.

    ; $30[0x01] - (Channel)
    .ChanBit: skip $01
        ; This is the current channel offset but represented by an individual 
        ; bit. Only one bit will ever be set at a time.
        ; This is equal to 2^(ChannelOffset or the channel number).
        ; 7654 3210
        ; # - The channel number.

    ; $31[0x01] - (Channel)
    .ChanInUse: skip $01
        ; Each channel that is currently in used represented by a bit.
        ; 7654 3210
        ; # - The channel number.

    ; $32[0x01] - (Song, Channel)
    .ChanInUseSong: skip $01
        ; Each channel that is currently in use by the song, represented by
        ; a bit.
        ; 7654 3210
        ; # - The channel number.

    ; $33[0x01] - (Song, Channel, Volume)
    .ChanUpdateVol: skip $01
        ; Each channel that currently needs to have its volume recalculated,
        ; represented by a bit.
        ; 7654 3210
        ; # - The channel number.

    ; $34[0x01] - (Song, Channel, Pitch)
    .ChanUpdatePitch: skip $01
        ; Each channel that currently needs to have its pitch recalculated,
        ; represented by a bit.
        ; 7654 3210
        ; # - The channel number.

    ; $35[0x02] - (Song, Segment)
    .SegmentPtr: skip $02
        ; The pointer to current song's segments.

    ; $37[0x01] - (Song, Segment)
    .SegmentLoop: skip $01
        ; The number of times to loop the current song segment.

    ; $38[0x02] - (Song, Tempo)
    .SongTempo: skip $02
        ; The song tempo.

    ; $3A[0x02] - (Song, Timer)
    .SongTimer: skip $02
        ; This has the Tempo high byte added to it for every tick that 
        ; passes on timer 0. If the result added is greater than 0xFF, we need
        ; to take new song input from the 5A22 and handle the current song.

    ; $3C[0x01] - (Song)
    .SongDelay: skip $01
        ; Provides a short delay when changing songs.

    ; $3D[0x01] - (Song)
    .SongMute: skip $01
        ; if non zero, the song will be quiet but will still be playing in the
        ; background.

    ; $3E[0x01] - (Song, Transposition)
    .GlobalTransposition: skip $01
        ; The global transposition.

    ; $3F[0x02] - (Song, Volume)
    .GlobalVol: skip $02
        ; The global volume.

    ; $41[0x01] - (Song, Volume, Timer)
    .GlobalVolTimer: skip $01
        ; The global volume slide timer. Must be before the GlobalVolTarget.

    ; $42[0x01] - (Song, Volume)
    .GlobalVolTarget: skip $01
        ; Global volume slide target. Must be after the GlobalVolTimer.

    ; $43[0x02] - (Song, Volume)
    .GlobalVolInc: skip $02
        ; Global volume slide increment.

    ; $45[0x02] - (Song, Tempo)
    .TempoSlideInc: skip $02
        ; The tempo slide increment.

    ; $47[0x01] - (Song, Percussion)
    .PercussionBaseNote: skip $01
        ; The base note that will be added to the percussion commands (0xCA-0xDF)
        ; When playing a percussion note.

    ; $48[0x01] - (Song, Echo)
    .SongEchoEnable: skip $01
        ; Song channels currently using echo enable represented by a bit.
        ; 7654 3210
        ; # - The channel number.

    ; $49[0x01] - (Echo, Timer)
    .EchoTimer: skip $01
        ; A timer to prevent certain things until it reaches the same 
        ; value as $4D (EchoDelayQ).

    ; $4A[0x01] - (Echo, Timer)
    .EchoPanTimer: skip $01
        ; The echo pan timer.

    ; $4B[0x02] - (Echo)
    .EchoPanLeftInc: skip $02
        ; Echo volume left panning Increment.

    ; $4D[0x02] - (Echo)
    .EchoPanRightInc: skip $02
        ; Echo volume right panning Increment.

    ; $4F[0x01] - (Echo)
    .EchoPanLeftTarget: skip $01
        ; The echo pan target Left.

    ; $50[0x01] - (Echo)
    .EchoPanRightTarget: skip $01
        ; The echo pan target Right.

    ; $51[0x01] - (SFX, Timer)
    .SFXTimer: skip $01
        ; This has 0x38 Added to it for every tick that passes on timer 0.
        ; If the result added is greater than 0xFF, we need to take new sfx
        ; input from the 5A22 and handle the current SFX.

    ; $52[0x01] - (Echo)
    .EchoArtificialTimer: skip $01
        ; Used as artificially delay the incrementing of EchoTimer.

    ; $XX[0x01] - (TODO)
    .SINGLETEMP: skip $0D
        ; TODO: Remove.


    ; $XX[0x10] - (Song, Channel, Array)
    .Chan_SongPtr: skip $10
        ; The channel song pointer.

    ; $XX[0x08] - (Channel, Timer, Array)
    .Chan_Timer: skip $01
        ; The countdown for next note or how long the current note has been
        ; playing on each channel. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Timer, Array)
    .Chan_ReleaseTimer: skip $0F
        ; The countdown for release/staccato timing for each channel. Uses
        ; every other value for 8 values.

    ; $XX[0x08] - (Channel, Part, Array)
    .Chan_PartCounter: skip $01
        ; The channel part loop counter. How many times the current part
        ; needs to be looped. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Volume, Timer, Array)
    .Chan_VolTimer: skip $0F
        ; The channel volume slide timer. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Pan, Timer, Array)
    .Chan_PanTimer: skip $01
        ; The channel pan slide timer. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Tremolo, Timer, Array)
    .Chan_TremTimer: skip $0F
        ; The channel tremolo timer. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Vibrato, Timer, Array)
    .Chan_VbrSlideTimer: skip $01
        ; The channel vibrato intensity slide timer. Uses every other value
        ; for 8 values.

    ; $XX[0x08] - (Channel, Pitch, Timer, Array)
    .Chan_PitchSlideWait: skip $0F
        ; The channel pitch slide wait time. Uses every other value for 8 values.

    ; $XX[0x08] - (Channel, Pitch, Timer, Array)
    .Chan_PitchSlideTimer: skip $01
        ; The channel pitch slide timer. Uses every other value for 8 values.

    ; $XX[0x08] - (Song, Tempo, Timer)
    .TempoSlideTimer: skip $0F
        ; The tempo slide duration. Must be before the TempoSlideTarget.

    ; $XX[0x08] - (Song, Tempo)
    .TempoSlideTarget: skip $01
        ; The target tempo slide value. Must be after the TempoSlideTimer.

    ; $XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrTemp: skip $0F
        ; A temporary method of artificially slowing down the vibrato. Uses
        ; every other value for 8 values.
        ; TODO: Remove?

    ; $XX[0x08] - (Channel, Volume, Array)
    .Chan_VolTemp: skip $01
        ; A temporary method of artificially slowing down volume slides. Uses
        ; every other value for 8 values.
        ; TODO: Remove?
        
    ; $XX[0x08] - (Channel, Vibrato, Array)
    .Chan_PitchSlideTemp: skip $0F
        ; A temporary method of artificially slowing down the vibrato. Uses
        ; every other value for 8 values.
        ; TODO: Remove?

    ; $XX[0x08] - (TODO, Array)
    ;.ARRAYTEMP: skip $0F
        ; Uses every other value for 8 values.
        ; TODO: Remove.

    ; $XX[0x01] - (TODO)
    .TEMPCurrentSegment: skip $01
        ; TODO: Remove.

    print "ARAM end of page $00: ", pc

    assert pc() <= $0100

    ; ===========================================================================
    ; End of Direct Page 0x00
    ; ===========================================================================

    ; ===========================================================================
    ; Direct Page 0x01
    ; ===========================================================================

    base $0100

    ; $01XX[0x08] - (Channel, Note, Array)
    .Chan_Duration: skip $01
        ; The channel note duration reset value. How long a single note will
        ; play on each channel. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Note, Array)
    .Chan_Staccato: skip $0F
        ; Note release duration. Uses every other value for 8 values.
        ; Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Note, Array)
    .Chan_Note: skip $01
        ; The channel note. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Tune, Array)
    .Chan_Tuning: skip $0F
        ; The channel fine pitch tuning. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Transposition, Array)
    .Chan_Transposition: skip $01
        ; The channel transposition. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Instrument, Array)
    .Chan_Instrument: skip $0F
        ; The channel instrument ID. Uses every other value for 8 values.

    ; $01XX[0x10] - (Channel, Tune, Array)
    .Chan_TuneMult: skip $10
        ; The channel instrument high-level tuning multiplier.

    ; $01XX[0x10] - (Channel, Pitch, Array)
    .Chan_FinalPitch: skip $10
        ; The calculated channel pitch value. Includes the note, high-level
        ; tuning multiplier, channel transposition, global transposition,
        ; and vibrato.
        ; TODO: Remove? This is currently only used for debugging purposes.

    ; $01XX[0x10] - (Channel, Volume, Array)
    .Chan_Vol: skip $10
        ; The volume for each channel.
    
    ; $01XX[0x08] - (Channel, Volume, Array)
    .Chan_FinalVol: skip $01
        ; The channel finalized volume. This is the volume the channel will
        ; actually use after all tremolo, global, and channel volume
        ; changes are applied. Uses every other value for 8 values.
        ; TODO: Remove? This is currently only used for debugging purposes.

    ; $01XX[0x08] - (Channel, Volume, Array)
    .Chan_VolTarget: skip $0F
        ; The channel volume slide target. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Volume, Array)
    .Chan_Attack: skip $01
        ; The channel note attack. Uses every other value for 8 values.

    ; $01XX[0x08] - (Channel, Volume, Array)
    .Chan_Mute: skip $0F
        ; When non-0, mutes channel 0. This var never actually has a non-0
        ; value written to it and is only set in an unused function.
        ; Uses every other value for 8 values.

    ; $01XX[0x10] - (Channel, Volume, Array)
    .Chan_VolInc: skip $10
        ; The channel volume slide increment.

    ; $01XX[0x10] - (Channel, Part, Array)
    .Chan_PartAddr: skip $10
        ; The Subroutine address for part calls for each channel.

    ; $01XX[0x10] - (Channel, Part, Array)
    .Chan_PartReturn: skip $10
        ; The address to return to after the current part is done looping for
        ; each channel.

    print "ARAM end of page $01: ", pc

    assert pc() <= $01C0

    ; ==========================================================================
    ; SPC700 stack
    ; Starts here, for whatever reason
    ; ==========================================================================

    ; $01CF[0x10] - (Main)
    .APUStack: skip $30
        ; Goes up. so really 0x01C0-0x01CF.

    ; $01FF[0x01] - (Main)
    .IPLStack: skip $01
        ; The stack pointer for the boot ROM.

    assert pc() <= $0200

    ; ===========================================================================
    ; End of Direct Page 0x01
    ; ===========================================================================

    ; ===========================================================================
    ; Absolute Page 0x02
    ; ===========================================================================

    base $0200

    ; $02XX[0x08] - (Channel, Pan, Array)
    .Chan_PanSetting: skip $01
        ; The channel pan settings value. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Pan, Array)
    .Chan_PanTarget: skip $0F
        ; The channel target pan slide. Uses every other value for 8 values.

    ; $02XX[0x10] - (Channel, Pan, Array)
    .Chan_PanValue: skip $10
        ; The channel panning value.

    ; $02XX[0x10] - (Channel, Pan, Array)
    .Chan_PanInc: skip $10
        ; The pan increment value for the channel.

    ; $02XX[0x10] - (Channel, Vibrato, Array)
    .Chan_VbrCalc: skip $10
        ; The calculated channel vibrato to apply to the channel note when
        ; writing the channel pitch.

    ; $02XX[0x08] - (Channel, Vibrato, Timer, Array)
    .Chan_VbrDelay: skip $01
        ; The channel vibrato delay. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrat, Array)
    .Chan_VbrStrength: skip $0F
        ; The channel vibrato strength. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrAcc: skip $01
        ; The channel vibrato accumulator. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrInc: skip $0F
        ; The channel vibrato increment. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrIntensity: skip $01
        ; The channel vibrato intensity. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrMaxIntensity: skip $0F
        ; The channel max vibrato intensity. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Timer, Array)
    .Chan_VbrSlideWait: skip $01
        ; This is the value the channel vibrato intensity slide timer needs to
        ; reach to be complete. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Vibrato, Array)
    .Chan_VbrSlideInc: skip $0F
        ; The channel vibrato intensity slide increment. Uses every other
        ; value for 8 values.

    ; $02XX[0x08] - (Channel, Tremolo, Timer, Array)
    .Chan_TremDelay: skip $01
        ; The channel tremolo delay. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Tremolo, Array)
    .Chan_TremInc: skip $0F
        ; The channel tremolo increment. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Tremolo, Array)
    .Chan_TremIntensity: skip $01
        ; The channel tremolo intensity. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Tremolo, Array)
    .Chan_TremAcc: skip $0F
        ; The channel tremolo accumulator. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Pitch, Array)
    .Chan_PitchSlideType: skip $01
        ; The channel pitch slide type (0: from | 1: to). Uses every other
        ; value for 8 values.

    ; $02XX[0x08] - (Channel, Pitch, Array)
    .Chan_PitchSlideTarget: skip $0F
        ; The channel pitch slide target. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Pitch, Timer, Array)
    .Chan_PitchSlideDuration: skip $01
        ; The channel pitch slide duration. Uses every other value for 8 values.

    ; $02XX[0x08] - (Channel, Pitch, Timer, Array)
    .Chan_PitchSlideDelay: skip $0F
        ; The channel pitch slide delay queue. Uses every other value for 8
        ; values.

    ; $02XX[0x10] - (Channel, Pitch, Array)
    .Chan_PitchSlideCalc: skip $10
        ; The calculated pitch slide pitch adjustment to apply to the channel
        ; note when writing the channel pitch.

    ; $02XX[0x10] - (Channel, Pitch, Array)
    .Chan_PitchSlideInc: skip $10
        ; The channel pitch slide increment.

    print "ARAM end of page $02: ", pc

    assert pc() <= $0300

    ; ===========================================================================
    ; End of Direct Page 0x02
    ; ===========================================================================

    ; ===========================================================================
    ; Absolute Page 0x03
    ; ===========================================================================

    base $0300

    ; $03XX[0x10] - (Temp)
    .TEMPTickRate: skip $10
    
    print "ARAM end of page $03: ", pc

    assert pc() <= $0400

    ; ===========================================================================
    ; End of Absolute Page 0x03
    ; ===========================================================================

}
endstruct

print ""

; ==============================================================================