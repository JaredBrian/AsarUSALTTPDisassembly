; ==============================================================================

; Bank 06
; $030000-$037FFF
org $068000

; Misc sprite functions
; Main sprite control
; Sprite collision code

; ==============================================================================

; $030000-$030044 LONG JUMP LOCATION
BottleVendor_DetectFish:
{
    PHB : PHK : PLB
    
    LDY.b #$0F
    
    .nextSprite
    
        LDA.w $0DD0, Y : BEQ .inactiveSprite
            ; Literally!
            LDA.w $0E20, Y : CMP.b #$D2 : BEQ .isFishOutOfWater
        
        .inactiveSprite
    DEY : BPL .nextSprite
    
    PLB
    
    RTL
    
    .isFishOutOfWater
    
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $08
    LDA.b #$10     : STA.b $02
    
    LDA.w $0D00, X : STA.b $01
    LDA.w $0D20, X : STA.b $09
    LDA.b #$10     : STA.b $03
    
    PHX : TYX
    JSR.w Sprite_SetupHitBox
    
    PLX
    
    JSR.w Utility_CheckIfHitBoxesOverlap : BCC .delta
        ; If the fish is close enough to the merchant, indicate as such.
        TYA : ORA.b #$80 : STA.w $0E90, X
    
    .delta
    
    PLB
    
    RTL
}

; ==============================================================================

; $030045-$030053 DATA
Pool_BottleVendor_SpawnFishRewards:
{
    ; $030045
    .x_speeds
    db $FA, $FD, $00, $04, $07
    
    ; $03004A
    .y_speeds
    db $0B, $0E, $10, $0E, $0B
    
    ; $03004F
    .item_types
    db $DB, $E0, $DE, $E2, $D9
}

; Only used by the bottle vendor... I think this spawns the items he gives you
; in the event that you give him a fish?
; $030054-$03009E LONG JUMP LOCATION
BottleVendor_SpawnFishRewards:
{
    PHB : PHK : PLB
    
    LDA.b #$13
    JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA.w $0FB5
    
    .nextItem
    
        LDY.w $0FB5
        LDA.w .item_types, Y
        JSL.l Sprite_SpawnDynamically : BMI .spawnFailed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
            
            LDA.b #$FF : STA.w $0B58, Y
            
            PHX
            
            LDX.w $0FB5
            LDA Pool_BottleVendor_SpawnFishRewards_x_speeds, X : STA.w $0D50, Y
            LDA Pool_BottleVendor_SpawnFishRewards_y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$20 : STA.w $0F80, Y
                         STA.w $0F10, Y
            
            PLX
        
        .spawnFailed
    DEC.w $0FB5 : BPL .nextItem
    
    PLB
    
    RTL
}

; ==============================================================================

; When the boomerang is off camera and still in play, it dramatically speeds up
; to catch up to the player. This was confirmed by setting the 0x70 and 0x90
; values in this routine to much lower values and dashing away after throwing
; the boomerang. It took about 2 minutes for the boomerang to get back to the
; player, but when it finally appeared on screen it moved at its normal speed.
; Anyways, this routine overrides the values set by
; Ancilla_ProjectSpeedTowardsPlayer when the boomerang is out of view.
; $03009F-$0300E5 LONG JUMP LOCATION
Boomerang_CheatWhenNoOnesLooking:
{
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    LDA.w $0BFA, X : STA.b $04
    LDA.w $0C0E, X : STA.b $05
    
    REP #$20
    
    LDY.b #$70
    
    LDA.b $22 : SEC : SBC.b $02 : CLC : ADC.w #$00F0 : CMP.w #$01E0 : BPL .too_far_x
        ; Note: This is the negative version of 0x70.
        LDY.b #$90
    
    .too_far_x
    
    BCC .close_enough_x
        STY.b $01
        
        BRA .return
    
    .close_enough_x
    
    LDY.b #$70
    
    LDA.b $20 : SEC : SBC.b $04 : CLC : ADC.w #$00F0 : CMP.w #$01E0 : BPL .too_far_y
        LDY.b #$90
    
    .too_far_y
    
    BCC .close_enough_y
        STY.b $00
    
    .close_enough_y

    .return
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $0300E6-$0300F9 DATA
Pool_Player_ApplyRumbleToSprites:
{
    ; $0300E6
    .x_offsets_low
    db -32, -32, -32, 16
    
    ; $0300EA
    .y_offsets_low
    db -32, 32, -24, -24
    
    ; $0300EE
    .y_offsets_high ; Bleeds into next data block.
    db -1, 0
    
    ; $0300F0
    .x_offsets_high
    db -1, -1, -1, 0
    
    ; $0300F4
    .hitbox_w ; Bleeds into next data block.
    db 80, 80
    
    ; $0300F6
    .hitbox_h
    db 32, 32, 80, 80
}

; Grabs Link's coordinates plus an offset determined by his direction and
; stores them to direct page locations.
; $0300FA-$03012C LONG JUMP LOCATION
Player_ApplyRumbleToSprites:
{
    PHB : PHK : PLB
    
    LDA.b $2F : LSR : TAY
    
    LDA.b $22
    CLC : ADC.w Pool_Player_ApplyRumbleToSprites_x_offsets_low, Y : STA.b $00

    LDA.b $23
    ADC.w Pool_Player_ApplyRumbleToSprites_x_offsets_high, Y : STA.b $08
    
    LDA.b $20
    ADC.w Pool_Player_ApplyRumbleToSprites_y_offsets_low,  Y : STA.b $01

    LDA.b $21
    ADC.w Pool_Player_ApplyRumbleToSprites_y_offsets_high, Y : STA.b $09
    
    LDA.w Pool_Player_ApplyRumbleToSprites_hitbox_w, Y : STA.b $02
    LDA.w Pool_Player_ApplyRumbleToSprites_hitbox_h, Y : STA.b $03
    
    JSR.w Entity_ApplyRumbleToSprites
    
    PLB
    
    RTL
}

; ==============================================================================

; $03012D-$03014A LONG JUMP LOCATION
Sprite_SpawnImmediatelySmashedTerrain:
{
    LDY.w $0314 : PHY
    LDY.w $0FB2 : PHY
    
    PHB : PHK : PLB
    
    JSL.l Sprite_SpawnThrowableTerrainSilently : BMI .spawn_failed
        JSR.w ThrowableScenery_TransmuteToDebris
    
    .spawn_failed
    
    PLB
    
    PLA : STA.w $0FB2
    PLA : STA.w $0314
    
    RTL
}

; ==============================================================================

; This routine is called when you pick up a bush/pot/etc.
; A =   0 - sign 
;       1 - small light rock
;       2 - normal bush / pot
;       3 - thick grass
;       4 - off color bush
;       5 - small heavy rock
;       6 - large light rock
;       7 - large heavy rock
; $03014B-$030155 LONG JUMP LOCATION
Sprite_SpawnThrowableTerrain:
{
    PHA
    
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    ORA.b #$1D : STA.w $012E
    
    PLA

    ; Bleeds into the next function.
}
    
; $030156-$0301F3 LONG JUMP LOCATION
Sprite_SpawnThrowableTerrainSilently:
{
    LDX.b #$0F
    
    .next_slot
    
        ; Look for dead sprites.
        LDY.w $0DD0, X : BEQ .empty_slot
    DEX : BPL .next_slot
    
    ; Can't find any slots so don't do any animation.
    RTL
    
    .empty_slot
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    PHA
    
    LDA.b #$0A : STA.w $0DD0, X
    
    ; Make a bush/pot/etc. sprite appear.
    LDA.b #$EC : STA.w $0E20, X
    
    LDA.b $00 : STA.w $0D10, X
    LDA.b $01 : STA.w $0D30, X
    
    LDA.b $02 : STA.w $0D00, X
    LDA.b $03 : STA.w $0D20, X
    
    JSL.l Sprite_LoadProperties
    
    ; Set the floor level to whichever the player is on.
    LDA.b $EE : STA.w $0F20, X
    
    PLA : STA.w $0DB0, X
    CMP.b #$06 : BCC .not_heavy_object
        PHA
        
        LDA.b #$A6 : STA.w $0E40, X
        
        PLA
    
    .not_heavy_object
    
    CMP.b #$02 : BNE .notBushOrPot
        LDA.b $1B : BEQ .outdoors
            ; This doesn't seem to do anything because it gets overwritten just
            ; a few lines down anyways!
            LDA.b #$80 : STA.w $0F50, X
        
        .outdoors
    .notBushOrPot
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    PHB : PHK : PLB
    
    TAY
    
    LDA.w Pool_Sprite_ThrowableScenery_palettes, Y : STA.w $0F50, X
    
    LDA.b #$09 : STA.l $7FFA2C, X
    
    LDA.b #$02 : STA.w $0314
                 STA.w $0FB2
    
    LDA.b #$10 : STA.w $0DF0, X
    
    LDA.b $EE : STA.w $0F20, X
    
    STZ.w $0DC0, X
    
    LDA.w $0B9C : CMP.b #$FF : BEQ .invalid_secret
        ORA.b $1B : BNE .dont_substitute
            LDA.w $0DB0, X : DEC : DEC : CMP.b #$02 : BCC .dont_substitute
                JSL.l Overworld_SubstituteAlternateSecret
            
        .dont_substitute
        
        LDA.w $0B9C : BPL .normal_secret
            AND.b #$7F : STA.w $0DC0, X
            
            STZ.w $0B9C
        
        .normal_secret
        
        JSR.w Sprite_SpawnSecret
    
    .invalid_secret
    
    PLB
    
    RTL
}

; ==============================================================================

; $0301F4-$030261 DATA
Pool_Sprite_SpawnSecret:
{
    ; $0301F4
    .ID
    db $D9 ; SPRITE D9 - 0x01 - green rupee
    db $3E ; SPRITE 3E - 0x02 - hoarder
    db $79 ; SPRITE 79 - 0x03 - bee
    db $D9 ; SPRITE D9 - 0x04 - green rupee
    db $DC ; SPRITE DC - 0x05 - 1 bomb
    db $D8 ; SPRITE D8 - 0x06 - heart
    db $DA ; SPRITE DA - 0x07 - blue rupee
    db $E4 ; SPRITE E4 - 0x08 - small key
    db $E1 ; SPRITE E1 - 0x09 - 5 arrows
    db $DC ; SPRITE DC - 0x0A - 1 bomb
    db $D8 ; SPRITE D8 - 0x0B - heart
    db $DF ; SPRITE DF - 0x0C - small magic
    db $E0 ; SPRITE E0 - 0x0D - full magic
    db $0B ; SPRITE 0B - 0x0E - cucco
    db $42 ; SPRITE 42 - 0x0F - green guard
    db $D3 ; SPRITE D3 - 0x10 - stal
    db $41 ; SPRITE 41 - 0x11 - blue guard
    db $D4 ; SPRITE D4 - 0x12 - landmine
    db $D9 ; SPRITE D9 - 0x13 - green rupee
    db $E3 ; SPRITE E3 - 0x14 - fairy
    db $D8 ; SPRITE D8 - 0x15 - heart

    ; $030209
    .AI2
    db $00 ; 0x00 - null
    db $00 ; 0x01 - green rupee
    db $01 ; 0x02 - hoarder
    db $01 ; 0x03 - bee
    db $00 ; 0x04 - green rupee
    db $00 ; 0x05 - 1 bomb
    db $00 ; 0x06 - heart
    db $00 ; 0x07 - blue rupee
    db $00 ; 0x08 - small key
    db $00 ; 0x09 - 5 arrows
    db $00 ; 0x0A - 1 bomb
    db $03 ; 0x0B - heart
    db $00 ; 0x0C - small magic
    db $00 ; 0x0D - full magic
    db $01 ; 0x0E - cucco
    db $00 ; 0x0F - green guard
    db $00 ; 0x10 - stal
    db $00 ; 0x11 - blue guard
    db $00 ; 0x12 - landmine
    db $00 ; 0x13 - green rupee
    db $00 ; 0x14 - fairy
    db $00 ; 0x15 - heart

    ; $03021F
    .offset_x
    db $00 ; 0x00 - null
    db $04 ; 0x01 - green rupee
    db $00 ; 0x02 - hoarder
    db $04 ; 0x03 - bee
    db $04 ; 0x04 - green rupee
    db $00 ; 0x05 - 1 bomb
    db $04 ; 0x06 - heart
    db $04 ; 0x07 - blue rupee
    db $04 ; 0x08 - small key
    db $04 ; 0x09 - 5 arrows
    db $00 ; 0x0A - 1 bomb
    db $04 ; 0x0B - heart
    db $04 ; 0x0C - small magic
    db $04 ; 0x0D - full magic
    db $00 ; 0x0E - cucco
    db $00 ; 0x0F - green guard
    db $00 ; 0x10 - stal
    db $00 ; 0x11 - blue guard
    db $00 ; 0x12 - landmine
    db $04 ; 0x13 - green rupee
    db $00 ; 0x14 - fairy
    db $04 ; 0x15 - heart

    ; $030235
    .ignore_ancillae
    db $04 ; 0x00 - null
    db $01 ; 0x01 - green rupee
    db $00 ; 0x02 - hoarder
    db $00 ; 0x03 - bee
    db $01 ; 0x04 - green rupee
    db $01 ; 0x05 - 1 bomb
    db $01 ; 0x06 - heart
    db $01 ; 0x07 - blue rupee
    db $01 ; 0x08 - small key
    db $01 ; 0x09 - 5 arrows
    db $01 ; 0x0A - 1 bomb
    db $01 ; 0x0B - heart
    db $01 ; 0x0C - small magic
    db $01 ; 0x0D - full magic
    db $00 ; 0x0E - cucco
    db $00 ; 0x0F - green guard
    db $00 ; 0x10 - stal
    db $00 ; 0x11 - blue guard
    db $00 ; 0x12 - landmine
    db $01 ; 0x13 - green rupee
    db $01 ; 0x14 - fairy
    db $01 ; 0x15 - heart

    ; $03024B
    .jump_velocity
    db $01 ; 0x00 - null
    db $10 ; 0x01 - green rupee
    db $00 ; 0x02 - hoarder
    db $00 ; 0x03 - bee
    db $10 ; 0x04 - green rupee
    db $00 ; 0x05 - 1 bomb
    db $00 ; 0x06 - heart
    db $10 ; 0x07 - blue rupee
    db $10 ; 0x08 - small key
    db $10 ; 0x09 - 5 arrows
    db $10 ; 0x0A - 1 bomb
    db $00 ; 0x0B - heart
    db $10 ; 0x0C - small magic
    db $0A ; 0x0D - full magic
    db $10 ; 0x0E - cucco
    db $00 ; 0x0F - green guard
    db $00 ; 0x10 - stal
    db $00 ; 0x11 - blue guard
    db $00 ; 0x12 - landmine
    db $10 ; 0x13 - green rupee
    db $00 ; 0x14 - fairy
    db $00 ; 0x15 - heart
    db $00 ; 0x16 - null
}

; $030262-$030263 BRANCH LOCATION
Sprite_SpawnSecret_fastexit:
{
    CLC
    
    RTS
}
    
; $030264-$030327 BRANCH LOCATION
Sprite_SpawnSecret:
{
    LDA.b $1B : BNE .indoors
        JSL.l GetRandomInt : AND.b #$08 : BNE Sprite_SpawnSecret_fastexit
    
    .indoors
    
    LDY.w $0B9C : BEQ Sprite_SpawnSecret_fastexit
        CPY.b #$04 : BNE .not_random
            JSL.l GetRandomInt : AND.b #$03 : CLC : ADC.b #$13 : TAY
        
        .not_random
        
        STY.b $0D
        
        ; List of sprites that can be spawned by secrets.
        LDA.w Pool_Sprite_SpawnSecret_ID-1, Y : BEQ Sprite_SpawnSecret_fastexit
            JSL.l Sprite_SpawnDynamically : BMI Sprite_SpawnSecret_fastexit
                PHX
                
                LDX.b $0D
                LDA.w Pool_Sprite_SpawnSecret_AI2, X : STA.w $0D80, Y
                LDA.w Pool_Sprite_SpawnSecret_ignore_ancillae, X : STA.w $0BA0, Y
                LDA.w Pool_Sprite_SpawnSecret_jump_velocity, X : STA.w $0F80, Y
                
                LDA.b $00 : CLC : ADC.w Pool_Sprite_SpawnSecret_offset_x, X : STA.w $0D10, Y
                LDA.b $01 : ADC.b #$00 : STA.w $0D30, Y
                
                LDA.b $02 : STA.w $0D00, Y
                LDA.b $03 : STA.w $0D20, Y
                
                LDA.b $04 : STA.w $0F70, Y
                
                LDA.b #$00 : STA.w $0DC0, Y
                LDA.b #$20 : STA.w $0F10, Y
                LDA.b #$30 : STA.w $0E10, Y
                
                LDX.w $0E20, Y : CPX.b #$E4 : BNE .not_key
                    PHX
                    
                    TYX
                    
                    JSR.w SpritePrep_Key
                    
                    PLX
                
                .not_key
                
                CPX.b #$0B : BNE .not_chicken
                    ; Make a chicken noise.
                    LDA #$30 : STA.w $012E
                    
                    LDA.w $048E : CMP.b #$01 : BNE .BRANCH_DELTA
                        STA.w $0E30, Y
                    
                    .BRANCH_DELTA
                .not_chicken
                
                CPX.b #$42 : BEQ .is_soldier
                CPX.b #$41 : BEQ .is_soldier
                    CPX.b #$3E : BNE .not_rock_crab
                        LDA.b #$09 : STA.w $0F50, Y
                        
                        BRA .return
                
                .is_soldier
                
                ; Play the "pissed off soldier" sound effect.
                LDA.b #$04 : STA.w $012F
                
                LDA.b #$00 : STA.w $0CE2, Y
                LDA.b #$A0 : STA.w $0EF0, Y
                
                BRA .carry_on
                
                .not_rock_crab
                
                LDA.b #$FF : STA.w $0B58, Y
                
                .carry_on
                
                CPX.b #$79 : BNE .return
                    LDA.b #$20 : STA.w $0D90, Y
                
                .return
                
                SEC
                
                PLX
                
                RTS
}

; ==============================================================================

; $030328-$0303C1 LONG JUMP LOCATION
Sprite_Main:
{
    ; Are we indoors?
    LDA.b $1B : BNE .indoors
        STZ.w $0C7C : STZ.w $0C7D
        STZ.w $0C7E : STZ.w $0C7F
        STZ.w $0C80
        
        ; Looks like this might load or unload sprites as we scroll during
        ; the overworld... Not certain of this yet.
        JSL.l Sprite_RangeBasedActivation
    
    .indoors
    
    PHB : PHK : PLB
    
    LDY.b #$00
    
    LDA.l $7EF3CA : BEQ .in_light_world
        ; $7E0FFF = 0 if in LW, 1 otherwise
        INY
    
    .in_light_world
    
    ; Darkworld/Lightworld indicator
    STY.w $0FFF
    
    LDA.b $11 : BNE .dont_reset_player_dragging
        ; WTF: Wait, so the dragging of the player is reset under normal
        ; circumstances, but not in another submodule? Does not compute.
        STZ.w $0B7C
        STZ.w $0B7D
        
        STZ.w $0B7E
        STZ.w $0B7F
    
    .dont_reset_player_dragging
    
    JSR.w Oam_ResetRegionBases
    JSL.l Garnish_ExecuteUpperSlotsLong
    JSL.l Tagalong_MainLong
    
    LDA.w $0314 : STA.w $0FB2
    
    STZ.w $0314
    
    LDA.b #$80 : STA.w $0FAB
    
    ; Is this a delay counter between repulse sparks for sprites?
    LDA.b $47 : AND.b #$7F : BEQ .done_counting
        DEC.b $47
        
        BRA .still_counting
    
    .done_counting
    
    STZ.b $47
    
    .still_counting
    
    STZ.w $0379
    STZ.w $0377
    STZ.w $037B
    
    LDA.w $0FDC : BEQ .projectileCounterDone
        DEC.w $0FDC
    
    .projectileCounterDone
    
    JSL.l Ancilla_Main
    JSL.l Overlord_Main
    
    STZ.w $0B9A
    
    LDX.b #$0F
    
    .next_sprite
    
        STX.w $0FA0
        
        JSR.w Sprite_ExecuteSingle
    DEX : BPL .next_sprite
    
    JSL.l Garnish_ExecuteLowerSlotsLong
    
    STZ.w $069F
    STZ.w $069E
    
    PLB
    
    JSL.l CacheSprite_ExecuteAll
    
    LDA.w $0AAA : BEQ .iota
        STA.w $0FC6
    
    .iota
    
    RTL
}

; ==============================================================================

; \tcrf Already mentioned on tcrf, but I'm pretty sure they got that material
; from me, as some guy in IRC was asking about it around the time it went up on
; the wiki. Anyways, this code is confirmed to work, but is not accessibl in an
; unmodified game. A hook would have to be inserted somewhere to call this.
; $0303C2-$0303C6 LONG JUMP LOCATION
EasterEgg_BageCodeTrampoline:
{
    JSL.l EasterEgg_BageCode
    
    RTL
}

; ==============================================================================

; $0303C7-$0303D2 DATA
Oam_ResetRegionBases_bases:
{
    db $0030, $01D0, $0000, $0030, $0120, $0140
}

; ==============================================================================

; NOTE: Appears to reset OAM regions every frame that the sprite handlers are
; active. Whether these are just for sprites themselves and not object
; handlers, I dunno.
; $0303D3-$0303E5 LOCAL JUMP LOCATION
Oam_ResetRegionBases:
{
    LDY.b #$00
    
    REP #$20
    
    .next_OAM_region
    
        LDA.w .bases, Y : STA.w $0FE0, Y
    INY : INY : CPY.b #$0B : BCC .next_OAM_region
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0303E6-$0303E9 LONG JUMP LOCATION
Utility_CheckIfHitBoxesOverlapLong:
{
    JSR.w Utility_CheckIfHitBoxesOverlap
    
    RTL
}

; ==============================================================================

; $0303EA-$0303F1 LONG JUMP LOCATION
Sprite_SetupHitBoxLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SetupHitBox
    
    PLB
    
    RTL
}

; ==============================================================================

; $0303F2-$0304BC LOCAL JUMP LOCATION
Sprite_TimersAndOAM:
{
    JSR.w Sprite_Get_16_bit_Coords
    
    LDA.w $0E40, X : AND.b #$1F : INC : ASL : ASL
    
    LDY.w $0FB3 : BEQ .dontSortSprites
        LDY.w $0F20, X : BEQ .onBG2
            JSL.l OAM_AllocateFromRegionF : BRA .doneAllocatingOamSlot
        
        .onBG2
        
        JSL.l OAM_AllocateFromRegionD : BRA .doneAllocatingOamSlot
    
    .dontSortSprites
    
    JSL.l OAM_AllocateFromRegionA
    
    .doneAllocatingOamSlot
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; Checking for oddball modes:
    ; Typically branches along this path.
    LDA.b $11 : ORA.w $0FC1 : BEQ .normalGameMode
        JMP.w .handle_linkhop
    
    .normalGameMode
    
    ; This section decrements the sprite's 4 general purpose timers (if nonzero).
    LDA.w $0DF0, X : BEQ .timer_0_expired
        DEC.w $0DF0, X
    
    .timer_0_expired
    
    LDA.w $0E00, X : BEQ .timer_1_expired
        DEC.w $0E00, X
    
    .timer_1_expired
    
    LDA.w $0E10, X : BEQ .timer_2_expired
        DEC.w $0E10, X
    
    .timer_2_expired
    
    LDA.w $0EE0, X : BEQ .timer_3_expired
        DEC.w $0EE0, X
    
    .timer_3_expired
    
    LDA.w $0EF0, X : AND.b #$7F : BEQ .death_timer_inactive
        LDY.w $0DD0, X : CPY.b #$09 : BCC .sprite_inactive
            ; On the 0x1F tick of the damage timer we...
            CMP.b #$1F : BNE .BRANCH_MU
                PHA
                
                ; Is the sprite Agahnim?
                LDA.w $0E20, X : CMP.b #$7A : BNE .not_agahnim_complaining
                    ; Branch if in the dark world.
                    LDA.w $0FFF : BNE .not_agahnim_complaining
                        ; Subtract off damage from agahnim.
                        LDA.w $0E50, X : SEC : SBC.w $0CE2, X : BEQ .agahnim_complains
                            BCS .not_agahnim_complaining
                        
                        .agahnim_complains
                        
                        ; Agahnim complaining about you beating him in the
                        ; Light world.
                        LDA.b #$40 : STA.w $1CF0
                        LDA.b #$01 : STA.w $1CF1
                        JSL.l Sprite_ShowMessageMinimal
                
                .not_agahnim_complaining
                
                PLA
            
            .BRANCH_MU
            
            CMP.b #$18 : BNE .BRANCH_LAMBDA
                JSR.w Sprite_HandleSpecialHits
            
            .BRANCH_LAMBDA
        .sprite_inactive
        
        LDA.w $0CE2, X : CMP.b #$FB : BCS .BRANCH_XI
            LDA.w $0EF0, X : ASL : AND.b #$0E : STA.w $0B89, X
        
        .BRANCH_XI
        
        DEC.w $0EF0, X
        
        BRA .BRANCH_OMICRON
    
    .death_timer_inactive
    
    STZ.w $0EF0, X
    STZ.w $0B89, X
    
    .BRANCH_OMICRON
    
    LDA.w $0F10, X : BEQ .aux_timer_4_expired
        DEC.w $0F10, X
    
    .aux_timer_4_expired
    
    ; $0304A4 ALTERNATE ENTRY POINT
    .handle_linkhop
    
    ; WTF: Interesting.... if player priority is super priority, all sprites
    ; follow? TODO: Investigate this.
    LDY.b $EE : CPY.b #$03 : BEQ .player_using_super_priority
        LDY.w $0F20, X
    
    .player_using_super_priority
    
    LDA.w $0B89, X : AND.b #$CF : ORA .priority, Y : STA.w $0B89, X
    
    RTS
    
    .priority
    db $20, $10, $30, $30
}

; ==============================================================================

; $0304BD-$0304C0 LONG JUMP LOCATION
Sprite_Get_16_bit_CoordsLong:
{
    JSR.w Sprite_Get_16_bit_Coords
    
    RTL
}

; ==============================================================================

; $0304C1-$0304D9 LOCAL JUMP LOCATION
Sprite_Get_16_bit_Coords:
{
    ; $0FD8 = sprite's X coordinate, $0FDA = sprite's Y coordinate.
    LDA.w $0D10, X : STA.w $0FD8
    LDA.w $0D30, X : STA.w $0FD9
    
    LDA.w $0D00, X : STA.w $0FDA
    LDA.w $0D20, X : STA.w $0FDB
    
    RTS
}

; ==============================================================================

; $0304DA-$0304E1 LON
Sprite_ExecuteSingleLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_ExecuteSingle
    
    PLB
    
    RTL
}

; ==============================================================================

; $0304E2-$03050E LOCAL JUMP LOCATION
Sprite_ExecuteSingle:
{
    LDA.w $0DD0, X : BEQ SpriteModule_Inactive
        PHA
        
        ; Loads some sprite data into common addresses.
        JSR.w Sprite_TimersAndOAM
        
        PLA : CMP.b #$09 : BEQ .activeSprite
            ; Index is $0DD0, X
            JSL.l UseImplicitRegIndexedLocalJumpTable
            dw SpriteModule_Inactive ; 0x00 - $8510 Sprite is totally inactive
            dw SpriteFall_Main       ; 0x01 - $852E Sprite is falling into a hole
            dw SpritePoof_Main       ; 0x02 - $E393 Frozen Sprite being smashed by
                                     ;        hammer, and pooferized, perhaps into
                                     ;        a nice magic refilling item
            dw SpriteDrown_Main      ; 0x03 - $859C Sprite has fallen into deep
                                     ;        water, may produce a fish
            dw SpriteExplode_Main    ; 0x04 - $8548 Explodey Mode for bosses?
            dw SpriteCustomFall_Main ; 0x05 - $FBEA Sprite falling into a hole but
                                     ;        that has a special animation (e.g.
                                     ;        soldiers and hard hat beetles)
            dw SpriteDeath_Main      ; 0x06 - $F8A2 Death mode for normal creatures
            dw SpriteBurn_Main       ; 0x07 - $8543 Being incinerated? (By Fire Rod)
            dw SpritePrep_Main       ; 0x08 - $864D A spawning sprite
            dw SpriteActive_Main     ; 0x09 - $9271 An active sprite
            dw SpriteHeld_Main       ; 0x0A - $DE83 Sprite is being held above
                                     ;        Link's head
            dw SpriteStunned_Main    ; 0x0B - $DFFA Sprite is frozen and immobile
        
        .activeSprite
        
        JMP.w SpriteActive_Main
}

; $03050F-$03050F LOCAL JUMP LOCATION
SpritePrep_DoNothingI:
{
    RTS
}
    
; $030510-$030525 LOCAL JUMP LOCATION
SpriteModule_Inactive:
{
    LDA.b $1B : BNE .indoors
        ; TODO: OPTIMIZE: Worthless codes?
        TXA : ASL
        
        LDA.b #$FF : STA.w $0BC0, Y
                     STA.w $0BC1, Y
        
        RTS
    
    .indoors
    
    LDA.b #$FF : STA.w $0BC0, X
    
    RTS
}

; ==============================================================================

; $030526-$03052D LONG JUMP LOCATION
SpriteActive_MainLong:
{
    PHB : PHK : PLB
    
    JSR.w SpriteActive_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; Sprite mode for falling into a hole.
; $03052E-$030542 JUMP LOCATION
SpriteFall_Main:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0DD0, X
        
        JSL.l Dungeon_ManuallySetSpriteDeathFlag
        
        RTS
    
    .delay
    
    JSR.w Sprite_PrepOamCoord
    JSL.l SpriteFall_Draw
    
    RTS
}

; ==============================================================================

; $030543-$030547 JUMP LOCATION
SpriteBurn_Main:
{
    JSL.l SpriteBurn_Execute
    
    RTS
}

; ==============================================================================

; $030548-$03054C JUMP LOCATION
SpriteExplode_Main:
{
    JSL.l SpriteExplode_ExecuteLong
    
    RTS
}

; ==============================================================================

; $03054D-$03059B DATA
Pool_SpriteDrown_Main:
{
    ; $03054D
    .OAM_groups
    dw -7, -7 : db $80, $04, $00, $00
    dw 14, -6 : db $83, $04, $00, $00
    
    dw -6, -6 : db $CF, $04, $00, $00
    dw 13, -5 : db $DF, $04, $00, $00
    
    dw -4, -4 : db $AE, $04, $00, $00
    dw 12, -4 : db $AF, $44, $00, $00
    
    dw  0,  0 : db $E7, $04, $00, $02
    dw  0,  0 : db $E7, $04, $00, $02
    
    ; $03058D
    .vh_flip
    db $00, $40, $C0, $80
    
    ; $030591
    .chr
    db $C0, $C0, $C0, $C0, $CD, $CD, $CD, $CB
    db $CB, $CB, $CB
}

