
; ==============================================================================

Pool_Sprite_RetreatBat:
; $0D75D5-$0D75D8 DATA
{
    db  1, -1
    
    ; $D75D7
    db  0, -1
}

; ==============================================================================

; \note Ganon bat that crashes into the pyramid of power.

; $0D75D9-$0D763C JUMP LOCATION
Sprite_RetreatBat:
{
    JSR RetreatBat_Draw
    JSR Sprite6_CheckIfActive
    JSL Sprite_MoveLong
    JSR RetreatBat_DrawSomethingElse
    
    STZ.w $011C
    STZ.w $011D
    
    LDA.w $0EE0, X : BEQ .BRANCH_ALPHA 
    
    DEC A : BNE .BRANCH_BETA
    
    LDY.b #$05 : STY.w $012D
    
    .BRANCH_BETA
    
    AND.b #$01 : TAY
    
    LDA.w $F5D5, Y : STA.w $011C
    LDA.w $F5D7, Y : STA.w $011D
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
    
    LDA.w $0DC0, X : INC A : AND.b #$03 : STA.w $0DC0, X : BNE .BRANCH_DELTA
    
    LDA.w $0D80, X : CMP.b #$02 : BCS .BRANCH_DELTA
    
    LDA.b #$03 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_DELTA
    
    LDY.w $0DE0, X
    
    LDA.w $F5A0, Y : STA.w $0DF0, X
    
    .BRANCH_GAMMA
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F63D ; = $D763D*
    dw $F684 ; = $D7684*
    dw $F6C8 ; = $D76C8* ; ???
    dw RetreatBat_FinishUp
}

; $0D763D-$0D7683 JUMP LOCATION
{
    LDA.w $0D90, X : ASL A : TAY
    
    REP #$20
    
    LDA.w $F590, Y : CMP.w $0FD8
    
    SEP #$30 : BCS .BRANCH_ALPHA
    
    CPY.b #$04 : BCC .BRANCH_BETA
    
    INC.w $0D80, X
    
    LDA.b #$D0 : STA.w $0E00, X
    
    .BRANCH_BETA
    
    INC.w $0D90, X
    INC.w $0DE0, X
    
    ; $0D7660 ALTERNATE ENTRY POINT
    .BRANCH_ALPHA
    
    LDA $1A : AND.b #$07 : BNE .BRANCH_GAMMA
    
    REP #$20
    
    LDA.w $F598, Y : CMP.w $0FDA : SEP #$30 : BCC .BRANCH_DELTA
    
    INC.w $0D40, X
    
    BRA .BRANCH_GAMMA
    
    .BRANCH_DELTA
    
    DEC.w $0D40, X
    
    .BRANCH_GAMMA
    
    LDA $1A : AND.b #$0F : BNE .BRANCH_EPSILON
    
    INC.w $0D50, X
    
    .BRANCH_EPSILON
    
    RTS
}

; $0D7684-$0D76C7 JUMP LOCATION
{
    LDA.w $0E00, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$26 : JSL Sound_SetSfx3PanLong
    
    INC.w $0DE0, X
    
    LDA.b #$E8 : STA.w $0D10, X
    LDA.b #$07 : STA.w $0D30, X
    LDA.b #$E0 : STA.w $0D00, X
    LDA.b #$05 : STA.w $0D20, X
    
    STZ.w $0D50, X
    
    LDA.b #$40 : STA.w $0D40, X
    LDA.b #$2D : STA.w $0E00, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA $1A : AND.b #$03 : BNE .BRANCH_BETA
    
    DEC.w $0D50, X
    
    .BRANCH_BETA
    
    LDA.w $0D90, X : ASL A : TAY
    
    JMP.w $F660 ; $0D7660 IN ROM
}


; $0D76C8-$0D76E8 JUMP LOCATION
{
    LDA.w $0E00, X : BNE .advancement_delay
    
    STZ.w $0D40, X
    
    LDA.b #$60 : STA.w $0E00, X
    
    INC.w $0D80, X
    
    .advancement_delay
    
    LDA.w $0E00, X : CMP.b #$09 : BNE .smash_delay
    
    JSR RetreatBat_SpawnPyramidDebris
    
    PHX
    
    JSL Overworld_CreatePyramidHole
    
    PLX
    
    .smash_delay
    
    RTS
}

