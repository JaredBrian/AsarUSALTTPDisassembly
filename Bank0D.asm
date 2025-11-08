; ==============================================================================

; Bank 0x0D
; $068000-$06FFFF
org $0D8000

; Player OAM
; Sound effects code
; Misc sprite code
; HUD code
; Item menu code

; ==============================================================================
; Player OAM Data
; ==============================================================================
; This holds data for Link's primary poses
; y, x, ab
;   y - y offset of head
;   x - x offset of head
;   a - head OAM props high nibble
;   b - body OAM props high nibble
;   F - don't draw
; ==============================================================================

; $068000-$06838C DATA
PlayerOam_PoseData:
{
    db  0,  0, $00 ; 0x0000
    db  1,  0, $00 ; 0x0001
    db  2,  0, $00 ; 0x0002
    db  1,  0, $04 ; 0x0003
    db  2,  0, $04 ; 0x0004
    db  0,  0, $00 ; 0x0005
    db  1,  0, $00 ; 0x0006
    db  2,  0, $00 ; 0x0007
    db  1,  0, $04 ; 0x0008
    db  2,  0, $04 ; 0x0009
    db  0,  1, $44 ; 0x000A
    db  1,  1, $44 ; 0x000B
    db  2,  2, $44 ; 0x000C
    db  0, -1, $00 ; 0x000D
    db  1, -1, $00 ; 0x000E
    db  2, -2, $00 ; 0x000F
    db  0,  0, $00 ; 0x0010
    db  0,  0, $00 ; 0x0011
    db -1,  0, $00 ; 0x0012
    db  0,  0, $00 ; 0x0013
    db  0,  0, $00 ; 0x0014
    db  1,  0, $00 ; 0x0015
    db  1,  0, $00 ; 0x0016
    db  1,  0, $00 ; 0x0017
    db  1,  1, $44 ; 0x0018
    db  1,  1, $44 ; 0x0019
    db  1,  0, $44 ; 0x001A
    db  1,  1, $44 ; 0x001B
    db  1, -1, $00 ; 0x001C
    db  1, -1, $00 ; 0x001D
    db  1,  0, $00 ; 0x001E
    db  1, -1, $00 ; 0x001F
    db  0,  0, $00 ; 0x0020
    db  1,  0, $00 ; 0x0021
    db  2,  0, $00 ; 0x0022
    db  1,  0, $04 ; 0x0023
    db  2,  0, $04 ; 0x0024
    db  0,  0, $00 ; 0x0025
    db  1,  0, $00 ; 0x0026
    db  2,  0, $00 ; 0x0027
    db  1,  0, $00 ; 0x0028
    db  2,  0, $00 ; 0x0029
    db  0,  1, $44 ; 0x002A
    db  1,  1, $44 ; 0x002B
    db  2,  1, $44 ; 0x002C
    db  0, -1, $00 ; 0x002D
    db  1, -1, $00 ; 0x002E
    db  2, -1, $00 ; 0x002F
    db -1,  0, $00 ; 0x0030
    db  0,  0, $00 ; 0x0031
    db  0,  0, $00 ; 0x0032
    db  2,  0, $00 ; 0x0033
    db  1,  0, $00 ; 0x0034
    db  2, -1, $44 ; 0x0035
    db  1,  1, $44 ; 0x0036
    db  1,  1, $44 ; 0x0037
    db  2,  1, $00 ; 0x0038
    db  1, -1, $00 ; 0x0039
    db  1, -1, $00 ; 0x003A
    db  0, -8, $00 ; 0x003B
    db  4,  0, $0F ; 0x003C
    db  4,  0, $0F ; 0x003D
    db  0,  0, $FF ; 0x003E
    db  0,  0, $00 ; 0x003F
    db  0,  0, $00 ; 0x0040
    db  0,  0, $44 ; 0x0041
    db  0,  0, $00 ; 0x0042
    db  0,  0, $00 ; 0x0043
    db -1,  0, $00 ; 0x0044
    db -1,  0, $00 ; 0x0045
    db  0,  0, $00 ; 0x0046
    db  1,  0, $00 ; 0x0047
    db  2,  0, $00 ; 0x0048
    db  0,  0, $44 ; 0x0049
    db  1,  0, $44 ; 0x004A
    db  1,  0, $44 ; 0x004B
    db  0,  0, $00 ; 0x004C
    db  1,  0, $00 ; 0x004D
    db  1,  0, $00 ; 0x004E
    db -1,  0, $00 ; 0x004F
    db -5,  0, $00 ; 0x0050
    db  2,  0, $00 ; 0x0051
    db  5,  0, $00 ; 0x0052
    db -1,  0, $44 ; 0x0053
    db  0,  0, $44 ; 0x0054
    db  0,  1, $44 ; 0x0055
    db -1,  0, $00 ; 0x0056
    db  0,  0, $00 ; 0x0057
    db  0, -1, $00 ; 0x0058
    db  0,  0, $00 ; 0x0059
    db  1,  0, $00 ; 0x005A
    db  2,  0, $00 ; 0x005B
    db  1,  0, $04 ; 0x005C
    db  2,  0, $04 ; 0x005D
    db  0,  0, $00 ; 0x005E
    db  1,  0, $00 ; 0x005F
    db  2,  0, $00 ; 0x0060
    db  1,  0, $04 ; 0x0061
    db  2,  0, $04 ; 0x0062
    db  0,  1, $44 ; 0x0063
    db  1,  1, $44 ; 0x0064
    db  2,  1, $44 ; 0x0065
    db  0, -1, $00 ; 0x0066
    db  1, -1, $00 ; 0x0067
    db  2, -1, $00 ; 0x0068
    db  1,  0, $04 ; 0x0069
    db  0,  0, $44 ; 0x006A
    db  0,  0, $00 ; 0x006B
    db  0,  1, $44 ; 0x006C
    db  0,  0, $00 ; 0x006D
    db  0,  0, $04 ; 0x006E
    db  0,  0, $44 ; 0x006F
    db  0,  1, $40 ; 0x0070
    db  0,  2, $40 ; 0x0071
    db  0, -1, $00 ; 0x0072
    db  0, -2, $00 ; 0x0073
    db  0,  0, $00 ; 0x0074
    db  1,  0, $00 ; 0x0075
    db  0,  0, $00 ; 0x0076
    db  0,  1, $44 ; 0x0077
    db  0, -1, $00 ; 0x0078
    db  1,  1, $00 ; 0x0079
    db  2,  1, $00 ; 0x007A
    db  2,  4, $00 ; 0x007B
    db  2,  1, $00 ; 0x007C
    db  0,  0, $00 ; 0x007D
    db  1,  0, $00 ; 0x007E
    db  1,  0, $00 ; 0x007F
    db  0,  0, $00 ; 0x0080
    db  1,  0, $00 ; 0x0081
    db  1, -1, $44 ; 0x0082
    db  2, -1, $44 ; 0x0083
    db  2, -4, $44 ; 0x0084
    db  2, -1, $44 ; 0x0085
    db  1,  0, $44 ; 0x0086
    db  0,  0, $00 ; 0x0087
    db  0,  0, $40 ; 0x0088
    db  0,  0, $04 ; 0x0089
    db  0,  0, $04 ; 0x008A
    db  0,  0, $00 ; 0x008B
    db  0,  0, $00 ; 0x008C
    db  0,  0, $00 ; 0x008D
    db  1,  0, $00 ; 0x008E
    db  2,  0, $04 ; 0x008F
    db  1,  0, $00 ; 0x0090
    db  2,  0, $04 ; 0x0091
    db  5,  1, $40 ; 0x0092
    db  6,  1, $44 ; 0x0093
    db  5, -1, $04 ; 0x0094
    db  6, -1, $00 ; 0x0095
    db  0,  0, $00 ; 0x0096
    db  0,  0, $04 ; 0x0097
    db  0,  0, $00 ; 0x0098
    db  0,  0, $00 ; 0x0099
    db  0,  0, $44 ; 0x009A
    db  0,  0, $00 ; 0x009B
    db 13,  3, $44 ; 0x009C
    db 12,  5, $44 ; 0x009D
    db 12,  5, $44 ; 0x009E
    db 13, -3, $00 ; 0x009F
    db 12, -5, $00 ; 0x00A0
    db 12, -5, $00 ; 0x00A1
    db  1,  0, $00 ; 0x00A2
    db  0,  0, $00 ; 0x00A3
    db  0,  0, $00 ; 0x00A4
    db  1,  0, $00 ; 0x00A5
    db  2,  0, $00 ; 0x00A6
    db  0,  0, $44 ; 0x00A7
    db  0,  0, $00 ; 0x00A8
    db  0,  0, $00 ; 0x00A9
    db  0,  0, $00 ; 0x00AA
    db  0,  0, $44 ; 0x00AB
    db  0,  0, $44 ; 0x00AC
    db -1,  0, $04 ; 0x00AD
    db  0,  0, $00 ; 0x00AE
    db -1,  0, $00 ; 0x00AF
    db -2,  0, $00 ; 0x00B0
    db  0,  0, $00 ; 0x00B1
    db  0,  0, $00 ; 0x00B2
    db -1,  0, $00 ; 0x00B3
    db -2,  0, $00 ; 0x00B4
    db  0,  0, $00 ; 0x00B5
    db  0,  0, $04 ; 0x00B6
    db -1,  0, $00 ; 0x00B7
    db -2,  0, $00 ; 0x00B8
    db  0,  0, $00 ; 0x00B9
    db -1,  0, $04 ; 0x00BA
    db -2,  0, $04 ; 0x00BB
    db  0,  0, $04 ; 0x00BC
    db -1,  1, $44 ; 0x00BD
    db -1,  0, $44 ; 0x00BE
    db  0,  1, $44 ; 0x00BF
    db  0,  1, $44 ; 0x00C0
    db -1,  1, $44 ; 0x00C1
    db -1,  0, $44 ; 0x00C2
    db  0,  0, $44 ; 0x00C3
    db -1, -1, $00 ; 0x00C4
    db -1,  0, $00 ; 0x00C5
    db  0, -1, $00 ; 0x00C6
    db  0, -1, $00 ; 0x00C7
    db -1, -1, $00 ; 0x00C8
    db -1,  0, $00 ; 0x00C9
    db  0,  0, $00 ; 0x00CA
    db  0,  0, $04 ; 0x00CB
    db  1,  0, $00 ; 0x00CC
    db  2,  0, $00 ; 0x00CD
    db  1,  0, $00 ; 0x00CE
    db  2,  0, $00 ; 0x00CF
    db  1,  0, $00 ; 0x00D0
    db  2,  0, $00 ; 0x00D1
    db  1,  0, $04 ; 0x00D2
    db  2,  0, $04 ; 0x00D3
    db  1,  1, $44 ; 0x00D4
    db  2,  1, $44 ; 0x00D5
    db  1, -1, $00 ; 0x00D6
    db  2, -1, $00 ; 0x00D7
    db  2,  0, $00 ; 0x00D8
    db  2,  0, $00 ; 0x00D9
    db  3,  0, $00 ; 0x00DA
    db  3,  0, $00 ; 0x00DB
    db  2, -2, $44 ; 0x00DC
    db  2,  1, $44 ; 0x00DD
    db  2,  2, $00 ; 0x00DE
    db  2, -1, $00 ; 0x00DF
    db  0,  0, $00 ; 0x00E0
    db  1,  0, $00 ; 0x00E1
    db  2,  0, $00 ; 0x00E2
    db  1,  0, $04 ; 0x00E3
    db  2,  0, $04 ; 0x00E4
    db  2,  0, $00 ; 0x00E5
    db  3,  0, $00 ; 0x00E6
    db  4,  0, $00 ; 0x00E7
    db  3,  0, $04 ; 0x00E8
    db  4,  0, $04 ; 0x00E9
    db  0,  0, $44 ; 0x00EA
    db  1,  0, $44 ; 0x00EB
    db  2,  0, $44 ; 0x00EC
    db  0,  0, $00 ; 0x00ED
    db  1,  0, $00 ; 0x00EE
    db  2,  0, $00 ; 0x00EF
    db  3,  0, $00 ; 0x00F0
    db  2,  0, $00 ; 0x00F1
    db -1,  0, $00 ; 0x00F2
    db  0,  0, $00 ; 0x00F3
    db  1,  0, $00 ; 0x00F4
    db -1,  0, $00 ; 0x00F5
    db  0,  0, $00 ; 0x00F6
    db  1,  0, $00 ; 0x00F7
    db -1,  0, $44 ; 0x00F8
    db  0,  0, $44 ; 0x00F9
    db  1,  0, $44 ; 0x00FA
    db -1,  0, $44 ; 0x00FB
    db  0,  0, $44 ; 0x00FC
    db  1,  0, $44 ; 0x00FD
    db  0,  0, $00 ; 0x00FE
    db  1,  0, $00 ; 0x00FF
    db  2,  0, $00 ; 0x0100
    db  1,  0, $00 ; 0x0101
    db  2,  0, $00 ; 0x0102
    db  0,  0, $00 ; 0x0103
    db  3,  0, $00 ; 0x0104
    db  4,  0, $00 ; 0x0105
    db  2,  0, $00 ; 0x0106
    db  0, -1, $44 ; 0x0107
    db  1,  1, $44 ; 0x0108
    db  0,  1, $44 ; 0x0109
    db  0,  1, $00 ; 0x010A
    db  1,  1, $00 ; 0x010B
    db  0, -1, $00 ; 0x010C
    db  3,  0, $00 ; 0x010D
    db  2,  0, $04 ; 0x010E
    db  3,  0, $04 ; 0x010F
    db  0,  2, $00 ; 0x0110
    db  8,  8, $00 ; 0x0111
    db  0,  0, $00 ; 0x0112
    db  0,  0, $00 ; 0x0113
    db -1,  0, $0F ; 0x0114
    db  1,  0, $00 ; 0x0115
    db  0,  0, $04 ; 0x0116
    db  0,  0, $00 ; 0x0117
    db  2,  0, $00 ; 0x0118
    db  1,  4, $44 ; 0x0119
    db  1, -4, $00 ; 0x011A
    db  0,  0, $00 ; 0x011B
    db  1,  0, $00 ; 0x011C
    db  1,  0, $04 ; 0x011D
    db  0,  0, $00 ; 0x011E
    db  1,  0, $00 ; 0x011F
    db  1,  0, $04 ; 0x0120
    db  0,  1, $44 ; 0x0121
    db  1,  1, $44 ; 0x0122
    db  0, -1, $00 ; 0x0123
    db  1, -1, $00 ; 0x0124
    db  0,  0, $44 ; 0x0125
    db -2,  0, $00 ; 0x0126
    db  0, -2, $04 ; 0x0127
    db  0,  0, $00 ; 0x0128
    db  0,  1, $00 ; 0x0129
    db  0,  0, $04 ; 0x012A
    db 12,  0, $08 ; 0x012B
    db 14,  0, $80 ; 0x012C
    db 12,  0, $00 ; 0x012D
    db 11,  0, $00 ; 0x012E
}

; ==============================================================================

; $06838D-$06839A DATA
PlayerOam_AuxFlip:
{
    db $00, $00, $00, $40, $40, $48, $C0
    db $48, $C0, $48, $C0, $48, $C0, $40
}

; ==============================================================================
; These are OAM props and characters for 3 separate positions for the sword,
; and other weapons. $FFFF - do not draw.
; ==============================================================================

; $06839B-$068562 DATA
PlayerOam_WeaponTiles:
{
    dw $2A05, $2A06, $FFFF
    dw $6A06, $6A05, $FFFF
    dw $AA05, $AA06, $FFFF
    dw $2A05, $2A06, $FFFF
    dw $EA06, $EA05, $FFFF
    dw $6A06, $6A05, $FFFF
    dw $2A05, $FFFF, $2A15
    dw $AA15, $FFFF, $AA05
    dw $2A05, $FFFF, $2A15
    dw $AA15, $FFFF, $AA05
    dw $6A05, $FFFF, $6A15
    dw $EA15, $FFFF, $EA05
    dw $2A05, $FFFF, $FFFF
    dw $AA05, $FFFF, $FFFF
    dw $6A05, $FFFF, $FFFF
    dw $EA05, $FFFF, $FFFF
    dw $2A05, $FFFF, $FFFF
    dw $AA05, $FFFF, $FFFF
    dw $6A05, $FFFF, $FFFF
    dw $EA05, $FFFF, $FFFF
    dw $2A05, $FFFF, $FFFF
    dw $AA05, $FFFF, $FFFF
    dw $6A05, $FFFF, $FFFF
    dw $EA05, $FFFF, $FFFF
    dw $2A05, $FFFF, $FFFF
    dw $AA05, $FFFF, $FFFF
    dw $6A05, $FFFF, $FFFF
    dw $EA05, $FFFF, $FFFF
    dw $AA15, $FFFF, $FFFF
    dw $2209, $FFFF, $2219
    dw $2209, $FFFF, $2219
    dw $221A, $FFFF, $2219
    dw $A219, $FFFF, $A209
    dw $2209, $FFFF, $2219
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2219, $2209, $FFFF
    dw $6209, $FFFF, $FFFF
    dw $6209, $6219, $FFFF
    dw $A209, $E209, $FFFF
    dw $2209, $6209, $FFFF
    dw $6209, $FFFF, $E209
    dw $2209, $FFFF, $A209
    dw $A209, $FFFF, $FFFF
    dw $6209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $E209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $6209, $FFFF, $FFFF
    dw $6209, $FFFF, $FFFF
    dw $221A, $FFFF, $FFFF
    dw $221A, $FFFF, $FFFF
    dw $221A, $FFFF, $FFFF
    dw $221A, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $E209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $FFFF
    dw $2209, $FFFF, $2219
    dw $2209, $FFFF, $2219
    dw $2209, $FFFF, $2219
    dw $6209, $FFFF, $6219
    dw $2209, $FFFF, $2219
    dw $2209, $FFFF, $FFFF
    dw $A219, $A209, $FFFF
    dw $6209, $FFFF, $FFFF
    dw $E209, $E219, $FFFF
    dw $2809, $FFFF, $FFFF
}

; ==============================================================================
; These are OAM props and characters for 3 separate positions for the shield.
; $FFFF - do not draw
; ==============================================================================

; $068563-$0685CE DATA
PlayerOam_ShieldTiles:
{
    dw $2A07, $FFFF, $FFFF ; Down
    dw $2A07, $FFFF, $FFFF ; Up
    dw $2A07, $FFFF, $FFFF ; Right
    dw $6A07, $FFFF, $FFFF ; Left

    dw $2A07, $FFFF, $FFFF ; The rest of these seem to be unused/garbage
    dw $6A07, $FFFF, $FFFF
    dw $2A07, $FFFF, $FFFF
    dw $6A07, $FFFF, $FFFF

    dw $2809, $FFFF, $2819
    dw $2809, $FFFF, $2819
    dw $281A, $FFFF, $2819
    dw $A819, $FFFF, $A809

    dw $2809, $FFFF, $2819
    dw $2809, $FFFF, $FFFF
    dw $2809, $FFFF, $FFFF
    dw $2819, $2809, $FFFF

    dw $6809, $FFFF, $FFFF
    dw $6809, $6819, $FFFF
}

; ==============================================================================
; OAM props and tiles for shadows appears to be: formatted as:
;   ABCC
;   A - OAM props of left tile
;   B - OAM props of right tile
;   C - OAM char of both tiles
;
;  FFFF - no tile
; ==============================================================================

; $0685CF-$0685FA DATA
PlayerOam_ShadowTiles:
{
    dw $286C, $686C ; Normal shadow
    dw $2828, $6828 ; Small shadow
    dw $2838, $FFFF ; Used while falling
    dw $286E, $686E ; Unused and buggy
    dw $287E, $687E ; Unused and buggy
    dw $24D8, $64D8 ; Shallow water step 1
    dw $24D9, $64D9 ; Shallow water step 2
    dw $24DA, $64DA ; Shallow water step 3
    dw $22C8, $62C8 ; Grass step 1
    dw $22C9, $62C9 ; Grass step 2
    dw $22CA, $62CA ; Grass step 3
}

; ==============================================================================
; These animation steps point to an index in PlayerOam_PoseData
; ==============================================================================

; $0685FB-0689F8 DATA
PlayerOam_AnimationSteps:
{
    ; Walking
    ; Charging dash
    ; Index 0 used for standing still
    dw $0000, $00AE, $00AF, $00B0, $00B1, $00B2, $00B3, $00B4, $00B5 ; Up
    dw $0005, $00B6, $00B7, $00B8, $00B9, $00B6, $00BA, $00BB, $00BC ; Down
    dw $000A, $000A, $00BD, $00BE, $00BF, $00C0, $00C1, $00C2, $00C3 ; Left
    dw $000D, $000D, $00C4, $00C5, $00C6, $00C7, $00C8, $00C9, $00CA ; Right

    ; Powder
    dw $0010, $0010, $0011, $0011, $0012, $0012, $0013, $0013, $0013 ; Up
    dw $0014, $0014, $0015, $0015, $0016, $0016, $0017, $0017, $0017 ; Down
    dw $0018, $0018, $0019, $0019, $001A, $001A, $001B, $001B, $001B ; Left
    dw $001C, $001C, $001D, $001D, $001E, $001E, $001F, $001F, $001F ; Right

    ; Walking with sword out
    dw $0020, $0021, $0022, $0020, $0023, $0024 ; Up
    dw $0025, $0026, $0027, $0025, $0028, $0029 ; Down
    dw $002A, $002B, $002C, $002A, $002B, $002C ; Left
    dw $002D, $002E, $002F, $002D, $002E, $002F ; Right

    ; Poking with sword
    dw $0031, $0030, $0032 ; Up
    dw $0034, $0033, $0034 ; Down
    dw $0036, $0035, $0037 ; Left
    dw $0039, $0038, $003A ; Right

    ; Falling
    dw $003B, $003C, $003D, $003E, $003E, $003E

    ; Landing in underworld
    dw $0000, $000D, $0005, $000A

    ; Bonk
    dw $003F ; Up
    dw $0040 ; Down
    dw $0041 ; Left
    dw $0042 ; Right

    ; Hammer
    ; Rods
    dw $0043, $0044, $0045 ; Up
    dw $0046, $0047, $0048 ; Down
    dw $0049, $004A, $004B ; Left
    dw $004C, $004D, $004E ; Right

    ; Bow
    dw $0000, $0021, $0074 ; Up
    dw $0005, $0075, $0076 ; Down
    dw $002A, $001A, $0077 ; Left
    dw $002D, $001E, $0078 ; Right

    ; Boomerang
    dw $00A3, $00A4 ; Up
    dw $00A5, $00A6 ; Down
    dw $00A7, $001A ; Left
    dw $00A8, $001E ; Right

    ; Tall grass
    dw $0000, $00CE, $00CF, $0000, $00A2, $0024 ; Up
    dw $0005, $00D0, $00D1, $0005, $00D2, $00D3 ; Down
    dw $000A, $00D4, $00D5, $000A, $00D4, $00D5 ; Left
    dw $000D, $00D6, $00D7, $000D, $00D6, $00D7 ; Right

    ; Desert prayer
    dw $007D, $007E, $007F, $0080

    ; Shovel
    dw $0053, $0054, $0055 ; Left
    dw $0056, $0057, $0058 ; Right

    ; Walk carrying item
    dw $0059, $005A, $005B, $0059, $005C, $005D ; Up
    dw $005E, $005F, $0060, $005E, $0061, $0062 ; Down
    dw $0063, $0064, $0065, $0063, $0064, $0065 ; Left
    dw $0066, $0067, $0068, $0066, $0067, $0068 ; Right

    ; Throwing item
    ; Seems walk cycle based too
    dw $0020, $0021, $0022, $0020, $0023, $0024 ; Up
    dw $0025, $0026, $0027, $0025, $0028, $0029 ; Down
    dw $002A, $002B, $002C, $002A, $002B, $002C ; Left
    dw $002D, $002E, $002F, $002D, $002E, $002F ; Right

    ; Spin attack
    dw $0069, $006A, $006B, $006B, $006C, $006C, $006D, $006D
    dw $000D, $000D, $006E, $006F, $0070, $0071, $0072, $0073

    ; Lifting item
    dw $00D8, $00D9, $00D9 ; Up
    dw $00DA, $00DB, $00DB ; Down
    dw $00DC, $00DD, $00DD ; Left
    dw $00DE, $00DF, $00DF ; Right

    ; Treading water
    dw $008E, $008F ; Up
    dw $0090, $0091 ; Down
    dw $0092, $0093 ; Left
    dw $0094, $0095 ; Right

    ; Fast swim
    dw $0098, $0096, $0097, $0096 ; Up
    dw $009B, $0099, $009A, $0099 ; Down
    dw $009E, $009C, $009D, $009C ; Left
    dw $00A1, $009F, $00A0, $009F ; Right

    ; Slow swim
    dw $0096, $0097, $0098 ; Up
    dw $0099, $009A, $009B ; Down
    dw $009C, $009D, $009E ; Left
    dw $009F, $00A0, $00A1 ; Right

    ; Zap
    dw $00AB, $00AB, $00AC, $00AC ; Up
    dw $00A9, $00A9, $00AA, $00AA ; Down
    dw $00AB, $00AB, $00AC, $00AC ; Left
    dw $00A9, $00A9, $00AA, $00AA ; Right

    ; Medallion spin
    dw $0025, $002A, $0020, $002D

    ; Ether
    dw $006B, $00AD, $00AD, $00AD

    ; Bombos
    dw $006B, $00CB, $00CB, $00CB, $00CB
    dw $00CC, $00CC, $00CC, $00A6, $00A6

    ; Quake
    dw $006B, $00CB, $005E, $00CD, $00CD

    ; Pushing
    ; Last item seems unused?
    dw $00E0, $00E1, $00E2, $00E0, $00E3, $00E4 ; Up
    dw $00E5, $00E6, $00E7, $00E5, $00E8, $00E9 ; Down
    dw $00EA, $00EB, $00EC, $00EA, $00EB, $00EC ; Left
    dw $00ED, $00EE, $00EF, $00ED, $00EE, $00EF ; Right

    ; Pull switch down
    dw $0101, $0117, $0117, $0117, $0117

    ; Pull switch up
    dw $00F0, $00F1, $00FF, $005E

    ; Ped pull
    dw $00DB, $00FF

    ; Grabbing
    dw $0101, $0117, $0117, $0117 ; Up
    dw $0104, $0118, $0118, $0118 ; Down
    dw $0107, $0119, $0119, $0119 ; Left
    dw $010A, $011A, $011A, $011A ; Right

    ; Walking up spiral stairs
    dw $00F5, $00F6, $00F7 ; Lower
    dw $00F2, $00F3, $00F4 ; Higher

    ; Walking down spiral stairs
    dw $00FB, $00FC, $00FD ; Higher
    dw $00F8, $00F9, $00FA ; Lower

    ; Death
    dw $0005, $000A, $0000, $000D, $0110, $0111

    ; Unused? arm swing
    dw $0000, $0021, $0074 ; Up
    dw $0005, $0075, $0076 ; Down
    dw $002A, $001A, $0077 ; Left
    dw $002D, $001E, $0078 ; Right

    ; Item gets
    dw $0112 ; Normal
    dw $0113 ; Crystal/triforce

    ; Sleep
    dw $0114, $0115

    ; Hookshot
    dw $0012 ; Up
    dw $0016 ; Down
    dw $001A ; Left
    dw $001E ; Right

    ; Bunny walk
    ; First frame used for standing still
    dw $011B, $011C, $011B, $011D ; Up
    dw $011E, $011F, $011E, $0120 ; Down
    dw $0121, $0122, $0121, $0122 ; Left
    dw $0123, $0124, $0123, $0124 ; Right

    ; Cane
    dw $006F, $0125, $0126 ; Up
    dw $006A, $00CB, $0048 ; Down
    dw $0071, $0063, $001A ; Left
    dw $0127, $0066, $001E ; Right

    ; Net
    dw $0069 ; This first pose is unreachable
    dw $00CB, $006B, $000A, $000A, $006D
    dw $006D, $000D, $000D, $0070, $0072, $006E

    ; Sword up
    dw $00CB

    ; Book
    dw $0129

    ; Tree pull
    dw $012B, $012C, $012D, $012E, $003F

    ; Sword slash
    dw $0010, $0010, $004F, $004F, $0126, $0050, $0126, $0013, $0013 ; Up
    dw $0014, $0014, $0015, $0015, $0051, $0052, $0051, $0017, $0017 ; Down
    dw $0018, $0018, $0019, $0082, $0083, $0084, $0085, $0086, $0086 ; Left
    dw $001C, $001C, $001D, $0079, $007A, $007B, $007C, $0081, $0081 ; Right
}

; ==============================================================================

; $0689F9-$0D8A74 DATA
PlayerOam_Aux1GFXIndex:
{
    ; Falling
    db $00, $FF, $FF, $02, $03, $04, $FF

    ; Landing in underworld
    db $FF, $FF, $FF

    ; Lifting item
    db $FF, $15, $17 ; Up
    db $FF, $15, $17 ; Down
    db $FF, $16, $18 ; Left
    db $FF, $15, $17 ; Right

    ; Fast swim
    db $13, $0B, $0F, $FF ; Up
    db $11, $09, $0D, $FF ; Down
    db $09, $12, $0D, $FF ; Left
    db $0A, $11, $0F, $FF ; Right

    ; Medallion spin
    db $FF, $FF, $FF, $FF

    ; Ether
    db $FF, $FF, $FF, $FF

    ; Bombos
    db $FF, $FF, $FF, $04, $03
    db $FF, $FF, $FF, $FF, $FF

    ; Quake
    db $FF, $FF, $FF, $FF, $FF

    ; Pull switch down
    db $FF, $17, $17, $FF, $FF

    ; Pull switch up
    db $FF, $FF, $FF, $FF

    ; Ped pull
    db $FF, $FF

    ; Grabbing
    db $FF, $17, $17, $FF ; Up
    db $FF, $15, $15, $FF ; Down
    db $FF, $18, $18, $FF ; Left
    db $FF, $17, $17, $FF ; Right

    ; Sword slash
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $1A, $1A, $1A, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $19, $19, $19, $FF, $FF ; Right
}

; ==============================================================================

; $0D8A75-$068AF0 DATA
PlayerOam_Aux2GFXIndex:
{
    ; Falling
    db $01, $FF, $FF, $FF, $FF, $FF, $FF

    ; Landing in underworld
    db $FF, $FF, $FF

    ; Lifting item
    db $FF, $16, $18 ; Up
    db $FF, $16, $18 ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Fast swim
    db $14, $0C, $10, $FF ; Up
    db $12, $0A, $0E, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Medallion spin
    db $FF, $FF, $FF, $FF

    ; Ether
    db $FF, $FF, $FF, $FF

    ; Bombos
    db $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF

    ; Quake
    db $FF, $FF, $FF, $FF, $FF

    ; Pull switch down
    db $FF, $18, $18, $FF, $FF

    ; Pull switch up
    db $FF, $FF, $FF, $FF

    ; Ped pull
    db $FF, $FF

    ; Grabbing
    db $FF, $18, $18, $FF ; Up
    db $FF, $16, $16, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Sword slash
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Right
}

; ==============================================================================

; $068AF1-$068CEF DATA
PlayerOam_WeaponGFXIndex:
{
    ; Walking
    ; Charging dash
    ; Index 0 used for standing still
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Powder
    db $01, $05, $0E, $1A, $06, $08, $10, $14, $00 ; Up
    db $00, $02, $0D, $19, $07, $0B, $13, $17, $01 ; Down
    db $06, $08, $10, $14, $00, $02, $0D, $19, $07 ; Left
    db $06, $0A, $12, $16, $01, $04, $0F, $1B, $07 ; Right

    ; Walking with sword out
    db $0A, $0A, $0A, $0A, $0A, $0A ; Up
    db $09, $09, $09, $09, $09, $09 ; Down
    db $00, $00, $00, $00, $00, $00 ; Left
    db $01, $01, $01, $01, $01, $01 ; Right

    ; Poking with sword
    db $06, $0A, $06 ; Up
    db $07, $09, $07 ; Down
    db $00, $00, $00 ; Left
    db $01, $01, $01 ; Right

    ; Falling
    db $FF, $FF, $FF, $FF, $FF, $FF

    ; Landing in underworld
    db $FF, $FF, $FF, $FF

    ; Bonk
    db $08 ; Up
    db $0A ; Down
    db $0A ; Left
    db $08 ; Right

    ; Hammer
    ; Rods
    db $20, $1D, $21 ; Up
    db $1D, $22, $1E ; Down
    db $1F, $25, $26 ; Left
    db $1F, $23, $24 ; Right

    ; Bow
    db $2A, $27, $27 ; Up
    db $29, $28, $28 ; Down
    db $2C, $2A, $2A ; Left
    db $2D, $29, $29 ; Right

    ; Boomerang
    db $FF, $FF ; Up
    db $FF, $FF ; Down
    db $FF, $FF ; Left
    db $FF, $FF ; Right

    ; Tall grass
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Desert prayer
    db $FF, $FF, $FF, $FF

    ; Shovel
    db $31, $31, $32 ; Left
    db $2F, $2F, $30 ; Right

    ; Walk carrying item
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Throwing item
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Spin attack
    db $0A, $08, $05, $04, $0B, $09, $02, $03
    db $08, $0A, $09, $0B, $04, $05, $03, $02

    ; Lifting item
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Treading water
    db $FF, $FF ; Up
    db $FF, $FF ; Down
    db $FF, $FF ; Left
    db $FF, $FF ; Right

    ; Fast swim
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Slow swim
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Zap
    db $FF, $00, $03, $03 ; Up
    db $FF, $01, $05, $05 ; Down
    db $FF, $00, $03, $03 ; Left
    db $FF, $01, $05, $05 ; Right

    ; Medallion spin
    db $09, $02, $06, $04

    ; Ether
    db $04, $0A, $06, $06

    ; Bombos
    db $0A, $06, $08, $08, $08
    db $01, $04, $0F, $0B, $07

    ; Quake
    db $04, $0A, $06, $07, $1C

    ; Pushing
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Pull switch down
    db $FF, $FF, $FF, $FF, $FF

    ; Pull switch up
    db $FF, $FF, $FF, $FF

    ; Ped pull
    db $FF, $FF

    ; Grabbing
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Walking up spiral stairs
    db $FF, $FF, $FF ; Lower
    db $FF, $FF, $FF ; Higher

    ; Walking down spiral stairs
    db $FF, $FF, $FF ; Higher
    db $FF, $FF, $FF ; Lower

    ; Death
    db $FF, $FF, $FF, $FF, $FF, $FF

    ; Unused? arm swing
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Item gets
    db $FF ; Normal
    db $FF ; Crystal/triforce

    ; Sleep
    db $FF, $FF

    ; Hookshot
    db $33 ; Up
    db $34 ; Down
    db $35 ; Left
    db $36 ; Right

    ; Bunny walk
    ; First frame used for standing still
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Cane
    db $44, $44, $46 ; Up
    db $44, $44, $43 ; Down
    db $47, $44, $4A ; Left
    db $49, $45, $48 ; Right

    ; Net
    db $37
    db $37, $38, $39, $3A, $3B
    db $3C, $3D, $3E, $3F, $40, $41

    ; Sword up
    db $06

    ; Book
    db $4B

    ; Tree pull
    db $FF, $FF, $FF, $FF, $FF

    ; Sword slash
    db $01, $05, $0E, $1A, $0A, $06, $08, $10, $14 ; Up
    db $00, $02, $0D, $19, $09, $07, $0B, $13, $17 ; Down
    db $06, $08, $10, $14, $03, $00, $02, $0D, $19 ; Left
    db $06, $0A, $12, $16, $05, $01, $04, $0F, $1B ; Right
}

; ==============================================================================

; $068CF0-$068EEE DATA
PlayerOam_ShieldGFXIndex:
{
    ; Walking
    ; Charging dash
    ; Index 0 used for standing still
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; Up
    db $00, $00, $00, $00, $00, $00, $00, $00, $00 ; Down
    db $03, $03, $03, $03, $03, $03, $03, $03, $03 ; Left
    db $02, $02, $02, $02, $02, $02, $02, $02, $02 ; Right

    ; Powder
    db $00, $00, $00, $00, $02, $02, $02, $02, $02 ; Up
    db $01, $01, $01, $01, $03, $03, $03, $03, $03 ; Down
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; Left
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; Right

    ; Walking with sword out
    db $02, $02, $02, $02, $02, $02 ; Up
    db $03, $03, $03, $03, $03, $03 ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Poking with sword
    db $02, $02, $02 ; Up
    db $03, $03, $03 ; Down
    db $01, $01, $01 ; Left
    db $01, $01, $01 ; Right

    ; Falling
    db $FF, $FF, $FF, $FF, $FF, $FF

    ; Landing in underworld
    db $FF, $FF, $FF, $FF

    ; Bonk
    db $01 ; Up
    db $00 ; Down
    db $01 ; Left
    db $01 ; Right

    ; Hammer
    ; Rods
    db $02, $02, $02 ; Up
    db $03, $03, $03 ; Down
    db $01, $01, $01 ; Left
    db $01, $01, $01 ; Right

    ; Bow
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Boomerang
    db $01, $02 ; Up
    db $00, $03 ; Down
    db $03, $01 ; Left
    db $02, $01 ; Right

    ; Tall grass
    db $01, $01, $01, $01, $01, $01 ; Up
    db $00, $00, $00, $00, $00, $00 ; Down
    db $03, $03, $03, $03, $03, $03 ; Left
    db $02, $02, $02, $02, $02, $02 ; Right

    ; Desert prayer
    db $FF, $FF, $FF, $FF

    ; Shovel
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Walk carrying item
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Throwing item
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Spin attack
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

    ; Lifting item
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Treading water
    db $FF, $FF ; Up
    db $FF, $FF ; Down
    db $FF, $FF ; Left
    db $FF, $FF ; Right

    ; Fast swim
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Slow swim
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Zap
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Medallion spin
    db $00, $03, $01, $02

    ; Ether
    db $00, $00, $00, $00

    ; Bombos
    db $00, $00, $00, $00, $00
    db $03, $03, $03, $03, $03

    ; Quake
    db $00, $00, $03, $00, $00

    ; Pushing
    db $FF, $FF, $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF ; Right

    ; Pull switch down
    db $FF, $FF, $FF, $FF, $FF

    ; Pull switch up
    db $FF, $FF, $FF, $FF

    ; Ped pull
    db $FF, $FF

    ; Grabbing
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Walking up spiral stairs
    db $FF, $FF, $FF ; Lower
    db $FF, $FF, $FF ; Higher

    ; Walking down spiral stairs
    db $FF, $FF, $FF ; Higher
    db $FF, $FF, $FF ; Lower

    ; Death
    db $FF, $FF, $FF, $FF, $FF, $FF

    ; Unused? arm swing
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Item gets
    db $03 ; Normal
    db $FF ; Crystal/triforce

    ; Sleep
    db $FF, $FF

    ; Hookshot
    db $02 ; Up
    db $03 ; Down
    db $FF ; Left
    db $FF ; Right

    ; Bunny walk
    ; First frame used for standing still
    db $FF, $FF, $FF, $FF ; Up
    db $FF, $FF, $FF, $FF ; Down
    db $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF ; Right

    ; Cane
    db $FF, $FF, $FF ; Up
    db $FF, $FF, $FF ; Down
    db $FF, $FF, $FF ; Left
    db $FF, $FF, $FF ; Right

    ; Net
    db $FF
    db $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF

    ; Sword up
    db $FF

    ; Book
    db $FF

    ; Tree pull
    db $FF, $FF, $FF, $FF, $FF

    ; Sword slash
    db $02, $02, $02, $02, $02, $02, $02, $02, $02 ; Up
    db $03, $03, $03, $03, $03, $03, $03, $03, $03 ; Down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Right
}

; ==============================================================================

; $068EEF-$0690ED DATA
LinkOAM_SwordOffsetY:
{
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db   9,   5,  -2,  -6,  -8,  -5,  -3,  -1,   9 ; Up
    db  11,  15,  13,  17,  19,  17,  15,  13,  11 ; Down
    db  -2,   2,   3,   4,  12,  15,  14,  19,  19 ; Left
    db  -2,   2,   3,   4,  12,  15,  14,  19,  19 ; Right

    db  -5,  -4,  -3,  -5,  -4,  -3 ; Up
    db  16,  17,  18,  16,  17,  18 ; Down
    db  13,  14,  15,  13,  14,  15 ; Left
    db  13,  14,  15,  13,  14,  15 ; Right

    db  -3,  -7,   2 ; Up
    db  12,  18,  16 ; Down
    db  15,  13,  10 ; Left
    db  15,  13,  10 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1,  -1

    db   2 ; Up
    db   3 ; Down
    db   6 ; Left
    db   6 ; Right

    db  -8,  -3,  -3 ; Up
    db  -3,  10,  18 ; Down
    db  -2,   2,  14 ; Left
    db  -2,   2,  14 ; Right

    db   5,   9,   9 ; Up
    db   9,  13,  13 ; Down
    db  10,   7,   7 ; Left
    db  10,   7,   7 ; Right

    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1

    db  10,  11,  -4 ; Left
    db  10,  11,  -4 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -4,  -8,   6,  15,  18,  18,  14,   6
    db  -7,  -7,  14,  17,  16,   8,   5,  12

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1,   8,   6,  10 ; Up
    db  -1,   8,   6,  10 ; Down
    db  -1,   8,   6,  10 ; Left
    db  -1,   8,   6,  10 ; Right

    db  16,  16,  -5,  16

    db  13,  -4,  -5,  -5

    db  -1,  -5,  -5,  -5,  -5
    db  11,  15,  13,  17,  19

    db  13,  -3,  -7,  18,  18

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1,  -1

    db  -1,  -1

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1 ; Lower
    db  -1,  -1,  -1 ; Higher

    db  -1,  -1,  -1 ; Higher
    db  -1,  -1,  -1 ; Lower

    db  -1,  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1 ; Normal
    db  -1 ; Crystal/triforce

    db  -1,  -1

    db   2 ; Up
    db  17 ; Down
    db  12 ; Left
    db  12 ; Right

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db   5,  -2,  -9 ; Up
    db  -7,  -2,  16 ; Down
    db   2,  -2,  12 ; Left
    db   2,  -2,  12 ; Right

    db  -4
    db  -5,   4,  14,  20,  15
    db   8,  -3,  -8,  14,  -3,  15

    db  -5

    db   0

    db  -1,  -1,  -1,  -1,  -1

    db   9,   5,  -3,  -9, -11, -15,  -9,  -4,   0 ; Up
    db  11,  14,  12,  17,  19,  23,  17,  15,  13 ; Down
    db  -2,  -1,   0,   0,   9,  12,  16,  16,  19 ; Left
    db  -2,  -1,   0,   0,   9,  12,  16,  16,  19 ; Right
}

; ==============================================================================

; $0690EE-$0692ED DATA
LinkOAM_SwordOffsetX:
{
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  11,  10,   6,   2,   0,  -4, -10, -13, -15 ; Up
    db  -8,  -6,  -5,  -3,   8,  12,  10,  14,  15 ; Down
    db   3,  -2,  -7, -11, -14, -11,  -9,  -7,   3 ; Left
    db   5,  10,   7,  11,  14,  11,   9,   7,   5 ; Right

    db   0,   0,   0,   0,   0,   0 ; Up
    db   7,   7,   7,   7,   7,   7 ; Down
    db -10, -10, -10, -10, -10, -10 ; Left
    db  10,  10,  10,  10,  10,  10 ; Right

    db  -3,   2,  -3 ; Up
    db  10,   7,  10 ; Down
    db -12, -16,  -8 ; Left
    db  12,  16,   8 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1,  -1

    db  -4 ; Up
    db  12 ; Down
    db   8 ; Left
    db   0 ; Right

    db  -2,  -2,  -2 ; Up
    db  10,  10,   9 ; Down
    db   1, -10, -11 ; Left
    db   7,  10,  11 ; Right

    db  -2,  -5,  -5 ; Up
    db   9,   2,   2 ; Down
    db  -2,  -3,  -3 ; Left
    db   2,  11,  11 ; Right

    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1

    db  -3,  -7,   8 ; Left
    db   3,   7,   0 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  13,   6,  14,  14,   8,  -1, -14, -14
    db  -1,   9,  -5,   3,  10,  13, -11, -12

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1, -14, -13, -12 ; Up
    db  -1,  14,  13,  12 ; Down
    db  -1, -14, -13, -12 ; Left
    db  -1,  14,  13,  12 ; Right

    db   7,  -9,   0,   9

    db  14,  14,  10,  10

    db  14,  11,   8,   8,   8
    db  15,  14,  12,  12,   8

    db  15,  14,  10,   4,   4

    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1,  -1

    db  -1,  -1

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db  -1,  -1,  -1 ; Lower
    db  -1,  -1,  -1 ; Higher

    db  -1,  -1,  -1 ; Higher
    db  -1,  -1,  -1 ; Lower

    db  -1,  -1,  -1,  -1,  -1,  -1

    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    db  -1 ; Normal
    db  -1 ; Crystal/triforce

    db  -1,  -1

    db   4 ; Up
    db   4 ; Down
    db  -7 ; Left
    db  15 ; Right

    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    db  -1,  -3,  -3 ; Up
    db   9,  12,   8 ; Down
    db  10,   3, -13 ; Left
    db -10,   5,  13 ; Right

    db  13
    db  13,  16,  11,   2, -11
    db -16,  -9,   0,   8,  -9, -11

    db  12

    db  -7

    db  -1,  -1,  -1,  -1,  -1

    db  11,   9,   7,   6,   3,  -1,  -5, -11, -14 ; Up
    db  -8,  -7,  -6,  -5,   5,   8,  12,  10,  14 ; Down
    db   3,  -2,  -8, -13, -16, -20, -15, -12,  -7 ; Left
    db   5,  10,   8,  13,  16,  20,  15,  12,   7 ; Right
}

; ==============================================================================

; $0692ED-$069368 DATA
PlayerOam_Aux1Offset_Y:
{
    ; Falling
    db   0,  -1,  -1,   8,   8,   8,  -1

    ; Landing in underworld
    db  -1,  -1,  -1

    ; Lifting item
    db  -1,   7,  10 ; Up
    db  -1,   5,   8 ; Down
    db  -1,   8,  12 ; Left
    db  -1,   8,  12 ; Right

    ; Fast swim
    db   2,   7,  13,  -1 ; Up
    db  20,  14,   7,  -1 ; Down
    db  20,  21,  20,  -1 ; Left
    db  20,  21,  20,  -1 ; Right

    ; Medallion spin
    db  -1,  -1,  -1,  -1

    ; Ether
    db  -1,  -1,  -1,  -1

    ; Bombos
    db  -1,  -1,  -1,  -8,  -8
    db  -1,  -1,  -1,  -1,  -1

    ; Quake
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch down
    db  -1,   5,  11,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,   5,  11,  -1 ; Up
    db  -1,   6,   1,  -1 ; Down
    db  -1,  13,  15,  -1 ; Left
    db  -1,  13,  15,  -1 ; Right

    ; Sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  12,  12,  12,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  12,  12,  12,  -1,  -1 ; Right
}

; ==============================================================================

; $069369-$0693E4 DATA
PlayerOam_Aux1Offset_X:
{
    ; Falling
    db   8,  -1,  -1,   4,   4,   4,  -1

    ; Landing in underworld
    db  -1,  -1,  -1

    ; Lifting item
    db  -1,  -7,  -9 ; Up
    db  -1,  -8, -10 ; Down
    db  -1,  13,  16 ; Left
    db  -1,  -5,  -8 ; Right

    ; Fast swim
    db  -2,  -6,  -5,  -1 ; Up
    db  -1,  -5,  -6,  -1 ; Down
    db  -3,   4,   9,  -1 ; Left
    db  11,   4,  -1,  -1 ; Right

    ; Medallion spin
    db  -1,  -1,  -1,  -1

    ; Ether
    db  -1,  -1,  -1,  -1

    ; Bombos
    db  -1,  -1,  -1,   4,   4
    db  -1,  -1,  -1,  -1,  -1

    ; Quake
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch down
    db  -1,  -5,  -8,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,  -5,  -8,  -1 ; Up
    db  -1,  -5,  -8,  -1 ; Down
    db  -1,  15,  17,  -1 ; Left
    db  -1,  -7,  -9,  -1 ; Right

    ; Sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -3,  -7,  -3,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  11,  15,  11,  -1,  -1 ; Right
}

; ==============================================================================

; $0693E5-$069460 DATA
PlayerOam_Aux2Offset_Y:
{
    ; Falling
    db  16,  -1,  -1,  -1,  -1,  -1,  -1

    ; Landing in underworld
    db  -1,  -1,  -1

    ; Lifting item
    db  -1,   7,  10 ; Up
    db  -1,   5,   8 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Fast swim
    db   2,   7,  13,  -1 ; Up
    db  20,  14,   7,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Medallion spin
    db  -1,  -1,  -1,  -1

    ; Ether
    db  -1,  -1,  -1,  -1

    ; Bombos
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1

    ; Quake
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch down
    db  -1,   5,  11,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,   5,  11,  -1 ; Up
    db  -1,   6,   1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Right
}

; ==============================================================================

; $069461-$0694DC DATA
PlayerOam_Aux2Offset_X:
{
    ; Falling
    db  -8,  -1,  -1,  -1,  -1,  -1,  -1

    ; Landing in underworld
    db  -1,  -1,  -1

    ; Lifting item
    db  -1,  15,  17 ; Up
    db  -1,  16,  18 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Fast swim
    db  10,  14,  13,  -1 ; Up
    db   9,  14,  14,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Medallion spin
    db  -1,  -1,  -1,  -1

    ; Ether
    db  -1,  -1,  -1,  -1

    ; Bombos
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1

    ; Quake
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch down
    db  -1,  13,  16,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,  13,  16,  -1 ; Up
    db  -1,  13,  16,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; Right
}

; ==============================================================================

; $0694DD-$0696DB DATA
PlayerOam_ShieldOffsetY:
{
    ; Walking
    ; Charging dash
    ; Index 0 used for standing still
    db   5,   5,   4,   3,   5,   5,   4,   3,   5 ; Up
    db   9,  10,   9,   7,   8,  10,   9,   7,   8 ; Down
    db   5,   5,   4,   3,   4,   5,   4,   3,   4 ; Left
    db   5,   5,   4,   3,   4,   5,   4,   3,   4 ; Right

    ; Powder
    db  12,  12,   8,   8,   6,   6,   6,   6,   6 ; Up
    db   1,   1,   3,   3,   7,   7,   7,   7,   7 ; Down
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; Left
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; Right

    ; Walking with sword out
    db   5,   6,   7,   5,   6,   7 ; Up
    db   6,   7,   8,   6,   7,   8 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Poking with sword
    db   7,   5,   7 ; Up
    db   7,   8,   7 ; Down
    db   5,   5,   5 ; Left
    db   5,   5,   5 ; Right

    ; Falling
    db  16,  -1,  -1,  -1,  -1,  -1

    ; Landing in underworld
    db  -1,  -1,  -1,  -1

    ; Bonk
    db   5 ; Up
    db   8 ; Down
    db   7 ; Left
    db   7 ; Right

    ; Hammer
    ; Rods
    db   6,   5,   5 ; Up
    db   7,   7,   7 ; Down
    db   5,   5,   5 ; Left
    db   5,   5,   5 ; Right

    ; Bow
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Boomerang
    db   6,   6 ; Up
    db  11,   7 ; Down
    db   4,   8 ; Left
    db   4,   8 ; Right

    ; Tall grass
    db   4,   5,   6,   4,   5,   6 ; Up
    db  10,  11,  12,  10,  11,  12 ; Down
    db   5,   6,   7,   5,   6,   7 ; Left
    db   5,   6,   7,   5,   6,   7 ; Right

    ; Desert prayer
    db  -1,  -1,  -1,  -1

    ; Shovel
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Walk carrying item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Throwing item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Spin attack
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1

    ; Lifting item
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Treading water
    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    ; Fast swim
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Slow swim
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Zap
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Medallion spin
    db  10,   5,   4,   5

    ; Ether
    db  10,  10,  10,  10

    ; Bombos
    db  10,  10,  10,  10,  10
    db   7,   7,   7,   7,   7

    ; Quake
    db  10,  10,   1,  10,  10

    ; Pushing
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Pull switch down
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Walking up spiral stairs
    db  -1,  -1,  -1 ; Lower
    db  -1,  -1,  -1 ; Higher

    ; Walking down spiral stairs
    db  -1,  -1,  -1 ; Higher
    db  -1,  -1,  -1 ; Lower

    ; Death
    db  -1,  -1,  -1,  -1,  -1,  -1

    ; Unused? arm swing
    db   5,   5,   5 ; Up
    db   7,   7,   7 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Item gets
    db   9 ; Normal
    db  -1 ; Crystal/triforce

    ; Sleep
    db  -1,  -1

    ; Hookshot
    db   5 ; Up
    db   7 ; Down
    db  -1 ; Left
    db  -1 ; Right

    ; Bunny walk
    ; First frame used for standing still
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Cane
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Net
    db  -1
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1

    ; Sword up
    db  -1

    ; Book
    db  -1

    ; Tree pull
    db  -1,  -1,  -1,  -1,  -1

    ; Sword slash
    db   8,   8,   6,   6,   4,   2,   5,   6,   6 ; Up
    db   1,   1,   4,   4,   6,   8,   6,   6,   6 ; Down
    db   4,   4,   4,   4,   4,   4,   4,   4,   4 ; Left
    db   4,   4,   4,   4,   4,   4,   4,   4,   4 ; Right
}

; ==============================================================================

; $0696DC-$0698DB DATA
PlayerOam_ShieldOffsetX:
{
    ; Walking
    ; Charging dash
    ; Index 0 used for standing still
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; Up
    db  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4 ; Down
    db  -8,  -8,  -8,  -8,  -8,  -8,  -8,  -8,  -8 ; Left
    db   8,   8,   8,   8,   8,   8,   8,   8,   8 ; Right

    ; Powder
    db   6,   6,   8,   8,  10,  10,  10,  10,  10 ; Up
    db  -5,  -5,  -7,  -7, -10, -10, -10, -10, -10 ; Down
    db   1,   1,   1,   1,   0,   0,   0,   0,   0 ; Left
    db  -1,  -1,  -1,  -1,   0,   0,   0,   0,   0 ; Right

    ; Walking with sword out
    db   9,   9,   9,   9,   9,   9 ; Up
    db  -9,  -9,  -9,  -9,  -9,  -9 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Poking with sword
    db  10,  10,  10 ; Up
    db -10, -10, -10 ; Down
    db   0,  -1,   0 ; Left
    db   0,   1,   0 ; Right

    ; Falling
    db  -4,  -1,  -1,  -1,  -1,  -1

    ; Landing in underworld
    db  -1,  -1,  -1,  -1

    ; Bonk
    db   8 ; Up
    db  -4 ; Down
    db   2 ; Left
    db  -3 ; Right

    ; Hammer
    ; Rods
    db   9,   9,   9 ; Up
    db -10, -10, -10 ; Down
    db   0,   0,   0 ; Left
    db   0,   0,   0 ; Right

    ; Bow
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Boomerang
    db   5,   9 ; Up
    db  -4, -10 ; Down
    db   0,   0 ; Left
    db   8,   0 ; Right

    ; Tall grass
    db   5,   5,   5,   5,   5,   5 ; Up
    db  -4,  -4,  -4,  -4,  -4,  -4 ; Down
    db  -8,  -8,  -8,  -8,  -8,  -8 ; Left
    db   8,   8,   8,   8,   8,   8 ; Right

    ; Desert prayer
    db  -1,  -1,  -1,  -1

    ; Shovel
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Walk carrying item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Throwing item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Spin attack
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1

    ; Lifting item
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Treading water
    db  -1,  -1 ; Up
    db  -1,  -1 ; Down
    db  -1,  -1 ; Left
    db  -1,  -1 ; Right

    ; Fast swim
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Slow swim
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Zap
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Medallion spin
    db  -4,  -8,   5,   8

    ; Ether
    db  -4,  -4,  -4,  -4

    ; Bombos
    db  -5,  -5,  -5,  -5,  -5
    db -10, -10, -10, -10, -10

    ; Quake
    db  -5,  -5,  -7,  -4,  -4

    ; Pushing
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; Right

    ; Pull switch down
    db  -1,  -1,  -1,  -1,  -1

    ; Pull switch up
    db  -1,  -1,  -1,  -1

    ; Ped pull
    db  -1,  -1

    ; Grabbing
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Walking up spiral stairs
    db  -1,  -1,  -1 ; Lower
    db  -1,  -1,  -1 ; Higher

    ; Walking down spiral stairs
    db  -1,  -1,  -1 ; Higher
    db  -1,  -1,  -1 ; Lower

    ; Death
    db  -1,  -1,  -1,  -1,  -1,  -1

    ; Unused? arm swing
    db   9,   9,   9 ; Up
    db -10, -10, -10 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Item gets
    db  -6 ; Normal
    db  -1 ; Crystal/triforce

    ; Sleep
    db  -1,  -1

    ; Hookshot
    db  10 ; Up
    db -10 ; Down
    db  -1 ; Left
    db  -1 ; Right

    ; Bunny walk
    ; First frame used for standing still
    db  -1,  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1,  -1 ; Right

    ; Cane
    db  -1,  -1,  -1 ; Up
    db  -1,  -1,  -1 ; Down
    db  -1,  -1,  -1 ; Left
    db  -1,  -1,  -1 ; Right

    ; Net
    db  -1
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1

    ; Sword up
    db  -1

    ; Book
    db  -1

    ; Tree pull
    db  -1,  -1,  -1,  -1,  -1

    ; Sword slash
    db  10,  10,  10,  10,  10,  10,  10,  10,  10 ; Up
    db  -9,  -9,  -9,  -9, -10, -10, -10, -10, -10 ; Down
    db   1,   1,   1,   2,   2,   2,   1,   2,   2 ; Left
    db  -1,  -1,  -1,  -2,  -2,  -2,  -1,  -2,  -2 ; Right
}

; ==============================================================================

; $0698DB-$0698E6 DATA
PlayerOam_ShadowOffset_Y:
{
    db  16,  16,  17,  17
    db  16,  16,  16,  16
    db  18,  18,  18,  18
}

; ==============================================================================

; $0698E7-$0698F2 DATA
PlayerOam_ShadowOffset_X:
{
    db   0,   0,  -1,   1
    db   0,   0,   0,   0
    db   0,   0,   0,   0
}

; ==============================================================================
    
; $0698F3-$069AF1
AttackHitboxOffset_Y:
{
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $09, $05, $FE, $FA
    db $F8, $FB, $FD, $07, $09, $0B, $0F, $15
    
    db $19, $1B, $19, $17, $0D, $0B, $FE, $02
    db $03, $0C, $0C, $0F, $16, $1B, $1B, $FE
    
    db $02, $03, $0C, $0C, $0F, $16, $1B, $1B
    db $FB, $FC, $FD, $FB, $FC, $FD, $18, $19
    
    db $1A, $18, $19, $1A, $0D, $0E, $0F, $0D
    db $0E, $0F, $0D, $0E, $0F, $0D, $0E, $0F
    
    db $FD, $F9, $02, $14, $1A, $18, $0A, $0D
    db $0F, $0A, $0D, $0F, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $F9, $FF, $FE, $FD, $0A, $1A
    
    db $FE, $03, $0E, $FE, $03, $0E, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $FC, $F8, $06, $0F
    
    db $1A, $1A, $0E, $06, $F9, $F9, $16, $1A
    db $10, $08, $05, $0C, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $18, $10, $FB, $10
    
    db $0D, $FC, $FB, $FB, $FF, $FB, $FB, $FB
    db $FB, $0B, $0F, $15, $19, $1B, $0D, $FD
    
    db $F9, $1A, $12, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $FC, $FB, $04, $0E, $14, $0F, $08, $FD
    
    db $F8, $0E, $FD, $0F, $80, $80, $80, $80
    db $80, $80, $80, $09, $05, $FD, $F7, $F5
    
    db $F1, $F7, $FC, $08, $0B, $0E, $14, $19
    db $1B, $1F, $19, $17, $0D, $FE, $FF, $00
    
    db $08, $09, $0C, $10, $18, $1E, $FE, $FF
    db $00, $08, $09, $0C, $10, $18, $1E
}

; $069AF2-$069CF0 DATA
AttackHitboxOffset_X:
{
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $13, $12, $0E, $0A
    db $00, $FC, $F6, $F3, $F1, $F8, $FA, $FB
    
    db $05, $08, $0C, $12, $16, $17, $03, $FE
    db $F9, $F5, $F2, $F5, $F7, $01, $03, $05
    
    db $0A, $0F, $13, $16, $13, $11, $07, $05
    db $00, $00, $00, $00, $00, $00, $07, $07
    
    db $07, $07, $07, $07, $F6, $F6, $F6, $F6
    db $F6, $F6, $12, $12, $12, $12, $12, $12
    
    db $FD, $02, $FD, $0A, $07, $0A, $F0, $E8
    db $EC, $10, $18, $14, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $FE, $FE, $FE, $0A, $0A, $0A
    
    db $01, $F6, $F5, $07, $12, $13, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $0D, $06, $16, $16
    
    db $08, $FF, $F2, $F2, $FF, $09, $FB, $03
    db $12, $15, $F5, $F4, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $07, $F7, $00, $11
    
    db $16, $0E, $0A, $0A, $0E, $0B, $08, $08
    db $08, $17, $16, $14, $0C, $08, $17, $0E
    
    db $0A, $0C, $0C, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $0D, $0D, $10, $0B, $02, $F5, $F0, $F7
    
    db $00, $0B, $F7, $F5, $80, $80, $80, $80
    db $80, $80, $80, $13, $11, $0F, $0E, $03
    
    db $FF, $FB, $F5, $F2, $F8, $F9, $FA, $03
    db $05, $08, $0C, $12, $16, $03, $FE, $F8
    
    db $F3, $F0, $EC, $F1, $F4, $01, $05, $0A
    db $10, $15, $18, $1C, $17, $14, $07
}

; Walking
; Charging dash
; Index 0 used for standing still
; $069CF1-$069EEF DATA
PlayerOam_Priority:
{
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $0A, $0A, $0A, $0A, $0A, $0A, $0A
    
    db $0A, $0A, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $03, $03, $03, $03
    db $03, $03, $03, $03, $01, $00, $00, $00
    
    db $00, $0B, $0B, $0B, $0B, $0B, $02, $02
    db $02, $02, $02, $02, $00, $00, $00, $02
    
    db $02, $02, $02, $02, $02, $00, $00, $00
    db $02, $02, $02, $02, $02, $02, $01, $01
    
    db $01, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    db $03, $03, $03, $06, $06, $06, $05, $05
    db $05, $05, $05, $05, $01, $01, $01, $01
    
    db $01, $01, $01, $01, $01, $01, $02, $03
    db $00, $00, $00, $03, $03, $06, $06, $06
    
    db $00, $00, $00, $00, $00, $00, $02, $02
    db $02, $00, $00, $00, $00, $00, $00, $00
    
    db $00, $00, $00, $03, $03, $03, $02, $00
    db $02, $00, $02, $02, $02, $02, $02, $02
    
    db $0A, $0A, $0A, $0A, $0A, $0A, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $03, $03, $03, $03, $01, $01
    db $02, $01, $01, $02, $04, $04, $04, $04
    
    db $04, $04, $03, $03, $03, $03, $03, $03
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $04, $04, $04, $04
    db $04, $04, $03, $03, $03, $03, $03, $03
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $05, $05
    
    db $05, $05, $05, $05, $02, $02, $05, $05
    db $05, $05, $02, $05, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    db $07, $07, $07, $07, $08, $08, $08, $08
    db $09, $09, $09, $09, $09, $09, $09, $09
    
    db $00, $00, $00, $07, $07, $07, $07, $07
    db $07, $07, $07, $07, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $02, $01
    
    db $01, $01, $01, $01, $01, $03, $03, $0A
    db $0A, $01, $01, $01, $01, $01, $01, $01
    
    db $01, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $01, $01, $02, $02
    db $03, $06, $05, $05, $02, $02, $02, $02
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $00, $00, $02, $02
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $02, $02, $00, $00, $00, $00, $00, $02
    
    db $02, $00, $02, $00, $05, $02, $00, $00
    db $00, $00, $00, $03, $03, $03, $03, $03
    
    db $03, $03, $03, $03, $00, $0B, $0B, $0B
    db $0B, $0B, $0B, $0B, $0B, $02, $02, $02
    
    db $02, $02, $00, $00, $00, $00, $02, $02
    db $02, $02, $02, $00, $00, $00, $00
}

; $069EF0-$06A02F DATA
PlayerOam_AnimationStepDataOffsets:
{
    ; Up
    dw $0000 ; 0x00 - Walking
    dw $0024 ; 0x01 - Powder duplicate unused?
    dw $0048 ; 0x02 - Sword out/Dashing
    dw $0060 ; 0x03 - Sword poke
    dw $006C ; 0x04 - Falling
    dw $0076 ; 0x05 - Bonking/Recoil
    dw $007A ; 0x06 - Rods/Hammer
    dw $0086 ; 0x07 - Bow
    dw $0024 ; 0x08 - Powder
    dw $0092 ; 0x09 - Boom
    dw $009A ; 0x0A - Sloshing/Stairs
    dw $00B2 ; 0x0B - Prayer
    dw $00B9 ; 0x0C - Shovel
    dw $00BC ; 0x0D - Carrying
    dw $00D4 ; 0x0E - Throwing
    dw $00EC ; 0x0F - Spin attack
    dw $00FC ; 0x10 - Lifting
    dw $0108 ; 0x11 - Treading water
    dw $0110 ; 0x12 - Stroked swimming
    dw $0120 ; 0x13 - Swimming
    dw $012C ; 0x14 - Zapped
    dw $013C ; 0x15 - Medallions
    dw $0153 ; 0x16 - Pushing
    dw $016B ; 0x17 - Switch pull
    dw $0176 ; 0x18 - Grabbing/Pulling
    dw $0186 ; 0x19 - Diagonally up stairs
    dw $018C ; 0x1A - Diagonally down stairs
    dw $0192 ; 0x1B - Spin and die
    dw $0198 ; 0x1C - Arm swing (unused?)
    dw $01A4 ; 0x1D - Item get
    dw $01A5 ; 0x1E - 2 handed item get
    dw $01A6 ; 0x1F - Sleeping
    dw $01A8 ; 0x20 - Hookshot
    dw $01AC ; 0x21 - Bunny
    dw $01BC ; 0x22 - Cane
    dw $01C8 ; 0x23 - Bug net
    dw $01D4 ; 0x24 - Sword up
    dw $01D5 ; 0x25 - Book
    dw $01D6 ; 0x26 - Tree pull
    dw $01DB ; 0x27 - Sword slash

    ; Down
    dw $0009 ; 0x00 - Walking
    dw $002D ; 0x01 - Powder duplicate unused?
    dw $004E ; 0x02 - Sword out/Dashing
    dw $0063 ; 0x03 - Sword poke
    dw $006C ; 0x04 - Falling
    dw $0077 ; 0x05 - Bonking/Recoil
    dw $007D ; 0x06 - Rods/Hammer
    dw $0089 ; 0x07 - Bow
    dw $002D ; 0x08 - Powder
    dw $0094 ; 0x09 - Boom
    dw $00A0 ; 0x0A - Sloshing/Stairs
    dw $00B2 ; 0x0B - Prayer
    dw $00B9 ; 0x0C - Shovel
    dw $00C2 ; 0x0D - Carrying
    dw $00DA ; 0x0E - Throwing
    dw $00EC ; 0x0F - Spin attack
    dw $00FF ; 0x10 - Lifting
    dw $010A ; 0x11 - Treading water
    dw $0114 ; 0x12 - Stroked swimming
    dw $0123 ; 0x13 - Swimming
    dw $0130 ; 0x14 - Zapped
    dw $013C ; 0x15 - Medallions
    dw $0159 ; 0x16 - Pushing
    dw $016B ; 0x17 - Switch pull
    dw $017A ; 0x18 - Grabbing/Pulling
    dw $0189 ; 0x19 - Diagonally up stairs
    dw $018F ; 0x1A - Diagonally down stairs
    dw $0192 ; 0x1B - Spin and die
    dw $019B ; 0x1C - Arm swing (unused?)
    dw $01A4 ; 0x1D - Item get
    dw $01A5 ; 0x1E - 2 handed item get
    dw $01A6 ; 0x1F - Sleeping
    dw $01A9 ; 0x20 - Hookshot
    dw $01B0 ; 0x21 - Bunny
    dw $01BF ; 0x22 - Cane
    dw $01C8 ; 0x23 - Bug net
    dw $01D4 ; 0x24 - Sword up
    dw $01D5 ; 0x25 - Book
    dw $01D6 ; 0x26 - Tree pull
    dw $01E4 ; 0x27 - Sword slash

    ; Left
    dw $0012 ; 0x00 - Walking
    dw $0036 ; 0x01 - Powder duplicate unused?
    dw $0054 ; 0x02 - Sword out/Dashing
    dw $0066 ; 0x03 - Sword poke
    dw $006C ; 0x04 - Falling
    dw $0078 ; 0x05 - Bonking/Recoil
    dw $0080 ; 0x06 - Rods/Hammer
    dw $008C ; 0x07 - Bow
    dw $0036 ; 0x08 - Powder
    dw $0096 ; 0x09 - Boom
    dw $00A6 ; 0x0A - Sloshing/Stairs
    dw $00B2 ; 0x0B - Prayer
    dw $00B6 ; 0x0C - Shovel
    dw $00C8 ; 0x0D - Carrying
    dw $00E0 ; 0x0E - Throwing
    dw $00EC ; 0x0F - Spin attack
    dw $0102 ; 0x10 - Lifting
    dw $010C ; 0x11 - Treading water
    dw $0118 ; 0x12 - Stroked swimming
    dw $0126 ; 0x13 - Swimming
    dw $0134 ; 0x14 - Zapped
    dw $013C ; 0x15 - Medallions
    dw $015F ; 0x16 - Pushing
    dw $016B ; 0x17 - Switch pull
    dw $017E ; 0x18 - Grabbing/Pulling
    dw $0186 ; 0x19 - Diagonally up stairs
    dw $018C ; 0x1A - Diagonally down stairs
    dw $0192 ; 0x1B - Spin and die
    dw $019E ; 0x1C - Arm swing (unused?)
    dw $01A4 ; 0x1D - Item get
    dw $01A5 ; 0x1E - 2 handed item get
    dw $01A6 ; 0x1F - Sleeping
    dw $01AA ; 0x20 - Hookshot
    dw $01B4 ; 0x21 - Bunny
    dw $01C2 ; 0x22 - Cane
    dw $01C8 ; 0x23 - Bug net
    dw $01D4 ; 0x24 - Sword up
    dw $01D5 ; 0x25 - Book
    dw $01D6 ; 0x26 - Tree pull
    dw $01ED ; 0x27 - Sword slash

    ; Right
    dw $001B ; 0x00 - Walking
    dw $003F ; 0x01 - Powder duplicate unused?
    dw $005A ; 0x02 - Sword out/Dashing
    dw $0069 ; 0x03 - Sword poke
    dw $006C ; 0x04 - Falling
    dw $0079 ; 0x05 - Bonking/Recoil
    dw $0083 ; 0x06 - Rods/Hammer
    dw $008F ; 0x07 - Bow
    dw $003F ; 0x08 - Powder
    dw $0098 ; 0x09 - Boom
    dw $00AC ; 0x0A - Sloshing/Stairs
    dw $00B2 ; 0x0B - Prayer
    dw $00B9 ; 0x0C - Shovel
    dw $00CE ; 0x0D - Carrying
    dw $00E6 ; 0x0E - Throwing
    dw $00EC ; 0x0F - Spin attack
    dw $0105 ; 0x10 - Lifting
    dw $010E ; 0x11 - Treading water
    dw $011C ; 0x12 - Stroked swimming
    dw $0129 ; 0x13 - Swimming
    dw $0138 ; 0x14 - Zapped
    dw $013C ; 0x15 - Medallions
    dw $0165 ; 0x16 - Pushing
    dw $016B ; 0x17 - Switch pull
    dw $0182 ; 0x18 - Grabbing/Pulling
    dw $0189 ; 0x19 - Diagonally up stairs
    dw $018F ; 0x1A - Diagonally down stairs
    dw $0192 ; 0x1B - Spin and die
    dw $01A1 ; 0x1C - Arm swing (unused?)
    dw $01A4 ; 0x1D - Item get
    dw $01A5 ; 0x1E - 2 handed item get
    dw $01A6 ; 0x1F - Sleeping
    dw $01AB ; 0x20 - Hookshot
    dw $01B8 ; 0x21 - Bunny
    dw $01C5 ; 0x22 - Cane
    dw $01C8 ; 0x23 - Bug net
    dw $01D4 ; 0x24 - Sword up
    dw $01D5 ; 0x25 - Book
    dw $01D6 ; 0x26 - Tree pull
    dw $01F6 ; 0x27 - Sword slash
}

; $06A030-$06A037 DATA
PlayerOam_AnimationDirectionalStepIndexOffset:
{ 
    ;     Up,  down,  left, right 
    dw $0000, $0050, $00A0, $00F0
}

; Falling, lifting item, swim, medallions, pull switch, grabbing, sword slashQ
; $06A038-$06A045 DATA
PlayerOam_AuxAnimationStepDataOffset:
{
    dw $0000, $000A, $0016, $0026, $003D, $0048, $0058 ; Up 

    dw $0000, $000D, $001A, $0026, $003D, $004C, $0061 ; Down 
    
    dw $0000, $0010, $001E, $0026, $003D, $0050, $006A ; Left 
    
    dw $0000, $0013, $0022, $0026, $003D, $0054, $0073 ; Right 
}

; $06A070-$06A077 DATA
PlayerOam_AuxAnimationDirectionalStepIndexOffset:
{
    dw $0000, $000E, $001C, $002A
}
    
; $06A078-$06A083 DATA
PlayerOam_Aux1BufferOffsets_SetA:
{
    db $00, $08, $00, $08, $08, $0C, $14, $08
    db $08, $00, $00, $00
}

; $06A084-$06A08F DATA
PlayerOam_Aux2BufferOffsets_SetA:
{
    db $04, $0C, $04, $0C, $0C, $10, $18, $0C
    db $0C, $0C, $04, $04
}

; $06A090-$06A09B DATA
PlayerOam_WeaponBufferOffsets_SetA:
{
    db $08, $10, $10, $18, $10, $00, $00, $10
    db $18, $10, $18, $10
}

; $06A09C-$06A0A7 DATA
PlayerOam_ElfBufferOffsets_SetA:
{
    db $14, $1C, $08, $10, $00, $14, $18, $00
    db $10, $04, $10, $1C
}

; $06A0A8-$06A0B3 DATA
PlayerOam_ShieldBufferOffsets_SetA:
{
    db $1C, $00, $1C, $00, $18, $1C, $0C, $1C
    db $24, $1C, $08, $08
}

; $06A0B4-$06A0BF
PlayerOam_ShadowBufferOffsets_SetA:
{
    db $28, $28, $28, $28, $28, $28, $28, $28
    db $00, $28, $28, $28
}

; $06A0C0-$06A0CC
PlayerOam_Aux1BufferOffsets_SetB:
{
    db $14, $1C, $08, $10, $10, $14, $1C, $10
    db $08, $08, $08, $14
}

; $06A0CC-$06A0D7
PlayerOam_Aux2BufferOffsets_SetB:
{
    db $18, $20, $0C, $14, $14, $18, $20, $14
    db $0C, $14, $0C, $18
}

; $06A0D8-$06A0E3
PlayerOam_WeaponBufferOffsets_SetB:
{
    db $00, $00, $18, $20, $18, $00, $00, $18
    db $18, $18, $20, $00
}

; $06A0E4-$060AEF
PlayerOam_ElfBufferOffsets_SetB:
{
    db $1C, $24, $10, $18, $08, $1C, $24, $08
    db $10, $0C, $18, $24
}

; $060AF0-$06A0FB
PlayerOam_ShieldBufferOffsets_SetB:
{
    db $24, $14, $24, $08, $20, $24, $14, $24
    db $24, $24, $10, $1C
}

; $06A0FC-$06A107
PlayerOam_ShadowBufferOffsets_SetB:
{
    db $0C, $0C, $00, $00, $00, $0C, $0C, $00
    db $00, $00, $00, $00
}

; $06A108-$06A11F DATA
PlayerOam_PlayerOam_Aux1BufferOffsetPointers:
{
    dw PlayerOam_Aux1BufferOffsets_SetA
    dw PlayerOam_Aux1BufferOffsets_SetB
}
    
; $06A10C-$06A10F DATA
PlayerOam_Aux2BufferOffsetPointers:
{
    dw $A084, $A0CC
}

; $06A110-$06A113 DATA
PlayerOam_WeaponBufferOffsetPointers:
{
    dw $A090, $A0D8
}

; $06A114-$06A117 DATA
PlayerOam_ElfBufferOffsetPointers:
{
    dw $A09C, $A0E4
}
    
; $06A118-$06A11B DATA
PlayerOam_ShieldBufferOffsetPointers:
{
    dw $A0A8, $A0F0
}
    
; $06A11C-$06A11F DATA
PlayerOam_ShadowBufferOffsetPointers:
{
    dw $A0B4, $A0FC
}

; $06A120-$06A125 DATA
LinkOAM_OAMBufferOffset:
{
    ; Two possible offsets into OAM buffer for player sprite.
    dw $0190, $00E0
    
    ; Another optional offset into the OAM buffer for the player sprite.
    dw $0000
}

; $06A126-$06A12D DATA
LinkOAM_ObjectPriority:
{
    dw $2000, $1000, $3000, $2000
}

; Has to do with fire rod and ice rod OAM handling...
; $06A12E-$06A130 DATA
PlayerOam_RodTypeID:
{
    db $02, $04, $04
}

; $06A131-$06A139 DATA
PlayerOam_StairsSomething:
{
    db $00, $01, $02, $00, $01, $02, $00, $01, $02
}

; Rod, hammer, n/a, n/a, bow, n/a, powder, boomerang
; $06A13A-$06A141 DATA
PlayerOam_ItemsAUseIndex:
{
    db $06, $06, $06, $06, $07, $07, $08, $09
}

; Shovel, unused prayer, hookshot, cane, net, book
; $06A142-$06A147 DATA
PlayerOam_ItemsBUseIndex:
{
    db $0C, $0B, $20, $22, $23, $25
}

; Methinks the 0x26 belongs to the previous array...?
; $06A148-$06A14F DATA
PlayerOam_WeirdGrabIndices:
{
    db $26, $0B, $0B, $0C, $0B, $0B, $0B, $0D
}

; Special poses to check for?
; $06A150-$06A15D DATA
PlayerOam_AnimationsWithAuxParts:
{
    dw $0004, $0010, $0012, $0015, $0017, $0018, $0027
}

; $06A15E-$06A18D
PlayerOam_StraightStairsYOffset:
{
    ; $06A15E
    dw  0, -2, -3,  0, -2, -3
    dw  0,  0,  0,  0,  0,  0
    
    ; $06A176
    dw  0, -2, -3,  0, -2, -3
    dw  0,  0,  0,  0,  0,  0
}
    
; $72 = 0x00 if not standing in water or grass, 0x02 otherwise
; $06A18E-$06AAC2 LONG JUMP LOCATION
PlayerOam_Main:
{
    PHB : PHK : PLB
    
    LDY.b #$00
    
    LDA.b $11 : CMP.b #$12 : BEQ .on_straight_interroom_staircase   
        LDY.b #$18
        
        ; Checks for submodules 0x12 and 0x13
        CMP.b #$13 : BNE .not_on_straight_interroom_staircase

    .on_straight_interroom_staircase

    STY.b $00
    
    LDA.b $20 : PHA
    LDA.b $21 : PHA
    
    LDY.b #$00
    
    LDA.w $0462 : AND.b #$04 : BEQ .is_straight_up_staircase
        LDY.b #$0C

    .is_straight_up_staircase

    TYA : CLC : ADC.b $00 : STA.b $00
    
    ; Link's frame index shouldn't be more than 5 on this kind of staircase.
    LDA.b $2E : CMP.b #$06 : BCC .frame_index_in_range
        LDA.b #$00

    .frame_index_in_range

    ASL : CLC : ADC.b $00 : TAY
    
    REP #$20
    
    ; Ultimately, we have determined an offset to be applied to the player's
    ; Y coordinate, just for the sake of sprite display. The value of the Y
    ; coordinate will be restored near the end of this routine.
    LDA.w PlayerOam_StraightStairsYOffset, Y : CLC : ADC.b $20 : STA.b $20
    
    SEP #$20

    .not_on_straight_interroom_staircase

    ; Assumes this is not submodule 0x12 or 0x13
    
    LDA.b $20 : SEC : SBC.b $E8 : STA.b $01
    LDA.b $22 : SEC : SBC.b $E2 : STA.b $00
    
    LDA.b #$80 : STA.b $45
                 STA.b $44
    
    LDX.b #$00
    
    ; Check if we need to draw grass or water around Link (he'd be standing in
    ; one of those).
    LDA.w $0351 : BEQ .not_in_water_or_grass
        LDX.b #$01

    .not_in_water_or_grass

    ; 0 or 1, eh?...
    TXA : ASL : STA.b $72
                STZ.b $73
    
    REP #$20
    
    ; Determine OAM priority from floor level the player is on (BG2 -> 0x2000,
    ; BG1 -> 0x1000, there's two other settings but not clear what they're used
    ; for).
    LDA.b $EE : AND.w #$00FF : ASL : TAX
    LDA.w PlayerOam_ObjectPriority, X : STA.b $64
    
    ; Check "sort sprites" setting (HM name).
    LDA.w $0FB3 : ASL : TAY
    
    ; "sort sprites" here serves as a selector for where in the OAM buffer we
    ; want to start entering in sprite data for the player. (0x0190 or 0x00E0)
    LDA.w PlayerOam_OAMBufferOffset, Y : STA.w $0352
    
    SEP #$20
    
    ; Is Link asleep in bed (starting sequence)?
    LDA.b $5D : CMP.b #$16 : BNE .notInBed
        LDY.b #$1F
        
        LDA.w $037D : CMP.b #$02 : BEQ .notInBed
            STA.b $02
            
            BRL .PlayerOam_ContinueWithAnimation

    .notInBed

    LDA.w $03EF : BEQ .notHoldingUpSword
        LDY.b #$24
        
        STZ.b $02
        
        LDA.b $2F : STA.w $0323
        
        BRL .PlayerOam_ContinueWithAnimation

    .notHoldingUpSword

    LDA.w $02E0 : BEQ .not_transforming
        LDY.b #$21
        
        LDA.b $2E : AND.b #$03 : STA.b $02
        
        LDA.b $2F : STA.w $0323
        
        BRL .PlayerOam_ContinueWithAnimation

    .not_transforming

    LDY.b #$00
    
    LDA.w $0351 : BEQ .not_in_water_or_grass_2
        LDY.b #$0A

    .not_in_water_or_grass_2

    LDA.b $11 : CMP.b #$0E : BNE .BRANCH_MU
        ; Is the player dead / dying?
        LDA.b $10 : CMP.b #$12 : BEQ .BRANCH_MU
            LDY.b #$0A
            
            LDA.b $28 : BEQ .BRANCH_MU
                LDX.b $2F : CPX.b #$04 : BEQ .facing_left_or_right
                            CPX.b #$06 : BEQ .facing_left_or_right
                    LDX.b $2E
                    LDA.w PlayerOam_StairsSomething, X : STA.b $02
                    
                    LDY.b #$19
                    
                    LDA.w $0462 : AND.b #$04 : BEQ .is_up_spiral_staircase
                        LDY.b #$1A
                        
                        BRA .BRANCH_XI

    .BRANCH_MU

    LDA.w $0376 : AND.b #$03 : BEQ .notGrabbingWall
        LDY.b #$18
        
        LDA.w $030A : STA.b $02
        
        BRA .BRANCH_XI

    .notGrabbingWall

    LDA.b $48 : AND.b #$0D : BEQ .not_feeling_grabby
        LDY.b #$16
        
        LDA.b $2E : CMP.b #$05 : BCC .not_feeling_grabby
            STZ.b $2E

    .not_feeling_grabby
    .facing_left_or_right

    LDA.b $2E : STA.b $02

    .is_up_spiral_staircase
    .BRANCH_XI

    LDA.b $2F : STA.w $0323
    
    LDA.w $0345 : BEQ .not_in_deep_water
        ; Force to priority level 2 if we're in deep water.
        LDA.b #$20 : STA.b $65
                     STZ.b $64

    .not_in_deep_water

    LDA.b $5D : CMP.b #$04 : BNE .not_swimming
        LDY.b #$11
        
        LDA.b $02 : AND.b #$01 : STA.b $02
        
        LDA.b $11 : BNE .skip_stroke_check
            ; Check previous button presses.
            LDA.b $F0 : AND.b #$0F : BNE .swim_strokes

        .skip_stroke_check

        LDA.w $033C : ORA.w $033D : ORA.w $033E : ORA.w $033F : BEQ .no_swim_accel
            .swim_strokes

            LDY.b #$13
            
            LDA.w $02CC : STA.b $02

        .no_swim_accel

        LDA.w $032A : BEQ .not_stroking_hard
            DEC : STA.b $02
            
            LDY.b #$12

        .not_stroking_hard

        BRL .PlayerOam_ContinueWithAnimation

    .not_swimming

    LDA.w $02DA : BEQ .not_in_hold_item_pose
        STZ.b $02
        
        LDY.b #$1E
        
        CMP.b #$02 : BEQ .two_hand_hold_item_pose
            LDY.b #$1D

        .two_hand_hold_item_pose

        BRA not_stroking_hard

    .not_in_hold_item_pose

    ; Has something to do with the death module. Perhaps the player sprite
    ; lying down?
    LDA.w $036B : AND.b #$01 : BEQ .nothing_with_desert_cutscene
        LDA.w $030A : STA.b $02
        
        LDY.b #$1B
        
        BRA .not_stroking_hard

    .nothing_with_desert_cutscene

    LDA.b $4D  : BEQ .nothing_with_swim
        CMP.b #$01 : BEQ .check_if_som_platform
            CMP.b #$04 : BNE .nothing_with_swim
                LDY.b #$13
                
                LDA.b $1A : AND.b #$18 : LSR #3 : TAX
                LDA.l LinkSwimming_anim_offset, X : STA.b $02
                
                BRL .PlayerOam_ContinueWithAnimation

        .check_if_som_platform

        LDA.b $5D : CMP.b #$05 : BNE .notOnSomariaPlatform
            LDA.w $034E : BNE .dont_somaria_priority
                LDA.b #$30 : STA.b $65
                             STZ.b $64

            .dont_somaria_priority

            BRL .check_if_grabbing

        .notOnSomariaPlatform

        ; Is the player using the hookshot?
        LDA.b $5D : CMP.b #$13 : BEQ .nothing_with_swim
            LDA.b $55 : BNE .nothing_with_swim
                LDY.b #$05
                
                LDA.w $0360 : BEQ .no_electroction_flag
                    LDY.b #$14
                    
                    LDA.w $0300 : AND.b #$03

                .no_electroction_flag

                STA.b $02
                
                BRL .PlayerOam_ContinueWithAnimation

    .nothing_with_swim

    LDA.b $5B  : BEQ .no_slip_drawing
    CMP.b #$01 : BEQ .no_slip_drawing
        CMP.b #$03 : BNE .not_fully_falling
            ; Use an offset of 0x0000 in the OAM buffer when the player is
            ; falling into a hole or to the floor below?
            LDA.w PlayerOam_OAMBufferOffset+4 : STA.w $0352
            LDA.w PlayerOam_OAMBufferOffset+5 : STA.w $0353

        .not_fully_falling

        LDA.b $5A : STA.b $02 : CMP.b #$06 : BCC .not_max_fall_priority
            LDA.b $65 : ORA.b #$30 : STA.b $65

        .not_max_fall_priority

        LDY.b #$04
        
        BRL .PlayerOam_ContinueWithAnimation

    .no_slip_drawing

    LDA.w $0308 : BEQ .not_carrying_something
        JSR.w PlayerOam_GetHighestSetBit
        
        ; This comparison would seem to indicate that some other part of the
        ; code gives a crap about bit 6 of this variable, but in truth the only
        ; relevant bits are 0 and 7. They could have just used a BMI
        ; instruction.
        CPX.b #$06 : BCS .keep_lift_direction
            ; Explicitly set to down (0x02) for Desert prayer.
            LDA.b #$02 : STA.w $0323

        .keep_lift_direction

        LDY.w PlayerOam_WeirdGrabIndices, X : CPY.b #$0D : BCC .check_desert_step_counter
            LDA.w $0309 : AND.b #$02 : BEQ .not_throwing_object
                INY

            .not_throwing_object

            LDA.w $0309 : AND.b #$01 : BEQ .not_lifting_object
                LDY.b #$10
                
                BRA .check_desert_step_counter

            .not_lifting_object

            LDA.w $0308 : AND.b #$80 : BEQ .check_desert_step_counter
                BRL .PlayerOam_ContinueWithAnimation

        .check_desert_step_counter

        LDA.w $030A
        
        BRA .set_item_use_anim

    .not_carrying_something

    LDA.w $0377 : BEQ .not_grabbing_at_all
        DEC
        
        LDY.b #$17
        
        BRA .set_item_use_anim

    .not_grabbing_at_all

    LDA.w $0301 : BEQ .not_using_items_a
        JSR.w PlayerOam_GetHighestSetBit
        
        LDY.w PlayerOam_ItemsAUseIndex, X
        
        BRA .continue_with_items_a

    .not_using_items_a

    LDA.w $037A : BEQ .not_using_items_b
        JSR.w PlayerOam_GetHighestSetBit
        
        LDY.w PlayerOam_ItemsBUseIndex, X

        .continue_with_items_a

        LDA.w $0300

        .set_item_use_anim

        STA.b $02
        
        BRA .PlayerOam_ContinueWithAnimation

    .not_using_items_b

    LDA.b $5D : CMP.b #$0A : BEQ .using_medallion
                CMP.b #$08 : BEQ .using_medallion
        CMP.b #$09 : BNE .not_using_medallion

    .using_medallion

    LDY.b #$15
    
    BRA .continue_with_medallion

    .not_using_medallion

    CMP.b #$1E : BEQ .using_spin_attack
        CMP.b #$03 : BNE .not_spinning

    .using_spin_attack

    LDY.b #$0F

    .continue_with_medallion

    LDA.w $031C : STA.b $02
    
    BRA .PlayerOam_ContinueWithAnimation

    .not_spinning

    ; Check B button status:
    ; B button not down
    LDA.b $3A : AND.b #$80 : BEQ .PlayerOam_ContinueWithAnimation
        ; Check how long the B button has been pressed:
        ; Not nine frames.
        LDA.b $3C : CMP.b #$09 : BNE .not_fully_primed_sword
            LDY.b #$02
            
            BRA .PlayerOam_ContinueWithAnimation

        .not_fully_primed_sword

        LDY.b #$27
        
        ; B button has been pressed less than 9 frames.
        LDA.b $3C : STA.b $02
        CMP.b #$09 : BCC .PlayerOam_ContinueWithAnimation
            LDA.b $02 : SEC : SBC.b #$0A : STA.b $02
            
            LDY.b #$03

    .PlayerOam_ContinueWithAnimation

    STY.w $0354 : CPY.b #$05 : BEQ .not_recoiling
        LDA.b $64 : STA.w $035D
        LDA.b $65 : STA.w $035E

    .not_recoiling

    STZ.b $03
    
    LDA.b $02 : STA.b $76
    
    REP #$30
    
    LDA.b $2F : AND.w #$00FF : TAX
    LDA PlayerOam_AuxAnimationDirectionalStepIndexOffset, X : STA.b $74

    ; Multiples of 0x50...
    LDA PlayerOam_AnimationDirectionalStepIndexOffset, X : STA.b $04 
    
    ; I think Y is the "pose" for the particular direction we're facing.
    TYA : AND.w #$00FF : ASL : CLC : ADC.b $04 : TAY
    
    ; $02 is probably a subpose index...
    LDA PlayerOam_AnimationStepDataOffsets, Y
    CLC : ADC.b $02 : STA.b $02 : TAY
    
    LDA PlayerOam_Priority, Y : AND.w #$00FF : STA.b $04
    
    LDA.w #$0E00 : STA.w $0346
    
    LDA.w $0ABD : BEQ .not_alternate_palette
        ; Use palette SP0 instead of SP7.
        STZ.w $0346

    .not_alternate_palette

    STZ.w $0102
    STZ.w $0104
    
    LDX.w #$000C

    .check_next

        LDA.w $0354 : AND.w #$00FF : CMP PlayerOam_AnimationsWithAuxParts, X : BEQ .match
    DEX : DEX : BPL  .check_next
    
    BRL .PlayerOam_NoAux

    .match

    TXA : AND.w #$00FF : CLC : ADC.b $74 : TAX
    LDA.b $76 : AND.w #$00FF : CLC : ADC PlayerOam_AuxAnimationStepDataOffset, X : STA.b $74
    
    LDY.b $74
    LDA PlayerOam_Aux1GFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BNE .continue_aux1
        BRL .no_aux1

    .continue_aux1

    ASL : STA.w $0102
    
    LDX.b $72
    LDA.w PlayerOam_PlayerOam_Aux1BufferOffsetPointers, X : STA.b $0A
    
    LDY.b $04
    LDA.b ($0A), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    LDY.b $74
    
    SEP #$20
    
    LDA.b $25 : BMI .aux1_z_negative
        LDA.b $24
        
        BRA .aux1_z_continue

    .aux1_z_negative

    LDA.b $24 : CMP.b #$F0 : BCC .aux1_z_continue
        LDA.b #$00

    .aux1_z_continue

    STA.b $0F
    STZ.b $0E
    
    LDA.w PlayerOam_Aux1Offset_Y, Y : CLC : ADC.b $01 : SEC : SBC.b $0F : STA.w $0801, X

    LDA.w PlayerOam_Aux1Offset_X, Y : CLC : ADC.b $00 : STA.w $0800, X
    
    REP #$20
    
    LDA PlayerOam_Aux1GFXIndex, Y : AND.w #$00FF : STA.b $06
    
    LSR : TAY
    LDA.w PlayerOam_AuxFlip-1, Y : TAY
    
    LDA.b $06 : AND.w #$0001 : BEQ .dont_shift_aux1
        TYA : ASL #4 : TAY

    .dont_shift_aux1

    TYA : AND.w #$C000 : ORA.b $64 : ORA.w $0346 : ORA.w #$0004 : STA.w $0802, X
    
    TXA : LSR : LSR : TAX
    LDA.w $0A20, X : AND.w #$FF00 : STA.w $0A20, X

    .no_aux1

    LDY.b $74
    LDA.w PlayerOam_Aux2GFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BNE .continue_aux2
        .BRL PlayerOam_NoAux

    .continue_aux2

    ASL : STA.w $0104
    
    LDX.b $72
    LDA.w PlayerOam_Aux2BufferOffsetPointers, X : STA.b $0A
    
    LDY.b $04
    LDA.b ($0A), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    LDY.b $74
    
    SEP #$20
    
    LDA.b $25 : BMI .aux_2_z_negative
        LDA.b $24
        
        BRA .aux_2_z_continue

    .aux_2_z_negative

    LDA.b $24 : CMP.w #$F0 : BCC .aux_2_z_continue
        LDA.w #$00

    .aux_2_z_continue

    STA.b $0F
    STZ.b $0E
    
    LDA.w PlayerOam_Aux2Offset_Y, Y : CLC : ADC.b $01 : SEC : SBC.b $0F : STA.w $0801, X
    
    LDA PlayerOam_Aux2Offset_X, Y : CLC : ADC.b $00 : STA.w $0800, X
    
    REP #$20
    
    LDA PlayerOam_Aux2GFXIndex, Y : AND.w #$00FF : STA.b $06
    LSR : TAY
    LDA PlayerOam_AuxFlip-1, Y : TAY
    
    LDA.b $06 : AND.w #$0001 : BEQ .dont_shift_aux2
        TYA : ASL #4 : TAY

    .dont_shift_aux2

    TYA : AND.w #$C000 : ORA.b $64 : ORA.w $0346 : ORA.w #$0014 : STA.w $0802, X
    
    TXA : LSR : LSR : TAX
    LDA.w $0A20, X : AND.w #$FF00 : STA.w $0A20, X

    .PlayerOam_NoAux

    LDA.w $0309 : AND.w #$0004 : BEQ .always_taken
        JSR.w PlayerOam_UnusedWeaponSettings
        
        BRA .skip_sword_VRAM

    .always_taken

    LDA.b $5D : AND.w #$00FF : CMP.w #$0008 : BEQ .is_spinning_mode
                               CMP.w #$0009 : BEQ .is_spinning_mode
                               CMP.w #$000A : BEQ .is_spinning_mode
                               CMP.w #$0003 : BEQ .is_spinning_mode
                               CMP.w #$001E : BEQ .is_spinning_mode
        LDA.w $0308 : AND.w #$00FF : BNE .holding_hands_up
            LDA.w $03EF : ORA.w $0360 : AND.w #$00FF : BNE .holding_hands_up
                LDA.w $0301 : AND.w #$0040 : BNE .skip_sword_VRAM
                    LDA.w $037A : AND.w #$003D : BNE .using_some_item
                        LDA.w $0301 : AND.w #$0093 : BNE .using_some_item
                            LDA.b $3A : AND.w #$0080 : BEQ .skip_sword_VRAM

        .holding_hands_up
    .is_spinning_mode

    LDA.l $7EF359 : INC : AND.w #$00FE : BEQ .skip_sword_VRAM
        .using_some_item

        JSR.w PlayerOam_SetWeaponVRAMOffsets : BCC .continue_with_weapon

    .skip_sword_VRAM

    BRL .PlayerOam_DrawShield

    .continue_with_weapon

    LDY.b $02
    
    SEP #$20
    
    LDA.b $25 : BMI .possible_grounded
        LDA.b $24
        
        BRA .airborne

    .possible_grounded

    LDA.b $24 : CMP.b #$F0 : BCC .airborne
        LDA.b #$00

    .airborne

    STA.b $0B
    
    LDA.b $01 : CLC : ADC.w PlayerOam_SwordOffsetY, Y : SEC : SBC.b $0B : STA.b $0B
    LDA.b $00 : CLC : ADC.w PlayerOam_SwordOffsetX, Y       : STA.b $0A : STA.b $08
    
    LDA.w $0301 : AND.b #$02 : BEQ .not_hammer
        LDA.w $0300 : CMP.b #$02 : BNE .skip_hitbox
            LDA.b $3D : CMP.b #$0F : BNE .skip_hitbox
                BRA .set_hitbox_offset

    .not_hammer

    LDA.w $0301 : AND.b #$05 : BNE .skip_hitbox
        .set_hitbox_offset

        LDA.w AttackHitboxOffset_Y, Y : STA.b $44
        LDA.w AttackHitboxOffset_X, Y : STA.b $45

    .skip_hitbox

    STZ.b $0E
    STZ.b $0F
    
    LDA.w $0301 : AND.b #$05 : BEQ .rodding
        LDY.w $0307 : DEY
        LDA.w PlayerOam_RodTypeID, Y : STA.b $0F

    .rodding

    LDA.w $037A : AND.b #$08 : BEQ .not_caning
        LDA.w $0303 : CMP.b #$0D : BNE .not_caning
            LDA.b #$04 : STA.b $0F

    .not_caning

    REP #$20
    
    LDA.b $06 : ASL : CLC : ADC.b $06 : ASL : TAY
    
    STZ.b $06
    
    PHY
    
    LDX.b $72
    LDA.w PlayerOam_WeaponBufferOffsetPointers, X : STA.b $74
    
    LDA.b $04 : AND.w #$00FF : TAY
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    PLY
    
    LDA.b $0E : PHA
    
    JSR.w PlayerOam_DrawSwordSwingTip
    
    PLA : STA.b $0E

    .next_weapon_object

        REP #$20
        
        LDA PlayerOam_WeaponTiles, Y : CMP.w #$FFFF : BEQ .no_weapons
            AND.w #$CFFF : ORA.b $64 : STA.w $0802, X
            AND.w #$0E00 : CMP.w #$0200 : BEQ .ignore_palette_adjustments
                LDA.w $0346 : BNE .ignore_palette_adjustments
                    LDA.w $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA.w $0802, X

            .ignore_palette_adjustments

            LDA.b $0E : BEQ .ignore_palette_adjustments_2
                LDA.w $0802, X : AND.w #$F1FF : ORA.b $0E : STA.w $0802, X

            .ignore_palette_adjustments_2

            LDA.b $0A    : STA.w $0800, X
            AND.w #$00FF : STA.b $74
            
            LDA.b $00 : AND.w #$00FF : SEC : SBC.b $74 : BPL .positive_a
                EOR.w #$FFFF : INC

            .positive_a

            CMP.w #$0080 : BCC .positive_b
                LDA.w #$0001 : TSB.b $0C

            .positive_b

            PHY : PHX
            
            TXA : LSR : LSR : TAX
            
            SEP #$20
            
            LDA.b $0C  : STA.w $0A20, X
            AND.b #$FE : STA.b $0C
            
            PLX : PLY
            
            INX #4

        .no_weapons

        SEP #$20
        
        LDA.b $0A : CLC : ADC.b #$08 : STA.b $0A
        
        INY : INY
        
        LDA.b $06 : INC : STA.b $06
        AND.b #$01 : BNE .no_offset
            LDA.b $0B : CLC : ADC.b #$08 : STA.b $0B
            
            LDA.b $08 : STA.b $0A

        .no_offset

        LDA.b $06 : CMP.b #$03 : BEQ .weapon_loop_done
    
    BRL .next_weapon_object

    .weapon_loop_done

    SEP #$10

    .PlayerOam_DrawShield

    REP #$30
    
    ; Shield
    LDA.l $7EF35A : AND.w #$00FF : BEQ .dontShowShield
        ; Check out progress indicator to see if Link's gotten the shield from
        ; his uncle yet. In other words, if Link has entered phase 1.
        LDA.l $7EF3C5 : AND.w #$00FF : BEQ .dontShowShield
            ; Affects graphics when carrying things?
            JSR.w PlayerOam_SetEquipmentVRAMOffsets : BCC .showShield

    .dontShowShield

    BRL .PlayerOam_DrawShadow

    ; Pretty sure this label is accurate, would require in game tesing.
    .showShield

    LDY.b $02
    
    SEP #$20
    
    LDA.b $25 : BMI .not_necessarily_airborne
        LDA.b $24
        
        BRA .airborne

    .not_necessarily_airborne

    LDA.b $24 : CMP.b #$F0 : BCC .airborne
        LDA.b #$00

    .airborne

    STA.b $0B
    
    LDA.b $01 : CLC : ADC.w PlayerOam_ShieldOffsetY, Y
    DEC : SEC : SBC.b $0B : STA.b $0B
    
    LDA.b $00 : CLC : ADC.w PlayerOam_ShieldOffsetX, Y : STA.b $0A
                                                         STA.b $08
    
    LDA.w PlayerOam_ShieldOffsetX, Y
    
    JSR.w PlayerOam_GetRelativeHighBit
    
                 STZ.b $0E
    LDA.b #$0A : STA.b $0F
    
    ; Branch if the player sprite is using palette 7, which is typical.
    LDA.w $0347 : BNE .leave_shield_palette
        LDA.b #$06 : STA.b $0F

    .leave_shield_palette

    REP #$30
    
    LDA.b $06 : ASL : CLC : ADC.b $06 : ASL : TAY
    
    STZ.b $06
    
    PHY
    
    LDX.b $72
    
    LDA.w PlayerOam_ShieldBufferOffsetPointers, X : STA.b $74
    
    LDA.b $04 : AND.w #$00FF : TAY
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    PLY

    .next_shield_object

        REP #$20
        
        STZ.b $74
        
        LDA.w PlayerOam_ShieldTiles, Y : CMP.w #$FFFF : BEQ .no_shield_to_draw
            AND.w #$C1FF : ORA.b $0E : ORA.b $64 : STA.w $0802, X
            
            LDA.b $0A : STA.w $0800, X
            
            PHX
            
            TXA : LSR : LSR : TAX
            
            SEP #$20
            
            ; Or in the 9th bit of the X coordinate.
            LDA.b $0C : ORA.w $03FA : STA.w $0A20, X
            
            PLX : INX #4

        .no_shield_to_draw

        SEP #$20
        
        LDA.b $0A : CLC : ADC.b #$08 : STA.b $0A
        
        INY : INY
        
        INC.b $06
        LDA.b $06 : AND.b #$01 : BNE .no_offset_2
            LDA.b $0B : CLC : ADC.b #$08 : STA.b $0B
            
            LDA.b $08 : STA.b $0A

        .no_offset_2
    LDA.b $06 : CMP.b #$03 : BNE .next_shield_object
    
    SEP #$10

    .PlayerOam_DrawShadow

    SEP #$30
    
    LDA.b $4B : CMP.b #$0C : BNE .player_is_visible
        BRL PlayerOam_DrawPose

    .player_is_visible

    LDA.b $5D : CMP.b #$16 : BEQ .proceed_to_pose
        LDA.w $0354 : CMP.b #$05 : BEQ .recoil_check
            ; See if Link is standing in water.
            LDA.w $0351 : BEQ .recoil_check
                ; Draws water/grass sprites around Link.
                JSR.w PlayerOam_DrawFootObject
                
                BRA .proceed_to_pose

        .recoil_check:

        LDA.b $4D : CMP.b #$04 : BEQ .proceed_to_pose
            LDA.b $5D : CMP.b #$04 : BEQ .proceed_to_pose
                LDY.b #$00
                
                LDA.b $5B  : BEQ .weak_slip
                CMP.b #$01 : BEQ .weak_slip
                    LDA.b $5A : CMP.b #$06 : BCC .proceed_to_pose
                        JSR.w PlayerOam_DungeonFallShadow

    .proceed_to_pose

        BRL .PlayerOam_DrawPose
            .weak_slip

            LDA.b $4D : BEQ .big_shadow
                CMP.b #$01 : BNE .tiny_shadow
                    LDA.b $55 : BNE .big_shadow

                .tiny_shadow

                LDY.b #$01

            .big_shadow

            STY.b $0A
            STZ.b $0B
            
            LDA.w $0323 : LSR : TAY
            
            REP #$20
            
            LDA.b $20 : SEC : SBC.b $E8 : STA.b $06
            
            LDA.w PlayerOam_ShadowOffset_Y, Y : AND.w #$00FF : CMP.w #$0080 : BCC .positive_y
                ORA.w #$FF00

            .positive_y

            CLC : ADC.b $06 : STA.b $06
            
            SEP #$20
    LDA.b $07 : BNE .proceed_to_pose
    
    LDA.b $01 : CLC : ADC.w PlayerOam_ShadowOffset_Y, Y : STA.b $07
    LDA.b $00 : CLC : ADC.w PlayerOam_ShadowOffset_X, Y : STA.b $06
    
    REP #$30
    
    LDX.b $72
    LDA.w PlayerOam_ShadowBufferOffsetPointers, X : STA.b $74
    
    LDA.b $04 : AND.w #$00FF : TAY
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    LDA.b $0A : ASL : ASL : TAY
    LDA PlayerOam_ShadowTiles, Y : AND.w #$CFFF : ORA.w $035D : STA.w $0802, X
                                   AND.w #$3FFF : ORA.w #$4000 : STA.w $0806, X
    
    LDA.b $06 : STA.w $0800, X
    
    XBA : CLC : ADC.w #$0800 : XBA : STA.w $0804, X
    
    LDA.w $0346 : BNE .no_palette_adjustment
        LDA.w $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA.w $0802, X
        LDA.w $0806, X : AND.w #$F1FF : ORA.w #$0600 : STA.w $0806, X

    .no_palette_adjustment

    TXA : LSR : LSR : TAX
    STZ.w $0A20, X
    
    SEP #$30

    .PlayerOam_DrawPose

    REP #$30
    
    LDX.b $72
    LDA PlayerOam_ElfBufferOffsetPointers, X : STA.b $74
    
    ; Determine the finalized offset into the OAM buffer?
    LDY.b $04
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    LDA.b $02 : ASL : TAY
    LDA.w PlayerOam_AnimationSteps, Y : STA.b $0E
    ASL                               : STA.w $0100
    CLC : ADC.b $0E                   : TAY
    
    SEP #$20
    
    LDA.b $4B : CMP.b #$0C : BNE .not_invisible
        BRL .PlayerOam_RunFinalAdjustments

    .not_invisible

    LDA.b $25 : BMI .possibly_grounded
        LDA.b $24
        
        BRA .airborne

    .possibly_grounded

    LDA.b $24 : CMP.b #$F0 : BCC .airborne
        LDA.b #$00

    .airborne

    STA.b $0F
    STZ.b $0E
    
    LDA.b $01 : CLC : ADC PlayerOam_PoseData, Y : SEC : SBC.b $0F : STA.b $0B
    LDA.b $00 : CLC : ADC PlayerOam_PoseData+1, Y                 : STA.b $0A
    
    REP #$20
    
    LDA PlayerOam_PoseData+2, Y : XBA : STA.b $06
    AND.w #$F000 : CMP.w #$F000 : BEQ .no_draw
        ORA.b $64 : ORA.w $0346 : STA.w $0802, X
        
        STZ.b $02
        
        LDA.b $0A : STA.w $0800, X
        AND.w #$00FF : CMP.w #$00F8 : BCC .on_screen_x
            LDA.w #$0001 : STA.b $02

        .on_screen_x

        PHX
        
        TXA : LSR : LSR : TAX
        LDA.w $0A20, X : AND.w #$FF00 : ORA.b $02 : ORA.w #$0002 : STA.w $0A20, X
        
        PLX

    .no_draw

    LDA.b $06 : AND.w #$0F00 : CMP.w #$0F00 : BEQ .PlayerOam_RunFinalAdjustments
        ASL #4 : ORA.b $64 : ORA.w $0346 : ORA.w #$0002 : STA.w $0806, X
        
        LDA.b $00 : SEC : SBC.b $0E : CLC : ADC.w #$0800 : STA.w $0804, X
        
        TXA : LSR : LSR : TAX
        LDA.w $0A21, X : AND.w #$FF00 : ORA.w #$0002 : STA.w $0A21, X

    .PlayerOam_RunFinalAdjustments

    SEP #$30
    
    LDA.b #$01 : STA.b $0E
    
    LDA.b $6C : BEQ .not_in_doorway
        REP #$20
        
        LDA.b $22 : SEC : SBC.b $E2 : CMP.w #$0004 : BCC .looks_invisible
                                      CMP.w #$00FC : BCS .looks_invisible
            LDA.b $20 : SEC : SBC.b $E8 : CMP.w #$0004 : BCC .looks_invisible
                                          CMP.w #$00E0 : BCS .looks_invisible
                SEP #$20

    .not_in_doorway

    STZ.b $0E
    
    LDA.b $11 : BNE .check_stair_visibility
        LDA.w $031F : BEQ .check_stair_visibility
            DEC : STA.w $031F
            CMP.b #$04 : BCC .check_stair_visibility
                AND.b #$01 : BEQ .looks_invisible

    .check_stair_visibility

    LDA.b $4B : CMP.b #$0C : BEQ .looks_invisible
        LDA.b $55 : BEQ .cape_inactive_z

    .looks_invisible

    REP #$30
    
    LDA.w $0352 : LSR : LSR : TAX
    LDA.w #$0101
    STA.w $0A20, X : STA.w $0A22, X
    STA.w $0A24, X : STA.w $0A26, X
    STA.w $0A28, X : STA.w $0A2A, X
    
    LDA.b $4B : AND.w #$00FF : CMP.w #$000C : BEQ .check_position_restoration
        LDA.b $0E : AND.w #$00FF : BNE .check_position_restoration
            LDX.b $72
            LDA PlayerOam_ShadowBufferOffsetPointers, X : STA.b $74
            
            LDA.b $04 : AND.w #$00FF : TAY
            LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : LSR : LSR : TAX
            
            STZ.w $0A20, X

    .check_position_restoration

    SEP #$30

    .cape_inactive_z
    
    ; Z is a placeholder until we figure out how many there are like this.
    LDA.b $11 : CMP.b #$12 : BEQ .on_straight_interroom_staircase_z
        CMP.b #$13 : BNE .not_on_straight_interroom_staircase_z

    ; Restore position.
    .on_straight_interroom_staircase_z

    PLA : STA.b $21
    PLA : STA.b $20

    .not_on_straight_interroom_staircase_z

    PLB
    
    RTL
}

; ==============================================================================

; This routine returns the highest bit set in whatever variable is the
; accumulator. Note: you wouldn't want to call this with a 16-bit accumulator
; enabled.
; $06AAC3-$06AACB LOCAL JUMP LOCATION
PlayerOam_GetHighestSetBit:
{
    LDX.b #$07

    .next_bit

        ASL : BCS .bit_was_set
    DEX : BPL .next_bit

    .bit_was_set

    RTS
}

; ==============================================================================

; TODO: analyze, format, annotate.
; $06AACC-$06AB17 DATA
PlayerOam_WeaponOffsetID:
{
    db $06
    db $06
    db $04
    db $04
    db $04
    db $04
    db $00
    db $00
    db $08
    db $08
    db $08
    db $08
    db $02
    db $02
    db $02
    db $02
    db $0A
    db $0A
    db $0A
    db $0A
    db $0C
    db $0C
    db $0C
    db $0C
    db $0E
    db $0E
    db $0E
    db $0E
    db $00
    db $09
    db $0C
    db $09
    db $0C
    db $0E
    db $0A
    db $08
    db $0D
    db $08
    db $0D
    db $12
    db $12
    db $11
    db $11
    db $10
    db $10
    db $10
    db $10
    db $40
    db $41
    db $40
    db $41
    db $18
    db $18
    db $19
    db $19
    db $24
    db $21
    db $25
    db $23
    db $22
    db $20
    db $26
    db $23
    db $25
    db $26
    db $22
    db $28
    db $2A
    db $29
    db $29
    db $2C
    db $28
    db $2B
    db $28
    db $2B
    db $30
}

; ==============================================================================

; $06AB18-$06AB22 DATA
PlayerOam_RodOffsetID:
{
    db $01, $04, $01, $04, $06, $02, $00, $05
    db $00, $05
}

; ==============================================================================

; $06AB22-06AB6D DATA
PlayerOam_WeaponSize:
{
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $02
    db $00
    db $02
    db $00
    db $00
    db $00
    db $00
    db $00
    db $02
    db $02
    db $02
    db $02
    db $02
    db $00
    db $02
    db $00
    db $00
    db $00
    db $00
    db $00
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $02
    db $00
    db $00
    db $00
    db $00
    db $02
    db $00
    db $02
    db $00
    db $02
}

; $06AB6E-$06ABC9 LOCAL JUMP LOCATION
PlayerOam_SetWeaponVRAMOffsets:
{
    REP #$30
    
    LDY.b $02
    LDA.w PlayerOam_WeaponGFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BEQ .fail
        STA.b $06
        TAX
        LDA.w PlayerOam_WeaponSize, X : AND.w #$00FF : STA.b $0C
        
        TXA
        LDY.w PlayerOam_WeaponOffsetID, X : CMP.w #$001D : BCC .is_sword
            LDA.w $0301 : AND.w #$0005 : BEQ .not_rod
                TXA : SEC : SBC.w #$001D : TAX
                LDY.w PlayerOam_RodOffsetID, X

            .not_rod

            TYA : AND.w #$00FF : STA.b $0A
            
            LDA.w $0109 : AND.w #$FF00 : ORA.b $0A : STA.w $0109
            
            BRA .succeed

        .is_sword

        TYA : AND.w #$00FF : STA.b $0A
        
        LDA.w $0107 : AND.w #$FF00 : ORA.b $0A : STA.w $0107

        .succeed

        CLC
        
        RTS

    .fail

    SEC
    
    RTS
}

; $06ABCA-06ABE7 DATA
EquipmentVRAMOffsets:
{
    ; $06ABCA
    .shield_id
    db $00, $02, $04, $04, $04, $04, $04, $04
    db $09, $0C, $09, $0C, $0E, $0A, $08, $0D
    db $08, $0D

    ; $06ABDC
    .rod_id
    db $01, $04, $01, $04, $06, $02, $00, $05
    db $00, $05
}

; $06ABE6-$06AC44 LOCAL JUMP LOCATION
PlayerOam_SetEquipmentVRAMOffsets:
{
    REP #$30
    
    STZ.b $0C
    
    LDY.b $02
    
    ; Appears to only range from 0xFF to 0x03.
    LDA PlayerOam_ShieldGFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BEQ .fail
        STA.b $06
        TAX
        LDY.w EquipmentVRAMOffsets_shield_id, X : AND.w #$00F8 : BEQ .is_shield
            LDA.w $0301 : AND.w #$0005 : BEQ .not_rod
                TXA : SEC : SBC.w #$0008 : TAX
                LDY.w EquipmentVRAMOffsets_rod_id, X

            .not_rod

            TYA         : AND.w #$00FF             : STA.b $0A
            LDA.w $0109 : AND.w #$FF00 : ORA.b $0A : STA.w $0109
            AND.w #$0007 : BEQ .dont_invert
                BRA .succeed

        .is_shield

        TYA : AND.w #$00FF : STA.b $0A
        
        LDA.w $0108 : AND.w #$FF00 : ORA.b $0A : STA.w $0108

        .dont_invert

        LDA.w #$0002 : STA.b $0C

        .succeed

        CLC
        
        RTS

    .fail

    SEC
    
    RTS
}

; $06AC45-06AC8C DATA
PlayerOam_SwordSwingTipTile:
{
    ; $06AC45
    .up
    dw $FFFF
    dw $FFFF
    dw $6A3E
    dw $6A2F
    dw $6A2F
    dw $2A05
    dw $2A2F
    dw $2A3E
    dw $FFFF

    ; $06AC57
    .down
    dw $FFFF
    dw $FFFF
    dw $AA3E
    dw $AA2F
    dw $AA2F
    dw $AA05
    dw $EA2F
    dw $EA3E
    dw $FFFF

    ; $06AC69
    .left
    dw $FFFF
    dw $FFFF
    dw $2A3E
    dw $2A3F
    dw $2A3F
    dw $2A05
    dw $AA3F
    dw $AA3E
    dw $FFFF

    ; $06AC7B
    .right
    dw $FFFF
    dw $FFFF
    dw $6A3E
    dw $6A3F
    dw $6A3F
    dw $6A05
    dw $EA3F
    dw $EA3E
    dw $FFFF
}

; ==============================================================================

; $06AC8D-$06ACB0 DATA
PlayerOam_SwordSwingTipOffsetY:
{
    ; $06AC8D
    .up
    db $FF
    db $FF
    db $FB
    db $F3
    db $F1
    db $EB
    db $F3
    db $FB
    db $FF

    ; $06AC96
    .down
    db $FF
    db $FF
    db $16
    db $1B
    db $1D
    db $23
    db $1B
    db $18
    db $FF

    ; $06AC9F
    .left
    db $FF
    db $FF
    db $FF
    db $02
    db $05
    db $0C
    db $14
    db $1A
    db $FF

    ; $06ACA8
    .right
    db $FF
    db $FF
    db $FF
    db $02
    db $05
    db $0C
    db $14
    db $1A
    db $FF
}
; ==============================================================================

; $06ACB1-$06ACD4 DATA
PlayerOam_SwordSwingTipOffsetX:
{
    ; $06ACB1
    .up
    db $FF
    db $FF
    db $0F
    db $0D
    db $08
    db $FF
    db $F6
    db $F2
    db $FF

    ; $06ACBA
    .down
    db $FF
    db $FF
    db $FA
    db $FD
    db $01
    db $08
    db $10
    db $15
    db $FF

    ; $06ACC3
    .left
    db $FF
    db $FF
    db $F5
    db $F1
    db $EE
    db $E8
    db $EF
    db $F4
    db $FF

    ; $06ACCC
    .right
    db $FF
    db $FF
    db $13
    db $17
    db $1A
    db $20
    db $19
    db $14
    db $FF
}

; $06ACD5-$06AD81 LOCAL JUMP LOCATION
PlayerOam_DrawSwordSwingTip:
{
    LDA.b $0A : PHA
    
    PHY
    
    LDA.b $5D : BEQ .base_link_state
        .give_up

        BRL .reset_and_exit

    .base_link_state

    LDA.l $7EF359 : AND.w #$00FF : BEQ .give_up
                    CMP.w #$00FF : BEQ .give_up
                    CMP.w #$0001 : BEQ .give_up
        LDA.b $3A : AND.w #$0080 : BEQ .give_up
            LDA.b $3C : AND.w #$00FF : CMP.w #$0009 : BCS .give_up
                ASL : STA.b $0A
                
                LDA.b $2F : AND.w #$00FF : LSR                   : STA.b $0E
                ASL #3 : CLC : ADC.b $0E : ASL : CLC : ADC.b $0A : TAY
                LDA.w PlayerOam_SwordSwingTipTile, Y : CMP.w #$FFFF : BEQ .reset_and_exit
                    AND.w #$CFFF : ORA.b $64 : STA.w $0802, X
                    
                    LDA.w $0346 : BNE .no_palette_adjust
                        LDA.w $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA.w $0802, X

                    .no_palette_adjust

                    TYA : LSR : TAY
                    
                    SEP #$20
                    
                    LDA.w PlayerOam_SwordSwingTipOffsetY, Y : CLC : ADC.b $01 : STA.b $0B
                    LDA.w PlayerOam_SwordSwingTipOffsetX, Y : CLC : ADC.b $00 : STA.b $0A
                    
                    LDA.w PlayerOam_SwordSwingTipOffsetY, Y : STA.b $44
                    LDA.w PlayerOam_SwordSwingTipOffsetX, Y : STA.b $45
                    
                    JSR.w PlayerOam_GetRelativeHighBit
                    
                    REP #$20
                    
                    LDA.b $0A : STA.w $0800, X
                    
                    INX #4
                    
                    PHX
                    
                    TXA : SEC : SBC.w #$0004 : LSR : LSR : TAX
                    
                    ; Or in the 9th bit of the X coordinate.
                    LDA.w #$0000 : ORA.w $03FA : STA.w $0A20, X
                    
                    PLX

    .reset_and_exit

    STZ.b $0E
    
    PLY
    
    PLA : STA.b $0A
    
    RTS
}

; $06AD82-$06ADB5 DATA
Pool_LinkOAM_UnusedWeaponSettings:
{
    ; $06AD82
    .props
    dw $2609

    ; $06AD84
    .index
    db $FF, $FF, $FF, $FF
    db $00, $FF, $FF, $FF
    db $00, $00, $FF, $FF
    db $00, $00, $00, $FF

    ; $06AD94
    .offset_x
    db $FF, $FF, $FF, $FF
    db   8, $FF, $FF, $FF
    db   8,   5, $FF, $FF
    db   8,   5,   2, $FF

    ; $06ADA4
    .offset_y
    db $FF, $FF, $FF, $FF
    db  14, $FF, $FF, $FF
    db  14,  22, $FF, $FF
    db  14,  22,  30, $FF

    ; $06ADB4
    .offset
    db $00
    db $04
}

; $06ADB6-$06AE37 LOCAL JUMP LOCATION
PlayerOam_UnusedWeaponSettings:
{
    SEP #$30
    
    LSR : LSR
    JSR.w PlayerOam_GetHighestSetBit
    
    LDA.w Pool_LinkOAM_UnusedWeaponSettings_index, X
    CLC : ADC.w $030E : ASL : ASL : STA.b $06
                                    STZ.b $07
    
    LDA.b #$42 : STA.w $0109
    
    REP #$30
    
    LDX.b $72
    LDA.w PlayerOam_WeaponBufferOffsetPointers, X : STA.b $74
    
    LDA.b $04 : AND.w #$00FF : TAY
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    LDY.b $06
    
    STZ.b $06

    .BRANCH_BETA

            SEP #$20
            
            LDA.b $01
            CLC : ADC.w Pool_LinkOAM_UnusedWeaponSettings_offset_x, Y : STA.b $0B

            LDA.b $00
            CLC : ADC.w Pool_LinkOAM_UnusedWeaponSettings_offset_y, Y : STA.b $0A
            
            PHY
            
            LDA.w Pool_LinkOAM_UnusedWeaponSettings_index, Y : CMP.b #$FF : BEQ .BRANCH_ALPHA
                REP #$20
                
                AND.w #$00FF : TAY
                LDA.w Pool_LinkOAM_UnusedWeaponSettings_props, Y
                AND.w #$CFFF : ORA.b $64 : STA.w $0802, X
                
                LDA.b $0A : STA.w $0800, X
                
                PHX
                
                TXA : LSR : LSR : TAX
                
                SEP #$20
                
                STZ.w $0A20, X
                
                PLX : INX #4

            .BRANCH_ALPHA

            PLY : INY
        INC.b $06 : LDA.b $06 : CMP.b #$04 : BNE .BRANCH_BETA
    LDA.b $06 : CMP.b #$04 : BNE .BRANCH_BETA
    
    REP #$30
    
    RTS
}

; ==============================================================================

; $06AE38-$06AE3A DATA
DungeonFallShadow_offset_x:
{
    db $00, $00, $04
}

; $06AE3B-$06AEC9 LOCAL JUMP LOCATION
PlayerOam_DungeonFallShadow:
{
    LDY.b #$00
    
    LDA.b $51 : SEC : SBC.b #$0C : SEC : SBC.b $20
    
    CMP.b #$F0 : BCS .shadow_size_chosen
        CMP.b #$30 : BCC .not_medium_shadow
            LDY.b #$04

        .not_medium_shadow

        CMP.b #$60 : BCC .shadow_size_chosen
            LDY.b #$08

    .shadow_size_chosen

    TYA : LSR : LSR : TAX
    LDA DungeonFallShadow_offset_x, X : STA.b $06
    
    LDA.b $51 : SEC : SBC.b #$0C : SEC : SBC.b $E8 : CLC : ADC.b #$1D : STA.b $07
    
    LDA.b $00 : CLC : ADC.b $06 : STA.b $06
    
    STZ.b $04
    
    REP #$30
    
    PHY
    
    LDX.b $72
    LDA.w PlayerOam_ShadowBufferOffsetPointers, X : STA.b $74
    
    LDA.b $03 : AND.w #$00FF : TAY
    LDA.b ($74), Y : AND.w #$00FF : CLC : ADC.w $0352 : TAX
    
    PLY

    .next_object

        REP #$20
        
        LDA PlayerOam_ShadowTiles, Y : CMP.w #$FFFF : BEQ .give_up
            AND.w #$CFFF : ORA.w $035D : STA.w $0802, X
            
            LDA.b $06 : STA.w $0800, X

        .give_up

        PHX
        
        TXA : LSR : LSR : TAX
        
        SEP #$20
        
        STZ.w $0A20, X
        
        PLX
        
        LDA.b $06 : CLC : ADC.b #$08 : STA.b $06
        
        INY : INY
        
        INX #4
        
        INC.b $04
    LDA.b $04 : CMP.b #$02 : BNE .next_object
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; $06AECA-$06AED0 DATA
FootObject:
{
    ; $06AECA
    .aux_check
    db $0A
    db $02
    db $0E

    ; $06AECD
    .shield_direction
    db $04 ; Up
    db $04 ; Down
    db $08 ; Left
    db $08 ; Right
}

; ==============================================================================

; Seems to draw the ripples around Link while standing in shallow water.
; $06AED1-$06AF9C LOCAL JUMP LOCATION
PlayerOam_DrawFootObject:
{
    ; Seems like a timer to control how often to change the sprite's frame
    ; If frame counter < 9.
    LDA.w $0356 : INC : AND.b #$0F : STA.w $0356
    CMP.b #$09 : BCC .dont_reset_foot_object
        STZ.w $0356
        
        LDA.w $0355 : INC : AND.b #$03 : STA.w $0355
        CMP.b #$03 : BNE .dont_reset_foot_object
            STZ.w $0355

    .dont_reset_foot_object

    ; See if Link has a shield.
    LDA.l $7EF35A : TAY
    
    ; See which direction Link is facing.
    ; Probably positions the water/grass sprite appropriately.
    LDA.w $0323 : LSR : CLC : ADC.w FootObject_shield_direction, Y : TAY
    LDA.b $01 : CLC : ADC.w PlayerOam_ShadowOffset_Y, Y : STA.b $07
    LDA.b $00 : CLC : ADC.w PlayerOam_ShadowOffset_X, Y : STA.b $06
    
    ; $8D = secondary timer * 4.
    LDA.w $0355 : ASL : ASL : STA.b $8D
    
    PHY
    
    ; ???? $72 apparently is assumed to be even at all times.
    LDX.b $72
    LDA PlayerOam_ShadowBufferOffsetPointers+0, X : STA.b $74
    LDA PlayerOam_ShadowBufferOffsetPointers+1, X : STA.b $75
    
    LDY.b $04
    LDA.b ($74), Y : TAX
    
    PLY
    
    ; See if Link is standing in grass.
    ; Nope... standing in water.
    LDA.w $0351 : CMP.b #$02 : BNE .not_tall_grass
        LDY.b #$06

        .check_next

            LDA.w .aux_check, Y : CMP.w $0354 : BNE .wrong
                STZ.b $8D
                
                BRA .check_step

            .wrong
        DEY : BPL .check_next

        .check_step

        LDA.b $2E : CMP.b #$03 : BCC .dont_reset_step
            SEC : SBC.b #$03

        .dont_reset_step

        ASL : ASL : STA.b $8D
        
        LDA.b #$08 : ASL : ASL : CLC : ADC.b $8D : TAY
        
        BRA .continue

    .not_tall_grass

    LDA.b #$05 : ASL : ASL : CLC : ADC.b $8D : TAY

    .continue

    ; This is where the actual draw starts, it draws both tiles at the same
    ; time but in 2 completly different ways. Wtf Nintendo.
    REP #$30
    
    ; Get the starting address for the frame of either the water or grass
    ; animation we are on.
    TYA : AND.w #$00FF : TAY

    ; Get the offset of where to put the OAM.
    TXA : AND.w #$00FF : CLC : ADC.w $0352 : TAX
        
    ; Char and property bytes for the left half of the grass/splash.
    LDA.w PlayerOam_ShadowTiles+0, Y : AND.w #$CFFF : ORA.w $035D : STA.w $0802, X
        
    ; Char and property bytes for the right half of the grass/splash.
    ; Because this is separate from the other half this leads to a stupid bug
    ; in vanilla where if you have water under a bridge in a dungeon, the right
    ; half will appear incorrectly on top of the bridge.
    LDA.w PlayerOam_ShadowTiles+2, Y : ORA.w $035D : STA.w $0806, X
        
    ; X and Y pos for left half.
    LDA.b $06 : STA.w $0800, X
    
    ; X and Y pos for right half by just adding 8 to the x pos.
    ; Why tf are you switching bytes and then adding #$0800? why not just add
    ; #$0080 and skip flipping A and B??
    XBA : CLC : ADC.w #$0800 : XBA : STA.w $0804, X

    ; Write the size and extra x bytes.
    TXA : LSR : LSR : TAX
    STZ.w $0A20, X
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06AF9D-$06AFA5 DATA
Pool_PlayerOam_Unused_0_offsets:
{
    db $00, $00, $00, $01, $00, $01, $01, $01
    db $00
}

; $06AFA6-$06AFBF LOCAL JUMP LOCATION
PlayerOam_Unused_0:
{
    SEP #$30
    
    LDX.b $2E
    
    LDA.w $0354 : CMP.b #$19 : BNE .alpha
        LDA.w PlayerOam_StairsSomething, X : TAX

    .alpha

    LDA.w .offsets, X : CLC : ADC.b $01 : STA.b $01
    
    REP #$30
    
    RTS
}

; ==============================================================================

; In general this seems to take an offset for a sprite and figure out if its
; position relative to Link and the screen will require the 9th bit of the X
; coordinate to be set.
; $06AFC0-$06AFDC LOCAL JUMP LOCATION
PlayerOam_GetRelativeHighBit:
{
    REP #$20
    
    ; Sign extend the value in the accumulator to 16-bits.
    AND.w #$00FF : CMP.w #$0080 : BCC .positive
        ORA.w #$FF00

    .positive

    CLC : ADC.b $22 : SEC : SBC.b $E2 : XBA : AND.w #$0001 : STA.w $03FA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $06AFDD-$06B07F NULL
NULL_0DAFDD:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF
}

; ==============================================================================

; $0E40 - OAM allocation and misc settings.
; $06B080-$06B172 DATA
SpriteData_OAMHarm:
{
    db $01 ; ... $01 | 0x00 - RAVEN
    db $02 ; ... $02 | 0x01 - VULTURE
    db $01 ; ... $01 | 0x02 - STALFOS HEAD
    db $82 ; h.. $02 | 0x03 - NULL
    db $81 ; h.. $01 | 0x04 - CORRECT PULL SWITCH
    db $84 ; h.. $04 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $84 ; h.. $04 | 0x06 - WRONG PULL SWITCH
    db $84 ; h.. $04 | 0x07 - UNUSED WRONG PULL SWITCH
    db $02 ; ... $02 | 0x08 - OCTOROK
    db $0F ; ... $0F | 0x09 - MOLDORM
    db $02 ; ... $02 | 0x0A - OCTOROK 4WAY
    db $01 ; ... $01 | 0x0B - CUCCO
    db $20 ; ..w $00 | 0x0C - OCTOROK STONE
    db $03 ; ... $03 | 0x0D - BUZZBLOB
    db $04 ; ... $04 | 0x0E - SNAPDRAGON
    db $84 ; h.. $04 | 0x0F - OCTOBALLOON
    db $01 ; ... $01 | 0x10 - OCTOBALLOON BABY
    db $05 ; ... $05 | 0x11 - HINOX
    db $04 ; ... $04 | 0x12 - MOBLIN
    db $01 ; ... $01 | 0x13 - MINI HELMASAUR
    db $80 ; h.. $00 | 0x14 - THIEVES TOWN GRATE
    db $04 ; ... $04 | 0x15 - ANTIFAIRY
    db $A2 ; h.w $02 | 0x16 - SAHASRAHLA / AGINAH
    db $83 ; h.. $03 | 0x17 - HOARDER
    db $04 ; ... $04 | 0x18 - MINI MOLDORM
    db $02 ; ... $02 | 0x19 - POE
    db $82 ; h.. $02 | 0x1A - SMITHY
    db $62 ; .mw $02 | 0x1B - ARROW
    db $82 ; h.. $02 | 0x1C - STATUE
    db $80 ; h.. $00 | 0x1D - FLUTEQUEST
    db $80 ; h.. $00 | 0x1E - CRYSTAL SWITCH
    db $85 ; h.. $05 | 0x1F - SICK KID
    db $01 ; ... $01 | 0x20 - SLUGGULA
    db $A5 ; h.w $05 | 0x21 - WATER SWITCH
    db $03 ; ... $03 | 0x22 - ROPA
    db $04 ; ... $04 | 0x23 - RED BARI
    db $04 ; ... $04 | 0x24 - BLUE BARI
    db $83 ; h.. $03 | 0x25 - TALKING TREE
    db $02 ; ... $02 | 0x26 - HARDHAT BEETLE
    db $01 ; ... $01 | 0x27 - DEADROCK
    db $82 ; h.. $02 | 0x28 - DARK WORLD HINT NPC
    db $A2 ; h.w $02 | 0x29 - ADULT
    db $A2 ; h.w $02 | 0x2A - SWEEPING LADY
    db $A3 ; h.w $03 | 0x2B - HOBO
    db $AA ; h.w $0A | 0x2C - LUMBERJACKS
    db $A3 ; h.w $03 | 0x2D - NECKLESS MAN
    db $A4 ; h.w $04 | 0x2E - FLUTE KID
    db $82 ; h.. $02 | 0x2F - RACE GAME LADY
    db $82 ; h.. $02 | 0x30 - RACE GAME GUY
    db $83 ; h.. $03 | 0x31 - FORTUNE TELLER
    db $82 ; h.. $02 | 0x32 - ARGUE BROS
    db $80 ; h.. $00 | 0x33 - RUPEE PULL
    db $82 ; h.. $02 | 0x34 - YOUNG SNITCH
    db $82 ; h.. $02 | 0x35 - INNKEEPER
    db $A5 ; h.w $05 | 0x36 - WITCH
    db $80 ; h.. $00 | 0x37 - WATERFALL
    db $A4 ; h.w $04 | 0x38 - EYE STATUE
    db $82 ; h.. $02 | 0x39 - LOCKSMITH
    db $81 ; h.. $01 | 0x3A - MAGIC BAT
    db $82 ; h.. $02 | 0x3B - BONK ITEM
    db $82 ; h.. $02 | 0x3C - KID IN KAK
    db $82 ; h.. $02 | 0x3D - OLD SNITCH
    db $81 ; h.. $01 | 0x3E - HOARDER
    db $06 ; ... $06 | 0x3F - TUTORIAL GUARD
    db $08 ; ... $08 | 0x40 - LIGHTNING GATE
    db $08 ; ... $08 | 0x41 - BLUE GUARD
    db $08 ; ... $08 | 0x42 - GREEN GUARD
    db $08 ; ... $08 | 0x43 - RED SPEAR GUARD
    db $06 ; ... $06 | 0x44 - BLUESAIN BOLT
    db $08 ; ... $08 | 0x45 - USAIN BOLT
    db $08 ; ... $08 | 0x46 - BLUE ARCHER
    db $08 ; ... $08 | 0x47 - GREEN BUSH GUARD
    db $06 ; ... $06 | 0x48 - RED JAVELIN GUARD
    db $07 ; ... $07 | 0x49 - RED BUSH GUARD
    db $07 ; ... $07 | 0x4A - BOMB GUARD
    db $02 ; ... $02 | 0x4B - GREEN KNIFE GUARD
    db $02 ; ... $02 | 0x4C - GELDMAN
    db $22 ; ..w $02 | 0x4D - TOPPO
    db $01 ; ... $01 | 0x4E - POPO
    db $01 ; ... $01 | 0x4F - POPO
    db $20 ; ..w $00 | 0x50 - CANNONBALL
    db $82 ; h.. $02 | 0x51 - ARMOS STATUE
    db $07 ; ... $07 | 0x52 - KING ZORA
    db $85 ; h.. $05 | 0x53 - ARMOS KNIGHT
    db $0F ; ... $0F | 0x54 - LANMOLAS
    db $21 ; ..w $01 | 0x55 - ZORA / FIREBALL
    db $05 ; ... $05 | 0x56 - ZORA
    db $83 ; h.. $03 | 0x57 - DESERT STATUE
    db $02 ; ... $02 | 0x58 - CRAB
    db $01 ; ... $01 | 0x59 - LOST WOODS BIRD
    db $01 ; ... $01 | 0x5A - LOST WOODS SQUIRREL
    db $01 ; ... $01 | 0x5B - SPARK
    db $01 ; ... $01 | 0x5C - SPARK
    db $07 ; ... $07 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $07 ; ... $07 | 0x5E - ROLLER VERTICAL UP FIRST
    db $07 ; ... $07 | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $07 ; ... $07 | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $00 ; ... $00 | 0x61 - BEAMOS
    db $85 ; h.. $05 | 0x62 - MASTERSWORD
    db $83 ; h.. $03 | 0x63 - DEBIRANDO PIT
    db $03 ; ... $03 | 0x64 - DEBIRANDO
    db $A4 ; h.w $04 | 0x65 - ARCHERY GUY
    db $00 ; ... $00 | 0x66 - WALL CANNON VERTICAL LEFT
    db $00 ; ... $00 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $00 ; ... $00 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $00 ; ... $00 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $09 ; ... $09 | 0x6A - BALL N CHAIN
    db $04 ; ... $04 | 0x6B - CANNONBALL / CANNON TROOPER
    db $A0 ; h.w $00 | 0x6C - MIRROR PORTAL
    db $00 ; ... $00 | 0x6D - RAT / CRICKET
    db $01 ; ... $01 | 0x6E - SNAKE
    db $00 ; ... $00 | 0x6F - KEESE
    db $00 ; ... $00 | 0x70 - KING HELMASAUR FIREBALL
    db $03 ; ... $03 | 0x71 - LEEVER
    db $8B ; h.. $0B | 0x72 - FAIRY POND TRIGGER
    db $86 ; h.. $06 | 0x73 - UNCLE / PRIEST / MANTLE
    db $C2 ; hm. $02 | 0x74 - RUNNING MAN
    db $82 ; h.. $02 | 0x75 - BOTTLE MERCHANT
    db $81 ; h.. $01 | 0x76 - ZELDA
    db $04 ; ... $04 | 0x77 - ANTIFAIRY
    db $82 ; h.. $02 | 0x78 - SAHASRAHLAS WIFE
    db $21 ; ..w $01 | 0x79 - BEE
    db $06 ; ... $06 | 0x7A - AGAHNIM
    db $03 ; ... $03 | 0x7B - AGAHNIMS BALLS
    db $01 ; ... $01 | 0x7C - GREEN STALFOS
    db $03 ; ... $03 | 0x7D - BIG SPIKE
    db $03 ; ... $03 | 0x7E - FIREBAR CLOCKWISE
    db $03 ; ... $03 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $00 ; ... $00 | 0x80 - FIRESNAKE
    db $00 ; ... $00 | 0x81 - HOVER
    db $04 ; ... $04 | 0x82 - ANTIFAIRY CIRCLE
    db $05 ; ... $05 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $05 ; ... $05 | 0x84 - RED EYEGORE / RED MIMIC
    db $03 ; ... $03 | 0x85 - YELLOW STALFOS
    db $01 ; ... $01 | 0x86 - KODONGO
    db $02 ; ... $02 | 0x87 - KONDONGO FIRE
    db $00 ; ... $00 | 0x88 - MOTHULA
    db $00 ; ... $00 | 0x89 - MOTHULA BEAM
    db $00 ; ... $00 | 0x8A - SPIKE BLOCK
    db $02 ; ... $02 | 0x8B - GIBDO
    db $07 ; ... $07 | 0x8C - ARRGHUS
    db $00 ; ... $00 | 0x8D - ARRGHI
    db $01 ; ... $01 | 0x8E - TERRORPIN
    db $01 ; ... $01 | 0x8F - BLOB
    db $87 ; h.. $07 | 0x90 - WALLMASTER
    db $06 ; ... $06 | 0x91 - STALFOS KNIGHT
    db $00 ; ... $00 | 0x92 - KING HELMASAUR
    db $83 ; h.. $03 | 0x93 - BUMPER
    db $02 ; ... $02 | 0x94 - PIROGUSU
    db $22 ; ..w $02 | 0x95 - LASER EYE LEFT
    db $22 ; ..w $02 | 0x96 - LASER EYE RIGHT
    db $22 ; ..w $02 | 0x97 - LASER EYE TOP
    db $22 ; ..w $02 | 0x98 - LASER EYE BOTTOM
    db $04 ; ... $04 | 0x99 - PENGATOR
    db $03 ; ... $03 | 0x9A - KYAMERON
    db $05 ; ... $05 | 0x9B - WIZZROBE
    db $01 ; ... $01 | 0x9C - ZORO
    db $01 ; ... $01 | 0x9D - BABASU
    db $04 ; ... $04 | 0x9E - HAUNTED GROVE OSTRITCH
    db $01 ; ... $01 | 0x9F - HAUNTED GROVE RABBIT
    db $02 ; ... $02 | 0xA0 - HAUNTED GROVE BIRD
    db $08 ; ... $08 | 0xA1 - FREEZOR
    db $08 ; ... $08 | 0xA2 - KHOLDSTARE
    db $80 ; h.. $00 | 0xA3 - KHOLDSTARE SHELL
    db $21 ; ..w $01 | 0xA4 - FALLING ICE
    db $03 ; ... $03 | 0xA5 - BLUE ZAZAK
    db $03 ; ... $03 | 0xA6 - RED ZAZAK
    db $03 ; ... $03 | 0xA7 - STALFOS
    db $02 ; ... $02 | 0xA8 - GREEN ZIRRO
    db $02 ; ... $02 | 0xA9 - BLUE ZIRRO
    db $08 ; ... $08 | 0xAA - PIKIT
    db $8F ; h.. $0F | 0xAB - CRYSTAL MAIDEN
    db $A1 ; h.w $01 | 0xAC - APPLE
    db $81 ; h.. $01 | 0xAD - OLD MAN
    db $80 ; h.. $00 | 0xAE - PIPE DOWN
    db $80 ; h.. $00 | 0xAF - PIPE UP
    db $80 ; h.. $00 | 0xB0 - PIPE RIGHT
    db $80 ; h.. $00 | 0xB1 - PIPE LEFT
    db $A1 ; h.w $01 | 0xB2 - GOOD BEE
    db $80 ; h.. $00 | 0xB3 - PEDESTAL PLAQUE
    db $81 ; h.. $01 | 0xB4 - PURPLE CHEST
    db $81 ; h.. $01 | 0xB5 - BOMB SHOP GUY
    db $86 ; h.. $06 | 0xB6 - KIKI
    db $81 ; h.. $01 | 0xB7 - BLIND MAIDEN
    db $82 ; h.. $02 | 0xB8 - DIALOGUE TESTER
    db $82 ; h.. $02 | 0xB9 - BULLY / PINK BALL
    db $80 ; h.. $00 | 0xBA - WHIRLPOOL
    db $80 ; h.. $00 | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $83 ; h.. $03 | 0xBC - DRUNKARD
    db $06 ; ... $06 | 0xBD - VITREOUS
    db $00 ; ... $00 | 0xBE - VITREOUS SMALL EYE
    db $00 ; ... $00 | 0xBF - LIGHTNING
    db $05 ; ... $05 | 0xC0 - CATFISH
    db $04 ; ... $04 | 0xC1 - CUTSCENE AGAHNIM
    db $06 ; ... $06 | 0xC2 - BOULDER
    db $05 ; ... $05 | 0xC3 - GIBO
    db $02 ; ... $02 | 0xC4 - THIEF
    db $00 ; ... $00 | 0xC5 - MEDUSA
    db $00 ; ... $00 | 0xC6 - 4WAY SHOOTER
    db $05 ; ... $05 | 0xC7 - POKEY
    db $04 ; ... $04 | 0xC8 - BIG FAIRY
    db $04 ; ... $04 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $07 ; ... $07 | 0xCA - CHAIN CHOMP
    db $0B ; ... $0B | 0xCB - TRINEXX ROCK HEAD
    db $0C ; ... $0C | 0xCC - TRINEXX FIRE HEAD
    db $0C ; ... $0C | 0xCD - TRINEXX ICE HEAD
    db $06 ; ... $06 | 0xCE - BLIND
    db $06 ; ... $06 | 0xCF - SWAMOLA
    db $03 ; ... $03 | 0xD0 - LYNEL
    db $A4 ; h.w $04 | 0xD1 - BUNNYBEAM / SMOKE
    db $04 ; ... $04 | 0xD2 - FLOPPING FISH
    db $82 ; h.. $02 | 0xD3 - STAL
    db $81 ; h.. $01 | 0xD4 - LANDMINE
    db $83 ; h.. $03 | 0xD5 - DIG GAME GUY
    db $10 ; ... $10 | 0xD6 - GANON
    db $10 ; ... $10 | 0xD7 - GANON
    db $81 ; h.. $01 | 0xD8 - HEART
    db $82 ; h.. $02 | 0xD9 - GREEN RUPEE
    db $82 ; h.. $02 | 0xDA - BLUE RUPEE
    db $82 ; h.. $02 | 0xDB - RED RUPEE
    db $83 ; h.. $03 | 0xDC - BOMB REFILL 1
    db $83 ; h.. $03 | 0xDD - BOMB REFILL 4
    db $83 ; h.. $03 | 0xDE - BOMB REFILL 8
    db $81 ; h.. $01 | 0xDF - SMALL MAGIC DECANTER
    db $82 ; h.. $02 | 0xE0 - LARGE MAGIC DECANTER
    db $83 ; h.. $03 | 0xE1 - ARROW REFILL 5
    db $83 ; h.. $03 | 0xE2 - ARROW REFILL 10
    db $81 ; h.. $01 | 0xE3 - FAIRY
    db $82 ; h.. $02 | 0xE4 - SMALL KEY
    db $81 ; h.. $01 | 0xE5 - BIG KEY
    db $82 ; h.. $02 | 0xE6 - STOLEN SHIELD
    db $A0 ; h.w $00 | 0xE7 - MUSHROOM
    db $A1 ; h.w $01 | 0xE8 - FAKE MASTER SWORD
    db $A3 ; h.w $03 | 0xE9 - MAGIC SHOP ASSISTANT
    db $A1 ; h.w $01 | 0xEA - HEART CONTAINER
    db $A1 ; h.w $01 | 0xEB - HEART PIECE
    db $A1 ; h.w $01 | 0xEC - THROWN ITEM
    db $83 ; h.. $03 | 0xED - SOMARIA PLATFORM
    db $85 ; h.. $05 | 0xEE - CASTLE MANTLE
    db $83 ; h.. $03 | 0xEF - UNUSED SOMARIA PLATFORM
    db $83 ; h.. $03 | 0xF0 - UNUSED SOMARIA PLATFORM
    db $83 ; h.. $03 | 0xF1 - UNUSED SOMARIA PLATFORM
    db $83 ; h.. $03 | 0xF2 - MEDALLION TABLET
}
    
; $0E50 - Health
; $06B173-$06B265 DATA
SpriteData_Health:
{
    db $0C ; 0x00 - RAVEN
    db $06 ; 0x01 - VULTURE
    db $FF ; 0x02 - STALFOS HEAD
    db $03 ; 0x03 - NULL
    db $03 ; 0x04 - CORRECT PULL SWITCH
    db $03 ; 0x05 - UNUSED CORRECT PULL SWITCH
    db $03 ; 0x06 - WRONG PULL SWITCH
    db $03 ; 0x07 - UNUSED WRONG PULL SWITCH
    db $02 ; 0x08 - OCTOROK
    db $0C ; 0x09 - MOLDORM
    db $04 ; 0x0A - OCTOROK 4WAY
    db $FF ; 0x0B - CUCCO
    db $00 ; 0x0C - OCTOROK STONE
    db $03 ; 0x0D - BUZZBLOB
    db $0C ; 0x0E - SNAPDRAGON
    db $02 ; 0x0F - OCTOBALLOON
    db $00 ; 0x10 - OCTOBALLOON BABY
    db $14 ; 0x11 - HINOX
    db $04 ; 0x12 - MOBLIN
    db $04 ; 0x13 - MINI HELMASAUR
    db $00 ; 0x14 - THIEVES TOWN GRATE
    db $FF ; 0x15 - ANTIFAIRY
    db $00 ; 0x16 - SAHASRAHLA / AGINAH
    db $02 ; 0x17 - HOARDER
    db $03 ; 0x18 - MINI MOLDORM
    db $08 ; 0x19 - POE
    db $00 ; 0x1A - SMITHY
    db $00 ; 0x1B - ARROW
    db $00 ; 0x1C - STATUE
    db $00 ; 0x1D - FLUTEQUEST
    db $00 ; 0x1E - CRYSTAL SWITCH
    db $00 ; 0x1F - SICK KID
    db $08 ; 0x20 - SLUGGULA
    db $03 ; 0x21 - WATER SWITCH
    db $08 ; 0x22 - ROPA
    db $02 ; 0x23 - RED BARI
    db $02 ; 0x24 - BLUE BARI
    db $00 ; 0x25 - TALKING TREE
    db $03 ; 0x26 - HARDHAT BEETLE
    db $FF ; 0x27 - DEADROCK
    db $00 ; 0x28 - DARK WORLD HINT NPC
    db $03 ; 0x29 - ADULT
    db $03 ; 0x2A - SWEEPING LADY
    db $03 ; 0x2B - HOBO
    db $03 ; 0x2C - LUMBERJACKS
    db $03 ; 0x2D - NECKLESS MAN
    db $03 ; 0x2E - FLUTE KID
    db $03 ; 0x2F - RACE GAME LADY
    db $03 ; 0x30 - RACE GAME GUY
    db $00 ; 0x31 - FORTUNE TELLER
    db $03 ; 0x32 - ARGUE BROS
    db $00 ; 0x33 - RUPEE PULL
    db $03 ; 0x34 - YOUNG SNITCH
    db $03 ; 0x35 - INNKEEPER
    db $03 ; 0x36 - WITCH
    db $00 ; 0x37 - WATERFALL
    db $03 ; 0x38 - EYE STATUE
    db $00 ; 0x39 - LOCKSMITH
    db $00 ; 0x3A - MAGIC BAT
    db $00 ; 0x3B - BONK ITEM
    db $00 ; 0x3C - KID IN KAK
    db $03 ; 0x3D - OLD SNITCH
    db $02 ; 0x3E - HOARDER
    db $FF ; 0x3F - TUTORIAL GUARD
    db $02 ; 0x40 - LIGHTNING GATE
    db $06 ; 0x41 - BLUE GUARD
    db $04 ; 0x42 - GREEN GUARD
    db $08 ; 0x43 - RED SPEAR GUARD
    db $06 ; 0x44 - BLUESAIN BOLT
    db $08 ; 0x45 - USAIN BOLT
    db $06 ; 0x46 - BLUE ARCHER
    db $04 ; 0x47 - GREEN BUSH GUARD
    db $08 ; 0x48 - RED JAVELIN GUARD
    db $08 ; 0x49 - RED BUSH GUARD
    db $08 ; 0x4A - BOMB GUARD
    db $04 ; 0x4B - GREEN KNIFE GUARD
    db $04 ; 0x4C - GELDMAN
    db $02 ; 0x4D - TOPPO
    db $02 ; 0x4E - POPO
    db $02 ; 0x4F - POPO
    db $FF ; 0x50 - CANNONBALL
    db $08 ; 0x51 - ARMOS STATUE
    db $FF ; 0x52 - KING ZORA
    db $30 ; 0x53 - ARMOS KNIGHT
    db $10 ; 0x54 - LANMOLAS
    db $08 ; 0x55 - ZORA / FIREBALL
    db $08 ; 0x56 - ZORA
    db $FF ; 0x57 - DESERT STATUE
    db $02 ; 0x58 - CRAB
    db $00 ; 0x59 - LOST WOODS BIRD
    db $00 ; 0x5A - LOST WOODS SQUIRREL
    db $FF ; 0x5B - SPARK
    db $FF ; 0x5C - SPARK
    db $FF ; 0x5D - ROLLER VERTICAL DOWN FIRST
    db $FF ; 0x5E - ROLLER VERTICAL UP FIRST
    db $FF ; 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $FF ; 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $FF ; 0x61 - BEAMOS
    db $FF ; 0x62 - MASTERSWORD
    db $FF ; 0x63 - DEBIRANDO PIT
    db $04 ; 0x64 - DEBIRANDO
    db $04 ; 0x65 - ARCHERY GUY
    db $FF ; 0x66 - WALL CANNON VERTICAL LEFT
    db $FF ; 0x67 - WALL CANNON VERTICAL RIGHT
    db $FF ; 0x68 - WALL CANNON HORIZONTAL TOP
    db $FF ; 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $10 ; 0x6A - BALL N CHAIN
    db $03 ; 0x6B - CANNONBALL / CANNON TROOPER
    db $00 ; 0x6C - MIRROR PORTAL
    db $02 ; 0x6D - RAT / CRICKET
    db $04 ; 0x6E - SNAKE
    db $01 ; 0x6F - KEESE
    db $FF ; 0x70 - KING HELMASAUR FIREBALL
    db $04 ; 0x71 - LEEVER
    db $FF ; 0x72 - FAIRY POND TRIGGER
    db $00 ; 0x73 - UNCLE / PRIEST / MANTLE
    db $00 ; 0x74 - RUNNING MAN
    db $00 ; 0x75 - BOTTLE MERCHANT
    db $00 ; 0x76 - ZELDA
    db $FF ; 0x77 - ANTIFAIRY
    db $00 ; 0x78 - SAHASRAHLAS WIFE
    db $00 ; 0x79 - BEE
    db $60 ; 0x7A - AGAHNIM
    db $FF ; 0x7B - AGAHNIMS BALLS
    db $18 ; 0x7C - GREEN STALFOS
    db $FF ; 0x7D - BIG SPIKE
    db $FF ; 0x7E - FIREBAR CLOCKWISE
    db $FF ; 0x7F - FIREBAR COUNTERCLOCKWISE
    db $03 ; 0x80 - FIRESNAKE
    db $04 ; 0x81 - HOVER
    db $FF ; 0x82 - ANTIFAIRY CIRCLE
    db $10 ; 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $08 ; 0x84 - RED EYEGORE / RED MIMIC
    db $08 ; 0x85 - YELLOW STALFOS
    db $00 ; 0x86 - KODONGO
    db $FF ; 0x87 - KONDONGO FIRE
    db $20 ; 0x88 - MOTHULA
    db $20 ; 0x89 - MOTHULA BEAM
    db $20 ; 0x8A - SPIKE BLOCK
    db $20 ; 0x8B - GIBDO
    db $20 ; 0x8C - ARRGHUS
    db $08 ; 0x8D - ARRGHI
    db $08 ; 0x8E - TERRORPIN
    db $04 ; 0x8F - BLOB
    db $08 ; 0x90 - WALLMASTER
    db $40 ; 0x91 - STALFOS KNIGHT
    db $30 ; 0x92 - KING HELMASAUR
    db $FF ; 0x93 - BUMPER
    db $02 ; 0x94 - PIROGUSU
    db $FF ; 0x95 - LASER EYE LEFT
    db $FF ; 0x96 - LASER EYE RIGHT
    db $FF ; 0x97 - LASER EYE TOP
    db $FF ; 0x98 - LASER EYE BOTTOM
    db $10 ; 0x99 - PENGATOR
    db $04 ; 0x9A - KYAMERON
    db $02 ; 0x9B - WIZZROBE
    db $04 ; 0x9C - ZORO
    db $04 ; 0x9D - BABASU
    db $08 ; 0x9E - HAUNTED GROVE OSTRITCH
    db $08 ; 0x9F - HAUNTED GROVE RABBIT
    db $08 ; 0xA0 - HAUNTED GROVE BIRD
    db $10 ; 0xA1 - FREEZOR
    db $40 ; 0xA2 - KHOLDSTARE
    db $40 ; 0xA3 - KHOLDSTARE SHELL
    db $08 ; 0xA4 - FALLING ICE
    db $04 ; 0xA5 - BLUE ZAZAK
    db $08 ; 0xA6 - RED ZAZAK
    db $04 ; 0xA7 - STALFOS
    db $04 ; 0xA8 - GREEN ZIRRO
    db $08 ; 0xA9 - BLUE ZIRRO
    db $0C ; 0xAA - PIKIT
    db $10 ; 0xAB - CRYSTAL MAIDEN
    db $00 ; 0xAC - APPLE
    db $00 ; 0xAD - OLD MAN
    db $00 ; 0xAE - PIPE DOWN
    db $00 ; 0xAF - PIPE UP
    db $00 ; 0xB0 - PIPE RIGHT
    db $00 ; 0xB1 - PIPE LEFT
    db $00 ; 0xB2 - GOOD BEE
    db $00 ; 0xB3 - PEDESTAL PLAQUE
    db $00 ; 0xB4 - PURPLE CHEST
    db $00 ; 0xB5 - BOMB SHOP GUY
    db $00 ; 0xB6 - KIKI
    db $00 ; 0xB7 - BLIND MAIDEN
    db $00 ; 0xB8 - DIALOGUE TESTER
    db $00 ; 0xB9 - BULLY / PINK BALL
    db $00 ; 0xBA - WHIRLPOOL
    db $00 ; 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $00 ; 0xBC - DRUNKARD
    db $80 ; 0xBD - VITREOUS
    db $30 ; 0xBE - VITREOUS SMALL EYE
    db $FF ; 0xBF - LIGHTNING
    db $FF ; 0xC0 - CATFISH
    db $FF ; 0xC1 - CUTSCENE AGAHNIM
    db $FF ; 0xC2 - BOULDER
    db $08 ; 0xC3 - GIBO
    db $00 ; 0xC4 - THIEF
    db $00 ; 0xC5 - MEDUSA
    db $00 ; 0xC6 - 4WAY SHOOTER
    db $20 ; 0xC7 - POKEY
    db $00 ; 0xC8 - BIG FAIRY
    db $08 ; 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $05 ; 0xCA - CHAIN CHOMP
    db $28 ; 0xCB - TRINEXX ROCK HEAD
    db $28 ; 0xCC - TRINEXX FIRE HEAD
    db $28 ; 0xCD - TRINEXX ICE HEAD
    db $5A ; 0xCE - BLIND
    db $10 ; 0xCF - SWAMOLA
    db $18 ; 0xD0 - LYNEL
    db $40 ; 0xD1 - BUNNYBEAM / SMOKE
    db $00 ; 0xD2 - FLOPPING FISH
    db $04 ; 0xD3 - STAL
    db $00 ; 0xD4 - LANDMINE
    db $00 ; 0xD5 - DIG GAME GUY
    db $FF ; 0xD6 - GANON
    db $FF ; 0xD7 - GANON
    db $00 ; 0xD8 - HEART
    db $00 ; 0xD9 - GREEN RUPEE
    db $00 ; 0xDA - BLUE RUPEE
    db $00 ; 0xDB - RED RUPEE
    db $00 ; 0xDC - BOMB REFILL 1
    db $00 ; 0xDD - BOMB REFILL 4
    db $00 ; 0xDE - BOMB REFILL 8
    db $00 ; 0xDF - SMALL MAGIC DECANTER
    db $00 ; 0xE0 - LARGE MAGIC DECANTER
    db $00 ; 0xE1 - ARROW REFILL 5
    db $00 ; 0xE2 - ARROW REFILL 10
    db $00 ; 0xE3 - FAIRY
    db $00 ; 0xE4 - SMALL KEY
    db $00 ; 0xE5 - BIG KEY
    db $00 ; 0xE6 - STOLEN SHIELD
    db $00 ; 0xE7 - MUSHROOM
    db $00 ; 0xE8 - FAKE MASTER SWORD
    db $00 ; 0xE9 - MAGIC SHOP ASSISTANT
    db $00 ; 0xEA - HEART CONTAINER
    db $00 ; 0xEB - HEART PIECE
    db $00 ; 0xEC - THROWN ITEM
    db $00 ; 0xED - SOMARIA PLATFORM
    db $00 ; 0xEE - CASTLE MANTLE
    db $00 ; 0xEF - UNUSED SOMARIA PLATFORM
    db $00 ; 0xF0 - UNUSED SOMARIA PLATFORM
    db $00 ; 0xF1 - UNUSED SOMARIA PLATFORM
    db $00 ; 0xF2 - MEDALLION TABLET
}    

; Goes into $0CD2 - Bump damage.
; $06B266-$06B358 DATA
SpriteData_Bump:
{
    db $83 ; t... $3 | 0x00 - RAVEN
    db $83 ; t... $3 | 0x01 - VULTURE
    db $81 ; t... $1 | 0x02 - STALFOS HEAD
    db $02 ; .... $2 | 0x03 - NULL
    db $02 ; .... $2 | 0x04 - CORRECT PULL SWITCH
    db $02 ; .... $2 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $02 ; .... $2 | 0x06 - WRONG PULL SWITCH
    db $02 ; .... $2 | 0x07 - UNUSED WRONG PULL SWITCH
    db $01 ; .... $1 | 0x08 - OCTOROK
    db $13 ; ...d $3 | 0x09 - MOLDORM
    db $01 ; .... $1 | 0x0A - OCTOROK 4WAY
    db $01 ; .... $1 | 0x0B - CUCCO
    db $01 ; .... $1 | 0x0C - OCTOROK STONE
    db $01 ; .... $1 | 0x0D - BUZZBLOB
    db $08 ; .... $8 | 0x0E - SNAPDRAGON
    db $01 ; .... $1 | 0x0F - OCTOBALLOON
    db $01 ; .... $1 | 0x10 - OCTOBALLOON BABY
    db $08 ; .... $8 | 0x11 - HINOX
    db $05 ; .... $5 | 0x12 - MOBLIN
    db $03 ; .... $3 | 0x13 - MINI HELMASAUR
    db $40 ; .z.. $0 | 0x14 - THIEVES TOWN GRATE
    db $04 ; .... $4 | 0x15 - ANTIFAIRY
    db $00 ; .... $0 | 0x16 - SAHASRAHLA / AGINAH
    db $02 ; .... $2 | 0x17 - HOARDER
    db $03 ; .... $3 | 0x18 - MINI MOLDORM
    db $85 ; t... $5 | 0x19 - POE
    db $00 ; .... $0 | 0x1A - SMITHY
    db $01 ; .... $1 | 0x1B - ARROW
    db $00 ; .... $0 | 0x1C - STATUE
    db $40 ; .z.. $0 | 0x1D - FLUTEQUEST
    db $00 ; .... $0 | 0x1E - CRYSTAL SWITCH
    db $00 ; .... $0 | 0x1F - SICK KID
    db $06 ; .... $6 | 0x20 - SLUGGULA
    db $00 ; .... $0 | 0x21 - WATER SWITCH
    db $05 ; .... $5 | 0x22 - ROPA
    db $03 ; .... $3 | 0x23 - RED BARI
    db $01 ; .... $1 | 0x24 - BLUE BARI
    db $00 ; .... $0 | 0x25 - TALKING TREE
    db $00 ; .... $0 | 0x26 - HARDHAT BEETLE
    db $03 ; .... $3 | 0x27 - DEADROCK
    db $00 ; .... $0 | 0x28 - DARK WORLD HINT NPC
    db $00 ; .... $0 | 0x29 - ADULT
    db $00 ; .... $0 | 0x2A - SWEEPING LADY
    db $00 ; .... $0 | 0x2B - HOBO
    db $00 ; .... $0 | 0x2C - LUMBERJACKS
    db $00 ; .... $0 | 0x2D - NECKLESS MAN
    db $00 ; .... $0 | 0x2E - FLUTE KID
    db $00 ; .... $0 | 0x2F - RACE GAME LADY
    db $00 ; .... $0 | 0x30 - RACE GAME GUY
    db $00 ; .... $0 | 0x31 - FORTUNE TELLER
    db $00 ; .... $0 | 0x32 - ARGUE BROS
    db $00 ; .... $0 | 0x33 - RUPEE PULL
    db $00 ; .... $0 | 0x34 - YOUNG SNITCH
    db $00 ; .... $0 | 0x35 - INNKEEPER
    db $00 ; .... $0 | 0x36 - WITCH
    db $40 ; .z.. $0 | 0x37 - WATERFALL
    db $00 ; .... $0 | 0x38 - EYE STATUE
    db $00 ; .... $0 | 0x39 - LOCKSMITH
    db $00 ; .... $0 | 0x3A - MAGIC BAT
    db $00 ; .... $0 | 0x3B - BONK ITEM
    db $00 ; .... $0 | 0x3C - KID IN KAK
    db $00 ; .... $0 | 0x3D - OLD SNITCH
    db $02 ; .... $2 | 0x3E - HOARDER
    db $02 ; .... $2 | 0x3F - TUTORIAL GUARD
    db $00 ; .... $0 | 0x40 - LIGHTNING GATE
    db $01 ; .... $1 | 0x41 - BLUE GUARD
    db $01 ; .... $1 | 0x42 - GREEN GUARD
    db $03 ; .... $3 | 0x43 - RED SPEAR GUARD
    db $01 ; .... $1 | 0x44 - BLUESAIN BOLT
    db $03 ; .... $3 | 0x45 - USAIN BOLT
    db $01 ; .... $1 | 0x46 - BLUE ARCHER
    db $01 ; .... $1 | 0x47 - GREEN BUSH GUARD
    db $03 ; .... $3 | 0x48 - RED JAVELIN GUARD
    db $03 ; .... $3 | 0x49 - RED BUSH GUARD
    db $03 ; .... $3 | 0x4A - BOMB GUARD
    db $01 ; .... $1 | 0x4B - GREEN KNIFE GUARD
    db $03 ; .... $3 | 0x4C - GELDMAN
    db $01 ; .... $1 | 0x4D - TOPPO
    db $01 ; .... $1 | 0x4E - POPO
    db $01 ; .... $1 | 0x4F - POPO
    db $01 ; .... $1 | 0x50 - CANNONBALL
    db $01 ; .... $1 | 0x51 - ARMOS STATUE
    db $01 ; .... $1 | 0x52 - KING ZORA
    db $11 ; ...d $1 | 0x53 - ARMOS KNIGHT
    db $14 ; ...d $4 | 0x54 - LANMOLAS
    db $01 ; .... $1 | 0x55 - ZORA / FIREBALL
    db $01 ; .... $1 | 0x56 - ZORA
    db $02 ; .... $2 | 0x57 - DESERT STATUE
    db $05 ; .... $5 | 0x58 - CRAB
    db $00 ; .... $0 | 0x59 - LOST WOODS BIRD
    db $00 ; .... $0 | 0x5A - LOST WOODS SQUIRREL
    db $04 ; .... $4 | 0x5B - SPARK
    db $04 ; .... $4 | 0x5C - SPARK
    db $08 ; .... $8 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $08 ; .... $8 | 0x5E - ROLLER VERTICAL UP FIRST
    db $08 ; .... $8 | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $08 ; .... $8 | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $04 ; .... $4 | 0x61 - BEAMOS
    db $00 ; .... $0 | 0x62 - MASTERSWORD
    db $04 ; .... $4 | 0x63 - DEBIRANDO PIT
    db $03 ; .... $3 | 0x64 - DEBIRANDO
    db $02 ; .... $2 | 0x65 - ARCHERY GUY
    db $02 ; .... $2 | 0x66 - WALL CANNON VERTICAL LEFT
    db $02 ; .... $2 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $02 ; .... $2 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $02 ; .... $2 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $03 ; .... $3 | 0x6A - BALL N CHAIN
    db $01 ; .... $1 | 0x6B - CANNONBALL / CANNON TROOPER
    db $00 ; .... $0 | 0x6C - MIRROR PORTAL
    db $00 ; .... $0 | 0x6D - RAT / CRICKET
    db $01 ; .... $1 | 0x6E - SNAKE
    db $80 ; t... $0 | 0x6F - KEESE
    db $05 ; .... $5 | 0x70 - KING HELMASAUR FIREBALL
    db $01 ; .... $1 | 0x71 - LEEVER
    db $00 ; .... $0 | 0x72 - FAIRY POND TRIGGER
    db $00 ; .... $0 | 0x73 - UNCLE / PRIEST / MANTLE
    db $00 ; .... $0 | 0x74 - RUNNING MAN
    db $40 ; .z.. $0 | 0x75 - BOTTLE MERCHANT
    db $00 ; .... $0 | 0x76 - ZELDA
    db $04 ; .... $4 | 0x77 - ANTIFAIRY
    db $00 ; .... $0 | 0x78 - SAHASRAHLAS WIFE
    db $00 ; .... $0 | 0x79 - BEE
    db $14 ; ...d $4 | 0x7A - AGAHNIM
    db $04 ; .... $4 | 0x7B - AGAHNIMS BALLS
    db $06 ; .... $6 | 0x7C - GREEN STALFOS
    db $04 ; .... $4 | 0x7D - BIG SPIKE
    db $04 ; .... $4 | 0x7E - FIREBAR CLOCKWISE
    db $04 ; .... $4 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $04 ; .... $4 | 0x80 - FIRESNAKE
    db $03 ; .... $3 | 0x81 - HOVER
    db $04 ; .... $4 | 0x82 - ANTIFAIRY CIRCLE
    db $04 ; .... $4 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $04 ; .... $4 | 0x84 - RED EYEGORE / RED MIMIC
    db $01 ; .... $1 | 0x85 - YELLOW STALFOS
    db $04 ; .... $4 | 0x86 - KODONGO
    db $04 ; .... $4 | 0x87 - KONDONGO FIRE
    db $15 ; ...d $5 | 0x88 - MOTHULA
    db $05 ; .... $5 | 0x89 - MOTHULA BEAM
    db $04 ; .... $4 | 0x8A - SPIKE BLOCK
    db $05 ; .... $5 | 0x8B - GIBDO
    db $15 ; ...d $5 | 0x8C - ARRGHUS
    db $15 ; ...d $5 | 0x8D - ARRGHI
    db $03 ; .... $3 | 0x8E - TERRORPIN
    db $05 ; .... $5 | 0x8F - BLOB
    db $00 ; .... $0 | 0x90 - WALLMASTER
    db $05 ; .... $5 | 0x91 - STALFOS KNIGHT
    db $15 ; ...d $5 | 0x92 - KING HELMASAUR
    db $05 ; .... $5 | 0x93 - BUMPER
    db $05 ; .... $5 | 0x94 - PIROGUSU
    db $06 ; .... $6 | 0x95 - LASER EYE LEFT
    db $06 ; .... $6 | 0x96 - LASER EYE RIGHT
    db $06 ; .... $6 | 0x97 - LASER EYE TOP
    db $06 ; .... $6 | 0x98 - LASER EYE BOTTOM
    db $05 ; .... $5 | 0x99 - PENGATOR
    db $03 ; .... $3 | 0x9A - KYAMERON
    db $06 ; .... $6 | 0x9B - WIZZROBE
    db $05 ; .... $5 | 0x9C - ZORO
    db $05 ; .... $5 | 0x9D - BABASU
    db $03 ; .... $3 | 0x9E - HAUNTED GROVE OSTRITCH
    db $03 ; .... $3 | 0x9F - HAUNTED GROVE RABBIT
    db $03 ; .... $3 | 0xA0 - HAUNTED GROVE BIRD
    db $06 ; .... $6 | 0xA1 - FREEZOR
    db $17 ; ...d $7 | 0xA2 - KHOLDSTARE
    db $15 ; ...d $5 | 0xA3 - KHOLDSTARE SHELL
    db $15 ; ...d $5 | 0xA4 - FALLING ICE
    db $05 ; .... $5 | 0xA5 - BLUE ZAZAK
    db $05 ; .... $5 | 0xA6 - RED ZAZAK
    db $01 ; .... $1 | 0xA7 - STALFOS
    db $85 ; t... $5 | 0xA8 - GREEN ZIRRO
    db $83 ; t... $3 | 0xA9 - BLUE ZIRRO
    db $05 ; .... $5 | 0xAA - PIKIT
    db $04 ; .... $4 | 0xAB - CRYSTAL MAIDEN
    db $00 ; .... $0 | 0xAC - APPLE
    db $00 ; .... $0 | 0xAD - OLD MAN
    db $00 ; .... $0 | 0xAE - PIPE DOWN
    db $00 ; .... $0 | 0xAF - PIPE UP
    db $00 ; .... $0 | 0xB0 - PIPE RIGHT
    db $00 ; .... $0 | 0xB1 - PIPE LEFT
    db $00 ; .... $0 | 0xB2 - GOOD BEE
    db $00 ; .... $0 | 0xB3 - PEDESTAL PLAQUE
    db $00 ; .... $0 | 0xB4 - PURPLE CHEST
    db $00 ; .... $0 | 0xB5 - BOMB SHOP GUY
    db $00 ; .... $0 | 0xB6 - KIKI
    db $00 ; .... $0 | 0xB7 - BLIND MAIDEN
    db $00 ; .... $0 | 0xB8 - DIALOGUE TESTER
    db $00 ; .... $0 | 0xB9 - BULLY / PINK BALL
    db $00 ; .... $0 | 0xBA - WHIRLPOOL
    db $00 ; .... $0 | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $00 ; .... $0 | 0xBC - DRUNKARD
    db $17 ; ...d $7 | 0xBD - VITREOUS
    db $17 ; ...d $7 | 0xBE - VITREOUS SMALL EYE
    db $05 ; .... $5 | 0xBF - LIGHTNING
    db $05 ; .... $5 | 0xC0 - CATFISH
    db $05 ; .... $5 | 0xC1 - CUTSCENE AGAHNIM
    db $04 ; .... $4 | 0xC2 - BOULDER
    db $03 ; .... $3 | 0xC3 - GIBO
    db $02 ; .... $2 | 0xC4 - THIEF
    db $10 ; ...d $0 | 0xC5 - MEDUSA
    db $00 ; .... $0 | 0xC6 - 4WAY SHOOTER
    db $06 ; .... $6 | 0xC7 - POKEY
    db $00 ; .... $0 | 0xC8 - BIG FAIRY
    db $05 ; .... $5 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $07 ; .... $7 | 0xCA - CHAIN CHOMP
    db $17 ; ...d $7 | 0xCB - TRINEXX ROCK HEAD
    db $17 ; ...d $7 | 0xCC - TRINEXX FIRE HEAD
    db $17 ; ...d $7 | 0xCD - TRINEXX ICE HEAD
    db $15 ; ...d $5 | 0xCE - BLIND
    db $07 ; .... $7 | 0xCF - SWAMOLA
    db $06 ; .... $6 | 0xD0 - LYNEL
    db $10 ; ...d $0 | 0xD1 - BUNNYBEAM / SMOKE
    db $00 ; .... $0 | 0xD2 - FLOPPING FISH
    db $03 ; .... $3 | 0xD3 - STAL
    db $03 ; .... $3 | 0xD4 - LANDMINE
    db $00 ; .... $0 | 0xD5 - DIG GAME GUY
    db $19 ; ...d $9 | 0xD6 - GANON
    db $19 ; ...d $9 | 0xD7 - GANON
    db $00 ; .... $0 | 0xD8 - HEART
    db $00 ; .... $0 | 0xD9 - GREEN RUPEE
    db $00 ; .... $0 | 0xDA - BLUE RUPEE
    db $00 ; .... $0 | 0xDB - RED RUPEE
    db $00 ; .... $0 | 0xDC - BOMB REFILL 1
    db $00 ; .... $0 | 0xDD - BOMB REFILL 4
    db $00 ; .... $0 | 0xDE - BOMB REFILL 8
    db $00 ; .... $0 | 0xDF - SMALL MAGIC DECANTER
    db $00 ; .... $0 | 0xE0 - LARGE MAGIC DECANTER
    db $00 ; .... $0 | 0xE1 - ARROW REFILL 5
    db $00 ; .... $0 | 0xE2 - ARROW REFILL 10
    db $10 ; ...d $0 | 0xE3 - FAIRY
    db $00 ; .... $0 | 0xE4 - SMALL KEY
    db $00 ; .... $0 | 0xE5 - BIG KEY
    db $00 ; .... $0 | 0xE6 - STOLEN SHIELD
    db $00 ; .... $0 | 0xE7 - MUSHROOM
    db $00 ; .... $0 | 0xE8 - FAKE MASTER SWORD
    db $00 ; .... $0 | 0xE9 - MAGIC SHOP ASSISTANT
    db $00 ; .... $0 | 0xEA - HEART CONTAINER
    db $00 ; .... $0 | 0xEB - HEART PIECE
    db $00 ; .... $0 | 0xEC - THROWN ITEM
    db $00 ; .... $0 | 0xED - SOMARIA PLATFORM
    db $00 ; .... $0 | 0xEE - CASTLE MANTLE
    db $00 ; .... $0 | 0xEF - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF0 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF1 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF2 - MEDALLION TABLET
}

; $0E60 - Misc settings (only the top 4 bits)
; $0F50 - Sprite OAM Byte 4 (only the last 4 bits)
; nios pppc
;   n - Custom death animation
;   i - Impervious to attacks
;   o - Shadow size (0: big | 1: small)
;   s - Draw shadow (0: no shadow | 1: draw shadow)
;   p - Sprite palette, copied to OAM
;   c - Sprite character table, copied to OAM
; $06B359-$06B44B DATA
SpriteData_OAMProp:
{
    db $19 ; ...s $1, 1 | 0x00 - RAVEN
    db $0B ; .... $3, 1 | 0x01 - VULTURE
    db $1B ; ...s $3, 1 | 0x02 - STALFOS HEAD
    db $4B ; .i.. $3, 1 | 0x03 - NULL
    db $41 ; .i.. $1, 1 | 0x04 - CORRECT PULL SWITCH
    db $41 ; .i.. $1, 1 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $41 ; .i.. $1, 1 | 0x06 - WRONG PULL SWITCH
    db $4D ; .i.. $5, 1 | 0x07 - UNUSED WRONG PULL SWITCH
    db $1D ; ...s $5, 1 | 0x08 - OCTOROK
    db $01 ; .... $1, 1 | 0x09 - MOLDORM
    db $1D ; ...s $5, 1 | 0x0A - OCTOROK 4WAY
    db $19 ; ...s $1, 1 | 0x0B - CUCCO
    db $8D ; n... $5, 1 | 0x0C - OCTOROK STONE
    db $1B ; ...s $3, 1 | 0x0D - BUZZBLOB
    db $09 ; .... $1, 1 | 0x0E - SNAPDRAGON
    db $9D ; n..s $5, 1 | 0x0F - OCTOBALLOON
    db $3D ; ..os $5, 1 | 0x10 - OCTOBALLOON BABY
    db $01 ; .... $1, 1 | 0x11 - HINOX
    db $09 ; .... $1, 1 | 0x12 - MOBLIN
    db $11 ; ...s $1, 1 | 0x13 - MINI HELMASAUR
    db $40 ; .i.. $0, 0 | 0x14 - THIEVES TOWN GRATE
    db $01 ; .... $1, 1 | 0x15 - ANTIFAIRY
    db $4D ; .i.. $5, 1 | 0x16 - SAHASRAHLA / AGINAH
    db $19 ; ...s $1, 1 | 0x17 - HOARDER
    db $07 ; .... $7, 1 | 0x18 - MINI MOLDORM
    db $1D ; ...s $5, 1 | 0x19 - POE
    db $59 ; .i.s $1, 1 | 0x1A - SMITHY
    db $80 ; n... $0, 0 | 0x1B - ARROW
    db $4D ; .i.. $5, 1 | 0x1C - STATUE
    db $40 ; .i.. $0, 0 | 0x1D - FLUTEQUEST
    db $01 ; .... $1, 1 | 0x1E - CRYSTAL SWITCH
    db $49 ; .i.. $1, 1 | 0x1F - SICK KID
    db $1B ; ...s $3, 1 | 0x20 - SLUGGULA
    db $41 ; .i.. $1, 1 | 0x21 - WATER SWITCH
    db $03 ; .... $3, 1 | 0x22 - ROPA
    db $13 ; ...s $3, 1 | 0x23 - RED BARI
    db $15 ; ...s $5, 1 | 0x24 - BLUE BARI
    db $41 ; .i.. $1, 1 | 0x25 - TALKING TREE
    db $18 ; ...s $0, 0 | 0x26 - HARDHAT BEETLE
    db $1B ; ...s $3, 1 | 0x27 - DEADROCK
    db $41 ; .i.. $1, 1 | 0x28 - DARK WORLD HINT NPC
    db $47 ; .i.. $7, 1 | 0x29 - ADULT
    db $0F ; .... $7, 1 | 0x2A - SWEEPING LADY
    db $49 ; .i.. $1, 1 | 0x2B - HOBO
    db $4B ; .i.. $3, 1 | 0x2C - LUMBERJACKS
    db $4D ; .i.. $5, 1 | 0x2D - NECKLESS MAN
    db $41 ; .i.. $1, 1 | 0x2E - FLUTE KID
    db $47 ; .i.. $7, 1 | 0x2F - RACE GAME LADY
    db $49 ; .i.. $1, 1 | 0x30 - RACE GAME GUY
    db $4D ; .i.. $5, 1 | 0x31 - FORTUNE TELLER
    db $49 ; .i.. $1, 1 | 0x32 - ARGUE BROS
    db $40 ; .i.. $0, 0 | 0x33 - RUPEE PULL
    db $4D ; .i.. $5, 1 | 0x34 - YOUNG SNITCH
    db $47 ; .i.. $7, 1 | 0x35 - INNKEEPER
    db $49 ; .i.. $1, 1 | 0x36 - WITCH
    db $41 ; .i.. $1, 1 | 0x37 - WATERFALL
    db $74 ; .ios $4, 0 | 0x38 - EYE STATUE
    db $47 ; .i.. $7, 1 | 0x39 - LOCKSMITH
    db $5B ; .i.s $3, 1 | 0x3A - MAGIC BAT
    db $58 ; .i.s $0, 0 | 0x3B - BONK ITEM
    db $51 ; .i.s $1, 1 | 0x3C - KID IN KAK
    db $49 ; .i.. $1, 1 | 0x3D - OLD SNITCH
    db $1D ; ...s $5, 1 | 0x3E - HOARDER
    db $5D ; .i.s $5, 1 | 0x3F - TUTORIAL GUARD
    db $03 ; .... $3, 1 | 0x40 - LIGHTNING GATE
    db $19 ; ...s $1, 1 | 0x41 - BLUE GUARD
    db $1B ; ...s $3, 1 | 0x42 - GREEN GUARD
    db $17 ; ...s $7, 1 | 0x43 - RED SPEAR GUARD
    db $19 ; ...s $1, 1 | 0x44 - BLUESAIN BOLT
    db $17 ; ...s $7, 1 | 0x45 - USAIN BOLT
    db $19 ; ...s $1, 1 | 0x46 - BLUE ARCHER
    db $1B ; ...s $3, 1 | 0x47 - GREEN BUSH GUARD
    db $17 ; ...s $7, 1 | 0x48 - RED JAVELIN GUARD
    db $17 ; ...s $7, 1 | 0x49 - RED BUSH GUARD
    db $17 ; ...s $7, 1 | 0x4A - BOMB GUARD
    db $1B ; ...s $3, 1 | 0x4B - GREEN KNIFE GUARD
    db $0D ; .... $5, 1 | 0x4C - GELDMAN
    db $09 ; .... $1, 1 | 0x4D - TOPPO
    db $19 ; ...s $1, 1 | 0x4E - POPO
    db $19 ; ...s $1, 1 | 0x4F - POPO
    db $49 ; .i.. $1, 1 | 0x50 - CANNONBALL
    db $5D ; .i.s $5, 1 | 0x51 - ARMOS STATUE
    db $5B ; .i.s $3, 1 | 0x52 - KING ZORA
    db $49 ; .i.. $1, 1 | 0x53 - ARMOS KNIGHT
    db $0D ; .... $5, 1 | 0x54 - LANMOLAS
    db $03 ; .... $3, 1 | 0x55 - ZORA / FIREBALL
    db $13 ; ...s $3, 1 | 0x56 - ZORA
    db $41 ; .i.. $1, 1 | 0x57 - DESERT STATUE
    db $1B ; ...s $3, 1 | 0x58 - CRAB
    db $5B ; .i.s $3, 1 | 0x59 - LOST WOODS BIRD
    db $5D ; .i.s $5, 1 | 0x5A - LOST WOODS SQUIRREL
    db $43 ; .i.. $3, 1 | 0x5B - SPARK
    db $43 ; .i.. $3, 1 | 0x5C - SPARK
    db $4D ; .i.. $5, 1 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $4D ; .i.. $5, 1 | 0x5E - ROLLER VERTICAL UP FIRST
    db $4D ; .i.. $5, 1 | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $4D ; .i.. $5, 1 | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $4D ; .i.. $5, 1 | 0x61 - BEAMOS
    db $49 ; .i.. $1, 1 | 0x62 - MASTERSWORD
    db $01 ; .... $1, 1 | 0x63 - DEBIRANDO PIT
    db $00 ; .... $0, 0 | 0x64 - DEBIRANDO
    db $41 ; .i.. $1, 1 | 0x65 - ARCHERY GUY
    db $4D ; .i.. $5, 1 | 0x66 - WALL CANNON VERTICAL LEFT
    db $4D ; .i.. $5, 1 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $4D ; .i.. $5, 1 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $4D ; .i.. $5, 1 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $1D ; ...s $5, 1 | 0x6A - BALL N CHAIN
    db $09 ; .... $1, 1 | 0x6B - CANNONBALL / CANNON TROOPER
    db $C4 ; ni.. $4, 0 | 0x6C - MIRROR PORTAL
    db $0D ; .... $5, 1 | 0x6D - RAT / CRICKET
    db $0D ; .... $5, 1 | 0x6E - SNAKE
    db $09 ; .... $1, 1 | 0x6F - KEESE
    db $03 ; .... $3, 1 | 0x70 - KING HELMASAUR FIREBALL
    db $03 ; .... $3, 1 | 0x71 - LEEVER
    db $4B ; .i.. $3, 1 | 0x72 - FAIRY POND TRIGGER
    db $47 ; .i.. $7, 1 | 0x73 - UNCLE / PRIEST / MANTLE
    db $47 ; .i.. $7, 1 | 0x74 - RUNNING MAN
    db $49 ; .i.. $1, 1 | 0x75 - BOTTLE MERCHANT
    db $49 ; .i.. $1, 1 | 0x76 - ZELDA
    db $41 ; .i.. $1, 1 | 0x77 - ANTIFAIRY
    db $47 ; .i.. $7, 1 | 0x78 - SAHASRAHLAS WIFE
    db $36 ; ..os $6, 0 | 0x79 - BEE
    db $8B ; n... $3, 1 | 0x7A - AGAHNIM
    db $49 ; .i.. $1, 1 | 0x7B - AGAHNIMS BALLS
    db $1D ; ...s $5, 1 | 0x7C - GREEN STALFOS
    db $49 ; .i.. $1, 1 | 0x7D - BIG SPIKE
    db $43 ; .i.. $3, 1 | 0x7E - FIREBAR CLOCKWISE
    db $43 ; .i.. $3, 1 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $43 ; .i.. $3, 1 | 0x80 - FIRESNAKE
    db $0B ; .... $3, 1 | 0x81 - HOVER
    db $41 ; .i.. $1, 1 | 0x82 - ANTIFAIRY CIRCLE
    db $0D ; .... $5, 1 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $07 ; .... $7, 1 | 0x84 - RED EYEGORE / RED MIMIC
    db $0B ; .... $3, 1 | 0x85 - YELLOW STALFOS
    db $1D ; ...s $5, 1 | 0x86 - KODONGO
    db $43 ; .i.. $3, 1 | 0x87 - KONDONGO FIRE
    db $0D ; .... $5, 1 | 0x88 - MOTHULA
    db $43 ; .i.. $3, 1 | 0x89 - MOTHULA BEAM
    db $0D ; .... $5, 1 | 0x8A - SPIKE BLOCK
    db $1D ; ...s $5, 1 | 0x8B - GIBDO
    db $4D ; .i.. $5, 1 | 0x8C - ARRGHUS
    db $4D ; .i.. $5, 1 | 0x8D - ARRGHI
    db $1B ; ...s $3, 1 | 0x8E - TERRORPIN
    db $1B ; ...s $3, 1 | 0x8F - BLOB
    db $0A ; .... $2, 0 | 0x90 - WALLMASTER
    db $0B ; .... $3, 1 | 0x91 - STALFOS KNIGHT
    db $00 ; .... $0, 0 | 0x92 - KING HELMASAUR
    db $05 ; .... $5, 1 | 0x93 - BUMPER
    db $0D ; .... $5, 1 | 0x94 - PIROGUSU
    db $01 ; .... $1, 1 | 0x95 - LASER EYE LEFT
    db $01 ; .... $1, 1 | 0x96 - LASER EYE RIGHT
    db $01 ; .... $1, 1 | 0x97 - LASER EYE TOP
    db $01 ; .... $1, 1 | 0x98 - LASER EYE BOTTOM
    db $0B ; .... $3, 1 | 0x99 - PENGATOR
    db $05 ; .... $5, 1 | 0x9A - KYAMERON
    db $01 ; .... $1, 1 | 0x9B - WIZZROBE
    db $01 ; .... $1, 1 | 0x9C - ZORO
    db $01 ; .... $1, 1 | 0x9D - BABASU
    db $07 ; .... $7, 1 | 0x9E - HAUNTED GROVE OSTRITCH
    db $17 ; ...s $7, 1 | 0x9F - HAUNTED GROVE RABBIT
    db $19 ; ...s $1, 1 | 0xA0 - HAUNTED GROVE BIRD
    db $0D ; .... $5, 1 | 0xA1 - FREEZOR
    db $0D ; .... $5, 1 | 0xA2 - KHOLDSTARE
    db $80 ; n... $0, 0 | 0xA3 - KHOLDSTARE SHELL
    db $4D ; .i.. $5, 1 | 0xA4 - FALLING ICE
    db $19 ; ...s $1, 1 | 0xA5 - BLUE ZAZAK
    db $17 ; ...s $7, 1 | 0xA6 - RED ZAZAK
    db $19 ; ...s $1, 1 | 0xA7 - STALFOS
    db $0B ; .... $3, 1 | 0xA8 - GREEN ZIRRO
    db $09 ; .... $1, 1 | 0xA9 - BLUE ZIRRO
    db $0D ; .... $5, 1 | 0xAA - PIKIT
    db $4A ; .i.. $2, 0 | 0xAB - CRYSTAL MAIDEN
    db $12 ; ...s $2, 0 | 0xAC - APPLE
    db $49 ; .i.. $1, 1 | 0xAD - OLD MAN
    db $C3 ; ni.. $3, 1 | 0xAE - PIPE DOWN
    db $C3 ; ni.. $3, 1 | 0xAF - PIPE UP
    db $C3 ; ni.. $3, 1 | 0xB0 - PIPE RIGHT
    db $C3 ; ni.. $3, 1 | 0xB1 - PIPE LEFT
    db $76 ; .ios $6, 0 | 0xB2 - GOOD BEE
    db $40 ; .i.. $0, 0 | 0xB3 - PEDESTAL PLAQUE
    db $59 ; .i.s $1, 1 | 0xB4 - PURPLE CHEST
    db $41 ; .i.. $1, 1 | 0xB5 - BOMB SHOP GUY
    db $58 ; .i.s $0, 0 | 0xB6 - KIKI
    db $4F ; .i.. $7, 1 | 0xB7 - BLIND MAIDEN
    db $73 ; .ios $3, 1 | 0xB8 - DIALOGUE TESTER
    db $5B ; .i.s $3, 1 | 0xB9 - BULLY / PINK BALL
    db $44 ; .i.. $4, 0 | 0xBA - WHIRLPOOL
    db $41 ; .i.. $1, 1 | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $51 ; .i.s $1, 1 | 0xBC - DRUNKARD
    db $0A ; .... $2, 0 | 0xBD - VITREOUS
    db $0B ; .... $3, 1 | 0xBE - VITREOUS SMALL EYE
    db $0B ; .... $3, 1 | 0xBF - LIGHTNING
    db $4B ; .i.. $3, 1 | 0xC0 - CATFISH
    db $00 ; .... $0, 0 | 0xC1 - CUTSCENE AGAHNIM
    db $40 ; .i.. $0, 0 | 0xC2 - BOULDER
    db $5B ; .i.s $3, 1 | 0xC3 - GIBO
    db $0D ; .... $5, 1 | 0xC4 - THIEF
    db $00 ; .... $0, 0 | 0xC5 - MEDUSA
    db $00 ; .... $0, 0 | 0xC6 - 4WAY SHOOTER
    db $0D ; .... $5, 1 | 0xC7 - POKEY
    db $4B ; .i.. $3, 1 | 0xC8 - BIG FAIRY
    db $0B ; .... $3, 1 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $59 ; .i.s $1, 1 | 0xCA - CHAIN CHOMP
    db $41 ; .i.. $1, 1 | 0xCB - TRINEXX ROCK HEAD
    db $0B ; .... $3, 1 | 0xCC - TRINEXX FIRE HEAD
    db $0D ; .... $5, 1 | 0xCD - TRINEXX ICE HEAD
    db $01 ; .... $1, 1 | 0xCE - BLIND
    db $0D ; .... $5, 1 | 0xCF - SWAMOLA
    db $0D ; .... $5, 1 | 0xD0 - LYNEL
    db $00 ; .... $0, 0 | 0xD1 - BUNNYBEAM / SMOKE
    db $50 ; .i.s $0, 0 | 0xD2 - FLOPPING FISH
    db $4C ; .i.. $4, 0 | 0xD3 - STAL
    db $44 ; .i.. $4, 0 | 0xD4 - LANDMINE
    db $51 ; .i.s $1, 1 | 0xD5 - DIG GAME GUY
    db $01 ; .... $1, 1 | 0xD6 - GANON
    db $01 ; .... $1, 1 | 0xD7 - GANON
    db $F2 ; nios $2, 0 | 0xD8 - HEART
    db $F8 ; nios $0, 0 | 0xD9 - GREEN RUPEE
    db $F4 ; nios $4, 0 | 0xDA - BLUE RUPEE
    db $F2 ; nios $2, 0 | 0xDB - RED RUPEE
    db $D4 ; ni.s $4, 0 | 0xDC - BOMB REFILL 1
    db $D4 ; ni.s $4, 0 | 0xDD - BOMB REFILL 4
    db $D4 ; ni.s $4, 0 | 0xDE - BOMB REFILL 8
    db $F8 ; nios $0, 0 | 0xDF - SMALL MAGIC DECANTER
    db $F8 ; nios $0, 0 | 0xE0 - LARGE MAGIC DECANTER
    db $F4 ; nios $4, 0 | 0xE1 - ARROW REFILL 5
    db $F4 ; nios $4, 0 | 0xE2 - ARROW REFILL 10
    db $D8 ; ni.s $0, 0 | 0xE3 - FAIRY
    db $F8 ; nios $0, 0 | 0xE4 - SMALL KEY
    db $D8 ; ni.s $0, 0 | 0xE5 - BIG KEY
    db $DF ; ni.s $7, 1 | 0xE6 - STOLEN SHIELD
    db $C8 ; ni.. $0, 0 | 0xE7 - MUSHROOM
    db $69 ; .io. $1, 1 | 0xE8 - FAKE MASTER SWORD
    db $C1 ; ni.. $1, 1 | 0xE9 - MAGIC SHOP ASSISTANT
    db $D2 ; ni.s $2, 0 | 0xEA - HEART CONTAINER
    db $D2 ; ni.s $2, 0 | 0xEB - HEART PIECE
    db $DC ; ni.s $4, 0 | 0xEC - THROWN ITEM
    db $C7 ; ni.. $7, 1 | 0xED - SOMARIA PLATFORM
    db $C1 ; ni.. $1, 1 | 0xEE - CASTLE MANTLE
    db $C7 ; ni.. $7, 1 | 0xEF - UNUSED SOMARIA PLATFORM
    db $C7 ; ni.. $7, 1 | 0xF0 - UNUSED SOMARIA PLATFORM
    db $C7 ; ni.. $7, 1 | 0xF1 - UNUSED SOMARIA PLATFORM
    db $C1 ; ni.. $1, 1 | 0xF2 - MEDALLION TABLET
}

; $0F60 - Alive / hit box properties.
; $06B44C-$06B53E DATA
SpriteData_HitBox:
{
    db $00 ; ... $00 | 0x00 - RAVEN
    db $00 ; ... $00 | 0x01 - VULTURE
    db $00 ; ... $00 | 0x02 - STALFOS HEAD
    db $43 ; .s. $03 | 0x03 - NULL
    db $43 ; .s. $03 | 0x04 - CORRECT PULL SWITCH
    db $43 ; .s. $03 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $43 ; .s. $03 | 0x06 - WRONG PULL SWITCH
    db $43 ; .s. $03 | 0x07 - UNUSED WRONG PULL SWITCH
    db $00 ; ... $00 | 0x08 - OCTOROK
    db $00 ; ... $00 | 0x09 - MOLDORM
    db $00 ; ... $00 | 0x0A - OCTOROK 4WAY
    db $00 ; ... $00 | 0x0B - CUCCO
    db $1C ; ... $1C | 0x0C - OCTOROK STONE
    db $00 ; ... $00 | 0x0D - BUZZBLOB
    db $00 ; ... $00 | 0x0E - SNAPDRAGON
    db $02 ; ... $02 | 0x0F - OCTOBALLOON
    db $01 ; ... $01 | 0x10 - OCTOBALLOON BABY
    db $03 ; ... $03 | 0x11 - HINOX
    db $00 ; ... $00 | 0x12 - MOBLIN
    db $00 ; ... $00 | 0x13 - MINI HELMASAUR
    db $03 ; ... $03 | 0x14 - THIEVES TOWN GRATE
    db $C0 ; is. $00 | 0x15 - ANTIFAIRY
    db $07 ; ... $07 | 0x16 - SAHASRAHLA / AGINAH
    db $00 ; ... $00 | 0x17 - HOARDER
    db $00 ; ... $00 | 0x18 - MINI MOLDORM
    db $00 ; ... $00 | 0x19 - POE
    db $07 ; ... $07 | 0x1A - SMITHY
    db $45 ; .s. $05 | 0x1B - ARROW
    db $43 ; .s. $03 | 0x1C - STATUE
    db $00 ; ... $00 | 0x1D - FLUTEQUEST
    db $40 ; .s. $00 | 0x1E - CRYSTAL SWITCH
    db $0D ; ... $0D | 0x1F - SICK KID
    db $00 ; ... $00 | 0x20 - SLUGGULA
    db $00 ; ... $00 | 0x21 - WATER SWITCH
    db $00 ; ... $00 | 0x22 - ROPA
    db $00 ; ... $00 | 0x23 - RED BARI
    db $00 ; ... $00 | 0x24 - BLUE BARI
    db $00 ; ... $00 | 0x25 - TALKING TREE
    db $00 ; ... $00 | 0x26 - HARDHAT BEETLE
    db $00 ; ... $00 | 0x27 - DEADROCK
    db $07 ; ... $07 | 0x28 - DARK WORLD HINT NPC
    db $07 ; ... $07 | 0x29 - ADULT
    db $07 ; ... $07 | 0x2A - SWEEPING LADY
    db $07 ; ... $07 | 0x2B - HOBO
    db $07 ; ... $07 | 0x2C - LUMBERJACKS
    db $07 ; ... $07 | 0x2D - NECKLESS MAN
    db $0D ; ... $0D | 0x2E - FLUTE KID
    db $07 ; ... $07 | 0x2F - RACE GAME LADY
    db $07 ; ... $07 | 0x30 - RACE GAME GUY
    db $07 ; ... $07 | 0x31 - FORTUNE TELLER
    db $07 ; ... $07 | 0x32 - ARGUE BROS
    db $03 ; ... $03 | 0x33 - RUPEE PULL
    db $07 ; ... $07 | 0x34 - YOUNG SNITCH
    db $07 ; ... $07 | 0x35 - INNKEEPER
    db $07 ; ... $07 | 0x36 - WITCH
    db $40 ; .s. $00 | 0x37 - WATERFALL
    db $03 ; ... $03 | 0x38 - EYE STATUE
    db $07 ; ... $07 | 0x39 - LOCKSMITH
    db $0D ; ... $0D | 0x3A - MAGIC BAT
    db $00 ; ... $00 | 0x3B - BONK ITEM
    db $07 ; ... $07 | 0x3C - KID IN KAK
    db $07 ; ... $07 | 0x3D - OLD SNITCH
    db $00 ; ... $00 | 0x3E - HOARDER
    db $00 ; ... $00 | 0x3F - TUTORIAL GUARD
    db $09 ; ... $09 | 0x40 - LIGHTNING GATE
    db $12 ; ... $12 | 0x41 - BLUE GUARD
    db $12 ; ... $12 | 0x42 - GREEN GUARD
    db $12 ; ... $12 | 0x43 - RED SPEAR GUARD
    db $12 ; ... $12 | 0x44 - BLUESAIN BOLT
    db $12 ; ... $12 | 0x45 - USAIN BOLT
    db $12 ; ... $12 | 0x46 - BLUE ARCHER
    db $12 ; ... $12 | 0x47 - GREEN BUSH GUARD
    db $12 ; ... $12 | 0x48 - RED JAVELIN GUARD
    db $12 ; ... $12 | 0x49 - RED BUSH GUARD
    db $12 ; ... $12 | 0x4A - BOMB GUARD
    db $12 ; ... $12 | 0x4B - GREEN KNIFE GUARD
    db $00 ; ... $00 | 0x4C - GELDMAN
    db $00 ; ... $00 | 0x4D - TOPPO
    db $00 ; ... $00 | 0x4E - POPO
    db $00 ; ... $00 | 0x4F - POPO
    db $80 ; i.. $00 | 0x50 - CANNONBALL
    db $12 ; ... $12 | 0x51 - ARMOS STATUE
    db $09 ; ... $09 | 0x52 - KING ZORA
    db $09 ; ... $09 | 0x53 - ARMOS KNIGHT
    db $00 ; ... $00 | 0x54 - LANMOLAS
    db $40 ; .s. $00 | 0x55 - ZORA / FIREBALL
    db $00 ; ... $00 | 0x56 - ZORA
    db $0C ; ... $0C | 0x57 - DESERT STATUE
    db $00 ; ... $00 | 0x58 - CRAB
    db $00 ; ... $00 | 0x59 - LOST WOODS BIRD
    db $00 ; ... $00 | 0x5A - LOST WOODS SQUIRREL
    db $40 ; .s. $00 | 0x5B - SPARK
    db $40 ; .s. $00 | 0x5C - SPARK
    db $10 ; ... $10 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $10 ; ... $10 | 0x5E - ROLLER VERTICAL UP FIRST
    db $2E ; ..p $0E | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $2E ; ..p $0E | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $40 ; .s. $00 | 0x61 - BEAMOS
    db $1E ; ... $1E | 0x62 - MASTERSWORD
    db $53 ; .s. $13 | 0x63 - DEBIRANDO PIT
    db $00 ; ... $00 | 0x64 - DEBIRANDO
    db $0A ; ... $0A | 0x65 - ARCHERY GUY
    db $00 ; ... $00 | 0x66 - WALL CANNON VERTICAL LEFT
    db $00 ; ... $00 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $00 ; ... $00 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $00 ; ... $00 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $12 ; ... $12 | 0x6A - BALL N CHAIN
    db $12 ; ... $12 | 0x6B - CANNONBALL / CANNON TROOPER
    db $40 ; .s. $00 | 0x6C - MIRROR PORTAL
    db $00 ; ... $00 | 0x6D - RAT / CRICKET
    db $00 ; ... $00 | 0x6E - SNAKE
    db $40 ; .s. $00 | 0x6F - KEESE
    db $19 ; ... $19 | 0x70 - KING HELMASAUR FIREBALL
    db $00 ; ... $00 | 0x71 - LEEVER
    db $00 ; ... $00 | 0x72 - FAIRY POND TRIGGER
    db $0A ; ... $0A | 0x73 - UNCLE / PRIEST / MANTLE
    db $0D ; ... $0D | 0x74 - RUNNING MAN
    db $0A ; ... $0A | 0x75 - BOTTLE MERCHANT
    db $0A ; ... $0A | 0x76 - ZELDA
    db $80 ; i.. $00 | 0x77 - ANTIFAIRY
    db $0A ; ... $0A | 0x78 - SAHASRAHLAS WIFE
    db $41 ; .s. $01 | 0x79 - BEE
    db $00 ; ... $00 | 0x7A - AGAHNIM
    db $40 ; .s. $00 | 0x7B - AGAHNIMS BALLS
    db $00 ; ... $00 | 0x7C - GREEN STALFOS
    db $49 ; .s. $09 | 0x7D - BIG SPIKE
    db $00 ; ... $00 | 0x7E - FIREBAR CLOCKWISE
    db $00 ; ... $00 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $C0 ; is. $00 | 0x80 - FIRESNAKE
    db $00 ; ... $00 | 0x81 - HOVER
    db $40 ; .s. $00 | 0x82 - ANTIFAIRY CIRCLE
    db $00 ; ... $00 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $00 ; ... $00 | 0x84 - RED EYEGORE / RED MIMIC
    db $40 ; .s. $00 | 0x85 - YELLOW STALFOS
    db $00 ; ... $00 | 0x86 - KODONGO
    db $00 ; ... $00 | 0x87 - KONDONGO FIRE
    db $09 ; ... $09 | 0x88 - MOTHULA
    db $80 ; i.. $00 | 0x89 - MOTHULA BEAM
    db $C0 ; is. $00 | 0x8A - SPIKE BLOCK
    db $00 ; ... $00 | 0x8B - GIBDO
    db $40 ; .s. $00 | 0x8C - ARRGHUS
    db $00 ; ... $00 | 0x8D - ARRGHI
    db $00 ; ... $00 | 0x8E - TERRORPIN
    db $80 ; i.. $00 | 0x8F - BLOB
    db $00 ; ... $00 | 0x90 - WALLMASTER
    db $00 ; ... $00 | 0x91 - STALFOS KNIGHT
    db $18 ; ... $18 | 0x92 - KING HELMASAUR
    db $5A ; .s. $1A | 0x93 - BUMPER
    db $00 ; ... $00 | 0x94 - PIROGUSU
    db $D4 ; is. $14 | 0x95 - LASER EYE LEFT
    db $D4 ; is. $14 | 0x96 - LASER EYE RIGHT
    db $D4 ; is. $14 | 0x97 - LASER EYE TOP
    db $D4 ; is. $14 | 0x98 - LASER EYE BOTTOM
    db $00 ; ... $00 | 0x99 - PENGATOR
    db $40 ; .s. $00 | 0x9A - KYAMERON
    db $00 ; ... $00 | 0x9B - WIZZROBE
    db $80 ; i.. $00 | 0x9C - ZORO
    db $80 ; i.. $00 | 0x9D - BABASU
    db $40 ; .s. $00 | 0x9E - HAUNTED GROVE OSTRITCH
    db $40 ; .s. $00 | 0x9F - HAUNTED GROVE RABBIT
    db $40 ; .s. $00 | 0xA0 - HAUNTED GROVE BIRD
    db $00 ; ... $00 | 0xA1 - FREEZOR
    db $09 ; ... $09 | 0xA2 - KHOLDSTARE
    db $1D ; ... $1D | 0xA3 - KHOLDSTARE SHELL
    db $00 ; ... $00 | 0xA4 - FALLING ICE
    db $00 ; ... $00 | 0xA5 - BLUE ZAZAK
    db $00 ; ... $00 | 0xA6 - RED ZAZAK
    db $00 ; ... $00 | 0xA7 - STALFOS
    db $00 ; ... $00 | 0xA8 - GREEN ZIRRO
    db $00 ; ... $00 | 0xA9 - BLUE ZIRRO
    db $00 ; ... $00 | 0xAA - PIKIT
    db $00 ; ... $00 | 0xAB - CRYSTAL MAIDEN
    db $00 ; ... $00 | 0xAC - APPLE
    db $0A ; ... $0A | 0xAD - OLD MAN
    db $1B ; ... $1B | 0xAE - PIPE DOWN
    db $1B ; ... $1B | 0xAF - PIPE UP
    db $1B ; ... $1B | 0xB0 - PIPE RIGHT
    db $1B ; ... $1B | 0xB1 - PIPE LEFT
    db $41 ; .s. $01 | 0xB2 - GOOD BEE
    db $00 ; ... $00 | 0xB3 - PEDESTAL PLAQUE
    db $03 ; ... $03 | 0xB4 - PURPLE CHEST
    db $07 ; ... $07 | 0xB5 - BOMB SHOP GUY
    db $07 ; ... $07 | 0xB6 - KIKI
    db $03 ; ... $03 | 0xB7 - BLIND MAIDEN
    db $0A ; ... $0A | 0xB8 - DIALOGUE TESTER
    db $00 ; ... $00 | 0xB9 - BULLY / PINK BALL
    db $01 ; ... $01 | 0xBA - WHIRLPOOL
    db $0A ; ... $0A | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $0A ; ... $0A | 0xBC - DRUNKARD
    db $09 ; ... $09 | 0xBD - VITREOUS
    db $00 ; ... $00 | 0xBE - VITREOUS SMALL EYE
    db $00 ; ... $00 | 0xBF - LIGHTNING
    db $00 ; ... $00 | 0xC0 - CATFISH
    db $00 ; ... $00 | 0xC1 - CUTSCENE AGAHNIM
    db $09 ; ... $09 | 0xC2 - BOULDER
    db $00 ; ... $00 | 0xC3 - GIBO
    db $00 ; ... $00 | 0xC4 - THIEF
    db $40 ; .s. $00 | 0xC5 - MEDUSA
    db $40 ; .s. $00 | 0xC6 - 4WAY SHOOTER
    db $00 ; ... $00 | 0xC7 - POKEY
    db $00 ; ... $00 | 0xC8 - BIG FAIRY
    db $00 ; ... $00 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $00 ; ... $00 | 0xCA - CHAIN CHOMP
    db $89 ; i.. $09 | 0xCB - TRINEXX ROCK HEAD
    db $80 ; i.. $00 | 0xCC - TRINEXX FIRE HEAD
    db $80 ; i.. $00 | 0xCD - TRINEXX ICE HEAD
    db $00 ; ... $00 | 0xCE - BLIND
    db $1C ; ... $1C | 0xCF - SWAMOLA
    db $00 ; ... $00 | 0xD0 - LYNEL
    db $40 ; .s. $00 | 0xD1 - BUNNYBEAM / SMOKE
    db $00 ; ... $00 | 0xD2 - FLOPPING FISH
    db $00 ; ... $00 | 0xD3 - STAL
    db $1C ; ... $1C | 0xD4 - LANDMINE
    db $07 ; ... $07 | 0xD5 - DIG GAME GUY
    db $03 ; ... $03 | 0xD6 - GANON
    db $03 ; ... $03 | 0xD7 - GANON
    db $44 ; .s. $04 | 0xD8 - HEART
    db $44 ; .s. $04 | 0xD9 - GREEN RUPEE
    db $44 ; .s. $04 | 0xDA - BLUE RUPEE
    db $44 ; .s. $04 | 0xDB - RED RUPEE
    db $44 ; .s. $04 | 0xDC - BOMB REFILL 1
    db $44 ; .s. $04 | 0xDD - BOMB REFILL 4
    db $44 ; .s. $04 | 0xDE - BOMB REFILL 8
    db $44 ; .s. $04 | 0xDF - SMALL MAGIC DECANTER
    db $44 ; .s. $04 | 0xE0 - LARGE MAGIC DECANTER
    db $44 ; .s. $04 | 0xE1 - ARROW REFILL 5
    db $44 ; .s. $04 | 0xE2 - ARROW REFILL 10
    db $43 ; .s. $03 | 0xE3 - FAIRY
    db $44 ; .s. $04 | 0xE4 - SMALL KEY
    db $43 ; .s. $03 | 0xE5 - BIG KEY
    db $40 ; .s. $00 | 0xE6 - STOLEN SHIELD
    db $C0 ; is. $00 | 0xE7 - MUSHROOM
    db $C0 ; is. $00 | 0xE8 - FAKE MASTER SWORD
    db $C7 ; is. $07 | 0xE9 - MAGIC SHOP ASSISTANT
    db $C3 ; is. $03 | 0xEA - HEART CONTAINER
    db $C3 ; is. $03 | 0xEB - HEART PIECE
    db $C0 ; is. $00 | 0xEC - THROWN ITEM
    db $1B ; ... $1B | 0xED - SOMARIA PLATFORM
    db $08 ; ... $08 | 0xEE - CASTLE MANTLE
    db $1B ; ... $1B | 0xEF - UNUSED SOMARIA PLATFORM
    db $1B ; ... $1B | 0xF0 - UNUSED SOMARIA PLATFORM
    db $1B ; ... $1B | 0xF1 - UNUSED SOMARIA PLATFORM
    db $03 ; ... $03 | 0xF2 - MEDALLION TABLET
}

; $0B6B - Tile hit box and other misc settings.
; $06B53F-$06B631 DATA
SpriteData_TileInteraction:
{
    db $00 ; .... $0 | 0x00 - RAVEN
    db $00 ; .... $0 | 0x01 - VULTURE
    db $00 ; .... $0 | 0x02 - STALFOS HEAD
    db $00 ; .... $0 | 0x03 - NULL
    db $00 ; .... $0 | 0x04 - CORRECT PULL SWITCH
    db $00 ; .... $0 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $00 ; .... $0 | 0x06 - WRONG PULL SWITCH
    db $00 ; .... $0 | 0x07 - UNUSED WRONG PULL SWITCH
    db $00 ; .... $0 | 0x08 - OCTOROK
    db $0A ; a.b. $0 | 0x09 - MOLDORM
    db $00 ; .... $0 | 0x0A - OCTOROK 4WAY
    db $01 ; ...p $0 | 0x0B - CUCCO
    db $30 ; .... $0 | 0x0C - OCTOROK STONE
    db $00 ; .... $0 | 0x0D - BUZZBLOB
    db $00 ; .... $0 | 0x0E - SNAPDRAGON
    db $20 ; .... $0 | 0x0F - OCTOBALLOON
    db $10 ; .... $0 | 0x10 - OCTOBALLOON BABY
    db $00 ; .... $0 | 0x11 - HINOX
    db $00 ; .... $0 | 0x12 - MOBLIN
    db $01 ; ...p $0 | 0x13 - MINI HELMASAUR
    db $00 ; .... $0 | 0x14 - THIEVES TOWN GRATE
    db $00 ; .... $0 | 0x15 - ANTIFAIRY
    db $00 ; .... $0 | 0x16 - SAHASRAHLA / AGINAH
    db $00 ; .... $0 | 0x17 - HOARDER
    db $00 ; .... $0 | 0x18 - MINI MOLDORM
    db $00 ; .... $0 | 0x19 - POE
    db $00 ; .... $0 | 0x1A - SMITHY
    db $08 ; a... $0 | 0x1B - ARROW
    db $20 ; .... $0 | 0x1C - STATUE
    db $00 ; .... $0 | 0x1D - FLUTEQUEST
    db $04 ; .s.. $0 | 0x1E - CRYSTAL SWITCH
    db $00 ; .... $0 | 0x1F - SICK KID
    db $00 ; .... $0 | 0x20 - SLUGGULA
    db $00 ; .... $0 | 0x21 - WATER SWITCH
    db $00 ; .... $0 | 0x22 - ROPA
    db $00 ; .... $0 | 0x23 - RED BARI
    db $00 ; .... $0 | 0x24 - BLUE BARI
    db $00 ; .... $0 | 0x25 - TALKING TREE
    db $01 ; ...p $0 | 0x26 - HARDHAT BEETLE
    db $04 ; .s.. $0 | 0x27 - DEADROCK
    db $00 ; .... $0 | 0x28 - DARK WORLD HINT NPC
    db $00 ; .... $0 | 0x29 - ADULT
    db $00 ; .... $0 | 0x2A - SWEEPING LADY
    db $00 ; .... $0 | 0x2B - HOBO
    db $00 ; .... $0 | 0x2C - LUMBERJACKS
    db $00 ; .... $0 | 0x2D - NECKLESS MAN
    db $00 ; .... $0 | 0x2E - FLUTE KID
    db $00 ; .... $0 | 0x2F - RACE GAME LADY
    db $00 ; .... $0 | 0x30 - RACE GAME GUY
    db $00 ; .... $0 | 0x31 - FORTUNE TELLER
    db $00 ; .... $0 | 0x32 - ARGUE BROS
    db $00 ; .... $0 | 0x33 - RUPEE PULL
    db $00 ; .... $0 | 0x34 - YOUNG SNITCH
    db $00 ; .... $0 | 0x35 - INNKEEPER
    db $00 ; .... $0 | 0x36 - WITCH
    db $00 ; .... $0 | 0x37 - WATERFALL
    db $00 ; .... $0 | 0x38 - EYE STATUE
    db $00 ; .... $0 | 0x39 - LOCKSMITH
    db $00 ; .... $0 | 0x3A - MAGIC BAT
    db $00 ; .... $0 | 0x3B - BONK ITEM
    db $00 ; .... $0 | 0x3C - KID IN KAK
    db $00 ; .... $0 | 0x3D - OLD SNITCH
    db $00 ; .... $0 | 0x3E - HOARDER
    db $68 ; a... $0 | 0x3F - TUTORIAL GUARD
    db $60 ; .... $0 | 0x40 - LIGHTNING GATE
    db $61 ; ...p $0 | 0x41 - BLUE GUARD
    db $61 ; ...p $0 | 0x42 - GREEN GUARD
    db $61 ; ...p $0 | 0x43 - RED SPEAR GUARD
    db $61 ; ...p $0 | 0x44 - BLUESAIN BOLT
    db $61 ; ...p $0 | 0x45 - USAIN BOLT
    db $61 ; ...p $0 | 0x46 - BLUE ARCHER
    db $61 ; ...p $0 | 0x47 - GREEN BUSH GUARD
    db $61 ; ...p $0 | 0x48 - RED JAVELIN GUARD
    db $61 ; ...p $0 | 0x49 - RED BUSH GUARD
    db $61 ; ...p $0 | 0x4A - BOMB GUARD
    db $61 ; ...p $0 | 0x4B - GREEN KNIFE GUARD
    db $00 ; .... $0 | 0x4C - GELDMAN
    db $00 ; .... $0 | 0x4D - TOPPO
    db $00 ; .... $0 | 0x4E - POPO
    db $00 ; .... $0 | 0x4F - POPO
    db $00 ; .... $0 | 0x50 - CANNONBALL
    db $00 ; .... $0 | 0x51 - ARMOS STATUE
    db $02 ; ..b. $0 | 0x52 - KING ZORA
    db $02 ; ..b. $0 | 0x53 - ARMOS KNIGHT
    db $02 ; ..b. $0 | 0x54 - LANMOLAS
    db $00 ; .... $0 | 0x55 - ZORA / FIREBALL
    db $00 ; .... $0 | 0x56 - ZORA
    db $70 ; .... $0 | 0x57 - DESERT STATUE
    db $00 ; .... $0 | 0x58 - CRAB
    db $00 ; .... $0 | 0x59 - LOST WOODS BIRD
    db $00 ; .... $0 | 0x5A - LOST WOODS SQUIRREL
    db $90 ; .... $0 | 0x5B - SPARK
    db $90 ; .... $0 | 0x5C - SPARK
    db $00 ; .... $0 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $00 ; .... $0 | 0x5E - ROLLER VERTICAL UP FIRST
    db $00 ; .... $0 | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $00 ; .... $0 | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $00 ; .... $0 | 0x61 - BEAMOS
    db $00 ; .... $0 | 0x62 - MASTERSWORD
    db $00 ; .... $0 | 0x63 - DEBIRANDO PIT
    db $00 ; .... $0 | 0x64 - DEBIRANDO
    db $00 ; .... $0 | 0x65 - ARCHERY GUY
    db $00 ; .... $0 | 0x66 - WALL CANNON VERTICAL LEFT
    db $00 ; .... $0 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $00 ; .... $0 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $00 ; .... $0 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $60 ; .... $0 | 0x6A - BALL N CHAIN
    db $60 ; .... $0 | 0x6B - CANNONBALL / CANNON TROOPER
    db $00 ; .... $0 | 0x6C - MIRROR PORTAL
    db $00 ; .... $0 | 0x6D - RAT / CRICKET
    db $00 ; .... $0 | 0x6E - SNAKE
    db $00 ; .... $0 | 0x6F - KEESE
    db $00 ; .... $0 | 0x70 - KING HELMASAUR FIREBALL
    db $00 ; .... $0 | 0x71 - LEEVER
    db $00 ; .... $0 | 0x72 - FAIRY POND TRIGGER
    db $00 ; .... $0 | 0x73 - UNCLE / PRIEST / MANTLE
    db $00 ; .... $0 | 0x74 - RUNNING MAN
    db $00 ; .... $0 | 0x75 - BOTTLE MERCHANT
    db $00 ; .... $0 | 0x76 - ZELDA
    db $80 ; .... $0 | 0x77 - ANTIFAIRY
    db $00 ; .... $0 | 0x78 - SAHASRAHLAS WIFE
    db $00 ; .... $0 | 0x79 - BEE
    db $02 ; ..b. $0 | 0x7A - AGAHNIM
    db $00 ; .... $0 | 0x7B - AGAHNIMS BALLS
    db $00 ; .... $0 | 0x7C - GREEN STALFOS
    db $70 ; .... $0 | 0x7D - BIG SPIKE
    db $00 ; .... $0 | 0x7E - FIREBAR CLOCKWISE
    db $00 ; .... $0 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $00 ; .... $0 | 0x80 - FIRESNAKE
    db $00 ; .... $0 | 0x81 - HOVER
    db $00 ; .... $0 | 0x82 - ANTIFAIRY CIRCLE
    db $00 ; .... $0 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $00 ; .... $0 | 0x84 - RED EYEGORE / RED MIMIC
    db $00 ; .... $0 | 0x85 - YELLOW STALFOS
    db $B0 ; .... $0 | 0x86 - KODONGO
    db $00 ; .... $0 | 0x87 - KONDONGO FIRE
    db $C2 ; ..b. $0 | 0x88 - MOTHULA
    db $00 ; .... $0 | 0x89 - MOTHULA BEAM
    db $20 ; .... $0 | 0x8A - SPIKE BLOCK
    db $00 ; .... $0 | 0x8B - GIBDO
    db $02 ; ..b. $0 | 0x8C - ARRGHUS
    db $00 ; .... $0 | 0x8D - ARRGHI
    db $00 ; .... $0 | 0x8E - TERRORPIN
    db $00 ; .... $0 | 0x8F - BLOB
    db $00 ; .... $0 | 0x90 - WALLMASTER
    db $00 ; .... $0 | 0x91 - STALFOS KNIGHT
    db $02 ; ..b. $0 | 0x92 - KING HELMASAUR
    db $00 ; .... $0 | 0x93 - BUMPER
    db $B0 ; .... $0 | 0x94 - PIROGUSU
    db $00 ; .... $0 | 0x95 - LASER EYE LEFT
    db $00 ; .... $0 | 0x96 - LASER EYE RIGHT
    db $00 ; .... $0 | 0x97 - LASER EYE TOP
    db $00 ; .... $0 | 0x98 - LASER EYE BOTTOM
    db $00 ; .... $0 | 0x99 - PENGATOR
    db $00 ; .... $0 | 0x9A - KYAMERON
    db $00 ; .... $0 | 0x9B - WIZZROBE
    db $A0 ; .... $0 | 0x9C - ZORO
    db $A0 ; .... $0 | 0x9D - BABASU
    db $00 ; .... $0 | 0x9E - HAUNTED GROVE OSTRITCH
    db $00 ; .... $0 | 0x9F - HAUNTED GROVE RABBIT
    db $00 ; .... $0 | 0xA0 - HAUNTED GROVE BIRD
    db $04 ; .s.. $0 | 0xA1 - FREEZOR
    db $02 ; ..b. $0 | 0xA2 - KHOLDSTARE
    db $00 ; .... $0 | 0xA3 - KHOLDSTARE SHELL
    db $00 ; .... $0 | 0xA4 - FALLING ICE
    db $00 ; .... $0 | 0xA5 - BLUE ZAZAK
    db $00 ; .... $0 | 0xA6 - RED ZAZAK
    db $00 ; .... $0 | 0xA7 - STALFOS
    db $00 ; .... $0 | 0xA8 - GREEN ZIRRO
    db $00 ; .... $0 | 0xA9 - BLUE ZIRRO
    db $00 ; .... $0 | 0xAA - PIKIT
    db $00 ; .... $0 | 0xAB - CRYSTAL MAIDEN
    db $00 ; .... $0 | 0xAC - APPLE
    db $00 ; .... $0 | 0xAD - OLD MAN
    db $00 ; .... $0 | 0xAE - PIPE DOWN
    db $00 ; .... $0 | 0xAF - PIPE UP
    db $00 ; .... $0 | 0xB0 - PIPE RIGHT
    db $00 ; .... $0 | 0xB1 - PIPE LEFT
    db $00 ; .... $0 | 0xB2 - GOOD BEE
    db $00 ; .... $0 | 0xB3 - PEDESTAL PLAQUE
    db $00 ; .... $0 | 0xB4 - PURPLE CHEST
    db $00 ; .... $0 | 0xB5 - BOMB SHOP GUY
    db $00 ; .... $0 | 0xB6 - KIKI
    db $00 ; .... $0 | 0xB7 - BLIND MAIDEN
    db $00 ; .... $0 | 0xB8 - DIALOGUE TESTER
    db $00 ; .... $0 | 0xB9 - BULLY / PINK BALL
    db $00 ; .... $0 | 0xBA - WHIRLPOOL
    db $00 ; .... $0 | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $00 ; .... $0 | 0xBC - DRUNKARD
    db $C2 ; ..b. $0 | 0xBD - VITREOUS
    db $00 ; .... $0 | 0xBE - VITREOUS SMALL EYE
    db $00 ; .... $0 | 0xBF - LIGHTNING
    db $00 ; .... $0 | 0xC0 - CATFISH
    db $00 ; .... $0 | 0xC1 - CUTSCENE AGAHNIM
    db $00 ; .... $0 | 0xC2 - BOULDER
    db $00 ; .... $0 | 0xC3 - GIBO
    db $04 ; .s.. $0 | 0xC4 - THIEF
    db $00 ; .... $0 | 0xC5 - MEDUSA
    db $00 ; .... $0 | 0xC6 - 4WAY SHOOTER
    db $00 ; .... $0 | 0xC7 - POKEY
    db $00 ; .... $0 | 0xC8 - BIG FAIRY
    db $00 ; .... $0 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $00 ; .... $0 | 0xCA - CHAIN CHOMP
    db $02 ; ..b. $0 | 0xCB - TRINEXX ROCK HEAD
    db $02 ; ..b. $0 | 0xCC - TRINEXX FIRE HEAD
    db $02 ; ..b. $0 | 0xCD - TRINEXX ICE HEAD
    db $02 ; ..b. $0 | 0xCE - BLIND
    db $00 ; .... $0 | 0xCF - SWAMOLA
    db $00 ; .... $0 | 0xD0 - LYNEL
    db $00 ; .... $0 | 0xD1 - BUNNYBEAM / SMOKE
    db $00 ; .... $0 | 0xD2 - FLOPPING FISH
    db $00 ; .... $0 | 0xD3 - STAL
    db $00 ; .... $0 | 0xD4 - LANDMINE
    db $00 ; .... $0 | 0xD5 - DIG GAME GUY
    db $0A ; a.b. $0 | 0xD6 - GANON
    db $0A ; a.b. $0 | 0xD7 - GANON
    db $10 ; .... $0 | 0xD8 - HEART
    db $10 ; .... $0 | 0xD9 - GREEN RUPEE
    db $10 ; .... $0 | 0xDA - BLUE RUPEE
    db $10 ; .... $0 | 0xDB - RED RUPEE
    db $00 ; .... $0 | 0xDC - BOMB REFILL 1
    db $00 ; .... $0 | 0xDD - BOMB REFILL 4
    db $00 ; .... $0 | 0xDE - BOMB REFILL 8
    db $10 ; .... $0 | 0xDF - SMALL MAGIC DECANTER
    db $10 ; .... $0 | 0xE0 - LARGE MAGIC DECANTER
    db $10 ; .... $0 | 0xE1 - ARROW REFILL 5
    db $10 ; .... $0 | 0xE2 - ARROW REFILL 10
    db $00 ; .... $0 | 0xE3 - FAIRY
    db $10 ; .... $0 | 0xE4 - SMALL KEY
    db $00 ; .... $0 | 0xE5 - BIG KEY
    db $00 ; .... $0 | 0xE6 - STOLEN SHIELD
    db $00 ; .... $0 | 0xE7 - MUSHROOM
    db $00 ; .... $0 | 0xE8 - FAKE MASTER SWORD
    db $00 ; .... $0 | 0xE9 - MAGIC SHOP ASSISTANT
    db $00 ; .... $0 | 0xEA - HEART CONTAINER
    db $00 ; .... $0 | 0xEB - HEART PIECE
    db $00 ; .... $0 | 0xEC - THROWN ITEM
    db $00 ; .... $0 | 0xED - SOMARIA PLATFORM
    db $00 ; .... $0 | 0xEE - CASTLE MANTLE
    db $00 ; .... $0 | 0xEF - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF0 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF1 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF2 - MEDALLION TABLET
}

; $0BE0 - Prize pack and other misc settings.
; $06B632-$06B724 DATA
SpriteData_PrizePack:
{
    db $83 ; i... $3 | 0x00 - RAVEN
    db $96 ; i..s $6 | 0x01 - VULTURE
    db $84 ; i... $4 | 0x02 - STALFOS HEAD
    db $80 ; i... $0 | 0x03 - NULL
    db $80 ; i... $0 | 0x04 - CORRECT PULL SWITCH
    db $80 ; i... $0 | 0x05 - UNUSED CORRECT PULL SWITCH
    db $80 ; i... $0 | 0x06 - WRONG PULL SWITCH
    db $80 ; i... $0 | 0x07 - UNUSED WRONG PULL SWITCH
    db $02 ; .... $2 | 0x08 - OCTOROK
    db $00 ; .... $0 | 0x09 - MOLDORM
    db $02 ; .... $2 | 0x0A - OCTOROK 4WAY
    db $80 ; i... $0 | 0x0B - CUCCO
    db $A0 ; i.b. $0 | 0x0C - OCTOROK STONE
    db $83 ; i... $3 | 0x0D - BUZZBLOB
    db $97 ; i..s $7 | 0x0E - SNAPDRAGON
    db $80 ; i... $0 | 0x0F - OCTOBALLOON
    db $80 ; i... $0 | 0x10 - OCTOBALLOON BABY
    db $94 ; i..s $4 | 0x11 - HINOX
    db $91 ; i..s $1 | 0x12 - MOBLIN
    db $07 ; .... $7 | 0x13 - MINI HELMASAUR
    db $00 ; .... $0 | 0x14 - THIEVES TOWN GRATE
    db $80 ; i... $0 | 0x15 - ANTIFAIRY
    db $00 ; .... $0 | 0x16 - SAHASRAHLA / AGINAH
    db $80 ; i... $0 | 0x17 - HOARDER
    db $92 ; i..s $2 | 0x18 - MINI MOLDORM
    db $96 ; i..s $6 | 0x19 - POE
    db $80 ; i... $0 | 0x1A - SMITHY
    db $A0 ; i.b. $0 | 0x1B - ARROW
    db $00 ; .... $0 | 0x1C - STATUE
    db $00 ; .... $0 | 0x1D - FLUTEQUEST
    db $00 ; .... $0 | 0x1E - CRYSTAL SWITCH
    db $80 ; i... $0 | 0x1F - SICK KID
    db $04 ; .... $4 | 0x20 - SLUGGULA
    db $80 ; i... $0 | 0x21 - WATER SWITCH
    db $82 ; i... $2 | 0x22 - ROPA
    db $06 ; .... $6 | 0x23 - RED BARI
    db $06 ; .... $6 | 0x24 - BLUE BARI
    db $00 ; .... $0 | 0x25 - TALKING TREE
    db $00 ; .... $0 | 0x26 - HARDHAT BEETLE
    db $80 ; i... $0 | 0x27 - DEADROCK
    db $80 ; i... $0 | 0x28 - DARK WORLD HINT NPC
    db $80 ; i... $0 | 0x29 - ADULT
    db $80 ; i... $0 | 0x2A - SWEEPING LADY
    db $80 ; i... $0 | 0x2B - HOBO
    db $80 ; i... $0 | 0x2C - LUMBERJACKS
    db $80 ; i... $0 | 0x2D - NECKLESS MAN
    db $80 ; i... $0 | 0x2E - FLUTE KID
    db $80 ; i... $0 | 0x2F - RACE GAME LADY
    db $80 ; i... $0 | 0x30 - RACE GAME GUY
    db $80 ; i... $0 | 0x31 - FORTUNE TELLER
    db $80 ; i... $0 | 0x32 - ARGUE BROS
    db $80 ; i... $0 | 0x33 - RUPEE PULL
    db $80 ; i... $0 | 0x34 - YOUNG SNITCH
    db $80 ; i... $0 | 0x35 - INNKEEPER
    db $80 ; i... $0 | 0x36 - WITCH
    db $80 ; i... $0 | 0x37 - WATERFALL
    db $80 ; i... $0 | 0x38 - EYE STATUE
    db $80 ; i... $0 | 0x39 - LOCKSMITH
    db $80 ; i... $0 | 0x3A - MAGIC BAT
    db $00 ; .... $0 | 0x3B - BONK ITEM
    db $00 ; .... $0 | 0x3C - KID IN KAK
    db $80 ; i... $0 | 0x3D - OLD SNITCH
    db $80 ; i... $0 | 0x3E - HOARDER
    db $90 ; i..s $0 | 0x3F - TUTORIAL GUARD
    db $80 ; i... $0 | 0x40 - LIGHTNING GATE
    db $91 ; i..s $1 | 0x41 - BLUE GUARD
    db $91 ; i..s $1 | 0x42 - GREEN GUARD
    db $91 ; i..s $1 | 0x43 - RED SPEAR GUARD
    db $97 ; i..s $7 | 0x44 - BLUESAIN BOLT
    db $91 ; i..s $1 | 0x45 - USAIN BOLT
    db $95 ; i..s $5 | 0x46 - BLUE ARCHER
    db $95 ; i..s $5 | 0x47 - GREEN BUSH GUARD
    db $93 ; i..s $3 | 0x48 - RED JAVELIN GUARD
    db $97 ; i..s $7 | 0x49 - RED BUSH GUARD
    db $14 ; ...s $4 | 0x4A - BOMB GUARD
    db $91 ; i..s $1 | 0x4B - GREEN KNIFE GUARD
    db $92 ; i..s $2 | 0x4C - GELDMAN
    db $81 ; i... $1 | 0x4D - TOPPO
    db $82 ; i... $2 | 0x4E - POPO
    db $82 ; i... $2 | 0x4F - POPO
    db $80 ; i... $0 | 0x50 - CANNONBALL
    db $85 ; i... $5 | 0x51 - ARMOS STATUE
    db $80 ; i... $0 | 0x52 - KING ZORA
    db $80 ; i... $0 | 0x53 - ARMOS KNIGHT
    db $80 ; i... $0 | 0x54 - LANMOLAS
    db $04 ; .... $4 | 0x55 - ZORA / FIREBALL
    db $04 ; .... $4 | 0x56 - ZORA
    db $80 ; i... $0 | 0x57 - DESERT STATUE
    db $91 ; i..s $1 | 0x58 - CRAB
    db $80 ; i... $0 | 0x59 - LOST WOODS BIRD
    db $80 ; i... $0 | 0x5A - LOST WOODS SQUIRREL
    db $80 ; i... $0 | 0x5B - SPARK
    db $80 ; i... $0 | 0x5C - SPARK
    db $80 ; i... $0 | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $80 ; i... $0 | 0x5E - ROLLER VERTICAL UP FIRST
    db $80 ; i... $0 | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $80 ; i... $0 | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $00 ; .... $0 | 0x61 - BEAMOS
    db $80 ; i... $0 | 0x62 - MASTERSWORD
    db $80 ; i... $0 | 0x63 - DEBIRANDO PIT
    db $82 ; i... $2 | 0x64 - DEBIRANDO
    db $8A ; i... $A | 0x65 - ARCHERY GUY
    db $80 ; i... $0 | 0x66 - WALL CANNON VERTICAL LEFT
    db $80 ; i... $0 | 0x67 - WALL CANNON VERTICAL RIGHT
    db $80 ; i... $0 | 0x68 - WALL CANNON HORIZONTAL TOP
    db $80 ; i... $0 | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $92 ; i..s $2 | 0x6A - BALL N CHAIN
    db $91 ; i..s $1 | 0x6B - CANNONBALL / CANNON TROOPER
    db $80 ; i... $0 | 0x6C - MIRROR PORTAL
    db $82 ; i... $2 | 0x6D - RAT / CRICKET
    db $81 ; i... $1 | 0x6E - SNAKE
    db $81 ; i... $1 | 0x6F - KEESE
    db $80 ; i... $0 | 0x70 - KING HELMASAUR FIREBALL
    db $81 ; i... $1 | 0x71 - LEEVER
    db $80 ; i... $0 | 0x72 - FAIRY POND TRIGGER
    db $80 ; i... $0 | 0x73 - UNCLE / PRIEST / MANTLE
    db $80 ; i... $0 | 0x74 - RUNNING MAN
    db $80 ; i... $0 | 0x75 - BOTTLE MERCHANT
    db $80 ; i... $0 | 0x76 - ZELDA
    db $80 ; i... $0 | 0x77 - ANTIFAIRY
    db $80 ; i... $0 | 0x78 - SAHASRAHLAS WIFE
    db $80 ; i... $0 | 0x79 - BEE
    db $80 ; i... $0 | 0x7A - AGAHNIM
    db $80 ; i... $0 | 0x7B - AGAHNIMS BALLS
    db $97 ; i..s $7 | 0x7C - GREEN STALFOS
    db $80 ; i... $0 | 0x7D - BIG SPIKE
    db $80 ; i... $0 | 0x7E - FIREBAR CLOCKWISE
    db $80 ; i... $0 | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $80 ; i... $0 | 0x80 - FIRESNAKE
    db $C2 ; iw.. $2 | 0x81 - HOVER
    db $80 ; i... $0 | 0x82 - ANTIFAIRY CIRCLE
    db $15 ; ...s $5 | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $15 ; ...s $5 | 0x84 - RED EYEGORE / RED MIMIC
    db $17 ; ...s $7 | 0x85 - YELLOW STALFOS
    db $06 ; .... $6 | 0x86 - KODONGO
    db $00 ; .... $0 | 0x87 - KONDONGO FIRE
    db $80 ; i... $0 | 0x88 - MOTHULA
    db $00 ; .... $0 | 0x89 - MOTHULA BEAM
    db $C0 ; iw.. $0 | 0x8A - SPIKE BLOCK
    db $13 ; ...s $3 | 0x8B - GIBDO
    db $40 ; .w.. $0 | 0x8C - ARRGHUS
    db $00 ; .... $0 | 0x8D - ARRGHI
    db $02 ; .... $2 | 0x8E - TERRORPIN
    db $06 ; .... $6 | 0x8F - BLOB
    db $10 ; ...s $0 | 0x90 - WALLMASTER
    db $14 ; ...s $4 | 0x91 - STALFOS KNIGHT
    db $00 ; .... $0 | 0x92 - KING HELMASAUR
    db $00 ; .... $0 | 0x93 - BUMPER
    db $40 ; .w.. $0 | 0x94 - PIROGUSU
    db $00 ; .... $0 | 0x95 - LASER EYE LEFT
    db $00 ; .... $0 | 0x96 - LASER EYE RIGHT
    db $00 ; .... $0 | 0x97 - LASER EYE TOP
    db $00 ; .... $0 | 0x98 - LASER EYE BOTTOM
    db $13 ; ...s $3 | 0x99 - PENGATOR
    db $46 ; .w.. $6 | 0x9A - KYAMERON
    db $11 ; ...s $1 | 0x9B - WIZZROBE
    db $80 ; i... $0 | 0x9C - ZORO
    db $80 ; i... $0 | 0x9D - BABASU
    db $00 ; .... $0 | 0x9E - HAUNTED GROVE OSTRITCH
    db $00 ; .... $0 | 0x9F - HAUNTED GROVE RABBIT
    db $00 ; .... $0 | 0xA0 - HAUNTED GROVE BIRD
    db $10 ; ...s $0 | 0xA1 - FREEZOR
    db $00 ; .... $0 | 0xA2 - KHOLDSTARE
    db $00 ; .... $0 | 0xA3 - KHOLDSTARE SHELL
    db $00 ; .... $0 | 0xA4 - FALLING ICE
    db $16 ; ...s $6 | 0xA5 - BLUE ZAZAK
    db $16 ; ...s $6 | 0xA6 - RED ZAZAK
    db $16 ; ...s $6 | 0xA7 - STALFOS
    db $81 ; i... $1 | 0xA8 - GREEN ZIRRO
    db $87 ; i... $7 | 0xA9 - BLUE ZIRRO
    db $82 ; i... $2 | 0xAA - PIKIT
    db $00 ; .... $0 | 0xAB - CRYSTAL MAIDEN
    db $80 ; i... $0 | 0xAC - APPLE
    db $80 ; i... $0 | 0xAD - OLD MAN
    db $00 ; .... $0 | 0xAE - PIPE DOWN
    db $00 ; .... $0 | 0xAF - PIPE UP
    db $00 ; .... $0 | 0xB0 - PIPE RIGHT
    db $00 ; .... $0 | 0xB1 - PIPE LEFT
    db $80 ; i... $0 | 0xB2 - GOOD BEE
    db $80 ; i... $0 | 0xB3 - PEDESTAL PLAQUE
    db $00 ; .... $0 | 0xB4 - PURPLE CHEST
    db $00 ; .... $0 | 0xB5 - BOMB SHOP GUY
    db $00 ; .... $0 | 0xB6 - KIKI
    db $00 ; .... $0 | 0xB7 - BLIND MAIDEN
    db $00 ; .... $0 | 0xB8 - DIALOGUE TESTER
    db $00 ; .... $0 | 0xB9 - BULLY / PINK BALL
    db $00 ; .... $0 | 0xBA - WHIRLPOOL
    db $00 ; .... $0 | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $00 ; .... $0 | 0xBC - DRUNKARD
    db $00 ; .... $0 | 0xBD - VITREOUS
    db $00 ; .... $0 | 0xBE - VITREOUS SMALL EYE
    db $00 ; .... $0 | 0xBF - LIGHTNING
    db $00 ; .... $0 | 0xC0 - CATFISH
    db $00 ; .... $0 | 0xC1 - CUTSCENE AGAHNIM
    db $00 ; .... $0 | 0xC2 - BOULDER
    db $80 ; i... $0 | 0xC3 - GIBO
    db $00 ; .... $0 | 0xC4 - THIEF
    db $00 ; .... $0 | 0xC5 - MEDUSA
    db $00 ; .... $0 | 0xC6 - 4WAY SHOOTER
    db $17 ; ...s $7 | 0xC7 - POKEY
    db $00 ; .... $0 | 0xC8 - BIG FAIRY
    db $12 ; ...s $2 | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $00 ; .... $0 | 0xCA - CHAIN CHOMP
    db $00 ; .... $0 | 0xCB - TRINEXX ROCK HEAD
    db $00 ; .... $0 | 0xCC - TRINEXX FIRE HEAD
    db $00 ; .... $0 | 0xCD - TRINEXX ICE HEAD
    db $00 ; .... $0 | 0xCE - BLIND
    db $10 ; ...s $0 | 0xCF - SWAMOLA
    db $17 ; ...s $7 | 0xD0 - LYNEL
    db $00 ; .... $0 | 0xD1 - BUNNYBEAM / SMOKE
    db $40 ; .w.. $0 | 0xD2 - FLOPPING FISH
    db $01 ; .... $1 | 0xD3 - STAL
    db $00 ; .... $0 | 0xD4 - LANDMINE
    db $00 ; .... $0 | 0xD5 - DIG GAME GUY
    db $00 ; .... $0 | 0xD6 - GANON
    db $00 ; .... $0 | 0xD7 - GANON
    db $00 ; .... $0 | 0xD8 - HEART
    db $00 ; .... $0 | 0xD9 - GREEN RUPEE
    db $00 ; .... $0 | 0xDA - BLUE RUPEE
    db $00 ; .... $0 | 0xDB - RED RUPEE
    db $00 ; .... $0 | 0xDC - BOMB REFILL 1
    db $00 ; .... $0 | 0xDD - BOMB REFILL 4
    db $00 ; .... $0 | 0xDE - BOMB REFILL 8
    db $00 ; .... $0 | 0xDF - SMALL MAGIC DECANTER
    db $00 ; .... $0 | 0xE0 - LARGE MAGIC DECANTER
    db $00 ; .... $0 | 0xE1 - ARROW REFILL 5
    db $00 ; .... $0 | 0xE2 - ARROW REFILL 10
    db $40 ; .w.. $0 | 0xE3 - FAIRY
    db $00 ; .... $0 | 0xE4 - SMALL KEY
    db $00 ; .... $0 | 0xE5 - BIG KEY
    db $00 ; .... $0 | 0xE6 - STOLEN SHIELD
    db $00 ; .... $0 | 0xE7 - MUSHROOM
    db $00 ; .... $0 | 0xE8 - FAKE MASTER SWORD
    db $00 ; .... $0 | 0xE9 - MAGIC SHOP ASSISTANT
    db $00 ; .... $0 | 0xEA - HEART CONTAINER
    db $00 ; .... $0 | 0xEB - HEART PIECE
    db $80 ; i... $0 | 0xEC - THROWN ITEM
    db $00 ; .... $0 | 0xED - SOMARIA PLATFORM
    db $00 ; .... $0 | 0xEE - CASTLE MANTLE
    db $00 ; .... $0 | 0xEF - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF0 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF1 - UNUSED SOMARIA PLATFORM
    db $00 ; .... $0 | 0xF2 - MEDALLION TABLET
}

; $0CAA - Deflection properties
; $06B725-$06B817 DATA
SpriteData_Deflection:
{
    db $00 ; .... .... | 0x00 - RAVEN
    db $00 ; .... .... | 0x01 - VULTURE
    db $44 ; .i.. .h.. | 0x02 - STALFOS HEAD
    db $20 ; ..s. .... | 0x03 - NULL
    db $20 ; ..s. .... | 0x04 - CORRECT PULL SWITCH
    db $20 ; ..s. .... | 0x05 - UNUSED CORRECT PULL SWITCH
    db $20 ; ..s. .... | 0x06 - WRONG PULL SWITCH
    db $20 ; ..s. .... | 0x07 - UNUSED WRONG PULL SWITCH
    db $00 ; .... .... | 0x08 - OCTOROK
    db $81 ; a... ...x | 0x09 - MOLDORM
    db $00 ; .... .... | 0x0A - OCTOROK 4WAY
    db $00 ; .... .... | 0x0B - CUCCO
    db $48 ; .i.. c... | 0x0C - OCTOROK STONE
    db $00 ; .... .... | 0x0D - BUZZBLOB
    db $00 ; .... .... | 0x0E - SNAPDRAGON
    db $00 ; .... .... | 0x0F - OCTOBALLOON
    db $00 ; .... .... | 0x10 - OCTOBALLOON BABY
    db $00 ; .... .... | 0x11 - HINOX
    db $00 ; .... .... | 0x12 - MOBLIN
    db $00 ; .... .... | 0x13 - MINI HELMASAUR
    db $00 ; .... .... | 0x14 - THIEVES TOWN GRATE
    db $00 ; .... .... | 0x15 - ANTIFAIRY
    db $04 ; .... .h.. | 0x16 - SAHASRAHLA / AGINAH
    db $00 ; .... .... | 0x17 - HOARDER
    db $00 ; .... .... | 0x18 - MINI MOLDORM
    db $00 ; .... .... | 0x19 - POE
    db $00 ; .... .... | 0x1A - SMITHY
    db $48 ; .i.. c... | 0x1B - ARROW
    db $24 ; ..s. .h.. | 0x1C - STATUE
    db $80 ; a... .... | 0x1D - FLUTEQUEST
    db $00 ; .... .... | 0x1E - CRYSTAL SWITCH
    db $00 ; .... .... | 0x1F - SICK KID
    db $00 ; .... .... | 0x20 - SLUGGULA
    db $20 ; ..s. .... | 0x21 - WATER SWITCH
    db $00 ; .... .... | 0x22 - ROPA
    db $00 ; .... .... | 0x23 - RED BARI
    db $00 ; .... .... | 0x24 - BLUE BARI
    db $80 ; a... .... | 0x25 - TALKING TREE
    db $00 ; .... .... | 0x26 - HARDHAT BEETLE
    db $00 ; .... .... | 0x27 - DEADROCK
    db $00 ; .... .... | 0x28 - DARK WORLD HINT NPC
    db $00 ; .... .... | 0x29 - ADULT
    db $00 ; .... .... | 0x2A - SWEEPING LADY
    db $00 ; .... .... | 0x2B - HOBO
    db $00 ; .... .... | 0x2C - LUMBERJACKS
    db $00 ; .... .... | 0x2D - NECKLESS MAN
    db $00 ; .... .... | 0x2E - FLUTE KID
    db $80 ; a... .... | 0x2F - RACE GAME LADY
    db $80 ; a... .... | 0x30 - RACE GAME GUY
    db $00 ; .... .... | 0x31 - FORTUNE TELLER
    db $00 ; .... .... | 0x32 - ARGUE BROS
    db $00 ; .... .... | 0x33 - RUPEE PULL
    db $00 ; .... .... | 0x34 - YOUNG SNITCH
    db $00 ; .... .... | 0x35 - INNKEEPER
    db $00 ; .... .... | 0x36 - WITCH
    db $80 ; a... .... | 0x37 - WATERFALL
    db $00 ; .... .... | 0x38 - EYE STATUE
    db $80 ; a... .... | 0x39 - LOCKSMITH
    db $00 ; .... .... | 0x3A - MAGIC BAT
    db $02 ; .... ..b. | 0x3B - BONK ITEM
    db $00 ; .... .... | 0x3C - KID IN KAK
    db $00 ; .... .... | 0x3D - OLD SNITCH
    db $00 ; .... .... | 0x3E - HOARDER
    db $04 ; .... .h.. | 0x3F - TUTORIAL GUARD
    db $80 ; a... .... | 0x40 - LIGHTNING GATE
    db $00 ; .... .... | 0x41 - BLUE GUARD
    db $00 ; .... .... | 0x42 - GREEN GUARD
    db $00 ; .... .... | 0x43 - RED SPEAR GUARD
    db $00 ; .... .... | 0x44 - BLUESAIN BOLT
    db $00 ; .... .... | 0x45 - USAIN BOLT
    db $00 ; .... .... | 0x46 - BLUE ARCHER
    db $00 ; .... .... | 0x47 - GREEN BUSH GUARD
    db $00 ; .... .... | 0x48 - RED JAVELIN GUARD
    db $00 ; .... .... | 0x49 - RED BUSH GUARD
    db $00 ; .... .... | 0x4A - BOMB GUARD
    db $00 ; .... .... | 0x4B - GREEN KNIFE GUARD
    db $00 ; .... .... | 0x4C - GELDMAN
    db $00 ; .... .... | 0x4D - TOPPO
    db $00 ; .... .... | 0x4E - POPO
    db $00 ; .... .... | 0x4F - POPO
    db $84 ; a... .h.. | 0x50 - CANNONBALL
    db $00 ; .... .... | 0x51 - ARMOS STATUE
    db $81 ; a... ...x | 0x52 - KING ZORA
    db $05 ; .... .h.x | 0x53 - ARMOS KNIGHT
    db $01 ; .... ...x | 0x54 - LANMOLAS
    db $40 ; .i.. .... | 0x55 - ZORA / FIREBALL
    db $08 ; .... c... | 0x56 - ZORA
    db $A0 ; a.s. .... | 0x57 - DESERT STATUE
    db $00 ; .... .... | 0x58 - CRAB
    db $00 ; .... .... | 0x59 - LOST WOODS BIRD
    db $00 ; .... .... | 0x5A - LOST WOODS SQUIRREL
    db $00 ; .... .... | 0x5B - SPARK
    db $00 ; .... .... | 0x5C - SPARK
    db $84 ; a... .h.. | 0x5D - ROLLER VERTICAL DOWN FIRST
    db $84 ; a... .h.. | 0x5E - ROLLER VERTICAL UP FIRST
    db $84 ; a... .h.. | 0x5F - ROLLER HORIZONTAL RIGHT FIRST
    db $84 ; a... .h.. | 0x60 - ROLLER HORIZONTAL LEFT FIRST
    db $08 ; .... c... | 0x61 - BEAMOS
    db $80 ; a... .... | 0x62 - MASTERSWORD
    db $80 ; a... .... | 0x63 - DEBIRANDO PIT
    db $80 ; a... .... | 0x64 - DEBIRANDO
    db $00 ; .... .... | 0x65 - ARCHERY GUY
    db $80 ; a... .... | 0x66 - WALL CANNON VERTICAL LEFT
    db $80 ; a... .... | 0x67 - WALL CANNON VERTICAL RIGHT
    db $80 ; a... .... | 0x68 - WALL CANNON HORIZONTAL TOP
    db $80 ; a... .... | 0x69 - WALL CANNON HORIZONTAL BOTTOM
    db $00 ; .... .... | 0x6A - BALL N CHAIN
    db $08 ; .... c... | 0x6B - CANNONBALL / CANNON TROOPER
    db $80 ; a... .... | 0x6C - MIRROR PORTAL
    db $00 ; .... .... | 0x6D - RAT / CRICKET
    db $00 ; .... .... | 0x6E - SNAKE
    db $00 ; .... .... | 0x6F - KEESE
    db $40 ; .i.. .... | 0x70 - KING HELMASAUR FIREBALL
    db $00 ; .... .... | 0x71 - LEEVER
    db $00 ; .... .... | 0x72 - FAIRY POND TRIGGER
    db $00 ; .... .... | 0x73 - UNCLE / PRIEST / MANTLE
    db $00 ; .... .... | 0x74 - RUNNING MAN
    db $00 ; .... .... | 0x75 - BOTTLE MERCHANT
    db $00 ; .... .... | 0x76 - ZELDA
    db $00 ; .... .... | 0x77 - ANTIFAIRY
    db $00 ; .... .... | 0x78 - SAHASRAHLAS WIFE
    db $02 ; .... ..b. | 0x79 - BEE
    db $01 ; .... ...x | 0x7A - AGAHNIM
    db $00 ; .... .... | 0x7B - AGAHNIMS BALLS
    db $00 ; .... .... | 0x7C - GREEN STALFOS
    db $04 ; .... .h.. | 0x7D - BIG SPIKE
    db $00 ; .... .... | 0x7E - FIREBAR CLOCKWISE
    db $00 ; .... .... | 0x7F - FIREBAR COUNTERCLOCKWISE
    db $00 ; .... .... | 0x80 - FIRESNAKE
    db $00 ; .... .... | 0x81 - HOVER
    db $80 ; a... .... | 0x82 - ANTIFAIRY CIRCLE
    db $04 ; .... .h.. | 0x83 - GREEN EYEGORE / GREEN MIMIC
    db $04 ; .... .h.. | 0x84 - RED EYEGORE / RED MIMIC
    db $00 ; .... .... | 0x85 - YELLOW STALFOS
    db $00 ; .... .... | 0x86 - KODONGO
    db $48 ; .i.. c... | 0x87 - KONDONGO FIRE
    db $00 ; .... .... | 0x88 - MOTHULA
    db $00 ; .... .... | 0x89 - MOTHULA BEAM
    db $04 ; .... .h.. | 0x8A - SPIKE BLOCK
    db $00 ; .... .... | 0x8B - GIBDO
    db $01 ; .... ...x | 0x8C - ARRGHUS
    db $01 ; .... ...x | 0x8D - ARRGHI
    db $00 ; .... .... | 0x8E - TERRORPIN
    db $00 ; .... .... | 0x8F - BLOB
    db $80 ; a... .... | 0x90 - WALLMASTER
    db $00 ; .... .... | 0x91 - STALFOS KNIGHT
    db $00 ; .... .... | 0x92 - KING HELMASAUR
    db $00 ; .... .... | 0x93 - BUMPER
    db $40 ; .i.. .... | 0x94 - PIROGUSU
    db $08 ; .... c... | 0x95 - LASER EYE LEFT
    db $08 ; .... c... | 0x96 - LASER EYE RIGHT
    db $08 ; .... c... | 0x97 - LASER EYE TOP
    db $08 ; .... c... | 0x98 - LASER EYE BOTTOM
    db $00 ; .... .... | 0x99 - PENGATOR
    db $00 ; .... .... | 0x9A - KYAMERON
    db $00 ; .... .... | 0x9B - WIZZROBE
    db $80 ; a... .... | 0x9C - ZORO
    db $80 ; a... .... | 0x9D - BABASU
    db $00 ; .... .... | 0x9E - HAUNTED GROVE OSTRITCH
    db $00 ; .... .... | 0x9F - HAUNTED GROVE RABBIT
    db $00 ; .... .... | 0xA0 - HAUNTED GROVE BIRD
    db $04 ; .... .h.. | 0xA1 - FREEZOR
    db $01 ; .... ...x | 0xA2 - KHOLDSTARE
    db $05 ; .... .h.x | 0xA3 - KHOLDSTARE SHELL
    db $00 ; .... .... | 0xA4 - FALLING ICE
    db $00 ; .... .... | 0xA5 - BLUE ZAZAK
    db $00 ; .... .... | 0xA6 - RED ZAZAK
    db $00 ; .... .... | 0xA7 - STALFOS
    db $00 ; .... .... | 0xA8 - GREEN ZIRRO
    db $00 ; .... .... | 0xA9 - BLUE ZIRRO
    db $00 ; .... .... | 0xAA - PIKIT
    db $04 ; .... .h.. | 0xAB - CRYSTAL MAIDEN
    db $02 ; .... ..b. | 0xAC - APPLE
    db $00 ; .... .... | 0xAD - OLD MAN
    db $80 ; a... .... | 0xAE - PIPE DOWN
    db $80 ; a... .... | 0xAF - PIPE UP
    db $80 ; a... .... | 0xB0 - PIPE RIGHT
    db $80 ; a... .... | 0xB1 - PIPE LEFT
    db $82 ; a... ..b. | 0xB2 - GOOD BEE
    db $80 ; a... .... | 0xB3 - PEDESTAL PLAQUE
    db $00 ; .... .... | 0xB4 - PURPLE CHEST
    db $00 ; .... .... | 0xB5 - BOMB SHOP GUY
    db $80 ; a... .... | 0xB6 - KIKI
    db $00 ; .... .... | 0xB7 - BLIND MAIDEN
    db $00 ; .... .... | 0xB8 - DIALOGUE TESTER
    db $80 ; a... .... | 0xB9 - BULLY / PINK BALL
    db $80 ; a... .... | 0xBA - WHIRLPOOL
    db $00 ; .... .... | 0xBB - SHOPKEEPER / CHEST GAME GUY
    db $00 ; .... .... | 0xBC - DRUNKARD
    db $01 ; .... ...x | 0xBD - VITREOUS
    db $01 ; .... ...x | 0xBE - VITREOUS SMALL EYE
    db $40 ; .i.. .... | 0xBF - LIGHTNING
    db $00 ; .... .... | 0xC0 - CATFISH
    db $00 ; .... .... | 0xC1 - CUTSCENE AGAHNIM
    db $04 ; .... .h.. | 0xC2 - BOULDER
    db $00 ; .... .... | 0xC3 - GIBO
    db $00 ; .... .... | 0xC4 - THIEF
    db $00 ; .... .... | 0xC5 - MEDUSA
    db $00 ; .... .... | 0xC6 - 4WAY SHOOTER
    db $00 ; .... .... | 0xC7 - POKEY
    db $00 ; .... .... | 0xC8 - BIG FAIRY
    db $00 ; .... .... | 0xC9 - TEKTITE / FIREBAT / PITCHFORK
    db $04 ; .... .h.. | 0xCA - CHAIN CHOMP
    db $05 ; .... .h.x | 0xCB - TRINEXX ROCK HEAD
    db $05 ; .... .h.x | 0xCC - TRINEXX FIRE HEAD
    db $05 ; .... .h.x | 0xCD - TRINEXX ICE HEAD
    db $80 ; a... .... | 0xCE - BLIND
    db $80 ; a... .... | 0xCF - SWAMOLA
    db $00 ; .... .... | 0xD0 - LYNEL
    db $00 ; .... .... | 0xD1 - BUNNYBEAM / SMOKE
    db $00 ; .... .... | 0xD2 - FLOPPING FISH
    db $00 ; .... .... | 0xD3 - STAL
    db $00 ; .... .... | 0xD4 - LANDMINE
    db $00 ; .... .... | 0xD5 - DIG GAME GUY
    db $00 ; .... .... | 0xD6 - GANON
    db $00 ; .... .... | 0xD7 - GANON
    db $02 ; .... ..b. | 0xD8 - HEART
    db $02 ; .... ..b. | 0xD9 - GREEN RUPEE
    db $02 ; .... ..b. | 0xDA - BLUE RUPEE
    db $02 ; .... ..b. | 0xDB - RED RUPEE
    db $02 ; .... ..b. | 0xDC - BOMB REFILL 1
    db $02 ; .... ..b. | 0xDD - BOMB REFILL 4
    db $02 ; .... ..b. | 0xDE - BOMB REFILL 8
    db $02 ; .... ..b. | 0xDF - SMALL MAGIC DECANTER
    db $02 ; .... ..b. | 0xE0 - LARGE MAGIC DECANTER
    db $02 ; .... ..b. | 0xE1 - ARROW REFILL 5
    db $02 ; .... ..b. | 0xE2 - ARROW REFILL 10
    db $02 ; .... ..b. | 0xE3 - FAIRY
    db $02 ; .... ..b. | 0xE4 - SMALL KEY
    db $02 ; .... ..b. | 0xE5 - BIG KEY
    db $02 ; .... ..b. | 0xE6 - STOLEN SHIELD
    db $02 ; .... ..b. | 0xE7 - MUSHROOM
    db $02 ; .... ..b. | 0xE8 - FAKE MASTER SWORD
    db $00 ; .... .... | 0xE9 - MAGIC SHOP ASSISTANT
    db $82 ; a... ..b. | 0xEA - HEART CONTAINER
    db $82 ; a... ..b. | 0xEB - HEART PIECE
    db $08 ; .... c... | 0xEC - THROWN ITEM
    db $80 ; a... .... | 0xED - SOMARIA PLATFORM
    db $20 ; ..s. .... | 0xEE - CASTLE MANTLE
    db $80 ; a... .... | 0xEF - UNUSED SOMARIA PLATFORM
    db $80 ; a... .... | 0xF0 - UNUSED SOMARIA PLATFORM
    db $80 ; a... .... | 0xF1 - UNUSED SOMARIA PLATFORM
    db $20 ; ..s. .... | 0xF2 - MEDALLION TABLET
}

; ==============================================================================

; Load's sprite characteristics, such as HP.
; $06B818-$06B85B LONG JUMP LOCATION
Sprite_LoadProperties:
{
    JSL.l Sprite_ResetProperties
    
    PHY
    
    PHB : PHK : PLB
    
    ; Get the sprite type and get its default settings.
    LDY.w $0E20, X
    LDA.w SpriteData_OAMHarm, Y         : STA.w $0E40, X
    LDA.w SpriteData_Health, Y          : STA.w $0E50, X 
    LDA.w SpriteData_HitBox, Y          : STA.w $0F60, X
    LDA.w SpriteData_PrizePack, Y       : STA.w $0BE0, X
    LDA.w SpriteData_Deflection, Y      : STA.w $0CAA, X
    LDA.w SpriteData_Bump, Y            : STA.w $0CD2, X
    LDA.w SpriteData_TileInteraction, Y : STA.w $0B6B, X
    
    ; Load the overworld area number.
    LDA.w $040A
    
    LDY.b $1B : BEQ .outdoors
        ; If indoors, instead load the room number. (in this case, the lower
        ; byte).
        LDA.w $048E
    
    .outdoors
    
    ; And store that index here.
    STA.w $0C9A, X
    
    PLB
    
    PLY

    ; Bleeds into the next function.
}
    
; $06B85C-$06B870 LONG JUMP LOCATION
Sprite_LoadPalette:
{
    PHY
    
    PHB : PHK : PLB
    
    ; Again, tell us what sprite it is.
    LDY.w $0E20, X
    LDA.w SpriteData_OAMProp, Y : STA.w $0E60, X
    AND.b #$0F                  : STA.w $0F50, X
    
    PLB
    
    PLY
    
    RTL
}

; ==============================================================================

; $06B871-$06B8F0 LONG JUMP LOCATION
Sprite_ResetProperties:
{
    ; OPTIMIZE: LDA.b #$00 : STA.w all of these.
    STZ.w $0F00, X
    STZ.w $0E90, X
    STZ.w $0D50, X
    STZ.w $0D40, X
    STZ.w $0F80, X
    STZ.w $0D70, X
    STZ.w $0D60, X
    STZ.w $0F90, X
    STZ.w $0D80, X
    STZ.w $0DC0, X
    STZ.w $0DE0, X
    STZ.w $0DF0, X
    STZ.w $0E00, X
    STZ.w $0E10, X
    STZ.w $0F10, X
    STZ.w $0EB0, X
    STZ.w $0EC0, X
    STZ.w $0ED0, X
    STZ.w $0EF0, X
    STZ.w $0E70, X
    STZ.w $0F70, X
    STZ.w $0E50, X
    STZ.w $0EA0, X
    STZ.w $0F40, X
    STZ.w $0F30, X
    STZ.w $0D90, X
    STZ.w $0DA0, X
    STZ.w $0DB0, X
    STZ.w $0BB0, X
    STZ.w $0E80, X
    STZ.w $0BA0, X
    STZ.w $0B89, X
    STZ.w $0F50, X
    STZ.w $0B58, X
    STZ.w $0CE2, X
    
    LDA.b #$00 : STA.l $7FFA1C, X
                 STA.l $7FFA2C, X
                 STA.l $7FFA3C, X
                 STA.l $7FFA4C, X
                 STA.l $7FF9C2, X
    
    RTL
}

; ==============================================================================

; (This data is used in bank 0x06, so look there).
; $06B8F1-$06B970 DATA
DamageSubclassValue:
{
    db $00, $01, $20, $FF, $FC, $FB, $00, $00 ; 0x00 - Boomerang
    db $00, $02, $40, $04, $00, $00, $00, $00 ; 0x01 - Sword 1
    db $00, $04, $40, $02, $03, $00, $00, $00 ; 0x02 - Sword 2
    db $00, $08, $40, $04, $00, $00, $00, $00 ; 0x03 - Sword 3
    db $00, $10, $40, $08, $00, $00, $00, $00 ; 0x04 - Sword 4
    db $00, $10, $40, $08, $00, $00, $00, $00 ; 0x05 - Sword 5
    db $00, $04, $40, $10, $00, $00, $00, $00 ; 0x06 - Arrow
    db $00, $FF, $40, $FF, $FC, $FB, $00, $00 ; 0x07 - Hookshot
    db $00, $04, $40, $FF, $FC, $FB, $20, $00 ; 0x08 - Bomb
    db $00, $64, $18, $64, $00, $00, $00, $00 ; 0x09 - Silver arrow
    db $00, $F9, $FA, $FF, $64, $00, $00, $00 ; 0x0A - Powder
    db $00, $08, $40, $FD, $04, $10, $00, $00 ; 0x0B - Fire rod
    db $00, $08, $40, $FE, $04, $00, $00, $00 ; 0x0C - Ice rod
    db $00, $10, $40, $FD, $00, $00, $00, $00 ; 0x0D - Bombos
    db $00, $FE, $40, $10, $00, $00, $00, $00 ; 0x0E - Ether
    db $00, $20, $40, $FF, $00, $00, $00, $FA ; 0x0F - Quake
}

; ==============================================================================

; $06B971-$06BA70 DATA
Sprite_SimplifiedTileAttr:
{
    db $00 ; 0x00
    db $01 ; 0x01
    db $00 ; 0x02
    db $00 ; 0x03
    db $00 ; 0x04
    db $00 ; 0x05
    db $00 ; 0x06
    db $00 ; 0x07
    db $00 ; 0x08
    db $00 ; 0x09
    db $03 ; 0x0A
    db $00 ; 0x0B
    db $00 ; 0x0C
    db $00 ; 0x0D
    db $00 ; 0x0E
    db $00 ; 0x0F
    db $01 ; 0x10
    db $01 ; 0x11
    db $01 ; 0x12
    db $01 ; 0x13
    db $00 ; 0x14
    db $00 ; 0x15
    db $00 ; 0x16
    db $00 ; 0x17
    db $01 ; 0x18
    db $01 ; 0x19
    db $01 ; 0x1A
    db $01 ; 0x1B
    db $00 ; 0x1C
    db $03 ; 0x1D
    db $03 ; 0x1E
    db $03 ; 0x1F
    db $00 ; 0x20
    db $00 ; 0x21
    db $00 ; 0x22
    db $00 ; 0x23
    db $00 ; 0x24
    db $00 ; 0x25
    db $01 ; 0x26
    db $01 ; 0x27
    db $04 ; 0x28
    db $04 ; 0x29
    db $04 ; 0x2A
    db $04 ; 0x2B
    db $04 ; 0x2C
    db $04 ; 0x2D
    db $04 ; 0x2E
    db $04 ; 0x2F
    db $01 ; 0x30
    db $01 ; 0x31
    db $01 ; 0x32
    db $01 ; 0x33
    db $01 ; 0x34
    db $01 ; 0x35
    db $01 ; 0x36
    db $01 ; 0x37
    db $01 ; 0x38
    db $01 ; 0x39
    db $00 ; 0x3A
    db $00 ; 0x3B
    db $01 ; 0x3C
    db $01 ; 0x3D
    db $01 ; 0x3E
    db $01 ; 0x3F
    db $00 ; 0x40
    db $00 ; 0x41
    db $00 ; 0x42
    db $00 ; 0x43
    db $00 ; 0x44
    db $00 ; 0x45
    db $00 ; 0x46
    db $00 ; 0x47
    db $00 ; 0x48
    db $00 ; 0x49
    db $00 ; 0x4A
    db $00 ; 0x4B
    db $04 ; 0x4C
    db $04 ; 0x4D
    db $04 ; 0x4E
    db $04 ; 0x4F
    db $00 ; 0x50
    db $00 ; 0x51
    db $00 ; 0x52
    db $00 ; 0x53
    db $00 ; 0x54
    db $00 ; 0x55
    db $00 ; 0x56
    db $00 ; 0x57
    db $00 ; 0x58
    db $00 ; 0x59
    db $00 ; 0x5A
    db $00 ; 0x5B
    db $00 ; 0x5C
    db $00 ; 0x5D
    db $00 ; 0x5E
    db $00 ; 0x5F
    db $00 ; 0x60
    db $00 ; 0x61
    db $00 ; 0x62
    db $00 ; 0x63
    db $00 ; 0x64
    db $00 ; 0x65
    db $00 ; 0x66
    db $00 ; 0x67
    db $00 ; 0x68
    db $00 ; 0x69
    db $00 ; 0x6A
    db $00 ; 0x6B
    db $01 ; 0x6C
    db $01 ; 0x6D
    db $01 ; 0x6E
    db $01 ; 0x6F
    db $00 ; 0x70
    db $00 ; 0x71
    db $00 ; 0x72
    db $00 ; 0x73
    db $00 ; 0x74
    db $00 ; 0x75
    db $00 ; 0x76
    db $00 ; 0x77
    db $00 ; 0x78
    db $00 ; 0x79
    db $00 ; 0x7A
    db $00 ; 0x7B
    db $00 ; 0x7C
    db $00 ; 0x7D
    db $00 ; 0x7E
    db $00 ; 0x7F
    db $01 ; 0x80
    db $01 ; 0x81
    db $01 ; 0x82
    db $01 ; 0x83
    db $01 ; 0x84
    db $01 ; 0x85
    db $01 ; 0x86
    db $01 ; 0x87
    db $01 ; 0x88
    db $01 ; 0x89
    db $01 ; 0x8A
    db $01 ; 0x8B
    db $01 ; 0x8C
    db $01 ; 0x8D
    db $01 ; 0x8E
    db $01 ; 0x8F
    db $01 ; 0x90
    db $01 ; 0x91
    db $01 ; 0x92
    db $01 ; 0x93
    db $01 ; 0x94
    db $01 ; 0x95
    db $01 ; 0x96
    db $01 ; 0x97
    db $01 ; 0x98
    db $01 ; 0x99
    db $01 ; 0x9A
    db $01 ; 0x9B
    db $01 ; 0x9C
    db $01 ; 0x9D
    db $01 ; 0x9E
    db $01 ; 0x9F
    db $01 ; 0xA0
    db $01 ; 0xA1
    db $01 ; 0xA2
    db $01 ; 0xA3
    db $01 ; 0xA4
    db $01 ; 0xA5
    db $01 ; 0xA6
    db $01 ; 0xA7
    db $01 ; 0xA8
    db $01 ; 0xA9
    db $01 ; 0xAA
    db $01 ; 0xAB
    db $01 ; 0xAC
    db $01 ; 0xAD
    db $01 ; 0xAE
    db $01 ; 0xAF
    db $00 ; 0xB0
    db $00 ; 0xB1
    db $00 ; 0xB2
    db $00 ; 0xB3
    db $00 ; 0xB4
    db $00 ; 0xB5
    db $00 ; 0xB6
    db $00 ; 0xB7
    db $00 ; 0xB8
    db $00 ; 0xB9
    db $00 ; 0xBA
    db $00 ; 0xBB
    db $00 ; 0xBC
    db $00 ; 0xBD
    db $00 ; 0xBE
    db $00 ; 0xBF
    db $00 ; 0xC0
    db $00 ; 0xC1
    db $00 ; 0xC2
    db $00 ; 0xC3
    db $00 ; 0xC4
    db $00 ; 0xC5
    db $00 ; 0xC6
    db $00 ; 0xC7
    db $00 ; 0xC8
    db $00 ; 0xC9
    db $00 ; 0xCA
    db $00 ; 0xCB
    db $00 ; 0xCC
    db $00 ; 0xCD
    db $00 ; 0xCE
    db $00 ; 0xCF
    db $00 ; 0xD0
    db $00 ; 0xD1
    db $00 ; 0xD2
    db $00 ; 0xD3
    db $00 ; 0xD4
    db $00 ; 0xD5
    db $00 ; 0xD6
    db $00 ; 0xD7
    db $00 ; 0xD8
    db $00 ; 0xD9
    db $00 ; 0xDA
    db $00 ; 0xDB
    db $00 ; 0xDC
    db $00 ; 0xDD
    db $00 ; 0xDE
    db $00 ; 0xDF
    db $00 ; 0xE0
    db $00 ; 0xE1
    db $00 ; 0xE2
    db $00 ; 0xE3
    db $00 ; 0xE4
    db $00 ; 0xE5
    db $00 ; 0xE6
    db $00 ; 0xE7
    db $00 ; 0xE8
    db $00 ; 0xE9
    db $00 ; 0xEA
    db $00 ; 0xEB
    db $00 ; 0xEC
    db $00 ; 0xED
    db $00 ; 0xEE
    db $00 ; 0xEF
    db $01 ; 0xF0
    db $01 ; 0xF1
    db $01 ; 0xF2
    db $01 ; 0xF3
    db $01 ; 0xF4
    db $01 ; 0xF5
    db $01 ; 0xF6
    db $01 ; 0xF7
    db $01 ; 0xF8
    db $01 ; 0xF9
    db $01 ; 0xFA
    db $01 ; 0xFB
    db $01 ; 0xFC
    db $01 ; 0xFD
    db $01 ; 0xFE
    db $01 ; 0xFF
}

; ==============================================================================

; $06BA71-$06BA7F LONG JUMP LOCATION
GetRandomInt:
{
    ; Interesting to note two consecutive reads from differing locations.
    ; What this first read does is latch a hardware register (v or hcount, I
    ; can't remember) Reading this "latch" places a value in $213C.
    LDA.w SNES.OAMReadDataLowHigh
    
    ; The purpose of this routine is to generate a random
    ; Number, of course. Number = counter + frame counter + $0FA1 which is
    ; apparently an accumulator.
    
    ; Contributing to the chaos is that all adds are done without regard to
    ; the state of the carry. It's probably not a well distributed random
    ; number generator but I'm sure it gets the job done most of the time.
    LDA.w SNES.HCounterData : ADC.b $1A : ADC.w $0FA1 : STA.w $0FA1
    
    RTL
}

; ==============================================================================

; $06BA80-$06BB5A
incsrc "sprite_OAM_allocation.asm"

; ==============================================================================

; $06BB5B-$06BB5D DATA TABLE
Sound_SetSFXPan_pan_options:
{
    dw $00, $80, $40
}

; ==============================================================================

; $06BB5E-$06BB66 LONG JUMP LOCATION
Sound_SFXPanObjectCoords:
{
    LDA.w $0C18, X : XBA
    LDA.w $0C04, X
    
    BRA Sound_SetSFXPan_useArbitraryCoords
}

; ==============================================================================

; $06BB67-$06BB6D LONG JUMP LOCATION
Sound_SetSFXPanWithPlayerCoords:
{
    LDA.b $23 : XBA
    LDA.b $22
    
    BRA Sound_SetSFXPan_useArbitraryCoords
}

; ==============================================================================

; $06BB6E-$06BB7B LONG JUMP LOCATION
Sound_SetSFX1PanLong:
{
    PHY
    
    LDY.w $012D : BNE .channelInUse
        JSR.w Sound_AddSFXPan
        
        STA.w $012D
    
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB7C-$06BB89 LONG JUMP LOCATION
Sound_SetSFX2PanLong:
{
    PHY
    
    LDY.w $012E : BEQ .channelInUse
        JSR.w Sound_AddSFXPan
        
        STA.w $012E
        
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB8A-$06BB97 LONG JUMP LOCATION
Sound_SetSFX3PanLong:
{
    PHY
    
    ; Is there a sound effect playing on this channel?
    LDY.w $012F : BNE .channelInUse
        JSR.w Sound_AddSFXPan
        
        ; Picked a sound effect, play it.
        STA.w $012F
        
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB98-$06BBA0 LOCAL JUMP LOCATION
Sound_AddSFXPan:
{
    ; Store the sound effect index here temporarily.
    STA.b $0D
    
    JSL.l Sound_SetSFXPan : ORA.b $0D
    
    RTS
}

; ==============================================================================

; Used to determine stereo settings for sound effects. For example, if a
; bomb is more towards the left of the screen, the sound will mostly come
; out of the left speaker. The sound engine knows how to handle these inputs.
; $06BBA1-$06BBC7 LONG JUMP LOCATION
Sound_SetSFXPan:
{
    LDA.w $0D30, X : XBA
    LDA.w $0D10, X
    
    ; $06BBA8 BRANCH LOCATION
    .useArbitraryCoords
    
    REP #$20
    
    PHX
    
    LDX.b #$00
    
    ; A = Sprites X position minus the X coordinate of the scroll register for
    ; Layer 2. If A (unsigned) is less than #$50. A will be #$00.
    SEC : SBC.b $E2 : SEC : SBC.w #$0050 : CMP.w #$0050 : BCC .panSelected
        INX
        
        CMP.w #$0000 : BMI .panSelected
            INX ; And if all else fails, A will be #$40.
    
    .panSelected
    
    SEP #$20
    
    LDA.w .pan_options, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $06BBC8-$06BBCF DATA
Sound_GetFineSFXPan_settings:
{
    db $80, $80, $80, $00, $00, $40, $40, $40
}

; $06BBD0-$06BBDF LONG JUMP LOCATION
Sound_GetFineSFXPan:
{
    SEC : SBC.b $E2 : LSR #5 : PHX
                             : TAX
    
    LDA.w .settings, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $06BBE0-$06BD1F DATA
Babusu_Draw_OAM_groups:
{
    dw  0,  4 : db $80, $43, $00, $00
    dw  0,  4 : db $80, $43, $00, $00
    
    dw  0,  4 : db $B6, $43, $00, $00
    dw  0,  4 : db $B6, $43, $00, $00
    
    dw  0,  4 : db $B7, $43, $00, $00
    dw  8,  4 : db $80, $03, $00, $00
    
    dw  0,  4 : db $80, $43, $00, $00
    dw  8,  4 : db $B6, $03, $00, $00
    
    dw  8,  4 : db $B7, $03, $00, $00
    dw  8,  4 : db $B7, $03, $00, $00
    
    dw  8,  4 : db $80, $03, $00, $00
    dw  8,  4 : db $80, $03, $00, $00
    
    dw  4,  0 : db $80, $83, $00, $00
    dw  4,  0 : db $80, $83, $00, $00
    
    dw  4,  0 : db $B6, $83, $00, $00
    dw  4,  0 : db $B6, $83, $00, $00
    
    dw  4,  0 : db $B7, $83, $00, $00
    dw  4,  8 : db $80, $03, $00, $00
    
    dw  4,  0 : db $80, $83, $00, $00
    dw  4,  8 : db $B6, $03, $00, $00
    
    dw  4,  8 : db $B7, $03, $00, $00
    dw  4,  8 : db $B7, $03, $00, $00
    
    dw  4,  8 : db $80, $03, $00, $00
    dw  4,  8 : db $80, $03, $00, $00
    
    dw  0, -8 : db $4E, $0A, $00, $02
    dw  0,  0 : db $5E, $0A, $00, $02
    
    dw  0, -8 : db $4E, $4A, $00, $02
    dw  0,  0 : db $5E, $4A, $00, $02
    
    dw  8,  0 : db $6C, $0A, $00, $02
    dw  0,  0 : db $6B, $0A, $00, $02
    
    dw  8,  0 : db $6C, $8A, $00, $02
    dw  0,  0 : db $6B, $8A, $00, $02
    
    dw  0,  8 : db $4E, $8A, $00, $02
    dw  0,  0 : db $5E, $8A, $00, $02
    
    dw  0,  8 : db $4E, $CA, $00, $02
    dw  0,  0 : db $5E, $CA, $00, $02
    
    dw -8,  0 : db $6C, $4A, $00, $02
    dw  0,  0 : db $6B, $4A, $00, $02
    
    dw -8,  0 : db $6C, $CA, $00, $02
    dw  0,  0 : db $6B, $CA, $00, $02   
}

; $06BD20-$06BD45 LONG JUMP LOCATION
Babusu_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : BMI .invalid_animation_state
        REP #$20
        
        ASL #4 : ADC.w #(.OAM_groups) : STA.b $08
        
        SEP #$20
        
        LDA.b #$02
        JSL.l Sprite_DrawMultiple

        PLB
            
        RTL
    
    .invalid_animation_state
    
    JSL.l Sprite_PrepOamCoordLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BD46-$06BE05 DATA
Wizzrobe_Draw_OAM_groups:
{
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $88, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $86, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8C, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8A, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8C, $40, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8A, $40, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $A4, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8E, $00, $00, $02
}

; $06BE06-$06BE27 LONG JUMP LOCATION
Wizzrobe_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20

    ASL #3                                 : STA.b $00
    ASL : ADC.b $00 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03
    JSL.l Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BE28-$06BE67 DATA
Wizzbeam_Draw_OAM_groups:
{
    dw  0, -4 : db $C5, $00, $00, $00
    dw  0,  4 : db $C5, $80, $00, $00
    
    dw  0, -4 : db $C5, $40, $00, $00
    dw  0,  4 : db $C5, $C0, $00, $00
    
    dw -4,  0 : db $D2, $40, $00, $00
    dw  4,  0 : db $D2, $00, $00, $00
    
    dw -4,  0 : db $D2, $C0, $00, $00
    dw  4,  0 : db $D2, $80, $00, $00
}

; $06BE68-$06BE85 LONG JUMP LOCATION
Wizzbeam_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DE0, X
    
    REP #$20
    
    ASL #4 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02
    JSL.l Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BE86-$06BFA5 DATA
Pool_Freezor_Draw:
{
    ; $06BE86
    .death_OAM_groups
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    dw  0, 11 : db $AB, $00, $00, $00
    dw  8, 11 : db $AB, $40, $00, $00
    
    dw -8,  0 : db $AC, $00, $00, $02
    dw  8,  0 : db $A8, $40, $00, $02
    dw  0, 11 : db $BA, $00, $00, $00
    dw  8, 11 : db $BB, $00, $00, $00
    
    dw -8,  0 : db $A8, $00, $00, $02
    dw  8,  0 : db $AC, $40, $00, $02
    dw  0, 11 : db $BB, $40, $00, $00
    dw  8, 11 : db $BA, $40, $00, $00
    
    dw  0,  2 : db $AE, $00, $00, $00
    dw  8,  2 : db $AE, $40, $00, $00
    dw  0, 10 : db $BE, $00, $00, $00
    dw  8, 10 : db $BE, $40, $00, $00
    
    dw  0,  4 : db $AF, $00, $00, $00
    dw  8,  4 : db $AF, $40, $00, $00
    dw  0, 12 : db $BF, $00, $00, $00
    dw  8, 12 : db $BF, $40, $00, $00
    
    dw  0,  8 : db $AA, $00, $00, $00
    dw  8,  8 : db $AA, $40, $00, $00
    dw  0,  8 : db $AA, $00, $00, $00
    dw  8,  8 : db $AA, $40, $00, $00
    
    ; $06BF66
    .normal_OAM_group
    dw  0, 0 : db $AE, $00, $00, $00
    dw  8, 0 : db $AE, $40, $00, $00
    dw  0, 8 : db $BE, $00, $00, $00
    dw  8, 8 : db $BE, $40, $00, $00
    dw -2, 0 : db $AE, $00, $00, $00
    dw 10, 0 : db $AE, $40, $00, $00
    dw -2, 8 : db $BE, $00, $00, $00
    dw 10, 8 : db $BE, $40, $00, $00
}

; $06BFA6-$06BFD5 LONG JUMP LOCATION
Freezor_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : CMP.b #$07 : BEQ .use_normal_OAM_groups
        REP #$20 : ASL #5 : ADC.w #(Pool_Freezor_Draw_death_OAM_groups) : STA.b $08
        
        SEP #$20
        
        LDA.b #$04
        
        .now_draw
        
        JSL.l Sprite_DrawMultiple
        
        PLB
        
        RTL
    
    .use_normal_OAM_groups
    
    REP #$20
    
    LDA.w #(Pool_Freezor_Draw_normal_OAM_group) : STA.b $08
    
    SEP #$20
    
    LDA.b #$08
    
    BRA .now_draw
}

; ==============================================================================

; $06BFD6-$06C0A5 DATA
Pool_Zazak_Draw:
{
    ; $06BFD6
    .OAM_groups
    dw  0, -8 : db $08, $00, $00, $02
    dw -4,  0 : db $A0, $00, $00, $02
    dw  4,  0 : db $A1, $00, $00, $02
    
    dw  0, -7 : db $08, $00, $00, $02
    dw -4,  1 : db $A1, $40, $00, $02
    dw  4,  1 : db $A0, $40, $00, $02
    
    dw  0, -8 : db $0E, $00, $00, $02
    dw -4,  0 : db $A3, $00, $00, $02
    dw  4,  0 : db $A4, $00, $00, $02
    
    dw  0, -7 : db $0E, $00, $00, $02
    dw -4,  1 : db $A4, $40, $00, $02
    dw  4,  1 : db $A3, $40, $00, $02
    
    dw  0, -9 : db $0C, $00, $00, $02
    dw  0,  0 : db $A6, $00, $00, $02
    dw  0,  0 : db $A6, $00, $00, $02
    
    dw  0, -8 : db $0C, $00, $00, $02
    dw  0,  0 : db $A8, $00, $00, $02
    dw  0,  0 : db $A8, $00, $00, $02
    
    dw  0, -9 : db $0C, $40, $00, $02
    dw  0,  0 : db $A6, $40, $00, $02
    dw  0,  0 : db $A6, $40, $00, $02
    
    dw  0, -8 : db $0C, $40, $00, $02
    dw  0,  0 : db $A8, $40, $00, $02
    dw  0,  0 : db $A8, $40, $00, $02
    
    ; $06C096
    .chr_overrides
    db $82, $82, $80, $84, $88, $88, $86, $84
    
    ; $06C09E
    .vh_flip_overrides
    db $40, $00, $00, $00, $40, $00, $00, $00
}

; ==============================================================================

; $06C0A6-$06C0F2 LONG JUMP LOCATION
Zazak_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20

    ASL #3                                 : STA.b $00
    ASL : ADC.b $00 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL.l Sprite_DrawMultiple
        LDA.w $0F00, X : BNE .paused
            LDA.w $0E00, X : CMP.b #$01 : PHX
            LDA.w $0EB0, X : TAX
            BCC .mouth_closed
                INX #4
            
            .mouth_closed
            
            LDA.w .chr_overrides, X : LDY.b #$02 : STA.b ($90), Y
            
            INY
            
            LDA.b ($90), Y : AND.b #$BF : ORA .vh_flip_overrides, X : STA.b ($90), Y
            
            PLX
            
            JSL.l Sprite_DrawShadowLong
    
    .paused
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C0F3-$06C216 DATA
Pool_Stalfos_Draw:
{
    ; $06C0F3
    .OAM_groups
    dw  0, -10 : db $00, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    
    dw  0,  -9 : db $00, $00, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    
    dw  0, -10 : db $04, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    
    dw  0,  -9 : db $04, $00, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    
    dw  0, -10 : db $02, $00, $00, $02
    dw  5,   5 : db $2E, $00, $00, $00
    dw  0,   0 : db $24, $00, $00, $02
    
    dw  0, -10 : db $02, $00, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    
    dw  0, -10 : db $02, $40, $00, $02
    dw  3,   5 : db $2E, $40, $00, $00
    dw  0,   0 : db $24, $40, $00, $02
    
    dw  0, -10 : db $02, $40, $00, $02
    dw  0,   0 : db $0E, $40, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    
    dw  2,  -8 : db $02, $40, $00, $02
    dw  0,   0 : db $08, $40, $00, $02
    dw  0,   0 : db $08, $40, $00, $02
    
    dw -2,  -8 : db $02, $00, $00, $02
    dw  0,   0 : db $08, $00, $00, $02
    dw  0,   0 : db $08, $00, $00, $02
    
    dw  0, -10 : db $00, $00, $00, $02
    dw  0,   0 : db $0A, $00, $00, $02
    dw  0,   0 : db $0A, $00, $00, $02
    
    dw  0,   0 : db $0A, $00, $00, $02
    dw  0,  -6 : db $04, $00, $00, $02
    dw  0,  -6 : db $04, $00, $00, $02
    
    ; $06C213
    .head_chr
    db $02, $02, $00, $04
}

; $06C217-$06C21B DATA
SpriteDontDraw_Stalfos:
{
    JSL.l Sprite_PrepOamCoordLong
    
    RTL
}

; $06C21C-$06C26D LONG JUMP LOCATION
Stalfos_Draw:
{
    LDA.w $0E10, X : BNE SpriteDontDraw_Stalfos
        PHB : PHK : PLB
        
        LDA.b #$00 : XBA
        LDA.w $0DC0, X
        
        REP #$20
        
        ASL #3                                                  : STA.b $00
        ASL : ADC.b $00 : ADC.w #(Pool_Stalfos_Draw_OAM_groups) : STA.b $08
        
        SEP #$20
        
        LDA.b #$03
        JSL.l Sprite_DrawMultiple
        
        LDA.w $0DC0, X : CMP.b #$08 : BCS .no_head_override
            LDA.w $0F00, X : BNE .no_head_override
                PHX
                
                LDA.w $0EB0, X : TAX
                LDA.w Pool_Stalfos_Draw_head_chr, X : LDY.b #$02 : STA.b ($90), Y
                
                INY
                LDA.b ($90), Y : AND.b #$8F : ORA .head_properties, X : STA.b ($90), Y
                
                PLX
        
        .no_head_override
        
        JSL.l Sprite_DrawShadowLong
            
        PLB
            
        RTL
    
    ; $06C26A
    .head_properties
    db $70, $30, $30, $30
}

; ==============================================================================

; $06C26E-$06C2D0 LONG JUMP LOCATION
Probe_CheckTileSolidity:
{
    LDA.w $0F20, X : CMP.b #$01 : REP #$30 : STZ.b $05 : BCC .on_bg2
        LDA.w #$1000 : STA.b $05
    
    .on_bg2
    
    SEP #$20
    
    LDA.b $1B : REP #$20 : BEQ .outdoors
        LDA.w $0FD8 : AND.w #$01FF : LSR #3 : STA.b $04
        
        LDA.w $0FDA : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $05
        
        PHX
        
        TAX
        
        ; Detect the tile type the soldier interacts with
        LDA.l $7F2000, X
        
        PLX
        
        BRA .finished
    
    .outdoors
    
    PHX : PHY
    
    LDA.w $0FD8 : LSR #3 : STA.b $02
    
    LDA.w $0FDA : STA.b $00
    
    SEP #$30
    
    JSL.l Overworld_ReadTileAttr
    
    ; (It will later be translated into something dungeon oriented).
    REP #$10
    
    PLY : PLX
    
    .finished
    
    SEP #$30
    
    PHX
    
    STA.w $0FA5 : TAX
    
    LDA Sprite_SimplifiedTileAttr, X : PLX : CMP.b #$01
    
    RTL
}

; ==============================================================================

; $06C2D1-$06C4A4
incsrc "sprite_human_multi_1.asm"

; $06C4A5-$06C50A
incsrc "sprite_sweeping_lady.asm"

; $06C50B-$06C6DD
incsrc "sprite_lumberjacks.asm"

; $06C6DE-$06C759
incsrc "sprite_unused_telepath.asm"

; $06C75A-$06CB53
incsrc "sprite_fortune_teller.asm"

; $06CB54-$06CBE9
incsrc "sprite_maze_game_lady.asm"

; $06CBEA-$06CDCE
incsrc "sprite_maze_game_guy.asm"

; ==============================================================================

; $06CDCF-$06CE5E DATA
Pool_CrystalMaiden_Draw:
{
    ; $06CDCF
    .OAM_groups
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $41, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $41, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    ; $06CE4F
    .VRAM_source_indices
    db $20, $C0
    db $20, $C0
    db $00, $A0
    db $00, $A0
    db $40, $80
    db $40, $60
    db $40, $80
    db $40, $60
}

; $06CE5F-$06CE90 LONG JUMP LOCATION
CrystalMaiden_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL : TAY
    LDA.w Pool_CrystalMaiden_Draw_VRAM_source_indices+0, Y : STA.w $0AE8
    LDA.w Pool_CrystalMaiden_Draw_VRAM_source_indices+1, Y : STA.w $0AEA
    
    ; Crystal maidens?
    TYA : ASL #3
    
    ADC.b #(Pool_CrystalMaiden_Draw_OAM_groups >> 0)              : STA.b $08
    LDA.b #(Pool_CrystalMaiden_Draw_OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CE91-$06CF30 DATA
Pool_Priest_Draw_OAM_groups:
{
    dw  0, -8 : db $20, $0E, $00, $02
    dw  0,  0 : db $26, $0E, $00, $02
    
    dw  0, -8 : db $20, $0E, $00, $02
    dw  0,  0 : db $26, $4E, $00, $02
    
    dw  0, -8 : db $0E, $0E, $00, $02
    dw  0,  0 : db $24, $0E, $00, $02
    
    dw  0, -8 : db $0E, $0E, $00, $02
    dw  0,  0 : db $24, $0E, $00, $02
    
    dw  0, -8 : db $22, $0E, $00, $02
    dw  0,  0 : db $28, $0E, $00, $02
    
    dw  0, -8 : db $22, $0E, $00, $02
    dw  0,  0 : db $2A, $0E, $00, $02
    
    dw  0, -8 : db $22, $4E, $00, $02
    dw  0,  0 : db $28, $4E, $00, $02
    
    dw  0, -8 : db $22, $4E, $00, $02
    dw  0,  0 : db $2A, $4E, $00, $02
    
    dw -7,  1 : db $0A, $0E, $00, $02
    dw  3,  3 : db $0C, $0E, $00, $02
    
    dw -7,  1 : db $0A, $0E, $00, $02
    dw  3,  3 : db $0C, $0E, $00, $02
}

; Called by two routines.
; $06CF31-$06CF58 LONG JUMP LOCATION
Priest_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #4
                 ADC.b #(.OAM_groups >. 0) : STA.b $08
    LDA.b #$00 : ADC.b #(.OAM_groups >> 8) : STA.b $09
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CF59-$06CFD8 DATA
Pool_FluteBoy_Draw_OAM_groups:
{
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   0 : db $AA, $0A, $00, $02
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   8 : db $BF, $0A, $00, $00
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   0 : db $AA, $0A, $00, $02
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   8 : db $BF, $0A, $00, $00
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
}

; $06CFD9-$06CFFF LONG JUMP LOCATION
FluteBoy_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$10
    JSL.l OAM_AllocateFromRegionB
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #5
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM-groups >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$04
    JSL.l Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D000-$06D03F DATA
FluteAardvark_Draw_OAM_groups:
{
    db 0, -10, $E6, $06, $00, $02
    db 0,  -8, $C8, $06, $00, $02
    
    db 0, -10, $E6, $06, $00, $02
    db 0,  -8, $CA, $06, $00, $02
    
    db 0, -10, $E8, $06, $00, $02
    db 0,  -8, $CA, $06, $00, $02
    
    db 0, -10, $CC, $00, $00, $02
    db 0,  -8, $DC, $00, $00, $02
}

; $06D040-$06D05F LONG JUMP LOCATION
FluteAardvark_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM-groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D060-$06D11F DATA
DustCloud_Draw_OAM_groups:
{
    db  0, -3 : db $8B, $00, $00, $00
    db  3,  0 : db $9B, $00, $00, $00
    db -3,  0 : db $8B, $C0, $00, $00
    db  0,  3 : db $9B, $C0, $00, $00
    
    db  0, -5 : db $8A, $00, $00, $02
    db  5,  0 : db $8A, $00, $00, $02
    db -5,  0 : db $8A, $00, $00, $02
    db  0,  5 : db $8A, $00, $00, $02
    
    db  0, -7 : db $86, $00, $00, $02
    db  7,  0 : db $86, $00, $00, $02
    db -7,  0 : db $86, $00, $00, $02
    db  0,  7 : db $86, $00, $00, $02
    
    db  0, -9 : db $86, $80, $00, $02
    db  9,  0 : db $86, $80, $00, $02
    db -9,  0 : db $86, $80, $00, $02
    db  0,  9 : db $86, $80, $00, $02
    
    db  0, -9 : db $86, $C0, $00, $02
    db  9,  0 : db $86, $C0, $00, $02
    db -9,  0 : db $86, $C0, $00, $02
    db  0,  9 : db $86, $C0, $00, $02
    
    db  0, -7 : db $86, $40, $00, $02
    db  7,  0 : db $86, $40, $00, $02
    db -7,  0 : db $86, $40, $00, $02
    db  0,  7 : db $86, $40, $00, $02
}

; $06D120-$06D141 LONG JUMP LOCATION
DustCloud_Draw:
{
    ; Part of medallion tablet code...
    PHB : PHK : PLB
    
    LDA.b #$14 : STA.w $0F50, X
    
    LDA.w $0DC0, X : ASL #5
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$04
    JSL.l Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D142-$06D1E1 DATA
MedallionTablet_Draw_OAM_groups:
{
    dw -8, -16 : $8C, $00, $00, $02
    dw  8, -16 : $8C, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8, -13 : $8A, $00, $00, $02
    dw  8, -13 : $8A, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8,  -8 : $8A, $00, $00, $02
    dw  8,  -8 : $8A, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8,  -4 : $8A, $00, $00, $02
    dw  8,  -4 : $8A, $40, $00, $02
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
    
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
}

; $06D1E2-$06D202 LONG JUMP LOCATION
MedallionTablet_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0DC0, X : ASL #5
    ADC.b #(.OAM_groups>>0)              : STA.b $08
    LDA.b #(.OAM_groups>>8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : STA.b $06
                 STZ.b $07
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D203-$06D390 DATA
Pool_Uncle_Draw:
{
    ; $06D203
    .OAM_groups
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw  -7,   2 : db $07, $0D, $00, $02
    dw  -7,   2 : db $07, $0D, $00, $02
    dw  10,  12 : db $05, $8D, $00, $00
    dw  10,   4 : db $15, $8D, $00, $00
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $04, $0C, $00, $02
    dw  -7,   1 : db $07, $0D, $00, $02
    dw  -7,   1 : db $07, $0D, $00, $02
    dw  10,  13 : db $05, $8D, $00, $00
    dw  10,   5 : db $15, $8D, $00, $00
    dw   0,  -9 : db $00, $0E, $00, $02
    dw   0,   1 : db $04, $4C, $00, $02
    dw  -7,   8 : db $05, $8D, $00, $00
    dw   1,   8 : db $06, $8D, $00, $00
    dw   0, -10 : db $02, $0E, $00, $02
    dw  -6,  -1 : db $07, $4D, $00, $02
    dw   0,   0 : db $23, $0C, $00, $02
    dw   0,   0 : db $23, $0C, $00, $02
    dw  -9,   7 : db $05, $8D, $00, $00
    dw  -1,   7 : db $06, $8D, $00, $00
    dw   0,  -9 : db $02, $0E, $00, $02
    dw  -6,   0 : db $07, $4D, $00, $02
    dw   0,   1 : db $25, $0C, $00, $02
    dw   0,   1 : db $25, $0C, $00, $02
    dw -10, -17 : db $07, $0D, $00, $02
    dw  15, -12 : db $15, $8D, $00, $00
    dw  15,  -4 : db $05, $8D, $00, $00
    dw   0, -28 : db $08, $0E, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    dw   0, -28 : db $08, $0E, $00, $02
    dw   0, -28 : db $08, $0E, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    
    ; $06D383
    .source_for_VRAM_1
    db $08, $08, $00, $00, $06, $06, $00
    
    ; $06D38A
    .source_for_VRAM_2
    db $00, $00, $00, $00, $04, $04, $00
}

; $06D391-$06D3EA LONG JUMP LOCATION
Uncle_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$18
    JSL.l OAM_AllocateFromRegionB
    
    REP #$20
    
    LDA.w $0DC0, X : AND.w #$00FF : STA.b $00
    LDA.w $0DE0, X : AND.w #$00FF : STA.b $02
    
    ; This calculation is... ( ( ( ( (v2 * 2) + v2 + v0) * 2) + v0) * 16 )
    ; or... 96v2 + 48v0. wtf is this for?
    ASL : ADC.b $02 : ADC.b $00 : ASL : ADC.b $00 : ASL #4
    ADC.w #(.OAM_groups) : STA.b $08
    
    LDA.w #$0006 : STA.b $06
    
    SEP #$30
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : TAY
    
    ; BUG: Don't have proof yet, but something tells me that if Link's uncle
    ; were ever facing to the right, it would not look correct. These tables
    ; are only 7 elements long and should be 8 elements long...
    LDA.w .source_for_VRAM_1, Y : STA.w $0107
    LDA.w .source_for_VRAM_2, Y : STA.w $0108
    
    JSL.l Sprite_DrawMultiple_quantity_preset
    
    LDA.w $0DE0, X : BEQ .skip_shadow
    CMP.b #$03 : BEQ .skip_shadow
        JSL.l Sprite_DrawShadowLong
    
    .skip_shadow
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D3EB-$06D47A DATA
BugKidNet_Draw_OAM_groups:
{
    dw  4,  0 : db $27, $00, $00, $00
    dw  0, -5 : db $0E, $00, $00, $02
    dw -8,  6 : db $0A, $04, $00, $02
    dw  8,  6 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
    
    dw  0, -5 : db $0E, $00, $00, $02
    dw  0, -5 : db $0E, $00, $00, $02
    dw -8,  6 : db $0A, $04, $00, $02
    dw  8,  6 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
    
    dw  0, -5 : db $2E, $00, $00, $02
    dw  0, -5 : db $2E, $00, $00, $02
    dw -8,  7 : db $0A, $04, $00, $02
    dw  8,  7 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
}

; $06D47B-$06D49E LONG JUMP LOCATION
BugNetKid_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$06 : STA.b $06
                 STZ.b $07
    
    ; Multiples of 0x30.
    LDA.w $0DC0, X : ASL : ADC.w $0DC0, X : ASL #4
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; Deactivates the sprite in certain situations.
; $06D49F-$06D4BB LOCAL JUMP LOCATION
Sprite5_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        LDA.w $0FC1 : BNE .inactive
            LDA.b $11 : BNE .inactive
                LDA.w $0CAA, X : BMI .active
                    LDA.w $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .active
    
    RTS
}

; ==============================================================================

; $06D4BC-$06D56B DATA
Bomber_Draw_OAM_groups:
{
    dw  0, 0 : db $C6, $40, $00, $02
    dw  0, 0 : db $C6, $40, $00, $02
    
    dw  0, 0 : db $C4, $40, $00, $02
    dw  0, 0 : db $C4, $40, $00, $02
    
    dw  0, 0 : db $C6, $00, $00, $02
    dw  0, 0 : db $C6, $00, $00, $02
    
    dw  0, 0 : db $C4, $00, $00, $02
    dw  0, 0 : db $C4, $00, $00, $02
    
    dw -8, 0 : db $C0, $00, $00, $02
    dw  8, 0 : db $C0, $40, $00, $02
    
    dw -8, 0 : db $C2, $00, $00, $02
    dw  8, 0 : db $C2, $40, $00, $02
    
    dw -8, 0 : db $E0, $00, $00, $02
    dw  8, 0 : db $E0, $40, $00, $02
    
    dw -8, 0 : db $E2, $00, $00, $02
    dw  8, 0 : db $E2, $40, $00, $02
    
    dw -8, 0 : db $E4, $00, $00, $02
    dw  8, 0 : db $E4, $40, $00, $02
    
    dw  0, 0 : db $E6, $40, $00, $02
    dw  0, 0 : db $E6, $40, $00, $02
    
    dw  0, 0 : db $E6, $00, $00, $02
    dw  0, 0 : db $E6, $00, $00, $02
}

; $06D56C-$06D58D LONG JUMP LOCATION
Bomber_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #4 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02
    JSL.l Sprite_DrawMultiple
    
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D58E-$06D605 DATA
BomberPellet_DrawExplosion_OAM_groups:
{
    dw -11,   0 : db $9B, $01, $00, $00
    dw   0,  -8 : db $9B, $C1, $00, $00
    dw   6,   6 : db $9B, $41, $00, $00
    
    dw -15,  -6 : db $8A, $01, $00, $02
    dw  -4, -14 : db $8A, $01, $00, $02
    dw   2,   0 : db $8A, $01, $00, $02
    
    dw -15,  -6 : db $86, $01, $00, $02
    dw  -4, -14 : db $86, $01, $00, $02
    dw   2,   0 : db $86, $01, $00, $02
    
    dw  -4,  -4 : db $86, $01, $00, $02
    dw  -4,  -4 : db $86, $01, $00, $02
    dw  -4,  -4 : db $86, $01, $00, $02
    
    dw  -4,  -4 : db $AA, $01, $00, $02
    dw  -4,  -4 : db $AA, $01, $00, $02
    dw  -4,  -4 : db $AA, $01, $00, $02
   }

; $06D606-$06D630 LONG JUMP LOCATION
BomberPellet_DrawExplosion:
{
    PHB : PHK : PLB
    
    LDA.w $0DF0, X : BNE .still_exploding
        STZ.w $0DD0, X
    
    .still_exploding
    
    ; Multiply by 24 and add 0xD58E...
    LSR : LSR : PHA
    LDA.b #$00 : XBA
    PLA
    
    REP #$20
    
    ASL #3                                 : STA.b $00
    ASL : ADC.b $00 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03
    JSL.l Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D631-$06D6A5 LONG JUMP LOCATION
GoodBee_AttackOtherSprite:
{
    ; Good bee can't attack any bosses except mothula, apparently.
    LDA.w $0E20, Y : CMP.b #$88 : BEQ .is_mothula
        LDA.w $0B6B, Y : AND.b #$02 : BNE .is_a_boss
            .is_mothula
            
            LDA.w $0D10, Y : STA.b $00
            LDA.w $0D30, Y : STA.b $01
            
            LDA.w $0D00, Y : STA.b $02
            LDA.w $0D20, Y : STA.b $03
            
            REP #$20
            
            LDA.w $0FD8 : SEC : SBC.b $00 : CLC : ADC.w #$0010
            CMP.w #$0018 : BCS .sprite_not_close
                LDA.w $0FDA : SEC : SBC.b $02 : CLC : ADC.w #$FFF8
                CMP.w #$0018 : BCS .sprite_not_close
                    SEP #$20
                    
                    LDA.w $0E20, Y : CMP.b #$75 : BNE .not_bottle_vendor
                        TXA : INC : STA.w $0E90, Y
                        
                        RTL
                    
                    .not_bottle_vendor
                    
                    ; Damage class of the attack is same as that of the level
                    ; 1 sword.
                    LDA.b #$01
                    
                    PHY : PHX
                    
                    TYX
                    JSL.l Ancilla_CheckSpriteDamage_preset_class
                    
                    PLX : PLY
                    
                    LDA.b #$0F : STA.w $0EA0, Y
                    
                    LDA.w $0D50, X : ASL : STA.w $0F40, Y
                    
                    LDA.w $0D40, X : ASL : STA.w $0F30, Y
                    
                    INC.w $0DA0, X
            
            .sprite_not_close
    .is_a_boss
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $06D6A6-$06D6E5 DATA
Pool_Pikit_Draw_OAM_groups:
{
    dw  0, 0 : db $C8, $00, $00, $02
    dw  0, 0 : db $C8, $00, $00, $02
    
    dw  0, 0 : db $CA, $00, $00, $02
    dw  0, 0 : db $CA, $00, $00, $02
    
    dw -8, 0 : db $CC, $00, $00, $02
    dw  8, 0 : db $CC, $40, $00, $02
    
    dw -8, 0 : db $CE, $00, $00, $02
    dw  8, 0 : db $CE, $40, $00, $02
}

; $06D6E6-$06D738 LONG JUMP LOCATION
Pikit_Draw:
{
    PHB : PHK : PLB
    
    JSR.w Pikit_DrawTongue
    
    LDY.b #$00
    LDA.b ($90), Y : STA.w $0FB5
    
    INY
    LDA.b ($90), Y : STA.w $0FB6
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #4 : ADC.w #(.OAM_groups) : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0018 : STA.b $90
    LDA.b $92 : CLC : ADC.w #$0006 : STA.b $92
    
    SEP #$20
    
    LDA.b #$02
    JSL.l Sprite_DrawMultiple
    
    LDA.w $0E40, X   : PHA
    SEC : SBC.b #$06 : STA.w $0E40, X
    
    JSL.l Sprite_DrawShadowLong
    
    PLA : STA.w $0E40, X
    
    JSR.w Pikit_DrawGrabbedItem
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D739-$06D739 BRANCH LOCATION
Pikit_DrawTongue_easy_out:
{
    RTS
}
    
; $06D73A-$06D749
Pool_Pikit_DrawTongue:
{
    ; $06D73A
    .chr
    db $EE, $FD, $ED, $FD, $EE, $FD, $ED, $FD
    
    ; $06D742
    .vh_flip
    db $00, $00, $00, $40, $40, $C0, $80, $80
}

; ==============================================================================

; $06D74A-$06D812 LOCAL JUMP LOCATION
Pikit_DrawTongue:
{
    LDA.w $0D80, X : CMP.b #$02 : BNE .easy_out
        LDA.w $0F00, X : BNE .easy_out
            LDA.b $00 : CLC : ADC.b #$04 : STA.b $00
            
            LDY.b #$14                        : STA.b ($90), Y
            CLC : ADC.w $0D90, X : LDY.b #$00 : STA.b ($90), Y
            
            LDA.b $02 : CLC : ADC.b #$03 : STA.b $02
            
                                   LDY.b #$15 : STA.b ($90), Y
            CLC : ADC.w $0DA0, X : LDY.b #$01 : STA.b ($90), Y
            LDA.b #$FE           : LDY.b #$16 : STA.b ($90), Y
                                   LDY.b #$02 : STA.b ($90), Y
            LDA.b $05            : LDY.b #$17 : STA.b ($90), Y
                                   LDY.b #$03 : STA.b ($90), Y
            
            LDA.w $0DE0, X : STA.b $0B
            
            LDA.w $0D90, X : STA.b $0E : BPL .BRANCH_ALPHA
                EOR.b #$FF : INC
            
            .BRANCH_ALPHA
            
            STA.b $0C
            
            LDA.w $0DA0, X : STA.b $0F : BPL .BRANCH_BETA
                EOR.b #$FF : INC
            
            .BRANCH_BETA
            
            STA.b $0D
            
            LDY.b #$04
            
            PHX
            
            LDX.b #$03
            
            .next_subsprite
            
                LDA.b $0C             : STA.w SNES.MultiplicandA
                LDA.w .multipliers, X : STA.w SNES.MultiplierB
                
                ; Burn a few cycles...
                JSR.w Pikit_MultiplicationDelay
                
                ; OPTIMIZE: Useless codes?
                LDA.b $0E : ASL
                
                LDA.w SNES.RemainderResultHigh : BCC .BRANCH_GAMMA
                    EOR.b #$FF : INC
                
                .BRANCH_GAMMA
                
                CLC : ADC.b $00 : STA.b ($90), Y
                
                LDA.b $0D             : STA.w SNES.MultiplicandA
                LDA.w .multipliers, X : STA.w SNES.MultiplierB
                
                JSR.w Pikit_MultiplicationDelay
                
                LDA.b $0F : ASL : LDA.w SNES.RemainderResultHigh : BCC .BRANCH_DELTA
                    EOR.b #$FF : INC
                
                .BRANCH_DELTA
                
                CLC : ADC.b $02
                
                INY
                STA.b ($90), Y
                
                PHX
                
                LDX.b $0B
                LDA.w Pool_Pikit_DrawTongue_chr, X : INY : STA.b ($90), Y
                
                INY
                LDA.w Pool_Pikit_DrawTongue_vh_flip, X : ORA.b $05 : STA.b ($90), Y
                
                PLX
                
                INY
            DEX : BPL .next_subsprite
            
            PLX
            
            LDY.b #$00
            LDA.b #$05
            JSL.l Sprite_CorrectOamEntriesLong
            
            RTS
    
    ; Multiples of 51.... okay then... 51 = 1/5 of 255, mind you.
    ; Don't yet know the significance, however.
    .multipliers
    db $33, $66, $99, $CC        
}

; ==============================================================================

; $06D813-$06D816 LOCAL JUMP LOCATION
Pikit_MultiplicationDelay:
{
    ; Delay for multiplication.
    NOP #3
    
    RTS
} 

; ==============================================================================

; $06D817-$06D857 DATA
Pool_Pikit_DrawGrabbedItem:
{
    ; $06D817
    .x_offsets
    db -4,  4, -4,  4,  0,  8,  0,  8
    db  0,  8,  0,  8,  0,  8,  0,  8
    db -4,  4, -4,  4
    
    ; $06D82B
    .y_offsets
    db -4, -4,  4,  4, -4, -4,  4,  4
    db -4, -4,  4,  4, -4, -4,  4,  4
    db -4, -4,  4,  4    
    
    ; $06D83F
    .chr
    db $6E, $6F, $7E, $7F, $63, $7C, $73, $7C
    db $0B, $7C, $1B, $7C, $EC, $F9, $FC, $F9
    db $EA, $EB, $FA, $FB
    
    ; $06D853
    .properties
    db $24, $24, $28, $29, $2F
}

; $06D858-$06D8AE LOCAL JUMP LOCATION
Pikit_DrawGrabbedItem:
{
    LDA.w $0ED0, X : BEQ .return
        DEC : CMP.b #$03 : BNE .not_shield
            ; Indicates the shield level, which should be 1 or 2, resulting in
            ; a final value here of 3 or 4.
            LDA.w $0E30, X : CLC : ADC.b #$02
        
        .not_shield
        
        STA.b $02
        
        LDA.b #$10
        JSL.l OAM_AllocateFromRegionC
        
        LDY.b #$00
        
        PHX
        
        LDX.b #$03
        
        .next_subsprite
        
            STX.b $03
            
            LDA.b $02 : ASL : ASL : ORA.b $03 : TAX
            LDA.w $0FB5 : CLC : ADC Pool_Pikit_DrawGrabbedItem_x_offsets, X       : STA.b ($90), Y
            LDA.w $0FB6 : CLC : ADC Pool_Pikit_DrawGrabbedItem_y_offsets, X : INY : STA.b ($90), Y
            LDA.w Pool_Pikit_DrawGrabbedItem_chr, X                         : INY : STA.b ($90), Y
            LDX.b $02 : LDA.w Pool_Pikit_DrawGrabbedItem_properties, X      : INY : STA.b ($90), Y
            
            INY
        LDX.b $03 : DEX : BPL .next_subsprite
        
        PLX
        
        LDY.b #$00
        LDA.b #$03
        JSL.l Sprite_CorrectOamEntriesLong
    
    .return
    
    RTS
}

; ==============================================================================

; $06D8AF-$06D98E DATA
Pool_Kholdstare_Draw:
{
    ; $06D8AF
    .OAM_groups
    dw -8, -8 : db $80, $00, $00, $02
    dw  8, -8 : db $82, $00, $00, $02
    dw -8,  8 : db $A0, $00, $00, $02
    dw  8,  8 : db $A2, $00, $00, $02
    
    dw -7, -7 : db $80, $00, $00, $02
    dw  7, -7 : db $82, $00, $00, $02
    dw -7,  7 : db $A0, $00, $00, $02
    dw  7,  7 : db $A2, $00, $00, $02
    
    dw -7, -7 : db $84, $00, $00, $02
    dw  7, -7 : db $86, $00, $00, $02
    dw -7,  7 : db $A4, $00, $00, $02
    dw  7,  7 : db $A6, $00, $00, $02
    
    dw -8, -8 : db $84, $00, $00, $02
    dw  8, -8 : db $86, $00, $00, $02
    dw -8,  8 : db $A4, $00, $00, $02
    dw  8,  8 : db $A6, $00, $00, $02
    
    ; $06D92F
    .x_offsets
    dw  8,  7,  4,  2,  0, -2, -4, -7
    dw -8, -7, -4, -2,  0,  2,  4,  7
    
    ; $06D94F
    .y_offsets
    dw  0,  2,  4,  7,  8,  7,  4,  2
    dw  0, -2, -4, -7, -8, -7, -4, -2
    
    ; $06D96F
    .chr
    db $AC, $AC, $AA, $8C, $8C, $8C, $AA, $AC
    db $AC, $AA, $AA, $8C, $8C, $8C, $AA, $AC
    
    ; $06D97F
    .vh_flip
    db $40, $40, $40, $00, $00, $00, $00, $00
    db $80, $80, $80, $80, $80, $80, $C0, $C0
}

; $06D98F-$06DA05 LONG JUMP LOCATION
Kholdstare_Draw:
{
    PHB : PHK : PLB
    
    JSL.l Sprite_PrepOamCoordLong : BCS .offscreen
        PHX
        
        LDA.w $0D90, X : PHA : ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_Kholdstare_Draw_x_offsets, X : STA.b ($90), Y
        AND.w #$0100                                            : STA.b $0E
        
        LDA.b $02 : CLC : ADC Pool_Kholdstare_Draw_y_offsets, X
        INY : STA.b ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA.b ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA.w Pool_Kholdstare_Draw_chr, X                 : INY : STA.b ($90), Y
        LDA.w Pool_Kholdstare_Draw_vh_flip, X : ORA.b $05 : INY : STA.b ($90), Y
        
        TYA : LSR : LSR : TAY
        LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
        
        PLX
        
        LDA.b #$00 : XBA
        LDA.w $0DC0, X

        REP #$20
        
        ASL #5 : ADC.w #(Pool_Kholdstare_Draw_OAM_groups) : STA.b $08
        
        LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
        
        INC.b $92
        
        SEP #$20
        
        LDA.b #$04
        JSL.l Sprite_DrawMultiple
    
    .offscreen
    
    PLB
    
    RTL
}

; ==============================================================================

; $06DA06-$06DA78 LONG JUMP LOCATION
Sprite_SpawnFireball:
{
    PHB : PHK : PLB
    
    LDA.b #$19
    JSL.l Sound_SetSFX3PanLong
    
    LDY.b #$0D
    LDA.b #$55
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01       : ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$04 : PHP : SEC : SBC.b $04  : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00 : PLP       : ADC.b #$00 : STA.w $0D20, Y
        
        LDA.w $0E60, Y : AND.b #$FE : ORA.b #$40 : STA.w $0E60, Y
        
        LDA.b #$06 : STA.w $0F50, Y
        
        LDA.b #$54 : STA.w $0F60, Y
                     STA.w $0E90, Y
        
        LDA.b #$20 : STA.w $0E40, Y
        
        PHX : TYX
        
        LDA.b #$20
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$14 : STA.w $0DF0, X
        
        LDA.b #$10 : STA.w $0E00, X
        
        STZ.w $0BE0, X
        
        LDA.b #$48 : STA.w $0CAA, X
        
        TXY
        
        PLX
    
    .spawn_failed
    
    PLB
    
    TYA
    
    RTL
}

; ==============================================================================

; $06DA79-$06DAC3 DATA
Pool_ArcheryGameGuy_Draw:
{
    ; $06DA79
    .x_offsets
    db $00, $00, $00
    db $00, $00, $FB
    db $00, $FF, $FF
    db $00, $00, $00
    db $00, $01, $01
    
    ; $06DA88
    .y_offsets
    db $00, $F6, $F6
    db $00, $F6, $FD
    db $00, $F6, $F6
    db $00, $F6, $F6
    db $00, $F6, $F6
    
    ; $06DA97
    .chr
    db $26, $06, $06
    db $08, $06, $3A
    db $26, $06, $06
    db $26, $06, $06
    db $26, $06, $06
    
    ; $06DAA6
    .properties
    db $08, $06, $06
    db $08, $06, $08
    db $08, $06, $06
    db $08, $06, $06
    db $08, $06, $06
    
    ; $06DAB5
    .size_bits
    db $02, $02, $02
    db $02, $02, $00
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
}

; $06DAC4-$06DB16 LONG JUMP LOCATION
ArcheryGameGuy_Draw:
{
    PHB : PHK : PLB
    
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    JSL.l Sprite_PrepOamCoordLong
    
    LDA.w $0DC0, X : ASL : ADC.w $0DC0, X : STA.b $06
    
    PHX
    
    LDX.b #$02
    
    .next_subsprite
    
        PHX : TXA : CLC : ADC.b $06 : TAX
        LDA.b $00 : CLC : ADC Pool_ArcheryGameGuy_Draw_x_offsets, X : STA.b ($90), Y
        LDA.b $02 : CLC : ADC Pool_ArcheryGameGuy_y_offsets, X      : INY : STA.b ($90), Y
        LDA.w Pool_ArcheryGameGuy_chr, X                            : INY : STA.b ($90), Y
        LDA.b $05       : ORA Pool_ArcheryGameGuy_properties, X     : INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.w Pool_ArcheryGameGuy_size_bits, X : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06DB17-$06DB3F NULL
NULL_0DDB17:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF
}

; ==============================================================================
; Start of Heads Up Display:
; ==============================================================================

; $06DB40-$06DB74 DATA
HUD_CapacityUpgrades:
{
    ; $06DB40
    .bombs_bcd
    db $10, $15, $20, $25, $30, $35, $40, $50

    ; $06DB48
    .bombs_hex
    db  10,  15,  20,  25,  30,  35,  40,  50

    ; $06DB50
    .arrows_bcd
    db $30, $35, $40, $45, $50, $55, $60, $70

    ; $06DB58
    .arrows_hex
    db  30,  35,  40,  45,  50,  55,  60,  70
}

; $06DB60-$06DB74 DATA
HeartBeepThresholds:
{
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $11, $11, $11, $11, $11, $11, $11, $19
    db $19, $19, $19, $19, $19
}

; ==============================================================================
    
; $06DB75-$06DB7E LONG JUMP LOCATION
HUD_RefillLogicLong:
{
    PHB : PHK : PLB

    LDA.w $0200 : BEQ HUD_RefillLogic
        PLB

        RTL
}
    
; ==============================================================================

; Similar to RebuildLong but it checks to see if our equipped item has changed
; state first.
; $06DB7F-$06DB91 LONG JUMP LOCATION
HUD_RefreshIconLong:
{
    PHB : PHK : PLB

    JSR.w SearchForEquippedItem
    JSR.w Equipment_UpdateHUD
    JSR.w Rebuild

    SEP #$30

    STZ.w $0200

    PLB

    RTL
}

; ==============================================================================

; $06DB92-$06DD29 BRANCH LOCATION
HUD_RefillLogic:
{
    ; Check the refill magic indicator.
    LDA.l $7EF373 :  BEQ .doneWithMagicRefill
        ; Check the current magic power level we have.
        ; Is it full?
        LDA.l $7EF36E : CMP.b #$80 : BCC .magicNotFull
            ; If it is full, freeze it at 128 magic pts.
            ; And stop this refilling nonsense.
            LDA.b #$80 : STA.l $7EF36E
            LDA.b #$00 : STA.l $7EF373
            
            BRA .doneWithMagicRefill
        
        .magicNotFull
        
        LDA.l $7EF373 : DEC : STA.l $7EF373
        LDA.l $7EF36E : INC : STA.l $7EF36E
        
        ; If((frame_counter % 4) != 0) don't refill this frame.
        LDA.b $1A : AND.b #$03 : BNE .doneWithMagicRefill
            ; Is this sound channel in use?
            LDA.w $012E : BNE .doneWithMagicRefill
                ; Play the magic refill sound effect.
                LDA.b #$2D : STA.w $012E
    
    .doneWithMagicRefill
    
    REP #$30
    
    ; Check current rupees (362) against goal rupees (360) goal refers to how
    ; many we really have and current refers to the number currently being
    ; displayed. When you buy something, goal rupees are decreased by, say,
    ; 100, but it takes a while for the current rupees indicator to catch up.
    ; When you get a gift of 300 rupees, the goal increases, and current has to
    ; catch up in the other direction.
    LDA.l $7EF362 : CMP.l $7EF360 : BEQ .doneWithRupeesRefill
        BMI .addRupees
            DEC : BPL .subtractRupees
                LDA.w #$0000 : STA.l $7EF360
                
                BRA .subtractRupees
        
        .addRupees
        
        ; If current rupees <= 1000 (decimal).
        INC : CMP.w #1000 : BCC .subtractRupees
            ; Otherwise just store 999 to the rupee amount.
            LDA.w #999 : STA.l $7EF360
        
        .subtractRupees
        
        STA.l $7EF362
        
        SEP #$30
        
        LDA.w $012E : BNE .doneWithRupeesRefill
            ; Looks like a delay counter of some sort between invocations of
            ; the rupee fill sound effect.
            LDA.w $0CFD : INC.w $0CFD : AND.b #$07 : BNE .skipRupeeSound
                LDA.b #$29 : STA.w $012E
                
                BRA .skipRupeeSound
        
    .doneWithRupeesRefill
    
    SEP #$30
    
    STZ.w $0CFD
    
    .skipRupeeSound
    
    LDA.l $7EF375 : BEQ .doneRefillingBombs
        ; Decrease the bomb refill counter.
        LDA.l $7EF375 : DEC : STA.l $7EF375

        ; Use the bomb upgrade index to know what max number of bombs Link can
        ; carry is.
        LDA.l $7EF370 : TAY

        ; If it matches the max, you can't have any more bombs.
        LDA.l $7EF343 : CMP.w HUD_CapacityUpgrades_bombs_hex, Y : BEQ .doneRefillingBombs
            ; You like bombs? I got lotsa bombs!
            INC : STA.l $7EF343

    .doneRefillingBombs

    ; Check arrow refill counter
    LDA.l $7EF376 : BEQ .doneRefillingArrows
        LDA.l $7EF376 : DEC : STA.l $7EF376
        
        ; Check arrow upgrade index to see how our max limit on arrows, just
        ; like bombs.
        LDA.l $7EF371 : TAY 
        
        ; I reckon you get no more arrows, pardner.
        LDA.l $7EF377 : CMP.w HUD_CapacityUpgrades_arrows_hex, Y : BEQ .arrowsAtMax
            INC : STA.l $7EF377

        .arrowsAtMax

        ; See if we even have the bow.
        LDA.l $7EF340 : BEQ .doneRefillingArrows
            AND.b #$01 : CMP.b #$01 : BNE .doneRefillingArrows
                ; Changes the icon from a bow without arrows to a bow with
                ; arrows.
                LDA.l $7EF340 : INC : STA.l $7EF340
                
                JSL.l RefreshIconLong

    .doneRefillingArrows

    ; A frozen Link is an impervious Link, so don't beep.
    LDA.w $02E4 : BNE .doneWithWarningBeep
        ; If heart refill is in process, we don't beep.
        LDA.l $7EF372 : BNE .doneWithWarningBeep
            ; Checking current health against capacity health to see
            ; if we need to put on that annoying beeping noise.
            LDA.l $7EF36C : LSR #3 : TAX
            LDA.l $7EF36D : CMP.w HeartBeepThresholds, X : BCS .doneWithWarningBeep
                LDA.w $04CA : BNE .decrementBeepTimer
                    ; Beep incessantly when life is low.
                    LDA.w $012E : BNE .doneWithWarningBeep
                        LDA.b #$20 : STA.w $04CA
                        LDA.b #$2B : STA.w $012E
                
                .decrementBeepTimer
                
                ; Timer for the low life beep sound.
                DEC.w $04CA

    .doneWithWarningBeep

    ; If nonzero, indicates that a heart is being "flipped" over
    ; as in, filling up, currently.
    LDA.w $020A : BNE .waitForHeartFillAnimation
        ; If no hearts need to be filled, branch.
        LDA.l $7EF372 : BEQ .doneRefillingHearts
            ; Check if actual health matches capacity health.
            LDA.l $7EF36D : CMP.l $7EF36C : BCC .notAtFullHealth
                ; Just set health to full in the event it overflowed past 0xA0
                ; (20 hearts).
                LDA.l $7EF36C : STA.l $7EF36D
                
                ; Done refilling health so deactivate the health refill
                ; variable.
                LDA.b #$00 : STA.l $7EF372
                
                BRA .doneRefillingHearts

            .notAtFullHealth

            ; Refill health by one heart
            LDA.l $7EF36D : CLC : ADC.b #$08 : STA.l $7EF36D
            
            LDA.w $012F : BNE .soundChannelInUse
                ; Play heart refill sound effect
                LDA.b #$0D : STA.w $012F

            .soundChannelInUse

            ; Repeat the same logic from earlier, checking if health's at max
            ; and setting it to max if it overflowed.
            LDA.l $7EF36D : CMP.l $7EF36C : BCC .healthDidntOverflow
                LDA.l $7EF36C : STA.l $7EF36D

            .healthDidntOverflow

            ; Subtract a heart from the refill variable.
            LDA.l $7EF372 : SEC : SBC.b #$08 : STA.l $7EF372
            
            ; Activate heart refill animation (which will cause a small delay\
            ; for the next heart if we still need to fill some up).
            INC.w $020A
            
            LDA.b #$07 : STA.w $0208

    .waitForHeartFillAnimation
    
    REP #$30
    
    LDA.w #$FFFF : STA.b $0E
    
    JSR.w Update_ignoreHealth
    JSR.w AnimateHeartRefill
    
    SEP #$30
    
    INC.b $16
    
    PLB
    
    RTL

    .doneRefillingHearts

    REP #$30
    
    LDA.w #$FFFF : STA.b $0E
    
    JSR.w Update_ignoreItemBox
    
    SEP #$30
    
    INC.b $16
    
    PLB
    
    RTL
} 

; ==============================================================================
; Start of Equpiment:
; ==============================================================================

; Module E submodule 1 - Item submenu
; $06DD2A-$06DD31 JUMP LOCATION
Messaging_Equipment:
{
    PHB : PHK : PLB
    
    JSR.w Equipment_Local
    
    PLB
    
    RTL
}

; ==============================================================================

; $06DD32-$06DD35 LONG JUMP LOCATION
Equipment_UpdateEquippedItemLong:
{
    JSR.w UpdateHUD_updateEquippedItem
    
    RTL
}

; ==============================================================================
    
; Appears to be a simple debug frame counter (8-bit) for this submodule
; of course, it loops back every 256 frames.
; $06DD36-$06DD59 LOCAL JUMP LOCATION
Equipment_Local:
{
    INC.w $0206
    LDA.w $0200
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ClearTilemap       ; 0x00 - $DD5A
    dw Init               ; 0x01 - $DDAB
    dw BringMenuDown      ; 0x02 - $DE59
    dw ChooseNextMode     ; 0x03 - $DE6E
    dw NormalMenu         ; 0x04 - $DF15
    dw UpdateHUD          ; 0x05 - $DFA9
    dw CloseMenu          ; 0x06 - $DFBA
    dw GotoBottleMenu     ; 0x07 - $DFFB
    dw InitBottleMenu     ; 0x08 - $E002
    dw ExpandBottleMenu   ; 0x09 - $E08C
    dw BottleMenu         ; 0x0A - $E0DF
    dw EraseBottleMenu    ; 0x0B - $E2FD
    dw RestoreNormalMenu  ; 0x0C - $E346
}

; ==============================================================================

; This routine sets up a DMA transfer from $7E1000 to $6800 (word address) in
; VRAM basically clears out. Also plays the menu coming down sound, then moves
; to the next step.
; $06DD5A-$06DDAA JUMP LOCATION
Equipment_ClearTilemap:
{
    REP #$20
    
    LDX.b #$00
    
    ; Value of a transparent tile.
    LDA.b #$207F
    
    .clearVramBuffer
    
        STA.w $1000, X : STA.w $1080, X
        STA.w $1100, X : STA.w $1180, X
        STA.w $1200, X : STA.w $1280, X
        STA.w $1300, X : STA.w $1380, X
        STA.w $1400, X : STA.w $1480, X
        STA.w $1500, X : STA.w $1580, X
        STA.w $1600, X : STA.w $1680, X
        STA.w $1700, X : STA.w $1780, X
        
        INX : INX : CPX.b #$80
    BNE .clearVramBuffer
    
    SEP #$20
    
    ; Play sound effect for opening item menu.
    LDA.b #$11 : STA.w $012F

    ; Tell NMI to update tilemap.
    LDA.b #$01 : STA.b $17
    
    ; The region of tilemap to update is word address $6800 (this value 0x22
    ; indexes into a table in NMI).
    LDA.b #$22 : STA.w $0116
    
    ; Move to next step of the submodule.
    INC.w $0200
    
    RTS
}

; ==============================================================================

; Module 0x0E.0x01.0x01
; $06DDAB-$06DE58 JUMP LOCATION
Equipment_Init:
{
    ; Handles which item to equip (if none is equipped).
    JSR.w CheckEquippedItem
    
    LDA.b #$01
    JSR.w GetPaletteMask ; $00[2] = 0xFFFF

    JSR.w DrawYButtonItems
    
    LDA.b #$01
    JSR.w GetPaletteMask

    ; Construct a portion of the menu.
    JSR.w DrawSelectedItemBox
    
    LDA.b #$01
    JSR.w GetPaletteMask

    JSR.w DrawAbilityText 
    JSR.w DrawAbilityIcons 
    JSR.w DrawProgressIcons
    JSR.w DrawMoonPearl
    JSR.w UnfinishedRoutine
    
    LDA.b #$01
    JSR.w GetPaletteMask

    JSR.w DrawEquipment
    JSR.w DrawShield
    JSR.w DrawArmor
    JSR.w DrawMapAndBigKey
    JSR.w DrawCompass
    
    LDX.b #$12
    
    LDA.l $7EF340
    
    ; Check if we have any equippable items available.
    .itemCheck
    
        ORA.l $7EF341, X : DEX
    BPL .itemCheck
    
    CMP.b #$00 : BEQ .noEquipableItems
        LDA.l $7EF35C
        ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F : BNE .haveBottleItems
            BRA .haveNoBottles
        
        .haveBottleItems
        
        ; There is a difference between having bottled items and having
        ; at least one bottle to put them in. $7EF34F acts as a flag for that.
        LDA.l $7EF34F : BNE .hasBottleFlag
            TAY
            
            INY
            LDA.l $7EF35C : BNE .selectThisBottle
                INY
                LDA.l $7EF35D : BNE .selectThisBottle
                    INY
                    LDA.l $7EF35E : BNE .selectThisBottle
                        INY
                
            .selectThisBottle
            
            TYA
            
            .haveNoBottles
            
            STA.l $7EF34F
        
        .hasBottleFlag
        
        JSR.w DoWeHaveThisItem : BCS .weHaveIt
            JSR.w TryEquipNextItem
        
        .weHaveIt
        
        JSR.w DrawSelectedYButtonItem
        
        ; Does the player have a bottle equipped currently? Initial draw.
        LDA.w $0202 : CMP.b #$10 : BNE .equippedItemIsntBottle
            LDA.b #$01
            JSR.w GetPaletteMask

            JSR.w DrawBottleMenu
            
        .equippedItemIsntBottle
    .noEquipableItems
    
    ; Start a timer.
    LDA.b #$10 : STA.w $0207
    
    ; Make NMI update BG3 tilemap.
    LDA.b #$01 : STA.b $17
    
    ; Update VRAM address $6800 (word).
    LDA.b #$22 : STA.w $0116
    
    ; Move on to next step of the submodule.
    INC.w $0200
    
    RTS
}

; ==============================================================================

; $06DE59-$06DE6D JUMP LOCATION
Equipment_BringMenuDown:
{
    REP #$20
    
    LDA.b $EA : SEC : SBC.w #$0008 : STA.b $EA
    CMP.w #$FF18
    
    SEP #$20
    
    BNE .notDoneScrolling 
        INC.w $0200
    
    .notDoneScrolling
    
    RTS
}
    
; ==============================================================================

; Makes a determination whether to go to the normal menu handling mode or the
; bottle submenu handling mode. There's also mode 0x05... which appears to be
; hidden at this point.
; $06DE6E-$06DEAF JUMP LOCATION
Equipment_ChooseNextMode:
{
    LDX.b #$12
    LDA.l $7EF340
    
    .haveAnyEquippable

        ; Loop.
        ORA.l $7EF341, X
    DEX : BPL .haveAnyEquippable

    CMP.b #$00 : BEQ .haveNone
        ; Tell NMI to update BG3 tilemap next from by writing to address $6800
        ; (word) in VRAM.
        LDA.b #$01 : STA.b $17
        LDA.b #$22 : STA.w $0116
        
        JSR.w DoWeHaveThisItem : BCS .weHaveIt
            JSR.w TryEquipNextItem
        
        .weHaveIt
        
        JSR.w DrawSelectedYButtonItem
        
        ; Move to the next step of the submodule.
        LDA.b #$04 : STA.w $0200
        
        LDA.w $0202 : CMP.b #$10 : BNE .notOnBottleMenu
            ; Switch to the step of this submodule that handles when the
            ; bottle submenu is up.
            LDA.b #$0A : STA.w $0200
        
        .notOnBottleMenu
        
        RTS
    
    .haveNone
    
    ; BYSTudlr
    LDA.b $F4 : BEQ .noButtonPress
        LDA.b #$05 : STA.w $0200
        
        RTS
    
    .noButtonPress
    
    RTS
}

; ==============================================================================

; $06DEB0-$06DEBC LOCAL JUMP LOCATION
Equipment_DoWeHaveThisItem:
{
    LDX.w $0202
    
    ; Check to see if we have this item:
    LDA.l $7EF33F, X : BNE .haveThisItem
        CLC
        
        RTS
    
    .haveThisItem
    
    SEC
    
    RTS
}

; ==============================================================================
    
; $06DEBD-$06DECA LOCAL JUMP LOCATION
Equipment_GoToPrevItem:
{
    LDA.w $0202 : DEC : CMP.b #$01 : BCS .dontReset
        LDA.b #$14
    
    .dontReset
    
    STA.w $0202
    
    RTS
} 

; ==============================================================================
    
; $06DECB-$06DED8 LOCAL JUMP LOCATION
Equipment_GotoNextItem:
{
    ; Load our currently equipped item, and move to the next one If we reach
    ; our limit (21), set it back to the bow and arrow slot.
    LDA.w $0202 : INC : CMP.b #$15 : BCC .dontReset
        LDA.b #$01
    
    .dontReset
    
    ; Otherwise try to equip the item in the next slot.
    STA.w $0202
    
    RTS
}

; ==============================================================================
    
; $06DED9-$06DEE1 LOCAL JUMP LOCATION
Equipment_TryEquipPrevItem:
{
    .keepLooking
    
        JSR.w GoToPrevItem
    JSR.w DoWeHaveThisItem : BCC .keepLooking
    
    RTS
} 

; ==============================================================================
    
; $06DEE2-$06DEEA JUMP LOCATION
Equipment_TryEquipNextItem:
{
    .keepLooking
    
        JSR.w GoToNextItem
    JSR.w DoWeHaveThisItem : BCC .keepLooking
    
    RTS
}

; ==============================================================================
    
; $06DEEB-$06DEFF LOCAL JUMP LOCATION
Equipment_TryEquipItemAbove:
{
    .keepLooking
    
        JSR.w GoToPrevItem
        JSR.w GoToPrevItem
        JSR.w GoToPrevItem
        JSR.w GoToPrevItem
        JSR.w GoToPrevItem
    JSR.w DoWeHaveThisItem : BCC .keepLooking
    
    RTS
} 

; ==============================================================================

; $06DF00-$06DF14 LOCAL JUMP LOCATION
Equipment_TryEquipItemBelow:
{
    .keepLooking
    
        JSR.w GoToNextItem
        JSR.w GoToNextItem
        JSR.w GoToNextItem
        JSR.w GoToNextItem
        JSR.w GoToNextItem
    JSR.w DoWeHaveThisItem : BCC .keepLooking
    
    RTS
}

; ==============================================================================

; $06DF15-$06DFA8 JUMP LOCATION
Equipment_NormalMenu:
{
    INC.w $0207
    
    ; BYSTudlr
    LDA.b $F0 : BNE .inputReceived
        ; Reset the ability to select a new item.
        STZ.b $BD
    
    .inputReceived
    
    ; Check if the start button was pressed this frame.
    LDA.b $F4 : AND.b #$10 : BEQ .dontLeaveMenu
        ; Bring the menu back up and play the vvvvoooop sound as it comes up.
        LDA.b #$05 : STA.w $0200
        LDA.b #$12 : STA.w $012F
        
        RTS
    
    .dontLeaveMenu
    
    ; After selecting a new item, you have to release all of the BYSTudlr inputs
    ; before you can select a new item. Notice how $BD gets set back low if you
    ; aren't holding any of those buttons.
    LDA.b $BD : BNE .didntChange
        LDA.w $0202 : STA.b $00
        
        ; Joypad 2.... interesting. It's checking the R button.
        LDA.b $F7 : AND.b #$10 : BEQ .dontBeAJerk
            ; Apparently pressing R on Joypad 2 (if it's enabled) deletes your
            ; currently selected item. Imagine playing the game with your friend
            ; constantly trying to delete your items lots of punching would
            ; ensue.
            LDX.w $0202
            LDA.b #$00 : STA.l $7EF33F, X
            
            ; Unlike .movingOut, Anthony's Song.
            BRA .movingOn
        
        .dontBeAJerk
        
        ; BYSTudlr says that we're checking if the up direction is pressed!
        ; RAWWWWWWWRRRHHGHGH! BYSTudrl sounds like a name, like Baiyst Yudler,
        ; a] German superbrute that hacks roms by breaking them in two! And
        ; then he breaks them into many other numbers bigger than two!
        LDA.b $F4 : AND.b #$08 : BEQ .notPressingUp
            JSR.w TryEquipItemAbove
            
            BRA .movingOn
        
        .notPressingUp
        
        ; Don't piss off BYSTudlr - he likes playing Mr. Potato Head. The
        ; problem is he skips the potato part and goes straight for the head.
        ; (In spite of this, I find most of his work quite artistic and
        ; tasteful.)
        LDA.b $F4 : AND.b #$04 : BEQ .notPressingDown
            JSR.w TryEquipItemBelow
            
            BRA .movingOut
        
        .notPressingDown
        
        ; BYSTudlr is not going to pump you up, girly man. His sensibilities
        ; are far more refined than that.
        LDA.b $F4 : AND.b #$02 : BEQ .notPressingLeft
            JSR.w TryEquipPrevItem
            
            BRA .movingOn
        
        .notPressingLeft
        
        ; When BYSTudlr gets really hungry he makes chicken soup. Recipe
        ; (translated from German): Fill bathtub with chicken broth. Put
        ; chickens in tub. Eat.
        LDA.b $F4 : AND.b #$01 : BEQ .notPressingRight
            JSR.w TryEquipNextItem
        
        .notPressingRight
        
        LDA.b $F4 : STA.b $BD
        
        ; Check if the currently equipped item changed.
        LDA.w $0202 : CMP.b $00 : BEQ .didntChange
            ; Reset a timer and play a sound effect.
            LDA.b #$10 : STA.w $0207
            LDA.b #$20 : STA.w $012F
    
    .didntChange
    
    LDA.b #$01
    JSR.w GetPaletteMask

    JSR.w DrawYButtonItems
    JSR.w DrawSelectedYButtonItem
    
    ; Check if we ended up selecting a bottle this frame.
    LDA.w $0202 : CMP.b #$10 : BNE .didntSelectBottle
        ; Switch to the bottle submenu handler.
        LDA.b #$07 : STA.w $0200
    
    .didntSelectBottle
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06DFA9-$06DFB9 LOCAL JUMP LOCATION
Equipment_UpdateHUD:
{
    ; Move on to next step.
    INC.w $0200
    
    JSR.w HUD_Rebuild_updateOnly
    
    ; $06DFAF ALTERNATE ENTRY POINT
    .updateEquippedItem
    
    ; Using the item selected in the item menu, set a value that tells us what
    ; item to use during actual gameplay. (Y button items, btw).
    LDX.w $0202 
    LDA.l MenuID_to_EquipID, X : STA.w $0303
    
    RTS
}

; ==============================================================================

; $06DFBA-$06DFFA JUMP LOCATION
Equipment_CloseMenu:
{
    .scroll_up_additional_8_pixels
    
    REP #$20
    
    ; Scroll the menu back up so it's off screen (8 pixels at a time).
    LDA.b $EA : CLC : ADC.w #$0008 : STA.b $EA

    SEP #$20
    
    BNE .notDoneScrolling
        JSR.w HUD_Rebuild
        
        ; Reset submodule and subsubmodule indices.
        STZ.w $0200
        STZ.b $11
        
        ; Go back to the module we came from.
        LDA.w $010C : STA.b $10
        
        ; Why this is checked, I dunno. notice the huge whopping STZ.b $11 up
        ; above? Yeah, I thought so.
        LDA.b $11 : BEQ .noSpecialSubmode
            ; This seems random and out of place. There's not even a check to
            ; make sure we're indoors. Unless that LDA.b $11 up above was meant
            ; to be LDA.b $1B.
            JSL.l RestoreTorchBackground
        
        .noSpecialSubmode
        
        LDA.w $0303 : CMP.b #$05 : BEQ .fireRod
            CMP.b #$06 : BEQ .iceRod
                LDA.b #$02 : STA.w $034B
                
                STZ.w $020B
                
                BRA .return

            .iceRod
        .fireRod

        ; Okay, so contrary to what I thought this did previously in the
        ; abstract, it actually positions the HUD up by 8 pixels higher than
        ; it would normally be if you select one of the rods and this variable
        ; $020B is also set. That's it.
        LDA.w $020B : BNE .scroll_up_additional_8_pixels
            STZ.w $034B
    
    .notDoneScrolling

    .return
    
    RTS
}

; ==============================================================================

; $06DFFB-$06E001 JUMP LOCATION
Equipment_GotoBottleMenu:
{
    STZ.w $0205
    INC.w $0200
    
    RTS
} 

; ==============================================================================

; $06E002-$06E04F JUMP LOCATION
Equipment_InitBottleMenu:
{
    REP #$30
    
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX
    LDA.w #$207F 
    STA.w $12EA, X : STA.w $12EC, X
    STA.w $12EE, X : STA.w $12F0, X
    STA.w $12F2, X : STA.w $12F4, X
    STA.w $12F6, X : STA.w $12F8, X
    STA.w $12FA, X : STA.w $12FC, X
    
    SEP #$30
    
    INC.w $0205
    LDA.w $0205 : CMP.b #$13 : BNE .notDoneErasing
        INC.w $0200
        
        LDA.b #$11 : STA.w $0205
    
    .notDoneErasing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E050-$06E08B DATA
Pool_BottleMenu_Open:
{
    ; $06E050
    .border_tile_top
    dw $28FB, $28F9, $28F9, $28F9, $28F9
    dw $28F9, $28F9, $28F9, $28F9, $68FB
    
    ; $06E064
    .border_tile_row
    dw $28FC, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $68FC
    
    ; $06E078
    .border_tile_bottom
    dw $A8FB, $A8F9, $A8F9, $A8F9, $A8F9
    dw $A8F9, $A8F9, $A8F9, $A8F9, $E8FB
}

; ==============================================================================

; Each frame of this causes the bottle menu frame to expand upward by by one
; tile.
; $06E08C-$06E0DE JUMP LOCATION
Equipment_ExpandBottleMenu:
{
    REP #$30
    
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX : PHX
    
    LDY.w #$0012
    
    .drawBottleMenuTop
    
        LDA.w Pool_BottleMenu_Open_border_tile_top, Y : STA.w $12FC, X

        DEX : DEX
    DEY : DEY : BPL .drawBottleMenuTop
    
    PLX 
    
    LDY.w #$0012
    
    ; Each subsequent frame, this will overwrite the top of the menu
    ; from the previous frame until fully expanded.
    .eraseOldTop
    
        LDA.w Pool_BottleMenu_Open_border_tile_row, Y : STA.w $133C, X
        
        DEX : DEX
    DEY : DEY : BPL .eraseOldTop
    
    LDX.w #$0012

    ; Probably only really needs to be done during the first frame of this
    ; step of the submodule.
    .drawBottleMenuBottom
    
        LDA.w Pool_BottleMenu_Open_border_tile_bottom, X : STA.w $176A, X
    DEX : DEX : BPL .drawBottleMenuBottom
    
    SEP #$30
    
    DEC.w $0205
    LDA.w $0205 : BPL .notDoneDrawing
        INC.w $0200
    
    .notDoneDrawing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E0DF-$06E176 JUMP LOCATION
Equipment_BottleMenu:
{
    INC.w $0207
    
    ; Check if the start button was pressed this frame.
    LDA.b $F4 : AND.b #$10 : BEQ .dontCloseMenu
        ; Close the item menu and play the vvvoooop sound as it goes up.
        LDA.b #$12 : STA.w $012F
        LDA.b #$05 : STA.w $0200
        
        BRA .lookAtUpDownInput
    
    .dontCloseMenu
    
    LDA.b $F4 : AND.b #$03 : BEQ .noLeftRightInput
        LDA.b $F4 : AND.b #$02 : BEQ .noLeftInput
            JSR.w TryEquipPrevItem
            
            BRA .movingOn
        
        .noLeftInput
        
        LDA.b $F4 : AND.b #$01 : BEQ .noRightInput
            JSR.w TryEquipNextItem
        
        .noRightInput
        .movingOn
        
        ; Play sound effect and start a timer to keep us from switching items
        ; for 16 frames.
        LDA.b #$10 : STA.w $0207
        LDA.b #$20 : STA.w $012F
        
        LDA.b #$01
        JSR.w GetPaletteMask

        JSR.w DrawYButtonItems
        JSR.w DrawSelectedYButtonItem
        
        ; Since left or right was pressed, we're exiting the bottle menu
        ; and going back to the normal menu.
        INC.w $0200
        
        STZ.w $0205
        
        RTS
    
    .noLeftRightInput
    .lookAtUpDownInput
    
    JSR.w UpdateBottleMenu
    
    LDA.b $F4 : AND.b #$0C : BNE .haveUpDownInput 
        ; There's no input, so nothing happens.
        RTS
    
    .haveUpDownInput
    
    LDA.l $7EF34F : DEC : STA.b $00 : STA.b $02
    
    LDA.b $F4 : AND.b #$08 : BEQ .haveUpInput
        .selectPrevBottle
        
            LDA.b $00 : DEC : AND.b #$03 : STA.b $00
                                           TAX
        LDA.l $7EF35C, X : BEQ .selectPrevBottle
        
        BRA .bottleIsSelected
    
    .haveUpInput

    .selectNextBottle
    
        LDA.b $00 : INC : AND.b #$03 : STA.b $00
                                       TAX
    LDA.l $7EF35C, X : BEQ .selectNextBottle
    
    .bottleIsSelected
    
    LDA.b $00 : CMP.b $02 : BEQ .sameBottleWhoCares
        ; Record which bottle was just selected.
        INC : STA.l $7EF34F
        
        ; If it's not the same bottle we play the obligatory item switch sound
        ; effect.
        LDA.b #$10 : STA.w $0207
        LDA.b #$20 : STA.w $012F
        
    .sameBottleWhoCares
    
    RTS
}

; ==============================================================================

; $06E177-$06E17E DATA
BottleMenuCursorPosition:
{
    dw $0088, $0188, $0288, $0388 
}

; ==============================================================================

; $06E17F-$06E2FC LOCAL JUMP LOCATION
Equipment_UpdateBottleMenu:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .erase
    
        STA.w $132C, X : STA.w $136C, X
        STA.w $13AC, X : STA.w $13EC, X
        STA.w $142C, X : STA.w $146C, X
        STA.w $14AC, X : STA.w $14EC, X
        STA.w $152C, X : STA.w $156C, X
        STA.w $15AC, X : STA.w $15EC, X
        STA.w $162C, X : STA.w $166C, X
        STA.w $16AC, X : STA.w $16EC, X
        STA.w $172C, X 
        
        INX : INX
    DEY : BPL .erase
    
    ; Draw the 4 bottle icons (if we don't have that bottle it just draws
    ; blanks).
    LDA.w #$1372 :                 STA.b $00
    LDA.l $7EF35C : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    LDA.w #$1472 :                 STA.b $00
    LDA.l $7EF35D : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    LDA.w #$1572 :                 STA.b $00
    LDA.l $7EF35E : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    LDA.w #$1672 :                 STA.b $00
    LDA.l $7EF35F : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    LDA.w #$1408 : STA.b $00
    
    LDA.l $7EF34F : AND.w #$00FF : TAX : BNE .haveBottleEquipped
        LDA.w #$0000
        
        BRA .drawEquippedBottle
    
    .haveBottleEquipped
    
    LDA.l $7EF35B, X : AND.w #$00FF
    
    .drawEquippedBottle
    
    STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    LDA.w $0202 : AND.w #$00FF : DEC : ASL : TAX
    LDY.w ItemMenu_CursorPositions, X
    LDA.w $0000, Y : STA.w $11B2
    LDA.w $0002, Y : STA.w $11B4
    LDA.w $0040, Y : STA.w $11F2
    LDA.w $0042, Y : STA.w $11F4
    
    LDA.l $7EF34F : DEC : AND.w #$00FF : ASL : TAY
    LDA.w Equipment_BottleMenuCursorPosition, Y : TAY
    
    LDA.w $0207 : AND.w #$0010 : BEQ .return
        LDA.w #$3C61 : STA.w $12AA, Y
        ORA.w #$4000 : STA.w $12AC, Y
        
        LDA.w #$3C70 : STA.w $12E8, Y
        ORA.w #$4000 : STA.w $12EE, Y
        
        LDA.w #$BC70 : STA.w $1328, Y
        ORA.w #$4000 : STA.w $132E, Y
        
        LDA.w #$BC61 : STA.w $136A, Y
        ORA.w #$4000 : STA.w $136C, Y
        
        LDA.w #$3C60 : STA.w $12A8, Y
        ORA.w #$4000 : STA.w $12AE, Y
        ORA.w #$8000 : STA.w $136E, Y
        EOR.w #$4000 : STA.w $1368, Y
        
        LDA.l $7EF34F : AND.w #$00FF : BEQ .noSelectedBottle
            TAX
            LDA.l $7EF35B, X : AND.w #$00FF : DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeBottleDescription
                LDA.w ItemMenuNameText_Bottles_0, X : STA.w $122C, Y
                LDA.w ItemMenuNameText_Bottles_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .writeBottleDescription

        .noSelectedBottle
    
    .return
    
    SEP #$30
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
} 

; ==============================================================================

; $06E2FD-$06E345 JUMP LOCATION
Equipment_EraseBottleMenu:
{
    REP #$30
    
    ; Erase the bottle menu.
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX
    LDA.w #$207F
    STA.w $12EA, X : STA.w $12EC, X
    STA.w $12EE, X : STA.w $12F0, X
    STA.w $12F2, X : STA.w $12F4, X
    STA.w $12F6, X : STA.w $12F8, X
    STA.w $12FA, X : STA.w $12FC, X
    
    SEP #$30
    
    INC.w $0205
    LDA.w $0205 : CMP.b #$13 : BNE .notDoneErasing
        ; Move on to the next step of the submodule.
        INC.w $0200
    
    .notDoneErasing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; Updates just the portions of the screen that the bottle menu screws with.
; $06E346-$06E371 JUMP LOCATION
Equipment_RestoreNormalMenu:
{
    JSR.w DrawProgressIcons
    JSR.w DrawMoonPearl
    JSR.w UnfinishedRoutine
    
    LDA.b #$01
    JSR.w GetPaletteMask

    JSR.w DrawEquipment
    JSR.w DrawShield
    JSR.w DrawArmor
    JSR.w DrawMapAndBigKey
    JSR.w DrawCompass
    
    ; Switch to the normal menu submode.
    LDA.b #$04 : STA.w $0200
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800
    ; (word) in VRAM.
    LDA.b #$01 : STA.b $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E372-$06E394 LOCAL JUMP LOCATION
Equipment_DrawItem:
{
    LDA.b $02 : ASL #3 : TAY
    LDX.b $00
    LDA.b ($04), Y : STA.w $0000, X

    INY : INY
    LDA.b ($04), Y : STA.w $0002, X 

    INY : INY
    LDA.b ($04), Y : STA.w $0040, X 

    INY : INY
    LDA.b ($04), Y : STA.w $0042, X
    
    RTS
} 

; ==============================================================================

; $06E395-$06E398 LONG JUMP LOCATION
; TODO: Unused? Investigate.
Equipment_SearchForEquippedItemLong:
{
    JSR.w SearchForEquippedItem
    
    RTL
}

; ==============================================================================

; $06E399-$06E3C7 LOCAL JUMP LOCATION
Equipment_SearchForEquippedItem:
{
    SEP #$30
    
    LDX.b #$12
    LDA.l $7EF340
    
    ; Go through all our equipable items, hoping to find at least one available.
    .itemCheck

        ; Loop.
        ORA.l $7EF341, X
    DEX : BPL .itemCheck                     
    
    CMP.b #$00 : BNE .equippableItemAvailable
        ; In this case we have no equippable items.
        STZ.w $0202
        STZ.w $0203
        STZ.w $0204
        
        .weHaveThatItem
        
        RTS
    
    .equippableItemAvailable
    
    ; Is there an item currently equipped (in the HUD slot)?
    LDA.w $0202 : BNE .alreadyEquipped
        ; If not, set the equipped item to the Bow and Arrow (even if we don't
        ; actually have it).
        LDA.b #$01 : STA.w $0202
    
    .alreadyEquipped
    
    ; Checks to see if we actually have that item, we're done if we have that
    ; item.
    JSR.w DoWeHaveThisItem : BCS .weHaveThatItem
        JMP.w TryEquipNextItem
}

; ==============================================================================

; $06E3C8-$06E3D8 LOCAL JUMP LOCATION
Equipment_GetPaletteMask:
{
    ; Basically if(A == 0) $00 = 0xE3FF else $00 = 0xFFFF; If A was zero, this
    ; would be used to force a tilemap entry's palette to the 0th palette.
    
    SEP #$30
    
    LDX.b #$E3
    
    CMP.b #$00 : BEQ .alpha
        LDX.b #$FF
    
    .alpha
    
    STX.b $01
    
    LDA.b #$FF : STA.b $00
    
    RTS
}

; ==============================================================================

; $06E3D9-$06E646 LOCAL JUMP LOCATION
Equipment_DrawYButtonItems:
{
    REP #$30
    
    ; Draw 4 corners of a box (for the equippable item section).
    LDA.w #$3CFB : AND.b $00    : STA.w $1142
                   ORA.w #$8000 : STA.w $14C2
                   ORA.w #$4000 : STA.w $14E6
                   EOR.w #$8000 : STA.w $1166
    
    LDX.w #$0000
    LDY.w #$000C
    
    .drawVerticalEdges
    
        LDA.w #$3CFC : AND.b $00    : STA.w $1182, X
                       ORA.w #$4000 : STA.w $11A6, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$3CF9 : AND.b $00 : STA.w $1144, X
        ORA.w #$8000             : STA.w $14C4, X
        
        INX : INX
    DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    LDA.w #$24F5
    
    .drawBoxInterior
    
        STA.w $1184, X : STA.w $11C4, X
        STA.w $1204, X : STA.w $1244, X
        STA.w $1284, X : STA.w $12C4, X
        STA.w $1304, X : STA.w $1344, X
        STA.w $1384, X : STA.w $13C4, X
        STA.w $1404, X : STA.w $1444, X
        STA.w $1484, X
        
        INX : INX
    DEY : BPL .drawBoxInterior
    
    ; Draw 'Y' button Icon.
    LDA.w #$3CF0 : STA.w $1184
    LDA.w #$3CF1 : STA.w $11C4

    ; The "ITEM" at the top.
    LDA.w #$246E : STA.w $1146
    LDA.w #$246F : STA.w $1148
    
    ; Draw the items:

    ; Draw Bow and Arrow.
    LDA.w #$11C8                 : STA.b $00
    LDA.l $7EF340 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bows    : STA.b $04
    JSR.w DrawItem
    
    ; Draw Boomerang.
    LDA.w #$11CE                 : STA.b $00
    LDA.l $7EF341 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_booms   : STA.b $04
    JSR.w DrawItem
    
    ; Draw Hookshot.
    LDA.w #$11D4                 : STA.b $00
    LDA.l $7EF342 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_hook    : STA.b $04
    JSR.w DrawItem
    
    ; Draw Bombs.
    LDA.w #$11DA : STA.b $00
    LDA.l $7EF343 : AND.w #$00FF : BEQ .gotNoBombs
        LDA.w #$0001
    
    .gotNoBombs
    
    STA.b $02
    LDA.w #ItemMenuIcons_bombs : STA.b $04
    JSR.w DrawItem
    
    ; Draw mushroom or magic powder.
    LDA.w #$11E0 :                 STA.b $00
    LDA.l $7EF344 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_powder  : STA.b $04
    JSR.w DrawItem
    
    ; Draw Fire Rod.
    LDA.w #$1288 :                  STA.b $00
    LDA.l $7EF345 : AND.w #$00FF  : STA.b $02
    LDA.w #ItemMenuIcons_fire_rod : STA.b $04
    JSR.w DrawItem
    
    ; Draw Ice Rod.
    LDA.w #$128E :                 STA.b $00
    LDA.l $7EF346 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_ice_rod : STA.b $04
    JSR.w DrawItem
    
    ; Draw Bombos Medallion.
    LDA.w #$1294 :                 STA.b $00
    LDA.l $7EF347 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bombos  : STA.b $04
    JSR.w DrawItem
    
    ; Draw Ether Medallion.
    LDA.w #$129A :                 STA.b $00
    LDA.l $7EF348 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_ether   : STA.b $04
    JSR.w DrawItem
    
    ; Draw Quake Medallion.
    LDA.w #$12A0 :                 STA.b $00
    LDA.l $7EF349 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_quake   : STA.b $04
    JSR.w DrawItem
    
    ; Draw Lamp.
    LDA.w #$1348 :                 STA.b $00
    LDA.l $7EF34A : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_lamp    : STA.b $04
    JSR.w DrawItem
    
    ; Hammer.
    LDA.w #$134E :                 STA.b $00
    LDA.l $7EF34B : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_hammer  : STA.b $04
    JSR.w DrawItem
    
    ; Flute.
    LDA.w #$1354 :                 STA.b $00
    LDA.l $7EF34C : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_flute   : STA.b $04
    JSR.w DrawItem
    
    ; Bug Catching Net.
    LDA.w #$135A :                 STA.b $00
    LDA.l $7EF34D : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_net     : STA.b $04
    JSR.w DrawItem
    
    ; Draw Book Of Mudora.
    LDA.w #$1360 :                 STA.b $00
    LDA.l $7EF34E : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_book    : STA.b $04
    JSR.w DrawItem
    
    ; There is an active bottle.
    LDA.w #$1408 : STA.b $00
    LDA.l $7EF34F : AND.w #$00FF : TAX : BNE .haveSelectedBottle
        LDA.w #$0000
        
        BRA .noSelectedBottle
    
    .haveSelectedBottle
    
    LDA.l $7EF35B, X : AND.w #$00FF
    
    .noSelectedBottle
    
    STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Draw Cane of Somaria.
    LDA.w #$140E :                 STA.b $00
    LDA.l $7EF350 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_somaria : STA.b $04
    JSR.w DrawItem
    
    ; Draw Cane of Byrna.
    LDA.w #$1414 :                 STA.b $00
    LDA.l $7EF351 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_byrna   : STA.b $04
    JSR.w DrawItem
    
    ; Draw Magic Cape.
    LDA.w #$141A :                 STA.b $00
    LDA.l $7EF352 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_cape    : STA.b $04
    JSR.w DrawItem
    
    ; Draw Magic Mirror.
    LDA.w #$1420 :                 STA.b $00
    LDA.l $7EF353 : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_mirror  : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06E647-$06E6B5 LOCAL JUMP LOCATION
Equipment_DrawSelectedItemBox:
{
    REP #$30
    
    ; Draw 4 corners of a box.
    LDA.w #$3CFB : AND.b $00 : STA.w $116A
    ORA.w #$8000 :             STA.w $12AA
    ORA.w #$4000 :             STA.w $12BC
    EOR.w #$8000 :             STA.w $117C
    
    LDX.w #$0000 
    LDY.w #$0003
    
    ; The lines these tiles make are vertical.
    .drawBoxVerticalSides
    
        LDA.w #$3CFC : AND.b $00    : STA.w $11AA, X
                       ORA.w #$4000 : STA.w $11BC, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawBoxVerticalSides
    
    LDX.w #$0000
    LDY.w #$0007
    
    ; I say horizontal because the lines the sides make are horizontal.
    .drawBoxHorizontalSides
    
        LDA.w #$3CF9 : AND.b $00    : STA.w $116C, X
                       ORA.w #$8000 : STA.w $12AC, X
        
        INX : INX
    DEY : BPL .drawBoxHorizontalSides
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .drawBoxInterior
    
        ; Init description draw.
        STA.w $11AC, X : STA.w $11EC, X
        STA.w $122C, X : STA.w $126C, X
        
        INX : INX
    DEY : BPL .drawBoxInterior
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06E6B6-$06E7B6 LOCAL JUMP LOCATION
Equipment_DrawAbilityText:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$0010
    LDA.w #$24F5
    
    .drawBoxInterior
    
        STA.w $1584, X : STA.w $15C4, X
        STA.w $1604, X : STA.w $1644, X
        STA.w $1684, X : STA.w $16C4, X
        STA.w $1704, X
        
        INX : INX
    DEY : BPL .drawBoxInterior
    
    ; Get data from ability variable (set of flags for each ability).
    LDA.l $7EF378 : AND.w #$FF00 : STA.b $02
    
    LDA.w #$0003 : STA.b $04
    
    LDY.w #$0000 : TYX
    
    .nextLine
    
        LDA.w #$0004 : STA.b $06
        
        .nextAbility
        
            ASL.b $02 : BCC .lacksAbility
                ; Draws the ability strings if Link has the ability
                ; (2 x 5 tile rectangle for each ability).
                LDA.w ItemMenu_AbilityText_main_jumble+00, X : STA.w $1588, Y
                LDA.w ItemMenu_AbilityText_main_jumble+02, X : STA.w $158A, Y
                LDA.w ItemMenu_AbilityText_main_jumble+04, X : STA.w $158C, Y
                LDA.w ItemMenu_AbilityText_main_jumble+06, X : STA.w $158E, Y
                LDA.w ItemMenu_AbilityText_main_jumble+08, X : STA.w $1590, Y
                LDA.w ItemMenu_AbilityText_main_jumble+10, X : STA.w $15C8, Y
                LDA.w ItemMenu_AbilityText_main_jumble+12, X : STA.w $15CA, Y
                LDA.w ItemMenu_AbilityText_main_jumble+14, X : STA.w $15CC, Y
                LDA.w ItemMenu_AbilityText_main_jumble+16, X : STA.w $15CE, Y
                LDA.w ItemMenu_AbilityText_main_jumble+18, X : STA.w $15D0, Y
            
            .lacksAbility
            
            TXA : CLC : ADC.w #$0014 : TAX
            TYA : CLC : ADC.w #$000A : TAY
        DEC.b $06 : BNE .nextAbility
        
        TYA : CLC : ADC.w #$0058 : TAY
    DEC.b $04 : BNE .nextLine
    
    ; Draw the 4 corners of the box containing the ability tiles.
    LDA.w #$24FB : AND.b $00    : STA.w $1542
                   ORA.w #$8000 : STA.w $1742
                   ORA.w #$4000 : STA.w $1766
                   EOR.w #$8000 : STA.w $1566
    
    LDX.w #$0000
    LDY.w #$0006
    
    .drawVerticalEdges
    
        LDA.w #$24FC : AND.b $00 : STA.w $1582, X
        ORA.w #$4000             : STA.w $15A6, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$24F9 : AND.b $00 : STA.w $1544, X
        ORA.w #$8000             : STA.w $1744, X
        
        INX : INX
    DEY : BPL .drawHorizontalEdges
    
    ; Draw 'A' button icon.
    LDA.w #$A4F0 : STA.w $1584
    LDA.w #$24F2 : STA.w $15C4
    LDA.w #$2482 : STA.w $1546
    LDA.w #$2483 : STA.w $1548
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06E7B7-$06E819 LOCAL JUMP LOCATION
Equipment_DrawAbilityIcons:
{
    REP #$30
    
    ; Draw Gloves.
    LDA.w #$16D0 :                 STA.b $00
    LDA.l $7EF354 : AND.w #$00FF : STA.b $02
    LDA.w #$F7E9 :                 STA.b $04
    JSR.w DrawItem
    
    ; Draw Boots.
    LDA.w #$16C8 :                 STA.b $00
    LDA.l $7EF355 : AND.w #$00FF : STA.b $02
    LDA.w #$F801 :                 STA.b $04
    JSR.w DrawItem
    
    ; Draw Flippers.
    LDA.w #$16D8 :                 STA.b $00
    LDA.l $7EF356 : AND.w #$00FF : STA.b $02
    LDA.w #$F811 :                 STA.b $04
    JSR.w DrawItem
    
    ; Modify the lift ability text if you have a glove item.
    LDA.l $7EF354 : AND.w #$00FF : BEQ .finished
        CMP.w #$0001 : BNE .titansMitt
            LDA.w #$0000
            JSR.w DrawGloveAbility
            
            BRA .finished
        
        .titansMitt
        
        LDA.w #$0001
        
        JSR.w DrawGloveAbility
    
    .finished
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06E81A-$06E85F LOCAL JUMP LOCATION
Equipment_DrawGloveAbility:
{
    STA.b $00 
    ASL : ASL : ADC.b $00 : ASL : ASL : TAX
    LDA.w ItemMenu_AbilityText_lifts+00, X : STA.w $1588
    LDA.w ItemMenu_AbilityText_lifts+02, X : STA.w $158A
    LDA.w ItemMenu_AbilityText_lifts+04, X : STA.w $158C
    LDA.w ItemMenu_AbilityText_lifts+06, X : STA.w $158E
    LDA.w ItemMenu_AbilityText_lifts+08, X : STA.w $1590
    LDA.w ItemMenu_AbilityText_lifts+10, X : STA.w $15C8
    LDA.w ItemMenu_AbilityText_lifts+12, X : STA.w $15CA
    LDA.w ItemMenu_AbilityText_lifts+14, X : STA.w $15CC
    LDA.w ItemMenu_AbilityText_lifts+16, X : STA.w $15CE
    LDA.w ItemMenu_AbilityText_lifts+18, X : STA.w $15D0
    
    RTS
}

; ==============================================================================
    
; Progress box data
; $06E860-$06E913 DATA
ItemMenuIcons_PendantWindow:
{
    ; $6E860
    .row0
    db $28FB, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $68FB

    ; $6E874
    .row1
    db $28FC, $2521, $2522, $2523, $2524, $253F, $24F5, $24F5, $24F5, $68FC

    ; $6E888
    .row2
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC

    ; $6E89C
    .row3
    db $28FC, $24F5, $24F5, $24F5, $213B, $213C, $24F5, $24F5, $24F5, $68FC

    ; $6E8B0
    .row4
    db $28FC, $24F5, $24F5, $24F5, $213D, $213E, $24F5, $24F5, $24F5, $68FC

    ; $6E8C4
    .row5
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC

    ; $6E8D8
    .row6
    db $28FC, $24F5, $213B, $213C, $24F5, $24F5, $213B, $213C, $24F5, $68FC

    ; $6E8EC
    .row7
    db $28FC, $24F5, $213D, $213E, $24F5, $24F5, $213D, $213E, $24F5, $68FC

    ; $06E900
    .row8
    db $A8FB, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $E8FB
}

; $06E914-$06E9C7 DATA
ItemMenuIcons_CrystalWindow:
{
    ; $06E914
    .row0
    db $28FB, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $68FB

    ; $06E928
    .row1
    db $28FC, $252F, $2534, $2535, $2536, $2537, $24F5, $24F5, $24F5, $68FC

    ; $06E93C
    .row2
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC

    ; $06E950
    .row3
    db $28FC, $24F5, $24F5, $3146, $3147, $3146, $3147, $24F5, $24F5, $68FC

    ; $06E964
    .row4
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC

    ; $06E978
    .row5
    db $28FC, $24F5, $3146, $3147, $3146, $3147, $3146, $3147, $24F5, $68FC

    ; $06E98C
    .row6
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC

    ; $06E9A0
    .row7
    db $28FC, $24F5, $24F5, $3146, $3147, $3146, $3147, $24F5, $24F5, $68FC

    ; $06E9B4
    .row8
    db $A8FB, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $E8FB
}

; ==============================================================================

; $06E9C8-$06EB39 LOCAL JUMP LOCATION
Equipment_DrawProgressIcons:
{
    LDA.l $7EF3C5 : CMP.b #$03 : BCC .beforeAgahnim
        JMP.w .drawCrystals
    
    .beforeAgahnim
    
    REP #$30
    
    LDX.w #$0000
    
    .initPendantDiagram
    
        LDA.w ItemMenuIcons_PendantWindow_row0, X : STA.w $12EA, X
        LDA.w ItemMenuIcons_PendantWindow_row1, X : STA.w $132A, X
        LDA.w ItemMenuIcons_PendantWindow_row2, X : STA.w $136A, X
        LDA.w ItemMenuIcons_PendantWindow_row3, X : STA.w $13AA, X
        LDA.w ItemMenuIcons_PendantWindow_row4, X : STA.w $13EA, X
        LDA.w ItemMenuIcons_PendantWindow_row5, X : STA.w $142A, X
        LDA.w ItemMenuIcons_PendantWindow_row6, X : STA.w $146A, X
        LDA.w ItemMenuIcons_PendantWindow_row7, X : STA.w $14AA, X
        LDA.w ItemMenuIcons_PendantWindow_row8, X : STA.w $14EA, X
    INX : INX : CPX.w #$0014 : BCC .initPendantDiagram
    
    ; Draw Green Pendant.
    LDA.w #$13B2                 : STA.b $00
    LDA.l $7EF374 : AND.w #$0001 : STA.b $02
    LDA.w #$F8D1                 : STA.b $04
    JSR.w DrawItem
    
    ; Draw Blue Pendant.
    LDA.w #$146E : STA.b $00
                   STZ.b $02
    LDA.l $7EF374 : AND.w #$0002 : BEQ .needWisdomPendant
        INC.b $02
    
    .needWisdomPendant
    
    LDA.w #$F8E1 : STA.b $04
    JSR.w DrawItem
    
    ; Draw Red Pendant.
    LDA.w #$1476 : STA.b $00
                   STZ.b $02
    LDA.l $7EF374 : AND.w #$0004 : BEQ .needPowerPendant
        INC.b $02
    
    .needPowerPendant
    
    LDA.w #$F8F1 : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
    
    ; $06EA62 ALTERNATE ENTRY POINT
    .drawCrystals
    
    REP #$30
    
    LDX.w #$0000
    
    .initCrystalDiagram
    
        LDA.w ItemMenuIcons_CrystalWindow_row0, X : STA.w $12EA, X
        LDA.w ItemMenuIcons_CrystalWindow_row1, X : STA.w $132A, X
        LDA.w ItemMenuIcons_CrystalWindow_row2, X : STA.w $136A, X
        LDA.w ItemMenuIcons_CrystalWindow_row3, X : STA.w $13AA, X
        LDA.w ItemMenuIcons_CrystalWindow_row4, X : STA.w $13EA, X
        LDA.w ItemMenuIcons_CrystalWindow_row5, X : STA.w $142A, X
        LDA.w ItemMenuIcons_CrystalWindow_row6, X : STA.w $146A, X
        LDA.w ItemMenuIcons_CrystalWindow_row7, X : STA.w $14AA, X
        LDA.w ItemMenuIcons_CrystalWindow_row8, X : STA.w $14EA, X
    INX : INX : CPX.w #$0014 : BCC .initCrystalDiagram
    
    ; Draw Crystal 1.
    LDA.l $7EF37A : AND.w #$0001 : BEQ .miseryMireNotDone
        LDA.w #$2D44 : STA.w $13B0
        LDA.w #$2D45 : STA.w $13B2
    
    .miseryMireNotDone
    
    ; Draw Crystal 2.
    LDA.l $7EF37A : AND.w #$0002 : BEQ .darkPalaceNotDone
        LDA.w #$2D44 : STA.w $13B4
        LDA.w #$2D45 : STA.w $13B6
    
    .darkPalaceNotDone
    
    ; Draw Crystal 3.
    LDA.l $7EF37A : AND.w #$0004 : BEQ .icePalaceNotDone
        LDA.w #$2D44 : STA.w $142E
        LDA.w #$2D45 : STA.w $1430
    
    .icePalaceNotDone
    
    ; Draw Crystal 4.
    LDA.l $7EF37A : AND.w #$0008 : BEQ .turtleRockNotDone
        LDA.w #$2D44 : STA.w $1432
        LDA.w #$2D45 : STA.w $1434
    
    .turtleRockNotDone
    
    ; Draw Crystal 5.
    LDA.l $7EF37A : AND.w #$0010 : BEQ .swampPalaceNotDone
        LDA.w #$2D44 : STA.w $1436
        LDA.w #$2D45 : STA.w $1438
    
    .swampPalaceNotDone
    
    ; Draw Crystal 6.
    LDA.l $7EF37A : AND.w #$0020 : BEQ .blindHideoutNotDone
        LDA.w #$2D44 : STA.w $14B0
        LDA.w #$2D45 : STA.w $14B2
    
    .blindHideoutNotDone
    
    ; Draw Crystal 7.
    LDA.l $7EF37A : AND.w #$0040 : BEQ .skullWoodsNotDone
        LDA.w #$2D44 : STA.w $14B4
        LDA.w #$2D45 : STA.w $14B6
    
    .skullWoodsNotDone
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06EB3A-$06ECE8 LOCAL JUMP LOCATION
Equipment_DrawSelectedYButtonItem:
{
    REP #$30
    
    LDA.w $0202 : AND.w #$00FF : DEC : ASL : TAX
    LDY.w ItemMenu_CursorPosition, X
    LDA.w $0000, Y : STA.w $11B2
    LDA.w $0002, Y : STA.w $11B4
    LDA.w $0040, Y : STA.w $11F2
    LDA.w $0042, Y : STA.w $11F4
    
    LDA.w $0207 : AND.w #$0010 : BEQ .dontUpdate
        ; TODO: Find out where the bank switch is for this and what bank we are
        ; currently in.
        LDA.w #$3C61 : STA.w $FFC0, Y
        ORA.w #$4000 : STA.w $FFC2, Y
        
        LDA.w #$3C70 : STA.w $FFFE, Y
        ORA.w #$4000 : STA.w $0004, Y
        
        LDA.w #$BC70 : STA.w $003E, Y
        ORA.w #$4000 : STA.w $0044, Y
        
        LDA.w #$BC61 : STA.w $0080, Y
        ORA.w #$4000 : STA.w $0082, Y
        
        LDA.w #$3C60 : STA.w $FFBE, Y
        ORA.w #$4000 : STA.w $FFC4, Y
        ORA.w #$8000 : STA.w $0084, Y
        EOR.w #$4000 : STA.w $007E, Y
    
    .dontUpdate

    ; Draw the item description:
    ; The Bottles, Magic Powder, Magic Mirror, and Flute's descriptions can
    ; change depending on their SRM value because of their alternate items
    ; (potions/faires, mushroom, unused map item, and shovel).
    
    ; Check if we need to write a Bottle description.
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0010 : BNE .bottleNotSelected
        LDA.l $7EF34F : AND.w #$00FF : BEQ .bottleNotSelected
            TAX
            LDA.l $7EF35B, X : AND.w #$00FF : DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .drawBottleDescription
            
                ; Loads 24F5, 
                LDA.w ItemMenuNameText_Bottles_0, X : STA.w $122C, Y

                ; Loads 2551, 255E, 2563, 2563, 255B, 2554, 24F5, 24F5,
                LDA.w ItemMenuNameText_Bottles_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .drawBottleDescription
            
            JMP.w .finished
    
    .bottleNotSelected

    ; Check if we need to write the Magic Powder description.
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0005 : BNE .powderNotSelected
        LDA.l $7EF344 : AND.w #$00FF : DEC : BEQ .powderNotSelected
            DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writePowderDescription
            
                LDA.w ItemMenuNameText_Powder_0, X : STA.w $122C, Y
                LDA.w ItemMenuNameText_Powder_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .writePowderDescription
            
            JMP.w .finished
    
    .powderNotSelected
    
    ; Check if we need to write the Magic Mirror description.
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0014 : BNE .mirrorNotSelected
        LDA.l $7EF353 : AND.w #$00FF : DEC : BEQ .mirrorNotSelected
            DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeMirrorDescription
            
                LDA.w ItemMenuNameText_Mirror_0, X : STA.w $122C, Y
                LDA.w ItemMenuNameText_Mirror_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .writeMirrorDescription
            
            JMP.w .finished
    
    .mirrorNotSelected
    
    ; Check if we need to write the Flute description.
    LDA.w $0202 : AND.w #$00FF : CMP.w #$000D : BNE .fluteNotSelected
        LDA.l $7EF34C : AND.w #$00FF : DEC : BEQ .fluteNotSelected
            DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeFluteDescription
            
                LDA.w ItemMenuNameText_Flute_0, X : STA.w $122C, Y
                LDA.w ItemMenuNameText_Flute_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .writeFluteDescription
            
            BRA .finished
        
    .fluteNotSelected
    
    ; Check if we need to write the Bow description.
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0001 : BNE .bowNotSelected
        LDA.l $7EF340 : AND.w #$00FF : DEC : BEQ .bowNotSelected
            DEC : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeBowDescription
            
                LDA.w ItemMenuNameText_Bow_0, X : STA.w $122C, Y
                LDA.w ItemMenuNameText_Bow_1, X : STA.w $126C, Y
                
                INX : INX
            INY : INY : CPY.w #$0010 : BCC .writeBowDescription
            
            BRA .finished
    
    .bowNotSelected
    
    TXA : ASL #4 : TAX
    
    LDY.w #$0000                                                
    
    ; If we the item was not a bottle, the Magic Powder, Magic Mirror, or the
    ; Bow, write the defaul description.
    .writeDefaultDescription
    
        LDA.w ItemMenuNameText_YItems_0, X : STA.w $122C, Y
        LDA.w ItemMenuNameText_YItems_1, X : STA.w $126C, Y
        
        INX : INX
    INY : INY : CPY.w #$0010 : BCC .writeDefaultDescription
    
    .finished
    
    SEP #$30
    
    RTS
}

; ==============================================================================
 
; $06ECE9-$06ED03 LOCAL JUMP LOCATION
Equipment_DrawMoonPearl:
{
    REP #$30
    
    LDA.w #$16E0                 : STA.b $00
    LDA.l $7EF357 : AND.w #$00FF : STA.b $02
    LDA.w #$F821                 : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
} 

; ==============================================================================
    
; $06ED04-$06ED08 LOCAL JUMP LOCATION
Equipment_UnfinishedRoutine:
{
    REP #$30
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; Equipment box text:
; $06ED09-$06ED18 DATA
ItemMenu_EQUIPMENT:
{
    ; "EQUIPMENT"
    dw $2479, $247A, $247B, $247C, $248C, $24F5, $24F5, $24F5
}

; $06ED19-$06ED28 DATA
ItemMenu_DUNGEONITEM:
{
    ; "DUNGEON ITEM"
    dw $2469, $246A, $246B, $246C, $246D, $246E, $246F, $24F5
}

; ==============================================================================

; $06ED29-$06EE20 LOCAL JUMP LOCATION
Equipment_DrawEquipment:
{
    REP #$30
    
    ; Draw the 4 corners of the border for this section.
    LDA.w #$28FB : AND.b $00 : STA.w $156A
    ORA.w #$8000 :             STA.w $176A
    ORA.w #$4000 :             STA.w $177C
    EOR.w #$8000 :             STA.w $157C
    
    LDX.w #$0000
    LDY.w #$0006
    
    .drawVerticalEdges

        LDA.w #$28FC : AND.b $00 : STA.w $15AA, X
        ORA.w #$4000 :             STA.w $15BC, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawHorizontalEdges

        LDA.w #$28F9 : AND.b $00 : STA.w $156C, X
        ORA.w #$8000 :             STA.w $176C, X
    INX : INX : DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .drawBoxInterior

        STA.w $15AC, X : STA.w $15EC, X
        STA.w $162C, X : STA.w $166C, X
        STA.w $16AC, X : STA.w $16EC, X
        STA.w $172C, X
    INX : INX : DEY : BPL .drawBoxInterior
    
    LDX.w #$0000
    LDY.w #$0007
    
    LDA.w #$28D7 : AND.b $00
    
    .drawDashedSeparator

        STA.w $166C, X
    INX : INX : DEY : BPL .drawDashedSeparator
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawBoxTitle

        ; Draw the "EQUIPMENT" text.
        LDA.w ItemMenu_EQUIPMENT, X : AND.b $00 : STA.w $15AC, X

        ; Draw the "DUNGEON ITEM" text.
        LDA.w ItemMenu_DUNGEONITEM, X : AND.b $00 : STA.w $16AC, X
    INX : INX : DEY : BPL .drawBoxTitle
    
    ; Check if we're in a real dungeon as opposed to just some
    ; house or cave.
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BNE .inSpecificDungeon
        LDX.w #$0000
        LDY.w #$0007
        LDA.w #$24F5
        
        .delete_dungeon_item_letters
        
            STA.w $16AC, X

            INX : INX
        DEY : BPL .delete_dungeon_item_letters
        
        ; Draw Heart Pieces.
        LDA.w #$16F2 :                 STA.b $00
        LDA.l $7EF36B : AND.w #$00FF : STA.b $02
        LDA.w #$F911 :                 STA.b $04
        JSR.w DrawItem
    
    .inSpecificDungeon
    
    REP #$30
    
    ; Draw Sword.
    LDA.w #$15EC : STA.b $00

    LDA.l $7EF359 : AND.w #$00FF : CMP.w #$00FF : BNE .hasSword
        LDA.w #$0000
    
    .hasSword
    
                   STA.b $02
    LDA.w #$F839 : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE21-$06EE3B LOCAL JUMP LOCATION
Equipment_DrawShield:
{
    REP #$30
    
    LDA.w #$15F2                  : STA.b $00
    LDA.l $7EF35A  : AND.w #$00FF : STA.b $02
    LDA.w #$F861                  : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE3C-$06EE56 LOCAL JUMP LOCATION
Equipment_DrawArmor:
{
    REP #$30
    
    LDA.w #$15F8                  : STA.b $00
    LDA.l $7EF35B  : AND.w #$00FF : STA.b $02
    LDA.w #$F881                  : STA.b $04
    JSR.w DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE57-$06EEB5 LOCAL JUMP LOCATION
Equipment_DrawMapAndBigKey:
{
    REP #$30
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInDungeon
        LSR : TAX
        
        ; Check if we have the big key in this dungeon.
        LDA.l $7EF366
        
        .locateBigKeyFlag

            ; Loop.
            ASL
        DEX : BPL .locateBigKeyFlag

        BCC .dontHaveBigKey
            JSR.w ItemMenu_CheckForDungeonPrize
            
            REP #$30
            
            ; Draw the big key (or big key with chest if we've gotten the
            ; treasure) icon.
            LDA.w #$16F8                   : STA.b $00
            LDA.w #$0001 : CLC : ADC.b $02 : STA.b $02
            LDA.w #$F8A9                   : STA.b $04
            JSR.w DrawItem
        
        .dontHaveBigKey
    .notInDungeon
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInDungeonAgain
        LSR : TAX
        
        ; Check if we have the map in this dungeon.
        LDA.l $7EF368
        
        .locateMapFlag
        
            ; Loop.
            ASL
        DEX : BPL .locateMapFlag
        
        BCC .dontHaveMap
            ; Draw Map.
            LDA.w #$16EC : STA.b $00
            LDA.w #$0001 : STA.b $02
            LDA.w #$F8C1 : STA.b $04
            JSR.w DrawItem
        
        .dontHaveMap
    .notInDungeonAgain
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EEB6-$06EEDB LOCAL JUMP LOCATION
ItemMenu_CheckForDungeonPrize:
{
    SEP #$30
    
    LDA.w $040C : LSR
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ItemMenu_NoPrizeHad           ; 0x00 - $EEDC Sewers
    dw ItemMenu_NoPrizeHad           ; 0x01 - $EEDC Hyrule Castle
    dw ItemMenu_CheckForBow          ; 0x02 - $EEE1 Eastern Palace
    dw ItemMenu_CheckForGloves       ; 0x03 - $EEEE Desert Palace
    dw ItemMenu_NoPrizeHad           ; 0x04 - $EEDC Agahnim's Tower
    dw ItemMenu_CheckForHookshot     ; 0x05 - $EEF4 Swamp Palace
    dw ItemMenu_CheckForHammer       ; 0x06 - $EEFA Palace of Darkness
    dw ItemMenu_CheckForSomaria      ; 0x07 - $EF00 Misery Mire
    dw ItemMenu_CheckForFireRod      ; 0x08 - $EF06 Skull Woods
    dw ItemMenu_CheckForBlueMail     ; 0x09 - $EF0C Ice Palace
    dw ItemMenu_CheckForMoonPearl    ; 0x0A - $EF12 Tower of Hera
    dw ItemMenu_CheckForTitansMitt   ; 0x0B - $EF18 Thieves' Town
    dw ItemMenu_CheckForMirrorShield ; 0x0C - $EF1F Turtle Rock
    dw ItemMenu_CheckForRedMail      ; 0x0D - $EF2C Ganon's Tower
}

; $06EEDC-$06EEE0 LOCAL JUMP LOCATION
ItemMenu_NoPrizeHad:
{
    STZ.b $02
    STZ.b $03
    
    RTS
}
    
; $06EEE1-$06EEE4 LOCAL JUMP LOCATION
ItemMenu_CheckForBow:
{
    LDA.l $7EF340

    ; Bleeds into the next function.
}
    
; $06EEE5-$06EEE6 LOCAL JUMP LOCATION
ItemMenu_CheckThePrize:
{
    BEQ ItemMenu_NoPrizeHad
        ; Bleeds into the next function.
}

; $06EEE7-$06EEED LOCAL JUMP LOCATION
ItemMenu_HaveThePrize:
{
    LDA.b #$01 : STA.b $02
                 STZ.b $03
    
    RTS
}
    
; $06EEEE-$06EEF3 LOCAL JUMP LOCATION
ItemMenu_CheckForGloves:
{
    LDA.l $7EF354

    BRA ItemMenu_CheckThePrize
}
    
; $06EEF4-$06EEF9 LOCAL JUMP LOCATION
ItemMenu_CheckForHookshot:
{
    LDA.l $7EF342
    
    BRA ItemMenu_CheckThePrize
}

; $06EEFA-$06EEFF LOCAL JUMP LOCATION
ItemMenu_CheckForHammer:
{
    LDA.l $7EF34B
    
    BRA ItemMenu_CheckThePrize
}

; $06EF00-$06EF05 LOCAL JUMP LOCATION
ItemMenu_CheckForSomaria:
{
    LDA.l $7EF350
    
    BRA ItemMenu_CheckThePrize
}

; $06EF06-$06EF0B LOCAL JUMP LOCATION
ItemMenu_CheckForFireRod:
{
    LDA.l $7EF345
    
    BRA ItemMenu_CheckThePrize
}

; $06EF0C-$06EF11 LOCAL JUMP LOCATION
ItemMenu_CheckForBlueMail:
{
    LDA.l $7EF35B
    
    BRA ItemMenu_CheckThePrize
}

; $06EF12-$06EF17 LOCAL JUMP LOCATION
ItemMenu_CheckForMoonPearl:
{
    LDA.l $7EF357
    
    BRA ItemMenu_CheckThePrize
}

; $06EF18-$06EF1E LOCAL JUMP LOCATION
ItemMenu_CheckForTitansMitt:
{
    LDA.l $7EF354 : DEC
    
    BRA ItemMenu_CheckThePrize
}

; $06EF1F-$06EF2B LOCAL JUMP LOCATION
ItemMenu_CheckForMirrorShield:
{
    LDA.l $7EF35A : CMP.b #$03 : BEQ ItemMenu_HaveThePrize
        STZ.b $02
        STZ.b $03
        
        RTS
}

; $06EF2C-$06EF38 LOCAL JUMP LOCATION
ItemMenu_CheckForRedMail:
{
    LDA.l $7EF35B : CMP.b #$02 : BEQ ItemMenu_HaveThePrize
        STZ.b $02
        STZ.b $03
        
        RTS
}

; ==============================================================================

; $06EF39-$06EF66 LOCAL JUMP LOCATION
Equipment_DrawCompass:
{
    REP #$30
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInDungeon
        LSR : TAX
        
        LDA.l $7EF364
        
        .locateCompassFlag

            ; Loop.
            ASL
        DEX : BPL .locateCompassFlag

        BCC .dontHaveCompass
            LDA.w #$16F2 : STA.b $00
            LDA.w #$0001 : STA.b $02
            LDA.w #$F899 : STA.b $04
            JSR.w DrawItem
            
        .dontHaveCompass
    .notInDungeon
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EF67-$06F0F6 LOCAL JUMP LOCATION
Equipment_DrawBottleMenu:
{
    REP #$30
    
    LDA.w #$28FB : AND.b $00 : STA.w $12EA
    ORA.w #$8000             : STA.w $176A
    ORA.w #$4000             : STA.w $177C
    EOR.w #$8000             : STA.w $12FC
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawVerticalEdges
    
        LDA.w #$28FC : AND.b $00 : STA.w $132A, X
        ORA.w #$4000             : STA.w $133C, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawHorizontalEdges
    
        LDA.w #$28F9 : AND.b $00 : STA.w $12EC, X
        ORA.w #$8000             : STA.w $176C, X
        
        INX : INX
    DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    ; Fills in a region of 0x11 by 0x07 tiles with one tilemap value.
    .drawBoxInterior
    
        STA.w $132C, X : STA.w $136C, X
        STA.w $13AC, X : STA.w $13EC, X
        STA.w $142C, X : STA.w $146C, X
        STA.w $14AC, X : STA.w $14EC, X
        STA.w $152C, X : STA.w $156C, X
        STA.w $15AC, X : STA.w $15EC, X
        STA.w $162C, X : STA.w $166C, X
        STA.w $16AC, X : STA.w $16EC, X
        STA.w $172C, X
        
        INX : INX
    DEY : BPL .drawBoxInterior
    
    REP #$30
    
    ; Draw bottle 0.
    LDA.w #$1372                 : STA.b $00
    LDA.l $7EF35C : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Draw bottle 1.
    LDA.w #$1472                 : STA.b $00
    LDA.l $7EF35D : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Draw bottle 2.
    LDA.w #$1572                 : STA.b $00
    LDA.l $7EF35E : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Draw bottle 3.
    LDA.w #$1672                 : STA.b $00
    LDA.l $7EF35F : AND.w #$00FF : STA.b $02
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Draw the currently selected bottle.
    LDA.w #$1408                    : STA.b $00
    LDA.l $7EF34F : AND.w #$00FF    : TAX
    LDA.l $7EF35B, X : AND.w #$00FF : STA.b $02

    ; Loads $2837, $2838, $2CC3, $2CD3
    LDA.w #ItemMenuIcons_bottles : STA.b $04
    JSR.w DrawItem
    
    ; Take the currently selected item, and draw something with it, perhaps on
    ; the main menu region.
    LDA.w $0202 : AND.w #$00FF : DEC : ASL : TAX
    LDY.w ItemMenu_CursorPositions, X 
    LDA.w $0000, Y : STA.w $11B2
    LDA.w $0002, Y : STA.w $11B4
    LDA.w $0040, Y : STA.w $11F2
    LDA.w $0042, Y : STA.w $11F4
    
    LDA.l $7EF34F : DEC : AND.w #$00FF : ASL : TAY
    LDA.w BottleMenuCursorPosition, Y : TAY
    
    ; OPTIMIZE: Appears to be an extraneous load, perhaps something that was
    ; unfinished or meant to be taken out but it just never happened.
    LDA.w $0207
    
    LDA.w #$3C61 : STA.w $12AA, Y
    ORA.w #$4000 : STA.w $12AC, Y
    
    LDA.w #$3C70 : STA.w $12E8, Y
    ORA.w #$4000 : STA.w $12EE, Y
    
    LDA.w #$BC70 : STA.w $1328, Y
    ORA.w #$4000 : STA.w $132E, Y
    
    LDA.w #$BC61 : STA.w $136A, Y
    ORA.w #$4000 : STA.w $136C, Y
    
    ; Draw the corners of the bottle submenu.
    LDA.w #$3C60 : STA.w $12A8, Y
    ORA.w #$4000 : STA.w $12AE, Y
    ORA.w #$8000 : STA.w $136E, Y
    EOR.w #$4000 : STA.w $1368, Y
    
    SEP #$30
    
    LDA.b #$10 : STA.w $0207
    
    RTS
}

; ==============================================================================
; End of Equipment:    
; ==============================================================================

; This apparently is a hex to decimal converter for use with displaying numbers
; It's obviously slower with larger numbers... should find a way to speed it
; up. (already done)
; $06F0F7-$06F127 LOCAL JUMP LOCATION
HUD_HexToDecimal:
{
    REP #$30
    
    STZ.w $0003
    
    ; The objects mentioned could be rupees, arrows, bombs, or keys.
    LDX.w #$0000
    LDY.w #$0002
    
    .nextDigit
    
        ; If number of objects left < 100, 10
        CMP.w HUD_HEXtoDEC_PowersOf10, Y : BCC .nextLowest10sPlace
            ; Otherwise take off another 100 objects from the total and
            ; increment $03.
            ; $06F9F9, Y THAT IS, 100, 10
            SEC : SBC.w HUD_HEXtoDEC_PowersOf10, Y

            INC.b $03, X
            
            BRA .nextDigit
        
        .nextLowest10sPlace
        
        INX : DEY : DEY
        ; Move on to next digit (to the right).
    BPL .nextDigit
    
    ; Whatever is left is obviously less than 10, so store the digit at $05.
    STA.b $05
    
    SEP #$30
    
    ; Go through at most three digits.
    LDX.b #$02
    
    ; Repeat for all three digits.
    .setNextDigitTile
    
        ; Load each digit's computed value
        LDA.b $03, X : CMP.b #$7F : BEQ .blankDigit
            ; #$0-9 -> #$90-#$99
            ORA.b #$90
        
        .blankDigit
        
        ; A blank digit.
        STA.b $03, X
    DEX : BPL .setNextDigitTile
    
    RTS
}

; ==============================================================================

; Carry clear if we are currently healing.
; Carry set if not.
; $06F128-$06F14E LONG JUMP LOCATION
HUD_RefillHealth:
{
    ; Check goal health versus actual health.
    ; If(actual < goal) then branch.
    LDA.l $7EF36D : CMP.l $7EF36C : BCC .refillAllHealth
        LDA.l $7EF36C : STA.l $7EF36D
        
        LDA.b #$00 : STA.l $7EF372
        
        ; If we are already healing, return carry clear.
        LDA.w $020A : BNE .beta
            SEC
            
            RTL
    
    .refillAllHealth
    
    ; Fill up the health.
    LDA.b #$A0 : STA.l $7EF372
    
    .beta
    
    CLC
    
    RTL
}

; ==============================================================================

; $06F14F-$06F1B2 LOCAL JUMP LOCATION
HUD_AnimateHeartRefill:
{
    SEP #$30
    
    ; $00[3] = $7EC768 (WRAM address of first row of hearts in tilemap buffer)
    LDA.b #$68 : STA.b $00
    LDA.b #$C7 : STA.b $01
    LDA.b #$7E : STA.b $02
    
    DEC.w $0208 : BNE .return
        REP #$30
        
        ; Y = ( ( ( (current_health & 0x00F8) - 1) / 8 ) * 2)
        LDA.l $7EF36D : AND.w #$00F8 : DEC : LSR #3 : ASL : TAY
        CMP.w #$0014 : BCC .halfHealthOrLess
            SBC.w #$0014 : TAY
            
            ; $00[3] = $7EC7A8 (WRAM address of second row of hearts)
            LDA.b $00 : CLC : ADC.w #$0040 : STA.b $00

        .halfHealthOrless

        SEP #$30
        
        LDX.w $0209 : LDA.l HUD_AllOnes, X : STA.w $0208
        
        TXA : ASL : TAX
        LDA.l HUD_HeartDisplayFrames+0, X : STA.b [$00], Y
        
        INY
        LDA.l HUD_HeartDisplayFrames+2, X : STA.b [$00], Y
        
        LDA.w $0209 : INC : AND.b #$03 : STA.w $0209
        BNE .return
            SEP #$30
            
            JSR.w Rebuild
            
            STZ.w $020A

    .return

    CLC
    
    RTS
} 

; ==============================================================================

; $06F1B3-$06F1C8 LONG JUMP LOCATION
HUD_RefillMagicPower:
{
    SEP #$30
    
    ; Check if Link's magic meter is full.
    LDA.l $7EF36E : CMP.b #$80 : BCS .itsFull
        ; Tell the magic meter to fill up until it's full.
        LDA.b #$80 : STA.l $7EF373
        
        SEP #$30
        
        RTL
    
    .itsFull
    
    ; Set the carry, signifying we're done filling it.
    SEP #$31
    
    RTL
}

; ==============================================================================

; $06F1C9-$06F448 DATA
ItemMenuNameText_YItems:
{
    ; $06F1C9
    .0
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ;

    ; $06F1D9
    .1
    dw $256B, $256C, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; Bow

    ; $06F1E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2570, $2571, $2572, $2573, $2574, $2575, $2576, $2577 ; Boomerang

    ; $06F209
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2557, $255E, $255E, $255A, $2562, $2557, $255E, $2563 ; Hookshot

    ; $06F229
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2551, $255E, $255C, $2551, $24F5, $24F5, $24F5, $24F5 ; Bombs

    ; $06F269
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C ; Mushroom

    ; $06F269
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2555, $2558, $2561, $2554, $2561, $255E, $2553, $24F5 ; Fire rod

    ; $06F289
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2558, $2552, $2554, $2561, $255E, $2553, $24F5, $24F5 ; Ice rod

    ; $06F2A9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2551, $255E, $255C, $2551, $255E, $2562, $24F5, $24F5 ; Bombos

    ; $06F2C9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2554, $2563, $2557, $2554, $2561, $24F5, $24F5, $24F5 ; Ether

    ; $06F2E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2560, $2564, $2550, $255A, $2554, $24F5, $24F5, $24F5 ; Quake

    ; $06F309
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $255B, $2550, $255C, $255F, $24F5, $24F5, $24F5, $24F5 ; Lamp

    ; $06F329
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5 ; 
    dw $24F5, $24F5, $2557, $2550, $255C, $255C, $2554, $2561 ; Magic hammer

    ; $06F349
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2562, $2557, $255E, $2565, $2554, $255B, $24F5, $24F5 ; Shovel

    ; $06F369
    dw $2400, $2401, $2402, $2403, $2404, $2405, $2406, $2407 ; 
    dw $2408, $2409, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; Bug net

    ; $06F389
    dw $2551, $255E, $255E, $255A, $24F5, $255E, $2555, $24F5 ; 
    dw $255C, $2564, $2553, $255E, $2561, $2550, $24F5, $24F5 ; Book of mudora

    ; $06F3A9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C ; Mushroom

    ; $06F3C9
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5 ; 
    dw $24F5, $2562, $255E, $255C, $2550, $2561, $2558, $2550 ; Cane of somaria

    ; $06F3E9
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5 ; 
    dw $24F5, $24F5, $24F5, $2551, $2568, $2561, $255D, $2550 ; Cane of byrna

    ; $06F409
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5 ; 
    dw $24F5, $24F5, $24F5, $2552, $2550, $255F, $2554, $24F5 ; Magic cape

    ; $06F429
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; Letter
}

; ==============================================================================

; $06F449-$06F548 DATA
ItemMenuNameText_Bottles:
{
    ; $06F449
    .0
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ;

    ; $06F459
    .1
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C ; Mushroom

    ; $06F469
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2551, $255E, $2563, $2563, $255B, $2554, $24F5, $24F5 ; Bottle

    ; $06F489
    dw $255B, $2558, $2555, $2554, $24F5, $24F5, $24F5, $24F5 ; 
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554 ; Life potion

    ; $06F4A9
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5 ; 
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554 ; Magic potion

    ; $06F4C9
    dw $2552, $2564, $2561, $2554, $256A, $2550, $255B, $255B ; 
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554 ; Life and magic

    ; $06F4E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2555, $2550, $2554, $2561, $2558, $2554, $24F5, $24F5 ; Fairy

    ; $06F509
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2551, $2554, $2554, $24F5, $24F5, $24F5, $24F5, $24F5 ; Bee

    ; $06F529
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2556, $255E, $255E, $2553, $24F5, $2551, $2554, $2554 ; Golden bee
}

; ==============================================================================

; $06F549-$06F568 DATA
ItemMenuNameText_Powder:
{
    ; $06F549
    .0
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5 ;

    ; $06F559
    .1
    dw $24F5, $255F, $255E, $2566, $2553, $2554, $2561, $24F5 ; Magic powder
}

; ==============================================================================

; $06F569-$06F5A8 DATA
ItemMenuNameText_Flute:
{
    ; $06F569
    .0
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ;

    ; $06F579
    .1
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5 ; Ocarina

    ; $06F589
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5 ; Ocarina
}

; ==============================================================================

; $06F5A9-$06F5C8 DATA
ItemMenuNameText_Mirror:
{
    ; $06F5A9
    .0
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5 ;

    ; $06F5B9
    .1
    dw $24F5, $24F5, $255C, $2558, $2561, $2561, $255E, $2561 ; Magic mirror
}

; ==============================================================================

; $06F5C9-$06F628
ItemMenuNameText_Bow:
{
    ; $06F5C9
    .0
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 

    ; $06F5D9
    .1
    dw $256B, $256C, $256E, $256F, $257C, $257D, $257E, $257F ; Bow and arrows

    ; $06F5E9
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; 
    dw $256B, $256C, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5 ; Bow

    ; $06F609
    dw $256B, $256C, $24F5, $256E, $256F, $24F5, $24F5, $24F5 ; 
    dw $2578, $2579, $257A, $257B, $257C, $257D, $257E, $257F ; Bow and silver arrows
}

; ==============================================================================

; $06F629-$06F930 DATA
ItemMenuIcons:
{
    ; $06F629
    .bows
    dw $20F5, $20F5, $20F5, $20F5 ; No bow
    dw $28BA, $28E9, $28E8, $28CB ; Empty bow
    dw $28BA, $284A, $2849, $28CB ; Bow and arrows
    dw $28BA, $28E9, $28E8, $28CB ; Empty silvers bow
    dw $28BA, $28BB, $24CA, $28CB ; Silver bow and arrows

    ; $06F651
    .booms
    dw $20F5, $20F5, $20F5, $20F5 ; No boomerang
    dw $2CB8, $2CB9, $2CF5, $2CC9 ; Blue boomerang
    dw $24B8, $24B9, $24F5, $24C9 ; Red boomerang

    ; $06F669
    .hook
    dw $20F5, $20F5, $20F5, $20F5 ; No hookshot
    dw $24F5, $24F6, $24C0, $24F5 ; Hookshot

    ; $06F679
    .bombs
    dw $20F5, $20F5, $20F5, $20F5 ; No bombs
    dw $2CB2, $2CB3, $2CC2, $6CC2 ; Bombs

    ; $06F689
    .powder
    dw $20F5, $20F5, $20F5, $20F5 ; No powder
    dw $2444, $2445, $2446, $2447 ; Mushroom
    dw $203B, $203C, $203D, $203E ; Powder

    ; $06F6A1
    .fire_rod
    dw $20F5, $20F5, $20F5, $20F5 ; No fire rod
    dw $24B0, $24B1, $24C0, $24C1 ; Fire rod

    ; $06F6B1
    .ice_rod
    dw $20F5, $20F5, $20F5, $20F5 ; No ice rod
    dw $2CB0, $2CBE, $2CC0, $2CC1 ; Ice rod

    ; $06F6C1
    .bombos
    dw $20F5, $20F5, $20F5, $20F5 ; No bombos
    dw $287D, $287E, $E87E, $E87D ; Bombos

    ; $06F6D1
    .ether
    dw $20F5, $20F5, $20F5, $20F5 ; No ether
    dw $2876, $2877, $E877, $E876 ; Ether

    ; $06F6E1
    .quake
    dw $20F5, $20F5, $20F5, $20F5 ; No quake
    dw $2866, $2867, $E867, $E866 ; Quake

    ; $06F6F1
    .lamp
    dw $20F5, $20F5, $20F5, $20F5 ; No lamp
    dw $24BC, $24BD, $24CC, $24CD ; Lamp

    ; $06F701
    .hammer
    dw $20F5, $20F5, $20F5, $20F5 ; No hammer
    dw $20B6, $20B7, $20C6, $20C7 ; Hammer

    ; $06F711
    .flute
    dw $20F5, $20F5, $20F5, $20F5 ; No flute
    dw $20D0, $20D1, $20E0, $20E1 ; Shovel
    dw $2CD4, $2CD5, $2CE4, $2CE5 ; Flute (inactive)
    dw $2CD4, $2CD5, $2CE4, $2CE5 ; Flute (active)

    ; $06F731
    .net
    dw $20F5, $20F5, $20F5, $20F5 ; No net
    dw $3C40, $3C41, $2842, $3C43 ; Net

    ; $06F741
    .book
    dw $20F5, $20F5, $20F5, $20F5 ; No book
    dw $3CA5, $3CA6, $3CD8, $3CD9 ; Book of Mudora

    ; $06F751
    .bottles
    dw $20F5, $20F5, $20F5, $20F5 ; No bottle
    dw $2044, $2045, $2046, $2047 ; Mushroom
    dw $2837, $2838, $2CC3, $2CD3 ; Empty bottle
    dw $24D2, $64D2, $24E2, $24E3 ; Red potion
    dw $3CD2, $7CD2, $3CE2, $3CE3 ; Green potion
    dw $2CD2, $6CD2, $2CE2, $2CE3 ; Blue potion
    dw $2855, $6855, $2C57, $2C5A ; Fairy
    dw $2837, $2838, $2839, $283A ; Bee
    dw $2837, $2838, $2839, $283A ; Good bee

    ; $06F799
    .somaria
    dw $20F5, $20F5, $20F5, $20F5 ; No somaria
    dw $24DC, $24DD, $24EC, $24ED ; Cane of Somaria

    ; $06F7A9
    .byrna
    dw $20F5, $20F5, $20F5, $20F5 ; No byrna
    dw $2CDC, $2CDD, $2CEC, $2CED ; Cane of Byrna

    ; $06F7B9
    .cape
    dw $20F5, $20F5, $20F5, $20F5 ; No cape
    dw $24B4, $24B5, $24C4, $24C5 ; Cape

    ; $06F7C9
    .mirror
    dw $20F5, $20F5, $20F5, $20F5 ; No mirror
    dw $28DE, $28DF, $28EE, $28EF ; Map
    dw $2C62, $2C63, $2C72, $2C73 ; Mirror
    dw $2886, $2887, $2888, $2889 ; Triforce (displays as arrows and bombs)

    ; $06F7E9
    .gloves
    dw $20F5, $20F5, $20F5, $20F5 ; No glove
    dw $2130, $2131, $2140, $2141 ; Power glove
    dw $28DA, $28DB, $28EA, $28EB ; Titan's mitt

    ; $06F801
    .boots
    dw $20F5, $20F5, $20F5, $20F5 ; No boots
    dw $3429, $342A, $342B, $342C ; Pegasus boots

    ; $06F811
    .flippers
    dw $20F5, $20F5, $20F5, $20F5 ; No flippers
    dw $2C9A, $2C9B, $2C9D, $2C9E ; Flippers

    ; $06F821
    .pearl
    dw $20F5, $20F5, $20F5, $20F5 ; No pearl
    dw $2433, $2434, $2435, $2436 ; Moon pearl

    ; $06F831
    .unused_nothing
    dw $20F5, $20F5, $20F5, $20F5 ; Nothing

    ; $06F839
    .sword
    dw $20F5, $20F5, $20F5, $20F5 ; No sword
    dw $2C64, $2CCE, $2C75, $3D25 ; Fighter sword
    dw $2C8A, $2C65, $2474, $3D26 ; Master sword
    dw $248A, $2465, $3C74, $2D48 ; Tempered sword
    dw $288A, $2865, $2C74, $2D39 ; Gold sword

    ; $06F861
    .shield
    dw $24F5, $24F5, $24F5, $24F5 ; No shield
    dw $2CFD, $6CFD, $2CFE, $6CFE ; Fighter shield
    dw $34FF, $74FF, $349F, $749F ; Fire shield
    dw $2880, $2881, $288D, $288E ; Mirror shield

    ; $06F881
    .mail
    dw $3C68, $7C68, $3C78, $7C78 ; Green mail
    dw $2C68, $6C68, $2C78, $6C78 ; Blue mail
    dw $2468, $6468, $2478, $6478 ; Red mail

    ; $06F899
    .compass
    dw $20F5, $20F5, $20F5, $20F5 ; No compass
    dw $24BF, $64BF, $2CCF, $6CCF ; Compass

    ; $06F8A9
    .big_key
    dw $20F5, $20F5, $20F5, $20F5 ; No big key
    dw $28D6, $68D6, $28E6, $28E7 ; Big key
    dw $354B, $354C, $354D, $354E ; Big key and chest

    ; $06F8C1
    .map
    dw $20F5, $20F5, $20F5, $20F5 ; No map
    dw $28DE, $28DF, $28EE, $28EF ; Map

    ; $06F8D1
    .pendant_red
    dw $313B, $313C, $313D, $313E ; No red pendant
    dw $252B, $252C, $252D, $252E ; Red pendant

    ; $06F8E1
    .pendant_blue
    dw $313B, $313C, $313D, $313E ; No blue pendant
    dw $2D2B, $2D2C, $2D2D, $2D2E ; Blue pendant

    ; $06F8F1
    .pendant_green
    dw $313B, $313C, $313D, $313E ; No green pendant
    dw $3D2B, $3D2C, $3D2D, $3D2E ; Green pendant

    ; $06F901
    .white_glove
    dw $20F5, $20F5, $20F5, $20F5 ; No white glove?
    dw $3D30, $3D31, $3D40, $3D41 ; White glove?

    ; $06F911
    .heart_pieces
    dw $2484, $6484, $2485, $6485 ; 0 heart pieces
    dw $24AD, $6484, $2485, $6485 ; 1 heart piece
    dw $24AD, $6484, $24AE, $6485 ; 2 heart pieces
    dw $24AD, $64AD, $24AE, $6485 ; 3 heart pieces
}

; ==============================================================================

; $06F931-06F9F8 DATA
ItemMenu_AbilityText:
{
    ; $06F931
    .lifts
    .lift2
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2D5B, $2D58, $2D55, $2D63, $2D28 ; Lift 2

    ; $06F945
    .lift3
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2D5B, $2D58, $2D55, $2D63, $2D29 ; Lift 3

    ; $06F959
    .main_jumble
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2D5B, $2D58, $2D55, $2D63, $2D27 ; Lift 1

    ; $06F96D
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2CF5, $2D61, $2D54, $2D50, $2D53 ; Read

    ; $06F981
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2CF5, $2D63, $2D50, $2D5B, $2D5A ; Talk

    ; $06F995
    dw $207F, $207F, $207F, $207F, $207F ; Nothing
    dw $207F, $207F, $207F, $207F, $207F ; Nothing

    ; $06F9A9
    dw $2CF5, $2CF5, $2C2E, $2CF5, $2CF5 ; 
    dw $2D5F, $2D64, $2D5B, $2D5B, $2CF5 ; Pull

    ; $06F9BD
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2CF5, $2D61, $2D64, $2D5D, $2CF5 ; Run

    ; $06F9D1
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5 ; 
    dw $2CF5, $2D62, $2D66, $2D58, $2D5C ; Swim

    ; $06F9E5
    dw $2CF5, $2CF5, $2CF5, $207F, $207F ; 
    dw $2C01, $2C18, $2C28, $207F, $207F ; Pray
}

; ==============================================================================

; $06F9F9-$06F9FC DATA
HUD_HEXtoDEC_PowersOf10:
{
    dw  10
    dw 100
}

; $06F9FD-$06FA02 DATA
HUD_HeartGFXTiles:
{
    dw $24A2, $24A2, $24A2
}

; $06FA03-$06FA08 DATA
HUD_HeartTiles:
{
    dw $24A2, $24A1, $24A0
}

; $06FA09-$06FA10 DATA
HUD_HeartDisplayFrames:
{
    dw $24A3, $24A4, $24A3, $24A0
}

; $06FA11-$06FA14 DATA
HUD_AllOnes:
{
    db $01, $01, $01, $01
}

; Used to determine what item to have link use, based on the position of the
; selected item in the Item Menu see $0303.
; $06FA15-$06FA32 DATA
MenuID_to_EquipID:
{
    ; $06FA15
    db $00 ; 0x00 - Nothing
    db $03 ; 0x01 - Bow
    db $02 ; 0x02 - Boomerang
    db $0E ; 0x03 - Hookshot
    db $01 ; 0x04 - Bombs
    db $0A ; 0x05 - Mushroom/Powder
    db $05 ; 0x06 - Fire rod
    db $06 ; 0x07 - Ice rod
    db $0F ; 0x08 - Bombos
    db $10 ; 0x09 - Ether
    db $11 ; 0x0A - Quake
    db $09 ; 0x0B - Lamp
    db $04 ; 0x0C - Hammer
    db $08 ; 0x0D - Shovel/Flute
    db $07 ; 0x0E - Net
    db $0C ; 0x0F - Book
    db $0B ; 0x10 - Bottle
    db $12 ; 0x11 - Somaria
    db $0D ; 0x12 - Byrna
    db $13 ; 0x13 - Cape
    db $14 ; 0x14 - Mirror

    ; $06FA2A
    db $00 ; 0x15 - Nothing
    db $01 ; 0x16 - Bombs
    db $06 ; 0x17 - Ice rod
    db $02 ; 0x18 - Boomerang
    db $07 ; 0x19 - Net
    db $03 ; 0x1A - Bow
    db $05 ; 0x1B - Fire rod
    db $04 ; 0x1C - Hammer
    db $08 ; 0x1D - Shovel/Flute
}

; ==============================================================================

; $06FA33-$06FA57 LONG JUMP LOCATION
RestoreTorchBackground:
{
    ; See if we have the lamp:
    LDA.l $7EF34A : BEQ .doNothing
        ; See if this room has the 'lights out' property.
        LDA.l $7EC005 : BEQ .doNothing
            ; TODO: The rest of these variables, I'm not too sure about.
            ; Probably indicate that a lamp bg object was place in the
            ; dungeon room.
            LDA.w $0458 : BNE .doNothing
                LDA.w $045A : BNE .doNothing
                    INC.w $0458
                    
                    LDA.w $0414 : CMP.b #$02 : BEQ .doNothing                 
                        LDA.b #$01 : STA.b $1D
    
    .doNothing
    
    RTL
}
    
; ==============================================================================

; $06FA58-$06FA5F LONG JUMP LOCATION
HUD_RebuildLong:
{
    PHB : PHK : PLB

    JSR.w Rebuild

    PLB

    RTL
}

; ==============================================================================

; $06FA60-$06FA67 LONG JUMP LOCATION
HUD_RebuildIndoor:
{
    LDA.b #$00 : STA.l $7EC017
    
    LDA.b #$FF

    ; Bleeds into the next function.
}
    
; $06FA68-$06FA6B LONG JUMP LOCATION
RebuildHUD_Keys:
{
    ; When the dungeon loads, tells us how many keys we have.
    STA.l $7EF36F

    ; Bleeds into the next function.
}

; $06FA6C-$06FA6F LONG JUMP LOCATION
RebuildLong2:
{
    JSR.w Rebuild
    
    RTL
}

; ==============================================================================

; When the screen finishes transitioning from the menu to the main game screen
; this is called to refresh the HUD by drawing a template (some tiles are
; dynamic though).
; $06FA70-$06FA92 LOCAL JUMP LOCATION
HUD_Rebuild:
{
    REP #$30
    
    PHB
    
    ; Preparing for the MVN transfer:
    LDA.w #$0149
    LDX.w #.hud_tilemap
    LDY.w #$C700
    
    ; $Transfer 0x014A bytes from $6FE77 -> $7EC700
    MVN $0D, $7E
    
    ; The above sets up a template for the status bar.
    PLB
    
    PHB : PHK : PLB
    
    BRA .alpha
    
    ; $06FA85 ALTERNATE ENTRY POINT
    .updateOnly
    
    REP #$30
    
    PHB : PHK : PLB
    
    .alpha
    
    JSR.w Update
    
    PLB
    
    SEP #$30
    
    INC.b $16 ; Indicate this needs drawing.
    
    RTS
}

; ==============================================================================

; $06FA93-$06FAD4 DATA
ItemMenu_ItemGFXPointers:
{
    dw ItemMenuIcons_bows           ; 0x00 - $F629
    dw ItemMenuIcons_booms          ; 0x01 - $F651
    dw ItemMenuIcons_hook           ; 0x02 - $F669
    dw ItemMenuIcons_bombs          ; 0x03 - $F679
    dw ItemMenuIcons_powder         ; 0x04 - $F689
    dw ItemMenuIcons_fire_rod       ; 0x05 - $F6A1
    dw ItemMenuIcons_ice_rod        ; 0x06 - $F6B1
    dw ItemMenuIcons_bombos         ; 0x07 - $F6C1
    dw ItemMenuIcons_ether          ; 0x08 - $F6D1
    dw ItemMenuIcons_quake          ; 0x09 - $F6E1
    dw ItemMenuIcons_lamp           ; 0x0A - $F6F1
    dw ItemMenuIcons_hammer         ; 0x0B - $F701
    dw ItemMenuIcons_flute          ; 0x0C - $F711
    dw ItemMenuIcons_net            ; 0x0D - $F731
    dw ItemMenuIcons_book           ; 0x0E - $F741
    dw ItemMenuIcons_bottles        ; 0x0F - $F751
    dw ItemMenuIcons_somaria        ; 0x10 - $F799
    dw ItemMenuIcons_byrna          ; 0x11 - $F7A9
    dw ItemMenuIcons_cape           ; 0x12 - $F7B9
    dw ItemMenuIcons_mirror         ; 0x13 - $F7C9
    dw ItemMenuIcons_gloves         ; 0x14 - $F7E9
    dw ItemMenuIcons_boots          ; 0x15 - $F801
    dw ItemMenuIcons_flippers       ; 0x16 - $F811
    dw ItemMenuIcons_pearl          ; 0x17 - $F821
    dw ItemMenuIcons_unused_nothing ; 0x18 - $F831
    dw ItemMenuIcons_sword          ; 0x19 - $F839
    dw ItemMenuIcons_shield         ; 0x1A - $F861
    dw ItemMenuIcons_mail           ; 0x1B - $F881
    dw ItemMenuIcons_bottles        ; 0x1C - $F751
    dw ItemMenuIcons_bottles        ; 0x1D - $F751
    dw ItemMenuIcons_bottles        ; 0x1E - $F751
    dw ItemMenuIcons_bottles        ; 0x1F - $F751
    dw ItemMenuIcons_white_glove    ; 0x20 - $F901
}

; $06FAD5-$06FAFC DATA
ItemMenu_CursorPositions:
{
    dw $11C8, $11CE, $11D4, $11DA, $11E0
    dw $1288, $128E, $1294, $129A, $12A0
    dw $1348, $134E, $1354, $135A, $1360
    dw $1408, $140E, $1414, $141A, $1420
}

; ==============================================================================

; $06FAFD-$06FB90 LOCAL JUMP LOCATION
HUD_UpdateItemBox:
{
    SEP #$30
    
    ; Dost thou haveth the the bow?
    LDA.l $7EF340 : BEQ .havethNoBow
        ; Dost thou haveth the silver arrows?
        CMP.b #$03 : BCC .havethNoSilverArrows 
            ; Draw the arrow guage icon as silver rather than normal wood
            ; arrows.
            LDA.b #$86 : STA.l $7EC71E
            LDA.b #$24 : STA.l $7EC71F
            LDA.b #$87 : STA.l $7EC720
            LDA.b #$24 : STA.l $7EC721
            
            LDX.b #$04
            
            ; Check how many arrows the player has.
            LDA.l $7EF377 : BNE .drawBowItemIcon
                LDX.b #$03
                
                BRA .drawBowItemIcon
        
        .havethNoSilverArrows
        
        LDX.b #$02
        
        LDA.l $7EF377 : BNE .drawBowItemIcon
            LDX.b #$01
        
        .drawBowItemIcon
        
        ; Values of X correspond to how the icon will end up drawn:
        ; 0x01 - normal bow with no arrows
        ; 0x02 - normal bow with arrows
        ; 0x03 - silver bow with no silver arrows
        ; 0x04 - silver bow with silver arrows
        TXA : STA.l $7EF340
    
    .havethNoBow
    
    REP #$30
    
    LDX.w $0202 : BEQ .noEquippedItem
        LDA.l $7EF33F, X : AND.w #$00FF : CPX.w #$0004 : BNE .bombsNotEquipped
            LDA.w #$0001
        
        .bombsNotEquipped
        
        CPX.w #$0010 : BNE .bottleNotEquipped
            TXY : TAX
            LDA.l $7EF35B, X : AND.w #$00FF : TYX
        
        .bottleNotEquipped
        
        STA.b $02

        ; Insert jump here check for 0x15 in X then branch off, interject GFX,
        ; and return to .noEquippedItem, otherwise insert the next line again 
        ; and return to LDA.w ItemMenu_ItemGFXPointers.
        TXA : DEC : ASL : TAX ; (x-1)*2.
        
        ; For fire rod (05), loads F6A1.
        LDA.w ItemMenu_ItemGFXPointers, X : STA.b $04
        
        LDA.b $02 : ASL #3 : TAY ; Loads 08.
        
        ; These addresses form the item box graphics. Fire rod loads: 24B0,
        ; 24B1, 24C0, 24C1 ; Ice rod loads: 2CB0, 2CBE, 2CC0, 2CC1.
        LDA.b ($04), Y : STA.l $7EC74A
        
        INY : INY
        LDA.b ($04), Y : STA.l $7EC74C
        
        INY : INY
        LDA.b ($04), Y : STA.l $7EC78A
        
        INY : INY
        LDA.b ($04), Y : STA.l $7EC78C
        
        INY : INY
    
    .noEquippedItem
    
    RTS
}

; ==============================================================================

; $06FB91-$06FCF9 LOCAL JUMP LOCATION
HUD_Update:
{
    JSR.w UpdateItemBox
    
    ; $06FB94 ALTERNATE ENTRY POINT
    .ignoreItemBox
    
    SEP #$30
    
    ; The hook for optimization was placed here...
    ; Need to draw partial heart still though. update: optimization complete
    ; with great results.
    LDA.b #$FD : STA.b $0A
    LDA.b #$F9 : STA.b $0B
    LDA.b #$0D : STA.b $0C
    
    LDA.b #$68 : STA.b $07
    LDA.b #$C7 : STA.b $08
    LDA.b #$7E : STA.b $09
    
    REP #$30
    
    ; Load Capacity health.
    LDA.l $7EF36C : AND.w #$00FF : STA.b $00
                                   STA.b $02
                                   STA.b $04
    
    ; First, just draw all the empty hearts (capacity health).
    JSR.w UpdateHearts
    
    SEP #$30
    
    LDA.b #$03 : STA.b $0A
    LDA.b #$FA : STA.b $0B
    LDA.b #$0D : STA.b $0C
    
    LDA.b #$68 : STA.b $07
    LDA.b #$C7 : STA.b $08
    LDA.b #$7E : STA.b $09
    
    ; Branch if at full health:
    LDA.l $7EF36C : CMP.l $7EF36D : BEQ .healthUpdated
        ; Seems absurd to have a branch of zero bytes, right?
        SEC : SBC.b #$04 : CMP.l $7EF36D : BCS .healthUpdated
    
    .healthUpdated
    
    ; A = actual health + 0x03;
    LDA.l $7EF36D : CLC : ADC.b #$03
    
    REP #$30
    
    AND.w #$00FC : STA.b $00
                   STA.b $04
    
    LDA.l $7EF36C : AND.w #$00FF : STA.b $02
    
    ; This time we're filling in the full and partially filled hearts (actual
    ; health).
    JSR.w UpdateHearts
    
    ; $06FC09 ALTERNATE ENTRY POINT
    .ignoreHealth
    
    REP #$30
    
    ; Magic amount indicator (normal, 1/2, or 1/4).
    LDA.l $7EF37B : AND.w #$00FF : CMP.w #$0001 : BCC .normalMagicMeter
        ; Draws a 1/2 magic meter (note, we could add in the 1/4 magic meter
        ; here if we really cared about that >_>).
        LDA.w #$28F7 : STA.l $7EC704
        LDA.w #$2851 : STA.l $7EC706
        LDA.w #$28FA : STA.l $7EC708
    
    .normalMagicMeter
    
    ; Check how much magic power the player has at the moment (ranges from 0 to
    ; 0x7F) X = ((MP & 0xFF)) + 7) & 0xFFF8).
    LDA.l $7EF36E : AND.w #$00FF : CLC : ADC.w #$0007 : AND.w #$FFF8 : TAX
    
    ; These four writes draw the magic power bar based on how much MP you
    ; have.
    LDA.w .mp_tilemap+0, X : STA.l $7EC746
    LDA.w .mp_tilemap+2, X : STA.l $7EC786
    LDA.w .mp_tilemap+4, X : STA.l $7EC7C6
    LDA.w .mp_tilemap+6, X : STA.l $7EC806
    
    ; Load how many rupees the player has.
    LDA.l $7EF362
    JSR.w HexToDecimal
    
    REP #$30
    
    ; The tile index for the first rupee digit.
    LDA.b $03 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC750
    
    ; The tile index for the second rupee digit.
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC752
    
    ; The tile index for the third rupee digit.
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC754
    
    ; Number of bombs Link has.
    LDA.l $7EF343 : AND.w #$00FF
    
    JSR.w HexToDecimal
    
    REP #$30
    
    ; The tile index for the first bomb digit.
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC758
    
    ; The tile index for the second bomb digit.
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC75A
    
    ; Number of Arrows Link has.
    LDA.l $7EF377 : AND.w #$00FF
    
    ; Converts hex to up to 3 decimal digits.
    JSR.w HexToDecimal
    
    REP #$30
    
    ; The tile index for the first arrow digit.
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC75E
    
    ; The tile index for the second arrow digit.
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC760
    
    LDA.w #$007F : STA.b $05
    
    ; Load number of Keys Link has.
    LDA.l $7EF36F : AND.w #$00FF : CMP.w #$00FF : BEQ .noKeys
        JSR.w HexToDecimal
    
    .noKeys
    
    REP #$30
    
    ; The key digit, which is optionally drawn.
    ; Also check to see if the key spot is blank.
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC764
    CMP.w #$247F : BNE .dontBlankKeyIcon
        ; If the key digit is blank, also blank out the key icon.
        STA.l $7EC724
    
    .dontBlankKeyIcon
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; Draws hearts in a painfully slow loop. I used DMA to speed it up in my custom
; code (but still needs fixing to work on 1/1/1 hardware).
; $06FDAB-006FDD8 LOCAL JUMP LOCATION
HUD_UpdateHearts:
{
    LDX.w #$0000
    
    .nextHeart
    
        LDA.b $00 : CMP.w #$0008 : BCC .lessThanOneHeart
            ; Notice no SEC was needed since carry is assumedly set.
            SBC.w #$0008 : STA.b $00
            
            LDY.w #$0004
            JSR.w UpdateHUDBuffer_DrawSingleHeart
            
            INX : INX
    BRA .nextHeart
    
    .lessThanOneHeart
    
    CMP.w #$0005 : BCC .halfHeartOrLess
        LDY.w #$0004
        
        BRA UpdateHUDBuffer_DrawSingleHeart
    
    .halfHeartOrLess
    
    CMP.w #$0001 : BCC .emptyHeart
        LDY.w #$0002
        
        BRA UpdateHUDBuffer_DrawSingleHeart
    
    .emptyHeart
    
    RTS
}

; $06FDD9-$06FDEE LOCAL JUMP LOCATION
UpdateHUDBuffer_DrawSingleHeart:
{
    ; Compare number of hearts so far on current line to 10.
    CPX.w #$0014 : BCC .noLineChange
        ; If not, we have to move down one tile in the tilemap.
        LDX.w #$0000
        
        LDA.b $07 : CLC : ADC.w #$0040 : STA.b $07
    
    .noLineChange
    
    LDA.b [$0A], Y
    
    TXY
    STA.b [$07], Y
    
    RTS
}

; ==============================================================================

; $06FDEF-$06FE76 DATA
HUD_Update_mp_tilemap:
{
    dw $3CF5, $3CF5, $3CF5, $3CF5
    dw $3CF5, $3CF5, $3CF5, $3C5F
    dw $3CF5, $3CF5, $3CF5, $3C4C
    dw $3CF5, $3CF5, $3CF5, $3C4D
    dw $3CF5, $3CF5, $3CF5, $3C4E
    dw $3CF5, $3CF5, $3C5F, $3C5E
    dw $3CF5, $3CF5, $3C4C, $3C5E
    dw $3CF5, $3CF5, $3C4D, $3C5E
    dw $3CF5, $3CF5, $3C4E, $3C5E
    dw $3CF5, $3C5F, $3C5E, $3C5E
    dw $3CF5, $3C4C, $3C5E, $3C5E
    dw $3CF5, $3C4D, $3C5E, $3C5E
    dw $3CF5, $3C4E, $3C5E, $3C5E
    dw $3C5F, $3C5E, $3C5E, $3C5E
    dw $3C4C, $3C5E, $3C5E, $3C5E
    dw $3C4D, $3C5E, $3C5E, $3C5E
    dw $3C4E, $3C5E, $3C5E, $3C5E    
}

; ==============================================================================

; $06FE77-$06FFC0
HUD_Rebuild_hud_tilemap:
{
    dw $207F, $207F, $2850, $A856
    dw $2852, $285B, $285B, $285C
    dw $207F, $3CA8, $207F, $207F
    dw $2C88, $2C89, $207F, $20A7
    dw $20A9, $207F, $2871, $207F
    dw $207F, $207F, $288B, $288F
    dw $24AB, $24AC, $688F, $688B
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $2871
    dw $2858, $207F, $207F, $285D
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $304E
    dw $2858, $207F, $207F, $285D
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $305E
    dw $2859, $A85B, $A85B, $A85C
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $305E
    dw $6854, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $A850, $2856
    dw $E850
}

; ==============================================================================
; End of Heads Up Display:
; ==============================================================================

; $06FFC1-$06FFFF NULL
NULL_0DFFC1:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $0E8000