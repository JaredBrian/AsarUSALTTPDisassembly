; ==============================================================================

; $06CB54-$06CB5B LONG JUMP LOCATION
Sprite_MazeGameLadyLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_MazeGameLady
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CB5C-$06CB7D LOCAL JUMP LOCATION
Sprite_MazeGameLady:
{
    JSL.l Lady_Draw
    JSR.w Sprite5_CheckIfActive
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSL.l Sprite_DirectionToFacePlayerLong : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw MazeGameLady_Startup           ; 0x00 - $CB7E
    dw MazeGameLady_PlayStartingNoise ; 0x01 - $CBE0
    dw MazeGameLady_AccumulateTime    ; 0x02 - $CBBA
}

; ==============================================================================

; $06CB7E-$06CBB9 JUMP LOCATION
MazeGameLady_Startup:
{
    LDA.w $0D10, X : CMP $22 : BCS .yous_a_cheater
        ; "... reach the goal within 15 seconds, we will give you something..."
        LDA.b #$CC
        LDY.b #$00
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
            STA.w $0EB0, X : STA.w $0DE0, X
            
            INC.w $0D80, X
            
            LDA.b #$00
            STA.l $7FFE00 : STA.l $7FFE01 : STA.l $7FFE02 : STA.l $7FFE03
            
            STZ.w $0D90, X
            
            STZ.w $0ABF
        
        .didnt_speak
        
        RTS
        
    .yous_a_cheater
    
    ; "You have to enter the maze from the proper entrance..."
    LDA.b #$D0
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact
    
    RTS
}

; ==============================================================================

; $06CBBA-$06CBDF JUMP LOCATION
MazeGameLady_AccumulateTime:
{
    INC.w $0D90, X : LDA.w $0D90, X : CMP.b #$3F : BNE .no_reset_frame_counter
        STZ.w $0D90, X
        
        REP #$20
        
        LDA.l $7FFE00 : INC : STA.l $7FFE00
        BNE .dont_increment_minute_counter
            LDA.l $7FFE02 : INC : STA.l $7FFE02
            
        .dont_increment_minute_counter
            
        SEP #$30
        
    .no_reset_frame_counter
    
    RTS
}

; ==============================================================================

; $06CBE0-$06CBE9 JUMP LOCATION
MazeGameLady_PlayStartingNoise:
{
    LDA.b #$07 : JSL.l Sound_SetSfx3PanLong
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================
