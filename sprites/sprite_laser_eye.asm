; ==============================================================================

; NOTE: Uses a nonstandard direction variable.
; 0x00 - right
; 0x01 - left
; 0x02 - down
; 0x03 - up
!laser_eye_direction = $0DE0
    
; NOTE: Laser eyes that have this flag set look closed most of the time.
; They appear to open when firing. Without this flag, the laser eye
; appears to be open only when *not* firing. Weird variable.
; TODO: Verify the semantics I've described.
!requires_facing = $0EB0

; ==============================================================================

; $0F2462-$0F2487 LOCAL JUMP LOCATION
Sprite_LaserBeam:
{
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite3_CheckIfActive
    JSR.w LaserBeam_Draw
    JSR.w Sprite3_Move
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong
    
    ; TODO: timer_0?
    LDA !timer_0, X : BNE .delay
        	JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
    	    STZ.w $0DD0, X
    
    	    LDA.b #$26 : JSL.l Sound_SetSfx3PanLong
    
   	    RTS
    
        .no_tile_collision
    .delay
    
    RTS
}

; ==============================================================================

; $0F2488-$0F24E6 LOCAL JUMP LOCATION
LaserBeam_Draw:
{
    PHX : TXY
    
    LDX.b #$1D
    
    .next_slot
    
        LDA.l $7FF800, X : BEQ .empty_slot
    DEX : BPL .next_slot
    
    DEC.w $0FF8 : BPL .no_underflow
        LDA.b #$1D : STA.w $0FF8
    
    .no_underflow
    
    LDX.w $0FF8
    
    .empty_slot
    
    ; laser garnish...?
    LDA.b #$04 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.b #$10 : STA.l $7FF90E, X
    
    LDA.w $0DC0, Y : STA.l $7FF9FE, X
    
    TYA : STA.l $7FF92C, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    PLX
    
    RTS
}

; ==============================================================================

; $0F24E7-$0F24EE LONG JUMP LOCATION
SpritePrep_LaserEyeLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_LaserEye
    
    PLB
    
    RTL
}

; ==============================================================================

; NOTE: This explains why the exact same data was found near the 
; sprite prep routine in bank 0x06 (and is unused)
; $0F24EF-$0F24F0 DATA
SpritePrep_LaserEye_offsets:
{
    db -8,  8
}

; ==============================================================================

; $0F24F1-$0F2540 LOCAL JUMP LOCATION
SpritePrep_LaserEye:
{
    LDA.w $0E20, X : CMP.b #$97 : BCC .horizontal
    	LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
    
    	; Sets the direction to 2 or 3.
    	LDA.w $0E20, X : SEC : SBC.b #$95 : STA !laser_eye_direction, X : TAY
    
    	LDA.w $0D10, X : AND.b #$10 : EOR.b #$10 : STA !requires_facing, X
    	BNE .dont_adjust_y
    	    LDA.w $0D00, X : CLC : ADC .offsets-2, Y : STA.w $0D00, X
    
    	.dont_adjust_y
    
    	RTS
    
    .horizontal
    
    LDA.w $0E20, X : SEC : SBC.b #$95 : STA !laser_eye_direction, X : TAY
    
    LDA.w $0D00, X : AND.b #$10 : STA !requires_facing, X
    BNE .dont_adjust_x
        LDA.w $0D10, X : CLC : ADC .offsets, Y : STA.w $0D10, X
    
    .dont_adjust_x
    
    RTS
}

; ==============================================================================

; $0F2541-$0F2559 JUMP LOCATION
Sprite_LaserEye:
{
    LDA.w $0D90, X : BEQ .not_beam
        JMP Sprite_LaserBeam
    
    .not_beam
    
    JSR.w LaserEye_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw LaserEye_MonitorFiringZone ; 0x00 - $A55E
    dw LaserEye_FiringBeam        ; 0x01 - $A5C2
}

; ==============================================================================

; $0F255A-$0F255D DATA
LaserEye_MonitorFiringZone_matching_directions:
{
    db $02, $03, $00, $01
}

