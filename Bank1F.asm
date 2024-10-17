; ==============================================================================

; Bank 1F
; $0F8000-$0FFFFF
org $1F8000

; Dungeon Room Data and pointers

; ==============================================================================

; $0F8000-$0F83BF
RoomData_ObjectDataPointers:
{
    dl RoomDataTiles_0000
    dl RoomDataTiles_0001
    dl RoomDataTiles_0002
    dl RoomDataTiles_0003
    dl RoomDataTiles_0004
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0006
    dl RoomDataTiles_0007
    dl RoomDataTiles_0008
    dl RoomDataTiles_0009
    dl RoomDataTiles_000A
    dl RoomDataTiles_000B
    dl RoomDataTiles_000C
    dl RoomDataTiles_000D
    dl RoomDataTiles_000E
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0010
    dl RoomDataTiles_0011
    dl RoomDataTiles_0012
    dl RoomDataTiles_0013
    dl RoomDataTiles_0014
    dl RoomDataTiles_0015
    dl RoomDataTiles_0016
    dl RoomDataTiles_0017
    dl RoomDataTiles_0018
    dl RoomDataTiles_0019
    dl RoomDataTiles_001A
    dl RoomDataTiles_001B
    dl RoomDataTiles_001C
    dl RoomDataTiles_001D
    dl RoomDataTiles_001E
    dl RoomDataTiles_001F
    dl RoomDataTiles_000D
    dl RoomDataTiles_0021
    dl RoomDataTiles_0022
    dl RoomDataTiles_0023
    dl RoomDataTiles_0024
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0026
    dl RoomDataTiles_0027
    dl RoomDataTiles_0028
    dl RoomDataTiles_0029
    dl RoomDataTiles_002A
    dl RoomDataTiles_002B
    dl RoomDataTiles_002C
    dl RoomDataTiles_Empty
    dl RoomDataTiles_002E
    dl RoomDataTiles_002F
    dl RoomDataTiles_0030
    dl RoomDataTiles_0031
    dl RoomDataTiles_0032
    dl RoomDataTiles_0033
    dl RoomDataTiles_0034
    dl RoomDataTiles_0035
    dl RoomDataTiles_0036
    dl RoomDataTiles_0037
    dl RoomDataTiles_0038
    dl RoomDataTiles_0039
    dl RoomDataTiles_003A
    dl RoomDataTiles_003B
    dl RoomDataTiles_003C
    dl RoomDataTiles_003D
    dl RoomDataTiles_003E
    dl RoomDataTiles_003F
    dl RoomDataTiles_0040
    dl RoomDataTiles_0041
    dl RoomDataTiles_0042
    dl RoomDataTiles_0043
    dl RoomDataTiles_0044
    dl RoomDataTiles_0045
    dl RoomDataTiles_0046
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0049
    dl RoomDataTiles_004A
    dl RoomDataTiles_004B
    dl RoomDataTiles_004C
    dl RoomDataTiles_004D
    dl RoomDataTiles_004E
    dl RoomDataTiles_004F
    dl RoomDataTiles_0050
    dl RoomDataTiles_0051
    dl RoomDataTiles_0052
    dl RoomDataTiles_0053
    dl RoomDataTiles_0054
    dl RoomDataTiles_0055
    dl RoomDataTiles_0056
    dl RoomDataTiles_0057
    dl RoomDataTiles_0058
    dl RoomDataTiles_0059
    dl RoomDataTiles_005A
    dl RoomDataTiles_005B
    dl RoomDataTiles_005C
    dl RoomDataTiles_005D
    dl RoomDataTiles_005E
    dl RoomDataTiles_005F
    dl RoomDataTiles_0060
    dl RoomDataTiles_0061
    dl RoomDataTiles_0062
    dl RoomDataTiles_0063
    dl RoomDataTiles_0064
    dl RoomDataTiles_0065
    dl RoomDataTiles_0066
    dl RoomDataTiles_0067
    dl RoomDataTiles_0068
    dl RoomDataTiles_Empty
    dl RoomDataTiles_006A
    dl RoomDataTiles_006B
    dl RoomDataTiles_006C
    dl RoomDataTiles_006D
    dl RoomDataTiles_006E
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0070
    dl RoomDataTiles_0071
    dl RoomDataTiles_0072
    dl RoomDataTiles_0073
    dl RoomDataTiles_0074
    dl RoomDataTiles_0075
    dl RoomDataTiles_0076
    dl RoomDataTiles_0077
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_007B
    dl RoomDataTiles_007C
    dl RoomDataTiles_007D
    dl RoomDataTiles_007E
    dl RoomDataTiles_007F
    dl RoomDataTiles_0080
    dl RoomDataTiles_0081
    dl RoomDataTiles_0082
    dl RoomDataTiles_0083
    dl RoomDataTiles_0084
    dl RoomDataTiles_0085
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0087
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0089
    dl RoomDataTiles_Empty
    dl RoomDataTiles_008B
    dl RoomDataTiles_008C
    dl RoomDataTiles_008D
    dl RoomDataTiles_008E
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0090
    dl RoomDataTiles_0091
    dl RoomDataTiles_0092
    dl RoomDataTiles_0093
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0095
    dl RoomDataTiles_0096
    dl RoomDataTiles_0097
    dl RoomDataTiles_0098
    dl RoomDataTiles_0099
    dl RoomDataTiles_Empty
    dl RoomDataTiles_009B
    dl RoomDataTiles_009C
    dl RoomDataTiles_009D
    dl RoomDataTiles_009E
    dl RoomDataTiles_009F
    dl RoomDataTiles_00A0
    dl RoomDataTiles_00A1
    dl RoomDataTiles_00A2
    dl RoomDataTiles_00A3
    dl RoomDataTiles_00A4
    dl RoomDataTiles_00A5
    dl RoomDataTiles_00A6
    dl RoomDataTiles_00A7
    dl RoomDataTiles_00A8
    dl RoomDataTiles_00A9
    dl RoomDataTiles_00AA
    dl RoomDataTiles_00AB
    dl RoomDataTiles_00AC
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00AE
    dl RoomDataTiles_00AF
    dl RoomDataTiles_00B0
    dl RoomDataTiles_00B1
    dl RoomDataTiles_00B2
    dl RoomDataTiles_00B3
    dl RoomDataTiles_00B4
    dl RoomDataTiles_00B5
    dl RoomDataTiles_00B6
    dl RoomDataTiles_00B7
    dl RoomDataTiles_00B8
    dl RoomDataTiles_00B9
    dl RoomDataTiles_00BA
    dl RoomDataTiles_00BB
    dl RoomDataTiles_00BC
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00BE
    dl RoomDataTiles_004F
    dl RoomDataTiles_00C0
    dl RoomDataTiles_00C1
    dl RoomDataTiles_00C2
    dl RoomDataTiles_00C3
    dl RoomDataTiles_00C4
    dl RoomDataTiles_00C5
    dl RoomDataTiles_00C6
    dl RoomDataTiles_00C7
    dl RoomDataTiles_00C8
    dl RoomDataTiles_00C9
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00CB
    dl RoomDataTiles_00CC
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00CE
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00D0
    dl RoomDataTiles_00D1
    dl RoomDataTiles_00D2
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00D5
    dl RoomDataTiles_00D6
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00D8
    dl RoomDataTiles_00D9
    dl RoomDataTiles_00DA
    dl RoomDataTiles_00DB
    dl RoomDataTiles_00DC
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00DE
    dl RoomDataTiles_00DF
    dl RoomDataTiles_00E0
    dl RoomDataTiles_00E1
    dl RoomDataTiles_00E2
    dl RoomDataTiles_00E3
    dl RoomDataTiles_00E4
    dl RoomDataTiles_00E5
    dl RoomDataTiles_00E6
    dl RoomDataTiles_00E7
    dl RoomDataTiles_00E8
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00EA
    dl RoomDataTiles_00EB
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00ED
    dl RoomDataTiles_00EE
    dl RoomDataTiles_00EF
    dl RoomDataTiles_00F0
    dl RoomDataTiles_00F1
    dl RoomDataTiles_00F2
    dl RoomDataTiles_00F3
    dl RoomDataTiles_00F4
    dl RoomDataTiles_00F5
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00F8
    dl RoomDataTiles_00F9
    dl RoomDataTiles_00FA
    dl RoomDataTiles_00FB
    dl RoomDataTiles_Empty
    dl RoomDataTiles_00FD
    dl RoomDataTiles_00FE
    dl RoomDataTiles_00FF
    dl RoomDataTiles_0100
    dl RoomDataTiles_0101
    dl RoomDataTiles_0102
    dl RoomDataTiles_0103
    dl RoomDataTiles_0104
    dl RoomDataTiles_0105
    dl RoomDataTiles_0106
    dl RoomDataTiles_0107
    dl RoomDataTiles_0108
    dl RoomDataTiles_0109
    dl RoomDataTiles_010A
    dl RoomDataTiles_010B
    dl RoomDataTiles_010C
    dl RoomDataTiles_010D
    dl RoomDataTiles_010E
    dl RoomDataTiles_010F
    dl RoomDataTiles_0110
    dl RoomDataTiles_0111
    dl RoomDataTiles_0112
    dl RoomDataTiles_0113
    dl RoomDataTiles_0114
    dl RoomDataTiles_0115
    dl RoomDataTiles_0116
    dl RoomDataTiles_0117
    dl RoomDataTiles_0118
    dl RoomDataTiles_0119
    dl RoomDataTiles_011A
    dl RoomDataTiles_011B
    dl RoomDataTiles_011C
    dl RoomDataTiles_011D
    dl RoomDataTiles_011E
    dl RoomDataTiles_011F
    dl RoomDataTiles_0120
    dl RoomDataTiles_0121
    dl RoomDataTiles_0122
    dl RoomDataTiles_0123
    dl RoomDataTiles_0124
    dl RoomDataTiles_0125
    dl RoomDataTiles_0126
    dl RoomDataTiles_0125
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_0033
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
    dl RoomDataTiles_Empty
}

