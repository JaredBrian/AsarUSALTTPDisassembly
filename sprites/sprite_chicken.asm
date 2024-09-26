; ==============================================================================

; UNUSED: Presumably
; $032540-$0325BF DATA
UNUSED06A540:
{
    dw -24,  -8,   8,  24, -24,  -8,   8,  24
    dw -24,  -8,   8,  24, -24,  -8,   8,  24
    dw -22,  -7,   7,  22, -22,  -7,   7,  22
    dw -22,  -7,   7,  22, -22,  -7,   7,  22
    dw -24, -24, -24, -24,  -8,  -8,  -8,  -8
    dw   8,   8,   8,   8,  24,  24,  24,  24
    dw -22, -22, -22, -22,  -7,  -7,  -7,  -7
    dw   7,   7,   7,   7,  22,  22,  22,  22
}

; ==============================================================================

; $0325C0-$0325C1 DATA
Sprite_Chicken_h_flip:
{
    db $40, $00
}

; $0325C2-$0326AC JUMP LOCATION
Sprite_Chicken:
{
    LDA.w $0D50, X : BEQ .x_speed_at_rest
        ; Change h-flip status mainly when.
        ASL A : ROL A : AND.b #$01 : TAY
        
        LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
        
    .x_speed_at_rest
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    
    LDA.w $0EB0, X : BEQ .not_transmutable_to_human
        LDA.b #$3D : STA.w $0E20, X
        
        JSL.l Sprite_LoadProperties
        
        INC.w $0E30, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
        LDA.b #$15 : STA.w $012E : STA.w $0BA0, X
        
        RTS
        
    .not_transmutable_to_human
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .not_being_held_by_player
        LDA.b #$03 : STA.w $0D80, X

        LDA.b $11 : BNE .inactive_game_submodule
            JSR.w Chicken_SlowAnimate
            JSR.w Chicken_DrawDistressMarker
                
            LDA.b $1A : AND.b #$0F : BNE .no_bawk_bawk
                JSR.w Chicken_BawkBawk
                
            .no_bawk_bawk
        .inactive_game_submodule
    .not_being_held_by_player
    
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0DB0, X : BEQ .not_part_of_horde
        LDA.w $0F50, X : ORA.b #$10 : STA.w $0F50, X
        
        JSR.w Sprite_Move
        
        LDA.b #$0C : STA.w $0F70, X : STA.w $0BA0, X
        
        TXA : EOR.b $1A : AND.b #$07 : BNE .horde_damage_delay
            JSR.w Sprite_CheckDamageToPlayer
        
        .horde_damage_delay
        
        JMP Chicken_FastAnimate
    
    .not_part_of_horde
    
    LDA.b #$FF : STA.w $0E50, X
    
    ; Begin spawning attack chickens if the player has hit this chicken
    ; too many times.
    LDA.w $0DA0, X : CMP.b #$23 : BCC .anospawn_attack_chicken
        JSR.w Chicken_SpawnAvengerChicken
    
    .anospawn_attack_chicken
    
    LDA.w $0EA0, X : BEQ .no_new_hits_from_player
        STZ.w $0EA0, X
        
        ; If saturated, don't make this particular chicken bawk, because the
        ; others will be doing a lot of it.
        LDA.w $0DA0, X : CMP.b #$23 : BCS .saturated_with_hits
            INC.w $0DA0, X
            
            JSR.w Chicken_BawkBawk
        
        .saturated_with_hits
        
        LDA.b #$02 : STA.w $0D80, X
    
    .no_new_hits_from_player
    
    JSR.w Sprite_CheckDamageFromPlayer
    
    LDA.w $0D80, X : BEQ .calm
        CMP.b #$01 : BEQ Chicken_Hopping
            CMP.b #$02 : BNE .aloft
                JMP Chicken_FleeingPlayer
        
            .aloft
        
            JMP Chicken_Aloft
        
    .calm
    
    LDA.w $0DF0, X : BNE .delay_direction_change 
        JSL.l GetRandomInt : AND.b #$0F
        
        PHX : TXY
        
        TAX
        
        LDA.l Pool_Keese_Agitated_random_x_speeds, X : STA.w $0D50, Y
        
        LDA.l Pool_Keese_Agitated_random_x_speeds, X : STA.w $0D40, Y
        
        PLX
        
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$10 : STA.w $0DF0, X
        
        INC.w $0D80, X
        
    .delay_direction_change
    
    STZ.w $0DC0, X

    ; Bleeds into the next function.
}