; $0F255E-$0F25AF JUMP LOCATION
LaserEye_MonitorFiringZone:
{
    REP #$20
    
    LDA.b $20 : SEC : SBC.w $0FDA : STA.b $0C
    
    LDA.b $22 : SEC : SBC.w $0FD8 : STA.b $0E
    
    SEP #$20
    
    LDA.b $2F : LSR A : LDY !requires_facing, X : CPY.b #$01 : TAY
    
    LDA !laser_eye_direction, X : BCS .ignore_player_direction
        CMP .matching_directions, Y : BNE .not_in_zone
    
    .ignore_player_direction
    
    CMP.b #$02 : REP #$20 : BCS .vertically_oriented
    	LDA.b $0C
    
        BRA .is_player_in_firing_zone
    
    .vertically_oriented
    
    LDA.b $0E
    
    .is_player_in_firing_zone
    
    CLC : ADC.w #$0010 : CMP.w #$0020 : SEP #$20 : BCS .not_in_zone
    	LDA.b #$20
    
    	LDY !requires_facing, X : BEQ .irrelevant
    	    ; OPTIMIZE: Loaded value of A is the same regardless.
    	    LDA.b #$20
    
    	.irrelevant
    
	; TODO: timer_0?
    	STA !timer_0, X
    
    	INC.w $0D80, X
    
    	RTS
    
    .not_in_zone
    
    STZ.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F25B0-$0F25C1 DATA
Pool_LaserEye_SpawnBeam:
{
    ; $0F25B0
    .x_offsets_low ; Bleeds into the next block. Length 4
    db  12, -12
    
    ; $0F25B2
    .y_offsets_low
    db   4,   4,  12, -12
    
    ; $0F25B6
    .x_offsets_high ; Bleeds into the next block. Length 4
    db   0,  -1

    ; $0F25B8
    .y_offsets_high
    db   0,   0,   0,  -1
    
    ; $0F25BC
    .x_speeds ; Bleeds into the next block. Length 4
    db 112, -112
    
    ; $0F25BE
    .y_speeds
    db   0,    0,  112, -112
}

; ==============================================================================

; $0F25C2-$0F25D7 JUMP LOCATION
LaserEye_FiringBeam:
{
    LDA.b #$01 : STA.w $0DC0, X
    
    LDA !timer_0, X : BNE .delay
    	STZ.w $0D80, X
    
    	JSR.w LaserEye_SpawnBeam
    
   	; TODO: timer_4?
    	LDA.b #$0C : STA !timer_4, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F25D8-$0F2647 LOCAL JUMP LOCATION
LaserEye_SpawnBeam:
{
    LDA.b #$95 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    	PHX
    
    	LDA !laser_eye_direction, X : TAX
    
    	AND.b #$02 : LSR A : STA.w $0DC0, Y
    
    	LDA.b $00 : CLC : ADC Pool_LaserEye_SpawnBeam_x_offsets_low,  X : STA.w $0D10, Y
    	LDA.b $01 :       ADC Pool_LaserEye_SpawnBeam_x_offsets_high, X : STA.w $0D30, Y
    
    	LDA.b $02 : CLC : ADC Pool_LaserEye_SpawnBeam_y_offsets_low,  X : STA.w $0D00, Y
    	LDA.b $03 :       ADC Pool_LaserEye_SpawnBeam_y_offsets_high, X : STA.w $0D20, Y
    
    	LDA.w Pool_LaserEye_SpawnBeam_x_speeds, X : STA.w $0D50, Y
    
    	LDA.w Pool_LaserEye_SpawnBeam_y_speeds, X : STA.w $0D40, Y
    
    	LDA.b #$20 : STA.w $0E40, Y : STA.w $0D90, Y
    
    	LDA.b #$05 : STA.w $0F50, Y
    
    	LDA.b #$48 : STA.w $0CAA, Y : STA.w $0BA0, Y
    
    	LDA.b #$05 : STA !timer_0, Y
    
    	LDA.l $7EF35A : CMP.b #$03 : BNE .not_blockable
    	    ; NOTE: Again, this pattern... why even bother writing code to
    	    ; make sprites blockable if you're just going to ... eh... just a bit
    	    ; annoying is all.
    	    LDA.b #$20 : STA.w $0BE0, Y
    
    	.not_blockable
    
    	PLX
    
    	LDA.b #$19 : JSL.l Sound_SetSfx3PanLong
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F2648-$0F2707 DATA
LaserEye_Draw_OAM_groups:
{
    dw  8, -4 : db $C8, $40, $00, $00
    dw  8,  4 : db $D8, $40, $00, $00
    dw  8, 12 : db $C8, $C0, $00, $00
    
    dw  8, -4 : db $C9, $40, $00, $00
    dw  8,  4 : db $D9, $40, $00, $00
    dw  8, 12 : db $C9, $C0, $00, $00
    
    dw  0, -4 : db $C8, $00, $00, $00
    dw  0,  4 : db $D8, $00, $00, $00
    dw  0, 12 : db $C8, $80, $00, $00
    
    dw  0, -4 : db $C9, $00, $00, $00
    dw  0,  4 : db $D9, $00, $00, $00
    dw  0, 12 : db $C9, $80, $00, $00
    
    dw -4,  8 : db $D6, $00, $00, $00
    dw  4,  8 : db $D7, $00, $00, $00
    dw 12,  8 : db $D6, $40, $00, $00
    
    dw -4,  8 : db $C6, $00, $00, $00
    dw  4,  8 : db $C7, $00, $00, $00
    dw 12,  8 : db $C6, $40, $00, $00
    
    dw -4,  0 : db $D6, $80, $00, $00
    dw  4,  0 : db $D7, $80, $00, $00
    dw 12,  0 : db $D6, $C0, $00, $00
    
    dw -4,  0 : db $C6, $80, $00, $00
    dw  4,  0 : db $C7, $80, $00, $00
    dw 12,  0 : db $C6, $C0, $00, $00
}

; $0F2708-$0F273E LOCAL JUMP LOCATION
LaserEye_Draw:
{
    LDA !requires_facing, X : BEQ .open_by_default
    	LDA.b #$01 : STA.w $0DC0, X
    
    	LDA !timer_4, X : BEQ .closed_when_not_firing
    	    STZ.w $0DC0, X
    
    	.closed_when_not_firing
    .open_by_default
    
    ; Always draw with super priority.
    LDA.b #$30 : STA.w $0B89, X
    
    LDA.b #$00 : XBA
    
    LDA !laser_eye_direction, X : ASL A : ADC.w $0DC0, X
    
    REP #$20
    
    ASL #3 : STA.b $00 : ASL A  : ADC.b $00 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JMP Sprite3_DrawMultiple
}

; ==============================================================================
