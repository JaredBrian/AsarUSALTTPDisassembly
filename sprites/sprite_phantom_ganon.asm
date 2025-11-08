; ==============================================================================

; $0E88A1-$0E88BB LONG JUMP LOCATION
Sprite_SpawnPhantomGanon:
{
    ; Spawn one of Ganon's bats? Emerges from Agahnim, seems like.
    LDA.b #$C9
    JSL.l Sprite_SpawnDynamically
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b #$02 : STA.w $0E40, Y
                 STA.w $0BA0, Y
    DEC        : STA.w $0EC0, Y
    DEC        : STA.w $0F50, Y
    
    RTL
}

; ==============================================================================

; $0E88BC-$0E8905 JUMP LOCATION
Sprite_PhantomGanon:
{
    LDA.w $0D80, X : BNE Sprite_GanonBat
        JSR.w PhantomGanon_Draw
        JSR.w Sprite4_CheckIfActive
        JSR.w Sprite4_MoveVert
        
        INC.w $0E80, X
        
        LDA.w $0E80, X : AND.b #$1F : BNE .delay
            DEC.w $0D40, X
            LDA.w $0D40, X : CMP.b #$FC : BNE .BRANCH_BETA
                PHA
                
                JSR.w Blind_SpawnPoof
                
                LDA.w $0D00, Y : SEC : SBC.b #$14 : STA.w $0D00, Y
                LDA.w $0D20, Y :       SBC.b #$00 : STA.w $0D20, Y
                
                PLA
                
            .BRANCH_BETA
            
            CMP.b #$FB : BNE .dont_transform
                INC.w $0D80, X
                
                LDA.b #$FF : STA.w $0DF0, X
                LDA.b #$FC : STA.w $0D40, X
            
            .dont_transform
        .delay
        
        RTS
}

; ==============================================================================

; $0E8906-$0E8A03
incsrc "sprite_ganon_bat.asm"

; ==============================================================================

; $0E8A04-$0E8A83 DATA
PhantomGanon_Draw_OAM_groups:
{
    dw -16, -8 : db $46, $0D, $00, $02
    dw  -8, -8 : db $47, $0D, $00, $02
    dw   8, -8 : db $47, $4D, $00, $02
    dw  16, -8 : db $46, $4D, $00, $02
    dw -16,  8 : db $69, $0D, $00, $02
    dw  -8,  8 : db $6A, $0D, $00, $02
    dw   8,  8 : db $6A, $4D, $00, $02
    dw  16,  8 : db $69, $4D, $00, $02
    
    dw -16, -8 : db $46, $0D, $00, $02
    dw  -8, -8 : db $47, $0D, $00, $02
    dw   8, -8 : db $47, $4D, $00, $02
    dw  16, -8 : db $46, $4D, $00, $02
    dw -16,  8 : db $66, $0D, $00, $02
    dw  -8,  8 : db $67, $0D, $00, $02
    dw   8,  8 : db $67, $4D, $00, $02
    dw  16,  8 : db $66, $4D, $00, $02
}

; $0E8A84-$0E8AA8 LOCAL JUMP LOCATION
PhantomGanon_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #6 : CLC : ADC.w #(.OAM_groups) : STA.b $08
    
    LDA.w #$0950 : STA.b $90
    LDA.w #$0A74 : STA.b $92
    
    SEP #$20
    
    LDA.b #$08
    JMP Sprite4_DrawMultiple
}

; $0E8AA9-$0E8AB5 LOCAL JUMP LOCATION
Sprite_PeriodicWhirringSFX:
{
    LDA.b $1A : AND.b #$0F : BNE .shadow_flicker
        LDA.b #$06
        JSL.l Sound_SetSFX3PanLong
    
    .shadow_flicker
    
    RTS
}

; ==============================================================================
