; Player OAM Data

; =========================================================
; This holds data for Link's primary poses
; y, x, ab
;   y - y offset of head
;   x - x offset of head
;   a - head oam props high nibble
;   b - body oam props high nibble
;       F - don't draw
; =========================================================
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

; =========================================================

PlayerOam_AuxFlip:
{
    db $00, $00, $00, $40, $40, $48, $C0
    db $48, $C0, $48, $C0, $48, $C0, $40
}

; =========================================================
; These are OAM props and characters for 3 separate positions for the sword, and other weapons.
; $FFFF - do not draw
; =========================================================
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

; =========================================================
; These are OAM props and characters for 3 separate positions for the shield
; $FFFF - do not draw
; =========================================================
PlayerOam_ShieldTiles:
{
    dw $2A07, $FFFF, $FFFF ; down
    dw $2A07, $FFFF, $FFFF ; up
    dw $2A07, $FFFF, $FFFF ; right
    dw $6A07, $FFFF, $FFFF ; left

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

; =========================================================
; OAM props and tiles for shadows
; appears to be: formatted as:
;   ABCC
;   A - OAM props of left tile
;   B - OAM props of right tile
;   C - OAM char of both tiles
;
;  FFFF - no tile
; =========================================================
PlayerOam_ShadowTiles:
{
    dw $286C, $686C ; normal shadow
    dw $2828, $6828 ; small shadow
    dw $2838, $FFFF ; used while falling
    dw $286E, $686E ; unused and buggy
    dw $287E, $687E ; unused and buggy
    dw $24D8, $64D8 ; shallow water step 1
    dw $24D9, $64D9 ; shallow water step 2
    dw $24DA, $64DA ; shallow water step 3
    dw $22C8, $62C8 ; grass step 1
    dw $22C9, $62C9 ; grass step 2
    dw $22CA, $62CA ; grass step 3
}


; =========================================================
; These animation steps point to an index in PlayerOam_PoseData
; =========================================================
PlayerOam_AnimationSteps:
; walking
; charging dash
; index 0 used for standing still
    dw $0000, $00AE, $00AF, $00B0, $00B1, $00B2, $00B3, $00B4, $00B5 ; up
    dw $0005, $00B6, $00B7, $00B8, $00B9, $00B6, $00BA, $00BB, $00BC ; down
    dw $000A, $000A, $00BD, $00BE, $00BF, $00C0, $00C1, $00C2, $00C3 ; left
    dw $000D, $000D, $00C4, $00C5, $00C6, $00C7, $00C8, $00C9, $00CA ; right

; powder
    dw $0010, $0010, $0011, $0011, $0012, $0012, $0013, $0013, $0013 ; up
    dw $0014, $0014, $0015, $0015, $0016, $0016, $0017, $0017, $0017 ; down
    dw $0018, $0018, $0019, $0019, $001A, $001A, $001B, $001B, $001B ; left
    dw $001C, $001C, $001D, $001D, $001E, $001E, $001F, $001F, $001F ; right

; walking with sword out
    dw $0020, $0021, $0022, $0020, $0023, $0024 ; up
    dw $0025, $0026, $0027, $0025, $0028, $0029 ; down
    dw $002A, $002B, $002C, $002A, $002B, $002C ; left
    dw $002D, $002E, $002F, $002D, $002E, $002F ; right

; poking with sword
    dw $0031, $0030, $0032 ; up
    dw $0034, $0033, $0034 ; down
    dw $0036, $0035, $0037 ; left
    dw $0039, $0038, $003A ; right

; falling
    dw $003B, $003C, $003D, $003E, $003E, $003E

; landing in underworld
    dw $0000, $000D, $0005, $000A

; bonk
    dw $003F ; up
    dw $0040 ; down
    dw $0041 ; left
    dw $0042 ; right

; hammer
; rods
    dw $0043, $0044, $0045 ; up
    dw $0046, $0047, $0048 ; down
    dw $0049, $004A, $004B ; left
    dw $004C, $004D, $004E ; right

; bow
    dw $0000, $0021, $0074 ; up
    dw $0005, $0075, $0076 ; down
    dw $002A, $001A, $0077 ; left
    dw $002D, $001E, $0078 ; right

; boomerang
    dw $00A3, $00A4 ; up
    dw $00A5, $00A6 ; down
    dw $00A7, $001A ; left
    dw $00A8, $001E ; right

; tall grass
    dw $0000, $00CE, $00CF, $0000, $00A2, $0024 ; up
    dw $0005, $00D0, $00D1, $0005, $00D2, $00D3 ; down
    dw $000A, $00D4, $00D5, $000A, $00D4, $00D5 ; left
    dw $000D, $00D6, $00D7, $000D, $00D6, $00D7 ; right

; desert prayer
    dw $007D, $007E, $007F, $0080

; shovel
    dw $0053, $0054, $0055 ; left
    dw $0056, $0057, $0058 ; right

; walk carrying item
    dw $0059, $005A, $005B, $0059, $005C, $005D ; up
    dw $005E, $005F, $0060, $005E, $0061, $0062 ; down
    dw $0063, $0064, $0065, $0063, $0064, $0065 ; left
    dw $0066, $0067, $0068, $0066, $0067, $0068 ; right

; throwing item
; seems walk cycle based too
    dw $0020, $0021, $0022, $0020, $0023, $0024 ; up
    dw $0025, $0026, $0027, $0025, $0028, $0029 ; down
    dw $002A, $002B, $002C, $002A, $002B, $002C ; left
    dw $002D, $002E, $002F, $002D, $002E, $002F ; right

; spin attack
    dw $0069, $006A, $006B, $006B, $006C, $006C, $006D, $006D
    dw $000D, $000D, $006E, $006F, $0070, $0071, $0072, $0073

; lifting item
    dw $00D8, $00D9, $00D9 ; up
    dw $00DA, $00DB, $00DB ; down
    dw $00DC, $00DD, $00DD ; left
    dw $00DE, $00DF, $00DF ; right

; treading water
    dw $008E, $008F ; up
    dw $0090, $0091 ; down
    dw $0092, $0093 ; left
    dw $0094, $0095 ; right

; fast swim
    dw $0098, $0096, $0097, $0096 ; up
    dw $009B, $0099, $009A, $0099 ; down
    dw $009E, $009C, $009D, $009C ; left
    dw $00A1, $009F, $00A0, $009F ; right

; slow swim
    dw $0096, $0097, $0098 ; up
    dw $0099, $009A, $009B ; down
    dw $009C, $009D, $009E ; left
    dw $009F, $00A0, $00A1 ; right

; zap
    dw $00AB, $00AB, $00AC, $00AC ; up
    dw $00A9, $00A9, $00AA, $00AA ; down
    dw $00AB, $00AB, $00AC, $00AC ; left
    dw $00A9, $00A9, $00AA, $00AA ; right

; medallion spin
    dw $0025, $002A, $0020, $002D

; ether
    dw $006B, $00AD, $00AD, $00AD

; bombos
    dw $006B, $00CB, $00CB, $00CB, $00CB
    dw $00CC, $00CC, $00CC, $00A6, $00A6

; quake
    dw $006B, $00CB, $005E, $00CD, $00CD

; pushing
; last item seems unused?
    dw $00E0, $00E1, $00E2, $00E0, $00E3, $00E4 ; up
    dw $00E5, $00E6, $00E7, $00E5, $00E8, $00E9 ; down
    dw $00EA, $00EB, $00EC, $00EA, $00EB, $00EC ; left
    dw $00ED, $00EE, $00EF, $00ED, $00EE, $00EF ; right

; pull switch down
    dw $0101, $0117, $0117, $0117, $0117

; pull switch up
    dw $00F0, $00F1, $00FF, $005E

; ped pull
    dw $00DB, $00FF

; grabbing
    dw $0101, $0117, $0117, $0117 ; up
    dw $0104, $0118, $0118, $0118 ; down
    dw $0107, $0119, $0119, $0119 ; left
    dw $010A, $011A, $011A, $011A ; right

; walking up spiral stairs
    dw $00F5, $00F6, $00F7 ; lower
    dw $00F2, $00F3, $00F4 ; higher

; walking down spiral stairs
    dw $00FB, $00FC, $00FD ; higher
    dw $00F8, $00F9, $00FA ; lower

; death
    dw $0005, $000A, $0000, $000D, $0110, $0111

; unused? arm swing
    dw $0000, $0021, $0074 ; up
    dw $0005, $0075, $0076 ; down
    dw $002A, $001A, $0077 ; left
    dw $002D, $001E, $0078 ; right

; item gets
    dw $0112 ; normal
    dw $0113 ; crystal/triforce

; sleep
    dw $0114, $0115

; hookshot
    dw $0012 ; up
    dw $0016 ; down
    dw $001A ; left
    dw $001E ; right

; bunny walk
; first frame used for standing still
    dw $011B, $011C, $011B, $011D ; up
    dw $011E, $011F, $011E, $0120 ; down
    dw $0121, $0122, $0121, $0122 ; left
    dw $0123, $0124, $0123, $0124 ; right

; cane
    dw $006F, $0125, $0126 ; up
    dw $006A, $00CB, $0048 ; down
    dw $0071, $0063, $001A ; left
    dw $0127, $0066, $001E ; right

; net
    dw $0069 ; this first pose is unreachable
    dw $00CB, $006B, $000A, $000A, $006D
    dw $006D, $000D, $000D, $0070, $0072, $006E

; sword up
    dw $00CB

; book
    dw $0129

; tree pull
    dw $012B, $012C, $012D, $012E, $003F

; sword slash
    dw $0010, $0010, $004F, $004F, $0126, $0050, $0126, $0013, $0013 ; up
    dw $0014, $0014, $0015, $0015, $0051, $0052, $0051, $0017, $0017 ; down
    dw $0018, $0018, $0019, $0082, $0083, $0084, $0085, $0086, $0086 ; left
    dw $001C, $001C, $001D, $0079, $007A, $007B, $007C, $0081, $0081 ; right

; =========================================================

PlayerOam_Aux1GFXIndex:
; falling
    db $00, $FF, $FF, $02, $03, $04, $FF

; landing in underworld
    db $FF, $FF, $FF

; lifting item
    db $FF, $15, $17 ; up
    db $FF, $15, $17 ; down
    db $FF, $16, $18 ; left
    db $FF, $15, $17 ; right

; fast swim
    db $13, $0B, $0F, $FF ; up
    db $11, $09, $0D, $FF ; down
    db $09, $12, $0D, $FF ; left
    db $0A, $11, $0F, $FF ; right

; medallion spin
    db $FF, $FF, $FF, $FF

; ether
    db $FF, $FF, $FF, $FF

; bombos
    db $FF, $FF, $FF, $04, $03
    db $FF, $FF, $FF, $FF, $FF

; quake
    db $FF, $FF, $FF, $FF, $FF

; pull switch down
    db $FF, $17, $17, $FF, $FF

; pull switch up
    db $FF, $FF, $FF, $FF

; ped pull
    db $FF, $FF

; grabbing
    db $FF, $17, $17, $FF ; up
    db $FF, $15, $15, $FF ; down
    db $FF, $18, $18, $FF ; left
    db $FF, $17, $17, $FF ; right

; sword slash
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $1A, $1A, $1A, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $19, $19, $19, $FF, $FF ; right

; =========================================================

PlayerOam_Aux2GFXIndex:
; falling
    db $01, $FF, $FF, $FF, $FF, $FF, $FF

; landing in underworld
    db $FF, $FF, $FF

; lifting item
    db $FF, $16, $18 ; up
    db $FF, $16, $18 ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; fast swim
    db $14, $0C, $10, $FF ; up
    db $12, $0A, $0E, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; medallion spin
    db $FF, $FF, $FF, $FF

; ether
    db $FF, $FF, $FF, $FF

; bombos
    db $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF

; quake
    db $FF, $FF, $FF, $FF, $FF

; pull switch down
    db $FF, $18, $18, $FF, $FF

; pull switch up
    db $FF, $FF, $FF, $FF

; ped pull
    db $FF, $FF

; grabbing
    db $FF, $18, $18, $FF ; up
    db $FF, $16, $16, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; sword slash
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; right

; =========================================================

PlayerOam_WeaponGFXIndex:
; walking
; charging dash
; index 0 used for standing still
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; right

; powder
    db $01, $05, $0E, $1A, $06, $08, $10, $14, $00 ; up
    db $00, $02, $0D, $19, $07, $0B, $13, $17, $01 ; down
    db $06, $08, $10, $14, $00, $02, $0D, $19, $07 ; left
    db $06, $0A, $12, $16, $01, $04, $0F, $1B, $07 ; right

; walking with sword out
    db $0A, $0A, $0A, $0A, $0A, $0A ; up
    db $09, $09, $09, $09, $09, $09 ; down
    db $00, $00, $00, $00, $00, $00 ; left
    db $01, $01, $01, $01, $01, $01 ; right

; poking with sword
    db $06, $0A, $06 ; up
    db $07, $09, $07 ; down
    db $00, $00, $00 ; left
    db $01, $01, $01 ; right

; falling
    db $FF, $FF, $FF, $FF, $FF, $FF

; landing in underworld
    db $FF, $FF, $FF, $FF

; bonk
    db $08 ; up
    db $0A ; down
    db $0A ; left
    db $08 ; right

; hammer
; rods
    db $20, $1D, $21 ; up
    db $1D, $22, $1E ; down
    db $1F, $25, $26 ; left
    db $1F, $23, $24 ; right

; bow
    db $2A, $27, $27 ; up
    db $29, $28, $28 ; down
    db $2C, $2A, $2A ; left
    db $2D, $29, $29 ; right

; boomerang
    db $FF, $FF ; up
    db $FF, $FF ; down
    db $FF, $FF ; left
    db $FF, $FF ; right

; tall grass
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; desert prayer
    db $FF, $FF, $FF, $FF

; shovel
    db $31, $31, $32 ; left
    db $2F, $2F, $30 ; right

; walk carrying item
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; throwing item
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; spin attack
    db $0A, $08, $05, $04, $0B, $09, $02, $03
    db $08, $0A, $09, $0B, $04, $05, $03, $02

; lifting item
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; treading water
    db $FF, $FF ; up
    db $FF, $FF ; down
    db $FF, $FF ; left
    db $FF, $FF ; right

; fast swim
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; slow swim
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; zap
    db $FF, $00, $03, $03 ; up
    db $FF, $01, $05, $05 ; down
    db $FF, $00, $03, $03 ; left
    db $FF, $01, $05, $05 ; right

; medallion spin
    db $09, $02, $06, $04

; ether
    db $04, $0A, $06, $06

; bombos
    db $0A, $06, $08, $08, $08
    db $01, $04, $0F, $0B, $07

; quake
    db $04, $0A, $06, $07, $1C

; pushing
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; pull switch down
    db $FF, $FF, $FF, $FF, $FF

; pull switch up
    db $FF, $FF, $FF, $FF

; ped pull
    db $FF, $FF

; grabbing
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; walking up spiral stairs
    db $FF, $FF, $FF ; lower
    db $FF, $FF, $FF ; higher

; walking down spiral stairs
    db $FF, $FF, $FF ; higher
    db $FF, $FF, $FF ; lower

; death
    db $FF, $FF, $FF, $FF, $FF, $FF

; unused? arm swing
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; item gets
    db $FF ; normal
    db $FF ; crystal/triforce

; sleep
    db $FF, $FF

; hookshot
    db $33 ; up
    db $34 ; down
    db $35 ; left
    db $36 ; right

; bunny walk
; first frame used for standing still
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; cane
    db $44, $44, $46 ; up
    db $44, $44, $43 ; down
    db $47, $44, $4A ; left
    db $49, $45, $48 ; right

; net
    db $37
    db $37, $38, $39, $3A, $3B
    db $3C, $3D, $3E, $3F, $40, $41

; sword up
    db $06

; book
    db $4B

; tree pull
    db $FF, $FF, $FF, $FF, $FF

; sword slash
    db $01, $05, $0E, $1A, $0A, $06, $08, $10, $14 ; up
    db $00, $02, $0D, $19, $09, $07, $0B, $13, $17 ; down
    db $06, $08, $10, $14, $03, $00, $02, $0D, $19 ; left
    db $06, $0A, $12, $16, $05, $01, $04, $0F, $1B ; right

; =========================================================

PlayerOam_ShieldGFXIndex:
; walking
; charging dash
; index 0 used for standing still
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; up
    db $00, $00, $00, $00, $00, $00, $00, $00, $00 ; down
    db $03, $03, $03, $03, $03, $03, $03, $03, $03 ; left
    db $02, $02, $02, $02, $02, $02, $02, $02, $02 ; right

; powder
    db $00, $00, $00, $00, $02, $02, $02, $02, $02 ; up
    db $01, $01, $01, $01, $03, $03, $03, $03, $03 ; down
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; left
    db $01, $01, $01, $01, $01, $01, $01, $01, $01 ; right

; walking with sword out
    db $02, $02, $02, $02, $02, $02 ; up
    db $03, $03, $03, $03, $03, $03 ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; poking with sword
    db $02, $02, $02 ; up
    db $03, $03, $03 ; down
    db $01, $01, $01 ; left
    db $01, $01, $01 ; right

; falling
    db $FF, $FF, $FF, $FF, $FF, $FF

; landing in underworld
    db $FF, $FF, $FF, $FF

; bonk
    db $01 ; up
    db $00 ; down
    db $01 ; left
    db $01 ; right

; hammer
; rods
    db $02, $02, $02 ; up
    db $03, $03, $03 ; down
    db $01, $01, $01 ; left
    db $01, $01, $01 ; right

; bow
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; boomerang
    db $01, $02 ; up
    db $00, $03 ; down
    db $03, $01 ; left
    db $02, $01 ; right

; tall grass
    db $01, $01, $01, $01, $01, $01 ; up
    db $00, $00, $00, $00, $00, $00 ; down
    db $03, $03, $03, $03, $03, $03 ; left
    db $02, $02, $02, $02, $02, $02 ; right

; desert prayer
    db $FF, $FF, $FF, $FF

; shovel
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; walk carrying item
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; throwing item
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; spin attack
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

; lifting item
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; treading water
    db $FF, $FF ; up
    db $FF, $FF ; down
    db $FF, $FF ; left
    db $FF, $FF ; right

; fast swim
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; slow swim
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; zap
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; medallion spin
    db $00, $03, $01, $02

; ether
    db $00, $00, $00, $00

; bombos
    db $00, $00, $00, $00, $00
    db $03, $03, $03, $03, $03

; quake
    db $00, $00, $03, $00, $00

; pushing
    db $FF, $FF, $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF ; right

; pull switch down
    db $FF, $FF, $FF, $FF, $FF

; pull switch up
    db $FF, $FF, $FF, $FF

; ped pull
    db $FF, $FF

; grabbing
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; walking up spiral stairs
    db $FF, $FF, $FF ; lower
    db $FF, $FF, $FF ; higher

; walking down spiral stairs
    db $FF, $FF, $FF ; higher
    db $FF, $FF, $FF ; lower

; death
    db $FF, $FF, $FF, $FF, $FF, $FF

; unused? arm swing
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; item gets
    db $03 ; normal
    db $FF ; crystal/triforce

; sleep
    db $FF, $FF

; hookshot
    db $02 ; up
    db $03 ; down
    db $FF ; left
    db $FF ; right

; bunny walk
; first frame used for standing still
    db $FF, $FF, $FF, $FF ; up
    db $FF, $FF, $FF, $FF ; down
    db $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF ; right

; cane
    db $FF, $FF, $FF ; up
    db $FF, $FF, $FF ; down
    db $FF, $FF, $FF ; left
    db $FF, $FF, $FF ; right

; net
    db $FF
    db $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF

; sword up
    db $FF

; book
    db $FF

; tree pull
    db $FF, $FF, $FF, $FF, $FF

; sword slash
    db $02, $02, $02, $02, $02, $02, $02, $02, $02 ; up
    db $03, $03, $03, $03, $03, $03, $03, $03, $03 ; down
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; left
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; right

; =========================================================

PlayerOam_Aux1Offset_Y:
; falling
    db   0,  -1,  -1,   8,   8,   8,  -1

; landing in underworld
    db  -1,  -1,  -1

; lifting item
    db  -1,   7,  10 ; up
    db  -1,   5,   8 ; down
    db  -1,   8,  12 ; left
    db  -1,   8,  12 ; right

; fast swim
    db   2,   7,  13,  -1 ; up
    db  20,  14,   7,  -1 ; down
    db  20,  21,  20,  -1 ; left
    db  20,  21,  20,  -1 ; right

; medallion spin
    db  -1,  -1,  -1,  -1

; ether
    db  -1,  -1,  -1,  -1

; bombos
    db  -1,  -1,  -1,  -8,  -8
    db  -1,  -1,  -1,  -1,  -1

; quake
    db  -1,  -1,  -1,  -1,  -1

; pull switch down
    db  -1,   5,  11,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,   5,  11,  -1 ; up
    db  -1,   6,   1,  -1 ; down
    db  -1,  13,  15,  -1 ; left
    db  -1,  13,  15,  -1 ; right

; sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  12,  12,  12,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  12,  12,  12,  -1,  -1 ; right

; =========================================================

PlayerOam_Aux1Offset_X:
; falling
    db   8,  -1,  -1,   4,   4,   4,  -1

; landing in underworld
    db  -1,  -1,  -1

; lifting item
    db  -1,  -7,  -9 ; up
    db  -1,  -8, -10 ; down
    db  -1,  13,  16 ; left
    db  -1,  -5,  -8 ; right

; fast swim
    db  -2,  -6,  -5,  -1 ; up
    db  -1,  -5,  -6,  -1 ; down
    db  -3,   4,   9,  -1 ; left
    db  11,   4,  -1,  -1 ; right

; medallion spin
    db  -1,  -1,  -1,  -1

; ether
    db  -1,  -1,  -1,  -1

; bombos
    db  -1,  -1,  -1,   4,   4
    db  -1,  -1,  -1,  -1,  -1

; quake
    db  -1,  -1,  -1,  -1,  -1

; pull switch down
    db  -1,  -5,  -8,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,  -5,  -8,  -1 ; up
    db  -1,  -5,  -8,  -1 ; down
    db  -1,  15,  17,  -1 ; left
    db  -1,  -7,  -9,  -1 ; right

; sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -3,  -7,  -3,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  11,  15,  11,  -1,  -1 ; right

; =========================================================

PlayerOam_Aux2Offset_Y:
; falling
    db  16,  -1,  -1,  -1,  -1,  -1,  -1

; landing in underworld
    db  -1,  -1,  -1

; lifting item
    db  -1,   7,  10 ; up
    db  -1,   5,   8 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; fast swim
    db   2,   7,  13,  -1 ; up
    db  20,  14,   7,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; medallion spin
    db  -1,  -1,  -1,  -1

; ether
    db  -1,  -1,  -1,  -1

; bombos
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1

; quake
    db  -1,  -1,  -1,  -1,  -1

; pull switch down
    db  -1,   5,  11,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,   5,  11,  -1 ; up
    db  -1,   6,   1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; right

; =========================================================

PlayerOam_Aux2Offset_X:
; falling
    db  -8,  -1,  -1,  -1,  -1,  -1,  -1

; landing in underworld
    db  -1,  -1,  -1

; lifting item
    db  -1,  15,  17 ; up
    db  -1,  16,  18 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; fast swim
    db  10,  14,  13,  -1 ; up
    db   9,  14,  14,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; medallion spin
    db  -1,  -1,  -1,  -1

; ether
    db  -1,  -1,  -1,  -1

; bombos
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1

; quake
    db  -1,  -1,  -1,  -1,  -1

; pull switch down
    db  -1,  13,  16,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,  13,  16,  -1 ; up
    db  -1,  13,  16,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; sword slash
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 ; right

; =========================================================

PlayerOam_ShieldOffsetY:
; walking
; charging dash
; index 0 used for standing still
    db   5,   5,   4,   3,   5,   5,   4,   3,   5 ; up
    db   9,  10,   9,   7,   8,  10,   9,   7,   8 ; down
    db   5,   5,   4,   3,   4,   5,   4,   3,   4 ; left
    db   5,   5,   4,   3,   4,   5,   4,   3,   4 ; right

; powder
    db  12,  12,   8,   8,   6,   6,   6,   6,   6 ; up
    db   1,   1,   3,   3,   7,   7,   7,   7,   7 ; down
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; left
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; right

; walking with sword out
    db   5,   6,   7,   5,   6,   7 ; up
    db   6,   7,   8,   6,   7,   8 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; poking with sword
    db   7,   5,   7 ; up
    db   7,   8,   7 ; down
    db   5,   5,   5 ; left
    db   5,   5,   5 ; right

; falling
    db  16,  -1,  -1,  -1,  -1,  -1

; landing in underworld
    db  -1,  -1,  -1,  -1

; bonk
    db   5 ; up
    db   8 ; down
    db   7 ; left
    db   7 ; right

; hammer
; rods
    db   6,   5,   5 ; up
    db   7,   7,   7 ; down
    db   5,   5,   5 ; left
    db   5,   5,   5 ; right

; bow
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; boomerang
    db   6,   6 ; up
    db  11,   7 ; down
    db   4,   8 ; left
    db   4,   8 ; right

; tall grass
    db   4,   5,   6,   4,   5,   6 ; up
    db  10,  11,  12,  10,  11,  12 ; down
    db   5,   6,   7,   5,   6,   7 ; left
    db   5,   6,   7,   5,   6,   7 ; right

; desert prayer
    db  -1,  -1,  -1,  -1

; shovel
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; walk carrying item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; throwing item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; spin attack
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1

; lifting item
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; treading water
    db  -1,  -1 ; up
    db  -1,  -1 ; down
    db  -1,  -1 ; left
    db  -1,  -1 ; right

; fast swim
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; slow swim
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; zap
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; medallion spin
    db  10,   5,   4,   5

; ether
    db  10,  10,  10,  10

; bombos
    db  10,  10,  10,  10,  10
    db   7,   7,   7,   7,   7

; quake
    db  10,  10,   1,  10,  10

; pushing
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; pull switch down
    db  -1,  -1,  -1,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; walking up spiral stairs
    db  -1,  -1,  -1 ; lower
    db  -1,  -1,  -1 ; higher

; walking down spiral stairs
    db  -1,  -1,  -1 ; higher
    db  -1,  -1,  -1 ; lower

; death
    db  -1,  -1,  -1,  -1,  -1,  -1

; unused? arm swing
    db   5,   5,   5 ; up
    db   7,   7,   7 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; item gets
    db   9 ; normal
    db  -1 ; crystal/triforce

; sleep
    db  -1,  -1

; hookshot
    db   5 ; up
    db   7 ; down
    db  -1 ; left
    db  -1 ; right

; bunny walk
; first frame used for standing still
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; cane
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; net
    db  -1
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1

; sword up
    db  -1

; book
    db  -1

; tree pull
    db  -1,  -1,  -1,  -1,  -1

; sword slash
    db   8,   8,   6,   6,   4,   2,   5,   6,   6 ; up
    db   1,   1,   4,   4,   6,   8,   6,   6,   6 ; down
    db   4,   4,   4,   4,   4,   4,   4,   4,   4 ; left
    db   4,   4,   4,   4,   4,   4,   4,   4,   4 ; right

; =========================================================

PlayerOam_ShieldOffsetX:
; walking
; charging dash
; index 0 used for standing still
    db   5,   5,   5,   5,   5,   5,   5,   5,   5 ; up
    db  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4 ; down
    db  -8,  -8,  -8,  -8,  -8,  -8,  -8,  -8,  -8 ; left
    db   8,   8,   8,   8,   8,   8,   8,   8,   8 ; right

; powder
    db   6,   6,   8,   8,  10,  10,  10,  10,  10 ; up
    db  -5,  -5,  -7,  -7, -10, -10, -10, -10, -10 ; down
    db   1,   1,   1,   1,   0,   0,   0,   0,   0 ; left
    db  -1,  -1,  -1,  -1,   0,   0,   0,   0,   0 ; right

; walking with sword out
    db   9,   9,   9,   9,   9,   9 ; up
    db  -9,  -9,  -9,  -9,  -9,  -9 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; poking with sword
    db  10,  10,  10 ; up
    db -10, -10, -10 ; down
    db   0,  -1,   0 ; left
    db   0,   1,   0 ; right

; falling
    db  -4,  -1,  -1,  -1,  -1,  -1

; landing in underworld
    db  -1,  -1,  -1,  -1

; bonk
    db   8 ; up
    db  -4 ; down
    db   2 ; left
    db  -3 ; right

; hammer
; rods
    db   9,   9,   9 ; up
    db -10, -10, -10 ; down
    db   0,   0,   0 ; left
    db   0,   0,   0 ; right

; bow
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; boomerang
    db   5,   9 ; up
    db  -4, -10 ; down
    db   0,   0 ; left
    db   8,   0 ; right

; tall grass
    db   5,   5,   5,   5,   5,   5 ; up
    db  -4,  -4,  -4,  -4,  -4,  -4 ; down
    db  -8,  -8,  -8,  -8,  -8,  -8 ; left
    db   8,   8,   8,   8,   8,   8 ; right

; desert prayer
    db  -1,  -1,  -1,  -1

; shovel
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; walk carrying item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; throwing item
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; spin attack
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1

; lifting item
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; treading water
    db  -1,  -1 ; up
    db  -1,  -1 ; down
    db  -1,  -1 ; left
    db  -1,  -1 ; right

; fast swim
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; slow swim
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; zap
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; medallion spin
    db  -4,  -8,   5,   8

; ether
    db  -4,  -4,  -4,  -4

; bombos
    db  -5,  -5,  -5,  -5,  -5
    db -10, -10, -10, -10, -10

; quake
    db  -5,  -5,  -7,  -4,  -4

; pushing
    db  -1,  -1,  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1,  -1,  -1 ; right

; pull switch down
    db  -1,  -1,  -1,  -1,  -1

; pull switch up
    db  -1,  -1,  -1,  -1

; ped pull
    db  -1,  -1

; grabbing
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; walking up spiral stairs
    db  -1,  -1,  -1 ; lower
    db  -1,  -1,  -1 ; higher

; walking down spiral stairs
    db  -1,  -1,  -1 ; higher
    db  -1,  -1,  -1 ; lower

; death
    db  -1,  -1,  -1,  -1,  -1,  -1

; unused? arm swing
    db   9,   9,   9 ; up
    db -10, -10, -10 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; item gets
    db  -6 ; normal
    db  -1 ; crystal/triforce

; sleep
    db  -1,  -1

; hookshot
    db  10 ; up
    db -10 ; down
    db  -1 ; left
    db  -1 ; right

; bunny walk
; first frame used for standing still
    db  -1,  -1,  -1,  -1 ; up
    db  -1,  -1,  -1,  -1 ; down
    db  -1,  -1,  -1,  -1 ; left
    db  -1,  -1,  -1,  -1 ; right

; cane
    db  -1,  -1,  -1 ; up
    db  -1,  -1,  -1 ; down
    db  -1,  -1,  -1 ; left
    db  -1,  -1,  -1 ; right

; net
    db  -1
    db  -1,  -1,  -1,  -1,  -1
    db  -1,  -1,  -1,  -1,  -1,  -1

; sword up
    db  -1

; book
    db  -1

; tree pull
    db  -1,  -1,  -1,  -1,  -1

; sword slash
    db  10,  10,  10,  10,  10,  10,  10,  10,  10 ; up
    db  -9,  -9,  -9,  -9, -10, -10, -10, -10, -10 ; down
    db   1,   1,   1,   2,   2,   2,   1,   2,   2 ; left
    db  -1,  -1,  -1,  -2,  -2,  -2,  -1,  -2,  -2 ; right

; =========================================================

PlayerOam_ShadowOffset_Y:
    db  16,  16,  17,  17
    db  16,  16,  16,  16
    db  18,  18,  18,  18

; =========================================================

PlayerOam_ShadowOffset_X:
    db   0,   0,  -1,   1
    db   0,   0,   0,   0
    db   0,   0,   0,   0

; =========================================================
    
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

; $069CF1-$069EEF DATA
; walking
; charging dash
; index 0 used for standing still
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
; up
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

; down
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

; left
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

; right
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
    ; up, down, left, right 
    dw $0000, $0050, $00A0, $00F0
}

