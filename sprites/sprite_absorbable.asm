; ==============================================================================

; $035030-$035031 DATA
Sprite_Key_flag_masks:
Key_AbsorptionByPlayer_flag_masks:
{
    db $40, $20
}

; ==============================================================================

; $035032-$035049 JUMP LOCATION
Sprite_Key:
Sprite_BigKey:
{
    LDY.w $0CBA, X
    
    LDA.w $0403 : AND.w Sprite_Key_flag_masks, Y : BEQ .keyNotObtainedYet
        ; Kill the key, as it's already been obtained.
        STZ.w $0DD0, X
        
        RTS
        
    .keyNotObtainedYet
    
    JSL.l Sprite_DrawRippleIfInWater
    JSR.w Sprite_DrawAbsorbable
    
    BRA Sprite_Absorbable_draw_logic_finished
}
    
; TODO: A lot of other refill / pickup sprites map to this location
; carefully ensure they all get named right, and perhaps with distinct
; names would be safer.
; $03504A-$0350EC JUMP LOCATION
Sprite_GreenRupee:
Sprite_BlueRupee:
Sprite_RedRupee:
Sprite_OneBombRefill:
Sprite_FourBombRefill:
Sprite_EightBombRefill:
Sprite_SmallMagicRefill:
Sprite_FullMagicRefill:
Sprite_FiveArrowRefill:
Sprite_TenArrowRefill:
Sprite_ShieldPickup:
{
    JSL.l Sprite_DrawRippleIfInWater
    JSR.w Sprite_DrawTransientAbsorbable

    ; Bleeds into the next function.
}

; $035051-$0350EC JUMP LOCATION
Sprite_Absorbable_draw_logic_finished:
{
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_MoveAltitude
    JSR.w Sprite_Move
    
    LDA !timer_3, X : BNE .skip_tile_collision_logic
        JSR.w Sprite_CheckTileCollision
        JSR.w Sprite_WallInducedSpeedInversion
        
    .skip_tile_collision_logic
    
    ; Simulates gravity for the sprite.
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        ; Is this equivalent to an arithmetic shift right? Interesting.
        LDA.w $0D50, X : ASL : ROR.w $0D50, X
        LDA.w $0D40, X : ASL : ROR.w $0D40, X
        
        LDA.w $0F80, X : EOR.b #$FF : INC : LSR A
        
        CMP.b #$09 : BCS .enough_z_speed_for_bounce
            JSR.w Sprite_Zero_XYZ_Velocity
            
            BRA .finished_bounce_logic
            
        .enough_z_speed_for_bounce
        
        STA.w $0F80, X
        
        LDA.l $7FF9C2, X : CMP.b #$08 : BEQ .water_tile
                           CMP.b #$09 : BNE .not_water_tile
            .water_tile
            
            STZ.w $0F80, X
            
            JSL.l Sprite_SpawnSmallWaterSplash : BMI .finished_bounce_logic
                LDA.w $0E60, X : AND.b #$20 : BEQ .finished_bounce_logic
                
                ; Adjust water splash coordinates, but only if this flag is set?
                ; TODO: Investigate, and if this is true, document it in WRAM doc.
                LDA.w $0D10, Y : SBC.b #$04 : STA.w $0D10, Y
                LDA.w $0D30, Y : SBC.b #$00 : STA.w $0D30, Y
                
                LDA.w $0D00, Y : SBC.b #$04 : STA.w $0D00, Y
                LDA.w $0D20, Y : SBC.b #$00 : STA.w $0D20, Y
                
            BRA .finished_bounce_logic
        
        .not_water_tile
        
        ; Is the sprite an item or other upper echelon sprite?
        LDA.w $0E20, X : CMP.b #$E4 : BCC .dont_play_clink_SFX
            LDA.b $1B : BEQ .dont_play_clink_SFX
                LDA.b #$05 : JSL.l Sound_SetSfx2PanLong
                
        .dont_play_clink_SFX
    .aloft

    .finished_bounce_logic
    
    JSR.w Sprite_HandleDraggingByAncilla
    JSR.w Sprite_CheckAbsorptionByPlayer
    
    RTS
}

; ==============================================================================

