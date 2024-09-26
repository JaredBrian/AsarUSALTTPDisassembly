; ==============================================================================

; Middle aged guy in the desert
; $033CAC-$033CC8 JUMP LOCATION
Sprite_MiddleAgedMan:
{
    JSR.w MiddleAgedMan_Draw
    JSR.w Sprite_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw MiddleAgedMan_Chillin                      ; 0x00 - $BCC9
    dw MiddleAgedMan_TransitionToTagalong         ; 0x01 - $BD01
    dw MiddleAgedMan_OfferChestOpening            ; 0x02 - $BD20
    dw MiddleAgedMan_ReactToSecretKeepingResponse ; 0x03 - $BD46
    dw MiddleAgedMan_PromiseReminder              ; 0x04 - $BD8A
    dw MiddleAgedMan_SilenceDueToOtherTagalong    ; 0x05 - $BD93
}

; ==============================================================================

; $033CC9-$033D00 JUMP LOCATION
MiddleAgedMan_Chillin:
{
    ; "... .... ..... ......"
    LDA.b #$07
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    LDA.w $0D10, X : PHA
    
    SEC : SBC.b #$10 : STA.w $0D10, X
    
    JSR.w Sprite_Get_16_bit_Coords
    
    LDA.b #$01 : STA.w $0D50, X : STA.w $0D40, X
    
    JSL.l Sprite_CheckTileCollisionLong : BNE .sign_wasnt_taken
        INC.w $0D80, X
        
        LDA.l $7EF3CC : CMP.b #$00 : BEQ .player_lacks_tagalong
            LDA.b #$05 : STA.w $0D80, X
        
        .player_lacks_tagalong
    .sign_wasnt_taken
    
    PLA : STA.w $0D10, X
    
    RTS
}

; ==============================================================================

; $033D01-$033D1F JUMP LOCATION
MiddleAgedMan_TransitionToTagalong:
{
    LDA.b #$09 : STA.l $7EF3CC
    
    PHX
    
    STZ.w $02F9
    
    JSL.l Tagalong_LoadGfx
    JSL.l Tagalong_Init
    
    PLX
    
    LDA.b #$40 : STA.w $02CD
                 STZ.w $02CE
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $033D20-$033D45 JUMP LOCATION
MiddleAgedMan_OfferChestOpening:
{
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .return
        ; OPTIMIZE: He says the same thing regardless of whether the chest
        ; is close by.
        LDA.l $7EF3D3 : BEQ .chest_connected_to_player
            LDA.b #$09 ; Message from the middle aged man saying he'll open
            LDY.b #$01 ; the chest for you.
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .return
                BRA .advance_ai_state
            
        .chest_connected_to_player
        
        LDA.b #$09
        LDY.b #$01
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .return
            .advance_ai_state
            
            INC.w $0D80, X
        
    .return
    
    RTS
}

; ==============================================================================

; $033D46-$033D89 JUMP LOCATION
MiddleAgedMan_ReactToSecretKeepingResponse:
{
    LDA.w $1CE8 : BNE .angry_reply
        LDA.l $7EF3D3 : BEQ .chest_directly_connected_to_player
            LDA #$0C
            LDY #$01
            JSL.l Sprite_ShowMessageUnconditional
            
            LDA.b #$02 : STA.w $0D80, X
            
            RTS
        
        .chest_directly_connected_to_player
        
        ; Give Link an empty bottle... but from who? Middle aged guy?
        LDY.b #$16
        
        STZ.w $02E9
        
        JSL.l Link_ReceiveItem
        
        LDA.l $7EF3C9 : ORA.b #$10 : STA.l $7EF3C9
        
        INC.w $0D80, X
        
        LDA.b #$00 : STA.l $7EF3CC
        
        RTS
        
    .angry_reply
    
    ; "OK, ..., I hope you drag that chest around forever!"
    LDA.b #$0A
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    LDA.b #$02 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $033D8A-$033D92 JUMP LOCATION
MiddleAgedMan_PromiseReminder:
{
    ; "Remember, you promised... Don't tell anyone."
    LDA.b #$0B
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033D93-$033D9B JUMP LOCATION
MiddleAgedMan_SilenceDueToOtherTagalong:
{
    ; "... .... ..... ......"
    LDA.b #$07
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033D9C-$033DAB DATA
MiddleAgedMan_Draw_oam_groups:
{
    dw 0, -8 : db $EA, $00, $00, $02
    dw 0,  0 : db $EC, $00, $00, $02
}

; $033DAC-$033DC0 LOCAL JUMP LOCATION
MiddleAgedMan_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.b #.oam_groups    : STA.b $08
    LDA.b #.oam_groups>>8 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================
