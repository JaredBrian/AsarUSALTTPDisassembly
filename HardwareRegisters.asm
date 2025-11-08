; ==============================================================================
; SNES Hardware Registers
; ==============================================================================

; Shorthand legend:
; Addr = Address
; APU = Audio Processing Unit
; BG = BackGround
; CGRAM = Color Generator RAM
; Des = Designation
; H = Horizontal
; HDMA = Horizontal Direct Memory Access
; HV = H/V or Horizontal/Vertical
; Init = Initial
; IO = I/O or Input/Output
; IRQ = Interupt ReQuest
; NMI = Non-Maskable Interupt
; Num = Number
; MULT = Multiply/Multiplication
; OAM = Object Attribute Memory
; OBJ = Object
; Pos = Position
; PPU = Picture Processing Unit
; V = Vertical
; Val = Value
; VRAM = Video RAM

; Names taken from:
; https://en.wikibooks.org/wiki/Super_NES_Programming/SNES_Hardware_Registers

; Further details on each register can be found here:
; https://github.com/gilligan/snesdev/blob/master/docs/snes_registers.txt
; https://www.youtube.com/watch?v=-4OOuRvTXrM&t=167s

org $7E2100 ; Remove for asar 2.0.

struct SNES $7E2100
{
    .ScreenDisplay:             skip $01 ; $2100
    .OAMSizeAndDataDes:         skip $01 ; $2101
    .OAMAccessAddr:             skip $02 ; $2102
    .OMADataWrite:              skip $01 ; $2104
    .BGModeAndTileSize:         skip $01 ; $2105
    .MosaicAndBGEnable:         skip $01 ; $2106

    .BG1AddrAndSize:            skip $01 ; $2107
    .BG2AddrAndSize:            skip $01 ; $2108
    .BG3AddrAndSize:            skip $01 ; $2109
    .BG4AddrAndSize:            skip $01 ; $210A

    .BG1And2TileDataDes:        skip $01 ; $210B
    .BG3And4TileDataDes:        skip $01 ; $210C

    .BG1HScrollOffset:          skip $01 ; $210D
    .BG1VScrollOffset:          skip $01 ; $210E
    .BG2HScrollOffset:          skip $01 ; $210F
    .BG2VScrollOffset:          skip $01 ; $2110
    .BG3HScrollOffset:          skip $01 ; $2111
    .BG3VScrollOffset:          skip $01 ; $2112
    .BG4HScrollOffset:          skip $01 ; $2113
    .BG4VScrollOffset:          skip $01 ; $2114

    .VRAMAddrIncrementVal:      skip $01 ; $2115
    .VRAMAddrReadWriteLow:      skip $01 ; $2116
    .VRAMAddrReadWriteHigh:     skip $01 ; $2117
    .VRAMDataWriteLow:          skip $01 ; $2118
    .VRAMDataWriteHigh:         skip $01 ; $2119

    .Mode7Init                  skip $01 ; $211A
    .Mode7MatrixA               skip $01 ; $211B
    .Mode7MatrixB               skip $01 ; $211C
    .Mode7MatrixC               skip $01 ; $211D
    .Mode7MatrixD               skip $01 ; $211E
    .Mode7CenterPosX            skip $01 ; $211F
    .Mode7CenterPosY            skip $01 ; $2120

    .CGRAMWriteAddr             skip $01 ; $2121
    .CGRAMWriteData             skip $01 ; $2122

    .BG1And2WindowMask          skip $01 ; $2123
    .BG3And4WindowMask          skip $01 ; $2124
    .OBJAndColorWindow          skip $01 ; $2125

    .Window1LeftPosDes          skip $01 ; $2126
    .Window1RightPosDes         skip $01 ; $2127
    .Window2LeftPosDes          skip $01 ; $2128
    .Window2RightPosDes         skip $01 ; $2129

