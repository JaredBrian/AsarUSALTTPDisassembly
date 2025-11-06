; ==============================================================================
; Symbols for the audio processing unit
; ==============================================================================

struct ARAM $0000
{
    ; ===========================================================================
    ; Page 0x00
    ; ===========================================================================
    
    ; Input values from APU ports.
    ; $0000[0x01] - (???)
    .InputSong: skip $01

    ; $0001[0x01] - (???)
    .InputSFX1: skip $01

    ; $0002[0x01] - (???)
    .InputSFX2: skip $01

    ; $0003[0x01] - (???)
    .InputSFX3: skip $01


    ; $0004[0x01] - (???)
    .CurretnSong: skip $01
        ; The currently playing song sent back to the SNES CPU over I/O.

    ; $0005[0x01] - (???)
    .CurretSFX1: skip $01
        ; The currently playing SFX1 sent back to the SNES CPU over I/O.

    ; $0006[0x01] - (???)
    .CurretSFX2: skip $01
        ; The currently playing SFX2 sent back to the SNES CPU over I/O.

    ; $0007[0x01] - (???)
    .CurretSFX3: skip $01
        ; The currently playing SFX3 sent back to the SNES CPU over I/O.


    ; Redundancy check for sound handling.
    ; $0008[0x01] - (???)
    .RedundancySONG: skip $01

    ; $0009[0x01] - (???)
    .RedundancySFX1: skip $01

    ; $000A[0x01] - (???)
    .RedundancySFX2: skip $01

    ; $000B[0x01] - (???)
    .RedundancySFX3: skip $01


    ; $000C[0x01] - (???)
    .DELAY: skip $01
        ; Provides a short delay when changing songs

    ; $000D[0x01] - (Free)
    .Free_0D: skip $01
        ; Free RAM.


    ; $000E[0x02] - (???)
    .ZERO: skip $02
        ; Always expected to hold the value 0x0000
        ; Used to give YA a value of 0x0000
        ; Also used to un-key off every channel each loop

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
    .DOPCH: skip $01
        ; Flags pitch changes via commands
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
        ; Manipulated every loop, but to seemingly no effect

    ; $0019[0x01] - (Junk)
    .Junk_19: skip $01
        ; Manipulated every loop, but to seemingly no effect

    ; $001A[0x01] - (???)
    .SFXUSE: skip $01
        ; Flags channels currently in use by sound effects

    ; $001B[0x01] - (???)
    .MUTED: skip $01
        ; Disables all music

    ; $001C[0x04] - (Free)
    .Free_1C: skip $04
        ; Free RAM.

    ; $0020[0x01] - (???)
    .SFXPAN: skip $01
        ; Indicates pan of current SFX
        ; lr.. ....
        ;   l - pan left
        ;   r - pan right
        ; left takes priority

    ; $0021[0x0B] - (Free)
    .Free_21: skip $0B
        ; Free RAM.

    ; $002C[0x02] - (???)
    .SFXPTR: skip $02
        ; SFX data pointer

    ; $002E[0x02] - (Free)
    .Free_2E: skip $02
        ; Free RAM.


    ; Track pointers for each channel
    ; $0030[0x01] - (???)
    .T0PTR: skip $01

    ; $0031[0x01] - (???)
    .T0PTRH: skip $01

    ; $0032[0x01] - (???)
    .T1PTR: skip $01

    ; $0033[0x01] - (???)
    .T1PTRH: skip $01

    ; $0034[0x01] - (???)
    .T2PTR: skip $01

    ; $0035[0x01] - (???)
    .T2PTRH: skip $01

    ; $0036[0x01] - (???)
    .T3PTR: skip $01

    ; $0037[0x01] - (???)
    .T3PTRH: skip $01

    ; $0038[0x01] - (???)
    .T4PTR: skip $01

    ; $0039[0x01] - (???)
    .T4PTRH: skip $01

    ; $003A[0x01] - (???)
    .T5PTR: skip $01

    ; $003B[0x01] - (???)
    .T5PTRH: skip $01

    ; $003C[0x01] - (???)
    .T6PTR: skip $01

    ; $003D[0x01] - (???)
    .T6PTRH: skip $01

    ; $003E[0x01] - (???)
    .T7PTR: skip $01

    ; $003F[0x01] - (???)
    .T7PTRH: skip $01


    ; $0040[0x02] - (???)
    .SEGPTR: skip $02
        ; Pointer to current song's segments

    ; $0042[0x01] - (???)
    .SEGLOOP: skip $01
        ; Used to build up segment pointers during new songs

    ; $0043[0x01] - (???)
    .TACCUM: skip $01
        ; Accumulates timer 0 loops to keep steady timing

