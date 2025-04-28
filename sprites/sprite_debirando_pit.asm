; ==============================================================================

; $02852D-$028530 DATA
Pool_Sprite_DebirandoPit:
{
    ; $02852D
    .drag_x
    db -1, 1
    
    ; $02852F
    .drag_y
    db -1, 0
}

; Sand lion pit code
; $028531-$0285DD JUMP LOCATION
Sprite_DebirandoPit:
{
    JSR.w Sprite2_DirectionToFacePlayer
    
    LDA.b $0E : CLC : ADC.b #$20 : CMP.b #$40 : BCS .ignore_player
        LDA.b $0F : CLC : ADC.b #$20 : CMP.b #$40 : BCS .ignore_player
            LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
    
    .ignore_player
    
    JSR.w DebirandoPit_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDY.w $0EB0, X
    
    LDA.w $0DD0, Y : CMP.b #$06 : BNE .cosprite_not_dying
        STA.w $0DD0, X
        
        LDA.w $0DF0, Y : STA.w $0DF0, X
        
        LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
        
        RTS
        
    .cosprite_not_dying
    
    LDA.w $0DC0, X : CMP.b #$03 : BCS .not_open
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_contact
            JSL.l Player_HaltDashAttackLong
            
            ; \tcrf (verified)
            ; Cheat code is a tentative name, though probably a well qualified
            ; one as well. This stanza would seem to indicate that tapping the R
            ; button can help you escape from the pits.
            LDA.b $F6 : AND.b #$10 : BNE .cheat_code
                ; Without tapping that, you're stuck.
                LDA.b #$01 : STA.w $0B7B
            
            .cheat_code
            
            LDA.b #$10
            
            JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
            LDY.b #$00
            
            LDA.b $00 : BPL .epsilon
                EOR.b #$FF : INC A
                
                INY
            
            .epsilon
            
            CLC : ADC.w $0D90, X : STA.w $0D90, X : BCC .zeta
                LDA.w Pool_Sprite_DebirandoPit_drag_x, Y : STA.w $0B7E
                LDA.w Pool_Sprite_DebirandoPit_drag_y, Y : STA.w $0B7F
            
            .zeta
            
            LDY.b #$00
            
            LDA.b $01 : BPL .theta
                EOR.b #$FF : INC A
                
                INY
            
            .theta
            
            CLC : ADC.w $0DA0, X : STA.w $0DA0, X : BCC .gamma
                LDA.w Pool_Sprite_DebirandoPit_drag_x, Y : STA.w $0B7C
                LDA.w Pool_Sprite_DebirandoPit_drag_y, Y : STA.w $0B7D
                
            .gamma
        .no_player_contact
    .not_open
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw DebirandoPit_Closed  ; 0x00 - $85DE
    dw DebirandoPit_Opening ; 0x01 - $85F5
    dw DebirandoPit_Open    ; 0x02 - $860F
    dw DebirandoPit_Closing ; 0x03 - $8634
}

; ==============================================================================

; $0285DE-$0285F0 JUMP LOCATION
DebirandoPit_Closed:
{
    LDA.b #$06 : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$3F : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0285F1-$0285F4 DATA
DebirandoPit_Opening_animation_states:
{
    db 5, 4, 3, 3
}

; $0285F5-$02860E JUMP LOCATION
DebirandoPit_Opening:
{
    LDA.w $0DF0, X : BNE .delay_ai_state_transition
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        RTS
    
    .delay_ai_state_transition
    
    LSR #4 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02860F-$02862F JUMP LOCATION
DebirandoPit_Open:
{
    LDA.b $1A : AND.b #$0F : BNE .skip_frame
        INC.w $0DC0, X : LDA.w $0DC0, X : CMP.b #$03 : BCC .no_modulus
            STZ.w $0DC0, X
        
        .no_modulus
    .skip_frame
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$3F : STA.w $0DF0, X
        
        INC.w $0D80, X
    
    .delay
    
    RTS
} 

; ==============================================================================

; $028630-$028633 DATA
DebirandoPit_Closing_animation_states:
{
    db 3, 3, 4, 5
}

; $028634-$02864D JUMP LOCATION
DebirandoPit_Closing:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #4 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02864E-$0286E3 DATA
Pool_DebirandoPit_Draw:
{
    ; $02864E
    .x_offsets
    dw -8,  8, -8,  8, -8,  8, -8,  8
    dw -8,  8, -8,  8,  0,  8,  0,  8
    dw  0,  8,  0,  8, -8,  8, -8,  8
    
    ; $02867E
    .y_offsets
    dw -8, -8,  8,  8, -8, -8,  8,  8
    dw -8, -8,  8,  8,  0,  0,  8,  8
    dw  0,  0,  8,  8, -8, -8,  8,  8
    
    ; $0286AE
    .chr
    db $04, $04, $04, $04, $22, $22, $22, $22
    db $02, $02, $02, $02, $29, $29, $29, $29
    db $39, $39, $39, $39, $2A, $2A, $2A, $2A
    
    ; $0286C6
    .vh_flip
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    
    ; $0286DE
    .OAM_sizes
    db $02, $02, $02, $00, $00, $02
}

; $0286E4-$02874C LOCAL JUMP LOCATION
DebirandoPit_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    ; The pit is not at all open right now, so don't draw it.
    LDA.w $0DC0, X : CMP.b #$06 : BEQ .return
        PHX
        
        TAX
        
        LDA Pool_DebirandoPit_Draw_OAM_sizes, X : STA.b $0D
        
        TXA : ASL #2 : STA.b $06
        
        LDX.b #$03
        
        .next_subsprite
            
            PHX
            
            TXA : CLC : ADC.b $06 : PHA
            
            ASL A : TAX
            
            REP #$20
            
            LDA.b $00 : CLC : ADC Pool_DebirandoPit_Draw_x_offsets, X
            STA ($90), Y
            
            AND.w #$0100 : STA.b $0E
            
            LDA.b $02 : CLC : ADC Pool_DebirandoPit_Draw_y_offsets, X
            INY : STA ($90), Y
            
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA ($90), Y
            
            .on_screen_y
            
            PLX
            
            LDA Pool_DebirandoPit_Draw_chr, X
            INY : STA ($90), Y

            LDA Pool_DebirandoPit_Draw_vh_flip, X
            ORA.b $05 : INY : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            LDA.b $0D : ORA.b $0F : STA ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_subsprite
        
        PLX
    
    .return
    
    RTS
}
    
; ==============================================================================