    .BG123And4WindowLogic       skip $01 ; $212A
    .ColorAndOBJWindowLogic     skip $01 ; $212B
    .BGAndOBJEnableMainScreen   skip $01 ; $212C
    .BGAndOBJEnableSubScreen    skip $01 ; $212D
    .WindowMaskDesMainScreen    skip $01 ; $212E
    .WindowMaskDesSubScreen     skip $01 ; $212F
    .InitColorAddition          skip $01 ; $2130
    .AddSubtractSelectAndEnable skip $01 ; $2131
    .FixedColorData             skip $01 ; $2132
    .ScreenInit                 skip $01 ; $2133

    .MultResultLow              skip $01 ; $2134
    .MultResultMid              skip $01 ; $2135
    .MultResultHigh             skip $01 ; $2136

    .HVCounterSoftwareLatch     skip $01 ; $2137

    .OAMReadDataLowHigh         skip $01 ; $2138
    .VRAMReadDataLow            skip $01 ; $2139
    .VRAMReadDataHigh           skip $01 ; $213A
    .CGRAMReadDataLowHigh       skip $01 ; $213B

    .HCounterData               skip $01 ; $213C
    .VCounterData               skip $01 ; $213D

    .PPUStatusFlag1             skip $01 ; $213E
    .PPUStatusFlag2             skip $01 ; $213F

    .APUIOPort0                 skip $01 ; $2140
    .APUIOPort1                 skip $01 ; $2141
    .APUIOPort2                 skip $01 ; $2142
    .APUIOPort3                 skip $01 ; $2143

    base $2180
    .IndirectWorkRAMPort:       skip $01 ; $2180
    .IndirectWorkRAMAddrLow:    skip $01 ; $2181
    .IndirectWorkRAMAddrMid:    skip $01 ; $2182
    .IndirectWorkRAMAddrHigh:   skip $01 ; $2183

    base $4200
    .NMIVHCountJoypadEnable:    skip $01 ; $4200
    .ProgrammableIOPortOut:     skip $01 ; $4201
    .MultiplicandA:             skip $01 ; $4202
    .MultiplierB:               skip $01 ; $4203
    .DividendLow:               skip $01 ; $4204
    .DividendHigh:              skip $01 ; $4205
    .DivisorB:                  skip $01 ; $4206
    .HCountTimer:               skip $01 ; $4207
    .HCountTimerHigh:           skip $01 ; $4208
    .VCountTImer:               skip $01 ; $4209
    .VCountTimerHigh:           skip $01 ; $420A

    .DMAChannelEnable:          skip $01 ; $420B
    .HDMAChannelEnable:         skip $01 ; $420C
    .CycleSpeedDes:             skip $01 ; $420D

    base $4210
    .NMIFlagAndCPUVersionNum:   skip $01 ; $4210
    .IRQFlagByHVCountTimer:     skip $01 ; $4211
    .HVBlankFlagsAndJoyStatus:  skip $01 ; $4212
    .ProgrammableIOPortIn:      skip $01 ; $4213
    .DivideResultQuotientLow:   skip $01 ; $4214
    .DivideResultQuotientHigh:  skip $01 ; $4215
    .RemainderResultLow:        skip $01 ; $4216
    .RemainderResultHigh:       skip $01 ; $4217

    .JoyPad1DataLow:            skip $01 ; $4218
    .JoyPad1DataHigh:           skip $01 ; $4219
    .JoyPad2DataLow:            skip $01 ; $421A
    .JoyPad2DataHigh:           skip $01 ; $421B
    .JoyPad3DataLow:            skip $01 ; $421C
    .JoyPad3DataHigh:           skip $01 ; $421D
    .JoyPad4DataLow:            skip $01 ; $421E
    .JoyPad4DataHigh:           skip $01 ; $421F
}
endstruct

struct DMA $7E4300
{
    ; Channel 0
    .0_TransferParameters:   skip $01 ; $4300
    .0_DestinationAddr:      skip $01 ; $4301
    .0_SourceAddrOffsetLow:  skip $01 ; $4302
    .0_SourceAddrOffsetHigh: skip $01 ; $4303
    .0_SourceAddrBank:       skip $01 ; $4304
    .0_TransferSizeLow:      skip $01 ; $4305
    .0_TransferSizeHigh:     skip $01 ; $4306
    .0_DataBank:             skip $01 ; $4307
    .0_TableAddrLow:         skip $01 ; $4308
    .0_TableAddrHigh:        skip $01 ; $4309
    .0_TransferLineNum:      skip $01 ; $430A

