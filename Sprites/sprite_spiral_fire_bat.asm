; ==============================================================================

; $0E8B52-$0E8B8F JUMP LOCATION
Sprite_SpiralFireBat:
{
    JSR.w FireBat_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_Load_16bit_AuxCoord
    
    LDA.b #$02
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    LDA.b #$50
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.w $0D50, X : EOR.b #$FF : INC : CLC : ADC.b $00 : STA.w $0D50, X
    LDA.w $0D40, X : EOR.b #$FF : INC                   : STA.b $00
    LDA.b $01      : EOR.b #$FF : INC : CLC : ADC.b $00 : STA.w $0D40, X

    ; Bleeds into the next location.
}

; $0E8B90-$0E8BBB JUMP LOCATION
FireBat_Move:
{
    JSR.w FireBat_Animate
    JSR.w Sprite4_Move

    LDA.w $0E80, X : AND.b #$07 : BNE .BRANCH_ALPHA
        LDA.b #$0E
        JSR.w FireBat_SpawnFireballGarnish
        
        LDY.w $0EC0, X
        
        PHX
        
        LDX.b $00
        LDA.b #$10 : STA.l $7FF800, X
        
        LDA.b #$4F
        
        CPY.b #$05 : BNE .BRANCH_BETA
            LDA.b #$2F
        
        .BRANCH_BETA
        
        STA.l $7FF90E, X
        
        PLX
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; TODO: Investigate the usage of this routine. I suspect that it more
; correctly would be called Sprite4_LoadOriginCoord, but it's not clear
; if the Lynel uses it differently.
; $0E8BBC-$0E8BD0 LOCAL JUMP LOCATION
Sprite4_Load_16bit_AuxCoord:
{
    LDA.w $0D90, X : STA.b $04
    LDA.w $0DA0, X : STA.b $05
    
    LDA.w $0DB0, X : STA.b $06
    LDA.w $0E90, X : STA.b $07
    
    RTS
}

; ==============================================================================