; $06A038-$06A045 DATA
; falling, lifting item, swim, medallions, pull switch, grabbing, sword slashQ
PlayerOam_AuxAnimationStepDataOffset:
{
    dw $0000, $000A, $0016, $0026, $003D, $0048, $0058 ; up 

    dw $0000, $000D, $001A, $0026, $003D, $004C, $0061 ; down 
    
    dw $0000, $0010, $001E, $0026, $003D, $0050, $006A ; left 
    
    dw $0000, $0013, $0022, $0026, $003D, $0054, $0073 ; right 
}

; $06A070-$06A077 DATA
PlayerOam_AuxAnimationDirectionalStepIndexOffset:
{
    dw $0000, $000E, $001C, $002A
}
    
; $06A078-$06A107 DATA
PlayerOam_Aux1BufferOffsets_SetA:
{
    db $00, $08, $00, $08, $08, $0C, $14, $08
    db $08, $00, $00, $00
}

; $6A084
PlayerOam_Aux2BufferOffsets_SetA:
{
    db $04, $0C, $04, $0C, $0C, $10, $18, $0C
    db $0C, $0C, $04, $04
}

; $6A090
PlayerOam_WeaponBufferOffsets_SetA:
{
    db $08, $10, $10, $18, $10, $00, $00, $10
    db $18, $10, $18, $10
}

