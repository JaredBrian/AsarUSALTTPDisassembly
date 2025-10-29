; ==============================================================================

; Bank 1A
; $0D0000-$0D7FFF
org $1A8000

; SPC engine
; Music data
; Misc sprite draw

; ==============================================================================

; The later half of the SPC engine is right here and spills over from bank 19.
; TODO: Figure out how to represent that code.

; ==============================================================================

; $0D0B6C-1A9BFF DATA
org $1A8B6C
SFX_Data:
{
    ; Transfer size, transfer address
    dw $1090, SFX_DATA

    ; SPC $17C0-$2850 DATA
    base SFX_DATA

    ; ==========================================================================

    ; SPC $17C0-$17FF DATA
    ; $0D0B70-$0D0BAF DATA
    SFX1_Pointers:
    {
        dw SFX1_01
        dw SFX1_02
        dw SFX1_03
        dw SFX1_04
        dw SFX1_05
        dw SFX1_05
        dw SFX1_07
        dw SFX1_08
        dw SFX1_09
        dw SFX1_0A
        dw SFX1_0B
        dw SFX1_0C
        dw SFX1_0D
        dw SFX1_0E
        dw SFX1_0F
        dw SFX1_10
        dw SFX1_11
        dw SFX1_12
        dw SFX1_13
        dw SFX1_14
        dw SFX1_15
        dw SFX1_16
        dw SFX1_17
        dw SFX1_18
        dw $0000
        dw $0000
        dw SFX1_0B ; TODO: Are these supposed to be duplicates?
        dw SFX1_0C
        dw SFX1_0D
        dw SFX1_0E
        dw SFX1_0F
        dw SFX1_10
    }

    ; ==========================================================================

    ; SPC $1800-$181F DATA
    ; $0D0BB0-$0D0BCF DATA
    SFX1_Accomp:
    {
        db $02 ; SFX1 01
        db $00 ; SFX1 02
        db $04 ; SFX1 03
        db $00 ; SFX1 04
        db $06 ; SFX1 05
        db $00 ; SFX1 06
        db $08 ; SFX1 07
        db $00 ; SFX1 08
        db $0A ; SFX1 09
        db $00 ; SFX1 0A
        db $0C ; SFX1 0B
        db $00 ; SFX1 0C
        db $0E ; SFX1 0D
        db $00 ; SFX1 0E
        db $10 ; SFX1 0F
        db $00 ; SFX1 10
        db $12 ; SFX1 11
        db $00 ; SFX1 12
        db $14 ; SFX1 13
        db $00 ; SFX1 14
        db $16 ; SFX1 15
        db $00 ; SFX1 16
        db $18 ; SFX1 17
        db $00 ; SFX1 18
        db $1A ; SFX1 19
        db $00 ; SFX1 1A
        db $1C ; SFX1 1B
        db $00 ; SFX1 1C
        db $1E ; SFX1 1D
        db $00 ; SFX1 1E
        db $20 ; SFX1 1F
        db $00 ; SFX1 20
    }

    ; ==========================================================================

SFX2_Pointers:
#_1A8BD0: #_1820: dw SFX2_01
#_1A8BD2: #_1822: dw SFX2_02
#_1A8BD4: #_1824: dw SFX2_03
#_1A8BD6: #_1826: dw SFX2_04
#_1A8BD8: #_1828: dw SFX2_05
#_1A8BDA: #_182A: dw SFX2_06
#_1A8BDC: #_182C: dw SFX2_07
#_1A8BDE: #_182E: dw SFX2_08
#_1A8BE0: #_1830: dw SFX2_09
#_1A8BE2: #_1832: dw SFX2_0A
#_1A8BE4: #_1834: dw SFX2_0B
#_1A8BE6: #_1836: dw SFX2_0C
#_1A8BE8: #_1838: dw SFX2_0D
#_1A8BEA: #_183A: dw SFX2_0E
#_1A8BEC: #_183C: dw SFX2_0F
#_1A8BEE: #_183E: dw SFX2_10
#_1A8BF0: #_1840: dw SFX2_11
#_1A8BF2: #_1842: dw SFX2_12
#_1A8BF4: #_1844: dw SFX2_13
#_1A8BF6: #_1846: dw SFX2_14
#_1A8BF8: #_1848: dw SFX2_15
#_1A8BFA: #_184A: dw SFX2_16
#_1A8BFC: #_184C: dw SFX2_17
#_1A8BFE: #_184E: dw SFX2_18
#_1A8C00: #_1850: dw SFX2_19
#_1A8C02: #_1852: dw SFX2_1A
#_1A8C04: #_1854: dw SFX2_1B
#_1A8C06: #_1856: dw SFX2_1C
#_1A8C08: #_1858: dw SFX2_1D
#_1A8C0A: #_185A: dw SFX2_1E
#_1A8C0C: #_185C: dw SFX2_1F
#_1A8C0E: #_185E: dw SFX2_20
#_1A8C10: #_1860: dw SFX2_21
#_1A8C12: #_1862: dw SFX2_22
#_1A8C14: #_1864: dw SFX2_23
#_1A8C16: #_1866: dw SFX2_24
#_1A8C18: #_1868: dw SFX2_25
#_1A8C1A: #_186A: dw SFX2_26
#_1A8C1C: #_186C: dw SFX2_27
#_1A8C1E: #_186E: dw SFX2_28
#_1A8C20: #_1870: dw SFX2_29
#_1A8C22: #_1872: dw SFX2_2A
#_1A8C24: #_1874: dw SFX2_2B
#_1A8C26: #_1876: dw SFX2_2C
#_1A8C28: #_1878: dw SFX2_2D
#_1A8C2A: #_187A: dw SFX2_2E
#_1A8C2C: #_187C: dw SFX2_2F
#_1A8C2E: #_187E: dw SFX2_30
#_1A8C30: #_1880: dw SFX2_31
#_1A8C32: #_1882: dw SFX2_32
#_1A8C34: #_1884: dw SFX2_33
#_1A8C36: #_1886: dw SFX2_34
#_1A8C38: #_1888: dw SFX2_35
#_1A8C3A: #_188A: dw SFX2_36
#_1A8C3C: #_188C: dw SFX2_37
#_1A8C3E: #_188E: dw SFX2_34
#_1A8C40: #_1890: dw SFX2_39
#_1A8C42: #_1892: dw SFX2_3A
#_1A8C44: #_1894: dw SFX2_3B
#_1A8C46: #_1896: dw SFX2_3C
#_1A8C48: #_1898: dw SFX2_3D
#_1A8C4A: #_189A: dw SFX2_3E
#_1A8C4C: #_189C: dw SFX2_3F

;---------------------------------------------------------------------------------------------------

SFX2_Accomp:
#_1A8C4E: #_189E: db $00 ; SFX2 01
#_1A8C4F: #_189F: db $00 ; SFX2 02
#_1A8C50: #_18A0: db $00 ; SFX2 03
#_1A8C51: #_18A1: db $00 ; SFX2 04
#_1A8C52: #_18A2: db $00 ; SFX2 05
#_1A8C53: #_18A3: db $00 ; SFX2 06
#_1A8C54: #_18A4: db $00 ; SFX2 07
#_1A8C55: #_18A5: db $00 ; SFX2 08
#_1A8C56: #_18A6: db $00 ; SFX2 09
#_1A8C57: #_18A7: db $00 ; SFX2 0A
#_1A8C58: #_18A8: db $00 ; SFX2 0B
#_1A8C59: #_18A9: db $00 ; SFX2 0C
#_1A8C5A: #_18AA: db $3F ; SFX2 0D
#_1A8C5B: #_18AB: db $00 ; SFX2 0E
#_1A8C5C: #_18AC: db $00 ; SFX2 0F
#_1A8C5D: #_18AD: db $00 ; SFX2 10
#_1A8C5E: #_18AE: db $00 ; SFX2 11
#_1A8C5F: #_18AF: db $00 ; SFX2 12
#_1A8C60: #_18B0: db $3E ; SFX2 13
#_1A8C61: #_18B1: db $00 ; SFX2 14
#_1A8C62: #_18B2: db $00 ; SFX2 15
#_1A8C63: #_18B3: db $00 ; SFX2 16
#_1A8C64: #_18B4: db $00 ; SFX2 17
#_1A8C65: #_18B5: db $00 ; SFX2 18
#_1A8C66: #_18B6: db $00 ; SFX2 19
#_1A8C67: #_18B7: db $00 ; SFX2 1A
#_1A8C68: #_18B8: db $00 ; SFX2 1B
#_1A8C69: #_18B9: db $00 ; SFX2 1C
#_1A8C6A: #_18BA: db $00 ; SFX2 1D
#_1A8C6B: #_18BB: db $00 ; SFX2 1E
#_1A8C6C: #_18BC: db $00 ; SFX2 1F
#_1A8C6D: #_18BD: db $00 ; SFX2 20
#_1A8C6E: #_18BE: db $00 ; SFX2 21
#_1A8C6F: #_18BF: db $00 ; SFX2 22
#_1A8C70: #_18C0: db $00 ; SFX2 23
#_1A8C71: #_18C1: db $3D ; SFX2 24
#_1A8C72: #_18C2: db $00 ; SFX2 25
#_1A8C73: #_18C3: db $00 ; SFX2 26
#_1A8C74: #_18C4: db $00 ; SFX2 27
#_1A8C75: #_18C5: db $00 ; SFX2 28
#_1A8C76: #_18C6: db $3B ; SFX2 29
#_1A8C77: #_18C7: db $00 ; SFX2 2A
#_1A8C78: #_18C8: db $00 ; SFX2 2B
#_1A8C79: #_18C9: db $3A ; SFX2 2C
#_1A8C7A: #_18CA: db $00 ; SFX2 2D
#_1A8C7B: #_18CB: db $39 ; SFX2 2E
#_1A8C7C: #_18CC: db $38 ; SFX2 2F
#_1A8C7D: #_18CD: db $00 ; SFX2 30
#_1A8C7E: #_18CE: db $00 ; SFX2 31
#_1A8C7F: #_18CF: db $00 ; SFX2 32
#_1A8C80: #_18D0: db $00 ; SFX2 33
#_1A8C81: #_18D1: db $33 ; SFX2 34
#_1A8C82: #_18D2: db $36 ; SFX2 35
#_1A8C83: #_18D3: db $00 ; SFX2 36
#_1A8C84: #_18D4: db $00 ; SFX2 37
#_1A8C85: #_18D5: db $00 ; SFX2 38
#_1A8C86: #_18D6: db $00 ; SFX2 39
#_1A8C87: #_18D7: db $00 ; SFX2 3A
#_1A8C88: #_18D8: db $00 ; SFX2 3B
#_1A8C89: #_18D9: db $00 ; SFX2 3C
#_1A8C8A: #_18DA: db $00 ; SFX2 3D
#_1A8C8B: #_18DB: db $00 ; SFX2 3E
#_1A8C8C: #_18DC: db $00 ; SFX2 3F

;---------------------------------------------------------------------------------------------------

SFX2_Echo:
#_1A8C8D: #_18DD: db $00 ; SFX2 01
#_1A8C8E: #_18DE: db $00 ; SFX2 02
#_1A8C8F: #_18DF: db $00 ; SFX2 03
#_1A8C90: #_18E0: db $00 ; SFX2 04
#_1A8C91: #_18E1: db $00 ; SFX2 05
#_1A8C92: #_18E2: db $00 ; SFX2 06
#_1A8C93: #_18E3: db $00 ; SFX2 07
#_1A8C94: #_18E4: db $00 ; SFX2 08
#_1A8C95: #_18E5: db $00 ; SFX2 09
#_1A8C96: #_18E6: db $00 ; SFX2 0A
#_1A8C97: #_18E7: db $00 ; SFX2 0B
#_1A8C98: #_18E8: db $01 ; SFX2 0C
#_1A8C99: #_18E9: db $00 ; SFX2 0D
#_1A8C9A: #_18EA: db $00 ; SFX2 0E
#_1A8C9B: #_18EB: db $00 ; SFX2 0F
#_1A8C9C: #_18EC: db $00 ; SFX2 10
#_1A8C9D: #_18ED: db $00 ; SFX2 11
#_1A8C9E: #_18EE: db $00 ; SFX2 12
#_1A8C9F: #_18EF: db $00 ; SFX2 13
#_1A8CA0: #_18F0: db $00 ; SFX2 14
#_1A8CA1: #_18F1: db $00 ; SFX2 15
#_1A8CA2: #_18F2: db $00 ; SFX2 16
#_1A8CA3: #_18F3: db $00 ; SFX2 17
#_1A8CA4: #_18F4: db $00 ; SFX2 18
#_1A8CA5: #_18F5: db $00 ; SFX2 19
#_1A8CA6: #_18F6: db $00 ; SFX2 1A
#_1A8CA7: #_18F7: db $00 ; SFX2 1B
#_1A8CA8: #_18F8: db $00 ; SFX2 1C
#_1A8CA9: #_18F9: db $00 ; SFX2 1D
#_1A8CAA: #_18FA: db $00 ; SFX2 1E
#_1A8CAB: #_18FB: db $00 ; SFX2 1F
#_1A8CAC: #_18FC: db $00 ; SFX2 20
#_1A8CAD: #_18FD: db $00 ; SFX2 21
#_1A8CAE: #_18FE: db $00 ; SFX2 22
#_1A8CAF: #_18FF: db $00 ; SFX2 23
#_1A8CB0: #_1900: db $00 ; SFX2 24
#_1A8CB1: #_1901: db $00 ; SFX2 25
#_1A8CB2: #_1902: db $00 ; SFX2 26
#_1A8CB3: #_1903: db $00 ; SFX2 27
#_1A8CB4: #_1904: db $00 ; SFX2 28
#_1A8CB5: #_1905: db $3B ; SFX2 29
#_1A8CB6: #_1906: db $01 ; SFX2 2A
#_1A8CB7: #_1907: db $01 ; SFX2 2B
#_1A8CB8: #_1908: db $00 ; SFX2 2C
#_1A8CB9: #_1909: db $01 ; SFX2 2D
#_1A8CBA: #_190A: db $01 ; SFX2 2E
#_1A8CBB: #_190B: db $01 ; SFX2 2F
#_1A8CBC: #_190C: db $00 ; SFX2 30
#_1A8CBD: #_190D: db $00 ; SFX2 31
#_1A8CBE: #_190E: db $00 ; SFX2 32
#_1A8CBF: #_190F: db $00 ; SFX2 33
#_1A8CC0: #_1910: db $00 ; SFX2 34
#_1A8CC1: #_1911: db $01 ; SFX2 35
#_1A8CC2: #_1912: db $01 ; SFX2 36
#_1A8CC3: #_1913: db $00 ; SFX2 37
#_1A8CC4: #_1914: db $00 ; SFX2 38
#_1A8CC5: #_1915: db $00 ; SFX2 39
#_1A8CC6: #_1916: db $00 ; SFX2 3A
#_1A8CC7: #_1917: db $00 ; SFX2 3B
#_1A8CC8: #_1918: db $01 ; SFX2 3C
#_1A8CC9: #_1919: db $00 ; SFX2 3D
#_1A8CCA: #_191A: db $3C ; SFX2 3E
#_1A8CCB: #_191B: db $00 ; SFX2 3F

;===================================================================================================

SFX3_Pointers:
#_1A8CCC: #_191C: dw SFX3_01
#_1A8CCE: #_191E: dw SFX3_02
#_1A8CD0: #_1920: dw SFX3_03
#_1A8CD2: #_1922: dw SFX3_04
#_1A8CD4: #_1924: dw SFX2_07
#_1A8CD6: #_1926: dw SFX3_06
#_1A8CD8: #_1928: dw SFX3_07
#_1A8CDA: #_192A: dw SFX3_08
#_1A8CDC: #_192C: dw SFX3_09
#_1A8CDE: #_192E: dw SFX3_0A
#_1A8CE0: #_1930: dw SFX3_0B
#_1A8CE2: #_1932: dw SFX3_0C
#_1A8CE4: #_1934: dw SFX3_0D
#_1A8CE6: #_1936: dw SFX3_0E
#_1A8CE8: #_1938: dw SFX3_0F
#_1A8CEA: #_193A: dw SFX3_10
#_1A8CEC: #_193C: dw SFX3_11
#_1A8CEE: #_193E: dw SFX3_12
#_1A8CF0: #_1940: dw SFX3_13
#_1A8CF2: #_1942: dw SFX3_14
#_1A8CF4: #_1944: dw SFX3_15
#_1A8CF6: #_1946: dw SFX3_16
#_1A8CF8: #_1948: dw SFX3_17
#_1A8CFA: #_194A: dw SFX3_18
#_1A8CFC: #_194C: dw SFX3_19
#_1A8CFE: #_194E: dw SFX3_1A
#_1A8D00: #_1950: dw SFX3_1B
#_1A8D02: #_1952: dw SFX3_1C
#_1A8D04: #_1954: dw SFX2_2D
#_1A8D06: #_1956: dw SFX3_1E
#_1A8D08: #_1958: dw SFX3_1F
#_1A8D0A: #_195A: dw SFX3_20
#_1A8D0C: #_195C: dw SFX3_21
#_1A8D0E: #_195E: dw SFX3_22
#_1A8D10: #_1960: dw SFX3_23
#_1A8D12: #_1962: dw SFX3_24
#_1A8D14: #_1964: dw SFX3_25
#_1A8D16: #_1966: dw SFX3_26
#_1A8D18: #_1968: dw SFX3_27
#_1A8D1A: #_196A: dw SFX3_28
#_1A8D1C: #_196C: dw SFX3_29
#_1A8D1E: #_196E: dw SFX3_2A
#_1A8D20: #_1970: dw SFX3_2B
#_1A8D22: #_1972: dw SFX3_2C
#_1A8D24: #_1974: dw SFX3_2D
#_1A8D26: #_1976: dw SFX3_2E
#_1A8D28: #_1978: dw SFX3_2F
#_1A8D2A: #_197A: dw SFX3_30
#_1A8D2C: #_197C: dw SFX3_31
#_1A8D2E: #_197E: dw SFX3_32
#_1A8D30: #_1980: dw SFX3_33
#_1A8D32: #_1982: dw SFX3_34
#_1A8D34: #_1984: dw SFX3_35
#_1A8D36: #_1986: dw SFX3_36
#_1A8D38: #_1988: dw SFX3_37
#_1A8D3A: #_198A: dw SFX3_38
#_1A8D3C: #_198C: dw SFX3_39
#_1A8D3E: #_198E: dw SFX3_3A
#_1A8D40: #_1990: dw SFX3_3B
#_1A8D42: #_1992: dw SFX3_3C
#_1A8D44: #_1994: dw SFX3_3D
#_1A8D46: #_1996: dw SFX3_3E
#_1A8D48: #_1998: dw SFX3_3F

;---------------------------------------------------------------------------------------------------

SFX3_Accomp:
#_1A8D4A: #_199A: db $00 ; SFX3 01
#_1A8D4B: #_199B: db $00 ; SFX3 02
#_1A8D4C: #_199C: db $00 ; SFX3 03
#_1A8D4D: #_199D: db $00 ; SFX3 04
#_1A8D4E: #_199E: db $00 ; SFX3 05
#_1A8D4F: #_199F: db $00 ; SFX3 06
#_1A8D50: #_19A0: db $00 ; SFX3 07
#_1A8D51: #_19A1: db $00 ; SFX3 08
#_1A8D52: #_19A2: db $00 ; SFX3 09
#_1A8D53: #_19A3: db $00 ; SFX3 0A
#_1A8D54: #_19A4: db $00 ; SFX3 0B
#_1A8D55: #_19A5: db $00 ; SFX3 0C
#_1A8D56: #_19A6: db $00 ; SFX3 0D
#_1A8D57: #_19A7: db $00 ; SFX3 0E
#_1A8D58: #_19A8: db $3C ; SFX3 0F
#_1A8D59: #_19A9: db $3B ; SFX3 10
#_1A8D5A: #_19AA: db $00 ; SFX3 11
#_1A8D5B: #_19AB: db $00 ; SFX3 12
#_1A8D5C: #_19AC: db $00 ; SFX3 13
#_1A8D5D: #_19AD: db $00 ; SFX3 14
#_1A8D5E: #_19AE: db $00 ; SFX3 15
#_1A8D5F: #_19AF: db $00 ; SFX3 16
#_1A8D60: #_19B0: db $00 ; SFX3 17
#_1A8D61: #_19B1: db $00 ; SFX3 18
#_1A8D62: #_19B2: db $00 ; SFX3 19
#_1A8D63: #_19B3: db $38 ; SFX3 1A
#_1A8D64: #_19B4: db $3A ; SFX3 1B
#_1A8D65: #_19B5: db $00 ; SFX3 1C
#_1A8D66: #_19B6: db $00 ; SFX3 1D
#_1A8D67: #_19B7: db $00 ; SFX3 1E
#_1A8D68: #_19B8: db $00 ; SFX3 1F
#_1A8D69: #_19B9: db $00 ; SFX3 20
#_1A8D6A: #_19BA: db $00 ; SFX3 21
#_1A8D6B: #_19BB: db $00 ; SFX3 22
#_1A8D6C: #_19BC: db $39 ; SFX3 23
#_1A8D6D: #_19BD: db $00 ; SFX3 24
#_1A8D6E: #_19BE: db $00 ; SFX3 25
#_1A8D6F: #_19BF: db $00 ; SFX3 26
#_1A8D70: #_19C0: db $00 ; SFX3 27
#_1A8D71: #_19C1: db $00 ; SFX3 28
#_1A8D72: #_19C2: db $00 ; SFX3 29
#_1A8D73: #_19C3: db $00 ; SFX3 2A
#_1A8D74: #_19C4: db $00 ; SFX3 2B
#_1A8D75: #_19C5: db $00 ; SFX3 2C
#_1A8D76: #_19C6: db $37 ; SFX3 2D
#_1A8D77: #_19C7: db $35 ; SFX3 2E
#_1A8D78: #_19C8: db $33 ; SFX3 2F
#_1A8D79: #_19C9: db $00 ; SFX3 30
#_1A8D7A: #_19CA: db $00 ; SFX3 31
#_1A8D7B: #_19CB: db $00 ; SFX3 32
#_1A8D7C: #_19CC: db $00 ; SFX3 33
#_1A8D7D: #_19CD: db $00 ; SFX3 34
#_1A8D7E: #_19CE: db $34 ; SFX3 35
#_1A8D7F: #_19CF: db $00 ; SFX3 36
#_1A8D80: #_19D0: db $00 ; SFX3 37
#_1A8D81: #_19D1: db $00 ; SFX3 38
#_1A8D82: #_19D2: db $00 ; SFX3 39
#_1A8D83: #_19D3: db $00 ; SFX3 3A
#_1A8D84: #_19D4: db $00 ; SFX3 3B
#_1A8D85: #_19D5: db $3D ; SFX3 3C
#_1A8D86: #_19D6: db $3E ; SFX3 3D
#_1A8D87: #_19D7: db $3F ; SFX3 3E
#_1A8D88: #_19D8: db $00 ; SFX3 3F

;---------------------------------------------------------------------------------------------------

SFX3_Echo:
#_1A8D89: #_19D9: db $00 ; SFX3 01
#_1A8D8A: #_19DA: db $00 ; SFX3 02
#_1A8D8B: #_19DB: db $00 ; SFX3 03
#_1A8D8C: #_19DC: db $00 ; SFX3 04
#_1A8D8D: #_19DD: db $00 ; SFX3 05
#_1A8D8E: #_19DE: db $00 ; SFX3 06
#_1A8D8F: #_19DF: db $00 ; SFX3 07
#_1A8D90: #_19E0: db $00 ; SFX3 08
#_1A8D91: #_19E1: db $00 ; SFX3 09
#_1A8D92: #_19E2: db $00 ; SFX3 0A
#_1A8D93: #_19E3: db $00 ; SFX3 0B
#_1A8D94: #_19E4: db $01 ; SFX3 0C
#_1A8D95: #_19E5: db $01 ; SFX3 0D
#_1A8D96: #_19E6: db $00 ; SFX3 0E
#_1A8D97: #_19E7: db $3C ; SFX3 0F
#_1A8D98: #_19E8: db $3B ; SFX3 10
#_1A8D99: #_19E9: db $01 ; SFX3 11
#_1A8D9A: #_19EA: db $01 ; SFX3 12
#_1A8D9B: #_19EB: db $00 ; SFX3 13
#_1A8D9C: #_19EC: db $00 ; SFX3 14
#_1A8D9D: #_19ED: db $00 ; SFX3 15
#_1A8D9E: #_19EE: db $00 ; SFX3 16
#_1A8D9F: #_19EF: db $00 ; SFX3 17
#_1A8DA0: #_19F0: db $00 ; SFX3 18
#_1A8DA1: #_19F1: db $00 ; SFX3 19
#_1A8DA2: #_19F2: db $00 ; SFX3 1A
#_1A8DA3: #_19F3: db $3A ; SFX3 1B
#_1A8DA4: #_19F4: db $00 ; SFX3 1C
#_1A8DA5: #_19F5: db $01 ; SFX3 1D
#_1A8DA6: #_19F6: db $00 ; SFX3 1E
#_1A8DA7: #_19F7: db $01 ; SFX3 1F
#_1A8DA8: #_19F8: db $01 ; SFX3 20
#_1A8DA9: #_19F9: db $01 ; SFX3 21
#_1A8DAA: #_19FA: db $01 ; SFX3 22
#_1A8DAB: #_19FB: db $00 ; SFX3 23
#_1A8DAC: #_19FC: db $01 ; SFX3 24
#_1A8DAD: #_19FD: db $00 ; SFX3 25
#_1A8DAE: #_19FE: db $00 ; SFX3 26
#_1A8DAF: #_19FF: db $00 ; SFX3 27
#_1A8DB0: #_1A00: db $00 ; SFX3 28
#_1A8DB1: #_1A01: db $00 ; SFX3 29
#_1A8DB2: #_1A02: db $00 ; SFX3 2A
#_1A8DB3: #_1A03: db $00 ; SFX3 2B
#_1A8DB4: #_1A04: db $00 ; SFX3 2C
#_1A8DB5: #_1A05: db $01 ; SFX3 2D
#_1A8DB6: #_1A06: db $01 ; SFX3 2E
#_1A8DB7: #_1A07: db $01 ; SFX3 2F
#_1A8DB8: #_1A08: db $00 ; SFX3 30
#_1A8DB9: #_1A09: db $01 ; SFX3 31
#_1A8DBA: #_1A0A: db $00 ; SFX3 32
#_1A8DBB: #_1A0B: db $01 ; SFX3 33
#_1A8DBC: #_1A0C: db $01 ; SFX3 34
#_1A8DBD: #_1A0D: db $01 ; SFX3 35
#_1A8DBE: #_1A0E: db $00 ; SFX3 36
#_1A8DBF: #_1A0F: db $01 ; SFX3 37
#_1A8DC0: #_1A10: db $00 ; SFX3 38
#_1A8DC1: #_1A11: db $00 ; SFX3 39
#_1A8DC2: #_1A12: db $00 ; SFX3 3A
#_1A8DC3: #_1A13: db $00 ; SFX3 3B
#_1A8DC4: #_1A14: db $3D ; SFX3 3C
#_1A8DC5: #_1A15: db $3E ; SFX3 3D
#_1A8DC6: #_1A16: db $3F ; SFX3 3E
#_1A8DC7: #_1A17: db $01 ; SFX3 3F

;===================================================================================================
; Sound effects
;===================================================================================================
#_1A8DC8: #_1A18: SFX3_01: incbin "bin/sfx/sfx3-01.sfx"            ; size: 0x001F
#_1A8DE7: #_1A37: SFX2_3C: incbin "bin/sfx/sfx2-3C.sfx"            ; size: 0x000C
#_1A8DF3: #_1A43: SFX2_37: incbin "bin/sfx/sfx2-37.sfx"            ; size: 0x0018
#_1A8E0B: #_1A5B: UnusedSFX_1A5B: incbin "bin/sfx/unused-1A5B.sfx" ; size: 0x0007
#_1A8E12: #_1A62: SFX3_1C: incbin "bin/sfx/sfx3-1C.sfx"            ; size: 0x0016
#_1A8E28: #_1A78: SFX3_32: incbin "bin/sfx/sfx3-32.sfx"            ; size: 0x002F
#_1A8E57: #_1AA7: SFX3_36: incbin "bin/sfx/sfx3-36.sfx"            ; size: 0x0023
#_1A8E7A: #_1ACA: SFX3_31: incbin "bin/sfx/sfx3-31.sfx"            ; size: 0x0008
#_1A8E82: #_1AD2: SFX1_13: incbin "bin/sfx/sfx1-13.sfx"            ; size: 0x000F
#_1A8E91: #_1AE1: SFX1_14: incbin "bin/sfx/sfx1-14.sfx"            ; size: 0x000F
#_1A8EA0: #_1AF0: SFX1_15: incbin "bin/sfx/sfx1-15.sfx"            ; size: 0x000F
#_1A8EAF: #_1AFF: SFX1_16: incbin "bin/sfx/sfx1-16.sfx"            ; size: 0x000F
#_1A8EBE: #_1B0E: SFX1_0D: incbin "bin/sfx/sfx1-0D.sfx"            ; size: 0x000F
#_1A8ECD: #_1B1D: SFX1_0E: incbin "bin/sfx/sfx1-0E.sfx"            ; size: 0x000F
#_1A8EDC: #_1B2C: SFX1_0F: incbin "bin/sfx/sfx1-0F.sfx"            ; size: 0x0012
#_1A8EEE: #_1B3E: SFX1_10: incbin "bin/sfx/sfx1-10.sfx"            ; size: 0x0015
#_1A8F03: #_1B53: SFX3_30: incbin "bin/sfx/sfx3-30.sfx"            ; size: 0x000F
#_1A8F12: #_1B62: SFX1_0C: incbin "bin/sfx/sfx1-0C.sfx"            ; size: 0x0041
#_1A8F53: #_1BA3: SFX1_0B: incbin "bin/sfx/sfx1-0B.sfx"            ; size: 0x0040
#_1A8F93: #_1BE3: SFX1_18: incbin "bin/sfx/sfx1-18.sfx"            ; size: 0x0041
#_1A8FD4: #_1C24: SFX1_17: incbin "bin/sfx/sfx1-17.sfx"            ; size: 0x0040
#_1A9014: #_1C64: SFX2_36: incbin "bin/sfx/sfx2-36.sfx"            ; size: 0x0003
#_1A9017: #_1C67: SFX2_35: incbin "bin/sfx/sfx2-35.sfx"            ; size: 0x0027
#_1A903E: #_1C8E: SFX1_09: incbin "bin/sfx/sfx1-09.sfx"            ; size: 0x002E
#_1A906C: #_1CBC: SFX1_0A: incbin "bin/sfx/sfx1-0A.sfx"            ; size: 0x0020
#_1A908C: #_1CDC: SFX2_33: incbin "bin/sfx/sfx2-33.sfx"            ; size: 0x0040
#_1A90CC: #_1D1C: UnusedSFX_1D1C: incbin "bin/sfx/unused-1D1C.sfx" ; size: 0x002B
#_1A90F7: #_1D47: SFX2_32: incbin "bin/sfx/sfx2-32.sfx"            ; size: 0x0016
#_1A910D: #_1D5D: SFX3_2E: incbin "bin/sfx/sfx3-2E.sfx"            ; size: 0x0009
#_1A9116: #_1D66: SFX3_34: incbin "bin/sfx/sfx3-34.sfx"            ; size: 0x000D
#_1A9123: #_1D73: SFX3_35: incbin "bin/sfx/sfx3-35.sfx"            ; size: 0x000D
#_1A9130: #_1D80: SFX3_2F: incbin "bin/sfx/sfx3-2F.sfx"            ; size: 0x0013
#_1A9143: #_1D93: SFX3_33: incbin "bin/sfx/sfx3-33.sfx"            ; size: 0x0016
#_1A9159: #_1DA9: SFX3_2D: incbin "bin/sfx/sfx3-2D.sfx"            ; size: 0x000B
#_1A9164: #_1DB4: SFX3_37: incbin "bin/sfx/sfx3-37.sfx"            ; size: 0x000C
#_1A9170: #_1DC0: SFX3_2C: incbin "bin/sfx/sfx3-2C.sfx"            ; size: 0x0033
#_1A91A3: #_1DF3: SFX3_2B: incbin "bin/sfx/sfx3-2B.sfx"            ; size: 0x001F
#_1A91C2: #_1E12: SFX3_2A: incbin "bin/sfx/sfx3-2A.sfx"            ; size: 0x000F
#_1A91D1: #_1E21: SFX3_29: incbin "bin/sfx/sfx3-29.sfx"            ; size: 0x001F
#_1A91F0: #_1E40: SFX3_27: incbin "bin/sfx/sfx3-27.sfx"            ; size: 0x003B
#_1A922B: #_1E7B: SFX3_26: incbin "bin/sfx/sfx3-26.sfx"            ; size: 0x000F
#_1A923A: #_1E8A: SFX3_1A: incbin "bin/sfx/sfx3-1A.sfx"            ; size: 0x0009
#_1A9243: #_1E93: SFX3_38: incbin "bin/sfx/sfx3-38.sfx"            ; size: 0x000A
#_1A924D: #_1E9D: SFX3_25: incbin "bin/sfx/sfx3-25.sfx"            ; size: 0x000F
#_1A925C: #_1EAC: SFX1_11: incbin "bin/sfx/sfx1-11.sfx"            ; size: 0x001C
#_1A9278: #_1EC8: SFX1_12: incbin "bin/sfx/sfx1-12.sfx"            ; size: 0x001A
#_1A9292: #_1EE2: UnusedSFX_1EE2: incbin "bin/sfx/unused-1EE2.sfx" ; size: 0x000F
#_1A92A1: #_1EF1: SFX2_30: incbin "bin/sfx/sfx2-30.sfx"            ; size: 0x0022
#_1A92C3: #_1F13: UnusedSFX_1F13: incbin "bin/sfx/unused-1F13.sfx" ; size: 0x0034
#_1A92F7: #_1F47: SFX2_2F: incbin "bin/sfx/sfx2-2F.sfx"            ; size: 0x0028
#_1A931F: #_1F6F: SFX2_34: incbin "bin/sfx/sfx2-34.sfx"            ; size: 0x002D
#_1A934C: #_1F9C: SFX2_39: incbin "bin/sfx/sfx2-39.sfx"            ; size: 0x002E
#_1A937A: #_1FCA: SFX2_2E: incbin "bin/sfx/sfx2-2E.sfx"            ; size: 0x000F
#_1A9389: #_1FD9: SFX2_2C: incbin "bin/sfx/sfx2-2C.sfx"            ; size: 0x000E
#_1A9397: #_1FE7: SFX2_3A: incbin "bin/sfx/sfx2-3A.sfx"            ; size: 0x000B
#_1A93A2: #_1FF2: SFX2_2B: incbin "bin/sfx/sfx2-2B.sfx"            ; size: 0x000F
#_1A93B1: #_2001: SFX3_23: incbin "bin/sfx/sfx3-23.sfx"            ; size: 0x0016
#_1A93C7: #_2017: SFX3_39: incbin "bin/sfx/sfx3-39.sfx"            ; size: 0x001C
#_1A93E3: #_2033: SFX2_2A: incbin "bin/sfx/sfx2-2A.sfx"            ; size: 0x0010
#_1A93F3: #_2043: SFX3_24: incbin "bin/sfx/sfx3-24.sfx"            ; size: 0x0008
#_1A93FB: #_204B: SFX3_1F: incbin "bin/sfx/sfx3-1F.sfx"            ; size: 0x0046
#_1A9441: #_2091: SFX3_1E: incbin "bin/sfx/sfx3-1E.sfx"            ; size: 0x0015
#_1A9456: #_20A6: SFX2_2D: incbin "bin/sfx/sfx2-2D.sfx"            ; size: 0x0010
#_1A9466: #_20B6: SFX3_1B: incbin "bin/sfx/sfx3-1B.sfx"            ; size: 0x000A
#_1A9470: #_20C0: SFX3_3A: incbin "bin/sfx/sfx3-3A.sfx"            ; size: 0x000E
#_1A947E: #_20CE: SFX2_31: incbin "bin/sfx/sfx2-31.sfx"            ; size: 0x000F
#_1A948D: #_20DD: SFX3_18: incbin "bin/sfx/sfx3-18.sfx"            ; size: 0x002A
#_1A94B7: #_2107: SFX2_22: incbin "bin/sfx/sfx2-22.sfx"            ; size: 0x001C
#_1A94D3: #_2123: SFX3_16: incbin "bin/sfx/sfx3-16.sfx"            ; size: 0x000C
#_1A94DF: #_212F: SFX3_15: incbin "bin/sfx/sfx3-15.sfx"            ; size: 0x000C
#_1A94EB: #_213B: SFX3_13: incbin "bin/sfx/sfx3-13.sfx"            ; size: 0x0014
#_1A94FF: #_214F: SFX3_11: incbin "bin/sfx/sfx3-11.sfx"            ; size: 0x000F
#_1A950E: #_215E: SFX3_12: incbin "bin/sfx/sfx3-12.sfx"            ; size: 0x000F
#_1A951D: #_216D: SFX3_10: incbin "bin/sfx/sfx3-10.sfx"            ; size: 0x0009
#_1A9526: #_2176: SFX3_3B: incbin "bin/sfx/sfx3-3B.sfx"            ; size: 0x000C
#_1A9532: #_2182: SFX3_0E: incbin "bin/sfx/sfx3-0E.sfx"            ; size: 0x000C
#_1A953E: #_218E: SFX3_0C: incbin "bin/sfx/sfx3-0C.sfx"            ; size: 0x000A
#_1A9548: #_2198: SFX3_0B: incbin "bin/sfx/sfx3-0B.sfx"            ; size: 0x0011
#_1A9559: #_21A9: SFX3_0A: incbin "bin/sfx/sfx3-0A.sfx"            ; size: 0x000C
#_1A9565: #_21B5: SFX3_0D: incbin "bin/sfx/sfx3-0D.sfx"            ; size: 0x000C
#_1A9571: #_21C1: SFX3_09: incbin "bin/sfx/sfx3-09.sfx"            ; size: 0x0025
#_1A9596: #_21E6: SFX3_08: incbin "bin/sfx/sfx3-08.sfx"            ; size: 0x000F
#_1A95A5: #_21F5: SFX3_06: incbin "bin/sfx/sfx3-06.sfx"            ; size: 0x0019
#_1A95BE: #_220E: SFX3_04: incbin "bin/sfx/sfx3-04.sfx"            ; size: 0x002F
#_1A95ED: #_223D: SFX3_07: incbin "bin/sfx/sfx3-07.sfx"            ; size: 0x000D
#_1A95FA: #_224A: SFX3_03: incbin "bin/sfx/sfx3-03.sfx"            ; size: 0x0008
#_1A9602: #_2252: SFX2_27: incbin "bin/sfx/sfx2-27.sfx"            ; size: 0x0035
#_1A9637: #_2287: SFX2_28: incbin "bin/sfx/sfx2-28.sfx"            ; size: 0x000F
#_1A9646: #_2296: SFX2_25: incbin "bin/sfx/sfx2-25.sfx"            ; size: 0x000F
#_1A9655: #_22A5: SFX2_24: incbin "bin/sfx/sfx2-24.sfx"            ; size: 0x0006
#_1A965B: #_22AB: SFX2_3D: incbin "bin/sfx/sfx2-3D.sfx"            ; size: 0x0006
#_1A9661: #_22B1: SFX2_23: incbin "bin/sfx/sfx2-23.sfx"            ; size: 0x000A
#_1A966B: #_22BB: SFX2_1D: incbin "bin/sfx/sfx2-1D.sfx"            ; size: 0x0014
#_1A967F: #_22CF: SFX2_21: incbin "bin/sfx/sfx2-21.sfx"            ; size: 0x000B
#_1A968A: #_22DA: SFX2_20: incbin "bin/sfx/sfx2-20.sfx"            ; size: 0x000F
#_1A9699: #_22E9: SFX2_1F: incbin "bin/sfx/sfx2-1F.sfx"            ; size: 0x0018
#_1A96B1: #_2301: SFX2_1C: incbin "bin/sfx/sfx2-1C.sfx"            ; size: 0x0006
#_1A96B7: #_2307: SFX2_1B: incbin "bin/sfx/sfx2-1B.sfx"            ; size: 0x000F
#_1A96C6: #_2316: SFX2_1A: incbin "bin/sfx/sfx2-1A.sfx"            ; size: 0x0016
#_1A96DC: #_232C: SFX2_16: incbin "bin/sfx/sfx2-16.sfx"            ; size: 0x0018
#_1A96F4: #_2344: SFX2_17: incbin "bin/sfx/sfx2-17.sfx"            ; size: 0x0012
#_1A9706: #_2356: SFX2_18: incbin "bin/sfx/sfx2-18.sfx"            ; size: 0x0018
#_1A971E: #_236E: SFX2_19: incbin "bin/sfx/sfx2-19.sfx"            ; size: 0x0012
#_1A9730: #_2380: SFX2_14: incbin "bin/sfx/sfx2-14.sfx"            ; size: 0x0010
#_1A9740: #_2390: SFX2_15: incbin "bin/sfx/sfx2-15.sfx"            ; size: 0x0010
#_1A9750: #_23A0: SFX2_13: incbin "bin/sfx/sfx2-13.sfx"            ; size: 0x0015
#_1A9765: #_23B5: SFX2_3E: incbin "bin/sfx/sfx2-3E.sfx"            ; size: 0x0018
#_1A977D: #_23CD: SFX2_12: incbin "bin/sfx/sfx2-12.sfx"            ; size: 0x0023
#_1A97A0: #_23F0: SFX2_11: incbin "bin/sfx/sfx2-11.sfx"            ; size: 0x000A
#_1A97AA: #_23FA: SFX2_10: incbin "bin/sfx/sfx2-10.sfx"            ; size: 0x000A
#_1A97B4: #_2404: SFX2_0E: incbin "bin/sfx/sfx2-0E.sfx"            ; size: 0x0010
#_1A97C4: #_2414: SFX2_0D: incbin "bin/sfx/sfx2-0D.sfx"            ; size: 0x0021
#_1A97E5: #_2435: SFX2_3F: incbin "bin/sfx/sfx2-3F.sfx"            ; size: 0x000A
#_1A97EF: #_243F: SFX2_29: incbin "bin/sfx/sfx2-29.sfx"            ; size: 0x0023
#_1A9812: #_2462: SFX2_3B: incbin "bin/sfx/sfx2-3B.sfx"            ; size: 0x000A
#_1A981C: #_246C: SFX3_14: incbin "bin/sfx/sfx3-14.sfx"            ; size: 0x000C
#_1A9828: #_2478: SFX2_0B: incbin "bin/sfx/sfx2-0B.sfx"            ; size: 0x0008
#_1A9830: #_2480: SFX3_3F: incbin "bin/sfx/sfx3-3F.sfx"            ; size: 0x000A
#_1A983A: #_248A: SFX3_3C: incbin "bin/sfx/sfx3-3C.sfx"            ; size: 0x000A
#_1A9844: #_2494: SFX3_3D: incbin "bin/sfx/sfx3-3D.sfx"            ; size: 0x000A
#_1A984E: #_249E: SFX3_3E: incbin "bin/sfx/sfx3-3E.sfx"            ; size: 0x001B
#_1A9869: #_24B9: SFX3_0F: incbin "bin/sfx/sfx3-0F.sfx"            ; size: 0x000A
#_1A9873: #_24C3: SFX2_0F: incbin "bin/sfx/sfx2-0F.sfx"            ; size: 0x0047
#_1A98BA: #_250A: SFX3_19: incbin "bin/sfx/sfx3-19.sfx"            ; size: 0x0023
#_1A98DD: #_252D: UnusedSFX_252D: incbin "bin/sfx/unused-252D.sfx" ; size: 0x0006
#_1A98E3: #_2533: UnusedSFX_2533: incbin "bin/sfx/unused-2533.sfx" ; size: 0x001B
#_1A98FE: #_254E: SFX3_02: incbin "bin/sfx/sfx3-02.sfx"            ; size: 0x0029
#_1A9927: #_2577: SFX2_1E: incbin "bin/sfx/sfx2-1E.sfx"            ; size: 0x002F
#_1A9956: #_25A6: SFX3_17: incbin "bin/sfx/sfx3-17.sfx"            ; size: 0x0007
#_1A995D: #_25AD: SFX2_09: incbin "bin/sfx/sfx2-09.sfx"            ; size: 0x000A
#_1A9967: #_25B7: SFX2_07: incbin "bin/sfx/sfx2-07.sfx"            ; size: 0x0010
#_1A9977: #_25C7: SFX2_0A: incbin "bin/sfx/sfx2-0A.sfx"            ; size: 0x0010
#_1A9987: #_25D7: SFX2_06: incbin "bin/sfx/sfx2-06.sfx"            ; size: 0x0006
#_1A998D: #_25DD: SFX2_05: incbin "bin/sfx/sfx2-05.sfx"            ; size: 0x0006
#_1A9993: #_25E3: SFX2_08: incbin "bin/sfx/sfx2-08.sfx"            ; size: 0x0031
#_1A99C4: #_2614: SFX2_01: incbin "bin/sfx/sfx2-01.sfx"            ; size: 0x0011
#_1A99D5: #_2625: SFX2_02: incbin "bin/sfx/sfx2-02.sfx"            ; size: 0x000F
#_1A99E4: #_2634: SFX2_03: incbin "bin/sfx/sfx2-03.sfx"            ; size: 0x000F
#_1A99F3: #_2643: SFX2_04: incbin "bin/sfx/sfx2-04.sfx"            ; size: 0x000F
#_1A9A02: #_2652: SFX1_01: incbin "bin/sfx/sfx1-01.sfx"            ; size: 0x0005
#_1A9A07: #_2657: UnusedSFX_2657: incbin "bin/sfx/unused-2657.sfx" ; size: 0x000B
#_1A9A12: #_2662: SFX1_02: incbin "bin/sfx/sfx1-02.sfx"            ; size: 0x0015
#_1A9A27: #_2677: SFX1_03: incbin "bin/sfx/sfx1-03.sfx"            ; size: 0x0005
#_1A9A2C: #_267C: UnusedSFX_267C: incbin "bin/sfx/unused-267C.sfx" ; size: 0x000B
#_1A9A37: #_2687: SFX1_04: incbin "bin/sfx/sfx1-04.sfx"            ; size: 0x0015
#_1A9A4C: #_269C: SFX2_0C: incbin "bin/sfx/sfx2-0C.sfx"            ; size: 0x0006
#_1A9A52: #_26A2: UnusedSFX_26A2: incbin "bin/sfx/unused-26A2.sfx" ; size: 0x002D
#_1A9A7F: #_26CF: SFX3_22: incbin "bin/sfx/sfx3-22.sfx"            ; size: 0x0028
#_1A9AA7: #_26F7: SFX3_28: incbin "bin/sfx/sfx3-28.sfx"            ; size: 0x003F
#_1A9AE6: #_2736: SFX1_08: incbin "bin/sfx/sfx1-08.sfx"            ; size: 0x0003
#_1A9AE9: #_2739: SFX1_07: incbin "bin/sfx/sfx1-07.sfx"            ; size: 0x0033
#_1A9B1C: #_276C: SFX3_20: incbin "bin/sfx/sfx3-20.sfx"            ; size: 0x0012
#_1A9B2E: #_277E: UnusedSFX_277E: incbin "bin/sfx/unused-277E.sfx" ; size: 0x001F
#_1A9B4D: #_279D: UnusedSFX_279D: incbin "bin/sfx/unused-279D.sfx" ; size: 0x002C
#_1A9B79: #_27C9: UnusedSFX_27C9: incbin "bin/sfx/unused-27C9.sfx" ; size: 0x0019
#_1A9B92: #_27E2: SFX3_21: incbin "bin/sfx/sfx3-21.sfx"            ; size: 0x0014
#_1A9BA6: #_27F6: UnusedSFX_27F6: incbin "bin/sfx/unused-27F6.sfx" ; size: 0x0011
#_1A9BB7: #_2807: UnusedSFX_2807: incbin "bin/sfx/unused-2807.sfx" ; size: 0x0011
#_1A9BC8: #_2818: UnusedSFX_2818: incbin "bin/sfx/unused-2818.sfx" ; size: 0x0011
#_1A9BD9: #_2829: UnusedSFX_2829: incbin "bin/sfx/unused-2829.sfx" ; size: 0x0008
#_1A9BE1: #_2831: UnusedSFX_2831: incbin "bin/sfx/unused-2831.sfx" ; size: 0x0013
#_1A9BF4: #_2844: SFX2_26: incbin "bin/sfx/sfx2-26.sfx"            ; size: 0x0006
#_1A9BFA: #_284A: UnusedSFX_284A: incbin "bin/sfx/unused-284A.sfx" ; size: 0x0005
#_1A9BFF: #_284F: SFX1_05: incbin "bin/sfx/sfx1-05.sfx"            ; size: 0x0001

base off
}

