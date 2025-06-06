; ==============================================================================

; $02995B-$029971 JUMP LOCATION
Sprite_ZoraKing:
{
    JSR.w ZoraKing_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ZoraKing_WaitingForPlayer ; 0x00 - $997A
    dw ZoraKing_RumblingGround   ; 0x01 - $99D9
    dw ZoraKing_Surfacing        ; 0x02 - $9A17
    dw ZoraKing_Dialogue         ; 0x03 - $9A46
    dw ZoraKing_Submerge         ; 0x04 - $9AE4
}

; ==============================================================================

; UNUSED:
; $029972-$029979 DATA
UNUSED_059972:
{
    db $28, $78, $C8, $78, $60, $50, $70, $50
}

; ==============================================================================

; $02997A-$0299D4 JUMP LOCATION
ZoraKing_WaitingForPlayer:
{
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0010 : CMP.w #$0020 : BCS .out_of_range
        LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0030 : CMP.w #$0060 : BCS .out_of_range
            SEP #$20
            
            ; Stop any process of Link dashing, moving, etc.
            JSL.l Player_HaltDashAttackLong
            
            LDA.b #$7F : STA.w $0DF0, X
            
            ; Make rumbly noise.
            LDA.b #$35 : STA.w $012E
            
            INC.w $0D80, X
            
            LDY.b #$0F
            
            .next_sprite
                
                CPY.w $0FA0 : BEQ .ignore_sprite
                    LDA.w $0CAA, Y : BMI .ignore_sprite
                        PHX : TYX : PHY
                        
                        LDA.w $0DD0, X : CMP.b #$0A : BNE .sprite_not_being_carried
                            STZ.w $0308
                            STZ.w $0309
                            
                        .sprite_not_being_carried
                        
                        ; Attempt to delete the sprite.
                        JSL.l Sprite_SelfTerminate
                        
                        PLY : PLX
                
                .ignore_sprite
            DEY : BPL .next_sprite
    
    .out_of_range
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0299D5-$0299D8 DATA
Pool_ZoraKing_RumblingGround:
{
    ; $0299D5
    .offsets_low
    db $01, $FF
    
    ; $0299D7
    .offsets_high
    db $00, $FF
}

; $0299D9-$029A06 JUMP LOCATION
ZoraKing_RumblingGround:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$7F : STA.w $0DF0, X
        
        STZ.w $011A
        STZ.w $011B ; Stop the shaking.
        
        LDA.b #$04 : STA.w $0DC0, X
        
        RTS
        
    .delay
    
    ; Make the ground rumble while counting down.
    AND.b #$01 : TAY
    
    LDA.w Pool_ZoraKing_RumblingGround_offsets_low, Y  : STA.w $011A
    LDA.w Pool_ZoraKing_RumblingGround_offsets_high, Y : STA.w $011B
    
    ; Link can't move.
    LDA.b #$01 : STA.w $02E4
    
    RTS
}

; ==============================================================================

; $029A07-$029A16 DATA
ZoraKing_Surfacing_animation_states:
{
    db $00, $00, $00, $03, $09, $08, $07, $06
    db $09, $08, $07, $06, $05, $04, $05, $04
}

; $029A17-$029A3D JUMP LOCATION
ZoraKing_Surfacing:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$7F : STA.w $0DF0, X
        
        RTS
        
    .delay
    
    CMP.b #$1C : BNE .dont_make_splashes
        PHA
        
        LDA.b #$0F : STA.w $0E10, X
        
        JSR.w Sprite_SpawnSplashRing
        
        PLA
        
    .dont_make_splashes
    
    LSR #3 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $029A3E-$029A45 DATA
ZoraKing_Dialogue_animation_states:
{
    db $00, $00, $01, $02, $01, $02, $00, $00
}

; $029A46-$029ACE JUMP LOCATION
ZoraKing_Dialogue:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$24 : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #4 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : CMP.b #$50 : BEQ .initial_message
        CMP.b #$4F : BEQ .check_if_buying_flippers
            CMP.b #$4E : BEQ .check_if_can_afford
                CMP.b #$4D : BEQ .maybe_give_flippers
                    RTS
        
    .initial_message
    
    ; Wah ha ha! What do you want, little man?..."
    LDA.b #$42
    
    .show_message
    
    STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    JSL.l Sprite_ShowMessageMinimal
        
    RTS
        
    .check_if_buying_flippers
        
    LDA.w $1CE8 : BNE .player_says_just_came_to_visit
        ; ...But I don't just give flippers away for free. I sell them..."
        LDA.b #$43
    JSR.w .show_message
    
    RTS
    
    .check_if_can_afford
    
    LDA.w $1CE8 : BNE .not_buying
        REP #$20
        
        ; Check if the player has 500 or more rupees (for flippers).
        LDA.l $7EF360 : SEC : SBC.w #$01F4 : BCC .cant_afford
            STA.l $7EF360
            
            SEP #$20
            
            ; "Wah ha ha! One pair of flippers coming up..."
            LDA.b #$44
            JSR.w .show_message
            
            INC.w $0E90, X
            
            RTS
            
            .player_says_just_came_to_visit
            
            ; "Great! Whenever you want to see my fishy face, you are welcome
            ; here."
            LDA.b #$46
            JSR.w .show_message
            
            LDA.b #$30 : STA.w $0DF0, X
            
            RTS
            
        .cant_afford
    .not_buying
    
    SEP #$20
    
    ; Wade back this way when you have more Rupees... Wah ha ha!..."
    LDA.b #$45
    JSR.w .show_message
    
    LDA.b #$30 : STA.w $0DF0, X
    
    RTS
    
    .maybe_give_flippers
    
    LDA.w $0E90, X : BEQ .didnt_pay_for_flippers
        ; Spawn the flippers and toss them at Link.
        JSL.l Sprite_SpawnFlippersItem
    
    .didnt_pay_for_flippers
    
    RTS
}