; $6A09C
PlayerOam_ElfBufferOffsets_SetA:
{
    db $14, $1C, $08, $10, $00, $14, $18, $00
    db $10, $04, $10, $1C
}

; $6A0A8
PlayerOam_ShieldBufferOffsets_SetA:
{
    db $1C, $00, $1C, $00, $18, $1C, $0C, $1C
    db $24, $1C, $08, $08
}

; $6A0B4
PlayerOam_ShadowBufferOffsets_SetA:
{
    db $28, $28, $28, $28, $28, $28, $28, $28
    db $00, $28, $28, $28
}

; $6A0C0
PlayerOam_Aux1BufferOffsets_SetB:
{
    db $14, $1C, $08, $10, $10, $14, $1C, $10
    db $08, $08, $08, $14
}

; $6A0CC
PlayerOam_Aux2BufferOffsets_SetB:
{
    db $18, $20, $0C, $14, $14, $18, $20, $14
    db $0C, $14, $0C, $18
}

; $6A0D8
PlayerOam_WeaponBufferOffsets_SetB:
{
    db $00, $00, $18, $20, $18, $00, $00, $18
    db $18, $18, $20, $00
}

; $6A0E4
PlayerOam_ElfBufferOffsets_SetB:
{
    db $1C, $24, $10, $18, $08, $1C, $24, $08
    db $10, $0C, $18, $24
}

