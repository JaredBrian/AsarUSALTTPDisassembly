; ==============================================================================

; Bottle vendor (0x75)
; $02EA71-$02EA78 LONG JUMP LOCATION
Sprite_BottleVendorLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_BottleVendor
    
    PLB
    
    RTL
}

; ==============================================================================

; Note: $0E90 is 0 - normal, 1 - good bee is present, 0x80 - fish
; are present, 0x81 - fish and good bee are present, but fish overrides
; good bee for this sprite's behavior.
; $02EA79-$02EABD LOCAL JUMP LOCATION
Sprite_BottleVendor:
{
    JSR.w BottleVendor_Draw
    
    LDA.b $03 : ORA.b $01 : STA.w $0D90, X
    
    JSR.w Sprite2_CheckIfActive
    JSL.l BottleVendor_DetectFish
    JSL.l Sprite_PlayerCantPassThrough
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCC .player_available
        RTS
    
    .player_available
    
    JSL.l GetRandomInt : BNE .dont_reset_timer
        LDA.b #$01 : STA.w $0DC0, X
        
        LDA.b #$14 : STA.w $0DF0, X
        
    .dont_reset_timer
    
    LDA.w $0DF0, X : BNE .wait
        STZ.w $0DC0, X
    
    .wait
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw BottleVendor_Base                   ; 0x00 - $EAC7
    dw BottleVendor_SellingBottle          ; 0x01 - $EAED
    dw BottleVendor_GiveBottle             ; 0x02 - $EB17
    dw BottleVendor_BuyingFromPlayer       ; 0x03 - $EB40
    dw BottleVendor_DispenseRewardToPlayer ; 0x04 - $EB5D
}

; ==============================================================================

; $02EABE-$02EAC6 BRANCH LOCATION
BottleVendor_SoldOut:
{
    ; "I'm sold out of bottles, come back later."
    LDA.b #$D4
    LDY.b #$00 
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $02EAC7-$02EAEC JUMP LOCATION
BottleVendor_Base:
{
    ; TODO: Find out why it would check this... What is $0D90 really, for
    ; this sprite?
    LDA.w $0D90, X : BNE .off_screen
        LDA.w $0E90, X : BEQ .no_fish_or_good_bee
            LDA.b #$03 : STA.w $0D80, X
            
            RTS
            
        .no_fish_or_good_bee
    .off_screen
    
    LDA.l $7EF3C9 : AND.b #$02 : BNE BottleVendor_SoldOut
        ; "... I've got one on sale for the low, low price of 100 rupees!..."
        LDA.b #$D1
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_converse
            INC.w $0D80, X
        
        .didnt_converse
        
        RTS
}

; ==============================================================================

; $02EAED-$02EB16 JUMP LOCATION
BottleVendor_SellingBottle:
{
    LDA.w $1CE8 : BNE .no_selected
        REP #$20
        
        ; Check if player has 100 rupees (bottle vendor?)
        LDA.l $7EF360 : CMP.w #$0064 : SEP #$30 : BCC .player_cant_afford
            ; "...Now, hold it above your head for the whole world to see, OK?..."
            LDA.b #$D2
            LDY.b #$00
            JSL.l Sprite_ShowMessageUnconditional
            
            INC.w $0D80, X
            
            RTS
            
        .player_cant_afford
    .no_selected
    
    ; "...Come back after you earn more Rupees.  It might still be here."
    LDA.b #$D3
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02EB17-$02EB3F JUMP LOCATION
BottleVendor_GiveBottle:
{
    ; \item(Bottle)
    LDY.b #$16
    
    STZ.w $02E9
    
    PHX
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    LDA.l $7EF3C9 : ORA.b #$02 : STA.l $7EF3C9
    
    REP #$20
    
    LDA.l $7EF360 : SEC : SBC.w #$0064 : STA.l $7EF360
    
    SEP #$30
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02EB40-$02EB5C JUMP LOCATION
BottleVendor_BuyingFromPlayer:
{
    LDA.w $0E90, X : BMI .player_has_fish
        ; "Wow! I've never seen such a rare bug! I'll buy it for 100 rupees..."
        LDA.b #$D5
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        RTS
    
    .player_has_fish
    
    ; "You have to give me this fish for this stuff, OK? Done!"
    LDA.b #$D6
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02EB5D-$02EB86 JUMP LOCATION
BottleVendor_DispenseRewardToPlayer:
{
    LDY.w $0E90, X : BMI .player_has_fish
        DEY
        
        LDA.b #$00 : STA.w $0DD0, Y
        
        JSL.l BottleVendor_PayForGoodBee
        
        STZ.w $0E90, X
        STZ.w $0D80, X
        
        RTS
        
    .player_has_fish
    
    TYA : AND.b #$0F : TAY
    
    LDA.b #$00 : STA.w $0DD0, Y
    
    JSL.l BottleVendor_SpawnFishRewards
    
    STZ.w $0E90, X
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02EB87-$02EBA6 DATA
BottleVendor_Draw_animation_states:
{
    dw 0, -7 : db $AC, $00, $00, $02
    dw 0,  0 : db $88, $00, $00, $02
    
    dw 0, -6 : db $AC, $00, $00, $02
    dw 0,  0 : db $A2, $00, $00, $02
}

; $02EBA7-$02EBC6 LOCAL JUMP LOCATION
BottleVendor_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    
    ; $EB87 = .animation_states
    ADC.b #.animation_states                 : STA.b $08
    LDA.b #.animation_states>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
