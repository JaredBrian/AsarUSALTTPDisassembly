; ==============================================================================

; Sprite Logic for sprite 0xEE - pushable mantle
; $0D7C31-$0D7C38 LONG JUMP LOCATION
Sprite_MovableMantleLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_MovableMantle
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7C39-$0D7C9A LOCAL JUMP LOCATION
Sprite_MovableMantle:
{
    JSR.w MovableMantle_Draw
    JSR.w Sprite6_CheckIfActive
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .return
        JSL.l Sprite_NullifyHookshotDrag
        JSL.l Sprite_RepelDashAttackLong
        
        ; Only moves if Zelda is following you.
        LDA.l $7EF3CC : CMP.b #$01 : BNE .return
            ; Only moves if you have the lamp.
            LDA.l $7EF34A : BEQ .return
                ; Won't work if you're dashing.
                LDA.w $0372 : BNE .return
                    ; For the mantle, this is how many pixels it has moved right.
                    LDA.w $0ED0, X : CMP.b #$90 : BEQ .return
                        ; Recoil can't induce mantle movement.
                        LDA.b $28 : CMP.b #$18 : BMI .return
                            ; Set a game state (numerical, not bitwise).
                            LDA.b #$04 : STA.l $7EF3C8
                            
                            INC.w $0E80, 
                            LDA.w $0E80, X : AND.b #$01 : BNE .delay_movement
                                INC.w $0ED0, X
                            
                            .delay_movement
                            
                            ; Start playing dragging sound after 8 pixels of
                            ; movement.
                            LDA.w $0ED0, X : CMP.b #$08 : BCC .return
                                LDA.w $012E : BNE .SFX_slot_in_use
                                    LDA.b #$22 : STA.w $012E
                                
                                .SFX_slot_in_use
                                
                                LDA.b #$02 : STA.w $0D50, X
                                
                                JSL.l Sprite_MoveLong
    
    .return
    
    RTS
}

; ==============================================================================

; $0D7C9B-$0D7CB2 DATA
Pool_MovableMantle_Draw:
{
    ; $0D7C9B
    .offset_x
    db   0,  16,  32,   0,  16,  32

    ; $0D7CA1
    .offset_y
    db   0,   0,   0,  16,  16,  16

    ; $0D7CA7
    .char
    db $0C, $0E, $0C, $2C, $2E, $2C

    ; $0D7CAD
    .prop
    db $31, $31, $71, $31, $31, $71
}

; $0D7CB3-$0D7CEC LOCAL JUMP LOCATION
MovableMantle_Draw:
{
    LDA.b #$20
    JSL.l OAM_AllocateFromRegionB
    
    JSL.l Sprite_PrepOamCoordLong : BCS .not_on_screen
        PHX
        
        LDX.b #$05
        
        .next_subsprite
            
            LDA.b $00 : CLC : ADC.w Pool_MovableMantle_Draw_offset_x, X
            STA.b ($90), Y

            LDA.b $02 : CLC : ADC.w Pool_MovableMantle_Draw_offset_y, X
            INY : STA.b ($90), Y

            LDA.w Pool_MovableMantle_Draw_char, X : INY : STA.b ($90), Y
            LDA.w Pool_MovableMantle_Draw_prop, X : INY : STA.b ($90), Y
            INY
        DEX : BPL .next_subsprite
        
        PLX
        
        LDY.b #$02
        LDA.b #$05
        JSL.l Sprite_CorrectOamEntriesLong
    
    .not_on_screen
    
    RTS
}

; ==============================================================================