; ==============================================================================

; $0D7424-$0D742F
GARBAGE_1AF424:
{
    db $34, $00, $00, $00, $00, $01, $FF, $00, $00, $00, $00, $00
}

; $0D7430-$0D74FF NULL
NULL_1AF430:
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
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $0D7500-$0D758F DATA
SpriteDraw_BatCrash_OAM_group:
{
    ; $0D7500
    .00
    dw   0,   0 : db $4B, $04, $00, $00

    ; $0D7508
    .01
    dw   5,  -4 : db $5B, $04, $00, $00

    ; $0D7510
    .02
    dw  -2,  -4 : db $64, $04, $00, $02

    ; $0D7518
    .03
    dw  -2,  -4 : db $49, $04, $00, $02

    ; $0D7520
    .04
    dw  -8,  -9 : db $6C, $04, $00, $02
    dw   8,  -9 : db $6C, $44, $00, $02

    ; $0D7530
    .05
    dw  -8,  -7 : db $4C, $04, $00, $02
    dw   8,  -7 : db $4C, $44, $00, $02

    ; $0D7540
    .06
    dw  -8,  -9 : db $44, $04, $00, $02
    dw   8,  -9 : db $44, $44, $00, $02

    ; $0D7550
    .07
    dw  -8,  -8 : db $62, $04, $00, $02
    dw   8,  -8 : db $62, $44, $00, $02

    ; $0D7560
    .08
    dw  -8,  -7 : db $60, $04, $00, $02
    dw   8,  -7 : db $60, $44, $00, $02

    ; $0D7570
    .09
    dw   0,   0 : db $4E, $04, $00, $02
    dw  16,   0 : db $4E, $44, $00, $02
    dw   0,  16 : db $6E, $04, $00, $02
    dw  16,  16 : db $6E, $44, $00, $02
}

