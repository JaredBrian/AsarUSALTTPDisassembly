; ==============================================================================

; $0D75D5-$0D75D8 DATA
Pool_Sprite_RetreatBat:
{
    ; $0D75D5
    .shake_low
    db  1, -1
    
    ; $0D75D7
    .shake_high
    db  0, -1
}

; NOTE: Ganon bat that crashes into the pyramid of power.
; $0D75D9-$0D763C JUMP LOCATION
Sprite_RetreatBat:
{
    JSR.w RetreatBat_Draw
    JSR.w Sprite6_CheckIfActive
    JSL.l Sprite_MoveLong
    JSR.w RetreatBat_DrawOAMMask
    
    STZ.w $011C
    STZ.w $011D
    
    LDA.w $0EE0, X : BEQ .BRANCH_ALPHA 
        DEC : BNE .BRANCH_BETA
            LDY.b #$05 : STY.w $012D
        
        .BRANCH_BETA
        
        AND.b #$01 : TAY
        
        LDA.w Pool_Sprite_RetreatBat_shake_low, Y  : STA.w $011C
        LDA.w Pool_Sprite_RetreatBat_shake_high, Y : STA.w $011D
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
        LDA.w $0DC0, X : INC : AND.b #$03 : STA.w $0DC0, X : BNE .BRANCH_DELTA
            LDA.w $0D80, X : CMP.b #$02 : BCS .BRANCH_DELTA
                LDA.b #$03 : JSL.l Sound_SetSfx2PanLong
            
        .BRANCH_DELTA
        
        LDY.w $0DE0, X
        
        LDA.w Pool_BatCrash_Approach_anim_timer, Y : STA.w $0DF0, X
    
    .BRANCH_GAMMA
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw BatCrash_Approach   ; 0x00 - $F63D
    dw BatCrash_Ascend     ; 0x01 - $F684
    dw BatCrash_DiveBomb   ; 0x02 - $F6C8
    dw RetreatBat_FinishUp ; 0x03 - $F6E9
}