; $60AF0
PlayerOam_ShieldBufferOffsets_SetB:
{
    db $24, $14, $24, $08, $20, $24, $14, $24
    db $24, $24, $10, $1C
}

; $6A0FC
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
    
; $6A10C
PlayerOam_Aux2BufferOffsetPointers:
{
    dw $A084, $A0CC
}

; $06A110 DATA
PlayerOam_WeaponBufferOffsetPointers:
{
    dw $A090, $A0D8
}

; $6A114
PlayerOam_ElfBufferOffsetPointers:
{
    dw $A09C, $A0E4
}
    
; $6A118
PlayerOam_ShieldBufferOffsetPointers:
{
    dw $A0A8, $A0F0
}
    
; $6A11C
PlayerOam_ShadowBufferOffsetPointers:
{
    dw $A0B4, $A0FC
}

; $06A120-$06A123
{
    dw $0190, $00E0
}

; $06A126-$06A12D
{
    dw $2000, $1000, $3000, $2000
}

; $06A120-$06A123 DATA
{
    ; Two possible offsets into OAM buffer for player sprite.
    dw $0190, $00E0
}

; $06A124-$06A125 DATA
{
    ; Another optional offset into the OAM buffer for the player sprite.
    dw $0000
}

; $06A126-$06A12D DATA
{
    dw $2000, $1000, $3000, $2000
}

; $06A12E-$06A130 DATA
PlayerOam_RodTypeID:
{
    ; Has to do with fire rod and ice rod oam handling...
    db $02, $04, $04
}

; $06A131-$06A139 DATA
PlayerOam_StairsSomething:
{
    db $00, $01, $02, $00, $01, $02, $00, $01, $02
}

; $06A13A-$06A141 DATA
PlayerOam_ItemsAUseIndex:
{
    ; rod, hammer, n/a, n/a, bow, n/a, powder, boomerang
    db $06, $06, $06, $06, $07, $07, $08, $09
}

; $06A142-$06A147 DATA
PlayerOam_ItemsBUseIndex:
{
    ; shovel, unused prayer, hookshot, cane, net, book
    db $0C, $0B, $20, $22, $23, $25
}

; $06A148-$06A14F DATA
PlayerOam_WeirdGrabIndices:
{
    ; Methinks the 0x26 belongs to the previous array...?
    db $26, $0B, $0B, $0C, $0B, $0B, $0B, $0D
}

; $06A150-$06A15D DATA
PlayerOam_AnimationsWithAuxParts:
{
    ; Special poses to check for?
    dw $0004, $0010, $0012, $0015, $0017, $0018, $0027
}

; $6A15E
PlayerOam_StraightStairsYOffset:
{
    dw  0, -2, -3,  0, -2, -3
    dw  0,  0,  0,  0,  0,  0
    
; $6A176

    dw  0, -2, -3,  0, -2, -3
    dw  0,  0,  0,  0,  0,  0
}
    