; $0D7590-$0D75A4 DATA
Pool_BatCrash_Approach:
{
    ; $0D7590
    .position_x
    dw $07DC, $07F0, $0820, $0818

    ; $0D7598
    .position_y
    dw $062E, $0636, $0630, $05E0

    ; $0D75A0
    .anim_timer
    db 4, 3, 4, 6, 0
}

; ==============================================================================

; $0D75A5-$0D75D4
incsrc "sprite_waterfall.asm"

; $0D75D5-$0D785B
incsrc "sprite_retreat_bat.asm"

; ==============================================================================

; $0D785C-$0D788B DATA
DrinkingGuy_Draw_OAM_groups:
{
    dw 8,  2 : db $AE, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02
    
    dw 7,  0 : db $AF, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02        
}

; $0D788C-$0D78AB LONG JUMP LOCATION
DrinkingGuy_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0DC0, X : ASL : ADC.w $0DC0, X : ASL #3
    ADC.b #(.OAM_groups)              : STA.b $08
    LDA.b #(.OAM_groups) : ADC.b #$00 : STA.b $09
    
    LDA.b #$03 : STA.b $06
                 STZ.b $07
    
    JMP.w Lady_Draw_DrinkingGuy_continue
}

; ==============================================================================

; Generally speaking, this draws a lady sprite... can be young or old,
; but the same graphics either way.
; $0D792C-$0D7953 LONG JUMP LOCATION
Lady_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #4
    
    ; TODO: Figure out where the reference goes.
    ; OPTIMIZE: Add 0?
    ; $0D78AC
    ADC.b #$AC              : STA.b $08
    LDA.b #$F8 : ADC.b #$00 : STA.b $09
    
    ; $0D794A ALTERNATE ENTRY POINT
    .DrinkingGuy_continue
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7954-$0D7970 LOCAL JUMP LOCATION
Sprite6_CheckIfActive:
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

