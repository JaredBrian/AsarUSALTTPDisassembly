; ==============================================================================

; Idiosyncrasies:
;
;   $0380[0x05]
;       Tile type that was last interacted with when dealing with ledges.
;   
;   $0385[0x0A]
;       0x00 - Does nothing
;       0x01 - Overrides a lot of logic, including disabling sprite
;       collision and collision with other ledges. Paired ledges set this
;       high first, then low when hitting the second ledge. This is special
;       logic that allows the player to cross gaps across ledges, as
;       normally many objects collide with ledges.
;   
;   $0394[0x05]
;       Delay timer to avoid 'extra' collision
;   
;
;   $0C54[0x0A] 
;       0 - protracting
;       1 - retracting
;   
;   $0C5E[0x0A]
;       indicates the 'steps' of the protraction / retraction

; ==============================================================================

; $043D4C-$043D73 DATA
Pool_Ancilla_Hookshot:
{
    ; $043D4C
    .chr
    db $09, $0A, $FF, $09, $0A, $FF
    db $09, $FF, $0A, $09, $FF, $0A
    
    ; $043D58
    .properties
    db $00, $00, $FF, $80, $80, $FF
    db $40, $FF, $40, $00, $FF, $00
    
    ; $043D64
    .chain_y_speeds
    dw 8, -9,  0,  0
    
    ; $043D6C
    .chain_x_speeds
    dw 0,  0,  8, -8
}

