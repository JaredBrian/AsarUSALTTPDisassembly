; ==============================================================================

; $0E84F1-$0E8530 DATA
ChimneySmoke_Draw_OAM_groups:
{
    dw 0, 0 : db $86, $00, $00, $00
    dw 8, 0 : db $87, $00, $00, $00
    dw 0, 8 : db $96, $00, $00, $00
    dw 8, 8 : db $97, $00, $00, $00
    
    dw 1, 1 : db $86, $00, $00, $00
    dw 7, 1 : db $87, $00, $00, $00
    dw 1, 7 : db $96, $00, $00, $00
    dw 7, 7 : db $97, $00, $00, $00
}

; $0E8531-$0E8548 LOCAL JUMP LOCATION
ChimneySmoke_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : AND.b #$01 : REP #$20 : ASL #5
    
    ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04

    ; Bleeds into the next function.
}
    
; $0E8549-$0E854D LOCAL JUMP LOCATION
Sprite4_DrawMultiple:
{ 
    JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $0E854E-$0E854F DATA
Pool_Sprite_Chimney_x_speed_targets:
{
    db 4, -4
}

; ==============================================================================

; $0E8550-$0E858A BRANCH LOCATION
Sprite_ChimneySmoke:
{
    LDA.b #$30 : STA.w $0B89, X
    
    JSR.w ChimneySmoke_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_Move
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$07 : BNE .speed_adjust_delay
        LDA.w $0DE0, X : AND.b #$01 : TAY
        
        LDA.w $0D50, X
        
        CLC : ADC Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D50, X
        
        CMP Pool_Sprite_Chimney_x_speed_targets, Y : BNE .anoswitch_direction
            INC.w $0DE0, X
        
        .anoswitch_direction
    .speed_adjust_delay
    
    LDA.w $0E80, X : AND.b #$1F : BNE .anoincrement_animation_state
        INC.w $0DC0, X
    
    .anoincrement_animation_state
    
    RTS
}

; ==============================================================================

; $0E858B-$0E85DF JUMP LOCATION
Sprite_ChimneyAndRabbitBeam:
Sprite_Chimney:
{
    LDA.b $1B : BNE Sprite_RabbitBeam
        LDA.b #$40 : STA.w $0E60, X : STA.w $0BA0, X
        
        LDA.w $0D80, X : BNE Sprite_ChimneySmoke
            JSR.w Sprite4_CheckIfActive
            
            LDA.w $0DF0, X : BNE .spawn_delay
                LDA.b #$43 : STA.w $0DF0, X
                
                LDA.b #$D1 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
                    JSL.l Sprite_SetSpawnedCoords
                    
                    LDA.b $00 : CLC : ADC.b #$08 : STA.w $0D10, Y
                    
                    LDA.b $02 : ADC.b #$04 : STA.w $0D00, Y
                    
                    LDA.b #$04 : STA.w $0F50, Y : STA.w $0D80, Y
                    
                    LDA.b #$43 : STA.w $0E40, Y : STA.w $0E60, Y
                    
                    LDA.w .x_speed_targets+1 : STA.w $0D50, Y
                    
                    LDA.b #-6 : STA.w $0D40, Y
                
                .spawn_failed
            .spawn_delay
            
            RTS
}
    
; ==============================================================================

; $0E85E0-$0E85F9 BRANCH LOCATION
Sprite_RabbitBeam:
{
    LDA.w $0D80, X : BNE RabbitBeam_Active
        JSL.l Sprite_PrepOamCoordLong
        JSR.w Sprite4_CheckIfActive
        
        JSR.w Sprite4_CheckTileCollision : BNE .no_tile_collision
            INC.w $0D80, X
            
            LDA.b #$80 : STA.w $0DF0, X
        
        .no_tile_collision
        
        RTS
}

; ==============================================================================

; $0E85FA-$0E85FF DATA
RabbitBeam_Active_chr:
{
    db $D7, $D7, $D7, $91, $91, $91
}

; $0E8600-$0E8669 BRANCH LOCATION
RabbitBeam_Active:
{
    JSL.l Sprite_DrawFourAroundOne
    
    LDA.w $0F00, X : BNE .sprite_is_paused
        LDY.w $0DC0, X
        
        LDA.w .chr, Y : STA.b $00
        
        LDY.b #$00
        
        .next_OAM_entry
        
            ; Force the chr to a certain value, and the palette of each entry
            ; to palette 1 (name table is also forced to 0 here).
            INY #2 : LDA.b $00                              : STA ($90), Y
            INY    : LDA ($90), Y : AND.b #$F0 : ORA.b #$02 : STA ($90), Y
        INY : CPY.b #$14 : BCC .next_OAM_entry
    
    .sprite_is_paused
    
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0DF0, X : BNE .cant_move_yet
        LDA.b #$30 : STA.w $0CD2, X
        
        ; The hunter is alive, but didn't get link yet.
        JSL.l Sprite_CheckDamageToPlayerLong : BCC .no_player_collision
            ; The hunter is dead, and it got Link to turn into a bunny.
            STZ.w $0DD0, X
            
            ; This useless load probably indicates a commented out store to the 
            ; countdown timer that would use 0x180 frames instead of 0x100.
            LDA.b #$80
            
            ; Set the tempbunny countdown timer to 0x100 frames.
                         STZ.w $03F5
            LDA.b #$01 : STA.w $03F6
            
        .no_player_collision
        
        ; Only adjust trajectory if player is on the same layer.
        LDA.b $EE : CMP.w $0F20, X : BNE .cant_track_player
            LDA.b #$10
            JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
        .cant_track_player
        
        JSR.w Sprite4_Move
        
        JSR.w Sprite4_CheckTileCollision : BEQ .no_tile_collision
            ; The transformer ran into a wall and died.
            STZ.w $0DD0, X
            
            JSL.l Sprite_SpawnPoofGarnish
            
            ; Selects a sound to play.
            LDA.b #$15 : JSL.l Sound_SetSfx2PanLong
    
        .no_tile_collision
    .cant_move_yet
    
    RTS
}

; ==============================================================================