; $0D7971-$0D7980 DATA
Pool_Lanmola_SpawnShrapnel:
{
    ; $0D7971
    .speed_y
    db  28, -28,  28, -28,   0,  36,   0, -36

    ; $0D7979
    .speed_x
    db -28, -28,  28,  28, -36,   0,  36,   0
}
    
; $0D7981-$0D79E5 LONG JUMP LOCATION
Lanmola_SpawnShrapnel:
{
    ; Spawns Lanmolas' rocks when they pop out of the ground.
    LDY.b #$03
    
    LDA.w $0DD0 : CLC : ADC.w $0DD1 : ADC.w $0DD2 : CMP.b #$0A : BCS .BRANCH_ALPHA
        LDY.b #$07
    
    .BRANCH_ALPHA
    
    STY.w $0FB5
    
    .BRANCH_GAMMA
    
    LDA.b #$C2
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $02 : ADC.b #$04 : STA.w $0D00, Y
        
        LDA.b #$01 : STA.w $0BA0, Y
                     STA.w $0CD2, Y
                     STA.w $0F60, Y
        
        DEC : STA.w $0F70, Y
        
        LDA.b #$20 : STA.w $0E40, Y
        
        PHX
        
        LDX.w $0FB5
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_x, X : STA.w $0D50, Y
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_y, X : STA.w $0D40, Y
        
        JSL.l GetRandomInt : AND.b #$01 : STA.w $0DC0, Y
        
        PLX
    
    .spawn_failed
    
    DEC.w $0FB5 : BPL .BRANCH_GAMMA
    
    RTL
}

