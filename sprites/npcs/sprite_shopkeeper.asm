
; ==============================================================================

; $0F6EEF-$0F6F11 JUMP LOCATION
Sprite_ShopKeeper:
{
    LDA $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $EF12 ; = $F6F12* ; 
    dw $EF90 ; = $F6F90*
    dw $F038 ; = $F7038*
    dw $F078 ; = $F7078*
    dw $F0F3 ; = $F70F3* ; 
    dw $F14F ; = $F714F* ; Thief talkin about Ice Cave near Lake Hylia.
    dw $F14F ; = $F714F* ; Thief talkin about defeating enemies for rupees.
    dw $F16E ; = $F716E* ; 
    dw $F1F2 ; = $F71F2* ; 
    dw $F230 ; = $F7230* ;  
    dw $F27D ; = $F727D* ; 
    dw $F2AF ; = $F72AF* ; 
    dw $F2F0 ; = $F72F0* ; 
    dw $F322 ; = $F7322* ; 
}

; $0F6F12-$0F6F6C JUMP LOCATION
{
    LDA $0FFF : BEQ .in_light_world
    
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    LDA $0F50, X : AND.b #$3F : STA $00
    
    LDA $1A : ASL #3 : AND.b #$40 : ORA $00 : STA $0F50, X
    
    .BRANCH_BETA
    
    JSL Sprite_PlayerCantPassThrough
    
    LDY $0FFF
    
    LDA.w $EF69, Y       : XBA
    LDA.w $EF6B, Y : TAY : XBA
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    LDA $0D80, X : BEQ .BRANCH_F6F6D
    
    BRA .BRANCH_F6F8F ; (RTS)
    
    .in_light_world
    
    LDA.b #$07 : STA $0F50, X
    
    JSL Shopkeeper_Draw
    JSR Sprite3_CheckIfActive
    
    LDA $1A : LSR #4 : AND.b #$01 : STA $0DC0, X
    
    BRA .BRANCH_BETA
    
    .messages_low
    ; "May I help you? Select the thing you like (...). Prices as marked!"
    ; "In such a dangerous world you may need many things..."
    db $65, $5F
    
    .messsages_high
    db $01, $01
}

; $0F6F6D-$0F6F8F LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA $0FDA : CLC : ADC.w #$0060 : CMP $20 : SEP #$30 : BCC .BRANCH_ALPHA
    
    LDY $0FFF
    
    LDA.w $EF69, Y       : XBA
    LDA.w $EF6B, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F6F90-$0F6FBE JUMP LOCATION
{
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0F50, X : AND.b #$3F : STA $00
    
    LDA $1A : ASL #3 : AND.b #$40 : ORA $00 : STA $0F50, X
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $EFBF ; = $F6FBF*
    dw $EFD5 ; = $F6FD5*
    dw $F000 ; = $F7000*
}