; $0D763D-$0D765F JUMP LOCATION
BatCrash_Approach:
{
    LDA.w $0D90, X : ASL : TAY
    
    REP #$20
    
    LDA.w Pool_BatCrash_Approach_position_x, Y : CMP.w $0FD8
    
    SEP #$30 : BCS .BRANCH_ALPHA
        CPY.b #$04 : BCC .BRANCH_BETA
            INC.w $0D80, X
            
            LDA.b #$D0 : STA.w $0E00, X
            
        .BRANCH_BETA
        
        INC.w $0D90, X
        INC.w $0DE0, X

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $0D7660-$0D7683 JUMP LOCATION
BatCrash_HandleYMovement:
{
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_GAMMA
        REP #$20
        
        LDA.w Pool_BatCrash_Approach_position_y, Y : CMP.w $0FDA : SEP #$30 : BCC .BRANCH_DELTA
            INC.w $0D40, X
            
            BRA .BRANCH_GAMMA
            
        .BRANCH_DELTA
        
        DEC.w $0D40, X
        
    .BRANCH_GAMMA
    
    LDA.b $1A : AND.b #$0F : BNE .BRANCH_EPSILON
        INC.w $0D50, X
    
    .BRANCH_EPSILON
    
    RTS
}

; $0D7684-$0D76C7 JUMP LOCATION
BatCrash_Ascend:
{
    LDA.w $0E00, X : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        LDA.b #$26 : JSL.l Sound_SetSfx3PanLong
        
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
    
    LDA.b $1A : AND.b #$03 : BNE .BRANCH_BETA
        DEC.w $0D50, X
    
    .BRANCH_BETA
    
    LDA.w $0D90, X : ASL : TAY
    
    JMP.w BatCrash_HandleYMovement
}


; $0D76C8-$0D76E8 JUMP LOCATION
BatCrash_DiveBomb:
{
    LDA.w $0E00, X : BNE .advancement_delay
        STZ.w $0D40, X
        
        LDA.b #$60 : STA.w $0E00, X
        
        INC.w $0D80, X
        
    .advancement_delay
    
    LDA.w $0E00, X : CMP.b #$09 : BNE .smash_delay
        JSR.w RetreatBat_SpawnPyramidDebris
        
        PHX
        
        JSL.l Overworld_CreatePyramidHole
        
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

; Create the bat to break into Pyramid of Power
; $0D76F5-$0D772F LONG
GanonEmerges_SpawnRetreatBat:
{
    LDA.b #$37 : JSL.l Sprite_SpawnDynamically
    
    LDA.b #$00 : STA.w $0D40, Y
                 STA.w $0DA0, Y
                 STA.w $0DE0, Y
                 STA.w $0F20, Y
    
    INC : STA.w $0E80, Y
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
RetreatBat_DrawOAMMask_OAM_entries:
{
    db $68, $97, $57, $01
    db $78, $97, $57, $01
    db $88, $97, $57, $01
    
    db $68, $A7, $57, $01
    db $78, $A7, $57, $01
    db $88, $A7, $57, $01
    
    db $65, $90, $57, $01
    db $8B, $90, $57, $01        
}

; This is a OAM sprite mask that is placed directly below the hole on
; the pyramid. It is used to block out the bat's OAM so that it doesn't
; appear to go over the hole and instead into it.
; $0D7750-$0D776C LOCAL JUMP LOCATION
RetreatBat_DrawOAMMask:
{
    REP #$20
    
    LDY.b #$20
    
    .write_OAM_low_buffer_entries
    
        LDA.w .OAM_entries - 2, Y : STA.w $092E, Y
    DEY #2 : BNE .write_OAM_low_buffer_entries
    
    LDY.b #$08
    
    ; Use all large OAM-sized sprites.
    LDA.w #$0202
    
    .write_OAM_high_buffer_entries
    
        STA.w $0A6C, Y
    DEY #2 : BPL .write_OAM_high_buffer_entries
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0D776D-$0D77E4 DATA
Pool_RetreatBat_SpawnPyramidDebris:
{
    ; $0D776D
    .offset_x
    db  -8,   0,   8,  16,  24,  32
    db  -8,   0,   8,  16,  24,  32
    db  -8,   0,   8,  16,  24,  32
    db  -8,   0,   8,  16,  24,  32
    db  -8,   0,   8,  16,  24,  32

    ; $0D778B
    .offset_y
    db  48,  48,  48,  48,  48,  48
    db  40,  40,  40,  40,  40,  40
    db  32,  32,  32,  32,  32,  32
    db  24,  24,  24,  24,  24,  24
    db  16,  16,  16,  16,  16,  16

    ; $0D77A9
    .speed_x
    db $E2, $E7, $F8, $08, $19, $1E
    db $CE, $D3, $EC, $14, $2D, $32
    db $CE, $DD, $E7, $19, $23, $32
    db $D3, $CE, $C4, $3C, $32, $2D
    db $E2, $DD, $D8, $28, $23, $1E

    ; $0D77C7
    .speed_y
    db $02, $05, $0A, $0A, $05, $02
    db $05, $14, $1E, $1E, $14, $05
    db $0A, $1E, $28, $28, $1E, $0A
    db $EC, $D8, $C4, $C4, $D8, $EC
    db $F6, $EC, $D8, $D8, $EC, $F6
}

; $0D77E5-$0D7809 LOCAL JUMP LOCATION
RetreatBat_SpawnPyramidDebris:
{
    LDY.b #$1D
    
    .spawn_another
    
        LDA.w Pool_RetreatBat_SpawnPyramidDebris_offset_x, Y : STA.b $00
        LDA.w Pool_RetreatBat_SpawnPyramidDebris_offset_y, Y : STA.b $01
        
        LDA.w Pool_RetreatBat_SpawnPyramidDebris_speed_x, Y : STA.b $02
        LDA.w Pool_RetreatBat_SpawnPyramidDebris_speed_y, Y : STA.b $03
        
        PHY
        
        JSL.l Garnish_SpawnPyramidDebris
    PLY : DEY : BPL .spawn_another
    
    LDA.b #$20 : STA.w $0EE0, X
    
    RTS
}

; ==============================================================================

; $0D780A-$0D7832 DATA
Pool_RetreatBat_Draw:
{
    ; TODO: Update these pointers to use a label instead.
    ; $0D780A
    .ptr_low_bytes
    db $00, $00, $08, $08, $10, $10, $18, $18
    db $20, $20, $30, $30, $40, $50, $60, $50
    db $70, $70, $70, $70
    
    ; $0D781E
    .ptr_high_byte
    db $F5
    
    ; $0D781F
    .num_OAM_entries
    db 1, 1, 1, 1, 1, 1, 1, 1
    db 2, 2, 2, 2, 2, 2, 2, 2
    db 4, 4, 4, 4
}

; $0D7833-$0D785B LOCAL JUMP LOCATION
RetreatBat_Draw:
{
    REP #$20
    
    LDA.w #$0960 : STA.b $90
    LDA.w #$0A78 : STA.b $92
    
    SEP #$20
    
    LDA.w $0DE0, X : ASL #2 : ADC.w $0DC0, X : TAY
    
    LDA.w Pool_RetreatBat_Draw_ptr_low_bytes, Y : STA.b $08
    LDA.w Pool_RetreatBat_Draw_ptr_high_byte    : STA.b $09
    
    LDA.w Pool_RetreatBat_Draw_num_OAM_entries, Y : JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================