; $0326AD-$0326B0 JUMP LOCATION
Chicken_CheckIfLifted:
{
    JSR.w Sprite_CheckIfLifted
    
    RTS
}

; ==============================================================================

; $0326B1-$0326E1 BRANCH LOCATION
Chicken_Hopping:
{
    TXA : EOR.b $1A : LSR A : BCC .skip_tile_collision_logic
        JSR.w Chicken_Move_XY_AndCheckTileCollision : BEQ .no_tile_collision
            STZ.w $0D80, X
        
        .no_tile_collision
    .skip_tile_collision_logic
    
    JSR.w Sprite_MoveAltitude
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .tick_animation_counter
        STZ.w $0F70, X
        
        LDA.w $0DF0, X : BNE .delay_hopping_halt
            LDA.b #$20 : STA.w $0DF0, X
            
            STZ.w $0D80, X
        
        .delay_hopping_halt
        
        LDA.b #$0A : STA.w $0F80, X
    
    .tick_animation_counter

    ; Bleeds into the next function.
}
    
; $0326E2-$0326E4 BRANCH LOCATION
Chicken_FastAnimate:
{
    INC.w $0E80, X

    ; Bleeds into the next function.
}

; $0326E5-$0326FB BRANCH LOCATION
Chicken_SlowAnimate:
{
    INC.w $0E80, X : INC.w $0E80, X : INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    BRA Chicken_CheckIfLifted
}

; ==============================================================================

; $0326FC-$03270B JUMP LOCATION
Chicken_FleeingPlayer:
{
    JSR.w Chicken_CheckIfLifted
    JSR.w Chicken_Move_XY_AndCheckTileCollision
    
    STZ.w $0F70, X
    
    TXA : EOR.b $1A : AND.b #$1F : BNE Chicken_SetFleePlayerSpeeds_flee_delay
        ; Bleeds into the next function.
}

; $03270C-$032726 JUMP LOCATION
Chicken_SetFleePlayerSpeeds:
{
    LDA.b #$10 : JSR.w Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : EOR.b #$FF : INC A : STA.w $0D40, X
    LDA.b $01 : EOR.b #$FF : INC A : STA.w $0D50, X
    
    ; $032721 ALTERNATE ENTRY POINT
    .flee_delay
    
    INC.w $0E80, X
    
    JSR.w Chicken_FastAnimate

    ; Bleeds into the next function.
}
    
; $032727-$03272E JUMP LOCATION
Chicken_DrawDistressMarker:
{
    JSR.w Sprite_PrepOamCoord
    JSL.l Sprite_DrawDistressMarker
    
    RTS
}

; ==============================================================================

; Draws the 4 little dots that appear above the cucco when you hit them.
; Each dot is 1 8x8 oam tile for a total of 4.
; $03272F-$032732 LONG JUMP LOCATION
Sprite_DrawDistressMarker:
{
    LDA.b $1A : STA.b $06

    ; Bleeds into the next function.
}
    
; $032733-$03278D LONG JUMP LOCATION
Sprite_CustomTimedDrawDistressMarker:
{
    ; Allocate some oam space...
    LDA.b #$10 : JSL.l OAM_AllocateFromRegionA
    
    LDA.b $06 : AND.b #$18 : BEQ .return
        PHX
        
        LDX.b #$03
        LDY.b #$00
        
        .next_oam_entry
        
            PHX : PHX
            
            TXA : ASL A : TAX
            
            REP #$20
            
            LDA.b $00
            CLC : ADC.l Pool_Sprite_DrawDistressMarker_x_offsets, X
            STA ($90), Y
            
            AND.w #$0100 : STA.b $0E
            
            LDA.b $02
            CLC : ADC.l Pool_Sprite_DrawDistressMarker_y_offsets, X
            INY : STA ($90), Y
            
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA ($90), Y
        
            .on_screen_y
        
            PLX
            
            LDA.b #$83 : INY : STA ($90), Y
            LDA.b #$22 : INY : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            LDA.b $0F : STA ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_oam_entry
        
        PLX
        
    .return
    
    RTL
}

