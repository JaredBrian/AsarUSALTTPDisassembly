; ==============================================================================

; $0F7632-$0F76A0 JUMP LOCATION
Pipe_LocateTransitTile:
{
    ; Not really certain whether this is necessary.
    LDA.b #$FF : STA.w $1DE0
    
    LDA.w $0E20, X : SEC : SBC.b #$AE : STA.w $0DE0, X

    ; Bleeds into the next function.
}
    
; $0F7640-$0F76A0 JUMP LOCATION
SomariaPlatform_LocateTransitTile:
{
    .try_another_tile
    
        ; Get the tile type the sprite interacted with.
        JSR.w SomariaPlatformAndPipe_CheckTile : STA.w $0E90, X
        
        SEC : SBC.b #$B0 : BCS .is_upper_tile
            .not_pipe_tile
            
            LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
            LDA.w $0D30, X       : ADC.b #$00 : STA.w $0D30, X
            
            LDA.w $0D00, X : CLC : ADC.b #$08 : STA.w $0D00, X
            LDA.w $0D20, X       : ADC.b #$00 : STA.w $0D20, X
            
            ; BUG: This seems to have the potential to crash the game if the pipe
            ; sprite is used in a room it should be used in.
    BRA .try_another_tile
    
    .is_upper_tile
    
    CMP.b #$0F : BCS .not_pipe_tile
    
    ; Reaching this address means that we were able to find a special tile
    ; (0xB0 to 0xBE) to bind to, somewhere in the map.
    LDA.w $0D10, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.w $0D10, X
    LDA.w $0D00, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.w $0D00, X
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w SomariaPlatformAndPipe_HandleMovement
    
    INC.w $0BA0, X
    
    STZ.w $02F5
    
    LDA.b #$0E : STA.w $0F10, X
    
    INC.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F76A1-$0F76A8 LONG JUMP LOCATION
Sprite_SomariaPlatformLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SomariaPlatform
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F76A9-$0F76D3 DATA
Pool_SomariaPlatformAndPipe:
{
    ; $0F76A9
    .x_speeds
    db $00, $00, $F0, $10
    db $F0, $10, $10
    
    ; $0F76B0
    .y_speeds
    db $F0, $10, $00, $00
    db $F0, $10, $F0, $10
    
    ; $0F76B8
    .drag_x_high
    db $00, $00, $FF, $00, $FF
    
    ; $0F76BD
    .drag_x_low
    db $00, $00, $FF, $01 , $FF, $01, $01

    ; $0F76C4
    .drag_y_low
    db $FF, $01, $00, $00, $FF, $01, $FF, $01

    ; $0F76CC
    .drag_y_high
    db $FF, $00, $00, $00, $FF, $00, $FF, $00
}

; ==============================================================================

; Sprite types 0xED, 0xEF, $F0, and $F1 (cane of somaria platform)
; $0F76D4-$0F76DE LOCAL JUMP LOCATION
Sprite_SomariaPlatform:
{
    LDA.w $0DC0, X
    JSL.l UseImplicitRegIndexedLocalJumpTable  
    dw SomariaPlatform_Spawn       ; 0x00 - $F6DF
    dw SomariaPlatformAndPipe_Main ; 0x01 - $F709
}

; ==============================================================================

; $0F76DF-$0F7708 JUMP LOCATION
SomariaPlatform_Spawn:
{
    JSR.w SomariaPlatform_LocateTransitTile
    JSL.l Sprite_SpawnSuperficialBombBlast
    
    ; OPTIMIZE: Remove these - 0.
    ; X coordinate -= 0x08
    LDA.w $0D10, Y : SEC : SBC.b #$08 : STA.w $0D10, Y
    LDA.w $0D30, Y       : SBC.b #$00 : STA.w $0D30, Y
    
    ; Y coordinate -= 0x08
    LDA.w $0D00, Y : SEC : SBC.b #$08 : STA.w $0D00, Y
    LDA.w $0D20, Y       : SBC.b #$00 : STA.w $0D20, Y
    
    RTS
}

; ==============================================================================

; $0F7709-$0F77A2 JUMP LOCATION
SomariaPlatformAndPipe_Main:
{
    JSR.w SpriteDraw_SomariaPlatform
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0B7C : ORA.w $0B7D : ORA.w $0B7E : ORA.w $0B7F : BEQ .BRANCH_ALPHA
        .BRANCH_BETA
            
        JMP.w SomariaPlatform_Inactive
        
    .BRANCH_ALPHA

    LDA.b $5B : DEC : DEC : BPL .BRANCH_BETA
        JSL.l Sprite_CheckDamageToPlayerIgnoreLayerLong : BCC .BRANCH_GAMMA
            LDA.b #$01 : STA.w $0DB0, X
            
            JSL.l Player_HaltDashAttackLong
            
            LDA.b $5D : CMP.b #$13 : BEQ .BRANCH_GAMMA
                        CMP.b #$03 : BEQ .BRANCH_GAMMA
                LDA.w $0D80, X : BNE SomariaPlatformAndPipe_HandleMovement
                    INC.w $0D90, X
                    
                    LDA.b #$02 : STA.w $02F5
                    
                    LDA.w $0D90, X : AND.b #$07 : BNE .BRANCH_EPSILON
                        JSR.w SomariaPlatformAndPipe_CheckTile
                        
                        CMP.w $0E90, X : BEQ .BRANCH_EPSILON
                            STA.w $0E90, X
                            
                            LDA.w $0DE0, X : STA.w $0EB0, X
                            
                            JSR.w SomariaPlatformAndPipe_HandleMovement
                            JSR.w SomariaPlatform_HandleDrag
                    
                    .BRANCH_EPSILON
                    
                    LDA.b $A0 : CMP.b #$24 : BEQ .BRANCH_ZETA
                        LDY.w $0DE0, X
                        
                        LDA.w Pool_SomariaPlatformAndPipe_drag_x_low, Y
                        CLC : ADC.w $0B7C : STA.w $0B7C

                        LDA.w Pool_SomariaPlatformAndPipe_drag_x_high, Y
                              ADC.w $0B7D : STA.w $0B7D
                        
                        LDA.w Pool_SomariaPlatformAndPipe_drag_y_low, Y
                        CLC : ADC.w $0B7E : STA.w $0B7E

                        LDA.w Pool_SomariaPlatformAndPipe_drag_y_high, Y
                              ADC.w $0B7F : STA.w $0B7F
                        
                        JSR.w Sprite3_Move
                        JSR.w SomariaPlatform_DragLink
                        
                        RTS
                        
                    .BRANCH_ZETA
                    
                    JMP.w SomariaPlatform_EnableDragging

        .BRANCH_GAMMA

    ; Bleeds into the next function.
}
        
; $0F77A3-$0F77AE JUMP LOCATION
SomariaPlatform_Inactive:
{
    LDA.w $0DB0, X : BEQ .BRANCH_THETA
        STZ.w $02F5
        STZ.w $0DB0, X
        
    .BRANCH_THETA
    
    RTS
}
    
; $0F77AF-$0F77C1 JUMP LOCATION
SomariaPlatformAndPipe_HandleMovement:
{
    JSR.w SomariaPlatform_HandleTile
    
    LDY.w $0DE0, X
    
    LDA.w Pool_SomariaPlatformAndPipe_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_SomariaPlatformAndPipe_y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; $0F77C2-$0F77DF LOCAL JUMP LOCATION
SomariaPlatformAndPipe_CheckTile:
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    LDA.w $0D10, X : STA.b $02
    LDA.w $0D30, X : STA.b $03
    
    ; Forced to check on bg2 (the main bg).
    LDA.b #$00 : JSL.l Entity_GetTileAttr
    
    LDA.w $0FA5
    
    RTS
}

; ==============================================================================

; $0F77E0-$0F785F DATA
SpriteDraw_SomariaPlatform_OAM_groups:
{
    dw -16, -16 : db $AC, $00, $00, $02
    dw   0, -16 : db $AC, $40, $00, $02
    dw -16,   0 : db $AC, $80, $00, $02
    dw   0,   0 : db $AC, $C0, $00, $02
    
    dw -13, -13 : db $AC, $00, $00, $02
    dw  -3, -13 : db $AC, $40, $00, $02
    dw -13,  -3 : db $AC, $80, $00, $02
    dw  -3,  -3 : db $AC, $C0, $00, $02
    
    dw -10, -10 : db $AC, $00, $00, $02
    dw  -6, -10 : db $AC, $40, $00, $02
    dw -10,  -6 : db $AC, $80, $00, $02
    dw  -6,  -6 : db $AC, $C0, $00, $02
    
    dw  -8,  -8 : db $AC, $00, $00, $02
    dw  -8,  -8 : db $AC, $40, $00, $02
    dw  -8,  -8 : db $AC, $80, $00, $02
    dw  -8,  -8 : db $AC, $C0, $00, $02
}

; $0F7860-$0F787C LOCAL JUMP LOCATION
SpriteDraw_SomariaPlatform:
{
    LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
    
    LDA.w $0F10, X : AND.b #$0C : ASL #3
    
    ADC.b #.OAM_groups                 : STA.b $08
    LDA.b #.OAM_groups>>8 : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : JMP Sprite3_DrawMultiple
}

; ==============================================================================

; $0F787D-$0F78AC LOCAL JUMP LOCATION
SomariaPlatform_HandleTile:
{
    LDA.w $0E90, X : SEC : SBC.b #$B0 : BCS .is_upper_tile
        RTS
    
    .is_upper_tile
    
    CMP.b #$0F : BCC .is_transit_tile
        RTS
    
    .is_transit_tile
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw SomariaPlatform_HandleTile_DoNothing    ; 0xB0 - $F908
    dw SomariaPlatform_HandleTile_DoNothing    ; 0xB1 - $F908
    dw SomariaPlatform_HandleTile_RisingSlope  ; 0xB2 - $F909 Zig zag rising slope
    dw SomariaPlatform_HandleTile_FallingSlope ; 0xB3 - $F912 Zig zag falling slope
    dw SomariaPlatform_HandleTile_FallingSlope ; 0xB4 - $F912 Zig zag falling slope
    dw SomariaPlatform_HandleTile_RisingSlope  ; 0xB5 - $F909 Zig zag rising slope
    dw SomariaPlatform_HandleTile_TJunctionDLR ; 0xB6 - $F91F Transit tile allowing direction inversion?
    dw SomariaPlatform_HandleTile_TJunctionULR ; 0xB7 - $F946 T junction transit tile (can't go up)
    dw SomariaPlatform_HandleTile_TJunctionUDR ; 0xB8 - $F9A3 T junction transit tile (can't go down)
    dw SomariaPlatform_HandleTile_TJunctionUDL ; 0xB9 - $FA02 T junction transit tile (can't go left)
    dw SomariaPlatform_HandleTile_4WayJunction ; 0xBA - $FA61 T junction transit tile (can't go right)
    dw SomariaPlatform_HandleTile_CrossOver    ; 0xBB - $FAC0 Transit tile junction that allows movement in all directions except for the one you came from.
    dw SomariaPlatform_HandleTile_Unknown      ; 0xBC - $FAFF Straight transit line junction? Question mark looking. Only allows travel in two colinear directions.
    dw SomariaPlatform_HandleTile_DoNothing    ; 0xBD - $F908
    dw SomariaPlatform_HandleTile_Station      ; 0xBE - $FB3A Endpoint node transit tile
}

; $0F78AD-$0F78D6 LOCAL JUMP LOCATION
SomariaPlatform_HandleDragX:
{
    LDA.w $0DE0, X : EOR.w $0EB0, X : AND.b #$02 : BEQ .BRANCH_ALPHA
        LDA.w $0D10, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.b $00
        
        SEC : SBC.w $0D10, X : BEQ .BRANCH_ALPHA
            STA.w $0B7C : BPL .BRANCH_BETA
                LDA.b #$FF : STA.w $0B7D
                
            .BRANCH_BETA
            
            LDA.b $00 : STA.w $0D10, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F78D7-$0F7900 LOCAL JUMP LOCATION
SomariaPlatform_HandleDragY:
{
    LDA.w $0DE0, X : EOR.w $0EB0, X : AND.b #$02 : BEQ .BRANCH_ALPHA
        LDA.w $0D00, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.b $00
        
        SEC : SBC.w $0D00, X : BEQ .BRANCH_ALPHA
            STA.w $0B7E : BPL .BRANCH_BETA
                LDA.b #$FF : STA.w $0B7F
            
            .BRANCH_BETA
            
            LDA.b $00 : STA.w $0D00, X
    
    .BRANCH_ALPHA
    
    RTS
} 

; $0F7901-$0F7907 LOCAL JUMP LOCATION
SomariaPlatform_HandleDrag:
{
    JSR.w SomariaPlatform_HandleDragX
    JSR.w SomariaPlatform_HandleDragY
    
    RTS
}

; OPTIMIZE: Use an RTS somewhere else to remove this.
; $0F7908-$0F7908 JUMP LOCATION
SomariaPlatform_HandleTile_DoNothing:
{
    RTS
}

; $0F7909-$0F7911 JUMP LOCATION
SomariaPlatform_HandleTile_RisingSlope:
{
    ; Zig zag along y = x line. Zig zag rising slope?
    LDA.w $0DE0, X : EOR.b #$03 : STA.w $0DE0, X
    
    RTS
}

; $0F7912-$0F791A JUMP LOCATION
SomariaPlatform_HandleTile_FallingSlope:
{
    ; Zig zag along y = -x line. Zig zag falling slope?
    LDA.w $0DE0, X : EOR.b #$02 : STA.w $0DE0, X
    
    RTS
}

; $0F791B-$0F791E DATA
SomariaPlatform_HandleTile_TJunctionDLR_dpad_press:
{
    db $04, $08, $01, $02
}

; Transit tile that allows you to invert your direction?
; $0F791F-$0F7941 JUMP LOCATION
SomariaPlatform_HandleTile_TJunctionDLR:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDA.b $4D : BNE .BRANCH_ALPHA
        LDY.w $0DE0, X
        
        LDA.b $F0 : AND.w .dpad_press, Y : BEQ .BRANCH_ALPHA
            STZ.w $0D80, X
            
            LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    STZ.b $4B
    
    JMP.w SomariaPlatform_EnableDragging
}

; ==============================================================================

; $0F7942-$0F7945 DATA
SomariaPlatform_HandleTile_TJunctionULR_dpad_press:
{
    db $03, $07, $06, $05    
}

; $0F7946-$0F799E JUMP LOCATION
SomariaPlatform_HandleTile_TJunctionULR:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : STA.b $00 : AND.b #$08 : BEQ .always
        LDA.b #$00 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
        
    .always
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_down
        LDA.b #$01 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
        
    .not_pressing_down
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
        LDA.b #$02 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
        LDA.b #$03 : STA.w $0DE0, X
        
        STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : BNE .not_going_up
        ; If we are going up, automatically head left once we hit the T
        ; intersection.
        LDA.b #$02 : STA.w $0DE0, X
        
    .not_going_up
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F799F-$0F79A2 DATA
SomariaPlatform_HandleTile_TJunctionUDR_dpad_press:
{
    db $0B, $03, $0A, $09
}

; $0F79A3-$0F79FD JUMP LOCATION
SomariaPlatform_HandleTile_TJunctionUDR:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : STA.b $00
    AND.b #$08 : BEQ .not_pressing_up
        LDA.b #$00 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .always
        LDA.b #$01 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .always
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
        LDA.b #$02 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
        LDA.b #$03 : STA.w $0DE0, X
        
        STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : CMP.b #$01 : BNE .not_going_down
        ; Automatically choose left as the next direction.
        LDA.b #$02 : STA.w $0DE0, X
    
    .not_going_down
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F79FE-$0F7A01 DATA
SomariaPlatform_HandleTile_TJunctionUDL_dpad_press:
{
    db $09, $05, $0C, $0D
}

; $0F7A02-$0F7A5C JUMP LOCATION
SomariaPlatform_HandleTile_TJunctionUDL:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : STA.b $00
    AND.b #$08 : BEQ .not_pressing_up
        LDA.b #$00 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_up
        LDA.b #$01 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$02 : BEQ .always
        LDA.b #$02 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .always
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
        LDA.b #$03 : STA.w $0DE0, X
        
        STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : CMP.b #$02 : BNE .not_going_left
        ; Force heading to going up.
        LDA.b #$00 : STA.w $0DE0, X
    
    .not_going_left
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F7A5D-$0F7A60 DATA
SomariaPlatform_HandleTile_4WayJunction_dpad_press:
{
    db $0A, $06, $0E, $0C
}

; $0F7A61-$0F7ABB JUMP LOCATION
SomariaPlatform_HandleTile_4WayJunction:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : STA.b $00
    AND.b #$08 : BEQ .not_pressing_up
        LDA.b #$00 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
        
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_down
        LDA.b #$01 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
        
    .not_pressing_down
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
        LDA.b #$02 : STA.w $0DE0, X
        
        STZ.w $0D80, X
        
        BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .always
    
    LDA.b #$03 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .always
    
    LDA.w $0DE0, X : CMP.b #$03 : BNE .not_going_right
        ; Default heading in reaction to this tile is going up.
        LDA.b #$00 : STA.w $0DE0, X
        
    .not_going_right
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F7ABC-$0F7ABF DATA
SomariaPlatform_HandleTile_CrossOver_dpad_press:
{
    db $0B, $07, $0E, $0D
}

; $0F7AC0-$0F7AFA JUMP LOCATION
SomariaPlatform_HandleTile_CrossOver:
{
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : STA.b $00
    AND.b #$08 : BEQ .BRANCH_ALPHA
        LDA.b #$00 : STA.w $0DE0, X
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b $00 : AND.b #$04 : BEQ .BRANCH_GAMMA
        LDA.b #$01 : STA.w $0DE0, X
        
        BRA .BRANCH_BETA
    
    .BRANCH_GAMMA
    
    LDA.b $00 : AND.b #$02 : BEQ .BRANCH_DELTA
        LDA.b #$02 : STA.w $0DE0, X
        
        BRA .BRANCH_BETA
    
    .BRANCH_DELTA
    
    LDA.b $00 : AND.b #$01 : BEQ .BRANCH_BETA
        LDA.b #$03 : STA.w $0DE0, X
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $0F7AFB-$0F7AFE DATA
SomariaPlatform_HandleTile_Unknown_dpad_press:
{
    db $0C, $0C, $03, $03
}

; $0F7AFF-$0F7B33 JUMP LOCATION
SomariaPlatform_HandleTile_Unknown:
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w .dpad_press, Y : BEQ .not_pressing_any_directions
        STA.b $00 : AND.b #$08 : BEQ .not_pressing_up
            LDA.b #$00 : BRA .set_direction
        
        .not_pressing_up
        
        LDA.b $00 : AND.b #$04 : BEQ .not_pressing_down
            LDA.b #$01 : BRA .set_direction
        
        .not_pressing_down
        
        LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
            LDA.b #$02 : BRA .set_direction
        
        .not_pressing_left
        
        LDA.b #$03
        
        .set_direction
        
        STA.w $0DE0, X
        
        STZ.w $0D80, X
        
    .not_pressing_any_directions

    ; Bleeds into the next function.
}

; $0F7B34-$0F7B39 JUMP LOCATION
SomariaPlatform_EnableDragging:
{ 
    LDA.b #$01 : STA.w $02F5
    
    RTS
}

; $0F7B3A-$0F7B48 JUMP LOCATION
SomariaPlatform_HandleTile_Station:
{
    STZ.w $0D80, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    STZ.b $4B
    
    BRA SomariaPlatform_EnableDragging
}

; $0F7B49-$0F7B77 LOCAL JUMP LOCATION
SomariaPlatform_DragLink:
{
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.w #$0008 : CMP.b $22 : BEQ .BRANCH_ALPHA
        BPL .BRANCH_BETA
            DEC.w $0B7C
            
            BRA .BRANCH_ALPHA
            
        .BRANCH_BETA
        
        INC.w $0B7C
        
    .BRANCH_ALPHA
    
    LDA.w $0FDA : SEC : SBC.w #$0010 : CMP.b $20 : BEQ .BRANCH_GAMMA
        BPL .BRANCH_DELTA
            DEC.w $0B7E
            
            BRA .BRANCH_GAMMA
            
        .BRANCH_DELTA
        
        INC.w $0B7E
    
    .BRANCH_GAMMA
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; UNUSED:
; $0F7B78-$0F7B7D DATA
UNUSED_1EFB78:
{
    ; NOTE: Perhaps these wwere speeds to be used for the player moving
    ; through the pipes?
    db $00, $00, $01, $FF, $00, $00
}

; ==============================================================================

; NOTE: The Pipe sprite doesn't use $0D80, X
; $0F7B7E-$0F7B93 JUMP LOCATION
Sprite_Pipe:
{
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0DC0, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Pipe_LocateTransitTile     ; 0x00 - $F632
    dw Pipe_LocateTransitEndpoint ; 0x01 - $FB94
    dw Pipe_WaitForPlayer         ; 0x02 - $FBBE
    dw Pipe_DrawPlayerInward      ; 0x03 - $FBF4
    dw Pipe_DragPlayerAlong       ; 0x04 - $FC13
    dw Pipe_Reset                 ; 0x05 - $FCD3
}

; ==============================================================================

; $0F7B94-$0F7BBD JUMP LOCATION
Pipe_LocateTransitEndpoint:
{
    ; Get tile attribute at sprite's current location.
    ; I'm thinking this is the starting tile for the pipe? Or perhaps
    ; represents an endpoint...
    JSR.w SomariaPlatformAndPipe_CheckTile : CMP.b #$BE : BNE .not_the_tile_youre_looking_for
        STA.w $0E90, X
        
        INC.w $0DC0, X
        
        ; Switch direction polarity... I guess so the player can go through it?
        LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
        
    .not_the_tile_youre_looking_for
    
    CMP.w $0E90, X : BEQ .beta
        STA.w $0E90, X
    
    .beta
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w SomariaPlatformAndPipe_HandleMovement
    JSR.w Sprite3_Move
    
    RTS
}

; ==============================================================================

; $0F7BBE-$0F7BEF JUMP LOCATION
Pipe_WaitForPlayer:
{
    ; NOTE: The sprite travels along with you (or ahead of you?).
    ; Entering the same pipe twice without taking the return trip results
    ; in a nonfunctional pipe that just behaves as normal empty space.
    ; This was confirmed directly by modifying the player's coordinates in
    ; a memory editor. Clearly this design limitation dictated the layout
    ; of the rooms the pipes appear in.
    LDA.w $1DE0 : CMP.b #$FF : BNE .cant_enter
        JSL.l Sprite_CheckDamageToPlayerIgnoreLayerLong : BCC .cant_enter
            PHX
            
            JSL.l Player_IsPipeEnterable
            
            PLX
            
            BCS .cant_pass_through
            
            INC.w $0DC0, X
            
            LDA.b #$04 : STA.w $0E00, X
            
            JSL.l Player_ResetState
            
            LDA.b #$01 : STA.w $02E4 : STA.w $037B
            
            TXA : STA.w $1DE0
    
    .cant_enter
    
    RTS
    
    .cant_pass_through
    
    JSR.w Sprite_HaltSpecialPlayerMovement
    
    RTS
}

; ==============================================================================

; $0F7BF0-$0F7BF3 DATA
Pipe_player_direction:
{
    db $08, $04, $02, $01
}

; $0F7BF4-$0F7C12 JUMP LOCATION
Pipe_DrawPlayerInward:
{
    LDA.w $0E00, X : BNE .delay
        INC.w $0DC0, X
        
        ; Makes the player invisible.
        LDA.b #$0C : STA.b $4B
        
        RTS
        
    .delay
    
    ; Halt the player, but also take care of some of their functions?
    LDA.b #$01 : STA.w $02E4 : STA.w $037B
    
    LDY.w $0DE0, X
    
    LDA Pipe_player_direction, Y
    
    JSR.w Pipe_HandlePlayerMovemen
    
    RTS
}

; ==============================================================================

; $0F7C13-$0F7CD2 JUMP LOCATION
Pipe_DragPlayerAlong:
{
    LDA.b #$03 : STA.w $0E80, X
    
    LDA.b $22 : STA.b $3F
    LDA.b $23 : STA.b $41
    
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40
    
    .lambda
    
        INC.w $0D90, X
        
        LDA.w $0D90, X : AND.b #$07 : BNE .BRANCH_ALPHA
            JSR.w SomariaPlatformAndPipe_CheckTile
            
            PHA : CMP.b #$B2 : BCC .BRANCH_BETA
                  CMP.b #$B6 : BCS .BRANCH_BETA
                
                LDA.b #$0B : JSL.l Sound_SetSfx2PanLong
            
            .BRANCH_BETA
            
            PLA : CMP.w $0E90, X : BEQ .BRANCH_ALPHA
                STA.w $0E90, X : CMP.b #$BE : BNE .not_endpoint_node
                    INC.w $0DC0, X
                    
                    LDA.b #$18 : STA.w $0E00, X
                
                .not_endpoint_node
                
                LDA.w $0DE0, X : STA.w $0EB0, X
                
                JSR.w SomariaPlatformAndPipe_HandleMovement
                JSR.w SomariaPlatform_HandleDrag
        
        .BRANCH_ALPHA
        
        JSR.w Sprite3_Move
        
        LDA.w $0D10, X : SEC : SBC.b #$08 : STA.b $00
        LDA.w $0D30, X       : SBC.b #$00 : STA.b $01
        
        LDA.w $0D00, X : SEC : SBC.b #$0E : STA.b $02
        LDA.w $0D20, X       : SBC.b #$00 : STA.b $03
        
        REP #$20
        
        LDA.b $00 : CMP.b $22 : BEQ .BRANCH_DELTA
            BCS .BRANCH_EPSILON
                DEC.b $22
                
                BRA .BRANCH_DELTA
                
            .BRANCH_EPSILON
            
            INC.b $22
            
        .BRANCH_DELTA
        
        LDA.b $02 : CMP.b $20 : BEQ .BRANCH_ZETA
            BCS .BRANCH_THETA
                DEC.b $20
                
                BRA .BRANCH_ZETA
                
            .BRANCH_THETA
            
            INC.b $20
        
        .BRANCH_ZETA
        
        SEP #$30
        
        DEC.w $0E80, X : BEQ .BRANCH_IOTA
    JMP .lambda
    
    .BRANCH_IOTA
    
    LDA.b $22 : SEC : SBC.b $3F : STA.b $31
    LDA.b $20 : SEC : SBC.b $3E : STA.b $30

    LDY.w $0DE0, X
    
    LDA Pipe_player_direction, Y : STA.b $26
    
    PHX
    
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    JSL.l HandleIndoorCameraAndDoors_long
    JSL.l Player_HaltDashAttackLong
    
    PLX
    
    RTS
}

; $0F7CD3-$0F7CFE JUMP LOCATION
Pipe_Reset:
{
    LDA.w $0E00, X : BNE .delay
        STZ.w $02E4
        STZ.w $02F5
        STZ.w $037B
        STZ.b $4B
        STZ.b $31
        STZ.b $30
        
        LDA.b #$FF : STA.w $1DE0
        
        LDA.b #$02 : STA.w $0DC0, X
        
        RTS
    
    .delay
    
    LDA.w $0DE0, X : EOR.b #$01 : TAY
    
    LDA Pipe_player_direction, Y
    
    JSR.w Pipe_HandlePlayerMovemen
    
    RTS
}

; Induces player movement, I do believe (in spite of the fact that
; we made the player invisible and 'froze' them. So... this sprite
; is acting as a surrogate of the player sprite, so to speak.
; $0F7CFF-$0F7D11 LOCAL JUMP LOCATION
Pipe_HandlePlayerMovement:
{
    PHX
    
    STA.b $67 : STA.b $26
    
    JSL.l Link_HandleVelocity
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    JSL.l HandleIndoorCameraAndDoors_long
    
    PLX
    
    RTS
}

; ==============================================================================