; ==============================================================================

; $029ACF-$029AE3 DATA
ZoraKing_Submerge_animation_states:
{
    db $0C, $0C, $0C, $0C, $0C, $0C, $0B, $0B
    db $0B, $0B, $0B, $0A, $0A, $0A, $0A, $03
    db $03, $03, $03, $03, $03
}

; $029AE4-$029B07 JUMP LOCATION
ZoraKing_Submerge:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l Sprite_SelfTerminate
        
        STZ.w $02E4
        
        RTS
    
    .delay
    
    CMP.b #$1D : BNE .dont_submerge_yet
        PHA
        
        LDA.b #$0F : STA.w $0E10, X
        
        JSR.w Sprite_SpawnSplashRing
        
        PLA
        
    .dont_submerge_yet
    
    LSR : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $029B08-$029B37 DATA
Pool_Sprite_SpawnSplashRing:
{
    ; $029B08
    .x_offsets_low
    db $F8, $FB, $04, $0D, $10, $0D, $04, $FB
    
    ; $029B10
    .x_offsets_high
    db $FF, $FF, $00, $00, $00, $00, $00, $FF
    
    ; $029B18
    .y_offsets_low
    db $04, $FB, $F8, $FB, $04, $0D, $10, $0D
    
    ; $029B20
    .y_offsets_high
    db $00, $FF, $FF, $FF, $00, $00, $00, $00
    
    ; $029B28
    .x_speeds
    db $F8, $FA, $00, $06, $08, $06, $00, $FA
    
    ; $029B30
    .y_speeds
    db $00, $FA, $F8, $FA, $00, $06, $08, $06
}

; ==============================================================================

; $029B38-$029B3F LONG JUMP LOCATION
Sprite_SpawnSplashRingLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SpawnSplashRing
    
    PLB
    
    RTL
}

; ==============================================================================

; $029B40-$029BBA LOCAL JUMP LOCATION
Sprite_SpawnSplashRing:
{
    LDA.b #$24 : JSL.l Sound_SetSfx2PanLong
    
    NOP
    
    LDA.b #$07 : STA.b $0D
    
    .next_attempt
        
        LDA.b #$08 ; Murder some octorocs in the water because why not.
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            LDA.b #$03 : STA.w $0DD0, Y
            
            PHX
            
            LDX.b $0D
            
            LDA.w Pool_Sprite_SpawnSplashRing_x_offsets_low, X
            SEC : SBC.b #$04 : CLC : ADC.b $00 : STA.w $0D10, Y

            LDA.b $01 : ADC Pool_Sprite_SpawnSplashRing_x_offsets_high, X
            STA.w $0D30, Y
            
            LDA.w Pool_Sprite_SpawnSplashRing_y_offsets_low, X
            SEC : SBC.b #$04 : CLC : ADC.b $02 : STA.w $0D00, Y

            LDA.b $03 : ADC Pool_Sprite_SpawnSplashRing_y_offsets_high, X
            STA.w $0D20, Y
            
            LDA.w Pool_Sprite_SpawnSplashRing_x_speeds, X : STA.w $0D50, Y
            LDA.w Pool_Sprite_SpawnSplashRing_y_speeds, X : STA.w $0D40, Y
            
            TXA : STA.w $0D90, Y
            
            PHY
            JSL.l GetRandomInt
            PLY
            AND.b #$0F : ADC.b #$18 : STA.w $0F80, Y
            
            LDA.b #$01 : STA.w $0D80, Y
            LDA.b #$00 : STA.w $0F70, Y
            
            LDA.w $0E60, Y : ORA.b #$40 : STA.w $0E60, Y : STA.w $0BA0, Y
            
            PLX
            
        .spawn_failed
    DEC.b $0D : BPL .next_attempt
    
    RTS
}

; ==============================================================================

