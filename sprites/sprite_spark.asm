; ==============================================================================

; $029333-$02933E DATA
Pool_Sprite_Spark:
{
    ; $029333
    .vh_flip
    db $00, $40, $80, $C0
    
    ; $029337
    .directions
    db 1, 3, 2, 0
    db 7, 5, 6, 4 ; Clockwise directions? wtf?
}

; $02933F-$02940D JUMP LOCATION
Sprite_Spark:
{
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    LDA.b $1A : AND.b #$01 : BNE .dont_toggle_palette
        LDA.w $0F50, X : EOR.b #$06 : STA.w $0F50, X
    
    .dont_toggle_palette
    
    LDA.w $0D80, X : BNE .direction_initialized
        INC.w $0D80, X
        
        LDA.b #$01 : STA.w $0D40, X
                     STA.w $0D50, X
        
        JSR.w Sprite2_CheckTileCollision
        
        PHA
        
        LDA.b #$FF : STA.w $0D40, X : STA.w $0D50, X
        
        JSR.w Sprite2_CheckTileCollision
        
        PLA : ORA.w $0E70, X : CMP.b #$04 : BCS .collided_up_or_down
            LDY.b #$00
            
            AND.b #$01 : BNE .collided_right
                INY
            
            .collided_right
            
            BRA .moving_on
        
        .collided_up_or_down
        
        LDY.b #$02
        
        AND.b #$04 : BNE .collided_downwards
            INY
        
        .collided_downwards
        
        LDA.w $0E20, X : CMP.b #$5C : BEQ .travels_counterclockwise
            ; And the opposite of that is... you guessed it, clockwise.
            INY #4
        
        .travels_counterclockwise
        
        LDA.w Pool_Sprite_Spark_directions, Y : STA.w $0DE0, X
        
    .direction_initialized
    
    LDA.b $1A : LSR #2 : AND.b #$03 : TAY
    
    ; Interesting.... its v and h flip settings are cyclical?
    LDA.w $0F50, X
    AND.b #$3F : ORA Pool_Sprite_Spark_vh_flip, Y : STA.w $0F50, X
    
    JSR.w Sprite2_Move
    JSL.l Sprite_CheckDamageToPlayerLong
    
    LDY.w $0DE0, X
    
    LDA Probe_x_checked_directions, Y : STA.w $0D50, X
    LDA Probe_y_checked_directions, Y : STA.w $0D40, X
    
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0E10, X : BEQ .check_orthogonal_collision
        CMP.b #$06 : BNE .check_collinear_collision
            LDY.w $0DE0, X
            
            ; Has us temporarily move in a direction that is opposite to the
            ; usual orientation of the sprite. This is because we have run out
            ; of wall to adhere to on our near side, and have to find a new wall
            ; to adhere to, so we turn towards the orthogonal direction.
            LDA Probe_orthogonal_next_direction, Y : STA.w $0DE0, X
            
            BRA .check_collinear_collision
        
    .check_orthogonal_collision
    
    ; We check the orthogonal direction of the wall that we're supposed
    ; to be adhering to. If we have lost track of that directino we will
    ; end up having to do a termporary change of rotation to seek out
    ; a new wall to adhere to (in effect, momentarily switching from
    ; clockwise to counterclockwise or vice versa.
    LDY.w $0DE0, X
    
    LDA.w $0E70, X
    
    AND Probe_orthogonal_directions, Y : BNE .has_orthogonal_collision
        LDA.b #$0A : STA.w $0E10, X
    
    .has_orthogonal_collision
    .check_collinear_collision
    
    LDY.w $0DE0, X
    
    LDA.w $0E70, X
    
    AND Probe_collinear_directions, Y : BEQ .no_collinear_collision
        LDA Probe_collinear_next_direction, Y : STA.w $0DE0, X
    
    .no_collinear_collision
    
    LDY.w $0DE0, X
    
    LDA Probe_x_speeds, Y : ASL : STA.w $0D50, X
    
    LDA Probe_y_speeds, Y : ASL : STA.w $0D40, X
    
    RTS
}

; ==============================================================================