; $0350ED-$035115 LOCAL JUMP LOCATION
Sprite_HandleBlinkingPhaseOut:
{
    LDA.w $0B58, X : BEQ .phase_out_not_scheduled
        LDA.b $11 : ORA.w $0FC1 : BNE .dont_blink_at_all
            LDA.b $1A : LSR : BCS .decrement_blink_timer_delay
                DEC.w $0B58, X
                
            .decrement_blink_timer_delay
            
            LDA.w $0B58, X : BNE .self_termination_delay
                STZ.w $0DD0, X
                
            .self_termination_delay
            
            CMP.b #$28 : BCS .dont_blink_at_all
                LSR : BCS .visible_this_frame
                    JSR.w Sprite_PrepOamCoordSafeWrapper
                    
                    PLA : PLA

                .visible_this_frame
        .dont_blink_at_all
    .phase_out_not_scheduled
    
    RTS
}

; ==============================================================================

; $035116-$035124 LOCAL JUMP LOCATION
Sprite_CheckAbsorptionByPlayer:
{
    LDA.w $0F10, X : BNE .sprite_is_paused
        JSR.w Sprite_CheckDamageToPlayer_stagger : BCC .no_player_collision
            JSL.l Sprite_HandleAbsorptionByPlayerLong
            
        .no_player_collision
    .sprite_is_paused
    
    RTS
}

; ==============================================================================

; $035125-$03512C LONG JUMP LOCATION
Sprite_HandleAbsorptionByPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_HandleAbsorptionByPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $03512D-$03513B DATA
Sprite_HandleAbsorptionByPlayer_SFX:
{
    db $0B, $0A, $0A, $0A, $0B, $0B, $0B, $0B
    db $0B, $0B, $0B, $0B, $2F, $2F, $0B
}

; $03513C-$03516F LOCAL JUMP LOCATION
Sprite_HandleAbsorptionByPlayer:
{
    STZ.w $0DD0, X
    
    LDA.w $0E20, X : SEC : SBC.b #$D8 : TAY
    
    LDA.w .SFX, Y : JSL.l Sound_SetSfx3PanLong
    
    TYA
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw HeartRefill_AbsorptionByPlayer      ; 0x00 - $D1AF
    dw GreenRupee_AbsorptionByPlayer       ; 0x01 - $D1BE
    dw BlueRupee_AbsorptionByPlayer        ; 0x02 - $D1BE
    dw RedRupee_AbsorptionByPlayer         ; 0x03 - $D1BE
    dw OneBombRefill_AbsorptionByPlayer    ; 0x04 - $D1D8
    dw FourBombRefill_AbsorptionByPlayer   ; 0x05 - $D1D8
    dw EightBombRefill_AbsorptionByPlayer  ; 0x06 - $D1D8
    dw SmallMagicRefill_AbsorptionByPlayer ; 0x07 - $D1E8
    dw FullMagicRefill_AbsorptionByPlayer  ; 0x08 - $D1F1
    dw FiveArrowRefill_AbsorptionByPlayer  ; 0x09 - $D1F8
    dw TenArrowRefill_AbsorptionByPlayer   ; 0x0A - $D201
    dw Fairy_AbsorptionByPlayer            ; 0x0B - $D1A5
    dw Key_AbsorptionByPlayer              ; 0x0C - $D185
    dw BigKey_AbsorptionByPlayer           ; 0x0D - $D178
    dw ShieldPickup_AbsorptionByPlayer     ; 0x0E - $D170
}

; ==============================================================================

; $035170-$035177 JUMP LOCATION
ShieldPickup_AbsorptionByPlayer:
{
    ; Recoverable shield (from Pikit, etc).
    LDA.w $0E30, X : STA.l $7EF35A
    
    RTS
}

; ==============================================================================

; $035178-$035184 JUMP LOCATION
BigKey_AbsorptionByPlayer:
{
    STZ.w $02E9
    
    LDY.b #$32
    
    PHX
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    BRA Key_AbsorptionByPlayer_set_event_flag
}

; $035185-$0351A4 JUMP LOCATION
Key_AbsorptionByPlayer:
{
    LDA.l $7EF36F : INC : STA.l $7EF36F
    
    ; $03518E ALTERNATE ENTRY POINT
    .set_event_flag
    
    LDA.w $0E30, X : STA.w $0BC0, X
    
    ; Hopefully this is 0 or 1 or else things don't make much sense.
    LDY.w $0CBA, X
    LDA.w $0403 : ORA.w Key_AbsorptionByPlayer_flag_masks, Y : STA.w $0403
    
    JSL.l Dungeon_ManuallySetSpriteDeathFlag
    
    RTS
}

; ==============================================================================

; $0351A5-$0351AE JUMP LOCATION
Fairy_AbsorptionByPlayer:
{
    LDA.b #$31 : JSL.l Sound_SetSfx2PanLong
    
    LDA.b #$38 ; Amount of hearts a Fairy refills (7 hearts).
    
    BRA HeartRefill_AbsorptionByPlayer_apply_refill_amount
}