    ; $0044[0x01] - (???)
    .CHOFF: skip $01
        ; Saves channel offset index when the X register is required


    ; Key on/off queues
    ; $0045[0x01] - (???)
    .KONQ: skip $01

    ; $0046[0x01] - (???)
    .KOFQ: skip $01


    ; $0047[0x01] - (???)
    .CBIT: skip $01
        ; Current channel bit for bitfield writes


    ; More DSP queues
    ; $0048[0x01] - (???)
    .FLGQ: skip $01

    ; $0049[0x01] - (???)
    .NONQ: skip $01

    ; $004A[0x01] - (???)
    .EONQ: skip $01

    ; $004B[0x01] - (???)
    .PMONQ: skip $01


    ; Echo register cache and queues
    ; $004C[0x01] - (???)
    .EDLC: skip $01

    ; $004D[0x01] - (???)
    .EDLQ: skip $01

    ; $004E[0x01] - (???)
    .EFBQ: skip $01


    ; $004F[0x01] - (Free)
    .Free_4F: skip $01
        ; Free RAM.

    ; $0050[0x01] - (???)
    .GTRANS: skip $01
        ; Global transposition

    ; $0051[0x01] - (???)
    .MACCUM: skip $01
        ; Accumulator for clock passes


    ; Song tempo
    ; $0052[0x01] - (???)
    .TEMPOL: skip $01

    ; $0053[0x01] - (???)
    .TEMPO: skip $01


    ; $0054[0x01] - (???)
    .TEMPOTM: skip $01
        ; Tempo sweep duration

    ; $0055[0x01] - (???)
    .TEMPOTG: skip $01
        ; Target tempo for sweep


    ; Tempo slide sweep amount
    ; $0056[0x01] - (???)
    .TEMPOVL: skip $01

    ; $0057[0x01] - (???)
    .TEMPOVH: skip $01


    ; Global volume
    ; $0058[0x01] - (???)
    .GVOLL: skip $01

    ; $0059[0x01] - (???)
    .GVOL: skip $01


    ; $005A[0x01] - (???)
    .GVOLTM: skip $01
        ; Global volume slide timer

    ; $005B[0x01] - (???)
    .GVOLTG: skip $01
        ; Global volume slide target


    ; Global volume slide increment per loop
    ; $005C[0x01] - (???)
    .GVOLIL: skip $01

    ; $005D[0x01] - (???)
    .GVOLIH: skip $01


    ; $005E[0x01] - (???)
    .SLIDE: skip $01
        ; Flags channels for pitch slide

    ; $005F[0x01] - (???)
    .DRUM0: skip $01
        ; Base SRCN for percussion commands


    ; Echo volume queues
    ; $0060[0x01] - (???)
    .EVOLLQL: skip $01

    ; $0061[0x01] - (???)
    .EVOLLQH: skip $01

    ; $0062[0x01] - (???)
    .EVOLRQL: skip $01

    ; $0063[0x01] - (???)
    .EVOLRQH: skip $01


    ; Echo volume panning steps
    ; $0064[0x01] - (???)
    .EPANLL: skip $01

    ; $0065[0x01] - (???)
    .EPANLH: skip $01

    ; $0066[0x01] - (???)
    .EPANRL: skip $01

    ; $0067[0x01] - (???)
    .EPANRH: skip $01


    ; $0068[0x01] - (???)
    .EPANTM: skip $01
        ; Echo pan timer


    ; Echo pan target values
    ; $0069[0x01] - (???)
    .EPANLTG: skip $01

    ; $006A[0x01] - (???)
    .EPANRTG: skip $01


    ; $006B[0x05] - (Free)
    .Free_6B: skip $05
        ; Free RAM.


    ; Countdown for next note playing and for continuing sustained commands
    ; $0070[0x01] - (???)
    .T0DUR: skip $01

    ; $0071[0x01] - (???)
    .T0CMDTM: skip $01

    ; $0072[0x01] - (???)
    .T1DUR: skip $01

    ; $0073[0x01] - (???)
    .T1CMDTM: skip $01

    ; $0074[0x01] - (???)
    .T2DUR: skip $01

    ; $0075[0x01] - (???)
    .T2CMDTM: skip $01

    ; $0076[0x01] - (???)
    .T3DUR: skip $01

    ; $0077[0x01] - (???)
    .T3CMDTM: skip $01

    ; $0078[0x01] - (???)
    .T4DUR: skip $01

    ; $0079[0x01] - (???)
    .T4CMDTM: skip $01

    ; $007A[0x01] - (???)
    .T5DUR: skip $01

    ; $007B[0x01] - (???)
    .T5CMDTM: skip $01

    ; $007C[0x01] - (???)
    .T6DUR: skip $01

