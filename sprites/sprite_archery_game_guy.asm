; ==============================================================================

; $028176-$028191 DATA
Pool_SpritePrep_ArcheryGameGuy:
{
    ; $028176
    .x_offests
    db $00, $40, $80, $C0, $30, $60, $90, $C0
    
    ; $02817E
    .y_offsets
    db $00, $4F, $4F, $4F, $5A, $5A, $5A, $5A
    
    ; $028186
    .subtypes
    db $00, $01, $01, $01, $02, $02, $02, $02
    
    ; $02818E
    .x_speeds
    db $F8, $0C
    
    ; $028190
    .hit_boxes
    db $1C, $15
}

; Shooting gallery guy initialization routine
; $028192-$0281FE LONG JUMP LOCATION
SpritePrep_ArcheryGameGuy:
{
    PHB : PHK : PLB
    
    STZ.w $0B88
    
    LDA.w $0D00, X : SEC : SBC.b #$08 : STA.w $0D00, X
    
    PHX
    
    ; This loop essentially spawns 8 sprites, even overwriting the current
    ; sprite's data (almost certainly, barring strange circumstances like
    ; having many other sprites in the room). It configures a number of
    ; sprites to be hands, and others to be mops, and ensures the state
    ; of the proprietor (the humanoid you talk to to start the game).
    LDX.b #$07
    
    .next_sprite
    
        LDA.b #$65 : STA.w $0E20, X
        
        LDA.b #$09 : STA.w $0DD0, X
        
        JSL.l Sprite_LoadProperties
        
        LDA.b $23           : STA.w $0D30, X
        LDA.w Pool_SpritePrep_ArcheryGameGuy_x_offsets, X : STA.w $0D10, X
        
        LDA.b $21           : STA.w $0D20, X
        LDA.w Pool_SpritePrep_ArcheryGameGuy_y_offsets, X : STA.w $0D00, X
        
        LDA.w Pool_SpritePrep_ArcheryGameGuy_subtypes, X : STA.w $0D90, X
        
        DEC : STA.w $0DC0, X : TAY
        
        LDA.w Pool_SpritePrep_ArcheryGameGuy_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Pool_SpritePrep_ArcheryGameGuy_hit_boxes, Y : STA.w $0F60, X
        
        LDA.b #$0D : STA.w $0F50, X
        
        LDA.b $EE : STA.w $0F20, X
        
        JSL.l GetRandomInt : STA.w $0E80, X
    DEX : BNE .next_sprite
    
    PLX : INC.w $0BA0, X
    
    ; Cache number of arrows that Link has when he enters the room.
    LDA.l $7EF377 : STA.w $0E30, X
    
    PLB
    
    RTL
}

; ==============================================================================

; $0281FF-$028212 JUMP LOCATION
Sprite_ArcheryGameGuy:
{
    ; Make sure arrows stay at the amount they started at when Link
    ; entered the shooting gallery. (This seems unelegant, but also
    ; seems to work well enough).
    LDA.w $0E30, X : STA.l $7EF377
    
    LDA.w $0D90, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ArcheryGameGuy_Main      ; 0x00 - $8217
    dw Sprite_GoodArcheryTarget ; 0x01 - $83D9
    dw Sprite_BadArcheryTarget  ; 0x02 - $844E
}

; ==============================================================================

; $028213-$028216 DATA
ArcheryGameGuy_Main_animation_states:
{
    db 3, 4, 3, 2
}
    