; Sprite Mode 0x03
; $03059C-$030611 JUMP LOCATION
SpriteDrown_Main:
{
    LDA.w $0D80, X : BEQ Drowning_DrawSprite
        LDA.w $0D90, X : CMP.b #$06 : BNE .BRANCH_BETA
            LDA.b #$08
            JSL.l OAM_AllocateFromRegionC
        
        .BRANCH_BETA
        
        LDA.w $0E60, X : EOR.b #$10 : STA.w $0E60, X
        
        JSR.w Sprite_PrepAndDrawSingleLarge
        
        ; Load hflip and vflip settings.
        LDA.w $0E80, X : LSR : LSR : AND.b #$03 : TAY
        LDA.w Pool_SpriteDrown_Main_vh_flip, Y : STA.b $05
        
        LDA.w $0DF0, X : CMP.b #$01 : BNE .notLastTimerTick
            STZ.w $0DD0, X
        
        .notLastTimerTick
        
        PHX
        
        LDA.b #$8A : BCC .timerExpired
            LDA.w $0DF0, X : LSR : TAX
            
            STZ.b $05
            
            ; Get address of first tile of the sprite.
            LDA.w Pool_SpriteDrown_Main_chr, X
        
        .timerExpired
        
        LDY.b #$02             : STA.b ($90), Y : INY
        LDA.b #$24 : ORA.b $05 : STA.b ($90), Y
        
        PLX
        
        LDA.w $0DF0, X : BNE EXIT_06861A
            JSR.w Sprite_CheckIfActive_permissive
            
            INC.w $0E80, X
            
            JSR.w Sprite_Move
            JSR.w Sprite_MoveAltitude
            
            LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
            
            LDA.w $0F70, X : BPL EXIT_06861A
                STZ.w $0F70, X
                
                LDA.b #$12 : STA.w $0DF0, X
}

; $030612-$030619 JUMP LOCATION
Sprite_DisableShadowFlag:
{
    LDA.w $0E60, X : AND.b #$EF : STA.w $0E60, X

    ; Bleeds into the next function.
}

; $03061A-$03061A JUMP LOCATION
EXIT_06861A:
{
    RTS
}

; $03061B-$03064C JUMP LOCATION
Drowning_DrawSprite:
{
    JSR.w Sprite_CheckIfActive_permissive
    
    LDA.b $1A : AND.b #$01 : BNE .BRANCH_ZETA
        INC.w $0DF0, X
    
    .BRANCH_ZETA
    
    STZ.w $0F50, X
    STZ.w $0EF0, X
    
    LDA.b #$00 : XBA
    LDA.w $0DF0, X : BNE .BRANCH_THETA
        STZ.w $0DD0, X
    
    .BRANCH_THETA
    
    REP #$20
    
    ASL : AND.w #$00F8 : ASL : ADC.w #Pool_SpriteDrown_Main_OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $03064D-$031282
incsrc "sprite_prep.asm"

; ==============================================================================
    
; SPRITE ROUTINES 1
; This is the table for all sprite objects used in the game.
; PARAMETER $0E20, X
; This is an unusual jump table. The jump values were fed onto the stack, and
; an RTS was used to jump there. In the above routine you will notice that the
; accumulator was decremented (DEC . That was intentional, since after an
; RTS, the processor pulls an address off the stack and increments it by one,
; thereby allowing it to travel to the addresses you see.
; $031283-$031468 JUMP TABLE
SpriteActive_Table:
{
    dw Sprite_RavenTrampoline            ; 0x00 - $946E Raven
    dw Sprite_VultureTrampoline          ; 0x01 - $9473 Vulture
    dw Sprite_StalfosHead                ; 0x02 - $DDB7 Flying Stalfos head
    dw $0000                             ; 0x03 - $0000 Since this leads to null
                                         ;        area, we presume this is unused
    dw Sprite_PullSwitchTrampoline       ; 0x04 - $C003 Good switch (down)
    dw Sprite_PullSwitchTrampoline       ; 0x05 - $C003 Bad Switch (down)
    dw Sprite_PullSwitchTrampoline       ; 0x06 - $C003 Good switch (up)
    dw Sprite_PullSwitchTrampoline       ; 0x07 - $C003 Bad switch (up)
    dw Sprite_Octorock                   ; 0x08 - $D377 Octorock
    dw Sprite_GiantMoldormTrampoline     ; 0x09 - $9469 Giant Moldorm
    dw Sprite_Octorock                   ; 0x0A - $D377 Four Shooter Octorock
    dw Sprite_Chicken                    ; 0x0B - $A5C2 Chicken / Chicken -> Lady
                                         ;        transformation
    dw Sprite_Octostone                  ; 0x0C - $D5B9 Rock Octorock projectile
    dw Sprite_Buzzblob                   ; 0x0D - $D89A Buzzblob
    dw Sprite_SnapDragon                 ; 0x0E - $9C24 Plants with big mouths
    dw Sprite_Octoballoon                ; 0x0F - $D6AA Octoballoon
    dw Sprite_Octospawn                  ; 0x10 - $D853 Small things from the
                                         ;        Octoballoon
    dw Sprite_Hinox                      ; 0x11 - $9F05 Hinox
    dw Sprite_Moblin                     ; 0x12 - $98E4 Moblin
    dw Sprite_Helmasaur                  ; 0x13 - $A409 Helmasaur
    dw Sprite_GargoyleGrateTrampoline    ; 0x14 - $C01C Gargoyle's Domain Entrance
    dw Sprite_Bubble                     ; 0x15 - $A50C Fire Fairy?
    dw Sprite_ElderTrampoline            ; 0x16 - $C08A Sahasralah / Aginah
    dw Sprite_CoveredRupeeCrab           ; 0x17 - $A86C Rupee Crab under bush
    dw Sprite_Moldorm                    ; 0x18 - $9808 Moldorm
    dw Sprite_Poe                        ; 0x19 - $9688 Poe
    dw Sprite_SmithyBros                 ; 0x1A - $B1EE Smithy bros
    dw Sprite_EnemyArrow                 ; 0x1B - $B754 Arrow in wall
    dw Sprite_MovableStatue              ; 0x1C - $C0E8 Movable Statue
    dw Sprite_WeathervaneTrigger         ; 0x1D - $C2E5 Weathervane Sprite
    dw Sprite_CrystalSwitch              ; 0x1E - $B8D0 Crystal Switches
    dw Sprite_BugNetKid                  ; 0x1F - $B94C Sick bug catching kid
    dw Sprite_Sluggula                   ; 0x20 - $95D9 Bomb Slug
    dw Sprite_PushSwitch                 ; 0x21 - $B9FA Water palace push switch
    dw Sprite_Ropa                       ; 0x22 - $9E1F Ropa
    dw Sprite_RedBari                    ; 0x23 - $A23D Bari (Red)
    dw Sprite_BlueBari                   ; 0x24 - $A23D Bari (Blue)
    dw Sprite_TalkingTreeTrampoline      ; 0x25 - $C0D5 Talking Tree
    dw Sprite_HardHatBeetle              ; 0x26 - $A460 Hard hat Beetle
    dw Sprite_DeadRock                   ; 0x27 - $948A Deadrock
    dw Sprite_StoryTeller_1              ; 0x28 - $AD6F Story Teller NPCs / DW
                                         ;        hint NPC
    dw Sprite_HumanMulti_1_Trampoline    ; 0x29 - $C0B7 Guy in Blind's Old Hideout /
                                         ;        Thieves Hideout Guy / Flute Boy's
                                         ;        Father
    dw Sprite_SweepingLadyTrampoline     ; 0x2A - $C0BC Sweeping lady
    dw Sprite_HoboEntities               ; 0x2B - $BDC1 Hobo under bridge (and helper
                                         ;        sprites)
    dw Sprite_LumberjacksTrampoline      ; 0x2C - $C0C1 Lumberjack Bros
    dw Sprite_UnusedTelepathTrampoline   ; 0x2D - $C0B2 Telepathic stones
    dw Sprite_FluteBoy                   ; 0x2E - $AF3B Flute boy, and his notes?
    dw Sprite_MazeGameLadyTrampoline     ; 0x2F - $C0CB Heart piece race guy / girl
    dw Sprite_MazeGameGuyTrampoline      ; 0x30 - $C0D0 Maze Game Guy
    dw Sprite_FortuneTellerTrampoline    ; 0x31 - $C0C6 Fortune Teller / Dwarf
                                         ;        Swordsmith
    dw Sprite_QuarrelBrosTrampoline      ; 0x32 - $C012 Quarreling Brothers
    dw Sprite_PullForRupeesTrampoline    ; 0x33 - $C017 Rupee prizes hidden in walls
    dw Sprite_YoungSnitchLadyTrampoline  ; 0x34 - $C021 Young Snitch Lady
    dw Sprite_InnKeeperTrampoline        ; 0x35 - $C02B Inn Keeper
    dw Sprite_WitchTrampoline            ; 0x36 - $C035 Witch?
    dw Sprite_WaterfallTrampoline        ; 0x37 - $C03A Waterfall sprite
    dw Sprite_ArrowTriggerTrampoline     ; 0x38 - $C03F Arrow trigger
    dw Sprite_MiddleAgedMan              ; 0x39 - $BCAC Middle aged man in the desert
    dw Sprite_MadBatterTrampoline        ; 0x3A - $C044 Magic Powder bat / lightning 
                                         ;        bolt he throws
    dw Sprite_DashItemTrampoline         ; 0x3B - $C049 Dash item (book of mudora
                                         ;        / etc)
    dw Sprite_TroughBoyTrempoline        ; 0x3C - $C04E TroughBoy
    dw Sprite_OldSnitchLadyTrampoline    ; 0x3D - $C053 Scared ladies and chicken 
                                         ;        lady, maybe others.
    dw Sprite_CoveredRupeeCrab           ; 0x3E - $A86C Rupee Crab under rock
    dw Sprite_TutorialEntitiesTrampoline ; 0x3F - $BFFE Tutorial Soldier
    dw Sprite_TutorialEntitiesTrampoline ; 0x40 - $BFFE Hyrule Castle Barrier
    dw SpriteActive2_Trampoline          ; 0x41 - $BFEA Blue Soldier
    dw SpriteActive2_Trampoline          ; 0x42 - $BFEA Green Soldier
    dw SpriteActive2_Trampoline          ; 0x43 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x44 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x45 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x46 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x47 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x48 - $BFEA Red Spear Soldier (in special
                                         ;        armor)
    dw SpriteActive2_Trampoline          ; 0x49 - $BFEA Red Spear Soldier (in bushes)
    dw SpriteActive2_Trampoline          ; 0x4A - $BFEA Green Enemy Bomb
    dw SpriteActive2_Trampoline          ; 0x4B - $BFEA Green Soldier (weak version)
    dw SpriteActive2_Trampoline          ; 0x4C - $BFEA Sand monster
    dw SpriteActive2_Trampoline          ; 0x4D - $BFEA Bunnies in tall grass /
                                         ;        on ground
    dw SpriteActive2_Trampoline          ; 0x4E - $BFEA Popo (aka Snakebasket)
    dw SpriteActive2_Trampoline          ; 0x4F - $BFEA Blobs?
    dw SpriteActive2_Trampoline          ; 0x50 - $BFEA Metal balls in Eastern Palace
    dw SpriteActive2_Trampoline          ; 0x51 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x52 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x53 - $BFEA Armos Knight
    dw SpriteActive2_Trampoline          ; 0x54 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x55 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x56 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x57 - $BFEA Desert Palace barriers
    dw SpriteActive2_Trampoline          ; 0x58 - $BFEA Crab
    dw SpriteActive2_Trampoline          ; 0x59 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5A - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5B - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5C - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5D - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5E - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x5F - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x60 - $BFEA Roller (horizontal)
    dw SpriteActive2_Trampoline          ; 0x61 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x62 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x63 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x64 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x65 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x66 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x67 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x68 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x69 - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x6A - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x6B - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x6C - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x6D - $BFEA Rat / Bazu
    dw SpriteActive2_Trampoline          ; 0x6E - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x6F - $BFEA 
    dw SpriteActive2_Trampoline          ; 0x70 - $BFEA 
    dw Sprite_Leever                     ; 0x71 - $CBA2
    dw Sprite_WishPond                   ; 0x72 - $C319 Pond of Wishing
    dw Sprite_UncleAndSageTrampoline     ; 0x73 - $BFE0 Uncle / Priest /
                                         ;        Sanctury Mantle
    dw Sprite_RunningManTrampoline       ; 0x74 - $C058 Scared red hat man
    dw Sprite_BottleVendorTrampoline     ; 0x75 - $C062 Bottle vendor 
    dw Sprite_ZeldaTrampoline            ; 0x76 - $C067 Princess Zelda (not the
                                         ;        tagalong)
    dw Sprite_Bubble                     ; 0x77 - $A50C Weird kind of Fire fairy?
    dw Sprite_ElderWifeTrampoline        ; 0x78 - $C071 Elder's Wife
    dw SpriteActive3_Transfer            ; 0x79 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7A - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7B - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7C - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7D - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7E - $BFEF 
    dw SpriteActive3_Transfer            ; 0x7F - $BFEF 
    dw SpriteActive3_Transfer            ; 0x80 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x81 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x82 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x82 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x82 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x85 - $BFEF Yellow Stalfos
    dw SpriteActive3_Transfer            ; 0x86 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x87 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x88 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x89 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8A - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8B - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8C - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8D - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8E - $BFEF 
    dw SpriteActive3_Transfer            ; 0x8F - $BFEF 
    dw SpriteActive3_Transfer            ; 0x90 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x91 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x92 - $BFEF helamsaur king
    dw SpriteActive3_Transfer            ; 0x93 - $BFEF Bumper
    dw SpriteActive3_Transfer            ; 0x94 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x95 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x96 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x97 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x98 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x99 - $BFEF 
    dw SpriteActive3_Transfer            ; 0x9A - $BFEF Kyameron
    dw SpriteActive3_Transfer            ; 0x9B - $BFEF 
    dw SpriteActive3_Transfer            ; 0x9C - $BFEF 
    dw SpriteActive3_Transfer            ; 0x9D - $BFEF 
    dw SpriteActive3_Transfer            ; 0x9E - $BFEF 
    dw SpriteActive3_Transfer            ; 0x9F - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA0 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA1 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA2 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA3 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA4 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA5 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA6 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA7 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xA8 - $BFEF Green Bomber (Zirro?)
    dw SpriteActive3_Transfer            ; 0xA9 - $BFEF Blue Bomber (Zirro?)
    dw SpriteActive3_Transfer            ; 0xAA - $BFEF 
    dw SpriteActive3_Transfer            ; 0xAB - $BFEF 
    dw SpriteActive3_Transfer            ; 0xAC - $BFEF 
    dw SpriteActive3_Transfer            ; 0xAD - $BFEF 
    dw SpriteActive3_Transfer            ; 0xAE - $BFEF 
    dw SpriteActive3_Transfer            ; 0xAF - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB0 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB1 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB2 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB3 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB4 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB5 - $BFEF Elephant salesman
    dw SpriteActive3_Transfer            ; 0xB6 - $BFEF Kiki the monkey (B6)
    dw SpriteActive3_Transfer            ; 0xB7 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xB8 - $BFEF Monologue testing sprite
    dw SpriteActive3_Transfer            ; 0xB9 - $BFEF 
    dw SpriteActive3_Transfer            ; 0xBA - $BFEF 
    dw SpriteActive3_Transfer            ; 0xBB - $BFEF Shop Keeper / Chest Game Guys
    dw SpriteActive3_Transfer            ; 0xBC - $BFEF 
    dw SpriteActive4_Transfer            ; 0xBD - $BFF4 
    dw SpriteActive4_Transfer            ; 0xBE - $BFF4 Mystery sprite "???" in HM
    dw SpriteActive4_Transfer            ; 0xBF - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC0 - $BFF4 Cranky Lake Monster
    dw SpriteActive4_Transfer            ; 0xC1 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC2 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC3 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC4 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC5 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC6 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC7 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xC8 - $BFF4 Big Fairy
    dw SpriteActive4_Transfer            ; 0xC9 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xCA - $BFF4 Chain Chomp
    dw SpriteActive4_Transfer            ; 0xCB - $BFF4 
    dw SpriteActive4_Transfer            ; 0xCC - $BFF4 
    dw SpriteActive4_Transfer            ; 0xCD - $BFF4 
    dw SpriteActive4_Transfer            ; 0xCE - $BFF4 Blind
    dw SpriteActive4_Transfer            ; 0xCF - $BFF4 Swamola
    dw SpriteActive4_Transfer            ; 0xD0 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xD1 - $BFF4 Pointer for Yellow hunter
    dw SpriteActive4_Transfer            ; 0xD2 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xD3 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xD4 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xD5 - $BFF4 
    dw SpriteActive4_Transfer            ; 0xD6 - $BFF4 Pointer for Ganon.
    dw SpriteActive4_Transfer            ; 0xD7 - $BFF4 
    dw Sprite_HeartRefill                ; 0xD8 - $CEC0 Heart refill
    dw Sprite_GreenRupee                 ; 0xD9 - $D04A 
    dw Sprite_BlueRupee                  ; 0xDA - $D04A 
    dw Sprite_RedRupee                   ; 0xDB - $D04A 
    dw Sprite_OneBombRefill              ; 0xDC - $D04A 1 Bomb Refill
    dw Sprite_FourBombRefill             ; 0xDD - $D04A 4 Bomb Refill
    dw Sprite_EightBombRefill            ; 0xDE - $D04A 8 Bomb Refill
    dw Sprite_SmallMagicRefill           ; 0xDF - $D04A Small Magic Refill
    dw Sprite_FullMagicRefill            ; 0xE0 - $D04A Full Magic Refill
    dw Sprite_FiveArrowRefill            ; 0xE1 - $D04A 5 Arrow Refill
    dw Sprite_TenArrowRefill             ; 0xE2 - $D04A 10 Arrow Refill
    dw Sprite_Fairy                      ; 0xE3 - $CF94 Fairy
    dw Sprite_Key                        ; 0xE4 - $D032 Key 
    dw Sprite_BigKey                     ; 0xE5 - $D032 Big Key
    dw Sprite_ShieldPickup               ; 0xE6 - $D04A Shield Pickup (from Pikit)
    dw Sprite_MushroomTrampoline         ; 0xE7 - $C076 Mushroom
    dw Sprite_FakeSwordTrampoline        ; 0xE8 - $C080 Fake Master Sword
    dw Sprite_PotionShopTrampoline       ; 0xE9 - $C08F Magic Shop Dude and his items
    dw Sprite_HeartContainerTrampoline   ; 0xEA - $C099 Heart Container
    dw Sprite_HeartPieceTrampoline       ; 0xEB - $C0A3 Heart piece
    dw SpritePrep_DoNothingI             ; 0xEC - $850F pot/bush/etc
    dw Sprite_SomariaPlatformTrampoline  ; 0xED - $C008 Cane of Somaria Platform
    dw Sprite_MovableMantleTrampoline    ; 0xEE - $A853 Mantle in throne room
    dw Sprite_SomariaPlatformTrampoline  ; 0xEF - $C008 Cane of Somaria Platform
    dw Sprite_SomariaPlatformTrampoline  ; 0xF0 - $C008 Cane of Somaria Platform
    dw Sprite_SomariaPlatformTrampoline  ; 0xF1 - $C008 Cane of Somaria Platform
    dw Sprite_MedallionTabletTrampoline  ; 0xF2 - $C00D Medallion Tablet
}

; ==============================================================================

; $031469-$03146D JUMP LOCATION
Sprite_GiantMoldormTrampoline:
{
    JSL.l Sprite_GiantMoldormLong
    
    RTS
}

; ==============================================================================

; $03146E-$031472 JUMP LOCATION
Sprite_RavenTrampoline:
{
    JSL.l Sprit_RavenLong
    
    RTS
}

; ==============================================================================

; $031473-$031477 JUMP LOCATION
Sprite_VultureTrampoline:
{
    JSL.l Sprite_VultureLong
    
    RTS
}

; ==============================================================================

; $031478-$0315C8
incsrc "sprite_deadrock.asm"

; $0315C9-$031685
incsrc "sprite_sluggula.asm"

; $031686-$0317D7
incsrc "sprite_poe.asm"

; $0317D8-$0318DF
incsrc "sprite_moldorm.asm"

; $0318E0-$031C1F
incsrc "sprite_moblin.asm"

; $031C20-$031E1E
incsrc "sprite_snap_dragon.asm"

; $031E1F-$031F04
incsrc "sprite_ropa.asm"

; $031F05-$032212
incsrc "sprite_hinox.asm"

; $032213-$0323F8
incsrc "sprite_bari.asm"

; $0323F9-$03250B
incsrc "sprite_helmasaur.asm"

; $03250C-$03253F
incsrc "sprite_bubble.asm"

; $032540-$032852
incsrc "sprite_chicken.asm"

; ==============================================================================

; $032853-$032857 JUMP LOCATION
Sprite_MovableMantleTrampoline:
{
    JSL.l Sprite_MovableMantleLong
    
    RTS
}

; ==============================================================================

; $032858-$032ABD
incsrc "sprite_rupee_crab.asm"

; $032ABE-$032D02
incsrc "sprite_throwable_scenery.asm"

; ==============================================================================

; $032D03-$032D4F LOCAL JUMP LOCATION
Entity_ApplyRumbleToSprites:
{
    LDY.b #$0F
    
    .next_sprite
    
        LDA.w $0CAA, Y : AND.b #$02 : BEQ .skip_sprite
            LDA.w $0E90, Y : BEQ .skip_sprite
                LDA.w $0FC6 : CMP.b #$0E : BEQ .collision_guaranteed
                    PHX
                    
                    ; Loads up all the bases and widths for the collision
                    ; detection...
                    TYX
                    JSR.w Sprite_SetupHitBox
                    
                    PLX
                    
                    ; Does the actual collision detection...
                    JSR.w Utility_CheckIfHitBoxesOverlap : BCC .skip_sprite
                
                .collision_guaranteed
                
                ; Maybe other sprites react to this, but primarily the apple
                ; sprites hidden in trees split when this variable is set low.
                LDA.b #$00 : STA.w $0E90, Y
                
                LDA.b #$30 : STA.w $012F
                
                LDA.b #$30 : STA.w $0F80, Y
                LDA.b #$10 : STA.w $0D50, X
                LDA.b #$30 : STA.w $0EE0, Y
                LDA.b #$FF : STA.w $0B58, Y
                
                ; NOTE: Interestingly enough, this is not really a heart refill,
                ; but a trigger for a bomb to be knocked out of a tree. What a
                ; mess this game's sprites system is. assassin17 knows it too,
                ; and I've known it for somewhat longer, but it still manages to
                ; surprise me now and then.
                LDA.w $0E20, Y : CMP.b #$D8 : BNE .not_single_heart_refill
                    JSL.l Sprite_TransmuteToEnemyBomb

                .not_single_heart_refill
            .skip_sprite
    DEY : BPL .next_sprite
    
    RTS
}

; ==============================================================================

; $032D50-$032D6E LONG JUMP LOCATION
Sprite_TransmuteToEnemyBomb:
{
    LDA.b #$4A : STA.w $0E20, X
    LDA.b #$01 : STA.w $0DB0, X
    LDA.b #$FF : STA.w $0E00, X
    LDA.b #$18 : STA.w $0E60, X
    LDA.b #$08 : STA.w $0F50, X
    LDA.b #$00 : STA.w $0E50, X
    
    RTL
}

; ==============================================================================

; $032D6F-$032F3A
incsrc "sprite_story_teller_multi_1.asm"

; $032F3B-$0331DD
incsrc "sprite_flute_boy.asm"

; $0331DE-$033749
incsrc "sprite_smithy_bros.asm"

; $03374A-$0338CD
incsrc "sprite_enemy_arrow.asm"

; $0338CE-$03394B
incsrc "sprite_crystal_switch.asm"

; $03394C-$0339E5
incsrc "sprite_bug_net_kid.asm"

; $0339E6-$033CAB
incsrc "sprite_push_switch.asm"

; $033CAC-$033DC0
incsrc "sprite_middle_aged_man.asm"

; $033DC1-$033FDF
incsrc "sprite_hobo.asm"

; ==============================================================================

; Uncle / Priest / Santuary Mantle
; $033FE0-$033FE4 JUMP LOCATION
Sprite_UncleAndSageTrampoline:
{
    JSL.l Sprite_UncleAndSageLong
    
    RTS
}

; ==============================================================================

; $033FE5-$033FE9 JUMP LOCATION
SpritePrep_UncleAndSageTrampoline:
{
    JSL.l SpritePrep_UncleAndSageLong
    
    RTS
}

; ==============================================================================

; $033FEA-$033FEE JUMP LOCATION
SpriteActive2_Trampoline:
{
    JSL.l SpriteActive2_MainLong
    
    RTS
}

; ==============================================================================

; $033FEF-$033FF3 JUMP LOCATION
SpriteActive3_Transfer:
{
    JSL.l SpriteActive3_MainLong
    
    RTS
}

; ==============================================================================

; $033FF4-$033FF8 JUMP LOCATION
SpriteActive4_Transfer:
{
    JSL.l SpriteActive4_MainLong
    
    RTS
}

; ==============================================================================

; $033FF9-$033FFD JUMP LOCATION
SpritePrep_OldMountainManTrampoline:
{
    JSL.l SpritePrep_OldMountainManLong
    
    RTS
}

; ==============================================================================

; $033FFE-$034002 JUMP LOCATION
Sprite_TutorialEntitiesTrampoline:
{
    JSL.l Sprite_TutorialEntitiesLong
    
    RTS
}

; ==============================================================================

; $034003-$034007 JUMP LOCATION
Sprite_PullSwitchTrampoline:
{
    JSL.l Sprite_PullSwitch
    
    RTS
}

; ==============================================================================

; $034008-$03400C JUMP LOCATION
Sprite_SomariaPlatformTrampoline:
{
    JSL.l Sprite_SomariaPlatformLong
    
    RTS
}

; ==============================================================================

; $03400D-$034011 JUMP LOCATION
Sprite_MedallionTabletTrampoline:
{
    ; Medallion Tablet
    JSL.l Sprite_MedallionTabletLong
    
    RTS
}

; ==============================================================================

; $034012-$034016 JUMP LOCATION
Sprite_QuarrelBrosTrampoline:
{
    JSL.l Sprite_QuarrelBrosLong
    
    RTS
}

; ==============================================================================

; $034017-$03401B JUMP LOCATION
Sprite_PullForRupeesTrampoline:
{
    JSL.l Sprite_PullForRupeesLong
    
    RTS
}

; ==============================================================================

; $03401C-$034020 JUMP LOCATION
Sprite_GargoyleGrateTrampoline:
{
    JSL.l Sprite_GargoyleGrateLong
    
    RTS
}

; ==============================================================================

; $034021-$034025 JUMP LOCATION
Sprite_YoungSnitchLadyTrampoline:
{
    JSL.l Sprite_YoungSnitchLadyLong
    
    RTS
}

; ==============================================================================

; $034026-$03402A JUMP LOCATION
SpritePrep_YoungSnitchGirl:
{
    JSL.l SpritePrep_SnitchesLong
    
    RTS
}

; ==============================================================================

; $03402B-$03402F JUMP LOCATION
Sprite_InnKeeperTrampoline:
{
    JSL.l Sprite_InnKeeperLong
    
    RTS
}

; ==============================================================================

; $034030-$034034 JUMP LOCATION
SpritePrep_InnKeeper:
{
    JSL.l SpritePrep_SnitchesLong
    
    RTS
}

; ==============================================================================

; $034035-$034039 JUMP LOCATION
Sprite_WitchTrampoline:
{
    JSL.l Sprite_WitchLong
    
    RTS
}

; ==============================================================================

; $03403A-$03403E JUMP LOCATION
Sprite_WaterfallTrampoline:
{
    JSL.l Sprite_WaterfallLong
    
    RTS
}

; ==============================================================================

; $03403F-$034043 JUMP LOCATION
Sprite_ArrowTriggerTrampoline:
{
    JSL.l Sprite_ArrowTriggerLong
    
    RTS
}

; ==============================================================================

; $034044-$034048 JUMP LOCATION
Sprite_MadBatterTrampoline:
{
    JSL.l Sprite_MadBatterLong
    
    RTS
}

; ==============================================================================

; $034049-$03404D JUMP LOCATION
Sprite_DashItemTrampoline:
{
    JSL.l Sprite_DashItemLong
    
    RTS
}

; ==============================================================================

; $03404E-$034052 JUMP LOCATION
Sprite_TroughBoyTrempoline:
{
    JSL.l Sprite_TroughBoyLong
    
    RTS
}

; ==============================================================================

; $034053-$034057 JUMP LOCATION
Sprite_OldSnitchLadyTrampoline:
{
    JSL.l Sprite_OldSnitchLadyLong
    
    RTS
}

; ==============================================================================

; $034058-$03405C JUMP LOCATION
Sprite_RunningManTrampoline:
{
    JSL.l Sprite_RunningManLong
    
    RTS
}

; ==============================================================================

; $03405D-$034061 JUMP LOCATION
SpritePrep_RunningManTrampoline:
{
    JSL.l SpritePrep_RunningManLong
    
    RTS
}

; ==============================================================================

; $034062-$034066 JUMP LOCATION
Sprite_BottleVendorTrampoline:
{
    ; Bottle Vendor AI
    
    JSL.l Sprite_BottleVendorLong
    
    RTS
}

; ==============================================================================

; $034067-$03406B JUMP LOCATION
Sprite_ZeldaTrampoline:
{
    JSL.l Sprite_ZeldaLong
    
    RTS
}

; ==============================================================================

; $03406C-$034070 JUMP LOCATION
SpritePrep_ZeldaTrampoline:
{
    JSL.l SpritePrep_ZeldaLong
    
    RTS
}

; ==============================================================================

; $034071-$034075 JUMP LOCATION
Sprite_ElderWifeTrampoline:
{
    JSL.l Sprite_ElderWifeLong
    
    RTS
}

; ==============================================================================

; $034076-$03407A JUMP LOCATION
Sprite_MushroomTrampoline:
{
    JSL.l Sprite_MushroomLong
    
    RTS
}

; ==============================================================================

; $03407B-$03407F JUMP LOCATION
SpritePrep_MushroomTrampoline:
{
    JSL.l SpritePrep_MushroomLong
    
    RTS
}

; ==============================================================================

; $034080-$034084 JUMP LOCATION
Sprite_FakeSwordTrampoline:
{
    JSL.l Sprite_FakeSwordLong
    
    RTS
}

; ==============================================================================

; $034085-$034089 JUMP LOCATION
SpritePrep_FakeSwordTrampoline:
{
    JSL.l SpritePrep_FakeSword
    
    RTS
}

; ==============================================================================

; $03408A-$03408E JUMP LOCATION
Sprite_ElderTrampoline:
{
    JSL.l Sprite_ElderLong
    
    RTS
}

; ==============================================================================

; $03408F-$034093 JUMP LOCATION
Sprite_PotionShopTrampoline:
{
    JSL.l Sprite_PotionShopLong
    
    RTS
}

; ==============================================================================

; $034094-$034098 JUMP LOCATION
SpritePrep_PotionShopTrampoline:
{
    JSL.l SpritePrep_PotionShopLong
    
    RTS
}

; ==============================================================================

; $034099-$03409D JUMP LOCATION
Sprite_HeartContainerTrampoline:
{
    JSL.l Sprite_HeartContainerLong
    
    RTS
}

; ==============================================================================

; $03409E-$0340A2 JUMP LOCATION
SpritePrep_HeartContainerTrampoline:
{
    JSL.l SpritePrep_HeartContainerLong
    
    RTS
}

; ==============================================================================

; $0340A3-$0340A7 JUMP LOCATION
Sprite_HeartPieceTrampoline:
{
    JSL.l Sprite_HeartPieceLong
    
    RTS
}

; ==============================================================================

; $0340A8-$0340AC JUMP LOCATION
SpritePrep_HeartPieceTrampoline:
{
    JSL.l SpritePrep_HeartPieceLong
    
    RTS
}

; ==============================================================================

; $0340AD-$0340B1 JUMP LOCATION (UNUSED)
FluteBoy_UnusedInvocation:
{
    JSL.l Sprite_FluteBoy
    
    RTS
}

; ==============================================================================

; $0340B2-$0340B6 JUMP LOCATION
Sprite_UnusedTelepathTrampoline:
{
    JSL.l Sprite_UnusedTelepathLong
    
    RTS
}

; ==============================================================================

; $0340B7-$0340BB JUMP LOCATION
Sprite_HumanMulti_1_Trampoline:
{
    JSL.l Sprite_HumanMulti_1_Long
    
    RTS
}

; ==============================================================================

; $0340BC-$0340C0 JUMP LOCATION
Sprite_SweepingLadyTrampoline:
{
    JSL.l Sprite_SweepingLadyLong
    
    RTS
}

; ==============================================================================

; $0340C1-$0340C5 JUMP LOCATION
Sprite_LumberjacksTrampoline:
{
    JSL.l Sprite_LumberjacksLong
    
    RTS
}

; ==============================================================================

; $0340C6-$0340CA JUMP LOCATION
Sprite_FortuneTellerTrampoline:
{
    JSL.l Sprite_FortuneTellerLong
    
    RTS
}

; ==============================================================================

; $0340CB-$0340CF JUMP LOCATION
Sprite_MazeGameLadyTrampoline:
{
    JSL.l Sprite_MazeGameLadyLong
    
    RTS
}

; ==============================================================================

; $0340D0-$0340D4 JUMP LOCATION
Sprite_MazeGameGuyTrampoline:
{
    JSL.l Sprite_MazeGameGuyLong
    
    RTS
}

; ==============================================================================

; $0340D5-$0340D9 JUMP LOCATION
Sprite_TalkingTreeTrampoline:
{
    JSL.l Sprite_TalkingTreeLong
    
    RTS
}

; ==============================================================================

; $0340DA-$0342E4
incsrc "sprite_movable_statue.asm"

; $0342E5-$034308
incsrc "sprite_weathervane_trigger.asm"

; $034309-$034BA1
incsrc "sprite_ponds.asm"

; $034BA2-$034EBF
incsrc "sprite_leever.asm"

; $034EC0-$034F63
incsrc "sprite_heart_refill.asm"

; $034F64-$03502F
incsrc "sprite_fairy.asm"

; $035030-$035362
incsrc "sptite_absorbable.asm"

; $035363-$0355B8
incsrc "sprite_octorock.asm"

; $0355B9-$0356A1
incsrc "sprite_octostone.asm"

; $0356A2-$035842
incsrc "sprite_octoballoon.asm"

; $035853-$035891
incsrc "sprite_octospawn.asm"

; $035892-$0359BF
incsrc "sprite_buzzblob.asm"

; ==============================================================================

; $0359C0-$0359D4 LOCAL JUMP LOCATION
Sprite_WallInducedSpeedInversion:
{
    LDA.w $0E70, X : AND.b #$03 : BEQ .no_horiz_collision
        JSR.w Sprite_InvertHorizSpeed
    
    .no_horiz_collision
    
    LDA.w $0E70, X : AND.b #$0C : BEQ .no_vert_collision
        JSR.w Sprite_InvertVertSpeed
    
    .no_vert_collision
    
    RTS
}

; ==============================================================================

; $0359D5-$0359E1 LOCAL JUMP LOCATION
Sprite_Invert_XY_Speeds:
{
    JSR.w Sprite_InvertVertSpeed

    ; Bleeds into the next function.
}

; $0359D8-$0359E1 LOCAL JUMP LOCATION
Sprite_InvertHorizSpeed:
{
    ; Flip sign of X velocity
    LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0359E2-$0359EB LOCAL JUMP LOCATION
Sprite_InvertVertSpeed:
{
    ; Flip sign of Y velocity
    LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0359EC-$035A08 LOCAL JUMP LOCATION
Sprite_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        ; $0359F3 ALTERNATE ENTRY POINT
        .permissive
    
        LDA.w $0FC1 : BNE .inactive
            LDA.b $11 : BNE .inactive
                LDA.w $0CAA, X : BMI .active
                    LDA.w $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .active
    
    RTS
}

; ==============================================================================

; $035A09-$035B03 DATA
SpriteDraw_IDtoClass:
{
    ; 0x00
    ; $035A09
    db $A0, $A2, $A0, $A2
    db $80, $82, $80, $82

    ; 0x08 - Cucco
    ; $035A11
    db $EA, $EC

    ; 0x0A - Octorok stone
    ; $035A13
    db $84

    ; 0x0B - Buzz blob
    ; $035A14
    db $4E, $61

    ; 0x0D - Octoballoon baby
    ; $035A16
    db $BD

    ; 0x0E - Kodongo fire
    ; $035A17
    db $8C

    ; 0x0F - Red guard/Elder
    ; $035A18
    db $20, $22

    ; 0x11 - Hoarder
    ; $035A1A
    db $C0, $C2

    ; 0x13 - Poe
    ; $035A1C
    db $E6

    ; 0x14 - Crystal switch
    ; $035A1D
    db $E4

    ; 0x15 - Sluggula
    ; $035A1E
    db $82, $AA, $84, $AC
    db $80, $A0

    ; 0x1B - Water switch
    ; $035A24
    db $CA

    ; 0x1C - Flute kid
    ; $035A25
    db $AF

    ; 0x1D - Heart
    ; $035A26
    db $29, $39

    ; 0x1F - Rupees
    ; $035A28
    db $0B

    ; 0x20 - Bombs
    ; $035A29
    db $6E

    ; 0x21 - Small magic
    ; $035A2A
    db $60

    ; 0x22 - Full magic
    ; $035A2B
    db $62

    ; 0x23 - Arrows
    ; $035A2C
    db $63

    ; 0x24 - Mirror portal
    ; $035A2D
    db $4C

    ; 0x25 - Fairy
    ; $035A2E
    db $EA, $EC

    ; 0x27 - Bonk item
    ; $035A30
    db $24

    ; 0x28 - Small key
    ; $035A31
    db $6B

    ; 0x29 - Mushroom
    ; $035A32
    db $24

    ; 0x2A - Bari
    ; $035A33
    db $22, $24, $26, $20
    db $30, $21

    ; 0x30 - Cannonball
    ; $035A39
    db $2A, $24

    ; 0x32 - Rat
    ; $035A3B
    db $86, $88, $8A, $8C
    db $8E, $A2

    ; 0x38 - Rope
    ; $035A41
    db $A4, $A6, $A8

    ; 0x3B - Mothula beam
    ; $035A44
    db $AA

    ; 0x3C - Keese
    ; $035A45
    db $84, $80, $82

    ; 0x3F - Bomb
    ; $035A48
    db $6E

    ; 0x40 - Popo
    ; $035A49
    db $40, $42

    ; 0x42 - Hoarder/Spike block
    ; $035A4B
    db $E6, $E8

    ; 0x44 - Cannonball
    ; $035A4D
    db $80, $82

    ; 0x46 - Zora
    ; $035A4F
    db $C8

    ; 0x47 - Zora/fireball
    ; $035A50
    db $8D

    ; 0x48 - Lost woods bird
    ; $035A51
    db $E3, $E5

    ; 0x4A - Lost woods squirrel
    ; $035A53
    db $C5, $E1

    ; 0x4C - Archery game guy
    ; $035A55
    db $04, $24

    ; 0x4E - Wall cannon
    ; $035A57
    db $0E, $2E, $0C, $0A

    ; 0x52 - Big fairy
    ; $035A5B
    db $9C, $C7, $B6, $B7

    ; 0x56 - Mini helmasaur
    ; $035A5F
    db $60, $62, $64, $66
    db $68, $6A

    ; 0x5C - Bee
    ; $035A65
    db $E4, $F4

    ; 0x5E - Green stalfos
    ; $035A67
    db $02, $02, $00, $04

    ; 0x62 - Aga balls
    ; $035A6B
    db $C6, $CC, $CE

    ; 0x65 - Fire snake, sparks
    ; $035A6E
    db $28

    ; 0x66 - Hover
    ; $035A6F
    db $84, $82, $80

    ; 0x69 - Apple
    ; $035A72
    db $E5

    ; 0x6A - Big key
    ; $035A73
    db $24

    ; 0x6B - Stalfos head
    ; $035A74
    db $00, $02, $04

    ; 0x6E - Kodongo
    ; $035A77
    db $A0, $AA, $A4, $A6
    db $AC, $A2, $A8

    ; 0x75 - Arrghi/Wizzrobe
    ; $035A7E
    db $A6, $88, $86

    ; 0x78 - Terror pin
    ; $035A81
    db $8E, $AE, $8A

    ; 0x7B - Blob
    ; $035A84
    db $42, $44, $42, $44
    db $64, $66

    ; 0x81 - King Helmasaur fireball
    ; $035A8A
    db $CC, $CC, $CA

    ; 0x84 - Pirogusu
    ; $035A8D
    db $87, $97, $8E, $AE
    db $AC, $8C, $8E, $AA
    db $AC

    ; 0x8D - Laser eye
    ; $035A96
    db $D2, $F3

    ; 0x8F - Master sword
    ; $035A98
    db $84, $A2, $84, $A4
    db $E7

    ; 0x94 - Kyameron
    ; $035A9D
    db $8A, $A8, $8A, $A8
    db $88, $A0, $A4, $A2
    db $A6, $A6, $A6, $A6

    ; 0xA0 - Zoro
    ; $035AA9
    db $7E, $7F

    ; 0xA2 - Haunted grove rabbit
    ; $035AAB
    db $8A, $88, $8C, $A6

    ; 0xA6 - Haunted grove bird
    ; $035AAF
    db $86, $8E, $AC, $86

    ; 0xAA - Hobo
    ; $035AB3
    db $BB, $AC, $A9, $B9
    db $AA, $BA, $BC

    ; 0xB1 - Falling ice
    ; $035ABA
    db $8A, $8E, $8A, $86

    ; 0xB5 - Zazak fire ball
    ; $035ABE
    db $0A

    ; 0xB6 - Deadrock
    ; $035ABF
    db $C2, $C4, $E2, $E4
    db $C6

    ; 0xBB - Magic bat
    ; $035AC4
    db $EA, $EC

    ; 0xBD - Zirro bomb
    ; $035AC6
    db $FF

    ; 0xBE - Vitreous small eye
    ; $035AC7
    db $E6, $C6

    ; 0xC0 - Lightning
    ; $035AC9
    db $CC, $EC, $CE, $EE
    db $4C, $6C, $4E, $6E

    ; 0xC8 - Raven
    ; $035AD1
    db $C8, $C4, $C6

    ; 0xCB - Mini moldorm
    ; $035AD4
    db $88, $8C

    ; 0xCD - Heart container
    ; $035AD6
    db $24

    ; 0xCE - Heart piece
    ; $035AD7
    db $E0

    ; 0xCF - King Helmasaur
    ; $035AD8
    db $AE, $C0, $C8, $C4
    db $C6, $E2, $E0

    ; 0xD6 - Purple chest
    ; $035ADF
    db $EE

    ; 0xD7 - Gibo
    ; $035AE0
    db $AE

    ; 0xD8 - Pokey
    ; $035AE1
    db $A0, $80

    ; 0xDA - Whirlpool
    ; $035AE3
    db $EE

    ; 0xDB - Bully/Victim
    ; $035AE4
    db $C0, $C2, $BF

    ; 0xDE - Chain chomp
    ; $035AE7
    db $8C, $AA, $86, $A8
    db $A6

    ; 0xE3 - Trinexx
    ; $035AEC
    db $2C, $28, $06

    ; 0xE6 - Bomb shop guy
    ; $035AEF
    db $DF, $CF, $A9

    ; 0xE9 - Shopkeeper
    ; $035AF2
    db $46, $46

    ; 0xEB - Swamola
    ; $035AF4
    db $EA, $C0, $C2, $E0
    db $E8, $E2, $E6, $E4

    ; 0xF3 - Waterfall
    ; $035AFC
    db $0B

    ; 0xF4 - Ganon
    ; $035AFD
    db $8E, $A0

    ; 0xF6 - Stolen shield
    ; $035AFF
    db $EC, $EA

    ; 0xF8 - Talking tree
    ; $035B01
    db $E9

    ; 0xF9 - Boulder
    ; $035B02
    db $48, $58
}

; ==============================================================================

; $035B04-$035BEF DATA
SpriteDraw_ClassToChar:
{
    db $C8 ; RAVEN
    db $00 ; VULTURE
    db $6B ; STALFOS HEAD
    db $00 ; NULL
    db $00 ; CORRECT PULL SWITCH
    db $00 ; UNUSED CORRECT PULL SWITCH
    db $00 ; WRONG PULL SWITCH
    db $00 ; UNUSED WRONG PULL SWITCH
    db $00 ; OCTOROK
    db $CB ; MOLDORM
    db $00 ; OCTOROK 4WAY
    db $08 ; CUCCO
    db $0A ; OCTOROK STONE
    db $0B ; BUZZBLOB
    db $00 ; SNAPDRAGON
    db $00 ; OCTOBALLOON
    db $0D ; OCTOBALLOON BABY
    db $00 ; HINOX
    db $00 ; MOBLIN
    db $56 ; MINI HELMASAUR
    db $00 ; THIEVES TOWN GRATE
    db $00 ; ANTIFAIRY
    db $0F ; SAHASRAHLA / AGINAH
    db $11 ; HOARDER
    db $00 ; MINI MOLDORM
    db $13 ; POE
    db $00 ; SMITHY
    db $00 ; ARROW
    db $00 ; STATUE
    db $00 ; FLUTEQUEST
    db $14 ; CRYSTAL SWITCH
    db $00 ; SICK KID
    db $15 ; SLUGGULA
    db $1B ; WATER SWITCH
    db $00 ; ROPA
    db $2A ; RED BARI
    db $2A ; BLUE BARI
    db $F8 ; TALKING TREE
    db $00 ; HARDHAT BEETLE
    db $B6 ; DEADROCK
    db $00 ; DARK WORLD HINT NPC
    db $00 ; ADULT
    db $00 ; SWEEPING LADY
    db $AA ; HOBO
    db $00 ; LUMBERJACKS
    db $00 ; TELEPATHIC TILE
    db $1C ; FLUTE KID
    db $00 ; RACE GAME LADY
    db $00 ; RACE GAME GUY
    db $00 ; FORTUNE TELLER
    db $00 ; ARGUE BROS
    db $00 ; RUPEE PULL
    db $00 ; YOUNG SNITCH
    db $00 ; INNKEEPER
    db $00 ; WITCH
    db $F3 ; WATERFALL
    db $F3 ; EYE STATUE
    db $00 ; LOCKSMITH
    db $BB ; MAGIC BAT
    db $27 ; BONK ITEM
    db $00 ; KID IN KAK
    db $00 ; OLD SNITCH
    db $42 ; HOARDER
    db $00 ; TUTORIAL GUARD
    db $00 ; LIGHTNING GATE
    db $00 ; BLUE GUARD
    db $00 ; GREEN GUARD
    db $00 ; RED SPEAR GUARD
    db $00 ; BLUESAIN BOLT
    db $00 ; USAIN BOLT
    db $00 ; BLUE ARCHER
    db $00 ; GREEN BUSH GUARD
    db $00 ; RED JAVELIN GUARD
    db $0F ; RED BUSH GUARD
    db $3F ; BOMB GUARD
    db $00 ; GREEN KNIFE GUARD
    db $00 ; GELDMAN
    db $00 ; TOPPO
    db $40 ; POPO
    db $40 ; POPO
    db $44 ; CANNONBALL
    db $00 ; ARMOS STATUE
    db $00 ; KING ZORA
    db $00 ; ARMOS KNIGHT
    db $00 ; LANMOLAS
    db $47 ; ZORA / FIREBALL
    db $46 ; ZORA
    db $00 ; DESERT STATUE
    db $00 ; CRAB
    db $48 ; LOST WOODS BIRD
    db $4A ; LOST WOODS SQUIRREL
    db $65 ; SPARK
    db $65 ; SPARK
    db $00 ; ROLLER VERTICAL DOWN FIRST
    db $00 ; ROLLER VERTICAL UP FIRST
    db $00 ; ROLLER HORIZONTAL RIGHT FIRST
    db $00 ; ROLLER HORIZONTAL LEFT FIRST
    db $00 ; BEAMOS
    db $8F ; MASTERSWORD
    db $00 ; DEBIRANDO PIT
    db $00 ; DEBIRANDO
    db $4C ; ARCHERY GUY
    db $4E ; WALL CANNON VERTICAL LEFT
    db $4E ; WALL CANNON VERTICAL RIGHT
    db $4E ; WALL CANNON HORIZONTAL TOP
    db $4E ; WALL CANNON HORIZONTAL BOTTOM
    db $00 ; BALL N CHAIN
    db $30 ; CANNONBALL / CANNON TROOPER
    db $24 ; MIRROR PORTAL
    db $32 ; RAT / CRICKET
    db $38 ; SNAKE
    db $3C ; KEESE
    db $81 ; KING HELMASAUR FIREBALL
    db $00 ; LEEVER
    db $52 ; FAIRY POND TRIGGER
    db $00 ; UNCLE / PRIEST / MANTLE
    db $00 ; RUNNING MAN
    db $00 ; BOTTLE MERCHANT
    db $00 ; ZELDA
    db $00 ; ANTIFAIRY
    db $00 ; SAHASRAHLAS WIFE
    db $5C ; BEE
    db $00 ; AGAHNIM
    db $62 ; AGAHNIMS BALLS
    db $5E ; GREEN STALFOS
    db $00 ; BIG SPIKE
    db $00 ; FIREBAR CLOCKWISE
    db $00 ; FIREBAR COUNTERCLOCKWISE
    db $65 ; FIRESNAKE
    db $66 ; HOVER
    db $00 ; ANTIFAIRY CIRCLE
    db $00 ; GREEN EYEGORE / GREEN MIMIC
    db $00 ; RED EYEGORE / RED MIMIC
    db $00 ; YELLOW STALFOS
    db $6E ; KODONGO
    db $0E ; KONDONGO FIRE
    db $00 ; MOTHULA
    db $3B ; MOTHULA BEAM
    db $42 ; SPIKE BLOCK
    db $00 ; GIBDO
    db $00 ; ARRGHUS
    db $75 ; ARRGHI
    db $78 ; TERRORPIN
    db $7B ; BLOB
    db $00 ; WALLMASTER
    db $00 ; STALFOS KNIGHT
    db $CF ; KING HELMASAUR
    db $00 ; BUMPER
    db $84 ; PIROGUSU
    db $8D ; LASER EYE LEFT
    db $8D ; LASER EYE RIGHT
    db $8D ; LASER EYE TOP
    db $8D ; LASER EYE BOTTOM
    db $00 ; PENGATOR
    db $94 ; KYAMERON
    db $75 ; WIZZROBE
    db $A0 ; ZORO
    db $00 ; BABASU
    db $00 ; HAUNTED GROVE OSTRITCH
    db $A2 ; HAUNTED GROVE RABBIT
    db $A6 ; HAUNTED GROVE BIRD
    db $00 ; FREEZOR
    db $00 ; KHOLDSTARE
    db $00 ; KHOLDSTARE SHELL
    db $B1 ; FALLING ICE
    db $00 ; BLUE ZAZAK
    db $B5 ; RED ZAZAK
    db $00 ; STALFOS
    db $BD ; GREEN ZIRRO
    db $00 ; BLUE ZIRRO
    db $00 ; PIKIT
    db $00 ; CRYSTAL MAIDEN
    db $69 ; APPLE
    db $00 ; OLD MAN
    db $00 ; PIPE DOWN
    db $00 ; PIPE UP
    db $00 ; PIPE RIGHT
    db $00 ; PIPE LEFT
    db $5C ; GOOD BEE
    db $00 ; PEDESTAL PLAQUE
    db $D6 ; PURPLE CHEST
    db $E6 ; BOMB SHOP GUY
    db $00 ; KIKI
    db $00 ; BLIND MAIDEN
    db $00 ; DIALOGUE TESTER
    db $DB ; BULLY / PINK BALL
    db $DA ; WHIRLPOOL
    db $E9 ; SHOPKEEPER / CHEST GAME GUY
    db $00 ; DRUNKARD
    db $00 ; VITREOUS
    db $BE ; VITREOUS SMALL EYE
    db $C0 ; LIGHTNING
    db $6A ; CATFISH
    db $00 ; CUTSCENE AGAHNIM
    db $F9 ; BOULDER
    db $D7 ; GIBO
    db $00 ; THIEF
    db $00 ; MEDUSA
    db $00 ; 4WAY SHOOTER
    db $D8 ; POKEY
    db $00 ; BIG FAIRY
    db $00 ; TEKTITE / FIREBAT
    db $DE ; CHAIN CHOMP
    db $E3 ; TRINEXX ROCK HEAD
    db $00 ; TRINEXX FIRE HEAD
    db $00 ; TRINEXX ICE HEAD
    db $00 ; BLIND
    db $EB ; SWAMOLA
    db $00 ; LYNEL
    db $00 ; BUNNYBEAM / SMOKE
    db $00 ; FLOPPING FISH
    db $00 ; STAL
    db $00 ; LANDMINE
    db $00 ; DIG GAME GUY
    db $F4 ; GANON
    db $F4 ; GANON
    db $1D ; HEART
    db $1F ; GREEN RUPEE
    db $1F ; BLUE RUPEE
    db $1F ; RED RUPEE
    db $20 ; BOMB REFILL 1
    db $20 ; BOMB REFILL 4
    db $20 ; BOMB REFILL 8
    db $21 ; SMALL MAGIC DECANTER
    db $22 ; LARGE MAGIC DECANTER
    db $23 ; ARROW REFILL 5
    db $23 ; ARROW REFILL 10
    db $25 ; FAIRY
    db $28 ; SMALL KEY
    db $6A ; BIG KEY
    db $F6 ; STOLEN SHIELD
    db $29 ; MUSHROOM
    db $00 ; FAKE MASTER SWORD
    db $00 ; MAGIC SHOP ASSISTANT
    db $CD ; HEART CONTAINER
    db $CE ; HEART PIECE
}

; ==============================================================================

; $035BF0-$035BF7 LONG JUMP LOCATION
Sprite_PrepAndDrawSingleLargeLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    
    PLB
    
    RTL
}

; ==============================================================================

; $035BF8-$035BFF LONG JUMP LOCATION
Sprite_PrepAndDrawSingleSmallLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    
    PLB
    
    RTL
}

; ==============================================================================

; UNUSED:
; $035C00-$035C0F
UNREACHABLE_06DC00:
{
    db $00, $00, $01, $01, $01, $02, $02, $02
    db $02, $03, $03, $03, $03, $03, $03, $03
}

; $035C10-$035C4B LOCAL JUMP LOCATION
Sprite_PrepAndDrawSingleLarge:
{
    JSR.w Sprite_PrepOamCoord
    
    ; $035C13 ALTERNATE ENTRY POINT
    .just_draw
    
    LDA.b $00 : STA.b ($90), Y
    
    ; OPTIMIZE: WTF: Broken check?
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$01 : ROL : STA.b ($92)
    
    REP #$20
    
    LDA.b $02
    INY
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .out_of_bounds_y
        SBC.b #$0F : STA.b ($90), Y
        
        PHY
        
        LDY.w $0E20, X
        
        LDA.w SpriteDraw_ClassToChar, Y : CLC : ADC.w $0DC0, X : TAY
        LDA.w SpriteDraw_IDtoClass, Y : PLY : INY : STA.b ($90), Y
        LDA.b $05                           : INY : STA.b ($90), Y
    
    .out_of_bounds_y

    ; Bleeds into the next function.
}

; Optinally draw a shadow for the sprite if this flag is set.
; $035C4C-$035C53 LOCAL JUMP LOCATION
Sprite_DrawShadowRedundant:
{
    LDA.w $0E60, X : AND.b #$10 : BNE Sprite_DrawShadow
        RTS
}

; ==============================================================================

; $035C54-$035C5B LONG JUMP LOCATION
Sprite_DrawShadowLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_DrawShadow
    
    PLB
    
    RTL
}