    ; $007D[0x01] - (???)
    .T6CMDTM: skip $01

    ; $007E[0x01] - (???)
    .T7DUR: skip $01

    ; $007F[0x01] - (???)
    .T7CMDTM: skip $01


    ; Channel part loop counters
    ; High byte unused
    ; $0080[0x01] - (???)
    .T0PARTX: skip $01

    ; $0081[0x01] - (???)
    .T0U80: skip $01

    ; $0082[0x01] - (???)
    .T1PARTX: skip $01

    ; $0083[0x01] - (???)
    .T1U80: skip $01

    ; $0084[0x01] - (???)
    .T2PARTX: skip $01

    ; $0085[0x01] - (???)
    .T2U80: skip $01

    ; $0086[0x01] - (???)
    .T3PARTX: skip $01

    ; $0087[0x01] - (???)
    .T3U80: skip $01

    ; $0088[0x01] - (???)
    .T4PARTX: skip $01

    ; $0089[0x01] - (???)
    .T4U80: skip $01

    ; $008A[0x01] - (???)
    .T5PARTX: skip $01

    ; $008B[0x01] - (???)
    .T5U80: skip $01

    ; $008C[0x01] - (???)
    .T6PARTX: skip $01

    ; $008D[0x01] - (???)
    .T6U80: skip $01

    ; $008E[0x01] - (???)
    .T7PARTX: skip $01

    ; $008F[0x01] - (???)
    .T7U80: skip $01


    ; Channel volume slide and pan slide timers
    ; $0090[0x01] - (???)
    .T0VOLTM: skip $01

    ; $0091[0x01] - (???)
    .T0PANTM: skip $01

    ; $0092[0x01] - (???)
    .T1VOLTM: skip $01

    ; $0093[0x01] - (???)
    .T1PANTM: skip $01

    ; $0094[0x01] - (???)
    .T2VOLTM: skip $01

    ; $0095[0x01] - (???)
    .T2PANTM: skip $01

    ; $0096[0x01] - (???)
    .T3VOLTM: skip $01

    ; $0097[0x01] - (???)
    .T3PANTM: skip $01

    ; $0098[0x01] - (???)
    .T4VOLTM: skip $01

    ; $0099[0x01] - (???)
    .T4PANTM: skip $01

    ; $009A[0x01] - (???)
    .T5VOLTM: skip $01

    ; $009B[0x01] - (???)
    .T5PANTM: skip $01

    ; $009C[0x01] - (???)
    .T6VOLTM: skip $01

    ; $009D[0x01] - (???)
    .T6PANTM: skip $01

    ; $009E[0x01] - (???)
    .T7VOLTM: skip $01

    ; $009F[0x01] - (???)
    .T7PANTM: skip $01


    ; Channel pitch slide timer and delay for operation
    ; $00A0[0x01] - (???)
    .T0GLSTM: skip $01

    ; $00A1[0x01] - (???)
    .T0GLSWT: skip $01

    ; $00A2[0x01] - (???)
    .T1GLSTM: skip $01

    ; $00A3[0x01] - (???)
    .T1GLSWT: skip $01

    ; $00A4[0x01] - (???)
    .T2GLSTM: skip $01

    ; $00A5[0x01] - (???)
    .T2GLSWT: skip $01

    ; $00A6[0x01] - (???)
    .T3GLSTM: skip $01

    ; $00A7[0x01] - (???)
    .T3GLSWT: skip $01

    ; $00A8[0x01] - (???)
    .T4GLSTM: skip $01

    ; $00A9[0x01] - (???)
    .T4GLSWT: skip $01

    ; $00AA[0x01] - (???)
    .T5GLSTM: skip $01

    ; $00AB[0x01] - (???)
    .T5GLSWT: skip $01

    ; $00AC[0x01] - (???)
    .T6GLSTM: skip $01

    ; $00AD[0x01] - (???)
    .T6GLSWT: skip $01

    ; $00AE[0x01] - (???)
    .T7GLSTM: skip $01

    ; $00AF[0x01] - (???)
    .T7GLSWT: skip $01


    ; Channel vibrato strength and max intensity
    ; $00B0[0x01] - (???)
    .T0VBRS: skip $01

    ; $00B1[0x01] - (???)
    .T0VBRI: skip $01

    ; $00B2[0x01] - (???)
    .T1VBRS: skip $01

    ; $00B3[0x01] - (???)
    .T1VBRI: skip $01

    ; $00B4[0x01] - (???)
    .T2VBRS: skip $01

    ; $00B5[0x01] - (???)
    .T2VBRI: skip $01

    ; $00B6[0x01] - (???)
    .T3VBRS: skip $01

