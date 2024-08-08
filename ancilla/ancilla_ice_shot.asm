
; ==============================================================================

; $0424DD-$042535 JUMP LOCATION
    shared Ancilla_IceShot:
{
    LDA $11 : BEQ .normal_submode
    
    BRA .generate_sparkle
    
    .normal_submode
    
    DEC.w $03B1, X : BPL .delay
    
    LDA.w $0C5E, X : INC A : STA.w $0C5E, X : AND.b #$FE : BEQ .delay_2
    
    ; Once this flag goes high, it stays high, and it indicates that
    ; movement and collision checking need to begin being handled.
    ; This seems to produce that semi-halted look that the ice beam shot
    ; has when firing the rod (for a short time).
    LDA.b #$01 : STA.w $0C54, X
    
    LDA.w $0C5E, X : AND.b #$07 : ORA.b #$04 : STA.w $0C5E, X
    
    .delay_2
    
    LDA.b #$03 : STA.w $03B1, X
    
    .delay
    
    LDA.w $0C54, X : BEQ .ignore_movement_and_collision
    
    JSR.w Ancilla_BoundsCheck
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    
    JSR.w Ancilla_CheckSpriteCollision : BCS .collided
    
    JSR.w Ancilla_CheckTileCollision : BCC .no_collision
    
    .collided
    
    ; Transmute this object into a different object, which is that of
    ; the ice shot dissipating (due to hitting something).
    ; That object is called Ancilla_IceShotSpread.
    LDA.b #$11 : STA.w $0C4A, X : TAY
    
    LDA.w $806F, Y : STA.w $0C90, X
    
    STZ.w $0C5E, X
    
    LDA.b #$04 : STA.w $03B1, X
    
    .no_collision
    .ignore_movement_and_collision
    
    BRL IceShotSparkle_Spawn
}

; ==============================================================================