; $028217-$0282D3 JUMP LOCATION
ArcheryGameGuy_Main:
{
    LDA.w $0B99 : BNE .have_minigame_arrows
        ; Disallows firing of arrows if you have no "minigame" arrows left.
        INC.w $0B9A
    
    .have_minigame_arrows
    
    JSL.l ArcheryGameGuy_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDA.b #$00 : STA.w $0F60, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
        JSL.l Sprite_NullifyHookshotDrag
        
        STZ.b $5E
        
        JSL.l Player_HaltDashAttackLong
    
    .no_player_collision
    
    LDA.w $0DF0, X : BEQ .not_banging_his_drum
        AND.b #$07 : BNE .sound_effect_delay
            LDA.b #$11 : JSL.l Sound_SetSfx2PanLong
        
        .sound_effect_delay
        
        LDA.w $0DF0, X : AND.b #$04 : LSR : LSR : BRA .set_animation_state
        
    .not_banging_his_drum
    
    LDA.w $0D80, X : BEQ .in_ground_state
        ; I think this is what animtes the proprietor when you hit a target.
        LDA.b $1A : LSR #5 : AND.b #$03
        
    .in_ground_state
    
    TAY
    
    LDA.w .animation_states, Y
    
    .set_animation_state
    
    STA.w $0DC0, X
    
    LDA.w $0D80, X
    
    CMP.b #$02 : BEQ ArcheryGameGuy_RunGame
        CMP.b #$01 : BEQ .check_if_player_wants_to_play
            CMP.b #$03 : BNE .in_ground_state_2
                LDA.w $1CE8 : BNE .player_not_interested
                    LDA.b #$01 : STA.w $0D80, X
                    
                    BRA .restart_minigame
                
            .in_ground_state_2
            
            LDA.b #$0A : STA.w $0F60, X
            
            JSL.l Sprite_CheckDamageToPlayerSameLayerLong
            BCC .no_player_contact_2
                LDA.b $F6 : BPL .a_button_not_pressed
                    LDA.b #$85
                    
                    JSR.w .show_message
                    
                    INC.w $0D80, X
                    
                .a_button_not_pressed
            .no_player_contact_2
            
            RTS
        
        .check_if_player_wants_to_play
        
        LDA.w $1CE8 : BNE .player_not_interested
            .restart_minigame
            
            REP #$20
            
            LDA.l $7EF360 : CMP.w #$0014 : SEP #$20 : BCC .dont_got_the_cash
                STZ.w $0EB0, X
                STZ.w $0B88
                
                INC.w $0D80, X
                
                LDA.b #$86 : BRA .show_message
        
        .player_not_interested
        
        STZ.w $0D80, X
        
        ; "Well little partner, you can just turn yourself right around and..."
        LDA.b #$87
        
        .show_message
        
        STA.w $1CF0
        STZ.w $1CF1
        JSL.l Sprite_ShowMessageMinimal
        
        STZ.w $0DF0, X
        
        RTS
        
        .dont_got_the_cash
        
        STZ.w $0D80, X
        
        ; "Well little partner, you can just turn yourself right around and..."
        LDA.b #$87
        
        BRA .show_message
}

; ==============================================================================