; ==============================================================================

; $0F83C0-$0F877F
RoomData_DoorDataPointers:
{
    dl RoomDataTiles_0000+$004D
    dl RoomDataTiles_0001+$0086
    dl RoomDataTiles_0002+$00F2
    dl RoomDataTiles_0003+$0026
    dl RoomDataTiles_0004+$0089
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0006+$0038
    dl RoomDataTiles_0007+$0137
    dl RoomDataTiles_0008+$00B3
    dl RoomDataTiles_0009+$0059
    dl RoomDataTiles_000A+$00B6
    dl RoomDataTiles_000B+$00B9
    dl RoomDataTiles_000C+$010D
    dl RoomDataTiles_000D+$0038
    dl RoomDataTiles_000E+$0089
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0010+$00DD
    dl RoomDataTiles_0011+$00B3
    dl RoomDataTiles_0012+$00C8
    dl RoomDataTiles_0013+$0035
    dl RoomDataTiles_0014+$01C1
    dl RoomDataTiles_0015+$01CA
    dl RoomDataTiles_0016+$012B
    dl RoomDataTiles_0017+$010A
    dl RoomDataTiles_0018+$008C
    dl RoomDataTiles_0019+$00CE
    dl RoomDataTiles_001A+$00CE
    dl RoomDataTiles_001B+$0080
    dl RoomDataTiles_001C+$003B
    dl RoomDataTiles_001D+$0047
    dl RoomDataTiles_001E+$00DD
    dl RoomDataTiles_001F+$0047
    dl RoomDataTiles_000D+$0038
    dl RoomDataTiles_0021+$00D4
    dl RoomDataTiles_0022+$009B
    dl RoomDataTiles_0023+$0047
    dl RoomDataTiles_0024+$00AA
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0026+$00F8
    dl RoomDataTiles_0027+$013D
    dl RoomDataTiles_0028+$0119
    dl RoomDataTiles_0029+$0068
    dl RoomDataTiles_002A+$0197
    dl RoomDataTiles_002B+$00C5
    dl RoomDataTiles_002C+$00F8
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_002E+$0023
    dl RoomDataTiles_002F+$00E6
    dl RoomDataTiles_0030+$005C
    dl RoomDataTiles_0031+$00DD
    dl RoomDataTiles_0032+$0074
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0034+$013D
    dl RoomDataTiles_0035+$015E
    dl RoomDataTiles_0036+$01E5
    dl RoomDataTiles_0037+$0131
    dl RoomDataTiles_0038+$00AD
    dl RoomDataTiles_0039+$004A
    dl RoomDataTiles_003A+$0182
    dl RoomDataTiles_003B+$010D
    dl RoomDataTiles_003C+$00C8
    dl RoomDataTiles_003D+$00B9
    dl RoomDataTiles_003E+$00AA
    dl RoomDataTiles_003F+$008F
    dl RoomDataTiles_0040+$0101
    dl RoomDataTiles_0041+$0080
    dl RoomDataTiles_0042+$0044
    dl RoomDataTiles_0043+$0062
    dl RoomDataTiles_0044+$0104
    dl RoomDataTiles_0045+$00D7
    dl RoomDataTiles_0046+$014C
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0049+$012B
    dl RoomDataTiles_004A+$00C5
    dl RoomDataTiles_004B+$00E0
    dl RoomDataTiles_004C+$006E
    dl RoomDataTiles_004D+$0119
    dl RoomDataTiles_004E+$009B
    dl RoomDataTiles_004F+$0059
    dl RoomDataTiles_0050+$00AD
    dl RoomDataTiles_0051+$0110
    dl RoomDataTiles_0052+$00C2
    dl RoomDataTiles_0053+$00AD
    dl RoomDataTiles_0054+$012B
    dl RoomDataTiles_0055+$011F
    dl RoomDataTiles_0056+$0098
    dl RoomDataTiles_0057+$007A
    dl RoomDataTiles_0058+$0116
    dl RoomDataTiles_0059+$00EF
    dl RoomDataTiles_005A+$001A
    dl RoomDataTiles_005B+$00A1
    dl RoomDataTiles_005C+$00A4
    dl RoomDataTiles_005D+$0065
    dl RoomDataTiles_005E+$00F8
    dl RoomDataTiles_005F+$0038
    dl RoomDataTiles_0060+$00D1
    dl RoomDataTiles_0061+$013D
    dl RoomDataTiles_0062+$0113
    dl RoomDataTiles_0063+$0038
    dl RoomDataTiles_0064+$0077
    dl RoomDataTiles_0065+$006E
    dl RoomDataTiles_0066+$01DC
    dl RoomDataTiles_0067+$0113
    dl RoomDataTiles_0068+$00E3
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_006A+$008F
    dl RoomDataTiles_006B+$0095
    dl RoomDataTiles_006C+$004A
    dl RoomDataTiles_006D+$0065
    dl RoomDataTiles_006E+$004D
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0070+$0032
    dl RoomDataTiles_0071+$00F2
    dl RoomDataTiles_0072+$010D
    dl RoomDataTiles_0073+$007D
    dl RoomDataTiles_0074+$00EC
    dl RoomDataTiles_0075+$004D
    dl RoomDataTiles_0076+$0170
    dl RoomDataTiles_0077+$0191
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_007B+$00D4
    dl RoomDataTiles_007C+$00BC
    dl RoomDataTiles_007D+$0113
    dl RoomDataTiles_007E+$0077
    dl RoomDataTiles_007F+$0059
    dl RoomDataTiles_0080+$009B
    dl RoomDataTiles_0081+$012B
    dl RoomDataTiles_0082+$0140
    dl RoomDataTiles_0083+$00FB
    dl RoomDataTiles_0084+$00F5
    dl RoomDataTiles_0085+$00C2
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0087+$00CB
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0089+$0065
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_008B+$012B
    dl RoomDataTiles_008C+$00A4
    dl RoomDataTiles_008D+$00E3
    dl RoomDataTiles_008E+$0020
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0090+$0014
    dl RoomDataTiles_0091+$005F
    dl RoomDataTiles_0092+$0092
    dl RoomDataTiles_0093+$009E
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0095+$007D
    dl RoomDataTiles_0096+$006E
    dl RoomDataTiles_0097+$00A7
    dl RoomDataTiles_0098+$0098
    dl RoomDataTiles_0099+$0089
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_009B+$00B6
    dl RoomDataTiles_009C+$011F
    dl RoomDataTiles_009D+$006E
    dl RoomDataTiles_009E+$0077
    dl RoomDataTiles_009F+$0065
    dl RoomDataTiles_00A0+$00B0
    dl RoomDataTiles_00A1+$00DA
    dl RoomDataTiles_00A2+$00EC
    dl RoomDataTiles_00A3+$0077
    dl RoomDataTiles_00A4+$0041
    dl RoomDataTiles_00A5+$00D7
    dl RoomDataTiles_00A6+$002F
    dl RoomDataTiles_00A7+$003E
    dl RoomDataTiles_00A8+$0155
    dl RoomDataTiles_00A9+$0134
    dl RoomDataTiles_00AA+$0152
    dl RoomDataTiles_00AB+$0023
    dl RoomDataTiles_00AC+$0029
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00AE+$0038
    dl RoomDataTiles_00AF+$0068
    dl RoomDataTiles_00B0+$007D
    dl RoomDataTiles_00B1+$00A7
    dl RoomDataTiles_00B2+$00EC
    dl RoomDataTiles_00B3+$0068
    dl RoomDataTiles_00B4+$00C2
    dl RoomDataTiles_00B5+$02FC
    dl RoomDataTiles_00B6+$0098
    dl RoomDataTiles_00B7+$0071
    dl RoomDataTiles_00B8+$003E
    dl RoomDataTiles_00B9+$018E
    dl RoomDataTiles_00BA+$0044
    dl RoomDataTiles_00BB+$00E0
    dl RoomDataTiles_00BC+$00FB
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00BE+$0041
    dl RoomDataTiles_004F+$0059
    dl RoomDataTiles_00C0+$00B3
    dl RoomDataTiles_00C1+$007D
    dl RoomDataTiles_00C2+$010D
    dl RoomDataTiles_00C3+$00AD
    dl RoomDataTiles_00C4+$0134
    dl RoomDataTiles_00C5+$009E
    dl RoomDataTiles_00C6+$018B
    dl RoomDataTiles_00C7+$0137
    dl RoomDataTiles_00C8+$0011
    dl RoomDataTiles_00C9+$00FB
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00CB+$015B
    dl RoomDataTiles_00CC+$014F
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00CE+$0050
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00D0+$00B0
    dl RoomDataTiles_00D1+$00D1
    dl RoomDataTiles_00D2+$0077
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00D5+$010A
    dl RoomDataTiles_00D6+$0122
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00D8+$0053
    dl RoomDataTiles_00D9+$007A
    dl RoomDataTiles_00DA+$0026
    dl RoomDataTiles_00DB+$0173
    dl RoomDataTiles_00DC+$015B
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00DE+$000B
    dl RoomDataTiles_00DF+$0077
    dl RoomDataTiles_00E0+$0065
    dl RoomDataTiles_00E1+$00CE
    dl RoomDataTiles_00E2+$0131
    dl RoomDataTiles_00E3+$00E9
    dl RoomDataTiles_00E4+$00DD
    dl RoomDataTiles_00E5+$0101
    dl RoomDataTiles_00E6+$00F5
    dl RoomDataTiles_00E7+$00DA
    dl RoomDataTiles_00E8+$00D1
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00EA+$008C
    dl RoomDataTiles_00EB+$0062
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00ED+$0137
    dl RoomDataTiles_00EE+$00CE
    dl RoomDataTiles_00EF+$0095
    dl RoomDataTiles_00F0+$0170
    dl RoomDataTiles_00F1+$0173
    dl RoomDataTiles_00F2+$0041
    dl RoomDataTiles_00F3+$0047
    dl RoomDataTiles_00F4+$0032
    dl RoomDataTiles_00F5+$0038
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00F8+$00E3
    dl RoomDataTiles_00F9+$0065
    dl RoomDataTiles_00FA+$0107
    dl RoomDataTiles_00FB+$0086
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_00FD+$00DA
    dl RoomDataTiles_00FE+$0077
    dl RoomDataTiles_00FF+$00AA
    dl RoomDataTiles_0100+$0047
    dl RoomDataTiles_0101+$007A
    dl RoomDataTiles_0102+$0059
    dl RoomDataTiles_0103+$00E6
    dl RoomDataTiles_0104+$0041
    dl RoomDataTiles_0105+$0068
    dl RoomDataTiles_0106+$00B3
    dl RoomDataTiles_0107+$0098
    dl RoomDataTiles_0108+$00B3
    dl RoomDataTiles_0109+$005C
    dl RoomDataTiles_010A+$00D4
    dl RoomDataTiles_010B+$00D7
    dl RoomDataTiles_010C+$00FE
    dl RoomDataTiles_010D+$0083
    dl RoomDataTiles_010E+$0125
    dl RoomDataTiles_010F+$004D
    dl RoomDataTiles_0110+$004A
    dl RoomDataTiles_0111+$003B
    dl RoomDataTiles_0112+$008F
    dl RoomDataTiles_0113+$006E
    dl RoomDataTiles_0114+$00C5
    dl RoomDataTiles_0115+$00F8
    dl RoomDataTiles_0116+$003E
    dl RoomDataTiles_0117+$0140
    dl RoomDataTiles_0118+$0053
    dl RoomDataTiles_0119+$0059
    dl RoomDataTiles_011A+$0062
    dl RoomDataTiles_011B+$00DD
    dl RoomDataTiles_011C+$009B
    dl RoomDataTiles_011D+$007A
    dl RoomDataTiles_011E+$008C
    dl RoomDataTiles_011F+$0098
    dl RoomDataTiles_0120+$0083
    dl RoomDataTiles_0121+$0023
    dl RoomDataTiles_0122+$006E
    dl RoomDataTiles_0123+$0053
    dl RoomDataTiles_0124+$0038
    dl RoomDataTiles_0125+$004D
    dl RoomDataTiles_0126+$007A
    dl RoomDataTiles_0125+$004D
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_0033+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
    dl RoomDataTiles_Empty+$0008
}