; $0F6FBF-$0F6FD4 JUMP LOCATION
{
    LDA $04C4 : DEC A : CMP.b #$02 : BCC .BRANCH_ALPHA
    
    LDA.b #$60
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F6FD5-$0F6FFF JUMP LOCATION
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    LDA.b #$1E
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_ALPHA
    
    LDA.b #$02 : STA $04C4
    
    LDA.b #$64
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$61
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $0F7000-$0F7016 JUMP LOCATION
{
    LDA $04C4 : BNE .BRANCH_ALPHA
    
    LDA.b #$63
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$7F
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $0F7017-$0F7037 LOCAL JUMP LOCATION
{
    LDA $1A : AND.b #$03 : BNE .BRANCH_ALPHA
    
    LDA.b #$02 : STA $0DC0, X
    
    JSR Sprite3_DirectionToFacePlayer
    
    CPY.b #$03 : BNE .BRANCH_BETA
    
    LDY.b #$02
    
    .BRANCH_BETA
    
    TYA : STA $0EB0, X
    
    .BRANCH_ALPHA
    
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    JSL Thief_Draw
    
    RTS
}

; $0F7038-$0F704E JUMP LOCATION
{
    JSR $F017 ; $0F7017 IN ROM
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F04F ; = $F704F*
    dw $F05D ; = $F705D*
    dw $F074 ; = $F7074*
}

; $0F704F-$0F705C JUMP LOCATION
{
    LDA.b #$76
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F705D-$0F7077 JUMP LOCATION
{
    LDA $0403 : AND.b #$40 : BNE .BRANCH_ALPHA
    
    LDA $0403 : ORA.b #$40 : STA $0403
    
    INC $0D80, X
    
    LDY.b #$46 : JMP $F366 ; $0F7366 IN ROM
    
    ; $0F7074 ALTERNATE ENTRY PONT
    .BRANCH_ALPHA
    
    STZ $0D80, X
    
    RTS
}

; $0F7078-$0F709B JUMP LOCATION
{
    JSR Sprite3_DirectionToFacePlayer
    
    TYA : EOR.b #$03 : STA $0DE0, X
    
    STZ $0DC0, X
    
    JSL MazeGameGuy_Draw
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F09C ; = $F709C*
    dw $F0B2 ; = $F70B2*
    dw $F0E1 ; = $F70E1*
}

; $0F709C-$0F70B1 JUMP LOCATION
{
    LDA $04C4 : DEC A : CMP.b #$02 : BCC .BRANCH_ALPHA
    
    ; "Pay me 20 Rupees and I'll let you open one chest. ...
    LDA.b #$7E
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F70B2-$0F70DC JUMP LOCATION
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    LDA.b #$14
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_ALPHA
    
    LDA.b #$01 : STA $04C4
    
    LDA.b #$7F
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$80
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $0F70DD-$0F70E0 DATA
    pool 
{
    .messages_low
    ; "You can't open any more chests. The game is over."
    ; "Oh, I see...  Too bad. Drop by again after collecting Rupees."
    db $63, $7F
    
    .messages_high
    db $01, $01
}

; $0F70E1-$0F70F2 JUMP LOCATION
{
    LDA $04C4 : TAY
    
    ; \bug Maybe? Don't see how the second message could ever occur so far.
    LDA.w $F0DD, Y       : XBA
    LDA.w $F0DF, Y : TAY : XBA
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $0F70F3-$0F7109 JUMP LOCATION
{
    JSR $F017 ; $0F7017 IN ROM
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F10A ; = $F710A*
    dw $F120 ; = $F7120*
    dw $F0E1 ; = $F70E1*
}

; $0F710A-$0F711F JUMP LOCATION
{
    ; \bug Maybe? More like unnecessary given the structure of the minigame?
    LDA $04C4 : DEC A : CMP.b #$02 : BCC .BRANCH_$F70B1 ; (RTS)
    
    ; "For 100 Rupees, I'll let you open one chest and keep the treasure..."
    LDA.b #$81
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
    
    INC $0D80, X
    
    .didnt_speak
    
    RTS
}

; $0F7120-$0F714A JUMP LOCATION
{
    LDA $1CE8 : BNE .player_declined
    
    LDA.b #$64
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .cant_afford
    
    LDA.b #$01 : STA $04C4
    
    ; "All right! Open the chest you like!"
    LDA.b #$7F
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    RTS
    
    .cant_afford
    .player_declined
    
    ; "Oh, I see... Too bad. Drop by again after collecting Rupees."
    LDA.b #$80
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $0F714B-$0F714E JUMP LOCATION
{
    .messages_low
    ; "Check out the cave east of Lake Hylia. Strange and wonderful..."
    ; "You can earn a lot of Rupees by defeating enemies. It's the ..."
    db $77, $78
    
    .messages_high
    db $01, $01
}

; $0F714F-$0F716D JUMP LOCATION
{
    JSR $F017   ; $0F7017 IN ROM
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0E80, X : SEC : SBC.b #$05 : TAY
    
    LDA.w $F14B, Y : XBA
    LDA.w $F14D, Y : TAY : XBA
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}


; $0F716E-$0F71AC JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    JSL Sprite_GetEmptyBottleIndex : BMI .BRANCH_BETA
    
    LDA.b #$96
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .player_cant_afford
    
    STZ $0DD0, X
    
    LDY.b #$2E : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$6D
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    JSR $F38A ; $0F738A IN ROM
    
    RTS
    
    ; $0F71A1 ALTERNATE ENTRY POINT
    .player_cant_afford
    
    LDA.b #$7C
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    JSR $F38A ; $0F738A IN ROM
    
    RTS
}

; ==============================================================================

; $0F71AD-$0F71B2 DATA
pool ShopKeeper_SpawnInventoryItem:
{
    .x_offsets
    dw -44, 8, 60
}

; ==============================================================================

; $0F71B3-$0F71F1 LONG JUMP LOCATION
ShopKeeper_SpawnInventoryItem:
{
    PHA : PHY
    
    LDA.b #$BB
    LDY.b #$0C
    
    JSL Sprite_SpawnDynamically.arbitrary
    
    PLA : STA $0E80, Y : STA $0BA0, Y
    
    PLA : PHX : ASL A : TAX
    
    LDA $00 : CLC : ADC.l .x_offsets + 0, X : STA $0D10, Y
    LDA $01 : ADC.l .x_offsets + 1, X : STA $0D30, Y
    
    LDA $02 : CLC : ADC.b #$27 : STA $0D00, Y
    LDA $03              : STA $0D20, Y
    
    LDA $0E40, Y : ORA.b #$04 : STA $0E40, Y
    
    PLX
    
    RTL
}

; ==============================================================================

; $0F71F2-$0F722F JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    JSR $F261 ; $0F7261 IN ROM
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    LDA $7EF35A : BNE .BRANCH_BETA
    
    LDA.b #$32
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
    
    STZ $0DD0, X
    
    LDY.b #$04 : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$1C : STA $0F60, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$66
    
    ; $0F7221 ALTERNATE ENTRY POINT
    
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    JSR $F38A   ; $0F738A IN ROM
    
    RTS
    
    ; $0F722D ALTERNATE ENTRY POINT
    .BRANCH_GAMMA
    
    JMP $F1A1 ; $0F71A1 IN ROM
}

; $0F7230-$0F7260 JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    JSR $F261   ; $0F7261 IN ROM
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    LDA $7EF35A : CMP.b #$02 : BCS .BRANCH_$F7221
    
    LDA.b #$F4
    LDY.b #$01
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_$F722D
    
    STZ $0DD0, X
    
    LDY.b #$05 : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$1C : STA $0F60, X
    
    RTS
}

; ==============================================================================

; $0F7261-$0F727C LOCAL JUMP LOCATION
{
    STZ $0BA0, X
    
    LDA.b #$08 : STA $0B6B, X
    
    LDA.b #$04 : STA $0CAA, X
    
    LDA.b #$1C : STA $0F60, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    LDA.b #$0A : STA $0F60, X
    
    RTS
}

; ==============================================================================
    
; $0F727D-$0F72AE JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    LDA $7EF36C : CMP $7EF36D : BEQ .BRANCH_BETA
    
    LDA.b #$0A
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
    
    STZ $0DD0, X
    
    LDY.b #$42 : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    JSR $F38A ; $0F738A IN ROM
    
    RTS
    
    .BRANCH_GAMMA
    
    JMP $F1A1 ; $0F71A1 IN ROM
}

; $0F72AF-$0F72EF JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    JSR ShopKeeper_CheckPlayerSolicitedDamage
    
    BCC .BRANCH_ALPHA
    
    LDA $7EF371
    
    PHX
    
    TAX
    
    LDA $0DDB58, X : PLX : CMP $7EF377 : BEQ .BRANCH_BETA
    
    LDA.b #$1E
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
    
    STZ $0DD0, X
    
    LDY.b #$44 : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    RTS
    
    ; $0F72E1 ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    LDA.b #$6E
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    JSR $F38A   ; $0F738A IN ROM
    
    RTS
    
    ; $0F72ED ALTERNATE ENTRY POINT
    .BRANCH_GAMMA
    
    JMP $F1A1 ; $0F71A1 IN ROM
}

; $0F72F0-$0F7321 JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    LDA $7EF370 : PHX
    
    TAX
    
    LDA $0DDB48, X
    
    PLX
    
    CMP $7EF343 : BEQ .BRANCH_F72E1
    
    LDA.b #$32
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_$F72ED
    
    STZ $0DD0, X
    
    LDY.b #$31 : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F7322-$0F7357 JUMP LOCATION
{
    JSR ShopKeeper_DrawItemWithPrice
    JSR Sprite3_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSR ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
    
    JSL Sprite_GetEmptyBottleIndex : BMI .BRANCH_BETA
    
    LDA.b #$0A
    LDY.b #$00
    
    JSR ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
    
    STZ $0DD0, X
    
    LDY.b #$0E : JSR $F366 ; $0F7366 IN ROM
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$6D
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    JSR $F38A   ; $0F738A IN ROM
    
    RTS
    
    .BRANCH_GAMMA
    
    JMP $F1A1 ; $0F71A1 IN ROM
}

; ==============================================================================

; $0F7358-$0F7365 DATA
{
    .message_ids_low
    db $68, $67, $67, $6C, $69, $6A, $6B
    
    .message_ids_high
    db $01, $01, $01, $01, $01, $01, $01
}

; ==============================================================================

; $0F7366-$0F7389 LOCAL JUMP LOCATION
{
    ; Subroutine grants the player an item parameterized by the A register.
    
    STZ $02E9
    
    PHX
    
    JSL Link_ReceiveItem
    
    PLX
    
    LDA $0E80, X : SEC : SBC.b #$07 : BMI .BRANCH_ALPHA
    
    TAY
    
    LDA .message_ids_low, Y  :       XBA
    LDA .message_ids_high, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    JSL ShopKeeper_RapidTerminateReceiveItem
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F738A-$0F7390 LOCAL JUMP LOCATION
{
    LDA.b #$3C : JSL Sound_SetSfx2PanLong
    
    RTS
}

; ==============================================================================

; $0F7391-$0F739D LOCAL JUMP LOCATION
ShopKeeper_CheckPlayerSolicitedDamage:
{
    LDA $F6 : BPL .the_a_button_not_pressed
    
    ; \note The bcc branch seems kind of .... useless. Maybe there was
    ; some other code dummied out?
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_contact
    
    RTS
    
    .no_player_contact
    .the_a_button_not_pressed
    
    CLC
    
    RTS
}

; ==============================================================================

; $0F739E-$0F73B5 LOCAL JUMP LOCATION
ShopKeeper_TryToGetPaid:
{
    STA $00
    STY $01
    
    REP #$20
    
    LDA $7EF360 : CMP $00 : BCC .player_cant_afford
    
    SBC $00 : STA $7EF360
    
    SEC
    
    .player_cant_afford
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0F73B6-$0F74CD DATA
pool ShopKeeper_DrawItemWithPrice:
{
    .oam_groups
    dw -4, 16 : db $31, $02, $00, $00
    dw  4, 16 : db $13, $02, $00, $00
    dw 12, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $C0, $02, $00, $02
    dw  0, 11 : db $6C, $03, $00, $02
    
    dw  0, 16 : db $13, $02, $00, $00
    dw  0, 16 : db $13, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $CE, $04, $00, $02
    dw  4, 12 : db $38, $03, $00, $00
    
    dw -4, 16 : db $13, $02, $00, $00
    dw  4, 16 : db $30, $02, $00, $00
    dw 12, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $CC, $08, $00, $02
    dw  4, 12 : db $38, $03, $00, $00
    
    dw  0, 16 : db $31, $02, $00, $00
    dw  0, 16 : db $31, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  4,  8 : db $29, $03, $00, $00
    dw  4, 11 : db $38, $03, $00, $00
    
    dw -4, 16 : db $03, $02, $00, $00
    dw -4, 16 : db $03, $02, $00, $00
    dw  4, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $C4, $04, $00, $02
    dw  0, 11 : db $38, $03, $00, $00
    
    dw  0, 16 : db $13, $02, $00, $00
    dw  0, 16 : db $13, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $E8, $04, $00, $02
    dw  0, 11 : db $6C, $03, $00, $02
    
    db  0, 16 : db $31, $02, $00, $00
    db  0, 16 : db $31, $02, $00, $00
    db  8, 16 : db $30, $02, $00, $00
    db  4,  8 : db $F4, $0F, $00, $00
    db  4, 11 : db $38, $03, $00, $00
}

; ==============================================================================

; $0F74CE-$0F74F2 LOCAL JUMP LOCATION
ShopKeeper_DrawItemWithPrice:
{
    LDA $0E80, X : SEC : SBC.b #$07 : REP #$20 : AND.w #$00FF : STA $00
                                           ASL #2       : ADC $00 : ASL #3
    
    ADC.w #.oam_groups : STA $08
    
    LDA.w #$0005 : STA $06
    
    SEP #$30
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================