; $06A18E-$06AAC2 LONG JUMP LOCATION
PlayerOam_Main:
{
    ; $72 = 0x00 if not standing in water or grass, 0x02 otherwise
    
    PHB : PHK : PLB
    
    LDY.b #$00
    
    LDA $11 : CMP.b #$12 : BEQ .on_straight_interroom_staircase
    
    LDY.b #$18
    
    ; Checks for submodules 0x12 and 0x13
    CMP.b #$13 : BNE .not_on_straight_interroom_staircase

.on_straight_interroom_staircase

    STY $00
    
    LDA $20 : PHA
    LDA $21 : PHA
    
    LDY.b #$00
    
    LDA $0462 : AND.b #$04 : BEQ .is_straight_up_staircase
    
    LDY.b #$0C

.is_straight_up_staircase

    TYA : CLC : ADC $00 : STA $00
    
    ; Link's frame index shouldn't be more than 5 on this kind of staircase.
    LDA $2E : CMP.b #$06 : BCC .frame_index_in_range
    
    LDA.b #$00

.frame_index_in_range

    ASL A : CLC : ADC $00 : TAY
    
    REP #$20
    
    ; Ultimately, we have determined an offset to be applied to the player's
    ; Y coordinate, just for the sake of sprite display. The value of the Y
    ; coordinate will be restored near the end of this routine.
    LDA PlayerOam_StraightStairsYOffset, Y : CLC : ADC $20 : STA $20
    
    SEP #$20

.not_on_straight_interroom_staircase

    ; Assumes this is not submodule 0x12 or 0x13
    
    LDA $20 : SEC : SBC $E8 : STA $01
    LDA $22 : SEC : SBC $E2 : STA $00
    
    LDA.b #$80 : STA $45 : STA $44
    
    LDX.b #$00
    
    ; Check if we need to draw grass or water around Link (he'd be standing in one of those)
    LDA $0351 : BEQ .not_in_water_or_grass
    
    LDX.b #$01

.not_in_water_or_grass

    ; 0 or 1, eh?...
    TXA : ASL A : STA $72 : STZ $73
    
    REP #$20
    
    LDA.b $EE : AND.w #$00FF : ASL A : TAX
    
    ; Determine OAM priority from floor level the player is on
    ; (BG2 -> 0x2000, BG1 -> 0x1000, there's two other settings but not clear what they're used for.)
    LDA.w PlayerOam_ObjectPriority, X : STA.b $64
    
    ; Check "sort sprites" setting (HM name)
    LDA.w $0FB3 : ASL A : TAY
    
    ; "sort sprites" here serves as a selector for where
    ; in the OAM buffer we want to start entering in sprite data for the player. (0x0190 or 0x00E0)
    LDA.w PlayerOam_OAMBufferOffset, Y : STA.w $0352
    
    SEP #$20
    
    ; Is Link asleep in bed (starting sequence)?
    LDA $5D : CMP.b #$16 : BNE .notInBed
    
    LDY.b #$1F
    
    LDA $037D : CMP.b #$02 : BEQ .notInBed
    
    STA $02
    
    BRL .PlayerOam_ContinueWithAnimation

.notInBed

    LDA $03EF : BEQ .notHoldingUpSword
    
    LDY.b #$24
    
    STZ $02
    
    LDA $2F : STA $0323
    
    BRL .PlayerOam_ContinueWithAnimation

.notHoldingUpSword

    LDA $02E0 : BEQ .not_transforming
    
    LDY.b #$21
    
    LDA $2E : AND.b #$03 : STA $02
    
    LDA $2F : STA $0323
    
    BRL .PlayerOam_ContinueWithAnimation

.not_transforming

    LDY.b #$00
    
    LDA $0351 : BEQ .not_in_water_or_grass_2
    
    LDY.b #$0A

.not_in_water_or_grass_2

    LDA $11 : CMP.b #$0E : BNE .BRANCH_MU
    
    ; Is the player dead / dying?
    LDA $10 : CMP.b #$12 : BEQ .BRANCH_MU
    
    LDY.b #$0A
    
    LDA $28 : BEQ .BRANCH_MU
    
    LDX $2F
    
    CPX.b #$04 : BEQ .facing_left_or_right
    CPX.b #$06 : BEQ .facing_left_or_right
    
    LDX $2E
    
    LDA.w $A131, X : STA $02
    
    LDY.b #$19
    
    LDA $0462 : AND.b #$04 : BEQ .is_up_spiral_staircase
    
    LDY.b #$1A
    
    BRA .BRANCH_XI

.BRANCH_MU

    LDA $0376 : AND.b #$03 : BEQ .notGrabbingWall
    
    LDY.b #$18
    
    LDA $030A : STA $02
    
    BRA .BRANCH_XI

.notGrabbingWall

    LDA $48 : AND.b #$0D : BEQ .not_feeling_grabby
    
    LDY.b #$16
    
    LDA $2E : CMP.b #$05 : BCC .not_feeling_grabby
    
    STZ $2E

.not_feeling_grabby
.facing_left_or_right

    LDA $2E : STA $02

.is_up_spiral_staircase
.BRANCH_XI

    LDA $2F : STA $0323
    
    LDA $0345 : BEQ .not_in_deep_water
    
    ; Force to priority level 2 if we're in deep water.
    LDA.b #$20 : STA $65 : STZ $64

.not_in_deep_water

    LDA $5D : CMP.b #$04 : BNE .not_swimming
    
    LDY.b #$11
    
    LDA $02 : AND.b #$01 : STA $02
    
    LDA $11 : BNE .skip_stroke_check
    
    ; Check previous button presses
    LDA $F0 : AND.b #$0F : BNE .swim_strokes

.skip_stroke_check

    LDA $033C : ORA $033D : ORA $033E : ORA $033F : BEQ .no_swim_accel

.swim_strokes

    LDY.b #$13
    
    LDA $02CC : STA $02

.no_swim_accel

    LDA $032A : BEQ .not_stroking_hard
    
    DEC A : STA $02
    
    LDY.b #$12

.not_stroking_hard

    BRL .PlayerOam_ContinueWithAnimation

.not_swimming

    LDA $02DA : BEQ .not_in_hold_item_pose
    
    STZ $02
    
    LDY.b #$1E
    
    CMP.b #$02 : BEQ .two_hand_hold_item_pose
    
    LDY.b #$1D

.two_hand_hold_item_pose

    BRA not_stroking_hard

.not_in_hold_item_pose

    ; Has something to do with the death module. Perhaps the player sprite
    ; lying down?
    LDA $036B : AND.b #$01 : BEQ nothing_with_desert_cutscene
    
    LDA $030A : STA $02
    
    LDY.b #$1B
    
    BRA .not_stroking_hard

nothing_with_desert_cutscene

    LDA $4D    : BEQ .nothing_with_swim
    CMP.b #$01 : BEQ .check_if_som_platform
    CMP.b #$04 : BNE .nothing_with_swim
    
    LDY.b #$13
    
    LDA $1A : AND.b #$18 : LSR #3 : TAX
    
    LDA.l $079635, X : STA $02
    
    BRL .PlayerOam_ContinueWithAnimation

.check_if_som_platform

    LDA $5D : CMP.b #$05 : BNE .notOnSomariaPlatform
    
    LDA $034E : BNE .dont_somaria_priority
    
    LDA.b #$30 : STA $65 : STZ $64

.dont_somaria_priority

    BRL .check_if_grabbing

.notOnSomariaPlatform

    ; Is the player using the hookshot?
    LDA $5D : CMP.b #$13 : BEQ .nothing_with_swim
    
    LDA $55 : BNE .nothing_with_swim
    
    LDY.b #$05
    
    LDA $0360 : BEQ .no_electroction_flag
    
    LDY.b #$14
    
    LDA $0300 : AND.b #$03

.no_electroction_flag

    STA $02
    
    BRL .PlayerOam_ContinueWithAnimation

.nothing_with_swim

    LDA.b $5B    : BEQ .no_slip_drawing
    CMP.b #$01   : BEQ .no_slip_drawing
    CMP.b #$03   : BNE .not_fully_falling
    
    ; Use an offset of 0x0000 in the OAM buffer when the player is falling
    ; into a hole or to the floor below?
    LDA PlayerOam_OAMBufferOffset+4 : STA $0352
    LDA PlayerOam_OAMBufferOffset+5 : STA $0353

.not_fully_falling

    LDA $5A : STA $02 : CMP.b #$06 : BCC .not_max_fall_priority
    
    LDA $65 : ORA.b #$30 : STA $65

.not_max_fall_priority

    LDY.b #$04
    
    BRL .PlayerOam_ContinueWithAnimation

.no_slip_drawing

    LDA $0308 : BEQ .not_carrying_something
    
    JSR PlayerOam_GetHighestSetBit
    
    ; This comparison would seem to indicate that some other part of the code
    ; gives a damn about bit 6 of this variable, but in truth the only relevant
    ; bits are 0 and 7. They could have just used a BMI instruction.
    CPX.b #$06 : BCS .keep_lift_direction
    
    ; Force player to face down...? Why?
    LDA.b #$02 : STA $0323

.keep_lift_direction

    LDY.w $A148, X : CPY.b #$0D : BCC .check_desert_step_counter
    
    LDA $0309 : AND.b #$02 : BEQ .not_throwing_object
    
    INY

.not_throwing_object

    LDA $0309 : AND.b #$01 : BEQ .not_lifting_object
    
    LDY.b #$10
    
    BRA .check_desert_step_counter

.not_lifting_object

    LDA $0308 : AND.b #$80 : BEQ .check_desert_step_counter
    
    BRL .PlayerOam_ContinueWithAnimation

.check_desert_step_counter

    LDA $030A
    
    BRA .set_item_use_anim

.not_carrying_something

    LDA $0377 : BEQ .not_grabbing_at_all
    
    DEC A
    
    LDY.b #$17
    
    BRA .set_item_use_anim

.not_grabbing_at_all

    LDA $0301 : BEQ .not_using_items_a
    
    JSR PlayerOam_GetHighestSetBit
    
    LDY.w PlayerOam_ItemsAUseIndex, X
    
    BRA .continue_with_items_a

.not_using_items_a

    LDA $037A : BEQ .not_using_items_b
    
    JSR PlayerOam_GetHighestSetBit
    
    LDY.w PlayerOam_ItemsBUseIndex, X

.continue_with_items_a

    LDA $0300

.set_item_use_anim

    STA $02
    
    BRA .PlayerOam_ContinueWithAnimation

.not_using_items_b

    LDA $5D : CMP.b #$0A : BEQ .using_medallion
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

    LDA $031C : STA $02
    
    BRA .PlayerOam_ContinueWithAnimation

.not_spinning

    ; Check B button status
    ; B button not down
    LDA $3A : AND.b #$80 : BEQ .PlayerOam_ContinueWithAnimation
    
    ; Check how long the B button has been pressed
    ; Not nine frames
    LDA $3C : CMP.b #$09 : BNE .not_fully_primed_sword
    
    LDY.b #$02
    
    BRA .PlayerOam_ContinueWithAnimation

.not_fully_primed_sword

    LDY.b #$27
    
    ; B button has been pressed less than 9 frames
    LDA $3C : STA $02 : CMP.b #$09 : BCC .PlayerOam_ContinueWithAnimation
    
    LDA $02 : SEC : SBC.b #$0A : STA $02
    
    LDY.b #$03

.PlayerOam_ContinueWithAnimation

    STY $0354 : CPY.b #$05 : BEQ .not_recoiling
    
    LDA $64 : STA $035D
    LDA $65 : STA $035E

.not_recoiling

    STZ $03
    
    LDA $02 : STA $76
    
    REP #$30
    
    LDA $2F : AND.w #$00FF : TAX
    
    LDA PlayerOam_AuxAnimationDirectionalStepIndexOffset, X : STA $74
    LDA PlayerOam_AnimationDirectionalStepIndexOffset, X : STA $04 ; Multiples of 0x50...
    
    ; I think Y is the "pose" for the particular direction we're facing.
    TYA : AND.w #$00FF : ASL A : CLC : ADC $04 : TAY
    
    ; $02 is probably a subpose index...
    LDA PlayerOam_AnimationStepDataOffsets, Y : CLC : ADC $02 : STA $02 : TAY
    
    LDA PlayerOam_Priority, Y : AND.w #$00FF : STA $04
    
    LDA.w #$0E00 : STA $0346
    
    LDA $0ABD : BEQ .not_alternate_palette
    
    ; Use palette SP0 instead of SP7
    STZ $0346

.not_alternate_palette

    STZ $0102
    STZ $0104
    
    LDX.w #$000C

 .check_next

    LDA $0354 : AND.w #$00FF : CMP PlayerOam_AnimationsWithAuxParts, X : BEQ .match
    
    DEX #2 : BPL  .check_next
    
    BRL PlayerOam_NoAux

.match

    TXA : AND.w #$00FF : CLC : ADC $74 : TAX
    
    LDA $76 : AND.w #$00FF : CLC : ADC PlayerOam_AuxAnimationStepDataOffset, X : STA $74
    
    LDY $74
    
    LDA PlayerOam_Aux1GFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BNE .continue_aux1
    
    BRL .no_aux1

.continue_aux1

    ASL A : STA $0102
    
    LDX $72
    
    LDA PlayerOam_PlayerOam_Aux1BufferOffsetPointers, X : STA $0A
    
    LDY $04
    
    LDA ($0A), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    LDY $74
    
    SEP #$20
    
    LDA $25 : BMI .aux1_z_negative
    
    LDA $24
    
    BRA .aux1_z_continue

.aux1_z_negative

    LDA $24 : CMP.b #$F0 : BCC .aux1_z_continue
    
    LDA.b #$00

.aux1_z_continue

    STA $0F : STZ $0E
    
    LDA.w PlayerOam_Aux1Offset_Y, Y : CLC : ADC.b $01 : SEC : SBC.b $0F : STA.w $0801, X
    LDA.w PlayerOam_Aux1Offset_X, Y : CLC : ADC.b $00 :            STA.w $0800, X
    
    REP #$20
    
    LDA PlayerOam_Aux1GFXIndex, Y : AND.w #$00FF : STA $06
    
    LSR A : TAY
    
    LDA.w $838C, Y : TAY
    
    LDA $06 : AND.w #$0001 : BEQ .dont_shift_aux1
    
    TYA : ASL #4 : TAY

.dont_shift_aux1

    TYA : AND.w #$C000 : ORA $64 : ORA $0346 : ORA.w #$0004 : STA $0802, X
    
    TXA : LSR #2 : TAX
    
    LDA $0A20, X : AND.w #$FF00 : STA $0A20, X

.no_aux1

    LDY $74
    
    LDA.w PlayerOam_Aux2GFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BNE .continue_aux2
    
    BRL PlayerOam_NoAux

.continue_aux2

    ASL A : STA.w $0104
    
    LDX.b $72
    
    LDA.w PlayerOam_Aux2BufferOffsetPointers, X : STA.b $0A
    
    LDY $04
    
    LDA ($0A), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    LDY $74
    
    SEP #$20
    
    LDA $25 : BMI .aux_2_z_negative
    
    LDA $24
    
    BRA .aux_2_z_continue

.aux_2_z_negative

    LDA $24 : CMP.w #$F0 : BCC .aux_2_z_continue
    
    LDA.w #$00

.aux_2_z_continue

    STA $0F : STZ $0E
    
    LDA PlayerOam_Aux2Offset_Y, Y : CLC : ADC $01 : SEC : SBC $0F : STA $0801, X
    
    LDA PlayerOam_Aux2Offset_X, Y : CLC : ADC $00 : STA $0800, X
    
    REP #$20
    
    LDA PlayerOam_Aux2GFXIndex, Y : AND.w #$00FF : STA $06
    
    LSR A : TAY
    
    LDA PlayerOam_AuxFlip-1, Y : TAY
    
    LDA $06 : AND.w #$0001 : BEQ .dont_shift_aux2
    
    TYA : ASL #4 : TAY

.dont_shift_aux2

    TYA : AND.w #$C000 : ORA $64 : ORA $0346 : ORA.w #$0014 : STA $0802, X
    
    TXA : LSR #2 : TAX
    
    LDA $0A20, X : AND.w #$FF00 : STA $0A20, X

PlayerOam_NoAux

    LDA $0309 : AND.w #$0004 : BEQ .always_taken
    
    JSR PlayerOam_UnusedWeaponSettings ; $06ADB6 IN ROM
    
    BRA .skip_sword_vram

.always_taken

    LDA $5D : AND.w #$00FF
    
    CMP.w #$0008 : BEQ .is_spinning_mode
    CMP.w #$0009 : BEQ .is_spinning_mode
    CMP.w #$000A : BEQ .is_spinning_mode
    CMP.w #$0003 : BEQ .is_spinning_mode
    CMP.w #$001E : BEQ .is_spinning_mode
    
    LDA $0308 : AND.w #$00FF : BNE .holding_hands_up
    
    LDA $03EF : ORA $0360 : AND.w #$00FF : BNE .holding_hands_up
    
    LDA $0301 : AND.w #$0040 : BNE .skip_sword_vram
    
    LDA $037A : AND.w #$003D : BNE .using_some_item
    
    LDA $0301 : AND.w #$0093 : BNE .using_some_item
    
    LDA $3A : AND.w #$0080 : BEQ .skip_sword_vram

.is_spinning_mode
.holding_hands_up

    LDA.l $7EF359 : INC A : AND.w #$00FE : BEQ .skip_sword_vram

.using_some_item:

    ; $06AB6E IN ROM
    JSR PlayerOam_SetWeaponVRAMOffsets : BCC .continue_with_weapon

.skip_sword_vram:

    BRL PlayerOam_DrawShield

.continue_with_weapon

    LDY $02
    
    SEP #$20
    
    LDA $25 : BMI .possible_grounded
    
    LDA $24
    
    BRA .airborne

.possible_grounded

    LDA $24 : CMP.b #$F0 : BCC .airborne
    
    LDA.b #$00

.airborne

    STA $0B
    
    LDA $01 : CLC : ADC PlayerOam_SwordOffsetY, Y : SEC : SBC $0B : STA $0B
    
    LDA $00 : CLC : ADC PlayerOam_SwordOffsetX, Y : STA $0A : STA $08
    
    LDA $0301 : AND.b #$02 : BEQ .not_hammer
    
    LDA $0300 : CMP.b #$02 : BNE .skip_hitbox
    
    LDA $3D : CMP.b #$0F : BNE .skip_hitbox
    
    BRA .set_hitbox_offset

.not_hammer

    LDA $0301 : AND.b #$05 : BNE .skip_hitbox

.set_hitbox_offset

    LDA AttackHitboxOffset_Y, Y : STA $44
    LDA AttackHitboxOffset_X, Y : STA $45

.skip_hitbox

    STZ $0E
    STZ $0F
    
    LDA $0301 : AND.b #$05 : BEQ .rodding
    
    LDY $0307 : DEY
    
    LDA PlayerOam_RodTypeID, Y : STA $0F

.rodding

    LDA $037A : AND.b #$08 : BEQ .not_caning
    
    LDA $0303 : CMP.b #$0D : BNE .not_caning
    
    LDA.b #$04 : STA $0F

.not_caning

    REP #$20
    
    LDA $06 : ASL A : CLC : ADC $06 : ASL A : TAY
    
    STZ $06
    
    PHY
    
    LDX $72
    
    LDA PlayerOam_WeaponBufferOffsetPointers, X : STA $74
    
    LDA $04 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    PLY
    
    LDA $0E : PHA
    
    JSR PlayerOam_DrawSwordSwingTip ; $06ACD5 IN ROM
    
    PLA : STA $0E

.next_weapon_object

    REP #$20
    
    LDA PlayerOam_WeaponTiles, Y : CMP.w #$FFFF : BEQ .no_weapons
    
    AND.w #$CFFF : ORA $64 : STA $0802, X
    
    AND.w #$0E00 : CMP.w #$0200 : BEQ .ignore_palette_adjustments
    
    LDA $0346 : BNE .ignore_palette_adjustments
    
    LDA $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA $0802, X

.ignore_palette_adjustments

    LDA $0E : BEQ .ignore_palette_adjustments_2
    
    LDA $0802, X : AND.w #$F1FF : ORA $0E : STA $0802, X

.ignore_palette_adjustments_2

    LDA $0A : STA $0800, X
    
    AND.w #$00FF : STA $74
    
    LDA $00 : AND.w #$00FF : SEC : SBC $74 : BPL .positive_a
    
    EOR.w #$FFFF : INC A

.positive_a

    CMP.w #$0080 : BCC .positive_b
    
    LDA.w #$0001 : TSB $0C

.positive_b

    PHY : PHX
    
    TXA : LSR #2 : TAX
    
    SEP #$20
    
    LDA $0C : STA $0A20, X
    
    AND.b #$FE : STA $0C
    
    PLX : PLY
    
    INX #4

.no_weapons

    SEP #$20
    
    LDA $0A : CLC : ADC.b #$08 : STA $0A
    
    INY #2
    
    LDA $06 : INC A : STA $06 : AND.b #$01 : BNE .no_offset
    
    LDA $0B : CLC : ADC.b #$08 : STA $0B
    
    LDA $08 : STA $0A

.no_offset

    LDA $06 : CMP.b #$03 : BEQ .weapon_loop_done
    
    BRL .next_weapon_object

.weapon_loop_done

    SEP #$10

PlayerOam_DrawShield:

    REP #$30
    
    ; Shield
    LDA.l $7EF35A : AND.w #$00FF : BEQ .dontShowShield
    
    ; Check out progress indicator to see if Link's gotten the shield from his uncle yet.
    ; In other words, if Link has entered phase 1
    LDA.l $7EF3C5 : AND.w #$00FF : BEQ .dontShowShield
    
    ; $06ABE6 IN ROM; affects graphics when carrying things?
    JSR PlayerOam_SetEquipmentVRAMOffsets : BCC .showShield

.dontShowShield

    BRL PlayerOam_DrawShadow

; Pretty sure this label is accurate, would require in game tesing
.showShield

    LDY $02
    
    SEP #$20
    
    LDA $25 : BMI .not_necessarily_airborne
    
    LDA $24
    
    BRA .airborne

.not_necessarily_airborne

    LDA $24 : CMP.b #$F0 : BCC .airborne
    
    LDA.b #$00

.airborne

    STA $0B
    
    LDA.b $01 : CLC : ADC.w PlayerOam_ShieldOffsetY, Y : DEC A : SEC : SBC.b $0B : STA.b $0B
    
    LDA.b $00 : CLC : ADC.w PlayerOam_ShieldOffsetX, Y : STA.b $0A : STA.b $08
    
    LDA PlayerOam_ShieldOffsetX, Y
    
    JSR PlayerOam_GetRelativeHighBit
    
    STZ $0E
    
    LDA.b #$0A : STA $0F
    
    ; Branch if the player sprite is using palette 7, which is typical.
    LDA $0347 : BNE .leave_shield_palette
    
    LDA.b #$06 : STA $0F

.leave_shield_palette

    REP #$30
    
    LDA $06 : ASL A : CLC : ADC $06 : ASL A : TAY
    
    STZ $06
    
    PHY
    
    LDX $72
    
    LDA.w PlayerOam_ShieldBufferOffsetPointers, X : STA.b $74
    
    LDA $04 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    PLY

.next_shield_object

    REP #$20
    
    STZ $74
    
    LDA.w $8563, Y : CMP.w #$FFFF : BEQ .no_shield_to_draw
    
    AND.w #$C1FF : ORA $0E : ORA $64 : STA $0802, X
    
    LDA $0A : STA $0800, X
    
    PHX
    
    TXA : LSR #2 : TAX
    
    SEP #$20
    
    ; Or in the 9th bit of the X coordinate
    LDA $0C : ORA $03FA : STA $0A20, X
    
    PLX : INX #4

.no_shield_to_draw

    SEP #$20
    
    LDA $0A : CLC : ADC.b #$08 : STA $0A
    
    INY #2
    
    INC $06
    
    LDA $06 : AND.b #$01 : BNE .no_offset_2
    
    LDA $0B : CLC : ADC.b #$08 : STA $0B
    
    LDA $08 : STA $0A

.no_offset_2

    LDA $06 : CMP.b #$03 : BNE .next_shield_object
    
    SEP #$10

PlayerOam_DrawShadow:

    SEP #$30
    
    LDA $4B : CMP.b #$0C : BNE .player_is_visible
    
    BRL PlayerOam_DrawPose

.player_is_visible

    LDA $5D : CMP.b #$16 : BEQ .proceed_to_pose
    
    LDA $0354 : CMP.b #$05 : BEQ .recoil_check
    
    ; See if Link is standing in water.
    LDA $0351 : BEQ .recoil_check
    
    JSR PlayerOam_DrawFootObject ; $06AED1 IN ROM; Draws water/grass sprites around Link
    
    BRA .proceed_to_pose

.recoil_check:

    LDA $4D : CMP.b #$04 : BEQ .proceed_to_pose
    
    LDA $5D : CMP.b #$04 : BEQ .proceed_to_pose
    
    LDY.b #$00
    
    LDA $5B    : BEQ .weak_slip
    CMP.b #$01 : BEQ .weak_slip
    
    LDA $5A : CMP.b #$06 : BCC .proceed_to_pose
    
    JSR PlayerOam_DungeonFallShadow ; $06AE3B IN ROM

.proceed_to_pose:

    BRL PlayerOam_DrawPose

.weak_slip:

    LDA $4D    : BEQ .big_shadow
    CMP.b #$01 : BNE .tiny_shadow
    
    LDA $55 : BNE .big_shadow

.tiny_shadow

    LDY.b #$01

.big_shadow

    STY $0A
    STZ $0B
    
    LDA $0323 : LSR A : TAY
    
    REP #$20
    
    LDA $20 : SEC : SBC $E8 : STA $06
    
    LDA PlayerOam_ShadowOffset_Y, Y : AND.w #$00FF : CMP.w #$0080 : BCC .positive_y
    
    ORA.w #$FF00

.positive_y

    CLC : ADC $06 : STA $06
    
    SEP #$20
    
    LDA $07 : BNE .proceed_to_pose
    
    LDA $01 : CLC : ADC PlayerOam_ShadowOffset_Y, Y : STA $07
    LDA $00 : CLC : ADC PlayerOam_ShadowOffset_X, Y : STA $06
    
    REP #$30
    
    LDX $72
    
    LDA PlayerOam_ShadowBufferOffsetPointers, X : STA $74
    
    LDA $04 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    LDA $0A : ASL #2 : TAY
    
    LDA PlayerOam_ShadowTiles, Y : AND.w #$CFFF : ORA $035D : STA $0802, X
    
    AND.w #$3FFF : ORA.w #$4000 : STA $0806, X
    
    LDA $06 : STA $0800, X
    
    XBA : CLC : ADC.w #$0800 : XBA : STA $0804, X
    
    LDA $0346 : BNE .no_palette_adjustment
    
    LDA $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA $0802, X
    
    LDA $0806, X : AND.w #$F1FF : ORA.w #$0600 : STA $0806, X

.no_palette_adjustment

    TXA : LSR #2 : TAX
    
    STZ $0A20, X
    
    SEP #$30

PlayerOam_DrawPose:

    REP #$30
    
    LDX $72
    
    LDA PlayerOam_ElfBufferOffsetPointers, X : STA $74
    
    LDY $04
    
    ; Determine the finalized offset into the OAM buffer?
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    LDA $02 : ASL A : TAY
    
    LDA PlayerOam_AnimationSteps, Y : STA $0E
    
    ASL A : STA $0100
    
    CLC : ADC $0E : TAY
    
    SEP #$20
    
    LDA $4B : CMP.b #$0C : BNE .not_invisible
    
    BRL PlayerOam_RunFinalAdjustments

.not_invisible

    LDA $25 : BMI .possibly_grounded
    
    LDA $24
    
    BRA .airborne

.possibly_grounded

    LDA $24 : CMP.b #$F0 : BCC .airborne
    
    LDA.b #$00

.airborne

    STA $0F
    STZ $0E
    
    LDA $01 : CLC : ADC PlayerOam_PoseData, Y : SEC : SBC $0F : STA $0B
    LDA $00 : CLC : ADC PlayerOam_PoseData+1, Y            : STA $0A
    
    REP #$20
    
    LDA PlayerOam_PoseData+2, Y : XBA : STA $06
    
    AND.w #$F000 : CMP.w #$F000 : BEQ .no_draw
    
    ORA $64 : ORA $0346 : STA $0802, X
    
    STZ $02
    
    LDA $0A : STA $0800, X
    
    AND.w #$00FF : CMP.w #$00F8 : BCC .on_screen_x
    
    LDA.w #$0001 : STA $02

.on_screen_x

    PHX
    
    TXA : LSR #2 : TAX
    
    LDA $0A20, X : AND.w #$FF00 : ORA $02 : ORA.w #$0002 : STA $0A20, X
    
    PLX

.no_draw:

    LDA $06 : AND.w #$0F00 : CMP.w #$0F00 : BEQ PlayerOam_RunFinalAdjustments
    
    ASL #4 : ORA $64 : ORA $0346 : ORA.w #$0002 : STA $0806, X
    
    LDA $00 : SEC : SBC $0E : CLC : ADC.w #$0800 : STA $0804, X
    
    TXA : LSR #2 : TAX
    
    LDA $0A21, X : AND.w #$FF00 : ORA.w #$0002 : STA $0A21, X

PlayerOam_RunFinalAdjustments:

    SEP #$30
    
    LDA.b #$01 : STA $0E
    
    LDA $6C : BEQ .not_in_doorway
    
    REP #$20
    
    LDA $22 : SEC : SBC $E2
    
    CMP.w #$0004 : BCC .looks_invisible
    CMP.w #$00FC : BCS .looks_invisible
    
    LDA $20 : SEC : SBC $E8
    
    CMP.w #$0004 : BCC .looks_invisible
    CMP.w #$00E0 : BCS .looks_invisible
    
    SEP #$20

.not_in_doorway

    STZ $0E
    
    LDA $11 : BNE .check_stair_visibility
    
    LDA $031F : BEQ .check_stair_visibility
    
    DEC A : STA $031F
    
    CMP.b #$04 : BCC .check_stair_visibility
    AND.b #$01 : BEQ .looks_invisible

.check_stair_visibility:

    LDA $4B : CMP.b #$0C : BEQ .looks_invisible
    
    LDA $55 : BEQ .cape_inactive_z

.looks_invisible:

    REP #$30
    
    LDA $0352 : LSR #2 : TAX
    
    LDA.w #$0101 : STA $0A20, X : STA $0A22, X : STA $0A24, X
               STA $0A26, X : STA $0A28, X : STA $0A2A, X
    
    LDA $4B : AND.w #$00FF : CMP.w #$000C : BEQ .check_position_restoration
    
    LDA $0E : AND.w #$00FF : BNE .check_position_restoration
    
    LDX $72
    
    LDA PlayerOam_ShadowBufferOffsetPointers, X : STA $74
    
    LDA $04 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : LSR #2 : TAX
    
    STZ $0A20, X

.check_position_restoration:

    SEP #$30

.cape_inactive_z

    LDA $11
    
    ; z is a placeholder until we figure out how many there are like this.
    CMP.b #$12 : BEQ .on_straight_interroom_staircase_z
    CMP.b #$13 : BNE .not_on_straight_interroom_staircase_z

; restore position 
.on_straight_interroom_staircase_z

    PLA : STA $21
    PLA : STA $20

.not_on_straight_interroom_staircase_z

    PLB
    
    RTL
}

; =========================================================

; $06AAC3-$06AACB LOCAL JUMP LOCATION
PlayerOam_GetHighestSetBit:
{
    ; This routine returns the highest bit set in whatever variable is the
    ; accumulator. Note: you wouldn't want to call this with a 16-bit
    ; accumulator enabled.
    
    LDX.b #$07

.next_bit:

    ASL A : BCS .bit_was_set
    
    DEX : BPL .next_bit

.bit_was_set

    RTS
}

; =========================================================

; $06AACC-$0???? DATA
; TODO analyze, format, annotate
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

; =========================================================

PlayerOam_RodOffsetID:
     db $01, $04, $01, $04, $06, $02, $00, $05
     db $00, $05

; =========================================================

PlayerOam_WeaponSize:
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
    
    STA.b $06 : TAX
    
    LDA.w PlayerOam_WeaponSize, X : AND.w #$00FF : STA $0C
    
    TXA
    
    LDY.w PlayerOam_WeaponOffsetID, X : CMP.w #$001D : BCC .is_sword
    
    LDA.w $0301 : AND.w #$0005 : BEQ .not_rod
    
    TXA : SEC : SBC.w #$001D : TAX
    
    LDY.w PlayerOam_RodOffsetID, X

.not_rod

    TYA : AND.w #$00FF : STA $0A
    
    LDA $0109 : AND.w #$FF00 : ORA $0A : STA $0109
    
    BRA .succeed

.is_sword

    TYA : AND.w #$00FF : STA $0A
    
    LDA $0107 : AND.w #$FF00 : ORA $0A : STA $0107

.succeed

    CLC
    
    RTS

.fail

    SEC
    
    RTS
}

