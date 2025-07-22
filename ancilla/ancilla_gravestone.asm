; ==============================================================================

; NOTE: Performs movement and player interaction of the gravestone.
; $046D89-$046DF8 LONG JUMP LOCATION
Gravestone_Move:
{
    PHB : PHK : PLB
    
    LDA.b $11 : BNE .return
        LDA.b #$F8 : STA.w $0C22, X
        
        JSR.w Ancilla_MoveVert
        JSR.w Gravestone_RepelPlayerAdvance
        
        LDA.w $038A, X : STA.b $00
        LDA.w $038F, X : STA.b $01
        
        LDA.w $0BFA, X : STA.b $02
        LDA.w $0C0E, X : STA.b $03
        
        REP #$20
        
        ; Wait until the gravestone reaches its target y coordinate...
        ; This only works because... eh. Have to see this in action. Seems
        ; like there would be a sudden change in the underlying tiles.
        LDA.b $02 : CMP.b $00 : SEP #$20 : BCS .return
            STZ.w $0C4A, X
            STZ.w $03E9
            
            LDA.b $48 : AND.b #$FB : STA.b $48
            
            LDA.w $03BA, X : STA.b $72
            LDA.w $03B6, X : STA.b $73
            
            REP #$20
            
            LDA.b $72 : STA.w $0698
            
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
    
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    LDA.b #$10
    JSL.l OAM_AllocateFromRegionB
    
    LDY.b #$00 : TYX
    
    .next_OAM_entry
    
        JSR.w Ancilla_SetOam_XY
        
        LDA.w Pool_Ancilla_Gravestone_chr, X : STA.b ($90), Y

        INY
        LDA.w Pool_Ancilla_Gravestone_properties, X : ORA.b #$3D : STA.b ($90), Y

        INY : PHY
        TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
        
        LDA.b #$02 : STA.b ($92), Y
        
        PLY : INX
        
        REP #$20
        
        LDA.b $02 : CLC : ADC.w #$0010 : STA.b $02
        
        CPX.b #$02 : BNE .still_drawing_left_half
            ; The last two are further to the right.
            LDA.b $00 : CLC : ADC.w #$0008 : STA.b $00
            LDA.b $06                      : STA.b $02
        
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
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w #$0018 : STA.b $04
    LDA.b $02 : CLC : ADC.w #$0020 : STA.b $06
    
    LDA.b $20 : CLC : ADC.w #$0008 : STA.b $08 : CMP.b $00 : BCC .player_not_close
                                                 CMP.b $04 : BCS .player_not_close
        LDA.b $22 : CLC : ADC.w #$0008 : CMP.b $02 : BCC .player_not_close
                                         CMP.b $06 : BCC .player_not_close
            LDA.b $08 : SEC : SBC.b $04 : BPL .player_below_object
                EOR.w #$FFFF : INC
            
            .player_below_object
            
                              STA.b $0A
            CLC : ADC.b $20 : STA.b $20
            
            LDA.b $30 : CMP.w #$0080 : BCC .sign_already_proper
                ORA.w #$FF00
            
            .sign_already_proper
            
            STA.b $08
            
            LDA.b $0A : CLC : ADC.b $08 : AND.w #$00FF : STA.b $08
            
            LDA.b $30 : AND.w #$FF00 : ORA.b $08 : STA.b $30
            
            LDA.w #$0004 : TSB.b $48
    
    .player_not_close
    
    SEP #$20
    
    LDA.b $2F : BEQ .dont_negate_grab_pose
        LDA.b $48 : AND.b #$FB : STA.b $48
    
    .dont_negate_grab_pose
    
    RTS
}

; ==============================================================================
