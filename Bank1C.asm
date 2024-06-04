; ==============================================================================

; Bank 1C
; $0E0000-$0E7FFF
org $1C8000

; The entire bank consists of message data.

; ==============================================================================

; First block of dialogue data.
; $0E0000-$0E7F29 DATA
Message_Data:
{
    ; ==========================================================================
    ; --------------------------------------------------------------------------
    ; 
    ; $0E0000
    Message_0000:
    db $7F ; end of message

    ; ==========================================================================
    ;     >
    ;       
    ; --------------------------------------------------------------------------
    ; $0E0001
    Message_0001:
    db $7A, $00 ; set draw speed
    db $76 ; line 3
    db $88, $8A ; [    ][  ]
    db $75 ; line 2
    db $88, $44 ; [    ]>
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ;       
    ;     >
    ; --------------------------------------------------------------------------
    ; $0E000B
    Message_0002:
    db $7A, $00 ; set draw speed
    db $75 ; line 2
    db $88, $8A ; [    ][  ]
    db $76 ; line 3
    db $88, $44 ; [    ]>
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Save And Continue
    ; Save And Quit
    ; Do Not Save And Continue
    ; --------------------------------------------------------------------------
    ; $0E0015
    Message_0003:
    db $7A, $00 ; set draw speed
    db $12, $1A, $2F, $1E, $59, $00, $27, $1D ; Save⎵And
    db $59, $02, $C7, $2D, $B4, $2E, $1E ; ⎵C[on]t[in]ue
    db $75 ; line 2
    db $12, $1A, $2F, $1E, $59, $00, $27, $1D ; Save⎵And
    db $59, $10, $2E, $B6 ; ⎵Qu[it]
    db $76 ; line 3
    db $03, $28, $59, $0D, $28, $2D, $59, $12 ; Do⎵Not⎵S
    db $1A, $2F, $1E, $59, $00, $27, $1D, $59 ; ave⎵And⎵
    db $02, $C7, $2D, $B4, $2E, $1E ; C[on]t[in]ue
    db $7F ; end of message

    ; ==========================================================================
    ; 0- [#0]. 1- [#1]
    ; 2- [#2]. 3- [#3]
    ; --------------------------------------------------------------------------
    ; $0E004B
    Message_0004:
    db $7A, $00 ; set draw speed
    db $34, $40, $59, $6C, $00, $41, $59, $35 ; 0-⎵[#0].⎵1
    db $40, $59, $6C, $01 ; -⎵[#1]
    db $75 ; line 2
    db $36, $40, $59, $6C, $02, $41, $59, $37 ; 2-⎵[#2].⎵3
    db $40, $59, $6C, $03 ; -⎵[#3]
    db $7F ; end of message

    ; ==========================================================================
    ; You can't enter with something
    ; following you.
    ; --------------------------------------------------------------------------
    ; $0E0067
    Message_0005:
    db $E8, $59, $1C, $93, $51, $2D, $59, $A3 ; [You]⎵c[an]'t⎵[ent]
    db $A1, $DE, $59, $CF, $D5, $20 ; [er ][with]⎵[some][thin]g
    db $75 ; line 2
    db $1F, $28, $25, $BB, $E2, $27, $20, $59 ; fol[lo][wi]ng⎵
    db $E3, $41 ; [you].
    db $7F ; end of message

    ; ==========================================================================
    ; >
    ;   
    ;   
    ; --------------------------------------------------------------------------
    ; $0E0081
    Message_0006:
    db $7A, $00 ; set draw speed
    db $74 ; line 1
    db $44 ; >
    db $75 ; line 2
    db $8A ; [  ]
    db $76 ; line 3
    db $8A ; [  ]
    db $71 ; choose 3
    db $7F ; end of message

    ; ==========================================================================
    ;   
    ; >
    ;   
    ; --------------------------------------------------------------------------
    ; $0E008B
    Message_0007:
    db $7A, $00 ; set draw speed
    db $74 ; line 1
    db $8A ; [  ]
    db $75 ; line 2
    db $44 ; >
    db $76 ; line 3
    db $8A ; [  ]
    db $71 ; choose 3
    db $7F ; end of message

    ; ==========================================================================
    ;   
    ;   
    ; >
    ; --------------------------------------------------------------------------
    ; $0E0095
    Message_0008:
    db $7A, $00 ; set draw speed
    db $74 ; line 1
    db $8A ; [  ]
    db $75 ; line 2
    db $8A ; [  ]
    db $76 ; line 3
    db $44 ; >
    db $71 ; choose 3
    db $7F ; end of message

    ; ==========================================================================
    ; >
    ;   
    ; --------------------------------------------------------------------------
    ; $0E009F
    Message_0009:
    db $7A, $00 ; set draw speed
    db $74 ; line 1
    db $44 ; >
    db $75 ; line 2
    db $8A ; [  ]
    db $72 ; choose 2 high
    db $7F ; end of message

    ; ==========================================================================
    ;   
    ; >
    ; --------------------------------------------------------------------------
    ; $0E00A7
    Message_000A:
    db $7A, $00 ; set draw speed
    db $74 ; line 1
    db $8A ; [  ]
    db $75 ; line 2
    db $44 ; >
    db $72 ; choose 2 high
    db $7F ; end of message

    ; ==========================================================================
    ;     
    ;   >
    ; --------------------------------------------------------------------------
    ; $0E00AF
    Message_000B:
    db $7A, $00 ; set draw speed
    db $76 ; line 3
    db $88 ; [    ]
    db $75 ; line 2
    db $8A, $44 ; [  ]>
    db $6F ; choose 2 low
    db $7F ; end of message

    ; ==========================================================================
    ;     
    ;   >
    ; --------------------------------------------------------------------------
    ; $0E00B8
    Message_000C:
    db $7A, $00 ; set draw speed
    db $75 ; line 2
    db $88 ; [    ]
    db $76 ; line 3
    db $8A, $44 ; [  ]>
    db $6F ; choose 2 low
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], I'm going out for a
    ; while.  I'll be back by morning.
    ; Don't leave the house.
    ; --------------------------------------------------------------------------
    ; $0E00C1
    Message_000D:
    db $6A, $42, $59, $08, $51, $26, $59, $AC ; [LINK],⎵I'm⎵[go]
    db $B3, $C5, $A8, $59, $1A ; [ing ][out ][for]⎵a
    db $75 ; line 2
    db $E1, $22, $25, $1E, $41, $8A, $08, $51 ; [wh]ile.[  ]I'
    db $25, $25, $59, $97, $59, $96, $9C, $59 ; ll⎵[be]⎵[ba][ck]⎵
    db $1B, $32, $59, $26, $C8, $27, $B4, $20 ; by⎵m[or]n[in]g
    db $41 ; .
    db $76 ; line 3
    db $03, $C7, $51, $2D, $59, $25, $1E, $1A ; D[on]'t⎵lea
    db $2F, $1E, $59, $D8, $59, $21, $28, $2E ; ve⎵[the]⎵hou
    db $D0, $41 ; [se].
    db $7F ; end of message

    ; ==========================================================================
    ; Unnh… [LINK], I didn't want
    ; you involved in this…  I told
    ; you not to leave the house…
    ; Take my sword and shield and
    ; listen.  You can focus power in
    ; the blade (hold the Ⓑ Button).
    ; …Then release it using the
    ; secret technique handed down
    ; by our people…
    ; [LINK], you can do it!
    ; Save the Princess…
    ; Zelda is your… … …
    ; --------------------------------------------------------------------------
    ; $0E00FC
    Message_000E:
    db $14, $27, $27, $21, $43, $59, $6A, $42 ; Unnh…⎵[LINK],
    db $59, $08, $59, $9E, $1D, $C0, $DF, $27 ; ⎵I⎵[di]d[n't ][wa]n
    db $2D ; t
    db $75 ; line 2
    db $E3, $59, $B4, $2F, $28, $25, $2F, $A4 ; [you]⎵[in]volv[ed ]
    db $B4, $59, $D9, $2C, $43, $8A, $08, $59 ; [in]⎵[thi]s…[  ]I⎵
    db $DA, $25, $1D ; [to]ld
    db $76 ; line 3
    db $E3, $59, $C2, $59, $DA, $59, $25, $1E ; [you]⎵[not]⎵[to]⎵le
    db $1A, $2F, $1E, $59, $D8, $59, $21, $28 ; ave⎵[the]⎵ho
    db $2E, $D0, $43 ; u[se]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $1A, $24, $1E, $59, $26, $32, $59 ; Take⎵my⎵
    db $2C, $30, $C8, $1D, $59, $8C, $D1, $22 ; sw[or]d⎵[and ][sh]i
    db $1E, $25, $1D, $59, $90 ; eld⎵[and]
    db $73 ; scroll text
    db $25, $B5, $2D, $A5, $41, $8A, $E8, $59 ; l[is]t[en].[  ][You]⎵
    db $99, $1F, $28, $1C, $2E, $2C, $59, $CB ; [can ]focus⎵[pow]
    db $A1, $B4 ; [er ][in]
    db $73 ; scroll text
    db $D8, $59, $1B, $BA, $1D, $1E, $59, $45 ; [the]⎵b[la]de⎵(
    db $21, $28, $25, $1D, $59, $D8, $59, $5C ; hold⎵[the]⎵Ⓑ
    db $59, $01, $2E, $2D, $DA, $27, $46, $41 ; ⎵But[to]n).
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $E6, $27, $59, $CE, $25, $1E, $1A ; …[The]n⎵[re]lea
    db $D0, $59, $B6, $59, $2E, $2C, $B3, $D8 ; [se]⎵[it]⎵us[ing ][the]
    db $73 ; scroll text
    db $D0, $1C, $CE, $2D, $59, $2D, $1E, $1C ; [se]c[re]t⎵tec
    db $21, $27, $22, $2A, $2E, $1E, $59, $B1 ; hnique⎵[ha]
    db $27, $1D, $A4, $9F, $30, $27 ; nd[ed ][do]wn
    db $73 ; scroll text
    db $1B, $32, $59, $28, $2E, $2B, $59, $29 ; by⎵our⎵p
    db $1E, $28, $CA, $43 ; eo[ple]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $6A, $42, $59, $E3, $59, $99, $9F, $59 ; [LINK],⎵[you]⎵[can ][do]⎵
    db $B6, $3E ; [it]!
    db $73 ; scroll text
    db $12, $1A, $2F, $1E, $59, $D8, $59, $0F ; Save⎵[the]⎵P
    db $2B, $B4, $1C, $1E, $2C, $2C, $43 ; r[in]cess…
    db $73 ; scroll text
    db $19, $1E, $25, $1D, $1A, $59, $B5, $59 ; Zelda⎵[is]⎵
    db $E3, $2B, $43, $59, $43, $59, $43 ; [you]r…⎵…⎵…
    db $7F ; end of message

    ; ==========================================================================
    ; What're you doing up this late,
    ; kid?  You can stay up when
    ; you're grown up!  Now go home!
    ; --------------------------------------------------------------------------
    ; $0E01DB
    Message_000F:
    db $16, $B1, $2D, $51, $CD, $E3, $59, $9F ; W[ha]t'[re ][you]⎵[do]
    db $B3, $DC, $59, $D9, $2C, $59, $BA, $2D ; [ing ][up]⎵[thi]s⎵[la]t
    db $1E, $42 ; e,
    db $75 ; line 2
    db $24, $22, $1D, $3F, $8A, $E8, $59, $99 ; kid?[  ][You]⎵[can ]
    db $D3, $1A, $32, $59, $DC, $59, $E1, $A5 ; [st]ay⎵[up]⎵[wh][en]
    db $76 ; line 3
    db $E3, $51, $CD, $20, $2B, $28, $30, $27 ; [you]'[re ]grown
    db $59, $DC, $3E, $8A, $0D, $28, $30, $59 ; ⎵[up]![  ]Now⎵
    db $AC, $59, $21, $28, $BE, $3E ; [go]⎵ho[me]!
    db $7F ; end of message

    ; ==========================================================================
    ; I see you brought a map so you
    ; don't get lost.  (Press the
    ; ⓧ Button to see your map).
    ; --------------------------------------------------------------------------
    ; $0E0216
    Message_0010:
    db $08, $59, $D0, $1E, $59, $E3, $59, $1B ; I⎵[se]e⎵[you]⎵b
    db $2B, $28, $2E, $20, $21, $2D, $59, $1A ; rought⎵a
    db $59, $BD, $29, $59, $D2, $59, $E3 ; ⎵[ma]p⎵[so]⎵[you]
    db $75 ; line 2
    db $9F, $C0, $AB, $59, $BB, $D3, $41, $8A ; [do][n't ][get]⎵[lo][st].[  ]
    db $45, $0F, $CE, $2C, $2C, $59, $D8 ; (P[re]ss⎵[the]
    db $76 ; line 3
    db $5D, $59, $01, $2E, $2D, $DA, $27, $59 ; ⓧ⎵But[to]n⎵
    db $DA, $59, $D0, $1E, $59, $E3, $2B, $59 ; [to]⎵[se]e⎵[you]r⎵
    db $BD, $29, $46, $41 ; [ma]p).
    db $7F ; end of message

    ; ==========================================================================
    ; You look strong for a kid.  How
    ; much can you lift?  (Press the
    ; Ⓐ Button while touching a thing
    ; to lift it.)
    ; --------------------------------------------------------------------------
    ; $0E0253
    Message_0011:
    db $E8, $59, $BB, $28, $24, $59, $D3, $2B ; [You]⎵[lo]ok⎵[st]r
    db $C7, $20, $59, $A8, $59, $1A, $59, $24 ; [on]g⎵[for]⎵a⎵k
    db $22, $1D, $41, $8A, $07, $28, $30 ; id.[  ]How
    db $75 ; line 2
    db $BF, $1C, $21, $59, $99, $E3, $59, $25 ; [mu]ch⎵[can ][you]⎵l
    db $22, $1F, $2D, $3F, $8A, $45, $0F, $CE ; ift?[  ](P[re]
    db $2C, $2C, $59, $D8 ; ss⎵[the]
    db $76 ; line 3
    db $5B, $59, $01, $2E, $2D, $DA, $27, $59 ; Ⓐ⎵But[to]n⎵
    db $E1, $22, $25, $1E, $59, $DA, $2E, $1C ; [wh]ile⎵[to]uc
    db $B0, $27, $20, $59, $1A, $59, $D5, $20 ; [hi]ng⎵a⎵[thin]g
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $59, $25, $22, $1F, $2D, $59, $B6 ; [to]⎵lift⎵[it]
    db $41, $46 ; .)
    db $7F ; end of message

    ; ==========================================================================
    ; I'll bet you can't wait until you
    ; are old enough to use a sword!
    ; (Press the Ⓑ Button to use
    ; your sword when you get it.)
    ; --------------------------------------------------------------------------
    ; $0E02A5
    Message_0012:
    db $08, $51, $25, $25, $59, $97, $2D, $59 ; I'll⎵[be]t⎵
    db $E3, $59, $1C, $93, $51, $2D, $59, $DF ; [you]⎵c[an]'t⎵[wa]
    db $B6, $59, $2E, $27, $2D, $22, $25, $59 ; [it]⎵until⎵
    db $E3 ; [you]
    db $75 ; line 2
    db $8D, $28, $25, $1D, $59, $A5, $28, $2E ; [are ]old⎵[en]ou
    db $20, $21, $59, $DA, $59, $2E, $D0, $59 ; gh⎵[to]⎵u[se]⎵
    db $1A, $59, $2C, $30, $C8, $1D, $3E ; a⎵sw[or]d!
    db $76 ; line 3
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5C, $59, $01, $2E, $2D, $DA, $27, $59 ; Ⓑ⎵But[to]n⎵
    db $DA, $59, $2E, $D0 ; [to]⎵u[se]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E3, $2B, $59, $2C, $30, $C8, $1D, $59 ; [you]r⎵sw[or]d⎵
    db $E1, $A0, $E3, $59, $AB, $59, $B6, $41 ; [wh][en ][you]⎵[get]⎵[it].
    db $46 ; )
    db $7F ; end of message

    ; ==========================================================================
    ; That mark on your map must be
    ; your destination.
    ; --------------------------------------------------------------------------
    ; $0E02FF
    Message_0013:
    db $E5, $2D, $59, $BD, $2B, $24, $59, $C7 ; [Tha]t⎵[ma]rk⎵[on]
    db $59, $E3, $2B, $59, $BD, $29, $59, $BF ; ⎵[you]r⎵[ma]p⎵[mu]
    db $D3, $59, $97 ; [st]⎵[be]
    db $75 ; line 2
    db $E3, $2B, $59, $9D, $2D, $B4, $94, $22 ; [you]r⎵[des]t[in][at]i
    db $C7, $41 ; [on].
    db $7F ; end of message

    ; ==========================================================================
    ; You can often find valuables
    ; in chests.  (Press the Ⓐ
    ; Button in front of a chest to
    ; open it.)
    ; --------------------------------------------------------------------------
    ; $0E031E
    Message_0014:
    db $E8, $59, $99, $C6, $2D, $A0, $1F, $B4 ; [You]⎵[can ][of]t[en ]f[in]
    db $1D, $59, $2F, $1A, $25, $2E, $1A, $95 ; d⎵valua[ble]
    db $2C ; s
    db $75 ; line 2
    db $B4, $59, $9A, $D3, $2C, $41, $8A, $45 ; [in]⎵[che][st]s.[  ](
    db $0F, $CE, $2C, $2C, $59, $D8, $59, $5B ; P[re]ss⎵[the]⎵Ⓐ
    db $76 ; line 3
    db $01, $2E, $2D, $DA, $27, $59, $B4, $59 ; But[to]n⎵[in]⎵
    db $A9, $27, $2D, $59, $C6, $59, $1A, $59 ; [fro]nt⎵[of]⎵a⎵
    db $9A, $D3, $59, $DA ; [che][st]⎵[to]
    db $7E ; wait for key
    db $73 ; scroll text
    db $C3, $59, $B6, $41, $46 ; [open]⎵[it].)
    db $7F ; end of message

    ; ==========================================================================
    ; Us soldiers have been around,
    ; kid.  You can learn a lot from
    ; us.  But you already know that!
    ; --------------------------------------------------------------------------
    ; $0E0335D
    Message_0015:
    db $14, $2C, $59, $D2, $25, $9E, $A6, $2C ; Us⎵[so]l[di][er]s
    db $59, $AD, $59, $97, $A0, $1A, $2B, $C4 ; ⎵[have]⎵[be][en ]ar[ound]
    db $42 ; ,
    db $75 ; line 2
    db $24, $22, $1D, $41, $8A, $E8, $59, $99 ; kid.[  ][You]⎵[can ]
    db $25, $A2, $27, $59, $1A, $59, $BB, $2D ; l[ear]n⎵a⎵[lo]t
    db $59, $A9, $26 ; ⎵[fro]m
    db $76 ; line 3
    db $2E, $2C, $41, $8A, $01, $2E, $2D, $59 ; us.[  ]But⎵
    db $E3, $59, $1A, $25, $CE, $1A, $1D, $32 ; [you]⎵al[re]ady
    db $59, $B8, $59, $D7, $2D, $3E ; ⎵[know]⎵[tha]t!
    db $7F ; end of message

    ; ==========================================================================
    ; Meet the elder of the village
    ; and get the Master Sword.
    ; --------------------------------------------------------------------------
    ; $0E039A
    Message_0016:
    db $0C, $1E, $1E, $2D, $59, $D8, $59, $1E ; Meet⎵[the]⎵e
    db $25, $1D, $A1, $C6, $59, $D8, $59, $2F ; ld[er ][of]⎵[the]⎵v
    db $22, $25, $BA, $20, $1E ; il[la]ge
    db $75 ; line 2
    db $8C, $AB, $59, $D8, $59, $0C, $92, $A1 ; [and ][get]⎵[the]⎵M[ast][er ]
    db $12, $30, $C8, $1D, $41 ; Sw[or]d.
    db $7F ; end of message

    ; ==========================================================================
    ; Princess Zelda, you are safe!
    ; Is this your doing, [LINK]?
    ; --------------------------------------------------------------------------
    ; $0E03BE
    Message_0017:
    db $0F, $2B, $B4, $1C, $1E, $2C, $2C, $59 ; Pr[in]cess⎵
    db $19, $1E, $25, $1D, $1A, $42, $59, $E3 ; Zelda,⎵[you]
    db $59, $8D, $2C, $1A, $1F, $1E, $3E ; ⎵[are ]safe!
    db $75 ; line 2
    db $08, $2C, $59, $D9, $2C, $59, $E3, $2B ; Is⎵[thi]s⎵[you]r
    db $59, $9F, $B4, $20, $42, $59, $6A, $3F ; ⎵[do][in]g,⎵[LINK]?
    db $7F ; end of message

    ; ==========================================================================
    ; I sense that a mighty evil
    ; force guides the wizard's
    ; actions and augments his
    ; magical power.  The only
    ; weapon potent enough to
    ; defeat the wizard is the
    ; legendary Master Sword.
    ; It is said that the village elder
    ; is a descendant of one of the
    ; seven wise men.  Maybe
    ; he can tell you more…
    ; I will mark his house on your
    ; map.  But watch your every
    ; move!  I am certain that the
    ; castle soldiers will be looking
    ; for you now!  …    …    …
    ; I will hide Princess Zelda here.
    ; Do not worry!  Seek the elder!
    ; …    …    …
    ; Do you understand?
    ;     > Yes
    ;        Not at all
    ; --------------------------------------------------------------------------
    ; $0E03E7
    Message_0018:
    db $08, $59, $D0, $27, $D0, $59, $D7, $2D ; I⎵[se]n[se]⎵[tha]t
    db $59, $1A, $59, $26, $22, $20, $21, $2D ; ⎵a⎵might
    db $32, $59, $A7, $22, $25 ; y⎵[ev]il
    db $75 ; line 2
    db $A8, $1C, $1E, $59, $20, $2E, $22, $9D ; [for]ce⎵gui[des]
    db $59, $D8, $59, $E2, $33, $1A, $2B, $1D ; ⎵[the]⎵[wi]zard
    db $51, $2C ; 's
    db $76 ; line 3
    db $1A, $1C, $2D, $22, $C7, $2C, $59, $8C ; acti[on]s⎵[and ]
    db $1A, $2E, $20, $BE, $27, $2D, $2C, $59 ; aug[me]nts⎵
    db $B0, $2C ; [hi]s
    db $7E ; wait for key
    db $73 ; scroll text
    db $BD, $20, $22, $1C, $1A, $25, $59, $CB ; [ma]gical⎵[pow]
    db $A6, $41, $8A, $E6, $59, $C7, $25, $32 ; [er].[  ][The]⎵[on]ly
    db $73 ; scroll text
    db $E0, $1A, $29, $C7, $59, $29, $28, $2D ; [we]ap[on]⎵pot
    db $A3, $59, $A5, $28, $2E, $20, $21, $59 ; [ent]⎵[en]ough⎵
    db $DA ; [to]
    db $73 ; scroll text
    db $1D, $1E, $1F, $1E, $91, $D8, $59, $E2 ; defe[at ][the]⎵[wi]
    db $33, $1A, $2B, $1D, $59, $B5, $59, $D8 ; zard⎵[is]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $25, $1E, $20, $A5, $1D, $1A, $2B, $32 ; leg[en]dary
    db $59, $0C, $92, $A1, $12, $30, $C8, $1D ; ⎵M[ast][er ]Sw[or]d
    db $41 ; .
    db $73 ; scroll text
    db $08, $2D, $59, $B5, $59, $2C, $1A, $22 ; It⎵[is]⎵sai
    db $1D, $59, $D7, $2D, $59, $D8, $59, $2F ; d⎵[tha]t⎵[the]⎵v
    db $22, $25, $BA, $20, $1E, $59, $1E, $25 ; il[la]ge⎵el
    db $1D, $A6 ; d[er]
    db $73 ; scroll text
    db $B5, $59, $1A, $59, $9D, $1C, $A5, $1D ; [is]⎵a⎵[des]c[en]d
    db $93, $2D, $59, $C6, $59, $C7, $1E, $59 ; [an]t⎵[of]⎵[on]e⎵
    db $C6, $59, $D8 ; [of]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $41, $8A, $0C, $1A, $32, $97 ; .[  ]May[be]
    db $73 ; scroll text
    db $21, $1E, $59, $99, $2D, $1E, $25, $25 ; he⎵[can ]tell
    db $59, $E3, $59, $26, $C8, $1E, $43 ; ⎵[you]⎵m[or]e…
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $BD, $2B ; I⎵[wi]ll⎵[ma]r
    db $24, $59, $B0, $2C, $59, $21, $28, $2E ; k⎵[hi]s⎵hou
    db $D0, $59, $C7, $59, $E3, $2B ; [se]⎵[on]⎵[you]r
    db $7E ; wait for key
    db $73 ; scroll text
    db $BD, $29, $41, $8A, $01, $2E, $2D, $59 ; [ma]p.[  ]But⎵
    db $DF, $2D, $1C, $21, $59, $E3, $2B, $59 ; [wa]tch⎵[you]r⎵
    db $A7, $A6, $32 ; [ev][er]y
    db $73 ; scroll text
    db $26, $28, $2F, $1E, $3E, $8A, $08, $59 ; move![  ]I⎵
    db $1A, $26, $59, $1C, $A6, $2D, $8F, $59 ; am⎵c[er]t[ain]⎵
    db $D7, $2D, $59, $D8 ; [tha]t⎵[the]
    db $73 ; scroll text
    db $1C, $92, $25, $1E, $59, $D2, $25, $9E ; c[ast]le⎵[so]l[di]
    db $A6, $2C, $59, $E2, $25, $25, $59, $97 ; [er]s⎵[wi]ll⎵[be]
    db $59, $BB, $28, $24, $B4, $20 ; ⎵[lo]ok[in]g
    db $7E ; wait for key
    db $73 ; scroll text
    db $A8, $59, $E3, $59, $27, $28, $30, $3E ; [for]⎵[you]⎵now!
    db $8A, $43, $88, $43, $88, $43 ; [  ]…[    ]…[    ]…
    db $79, $2D ; play sfx
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $B0, $1D ; I⎵[wi]ll⎵[hi]d
    db $1E, $59, $0F, $2B, $B4, $1C, $1E, $2C ; e⎵Pr[in]ces
    db $2C, $59, $19, $1E, $25, $1D, $1A, $59 ; s⎵Zelda⎵
    db $AF, $1E, $41 ; [her]e.
    db $73 ; scroll text
    db $03, $28, $59, $C2, $59, $30, $C8, $2B ; Do⎵[not]⎵w[or]r
    db $32, $3E, $8A, $12, $1E, $1E, $24, $59 ; y![  ]Seek⎵
    db $D8, $59, $1E, $25, $1D, $A6, $3E ; [the]⎵eld[er]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $88, $43, $88, $43 ; …[    ]…[    ]…
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $2E, $27, $1D ; Do⎵[you]⎵und
    db $A6, $D3, $90, $3F ; [er][st][and]?
    db $73 ; scroll text
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $73 ; scroll text
    db $88, $89, $0D, $28, $2D, $59, $91, $1A ; [    ][   ]Not⎵[at ]a
    db $25, $25 ; ll
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; If you defeat the wizard, the
    ; soldiers may regain
    ; their sanity.
    ; Go, seek the Pendants!
    ; --------------------------------------------------------------------------
    ; $0E057F
    Message_0019:
    db $08, $1F, $59, $E3, $59, $1D, $1E, $1F ; If⎵[you]⎵def
    db $1E, $91, $D8, $59, $E2, $33, $1A, $2B ; e[at ][the]⎵[wi]zar
    db $1D, $42, $59, $D8 ; d,⎵[the]
    db $75 ; line 2
    db $D2, $25, $9E, $A6, $2C, $59, $BD, $32 ; [so]l[di][er]s⎵[ma]y
    db $59, $CE, $20, $8F ; ⎵[re]g[ain]
    db $76 ; line 3
    db $D8, $22, $2B, $59, $2C, $93, $B6, $32 ; [the]ir⎵s[an][it]y
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $28, $42, $59, $D0, $1E, $24, $59 ; Go,⎵[se]ek⎵
    db $D8, $59, $0F, $A5, $1D, $93, $2D, $2C ; [the]⎵P[en]d[an]ts
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Take the three Pendants into
    ; the Lost Woods.  The Master
    ; Sword awaits you there.
    ; --------------------------------------------------------------------------
    ; $0E05BE
    Message_001A:
    db $13, $1A, $24, $1E, $59, $D8, $59, $2D ; Take⎵[the]⎵t
    db $21, $CE, $1E, $59, $0F, $A5, $1D, $93 ; h[re]e⎵P[en]d[an]
    db $2D, $2C, $59, $B4, $DA ; ts⎵[in][to]
    db $75 ; line 2
    db $D8, $59, $0B, $28, $D3, $59, $16, $28 ; [the]⎵Lo[st]⎵Wo
    db $28, $1D, $2C, $41, $8A, $E6, $59, $0C ; ods.[  ][The]⎵M
    db $92, $A6 ; [ast][er]
    db $76 ; line 3
    db $12, $30, $C8, $1D, $59, $1A, $DF, $B6 ; Sw[or]d⎵a[wa][it]
    db $2C, $59, $E3, $59, $D8, $CE, $41 ; s⎵[you]⎵[the][re].
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK]!  You are a second too
    ; late.  I have failed… Zelda…
    ; The soldiers have
    ; abducted her.
    ; They have taken her to
    ; the castle.
    ; You must find her before the
    ; wizard works his magic.
    ; Please…You are our only hope…
    ; --------------------------------------------------------------------------
    ; $0E05F7
    Message_001B:
    db $6A, $3E, $8A, $E8, $59, $8D, $1A, $59 ; [LINK]![  ][You]⎵[are ]a⎵
    db $D0, $1C, $C7, $1D, $59, $DA, $28 ; [se]c[on]d⎵[to]o
    db $75 ; line 2
    db $BA, $2D, $1E, $41, $8A, $08, $59, $AD ; [la]te.[  ]I⎵[have]
    db $59, $1F, $1A, $22, $25, $1E, $1D, $43 ; ⎵failed…
    db $59, $19, $1E, $25, $1D, $1A, $43 ; ⎵Zelda…
    db $76 ; line 3
    db $E6, $59, $D2, $25, $9E, $A6, $2C, $59 ; [The]⎵[so]l[di][er]s⎵
    db $AD ; [have]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $1B, $1D, $2E, $1C, $2D, $A4, $AF ; abduct[ed ][her]
    db $41 ; .
    db $73 ; scroll text
    db $E6, $32, $59, $AD, $59, $2D, $1A, $24 ; [The]y⎵[have]⎵tak
    db $A0, $AF, $59, $DA ; [en ][her]⎵[to]
    db $73 ; scroll text
    db $D8, $59, $1C, $92, $25, $1E, $41 ; [the]⎵c[ast]le.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $BF, $D3, $59, $1F, $B4, $1D ; [You]⎵[mu][st]⎵f[in]d
    db $59, $AF, $59, $97, $A8, $1E, $59, $D8 ; ⎵[her]⎵[be][for]e⎵[the]
    db $73 ; scroll text
    db $E2, $33, $1A, $2B, $1D, $59, $30, $C8 ; [wi]zard⎵w[or]
    db $24, $2C, $59, $B0, $2C, $59, $BD, $20 ; ks⎵[hi]s⎵[ma]g
    db $22, $1C, $41 ; ic.
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $43, $E8, $59 ; Plea[se]…[You]⎵
    db $8D, $28, $2E, $2B, $59, $C7, $B9, $21 ; [are ]our⎵[on][ly ]h
    db $28, $29, $1E, $43 ; ope…
    db $7F ; end of message

    ; ==========================================================================
    ; Thank you, [LINK].  I had a
    ; feeling you were getting close.
    ; --------------------------------------------------------------------------
    ; $0E0684
    Message_001C:
    db $E5, $27, $24, $59, $E3, $42, $59, $6A ; [Tha]nk⎵[you],⎵[LINK]
    db $41, $8A, $08, $59, $B1, $1D, $59, $1A ; .[  ]I⎵[ha]d⎵a
    db $75 ; line 2
    db $1F, $1E, $1E, $25, $B3, $E3, $59, $E0 ; feel[ing ][you]⎵[we]
    db $CD, $AB, $2D, $B3, $1C, $BB, $D0, $41 ; [re ][get]t[ing ]c[lo][se].
    db $7F ; end of message

    ; ==========================================================================
    ; Yes, it was [LINK] who helped
    ; me escape from the dungeon!
    ; When I was captive the wizard
    ; said, "Once I have finished with
    ; you, the final one, the seal of
    ; the wise men will open."
    ; …    …    …
    ; [LINK], you must not let the
    ; land of Hyrule fall into the
    ; wizard's clutches.
    ; If he releases the seal of the
    ; seven wise men, evil power will
    ; overwhelm this land.
    ; Before that happens…
    ; before it's too late… destroy
    ; the wizard before he destroys
    ; all of Hyrule!  You can do it!
    ; You can…
    ; --------------------------------------------------------------------------
    ; $0E06A6
    Message_001D:
    db $18, $1E, $2C, $42, $59, $B6, $59, $DF ; Yes,⎵[it]⎵[wa]
    db $2C, $59, $6A, $59, $E1, $28, $59, $21 ; s⎵[LINK]⎵[wh]o⎵h
    db $1E, $25, $29, $1E, $1D ; elped
    db $75 ; line 2
    db $BE, $59, $1E, $2C, $1C, $1A, $29, $1E ; [me]⎵escape
    db $59, $A9, $26, $59, $D8, $59, $1D, $2E ; ⎵[fro]m⎵[the]⎵du
    db $27, $20, $1E, $C7, $3E ; nge[on]!
    db $76 ; line 3
    db $16, $21, $A0, $08, $59, $DF, $2C, $59 ; Wh[en ]I⎵[wa]s⎵
    db $1C, $1A, $29, $2D, $22, $2F, $1E, $59 ; captive⎵
    db $D8, $59, $E2, $33, $1A, $2B, $1D ; [the]⎵[wi]zard
    db $7E ; wait for key
    db $73 ; scroll text
    db $2C, $1A, $22, $1D, $42, $59, $4C, $0E ; said,⎵"O
    db $27, $1C, $1E, $59, $08, $59, $AD, $59 ; nce⎵I⎵[have]⎵
    db $1F, $B4, $B5, $21, $A4, $DE ; f[in][is]h[ed ][with]
    db $73 ; scroll text
    db $E3, $42, $59, $D8, $59, $1F, $B4, $1A ; [you],⎵[the]⎵f[in]a
    db $25, $59, $C7, $1E, $42, $59, $D8, $59 ; l⎵[on]e,⎵[the]⎵
    db $D0, $1A, $25, $59, $C6 ; [se]al⎵[of]
    db $73 ; scroll text
    db $D8, $59, $E2, $D0, $59, $BE, $27, $59 ; [the]⎵[wi][se]⎵[me]n⎵
    db $E2, $25, $25, $59, $C3, $41, $4C ; [wi]ll⎵[open]."
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $88, $43, $88, $43 ; …[    ]…[    ]…
    db $73 ; scroll text
    db $6A, $42, $59, $E3, $59, $BF, $D3, $59 ; [LINK],⎵[you]⎵[mu][st]⎵
    db $C2, $59, $25, $1E, $2D, $59, $D8 ; [not]⎵let⎵[the]
    db $73 ; scroll text
    db $BA, $27, $1D, $59, $C6, $59, $07, $32 ; [la]nd⎵[of]⎵Hy
    db $2B, $2E, $25, $1E, $59, $1F, $8E, $B4 ; rule⎵f[all ][in]
    db $DA, $59, $D8 ; [to]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E2, $33, $1A, $2B, $1D, $8B, $1C, $25 ; [wi]zard['s ]cl
    db $2E, $2D, $9A, $2C, $41 ; ut[che]s.
    db $73 ; scroll text
    db $08, $1F, $59, $21, $1E, $59, $CE, $25 ; If⎵he⎵[re]l
    db $1E, $1A, $D0, $2C, $59, $D8, $59, $D0 ; ea[se]s⎵[the]⎵[se]
    db $1A, $25, $59, $C6, $59, $D8 ; al⎵[of]⎵[the]
    db $73 ; scroll text
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $42, $59, $A7, $22, $25, $59, $CB, $A1 ; ,⎵[ev]il⎵[pow][er ]
    db $E2, $25, $25 ; [wi]ll
    db $7E ; wait for key
    db $73 ; scroll text
    db $28, $DD, $E1, $1E, $25, $26, $59, $D9 ; o[ver][wh]elm⎵[thi]
    db $2C, $59, $BA, $27, $1D, $41 ; s⎵[la]nd.
    db $73 ; scroll text
    db $01, $1E, $A8, $1E, $59, $D7, $2D, $59 ; Be[for]e⎵[tha]t⎵
    db $B1, $29, $29, $A5, $2C, $43 ; [ha]pp[en]s…
    db $73 ; scroll text
    db $97, $A8, $1E, $59, $B6, $8B, $DA, $28 ; [be][for]e⎵[it]['s ][to]o
    db $59, $BA, $2D, $1E, $43, $59, $9D, $DB ; ⎵[la]te…⎵[des][tr]
    db $28, $32 ; oy
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $E2, $33, $1A, $2B, $1D, $59 ; [the]⎵[wi]zard⎵
    db $97, $A8, $1E, $59, $21, $1E, $59, $9D ; [be][for]e⎵he⎵[des]
    db $DB, $28, $32, $2C ; [tr]oys
    db $73 ; scroll text
    db $8E, $C6, $59, $07, $32, $2B, $2E, $25 ; [all ][of]⎵Hyrul
    db $1E, $3E, $8A, $E8, $59, $99, $9F, $59 ; e![  ][You]⎵[can ][do]⎵
    db $B6, $3E ; [it]!
    db $73 ; scroll text
    db $E8, $59, $1C, $93, $43 ; [You]⎵c[an]…
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], be careful out there!
    ; I know you can save Hyrule!
    ; --------------------------------------------------------------------------
    ; $0E07EE
    Message_001E:
    db $6A, $42, $59, $97, $59, $1C, $1A, $CE ; [LINK],⎵[be]⎵ca[re]
    db $1F, $2E, $25, $59, $C5, $D8, $CE, $3E ; ful⎵[out ][the][re]!
    db $75 ; line 2
    db $08, $59, $B8, $59, $E3, $59, $99, $2C ; I⎵[know]⎵[you]⎵[can ]s
    db $1A, $2F, $1E, $59, $07, $32, $2B, $2E ; ave⎵Hyru
    db $25, $1E, $3E ; le!
    db $7F ; end of message

    ; ==========================================================================
    ; Help me…
    ; Please help me…
    ; I am a prisoner in the dungeon
    ; of the castle.
    ; My name is Zelda.
    ; The wizard, Agahnim, has done…
    ; something to the other missing
    ; girls.  Now only I remain…
    ; Agahnim has seized control of
    ; the castle and is now trying to
    ; open the seven wise men's
    ; seal.  …   …
    ; I am in the dungeon of the
    ; castle.
    ; Please help me…
    ; --------------------------------------------------------------------------
    ; $0E0813
    Message_001F:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $07, $1E, $25, $29, $59, $BE, $43 ; Help⎵[me]…
    db $78, $01 ; delay
    db $76 ; line 3
    db $0F, $25, $1E, $1A, $D0, $59, $21, $1E ; Plea[se]⎵he
    db $25, $29, $59, $BE, $43 ; lp⎵[me]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $1A, $26, $59, $1A, $59, $29 ; I⎵am⎵a⎵p
    db $2B, $B5, $C7, $A1, $B4, $59, $D8, $59 ; r[is][on][er ][in]⎵[the]⎵
    db $1D, $2E, $27, $20, $1E, $C7 ; dunge[on]
    db $73 ; scroll text
    db $C6, $59, $D8, $59, $1C, $92, $25, $1E ; [of]⎵[the]⎵c[ast]le
    db $41 ; .
    db $73 ; scroll text
    db $0C, $32, $59, $27, $1A, $BE, $59, $B5 ; My⎵na[me]⎵[is]
    db $59, $19, $1E, $25, $1D, $1A, $41 ; ⎵Zelda.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $E2, $33, $1A, $2B, $1D, $42 ; [The]⎵[wi]zard,
    db $59, $00, $20, $1A, $21, $27, $22, $26 ; ⎵Agahnim
    db $42, $59, $AE, $59, $9F, $27, $1E, $43 ; ,⎵[has]⎵[do]ne…
    db $73 ; scroll text
    db $CF, $D5, $20, $59, $DA, $59, $D8, $59 ; [some][thin]g⎵[to]⎵[the]⎵
    db $28, $D8, $2B, $59, $26, $B5, $2C, $B4 ; o[the]r⎵m[is]s[in]
    db $20 ; g
    db $73 ; scroll text
    db $20, $22, $2B, $25, $2C, $41, $8A, $0D ; girls.[  ]N
    db $28, $30, $59, $C7, $B9, $08, $59, $CE ; ow⎵[on][ly ]I⎵[re]
    db $BD, $B4, $43 ; [ma][in]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $20, $1A, $21, $27, $22, $26, $59 ; Agahnim⎵
    db $AE, $59, $D0, $22, $33, $A4, $1C, $C7 ; [has]⎵[se]iz[ed ]c[on]
    db $DB, $28, $25, $59, $C6 ; [tr]ol⎵[of]
    db $73 ; scroll text
    db $D8, $59, $1C, $92, $25, $1E, $59, $8C ; [the]⎵c[ast]le⎵[and ]
    db $B5, $59, $27, $28, $30, $59, $DB, $32 ; [is]⎵now⎵[tr]y
    db $B3, $DA ; [ing ][to]
    db $73 ; scroll text
    db $C3, $59, $D8, $59, $D0, $2F, $A0, $E2 ; [open]⎵[the]⎵[se]v[en ][wi]
    db $D0, $59, $BE, $27, $51, $2C ; [se]⎵[me]n's
    db $7E ; wait for key
    db $73 ; scroll text
    db $D0, $1A, $25, $41, $8A, $43, $89, $43 ; [se]al.[  ]…[   ]…
    db $73 ; scroll text
    db $08, $59, $1A, $26, $59, $B4, $59, $D8 ; I⎵am⎵[in]⎵[the]
    db $59, $1D, $2E, $27, $20, $1E, $C7, $59 ; ⎵dunge[on]⎵
    db $C6, $59, $D8 ; [of]⎵[the]
    db $73 ; scroll text
    db $1C, $92, $25, $1E, $41 ; c[ast]le.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $59, $21, $1E ; Plea[se]⎵he
    db $25, $29, $59, $BE, $43 ; lp⎵[me]…
    db $7F ; end of message

    ; ==========================================================================
    ; Help me…
    ; I am in the dungeon of the
    ; castle.
    ; I know there is a hidden path
    ; from outside of  the castle to
    ; the garden inside.
    ; --------------------------------------------------------------------------
    ; $0E090D
    Message_0020:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $07, $1E, $25, $29, $59, $BE, $43 ; Help⎵[me]…
    db $75 ; line 2
    db $08, $59, $1A, $26, $59, $B4, $59, $D8 ; I⎵am⎵[in]⎵[the]
    db $59, $1D, $2E, $27, $20, $1E, $C7, $59 ; ⎵dunge[on]⎵
    db $C6, $59, $D8 ; [of]⎵[the]
    db $76 ; line 3
    db $1C, $92, $25, $1E, $41 ; c[ast]le.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $B8, $59, $D8, $CD, $B5, $59 ; I⎵[know]⎵[the][re ][is]⎵
    db $1A, $59, $B0, $1D, $1D, $A0, $29, $94 ; a⎵[hi]dd[en ]p[at]
    db $21 ; h
    db $73 ; scroll text
    db $A9, $26, $59, $28, $2E, $2D, $2C, $22 ; [fro]m⎵outsi
    db $1D, $1E, $59, $C6, $8A, $D8, $59, $1C ; de⎵[of][  ][the]⎵c
    db $92, $25, $1E, $59, $DA ; [ast]le⎵[to]
    db $73 ; scroll text
    db $D8, $59, $20, $1A, $2B, $1D, $A0, $B4 ; [the]⎵gard[en ][in]
    db $2C, $22, $1D, $1E, $41 ; side.
    db $7F ; end of message

    ; ==========================================================================
    ; There is a secret passage in
    ; the throne room that leads to
    ; Sanctuary.  I'm sure the old
    ; man there will help us.
    ; --------------------------------------------------------------------------
    ; $0E096A
    Message_0021:
    db $E6, $CD, $B5, $59, $1A, $59, $D0, $1C ; [The][re ][is]⎵a⎵[se]c
    db $CE, $2D, $59, $29, $1A, $2C, $2C, $1A ; [re]t⎵passa
    db $20, $1E, $59, $B4 ; ge⎵[in]
    db $75 ; line 2
    db $D8, $59, $2D, $21, $2B, $C7, $1E, $59 ; [the]⎵thr[on]e⎵
    db $2B, $28, $28, $26, $59, $D7, $2D, $59 ; room⎵[tha]t⎵
    db $25, $1E, $1A, $1D, $2C, $59, $DA ; leads⎵[to]
    db $76 ; line 3
    db $12, $93, $1C, $2D, $2E, $1A, $2B, $32 ; S[an]ctuary
    db $41, $8A, $08, $51, $26, $59, $2C, $2E ; .[  ]I'm⎵su
    db $CD, $D8, $59, $28, $25, $1D ; [re ][the]⎵old
    db $7E ; wait for key
    db $73 ; scroll text
    db $BC, $59, $D8, $CD, $E2, $25, $25, $59 ; [man]⎵[the][re ][wi]ll⎵
    db $21, $1E, $25, $29, $59, $2E, $2C, $41 ; help⎵us.
    db $7F ; end of message

    ; ==========================================================================
    ; That ornamental shelf should
    ; open.  Do you have a light?
    ; It's pitch dark inside and you
    ; can't see without one.
    ; If you're ready, let's go!
    ; Help me push it from the left!
    ; --------------------------------------------------------------------------
    ; $0E09C0
    Message_0022:
    db $E5, $2D, $59, $C8, $27, $1A, $BE, $27 ; [Tha]t⎵[or]na[me]n
    db $2D, $1A, $25, $59, $D1, $1E, $25, $1F ; tal⎵[sh]elf
    db $59, $D1, $28, $2E, $25, $1D ; ⎵[sh]ould
    db $75 ; line 2
    db $C3, $41, $8A, $03, $28, $59, $E3, $59 ; [open].[  ]Do⎵[you]⎵
    db $AD, $59, $1A, $59, $25, $22, $20, $21 ; [have]⎵a⎵ligh
    db $2D, $3F ; t?
    db $76 ; line 3
    db $08, $2D, $8B, $29, $B6, $1C, $21, $59 ; It['s ]p[it]ch⎵
    db $1D, $1A, $2B, $24, $59, $B4, $2C, $22 ; dark⎵[in]si
    db $1D, $1E, $59, $8C, $E3 ; de⎵[and ][you]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $93, $51, $2D, $59, $D0, $1E, $59 ; c[an]'t⎵[se]e⎵
    db $DE, $C5, $C7, $1E, $41 ; [with][out ][on]e.
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $51, $CD, $CE, $1A ; If⎵[you]'[re ][re]a
    db $1D, $32, $42, $59, $25, $1E, $2D, $8B ; dy,⎵let['s ]
    db $AC, $3E ; [go]!
    db $73 ; scroll text
    db $07, $1E, $25, $29, $59, $BE, $59, $29 ; Help⎵[me]⎵p
    db $2E, $D1, $59, $B6, $59, $A9, $26, $59 ; u[sh]⎵[it]⎵[fro]m⎵
    db $D8, $59, $25, $1E, $1F, $2D, $3E ; [the]⎵left!
    db $7F ; end of message

    ; ==========================================================================
    ; You have to pull the lever to
    ; open the door.  (Press the Ⓐ
    ; Button and hold Down on the
    ; Control Pad. )
    ; --------------------------------------------------------------------------
    ; $0E0A3A
    Message_0023:
    db $E8, $59, $AD, $59, $DA, $59, $29, $2E ; [You]⎵[have]⎵[to]⎵pu
    db $25, $25, $59, $D8, $59, $25, $A7, $A1 ; ll⎵[the]⎵l[ev][er ]
    db $DA ; [to]
    db $75 ; line 2
    db $C3, $59, $D8, $59, $9F, $C8, $41, $8A ; [open]⎵[the]⎵[do][or].[  ]
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5B ; Ⓐ
    db $76 ; line 3
    db $01, $2E, $2D, $DA, $27, $59, $8C, $21 ; But[to]n⎵[and ]h
    db $28, $25, $1D, $59, $03, $28, $30, $27 ; old⎵Down
    db $59, $C7, $59, $D8 ; ⎵[on]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $02, $C7, $DB, $28, $25, $59, $0F, $1A ; C[on][tr]ol⎵Pa
    db $1D, $41, $59, $46 ; d.⎵)
    db $7F ; end of message

    ; ==========================================================================
    ; All right,  let's get out of here
    ; before the wizard notices.  I
    ; know a secret path, but first
    ; we have to go to the
    ; first floor.  Let's  go!
    ; --------------------------------------------------------------------------
    ; $0E0A81
    Message_0024:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $42, $8A, $25, $1E, $2D, $8B, $AB ; t,[  ]let['s ][get]
    db $59, $C5, $C6, $59, $AF, $1E ; ⎵[out ][of]⎵[her]e
    db $75 ; line 2
    db $97, $A8, $1E, $59, $D8, $59, $E2, $33 ; [be][for]e⎵[the]⎵[wi]z
    db $1A, $2B, $1D, $59, $C2, $22, $1C, $1E ; ard⎵[not]ice
    db $2C, $41, $8A, $08 ; s.[  ]I
    db $76 ; line 3
    db $B8, $59, $1A, $59, $D0, $1C, $CE, $2D ; [know]⎵a⎵[se]c[re]t
    db $59, $29, $94, $21, $42, $59, $1B, $2E ; ⎵p[at]h,⎵bu
    db $2D, $59, $1F, $22, $2B, $D3 ; t⎵fir[st]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E0, $59, $AD, $59, $DA, $59, $AC, $59 ; [we]⎵[have]⎵[to]⎵[go]⎵
    db $DA, $59, $D8 ; [to]⎵[the]
    db $73 ; scroll text
    db $1F, $22, $2B, $D3, $59, $1F, $BB, $C8 ; fir[st]⎵f[lo][or]
    db $41, $8A, $0B, $1E, $2D, $8B, $59, $AC ; .[  ]Let['s ]⎵[go]
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], listen carefully.  The
    ; wizard is magically controlling
    ; all the soldiers in the castle.
    ; I fear the worst for
    ; my father…
    ; The wizard is an inhuman fiend
    ; with strong magical powers!
    ; …   …   …
    ; Do you understand?
    ;     > Yes
    ;        Not at all
    ; --------------------------------------------------------------------------
    ; $0E0AE3
    Message_0025:
    db $6A, $42, $59, $25, $B5, $2D, $A0, $1C ; [LINK],⎵l[is]t[en ]c
    db $1A, $CE, $1F, $2E, $25, $25, $32, $41 ; a[re]fully.
    db $8A, $E6 ; [  ][The]
    db $75 ; line 2
    db $E2, $33, $1A, $2B, $1D, $59, $B5, $59 ; [wi]zard⎵[is]⎵
    db $BD, $20, $22, $1C, $1A, $25, $B9, $1C ; [ma]gical[ly ]c
    db $C7, $DB, $28, $25, $25, $B4, $20 ; [on][tr]oll[in]g
    db $76 ; line 3
    db $8E, $D8, $59, $D2, $25, $9E, $A6, $2C ; [all ][the]⎵[so]l[di][er]s
    db $59, $B4, $59, $D8, $59, $1C, $92, $25 ; ⎵[in]⎵[the]⎵c[ast]l
    db $1E, $41 ; e.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $1F, $A2, $59, $D8, $59, $30 ; I⎵f[ear]⎵[the]⎵w
    db $C8, $D3, $59, $A8 ; [or][st]⎵[for]
    db $73 ; scroll text
    db $26, $32, $59, $1F, $94, $AF, $43 ; my⎵f[at][her]…
    db $73 ; scroll text
    db $E6, $59, $E2, $33, $1A, $2B, $1D, $59 ; [The]⎵[wi]zard⎵
    db $B5, $59, $93, $59, $B4, $21, $2E, $BC ; [is]⎵[an]⎵[in]hu[man]
    db $59, $1F, $22, $A5, $1D ; ⎵fi[en]d
    db $7E ; wait for key
    db $73 ; scroll text
    db $DE, $59, $D3, $2B, $C7, $20, $59, $BD ; [with]⎵[st]r[on]g⎵[ma]
    db $20, $22, $1C, $1A, $25, $59, $CB, $A6 ; gical⎵[pow][er]
    db $2C, $3E ; s!
    db $73 ; scroll text
    db $43, $89, $43, $89, $43 ; …[   ]…[   ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $2E, $27, $1D ; Do⎵[you]⎵und
    db $A6, $D3, $90, $3F ; [er][st][and]?
    db $73 ; scroll text
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $73 ; scroll text
    db $88, $89, $0D, $28, $2D, $59, $91, $1A ; [    ][   ]Not⎵[at ]a
    db $25, $25 ; ll
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; You should follow the marks
    ; the elder made on your map
    ; when you explore.
    ; If you don't know what to do
    ; next, you can also visit a
    ; fortune teller.
    ; --------------------------------------------------------------------------
    ; $0E0B88
    Message_0026:
    db $E8, $59, $D1, $28, $2E, $25, $1D, $59 ; [You]⎵[sh]ould⎵
    db $1F, $28, $25, $BB, $30, $59, $D8, $59 ; fol[lo]w⎵[the]⎵
    db $BD, $2B, $24, $2C ; [ma]rks
    db $75 ; line 2
    db $D8, $59, $1E, $25, $1D, $A1, $BD, $1D ; [the]⎵eld[er ][ma]d
    db $1E, $59, $C7, $59, $E3, $2B, $59, $BD ; e⎵[on]⎵[you]r⎵[ma]
    db $29 ; p
    db $76 ; line 3
    db $E1, $A0, $E3, $59, $1E, $31, $29, $BB ; [wh][en ][you]⎵exp[lo]
    db $CE, $41 ; [re].
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $9F, $C0, $B8 ; If⎵[you]⎵[do][n't ][know]
    db $59, $E1, $91, $DA, $59, $9F ; ⎵[wh][at ][to]⎵[do]
    db $73 ; scroll text
    db $27, $1E, $31, $2D, $42, $59, $E3, $59 ; next,⎵[you]⎵
    db $99, $1A, $25, $D2, $59, $2F, $B5, $B6 ; [can ]al[so]⎵v[is][it]
    db $59, $1A ; ⎵a
    db $73 ; scroll text
    db $A8, $2D, $2E, $27, $1E, $59, $2D, $1E ; [for]tune⎵te
    db $25, $25, $A6, $41 ; ll[er].
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], you are wonderful!
    ; As I thought, you have the
    ; power of the Hero inside you!
    ; Now, you should get the Master
    ; Sword.  I am confident that you
    ; can defeat the evil wizard!
    ; --------------------------------------------------------------------------
    ; $0E0BEA
    Message_0027:
    db $6A, $42, $59, $E3, $59, $8D, $30, $C7 ; [LINK],⎵[you]⎵[are ]w[on]
    db $1D, $A6, $1F, $2E, $25, $3E ; d[er]ful!
    db $75 ; line 2
    db $00, $2C, $59, $08, $59, $2D, $21, $28 ; As⎵I⎵tho
    db $2E, $20, $21, $2D, $42, $59, $E3, $59 ; ught,⎵[you]⎵
    db $AD, $59, $D8 ; [have]⎵[the]
    db $76 ; line 3
    db $CB, $A1, $C6, $59, $D8, $59, $E4, $28 ; [pow][er ][of]⎵[the]⎵[Her]o
    db $59, $B4, $2C, $22, $1D, $1E, $59, $E3 ; ⎵[in]side⎵[you]
    db $3E ; !
    db $7E ; wait for key
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $E3, $59, $D1 ; Now,⎵[you]⎵[sh]
    db $28, $2E, $25, $1D, $59, $AB, $59, $D8 ; ould⎵[get]⎵[the]
    db $59, $0C, $92, $A6 ; ⎵M[ast][er]
    db $73 ; scroll text
    db $12, $30, $C8, $1D, $41, $8A, $08, $59 ; Sw[or]d.[  ]I⎵
    db $1A, $26, $59, $1C, $C7, $1F, $22, $1D ; am⎵c[on]fid
    db $A3, $59, $D7, $2D, $59, $E3 ; [ent]⎵[tha]t⎵[you]
    db $73 ; scroll text
    db $99, $1D, $1E, $1F, $1E, $91, $D8, $59 ; [can ]defe[at ][the]⎵
    db $A7, $22, $25, $59, $E2, $33, $1A, $2B ; [ev]il⎵[wi]zar
    db $1D, $3E ; d!
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK]!  Help!  The soldiers
    ; are coming to Sanctuary!
    ; AIEEEEEEE!
    ; … … …
    ; --------------------------------------------------------------------------
    ; $0E0C5F
    Message_0028:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $6A, $3E, $8A, $07, $1E, $25, $29, $3E ; [LINK]![  ]Help!
    db $8A, $E6, $59, $D2, $25, $9E, $A6, $2C ; [  ][The]⎵[so]l[di][er]s
    db $75 ; line 2
    db $8D, $9B, $B3, $DA, $59, $12, $93, $1C ; [are ][com][ing ][to]⎵S[an]c
    db $2D, $2E, $1A, $2B, $32, $3E ; tuary!
    db $76 ; line 3
    db $00, $08, $04, $04, $04, $04, $04, $04 ; AIEEEEEE
    db $04, $3E ; E!
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $59, $43, $59, $43 ; …⎵…⎵…
    db $7F ; end of message

    ; ==========================================================================
    ; After passing through these
    ; sewers, we will be very close
    ; to Sanctuary!
    ; Let's be careful!
    ; --------------------------------------------------------------------------
    ; $0E0C95
    Message_0029:
    db $00, $1F, $D4, $29, $1A, $2C, $2C, $B3 ; Af[ter ]pass[ing ]
    db $2D, $21, $2B, $28, $2E, $20, $21, $59 ; through⎵
    db $D8, $D0 ; [the][se]
    db $75 ; line 2
    db $D0, $E0, $2B, $2C, $42, $59, $E0, $59 ; [se][we]rs,⎵[we]⎵
    db $E2, $25, $25, $59, $97, $59, $DD, $32 ; [wi]ll⎵[be]⎵[ver]y
    db $59, $1C, $BB, $D0 ; ⎵c[lo][se]
    db $76 ; line 3
    db $DA, $59, $12, $93, $1C, $2D, $2E, $1A ; [to]⎵S[an]ctua
    db $2B, $32, $3E ; ry!
    db $7E ; wait for key
    db $73 ; scroll text
    db $0B, $1E, $2D, $8B, $97, $59, $1C, $1A ; Let['s ][be]⎵ca
    db $CE, $1F, $2E, $25, $3E ; [re]ful!
    db $7F ; end of message

    ; ==========================================================================
    ; Sanctuary is just beyond that
    ; door.  Pull the switch over
    ; there.
    ; --------------------------------------------------------------------------
    ; $0E0CD8
    Message_002A:
    db $12, $93, $1C, $2D, $2E, $1A, $2B, $32 ; S[an]ctuary
    db $59, $B5, $59, $B7, $59, $97, $32, $C7 ; ⎵[is]⎵[just]⎵[be]y[on]
    db $1D, $59, $D7, $2D ; d⎵[tha]t
    db $75 ; line 2
    db $9F, $C8, $41, $8A, $0F, $2E, $25, $25 ; [do][or].[  ]Pull
    db $59, $D8, $59, $2C, $E2, $2D, $1C, $21 ; ⎵[the]⎵s[wi]tch
    db $59, $28, $DD ; ⎵o[ver]
    db $76 ; line 3
    db $D8, $CE, $41 ; [the][re].
    db $7F ; end of message

    ; ==========================================================================
    ; Who? Oh, it's you, [LINK]!
    ; What can I do for you, young
    ; man?  The elder?  Oh, no one
    ; has seen him since the wizard
    ; began collecting victims…
    ; …   …   …
    ; What?  Master Sword?  Well, I
    ; don't remember the details
    ; exactly, but…
    ; --------------------------------------------------------------------------
    ; $0E0D05
    Message_002B:
    db $16, $21, $28, $3F, $59, $0E, $21, $42 ; Who?⎵Oh,
    db $59, $B6, $8B, $E3, $42, $59, $6A, $3E ; ⎵[it]['s ][you],⎵[LINK]!
    db $75 ; line 2
    db $16, $B1, $2D, $59, $99, $08, $59, $9F ; W[ha]t⎵[can ]I⎵[do]
    db $59, $A8, $59, $E3, $42, $59, $E3, $27 ; ⎵[for]⎵[you],⎵[you]n
    db $20 ; g
    db $76 ; line 3
    db $BC, $3F, $8A, $E6, $59, $1E, $25, $1D ; [man]?[  ][The]⎵eld
    db $A6, $3F, $8A, $0E, $21, $42, $59, $27 ; [er]?[  ]Oh,⎵n
    db $28, $59, $C7, $1E ; o⎵[on]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $AE, $59, $D0, $A0, $B0, $26, $59, $2C ; [has]⎵[se][en ][hi]m⎵s
    db $B4, $1C, $1E, $59, $D8, $59, $E2, $33 ; [in]ce⎵[the]⎵[wi]z
    db $1A, $2B, $1D ; ard
    db $73 ; scroll text
    db $97, $20, $93, $59, $1C, $28, $25, $25 ; [be]g[an]⎵coll
    db $1E, $1C, $2D, $B3, $2F, $22, $1C, $2D ; ect[ing ]vict
    db $22, $26, $2C, $43 ; ims…
    db $73 ; scroll text
    db $43, $89, $43, $89, $43 ; …[   ]…[   ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $3F, $8A, $0C, $92, $A1 ; W[ha]t?[  ]M[ast][er ]
    db $12, $30, $C8, $1D, $3F, $8A, $16, $1E ; Sw[or]d?[  ]We
    db $25, $25, $42, $59, $08 ; ll,⎵I
    db $73 ; scroll text
    db $9F, $C0, $CE, $BE, $26, $97, $2B, $59 ; [do][n't ][re][me]m[be]r⎵
    db $D8, $59, $1D, $1E, $2D, $1A, $22, $25 ; [the]⎵detail
    db $2C ; s
    db $73 ; scroll text
    db $1E, $31, $1A, $1C, $2D, $25, $32, $42 ; exactly,
    db $59, $1B, $2E, $2D, $43 ; ⎵but…
    db $7F ; end of message

    ; ==========================================================================
    ; Long ago, a prosperous people
    ; known as the Hylia inhabited
    ; this land…
    ; Legends tell of many treasures
    ; that the Hylia hid throughout
    ; the land…
    ; The Master Sword, a mighty
    ; blade forged against those
    ; with evil hearts, is one of
    ; them.  People say that now it
    ; is sleeping deep in the forest…
    ; … … …
    ; Do you understand the legend?
    ;     > Yes
    ;        Not at all
    ; --------------------------------------------------------------------------
    ; $0E0DA4
    Message_002C:
    db $0B, $C7, $20, $59, $1A, $AC, $42, $59 ; L[on]g⎵a[go],⎵
    db $1A, $59, $CC, $2C, $C9, $28, $2E, $2C ; a⎵[pro]s[per]ous
    db $59, $29, $1E, $28, $CA ; ⎵peo[ple]
    db $75 ; line 2
    db $B8, $27, $59, $1A, $2C, $59, $D8, $59 ; [know]n⎵as⎵[the]⎵
    db $07, $32, $25, $22, $1A, $59, $B4, $B1 ; Hylia⎵[in][ha]
    db $1B, $B6, $1E, $1D ; b[it]ed
    db $76 ; line 3
    db $D9, $2C, $59, $BA, $27, $1D, $43 ; [thi]s⎵[la]nd…
    db $7E ; wait for key
    db $73 ; scroll text
    db $0B, $1E, $20, $A5, $1D, $2C, $59, $2D ; Leg[en]ds⎵t
    db $1E, $25, $25, $59, $C6, $59, $BC, $32 ; ell⎵[of]⎵[man]y
    db $59, $DB, $1E, $1A, $2C, $2E, $CE, $2C ; ⎵[tr]easu[re]s
    db $73 ; scroll text
    db $D7, $2D, $59, $D8, $59, $07, $32, $25 ; [tha]t⎵[the]⎵Hyl
    db $22, $1A, $59, $B0, $1D, $59, $2D, $21 ; ia⎵[hi]d⎵th
    db $2B, $28, $2E, $20, $21, $28, $2E, $2D ; roughout
    db $73 ; scroll text
    db $D8, $59, $BA, $27, $1D, $43 ; [the]⎵[la]nd…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $0C, $92, $A1, $12, $30, $C8 ; [The]⎵M[ast][er ]Sw[or]
    db $1D, $42, $59, $1A, $59, $26, $22, $20 ; d,⎵a⎵mig
    db $21, $2D, $32 ; hty
    db $73 ; scroll text
    db $1B, $BA, $1D, $1E, $59, $A8, $20, $A4 ; b[la]de⎵[for]g[ed ]
    db $1A, $20, $8F, $D3, $59, $2D, $21, $28 ; ag[ain][st]⎵tho
    db $D0 ; [se]
    db $73 ; scroll text
    db $DE, $59, $A7, $22, $25, $59, $21, $A2 ; [with]⎵[ev]il⎵h[ear]
    db $2D, $2C, $42, $59, $B5, $59, $C7, $1E ; ts,⎵[is]⎵[on]e
    db $59, $C6 ; ⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $26, $41, $8A, $0F, $1E, $28, $CA ; [the]m.[  ]Peo[ple]
    db $59, $2C, $1A, $32, $59, $D7, $2D, $59 ; ⎵say⎵[tha]t⎵
    db $27, $28, $30, $59, $B6 ; now⎵[it]
    db $73 ; scroll text
    db $B5, $59, $2C, $25, $1E, $1E, $29, $B3 ; [is]⎵sleep[ing ]
    db $1D, $1E, $1E, $29, $59, $B4, $59, $D8 ; deep⎵[in]⎵[the]
    db $59, $A8, $1E, $D3, $43 ; ⎵[for]e[st]…
    db $73 ; scroll text
    db $43, $59, $43, $59, $43 ; …⎵…⎵…
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $2E, $27, $1D ; Do⎵[you]⎵und
    db $A6, $D3, $8C, $D8, $59, $25, $1E, $20 ; [er][st][and ][the]⎵leg
    db $A5, $1D, $3F ; [en]d?
    db $73 ; scroll text
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $73 ; scroll text
    db $88, $89, $0D, $28, $2D, $59, $91, $1A ; [    ][   ]Not⎵[at ]a
    db $25, $25 ; ll
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Anyway, look for the elder.
    ; There must be someone in the
    ; village who knows where he is.
    ; You take care now, [LINK]…
    ; --------------------------------------------------------------------------
    ; $0E0EA6
    Message_002D:
    db $00, $27, $32, $DF, $32, $42, $59, $BB ; Any[wa]y,⎵[lo]
    db $28, $24, $59, $A8, $59, $D8, $59, $1E ; ok⎵[for]⎵[the]⎵e
    db $25, $1D, $A6, $41 ; ld[er].
    db $75 ; line 2
    db $E6, $CD, $BF, $D3, $59, $97, $59, $CF ; [The][re ][mu][st]⎵[be]⎵[some]
    db $C7, $1E, $59, $B4, $59, $D8 ; [on]e⎵[in]⎵[the]
    db $76 ; line 3
    db $2F, $22, $25, $BA, $20, $1E, $59, $E1 ; vil[la]ge⎵[wh]
    db $28, $59, $B8, $2C, $59, $E1, $A6, $1E ; o⎵[know]s⎵[wh][er]e
    db $59, $21, $1E, $59, $B5, $41 ; ⎵he⎵[is].
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $2D, $1A, $24, $1E, $59, $1C ; [You]⎵take⎵c
    db $8D, $27, $28, $30, $42, $59, $6A, $43 ; [are ]now,⎵[LINK]…
    db $7F ; end of message

    ; ==========================================================================
    ; Ohhh,[LINK].  You've changed!
    ; You look marvelous…  Please
    ; save us from Agahnim
    ; the wizard!
    ; --------------------------------------------------------------------------
    ; $0E0EF3
    Message_002E:
    db $0E, $21, $21, $21, $42, $6A, $41, $8A ; Ohhh,[LINK].[  ]
    db $E8, $51, $2F, $1E, $59, $1C, $B1, $27 ; [You]'ve⎵c[ha]n
    db $20, $1E, $1D, $3E ; ged!
    db $75 ; line 2
    db $E8, $59, $BB, $28, $24, $59, $BD, $2B ; [You]⎵[lo]ok⎵[ma]r
    db $2F, $1E, $BB, $2E, $2C, $43, $8A, $0F ; ve[lo]us…[  ]P
    db $25, $1E, $1A, $D0 ; lea[se]
    db $76 ; line 3
    db $2C, $1A, $2F, $1E, $59, $2E, $2C, $59 ; save⎵us⎵
    db $A9, $26, $59, $00, $20, $1A, $21, $27 ; [fro]m⎵Agahn
    db $22, $26 ; im
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $E2, $33, $1A, $2B, $1D, $3E ; [the]⎵[wi]zard!
    db $7F ; end of message

    ; ==========================================================================
    ; Hey!  Here is [LINK], the
    ; wanted man!  Soldiers!  Anyone!
    ; Come quickly!
    ; --------------------------------------------------------------------------
    ; $0E0F3A
    Message_002F:
    db $07, $1E, $32, $3E, $8A, $E4, $1E, $59 ; Hey![  ][Her]e⎵
    db $B5, $59, $6A, $42, $59, $D8 ; [is]⎵[LINK],⎵[the]
    db $75 ; line 2
    db $DF, $27, $2D, $A4, $BC, $3E, $8A, $12 ; [wa]nt[ed ][man]![  ]S
    db $28, $25, $9E, $A6, $2C, $3E, $8A, $00 ; ol[di][er]s![  ]A
    db $27, $32, $C7, $1E, $3E ; ny[on]e!
    db $76 ; line 3
    db $02, $28, $BE, $59, $2A, $2E, $22, $9C ; Co[me]⎵qui[ck]
    db $25, $32, $3E ; ly!
    db $7F ; end of message

    ; ==========================================================================
    ; Incredible!  At last you have
    ; the three Pendants…  Now, you
    ; should go to the Lost Woods.
    ; If you are the true Hero, the
    ; sword itself will select you.
    ; … … …
    ; --------------------------------------------------------------------------
    ; $0E0F6B
    Message_0030:
    db $08, $27, $1C, $CE, $9E, $95, $3E, $8A ; Inc[re][di][ble]![  ]
    db $00, $2D, $59, $BA, $D3, $59, $E3, $59 ; At⎵[la][st]⎵[you]⎵
    db $AD ; [have]
    db $75 ; line 2
    db $D8, $59, $2D, $21, $CE, $1E, $59, $0F ; [the]⎵th[re]e⎵P
    db $A5, $1D, $93, $2D, $2C, $43, $8A, $0D ; [en]d[an]ts…[  ]N
    db $28, $30, $42, $59, $E3 ; ow,⎵[you]
    db $76 ; line 3
    db $D1, $28, $2E, $25, $1D, $59, $AC, $59 ; [sh]ould⎵[go]⎵
    db $DA, $59, $D8, $59, $0B, $28, $D3, $59 ; [to]⎵[the]⎵Lo[st]⎵
    db $16, $28, $28, $1D, $2C, $41 ; Woods.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $8D, $D8, $59 ; If⎵[you]⎵[are ][the]⎵
    db $DB, $2E, $1E, $59, $E4, $28, $42, $59 ; [tr]ue⎵[Her]o,⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $2C, $30, $C8, $1D, $59, $B6, $D0, $25 ; sw[or]d⎵[it][se]l
    db $1F, $59, $E2, $25, $25, $59, $D0, $25 ; f⎵[wi]ll⎵[se]l
    db $1E, $1C, $2D, $59, $E3, $41 ; ect⎵[you].
    db $73 ; scroll text
    db $43, $59, $43, $59, $43 ; …⎵…⎵…
    db $7F ; end of message

    ; ==========================================================================
    ; I am too old to fight.
    ; I can only rely on you.
    ; --------------------------------------------------------------------------
    ; $0E0FDA
    Message_0031:
    db $08, $59, $1A, $26, $59, $DA, $28, $59 ; I⎵am⎵[to]o⎵
    db $28, $25, $1D, $59, $DA, $59, $1F, $22 ; old⎵[to]⎵fi
    db $20, $21, $2D, $41 ; ght.
    db $75 ; line 2
    db $08, $59, $99, $C7, $B9, $CE, $B9, $C7 ; I⎵[can ][on][ly ][re][ly ][on]
    db $59, $E3, $41 ; ⎵[you].
    db $7F ; end of message

    ; ==========================================================================
    ; I am, indeed, Sahasrahla, the
    ; village elder and a descendent
    ; of the seven wise men.
    ; …   …     Oh really?
    ; [LINK], I am surprised a young
    ; man like you is searching for
    ; the sword of evil's bane.
    ; Not just anyone can use that
    ; weapon.  Legends say only the
    ; Hero who has won the three
    ; Pendants can wield the sword.
    ; …   …   …
    ; Do you really want to find it?
    ;     > Yeah!
    ;        Of Course!
    ; --------------------------------------------------------------------------
    ; $0E0FFB
    Message_0032:
    db $08, $59, $1A, $26, $42, $59, $B4, $1D ; I⎵am,⎵[in]d
    db $1E, $1E, $1D, $42, $59, $12, $1A, $AE ; eed,⎵Sa[has]
    db $2B, $1A, $21, $BA, $42, $59, $D8 ; rah[la],⎵[the]
    db $75 ; line 2
    db $2F, $22, $25, $BA, $20, $1E, $59, $1E ; vil[la]ge⎵e
    db $25, $1D, $A1, $8C, $1A, $59, $9D, $1C ; ld[er ][and ]a⎵[des]c
    db $A5, $1D, $A3 ; [en]d[ent]
    db $76 ; line 3
    db $C6, $59, $D8, $59, $D0, $2F, $A0, $E2 ; [of]⎵[the]⎵[se]v[en ][wi]
    db $D0, $59, $BE, $27, $41 ; [se]⎵[me]n.
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $89, $43, $88, $59, $0E, $21, $59 ; …[   ]…[    ]⎵Oh⎵
    db $CE, $1A, $25, $25, $32, $3F ; [re]ally?
    db $73 ; scroll text
    db $6A, $42, $59, $08, $59, $1A, $26, $59 ; [LINK],⎵I⎵am⎵
    db $2C, $2E, $2B, $29, $2B, $B5, $A4, $1A ; surpr[is][ed ]a
    db $59, $E3, $27, $20 ; ⎵[you]ng
    db $73 ; scroll text
    db $BC, $59, $25, $22, $24, $1E, $59, $E3 ; [man]⎵like⎵[you]
    db $59, $B5, $59, $D0, $1A, $2B, $1C, $B0 ; ⎵[is]⎵[se]arc[hi]
    db $27, $20, $59, $A8 ; ng⎵[for]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $2C, $30, $C8, $1D, $59, $C6 ; [the]⎵sw[or]d⎵[of]
    db $59, $A7, $22, $25, $8B, $96, $27, $1E ; ⎵[ev]il['s ][ba]ne
    db $41 ; .
    db $73 ; scroll text
    db $0D, $28, $2D, $59, $B7, $59, $93, $32 ; Not⎵[just]⎵[an]y
    db $C7, $1E, $59, $99, $2E, $D0, $59, $D7 ; [on]e⎵[can ]u[se]⎵[tha]
    db $2D ; t
    db $73 ; scroll text
    db $E0, $1A, $29, $C7, $41, $8A, $0B, $1E ; [we]ap[on].[  ]Le
    db $20, $A5, $1D, $2C, $59, $2C, $1A, $32 ; g[en]ds⎵say
    db $59, $C7, $B9, $D8 ; ⎵[on][ly ][the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E4, $28, $59, $E1, $28, $59, $AE, $59 ; [Her]o⎵[wh]o⎵[has]⎵
    db $30, $C7, $59, $D8, $59, $2D, $21, $CE ; w[on]⎵[the]⎵th[re]
    db $1E ; e
    db $73 ; scroll text
    db $0F, $A5, $1D, $93, $2D, $2C, $59, $99 ; P[en]d[an]ts⎵[can ]
    db $E2, $1E, $25, $1D, $59, $D8, $59, $2C ; [wi]eld⎵[the]⎵s
    db $30, $C8, $1D, $41 ; w[or]d.
    db $73 ; scroll text
    db $43, $89, $43, $89, $43 ; …[   ]…[   ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $CE, $1A, $25 ; Do⎵[you]⎵[re]al
    db $B9, $DF, $27, $2D, $59, $DA, $59, $1F ; [ly ][wa]nt⎵[to]⎵f
    db $B4, $1D, $59, $B6, $3F ; [in]d⎵[it]?
    db $73 ; scroll text
    db $88, $44, $59, $18, $1E, $1A, $21, $3E ; [    ]>⎵Yeah!
    db $73 ; scroll text
    db $88, $89, $0E, $1F, $59, $02, $28, $2E ; [    ][   ]Of⎵Cou
    db $2B, $D0, $3E ; r[se]!
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Good.  As a test, can you
    ; retrieve the Pendant Of
    ; Courage from the East Palace?
    ; If you bring it here, I will tell
    ; you more of the legend and
    ; give you a magical artifact.
    ; Now, go forward to the palace.
    ; --------------------------------------------------------------------------
    ; $0E1104
    Message_0033:
    db $06, $28, $28, $1D, $41, $8A, $00, $2C ; Good.[  ]As
    db $59, $1A, $59, $2D, $1E, $D3, $42, $59 ; ⎵a⎵te[st],⎵
    db $99, $E3 ; [can ][you]
    db $75 ; line 2
    db $CE, $DB, $22, $A7, $1E, $59, $D8, $59 ; [re][tr]i[ev]e⎵[the]⎵
    db $0F, $A5, $1D, $93, $2D, $59, $0E, $1F ; P[en]d[an]t⎵Of
    db $76 ; line 3
    db $02, $28, $2E, $2B, $1A, $20, $1E, $59 ; Courage⎵
    db $A9, $26, $59, $D8, $59, $04, $92, $59 ; [fro]m⎵[the]⎵E[ast]⎵
    db $0F, $1A, $BA, $1C, $1E, $3F ; Pa[la]ce?
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $1B, $2B, $B3 ; If⎵[you]⎵br[ing ]
    db $B6, $59, $AF, $1E, $42, $59, $08, $59 ; [it]⎵[her]e,⎵I⎵
    db $E2, $25, $25, $59, $2D, $1E, $25, $25 ; [wi]ll⎵tell
    db $73 ; scroll text
    db $E3, $59, $26, $C8, $1E, $59, $C6, $59 ; [you]⎵m[or]e⎵[of]⎵
    db $D8, $59, $25, $1E, $20, $A5, $1D, $59 ; [the]⎵leg[en]d⎵
    db $90 ; [and]
    db $73 ; scroll text
    db $AA, $E3, $59, $1A, $59, $BD, $20, $22 ; [give ][you]⎵a⎵[ma]gi
    db $1C, $1A, $25, $59, $1A, $2B, $2D, $22 ; cal⎵arti
    db $1F, $1A, $1C, $2D, $41 ; fact.
    db $79, $2D ; play sfx
    db $7E ; wait for key
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $AC, $59, $A8 ; Now,⎵[go]⎵[for]
    db $DF, $2B, $1D, $59, $DA, $59, $D8, $59 ; [wa]rd⎵[to]⎵[the]⎵
    db $29, $1A, $BA, $1C, $1E, $41 ; pa[la]ce.
    db $7F ; end of message

    ; ==========================================================================
    ; Other relatives of the wise men
    ; are hiding from the evil
    ; wizard's followers.
    ; You should find them.
    ; --------------------------------------------------------------------------
    ; $0E119B
    Message_0034:
    db $0E, $D8, $2B, $59, $CE, $BA, $2D, $22 ; O[the]r⎵[re][la]ti
    db $2F, $1E, $2C, $59, $C6, $59, $D8, $59 ; ves⎵[of]⎵[the]⎵
    db $E2, $D0, $59, $BE, $27 ; [wi][se]⎵[me]n
    db $75 ; line 2
    db $8D, $B0, $9E, $27, $20, $59, $A9, $26 ; [are ][hi][di]ng⎵[fro]m
    db $59, $D8, $59, $A7, $22, $25 ; ⎵[the]⎵[ev]il
    db $76 ; line 3
    db $E2, $33, $1A, $2B, $1D, $8B, $1F, $28 ; [wi]zard['s ]fo
    db $25, $BB, $E0, $2B, $2C, $41 ; l[lo][we]rs.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $D1, $28, $2E, $25, $1D, $59 ; [You]⎵[sh]ould⎵
    db $1F, $B4, $1D, $59, $D8, $26, $41 ; f[in]d⎵[the]m.
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla.
    ; I am communicating to you
    ; across the void through
    ; telepathy…  The place where
    ; you now stand was the Golden
    ; Land, but evil power turned it
    ; into the Dark World.  The
    ; wizard has broken the wise
    ; men's seal and opened a gate
    ; to link the worlds
    ; at Hyrule Castle.  In
    ; order to save this half of the
    ; world, the Light World, you
    ; must win back the Golden
    ; Power.  You must also rescue
    ; the seven maidens who Agahnim
    ; sent to the Dark World.  As
    ; members of the blood-line of
    ; the seven wise men, they have
    ; power that will surely help you.
    ; The maidens are locked in
    ; hidden dungeons full of evil
    ; creatures and dangerous traps.
    ; The Palace of Darkness should
    ; be your first goal in this world!
    ; [LINK], I can rely on only
    ; you.  Please make this old
    ; man's wishes come true.
    ; I beg you!
    ; --------------------------------------------------------------------------
    ; $0E11E0
    Message_0035:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $41 ; [la].
    db $75 ; line 2
    db $08, $59, $1A, $26, $59, $9B, $BF, $27 ; I⎵am⎵[com][mu]n
    db $22, $1C, $94, $B3, $DA, $59, $E3 ; ic[at][ing ][to]⎵[you]
    db $76 ; line 3
    db $1A, $1C, $2B, $28, $2C, $2C, $59, $D8 ; across⎵[the]
    db $59, $2F, $28, $22, $1D, $59, $2D, $21 ; ⎵void⎵th
    db $2B, $28, $2E, $20, $21 ; rough
    db $7E ; wait for key
    db $73 ; scroll text
    db $2D, $1E, $25, $1E, $29, $94, $21, $32 ; telep[at]hy
    db $43, $8A, $E6, $59, $29, $BA, $1C, $1E ; …[  ][The]⎵p[la]ce
    db $59, $E1, $A6, $1E ; ⎵[wh][er]e
    db $73 ; scroll text
    db $E3, $59, $27, $28, $30, $59, $D3, $8C ; [you]⎵now⎵[st][and ]
    db $DF, $2C, $59, $D8, $59, $06, $28, $25 ; [wa]s⎵[the]⎵Gol
    db $1D, $A5 ; d[en]
    db $73 ; scroll text
    db $0B, $90, $42, $59, $1B, $2E, $2D, $59 ; L[and],⎵but⎵
    db $A7, $22, $25, $59, $CB, $A1, $2D, $2E ; [ev]il⎵[pow][er ]tu
    db $2B, $27, $A4, $B6 ; rn[ed ][it]
    db $7E ; wait for key
    db $73 ; scroll text
    db $B4, $DA, $59, $D8, $59, $03, $1A, $2B ; [in][to]⎵[the]⎵Dar
    db $24, $59, $16, $C8, $25, $1D, $41, $8A ; k⎵W[or]ld.[  ]
    db $E6 ; [The]
    db $73 ; scroll text
    db $E2, $33, $1A, $2B, $1D, $59, $AE, $59 ; [wi]zard⎵[has]⎵
    db $1B, $2B, $28, $24, $A0, $D8, $59, $E2 ; brok[en ][the]⎵[wi]
    db $D0 ; [se]
    db $73 ; scroll text
    db $BE, $27, $8B, $D0, $1A, $25, $59, $8C ; [me]n['s ][se]al⎵[and ]
    db $C3, $A4, $1A, $59, $20, $94, $1E ; [open][ed ]a⎵g[at]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $59, $25, $B4, $24, $59, $D8, $59 ; [to]⎵l[in]k⎵[the]⎵
    db $30, $C8, $25, $1D, $2C ; w[or]lds
    db $73 ; scroll text
    db $91, $07, $32, $2B, $2E, $25, $1E, $59 ; [at ]Hyrule⎵
    db $02, $92, $25, $1E, $41, $8A, $08, $27 ; C[ast]le.[  ]In
    db $73 ; scroll text
    db $C8, $1D, $A1, $DA, $59, $2C, $1A, $2F ; [or]d[er ][to]⎵sav
    db $1E, $59, $D9, $2C, $59, $B1, $25, $1F ; e⎵[thi]s⎵[ha]lf
    db $59, $C6, $59, $D8 ; ⎵[of]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $30, $C8, $25, $1D, $42, $59, $D8, $59 ; w[or]ld,⎵[the]⎵
    db $0B, $B2, $16, $C8, $25, $1D, $42, $59 ; L[ight ]W[or]ld,⎵
    db $E3 ; [you]
    db $73 ; scroll text
    db $BF, $D3, $59, $E2, $27, $59, $96, $9C ; [mu][st]⎵[wi]n⎵[ba][ck]
    db $59, $D8, $59, $06, $28, $25, $1D, $A5 ; ⎵[the]⎵Gold[en]
    db $73 ; scroll text
    db $0F, $28, $E0, $2B, $41, $8A, $E8, $59 ; Po[we]r.[  ][You]⎵
    db $BF, $D3, $59, $1A, $25, $D2, $59, $CE ; [mu][st]⎵al[so]⎵[re]
    db $2C, $1C, $2E, $1E ; scue
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $D0, $2F, $A0, $BD, $22, $1D ; [the]⎵[se]v[en ][ma]id
    db $A5, $2C, $59, $E1, $28, $59, $00, $20 ; [en]s⎵[wh]o⎵Ag
    db $1A, $21, $27, $22, $26 ; ahnim
    db $73 ; scroll text
    db $D0, $27, $2D, $59, $DA, $59, $D8, $59 ; [se]nt⎵[to]⎵[the]⎵
    db $03, $1A, $2B, $24, $59, $16, $C8, $25 ; Dark⎵W[or]l
    db $1D, $41, $8A, $00, $2C ; d.[  ]As
    db $73 ; scroll text
    db $BE, $26, $97, $2B, $2C, $59, $C6, $59 ; [me]m[be]rs⎵[of]⎵
    db $D8, $59, $1B, $BB, $28, $1D, $40, $25 ; [the]⎵b[lo]od-l
    db $B4, $1E, $59, $C6 ; [in]e⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $D0, $2F, $A0, $E2, $D0, $59 ; [the]⎵[se]v[en ][wi][se]⎵
    db $BE, $27, $42, $59, $D8, $32, $59, $AD ; [me]n,⎵[the]y⎵[have]
    db $73 ; scroll text
    db $CB, $A1, $D7, $2D, $59, $E2, $25, $25 ; [pow][er ][tha]t⎵[wi]ll
    db $59, $2C, $2E, $CE, $B9, $21, $1E, $25 ; ⎵su[re][ly ]hel
    db $29, $59, $E3, $41 ; p⎵[you].
    db $73 ; scroll text
    db $E6, $59, $BD, $22, $1D, $A5, $2C, $59 ; [The]⎵[ma]id[en]s⎵
    db $8D, $BB, $9C, $A4, $B4 ; [are ][lo][ck][ed ][in]
    db $7E ; wait for key
    db $73 ; scroll text
    db $B0, $1D, $1D, $A0, $1D, $2E, $27, $20 ; [hi]dd[en ]dung
    db $1E, $C7, $2C, $59, $1F, $2E, $25, $25 ; e[on]s⎵full
    db $59, $C6, $59, $A7, $22, $25 ; ⎵[of]⎵[ev]il
    db $73 ; scroll text
    db $1C, $CE, $94, $2E, $CE, $2C, $59, $8C ; c[re][at]u[re]s⎵[and ]
    db $1D, $93, $20, $A6, $28, $2E, $2C, $59 ; d[an]g[er]ous⎵
    db $DB, $1A, $29, $2C, $41 ; [tr]aps.
    db $73 ; scroll text
    db $E6, $59, $0F, $1A, $BA, $1C, $1E, $59 ; [The]⎵Pa[la]ce⎵
    db $C6, $59, $03, $1A, $2B, $24, $27, $1E ; [of]⎵Darkne
    db $2C, $2C, $59, $D1, $28, $2E, $25, $1D ; ss⎵[sh]ould
    db $7E ; wait for key
    db $73 ; scroll text
    db $97, $59, $E3, $2B, $59, $1F, $22, $2B ; [be]⎵[you]r⎵fir
    db $D3, $59, $AC, $1A, $25, $59, $B4, $59 ; [st]⎵[go]al⎵[in]⎵
    db $D9, $2C, $59, $30, $C8, $25, $1D, $3E ; [thi]s⎵w[or]ld!
    db $79, $2D ; play sfx
    db $73 ; scroll text
    db $6A, $42, $59, $08, $59, $99, $CE, $B9 ; [LINK],⎵I⎵[can ][re][ly ]
    db $C7, $59, $C7, $25, $32 ; [on]⎵[on]ly
    db $73 ; scroll text
    db $E3, $41, $8A, $0F, $25, $1E, $1A, $D0 ; [you].[  ]Plea[se]
    db $59, $BD, $24, $1E, $59, $D9, $2C, $59 ; ⎵[ma]ke⎵[thi]s⎵
    db $28, $25, $1D ; old
    db $7E ; wait for key
    db $73 ; scroll text
    db $BC, $8B, $E2, $D1, $1E, $2C, $59, $9B ; [man]['s ][wi][sh]es⎵[com]
    db $1E, $59, $DB, $2E, $1E, $41 ; e⎵[tr]ue.
    db $73 ; scroll text
    db $08, $59, $97, $20, $59, $E3, $3E ; I⎵[be]g⎵[you]!
    db $7F ; end of message

    ; ==========================================================================
    ; But I sense your helplessness…
    ; Before you go any further,
    ; find the Moon Pearl on
    ; Death Mountain.  It will protect
    ; you from the Dark World's
    ; magic so you can keep your
    ; heroic figure.
    ; --------------------------------------------------------------------------
    ; $0E1412
    Message_0036:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $01, $2E, $2D, $59, $08, $59, $D0, $27 ; But⎵I⎵[se]n
    db $D0, $59, $E3, $2B, $59, $21, $1E, $25 ; [se]⎵[you]r⎵hel
    db $CA, $2C, $2C, $27, $1E, $2C, $2C, $43 ; [ple]ssness…
    db $75 ; line 2
    db $01, $1E, $A8, $1E, $59, $E3, $59, $AC ; Be[for]e⎵[you]⎵[go]
    db $59, $93, $32, $59, $1F, $2E, $2B, $D8 ; ⎵[an]y⎵fur[the]
    db $2B, $42 ; r,
    db $76 ; line 3
    db $1F, $B4, $1D, $59, $D8, $59, $0C, $28 ; f[in]d⎵[the]⎵Mo
    db $C7, $59, $0F, $A2, $25, $59, $C7 ; [on]⎵P[ear]l⎵[on]
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $1E, $94, $21, $59, $0C, $28, $2E ; De[at]h⎵Mou
    db $27, $2D, $8F, $41, $8A, $08, $2D, $59 ; nt[ain].[  ]It⎵
    db $E2, $25, $25, $59, $CC, $2D, $1E, $1C ; [wi]ll⎵[pro]tec
    db $2D ; t
    db $73 ; scroll text
    db $E3, $59, $A9, $26, $59, $D8, $59, $03 ; [you]⎵[fro]m⎵[the]⎵D
    db $1A, $2B, $24, $59, $16, $C8, $25, $1D ; ark⎵W[or]ld
    db $51, $2C ; 's
    db $73 ; scroll text
    db $BD, $20, $22, $1C, $59, $D2, $59, $E3 ; [ma]gic⎵[so]⎵[you]
    db $59, $99, $24, $1E, $1E, $29, $59, $E3 ; ⎵[can ]keep⎵[you]
    db $2B ; r
    db $7E ; wait for key
    db $73 ; scroll text
    db $AF, $28, $22, $1C, $59, $1F, $22, $20 ; [her]oic⎵fig
    db $2E, $CE, $41 ; u[re].
    db $7F ; end of message

    ; ==========================================================================
    ; A helpful item is hidden in the
    ; cave on the east side of Lake
    ; Hylia.  Get it!
    ; --------------------------------------------------------------------------
    ; $0E149F
    Message_0037:
    db $00, $59, $21, $1E, $25, $29, $1F, $2E ; A⎵helpfu
    db $25, $59, $B6, $1E, $26, $59, $B5, $59 ; l⎵[it]em⎵[is]⎵
    db $B0, $1D, $1D, $A0, $B4, $59, $D8 ; [hi]dd[en ][in]⎵[the]
    db $75 ; line 2
    db $1C, $1A, $2F, $1E, $59, $C7, $59, $D8 ; cave⎵[on]⎵[the]
    db $59, $1E, $92, $59, $2C, $22, $1D, $1E ; ⎵e[ast]⎵side
    db $59, $C6, $59, $0B, $1A, $24, $1E ; ⎵[of]⎵Lake
    db $76 ; line 3
    db $07, $32, $25, $22, $1A, $41, $8A, $06 ; Hylia.[  ]G
    db $1E, $2D, $59, $B6, $3E ; et⎵[it]!
    db $7F ; end of message

    ; ==========================================================================
    ; Oh!?  You got the Pendant Of
    ; Courage!  Now I will tell you
    ; more of the legend…
    ; Three or four generations ago,
    ; an order of knights protected
    ; the royalty of the Hylia.
    ; These Knights Of Hyrule were
    ; also guardians of the Pendant
    ; Of Courage.
    ; Unfortunately, most of them
    ; were destroyed in the great
    ; war against evil that took
    ; place when the seven wise men
    ; created their seal.  Among the
    ; descendants of the Knights Of
    ; Hyrule a hero must appear.
    ; …I see.  [LINK], I believe you.
    ; You should get the remaining
    ; Pendants.
    ; And carry this with you.
    ; This is a treasure passed down
    ; by the families of the wise
    ; men.  I want you to have it.
    ; --------------------------------------------------------------------------
    ; $0E14DD
    Message_0038:
    db $0E, $21, $3E, $3F, $8A, $E8, $59, $AC ; Oh!?[  ][You]⎵[go]
    db $2D, $59, $D8, $59, $0F, $A5, $1D, $93 ; t⎵[the]⎵P[en]d[an]
    db $2D, $59, $0E, $1F ; t⎵Of
    db $75 ; line 2
    db $02, $28, $2E, $2B, $1A, $20, $1E, $3E ; Courage!
    db $8A, $0D, $28, $30, $59, $08, $59, $E2 ; [  ]Now⎵I⎵[wi]
    db $25, $25, $59, $2D, $1E, $25, $25, $59 ; ll⎵tell⎵
    db $E3 ; [you]
    db $76 ; line 3
    db $26, $C8, $1E, $59, $C6, $59, $D8, $59 ; m[or]e⎵[of]⎵[the]⎵
    db $25, $1E, $20, $A5, $1D, $43 ; leg[en]d…
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $21, $CE, $1E, $59, $C8, $59, $1F ; Th[re]e⎵[or]⎵f
    db $28, $2E, $2B, $59, $20, $A5, $A6, $94 ; our⎵g[en][er][at]
    db $22, $C7, $2C, $59, $1A, $AC, $42 ; i[on]s⎵a[go],
    db $73 ; scroll text
    db $93, $59, $C8, $1D, $A1, $C6, $59, $24 ; [an]⎵[or]d[er ][of]⎵k
    db $27, $22, $20, $21, $2D, $2C, $59, $CC ; nights⎵[pro]
    db $2D, $1E, $1C, $2D, $1E, $1D ; tected
    db $73 ; scroll text
    db $D8, $59, $2B, $28, $32, $1A, $25, $2D ; [the]⎵royalt
    db $32, $59, $C6, $59, $D8, $59, $07, $32 ; y⎵[of]⎵[the]⎵Hy
    db $25, $22, $1A, $41 ; lia.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $D0, $59, $0A, $27, $22, $20, $21 ; [The][se]⎵Knigh
    db $2D, $2C, $59, $0E, $1F, $59, $07, $32 ; ts⎵Of⎵Hy
    db $2B, $2E, $25, $1E, $59, $E0, $CE ; rule⎵[we][re]
    db $73 ; scroll text
    db $1A, $25, $D2, $59, $20, $2E, $1A, $2B ; al[so]⎵guar
    db $9E, $93, $2C, $59, $C6, $59, $D8, $59 ; [di][an]s⎵[of]⎵[the]⎵
    db $0F, $A5, $1D, $93, $2D ; P[en]d[an]t
    db $73 ; scroll text
    db $0E, $1F, $59, $02, $28, $2E, $2B, $1A ; Of⎵Coura
    db $20, $1E, $41 ; ge.
    db $7E ; wait for key
    db $73 ; scroll text
    db $14, $27, $A8, $2D, $2E, $27, $94, $1E ; Un[for]tun[at]e
    db $25, $32, $42, $59, $26, $28, $D3, $59 ; ly,⎵mo[st]⎵
    db $C6, $59, $D8, $26 ; [of]⎵[the]m
    db $73 ; scroll text
    db $E0, $CD, $9D, $DB, $28, $32, $A4, $B4 ; [we][re ][des][tr]oy[ed ][in]
    db $59, $D8, $59, $20, $CE, $94 ; ⎵[the]⎵g[re][at]
    db $73 ; scroll text
    db $DF, $2B, $59, $1A, $20, $8F, $D3, $59 ; [wa]r⎵ag[ain][st]⎵
    db $A7, $22, $25, $59, $D7, $2D, $59, $DA ; [ev]il⎵[tha]t⎵[to]
    db $28, $24 ; ok
    db $7E ; wait for key
    db $73 ; scroll text
    db $29, $BA, $1C, $1E, $59, $E1, $A0, $D8 ; p[la]ce⎵[wh][en ][the]
    db $59, $D0, $2F, $A0, $E2, $D0, $59, $BE ; ⎵[se]v[en ][wi][se]⎵[me]
    db $27 ; n
    db $73 ; scroll text
    db $1C, $CE, $94, $A4, $D8, $22, $2B, $59 ; c[re][at][ed ][the]ir⎵
    db $D0, $1A, $25, $41, $8A, $00, $26, $C7 ; [se]al.[  ]Am[on]
    db $20, $59, $D8 ; g⎵[the]
    db $73 ; scroll text
    db $9D, $1C, $A5, $1D, $93, $2D, $2C, $59 ; [des]c[en]d[an]ts⎵
    db $C6, $59, $D8, $59, $0A, $27, $22, $20 ; [of]⎵[the]⎵Knig
    db $21, $2D, $2C, $59, $0E, $1F ; hts⎵Of
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $32, $2B, $2E, $25, $1E, $59, $1A ; Hyrule⎵a
    db $59, $AF, $28, $59, $BF, $D3, $59, $1A ; ⎵[her]o⎵[mu][st]⎵a
    db $29, $29, $A2, $41 ; pp[ear].
    db $73 ; scroll text
    db $43, $08, $59, $D0, $1E, $41, $8A, $6A ; …I⎵[se]e.[  ][LINK]
    db $42, $59, $08, $59, $97, $25, $22, $A7 ; ,⎵I⎵[be]li[ev]
    db $1E, $59, $E3, $41 ; e⎵[you].
    db $73 ; scroll text
    db $E8, $59, $D1, $28, $2E, $25, $1D, $59 ; [You]⎵[sh]ould⎵
    db $AB, $59, $D8, $59, $CE, $BD, $B4, $B4 ; [get]⎵[the]⎵[re][ma][in][in]
    db $20 ; g
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $A5, $1D, $93, $2D, $2C, $41 ; P[en]d[an]ts.
    db $73 ; scroll text
    db $00, $27, $1D, $59, $1C, $1A, $2B, $2B ; And⎵carr
    db $32, $59, $D9, $2C, $59, $DE, $59, $E3 ; y⎵[thi]s⎵[with]⎵[you]
    db $41 ; .
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $1A, $59, $DB ; [Thi]s⎵[is]⎵a⎵[tr]
    db $1E, $1A, $2C, $2E, $CD, $29, $1A, $2C ; easu[re ]pas
    db $D0, $1D, $59, $9F, $30, $27 ; [se]d⎵[do]wn
    db $7E ; wait for key
    db $73 ; scroll text
    db $1B, $32, $59, $D8, $59, $1F, $1A, $26 ; by⎵[the]⎵fam
    db $22, $25, $22, $1E, $2C, $59, $C6, $59 ; ilies⎵[of]⎵
    db $D8, $59, $E2, $D0 ; [the]⎵[wi][se]
    db $73 ; scroll text
    db $BE, $27, $41, $8A, $08, $59, $DF, $27 ; [me]n.[  ]I⎵[wa]n
    db $2D, $59, $E3, $59, $DA, $59, $AD, $59 ; t⎵[you]⎵[to]⎵[have]⎵
    db $B6, $41 ; [it].
    db $7F ; end of message

    ; ==========================================================================
    ; You are correct, young man!
    ; I am Sahasrahla, the village
    ; elder and a descendent of the
    ; seven wise men.
    ; … … … What?
    ; [LINK], I'm surprised a young
    ; man like you is looking for the
    ; sword of evil's bane.  Not just
    ; anyone can use that sword.
    ; According to the tales handed
    ; down by the Hylia, only the
    ; Hero who has destroyed three
    ; great evils and won the three
    ; Pendants can wield the sword…
    ; … … …
    ; I see you have acquired the
    ; Pendant of Courage.  I will tell
    ; you about the legend behind it.
    ; Three or four generations ago,
    ; an order of knights protected
    ; the royalty of the Hylia.
    ; These Knights Of Hyrule were
    ; also guardians of the Pendant
    ; Of Courage.
    ; Unfortunately, most of them
    ; were destroyed in the great
    ; war against evil that took
    ; place when the seven wise men
    ; created their seal.  Among the
    ; descendants of the Knights Of
    ; Hyrule a hero must appear.
    ; …I see.  [LINK], I believe you.
    ; You should get the remaining
    ; Pendants.
    ; And carry this with you.
    ; This is a treasure passed down
    ; by the families of the wise
    ; men.  I want you to have it.
    ; --------------------------------------------------------------------------
    ; $0E16A9
    Message_0039:
    db $E8, $59, $8D, $1C, $C8, $CE, $1C, $2D ; [You]⎵[are ]c[or][re]ct
    db $42, $59, $E3, $27, $20, $59, $BC, $3E ; ,⎵[you]ng⎵[man]!
    db $75 ; line 2
    db $08, $59, $1A, $26, $59, $12, $1A, $AE ; I⎵am⎵Sa[has]
    db $2B, $1A, $21, $BA, $42, $59, $D8, $59 ; rah[la],⎵[the]⎵
    db $2F, $22, $25, $BA, $20, $1E ; vil[la]ge
    db $76 ; line 3
    db $1E, $25, $1D, $A1, $8C, $1A, $59, $9D ; eld[er ][and ]a⎵[des]
    db $1C, $A5, $1D, $A3, $59, $C6, $59, $D8 ; c[en]d[ent]⎵[of]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $41 ; .
    db $73 ; scroll text
    db $43, $59, $43, $59, $43, $59, $16, $B1 ; …⎵…⎵…⎵W[ha]
    db $2D, $3F ; t?
    db $73 ; scroll text
    db $6A, $42, $59, $08, $51, $26, $59, $2C ; [LINK],⎵I'm⎵s
    db $2E, $2B, $29, $2B, $B5, $A4, $1A, $59 ; urpr[is][ed ]a⎵
    db $E3, $27, $20 ; [you]ng
    db $7E ; wait for key
    db $73 ; scroll text
    db $BC, $59, $25, $22, $24, $1E, $59, $E3 ; [man]⎵like⎵[you]
    db $59, $B5, $59, $BB, $28, $24, $B3, $A8 ; ⎵[is]⎵[lo]ok[ing ][for]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $2C, $30, $C8, $1D, $59, $C6, $59, $A7 ; sw[or]d⎵[of]⎵[ev]
    db $22, $25, $8B, $96, $27, $1E, $41, $8A ; il['s ][ba]ne.[  ]
    db $0D, $28, $2D, $59, $B7 ; Not⎵[just]
    db $73 ; scroll text
    db $93, $32, $C7, $1E, $59, $99, $2E, $D0 ; [an]y[on]e⎵[can ]u[se]
    db $59, $D7, $2D, $59, $2C, $30, $C8, $1D ; ⎵[tha]t⎵sw[or]d
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $1C, $1C, $C8, $9E, $27, $20, $59 ; Acc[or][di]ng⎵
    db $DA, $59, $D8, $59, $2D, $1A, $25, $1E ; [to]⎵[the]⎵tale
    db $2C, $59, $B1, $27, $1D, $1E, $1D ; s⎵[ha]nded
    db $73 ; scroll text
    db $9F, $30, $27, $59, $1B, $32, $59, $D8 ; [do]wn⎵by⎵[the]
    db $59, $07, $32, $25, $22, $1A, $42, $59 ; ⎵Hylia,⎵
    db $C7, $B9, $D8 ; [on][ly ][the]
    db $73 ; scroll text
    db $E4, $28, $59, $E1, $28, $59, $AE, $59 ; [Her]o⎵[wh]o⎵[has]⎵
    db $9D, $DB, $28, $32, $A4, $2D, $21, $CE ; [des][tr]oy[ed ]th[re]
    db $1E ; e
    db $7E ; wait for key
    db $73 ; scroll text
    db $20, $CE, $91, $A7, $22, $25, $2C, $59 ; g[re][at ][ev]ils⎵
    db $8C, $30, $C7, $59, $D8, $59, $2D, $21 ; [and ]w[on]⎵[the]⎵th
    db $CE, $1E ; [re]e
    db $73 ; scroll text
    db $0F, $A5, $1D, $93, $2D, $2C, $59, $99 ; P[en]d[an]ts⎵[can ]
    db $E2, $1E, $25, $1D, $59, $D8, $59, $2C ; [wi]eld⎵[the]⎵s
    db $30, $C8, $1D, $43 ; w[or]d…
    db $73 ; scroll text
    db $43, $59, $43, $59, $43 ; …⎵…⎵…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $D0, $1E, $59, $E3, $59, $AD ; I⎵[se]e⎵[you]⎵[have]
    db $59, $1A, $1C, $2A, $2E, $22, $CE, $1D ; ⎵acqui[re]d
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $0F, $A5, $1D, $93, $2D, $59, $C6, $59 ; P[en]d[an]t⎵[of]⎵
    db $02, $28, $2E, $2B, $1A, $20, $1E, $41 ; Courage.
    db $8A, $08, $59, $E2, $25, $25, $59, $2D ; [  ]I⎵[wi]ll⎵t
    db $1E, $25, $25 ; ell
    db $73 ; scroll text
    db $E3, $59, $1A, $98, $2E, $2D, $59, $D8 ; [you]⎵a[bo]ut⎵[the]
    db $59, $25, $1E, $20, $A5, $1D, $59, $97 ; ⎵leg[en]d⎵[be]
    db $B0, $27, $1D, $59, $B6, $41 ; [hi]nd⎵[it].
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $21, $CE, $1E, $59, $C8, $59, $1F ; Th[re]e⎵[or]⎵f
    db $28, $2E, $2B, $59, $20, $A5, $A6, $94 ; our⎵g[en][er][at]
    db $22, $C7, $2C, $59, $1A, $AC, $42 ; i[on]s⎵a[go],
    db $73 ; scroll text
    db $93, $59, $C8, $1D, $A1, $C6, $59, $24 ; [an]⎵[or]d[er ][of]⎵k
    db $27, $22, $20, $21, $2D, $2C, $59, $CC ; nights⎵[pro]
    db $2D, $1E, $1C, $2D, $1E, $1D ; tected
    db $73 ; scroll text
    db $D8, $59, $2B, $28, $32, $1A, $25, $2D ; [the]⎵royalt
    db $32, $59, $C6, $59, $D8, $59, $07, $32 ; y⎵[of]⎵[the]⎵Hy
    db $25, $22, $1A, $41 ; lia.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $D0, $59, $0A, $27, $22, $20, $21 ; [The][se]⎵Knigh
    db $2D, $2C, $59, $0E, $1F, $59, $07, $32 ; ts⎵Of⎵Hy
    db $2B, $2E, $25, $1E, $59, $E0, $CE ; rule⎵[we][re]
    db $73 ; scroll text
    db $1A, $25, $D2, $59, $20, $2E, $1A, $2B ; al[so]⎵guar
    db $9E, $93, $2C, $59, $C6, $59, $D8, $59 ; [di][an]s⎵[of]⎵[the]⎵
    db $0F, $A5, $1D, $93, $2D ; P[en]d[an]t
    db $73 ; scroll text
    db $0E, $1F, $59, $02, $28, $2E, $2B, $1A ; Of⎵Coura
    db $20, $1E, $41 ; ge.
    db $7E ; wait for key
    db $73 ; scroll text
    db $14, $27, $A8, $2D, $2E, $27, $94, $1E ; Un[for]tun[at]e
    db $25, $32, $42, $59, $26, $28, $D3, $59 ; ly,⎵mo[st]⎵
    db $C6, $59, $D8, $26 ; [of]⎵[the]m
    db $73 ; scroll text
    db $E0, $CD, $9D, $DB, $28, $32, $A4, $B4 ; [we][re ][des][tr]oy[ed ][in]
    db $59, $D8, $59, $20, $CE, $94 ; ⎵[the]⎵g[re][at]
    db $73 ; scroll text
    db $DF, $2B, $59, $1A, $20, $8F, $D3, $59 ; [wa]r⎵ag[ain][st]⎵
    db $A7, $22, $25, $59, $D7, $2D, $59, $DA ; [ev]il⎵[tha]t⎵[to]
    db $28, $24 ; ok
    db $7E ; wait for key
    db $73 ; scroll text
    db $29, $BA, $1C, $1E, $59, $E1, $A0, $D8 ; p[la]ce⎵[wh][en ][the]
    db $59, $D0, $2F, $A0, $E2, $D0, $59, $BE ; ⎵[se]v[en ][wi][se]⎵[me]
    db $27 ; n
    db $73 ; scroll text
    db $1C, $CE, $94, $A4, $D8, $22, $2B, $59 ; c[re][at][ed ][the]ir⎵
    db $D0, $1A, $25, $41, $8A, $00, $26, $C7 ; [se]al.[  ]Am[on]
    db $20, $59, $D8 ; g⎵[the]
    db $73 ; scroll text
    db $9D, $1C, $A5, $1D, $93, $2D, $2C, $59 ; [des]c[en]d[an]ts⎵
    db $C6, $59, $D8, $59, $0A, $27, $22, $20 ; [of]⎵[the]⎵Knig
    db $21, $2D, $2C, $59, $0E, $1F ; hts⎵Of
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $32, $2B, $2E, $25, $1E, $59, $1A ; Hyrule⎵a
    db $59, $AF, $28, $59, $BF, $D3, $59, $1A ; ⎵[her]o⎵[mu][st]⎵a
    db $29, $29, $A2, $41 ; pp[ear].
    db $73 ; scroll text
    db $43, $08, $59, $D0, $1E, $41, $8A, $6A ; …I⎵[se]e.[  ][LINK]
    db $42, $59, $08, $59, $97, $25, $22, $A7 ; ,⎵I⎵[be]li[ev]
    db $1E, $59, $E3, $41 ; e⎵[you].
    db $73 ; scroll text
    db $E8, $59, $D1, $28, $2E, $25, $1D, $59 ; [You]⎵[sh]ould⎵
    db $AB, $59, $D8, $59, $CE, $BD, $B4, $B4 ; [get]⎵[the]⎵[re][ma][in][in]
    db $20 ; g
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $A5, $1D, $93, $2D, $2C, $41 ; P[en]d[an]ts.
    db $73 ; scroll text
    db $00, $27, $1D, $59, $1C, $1A, $2B, $2B ; And⎵carr
    db $32, $59, $D9, $2C, $59, $DE, $59, $E3 ; y⎵[thi]s⎵[with]⎵[you]
    db $41 ; .
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $1A, $59, $DB ; [Thi]s⎵[is]⎵a⎵[tr]
    db $1E, $1A, $2C, $2E, $CD, $29, $1A, $2C ; easu[re ]pas
    db $D0, $1D, $59, $9F, $30, $27 ; [se]d⎵[do]wn
    db $7E ; wait for key
    db $73 ; scroll text
    db $1B, $32, $59, $D8, $59, $1F, $1A, $26 ; by⎵[the]⎵fam
    db $22, $25, $22, $1E, $2C, $59, $C6, $59 ; ilies⎵[of]⎵
    db $D8, $59, $E2, $D0 ; [the]⎵[wi][se]
    db $73 ; scroll text
    db $BE, $27, $41, $8A, $08, $59, $DF, $27 ; [me]n.[  ]I⎵[wa]n
    db $2D, $59, $E3, $59, $DA, $59, $AD, $59 ; t⎵[you]⎵[to]⎵[have]⎵
    db $B6, $41 ; [it].
    db $7F ; end of message

    ; ==========================================================================
    ; I will give 100 Rupees to the
    ; man who finds the descendants
    ; of the wise men.   THE KING
    ; --------------------------------------------------------------------------
    ; $0E198B
    Message_003A:
    db $08, $59, $E2, $25, $25, $59, $AA, $35 ; I⎵[wi]ll⎵[give ]1
    db $34, $34, $59, $11, $DC, $1E, $1E, $2C ; 00⎵R[up]ees
    db $59, $DA, $59, $D8 ; ⎵[to]⎵[the]
    db $75 ; line 2
    db $BC, $59, $E1, $28, $59, $1F, $B4, $1D ; [man]⎵[wh]o⎵f[in]d
    db $2C, $59, $D8, $59, $9D, $1C, $A5, $1D ; s⎵[the]⎵[des]c[en]d
    db $93, $2D, $2C ; [an]ts
    db $76 ; line 3
    db $C6, $59, $D8, $59, $E2, $D0, $59, $BE ; [of]⎵[the]⎵[wi][se]⎵[me]
    db $27, $41, $89, $13, $07, $04, $59, $0A ; n.[   ]THE⎵K
    db $08, $0D, $06 ; ING
    db $7F ; end of message

    ; ==========================================================================
    ;   😬  WANTED!  This is the
    ; criminal who kidnapped Zelda.
    ; Call a soldier if you see him!
    ; --------------------------------------------------------------------------
    ; $0E19C8
    Message_003B:
    db $8A, $4A, $4B, $8A, $16, $00, $0D, $13 ; [  ]😬[  ]WANT
    db $04, $03, $3E, $8A, $E7, $2C, $59, $B5 ; ED![  ][Thi]s⎵[is]
    db $59, $D8 ; ⎵[the]
    db $75 ; line 2
    db $1C, $2B, $22, $26, $B4, $1A, $25, $59 ; crim[in]al⎵
    db $E1, $28, $59, $24, $22, $1D, $27, $1A ; [wh]o⎵kidna
    db $29, $29, $A4, $19, $1E, $25, $1D, $1A ; pp[ed ]Zelda
    db $41 ; .
    db $76 ; line 3
    db $02, $8E, $1A, $59, $D2, $25, $9E, $A1 ; C[all ]a⎵[so]l[di][er ]
    db $22, $1F, $59, $E3, $59, $D0, $1E, $59 ; if⎵[you]⎵[se]e⎵
    db $B0, $26, $3E ; [hi]m!
    db $7F ; end of message

    ; ==========================================================================
    ;      DANGER!
    ; Do not enter Death Mountain
    ; without the King's permission!
    ; --------------------------------------------------------------------------
    ; $0E1A09
    Message_003C:
    db $88, $59, $03, $00, $0D, $06, $04, $11 ; [    ]⎵DANGER
    db $3E ; !
    db $75 ; line 2
    db $03, $28, $59, $C2, $59, $A3, $A1, $03 ; Do⎵[not]⎵[ent][er ]D
    db $1E, $94, $21, $59, $0C, $28, $2E, $27 ; e[at]h⎵Moun
    db $2D, $8F ; t[ain]
    db $76 ; line 3
    db $DE, $C5, $D8, $59, $0A, $B4, $20, $8B ; [with][out ][the]⎵K[in]g['s ]
    db $C9, $26, $B5, $2C, $22, $C7, $3E ; [per]m[is]si[on]!
    db $7F ; end of message

    ; ==========================================================================
    ; This way to the
    ;      Lost Woods
    ; --------------------------------------------------------------------------
    ; $0E1A36
    Message_003D:
    db $E7, $2C, $59, $DF, $32, $59, $DA, $59 ; [Thi]s⎵[wa]y⎵[to]⎵
    db $D8 ; [the]
    db $75 ; line 2
    db $88, $59, $0B, $28, $D3, $59, $16, $28 ; [    ]⎵Lo[st]⎵Wo
    db $28, $1D, $2C ; ods
    db $7F ; end of message

    ; ==========================================================================
    ;            DANGER!
    ; Beware of deep water and Zora!
    ; --------------------------------------------------------------------------
    ; $0E1A4C
    Message_003E:
    db $88, $88, $89, $03, $00, $0D, $06, $04 ; [    ][    ][   ]DANGE
    db $11, $3E ; R!
    db $75 ; line 2
    db $01, $1E, $DF, $CD, $C6, $59, $1D, $1E ; Be[wa][re ][of]⎵de
    db $1E, $29, $59, $DF, $D4, $8C, $19, $C8 ; ep⎵[wa][ter ][and ]Z[or]
    db $1A, $3E ; a!
    db $7F ; end of message

    ; ==========================================================================
    ; Welcome to the Magic Shop.
    ; The Waterfall Of Wishing is
    ; just ahead.  
    ; --------------------------------------------------------------------------
    ; $0E1A6A
    Message_003F:
    db $16, $1E, $25, $9B, $1E, $59, $DA, $59 ; Wel[com]e⎵[to]⎵
    db $D8, $59, $0C, $1A, $20, $22, $1C, $59 ; [the]⎵Magic⎵
    db $12, $21, $28, $29, $41 ; Shop.
    db $75 ; line 2
    db $E6, $59, $16, $94, $A6, $1F, $8E, $0E ; [The]⎵W[at][er]f[all ]O
    db $1F, $59, $16, $B5, $B0, $27, $20, $59 ; f⎵W[is][hi]ng⎵
    db $B5 ; [is]
    db $76 ; line 3
    db $B7, $59, $1A, $21, $1E, $1A, $1D, $41 ; [just]⎵ahead.
    db $8A ; [  ]
    db $7F ; end of message

    ; ==========================================================================
    ; This cave leads to the path
    ; back to Kakariko Village.
    ; --------------------------------------------------------------------------
    ; $0E1A9C
    Message_0040:
    db $E7, $2C, $59, $1C, $1A, $2F, $1E, $59 ; [Thi]s⎵cave⎵
    db $25, $1E, $1A, $1D, $2C, $59, $DA, $59 ; leads⎵[to]⎵
    db $D8, $59, $29, $94, $21 ; [the]⎵p[at]h
    db $75 ; line 2
    db $96, $9C, $59, $DA, $59, $0A, $1A, $24 ; [ba][ck]⎵[to]⎵Kak
    db $1A, $2B, $22, $24, $28, $59, $15, $22 ; ariko⎵Vi
    db $25, $BA, $20, $1E, $41 ; l[la]ge.
    db $7F ; end of message

    ; ==========================================================================
    ; This way ↓
    ;          Lake Hylia
    ;          Shop
    ; --------------------------------------------------------------------------
    ; $0E1AC8
    Message_0041:
    db $E7, $2C, $59, $DF, $32, $59, $4E ; [Thi]s⎵[wa]y⎵↓
    db $75 ; line 2
    db $88, $88, $59, $0B, $1A, $24, $1E, $59 ; [    ][    ]⎵Lake⎵
    db $07, $32, $25, $22, $1A ; Hylia
    db $76 ; line 3
    db $88, $88, $59, $12, $21, $28, $29 ; [    ][    ]⎵Shop
    db $7F ; end of message

    ; ==========================================================================
    ; This way ←
    ;          Kakariko Village
    ; --------------------------------------------------------------------------
    ; $0E1AE6
    Message_0042:
    db $E7, $2C, $59, $DF, $32, $59, $4F ; [Thi]s⎵[wa]y⎵←
    db $75 ; line 2
    db $88, $88, $59, $0A, $1A, $24, $1A, $2B ; [    ][    ]⎵Kakar
    db $22, $24, $28, $59, $15, $22, $25, $BA ; iko⎵Vil[la]
    db $20, $1E ; ge
    db $7F ; end of message

    ; ==========================================================================
    ; This way ←
    ;          Desert Of Mystery
    ; --------------------------------------------------------------------------
    ; $0E1B01
    Message_0043:
    db $E7, $2C, $59, $DF, $32, $59, $4F ; [Thi]s⎵[wa]y⎵←
    db $75 ; line 2
    db $88, $88, $59, $03, $1E, $D0, $2B, $2D ; [    ][    ]⎵De[se]rt
    db $59, $0E, $1F, $59, $0C, $32, $D3, $A6 ; ⎵Of⎵My[st][er]
    db $32 ; y
    db $7F ; end of message

    ; ==========================================================================
    ; This way ↑ →
    ;          Magic Shop
    ;          Waterfall Of Wishing
    ; --------------------------------------------------------------------------
    ; $0E1B1B
    Message_0044:
    db $E7, $2C, $59, $DF, $32, $59, $4D, $59 ; [Thi]s⎵[wa]y⎵↑⎵
    db $50 ; →
    db $75 ; line 2
    db $88, $88, $59, $0C, $1A, $20, $22, $1C ; [    ][    ]⎵Magic
    db $59, $12, $21, $28, $29 ; ⎵Shop
    db $76 ; line 3
    db $88, $88, $59, $16, $94, $A6, $1F, $8E ; [    ][    ]⎵W[at][er]f[all ]
    db $0E, $1F, $59, $16, $B5, $B0, $27, $20 ; Of⎵W[is][hi]ng
    db $7F ; end of message

    ; ==========================================================================
    ; This way → Eastern Palace
    ; This way ← Hyrule Castle
    ; --------------------------------------------------------------------------
    ; $0E1B44
    Message_0045:
    db $E7, $2C, $59, $DF, $32, $59, $50, $59 ; [Thi]s⎵[wa]y⎵→⎵
    db $04, $92, $A6, $27, $59, $0F, $1A, $BA ; E[ast][er]n⎵Pa[la]
    db $1C, $1E ; ce
    db $76 ; line 3
    db $E7, $2C, $59, $DF, $32, $59, $4F, $59 ; [Thi]s⎵[wa]y⎵←⎵
    db $07, $32, $2B, $2E, $25, $1E, $59, $02 ; Hyrule⎵C
    db $92, $25, $1E ; [ast]le
    db $7F ; end of message

    ; ==========================================================================
    ;         Lake Hylia
    ; --------------------------------------------------------------------------
    ; $0E1B6B
    Message_0046:
    db $75 ; line 2
    db $88, $88, $0B, $1A, $24, $1E, $59, $07 ; [    ][    ]Lake⎵H
    db $32, $25, $22, $1A ; ylia
    db $7F ; end of message

    ; ==========================================================================
    ; Pay no attention to the
    ; average middle-aged man
    ; standing by this sign.
    ; Leave him alone!
    ; --------------------------------------------------------------------------
    ; $0E1B79
    Message_0047:
    db $0F, $1A, $32, $59, $27, $28, $59, $94 ; Pay⎵no⎵[at]
    db $2D, $A3, $22, $C7, $59, $DA, $59, $D8 ; t[ent]i[on]⎵[to]⎵[the]
    db $75 ; line 2
    db $1A, $DD, $1A, $20, $1E, $59, $26, $22 ; a[ver]age⎵mi
    db $1D, $1D, $25, $1E, $40, $1A, $20, $A4 ; ddle-ag[ed ]
    db $BC ; [man]
    db $76 ; line 3
    db $D3, $90, $B3, $1B, $32, $59, $D9, $2C ; [st][and][ing ]by⎵[thi]s
    db $59, $2C, $22, $20, $27, $41 ; ⎵sign.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0B, $1E, $1A, $2F, $1E, $59, $B0, $26 ; Leave⎵[hi]m
    db $59, $1A, $BB, $27, $1E, $3E ; ⎵a[lo]ne!
    db $7F ; end of message

    ; ==========================================================================
    ; The House Of Lumberjacks
    ; A. Bumpkin and B. Bumpkin
    ; --------------------------------------------------------------------------
    ; $0E1BBB
    Message_0048:
    db $75 ; line 2
    db $E6, $59, $07, $28, $2E, $D0, $59, $0E ; [The]⎵Hou[se]⎵O
    db $1F, $59, $0B, $2E, $26, $97, $2B, $23 ; f⎵Lum[be]rj
    db $1A, $9C, $2C ; a[ck]s
    db $76 ; line 3
    db $00, $41, $59, $01, $2E, $26, $29, $24 ; A.⎵Bumpk
    db $B4, $59, $8C, $01, $41, $59, $01, $2E ; [in]⎵[and ]B.⎵Bu
    db $26, $29, $24, $B4 ; mpk[in]
    db $7F ; end of message

    ; ==========================================================================
    ; This way ↓
    ;        Kakariko Village
    ; --------------------------------------------------------------------------
    ; $0E1BE5
    Message_0049:
    db $E7, $2C, $59, $DF, $32, $59, $4E ; [Thi]s⎵[wa]y⎵↓
    db $75 ; line 2
    db $88, $89, $0A, $1A, $24, $1A, $2B, $22 ; [    ][   ]Kakari
    db $24, $28, $59, $15, $22, $25, $BA, $20 ; ko⎵Vil[la]g
    db $1E ; e
    db $7F ; end of message

    ; ==========================================================================
    ; Double, double toil and trouble,
    ; fire burn and cauldron bubble…
    ; Making mushroom brew, I am…
    ; --------------------------------------------------------------------------
    ; $0E1BFF
    Message_004A:
    db $03, $28, $2E, $95, $42, $59, $9F, $2E ; Dou[ble],⎵[do]u
    db $95, $59, $DA, $22, $25, $59, $8C, $DB ; [ble]⎵[to]il⎵[and ][tr]
    db $28, $2E, $95, $42 ; ou[ble],
    db $75 ; line 2
    db $1F, $22, $CD, $1B, $2E, $2B, $27, $59 ; fi[re ]burn⎵
    db $8C, $1C, $1A, $2E, $25, $1D, $2B, $C7 ; [and ]cauldr[on]
    db $59, $1B, $2E, $1B, $95, $43 ; ⎵bub[ble]…
    db $76 ; line 3
    db $0C, $1A, $24, $B3, $BF, $D1, $2B, $28 ; Mak[ing ][mu][sh]ro
    db $28, $26, $59, $1B, $CE, $30, $42, $59 ; om⎵b[re]w,⎵
    db $08, $59, $1A, $26, $43 ; I⎵am…
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh…  Thank you, young
    ; man…  Come back to the shop
    ; later for something good…
    ; Heh heh…
    ; --------------------------------------------------------------------------
    ; $0E1C41
    Message_004B:
    db $07, $1E, $21, $59, $21, $1E, $21, $43 ; Heh⎵heh…
    db $8A, $E5, $27, $24, $59, $E3, $42, $59 ; [  ][Tha]nk⎵[you],⎵
    db $E3, $27, $20 ; [you]ng
    db $75 ; line 2
    db $BC, $43, $8A, $02, $28, $BE, $59, $96 ; [man]…[  ]Co[me]⎵[ba]
    db $9C, $59, $DA, $59, $D8, $59, $D1, $28 ; [ck]⎵[to]⎵[the]⎵[sh]o
    db $29 ; p
    db $76 ; line 3
    db $BA, $D4, $A8, $59, $CF, $D5, $20, $59 ; [la][ter ][for]⎵[some][thin]g⎵
    db $AC, $28, $1D, $43 ; [go]od…
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $21, $59, $21, $1E, $21, $43 ; Heh⎵heh…
    db $7F ; end of message

    ; ==========================================================================
    ; Mmmmm…  The smell of rotten
    ; fruit…  If you give me that
    ; Mushroom, I can finish my brew.
    ; Heh heh…
    ; --------------------------------------------------------------------------
    ; $0E1C7E
    Message_004C:
    db $0C, $26, $26, $26, $26, $43, $8A, $E6 ; Mmmmm…[  ][The]
    db $59, $2C, $BE, $25, $25, $59, $C6, $59 ; ⎵s[me]ll⎵[of]⎵
    db $2B, $28, $2D, $2D, $A5 ; rott[en]
    db $75 ; line 2
    db $1F, $2B, $2E, $B6, $43, $8A, $08, $1F ; fru[it]…[  ]If
    db $59, $E3, $59, $AA, $BE, $59, $D7, $2D ; ⎵[you]⎵[give ][me]⎵[tha]t
    db $76 ; line 3
    db $0C, $2E, $D1, $2B, $28, $28, $26, $42 ; Mu[sh]room,
    db $59, $08, $59, $99, $1F, $B4, $B5, $21 ; ⎵I⎵[can ]f[in][is]h
    db $59, $26, $32, $59, $1B, $CE, $30, $41 ; ⎵my⎵b[re]w.
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $21, $59, $21, $1E, $21, $43 ; Heh⎵heh…
    db $7F ; end of message

    ; ==========================================================================
    ; If you want to buy the potion,
    ; you should bring a bottle to
    ; put it in…  He he he!
    ; --------------------------------------------------------------------------
    ; $0E1CC8
    Message_004D:
    db $08, $1F, $59, $E3, $59, $DF, $27, $2D ; If⎵[you]⎵[wa]nt
    db $59, $DA, $59, $1B, $2E, $32, $59, $D8 ; ⎵[to]⎵buy⎵[the]
    db $59, $29, $28, $2D, $22, $C7, $42 ; ⎵poti[on],
    db $75 ; line 2
    db $E3, $59, $D1, $28, $2E, $25, $1D, $59 ; [you]⎵[sh]ould⎵
    db $1B, $2B, $B3, $1A, $59, $98, $2D, $2D ; br[ing ]a⎵[bo]tt
    db $25, $1E, $59, $DA ; le⎵[to]
    db $76 ; line 3
    db $29, $2E, $2D, $59, $B6, $59, $B4, $43 ; put⎵[it]⎵[in]…
    db $8A, $07, $1E, $59, $21, $1E, $59, $21 ; [  ]He⎵he⎵h
    db $1E, $3E ; e!
    db $7F ; end of message

    ; ==========================================================================
    ; Red is the medicine of life.
    ; Green is the medicine of magic.
    ; Blue renews both life and
    ; magic.
    ; Here, taste a sample of the
    ; Red Potion…  He he!
    ; --------------------------------------------------------------------------
    ; $0E1D08
    Message_004E:
    db $11, $A4, $B5, $59, $D8, $59, $BE, $9E ; R[ed ][is]⎵[the]⎵[me][di]
    db $1C, $B4, $1E, $59, $C6, $59, $25, $22 ; c[in]e⎵[of]⎵li
    db $1F, $1E, $41 ; fe.
    db $75 ; line 2
    db $06, $CE, $A0, $B5, $59, $D8, $59, $BE ; G[re][en ][is]⎵[the]⎵[me]
    db $9E, $1C, $B4, $1E, $59, $C6, $59, $BD ; [di]c[in]e⎵[of]⎵[ma]
    db $20, $22, $1C, $41 ; gic.
    db $76 ; line 3
    db $01, $25, $2E, $1E, $59, $CE, $27, $1E ; Blue⎵[re]ne
    db $30, $2C, $59, $98, $2D, $21, $59, $25 ; ws⎵[bo]th⎵l
    db $22, $1F, $1E, $59, $90 ; ife⎵[and]
    db $7E ; wait for key
    db $73 ; scroll text
    db $BD, $20, $22, $1C, $41 ; [ma]gic.
    db $73 ; scroll text
    db $E4, $1E, $42, $59, $2D, $92, $1E, $59 ; [Her]e,⎵t[ast]e⎵
    db $1A, $59, $2C, $1A, $26, $CA, $59, $C6 ; a⎵sam[ple]⎵[of]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $11, $A4, $0F, $28, $2D, $22, $C7, $43 ; R[ed ]Poti[on]…
    db $8A, $07, $1E, $59, $21, $1E, $3E ; [  ]He⎵he!
    db $7F ; end of message

    ; ==========================================================================
    ; Without a magic bottle, you can
    ; not buy any potions.
    ; He he he!
    ; --------------------------------------------------------------------------
    ; $0E1D71
    Message_004F:
    db $16, $B6, $21, $C5, $1A, $59, $BD, $20 ; W[it]h[out ]a⎵[ma]g
    db $22, $1C, $59, $98, $2D, $2D, $25, $1E ; ic⎵[bo]ttle
    db $42, $59, $E3, $59, $1C, $93 ; ,⎵[you]⎵c[an]
    db $75 ; line 2
    db $C2, $59, $1B, $2E, $32, $59, $93, $32 ; [not]⎵buy⎵[an]y
    db $59, $29, $28, $2D, $22, $C7, $2C, $41 ; ⎵poti[on]s.
    db $76 ; line 3
    db $07, $1E, $59, $21, $1E, $59, $21, $1E ; He⎵he⎵he
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; No,  no,  no…  I can't put
    ; anything into a full bottle.
    ; He he he!
    ; --------------------------------------------------------------------------
    ; $0E1DA3
    Message_0050:
    db $0D, $28, $42, $8A, $27, $28, $42, $8A ; No,[  ]no,[  ]
    db $27, $28, $43, $8A, $08, $59, $1C, $93 ; no…[  ]I⎵c[an]
    db $51, $2D, $59, $29, $2E, $2D ; 't⎵put
    db $75 ; line 2
    db $93, $32, $D5, $20, $59, $B4, $DA, $59 ; [an]y[thin]g⎵[in][to]⎵
    db $1A, $59, $1F, $2E, $25, $25, $59, $98 ; a⎵full⎵[bo]
    db $2D, $2D, $25, $1E, $41 ; ttle.
    db $76 ; line 3
    db $07, $1E, $59, $21, $1E, $59, $21, $1E ; He⎵he⎵he
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Lamp!
    ; Now you can light torches and
    ; see your way in darkness.
    ; --------------------------------------------------------------------------
    ; $0E1DDA
    Message_0051:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0B ; [You]⎵[go]t⎵[the]⎵L
    db $1A, $26, $29, $3E ; amp!
    db $75 ; line 2
    db $0D, $28, $30, $59, $E3, $59, $99, $25 ; Now⎵[you]⎵[can ]l
    db $B2, $DA, $2B, $9A, $2C, $59, $90 ; [ight ][to]r[che]s⎵[and]
    db $76 ; line 3
    db $D0, $1E, $59, $E3, $2B, $59, $DF, $32 ; [se]e⎵[you]r⎵[wa]y
    db $59, $B4, $59, $1D, $1A, $2B, $24, $27 ; ⎵[in]⎵darkn
    db $1E, $2C, $2C, $41 ; ess.
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Boomerang!
    ; Give it a try!  (To select an
    ; item, press the Start Button. )
    ; --------------------------------------------------------------------------
    ; $0E1E0C
    Message_0052:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $01 ; [You]⎵[go]t⎵[the]⎵B
    db $28, $28, $BE, $2B, $93, $20, $3E ; oo[me]r[an]g!
    db $75 ; line 2
    db $06, $22, $2F, $1E, $59, $B6, $59, $1A ; Give⎵[it]⎵a
    db $59, $DB, $32, $3E, $8A, $45, $13, $28 ; ⎵[tr]y![  ](To
    db $59, $D0, $25, $1E, $1C, $2D, $59, $93 ; ⎵[se]lect⎵[an]
    db $76 ; line 3
    db $B6, $1E, $26, $42, $59, $29, $CE, $2C ; [it]em,⎵p[re]s
    db $2C, $59, $D8, $59, $12, $2D, $1A, $2B ; s⎵[the]⎵Star
    db $2D, $59, $01, $2E, $2D, $DA, $27, $41 ; t⎵But[to]n.
    db $59, $46 ; ⎵)
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Bow!
    ; You can shoot arrows until you
    ; run out!
    ; --------------------------------------------------------------------------
    ; $0E1E50
    Message_0053:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $01 ; [You]⎵f[ound]⎵[the]⎵B
    db $28, $30, $3E ; ow!
    db $75 ; line 2
    db $E8, $59, $99, $D1, $28, $28, $2D, $59 ; [You]⎵[can ][sh]oot⎵
    db $1A, $2B, $2B, $28, $30, $2C, $59, $2E ; arrows⎵u
    db $27, $2D, $22, $25, $59, $E3 ; ntil⎵[you]
    db $76 ; line 3
    db $2B, $2E, $27, $59, $28, $2E, $2D, $3E ; run⎵out!
    db $7F ; end of message

    ; ==========================================================================
    ; You borrowed a shovel!
    ; You can dig in many places.
    ; You never know what you'll
    ; find!
    ; --------------------------------------------------------------------------
    ; $0E1E7C
    Message_0054:
    db $E8, $59, $98, $2B, $2B, $28, $E0, $1D ; [You]⎵[bo]rro[we]d
    db $59, $1A, $59, $D1, $28, $2F, $1E, $25 ; ⎵a⎵[sh]ovel
    db $3E ; !
    db $75 ; line 2
    db $E8, $59, $99, $9E, $20, $59, $B4, $59 ; [You]⎵[can ][di]g⎵[in]⎵
    db $BC, $32, $59, $29, $BA, $1C, $1E, $2C ; [man]y⎵p[la]ces
    db $41 ; .
    db $76 ; line 3
    db $E8, $59, $27, $A7, $A1, $B8, $59, $E1 ; [You]⎵n[ev][er ][know]⎵[wh]
    db $91, $E3, $51, $25, $25 ; [at ][you]'ll
    db $7E ; wait for key
    db $73 ; scroll text
    db $1F, $B4, $1D, $3E ; f[in]d!
    db $7F ; end of message

    ; ==========================================================================
    ; This is the Magic Cape!
    ; You are invisible when you wear
    ; it! Watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E1EB4
    Message_0055:
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1A, $20, $22, $1C, $59, $02, $1A, $29 ; agic⎵Cap
    db $1E, $3E ; e!
    db $75 ; line 2
    db $E8, $59, $8D, $B4, $2F, $B5, $22, $95 ; [You]⎵[are ][in]v[is]i[ble]
    db $59, $E1, $A0, $E3, $59, $E0, $1A, $2B ; ⎵[wh][en ][you]⎵[we]ar
    db $76 ; line 3
    db $B6, $3E, $59, $16, $94, $1C, $21, $59 ; [it]!⎵W[at]ch⎵
    db $E3, $2B, $59, $0C, $1A, $20, $22, $1C ; [you]r⎵Magic
    db $59, $0C, $1E, $D6, $3E ; ⎵Me[ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; This is Magic Powder!
    ; Try to sprinkle it on enemies
    ; and many other things!
    ; --------------------------------------------------------------------------
    ; $0E1EEE
    Message_0056:
    db $E7, $2C, $59, $B5, $59, $0C, $1A, $20 ; [Thi]s⎵[is]⎵Mag
    db $22, $1C, $59, $0F, $28, $30, $1D, $A6 ; ic⎵Powd[er]
    db $3E ; !
    db $75 ; line 2
    db $13, $2B, $32, $59, $DA, $59, $2C, $29 ; Try⎵[to]⎵sp
    db $2B, $B4, $24, $25, $1E, $59, $B6, $59 ; r[in]kle⎵[it]⎵
    db $C7, $59, $A5, $1E, $26, $22, $1E, $2C ; [on]⎵[en]emies
    db $76 ; line 3
    db $8C, $BC, $32, $59, $28, $D8, $2B, $59 ; [and ][man]y⎵o[the]r⎵
    db $D5, $20, $2C, $3E ; [thin]gs!
    db $7F ; end of message

    ; ==========================================================================
    ; You bought Zora's Flippers!
    ; With these you should be able
    ; to swim even in deep water!
    ; --------------------------------------------------------------------------
    ; $0E1F26
    Message_0057:
    db $E8, $59, $98, $2E, $20, $21, $2D, $59 ; [You]⎵[bo]ught⎵
    db $19, $C8, $1A, $8B, $05, $25, $22, $29 ; Z[or]a['s ]Flip
    db $C9, $2C, $3E ; [per]s!
    db $75 ; line 2
    db $16, $B6, $21, $59, $D8, $D0, $59, $E3 ; W[it]h⎵[the][se]⎵[you]
    db $59, $D1, $28, $2E, $25, $1D, $59, $97 ; ⎵[sh]ould⎵[be]
    db $59, $1A, $95 ; ⎵a[ble]
    db $76 ; line 3
    db $DA, $59, $2C, $E2, $26, $59, $A7, $A0 ; [to]⎵s[wi]m⎵[ev][en ]
    db $B4, $59, $1D, $1E, $1E, $29, $59, $DF ; [in]⎵deep⎵[wa]
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Power Glove!
    ; You can feel strength in both
    ; hands!  You can pick up and
    ; carry stones now!
    ; --------------------------------------------------------------------------
    ; $0E1F61
    Message_0058:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0F ; [You]⎵[go]t⎵[the]⎵P
    db $28, $E0, $2B, $59, $06, $BB, $2F, $1E ; o[we]r⎵G[lo]ve
    db $3E ; !
    db $75 ; line 2
    db $E8, $59, $99, $1F, $1E, $1E, $25, $59 ; [You]⎵[can ]feel⎵
    db $D3, $CE, $27, $20, $2D, $21, $59, $B4 ; [st][re]ngth⎵[in]
    db $59, $98, $2D, $21 ; ⎵[bo]th
    db $76 ; line 3
    db $B1, $27, $1D, $2C, $3E, $8A, $E8, $59 ; [ha]nds![  ][You]⎵
    db $99, $29, $22, $9C, $59, $DC, $59, $90 ; [can ]pi[ck]⎵[up]⎵[and]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $1A, $2B, $2B, $32, $59, $D3, $C7 ; carry⎵[st][on]
    db $1E, $2C, $59, $27, $28, $30, $3E ; es⎵now!
    db $7F ; end of message

    ; ==========================================================================
    ; You won the Pendant Of
    ; Courage!  Take it to
    ; Sahasrahla!
    ; Two Pendants remain!
    ; --------------------------------------------------------------------------
    ; $0E1FAA
    Message_0059:
    db $E8, $59, $30, $C7, $59, $D8, $59, $0F ; [You]⎵w[on]⎵[the]⎵P
    db $A5, $1D, $93, $2D, $59, $0E, $1F ; [en]d[an]t⎵Of
    db $75 ; line 2
    db $02, $28, $2E, $2B, $1A, $20, $1E, $3E ; Courage!
    db $8A, $13, $1A, $24, $1E, $59, $B6, $59 ; [  ]Take⎵[it]⎵
    db $DA ; [to]
    db $76 ; line 3
    db $12, $1A, $AE, $2B, $1A, $21, $BA, $3E ; Sa[has]rah[la]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $30, $28, $59, $0F, $A5, $1D, $93 ; Two⎵P[en]d[an]
    db $2D, $2C, $59, $CE, $BD, $B4, $3E ; ts⎵[re][ma][in]!
    db $7F ; end of message

    ; ==========================================================================
    ; You won the Pendant Of Power!
    ; Your goal of finding three
    ; Pendants is in sight!
    ; Go for the last one!
    ; --------------------------------------------------------------------------
    ; $0E1FE6
    Message_005A:
    db $E8, $59, $30, $C7, $59, $D8, $59, $0F ; [You]⎵w[on]⎵[the]⎵P
    db $A5, $1D, $93, $2D, $59, $0E, $1F, $59 ; [en]d[an]t⎵Of⎵
    db $0F, $28, $E0, $2B, $3E ; Po[we]r!
    db $75 ; line 2
    db $E8, $2B, $59, $AC, $1A, $25, $59, $C6 ; [You]r⎵[go]al⎵[of]
    db $59, $1F, $B4, $9E, $27, $20, $59, $2D ; ⎵f[in][di]ng⎵t
    db $21, $CE, $1E ; h[re]e
    db $76 ; line 3
    db $0F, $A5, $1D, $93, $2D, $2C, $59, $B5 ; P[en]d[an]ts⎵[is]
    db $59, $B4, $59, $2C, $22, $20, $21, $2D ; ⎵[in]⎵sight
    db $3E ; !
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $28, $59, $A8, $59, $D8, $59, $BA ; Go⎵[for]⎵[the]⎵[la]
    db $D3, $59, $C7, $1E, $3E ; [st]⎵[on]e!
    db $7F ; end of message

    ; ==========================================================================
    ; You won the Pendant Of Wisdom!
    ; With this, you have collected
    ; all three Pendants!  Go now to
    ; the Lost Woods to get
    ; the Master Sword!
    ; --------------------------------------------------------------------------
    ; $0E2031
    Message_005B:
    db $E8, $59, $30, $C7, $59, $D8, $59, $0F ; [You]⎵w[on]⎵[the]⎵P
    db $A5, $1D, $93, $2D, $59, $0E, $1F, $59 ; [en]d[an]t⎵Of⎵
    db $16, $B5, $9F, $26, $3E ; W[is][do]m!
    db $75 ; line 2
    db $16, $B6, $21, $59, $D9, $2C, $42, $59 ; W[it]h⎵[thi]s,⎵
    db $E3, $59, $AD, $59, $1C, $28, $25, $25 ; [you]⎵[have]⎵coll
    db $1E, $1C, $2D, $1E, $1D ; ected
    db $76 ; line 3
    db $8E, $2D, $21, $CE, $1E, $59, $0F, $A5 ; [all ]th[re]e⎵P[en]
    db $1D, $93, $2D, $2C, $3E, $8A, $06, $28 ; d[an]ts![  ]Go
    db $59, $27, $28, $30, $59, $DA ; ⎵now⎵[to]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $0B, $28, $D3, $59, $16, $28 ; [the]⎵Lo[st]⎵Wo
    db $28, $1D, $2C, $59, $DA, $59, $AB ; ods⎵[to]⎵[get]
    db $73 ; scroll text
    db $D8, $59, $0C, $92, $A1, $12, $30, $C8 ; [the]⎵M[ast][er ]Sw[or]
    db $1D, $3E ; d!
    db $7F ; end of message

    ; ==========================================================================
    ; This Mushroom smells like sweet
    ; rotten fruit…
    ; You can give this to anyone
    ; who wants it (Select it and
    ; press the ⓨ Button).
    ; --------------------------------------------------------------------------
    ; $0E2090
    Message_005C:
    db $E7, $2C, $59, $0C, $2E, $D1, $2B, $28 ; [Thi]s⎵Mu[sh]ro
    db $28, $26, $59, $2C, $BE, $25, $25, $2C ; om⎵s[me]lls
    db $59, $25, $22, $24, $1E, $59, $2C, $E0 ; ⎵like⎵s[we]
    db $1E, $2D ; et
    db $75 ; line 2
    db $2B, $28, $2D, $2D, $A0, $1F, $2B, $2E ; rott[en ]fru
    db $B6, $43 ; [it]…
    db $76 ; line 3
    db $E8, $59, $99, $AA, $D9, $2C, $59, $DA ; [You]⎵[can ][give ][thi]s⎵[to]
    db $59, $93, $32, $C7, $1E ; ⎵[an]y[on]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $E1, $28, $59, $DF, $27, $2D, $2C, $59 ; [wh]o⎵[wa]nts⎵
    db $B6, $59, $45, $12, $1E, $25, $1E, $1C ; [it]⎵(Selec
    db $2D, $59, $B6, $59, $90 ; t⎵[it]⎵[and]
    db $73 ; scroll text
    db $29, $CE, $2C, $2C, $59, $D8, $59, $5E ; p[re]ss⎵[the]⎵ⓨ
    db $59, $01, $2E, $2D, $DA, $27, $46, $41 ; ⎵But[to]n).
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Book of Mudora!
    ; You can use it to read the
    ; ancient language of the Hylia!
    ; --------------------------------------------------------------------------
    ; $0E20EC
    Message_005D:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $01 ; [You]⎵f[ound]⎵[the]⎵B
    db $28, $28, $24, $59, $C6, $59, $0C, $2E ; ook⎵[of]⎵Mu
    db $9F, $2B, $1A, $3E ; [do]ra!
    db $75 ; line 2
    db $E8, $59, $99, $2E, $D0, $59, $B6, $59 ; [You]⎵[can ]u[se]⎵[it]⎵
    db $DA, $59, $CE, $1A, $1D, $59, $D8 ; [to]⎵[re]ad⎵[the]
    db $76 ; line 3
    db $93, $1C, $22, $A3, $59, $BA, $27, $20 ; [an]ci[ent]⎵[la]ng
    db $2E, $1A, $20, $1E, $59, $C6, $59, $D8 ; uage⎵[of]⎵[the]
    db $59, $07, $32, $25, $22, $1A, $3E ; ⎵Hylia!
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Moon Pearl!
    ; This protects The Hero from
    ; the changing effects of the
    ; Golden Power.
    ; --------------------------------------------------------------------------
    ; $0E2129
    Message_005E:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $0C ; [You]⎵f[ound]⎵[the]⎵M
    db $28, $C7, $59, $0F, $A2, $25, $3E ; o[on]⎵P[ear]l!
    db $75 ; line 2
    db $E7, $2C, $59, $CC, $2D, $1E, $1C, $2D ; [Thi]s⎵[pro]tect
    db $2C, $59, $E6, $59, $E4, $28, $59, $A9 ; s⎵[The]⎵[Her]o⎵[fro]
    db $26 ; m
    db $76 ; line 3
    db $D8, $59, $1C, $B1, $27, $20, $B3, $1E ; [the]⎵c[ha]ng[ing ]e
    db $1F, $1F, $1E, $1C, $2D, $2C, $59, $C6 ; ffects⎵[of]
    db $59, $D8 ; ⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $28, $25, $1D, $A0, $0F, $28, $E0 ; Gold[en ]Po[we]
    db $2B, $41 ; r.
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Compass!
    ; Now you can pinpoint the
    ; lair of the dungeon's evil
    ; master!
    ; --------------------------------------------------------------------------
    ; $0E216A
    Message_005F:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $02 ; [You]⎵f[ound]⎵[the]⎵C
    db $28, $26, $29, $1A, $2C, $2C, $3E ; ompass!
    db $75 ; line 2
    db $0D, $28, $30, $59, $E3, $59, $99, $29 ; Now⎵[you]⎵[can ]p
    db $B4, $29, $28, $B4, $2D, $59, $D8 ; [in]po[in]t⎵[the]
    db $76 ; line 3
    db $BA, $22, $2B, $59, $C6, $59, $D8, $59 ; [la]ir⎵[of]⎵[the]⎵
    db $1D, $2E, $27, $20, $1E, $C7, $8B, $A7 ; dunge[on]['s ][ev]
    db $22, $25 ; il
    db $7E ; wait for key
    db $73 ; scroll text
    db $BD, $D3, $A6, $3E ; [ma][st][er]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Map!
    ; You can use it to see your
    ; current position and the rest
    ; of the dungeon (Press ⓧ).
    ; --------------------------------------------------------------------------
    ; $0E21A3
    Message_0060:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0C ; [You]⎵[go]t⎵[the]⎵M
    db $1A, $29, $3E ; ap!
    db $75 ; line 2
    db $E8, $59, $99, $2E, $D0, $59, $B6, $59 ; [You]⎵[can ]u[se]⎵[it]⎵
    db $DA, $59, $D0, $1E, $59, $E3, $2B ; [to]⎵[se]e⎵[you]r
    db $76 ; line 3
    db $1C, $2E, $2B, $CE, $27, $2D, $59, $29 ; cur[re]nt⎵p
    db $28, $2C, $B6, $22, $C7, $59, $8C, $D8 ; os[it]i[on]⎵[and ][the]
    db $59, $CE, $D3 ; ⎵[re][st]
    db $7E ; wait for key
    db $73 ; scroll text
    db $C6, $59, $D8, $59, $1D, $2E, $27, $20 ; [of]⎵[the]⎵dung
    db $1E, $C7, $59, $45, $0F, $CE, $2C, $2C ; e[on]⎵(P[re]ss
    db $59, $5D, $46, $41 ; ⎵ⓧ).
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Ice Rod!
    ; Its chill magic blasts the air!
    ; But watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E21E9
    Message_0061:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $08 ; [You]⎵f[ound]⎵[the]⎵I
    db $1C, $1E, $59, $11, $28, $1D, $3E ; ce⎵Rod!
    db $75 ; line 2
    db $08, $2D, $2C, $59, $1C, $B0, $25, $25 ; Its⎵c[hi]ll
    db $59, $BD, $20, $22, $1C, $59, $1B, $BA ; ⎵[ma]gic⎵b[la]
    db $D3, $2C, $59, $D8, $59, $1A, $22, $2B ; [st]s⎵[the]⎵air
    db $3E ; !
    db $76 ; line 3
    db $01, $2E, $2D, $59, $DF, $2D, $1C, $21 ; But⎵[wa]tch
    db $59, $E3, $2B, $59, $0C, $1A, $20, $22 ; ⎵[you]r⎵Magi
    db $1C, $59, $0C, $1E, $D6, $3E ; c⎵Me[ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Fire Rod!
    ; This rod commands the red fire!
    ; But watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E222A
    Message_0062:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $05 ; [You]⎵f[ound]⎵[the]⎵F
    db $22, $CD, $11, $28, $1D, $3E ; i[re ]Rod!
    db $75 ; line 2
    db $E7, $2C, $59, $2B, $28, $1D, $59, $9B ; [Thi]s⎵rod⎵[com]
    db $BC, $1D, $2C, $59, $D8, $59, $CE, $1D ; [man]ds⎵[the]⎵[re]d
    db $59, $1F, $22, $CE, $3E ; ⎵fi[re]!
    db $76 ; line 3
    db $01, $2E, $2D, $59, $DF, $2D, $1C, $21 ; But⎵[wa]tch
    db $59, $E3, $2B, $59, $0C, $1A, $20, $22 ; ⎵[you]r⎵Magi
    db $1C, $59, $0C, $1E, $D6, $3E ; c⎵Me[ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; This is the Ether Medallion!
    ; Its magic controls the upper
    ; atmosphere and polar wind!
    ; Watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E2266
    Message_0063:
    db $E7, $2C, $59, $B5, $59, $D8, $59, $04 ; [Thi]s⎵[is]⎵[the]⎵E
    db $D8, $2B, $59, $0C, $1E, $1D, $1A, $25 ; [the]r⎵Medal
    db $25, $22, $C7, $3E ; li[on]!
    db $75 ; line 2
    db $08, $2D, $2C, $59, $BD, $20, $22, $1C ; Its⎵[ma]gic
    db $59, $1C, $C7, $DB, $28, $25, $2C, $59 ; ⎵c[on][tr]ols⎵
    db $D8, $59, $DC, $C9 ; [the]⎵[up][per]
    db $76 ; line 3
    db $94, $26, $28, $2C, $29, $AF, $1E, $59 ; [at]mosp[her]e⎵
    db $8C, $29, $28, $BA, $2B, $59, $E2, $27 ; [and ]po[la]r⎵[wi]n
    db $1D, $3E ; d!
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $94, $1C, $21, $59, $E3, $2B, $59 ; W[at]ch⎵[you]r⎵
    db $0C, $1A, $20, $22, $1C, $59, $0C, $1E ; Magic⎵Me
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; This is the Bombos Medallion!
    ; Its magic makes the ground
    ; explode with power!
    ; Watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E22B7
    Message_0064:
    db $E7, $2C, $59, $B5, $59, $D8, $59, $01 ; [Thi]s⎵[is]⎵[the]⎵B
    db $28, $26, $98, $2C, $59, $0C, $1E, $1D ; om[bo]s⎵Med
    db $1A, $25, $25, $22, $C7, $3E ; alli[on]!
    db $75 ; line 2
    db $08, $2D, $2C, $59, $BD, $20, $22, $1C ; Its⎵[ma]gic
    db $59, $BD, $24, $1E, $2C, $59, $D8, $59 ; ⎵[ma]kes⎵[the]⎵
    db $20, $2B, $C4 ; gr[ound]
    db $76 ; line 3
    db $1E, $31, $29, $BB, $1D, $1E, $59, $DE ; exp[lo]de⎵[with]
    db $59, $CB, $A6, $3E ; ⎵[pow][er]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $94, $1C, $21, $59, $E3, $2B, $59 ; W[at]ch⎵[you]r⎵
    db $0C, $1A, $20, $22, $1C, $59, $0C, $1E ; Magic⎵Me
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; This is the Quake Medallion!
    ; Its magic causes the ground
    ; to shake and defeats
    ; nearby enemies!
    ; Watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E2303
    Message_0065:
    db $E7, $2C, $59, $B5, $59, $D8, $59, $10 ; [Thi]s⎵[is]⎵[the]⎵Q
    db $2E, $1A, $24, $1E, $59, $0C, $1E, $1D ; uake⎵Med
    db $1A, $25, $25, $22, $C7, $3E ; alli[on]!
    db $75 ; line 2
    db $08, $2D, $2C, $59, $BD, $20, $22, $1C ; Its⎵[ma]gic
    db $59, $1C, $1A, $2E, $D0, $2C, $59, $D8 ; ⎵cau[se]s⎵[the]
    db $59, $20, $2B, $C4 ; ⎵gr[ound]
    db $76 ; line 3
    db $DA, $59, $D1, $1A, $24, $1E, $59, $8C ; [to]⎵[sh]ake⎵[and ]
    db $1D, $1E, $1F, $1E, $94, $2C ; defe[at]s
    db $7E ; wait for key
    db $73 ; scroll text
    db $27, $A2, $1B, $32, $59, $A5, $1E, $26 ; n[ear]by⎵[en]em
    db $22, $1E, $2C, $3E ; ies!
    db $73 ; scroll text
    db $16, $94, $1C, $21, $59, $E3, $2B, $59 ; W[at]ch⎵[you]r⎵
    db $0C, $1A, $20, $22, $1C, $59, $0C, $1E ; Magic⎵Me
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Magic Hammer!
    ; You can drive the wooden
    ; stakes down into the ground!
    ; You can use it to pound on
    ; other things too!
    ; --------------------------------------------------------------------------
    ; $0E235F
    Message_0066:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0C ; [You]⎵[go]t⎵[the]⎵M
    db $1A, $20, $22, $1C, $59, $07, $1A, $26 ; agic⎵Ham
    db $BE, $2B, $3E ; [me]r!
    db $75 ; line 2
    db $E8, $59, $99, $1D, $2B, $22, $2F, $1E ; [You]⎵[can ]drive
    db $59, $D8, $59, $30, $28, $28, $1D, $A5 ; ⎵[the]⎵wood[en]
    db $76 ; line 3
    db $D3, $1A, $24, $1E, $2C, $59, $9F, $30 ; [st]akes⎵[do]w
    db $27, $59, $B4, $DA, $59, $D8, $59, $20 ; n⎵[in][to]⎵[the]⎵g
    db $2B, $C4, $3E ; r[ound]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $99, $2E, $D0, $59, $B6, $59 ; [You]⎵[can ]u[se]⎵[it]⎵
    db $DA, $59, $29, $C4, $59, $C7 ; [to]⎵p[ound]⎵[on]
    db $73 ; scroll text
    db $28, $D8, $2B, $59, $D5, $20, $2C, $59 ; o[the]r⎵[thin]gs⎵
    db $DA, $28, $3E ; [to]o!
    db $7F ; end of message

    ; ==========================================================================
    ; Oh!  Here is the Flute!
    ; Its music surely has some
    ; mysterious power!
    ; --------------------------------------------------------------------------
    ; $0E23B4
    Message_0067:
    db $0E, $21, $3E, $8A, $E4, $1E, $59, $B5 ; Oh![  ][Her]e⎵[is]
    db $59, $D8, $59, $05, $25, $2E, $2D, $1E ; ⎵[the]⎵Flute
    db $3E ; !
    db $75 ; line 2
    db $08, $2D, $2C, $59, $BF, $2C, $22, $1C ; Its⎵[mu]sic
    db $59, $2C, $2E, $CE, $B9, $AE, $59, $CF ; ⎵su[re][ly ][has]⎵[some]
    db $76 ; line 3
    db $26, $32, $D3, $A6, $22, $28, $2E, $2C ; my[st][er]ious
    db $59, $CB, $A6, $3E ; ⎵[pow][er]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Cane Of Somaria!
    ; It will be very helpful if you
    ; make proper use of it!
    ; What a mysterious cane!
    ; --------------------------------------------------------------------------
    ; $0E23E4
    Message_0068:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $02 ; [You]⎵[go]t⎵[the]⎵C
    db $93, $1E, $59, $0E, $1F, $59, $12, $28 ; [an]e⎵Of⎵So
    db $BD, $2B, $22, $1A, $3E ; [ma]ria!
    db $75 ; line 2
    db $08, $2D, $59, $E2, $25, $25, $59, $97 ; It⎵[wi]ll⎵[be]
    db $59, $DD, $32, $59, $21, $1E, $25, $29 ; ⎵[ver]y⎵help
    db $1F, $2E, $25, $59, $22, $1F, $59, $E3 ; ful⎵if⎵[you]
    db $76 ; line 3
    db $BD, $24, $1E, $59, $CC, $C9, $59, $2E ; [ma]ke⎵[pro][per]⎵u
    db $D0, $59, $C6, $59, $B6, $3E ; [se]⎵[of]⎵[it]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $1A, $59, $26, $32 ; W[ha]t⎵a⎵my
    db $D3, $A6, $22, $28, $2E, $2C, $59, $1C ; [st][er]ious⎵c
    db $93, $1E, $3E ; [an]e!
    db $7F ; end of message

    ; ==========================================================================
    ; BOING!  This is the Hook Shot!
    ; It extends and contracts and…
    ; BOING!  It can grapple many
    ; things!
    ; --------------------------------------------------------------------------
    ; $0E2437
    Message_0069:
    db $01, $0E, $08, $0D, $06, $3E, $8A, $E7 ; BOING![  ][Thi]
    db $2C, $59, $B5, $59, $D8, $59, $07, $28 ; s⎵[is]⎵[the]⎵Ho
    db $28, $24, $59, $12, $21, $28, $2D, $3E ; ok⎵Shot!
    db $75 ; line 2
    db $08, $2D, $59, $1E, $31, $2D, $A5, $1D ; It⎵ext[en]d
    db $2C, $59, $8C, $1C, $C7, $DB, $1A, $1C ; s⎵[and ]c[on][tr]ac
    db $2D, $2C, $59, $90, $43 ; ts⎵[and]…
    db $76 ; line 3
    db $01, $0E, $08, $0D, $06, $3E, $8A, $08 ; BOING![  ]I
    db $2D, $59, $99, $20, $2B, $1A, $29, $CA ; t⎵[can ]grap[ple]
    db $59, $BC, $32 ; ⎵[man]y
    db $7E ; wait for key
    db $73 ; scroll text
    db $D5, $20, $2C, $3E ; [thin]gs!
    db $7F ; end of message

    ; ==========================================================================
    ; You got some Bombs!
    ; You can pick up and throw
    ; a Bomb you placed
    ; (Press the Ⓐ Button)!
    ; --------------------------------------------------------------------------
    ; $0E2480
    Message_006A:
    db $E8, $59, $AC, $2D, $59, $CF, $59, $01 ; [You]⎵[go]t⎵[some]⎵B
    db $28, $26, $1B, $2C, $3E ; ombs!
    db $75 ; line 2
    db $E8, $59, $99, $29, $22, $9C, $59, $DC ; [You]⎵[can ]pi[ck]⎵[up]
    db $59, $8C, $2D, $21, $2B, $28, $30 ; ⎵[and ]throw
    db $76 ; line 3
    db $1A, $59, $01, $28, $26, $1B, $59, $E3 ; a⎵Bomb⎵[you]
    db $59, $29, $BA, $1C, $1E, $1D ; ⎵p[la]ced
    db $7E ; wait for key
    db $73 ; scroll text
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5B, $59, $01, $2E, $2D, $DA, $27, $46 ; Ⓐ⎵But[to]n)
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; This is a Magic Bottle!
    ; You can store an item
    ; inside and then use it later!
    ; --------------------------------------------------------------------------
    ; $0E24C0
    Message_006B:
    db $E7, $2C, $59, $B5, $59, $1A, $59, $0C ; [Thi]s⎵[is]⎵a⎵M
    db $1A, $20, $22, $1C, $59, $01, $28, $2D ; agic⎵Bot
    db $2D, $25, $1E, $3E ; tle!
    db $75 ; line 2
    db $E8, $59, $99, $D3, $C8, $1E, $59, $93 ; [You]⎵[can ][st][or]e⎵[an]
    db $59, $B6, $1E, $26 ; ⎵[it]em
    db $76 ; line 3
    db $B4, $2C, $22, $1D, $1E, $59, $8C, $D8 ; [in]side⎵[and ][the]
    db $27, $59, $2E, $D0, $59, $B6, $59, $BA ; n⎵u[se]⎵[it]⎵[la]
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Big Key!
    ; This is the master key of the
    ; dungeon.  It can open many
    ; locks that small keys cannot.
    ; --------------------------------------------------------------------------
    ; $0E24F5
    Message_006C:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $01 ; [You]⎵[go]t⎵[the]⎵B
    db $22, $20, $59, $0A, $1E, $32, $3E ; ig⎵Key!
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $BD ; [Thi]s⎵[is]⎵[the]⎵[ma]
    db $D3, $A1, $24, $1E, $32, $59, $C6, $59 ; [st][er ]key⎵[of]⎵
    db $D8 ; [the]
    db $76 ; line 3
    db $1D, $2E, $27, $20, $1E, $C7, $41, $8A ; dunge[on].[  ]
    db $08, $2D, $59, $99, $C3, $59, $BC, $32 ; It⎵[can ][open]⎵[man]y
    db $7E ; wait for key
    db $73 ; scroll text
    db $BB, $9C, $2C, $59, $D7, $2D, $59, $2C ; [lo][ck]s⎵[tha]t⎵s
    db $BD, $25, $25, $59, $24, $1E, $32, $2C ; [ma]ll⎵keys
    db $59, $1C, $93, $C2, $41 ; ⎵c[an][not].
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Titan's Mitt!
    ; Now you can lift the heaviest
    ; stones that were once
    ; impossible to budge.
    ; --------------------------------------------------------------------------
    ; $0E253F
    Message_006D:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $13 ; [You]⎵[go]t⎵[the]⎵T
    db $B6, $93, $8B, $0C, $B6, $2D, $3E ; [it][an]['s ]M[it]t!
    db $75 ; line 2
    db $0D, $28, $30, $59, $E3, $59, $99, $25 ; Now⎵[you]⎵[can ]l
    db $22, $1F, $2D, $59, $D8, $59, $21, $1E ; ift⎵[the]⎵he
    db $1A, $2F, $22, $1E, $D3 ; avie[st]
    db $76 ; line 3
    db $D3, $C7, $1E, $2C, $59, $D7, $2D, $59 ; [st][on]es⎵[tha]t⎵
    db $E0, $CD, $C7, $1C, $1E ; [we][re ][on]ce
    db $7E ; wait for key
    db $73 ; scroll text
    db $22, $26, $29, $28, $2C, $2C, $22, $95 ; impossi[ble]
    db $59, $DA, $59, $1B, $2E, $1D, $20, $1E ; ⎵[to]⎵budge
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; He gave you the Magic Mirror!
    ; This mirror is blue, clear and
    ; beautiful…
    ; You feel like it is going to
    ; absorb you into another world…
    ; --------------------------------------------------------------------------
    ; $0E2586
    Message_006E:
    db $07, $1E, $59, $20, $1A, $2F, $1E, $59 ; He⎵gave⎵
    db $E3, $59, $D8, $59, $0C, $1A, $20, $22 ; [you]⎵[the]⎵Magi
    db $1C, $59, $0C, $22, $2B, $2B, $C8, $3E ; c⎵Mirr[or]!
    db $75 ; line 2
    db $E7, $2C, $59, $26, $22, $2B, $2B, $C8 ; [Thi]s⎵mirr[or]
    db $59, $B5, $59, $1B, $25, $2E, $1E, $42 ; ⎵[is]⎵blue,
    db $59, $1C, $25, $A2, $59, $90 ; ⎵cl[ear]⎵[and]
    db $76 ; line 3
    db $97, $1A, $2E, $2D, $22, $1F, $2E, $25 ; [be]autiful
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $1F, $1E, $1E, $25, $59, $25 ; [You]⎵feel⎵l
    db $22, $24, $1E, $59, $B6, $59, $B5, $59 ; ike⎵[it]⎵[is]⎵
    db $AC, $B3, $DA ; [go][ing ][to]
    db $73 ; scroll text
    db $1A, $1B, $D2, $2B, $1B, $59, $E3, $59 ; ab[so]rb⎵[you]⎵
    db $B4, $DA, $59, $93, $28, $D8, $2B, $59 ; [in][to]⎵[an]o[the]r⎵
    db $30, $C8, $25, $1D, $43 ; w[or]ld…
    db $7F ; end of message

    ; ==========================================================================
    ; This is it!  The Master Sword!
    ; …  …  …
    ; No, this can't be it… Too bad.
    ; --------------------------------------------------------------------------
    ; $0E25EB
    Message_006F:
    db $E7, $2C, $59, $B5, $59, $B6, $3E, $8A ; [Thi]s⎵[is]⎵[it]![  ]
    db $E6, $59, $0C, $92, $A1, $12, $30, $C8 ; [The]⎵M[ast][er ]Sw[or]
    db $1D, $3E ; d!
    db $75 ; line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $76 ; line 3
    db $0D, $28, $42, $59, $D9, $2C, $59, $1C ; No,⎵[thi]s⎵c
    db $93, $51, $2D, $59, $97, $59, $B6, $43 ; [an]'t⎵[be]⎵[it]…
    db $59, $13, $28, $28, $59, $96, $1D, $41 ; ⎵Too⎵[ba]d.
    db $7F ; end of message

    ; ==========================================================================
    ; Suddenly, Sahasrahla contacts
    ; you telepathically…
    ; …  …  …
    ; [LINK], it is extraordinary
    ; that you won the Master Sword
    ; that makes evil retreat…
    ; With this shining sword, I
    ; believe you can deflect the
    ; wizard's evil powers.
    ; 
    ; The destiny of this land
    ; is in your hands.
    ; Please, [LINK]…
    ; --------------------------------------------------------------------------
    ; $0E261D
    Message_0070:
    db $6B, $02 ; set window border
    db $7A, $03 ; set draw speed
    db $12, $2E, $1D, $1D, $A5, $25, $32, $42 ; Sudd[en]ly,
    db $59, $12, $1A, $AE, $2B, $1A, $21, $BA ; ⎵Sa[has]rah[la]
    db $59, $1C, $C7, $2D, $1A, $1C, $2D, $2C ; ⎵c[on]tacts
    db $75 ; line 2
    db $E3, $59, $2D, $1E, $25, $1E, $29, $94 ; [you]⎵telep[at]
    db $B0, $1C, $1A, $25, $25, $32, $43 ; [hi]cally…
    db $76 ; line 3
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $6A, $42, $59, $B6, $59, $B5, $59, $1E ; [LINK],⎵[it]⎵[is]⎵e
    db $31, $DB, $1A, $C8, $9E, $27, $1A, $2B ; x[tr]a[or][di]nar
    db $32 ; y
    db $73 ; scroll text
    db $D7, $2D, $59, $E3, $59, $30, $C7, $59 ; [tha]t⎵[you]⎵w[on]⎵
    db $D8, $59, $0C, $92, $A1, $12, $30, $C8 ; [the]⎵M[ast][er ]Sw[or]
    db $1D ; d
    db $73 ; scroll text
    db $D7, $2D, $59, $BD, $24, $1E, $2C, $59 ; [tha]t⎵[ma]kes⎵
    db $A7, $22, $25, $59, $CE, $DB, $1E, $94 ; [ev]il⎵[re][tr]e[at]
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B6, $21, $59, $D9, $2C, $59, $D1 ; W[it]h⎵[thi]s⎵[sh]
    db $B4, $B3, $2C, $30, $C8, $1D, $42, $59 ; [in][ing ]sw[or]d,⎵
    db $08 ; I
    db $73 ; scroll text
    db $97, $25, $22, $A7, $1E, $59, $E3, $59 ; [be]li[ev]e⎵[you]⎵
    db $99, $1D, $1E, $1F, $25, $1E, $1C, $2D ; [can ]deflect
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $E2, $33, $1A, $2B, $1D, $8B, $A7, $22 ; [wi]zard['s ][ev]i
    db $25, $59, $CB, $A6, $2C, $41 ; l⎵[pow][er]s.
    db $7E ; wait for key
    db $73 ; scroll text
    db $73 ; scroll text
    db $E6, $59, $9D, $2D, $B4, $32, $59, $C6 ; [The]⎵[des]t[in]y⎵[of]
    db $59, $D9, $2C, $59, $BA, $27, $1D ; ⎵[thi]s⎵[la]nd
    db $73 ; scroll text
    db $B5, $59, $B4, $59, $E3, $2B, $59, $B1 ; [is]⎵[in]⎵[you]r⎵[ha]
    db $27, $1D, $2C, $41 ; nds.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $42, $59, $6A ; Plea[se],⎵[LINK]
    db $43 ; …
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh heh…  Thank you!
    ; This is the Medicine of Life.
    ; Use it to regain your Life
    ; power.
    ; --------------------------------------------------------------------------
    ; $0E26E6
    Message_0071:
    db $07, $1E, $21, $59, $21, $1E, $21, $59 ; Heh⎵heh⎵
    db $21, $1E, $21, $43, $8A, $E5, $27, $24 ; heh…[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1E, $9E, $1C, $B4, $1E, $59, $C6, $59 ; e[di]c[in]e⎵[of]⎵
    db $0B, $22, $1F, $1E, $41 ; Life.
    db $76 ; line 3
    db $14, $D0, $59, $B6, $59, $DA, $59, $CE ; U[se]⎵[it]⎵[to]⎵[re]
    db $20, $8F, $59, $E3, $2B, $59, $0B, $22 ; g[ain]⎵[you]r⎵Li
    db $1F, $1E ; fe
    db $7E ; wait for key
    db $73 ; scroll text
    db $CB, $A6, $41 ; [pow][er].
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh heh…  Thank you!
    ; This is the Medicine of Magic.
    ; You can recharge your mystic
    ; energy with it.
    ; --------------------------------------------------------------------------
    ; $0E2728
    Message_0072:
    db $07, $1E, $21, $59, $21, $1E, $21, $59 ; Heh⎵heh⎵
    db $21, $1E, $21, $43, $8A, $E5, $27, $24 ; heh…[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1E, $9E, $1C, $B4, $1E, $59, $C6, $59 ; e[di]c[in]e⎵[of]⎵
    db $0C, $1A, $20, $22, $1C, $41 ; Magic.
    db $76 ; line 3
    db $E8, $59, $99, $CE, $1C, $B1, $2B, $20 ; [You]⎵[can ][re]c[ha]rg
    db $1E, $59, $E3, $2B, $59, $26, $32, $D3 ; e⎵[you]r⎵my[st]
    db $22, $1C ; ic
    db $7E ; wait for key
    db $73 ; scroll text
    db $A5, $A6, $20, $32, $59, $DE, $59, $B6 ; [en][er]gy⎵[with]⎵[it]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh heh…  Thank you!
    ; This is the Medicine of Life and
    ; Magic!  You can recover both!
    ; --------------------------------------------------------------------------
    ; $0E2771
    Message_0073:
    db $07, $1E, $21, $59, $21, $1E, $21, $59 ; Heh⎵heh⎵
    db $21, $1E, $21, $43, $8A, $E5, $27, $24 ; heh…[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1E, $9E, $1C, $B4, $1E, $59, $C6, $59 ; e[di]c[in]e⎵[of]⎵
    db $0B, $22, $1F, $1E, $59, $90 ; Life⎵[and]
    db $76 ; line 3
    db $0C, $1A, $20, $22, $1C, $3E, $8A, $E8 ; Magic![  ][You]
    db $59, $99, $CE, $1C, $28, $DD, $59, $98 ; ⎵[can ][re]co[ver]⎵[bo]
    db $2D, $21, $3E ; th!
    db $7F ; end of message

    ; ==========================================================================
    ; You borrowed the Bug Catching
    ; Net!  There may be some other
    ; things you can catch with it,
    ; too.
    ; --------------------------------------------------------------------------
    ; $0E27B0
    Message_0074:
    db $E8, $59, $98, $2B, $2B, $28, $E0, $1D ; [You]⎵[bo]rro[we]d
    db $59, $D8, $59, $01, $2E, $20, $59, $02 ; ⎵[the]⎵Bug⎵C
    db $94, $1C, $B0, $27, $20 ; [at]c[hi]ng
    db $75 ; line 2
    db $0D, $1E, $2D, $3E, $8A, $E6, $CD, $BD ; Net![  ][The][re ][ma]
    db $32, $59, $97, $59, $CF, $59, $28, $D8 ; y⎵[be]⎵[some]⎵o[the]
    db $2B ; r
    db $76 ; line 3
    db $D5, $20, $2C, $59, $E3, $59, $99, $1C ; [thin]gs⎵[you]⎵[can ]c
    db $94, $1C, $21, $59, $DE, $59, $B6, $42 ; [at]ch⎵[with]⎵[it],
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $28, $41 ; [to]o.
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Blue Mail!
    ; This armor reduces the damage
    ; that you take from enemies!
    ; --------------------------------------------------------------------------
    ; $0E27EE
    Message_0075:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $01 ; [You]⎵f[ound]⎵[the]⎵B
    db $25, $2E, $1E, $59, $0C, $1A, $22, $25 ; lue⎵Mail
    db $3E ; !
    db $75 ; line 2
    db $E7, $2C, $59, $1A, $2B, $26, $C8, $59 ; [Thi]s⎵arm[or]⎵
    db $CE, $1D, $2E, $1C, $1E, $2C, $59, $D8 ; [re]duces⎵[the]
    db $59, $1D, $1A, $BD, $20, $1E ; ⎵da[ma]ge
    db $76 ; line 3
    db $D7, $2D, $59, $E3, $59, $2D, $1A, $24 ; [tha]t⎵[you]⎵tak
    db $1E, $59, $A9, $26, $59, $A5, $1E, $26 ; e⎵[fro]m⎵[en]em
    db $22, $1E, $2C, $3E ; ies!
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Red Mail!
    ; This provides even better
    ; protection than the Blue Mail!
    ; --------------------------------------------------------------------------
    ; $0E282C
    Message_0076:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $11 ; [You]⎵f[ound]⎵[the]⎵R
    db $A4, $0C, $1A, $22, $25, $3E ; [ed ]Mail!
    db $75 ; line 2
    db $E7, $2C, $59, $CC, $2F, $22, $9D, $59 ; [Thi]s⎵[pro]vi[des]⎵
    db $A7, $A0, $97, $2D, $D6 ; [ev][en ][be]t[ter]
    db $76 ; line 3
    db $CC, $2D, $1E, $1C, $2D, $22, $C7, $59 ; [pro]tecti[on]⎵
    db $D7, $27, $59, $D8, $59, $01, $25, $2E ; [tha]n⎵[the]⎵Blu
    db $1E, $59, $0C, $1A, $22, $25, $3E ; e⎵Mail!
    db $7F ; end of message

    ; ==========================================================================
    ; Great!  Your sword is stronger!
    ; You can feel the sheer power
    ; flowing through your body!
    ; --------------------------------------------------------------------------
    ; $0E2861
    Message_0077:
    db $06, $CE, $94, $3E, $8A, $E8, $2B, $59 ; G[re][at]![  ][You]r⎵
    db $2C, $30, $C8, $1D, $59, $B5, $59, $D3 ; sw[or]d⎵[is]⎵[st]
    db $2B, $C7, $20, $A6, $3E ; r[on]g[er]!
    db $75 ; line 2
    db $E8, $59, $99, $1F, $1E, $1E, $25, $59 ; [You]⎵[can ]feel⎵
    db $D8, $59, $D1, $1E, $A1, $CB, $A6 ; [the]⎵[sh]e[er ][pow][er]
    db $76 ; line 3
    db $1F, $BB, $E2, $27, $20, $59, $2D, $21 ; f[lo][wi]ng⎵th
    db $2B, $28, $2E, $20, $21, $59, $E3, $2B ; rough⎵[you]r
    db $59, $98, $1D, $32, $3E ; ⎵[bo]dy!
    db $7F ; end of message

    ; ==========================================================================
    ; You found the Mirror Shield!
    ; You can now reflect beams
    ; that your old shield
    ; couldn't block!
    ; --------------------------------------------------------------------------
    ; $0E289D
    Message_0078:
    db $E8, $59, $1F, $C4, $59, $D8, $59, $0C ; [You]⎵f[ound]⎵[the]⎵M
    db $22, $2B, $2B, $C8, $59, $12, $B0, $1E ; irr[or]⎵S[hi]e
    db $25, $1D, $3E ; ld!
    db $75 ; line 2
    db $E8, $59, $99, $27, $28, $30, $59, $CE ; [You]⎵[can ]now⎵[re]
    db $1F, $25, $1E, $1C, $2D, $59, $97, $1A ; flect⎵[be]a
    db $26, $2C ; ms
    db $76 ; line 3
    db $D7, $2D, $59, $E3, $2B, $59, $28, $25 ; [tha]t⎵[you]r⎵ol
    db $1D, $59, $D1, $22, $1E, $25, $1D ; d⎵[sh]ield
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $28, $2E, $25, $1D, $C0, $1B, $BB ; could[n't ]b[lo]
    db $9C, $3E ; [ck]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Cane Of Byrna!
    ; If you swing it once, a ring of
    ; light will protect you!
    ; --------------------------------------------------------------------------
    ; $0E28E0
    Message_0079:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $02 ; [You]⎵[go]t⎵[the]⎵C
    db $93, $1E, $59, $0E, $1F, $59, $01, $32 ; [an]e⎵Of⎵By
    db $2B, $27, $1A, $3E ; rna!
    db $75 ; line 2
    db $08, $1F, $59, $E3, $59, $2C, $E2, $27 ; If⎵[you]⎵s[wi]n
    db $20, $59, $B6, $59, $C7, $1C, $1E, $42 ; g⎵[it]⎵[on]ce,
    db $59, $1A, $59, $2B, $B3, $C6 ; ⎵a⎵r[ing ][of]
    db $76 ; line 3
    db $25, $B2, $E2, $25, $25, $59, $CC, $2D ; l[ight ][wi]ll⎵[pro]t
    db $1E, $1C, $2D, $59, $E3, $3E ; ect⎵[you]!
    db $7F ; end of message

    ; ==========================================================================
    ; Eh?  It's locked!
    ; If you had the Big Key, you
    ; might be able to open it!
    ; --------------------------------------------------------------------------
    ; $0E281B
    Message_007A:
    db $04, $21, $3F, $8A, $08, $2D, $8B, $BB ; Eh?[  ]It['s ][lo]
    db $9C, $1E, $1D, $3E ; [ck]ed!
    db $75 ; line 2
    db $08, $1F, $59, $E3, $59, $B1, $1D, $59 ; If⎵[you]⎵[ha]d⎵
    db $D8, $59, $01, $22, $20, $59, $0A, $1E ; [the]⎵Big⎵Ke
    db $32, $42, $59, $E3 ; y,⎵[you]
    db $76 ; line 3
    db $26, $B2, $97, $59, $1A, $95, $59, $DA ; m[ight ][be]⎵a[ble]⎵[to]
    db $59, $C3, $59, $B6, $3E ; ⎵[open]⎵[it]!
    db $7F ; end of message

    ; ==========================================================================
    ; You are short on Magic Power!
    ; You can't use this item now.
    ; Watch your Magic Meter!
    ; --------------------------------------------------------------------------
    ; $0E294B
    Message_007B:
    db $E8, $59, $8D, $D1, $C8, $2D, $59, $C7 ; [You]⎵[are ][sh][or]t⎵[on]
    db $59, $0C, $1A, $20, $22, $1C, $59, $0F ; ⎵Magic⎵P
    db $28, $E0, $2B, $3E ; o[we]r!
    db $75 ; line 2
    db $E8, $59, $1C, $93, $51, $2D, $59, $2E ; [You]⎵c[an]'t⎵u
    db $D0, $59, $D9, $2C, $59, $B6, $1E, $26 ; [se]⎵[thi]s⎵[it]em
    db $59, $27, $28, $30, $41 ; ⎵now.
    db $76 ; line 3
    db $16, $94, $1C, $21, $59, $E3, $2B, $59 ; W[at]ch⎵[you]r⎵
    db $0C, $1A, $20, $22, $1C, $59, $0C, $1E ; Magic⎵Me
    db $D6, $3E ; [ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; He gives you the Pegasus
    ; Shoes!  Now you can execute a
    ; devastating dash attack!
    ; (Hold the Ⓐ Button
    ; for a short time.)
    ; --------------------------------------------------------------------------
    ; $0E2989
    Message_007C:
    db $07, $1E, $59, $20, $22, $2F, $1E, $2C ; He⎵gives
    db $59, $E3, $59, $D8, $59, $0F, $1E, $20 ; ⎵[you]⎵[the]⎵Peg
    db $1A, $2C, $2E, $2C ; asus
    db $75 ; line 2
    db $12, $21, $28, $1E, $2C, $3E, $8A, $0D ; Shoes![  ]N
    db $28, $30, $59, $E3, $59, $99, $1E, $31 ; ow⎵[you]⎵[can ]ex
    db $1E, $1C, $2E, $2D, $1E, $59, $1A ; ecute⎵a
    db $76 ; line 3
    db $1D, $A7, $92, $94, $B3, $1D, $1A, $D1 ; d[ev][ast][at][ing ]da[sh]
    db $59, $94, $2D, $1A, $9C, $3E ; ⎵[at]ta[ck]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $45, $07, $28, $25, $1D, $59, $D8, $59 ; (Hold⎵[the]⎵
    db $5B, $59, $01, $2E, $2D, $DA, $27 ; Ⓐ⎵But[to]n
    db $73 ; scroll text
    db $A8, $59, $1A, $59, $D1, $C8, $2D, $59 ; [for]⎵a⎵[sh][or]t⎵
    db $2D, $22, $BE, $41, $46 ; ti[me].)
    db $7F ; end of message

    ; ==========================================================================
    ; Wow!  I haven't seen a normal
    ; person in a few hundred years!
    ; Let me talk to you for a while.
    ; --------------------------------------------------------------------------
    ; $0E29E4
    Message_007D:
    db $16, $28, $30, $3E, $8A, $08, $59, $AD ; Wow![  ]I⎵[have]
    db $C0, $D0, $A0, $1A, $59, $27, $C8, $BD ; [n't ][se][en ]a⎵n[or][ma]
    db $25 ; l
    db $75 ; line 2
    db $C9, $D2, $27, $59, $B4, $59, $1A, $59 ; [per][so]n⎵[in]⎵a⎵
    db $1F, $1E, $30, $59, $21, $2E, $27, $1D ; few⎵hund
    db $CE, $1D, $59, $32, $A2, $2C, $3E ; [re]d⎵y[ear]s!
    db $76 ; line 3
    db $0B, $1E, $2D, $59, $BE, $59, $2D, $1A ; Let⎵[me]⎵ta
    db $25, $24, $59, $DA, $59, $E3, $59, $A8 ; lk⎵[to]⎵[you]⎵[for]
    db $59, $1A, $59, $E1, $22, $25, $1E, $41 ; ⎵a⎵[wh]ile.
    db $7F ; end of message

    ; ==========================================================================
    ; Do you know about the
    ; Gargoyle statue in the village?
    ; People say they can hear a girl
    ; calling for help from under the
    ; statue.  Isn't that a strange
    ; story…
    ; --------------------------------------------------------------------------
    ; $0E2A27
    Message_007E:
    db $03, $28, $59, $E3, $59, $B8, $59, $1A ; Do⎵[you]⎵[know]⎵a
    db $98, $2E, $2D, $59, $D8 ; [bo]ut⎵[the]
    db $75 ; line 2
    db $06, $1A, $2B, $AC, $32, $25, $1E, $59 ; Gar[go]yle⎵
    db $D3, $94, $2E, $1E, $59, $B4, $59, $D8 ; [st][at]ue⎵[in]⎵[the]
    db $59, $2F, $22, $25, $BA, $20, $1E, $3F ; ⎵vil[la]ge?
    db $76 ; line 3
    db $0F, $1E, $28, $CA, $59, $2C, $1A, $32 ; Peo[ple]⎵say
    db $59, $D8, $32, $59, $99, $21, $A2, $59 ; ⎵[the]y⎵[can ]h[ear]⎵
    db $1A, $59, $20, $22, $2B, $25 ; a⎵girl
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $1A, $25, $25, $B3, $A8, $59, $21 ; call[ing ][for]⎵h
    db $1E, $25, $29, $59, $A9, $26, $59, $2E ; elp⎵[fro]m⎵u
    db $27, $1D, $A1, $D8 ; nd[er ][the]
    db $73 ; scroll text
    db $D3, $94, $2E, $1E, $41, $8A, $08, $2C ; [st][at]ue.[  ]Is
    db $C0, $D7, $2D, $59, $1A, $59, $D3, $2B ; [n't ][tha]t⎵a⎵[st]r
    db $93, $20, $1E ; [an]ge
    db $73 ; scroll text
    db $D3, $C8, $32, $43 ; [st][or]y…
    db $7F ; end of message

    ; ==========================================================================
    ; Surprisingly, the Triforce
    ; created this world to fulfill
    ; Ganon's wish.
    ; What is Ganon's wish,
    ; you ask?  It is to rule the
    ; entire cosmos!  Don't you think
    ; it might be possible with the
    ; power of the Triforce
    ; behind you?
    ; --------------------------------------------------------------------------
    ; $0E2A94
    Message_007F:
    db $12, $2E, $2B, $29, $2B, $B5, $B4, $20 ; Surpr[is][in]g
    db $25, $32, $42, $59, $D8, $59, $13, $2B ; ly,⎵[the]⎵Tr
    db $22, $A8, $1C, $1E ; i[for]ce
    db $75 ; line 2
    db $1C, $CE, $94, $A4, $D9, $2C, $59, $30 ; c[re][at][ed ][thi]s⎵w
    db $C8, $25, $1D, $59, $DA, $59, $1F, $2E ; [or]ld⎵[to]⎵fu
    db $25, $1F, $22, $25, $25 ; lfill
    db $76 ; line 3
    db $06, $93, $C7, $8B, $E2, $D1, $41 ; G[an][on]['s ][wi][sh].
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $B5, $59, $06, $93 ; W[ha]t⎵[is]⎵G[an]
    db $C7, $8B, $E2, $D1, $42 ; [on]['s ][wi][sh],
    db $73 ; scroll text
    db $E3, $59, $1A, $2C, $24, $3F, $8A, $08 ; [you]⎵ask?[  ]I
    db $2D, $59, $B5, $59, $DA, $59, $2B, $2E ; t⎵[is]⎵[to]⎵ru
    db $25, $1E, $59, $D8 ; le⎵[the]
    db $73 ; scroll text
    db $A3, $22, $CD, $1C, $28, $2C, $26, $28 ; [ent]i[re ]cosmo
    db $2C, $3E, $8A, $03, $C7, $51, $2D, $59 ; s![  ]D[on]'t⎵
    db $E3, $59, $D5, $24 ; [you]⎵[thin]k
    db $7E ; wait for key
    db $73 ; scroll text
    db $B6, $59, $26, $B2, $97, $59, $29, $28 ; [it]⎵m[ight ][be]⎵po
    db $2C, $2C, $22, $95, $59, $DE, $59, $D8 ; ssi[ble]⎵[with]⎵[the]
    db $73 ; scroll text
    db $CB, $A1, $C6, $59, $D8, $59, $13, $2B ; [pow][er ][of]⎵[the]⎵Tr
    db $22, $A8, $1C, $1E ; i[for]ce
    db $73 ; scroll text
    db $97, $B0, $27, $1D, $59, $E3, $3F ; [be][hi]nd⎵[you]?
    db $7F ; end of message

    ; ==========================================================================
    ; I once lived in the Lost Woods,
    ; until the day I wandered into a
    ; magic transporter…
    ; The power of the Dark World
    ; quickly turned me into this
    ; tree shape…
    ; I guess the two forests are
    ; connected with each other…
    ; --------------------------------------------------------------------------
    ; $0E2B27
    Message_0080:
    db $08, $59, $C7, $1C, $1E, $59, $25, $22 ; I⎵[on]ce⎵li
    db $2F, $A4, $B4, $59, $D8, $59, $0B, $28 ; v[ed ][in]⎵[the]⎵Lo
    db $D3, $59, $16, $28, $28, $1D, $2C, $42 ; [st]⎵Woods,
    db $75 ; line 2
    db $2E, $27, $2D, $22, $25, $59, $D8, $59 ; until⎵[the]⎵
    db $1D, $1A, $32, $59, $08, $59, $DF, $27 ; day⎵I⎵[wa]n
    db $1D, $A6, $A4, $B4, $DA, $59, $1A ; d[er][ed ][in][to]⎵a
    db $76 ; line 3
    db $BD, $20, $22, $1C, $59, $DB, $93, $2C ; [ma]gic⎵[tr][an]s
    db $29, $C8, $D6, $43 ; p[or][ter]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $CB, $A1, $C6, $59, $D8, $59 ; [The]⎵[pow][er ][of]⎵[the]⎵
    db $03, $1A, $2B, $24, $59, $16, $C8, $25 ; Dark⎵W[or]l
    db $1D ; d
    db $73 ; scroll text
    db $2A, $2E, $22, $9C, $B9, $2D, $2E, $2B ; qui[ck][ly ]tur
    db $27, $A4, $BE, $59, $B4, $DA, $59, $D9 ; n[ed ][me]⎵[in][to]⎵[thi]
    db $2C ; s
    db $73 ; scroll text
    db $DB, $1E, $1E, $59, $D1, $1A, $29, $1E ; [tr]ee⎵[sh]ape
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $20, $2E, $1E, $2C, $2C, $59 ; I⎵guess⎵
    db $D8, $59, $2D, $30, $28, $59, $A8, $1E ; [the]⎵two⎵[for]e
    db $D3, $2C, $59, $1A, $CE ; [st]s⎵a[re]
    db $73 ; scroll text
    db $1C, $C7, $27, $1E, $1C, $2D, $A4, $DE ; c[on]nect[ed ][with]
    db $59, $1E, $1A, $1C, $21, $59, $28, $D8 ; ⎵each⎵o[the]
    db $2B, $43 ; r…
    db $7F ; end of message

    ; ==========================================================================
    ; I heard that using Bombs is the
    ; best way to defeat the
    ; one-eyed giants.
    ; That's all I know!
    ; --------------------------------------------------------------------------
    ; $0E2BBE
    Message_0081:
    db $08, $59, $21, $A2, $1D, $59, $D7, $2D ; I⎵h[ear]d⎵[tha]t
    db $59, $2E, $2C, $B3, $01, $28, $26, $1B ; ⎵us[ing ]Bomb
    db $2C, $59, $B5, $59, $D8 ; s⎵[is]⎵[the]
    db $75 ; line 2
    db $97, $D3, $59, $DF, $32, $59, $DA, $59 ; [be][st]⎵[wa]y⎵[to]⎵
    db $1D, $1E, $1F, $1E, $91, $D8 ; defe[at ][the]
    db $76 ; line 3
    db $C7, $1E, $40, $1E, $32, $A4, $20, $22 ; [on]e-ey[ed ]gi
    db $93, $2D, $2C, $41 ; [an]ts.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E5, $2D, $8B, $8E, $08, $59, $B8, $3E ; [Tha]t['s ][all ]I⎵[know]!
    db $7F ; end of message

    ; ==========================================================================
    ; Quit bothering me!  And watch
    ; where you're going when you
    ; dash around!
    ; --------------------------------------------------------------------------
    ; $0E2BFA
    Message_0082:
    db $10, $2E, $B6, $59, $98, $D8, $2B, $B3 ; Qu[it]⎵[bo][the]r[ing ]
    db $BE, $3E, $8A, $00, $27, $1D, $59, $DF ; [me]![  ]And⎵[wa]
    db $2D, $1C, $21 ; tch
    db $75 ; line 2
    db $E1, $A6, $1E, $59, $E3, $51, $CD, $AC ; [wh][er]e⎵[you]'[re ][go]
    db $B3, $E1, $A0, $E3 ; [ing ][wh][en ][you]
    db $76 ; line 3
    db $1D, $1A, $D1, $59, $1A, $2B, $C4, $3E ; da[sh]⎵ar[ound]!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Pendant Of Power!
    ; You have now collected all
    ; three Pendants!  Go forth now
    ; to the Lost Woods for the
    ; Master Sword!
    ; --------------------------------------------------------------------------
    ; $0E2C24
    Message_0083:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0F ; [You]⎵[go]t⎵[the]⎵P
    db $A5, $1D, $93, $2D, $59, $0E, $1F, $59 ; [en]d[an]t⎵Of⎵
    db $0F, $28, $E0, $2B, $3E ; Po[we]r!
    db $75 ; line 2
    db $E8, $59, $AD, $59, $27, $28, $30, $59 ; [You]⎵[have]⎵now⎵
    db $1C, $28, $25, $25, $1E, $1C, $2D, $A4 ; collect[ed ]
    db $1A, $25, $25 ; all
    db $76 ; line 3
    db $2D, $21, $CE, $1E, $59, $0F, $A5, $1D ; th[re]e⎵P[en]d
    db $93, $2D, $2C, $3E, $8A, $06, $28, $59 ; [an]ts![  ]Go⎵
    db $A8, $2D, $21, $59, $27, $28, $30 ; [for]th⎵now
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $59, $D8, $59, $0B, $28, $D3, $59 ; [to]⎵[the]⎵Lo[st]⎵
    db $16, $28, $28, $1D, $2C, $59, $A8, $59 ; Woods⎵[for]⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $0C, $92, $A1, $12, $30, $C8, $1D, $3E ; M[ast][er ]Sw[or]d!
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Pendant Of Wisdom!
    ; Again your power has increased!
    ; Now, go for the last one!
    ; --------------------------------------------------------------------------
    ; $0E2C82
    Message_0084:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0F ; [You]⎵[go]t⎵[the]⎵P
    db $A5, $1D, $93, $2D, $59, $0E, $1F, $59 ; [en]d[an]t⎵Of⎵
    db $16, $B5, $9F, $26, $3E ; W[is][do]m!
    db $75 ; line 2
    db $00, $20, $8F, $59, $E3, $2B, $59, $CB ; Ag[ain]⎵[you]r⎵[pow]
    db $A1, $AE, $59, $B4, $1C, $CE, $1A, $D0 ; [er ][has]⎵[in]c[re]a[se]
    db $1D, $3E ; d!
    db $76 ; line 3
    db $0D, $28, $30, $42, $59, $AC, $59, $A8 ; Now,⎵[go]⎵[for]
    db $59, $D8, $59, $BA, $D3, $59, $C7, $1E ; ⎵[the]⎵[la][st]⎵[on]e
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Well howdy, Light Worlder!
    ; You look like a straight
    ; shooter…  Want to try your
    ; skill in my shooting gallery?
    ; I'll give you five shots for 20
    ; Rupees.  If you're as sharp
    ; as I think you are, you stand
    ; to rake in the Rupees.
    ; How about it, stranger?
    ;     > Play
    ;        No way
    ; --------------------------------------------------------------------------
    ; $0E2CBD
    Message_0085:
    db $16, $1E, $25, $25, $59, $21, $28, $30 ; Well⎵how
    db $1D, $32, $42, $59, $0B, $B2, $16, $C8 ; dy,⎵L[ight ]W[or]
    db $25, $1D, $A6, $3E ; ld[er]!
    db $75 ; line 2
    db $E8, $59, $BB, $28, $24, $59, $25, $22 ; [You]⎵[lo]ok⎵li
    db $24, $1E, $59, $1A, $59, $D3, $2B, $1A ; ke⎵a⎵[st]ra
    db $22, $20, $21, $2D ; ight
    db $76 ; line 3
    db $D1, $28, $28, $D6, $43, $8A, $16, $93 ; [sh]oo[ter]…[  ]W[an]
    db $2D, $59, $DA, $59, $DB, $32, $59, $E3 ; t⎵[to]⎵[tr]y⎵[you]
    db $2B ; r
    db $7E ; wait for key
    db $73 ; scroll text
    db $2C, $24, $22, $25, $25, $59, $B4, $59 ; skill⎵[in]⎵
    db $26, $32, $59, $D1, $28, $28, $2D, $B3 ; my⎵[sh]oot[ing ]
    db $20, $1A, $25, $25, $A6, $32, $3F ; gall[er]y?
    db $73 ; scroll text
    db $08, $51, $25, $25, $59, $AA, $E3, $59 ; I'll⎵[give ][you]⎵
    db $1F, $22, $2F, $1E, $59, $D1, $28, $2D ; five⎵[sh]ot
    db $2C, $59, $A8, $59, $36, $34 ; s⎵[for]⎵20
    db $73 ; scroll text
    db $11, $DC, $1E, $1E, $2C, $41, $8A, $08 ; R[up]ees.[  ]I
    db $1F, $59, $E3, $51, $CD, $1A, $2C, $59 ; f⎵[you]'[re ]as⎵
    db $D1, $1A, $2B, $29 ; [sh]arp
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $2C, $59, $08, $59, $D5, $24, $59 ; as⎵I⎵[thin]k⎵
    db $E3, $59, $1A, $CE, $42, $59, $E3, $59 ; [you]⎵a[re],⎵[you]⎵
    db $D3, $90 ; [st][and]
    db $73 ; scroll text
    db $DA, $59, $2B, $1A, $24, $1E, $59, $B4 ; [to]⎵rake⎵[in]
    db $59, $D8, $59, $11, $DC, $1E, $1E, $2C ; ⎵[the]⎵R[up]ees
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $28, $30, $59, $1A, $98, $2E, $2D ; How⎵a[bo]ut
    db $59, $B6, $42, $59, $D3, $2B, $93, $20 ; ⎵[it],⎵[st]r[an]g
    db $A6, $3F ; [er]?
    db $73 ; scroll text
    db $88, $44, $59, $0F, $BA, $32 ; [    ]>⎵P[la]y
    db $73 ; scroll text
    db $88, $89, $0D, $28, $59, $DF, $32 ; [    ][   ]No⎵[wa]y
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; All right!  Aim carefully!
    ; Ready?  GO!
    ; --------------------------------------------------------------------------
    ; $0E2D88
    Message_0086:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $3E, $8A, $00, $22, $26, $59, $1C ; t![  ]Aim⎵c
    db $1A, $CE, $1F, $2E, $25, $25, $32, $3E ; a[re]fully!
    db $75 ; line 2
    db $11, $1E, $1A, $1D, $32, $3F, $8A, $06 ; Ready?[  ]G
    db $0E, $3E ; O!
    db $7F ; end of message

    ; ==========================================================================
    ; Well little partner, you can
    ; turn yourself right around and
    ; leave the same way you 
    ; came in.
    ; See you later!  Have a nice day!
    ; --------------------------------------------------------------------------
    ; $0E2DAC
    Message_0087:
    db $16, $1E, $25, $25, $59, $25, $B6, $2D ; Well⎵l[it]t
    db $25, $1E, $59, $29, $1A, $2B, $2D, $27 ; le⎵partn
    db $A6, $42, $59, $E3, $59, $1C, $93 ; [er],⎵[you]⎵c[an]
    db $75 ; line 2
    db $2D, $2E, $2B, $27, $59, $E3, $2B, $D0 ; turn⎵[you]r[se]
    db $25, $1F, $59, $2B, $B2, $1A, $2B, $C4 ; lf⎵r[ight ]ar[ound]
    db $59, $90 ; ⎵[and]
    db $76 ; line 3
    db $25, $1E, $1A, $2F, $1E, $59, $D8, $59 ; leave⎵[the]⎵
    db $2C, $1A, $BE, $59, $DF, $32, $59, $E3 ; sa[me]⎵[wa]y⎵[you]
    db $59 ; ⎵
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $1A, $BE, $59, $B4, $41 ; ca[me]⎵[in].
    db $73 ; scroll text
    db $12, $1E, $1E, $59, $E3, $59, $BA, $D6 ; See⎵[you]⎵[la][ter]
    db $3E, $8A, $07, $1A, $2F, $1E, $59, $1A ; ![  ]Have⎵a
    db $59, $27, $22, $1C, $1E, $59, $1D, $1A ; ⎵nice⎵da
    db $32, $3E ; y!
    db $7F ; end of message

    ; ==========================================================================
    ; Want to shoot again?
    ;     > Continue
    ;        Quit
    ; --------------------------------------------------------------------------
    ; $0E2E0C
    Message_0088:
    db $16, $93, $2D, $59, $DA, $59, $D1, $28 ; W[an]t⎵[to]⎵[sh]o
    db $28, $2D, $59, $1A, $20, $8F, $3F ; ot⎵ag[ain]?
    db $75 ; line 2
    db $88, $44, $59, $02, $C7, $2D, $B4, $2E ; [    ]>⎵C[on]t[in]u
    db $1E ; e
    db $76 ; line 3
    db $88, $89, $10, $2E, $B6 ; [    ][   ]Qu[it]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; --POND OF HAPPINESS--
    ; Throw some Rupees in and your
    ; wishes will surely come true.
    ; Do you want to throw Rupees?
    ;     > Throw a few
    ;        Don't feel like it
    ; --------------------------------------------------------------------------
    ; $0E2E2D
    Message_0089:
    db $40, $40, $0F, $0E, $0D, $03, $59, $0E ; --POND⎵O
    db $05, $59, $07, $00, $0F, $0F, $08, $0D ; F⎵HAPPIN
    db $04, $12, $12, $40, $40 ; ESS--
    db $75 ; line 2
    db $13, $21, $2B, $28, $30, $59, $CF, $59 ; Throw⎵[some]⎵
    db $11, $DC, $1E, $1E, $2C, $59, $B4, $59 ; R[up]ees⎵[in]⎵
    db $8C, $E3, $2B ; [and ][you]r
    db $76 ; line 3
    db $E2, $D1, $1E, $2C, $59, $E2, $25, $25 ; [wi][sh]es⎵[wi]ll
    db $59, $2C, $2E, $CE, $B9, $9B, $1E, $59 ; ⎵su[re][ly ][com]e⎵
    db $DB, $2E, $1E, $41 ; [tr]ue.
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $DF, $27, $2D ; Do⎵[you]⎵[wa]nt
    db $59, $DA, $59, $2D, $21, $2B, $28, $30 ; ⎵[to]⎵throw
    db $59, $11, $DC, $1E, $1E, $2C, $3F ; ⎵R[up]ees?
    db $73 ; scroll text
    db $88, $44, $59, $13, $21, $2B, $28, $30 ; [    ]>⎵Throw
    db $59, $1A, $59, $1F, $1E, $30 ; ⎵a⎵few
    db $73 ; scroll text
    db $88, $89, $03, $C7, $51, $2D, $59, $1F ; [    ][   ]D[on]'t⎵f
    db $1E, $1E, $25, $59, $25, $22, $24, $1E ; eel⎵like
    db $59, $B6 ; ⎵[it]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Select an item using the
    ; Control Pad and throw it using
    ; the ⓨ Button.
    ; --------------------------------------------------------------------------
    ; $0E2EA8
    Message_008A:
    db $12, $1E, $25, $1E, $1C, $2D, $59, $93 ; Select⎵[an]
    db $59, $B6, $1E, $26, $59, $2E, $2C, $B3 ; ⎵[it]em⎵us[ing ]
    db $D8 ; [the]
    db $75 ; line 2
    db $02, $C7, $DB, $28, $25, $59, $0F, $1A ; C[on][tr]ol⎵Pa
    db $1D, $59, $8C, $2D, $21, $2B, $28, $30 ; d⎵[and ]throw
    db $59, $B6, $59, $2E, $2C, $B4, $20 ; ⎵[it]⎵us[in]g
    db $76 ; line 3
    db $D8, $59, $5E, $59, $01, $2E, $2D, $DA ; [the]⎵ⓨ⎵But[to]
    db $27, $41 ; n.
    db $69 ; choose item
    db $7F ; end of message

    ; ==========================================================================
    ; Hello there.  Did you drop this?
    ;     > Yes
    ;        No, I didn't
    ; --------------------------------------------------------------------------
    ; $0E2EDE
    Message_008B:
    db $07, $1E, $25, $BB, $59, $D8, $CE, $41 ; Hel[lo]⎵[the][re].
    db $8A, $03, $22, $1D, $59, $E3, $59, $1D ; [  ]Did⎵[you]⎵d
    db $2B, $28, $29, $59, $D9, $2C, $3F ; rop⎵[thi]s?
    db $75 ; line 2
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $76 ; line 3
    db $88, $89, $0D, $28, $42, $59, $08, $59 ; [    ][   ]No,⎵I⎵
    db $9E, $1D, $27, $51, $2D ; [di]dn't
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; I like an honest person.
    ; I will give you something better
    ; in return.
    ; --------------------------------------------------------------------------
    ; $0E2F0C
    Message_008C:
    db $08, $59, $25, $22, $24, $1E, $59, $93 ; I⎵like⎵[an]
    db $59, $21, $C7, $1E, $D3, $59, $C9, $D2 ; ⎵h[on]e[st]⎵[per][so]
    db $27, $41 ; n.
    db $75 ; line 2
    db $08, $59, $E2, $25, $25, $59, $AA, $E3 ; I⎵[wi]ll⎵[give ][you]
    db $59, $CF, $D5, $20, $59, $97, $2D, $D6 ; ⎵[some][thin]g⎵[be]t[ter]
    db $76 ; line 3
    db $B4, $59, $CE, $2D, $2E, $2B, $27, $41 ; [in]⎵[re]turn.
    db $7F ; end of message

    ; ==========================================================================
    ; Are you sure this is not yours?
    ;     > Really, it isn't
    ;        To tell the truth, it is
    ; --------------------------------------------------------------------------
    ; $0E2F39
    Message_008D:
    db $00, $CD, $E3, $59, $2C, $2E, $CD, $D9 ; A[re ][you]⎵su[re ][thi]
    db $2C, $59, $B5, $59, $C2, $59, $E3, $2B ; s⎵[is]⎵[not]⎵[you]r
    db $2C, $3F ; s?
    db $75 ; line 2
    db $88, $44, $59, $11, $1E, $1A, $25, $25 ; [    ]>⎵Reall
    db $32, $42, $59, $B6, $59, $B5, $27, $51 ; y,⎵[it]⎵[is]n'
    db $2D ; t
    db $76 ; line 3
    db $88, $89, $13, $28, $59, $2D, $1E, $25 ; [    ][   ]To⎵tel
    db $25, $59, $D8, $59, $DB, $2E, $2D, $21 ; l⎵[the]⎵[tr]uth
    db $42, $59, $B6, $59, $B5 ; ,⎵[it]⎵[is]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Now,  now, don't tell me a lie.
    ; Please take it back.
    ; --------------------------------------------------------------------------
    ; $0E2F75
    Message_008E:
    db $0D, $28, $30, $42, $8A, $27, $28, $30 ; Now,[  ]now
    db $42, $59, $9F, $C0, $2D, $1E, $25, $25 ; ,⎵[do][n't ]tell
    db $59, $BE, $59, $1A, $59, $25, $22, $1E ; ⎵[me]⎵a⎵lie
    db $41 ; .
    db $75 ; line 2
    db $0F, $25, $1E, $1A, $D0, $59, $2D, $1A ; Plea[se]⎵ta
    db $24, $1E, $59, $B6, $59, $96, $9C, $41 ; ke⎵[it]⎵[ba][ck].
    db $7F ; end of message

    ; ==========================================================================
    ; You got the Magical Boomerang!
    ; You can throw this faster and
    ; farther than your old one!
    ; --------------------------------------------------------------------------
    ; $0E2FA0
    Message_008F:
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0C ; [You]⎵[go]t⎵[the]⎵M
    db $1A, $20, $22, $1C, $1A, $25, $59, $01 ; agical⎵B
    db $28, $28, $BE, $2B, $93, $20, $3E ; oo[me]r[an]g!
    db $75 ; line 2
    db $E8, $59, $99, $2D, $21, $2B, $28, $30 ; [You]⎵[can ]throw
    db $59, $D9, $2C, $59, $1F, $92, $A1, $90 ; ⎵[thi]s⎵f[ast][er ][and]
    db $76 ; line 3
    db $1F, $1A, $2B, $D8, $2B, $59, $D7, $27 ; far[the]r⎵[tha]n
    db $59, $E3, $2B, $59, $28, $25, $1D, $59 ; ⎵[you]r⎵old⎵
    db $C7, $1E, $3E ; [on]e!
    db $7F ; end of message

    ; ==========================================================================
    ; Your shield is improved!
    ; Now you can defend yourself
    ; against fireballs!
    ; --------------------------------------------------------------------------
    ; $0E2FDD
    Message_0090:
    db $E8, $2B, $59, $D1, $22, $1E, $25, $1D ; [You]r⎵[sh]ield
    db $59, $B5, $59, $22, $26, $CC, $2F, $1E ; ⎵[is]⎵im[pro]ve
    db $1D, $3E ; d!
    db $75 ; line 2
    db $0D, $28, $30, $59, $E3, $59, $99, $1D ; Now⎵[you]⎵[can ]d
    db $1E, $1F, $A5, $1D, $59, $E3, $2B, $D0 ; ef[en]d⎵[you]r[se]
    db $25, $1F ; lf
    db $76 ; line 3
    db $1A, $20, $8F, $D3, $59, $1F, $22, $CE ; ag[ain][st]⎵fi[re]
    db $96, $25, $25, $2C, $3E ; [ba]lls!
    db $7F ; end of message

    ; ==========================================================================
    ; These are the Silver Arrows
    ; you need to defeat Ganon!
    ; --------------------------------------------------------------------------
    ; $0E3011
    Message_0091:
    db $E6, $D0, $59, $8D, $D8, $59, $12, $22 ; [The][se]⎵[are ][the]⎵Si
    db $25, $DD, $59, $00, $2B, $2B, $28, $30 ; l[ver]⎵Arrow
    db $2C ; s
    db $75 ; line 2
    db $E3, $59, $27, $1E, $A4, $DA, $59, $1D ; [you]⎵ne[ed ][to]⎵d
    db $1E, $1F, $1E, $91, $06, $93, $C7, $3E ; efe[at ]G[an][on]!
    db $7F ; end of message

    ; ==========================================================================
    ; She filled your bottle with the
    ; Medicine Of Magic.  To get such
    ; a potion free is quite
    ; a bargain!
    ; --------------------------------------------------------------------------
    ; $0E3034
    Message_0092:
    db $12, $21, $1E, $59, $1F, $22, $25, $25 ; She⎵fill
    db $A4, $E3, $2B, $59, $98, $2D, $2D, $25 ; [ed ][you]r⎵[bo]ttl
    db $1E, $59, $DE, $59, $D8 ; e⎵[with]⎵[the]
    db $75 ; line 2
    db $0C, $1E, $9E, $1C, $B4, $1E, $59, $0E ; Me[di]c[in]e⎵O
    db $1F, $59, $0C, $1A, $20, $22, $1C, $41 ; f⎵Magic.
    db $8A, $13, $28, $59, $AB, $59, $2C, $2E ; [  ]To⎵[get]⎵su
    db $1C, $21 ; ch
    db $76 ; line 3
    db $1A, $59, $29, $28, $2D, $22, $C7, $59 ; a⎵poti[on]⎵
    db $1F, $CE, $1E, $59, $B5, $59, $2A, $2E ; f[re]e⎵[is]⎵qu
    db $B6, $1E ; [it]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $59, $96, $2B, $20, $8F, $3E ; a⎵[ba]rg[ain]!
    db $7F ; end of message

    ; ==========================================================================
    ; Your sword is stronger!
    ; You can feel its power
    ; throbbing in your hand!
    ; --------------------------------------------------------------------------
    ; $0E3081
    Message_0093:
    db $E8, $2B, $59, $2C, $30, $C8, $1D, $59 ; [You]r⎵sw[or]d⎵
    db $B5, $59, $D3, $2B, $C7, $20, $A6, $3E ; [is]⎵[st]r[on]g[er]!
    db $75 ; line 2
    db $E8, $59, $99, $1F, $1E, $1E, $25, $59 ; [You]⎵[can ]feel⎵
    db $B6, $2C, $59, $CB, $A6 ; [it]s⎵[pow][er]
    db $76 ; line 3
    db $2D, $21, $2B, $28, $1B, $1B, $B3, $B4 ; throbb[ing ][in]
    db $59, $E3, $2B, $59, $B1, $27, $1D, $3E ; ⎵[you]r⎵[ha]nd!
    db $7F ; end of message

    ; ==========================================================================
    ; Happiness increased [#3][#2] Rupees.
    ; In total, your Happiness is [#1][#0].
    ; You became happier by one
    ; step.
    ; --------------------------------------------------------------------------
    ; $0E30B1
    Message_0094:
    db $07, $1A, $29, $29, $B4, $1E, $2C, $2C ; Happ[in]ess
    db $59, $B4, $1C, $CE, $1A, $D0, $1D, $59 ; ⎵[in]c[re]a[se]d⎵
    db $6C, $03, $6C, $02, $59, $11, $DC, $1E ; [#3][#2]⎵R[up]e
    db $1E, $2C, $41 ; es.
    db $75 ; line 2
    db $08, $27, $59, $DA, $2D, $1A, $25, $42 ; In⎵[to]tal,
    db $59, $E3, $2B, $59, $07, $1A, $29, $29 ; ⎵[you]r⎵Happ
    db $B4, $1E, $2C, $2C, $59, $B5, $59 ; [in]ess⎵[is]⎵
    db $6C, $01, $6C, $00, $41 ; [#1][#0].
    db $76 ; line 3
    db $E8, $59, $97, $1C, $1A, $BE, $59, $B1 ; [You]⎵[be]ca[me]⎵[ha]
    db $29, $29, $22, $A1, $1B, $32, $59, $C7 ; ppi[er ]by⎵[on]
    db $1E ; e
    db $7E ; wait for key
    db $73 ; scroll text
    db $D3, $1E, $29, $41 ; [st]ep.
    db $7F ; end of message

    ; ==========================================================================
    ; I will make your wish come true.
    ;   >I want to carry more Bombs
    ;     I want to carry more Arrows
    ; --------------------------------------------------------------------------
    ; $0E3102
    Message_0095:
    db $08, $59, $E2, $25, $25, $59, $BD, $24 ; I⎵[wi]ll⎵[ma]k
    db $1E, $59, $E3, $2B, $59, $E2, $D1, $59 ; e⎵[you]r⎵[wi][sh]⎵
    db $9B, $1E, $59, $DB, $2E, $1E, $41 ; [com]e⎵[tr]ue.
    db $75 ; line 2
    db $8A, $44, $08, $59, $DF, $27, $2D, $59 ; [  ]>I⎵[wa]nt⎵
    db $DA, $59, $1C, $1A, $2B, $2B, $32, $59 ; [to]⎵carry⎵
    db $26, $C8, $1E, $59, $01, $28, $26, $1B ; m[or]e⎵Bomb
    db $2C ; s
    db $76 ; line 3
    db $88, $08, $59, $DF, $27, $2D, $59, $DA ; [    ]I⎵[wa]nt⎵[to]
    db $59, $1C, $1A, $2B, $2B, $32, $59, $26 ; ⎵carry⎵m
    db $C8, $1E, $59, $00, $2B, $2B, $28, $30 ; [or]e⎵Arrow
    db $2C ; s
    db $6F ; choose 2 low
    db $7F ; end of message

    ; ==========================================================================
    ; Then I will increase your
    ; carrying ability so you can
    ; carry [#1][#0] Bombs at maximum.
    ; This is just a small happiness
    ; I can give to you.
    ; --------------------------------------------------------------------------
    ; $0E314F
    Message_0096:
    db $E6, $27, $59, $08, $59, $E2, $25, $25 ; [The]n⎵I⎵[wi]ll
    db $59, $B4, $1C, $CE, $1A, $D0, $59, $E3 ; ⎵[in]c[re]a[se]⎵[you]
    db $2B ; r
    db $75 ; line 2
    db $1C, $1A, $2B, $2B, $32, $B3, $1A, $1B ; carry[ing ]ab
    db $22, $25, $B6, $32, $59, $D2, $59, $E3 ; il[it]y⎵[so]⎵[you]
    db $59, $1C, $93 ; ⎵c[an]
    db $76 ; line 3
    db $1C, $1A, $2B, $2B, $32, $59, $6C, $01 ; carry⎵[#1]
    db $6C, $00, $59, $01, $28, $26, $1B, $2C ; [#0]⎵Bombs
    db $59, $91, $BD, $31, $22, $BF, $26, $41 ; ⎵[at ][ma]xi[mu]m.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $B7, $59, $1A ; [Thi]s⎵[is]⎵[just]⎵a
    db $59, $2C, $BD, $25, $25, $59, $B1, $29 ; ⎵s[ma]ll⎵[ha]p
    db $29, $B4, $1E, $2C, $2C ; p[in]ess
    db $73 ; scroll text
    db $08, $59, $99, $AA, $DA, $59, $E3, $41 ; I⎵[can ][give ][to]⎵[you].
    db $7F ; end of message

    ; ==========================================================================
    ; Then I will increase your
    ; carrying ability so you can
    ; carry [#1][#0] Arrows at maximum.
    ; This is just a small happiness
    ; I can give to you.
    ; --------------------------------------------------------------------------
    ; $0E31AE
    Message_0097:
    db $E6, $27, $59, $08, $59, $E2, $25, $25 ; [The]n⎵I⎵[wi]ll
    db $59, $B4, $1C, $CE, $1A, $D0, $59, $E3 ; ⎵[in]c[re]a[se]⎵[you]
    db $2B ; r
    db $75 ; line 2
    db $1C, $1A, $2B, $2B, $32, $B3, $1A, $1B ; carry[ing ]ab
    db $22, $25, $B6, $32, $59, $D2, $59, $E3 ; il[it]y⎵[so]⎵[you]
    db $59, $1C, $93 ; ⎵c[an]
    db $76 ; line 3
    db $1C, $1A, $2B, $2B, $32, $59, $6C, $01 ; carry⎵[#1]
    db $6C, $00, $59, $00, $2B, $2B, $28, $30 ; [#0]⎵Arrow
    db $2C, $59, $91, $BD, $31, $22, $BF, $26 ; s⎵[at ][ma]xi[mu]m
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $B7, $59, $1A ; [Thi]s⎵[is]⎵[just]⎵a
    db $59, $2C, $BD, $25, $25, $59, $B1, $29 ; ⎵s[ma]ll⎵[ha]p
    db $29, $B4, $1E, $2C, $2C ; p[in]ess
    db $73 ; scroll text
    db $08, $59, $99, $AA, $DA, $59, $E3, $41 ; I⎵[can ][give ][to]⎵[you].
    db $7F ; end of message

    ; ==========================================================================
    ; I cannot grant any more wishes
    ; for you, but a friend of mine
    ; might be able to…
    ; She lives in the Waterfall Of
    ; Wishing near Zora's lake.
    ; I will return your Rupees to
    ; you.  May you be happy…
    ; --------------------------------------------------------------------------
    ; $0E320E
    Message_0098:
    db $08, $59, $1C, $93, $C2, $59, $20, $2B ; I⎵c[an][not]⎵gr
    db $93, $2D, $59, $93, $32, $59, $26, $C8 ; [an]t⎵[an]y⎵m[or]
    db $1E, $59, $E2, $D1, $1E, $2C ; e⎵[wi][sh]es
    db $75 ; line 2
    db $A8, $59, $E3, $42, $59, $1B, $2E, $2D ; [for]⎵[you],⎵but
    db $59, $1A, $59, $1F, $2B, $22, $A5, $1D ; ⎵a⎵fri[en]d
    db $59, $C6, $59, $26, $B4, $1E ; ⎵[of]⎵m[in]e
    db $76 ; line 3
    db $26, $B2, $97, $59, $1A, $95, $59, $DA ; m[ight ][be]⎵a[ble]⎵[to]
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $12, $21, $1E, $59, $25, $22, $2F, $1E ; She⎵live
    db $2C, $59, $B4, $59, $D8, $59, $16, $94 ; s⎵[in]⎵[the]⎵W[at]
    db $A6, $1F, $8E, $0E, $1F ; [er]f[all ]Of
    db $73 ; scroll text
    db $16, $B5, $B0, $27, $20, $59, $27, $A2 ; W[is][hi]ng⎵n[ear]
    db $59, $19, $C8, $1A, $8B, $BA, $24, $1E ; ⎵Z[or]a['s ][la]ke
    db $41 ; .
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $CE, $2D ; I⎵[wi]ll⎵[re]t
    db $2E, $2B, $27, $59, $E3, $2B, $59, $11 ; urn⎵[you]r⎵R
    db $DC, $1E, $1E, $2C, $59, $DA ; [up]ees⎵[to]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E3, $41, $8A, $0C, $1A, $32, $59, $E3 ; [you].[  ]May⎵[you]
    db $59, $97, $59, $B1, $29, $29, $32, $43 ; ⎵[be]⎵[ha]ppy…
    db $7F ; end of message

    ; ==========================================================================
    ; Uhhh…  Watch your step.
    ; There are holes in the ground.
    ; Could you turn right here?
    ; Young man, are you also going
    ; to the mountain to look for the
    ; Golden Power?
    ; Just ahead is a mountain full
    ; of monsters.  Many people have
    ; vanished in this mountain while
    ; looking for the Golden Power.
    ; 
    ; 
    ; I don't want to steer you
    ; wrong, so please don't get too
    ; involved in such a mad quest.
    ; --------------------------------------------------------------------------
    ; $0E3298
    Message_0099:
    db $14, $21, $21, $21, $43, $8A, $16, $94 ; Uhhh…[  ]W[at]
    db $1C, $21, $59, $E3, $2B, $59, $D3, $1E ; ch⎵[you]r⎵[st]e
    db $29, $41 ; p.
    db $75 ; line 2
    db $E6, $CD, $8D, $21, $28, $25, $1E, $2C ; [The][re ][are ]holes
    db $59, $B4, $59, $D8, $59, $20, $2B, $C4 ; ⎵[in]⎵[the]⎵gr[ound]
    db $41 ; .
    db $76 ; line 3
    db $02, $28, $2E, $25, $1D, $59, $E3, $59 ; Could⎵[you]⎵
    db $2D, $2E, $2B, $27, $59, $2B, $B2, $AF ; turn⎵r[ight ][her]
    db $1E, $3F ; e?
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $27, $20, $59, $BC, $42, $59, $8D ; [You]ng⎵[man],⎵[are ]
    db $E3, $59, $1A, $25, $D2, $59, $AC, $B4 ; [you]⎵al[so]⎵[go][in]
    db $20 ; g
    db $73 ; scroll text
    db $DA, $59, $D8, $59, $26, $28, $2E, $27 ; [to]⎵[the]⎵moun
    db $2D, $8F, $59, $DA, $59, $BB, $28, $24 ; t[ain]⎵[to]⎵[lo]ok
    db $59, $A8, $59, $D8 ; ⎵[for]⎵[the]
    db $73 ; scroll text
    db $06, $28, $25, $1D, $A0, $0F, $28, $E0 ; Gold[en ]Po[we]
    db $2B, $3F ; r?
    db $7E ; wait for key
    db $73 ; scroll text
    db $09, $2E, $D3, $59, $1A, $21, $1E, $1A ; Ju[st]⎵ahea
    db $1D, $59, $B5, $59, $1A, $59, $26, $28 ; d⎵[is]⎵a⎵mo
    db $2E, $27, $2D, $8F, $59, $1F, $2E, $25 ; unt[ain]⎵ful
    db $25 ; l
    db $73 ; scroll text
    db $C6, $59, $26, $C7, $D3, $A6, $2C, $41 ; [of]⎵m[on][st][er]s.
    db $8A, $0C, $93, $32, $59, $29, $1E, $28 ; [  ]M[an]y⎵peo
    db $CA, $59, $AD ; [ple]⎵[have]
    db $73 ; scroll text
    db $2F, $93, $B5, $21, $A4, $B4, $59, $D9 ; v[an][is]h[ed ][in]⎵[thi]
    db $2C, $59, $26, $28, $2E, $27, $2D, $8F ; s⎵mount[ain]
    db $59, $E1, $22, $25, $1E ; ⎵[wh]ile
    db $7E ; wait for key
    db $73 ; scroll text
    db $BB, $28, $24, $B3, $A8, $59, $D8, $59 ; [lo]ok[ing ][for]⎵[the]⎵
    db $06, $28, $25, $1D, $A0, $0F, $28, $E0 ; Gold[en ]Po[we]
    db $2B, $41 ; r.
    db $73 ; scroll text
    db $73 ; scroll text
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $9F, $C0, $DF, $27, $2D, $59 ; I⎵[do][n't ][wa]nt⎵
    db $DA, $59, $D3, $1E, $A1, $E3 ; [to]⎵[st]e[er ][you]
    db $73 ; scroll text
    db $30, $2B, $C7, $20, $42, $59, $D2, $59 ; wr[on]g,⎵[so]⎵
    db $CA, $1A, $D0, $59, $9F, $C0, $AB, $59 ; [ple]a[se]⎵[do][n't ][get]⎵
    db $DA, $28 ; [to]o
    db $73 ; scroll text
    db $B4, $2F, $28, $25, $2F, $A4, $B4, $59 ; [in]volv[ed ][in]⎵
    db $2C, $2E, $1C, $21, $59, $1A, $59, $BD ; such⎵a⎵[ma]
    db $1D, $59, $2A, $2E, $1E, $D3, $41 ; d⎵que[st].
    db $7F ; end of message

    ; ==========================================================================
    ; Uhh…  There must be a Heart in
    ; the bottle.
    ; --------------------------------------------------------------------------
    ; $0E3399
    Message_009A:
    db $14, $21, $21, $43, $8A, $E6, $CD, $BF ; Uhh…[  ][The][re ][mu]
    db $D3, $59, $97, $59, $1A, $59, $07, $A2 ; [st]⎵[be]⎵a⎵H[ear]
    db $2D, $59, $B4 ; t⎵[in]
    db $75 ; line 2
    db $D8, $59, $98, $2D, $2D, $25, $1E, $41 ; [the]⎵[bo]ttle.
    db $7F ; end of message

    ; ==========================================================================
    ; Uhh…  Turn right here…   …
    ; You know, I have a
    ; granddaughter who is your
    ; age…  The King took her to the
    ; castle and she never returned.
    ; Kidnapping those maidens must
    ; be part of the wizard's plot!
    ; I'm sure he is trying to
    ; somehow use the power of the
    ; descendants of the wise
    ; men…
    ; --------------------------------------------------------------------------
    ; $0E33B6
    Message_009B:
    db $14, $21, $21, $43, $8A, $13, $2E, $2B ; Uhh…[  ]Tur
    db $27, $59, $2B, $B2, $AF, $1E, $43, $89 ; n⎵r[ight ][her]e…[   ]
    db $43 ; …
    db $75 ; line 2
    db $E8, $59, $B8, $42, $59, $08, $59, $AD ; [You]⎵[know],⎵I⎵[have]
    db $59, $1A ; ⎵a
    db $76 ; line 3
    db $20, $2B, $90, $1D, $1A, $2E, $20, $21 ; gr[and]daugh
    db $D4, $E1, $28, $59, $B5, $59, $E3, $2B ; [ter ][wh]o⎵[is]⎵[you]r
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $20, $1E, $43, $8A, $E6, $59, $0A ; age…[  ][The]⎵K
    db $B3, $DA, $28, $24, $59, $AF, $59, $DA ; [ing ][to]ok⎵[her]⎵[to]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $1C, $92, $25, $1E, $59, $8C, $D1, $1E ; c[ast]le⎵[and ][sh]e
    db $59, $27, $A7, $A1, $CE, $2D, $2E, $2B ; ⎵n[ev][er ][re]tur
    db $27, $1E, $1D, $41 ; ned.
    db $73 ; scroll text
    db $0A, $22, $1D, $27, $1A, $29, $29, $B3 ; Kidnapp[ing ]
    db $2D, $21, $28, $D0, $59, $BD, $22, $1D ; tho[se]⎵[ma]id
    db $A5, $2C, $59, $BF, $D3 ; [en]s⎵[mu][st]
    db $7E ; wait for key
    db $73 ; scroll text
    db $97, $59, $29, $1A, $2B, $2D, $59, $C6 ; [be]⎵part⎵[of]
    db $59, $D8, $59, $E2, $33, $1A, $2B, $1D ; ⎵[the]⎵[wi]zard
    db $8B, $29, $BB, $2D, $3E ; ['s ]p[lo]t!
    db $73 ; scroll text
    db $08, $51, $26, $59, $2C, $2E, $CD, $21 ; I'm⎵su[re ]h
    db $1E, $59, $B5, $59, $DB, $32, $B3, $DA ; e⎵[is]⎵[tr]y[ing ][to]
    db $73 ; scroll text
    db $CF, $21, $28, $30, $59, $2E, $D0, $59 ; [some]how⎵u[se]⎵
    db $D8, $59, $CB, $A1, $C6, $59, $D8 ; [the]⎵[pow][er ][of]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $9D, $1C, $A5, $1D, $93, $2D, $2C, $59 ; [des]c[en]d[an]ts⎵
    db $C6, $59, $D8, $59, $E2, $D0 ; [of]⎵[the]⎵[wi][se]
    db $73 ; scroll text
    db $BE, $27, $43 ; [me]n…
    db $7F ; end of message

    ; ==========================================================================
    ; I don't know who you are, but
    ; if you are going to go up
    ; the mountain, will you take me
    ; with you?  I lost my lamp,
    ; so…
    ; --------------------------------------------------------------------------
    ; $0E346F
    Message_009C:
    db $08, $59, $9F, $C0, $B8, $59, $E1, $28 ; I⎵[do][n't ][know]⎵[wh]o
    db $59, $E3, $59, $1A, $CE, $42, $59, $1B ; ⎵[you]⎵a[re],⎵b
    db $2E, $2D ; ut
    db $75 ; line 2
    db $22, $1F, $59, $E3, $59, $8D, $AC, $B3 ; if⎵[you]⎵[are ][go][ing ]
    db $DA, $59, $AC, $59, $DC ; [to]⎵[go]⎵[up]
    db $76 ; line 3
    db $D8, $59, $26, $28, $2E, $27, $2D, $8F ; [the]⎵mount[ain]
    db $42, $59, $E2, $25, $25, $59, $E3, $59 ; ,⎵[wi]ll⎵[you]⎵
    db $2D, $1A, $24, $1E, $59, $BE ; take⎵[me]
    db $7E ; wait for key
    db $73 ; scroll text
    db $DE, $59, $E3, $3F, $8A, $08, $59, $BB ; [with]⎵[you]?[  ]I⎵[lo]
    db $D3, $59, $26, $32, $59, $BA, $26, $29 ; [st]⎵my⎵[la]mp
    db $42 ; ,
    db $73 ; scroll text
    db $D2, $43 ; [so]…
    db $7F ; end of message

    ; ==========================================================================
    ; The missing maidens are still
    ; alive somewhere.  I believe that
    ; a Hero will rescue them…
    ; I wait for that day…
    ; Uhh…  These are dangerous
    ; times…  I talked too much.
    ; Anyway…  Thank you for your
    ; kindness to an old man like me.
    ; Uhh…  I wanted to give you
    ; this.  If you wander into
    ; a magical transporter, gaze
    ; into this mirror.
    ; --------------------------------------------------------------------------
    ; $0E34BD
    Message_009D:
    db $E6, $59, $26, $B5, $2C, $B3, $BD, $22 ; [The]⎵m[is]s[ing ][ma]i
    db $1D, $A5, $2C, $59, $8D, $D3, $22, $25 ; d[en]s⎵[are ][st]il
    db $25 ; l
    db $75 ; line 2
    db $1A, $25, $22, $2F, $1E, $59, $CF, $E1 ; alive⎵[some][wh]
    db $A6, $1E, $41, $8A, $08, $59, $97, $25 ; [er]e.[  ]I⎵[be]l
    db $22, $A7, $1E, $59, $D7, $2D ; i[ev]e⎵[tha]t
    db $76 ; line 3
    db $1A, $59, $E4, $28, $59, $E2, $25, $25 ; a⎵[Her]o⎵[wi]ll
    db $59, $CE, $2C, $1C, $2E, $1E, $59, $D8 ; ⎵[re]scue⎵[the]
    db $26, $43 ; m…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $DF, $B6, $59, $A8, $59, $D7 ; I⎵[wa][it]⎵[for]⎵[tha]
    db $2D, $59, $1D, $1A, $32, $43 ; t⎵day…
    db $73 ; scroll text
    db $14, $21, $21, $43, $8A, $E6, $D0, $59 ; Uhh…[  ][The][se]⎵
    db $8D, $1D, $93, $20, $A6, $28, $2E, $2C ; [are ]d[an]g[er]ous
    db $73 ; scroll text
    db $2D, $22, $BE, $2C, $43, $8A, $08, $59 ; ti[me]s…[  ]I⎵
    db $2D, $1A, $25, $24, $A4, $DA, $28, $59 ; talk[ed ][to]o⎵
    db $BF, $1C, $21, $41 ; [mu]ch.
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $27, $32, $DF, $32, $43, $8A, $E5 ; Any[wa]y…[  ][Tha]
    db $27, $24, $59, $E3, $59, $A8, $59, $E3 ; nk⎵[you]⎵[for]⎵[you]
    db $2B ; r
    db $73 ; scroll text
    db $24, $B4, $1D, $27, $1E, $2C, $2C, $59 ; k[in]dness⎵
    db $DA, $59, $93, $59, $28, $25, $1D, $59 ; [to]⎵[an]⎵old⎵
    db $BC, $59, $25, $22, $24, $1E, $59, $BE ; [man]⎵like⎵[me]
    db $41 ; .
    db $73 ; scroll text
    db $14, $21, $21, $43, $8A, $08, $59, $DF ; Uhh…[  ]I⎵[wa]
    db $27, $2D, $A4, $DA, $59, $AA, $E3 ; nt[ed ][to]⎵[give ][you]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D9, $2C, $41, $8A, $08, $1F, $59, $E3 ; [thi]s.[  ]If⎵[you]
    db $59, $DF, $27, $1D, $A1, $B4, $DA ; ⎵[wa]nd[er ][in][to]
    db $73 ; scroll text
    db $1A, $59, $BD, $20, $22, $1C, $1A, $25 ; a⎵[ma]gical
    db $59, $DB, $93, $2C, $29, $C8, $D6, $42 ; ⎵[tr][an]sp[or][ter],
    db $59, $20, $1A, $33, $1E ; ⎵gaze
    db $73 ; scroll text
    db $B4, $DA, $59, $D9, $2C, $59, $26, $22 ; [in][to]⎵[thi]s⎵mi
    db $2B, $2B, $C8, $41 ; rr[or].
    db $7F ; end of message

    ; ==========================================================================
    ; The wizard has deceived the
    ; King, and now he is trying to
    ; open the way to the
    ; Dark World.  To complete
    ; your quest, you will need
    ; the Moon Pearl, which is in the
    ; tower on top of the mountain.
    ; All I can do for you now is to
    ; comfort your weariness…
    ; Come back here any time.
    ; --------------------------------------------------------------------------
    ; $0E35A0
    Message_009E:
    db $E6, $59, $E2, $33, $1A, $2B, $1D, $59 ; [The]⎵[wi]zard⎵
    db $AE, $59, $1D, $1E, $1C, $1E, $22, $2F ; [has]⎵deceiv
    db $A4, $D8 ; [ed ][the]
    db $75 ; line 2
    db $0A, $B4, $20, $42, $59, $8C, $27, $28 ; K[in]g,⎵[and ]no
    db $30, $59, $21, $1E, $59, $B5, $59, $DB ; w⎵he⎵[is]⎵[tr]
    db $32, $B3, $DA ; y[ing ][to]
    db $76 ; line 3
    db $C3, $59, $D8, $59, $DF, $32, $59, $DA ; [open]⎵[the]⎵[wa]y⎵[to]
    db $59, $D8 ; ⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $1A, $2B, $24, $59, $16, $C8, $25 ; Dark⎵W[or]l
    db $1D, $41, $8A, $13, $28, $59, $9B, $CA ; d.[  ]To⎵[com][ple]
    db $2D, $1E ; te
    db $73 ; scroll text
    db $E3, $2B, $59, $2A, $2E, $1E, $D3, $42 ; [you]r⎵que[st],
    db $59, $E3, $59, $E2, $25, $25, $59, $27 ; ⎵[you]⎵[wi]ll⎵n
    db $1E, $1E, $1D ; eed
    db $73 ; scroll text
    db $D8, $59, $0C, $28, $C7, $59, $0F, $A2 ; [the]⎵Mo[on]⎵P[ear]
    db $25, $42, $59, $E1, $22, $1C, $21, $59 ; l,⎵[wh]ich⎵
    db $B5, $59, $B4, $59, $D8 ; [is]⎵[in]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $E0, $2B, $59, $C7, $59, $DA, $29 ; [to][we]r⎵[on]⎵[to]p
    db $59, $C6, $59, $D8, $59, $26, $28, $2E ; ⎵[of]⎵[the]⎵mou
    db $27, $2D, $8F, $41 ; nt[ain].
    db $73 ; scroll text
    db $00, $25, $25, $59, $08, $59, $99, $9F ; All⎵I⎵[can ][do]
    db $59, $A8, $59, $E3, $59, $27, $28, $30 ; ⎵[for]⎵[you]⎵now
    db $59, $B5, $59, $DA ; ⎵[is]⎵[to]
    db $73 ; scroll text
    db $9B, $A8, $2D, $59, $E3, $2B, $59, $E0 ; [com][for]t⎵[you]r⎵[we]
    db $1A, $2B, $B4, $1E, $2C, $2C, $43 ; ar[in]ess…
    db $7E ; wait for key
    db $73 ; scroll text
    db $02, $28, $BE, $59, $96, $9C, $59, $AF ; Co[me]⎵[ba][ck]⎵[her]
    db $1E, $59, $93, $32, $59, $2D, $22, $BE ; e⎵[an]y⎵ti[me]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; The Moon Pearl will protect its
    ; bearer from the magical air of
    ; the Golden Land, so you can
    ; keep your human shape there.
    ; All I can do for you now is
    ; comfort your weariness… 
    ; Come back here any time.
    ; --------------------------------------------------------------------------
    ; $0E365E
    Message_009F:
    db $74 ; line 1
    db $E6, $59, $0C, $28, $C7, $59, $0F, $A2 ; [The]⎵Mo[on]⎵P[ear]
    db $25, $59, $E2, $25, $25, $59, $CC, $2D ; l⎵[wi]ll⎵[pro]t
    db $1E, $1C, $2D, $59, $B6, $2C ; ect⎵[it]s
    db $75 ; line 2
    db $97, $1A, $CE, $2B, $59, $A9, $26, $59 ; [be]a[re]r⎵[fro]m⎵
    db $D8, $59, $BD, $20, $22, $1C, $1A, $25 ; [the]⎵[ma]gical
    db $59, $1A, $22, $2B, $59, $C6 ; ⎵air⎵[of]
    db $76 ; line 3
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $90, $42, $59, $D2, $59, $E3, $59, $1C ; [and],⎵[so]⎵[you]⎵c
    db $93 ; [an]
    db $7E ; wait for key
    db $73 ; scroll text
    db $24, $1E, $1E, $29, $59, $E3, $2B, $59 ; keep⎵[you]r⎵
    db $21, $2E, $BC, $59, $D1, $1A, $29, $1E ; hu[man]⎵[sh]ape
    db $59, $D8, $CE, $41 ; ⎵[the][re].
    db $73 ; scroll text
    db $00, $25, $25, $59, $08, $59, $99, $9F ; All⎵I⎵[can ][do]
    db $59, $A8, $59, $E3, $59, $27, $28, $30 ; ⎵[for]⎵[you]⎵now
    db $59, $B5 ; ⎵[is]
    db $73 ; scroll text
    db $9B, $A8, $2D, $59, $E3, $2B, $59, $E0 ; [com][for]t⎵[you]r⎵[we]
    db $1A, $2B, $B4, $1E, $2C, $2C, $43, $59 ; ar[in]ess…⎵
    db $7E ; wait for key
    db $73 ; scroll text
    db $02, $28, $BE, $59, $96, $9C, $59, $AF ; Co[me]⎵[ba][ck]⎵[her]
    db $1E, $59, $93, $32, $59, $2D, $22, $BE ; e⎵[an]y⎵ti[me]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], I think the wizard
    ; connected the two worlds
    ; somewhere around the castle.
    ; All I can do for you now is to
    ; comfort your weariness…
    ; Come back here any time.
    ; --------------------------------------------------------------------------
    ; $0E36EC
    Message_00A0:
    db $6A, $42, $59, $08, $59, $D5, $24, $59 ; [LINK],⎵I⎵[thin]k⎵
    db $D8, $59, $E2, $33, $1A, $2B, $1D ; [the]⎵[wi]zard
    db $75 ; line 2
    db $1C, $C7, $27, $1E, $1C, $2D, $A4, $D8 ; c[on]nect[ed ][the]
    db $59, $2D, $30, $28, $59, $30, $C8, $25 ; ⎵two⎵w[or]l
    db $1D, $2C ; ds
    db $76 ; line 3
    db $CF, $E1, $A6, $1E, $59, $1A, $2B, $C4 ; [some][wh][er]e⎵ar[ound]
    db $59, $D8, $59, $1C, $92, $25, $1E, $41 ; ⎵[the]⎵c[ast]le.
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $25, $25, $59, $08, $59, $99, $9F ; All⎵I⎵[can ][do]
    db $59, $A8, $59, $E3, $59, $27, $28, $30 ; ⎵[for]⎵[you]⎵now
    db $59, $B5, $59, $DA ; ⎵[is]⎵[to]
    db $73 ; scroll text
    db $9B, $A8, $2D, $59, $E3, $2B, $59, $E0 ; [com][for]t⎵[you]r⎵[we]
    db $1A, $2B, $B4, $1E, $2C, $2C, $43 ; ar[in]ess…
    db $73 ; scroll text
    db $02, $28, $BE, $59, $96, $9C, $59, $AF ; Co[me]⎵[ba][ck]⎵[her]
    db $1E, $59, $93, $32, $59, $2D, $22, $BE ; e⎵[an]y⎵ti[me]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; …mumble mumble…  My son
    ; really liked to play the flute,
    ; but he went to look for the
    ; Golden Power and has not
    ; returned… … …
    ; I wonder where he is and what
    ; he is doing now?…
    ; …  Zzzzzz  Zzzzzz
    ; --------------------------------------------------------------------------
    ; $0E3758
    Message_00A1:
    db $43, $BF, $26, $95, $59, $BF, $26, $95 ; …[mu]m[ble]⎵[mu]m[ble]
    db $43, $8A, $0C, $32, $59, $D2, $27 ; …[  ]My⎵[so]n
    db $75 ; line 2
    db $CE, $1A, $25, $B9, $25, $22, $24, $A4 ; [re]al[ly ]lik[ed ]
    db $DA, $59, $29, $BA, $32, $59, $D8, $59 ; [to]⎵p[la]y⎵[the]⎵
    db $1F, $25, $2E, $2D, $1E, $42 ; flute,
    db $76 ; line 3
    db $1B, $2E, $2D, $59, $21, $1E, $59, $E0 ; but⎵he⎵[we]
    db $27, $2D, $59, $DA, $59, $BB, $28, $24 ; nt⎵[to]⎵[lo]ok
    db $59, $A8, $59, $D8 ; ⎵[for]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $28, $25, $1D, $A0, $0F, $28, $E0 ; Gold[en ]Po[we]
    db $2B, $59, $8C, $AE, $59, $C2 ; r⎵[and ][has]⎵[not]
    db $73 ; scroll text
    db $CE, $2D, $2E, $2B, $27, $1E, $1D, $43 ; [re]turned…
    db $59, $43, $59, $43 ; ⎵…⎵…
    db $73 ; scroll text
    db $08, $59, $30, $C7, $1D, $A1, $E1, $A6 ; I⎵w[on]d[er ][wh][er]
    db $1E, $59, $21, $1E, $59, $B5, $59, $8C ; e⎵he⎵[is]⎵[and ]
    db $E1, $94 ; [wh][at]
    db $7E ; wait for key
    db $73 ; scroll text
    db $21, $1E, $59, $B5, $59, $9F, $B3, $27 ; he⎵[is]⎵[do][ing ]n
    db $28, $30, $3F, $43 ; ow?…
    db $73 ; scroll text
    db $43, $8A, $19, $33, $33, $33, $33, $33 ; …[  ]Zzzzzz
    db $8A, $19, $33, $33, $33, $33, $33 ; [  ]Zzzzzz
    db $7F ; end of message

    ; ==========================================================================
    ; …mumble mumble…  Oh?  This
    ; is my son's flute…!
    ; Did you meet my son?
    ; Where is he?  Is he all right?
    ; … … … …
    ; 
    ; Oh, I see…  Well, I can tell
    ; what you want to say by the
    ; look in your eyes…
    ; --------------------------------------------------------------------------
    ; $0E37E2
    Message_00A2:
    db $43, $BF, $26, $95, $59, $BF, $26, $95 ; …[mu]m[ble]⎵[mu]m[ble]
    db $43, $8A, $0E, $21, $3F, $8A, $E7, $2C ; …[  ]Oh?[  ][Thi]s
    db $75 ; line 2
    db $B5, $59, $26, $32, $59, $D2, $27, $8B ; [is]⎵my⎵[so]n['s ]
    db $1F, $25, $2E, $2D, $1E, $43, $3E ; flute…!
    db $76 ; line 3
    db $03, $22, $1D, $59, $E3, $59, $BE, $1E ; Did⎵[you]⎵[me]e
    db $2D, $59, $26, $32, $59, $D2, $27, $3F ; t⎵my⎵[so]n?
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $AF, $1E, $59, $B5, $59, $21, $1E ; W[her]e⎵[is]⎵he
    db $3F, $8A, $08, $2C, $59, $21, $1E, $59 ; ?[  ]Is⎵he⎵
    db $8E, $2B, $22, $20, $21, $2D, $3F ; [all ]right?
    db $73 ; scroll text
    db $43, $59, $43, $59, $43, $59, $43 ; …⎵…⎵…⎵…
    db $73 ; scroll text
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $21, $42, $59, $08, $59, $D0, $1E ; Oh,⎵I⎵[se]e
    db $43, $8A, $16, $1E, $25, $25, $42, $59 ; …[  ]Well,⎵
    db $08, $59, $99, $2D, $1E, $25, $25 ; I⎵[can ]tell
    db $73 ; scroll text
    db $E1, $91, $E3, $59, $DF, $27, $2D, $59 ; [wh][at ][you]⎵[wa]nt⎵
    db $DA, $59, $2C, $1A, $32, $59, $1B, $32 ; [to]⎵say⎵by
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $BB, $28, $24, $59, $B4, $59, $E3, $2B ; [lo]ok⎵[in]⎵[you]r
    db $59, $1E, $32, $1E, $2C, $43 ; ⎵eyes…
    db $7F ; end of message

    ; ==========================================================================
    ; Would you keep the flute?
    ; And will you play its sweet
    ; melody for the bird in the
    ; village square?
    ; I beg of you, please!
    ; My son would probably want it
    ; this way…
    ; …But still, I wish I could
    ; see him once more…
    ; --------------------------------------------------------------------------
    ; $0E3871
    Message_00A3:
    db $16, $28, $2E, $25, $1D, $59, $E3, $59 ; Would⎵[you]⎵
    db $24, $1E, $1E, $29, $59, $D8, $59, $1F ; keep⎵[the]⎵f
    db $25, $2E, $2D, $1E, $3F ; lute?
    db $75 ; line 2
    db $00, $27, $1D, $59, $E2, $25, $25, $59 ; And⎵[wi]ll⎵
    db $E3, $59, $29, $BA, $32, $59, $B6, $2C ; [you]⎵p[la]y⎵[it]s
    db $59, $2C, $E0, $1E, $2D ; ⎵s[we]et
    db $76 ; line 3
    db $BE, $BB, $1D, $32, $59, $A8, $59, $D8 ; [me][lo]dy⎵[for]⎵[the]
    db $59, $1B, $22, $2B, $1D, $59, $B4, $59 ; ⎵bird⎵[in]⎵
    db $D8 ; [the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $2F, $22, $25, $BA, $20, $1E, $59, $2C ; vil[la]ge⎵s
    db $2A, $2E, $1A, $CE, $3F ; qua[re]?
    db $73 ; scroll text
    db $08, $59, $97, $20, $59, $C6, $59, $E3 ; I⎵[be]g⎵[of]⎵[you]
    db $42, $59, $CA, $1A, $D0, $3E ; ,⎵[ple]a[se]!
    db $73 ; scroll text
    db $0C, $32, $59, $D2, $27, $59, $30, $28 ; My⎵[so]n⎵wo
    db $2E, $25, $1D, $59, $CC, $96, $1B, $B9 ; uld⎵[pro][ba]b[ly ]
    db $DF, $27, $2D, $59, $B6 ; [wa]nt⎵[it]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D9, $2C, $59, $DF, $32, $43 ; [thi]s⎵[wa]y…
    db $73 ; scroll text
    db $43, $01, $2E, $2D, $59, $D3, $22, $25 ; …But⎵[st]il
    db $25, $42, $59, $08, $59, $E2, $D1, $59 ; l,⎵I⎵[wi][sh]⎵
    db $08, $59, $1C, $28, $2E, $25, $1D ; I⎵could
    db $73 ; scroll text
    db $D0, $1E, $59, $B0, $26, $59, $C7, $1C ; [se]e⎵[hi]m⎵[on]c
    db $1E, $59, $26, $C8, $1E, $43 ; e⎵m[or]e…
    db $7F ; end of message

    ; ==========================================================================
    ; Zzzzzzz  Zzzzzzzz
    ; …  …  …
    ; Snore  Zzzzzz  Zzzzzz
    ; --------------------------------------------------------------------------
    ; $0E3912
    Message_00A4:
    db $19, $33, $33, $33, $33, $33, $33, $8A ; Zzzzzzz[  ]
    db $19, $33, $33, $33, $33, $33, $33, $33 ; Zzzzzzzz
    db $75 ; line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $76 ; line 3
    db $12, $27, $C8, $1E, $8A, $19, $33, $33 ; Sn[or]e[  ]Zzz
    db $33, $33, $33, $8A, $19, $33, $33, $33 ; zzz[  ]Zzzz
    db $33, $33 ; zz
    db $7F ; end of message

    ; ==========================================================================
    ; Oh, [LINK].  The rumors say
    ; you kidnapped the Princess,
    ; but I still trust you.
    ; --------------------------------------------------------------------------
    ; $0E393C
    Message_00A5:
    db $0E, $21, $42, $59, $6A, $41, $8A, $E6 ; Oh,⎵[LINK].[  ][The]
    db $59, $2B, $2E, $26, $C8, $2C, $59, $2C ; ⎵rum[or]s⎵s
    db $1A, $32 ; ay
    db $75 ; line 2
    db $E3, $59, $24, $22, $1D, $27, $1A, $29 ; [you]⎵kidnap
    db $29, $A4, $D8, $59, $0F, $2B, $B4, $1C ; p[ed ][the]⎵Pr[in]c
    db $1E, $2C, $2C, $42 ; ess,
    db $76 ; line 3
    db $1B, $2E, $2D, $59, $08, $59, $D3, $22 ; but⎵I⎵[st]i
    db $25, $25, $59, $DB, $2E, $D3, $59, $E3 ; ll⎵[tr]u[st]⎵[you]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; I can't believe you caught me!
    ; With your speed it must have
    ; been easy to kidnap Zelda…
    ; You don't look like such a bad
    ; guy, though…
    ; Anyway, because you have
    ; such quick feet, it might be a
    ; good idea to run and bash into
    ; many things…
    ; For example, the trees in this
    ; village have many useful things
    ; hanging in their branches…
    ; Well, just try it, OK?!
    ; --------------------------------------------------------------------------
    ; $0E3976
    Message_00A6:
    db $08, $59, $1C, $93, $51, $2D, $59, $97 ; I⎵c[an]'t⎵[be]
    db $25, $22, $A7, $1E, $59, $E3, $59, $1C ; li[ev]e⎵[you]⎵c
    db $1A, $2E, $20, $21, $2D, $59, $BE, $3E ; aught⎵[me]!
    db $75 ; line 2
    db $16, $B6, $21, $59, $E3, $2B, $59, $2C ; W[it]h⎵[you]r⎵s
    db $29, $1E, $A4, $B6, $59, $BF, $D3, $59 ; pe[ed ][it]⎵[mu][st]⎵
    db $AD ; [have]
    db $76 ; line 3
    db $97, $A0, $1E, $1A, $2C, $32, $59, $DA ; [be][en ]easy⎵[to]
    db $59, $24, $22, $1D, $27, $1A, $29, $59 ; ⎵kidnap⎵
    db $19, $1E, $25, $1D, $1A, $43 ; Zelda…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $9F, $C0, $BB, $28, $24, $59 ; [You]⎵[do][n't ][lo]ok⎵
    db $25, $22, $24, $1E, $59, $2C, $2E, $1C ; like⎵suc
    db $21, $59, $1A, $59, $96, $1D ; h⎵a⎵[ba]d
    db $73 ; scroll text
    db $20, $2E, $32, $42, $59, $2D, $21, $28 ; guy,⎵tho
    db $2E, $20, $21, $43 ; ugh…
    db $73 ; scroll text
    db $00, $27, $32, $DF, $32, $42, $59, $97 ; Any[wa]y,⎵[be]
    db $1C, $1A, $2E, $D0, $59, $E3, $59, $AD ; cau[se]⎵[you]⎵[have]
    db $7E ; wait for key
    db $73 ; scroll text
    db $2C, $2E, $1C, $21, $59, $2A, $2E, $22 ; such⎵qui
    db $9C, $59, $1F, $1E, $1E, $2D, $42, $59 ; [ck]⎵feet,⎵
    db $B6, $59, $26, $B2, $97, $59, $1A ; [it]⎵m[ight ][be]⎵a
    db $73 ; scroll text
    db $AC, $28, $1D, $59, $22, $1D, $1E, $1A ; [go]od⎵idea
    db $59, $DA, $59, $2B, $2E, $27, $59, $8C ; ⎵[to]⎵run⎵[and ]
    db $96, $D1, $59, $B4, $DA ; [ba][sh]⎵[in][to]
    db $73 ; scroll text
    db $BC, $32, $59, $D5, $20, $2C, $43 ; [man]y⎵[thin]gs…
    db $7E ; wait for key
    db $73 ; scroll text
    db $05, $C8, $59, $1E, $31, $1A, $26, $CA ; F[or]⎵exam[ple]
    db $42, $59, $D8, $59, $DB, $1E, $1E, $2C ; ,⎵[the]⎵[tr]ees
    db $59, $B4, $59, $D9, $2C ; ⎵[in]⎵[thi]s
    db $73 ; scroll text
    db $2F, $22, $25, $BA, $20, $1E, $59, $AD ; vil[la]ge⎵[have]
    db $59, $BC, $32, $59, $2E, $D0, $1F, $2E ; ⎵[man]y⎵u[se]fu
    db $25, $59, $D5, $20, $2C ; l⎵[thin]gs
    db $73 ; scroll text
    db $B1, $27, $20, $B3, $B4, $59, $D8, $22 ; [ha]ng[ing ][in]⎵[the]i
    db $2B, $59, $1B, $2B, $93, $9A, $2C, $43 ; r⎵br[an][che]s…
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $1E, $25, $25, $42, $59, $B7, $59 ; Well,⎵[just]⎵
    db $DB, $32, $59, $B6, $42, $59, $0E, $0A ; [tr]y⎵[it],⎵OK
    db $3F, $3E ; ?!
    db $7F ; end of message

    ; ==========================================================================
    ; If you have enough time to
    ; read this sign, you should go
    ; to the goal immediately!
    ; --------------------------------------------------------------------------
    ; $0E3A77
    Message_00A7:
    db $08, $1F, $59, $E3, $59, $AD, $59, $A5 ; If⎵[you]⎵[have]⎵[en]
    db $28, $2E, $20, $21, $59, $2D, $22, $BE ; ough⎵ti[me]
    db $59, $DA ; ⎵[to]
    db $75 ; line 2
    db $CE, $1A, $1D, $59, $D9, $2C, $59, $2C ; [re]ad⎵[thi]s⎵s
    db $22, $20, $27, $42, $59, $E3, $59, $D1 ; ign,⎵[you]⎵[sh]
    db $28, $2E, $25, $1D, $59, $AC ; ould⎵[go]
    db $76 ; line 3
    db $DA, $59, $D8, $59, $AC, $1A, $25, $59 ; [to]⎵[the]⎵[go]al⎵
    db $22, $26, $BE, $9E, $94, $1E, $25, $32 ; im[me][di][at]ely
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; I'll give a piece of Heart to
    ; the person who wears the Cape.
    ; --------------------------------------------------------------------------
    ; $0E3AB3
    Message_00A8:
    db $08, $51, $25, $25, $59, $AA, $1A, $59 ; I'll⎵[give ]a⎵
    db $29, $22, $1E, $1C, $1E, $59, $C6, $59 ; piece⎵[of]⎵
    db $07, $A2, $2D, $59, $DA ; H[ear]t⎵[to]
    db $75 ; line 2
    db $D8, $59, $C9, $D2, $27, $59, $E1, $28 ; [the]⎵[per][so]n⎵[wh]o
    db $59, $E0, $1A, $2B, $2C, $59, $D8, $59 ; ⎵[we]ars⎵[the]⎵
    db $02, $1A, $29, $1E, $41 ; Cape.
    db $7F ; end of message

    ; ==========================================================================
    ; Curses to anyone who throws
    ; something into my circle of
    ; stones.
    ; --------------------------------------------------------------------------
    ; $0E3ADF
    Message_00A9:
    db $02, $2E, $2B, $D0, $2C, $59, $DA, $59 ; Cur[se]s⎵[to]⎵
    db $93, $32, $C7, $1E, $59, $E1, $28, $59 ; [an]y[on]e⎵[wh]o⎵
    db $2D, $21, $2B, $28, $30, $2C ; throws
    db $75 ; line 2
    db $CF, $D5, $20, $59, $B4, $DA, $59, $26 ; [some][thin]g⎵[in][to]⎵m
    db $32, $59, $1C, $22, $2B, $1C, $25, $1E ; y⎵circle
    db $59, $C6 ; ⎵[of]
    db $76 ; line 3
    db $D3, $C7, $1E, $2C, $41 ; [st][on]es.
    db $7F ; end of message

    ; ==========================================================================
    ; This way ↑ Skeleton Forest
    ; This way ↓ Village Of Outcasts
    ; --------------------------------------------------------------------------
    ; $0E3B0F
    Message_00AA:
    db $E7, $2C, $59, $DF, $32, $59, $4D, $59 ; [Thi]s⎵[wa]y⎵↑⎵
    db $12, $24, $1E, $25, $1E, $DA, $27, $59 ; Skele[to]n⎵
    db $05, $C8, $1E, $D3 ; F[or]e[st]
    db $76 ; line 3
    db $E7, $2C, $59, $DF, $32, $59, $4E, $59 ; [Thi]s⎵[wa]y⎵↓⎵
    db $15, $22, $25, $BA, $20, $1E, $59, $0E ; Vil[la]ge⎵O
    db $1F, $59, $0E, $2E, $2D, $1C, $92, $2C ; f⎵Outc[ast]s
    db $7F ; end of message

    ; ==========================================================================
    ; This way → Cave
    ; --------------------------------------------------------------------------
    ; $0E3B3D
    Message_00AB:
    db $75 ; line 2
    db $E7, $2C, $59, $DF, $32, $59, $50, $59 ; [Thi]s⎵[wa]y⎵→⎵
    db $02, $1A, $2F, $1E ; Cave
    db $7F ; end of message

    ; ==========================================================================
    ; This way → Palace Of Darkness
    ; --------------------------------------------------------------------------
    ; $0E3B4B
    Message_00AC:
    db $75 ; line 2
    db $E7, $2C, $59, $DF, $32, $59, $50, $59 ; [Thi]s⎵[wa]y⎵→⎵
    db $0F, $1A, $BA, $1C, $1E, $59, $0E, $1F ; Pa[la]ce⎵Of
    db $59, $03, $1A, $2B, $24, $27, $1E, $2C ; ⎵Darknes
    db $2C ; s
    db $7F ; end of message

    ; ==========================================================================
    ; This way ← Bomb Shop
    ; --------------------------------------------------------------------------
    ; $0E3B66
    Message_00AD:
    db $75 ; line 2
    db $E7, $2C, $59, $DF, $32, $59, $4F, $59 ; [Thi]s⎵[wa]y⎵←⎵
    db $01, $28, $26, $1B, $59, $12, $21, $28 ; Bomb⎵Sho
    db $29 ; p
    db $7F ; end of message

    ; ==========================================================================
    ; ←  Swamp Of Evil
    ;          No Entrance
    ;          No Escape
    ; --------------------------------------------------------------------------
    ; $0E3B79
    Message_00AE:
    db $4F, $8A, $12, $DF, $26, $29, $59, $0E ; ←[  ]S[wa]mp⎵O
    db $1F, $59, $04, $2F, $22, $25 ; f⎵Evil
    db $75 ; line 2
    db $88, $88, $59, $0D, $28, $59, $04, $27 ; [    ][    ]⎵No⎵En
    db $DB, $93, $1C, $1E ; [tr][an]ce
    db $76 ; line 3
    db $88, $88, $59, $0D, $28, $59, $04, $2C ; [    ][    ]⎵No⎵Es
    db $1C, $1A, $29, $1E ; cape
    db $7F ; end of message

    ; ==========================================================================
    ; This is the Village Of Outcasts.
    ; People without Rupees are not
    ; welcome here.
    ; --------------------------------------------------------------------------
    ; $0E3BA2
    Message_00AF:
    db $E7, $2C, $59, $B5, $59, $D8, $59, $15 ; [Thi]s⎵[is]⎵[the]⎵V
    db $22, $25, $BA, $20, $1E, $59, $0E, $1F ; il[la]ge⎵Of
    db $59, $0E, $2E, $2D, $1C, $92, $2C, $41 ; ⎵Outc[ast]s.
    db $75 ; line 2
    db $0F, $1E, $28, $CA, $59, $DE, $C5, $11 ; Peo[ple]⎵[with][out ]R
    db $DC, $1E, $1E, $2C, $59, $8D, $C2 ; [up]ees⎵[are ][not]
    db $76 ; line 3
    db $E0, $25, $9B, $1E, $59, $AF, $1E, $41 ; [we]l[com]e⎵[her]e.
    db $7F ; end of message

    ; ==========================================================================
    ; The Waterfall Of Wishing is just
    ; around the corner.
    ; --------------------------------------------------------------------------
    ; $0E3BD4
    Message_00B0:
    db $E6, $59, $16, $94, $A6, $1F, $8E, $0E ; [The]⎵W[at][er]f[all ]O
    db $1F, $59, $16, $B5, $B0, $27, $20, $59 ; f⎵W[is][hi]ng⎵
    db $B5, $59, $B7 ; [is]⎵[just]
    db $75 ; line 2
    db $1A, $2B, $C4, $59, $D8, $59, $1C, $C8 ; ar[ound]⎵[the]⎵c[or]
    db $27, $A6, $41 ; n[er].
    db $7F ; end of message

    ; ==========================================================================
    ; This way →↑
    ; Lake Of Ill Omen
    ; --------------------------------------------------------------------------
    ; $0E3BF4
    Message_00B1:
    db $E7, $2C, $59, $DF, $32, $59, $50, $4D ; [Thi]s⎵[wa]y⎵→↑
    db $75 ; line 2
    db $0B, $1A, $24, $1E, $59, $0E, $1F, $59 ; Lake⎵Of⎵
    db $08, $25, $25, $59, $0E, $BE, $27 ; Ill⎵O[me]n
    db $7F ; end of message

    ; ==========================================================================
    ; After Agahnim took over,
    ; everyone began to act
    ; strangely.
    ; I suppose it's only
    ; a matter of time before
    ; I'm affected, too.
    ; --------------------------------------------------------------------------
    ; $0E3C0D
    Message_00B2:
    db $00, $1F, $D4, $00, $20, $1A, $21, $27 ; Af[ter ]Agahn
    db $22, $26, $59, $DA, $28, $24, $59, $28 ; im⎵[to]ok⎵o
    db $DD, $42 ; [ver],
    db $75 ; line 2
    db $A7, $A6, $32, $C7, $1E, $59, $97, $20 ; [ev][er]y[on]e⎵[be]g
    db $93, $59, $DA, $59, $1A, $1C, $2D ; [an]⎵[to]⎵act
    db $76 ; line 3
    db $D3, $2B, $93, $20, $1E, $25, $32, $41 ; [st]r[an]gely.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $2C, $DC, $29, $28, $D0, $59 ; I⎵s[up]po[se]⎵
    db $B6, $8B, $C7, $25, $32 ; [it]['s ][on]ly
    db $73 ; scroll text
    db $1A, $59, $BD, $2D, $D4, $C6, $59, $2D ; a⎵[ma]t[ter ][of]⎵t
    db $22, $BE, $59, $97, $A8, $1E ; i[me]⎵[be][for]e
    db $73 ; scroll text
    db $08, $51, $26, $59, $1A, $1F, $1F, $1E ; I'm⎵affe
    db $1C, $2D, $1E, $1D, $42, $59, $DA, $28 ; cted,⎵[to]o
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Hey hey!  You're not allowed in
    ; the castle, son!
    ; Go home and get some sleep!
    ; --------------------------------------------------------------------------
    ; $0E3C69
    Message_00B3:
    db $07, $1E, $32, $59, $21, $1E, $32, $3E ; Hey⎵hey!
    db $8A, $E8, $51, $CD, $C2, $59, $1A, $25 ; [  ][You]'[re ][not]⎵al
    db $BB, $E0, $1D, $59, $B4 ; [lo][we]d⎵[in]
    db $75 ; line 2
    db $D8, $59, $1C, $92, $25, $1E, $42, $59 ; [the]⎵c[ast]le,⎵
    db $D2, $27, $3E ; [so]n!
    db $76 ; line 3
    db $06, $28, $59, $21, $28, $BE, $59, $8C ; Go⎵ho[me]⎵[and ]
    db $AB, $59, $CF, $59, $2C, $25, $1E, $1E ; [get]⎵[some]⎵slee
    db $29, $3E ; p!
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla.  I
    ; can talk to you telepathically
    ; when you touch these tiles.
    ; Here is a hint.  You can use the
    ; treasure hidden in this palace
    ; to defeat armored foes.
    ; --------------------------------------------------------------------------
    ; $0E3C9E
    Message_00B4:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $41, $8A, $08 ; [la].[  ]I
    db $75 ; line 2
    db $99, $2D, $1A, $25, $24, $59, $DA, $59 ; [can ]talk⎵[to]⎵
    db $E3, $59, $2D, $1E, $25, $1E, $29, $94 ; [you]⎵telep[at]
    db $B0, $1C, $1A, $25, $25, $32 ; [hi]cally
    db $76 ; line 3
    db $E1, $A0, $E3, $59, $DA, $2E, $1C, $21 ; [wh][en ][you]⎵[to]uch
    db $59, $D8, $D0, $59, $2D, $22, $25, $1E ; ⎵[the][se]⎵tile
    db $2C, $41 ; s.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E4, $1E, $59, $B5, $59, $1A, $59, $B0 ; [Her]e⎵[is]⎵a⎵[hi]
    db $27, $2D, $41, $8A, $E8, $59, $99, $2E ; nt.[  ][You]⎵[can ]u
    db $D0, $59, $D8 ; [se]⎵[the]
    db $73 ; scroll text
    db $DB, $1E, $1A, $2C, $2E, $CD, $B0, $1D ; [tr]easu[re ][hi]d
    db $1D, $A0, $B4, $59, $D9, $2C, $59, $29 ; d[en ][in]⎵[thi]s⎵p
    db $1A, $BA, $1C, $1E ; a[la]ce
    db $73 ; scroll text
    db $DA, $59, $1D, $1E, $1F, $1E, $91, $1A ; [to]⎵defe[at ]a
    db $2B, $26, $C8, $A4, $1F, $28, $1E, $2C ; rm[or][ed ]foes
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla the
    ; elder.  An orb known as the
    ; Moon Pearl is in this tower.
    ; Whoever holds the Moon Pearl is
    ; protected so that his form will
    ; not change in the Dark World.
    ; You must find it and escape
    ; from the tower!
    ; Don't forget the Moon Pearl…
    ; --------------------------------------------------------------------------
    ; $0E3D1B
    Message_00B5:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $59, $D8 ; [la]⎵[the]
    db $75 ; line 2
    db $1E, $25, $1D, $A6, $41, $8A, $00, $27 ; eld[er].[  ]An
    db $59, $C8, $1B, $59, $B8, $27, $59, $1A ; ⎵[or]b⎵[know]n⎵a
    db $2C, $59, $D8 ; s⎵[the]
    db $76 ; line 3
    db $0C, $28, $C7, $59, $0F, $A2, $25, $59 ; Mo[on]⎵P[ear]l⎵
    db $B5, $59, $B4, $59, $D9, $2C, $59, $DA ; [is]⎵[in]⎵[thi]s⎵[to]
    db $E0, $2B, $41 ; [we]r.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $21, $28, $A7, $A1, $21, $28, $25 ; Who[ev][er ]hol
    db $1D, $2C, $59, $D8, $59, $0C, $28, $C7 ; ds⎵[the]⎵Mo[on]
    db $59, $0F, $A2, $25, $59, $B5 ; ⎵P[ear]l⎵[is]
    db $73 ; scroll text
    db $CC, $2D, $1E, $1C, $2D, $A4, $D2, $59 ; [pro]tect[ed ][so]⎵
    db $D7, $2D, $59, $B0, $2C, $59, $A8, $26 ; [tha]t⎵[hi]s⎵[for]m
    db $59, $E2, $25, $25 ; ⎵[wi]ll
    db $73 ; scroll text
    db $C2, $59, $1C, $B1, $27, $20, $1E, $59 ; [not]⎵c[ha]nge⎵
    db $B4, $59, $D8, $59, $03, $1A, $2B, $24 ; [in]⎵[the]⎵Dark
    db $59, $16, $C8, $25, $1D, $41 ; ⎵W[or]ld.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $BF, $D3, $59, $1F, $B4, $1D ; [You]⎵[mu][st]⎵f[in]d
    db $59, $B6, $59, $8C, $1E, $2C, $1C, $1A ; ⎵[it]⎵[and ]esca
    db $29, $1E ; pe
    db $73 ; scroll text
    db $A9, $26, $59, $D8, $59, $DA, $E0, $2B ; [fro]m⎵[the]⎵[to][we]r
    db $3E ; !
    db $73 ; scroll text
    db $03, $C7, $51, $2D, $59, $A8, $AB, $59 ; D[on]'t⎵[for][get]⎵
    db $D8, $59, $0C, $28, $C7, $59, $0F, $A2 ; [the]⎵Mo[on]⎵P[ear]
    db $25, $43 ; l…
    db $7F ; end of message

    ; ==========================================================================
    ; ☥𓈗☥Ƨ☥𓈗☥Ƨ☥𓈗𓈗𓈗𓈗☥Ƨ☥𓈗☥Ƨ
    ; ☥Ƨ☥☥𓈗☥Ƨ☥𓈗☥Ƨ
    ; ☥𓈗☥Ƨ☥☥𓈗☥ƧƧ𓈗☥☥Ƨ
    ; --------------------------------------------------------------------------
    ; $0E3DCE
    Message_00B6:
    db $47, $48, $47, $49, $47, $48, $47, $49 ; ☥𓈗☥Ƨ☥𓈗☥Ƨ
    db $47, $48, $48, $48, $48, $47, $49, $47 ; ☥𓈗𓈗𓈗𓈗☥Ƨ☥
    db $48, $47, $49 ; 𓈗☥Ƨ
    db $75 ; line 2
    db $47, $49, $47, $47, $48, $47, $49, $47 ; ☥Ƨ☥☥𓈗☥Ƨ☥
    db $48, $47, $49 ; 𓈗☥Ƨ
    db $76 ; line 3
    db $47, $48, $47, $49, $47, $47, $48, $47 ; ☥𓈗☥Ƨ☥☥𓈗☥
    db $49, $49, $48, $47, $47, $49 ; ƧƧ𓈗☥☥Ƨ
    db $7F ; end of message

    ; ==========================================================================
    ; The Hero's triumph on
    ; Cataclysm's Eve
    ; Wins three symbols of virtue.
    ; The Master Sword he will then
    ; retrieve,
    ; Keeping the Knight's line true.
    ; --------------------------------------------------------------------------
    ; $0E3DFD
    Message_00B7:
    db $E6, $59, $E4, $28, $8B, $DB, $22, $2E ; [The]⎵[Her]o['s ][tr]iu
    db $26, $29, $21, $59, $C7 ; mph⎵[on]
    db $75 ; line 2
    db $02, $94, $1A, $1C, $25, $32, $2C, $26 ; C[at]aclysm
    db $8B, $04, $2F, $1E ; ['s ]Eve
    db $76 ; line 3
    db $16, $B4, $2C, $59, $2D, $21, $CE, $1E ; W[in]s⎵th[re]e
    db $59, $2C, $32, $26, $98, $25, $2C, $59 ; ⎵sym[bo]ls⎵
    db $C6, $59, $2F, $22, $2B, $2D, $2E, $1E ; [of]⎵virtue
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $0C, $92, $A1, $12, $30, $C8 ; [The]⎵M[ast][er ]Sw[or]
    db $1D, $59, $21, $1E, $59, $E2, $25, $25 ; d⎵he⎵[wi]ll
    db $59, $D8, $27 ; ⎵[the]n
    db $73 ; scroll text
    db $CE, $DB, $22, $A7, $1E, $42 ; [re][tr]i[ev]e,
    db $73 ; scroll text
    db $0A, $1E, $1E, $29, $B3, $D8, $59, $0A ; Keep[ing ][the]⎵K
    db $27, $22, $20, $21, $2D, $8B, $25, $B4 ; night['s ]l[in]
    db $1E, $59, $DB, $2E, $1E, $41 ; e⎵[tr]ue.
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla.
    ; You must somehow make your
    ; way to the top of Spectacle
    ; Rock.  From there you can
    ; reach the Tower of Hera on
    ; top of Death Mountain.
    ; --------------------------------------------------------------------------
    ; $0E3E65
    Message_00B8:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $41 ; [la].
    db $75 ; line 2
    db $E8, $59, $BF, $D3, $59, $CF, $21, $28 ; [You]⎵[mu][st]⎵[some]ho
    db $30, $59, $BD, $24, $1E, $59, $E3, $2B ; w⎵[ma]ke⎵[you]r
    db $76 ; line 3
    db $DF, $32, $59, $DA, $59, $D8, $59, $DA ; [wa]y⎵[to]⎵[the]⎵[to]
    db $29, $59, $C6, $59, $12, $29, $1E, $1C ; p⎵[of]⎵Spec
    db $2D, $1A, $1C, $25, $1E ; tacle
    db $7E ; wait for key
    db $73 ; scroll text
    db $11, $28, $9C, $41, $8A, $05, $2B, $28 ; Ro[ck].[  ]Fro
    db $26, $59, $D8, $CD, $E3, $59, $1C, $93 ; m⎵[the][re ][you]⎵c[an]
    db $73 ; scroll text
    db $CE, $1A, $1C, $21, $59, $D8, $59, $13 ; [re]ach⎵[the]⎵T
    db $28, $E0, $2B, $59, $C6, $59, $E4, $1A ; o[we]r⎵[of]⎵[Her]a
    db $59, $C7 ; ⎵[on]
    db $73 ; scroll text
    db $DA, $29, $59, $C6, $59, $03, $1E, $94 ; [to]p⎵[of]⎵De[at]
    db $21, $59, $0C, $28, $2E, $27, $2D, $8F ; h⎵Mount[ain]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla.
    ; Objects exist simultaneously in
    ; both worlds with similar shapes.
    ; If the form of a thing changes,
    ; it will affect the shape of its
    ; twin in the other world.
    ; --------------------------------------------------------------------------
    ; $0E3ED8
    Message_00B9:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $41 ; [la].
    db $75 ; line 2
    db $0E, $1B, $23, $1E, $1C, $2D, $2C, $59 ; Objects⎵
    db $1E, $31, $B5, $2D, $59, $2C, $22, $BF ; ex[is]t⎵si[mu]
    db $25, $2D, $93, $1E, $28, $2E, $2C, $B9 ; lt[an]eous[ly ]
    db $B4 ; [in]
    db $76 ; line 3
    db $98, $2D, $21, $59, $30, $C8, $25, $1D ; [bo]th⎵w[or]ld
    db $2C, $59, $DE, $59, $2C, $22, $26, $22 ; s⎵[with]⎵simi
    db $BA, $2B, $59, $D1, $1A, $29, $1E, $2C ; [la]r⎵[sh]apes
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $D8, $59, $A8, $26, $59 ; If⎵[the]⎵[for]m⎵
    db $C6, $59, $1A, $59, $D5, $20, $59, $1C ; [of]⎵a⎵[thin]g⎵c
    db $B1, $27, $20, $1E, $2C, $42 ; [ha]nges,
    db $73 ; scroll text
    db $B6, $59, $E2, $25, $25, $59, $1A, $1F ; [it]⎵[wi]ll⎵af
    db $1F, $1E, $1C, $2D, $59, $D8, $59, $D1 ; fect⎵[the]⎵[sh]
    db $1A, $29, $1E, $59, $C6, $59, $B6, $2C ; ape⎵[of]⎵[it]s
    db $73 ; scroll text
    db $2D, $E2, $27, $59, $B4, $59, $D8, $59 ; t[wi]n⎵[in]⎵[the]⎵
    db $28, $D8, $2B, $59, $30, $C8, $25, $1D ; o[the]r⎵w[or]ld
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK]…  It's me, Zelda…
    ; Don't be deceived by the magic
    ; of Blind the Thief!  Be careful!
    ; --------------------------------------------------------------------------
    ; $0E3F64
    Message_00BA:
    db $6B, $02 ; set window border
    db $6A, $43, $8A, $08, $2D, $8B, $BE, $42 ; [LINK]…[  ]It['s ][me],
    db $59, $19, $1E, $25, $1D, $1A, $43 ; ⎵Zelda…
    db $75 ; line 2
    db $03, $C7, $51, $2D, $59, $97, $59, $1D ; D[on]'t⎵[be]⎵d
    db $1E, $1C, $1E, $22, $2F, $A4, $1B, $32 ; eceiv[ed ]by
    db $59, $D8, $59, $BD, $20, $22, $1C ; ⎵[the]⎵[ma]gic
    db $76 ; line 3
    db $C6, $59, $01, $25, $B4, $1D, $59, $D8 ; [of]⎵Bl[in]d⎵[the]
    db $59, $E7, $1E, $1F, $3E, $8A, $01, $1E ; ⎵[Thi]ef![  ]Be
    db $59, $1C, $1A, $CE, $1F, $2E, $25, $3E ; ⎵ca[re]ful!
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK],  it is I, Sahasrahla
    ; the elder!  You must set fire
    ; to four torches to open
    ; the way forward.
    ; --------------------------------------------------------------------------
    ; $0E3FA7
    Message_00BB:
    db $6B, $02 ; set window border
    db $6A, $42, $8A, $B6, $59, $B5, $59, $08 ; [LINK],[  ][it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA ; [la]
    db $75 ; line 2
    db $D8, $59, $1E, $25, $1D, $A6, $3E, $8A ; [the]⎵eld[er]![  ]
    db $E8, $59, $BF, $D3, $59, $D0, $2D, $59 ; [You]⎵[mu][st]⎵[se]t⎵
    db $1F, $22, $CE ; fi[re]
    db $76 ; line 3
    db $DA, $59, $1F, $28, $2E, $2B, $59, $DA ; [to]⎵four⎵[to]
    db $2B, $9A, $2C, $59, $DA, $59, $C3 ; r[che]s⎵[to]⎵[open]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $DF, $32, $59, $A8, $DF, $2B ; [the]⎵[wa]y⎵[for][wa]r
    db $1D, $41 ; d.
    db $7F ; end of message

    ; ==========================================================================
    ; ☥Ƨ☥𓈗☥Ƨ☥𓈗☥𓈗☥
    ; ☥𓈗☥Ƨ☥Ƨ☥𓈗☥Ƨ
    ; ☥𓈗☥Ƨ☥Ƨ☥𓈗☥Ƨ☥
    ; --------------------------------------------------------------------------
    ; $0E3FEB
    Message_00BC:
    db $47, $49, $47, $48, $47, $49, $47, $48 ; ☥Ƨ☥𓈗☥Ƨ☥𓈗
    db $47, $48, $47 ; ☥𓈗☥
    db $75 ; line 2
    db $47, $48, $47, $49, $47, $49, $47, $48 ; ☥𓈗☥Ƨ☥Ƨ☥𓈗
    db $47, $49 ; ☥Ƨ
    db $76 ; line 3
    db $47, $48, $47, $49, $47, $49, $47, $48 ; ☥𓈗☥Ƨ☥Ƨ☥𓈗
    db $47, $49, $47 ; ☥Ƨ☥
    db $7F ; end of message

    ; ==========================================================================
    ; To open the way to go forward,
    ; Make your wish here
    ; And it will be granted.
    ; --------------------------------------------------------------------------
    ; $0E400E
    Message_00BD:
    db $13, $28, $59, $C3, $59, $D8, $59, $DF ; To⎵[open]⎵[the]⎵[wa]
    db $32, $59, $DA, $59, $AC, $59, $A8, $DF ; y⎵[to]⎵[go]⎵[for][wa]
    db $2B, $1D, $42 ; rd,
    db $75 ; line 2
    db $0C, $1A, $24, $1E, $59, $E3, $2B, $59 ; Make⎵[you]r⎵
    db $E2, $D1, $59, $AF, $1E ; [wi][sh]⎵[her]e
    db $76 ; line 3
    db $00, $27, $1D, $59, $B6, $59, $E2, $25 ; And⎵[it]⎵[wi]l
    db $25, $59, $97, $59, $20, $2B, $93, $2D ; l⎵[be]⎵gr[an]t
    db $1E, $1D, $41 ; ed.
    db $7F ; end of message

    ; ==========================================================================
    ; When Ganon is stunned, give
    ; him his last moment with a
    ; Silver Arrow!
    ; Do you understand, [LINK]?
    ; --------------------------------------------------------------------------
    ; $0E4044
    Message_00BE:
    db $6B, $02 ; set window border
    db $16, $21, $A0, $06, $93, $C7, $59, $B5 ; Wh[en ]G[an][on]⎵[is]
    db $59, $D3, $2E, $27, $27, $1E, $1D, $42 ; ⎵[st]unned,
    db $59, $20, $22, $2F, $1E ; ⎵give
    db $75 ; line 2
    db $B0, $26, $59, $B0, $2C, $59, $BA, $D3 ; [hi]m⎵[hi]s⎵[la][st]
    db $59, $26, $28, $BE, $27, $2D, $59, $DE ; ⎵mo[me]nt⎵[with]
    db $59, $1A ; ⎵a
    db $76 ; line 3
    db $12, $22, $25, $DD, $59, $00, $2B, $2B ; Sil[ver]⎵Arr
    db $28, $30, $3E ; ow!
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $28, $59, $E3, $59, $2E, $27, $1D ; Do⎵[you]⎵und
    db $A6, $D3, $90, $42, $59, $6A, $3F ; [er][st][and],⎵[LINK]?
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], can you hear me?
    ; It's me, Zelda.  I am locked in
    ; Turtle Rock on top of Death
    ; Mountain.  I know you are doing
    ; your best, but please hurry…
    ; --------------------------------------------------------------------------
    ; $0E408C
    Message_00BF:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $99, $E3, $59, $21, $A2 ; [LINK],⎵[can ][you]⎵h[ear]
    db $59, $BE, $3F ; ⎵[me]?
    db $75 ; line 2
    db $08, $2D, $8B, $BE, $42, $59, $19, $1E ; It['s ][me],⎵Ze
    db $25, $1D, $1A, $41, $8A, $08, $59, $1A ; lda.[  ]I⎵a
    db $26, $59, $BB, $9C, $A4, $B4 ; m⎵[lo][ck][ed ][in]
    db $76 ; line 3
    db $13, $2E, $2B, $2D, $25, $1E, $59, $11 ; Turtle⎵R
    db $28, $9C, $59, $C7, $59, $DA, $29, $59 ; o[ck]⎵[on]⎵[to]p⎵
    db $C6, $59, $03, $1E, $94, $21 ; [of]⎵De[at]h
    db $7E ; wait for key
    db $73 ; scroll text
    db $0C, $28, $2E, $27, $2D, $8F, $41, $8A ; Mount[ain].[  ]
    db $08, $59, $B8, $59, $E3, $59, $8D, $9F ; I⎵[know]⎵[you]⎵[are ][do]
    db $B4, $20 ; [in]g
    db $73 ; scroll text
    db $E3, $2B, $59, $97, $D3, $42, $59, $1B ; [you]r⎵[be][st],⎵b
    db $2E, $2D, $59, $CA, $1A, $D0, $59, $21 ; ut⎵[ple]a[se]⎵h
    db $2E, $2B, $2B, $32, $43 ; urry…
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla.
    ; You must never fail to find all
    ; the treasures in each dungeon.
    ; --------------------------------------------------------------------------
    ; $0E40F2
    Message_00C0:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $41 ; [la].
    db $75 ; line 2
    db $E8, $59, $BF, $D3, $59, $27, $A7, $A1 ; [You]⎵[mu][st]⎵n[ev][er ]
    db $1F, $1A, $22, $25, $59, $DA, $59, $1F ; fail⎵[to]⎵f
    db $B4, $1D, $59, $1A, $25, $25 ; [in]d⎵all
    db $76 ; line 3
    db $D8, $59, $DB, $1E, $1A, $2C, $2E, $CE ; [the]⎵[tr]easu[re]
    db $2C, $59, $B4, $59, $1E, $1A, $1C, $21 ; s⎵[in]⎵each
    db $59, $1D, $2E, $27, $20, $1E, $C7, $41 ; ⎵dunge[on].
    db $7F ; end of message

    ; ==========================================================================
    ; Listen well, [LINK].
    ; Even with the Master Sword,
    ; you cannot inflict physical
    ; harm on the wizard.
    ; You must find a way to return
    ; his own evil magic power to him.
    ; --------------------------------------------------------------------------
    ; $0E4137
    Message_00C1:
    db $6B, $02 ; set window border
    db $0B, $B5, $2D, $A0, $E0, $25, $25, $42 ; L[is]t[en ][we]ll,
    db $59, $6A, $41 ; ⎵[LINK].
    db $75 ; line 2
    db $04, $2F, $A0, $DE, $59, $D8, $59, $0C ; Ev[en ][with]⎵[the]⎵M
    db $92, $A1, $12, $30, $C8, $1D, $42 ; [ast][er ]Sw[or]d,
    db $76 ; line 3
    db $E3, $59, $1C, $93, $C2, $59, $B4, $1F ; [you]⎵c[an][not]⎵[in]f
    db $25, $22, $1C, $2D, $59, $29, $21, $32 ; lict⎵phy
    db $2C, $22, $1C, $1A, $25 ; sical
    db $7E ; wait for key
    db $73 ; scroll text
    db $B1, $2B, $26, $59, $C7, $59, $D8, $59 ; [ha]rm⎵[on]⎵[the]⎵
    db $E2, $33, $1A, $2B, $1D, $41 ; [wi]zard.
    db $73 ; scroll text
    db $E8, $59, $BF, $D3, $59, $1F, $B4, $1D ; [You]⎵[mu][st]⎵f[in]d
    db $59, $1A, $59, $DF, $32, $59, $DA, $59 ; ⎵a⎵[wa]y⎵[to]⎵
    db $CE, $2D, $2E, $2B, $27 ; [re]turn
    db $73 ; scroll text
    db $B0, $2C, $59, $28, $30, $27, $59, $A7 ; [hi]s⎵own⎵[ev]
    db $22, $25, $59, $BD, $20, $22, $1C, $59 ; il⎵[ma]gic⎵
    db $CB, $A1, $DA, $59, $B0, $26, $41 ; [pow][er ][to]⎵[hi]m.
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], do not use all your
    ; magic power if you do not
    ; possess the Medicine Of Magic.
    ; Now, get ready to go into the
    ; depths of this dungeon.
    ; --------------------------------------------------------------------------
    ; $0E41A9
    Message_00C2:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $9F, $59, $C2, $59, $2E ; [LINK],⎵[do]⎵[not]⎵u
    db $D0, $59, $8E, $E3, $2B ; [se]⎵[all ][you]r
    db $75 ; line 2
    db $BD, $20, $22, $1C, $59, $CB, $A1, $22 ; [ma]gic⎵[pow][er ]i
    db $1F, $59, $E3, $59, $9F, $59, $C2 ; f⎵[you]⎵[do]⎵[not]
    db $76 ; line 3
    db $29, $28, $2C, $D0, $2C, $2C, $59, $D8 ; pos[se]ss⎵[the]
    db $59, $0C, $1E, $9E, $1C, $B4, $1E, $59 ; ⎵Me[di]c[in]e⎵
    db $0E, $1F, $59, $0C, $1A, $20, $22, $1C ; Of⎵Magic
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $AB, $59, $CE ; Now,⎵[get]⎵[re]
    db $1A, $1D, $32, $59, $DA, $59, $AC, $59 ; ady⎵[to]⎵[go]⎵
    db $B4, $DA, $59, $D8 ; [in][to]⎵[the]
    db $73 ; scroll text
    db $1D, $1E, $29, $2D, $21, $2C, $59, $C6 ; depths⎵[of]
    db $59, $D9, $2C, $59, $1D, $2E, $27, $20 ; ⎵[thi]s⎵dung
    db $1E, $C7, $41 ; e[on].
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], do you possess the
    ; Medicine of Magic?  If not, I
    ; recommend against going any
    ; further.
    ; --------------------------------------------------------------------------
    ; $0E420D
    Message_00C3:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $9F, $59, $E3, $59, $29 ; [LINK],⎵[do]⎵[you]⎵p
    db $28, $2C, $D0, $2C, $2C, $59, $D8 ; os[se]ss⎵[the]
    db $75 ; line 2
    db $0C, $1E, $9E, $1C, $B4, $1E, $59, $C6 ; Me[di]c[in]e⎵[of]
    db $59, $0C, $1A, $20, $22, $1C, $3F, $8A ; ⎵Magic?[  ]
    db $08, $1F, $59, $C2, $42, $59, $08 ; If⎵[not],⎵I
    db $76 ; line 3
    db $CE, $9B, $BE, $27, $1D, $59, $1A, $20 ; [re][com][me]nd⎵ag
    db $8F, $D3, $59, $AC, $B3, $93, $32 ; [ain][st]⎵[go][ing ][an]y
    db $7E ; wait for key
    db $73 ; scroll text
    db $1F, $2E, $2B, $D8, $2B, $41 ; fur[the]r.
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], the magic flames will
    ; protect you inside this icy
    ; dungeon.
    ; --------------------------------------------------------------------------
    ; $0E424F
    Message_00C4:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $D8, $59, $BD, $20, $22 ; [LINK],⎵[the]⎵[ma]gi
    db $1C, $59, $1F, $BA, $BE, $2C, $59, $E2 ; c⎵f[la][me]s⎵[wi]
    db $25, $25 ; ll
    db $75 ; line 2
    db $CC, $2D, $1E, $1C, $2D, $59, $E3, $59 ; [pro]tect⎵[you]⎵
    db $B4, $2C, $22, $1D, $1E, $59, $D9, $2C ; [in]side⎵[thi]s
    db $59, $22, $1C, $32 ; ⎵icy
    db $76 ; line 3
    db $1D, $2E, $27, $20, $1E, $C7, $41 ; dunge[on].
    db $7F ; end of message

    ; ==========================================================================
    ; You cannot destroy the
    ; Skeleton Knight with the sword
    ; alone.  When he collapses, he is
    ; vulnerable to another weapon.
    ; --------------------------------------------------------------------------
    ; $0E4281
    Message_00C5:
    db $6B, $02 ; set window border
    db $E8, $59, $1C, $93, $C2, $59, $9D, $DB ; [You]⎵c[an][not]⎵[des][tr]
    db $28, $32, $59, $D8 ; oy⎵[the]
    db $75 ; line 2
    db $12, $24, $1E, $25, $1E, $DA, $27, $59 ; Skele[to]n⎵
    db $0A, $27, $B2, $DE, $59, $D8, $59, $2C ; Kn[ight ][with]⎵[the]⎵s
    db $30, $C8, $1D ; w[or]d
    db $76 ; line 3
    db $1A, $BB, $27, $1E, $41, $8A, $16, $21 ; a[lo]ne.[  ]Wh
    db $A0, $21, $1E, $59, $1C, $28, $25, $BA ; [en ]he⎵col[la]
    db $29, $D0, $2C, $42, $59, $21, $1E, $59 ; p[se]s,⎵he⎵
    db $B5 ; [is]
    db $7E ; wait for key
    db $73 ; scroll text
    db $2F, $2E, $25, $27, $A6, $1A, $95, $59 ; vuln[er]a[ble]⎵
    db $DA, $59, $93, $28, $D8, $2B, $59, $E0 ; [to]⎵[an]o[the]r⎵[we]
    db $1A, $29, $C7, $41 ; ap[on].
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], it is I, Sahasrahla the
    ; elder.  I have some advice…
    ; In the dungeons, you can gaze
    ; into the Magic Mirror to return
    ; to the entrance at any time.
    ; Do not forget this!
    ; --------------------------------------------------------------------------
    ; $0E42D4
    Message_00C6:
    db $6B, $02 ; set window border
    db $6A, $42, $59, $B6, $59, $B5, $59, $08 ; [LINK],⎵[it]⎵[is]⎵I
    db $42, $59, $12, $1A, $AE, $2B, $1A, $21 ; ,⎵Sa[has]rah
    db $BA, $59, $D8 ; [la]⎵[the]
    db $75 ; line 2
    db $1E, $25, $1D, $A6, $41, $8A, $08, $59 ; eld[er].[  ]I⎵
    db $AD, $59, $CF, $59, $1A, $1D, $2F, $22 ; [have]⎵[some]⎵advi
    db $1C, $1E, $43 ; ce…
    db $76 ; line 3
    db $08, $27, $59, $D8, $59, $1D, $2E, $27 ; In⎵[the]⎵dun
    db $20, $1E, $C7, $2C, $42, $59, $E3, $59 ; ge[on]s,⎵[you]⎵
    db $99, $20, $1A, $33, $1E ; [can ]gaze
    db $7E ; wait for key
    db $73 ; scroll text
    db $B4, $DA, $59, $D8, $59, $0C, $1A, $20 ; [in][to]⎵[the]⎵Mag
    db $22, $1C, $59, $0C, $22, $2B, $2B, $C8 ; ic⎵Mirr[or]
    db $59, $DA, $59, $CE, $2D, $2E, $2B, $27 ; ⎵[to]⎵[re]turn
    db $73 ; scroll text
    db $DA, $59, $D8, $59, $A3, $2B, $93, $1C ; [to]⎵[the]⎵[ent]r[an]c
    db $1E, $59, $91, $93, $32, $59, $2D, $22 ; e⎵[at ][an]y⎵ti
    db $BE, $41 ; [me].
    db $73 ; scroll text
    db $03, $28, $59, $C2, $59, $A8, $AB, $59 ; Do⎵[not]⎵[for][get]⎵
    db $D9, $2C, $3E ; [thi]s!
    db $7F ; end of message

    ; ==========================================================================
    ; My name is Chris Houlihan.
    ; This is my top secret room.
    ; Keep it between us, OK?
    ; --------------------------------------------------------------------------
    ; $0E434D
    Message_00C7:
    db $0C, $32, $59, $27, $1A, $BE, $59, $B5 ; My⎵na[me]⎵[is]
    db $59, $02, $21, $2B, $B5, $59, $07, $28 ; ⎵Chr[is]⎵Ho
    db $2E, $25, $22, $B1, $27, $41 ; uli[ha]n.
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $26, $32, $59 ; [Thi]s⎵[is]⎵my⎵
    db $DA, $29, $59, $D0, $1C, $CE, $2D, $59 ; [to]p⎵[se]c[re]t⎵
    db $2B, $28, $28, $26, $41 ; room.
    db $76 ; line 3
    db $0A, $1E, $1E, $29, $59, $B6, $59, $97 ; Keep⎵[it]⎵[be]
    db $2D, $E0, $A0, $2E, $2C, $42, $59, $0E ; t[we][en ]us,⎵O
    db $0A, $3F ; K?
    db $7F ; end of message

    ; ==========================================================================
    ; You caught a bee!
    ; What will you do?
    ;     > Keep it in a bottle
    ;        Set it free
    ; --------------------------------------------------------------------------
    ; $0E438D
    Message_00C8:
    db $E8, $59, $1C, $1A, $2E, $20, $21, $2D ; [You]⎵caught
    db $59, $1A, $59, $97, $1E, $3E ; ⎵a⎵[be]e!
    db $7E ; wait for key
    db $75 ; line 2
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $76 ; line 3
    db $88, $44, $59, $0A, $1E, $1E, $29, $59 ; [    ]>⎵Keep⎵
    db $B6, $59, $B4, $59, $1A, $59, $98, $2D ; [it]⎵[in]⎵a⎵[bo]t
    db $2D, $25, $1E ; tle
    db $73 ; scroll text
    db $88, $89, $12, $1E, $2D, $59, $B6, $59 ; [    ][   ]Set⎵[it]⎵
    db $1F, $CE, $1E ; f[re]e
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; You caught a faerie!
    ; What will you do?
    ;     > Keep it in a bottle
    ;        Set it free
    ; --------------------------------------------------------------------------
    ; $0E43CB
    Message_00C9:
    db $E8, $59, $1C, $1A, $2E, $20, $21, $2D ; [You]⎵caught
    db $59, $1A, $59, $1F, $1A, $A6, $22, $1E ; ⎵a⎵fa[er]ie
    db $3E ; !
    db $7E ; wait for key
    db $75 ; line 2
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $76 ; line 3
    db $88, $44, $59, $0A, $1E, $1E, $29, $59 ; [    ]>⎵Keep⎵
    db $B6, $59, $B4, $59, $1A, $59, $98, $2D ; [it]⎵[in]⎵a⎵[bo]t
    db $2D, $25, $1E ; tle
    db $73 ; scroll text
    db $88, $89, $12, $1E, $2D, $59, $B6, $59 ; [    ][   ]Set⎵[it]⎵
    db $1F, $CE, $1E ; f[re]e
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; You don't have any empty
    ; bottles.  You have no choice…
    ; Just set it free.
    ; --------------------------------------------------------------------------
    ; $0E4414
    Message_00CA:
    db $E8, $59, $9F, $C0, $AD, $59, $93, $32 ; [You]⎵[do][n't ][have]⎵[an]y
    db $59, $1E, $26, $29, $2D, $32 ; ⎵empty
    db $75 ; line 2
    db $98, $2D, $2D, $25, $1E, $2C, $41, $8A ; [bo]ttles.[  ]
    db $E8, $59, $AD, $59, $27, $28, $59, $1C ; [You]⎵[have]⎵no⎵c
    db $21, $28, $22, $1C, $1E, $43 ; hoice…
    db $76 ; line 3
    db $09, $2E, $D3, $59, $D0, $2D, $59, $B6 ; Ju[st]⎵[se]t⎵[it]
    db $59, $1F, $CE, $1E, $41 ; ⎵f[re]e.
    db $7F ; end of message

    ; ==========================================================================
    ; This try your time was
    ; [#3][#2] minutes [#1][#0] seconds.
    ; --------------------------------------------------------------------------
    ; $0E4440
    Message_00CB:
    db $E7, $2C, $59, $DB, $32, $59, $E3, $2B ; [Thi]s⎵[tr]y⎵[you]r
    db $59, $2D, $22, $BE, $59, $DF, $2C ; ⎵ti[me]⎵[wa]s
    db $75 ; line 2
    db $6C, $03, $6C, $02, $59, $26, $B4, $2E ; [#3][#2]⎵m[in]u
    db $2D, $1E, $2C, $59, $6C, $01, $6C, $00 ; tes⎵[#1][#0]
    db $59, $D0, $1C, $C7, $1D, $2C, $41 ; ⎵[se]c[on]ds.
    db $7F ; end of message

    ; ==========================================================================
    ; If you can reach the goal
    ; within 15 seconds, we will give
    ; you something good.
    ; Ready, Set… …  GO!
    ; --------------------------------------------------------------------------
    ; $0E4468
    Message_00CC:
    db $08, $1F, $59, $E3, $59, $99, $CE, $1A ; If⎵[you]⎵[can ][re]a
    db $1C, $21, $59, $D8, $59, $AC, $1A, $25 ; ch⎵[the]⎵[go]al
    db $75 ; line 2
    db $DE, $B4, $59, $35, $39, $59, $D0, $1C ; [with][in]⎵15⎵[se]c
    db $C7, $1D, $2C, $42, $59, $E0, $59, $E2 ; [on]ds,⎵[we]⎵[wi]
    db $25, $25, $59, $20, $22, $2F, $1E ; ll⎵give
    db $76 ; line 3
    db $E3, $59, $CF, $D5, $20, $59, $AC, $28 ; [you]⎵[some][thin]g⎵[go]o
    db $1D, $41 ; d.
    db $7E ; wait for key
    db $73 ; scroll text
    db $11, $1E, $1A, $1D, $32, $42, $59, $12 ; Ready,⎵S
    db $1E, $2D, $43, $59, $43, $8A, $06, $0E ; et…⎵…[  ]GO
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; You qualified!
    ; Congratulations!
    ; I present you with a piece of
    ; Heart!
    ; --------------------------------------------------------------------------
    ; $0E44AF
    Message_00CD:
    db $E8, $59, $2A, $2E, $1A, $25, $22, $1F ; [You]⎵qualif
    db $22, $1E, $1D, $3E ; ied!
    db $75 ; line 2
    db $02, $C7, $20, $2B, $94, $2E, $BA, $2D ; C[on]gr[at]u[la]t
    db $22, $C7, $2C, $3E ; i[on]s!
    db $76 ; line 3
    db $08, $59, $29, $CE, $D0, $27, $2D, $59 ; I⎵p[re][se]nt⎵
    db $E3, $59, $DE, $59, $1A, $59, $29, $22 ; [you]⎵[with]⎵a⎵pi
    db $1E, $1C, $1E, $59, $C6 ; ece⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $A2, $2D, $3E ; H[ear]t!
    db $7F ; end of message

    ; ==========================================================================
    ; You're not qualified.
    ; Too bad!
    ; Why don't you try again?
    ; --------------------------------------------------------------------------
    ; $0E44E5
    Message_00CE:
    db $E8, $51, $CD, $C2, $59, $2A, $2E, $1A ; [You]'[re ][not]⎵qua
    db $25, $22, $1F, $22, $1E, $1D, $41 ; lified.
    db $75 ; line 2
    db $13, $28, $28, $59, $96, $1D, $3E ; Too⎵[ba]d!
    db $76 ; line 3
    db $16, $21, $32, $59, $9F, $C0, $E3, $59 ; Why⎵[do][n't ][you]⎵
    db $DB, $32, $59, $1A, $20, $8F, $3F ; [tr]y⎵ag[ain]?
    db $7F ; end of message

    ; ==========================================================================
    ; I don't have anything more to
    ; give you.
    ; I'm sorry!
    ; --------------------------------------------------------------------------
    ; $0E450D
    Message_00CF:
    db $08, $59, $9F, $C0, $AD, $59, $93, $32 ; I⎵[do][n't ][have]⎵[an]y
    db $D5, $20, $59, $26, $C8, $1E, $59, $DA ; [thin]g⎵m[or]e⎵[to]
    db $75 ; line 2
    db $AA, $E3, $41 ; [give ][you].
    db $76 ; line 3
    db $08, $51, $26, $59, $D2, $2B, $2B, $32 ; I'm⎵[so]rry
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; You have to enter the maze
    ; from the proper entrance or I
    ; can't clock your time…
    ; --------------------------------------------------------------------------
    ; $0E452C
    Message_00D0:
    db $E8, $59, $AD, $59, $DA, $59, $A3, $A1 ; [You]⎵[have]⎵[to]⎵[ent][er ]
    db $D8, $59, $BD, $33, $1E ; [the]⎵[ma]ze
    db $75 ; line 2
    db $A9, $26, $59, $D8, $59, $CC, $C9, $59 ; [fro]m⎵[the]⎵[pro][per]⎵
    db $A3, $2B, $93, $1C, $1E, $59, $C8, $59 ; [ent]r[an]ce⎵[or]⎵
    db $08 ; I
    db $76 ; line 3
    db $1C, $93, $51, $2D, $59, $1C, $BB, $9C ; c[an]'t⎵c[lo][ck]
    db $59, $E3, $2B, $59, $2D, $22, $BE, $43 ; ⎵[you]r⎵ti[me]…
    db $7F ; end of message

    ; ==========================================================================
    ; You, sir!  Have you been going
    ; through life without one of my
    ; hold-anything bottles?
    ; Well step right up and make
    ; your life complete!  I've got
    ; one on sale now for the low,
    ; low price of 100 Rupees!
    ; What do you say?  Interested?
    ;     > I'll take one
    ;        Don't need it
    ; --------------------------------------------------------------------------
    ; $0E455D
    Message_00D1:
    db $E8, $42, $59, $2C, $22, $2B, $3E, $8A ; [You],⎵sir![  ]
    db $07, $1A, $2F, $1E, $59, $E3, $59, $97 ; Have⎵[you]⎵[be]
    db $A0, $AC, $B4, $20 ; [en ][go][in]g
    db $75 ; line 2
    db $2D, $21, $2B, $28, $2E, $20, $21, $59 ; through⎵
    db $25, $22, $1F, $1E, $59, $DE, $C5, $C7 ; life⎵[with][out ][on]
    db $1E, $59, $C6, $59, $26, $32 ; e⎵[of]⎵my
    db $76 ; line 3
    db $21, $28, $25, $1D, $40, $93, $32, $D5 ; hold-[an]y[thin]
    db $20, $59, $98, $2D, $2D, $25, $1E, $2C ; g⎵[bo]ttles
    db $3F ; ?
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $1E, $25, $25, $59, $D3, $1E, $29 ; Well⎵[st]ep
    db $59, $2B, $B2, $DC, $59, $8C, $BD, $24 ; ⎵r[ight ][up]⎵[and ][ma]k
    db $1E ; e
    db $73 ; scroll text
    db $E3, $2B, $59, $25, $22, $1F, $1E, $59 ; [you]r⎵life⎵
    db $9B, $CA, $2D, $1E, $3E, $8A, $08, $51 ; [com][ple]te![  ]I'
    db $2F, $1E, $59, $AC, $2D ; ve⎵[go]t
    db $73 ; scroll text
    db $C7, $1E, $59, $C7, $59, $2C, $1A, $25 ; [on]e⎵[on]⎵sal
    db $1E, $59, $27, $28, $30, $59, $A8, $59 ; e⎵now⎵[for]⎵
    db $D8, $59, $BB, $30, $42 ; [the]⎵[lo]w,
    db $7E ; wait for key
    db $73 ; scroll text
    db $BB, $30, $59, $29, $2B, $22, $1C, $1E ; [lo]w⎵price
    db $59, $C6, $59, $35, $34, $34, $59, $11 ; ⎵[of]⎵100⎵R
    db $DC, $1E, $1E, $2C, $3E ; [up]ees!
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $9F, $59, $E3, $59 ; W[ha]t⎵[do]⎵[you]⎵
    db $2C, $1A, $32, $3F, $8A, $08, $27, $D6 ; say?[  ]In[ter]
    db $1E, $D3, $1E, $1D, $3F ; e[st]ed?
    db $73 ; scroll text
    db $88, $44, $59, $08, $51, $25, $25, $59 ; [    ]>⎵I'll⎵
    db $2D, $1A, $24, $1E, $59, $C7, $1E ; take⎵[on]e
    db $73 ; scroll text
    db $88, $89, $03, $C7, $51, $2D, $59, $27 ; [    ][   ]D[on]'t⎵n
    db $1E, $A4, $B6 ; e[ed ][it]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Good buy!  Thanks a lot!
    ; Now, hold it above your head
    ; for the whole world to see, OK?
    ; It's good for business!
    ; --------------------------------------------------------------------------
    ; $0E4625
    Message_00D2:
    db $06, $28, $28, $1D, $59, $1B, $2E, $32 ; Good⎵buy
    db $3E, $8A, $E5, $27, $24, $2C, $59, $1A ; ![  ][Tha]nks⎵a
    db $59, $BB, $2D, $3E ; ⎵[lo]t!
    db $75 ; line 2
    db $0D, $28, $30, $42, $59, $21, $28, $25 ; Now,⎵hol
    db $1D, $59, $B6, $59, $1A, $98, $2F, $1E ; d⎵[it]⎵a[bo]ve
    db $59, $E3, $2B, $59, $21, $1E, $1A, $1D ; ⎵[you]r⎵head
    db $76 ; line 3
    db $A8, $59, $D8, $59, $E1, $28, $25, $1E ; [for]⎵[the]⎵[wh]ole
    db $59, $30, $C8, $25, $1D, $59, $DA, $59 ; ⎵w[or]ld⎵[to]⎵
    db $D0, $1E, $42, $59, $0E, $0A, $3F ; [se]e,⎵OK?
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $2D, $8B, $AC, $28, $1D, $59, $A8 ; It['s ][go]od⎵[for]
    db $59, $1B, $2E, $2C, $B4, $1E, $2C, $2C ; ⎵bus[in]ess
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; So you're broke, eh?  Too bad…
    ; Come back after you earn more
    ; Rupees.  It might still be here.
    ; --------------------------------------------------------------------------
    ; $0E467E
    Message_00D3:
    db $12, $28, $59, $E3, $51, $CD, $1B, $2B ; So⎵[you]'[re ]br
    db $28, $24, $1E, $42, $59, $1E, $21, $3F ; oke,⎵eh?
    db $8A, $13, $28, $28, $59, $96, $1D, $43 ; [  ]Too⎵[ba]d…
    db $75 ; line 2
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $1F, $D4, $E3, $59, $A2, $27, $59, $26 ; f[ter ][you]⎵[ear]n⎵m
    db $C8, $1E ; [or]e
    db $76 ; line 3
    db $11, $DC, $1E, $1E, $2C, $41, $8A, $08 ; R[up]ees.[  ]I
    db $2D, $59, $26, $B2, $D3, $22, $25, $25 ; t⎵m[ight ][st]ill
    db $59, $97, $59, $AF, $1E, $41 ; ⎵[be]⎵[her]e.
    db $7F ; end of message

    ; ==========================================================================
    ; I'm all sold out of bottles.
    ; Come back later, OK? 
    ;  … … …
    ; --------------------------------------------------------------------------
    ; $0E46C1
    Message_00D4:
    db $08, $51, $26, $59, $8E, $D2, $25, $1D ; I'm⎵[all ][so]ld
    db $59, $C5, $C6, $59, $98, $2D, $2D, $25 ; ⎵[out ][of]⎵[bo]ttl
    db $1E, $2C, $41 ; es.
    db $75 ; line 2
    db $02, $28, $BE, $59, $96, $9C, $59, $BA ; Co[me]⎵[ba][ck]⎵[la]
    db $D6, $42, $59, $0E, $0A, $3F, $59 ; [ter],⎵OK?⎵
    db $76 ; line 3
    db $59, $43, $59, $43, $59, $43 ; ⎵…⎵…⎵…
    db $7F ; end of message

    ; ==========================================================================
    ; Wow!  I've never seen such a
    ; rare bug!  I'll buy it for
    ; 100 Rupees, OK?  Done!
    ; --------------------------------------------------------------------------
    ; $0E46EC
    Message_00D5:
    db $16, $28, $30, $3E, $8A, $08, $51, $2F ; Wow![  ]I'v
    db $1E, $59, $27, $A7, $A1, $D0, $A0, $2C ; e⎵n[ev][er ][se][en ]s
    db $2E, $1C, $21, $59, $1A ; uch⎵a
    db $75 ; line 2
    db $2B, $8D, $1B, $2E, $20, $3E, $8A, $08 ; r[are ]bug![  ]I
    db $51, $25, $25, $59, $1B, $2E, $32, $59 ; 'll⎵buy⎵
    db $B6, $59, $A8 ; [it]⎵[for]
    db $76 ; line 3
    db $35, $34, $34, $59, $11, $DC, $1E, $1E ; 100⎵R[up]ee
    db $2C, $42, $59, $0E, $0A, $3F, $8A, $03 ; s,⎵OK?[  ]D
    db $C7, $1E, $3E ; [on]e!
    db $7F ; end of message

    ; ==========================================================================
    ; Hey!  They say eating fish
    ; makes you smart.  You have to
    ; give me this fish for this
    ; stuff, OK?  Done!
    ; --------------------------------------------------------------------------
    ; $0E472A
    Message_00D6:
    db $07, $1E, $32, $3E, $8A, $E6, $32, $59 ; Hey![  ][The]y⎵
    db $2C, $1A, $32, $59, $1E, $94, $B3, $1F ; say⎵e[at][ing ]f
    db $B5, $21 ; [is]h
    db $75 ; line 2
    db $BD, $24, $1E, $2C, $59, $E3, $59, $2C ; [ma]kes⎵[you]⎵s
    db $BD, $2B, $2D, $41, $8A, $E8, $59, $AD ; [ma]rt.[  ][You]⎵[have]
    db $59, $DA ; ⎵[to]
    db $76 ; line 3
    db $AA, $BE, $59, $D9, $2C, $59, $1F, $B5 ; [give ][me]⎵[thi]s⎵f[is]
    db $21, $59, $A8, $59, $D9, $2C ; h⎵[for]⎵[thi]s
    db $7E ; wait for key
    db $73 ; scroll text
    db $D3, $2E, $1F, $1F, $42, $59, $0E, $0A ; [st]uff,⎵OK
    db $3F, $8A, $03, $C7, $1E, $3E ; ?[  ]D[on]e!
    db $7F ; end of message

    ; ==========================================================================
    ; Yo!  [LINK]! You seem to be in
    ; a heap of trouble, but this is
    ; all I can give you.
    ; --------------------------------------------------------------------------
    ; $0E476F
    Message_00D7:
    db $18, $28, $3E, $8A, $6A, $3E, $59, $E8 ; Yo![  ][LINK]!⎵[You]
    db $59, $D0, $1E, $26, $59, $DA, $59, $97 ; ⎵[se]em⎵[to]⎵[be]
    db $59, $B4 ; ⎵[in]
    db $75 ; line 2
    db $1A, $59, $21, $1E, $1A, $29, $59, $C6 ; a⎵heap⎵[of]
    db $59, $DB, $28, $2E, $95, $42, $59, $1B ; ⎵[tr]ou[ble],⎵b
    db $2E, $2D, $59, $D9, $2C, $59, $B5 ; ut⎵[thi]s⎵[is]
    db $76 ; line 3
    db $8E, $08, $59, $99, $AA, $E3, $41 ; [all ]I⎵[can ][give ][you].
    db $7F ; end of message

    ; ==========================================================================
    ; Hey you!
    ; Welcome!
    ; 
    ; Ask us to do anything!
    ;     > Temper my sword
    ;        I just dropped by
    ; --------------------------------------------------------------------------
    ; $0E47A2
    Message_00D8:
    db $07, $1E, $32, $59, $E3, $3E ; Hey⎵[you]!
    db $75 ; line 2
    db $16, $1E, $25, $9B, $1E, $3E ; Wel[com]e!
    db $76 ; line 3
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $2C, $24, $59, $2E, $2C, $59, $DA ; Ask⎵us⎵[to]
    db $59, $9F, $59, $93, $32, $D5, $20, $3E ; ⎵[do]⎵[an]y[thin]g!
    db $73 ; scroll text
    db $88, $44, $59, $13, $1E, $26, $C9, $59 ; [    ]>⎵Tem[per]⎵
    db $26, $32, $59, $2C, $30, $C8, $1D ; my⎵sw[or]d
    db $73 ; scroll text
    db $88, $89, $08, $59, $B7, $59, $1D, $2B ; [    ][   ]I⎵[just]⎵dr
    db $28, $29, $29, $A4, $1B, $32 ; opp[ed ]by
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; I'll give you a big discount!
    ;     >Sword Tempered… 10 Rupees
    ;       Wait a minute
    ; --------------------------------------------------------------------------
    ; $0E47E3
    Message_00D9:
    db $08, $51, $25, $25, $59, $AA, $E3, $59 ; I'll⎵[give ][you]⎵
    db $1A, $59, $1B, $22, $20, $59, $9E, $2C ; a⎵big⎵[di]s
    db $1C, $28, $2E, $27, $2D, $3E ; count!
    db $75 ; line 2
    db $88, $44, $12, $30, $C8, $1D, $59, $13 ; [    ]>Sw[or]d⎵T
    db $1E, $26, $C9, $1E, $1D, $43, $59, $35 ; em[per]ed…⎵1
    db $34, $59, $11, $DC, $1E, $1E, $2C ; 0⎵R[up]ees
    db $76 ; line 3
    db $88, $8A, $16, $1A, $B6, $59, $1A, $59 ; [    ][  ]Wa[it]⎵a⎵
    db $26, $B4, $2E, $2D, $1E ; m[in]ute
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Tempered, eh?  Are you sure?
    ;     > Yes
    ;        I changed my mind
    ; --------------------------------------------------------------------------
    ; $0E4821
    Message_00DA:
    db $13, $1E, $26, $C9, $1E, $1D, $42, $59 ; Tem[per]ed,⎵
    db $1E, $21, $3F, $8A, $00, $CD, $E3, $59 ; eh?[  ]A[re ][you]⎵
    db $2C, $2E, $CE, $3F ; su[re]?
    db $75 ; line 2
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $76 ; line 3
    db $88, $89, $08, $59, $1C, $B1, $27, $20 ; [    ][   ]I⎵c[ha]ng
    db $A4, $26, $32, $59, $26, $B4, $1D ; [ed ]my⎵m[in]d
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Well, we can't make it any
    ; stronger than that… Sorry!
    ; --------------------------------------------------------------------------
    ; $0E484E
    Message_00DB:
    db $16, $1E, $25, $25, $42, $59, $E0, $59 ; Well,⎵[we]⎵
    db $1C, $93, $51, $2D, $59, $BD, $24, $1E ; c[an]'t⎵[ma]ke
    db $59, $B6, $59, $93, $32 ; ⎵[it]⎵[an]y
    db $75 ; line 2
    db $D3, $2B, $C7, $20, $A1, $D7, $27, $59 ; [st]r[on]g[er ][tha]n⎵
    db $D7, $2D, $43, $59, $12, $C8, $2B, $32 ; [tha]t…⎵S[or]ry
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Drop by again anytime you
    ; want to.  Hi ho!  Hi ho!
    ; We're off to work!
    ; --------------------------------------------------------------------------
    ; $0E4876
    Message_00DC:
    db $03, $2B, $28, $29, $59, $1B, $32, $59 ; Drop⎵by⎵
    db $1A, $20, $8F, $59, $93, $32, $2D, $22 ; ag[ain]⎵[an]yti
    db $BE, $59, $E3 ; [me]⎵[you]
    db $75 ; line 2
    db $DF, $27, $2D, $59, $DA, $41, $8A, $07 ; [wa]nt⎵[to].[  ]H
    db $22, $59, $21, $28, $3E, $8A, $07, $22 ; i⎵ho![  ]Hi
    db $59, $21, $28, $3E ; ⎵ho!
    db $76 ; line 3
    db $16, $1E, $51, $CD, $C6, $1F, $59, $DA ; We'[re ][of]f⎵[to]
    db $59, $30, $C8, $24, $3E ; ⎵w[or]k!
    db $7F ; end of message

    ; ==========================================================================
    ; All right, no problem.
    ; We'll have to keep your sword
    ; for a while.
    ; --------------------------------------------------------------------------
    ; $0E48AD
    Message_00DD:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $42, $59, $27, $28, $59, $CC, $95 ; t,⎵no⎵[pro][ble]
    db $26, $41 ; m.
    db $75 ; line 2
    db $16, $1E, $51, $25, $25, $59, $AD, $59 ; We'll⎵[have]⎵
    db $DA, $59, $24, $1E, $1E, $29, $59, $E3 ; [to]⎵keep⎵[you]
    db $2B, $59, $2C, $30, $C8, $1D ; r⎵sw[or]d
    db $76 ; line 3
    db $A8, $59, $1A, $59, $E1, $22, $25, $1E ; [for]⎵a⎵[wh]ile
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Your sword is tempered-up!
    ; Now hold it!
    ; --------------------------------------------------------------------------
    ; $0E48E1
    Message_00DE:
    db $E8, $2B, $59, $2C, $30, $C8, $1D, $59 ; [You]r⎵sw[or]d⎵
    db $B5, $59, $2D, $1E, $26, $C9, $1E, $1D ; [is]⎵tem[per]ed
    db $40, $DC, $3E ; -[up]!
    db $75 ; line 2
    db $0D, $28, $30, $59, $21, $28, $25, $1D ; Now⎵hold
    db $59, $B6, $3E ; ⎵[it]!
    db $7F ; end of message

    ; ==========================================================================
    ; If my lost partner returns,
    ; we can temper your sword,
    ; but now, I can't do
    ; anything for you.
    ; --------------------------------------------------------------------------
    ; $0E4901
    Message_00DF:
    db $08, $1F, $59, $26, $32, $59, $BB, $D3 ; If⎵my⎵[lo][st]
    db $59, $29, $1A, $2B, $2D, $27, $A1, $CE ; ⎵partn[er ][re]
    db $2D, $2E, $2B, $27, $2C, $42 ; turns,
    db $75 ; line 2
    db $E0, $59, $99, $2D, $1E, $26, $C9, $59 ; [we]⎵[can ]tem[per]⎵
    db $E3, $2B, $59, $2C, $30, $C8, $1D, $42 ; [you]r⎵sw[or]d,
    db $76 ; line 3
    db $1B, $2E, $2D, $59, $27, $28, $30, $42 ; but⎵now,
    db $59, $08, $59, $1C, $93, $51, $2D, $59 ; ⎵I⎵c[an]'t⎵
    db $9F ; [do]
    db $7E ; wait for key
    db $73 ; scroll text
    db $93, $32, $D5, $20, $59, $A8, $59, $E3 ; [an]y[thin]g⎵[for]⎵[you]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Oh!  Happy days are here again!
    ; You found my partner!
    ; …  We are very happy now…
    ; Drop by here again!
    ; At that time, we will temper
    ; your sword perfectly!
    ; --------------------------------------------------------------------------
    ; $0E4946
    Message_00E0:
    db $0E, $21, $3E, $8A, $07, $1A, $29, $29 ; Oh![  ]Happ
    db $32, $59, $1D, $1A, $32, $2C, $59, $8D ; y⎵days⎵[are ]
    db $AF, $1E, $59, $1A, $20, $8F, $3E ; [her]e⎵ag[ain]!
    db $75 ; line 2
    db $E8, $59, $1F, $C4, $59, $26, $32, $59 ; [You]⎵f[ound]⎵my⎵
    db $29, $1A, $2B, $2D, $27, $A6, $3E ; partn[er]!
    db $76 ; line 3
    db $43, $8A, $16, $1E, $59, $8D, $DD, $32 ; …[  ]We⎵[are ][ver]y
    db $59, $B1, $29, $29, $32, $59, $27, $28 ; ⎵[ha]ppy⎵no
    db $30, $43 ; w…
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $2B, $28, $29, $59, $1B, $32, $59 ; Drop⎵by⎵
    db $AF, $1E, $59, $1A, $20, $8F, $3E ; [her]e⎵ag[ain]!
    db $73 ; scroll text
    db $00, $2D, $59, $D7, $2D, $59, $2D, $22 ; At⎵[tha]t⎵ti
    db $BE, $42, $59, $E0, $59, $E2, $25, $25 ; [me],⎵[we]⎵[wi]ll
    db $59, $2D, $1E, $26, $C9 ; ⎵tem[per]
    db $73 ; scroll text
    db $E3, $2B, $59, $2C, $30, $C8, $1D, $59 ; [you]r⎵sw[or]d⎵
    db $C9, $1F, $1E, $1C, $2D, $25, $32, $3E ; [per]fectly!
    db $7F ; end of message

    ; ==========================================================================
    ; Ribbit ribbit…  Your body did
    ; not change!  You are not just
    ; an ordinary guy, are you?
    ; I used to live in Kakariko Town.
    ; I wonder what my partner is
    ; doing there without me…
    ; Ribbit!  I have a request of
    ; you.
    ; Please take me to my partner!
    ; Please!  Ribbit!  Please!
    ; --------------------------------------------------------------------------
    ; $0E49B9
    Message_00E1:
    db $11, $22, $1B, $1B, $B6, $59, $2B, $22 ; Ribb[it]⎵ri
    db $1B, $1B, $B6, $43, $8A, $E8, $2B, $59 ; bb[it]…[  ][You]r⎵
    db $98, $1D, $32, $59, $9E, $1D ; [bo]dy⎵[di]d
    db $75 ; line 2
    db $C2, $59, $1C, $B1, $27, $20, $1E, $3E ; [not]⎵c[ha]nge!
    db $8A, $E8, $59, $8D, $C2, $59, $B7 ; [  ][You]⎵[are ][not]⎵[just]
    db $76 ; line 3
    db $93, $59, $C8, $9E, $27, $1A, $2B, $32 ; [an]⎵[or][di]nary
    db $59, $20, $2E, $32, $42, $59, $8D, $E3 ; ⎵guy,⎵[are ][you]
    db $3F ; ?
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $2E, $D0, $1D, $59, $DA, $59 ; I⎵u[se]d⎵[to]⎵
    db $25, $22, $2F, $1E, $59, $B4, $59, $0A ; live⎵[in]⎵K
    db $1A, $24, $1A, $2B, $22, $24, $28, $59 ; akariko⎵
    db $13, $28, $30, $27, $41 ; Town.
    db $73 ; scroll text
    db $08, $59, $30, $C7, $1D, $A1, $E1, $91 ; I⎵w[on]d[er ][wh][at ]
    db $26, $32, $59, $29, $1A, $2B, $2D, $27 ; my⎵partn
    db $A1, $B5 ; [er ][is]
    db $73 ; scroll text
    db $9F, $B3, $D8, $CD, $DE, $C5, $BE, $43 ; [do][ing ][the][re ][with][out ][me]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $11, $22, $1B, $1B, $B6, $3E, $8A, $08 ; Ribb[it]![  ]I
    db $59, $AD, $59, $1A, $59, $CE, $2A, $2E ; ⎵[have]⎵a⎵[re]qu
    db $1E, $D3, $59, $C6 ; e[st]⎵[of]
    db $73 ; scroll text
    db $E3, $41 ; [you].
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $59, $2D, $1A ; Plea[se]⎵ta
    db $24, $1E, $59, $BE, $59, $DA, $59, $26 ; ke⎵[me]⎵[to]⎵m
    db $32, $59, $29, $1A, $2B, $2D, $27, $A6 ; y⎵partn[er]
    db $3E ; !
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $3E, $8A, $11 ; Plea[se]![  ]R
    db $22, $1B, $1B, $B6, $3E, $8A, $0F, $25 ; ibb[it]![  ]Pl
    db $1E, $1A, $D0, $3E ; ea[se]!
    db $7F ; end of message

    ; ==========================================================================
    ; I'm sorry, we're not done yet.
    ; Come back after a while.
    ; --------------------------------------------------------------------------
    ; $0E4A76
    Message_00E2:
    db $08, $51, $26, $59, $D2, $2B, $2B, $32 ; I'm⎵[so]rry
    db $42, $59, $E0, $51, $CD, $C2, $59, $9F ; ,⎵[we]'[re ][not]⎵[do]
    db $27, $1E, $59, $32, $1E, $2D, $41 ; ne⎵yet.
    db $75 ; line 2
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $1F, $D4, $1A, $59, $E1, $22, $25, $1E ; f[ter ]a⎵[wh]ile
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Thank you!
    ; 
    ; Thank you!
    ; --------------------------------------------------------------------------
    ; $0E4AA0
    Message_00E3:
    db $E5, $27, $24, $59, $E3, $3E ; [Tha]nk⎵[you]!
    db $75 ; line 2
    db $76 ; line 3
    db $E5, $27, $24, $59, $E3, $3E ; [Tha]nk⎵[you]!
    db $7F ; end of message

    ; ==========================================================================
    ; Hey hey, amateurs shouldn't
    ; try to do this.  You're just
    ; getting in the way!
    ; --------------------------------------------------------------------------
    ; $0E4AAF
    Message_00E4:
    db $07, $1E, $32, $59, $21, $1E, $32, $42 ; Hey⎵hey,
    db $59, $1A, $BD, $2D, $1E, $2E, $2B, $2C ; ⎵a[ma]teurs
    db $59, $D1, $28, $2E, $25, $1D, $27, $51 ; ⎵[sh]ouldn'
    db $2D ; t
    db $75 ; line 2
    db $DB, $32, $59, $DA, $59, $9F, $59, $D9 ; [tr]y⎵[to]⎵[do]⎵[thi]
    db $2C, $41, $8A, $E8, $51, $CD, $B7 ; s.[  ][You]'[re ][just]
    db $76 ; line 3
    db $AB, $2D, $B3, $B4, $59, $D8, $59, $DF ; [get]t[ing ][in]⎵[the]⎵[wa]
    db $32, $3E ; y!
    db $7F ; end of message

    ; ==========================================================================
    ; After wandering into this world
    ; I turned into this shape.
    ; …  …  …
    ; I enjoyed playing the flute in
    ; the original world…
    ; …  …  …
    ; There was a small grove where
    ; many animals gathered.  I want
    ; to see that place again…
    ; I buried my flute there with
    ; some flower seeds.
    ; 
    ; Will you try to find it for me?
    ;     > Yes
    ;        No way
    ; --------------------------------------------------------------------------
    ; $0E4AE4
    Message_00E5:
    db $00, $1F, $D4, $DF, $27, $1D, $A6, $B3 ; Af[ter ][wa]nd[er][ing ]
    db $B4, $DA, $59, $D9, $2C, $59, $30, $C8 ; [in][to]⎵[thi]s⎵w[or]
    db $25, $1D ; ld
    db $75 ; line 2
    db $08, $59, $2D, $2E, $2B, $27, $A4, $B4 ; I⎵turn[ed ][in]
    db $DA, $59, $D9, $2C, $59, $D1, $1A, $29 ; [to]⎵[thi]s⎵[sh]ap
    db $1E, $41 ; e.
    db $76 ; line 3
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $A5, $23, $28, $32, $A4, $29 ; I⎵[en]joy[ed ]p
    db $BA, $32, $B3, $D8, $59, $1F, $25, $2E ; [la]y[ing ][the]⎵flu
    db $2D, $1E, $59, $B4 ; te⎵[in]
    db $73 ; scroll text
    db $D8, $59, $C8, $22, $20, $B4, $1A, $25 ; [the]⎵[or]ig[in]al
    db $59, $30, $C8, $25, $1D, $43 ; ⎵w[or]ld…
    db $73 ; scroll text
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $CD, $DF, $2C, $59, $1A, $59, $2C ; [The][re ][wa]s⎵a⎵s
    db $BD, $25, $25, $59, $20, $2B, $28, $2F ; [ma]ll⎵grov
    db $1E, $59, $E1, $A6, $1E ; e⎵[wh][er]e
    db $73 ; scroll text
    db $BC, $32, $59, $93, $22, $BD, $25, $2C ; [man]y⎵[an]i[ma]ls
    db $59, $20, $94, $AF, $1E, $1D, $41, $8A ; ⎵g[at][her]ed.[  ]
    db $08, $59, $DF, $27, $2D ; I⎵[wa]nt
    db $73 ; scroll text
    db $DA, $59, $D0, $1E, $59, $D7, $2D, $59 ; [to]⎵[se]e⎵[tha]t⎵
    db $29, $BA, $1C, $1E, $59, $1A, $20, $8F ; p[la]ce⎵ag[ain]
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $1B, $2E, $2B, $22, $A4, $26 ; I⎵buri[ed ]m
    db $32, $59, $1F, $25, $2E, $2D, $1E, $59 ; y⎵flute⎵
    db $D8, $CD, $DE ; [the][re ][with]
    db $73 ; scroll text
    db $CF, $59, $1F, $BB, $E0, $2B, $59, $D0 ; [some]⎵f[lo][we]r⎵[se]
    db $1E, $1D, $2C, $41 ; eds.
    db $73 ; scroll text
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $22, $25, $25, $59, $E3, $59, $DB ; Will⎵[you]⎵[tr]
    db $32, $59, $DA, $59, $1F, $B4, $1D, $59 ; y⎵[to]⎵f[in]d⎵
    db $B6, $59, $A8, $59, $BE, $3F ; [it]⎵[for]⎵[me]?
    db $73 ; scroll text
    db $88, $44, $59, $18, $1E, $2C ; [    ]>⎵Yes
    db $73 ; scroll text
    db $88, $89, $0D, $28, $59, $DF, $32 ; [    ][   ]No⎵[wa]y
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Then I will lend you my shovel.
    ; Good luck!
    ; --------------------------------------------------------------------------
    ; $0E4BC5
    Message_00E6:
    db $E6, $27, $59, $08, $59, $E2, $25, $25 ; [The]n⎵I⎵[wi]ll
    db $59, $25, $A5, $1D, $59, $E3, $59, $26 ; ⎵l[en]d⎵[you]⎵m
    db $32, $59, $D1, $28, $2F, $1E, $25, $41 ; y⎵[sh]ovel.
    db $75 ; line 2
    db $06, $28, $28, $1D, $59, $25, $2E, $9C ; Good⎵lu[ck]
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; …  …  …
    ; I see.  I won't ask you again…
    ; Good bye.
    ; --------------------------------------------------------------------------
    ; $0E4BE8
    Message_00E7:
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $75 ; line 2
    db $08, $59, $D0, $1E, $41, $8A, $08, $59 ; I⎵[se]e.[  ]I⎵
    db $30, $C7, $51, $2D, $59, $1A, $2C, $24 ; w[on]'t⎵ask
    db $59, $E3, $59, $1A, $20, $8F, $43 ; ⎵[you]⎵ag[ain]…
    db $76 ; line 3
    db $06, $28, $28, $1D, $59, $1B, $32, $1E ; Good⎵bye
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Did you find my flute?
    ; …  …  …
    ; Please keep looking for it…
    ; --------------------------------------------------------------------------
    ; $0E4C10
    Message_00E8:
    db $03, $22, $1D, $59, $E3, $59, $1F, $B4 ; Did⎵[you]⎵f[in]
    db $1D, $59, $26, $32, $59, $1F, $25, $2E ; d⎵my⎵flu
    db $2D, $1E, $3F ; te?
    db $75 ; line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $76 ; line 3
    db $0F, $25, $1E, $1A, $D0, $59, $24, $1E ; Plea[se]⎵ke
    db $1E, $29, $59, $BB, $28, $24, $B3, $A8 ; ep⎵[lo]ok[ing ][for]
    db $59, $B6, $43 ; ⎵[it]…
    db $7F ; end of message

    ; ==========================================================================
    ; Thank you, [LINK].  But it
    ; looks like I can't play my flute
    ; any more.  Please take it.
    ; If by chance you go to the
    ; village I lived in, please give
    ; it to a tired old man you will
    ; find there.
    ; …  …  …
    ; Well,  my mind is getting
    ; hazy…
    ; Please let me hear the sound of
    ; the flute one last time…
    ; --------------------------------------------------------------------------
    ; $0E4C3E
    Message_00E9:
    db $E5, $27, $24, $59, $E3, $42, $59, $6A ; [Tha]nk⎵[you],⎵[LINK]
    db $41, $8A, $01, $2E, $2D, $59, $B6 ; .[  ]But⎵[it]
    db $75 ; line 2
    db $BB, $28, $24, $2C, $59, $25, $22, $24 ; [lo]oks⎵lik
    db $1E, $59, $08, $59, $1C, $93, $51, $2D ; e⎵I⎵c[an]'t
    db $59, $29, $BA, $32, $59, $26, $32, $59 ; ⎵p[la]y⎵my⎵
    db $1F, $25, $2E, $2D, $1E ; flute
    db $76 ; line 3
    db $93, $32, $59, $26, $C8, $1E, $41, $8A ; [an]y⎵m[or]e.[  ]
    db $0F, $25, $1E, $1A, $D0, $59, $2D, $1A ; Plea[se]⎵ta
    db $24, $1E, $59, $B6, $41 ; ke⎵[it].
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $1B, $32, $59, $1C, $B1 ; If⎵by⎵c[ha]
    db $27, $1C, $1E, $59, $E3, $59, $AC, $59 ; nce⎵[you]⎵[go]⎵
    db $DA, $59, $D8 ; [to]⎵[the]
    db $73 ; scroll text
    db $2F, $22, $25, $BA, $20, $1E, $59, $08 ; vil[la]ge⎵I
    db $59, $25, $22, $2F, $A4, $B4, $42, $59 ; ⎵liv[ed ][in],⎵
    db $CA, $1A, $D0, $59, $20, $22, $2F, $1E ; [ple]a[se]⎵give
    db $73 ; scroll text
    db $B6, $59, $DA, $59, $1A, $59, $2D, $22 ; [it]⎵[to]⎵a⎵ti
    db $CE, $1D, $59, $28, $25, $1D, $59, $BC ; [re]d⎵old⎵[man]
    db $59, $E3, $59, $E2, $25, $25 ; ⎵[you]⎵[wi]ll
    db $7E ; wait for key
    db $73 ; scroll text
    db $1F, $B4, $1D, $59, $D8, $CE, $41 ; f[in]d⎵[the][re].
    db $73 ; scroll text
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $73 ; scroll text
    db $16, $1E, $25, $25, $42, $8A, $26, $32 ; Well,[  ]my
    db $59, $26, $B4, $1D, $59, $B5, $59, $AB ; ⎵m[in]d⎵[is]⎵[get]
    db $2D, $B4, $20 ; t[in]g
    db $7E ; wait for key
    db $73 ; scroll text
    db $B1, $33, $32, $43 ; [ha]zy…
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $59, $25, $1E ; Plea[se]⎵le
    db $2D, $59, $BE, $59, $21, $A2, $59, $D8 ; t⎵[me]⎵h[ear]⎵[the]
    db $59, $D2, $2E, $27, $1D, $59, $C6 ; ⎵[so]und⎵[of]
    db $73 ; scroll text
    db $D8, $59, $1F, $25, $2E, $2D, $1E, $59 ; [the]⎵flute⎵
    db $C7, $1E, $59, $BA, $D3, $59, $2D, $22 ; [on]e⎵[la][st]⎵ti
    db $BE, $43 ; [me]…
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will find the elder
    ; Sahasrahla…
    ; --------------------------------------------------------------------------
    ; $0E4D1B
    Message_00EA:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $D8, $59, $1E, $25, $1D, $A6 ; d⎵[the]⎵eld[er]
    db $76 ; line 3
    db $12, $1A, $AE, $2B, $1A, $21, $BA, $43 ; Sa[has]rah[la]…
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; You will open a desert lock with
    ; the Book of Mudora.
    ; --------------------------------------------------------------------------
    ; $0E4D44
    Message_00EB:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $C3, $59 ; [You]⎵[wi]ll⎵[open]⎵
    db $1A, $59, $9D, $A6, $2D, $59, $BB, $9C ; a⎵[des][er]t⎵[lo][ck]
    db $59, $DE ; ⎵[with]
    db $76 ; line 3
    db $D8, $59, $01, $28, $28, $24, $59, $C6 ; [the]⎵Book⎵[of]
    db $59, $0C, $2E, $9F, $2B, $1A, $41 ; ⎵Mu[do]ra.
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will find a member of the
    ; wise men's line in the desert.
    ; --------------------------------------------------------------------------
    ; $0E4D7E
    Message_00EC:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $1A, $59, $BE, $26, $97, $2B ; d⎵a⎵[me]m[be]r
    db $59, $C6, $59, $D8 ; ⎵[of]⎵[the]
    db $76 ; line 3
    db $E2, $D0, $59, $BE, $27, $8B, $25, $B4 ; [wi][se]⎵[me]n['s ]l[in]
    db $1E, $59, $B4, $59, $D8, $59, $9D, $A6 ; e⎵[in]⎵[the]⎵[des][er]
    db $2D, $41 ; t.
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; You will find a mushroom lover
    ; at the Magic Shop…
    ; --------------------------------------------------------------------------
    ; $0E4DB5
    Message_00ED:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $1A, $59, $BF, $D1, $2B, $28 ; d⎵a⎵[mu][sh]ro
    db $28, $26, $59, $BB, $DD ; om⎵[lo][ver]
    db $76 ; line 3
    db $91, $D8, $59, $0C, $1A, $20, $22, $1C ; [at ][the]⎵Magic
    db $59, $12, $21, $28, $29, $43 ; ⎵Shop…
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will meet Zora living in a
    ; lake at the river's source…
    ; --------------------------------------------------------------------------
    ; $0E4DF1
    Message_00EE:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $BE, $1E ; [You]⎵[wi]ll⎵[me]e
    db $2D, $59, $19, $C8, $1A, $59, $25, $22 ; t⎵Z[or]a⎵li
    db $2F, $B3, $B4, $59, $1A ; v[ing ][in]⎵a
    db $76 ; line 3
    db $BA, $24, $1E, $59, $91, $D8, $59, $2B ; [la]ke⎵[at ][the]⎵r
    db $22, $DD, $8B, $D2, $2E, $2B, $1C, $1E ; i[ver]['s ][so]urce
    db $43 ; …
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; The true Hero will find the
    ; Moon Pearl in the
    ; mountain tower.
    ; --------------------------------------------------------------------------
    ; $0E4E28
    Message_00EF:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E6, $59, $DB, $2E, $1E, $59, $E4, $28 ; [The]⎵[tr]ue⎵[Her]o
    db $59, $E2, $25, $25, $59, $1F, $B4, $1D ; ⎵[wi]ll⎵f[in]d
    db $59, $D8 ; ⎵[the]
    db $76 ; line 3
    db $0C, $28, $C7, $59, $0F, $A2, $25, $59 ; Mo[on]⎵P[ear]l⎵
    db $B4, $59, $D8 ; [in]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $26, $28, $2E, $27, $2D, $8F, $59, $DA ; mount[ain]⎵[to]
    db $E0, $2B, $41 ; [we]r.
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; Even the mighty Master Sword
    ; cannot harm the wizard's body.
    ; --------------------------------------------------------------------------
    ; $0E4E6B
    Message_00F0:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $04, $2F, $A0, $D8, $59, $26, $22, $20 ; Ev[en ][the]⎵mig
    db $21, $2D, $32, $59, $0C, $92, $A1, $12 ; hty⎵M[ast][er ]S
    db $30, $C8, $1D ; w[or]d
    db $76 ; line 3
    db $1C, $93, $C2, $59, $B1, $2B, $26, $59 ; c[an][not]⎵[ha]rm⎵
    db $D8, $59, $E2, $33, $1A, $2B, $1D, $8B ; [the]⎵[wi]zard['s ]
    db $98, $1D, $32, $41 ; [bo]dy.
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; The true Hero will jump into the
    ; well near the smithy's shop.
    ; --------------------------------------------------------------------------
    ; $0E4EA3
    Message_00F1:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E6, $59, $DB, $2E, $1E, $59, $E4, $28 ; [The]⎵[tr]ue⎵[Her]o
    db $59, $E2, $25, $25, $59, $23, $2E, $26 ; ⎵[wi]ll⎵jum
    db $29, $59, $B4, $DA, $59, $D8 ; p⎵[in][to]⎵[the]
    db $76 ; line 3
    db $E0, $25, $25, $59, $27, $A2, $59, $D8 ; [we]ll⎵n[ear]⎵[the]
    db $59, $2C, $26, $B6, $21, $32, $8B, $D1 ; ⎵sm[it]hy['s ][sh]
    db $28, $29, $41 ; op.
    db $7F ; end of message

    ; ==========================================================================
    ; Well, I have to say my condition
    ; isn't very good today.  But I
    ; want you to come back again…
    ; --------------------------------------------------------------------------
    ; $0E4EE5
    Message_00F2:
    db $6D, $01 ; set window position
    db $16, $1E, $25, $25, $42, $59, $08, $59 ; Well,⎵I⎵
    db $AD, $59, $DA, $59, $2C, $1A, $32, $59 ; [have]⎵[to]⎵say⎵
    db $26, $32, $59, $1C, $C7, $9E, $2D, $22 ; my⎵c[on][di]ti
    db $C7 ; [on]
    db $75 ; line 2
    db $B5, $C0, $DD, $32, $59, $AC, $28, $1D ; [is][n't ][ver]y⎵[go]od
    db $59, $DA, $1D, $1A, $32, $41, $8A, $01 ; ⎵[to]day.[  ]B
    db $2E, $2D, $59, $08 ; ut⎵I
    db $76 ; line 3
    db $DF, $27, $2D, $59, $E3, $59, $DA, $59 ; [wa]nt⎵[you]⎵[to]⎵
    db $9B, $1E, $59, $96, $9C, $59, $1A, $20 ; [com]e⎵[ba][ck]⎵ag
    db $8F, $43 ; [ain]…
    db $7F ; end of message

    ; ==========================================================================
    ; Hmmm…  You look like you might
    ; have an interesting destiny…
    ; May I tell your fortune?
    ; I'll make it cheap…
    ;     > Ask him to tell it
    ;        Not interested
    ; --------------------------------------------------------------------------
    ; $0E4F29
    Message_00F3:
    db $6D, $01 ; set window position
    db $07, $26, $26, $26, $43, $8A, $E8, $59 ; Hmmm…[  ][You]⎵
    db $BB, $28, $24, $59, $25, $22, $24, $1E ; [lo]ok⎵like
    db $59, $E3, $59, $26, $22, $20, $21, $2D ; ⎵[you]⎵might
    db $75 ; line 2
    db $AD, $59, $93, $59, $B4, $D6, $1E, $D3 ; [have]⎵[an]⎵[in][ter]e[st]
    db $B3, $9D, $2D, $B4, $32, $43 ; [ing ][des]t[in]y…
    db $76 ; line 3
    db $0C, $1A, $32, $59, $08, $59, $2D, $1E ; May⎵I⎵te
    db $25, $25, $59, $E3, $2B, $59, $A8, $2D ; ll⎵[you]r⎵[for]t
    db $2E, $27, $1E, $3F ; une?
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $51, $25, $25, $59, $BD, $24, $1E ; I'll⎵[ma]ke
    db $59, $B6, $59, $9A, $1A, $29, $43 ; ⎵[it]⎵[che]ap…
    db $73 ; scroll text
    db $88, $44, $59, $00, $2C, $24, $59, $B0 ; [    ]>⎵Ask⎵[hi]
    db $26, $59, $DA, $59, $2D, $1E, $25, $25 ; m⎵[to]⎵tell
    db $59, $B6 ; ⎵[it]
    db $73 ; scroll text
    db $88, $89, $0D, $28, $2D, $59, $B4, $D6 ; [    ][   ]Not⎵[in][ter]
    db $1E, $D3, $1E, $1D ; e[st]ed
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Now I will take [#0][#1] Rupees.
    ; I hope you will be healthy.
    ; Yeehah ha hah!
    ; --------------------------------------------------------------------------
    ; $0E4F9A
    Message_00F4:
    db $6D, $01 ; set window position
    db $0D, $28, $30, $59, $08, $59, $E2, $25 ; Now⎵I⎵[wi]l
    db $25, $59, $2D, $1A, $24, $1E, $59 ; l⎵take⎵
    db $6C, $00, $6C, $01, $59, $11, $DC, $1E ; [#0][#1]⎵R[up]e
    db $1E, $2C, $41 ; es.
    db $75 ; line 2
    db $08, $59, $21, $28, $29, $1E, $59, $E3 ; I⎵hope⎵[you]
    db $59, $E2, $25, $25, $59, $97, $59, $21 ; ⎵[wi]ll⎵[be]⎵h
    db $1E, $1A, $25, $2D, $21, $32, $41 ; ealthy.
    db $76 ; line 3
    db $18, $1E, $1E, $B1, $21, $59, $B1, $59 ; Yee[ha]h⎵[ha]⎵
    db $B1, $21, $3E ; [ha]h!
    db $7F ; end of message

    ; ==========================================================================
    ; It is indeed a poor man who is
    ; not interested in his future…
    ; I'll be waiting for your return.
    ; --------------------------------------------------------------------------
    ; $0E4FDB
    Message_00F5:
    db $6D, $01 ; set window position
    db $08, $2D, $59, $B5, $59, $B4, $1D, $1E ; It⎵[is]⎵[in]de
    db $A4, $1A, $59, $29, $28, $C8, $59, $BC ; [ed ]a⎵po[or]⎵[man]
    db $59, $E1, $28, $59, $B5 ; ⎵[wh]o⎵[is]
    db $75 ; line 2
    db $C2, $59, $B4, $D6, $1E, $D3, $A4, $B4 ; [not]⎵[in][ter]e[st][ed ][in]
    db $59, $B0, $2C, $59, $1F, $2E, $2D, $2E ; ⎵[hi]s⎵futu
    db $CE, $43 ; [re]…
    db $76 ; line 3
    db $08, $51, $25, $25, $59, $97, $59, $DF ; I'll⎵[be]⎵[wa]
    db $B6, $B3, $A8, $59, $E3, $2B, $59, $CE ; [it][ing ][for]⎵[you]r⎵[re]
    db $2D, $2E, $2B, $27, $41 ; turn.
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will meet a strange man
    ; standing in the desert…
    ; --------------------------------------------------------------------------
    ; $0E501C
    Message_00F6:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $BE, $1E ; [You]⎵[wi]ll⎵[me]e
    db $2D, $59, $1A, $59, $D3, $2B, $93, $20 ; t⎵a⎵[st]r[an]g
    db $1E, $59, $BC ; e⎵[man]
    db $76 ; line 3
    db $D3, $90, $B3, $B4, $59, $D8, $59, $9D ; [st][and][ing ][in]⎵[the]⎵[des]
    db $A6, $2D, $43 ; [er]t…
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; The gossip shop in the Dark
    ; World has treasure for the
    ; asking…
    ; --------------------------------------------------------------------------
    ; $0E504B
    Message_00F7:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E6, $59, $AC, $2C, $2C, $22, $29, $59 ; [The]⎵[go]ssip⎵
    db $D1, $28, $29, $59, $B4, $59, $D8, $59 ; [sh]op⎵[in]⎵[the]⎵
    db $03, $1A, $2B, $24 ; Dark
    db $76 ; line 3
    db $16, $C8, $25, $1D, $59, $AE, $59, $DB ; W[or]ld⎵[has]⎵[tr]
    db $1E, $1A, $2C, $2E, $CD, $A8, $59, $D8 ; easu[re ][for]⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $2C, $24, $B4, $20, $43 ; ask[in]g…
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will find the smith's
    ; partner in the
    ; Village Of Outcasts.
    ; --------------------------------------------------------------------------
    ; $0E5090
    Message_00F8:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $D8, $59, $2C, $26, $B6, $21 ; d⎵[the]⎵sm[it]h
    db $51, $2C ; 's
    db $76 ; line 3
    db $29, $1A, $2B, $2D, $27, $A1, $B4, $59 ; partn[er ][in]⎵
    db $D8 ; [the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $15, $22, $25, $BA, $20, $1E, $59, $0E ; Vil[la]ge⎵O
    db $1F, $59, $0E, $2E, $2D, $1C, $92, $2C ; f⎵Outc[ast]s
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; You will find a treasure resting
    ; in peace in the graveyard.
    ; --------------------------------------------------------------------------
    ; $0E50CF
    Message_00F9:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $1A, $59, $DB, $1E, $1A, $2C ; d⎵a⎵[tr]eas
    db $2E, $CD, $CE, $D3, $B4, $20 ; u[re ][re][st][in]g
    db $76 ; line 3
    db $B4, $59, $29, $1E, $1A, $1C, $1E, $59 ; [in]⎵peace⎵
    db $B4, $59, $D8, $59, $20, $2B, $1A, $2F ; [in]⎵[the]⎵grav
    db $1E, $32, $1A, $2B, $1D, $41 ; eyard.
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will buy a new kind of bomb
    ; in the Bomb Shop.
    ; --------------------------------------------------------------------------
    ; $0E5114
    Message_00FA:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1B, $2E ; [You]⎵[wi]ll⎵bu
    db $32, $59, $1A, $59, $27, $1E, $30, $59 ; y⎵a⎵new⎵
    db $24, $B4, $1D, $59, $C6, $59, $98, $26 ; k[in]d⎵[of]⎵[bo]m
    db $1B ; b
    db $76 ; line 3
    db $B4, $59, $D8, $59, $01, $28, $26, $1B ; [in]⎵[the]⎵Bomb
    db $59, $12, $21, $28, $29, $41 ; ⎵Shop.
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; You will find something inside
    ; the pyramid of the Dark World.
    ; --------------------------------------------------------------------------
    ; $0E514C
    Message_00FB:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $1F, $B4 ; [You]⎵[wi]ll⎵f[in]
    db $1D, $59, $CF, $D5, $20, $59, $B4, $2C ; d⎵[some][thin]g⎵[in]s
    db $22, $1D, $1E ; ide
    db $76 ; line 3
    db $D8, $59, $29, $32, $2B, $1A, $26, $22 ; [the]⎵pyrami
    db $1D, $59, $C6, $59, $D8, $59, $03, $1A ; d⎵[of]⎵[the]⎵Da
    db $2B, $24, $59, $16, $C8, $25, $1D, $41 ; rk⎵W[or]ld.
    db $7F ; end of message

    ; ==========================================================================
    ; Hocus pocus!
    ; You will run into a barrier if
    ; you try to enter
    ; Ganon's tower.
    ; --------------------------------------------------------------------------
    ; $0E5190
    Message_00FC:
    db $6D, $01 ; set window position
    db $07, $28, $1C, $2E, $2C, $59, $29, $28 ; Hocus⎵po
    db $1C, $2E, $2C, $3E ; cus!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $2B, $2E ; [You]⎵[wi]ll⎵ru
    db $27, $59, $B4, $DA, $59, $1A, $59, $96 ; n⎵[in][to]⎵a⎵[ba]
    db $2B, $2B, $22, $A1, $22, $1F ; rri[er ]if
    db $76 ; line 3
    db $E3, $59, $DB, $32, $59, $DA, $59, $A3 ; [you]⎵[tr]y⎵[to]⎵[ent]
    db $A6 ; [er]
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $8B, $DA, $E0, $2B, $41 ; G[an][on]['s ][to][we]r.
    db $7F ; end of message

    ; ==========================================================================
    ; Abracadabra alakazam!
    ; You will need Silver Arrows to
    ; give Ganon his last moment.
    ; --------------------------------------------------------------------------
    ; $0E51CA
    Message_00FD:
    db $6D, $01 ; set window position
    db $00, $1B, $2B, $1A, $1C, $1A, $1D, $1A ; Abracada
    db $1B, $2B, $1A, $59, $1A, $BA, $24, $1A ; bra⎵a[la]ka
    db $33, $1A, $26, $3E ; zam!
    db $75 ; line 2
    db $E8, $59, $E2, $25, $25, $59, $27, $1E ; [You]⎵[wi]ll⎵ne
    db $A4, $12, $22, $25, $DD, $59, $00, $2B ; [ed ]Sil[ver]⎵Ar
    db $2B, $28, $30, $2C, $59, $DA ; rows⎵[to]
    db $76 ; line 3
    db $AA, $06, $93, $C7, $59, $B0, $2C, $59 ; [give ]G[an][on]⎵[hi]s⎵
    db $BA, $D3, $59, $26, $28, $BE, $27, $2D ; [la][st]⎵mo[me]nt
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; Hey!  I'll tell you a profitable
    ; story if you pay me 20 Rupees.
    ; How about it?
    ;     > Pay Rupees
    ;        Don't want to hear it
    ; --------------------------------------------------------------------------
    ; $0E520A
    Message_00FE:
    db $07, $1E, $32, $3E, $8A, $08, $51, $25 ; Hey![  ]I'l
    db $25, $59, $2D, $1E, $25, $25, $59, $E3 ; l⎵tell⎵[you]
    db $59, $1A, $59, $CC, $1F, $B6, $1A, $95 ; ⎵a⎵[pro]f[it]a[ble]
    db $75 ; line 2
    db $D3, $C8, $32, $59, $22, $1F, $59, $E3 ; [st][or]y⎵if⎵[you]
    db $59, $29, $1A, $32, $59, $BE, $59, $36 ; ⎵pay⎵[me]⎵2
    db $34, $59, $11, $DC, $1E, $1E, $2C, $41 ; 0⎵R[up]ees.
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $28, $30, $59, $1A, $98, $2E, $2D ; How⎵a[bo]ut
    db $59, $B6, $3F ; ⎵[it]?
    db $73 ; scroll text
    db $88, $44, $59, $0F, $1A, $32, $59, $11 ; [    ]>⎵Pay⎵R
    db $DC, $1E, $1E, $2C ; [up]ees
    db $73 ; scroll text
    db $88, $89, $03, $C7, $51, $2D, $59, $DF ; [    ][   ]D[on]'t⎵[wa]
    db $27, $2D, $59, $DA, $59, $21, $A2, $59 ; nt⎵[to]⎵h[ear]⎵
    db $B6 ; [it]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Hah!  Thank you.  They say
    ; there is a tiny circle of rocks
    ; in the lake at the source of
    ; the river.  I don't know what
    ; will happen, but it might be fun
    ; to throw something into it…
    ; Heh heh.  See you…
    ; --------------------------------------------------------------------------
    ; $0E5269
    Message_00FF:
    db $07, $1A, $21, $3E, $8A, $E5, $27, $24 ; Hah![  ][Tha]nk
    db $59, $E3, $41, $8A, $E6, $32, $59, $2C ; ⎵[you].[  ][The]y⎵s
    db $1A, $32 ; ay
    db $75 ; line 2
    db $D8, $CD, $B5, $59, $1A, $59, $2D, $B4 ; [the][re ][is]⎵a⎵t[in]
    db $32, $59, $1C, $22, $2B, $1C, $25, $1E ; y⎵circle
    db $59, $C6, $59, $2B, $28, $9C, $2C ; ⎵[of]⎵ro[ck]s
    db $76 ; line 3
    db $B4, $59, $D8, $59, $BA, $24, $1E, $59 ; [in]⎵[the]⎵[la]ke⎵
    db $91, $D8, $59, $D2, $2E, $2B, $1C, $1E ; [at ][the]⎵[so]urce
    db $59, $C6 ; ⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $2B, $22, $DD, $41, $8A, $08 ; [the]⎵ri[ver].[  ]I
    db $59, $9F, $C0, $B8, $59, $E1, $94 ; ⎵[do][n't ][know]⎵[wh][at]
    db $73 ; scroll text
    db $E2, $25, $25, $59, $B1, $29, $29, $A5 ; [wi]ll⎵[ha]pp[en]
    db $42, $59, $1B, $2E, $2D, $59, $B6, $59 ; ,⎵but⎵[it]⎵
    db $26, $B2, $97, $59, $1F, $2E, $27 ; m[ight ][be]⎵fun
    db $73 ; scroll text
    db $DA, $59, $2D, $21, $2B, $28, $30, $59 ; [to]⎵throw⎵
    db $CF, $D5, $20, $59, $B4, $DA, $59, $B6 ; [some][thin]g⎵[in][to]⎵[it]
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $21, $59, $21, $1E, $21, $41 ; Heh⎵heh.
    db $8A, $12, $1E, $1E, $59, $E3, $43 ; [  ]See⎵[you]…
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh.  I see.  I'm not
    ; interested in talking to people
    ; who don't have Rupees…
    ; --------------------------------------------------------------------------
    ; $0E52F3
    Message_0100:
    db $07, $1E, $21, $59, $21, $1E, $21, $41 ; Heh⎵heh.
    db $8A, $08, $59, $D0, $1E, $41, $8A, $08 ; [  ]I⎵[se]e.[  ]I
    db $51, $26, $59, $C2 ; 'm⎵[not]
    db $75 ; line 2
    db $B4, $D6, $1E, $D3, $A4, $B4, $59, $2D ; [in][ter]e[st][ed ][in]⎵t
    db $1A, $25, $24, $B3, $DA, $59, $29, $1E ; alk[ing ][to]⎵pe
    db $28, $CA ; o[ple]
    db $76 ; line 3
    db $E1, $28, $59, $9F, $C0, $AD, $59, $11 ; [wh]o⎵[do][n't ][have]⎵R
    db $DC, $1E, $1E, $2C, $43 ; [up]ees…
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh.  Thank you.  To tell
    ; you the truth, I used to be a
    ; thief in the Light World…
    ; some of my fellow thieves went
    ; into hiding because they were
    ; afraid of being caught.
    ; One of them was a master
    ; locksmith, but now he is hiding
    ; the fact that he was a thief…
    ; …by pretending to be a
    ; strange middle-aged guy!
    ; Ha ha ha…
    ; --------------------------------------------------------------------------
    ; $0E5329
    Message_0101:
    db $07, $1E, $21, $59, $21, $1E, $21, $41 ; Heh⎵heh.
    db $8A, $E5, $27, $24, $59, $E3, $41, $8A ; [  ][Tha]nk⎵[you].[  ]
    db $13, $28, $59, $2D, $1E, $25, $25 ; To⎵tell
    db $75 ; line 2
    db $E3, $59, $D8, $59, $DB, $2E, $2D, $21 ; [you]⎵[the]⎵[tr]uth
    db $42, $59, $08, $59, $2E, $D0, $1D, $59 ; ,⎵I⎵u[se]d⎵
    db $DA, $59, $97, $59, $1A ; [to]⎵[be]⎵a
    db $76 ; line 3
    db $D9, $1E, $1F, $59, $B4, $59, $D8, $59 ; [thi]ef⎵[in]⎵[the]⎵
    db $0B, $B2, $16, $C8, $25, $1D, $43 ; L[ight ]W[or]ld…
    db $7E ; wait for key
    db $73 ; scroll text
    db $CF, $59, $C6, $59, $26, $32, $59, $1F ; [some]⎵[of]⎵my⎵f
    db $1E, $25, $BB, $30, $59, $D9, $A7, $1E ; el[lo]w⎵[thi][ev]e
    db $2C, $59, $E0, $27, $2D ; s⎵[we]nt
    db $73 ; scroll text
    db $B4, $DA, $59, $B0, $9E, $27, $20, $59 ; [in][to]⎵[hi][di]ng⎵
    db $97, $1C, $1A, $2E, $D0, $59, $D8, $32 ; [be]cau[se]⎵[the]y
    db $59, $E0, $CE ; ⎵[we][re]
    db $73 ; scroll text
    db $1A, $1F, $2B, $1A, $22, $1D, $59, $C6 ; afraid⎵[of]
    db $59, $97, $B3, $1C, $1A, $2E, $20, $21 ; ⎵[be][ing ]caugh
    db $2D, $41 ; t.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $27, $1E, $59, $C6, $59, $D8, $26 ; One⎵[of]⎵[the]m
    db $59, $DF, $2C, $59, $1A, $59, $BD, $D3 ; ⎵[wa]s⎵a⎵[ma][st]
    db $A6 ; [er]
    db $73 ; scroll text
    db $BB, $9C, $2C, $26, $B6, $21, $42, $59 ; [lo][ck]sm[it]h,⎵
    db $1B, $2E, $2D, $59, $27, $28, $30, $59 ; but⎵now⎵
    db $21, $1E, $59, $B5, $59, $B0, $9E, $27 ; he⎵[is]⎵[hi][di]n
    db $20 ; g
    db $73 ; scroll text
    db $D8, $59, $1F, $1A, $1C, $2D, $59, $D7 ; [the]⎵fact⎵[tha]
    db $2D, $59, $21, $1E, $59, $DF, $2C, $59 ; t⎵he⎵[wa]s⎵
    db $1A, $59, $D9, $1E, $1F, $43 ; a⎵[thi]ef…
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $1B, $32, $59, $29, $CE, $2D, $A5 ; …by⎵p[re]t[en]
    db $9E, $27, $20, $59, $DA, $59, $97, $59 ; [di]ng⎵[to]⎵[be]⎵
    db $1A ; a
    db $73 ; scroll text
    db $D3, $2B, $93, $20, $1E, $59, $26, $22 ; [st]r[an]ge⎵mi
    db $1D, $1D, $25, $1E, $40, $1A, $20, $A4 ; ddle-ag[ed ]
    db $20, $2E, $32, $3E ; guy!
    db $73 ; scroll text
    db $07, $1A, $59, $B1, $59, $B1, $43 ; Ha⎵[ha]⎵[ha]…
    db $7F ; end of message

    ; ==========================================================================
    ; Hah!  Thank you.  To tell you
    ; the truth, I found incredible
    ; beauty inside the pyramid,
    ; but someone sealed the door.
    ; You can't do anything with a
    ; standard bomb, they say…
    ; --------------------------------------------------------------------------
    ; $0E5419
    Message_0102:
    db $07, $1A, $21, $3E, $8A, $E5, $27, $24 ; Hah![  ][Tha]nk
    db $59, $E3, $41, $8A, $13, $28, $59, $2D ; ⎵[you].[  ]To⎵t
    db $1E, $25, $25, $59, $E3 ; ell⎵[you]
    db $75 ; line 2
    db $D8, $59, $DB, $2E, $2D, $21, $42, $59 ; [the]⎵[tr]uth,⎵
    db $08, $59, $1F, $C4, $59, $B4, $1C, $CE ; I⎵f[ound]⎵[in]c[re]
    db $9E, $95 ; [di][ble]
    db $76 ; line 3
    db $97, $1A, $2E, $2D, $32, $59, $B4, $2C ; [be]auty⎵[in]s
    db $22, $1D, $1E, $59, $D8, $59, $29, $32 ; ide⎵[the]⎵py
    db $2B, $1A, $26, $22, $1D, $42 ; ramid,
    db $7E ; wait for key
    db $73 ; scroll text
    db $1B, $2E, $2D, $59, $CF, $C7, $1E, $59 ; but⎵[some][on]e⎵
    db $D0, $1A, $25, $A4, $D8, $59, $9F, $C8 ; [se]al[ed ][the]⎵[do][or]
    db $41 ; .
    db $73 ; scroll text
    db $E8, $59, $1C, $93, $51, $2D, $59, $9F ; [You]⎵c[an]'t⎵[do]
    db $59, $93, $32, $D5, $20, $59, $DE, $59 ; ⎵[an]y[thin]g⎵[with]⎵
    db $1A ; a
    db $73 ; scroll text
    db $D3, $90, $1A, $2B, $1D, $59, $98, $26 ; [st][and]ard⎵[bo]m
    db $1B, $42, $59, $D8, $32, $59, $2C, $1A ; b,⎵[the]y⎵sa
    db $32, $43 ; y…
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh.  Thank you.  As a
    ; matter of fact, monster magic
    ; is making it rain in the swamp.
    ; If you can move the air with
    ; more force than the monsters,
    ; the rain may stop.
    ; --------------------------------------------------------------------------
    ; $0E5491
    Message_0103:
    db $07, $1E, $21, $59, $21, $1E, $21, $41 ; Heh⎵heh.
    db $8A, $E5, $27, $24, $59, $E3, $41, $8A ; [  ][Tha]nk⎵[you].[  ]
    db $00, $2C, $59, $1A ; As⎵a
    db $75 ; line 2
    db $BD, $2D, $D4, $C6, $59, $1F, $1A, $1C ; [ma]t[ter ][of]⎵fac
    db $2D, $42, $59, $26, $C7, $D3, $A1, $BD ; t,⎵m[on][st][er ][ma]
    db $20, $22, $1C ; gic
    db $76 ; line 3
    db $B5, $59, $BD, $24, $B3, $B6, $59, $2B ; [is]⎵[ma]k[ing ][it]⎵r
    db $8F, $59, $B4, $59, $D8, $59, $2C, $DF ; [ain]⎵[in]⎵[the]⎵s[wa]
    db $26, $29, $41 ; mp.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $99, $26, $28 ; If⎵[you]⎵[can ]mo
    db $2F, $1E, $59, $D8, $59, $1A, $22, $2B ; ve⎵[the]⎵air
    db $59, $DE ; ⎵[with]
    db $73 ; scroll text
    db $26, $C8, $1E, $59, $A8, $1C, $1E, $59 ; m[or]e⎵[for]ce⎵
    db $D7, $27, $59, $D8, $59, $26, $C7, $D3 ; [tha]n⎵[the]⎵m[on][st]
    db $A6, $2C, $42 ; [er]s,
    db $73 ; scroll text
    db $D8, $59, $2B, $8F, $59, $BD, $32, $59 ; [the]⎵r[ain]⎵[ma]y⎵
    db $D3, $28, $29, $41 ; [st]op.
    db $7F ; end of message

    ; ==========================================================================
    ; Sniffle… Hey brother [LINK]!
    ; Do you have a bottle to keep
    ; a bug in?
    ; …
    ; I see.  You don't have one…
    ; Cough cough…
    ; --------------------------------------------------------------------------
    ; $0E5503
    Message_0104:
    db $12, $27, $22, $1F, $1F, $25, $1E, $43 ; Sniffle…
    db $59, $07, $1E, $32, $59, $1B, $2B, $28 ; ⎵Hey⎵bro
    db $D8, $2B, $59, $6A, $3E ; [the]r⎵[LINK]!
    db $75 ; line 2
    db $03, $28, $59, $E3, $59, $AD, $59, $1A ; Do⎵[you]⎵[have]⎵a
    db $59, $98, $2D, $2D, $25, $1E, $59, $DA ; ⎵[bo]ttle⎵[to]
    db $59, $24, $1E, $1E, $29 ; ⎵keep
    db $76 ; line 3
    db $1A, $59, $1B, $2E, $20, $59, $B4, $3F ; a⎵bug⎵[in]?
    db $7E ; wait for key
    db $73 ; scroll text
    db $43 ; …
    db $73 ; scroll text
    db $08, $59, $D0, $1E, $41, $8A, $E8, $59 ; I⎵[se]e.[  ][You]⎵
    db $9F, $C0, $AD, $59, $C7, $1E, $43 ; [do][n't ][have]⎵[on]e…
    db $73 ; scroll text
    db $02, $28, $2E, $20, $21, $59, $1C, $28 ; Cough⎵co
    db $2E, $20, $21, $43 ; ugh…
    db $7F ; end of message

    ; ==========================================================================
    ; I can't go out 'cause I'm sick…
    ; Cough cough…
    ; People say I caught this cold
    ; from the evil air that is coming
    ; down off the mountain…
    ; Sniff sniff…
    ; This is my bug-catching net.
    ; I'll use it when I'm better, but
    ; for now, I'll lend it to you.
    ; --------------------------------------------------------------------------
    ; $0E5558
    Message_0105:
    db $08, $59, $1C, $93, $51, $2D, $59, $AC ; I⎵c[an]'t⎵[go]
    db $59, $C5, $51, $1C, $1A, $2E, $D0, $59 ; ⎵[out ]'cau[se]⎵
    db $08, $51, $26, $59, $2C, $22, $9C, $43 ; I'm⎵si[ck]…
    db $75 ; line 2
    db $02, $28, $2E, $20, $21, $59, $1C, $28 ; Cough⎵co
    db $2E, $20, $21, $43 ; ugh…
    db $76 ; line 3
    db $0F, $1E, $28, $CA, $59, $2C, $1A, $32 ; Peo[ple]⎵say
    db $59, $08, $59, $1C, $1A, $2E, $20, $21 ; ⎵I⎵caugh
    db $2D, $59, $D9, $2C, $59, $1C, $28, $25 ; t⎵[thi]s⎵col
    db $1D ; d
    db $7E ; wait for key
    db $73 ; scroll text
    db $A9, $26, $59, $D8, $59, $A7, $22, $25 ; [fro]m⎵[the]⎵[ev]il
    db $59, $1A, $22, $2B, $59, $D7, $2D, $59 ; ⎵air⎵[tha]t⎵
    db $B5, $59, $9B, $B4, $20 ; [is]⎵[com][in]g
    db $73 ; scroll text
    db $9F, $30, $27, $59, $C6, $1F, $59, $D8 ; [do]wn⎵[of]f⎵[the]
    db $59, $26, $28, $2E, $27, $2D, $8F, $43 ; ⎵mount[ain]…
    db $73 ; scroll text
    db $12, $27, $22, $1F, $1F, $59, $2C, $27 ; Sniff⎵sn
    db $22, $1F, $1F, $43 ; iff…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $26, $32, $59 ; [Thi]s⎵[is]⎵my⎵
    db $1B, $2E, $20, $40, $1C, $94, $1C, $B0 ; bug-c[at]c[hi]
    db $27, $20, $59, $27, $1E, $2D, $41 ; ng⎵net.
    db $73 ; scroll text
    db $08, $51, $25, $25, $59, $2E, $D0, $59 ; I'll⎵u[se]⎵
    db $B6, $59, $E1, $A0, $08, $51, $26, $59 ; [it]⎵[wh][en ]I'm⎵
    db $97, $2D, $D6, $42, $59, $1B, $2E, $2D ; [be]t[ter],⎵but
    db $73 ; scroll text
    db $A8, $59, $27, $28, $30, $42, $59, $08 ; [for]⎵now,⎵I
    db $51, $25, $25, $59, $25, $A5, $1D, $59 ; 'll⎵l[en]d⎵
    db $B6, $59, $DA, $59, $E3, $41 ; [it]⎵[to]⎵[you].
    db $7F ; end of message

    ; ==========================================================================
    ; Sniffle… I hope I get well
    ; soon…
    ; Cough cough…
    ; --------------------------------------------------------------------------
    ; $0E5616
    Message_0106:
    db $12, $27, $22, $1F, $1F, $25, $1E, $43 ; Sniffle…
    db $59, $08, $59, $21, $28, $29, $1E, $59 ; ⎵I⎵hope⎵
    db $08, $59, $AB, $59, $E0, $25, $25 ; I⎵[get]⎵[we]ll
    db $75 ; line 2
    db $D2, $C7, $43 ; [so][on]…
    db $76 ; line 3
    db $02, $28, $2E, $20, $21, $59, $1C, $28 ; Cough⎵co
    db $2E, $20, $21, $43 ; ugh…
    db $7F ; end of message

    ; ==========================================================================
    ; …  …  …  …  …  …
    ; …  …  …
    ; --------------------------------------------------------------------------
    ; $0E563F
    Message_0107:
    db $43, $8A, $43, $8A, $43, $8A, $43, $8A ; …[  ]…[  ]…[  ]…[  ]
    db $43, $8A, $43 ; …[  ]…
    db $75 ; line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7F ; end of message

    ; ==========================================================================
    ; Why did you take my sign?  It
    ; says plain as day to just leave
    ; me alone!  Sheeesh!
    ; --------------------------------------------------------------------------
    ; $0E5651
    Message_0108:
    db $16, $21, $32, $59, $9E, $1D, $59, $E3 ; Why⎵[di]d⎵[you]
    db $59, $2D, $1A, $24, $1E, $59, $26, $32 ; ⎵take⎵my
    db $59, $2C, $22, $20, $27, $3F, $8A, $08 ; ⎵sign?[  ]I
    db $2D ; t
    db $75 ; line 2
    db $2C, $1A, $32, $2C, $59, $29, $BA, $B4 ; says⎵p[la][in]
    db $59, $1A, $2C, $59, $1D, $1A, $32, $59 ; ⎵as⎵day⎵
    db $DA, $59, $B7, $59, $25, $1E, $1A, $2F ; [to]⎵[just]⎵leav
    db $1E ; e
    db $76 ; line 3
    db $BE, $59, $1A, $BB, $27, $1E, $3E, $8A ; [me]⎵a[lo]ne![  ]
    db $12, $21, $1E, $1E, $1E, $D1, $3E ; Sheee[sh]!
    db $7F ; end of message

    ; ==========================================================================
    ; I heard that you know I used to
    ; be a thief, right?
    ; 
    ; Well, I'll open a chest for you.
    ; Will you keep it secret from
    ; everyone else?
    ; Would you please promise ?
    ;     > Promise not to tell
    ;        Tell it to everyone
    ; --------------------------------------------------------------------------
    ; $0E5695
    Message_0109:
    db $08, $59, $21, $A2, $1D, $59, $D7, $2D ; I⎵h[ear]d⎵[tha]t
    db $59, $E3, $59, $B8, $59, $08, $59, $2E ; ⎵[you]⎵[know]⎵I⎵u
    db $D0, $1D, $59, $DA ; [se]d⎵[to]
    db $75 ; line 2
    db $97, $59, $1A, $59, $D9, $1E, $1F, $42 ; [be]⎵a⎵[thi]ef,
    db $59, $2B, $22, $20, $21, $2D, $3F ; ⎵right?
    db $76 ; line 3
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $1E, $25, $25, $42, $59, $08, $51 ; Well,⎵I'
    db $25, $25, $59, $C3, $59, $1A, $59, $9A ; ll⎵[open]⎵a⎵[che]
    db $D3, $59, $A8, $59, $E3, $41 ; [st]⎵[for]⎵[you].
    db $73 ; scroll text
    db $16, $22, $25, $25, $59, $E3, $59, $24 ; Will⎵[you]⎵k
    db $1E, $1E, $29, $59, $B6, $59, $D0, $1C ; eep⎵[it]⎵[se]c
    db $CE, $2D, $59, $A9, $26 ; [re]t⎵[fro]m
    db $73 ; scroll text
    db $A7, $A6, $32, $C7, $1E, $59, $1E, $25 ; [ev][er]y[on]e⎵el
    db $D0, $3F ; [se]?
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $28, $2E, $25, $1D, $59, $E3, $59 ; Would⎵[you]⎵
    db $CA, $1A, $D0, $59, $CC, $26, $B5, $1E ; [ple]a[se]⎵[pro]m[is]e
    db $59, $3F ; ⎵?
    db $73 ; scroll text
    db $88, $44, $59, $0F, $2B, $28, $26, $B5 ; [    ]>⎵Prom[is]
    db $1E, $59, $C2, $59, $DA, $59, $2D, $1E ; e⎵[not]⎵[to]⎵te
    db $25, $25 ; ll
    db $73 ; scroll text
    db $88, $89, $13, $1E, $25, $25, $59, $B6 ; [    ][   ]Tell⎵[it]
    db $59, $DA, $59, $A7, $A6, $32, $C7, $1E ; ⎵[to]⎵[ev][er]y[on]e
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; OK, if that's the way you want
    ; it, I hope you drag that chest
    ; around forever!
    ; --------------------------------------------------------------------------
    ; $0E572D
    Message_010A:
    db $0E, $0A, $42, $59, $22, $1F, $59, $D7 ; OK,⎵if⎵[tha]
    db $2D, $8B, $D8, $59, $DF, $32, $59, $E3 ; t['s ][the]⎵[wa]y⎵[you]
    db $59, $DF, $27, $2D ; ⎵[wa]nt
    db $75 ; line 2
    db $B6, $42, $59, $08, $59, $21, $28, $29 ; [it],⎵I⎵hop
    db $1E, $59, $E3, $59, $1D, $2B, $1A, $20 ; e⎵[you]⎵drag
    db $59, $D7, $2D, $59, $9A, $D3 ; ⎵[tha]t⎵[che][st]
    db $76 ; line 3
    db $1A, $2B, $C4, $59, $A8, $A7, $A6, $3E ; ar[ound]⎵[for][ev][er]!
    db $7F ; end of message

    ; ==========================================================================
    ; Remember, you promised…
    ; Don't tell anyone.
    ; --------------------------------------------------------------------------
    ; $0E5762
    Message_010B:
    db $11, $1E, $BE, $26, $97, $2B, $42, $59 ; Re[me]m[be]r,⎵
    db $E3, $59, $CC, $26, $B5, $1E, $1D, $43 ; [you]⎵[pro]m[is]ed…
    db $75 ; line 2
    db $03, $C7, $51, $2D, $59, $2D, $1E, $25 ; D[on]'t⎵tel
    db $25, $59, $93, $32, $C7, $1E, $41 ; l⎵[an]y[on]e.
    db $7F ; end of message

    ; ==========================================================================
    ; All right, bring that chest over
    ; here…  Seriously, keep this a
    ; secret from everyone.
    ; --------------------------------------------------------------------------
    ; $0E5783
    Message_010C:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $42, $59, $1B, $2B, $B3, $D7, $2D ; t,⎵br[ing ][tha]t
    db $59, $9A, $D3, $59, $28, $DD ; ⎵[che][st]⎵o[ver]
    db $75 ; line 2
    db $AF, $1E, $43, $8A, $12, $A6, $22, $28 ; [her]e…[  ]S[er]io
    db $2E, $2C, $25, $32, $42, $59, $24, $1E ; usly,⎵ke
    db $1E, $29, $59, $D9, $2C, $59, $1A ; ep⎵[thi]s⎵a
    db $76 ; line 3
    db $D0, $1C, $CE, $2D, $59, $A9, $26, $59 ; [se]c[re]t⎵[fro]m⎵
    db $A7, $A6, $32, $C7, $1E, $41 ; [ev][er]y[on]e.
    db $7F ; end of message

    ; ==========================================================================
    ; 𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗𓈗𓈗Ƨ
    ; 𓈗☥ƧƧ☥𓈗☥Ƨ𓈗☥Ƨ𓈗☥Ƨ𓈗☥
    ; 𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗☥𓈗☥
    ; --------------------------------------------------------------------------
    ; $0E57C1
    Message_010D:
    db $48, $49, $48, $49, $48, $49, $48, $49 ; 𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗Ƨ
    db $48, $49, $48, $48, $48, $49 ; 𓈗Ƨ𓈗𓈗𓈗Ƨ
    db $75 ; line 2
    db $48, $47, $49, $49, $47, $48, $47, $49 ; 𓈗☥ƧƧ☥𓈗☥Ƨ
    db $48, $47, $49, $48, $47, $49, $48, $47 ; 𓈗☥Ƨ𓈗☥Ƨ𓈗☥
    db $76 ; line 3
    db $48, $49, $48, $49, $48, $49, $48, $47 ; 𓈗Ƨ𓈗Ƨ𓈗Ƨ𓈗☥
    db $48, $47 ; 𓈗☥
    db $7F ; end of message

    ; ==========================================================================
    ; Hold up the Master Sword and
    ; you will get the magic of
    ; Ether.
    ; --------------------------------------------------------------------------
    ; $0E57EC
    Message_010E:
    db $07, $28, $25, $1D, $59, $DC, $59, $D8 ; Hold⎵[up]⎵[the]
    db $59, $0C, $92, $A1, $12, $30, $C8, $1D ; ⎵M[ast][er ]Sw[or]d
    db $59, $90 ; ⎵[and]
    db $75 ; line 2
    db $E3, $59, $E2, $25, $25, $59, $AB, $59 ; [you]⎵[wi]ll⎵[get]⎵
    db $D8, $59, $BD, $20, $22, $1C, $59, $C6 ; [the]⎵[ma]gic⎵[of]
    db $76 ; line 3
    db $04, $D8, $2B, $41 ; E[the]r.
    db $7F ; end of message

    ; ==========================================================================
    ; Hold up the Master Sword and
    ; you will get the magic of
    ; Bombos.
    ; --------------------------------------------------------------------------
    ; $0E5815
    Message_010F:
    db $07, $28, $25, $1D, $59, $DC, $59, $D8 ; Hold⎵[up]⎵[the]
    db $59, $0C, $92, $A1, $12, $30, $C8, $1D ; ⎵M[ast][er ]Sw[or]d
    db $59, $90 ; ⎵[and]
    db $75 ; line 2
    db $E3, $59, $E2, $25, $25, $59, $AB, $59 ; [you]⎵[wi]ll⎵[get]⎵
    db $D8, $59, $BD, $20, $22, $1C, $59, $C6 ; [the]⎵[ma]gic⎵[of]
    db $76 ; line 3
    db $01, $28, $26, $98, $2C, $41 ; Bom[bo]s.
    db $7F ; end of message

    ; ==========================================================================
    ; Hey!  Blast you for waking me
    ; from my deep, dark sleep!
    ; …I mean, thanks a lot, sir!
    ; But now I will get my revenge
    ; on you.  Get ready for it!
    ; …Err, is that OK with you,
    ; sir?
    ; --------------------------------------------------------------------------
    ; $0E5840
    Message_0110:
    db $07, $1E, $32, $3E, $8A, $01, $BA, $D3 ; Hey![  ]B[la][st]
    db $59, $E3, $59, $A8, $59, $DF, $24, $B3 ; ⎵[you]⎵[for]⎵[wa]k[ing ]
    db $BE ; [me]
    db $75 ; line 2
    db $A9, $26, $59, $26, $32, $59, $1D, $1E ; [fro]m⎵my⎵de
    db $1E, $29, $42, $59, $1D, $1A, $2B, $24 ; ep,⎵dark
    db $59, $2C, $25, $1E, $1E, $29, $3E ; ⎵sleep!
    db $76 ; line 3
    db $43, $08, $59, $BE, $93, $42, $59, $D7 ; …I⎵[me][an],⎵[tha]
    db $27, $24, $2C, $59, $1A, $59, $BB, $2D ; nks⎵a⎵[lo]t
    db $42, $59, $2C, $22, $2B, $3E ; ,⎵sir!
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $27, $28, $30, $59 ; But⎵now⎵
    db $08, $59, $E2, $25, $25, $59, $AB, $59 ; I⎵[wi]ll⎵[get]⎵
    db $26, $32, $59, $CE, $2F, $A5, $20, $1E ; my⎵[re]v[en]ge
    db $73 ; scroll text
    db $C7, $59, $E3, $41, $8A, $06, $1E, $2D ; [on]⎵[you].[  ]Get
    db $59, $CE, $1A, $1D, $32, $59, $A8, $59 ; ⎵[re]ady⎵[for]⎵
    db $B6, $3E ; [it]!
    db $73 ; scroll text
    db $43, $04, $2B, $2B, $42, $59, $B5, $59 ; …Err,⎵[is]⎵
    db $D7, $2D, $59, $0E, $0A, $59, $DE, $59 ; [tha]t⎵OK⎵[with]⎵
    db $E3, $42 ; [you],
    db $7E ; wait for key
    db $73 ; scroll text
    db $2C, $22, $2B, $3F ; sir?
    db $7F ; end of message

    ; ==========================================================================
    ; Heh heh heh!  I laugh at your
    ; misfortune!  Now your magic
    ; power will drop by one half!
    ; Congratulations!
    ; Now, do your best, even though
    ; I'm sure it won't be enough!
    ; Have a nice day!  See you!
    ; --------------------------------------------------------------------------
    ; $0E58C7
    Message_0111:
    db $07, $1E, $21, $59, $21, $1E, $21, $59 ; Heh⎵heh⎵
    db $21, $1E, $21, $3E, $8A, $08, $59, $BA ; heh![  ]I⎵[la]
    db $2E, $20, $21, $59, $91, $E3, $2B ; ugh⎵[at ][you]r
    db $75 ; line 2
    db $26, $B5, $A8, $2D, $2E, $27, $1E, $3E ; m[is][for]tune!
    db $8A, $0D, $28, $30, $59, $E3, $2B, $59 ; [  ]Now⎵[you]r⎵
    db $BD, $20, $22, $1C ; [ma]gic
    db $76 ; line 3
    db $CB, $A1, $E2, $25, $25, $59, $1D, $2B ; [pow][er ][wi]ll⎵dr
    db $28, $29, $59, $1B, $32, $59, $C7, $1E ; op⎵by⎵[on]e
    db $59, $B1, $25, $1F, $3E ; ⎵[ha]lf!
    db $7E ; wait for key
    db $73 ; scroll text
    db $02, $C7, $20, $2B, $94, $2E, $BA, $2D ; C[on]gr[at]u[la]t
    db $22, $C7, $2C, $3E ; i[on]s!
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $9F, $59, $E3 ; Now,⎵[do]⎵[you]
    db $2B, $59, $97, $D3, $42, $59, $A7, $A0 ; r⎵[be][st],⎵[ev][en ]
    db $2D, $21, $28, $2E, $20, $21 ; though
    db $73 ; scroll text
    db $08, $51, $26, $59, $2C, $2E, $CD, $B6 ; I'm⎵su[re ][it]
    db $59, $30, $C7, $51, $2D, $59, $97, $59 ; ⎵w[on]'t⎵[be]⎵
    db $A5, $28, $2E, $20, $21, $3E ; [en]ough!
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1A, $2F, $1E, $59, $1A, $59, $27 ; Have⎵a⎵n
    db $22, $1C, $1E, $59, $1D, $1A, $32, $3E ; ice⎵day!
    db $8A, $12, $1E, $1E, $59, $E3, $3E ; [  ]See⎵[you]!
    db $7F ; end of message

    ; ==========================================================================
    ; Long ago, in the beautiful
    ; kingdom of Hyrule surrounded
    ; by mountains and forests…
    ; legends told of an omnipotent
    ; and omniscient Golden Power
    ; that resided in a hidden land.
    ; Many people aggressively
    ; sought to enter the hidden
    ; Golden Land…
    ; But no one ever returned.
    ; One day evil power began to
    ; flow from the Golden Land…
    ; So the King commanded seven
    ; wise men to seal the gate to
    ; the Land of the Golden Power.
    ; That seal should have remained
    ; for all time…
    ; 
    ; …  …But, when these events
    ; were obscured by the mists of
    ; time and became legend…
    ; --------------------------------------------------------------------------
    ; $0E595F
    Message_0112:
    db $6E, $00 ; set scroll speed
    db $77, $07 ; set text color
    db $7A, $03 ; set draw speed
    db $6B, $02 ; set window border
    db $67 ; next image
    db $0B, $C7, $20, $59, $1A, $AC, $42, $59 ; L[on]g⎵a[go],⎵
    db $B4, $59, $D8, $59, $97, $1A, $2E, $2D ; [in]⎵[the]⎵[be]aut
    db $22, $1F, $2E, $25 ; iful
    db $75 ; line 2
    db $24, $B4, $20, $9F, $26, $59, $C6, $59 ; k[in]g[do]m⎵[of]⎵
    db $07, $32, $2B, $2E, $25, $1E, $59, $2C ; Hyrule⎵s
    db $2E, $2B, $2B, $C4, $1E, $1D ; urr[ound]ed
    db $76 ; line 3
    db $1B, $32, $59, $26, $28, $2E, $27, $2D ; by⎵mount
    db $8F, $2C, $59, $8C, $A8, $1E, $D3, $2C ; [ain]s⎵[and ][for]e[st]s
    db $43 ; …
    db $78, $09 ; delay
    db $73 ; scroll text
    db $25, $1E, $20, $A5, $1D, $2C, $59, $DA ; leg[en]ds⎵[to]
    db $25, $1D, $59, $C6, $59, $93, $59, $28 ; ld⎵[of]⎵[an]⎵o
    db $26, $27, $22, $29, $28, $2D, $A3 ; mnipot[ent]
    db $73 ; scroll text
    db $8C, $28, $26, $27, $B5, $1C, $22, $A3 ; [and ]omn[is]ci[ent]
    db $59, $06, $28, $25, $1D, $A0, $0F, $28 ; ⎵Gold[en ]Po
    db $E0, $2B ; [we]r
    db $73 ; scroll text
    db $D7, $2D, $59, $CE, $2C, $22, $1D, $A4 ; [tha]t⎵[re]sid[ed ]
    db $B4, $59, $1A, $59, $B0, $1D, $1D, $A0 ; [in]⎵a⎵[hi]dd[en ]
    db $BA, $27, $1D, $41 ; [la]nd.
    db $78, $09 ; delay
    db $67 ; next image
    db $67 ; next image
    db $73 ; scroll text
    db $0C, $93, $32, $59, $29, $1E, $28, $CA ; M[an]y⎵peo[ple]
    db $59, $1A, $20, $20, $CE, $2C, $2C, $22 ; ⎵agg[re]ssi
    db $2F, $1E, $25, $32 ; vely
    db $73 ; scroll text
    db $D2, $2E, $20, $21, $2D, $59, $DA, $59 ; [so]ught⎵[to]⎵
    db $A3, $A1, $D8, $59, $B0, $1D, $1D, $A5 ; [ent][er ][the]⎵[hi]dd[en]
    db $73 ; scroll text
    db $06, $28, $25, $1D, $A0, $0B, $90, $43 ; Gold[en ]L[and]…
    db $78, $07 ; delay
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $27, $28, $59, $C7 ; But⎵no⎵[on]
    db $1E, $59, $A7, $A1, $CE, $2D, $2E, $2B ; e⎵[ev][er ][re]tur
    db $27, $1E, $1D, $41 ; ned.
    db $73 ; scroll text
    db $0E, $27, $1E, $59, $1D, $1A, $32, $59 ; One⎵day⎵
    db $A7, $22, $25, $59, $CB, $A1, $97, $20 ; [ev]il⎵[pow][er ][be]g
    db $93, $59, $DA ; [an]⎵[to]
    db $73 ; scroll text
    db $1F, $BB, $30, $59, $A9, $26, $59, $D8 ; f[lo]w⎵[fro]m⎵[the]
    db $59, $06, $28, $25, $1D, $A0, $0B, $90 ; ⎵Gold[en ]L[and]
    db $43 ; …
    db $78, $07 ; delay
    db $73 ; scroll text
    db $12, $28, $59, $D8, $59, $0A, $B3, $9B ; So⎵[the]⎵K[ing ][com]
    db $BC, $1D, $A4, $D0, $2F, $A5 ; [man]d[ed ][se]v[en]
    db $73 ; scroll text
    db $E2, $D0, $59, $BE, $27, $59, $DA, $59 ; [wi][se]⎵[me]n⎵[to]⎵
    db $D0, $1A, $25, $59, $D8, $59, $20, $94 ; [se]al⎵[the]⎵g[at]
    db $1E, $59, $DA ; e⎵[to]
    db $73 ; scroll text
    db $D8, $59, $0B, $8C, $C6, $59, $D8, $59 ; [the]⎵L[and ][of]⎵[the]⎵
    db $06, $28, $25, $1D, $A0, $0F, $28, $E0 ; Gold[en ]Po[we]
    db $2B, $41 ; r.
    db $78, $09 ; delay
    db $67 ; next image
    db $67 ; next image
    db $73 ; scroll text
    db $E5, $2D, $59, $D0, $1A, $25, $59, $D1 ; [Tha]t⎵[se]al⎵[sh]
    db $28, $2E, $25, $1D, $59, $AD, $59, $CE ; ould⎵[have]⎵[re]
    db $BD, $B4, $1E, $1D ; [ma][in]ed
    db $73 ; scroll text
    db $A8, $59, $8E, $2D, $22, $BE, $43 ; [for]⎵[all ]ti[me]…
    db $73 ; scroll text
    db $78, $09 ; delay
    db $67 ; next image
    db $67 ; next image
    db $73 ; scroll text
    db $43, $8A, $43, $01, $2E, $2D, $42, $59 ; …[  ]…But,⎵
    db $E1, $A0, $D8, $D0, $59, $A7, $A3, $2C ; [wh][en ][the][se]⎵[ev][ent]s
    db $73 ; scroll text
    db $E0, $CD, $28, $1B, $2C, $1C, $2E, $CE ; [we][re ]obscu[re]
    db $1D, $59, $1B, $32, $59, $D8, $59, $26 ; d⎵by⎵[the]⎵m
    db $B5, $2D, $2C, $59, $C6 ; [is]ts⎵[of]
    db $73 ; scroll text
    db $2D, $22, $BE, $59, $8C, $97, $1C, $1A ; ti[me]⎵[and ][be]ca
    db $BE, $59, $25, $1E, $20, $A5, $1D, $43 ; [me]⎵leg[en]d…
    db $7F ; end of message

    ; ==========================================================================
    ; A mysterious wizard known as
    ; Agahnim came to Hyrule to
    ; release the seal.  He eliminated
    ; the good King of Hyrule…
    ; --------------------------------------------------------------------------
    ; $0E5AEE
    Message_0113:
    db $6B, $02 ; set window border
    db $77, $07 ; set text color
    db $7A, $03 ; set draw speed
    db $74 ; line 1
    db $00, $59, $26, $32, $D3, $A6, $22, $28 ; A⎵my[st][er]io
    db $2E, $2C, $59, $E2, $33, $1A, $2B, $1D ; us⎵[wi]zard
    db $59, $B8, $27, $59, $1A, $2C ; ⎵[know]n⎵as
    db $75 ; line 2
    db $00, $20, $1A, $21, $27, $22, $26, $59 ; Agahnim⎵
    db $1C, $1A, $BE, $59, $DA, $59, $07, $32 ; ca[me]⎵[to]⎵Hy
    db $2B, $2E, $25, $1E, $59, $DA ; rule⎵[to]
    db $76 ; line 3
    db $CE, $25, $1E, $1A, $D0, $59, $D8, $59 ; [re]lea[se]⎵[the]⎵
    db $D0, $1A, $25, $41, $8A, $07, $1E, $59 ; [se]al.[  ]He⎵
    db $1E, $25, $22, $26, $B4, $94, $1E, $1D ; elim[in][at]ed
    db $78, $05 ; delay
    db $73 ; scroll text
    db $D8, $59, $AC, $28, $1D, $59, $0A, $B3 ; [the]⎵[go]od⎵K[ing ]
    db $C6, $59, $07, $32, $2B, $2E, $25, $1E ; [of]⎵Hyrule
    db $43 ; …
    db $78, $05 ; delay
    db $7F ; end of message

    ; ==========================================================================
    ; Through evil magic, he began
    ; to make descendants of the
    ; seven wise men vanish, one
    ; after another.
    ; --------------------------------------------------------------------------
    ; $0E5B52
    Message_0114:
    db $6B, $02 ; set window border
    db $77, $07 ; set text color
    db $7A, $03 ; set draw speed
    db $74 ; line 1
    db $13, $21, $2B, $28, $2E, $20, $21, $59 ; Through⎵
    db $A7, $22, $25, $59, $BD, $20, $22, $1C ; [ev]il⎵[ma]gic
    db $42, $59, $21, $1E, $59, $97, $20, $93 ; ,⎵he⎵[be]g[an]
    db $75 ; line 2
    db $DA, $59, $BD, $24, $1E, $59, $9D, $1C ; [to]⎵[ma]ke⎵[des]c
    db $A5, $1D, $93, $2D, $2C, $59, $C6, $59 ; [en]d[an]ts⎵[of]⎵
    db $D8 ; [the]
    db $76 ; line 3
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $59, $2F, $93, $B5, $21, $42, $59, $C7 ; ⎵v[an][is]h,⎵[on]
    db $1E ; e
    db $78, $05 ; delay
    db $73 ; scroll text
    db $1A, $1F, $D4, $93, $28, $D8, $2B, $41 ; af[ter ][an]o[the]r.
    db $78, $05 ; delay
    db $7F ; end of message

    ; ==========================================================================
    ; And the time of destiny for
    ; Princess Zelda is drawing
    ; near.
    ; --------------------------------------------------------------------------
    ; $0E5BA3
    Message_0115:
    db $6B, $02 ; set window border
    db $77, $07 ; set text color
    db $7A, $03 ; set draw speed
    db $74 ; line 1
    db $00, $27, $1D, $59, $D8, $59, $2D, $22 ; And⎵[the]⎵ti
    db $BE, $59, $C6, $59, $9D, $2D, $B4, $32 ; [me]⎵[of]⎵[des]t[in]y
    db $59, $A8 ; ⎵[for]
    db $75 ; line 2
    db $0F, $2B, $B4, $1C, $1E, $2C, $2C, $59 ; Pr[in]cess⎵
    db $19, $1E, $25, $1D, $1A, $59, $B5, $59 ; Zelda⎵[is]⎵
    db $1D, $2B, $1A, $E2, $27, $20 ; dra[wi]ng
    db $76 ; line 3
    db $27, $A2, $41 ; n[ear].
    db $78, $05 ; delay
    db $7F ; end of message

    ; ==========================================================================
    ; Because the key is locked
    ; inside this chest, you can
    ; never open it.
    ; Just take it with you.
    ; --------------------------------------------------------------------------
    ; $0E5BDA
    Message_0116:
    db $01, $1E, $1C, $1A, $2E, $D0, $59, $D8 ; Becau[se]⎵[the]
    db $59, $24, $1E, $32, $59, $B5, $59, $BB ; ⎵key⎵[is]⎵[lo]
    db $9C, $1E, $1D ; [ck]ed
    db $75 ; line 2
    db $B4, $2C, $22, $1D, $1E, $59, $D9, $2C ; [in]side⎵[thi]s
    db $59, $9A, $D3, $42, $59, $E3, $59, $1C ; ⎵[che][st],⎵[you]⎵c
    db $93 ; [an]
    db $76 ; line 3
    db $27, $A7, $A1, $C3, $59, $B6, $41 ; n[ev][er ][open]⎵[it].
    db $7E ; wait for key
    db $73 ; scroll text
    db $09, $2E, $D3, $59, $2D, $1A, $24, $1E ; Ju[st]⎵take
    db $59, $B6, $59, $DE, $59, $E3, $41 ; ⎵[it]⎵[with]⎵[you].
    db $7F ; end of message

    ; ==========================================================================
    ; 100 Rupees for 30 Bombs!  30
    ; Bombs for just 100 Rupees!
    ; Please buy 'em, mister!
    ; --------------------------------------------------------------------------
    ; $0E5C19
    Message_0117:
    db $35, $34, $34, $59, $11, $DC, $1E, $1E ; 100⎵R[up]ee
    db $2C, $59, $A8, $59, $37, $34, $59, $01 ; s⎵[for]⎵30⎵B
    db $28, $26, $1B, $2C, $3E, $8A, $37, $34 ; ombs![  ]30
    db $75 ; line 2
    db $01, $28, $26, $1B, $2C, $59, $A8, $59 ; Bombs⎵[for]⎵
    db $B7, $59, $35, $34, $34, $59, $11, $DC ; [just]⎵100⎵R[up]
    db $1E, $1E, $2C, $3E ; ees!
    db $76 ; line 3
    db $0F, $25, $1E, $1A, $D0, $59, $1B, $2E ; Plea[se]⎵bu
    db $32, $59, $51, $1E, $26, $42, $59, $26 ; y⎵'em,⎵m
    db $B5, $D6, $3E ; [is][ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; 100 Rupees for 30 Bombs!  I also
    ; have a new Super Bomb in stock
    ; for only 100 Rupees!  Please
    ; buy it too, mister!
    ; --------------------------------------------------------------------------
    ; $0E5C5B
    Message_0118:
    db $35, $34, $34, $59, $11, $DC, $1E, $1E ; 100⎵R[up]ee
    db $2C, $59, $A8, $59, $37, $34, $59, $01 ; s⎵[for]⎵30⎵B
    db $28, $26, $1B, $2C, $3E, $8A, $08, $59 ; ombs![  ]I⎵
    db $1A, $25, $D2 ; al[so]
    db $75 ; line 2
    db $AD, $59, $1A, $59, $27, $1E, $30, $59 ; [have]⎵a⎵new⎵
    db $12, $DC, $A1, $01, $28, $26, $1B, $59 ; S[up][er ]Bomb⎵
    db $B4, $59, $D3, $28, $9C ; [in]⎵[st]o[ck]
    db $76 ; line 3
    db $A8, $59, $C7, $B9, $35, $34, $34, $59 ; [for]⎵[on][ly ]100⎵
    db $11, $DC, $1E, $1E, $2C, $3E, $8A, $0F ; R[up]ees![  ]P
    db $25, $1E, $1A, $D0 ; lea[se]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1B, $2E, $32, $59, $B6, $59, $DA, $28 ; buy⎵[it]⎵[to]o
    db $42, $59, $26, $B5, $D6, $3E ; ,⎵m[is][ter]!
    db $7F ; end of message

    ; ==========================================================================
    ; Thank you very much.
    ; Thank you very much.
    ; --------------------------------------------------------------------------
    ; $0E5CB2
    Message_0119:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $7F ; end of message

    ; ==========================================================================
    ; Thank you very much.  You can
    ; drop this Bomb off anywhere.
    ; (Press the Ⓐ Button.)
    ; Please don't forget it.
    ; --------------------------------------------------------------------------
    ; $0E5CCE
    Message_011A:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41, $8A, $E8, $59 ; ⎵[mu]ch.[  ][You]⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1D, $2B, $28, $29, $59, $D9, $2C, $59 ; drop⎵[thi]s⎵
    db $01, $28, $26, $1B, $59, $C6, $1F, $59 ; Bomb⎵[of]f⎵
    db $93, $32, $E1, $A6, $1E, $41 ; [an]y[wh][er]e.
    db $76 ; line 3
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5B, $59, $01, $2E, $2D, $DA, $27, $41 ; Ⓐ⎵But[to]n.
    db $46 ; )
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $59, $9F, $C0 ; Plea[se]⎵[do][n't ]
    db $A8, $AB, $59, $B6, $41 ; [for][get]⎵[it].
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki ki!  If you give me 100
    ; Rupees,  I will open the
    ; entrance for you.  Ki ki ki!
    ;   What will you do?
    ;     > Ask him to open it
    ;        Try to open it yourself
    ; --------------------------------------------------------------------------
    ; $0E5D19
    Message_011B:
    db $0A, $22, $59, $24, $22, $59, $24, $22 ; Ki⎵ki⎵ki
    db $3E, $8A, $08, $1F, $59, $E3, $59, $AA ; ![  ]If⎵[you]⎵[give ]
    db $BE, $59, $35, $34, $34 ; [me]⎵100
    db $75 ; line 2
    db $11, $DC, $1E, $1E, $2C, $42, $8A, $08 ; R[up]ees,[  ]I
    db $59, $E2, $25, $25, $59, $C3, $59, $D8 ; ⎵[wi]ll⎵[open]⎵[the]
    db $76 ; line 3
    db $A3, $2B, $93, $1C, $1E, $59, $A8, $59 ; [ent]r[an]ce⎵[for]⎵
    db $E3, $41, $8A, $0A, $22, $59, $24, $22 ; [you].[  ]Ki⎵ki
    db $59, $24, $22, $3E ; ⎵ki!
    db $7E ; wait for key
    db $73 ; scroll text
    db $8A, $16, $B1, $2D, $59, $E2, $25, $25 ; [  ]W[ha]t⎵[wi]ll
    db $59, $E3, $59, $9F, $3F ; ⎵[you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $59, $00, $2C, $24, $59, $B0 ; [    ]>⎵Ask⎵[hi]
    db $26, $59, $DA, $59, $C3, $59, $B6 ; m⎵[to]⎵[open]⎵[it]
    db $73 ; scroll text
    db $88, $89, $13, $2B, $32, $59, $DA, $59 ; [    ][   ]Try⎵[to]⎵
    db $C3, $59, $B6, $59, $E3, $2B, $D0, $25 ; [open]⎵[it]⎵[you]r[se]l
    db $1F ; f
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki ki!  Hmph!
    ; Do it yourself, then!
    ; Kik ki ki!
    ; --------------------------------------------------------------------------
    ; $0E5D87
    Message_011C:
    db $0A, $22, $59, $24, $22, $59, $24, $22 ; Ki⎵ki⎵ki
    db $3E, $8A, $07, $26, $29, $21, $3E ; ![  ]Hmph!
    db $75 ; line 2
    db $03, $28, $59, $B6, $59, $E3, $2B, $D0 ; Do⎵[it]⎵[you]r[se]
    db $25, $1F, $42, $59, $D8, $27, $3E ; lf,⎵[the]n!
    db $76 ; line 3
    db $0A, $22, $24, $59, $24, $22, $59, $24 ; Kik⎵ki⎵k
    db $22, $3E ; i!
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki!  Good choice!  Then I get
    ; 100 of your Rupees.  Kik ki ki!
    ; --------------------------------------------------------------------------
    ; $0E5DB2
    Message_011D:
    db $0A, $22, $59, $24, $22, $3E, $8A, $06 ; Ki⎵ki![  ]G
    db $28, $28, $1D, $59, $1C, $21, $28, $22 ; ood⎵choi
    db $1C, $1E, $3E, $8A, $E6, $27, $59, $08 ; ce![  ][The]n⎵I
    db $59, $AB ; ⎵[get]
    db $75 ; line 2
    db $35, $34, $34, $59, $C6, $59, $E3, $2B ; 100⎵[of]⎵[you]r
    db $59, $11, $DC, $1E, $1E, $2C, $41, $8A ; ⎵R[up]ees.[  ]
    db $0A, $22, $24, $59, $24, $22, $59, $24 ; Kik⎵ki⎵k
    db $22, $3E ; i!
    db $7F ; end of message

    ; ==========================================================================
    ; I'm Kiki the monkey ki ki!
    ; I love Rupees more than
    ; anything.  Can you spare me
    ; 10 Rupees?
    ;  What will you do?
    ;     > Give him 10 Rupees
    ;        Never give him anything
    ; --------------------------------------------------------------------------
    ; $0E5DE8
    Message_011E:
    db $08, $51, $26, $59, $0A, $22, $24, $22 ; I'm⎵Kiki
    db $59, $D8, $59, $26, $C7, $24, $1E, $32 ; ⎵[the]⎵m[on]key
    db $59, $24, $22, $59, $24, $22, $3E ; ⎵ki⎵ki!
    db $75 ; line 2
    db $08, $59, $BB, $2F, $1E, $59, $11, $DC ; I⎵[lo]ve⎵R[up]
    db $1E, $1E, $2C, $59, $26, $C8, $1E, $59 ; ees⎵m[or]e⎵
    db $D7, $27 ; [tha]n
    db $76 ; line 3
    db $93, $32, $D5, $20, $41, $8A, $02, $93 ; [an]y[thin]g.[  ]C[an]
    db $59, $E3, $59, $2C, $29, $8D, $BE ; ⎵[you]⎵sp[are ][me]
    db $7E ; wait for key
    db $73 ; scroll text
    db $35, $34, $59, $11, $DC, $1E, $1E, $2C ; 10⎵R[up]ees
    db $3F ; ?
    db $7E ; wait for key
    db $73 ; scroll text
    db $59, $16, $B1, $2D, $59, $E2, $25, $25 ; ⎵W[ha]t⎵[wi]ll
    db $59, $E3, $59, $9F, $3F ; ⎵[you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $59, $06, $22, $2F, $1E, $59 ; [    ]>⎵Give⎵
    db $B0, $26, $59, $35, $34, $59, $11, $DC ; [hi]m⎵10⎵R[up]
    db $1E, $1E, $2C ; ees
    db $73 ; scroll text
    db $88, $89, $0D, $A7, $A1, $AA, $B0, $26 ; [    ][   ]N[ev][er ][give ][hi]m
    db $59, $93, $32, $D5, $20 ; ⎵[an]y[thin]g
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki ki ki!  Good choice!  I
    ; will accompany you for a while.
    ; Kik kiki!
    ; --------------------------------------------------------------------------
    ; $0E5E60
    Message_011F:
    db $0A, $22, $59, $24, $22, $59, $24, $22 ; Ki⎵ki⎵ki
    db $59, $24, $22, $3E, $8A, $06, $28, $28 ; ⎵ki![  ]Goo
    db $1D, $59, $1C, $21, $28, $22, $1C, $1E ; d⎵choice
    db $3E, $8A, $08 ; ![  ]I
    db $75 ; line 2
    db $E2, $25, $25, $59, $1A, $1C, $9B, $29 ; [wi]ll⎵ac[com]p
    db $93, $32, $59, $E3, $59, $A8, $59, $1A ; [an]y⎵[you]⎵[for]⎵a
    db $59, $E1, $22, $25, $1E, $41 ; ⎵[wh]ile.
    db $76 ; line 3
    db $0A, $22, $24, $59, $24, $22, $24, $22 ; Kik⎵kiki
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki!  Harumph!  I have no
    ; reason to talk to you, then.
    ; Bye bye!  Kik ki ki!
    ; --------------------------------------------------------------------------
    ; $0E5E9D
    Message_0120:
    db $0A, $22, $59, $24, $22, $3E, $8A, $07 ; Ki⎵ki![  ]H
    db $1A, $2B, $2E, $26, $29, $21, $3E, $8A ; arumph![  ]
    db $08, $59, $AD, $59, $27, $28 ; I⎵[have]⎵no
    db $75 ; line 2
    db $CE, $1A, $D2, $27, $59, $DA, $59, $2D ; [re]a[so]n⎵[to]⎵t
    db $1A, $25, $24, $59, $DA, $59, $E3, $42 ; alk⎵[to]⎵[you],
    db $59, $D8, $27, $41 ; ⎵[the]n.
    db $76 ; line 3
    db $01, $32, $1E, $59, $1B, $32, $1E, $3E ; Bye⎵bye!
    db $8A, $0A, $22, $24, $59, $24, $22, $59 ; [  ]Kik⎵ki⎵
    db $24, $22, $3E ; ki!
    db $7F ; end of message

    ; ==========================================================================
    ; Ki ki?  What are you doing?
    ; I don't want to go there!
    ; --------------------------------------------------------------------------
    ; $0E5EDD
    Message_0121:
    db $0A, $22, $59, $24, $22, $3F, $8A, $16 ; Ki⎵ki?[  ]W
    db $B1, $2D, $59, $8D, $E3, $59, $9F, $B4 ; [ha]t⎵[are ][you]⎵[do][in]
    db $20, $3F ; g?
    db $75 ; line 2
    db $08, $59, $9F, $C0, $DF, $27, $2D, $59 ; I⎵[do][n't ][wa]nt⎵
    db $DA, $59, $AC, $59, $D8, $CE, $3E ; [to]⎵[go]⎵[the][re]!
    db $7F ; end of message

    ; ==========================================================================
    ; Ohh, thank you very much!
    ; You saved my life.  Please take
    ; me outside.
    ; --------------------------------------------------------------------------
    ; $0E5F00
    Message_0122:
    db $0E, $21, $21, $42, $59, $D7, $27, $24 ; Ohh,⎵[tha]nk
    db $59, $E3, $59, $DD, $32, $59, $BF, $1C ; ⎵[you]⎵[ver]y⎵[mu]c
    db $21, $3E ; h!
    db $75 ; line 2
    db $E8, $59, $2C, $1A, $2F, $A4, $26, $32 ; [You]⎵sav[ed ]my
    db $59, $25, $22, $1F, $1E, $41, $8A, $0F ; ⎵life.[  ]P
    db $25, $1E, $1A, $D0, $59, $2D, $1A, $24 ; lea[se]⎵tak
    db $1E ; e
    db $76 ; line 3
    db $BE, $59, $28, $2E, $2D, $2C, $22, $1D ; [me]⎵outsid
    db $1E, $41 ; e.
    db $7F ; end of message

    ; ==========================================================================
    ; Gyaaah!
    ; Too bright!
    ; --------------------------------------------------------------------------
    ; $0E5F38
    Message_0123:
    db $06, $32, $1A, $1A, $1A, $21, $3E ; Gyaaah!
    db $75 ; line 2
    db $13, $28, $28, $59, $1B, $2B, $22, $20 ; Too⎵brig
    db $21, $2D, $3E ; ht!
    db $7F ; end of message

    ; ==========================================================================
    ; Err…  Wait a minute…
    ; Please don't go this way.
    ; --------------------------------------------------------------------------
    ; $0E5F4C
    Message_0124:
    db $04, $2B, $2B, $43, $8A, $16, $1A, $B6 ; Err…[  ]Wa[it]
    db $59, $1A, $59, $26, $B4, $2E, $2D, $1E ; ⎵a⎵m[in]ute
    db $43 ; …
    db $75 ; line 2
    db $0F, $25, $1E, $1A, $D0, $59, $9F, $C0 ; Plea[se]⎵[do][n't ]
    db $AC, $59, $D9, $2C, $59, $DF, $32, $41 ; [go]⎵[thi]s⎵[wa]y.
    db $7F ; end of message

    ; ==========================================================================
    ; I am Aginah.  I sense something
    ; is happening in the Golden Land
    ; the seven wise men sealed…
    ; This must be an omen of the
    ; Great Cataclysm foretold by
    ; the people of Hylian blood…
    ; … … …
    ; The prophecy says, "The Hero
    ; will stand in the desert holding
    ; the Book Of Mudora."
    ; If you have the Book Of Mudora
    ; you can read the language of
    ; the Hylia People.
    ; It should be in the house of
    ; books in the village…
    ; You must get it!
    ; If you are the person who will
    ; be The Hero…
    ; --------------------------------------------------------------------------
    ; $0E5F6F
    Message_0125:
    db $08, $59, $1A, $26, $59, $00, $20, $B4 ; I⎵am⎵Ag[in]
    db $1A, $21, $41, $8A, $08, $59, $D0, $27 ; ah.[  ]I⎵[se]n
    db $D0, $59, $CF, $D5, $20 ; [se]⎵[some][thin]g
    db $75 ; line 2
    db $B5, $59, $B1, $29, $29, $A5, $B3, $B4 ; [is]⎵[ha]pp[en][ing ][in]
    db $59, $D8, $59, $06, $28, $25, $1D, $A0 ; ⎵[the]⎵Gold[en ]
    db $0B, $90 ; L[and]
    db $76 ; line 3
    db $D8, $59, $D0, $2F, $A0, $E2, $D0, $59 ; [the]⎵[se]v[en ][wi][se]⎵
    db $BE, $27, $59, $D0, $1A, $25, $1E, $1D ; [me]n⎵[se]aled
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $E7, $2C, $59, $BF, $D3, $59, $97, $59 ; [Thi]s⎵[mu][st]⎵[be]⎵
    db $93, $59, $28, $BE, $27, $59, $C6, $59 ; [an]⎵o[me]n⎵[of]⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $06, $CE, $91, $02, $94, $1A, $1C, $25 ; G[re][at ]C[at]acl
    db $32, $2C, $26, $59, $A8, $1E, $DA, $25 ; ysm⎵[for]e[to]l
    db $1D, $59, $1B, $32 ; d⎵by
    db $73 ; scroll text
    db $D8, $59, $29, $1E, $28, $CA, $59, $C6 ; [the]⎵peo[ple]⎵[of]
    db $59, $07, $32, $25, $22, $93, $59, $1B ; ⎵Hyli[an]⎵b
    db $BB, $28, $1D, $43 ; [lo]od…
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $59, $43, $59, $43 ; …⎵…⎵…
    db $73 ; scroll text
    db $E6, $59, $CC, $29, $21, $1E, $1C, $32 ; [The]⎵[pro]phecy
    db $59, $2C, $1A, $32, $2C, $42, $59, $4C ; ⎵says,⎵"
    db $E6, $59, $E4, $28 ; [The]⎵[Her]o
    db $73 ; scroll text
    db $E2, $25, $25, $59, $D3, $8C, $B4, $59 ; [wi]ll⎵[st][and ][in]⎵
    db $D8, $59, $9D, $A6, $2D, $59, $21, $28 ; [the]⎵[des][er]t⎵ho
    db $25, $9E, $27, $20 ; l[di]ng
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $01, $28, $28, $24, $59, $0E ; [the]⎵Book⎵O
    db $1F, $59, $0C, $2E, $9F, $2B, $1A, $41 ; f⎵Mu[do]ra.
    db $4C ; "
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $AD, $59, $D8 ; If⎵[you]⎵[have]⎵[the]
    db $59, $01, $28, $28, $24, $59, $0E, $1F ; ⎵Book⎵Of
    db $59, $0C, $2E, $9F, $2B, $1A ; ⎵Mu[do]ra
    db $73 ; scroll text
    db $E3, $59, $99, $CE, $1A, $1D, $59, $D8 ; [you]⎵[can ][re]ad⎵[the]
    db $59, $BA, $27, $20, $2E, $1A, $20, $1E ; ⎵[la]nguage
    db $59, $C6 ; ⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $07, $32, $25, $22, $1A, $59 ; [the]⎵Hylia⎵
    db $0F, $1E, $28, $CA, $41 ; Peo[ple].
    db $73 ; scroll text
    db $08, $2D, $59, $D1, $28, $2E, $25, $1D ; It⎵[sh]ould
    db $59, $97, $59, $B4, $59, $D8, $59, $21 ; ⎵[be]⎵[in]⎵[the]⎵h
    db $28, $2E, $D0, $59, $C6 ; ou[se]⎵[of]
    db $73 ; scroll text
    db $98, $28, $24, $2C, $59, $B4, $59, $D8 ; [bo]oks⎵[in]⎵[the]
    db $59, $2F, $22, $25, $BA, $20, $1E, $43 ; ⎵vil[la]ge…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $BF, $D3, $59, $AB, $59, $B6 ; [You]⎵[mu][st]⎵[get]⎵[it]
    db $3E ; !
    db $73 ; scroll text
    db $08, $1F, $59, $E3, $59, $8D, $D8, $59 ; If⎵[you]⎵[are ][the]⎵
    db $C9, $D2, $27, $59, $E1, $28, $59, $E2 ; [per][so]n⎵[wh]o⎵[wi]
    db $25, $25 ; ll
    db $73 ; scroll text
    db $97, $59, $E6, $59, $E4, $28, $43 ; [be]⎵[The]⎵[Her]o…
    db $7F ; end of message

    ; ==========================================================================
    ; You have collected the three
    ; Pendants.
    ; If you are indeed the Hero who
    ; has Wisdom, Courage and Power,
    ; the Master Sword sleeping in
    ; the forest will be yours.
    ; --------------------------------------------------------------------------
    ; $0E60B1
    Message_0126:
    db $E8, $59, $AD, $59, $1C, $28, $25, $25 ; [You]⎵[have]⎵coll
    db $1E, $1C, $2D, $A4, $D8, $59, $2D, $21 ; ect[ed ][the]⎵th
    db $CE, $1E ; [re]e
    db $75 ; line 2
    db $0F, $A5, $1D, $93, $2D, $2C, $41 ; P[en]d[an]ts.
    db $76 ; line 3
    db $08, $1F, $59, $E3, $59, $8D, $B4, $1D ; If⎵[you]⎵[are ][in]d
    db $1E, $A4, $D8, $59, $E4, $28, $59, $E1 ; e[ed ][the]⎵[Her]o⎵[wh]
    db $28 ; o
    db $7E ; wait for key
    db $73 ; scroll text
    db $AE, $59, $16, $B5, $9F, $26, $42, $59 ; [has]⎵W[is][do]m,⎵
    db $02, $28, $2E, $2B, $1A, $20, $1E, $59 ; Courage⎵
    db $8C, $0F, $28, $E0, $2B, $42 ; [and ]Po[we]r,
    db $73 ; scroll text
    db $D8, $59, $0C, $92, $A1, $12, $30, $C8 ; [the]⎵M[ast][er ]Sw[or]
    db $1D, $59, $2C, $25, $1E, $1E, $29, $B3 ; d⎵sleep[ing ]
    db $B4 ; [in]
    db $73 ; scroll text
    db $D8, $59, $A8, $1E, $D3, $59, $E2, $25 ; [the]⎵[for]e[st]⎵[wi]l
    db $25, $59, $97, $59, $E3, $2B, $2C, $41 ; l⎵[be]⎵[you]rs.
    db $7F ; end of message

    ; ==========================================================================
    ; Aha!  It is the Book Of Mudora.
    ; With it, you can read the
    ; language of the Hylia people.
    ; --------------------------------------------------------------------------
    ; $0E6119
    Message_0127:
    db $00, $B1, $3E, $8A, $08, $2D, $59, $B5 ; A[ha]![  ]It⎵[is]
    db $59, $D8, $59, $01, $28, $28, $24, $59 ; ⎵[the]⎵Book⎵
    db $0E, $1F, $59, $0C, $2E, $9F, $2B, $1A ; Of⎵Mu[do]ra
    db $41 ; .
    db $75 ; line 2
    db $16, $B6, $21, $59, $B6, $42, $59, $E3 ; W[it]h⎵[it],⎵[you]
    db $59, $99, $CE, $1A, $1D, $59, $D8 ; ⎵[can ][re]ad⎵[the]
    db $76 ; line 3
    db $BA, $27, $20, $2E, $1A, $20, $1E, $59 ; [la]nguage⎵
    db $C6, $59, $D8, $59, $07, $32, $25, $22 ; [of]⎵[the]⎵Hyli
    db $1A, $59, $29, $1E, $28, $CA, $41 ; a⎵peo[ple].
    db $7F ; end of message

    ; ==========================================================================
    ; You are the true Hero…
    ; I believe that you will return
    ; peace to this land again.
    ; --------------------------------------------------------------------------
    ; $0E615B
    Message_0128:
    db $E8, $59, $8D, $D8, $59, $DB, $2E, $1E ; [You]⎵[are ][the]⎵[tr]ue
    db $59, $E4, $28, $43 ; ⎵[Her]o…
    db $75 ; line 2
    db $08, $59, $97, $25, $22, $A7, $1E, $59 ; I⎵[be]li[ev]e⎵
    db $D7, $2D, $59, $E3, $59, $E2, $25, $25 ; [tha]t⎵[you]⎵[wi]ll
    db $59, $CE, $2D, $2E, $2B, $27 ; ⎵[re]turn
    db $76 ; line 3
    db $29, $1E, $1A, $1C, $1E, $59, $DA, $59 ; peace⎵[to]⎵
    db $D9, $2C, $59, $BA, $27, $1D, $59, $1A ; [thi]s⎵[la]nd⎵a
    db $20, $8F, $41 ; g[ain].
    db $7F ; end of message

    ; ==========================================================================
    ; Your trial in the desert has
    ; made you stronger.  The blood
    ; of the Hero must be in your
    ; veins…
    ; --------------------------------------------------------------------------
    ; $0E6193
    Message_0129:
    db $E8, $2B, $59, $DB, $22, $1A, $25, $59 ; [You]r⎵[tr]ial⎵
    db $B4, $59, $D8, $59, $9D, $A6, $2D, $59 ; [in]⎵[the]⎵[des][er]t⎵
    db $AE ; [has]
    db $75 ; line 2
    db $BD, $1D, $1E, $59, $E3, $59, $D3, $2B ; [ma]de⎵[you]⎵[st]r
    db $C7, $20, $A6, $41, $8A, $E6, $59, $1B ; [on]g[er].[  ][The]⎵b
    db $BB, $28, $1D ; [lo]od
    db $76 ; line 3
    db $C6, $59, $D8, $59, $E4, $28, $59, $BF ; [of]⎵[the]⎵[Her]o⎵[mu]
    db $D3, $59, $97, $59, $B4, $59, $E3, $2B ; [st]⎵[be]⎵[in]⎵[you]r
    db $7E ; wait for key
    db $73 ; scroll text
    db $2F, $1E, $B4, $2C, $43 ; ve[in]s…
    db $7F ; end of message

    ; ==========================================================================
    ; Was it you who disturbed my
    ; peaceful nap?  I will give this
    ; to you if you go away!
    ; --------------------------------------------------------------------------
    ; $0E61D1
    Message_012A:
    db $16, $1A, $2C, $59, $B6, $59, $E3, $59 ; Was⎵[it]⎵[you]⎵
    db $E1, $28, $59, $9E, $D3, $2E, $2B, $97 ; [wh]o⎵[di][st]ur[be]
    db $1D, $59, $26, $32 ; d⎵my
    db $75 ; line 2
    db $29, $1E, $1A, $1C, $1E, $1F, $2E, $25 ; peaceful
    db $59, $27, $1A, $29, $3F, $8A, $08, $59 ; ⎵nap?[  ]I⎵
    db $E2, $25, $25, $59, $AA, $D9, $2C ; [wi]ll⎵[give ][thi]s
    db $76 ; line 3
    db $DA, $59, $E3, $59, $22, $1F, $59, $E3 ; [to]⎵[you]⎵if⎵[you]
    db $59, $AC, $59, $1A, $DF, $32, $3E ; ⎵[go]⎵a[wa]y!
    db $7F ; end of message

    ; ==========================================================================
    ; I don't have any more good
    ; presents for you.  Take this
    ; instead, pest!
    ; --------------------------------------------------------------------------
    ; $0E620E
    Message_012B:
    db $08, $59, $9F, $C0, $AD, $59, $93, $32 ; I⎵[do][n't ][have]⎵[an]y
    db $59, $26, $C8, $1E, $59, $AC, $28, $1D ; ⎵m[or]e⎵[go]od
    db $75 ; line 2
    db $29, $CE, $D0, $27, $2D, $2C, $59, $A8 ; p[re][se]nts⎵[for]
    db $59, $E3, $41, $8A, $13, $1A, $24, $1E ; ⎵[you].[  ]Take
    db $59, $D9, $2C ; ⎵[thi]s
    db $76 ; line 3
    db $B4, $D3, $1E, $1A, $1D, $42, $59, $29 ; [in][st]ead,⎵p
    db $1E, $D3, $3E ; e[st]!
    db $7F ; end of message

    ; ==========================================================================
    ; Yo [LINK]!  A mysterious fog
    ; has recently fallen over the
    ; forest.  We have to be careful!
    ; --------------------------------------------------------------------------
    ; $0E623F
    Message_012C:
    db $18, $28, $59, $6A, $3E, $8A, $00, $59 ; Yo⎵[LINK]![  ]A⎵
    db $26, $32, $D3, $A6, $22, $28, $2E, $2C ; my[st][er]ious
    db $59, $1F, $28, $20 ; ⎵fog
    db $75 ; line 2
    db $AE, $59, $CE, $1C, $A3, $B9, $1F, $1A ; [has]⎵[re]c[ent][ly ]fa
    db $25, $25, $A0, $28, $DD, $59, $D8 ; ll[en ]o[ver]⎵[the]
    db $76 ; line 3
    db $A8, $1E, $D3, $41, $8A, $16, $1E, $59 ; [for]e[st].[  ]We⎵
    db $AD, $59, $DA, $59, $97, $59, $1C, $1A ; [have]⎵[to]⎵[be]⎵ca
    db $CE, $1F, $2E, $25, $3E ; [re]ful!
    db $7F ; end of message

    ; ==========================================================================
    ; Maybe it's nothing, but this
    ; tree feels kind of strange as
    ; we cut it…
    ; --------------------------------------------------------------------------
    ; $0E627A
    Message_012D:
    db $0C, $1A, $32, $97, $59, $B6, $8B, $C2 ; May[be]⎵[it]['s ][not]
    db $B0, $27, $20, $42, $59, $1B, $2E, $2D ; [hi]ng,⎵but
    db $59, $D9, $2C ; ⎵[thi]s
    db $75 ; line 2
    db $DB, $1E, $1E, $59, $1F, $1E, $1E, $25 ; [tr]ee⎵feel
    db $2C, $59, $24, $B4, $1D, $59, $C6, $59 ; s⎵k[in]d⎵[of]⎵
    db $D3, $2B, $93, $20, $1E, $59, $1A, $2C ; [st]r[an]ge⎵as
    db $76 ; line 3
    db $E0, $59, $1C, $2E, $2D, $59, $B6, $43 ; [we]⎵cut⎵[it]…
    db $7F ; end of message

    ; ==========================================================================
    ; Yo!  The fog in the forest is
    ; clearing.  Thank you!  We can
    ; go there again!  Hey brother!
    ; --------------------------------------------------------------------------
    ; $0E62B0
    Message_012E:
    db $18, $28, $3E, $8A, $E6, $59, $1F, $28 ; Yo![  ][The]⎵fo
    db $20, $59, $B4, $59, $D8, $59, $A8, $1E ; g⎵[in]⎵[the]⎵[for]e
    db $D3, $59, $B5 ; [st]⎵[is]
    db $75 ; line 2
    db $1C, $25, $A2, $B4, $20, $41, $8A, $E5 ; cl[ear][in]g.[  ][Tha]
    db $27, $24, $59, $E3, $3E, $8A, $16, $1E ; nk⎵[you]![  ]We
    db $59, $1C, $93 ; ⎵c[an]
    db $76 ; line 3
    db $AC, $59, $D8, $CD, $1A, $20, $8F, $3E ; [go]⎵[the][re ]ag[ain]!
    db $8A, $07, $1E, $32, $59, $1B, $2B, $28 ; [  ]Hey⎵bro
    db $D8, $2B, $3E ; [the]r!
    db $7F ; end of message

    ; ==========================================================================
    ; Yeah [LINK], now I'm
    ; quarreling with my younger
    ; brother.  I sealed the door to
    ; his room.
    ; --------------------------------------------------------------------------
    ; $0E62EC
    Message_012F:
    db $18, $1E, $1A, $21, $59, $6A, $42, $59 ; Yeah⎵[LINK],⎵
    db $27, $28, $30, $59, $08, $51, $26 ; now⎵I'm
    db $75 ; line 2
    db $2A, $2E, $1A, $2B, $CE, $25, $B3, $DE ; quar[re]l[ing ][with]
    db $59, $26, $32, $59, $E3, $27, $20, $A6 ; ⎵my⎵[you]ng[er]
    db $76 ; line 3
    db $1B, $2B, $28, $D8, $2B, $41, $8A, $08 ; bro[the]r.[  ]I
    db $59, $D0, $1A, $25, $A4, $D8, $59, $9F ; ⎵[se]al[ed ][the]⎵[do]
    db $C8, $59, $DA ; [or]⎵[to]
    db $7E ; wait for key
    db $73 ; scroll text
    db $B0, $2C, $59, $2B, $28, $28, $26, $41 ; [hi]s⎵room.
    db $7F ; end of message

    ; ==========================================================================
    ; So the doorway is open again…
    ; OK OK, maybe I should make up
    ; with my brother…
    ; --------------------------------------------------------------------------
    ; $0E632B
    Message_0130:
    db $12, $28, $59, $D8, $59, $9F, $C8, $DF ; So⎵[the]⎵[do][or][wa]
    db $32, $59, $B5, $59, $C3, $59, $1A, $20 ; y⎵[is]⎵[open]⎵ag
    db $8F, $43 ; [ain]…
    db $75 ; line 2
    db $0E, $0A, $59, $0E, $0A, $42, $59, $BD ; OK⎵OK,⎵[ma]
    db $32, $97, $59, $08, $59, $D1, $28, $2E ; y[be]⎵I⎵[sh]ou
    db $25, $1D, $59, $BD, $24, $1E, $59, $DC ; ld⎵[ma]ke⎵[up]
    db $76 ; line 3
    db $DE, $59, $26, $32, $59, $1B, $2B, $28 ; [with]⎵my⎵bro
    db $D8, $2B, $43 ; [the]r…
    db $7F ; end of message

    ; ==========================================================================
    ; Hey [LINK], did you come from
    ; my older brother's room?  Is he
    ; still angry?
    ; --------------------------------------------------------------------------
    ; $0E63323
    Message_0131:
    db $07, $1E, $32, $59, $6A, $42, $59, $9E ; Hey⎵[LINK],⎵[di]
    db $1D, $59, $E3, $59, $9B, $1E, $59, $A9 ; d⎵[you]⎵[com]e⎵[fro]
    db $26 ; m
    db $75 ; line 2
    db $26, $32, $59, $28, $25, $1D, $A1, $1B ; my⎵old[er ]b
    db $2B, $28, $D8, $2B, $8B, $2B, $28, $28 ; ro[the]r['s ]roo
    db $26, $3F, $8A, $08, $2C, $59, $21, $1E ; m?[  ]Is⎵he
    db $76 ; line 3
    db $D3, $22, $25, $25, $59, $93, $20, $2B ; [st]ill⎵[an]gr
    db $32, $3F ; y?
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you,  I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; …This world used to be the
    ; Golden Land where the Triforce
    ; was hidden.
    ; But because Ganon, the boss
    ; of thieves, wished it the world
    ; was transformed…
    ; I'm sure he's intending to
    ; conquer even our Light World
    ; after building his power here.
    ; He is trying to open a larger
    ; gate between worlds near the
    ; castle using our powers.
    ; But the gate is not open
    ; completely yet…
    ; If we seven maidens come
    ; together, we can break the
    ; barrier around Ganon's hiding
    ; place.
    ; I will tell you where the other
    ; girls are held.  I believe you
    ; will destroy Ganon.
    ; I will return to my original
    ; form at that time.
    ;  … … … … …
    ; --------------------------------------------------------------------------
    ; $0E6399
    Message_0132:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $8A, $08, $59 ; ⎵[of]⎵[you],[  ]I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $E7, $2C, $59, $30, $C8, $25, $1D ; …[Thi]s⎵w[or]ld
    db $59, $2E, $D0, $1D, $59, $DA, $59, $97 ; ⎵u[se]d⎵[to]⎵[be]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $06, $28, $25, $1D, $A0, $0B, $8C, $E1 ; Gold[en ]L[and ][wh]
    db $A6, $1E, $59, $D8, $59, $13, $2B, $22 ; [er]e⎵[the]⎵Tri
    db $A8, $1C, $1E ; [for]ce
    db $73 ; scroll text
    db $DF, $2C, $59, $B0, $1D, $1D, $A5, $41 ; [wa]s⎵[hi]dd[en].
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $97, $1C, $1A, $2E ; But⎵[be]cau
    db $D0, $59, $06, $93, $C7, $42, $59, $D8 ; [se]⎵G[an][on],⎵[the]
    db $59, $98, $2C, $2C ; ⎵[bo]ss
    db $73 ; scroll text
    db $C6, $59, $D9, $A7, $1E, $2C, $42, $59 ; [of]⎵[thi][ev]es,⎵
    db $E2, $D1, $A4, $B6, $59, $D8, $59, $30 ; [wi][sh][ed ][it]⎵[the]⎵w
    db $C8, $25, $1D ; [or]ld
    db $73 ; scroll text
    db $DF, $2C, $59, $DB, $93, $2C, $A8, $BE ; [wa]s⎵[tr][an]s[for][me]
    db $1D, $43 ; d…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $51, $26, $59, $2C, $2E, $CD, $21 ; I'm⎵su[re ]h
    db $1E, $8B, $B4, $2D, $A5, $9E, $27, $20 ; e['s ][in]t[en][di]ng
    db $59, $DA ; ⎵[to]
    db $73 ; scroll text
    db $1C, $C7, $2A, $2E, $A1, $A7, $A0, $28 ; c[on]qu[er ][ev][en ]o
    db $2E, $2B, $59, $0B, $B2, $16, $C8, $25 ; ur⎵L[ight ]W[or]l
    db $1D ; d
    db $73 ; scroll text
    db $1A, $1F, $D4, $1B, $2E, $22, $25, $9E ; af[ter ]buil[di]
    db $27, $20, $59, $B0, $2C, $59, $CB, $A1 ; ng⎵[hi]s⎵[pow][er ]
    db $AF, $1E, $41 ; [her]e.
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $59, $B5, $59, $DB, $32, $B3 ; He⎵[is]⎵[tr]y[ing ]
    db $DA, $59, $C3, $59, $1A, $59, $BA, $2B ; [to]⎵[open]⎵a⎵[la]r
    db $20, $A6 ; g[er]
    db $73 ; scroll text
    db $20, $94, $1E, $59, $97, $2D, $E0, $A0 ; g[at]e⎵[be]t[we][en ]
    db $30, $C8, $25, $1D, $2C, $59, $27, $A2 ; w[or]lds⎵n[ear]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $1C, $92, $25, $1E, $59, $2E, $2C, $B3 ; c[ast]le⎵us[ing ]
    db $28, $2E, $2B, $59, $CB, $A6, $2C, $41 ; our⎵[pow][er]s.
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $D8, $59, $20, $94 ; But⎵[the]⎵g[at]
    db $1E, $59, $B5, $59, $C2, $59, $C3 ; e⎵[is]⎵[not]⎵[open]
    db $73 ; scroll text
    db $9B, $CA, $2D, $1E, $B9, $32, $1E, $2D ; [com][ple]te[ly ]yet
    db $43 ; …
    db $73 ; scroll text
    db $08, $1F, $59, $E0, $59, $D0, $2F, $A0 ; If⎵[we]⎵[se]v[en ]
    db $BD, $22, $1D, $A5, $2C, $59, $9B, $1E ; [ma]id[en]s⎵[com]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $DA, $AB, $AF, $42, $59, $E0, $59, $99 ; [to][get][her],⎵[we]⎵[can ]
    db $1B, $CE, $1A, $24, $59, $D8 ; b[re]ak⎵[the]
    db $73 ; scroll text
    db $96, $2B, $2B, $22, $A1, $1A, $2B, $C4 ; [ba]rri[er ]ar[ound]
    db $59, $06, $93, $C7, $8B, $B0, $9E, $27 ; ⎵G[an][on]['s ][hi][di]n
    db $20 ; g
    db $73 ; scroll text
    db $29, $BA, $1C, $1E, $41 ; p[la]ce.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $2D, $1E ; I⎵[wi]ll⎵te
    db $25, $25, $59, $E3, $59, $E1, $A6, $1E ; ll⎵[you]⎵[wh][er]e
    db $59, $D8, $59, $28, $D8, $2B ; ⎵[the]⎵o[the]r
    db $73 ; scroll text
    db $20, $22, $2B, $25, $2C, $59, $8D, $21 ; girls⎵[are ]h
    db $1E, $25, $1D, $41, $8A, $08, $59, $97 ; eld.[  ]I⎵[be]
    db $25, $22, $A7, $1E, $59, $E3 ; li[ev]e⎵[you]
    db $73 ; scroll text
    db $E2, $25, $25, $59, $9D, $DB, $28, $32 ; [wi]ll⎵[des][tr]oy
    db $59, $06, $93, $C7, $41 ; ⎵G[an][on].
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $CE, $2D ; I⎵[wi]ll⎵[re]t
    db $2E, $2B, $27, $59, $DA, $59, $26, $32 ; urn⎵[to]⎵my
    db $59, $C8, $22, $20, $B4, $1A, $25 ; ⎵[or]ig[in]al
    db $73 ; scroll text
    db $A8, $26, $59, $91, $D7, $2D, $59, $2D ; [for]m⎵[at ][tha]t⎵t
    db $22, $BE, $41 ; i[me].
    db $73 ; scroll text
    db $59, $43, $59, $43, $59, $43, $59, $43 ; ⎵…⎵…⎵…⎵…
    db $59, $43 ; ⎵…
    db $79, $2D ; play sfx
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you, I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; …The Triforce will grant the
    ; wishes of whoever touches it,
    ; as long as that person lives…
    ; That is why it was hidden in
    ; the Golden Land.  Only a select
    ; few knew of its location,
    ; but at some point that
    ; knowledge was lost…
    ; The person who rediscovered
    ; the Golden Land was
    ; Ganondorf the evil thief.
    ; Luckily, he couldn't figure out
    ; how to return to the Light
    ; World…
    ; …Well, remember that you
    ; have magical powers, which only
    ; The Hero can make the most of!
    ; There are some other magical
    ; warping points like the one you
    ; saw on Death Mountain.
    ; By using them you can go
    ; between the two worlds and
    ; find the evils hidden in the
    ; Dark World.  You are the only
    ; one who can destroy
    ; Ganondorf, the thief-no,
    ; Ganon, the evil King Of
    ; Darkness!
    ; --------------------------------------------------------------------------
    ; $0E632B
    Message_0133:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $59, $08, $59 ; ⎵[of]⎵[you],⎵I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $E6, $59, $13, $2B, $22, $A8, $1C ; …[The]⎵Tri[for]c
    db $1E, $59, $E2, $25, $25, $59, $20, $2B ; e⎵[wi]ll⎵gr
    db $93, $2D, $59, $D8 ; [an]t⎵[the]
    db $73 ; scroll text
    db $E2, $D1, $1E, $2C, $59, $C6, $59, $E1 ; [wi][sh]es⎵[of]⎵[wh]
    db $28, $A7, $A1, $DA, $2E, $9A, $2C, $59 ; o[ev][er ][to]u[che]s⎵
    db $B6, $42 ; [it],
    db $73 ; scroll text
    db $1A, $2C, $59, $BB, $27, $20, $59, $1A ; as⎵[lo]ng⎵a
    db $2C, $59, $D7, $2D, $59, $C9, $D2, $27 ; s⎵[tha]t⎵[per][so]n
    db $59, $25, $22, $2F, $1E, $2C, $43 ; ⎵lives…
    db $7E ; wait for key
    db $73 ; scroll text
    db $E5, $2D, $59, $B5, $59, $E1, $32, $59 ; [Tha]t⎵[is]⎵[wh]y⎵
    db $B6, $59, $DF, $2C, $59, $B0, $1D, $1D ; [it]⎵[wa]s⎵[hi]dd
    db $A0, $B4 ; [en ][in]
    db $73 ; scroll text
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $90, $41, $8A, $0E, $27, $B9, $1A, $59 ; [and].[  ]On[ly ]a⎵
    db $D0, $25, $1E, $1C, $2D ; [se]lect
    db $73 ; scroll text
    db $1F, $1E, $30, $59, $24, $27, $1E, $30 ; few⎵knew
    db $59, $C6, $59, $B6, $2C, $59, $BB, $1C ; ⎵[of]⎵[it]s⎵[lo]c
    db $94, $22, $C7, $42 ; [at]i[on],
    db $7E ; wait for key
    db $73 ; scroll text
    db $1B, $2E, $2D, $59, $91, $CF, $59, $29 ; but⎵[at ][some]⎵p
    db $28, $B4, $2D, $59, $D7, $2D ; o[in]t⎵[tha]t
    db $73 ; scroll text
    db $B8, $25, $1E, $1D, $20, $1E, $59, $DF ; [know]ledge⎵[wa]
    db $2C, $59, $BB, $D3, $43 ; s⎵[lo][st]…
    db $73 ; scroll text
    db $E6, $59, $C9, $D2, $27, $59, $E1, $28 ; [The]⎵[per][so]n⎵[wh]o
    db $59, $CE, $9E, $2C, $1C, $28, $DD, $1E ; ⎵[re][di]sco[ver]e
    db $1D ; d
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $8C, $DF, $2C ; [and ][wa]s
    db $73 ; scroll text
    db $06, $93, $C7, $9F, $2B, $1F, $59, $D8 ; G[an][on][do]rf⎵[the]
    db $59, $A7, $22, $25, $59, $D9, $1E, $1F ; ⎵[ev]il⎵[thi]ef
    db $41 ; .
    db $73 ; scroll text
    db $0B, $2E, $9C, $22, $25, $32, $42, $59 ; Lu[ck]ily,⎵
    db $21, $1E, $59, $1C, $28, $2E, $25, $1D ; he⎵could
    db $C0, $1F, $22, $20, $2E, $CD, $28, $2E ; [n't ]figu[re ]ou
    db $2D ; t
    db $7E ; wait for key
    db $73 ; scroll text
    db $21, $28, $30, $59, $DA, $59, $CE, $2D ; how⎵[to]⎵[re]t
    db $2E, $2B, $27, $59, $DA, $59, $D8, $59 ; urn⎵[to]⎵[the]⎵
    db $0B, $22, $20, $21, $2D ; Light
    db $73 ; scroll text
    db $16, $C8, $25, $1D, $43 ; W[or]ld…
    db $73 ; scroll text
    db $43, $16, $1E, $25, $25, $42, $59, $CE ; …Well,⎵[re]
    db $BE, $26, $97, $2B, $59, $D7, $2D, $59 ; [me]m[be]r⎵[tha]t⎵
    db $E3 ; [you]
    db $7E ; wait for key
    db $73 ; scroll text
    db $AD, $59, $BD, $20, $22, $1C, $1A, $25 ; [have]⎵[ma]gical
    db $59, $CB, $A6, $2C, $42, $59, $E1, $22 ; ⎵[pow][er]s,⎵[wh]i
    db $1C, $21, $59, $C7, $25, $32 ; ch⎵[on]ly
    db $73 ; scroll text
    db $E6, $59, $E4, $28, $59, $99, $BD, $24 ; [The]⎵[Her]o⎵[can ][ma]k
    db $1E, $59, $D8, $59, $26, $28, $D3, $59 ; e⎵[the]⎵mo[st]⎵
    db $C6, $3E ; [of]!
    db $73 ; scroll text
    db $E6, $CD, $8D, $CF, $59, $28, $D8, $2B ; [The][re ][are ][some]⎵o[the]r
    db $59, $BD, $20, $22, $1C, $1A, $25 ; ⎵[ma]gical
    db $7E ; wait for key
    db $73 ; scroll text
    db $DF, $2B, $29, $B3, $29, $28, $B4, $2D ; [wa]rp[ing ]po[in]t
    db $2C, $59, $25, $22, $24, $1E, $59, $D8 ; s⎵like⎵[the]
    db $59, $C7, $1E, $59, $E3 ; ⎵[on]e⎵[you]
    db $73 ; scroll text
    db $2C, $1A, $30, $59, $C7, $59, $03, $1E ; saw⎵[on]⎵De
    db $94, $21, $59, $0C, $28, $2E, $27, $2D ; [at]h⎵Mount
    db $8F, $41 ; [ain].
    db $73 ; scroll text
    db $01, $32, $59, $2E, $2C, $B3, $D8, $26 ; By⎵us[ing ][the]m
    db $59, $E3, $59, $99, $AC ; ⎵[you]⎵[can ][go]
    db $7E ; wait for key
    db $73 ; scroll text
    db $97, $2D, $E0, $A0, $D8, $59, $2D, $30 ; [be]t[we][en ][the]⎵tw
    db $28, $59, $30, $C8, $25, $1D, $2C, $59 ; o⎵w[or]lds⎵
    db $90 ; [and]
    db $73 ; scroll text
    db $1F, $B4, $1D, $59, $D8, $59, $A7, $22 ; f[in]d⎵[the]⎵[ev]i
    db $25, $2C, $59, $B0, $1D, $1D, $A0, $B4 ; ls⎵[hi]dd[en ][in]
    db $59, $D8 ; ⎵[the]
    db $73 ; scroll text
    db $03, $1A, $2B, $24, $59, $16, $C8, $25 ; Dark⎵W[or]l
    db $1D, $41, $8A, $E8, $59, $8D, $D8, $59 ; d.[  ][You]⎵[are ][the]⎵
    db $C7, $25, $32 ; [on]ly
    db $7E ; wait for key
    db $73 ; scroll text
    db $C7, $1E, $59, $E1, $28, $59, $99, $9D ; [on]e⎵[wh]o⎵[can ][des]
    db $DB, $28, $32 ; [tr]oy
    db $73 ; scroll text
    db $06, $93, $C7, $9F, $2B, $1F, $42, $59 ; G[an][on][do]rf,⎵
    db $D8, $59, $D9, $1E, $1F, $40, $27, $28 ; [the]⎵[thi]ef-no
    db $42 ; ,
    db $73 ; scroll text
    db $06, $93, $C7, $42, $59, $D8, $59, $A7 ; G[an][on],⎵[the]⎵[ev]
    db $22, $25, $59, $0A, $B3, $0E, $1F ; il⎵K[ing ]Of
    db $7E ; wait for key
    db $73 ; scroll text
    db $03, $1A, $2B, $24, $27, $1E, $2C, $2C ; Darkness
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you, I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; …Do you know the prophecy of
    ; the Great Cataclysm?
    ; This is the way I heard it…
    ; If a person who has an evil
    ; heart gets the Triforce, a Hero
    ; is destined to appear…
    ; …and he alone must face the
    ; person who began the Great
    ; Cataclysm.
    ; If the evil one destroys the
    ; Hero, nothing can save the
    ; world from his wicked reign.
    ; Only a person of the Knights Of
    ; Hyrule, who protected the
    ; royalty of Hylia, can become
    ; the Hero…  You are of their
    ; blood-line, aren't you?  Then
    ; you must rescue
    ; Zelda without fail.
    ; --------------------------------------------------------------------------
    ; $0E67B7
    Message_0134:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $59, $08, $59 ; ⎵[of]⎵[you],⎵I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $03, $28, $59, $E3, $59, $B8, $59 ; …Do⎵[you]⎵[know]⎵
    db $D8, $59, $CC, $29, $21, $1E, $1C, $32 ; [the]⎵[pro]phecy
    db $59, $C6 ; ⎵[of]
    db $73 ; scroll text
    db $D8, $59, $06, $CE, $91, $02, $94, $1A ; [the]⎵G[re][at ]C[at]a
    db $1C, $25, $32, $2C, $26, $3F ; clysm?
    db $73 ; scroll text
    db $E7, $2C, $59, $B5, $59, $D8, $59, $DF ; [Thi]s⎵[is]⎵[the]⎵[wa]
    db $32, $59, $08, $59, $21, $A2, $1D, $59 ; y⎵I⎵h[ear]d⎵
    db $B6, $43 ; [it]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $1A, $59, $C9, $D2, $27 ; If⎵a⎵[per][so]n
    db $59, $E1, $28, $59, $AE, $59, $93, $59 ; ⎵[wh]o⎵[has]⎵[an]⎵
    db $A7, $22, $25 ; [ev]il
    db $73 ; scroll text
    db $21, $A2, $2D, $59, $AB, $2C, $59, $D8 ; h[ear]t⎵[get]s⎵[the]
    db $59, $13, $2B, $22, $A8, $1C, $1E, $42 ; ⎵Tri[for]ce,
    db $59, $1A, $59, $E4, $28 ; ⎵a⎵[Her]o
    db $73 ; scroll text
    db $B5, $59, $9D, $2D, $B4, $A4, $DA, $59 ; [is]⎵[des]t[in][ed ][to]⎵
    db $1A, $29, $29, $A2, $43 ; app[ear]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $8C, $21, $1E, $59, $1A, $BB, $27 ; …[and ]he⎵a[lo]n
    db $1E, $59, $BF, $D3, $59, $1F, $1A, $1C ; e⎵[mu][st]⎵fac
    db $1E, $59, $D8 ; e⎵[the]
    db $73 ; scroll text
    db $C9, $D2, $27, $59, $E1, $28, $59, $97 ; [per][so]n⎵[wh]o⎵[be]
    db $20, $93, $59, $D8, $59, $06, $CE, $94 ; g[an]⎵[the]⎵G[re][at]
    db $73 ; scroll text
    db $02, $94, $1A, $1C, $25, $32, $2C, $26 ; C[at]aclysm
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $1F, $59, $D8, $59, $A7, $22, $25 ; If⎵[the]⎵[ev]il
    db $59, $C7, $1E, $59, $9D, $DB, $28, $32 ; ⎵[on]e⎵[des][tr]oy
    db $2C, $59, $D8 ; s⎵[the]
    db $73 ; scroll text
    db $E4, $28, $42, $59, $C2, $B0, $27, $20 ; [Her]o,⎵[not][hi]ng
    db $59, $99, $2C, $1A, $2F, $1E, $59, $D8 ; ⎵[can ]save⎵[the]
    db $73 ; scroll text
    db $30, $C8, $25, $1D, $59, $A9, $26, $59 ; w[or]ld⎵[fro]m⎵
    db $B0, $2C, $59, $E2, $9C, $A4, $CE, $22 ; [hi]s⎵[wi][ck][ed ][re]i
    db $20, $27, $41 ; gn.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $27, $B9, $1A, $59, $C9, $D2, $27 ; On[ly ]a⎵[per][so]n
    db $59, $C6, $59, $D8, $59, $0A, $27, $22 ; ⎵[of]⎵[the]⎵Kni
    db $20, $21, $2D, $2C, $59, $0E, $1F ; ghts⎵Of
    db $73 ; scroll text
    db $07, $32, $2B, $2E, $25, $1E, $42, $59 ; Hyrule,⎵
    db $E1, $28, $59, $CC, $2D, $1E, $1C, $2D ; [wh]o⎵[pro]tect
    db $A4, $D8 ; [ed ][the]
    db $73 ; scroll text
    db $2B, $28, $32, $1A, $25, $2D, $32, $59 ; royalty⎵
    db $C6, $59, $07, $32, $25, $22, $1A, $42 ; [of]⎵Hylia,
    db $59, $99, $97, $9B, $1E ; ⎵[can ][be][com]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $E4, $28, $43, $8A, $E8, $59 ; [the]⎵[Her]o…[  ][You]⎵
    db $8D, $C6, $59, $D8, $22, $2B ; [are ][of]⎵[the]ir
    db $73 ; scroll text
    db $1B, $BB, $28, $1D, $40, $25, $B4, $1E ; b[lo]od-l[in]e
    db $42, $59, $1A, $CE, $C0, $E3, $3F, $8A ; ,⎵a[re][n't ][you]?[  ]
    db $E6, $27 ; [The]n
    db $73 ; scroll text
    db $E3, $59, $BF, $D3, $59, $CE, $2C, $1C ; [you]⎵[mu][st]⎵[re]sc
    db $2E, $1E ; ue
    db $7E ; wait for key
    db $73 ; scroll text
    db $19, $1E, $25, $1D, $1A, $59, $DE, $C5 ; Zelda⎵[with][out ]
    db $1F, $1A, $22, $25, $41 ; fail.
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you, I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; As the wise men sealed the way
    ; to the Dark World, the Knights
    ; Of Hyrule defended them from
    ; the attacks of evil monsters.
    ; I heard that the Knights Of
    ; Hyrule were nearly wiped out in
    ; that battle…
    ; You are perhaps the last one
    ; to carry on the blood-line of
    ; the Knights…
    ; It is ironic that the last one in
    ; the line has the potential to
    ; become the Hero of legend.
    ; Surely you can destroy Ganon!
    ; --------------------------------------------------------------------------
    ; $0E6951
    Message_0135:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $59, $08, $59 ; ⎵[of]⎵[you],⎵I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $2C, $59, $D8, $59, $E2, $D0, $59 ; As⎵[the]⎵[wi][se]⎵
    db $BE, $27, $59, $D0, $1A, $25, $A4, $D8 ; [me]n⎵[se]al[ed ][the]
    db $59, $DF, $32 ; ⎵[wa]y
    db $73 ; scroll text
    db $DA, $59, $D8, $59, $03, $1A, $2B, $24 ; [to]⎵[the]⎵Dark
    db $59, $16, $C8, $25, $1D, $42, $59, $D8 ; ⎵W[or]ld,⎵[the]
    db $59, $0A, $27, $22, $20, $21, $2D, $2C ; ⎵Knights
    db $73 ; scroll text
    db $0E, $1F, $59, $07, $32, $2B, $2E, $25 ; Of⎵Hyrul
    db $1E, $59, $1D, $1E, $1F, $A5, $1D, $A4 ; e⎵def[en]d[ed ]
    db $D8, $26, $59, $A9, $26 ; [the]m⎵[fro]m
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $94, $2D, $1A, $9C, $2C, $59 ; [the]⎵[at]ta[ck]s⎵
    db $C6, $59, $A7, $22, $25, $59, $26, $C7 ; [of]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41 ; [st][er]s.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $21, $A2, $1D, $59, $D7, $2D ; I⎵h[ear]d⎵[tha]t
    db $59, $D8, $59, $0A, $27, $22, $20, $21 ; ⎵[the]⎵Knigh
    db $2D, $2C, $59, $0E, $1F ; ts⎵Of
    db $73 ; scroll text
    db $07, $32, $2B, $2E, $25, $1E, $59, $E0 ; Hyrule⎵[we]
    db $CD, $27, $A2, $B9, $E2, $29, $A4, $C5 ; [re ]n[ear][ly ][wi]p[ed ][out ]
    db $B4 ; [in]
    db $73 ; scroll text
    db $D7, $2D, $59, $96, $2D, $2D, $25, $1E ; [tha]t⎵[ba]ttle
    db $43 ; …
    db $7E ; wait for key
    db $73 ; scroll text
    db $E8, $59, $8D, $C9, $B1, $29, $2C, $59 ; [You]⎵[are ][per][ha]ps⎵
    db $D8, $59, $BA, $D3, $59, $C7, $1E ; [the]⎵[la][st]⎵[on]e
    db $73 ; scroll text
    db $DA, $59, $1C, $1A, $2B, $2B, $32, $59 ; [to]⎵carry⎵
    db $C7, $59, $D8, $59, $1B, $BB, $28, $1D ; [on]⎵[the]⎵b[lo]od
    db $40, $25, $B4, $1E, $59, $C6 ; -l[in]e⎵[of]
    db $73 ; scroll text
    db $D8, $59, $0A, $27, $22, $20, $21, $2D ; [the]⎵Knight
    db $2C, $43 ; s…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $2D, $59, $B5, $59, $22, $2B, $C7 ; It⎵[is]⎵ir[on]
    db $22, $1C, $59, $D7, $2D, $59, $D8, $59 ; ic⎵[tha]t⎵[the]⎵
    db $BA, $D3, $59, $C7, $1E, $59, $B4 ; [la][st]⎵[on]e⎵[in]
    db $73 ; scroll text
    db $D8, $59, $25, $B4, $1E, $59, $AE, $59 ; [the]⎵l[in]e⎵[has]⎵
    db $D8, $59, $29, $28, $2D, $A3, $22, $1A ; [the]⎵pot[ent]ia
    db $25, $59, $DA ; l⎵[to]
    db $73 ; scroll text
    db $97, $9B, $1E, $59, $D8, $59, $E4, $28 ; [be][com]e⎵[the]⎵[Her]o
    db $59, $C6, $59, $25, $1E, $20, $A5, $1D ; ⎵[of]⎵leg[en]d
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $12, $2E, $CE, $B9, $E3, $59, $99, $9D ; Su[re][ly ][you]⎵[can ][des]
    db $DB, $28, $32, $59, $06, $93, $C7, $3E ; [tr]oy⎵G[an][on]!
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you, I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; They say the Hylia people
    ; controlled mysterious powers,
    ; as did the seven wise men.
    ; But the blood of the Hylia has
    ; become thin over time.  We who
    ; carry the blood of the seven
    ; wise men do not possess strong
    ; power any more, either.
    ; Our powers will increase if we
    ; mix the courage of the Knights
    ; with the wisdom of the wise
    ; men.  Only a short time remains
    ; until the gate at the castle
    ; linking the worlds opens
    ; completely.  If you defeat
    ; Ganon, this world will vanish
    ; and the Triforce will wait for
    ; a new holder.
    ; I believe in you…
    ; Good luck!
    ; --------------------------------------------------------------------------
    ; $0E67AA4
    Message_0136:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $59, $08, $59 ; ⎵[of]⎵[you],⎵I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $32, $59, $2C, $1A, $32, $59, $D8 ; [The]y⎵say⎵[the]
    db $59, $07, $32, $25, $22, $1A, $59, $29 ; ⎵Hylia⎵p
    db $1E, $28, $CA ; eo[ple]
    db $73 ; scroll text
    db $1C, $C7, $DB, $28, $25, $25, $A4, $26 ; c[on][tr]oll[ed ]m
    db $32, $D3, $A6, $22, $28, $2E, $2C, $59 ; y[st][er]ious⎵
    db $CB, $A6, $2C, $42 ; [pow][er]s,
    db $73 ; scroll text
    db $1A, $2C, $59, $9E, $1D, $59, $D8, $59 ; as⎵[di]d⎵[the]⎵
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $D8, $59, $1B, $BB ; But⎵[the]⎵b[lo]
    db $28, $1D, $59, $C6, $59, $D8, $59, $07 ; od⎵[of]⎵[the]⎵H
    db $32, $25, $22, $1A, $59, $AE ; ylia⎵[has]
    db $73 ; scroll text
    db $97, $9B, $1E, $59, $D5, $59, $28, $DD ; [be][com]e⎵[thin]⎵o[ver]
    db $59, $2D, $22, $BE, $41, $8A, $16, $1E ; ⎵ti[me].[  ]We
    db $59, $E1, $28 ; ⎵[wh]o
    db $73 ; scroll text
    db $1C, $1A, $2B, $2B, $32, $59, $D8, $59 ; carry⎵[the]⎵
    db $1B, $BB, $28, $1D, $59, $C6, $59, $D8 ; b[lo]od⎵[of]⎵[the]
    db $59, $D0, $2F, $A5 ; ⎵[se]v[en]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E2, $D0, $59, $BE, $27, $59, $9F, $59 ; [wi][se]⎵[me]n⎵[do]⎵
    db $C2, $59, $29, $28, $2C, $D0, $2C, $2C ; [not]⎵pos[se]ss
    db $59, $D3, $2B, $C7, $20 ; ⎵[st]r[on]g
    db $73 ; scroll text
    db $CB, $A1, $93, $32, $59, $26, $C8, $1E ; [pow][er ][an]y⎵m[or]e
    db $42, $59, $1E, $B6, $AF, $41 ; ,⎵e[it][her].
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $2E, $2B, $59, $CB, $A6, $2C, $59 ; Our⎵[pow][er]s⎵
    db $E2, $25, $25, $59, $B4, $1C, $CE, $1A ; [wi]ll⎵[in]c[re]a
    db $D0, $59, $22, $1F, $59, $E0 ; [se]⎵if⎵[we]
    db $73 ; scroll text
    db $26, $22, $31, $59, $D8, $59, $1C, $28 ; mix⎵[the]⎵co
    db $2E, $2B, $1A, $20, $1E, $59, $C6, $59 ; urage⎵[of]⎵
    db $D8, $59, $0A, $27, $22, $20, $21, $2D ; [the]⎵Knight
    db $2C ; s
    db $73 ; scroll text
    db $DE, $59, $D8, $59, $E2, $2C, $9F, $26 ; [with]⎵[the]⎵[wi]s[do]m
    db $59, $C6, $59, $D8, $59, $E2, $D0 ; ⎵[of]⎵[the]⎵[wi][se]
    db $7E ; wait for key
    db $73 ; scroll text
    db $BE, $27, $41, $8A, $0E, $27, $B9, $1A ; [me]n.[  ]On[ly ]a
    db $59, $D1, $C8, $2D, $59, $2D, $22, $BE ; ⎵[sh][or]t⎵ti[me]
    db $59, $CE, $BD, $B4, $2C ; ⎵[re][ma][in]s
    db $73 ; scroll text
    db $2E, $27, $2D, $22, $25, $59, $D8, $59 ; until⎵[the]⎵
    db $20, $94, $1E, $59, $91, $D8, $59, $1C ; g[at]e⎵[at ][the]⎵c
    db $92, $25, $1E ; [ast]le
    db $73 ; scroll text
    db $25, $B4, $24, $B3, $D8, $59, $30, $C8 ; l[in]k[ing ][the]⎵w[or]
    db $25, $1D, $2C, $59, $C3, $2C ; lds⎵[open]s
    db $7E ; wait for key
    db $73 ; scroll text
    db $9B, $CA, $2D, $1E, $25, $32, $41, $8A ; [com][ple]tely.[  ]
    db $08, $1F, $59, $E3, $59, $1D, $1E, $1F ; If⎵[you]⎵def
    db $1E, $94 ; e[at]
    db $73 ; scroll text
    db $06, $93, $C7, $42, $59, $D9, $2C, $59 ; G[an][on],⎵[thi]s⎵
    db $30, $C8, $25, $1D, $59, $E2, $25, $25 ; w[or]ld⎵[wi]ll
    db $59, $2F, $93, $B5, $21 ; ⎵v[an][is]h
    db $73 ; scroll text
    db $8C, $D8, $59, $13, $2B, $22, $A8, $1C ; [and ][the]⎵Tri[for]c
    db $1E, $59, $E2, $25, $25, $59, $DF, $B6 ; e⎵[wi]ll⎵[wa][it]
    db $59, $A8 ; ⎵[for]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1A, $59, $27, $1E, $30, $59, $21, $28 ; a⎵new⎵ho
    db $25, $1D, $A6, $41 ; ld[er].
    db $73 ; scroll text
    db $08, $59, $97, $25, $22, $A7, $1E, $59 ; I⎵[be]li[ev]e⎵
    db $B4, $59, $E3, $43 ; [in]⎵[you]…
    db $73 ; scroll text
    db $06, $28, $28, $1D, $59, $25, $2E, $9C ; Good⎵lu[ck]
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], because of you, I can
    ; escape from the clutches of
    ; the evil monsters.  Thank you!
    ; Ganon captured us because he
    ; couldn't break the seal of the
    ; wise men with his power alone.
    ; And then, using the wizard
    ; Agahnim as his pawn, he drew us
    ; to the Dark World.
    ; After cracking the seal with
    ; our powers, he sealed us inside
    ; of these crystals.
    ; He then gave us to his loyal
    ; monsters.  But Ganon didn't
    ; plan on your getting this far.
    ; Now, Princess Zelda is waiting
    ; for you inside of Turtle Rock.
    ; Please hurry!
    ; --------------------------------------------------------------------------
    ; $0E6C67
    Message_0137:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $6A, $42, $59, $97, $1C, $1A, $2E, $D0 ; [LINK],⎵[be]cau[se]
    db $59, $C6, $59, $E3, $42, $59, $08, $59 ; ⎵[of]⎵[you],⎵I⎵
    db $1C, $93 ; c[an]
    db $75 ; line 2
    db $1E, $2C, $1C, $1A, $29, $1E, $59, $A9 ; escape⎵[fro]
    db $26, $59, $D8, $59, $1C, $25, $2E, $2D ; m⎵[the]⎵clut
    db $9A, $2C, $59, $C6 ; [che]s⎵[of]
    db $76 ; line 3
    db $D8, $59, $A7, $22, $25, $59, $26, $C7 ; [the]⎵[ev]il⎵m[on]
    db $D3, $A6, $2C, $41, $8A, $E5, $27, $24 ; [st][er]s.[  ][Tha]nk
    db $59, $E3, $3E ; ⎵[you]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $59, $1C, $1A, $29, $2D ; G[an][on]⎵capt
    db $2E, $CE, $1D, $59, $2E, $2C, $59, $97 ; u[re]d⎵us⎵[be]
    db $1C, $1A, $2E, $D0, $59, $21, $1E ; cau[se]⎵he
    db $73 ; scroll text
    db $1C, $28, $2E, $25, $1D, $C0, $1B, $CE ; could[n't ]b[re]
    db $1A, $24, $59, $D8, $59, $D0, $1A, $25 ; ak⎵[the]⎵[se]al
    db $59, $C6, $59, $D8 ; ⎵[of]⎵[the]
    db $73 ; scroll text
    db $E2, $D0, $59, $BE, $27, $59, $DE, $59 ; [wi][se]⎵[me]n⎵[with]⎵
    db $B0, $2C, $59, $CB, $A1, $1A, $BB, $27 ; [hi]s⎵[pow][er ]a[lo]n
    db $1E, $41 ; e.
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $27, $1D, $59, $D8, $27, $42, $59 ; And⎵[the]n,⎵
    db $2E, $2C, $B3, $D8, $59, $E2, $33, $1A ; us[ing ][the]⎵[wi]za
    db $2B, $1D ; rd
    db $73 ; scroll text
    db $00, $20, $1A, $21, $27, $22, $26, $59 ; Agahnim⎵
    db $1A, $2C, $59, $B0, $2C, $59, $29, $1A ; as⎵[hi]s⎵pa
    db $30, $27, $42, $59, $21, $1E, $59, $1D ; wn,⎵he⎵d
    db $CE, $30, $59, $2E, $2C ; [re]w⎵us
    db $73 ; scroll text
    db $DA, $59, $D8, $59, $03, $1A, $2B, $24 ; [to]⎵[the]⎵Dark
    db $59, $16, $C8, $25, $1D, $41 ; ⎵W[or]ld.
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $1F, $D4, $1C, $2B, $1A, $9C, $B3 ; Af[ter ]cra[ck][ing ]
    db $D8, $59, $D0, $1A, $25, $59, $DE ; [the]⎵[se]al⎵[with]
    db $73 ; scroll text
    db $28, $2E, $2B, $59, $CB, $A6, $2C, $42 ; our⎵[pow][er]s,
    db $59, $21, $1E, $59, $D0, $1A, $25, $A4 ; ⎵he⎵[se]al[ed ]
    db $2E, $2C, $59, $B4, $2C, $22, $1D, $1E ; us⎵[in]side
    db $73 ; scroll text
    db $C6, $59, $D8, $D0, $59, $1C, $2B, $32 ; [of]⎵[the][se]⎵cry
    db $D3, $1A, $25, $2C, $41 ; [st]als.
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $59, $D8, $27, $59, $20, $1A ; He⎵[the]n⎵ga
    db $2F, $1E, $59, $2E, $2C, $59, $DA, $59 ; ve⎵us⎵[to]⎵
    db $B0, $2C, $59, $BB, $32, $1A, $25 ; [hi]s⎵[lo]yal
    db $73 ; scroll text
    db $26, $C7, $D3, $A6, $2C, $41, $8A, $01 ; m[on][st][er]s.[  ]B
    db $2E, $2D, $59, $06, $93, $C7, $59, $9E ; ut⎵G[an][on]⎵[di]
    db $1D, $27, $51, $2D ; dn't
    db $73 ; scroll text
    db $29, $BA, $27, $59, $C7, $59, $E3, $2B ; p[la]n⎵[on]⎵[you]r
    db $59, $AB, $2D, $B3, $D9, $2C, $59, $1F ; ⎵[get]t[ing ][thi]s⎵f
    db $1A, $2B, $41 ; ar.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $0F, $2B, $B4 ; Now,⎵Pr[in]
    db $1C, $1E, $2C, $2C, $59, $19, $1E, $25 ; cess⎵Zel
    db $1D, $1A, $59, $B5, $59, $DF, $B6, $B4 ; da⎵[is]⎵[wa][it][in]
    db $20 ; g
    db $73 ; scroll text
    db $A8, $59, $E3, $59, $B4, $2C, $22, $1D ; [for]⎵[you]⎵[in]sid
    db $1E, $59, $C6, $59, $13, $2E, $2B, $2D ; e⎵[of]⎵Turt
    db $25, $1E, $59, $11, $28, $9C, $41 ; le⎵Ro[ck].
    db $73 ; scroll text
    db $0F, $25, $1E, $1A, $D0, $59, $21, $2E ; Plea[se]⎵hu
    db $2B, $2B, $32, $3E ; rry!
    db $7F ; end of message

    ; ==========================================================================
    ; I appreciate your coming so far
    ; to rescue me.  As I thought,
    ; you are the legendary Hero.
    ; I have felt this from the first
    ; time we met.
    ; …  …  …
    ; Ganon is waiting inside of his
    ; tower to pass through the
    ; gate linking the two worlds.
    ; Once Ganon enters the Light
    ; World, it is unlikely that
    ; anyone can stop him.
    ; But if he stays in the closed
    ; space of this world, you can
    ; find him wherever he runs.
    ; Now, go to the Tower Of
    ; Ganon!  We will use our
    ; combined powers to break the
    ; barrier.  Let's return peace to
    ; the country without fail…
    ; …  …  …
    ; --------------------------------------------------------------------------
    ; $0E6DE5
    Message_0138:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $08, $59, $1A, $29, $29, $CE, $1C, $22 ; I⎵app[re]ci
    db $94, $1E, $59, $E3, $2B, $59, $9B, $B3 ; [at]e⎵[you]r⎵[com][ing ]
    db $D2, $59, $1F, $1A, $2B ; [so]⎵far
    db $75 ; line 2
    db $DA, $59, $CE, $2C, $1C, $2E, $1E, $59 ; [to]⎵[re]scue⎵
    db $BE, $41, $8A, $00, $2C, $59, $08, $59 ; [me].[  ]As⎵I⎵
    db $2D, $21, $28, $2E, $20, $21, $2D, $42 ; thought,
    db $76 ; line 3
    db $E3, $59, $8D, $D8, $59, $25, $1E, $20 ; [you]⎵[are ][the]⎵leg
    db $A5, $1D, $1A, $2B, $32, $59, $E4, $28 ; [en]dary⎵[Her]o
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $AD, $59, $1F, $1E, $25, $2D ; I⎵[have]⎵felt
    db $59, $D9, $2C, $59, $A9, $26, $59, $D8 ; ⎵[thi]s⎵[fro]m⎵[the]
    db $59, $1F, $22, $2B, $D3 ; ⎵fir[st]
    db $73 ; scroll text
    db $2D, $22, $BE, $59, $E0, $59, $BE, $2D ; ti[me]⎵[we]⎵[me]t
    db $41 ; .
    db $73 ; scroll text
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $59, $B5, $59, $DF, $B6 ; G[an][on]⎵[is]⎵[wa][it]
    db $B3, $B4, $2C, $22, $1D, $1E, $59, $C6 ; [ing ][in]side⎵[of]
    db $59, $B0, $2C ; ⎵[hi]s
    db $73 ; scroll text
    db $DA, $E0, $2B, $59, $DA, $59, $29, $1A ; [to][we]r⎵[to]⎵pa
    db $2C, $2C, $59, $2D, $21, $2B, $28, $2E ; ss⎵throu
    db $20, $21, $59, $D8 ; gh⎵[the]
    db $73 ; scroll text
    db $20, $94, $1E, $59, $25, $B4, $24, $B3 ; g[at]e⎵l[in]k[ing ]
    db $D8, $59, $2D, $30, $28, $59, $30, $C8 ; [the]⎵two⎵w[or]
    db $25, $1D, $2C, $41 ; lds.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $27, $1C, $1E, $59, $06, $93, $C7 ; Once⎵G[an][on]
    db $59, $A3, $A6, $2C, $59, $D8, $59, $0B ; ⎵[ent][er]s⎵[the]⎵L
    db $22, $20, $21, $2D ; ight
    db $73 ; scroll text
    db $16, $C8, $25, $1D, $42, $59, $B6, $59 ; W[or]ld,⎵[it]⎵
    db $B5, $59, $2E, $27, $25, $22, $24, $1E ; [is]⎵unlike
    db $B9, $D7, $2D ; [ly ][tha]t
    db $73 ; scroll text
    db $93, $32, $C7, $1E, $59, $99, $D3, $28 ; [an]y[on]e⎵[can ][st]o
    db $29, $59, $B0, $26, $41 ; p⎵[hi]m.
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $22, $1F, $59, $21 ; But⎵if⎵h
    db $1E, $59, $D3, $1A, $32, $2C, $59, $B4 ; e⎵[st]ays⎵[in]
    db $59, $D8, $59, $1C, $BB, $D0, $1D ; ⎵[the]⎵c[lo][se]d
    db $73 ; scroll text
    db $2C, $29, $1A, $1C, $1E, $59, $C6, $59 ; space⎵[of]⎵
    db $D9, $2C, $59, $30, $C8, $25, $1D, $42 ; [thi]s⎵w[or]ld,
    db $59, $E3, $59, $1C, $93 ; ⎵[you]⎵c[an]
    db $73 ; scroll text
    db $1F, $B4, $1D, $59, $B0, $26, $59, $E1 ; f[in]d⎵[hi]m⎵[wh]
    db $A6, $A7, $A1, $21, $1E, $59, $2B, $2E ; [er][ev][er ]he⎵ru
    db $27, $2C, $41 ; ns.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0D, $28, $30, $42, $59, $AC, $59, $DA ; Now,⎵[go]⎵[to]
    db $59, $D8, $59, $13, $28, $E0, $2B, $59 ; ⎵[the]⎵To[we]r⎵
    db $0E, $1F ; Of
    db $73 ; scroll text
    db $06, $93, $C7, $3E, $8A, $16, $1E, $59 ; G[an][on]![  ]We⎵
    db $E2, $25, $25, $59, $2E, $D0, $59, $28 ; [wi]ll⎵u[se]⎵o
    db $2E, $2B ; ur
    db $73 ; scroll text
    db $9B, $1B, $B4, $A4, $CB, $A6, $2C, $59 ; [com]b[in][ed ][pow][er]s⎵
    db $DA, $59, $1B, $CE, $1A, $24, $59, $D8 ; [to]⎵b[re]ak⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $96, $2B, $2B, $22, $A6, $41, $8A, $0B ; [ba]rri[er].[  ]L
    db $1E, $2D, $8B, $CE, $2D, $2E, $2B, $27 ; et['s ][re]turn
    db $59, $29, $1E, $1A, $1C, $1E, $59, $DA ; ⎵peace⎵[to]
    db $73 ; scroll text
    db $D8, $59, $1C, $28, $2E, $27, $DB, $32 ; [the]⎵coun[tr]y
    db $59, $DE, $C5, $1F, $1A, $22, $25, $43 ; ⎵[with][out ]fail…
    db $73 ; scroll text
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $79, $2D ; play sfx
    db $7F ; end of message

    ; ==========================================================================
    ; May the way of the Hero lead
    ; to the Triforce.
    ; --------------------------------------------------------------------------
    ; $0E6F78
    Message_0139:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $0C, $1A, $32, $59, $D8, $59, $DF, $32 ; May⎵[the]⎵[wa]y
    db $59, $C6, $59, $D8, $59, $E4, $28, $59 ; ⎵[of]⎵[the]⎵[Her]o⎵
    db $25, $1E, $1A, $1D ; lead
    db $75 ; line 2
    db $DA, $59, $D8, $59, $13, $2B, $22, $A8 ; [to]⎵[the]⎵Tri[for]
    db $1C, $1E, $41 ; ce.
    db $7F ; end of message

    ; ==========================================================================
    ; Do you understand?
    ;     >  Yes
    ;         Not at all
    ; --------------------------------------------------------------------------
    ; $0E6F9F
    Message_013A:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $03, $28, $59, $E3, $59, $2E, $27, $1D ; Do⎵[you]⎵und
    db $A6, $D3, $90, $3F ; [er][st][and]?
    db $75 ; line 2
    db $88, $44, $8A, $18, $1E, $2C ; [    ]>[  ]Yes
    db $76 ; line 3
    db $88, $88, $0D, $28, $2D, $59, $91, $1A ; [    ][    ]Not⎵[at ]a
    db $25, $25 ; ll
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; [LINK], we are going to break
    ; the barrier of Ganon's Tower
    ; with our power.
    ; --------------------------------------------------------------------------
    ; $0E6FC5
    Message_013B:
    db $6A, $42, $59, $E0, $59, $8D, $AC, $B3 ; [LINK],⎵[we]⎵[are ][go][ing ]
    db $DA, $59, $1B, $CE, $1A, $24 ; [to]⎵b[re]ak
    db $75 ; line 2
    db $D8, $59, $96, $2B, $2B, $22, $A1, $C6 ; [the]⎵[ba]rri[er ][of]
    db $59, $06, $93, $C7, $8B, $13, $28, $E0 ; ⎵G[an][on]['s ]To[we]
    db $2B ; r
    db $76 ; line 3
    db $DE, $59, $28, $2E, $2B, $59, $CB, $A6 ; [with]⎵our⎵[pow][er]
    db $41 ; .
    db $7F ; end of message

    ; ==========================================================================
    ; I appreciate your coming so far
    ; to rescue me.  As I thought,
    ; you are the legendary Hero.
    ; I have felt this from the first
    ; time we met.
    ; …  …  …
    ; Ganon is waiting inside of his
    ; tower to pass through the
    ; gate linking the two worlds.
    ; Once Ganon enters the Light
    ; World, it is unlikely that
    ; anyone can stop him.
    ; But if he stays in the closed
    ; space of this world, you can
    ; find him wherever he runs.
    ; Some maidens still need your
    ; help, though.  Once you rescue
    ; them all, go to Ganon's Tower.
    ; We who are of the blood-line of
    ; the wise men will then use our
    ; power to break
    ; Ganon's barrier!  
    ; [LINK]…  You must return
    ; peace to this country…
    ; --------------------------------------------------------------------------
    ; $0E6FF0
    Message_013C:
    db $7A, $02 ; set draw speed
    db $6D, $01 ; set window position
    db $6B, $02 ; set window border
    db $08, $59, $1A, $29, $29, $CE, $1C, $22 ; I⎵app[re]ci
    db $94, $1E, $59, $E3, $2B, $59, $9B, $B3 ; [at]e⎵[you]r⎵[com][ing ]
    db $D2, $59, $1F, $1A, $2B ; [so]⎵far
    db $75 ; line 2
    db $DA, $59, $CE, $2C, $1C, $2E, $1E, $59 ; [to]⎵[re]scue⎵
    db $BE, $41, $8A, $00, $2C, $59, $08, $59 ; [me].[  ]As⎵I⎵
    db $2D, $21, $28, $2E, $20, $21, $2D, $42 ; thought,
    db $76 ; line 3
    db $E3, $59, $8D, $D8, $59, $25, $1E, $20 ; [you]⎵[are ][the]⎵leg
    db $A5, $1D, $1A, $2B, $32, $59, $E4, $28 ; [en]dary⎵[Her]o
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $AD, $59, $1F, $1E, $25, $2D ; I⎵[have]⎵felt
    db $59, $D9, $2C, $59, $A9, $26, $59, $D8 ; ⎵[thi]s⎵[fro]m⎵[the]
    db $59, $1F, $22, $2B, $D3 ; ⎵fir[st]
    db $73 ; scroll text
    db $2D, $22, $BE, $59, $E0, $59, $BE, $2D ; ti[me]⎵[we]⎵[me]t
    db $41 ; .
    db $73 ; scroll text
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $59, $B5, $59, $DF, $B6 ; G[an][on]⎵[is]⎵[wa][it]
    db $B3, $B4, $2C, $22, $1D, $1E, $59, $C6 ; [ing ][in]side⎵[of]
    db $59, $B0, $2C ; ⎵[hi]s
    db $73 ; scroll text
    db $DA, $E0, $2B, $59, $DA, $59, $29, $1A ; [to][we]r⎵[to]⎵pa
    db $2C, $2C, $59, $2D, $21, $2B, $28, $2E ; ss⎵throu
    db $20, $21, $59, $D8 ; gh⎵[the]
    db $73 ; scroll text
    db $20, $94, $1E, $59, $25, $B4, $24, $B3 ; g[at]e⎵l[in]k[ing ]
    db $D8, $59, $2D, $30, $28, $59, $30, $C8 ; [the]⎵two⎵w[or]
    db $25, $1D, $2C, $41 ; lds.
    db $7E ; wait for key
    db $73 ; scroll text
    db $0E, $27, $1C, $1E, $59, $06, $93, $C7 ; Once⎵G[an][on]
    db $59, $A3, $A6, $2C, $59, $D8, $59, $0B ; ⎵[ent][er]s⎵[the]⎵L
    db $22, $20, $21, $2D ; ight
    db $73 ; scroll text
    db $16, $C8, $25, $1D, $42, $59, $B6, $59 ; W[or]ld,⎵[it]⎵
    db $B5, $59, $2E, $27, $25, $22, $24, $1E ; [is]⎵unlike
    db $B9, $D7, $2D ; [ly ][tha]t
    db $73 ; scroll text
    db $93, $32, $C7, $1E, $59, $99, $D3, $28 ; [an]y[on]e⎵[can ][st]o
    db $29, $59, $B0, $26, $41 ; p⎵[hi]m.
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $22, $1F, $59, $21 ; But⎵if⎵h
    db $1E, $59, $D3, $1A, $32, $2C, $59, $B4 ; e⎵[st]ays⎵[in]
    db $59, $D8, $59, $1C, $BB, $D0, $1D ; ⎵[the]⎵c[lo][se]d
    db $73 ; scroll text
    db $2C, $29, $1A, $1C, $1E, $59, $C6, $59 ; space⎵[of]⎵
    db $D9, $2C, $59, $30, $C8, $25, $1D, $42 ; [thi]s⎵w[or]ld,
    db $59, $E3, $59, $1C, $93 ; ⎵[you]⎵c[an]
    db $73 ; scroll text
    db $1F, $B4, $1D, $59, $B0, $26, $59, $E1 ; f[in]d⎵[hi]m⎵[wh]
    db $A6, $A7, $A1, $21, $1E, $59, $2B, $2E ; [er][ev][er ]he⎵ru
    db $27, $2C, $41 ; ns.
    db $7E ; wait for key
    db $73 ; scroll text
    db $12, $28, $BE, $59, $BD, $22, $1D, $A5 ; So[me]⎵[ma]id[en]
    db $2C, $59, $D3, $22, $25, $25, $59, $27 ; s⎵[st]ill⎵n
    db $1E, $A4, $E3, $2B ; e[ed ][you]r
    db $73 ; scroll text
    db $21, $1E, $25, $29, $42, $59, $2D, $21 ; help,⎵th
    db $28, $2E, $20, $21, $41, $8A, $0E, $27 ; ough.[  ]On
    db $1C, $1E, $59, $E3, $59, $CE, $2C, $1C ; ce⎵[you]⎵[re]sc
    db $2E, $1E ; ue
    db $73 ; scroll text
    db $D8, $26, $59, $1A, $25, $25, $42, $59 ; [the]m⎵all,⎵
    db $AC, $59, $DA, $59, $06, $93, $C7, $8B ; [go]⎵[to]⎵G[an][on]['s ]
    db $13, $28, $E0, $2B, $41 ; To[we]r.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $1E, $59, $E1, $28, $59, $8D, $C6 ; We⎵[wh]o⎵[are ][of]
    db $59, $D8, $59, $1B, $BB, $28, $1D, $40 ; ⎵[the]⎵b[lo]od-
    db $25, $B4, $1E, $59, $C6 ; l[in]e⎵[of]
    db $73 ; scroll text
    db $D8, $59, $E2, $D0, $59, $BE, $27, $59 ; [the]⎵[wi][se]⎵[me]n⎵
    db $E2, $25, $25, $59, $D8, $27, $59, $2E ; [wi]ll⎵[the]n⎵u
    db $D0, $59, $28, $2E, $2B ; [se]⎵our
    db $73 ; scroll text
    db $CB, $A1, $DA, $59, $1B, $CE, $1A, $24 ; [pow][er ][to]⎵b[re]ak
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $8B, $96, $2B, $2B, $22 ; G[an][on]['s ][ba]rri
    db $A6, $3E, $8A ; [er]![  ]
    db $73 ; scroll text
    db $6A, $43, $8A, $E8, $59, $BF, $D3, $59 ; [LINK]…[  ][You]⎵[mu][st]⎵
    db $CE, $2D, $2E, $2B, $27 ; [re]turn
    db $73 ; scroll text
    db $29, $1E, $1A, $1C, $1E, $59, $DA, $59 ; peace⎵[to]⎵
    db $D9, $2C, $59, $1C, $28, $2E, $27, $DB ; [thi]s⎵coun[tr]
    db $32, $43 ; y…
    db $7F ; end of message

    ; ==========================================================================
    ; Ahah… [LINK]!
    ; I have been waiting for you!
    ; Heh heh heh…
    ; I was hoping I could make Zelda
    ; vanish in front of your eyes.
    ; Behold!  The last moment of
    ; Princess Zelda!
    ; --------------------------------------------------------------------------
    ; $0E71C3
    Message_013D:
    db $00, $B1, $21, $43, $59, $6A, $3E ; A[ha]h…⎵[LINK]!
    db $75 ; line 2
    db $08, $59, $AD, $59, $97, $A0, $DF, $B6 ; I⎵[have]⎵[be][en ][wa][it]
    db $B3, $A8, $59, $E3, $3E ; [ing ][for]⎵[you]!
    db $76 ; line 3
    db $07, $1E, $21, $59, $21, $1E, $21, $59 ; Heh⎵heh⎵
    db $21, $1E, $21, $43 ; heh…
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $DF, $2C, $59, $21, $28, $29 ; I⎵[wa]s⎵hop
    db $B3, $08, $59, $1C, $28, $2E, $25, $1D ; [ing ]I⎵could
    db $59, $BD, $24, $1E, $59, $19, $1E, $25 ; ⎵[ma]ke⎵Zel
    db $1D, $1A ; da
    db $73 ; scroll text
    db $2F, $93, $B5, $21, $59, $B4, $59, $A9 ; v[an][is]h⎵[in]⎵[fro]
    db $27, $2D, $59, $C6, $59, $E3, $2B, $59 ; nt⎵[of]⎵[you]r⎵
    db $1E, $32, $1E, $2C, $41 ; eyes.
    db $73 ; scroll text
    db $01, $1E, $21, $28, $25, $1D, $3E, $8A ; Behold![  ]
    db $E6, $59, $BA, $D3, $59, $26, $28, $BE ; [The]⎵[la][st]⎵mo[me]
    db $27, $2D, $59, $C6 ; nt⎵[of]
    db $7E ; wait for key
    db $73 ; scroll text
    db $0F, $2B, $B4, $1C, $1E, $2C, $2C, $59 ; Pr[in]cess⎵
    db $19, $1E, $25, $1D, $1A, $3E ; Zelda!
    db $7F ; end of message

    ; ==========================================================================
    ; Ho ho ho…  With this, the
    ; seal of the seven wise men is
    ; at last broken.
    ; It is now only a matter of time
    ; before evil power covers this
    ; land…
    ; After all, the legendary Hero
    ; cannot defeat us, the tribe of
    ; evil, when we are armed with
    ; the Power of Gold.
    ; Ho ho ho… Now, I must go!
    ; --------------------------------------------------------------------------
    ; $0E723D
    Message_013E:
    db $07, $28, $59, $21, $28, $59, $21, $28 ; Ho⎵ho⎵ho
    db $43, $8A, $16, $B6, $21, $59, $D9, $2C ; …[  ]W[it]h⎵[thi]s
    db $42, $59, $D8 ; ,⎵[the]
    db $75 ; line 2
    db $D0, $1A, $25, $59, $C6, $59, $D8, $59 ; [se]al⎵[of]⎵[the]⎵
    db $D0, $2F, $A0, $E2, $D0, $59, $BE, $27 ; [se]v[en ][wi][se]⎵[me]n
    db $59, $B5 ; ⎵[is]
    db $76 ; line 3
    db $91, $BA, $D3, $59, $1B, $2B, $28, $24 ; [at ][la][st]⎵brok
    db $A5, $41 ; [en].
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $2D, $59, $B5, $59, $27, $28, $30 ; It⎵[is]⎵now
    db $59, $C7, $B9, $1A, $59, $BD, $2D, $D4 ; ⎵[on][ly ]a⎵[ma]t[ter ]
    db $C6, $59, $2D, $22, $BE ; [of]⎵ti[me]
    db $73 ; scroll text
    db $97, $A8, $1E, $59, $A7, $22, $25, $59 ; [be][for]e⎵[ev]il⎵
    db $CB, $A1, $1C, $28, $DD, $2C, $59, $D9 ; [pow][er ]co[ver]s⎵[thi]
    db $2C ; s
    db $73 ; scroll text
    db $BA, $27, $1D, $43 ; [la]nd…
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $1F, $D4, $1A, $25, $25, $42, $59 ; Af[ter ]all,⎵
    db $D8, $59, $25, $1E, $20, $A5, $1D, $1A ; [the]⎵leg[en]da
    db $2B, $32, $59, $E4, $28 ; ry⎵[Her]o
    db $73 ; scroll text
    db $1C, $93, $C2, $59, $1D, $1E, $1F, $1E ; c[an][not]⎵defe
    db $91, $2E, $2C, $42, $59, $D8, $59, $DB ; [at ]us,⎵[the]⎵[tr]
    db $22, $97, $59, $C6 ; i[be]⎵[of]
    db $73 ; scroll text
    db $A7, $22, $25, $42, $59, $E1, $A0, $E0 ; [ev]il,⎵[wh][en ][we]
    db $59, $8D, $1A, $2B, $BE, $1D, $59, $DE ; ⎵[are ]ar[me]d⎵[with]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $0F, $28, $E0, $2B, $59, $C6 ; [the]⎵Po[we]r⎵[of]
    db $59, $06, $28, $25, $1D, $41 ; ⎵Gold.
    db $73 ; scroll text
    db $07, $28, $59, $21, $28, $59, $21, $28 ; Ho⎵ho⎵ho
    db $43, $59, $0D, $28, $30, $42, $59, $08 ; …⎵Now,⎵I
    db $59, $BF, $D3, $59, $AC, $3E ; ⎵[mu][st]⎵[go]!
    db $7F ; end of message

    ; ==========================================================================
    ; Oh, so?…  You mean to say you
    ; would like to be totally
    ; destroyed?  Well, I can make
    ; your wish come true!
    ; --------------------------------------------------------------------------
    ; $0E7301
    Message_013F:
    db $0E, $21, $42, $59, $D2, $3F, $43, $8A ; Oh,⎵[so]?…[  ]
    db $E8, $59, $BE, $93, $59, $DA, $59, $2C ; [You]⎵[me][an]⎵[to]⎵s
    db $1A, $32, $59, $E3 ; ay⎵[you]
    db $75 ; line 2
    db $30, $28, $2E, $25, $1D, $59, $25, $22 ; would⎵li
    db $24, $1E, $59, $DA, $59, $97, $59, $DA ; ke⎵[to]⎵[be]⎵[to]
    db $2D, $1A, $25, $25, $32 ; tally
    db $76 ; line 3
    db $9D, $DB, $28, $32, $1E, $1D, $3F, $8A ; [des][tr]oyed?[  ]
    db $16, $1E, $25, $25, $42, $59, $08, $59 ; Well,⎵I⎵
    db $99, $BD, $24, $1E ; [can ][ma]ke
    db $7E ; wait for key
    db $73 ; scroll text
    db $E3, $2B, $59, $E2, $D1, $59, $9B, $1E ; [you]r⎵[wi][sh]⎵[com]e
    db $59, $DB, $2E, $1E, $3E ; ⎵[tr]ue!
    db $7F ; end of message

    ; ==========================================================================
    ; Grrrrugh!  Well met!  Like the
    ; true Hero that you are…
    ; But I am not ready to admit
    ; defeat yet.  I will draw you
    ; into the Dark World!
    ; --------------------------------------------------------------------------
    ; $0E7350
    Message_0140:
    db $06, $2B, $2B, $2B, $2B, $2E, $20, $21 ; Grrrrugh
    db $3E, $8A, $16, $1E, $25, $25, $59, $BE ; ![  ]Well⎵[me]
    db $2D, $3E, $8A, $0B, $22, $24, $1E, $59 ; t![  ]Like⎵
    db $D8 ; [the]
    db $75 ; line 2
    db $DB, $2E, $1E, $59, $E4, $28, $59, $D7 ; [tr]ue⎵[Her]o⎵[tha]
    db $2D, $59, $E3, $59, $1A, $CE, $43 ; t⎵[you]⎵a[re]…
    db $76 ; line 3
    db $01, $2E, $2D, $59, $08, $59, $1A, $26 ; But⎵I⎵am
    db $59, $C2, $59, $CE, $1A, $1D, $32, $59 ; ⎵[not]⎵[re]ady⎵
    db $DA, $59, $1A, $1D, $26, $B6 ; [to]⎵adm[it]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1D, $1E, $1F, $1E, $91, $32, $1E, $2D ; defe[at ]yet
    db $41, $8A, $08, $59, $E2, $25, $25, $59 ; .[  ]I⎵[wi]ll⎵
    db $1D, $2B, $1A, $30, $59, $E3 ; draw⎵[you]
    db $73 ; scroll text
    db $B4, $DA, $59, $D8, $59, $03, $1A, $2B ; [in][to]⎵[the]⎵Dar
    db $24, $59, $16, $C8, $25, $1D, $3E ; k⎵W[or]ld!
    db $7F ; end of message

    ; ==========================================================================
    ; Ho ho ho!  It's great that you
    ; could come all the way here,
    ; [LINK].
    ; I'm very happy to see you
    ; again, but
    ; you'd better believe that we
    ; will not have a third meeting!
    ; Prepare to meet your doom!
    ; --------------------------------------------------------------------------
    ; $0E73B9
    Message_0141:
    db $07, $28, $59, $21, $28, $59, $21, $28 ; Ho⎵ho⎵ho
    db $3E, $8A, $08, $2D, $8B, $20, $CE, $91 ; ![  ]It['s ]g[re][at ]
    db $D7, $2D, $59, $E3 ; [tha]t⎵[you]
    db $75 ; line 2
    db $1C, $28, $2E, $25, $1D, $59, $9B, $1E ; could⎵[com]e
    db $59, $8E, $D8, $59, $DF, $32, $59, $AF ; ⎵[all ][the]⎵[wa]y⎵[her]
    db $1E, $42 ; e,
    db $76 ; line 3
    db $6A, $41 ; [LINK].
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $51, $26, $59, $DD, $32, $59, $B1 ; I'm⎵[ver]y⎵[ha]
    db $29, $29, $32, $59, $DA, $59, $D0, $1E ; ppy⎵[to]⎵[se]e
    db $59, $E3 ; ⎵[you]
    db $73 ; scroll text
    db $1A, $20, $8F, $42, $59, $1B, $2E, $2D ; ag[ain],⎵but
    db $73 ; scroll text
    db $E3, $51, $1D, $59, $97, $2D, $D4, $97 ; [you]'d⎵[be]t[ter ][be]
    db $25, $22, $A7, $1E, $59, $D7, $2D, $59 ; li[ev]e⎵[tha]t⎵
    db $E0 ; [we]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E2, $25, $25, $59, $C2, $59, $AD, $59 ; [wi]ll⎵[not]⎵[have]⎵
    db $1A, $59, $D9, $2B, $1D, $59, $BE, $1E ; a⎵[thi]rd⎵[me]e
    db $2D, $B4, $20, $3E ; t[in]g!
    db $73 ; scroll text
    db $0F, $CE, $29, $8D, $DA, $59, $BE, $1E ; P[re]p[are ][to]⎵[me]e
    db $2D, $59, $E3, $2B, $59, $9F, $28, $26 ; t⎵[you]r⎵[do]om
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Wah ha ha!  What do you want,
    ; little man?  Do you have
    ; something to ask me?
    ;     >  I want the flippers
    ;         I just dropped by
    ; --------------------------------------------------------------------------
    ; $0E743B
    Message_0142:
    db $16, $1A, $21, $59, $B1, $59, $B1, $3E ; Wah⎵[ha]⎵[ha]!
    db $8A, $16, $B1, $2D, $59, $9F, $59, $E3 ; [  ]W[ha]t⎵[do]⎵[you]
    db $59, $DF, $27, $2D, $42 ; ⎵[wa]nt,
    db $75 ; line 2
    db $25, $B6, $2D, $25, $1E, $59, $BC, $3F ; l[it]tle⎵[man]?
    db $8A, $03, $28, $59, $E3, $59, $AD ; [  ]Do⎵[you]⎵[have]
    db $76 ; line 3
    db $CF, $D5, $20, $59, $DA, $59, $1A, $2C ; [some][thin]g⎵[to]⎵as
    db $24, $59, $BE, $3F ; k⎵[me]?
    db $7E ; wait for key
    db $73 ; scroll text
    db $88, $44, $8A, $08, $59, $DF, $27, $2D ; [    ]>[  ]I⎵[wa]nt
    db $59, $D8, $59, $1F, $25, $22, $29, $C9 ; ⎵[the]⎵flip[per]
    db $2C ; s
    db $73 ; scroll text
    db $88, $88, $08, $59, $B7, $59, $1D, $2B ; [    ][    ]I⎵[just]⎵dr
    db $28, $29, $29, $A4, $1B, $32 ; opp[ed ]by
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Wah ha ha!  But I don't just
    ; give flippers away for free.
    ; I sell them for 500 Rupees a
    ; pair.
    ; What do you do?
    ;     >  Pay 500 Rupees
    ;         Quit after all
    ; --------------------------------------------------------------------------
    ; $0E7491
    Message_0143:
    db $16, $1A, $21, $59, $B1, $59, $B1, $3E ; Wah⎵[ha]⎵[ha]!
    db $8A, $01, $2E, $2D, $59, $08, $59, $9F ; [  ]But⎵I⎵[do]
    db $C0, $B7 ; [n't ][just]
    db $75 ; line 2
    db $AA, $1F, $25, $22, $29, $C9, $2C, $59 ; [give ]flip[per]s⎵
    db $1A, $DF, $32, $59, $A8, $59, $1F, $CE ; a[wa]y⎵[for]⎵f[re]
    db $1E, $41 ; e.
    db $76 ; line 3
    db $08, $59, $D0, $25, $25, $59, $D8, $26 ; I⎵[se]ll⎵[the]m
    db $59, $A8, $59, $39, $34, $34, $59, $11 ; ⎵[for]⎵500⎵R
    db $DC, $1E, $1E, $2C, $59, $1A ; [up]ees⎵a
    db $7E ; wait for key
    db $73 ; scroll text
    db $29, $1A, $22, $2B, $41 ; pair.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $9F, $59, $E3, $59 ; W[ha]t⎵[do]⎵[you]⎵
    db $9F, $3F ; [do]?
    db $73 ; scroll text
    db $88, $44, $8A, $0F, $1A, $32, $59, $39 ; [    ]>[  ]Pay⎵5
    db $34, $34, $59, $11, $DC, $1E, $1E, $2C ; 00⎵R[up]ees
    db $73 ; scroll text
    db $88, $88, $10, $2E, $B6, $59, $1A, $1F ; [    ][    ]Qu[it]⎵af
    db $D4, $1A, $25, $25 ; [ter ]all
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Wah ha ha!  One pair of
    ; flippers coming up.  I will
    ; give you a free bonus with
    ; your purchase.
    ; I will let you use the magic
    ; water ways of the sea folk
    ; which link lakes and rivers.
    ; When you see a whirlpool, dive
    ; into it.  You never know where
    ; you'll surface!  Wah ha ha!
    ; --------------------------------------------------------------------------
    ; $0E7500
    Message_0144:
    db $16, $1A, $21, $59, $B1, $59, $B1, $3E ; Wah⎵[ha]⎵[ha]!
    db $8A, $0E, $27, $1E, $59, $29, $1A, $22 ; [  ]One⎵pai
    db $2B, $59, $C6 ; r⎵[of]
    db $75 ; line 2
    db $1F, $25, $22, $29, $C9, $2C, $59, $9B ; flip[per]s⎵[com]
    db $B3, $DC, $41, $8A, $08, $59, $E2, $25 ; [ing ][up].[  ]I⎵[wi]l
    db $25 ; l
    db $76 ; line 3
    db $AA, $E3, $59, $1A, $59, $1F, $CE, $1E ; [give ][you]⎵a⎵f[re]e
    db $59, $98, $27, $2E, $2C, $59, $DE ; ⎵[bo]nus⎵[with]
    db $7E ; wait for key
    db $73 ; scroll text
    db $E3, $2B, $59, $29, $2E, $2B, $1C, $AE ; [you]r⎵purc[has]
    db $1E, $41 ; e.
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $25, $1E ; I⎵[wi]ll⎵le
    db $2D, $59, $E3, $59, $2E, $D0, $59, $D8 ; t⎵[you]⎵u[se]⎵[the]
    db $59, $BD, $20, $22, $1C ; ⎵[ma]gic
    db $73 ; scroll text
    db $DF, $D4, $DF, $32, $2C, $59, $C6, $59 ; [wa][ter ][wa]ys⎵[of]⎵
    db $D8, $59, $D0, $1A, $59, $1F, $28, $25 ; [the]⎵[se]a⎵fol
    db $24 ; k
    db $7E ; wait for key
    db $73 ; scroll text
    db $E1, $22, $1C, $21, $59, $25, $B4, $24 ; [wh]ich⎵l[in]k
    db $59, $BA, $24, $1E, $2C, $59, $8C, $2B ; ⎵[la]kes⎵[and ]r
    db $22, $DD, $2C, $41 ; i[ver]s.
    db $73 ; scroll text
    db $16, $21, $A0, $E3, $59, $D0, $1E, $59 ; Wh[en ][you]⎵[se]e⎵
    db $1A, $59, $E1, $22, $2B, $25, $29, $28 ; a⎵[wh]irlpo
    db $28, $25, $42, $59, $9E, $2F, $1E ; ol,⎵[di]ve
    db $73 ; scroll text
    db $B4, $DA, $59, $B6, $41, $8A, $E8, $59 ; [in][to]⎵[it].[  ][You]⎵
    db $27, $A7, $A1, $B8, $59, $E1, $A6, $1E ; n[ev][er ][know]⎵[wh][er]e
    db $7E ; wait for key
    db $73 ; scroll text
    db $E3, $51, $25, $25, $59, $2C, $2E, $2B ; [you]'ll⎵sur
    db $1F, $1A, $1C, $1E, $3E, $8A, $16, $1A ; face![  ]Wa
    db $21, $59, $B1, $59, $B1, $3E ; h⎵[ha]⎵[ha]!
    db $7F ; end of message

    ; ==========================================================================
    ; Wade back this way when you
    ; have more Rupees…
    ; Wah ha ha!  I'll see you again!
    ; --------------------------------------------------------------------------
    ; $0E75C1
    Message_0145:
    db $16, $1A, $1D, $1E, $59, $96, $9C, $59 ; Wade⎵[ba][ck]⎵
    db $D9, $2C, $59, $DF, $32, $59, $E1, $A0 ; [thi]s⎵[wa]y⎵[wh][en ]
    db $E3 ; [you]
    db $75 ; line 2
    db $AD, $59, $26, $C8, $1E, $59, $11, $DC ; [have]⎵m[or]e⎵R[up]
    db $1E, $1E, $2C, $43 ; ees…
    db $76 ; line 3
    db $16, $1A, $21, $59, $B1, $59, $B1, $3E ; Wah⎵[ha]⎵[ha]!
    db $8A, $08, $51, $25, $25, $59, $D0, $1E ; [  ]I'll⎵[se]e
    db $59, $E3, $59, $1A, $20, $8F, $3E ; ⎵[you]⎵ag[ain]!
    db $7F ; end of message

    ; ==========================================================================
    ; Great!  Whenever you want to
    ; see my fishy face, you are
    ; welcome here.
    ; …
    ; Wah ha ha!  Good bye…!
    ; --------------------------------------------------------------------------
    ; $0E75F8
    Message_0146:
    db $06, $CE, $94, $3E, $8A, $16, $21, $A5 ; G[re][at]![  ]Wh[en]
    db $A7, $A1, $E3, $59, $DF, $27, $2D, $59 ; [ev][er ][you]⎵[wa]nt⎵
    db $DA ; [to]
    db $75 ; line 2
    db $D0, $1E, $59, $26, $32, $59, $1F, $B5 ; [se]e⎵my⎵f[is]
    db $21, $32, $59, $1F, $1A, $1C, $1E, $42 ; hy⎵face,
    db $59, $E3, $59, $1A, $CE ; ⎵[you]⎵a[re]
    db $76 ; line 3
    db $E0, $25, $9B, $1E, $59, $AF, $1E, $41 ; [we]l[com]e⎵[her]e.
    db $7E ; wait for key
    db $73 ; scroll text
    db $43 ; …
    db $73 ; scroll text
    db $16, $1A, $21, $59, $B1, $59, $B1, $3E ; Wah⎵[ha]⎵[ha]!
    db $8A, $06, $28, $28, $1D, $59, $1B, $32 ; [  ]Good⎵by
    db $1E, $43, $3E ; e…!
    db $7F ; end of message

    ; ==========================================================================
    ; Hi [LINK]!
    ; Elder?  Are you talking about
    ; the grandpa?  OK,  but don't
    ; tell any of the bad people
    ; about this.
    ; He's hiding in the palace past
    ; the castle.
    ; I will mark the spot on your
    ; map.  Here you are…
    ; --------------------------------------------------------------------------
    ; $0E7640
    Message_0147:
    db $07, $22, $59, $6A, $3E ; Hi⎵[LINK]!
    db $75 ; line 2
    db $04, $25, $1D, $A6, $3F, $8A, $00, $CD ; Eld[er]?[  ]A[re ]
    db $E3, $59, $2D, $1A, $25, $24, $B3, $1A ; [you]⎵talk[ing ]a
    db $98, $2E, $2D ; [bo]ut
    db $76 ; line 3
    db $D8, $59, $20, $2B, $90, $29, $1A, $3F ; [the]⎵gr[and]pa?
    db $8A, $0E, $0A, $42, $8A, $1B, $2E, $2D ; [  ]OK,[  ]but
    db $59, $9F, $27, $51, $2D ; ⎵[do]n't
    db $7E ; wait for key
    db $73 ; scroll text
    db $2D, $1E, $25, $25, $59, $93, $32, $59 ; tell⎵[an]y⎵
    db $C6, $59, $D8, $59, $96, $1D, $59, $29 ; [of]⎵[the]⎵[ba]d⎵p
    db $1E, $28, $CA ; eo[ple]
    db $73 ; scroll text
    db $1A, $98, $2E, $2D, $59, $D9, $2C, $41 ; a[bo]ut⎵[thi]s.
    db $73 ; scroll text
    db $07, $1E, $8B, $B0, $9E, $27, $20, $59 ; He['s ][hi][di]ng⎵
    db $B4, $59, $D8, $59, $29, $1A, $BA, $1C ; [in]⎵[the]⎵pa[la]c
    db $1E, $59, $29, $92 ; e⎵p[ast]
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $1C, $92, $25, $1E, $41 ; [the]⎵c[ast]le.
    db $73 ; scroll text
    db $08, $59, $E2, $25, $25, $59, $BD, $2B ; I⎵[wi]ll⎵[ma]r
    db $24, $59, $D8, $59, $2C, $29, $28, $2D ; k⎵[the]⎵spot
    db $59, $C7, $59, $E3, $2B ; ⎵[on]⎵[you]r
    db $73 ; scroll text
    db $BD, $29, $41, $8A, $E4, $1E, $59, $E3 ; [ma]p.[  ][Her]e⎵[you]
    db $59, $1A, $CE, $43 ; ⎵a[re]…
    db $79, $2D ; play sfx
    db $7F ; end of message

    ; ==========================================================================
    ; Did you meet the grandpa?  If
    ; all the bad people go away, he
    ; can come back to the village.
    ; --------------------------------------------------------------------------
    ; $0E76D1
    Message_0148:
    db $03, $22, $1D, $59, $E3, $59, $BE, $1E ; Did⎵[you]⎵[me]e
    db $2D, $59, $D8, $59, $20, $2B, $90, $29 ; t⎵[the]⎵gr[and]p
    db $1A, $3F, $8A, $08, $1F ; a?[  ]If
    db $75 ; line 2
    db $8E, $D8, $59, $96, $1D, $59, $29, $1E ; [all ][the]⎵[ba]d⎵pe
    db $28, $CA, $59, $AC, $59, $1A, $DF, $32 ; o[ple]⎵[go]⎵a[wa]y
    db $42, $59, $21, $1E ; ,⎵he
    db $76 ; line 3
    db $99, $9B, $1E, $59, $96, $9C, $59, $DA ; [can ][com]e⎵[ba][ck]⎵[to]
    db $59, $D8, $59, $2F, $22, $25, $BA, $20 ; ⎵[the]⎵vil[la]g
    db $1E, $41 ; e.
    db $7F ; end of message

    ; ==========================================================================
    ; You're new here, aren't you?
    ; Did you come here looking for
    ; the Power Of Gold?
    ; Well, you're too late.  It will
    ; obey only the first person who
    ; touches it.
    ; The man who last claimed the
    ; Power Of Gold wished for this
    ; world.  It reflects his heart.
    ; Yes, I came here because of
    ; greed for the Golden Power,
    ; and look what happened to me… 
    ; To restore the Golden Land, a
    ; person worthy of the Golden
    ; Power must defeat the man who
    ; created this place…
    ; Until that time, I am stuck in
    ; this bizarre shape.
    ; But what a mischievous thing
    ; to leave lying around…
    ; The Power Of Gold…
    ; Triforce…
    ; --------------------------------------------------------------------------
    ; $0E770F
    Message_0149:
    db $E8, $51, $CD, $27, $1E, $30, $59, $AF ; [You]'[re ]new⎵[her]
    db $1E, $42, $59, $1A, $CE, $C0, $E3, $3F ; e,⎵a[re][n't ][you]?
    db $75 ; line 2
    db $03, $22, $1D, $59, $E3, $59, $9B, $1E ; Did⎵[you]⎵[com]e
    db $59, $AF, $1E, $59, $BB, $28, $24, $B3 ; ⎵[her]e⎵[lo]ok[ing ]
    db $A8 ; [for]
    db $76 ; line 3
    db $D8, $59, $0F, $28, $E0, $2B, $59, $0E ; [the]⎵Po[we]r⎵O
    db $1F, $59, $06, $28, $25, $1D, $3F ; f⎵Gold?
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $1E, $25, $25, $42, $59, $E3, $51 ; Well,⎵[you]'
    db $CD, $DA, $28, $59, $BA, $2D, $1E, $41 ; [re ][to]o⎵[la]te.
    db $8A, $08, $2D, $59, $E2, $25, $25 ; [  ]It⎵[wi]ll
    db $73 ; scroll text
    db $28, $97, $32, $59, $C7, $B9, $D8, $59 ; o[be]y⎵[on][ly ][the]⎵
    db $1F, $22, $2B, $D3, $59, $C9, $D2, $27 ; fir[st]⎵[per][so]n
    db $59, $E1, $28 ; ⎵[wh]o
    db $73 ; scroll text
    db $DA, $2E, $9A, $2C, $59, $B6, $41 ; [to]u[che]s⎵[it].
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $BC, $59, $E1, $28, $59, $BA ; [The]⎵[man]⎵[wh]o⎵[la]
    db $D3, $59, $1C, $BA, $22, $BE, $1D, $59 ; [st]⎵c[la]i[me]d⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $0F, $28, $E0, $2B, $59, $0E, $1F, $59 ; Po[we]r⎵Of⎵
    db $06, $28, $25, $1D, $59, $E2, $D1, $A4 ; Gold⎵[wi][sh][ed ]
    db $A8, $59, $D9, $2C ; [for]⎵[thi]s
    db $73 ; scroll text
    db $30, $C8, $25, $1D, $41, $8A, $08, $2D ; w[or]ld.[  ]It
    db $59, $CE, $1F, $25, $1E, $1C, $2D, $2C ; ⎵[re]flects
    db $59, $B0, $2C, $59, $21, $A2, $2D, $41 ; ⎵[hi]s⎵h[ear]t.
    db $7E ; wait for key
    db $73 ; scroll text
    db $18, $1E, $2C, $42, $59, $08, $59, $1C ; Yes,⎵I⎵c
    db $1A, $BE, $59, $AF, $1E, $59, $97, $1C ; a[me]⎵[her]e⎵[be]c
    db $1A, $2E, $D0, $59, $C6 ; au[se]⎵[of]
    db $73 ; scroll text
    db $20, $CE, $A4, $A8, $59, $D8, $59, $06 ; g[re][ed ][for]⎵[the]⎵G
    db $28, $25, $1D, $A0, $0F, $28, $E0, $2B ; old[en ]Po[we]r
    db $42 ; ,
    db $73 ; scroll text
    db $8C, $BB, $28, $24, $59, $E1, $91, $B1 ; [and ][lo]ok⎵[wh][at ][ha]
    db $29, $29, $A5, $A4, $DA, $59, $BE, $43 ; pp[en][ed ][to]⎵[me]…
    db $59 ; ⎵
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $28, $59, $CE, $D3, $C8, $1E, $59 ; To⎵[re][st][or]e⎵
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $90, $42, $59, $1A ; [and],⎵a
    db $73 ; scroll text
    db $C9, $D2, $27, $59, $30, $C8, $2D, $21 ; [per][so]n⎵w[or]th
    db $32, $59, $C6, $59, $D8, $59, $06, $28 ; y⎵[of]⎵[the]⎵Go
    db $25, $1D, $A5 ; ld[en]
    db $73 ; scroll text
    db $0F, $28, $E0, $2B, $59, $BF, $D3, $59 ; Po[we]r⎵[mu][st]⎵
    db $1D, $1E, $1F, $1E, $91, $D8, $59, $BC ; defe[at ][the]⎵[man]
    db $59, $E1, $28 ; ⎵[wh]o
    db $7E ; wait for key
    db $73 ; scroll text
    db $1C, $CE, $94, $A4, $D9, $2C, $59, $29 ; c[re][at][ed ][thi]s⎵p
    db $BA, $1C, $1E, $43 ; [la]ce…
    db $73 ; scroll text
    db $14, $27, $2D, $22, $25, $59, $D7, $2D ; Until⎵[tha]t
    db $59, $2D, $22, $BE, $42, $59, $08, $59 ; ⎵ti[me],⎵I⎵
    db $1A, $26, $59, $D3, $2E, $9C, $59, $B4 ; am⎵[st]u[ck]⎵[in]
    db $73 ; scroll text
    db $D9, $2C, $59, $1B, $22, $33, $1A, $2B ; [thi]s⎵bizar
    db $CD, $D1, $1A, $29, $1E, $41 ; [re ][sh]ape.
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $E1, $91, $1A, $59 ; But⎵[wh][at ]a⎵
    db $26, $B5, $1C, $B0, $A7, $28, $2E, $2C ; m[is]c[hi][ev]ous
    db $59, $D5, $20 ; ⎵[thin]g
    db $73 ; scroll text
    db $DA, $59, $25, $1E, $1A, $2F, $1E, $59 ; [to]⎵leave⎵
    db $25, $32, $B3, $1A, $2B, $C4, $43 ; ly[ing ]ar[ound]…
    db $73 ; scroll text
    db $E6, $59, $0F, $28, $E0, $2B, $59, $0E ; [The]⎵Po[we]r⎵O
    db $1F, $59, $06, $28, $25, $1D, $43 ; f⎵Gold…
    db $7E ; wait for key
    db $73 ; scroll text
    db $13, $2B, $22, $A8, $1C, $1E, $43 ; Tri[for]ce…
    db $7F ; end of message

    ; ==========================================================================
    ;      -Mysterious Pond-
    ; Won't you throw something in?
    ; 
    ; What will you do?
    ;     > Throw an item
    ;        Don't try it
    ; --------------------------------------------------------------------------
    ; $0E78A5
    Message_014A:
    db $88, $59, $40, $0C, $32, $D3, $A6, $22 ; [    ]⎵-My[st][er]i
    db $28, $2E, $2C, $59, $0F, $C7, $1D, $40 ; ous⎵P[on]d-
    db $75 ; line 2
    db $16, $C7, $51, $2D, $59, $E3, $59, $2D ; W[on]'t⎵[you]⎵t
    db $21, $2B, $28, $30, $59, $CF, $D5, $20 ; hrow⎵[some][thin]g
    db $59, $B4, $3F ; ⎵[in]?
    db $76 ; line 3
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $59, $13, $21, $2B, $28, $30 ; [    ]>⎵Throw
    db $59, $93, $59, $B6, $1E, $26 ; ⎵[an]⎵[it]em
    db $73 ; scroll text
    db $88, $89, $03, $C7, $51, $2D, $59, $DB ; [    ][   ]D[on]'t⎵[tr]
    db $32, $59, $B6 ; y⎵[it]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Don't do it!
    ; --------------------------------------------------------------------------
    ; $0E78F5
    Message_014B:
    db $03, $C7, $51, $2D, $59, $9F, $59, $B6 ; D[on]'t⎵[do]⎵[it]
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; Don't do it!
    ; --------------------------------------------------------------------------
    ; $0E78FF
    Message_014C:
    db $03, $C7, $51, $2D, $59, $9F, $59, $B6 ; D[on]'t⎵[do]⎵[it]
    db $3E ; !
    db $7F ; end of message

    ; ==========================================================================
    ; I will give this back to you
    ; then.  Don't drop it again.
    ; --------------------------------------------------------------------------
    ; $0E7909
    Message_014D:
    db $08, $59, $E2, $25, $25, $59, $AA, $D9 ; I⎵[wi]ll⎵[give ][thi]
    db $2C, $59, $96, $9C, $59, $DA, $59, $E3 ; s⎵[ba][ck]⎵[to]⎵[you]
    db $75 ; line 2
    db $D8, $27, $41, $8A, $03, $C7, $51, $2D ; [the]n.[  ]D[on]'t
    db $59, $1D, $2B, $28, $29, $59, $B6, $59 ; ⎵drop⎵[it]⎵
    db $1A, $20, $8F, $41 ; ag[ain].
    db $7F ; end of message

    ; ==========================================================================
    ; How many Rupees will you toss?
    ;     > [#1][#0] Rupees
    ;        [#3][#2] Rupees
    ; --------------------------------------------------------------------------
    ; $0E792F
    Message_014E:
    db $07, $28, $30, $59, $BC, $32, $59, $11 ; How⎵[man]y⎵R
    db $DC, $1E, $1E, $2C, $59, $E2, $25, $25 ; [up]ees⎵[wi]ll
    db $59, $E3, $59, $DA, $2C, $2C, $3F ; ⎵[you]⎵[to]ss?
    db $75 ; line 2
    db $88, $44, $59, $6C, $01, $6C, $00, $59 ; [    ]>⎵[#1][#0]⎵
    db $11, $DC, $1E, $1E, $2C ; R[up]ees
    db $76 ; line 3
    db $88, $89, $6C, $03, $6C, $02, $59, $11 ; [    ][   ][#3][#2]⎵R
    db $DC, $1E, $1E, $2C ; [up]ees
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; You are an honest person.
    ; I like you.
    ; I will give you something
    ; important…
    ; These are the Silver Arrows.
    ; To give Ganon his last
    ; moment, you definitely need
    ; them!  I know I don't quite have
    ; the figure of a faerie.
    ; Ganon's cruel power
    ; is to blame!
    ; You must defeat Ganon!
    ; --------------------------------------------------------------------------
    ; $0E7963
    Message_014F:
    db $E8, $59, $8D, $93, $59, $21, $C7, $1E ; [You]⎵[are ][an]⎵h[on]e
    db $D3, $59, $C9, $D2, $27, $41 ; [st]⎵[per][so]n.
    db $75 ; line 2
    db $08, $59, $25, $22, $24, $1E, $59, $E3 ; I⎵like⎵[you]
    db $41 ; .
    db $76 ; line 3
    db $08, $59, $E2, $25, $25, $59, $AA, $E3 ; I⎵[wi]ll⎵[give ][you]
    db $59, $CF, $D5, $20 ; ⎵[some][thin]g
    db $7E ; wait for key
    db $73 ; scroll text
    db $22, $26, $29, $C8, $2D, $93, $2D, $43 ; imp[or]t[an]t…
    db $73 ; scroll text
    db $E6, $D0, $59, $8D, $D8, $59, $12, $22 ; [The][se]⎵[are ][the]⎵Si
    db $25, $DD, $59, $00, $2B, $2B, $28, $30 ; l[ver]⎵Arrow
    db $2C, $41 ; s.
    db $73 ; scroll text
    db $13, $28, $59, $AA, $06, $93, $C7, $59 ; To⎵[give ]G[an][on]⎵
    db $B0, $2C, $59, $BA, $D3 ; [hi]s⎵[la][st]
    db $7E ; wait for key
    db $73 ; scroll text
    db $26, $28, $BE, $27, $2D, $42, $59, $E3 ; mo[me]nt,⎵[you]
    db $59, $1D, $1E, $1F, $B4, $B6, $1E, $B9 ; ⎵def[in][it]e[ly ]
    db $27, $1E, $1E, $1D ; need
    db $73 ; scroll text
    db $D8, $26, $3E, $8A, $08, $59, $B8, $59 ; [the]m![  ]I⎵[know]⎵
    db $08, $59, $9F, $C0, $2A, $2E, $B6, $1E ; I⎵[do][n't ]qu[it]e
    db $59, $AD ; ⎵[have]
    db $73 ; scroll text
    db $D8, $59, $1F, $22, $20, $2E, $CD, $C6 ; [the]⎵figu[re ][of]
    db $59, $1A, $59, $1F, $1A, $A6, $22, $1E ; ⎵a⎵fa[er]ie
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $06, $93, $C7, $8B, $1C, $2B, $2E, $1E ; G[an][on]['s ]crue
    db $25, $59, $CB, $A6 ; l⎵[pow][er]
    db $73 ; scroll text
    db $B5, $59, $DA, $59, $1B, $BA, $BE, $3E ; [is]⎵[to]⎵b[la][me]!
    db $73 ; scroll text
    db $E8, $59, $BF, $D3, $59, $1D, $1E, $1F ; [You]⎵[mu][st]⎵def
    db $1E, $91, $06, $93, $C7, $3E ; e[at ]G[an][on]!
    db $7F ; end of message

    ; ==========================================================================
    ;    Great Luck.
    ; --------------------------------------------------------------------------
    ; $0E7A15
    Message_0150:
    db $75 ; line 2
    db $89, $06, $CE, $91, $0B, $2E, $9C, $41 ; [   ]G[re][at ]Lu[ck].
    db $7F ; end of message

    ; ==========================================================================
    ;    Good Luck.
    ; --------------------------------------------------------------------------
    ; $0E7A1F
    Message_0151:
    db $75 ; line 2
    db $89, $06, $28, $28, $1D, $59, $0B, $2E ; [   ]Good⎵Lu
    db $9C, $41 ; [ck].
    db $7F ; end of message

    ; ==========================================================================
    ;    A Little Luck.
    ; --------------------------------------------------------------------------
    ; $0E7A2B
    Message_0152:
    db $75 ; line 2
    db $89, $00, $59, $0B, $B6, $2D, $25, $1E ; [   ]A⎵L[it]tle
    db $59, $0B, $2E, $9C, $41 ; ⎵Lu[ck].
    db $7F ; end of message

    ; ==========================================================================
    ;    Big Trouble.
    ; --------------------------------------------------------------------------
    ; $0E7A3A
    Message_0153:
    db $75 ; line 2
    db $89, $01, $22, $20, $59, $13, $2B, $28 ; [   ]Big⎵Tro
    db $2E, $95, $41 ; u[ble].
    db $7F ; end of message

    ; ==========================================================================
    ; For your reference, today you
    ; will have
    ; --------------------------------------------------------------------------
    ; $0E7A47
    Message_0154:
    db $05, $C8, $59, $E3, $2B, $59, $CE, $1F ; F[or]⎵[you]r⎵[re]f
    db $A6, $A5, $1C, $1E, $42, $59, $DA, $1D ; [er][en]ce,⎵[to]d
    db $1A, $32, $59, $E3 ; ay⎵[you]
    db $75 ; line 2
    db $E2, $25, $25, $59, $AD ; [wi]ll⎵[have]
    db $7F ; end of message

    ; ==========================================================================
    ; You found a piece of Heart!
    ;                  ♥♥
    ; --------------------------------------------------------------------------
    ; $0E7A62
    Message_0155:
    db $E8, $59, $1F, $C4, $59, $1A, $59, $29 ; [You]⎵f[ound]⎵a⎵p
    db $22, $1E, $1C, $1E, $59, $C6, $59, $07 ; iece⎵[of]⎵H
    db $A2, $2D, $3E ; [ear]t!
    db $75 ; line 2
    db $88, $88, $88, $88, $59, $52, $53 ; [    ][    ][    ][    ]⎵♥♥
    db $7F ; end of message

    ; ==========================================================================
    ; You found a piece of Heart!
    ;                  ♥♥
    ; --------------------------------------------------------------------------
    ; $0E7A7E
    Message_0156:
    db $E8, $59, $1F, $C4, $59, $1A, $59, $29 ; [You]⎵f[ound]⎵a⎵p
    db $22, $1E, $1C, $1E, $59, $C6, $59, $07 ; iece⎵[of]⎵H
    db $A2, $2D, $3E ; [ear]t!
    db $75 ; line 2
    db $88, $88, $88, $88, $59, $54, $53 ; [    ][    ][    ][    ]⎵♥♥
    db $7F ; end of message

    ; ==========================================================================
    ; You found a piece of Heart!
    ;                  ♥♥
    ; --------------------------------------------------------------------------
    ; $0E7A9A
    Message_0157:
    db $E8, $59, $1F, $C4, $59, $1A, $59, $29 ; [You]⎵f[ound]⎵a⎵p
    db $22, $1E, $1C, $1E, $59, $C6, $59, $07 ; iece⎵[of]⎵H
    db $A2, $2D, $3E ; [ear]t!
    db $75 ; line 2
    db $88, $88, $88, $88, $59, $55, $56 ; [    ][    ][    ][    ]⎵♥♥
    db $7F ; end of message

    ; ==========================================================================
    ; You found a piece of Heart!
    ;                  ♥♥
    ; Your Heart level increased!
    ; --------------------------------------------------------------------------
    ; $0E7AB6
    Message_0158:
    db $E8, $59, $1F, $C4, $59, $1A, $59, $29 ; [You]⎵f[ound]⎵a⎵p
    db $22, $1E, $1C, $1E, $59, $C6, $59, $07 ; iece⎵[of]⎵H
    db $A2, $2D, $3E ; [ear]t!
    db $75 ; line 2
    db $88, $88, $88, $88, $59, $57, $58 ; [    ][    ][    ][    ]⎵♥♥
    db $76 ; line 3
    db $E8, $2B, $59, $07, $A2, $2D, $59, $25 ; [You]r⎵H[ear]t⎵l
    db $A7, $1E, $25, $59, $B4, $1C, $CE, $1A ; [ev]el⎵[in]c[re]a
    db $D0, $1D, $3E ; [se]d!
    db $7F ; end of message

    ; ==========================================================================
    ; You found a Heart Container!
    ;                  ♥♥
    ; Your Heart level increased!
    ; --------------------------------------------------------------------------
    ; $0E7AE6
    Message_0159:
    db $E8, $59, $1F, $C4, $59, $1A, $59, $07 ; [You]⎵f[ound]⎵a⎵H
    db $A2, $2D, $59, $02, $C7, $2D, $8F, $A6 ; [ear]t⎵C[on]t[ain][er]
    db $3E ; !
    db $75 ; line 2
    db $88, $88, $88, $88, $59, $57, $58 ; [    ][    ][    ][    ]⎵♥♥
    db $76 ; line 3
    db $E8, $2B, $59, $07, $A2, $2D, $59, $25 ; [You]r⎵H[ear]t⎵l
    db $A7, $1E, $25, $59, $B4, $1C, $CE, $1A ; [ev]el⎵[in]c[re]a
    db $D0, $1D, $3E ; [se]d!
    db $7F ; end of message

    ; ==========================================================================
    ; I will sooth your wounds and
    ; comfort your weariness…
    ; Close your eyes and relax…
    ; --------------------------------------------------------------------------
    ; $0E7B14
    Message_015A:
    db $08, $59, $E2, $25, $25, $59, $D2, $28 ; I⎵[wi]ll⎵[so]o
    db $2D, $21, $59, $E3, $2B, $59, $30, $C4 ; th⎵[you]r⎵w[ound]
    db $2C, $59, $90 ; s⎵[and]
    db $75 ; line 2
    db $9B, $A8, $2D, $59, $E3, $2B, $59, $E0 ; [com][for]t⎵[you]r⎵[we]
    db $1A, $2B, $B4, $1E, $2C, $2C, $43 ; ar[in]ess…
    db $76 ; line 3
    db $02, $BB, $D0, $59, $E3, $2B, $59, $1E ; C[lo][se]⎵[you]r⎵e
    db $32, $1E, $2C, $59, $8C, $CE, $BA, $31 ; yes⎵[and ][re][la]x
    db $43 ; …
    db $7F ; end of message

    ; ==========================================================================
    ; Oh?  Who are you, Mr. Bunny?
    ; This world is like the real
    ; world, but evil has twisted it.
    ; The Golden Power is what
    ; changed your shape to reflect
    ; what is in your heart and mind.
    ; I am always changing my mind,
    ; so I turned into a ball…
    ; But if you have a ball called
    ; the Moon Pearl, you can keep
    ; your original shape here.
    ; --------------------------------------------------------------------------
    ; $0E7B4A
    Message_015B:
    db $0E, $21, $3F, $8A, $16, $21, $28, $59 ; Oh?[  ]Who⎵
    db $8D, $E3, $42, $59, $0C, $2B, $41, $59 ; [are ][you],⎵Mr.⎵
    db $01, $2E, $27, $27, $32, $3F ; Bunny?
    db $75 ; line 2
    db $E7, $2C, $59, $30, $C8, $25, $1D, $59 ; [Thi]s⎵w[or]ld⎵
    db $B5, $59, $25, $22, $24, $1E, $59, $D8 ; [is]⎵like⎵[the]
    db $59, $CE, $1A, $25 ; ⎵[re]al
    db $76 ; line 3
    db $30, $C8, $25, $1D, $42, $59, $1B, $2E ; w[or]ld,⎵bu
    db $2D, $59, $A7, $22, $25, $59, $AE, $59 ; t⎵[ev]il⎵[has]⎵
    db $2D, $E2, $D3, $A4, $B6, $41 ; t[wi][st][ed ][it].
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $06, $28, $25, $1D, $A0, $0F ; [The]⎵Gold[en ]P
    db $28, $E0, $2B, $59, $B5, $59, $E1, $94 ; o[we]r⎵[is]⎵[wh][at]
    db $73 ; scroll text
    db $1C, $B1, $27, $20, $A4, $E3, $2B, $59 ; c[ha]ng[ed ][you]r⎵
    db $D1, $1A, $29, $1E, $59, $DA, $59, $CE ; [sh]ape⎵[to]⎵[re]
    db $1F, $25, $1E, $1C, $2D ; flect
    db $73 ; scroll text
    db $E1, $91, $B5, $59, $B4, $59, $E3, $2B ; [wh][at ][is]⎵[in]⎵[you]r
    db $59, $21, $A2, $2D, $59, $8C, $26, $B4 ; ⎵h[ear]t⎵[and ]m[in]
    db $1D, $41 ; d.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $1A, $26, $59, $1A, $25, $DF ; I⎵am⎵al[wa]
    db $32, $2C, $59, $1C, $B1, $27, $20, $B3 ; ys⎵c[ha]ng[ing ]
    db $26, $32, $59, $26, $B4, $1D, $42 ; my⎵m[in]d,
    db $73 ; scroll text
    db $D2, $59, $08, $59, $2D, $2E, $2B, $27 ; [so]⎵I⎵turn
    db $A4, $B4, $DA, $59, $1A, $59, $96, $25 ; [ed ][in][to]⎵a⎵[ba]l
    db $25, $43 ; l…
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $22, $1F, $59, $E3 ; But⎵if⎵[you]
    db $59, $AD, $59, $1A, $59, $96, $25, $25 ; ⎵[have]⎵a⎵[ba]ll
    db $59, $1C, $1A, $25, $25, $1E, $1D ; ⎵called
    db $7E ; wait for key
    db $73 ; scroll text
    db $D8, $59, $0C, $28, $C7, $59, $0F, $A2 ; [the]⎵Mo[on]⎵P[ear]
    db $25, $42, $59, $E3, $59, $99, $24, $1E ; l,⎵[you]⎵[can ]ke
    db $1E, $29 ; ep
    db $73 ; scroll text
    db $E3, $2B, $59, $C8, $22, $20, $B4, $1A ; [you]r⎵[or]ig[in]a
    db $25, $59, $D1, $1A, $29, $1E, $59, $AF ; l⎵[sh]ape⎵[her]
    db $1E, $41 ; e.
    db $7F ; end of message

    ; ==========================================================================
    ; You didn't change your shape?
    ; You aren't just a normal guy,
    ; are you?
    ; --------------------------------------------------------------------------
    ; $0E7C33
    Message_015C:
    db $E8, $59, $9E, $1D, $C0, $1C, $B1, $27 ; [You]⎵[di]d[n't ]c[ha]n
    db $20, $1E, $59, $E3, $2B, $59, $D1, $1A ; ge⎵[you]r⎵[sh]a
    db $29, $1E, $3F ; pe?
    db $75 ; line 2
    db $E8, $59, $1A, $CE, $C0, $B7, $59, $1A ; [You]⎵a[re][n't ][just]⎵a
    db $59, $27, $C8, $BD, $25, $59, $20, $2E ; ⎵n[or][ma]l⎵gu
    db $32, $42 ; y,
    db $76 ; line 3
    db $8D, $E3, $3F ; [are ][you]?
    db $7F ; end of message

    ; ==========================================================================
    ; What do you want?!
    ; Do you have something to say
    ; to me, silly rabbit?!
    ; I came here to get the Power
    ; Of Gold but now I'm a freak and
    ; I can't go back to the real
    ; world!  If I only had the Moon
    ; Pearl from the Tower Of Hera, I
    ; could go back to my original
    ; shape!  I've got good reason
    ; to be stressed out!
    ; So back off!  Shoo shoo!
    ; --------------------------------------------------------------------------
    ; $0E7C5E
    Message_015D:
    db $16, $B1, $2D, $59, $9F, $59, $E3, $59 ; W[ha]t⎵[do]⎵[you]⎵
    db $DF, $27, $2D, $3F, $3E ; [wa]nt?!
    db $75 ; line 2
    db $03, $28, $59, $E3, $59, $AD, $59, $CF ; Do⎵[you]⎵[have]⎵[some]
    db $D5, $20, $59, $DA, $59, $2C, $1A, $32 ; [thin]g⎵[to]⎵say
    db $76 ; line 3
    db $DA, $59, $BE, $42, $59, $2C, $22, $25 ; [to]⎵[me],⎵sil
    db $B9, $2B, $1A, $1B, $1B, $B6, $3F, $3E ; [ly ]rabb[it]?!
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $59, $1C, $1A, $BE, $59, $AF, $1E ; I⎵ca[me]⎵[her]e
    db $59, $DA, $59, $AB, $59, $D8, $59, $0F ; ⎵[to]⎵[get]⎵[the]⎵P
    db $28, $E0, $2B ; o[we]r
    db $73 ; scroll text
    db $0E, $1F, $59, $06, $28, $25, $1D, $59 ; Of⎵Gold⎵
    db $1B, $2E, $2D, $59, $27, $28, $30, $59 ; but⎵now⎵
    db $08, $51, $26, $59, $1A, $59, $1F, $CE ; I'm⎵a⎵f[re]
    db $1A, $24, $59, $90 ; ak⎵[and]
    db $73 ; scroll text
    db $08, $59, $1C, $93, $51, $2D, $59, $AC ; I⎵c[an]'t⎵[go]
    db $59, $96, $9C, $59, $DA, $59, $D8, $59 ; ⎵[ba][ck]⎵[to]⎵[the]⎵
    db $CE, $1A, $25 ; [re]al
    db $7E ; wait for key
    db $73 ; scroll text
    db $30, $C8, $25, $1D, $3E, $8A, $08, $1F ; w[or]ld![  ]If
    db $59, $08, $59, $C7, $B9, $B1, $1D, $59 ; ⎵I⎵[on][ly ][ha]d⎵
    db $D8, $59, $0C, $28, $C7 ; [the]⎵Mo[on]
    db $73 ; scroll text
    db $0F, $A2, $25, $59, $A9, $26, $59, $D8 ; P[ear]l⎵[fro]m⎵[the]
    db $59, $13, $28, $E0, $2B, $59, $0E, $1F ; ⎵To[we]r⎵Of
    db $59, $E4, $1A, $42, $59, $08 ; ⎵[Her]a,⎵I
    db $73 ; scroll text
    db $1C, $28, $2E, $25, $1D, $59, $AC, $59 ; could⎵[go]⎵
    db $96, $9C, $59, $DA, $59, $26, $32, $59 ; [ba][ck]⎵[to]⎵my⎵
    db $C8, $22, $20, $B4, $1A, $25 ; [or]ig[in]al
    db $7E ; wait for key
    db $73 ; scroll text
    db $D1, $1A, $29, $1E, $3E, $8A, $08, $51 ; [sh]ape![  ]I'
    db $2F, $1E, $59, $AC, $2D, $59, $AC, $28 ; ve⎵[go]t⎵[go]o
    db $1D, $59, $CE, $1A, $D2, $27 ; d⎵[re]a[so]n
    db $73 ; scroll text
    db $DA, $59, $97, $59, $D3, $CE, $2C, $D0 ; [to]⎵[be]⎵[st][re]s[se]
    db $1D, $59, $28, $2E, $2D, $3E ; d⎵out!
    db $73 ; scroll text
    db $12, $28, $59, $96, $9C, $59, $C6, $1F ; So⎵[ba][ck]⎵[of]f
    db $3E, $8A, $12, $21, $28, $28, $59, $D1 ; ![  ]Shoo⎵[sh]
    db $28, $28, $3E ; oo!
    db $7F ; end of message

    ; ==========================================================================
    ; WOW!  Your shape didn't change!
    ; You got the Moon Pearl, huh?
    ; --------------------------------------------------------------------------
    ; $0E7D54
    Message_015E:
    db $16, $0E, $16, $3E, $8A, $E8, $2B, $59 ; WOW![  ][You]r⎵
    db $D1, $1A, $29, $1E, $59, $9E, $1D, $C0 ; [sh]ape⎵[di]d[n't ]
    db $1C, $B1, $27, $20, $1E, $3E ; c[ha]nge!
    db $75 ; line 2
    db $E8, $59, $AC, $2D, $59, $D8, $59, $0C ; [You]⎵[go]t⎵[the]⎵M
    db $28, $C7, $59, $0F, $A2, $25, $42, $59 ; o[on]⎵P[ear]l,⎵
    db $21, $2E, $21, $3F ; huh?
    db $7F ; end of message

    ; ==========================================================================
    ; In such a dangerous world you
    ; may need many things.  Select
    ; something that you like…
    ; --------------------------------------------------------------------------
    ; $0E7D80
    Message_015F:
    db $08, $27, $59, $2C, $2E, $1C, $21, $59 ; In⎵such⎵
    db $1A, $59, $1D, $93, $20, $A6, $28, $2E ; a⎵d[an]g[er]ou
    db $2C, $59, $30, $C8, $25, $1D, $59, $E3 ; s⎵w[or]ld⎵[you]
    db $75 ; line 2
    db $BD, $32, $59, $27, $1E, $A4, $BC, $32 ; [ma]y⎵ne[ed ][man]y
    db $59, $D5, $20, $2C, $41, $8A, $12, $1E ; ⎵[thin]gs.[  ]Se
    db $25, $1E, $1C, $2D ; lect
    db $76 ; line 3
    db $CF, $D5, $20, $59, $D7, $2D, $59, $E3 ; [some][thin]g⎵[tha]t⎵[you]
    db $59, $25, $22, $24, $1E, $43 ; ⎵like…
    db $7F ; end of message

    ; ==========================================================================
    ; Hi, may I help you?  You can
    ; open two chests for 30 Rupees.
    ; Why don't you play?
    ; What will you do?
    ;     > Play here
    ;        Maybe next time
    ; --------------------------------------------------------------------------
    ; $0E7DBD
    Message_0160:
    db $07, $22, $42, $59, $BD, $32, $59, $08 ; Hi,⎵[ma]y⎵I
    db $59, $21, $1E, $25, $29, $59, $E3, $3F ; ⎵help⎵[you]?
    db $8A, $E8, $59, $1C, $93 ; [  ][You]⎵c[an]
    db $75 ; line 2
    db $C3, $59, $2D, $30, $28, $59, $9A, $D3 ; [open]⎵two⎵[che][st]
    db $2C, $59, $A8, $59, $37, $34, $59, $11 ; s⎵[for]⎵30⎵R
    db $DC, $1E, $1E, $2C, $41 ; [up]ees.
    db $76 ; line 3
    db $16, $21, $32, $59, $9F, $C0, $E3, $59 ; Why⎵[do][n't ][you]⎵
    db $29, $BA, $32, $3F ; p[la]y?
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $59, $0F, $BA, $32, $59, $AF ; [    ]>⎵P[la]y⎵[her]
    db $1E ; e
    db $73 ; scroll text
    db $88, $89, $0C, $1A, $32, $97, $59, $27 ; [    ][   ]May[be]⎵n
    db $1E, $31, $2D, $59, $2D, $22, $BE ; ext⎵ti[me]
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==========================================================================
    ; Well, come back and play some
    ; time.  I'll be waiting for you.
    ; Until then, good bye!
    ; --------------------------------------------------------------------------
    ; $0E7E1F
    Message_0161:
    db $16, $1E, $25, $25, $42, $59, $9B, $1E ; Well,⎵[com]e
    db $59, $96, $9C, $59, $8C, $29, $BA, $32 ; ⎵[ba][ck]⎵[and ]p[la]y
    db $59, $CF ; ⎵[some]
    db $75 ; line 2
    db $2D, $22, $BE, $41, $8A, $08, $51, $25 ; ti[me].[  ]I'l
    db $25, $59, $97, $59, $DF, $B6, $B3, $A8 ; l⎵[be]⎵[wa][it][ing ][for]
    db $59, $E3, $41 ; ⎵[you].
    db $76 ; line 3
    db $14, $27, $2D, $22, $25, $59, $D8, $27 ; Until⎵[the]n
    db $42, $59, $AC, $28, $1D, $59, $1B, $32 ; ,⎵[go]od⎵by
    db $1E, $3E ; e!
    db $7F ; end of message

    ; ==========================================================================
    ; Hey kid!
    ; You can open a chest after
    ; paying Rupees!
    ; --------------------------------------------------------------------------
    ; $0E7E59
    Message_0162:
    db $07, $1E, $32, $59, $24, $22, $1D, $3E ; Hey⎵kid!
    db $75 ; line 2
    db $E8, $59, $99, $C3, $59, $1A, $59, $9A ; [You]⎵[can ][open]⎵a⎵[che]
    db $D3, $59, $1A, $1F, $D6 ; [st]⎵af[ter]
    db $76 ; line 3
    db $29, $1A, $32, $B3, $11, $DC, $1E, $1E ; pay[ing ]R[up]ee
    db $2C, $3E ; s!
    db $7F ; end of message

    ; ==========================================================================
    ; You can't open any more
    ; chests.  The game is over.
    ; --------------------------------------------------------------------------
    ; $0E7E7B
    Message_0163:
    db $E8, $59, $1C, $93, $51, $2D, $59, $C3 ; [You]⎵c[an]'t⎵[open]
    db $59, $93, $32, $59, $26, $C8, $1E ; ⎵[an]y⎵m[or]e
    db $75 ; line 2
    db $9A, $D3, $2C, $41, $8A, $E6, $59, $20 ; [che][st]s.[  ][The]⎵g
    db $1A, $BE, $59, $B5, $59, $28, $DD, $41 ; a[me]⎵[is]⎵o[ver].
    db $7F ; end of message

    ; ==========================================================================
    ; All right, kid.
    ; Choose well!  Good luck!
    ; --------------------------------------------------------------------------
    ; $0E7E9C
    Message_0164:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $42, $59, $24, $22, $1D, $41 ; t,⎵kid.
    db $75 ; line 2
    db $02, $21, $28, $28, $D0, $59, $E0, $25 ; Choo[se]⎵[we]l
    db $25, $3E, $8A, $06, $28, $28, $1D, $59 ; l![  ]Good⎵
    db $25, $2E, $9C, $3E ; lu[ck]!
    db $7F ; end of message

    ; ==========================================================================
    ; May I help you?  Select the
    ; thing you like (Press the Ⓐ
    ; Button).  Prices as marked!
    ; --------------------------------------------------------------------------
    ; $0E7EC1
    Message_0165:
    db $0C, $1A, $32, $59, $08, $59, $21, $1E ; May⎵I⎵he
    db $25, $29, $59, $E3, $3F, $8A, $12, $1E ; lp⎵[you]?[  ]Se
    db $25, $1E, $1C, $2D, $59, $D8 ; lect⎵[the]
    db $75 ; line 2
    db $D5, $20, $59, $E3, $59, $25, $22, $24 ; [thin]g⎵[you]⎵lik
    db $1E, $59, $45, $0F, $CE, $2C, $2C, $59 ; e⎵(P[re]ss⎵
    db $D8, $59, $5B ; [the]⎵Ⓐ
    db $76 ; line 3
    db $01, $2E, $2D, $DA, $27, $46, $41, $8A ; But[to]n).[  ]
    db $0F, $2B, $22, $1C, $1E, $2C, $59, $1A ; Prices⎵a
    db $2C, $59, $BD, $2B, $24, $1E, $1D, $3E ; s⎵[ma]rked!
    db $7F ; end of message

    ; ==========================================================================
    ; You don't need that item…
    ; Why not select something else?
    ; --------------------------------------------------------------------------
    ; $0E7F05
    Message_0166:
    db $E8, $59, $9F, $C0, $27, $1E, $A4, $D7 ; [You]⎵[do][n't ]ne[ed ][tha]
    db $2D, $59, $B6, $1E, $26, $43 ; t⎵[it]em…
    db $75 ; line 2
    db $16, $21, $32, $59, $C2, $59, $D0, $25 ; Why⎵[not]⎵[se]l
    db $1E, $1C, $2D, $59, $CF, $D5, $20, $59 ; ect⎵[some][thin]g⎵
    db $1E, $25, $D0, $3F ; el[se]?
    db $7F ; end of message

    ; --------------------------------------------------------------------------

    db $80 ; change banks

}
    
; ==============================================================================

; ZScream uses this space as an extention of the dialog data block above.
; $0E7F2A-$0E7FFF NULL
NULL_1CFF2A:
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
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $1D8000
