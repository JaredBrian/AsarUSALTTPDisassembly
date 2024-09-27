; ==============================================================================

; Tutorial Soldier (0x3F) / Evil Barrier (0x40)
; $02D53B-$02D542 LONG JUMP LOCATION
Sprite_TutorialEntitiesLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_TutorialEntities
    
    PLB
    
    RTL
}

; ==============================================================================

; $02D543-$02D547 BRANCH LOCATION
Sprite_EvilBarrierTrampoline:
{
    JSL.l Sprite_EvilBarrierLong
    
    RTS
}

; ==============================================================================

; $02D548-$02D54B DATA
Sprite_TutorialEntities_animation_states:
{
    db $02, $01, $00, $03
}

; $02D54C-$02D5BE LOCAL JUMP LOCATION
Sprite_TutorialEntities:
{
    ; Check if it's the hyrule castle electric fence:
    LDA.w $0E20, X : CMP.b #$40 : BEQ Sprite_EvilBarrierTrampoline
        LDY.w $0DE0, X : PHY
        
        LDA.w $0E00, X : BEQ .direction_lock_inactive
            LDA.w Soldier_DirectionLockSettings_directions, Y : STA.w $0DE0, X
        
        .direction_lock_inactive
        
        LDY.w $0DE0, X
        
        LDA.w .animation_states, Y : STA.w $0DC0, X
        
        ; Draw the soldier's sprites.
        JSR.w TutorialSoldier_Draw
        
        PLA : STA.w $0DE0, X
        
        ; Checks if sprite is inactive (in which case it forces us out of this
        ; routine).
        JSR.w Sprite2_CheckIfActive
        JSL.l Sprite_CheckDamageFromPlayerLong
        
        LDA.w $040A : CMP.b #$1B : BNE .use_default_tutorial_messages
            ; "...I suppose it's only a matter of time before I'm affected, too."
            LDA.b #$B2
            
            LDY.w $0D00, X : CPY.b #$50 : BEQ .guy_on_rampart
                ; "...You're not allowed in the castle, son! Go home..."
                LDA.b #$B3   : CPY.b #$90 : BNE .use_default_tutorial_messages
                
            .guy_on_rampart
            
            LDY.b #$00
            JSL.l Sprite_ShowMessageIfPlayerTouching
            
            BRA .moving_on
            
        .use_default_tutorial_messages
        
        LDA.w $0B69 : PHA : CLC : ADC.b #$0F
        LDY.b #$00
        JSL.l Sprite_ShowMessageIfPlayerTouching
        
        PLA : BCC .message_not_shown
            INC A : CMP.b #$07 : BNE .no_message_index_reset
                LDA.b #$00
            
            .no_message_index_reset
        .message_not_shown
        
        STA.w $0B69
        
        .moving_on
        
        JSR.w Sprite2_CheckDamage
        
        TXA : EOR.b $1A : AND.b #$1F : BNE .delay_facing
            JSR.w Trooper_FacePlayer
            
        .delay_facing
        
        RTS
}

; ==============================================================================

; $02D5BF-$02D64A DATA
Pool_TutorialSoldier_Draw:
{
    ; $02D5BF
    .x_offsets
    dw  4,  0, -6, -6,  2,  0,  0, -7
    dw -7, -7,  0,  0, 15, 15, 15,  6
    dw 14, -4,  4,  0
    
    ; $02D5E7
    .y_offsets
    dw  0, -10, -4, 12,  12,  0, -9, -11
    dw -3,   5,  0, -9, -11, -3,  5, -11
    dw  5,   0,  0, -9
    
    ; $02D60F
    .chr
    db $46, $40, $00, $28, $29, $4E, $42, $39
    db $2A, $3A, $4E, $42, $39, $2A, $3A, $26
    db $38, $64, $64, $44
    
    ; $02D623
    .vh_flip
    db $40, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $40, $40, $40, $40, $40, $00
    db $40, $00, $40, $00
    
    ; $02D637
    .sizes
    db $02, $02, $02, $00, $00, $02, $02, $00
    db $00, $00, $02, $02, $00, $00, $00, $02
    db $00, $02, $02, $02        
}

; $02D64B-$02D6BB LOCA
TutorialSoldier_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    ; $06 = ($0DC0, X * 5)
    LDA.w $0DC0, X : ASL #2 : ADC.w $0DC0, X : STA.b $06
    
    PHX
    
    LDX.b #$04
    
    .next_subsprite
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL A : TAX
        
        REP #$20
        
        LDA.w Pool_TutorialSoldier_x_offsets, X : CLC : ADC.b $00 : STA ($90), Y
        AND.w #$0100 : STA.b $0E
        
        LDA.w Pool_TutorialSoldier_y_offsets, X : CLC : ADC.b $02 : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
            ; Hide the sprite.
            LDA.w #$00F0 : STA ($90), Y
            
        .on_screen_y
        
        SEP #$20
        
        PLX
        
        LDA.w Pool_TutorialSoldier_chr, X : INY : STA ($90), Y : CMP.b #$40
        
        LDA.w Pool_TutorialSoldier_vh_flip, X : ORA.b $05 : BCS .no_palette_override
            AND.b #$F1 : ORA.b #$08
        
        .no_palette_override
        
        INY
        
        STA ($90), Y
        
        PHY
        
        TYA : LSR A : LSR A : TAY
        
        LDA.w Pool_TutorialSoldier_Draw_sizes, X : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX : LDA.b #$0C
    
    JSL.l Sprite_DrawShadowLong_variable
    
    RTS
}

; ==============================================================================
