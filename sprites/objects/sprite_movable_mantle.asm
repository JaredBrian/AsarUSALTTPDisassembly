
; ==============================================================================

; $0D7C31-$0D7C38 LONG JUMP LOCATION
Sprite_MovableMantleLong:
{
    ; Sprite Logic for sprite 0xEE - pushable mantle
    PHB : PHK : PLB
    
    JSR Sprite_MovableMantle
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7C39-$0D7C9A LOCAL JUMP LOCATION
Sprite_MovableMantle:
{
    JSR MovableMantle_Draw
    JSR Sprite6_CheckIfActive
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .return
    
    JSL Sprite_NullifyHookshotDrag
    JSL Sprite_RepelDashAttackLong
    
    ; Only moves if Zelda is following you
    LDA.l $7EF3CC : CMP.b #$01 : BNE .return
    
    ; Only moves if you have the lamp
    LDA.l $7EF34A : BEQ .return
    
    ; Won't work if you're dashing
    LDA.w $0372 : BNE .return
    
    ; (for the mantle, this is how many pixels it has moved right)
    LDA.w $0ED0, X : CMP.b #$90 : BEQ .return
    
    ; Recoil can't induce mantle movement.
    LDA $28 : CMP.b #$18 : BMI .return
    
    ; Set a game state (numerical, not bitwise).
    LDA.b #$04 : STA.l $7EF3C8
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$01 : BNE .delay_movement
    
    INC.w $0ED0, X
    
    .delay_movement
    
    ; Start playing dragging sound after 8 pixels of movement.
    LDA.w $0ED0, X : CMP.b #$08 : BCC .return
    
    LDA.w $012E : BNE .sfx_slot_in_use
    
    LDA.b #$22 : STA.w $012E
    
    .sfx_slot_in_use
    
    LDA.b #$02 : STA.w $0D50, X
    
    JSL Sprite_MoveLong
    
    .return
    
    RTS
}

; ==============================================================================

; $0D7C9B-$0D7CB2 DATA
Pool_MovableMantle_Draw:
{
    ; \task Fill in data.
}

; ==============================================================================

; $0D7CB3-$0D7CEC LOCAL JUMP LOCATION
MovableMantle_Draw:
{
    LDA.b #$20 : JSL OAM_AllocateFromRegionB
    
    JSL Sprite_PrepOamCoordLong : BCS .not_on_screen
    
    PHX
    
    LDX.b #$05
    
    .next_subsprite
    
    LDA $00      : CLC : ADC.w $FC9B, X       : STA ($90), Y
    LDA $02      : CLC : ADC.w $FCA1, X : INY : STA ($90), Y
    LDA.w $FCA7, X                : INY : STA ($90), Y
    LDA.w $FCAD, X                : INY : STA ($90), Y : INY
    
    DEX : BPL .next_subsprite
    
    PLX
    
    LDY.b #$02
    LDA.b #$05
    
    JSL Sprite_CorrectOamEntriesLong
    
    .not_on_screen
    
    RTS
}

; ==============================================================================