; TODO analyze
EquipmentVRAMOffsets:
{
.shield_id
     db $00, $02, $04, $04, $04, $04, $04, $04
     db $09, $0C, $09, $0C, $0E, $0A, $08, $0D
     db $08, $0D

.rod_id
     db $01, $04, $01, $04, $06, $02, $00, $05
     db $00, $05

}

; $06ABE6-$06AC44 LOCAL JUMP LOCATION
PlayerOam_SetEquipmentVRAMOffsets:
{
    REP #$30
    
    STZ $0C
    
    LDY $02
    
    ; Appears to only range from 0xFF to 0x03
    LDA PlayerOam_ShieldGFXIndex, Y : AND.w #$00FF : CMP.w #$00FF : BEQ .fail
    
    STA $06 : TAX : LDY.w EquipmentVRAMOffsets_shield_id, X : AND.w #$00F8 : BEQ .is_shield
    
    LDA $0301 : AND.w #$0005 : BEQ .not_rod
    
    TXA : SEC : SBC.w #$0008 : TAX
    
    LDY.w EquipmentVRAMOffsets_rod_id, X

.not_rod

    TYA       : AND.w #$00FF : STA $0A
    LDA $0109 : AND.w #$FF00 : ORA $0A : STA $0109
    
    AND.w #$0007 : BEQ .dont_invert
    
    BRA .succeed

.is_shield

    TYA : AND.w #$00FF : STA $0A
    
    LDA $0108 : AND.w #$FF00 : ORA $0A : STA $0108

.dont_invert

    LDA.w #$0002 : STA $0C

.succeed

    CLC
    
    RTS

.fail

    SEC
    
    RTS
}


