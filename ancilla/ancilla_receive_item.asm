
; ==============================================================================

; $0442DD-$044389 DATA
Pool_Ancilla_ReceiveItem:
{
    .item_messages
    dw $FFFF, $0070, $0077, $0052, $FFFF, $0078, $0078, $0062
    dw $0061, $0066, $0069, $0053, $0052, $0056, $FFFF, $0064
    dw $0063, $0065, $0051, $0054, $0067, $0068, $006B, $0077
    dw $0079, $0055, $006E, $0058, $006D, $005D, $0057, $005E
    dw $FFFF, $0074, $0075, $0076, $FFFF, $005F, $0158, $FFFF
    dw $006A, $005C, $008F, $0071, $0072, $0073, $0071, $0072
    dw $0073, $006A, $006C, $0060, $FFFF, $FFFF, $FFFF, $0059
    dw $0084, $005A, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $0159
    dw $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF, $FFFF
    dw $FFFF, $00DB, $0067, $007C
    
    .animation_tiles
    db $24, $25, $26
    
    .animation_timers
    db 9, 5, 5
    
    .default_oam_properties
    db $05, $01, $04
    
    .piece_of_heart_messages
    dw -1, $0155, $0156, $0157 
    
    .pendant_encouragement_message
    dw $005B, $0083
}

; ==============================================================================

