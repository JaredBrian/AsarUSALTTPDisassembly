
; ==============================================================================

; $06BA80-$06BA83 LONG JUMP LOCATION
OAM_AllocateFromRegionA:
{
    LDY.b #$00
    
    BRA OAM_Allocate
}

; $06BA84-$06BA87 LONG JUMP LOCATION
OAM_AllocateFromRegionB:
{
    LDY.b #$02
    
    BRA OAM_Allocate
}

; $06BA88-$06BA8B LONG JUMP LOCATION
OAM_AllocateFromRegionC:
{
    LDY.b #$04
    
    BRA OAM_Allocate
}

; $06BA8C-$06BA8F LONG JUMP LOCATION
OAM_AllocateFromRegionD:
{
    LDY.b #$06
    
    BRA OAM_Allocate
}

; $06BA90-$06BA93 LONG JUMP LOCATION
OAM_AllocateFromRegionE:
{  
    LDY.b #$08
    
    BRA OAM_Allocate
}

; Note: Seems to be for sorted, bg1 sprites
; $06BA94-$06BA95 LONG JUMP LOCATION
OAM_AllocateFromRegionF:
{
    LDY.b #$0A

    ; Bleeds into the next function.
}

; $06BA96-$06BA9D LONG JUMP LOCATION
OAM_Allocate:
{
    PHB : PHK : PLB
    
    JSR.w OAM_GetBufferPosition
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BA9E-$06BB09 DATA TABLE
Pool_OAM_GetBufferPosition:
{
    ; Upper limits for each OAM region
    .limits
    dw $0171 ; 0x0030 - 0x016F? (For now calling this region A)
    dw $0201 ; 0x01D0 - 0x01FF? (For now calling this region B)
    dw $0031 ; 0x0000 - 0x002F? (For now calling this region C)
    dw $00C1 ; 0x0030 - 0x00BF? (For now calling this region D)
    dw $0141 ; 0x0120 - 0x013F? (For now calling this region E)
    dw $01D1 ; 0x0140 - 0x01CF? (For now calling this region F)
    
    ; fall back points for each OAM region
    ; (in case of overflow)
    ; formula for accessing this table: ($0C * 8 + $0E)
    .fallback_points
    
    dw $0030 ; $0C = 0, $0E = 0
    dw $0050
    dw $0080
    dw $00B0
    dw $00E0
    dw $0110
    dw $0140
    dw $0170 ; $0C = 0, $0E = 7
    
    dw $01D0 ; $0C = 2, $0E = 0
    dw $01D4
    dw $01DC
    dw $01E0
    dw $01E4
    dw $01EC
    dw $01F0
    dw $01F8
    
    dw $0000 ; $0C = 4, $0E = 0
    dw $0004
    dw $0008
    dw $000C
    dw $0010
    dw $0014
    dw $0018
    dw $001C ; $0C = 4, $0E = 7
    
    dw $0030 ; $0C = 6, $0E = 0
    dw $0038
    dw $0050
    dw $0068
    dw $0080
    dw $0098
    dw $00B0
    dw $00C8 ; $0C = 6, $0E = 7
    
    dw $0120 ; $0C = 8, $0E = 0
    dw $0124
    dw $0128
    dw $012C
    dw $0130
    dw $0134
    dw $0138
    dw $013C ; $0C = 8, $0E = 7
    
    dw $0140 ; $0C = A, $0E = 0
    dw $0150
    dw $0160
    dw $0170
    dw $0180
    dw $0190
    dw $01A0
    dw $01B8 ; $0C = A, $0E = 7
}

; ==============================================================================

; $06BB0A-$06BB5A LOCAL JUMP LOCATION
OAM_GetBufferPosition:
{
    ; Inputs:
    ; A : Number of bytes requested for use in the OAM table. (number of
    ;     subsprites * 4)
    ; Y : Even value taken from { 0x00, ..., 0x0A }. Represents the region in the
    ;     table to allocate from.
    ; Hidden argument? (Not sure?) It is either 0 or 1, based on input from $0FB3
    ; (sort sprites variable)
    
    STA.b $0E
    STZ.w $000F
    
    REP #$20
    
    ; ($0FE0[0x10] is some kind of OAM allocator table)
    LDA.w $0FE0, Y : STA.b $90 : CLC : ADC.b $0E : CMP .limits, Y : BCC .within_limit
        ; (Sprite overflow, doesn't happen very often)
        ; (I think what happens is it resets the OAM buffer)
        STY.b $0C
        STZ.b $0D
        
        ; wtf...
        LDA.w $0FEC, Y : PHA : INC : STA.w $0FEC, Y
        
        PLA : AND.w #$0007 : ASL : STA.b $0E
        
        ; Y = (sprite field * 8) + $0E... whatever that is
        LDA.b $0C : ASL #3 : ADC.b $0E : TAY
        
        ; Reset the OAM Position (effectively ignores existing sprites)
        ; Note: I find it fairly interesting that there are set fallback points
        ; that increment state whenever this happens. This is kind of what
        ; induces the famous 'flicker' effect in video games, I imagine.
        LDA.w .fallback_points, Y : STA.b $90
        
        SEC
        
        BRA .moving_on
    
    .within_limit
    
    STA.w $0FE0, Y ; Store the new position in the OAM region
    
    .moving_on
    
    LDA.b $90 : PHA : LSR #2 : CLC : ADC.w #$0A20 : STA.b $92
    
    PLA : CLC : ADC.w #$0800 : STA.b $90
    
    SEP #$20
    
    LDY.b $90
    
    RTS
}

; ==============================================================================