; $029BBB-$029CAA DATA
Pool_ZoraKing_Draw:
{
    ; $029BBB
    .x_offsets
    db $F8, $08, $F8, $08, $F8, $08, $F8, $08
    db $F8, $08, $F8, $08, $F8, $08, $F8, $08
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $F8, $08, $F8, $08, $F8, $08, $F8, $08
    
    db $F8, $08, $F8, $08, $F8, $08, $F8, $08
    db $F7, $09, $F7, $09, $F6, $0A, $F6, $0A
    
    db $F5, $0B, $F5, $0B
    
    ; $029BEF
    .y_offsets
    db $EE, $EE, $FE, $FE, $EE, $EE, $FE, $FE
    db $EE, $EE, $FE, $FE, $F4, $F4, $04, $04
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $F8, $F8, $08, $08, $F8, $F8, $08, $08
    
    db $F8, $F8, $08, $08, $F8, $F8, $08, $08
    db $FB, $FB, $05, $05, $FB, $FB, $05, $05
    
    db $FB, $FB, $05, $05
    
    ; $029C23
    .chr
    db $C0, $C0, $E0, $E0, $C2, $EA, $E2, $E2
    db $EA, $C2, $E2, $E2, $C0, $C0, $E4, $E6
    
    db $88, $88, $88, $88, $88, $88, $88, $88
    db $C4, $C6, $E4, $E6, $C6, $C4, $E6, $E4
    
    db $E6, $E4, $C6, $C4, $E4, $E6, $C4, $C6
    db $88, $88, $88, $88, $88, $88, $88, $88
    
    db $88, $88, $88, $88
    
    ; $029C57
    .properties
    db $00, $40, $00, $40, $00, $40, $00, $40
    db $00, $40, $00, $40, $00, $40, $05, $05
    
    db $05, $05, $05, $05, $C5, $C5, $C5, $C5
    db $05, $05, $05, $05, $45, $45, $45, $45
    
    db $C5, $C5, $C5, $C5, $85, $85, $85, $85
    db $04, $44, $84, $C4, $04, $44, $84, $C4
    
    db $04, $44, $84, $C4
    
    ; $029C8B
    .whirlpool_x_offsets
    db $E9, $17, $17, $17, $EC, $F1, $0D, $12
    
    ; $029C93
    .whirlpool_y_offsets
    db $F8, $F8, $F8, $F8, $F9, $00, $00, $F9
    
    ; $029C9B
    .whirlpool_chr
    db $AE, $AE, $AE, $AE, $AC, $AC, $AC, $AC
    
    ; $029CA3
    .whirlpool_properties
    db $00, $40, $40, $40, $00, $00, $40, $40
}

; $029CAB-$029D49 LOCAL JUMP LOCATION
ZoraKing_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0D80, X : CMP.b #$02 : BCC .draw_whirlpool_instead
        LDA.w $0DC0, X : ASL #2 : STA.b $06
        
        PHX
        
        LDX.b #$03
        
        .next_subsprite
        
            PHX : TXA : CLC : ADC.b $06 : TAX
            
            LDA.b $00 : CLC : ADC Pool_ZoraKing_Draw_x_offsets, X : STA ($90), Y
            
            INY
            
            LDA.w Pool_ZoraKing_Draw_y_offsets, X : CLC : ADC.b $02 : STA ($90), Y
            LDA.w Pool_ZoraKing_Draw_chr, X : INY : STA ($90), Y
            
            LDA.b #$0F : STA.b $0F
            
            LDA.w Pool_ZoraKing_Draw_properties, X : BIT.b $0F : BNE .palette_override
                ORA.b $05
            
            .palette_override
            
            INY : ORA.b #$20 : STA ($90), Y
            
            INY
        PLX : DEX : BPL .next_subsprite
        
        PLX
        
        LDY.b #$02
        LDA.b #$03
        
        JSL.l Sprite_CorrectOamEntriesLong
        JSR.w Sprite2_PrepOamCoord
    
    .draw_whirlpool_instead
    
    LDA.w $0E10, X : BEQ .return
        LSR : AND.b #$04 : STA.b $06
        
        LDA.b #$10 : JSL.l OAM_AllocateFromRegionC
        
        LDY.b #$00
        
        PHX
        
        LDX.b #$03
        
        .next_whirlpool_subsprite
        
            PHX
            
            TXA : CLC : ADC.b $06 : TAX
            
            LDA.b $00
            CLC : ADC Pool_ZoraKing_Draw_whirlpool_x_offsets, X : STA ($90), Y

            LDA.b $02 : CLC : ADC Pool_ZoraKing_Draw_whirlpool_y_offsets, X
            INY : STA ($90), Y

            LDA.w Pool_ZoraKing_Draw_whirlpool_chr, X
            INY : STA ($90), Y

            LDA.w Pool_ZoraKing_Draw_whirlpool_properties, X
            ORA.b #$24 : INY : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            LDA.b #$02 : STA ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_whirlpool_subsprite
        
        PLX
        
    .return
    
    RTS
}

; ==============================================================================