; $0282D4-$0283CE BRANCH LOCATION
ArcheryGameGuy_RunGame:
{
    LDA.w $0EB0, X : BNE .arrows_already_laid_out
        LDA.b #$05 : STA.w $0B99
        
        LDA.b #$02
        
        JSL.l Sprite_InitializeSecondaryItemMinigame
        
        ; Start a delay counter to populate the counter with arrows.
        LDA.b #$27 : STA.w $0E00, X
        
        REP #$20
        
        ; Take 20 rupees as payment for the game.
        LDA.l $7EF360 : SEC : SBC.b #$0014 : STA.l $7EF360
        
        SEP #$20
        
        INC.w $0EB0, X
        
    .arrows_already_laid_out
    
    LDA.b #$34 : JSL.l OAM_AllocateFromRegionA
    
    JSR.w Sprite2_PrepOamCoord
    
    LDY.w $0B99 : STY.b $0D
    
    LDA.w $0E00, X : BEQ .arrow_stagger_finished
        ; This code is in play when the arrows on the counter are being
        ; populated one by one.
        LSR #3 : TAY : LDA.w .override_num_arrows_displayed, Y : STA.b $0D
    
    .arrow_stagger_finished
    
    PHX
    
    LDA.b $0D : ASL : CLC : ADC.b #$07 : TAX
    
    ; This loop draws the boundary of the arrows on the counter and the
    ; arrows themselves. If you cheat and have too many arrows it will look
    ; glitched.
    LDY.b #$00
    
    .next_subsprite
    
        LDA.b $00 : CLC : ADC.b #$EC : ADC .x_offsets, X       : STA.b ($90), Y
        LDA.b $02 : CLC : ADC.b #$D0 : ADC .y_offsets, X : INY : STA.b ($90), Y
        
        LDA.w .chr, X        : INY : STA.b ($90), Y
        LDA.w .properties, X : INY : STA.b ($90), Y
        
        PHY : TYA : LSR : LSR : TAY
        
        LDA.b #$00 : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    LDA.w $0B99
    ORA.w $0F10, X : ORA.w $0C4A
    ORA.w $0C4B    : ORA.w $0C4C
    ORA.w $0C4D    : ORA.w $0C4E
    BNE .game_in_progress
        ; Expand hit box for the proprietor, so that if we just get close to him
        ; he'll ask us if we want to play the minigame again.
        LDA.b #$0A : STA.w $0F60, X
        
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_retry_minigame
            LDA.b $F6 : BPL .no_retry_minigame
                ; "Want to shoot again? > Continue > Quit"
                LDA.b #$88
                
                JSR.w ArcheryGameGuy_Main_show_message
                
                INC.w $0D80, X
            
        .no_retry_minigame
    .game_in_progress
    
    RTS
    
    ; $028381
    .override_num_arrows_displayed
    db 5, 4, 3, 2, 1, 0
    
    ; $028387
    .x_offsets
    db  0,  0,  0,  0, 64, 64, 64, 64
    db  8,  8, 16, 16, 24, 24, 32, 32
    db 40, 40
    
    ; $028399
    .y_offsets
    db -8,  0,  8, 16, -8,  0,  8, 16
    db  0,  8,  0,  8,  0,  8,  0,  8
    db  0,  8
    
    ; $0283AB
    .chr
    db $2B, $3B, $3B, $2B, $2B, $3B, $3B, $2B
    db $63, $73, $63, $73, $63, $73, $63, $73
    db $63, $73
    
    ; $0283BD
    .properties
    db $33, $33, $B3, $B3, $73, $73, $F3, $F3
    db $32, $32, $32, $32, $32, $32, $32, $32
    db $32, $32
}

; ==============================================================================

; $0283CF-$0283D8 DATA
Sprite_GoodArcheryTarget_prizes:
{
    ; \tcrf (verified)
    ; Note the larger prizes available. The limit here seems to be
    ; 10 levels, though because we can only have 5 arrows, the upper
    ; level prizes are not used. Needs screenshot.
    db 4, 8, 16, 32, 64, 99, 99, 99, 99, 99
}

; $0283D9-$02844D JUMP LOCATION
Sprite_GoodArcheryTarget:
{
    LDA.w $0ED0, X : CMP.b #$05 : BCC .prize_index_in_range
        LDA.b #$06 : STA.w $0DA0, X
    
    .prize_index_in_range
    
    LDA.w $0E40, X : AND.b #$E0 : STA.w $0E40, X
    
    LDA.w $0E10, X : BNE .arrow_sticking_out
        LDA.w $0E80, X : LSR #3
    
    .arrow_sticking_out
    
    AND.b #$04 : ASL #4 : STA.b $00
    
    LDA.w $0F50, X : AND.b #$BF : ORA.b $00 : STA.w $0F50, X
    
    LDA.w $0FDA : SEC : SBC.b #$03 : STA.w $0FDA
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0E10, X : BEQ .no_arrow_sticking_out
        PHA
        
        LDA.w $0E40, X : ORA.b #$05 : STA.w $0E40, X
        
        PLA : CMP.b #$60 : BNE .dont_grant_rupees_this_frame
            LDA.b $11 : BNE .dont_grant_rupees_this_frame
                ; Make the proprietor go nuts and start banging a drum, or some
                ; other type of noise making thing.
                LDA.b #$70 : STA.w $0DF0
                
                LDY.w $0DA0, X
                
                LDA.b #$00 : XBA
                
                LDA (.prizes-1), Y

                REP #$20
                CLC : ADC.l $7EF360 : STA.l $7EF360
                SEP #$20
                
        .dont_grant_rupees_this_frame
        
        JSR.w GoodArcheryTarget_DrawPrize
    
    .no_arrow_sticking_out
    
    BRA ArcheryGame_TargetMain
}