; $035C5C-$035C63 LONG JUMP LOCATION
Sprite_DrawShadowLong_variable:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_DrawShadow_variable
    
    PLB
    
    RTL
}

; This draws the shadow underneath a sprite.
; $035C64-$035CEE LOCAL JUMP LOCATION
Sprite_DrawShadow:
{
    LDA.b #$0A
    
    ; $035C66 ALTERNATE ENTRY POINT
    .variable
    
                     CLC : ADC.w $0D00, X : STA.b $02
    LDA.w $0D20, X :       ADC.b #$00     : STA.b $03
    
    ; Is the sprite disabled ("paused", you might say).
    LDA.w $0F00, X : BNE .dontDrawShadow
        LDA.w $0DD0, X : CMP.b #$0A : BNE .notBeingCarried
            LDA.l $7FFA1C, X : CMP.b #$03 : BEQ .dontDrawShadow
        
        .notBeingCarried
        
        REP #$20
        
        LDA.b $02 : SEC : SBC.b $E8 : STA.b $02
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .offScreenY
            LDA.w $0E40, X : AND.b #$1F : ASL : ASL : TAY
            LDA.b $00 : STA.b ($90), Y
            
            LDA.w $0E60, X : AND.b #$20 : BEQ .delta
                INY
                
                ; This instruction doesn't seem to belong here, as it doesn't
                ; do anything (There's another LDA right after it).
                ; OPTIMIZE: Simply by taking it out, saves space and time.
                LDA.b ($90), Y
                
                LDA.b $02  : INC : STA.b ($90), Y

                INY
                LDA.b #$38 : STA.b ($90), Y
                
                LDA.b $05 : AND.b #$30 : ORA.b #$08 : INY : STA.b ($90), Y
                
                ; Ensures the lowest priority for the shadow.
                TYA : LSR : LSR : TAY
                LDA.b $01 : AND.b #$01 : STA.b ($92), Y
        
    .dontDrawShadow
    
    RTS
    
    .delta
    
    LDA.b $02  : INY : STA.b ($90), Y
    LDA.b #$6C : INY : STA.b ($90), Y
    
    LDA.b $05 : AND.b #$30 : ORA.b #$08 : INY : STA.b ($90), Y
    
    TYA : LSR : LSR : TAY
    
    LDA.b $01 : AND.b #$01 : ORA.b #$02 : STA.b ($92), Y
    
    .offScreenY
    
    RTS
}

; ==============================================================================

; $035CEF-$035D37 LOCAL JUMP LOCATION
Sprite_PrepAndDrawSingleSmall:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.b $00 : STA.b ($90), Y
    
    ; OPTIMIZE: WTF: Broken check?
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$00 : ROL : STA.b ($92)
    
    REP #$20
    
    LDA.b $02 : INY
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .BRANCH_ALPHA
        SBC.b #$0F : STA.b ($90), Y
        
        PHY
        
        LDY.w $0E20, X
        
        LDA.w SpriteDraw_ClassToChar, Y : CLC : ADC.w $0DC0, X : TAY
        
        LDA.w SpriteDraw_IDtoClass, Y : PLY : INY : STA.b ($90), Y
        LDA.b $05                           : INY : STA .b($90), Y
    
    .BRANCH_ALPHA
    
    LDA.w $0E60, X : AND.b #$10 : BEQ .BRANCH_BETA
        LDA.b #$02
        JMP.w Sprite_DrawShadow_variable
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $035D38-$035D3F LONG JUMP LOCATION
DashKey_Draw:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_DrawKey
    
    PLB
    
    RTL
}

; ==============================================================================

; $035D40-$035DAE LOCAL JUMP LOCATION
Sprite_DrawKey:
Sprite_DrawThinAndTall:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.b $00  : STA.b ($90), Y
    LDY.b #$04 : STA.b ($90), Y
    
    ; Get bit 8 of X coordinate, and force size to 8x8.
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$00 : ROL
    
    LDY.b #$00 : STA.b ($92), Y
    INY        : STA.b ($92), Y
    
    REP #$20
    
    LDA.b $02 : LDY.b #$01 : STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_upper_half_y
        LDA.w #$00F0 : STA.b ($90), Y
    
    .on_screen_upper_half_y
    
    LDA.b $02 : CLC : ADC.w #$0008
    
    LDY.b #$05 : STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_lower_half_y
        LDA.w #$00F0 : STA.b ($90), Y
    
    .on_screen_lower_half_y
    
    SEP #$20
    
    LDY.w $0E20, X
    
    LDA.w SpriteDraw_ClassToChar, Y : CLC : ADC.w $0DC0, X : TAY
    LDA.w SpriteDraw_IDtoClass, Y : LDY.b #$02 : STA.b ($90), Y
    CLC : ADC.b #$10              : LDY.b #$06 : STA.b ($90), Y
    LDA.b $05                     : LDY.b #$03 : STA.b ($90), Y
                                    LDY.b #$07 : STA.b ($90), Y
    
    JMP.w Sprite_DrawShadowRedundant
}

; ==============================================================================

; $035E4D-$035E82 DATA
Pool_SpriteHeld_Main:
{
    ; $035E4D
    .offset_x_low
    db   0,   0,   0,   0 ; Up
    db   0,   0,   0,   0 ; Down
    db -13, -10,  -5,   0 ; Left
    db  13,  10,   5,   0 ; Right

    ; $035E5D
    .offset_x_high
    db   0,   0,   0,   0 ; Up
    db   0,   0,   0,   0 ; Down
    db  -1,  -1,  -1,   0 ; Left
    db   0,   0,   0,   0 ; Right

    ; $035E6D
    .offset_z
    db  13,  14,  15,  16 ; Up
    db   0,  10,  22,  16 ; Down
    db   8,  11,  14,  16 ; Left
    db   8,  11,  14,  16 ; Right

    ; $035E7D
    .offset_y_low
    db   3,   2,   1,   3,   2,   1
}

