
; ==============================================================================

; $0288C5-$0288D5 JUMP LOCATION
Sprite_MasterSword:
{
    LDA.w $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MasterSword_Main
    dw Sprite_MasterLightFountain 
    dw Sprite_MasterLightBeam 
    dw Sprite_MasterSwordPendant
    dw Sprite_MasterLightWell
}

; ==============================================================================

; $0288D6-$028907 JUMP LOCATION
MasterSword_Main:
{
    LDA $10 : CMP.b #$1A : BEQ .in_end_sequence
    
    PHX
    
    LDX $8A
    
    LDA.l $7EF280, X : PLX : AND.b #$40 : BEQ .hasnt_been_taken
    
    JMP MasterSword_Terminate
    
    .hasnt_been_taken
    .in_end_sequence
    
    LDA.w $0D80, X : CMP.b #$05 : BEQ .skip_routine
    
    JSR MasterSword_Draw
    
    .skip_routine
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MasterSword_ReadyAndWaiting
    dw MasterSword_PendantsInTransit
    dw MasterSword_CrankUpLightShow
    dw MasterSword_LightShowIsCrunk
    dw MasterSword_GrantToPlayer
    dw MasterSword_Terminate
}

; ==============================================================================

; $028908-$02894C JUMP LOCATION
MasterSword_ReadyAndWaiting:
{
    ; (Player in unusual pose => fail)
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .cant_pull
    
    ; (Not in contact with the sprite => fail)
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .cant_pull
    
    LDA $2F : CMP.b #$02 : BNE .cant_pull
    
    ; (The 'A' button hasn't been pressed => fail)
    LDA $F6 : BPL .cant_pull
    
    ; (Don't have three pendants => fail)
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .cant_pull
    
    ; play "retrieving the master sword" music
    LDA.b #$0A : STA.w $012C
    
    LDA.b #$01 : STA.w $037B
    
    ; Spawn each of the pendant helper sprites
    LDA.b #$09 : JSR MasterSword_SpawnPendant
    LDA.b #$0B : JSR MasterSword_SpawnPendant
    LDA.b #$0F : JSR MasterSword_SpawnPendant
    
    JSR MasterSword_SpawnLightWell
    
    INC.w $0D80, X
    
    LDA.b #$F0 : STA.w $0DF0, X
    
    .cant_pull
    
    RTS
}

; ==============================================================================

; $02894D-$028967 JUMP LOCATION
MasterSword_PendantsInTransit:
{
    LDA.w $0DF0, X : BNE .wait
    
    JSR MasterSword_SpawnLightFountain
    
    INC.w $0D8080, X
    
    LDA.b #$C0 : STA.w $0DF0, X
    
    .wait
    
    ; Special pose for Link?
    LDA.b #$0A : STA.w $0377
    
    ; Link can't move...
    LDA.b #$01 : STA.w $02E4
    
    RTS
}

; ==============================================================================

; $028968-$02899C JUMP LOCATION
MasterSword_CrankUpLightShow:
{
    LDA.w $0DF0, X : BNE .wait
    
    LDY.b #$FF : JSR MasterSword_SpawnLightBeams
    
    INC.w $0D80, X
    
    LDA.b #$08 : STA.w $0DF0, X
    
    .wait
    
    LDA.b #$0A
    
    BRA .immobilize_player
    
    ; $02897E ALTERNATE ENTRY POINT
    shared MasterSword_LightShowIsCrunk:
    
    LDA.w $0DF0, X : BNE .wait_2
    
    LDA.b #$01
    LDY.b #$FF
    
    JSR MasterSword_SpawnLightBeams
    
    INC.w $0D80, X
    
    LDA.b #$10 : STA.w $0DF0, X
    
    .wait_2
    
    LDA.b #$0B
    
    .immobilize_player
    
    STA.w $0377
    
    ; Link can't move...
    LDA.b #$01 : STA.w $02E4
    
    RTS
}

; ==============================================================================

; $02899D-$0289C5 JUMP LOCATION
MasterSword_GrantToPlayer:
{
    LDA.w $0DF0, X : BNE .wait
    
    PHX
    
    LDX $8A
    
    ; Make it so the Master Sword won't show up again here.
    LDA.l $7EF280, X : ORA.b #$40 : STA.l $7EF280, X
    
    LDY.b #$01
    
    STZ.w $02E9
    
    JSL Link_ReceiveItem
    
    PLX
    
    ; Change Overworld map icon set
    LDA.b #$05 : STA.l $7EF3C7
    
    ; Disable this shit, whatever it was (probably player oam related).
    STZ.w $0377
    
    INC.w $0D80, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $0289C6-$0289C9 JUMP LOCATION
MasterSword_Terminate:
{
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0289CA-$0289DB DATA
Pool_Sprite_MasterLightFountain:
{
    .animation_states
    db $00, $01, $01, $02, $02, $02, $01, $01, $00
    
    .unknown
    db $00, $00, $01, $01, $02, $02, $00, $00, $00
}

; ==============================================================================

; $0289DC-$028A15 JUMP LOCATION
Sprite_MasterLightFountain:
{
    JSR MasterSword_DrawLightBall
    
    INC.w $0D90, X : LDA.w $0D90, X : BNE .alpha
    
    INC.w $0DB0, X
    
    STZ.w $0DD0, X
    
    .alpha
    
    LSR #2 : AND.b #$03 : STA.w $0DE0, X
    
    LDA.w $0D90, X : LSR #5 : AND.b #$07 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA .unknown, Y : BEQ .beta
    
    TAY
    
    LDA.w $0D90, X : LSR #2 : AND.b #$01
    
    JSR MasterSword_SpawnLightBeams
    
    .beta
    
    RTS
}

; ==============================================================================

; $028A16-$028A33 JUMP LOCATION
Sprite_MasterLightWell:
{
    JSR MasterSword_DrawLightBall
    
    INC.w $0D90, X : LDA.w $0D90, X : BNE .alpha
    
    INC.w $0DB0, X
    
    STZ.w $0DD0, X
    
    .alpha
    
    LSR #2 : AND.b #$03 : STA.w $0DE0, X
    
    LDA.b #$00 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $028A34-$028A93 DATA
Pool_MasterSword_DrawLightBall:
{
    .animation_states
    dw -6, 4 : db $82, $00, $00, $02
    dw -6, 4 : db $82, $40, $00, $02
    dw -6, 4 : db $82, $C0, $00, $02
    dw -6, 4 : db $82, $80, $00, $02
    dw -6, 4 : db $A0, $00, $00, $02
    dw -6, 4 : db $A0, $40, $00, $02
    dw -6, 4 : db $A0, $C0, $00, $02
    dw -6, 4 : db $A0, $80, $00, $02
    dw -6, 4 : db $80, $00, $00, $02
    dw -6, 4 : db $80, $40, $00, $02
    dw -6, 4 : db $80, $C0, $00, $02
    dw -6, 4 : db $80, $80, $00, $02
}

; ==============================================================================

; $028A94-$028AB5 LOCAL JUMP LOCATION
MasterSword_DrawLightBall:
{
    ; Generic routine that can draw either the light fountain (bigger) 
    ; or the light well (smaller). Technically the light well and fountain
    ; could have been merged into the same sprite, I'm fairly certain of
    ; this.
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionC
    
    LDA.w $0DC0, X : ASL #2 : ADC.w $0DE0, X : ASL #3 
    
    ADC.b #((.animation_states >> 0) & $FF)              : STA $08
    LDA.b #((.animation_states >> 8) & $FF) : ADC.b #$00 : STA $09
    
    LDA.b #$01
    
    ; $028AB1 ALTERNATE ENTRY POINT
    shared Sprite_DrawMultipleRedundantCall:
    
    ; The point of the name I chose for this routine is that there's 
    ; really no reason why client code couldn't just call
    ; Sprite_DrawMultiple directly, so this is just a waste of cpu time.
    
    JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $028AB6-$028ACF LOCAL JUMP LOCATION
MasterSword_SpawnLightWell:
{
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$04 : STA.w $0E80, Y
    LDA.b #$05 : STA.w $0F50, Y
    LDA.b #$00 : STA.w $0E40, Y
    
    RTS
}

; ==============================================================================

; $028AD0-$028AE9 LOCAL JUMP LOCATION
MasterSword_SpawnLightFountain:
{
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$01 : STA.w $0E80, Y
    LDA.b #$05 : STA.w $0F50, Y
    LDA.b #$00 : STA.w $0E40, Y
    
    RTS
}

; ==============================================================================

; $028AEA-$028B07 JUMP LOCATION
Sprite_MasterLightBeam:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0D90, X : BEQ .alpha
    
    JSR Sprite2_Move
    
    LDA $1A : AND.b #$03 : BNE .beta
    
    JSR MasterLightBeam_SpawnAnotherBeam
    
    .alpha
    
    DEC.w $0DA0, X : BNE .beta
    
    STZ.w $0DD0, X
    
    .beta
    
    RTS
}

; ==============================================================================

; $028B08-$028B1F DATA
Pool_MasterSword_SpawnLightBeams:
{
    .x_speeds_1
    db $00, $D0
    
    .x_speeds_2
    db $00, $30
    
    .x_speeds_3
    db $A0, $D0
    
    .x_speeds_4
    db $60, $30
    
    .y_speeds_1
    db $A0, $D0
    
    .y_speeds_2
    db $60, $30
    
    .y_speeds_3
    db $00, $30
    
    .y_speeds_4
    db $00, $D0
    
    .animation_states_1
    db $01, $00
    
    .animation_states_2
    db $03, $02
    
    .oam_properties_1
    db $05, $45
    
    .oam_properties_2
    db $05, $05
}

; ==============================================================================

; $028B20-$028B61 LOCAL JUMP LOCATION
MasterLightBeam_SpawnAnotherBeam:
{
    ; Not sure if the name is 100% accurate, but I can always change it
    ; later.
    
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically : BMI .alpha
    
    LDA $00 : CLC : ADC.b #$00 : STA.w $0D10, Y
    LDA $01 : ADC.b #$00 : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$00 : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E80, Y
    
    LDA.b #$03 : STA.w $0DA0, Y
    
    LDA.w $0DC0, X : STA.w $0DC0, Y
    
    LDA.w $0F50, X : STA.w $0F50, Y
    
    LDA.b #$00 : STA.w $0E40, Y
    
    .alpha
    
    RTS
}

; ==============================================================================

; $028B62-$028CD2 LOCAL JUMP LOCATION
MasterSword_SpawnLightBeams:
{
    PHY : PHA
    
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically : BPL .success_1
    
    JMP .spawn_failed
    
    .success_1
    
    LDA $00 : SEC : SBC.b #$04 : STA.w $0D10, Y
    LDA $01 : SBC.b #$00 : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$04 : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D2020, Y
    
    LDA.b #$02 : STA.w $0E80, Y : STA.w $0D90, Y
    
    LDA.b #$00 : STA.w $0E40, Y
    
    PLA
    
    PHX
    
    TAX
    
    LDA .x_speeds_1, X : STA.w $0D50, Y
    
    LDA .y_speeds_1, X : STA.w $0D40, Y
    
    LDA .animation_states_1, X : STA.w $0DC0, Y
    
    LDA .oam_properties_1, X : STA.w $0F50, Y
    
    TXA
    
    PLX
    
    STA $00
    
    PLA : STA.w $0DA0, Y : PHA
    
    LDA $00 : PHA
    
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically : BPL .success_2
    
    JMP .spawn_failed
    
    .success_2
    
    LDA $00 : SEC : SBC.b #$04 : STA.w $0D10, Y
    LDA $01 : SBC.b #$00 : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$04 : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E8080, Y : STA.w $0D9090, Y
    
    LDA.b #$00 : STA.w $0E4040, Y
    
    PLA
    
    PHX
    
    TAX
    
    LDA .x_speeds_2, X : STA.w $0D50, Y
    
    LDA .y_speeds_2, X : STA.w $0D40, Y
    
    LDA .animation_states_1, X : STA.w $0DC0, Y
    
    LDA .oam_properties_1, X : STA.w $0F50, Y
    
    TXA
    
    PLX
    
    STA $00
    
    PLA : STA.w $0DA0A0, Y : PHA
    
    LDA $00 : PHA
    
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically : BPL .success_3
    
    JMP .spawn_failed
    
    .success_3
    
    LDA $00 : SEC : SBC.b #$04 : STA.w $0D10, Y
    LDA $01 : SBC.b #$00 : STA.w $0D3030, Y
    
    LDA $02 : CLC : ADC.b #$04 : STA.w $0D0000, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E80, Y : STA.w $0D90, Y
    
    LDA.b #$00 : STA.w $0E4040, Y
    
    PLA
    
    PHX
    
    TAX
    
    LDA .x_speeds_3, X : STA.w $0D5050, Y
    
    LDA .y_speeds_3, X : STA.w $0D4040, Y
    
    LDA .animation_states_2, X : STA.w $0DC0, Y
    
    LDA .oam_properties_2, X : STA.w $0F50, Y
    
    TXA
    
    PLX
    
    STA $00
    
    PLA : STA.w $0DA0, Y
    
    PHA
    
    LDA $00 : PHA
    
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA $00 : SEC : SBC.b #$04 : STA.w $0D10, Y
    LDA $01 : SBC.b #$00 : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$04 : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E80, Y : STA.w $0D90, Y
    
    LDA.b #$00 : STA.w $0E40, Y
    
    PLA
    
    PHX
    
    TAX
    
    LDA .x_speeds_4, X : STA.w $0D50, Y
    
    LDA .y_speeds_4, X : STA.w $0D40, Y
    
    LDA .animation_states_2, X : STA.w $0DC0, Y
    
    LDA .oam_properties_2, X : STA.w $0F50, Y
    
    TXA
    
    PLX
    
    PLA : STA.w $0DA0, Y
    
    RTS
    
    .spawn_failed
    
    PLA : PLY
    
    RTS
}

; ==============================================================================

; $028CD3-$028D28 LOCAL JUMP LOCATION
MasterSword_SpawnPendant:
{
    PHA
    
    ; Master Sword and beams of light ceremony
    LDA.b #$62
    
    JSL Sprite_SpawnDynamically
    
    PLA : STA.w $0F50, Y
    
    LDA $22 : STA.w $0D10, Y
    LDA $23 : STA.w $0D30, Y
    
    LDA $20 : CLC : ADC.b #$08 : STA.w $0D00, Y
    LDA $21 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$04 : STA.w $0DC0, Y
    
    LDA.b #$03 : STA.w $0E80, Y
    
    LDA.b #$40 : STA.w $0E40, Y
    
    LDA.b #$E4 : STA.w $0DF0, Y
    
    PHX
    
    LDA.w $0F50, Y : LSR A : AND.b #$03 : TAX
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    PLX
    
    RTS
    
    .x_speeds
    db $FC, $04, $00, $00
    
    .y_speeds
    db $FE, $FE, $FC, $FC
}

; ==============================================================================

; $028D29-$028D3F JUMP LOCATION
Sprite_MasterSwordPendant:
{
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MasterSwordPendant_DriftingAway
    dw MasterSwordPendant_Flashing
    dw MasterSwordPendant_FlyAway
}

; ==============================================================================

; $028D40-$028D56 JUMP LOCATION
MasterSwordPendant_DriftingAway:
{
    JSR Sprite2_Move
    
    LDA.w $0DF0, X : BNE .wait
    
    INC.w $0D80, X
    
    LDA.b #$D0 : STA.w $0DF0, X
    
    LDA.w $0F50, X : STA.w $0D90, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $028D57-$028D79 JUMP LOCATION
MasterSwordPendant_Flashing:
{
    LDA.w $0F50, X : AND.b #$F1 : STA.w $0F50, X
    
    TXA : ASL A : EOR $1A : AND.b #$0E : ORA.w $0F50, X : STA.w $0F50, X
    
    LDA.w $0DF0, X : BNE .wait
    
    INC.w $0D80, X
    
    ; Restore original palette color (blue, green, or red).
    LDA.w $0D90, X : STA.w $0F50, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $028D7A-$028D95 JUMP LOCATION
MasterSwordPendant_FlyAway:
{
    ; This one gives me the impression of being poorly put together.
    ; I could be wrong, but I don't think it works as intended. Will
    ; will have to observe this in real time.
    
    JSR Sprite2_Move
    
    LDA.w $0DF0, X : BNE .wait
    
    ; double X and Y speed.... but not quite? (negative speeds would be...
    ; reversed)
    ASL.w $0D50, X
    
    ASL.w $0D40, X
    
    LDA.b #$06 : STA.w $0DF0, X
    
    .wait
    
    INC.w $0E90, X : BNE .beta
    
    STZ.w $0DD0, X
    
    .beta
    
    RTS
}

; ==============================================================================

; $028D96-$028DA7 DATA
Pool_MasterSword_Draw:
{
    .x_offsets
    db -8,  0, -8,  0, -8,  0
    
    .y_offsets
    db -8, -8,  0,  0,  8,  8
    
    .chr
    db $C3, $C4, $D3, $D4, $E0, $F0
}


; ==============================================================================

; $028DA8-$028DD7 LOCAL JUMP LOCATION
MasterSword_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    PHX
    
    LDX.b #$05
    
    .alpha
    
    LDA $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
    LDA $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    LDA .chr, X                  : INY : STA ($90), Y
    
    INY
    
    LDA $05 : STA ($90), Y
    
    INY
    
    DEX : BPL .alpha
    
    PLX
    
    LDY.b #$00
    LDA.b #$05
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================
