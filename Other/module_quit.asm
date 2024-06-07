
; ==============================================================================

; $04F79B-$04F79E Jump Table
Pool_Module_Quit:
{
    .submodules
    dw Quit_IndicateHaltedState
    dw Quit_FadeOut
}

; ==============================================================================

; $04F79F-$04F7AE LONG JUMP LOCATION
Module_Quit:
{
    ; Beginning of Module 0x17, Restart Mode
    
    LDA $11 : ASL A : TAX
    
    JSR (.submodules, X)
    
    JSL Sprite_Main
    JSL PlayerOam_Main
    
    RTL
}

; ==============================================================================

; $04F7AF-$04F7BF LOCAL JUMP LOCATION
Quit_IndicateHaltedState:
{
    INC $11
    
    ; $04F7B1 ALTERNATE ENTRY POINT
    shared Quit_FadeOut:
    
    DEC $13 : BNE Death_RestoreScreenPostRevival.return
    
    ; Once the screen fades out it's time to save game state and restart,
    ; essentially.
    LDA.b #$0F : STA $95
    
    LDA.b #$01 : STA $B0
    
    JMP.w $F50F ; $04F50F IN ROM
}

; ==============================================================================