; $02844E-$028462 JUMP LOCATION
Sprite_BadArcheryTarget:
{   
    LDA.w $0E40, X : AND.b #$E0 : STA.w $0E40, X
    
    LDA.w $0FDA : CLC : ADC.b #$03 : STA.w $0FDA
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong

    ; Bleeds into the next function.
}
    
; $028463-$0284AE JUMP LOCATION
ArcheryGame_TargetMain:
{
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0EE0, X : DEC : BNE .no_error_sound
        ; Play error noise if we hit a bad target (a "hand").
        LDA.b #$3C : STA.w $012E
        
    .no_error_sound
    
    INC.w $0E80, X
    
    JSR.w Sprite2_MoveHoriz
    
    LDA.w $0E00, X : BNE .dont_initiate_x_reset
        LDA.w $0DF0, X : STA.w $0BA0, X : BNE .reset_x_coordinate
            JSR.w Sprite2_CheckTileCollision : BEQ .dont_initiate_x_reset
                LDA.b #$10 : STA.w $0DF0, X
                
                ; Remove the arrow.
                STZ.w $0E10, X
        
    .dont_initiate_x_reset
    
    RTS
    
    .respawn_values
    
    db $E8, $08
    
    .reset_x_coordinate
    
    CMP.b #$01 : BNE .delay
        LDY.w $0DC0, X
        
        LDA.w .respawn_values, Y : STA.w $0D10, X
        LDA.b $23                : STA.w $0D30, X
        
        LDA.b #$20 : STA.w $0E00, X
        
        ; Reset prize indicator (probably not entirely necessary?)
        STZ.w $0ED0, X
        
    .delay
    
    RTS
}

; ==============================================================================

; $0284AF-$0284CE DATA
Pool_GoodArcheryTarget_DrawPrize:
{
    ; $0284AF
    .x_offsets
    db  -8,  -8,   0,   8,  16
    
    ; $0284B4
    .y_offsets
    db -24, -16, -20, -20, -20
    
    ; $0284B9
    .chr
    db $0B, $1B, $B6, $02, $30
    
    ; $0284BE
    .properties
    db $38, $38, $34, $35, $35
    
    ; $0284C3 (-1 based array)
    .first_digit_chr
    db $12, $32, $31, $03, $22, $33
    
    ; $0284C9 (-1 based array)
    .second_digit_chr
    db $7C, $7C, $22, $02, $12, $33
}

; Part of shooting gallery guy code.
; $0284CF-$02852C LOCAL JUMP LOCATION
GoodArcheryTarget_DrawPrize:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DA0, X : STA.b $06
    
    PHX
    
    LDX.b #$04
    LDY.b #$04
    
    .next_subsprite
    
        LDA.b $00 : CLC : ADC Pool_GoodArcheryTarget_DrawPrize_x_offsets, X
        STA.b ($90), Y

        LDA.b $02 : CLC : ADC Pool_GoodArcheryTarget_DrawPrize_y_offsets, X
        INY : STA.b ($90), Y
        
        CPX.b #$04 : BNE .not_second_digit
            PHX
            
            LDX.b $06
            LDA (Pool_GoodArcheryTarget_DrawPrize_second_digit_chr-1), X
            
            PLX
            
            BRA .write_chr
            
        .not_second_digit
        
        CPX.b #$03 : BNE .not_first_digit
            PHX
            
            LDX.b $06
            LDA (Pool_GoodArcheryTarget_DrawPrize_first_digit_chr-1), X
            
            PLX
            
            BRA .write_chr
            
        .not_first_digit
        
        LDA.w Pool_GoodArcheryTarget_DrawPrize_chr, X
        
        .write_chr
        
        INY : STA.b ($90), Y
        
        CMP.b #$7C : INY
        LDA.w Pool_GoodArcheryTarget_DrawPrize_properties, X : BCC .not_blank
            ; Mask off the name table bit (b/c apparently the blank exists in
            ; the first name table).
            AND.b #$FE
        
        .not_blank
        
        STA.b ($90), Y
        
        PHY : TYA : LSR : LSR : TAY
        
        LDA.b #$00 : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    JSL.l Sprite_DrawDistressMarker
    
    RTS
}

; ==============================================================================