; ==============================================================================

; $03278E-$0327B7 LOCAL JUMP LOCATION
Chicken_Aloft:
{
    JSR.w Chicken_Move_XYZ_AndCheckTileCollision : BEQ .no_tile_collision
        JSR.w Sprite_Invert_XY_Speeds

        JSR.w Sprite_Move
        JSR.w Sprite_Halve_XY_Speeds
        JSR.w Sprite_Halve_XY_Speeds
        JSR.w Chicken_BawkBawk
    
    .no_tile_collision
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_grounded
        STZ.w $0F70, X
        
        LDA.b #$02 : STA.w $0D80, X
        
        JMP Chicken_SetFleePlayerSpeeds
    
    .not_grounded
    
    JMP Chicken_FastAnimate
}
    
; ==============================================================================

; $0327B8-$0327BB LOCAL JUMP LOCATION
Chicken_Move_XYZ_AndCheckTileCollision:
{
    JSR.w Sprite_MoveAltitude

    ; Bleeds into the next functino.
}
    
; $0327BB-$0327C2 LOCAL JUMP LOCATION
Chicken_Move_XY_AndCheckTileCollision:
{
    JSR.w Sprite_Move
    JSL.l Sprite_CheckTileCollisionLong
    
    RTS
}

; ==============================================================================

; $0327C3-$0327D2 DATA
Pool_Sprite_DrawDistressMarker:
{
    ; $0327C3
    .x_offsets
    dw -3,  2,  7, 11
    
    ; $0327CB
    .y_offsets
    dw -5, -7, -7, -5
}

; ==============================================================================

; $0327D3-$03284B LOCAL JUMP LOCATION
Chicken_SpawnAvengerChicken:
{
    TXA : EOR.b $1A : AND.b #$0F : ORA.b $1B : BNE Chicken_BawkBawk_spawn_delay
        LDA.b #$0B
        LDY.b #$0A
        
        JSL.l Sprite_SpawnDynamically_arbitrary : BMI Chicken_BawkBawk_spawn_failed
            PHX
            
            TYX
            
            LDA.b #$1E : JSL.l Sound_SetSfx3PanLong
            
            PLX
            
            LDA.b #$01 : STA.w $0DB0, Y
            
            PHX
            
            JSL.l GetRandomInt : STA.b $0F : AND.b #$02 : BEQ .vertical_entry_point
                LDA.b $0F : ADC.b $E2  : STA.w $0D10, Y
                LDA.b $E3 : ADC.b #$00 : STA.w $0D30, Y
                
                LDA.b $0F : AND.b #$01 : TAX
                
                LDA.w Pool_Hinox_ThrowBomb_x_offsets_high, X
                ADC.b $E8 : STA.w $0D00, Y

                LDA.b $E9 : ADC.b #$00 : STA.w $0D20, Y
                
                BRA .set_velocity
        
            .vertical_entry_point
        
            LDA.b $0F : ADC.b $E8  : STA.w $0D00, Y
            LDA.b $E9 : ADC.b #$00 : STA.w $0D20, Y
            
            LDA.b $0F : AND.b #$01 : TAX
            
            LDA.w Pool_Hinox_ThrowBomb_x_offsets_high, X
            ADC.b $E2 : STA.w $0D10, Y

            LDA.b $E3 : ADC.b #$00 : STA.w $0D30, Y
        
            .set_velocity
        
            TYX
            
            LDA.b #$20 : JSR.w Sprite_ApplySpeedTowardsPlayer
            
            PLX

            ; Bleeds into the next function.
}
        
; $03284C-$032852 LOCAL JUMP LOCATION
Chicken_BawkBawk:
{   
    LDA.b #$30 : JSL.l Sound_SetSfx2PanLong
        
    .spawn_failed
    .spawn_delay
    
    RTS
}

; ==============================================================================