; ==============================================================================

; $0D79E6-$0D7B2B
incsrc "sprite_cukeman.asm"

; ==============================================================================

; $0D7B2C-$0D7B7A LONG JUMP LOCATION
RunningMan_SpawnDashDustGarnish:
{
    INC.w $0CBA, X
    LDA.w $0CBA, X : AND.b #$0F : BNE .delay
        PHX : TXY
        
        LDX.b #$1D
        
        .find_empty_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .find_empty_slot
        
        INX
        
        .empty_slot
        
        LDA.b #$14 : STA.l $7FF800, X
                     STA.w $0FB4
        
        LDA.w $0D10, Y : CLC : ADC.b #$04 : STA.l $7FF83C, X
        LDA.w $0D30, Y       : ADC.b #$00 : STA.l $7FF878, X
        
        LDA.w $0D00, Y : CLC : ADC.b #$1C : STA.l $7FF81E, X
        LDA.w $0D20, Y       : ADC.b #$00 : STA.l $7FF85A, X
        
        LDA.b #$0A : STA.l $7FF90E, X
        
        PLX
    
    .delay
    
    RTL ; Original dissasembly had this as an RTS.
}

; ==============================================================================

; $0D7B7B-$0D7BDA DATA
Pool_Overworld_SubstituteAlternateSecret:
{
    ; $0D7B7B
    .AreaIndex
    db $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $04, $04, $06, $04, $04, $06, $00, $00
    db $0F, $0F, $04, $05, $05, $04, $06, $06
    db $0F, $0F, $04, $05, $05, $07, $06, $06
    db $1F, $1F, $04, $07, $07, $04, $06, $06
    db $06, $07, $02, $00, $00, $00, $00, $00
    db $06, $06, $02, $00, $00, $00, $00, $00

    ; $D7BBB
    .ItemPool
    db $01, $01, $01, $01, $0F, $01, $01, $12
    db $10, $01, $01, $01, $11, $01, $01, $03

    ; $D7BCB
    .AreaMask
    db $00, $00, $00, $00, $02, $00, $00, $08
    db $10, $00, $00, $00, $01, $00, $00, $00
}