; $04438A-$0446F1 JUMP LOCATION
Ancilla_ReceiveItem:
{
    ; Special Object 0x22
    ; Items that we receive from various sources
    
    ; Usually induced by an instance of this object that is a crystal
    LDA.w $02E4 : CMP.b #$02 : BEQ .justDoGraphics
    LDA.b $11    : BEQ .allowedSubmodule
    CMP.b #$2B : BEQ .allowedSubmodule
    CMP.b #$09 : BEQ .allowedSubmodule
    CMP.b #$02 : BNE .justDoGraphics
        LDA.b #$10 : STA.w $0C68, X
    
    .justDoGraphics
    
    BRL .handleGraphics
    
    .allowedSubmodule
    
    INC.w $0FC1
    
    LDA.w $0C54, X : BEQ .fromTextOrObject
    CMP.b #$03   : BEQ .fromTextOrObject
    BRL .from_chest_or_sprite
    
    .fromTextOrObject
    
    LDA.w $0C5E, X : CMP.b #$01 : BNE .notMasterSword
    ; This should never happen, the way this is coded so far... >_<'''''''
    LDA.w $0C54, X : CMP.b #$02 : BEQ .masterSwordFromSprite
        LDA.w $0C68, X : BEQ .timerFinished
            CMP.b #$11 : BNE .timerWait
                REP #$20
                
                ; Begin a timer.... presumably to activate Sahsralah telling you
                ; good job and stuff.
                LDA.w #$0DF3 : STA.w $02CD
                
                SEP #$20
                
                ; Instantiate the boss victory tagalong
                ; (Sahasralah's disembodied voice in this case)
                LDA.b #$0E : STA.l $7EF3CC
            
                .times_up_2
            
                BRL .timesUp

    .masterSwordFromSprite
    .notMasterSword
    
    DEC.w $03B1, X : LDA.w $03B1, X : BEQ .timerFinished
               CMP.b #$01   : BNE .timerWait
    LDA.w $0C5E, X : CMP.b #$37 : BEQ .isPendant
                   CMP.b #$38 : BEQ .isPendant
                   CMP.b #$39 : BNE .not_pendant
        .isPendant
    
        ; Wait for the music to stop ( I think )
        LDA.w SNES.APUIOPort0 : BEQ .wait_for_music
            INC.w $03B1, X
            
            BRA .timerWait
        .wait_for_music

    .not_pendant
    
    BRL .times_up_2
    
    .timerWait
    
    BRL .handleGraphics
    
    .timerFinished
    
    LDA.w $0C5E, X : CMP.b #$01 : BNE .notMasterSword2
    LDA.w $0C54, X : BNE .notFromText
        ; Since we got the master sword, 
        ; restore the main overworld song and the disable ambient sound effects
        LDA.b #$05 : STA.w $012D
        LDA.b #$02 : STA.w $012C
    
    .notFromText
    .notMasterSword2
    
    LDY.b #$00
    
    LDA.w $0345 : BEQ .notInWater
    ; Restore Link to his swimming state
    LDY.b #$04
    
    .notInWater
    
    STY.b $5D
    
    STZ.w $02D8
    STZ.w $02DA
    STZ.w $037B
    
    JSL.l GiveRupeeGift ; $04AD6C IN ROM
    
    ; needs real name
    .optimus
    
    STZ.w $02E9
    
    LDA.w $0C5E, X : CMP.b #$17 : BNE .notPieceOfHeart
        ; Load the number of heart pieces collected so far
        LDA.l $7EF36B : BNE .notGrantingHeartContainer
            PHX
            
            LDY.b #$26
            
            ; Grant a heart container!!! yay
            JSL.l Link_ReceiveItem
            
            PLX
            
            STZ.w $0C4A, X
            
            STZ.w $0FC1
            
            RTS
    
        .notGrantingHeartContainer
    .notPieceOfHeart
    
    ; Heart container in chest, typically
    CMP.b #$26 : BEQ .heartContainerInChest
    CMP.b #$3F : BEQ .heartContainerInChest
        ; The type of heart container typically found on the ground after a boss fight
        CMP.b #$3E : BNE .notHeartContainer
            STZ.w $02E4
            
            ; Check if capatity health is at max.
            LDA.l $7EF36C : CMP.b #$A0 : BEQ .already20Hearts
                ; Give Link additional extra heart
                CLC : ADC.b #$08 : STA.l $7EF36C
                
                ; Fill in that one heart
                LDA.l $7EF372 : CLC : ADC.b #$08 : STA.l $7EF372
                
                BRA .playHeartContainerSfx
    
    .heartContainerInChest
    
    LDA.l $7EF36D : STA.b $00
    
    LDA.l $7EF36C : CMP.b #$A0 : BEQ .already20Hearts
        ; Give Link an additional heart
        CLC : ADC.b #$08 : STA.l $7EF36C
        
        ; Put Link's actual health at maximum
        SEC : SBC.b $00 : STA.b $00
        
        LDA.l $7EF372 : CLC : ADC.b $00 : STA.l $7EF372
    
        .playHeartContainerSfx
    
        LDA.b #$0D : JSR.w Ancilla_DoSfx3_NearPlayer
        
        BRA .objectFinished
    
        
    .already20Hearts
    .notHeartContainer
    
    CMP.b #$42 : BNE .notSingleHeartRefill
        ; Fill in one heart of actual health (using the heart refiller)
        LDA.l $7EF372 : CLC : ADC.b #$08 : STA.l $7EF372
        
        BRA .objectFinished
    
    .notSingleHeartRefill
    
    CMP.b #$45 : BNE .notSmallMagicRefill
        ; Refill 1/8 of our magic power
        LDA.l $7EF373 : CLC : ADC.b #$10 : STA.l $7EF373
        
        BRA .objectFinished
    
    .notSmallMagicRefill
    
    CMP.b #$22 : BEQ .armorUpgrade
        CMP.b #$23 : BNE .objectFinished
            .armorUpgrade
    
            PHX
            
            JSL.l Palette_ArmorAndGloves
            
            PLX
    
    .objectFinished
    
    STZ.w $0C4A, X
    
    STZ.w $0FC1
    
    LDA.w $0C54, X : CMP.b #$03 : BNE .noDefaultVictorySequence
        ; ether medallion
        ; bombos medallion
        LDY.w $0C5E, X : CPY .ether_medallion  : BEQ .noDefaultVictorySequence
                       CPY .bombos_medallion : BEQ .noDefaultVictorySequence
                       CPY .heart_container  : BEQ .noDefaultVictorySequence
                       CPY .crystal          : BEQ .noDefaultVictorySequence
        
        PHA : PHX
        
        JSL.l PrepDungeonExit
        
        PLX : PLA
    
    .noDefaultVictorySequence
    
    CMP.b #$02 : BEQ .fromSprite
        STZ.w $02E4
    
    .fromSprite
    
    RTS
    
    .from_chest_or_sprite
    
    ; Check timer
    DEC.w $03B1, X : LDA.w $03B1, X : BPL .stillInMotion
    BRL .optimus
    
    .stillInMotion
    
    CMP.b #$00 : BEQ .timesUp
    ; Give a rupee gift when the timer reaches value 0x28
    CMP.b #$28 : BNE .dontGiveRupees
        ; Check if item came from sprite
        LDA.w $0C54, X : CMP.b #$02 : BEQ .dontGiveRupees
            ; $04AD6C IN ROM
            JSL.l GiveRupeeGift : BCS .rupeesGiven
                LDA.w $0C5E, X : CMP.b #$17 : BNE .noSoundEffect
    
    .dontGiveRupees
    
    BRL .handleMovement
    
    .noSoundEffect
    .rupeesGiven
    
    LDA.b #$0F : JSR.w Ancilla_DoSfx3_NearPlayer
    
    BRA .dontGiveRupees
    
    .timesUp
    
    LDA.b $1B : BEQ .outdoors
    REP #$20
    
    LDA.b $A0
    
    CMP.w #$00FF : BEQ .shop
    CMP.w #$010F : BEQ .shop
    CMP.w #$0110 : BEQ .shop
    CMP.w #$0112 : BEQ .shop
    CMP.w #$011F : BNE .notShop
        .shop
    
        SEP #$20
    
        BRA .handleMovement
    
    .notShop
    .outdoors
    
    SEP #$20
    
    LDA.w $0C5E, X : CMP.b #$38 : BEQ .checkIfLastPendant
               CMP.b #$39 : BNE .notPendant
    .checkIfLastPendant
    
    TAY
    
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .defaultTextHandler
        ; Determine which text message to play
        ; I assume this has something to do with the fact that if you haven't
        ; collected all 3 pendants, it tells you to go for the last one, or whatever.
        TYA : SEC : SBC.b #$38 : ASL A : TAY
        
        REP #$20
        
        LDA.w .pendant_encouragement_message, Y : STA.w $1CF0
            SEP #$20
            
            BRA .doTextMessage
    
    .notPendant
    
    LDA.w $0C54, X : CMP.b #$02 : BEQ .handleGraphics
    LDA.w $0C5E, X : CMP.b #$17 : BNE .defaultTextHandler
        ; Display a different text message depending on how many pieces of heart we have
        LDA.l $7EF36B : ASL A : TAY
        
        REP #$20
        
        LDA.w .piece_of_heart_messages, Y : CMP.w #$FFFF : BEQ .handleGraphics
            STA.w $1CF0
            
            SEP #$20
            
            BRA .doTextMessage
    
    .defaultTextHandler
    
    LDA.w $0C5E, X : ASL A : TAY
        
    REP #$20
        
    LDA.w .item_messages, Y : CMP.w #$FFFF : BEQ .handleGraphics
        ; Check if it's Sahasralah's speech after getting the master sword
        STA.w $1CF0 : CMP.w #$0070 : BNE .notGeezerSpeech
            SEP #$20
        
            ; Play the telepathic noise during the Sahasralah speech
            LDA.b #$09 : STA.w $012D
    
        .notGeezerSpeech
    
        SEP #$20
    
        .doTextMessage
    
        JSL.l Main_ShowTextMessage
        
        BRA .handleGraphics
    
    .handleMovement
    
    LDA.w $03B1, X : CMP.b #$18 : BCC .handleGraphics
    ; A = ($0C22, X) - 1
    LDA.w $0C22, X : CLC : ADC.b #$FF : CMP.b #$F8
            
    ; if(A < 0xF8)
    BCC .stopAccelerating
        STA.w $0C22, X
        
    .stopAccelerating
        
    ; Move the object's in the Y direction based on $0C22, X's value
    ; handles speed values for the object (velocity)
    JSR.w Ancilla_MoveVert
    
    .handleGraphics
    
    SEP #$20
    
    ; Is the item we wish to grant a Crystal?
    LDA.w $0C5E, X : CMP.b #$20 : BNE .dont_add_sparkle
    ; Set a timer to zero.
    STZ.w $029E, X 
    
    JSR.w Ancilla_AddSwordChargeSpark
    
    LDA.w SNES.APUIOPort0 : BNE .waitForSilence
        ; Play the boss victory tune.
        LDA.b #$1A : STA.w $012C
        
        ; Replace this 0x22 object with the 0x3E object (which is the 3D version of the crystal)
        BRL Ancilla_TransmuteToRisingCrystal
    
    .waitForSilence
    .dont_add_sparkle
    
    SEP #$20
    
    LDA.w $0C5E, X : CMP.b #$01 : BNE .checkIfRupee
    LDA.w .default_oam_properties : STA.w $0BF0, X
    
    LDA.w $0C54, X : CMP.b #$02 : BEQ .dontAnimateMasterSword
        LDA.w $0C68, X : CMP.b #$10 : BCC .waitAnimateMasterSword
            DEC.w $039F, X : BPL .dontAnimateMasterSword
            
            LDA.b #$02 : STA.w $039F, X
            
            LDA.w $03A4, X : INC A : CMP.b #$03 : BNE .dontResetSwordAnimation
    
        .waitAnimateMasterSword
    
        LDA.b #$00
    
        .dontResetSwordAnimation
    
        STA.w $03A4, X : TAY
    
        LDA.w .default_oam_properties, Y : STA.w $0BF0, X
    
    .dontAnimateMasterSword
    .checkIfRupee
    
    LDA.w $0C5E, X
    
    CMP.b #$34 : BEQ .animatedRupeeSprite
    CMP.b #$35 : BEQ .animatedRupeeSprite
    CMP.b #$36 : BNE .dontAnimateSprite
    .animatedRupeeSprite
    
    DEC.w $039F, X : BPL .dontAnimateSprite
        INC.w $03A4, X : LDA.w $03A4, X : CMP.b #$03 : BNE .dontResetAnimation
            LDA.b #$00 : STA.w $03A4, X
    
    .dontResetAnimation
    
    TAY
        
    ; Set a new countdown timer for the amount of time it takes to get to the next animation step.
    LDA.w .animation_timers, Y : STA.w $039F, X
        
    PHX
        
    ; Load a new tile for the rupee
    LDA.w .animation_tiles, Y : JSL.l GetAnimatedSpriteTile
        
    PLX
    
    .dontAnimateSprite
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    ; $08 = $00 + 0x08
    LDA.b $00 : CLC : ADC.b #$0008 : STA.b $08
    
    SEP #$20
    
    ; $044690 ALTERNATE ENTRY POINT
    .draw
    
    PHX
    
    LDA.w $0BF0, X : STA.b $74
    
    LDA.w $0C5E, X : TAX
    
    LDY.b #$00
    
    ; Writes X and Y coordinates to OAM buffer
    JSR.w Ancilla_SetOam_XY
    
    ; always use the same character graphic (0x24)
    LDA.b #$24 : STA ($90), Y : INY
    
    LDA AddReceiveItem_properties, X : BPL .valid_upper_properties
    LDA.b $74
    
    .valid_upper_properties
    
    ASL A : ORA.b #$30 : STA ($90), Y : INY
    
    PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.w .wide_item_flag, X : STA ($92), Y
    
    PLY
    
    ; If it's a 16x16 sprite, we'll only draw one, otherwise we'll end up drawing
    ; two 8x8 sprites stack on top of each other
    CMP.b #$02 : BEQ .large_sprite
    REP #$20
    
    ; Shift Y coordinate 8 pixels down
    LDA.b $08 : STA.b $00
    
    SEP #$20
    
    JSR.w Ancilla_SetOam_XY
    
    ; always use the same character graphic (0x34)
    LDA.b #$34 : STA ($90), Y : INY
    
    LDA AddReceiveItem_properties, X : BPL .valid_lower_properties
        LDA.b $74
    
    .valid_lower_properties
    
    ASL A : ORA.b #$30 : STA ($90), Y 
    
    INY : PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY
    
    .large_sprite
    
    PLX
    
    RTS
}

; ==============================================================================