    ; $00B7[0x01] - (???)
    .T3VBRI: skip $01

    ; $00B8[0x01] - (???)
    .T4VBRS: skip $01

    ; $00B9[0x01] - (???)
    .T4VBRI: skip $01

    ; $00BA[0x01] - (???)
    .T5VBRS: skip $01

    ; $00BB[0x01] - (???)
    .T5VBRI: skip $01

    ; $00BC[0x01] - (???)
    .T6VBRS: skip $01

    ; $00BD[0x01] - (???)
    .T6VBRI: skip $01

    ; $00BE[0x01] - (???)
    .T7VBRS: skip $01

    ; $00BF[0x01] - (???)
    .T7VBRI: skip $01


    ; Channel tremolo timer and intensity
    ; $00C0[0x01] - (???)
    .T0TRMTM: skip $01

    ; $00C1[0x01] - (???)
    .T0TREMI: skip $01

    ; $00C2[0x01] - (???)
    .T1TRMTM: skip $01

    ; $00C3[0x01] - (???)
    .T1TREMI: skip $01

    ; $00C4[0x01] - (???)
    .T2TRMTM: skip $01

    ; $00C5[0x01] - (???)
    .T2TREMI: skip $01

    ; $00C6[0x01] - (???)
    .T3TRMTM: skip $01

    ; $00C7[0x01] - (???)
    .T3TREMI: skip $01

    ; $00C8[0x01] - (???)
    .T4TRMTM: skip $01

    ; $00C9[0x01] - (???)
    .T4TREMI: skip $01

    ; $00CA[0x01] - (???)
    .T5TRMTM: skip $01

    ; $00CB[0x01] - (???)
    .T5TREMI: skip $01

    ; $00CC[0x01] - (???)
    .T6TRMTM: skip $01

    ; $00CD[0x01] - (???)
    .T6TREMI: skip $01

    ; $00CE[0x01] - (???)
    .T7TRMTM: skip $01

    ; $00CF[0x01] - (???)
    .T7TREMI: skip $01


    ; $00D0[0x20] - (Free)
    .Free_D0: skip $20
        ; Free RAM.


    ; ==========================================================================
    ; SPC hardware registers at $F0..$FF
    ; See «registers_spc.asm»
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
        ; SFX channel pointer in use

    ; $03C1[0x01] - (???)
    .SFXBIT: skip $01
        ; SFX channel bit for bitfields

    ; $03C2[0x01] - (???)
    .BITASL3: skip $01
        ; Contains channel<<3 for easier calculation

    ; $03C3[0x01] - (???)
    .EONM: skip $01
        ; Music channels flagged for echo enable


    ; Only referenced in an unused function, but it appears to relate to
    ; SFXOFF and SFXBIT.
    ; $03C4[0x01] - (???)
    .SFXOFFRT: skip $01

    ; $03C5[0x01] - (???)
    .SFXBITRT: skip $01

    ; $03C6[0x01] - (Free)
    .Free_03C6: skip $01
        ; Free RAM.

    ; $03C7[0x01] - (???)
    .ECHOFLIP: skip $01
        ; Used as a flip flop for toggling incrementing of EDLC


    ; Copies SFXOFF and SFXBIT, but never used
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
    .SFX1BIT: skip $01
        ; Channel bits for SFX1


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
    .SFX1FIND: skip $01
        ; Used to find SFX1 channel

    ; $03E1[0x01] - (???)
    .SONGOVOL: skip $01
        ; Caches song volume between half and max volume commsnds

    ; $03E2[0x01] - (???)
    .SFXECHOV: skip $01
        ; Holds value from echo table for SFX

    ; $03E3[0x01] - (???)
    .SFXECHOS: skip $01
        ; Bitfield for SFX echos


    ; SFX1 fade timer and volume
    ; $03E4[0x01] - (???)
    .SFX1FADE: skip $01

    ; $03E5[0x01] - (???)
    .SFX1FDVOL: skip $01


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
}

; $040F-$07FF ???
; $0800-$179D SPC Engine
; $17C0-$284F SF_DATA
; $2880-$2A8C SongBlock_1
; $2900-$3937 CREDITS_AUX_POINTER

; $2B00-$3188 SONG_POINTERS_AUX
; $3C00-$3C6F SAMPLE_POINTERS
; $3D00-$3D95 INSTRUMENT_DATA
; $3E00-$3EE0 INSTRUMENT_DATA_SFX
; $4000-$BA9F SAMPLE_DATA
; $D000-$D035 SONG_POINTERS (Overworld)
; $D000-$E05F SONG_POINTERS (Credits)
; $D000-$FCBF SONG_POINTERS (Underworld)

; ==============================================================================
