; ==============================================================================

; $0F3CE8-$0F3D22 JUMP LOCATION
Sprite_SpikeBlock:
{
    LDA.w $0E90, X : BNE Sprite_TransientSpikeBlock
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        JSR.w Sprite3_CheckIfActive
        JSR.w Sprite3_CheckDamage
        JSR.w Sprite3_Move
        JSR.w Sprite3_CheckTileCollision
        
        LDA.w $0DF0, X : BNE .ignore_collision
            JSR.w SpikeBlock_CheckStatueSpriteCollision : BCC .no_sprite_collision
                LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
            
            .no_sprite_collision
            
            LDA.b #$04 : STA.w $0DF0, X
            
            LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
            
            LDA.b #$05
            JSL.l Sound_SetSFX2PanLong
            
            .no_tile_collision
        .ignore_collision
        
        RTS
}

; ==============================================================================

; NOTE: Spike blocks created by Mothula end up here.
; $0F3D23-$0F3D4A BRANCH LOCATION
Sprite_TransientSpikeBlock:
{
    LDA.b #$04
    JSL.l OAM_AllocateFromRegionB
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0D80, X : BNE TransientSpikeBlock_Activated
        ; Transmute a bg-based spike block into a mobile one (this sprite),
        ; but erase the underlying bg-based one.
        LDY.b #$00
        JSR.w SpikeBlock_InduceTilemapUpdate
        
        INC.w $0D80, X
        
        LDA.b #$40 : STA.w $0DF0, X
        LDA.b #$69 : STA.w $0E00, X
        
        RTS
}

; ==============================================================================

; $0F3D4B-$0F3D4C DATA
TransientSpikeBlock_Activated_wiggle_x_speeds:
{
    db 8, -8
}

; $0F3D4D-$0F3D73 BRANCH LOCATION
TransientSpikeBlock_Activated:
{
    LDA.w $0DF0, X : BEQ TransientSpikeBlock_InMotion
        CMP.b #$01 : BNE .wiggling
            LDA.w $0D90, X : STA.w $0D10, X
            LDA.w $0DA0, X : STA.w $0D00, X
            
            RTS
            
        .wiggling
        
        ; NOTE: While this may look weird, what it does is it wiggles the spike
        ; block before it becomes fully detatched.
        LSR : AND.b #$01 : TAY
        LDA.w .wiggle_x_speeds, Y : STA.w $0D50, X
        
        JSR.w Sprite3_MoveHoriz
        
        STZ.w $0D50, X
        
        RTS
}

; ==============================================================================

; $0F3D74-$0F3D7F DATA
Pool_TransientSpikeBlock_InMotion:
{
    ; $0F3D74
    .target_x_speeds
    db 32, -32
    
    ; $0F3D76
    .target_y_speeds
    db  0,   0,  32, -32
    
    ; $0F3D7A
    .x_acceleration
    db  1,  -1
    
    ; $0F3D7C
    .y_acceleration
    db  0,   0,   1,  -1
}

; $0F3D80-$0F3DC7 BRANCH LOCATION
TransientSpikeBlock_InMotion:
{
    LDA.w $0D80, X : CMP.b #$01 : BNE TransientSpikeBlock_Retract
        ; NOTE: This branch will never be taken. But with an actual nonzero
        ; mask this could have been used to slow down the acceleration.
        LDA.b $1A : AND.b #$00 : BNE .acceleration_delay
            LDY.w $0DE0, X
            LDA.w $0D50, X
            CMP.w Pool_TransientSpikeBlock_InMotion_target_x_speeds, Y : BEQ .at_target_x_speed
                CLC : ADC Pool_TransientSpikeBlock_InMotion_x_acceleration, Y : STA.w $0D50, X
            
            .at_target_x_speed
            
            LDA.w $0D40, X
            CMP.w Pool_TransientSpikeBlock_InMotion_target_y_speeds, Y : BEQ .at_target_y_speed
                CLC : ADC Pool_TransientSpikeBlock_InMotion_y_acceleration, Y : STA.w $0D40, X
            
            .at_target_y_speed
        .acceleration_delay
        
        JSR.w Sprite3_Move
        
        LDA.w $0E00, X : BNE .skip_tile_collision_logic
            JSL.l Sprite_Get_16_bit_CoordsLong
            
            JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
                INC.w $0D80, X
                
                LDA.b #$40 : STA.w $0E00, X
                
            .no_tile_collision
        .skip_tile_collision_logic
        
        RTS
}

; ==============================================================================

; $0F3DC8-$0F3DCF DATA
Pool_TransientSpikeBlock_Retract:
{
    ; $0F3DC8
    .x_speeds
    db -16,  16,   0,   0
    
    ; $0F3DCC
    .y_speeds
    db   0,   0, -16,   0
}

; $0F3DD0-$0F3DFF BRANCH LOCATION
TransientSpikeBlock_Retract:
{
    ; NOTE: The spike block waits at its current position and then
    ; retracts back to where it spawned from.
    LDA.w $0E00, X : BNE .delay
        LDY.w $0DE0, X
        LDA.w Pool_TransientSpikeBlock_Retract_x_speeds, Y : STA.w $0D50, X
        LDA.w Pool_TransientSpikeBlock_Retract_y_speeds, Y : STA.w $0D40, X
        
        JSR.w Sprite3_Move
        
        LDA.w $0D10, X : CMP.w $0D90, X : BNE .not_at_target_coord
            LDA.w $0D00, X : CMP.w $0DA0, X : BNE .not_at_target_coord
                STZ.w $0DD0, X
                
                ; Place a bg-based spike block here as the sprite
                ; version terminates.
                LDY.b #$02
                JSR.w SpikeBlock_InduceTilemapUpdate
        
        .not_at_target_coord
    .delay
    
    RTS
}

; ==============================================================================

; $0F3E00-$0F3E18 LOCAL JUMP LOCATION
SpikeBlock_InduceTilemapUpdate:
{
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
    
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    JSL.l Dungeon_SpriteInducedTilemapUpdate
    
    RTS
}

; ==============================================================================

; This subroutine checks collisions between the sprite block and
; other selected sprites.
; $0F3E19-$0F3E7D LOCAL JUMP LOCATION
SpikeBlock_CheckStatueSpriteCollision:
{
    LDY.b #$0F
    
    .next_sprite_slot
    
        TYA : EOR.b $1A : AND.b #$01 : BNE .delay
            LDA.w $0DD0, Y : BEQ .inactive_sprite
                LDA.w $0E20, Y : CMP.b #$1C : BNE .not_movable_statue
                    LDA.w $0D10, X : STA.b $00
                    LDA.w $0D30, X : STA.b $01
                    
                    LDA.w $0D00, X : STA.b $02
                    LDA.w $0D20, X : STA.b $03
                    
                    LDA.w $0D10, Y : STA.b $04
                    LDA.w $0D30, Y : STA.b $05
                    
                    LDA.w $0D00, Y : STA.b $06
                    LDA.w $0D20, Y : STA.b $07
                    
                    REP #$20
                    
                    LDA.b $00 : SEC : SBC.b $04 : CLC : ADC.w #$0010
                    CMP.w #$0020 : BCS .no_collision
                        LDA.b $02 : SEC : SBC.b $06 : CLC : ADC.w #$0008
                        CMP.w #$0010 : BCS .no_collision
                            SEP #$20
                            
                            RTS
                            
                    .no_collision
                    
                    SEP #$20

                .not_movable_statue
            .inactive_sprite
        .delay
    DEY : BPL .next_sprite_slot
    
    SEC
    
    RTS
}

; ==============================================================================
