
; ==============================================================================

; $04B419-$04B428 DATA
Pool_Garnish_LightningTrail:
{
    .chr
    db $CC, $EC, $CE, $EE, $CC, $EC, $CE, $EE
    
    .properties
    db $31, $31, $31, $31, $71, $71, $71, $71
}

; ==============================================================================

; $04B429-$04B495 JUMP LOCATION
Garnish_LightningTrail:
{
    ; special animation 0x09
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    LDA.l $7FF92C, X : PHX : TAX
    
    LDA.w .chr, X : PHX
    
    LDX.w $048E : CPX.b #$20 : BNE .not_agahnim_1_room
    
    ; WTF: Is this a kludge having to do with the tileset being loaded into
    ; a different slot in Agahnim's room?
    SEC : SBC.b #$80
    
    .not_agahnim_1_room
    
    PLX
    
    INY : STA ($90), Y
    
    LDA.b $1A : ASL A : AND.b #$0E : ORA .properties, X
    
    PLX
    
    JSR.w Garnish_SetOamPropsAndLargeSize
    
    ; $04B459 ALTERNATE ENTRY POINT
    shared Garnish_CheckPlayerCollision:
    
    TXA : EOR.b $1A : AND.b #$07
                    ORA.w $031F
                    ORA.w $037B : BNE .no_collision
    
    LDA.b $22 : SBC.b $E2 : SBC.b $00 : ADC.b #$0C
                                  CMP.b #$18 : BCS .no_collision
    
    LDA.b $20 : SBC.b $E8 : SBC.b $02 : ADC.b #$16
                                  CMP.b #$1C : BCS .no_collision
    
    LDA.b #$01 : STA.b $4D
    
    LDA.b #$10 : STA.b $46 : STA.w $0373
    
    LDA.b $28 : EOR.b #$FF : STA.b $28
    LDA.b $27 : EOR.b #$FF : STA.b $27
    
    .no_collision
    
    RTS
}

; ==============================================================================