; $0D7BDB-$0D7C30 LONG JUMP LOCATION
Overworld_SubstituteAlternateSecret:
{
    PHB : PHK : PLB
    
    !num_live_sprites = $0D
    
    JSL.l GetRandomInt : AND.b #$01 : BNE .return
        STZ.b !num_live_sprites
        
        LDY.b #$0F
        
        .next_sprite
            
            LDA.w $0DD0, Y : BEQ .dead_sprite
                LDA.w $0E20, Y : CMP.b #$6C : BEQ .is_warp_vortex
                    INC.b !num_live_sprites
                
                .is_warp_vortex
            .dead_sprite
        DEY : BPL .next_sprite
        
        LDA.b !num_live_sprites : CMP.b #$04 : BCS .return
            LDA.l $7EF3C5 : CMP.b #$02 : BCC .return
                LDA.w $0CF7 : INC.w $0CF7 : AND.b #$07
                
                LDY.w $0FFF : BEQ .in_light_world
                    ORA.b #$08
                
                .in_light_world
                
                TAY
                
                PHX
                
                LDA.w $040A : AND.b #$3F : TAX
                LDA.w Pool_Overworld_SubstituteAlternateSecret_AreaIndex, X
                AND .AreaMask, Y : BNE .BRANCH_EPSILON
                    LDA.w Pool_Overworld_SubstituteAlternateSecret_ItemPool, Y : STA.w $0B9C
                
                .BRANCH_EPSILON
                
                PLX
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7C31-$0D7CEC
incsrc "sprite_movable_mantle.asm"

; ==============================================================================

; $0D7CED-$0D7DAC DATA
Pool_Mothula_Draw:
{
    .OAM_groups
    dw -24,  -8 : db $80, $00, $00, $02
    dw  -8,  -8 : db $82, $00, $00, $02
    dw   8,  -8 : db $82, $40, $00, $02
    dw  24,  -8 : db $80, $40, $00, $02
    dw -24,   8 : db $A0, $00, $00, $02
    dw  -8,   8 : db $A2, $00, $00, $02
    dw   8,   8 : db $A2, $40, $00, $02
    dw  24,   8 : db $A0, $40, $00, $02

    dw -24,  -8 : db $84, $00, $00, $02
    dw  -8,  -8 : db $86, $00, $00, $02
    dw   8,  -8 : db $86, $40, $00, $02
    dw  24,  -8 : db $84, $40, $00, $02
    dw -24,   8 : db $A4, $00, $00, $02
    dw  -8,   8 : db $A6, $00, $00, $02
    dw   8,   8 : db $A6, $40, $00, $02
    dw  24,   8 : db $A4, $40, $00, $02

    dw  -8,  -8 : db $88, $00, $00, $02
    dw  -8,  -8 : db $88, $00, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
}

; ==============================================================================

; $0D7DAD-$0D7DB4 LONG JUMP LOCATION
Mothula_DrawLong:
{
    ; Something related to drawing Mothula (Gamoth?) or his beams?
    PHB : PHK : PLB
    
    JSR.w Mothula_Draw
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7DB5-$0D7E7D LOCAL JUMP LOCATION
Mothula_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #6 : ADC.w #$FCED : STA.b $08
    
    LDA.w #$0920 : STA.b $90
    LDA.w #$0A68 : STA.b $92
    
    SEP #$20
    
    LDA.b #$08
    JSL.l Sprite_DrawMultiple
    
    LDA.w $0F00, X : BNE .skip
        PHX
        
        LDA.w $0DC0, X : ASL #3 : ADC.w $0DC0, X : STA.b $06
        
        LDA.b $02 : CLC : ADC.w $0F70, X : STA.b $02
        LDA.b $03       : ADC.b #$00     : STA.b $03
        
        LDY.b #$28
        LDX.b #$08

        .next_OAM_entry

            PHX
            
            TXA : CLC : ADC.b $06 : ASL : TAX
            
            REP #$20
            
            LDA.b $00 : CLC : ADC.w .x_offsets, X : STA.b ($90), Y
            AND.w #$0100                          : STA.b $0E
            
            INY
            
            LDA.b $02 : CLC : ADC.w #$0010 : STA.b ($90), Y
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA.b ($90), Y

            .on_screen_y

            INY
            
            LDA.b #$6C : STA.b ($90), Y
            
            INY
            
            LDA.b #$24 : STA.b ($90), Y
            
            PHY
            
            TYA : LSR : LSR : TAY
            LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_OAM_entry
        
        PLX
    
    .skip
    
    RTS
    
    .x_offsets
    dw   0,   3,   6,   9,  12,  -3,  -6,  -9
    dw -12,   0,   2,   4,   6,   8,  -2,  -4
    dw  -6,  -8,   0,   1,   2,   3,   4,  -1
    dw  -2,  -3,  -4
}

; ==============================================================================

; $0D7E7E-$0D7E87 DATA
Pool_BottleVendor_PayForGoodBee:
{
    ; $0D7E7E
    .x_speeds
    db -6, -3,  0,  4,  7
    
    ; $0D7E83
    .y_speeds
    db 11, 14, 16, 14, 11
}

; $0D7E88-$0D7ECE LONG JUMP LOCATION
BottleVendor_PayForGoodBee:
{
    PHB : PHK : PLB
    
    LDA.b #$13
    JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA.w $0FB5
    
    .next_red_rupee
    
        LDA.b #$DB
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
            
            LDA.b #$FF : STA.w $0B58, Y
            
            PHX
            
            LDX.w $0FB5
            LDA.w .x_speeds, X : STA.w $0D50, Y
            LDA.w .y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$20 : STA.w $0F80, Y
                         STA.w $0F10, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .next_red_rupee
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7ECF-$0D7ED2 LONG JUMP LOCATION
Sprite_ChickenLadyLong:
{
    JSR.w Sprite_ChickenLady        
    
    RTL
}

; ==============================================================================

; $0D7ED3-$0D7EFF LOCAL JUMP LOCATION
Sprite_ChickenLady:
{
    LDA.b #$01 : STA.w $0DE0, X
    
    JSL.l Lady_Draw
    JSR.w Sprite6_CheckIfActive
    
    LDA.w $0DF0, X : CMP.b #$01 : BNE .anoshow_message
        ; "Cluck cluck...  What?! (...) I can even speak! ...".
        LDA.b #$7D : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        JSL.l Sprite_ShowMessageMinimal
    
    .anoshow_message
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0D7F00-$0D7F2A LONG JUMP LOCATION
SpritePrep_DiggingGameGuy:
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    REP #$20
    
    LDA.b $20 : CMP.b $00 : SEP #$30 : BCS .player_below_proprietor
        ; This is in case you warp into the digging game field from the light
        ; world (as a result of the mirror warp vortex taking you back to the
        ; dark world).
        LDA.b #$05 : STA.w $0D80, X
        
        LDA.w $0D10, X : SEC : SBC.b #$09 : STA.w $0D10, X
        
        LDA.b #$01 : STA.w $0DC0, X
    
    .player_below_proprietor
    
    INC.w $0BA0, X
    
    RTL
}

; ==============================================================================

; $0D7F2B-$0D7F3B DATA
Pool_Player_SpawnSmallWaterSplashFromHammer:
{
    ; $0D7F2B
    .x_offsets
    dw 0, 12, -8, 24
    
    ; $0D7F33
    .y_offsets
    dw 8, 32, 24, 24
    
    ; $0D7F3B
    .easy_out
    RTL
}

; ==============================================================================

; $0D7F3C-$0D7FFD LONG JUMP LOCATION
Player_SpawnSmallWaterSplashFromHammer:
{
    LDA.b $11 : ORA.w $02E4 : ORA.w $0FC1 : BNE Pool_Player_SpawnSmallWaterSplashFromHammer_easy_out
        PHX : PHY
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $22 : CLC : ADC.l .x_offsets, X : STA.b $00
        LDA.b $20 : CLC : ADC.l .y_offsets, X : STA.b $02
        
        SEP #$20
        
        LDA.b $EE : CMP.b #$01

        REP #$30
        
        STZ.b $05
        BCC .on_bg2
            LDA.w #$1000 : STA.b $05
        
        .on_bg2
        
        SEP #$20
        
        LDA.b $1B : REP #$20 : BEQ .outdoors
            LDA.b $00 : AND.w #$01FF : LSR #3 : STA.b $04
            LDA.b $02 : AND.w #$01F8 : ASL #3
            CLC : ADC.b $04 : CLC : ADC.b $05 : TAX
            
            LDA.l $7F2000, X
            
            BRA .check_tile_type
        
        .outdoors
        
        LDA.b $02          : PHA
        LDA.b $00 : LSR #3 : STA.b $02
        PLA                : STA.b $00
        
        SEP #$30
        
        JSL.l Overworld_ReadTileAttr
        
        REP #$10
        
        .check_tile_type
        
        SEP #$30
        
        CMP.b #$08 : BEQ .water_tile
            CMP.b #$09 : BNE .not_water_tile
                .water_tile
                
                JSL.l Sprite_SpawnSmallWaterSplash : BMI .spawn_failed
                    LDY.b $2F
                    LDA.b $20 : CLC : ADC.l .y_offsets, X : PHP : SEC : SBC.b #$10        : STA.w $0D00, Y
                    LDA.b $21       : SBC.b #$00          : PLP : ADC.l .y_offsets + 1, X : STA.w $0D20, Y
                    
                    LDA.b $22 : CLC : ADC.l .x_offsets, X : PHP : SEC : SBC.b #$08        : STA.w $0D10, Y
                    LDA.b $23       : SBC.b #$00          : PLP : ADC.l .x_offsets + 1, X : STA.w $0D30, Y
                    
                    LDA.b $EE : STA.w $0F20, Y
                    LDA.b #$00 : STA.w $0F70, Y
                    
                    PLX : PLY
                
                .spawn_failed
        .not_water_tile
        
        RTL
}

; ==============================================================================

; $0D7FFE-$0D7FFF NULL
NULL_1AFFFE:
{
    db $FF, $FF
}

; ==============================================================================

warnpc $1B8000