PlayerOam_SwordSwingTipTile:
{
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
; =========================================================

PlayerOam_SwordSwingTipOffsetY:
{
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
; =========================================================

PlayerOam_SwordSwingTipOffsetX:
{
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
    LDA $0A : PHA
    
    PHY
    
    LDA $5D : BEQ .base_link_state

.give_up

    BRL .reset_and_exit

.base_link_state

    LDA.l $7EF359
    
    AND.w #$00FF : BEQ .give_up
    CMP.w #$00FF : BEQ .give_up
    CMP.w #$0001 : BEQ .give_up
    
    LDA $3A : AND.w #$0080 : BEQ .give_up
    
    LDA $3C : AND.w #$00FF : CMP.w #$0009 : BCS .give_up
    
    ASL A : STA $0A
    
    LDA $2F : AND.w #$00FF : LSR A : STA $0E
    
    ASL #3 : CLC : ADC $0E : ASL A : CLC : ADC $0A : TAY
    
    LDA PlayerOam_SwordSwingTipTile, Y : CMP.w #$FFFF : BEQ .reset_and_exit
    
    AND.w #$CFFF : ORA $64 : STA $0802, X
    
    LDA $0346 : BNE .no_palette_adjust
    
    LDA $0802, X : AND.w #$F1FF : ORA.w #$0600 : STA $0802, X

.no_palette_adjust

    TYA : LSR A : TAY
    
    SEP #$20
    
    LDA PlayerOam_SwordSwingTipOffsetY, Y : CLC : ADC $01 : STA $0B
    LDA PlayerOam_SwordSwingTipOffsetX, Y : CLC : ADC $00 : STA $0A
    
    LDA PlayerOam_SwordSwingTipOffsetY, Y : STA $44
    LDA PlayerOam_SwordSwingTipOffsetX, Y : STA $45
    
    JSR PlayerOam_GetRelativeHighBit
    
    REP #$20
    
    LDA $0A : STA $0800, X
    
    INX #4
    
    PHX
    
    TXA : SEC : SBC.w #$0004 : LSR #2 : TAX
    
    ; Or in the 9th bit of the X coordinate
    LDA.w #$0000 : ORA $03FA : STA $0A20, X
    
    PLX

.reset_and_exit

    STZ $0E
    
    PLY
    
    PLA : STA $0A
    
    RTS
}

; $06ADB6-$06AE37 LOCAL JUMP LOCATION
PlayerOam_UnusedWeaponSettings:
{
    SEP #$30
    
    LSR #2
    
    JSR PlayerOam_GetHighestSetBit
    
    LDA.w $ADB4, X : CLC : ADC $030E : ASL #2 : STA $06 : STZ $07
    
    LDA.b #$42 : STA $0109
    
    REP #$30
    
    LDX $72
    
    LDA.w $A110, X : STA $74
    
    LDA $04 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    LDY $06
    
    STZ $06

BRANCH_BETA:

    SEP #$20
    
    LDA $01 : CLC : ADC $AD94, Y : STA $0B
    LDA $00 : CLC : ADC $ADA4, Y : STA $0A
    
    PHY
    
    LDA.w $AD84, Y : CMP.b #$FF : BEQ BRANCH_ALPHA
    
    REP #$20
    
    AND.w #$00FF : TAY
    
    LDA.w $AD82, Y : AND.w #$CFFF : ORA $64 : STA $0802, X
    
    LDA $0A : STA $0800, X
    
    PHX
    
    TXA : LSR #2 : TAX
    
    SEP #$20
    
    STZ $0A20, X
    
    PLX : INX #4

BRANCH_ALPHA:

    PLY : INY
    
    INC $06 : LDA $06 : CMP.b #$04 : BNE BRANCH_BETA
    
    LDA $06 : CMP.b #$04 : BNE BRANCH_BETA
    
    REP #$30
    
    RTS
}

; =========================================================

; $06AE38-$06AE3A DATA
DungeonFallShadow:
{
.offset_x
    db $00, $00, $04
}

; =========================================================

; $06AE3B-$06AEC9 LOCAL JUMP LOCATION
PlayerOam_DungeonFallShadow:
{
    LDY.b #$00
    
    LDA $51 : SEC : SBC.b #$0C : SEC : SBC $20
    
    CMP.b #$F0 : BCS .shadow_size_chosen
    CMP.b #$30 : BCC .not_medium_shadow
    
    LDY.b #$04

.not_medium_shadow

    CMP.b #$60 : BCC .shadow_size_chosen
    
    LDY.b #$08

.shadow_size_chosen

    TYA : LSR A : LSR A : TAX
    
    LDA DungeonFallShadow_offset_x, X : STA $06
    
    LDA $51 : SEC : SBC.b #$0C : SEC : SBC $E8 : CLC : ADC.b #$1D : STA $07
    
    LDA $00 : CLC : ADC $06 : STA $06
    
    STZ $04
    
    REP #$30
    
    PHY
    
    LDX $72
    
    LDA PlayerOam_ShadowBufferOffsetPointers, X : STA $74
    
    LDA $03 : AND.w #$00FF : TAY
    
    LDA ($74), Y : AND.w #$00FF : CLC : ADC $0352 : TAX
    
    PLY

.next_object

    REP #$20
    
    LDA PlayerOam_ShadowTiles, Y : CMP.w #$FFFF : BEQ .give_up
    
    AND.w #$CFFF : ORA $035D : STA $0802, X
    
    LDA $06 : STA $0800, X

.give_up:

    PHX
    
    TXA : LSR #2 : TAX
    
    SEP #$20
    
    STZ $0A20, X
    
    PLX
    
    LDA $06 : CLC : ADC.b #$08 : STA $06
    
    INY #2
    
    INX #4
    
    INC $04
    
    LDA $04 : CMP.b #$02 : BNE .next_object
    
    SEP #$10
    
    RTS
}

; =========================================================

; $06AECA-$06AED0 DATA
FootObject:
{
; \task Name this pool / routine.
.aux_check
    db $0A, $02, $0E
.shield_direction
    db $04, $04, $08, $08
}

; =========================================================

; $06AED1-$06AF9C LOCAL JUMP LOCATION
PlayerOam_DrawFootObject:
{
    ; Seems to draw the ripples around Link while standing in shallow water
    
    ; Seems like a timer to control how often to change the sprite's frame
    ; If frame counter < 9
    LDA $0356 : INC A : AND.b #$0F : STA $0356
    
    CMP.b #$09 : BCC .dont_reset_foot_object
    
    STZ $0356
    
    LDA $0355 : INC A : AND.b #$03 : STA $0355
    
    CMP.b #$03 : BNE .dont_reset_foot_object
    
    STZ $0355

.dont_reset_foot_object

    ; See if Link has a shield
    LDA.l $7EF35A : TAY
    
    ; See which direction Link is facing
    ; Probably positions the water/grass sprite appropriately
    LDA $0323 : LSR A : CLC : ADC FootObject_shield_direction, Y : TAY
    
    LDA $01 : CLC : ADC PlayerOam_ShadowOffset_Y, Y : STA $07
    LDA $00 : CLC : ADC PlayerOam_ShadowOffset_X, Y : STA $06
    
    ; $8D = secondary timer * 4
    LDA $0355 : ASL #2 : STA $8D
    
    PHY
    
    ; ???? $72 apparently is assumed to be even at all times.
    LDX $72
    
    LDA PlayerOam_ShadowBufferOffsetPointers, X : STA $74
    LDA PlayerOam_ShadowBufferOffsetPointers+1, X : STA $75
    
    LDY $04
    
    LDA ($74), Y : TAX
    
    PLY
    
    ; See if Link is standing in grass
    ; Nope... standing in water
    LDA $0351 : CMP.b #$02 : BNE .not_tall_grass
    
    LDY.b #$06

.check_next

    LDA .aux_check, Y : CMP $0354 : BNE .wrong
    
    STZ $8D
    
    BRA .check_step

.wrong

    DEY : BPL .check_next

.check_step

    LDA $2E : CMP.b #$03 : BCC .dont_reset_step
    
    SEC : SBC.b #$03

.dont_reset_step

    ASL #2 : STA $8D
    
    LDA.b #$08 : ASL #2 : CLC : ADC $8D : TAY
    
    BRA .continue

.not_tall_grass

    LDA.b #$05 : ASL #2 : CLC : ADC $8D : TAY

.continue

    ; This is where the actual draw starts, it draws both tiles at the same time but in 2 
    ; completly different ways. Wtf Nintendo.
    REP #$30
    
    ; Get the starting address for the frame of either the water or grass animation we are on.
    TYA : AND.w #$00FF : TAY

    ; Get the offset of where to put the OAM.
    TXA : AND.w #$00FF : CLC : ADC $0352 : TAX
        
    ; Char and property bytes for the left half of the grass/splash.
    LDA PlayerOam_ShadowTiles+0, Y : AND.w #$CFFF : ORA $035D : STA $0802, X
        
    ; Char and property bytes for the right half of the grass/splash.
    ; Because this is separate from the other half this leads to a stupid bug in vanilla 
    ; where if you have water under a bridge in a dungeon, the right half will appear
    ; incorrectly on top of the bridge.
    LDA PlayerOam_ShadowTiles+2, Y : ORA $035D : STA $0806, X
        
    ; X and Y pos for left half.
    LDA $06 : STA $0800, X
    
    ; X and Y pos for right half by just adding 8 to the x pos.
    ; Why tf are you switching bytes and then adding #$0800? why not just add #$0080 and
    ; skip flipping A and B??
    XBA : CLC : ADC.w #$0800 : XBA : STA $0804, X
        
    TXA : LSR #2 : TAX
    
    ; Write the size and extra x bytes.
    STZ $0A20, X
    
    SEP #$30
    
    RTS
}

; =========================================================

; \unused (Not sure if really unused yet.)
; $06AF9D-$06AFA5 DATA
Pool_PlayerOam_Unused_0:
{
.offsets
    db 0, 0, 0, 1, 0, 1, 1, 1
    db 0
}

; =========================================================

; \unused (Not sure if really unused yet.)
; $06AFA6-$06AFBF LOCAL JUMP LOCATION
PlayerOam_Unused_0:
{
    SEP #$30
    
    LDX $2E
    
    LDA $0354 : CMP.b #$19 : BNE .alpha
        LDA.w $A131, X : TAX

    .alpha

    LDA .offsets, X : CLC : ADC $01 : STA $01
    
    REP #$30
    
    RTS
}

; =========================================================

; $06AFC0-$06AFDC LOCAL JUMP LOCATION
PlayerOam_GetRelativeHighBit:
{
    ; In general this seems to take an offset for a sprite and figure out
    ; if its position relative to Link and the screen will require the 9th
    ; bit of the X coordinate to be set
    
    REP #$20
    
    ; sign extend the value in the accumulator to 16-bits
    AND.w #$00FF : CMP.w #$0080 : BCC .positive
        ORA.w #$FF00

    .positive

    CLC : ADC $22 : SEC : SBC $E2 : XBA : AND.w #$0001 : STA $03FA
    
    SEP #$20
    
    RTS
}

; =========================================================