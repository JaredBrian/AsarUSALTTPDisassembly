; ==============================================================================

; $06CBEA-$06CBF1 LONG JUMP LOCATION
Sprite_MazeGameGuyLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_MazeGameGuy
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CBF2-$06CC2C LOCAL JUMP LOCATION
Sprite_MazeGameGuy:
{
    JSL.l MazeGameGuy_Draw
    JSR.w Sprite5_CheckIfActive
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    STZ.w $0EB0, X
    
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    ; Check if the event has been initialized.
    LDA.w $0ABF : BNE .yous_a_cheater
        LDA.w $0D80, X
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw MazeGameGuy_ParseElapsedTime         ; 0x00 - $CC2D
        dw MazeGameGuy_CheckPlayerQualification ; 0x01 - $CCA7
        dw MazeGameGuy_SorryCantHaveIt          ; 0x02 - $CCF4
        dw MazeGameGuy_YouCanHaveIt             ; 0x03 - $CD05
        dw MazeGameGuy_NothingMoreToGive        ; 0x04 - $CD16
        
    .yous_a_cheater
    
    ; "You Have to enter the maze from the proper entrance or I can't..."
    LDA.b #$D0
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact
    
    RTS
}

; ==============================================================================

; $06CC2D-$06CCA6 JUMP LOCATION
MazeGameGuy_ParseElapsedTime:
{
    REP #$20
    
    LDA.l $7FFE00 : STA.l $7FFE04
    LDA.l $7FFE02 : STA.l $7FFE06
    
    STZ.b $00
    STZ.b $02
    STZ.b $04
    STZ.b $06
    
    ; NOTE: This series of loops extracts the number of minutes (up to 599 
    ; minutes) and seconds it took to complete the maze. Interestingly
    ; enough, if you are patient enough to wait 599 minutes and 59 seconds
    ; and then immediately walk right over to the guy he'll give you the
    ; heart piece as this is a modulo operation which would loop at 100
    ; minutes.
    LDA.l $7FFE04
    
    .modulo_6000_loop
        
        CMP.w #6000 : BCC .exhausted_modulo_6000
            SBC.w #6000
    BRA .modulo_6000_loop
    
    .exhausted_modulo_6000
    
    .modulo_600_loop
    
        CMP.w #600 : BCC .exhausted_modulo_600
            SBC.w #600
            
            INC.b $06
    BRA .modulo_600_loop
    
    .exhausted_modulo_600
    
    .modulo_60_loop
    
        CMP.w #60 : BCC .exhausted_modulo_60
            SBC.w #60
            
            INC.b $04
            
            BRA .modulo_60_loop
    .exhausted_modulo_60
    
    .modulo_10_loop
    
        CMP.w #10 : BCC .exhausted_modulo_10
            SBC.w #10
            
            INC.b $02
    BRA .modulo_10_loop
    
    .exhausted_modulo_10
    
    ; The last digit is a number from 0 to 9.
    STA.b $00
    
    SEP #$30
    
    LDA.b $02 : ASL #4 : ORA.b $00 : STA.w $1CF2
    LDA.b $06 : ASL #4 : ORA.b $04 : STA.w $1CF3
    
    LDA.b #$CB
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
        STA.w $0DE0, X : STA.w $0EB0, X
        
        INC.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06CCA7-$06CCF3 JUMP LOCATION
MazeGameGuy_CheckPlayerQualification:
{
    INC.w $0D80, X
    
    TXY
    
    LDX.b $8A
    
    LDA.l $7EF280, X : TYX : AND.b #$40 : BEQ .heart_piece_not_acquired
        INC.w $0D80, X : INC.w $0D80, X
        
        ; "I don't have anything more to give you. I'm sorry!"
        LDA.b #$CF
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        RTS
        
    .heart_piece_not_acquired
    
    LDA.l $7FFE05              : BNE .player_took_too_long
    LDA.l $7FFE04 : CMP.b #$10 : BCS .player_took_too_long
        INC.w $0D80, X
        
        ; "... Congratulations! I present you with a piece of Heart!"
        LDA.b #$CD
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        STA.w $0EB0, X : STA.w $0DE0, X
        
        RTS
        
        .player_took_too_long
    
    ; "You're not qualified. Too bad! Why don't you try again?"
    LDA.b #$CE
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STA.w $0EB0, X : STA.w $0DE0, X
    
    RTS
}

; ==============================================================================

; $06CCF4-$06CD04 JUMP LOCATION
MazeGameGuy_SorryCantHaveIt:
{
    ; "You're not qualified. Too bad! Why don't you try again?"
    LDA.b #$CE
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
        STA.w $0EB0, X : STA.w $0DE0, X
        
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06CD05-$06CD15 JUMP LOCATION
MazeGameGuy_YouCanHaveIt:
{
    ; "... Congratulations! I present you with a piece of Heart!"
    LDA.b #$CD
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        STA.w $0EB0, X : STA.w $0DE0, X
        
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06CD16-$06CD26 JUMP LOCATION
MazeGameGuy_NothingMoreToGive:
{
    ; "I don't have anything more to give you. I'm sorry!"
    LDA.b #$CF
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        STA.w $0EB0, X : STA.w $0DE0, X
        
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06CD27-$06CDA6 DATA
MazeGameGuy_Draw_OAM_groups:
{
    dw 0, -10 : db $00, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $00, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $00, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $00, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $02, $40, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $02, $40, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $02, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
    
    dw 0, -10 : db $02, $00, $00, $02
    dw 0,   0 : db $20, $00, $00, $02
   }

; $06CDA7-$06CDCE LONG JUMP LOCATION
MazeGameGuy_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #4
    
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================