; ==============================================================================

; $0F8780-$0FFF4D DATA
RoomDataBank1F:
{
    ; ===========================================================================
    ; Empty room
    ; ===========================================================================

    ; $0F8780
    RoomDataTiles_Empty:
    incbin "bin/rooms/room0005.bin" ; Size: 0x000A

    ; ===========================================================================
    ; Desert Palace
    ; ===========================================================================

    ; $0F878A
    RoomDataTiles_0033:
    incbin "bin/rooms/room0033.bin" ; Size: 0x000C

    ; $0F8796
    RoomDataTiles_0043:
    incbin "bin/rooms/room0043.bin" ; Size: 0x006A

    ; $0F8800
    RoomDataTiles_0053:
    incbin "bin/rooms/room0053.bin" ; Size: 0x00B5

    ; $0F88B5
    RoomDataTiles_0063:
    incbin "bin/rooms/room0063.bin" ; Size: 0x0040

    ; $0F88F5
    RoomDataTiles_0073:
    incbin "bin/rooms/room0073.bin" ; Size: 0x0085

    ; $0F897A
    RoomDataTiles_0074:
    incbin "bin/rooms/room0074.bin" ; Size: 0x00F2

    ; $0F8A6C
    RoomDataTiles_0075:
    incbin "bin/rooms/room0075.bin" ; Size: 0x0053

    ; $0F8ABF
    RoomDataTiles_0083:
    incbin "bin/rooms/room0083.bin" ; Size: 0x0103

    ; $0F8BC2
    RoomDataTiles_0084:
    incbin "bin/rooms/room0084.bin" ; Size: 0x00F9

    ; $0F8CBB
    RoomDataTiles_0085:
    incbin "bin/rooms/room0085.bin" ; Size: 0x00CC

    ; ===========================================================================
    ; Agahnim's Tower
    ; ===========================================================================

    ; $0F8D87
    RoomDataTiles_0030:
    incbin "bin/rooms/room0030.bin" ; Size: 0x0062

    ; $0F8DE9
    RoomDataTiles_0040:
    incbin "bin/rooms/room0040.bin" ; Size: 0x0105

    ; $0F8EEE
    RoomDataTiles_00B0:
    incbin "bin/rooms/room00B0.bin" ; Size: 0x0085

    ; $0F8F73
    RoomDataTiles_00C0:
    incbin "bin/rooms/room00C0.bin" ; Size: 0x00BB

    ; $0F902E
    RoomDataTiles_00D0:
    incbin "bin/rooms/room00D0.bin" ; Size: 0x00B6

    ; $0F90E4
    RoomDataTiles_00E0:
    incbin "bin/rooms/room00E0.bin" ; Size: 0x006F

    ; $0F9153
    RoomDataTiles_000D:
    incbin "bin/rooms/room000D.bin" ; Size: 0x003C

    ; ===========================================================================
    ; Swamp Palace
    ; ===========================================================================

    ; $0F918F
    RoomDataTiles_0028:
    incbin "bin/rooms/room0028.bin" ; Size: 0x011F

    ; $0F92AE
    RoomDataTiles_0038:
    incbin "bin/rooms/room0038.bin" ; Size: 0x00B3

    ; $0F9361
    RoomDataTiles_0037:
    incbin "bin/rooms/room0037.bin" ; Size: 0x013F

    ; $0F94A0
    RoomDataTiles_0036:
    incbin "bin/rooms/room0036.bin" ; Size: 0x01F3

    ; $0F9693
    RoomDataTiles_0035:
    incbin "bin/rooms/room0035.bin" ; Size: 0x016C

    ; $0F97FF
    RoomDataTiles_0034:
    incbin "bin/rooms/room0034.bin" ; Size: 0x0143

    ; $0F9942
    RoomDataTiles_0054:
    incbin "bin/rooms/room0054.bin" ; Size: 0x012D

    ; $0F9A6F
    RoomDataTiles_0046:
    incbin "bin/rooms/room0046.bin" ; Size: 0x0154

    ; $0F9BC3
    RoomDataTiles_0026:
    incbin "bin/rooms/room0026.bin" ; Size: 0x0102

    ; $0F9CC5
    RoomDataTiles_0076:
    incbin "bin/rooms/room0076.bin" ; Size: 0x017A

    ; $0F9E3F
    RoomDataTiles_0066:
    incbin "bin/rooms/room0066.bin" ; Size: 0x01E6

    ; $0FA025
    RoomDataTiles_0016:
    incbin "bin/rooms/room0016.bin" ; Size: 0x0135

    ; $0FA15A
    RoomDataTiles_0006:
    incbin "bin/rooms/room0006.bin" ; Size: 0x003C

    ; ===========================================================================
    ; Unused room I found
    ; ===========================================================================

    ; $0FA196
    RoomDataTiles_Orphan:
    incbin "bin/rooms/unused-1FA196.bin" ; Size: 0x000C

    ; ===========================================================================
    ; Palace of Darkness
    ; ===========================================================================

    ; $0FA1A2
    RoomDataTiles_004A:
    incbin "bin/rooms/room004A.bin" ; Size: 0x00D1

    ; $0FA273
    RoomDataTiles_003A:
    incbin "bin/rooms/room003A.bin" ; Size: 0x018A

    ; $0FA3FD
    RoomDataTiles_002A:
    incbin "bin/rooms/room002A.bin" ; Size: 0x01A5

    ; $0FA5A2
    RoomDataTiles_001A:
    incbin "bin/rooms/room001A.bin" ; Size: 0x00DC

    ; $0FA67E
    RoomDataTiles_000A:
    incbin "bin/rooms/room000A.bin" ; Size: 0x00BA

    ; $0FA738
    RoomDataTiles_006A:
    incbin "bin/rooms/room006A.bin" ; Size: 0x0093

    ; $0FA7CB
    RoomDataTiles_005A:
    incbin "bin/rooms/room005A.bin" ; Size: 0x001E

    ; $0FA7E9
    RoomDataTiles_004B:
    incbin "bin/rooms/room004B.bin" ; Size: 0x00E8

    ; $0FA8D1
    RoomDataTiles_003B:
    incbin "bin/rooms/room003B.bin" ; Size: 0x0111

    ; $0FA9E2
    RoomDataTiles_002B:
    incbin "bin/rooms/room002B.bin" ; Size: 0x00CF

    ; $0FAAB1
    RoomDataTiles_001B:
    incbin "bin/rooms/room001B.bin" ; Size: 0x0086

    ; $0FAB37
    RoomDataTiles_000B:
    incbin "bin/rooms/room000B.bin" ; Size: 0x00C1

    ; $0FABF8
    RoomDataTiles_0019:
    incbin "bin/rooms/room0019.bin" ; Size: 0x00D4

    ; $0FACCC
    RoomDataTiles_0009:
    incbin "bin/rooms/room0009.bin" ; Size: 0x005B

    ; ===========================================================================
    ; Unused rooms Zarby found
    ; ===========================================================================

    ; $0FAD27
    RoomDataTiles_Zarby89:
    incbin "bin/rooms/unused-1FAD27.bin" ; Size: 0x00CA

    ; $0FADF1
    RoomDataTiles_Zarby90:
    incbin "bin/rooms/unused-1FADF1.bin" ; Size: 0x00D2

    ; ===========================================================================
    ; Misery Mire
    ; ===========================================================================

    ; $0FAEC3
    RoomDataTiles_0098:
    incbin "bin/rooms/room0098.bin" ; Size: 0x009C

    ; $0FAF5F
    RoomDataTiles_00D2:
    incbin "bin/rooms/room00D2.bin" ; Size: 0x007B

    ; $0FAFDA
    RoomDataTiles_00C2:
    incbin "bin/rooms/room00C2.bin" ; Size: 0x011F

    ; $0FB0F9
    RoomDataTiles_00C1:
    incbin "bin/rooms/room00C1.bin" ; Size: 0x008F

    ; $0FB188
    RoomDataTiles_00D1:
    incbin "bin/rooms/room00D1.bin" ; Size: 0x00DB

    ; $0FB263
    RoomDataTiles_0097:
    incbin "bin/rooms/room0097.bin" ; Size: 0x00AD

    ; $0FB310
    RoomDataTiles_00B1:
    incbin "bin/rooms/room00B1.bin" ; Size: 0x00B1

    ; $0FB3C1
    RoomDataTiles_00B2:
    incbin "bin/rooms/room00B2.bin" ; Size: 0x00FE

    ; $0FB4BF
    RoomDataTiles_00C3:
    incbin "bin/rooms/room00C3.bin" ; Size: 0x00BD

    ; $0FB57C
    RoomDataTiles_00B3:
    incbin "bin/rooms/room00B3.bin" ; Size: 0x0074

    ; $0FB5F0
    RoomDataTiles_00A3:
    incbin "bin/rooms/room00A3.bin" ; Size: 0x007D

    ; $0FB66D
    RoomDataTiles_00A2:
    incbin "bin/rooms/room00A2.bin" ; Size: 0x00F6

    ; $0FB763
    RoomDataTiles_00A1:
    incbin "bin/rooms/room00A1.bin" ; Size: 0x00E0

    ; $0FB843
    RoomDataTiles_0093:
    incbin "bin/rooms/room0093.bin" ; Size: 0x00A6

    ; $0FB8E9
    RoomDataTiles_0092:
    incbin "bin/rooms/room0092.bin" ; Size: 0x009E

    ; $0FB987
    RoomDataTiles_0091:
    incbin "bin/rooms/room0091.bin" ; Size: 0x0063

    ; $0FB9EA
    RoomDataTiles_00A0:
    incbin "bin/rooms/room00A0.bin" ; Size: 0x00B4

    ; $0FBA9E
    RoomDataTiles_0090:
    incbin "bin/rooms/room0090.bin" ; Size: 0x0018

    ; ===========================================================================
    ; Skull Woods
    ; ===========================================================================

    ; $0FBAB6
    RoomDataTiles_0056:
    incbin "bin/rooms/room0056.bin" ; Size: 0x00A2

    ; $0FBB58
    RoomDataTiles_0057:
    incbin "bin/rooms/room0057.bin" ; Size: 0x0088

    ; $0FBBE0
    RoomDataTiles_0058:
    incbin "bin/rooms/room0058.bin" ; Size: 0x0124

    ; $0FBD04
    RoomDataTiles_0067:
    incbin "bin/rooms/room0067.bin" ; Size: 0x011B

    ; $0FBE1F
    RoomDataTiles_0068:
    incbin "bin/rooms/room0068.bin" ; Size: 0x00E9

    ; $0FBF08
    RoomDataTiles_0059:
    incbin "bin/rooms/room0059.bin" ; Size: 0x00F9

    ; $0FC001
    RoomDataTiles_0049:
    incbin "bin/rooms/room0049.bin" ; Size: 0x0135

    ; $0FC136
    RoomDataTiles_0039:
    incbin "bin/rooms/room0039.bin" ; Size: 0x0050

    ; $0FC186
    RoomDataTiles_0029:
    incbin "bin/rooms/room0029.bin" ; Size: 0x006A

    ; ===========================================================================
    ; Ice Palace
    ; ===========================================================================

    ; $0FC1F0
    RoomDataTiles_000E:
    incbin "bin/rooms/room000E.bin" ; Size: 0x0091

    ; $0FC281
    RoomDataTiles_001E:
    incbin "bin/rooms/room001E.bin" ; Size: 0x00E7

    ; $0FC368
    RoomDataTiles_001F:
    incbin "bin/rooms/room001F.bin" ; Size: 0x004D

    ; $0FC3B5
    RoomDataTiles_002E:
    incbin "bin/rooms/room002E.bin" ; Size: 0x0027

    ; $0FC3DC
    RoomDataTiles_003E:
    incbin "bin/rooms/room003E.bin" ; Size: 0x00B0

    ; $0FC48C
    RoomDataTiles_003F:
    incbin "bin/rooms/room003F.bin" ; Size: 0x0093

    ; $0FC51F
    RoomDataTiles_004E:
    incbin "bin/rooms/room004E.bin" ; Size: 0x00A1

    ; $0FC5C0
    RoomDataTiles_005E:
    incbin "bin/rooms/room005E.bin" ; Size: 0x0102

    ; $0FC6C2
    RoomDataTiles_005F:
    incbin "bin/rooms/room005F.bin" ; Size: 0x003C

    ; $0FC6FE
    RoomDataTiles_006E:
    incbin "bin/rooms/room006E.bin" ; Size: 0x0051

    ; $0FC74F
    RoomDataTiles_007E:
    incbin "bin/rooms/room007E.bin" ; Size: 0x007F

    ; $0FC7CE
    RoomDataTiles_007F:
    incbin "bin/rooms/room007F.bin" ; Size: 0x005F

    ; $0FC82D
    RoomDataTiles_008E:
    incbin "bin/rooms/room008E.bin" ; Size: 0x0024

    ; $0FC851
    RoomDataTiles_009E:
    incbin "bin/rooms/room009E.bin" ; Size: 0x0081

    ; $0FC8D2
    RoomDataTiles_009F:
    incbin "bin/rooms/room009F.bin" ; Size: 0x006B

    ; $0FC93D
    RoomDataTiles_00AE:
    incbin "bin/rooms/room00AE.bin" ; Size: 0x003C

    ; $0FC979
    RoomDataTiles_00AF:
    incbin "bin/rooms/room00AF.bin" ; Size: 0x006E

    ; $0FC9E7
    RoomDataTiles_00BE:
    incbin "bin/rooms/room00BE.bin" ; Size: 0x0049

    ; $0FCA30
    RoomDataTiles_004F:
    incbin "bin/rooms/room004F.bin" ; Size: 0x005D

    ; $0FCA8D
    RoomDataTiles_00CE:
    incbin "bin/rooms/room00CE.bin" ; Size: 0x0054

    ; $0FCAE1
    RoomDataTiles_00DE:
    incbin "bin/rooms/room00DE.bin" ; Size: 0x000D

    ; ===========================================================================
    ; Tower of Hera
    ; ===========================================================================

    ; $0FCAEE
    RoomDataTiles_0007:
    incbin "bin/rooms/room0007.bin" ; Size: 0x0139

    ; $0FCC27
    RoomDataTiles_0017:
    incbin "bin/rooms/room0017.bin" ; Size: 0x010C

    ; $0FCD33
    RoomDataTiles_0027:
    incbin "bin/rooms/room0027.bin" ; Size: 0x013F

    ; $0FCE72
    RoomDataTiles_0031:
    incbin "bin/rooms/room0031.bin" ; Size: 0x00E3

    ; $0FCF55
    RoomDataTiles_0077:
    incbin "bin/rooms/room0077.bin" ; Size: 0x0197

    ; $0FD0EC
    RoomDataTiles_0087:
    incbin "bin/rooms/room0087.bin" ; Size: 0x00D1

    ; $0FD1BD
    RoomDataTiles_00A7:
    incbin "bin/rooms/room00A7.bin" ; Size: 0x0040

    ; ===========================================================================
    ; Thieves' Town
    ; ===========================================================================

    ; $0FD1FD
    RoomDataTiles_00DB:
    incbin "bin/rooms/room00DB.bin" ; Size: 0x0179

    ; $0FD376
    RoomDataTiles_00DC:
    incbin "bin/rooms/room00DC.bin" ; Size: 0x015F

    ; $0FD4D5
    RoomDataTiles_00CB:
    incbin "bin/rooms/room00CB.bin" ; Size: 0x015F

    ; $0FD634
    RoomDataTiles_00CC:
    incbin "bin/rooms/room00CC.bin" ; Size: 0x0157

    ; $0FD78B
    RoomDataTiles_00BB:
    incbin "bin/rooms/room00BB.bin" ; Size: 0x00EE

    ; $0FD879
    RoomDataTiles_00BC:
    incbin "bin/rooms/room00BC.bin" ; Size: 0x010D

    ; $0FD986
    RoomDataTiles_00AB:
    incbin "bin/rooms/room00AB.bin" ; Size: 0x0029

    ; $0FD9AF
    RoomDataTiles_00AC:
    incbin "bin/rooms/room00AC.bin" ; Size: 0x002D

    ; $0FD9DC
    RoomDataTiles_0064:
    incbin "bin/rooms/room0064.bin" ; Size: 0x007B

    ; $0FDA57
    RoomDataTiles_0065:
    incbin "bin/rooms/room0065.bin" ; Size: 0x0072

    ; $0FDAC9
    RoomDataTiles_0044:
    incbin "bin/rooms/room0044.bin" ; Size: 0x010E

    ; $0FDBD7
    RoomDataTiles_0045:
    incbin "bin/rooms/room0045.bin" ; Size: 0x00E1

    ; ===========================================================================
    ; Turtle Rock
    ; ===========================================================================

    ; $0FDCB8
    RoomDataTiles_00B6:
    incbin "bin/rooms/room00B6.bin" ; Size: 0x00A4

    ; $0FDD5C
    RoomDataTiles_00B7:
    incbin "bin/rooms/room00B7.bin" ; Size: 0x0075

    ; $0FDDD1
    RoomDataTiles_00C6:
    incbin "bin/rooms/room00C6.bin" ; Size: 0x0199

    ; $0FDF6A
    RoomDataTiles_00C7:
    incbin "bin/rooms/room00C7.bin" ; Size: 0x013F

    ; $0FE0A9
    RoomDataTiles_00D6:
    incbin "bin/rooms/room00D6.bin" ; Size: 0x012A

    ; $0FE1D3
    RoomDataTiles_0004:
    incbin "bin/rooms/room0004.bin" ; Size: 0x0095

    ; $0FE268
    RoomDataTiles_0013:
    incbin "bin/rooms/room0013.bin" ; Size: 0x003B

    ; $0FE2A3
    RoomDataTiles_0014:
    incbin "bin/rooms/room0014.bin" ; Size: 0x01D1

    ; $0FE171
    RoomDataTiles_0015:
    incbin "bin/rooms/room0015.bin" ; Size: 0x01D0

    ; $0FE644
    RoomDataTiles_0024:
    incbin "bin/rooms/room0024.bin" ; Size: 0x00BC

    ; $0FE700
    RoomDataTiles_00A4:
    incbin "bin/rooms/room00A4.bin" ; Size: 0x0045

    ; $0FE745
    RoomDataTiles_00B4:
    incbin "bin/rooms/room00B4.bin" ; Size: 0x00C6

    ; $0FE80B
    RoomDataTiles_00B5:
    incbin "bin/rooms/room00B5.bin" ; Size: 0x0300

    ; $0FEB0B
    RoomDataTiles_00C4:
    incbin "bin/rooms/room00C4.bin" ; Size: 0x0138

    ; $0FEC43
    RoomDataTiles_00C5:
    incbin "bin/rooms/room00C5.bin" ; Size: 0x00A6

    ; $0FECE9
    RoomDataTiles_0023:
    incbin "bin/rooms/room0023.bin" ; Size: 0x004D

    ; $0FED36
    RoomDataTiles_00D5:
    incbin "bin/rooms/room00D5.bin" ; Size: 0x0110

    ; ===========================================================================
    ; Ganon's Tower
    ; ===========================================================================

    ; $0FEE46
    RoomDataTiles_000C:
    incbin "bin/rooms/room000C.bin" ; Size: 0x0111

    ; $0FEF57
    RoomDataTiles_007B:
    incbin "bin/rooms/room007B.bin" ; Size: 0x00DC

    ; $0FF033
    RoomDataTiles_007C:
    incbin "bin/rooms/room007C.bin" ; Size: 0x00C6

    ; $0FF0F9
    RoomDataTiles_007D:
    incbin "bin/rooms/room007D.bin" ; Size: 0x011B

    ; $0FF214
    RoomDataTiles_008B:
    incbin "bin/rooms/room008B.bin" ; Size: 0x0137

    ; $0FF34B
    RoomDataTiles_008C:
    incbin "bin/rooms/room008C.bin" ; Size: 0x00B2

    ; $0FF3FD
    RoomDataTiles_008D:
    incbin "bin/rooms/room008D.bin" ; Size: 0x00EF

    ; $0FF4EC
    RoomDataTiles_009B:
    incbin "bin/rooms/room009B.bin" ; Size: 0x00BE

    ; $0FF5AA
    RoomDataTiles_009C:
    incbin "bin/rooms/room009C.bin" ; Size: 0x0129

    ; $0FF6D3
    RoomDataTiles_009D:
    incbin "bin/rooms/room009D.bin" ; Size: 0x0076

    ; $0FF749
    RoomDataTiles_001C:
    incbin "bin/rooms/room001C.bin" ; Size: 0x0043

    ; $0FF78C
    RoomDataTiles_006B:
    incbin "bin/rooms/room006B.bin" ; Size: 0x009F

    ; $0FF82B
    RoomDataTiles_005B:
    incbin "bin/rooms/room005B.bin" ; Size: 0x00A7

    ; $0FF8D2
    RoomDataTiles_005C:
    incbin "bin/rooms/room005C.bin" ; Size: 0x00AA

    ; $0FF97C
    RoomDataTiles_005D:
    incbin "bin/rooms/room005D.bin" ; Size: 0x006D

    ; $0FF9E9
    RoomDataTiles_006D:
    incbin "bin/rooms/room006D.bin" ; Size: 0x006D

    ; $0FFA56
    RoomDataTiles_006C:
    incbin "bin/rooms/room006C.bin" ; Size: 0x0052

    ; $0FFAA8
    RoomDataTiles_00A5:
    incbin "bin/rooms/room00A5.bin" ; Size: 0x00DF

    ; $0FFB87
    RoomDataTiles_0095:
    incbin "bin/rooms/room0095.bin" ; Size: 0x0083

    ; $0FFC0A
    RoomDataTiles_0096:
    incbin "bin/rooms/room0096.bin" ; Size: 0x0074

    ; $0FFC7E
    RoomDataTiles_003D:
    incbin "bin/rooms/room003D.bin" ; Size: 0x00C3

    ; $0FFD41
    RoomDataTiles_004D:
    incbin "bin/rooms/room004D.bin" ; Size: 0x011F

    ; $0FFE60
    RoomDataTiles_004C:
    incbin "bin/rooms/room004C.bin" ; Size: 0x0072

    ; $0FFED2
    RoomDataTiles_001D:
    incbin "bin/rooms/room001D.bin" ; Size: 0x004B

    ; $0FFF1D
    RoomDataTiles_00A6:
    incbin "bin/rooms/room00A6.bin" ; Size: 0x0031
}

; ==============================================================================

; $0FFF4E-$0FFFFF NULL
NULL_1FFF4E:
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
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF
}

; ==============================================================================

warnpc $208000