; $035E83-$035F60 JUMP LOCATION
SpriteHeld_Main:
{
    ; Checks to see if the room we're in matches.
    LDA.w $040A : STA.w $0C9A, X
    
    LDA.l $7FFA1C, X : CMP.b #$03 : BEQ .fully_lifted
        LDA.w $0DF0, X : BNE .delay_lift_state_transition
            LDA.b #$04
            
            LDY.w $0DB0, X : CPY.b #$06 : BNE .not_large
                LDA.b #$08
            
            .not_large
            
            STA.w $0DF0, X
            
            LDA.l $7FFA1C, X : INC : STA.l $7FFA1C, X
        
        .delay_lift_state_transition
        
        BRA .x_wobble_logic
    
    .fully_lifted
    
    ; Unset the "draw shadow" flag for items we're holding.
    LDA.w $0E60, X : AND.b #$EF : STA.w $0E60, X
    
    .x_wobble_logic
    
    ; NOTE: Seems to be a wobble induced by the currently considered
    ; unused feature where a sprite can 'wake up' and leap out of the
    ; player's hands if $0F10, X is set to a nonzero value. See the tcrf
    ; note below.
    STZ.b $00
    
    ; OPTIMIZE: Use of the bit instruction and not decrementing, plus
    ; changing the order the branches are presented in would save
    ; a byte of space and a cycle or two of execution.
    LDA.w $0F10, X : DEC : CMP.b #$3F : BCS .dont_x_wobble
    AND.b #$02                        : BEQ .dont_x_wobble
        INC.b $00
    
    .dont_x_wobble
    
    LDA.b $2F : ASL : CLC : ADC.l $7FFA1C, X : TAY
    LDA.b $22 : CLC : ADC.w Pool_SpriteHeld_Main_offset_x_low, Y : PHP
                      ADC.b $00                                  : STA.w $0D10, X

    LDA.b $23 : ADC.b #$00 : PLP : ADC.w Pool_SpriteHeld_Main_offset_x_high, Y : STA.w $0D30, X
    
    LDA.w Pool_SpriteHeld_Main_offset_z, Y : STA.w $0F70, X
    
    LDY.b $2E : CPY.b #$06 : BCC .not_last_animation_step
        LDY.b #$00
    
    .not_last_animation_step
    
    LDA.b $24 : CLC : ADC.b #$01                                 : PHP
                CLC : ADC.w Pool_SpriteHeld_Main_offset_y_low, Y : STA.b $00

    LDA.b $25 : ADC.b #$00 : PLP : ADC.b #$00 : STA.b $0E
    
    LDA.b $20 : SEC : SBC.b $00  : PHP : CLC : ADC.b #$08 : STA.w $0D00, X
    LDA.b $21 :       ADC.b #$00 : PLP :       SBC.b $0E  : STA.w $0D20, X
    
    LDA.b $EE : AND.b #$01 : STA.w $0F20, X
    
    JSR.w SpriteHeld_ThrowQuery
    JSR.w Sprite_Get_16_bit_Coords
    
    LDA.l $7FFA2C, X : CMP.b #$0B : BEQ .frozen_sprite
        ; TODO: Presumably.... just does the drawing of the sprite? Find out
        ; what implications this has.
        JSR.w SpriteActive_Main
        
        LDA.w $0F10, X : DEC : BNE .dont_leap_from_player_grip
            ; UNUSED: The code bracketed by the above branch label.
            ; TODO: Upon inspection, it would be interesting to know of any time
            ; this code is actually *executed* in the game. It doesn't match
            ; anything in my experience. It's like the player has picked up a
            ; stunned enemy (\tcrf(unconfirmed) maybe?) and it eventually wakes
            ; up and leaps out of the player's hands.
            LDA.b #$09 : STA.w $0DD0, X
            
            STZ.w $0DA0, X
            
            LDA.b #$60 : STA.w $0F10, X
            
            LDA.b #$20 : STA.w $0F80, X
            
            LDA.w $0E60, X : ORA.b #$10 : STA.w $0E60, X
            
            LDA.b #$02 : STA.w $0309
        
        .dont_leap_from_player_grip
        
        ; $035F5D ALTERNATE ENTRY POINT
        .easy_out
        
        RTS
    
    .frozen_sprite
    
    JMP.w SpriteModule_Frozen
}

; ==============================================================================

; $035F61-$035F6C DATA
Pool_SpriteHeld_ThrowQuery:
{
    ; $035F61
    .x_speeds
    db 0, 0, -62, 63
    
    ; $035F65
    .y_speeds
    db -62, 63, 0, 0
    
    ; $035F69
    .z_speeds
    db 4, 4, 4, 4
}

; $035F6D-$035FF1 LOCAL JUMP LOCATION
SpriteHeld_ThrowQuery:
{
    ; In text mode, so do nothing...
    LDA.w $0010 : CMP.b #$0E : BEQ SpriteHeld_Main_easy_out
        LDA.b $5B : CMP.b #$02 : BEQ .coerced_throw
            LDA.b $4D : AND.b #$01
            
            LDY.w $037B : BNE .player_ignores_sprite_collisions
                ; Being hit causes the player to release a held sprite.
                ORA.w $0046
            
            .player_ignores_sprite_collisions
            
            ORA.w $0345 : ORA.w $02E0 : ORA.w $02DA : BNE .coerced_throw
                LDA.l $7FFA1C, X : CMP.b #$03 : BNE .dont_throw
                    LDA.b $F4 : ORA.b $F6 : BPL .dont_throw
                        ; Erase these inputs as they've been used up.
                        ; OPTIMIZE: Why not just use TRB here with 0x80 mask?
                        ASL.b $F6 : LSR.b $F6
        
        .coerced_throw
        
        LDA.b #$13
        JSL.l Sound_SetSfx3PanLong
        
        LDA.b #$02 : STA.w $0309
        
        ; This code gets called when some object flies out of Link's hand
        ; when he's falling into a pit.
        LDA.l $7FFA2C, X : STA.w $0DD0, X
        
        STZ.w $0F80, X
        
        LDA.b #$00 : STA.l $7FFA1C, X
        
        PHX
        
        LDA.w $0E20, X : TAX
        LDA.l SpriteData_OAMProp, X : PLX : AND.b #$10 : STA.b $00
        LDA.w $0E60, X : AND.b #$EF : ORA.b $00 : STA.w $0E60, X
        
        LDA.b $2F : LSR : TAY
        LDA.w .x_speeds, Y : STA.w $0D50, X
        LDA.w .y_speeds, Y : STA.w $0D40, X
        LDA.w .z_speeds, Y : STA.w $0F80, X
        
        LDA.b #$00 : STA.w $0F10, X
        
        .dont_throw
        
        RTS
}

; ==============================================================================

; $035FF2-$035FF9 LONG JUMP LOCATION
ThrownSprite_TileAndPeerInteractionLong:
{
    PHB : PHK : PLB
    
    JSR.w ThrownSprite_TileAndPeerInteraction
    
    PLB
    
    RTL
}

; ==============================================================================

; TODO: Come back to these function. IDK if I like the way they are organized.
; $035FFA-$036029 JUMP LOCATION
SpriteStunned_Main:
{
    JSR.w HandleFreezeAndStunTimer
    JSR.w Sprite_CheckIfActive_permissive
    
    LDA.w $0EA0, X : BEQ .not_recoiling
        BPL .recoil_timer_ticking
            STZ.w $0EA0, X
        
        .recoil_timer_ticking
        
        JSR.w Sprite_Zero_XY_Velocity
    
    .not_recoiling
    
    ; Even though the sprite is stunned, there is still a 32 frame delay
    ; before it can be damaged.
    LDA.w $0DF0, X : CMP.b #$20 : BCS .delay_vulnerability
        JSR.w Sprite_CheckDamageFromPlayer
    
    .delay_vulnerability
    
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_Move
    
    LDA.w $0E90, X : BNE ThrownSprite_skip_tile_collision_logic
        JSR.w Sprite_CheckTileCollision
        
        LDA.w $0DD0, X : BEQ Sprite_ChangeOAMAllotmentTo4_exit
            ; Bleeds into the next function.
}

; $03602A-$036040 JUMP LOCATION
ThrownSprite_TileAndPeerInteraction:
{
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
        JSR.w Sprite_ApplyRicochet
                
        LDA.w $0DD0, X : CMP.b #$0B : BNE .not_frozen
            ; Play clink sound because frozen sprite hit a wall.
            LDA.b #$05
            JSL.l Sound_SetSfx2PanLong

        .not_frozen
    .no_tile_collision

    ; Bleeds into the next function.
}

; $036041-$036094 JUMP LOCATION
ThrownSprite_PeerInteraction:
{
    ; Check collision against boundary of the area we're in? (not solid
    ; tiles, the actual border of the area / room).
    LDY.b #$68
    JSR.w Sprite_CheckTileProperty
    
    PHX
    
    LDA.w $0E20, X : TAX
    LDA.l SpriteData_OAMProp, X : PLX : AND.b #$10 : BEQ .BRANCH_ZETA
        LDA.w $0E60, X : ORA.b #$10 : STA.w $0E60, X
        
        LDA.w $0FA5 : CMP.b #$20 : BNE .BRANCH_ZETA
            ; Just unsets draw shadow flag (no reason to when over a pit).
            JSR.w Sprite_DisableShadowFlag
    
    .BRANCH_ZETA
    
    JSR.w Sprite_MoveAltitude
    
    ; Applies gravity to the sprite
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : DEC : CMP.b #$F0 : BCS .BRANCH_THETA
        JMP.w ThrownSprite_PeerInteraction_plop_in_water_check_for_freeze
    
    .BRANCH_THETA
    
    STZ.w $0F70, X
    
    LDA.w $0E20, X : CMP.b #$E8 : BNE .not_fake_master_sword
        LDA.w $0F80, X : CMP.b #$E8 : BPL .not_fake_master_sword
            ; Fake master sword has a special death animation where it sort
            ; of... poofs.
            LDA.b #$06 : STA.w $0DD0, X
            
            LDA.b #$08 : STA.w $0DF0, X

            ; Bleeds into the next function.
}

; $036095-$03609A JUMP LOCATION
Sprite_ChangeOAMAllotmentTo4:
{
    LDA.b #$03 : STA.w $0E40, X

    ; $03609A ALTERNATE ENTRY POINT
    .exit

    RTS
}

; $03609B-$0360AA JUMP LOCATION
ThrownSprite_PeerInteraction_not_fake_master_sword:
{
    ; Only applies to throwable scenery.
    JSR.w ThrowableScenery_TransmuteIfValid

    LDA.w $0FA5 : CMP.b #$20 : BNE ThrownSprite_PeerInteraction_not_pit_or_too_high
        LDA.w $0B6B, X : LSR : BCS ThrownSprite_PeerInteraction_not_pit_or_too_high
            ; Bleeds into the next function.
}
    
; $0360AB-$0360BE JUMP LOCATION
Sprite_SetToFalling:
{
    ; TODO: So... 0x01 is for outdoors, and 0x05 falling state is for
    ; indoors? Double and triple check this as it alters the necessary
    ; naming scheme.
    ; Set it so the object is falling into a pit.
    LDA.b #$01 : STA.w $0DD0, X
    LDA.b #$1F : STA.w $0DF0, X
    
    STZ.w $012E
    
    LDA.b #$20
    JSL.l Sound_SetSfx2PanLong
    
    RTS
}

; $0360BF-$0360F5 JUMP LOCATION
ThrownSprite_PeerInteraction_not_pit_or_too_high:
{
    CMP.b #$09 : BNE .not_shallow_water
        LDA.w $0F80, X
        STZ.w $0F80, X
        CMP.b #$F0 : BPL ThrownSprite_PeerInteraction_plop_in_water_continue
            ; TODO: Document which sprite is being spawned here.
            LDA.b #$EC
            JSL.l Sprite_SpawnDynamically : BMI ThrownSprite_PeerInteraction_plop_in_water_continue
                JSL.l Sprite_SetSpawnedCoords
                
                PHX
                
                TYX
                JSR.w ThrownSprite_PeerInteraction_plop_in_water
                
                PLX
                
                BRA ThrownSprite_PeerInteraction_plop_in_water_continue
    
    .not_shallow_water
    
    CMP.b #$08 : BNE ThrownSprite_PeerInteraction_plop_in_water_continue
        LDA.w $0E20, X : CMP.b #$D2 : BEQ .is_flopping_fish
            JSL.l GetRandomInt : LSR : BCC .anospawn_leaping_fish
        
        .is_flopping_fish
        
        JSR.w Fish_SpawnLeapingFish
        
        .anospawn_leaping_fish

        ; Bleeds into the next function.
}
    
; $0360F6-$036163 JUMP LOCATION
ThrownSprite_PeerInteraction_plop_in_water:
{
    JSL.l Sound_SetSfxPan : ORA.b #$28 : STA.w $012E
    
    LDA.b #$03 : STA.w $0DD0, X
    
    LDA.b #$0F : STA.w $0DF0, X
    
    STZ.w $0D80, X
    
    JSL.l GetRandomInt : AND.b #$01
    JMP.w Sprite_ChangeOAMAllotmentTo4

    ; $036115 ALTERNATE ENTRY POINT
    .continue

    LDA.w $0F80, X : BPL .BRANCH_OMICRON
        EOR.b #$FF : INC : LSR : CMP.b #$09 : BCS .BRANCH_PI
            LDA.b #$00
        
        .BRANCH_PI
        
        STA.w $0F80, X
    
    .BRANCH_OMICRON
    
    ; Is this arithmetic shift right? Clever, if so.
    LDA.w $0D50, X : ASL : ROR.w $0D50, X
    
    LDA.w $0D50, X : CMP.b #$FF : BNE .BRANCH_RHO
        STZ.w $0D50, X
    
    .BRANCH_RHO
    
    LDA.w $0D40, X : ASL : ROR.w $0D40, X
    
    LDA.w $0D40, X : CMP.b #$FF : BNE .check_for_freeze
        STZ.w $0D40, X

    ; $036149 ALTERNATE ENTRY POINT
    .check_for_freeze
    
    LDA.w $0DD0, X : CMP.b #$0B : BNE .BRANCH_TAU
        LDA.l $7FFA3C, X : BEQ .BRANCH_UPSILON
    
    .BRANCH_TAU
    
    JSR.w Sprite_CheckIfLifted
    
    LDA.w $0E20, X : CMP.b #$4A : BEQ .BRANCH_UPSILON
        JSR.w ThrownSprite_CheckDamageToPeers
    
    .BRANCH_UPSILON
    
    RTS
}

; ==============================================================================

; $036164-$036171 LOCAL JUMP LOCATION
ThrowableScenery_InteractWithSpritesAndTiles:
{
    JSR.w Sprite_Move
    
    LDA.w $0E90, X : BNE .skip_tile_collision
        JSR.w Sprite_CheckTileCollision
    
    .skip_tile_collision
    
    JMP.w ThrownSprite_TileAndPeerInteraction
}

; ==============================================================================

; This routine is intended to be used by 'throwable sprites' to damage
; other sprites.
; $036172-$0361B1 LOCAL JUMP LOCATION
ThrownSprite_CheckDamageToPeers:
{
    LDA.w $0F10, X : BNE .delay_damaging_others
        LDA.w $0D50, X : ORA.w $0D40, X : BEQ .no_momentum
            LDY.b #$0F
            
            .next_sprite_slot
            
                PHY
                
                CPY.w $0FA0 : BEQ .cant_damage_self
                    LDA.w $0E20, X : CMP.b #$D2 : BEQ .cant_damage
                        LDA.w $0DD0, Y : CMP.b #$09 : BCC .cant_damage
                            TYA : EOR.b $1A : AND.b #$03
                            ORA.w $0BA0, Y : ORA.w $0EF0, Y : BNE .cant_damage
                                LDA.w $0F20, X : CMP.w $0F20, Y : BNE .cant_damage
                                    JSR.w ThrownSprite_CheckDamageToSinglePeer
                    
                    .cant_damage
                .cant_damage_self
            PLY : DEY : BPL .next_sprite_slot
        
        .no_momentum
    .delay_damaging_others

    .exit
    
    RTS
}

; ==============================================================================

; $0361B2-$036228 LOCAL JUMP LOCATION
ThrownSprite_CheckDamageToSinglePeer:
{
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $08
    
    LDA.b #$0F : STA.b $02
    
    LDA.w $0D00, X : SEC : SBC.w $0F70, X : PHP : CLC : ADC.b #$08 : STA.b $01
    LDA.w $0D20, X :       ADC.b #$00     : PLP :       SBC.b #$00 : STA.b $09
    
    LDA.b #$08 : STA.b $03
    
    PHX
    
    TYX
    
    JSR.w Sprite_SetupHitBox
    
    PLX
    
    JSR.w Utility_CheckIfHitBoxesOverlap : BCC ThrownSprite_CheckDamageToPeers_exit
        LDA.w $0E20, Y : CMP.b #$3F : BNE .notTutorialSoldier
            JSL.l Sprite_PlaceRupulseSpark
            
            BRA Sprite_ApplyRicochet
        
        .notTutorialSoldier
        
        LDA.b #$03 : PHA
        
        LDA.w $0E20, X : CMP.b #$EC : BNE .BRANCH_GAMMA
            LDA.w $0DB0, X : CMP.b #$02 : BNE .BRANCH_GAMMA
                LDA.b $1B : BNE .BRANCH_GAMMA
                    PLA
                    
                    LDA.b #$01 : PHA
        
        .BRANCH_GAMMA
        
        PLA : PHX
        
        TYX
        
        PHY
        
        JSL.l Ancilla_CheckSpriteDamage_preset_class
        
        PLY : PLX
        
        LDA.w $0D50, X : ASL : STA.w $0F40, Y
        LDA.w $0D40, X : ASL : STA.w $0F30, Y
        
        LDA.b #$10 : STA.w $0F10, X

        ; Bleeds into the next function.
}

; TODO: Check for remaining references for this:
ThrownSprite_CheckDamageToSinglePeer_BRANCH_BETA:

; $036229-$03622E LOCAL JUMP LOCATION
Sprite_ApplyRicochet:
{
    JSR.w Sprite_Invert_XY_Speeds
    JSR.w Sprite_Halve_XY_Speeds
        
    ; Bleeds into the next function.
}

; $03622F-$036238 LOCAL JUMP LOCATION
ThrowableScenery_TransmuteIfValid:
{       
    ; Not a bush...
    LDA.w $0E20, X : CMP.b #$EC : BNE Sprite_CustomTimedScheduleForBreakage_exit
        STZ.w $0FAC

        ; Bleeds into the next function.
}
        
; $036239-$036259 LOCAL JUMP LOCATION
ThrowableScenery_TransmuteToDebris:
{
    LDA.w $0DC0, X : BEQ .BRANCH_EPSILON
        
        STA.w $0B9C
        
        JSR.w Sprite_SpawnSecret
        
        STZ.w $0B9C
        
    .BRANCH_EPSILON
        
    LDY.w $0DB0, X
        
    LDA.b $1B : BEQ .BRANCH_ZETA
        LDY.b #$00
        
    .BRANCH_ZETA
        
    STZ.w $012E
        
    LDA.w ThrownItemSFX, Y : JSL.l Sound_SetSfx2PanLong

    ; Bleeds into the next function.
}

; $03625A-$03625B LOCAL JUMP LOCATION
Sprite_ScheduleForBreakage:
{
    LDA.b #$1F

    ; Bleeds into the next function.
}
        
; $03625C-$03626D LOCAL JUMP LOCATION
Sprite_CustomTimedScheduleForBreakage:
{
    STA.w $0DF0, Y
        
    ; Break this pot...
    LDA.b #$06 : STA.w $0DD0, X
        
    LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
        
    .exit
        
    RTS
}

; ==============================================================================

; This sequence does an arithmetic (not logical!) shift right on
; the x and y speeds, which effectively reduces them by half.
; $03626E-$03627C LOCAL JUMP LOCATION
Sprite_Halve_XY_Speeds:
{
    ; TODO: Why are we shifting left? this doesn't seem to do anything because we
    ; just load the next one right after.
    LDA.w $0D50, X : ASL
    ROR.w $0D50, X
    
    LDA.w $0D40, X : ASL
    ROR.w $0D40, X
    
    RTS
}

; ==============================================================================

; $03627D-$036285 DATA
ThrownItemSFX:
{
    db $1F ; SFX2.1F
    db $1F ; SFX2.1F
    db $1E ; SFX2.1E
    db $1E ; SFX2.1E
    db $1E ; SFX2.1E
    db $1F ; SFX2.1F
    db $1F ; SFX2.1F
    db $1F ; SFX2.1F
    db $1F ; SFX2.1F
}

; ==============================================================================

; I think this is the routine called to spawn the fish that jump out
; of the water after a rock or similar is thrown into the water.
; $036286-$0362A6 LOCAL JUMP LOCATION
Fish_SpawnLeapingFish:
{
    LDA.b #$D2 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$02 : STA.w $0D80, Y
        
        LDA.b #$30 : STA.w $0DF0, Y
        
        LDA.w $0E20, X : CMP.b #$D2 : BNE .not_spawned_from_other_fish
            ; TODO: Give a 20 rupee reward? Is that what this controls?
            ; Only make a grateful fish leap up if it was one rescued from
            ; water, not a fish that was perturbed by something else being
            ; thrown into the water, like a skull rock / bush / frozen sprite.
            STA.w $0D90, Y
        
        .not_spawned_from_other_fish
    .spawn_failed
    
    RTS
}

; $0362A7-$0362A5 DATA
Pool_SpriteModule_Frozen:
{
    ; $0362A7
    .sparkle_offset_low
    db  -4,  12,   3,   8

    ; $0362AB
    .sparkle_offset_high
    db  -1,   0,   0,   0

    ; $0362AF
    .sparkle_mask
    db $7F, $0F, $03, $01, $00, $00, $00
}

; $0362B6-$0362B9 LOCAL JUMP LOCATION
HandleFreezeAndStunTimer:
{
    JSL.l Sprite_DrawRippleIfInWater

    ; Bleeds into the next function.
}

; $0362BA-$036342 LOCAL JUMP LOCATION
SpriteModule_Frozen:
{
    JSR.w SpriteActive_Main
    
    LDA.l $7FFA3C, X : BEQ .BRANCH_ALPHA
        LDA.w $0DF0, X : CMP.b #$20 : BCS .BRANCH_BETA
            ; NOTE: Think this sets a blue palette?
            LDA.w $0F50, X : AND.b #$F1 : ORA.b #$04 : STA.w $0F50, X
        
        .BRANCH_BETA
        
        LDA.w $0DF0, X : LSR #4 : TAY
        
        TXA : ASL #4 : EOR.b $1A : ORA.b $11 : AND.w Pool_SpriteModule_Frozen_sparkle_mask, Y : BNE .BRANCH_GAMMA
            JSL.l GetRandomInt : AND.b #$03 : TAY
            LDA.w Pool_SpriteModule_Frozen_sparkle_offset_low, Y : STA.b $00
            LDA.w Pool_SpriteModule_Frozen_sparkle_offset_high, Y : STA.b $01
            
            JSL.l GetRandomInt : AND.b #$03 : TAY
            LDA.w Pool_SpriteModule_Frozen_sparkle_offset_low, Y : STA.b $02
            LDA.w Pool_SpriteModule_Frozen_sparkle_offset_high, Y : STA.b $03
            
            JSL.l Sprite_SpawnSimpleSparkleGarnish
        
        .BRANCH_GAMMA
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.b $1A : AND.b #$01 : ORA.b $11 : ORA.w $0FC1 : BNE .BRANCH_DELTA
        LDA.w $0B58, X : BEQ .BRANCH_EPSILON
            DEC.w $0B58, X : CMP.b #$38 : BCS .BRANCH_DELTA
                AND.b #$01 : TAY
                LDA.w .wiggle_x_speeds, Y : STA.w $0D50, X
                
                JSR.w Sprite_MoveHoriz
    
    .BRANCH_DELTA
    
    RTS
    
    .BRANCH_EPSILON
    
    LDA.b #$09 : STA.w $0DD0, X
    
    STZ.w $0F40, X
    STZ.w $0F30, X
    
    RTS
    
    .wiggle_x_speeds
    db 8, -8
}

; ==============================================================================

; $036343-$036392 DATA
Pool_SpritePoof_Main:
{
    .x_offsets
    db -6,  10,   1,  13
    db -6,  10,   1,  13
    db -7,   4,  -5,   6
    db -1,   1,  -2,   0
    
    .y_offsets
    db -6,  -4,  10,   9
    db -6,  -4,  10,   9
    db -8, -10,   4,   3
    db -1,  -2,   0,   1
    
    .chr
    db $9B, $9B, $9B, $9B
    db $B3, $B3, $B3, $B3
    db $8A, $8A, $8A, $8A
    db $8A, $8A, $8A, $8A
    
    .properties
    db $24, $A4, $24, $A4
    db $E4, $64, $A4, $24
    db $24, $E4, $E4, $E4
    db $24, $E4, $E4, $E4
    
    .OAM_sizes
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $02, $02, $02, $02
    db $02, $02, $02, $02
}

; ==============================================================================

; Sprite state 0x02
; $036393-$036415 JUMP LOCATION
SpritePoof_Main:
{
    ; Check this timer.
    LDA.w $0DF0, X : BNE .just_draw
        ; See if the enemy is a buzzblob.
        LDA.w $0E20, X : CMP.b #$0D : BNE .not_trans_buzzblob
            ; Thinking this is a transformed buzz blob exception.
            LDY.w $0EB0, X : BEQ .not_trans_buzzblob
                LDY.w $0D10, X : PHY
                LDY.w $0D30, X : PHY
                
                JSR.w Sprite_DoTheDeath_PrepareEnemyDrop
                
                PLA : STA.w $0D30, X
                PLA : STA.w $0D10, X
                
                STZ.w $0F80, X
                STZ.w $0BA0, X
                
                RTS
            
        .not_trans_buzzblob
        
        LDA.w $0CBA, X : BNE .has_specific_drop_item
            LDY.b #$02
            JMP.w Sprite_DoTheDeath_ForcePrizeDrop
        
        .has_specific_drop_item
        
        JMP.w Sprite_DoTheDeath
    
    .just_draw
    
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0DF0, X : LSR : AND.b #$FC : STA.b $00
    
    PHX
    
    LDX.b #$03
    
    .next_OAM_entry
    
        PHX
        
        TXA : CLC : ADC.b $00 : TAX
        LDA.w $0FA8 : CLC : ADC.w .x_offsets, X        : STA.b ($90), Y
        LDA.w $0FA9 : CLC : ADC.w .y_offsets, X  : INY : STA.b ($90), Y
        LDA.w .chr, X                            : INY : STA.b ($90), Y
        LDA.w .properties, X                     : INY : STA.b ($90), Y
        
        PHY
        
        TYA : LSR : LSR : TAY
        LDA.w .OAM_sizes, X : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b #$03
    
    JMP.w Sprite_CorrectOamEntries
}

; ==============================================================================

; $036416-$036419 LONG JUMP LOCATION
Sprite_PrepOamCoordLong:
{
    JSR.w Sprite_PrepOamCoordSafeWrapper
    
    RTL
}

; ==============================================================================

; This wrapper is considered 'Safe' because it negates the caller termination
; property of 'Sprite_PrepOamCoord' by using this routine as a sacrificial
; intermediate. Since this subroutine only does one useful task, exiting from it
; early will not interrupt the caller of this subroutine, which can potentially
; happen if 'Sprite_PrepOamCoord' is called directly.
; $03641A-$03641D LOCAL JUMP LOCATION
Sprite_PrepOamCoordSafeWrapper:
{
    JSR.w Sprite_PrepOamCoord
    
    RTS
}

; ==============================================================================

; $03641E-$036495 LOCAL JUMP LOCATION
Sprite_PrepOamCoord:
{
    ; Enable the sprite to move.
    STZ.w $0F00, X
    
    REP #$20
    
    ; X coordinate for the sprite.
    LDA.w $0FD8 : SEC : SBC.b $E2 : STA.b $00
    
    ; A = (Sprite's X coord - far left of screen X coord) + 0x40
    ; Y coordinate is at most 255, so make 8 bit.
    ; If A >= 0x170 don't display at all.
    CLC : ADC.w #$0040 : CMP.w #$0170 : SEP #$20 : BCS .x_out_of_bounds
        ; How high off the ground is the object?
        LDA.w $0F70, X : STA.b $04
        STZ.b $05
        
        REP #$20
        
        ; Sprite's Y coord. Subtract the Y coordinate of the camera.
        LDA.w $0FDA : SEC : SBC.b $E8 : PHA
        
        ; Offset by how far the object is off the ground.
        SEC : SBC.b $04 : STA.b $02
        
        ; Grab the non height adjusted value.
        ; Add in 0x40 and see if it's >= 0x0170.
        ; If sufficiently off screen don't render at all.
        PLA : CLC : ADC.w #$0040 : CMP.w #$0170 : SEP #$20 : BCC .y_inbounds
            ; Not sure what $0F60, X does yet... (room relevance?).
            LDA.w $0F60, X : AND.b #$20 : BEQ .immobilize_sprite
        
        .y_inbounds
        
        ; Signals the sprite is fine...?
        CLC
        
        .finish_up
        
        ; What palette is the sprite using?
        ; Xor it with sprite priority.
        LDA.w $0F50, X : EOR.w $0B89, X : STA.b $05
                                          STZ.b $04
        
        LDA.b $00 : STA.w $0FA8
        LDA.b $02 : STA.w $0FA9
        
        LDY.b #$00
        
        RTS
    
    .x_out_of_bounds
    
    REP #$20
    
    LDA.w $0FDA : SEC : SBC.b $E8 : SEC : SBC.b $04 : STA.b $02
    
    SEP #$20
    
    .immobilize_sprite
    
    ; Make the sprite immobile.
    INC.w $0F00, X
    
    LDA.w $0CAA, X : BMI .dont_kill
        JSL.l Sprite_SelfTerminate
    
    .dont_kill
    
    PLA : PLA
    
    SEC
    
    BRA .finish_up
}

; ==============================================================================

; $036496-$0364A0 LONG JUMP LOCATION
Sprite_CheckTileCollisionLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckTileCollision
    
    PLB
    
    LDA.w $0E70, X
    
    RTL
}

; ==============================================================================

; $0364A1-$0364A7 BRANCH LOCATION
Sprite_CheckTileCollision_restore_layer_property:
{
    LDA.w $0FB6 : STA.w $0F20, X
    
    RTS
}

; $0364A7-$0364AB BRANCH LOCATION
Sprite_CheckTileCollision_restrict_to_same_layer:
{
    JMP.w Sprite_CheckTileCollisionSingleLayer

    ; Bleeds into the next function.
}

; $0364AB-$0364DA BRANCH LOCATION
Sprite_CheckTileCollision:
{
    STZ.w $0E70, X
    
    LDA.w $0F60, X : BMI .restrict_to_same_layer
        LDA.w $046C : BEQ .restrict_to_same_layer
            LDA.w $0F20, X : STA.w $0FB6
            
            LDA.b #$01 : STA.w $0F20, X
            
            JSR.w Sprite_CheckTileCollisionSingleLayer
            
            LDA.w $046C : CMP.b #$04 : BEQ .restore_layer_property
                STZ.w $0F20, X
                
                JSR.w Sprite_CheckTileCollisionSingleLayer
                
                LDA.w $0FA5 : STA.l $7FFABC, X
                
                RTS
}

; ==============================================================================