    base $4310 ; Channel 1
    .1_TransferParameters:   skip $01 ; $4310
    .1_DestinationAddr:      skip $01 ; $4311
    .1_SourceAddrOffsetLow:  skip $01 ; $4312
    .1_SourceAddrOffsetHigh: skip $01 ; $4313
    .1_SourceAddrBank:       skip $01 ; $4314
    .1_TransferSizeLow:      skip $01 ; $4315
    .1_TransferSizeHigh:     skip $01 ; $4316
    .1_DataBank:             skip $01 ; $4317
    .1_TableAddrLow:         skip $01 ; $4318
    .1_TableAddrHigh:        skip $01 ; $4319
    .1_TransferLineNum:      skip $01 ; $431A

    base $4320 ; Channel 2
    .2_TransferParameters:   skip $01 ; $4320
    .2_DestinationAddr:      skip $01 ; $4321
    .2_SourceAddrOffsetLow:  skip $01 ; $4322
    .2_SourceAddrOffsetHigh: skip $01 ; $4323
    .2_SourceAddrBank:       skip $01 ; $4324
    .2_TransferSizeLow:      skip $01 ; $4325
    .2_TransferSizeHigh:     skip $01 ; $4326
    .2_DataBank:             skip $01 ; $4327
    .2_TableAddrLow:         skip $01 ; $4328
    .2_TableAddrHigh:        skip $01 ; $4329
    .2_TransferLineNum:      skip $01 ; $432A

    base $4330 ; Channel 3
    .3_TransferParameters:   skip $01 ; $4330
    .3_DestinationAddr:      skip $01 ; $4331
    .3_SourceAddrOffsetLow:  skip $01 ; $4332
    .3_SourceAddrOffsetHigh: skip $01 ; $4333
    .3_SourceAddrBank:       skip $01 ; $4334
    .3_TransferSizeLow:      skip $01 ; $4335
    .3_TransferSizeHigh:     skip $01 ; $4336
    .3_DataBank:             skip $01 ; $4337
    .3_TableAddrLow:         skip $01 ; $4338
    .3_TableAddrHigh:        skip $01 ; $4339
    .3_TransferLineNum:      skip $01 ; $433A

    base $4340 ; Channel 4
    .4_TransferParameters:   skip $01 ; $4340
    .4_DestinationAddr:      skip $01 ; $4341
    .4_SourceAddrOffsetLow:  skip $01 ; $4342
    .4_SourceAddrOffsetHigh: skip $01 ; $4343
    .4_SourceAddrBank:       skip $01 ; $4344
    .4_TransferSizeLow:      skip $01 ; $4345
    .4_TransferSizeHigh:     skip $01 ; $4346
    .4_DataBank:             skip $01 ; $4347
    .4_TableAddrLow:         skip $01 ; $4348
    .4_TableAddrHigh:        skip $01 ; $4349
    .4_TransferLineNum:      skip $01 ; $434A

    base $4350 ; Channel 5
    .5_TransferParameters:   skip $01 ; $4350
    .5_DestinationAddr:      skip $01 ; $4351
    .5_SourceAddrOffsetLow:  skip $01 ; $4352
    .5_SourceAddrOffsetHigh: skip $01 ; $4353
    .5_SourceAddrBank:       skip $01 ; $4354
    .5_TransferSizeLow:      skip $01 ; $4355
    .5_TransferSizeHigh:     skip $01 ; $4356
    .5_DataBank:             skip $01 ; $4357
    .5_TableAddrLow:         skip $01 ; $4358
    .5_TableAddrHigh:        skip $01 ; $4359
    .5_TransferLineNum:      skip $01 ; $435A