; ==============================================================================

; $0D76E9-$0D76F4 JUMP LOCATION
RetreatBat_FinishUp:
{
    LDA.w $0E00, X : BNE .delay
    
    STZ.w $0DD0, X
    
    ; This allows the GanonEmerges module to continue on and let the player
    ; land on the pyramid.
    INC.w $0200

    .delay

    RTS
}

; ==============================================================================

; $0D76F5-$0D772F LONG
GanonEmerges_SpawnRetreatBat:
{
    ; Create the bat to break into Pyramid of Power
    
    LDA.b #$37 : JSL Sprite_SpawnDynamically
    
    LDA.b #$00 : STA.w $0D40, Y
                 STA.w $0DA0, Y
                 STA.w $0DE0, Y
                 STA.w $0F20, Y
    
    INC A : STA.w $0E80, Y
            STA.w $0E40, Y
            STA.w $0E60, Y
            STA.w $0F50, Y
    
    LDA.b #$CC : STA.w $0D10, Y
    LDA.b #$07 : STA.w $0D30, Y
    
    LDA.b #$32 : STA.w $0D00, Y
    LDA.b #$06 : STA.w $0D20, Y
    
    LDA.b #$80 : STA.w $0CAA, Y
    
    RTL
}

; ==============================================================================

; $0D7730-$0D774F DATA
Pool_RetreatBat_DrawSomethingElse:
{
    .oam_entries
    db $68, $97, $57, $01
    db $78, $97, $57, $01
    db $88, $97, $57, $01
    
    db $68, $A7, $57, $01
    db $78, $A7, $57, $01
    db $88, $A7, $57, $01
    
    db $65, $90, $57, $01
    db $8B, $90, $57, $01        
}

; ==============================================================================

; $0D7750-$0D776C LOCAL JUMP LOCATION
RetreatBat_DrawSomethingElse:
{
    ; This something esle is a sprite mask that is placed directly below the hole on the pyramid.
    ; It is used to block out the bat's sprite so that it doesn't appear to go over the whole and instead into it.
    REP #$20
    
    LDY.b #$20
    
    .write_oam_low_buffer_entries
    
    LDA .oam_entries - 2, Y : STA.w $092E, Y
    
    DEY #2 : BNE .write_oam_low_buffer_entries
    
    LDY.b #$08
    
    ; Use all large oam-sized sprites.
    LDA.w #$0202
    
    .write_oam_high_buffer_entries
    
    STA.w $0A6C, Y
    
    DEY #2 : BPL .write_oam_high_buffer_entries
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0D77E5-$0D7809 LOCAL JUMP LOCATION
RetreatBat_SpawnPyramidDebris:
{
    LDY.b #$1D
    
    .spawn_another
    
    LDA.w $F76D, Y : STA $00
    LDA.w $F78B, Y : STA $01
    
    LDA.w $F7A9, Y : STA $02
    LDA.w $F7C7, Y : STA $03
    
    PHY
    
    JSL Garnish_SpawnPyramidDebris
    
    PLY : DEY : BPL .spawn_another
    
    LDA.b #$20 : STA.w $0EE0, X
    
    RTS
}

; ==============================================================================

; $0D780A-$0D7832 DATA
Pool_RetreatBat_Draw:
{
    .ptr_low_bytes
    db $00, $00, $08, $08, $10, $10, $18, $18
    db $20, $20, $30, $30, $40, $50, $60, $50
    db $70, $70, $70, $70
    
    .ptr_high_byte
    db $F5
    
    .num_oam_entries
    db 1, 1, 1, 1, 1, 1, 1, 1
    db 2, 2, 2, 2, 2, 2, 2, 2
    db 4, 4, 4, 4
}

; ==============================================================================

; $0D7833-$0D785B LOCAL JUMP LOCATION
RetreatBat_Draw:
{
    REP #$20
    
    LDA.w #$0960 : STA $90
    LDA.w #$0A78 : STA $92
    
    SEP #$20
    
    LDA.w $0DE0, X : ASL #2 : ADC.w $0DC0, X : TAY
    
    LDA .ptr_low_bytes, Y : STA $08
    LDA .ptr_high_byte    : STA $09
    
    LDA .num_oam_entries, Y : JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================