; $0364DB-$0365B7 LOCAL JUMP LOCATION
Sprite_CheckTileCollisionSingleLayer:
{
    LDA.w $0E40, X : AND.b #$20 : BEQ .BRANCH_ALPHA
        LDY.b #$6A
        
        JSR.w Sprite_CheckTileProperty : BCC .BRANCH_BETA
            INC.w $0E70, X
        
        .BRANCH_BETA
        
        RTS
        
    .BRANCH_ALPHA
    
    LDA.w $0F60, X : BMI .BRANCH_GAMMA
        LDA.w $046C : BNE .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    LDY.b #$00
    
    LDA.w $0D40, X : BEQ .BRANCH_EPSILON
        BMI .BRANCH_ZETA
            INY
        
        .BRANCH_ZETA
        
        JSR.w Sprite_CheckForTileInDirection_vertical
    
    .BRANCH_EPSILON
    
    LDY.b #$02
    
    LDA.w $0D50, X : BEQ .BRANCH_THETA 
        BMI .BRANCH_IOTA
            INY
        
        .BRANCH_IOTA
        
        JSR.w Sprite_CheckForTileInDirection_horizontal
    
    .BRANCH_THETA
    
    BRA .BRANCH_KAPPA
    
    .BRANCH_DELTA
    
    LDY.b #$01
    
    .BRANCH_LAMBDA
    
        JSR.w Sprite_CheckForTileInDirection_vertical
    DEY : BPL .BRANCH_LAMBDA
    
    LDY.b #$03
    
    .BRANCH_MU
    
        JSR.w Sprite_CheckForTileInDirection_horizontal
    DEY : CPY.b #$01 : BNE .BRANCH_MU
    
    .BRANCH_KAPPA
    
    LDA.w $0BE0, X : BMI .BRANCH_NU
        LDA.w $0F70, X : BEQ .BRANCH_XI
    
    .BRANCH_NU
    
    RTS
    
    .BRANCH_XI
    
    LDY.b #$68
    JSR.w Sprite_CheckTileProperty
    
    ; Get the tile type:
    LDA.w $0FA5 : STA.l $7FF9C2, X

    ; TODO: Top of water staircase?
    CMP.b #$1C : BNE .BRANCH_OMICRON
        LDY.w $0FB3 : BEQ .BRANCH_OMICRON
            ; Is the enemy frozen?
            LDY.w $0DD0, X : CPY.b #$0B : BNE .notFrozen
                ; Nope.
                LDA.b #$01 : STA.w $0F20, X
                
                RTS

            .notFrozen
    .BRANCH_OMICRON
    
    ; Are we interacting with a pit?
    CMP.b #$20 : BNE .notAPit
        ; BUG: OPTIMIZE: This is a goofy branch, if branch, you will branch to a
        ; place where the game normally would expect the tile type to still be in
        ; A however that is no longer the case. So really this should just go
        ; straight to an RTS instead since the conditions this leads to shouldn't
        ; ever be met anyway. The result is technically the same but it is odd.
        LDA.w $0B6B, X : AND.b #$01 : BEQ .BRANCH_RHO
            LDA.b $1B : BNE .notIndoors
                JMP.w Sprite_SetToFalling
            
            .notIndoors
            
            LDA.b #$05 : STA.w $0DD0, X
            
            LDA.b #$5F
            
            ; Is it a helmasaur?
            LDY.w $0E20, X : CPY.b #$13 : BEQ .isHelmasaur
                CPY.b #$26 : BNE .notHardHatBeetle
            
            .isHelmasaur
            
            LSR.w $0F50, X : ASL.w $0F50, X
            
            LDA.b #$3F
            
            .notHardHatBeetle
            
            STA.w $0DF0, X
            
            RTS
    
    .notAPit
    
    ; Are we interacting with Mothula's room moving floor? 
    CMP.b #$0C : BNE .not_mothula_moving_floor
        LDA.l $7FFABC, X : CMP.b #$1C : BNE .exit
            JSR.w SpriteFall_AdjustPosition
            
            LDA.w $0E70, X : ORA.b #$20 : STA.w $0E70, X
            
            RTS
        
    .not_mothula_moving_floor
    .BRANCH_RHO
    
    ; Are we interacting with a conveyor belt?
    CMP.b #$68 : BCC .not_conveyor_belt
        CMP.b #$6C : BCS .not_conveyor_belt
            .applyConveyorMovement
            
            TAY
            JSL.l Sprite_ApplyConveyorAdjustment
            
            RTS
    
    .not_conveyor_belt
    
    ; Are we interacting with deep water?
    CMP.b #$08 : BNE .notDeepWater
        ; TODO: Check for the flowing water BG1 collision type?
        LDA.w $046C : CMP.b #$04 : BNE .noFlowingWater
            ; This indicates that flowing water makes sprites move to the left in
            ; the same way a conveyor belt would.
            LDA.b #$6A
            
            BRA .applyConveyorMovement
    
        .noFlowingWater
    .notDeepWater
    .exit
    
    RTS
}

