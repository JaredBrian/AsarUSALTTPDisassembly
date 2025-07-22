; ==============================================================================

; Ancilla 0x27 - Travel Bird

; Idiosyncrasies:
;   $03B5, X - 
;       0 - attempt to pick up player
;       1 - dropping off player
;   
;   $0394, X
;       Flapping sound effect delay timer

; ==============================================================================

; $045DD8-$045DE7 DATA
Pool_Ancilla_TravelBird:
{
    ; $045DD8
    .chr
    db $0E, $00, $02
    
    ; $045DDB
    .properties
    db $22, $2E, $2E
    
    ; $045DDE
    .y_offsets
    db $00, $0C, $14
    
    ; $045DE1
    .x_offsets
    db $00, $F7, $F7
    
    ; $045DE4
    .VRAM_offsets
    db $00, $20, $40, $E0
}

; $045DE8-$046067 JUMP LOCATION
Ancilla_TravelBird:
{
    LDA.b $11 : BEQ .execute
        BRL .draw_logic
        
    .execute
    
    LDA.w $0C68, X : BEQ .ready_to_seek_player
        ; Set coordinates while autotimer is counting down to be at roughly
        ; the y coordinate level of the player, and to the left of the screen.
        ; Update this every frame until the autotimer expires so the bird
        ; isn't suddenly shown midscreen if the player moves left.
        
        REP #$20
        
        LDA.b $20 : SEC : SBC.w #8 : STA.b $00
        
        LDA.w #-16 : CLC : ADC.b $E2 : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.w $0BFA, X
        LDA.b $01 : STA.w $0C0E, X
        
        LDA.b $02 : STA.w $0C04, X
        LDA.b $03 : STA.w $0C18, X
        
        RTS
    
    .ready_to_seek_player
    
    DEC.w $0394, X : BPL .flapping_SFX_delay
        LDA.b #$28 : STA.w $0394, X
        
        LDA.b #$1E : JSR.w Ancilla_DoSfx3
    
    .flapping_SFX_delay
    
    LDY.w $0385, X : BNE .dropping_off_so_swoop_down
        LDA.w $0C54, X : BEQ .maintain_current_altitude
            ; Pause sprite execution.
            INC.w $0FC1
            
    .dropping_off_so_swoop_down
    
    LDA.w $0294, X : CLC : ADC.b #-1 : STA.w $0294, X
    
    JSR.w Ancilla_MoveAltitude
    
    .maintain_current_altitude
    
    JSR.w Ancilla_MoveHoriz
    
    LDA.w $0385, X : BEQ .pick_up_logic
    
        BRL .drop_off_logic
        
    .dont_pick_up_player
        
    BRL .pick_up_logic_complete
    
    .pick_up_logic
    
    LDY.b #$01
    
    JSR.w Ancilla_CheckPlayerCollision : BCC .dont_pick_up_player
        LDA.b $10 : CMP.b #$0F : BEQ .dont_pick_up_player
            LDA.b $1B : BNE .indoors
                LDA.b $5D
                CMP.b #$0A : BEQ .dont_pick_up_player
                CMP.b #$09 : BEQ .dont_pick_up_player
                CMP.b #$08 : BEQ .dont_pick_up_player
                    LDA.b $5B : CMP.b #$02 : BEQ .dont_pick_up_player
                        LDA.w $02DA : ORA.w $037E : ORA.w $03EF : ORA.w $037B
                        BNE .dont_pick_up_player
                            BIT.w $0308 : BMI .dont_pick_up_player
                                PHX
                                
                                LDX.b #$04
                                
                                ; Terminate other ancillae that match a list
                                ; of types.
                                .next_slot
                                
                                    LDA.w $0C4A, X
                                    CMP.b #$2A : BEQ .terminate_ancilla
                                    CMP.b #$1F : BEQ .terminate_ancilla
                                    CMP.b #$30 : BEQ .terminate_ancilla
                                    CMP.b #$31 : BEQ .terminate_ancilla
                                    CMP.b #$41 : BNE .ignored_ancilla
                                        .terminate_ancilla
                                        
                                        STZ.w $0C4A, X
                                        
                                    .ignored_ancilla
                                DEX : BPL .next_slot
                                
                                PLX
                                
                                LDA.l $7EF3CC : CMP.b #$09 : BNE .tagalong_not_middle_aged_sign_guy
                                    LDA.b #$00 : STA.l $7EF3CC
                                                 STA.w $02F9
                                    
                                .tagalong_not_middle_aged_sign_guy
            .indoors
            
            REP #$20
            
            STZ.w $0308
            STZ.w $011A
            STZ.w $011C
            
            SEP #$20
            
            JSL.l Player_ResetState
            
            STZ.w $0345
            STZ.w $03F8
            
            LDA.b #$0C : STA.b $4B
            
            LDA.b #$00 : STA.b $5D
            
            INC : STA.w $02DA
                    STA.w $02E4
                    STA.w $037B
                    STA.w $02F9
            
            ; Begin rising now that the player has been picked up.
            INC : STA.w $0C54, X
            
            INC.w $0FC1
            
            STZ.w $0373
            
            LDA.b $1B : BEQ .dont_forbid_lifting_objects
                STA.w $03FD
            
            .dont_forbid_lifting_objects
    .pick_up_logic_complete
    
    BRA .draw_logic
    
    .drop_off_logic
    
    LDA.w $0C04, X : STA.b $00
    LDA.w $0C18, X : STA.b $01
    
    LDA.w $0C54, X : BEQ .dont_freeze_sprites
        INC.w $0FC1
    
    .dont_freeze_sprites
    
    REP #$20
    
    LDA.b $00 : BMI .drop_off_player_delay
    CMP.b $22 : BCC .drop_off_player_delay
        SEP #$20
        
        LDA.w $0C54, X : BEQ .draw_logic
            STZ.w $0C54, X
            STZ.b $4B
            STZ.w $02F9
            STZ.w $02DA
            
            STZ.w $0C22, X
            
            STZ.w $02E4
            STZ.w $037B
            STZ.w $03FD
            
            LDA.b #$90 : STA.w $031F
            
            LDA.l $7EF3CC
            
            CMP.b #$0D : BEQ .super_bomb_or_chest_tagalong
            CMP.b #$0C : BNE .tagalong_neither_of_those
                .super_bomb_or_chest_tagalong
                
                LDA.l $7EF3D3 : BNE .draw_logic
            
            .tagalong_neither_of_those
            
            JSL.l Tagalong_Init
            
            BRA .draw_logic
    
    .drop_off_player_delay
    
    LDA.b $22 : SEC : SBC.b $00 : CMP.w #$0030 : BCS .draw_logic
        ; Use the pulling up tiles for the bird since it's trying to
        ; not crash as it lands the player.
        LDY.b #$03
        
        SEP #$20
        
        BRA .set_VRAM_offset
    
    .draw_logic
    
    SEP #$20
    
    DEC.w $039F, X : BPL .animation_delay
        LDY.b #$03
        
        STA.w $039F, X
        
        INC.w $0380, X
        LDA.w $0380, X : CMP.b #$03 : BNE .anoreset_animation_index
            STZ.w $0380, X
        
        .anoreset_animation_index
    .animation_delay
    
    LDY.w $0380, X
    
    .set_VRAM_offset
    
    ; Set chr VRAM upload offset for bird body.
    LDA.w .VRAM_offsets, Y : STA.w $0AF4
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    ; WTF: (confirmed) Why does this object have to be a special snowflake?
    ; Why can't it just use altitude the way pretty much all other objects
    ; in the game do?
    LDA.w $029E, X : AND.w #$00FF : BEQ .treat_altitude_as_negative
        ORA.w #$FF00
    
    .treat_altitude_as_negative
    
    STA.b $04
    STA.b $72
    
    LDA.b $00 : STA.b $0A
    CLC : ADC.b $04 : STA.b $04
    
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDA.w $0C54, X : INC : STA.b $08
    
    LDY.b #$00 : TYX
    
    .next_OAM_entry
        
        REP #$20
        
        LDA.w Pool_Ancilla_TravelBird_y_offsets, X : AND.w #$00FF
        
        CMP.w #$0080 : BCC .sign_ext_y_offset
            ORA.w #$FF00
        
        .sign_ext_y_offset
        
        CLC : ADC.b $04 : STA.b $00
        
        LDA.w .x_offsets, X : AND.w #$00FF
        
        CMP.w #$0080 : BCC .sign_ext_x_offset
            ORA.w #$FF00
        
        .sign_ext_x_offset
        
        CLC : ADC.b $06 : STA.b $02
        
        SEP #$20
        
        JSR.w Ancilla_SetOam_XY
        
        LDA.w Pool_Ancilla_TravelBird_chr, X : STA ($90), Y
        INY
        
        LDA.w Pool_Ancilla_TravelBird_properties, X : ORA.b #$30 : STA ($90), Y
        INY
        
        PHY
        
        TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
        
        LDA.b #$02 : STA ($92), Y
        
        PLY
        
        INX
    CPY.b $08 : BNE .next_OAM_entry
    
    REP #$20
    
    LDA.b $0A : CLC : ADC.w #$001C : STA.b $00
    
    LDA.b $06 : STA.b $02
    
    SEP #$20
    
    LDA.b #$30 : STA.b $04
    
    LDX.b #$01 : JSR.w Ancilla_DrawShadow
    
    LDX.w $0FA0
    
    LDA.w $0C54, X : BEQ .dont_draw_player_shadow
        REP #$20
        
        LDA.b $0A : CLC : ADC.w #28 : STA.b $00
        
        LDA.b $06 : CLC : ADC.w #-7 : STA.b $02
        
        SEP #$20
        
        LDA.b #$30 : STA.b $04
        
        LDX.b #$01 : JSR.w Ancilla_DrawShadow
    
    .dont_draw_player_shadow
    
    PLX
    
    REP #$20
    
    LDA.b $06 : BMI .not_far_enough_right
        CMP.w #$0130 : BCC .not_far_enough_right
            SEP #$20
            
            STZ.w $0C4A, X
            
            LDA.w $0385, X : BNE .dont_transition_to_bird_travel_submodule
                LDA.w $0C54, X : BEQ .dont_transition_to_bird_travel_submodule
                    ; Enter the BirdTravel submodule of Messaging module.
                    LDA.b #$0A : STA.b $11
                    
                    ; Cache the current module.
                    LDA.b $10 : STA.w $010C
                    
                    LDA.b #$0E : STA.b $10

            .dont_transition_to_bird_travel_submodule
    .not_far_enough_right
    
    SEP #$20
    
    RTS
}

; ==============================================================================