    base $4360 ; Channel 6
    .6_TransferParameters:   skip $01 ; $4360
    .6_DestinationAddr:      skip $01 ; $4361
    .6_SourceAddrOffsetLow:  skip $01 ; $4362
    .6_SourceAddrOffsetHigh: skip $01 ; $4363
    .6_SourceAddrBank:       skip $01 ; $4364
    .6_TransferSizeLow:      skip $01 ; $4365
    .6_TransferSizeHigh:     skip $01 ; $4366
    .6_DataBank:             skip $01 ; $4367
    .6_TableAddrLow:         skip $01 ; $4368
    .6_TableAddrHigh:        skip $01 ; $4369
    .6_TransferLineNum:      skip $01 ; $436A

    base $4370 ; Channel 7
    .7_TransferParameters:   skip $01 ; $4370
    .7_DestinationAddr:      skip $01 ; $4371
    .7_SourceAddrOffsetLow:  skip $01 ; $4372
    .7_SourceAddrOffsetHigh: skip $01 ; $4373
    .7_SourceAddrBank:       skip $01 ; $4374
    .7_TransferSizeLow:      skip $01 ; $4375
    .7_TransferSizeHigh:     skip $01 ; $4376
    .7_DataBank:             skip $01 ; $4377
    .7_TableAddrLow:         skip $01 ; $4378
    .7_TableAddrHigh:        skip $01 ; $4379
    .7_TransferLineNum:      skip $01 ; $437A
}
endstruct

; ==============================================================================

; Further documentation on the SPC700 can be found here:
; https://www.romhacking.net/documents/197
; https://youtu.be/zrn0QavLMyo?si=sJ2hysYTft148S7u
; https://en.wikibooks.org/wiki/Super_NES_Programming/SPC700_reference
; https://snes.nesdev.org/wiki/S-DSP_registers#MVOL

struct SMP $00F0
{
    .TEST:     skip $01 ; $00F0
    .CONTROL:  skip $01 ; $00F1
    .DSPADDR:  skip $01 ; $00F2
    .DSPDATA:  skip $01 ; $00F3
    .CPUIO0:   skip $01 ; $00F4
    .CPUIO1:   skip $01 ; $00F5
    .CPUIO2:   skip $01 ; $00F6
    .CPUIO3:   skip $01 ; $00F7
    .AuxIO4:   skip $01 ; $00F8
    .AuxIO5:   skip $01 ; $00F9
    .T0TARGET: skip $01 ; $00FA
    .T1TARGET: skip $01 ; $00FB
    .T2TARGET: skip $01 ; $00FC
    .T0OUT:    skip $01 ; $00FD
    .T1OUT:    skip $01 ; $00FE
    .T2OUT:    skip $01 ; $00FF
}
endstruct

struct DSP $00
{
    .VxVOLL:            ; $00
    .V0VOLL:   skip $01 ; $00
    .VxVOLR:            ; $01
    .V0VOLR:   skip $01 ; $01
    .VxPITCHL:          ; $02
    .V0PITCHL: skip $01 ; $02
    .VxPITCHH:          ; $03
    .V0PITCHH: skip $01 ; $03
    .VxSRCN:            ; $04
    .V0SRCN:   skip $01 ; $04
    .VxADSR1:           ; $05
    .V0ADSR1:  skip $01 ; $05
    .VxADSR2:           ; $06
    .V0ADSR2:  skip $01 ; $06
    .VxGAIN:            ; $07
    .V0GAIN:   skip $01 ; $07
    .VxENVX:            ; $08
    .V0ENVX:   skip $01 ; $08
    .VxOUTX:            ; $09
    .V0OUTX:   skip $03 ; $09

    .MVOLL:    skip $01 ; $0C
    .EFB:      skip $02 ; $0D

    .FIR:      skip $01 ; $0F
    .FIR0:     skip $01 ; $0F
    .V1VOLL:   skip $01 ; $10
    .V1VOLR:   skip $01 ; $11
    .V1PITCHL: skip $01 ; $12
    .V1PITCHH: skip $01 ; $13
    .V1SRCN:   skip $01 ; $14
    .V1ADSR1:  skip $01 ; $15
    .V1ADSR2:  skip $01 ; $16
    .V1GAIN:   skip $01 ; $17
    .V1ENVX:   skip $01 ; $18
    .V1OUTX:   skip $03 ; $19

