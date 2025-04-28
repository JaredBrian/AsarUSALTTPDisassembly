; ==============================================================================

; NOTE: Performs movement and player interaction of the gravestone.
; $046D89-$046DF8 LONG JUMP LOCATION
Gravestone_Move:
{
    PHB : PHK : PLB
    
    LDA $11 : BNE .return
        LDA.b #$F8 : STA.w $0C22, X
        
        JSR.w Ancilla_MoveVert
        JSR.w Gravestone_RepelPlayerAdvance
        
        LDA.w $038A, X : STA $00
        LDA.w $038F, X : STA $01
        
        LDA.w $0BFA, X : STA $02
        LDA.w $0C0E, X : STA $03
        
        REP #$20
        
        ; Wait until the gravestone reaches its target y coordinate...
        ; This only works because... eh. Have to see this in action. Seems
        ; like there would be a sudden change in the underlying tiles.
        LDA $02 : CMP $00 : SEP #$20 : BCS .return
            STZ.w $0C4A, X
            STZ.w $03E9
            
            LDA $48 : AND.b #$FB : STA $48
            
            LDA.w $03BA, X : STA $72
            LDA.w $03B6, X : STA $73
            
            REP #$20
            
            LDA $72 : STA.w $0698
            
            ; This accomplishes the second part of the map16 update (which
            ; actually updates a 32x32 region).
            LDY.b #$48
            
            ; Grave Special Stairs.
            CMP.w #$0532 : BEQ .not_particular_addresses
                LDY.b #$60
                
                ; Grave Special Hole.
                CMP.w #$0488 : BEQ .not_particular_addresses
                    LDY.b #$40
            
            .not_particular_addresses
            
            TYA : AND.w #$00FF : STA.w $0692
            
            SEP #$20
            
            PHX
            
            JSL.l Overworld_DoMapUpdate32x32_Long
            
            PLX
            
            ; OPTIMIZE: Useless branch.
            BRA .return
        
    .return	
    
    PLB
    
    RTL
}

; ==============================================================================

; $046DF9-$046E00 DATA
Pool_Ancilla_Gravestone:
{
    ; $046DF9
    .chr
    db $C8, $C8, $D8, $D8
    
    ; $046DFD
    .properties
    db $00, $40, $00, $40
}

; NOTE: Unlike many Ancilla handlers, this guy only handles drawing
; of the object. The actual movement and other logic of the gravestone
; is driven by the player engine, called from a routine found above
; (Gravestone_Move).
; $046E01-$046E56 JUMP LOCATION
Ancilla_Gravestone:
{
    PHX
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    LDA $02 : STA $06
    
    SEP #$20
    
    LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
    
    LDY.b #$00 : TYX
    
    .next_OAM_entry
    
        JSR.w Ancilla_SetOam_XY
        
        LDA.w Pool_Ancilla_Gravestone_chr, X : STA ($90), Y
        INY

        LDA.w Pool_Ancilla_Gravestone_properties, X : ORA.b #$3D : STA ($90), Y
        INY
        
        PHY
        
        TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$02 : STA ($92), Y
        
        PLY : INX
        
        REP #$20
        
        LDA $02 : CLC : ADC.w #$0010 : STA $02
        
        CPX.b #$02 : BNE .still_drawing_left_half
            ; The last two are further to the right.
            LDA $00 : CLC : ADC.w #$0008 : STA $00
            LDA $06                      : STA $02
        
        .still_drawing_left_half
        
        SEP #$20
    CPX.b #$04 : BNE .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================

; $046E57-$046EDD LOCAL JUMP LOCATION
Gravestone_RepelPlayerAdvance:
{
    LDA.w $0BFA, X : STA $00
    LDA.w $0C0E, X : STA $01
    
    LDA.w $0C04, X : STA $02
    LDA.w $0C18, X : STA $03
    
    REP #$20
    
    LDA $00 : CLC : ADC.w #$0018 : STA $04
    LDA $02 : CLC : ADC.w #$0020 : STA $06
    
    LDA $20 : CLC : ADC.w #$0008 : STA $08 : CMP $00 : BCC .player_not_close
                                             CMP $04 : BCS .player_not_close
        LDA $22 : CLC : ADC.w #$0008 : CMP $02 : BCC .player_not_close
                                       CMP $06 : BCC .player_not_close
            LDA $08 : SEC : SBC $04 : BPL .player_below_object
                EOR.w #$FFFF : INC A
            
            .player_below_object
            
            STA $0A
            
            CLC : ADC $20 : STA $20
            
            LDA $30 : CMP.w #$0080 : BCC .sign_already_proper
                ORA.w #$FF00
            
            .sign_already_proper
            
            STA $08
            
            LDA $0A : CLC : ADC $08 : AND.w #$00FF : STA $08
            
            LDA $30 : AND.w #$FF00 : ORA $08 : STA $30
            
            LDA.w #$0004 : TSB $48
    
    .player_not_close
    
    SEP #$20
    
    LDA $2F : BEQ .dont_negate_grab_pose
        LDA $48 : AND.b #$FB : STA $48
    
    .dont_negate_grab_pose
    
    RTS
}

; ==============================================================================