; $0365B8-$0365ED LOCAL JUMP LOCATION
Sprite_CheckForTileInDirection_horizontal:
{
    JSR.w Sprite_CheckTileInDirection : BCC .BRANCH_ALPHA
        LDA.w Pool_Sprite_CheckForTileInDirection_direction_flag, Y
        ORA.w $0E70, X : STA.w $0E70, X
        
        LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .BRANCH_ALPHA
            LDA.w $0EA0, X : BEQ .BRANCH_BETA
                ; OPTIMIZE: If this code is reached, it's bound to be pretty
                ; slow. Mainly, it's calling the same code 3 times to do 3
                ; additions, so why not just adjust the amounts in the table by
                ; a factor of 3?
                JSR.w .add_offset
                JSR.w .add_offset
            
            .add_offset
            
            LDA.w $0D10, X
            CLC : ADC.w Pool_Sprite_CheckForTileInDirection_pushback_low, Y
            STA.w $0D10, X

            LDA.w $0D30, X
                  ADC.w Pool_Sprite_CheckForTileInDirection_pushback_high, Y
            STA.w $0D30, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0365EE-$036623 LOCAL JUMP LOCATION
Sprite_CheckForTileInDirection_vertical:
{
    JSR.w Sprite_CheckTileInDirection : BCC .return
        LDA.w Pool_Sprite_CheckForTileInDirection_direction_flag, Y
        ORA.w $0E70, X : STA.w $0E70, X
        
        LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .return
            LDA.w $0EA0, X : BEQ .add_offset
                ; OPTIMIZE: If this code is reached, it's bound to be pretty
                ; slow. Mainly, it's calling the same code 3 times to do 3
                ; additions, so why not just adjust the amounts in the table by
                ; a factor of 3?
                JSR.w .add_offset
                JSR.w .add_offset
            
            ; $036610 ALTERNATE ENTRY POINT
            .add_offset
            
            LDA.w $0D00, X
            CLC : ADC.w Pool_Sprite_CheckForTileInDirection_pushback_low, Y
            STA.w $0D00, X

            LDA.w $0D20, X
                  ADC.w Pool_Sprite_CheckForTileInDirection_pushback_high, Y
            STA.w $0D20, X
    
    .return
    
    RTS
}

; $036624-$03664A LOCAL JUMP LOCATION
SpriteFall_AdjustPosition:
{
    LDA.w $0310 : CLC : ADC.w $0D00, X : STA.w $0D00, X
    LDA.w $0311 :       ADC.w $0D20, X : STA.w $0D20, X
    LDA.w $0312 : CLC : ADC.w $0D10, X : STA.w $0D10, X
    LDA.w $0313 :       ADC.w $0D30, X : STA.w $0D30, X
    
    RTS
}

; $03664B-$036722 DATA
Pool_Sprite_CheckTileProperty:
{
    ; $03664B
    .offset_x
    dw $0008, $0008, $0002, $000E
    dw $0008, $0008, $FFFE, $000A
    dw $0008, $0008, $0001, $000E
    dw $0004, $0004, $0004, $0004
    dw $0004, $0004, $FFFE, $000A
    dw $0008, $0008, $FFE7, $0028
    dw $0008, $0008, $0002, $000E
    dw $0008, $0008, $FFF8, $0017
    dw $0008, $0008, $FFEC, $0024
    dw $0008, $0008, $FFFF, $0010
    dw $0008, $0008, $FFFF, $0010
    dw $0008, $0008, $FFF8, $0018
    dw $0008, $0008, $FFF8, $0018
    dw $0008, $0003
    
    ; $0366B7
    .offset_y
    dw $0006, $0014, $000D, $000D
    dw $0000, $0008, $0004, $0004
    dw $0001, $000E, $0008, $0008
    dw $0004, $0004, $0004, $0004
    dw $FFFE, $000A, $0004, $0004
    dw $FFE7, $0028, $0008, $0008
    dw $0003, $0010, $000A, $000A
    dw $FFF8, $0019, $0008, $0008
    dw $FFEC, $0024, $0008, $0008
    dw $FFFF, $0010, $0008, $0008
    dw $000E, $0003, $0008, $0008
    dw $FFF8, $0018, $0008, $0008
    dw $FFF8, $0020, $0008, $0008
    dw $000C, $0004
}

; ==============================================================================

; $036723-$03672E DATA
Pool_Sprite_CheckForTileInDirection:
{
    ; $036723
    .direction_flag
    db $08 ; Up
    db $04 ; Down
    db $02 ; Left
    db $01 ; Right

    ; $036727
    .pushback_low
    db   1 ; Up
    db  -1 ; Down
    db   1 ; Left
    db  -1 ; Right

    ; $03672B
    .pushback_high
    db   0 ; Up
    db  -1 ; Down
    db   0 ; Left
    db  -1 ; Right
}
    
; ==============================================================================

; $03672F-$03673B LOCAL JUMP LOCATION
Sprite_CheckTileInDirection:
{
    ; Seems that $08 is a value from 0 to 3 indicating the direction
    ; to check collision in... Pretty sure anyways.
    STY.b $08
    
    LDA.w $0B6B, X : AND.b #$F0 : LSR : LSR : ADC.b $08 : ASL : TAY

    ; Bleeds into the next function.
}
    
; $03673C-$03687A LOCAL JUMP LOCATION
Sprite_CheckTileProperty:
{
    LDA.b $1B : BEQ .outdoors
        REP #$20
        
        ; Load Y coordinate of sprite.
        LDA.w $0FDA : CLC : ADC.w #8 : AND.w #$01FF
        CLC : ADC.w Pool_Sprite_CheckTileProperty_offset_y, Y
        SEC : SBC.w #8 : STA.b $00
        CMP.w #$0200 : BCS .out_of_bounds
            ; Load X coordinate of sprite.
            LDA.w $0FD8 : ADC.w #8 : AND.w #$01FF
            CLC : ADC.w Pool_Sprite_CheckTileProperty_offset_x, Y
            
            SEC : SBC.w #8 : STA.b $02
            CMP.w #$0200
            
            BRA .check_if_inbounds
    
    .outdoors
    
    ; Overworld handling of collision (against perimeter?)
    REP #$20
    
    LDA.w $0FDA : CLC : ADC.w Pool_Sprite_CheckTileProperty_offset_y, Y : STA.b $00
    
    SEC : SBC.w $0FBE : CMP.w $0FBA : BCS .out_of_bounds
        LDA.w $0FD8
        CLC : ADC.w Pool_Sprite_CheckTileProperty_offset_x, Y : STA.b $02
        
        SEC : SBC.w $0FBC : CMP.w $0FB8
    
    .out_of_bounds
    .check_if_inbounds
    
    SEP #$20 : BCC .inbounds
        JMP.w .check_harmlessness
    
    .inbounds
    
    JSR.w Sprite_GetTileAttrLocal
    
    TAY
    
    LDA.w $0CAA, X : AND.b #$08 : BEQ .dont_use_simplified_tile_collision
        PHX
        
        TYX
        
        LDY.b $08
        
        LDA.l Sprite_SimplifiedTileAttr, X
        
        PLX
        
        CMP.b #$04 : BEQ .BRANCH_EPSILON
            CMP.b #$01 : BCC .BRANCH_ZETA
                LDA.w $0FA5 : CMP.b #$10 : BCC .not_sloped_tile
                              CMP.b #$14 : BCS .not_sloped_tile
                    JSR.w Entity_CheckSlopedTileCollision
                    JMP.w .load_tile_prop_exit
                
                .not_sloped_tile
                
                JMP.w .not_pit_tile
        
        .BRANCH_EPSILON
        
        LDY.b $1B : BNE .BRANCH_ZETA
            STA.w $0E90, X
        
        .BRANCH_ZETA
        
        JMP.w .succeed_and_exit
    
    .dont_use_simplified_tile_collision
    
    LDA.w $0BE0, X : ASL : BPL .BRANCH_IOTA
        LDA.w $0E20, X : CMP.b #$D2 : BEQ .flopping_fish
            CMP.b #$8A : BNE .not_moving_spike_block
        
        .flopping_fish
        
        CPY.b #$09 : BEQ .shallow_water_tile
            .not_moving_spike_block
            
            CMP.b #$94 : BNE .not_pirogusu
                LDA.w $0E90, X : BEQ .BRANCH_XI
                    BRA .BRANCH_IOTA
            
            .not_pirogusu
            
            CMP.b #$E3 : BEQ .BRANCH_XI
            CMP.b #$8C : BEQ .BRANCH_XI
            CMP.b #$9A : BEQ .BRANCH_XI
                CMP.b #$81 : BNE .BRANCH_IOTA
            
            .BRANCH_XI
            
            CPY.b #$08 : BEQ .deep_water_tile
                CPY.b #$09
            
        .shallow_water_tile
        
        BEQ .succeed_and_exit
            BRA .BRANCH_PI
    
    .BRANCH_IOTA
    
    PHX
    
    TYX
    LDA.l GeneralizedSpriteTileInteraction, X
    
    PLX
    
    LDY.b $08
    
    CMP.b #$00 : BEQ .succeed_and_exit
        LDA.w $0FA5 : CMP.b #$10 : BCC .BRANCH_RHO
                      CMP.b #$14 : BCS .BRANCH_RHO
            JSR.w Entity_CheckSlopedTileCollision
            
            BRA .load_tile_prop_exit
        
        .BRANCH_RHO
        
        CMP.b #$44 : BNE .not_spike_tile
            LDA.w $0EA0, X : BEQ .BRANCH_PI
                LDA.w $0CE2, X : BMI .BRANCH_UPSILON
                    LDA.b #$04
                    JSL.l Ancilla_CheckSpriteDamage_preset_class
                    
                    LDA.w $0EF0, X : BEQ .BRANCH_UPSILON
                        LDA.b #$99 : STA.w $0EF0, X
                        
                        STZ.w $0EA0, X
                
                .BRANCH_UPSILON
            
            BRA .BRANCH_PI
            
            ; $036852 ALTERNATE ENTRY POINT
            .check_harmlessness
            
            JSR.w .not_pit_tile
            
            LDA.w $0E40, X : ASL : BPL .BRANCH_PHI
                STZ.w $0DD0, X
                
                CLC
                
                RTS
            
            .BRANCH_PHI
            
            SEC
            
            RTS
        
        .not_spike_tile
        
        ; Check if the tile type is a pit:
        CMP.b #$20 : BNE .not_pit_tile
            LDA.w $0B6B, X : AND.b #$01 : BEQ .dontIgnorePits
                LDA.w $0EA0, X : BNE .succeed_and_exit

            .dontIgnorePits
        
        ; $036872 ALTERNATE ENTRY POINT
        .not_pit_tile
        
        SEC
        
        SEP #$21
        
        BRA .load_tile_prop_exit
    
    ; $036877 ALTERNATE ENTRY POINT
    .succeed_and_exit

    .deep_water_tile
    
    CLC
    
    ; $036878 ALTERNATE ENTRY POINT
    .load_tile_prop_exit
    
    LDY.b $08
    
    RTS
}

; ==============================================================================

; $03687B-$036882 LONG JUMP LOCATION
Entity_GetTileAttr:
{
    PHB : PHK : PLB
    
    JSR.w Entity_GetTileAttrLocal
    
    PLB
    
    RTL
}

; ==============================================================================

; Notes:
; $00[0x02] - Entity Y coordinate
; $02[0x03] - Entity X coordinate
; $036883-$036885 LOCAL JUMP LOCATION
Sprite_GetTileAttrLocal:
{
    LDA.w $0F20, X ; Floor selector for sprites.

    ; Bleeds into the next function.
}

; $036886-$0368D5 LOCAL JUMP LOCATION
Entity_GetTileAttrLocal:
{
    CMP.b #$01 : REP #$30 : STZ.b $05 : BCC .on_bg2
        LDA.w #$1000 : STA.b $05
    
    .on_bg2
    
    LDA.b $1B : AND.w #$00FF : BEQ .outdoors
        ; Horizontal Position
        LDA.b $02 : AND.w #$01FF : LSR #3 : STA.b $04
        
        ; Vertical position
        LDA.b $00 : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $05
        
        PHX
        
        ; Retrieve tile type.
        TAX
        LDA.l $7F2000, X
        
        PLX
        
        SEP #$30
        
        STA.w $0FA5
        
        RTS
    
    .outdoors
    
    LDA.b $02 : LSR #3 : STA.b $02
    
    SEP #$10
    
    PHX : PHY
    
    JSL.l Overworld_GetTileAttrAtLocation
    
    SEP #$30
    
    STA.w $0FA5
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $0368D6-$0368F5 DATA
Entity_CheckSlopedTileCollision_subtile_boundaries:
{
    db 7, 6, 5, 4, 3, 2, 1, 0
    db 0, 1, 2, 3, 4, 5, 6, 7
    db 0, 1, 2, 3, 4, 5, 6, 7
    db 7, 6, 5, 4, 3, 2, 1, 0
}

; $0368F6-$0368FD LONG JUMP LOCATION
Entity_CheckSlopedTileCollisionLong:
{
    PHB : PHK : PLB
    
    JSR.w Entity_CheckSlopedTileCollision
    
    PLB
    
    RTL
}

; TODO: go into more detail figuring out how this works now that we have
; a foothold.
; NOTE: Has to do with tile detection on tiles that have a slope to them
; (digonally).
; $0368FE-$03692B LOCAL JUMP LOCATION
Entity_CheckSlopedTileCollision:
{
    LDA.b $00 : AND.b #$07 : STA.b $04 ; $04 = ($00 & 0x07)
    LDA.b $02 : AND.b #$07 : STA.b $05 ; $05 = ($02 & 0x07)
    
    ; Tile type that was detected in the previous routine ($36883 most likely)
    ; $06 = ($0FA5 - 0x10).
    ; BUG: Maybe a bug.... what tile attributes are supposed to be used
    ; with this routine? Inspection suggests 0x18 through 0x1b, but this
    ; routine seems designed for 0x10 through 0x13. Hardly comforting...
    LDA.w $0FA5 : SEC : SBC.b #$10 : STA.b $06
    
    ; Y = ($06 << 3) + $05.
    ASL #3 : CLC : ADC.b $05 : TAY
    
    ; If original attribute was between 0x10 and 0x12.
    LDA.b $06 : CMP.b #$02 : BCC .alpha
        LDA.b $04 : CMP .subtile_boundaries, Y
        
        BRA .beta
    
    .alpha
    
    LDA.w .subtile_boundaries, Y : CMP.b $04
    
    .beta
    
    RTS
}

; ==============================================================================

; OPTIMIZE: Has been identified as time consuming (relative to what it does in
; real terms). Similar functions in other banks will have similar performance.
; $03692C-$036931 LOCAL JUMP LOCATION
Sprite_Move:
{
    JSR.w Sprite_MoveHoriz

    JMP.w Sprite_MoveVert
}

; $036932-$03693D LOCAL JUMP LOCATION
Sprite_MoveHoriz:
{
    ; Do X position adjustment.
    TXA : CLC : ADC.b #$10 : TAX
    JSR.w Sprite_MoveVert
    
    ; Reset sprite index so that we can do the Y position adjustment next.
    LDX.w $0FA0
    
    RTS
}

; $03693E-$03696B LOCAL JUMP LOCATION
Sprite_MoveVert:
{
    LDA.w $0D40, X : BEQ .return
        ASL #4 : CLC : ADC.w $0D60, X : STA.w $0D60, X
        
        LDA.w $0D40, X : PHP
        LSR #4
        LDY.b #$00 : PLP : BPL .positive
            ORA.b #$F0
            
            DEY
        
        .positive
        
              ADC.w $0D00, X : STA.w $0D00, X
        TYA : ADC.w $0D20, X : STA.w $0D20, X
    
    .return
    
    RTS
}

; ==============================================================================

; $03696C-$03698D LOCAL JUMP LOCATION
Sprite_MoveAltitude:
{
    LDA.w $0F80, X : ASL #4 : CLC : ADC.w $0F90, X : STA.w $0F90, X
    
    LDA.w $0F80, X : PHP
    LSR #4 : PLP : BPL .positive
        ORA.b #$F0
    
    .positive
    
    ADC.w $0F70, X : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $03698E-$036990 BRANCH LOCATION
Sprite_ProjectSpeedTowardsPlayer_return:
{
    STZ.b $00
    
    RTS
}

; Calculates a trajectory with a given magnitude.... but there's some broken
; trigonometry going on. Replacing this with the lookup tables in the dark
; prophecy hack could be a good idea. $01 is the magnitude or force of the
; trajectory.
; $036991-$036A03 LOCAL JUMP LOCATION
Sprite_ProjectSpeedTowardsPlayer:
{
    STA.b $01 : CMP.b #$00 : BEQ Sprite_ProjectSpeedTowardsPlayer_return
        PHX : PHY
        
        JSR.w Sprite_IsBelowPlayer : STY.b $02
        
        ; Difference in the low Y coordinate bytes.
        LDA.b $0E : BPL .positive_1
            EOR.b #$FF : INC
            ; Essentially, multiply by negative one, or in this context,
            ; absolute value.
            
        .positive_1
        
        ; $0C = |$0E| = |dY|
        STA.b $0C
        
        JSR.w Sprite_IsToRightOfPlayer : STY.b $03
        
        ; The difference in the low X coordinate bytes.
        LDA.b $0F : BPL .positive_2
            EOR.b #$FF : INC
        
        .positive_2
        
        ; $0D = |$0F| = |dX|
        STA.b $0D
        
        LDY.b #$00
        
        ; If |dX| > |dY|
        LDA.b $0D : CMP.b $0C : BCS .dx_is_bigger
            ; Flag indicating |dY| >= |dX|
            INY
            
            ; |dX| -> Stack; |dY| -> $0D ; |dX| -> $0C.
            ; Either way, the larger value will end up at $0D.
            PHA : LDA.b $0C : STA.b $0D
            PLA             : STA.b $0C
        
        .dx_is_bigger
        
        STZ.b $0B
        STZ.b $00
        
        LDX.b $01
        
        .still_have_velocity_to_apply 
        
            ; If ($0B + $0C) <= ($0D)
            LDA.b $0B : CLC : ADC.b $0C : CMP.b $0D : BCC .not_accumulated_yet
                ; Otherwise, just subtract the larger value and increment $00.
                SBC.b $0D
                
                ; Apportion velocity to the direction that has less magnitude
                ; for once.
                INC.b $00
            
            .not_accumulated_yet
            
            STA.b $0B
        DEX : BNE .still_have_velocity_to_apply
        
        TYA : BEQ .dx_is_bigger_2
            ; Swap $00 and $01.
            LDA.b $00 : PHA
            LDA.b $01 : STA.b $00
            PLA       : STA.b $01
        
        .dx_is_bigger_2
        
        LDA.b $00
        
        LDY.b $02 : BEQ .polarity_already_correct_1
            EOR.b #$FF : INC : STA.b $00
        
        .polarity_already_correct_1
        
        LDA.b $01
        
        LDY.b $03 : BEQ .polarity_already_correct_2
            EOR.b #$FF : INC : STA.b $01
        
        .polarity_already_correct_2
        
        PLY : PLX
        
        RTS
}

; ==============================================================================

; $036A04-$036A11 LOCAL JUMP LOCATION
Sprite_ApplySpeedTowardsPlayer:
{
    JSR.w Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $036A12-$036A19 LONG JUMP LOCATION
Sprite_ApplySpeedTowardsPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_ApplySpeedTowardsPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A1A-$036A21 LONG JUMP LOCATION
Sprite_ProjectSpeedTowardsPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_ProjectSpeedTowardsPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A22-$036A29 LONG JUMP LOCATION
Sprite_ProjectSpeedTowardsEntityLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_ProjectSpeedTowardsEntity
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A2A-$036A2C BRANCH LOCATION
Sprite_ProjectSpeedTowardsEntity_return:
{
    STZ.b $00
    
    RTS
}

; $036A2D-$036A9F LOCAL JUMP LOCATION
Sprite_ProjectSpeedTowardsEntity:
{
    STA.b $01
    CMP.b #$00 : BEQ .return
        PHX : PHY
        
        JSR.w Sprite_IsBelowEntity : STY.b $02
        
        LDA.b $0E : BPL .positive_1
            EOR.b #$FF : INC
        
        .positive_1
        
        STA.b $0C
        
        JSR.w Sprite_IsToRightOfEntity : STY.b $03
        
        LDA.b $0F : BPL .positive_2
            EOR.b #$FF : INC
        
        .positive_2
        
        STA.b $0D
        
        LDY.b #$00
        
        LDA.b $0D : CMP.b $0C : BCS .dx_is_bigger
            INY
            
            PHA
            
            LDA.b $0C : STA.b $0D
            
            PLA : STA.b $0C
        
        .dx_is_bigger
        
        STZ.b $0B
        STZ.b $00
        
        LDX.b $01
        
        .still_have_velocity_to_apply
        
            ; If ($0B + $0C) <= ($0D)
            LDA.b $0B : CLC : ADC.b $0C : CMP.b $0D : BCC .not_accumulated_yet
                ; Otherwise, just subtract the larger value and increment $00.
                SBC.b $0D
                
                ; Apportion velocity to the direction that has less magnitude for
                ; once.
                INC.b $00
            
            .not_accumulated_yet
            
            STA.b $0B
        DEX : BNE .still_have_velocity_to_apply
        
        TYA : BEQ .dx_is_bigger_2
            ; Swap $00 and $01.
            LDA.b $00 : PHA
            LDA.b $01 : STA.b $00
            PLA       : STA.b $01
            
        .dx_is_bigger_2
        
        LDA.b $00
        
        LDY.b $02 : BEQ .polarity_already_correct_1
            EOR.b #$FF : INC : STA.b $00
        
        .polarity_already_correct_1
        
        LDA.b $01
        
        LDY.b $03 : BEQ .polarity_already_correct_2
            EOR.b #$FF : INC : STA.b $01
        
        .polarity_already_correct_2
        
        PLY : PLX
        
        RTS
}

; ==============================================================================

; $036AA0-$036AA3 LONG JUMP LOCATION
Sprite_DirectionToFacePlayerLong:
{
    JSR.w Sprite_DirectionToFacePlayer
    
    RTL
}

; ==============================================================================

; $036AA4-$036ACC LOCAL JUMP LOCATION
; Return: $0E is low byte of player_y_pos - sprite_y_pos
;         $0F is low byte of player_x_pos - sprite_x_pos
Sprite_DirectionToFacePlayer:
{
    JSR.w Sprite_IsToRightOfPlayer : STY.b $00
    JSR.w Sprite_IsBelowPlayer     : STY.b $01
    
    LDA.b $0E : BPL .positive_1
        EOR.b #$FF : INC
    
    .positive_1
    
    STA.w $0FB5
    
    LDA.b $0F : BPL .positive_2
        EOR.b #$FF : INC
    
    .positive_2
    
    ; Compares absolute values of dx and dy.
    CMP.w $0FB5 : BCC .dy_is_bigger
        LDY.b $00
        
        RTS
    
    .dy_is_bigger
    
    LDA.b $01 : INC : INC : TAY
    
    RTS
}

; ==============================================================================

; $036ACD-$036AD0 LONG JUMP LOCATION
Sprite_IsToRightOfPlayerLong:
{
    JSR.w Sprite_IsToRightOfPlayer
    
    RTL
}

; $036AD1-$036AE3 LOCAL JUMP LOCATION
Sprite_IsToRightOfPlayer:
{
    LDY.b #$00
    
    ; Link X - Sprite X
    LDA.b $22 : SEC : SBC.w $0D10, X : STA.b $0F
    LDA.b $23 : SBC.w $0D30, X : BPL .same_or_to_left
        ; If Link is to the left of the sprite, Y = 1, otherwise Y = 0.
        INY
        
    .same_or_to_left
    
    RTS
}

; ==============================================================================

; $036AE4-$036AE7 LONG JUMP LOCATION
Sprite_IsBelowPlayerLong:
{
    JSR.w Sprite_IsBelowPlayer
    
    RTL
}

; ==============================================================================

; Return: Y=0 sprite is above or level with player
;         Y=1 sprite is below player
; $036AE8-$036B09 LOCAL JUMP LOCATION
Sprite_IsBelowPlayer:
{
    LDY.b #$00
    
    ; The additional 8 pixels I'm sure is to help simulate relative
    ; perspective. The altitude of the sprite is also factored in.
    LDA.b $20 : CLC : ADC.b #$08     : PHP 
                CLC : ADC.w $0F70, X : PHP
                SEC : SBC.w $0D00, X : STA.b $0E
    
    ; The higher byte of Link's Y coordinate.
    ; The difference in their higher bytes.
    ; Offset if Link is crossing a 0x0100 pixel boundary.
    LDA.b $21 : SBC.w $0D20, X
    PLP : ADC.b #$00 : PLP : ADC.b #$00 : BPL .same_or_above
        ; Link is above the sprite and therefore...
        ; The sprite is below the player.
        INY
        
    .same_or_above
    
    RTS
}

; ==============================================================================

; $04 = X coordinate of an entity
; $036B0A-$036B1C LOCAL JUMP LOCATION
Sprite_IsToRightOfEntity:
{
    LDY.b #$00
    
    LDA.b $04 : SEC : SBC.w $0D10, X : STA.b $0F
    LDA.b $05       : SBC.w $0D30, X : BPL .same_or_to_left
        INY
    
    .same_or_to_left
    
    RTS
}

; ==============================================================================

; $06 = coordinate of an entity
; $036B1D-$036B2F LOCAL JUMP LOCATION
Sprite_IsBelowEntity:
{
    LDY.b #$00
    
    LDA.b $06 : SEC : SBC.w $0D00, X : STA.b $0E
    LDA.b $07       : SBC.w $0D20, X : BPL .entityIsBelow
        INY
    
    .entityIsBelow
    
    RTS
}

; ==============================================================================

; $036B30-$036B5D LONG JUMP LOCATION
Sprite_DirectionToFaceEntity:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_IsToRightOfEntity : STY.b $00
    JSR.w Sprite_IsBelowEntity     : STY.b $01
    
    LDA.b $0E : BPL .positive_1
        EOR.b #$FF : INC
    
    .positive_1
    
    STA.w $0FB5
    
    LDA.b $0F : BPL .positive_2
        EOR.b #$FF : INC
    
    .positive_2
    
    ; Compares absolute values of dx and dy.
    CMP.w $0FB5 : BCC .dy_is_bigger
        LDY.b $00
        
        PLB
        
        RTL
        
    .dy_is_bigger
    
    LDA.b $01 : INC : INC : TAY
    
    PLB
    
    RTL
}

; $036B5E-$036B65 LONG JUMP LOCATION
Guard_ParrySwordAttacks:
{
    PHB : PHK : PLB
    
    JSR.w Guard_ParrySwordAttacks_main
    
    PLB
    
    RTL
}

; $036B66-$036B75
Pool_Guard_ParrySwordAttacks_main:
{
    ; $036B66
    .recoilTimes
    db $0F, $0F, $18, $0F
    db $0F, $13, $0F, $0F

    ; $036B6E
    .recoil_timer_link
    db  6,  6,  6, 12
    db  6,  6,  6, 15
}

; Exclusively called by soldier like enemies... but not sure why...?
; $036B76-$036C01 LOCAL JUMP LOCATION
Guard_ParrySwordAttacks_main:
{
    LDA.b $EE : CMP.w $0F20, X : BNE .not_on_player_layer
        LDA.b $46 : ORA.b $4D
    
    .not_on_player_layer
    
    BNE .return
        LDA.w $0EF0, X : BMI .return
            JSR.w Sprite_DoHitboxesFast
            
            LDA.w $037A : AND.b #$10 : BNE .BRANCH_GAMMA
                LDA.b $44 : CMP.b #$80 : BEQ .BRANCH_GAMMA
                    JSR.w Player_SetupActionHitBox
                    
                    LDA.b $3C : BMI .BRANCH_DELTA
                        JSR.w Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_DELTA
                            LDA.w $0E20, X : CMP.b #$6A : BEQ .BRANCH_EPSILON
                                JSL.l GetRandomInt : AND.b #$07 : TAY
                                
                                LDA Pool_Guard_ParrySwordAttacks_main_recoilTimes, Y 
                                STA.w $0EA0, X
                            
                            .BRANCH_EPSILON
                            
                            JSL.l GetRandomInt : AND.b #$07 : TAY
                            
                            LDA.w Pool_Guard_ParrySwordAttacks_main_recoil_timer_link, Y : STA.b $46
                            
                            LDA.b #$18
                            
                            LDY.b $3C : CPY.b #$09 : BPL .BRANCH_ZETA
                                LDA.b #$20
                            
                            .BRANCH_ZETA
                            
                            JSR.w Sprite_ProjectSpeedTowardsPlayer
                            
                            LDA.b $00 : EOR.b #$FF : INC : STA.w $0F30, X
                            LDA.b $01 : EOR.b #$FF : INC : STA.w $0F40, X
                            
                            LDA.b #$10
                            
                            LDY.b $3C : CPY.b #$09 : BPL .BRANCH_THETA
                                LDA.b #$08
                            
                            .BRANCH_THETA
                            
                            JSR.w Sprite_ApplyRecoilToPlayer
                            JSR.w Player_PlaceRepulseSpark
                            
                            LDA.b #$90 : STA.b $47
    
    .return
    
    RTS
    
    .BRANCH_DELTA
    
    JSR.w Sprite_SetupHitBox
    
    JSR.w Utility_CheckIfHitBoxesOverlap : BCS .BRANCH_IOTA
        .BRANCH_GAMMA
        
        JML.l Sprite_StaggeredCheckDamageToPlayerPlusRecoil

    .BRANCH_IOTA

    ; Bleeds into the next function.
}
    
; $036C02-$036C5B LOCAL JUMP LOCATION
Sprite_AttemptZapDamage:
{
    LDA.w $0E20, X : CMP.b #$7A : BEQ .attempt_electrocution
        CMP.b #$0D : BNE .not_buzzblob
            LDA.l $7EF359 : CMP.b #$04 : BCC .attempt_electrocution
        
        .not_buzzblob
        
        ; BUG: If we reach here from the comparison with the sword value,
        ; well.... we're not comparing apples to apples.
        CMP.b #$24 : BEQ .is_bari_or_biri
            CMP.b #$23 : BNE .not_bari_or_biri
        
        .is_bari_or_biri
        
        LDA.w $0DF0, X : BEQ .cant_electrocute
    
    .attempt_electrocution
    
    ; But if the sprite's not active, it can't electrocute.
    LDA.w $0DD0, X : CMP.b #$09 : BNE .cant_electrocute
        LDA.w $031F : BNE .player_blinking_invulnerable
            LDA.b #$40 : STA.w $0E00, X
                         STA.w $0360
            
            JSR.w Sprite_AttemptDamageToPlayerPlusRecoil
        
        .player_blinking_invulnerable
        
        RTS
        
    .cant_electrocute
    .not_bari_or_biri
    
    LDA.b #$50
    
    LDY.b $3C : CPY.b #$09 : BMI .BRANCH_OMICRON ; Not spin attack.
        LDA.b #$40
    
    .BRANCH_OMICRON
    
    JSR.w Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : EOR.b #$FF : INC : STA.w $0F30, X
    LDA.b $01 : EOR.b #$FF : INC : STA.w $0F40, X
    
    JSL.l Sprite_CalculateSwordDamage
    
    RTS
}

; ==============================================================================

; Exclusively called by Medallion code
; $036C5C-$036C7D LONG JUMP LOCATION
Medallion_CheckSpriteDamage:
{
    LDA.w $0C4A, X : STA.w $0FB5
    
    LDX.b #$0F
    
    .next_sprite
    
        LDA.w $0DD0, X : CMP.b #$09 : BCC .inactive_sprite
            LDA.w $0BA0, X : ORA.w $0F00, X : BNE .inactive_sprite
                LDA.w $0FB5 : JSL.l Ancilla_CheckSpriteDamage_override
        
        .inactive_sprite
    DEX : BPL .next_sprite
    
    RTL
}

; ==============================================================================

; $036C7E-$036CB6 DATA
AncillaDamageClasses:
{
    ; See $0C4A in WRAM.
    ; Possible values: 0x00, 0x01, 0x06, 0x07, 0x08, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F

    db $06 ; 0x00 - NOTHING
    db $01 ; 0x01 - SOMARIA BULLET
    db $0B ; 0x02 - FIRE ROD SHOT
    db $00 ; 0x03 - UNUSED
    db $00 ; 0x04 - BEAM HIT
    db $00 ; 0x05 - BOOMERANG
    db $00 ; 0x06 - WALL HIT
    db $08 ; 0x07 - BOMB
    db $00 ; 0x08 - DOOR DEBRIS
    db $06 ; 0x09 - ARROW
    db $00 ; 0x0A - ARROW IN THE WALL
    db $0C ; 0x0B - ICE ROD SHOT
    db $01 ; 0x0C - SWORD BEAM_BOUNCE
    db $00 ; 0x0D - SPIN ATTACK FULL CHARGE SP
    db $00 ; 0x0E - BLAST WALL EXPLOSION
    db $00 ; 0x0F - BLAST WALL EXPLOSION
    db $00 ; 0x10 - BLAST WALL EXPLOSION
    db $01 ; 0x11 - ICE ROD WALL HIT
    db $00 ; 0x12 - BLAST WALL EXPLOSION
    db $00 ; 0x13 - ICE ROD SPARKLE
    db $00 ; 0x14 - BAD POINTER
    db $00 ; 0x15 - SPLASH
    db $00 ; 0x16 - HIT STARS
    db $00 ; 0x17 - SHOVEL DIRT
    db $0E ; 0x18 - ETHER SPELL
    db $0D ; 0x19 - BOMBOS SPELL
    db $00 ; 0x1A - POWDER DUST
    db $00 ; 0x1B - SWORD WALL HIT
    db $0F ; 0x1C - QUAKE SPELL
    db $00 ; 0x1D - SCREEN SHAKE
    db $00 ; 0x1E - DASH DUST
    db $07 ; 0x1F - HOOKSHOT
    db $01 ; 0x20 - BLANKET
    db $01 ; 0x21 - SNORE
    db $01 ; 0x22 - ITEM GET
    db $01 ; 0x23 - LINK POOF
    db $01 ; 0x24 - GRAVESTONE
    db $01 ; 0x25 - BAD POINTER
    db $01 ; 0x26 - SWORD SWING SPARKLE
    db $01 ; 0x27 - DUCK
    db $01 ; 0x28 - WISH POND ITEM
    db $01 ; 0x29 - MILESTONE ITEM GET
    db $01 ; 0x2A - SPIN ATTACK SPARKLE A
    db $01 ; 0x2B - SPIN ATTACK SPARKLE B
    db $01 ; 0x2C - SOMARIA BLOCK
    db $01 ; 0x2D - SOMARIA BLOCK FIZZ
    db $01 ; 0x2E - SOMARIA BLOCK FISSION
    db $0B ; 0x2F - LAMP FLAME
    db $00 ; 0x30 - BYRNA WINDUP SPARK
    db $01 ; 0x31 - BYRNA SPARK
    db $01 ; 0x32 - BLAST WALL FIREBALL
    db $01 ; 0x33 - BLAST WALL EXPLOSION
    db $01 ; 0x34 - SKULL WOODS FIRE
    db $01 ; 0x35 - MASTER SWORD GET
    db $01 ; 0x36 - FLUTE
    db $01 ; 0x37 - WEATHERVANE EXPLOSION
    db $01 ; 0x38 - CUTSCENE DUCK
}

; ==============================================================================

; $036CB7-$036D24 LONG JUMP LOCATION
Ancilla_CheckSpriteDamage:
{
    LDY.w $0EF0, X : BPL .sprite_not_already_dying
        RTL
        
    .sprite_not_already_dying

    ; NOTE: It's called override because apparently it ignores the death
    ; timer status of the affected sprite.
    ; $036CBD ALTERNATE ENTRY POINT
    .override

    PHX
    
    TAX
    LDA.l AncillaDamageClasses, X
    
    PLX
    
    CMP.b #$06 : BNE .not_arrow_damage_class
        ; Do we have silver arrows?
        PHA : LDA.l $7EF340 : CMP.b #$03 : PLA : BCC .not_arrow_damage_class
            ; Is this Ganon?
            ; TODO: Go back and check if this means he's invincible, or just
            ; arrow prone (to deathing).
            LDA.w $0E20, X : CMP.b #$D7 : BNE .not_invincible_ganon
                ; Set damage timer? (In the event it's the arrow-vulnerable
                ; Ganon).
                LDA.b #$20 : STA.w $0F10, X
            
            .not_invincible_ganon
            
            LDA.b #$09
            
    .not_arrow_damage_class

    ; TODO: Should this really be in the Ancilla namespace? Perhaps this and
    ; its brethen should be in the Sprite_ namespace and flip around the
    ; ancilla part so it's taking damage from an ancilla or damage class.
    ; $036CE0 ALTERNATE ENTRY POINT
    .preset_class
    
    CMP.b #$0F : BNE .not_quake_spell
        LDY.w $0F70, X : BEQ .quake_only_affects_enemy_on_ground
            ; Dem's tha breaks, kiddo.
            RTL
        
        .quake_only_affects_enemy_on_ground
    .not_quake_spell
    
    CMP.b #$00 : BEQ .boomerang_or_hookshot_class
        CMP.b #$07 : BNE .not_boomerang_or_hookshot
    
    .boomerang_or_hookshot_class
    
    JSL.l .apply_damage
    
    LDA.w $0CE2, X : BNE .dont_spawn_repulse_spark
        LDA.w $0FAC : BNE .dont_spawn_repulse_spark
            LDA.b #$05 : STA.w $0FAC
            
            LDY.w $0FB6
            LDA.w $0C04, Y : ADC.b #$04 : STA.w $0FAD
            LDA.w $0BFA, Y              : STA.w $0FAE
            
            LDA.b $EE : STA.w $0B68
            
            STZ.w $012E
            
            LDA.b #$05
            JSL.l Sound_SetSfx2PanLong

    .dont_spawn_repulse_spark

    RTL

    .not_boomerang_or_hookshot

    ; Bleeds into the next function.
}
    
; $036D25-$036D32 LONG JUMP LOCATION
Ancilla_CheckSpriteDamage_apply_damage:
{
    STA.w $0CF2 : TAY
    
    LDA.b #$20
    
    CPY.b #$08 : BNE .not_bomb_class
        ; Cause the sprite to recoil more from bomb damage, right?
        LDA.b #$35

    .not_bomb_class

    BRA .BRANCH_$36D89
}

; ==============================================================================

; $036D33-$036D3E DATA TABLE
Sprite_CalculateSwordDamage_damage_class:
{
    db 1, 2, 3, 4 ; Normal strike damage indices
    db 2, 3, 4, 5 ; Spin attack damage indices
    db 1, 1, 2, 3 ; Stabbing damage indices
}

; $036D3F-$036EC0 LONG JUMP LOCATION
Sprite_CalculateSwordDamage:
{
    ; If bit 6 is set, sprite is invincible.
    LDA.w $0E60, X : AND.b #$40 : BEQ .notImpervious
        RTL
    
    .notImpervious
    
    LDA.w $0372 : STA.l $7FFA4C, X
    
    PHX
    
    ; Load Link's sword type.
    LDA.l $7EF359 : DEC
    
    LDX.w $0372 : BNE .notStabbingDamageType
        BRA .checkSwordCharging
        
    .doingSpinAttack
        
    ORA.b #$04
        
    BRA .notStabbingDamageType
        
    .checkSwordCharging
        
    ; How long has Link's sword been stuck out?
    ; If negative, he's doing a spin attack.
    LDX.b $3C : BMI .doingSpinAttack
        CPX.b #$09 : BMI .notStabbingDamageType ; Branch if less than 9.
            ORA.b #$08 ; Otherwise it gets a stabbing indicator.
        
    .notStabbingDamageType
    
    ; Set the damage class.
    TAX
    LDA.l .damage_class, X : STA.w $0CF2
    
    ; Not sure which item types this indicates.
    LDA.w $0301 : AND.b #$0A : BEQ .not_poised_with_hammer
        LDA.b #$03 : STA.w $0CF2
    
    .not_poised_with_hammer
    
    ; Set a timer.
    LDA.b #$04 : STA.w $02E3
    
    PLX
    
    LDA.b #$10 : STA.b $47
    
    LDA.b #$9D
    
    ; Bleeds into the next function.
}

; $036D89 ALTERNATE ENTRY POINT
Sprite_ApplyCalculatedDamage:
{
    STA.b $00
    
    ; THIS IS NOT USELESS!!!
    ; Removing this line makes it impossible to hit anything with your sword.
    STZ.w $0CF3
    
    LDA.w $0E60, X : AND.b #$40 : BNE .impervious
        LDA.b #$00 : XBA
        
        LDA.w $0E20, X : CMP.b #$D8 : BCC .notItemSprite
    
    .impervious
    
    RTL
    
    .notItemSprite
    
    REP #$20
    ASL #4 : ORA.w $0CF2 : PHX
    REP #$10
    TAX
    SEP #$20
    
    ; Loads Selected Sprite Damage in Advanced Damage Editor.
    LDA.l $7F6000, X : STA.b $02
    
    SEP #$10
    
    ; (Damage class << 3) | monster
    LDA.w $0CF2 : ASL #3 : ORA.b $02 : TAX
    
    ; Get the damage value for that monster for that damage class.
    LDA.l DamageSubclassValue, X
    
    PLX
    
    ; $036DC5 ALTERNATE ENTRY POINT
    .AgahnimBalls_DamageAgahnim

    CMP.b #$F9 : BNE .dontMakeIntoFairy
        ; Turn something into a fairy.
        LDA.b #$E3
        
        ; $036DCB ALTERNATE ENTRY POINT
        .transmute_to_sprite
        
        STA.w $0E20, X
        
        JSL.l Sprite_LoadProperties
        JSL.l Sprite_SpawnPoofGarnish
        
        STZ.w $012F
        
        LDA.b #$32 : JSL.l Sound_SetSfx3PanLong
        
        JMP.w Sprite_Clear_queued_damage
    
    .dontMakeIntoFairy
    
    ; Turn something into a 0 HP blob.
    CMP.b #$FA : BNE .dontMakeIntoBlob
        LDA.b #$8F
        
        JSL.l .transmute_to_sprite
        
        LDA.b #$02 : STA.w $0D80, X
        
        LDA.b #$20 : STA.w $0F80, X
        
        LDA.b #$08 : STA.w $0F50, X
        
        STZ.w $0EA0, X
        STZ.w $0EF0, X
        STZ.w $0E50, X
        
        LDA.b #$01 : STA.w $0CD2, X
                     STA.w $0BE0, X
        
        RTL
    
    .dontMakeIntoBlob
    
    CMP.w $0CE2, X : BCC .ifNewDamageLessIgnore 
        ; If(calc_dmg < base_dmg) dmg = base_dmg
        STA.w $0CE2, X
    
    .ifNewDamageLessIgnore
    
    CMP.b #$00 : BNE .notZeroDamageType
        LDA.w $0CF2 : CMP.b #$0A : BEQ .BRANCH_THETA
            LDA.w $0B6B, X : AND.b #$04 : BNE .BRANCH_IOTA
                STZ.w $02E3
        
        .BRANCH_THETA
        
        JMP.w Sprite_Clear_queued_damage
    
    .notZeroDamageType
    
    ; Freeze damage type
    CMP.b #$FE : BCC .BRANCH_KAPPA
        ; Is sprite frozen? if so, do nothing.
        LDA.w $0DD0, X : CMP.b #$0B : BEQ .BRANCH_THETA
    
    .BRANCH_KAPPA
    
    ; Is it a water bubble (in swamp palace)?
    LDA.w $0E20, X : CMP.b #$9A : BNE .not_water_bubble
        LDY.w $0CE2, X : CPY.b #$F0 : BCS .BRANCH_LAMBDA
            LDA.b #$09 : STA.w $0DD0, X
            LDA.b #$04 : STA.w $0D80, X
            LDA.b #$0F : STA.w $0DF0, X
            
            LDA.b #$28
            JSL.l Sound_SetSfx2PanLong
            
            RTL
    
        .BRANCH_LAMBDA
    .not_water_bubble
    
    CMP.b #$1B : BNE .not_arrow_in_wall
        ; $036E60 ALTERNATE ENTRY POINT
        .SpriteArrow_Break
        
        LDA.b #$05
        JSL.l Sound_SetSfx2PanLong
        
        JSR.w Sprite_ScheduleForBreakage
        JSL.l Sprite_PlaceRupulseSpark
        
        RTL
    
    .not_arrow_in_wall
    
    PHA
    
    LDA.b $00 : STA.w $0EF0, X
    
    PLA : CMP.b #$92 : BNE .not_helmasaur_king
        LDA.w $0DB0, X : CMP.b #$03 : BCC .no_sound_effect
            LDY.b #$21
            
            LDA.w $0B6B, X : AND.b #$02 : BNE .boss_damage_sound
    
    .not_helmasaur_king
    
    LDY.b #$08
    
    LDA.w $0BE0, X : AND.b #$10 : BEQ .minor_damage_sound
        LDY.b #$1C
    
    .minor_damage_sound
    .boss_damage_sound
    
    STY.b $01 : JSL.l Sound_SetSfxPan : ORA.b $01 : STA.w $012F
    
    .no_sound_effect
    
    LDA.b #$00
    
    LDY.w $0CF2 : CPY.b #$0D : BCS .medallion_damage_class
        LDY.w $0E20, X

        LDA.b #$14

        CPY.b #$09 : BEQ .giant_moldorm
            LDA.b #$0F

            CPY.b #$53 : BEQ .armos_knight
                CPY.b #$18 : BNE .not_moldorm
        
            .armos_knight
            
            LDA.b #$0B
            
            .not_moldorm
        .giant_moldorm
    .medallion_damage_class
    
    STA.w $0EA0, X
    
    RTL
}

; Don't deal damage/don't kill sprite.
; $036EC1-$036EC7 LONG JUMP LOCATION
Sprite_Clear_queued_damage:
{
    STZ.w $0EF0, X
    STZ.w $0CE2, X
    
    RTL
}

; $036EC8-$036FD9 LOCAL JUMP LOCATION
Sprite_HandleSpecialHits:
{
    ; Is the sprite alive?
    LDA.w $0DD0, X : CMP.b #$09 : BCC .not_fully_active_sprite
        ; Store this value in a temporary location.
        STA.w $0FB5
        
        LDA.w $0CE2, X : CMP.b #$FD : BNE .not_burn_damage
            STZ.w $0CE2, X
            
            LDA.b #$09
            JSL.l Sound_SetSfx3PanLong
            
            LDA.b #$07 : STA.w $0DD0, X
            LDA.b #$70 : STA.w $0DF0, X
            
            LDA.w $0E40, X : INC : INC : STA.w $0E40, X
            
            STZ.w $0CE2, X
    
    .not_fully_active_sprite
    .BRANCH_ALPHA
    
    RTS
    
    .not_burn_damage
    
    CMP.b #$FB : BCC .transmutation
    
        STZ.w $0CE2, X
        
        STA.b $00
        
        LDY.w $0DD0, X : CPY.b #$0B : BEQ .BRANCH_ALPHA
            LDY.b #$00
            
            CMP.b #$FE : BNE .BRANCH_GAMMA
                INY
            
            .BRANCH_GAMMA
            
            TYA : STA.l $7FFA3C, X : BEQ .BRANCH_DELTA
                LDA.w $0CAA, X : ORA.b #$08 : STA.w $0CAA, X
                
                ASL.w $0BE0, X : LSR.w $0BE0, X
                
                LDA.b #$0F
                JSL.l Sound_SetSfx2PanLong
                
                LDA.b #$18 : STA.w $0F80, X
                
                ; TODO: Does this remove the top bit?
                ASL.w $0CD2, X : LSR.w $0CD2, X
                
                JSR.w Sprite_Zero_XY_Velocity
            
            .BRANCH_DELTA
            
            LDA.b #$0B : STA.w $0DD0, X
            LDA.b #$40 : STA.w $0DF0, X
            
            LDA.b $00 : CLC : ADC.b #$05 : TAY
            
            ; BUG: (unconfirmed) This seems destined for failure, unless I'm
            ; missing something.
            LDA.w .stun_timer_amounts, Y : STA.w $0B58, X
            
            LDA.w $0E20, X : CMP.b #$23 : BNE .BRANCH_EPSILON
            
            ; TODO: Figure out what this means? Stunning a blue onoff makes
            ; them turn into a red one? What?
            INC : STA.w $0E20, X
            
            .BRANCH_EPSILON
            
            JMP.w Sprite_ScheduleForDeath_exit
    
    .stun_timer_amounts
    db 32, 128,  0,  0, 255

    ; TODO: Double check if it actually is an alternate entry point or just a
    ; branch location.
    ; $036F61 ALTERNATE ENTRY POINT
    .transmutation

    LDA.w $0E50, X : STA.b $00
    
    ; Subtract off an amount from the enemies HP.
    SEC : SBC.w $0CE2, X : STA.w $0E50, X
    
    STZ.w $0CE2, X
    
    BEQ .BRANCH_ALPHA
        BCS Sprite_ScheduleForDeath_exit
    
    .BRANCH_ALPHA
    
    LDA.w $0CBA, X : BNE .BRANCH_GAMMA
        LDA.w $0DD0, X : CMP.b #$0B : BNE .BRANCH_DELTA
            LDA.b #$03 : STA.w $0CBA, X
        
        .BRANCH_DELTA
        
        LDA.l $7FFA4C, X : BEQ .BRANCH_GAMMA
            LDA.b #$00 : STA.l $7FFA4C, X
            
            STZ.w $0BE0, X
    
    .BRANCH_GAMMA
    
    LDY.w $0E20, X : CPY.b #$1B : BEQ .BRANCH_EPSILON
        LDA.b #$09 : JSL.l Sound_SetSfx3PanLong
    
    .BRANCH_EPSILON
    
    CPY.b #$40 : BNE .BRANCH_ZETA
        PHX
        
        LDX.b $8A
        LDA.l $7EF280, X : ORA.b #$40 : STA.l $7EF280, X
        
        PLX
    
    .BRANCH_ZETA
    
    TYA : CMP.b #$EC : BNE .BRANCH_THETA
        LDY.w $0DB0, X : CPY.b #$02 : BNE Sprite_ScheduleForDeath_exit
            JMP.w ThrowableScenery_TransmuteToDebris
    
    .BRANCH_THETA
    
    PHA
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .BRANCH_IOTA
        STZ.w $0308
        STZ.w $0309
        
    .BRANCH_IOTA
    
    LDA.b #$06 : STA.w $0DD0, X
    
    PLA : CMP.b #$0C : BNE Sprite_AttemptKillingOfKin
        ; Bleeds into the next function.
}

; $036FDA-$036FE7 LOCAL JUMP LOCATION
Sprite_ScheduleForDeath:
{
    LDA.b #$06 : STA.w $0DD0, X
    LDA.b #$1F : STA.w $0DF0, X
    
    JSR.w Sprite_ChangeOAMAllotmentTo4
    
    ; $036FE7 ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; $036FE8-$037086 LOCAL JUMP LOCATION
Sprite_AttemptKillingOfKin:
{
    CMP.b #$92 : BNE .BRANCH_LAMBDA
        JSL.l Sprite_SchedulePeersForDeath
        
        LDA.b #$FF : STA.w $0DF0, X
        
        JMP.w Sprite_BossScreamAndDisableMenu
    
    .BRANCH_LAMBDA
    
    CMP.b #$CB : BNE .not_main_trinexx_head
        JMP.w Trinexx_ScheduleMainHeadForDeath
    
    .not_main_trinexx_head
    
    CMP.b #$CC : BEQ .trinexx_side_head
        CMP.b #$CD : BNE .not_trinexx_side_head
    
    .trinexx_side_head
    
    JMP.w Trinexx_ScheduleSideHeadForDeath
    
    .not_trinexx_side_head
    
    CMP.b #$53 : BEQ .BRANCH_OMICRON
        CMP.b #$54 : BEQ .BRANCH_PI
            CMP.b #$09 : BEQ .BRANCH_RHO
                CMP.b #$7A : BNE .not_agahnim_death
                    JMP.w Agahnim_ScheduleForDeath
                
                .not_agahnim_death
                
                CMP #$23 : BEQ RedBari_TimeToDie
                    CMP #$0F : BNE .SpriteDeath_not_octoballoon
                        ; $037025 ALTERNATE ENTRY POINT
                        .Octoballoon

                        ; TODO: Remove this label later when the new one is
                        ; used.
                        Octoballoon_ScheduleForDeath:
                        
                        STZ.w $0EF0, X
                        
                        LDA.b #$0F : STA.w $0DF0, X
                        
                        RTS
                    
                    .SpriteDeath_not_octoballoon
                    
                    LDA.w $0B6B, X : AND.b #$02 : BNE .BRANCH_PHI
                        LDA.w $0EF0, X : ASL
                        
                        LDA.b #$0F : BCC .BRANCH_CHI
                            LDA.b #$1F
                        
                        .BRANCH_CHI
                        
                        STA.w $0DF0, X
                        
                        JMP.w NormalMob_TimeToDie
                        
                        RTS
                
            .BRANCH_RHO
            
            LDA.b #$03 : STA.w $0D80, X
            
            LDA.b #$A0 : STA.w $0F10, X
            
            LDA.b #$09 : STA.w $0DD0, X
            
            BRA Sprite_BossScreamAndDisableMenu
            
            .BRANCH_PHI
            
            ; Check if it's Kholdstare.
            LDA.w $0E20, X : CMP.b #$A2 : BEQ .BRANCH_OMEGA
                JSL.l Sprite_SchedulePeersForDeath
            
            .BRANCH_OMEGA
            
            LDA.b #$04 : STA.w $0DD0, X
            
            STZ.w $0D90, X
            
            LDA.b #$FF
            
            .BRANCH_ALTIMA
            
            STA.w $0DF0, X
            STA.w $0EF0, X
            
            BRA Sprite_BossScreamAndDisableMenu
        
        .BRANCH_PI
        
        LDA.b #$05 : STA.w $0D80, X
        
        LDA.b #$C0
        
        BRA .BRANCH_ALTIMA
    
    .BRANCH_OMICRON
    
    LDA.b #$23 : STA.w $0DF0, X
    
    STZ.w $0EF0, X
    
    BRA Sprite_BossScreamAndDisableMenu_queue_scream 
}

; $037087-$037093 LOCAL JUMP LOCATION
Sprite_BossScreamAndDisableMenu:
{
    INC.w $0FFC

    ; $03708A ALTERNATE ENTRY POINT
    .queue_scream

    STZ.w $012F
    
    LDA.b #$22 : JSL.l Sound_SetSfx3PanLong
    
    RTS
}

; $037094-$0370AB LOCAL JUMP LOCATION
RedBari_TimeToDie:
{
    ; If nonzero, can't split again because it's a small red bari.
    LDA.w $0DB0, X : BNE Sprite_AttemptKillingOfKin_SpriteDeath_not_octoballoon
        ; Initiate splitting process.
        LDA.b #$02 : STA.w $0D80, X
        
        ; Splitting timer.
        LDA.b #$20 : STA.w $0DF0, X
        
        ; Make sure Bari stays alive, otherwise it will not be able to
        ; complete the split.
        LDA.b #$09 : STA.w $0DD0, X
        
        STZ.w $0EF0, X
        
        RTS
}

; ==============================================================================

; $0370AC-$0370BC JUMP LOCATION
Trinexx_ScheduleSideHeadForDeath:
{
    LDA.b #$80 : STA.w $0D80, X
    
    LDA.b #$60 : STA.w $0DF0, X
    
    LDA.b #$09 : STA.w $0DD0, X
    
    ; Consider merging this routine with the previous one, or splitting
    ; the one above into smaller parts.
    BRA .BRANCH_$037087
}
    
; $0370BD-$0370CD JUMP LOCATION
Trinexx_ScheduleMainHeadForDeath:
{
    LDA.b #$80 : STA.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.b #$09 : STA.w $0DD0, X
    
    BRA Sprite_BossScreamAndDisableMenu
}
    
; $0370CE-$03710A JUMP LOCATION
Agahnim_ScheduleForDeath:
{
    JSL.l Sprite_SchedulePeersForDeath
    
    LDA.b #$09 : STA.w $0DD0, X
                 STA.w $0BA0, X
    
    LDA.w $0FFF : BNE .in_dark_world
        LDA.b #$0A : STA.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        LDA.b #$20 : STA.w $0F80, X
        
        JMP.w Sprite_BossScreamAndDisableMenu
    
    .in_dark_world
    
    LDA.b #255 : STA.w $0DF0, X
    
    LDA.b #$08 : STA.w $0D80, X
    
    INC : STA.w $0D81
          STA.w $0D82
    
    STZ.w $0DC1
    STZ.w $0DC2
    
    JMP.w Sprite_BossScreamAndDisableMenu
}

; $03710B-$037120 JUMP LOCATION
NormalMob_TimeToDie:
{
    LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
    
    LDA.w $0FB5 : CMP.b #$0B : BNE .BRANCH_BETA
        LDA.b #$01 : STA.w $0BE0, X
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $037121-$037128 LONG JUMP LOCATION
Sprite_CheckDamageToPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckDamageToPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037129-$037130 LONG JUMP LOCATION
Sprite_CheckDamageToPlayerSameLayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037131-$037138 LONG JUMP LOCATION
Sprite_CheckDamageToPlayerIgnoreLayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckDamageToPlayer_ignore_layer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037139-$037144 DATA
Sprite_ToLink_Directions:
{
    ; $037139
    .opposing
    db $04, $06, $00, $02

    ; $03713D
    .standing
    db $06, $04, $00, $00

    ; $037141
    .opposing2
    db $04, $06, $00, $02
}

; ==============================================================================

; Return value CLC = no damage
; Return value SEC = damaged
; $037145-$0371F5 LOCAL JUMP LOCATION
Sprite_CheckDamageToPlayer:
{
    ; Is Link untouchable?
    LDA.w $037B : BNE .no_damage
        ; $03714A ALTERNATE ENTRY POINT
        .stagger
        
        ; No he's not, he's vulnerable.
        TXA : EOR.b $1A : AND.b #$03
        
        ; Since for a sentry it's usually 0.
        ; It wasn't the right frame to hit on?
        ORA.w $0EF0, X : BNE .no_damage
            ; $037154 ALTERNATE ENTRY POINT
            .same_layer
            
            ; Is the sprite on the same floor as Link?
            ; Nope, he doesn't get hit.
            LDA.w $00EE : CMP.w $0F20, X : BNE .BRANCH_BETA
                ; $03715C ALTERNATE ENTRY POINT
                .ignore_layer
                
                ; Is the sprite deactivated?
                LDA.w $0F60, X : BEQ .BRANCH_GAMMA
                    ; Puts Link's X / Y coords into memory.
                    JSR.w Player_SetupHitBox_ignoreImmunity

                    JSR.w Sprite_SetupHitBox
                    JSR.w Utility_CheckIfHitBoxesOverlap
                    
                    BRA .BRANCH_DELTA
                
                .BRANCH_GAMMA
                
                JSR.w Sprite_SetupHitBox00
                
                .BRANCH_DELTA
                
                ; If the 0x80 bit is set, it's a harmless sprite.
                LDA.w $0E40, X : BMI .BRANCH_EPSILON
                    BCC .BRANCH_BETA
                        LDA.b $4D : BNE .BRANCH_BETA
                            LDA.w $02E0 : BNE .BRANCH_ZETA
                                LDA.w $0308 : BMI .BRANCH_ZETA
                                    LDA.w $0BE0, X : AND.b #$20 : BEQ .cant_be_blocked_by_shield
                                        ; LINK'S SHIELD LEVEL
                                        LDA.l $7EF35A : BEQ .BRANCH_ZETA
                                            STZ.w $0DD0, X
                                            
                                            LDA.b $2F
                                            
                                            LDY.b $3C : BEQ .BRANCH_THETA
                                                LSR : TAY
                                                
                                                ; Use an alternate direction
                                                ; when the shield is beind held
                                                ; off to the side (when holding
                                                ; the B button down).
                                                LDA.w Sprite_ToLink_Directions_standing, Y
                                            
                                            .BRANCH_THETA
                                            
                                            LDY.w $0DE0, X
                                            CMP.w Sprite_ToLink_Directions_opposing2, Y : BNE .BRANCH_ZETA
                                                LDA.b #$06
                                                JSL.l Sound_SetSfx2PanLong
                                                
                                                JSL.l Sprite_PlaceRupulseSpark_coerce
                                                
                                                ; Check if it's one of those laser eyes.
                                                LDA.w $0E20, X : CMP.b #$95 : BNE .not_laser_eye
                                                    LDA.b #$26
                                                    JSL.l Sound_SetSfx3PanLong
        
    .no_damage
    
    CLC
    
    .BRANCH_EPSILON
    
    RTS ; End the routine.
    
    .not_laser_eye
    
    CMP.b #$9B : BNE .not_wizzrobe
        JSR.w Sprite_Invert_XY_Speeds
        
        LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
        
        INC.w $0D80, X
        
        LDA.b #$09 : STA.w $0DD0, X
        
        .BRANCH_BETA
        
        CLC
        
        RTS
    
    .not_wizzrobe
    
    CMP.b #$1B : BEQ .arrow_in_wall
        CMP.b #$0C : BEQ .octorock_stone
            RTS
            
            .cant_be_blocked_by_shield
            .BRANCH_ZETA
            
            JSR.w Sprite_AttemptDamageToPlayerPlusRecoil
            
            LDA.w $0E20, X : CMP.b #$0C : BNE .not_octorock_stone
        
        .octorock_stone
        
        JSR.w Sprite_ScheduleForDeath
        
        .not_octorock_stone
        
        SEC
        
        RTS
        
        ; $0371F1 ALTERNATE ENTRY POINT
        .UNREACHABLE_06F1F1
        CLC
        
        RTS
    
    .arrow_in_wall
    
    JMP.w Sprite_ScheduleForBreakage
}

; $0371F6-$037227 LOCAL JUMP LOCATION
Sprite_SetupHitBox00:
{
    ; Load the sprite's Z component.
    LDA.w $0F70, X : STA.b $0C
                     STZ.b $0D
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$000B
    CMP.w #$0017 : BCS .no_collision
        LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.b $0C
        CLC : ADC.w #$0010 : CMP.w #$0018 : BCS .no_collision
            SEP #$20
            
            SEC
            
            RTS
        
    .no_collision
    
    SEP #$20
    
    CLC
    
    RTS
}

; ==============================================================================

; $037228-$0372A9 LOCAL JUMP LOCATION
Sprite_CheckIfLifted:
{
    LDA.b $11 : ORA.b $3C : ORA.w $0FC1 : BNE .return
        LDA.b $EE : CMP.w $0F20, X : BNE .return
            LDY.b #$0F
        
            .next_sprite
            
                ; See if any enemies are in Link's hands:
                ; yes, an enemy is being held.
                LDA.w $0DD0, X : CMP.b #$0A : BEQ .return 
            DEY : BPL .next_sprite
                
            ; Ths bombs we speak of are enemy bombs, not Link's bombs.
            LDA.w $0E20, X : CMP.b #$0B : BEQ .is_chicken_or_bomb
                             CMP.b #$4A : BEQ .is_chicken_or_bomb
                ; Return if the sprite's velocity is nonzero.
                LDA.w $0D50, X : ORA.w $0D40, X : BNE .return
            
            .is_chicken_or_bomb

            ; Bleeds into the next function.
}


; $037257-$0372A9 LOCAL JUMP LOCATION
Sprite_CheckIfLiftedPermissive:
{ 
    LDA.w $0372 : BNE .return
        ; Check if the current sprite is the same one Link is touching.
        LDA.w $02F4 : DEC : CMP.w $0FA0 : BEQ .player_picks_up_sprite
            ; Set up player's hit box.
            JSR.w Player_SetupHitBox
            JSR.w Sprite_SetupHitBox
                        
             JSR.w Utility_CheckIfHitBoxesOverlap : BCC .return
                TXA : INC : STA.w $0314
                            STA.w $0FB2
                            
                RTS
            
        .player_picks_up_sprite
            
        STZ.b $F6
                
        STZ.w $0E90, X
                
        ; Play pick up object sound.
        LDA.b #$1D
        JSL.l Sound_SetSfx2PanLong
                
        LDA.w $0DD0, X : STA.l $7FFA2C, X
                
        LDA.b #$0A : STA.w $0DD0, X
        LDA.b #$10 : STA.w $0DF0, X
                
        LDA.b #$00 : STA.l $7FFA1C, X
                     STA.l $7FF9C2, X
                
        JSR.w Sprite_DirectionToFacePlayer
                
        LDA.w Sprite_ToLink_Directions_opposing, Y : STA.b $2F
                
        PLA : PLA
    
    .return
    
    RTS
}

; ==============================================================================

; $0372AA-$0372B3 LONG JUMP LOCATION
Sprite_CheckDamageFromPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckDamageFromPlayer : TAY
    
    PLB
    
    TYA
    
    RTL
}

; ==============================================================================

; $0372B4-$0373C9 LOCAL JUMP LOCATION
Sprite_CheckDamageFromPlayer:
{
    LDA.w $0EF0, X : AND.b #$80 : BNE .just_began_death_sequence
        LDA.b $EE : CMP.w $0F20, X
    
    ; (no there is nothing missing here)
    .just_began_death_sequence
    
    BNE .no_collision
        LDA.b $44 : CMP.b #$80 : BEQ .no_collision
            JSR.w Player_SetupActionHitBox
            JSR.w Sprite_SetupHitBox
            
            JSR.w Utility_CheckIfHitBoxesOverlap : BCC .no_collision
                STZ.w $0047
                
                LDA.w $037A : AND.b #$10 : BNE Sprite_CheckIfLifted_return
                    ; Is Link using the hammer or an item that's not in the
                    ; game?
                    LDA.w $0301 : AND.b #$0A : BEQ .not_frozen_kill
                        ; Can't kill Ganon with a hammer.
                        LDA.w $0E20, X : CMP.b #$D6 : BCS .no_collision
                            ; Is the enemy frozen?
                            LDA.w $0DD0, X : CMP #$0B : BNE .not_frozen_kill
                                LDA.l $7FFA3C, X : BEQ .not_frozen_kill
                                    ; I guess this puts it into poofing mode
                                    ; (when a frozen enemy gets hit by the
                                    ; hammer... or apparently an arrow??, it
                                    ; puts them into a special mode where
                                    ; they're more likely to yield magic
                                    ; decanters.)
                                    LDA.b #$02 : STA.w $0DD0, X
                                    
                                    LDA.b #$20 : STA.w $0DF0, X
                                    
                                    LDA.w $0E40, X : AND.b #$E0 : ORA.b #$03 : STA.w $0E40, X
                                    
                                    LDA.b #$1F
                                    JSL.l Sound_SetSfx2PanLong
                                    
                                    SEC
                                    
                                    RTS
                    
                    .not_frozen_kill
                    
                    ; Is it an Agahnim energy blast? (not a dud).
                    LDA.w $0E20, X : CMP.b #$7B : BNE .not_agahnim_ball
                        LDA.b $3C : CMP.b #$09 : BMI .spin_attack_charging
        
    .no_collision
    
    JMP.w .no_collision_part_deux
    
    .spin_attack_charging
    
    JMP.w .sorry_youre_not_special
    
    .is_baby_helmasaur
    
    LDY.w $0DE0, X
    
    LDA.b $2F : CMP.w Sprite_ToLink_Directions_opposing2, Y : BNE .direction_mismatch
        .is_flying_stalfos_head
        
        JSR.w .with_recoil
        
        STZ.w $0EF0, X
        
        JSR.w Player_PlaceRepulseSpark

        JMP.w .ExitWith00

    .direction_mismatch
  
    ; $03733D ALTERNATE ENTRY POINT
    .with_recoil

    .is_hardhat_bettle
    
    JSR.w Sprite_AttemptZapDamage
    
    LDA.b #$20
    JSR.w Sprite_ApplyRecoilToPlayer
    
    LDA.b #$10 : STA.b $47
                 STA.b $46
    
    JMP.w .ExitWith00
    
    .not_agahnim_ball
    
    CMP.b #$09 : BNE .not_giant_moldorm
        LDA.w $0D90, X : BNE .sorry_youre_not_special
            JSR.w Sprite_RecoilLinkAndTHUMP
            
            ; I don't think this would play a sound at all, actually...
            LDA.b #$32
            JSL.l Sound_SetSfxPan : STA.w $012F
            
            JMP.w .place_tink
    
    .not_giant_moldorm
    
    CMP.b #$92 : BNE .not_helmasaur_king
        JMP.w KingHelmasaur_ApplyRecoilIfEarlyPhase
    
    .not_helmasaur_king
    
    CMP.b #$26 : BEQ .is_hardhat_bettle
        CMP.b #$13 : BEQ .is_baby_helmasaur
            CMP.b #$02 : BEQ .is_flying_stalfos_head
                CMP.b #$CB : BEQ .certain_bosses
                CMP.b #$CD : BEQ .certain_bosses
                CMP.b #$CC : BEQ .certain_bosses
                CMP.b #$D6 : BEQ .certain_bosses
                CMP.b #$D7 : BEQ .certain_bosses
                CMP.b #$CE : BEQ .certain_bosses
                    CMP.b #$54 : BNE .sorry_youre_not_special
                    
                ; $037395 ALTERNATE ENTRY POINT
                .certain_bosses
                    
                LDA.b #$20
                JSR.w Sprite_ApplyRecoilToPlayer
                    
                LDA.b #$90 : STA.b $47
                LDA.b #$10 : STA.b $46
                
                ; $0373A2 ALTERNATE ENTRY POINT
                .sorry_youre_not_special
                
                LDA.w $0CAA, X : AND.b #$04 : BNE .okay_maybe_you_are
                    JSR.w Sprite_AttemptZapDamage
                    
                    SEC
                    
                    BRA .ExitWith00
                    
                    .no_collision_part_deux
                    
                    CLC
                    
                    BRA .ExitWith00
                
                ; $0373B2 ALTERNATE ENTRY POINT
                .okay_maybe_you_are
                
                LDA.b $47 : BNE .place_tink
                    LDA.b #$04
                    JSR.w Sprite_ApplyRecoilToPlayer
                    
                    LDA.b #$10 : STA.b $46
                    LDA.b #$10 : STA.b $47
                    
                ; $0373C3 ALTERNATE ENTRY POINT
                .place_tink
                
                JSR.w Player_PlaceRepulseSpark
                
                SEC
                
                ; $0373C7 ALTERNATE ENTRY POINT
                .ExitWith00
                
                LDA.b #$00
                
                RTS
}

; ==============================================================================

; $0373CA-$0373DA JUMP LOCATION
Sprite_StaggeredCheckDamageToPlayerPlusRecoil:
{
    TXA : EOR.b $1A : LSR : BCS Sprite_AttemptDamageToPlayerPlusRecoil_dont_damage_player
        JSR.w Sprite_DoHitboxesFast
        JSR.w Player_SetupHitBox
        
        JSR.w Utility_CheckIfHitBoxesOverlap
        BCS Sprite_AttemptDamageToPlayerPlusRecoil_dont_damage_player
            ; Bleeds into the next function.
}

; $0373DB-$03741E JUMP LOCATION
Sprite_AttemptDamageToPlayerPlusRecoil:
{
    LDA.w $031F : ORA.w $037B : BNE .dont_damage_player
        LDA.b #$13 : STA.b $46
                
        LDA.b #$18
        JSR.w Sprite_ApplyRecoilToPlayer
                
        LDA.b #$01 : STA.b $4D
                
        ; Determine damage for Link based on his armor value.
        LDA.w $0CD2, X : AND.b #$0F : STA.b $00
        ASL : ADC.b $00 : CLC : ADC.l $7EF35B : TAY
        LDA.w Bump_Damage_Table, Y : STA.w $0373
                
        LDA.w $0E20, X : CMP.b #$61 : BNE .not_beamos_laser
            LDA.w $0DB0, X : BEQ .not_beamos_laser
                ; Double the recoil amount to the player for the beamos
                ; laser beam.
                LDA.w $0D50, X : ASL : STA.b $28
                        
                LDA.w $0D40, X : ASL : STA.b $27
                
        .not_beamos_laser

    ; $03741E ALTERNATE ENTRY POINT
    .dont_damage_player
    
    RTS
}

; ==============================================================================

; $03741F-$037426 LONG JUMP LOCATION
Sprite_AttemptDamageToPlayerPlusRecoilLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_AttemptDamageToPlayerPlusRecoil
    
    PLB
    
    RTL
}

; ==============================================================================

; 1 of 3 values based on link's armour value and $0CD2, X.
; $037427-$037444 DATA
Bump_Damage_Table:
{
    db $02, $01, $01
    db $04, $04, $04
    db $00, $00, $00
    db $08, $04, $02
    db $08, $08, $08
    db $10, $08, $04
    db $20, $10, $08
    db $20, $18, $10
    db $18, $10, $08
    db $40, $30, $18
}

; ==============================================================================

; $037445-$03745F LOCAL JUMP LOCATION
Sprite_RecoilLinkAndTHUMP:
{
    LDA.b #$30
    JSR.w Sprite_ApplyRecoilToPlayer
    
    LDA.b #$90 : STA.b $47
    LDA.b #$10 : STA.b $46
    
    LDA.b #$21
    JSL.l Sound_SetSfx2PanLong
    
    LDA.b #$30 : STA.w $0E00, X
    
    JMP.w Sprite_CheckDamageFromPlayer_ExitWith00
}

; $037460-$03746C LOCAL JUMP LOCATION
KingHelmasaur_ApplyRecoilIfEarlyPhase:
{
    LDA.w $0DB0, X : CMP #$03 : BCS .do_recoil
        JMP.w Sprite_CheckDamageFromPlayer_okay_maybe_you_are
    
    .do_recoil
    
    JMP.w Sprite_CheckDamageFromPlayer_certain_bosses
}

; $03746D-$03757D DATA
Pool_ActionHitbox:
{
    ; $03746D
    .offset_x
    db   0 ; Net/hammer

    db   2 ; Up
    db   0 ; Up
    db   0 ; Up
    db  -8 ; Up
    db   0 ; Up
    db   2 ; Up
    db   0 ; Up
    db   2 ; Up
    db   2 ; Up
    db   1 ; Up
    db   1 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up

    db   2 ; Down
    db   4 ; Down
    db   4 ; Down
    db   0 ; Down
    db   0 ; Down
    db  -4 ; Down
    db  -4 ; Down
    db  -6 ; Down
    db   2 ; Down
    db   1 ; Down
    db   1 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down

    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   2 ; Left
    db   2 ; Left
    db   4 ; Left
    db   4 ; Left
    db   2 ; Left
    db   2 ; Left
    db   2 ; Left
    db   2 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left

    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db  -4 ; Right
    db  -4 ; Right
    db -10 ; Right
    db   0 ; Right
    db   2 ; Right
    db   2 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right

    ; $0374AE
    .size_x
    db  15 ; Net/hammer

    db   4 ; Up
    db   8 ; Up
    db   8 ; Up
    db   8 ; Up
    db   8 ; Up
    db  12 ; Up
    db   8 ; Up
    db   4 ; Up
    db   4 ; Up
    db   6 ; Up
    db   6 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up

    db   4 ; Down
    db  16 ; Down
    db  12 ; Down
    db   8 ; Down
    db   8 ; Down
    db  12 ; Down
    db  11 ; Down
    db  12 ; Down
    db   4 ; Down
    db   6 ; Down
    db   6 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down

    db   8 ; Left
    db   8 ; Left
    db   8 ; Left
    db  10 ; Left
    db  14 ; Left
    db  15 ; Left
    db   4 ; Left
    db   4 ; Left
    db   4 ; Left
    db   6 ; Left
    db   6 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left

    db   8 ; Right
    db   8 ; Right
    db   8 ; Right
    db  10 ; Right
    db  14 ; Right
    db  15 ; Right
    db   4 ; Right
    db   4 ; Right
    db   4 ; Right
    db   6 ; Right
    db   6 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    
    ; $0374EF
    .offset_y
    db   0 ; Net/hammer

    db   2 ; Up
    db   0 ; Up
    db   2 ; Up
    db   4 ; Up
    db   4 ; Up
    db   4 ; Up
    db   7 ; Up
    db   2 ; Up
    db   2 ; Up
    db   1 ; Up
    db   1 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up

    db   2 ; Down
    db   0 ; Down
    db   2 ; Down
    db  -4 ; Down
    db  -3 ; Down
    db  -8 ; Down
    db   0 ; Down
    db   0 ; Down
    db   2 ; Down
    db   1 ; Down
    db   1 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down

    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db  -2 ; Left
    db   0 ; Left
    db  -4 ; Left
    db   1 ; Left
    db   2 ; Left
    db   2 ; Left
    db   1 ; Left
    db   1 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left

    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db  -2 ; Right
    db   0 ; Right
    db  -4 ; Right
    db   1 ; Right
    db   2 ; Right
    db   2 ; Right
    db   1 ; Right
    db   1 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right

    ; $037530
    .size_y
    db  15 ; Net/hammer

    db   4 ; Up
    db   8 ; Up
    db   2 ; Up
    db  12 ; Up
    db   8 ; Up
    db  12 ; Up
    db   8 ; Up
    db   4 ; Up
    db   4 ; Up
    db   6 ; Up
    db   6 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up
    db   0 ; Up

    db   4 ; Down
    db   8 ; Down
    db   4 ; Down
    db  12 ; Down
    db  12 ; Down
    db  12 ; Down
    db   4 ; Down
    db   8 ; Down
    db   4 ; Down
    db   6 ; Down
    db   4 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down
    db   0 ; Down

    db   8 ; Left
    db   8 ; Left
    db   8 ; Left
    db   8 ; Left
    db   8 ; Left
    db  12 ; Left
    db   4 ; Left
    db   4 ; Left
    db   4 ; Left
    db   6 ; Left
    db   6 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left
    db   0 ; Left

    db   8 ; Right
    db   8 ; Right
    db   8 ; Right
    db   8 ; Right
    db   8 ; Right
    db  12 ; Right
    db   4 ; Right
    db   4 ; Right
    db   4 ; Right
    db   6 ; Right
    db   6 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right
    db   0 ; Right

    ; $037571
    .sword_validity
    db $01
    db $01
    db $01
    db $00
    db $00
    db $00
    db $00
    db $01
    db $01
    db $00
    db $00
    db $01
    db $01
}
    
; ==============================================================================

; $03757E-$037585 LONG JUMP LOCATION
Player_SetupActionHitBoxLong:
{
    PHB : PHK : PLB
    
    JSR.w Player_SetupActionHitBox
    
    PLB
    
    RTL
}

; ==============================================================================

; $037586-$037593 DATA
Pool_SetupActionHitbox_dashing:
{
    ; $037586
    .offset_y_high ; Bleeds into the next data block.
    db  -1,   0

    ; $037588
    .offset_x_low
    db   0,   0,  -8,   8

    ; $03758C
    .offset_x_high
    db   0,   0,  -1,   0

    ; $037590
    .offset_y_low
    db  -8,  16,   8,   8
}

; $037594-$0375DF LOCAL JUMP LOCATION
SetupActionHitbox_spinning:
{
    LDA.b $22 : SEC : SBC.b #$0E : STA.b $00
    LDA.b $23 :       SBC.b #$00 : STA.b $08
    
    LDA.b $20 : SEC : SBC.b #$0A : STA.b $01
    LDA.b $21 :       SBC.b #$00 : STA.b $09
    
    LDA.b #$2C : STA.b $02
    INC        : STA.b $03
    
    PLX
    
    RTS
}

; $0375B7-$0375DF LOCAL JUMP LOCATION
SetupActionHitbox_dashing:
{
    LDA.b $2F : LSR : TAY
    
    LDA.b $22
    CLC : ADC.w Pool_SetupActionHitbox_dashing_offset_x_low, Y  : STA.b $00

    LDA.b $23
          ADC.w Pool_SetupActionHitbox_dashing_offset_x_high, Y : STA.b $08
    
    LDA.b $20
    CLC : ADC.w Pool_SetupActionHitbox_dashing_offset_y_low, Y  : STA.b $01

    LDA.b $21
          ADC.w Pool_SetupActionHitbox_dashing_offset_y_high, Y : STA.b $09
    
    LDA.b #$10 : STA.b $02 : STA.b $03
    
    RTS
}

; ==============================================================================

; $0375E0-$037644 LOCAL JUMP LOCATION
Player_SetupActionHitBox:
{
    LDA.w $0372 : BNE SetupActionHitbox_dashing
        PHX
        
        LDX.b #$00
        
        LDA.w $0301 : AND.b #$0A : BNE .special_pose
            LDA.w $037A : AND.b #$10 : BNE .special_pose
                LDY.b $3C : BMI .spin_attack_hit_box
                    LDA.w Pool_ActionHitbox_sword_validity, Y : BNE .return
                        ; Adding $3C seems to be for the pokey player hit box
                        ; with the swordy.
                        LDA.b $2F : ASL #3 : CLC : ADC.b $3C : TAX
                        
                        INX
        
        .special_pose
        
        LDY.b #$00
        
        LDA.b $45 : CLC : ADC.w Pool_ActionHitbox_offset_x, X : BPL .positive
            DEY
        
        .positive
        
            CLC : ADC.b $22 : STA.b $00
        TYA : ADC.b $23 : STA.b $08
        
        LDY.b #$00
        
        LDA.b $44 : CLC : ADC.w Pool_ActionHitbox_offset_y, X : BPL .positive_2
            DEY
        
        .positive_2
        
              ADC.b $20 : STA.b $01
        TYA : ADC.b $21 : STA.b $09
        
        ; Widths of the colision boxes for player.
        LDA.w Pool_ActionHitbox_size_x, X : STA.b $02
        LDA.w Pool_ActionHitbox_size_y, X : STA.b $03
        
        PLX
        
        RTS
        
        .return
        
        LDA.b #$80 : STA.b $08
        
        PLX
        
        RTS
}

; ==============================================================================

; $037645-$037687 LOCAL JUMP LOCATION
Sprite_DoHitboxesFast:
{
    LDY.b #$00
    
    LDA.w $0FAB : CMP.b #$80 : BEQ .BRANCH_ALPHA
        CMP.b #$00 : BPL .BRANCH_BETA
            DEY
        
        .BRANCH_BETA
        
        CLC : ADC.w $0D10, X : STA.b $04
        TYA : ADC.w $0D30, X : STA.b $0A
        
        LDY.b #$00
        
        LDA.w $0FAA : BPL .BRANCH_GAMMA
            DEY
        
        .BRANCH_GAMMA
        
            CLC : ADC.w $0D00, X : STA.b $05
        TYA : ADC.w $0D20, X : STA.b $0B
        
        LDA.b #$03
        
        LDY.w $0E20, X : CPY.b #$6A : BNE .BRANCH_DELTA
            LDA.b #$10
        
        .BRANCH_DELTA
        
        STA.b $06 : STA.b $07
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$80 : STA.b $0A
    
    RTS
}

; ==============================================================================

; $037688-$03769E LOCAL JUMP LOCATION
Sprite_ApplyRecoilToPlayer:
{
    PHA
    
    JSR.w Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : STA.b $27
    LDA.b $01 : STA.b $28
    
    PLA : LSR : STA.b $29
                STA.b $C7
    
    STZ.b $24
    STZ.b $25
    
    RTS
}

; ==============================================================================

; $03769F-$0376C9 LOCAL JUMP LOCATION
Player_PlaceRepulseSpark:
{
    LDA.w $0FAC : BNE .respulse_spark_already_active
        LDA.b #$05 : STA.w $0FAC
        
        LDA.w $0022 : ADC.w $0045 : STA.w $0FAD
        LDA.w $0020 : ADC.w $0044 : STA.w $0FAE
        
        LDA.b $EE : STA.w $0B68
        
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ; Make "clink" against wall noise.
        ORA.b #$05 : STA.w $012E
    
    .respulse_spark_already_active
    
    RTS
}

; ==============================================================================

; $0376CA-$037704 LONG JUMP LOCATION
Sprite_PlaceRupulseSpark:
{
    LDA.w $0FAC : BNE .dont_place
        LDA.b #$05 : JSL.l Sound_SetSfx2PanLong
        
        ; NOTE: This entry point ignores whether there is already a repulse
        ; spark active (as there's only one slot for it, this would erase the
        ; old one).
        ; $0376D5 ALTERNATE ENTRY POINT
        .coerce
        
        ; OPTIMIZE: WTF: Broken check?
        LDA.w $0D10, X : CMP.b $E2

        LDA.w $0D30, X : SBC.b $E3 : BNE .off_screen
            LDA.w $0D00, X : CMP.b $E8
            LDA.w $0D20, X : SBC.b $E9 : BNE .off_screen
                LDA.w $0D10, X : STA.w $0FAD
                LDA.w $0D00, X : STA.w $0FAE
                
                LDA.b #$05 : STA.w $0FAC
                
                LDA.w $0F20, X : STA.w $0B68
        
        .off_screen
    .dont_place
    
    RTL
}

; ==============================================================================

; $037705-$03772E LOCAL JUMP LOCATION
Player_SetupHitBox:
{
    LDA.w $037B : BNE .no_player_interaction_with_sprites
        ; $03770A ALTERNATE ENTRY POINT
        .ignoreImmunity
        
        LDA.b #$08 : STA.b $02
                     STA.b $03
        
        LDA.b $22 : CLC : ADC.b #$04 : STA.b $00
        LDA.b $23 :       ADC.b #$00 : STA.b $08
        
        LDA.b $20 : ADC.b #$08 : STA.b $01
        LDA.b $21 : ADC.b #$00 : STA.b $09
        
        RTS
    
    .no_player_interaction_with_sprites
    
    ; WTF: Kind of .... lazy if you ask me. This ensures that the player hit
    ; box is so out of range of whatever we're going to compare with so that
    ; the hit boxes can't possibly overlap.
    ; (with a Y coordinate of 0x8000 to 0x80ff, it's highly unlikely).
    LDA.b #$80 : STA.b $09
    
    RTS
}

; ==============================================================================

; $03772F-$0377EE DATA
Pool_Sprite_SetupHitBox:
{
    ; $03772F
    .x_offsets_low
    db   2,   3,   0,  -3,  -6,   0,   2,  -8
    db   0,  -4,  -8,   0,  -8, -16,   2,   2
    
    db   2,   2,   2,  -8,   2,   2, -16,  -8
    db -12,   4,  -4, -12,   5, -32,  -2,   4
    
    ; $03774F
    .x_offsets_high
    db  0,  0,  0, -1, -1,  0,  0, -1
    db  0, -1, -1,  0, -1, -1,  0,  0
    
    db  0,  0,  0, -1,  0,  0, -1, -1
    db -1,  0, -1, -1,  0, -1, -1,  0
    
    ; $03776F
    .width
    db  12,   1,  16,  20,  20,   8,   4,  32
    db  48,  24,  32,  32,  32,  48,  12,  12
    
    db  60, 124,  12,  32,   4,  12,  48,  32
    db  40,   8,  24,  24,   5,  80,   4,   8
    
    ; $03778F
    .y_offsets_low
    db   0,   3,   4,  -4,  -8,   2,   0, -16
    db  12,  -4,  -8,   0, -10, -16,   2,   2
    
    db   2,   2,  -3, -12,   2,  10,   0, -12
    db  16,   4,  -4, -12,   3, -16,  -8,  10
    
    ; $0377AF
    .y_offsets_high
    db 0,  0,  0, -1, -1,  0,  0, -1
    db 0, -1, -1,  0, -1, -1,  0,  0
    
    db 0,  0, -1, -1,  0,  0,  0, -1
    db 0,  0, -1, -1,  0, -1, -1,  0
    
    ; $0377CF
    .height
    db  14,   1,  16,  21,  24,   4,   8,  40
    db  20,  24,  40,  29,  36,  48,  60, 124
    
    db  12,  12,  17,  28,   4,   2,  28,  20
    db  10,   4,  24,  16,   5,  48,   8,  12
}

; $0377EF-$037835 LOCAL JUMP LOCATION
Sprite_SetupHitBox:
{
    ; Check the height value of the sprite.
    LDA.w $0F70, X : BMI .out_of_view
        PHY
        
        ; Get the index for the sprite's hit detection box.
        LDA.w $0F60, X : AND.b #$1F : TAY
        
        ; Add an offset to the sprites X pos (lower byte)
        ; Store an offset X pos (high byte) to $0A.
        LDA.w $0D10, X : CLC : ADC .x_offsets_low,  Y : STA.b $04
        LDA.w $0D30, X :       ADC .x_offsets_high, Y : STA.b $0A
        
        LDA.w $0D00, X : CLC : ADC .y_offsets_low, Y  : PHP
                         SEC : SBC.w $0F70, X         : STA.b $05

        LDA.w $0D20, X :       SBC.b #$00             : PLP
                               ADC .y_offsets_high, Y : STA.b $0B
        
        ; Box widths.
        LDA.w .width, Y : STA.b $06

        ; Box heights.
        LDA.w .height, Y : STA.b $07
        
        PLY
        
        RTS
    
    .out_of_view
    
    LDA.b #$80 : STA.b $0A
    
    RTS
}

; ==============================================================================

; Returns carry clear if there was no overlap.
; $037836-$037863 LOCAL JUMP LOCATION
Utility_CheckIfHitBoxesOverlap:
{
    !pos1_low  = $00
    !pos1_size = $02
    !pos2_low  = $04
    !pos2_size = $06
    !pos1_high = $08
    !pos2_high = $0A
    
    !ans_low   = $0F
    !ans_high  = $0C
    
    PHX
    
    LDX.b #$01
    
    .check_other_direction
    
        ; Delta p low goes to the stack...
        ; Delta p high goes to $0C...
        ; Delta p + width of p2 goes to $0F...
        ; Delta p low + 0x80
              LDA.b !pos2_low, X  : SEC : SBC.b !pos1_low, X  : PHA
        PHP                       : CLC : ADC.b !pos2_size, X : STA.b $0F
        PLP : LDA.b !pos2_high, X :       SBC.b !pos1_high, X : STA.b $0C
        
        ; Wasn't clear at first, but the the purpose of this is to filter out
        ; delta p's [in 16-bit] that are smaller than -0x0080, and larger then
        ; 0x007F. Since the sizes (width and height) are only specified
        ; as 8-bit, perhaps that's the reason for this restriction.
        PLA                      : CLC : ADC.b #$80
        
        LDA.b $0C : ADC.b #$00 : BNE .out_of_range
        
        LDA.b !pos1_size, X : CLC : ADC.b !pos2_size, X : CMP.b $0F : BCC .not_overlapping
    DEX : BPL .check_other_direction
    
    .out_of_range
    .not_overlapping
    
    PLX
    
    RTS
}

; ==============================================================================

; $037864-$03786B LONG JUMP LOCATION
Sprite_OAM_AllocateDeferToPlayerLong:
{
    PHB : PHK : PLB
    
    JSR.w OAM_AllocateDeferToPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; This routine in general checks the sprite's proximity to the player, and if
; he's close enough, it will alter the OAM allocation region for the sprite.
; $03786C-$0378A1 LOCAL JUMP LOCATION
OAM_AllocateDeferToPlayer:
{
    ; Is the sprite on the same floor as the player?
    LDA.w $0F20, X : CMP.b $EE : BNE .return
        JSR.w Sprite_IsToRightOfPlayer
        
        ; Proceed only if the difference between the sprite's X coordinate
        ; and player's satisfies : [ -16 <= dX < 16 ].
        LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .return
            JSR.w Sprite_IsBelowPlayer
            
            ; Proceed if the difference in the Y coordinates satisfies:
            ; [ -32 <= dY < 40 ]
            LDA.b $0E : CLC : ADC.b #$20 : CMP.b #$48 : BCS .return
                LDA.w $0E40, X : AND.b #$1F : INC : ASL : ASL
                
                ; The sprite will request a different OAM range
                ; depending on player's relative position.
                CPY.b #$00 : BEQ .linkIsLower
                    JSL.l OAM_AllocateFromRegionC
                    
                    BRA .return
        
                .linkIsLower
        
                JSL.l OAM_AllocateFromRegionB
        
    .return
    
    RTS
}

; ==============================================================================

; Death routine for sprites (bushes and grass are exceptions)
; $0378A2-$037916 LOCAL JUMP LOCATION
SpriteDeath_Main:
{
    LDA.w $0E20, X : CMP.b #$EC : BNE .notBushOrGrass
        JSR.w ThrowableScenery_ScatterIntoDebris
        
        RTS
    
    .notBushOrGrass
    
    ; Armos Knight, Lanmolas, Helmasaur King.
    CMP.b #$53 : BEQ .draw_normally
    CMP.b #$54 : BEQ .draw_normally
    CMP.b #$92 : BEQ .draw_normally
        ; Red Bomb soldier?
        CMP.b #$4A : BNE .notBombSoldier
            LDA.w $0DB0, X : CMP.b #$02 : BCS .draw_normally
        
        .notBombSoldier
        
        LDA.w $0DF0, X : BEQ Sprite_DoTheDeath
            ; $0378C9 ALTERNATE ENTRY POINT
            .kyameron_respawn
            
            LDA.w $0E60, X : BMI .draw_normally
                LDA.b $1A : AND.b #$03 : ORA.b $11 : ORA.w $0FC1 : BNE .delay_finality
                    INC.w $0DF0, X
                
                .delay_finality
                
                JSR.w SpriteDeath_DrawPerishingOverlay
                
                LDA.w $0E20, X : CMP.b #$40 : BEQ .is_evil_barrier
                    LDA.w $0DF0, X : CMP.b #$0A : BCC .stop_drawing_sprite
                
                .is_evil_barrier
                
                REP #$20
                
                LDA.b $90 : CLC : ADC.w #$0010 : STA.b $90
                LDA.b $92 : CLC : ADC.w #$0004 : STA.b $92
                
                SEP #$20
                
                LDA.w $0E40, X   : PHA
                SEC : SBC.b #$04 : STA.w $0E40, X
                
                JSR.w SpriteActive_Main
                
                PLA : STA.w $0E40, X
                
                .stop_drawing_sprite
                
                RTS
    
    .draw_normally
    
    JSR.w SpriteActive_Main
    
    RTS
}

; ==============================================================================

; $037917-$03791E LONG JUMP LOCATION
Sprite_DoTheDeath_long:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_DoTheDeath
    
    PLB
    
    RTL
}

; ==============================================================================

; $03791F-$037922 DATA
Sprite_DoTheDeath_pikit_drop_items:
{
    db $DC ; SPRITE DC - 1 bomb
    db $E1 ; SPRITE E1 - 1 arrow
    db $D9 ; SPRITE D9 - 1 rupee
    db $E6 ; SPRITE E6 - 1 shield
}

; $037923-$037A53 LOCAL JUMP LOCATION
Sprite_DoTheDeath:
{
    ; Is it a Vitreous small eyeball?
    LDA.w $0E20, X : CMP.b #$BE : BNE .not_small_vitreous_eyeball
        ; HARDCODED: This is how Vitreous knows whether to come out of his
        ; slime pool.
        DEC.w $0ED0
    
    .not_small_vitreous_eyeball
    
    ; Is it a Pikit?
    CMP #$AA : BNE .not_a_pikit
        LDY.w $0E90, X : BEQ .BRANCH_BETA
            LDA.w .pikit_drop_items-1, Y
            
            LDY.w $0E30, X : PHY
            
            JSR.w Sprite_DoTheDeath_PrepareEnemyDrop
            
            PLA : STA.w $0E30, X
            DEC : BNE .BRANCH_GAMMA
                LDA.b #$09 : STA.w $0F50, X
                LDA.b #$F0 : STA.w $0E60, X
            
            .BRANCH_GAMMA
            
            INC.w $0EB0, X
            
            RTS

        .BRANCH_BETA
    .not_a_pikit
    
    ; Is it a crazy red spear soldier?
    LDA.w $0E20, X : CMP.b #$45 : BNE .BRANCH_DELTA
        ; If so, are we in the "first part" (on OW).
        LDA.l $7EF3C5 : CMP.b #$02 : BNE .BRANCH_DELTA
            LDA.w $040A : CMP.b #$18 : BNE .BRANCH_DELTA
                ; Resets the music in the village when the crazy green guards
                ; are killed.
                LDA.b #$07 : STA.w $012C
    
    .BRANCH_DELTA
    
    ; Does it have a drop item?
    LDY.w $0CBA, X : BEQ .BRANCH_EPSILON
        LDA.w $0BC0, X : STA.w $0E30, X
        
        LDA.b #$FF : STA.w $0BC0, X
        
        ; Small key.
        LDA.b #$E4
        
        CPY.b #$01 : BEQ PrepareEnemyDrop
            ; Big key.
            LDA.b #$E5
            
            CPY.b #$03 : BNE PrepareEnemyDrop
                ; Green rupee.
                LDA.b #$D9
                
                BRA PrepareEnemyDrop
    
    .BRANCH_EPSILON
    
    ; Determine prize packs...
    LDA.w $0BE0, X : AND.b #$0F : BEQ .BRANCH_THETA
        DEC : PHA
        
        ; Check luck status:
        ; If no special luck, proceed as normal.
        LDY.w $0CF9 : BEQ .notLucky
            ; Increase lucky (or unlucky) drop counter
            ; Once we reach 10 drops of a type we reset luck.
            INC.w $0CFA
            LDA.w $0CFA : CMP.b #$0A : BCC .dontResetLuck
                STZ.w $0CF9 ; Reset luck. (per above)
            
            .dontResetLuck
            
            PLA
            
            ; Is it great luck? If so, guarantee a prize drop.
            CPY.b #$01 : BEQ .good_drop_luck
    
    .BRANCH_THETA
    
    BRA .BRANCH_MU ; Otherwise Luck is 2 and failure is guaranteed.
    
    ; How prize packs normally drop.
    .notLucky
    
    ; Reload the prize pack #.
    JSL.l GetRandomInt : PLY : AND.w PrizePack_Chance, Y : BNE .BRANCH_MU
        ; $0379BC ALTERNATE ENTRY POINT
        .ForcePrizeDrop
        
        TYA ; Transfer prize number to A register.
        
        .good_drop_luck ; If this is branched to, the prize is guaranteed.
        
        ASL #3 : ORA.w $0FC7, Y : PHA
        
        LDA.w $0FC7, Y : INC : AND.b #$07 : STA.w $0FC7, Y
        
        PLY
        LDA.w PrizePack_Prizes_pack_1, Y
        
        ; $0379D1 ALTERNATE ENTRY POINT
        .PrepareEnemyDrop
        
        ; Is the sprite we've dropped a big key?
        STA.w $0E20, X : CMP.b #$E5 : BNE .BRANCH_NU
            JSR.w SpritePrep_LoadBigKeyGfx
            
            BRA .BRANCH_XI
        
        .BRANCH_NU
        
        ; Is it a normal key?
        CMP.b #$E4 : BNE .BRANCH_XI
            JSR.w SpritePrep_Key.set_item_drop
        
        .BRANCH_XI
        
        LDA.b #$09 : STA.w $0DD0, X
        
        LDA.w $0F70, X : PHA
        
        JSL.l Sprite_LoadProperties
        
        INC.w $0BA0, X
        
        LDY.w $0E20, X
        
        ; TODO: Investigate why this is -$D9.
        LDA.w ItemDropBounceProps-$D9, Y : PHA
        
        AND.b #$F0 : STA.w $0F80, X
        
        PLA : AND.b #$0F : CLC : ADC.w $0D10, X : STA.w $0D10, X
        LDA.w $0D30, X         : ADC.b #$00     : STA.w $0D30, X
        
        PLA : STA.w $0F70, X
        
        LDA.b #$15 : STA.w $0F10, X
        LDA.b #$FF : STA.w $0B58, X
        
        BRA .BRANCH_OMICRON
    
    .BRANCH_MU
    
    STZ.w $0DD0, X
    
    .BRANCH_OMICRON
    
    LDA.w $0E20, X : CMP.b #$A2 : BNE .not_kholdstare
        JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .anospawn_crystal
            LDA.b #$04 : JSL.l Sprite_SpawnFallingItem
        
        .anospawn_crystal
    .not_kholdstare
    
    JSL.l Dungeon_ManuallySetSpriteDeathFlag
    
    INC.w $0CFB
    
    LDA.w $0E20, X : CMP.b #$40 : BNE .not_evil_barrier
        LDA.b #$09 : STA.w $0DD0, X
        
        LDA.b #$04 : STA.w $0DC0, X
        
        JMP.w SpriteDeath_Main_kyameron_respawn
    
    .not_evil_barrier
    
    RTS
}

; ==============================================================================

; $037A54-$037A5B LONG JUMP LOCATION
ForcePrizeDrop_long:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_DoTheDeath_ForcePrizeDrop
    
    PLB
    
    RTL
}
; ==============================================================================

; This is using a mask system, 00 = 8/8 chances, 01 = 7/8 chances, 03 would be
; 6/8 etc...
; $037A5C-$037A63
PrizePack_Chance:
{
    db $01 ; Pack 1 :  50%
    db $01 ; Pack 2 :  50%
    db $01 ; Pack 3 :  50%
    db $00 ; Pack 4 : 100%
    db $01 ; Pack 5 :  50%
    db $01 ; Pack 6 :  50%
    db $01 ; Pack 7 :  50%
    db $00 ; Pack 8 : 100% - doesn't exist
}

; $037A64-$037A71
ItemDropBounceProps:
{
    db $24 ; GREEN RUPEE
    db $24 ; BLUE RUPEE
    db $24 ; RED RUPEE
    db $20 ; BOMB REFILL 1
    db $20 ; BOMB REFILL 4
    db $20 ; BOMB REFILL 8
    db $24 ; SMALL MAGIC DECANTER
    db $24 ; LARGE MAGIC DECANTER
    db $24 ; ARROW REFILL 5
    db $24 ; ARROW REFILL 10
    db $00 ; FAIRY
    db $24 ; SMALL KEY
    db $20 ; BIG KEY
    db $20 ; STOLEN SHIELD
}

; Wiki link for the prize pack as image:
; https://alttp-wiki.net/index.php/Enemy_prize_packs
; $037A72-$037AA9
PrizePack_Prizes:
{
    ; $037A72
    .pack_1
    db $D8 ; SPRITE D8 - heart
    db $D8 ; SPRITE D8 - heart
    db $D8 ; SPRITE D8 - heart
    db $D8 ; SPRITE D8 - heart
    db $D9 ; SPRITE D9 - green rupee
    db $D8 ; SPRITE D8 - heart
    db $D8 ; SPRITE D8 - heart
    db $D9 ; SPRITE D9 - green rupee

    ; $037A7A
    .pack_2
    db $DA ; SPRITE DA - blue rupee
    db $D9 ; SPRITE D9 - green rupee
    db $DA ; SPRITE DA - blue rupee
    db $DB ; SPRITE DB - red rupee
    db $DA ; SPRITE DA - blue rupee
    db $D9 ; SPRITE D9 - green rupee
    db $DA ; SPRITE DA - blue rupee
    db $DA ; SPRITE DA - blue rupee

    ; $037A82
    .pack_3
    db $E0 ; SPRITE E0 - full magic
    db $DF ; SPRITE DF - small magic
    db $DF ; SPRITE DF - small magic
    db $DA ; SPRITE DA - blue rupee
    db $E0 ; SPRITE E0 - full magic
    db $DF ; SPRITE DF - small magic
    db $D8 ; SPRITE D8 - heart
    db $DF ; SPRITE DF - small magic

    ; $037A8A
    .pack_4
    db $DC ; SPRITE DC - 1 bomb
    db $DC ; SPRITE DC - 1 bomb
    db $DC ; SPRITE DC - 1 bomb
    db $DD ; SPRITE DD - 4 bombs
    db $DC ; SPRITE DC - 1 bomb
    db $DC ; SPRITE DC - 1 bomb
    db $DE ; SPRITE DE - 8 bombs
    db $DC ; SPRITE DC - 1 bomb

    ; $037A92
    .pack_5
    db $E1 ; SPRITE E1 - 5 arrows
    db $D8 ; SPRITE D8 - heart
    db $E1 ; SPRITE E1 - 5 arrows
    db $E2 ; SPRITE E2 - 10 arrows
    db $E1 ; SPRITE E1 - 5 arrows
    db $D8 ; SPRITE D8 - heart
    db $E1 ; SPRITE E1 - 5 arrows
    db $E2 ; SPRITE E2 - 10 arrows

    ; $037A9A
    .pack_6
    db $DF ; SPRITE DF - small magic
    db $D9 ; SPRITE D9 - green rupee
    db $D8 ; SPRITE D8 - heart
    db $E1 ; SPRITE E1 - 5 arrows
    db $DF ; SPRITE DF - small magic
    db $DC ; SPRITE DC - 1 bomb
    db $D9 ; SPRITE D9 - green rupee
    db $D8 ; SPRITE D8 - heart

    ; $037AA2
    .pack_7
    db $D8 ; SPRITE D8 - heart
    db $E3 ; SPRITE E3 - fairy
    db $E0 ; SPRITE E0 - full magic
    db $DB ; SPRITE DB - red rupee
    db $DE ; SPRITE DE - 8 bombs
    db $D8 ; SPRITE D8 - heart
    db $DB ; SPRITE DB - red rupee
    db $E2 ; SPRITE E2 - 10 arrows
}

; ==============================================================================

; $037AAA-$037B29 DATA
Pool_SpriteDeath_DrawPoof:
{
    ; $037AAA
    .offset_x
    db   0,   0,   0,   8
    db   0,   8,   0,   8
    db   8,   8,   0,   8
    db   0,   8,   0,   8
    db   0,   8,   0,   8
    db   0,   8,   0,   8
    db  -3,  11,  -3,  11
    db  -6,  14,  -6,  14

    ; $037ACA
    .offset_y
    db   0,   0,   8,   8
    db   0,   0,   8,   8
    db   0,   0,   8,   8
    db   0,   0,   8,   8
    db   0,   0,   8,   8
    db   0,   0,   8,   8
    db  -3,  -3,  11,  11
    db  -6,  -6,  14,  14

    ; $037AEA
    .char
    db $00, $B9, $00, $00
    db $B4, $B5, $B5, $B4
    db $B9, $00, $00, $00
    db $B5, $B4, $B4, $B5
    db $A8, $A8, $B8, $B8
    db $A8, $A8, $B8, $B8
    db $A9, $A9, $A9, $A9
    db $9B, $9B, $9B, $9B

    ; $037B0A
    .prop
    db $04, $04, $04, $04
    db $04, $04, $C4, $C4
    db $44, $04, $04, $04
    db $44, $44, $84, $84
    db $04, $44, $04, $44
    db $04, $44, $04, $44
    db $44, $04, $C4, $84
    db $04, $44, $84, $C4
}

; $037B2A-$037B95 LOCAL JUMP LOCATION
SpriteDeath_DrawPerishingOverlay:
{
    LDA.w $046C : CMP.b #$04 : BNE .dont_use_super_priority
        LDA.b #$30 : STA.w $0B89, X
    
    .dont_use_super_priority
    
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0E60, X : AND.b #$20 : LSR #3 : STA.b $0C
    
    PHX
    
    LDA.b #$03 : STA.b $00
    
    LDA.w $0DF0, X : AND.b #$1C : EOR.b #$1C : CLC : ADC.b $00 : TAX
    
    .next_OAM_entry
    
        PHY
        
        LDA.w Pool_SpriteDeath_DrawPoof_char, X : BEQ .skip_entry
            INY : INY : STA.b ($90), Y

            LDA.w $0FA9 : SEC : SBC.b $0C
            CLC : ADC.w Pool_SpriteDeath_DrawPoof_offset_y, X
            DEY : STA.b ($90), Y

            LDA.w $0FA8 : SEC : SBC.b $0C
            CLC : ADC.w Pool_SpriteDeath_DrawPoof_offset_x, X
            DEY : STA.b ($90), Y

            LDA.b $05 : AND.b #$30 
            ORA.w Pool_SpriteDeath_DrawPoof_prop, X
            INY #3 : STA.b ($90), Y
        
        .skip_entry
        
        PLY : INY #4
        
        DEX
    DEC.b $00 : BPL .next_OAM_entry
    
    PLX
    
    LDY.b #$00
    LDA.b #$03
    JSR.w Sprite_CorrectOamEntries
    
    RTS
}

; ==============================================================================

; $037B96-$037BE9 DATA
Pool_SpriteModule_Fall2:
{
    ; $037B96
    .anim_step_a
    db $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0C
    db $0C, $0C, $0C, $0C, $03, $03, $03, $03
    db $03, $02, $02, $02, $02, $01, $01, $01
    db $01, $00, $00, $00, $00, $00, $00, $00

    ; $037BB6
    .anim_step_b
    db $05, $05, $05, $05, $05, $05, $05, $04
    db $04, $04, $04, $04, $03, $03, $03, $03
    db $03, $02, $02, $02, $02, $01, $01, $01
    db $01, $00, $00, $00, $00, $00, $00, $00

    ; $037BD6
    .frame_mask
    db $FF, $3F, $1F, $0F, $0F, $07, $03, $01
    db $FF, $3F, $1F, $0F, $07, $03, $01, $00

    ; $037BE6
    .head_data_offset
    db $00, $04, $08, $00
}

; $037BEA-$037CB6 JUMP LOCATION
SpriteCustomFall_Main:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        STZ.w $0DD0, X
        
        JSL.l Dungeon_ManuallySetSpriteDeathFlag
        
        RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$40 : BCC .BRANCH_BETA
        LDA.w $0F50, X : CMP.b #$05 : BNE .BRANCH_GAMMA
            LDA.b #$3F : STA.w $0DF0, X
            
            BRA .BRANCH_BETA
        
        .BRANCH_GAMMA
        
        LDA.w $0DF0, X : AND.b #$07 : ORA.b $11 : ORA.w $0FC1 : BNE .BRANCH_LAMBDA
            LDA.b #$31
            JSL.l Sound_SetSfx3PanLong
        
        .BRANCH_LAMBDA
        
        JSR.w SpriteActive_Main
        JSR.w Sprite_PrepOamCoord
        
        LDA.b $02 : SEC : SBC.b #$08 : STA.b $02
        LDA.b $03 : SEC : SBC.b #$00 : STA.b $03
        
        LDA.w $0DF0, X : CLC : ADC.b #$14 : STA.b $06
        
        JSL.l Sprite_CustomTimedDrawDistressMarker
        
        RTS
    
    .BRANCH_BETA
    
    CMP.b #$3D : BNE .BRANCH_DELTA
        PHA
        
        LDA.b #$20
        JSL.l Sound_SetSfx2PanLong
        
        PLA
    
    .BRANCH_DELTA
    
    LSR : TAY
    
    LDA.w $0E20, X
    
    CMP.b #$26 : BEQ .BRANCH_EPSILON
        CMP.b #$13 : BNE .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    LDA.w Pool_SpriteModule_Fall2_anim_step_b, Y : STA.w $0DC0, X
    
    JSR.w SpriteDraw_FallingHelmaBeetle
    
    BRA .BRANCH_THETA
    
    .BRANCH_ZETA
    
    LDA.w Pool_SpriteModule_Fall2_anim_step_a, Y : CMP.b #$0C : BCS .BRANCH_MU
        LDY.w $0DE0, X : CLC : ADC.w Pool_SpriteModule_Fall2_head_data_offset, Y
    
    .BRANCH_MU
    
    STA.w $0DC0, X
    
    JSR.w SpriteDraw_FallingHumanoid
    
    .BRANCH_THETA
    
    LDA.w $0DF0, X : LSR #3 : TAY
    LDA.b $1A : AND.w Pool_SpriteModule_Fall2_frame_mask, Y : ORA.b $11 : BNE .BRANCH_IOTA
        LDY.b #$68
        JSR.w Sprite_CheckTileProperty
        
        LDA.w $0FA5 : CMP.b #$20 : BEQ .BRANCH_KAPPA
            STZ.w $0F30, X
            STZ.w $0F40, X
        
        .BRANCH_KAPPA
        
        LDA.w $0F30, X : STA.w $0D40, X
        
        ASL : PHP
        ROR.w $0D40, X : PLP : ROR.w $0D40, X
        
        LDA.w $0F40, X : STA.w $0D50, X
        
        ASL : PHP
        ROR.w $0D50, X : PLP : ROR.w $0D50, X
        
        JSR.w Sprite_Move
    
    .BRANCH_IOTA
    
    RTS
}

; $037D17-$037D42 LOCAL JUMP LOCATION
SpriteDraw_FallingHelmaBeetle:
{
    LDA.w $0E20, X : CMP.b #$13 : BEQ .BRANCH_ALPHA
        LDA.w $0DC0, X : ASL #3 : ADC.b #$B7 : STA.b $08
        
        LDA.b #$FC
        
        .BRANCH_BETA
        
        ADC.b #$00 : STA.b $09
        
        LDA.b #$01
        JSL.l Sprite_DrawMultiple
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.w $0DC0, X : ASL #3 : ADC.b #$E7 : STA.b $08
    
    LDA.b #$FC
    
    BRA .BRANCH_BETA
}

; ==============================================================================

; $037D43-$037E5A DATA
Pool_SpriteDraw_FallingHumanoid:
{
    ; $037D43
    .offset_x
    db  -4,   4,  -4,  12
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db  -4,  12,  -4,   4
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db  -4,  12,  -4,   4
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db   4,   0,   0,   0
    db   4,   0,   0,   0

    ; $037D7B
    .offset_y
    db  -4,  -4,   4,  12
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db  -4,  -4,  12,   4
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db  -4,  -4,  12,   4
    db   0,   0,   0,   0
    db   0,   0,   0,   0
    db   4,   0,   0,   0
    db   4,   0,   0,   0
    db   4,   0,   0,   0

    ; $037DB3
    .char
    db $AE, $A8, $A6, $AF
    db $AA, $00, $00, $00
    db $AC, $00, $00, $00
    db $BE, $00, $00, $00
    db $A8, $AE, $AF, $A6
    db $AA, $00, $00, $00
    db $AC, $00, $00, $00
    db $BE, $00, $00, $00
    db $A6, $AF, $AE, $A8
    db $AA, $00, $00, $00
    db $AC, $00, $00, $00
    db $BE, $00, $00, $00
    db $B6, $00, $00, $00
    db $80, $00, $00, $00

    ; $037DEB
    .prop
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $40, $40, $40, $40
    db $40, $00, $00, $00
    db $40, $00, $00, $00
    db $40, $00, $00, $00
    db $80, $80, $80, $80
    db $80, $00, $00, $00
    db $80, $00, $00, $00
    db $80, $00, $00, $00
    db $01, $00, $00, $00
    db $01, $00, $00, $00

    ; $037E23
    .size
    db $00, $02, $02, $00
    db $02, $00, $00, $00
    db $02, $00, $00, $00
    db $00, $00, $00, $00
    db $02, $00, $00, $02
    db $02, $00, $00, $00
    db $02, $00, $00, $00
    db $00, $00, $00, $00
    db $02, $00, $00, $02
    db $02, $00, $00, $00
    db $02, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
}

; ==============================================================================

; $037E5B-$037EB3 LOCAL JUMP LOCATION
SpriteDraw_FallingHumanoid:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0DC0, X : PHA
    
    ASL : ASL : STA.b $06
    
    PLA
    
    PHX
    
    LDX.b #$00
    
    CMP.b #$0C : BCS .BRANCH_ALPHA
        AND.b #$03 : BNE .BRANCH_ALPHA
            LDX.b #$03
    
    .BRANCH_ALPHA
    
    STX.b $07
    
    .next_OAM_entry
    
        PHX
        
        TXA : CLC : ADC.b $06 : TAX
        LDA.b $00
        CLC : ADC.w Pool_SpriteDraw_FallingHumanoid_offset_x, X
        STA.b ($90), Y

        LDA.b $02
        CLC : ADC.w Pool_SpriteDraw_FallingHumanoid_offset_y, X
        INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_FallingHumanoid_char, X
        INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_FallingHumanoid_prop, X : EOR.b $05
        INY : STA.b ($90), Y
        
        PHY : TYA : LSR : LSR : TAY
        
        LDA.w Pool_SpriteDraw_FallingHumanoid_size, X : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b $07
    JSR.w Sprite_CorrectOamEntries
    
    RTS
}

; ==============================================================================

; $037EB4-$037EBB LONG JUMP LOCATION
Sprite_CorrectOamEntriesLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CorrectOamEntries
    
    PLB
    
    RTL
}