; $043D74-$044002 JUMP LOCATION
Ancilla_Hookshot:
{
    LDA.b $11 : BNE .just_draw
        ; Branch if no sound effect this frame...
        LDA.w $0C68, X : BNE .chain_SFX_delay
            LDA.b #$07 : STA.w $0C68, X
            
            LDA.b #$0A
            JSR.w Ancilla_DoSFX2
            
        .chain_SFX_delay
        
        ; In this situation, the player module is moving the player towards
        ; a location so we don't actually have to move the head of the
        ; hookshot.
        LDA.w $037E : BNE .just_draw
            JSR.w Ancilla_MoveVert
            JSR.w Ancilla_MoveHoriz
            
            ; In the protracting state? Branch.
            ; If retracting, continue on.
            LDA.w $0C54, X : BEQ .protracting
                DEC.w $0C5E, X : BMI .terminate_after_full_retraction
        
    .just_draw
    
    BRL .draw
    
    .terminate_after_full_retraction
    .self_terminate
    
    STZ.w $0C4A, X
    
    RTS
    
    .protracting
    
    ; If not at fully protracted state yet, don't begin retracting.
    LDA.w $0C5E, X : INC : STA.w $0C5E, X
    CMP.b #$20 : BNE .protraction_not_maxed
        ; Begin retracting.
        LDA.b #$01 : STA.w $0C54, X
        
        ; And reverse direction of the hookshot head.
        LDA.w $0C22, X : EOR.b #$FF : INC : STA.w $0C22, X
        LDA.w $0C2C, X : EOR.b #$FF : INC : STA.w $0C2C, X
        
    .protraction_not_maxed
    
    JSR.w Hookshot_IsCollisionCheckFutile : BCC .perform_collision_checks
        BRL .draw
    
    .perform_collision_checks
    
    LDA.w $0385, X : BNE .ignore_sprite_collision
        ; WTF: why all these checks of the protracting state? We already
        ; know if we're here that it can't be retracting.
        LDA.w $0C54, X : BNE .ignore_sprite_collision
            JSR.w Ancilla_CheckSpriteCollision : BCC .no_tile_collision
                LDA.w $0C54, X : BNE .ignore_sprite_collision
                    LDA.b #$01 : STA.w $0C54, X
                    
                    LDA.w $0C22, X : EOR.b #$FF : INC : STA.w $0C22, X
                    LDA.w $0C2C, X : EOR.b #$FF : INC : STA.w $0C2C, X
                    
                    BRA .check_tile_collision
                    
                    ; UNUSED: Interesting... was this put in here for debugging
                    ; or something? Requires investigation.
                    .unused
                    BRL .unused_2
        
        .no_tile_collision
    .ignore_sprite_collision

    .check_tile_collision
     
    JSL.l Hookshot_CheckTileCollison
    
    STZ.b $00
    
    LDA.b $1B : BEQ .outdoor_ledge_interaction
        LDY.b #$01
        
        LDA.w $0C72, X : AND.b #$02 : BNE .indoor_horiz_ledge_interaction
            LDA.w $036D : LSR #4 : STA.b $00
            
            LDY.b #$00
            
        .indoor_horiz_ledge_interaction
        
        ; Helps us get across bodies of water without being stopped.
        LDA.w $036D, Y : ORA.b $00 : AND.b #$03 : STA.b $00
        BEQ .not_ledge_collision
            BRA .ledge_collision
        
    .outdoor_ledge_interaction
    
    LDA.w $036E : AND.b #$03 : ORA.w $036D : ORA.w $0370
    AND.b #$33 : BEQ .not_ledge_collision
        .ledge_collision
        
        DEC.w $0394, X : BPL .hit_ledge_on_previous_frames
            ; If you're here, it means that the guard for ledge collision is
            ; still up.
            LDY.w $0380, X : BEQ .last_tile_interaction_passable
                ; As opposed to an outdoor ledge.
                LDA.b $00 : AND.b #$03 : BNE .hit_indoor_ledge_tile
                    ; NOTE: The tile detection api is supposed to set this
                    ; variable.
                    CPY.b $76 : BEQ .last_tile_interaction_passable
                    
                .hit_indoor_ledge_tile
                
                LDA.b #$02 : STA.w $0394, X
                
                DEC.w $0385, X : BPL .ignore_ledges_for_now
                    STZ.w $0385, X
                    
                    BRA .resume_normal_extra_collision
            
            .last_tile_interaction_passable
            
            ; This seems to happen when you hit a ledge tile for starters, and
            ; then it gets set low later.
            INC.w $0385, X
            
            LDA.b $76 : STA.w $0380, X
            
            LDA.b #$01 : STA.w $0394, X
            
            .ignore_ledges_for_now
        .hit_ledge_on_previous_frames
    .not_ledge_collision
    
    .resume_normal_extra_collision
    
    LDA.w $0385, X : BNE .extra_collision_logic_overrided
        LDA.w $0394, X : BMI .extra_collision_logic
            DEC.w $0394, X
    
    .extra_collision_logic_overrided
    
    BRL .draw
    
    .extra_collision_logic
    
    LDA.b $0E : LSR #4
    ORA.b $0E : ORA.b $58 : ORA.b $0C : AND.b #$03 : BEQ .no_extra_tile_collision
        LDA.w $0C54, X : BNE .no_extra_tile_collision
            LDA.b #$01 : STA.w $0C54, X
            
            LDA.w $0C22, X : EOR.b #$FF : INC : STA.w $0C22, X
            LDA.w $0C2C, X : EOR.b #$FF : INC : STA.w $0C2C, X
            
            ; NOTE: I really like this typo 'grabblable', it sounds ridiculous.
            ; Not a tile collision in this case, but it hit something grabblable.
            LDA.w $02F6 : AND.b #$03 : BNE .no_extra_tile_collision
                PHX
                
                LDY.b #$01
                LDA.b #$06
                JSL.l AddHookshotWallHit
                
                PLX
                
                ; Use a different sound if it hit a key door.
                LDY.b #$06
                
                LDA.w $02F6 : AND.b #$30 : BNE .hit_key_door
                    LDY #$05
                
                .hit_key_door
                
                TYA
                JSR.w Ancilla_DoSFX2
    
    .no_extra_tile_collision
    
    LDA.w $02F6 : AND.b #$03 : BEQ .draw
        ; NOTE: Though this label says unused, it just means that the branch
        ; origin is unreachable in this case.
        .unused_2
        
        ; If the drag collision occurred close enough, just terminate
        ; the hookshot and don't drag the player.
        LDA.w $0C5E, X : CMP.b #$04 : BCS .drag_actually_required
            BRL .self_terminate
        
        .drag_actually_required
        
        LDA.b #$01 : STA.w $037E
        
        STX.w $039D
    
    .draw
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0385, X : BEQ .max_priority_not_required
        LDA.b #$30 : STA.b $65
    
    .max_priority_not_required
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDA.w $0C72, X : STA.b $08
    
    ; X and $0A = $0C72, X * 6
    ASL : CLC : ADC.b $08 : STA.b $0A : TAX
    
    LDA.b #$02 : STA.b $08
    
    LDY.b #$00
    
    .next_OAM_entry
    
            LDX.b $0A
            
            LDA.w .chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
                JSR.w Ancilla_SetOam_XY
                
                LDX.b $0A
                LDA.w Pool_Ancilla_Hookshot_chr, X : STA.b ($90), Y

                INY
                LDA.w Pool_Ancilla_Hookshot_properties, X
                ORA.b #$02 : ORA.b $65 : STA.b ($90), Y

                INY : PHY
                TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
                LDA.b #$00 : STA.b ($92), Y
                
                PLY
            
            .skip_OAM_entry
            
            INC.b $0A
            
            LDA.b $02 : CLC : ADC.b #$08 : STA.b $02
            
            DEC.b $08 : BMI .draw_chain_links
        LDA.b $08 : BNE .next_OAM_entry
        
        LDA.b $00 : CLC : ADC.b #$08 : STA.b $00
        
        LDA.b $06 : STA.b $02
    BRA .next_OAM_entry
    
    .draw_chain_links
    
    PLX : PHX
    
    STZ.b $0A
    STZ.b $0B
    STZ.b $0C
    STZ.b $0D
    
    LDA.w $0C5E, X : LSR : CMP.b #$07 : BCC .link_scaling_not_needed
        ; At extension state >= 7, use this as the base displacement between
        ; chain links. Otherwise, the distance between them is fixed per
        ; the data tables provided by the pool.
        SEC : SBC.b #$07 : STA.b $0A
                           STA.b $0C
        
        LDA.b #$06
        
    .link_scaling_not_needed
    
    STA.b $08 : BNE .at_least_one_chain_link_renderable
        ; Currently we should not draw any of the little link components,
        ; so just return for now.
        BRL .no_chain_links
        
    .at_least_one_chain_link_renderable
    
    LDA.w $0C72, X : AND.b #$01 : BEQ .tracting_up_or_left
        ; Tracting down or right, so multiply the base offset by -1?
        ; It appears that this is done because the links are drawn
        ; relative to the hook at the end of the hookshot as it's tracting.
        LDA.b $0A : EOR.b #$FF : INC : STA.b $0A
                                       STA.b $0C
        
        BEQ .no_sign_extension_needed
            ; Sign extension for $0A and $0C.
            LDA.b #$FF : STA.b $0B
                         STA.b $0D
    
        .no_sign_extension_needed
    .tracting_up_or_left
    
    REP #$20
    
    LDA.w $0C72, X : ASL : AND.b #$00FF : TAX
    LDA.w Pool_Ancilla_Hookshot_chain_y_speeds, X : BNE .use_actual_y_displacement
        ; Otherwise move the base y offset for the links down 4 pixels.
        LDA.b $04 : CLC : ADC.w #$0004 : STA.b $04
        
    .use_actual_y_displacement
    
    LDA.w Pool_Ancilla_Hookshot_chain_x_speeds, X : BNE .use_actual_x_displacement
        ; Otherwise move the base x offset for the links right 4 pixels.
        LDA.b $06 : CLC : ADC.w #$0004 : STA.b $06
        
        SEP #$20
        
    .use_actual_x_displacement

    .next_chain_link
        
        REP #$20
        
        LDA.w .chain_y_speeds, X : BEQ .dont_accumulate_y_offset
            ; Accumulate y offset.
            CLC : ADC.b $0A
            
        .dont_accumulate_y_offset
        
        CLC : ADC.b $04 : STA.b $04
                STA.b $00
        
        LDA.w .chain_x_speeds, X : BEQ .dont_accumulate_x_offset
            ; Accumulate x offset.
            CLC : ADC.b $0C
        
        .dont_accumulate_x_offset
        
        CLC : ADC.b $06 : STA.b $06
                          STA.b $02
        
        SEP #$20
        
        ; If the chain's calculated position is too close to the player,
        ; it is omitted from the OAM buffer.
        JSR.w Hookshot_CheckChainLinkProximityToPlayer : BCS .chain_link_too_close
            JSR.w Ancilla_SetOam_XY
            
            ; Always same chr, but...
            LDA.b #$19 : STA.b ($90), Y
            
            INY
            
            ; ... The chain link was probably drawn a bit off kilter so that
            ; hflip and vflip could be employed to 'animate' it. That said, if
            ; you look at the hookshot effect closely, it looks a tad cheap.
            LDA.b $1A : AND.b #$02 : ASL #6
            
            ORA.b #$02 : ORA.b $65 : STA.b ($90), Y
            
            INY : PHY
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.b #$00 : STA.b ($92), Y
            
            PLY
        
        .chain_link_too_close
    DEC.b $08 : BPL .next_chain_link
    
    .no_chain_links
    
    PLX
    
    RTS
}

; ==============================================================================