; $0351AF-$0351BA JUMP LOCATION
HeartRefill_AbsorptionByPlayer:
{
    ; Amount of hearts a standard heart refills.
    LDA.b #$08
    
    ; $0351B1 ALTERNATE ENTRY POINT
    .apply_refill_amount
    
    CLC : ADC.l $7EF372 : STA.l $7EF372
    
    RTS
}

; ==============================================================================

; $0351BB-$0351BD DATA
GreenRupee_AbsorptionByPlayer_rupee_quantities:
{
    db 1, 5, 20
}

; ==============================================================================

; $0351BE-$0351D4 JUMP LOCATION
GreenRupee_AbsorptionByPlayer:
BlueRupee_AbsorptionByPlayer:
RedRupee_AbsorptionByPlayer:
{
    LDY.w $0E20, X
    
    LDA.b #$00 : XBA
    
    ; (actual useful values start at $0351BB).
    ; Give us this many more rupees.
    LDA.w .rupee_quantities-$D9, Y

    REP #$20
    CLC : ADC.l $7EF360 : STA.l $7EF360
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0351D5-$0351D7 DATA
OneBombRefill_AbsorptionByPlayer_refill_quantities:
{
    db 1, 4, 8
}

; ==============================================================================

; $0351D8-$0351E7 JUMP LOCATION
OneBombRefill_AbsorptionByPlayer:
FourBombRefill_AbsorptionByPlayer:
EightBombRefill_AbsorptionByPlayer:
{
    LDY.w $0E20, X
    
    ; (actual useful values start at $0351D5).
    LDA.w .refill_quantities-$24, Y
    CLC : ADC.l $7EF375 : STA.l $7EF375
    
    RTS
}

; ==============================================================================

; $0351E8-$0351F0 JUMP LOCATION
SmallMagicRefill_AbsorptionByPlayer:
{
    ; Small magic decanter.
    LDA.l $7EF373 : CLC : ADC.b #$10
    
    BRA FullMagicRefill_AbsorptionByPlayer_apply_refill_amount
}
    
; $0351F1-$0351F7 JUMP LOCATION
FullMagicRefill_AbsorptionByPlayer:
{
    LDA.b #$80 ; Full magic decanter.
    
    ; $0351F3 ALTERNATE ENTRY POINT
    .apply_refill_amount
    
    STA.l $7EF373
    
    RTS
}

; ==============================================================================

; $0351F8-$035200 JUMP LOCATION
FiveArrowRefill_AbsorptionByPlayer:
{
    ; Number of arrows is stored as a property for this sprite.
    LDA.w $0EB0, X : BNE TenArrowRefill_AbsorptionByPlayer_apply_refill_amount
        LDA.b #$05 ; If zero, give Link 5.
        
        BRA TenArrowRefill_AbsorptionByPlayer_apply_refill_amount
}

; $035201-$03520C JUMP LOCATION
TenArrowRefill_AbsorptionByPlayer:
{
    LDA.b #$0A ; Different upgrade type, gives 10 arrows.
    
    ; $035203 ALTERNATE ENTRY POINT
    .apply_refill_amount
    
    CLC : ADC.l $7EF376 : STA.l $7EF376
    
    RTS
}

; ==============================================================================

; $03520D-$03522E DATA
Pool_Sprite_DrawTransientAbsorbable:
{
    .GFX_shape
    db $00 ; Heart
    db $01 ; Green rupee
    db $01 ; Blue rupee
    db $01 ; Red rupee
    db $02 ; Bomb refill 1
    db $02 ; Bomb refill 4
    db $02 ; Bomb refill 8
    db $00 ; Small magic
    db $01 ; Full magic
    db $01 ; Arrow refill 5
    db $02 ; Arrow refill 10
    db $02 ; Fairy
    db $01 ; Small key
    db $02 ; Big key
    db $02 ; Stolen shield
    
    ; $03521C
    .numeral
    db $00 ; Heart
    db $00 ; Green rupee
    db $00 ; Blue rupee
    db $00 ; Red rupee
    db $01 ; Bomb refill 1
    db $02 ; Bomb refill 4
    db $03 ; Bomb refill 8
    db $00 ; Small magic
    db $00 ; Full magic
    db $04 ; Arrow refill 5
    db $05 ; Arrow refill 10
    db $00 ; Fairy
    db $00 ; Small key
    db $00 ; Big key
    db $00 ; Stolen shield
}

; ==============================================================================

; $03522B-$03522E DATA
UNUSED_06D22B:
{
    db 2, 4, 6, 2
}

; ==============================================================================

; $03522F-$035231 LOCAL JUMP LOCATION
Sprite_DrawTransientAbsorbable:
{
    JSR.w Sprite_HandleBlinkingPhaseOut

    ; Bleeds into the next function.
}
    
; $035232-$035289 LOCAL JUMP LOCATION
Sprite_DrawAbsorbable:
{ 
    LDA.w $0FB3 : BNE .dont_use_super_priority
        LDA.b $1B : BEQ .dont_use_super_priority
            LDA.b #$30 : STA.w $0B89, X
        
    .dont_use_super_priority
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .improper_graphics_pack_loaded
        LDA.w $0E10, X : BEQ .dont_use_special_OAM_region
            LDA.b #$0C : JSL.l OAM_AllocateFromRegionC
            
        .dont_use_special_OAM_region
        
        ; TODO: find out under which circumstances this branch would be taken.
        LDA.w $0E90, X : BNE .easly_return_caller
            LDY.w $0E20, X
            
            LDA.w .numeral-$D8, Y : BEQ .not_suffixed_with_number
                JMP Sprite_DrawNumberedAbsorbable
                
            .not_suffixed_with_number
            
            LDA.w .GFX_shape-$D8, Y : BNE .not_single_small_OAM_entry
                JMP Sprite_PrepAndDrawSingleSmall
                
            .not_single_small_OAM_entry
            
            CMP.b #$02 : BNE .is_thin_and_tall
                LDA.w $0E20, X : CMP.b #$E6 : BNE .not_shield_pickup
                    LDA.w $0E30, X : CMP.b #$01 : BEQ .is_fighter_shield
                        ; Hero shield (as opposed to fighter shield)?
                        LDA.b #$01 : STA.w $0DC0, X
                
                .not_shield_pickup
                
                JMP Sprite_PrepAndDrawSingleLarge
                
                .is_fighter_shield
            .is_thin_and_tall
            
            JMP Sprite_DrawThinAndTall
        
        .easly_return_caller
        
        PLA : PLA
    
    .improper_graphics_pack_loaded
    
    RTS
}

; ==============================================================================

; $03528A-$0352AD DATA
Sprite_DrawNumberedAbsorbable_x_offsets:
{
    dw 0, 0, 8, 0, 0, 8, 0, 0
    dw 8, 0, 0, 2, 0, 0, 2, 0
    dw 0, 0
}
    
; ==============================================================================

; WTF: How exactly did this data array end up here and not closer
; to the octorock's code? Not that it hurts anything, it's just odd...
; $0352AE-$0352B1 DATA
Sprite_Octorock_h_flip:
{
    db $40, $00, $00, $00
}
    
; ==============================================================================

; $0352B2-$0352F9 DATA
Pool_Sprite_DrawNumberedAbsorbable:
{
    ; $0352B2
    .y_offsets
    dw 0, 0, 8, 0, 0, 8, 0, 0
    dw 8, 0, 8, 8, 0, 8, 8, 0
    dw 8, 8
    
    ; $0352D6
    .chr
    db $6E, $6E, $68, $6E, $6E, $78, $6E, $6E
    db $79, $63, $73, $69, $63, $73, $6A, $63
    db $73, $73
    
    ; $0352E8
    .OAM_sizes
    db $02, $02, $00, $02, $02, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
}

; $0352FA-$035362 LOCAL JUMP LOCATION
Sprite_DrawNumberedAbsorbable:
{
    DEC : STA.b $06
    
    JSR.w Sprite_PrepOamCoord
    
    ; $06 *= 3;
    LDA.b $06 : ASL : ADC.b $06 : STA.b $06
    
    PHX
    
    LDA.w $0EB0, X : CMP.b #$01 : LDX.b #$02 : BCC .has_number
        ; Think this means that it doesn't have a number (like a single arrow
        ; refill such as one spawned by a thief or a pikit dying). TODO:
        ; investigate.
        DEX
    
    .has_number

    .next_OAM_entry
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_Sprite_DrawNumberedAbsorbable_x_offsets, X
        STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC Pool_Sprite_DrawNumberedAbsorbable_y_offsets, X
        INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA.w Pool_Sprite_DrawNumberedAbsorbable_chr, X : INY : STA ($90), Y

        INY
        LDA.b $05 : STA ($90), Y
        
        PHY
        
        TYA : LSR : LSR : TAY
        
        LDA.w Pool_Sprite_DrawNumberedAbsorbable_OAM_sizes, X 
        ORA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