; ==============================================================================

; $037EBC-$037F25 LOCAL JUMP LOCATION
Sprite_CorrectOamEntries:
{
    !spr_y_lo = $00
    !spr_y_hi = $01
    
    !spr_x_lo = $02
    !spr_x_hi = $03
    
    !spr_y_screen_rel = $06
    !spr_x_screen_rel = $07
    
    JSR.w Sprite_GetScreenRelativeCoords
    
    PHX
    
    REP #$10
    
    LDX.b $90 : STX.b $0C
    
    LDX.b $92 : STX.b $0E
    
    .next_OAM_entry
    
        LDX.b $0E
        
        LDA.b $0B : BPL .override_size_and_upper_x_bit
            ; Otherwise, just preserve the size but but zero out the most sig X
            ; bit.
            LDA.b $00, X : AND.b #$02
        
        .override_size_and_upper_x_bit
        
        STA.b $00, X
        
        LDY.w #$0000
        
        LDX.b $0C
        
        LDA.b $00, X : SEC : SBC.b $07 : BPL .sign_extension_x
            DEY
        
        .sign_extension_x
        
            CLC : ADC.b $02 : STA.b $04
        TYA : ADC.b $03 : STA.b $05
        
        JSR.w Sprite_CheckIfOnScreenX : BCC .on_screen_x
            LDX.b $0E
            
            ; Restore the X bit, as it's been show to be in exceess of 0x100...
            ; This whole routine is kind of wonky and I have to wonder if it's
            ; buggy as well? (Compared to other OAM handler code I've seen.)
            INC.b $00, X
        
        .on_screen_x
        
        LDY.w #$0000
        
        LDX.b $0C : INX
        
        LDA.b $00, X : SEC : SBC.b $06 : BPL .sign_extension_y
            DEY
        
        .sign_extension_y
        
        CLC : ADC.b $00 : STA.b $09
        TYA : ADC.b $01 : STA.b $0A
        
        JSR.w Sprite_CheckIfOnScreenY : BCC .on_screen_y
            LDA.b #$F0 : STA.b $00, X
        
        .on_screen_y
        
        INX #3 : STX.b $0C
        
        INC.b $0E
    DEC.b $08 : BPL .next_OAM_entry
    
    SEP #$10
    
    PLX
    
    RTS
}

; ==============================================================================

; $037F26-$037F48 LOCAL JUMP LOCATION
Sprite_GetScreenRelativeCoords:
{
    STY.b $0B
    
    STA.b $08
    
    LDA.w $0D00, X  : STA.b $00
    SEC : SBC.b $E8 : STA.b $06
    LDA.w $0D20, X  : STA.b $01
    
    LDA.w $0D10, X  : STA.b $02
    SEC : SBC.b $E2 : STA.b $07
    LDA.w $0D30, X  : STA.b $03
    
    RTS
}

; ==============================================================================

; $037F49-$037F55 LOCAL JUMP LOCATION
Sprite_CheckIfOnScreenX:
{
    REP #$20
    
    LDA.b $04 : SEC : SBC.b $E2 : CMP.w #$0100
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $037F56-$037F6C LOCAL JUMP LOCATION
Sprite_CheckIfOnScreenY:
{
    REP #$20
    
    ; Is there any point to this the push and pull of A? Not really certain
    ; of that. (Not to mention the first storing of $09.)
    
    LDA.b $09          : PHA
    CLC : ADC.w #$0010 : STA.b $09
    SEC : SBC.b $E8    : CMP.w #$0100
    PLA                : STA.b $09
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; UNUSED:
; $037F6D-$037F71
UNREACHABLE_06FF6D:
{
    JSL.l Sprite_SelfTerminate
    
    RTS
}

; ==============================================================================

; $037F72-$037F77 DATA
Sprite_CheckIfRecoiling_frame_counter_masks:
{
    db $03, $01, $00, $00, $0C, $03
}

; $037F78-$037FF7 LOCAL JUMP LOCATION
Sprite_CheckIfRecoiling:
{
    LDA.w $0EA0, X : BEQ .return
        AND.b #$7F : BEQ .recoil_finished
            LDA.w $0D40, X : PHA
            LDA.w $0D50, X : PHA
            
            DEC.w $0EA0, X : BNE .not_halted_yet
                LDA.w $0F40, X : CLC : ADC.b #$20 : CMP.b #$40 : BCS .too_fast_so_halt
                    LDA.w $0F30, X : CLC : ADC.b #$20 : CMP.b #$40 : BCC .slow_enough
                
                .too_fast_so_halt
                
                LDA.b #$90 : STA.w $0EA0, X
                
                .slow_enough
            .not_halted_yet
            
            LDA.w $0EA0, X : BMI .halted
                LSR : LSR : TAY
                LDA.b $1A : AND .frame_counter_masks, Y : BNE .halted
                    LDA.w $0F30, X : STA.w $0D40, X
                    LDA.w $0F40, X : STA.w $0D50, X
                    
                    LDA.w $0CD2, X : BMI .no_wall_collision
                        JSL.l Sprite_CheckTileCollisionLong
                        
                        LDA.w $0E70, X : AND.b #$0F : BEQ .no_wall_collision
                            CMP.b #$04 : BCS .y_axis_wall_collision
                                STZ.w $0F40, X
                                STZ.w $0D50, X
                                
                                BRA .moving_on
                                
                            .y_axis_wall_collision
                            
                            STZ.w $0F30, X
                            STZ.w $0D40, X
                            
                            .moving_on
                            
                            BRA .halted
                    
                    .no_wall_collision
                    
                    JSR.w Sprite_Move
            
            .halted
            
            PLA : STA.w $0D50, X
            PLA : STA.w $0D40, X
            
            PLA : PLA
    
    .return
    
    RTS
    
    .recoil_finished
    
    STZ.w $0EA0, X
    
    RTS
}

; ==============================================================================

; $037FF8-$037FFF
NULL_06FFF8:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $078000