    .MVOLR:    skip $03 ; $1C

    .FIR1:     skip $01 ; $1F
    .V2VOLL:   skip $01 ; $20
    .V2VOLR:   skip $01 ; $21
    .V2PITCHL: skip $01 ; $22
    .V2PITCHH: skip $01 ; $23
    .V2SRCN:   skip $01 ; $24
    .V2ADSR1:  skip $01 ; $25
    .V2ADSR2:  skip $01 ; $26
    .V2GAIN:   skip $01 ; $27
    .V2ENVX:   skip $01 ; $28
    .V2OUTX:   skip $03 ; $29

    .EVOLL:    skip $01 ; $2C
    .PMON:     skip $02 ; $2D

    .FIR2:     skip $01 ; $2F
    .V3VOLL:   skip $01 ; $30
    .V3VOLR:   skip $01 ; $31
    .V3PITCHL: skip $01 ; $32
    .V3PITCHH: skip $01 ; $33
    .V3SRCN:   skip $01 ; $34
    .V3ADSR1:  skip $01 ; $35
    .V3ADSR2:  skip $01 ; $36
    .V3GAIN:   skip $01 ; $37
    .V3ENVX:   skip $01 ; $38
    .V3OUTX:   skip $03 ; $39

    .EVOLR:    skip $01 ; $3C
    .NON:      skip $02 ; $3D

    .FIR3:     skip $01 ; $3F
    .V4VOLL:   skip $01 ; $40
    .V4VOLR:   skip $01 ; $41
    .V4PITCHL: skip $01 ; $42
    .V4PITCHH: skip $01 ; $43
    .V4SRCN:   skip $01 ; $44
    .V4ADSR1:  skip $01 ; $45
    .V4ADSR2:  skip $01 ; $46
    .V4GAIN:   skip $01 ; $47
    .V4ENVX:   skip $01 ; $48
    .V4OUTX:   skip $03 ; $49

    .KON:      skip $01 ; $4C
    .EON:      skip $02 ; $4D

    .FIR4:     skip $01 ; $4F
    .V5VOLL:   skip $01 ; $50
    .V5VOLR:   skip $01 ; $51
    .V5PITCHL: skip $01 ; $52
    .V5PITCHH: skip $01 ; $53
    .V5SRCN:   skip $01 ; $54
    .V5ADSR1:  skip $01 ; $55
    .V5ADSR2:  skip $01 ; $56
    .V5GAIN:   skip $01 ; $57
    .V5ENVX:   skip $01 ; $58
    .V5OUTX:   skip $03 ; $59

    .KOFF:     skip $01 ; $5C
    .DIR:      skip $02 ; $5D

    .FIR5:     skip $01 ; $5F
    .V6VOLL:   skip $01 ; $60
    .V6VOLR:   skip $01 ; $61
    .V6PITCHL: skip $01 ; $62
    .V6PITCHH: skip $01 ; $63
    .V6SRCN:   skip $01 ; $64
    .V6ADSR1:  skip $01 ; $65
    .V6ADSR2:  skip $01 ; $66
    .V6GAIN:   skip $01 ; $67
    .V6ENVX:   skip $01 ; $68
    .V6OUTX:   skip $03 ; $69

    .FLG:      skip $01 ; $6C
    .ESA:      skip $02 ; $6D

    .FIR6:     skip $01 ; $6F
    .V7VOLL:   skip $01 ; $70
    .V7VOLR:   skip $01 ; $71
    .V7PITCHL: skip $01 ; $72
    .V7PITCHH: skip $01 ; $73
    .V7SRCN:   skip $01 ; $74
    .V7ADSR1:  skip $01 ; $75
    .V7ADSR2:  skip $01 ; $76
    .V7GAIN:   skip $01 ; $77
    .V7ENVX:   skip $01 ; $78
    .V7OUTX:   skip $03 ; $79

    .ENDX:     skip $01 ; $7C
    .EDL:      skip $02 ; $7D

    .FIR7:              ; $7F
}

; ==============================================================================