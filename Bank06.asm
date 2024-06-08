; ==============================================================================

; Bank 06
; $030000-$037FFF
org $068000

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
    LDA.b #$10   : STA.b $0202
    
    LDA.w $0D00, X : STA.b $010101
    LDA.w $0D20, X : STA.b $0909090909
    LDA.b #$10   : STA.b $0303030303
    
    PHX : TYX
    
    JSR Sprite_SetupHitBox
    
    PLX
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .delta
        ; If the fish is close enough to the merchant, indicate as such.
        TYA : ORA.b #$80 : STA.w $0E90, X
    
    .delta
    
    PLB
    
    RTL
}

; ==============================================================================

; $030044-$030053 DATA
Pool_BottleVendor_SpawnFishRewards:
{
    .x_speeds
    db $FA, $FD, $00, $04, $07
    
    .y_speeds
    db $0B, $0E, $10, $0E, $0B
    
    .item_types
    db $DB, $E0, $DE, $E2, $D9
}

; ==============================================================================

; $030054-$03009E LONG JUMP LOCATION
BottleVendor_SpawnFishRewards:
{
    ; Only used by the bottle vendor...
    ; I think this spawns the items he gives you in the
    ; event that you give him a fish?
    
    PHB : PHK : PLB
    
    LDA.b #$13 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA.w $0FB5
    
    .nextItem
    
    LDY.w $0FB5
    
    LDA .item_types, Y : JSL Sprite_SpawnDynamically : BMI .spawnFailed
        JSL Sprite_SetSpawnedCoords
        
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        
        LDA.b #$FF : STA.w $0B58, Y
        
        PHX
        
        LDX.w $0FB5
        
        LDA .x_speeds, X : STA.w $0D50, Y
        
        LDA .y_speeds, X : STA.w $0D40, Y
        
        LDA.b #$20 : STA.w $0F80, Y : STA.w $0F10, Y
        
        PLX
    
    .spawnFailed
    
    DEC.w $0FB5 : BPL .nextItem
    
    PLB
    
    RTL
}

; ==============================================================================

    ; \wtf When the boomerang is off camera and still in play, it dramatically
    ; speeds up to catch up to the player. This was confirmed by setting
    ; the 0x70 and 0x90 values in this routine to much lower values and
    ; dashing away after throwing the boomerang. It took about 2 minutes
    ; for the boomerang to get back to the player, but when it finally
    ; appeared on screen it moved at its normal speed.
    ; Anyways, this routine overrides the values set by
    ; Ancilla_ProjectSpeedTowardsPlayer when the boomerang is out of
    ; view.
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
    
    ; Note: this is the negative version of 0x70
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
    .x_offsets_low
    db -32, -32, -32, 16
    
    .y_offsets_low
    db -32, 32, -24, -24
    
    .y_offsets_high
    db -1, 0
    
    .x_offsets_high
    db -1, -1, -1, 0
    
    ; $300F4
    db 80, 80
    
    ; $300F6
    db 32, 32, 80, 80
    
}

; ==============================================================================

; $0300FA-$03012C LONG JUMP LOCATION
Player_ApplyRumbleToSprites:
{
    ; Grabs Link's coordinates plus an offset determined by his direction
    ; and stores them to direct page locations.
    
    PHB : PHK : PLB
    
    LDA.b $2F : LSR A : TAY
    
    LDA.b $22 : CLC : ADC .x_offsets_low,  Y : STA.b $00
    LDA.b $23 : ADC .x_offsets_high, Y : STA.b $08
    
    LDA.b $20 : ADC .y_offsets_low,  Y : STA.b $01
    LDA.b $21 : ADC .y_offsets_high, Y : STA.b $09
    
    LDA.w $80F4, Y : STA.b $02
    LDA.w $80F6, Y : STA.b $03
    
    JSR Entity_ApplyRumbleToSprites
    
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
    
    JSL Sprite_SpawnThrowableTerrainSilently : BMI .spawn_failed
    
    JSR.w $E239 ; $036239 IN ROM
    
    .spawn_failed
    
    PLB
    
    PLA : STA.w $0FB2
    PLA : STA.w $0314
    
    RTL
}

; ==============================================================================

; $03014B-$0301F3 LONG JUMP LOCATION
Sprite_SpawnThrowableTerrain:
{
    ; This routine is called when you pick up a bush/pot/etc.
    ; A =   0 - sign 
    ;       1 - small light rock
    ;       2 - normal bush / pot
    ;       3 - thick grass
    ;       4 - off color bush
    ;       5 - small heavy rock
    ;       6 - large light rock
    ;       7 - large heavy rock
    
    PHA
    
    JSL Sound_SetSfxPanWithPlayerCoords
    
    ORA.b #$1D : STA.w $012E
    
    PLA
    
    ; $030156 ALTERNATE ENTRY POINT
    shared Sprite_SpawnThrowableTerrainSilently:
    
    LDX.b #$0F
    
    .next_slot
    
    ; look for dead sprites
    LDY.w $0DD0, X : BEQ .empty_slot
    
    DEX : BPL .next_slot
    
    ; can't find any slots so don't do any animation
    RTL
    
    .empty_slot
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    PHA
    
    LDA.b #$0A : STA.w $0DD0D0, X
    
    ; Make a bush/pot/etc. sprite appear
    LDA.b #$EC : STA.w $0E20, X
    
    LDA.b $00 : STA.w $0D10, X
    LDA.b $01 : STA.w $0D30, X
    
    LDA.b $02 : STA.w $0D0000, X
    LDA.b $03 : STA.w $0D20, X
    
    JSL Sprite_LoadProperties
    
    ; Set the floor level to whichever the player is on.
    LDA.b $EE : STA.w $0F20, X
    
    PLA : STA.w $0DB0, X : CMP.b #$06 : BCC .not_heavy_object
    
    PHA
    
    LDA.b #$A6 : STA.w $0E40, X
    
    PLA
    
    .not_heavy_object
    
    CMP.b #$02 : BNE .notBushOrPot
    
    LDA.b $1B : BEQ .outdoors
    
    ; This doesn't seem to do anything because it gets overwritten just
    ; a few lines down anyways!
    LDA.b #$80 : STA.w $0F50, X
    
    .notBushOrPot
    .outdoors
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    PHB : PHK : PLB
    
    TAY
    
    LDA.w $AACA, Y : STA.w $0F50, X
    
    LDA.b #$09 : STA.l $7FFA2C, X
    
    LDA.b #$02 : STA.w $0314
                 STA.w $0FB2
    
    LDA.b #$10 : STA.w $0DF0, X
    
    LDA.b $EE : STA.w $0F20, X
    
    STZ.w $0DC0, X
    
    LDA.w $0B9C : CMP.b #$FF : BEQ .invalid_secret
    
    ORA.b $1B : BNE .dont_substitute
    
    LDA.w $0DB0, X : DEC #2 : CMP.b #$02 : BCC .dont_substitute
    
    JSL Overworld_SubstituteAlternateSecret
    
    .dont_substitute
    
    LDA.w $0B9C : BPL .normal_secret
    
    AND.b #$7F : STA.w $0DC0, X
    
    STZ.w $0B9C
    
    .normal_secret
    
    JSR Sprite_SpawnSecret
    
    .invalid_secret
    
    PLB
    
    RTL
}

; ==============================================================================

; $030262-$030327 BRANCH LOCATION
Pool_Sprite_SpawnSecret:
{
    .easy_out
    
    CLC
    
    RTS
    
    ; $030264 MAIN ENTRY POINT
Sprite_SpawnSecret:
    
    LDA.b $1B : BNE .indoors
    
    JSL GetRandomInt : AND.b #$08 : BNE .easy_out
    
    .indoors
    
    LDY.w $0B9C  : BEQ .easy_out
    CPY.b #$04 : BNE .not_random
    
    JSL GetRandomInt : AND.b #$03 : CLC : ADC.b #$13 : TAY
    
    .not_random
    
    STY.b $0D
    
    ; List of sprites that can be spawned by secrets
    LDA.w $81F3, Y : BEQ .easy_out
    
    JSL Sprite_SpawnDynamically : BMI .easy_out
    
    PHX
    
    LDX.b $0D
    
    LDA.w $8209, X : STA.w $0D80, Y
    LDA.w $8235, X : STA.w $0BA0, Y
    LDA.w $824B, X : STA.w $0F80, Y
    
    LDA.b $00 : CLC : ADC.w $821F, X : STA.w $0D10, Y
    LDA.b $01 : ADC.b #$00   : STA.w $0D3030, Y
    
    LDA.b $02 : STA.w $0D00, Y
    LDA.b $03 : STA.w $0D20, Y
    
    LDA.b $04 : STA.w $0F70, Y
    
    LDA.b #$00 : STA.w $0DC0, Y
    LDA.b #$20 : STA.w $0F10, Y
    LDA.b #$30 : STA.w $0E10, Y
    
    LDX.w $0E20, Y : CPX.b #$E4 : BNE .not_key
    
    PHX
    
    TYX
    
    JSR.w $9262 ; $031262 IN ROM
    
    PLX
    
    .not_key
    
    CPX.b #$0B : BNE .not_chicken
    
    ; Make a chicken noise
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
    
    ; Play the "pissed off soldier" sound effect
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
    ; ARE WE INDOORS
    LDA.b $1B : BNE .indoors
    
    STZ.w $0C7C : STZ.w $0C7D : STZ.w $0C7E : STZ.w $0C7F
    STZ.w $0C80
    
    ; Looks like this might load or unload sprites as we scroll during
    ; the overworld... Not certain of this yet.
    JSL Sprite_RangeBasedActivation
    
    .indoors
    
    PHB : PHK : PLB
    
    LDY.b #$00
    
    LDA.l $7EF3CA : BEQ .in_light_world
    
    ; $7E0FFF = 0 if in LW, 1 otherwise
    INY
    
    .in_light_World
    
    ; Darkworld/Lightworld indicator
    STY.w $0FFF
    
    LDA.b $11 : BNE .dont_reset_player_dragging
    
    ; \wtf Wait, so the dragging of the player is reset under normal
    ; circumstances, but not in another submodule? Does not compute.
    STZ.w $0B7C
    STZ.w $0B7D
    
    STZ.w $0B7E
    STZ.w $0B7F
    
    .dont_reset_player_dragging
    
    JSR Oam_ResetRegionBases
    JSL Garnish_ExecuteUpperSlotsLong
    JSL Tagalong_MainLong
    
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
    
    JSL Ancilla_Main
    JSL Overlord_Main
    
    STZ.w $0B9A
    
    LDX.b #$0F
    
    .next_sprite
    
    STX.w $0FA0
    
    JSR Sprite_ExecuteSingle
    
    DEX : BPL .next_sprite
    
    JSL Garnish_ExecuteLowerSlotsLong
    
    STZ.w $069F
    STZ.w $069E
    
    PLB
    
    JSL CacheSprite_ExecuteAll
    
    LDA.w $0AAA : BEQ .iota
    
    STA.w $0FC6
    
    .iota
    
    RTL
}

; ==============================================================================

; $0303C2-$0303C6 LONG JUMP LOCATION
EasterEgg_BageCodeTrampoline:
{
    ; \tcrf Already mentioned on tcrf, but I'm pretty sure they got that
    ; material from me, as some guy in IRC was asking about it around
    ; the time it went up on the wiki.
    ; Anyways, this code is confirmed to work, but is not accessible
    ; in an unmodified game. A hook would have to be inserted somewhere
    ; to call this.
    
    JSL EasterEgg_BageCode
    
    RTL
}

; ==============================================================================

; $0303C7-$0303D2 DATA
Pool_Oam_ResetRegionBases:
{
    .bases
    db $0030, $01D0, $0000, $0030, $0120, $0140
}

; ==============================================================================

    ; \note Appears to reset oam regions every frame that the sprite
    ; handlers are active. Whether these are just for sprites themselves
    ; and not object handlers, I dunno.
; $0303D3-$0303E5 LOCAL JUMP LOCATION
Oam_ResetRegionBases:
{
    LDY.b #$00
    
    REP #$20
    
    .next_oam_region
    
    LDA .bases, Y : STA.w $0FE0, Y
    
    INY #2 : CPY.b #$0B : BCC .next_oam_region
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0303E6-$0303E9 LONG JUMP LOCATION
Utility_CheckIfHitBoxesOverlapLong:
{
    JSR Utility_CheckIfHitBoxesOverlap
    
    RTL
}

; ==============================================================================

; $0303EA-$0303F1 LONG JUMP LOCATION
Sprite_SetupHitBoxLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_SetupHitBox
    
    PLB
    
    RTL
}

; ==============================================================================

; $0303F2-$0304BC LOCAL JUMP LOCATION
{
    JSR Sprite_Get_16_bit_Coords
    
    LDA.w $0E40, X : AND.b #$1F : INC A : ASL #2
    
    LDY.w $0FB3 : BEQ .dontSortSprites
    
    LDY.w $0F20, X : BEQ .onBG2
    
    JSL OAM_AllocateFromRegionF : BRA .doneAllocatingOamSlot
    
    .onBG2
    
    JSL OAM_AllocateFromRegionD : BRA .doneAllocatingOamSlot
    
    .dontSortSprites
    
    JSL OAM_AllocateFromRegionA
    
    .doneAllocatingOamSlot
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; checking for oddball modes
    ; typically branches along this path
    LDA.b $11 : ORA.w $0FC1 : BEQ .normalGameMode
    
    JMP.w $84A4 ; $0304A4 IN ROM
    
    .normalGameMode
    
    ; this section decrements the sprite's 4 general purpose timers (if nonzero)
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
    
    ; on the 0x1F tick of the damage timer we...
    CMP.b #$1F : BNE .BRANCH_MU
    
    PHA
    
    ; Is the sprite Agahnim?
    LDA.w $0E20, X : CMP.b #$7A : BNE .not_agahnim_bitching
    
    ; branch if in the dark world
    LDA.w $0FFF : BNE .not_agahnim_bitching
    
    ; subtract off damage from agahnim
    LDA.w $0E50, X : SEC : SBC.w $0CE2, X : BEQ .agahnim_bitches
                                  BCS .not_agahnim_bitching
    
    .agahnim_bitches
    
    ; Agahnim bitching about you beating him in the Light world
    LDA.b #$40 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    .not_agahnim_bitching
    
    PLA
    
    .BRANCH_MU
    
    CMP.b #$18 : BNE .BRANCH_LAMBDA
    
    JSR.w $EEC8 ; $036EC8 IN ROM
    
    .BRANCH_LAMBDA
    .sprite_inactive
    
    LDA.w $0CE2, X : CMP.b #$FB : BCS .BRANCH_XI
    
    LDA.w $0EF0, X : ASL A : AND.b #$0E : STA.w $0B89, X
    
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
    
    ; \wtf Interesting.... if player priority is super priority, all sprites
    ; follow? \task Investigate this.
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
    JSR Sprite_Get_16_bit_Coords
    
    RTL
}

; ==============================================================================

; $0304C1-$0304D9 LOCAL JUMP LOCATION
Sprite_Get_16_bit_Coords:
{
    ; $0FD8 = sprite's X coordinate, $0FDA = sprite's Y coordinate
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
    
    JSR Sprite_ExecuteSingle
    
    PLB
    
    RTL
}

; ==============================================================================

; $0304E2-$030525 LOCAL JUMP LOCATION
Sprite_ExecuteSingle:
{
    LDA.w $0DD0, X : BEQ .inactiveSprite
    
    PHA
    
    JSR.w $83F2 ; $0303F2 IN ROM; Loads some sprite data into common addresses.
    
    PLA
    
    CMP.b #$09 : BEQ .activeSprite
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; index is $0DD0, X
    dw .inactiveSprite       ; 0x00 - Sprite is totally inactive
    dw SpriteFall_Main       ; 0x01 - sprite is falling into a hole
    dw SpritePoof_Main       ; 0x02 - Frozen Sprite being smashed by hammer, and pooferized, perhaps into a nice magic refilling item.
    dw SpriteDrown_Main      ; 0x03 - Sprite has fallen into deep water, may produce a fish
    dw SpriteExplode_Main    ; 0x04 - Explodey Mode for bosses?
    dw SpriteCustomFall_Main ; 0x05 - Sprite falling into a hole but that has a special animation (e.g. soldiers and hard hat beetles)
    dw SpriteDeath_Main      ; 0x06 - Death mode for normal creatures.
    dw SpriteBurn_Main       ; 0x07 - Being incinerated? (By Fire Rod)
    dw SpritePrep_Main       ; 0x08 - A spawning sprite
    dw SpriteActive_Main     ; 0x09 - An active sprite
    dw SpriteHeld_Main       ; 0x0A - sprite is being held above Link's head
    dw SpriteStunned_Main    ; 0x0B - sprite is frozen and immobile
    
    .activeSprite
    
    JMP SpriteActive_Main
    
    ; 3050F ALTERNATE ENTRY POINT
    shared SpritePrep_ThrowableScenery:
    
    ; Why the hell *this* is used as an alternate entry point is beyond
    ; me.
    RTS
    
    ; $030510 ALTERNATE ENTRY POINT
    .inactiveSprite
    
    LDA.b $1B : BNE .indoors
    
    TXA : ASL A
    
    LDA.b #$FF : STA.w $0BC0, Y : STA.w $0BC1, Y
    
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
    
    JSR SpriteActive_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $03052E-$030542 JUMP LOCATION
SpriteFall_Main:
{
    ; Sprite mode for falling into a hole
    
    LDA.w $0DF0, X : BNE .delay
    
    STZ.w $0DD0, X
    
    JSL Dungeon_ManuallySetSpriteDeathFlag
    
    RTS
    
    .delay
    
    JSR Sprite_PrepOamCoord
    JSL SpriteFall_Draw
    
    RTS
}

; ==============================================================================

; $030543-$030547 JUMP LOCATION
SpriteBurn_Main:
{
    JSL SpriteBurn_Execute
    
    RTS
}

; ==============================================================================

; $030548-$03054C JUMP LOCATION
SpriteExplode_Main:
{
    JSL SpriteExplode_ExecuteLong
    
    RTS
}

; ==============================================================================

; $03054D-$03059B DATA
Pool_SpriteDrown_Main:
{
    .oam_groups
    dw -7, -7 : db $80, $04, $00, $00
    dw 14, -6 : db $83, $04, $00, $00
    
    dw -6, -6 : db $CF, $04, $00, $00
    dw 13, -5 : db $DF, $04, $00, $00
    
    dw -4, -4 : db $AE, $04, $00, $00
    dw 12, -4 : db $AF, $44, $00, $00
    
    dw  0,  0 : db $E7, $04, $00, $02
    dw  0,  0 : db $E7, $04, $00, $02
    
    .vh_flip
    db $00, $40, $C0, $80
    
    .chr
    db $C0, $C0, $C0, $C0, $CD, $CD, $CD, $CB
    db $CB, $CB, $CB
}

; ==============================================================================

; $03059C-$03064C JUMP LOCATION
SpriteDrown_Main:
{
    ; Sprite Mode 0x03
    
    LDA.w $0D80, X : BEQ .alpha
    
    LDA.w $0D90, X : CMP.b #$06 : BNE .BRANCH_BETA
    
    LDA.b #$08 : JSL OAM_AllocateFromRegionC
    
    .BRANCH_BETA
    
    LDA.w $0E60, X : EOR.b #$10 : STA.w $0E60, X
    
    JSR Sprite_PrepAndDrawSingleLarge
    
    LDA.w $0E80, X : LSR #2 : AND.b #$03 : TAY
    
    ; Load hflip and vflip settings
    LDA .vh_flip, Y : STA.b $05
    
    LDA.w $0DF0, X : CMP.b #$01 : BNE .notLastTimerTick
    
    STZ.w $0DD0, X
    
    .notLastTimerTick
    
    PHX
    
    LDA.b #$8A : BCC .timerExpired
    
    LDA.w $0DF0, X : LSR A : TAX
    
    STZ.b $05
    
    ; Get address of first tile of the sprite.
    LDA .chr, X
    
    .timerExpired
    
    LDY.b #$02           : STA ($90), Y : INY
    LDA.b #$24 : ORA.b $05 : STA ($90), Y
    
    PLX
    
    LDA.w $0DF0, X : BNE .BRANCH_EPSILON
    
    JSR Sprite_CheckIfActive.permissive
    
    INC.w $0E80, X
    
    JSR Sprite_Move
    JSR Sprite_MoveAltitude
    
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_EPSILON
    
    STZ.w $0F70, X
    
    LDA.b #$12 : STA.w $0DF0, X
    
    ; $030612 ALTERNATE ENTRY POINT
    
    LDA.w $0E60, X : AND.b #$EF : STA.w $0E60, X
    
    .BRANCH_EPSILON
    
    RTS
    
    .alpha
    
    JSR Sprite_CheckIfActive.permissive
    
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
    
    ASL A : AND.w #$00F8 : ASL A : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

incsrc "sprite_prep.asm"

; ==============================================================================
    
; $031283-$031468 JUMP TABLE
SpriteActive_Table:
{
    ; SPRITE ROUTINES 1
    
    ; This is the table for all sprite objects used in the game
    ; PARAMETER $0E20, X
    
    ; This is an unusual jump table. The jump values were fed onto the stack, and an RTS was used to jump there. In the above routine you will notice that the accumulator was decremented (DEC A). That was intentional, since after an RTS, the processor pulls an address off the stack and increments it by one, thereby allowing it to travel to the addresses you see.
    
    !null_ptr = $0000
    
    dw Sprite_RavenTrampoline            ; 0x00 - Raven
    dw Sprite_VultureTrampoline          ; 0x01 - Vulture
    dw Sprite_StalfosHead                ; 0x02 - Flying Stalfos head
    dw !null_ptr                         ; 0x03 - Since this leads to null area, we presume this is unused. i tried using it, it crashed horribly.
    dw Sprite_PullSwitchTrampoline       ; 0x04 - Good switch (down)
    dw Sprite_PullSwitchTrampoline       ; 0x05 - Bad Switch (down)
    dw Sprite_PullSwitchTrampoline       ; 0x06 - Good switch (up)
    dw Sprite_PullSwitchTrampoline       ; 0x07 - Bad switch (up)
    dw Sprite_Octorock                   ; 0x08 - Octorock
    dw Sprite_GiantMoldormTrampoline     ; 0x09 - Giant Moldorm
    dw Sprite_Octorock                   ; 0x0A - Four Shooter Octorock
    dw Sprite_Chicken                    ; 0x0B - Chicken / Chicken -> Lady transformation
    dw Sprite_Octostone                  ; 0x0C - Rock projectile that Octorocks shoot
    dw Sprite_Buzzblob                   ; 0x0D - Buzzblob
    dw Sprite_SnapDragon                 ; 0x0E - Plants with big mouths (Dark World)
    dw Sprite_Octoballoon                ; 0x0F - Octoballoon (aka Exploder?)
    dw Sprite_Octospawn                  ; 0x10 - Small things from the exploder
    dw Sprite_Hinox                      ; 0x11 - Hinox
    dw Sprite_Moblin                     ; 0x12 - Moblin
    dw Sprite_Helmasaur                  ; 0x13 - Helmasaur
    dw Sprite_GargoyleGrateTrampoline    ; 0x14 - Gargoyle's Domain Entrance
    dw Sprite_Bubble                     ; 0x15 - Fire Fairy?
    dw Sprite_ElderTrampoline            ; 0x16 - Sahasralah / Aginah
    dw Sprite_CoveredRupeeCrab           ; 0x17 - Rupee Crab under bush
    dw Sprite_Moldorm                    ; 0x18 - Moldorm
    dw Sprite_Poe                        ; 0x19 - Poe
    dw Sprite_SmithyBros                 ; 0x1A - Smithy bros.
    dw Sprite_EnemyArrow                 ; 0x1B - Arrow in wall.
    dw Sprite_MovableStatue              ; 0x1C - Movable Statue
    dw Sprite_WeathervaneTrigger         ; 0x1D - Weathervane Sprite (Useless?)
    dw Sprite_CrystalSwitch              ; 0x1E - Crystal Switches for orange/blue barriers
    dw Sprite_BugNetKid                  ; 0x1F - Sick kid who gives Link the Bug catching net
    dw Sprite_Sluggula                   ; 0x20 - Bomb Slug
    dw Sprite_PushSwitch                 ; 0x21 - Water palace push switch
    dw Sprite_Ropa                       ; 0x22 - Ropa
    dw Sprite_RedBari                    ; 0x23 - Bari (Red)
    dw Sprite_BlueBari                   ; 0x24 - Bari (Blue)
    dw Sprite_TalkingTreeTrampoline      ; 0x25 - Talking Tree
    dw Sprite_HardHatBeetle              ; 0x26 - Hard hat Beetle
    dw Sprite_DeadRock                   ; 0x27 - Deadrock
    dw Sprite_StoryTeller_1              ; 0x28 - Story Teller NPCs / DW hint NPC
    dw Sprite_HumanMulti_1_Trampoline    ; 0x29 - Guy in Blind's Old Hideout / Thieves Hideout Guy / Flute Boy's Father
    dw Sprite_SweepingLadyTrampoline     ; 0x2A - Sweeping lady
    dw Sprite_HoboEntities               ; 0x2B - Hobo under bridge (and helper sprites)
    dw Sprite_LumberjacksTrampoline      ; 0x2C - Lumberjack Bros.
    dw Sprite_UnusedTelepathTrampoline   ; 0x2D - Telepathic stones? (wtf does this name mean?)
    dw Sprite_FluteBoy                   ; 0x2E - Flute boy, and his notes?
    dw Sprite_MazeGameLadyTrampoline     ; 0x2F - Heart piece race guy / girl
    dw Sprite_MazeGameGuyTrampoline      ; 0x30 - Maze Game Guy
    dw Sprite_FortuneTellerTrampoline    ; 0x31 - Fortune Teller / Dwarf Swordsmith
    dw Sprite_QuarrelBrosTrampoline      ; 0x32 - Quarreling Brothers
    dw Sprite_PullForRupeesTrampoline    ; 0x33 - Rupee prizes hidden in walls.
    dw Sprite_YoungSnitchLadyTrampoline  ; 0x34 - Young Snitch Lady
    dw Sprite_InnKeeperTrampoline        ; 0x35 - Inn Keeper
    dw Sprite_WitchTrampoline            ; 0x36 - Witch?
    dw Sprite_WaterfallTrampoline        ; 0x37 - Waterfall sprite
    dw Sprite_ArrowTriggerTrampoline     ; 0x38 - Arrow trigger
    dw Sprite_MiddleAgedMan              ; 0x39 - Middle aged man in the desert.
    dw Sprite_MadBatterTrampoline        ; 0x3A - Magic Powder bat / lightning bolt he throws
    dw Sprite_DashItemTrampoline         ; 0x3B - Dash item (book of mudora / etc)
    dw Sprite_TroughBoyTrempoline        ; 0x3C - TroughBoy
    dw Sprite_OldSnitchLadyTrampoline    ; 0x3D - Scared ladies and chicken lady, maybe others.
    dw Sprite_CoveredRupeeCrab           ; 0x3E - Rupee Crab under rock
    dw Sprite_TutorialEntitiesTrampoline ; 0x3F - Tutorial Soldier
    dw Sprite_TutorialEntitiesTrampoline ; 0x40 - Hyrule Castle Barrier
    dw SpriteActive2_Trampoline          ; 0x41 - Blue Soldier
    dw SpriteActive2_Trampoline          ; 0x42 - Green Soldier
    dw SpriteActive2_Trampoline          ; 0x43 - 
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x48 - Red Spear Soldier (in special armor)
    dw SpriteActive2_Trampoline ; 0x49 - Red Spear Soldier (in bushes)
    dw SpriteActive2_Trampoline ; 0x4A - Green Enemy Bomb
    dw SpriteActive2_Trampoline ; 0x4B - Green Soldier (weak version)
    dw SpriteActive2_Trampoline ; 0x4C - Sand monster
    dw SpriteActive2_Trampoline ; 0x4D - Bunnies in tall grass / on ground
    dw SpriteActive2_Trampoline ; 0x4E - Popo (aka Snakebasket)
    dw SpriteActive2_Trampoline ; 0x4F - Blobs?
    dw SpriteActive2_Trampoline ; 0x50 - Metal balls in Eastern Palace
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x53 - Armos Knight
    dw SpriteActive2_Trampoline ; 0x54 - 
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x57 - Desert Palace barriers
    dw SpriteActive2_Trampoline ; 0x58 - Crab
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x60 - Roller (horizontal)
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x68 - 
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline ; 0x6D - Rat / Bazu
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline
    dw SpriteActive2_Trampoline      ; 0x70 - 
    dw Sprite_Leever                 ; 0x71 - 
    dw Sprite_WishPond               ; 0x72 - Pond of Wishing (yes you're talking to a pond)
    dw Sprite_UncleAndSageTrampoline ; 0x73 - Uncle / Priest / Sanctury Mantle
    dw Sprite_RunningManTrampoline   ; 0x74 - Scared red hat man
    dw Sprite_BottleVendorTrampoline ; 0x75 - Bottle vendor 
    dw Sprite_ZeldaTrampoline        ; 0x76 - Princess Zelda (not the tagalong version)
    dw Sprite_Bubble                 ; 0x77 - Weird kind of Fire fairy?
    dw Sprite_ElderWifeTrampoline    ; 0x78 - Elder's Wife
    dw SpriteActive3_Transfer        ; 0x79 - 
    dw SpriteActive3_Transfer        ; 0x7A - 
    dw SpriteActive3_Transfer        ; 0x7B - 
    dw SpriteActive3_Transfer        ; 0x7C - 
    dw SpriteActive3_Transfer        ; 0x7D - 
    dw SpriteActive3_Transfer        ; 0x7E - 
    dw SpriteActive3_Transfer        ; 0x7F - 
    dw SpriteActive3_Transfer        ; 0x80 - 
    dw SpriteActive3_Transfer        ; 0x81 - 
    dw SpriteActive3_Transfer        ; 0x82 - 
    dw SpriteActive3_Transfer        ; 0x82 - 
    dw SpriteActive3_Transfer        ; 0x82 - 
    dw SpriteActive3_Transfer        ; 0x85 - Yellow Stalfos
    dw SpriteActive3_Transfer        ; 0x86 - 
    dw SpriteActive3_Transfer        ; 0x87 - 
    dw SpriteActive3_Transfer        ; 0x88 -
    dw SpriteActive3_Transfer        ; 0x89 - 
    dw SpriteActive3_Transfer        ; 0x8A - 
    dw SpriteActive3_Transfer        ; 0x8B - 
    dw SpriteActive3_Transfer        ; 0x8C - 
    dw SpriteActive3_Transfer        ; 0x8D - 
    dw SpriteActive3_Transfer        ; 0x8E - 
    dw SpriteActive3_Transfer        ; 0x8F - 
    dw SpriteActive3_Transfer        ; 0x90 - 
    dw SpriteActive3_Transfer        ; 0x91 - 
    dw SpriteActive3_Transfer        ; 0x92 - helamsaur king
    dw SpriteActive3_Transfer        ; 0x93 - Bumper
    dw SpriteActive3_Transfer        ; 0x94 - 
    dw SpriteActive3_Transfer        ; 0x95 - 
    dw SpriteActive3_Transfer        ; 0x96 - 
    dw SpriteActive3_Transfer        ; 0x97 - 
    dw SpriteActive3_Transfer        ; 0x98 - 
    dw SpriteActive3_Transfer        ; 0x99 - 
    dw SpriteActive3_Transfer        ; 0x9A - Kyameron
    dw SpriteActive3_Transfer        ; 0x9B - 
    dw SpriteActive3_Transfer        ; 0x9C - 
    dw SpriteActive3_Transfer        ; 0x9D - 
    dw SpriteActive3_Transfer        ; 0x9E - 
    dw SpriteActive3_Transfer        ; 0x9F - 
    dw SpriteActive3_Transfer        ; 0xA0 - 
    dw SpriteActive3_Transfer        ; 0xA1 - 
    dw SpriteActive3_Transfer        ; 0xA2 - 
    dw SpriteActive3_Transfer        ; 0xA3 - 
    dw SpriteActive3_Transfer        ; 0xA4 - 
    dw SpriteActive3_Transfer        ; 0xA5 - 
    dw SpriteActive3_Transfer        ; 0xA6 - 
    dw SpriteActive3_Transfer        ; 0xA7 - 
    dw SpriteActive3_Transfer        ; 0xA8 - Green Bomber (Zirro?)
    dw SpriteActive3_Transfer        ; 0xA9 - Blue Bomber (Zirro?)
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer ; 0xB0 - 
    dw SpriteActive3_Transfer ; 
    dw SpriteActive3_Transfer ; 
    dw SpriteActive3_Transfer ; 
    dw SpriteActive3_Transfer ; 
    dw SpriteActive3_Transfer ; Elephant salesman
    dw SpriteActive3_Transfer ; Kiki the monkey (B6)
    dw SpriteActive3_Transfer ; 
    dw SpriteActive3_Transfer ; 0xB8 - Monologue testing sprite (debug artifact)
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer
    dw SpriteActive3_Transfer ; 0xBB - Shop Keeper / Chest Game Guys
    dw SpriteActive3_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer ; Mystery sprite  "???" in hyrule magic
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer ; 0xC0 - Cranky Lake Monster CrankyLakeMonster
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer ; 0xC8 - Big Fairy
    dw SpriteActive4_Transfer ; 0xC9 - 
    dw SpriteActive4_Transfer ; 0xCA - Chain Chomp
    dw SpriteActive4_Transfer ; 0xCB - 
    dw SpriteActive4_Transfer ; 0xCC - 
    dw SpriteActive4_Transfer ; 0xCD - 
    dw SpriteActive4_Transfer ; 0xCE - Blind
    dw SpriteActive4_Transfer ; 0xCF - Swamola
    dw SpriteActive4_Transfer ; 0xD0 - 
    dw SpriteActive4_Transfer ; Pointer for Yellow hunter
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer
    dw SpriteActive4_Transfer           ; 0xD6 - Pointer for Ganon.
    dw SpriteActive4_Transfer           ; 0xD7 - 
    dw Sprite_HeartRefill               ; 0xD8 - Heart refill
    dw Sprite_GreenRupee                ; 0xD9 - 
    dw Sprite_BlueRupee                 ; 0xDA - 
    dw Sprite_RedRupee                  ; 0xDB - 
    dw Sprite_OneBombRefill             ; 0xDC - 1 Bomb Refill
    dw Sprite_FourBombRefill            ; 0xDD - 4 Bomb Refill
    dw Sprite_EightBombRefill           ; 0xDE - 8 Bomb Refill
    dw Sprite_SmallMagicRefill          ; 0xDF - Small Magic Refill
    dw Sprite_FullMagicRefill           ; 0xE0 - Full Magic Refill
    dw Sprite_FiveArrowRefill           ; 0xE1 - 5 Arrow Refill
    dw Sprite_TenArrowRefill            ; 0xE2 - 10 Arrow Refill
    dw Sprite_Fairy                    ; 0xE3 - Fairy
    dw Sprite_Key                       ; 0xE4 - Key 
    dw Sprite_BigKey                    ; 0xE5 - Big Key
    dw Sprite_ShieldPickup              ; 0xE6 - Shield Pickup (from Pikit)
    dw Sprite_MushroomTrampoline        ; 0xE7 - Mushroom
    dw Sprite_FakeSwordTrampoline       ; 0xE8 - Fake Master Sword
    dw Sprite_PotionShopTrampoline      ; 0xE9 - Magic Shop Dude and his items
    dw Sprite_HeartContainerTrampoline  ; 0xEA - Heart Container
    dw Sprite_HeartPieceTrampoline      ; 0xEB - Heart piece
    dw Sprite_ThrowableScenery          ; 0xEC - pot/bush/etc
    dw Sprite_SomariaPlatformTrampoline ; 0xED - Cane of Somaria Platform
    dw Sprite_MovableMantleTrampoline   ; 0xEE - [pushable] Mantle in throne room
    dw Sprite_SomariaPlatformTrampoline ; 0xEF - Cane of Somaria Platform
    dw Sprite_SomariaPlatformTrampoline ; 0xF0 - Cane of Somaria Platform
    dw Sprite_SomariaPlatformTrampoline ; 0xF1 - Cane of Somaria Platform
    dw Sprite_MedallionTabletTrampoline ; 0xF2 - Medallion Tablet
}

; ==============================================================================

; $031469-$03146D JUMP LOCATION
Sprite_GiantMoldormTrampoline:
{
    JSL Sprite_GiantMoldormLong
    
    RTS
}

; ==============================================================================

; $03146E-$031472 JUMP LOCATION
Sprite_RavenTrampoline:
{
    JSL Sprit_RavenLong
    
    RTS
}

; ==============================================================================

; $031473-$031477 JUMP LOCATION
Sprite_VultureTrampoline:
{
    JSL Sprite_VultureLong
    
    RTS
}

; ==============================================================================

incsrc "sprite_deadrock.asm"
incsrc "sprite_sluggula.asm"
incsrc "sprite_poe.asm"
incsrc "sprite_moldorm.asm"
incsrc "sprite_moblin.asm"
incsrc "sprite_snap_dragon.asm"
incsrc "sprite_ropa.asm"
incsrc "sprite_hinox.asm"
incsrc "sprite_bari.asm"
incsrc "sprite_helmasaur.asm"
incsrc "sprite_bubble.asm"
incsrc "sprite_chicken.asm"

; ==============================================================================

; $032853-$032857 JUMP LOCATION
Sprite_MovableMantleTrampoline:
{
    JSL Sprite_MovableMantleLong
    
    RTS
}

; ==============================================================================

incsrc "sprite_rupee_crab.asm"
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
    
    TYX
    
    ; Loads up all the bases and widths for the collision detection...
    JSR Sprite_SetupHitBox
    
    PLX
    
    ; Does the actual collision detection...
    JSR Utility_CheckIfHitBoxesOverlap : BCC .skip_sprite
    
    .collision_guaranteed
    
    ; Maybe other sprites react to this, but primarily the apple sprites
    ; hidden in trees split when this variable is set low.
    LDA.b #$00 : STA.w $0E90, Y
    
    LDA.b #$30 : STA.w $012F
    
    LDA.b #$30 : STA.w $0F80, Y
    LDA.b #$10 : STA.w $0D50, X
    LDA.b #$30 : STA.w $0EE0, Y
    LDA.b #$FF : STA.w $0B58, Y
    
    ; \note Interestingly enough, this is not really a heart refill,
    ; but a trigger for a bomb to be knocked out of a tree.
    ; What a mess this game's sprites system is. assassin17 knows it too,
    ; and I've known it for somewhat longer, but it still manages to
    ; surprise me now and then.
    LDA.w $0E20, Y : CMP.b #$D8 : BNE .not_single_heart_refill
    
    JSL Sprite_TransmuteToEnemyBomb
    
    .skip_sprite
    .not_single_heart_refill
    
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

incsrc "sprite_story_teller_multi_1.asm"
incsrc "sprite_flute_boy.asm"
incsrc "sprite_smithy_bros.asm"
incsrc "sprite_enemy_arrow.asm"
incsrc "sprite_crystal_switch.asm"
incsrc "sprite_bug_net_kid.asm"
incsrc "sprite_push_switch.asm"
incsrc "sprite_middle_aged_man.asm"
incsrc "sprite_hobo.asm"

; ==============================================================================

; $033FE0-$033FE4 JUMP LOCATION
Sprite_UncleAndSageTrampoline:
{
    ; Uncle / Priest / Santuary Mantle
    JSL Sprite_UncleAndSageLong
    
    RTS
}

; ==============================================================================

; $033FE5-$033FE9 JUMP LOCATION
SpritePrep_UncleAndSageTrampoline:
{
    JSL SpritePrep_UncleAndSageLong
    
    RTS
}

; ==============================================================================

; $033FEA-$033FEE JUMP LOCATION
SpriteActive2_Trampoline:
{
    JSL SpriteActive2_MainLong
    
    RTS
}

; ==============================================================================

; $033FEF-$033FF3 JUMP LOCATION
SpriteActive3_Transfer:
{
    JSL SpriteActive3_MainLong
    
    RTS
}

; ==============================================================================

; $033FF4-$033FF8 JUMP LOCATION
SpriteActive4_Transfer:
{
    JSL SpriteActive4_MainLong
    
    RTS
}

; ==============================================================================

; $033FF9-$033FFD JUMP LOCATION
SpritePrep_OldMountainManTrampoline:
{
    JSL SpritePrep_OldMountainManLong
    
    RTS
}

; ==============================================================================

; $033FFE-$034002 JUMP LOCATION
Sprite_TutorialEntitiesTrampoline:
{
    JSL Sprite_TutorialEntitiesLong
    
    RTS
}

; ==============================================================================

; $034003-$034007 JUMP LOCATION
Sprite_PullSwitchTrampoline:
{
    JSL Sprite_PullSwitch
    
    RTS
}

; ==============================================================================

; $034008-$03400C JUMP LOCATION
Sprite_SomariaPlatformTrampoline:
{
    JSL Sprite_SomariaPlatformLong
    
    RTS
}

; ==============================================================================

; $03400D-$034011 JUMP LOCATION
Sprite_MedallionTabletTrampoline:
{
    ; Medallion Tablet
    JSL Sprite_MedallionTabletLong
    
    RTS
}

; ==============================================================================

; $034012-$034016 JUMP LOCATION
Sprite_QuarrelBrosTrampoline:
{
    JSL Sprite_QuarrelBrosLong
    
    RTS
}

; ==============================================================================

; $034017-$03401B JUMP LOCATION
Sprite_PullForRupeesTrampoline:
{
    JSL Sprite_PullForRupeesLong
    
    RTS
}

; ==============================================================================

; $03401C-$034020 JUMP LOCATION
Sprite_GargoyleGrateTrampoline:
{
    JSL Sprite_GargoyleGrateLong
    
    RTS
}

; ==============================================================================

; $034021-$034025 JUMP LOCATION
Sprite_YoungSnitchLadyTrampoline:
{
    JSL Sprite_YoungSnitchLadyLong
    
    RTS
}

; ==============================================================================

; $034026-$03402A JUMP LOCATION
SpritePrep_YoungSnitchGirl:
{
    JSL SpritePrep_SnitchesLong
    
    RTS
}

; ==============================================================================

; $03402B-$03402F JUMP LOCATION
Sprite_InnKeeperTrampoline:
{
    JSL Sprite_InnKeeperLong
    
    RTS
}

; ==============================================================================

; $034030-$034034 JUMP LOCATION
SpritePrep_InnKeeper:
{
    JSL SpritePrep_SnitchesLong
    
    RTS
}

; ==============================================================================

; $034035-$034039 JUMP LOCATION
Sprite_WitchTrampoline:
{
    JSL Sprite_WitchLong
    
    RTS
}

; ==============================================================================

; $03403A-$03403E JUMP LOCATION
Sprite_WaterfallTrampoline:
{
    JSL Sprite_WaterfallLong
    
    RTS
}

; ==============================================================================

; $03403F-$034043 JUMP LOCATION
Sprite_ArrowTriggerTrampoline:
{
    JSL Sprite_ArrowTriggerLong
    
    RTS
}

; ==============================================================================

; $034044-$034048 JUMP LOCATION
Sprite_MadBatterTrampoline:
{
    JSL Sprite_MadBatterLong
    
    RTS
}

; ==============================================================================

; $034049-$03404D JUMP LOCATION
Sprite_DashItemTrampoline:
{
    JSL Sprite_DashItemLong
    
    RTS
}

; ==============================================================================

; $03404E-$034052 JUMP LOCATION
Sprite_TroughBoyTrempoline:
{
    JSL Sprite_TroughBoyLong
    
    RTS
}

; ==============================================================================

; $034053-$034057 JUMP LOCATION
Sprite_OldSnitchLadyTrampoline:
{
    JSL Sprite_OldSnitchLadyLong
    
    RTS
}

; ==============================================================================

; $034058-$03405C JUMP LOCATION
Sprite_RunningManTrampoline:
{
    JSL Sprite_RunningManLong
    
    RTS
}

; ==============================================================================

; $03405D-$034061 JUMP LOCATION
SpritePrep_RunningManTrampoline:
{
    JSL SpritePrep_RunningManLong
    
    RTS
}

; ==============================================================================

; $034062-$034066 JUMP LOCATION
Sprite_BottleVendorTrampoline:
{
    ; Bottle Vendor AI
    
    JSL Sprite_BottleVendorLong
    
    RTS
}

; ==============================================================================

; $034067-$03406B JUMP LOCATION
Sprite_ZeldaTrampoline:
{
    JSL Sprite_ZeldaLong
    
    RTS
}

; ==============================================================================

; $03406C-$034070 JUMP LOCATION
SpritePrep_ZeldaTrampoline:
{
    JSL SpritePrep_ZeldaLong
    
    RTS
}

; ==============================================================================

; $034071-$034075 JUMP LOCATION
Sprite_ElderWifeTrampoline:
{
    JSL Sprite_ElderWifeLong
    
    RTS
}

; ==============================================================================

; $034076-$03407A JUMP LOCATION
Sprite_MushroomTrampoline:
{
    JSL Sprite_MushroomLong
    
    RTS
}

; ==============================================================================

; $03407B-$03407F JUMP LOCATION
SpritePrep_MushroomTrampoline:
{
    JSL SpritePrep_MushroomLong
    
    RTS
}

; ==============================================================================

; $034080-$034084 JUMP LOCATION
Sprite_FakeSwordTrampoline:
{
    JSL Sprite_FakeSwordLong
    
    RTS
}

; ==============================================================================

; $034085-$034089 JUMP LOCATION
SpritePrep_FakeSwordTrampoline:
{
    JSL SpritePrep_FakeSword
    
    RTS
}

; ==============================================================================

; $03408A-$03408E JUMP LOCATION
Sprite_ElderTrampoline:
{
    JSL Sprite_ElderLong
    
    RTS
}

; ==============================================================================

; $03408F-$034093 JUMP LOCATION
Sprite_PotionShopTrampoline:
{
    JSL Sprite_PotionShopLong
    
    RTS
}

; ==============================================================================

; $034094-$034098 JUMP LOCATION
SpritePrep_PotionShopTrampoline:
{
    JSL SpritePrep_PotionShopLong
    
    RTS
}

; ==============================================================================

; $034099-$03409D JUMP LOCATION
Sprite_HeartContainerTrampoline:
{
    JSL Sprite_HeartContainerLong
    
    RTS
}

; ==============================================================================

; $03409E-$0340A2 JUMP LOCATION
SpritePrep_HeartContainerTrampoline:
{
    JSL SpritePrep_HeartContainerLong
    
    RTS
}

; ==============================================================================

; $0340A3-$0340A7 JUMP LOCATION
Sprite_HeartPieceTrampoline:
{
    JSL Sprite_HeartPieceLong
    
    RTS
}

; ==============================================================================

; $0340A8-$0340AC JUMP LOCATION
SpritePrep_HeartPieceTrampoline:
{
    JSL SpritePrep_HeartPieceLong
    
    RTS
}

; ==============================================================================

; $0340AD-$0340B1 JUMP LOCATION (UNUSED)
FluteBoy_UnusedInvocation:
{
    JSL Sprite_FluteBoy
    
    RTS
}

; ==============================================================================

; $0340B2-$0340B6 JUMP LOCATION
Sprite_UnusedTelepathTrampoline:
{
    JSL Sprite_UnusedTelepathLong
    
    RTS
}

; ==============================================================================

; $0340B7-$0340BB JUMP LOCATION
Sprite_HumanMulti_1_Trampoline:
{
    JSL Sprite_HumanMulti_1_Long
    
    RTS
}

; ==============================================================================

; $0340BC-$0340C0 JUMP LOCATION
Sprite_SweepingLadyTrampoline:
{
    JSL Sprite_SweepingLadyLong
    
    RTS
}

; ==============================================================================

; $0340C1-$0340C5 JUMP LOCATION
Sprite_LumberjacksTrampoline:
{
    JSL Sprite_LumberjacksLong
    
    RTS
}

; ==============================================================================

; $0340C6-$0340CA JUMP LOCATION
Sprite_FortuneTellerTrampoline:
{
    JSL Sprite_FortuneTellerLong
    
    RTS
}

; ==============================================================================

; $0340CB-$0340CF JUMP LOCATION
Sprite_MazeGameLadyTrampoline:
{
    JSL Sprite_MazeGameLadyLong
    
    RTS
}

; ==============================================================================

; $0340D0-$0340D4 JUMP LOCATION
Sprite_MazeGameGuyTrampoline:
{
    JSL Sprite_MazeGameGuyLong
    
    RTS
}

; ==============================================================================

; $0340D5-$0340D9 JUMP LOCATION
Sprite_TalkingTreeTrampoline:
{
    JSL Sprite_TalkingTreeLong
    
    RTS
}

; ==============================================================================

incsrc "sprite_movable_statue.asm"
incsrc "sprite_weathervane_trigger.asm"
incsrc "sprite_ponds.asm"
incsrc "sprite_leever.asm"
incsrc "sprite_heart_refill.asm"
incsrc "sprite_fairy.asm"
incsrc "sptite_absorbable.asm"
incsrc "sprite_octorock.asm"
incsrc "sprite_octostone.asm"
incsrc "sprite_octoballoon.asm"
incsrc "sprite_octospawn.asm"
incsrc "sprite_buzzblob.asm"

; ==============================================================================

; $0359C0-$0359D4 LOCAL JUMP LOCATION
Sprite_WallInducedSpeedInversion:
{
    LDA.w $0E70, X : AND.b #$03 : BEQ .no_horiz_collision
    
    JSR Sprite_InvertHorizSpeed
    
    .no_horiz_collision
    
    LDA.w $0E70, X : AND.b #$0C : BEQ .no_vert_collision
    
    JSR Sprite_InvertVertSpeed
    
    .no_vert_collision
    
    RTS
}

; ==============================================================================

; $0359D5-$0359E1 LOCAL JUMP LOCATION
Sprite_Invert_XY_Speeds:
{
    JSR Sprite_InvertVertSpeed
    
    ; $0359D8 ALTERNATE ENTRY POINT
    shared Sprite_InvertHorizSpeed:
    
    ; Flip sign of X velocity
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0359E2-$0359EB LOCAL JUMP LOCATION
Sprite_InvertVertSpeed:
{
    ; Flip sign of Y velocity
    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
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
{
    ; \task Needs naming, but probably just a simple conversion to a pool.
    db $A0, $A2, $A0, $A2, $80, $82, $80, $82
    db $EA, $EC, $84, $4E, $61, $BD, $8C, $20
    
    db $22, $C0, $C2, $E6, $E4, $82, $AA, $84
    db $AC, $80, $A0, $CA, $AF, $29, $39, $0B
    
    db $6E, $60, $62, $63, $4C, $EA, $EC, $24
    db $6B, $24, $22, $24, $26, $20, $30, $21
    
    db $2A, $24, $86, $88, $8A, $8C, $8E, $A2
    db $A4, $A6, $A8, $AA, $84, $80, $82, $6E
    
    db $40, $42, $E6, $E8, $80, $82, $C8, $8D
    db $E3, $E5, $C5, $E1, $04, $24, $0E, $2E
    
    db $0C, $0A, $9C, $C7, $B6, $B7, $60, $62
    db $64, $66, $68, $6A, $E4, $F4, $02, $02
    
    db $00, $04, $C6, $CC, $CE, $28, $84, $82
    db $80, $E5, $24, $00, $02, $04, $A0, $AA
    
    db $A4, $A6, $AC, $A2, $A8, $A6, $88, $86
    db $8E, $AE, $8A, $42, $44, $42, $44, $64
    
    db $66, $CC, $CC, $CA, $87, $97, $8E, $AE
    db $AC, $8C, $8E, $AA, $AC, $D2, $F3, $84
    
    db $A2, $84, $A4, $E7, $8A, $A8, $8A, $A8
    db $88, $A0, $A4, $A2, $A6, $A6, $A6, $A6
    
    db $7E, $7F, $8A, $88, $8C, $A6, $86, $8E
    db $AC, $86, $BB, $AC, $A9, $B9, $AA, $BA
    
    db $BC, $8A, $8E, $8A, $86, $0A, $C2, $C4
    db $E2, $E4, $C6, $EA, $EC, $FF, $E6, $C6
    
    db $CC, $EC, $CE, $EE, $4C, $6C, $4E, $6E
    db $C8, $C4, $C6, $88, $8C, $24, $E0, $AE
    
    db $C0, $C8, $C4, $C6, $E2, $E0, $EE, $AE
    db $A0, $80, $EE, $C0, $C2, $BF, $8C, $AA
    
    db $86, $A8, $A6, $2C, $28, $06, $DF, $CF
    db $A9, $46, $46, $EA, $C0, $C2, $E0, $E8
    
    db $E2, $E6, $E4, $0B, $8E, $A0, $EC, $EA
    db $E9, $48, $58
}

; ==============================================================================

; $035B04-$035BEF DATA
{
    db $C8, $00, $6B, $00, $00, $00, $00, $00
    db $00, $CB, $00, $08, $0A, $0B, $00, $00
    
    db $0D, $00, $00, $56, $00, $00, $0F, $11
    db $00, $13, $00, $00, $00, $00, $14, $00
    
    db $15, $1B, $00, $2A, $2A, $F8, $00, $B6
    db $00, $00, $00, $AA, $00, $00, $1C, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $F3
    db $F3, $00, $BB, $27, $00, $00, $42, $00
    
    ; 0x40
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $0F, $3F, $00, $00, $00, $40, $40
    
    db $44, $00, $00, $00, $00, $47, $46, $00
    db $00, $48, $4A, $65, $65, $00, $00, $00
    
    db $00, $00, $8F, $00, $00, $4C, $4E, $4E
    db $4E, $4E, $00, $30, $24, $32, $38, $3C
    
    db $81, $00, $52, $00, $00, $00, $00, $00
    db $00, $5C, $00, $62, $5E, $00, $00, $00
    
    ; 0x80
    db $65, $66, $00, $00, $00, $00, $6E, $0E
    db $00, $3B, $42, $00, $00, $75, $78, $7B
    
    db $00, $00, $CF, $00, $84, $8D, $8D, $8D
    db $8D, $00, $94, $75, $A0, $00, $00, $A2
    
    db $A6, $00, $00, $00, $B1, $00, $B5, $00
    db $BD, $00, $00, $00, $69, $00, $00, $00
    
    db $00, $00, $5C, $00, $D6, $E6, $00, $00
    db $00, $DB, $DA, $E9, $00, $00, $BE, $C0
    
    ; 0xc0
    db $6A, $00, $F9, $D7, $00, $00, $00, $D8
    db $00, $00, $DE, $E3, $00, $00, $00, $EB
    
    db $00, $00, $00, $00, $00, $00, $F4, $F4
    db $1D, $1F, $1F, $1F, $20, $20, $20, $21
    
    ; 0xe0
    db $22, $23, $23, $25, $28, $6A, $F6, $29
    db $00, $00, $CD, $CE
}

; ==============================================================================

; $035BF0-$035BF7 LONG JUMP LOCATION
Sprite_PrepAndDrawSingleLargeLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_PrepAndDrawSingleLarge
    
    PLB
    
    RTL
}

; ==============================================================================

; $035BF8-$035BFF LONG JUMP LOCATION
Sprite_PrepAndDrawSingleSmallLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_PrepAndDrawSingleSmall
    
    PLB
    
    RTL
}

; ==============================================================================

; $035C00-$035C0F
{
    ; This data seems to be unused.
    db 0, 0, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3
}

; $035C10-$035C53 LOCAL JUMP LOCATION
Sprite_PrepAndDrawSingleLarge:
{
    JSR Sprite_PrepOamCoord
    
    ; $035C13 ALTERNATE ENTRY POINT
    .just_draw
    
    LDA.b $00 : STA ($90), Y
    
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$01 : ROL A : STA ($92)
    
    REP #$20
    
    LDA.b $02 : INY
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .out_of_bounds_y
    SBC.b #$0F : STA ($90), Y
    
    PHY
    
    LDY.w $0E20, X
    
    LDA.w $DB04, Y : CLC : ADC.w $0DC0, X : TAY
    
    LDA.w $DA09, Y : PLY : INY : STA ($90), Y
    LDA.b $05            : INY : STA ($90), Y
    
    .out_of_bounds_y

    ; $035C4C ALTERNATE ENTRY POINT
Sprite_DrawShadowRedundant:
    
    ; Optinally draw a shadow for the sprite if this flag is set.
    LDA.w $0E60, X : AND.b #$10 : BNE Sprite_DrawShadow
    
    RTS
}

; ==============================================================================

; $035C54-$035C5B LONG JUMP LOCATION
Sprite_DrawShadowLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_DrawShadow
    
    PLB
    
    RTL
}

; ==============================================================================

; $035C5C-$035C63 LONG JUMP LOCATION
Pool_Sprite_DrawShadowLong:
{
    .variable
    
    PHB : PHK : PLB
    
    JSR Sprite_DrawShadow.variable
    
    PLB
    
    RTL
}

; ==============================================================================

; $035C64-$035CEE LOCAL JUMP LOCATION
Sprite_DrawShadow:
{
    ; This draws the shadow underneath a sprite
    
    LDA.b #$0A
    
    ; $035C66 ALTERNATE ENTRY POINT
    .variable
    
               CLC : ADC.w $0D00, X : STA.b $02
    LDA.w $0D20, X : ADC.b #$00   : STA.b $03
    
    ; Is the sprite disabled ("paused", you might say)
    LDA.w $0F00, X : BNE .dontDrawShadow
    LDA.w $0DD0, X : CMP.b #$0A : BNE .notBeingCarried
        LDA.l $7FFA1C, X : CMP.b #$03 : BEQ .dontDrawShadow
    
    .notBeingCarried
    
    REP #$20
    
    LDA.b $02 : SEC : SBC.b $E8 : STA.b $02
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .offScreenY
        LDA.w $0E40, X : AND.b #$1F : ASL #2 : TAY
        
        LDA.b $00 : STA ($90), Y
        
        LDA.w $0E60, X : AND.b #$20 : BEQ .delta
            INY
            
            ; This instruction doesn't seem to belong here, as it doesn't do anything
            ; (There's another LDA right after it)
            ; \optimize Simply by taking it out, saves space and time.
            LDA ($90), Y
            
                LDA.b $02    : INC A : STA ($90), Y
            INY : LDA.b #$38         : STA ($90), Y
            
            LDA.b $05 : AND.b #$30 : ORA.b #$08 : INY : STA ($90), Y
            
            TYA : LSR #2 : TAY
            
            ; Ensures the lowest priority for the shadow
            LDA.b $01 : AND.b #$01 : STA ($92), Y
    
    .dontDrawShadow
    
    RTS
    
    .delta
    
    LDA.b $02    : INY : STA ($90), Y
    LDA.b #$6C : INY : STA ($90), Y
    
    LDA.b $05 : AND.b #$30 : ORA.b #$08
    
    INY : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b $01 : AND.b #$01 : ORA.b #$02 : STA ($92), Y
    
    .offScreenY
    
    RTS
}

; ==============================================================================

; $035CEF-$035D37 LOCAL JUMP LOCATION
Sprite_PrepAndDrawSingleSmall:
{
    JSR Sprite_PrepOamCoord
    
    LDA.b $00 : STA ($90), Y
    
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$00 : ROL A : STA ($92)
    
    REP #$20
    
    LDA.b $02 : INY
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCS .BRANCH_ALPHA
    
    SBC.b #$0F : STA ($90), Y
    
    PHY
    
    LDY.w $0E20, X
    
    LDA.w $DB04, Y : CLC : ADC.w $0DC0, X : TAY
    
    LDA.w $DA09, Y : PLY : INY : STA ($90), Y
    LDA.b $05            : INY : STA ($90), Y
    
    .BRANCH_ALPHA
    
    LDA.w $0E60, X : AND.b #$10 : BEQ .BRANCH_BETA
    
    LDA.b #$02
    
    JMP Sprite_DrawShadow.variable
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $035D38-$035D3F LONG JUMP LOCATION
DashKey_Draw:
{
    PHB : PHK : PLB
    
    JSR Sprite_DrawKey
    
    PLB
    
    RTL
}

; ==============================================================================

; $035D40-$035DAE LOCAL JUMP LOCATION
Sprite_DrawKey:
    shared Sprite_DrawThinAndTall:
{
    JSR Sprite_PrepOamCoord
    
    LDA.b $00    : STA ($90), Y
    LDY.b #$04 : STA ($90), Y
    
    ; Get bit 8 of X coordinate, and force size to 8x8.
    LDA.b $01 : CMP.b #$01
    
    LDA.b #$00 : ROL A
    
    LDY.b #$00 : STA ($92), Y
    INY        : STA ($92), Y
    
    REP #$20
    
    LDA.b $02 : LDY.b #$01 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_upper_half_y
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_upper_half_y
    
    LDA.b $02 : CLC : ADC.w #$0008
    
    LDY.b #$05 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_lower_half_y
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_lower_half_y
    
    SEP #$20
    
    LDY.w $0E20, X
    
    LDA.w $DB04, Y : CLC : ADC.w $0DC0, X : TAY
    
    LDA.w $DA09, Y : LDY.b #$02 : STA ($90), Y
    CLC : ADC.b #$10   : LDY.b #$06 : STA ($90), Y
    LDA.b $05      : LDY.b #$03 : STA ($90), Y
                   LDY.b #$07 : STA ($90), Y
    
    JMP Sprite_DrawShadowRedundant
}

; ==============================================================================

incsrc "sprite_held_mode.asm"

; ==============================================================================

; $035FF2-$035FF9 LONG JUMP LOCATION
ThrownSprite_TileAndPeerInteractionLong:
{
    PHB : PHK : PLB
    
    JSR ThrownSprite_TileAndPeerInteraction
    
    PLB
    
    RTL
}

; ==============================================================================

; $035FFA-$036163 JUMP LOCATION
SpriteStunned_Main:
{
    JSR.w $E2B6 ; $0362B6 IN ROM
    JSR Sprite_CheckIfActive.permissive
    
    LDA.w $0EA0, X : BEQ .not_recoiling
                   BPL .recoil_timer_ticking
    
    STZ.w $0EA0, X
    
    .recoil_timer_ticking
    
    JSR Sprite_Zero_XY_Velocity
    
    .not_recoiling
    
    ; Even though the sprite is stunned, there is still a 32 frame delay
    ; before it can be damaged.
    LDA.w $0DF0, X : CMP.b #$20 : BCS .delay_vulnerability
    
    JSR Sprite_CheckDamageFromPlayer
    
    .delay_vulnerability
    
    JSR Sprite_CheckIfRecoiling
    JSR Sprite_Move
    
    LDA.w $0E90, X : BNE .skip_tile_collision_logic
    
    JSR Sprite_CheckTileCollision
    
    LDA.w $0DD0, X : BEQ .BRANCH_EPSILON
    
    ; $03602A ALTERNATE ENTRY POINT
    shared ThrownSprite_TileAndPeerInteraction:
    
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
    
    JSR.w $E229 ; $036229 IN ROM
    
    LDA.w $0DD0, X : CMP.b #$0B : BNE .not_frozen
    
    ; Play clink sound because frozen sprite hit a wall.
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    .no_tile_collision
    .not_frozen
    .skip_tile_collision_logic
    
    ; Check collision against boundary of the area we're in? (not solid
    ; tiles, the actual border of the area / room).
    LDY.b #$68 : JSR.w $E73C ; $03673C IN ROM
    
    PHX
    
    LDA.w $0E20, X : TAX
    
    LDA.l $0DB359, X : PLX : AND.b #$10 : BEQ .BRANCH_ZETA
    
    LDA.w $0E60, X : ORA.b #$10 : STA.w $0E60, X
    
    LDA.w $0FA5 : CMP.b #$20 : BNE .BRANCH_ZETA
    
    ; Just unsets draw shadow flag (no reason to when over a pit)
    JSR.w $8612 ; $030612 IN ROM
    
    .BRANCH_ZETA
    
    JSR Sprite_MoveAltitude
    
    ; Applies gravity to the sprite
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : DEC A : CMP.b #$F0 : BCS .BRANCH_THETA
    
    JMP.w $E149 ; $036149 IN ROM
    
    .BRANCH_THETA
    
    STZ.w $0F70, X
    
    LDA.w $0E20, X : CMP.b #$E8 : BNE .not_fake_master_sword
    
    LDA.w $0F80, X : CMP.b #$E8 : BPL .BRANCH_IOTA
    
    ; Fake master sword has a special death animation where it sort of...
    ; poofs.
    LDA.b #$06 : STA.w $0DD0, X
    
    LDA.b #$08 : STA.w $0DF0, X
    
    ; $036095 ALTERNATE ENTRY POINT
    
    LDA.b #$03 : STA.w $0E40, X
    
    .BRANCH_EPSILON
    
    RTS
    
    .BRANCH_IOTA
    .not_fake_master_sword
    
    ; Only applies to throwable scenery.
    JSR.w $E22F ; $03622F IN ROM
    
    LDA.w $0FA5 : CMP.b #$20 : BNE .BRANCH_KAPPA
    
    LDA.w $0B6B, X : LSR A : BCS .BRANCH_KAPPA
    
    ; $0360AB ALTERNATE ENTRY POINT
    
    ; \task So... 0x01 is for outdoors, and 0x05 falling state is for
    ; indoors? Double and triple check this as it alters the necessary
    ; naming scheme.
    ; Set it so the object is falling into a pit
    LDA.b #$01 : STA.w $0DD0, X
    LDA.b #$1F : STA.w $0DF0, X
    
    STZ.w $012E
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    RTS
    
    .BRANCH_KAPPA
    
    CMP.b #$09 : BNE .BRANCH_LAMBDA
    
    LDA.w $0F80, X : STZ.w $0F80, X : CMP.b #$F0 : BPL .BRANCH_MU
    
    LDA.b #$EC
    
    JSL Sprite_SpawnDynamically : BMI .BRANCH_MU
    
    JSL Sprite_SetSpawnedCoords
    
    PHX
    
    TYX
    
    JSR.w $E0F6 ; $0360F6 IN ROM
    
    PLX
    
    BRA .BRANCH_MU
    
    .BRANCH_LAMBDA
    
    CMP.b #$08 : BNE .BRANCH_MU
    
    LDA.w $0E20, X : CMP.b #$D2 : BEQ .is_flopping_fish
    
    JSL GetRandomInt : LSR A : BCC .anospawn_leaping_fish
    
    .is_flopping_fish
    
    JSR Fish_SpawnLeapingFish
    
    .anospawn_leaping_fish
    
    ; $0360F6 ALTERNATE ENTRY POINT
    
    JSL Sound_SetSfxPan : ORA.b #$28 : STA.w $012E
    
    LDA.b #$03 : STA.w $0DD0, X
    
    LDA.b #$0F : STA.w $0DF0, X
    
    STZ.w $0D80, X
    
    JSL GetRandomInt : AND.b #$01
    
    JMP.w $E095 ; $036095 IN ROM
    
    .BRANCH_MU
    
    LDA.w $0F80, X : BPL .BRANCH_OMICRON
    
    EOR.b #$FF : INC A : LSR A : CMP.b #$09 : BCS .BRANCH_PI
    
    LDA.b #$00
    
    .BRANCH_PI
    
    STA.w $0F80, X
    
    .BRANCH_OMICRON
    
    ; Is this arithmetic shift right? Clever, if so.
    LDA.w $0D50, X : ASL A : ROR.w $0D50, X
    
    LDA.w $0D50, X : CMP.b #$FF : BNE .BRANCH_RHO
    
    STZ.w $0D50, X
    
    .BRANCH_RHO
    
    LDA.w $0D40, X : ASL A : ROR.w $0D40, X
    
    LDA.w $0D40, X : CMP.b #$FF : BNE .BRANCH_SIGMA
    
    STZ.w $0D40, X
    
    ; $036149 ALTERNATE ENTRY POINT
    .BRANCH_SIGMA
    
    LDA.w $0DD0, X : CMP.b #$0B : BNE .BRANCH_TAU
    
    LDA.l $7FFA3C, X : BEQ .BRANCH_UPSILON
    
    .BRANCH_TAU
    
    JSR Sprite_CheckIfLifted
    
    LDA.w $0E20, X : CMP.b #$4A : BEQ .BRANCH_UPSILON
    
    JSR ThrownSprite_CheckDamageToPeers
    
    .BRANCH_UPSILON
    
    RTS
}

; ==============================================================================

; $036164-$036171 LOCAL JUMP LOCATION
ThrowableScenery_InteractWithSpritesAndTiles:
{
    JSR Sprite_Move
    
    LDA.w $0E90, X : BNE .skip_tile_collision
    
    JSR Sprite_CheckTileCollision
    
    .skip_tile_collision
    
    JMP ThrownSprite_TileAndPeerInteraction
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
    
    TYA : EOR.b $1A : AND.b #$03 : ORA.w $0BA0, Y
                                 ORA.w $0EF0, Y : BNE .cant_damage
    
    LDA.w $0F20, X : CMP.w $0F20, Y : BNE .cant_damage
    
    JSR ThrownSprite_CheckDamageToSinglePeer
    
    .cant_damage
    .cant_damage_self
    
    PLY : DEY : BPL .next_sprite_slot
    
    .no_momentum
    .delay_damaging_others
    
    RTS
}

; ==============================================================================

; $0361B2-$03626D LOCAL JUMP LOCATION
ThrownSprite_CheckDamageToSinglePeer:
{
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $08
    
    LDA.b #$0F : STA.b $02
    
    LDA.w $0D00, X : SEC : SBC.w $0F70, X : PHP : CLC : ADC.b #$08 : STA.b $01
    LDA.w $0D2020, X : ADC.b #$00   : PLP : SBC.b #$00 : STA.b $09
    
    LDA.b #$08 : STA.b $03
    
    PHX
    
    TYX
    
    JSR Sprite_SetupHitBox
    
    PLX
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_361B1 ; (RTS)
    
    LDA.w $0E20, Y : CMP.b #$3F : BNE .notTutorialSoldier
    
    JSL Sprite_PlaceRupulseSpark
    
    BRA .BRANCH_BETA
    
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
    
    JSL Ancilla_CheckSpriteDamage.preset_class
    
    PLY : PLX
    
    LDA.w $0D50, X : ASL A : STA.w $0F40, Y
    LDA.w $0D40, X : ASL A : STA.w $0F30, Y
    
    LDA.b #$10 : STA.w $0F10, X
    
    ; $036229 ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    JSR Sprite_Invert_XY_Speeds
    JSR Sprite_Halve_XY_Speeds
    
    ; $03622F ALTERNATE ENTRY POINT
    
    ; Not a bush...
    LDA.w $0E20, X : CMP.b #$EC : BNE .BRANCH_DELTA
    
    STZ.w $0FAC
    
    ; $036239 ALTERNATE ENTRY POINT
    
    LDA.w $0DC0, X : BEQ .BRANCH_EPSILON
    
    STA.w $0B9C
    
    JSR Sprite_SpawnSecret
    
    STZ.w $0B9C
    
    .BRANCH_EPSILON
    
    LDY.w $0DB0, X
    
    LDA.b $1B : BEQ .BRANCH_ZETA
    
    LDY.b #$00
    
    .BRANCH_ZETA
    
    STZ.w $012E
    
    LDA.w $E272, Y : JSL Sound_SetSfx2PanLong
    
    ; $03625A ALTERNATE ENTRY POINT
    shared Sprite_ScheduleForBreakage:
    
    LDA.b #$1F
    
    ; $03625C ALTERNATE ENTRY POINT
    shared Sprite_CustomTimedScheduleForBreakage:
    
    STA.w $0DF0, Y
    
    ; Break this pot...
    LDA.b #$06 : STA.w $0DD0, X
    
    LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
    
    .BRANCH_DELTA
    
    RTS
}

; ==============================================================================

; $03626E-$03627C LOCAL JUMP LOCATION
Sprite_Halve_XY_Speeds:
{
    ; This sequence does an arithmetic (not logical!) shift right on
    ; the x and y speeds, which effectively reduces them by
    LDA.w $0D50, X : ASL A
    
    ROR.w $0D50, X
    
    LDA.w $0D40, X : ASL A
    
    ROR.w $0D40, X
    
    RTS
}

; ==============================================================================

; $036286-$0362A6 LOCAL JUMP LOCATION
Fish_SpawnLeapingFish:
{
    ; I think this is the routine called to spawn the fish that jump out
    ; of the water after a rock or similar is thrown into the water.
    
    LDA.b #$D2 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$02 : STA.w $0D80, Y
    
    LDA.b #$30 : STA.w $0DF0, Y
    
    LDA.w $0E20, X : CMP.b #$D2 : BNE .not_spawned_from_other_fish
    
    ; \task Give a 20 rupee reward? Is that what this controls?
    ; Only make a grateful fish leap up if it was one rescued from water,
    ; not a fish that was perturbed by something else being thrown into
    ; the water, like a skull rock / bush / frozen sprite.
    STA.w $0D90, Y
    
    .not_spawned_from_other_fish
    .spawn_failed
    
    RTS
}

; $0362B6-$036342 LOCAL JUMP LOCATION
{
    JSL Sprite_DrawRippleIfInWater
    
    ; $0362BA ALTERNATE ENTRY POINT
    
    JSR SpriteActive_Main
    
    LDA.l $7FFA3C, X : BEQ .BRANCH_ALPHA
    
    LDA.w $0DF0, X : CMP.b #$20 : BCS .BRANCH_BETA
    
    ; \note Think this sets a blue palette?
    LDA.w $0F50, X : AND.b #$F1 : ORA.b #$04 : STA.w $0F50, X
    
    .BRANCH_BETA
    
    LDA.w $0DF0, X : LSR #4 : TAY
    
    TXA : ASL #4 : EOR.b $1A : ORA.b $11 : AND.w $E2AF, Y : BNE .BRANCH_GAMMA
    
    JSL GetRandomInt : AND.b #$03 : TAY
    
    LDA.w $E2A7, Y : STA.b $00
    LDA.w $E2AB, Y : STA.b $01
    
    JSL GetRandomInt : AND.b #$03 : TAY
    
    LDA.w $E2A7, Y : STA.b $02
    LDA.w $E2AB, Y : STA.b $03
    
    JSL Sprite_SpawnSimpleSparkleGarnish
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b $1A : AND.b #$01 : ORA.b $11 : ORA.w $0FC1 : BNE .BRANCH_DELTA
    
    LDA.w $0B58, X              : BEQ .BRANCH_EPSILON
    DEC.w $0B58, X : CMP.b #$38 : BCS .BRANCH_DELTA
    
    AND.b #$01 : TAY
    
    LDA .wiggle_x_speeds, Y : STA.w $0D50, X
    
    JSR Sprite_MoveHoriz
    
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
    
    .oam_sizes
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $02, $02, $02, $02
    db $02, $02, $02, $02
}

; ==============================================================================

; $036393-$036415 JUMP LOCATION
SpritePoof_Main:
{
    ; Sprite state 0x02
    
    ; Check this timer
    LDA.w $0DF0, X : BNE .just_draw
    
    ; See if the enemy is a buzzblob
    LDA.w $0E20, X : CMP.b #$0D : BNE .not_tranny_buzzblob
    
    ; Thinking this is a transformed buzz blob exception.
    LDY.w $0EB0, X : BEQ .not_tranny_buzzblob
    
    LDY.w $0D10, X : PHY
    LDY.w $0D30, X : PHY
    
    JSR.w $F9D1 ; $0379D1 IN ROM
    
    PLA : STA.w $0D30, X
    PLA : STA.w $0D10, X
    
    STZ.w $0F80, X
    STZ.w $0BA0, X
    
    RTS
    
    .not_tranny_buzzblob
    
    LDA.w $0CBA, X : BNE .has_specific_drop_item
    
    LDY.b #$02
    
    JMP.w $F9BC ; $0379BC IN ROM
    
    .has_specific_drop_item
    
    JMP.w $F923 ; $037923 IN ROM
    
    .just_draw
    
    JSR Sprite_PrepOamCoord
    
    LDA.w $0DF0, X : LSR A : AND.b #$FC : STA.b $00
    
    PHX
    
    LDX.b #$03
    
    .next_oam_entry
    
    PHX
    
    TXA : CLC : ADC.b $00 : TAX
    
    LDA.w $0FA8 : CLC : ADC .x_offsets, X        : STA ($90), Y
    LDA.w $0FA9 : CLC : ADC .y_offsets, X  : INY : STA ($90), Y
                LDA .chr, X        : INY : STA ($90), Y
                LDA .properties, X : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA .oam_sizes, X : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b #$03
    
    JMP Sprite_CorrectOamEntries
}

; ==============================================================================

; $036416-$036419 LONG JUMP LOCATION
Sprite_PrepOamCoordLong:
{
    JSR Sprite_PrepOamCoordSafeWrapper
    
    RTL
}

; ==============================================================================

; $03641A-$03641D LOCAL JUMP LOCATION
Sprite_PrepOamCoordSafeWrapper:
{
    ; This wrapper is considered 'Safe' because it negates the caller
    ; termination property of 'Sprite_PrepOamCoord' by using this routine
    ; as a sacrificial intermediate. Since this subroutine only does
    ; one useful task, exiting from it early will not interrupt the caller
    ; of this subroutine, which can potentially happen if
    ; 'Sprite_PrepOamCoord' is called directly
    
    JSR Sprite_PrepOamCoord
    
    RTS
}

; ==============================================================================

; $03641E-$036495 LOCAL JUMP LOCATION
Sprite_PrepOamCoord:
{
    ; Enable the sprite to move.
    STZ.w $0F00, X
    
    REP #$20
    
    ; X coordinate for the sprite
    LDA.w $0FD8 : SEC : SBC.b $E2 : STA.b $00
    
    ; A = (Sprite's X coord - far left of screen X coord) + 0x40
    ; Y coordinate is at most 255, so make 8 bit.
    ; If A >= 0x170 don't display at all
    CLC : ADC.w #$0040 : CMP.w #$0170 : SEP #$20 : BCS .x_out_of_bounds
    ; How high off the ground is the object?
    LDA.w $0F70, X : STA.b $04
    STZ.b $05
    
    REP #$20
    
    ; Link's Y coord. Subtract the Y coordinate of the camera.
    LDA.w $0FDA : SEC : SBC.b $E8 : PHA
    
    ; Offset by how far the object is off the ground, to be fair.
    SEC : SBC.b $04 : STA.b $02
    
    ; Grab the non height adjusted value.
    ; Add in 0x40 and see if it's >= 0x0170
    ; If sufficiently off screen don't render at all
    PLA : CLC : ADC.w #$0040 : CMP.w #$0170 : SEP #$20 : BCC .y_inbounds
        ; Not sure what $0F60, X does yet... (room relevance?)
        LDA.w $0F60, X : AND.b #$20 : BEQ .immobilize_sprite
    
    .y_inbounds
    
    ; Signals the sprite is fine...?
    CLC
    
    .finish_up
    
    ; What palette is the sprite using?
    ; Xor it with sprite priority
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
    JSL Sprite_SelfTerminate
    
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
    
    JSR Sprite_CheckTileCollision
    
    PLB
    
    LDA.w $0E70, X
    
    RTL
}

; ==============================================================================

; $0364A1-$0364DA BRANCH LOCATION
Pool_Sprite_CheckTileCollision:
{
    .restore_layer_property
    
    LDA.w $0FB6 : STA.w $0F20, X
    
    RTS
    
    .restrict_to_same_layer
    
    JMP Sprite_CheckTileCollisionSingleLayer
    
    ; $0364AB MAIN ENTRY POINT
Sprite_CheckTileCollision:
    
    STZ.w $0E70, X
    
    LDA.w $0F60, X : BMI .restrict_to_same_layer
    
    LDA.w $046C : BEQ .restrict_to_same_layer
    
    LDA.w $0F20, X : STA.w $0FB6
    
    LDA.b #$01 : STA.w $0F20, X
    
    JSR Sprite_CheckTileCollisionSingleLayer
    
    LDA.w $046C : CMP.b #$04 : BEQ .restore_layer_property
    
    STZ.w $0F20, X
    
    JSR Sprite_CheckTileCollisionSingleLayer
    
    LDA.w $0FA5 : STA.l $7FFABC, X
    
    RTS
}

; ==============================================================================

; $0364DB-$0365B7 LOCAL JUMP LOCATION
Sprite_CheckTileCollisionSingleLayer:
{
    LDA.w $0E40, X : AND.b #$20 : BEQ .BRANCH_ALPHA
    
    LDY.b #$6A
    
    ; $03673C IN ROM
    JSR.w $E73C : BCC .BRANCH_BETA
    
    INC.w $0E70, X
    
    .BRANCH_BETA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.w $0F60, X : BMI .BRANCH_GAMMA
    
    LDA.w $046C : BNE .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    LDY.b #$00
    
    LDA.w $0D40, X : BEQ .BRANCH_EPSILON  BMI .BRANCH_ZETA
    
    INY
    
    .BRANCH_ZETA
    
    JSR.w $E5EE   ; $0365EE IN ROM
    
    .BRANCH_EPSILON
    
    LDY.b #$02
    
    LDA.w $0D50, X : BEQ .BRANCH_THETA  BMI .BRANCH_IOTA
    
    INY
    
    .BRANCH_IOTA
    
    JSR.w $E5B8   ; $0365B8 IN ROM
    
    .BRANCH_THETA
    
    BRA .BRANCH_KAPPA
    
    .BRANCH_DELTA
    
    LDY.b #$01
    
    .BRANCH_LAMBDA
    
    JSR.w $E5EE   ; $0365EE IN ROM
    
    DEY : BPL .BRANCH_LAMBDA
    
    LDY.b #$03
    
    .BRANCH_MU
    
    JSR.w $E5B8   ; $0365B8 IN ROM
    
    DEY : CPY.b #$01 : BNE .BRANCH_MU
    
    .BRANCH_KAPPA
    
    LDA.w $0BE0, X : BMI .BRANCH_NU
    
    LDA.w $0F70, X : BEQ .BRANCH_XI
    
    .BRANCH_NU
    
    RTS
    
    .BRANCH_XI
    
    LDY.b #$68
    
    JSR.w $E73C ; $03673C IN ROM
    
    LDA.w $0FA5 : STA.l $7FF9C2, X : CMP.b #$1C : BNE .BRANCH_OMICRON
    
    LDY.w $0FB3 : BEQ .BRANCH_OMICRON
    
    ; Is the enemy frozen?
    ; Nope
    LDY.w $0DD0, X : CPY.b #$0B : BNE .BRANCH_OMICRON
    
    LDA.b #$01 : STA.w $0F20, X
    
    RTS
    
    .BRANCH_OMICRON
    
    CMP.b #$20 : BNE .BRANCH_PI
    
    LDA.w $0B6B, X : AND.b #$01 : BEQ .BRANCH_RHO
    
    LDA.b $1B : BNE .BRANCH_SIGMA
    
    JMP.w $E0AB ; $0360AB IN ROM
    
    .BRANCH_SIGMA
    
    LDA.b #$05 : STA.w $0DD0, X
    
    LDA.b #$5F
    
    ; is it a helmasaur?
    LDY.w $0E20, X : CPY.b #$13 : BEQ .BRANCH_TAU
                   CPY.b #$26 : BNE .BRANCH_UPSILON
    
    .BRANCH_TAU
    
    LSR.w $0F50, X : ASL.w $0F50, X
    
    LDA.b #$3F
    
    .BRANCH_UPSILON
    
    STA.w $0DF0, X
    
    RTS
    
    .BRANCH_PI
    
    CMP.b #$0C : BNE .not_mothula_moving_floor
    
    LDA.l $7FFABC, X : CMP.b #$1C : BNE .BRANCH_PHI
    
    JSR.w $E624 ; $036624 IN ROM
    
    LDA.w $0E70, X : ORA.b #$20 : STA.w $0E70, X
    
    RTS
    
    .not_mothula_moving_floor
    .BRANCH_RHO
    
    CMP.b #$68 : BCC .not_conveyor_belt
    CMP.b #$6C : BCS .not_conveyor_belt
    
    .BRANCH_PSI
    
    TAY
    
    JSL Sprite_ApplyConveyorAdjustment
    
    RTS
    
    .not_conveyor_belt
    
    CMP.b #$08 : BNE .BRANCH_PHI
    
    LDA.w $046C : CMP.b #$04 : BNE .BRANCH_PHI
    
    ; I think this indicates that flowing water makes sprites move to the
    ; left in the same way a conveyor belt would.
    LDA.b #$6A
    
    BRA .BRANCH_PSI
    
    .BRANCH_PHI
    
    RTS
}

; $0365B8-$0365ED LOCAL JUMP LOCATION
{
    ; $03672F IN ROM
    JSR.w $E72F : BCC .BRANCH_ALPHA
    
    LDA.w $E723, Y : ORA.w $0E70, X : STA.w $0E70, X
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .BRANCH_ALPHA
    
    LDA.w $0EA0, X : BEQ .BRANCH_BETA
    
    ; \optimize If this code is reached, it's bound to be pretty damn slow.
    ; Mainly, it's calling the same code 3 times to do 3 additions, so
    ; why not just adjust the amounts in the table by a factor of 3?
    JSR .add_offset
    JSR .add_offset
    
    .add_offset
    
    LDA.w $0D10, X : CLC : ADC.w $E727, Y : STA.w $0D10, X
    LDA.w $0D30, X : ADC.w $E72B, Y : STA.w $0D30, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0365EE-$036623 LOCAL JUMP LOCATION
{
    ; $03672F IN ROM
    JSR.w $E72F : BCC .return
    
    LDA.w $E723, Y : ORA.w $0E70, X : STA.w $0E70, X
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .return
    
    LDA.w $0EA0, X : BEQ .add_offset
    
    ; \optimize If this code is reached, it's bound to be pretty damn slow.
    ; Mainly, it's calling the same code 3 times to do 3 additions, so
    ; why not just adjust the amounts in the table by a factor of 3?
    JSR .add_offset
    JSR .add_offset
    
    ; $036610 ALTERNATE ENTRY POINT
    .add_offset
    
    LDA.w $0D00, X : CLC : ADC.w $E727, Y : STA.w $0D00, X
    LDA.w $0D20, X : ADC.w $E72B, Y : STA.w $0D20, X
    
    .return
    
    RTS
}

; $036624-$03664A LOCAL JUMP LOCATION
{
    LDA.w $0310 : CLC : ADC.w $0D00, X : STA.w $0D00, X
    LDA.w $0311 : ADC.w $0D20, X : STA.w $0D20, X
    LDA.w $0312 : CLC : ADC.w $0D10, X : STA.w $0D10, X
    LDA.w $0313 : ADC.w $0D30, X : STA.w $0D30, X
    
    RTS
}

; $03664B-$036722 DATA
{
    dw   8,   8,   2,  14,   8,   8,  -2,  10
    dw   8,   8,   1,  14,   4,   4,   4,   4
    dw   4,   4,  -2,  10,   8,   8, -25,  40
    dw   8,   8,   2,  14,   8,   8,  -8,  23
    dw   8,   8, -20,  36,   8,   8,  -1,  16
    dw   8,   8,  -1,  16,   8,   8,  -8,  24
    dw   8,   8,  -8,  24,   8,   3
    
    ; $366B7
    dw   6,  20,  13,  13,   0,   8,   4,   4
    dw   1,  14,   8,   8,   4,   4,   4,   4
    dw  -2,  10,   4,   4, -25,  40,   8,   8
    dw   3,  16,  10,  10,  -8,  25,   8,   8
    dw -20,  36,   8,   8,  -1,  16,   8,   8
    dw  14,   3,   8,   8,  -8,  24,   8,   8
    dw  -8,  32,   8,   8,  12,   4
}

; ==============================================================================

; $036723-$03672E DATA
{
    db 8,  4,  2,  1
    
    
    db 1, -1,  1, -1
    
    
    db 0, -1,  0, -1
}
    
; ==============================================================================

; $03672F-$03687A LOCAL JUMP LOCATION
{
    ; Seems that $08 is a value from 0 to 3 indicating the direction
    ; to check collision in... Pretty sure anyways.
    STY.b $08
    
    LDA.w $0B6B, X : AND.b #$F0 : LSR #2 : ADC.b $08 : ASL A : TAY
    
    ; $03673C ALTERNATE ENTRY POINT
    
    LDA.b $1B : BEQ .outdoors
    
    REP #$20
    
    ; Load Y coordinate of sprite
    LDA.w $0FDA : CLC : ADC.w #8 : AND.w #$01FF : CLC : ADC.w $E6B7, Y
    
    SEC : SBC.w #8 : STA.b $00 : CMP.w #$0200 : BCS .out_of_bounds
    
    ; Load X coordinate of sprite
    LDA.w $0FD8 : ADC.w #8 : AND.w #$01FF : CLC : ADC.w $E64B, Y
    
    SEC : SBC.w #8 : STA.b $02 : CMP.w #$0200
    
    BRA .check_if_inbounds
    
    .outdoors
    
    ; Overworld handling of collision (against perimeter?)
    REP #$20
    
    LDA.w $0FDA : CLC : ADC.w $E6B7, Y : STA.b $00
    
    SEC : SBC.w $0FBE : CMP.w $0FBA : BCS .out_of_bounds
    
    LDA.w $0FD8 : CLC : ADC.w $E64B, Y : STA.b $02
    
    SEC : SBC.w $0FBC : CMP.w $0FB8
    
    .out_of_bounds
    .check_if_inbounds
    
    SEP #$20 : BCC .inbounds
    
    JMP.w $E852 ; $036852 IN ROM
    
    .inbounds
    
    JSR Sprite_GetTileAttrLocal
    
    TAY
    
    LDA.w $0CAA, X : AND.b #$08 : BEQ .dont_use_simplified_tile_collision
    
    PHX
    
    TYX
    
    LDY.b $08
    
    LDA Sprite_SimplifiedTileAttr, X
    
    PLX
    
    CMP.b #$04 : BEQ .BRANCH_EPSILON
    CMP.b #$01 : BCC .BRANCH_ZETA
    
    LDA.w $0FA5
    
    CMP.b #$10 : BCC .not_sloped_tile
    CMP.b #$14 : BCS .not_sloped_tile
    
    JSR Entity_CheckSlopedTileCollision
    JMP.w $E878 ; $036878 IN ROM
    
    .not_sloped_tile
    
    JMP.w $E872 ; $036872 IN ROM
    
    .BRANCH_EPSILON
    
    LDY.b $1B : BNE .BRANCH_ZETA
    
    STA.w $0E90, X
    
    .BRANCH_ZETA
    
    JMP.w $E877 ; $036877 IN ROM
    
    .dont_use_simplified_tile_collision
    
    LDA.w $0BE0, X : ASL A : BPL .BRANCH_IOTA
    
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
    
    BEQ .BRANCH_OMICRON
    
    BRA .BRANCH_PI
    
    .BRANCH_IOTA
    
    PHX
    
    TYX
    
    LDA.l $1DF6CF, X
    
    PLX
    
    LDY.b $08
    
    CMP.b #$00 : BEQ .BRANCH_OMICRON
    
    LDA.w $0FA5
    
    CMP.b #$10 : BCC .BRANCH_RHO
    CMP.b #$14 : BCS .BRANCH_RHO
    
    JSR Entity_CheckSlopedTileCollision
    
    BRA .BRANCH_SIGMA
    
    .BRANCH_RHO
    
    CMP.b #$44 : BNE .not_spike_tile
    
    LDA.w $0EA0, X : BEQ .BRANCH_PI
    
    LDA.w $0CE2, X : BMI .BRANCH_UPSILON
    
    LDA.b #$04 : JSL Ancilla_CheckSpriteDamage.preset_class
    
    LDA.w $0EF0, X : BEQ .BRANCH_UPSILON
    
    LDA.b #$99 : STA.w $0EF0, X
    
    STZ.w $0EA0, X
    
    .BRANCH_UPSILON
    
    BRA .BRANCH_PI
    
    ; $036852 ALTERNATE ENTRY POINT
    
    JSR.w $E872 ; $036872 IN ROM
    
    LDA.w $0E40, X : ASL A : BPL .BRANCH_PHI
    
    STZ.w $0DD0, X
    
    CLC
    
    RTS
    
    .BRANCH_PHI
    
    SEC
    
    RTS
    
    .not_spike_tile
    
    CMP.b #$20 : BNE .not_pit_tile
    
    LDA.w $0B6B, X : AND.b #$01 : BEQ .BRANCH_PI
    
    LDA.w $0EA0, X : BNE .BRANCH_OMICRON
    
    ; $036872 ALTERNATE ENTRY POINT
    .not_pit_tile
    .BRANCH_PI
    
    SEC
    
    SEP #$21
    
    BRA .BRANCH_SIGMA
    
    ; $036877 ALTERNATE ENTRY POINT
    .BRANCH_OMICRON
    .deep_water_tile
    
    CLC
    
    ; $036878 ALTERNATE ENTRY POINT
    .BRANCH_SIGMA
    
    LDY.b $08
    
    RTS
}

; ==============================================================================

; $03687B-$036882 LONG JUMP LOCATION
Entity_GetTileAttr:
{
    PHB : PHK : PLB
    
    JSR Entity_GetTileAttrLocal
    
    PLB
    
    RTL
}

; ==============================================================================

; $036883-$0368D5 LOCAL JUMP LOCATION
Sprite_GetTileAttrLocal:
{
    ; Notes:
    ; $00[0x02] - Entity Y coordinate
    ; $02[0x03] - Entity X coordinate
    
    LDA.w $0F20, X ; Floor selector for sprites
    
    ; $036886 ALTERNATE ENTRY POINT
    shared Entity_GetTileAttrLocal:
    
    CMP.b #$01 : REP #$30 : STZ.b $05 : BCC .on_bg2
    
    LDA.w #$1000 : STA.b $05
    
    .on_bg2
    
    LDA.b $1B : AND.w #$00FF : BEQ .outdoors
    
    ; Horizontal Position
    LDA.b $02 : AND.w #$01FF : LSR #3 : STA.b $04
    
    ; Vertical position
    LDA.b $00 : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $05
    
    PHX
    
    TAX
    
    ; Retrieve tile type
    LDA.l $7F2000, X : PLX : SEP #$30 : STA.w $0FA5
    
    RTS
    
    .outdoors
    
    LDA.b $02 : LSR #3 : STA.b $02
    
    SEP #$10
    
    PHX : PHY
    
    JSL Overworld_GetTileAttrAtLocation : SEP #$30 : STA.w $0FA5
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $0368D6-$0368F5 DATA
Pool_Entity_CheckSlopedTileCollision:
{
    .subtile_boundaries
    db 7, 6, 5, 4, 3, 2, 1, 0
    db 0, 1, 2, 3, 4, 5, 6, 7
    db 0, 1, 2, 3, 4, 5, 6, 7
    db 7, 6, 5, 4, 3, 2, 1, 0
}

; ==============================================================================

; $0368F6-$0368FD LONG JUMP LOCATION
Entity_CheckSlopedTileCollisionLong:
{
    PHB : PHK : PLB
    
    JSR Entity_CheckSlopedTileCollision
    
    PLB
    
    RTL
}

; ==============================================================================

    ; \note Has to do with tile detection on tiles that have a slope to them
    ; (digonally)
    ; \task go into more detail figuring out how this works now that we have
    ; a foothold.
; $0368FE-$03692B LOCAL JUMP LOCATION
Entity_CheckSlopedTileCollision:
{
    ; Not sure what this routine does
    
    LDA.b $00 : AND.b #$07 : STA.b $04 ; $04 = ($00 & 0x07)
    LDA.b $02 : AND.b #$07 : STA.b $05 ; $05 = ($02 & 0x07)
    
    ; tile type that was detected in the previous routine ($36883 most likely)
    ; $06 = ($0FA5 - 0x10)
    ; \bug Maybe a bug.... what tile attributes are supposed to be used
    ; with this routine? Inspection suggests 0x18 through 0x1b, but this
    ; routine seems designed for 0x10 through 0x13. Hardly comforting...
    LDA.w $0FA5 : SEC : SBC.b #$10 : STA.b $06
    
    ; Y = ($06 << 3) + $05
    ASL #3 : CLC : ADC.b $05 : TAY
    
    ; If original attribute was between 0x10 and 0x12
    LDA.b $06 : CMP.b #$02 : BCC .alpha
    
    LDA.b $04 : CMP .subtile_boundaries, Y
    
    BRA .beta
    
    .alpha
    
    LDA .subtile_boundaries, Y : CMP $04
    
    .beta
    
    RTS
}

; ==============================================================================

    ; \optimize Has been identified as time consuming (relative to what it
    ; does in real terms). Similar functions in other banks will have
    ; similar performance.
; $03692C-$036931 LOCAL JUMP LOCATION
Sprite_Move:
{
    JSR .do_horiz
    JMP .do_vert
    
; $036932-$03693D LOCAL JUMP LOCATION
    shared Sprite_MoveHoriz:
    
    .do_horiz
    
    ; Do X position adjustment
    TXA : CLC : ADC.b #$10 : TAX
      
    JSR Sprite_MoveVert
    
    ; Reset sprite index so that we can do the Y position adjustment next.
    LDX.w $0FA0
    
    RTS
    
    .do_vert
    
; $03693E-$03696B LOCAL JUMP LOCATION
    shared Sprite_MoveVert:
    
    LDA.w $0D40, X : BEQ .return
    
    ASL #4 : CLC : ADC.w $0D60, X : STA.w $0D60, X
    
    LDA.w $0D40, X : PHP : LSR #4 : LDY.b #$00 : PLP : BPL .positive
    
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
    ; Do... altitude adjustment...?
    
    LDA.w $0F80, X : ASL #4 : CLC : ADC.w $0F90, X : STA.w $0F90, X
    
    LDA.w $0F80, X : PHP : LSR #4 : PLP : BPL .positive
    
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

; ==============================================================================

; $036991-$036A03 LOCAL JUMP LOCATION
Sprite_ProjectSpeedTowardsPlayer:
{
    ; Calculates a trajectory with a given magnitude.... but there's some
    ; broke ass trigonometry going on up in this bitch. Replacing
    ; this with the lookup tables in the dark prophecy hack could be
    ; a good idea.
    
    ; $01 is the magnitude or force of the trajectory. i should probably
    ; look up technical definitions of words like trajectory one of these
    ; days...
    
    STA.b $01 : CMP.b #$00 : BEQ Sprite_ProjectSpeedTowardsPlayer_return
    
    PHX : PHY
    
    JSR Sprite_IsBelowPlayer : STY.b $02
    
    ; Difference in the low Y coordinate bytes.
    LDA.b $0E : BPL .positive_1
    
    EOR.b #$FF : INC A
    ; Essentially, multiply by negative one, or in this context, absolute value.
    
    .positive_1
    
    ; $0C = |$0E| = |dY|
    STA.b $0C
    
    JSR Sprite_IsToRightOfPlayer : STY.b $03
    
    ; The difference in the low X coordinate bytes.
    LDA.b $0F : BPL .positive_2
    
    EOR.b #$FF : INC A
    
    .positive_2
    
    ; $0D = |$0F| = |dX|
    STA.b $0D
    
    LDY.b #$00
    
    ; If |dX| > |dY|
    LDA.b $0D : CMP $0C : BCS .dx_is_bigger
    
    ; Flag indicating |dY| >= |dX|
    INY
    
    ; |dX| -> Stack; |dY| -> $0D ; |dX| -> $0C.
    ; Either way, the larger value will end up at $0D
    PHA : LDA.b $0C : STA.b $0D
    PLA           : STA.b $0C
    
    .dx_is_bigger
    
    STZ.b $0B
    STZ.b $00
    
    LDX.b $01
    
    .still_have_velocity_to_apply 
    
    ; If ($0B + $0C) <= ($0D)
    LDA.b $0B : CLC : ADC.b $0C : CMP $0D : BCC .not_accumulated_yet
    
    ; Otherwise, just subtract the larger value and increment $00.
    SBC.b $0D
    
    ; Apportion velocity to the direction that has less magnitude for once.
    INC.b $00
    
    .not_accumulated_yet
    
    STA.b $0B
    
    DEX : BNE .still_have_velocity_to_apply
    
    TYA : BEQ .dx_is_bigger_2
    
    LDA.b $00 : PHA
    LDA.b $01 : STA.b $00
    PLA     : STA.b $01
    
    .dx_is_bigger_2
    
    LDA.b $00
    
    LDY.b $02 : BEQ .polarity_already_correct_1
    
    EOR.b #$FF : INC A : STA.b $00
    
    .polarity_already_correct_1
    
    LDA.b $01
    
    LDY.b $03 : BEQ .polarity_already_correct_2
    
    EOR.b #$FF : INC A : STA.b $01
    
    .polarity_already_correct_2
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $036A04-$036A11 LOCAL JUMP LOCATION
Sprite_ApplySpeedTowardsPlayer:
{
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $036A12-$036A19 LONG JUMP LOCATION
Sprite_ApplySpeedTowardsPlayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_ApplySpeedTowardsPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A1A-$036A21 LONG JUMP LOCATION
Sprite_ProjectSpeedTowardsPlayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A22-$036A29 LONG JUMP LOCATION
Sprite_ProjectSpeedTowardsEntityLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_ProjectSpeedTowardsEntity
    
    PLB
    
    RTL
}

; ==============================================================================

; $036A2A-$036A2C BRANCH LOCATION
Pool_Sprite_ProjectSpeedTowardsEntity:
{
    .return
    STZ.b $00
    
    RTS
}

; ==============================================================================

; $036A2D-$036A9F LOCAL JUMP LOCATION
Sprite_ProjectSpeedTowardsEntity:
{
    STA.b $01 : CMP.b #$00 : BEQ .return
    
    PHX : PHY
    
    JSR Sprite_IsBelowEntity : STY.b $02
    
    LDA.b $0E : BPL .positive_1
    
    EOR.b #$FF : INC A
    
    .positive_1
    
    STA.b $0C
    
    JSR Sprite_IsToRightOfEntity : STY.b $03
    
    LDA.b $0F : BPL .positive_2
    
    EOR.b #$FF : INC A
    
    .positive_2
    
    STA.b $0D
    
    LDY.b #$00
    
    LDA.b $0D : CMP $0C : BCS .dx_is_bigger
    
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
    LDA.b $0B : CLC : ADC.b $0C : CMP $0D : BCC .not_accumulated_yet
    
    ; Otherwise, just subtract the larger value and increment $00.
    SBC.b $0D
    
    ; Apportion velocity to the direction that has less magnitude for once.
    INC.b $00
    
    .not_accumulated_yet
    
    STA.b $0B
    
    DEX : BNE .still_have_velocity_to_apply
    
    TYA : BEQ .dx_is_bigger_2
    
    LDA.b $00 : PHA
    LDA.b $01 : STA.b $00
    PLA     : STA.b $01
    
    .dx_is_bigger_2
    
    LDA.b $00
    
    LDY.b $02 : BEQ .polarity_already_correct_1
    
    EOR.b #$FF : INC A : STA.b $00
    
    .polarity_already_correct_1
    
    LDA.b $01
    
    LDY.b $03 : BEQ .polarity_already_correct_2
    
    EOR.b #$FF : INC A : STA.b $01
    
    .polarity_already_correct_2
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $036AA0-$036AA3 LONG JUMP LOCATION
Sprite_DirectionToFacePlayerLong:
{
    JSR Sprite_DirectionToFacePlayer
    
    RTL
}

; ==============================================================================

; $036AA4-$036ACC LOCAL JUMP LOCATION
    ; \return       $0E is low byte of player_y_pos - sprite_y_pos
    ; \return       $0F is low byte of player_x_pos - sprite_x_pos
Sprite_DirectionToFacePlayer:
{
    JSR Sprite_IsToRightOfPlayer : STY.b $00
    JSR Sprite_IsBelowPlayer     : STY.b $01
    
    LDA.b $0E : BPL .positive_1
    
    EOR.b #$FF : INC A
    
    .positive_1
    
    STA.w $0FB5
    
    LDA.b $0F : BPL .positive_2
    
    EOR.b #$FF : INC A
    
    .positive_2
    
    ; Compares absolute values of dx and dy
    CMP.w $0FB5 : BCC .dy_is_bigger
    
    LDY.b $00
    
    RTS
    
    .dy_is_bigger
    
    LDA.b $01 : INC #2 : TAY
    
    RTS
}

; ==============================================================================

; $036ACD-$036AD0 LONG JUMP LOCATION
Sprite_IsToRightOfPlayerLong:
{
    JSR Sprite_IsToRightOfPlayer
    
    RTL
}

; ==============================================================================

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
    JSR Sprite_IsBelowPlayer
    
    RTL
}

; ==============================================================================

    ; \return Y=0 sprite is above or level with player
    ; \return Y=1 sprite is below player
; $036AE8-$036B09 LOCAL JUMP LOCATION
Sprite_IsBelowPlayer:
{
    LDY.b #$00
    
    ; The additional 8 pixels I'm sure is to help simulate relative
    ; perspective. The altitude of the sprite is also factored in.
    LDA.b $20 : CLC : ADC.b #$08   : PHP 
              CLC : ADC.w $0F70, X : PHP
              SEC : SBC.w $0D00, X : STA.b $0E
    
    ; The higher byte of Link's Y coordinate
    ; The difference in their higher bytes. 
    ; Offset if Link is crossing a 0x0100 pixel boundary.
    LDA.b $21 : SBC.w $0D20, X
    PLP     : ADC.b #$00
    PLP     : ADC.b #$00   : BPL .same_or_above
    
    ; Link is above the sprite and therefore...
    ; The sprite is below the player.
    INY
    
    .same_or_above
    
    RTS
}

; ==============================================================================

; $036B0A-$036B1C LOCAL JUMP LOCATION
Sprite_IsToRightOfEntity:
{
    ; $04 = X coordinate of an entity
    
    LDY.b #$00
    
    LDA.b $04 : SEC : SBC.w $0D10, X : STA.b $0F
    LDA.b $05 : SBC.w $0D30, X : BPL .same_or_to_left
    
    INY
    
    .same_or_to_left
    
    RTS
}

; ==============================================================================

; $036B1D-$036B2F LOCAL JUMP LOCATION
Sprite_IsBelowEntity:
{
    ; $06 = coordinate of an entity
    
    LDY.b #$00
    
    LDA.b $06 : SEC : SBC.w $0D00, X : STA.b $0E
    LDA.b $07 : SBC.w $0D20, X : BPL .entityIsBelow
    
    INY
    
    .entityIsBelow
    
    RTS
}

; ==============================================================================

; $036B30-$036B5D LONG JUMP LOCATION
Sprite_DirectionToFaceEntity:
{
    PHB : PHK : PLB
    
    JSR Sprite_IsToRightOfEntity : STY.b $00
    JSR Sprite_IsBelowEntity     : STY.b $01
    
    LDA.b $0E : BPL .positive_1
    
    EOR.b #$FF : INC A
    
    .positive_1
    
    STA.w $0FB5
    
    LDA.b $0F : BPL .positive_2
    
    EOR.b #$FF : INC A
    
    .positive_2
    
    ; Compares absolute values of dx and dy
    CMP.w $0FB5 : BCC .dy_is_bigger
    
    LDY.b $00
    
    PLB
    
    RTL
    
    .dy_is_bigger
    
    LDA.b $01 : INC #2 : TAY
    
    PLB
    
    RTL
}

; $036B5E-$036B65 LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR.w $EB76 ; $036B76 IN ROM
    
    PLB
    
    RTL
}

; $036B66-$036B6D DATA
{
    .recoilTimes
    db $0F db $0F db $18 db $0F db $0F db $13 db $0F db $0F
}

; $036B76-$036C5B LOCAL JUMP LOCATION
{
    ; Exclusively called by soldier like enemies... but not sure why...?
    
    LDA.b $EE : CMP.w $0F20, X : BNE .not_on_player_layer
    
    LDA.b $46 : ORA.b $4D
    
    .not_on_player_layer
    
                   BNE .return
    LDA.w $0EF0, X : BMI .return
    
    JSR.w $F645 ; $037645 IN ROM
    
    LDA.w $037A : AND.b #$10 : BNE .BRANCH_GAMMA
    
    LDA.b $44 : CMP.b #$80 : BEQ .BRANCH_GAMMA
    
    JSR Player_SetupActionHitBox
    
    LDA.b $3C : BMI .BRANCH_DELTA
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_DELTA
    
    LDA.w $0E20, X : CMP.b #$6A : BEQ .BRANCH_EPSILON
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    ; 36B66 IN ROM
    LDA .recoilTimes, Y : STA.w $0EA0, X ; $EB66
    
    .BRANCH_EPSILON
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $EB6E, Y : STA.b $46
    
    LDA.b #$18
    
    LDY.b $3C : CPY.b #$09 : BPL .BRANCH_ZETA
    
    LDA.b #$20
    
    .BRANCH_ZETA
    
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : EOR.b #$FF : INC A : STA.w $0F30, X
    LDA.b $01 : EOR.b #$FF : INC A : STA.w $0F40, X
    
    LDA.b #$10
    
    LDY.b $3C : CPY.b #$09 : BPL .BRANCH_THETA
    
    LDA.b #$08
    
    .BRANCH_THETA
    
    JSR Sprite_ApplyRecoilToPlayer
    JSR Player_PlaceRepulseSpark
    
    LDA.b #$90 : STA.b $47
    
    .return
    
    RTS
    
    .BRANCH_DELTA
    
    JSR Sprite_SetupHitBox
    
    JSR Utility_CheckIfHitBoxesOverlap : BCS .BRANCH_IOTA
    
    .BRANCH_GAMMA
    
    JML Sprite_StaggeredCheckDamageToPlayerPlusRecoil
    
    ; $036C02 ALTERNATE ENTRY POINT
    .BRANCH_IOTA
    
    LDA.w $0E20, X
    
    CMP.b #$7A : BEQ .attempt_electrocution
    CMP.b #$0D : BNE .not_buzzblob
    
    LDA.l $7EF359 : CMP.b #$04 : BCC .attempt_electrocution
    
    .not_buzzblob
    
    ; \bug If we reach here from the comparison with the sword value,
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
    
    JSR.w $F3DB ; $0373DB IN ROM
    
    .player_blinking_invulnerable
    
    RTS
    
    .cant_electrocute
    .not_bari_or_biri
    
    LDA.b #$50
    
    LDY.b $3C : CPY.b #$09 : BMI .BRANCH_OMICRON ; not spin attack
    
    LDA.b #$40
    
    .BRANCH_OMICRON
    
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : EOR.b #$FF : INC A : STA.w $0F30, X
    LDA.b $01 : EOR.b #$FF : INC A : STA.w $0F40, X
    
    JSL.l $06ED3F ; $036D3F IN ROM
    
    RTS
}

; ==============================================================================

; $036C5C-$036C7D LONG JUMP LOCATION
Medallion_CheckSpriteDamage:
{
    ; Exclusively called by Medallion code
    
    LDA.w $0C4A, X : STA.w $0FB5
    
    LDX.b #$0F
    
    .next_sprite
    
    LDA.w $0DD0, X : CMP.b #$09 : BCC .inactive_sprite
    
    LDA.w $0BA0, X : ORA.w $0F00, X : BNE .inactive_sprite
    
    LDA.w $0FB5 : JSL Ancilla_CheckSpriteDamage.override
    
    .inactive_sprite
    
    DEX : BPL .next_sprite
    
    RTL
}

; ==============================================================================

; $036C7E-$036CB6 DATA
Pool_Ancilla_CheckSpriteDamage:
{
    .damage_classes ; see $0C4A in ram
    db 6,  1, 11,  0,  0,  0,  0,  8,  0,  6,  0, 12,  1,  0,  0,  0
    db 0,  1,  0,  0,  0,  0,  0,  0, 14, 13,  0,  0, 15,  0,  0,  7
    db 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, 11
    db 0,  1,  1,  1,  1,  1,  1,  1,  1
} ; possible: 0, 1, 6, 7, 8, 11, 12, 13, 14, 15

; ==============================================================================

; $036CB7-$036D32 LONG JUMP LOCATION
Ancilla_CheckSpriteDamage:
{
    LDY.w $0EF0, X : BPL .sprite_not_already_dying
    
    RTL
    
    ; \note It's called override because apparently it ignores the death timer
    ; status of the affected sprite.
    ; $036CBD ALTERNATE ENTRY POINT
    .override
    .sprite_not_already_dying

    PHX
    
    TAX
    
    LDA.l .damage_classes, X
    
    PLX
    
    CMP.b #$06 : BNE .not_arrow_damage_class                                ; check for 6
    
    ; Do we have silver arrows?
    PHA : LDA.l $7EF340 : CMP.b #$03
    PLA :               BCC .not_arrow_damage_class
    
    ; Is this Ganon?
    ; \task Go back and check if this means he's invincible, or just
    ; arrow prone (to deathing).
    LDA.w $0E20, X : CMP.b #$D7 : BNE .not_invincible_ganon
    
    ; Set damage timer? (In the event it's the arrow-vulnerable Ganon)
    LDA.b #$20 : STA.w $0F10, X
    
    .not_invincible_ganon
    
    LDA.b #$09
    
    ; \task Should this really be in the Ancilla namespace? Perhaps this and
    ; its brethen should be in the Sprite_ namespace and flip around the
    ; ancilla part so it's taking damage from an ancilla or damage class.
    ; $036CE0 ALTERNATE ENTRY POINT
    .preset_class
    .not_arrow_damage_class
    
    CMP.b #$0F : BNE .not_quake_spell                                       ; check for 15
    
    LDY.w $0F70, X : BEQ .quake_only_affects_enemy_on_ground
    
    ; Dem's tha breaks, kiddo.
    RTL
    
    .quake_only_affects_enemy_on_ground
    .not_quake_spell
    
    CMP.b #$00 : BEQ .boomerang_or_hookshot_class                           ; check for 00
    CMP.b #$07 : BNE .not_boomerang_or_hookshot                             ; check for 07
    
    .boomerang_or_hookshot_class
    
    JSL .apply_damage
    
    LDA.w $0CE2, X : BNE .dont_spawn_repulse_spark
    
    LDA.w $0FAC : BNE .dont_spawn_repulse_spark
    
    LDA.b #$05 : STA.w $0FAC
    
    LDY.w $0FB6
    
    LDA.w $0C04, Y : ADC.b #$04 : STA.w $0FAD
    
    LDA.w $0BFA, Y : STA.w $0FAE
    
    LDA.b $EE : STA.w $0B68
    
    STZ.w $012E
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong

    .dont_spawn_repulse_spark

    RTL
    
    ; $036D25 ALTERNATE ENTRY POINT
    .apply_damage
    .not_boomerang_or_hookshot

    STA.w $0CF2 : TAY
    
    LDA.b #$20
    
    CPY.b #$08 : BNE .not_bomb_class                                        ; check for 8
    
    ; Cause the sprite to recoil more from bomb damage, right?
    LDA.b #$35

    .not_bomb_class

    BRA .BRANCH_$36D89
}

; ==============================================================================

; $036D33-$036D3E DATA TABLE
{
    db 1, 2, 3, 4 ; normal strike damage indices
    db 2, 3, 4, 5 ; spin attack damage indices
    db 1, 1, 2, 3 ; stabbing damage indices
}

; $036D3F-$036EC0 LONG JUMP LOCATION
{
    ; If bit 6 is set, sprite is invincible.
    LDA.w $0E60, X : AND.b #$40 : BEQ .notImpervious
    
    RTL
    
    .notImpervious
    
    LDA.w $0372 : STA.l $7FFA4C, X
    
    PHX
    
    ; Load Link's sword type.
    LDA.l $7EF359 : DEC A
    
    LDX.w $0372 : BNE .notStabbingDamageType
    
    BRA .checkSwordCharging
    
    .doingSpinAttack
    
    ORA.b #$04
    
    BRA .notStabbingDamageType
    
    .checkSwordCharging
    
    ; How long has Link's sword been stuck out?
    LDX.b $3C    : BMI .doingSpinAttack       ; If negative, he's doing a spin attack.
    CPX.b #$09 : BMI .notStabbingDamageType ; Branch if less than 9.
    
    ORA.b #$08 ; Otherwise it gets a stabbing indicator.
    
    .notStabbingDamageType
    
    TAX
    
    ; Set the damage class.
    LDA.l $06ED33, X : STA.w $0CF2
    
    ; not sure which item types this indicates
    LDA.w $0301 : AND.b #$0A : BEQ .not_poised_with_hammer
    
    LDA.b #$03 : STA.w $0CF2
    
    .not_poised_with_hammer
    
    ; Set a timer
    LDA.b #$04 : STA.w $02E3
    
    PLX
    
    LDA.b #$10 : STA.b $47
    
    LDA.b #$9D
    
    ; $036D89 ALTERNATE ENTRY POINT
    
    STA.b $00
    
    STZ.w $0CF3 ; THIS IS NOT USELESS!!! removing this line makes it impossible to hit anything with your sword.
    
    LDA.w $0E60, X : AND.b #$40 : BNE .impervious
    
    LDA.b #$00 : XBA
    
    LDA.w $0E20, X : CMP.b #$D8 : BCC .notItemSprite
    
    .impervious
    
    RTL
    
    .notItemSprite
    
    REP #$20 : ASL #4 : ORA.w $0CF2 : PHX : REP #$10 : TAX
    
    SEP #$20
    
    LDA.l $7F6000, X : STA.b $02                        ; loads Selected Sprite Damage in Advanced Damage Editor
    
    SEP #$10
    
    ; (Damage class << 3) | monster
    LDA.w $0CF2 : ASL #3 : ORA.b $02 : TAX              ;
    
    ; Get the damage value for that monster for that damage class... bah...
    LDA.l $0DB8F1, X                                  ; loads Selected Damage Table in Advanced Damage Editor located in sprite_properties.asm
    
    PLX
    
    ; $036DC5 ALTERNATE ENTRY POINT
    
    CMP.b #$F9 : BNE .dontMakeIntoFairy
    
    ; Turn something into a fairy
    LDA.b #$E3
    
    ; $036DCB ALTERNATE ENTRY POINT
    
    STA.w $0E20, X
    
    JSL Sprite_LoadProperties ; $0DB818
    JSL Sprite_SpawnPoofGarnish
    
    STZ.w $012F
    
    LDA.b #$32 : JSL Sound_SetSfx3PanLong
    
    JMP.w $EEC1   ; $036EC1 IN ROM
    
    .dontMakeIntoFairy
    
    ; Turn something into a 0 HP blob
    CMP.b #$FA : BNE .dontMakeIntoBlob
    
    LDA.b #$8F
    
    JSL.l $06EDCB ; $036DCB IN ROM
    
    LDA.b #$02 : STA.w $0D80, X
    
    LDA.b #$20 : STA.w $0F80, X
    
    LDA.b #$08 : STA.w $0F50, X
    
    STZ.w $0EA0, X
    STZ.w $0EF0, X
    STZ.w $0E50, X
    
    LDA.b #$01 : STA.w $0CD2, X : STA.w $0BE0, X
    
    RTL
    
    .dontMakeIntoBlob
    
    CMP.w $0CE2, X : BCC .ifNewDamageLessIgnore 
    
    ; if(calc_dmg < base_dmg) dmg = base_dmg
    STA.w $0CE2, X                             ; ---------------------------------------------------adds damage
    
    .ifNewDamageLessIgnore
    
    CMP.b #$00 : BNE .notZeroDamageType
    
    LDA.w $0CF2 : CMP.b #$0A : BEQ .BRANCH_THETA
    
    LDA.w $0B6B, X : AND.b #$04 : BNE .BRANCH_IOTA
    
    STZ.w $02E3
    
    .BRANCH_THETA
    
    JMP.w $EEC1 ; $036EC1 IN ROM; dont deal damage/dont kill sprite?
    
    .notZeroDamageType
    
    ; Freeze damage type
    CMP.b #$FE : BCC .BRANCH_KAPPA
    
    ; Is sprite frozen? if so, do nothing
    LDA.w $0DD0, X : CMP.b #$0B : BEQ .BRANCH_THETA
    
    .BRANCH_KAPPA
    
    ; Is it a water bubble (in swamp palace)
    LDA.w $0E20, X : CMP.b #$9A : BNE .not_water_bubble
    
    LDY.w $0CE2, X : CPY.b #$F0 : BCS .BRANCH_LAMBDA
    
    LDA.b #$09 : STA.w $0DD0, X
    
    LDA.b #$04 : STA.w $0D80, X
    
    LDA.b #$0F : STA.w $0DF0, X
    
    LDA.b #$28 : JSL Sound_SetSfx2PanLong
    
    RTL
    
    .not_water_bubble
    .BRANCH_LAMBDA
    
    CMP.b #$1B : BNE .not_arrow_in_wall
    
    ; $036E60 ALTERNATE ENTRY POINT
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    JSR Sprite_ScheduleForBreakage
    JSL Sprite_PlaceRupulseSpark
    
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
    
    STY.b $01 : JSL Sound_SetSfxPan : ORA.b $01 : STA.w $012F
    
    .no_sound_effect
    
    LDA.b #$00
    
    LDY.w $0CF2 : CPY.b #$0D : BCS .medallion_damage_class
    
    LDY.w $0E20, X : LDA.b #$14 : CPY.b #$09 : BEQ .giant_moldorm
                   LDA.b #$0F : CPY.b #$53 : BEQ .armos_knight
                                CPY.b #$18 : BNE .not_moldorm
    
    .armos_knight
    
    LDA.b #$0B
    
    .giant_moldorm
    .not_moldorm
    .medallion_damage_class
    
    STA.w $0EA0, X
    
    RTL
}

; $036EC1-$036EC7 LONG JUMP LOCATION
{
    STZ.w $0EF0, X
    STZ.w $0CE2, X
    
    RTL
}

; $036EC8-$036F60 LOCAL JUMP LOCATION
{
    ; Is the sprite alive?
    LDA.w $0DD0, X : CMP.b #$09 : BCC .not_fully_active_sprite
    
    ; Store this value in a temporary location.
    STA.w $0FB5
    
    LDA.w $0CE2, X : CMP.b #$FD : BNE .not_burn_damage
    
    STZ.w $0CE2, X
    
    LDA.b #$09 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$07 : STA.w $0DD0, X
    
    LDA.b #$70 : STA.w $0DF0, X
    
    LDA.w $0E40, X : INC #2 : STA.w $0E40, X
    
    STZ.w $0CE2, X
    
    .not_fully_active_sprite
    .BRANCH_ALPHA
    
    RTS
    
    .not_burn_damage
    
    CMP.b #$FB : BCC .BRANCH_36F61 ; damage routine
    
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
    
    LDA.b #$0F : JSL Sound_SetSfx2PanLong
    
    LDA.b #$18 : STA.w $0F80, X
    
    ASL.w $0CD2, X : LSR.w $0CD2, X
    
    JSR Sprite_Zero_XY_Velocity
    
    .BRANCH_DELTA
    
    LDA.b #$0B : STA.w $0DD0, X
    LDA.b #$40 : STA.w $0DF0, X
    
    LDA.b $00 : CLC : ADC.b #$05 : TAY
    
    ; \bug(unconfirmed) This seems destined for failure, unless I'm missing
    ; something.
    LDA .stun_timer_amounts, Y : STA.w $0B58, X
    
    LDA.w $0E20, X : CMP.b #$23 : BNE .BRANCH_EPSILON
    
    ; \task Figure out what the hell this means? Stunning a blue onoff makes
    ; them turn into a red one? What?
    INC A : STA.w $0E20, X
    
    .BRANCH_EPSILON
    
    JMP.w $EFE7 ; $036FE7 IN ROM (RTS)
    
    .stun_timer_amounts
    db 32, 128,  0,  0, 255
}

; ==============================================================================

; $036F61-$0370AB BRANCH LOCATION
{
    LDA.w $0E50, X : STA.b $00
    
    ; Subtract off an amount from the enemies HP.
    SEC : SBC.w $0CE2, X : STA.w $0E50, X
    
    STZ.w $0CE2, X
    
    BEQ .BRANCH_ALPHA  BCS .BRANCH_BETA
    
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
    
    LDA.b #$09 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_EPSILON
    
    CPY.b #$40 : BNE .BRANCH_ZETA
    
    PHX
    
    LDX.b $8A
    
    LDA.l $7EF280, X : ORA.b #$40 : STA.l $7EF280, X
    
    PLX
    
    .BRANCH_ZETA
    
    TYA : CMP.b #$EC : BNE .BRANCH_THETA
    
    LDY.w $0DB0, X : CPY.b #$02 : BNE .BRANCH_BETA
    
    JMP.w $E239 ; $036239 IN ROM
    
    .BRANCH_THETA
    
    PHA
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .BRANCH_IOTA
    
    STZ.w $0308
    STZ.w $0309
    
    .BRANCH_IOTA
    
    LDA.b #$06 : STA.w $0DD0, X
    
    PLA : CMP.b #$0C : BNE .BRANCH_KAPPA
    
    ; $036FDA ALTERNATE ENTRY POINT
    shared Sprite_ScheduleForDeath:
    
    LDA.b #$06 : STA.w $0DD0, X
    LDA.b #$1F : STA.w $0DF0, X
    
    JSR.w $E095 ; $036095 IN ROM
    
    .BRANCH_BETA
    
    RTS
    
    .BRANCH_KAPPA
    
    CMP.b #$92 : BNE .BRANCH_LAMBDA
    
    JSL Sprite_SchedulePeersForDeath
    
    LDA.b #$FF : STA.w $0DF0, X
    
    JMP.w $F087 ; $037087 IN ROM
    
    .BRANCH_LAMBDA
    
    CMP.b #$CB : BNE .not_main_trinexx_head
    
    JMP Trinexx_ScheduleMainHeadForDeath
    
    .not_main_trinexx_head
    
    CMP.b #$CC : BEQ .trinexx_side_head
    CMP.b #$CD : BNE .not_trinexx_side_head
    
    .trinexx_side_head
    
    JMP Trinexx_ScheduleSideHeadForDeath
    
    .not_trinexx_side_head
    
    CMP.b #$53 : BEQ .BRANCH_OMICRON
    CMP.b #$54 : BEQ .BRANCH_PI
    CMP.b #$09 : BEQ .BRANCH_RHO
    CMP.b #$7A : BNE .not_agahnim_death
    
    JMP Agahnim_ScheduleForDeath
    
    .not_agahnim_death
    
    CMP #$23 : BEQ .red_bari
    CMP #$0F : BNE .BRANCH_UPSILON
    
    ; $037025 ALTERNATE ENTRY POINT
    shared Octoballoon_ScheduleForDeath:
    
    STZ.w $0EF0, X
    
    LDA.b #$0F : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_UPSILON
    
    LDA.w $0B6B, X : AND.b #$02 : BNE .BRANCH_PHI
    
    LDA.w $0EF0, X : ASL A
    
    LDA.b #$0F : BCC .BRANCH_CHI
    
    LDA.b #$1F
    
    .BRANCH_CHI
    
    STA.w $0DF0, X
    
    JMP.w $F10B ; $03710B IN ROM
    
    RTS
    
    .BRANCH_RHO
    
    LDA.b #$03 : STA.w $0D80, X
    
    LDA.b #$A0 : STA.w $0F10, X
    
    LDA.b #$09 : STA.w $0DD0, X
    
    BRA .BRANCH_PSI
    
    .BRANCH_PHI
    
    ; Check if it's Kholdstare
    LDA.w $0E20, X : CMP.b #$A2 : BEQ .BRANCH_OMEGA
    
    JSL Sprite_SchedulePeersForDeath
    
    .BRANCH_OMEGA
    
    LDA.b #$04 : STA.w $0DD0, X
    
    STZ.w $0D90, X
    
    LDA.b #$FF
    
    .BRANCH_ALTIMA
    
    STA.w $0DF0, X : STA.w $0EF0, X
    
    BRA .BRANCH_PSI
    
    .BRANCH_PI
    
    LDA.b #$05 : STA.w $0D80, X
    
    LDA.b #$C0
    
    BRA .BRANCH_ALTIMA
    
    .BRANCH_OMICRON
    
    LDA.b #$23 : STA.w $0DF0, X
    
    STZ.w $0EF0, X
    
    BRA .BRANCH_ULTIMA
    
    ; $037087 ALTERNATE ENTRY POINT
    .BRANCH_PSI
    
    INC.w $0FFC
    
    .BRANCH_ULTIMA
    
    STZ.w $012F
    
    LDA.b #$22 : JSL Sound_SetSfx3PanLong
    
    RTS
    
    .red_bari
    
    ; If nonzero, can't split again because it's a small red bari.
    LDA.w $0DB0, X : BNE .BRANCH_UPSILON
    
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

; $0370AC-$037120 JUMP LOCATION
Trinexx_ScheduleSideHeadForDeath:
{
    LDA.b #$80 : STA.w $0D80, X
    
    LDA.b #$60 : STA.w $0DF0, X
    
    LDA.b #$09 : STA.w $0DD0, X
    
    ; consider merging this routine with the previous one, or splitting
    ; the one above into smaller parts.
    BRA .BRANCH_$37087
    
    ; $0370BD ALTERNATE ENTRY POINT
    shared Trinexx_ScheduleMainHeadForDeath:
    
    LDA.b #$80 : STA.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.b #$09 : STA.w $0DD0, X
    
    BRA .BRANCH_$37087
    
    ; $0370CE ALTERNATE ENTRY POINT
    shared Agahnim_ScheduleForDeath:
    
    JSL Sprite_SchedulePeersForDeath
    
    LDA.b #$09 : STA.w $0DD0, X
                 STA.w $0BA0, X
    
    LDA.w $0FFF : BNE .in_dark_world
    
    LDA.b #$0A : STA.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    LDA.b #$20 : STA.w $0F80, X
    
    JMP.w $F087 ; $037087 IN ROM
    
    .in_dark_world
    
    LDA.b #255 : STA.w $0DF0, X
    
    LDA.b #$08 : STA.w $0D80, X
    
    INC A : STA.w $0D81
            STA.w $0D82
    
    STZ.w $0DC1
    STZ.w $0DC2
    
    JMP.w $F087 ; $036087 IN ROM
    
    ; $03710B ALTERNATE ENTRY POINT
    
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
    
    JSR Sprite_CheckDamageToPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037129-$037130 LONG JUMP LOCATION
Sprite_CheckDamageToPlayerSameLayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_CheckDamageToPlayer_same_layer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037131-$037138 LONG JUMP LOCATION
Sprite_CheckDamageToPlayerIgnoreLayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_CheckDamageToPlayer_ignore_layer
    
    PLB
    
    RTL
}

; ==============================================================================

; $037139-$037144 DATA
{
    ; \task Name this pool.
    .directions
    db 4, 6, 0, 2
    db 6, 4, 0, 0
    db 4, 6, 0, 2
}

; ==============================================================================

; $037145-$0371F5 LOCAL JUMP LOCATION
Sprite_CheckDamageToPlayer:
{
    ; Return value CLC = no damage
    ; Return value SEC = damaged
    
    ; Is Link untouchable?
    LDA.w $037B : BNE .no_damage
    
    ; $03714A ALTERNATE ENTRY POINT
    .stagger
    
    ; No he's not, he's vulnerable
    TXA : EOR.b $1A : AND.b #$03
    
    ; Since for a sentry it's usually 0
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
    
    JSR Player_SetupHitBox_ignoreImmunity ; $F70A ; $03770A IN ROM; Puts Link's X / Y coords into memory
    JSR Sprite_SetupHitBox
    JSR Utility_CheckIfHitBoxesOverlap
    
    BRA .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    JSR.w $F1F6 ; $0371F6 IN ROM
    
    .BRANCH_DELTA
    
    ; If the 0x80 bit is set, it's a harmless sprite
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
    
    LSR A : TAY
    
    ; Use an alternate direction when the shield is beind held off to the
    ; side (when holding the B button down).
    LDA.w $F13D, Y
    
    .BRANCH_THETA
    
    LDY.w $0DE0, X
    
    CMP.w $F141, Y : BNE .BRANCH_ZETA
    
    LDA.b #$06 : JSL Sound_SetSfx2PanLong
    
    JSL Sprite_PlaceRupulseSpark.coerce
    
    ; Check if it's one of those laser eyes
    LDA.w $0E20, X : CMP.b #$95 : BNE .not_laser_eye
    
    LDA.b #$26 : JSL Sound_SetSfx3PanLong
    
    .no_damage
    
    CLC
    
    .BRANCH_EPSILON
    
    RTS ; End the routine
    
    .not_laser_eye
    
    CMP.b #$9B : BNE .not_wizzrobe
    
    JSR Sprite_Invert_XY_Speeds
    
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
    
    JSR.w $F3DB ; $0373DB IN ROM
    
    LDA.w $0E20, X : CMP.b #$0C : BNE .not_octorock_stone
    
    .octorock_stone
    
    JSR Sprite_ScheduleForDeath
    
    .not_octorock_stone
    
    SEC
    
    RTS
    
    ; Missing a label or is this just unused?
    CLC
    
    RTS
    
    .arrow_in_wall
    
    JMP Sprite_ScheduleForBreakage
}

; $0371F6-$037227 LOCAL JUMP LOCATION
{
    ; Load the sprite's Z component
    LDA.w $0F70, X : STA.b $0C
                   STZ.b $0D
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$000B
                            CMP.w #$0017 : BCS .no_collision
    
    LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.b $0C : CLC : ADC.w #$0010
                            CMP.w #$0018 : BCS .no_collision
    
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
    
        ; See if any enemies are in Link's hands
        ; yes, an enemy is being held
        LDA.w $0DD0, X : CMP.b #$0A : BEQ .return 
    DEY : BPL .next_sprite
        
    ; Ths bombs we speak of are enemy bombs, not Link's bombs.
    LDA.w $0E20, X : CMP.b #$0B : BEQ .is_chicken_or_bomb
                   CMP.b #$4A : BEQ .is_chicken_or_bomb
        ; Return if the sprite's velocity is nonzero
        LDA.w $0D50, X : ORA.w $0D40, X : BNE .return
    
    .is_chicken_or_bomb
    
    ; $037257 ALTERNATE ENTRY POINT
    shared Sprite_CheckIfLiftedPermissive:
    
    LDA.w $0372 : BNE .return
        ; check if the current sprite is the same one Link is touching.
        LDA.w $02F4 : DEC A : CMP.w $0FA0 : BEQ .player_picks_up_sprite
            ; Set up player's hit box.
            ; $037705 IN ROM
            JSR Player_SetupHitBox ; $F705
            JSR Sprite_SetupHitBox
                
            JSR Utility_CheckIfHitBoxesOverlap : BCC .return
                TXA : INC A : STA.w $0314
                              STA.w $0FB2
                    
                RTS
    
        .player_picks_up_sprite
    
        STZ.b $F6
        
        STZ.w $0E90, X
        
        ; Play pick up object sound.
        LDA.b #$1D : JSL Sound_SetSfx2PanLong
        
        LDA.w $0DD0, X : STA.l $7FFA2C, X
        
        LDA.b #$0A : STA.w $0DD0, X
        LDA.b #$10 : STA.w $0DF0, X
        
        LDA.b #$00 : STA.l $7FFA1C, X : STA.l $7FF9C2, X
        
        JSR Sprite_DirectionToFacePlayer
        
        LDA.w $F139, Y : STA.b $2F
        
        PLA : PLA
    
    .return
    
    RTS
}

; ==============================================================================

; $0372AA-$0372B3 LONG JUMP LOCATION
Sprite_CheckDamageFromPlayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_CheckDamageFromPlayer
    
    TAY
    
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
    
    JSR Player_SetupActionHitBox
    JSR Sprite_SetupHitBox
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .no_collision
    
    STZ.w $0047
    
    LDA.w $037A : AND.b #$10 : BNE Sprite_CheckIfLifted.return
    
    ; Is Link using the hammer or an item that's not in the game?
    LDA.w $0301 : AND.b #$0A : BEQ .not_frozen_kill
    
    ; Can't kill Ganon with a hammer ;)
    LDA.w $0E20, X : CMP.b #$D6 : BCS .no_collision
    
    ; Is the enemy frozen?
    LDA.w $0DD0, X : CMP #$0B : BNE .not_frozen_kill
    
    LDA.l $7FFA3C, X : BEQ .not_frozen_kill
    
    ; I guess this puts it into poofing mode (when a frozen enemy gets hit
    ; by the hammer... or apparently an arrow??, it puts them into a special
    ; mode where they're more likely to yield magic decanters.)
    LDA.b #$02 : STA.w $0DD0, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    LDA.w $0E40, X : AND.b #$E0 : ORA.b #$03 : STA.w $0E40, X
    
    LDA.b #$1F
    
    JSL Sound_SetSfx2PanLong
    
    SEC
    
    RTS
    
    .not_frozen_kill
    
    ; Is it an Agahnim energy blast? (not a dud)
    LDA.w $0E20, X : CMP.b #$7B : BNE .not_agahnim_energy_ball
    
    LDA.b $3C : CMP.b #$09 : BMI .spin_attack_charging
    
    .no_collision
    
    JMP .no_collision_part_deux
    
    .spin_attack_charging
    
    JMP.w $F3A2 ; $0373A2 IN ROM
    
    .is_baby_helmasaur
    
    LDY.w $0DE0, X
    
    LDA.b $2F : CMP.w $F141, Y : BNE .direction_mismatch
    
    .is_flying_stalfos_head
    
    JSR.w $F33D ; $03733D IN ROM
    
    STZ.w $0EF0, X
    
    JSR Player_PlaceRepulseSpark
    JMP.w $F3C7 ; $0373C7 IN ROM
    
    ; $03733D ALTERNATE ENTRY POINT
    .direction_mismatch
    .is_hardhat_bettle
    
    JSR.w $EC02 ; $036C02 IN ROM
    
    LDA.b #$20 : JSR Sprite_ApplyRecoilToPlayer
    
    LDA.b #$10 : STA.b $47 : STA.b $46
    
    JMP.w $F3C7 ; $0373C7 IN ROM
    
    .not_agahnim_energy_ball
    
    CMP.b #$09 : BNE .not_giant_moldorm
    
    LDA.w $0D90, X : BNE .sorry_youre_not_special
    
    JSR.w $F445 ; $037445 IN ROM
    
    ; I don't think this would play a sound at all, actually...
    LDA.b #$32 : JSL Sound_SetSfxPan : STA.w $012F
    
    JMP.w $F3C2 ; $0373C2 IN ROM
    
    .not_giant_moldorm
    
    CMP.b #$92 : BNE .not_helmasaur_king
    
    JMP.w $F460 ; $037460 IN ROM
    
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
    .certain_bosses:
    
    LDA.b #$20 : JSR Sprite_ApplyRecoilToPlayer
    
    LDA.b #$90 : STA.b $47
    LDA.b #$10 : STA.b $46
    
    ; $0373A2 ALTERNATE ENTRY POINT
    .sorry_youre_not_special
    
    LDA.w $0CAA, X : AND.b #$04 : BNE .okay_maybe_you_are
    
    JSR.w $EC02 ; $036C02 IN ROM
    
    SEC
    
    BRA .BRANCH_PI
    
    .no_collision_part_deux
    
    CLC
    
    BRA .BRANCH_PI
    
    ; $0373B2 ALTERNATE ENTRY POINT
    .okay_maybe_you_are
    
    LDA.b $47 : BNE .BRANCH_RHO
    
    LDA.b #$04 : JSR Sprite_ApplyRecoilToPlayer
    
    LDA.b #$10 : STA.b $46
    LDA.b #$10 : STA.b $47
    
    ; $0373C2 ALTERNATE ENTRY POINT
    .BRANCH_RHO
    
    JSR Player_PlaceRepulseSpark
    
    SEC
    
    ; $0373C7 ALTERNATE ENTRY POINT
    .BRANCH_PI
    
    LDA.b #$00
    
    RTS
}

; ==============================================================================

; $0373CA-$03741E JUMP LOCATION
Sprite_StaggeredCheckDamageToPlayerPlusRecoil:
{
    TXA : EOR.b $1A : LSR A : BCS .delay_player_damage
    
    JSR.w $F645 ; $037645 IN ROM
    JSR Player_SetupHitBox ; $F705 ; $037705 IN ROM
    
    JSR Utility_CheckIfHitBoxesOverlap : BCS .dont_damage_player
    
    ; $0373DB ALTERNATE ENTRY POINT
    shared Sprite_AttemptDamageToPlayerPlusRecoil:
    
    LDA.w $031F : ORA.w $037B : BNE .dont_damage_player
    
    LDA.b #$13 : STA.b $46
    
    LDA.b #$18 : JSR Sprite_ApplyRecoilToPlayer
    
    LDA.b #$01 : STA.b $4D
    
    ; determine damage for Link based on his armor value
    LDA.w $0CD2, X : AND.b #$0F : STA.b $00 : ASL A : ADC.b $00 : CLC : ADC.l $7EF35B : TAY
    
    LDA Bump_Damage_Table, Y : STA.w $0373
    
    LDA.w $0E20, X : CMP.b #$61 : BNE .not_beamos_laser
    
    LDA.w $0DB0, X : BEQ .not_beamos_laser
    
    ; Double the recoil amount to the player for the beamos laser beam.
    LDA.w $0D50, X : ASL A : STA.b $28
    
    LDA.w $0D40, X : ASL A : STA.b $27
    
    .not_beamos_laser
    .dont_damage_player
    .delay_player_damage
    
    RTS
}

; ==============================================================================

; $03741F-$037426 LONG JUMP LOCATION
Sprite_AttemptDamageToPlayerPlusRecoilLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_AttemptDamageToPlayerPlusRecoil
    
    PLB
    
    RTL
}

; ==============================================================================

; $037427-$037444 DATA
    ; 1 of 3 values based on link's armour value and $0CD2, X
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
{
    LDA.b #$30 : JSR Sprite_ApplyRecoilToPlayer
    
    LDA.b #$90 : STA.b $47
    LDA.b #$10 : STA.b $46
    
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    LDA.b #$30 : STA.w $0E00, X
    
    JMP.w $F3C7 ; $0373C7 IN ROM
}

; $037460-$03746C LOCAL JUMP LOCATION
{
    LDA.w $0DB0, X : CMP #$03 : BCS .alpha
    
    JMP.w $F3B2 ; $0373B2 IN ROM
    
    .alpha
    
    JMP.w $F395 ; $037395 IN ROM
}

; $037571-$03757D DATA
{
    db 1, 1, 1, 0, 0, 0, 0, 1
    db 1, 0, 0, 1, 1
}
    
; ==============================================================================

; $03757E-$037585 LONG JUMP LOCATION
Player_SetupActionHitBoxLong:
{
    PHB : PHK : PLB
    
    JSR Player_SetupActionHitBox
    
    PLB
    
    RTL
}

; ==============================================================================

; $037594-$0375DF LOCAL JUMP LOCATION
Pool_Player_SetupActionHitBox:
{
    .spin_attack_hit_box
    
    LDA.b $22 : SEC : SBC.b #$0E : STA.b $00
    LDA.b $23 : SBC.b #$00 : STA.b $08
    
    LDA.b $20 : SEC : SBC.b #$0A : STA.b $01
    LDA.b $21 : SBC.b #$00 : STA.b $09
    
    LDA.b #$2C : STA.b $02
    INC A      : STA.b $03
    
    PLX
    
    RTS
    
    .dash_hit_box
    
    LDA.b $2F : LSR A : TAY
    
    LDA.b $22 : CLC : ADC.w $F588, Y : STA.b $00
    LDA.b $23 : ADC.w $F58C, Y : STA.b $08
    
    LDA.b $20 : CLC : ADC.w $F590, Y : STA.b $01
    LDA.b $21 : ADC.w $F586, Y : STA.b $09
    
    LDA.b #$10 : STA.b $02 : STA.b $03
    
    RTS
}

; ==============================================================================

; $0375E0-$037644 LOCAL JUMP LOCATION
Player_SetupActionHitBox:
{
    LDA.w $0372 : BNE .dash_hit_box
    
    PHX
    
    LDX.b #$00
    
    LDA.w $0301 : AND.b #$0A : BNE .special_pose
    
    LDA.w $037A : AND.b #$10 : BNE .special_pose
    
    LDY.b $3C : BMI .spin_attack_hit_box
    
    LDA.w $F571, Y : BNE .return
    
    ; Adding $3C seems to be for the pokey player hit box with the swordy.
    LDA.b $2F : ASL #3 : CLC : ADC.b $3C : TAX : INX
    
    .special_pose
    
    LDY.b #$00
    
    LDA.b $45 : CLC : ADC.w $F46D, X : BPL .positive
    
    DEY
    
    .positive
    
          CLC : ADC.b $22 : STA.b $00
    TYA : ADC.b $23 : STA.b $08
    
    LDY.b #$00
    
    LDA.b $44 : CLC : ADC.w $F4EF, X : BPL .positive_2
    
    DEY
    
    .positive_2
    
          ADC.b $20 : STA.b $01
    TYA : ADC.b $21 : STA.b $09
    
    ; Widths of the colision boxes for player? Update: yep (Nov. 2012 haha)
    LDA.w $F4AE, X : STA.b $02
    
    LDA.w $F530, X : STA.b $03
    
    PLX
    
    RTS
    
    .return
    
    LDA.b #$80 : STA.b $08
    
    PLX
    
    RTS
}

; ==============================================================================

; $037645-$037687 LOCAL JUMP LOCATION
{
    LDY.b #$00
    
    LDA.w $0FAB : CMP.b #$80 : BEQ .BRANCH_ALPHA
    CMP.b #$00             : BPL .BRANCH_BETA
    
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
    
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    LDA.b $00 : STA.b $27
    LDA.b $01 : STA.b $28
    
    PLA : LSR A : STA.b $29 : STA.b $C7
    
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
    
    JSL Sound_SetSfxPanWithPlayerCoords
    
    ; Make "clink" against wall noise
    ORA.b #$05 : STA.w $012E
    
    .respulse_spark_already_active
    
    RTS
}

; ==============================================================================

; $0376CA-$037704 LONG JUMP LOCATION
Sprite_PlaceRupulseSpark:
{
    LDA.w $0FAC : BNE .dont_place
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    ; \note This entry point ignores whether there is already a repulse spark
    ; active (as there's only one slot for it, this would erase the old one).
    ; $0376D5 ALTERNATE ENTRY POINT
    .coerce
    
    LDA.w $0D10, X : CMP $E2
    LDA.w $0D30, X : SBC.b $E3 : BNE .off_screen
    
    LDA.w $0D00, X : CMP $E8
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
    LDA.b $23 : ADC.b #$00 : STA.b $08
    
    LDA.b $20 : ADC.b #$08 : STA.b $01
    LDA.b $21 : ADC.b #$00 : STA.b $09
    
    RTS
    
    .no_player_interaction_with_sprites
    
    ; \wtf Kind of .... lazy if you ask me. This ensures that the player hit
    ; box is so out of range of whatever we're going to compare with so that
    ; the hit boxes can't possibly overlap.
    ; (with a Y coordinate of 0x8000 to 0x80ff, it's highly unlikely).
    LDA.b #$80 : STA.b $09
    
    RTS
}

; ==============================================================================

; $03772F-$0377EE DATA
{
    .x_offsets_low
    db   2,   3,   0,  -3,  -6,   0,   2,  -8
    db   0,  -4,  -8,   0,  -8, -16,   2,   2
    
    db   2,   2,   2,  -8,   2,   2, -16,  -8
    db -12,   4,  -4, -12,   5, -32,  -2,   4
    
    .x_offsets_high
    db  0,  0,  0, -1, -1,  0,  0, -1
    db  0, -1, -1,  0, -1, -1,  0,  0
    
    db  0,  0,  0, -1,  0,  0, -1, -1
    db -1,  0, -1, -1,  0, -1, -1,  0
    
    .unknown_0
    db  12,   1,  16,  20,  20,   8,   4,  32
    db  48,  24,  32,  32,  32,  48,  12,  12
    
    db  60, 124,  12,  32,   4,  12,  48,  32
    db  40,   8,  24,  24,   5,  80,   4,   8
    
    .y_offsets_low
    db   0,   3,   4,  -4,  -8,   2,   0, -16
    db  12,  -4,  -8,   0, -10, -16,   2,   2
    
    db   2,   2,  -3, -12,   2,  10,   0, -12
    db  16,   4,  -4, -12,   3, -16,  -8,  10
    
    .y_offsets_high
    db 0,  0,  0, -1, -1,  0,  0, -1
    db 0, -1, -1,  0, -1, -1,  0,  0
    
    db 0,  0, -1, -1,  0,  0,  0, -1
    db 0,  0, -1, -1,  0, -1, -1,  0
    
    .unknown_1
    db  14,   1,  16,  21,  24,   4,   8,  40
    db  20,  24,  40,  29,  36,  48,  60, 124
    
    db  12,  12,  17,  28,   4,   2,  28,  20
    db  10,   4,  24,  16,   5,  48,   8,  12
}

; ==============================================================================

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
    LDA.w $0D30, X : ADC .x_offsets_high, Y : STA.b $0A
    
    LDA.w $0D00, X : CLC : ADC .y_offsets_low, Y : PHP : SEC : SBC.w $0F70, X  : STA.b $05
    LDA.w $0D20, X : SBC.b #$00   : PLP : ADC .y_offsets_high, Y : STA.b $0B
    
    ; Box... widths? right? ; yes it is the width
    LDA .unknown_0, Y : STA.b $06
    ; yes it is the height
    LDA .unknown_1, Y : STA.b $07
    
    PLY
    
    RTS
    
    .out_of_view
    
    LDA.b #$80 : STA.b $0A
    
    RTS
}

; ==============================================================================

; $037836-$037863 LOCAL JUMP LOCATION
Utility_CheckIfHitBoxesOverlap:
{
    ; returns carry clear if there was no overlap
    
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
    
    ; delta p low goes to the stack...
    ; delta p high goes to $0C...
    ; delta p + width of p2 goes to $0F...
    ; delta p low + 0x80
          LDA !pos2_low, X  : SEC : SBC !pos1_low, X  : PHA
    PHP                     : CLC : ADC !pos2_size, X : STA.b $0F
    PLP : LDA !pos2_high, X : SBC !pos1_high, X : STA.b $0C
    
    ; wasn't clear at first, but the the purpose of this is to filter out
    ; delta p's [in 16-bit] that are smaller than -0x0080, and larger then
    ; 0x007F. Since the sizes (width and height) are only specified
    ; as 8-bit, perhaps that's the reason for this restriction.
    PLA                     : CLC : ADC.b #$80
    
    LDA.b $0C : ADC.b #$00 : BNE .out_of_range
    
    LDA !pos1_size, X : CLC : ADC !pos2_size, X : CMP $0F : BCC .not_overlapping
    
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
    
    JSR OAM_AllocateDeferToPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $03786C-$0378A1 LOCAL JUMP LOCATION
OAM_AllocateDeferToPlayer:
{
    ; Might want to rename this to a Sprite_ namespace...
    
    ; This routine in general checks the sprite's proximity to the player,
    ; and if he's close enough, it will alter the OAM allocation region
    ; for the sprite.
    
    ; Is the sprite on the same floor as the player?
    LDA.w $0F20, X : CMP $EE : BNE .return
    JSR Sprite_IsToRightOfPlayer
    
    ; Proceed only if the difference between the sprite's X coordinate
    ; and player's satisfies : [ -16 <= dX < 16 ]
    LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .return
        JSR Sprite_IsBelowPlayer
        
        ; Proceed if the difference in the Y coordinates satisfies:
        ; [ -32 <= dY < 40 ]
        LDA.b $0E : CLC : ADC.b #$20 : CMP.b #$48 : BCS .return
            LDA.w $0E40, X : AND.b #$1F : INC A : ASL #2
            
            ; The sprite will request a different OAM range
            ; depending on player's relative position.
            CPY.b #$00 : BEQ .linkIsLower
                JSL OAM_AllocateFromRegionC : BRA .return
    
            .linkIsLower
    
            JSL OAM_AllocateFromRegionB
    
    .return
    
    RTS
}

; ==============================================================================

; $0378A2-$037916 LOCAL JUMP LOCATION
SpriteDeath_Main:
{
    ; Death routine for sprites
    ; (bushes and grass are exceptions)
    
    LDA.w $0E20, X : CMP.b #$EC : BNE .notBushOrGrass
    
    JSR ThrowableScenery_ScatterIntoDebris
    
    RTS
    
    .notBushOrGrass
    
    ; Armos Knight, Lanmolas, Helmasaur King
    CMP.b #$53 : BEQ .draw_normally
    CMP.b #$54 : BEQ .draw_normally
    CMP.b #$92 : BEQ .draw_normally
    
    ; Red Bomb soldier?
    CMP.b #$4A : BNE .notBombSoldier
    
    LDA.w $0DB0, X : CMP.b #$02 : BCS .draw_normally
    
    .notBombSoldier
    
    LDA.w $0DF0, X : BEQ .BRANCH_37923
    
    ; $0378C9 ALTERNATE ENTRY POINT
    
    LDA.w $0E60, X : BMI .draw_normally
    
    LDA.b $1A : AND.b #$03 : ORA.b $11 : ORA.w $0FC1 : BNE .delay_finality
    
    INC.w $0DF0, X
    
    .delay_finality
    
    JSR SpriteDeath_DrawPerishingOverlay
    
    LDA.w $0E20, X : CMP.b #$40 : BEQ .is_evil_barrier
    
    LDA.w $0DF0, X : CMP.b #$0A : BCC .stop_drawing_sprite
    
    .is_evil_barrier
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0010 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0004 : STA.b $92
    
    SEP #$20
    
    LDA.w $0E40, X : PHA
    
    SEC : SBC.b #$04 : STA.w $0E40, X
    
    JSR SpriteActive_Main
    
    PLA : STA.w $0E40, X
    
    .stop_drawing_sprite
    
    RTS
    
    .draw_normally
    
    JSR SpriteActive_Main
    
    RTS
}

; ==============================================================================

; $037917-$03791E LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR.w $F923 ; $037923 IN ROM
    
    PLB
    
    RTL
}

; ==============================================================================

; $03791F-$037922 DATA
{
    ; \task Name this pool / routine.
    
    .pikit_drop_items
    db $DC, $E1, $D9, $E6
}

; ==============================================================================

; $037923-$037A53 LOCAL JUMP LOCATION
{
    ; Is it a Vitreous small eyeball?
    LDA.w $0E20, X : CMP.b #$BE : BNE .not_small_vitreous_eyeball
    
    ; \hardcoded This is how Vitreous knows whether to come out of his
    ; slime pool.
    DEC.w $0ED0
    
    .not_small_vitreous_eyeball
    
    ; Is it a Pikit
    CMP #$AA : BNE .not_a_pikit
    
    LDY.w $0E90, X : BEQ .BRANCH_BETA
    
    LDA .pikit_drop_items-1, Y
    
    LDY.w $0E30, X : PHY
    
    JSR.w $F9D1 ; $0379D1 IN ROM
    
    PLA : STA.w $0E30, X : DEC A : BNE .BRANCH_GAMMA
    
    LDA.b #$09 : STA.w $0F50, X
    LDA.b #$F0 : STA.w $0E60, X
    
    .BRANCH_GAMMA
    
    INC.w $0EB0, X
    
    RTS
    
    .not_a_pikit
    .BRANCH_BETA
    
    ; Is it a crazy red spear soldier?
    LDA.w $0E20, X : CMP.b #$45 : BNE .BRANCH_DELTA
    
    ; If so, are we in the "first part" (on OW)
    LDA.l $7EF3C5 : CMP.b #$02 : BNE .BRANCH_DELTA
    
    LDA.w $040A : CMP.b #$18 : BNE .BRANCH_DELTA
    
    ; Resets the music in the village when the crazy green guards are killed.
    LDA.b #$07 : STA.w $012C
    
    .BRANCH_DELTA
    
    ; Does it have a drop item?
    LDY.w $0CBA, X : BEQ .BRANCH_EPSILON
    
    LDA.w $0BC0, X : STA.w $0E30, X
    
    LDA.b #$FF : STA.w $0BC0, X
    
    ; Small key
    LDA.b #$E4
    
    CPY.b #$01 : BEQ .BRANCH_ZETA
    
    ; Big key
    LDA.b #$E5
    
    CPY.b #$03 : BNE .BRANCH_ZETA
    
    ; Green rupee
    LDA.b #$D9
    
    BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    ; Determine prize packs...
    LDA.w $0BE0, X : AND.b #$0F : BEQ .BRANCH_THETA
    
    DEC A : PHA
    
    ; Check luck status
    ; If no special luck, proceed as normal
    LDY.w $0CF9 : BEQ .BRANCH_IOTA
    
    ; Increase lucky (or unlucky) drop counter
    ; Once we reach 10 drops of a type we reset luck.
    INC.w $0CFA : LDA.w $0CFA : CMP.b #$0A : BCC .BRANCH_KAPPA
    
    STZ.w $0CF9 ; Reset luck. (per above)
    
    .BRANCH_KAPPA
    
    PLA
    
    ; Is it great luck? If so, guarantee a prize drop
    CPY.b #$01 : BEQ .BRANCH_LAMBDA
    
    .BRANCH_THETA
    
    BRA .BRANCH_MU ; Otherwise Luck is 2 and failure is guaranteed.
    
    .BRANCH_IOTA ; how prize packs normally drop
    
    ; Reload the prize pack #
    JSL GetRandomInt : PLY  : AND.w $FA5C, Y : BNE .BRANCH_MU
    
    ; $0379BC ALTERNATE ENTRY POINT
    
    TYA ; Transfer prize number to A register
    
    .BRANCH_LAMBDA ; if this is branched to, the prize is guaranteed.
    
    ASL #3 : ORA.w $0FC7, Y : PHA
    
    LDA.w $0FC7, Y : INC A : AND.b #$07 : STA.w $0FC7, Y
    
    PLY
    
    LDA.w $FA72, Y
    
    ; $0379D1 ALTERNATE ENTRY POINT
    .BRANCH_ZETA
    
    ; Is the sprite we've dropped a big key?
    STA.w $0E20, X : CMP.b #$E5 : BNE .BRANCH_NU
    
    JSR SpritePrep_LoadBigKeyGfx
    
    BRA .BRANCH_XI
    
    .BRANCH_NU
    
    ; Is it a normal key?
    CMP.b #$E4 : BNE .BRANCH_XI
    
    JSR SpritePrep_Key.set_item_drop
    
    .BRANCH_XI
    
    LDA.b #$09 : STA.w $0DD0, X
    
    LDA.w $0F70, X : PHA
    
    JSL Sprite_LoadProperties
    
    INC.w $0BA0, X
    
    LDY.w $0E20, X
    
    LDA.w $F98B, Y : PHA
    
    AND.b #$F0 : STA.w $0F80, X
    
    PLA : AND.b #$0F : CLC : ADC.w $0D10, X : STA.w $0D10, X
    LDA.w $0D30, X     : ADC.b #$00   : STA.w $0D30, X
    
    PLA : STA.w $0F70, X
    
    LDA.b #$15 : STA.w $0F10, X
    LDA.b #$FF : STA.w $0B58, X
    
    BRA .BRANCH_OMICRON
    
    .BRANCH_MU
    
    STZ.w $0DD0, X
    
    .BRANCH_OMICRON
    
    LDA.w $0E20, X : CMP.b #$A2 : BNE .not_kholdstare
    
    JSL Sprite_VerifyAllOnScreenDefeated : BCC .anospawn_crystal
    
    LDA.b #$04 : JSL Sprite_SpawnFallingItem
    
    .anospawn_crystal
    .not_kholdstare
    
    JSL Dungeon_ManuallySetSpriteDeathFlag
    
    INC.w $0CFB
    
    LDA.w $0E20, X : CMP.b #$40 : BNE .not_evil_barrier
    
    LDA.b #$09 : STA.w $0DD0, X
    
    LDA.b #$04 : STA.w $0DC0, X
    
    JMP.w $F8C9 ; $0378C9 IN ROM
    
    .not_evil_barrier
    
    RTS
}

; ==============================================================================

; $037A54-$037A5B LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR.w $F9BC  ;  $379BC IN ROM
    
    PLB
    
    RTL
}
; ==============================================================================
; $037A5C-$037A71
    ; This is using a mask system, 00 = 8/8 chances, 01 = 7/8 chances, 03 would be 6/8 etc...
    PrizePack_Chance: ; $06FA5C
    db $01, $01, $01, $00, $01, $01, $01
    
; $037A72-$037AAA
    PrizePack_Prizes: ; $06FA72
    ; wiki link for the prize pack as image : https://alttp-wiki.net/index.php/Enemy_prize_packs
    ; .group00 Empty group no data for it this label is just here for reference
    .group01 ; heart, heart, heart, heart, 1rupee, heart, heart, 1rupee
    db $D8, $D8, $D8, $D8, $D9, $D8, $D8, $D9
    .group02 ; 5rupee, 1rupee, 5rupee, 20rupee, 5rupee, 1rupee, 5rupee, 5rupee
    db $DA, $D9, $DA, $DB, $DA, $D9, $DA, $DA
    .group03 ; B.magic, magic, magic, 5rupee, B.magic, magic, heart, magic
    db $E0, $DF, $DF, $DA, $E0, $DF, $D8, $DF
    .group04 ; 1bomb, 1bomb, 1bomb, 4bomb, 1bomb, 1bomb, 8bomb, 1bomb
    db $DC, $DC, $DC, $DD, $DC, $DC, $DE, $DC
    .group05 ; 5arrow, heart, 5arrow, 10arrow, 5arrow, heart, 5arrow, 10arrow
    db $E1, $D8, $E1, $E2, $E1, $D8, $E1, $E2
    .group06 ; magic, 1rupee, heart, 5arrow, magic, 1bomb, 5rupee, heart
    db $DF, $D9, $D8, $E1, $DF, $DC, $D9, $D8
    .group07 ; heart, fairy, B.magic, 20rupee, 8bomb, heart, 20rupee, 10arrow
    db $D8, $E3, $E0, $DB, $DE, $D8, $DB, $E2

; ==============================================================================

; $037B2A-$037B95 LOCAL JUMP LOCATION
SpriteDeath_DrawPerishingOverlay:
{
    LDA.w $046C : CMP.b #$04 : BNE .dont_use_super_priority
    
    LDA.b #$30 : STA.w $0B89, X
    
    .dont_use_super_priority
    
    JSR Sprite_PrepOamCoord
    
    LDA.w $0E60, X : AND.b #$20 : LSR #3 : STA.b $0C
    
    PHX
    
    LDA.b #$03 : STA.b $00
    
    LDA.w $0DF0, X : AND.b #$1C : EOR.b #$1C : CLC : ADC.b $00 : TAX
    
    .next_oam_entry
    
    PHY
    
    LDA.w $FAEA, X : BEQ .skip_entry
    
                                            INY #2 : STA ($90), Y
    LDA.w $0FA9 : SEC : SBC.b $0C    : CLC : ADC.w $FACA, X : DEY    : STA ($90), Y
    LDA.w $0FA8 : SEC : SBC.b $0C    : CLC : ADC.w $FAAA, X : DEY    : STA ($90), Y
    LDA.b $05   : AND.b #$30 : ORA.w $FB0A, X : INY #3 : STA ($90), Y
    
    .skip_entry
    
    PLY : INY #4
    
    DEX
    
    DEC.b $00 : BPL .next_oam_entry
    
    PLX
    
    LDY.b #$00
    LDA.b #$03
    
    JSR Sprite_CorrectOamEntries
    
    RTS
}

; ==============================================================================

; $037BEA-$037CB6 JUMP LOCATION
SpriteCustomFall_Main:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    STZ.w $0DD0, X
    
    JSL Dungeon_ManuallySetSpriteDeathFlag
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$40 : BCC .BRANCH_BETA
    
    LDA.w $0F50, X : CMP.b #$05 : BNE .BRANCH_GAMMA
    
    LDA.b #$3F : STA.w $0DF0, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_GAMMA
    
    LDA.w $0DF0, X : AND.b #$07 : ORA.b $11 : ORA.w $0FC1 : BNE .BRANCH_LAMBDA
    
    LDA.b #$31 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_LAMBDA
    
    JSR SpriteActive_Main
    JSR Sprite_PrepOamCoord
    
    LDA.b $02 : SEC : SBC.b #$08 : STA.b $02
    LDA.b $03 : SEC : SBC.b #$00 : STA.b $03
    
    LDA.w $0DF0, X : CLC : ADC.b #$14 : STA.b $06
    
    JSL Sprite_CustomTimedDrawDistressMarker
    
    RTS
    
    .BRANCH_BETA
    
    CMP.b #$3D : BNE .BRANCH_DELTA
    
    PHA
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    PLA
    
    .BRANCH_DELTA
    
    LSR A : TAY
    
    LDA.w $0E20, X
    
    CMP.b #$26 : BEQ .BRANCH_EPSILON
    CMP.b #$13 : BNE .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    LDA.w $FBB6, Y : STA.w $0DC0, X
    
    JSR.w $FD17   ; $037D17 IN ROM
    
    BRA .BRANCH_THETA
    
    .BRANCH_ZETA
    
    LDA.w $FB96, Y : CMP.b #$0C : BCS .BRANCH_MU
    
    LDY.w $0DE0, X
    
    CLC : ADC.w $FBE6, Y
    
    .BRANCH_MU
    
    STA.w $0DC0, X
    
    JSR.w $FE5B   ; $037E5B IN ROM
    
    .BRANCH_THETA
    
    LDA.w $0DF0, X : LSR #3 : TAY
    
    LDA.b $1A : AND.w $FBD6, Y : ORA.b $11 : BNE .BRANCH_IOTA
    
    LDY.b #$68
    
    JSR.w $E73C   ; $03673C IN ROM
    
    LDA.w $0FA5 : CMP.b #$20 : BEQ .BRANCH_KAPPA
    
    STZ.w $0F30, X
    STZ.w $0F40, X
    
    .BRANCH_KAPPA
    
    LDA.w $0F30, X : STA.w $0D40, X
    
    ASL A : PHP : ROR.w $0D40, X : PLP : ROR.w $0D40, X
    
    LDA.w $0F40, X : STA.w $0D50, X
    
    ASL A : PHP : ROR.w $0D50, X : PLP : ROR.w $0D50, X
    
    JSR Sprite_Move
    
    .BRANCH_IOTA
    
    RTS
}

; $037D17-$037D42 LOCAL JUMP LOCATION
{
    LDA.w $0E20, X : CMP.b #$13 : BEQ .BRANCH_ALPHA
    
    LDA.w $0DC0, X : ASL #3 : ADC.b #$B7 : STA.b $08
    
    LDA.b #$FC
    
    .BRANCH_BETA
    
    ADC.b #$00 : STA.b $09
    
    LDA.b #$01 : JSL Sprite_DrawMultiple
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.w $0DC0, X : ASL #3 : ADC.b #$E7 : STA.b $08
    
    LDA.b #$FC
    
    BRA .BRANCH_BETA
}

; ==============================================================================

; $037D43-$037E5A DATA
{
    ; \task Fill in data later, name stuff.
}

; ==============================================================================

; $037E5B-$037EB3 LOCAL JUMP LOCATION
{
    JSR Sprite_PrepOamCoord
    
    LDA.w $0DC0, X : PHA
    
    ASL #2 : STA.b $06
    
    PLA
    
    PHX
    
    LDX.b #$00
    
    CMP.b #$0C : BCS .BRANCH_ALPHA
    AND.b #$03 : BNE .BRANCH_ALPHA
    
    LDX.b #$03
    
    .BRANCH_ALPHA
    
    STX.b $07
    
    .BRANCH_BETA
    
    PHX
    
    TXA : CLC : ADC.b $06 : TAX
    
    LDA.b $00      : CLC : ADC.w $FD43, X       : STA ($90), Y
    LDA.b $02      : CLC : ADC.w $FD7B, X : INY : STA ($90), Y
    LDA.w $FDB3, X                : INY : STA ($90), Y
    LDA.w $FDEB, X : EOR.b $05      : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.w $FE23, X : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .BRANCH_BETA
    
    PLX
    
    LDY.b #$FF
    
    LDA.b $07
    
    JSR Sprite_CorrectOamEntries
    
    RTS
}

; ==============================================================================

; $037EB4-$037EBB LONG JUMP LOCATION
Sprite_CorrectOamEntriesLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_CorrectOamEntries
    
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
    
    JSR Sprite_GetScreenRelativeCoords
    
    PHX
    
    REP #$10
    
    LDX.b $90 : STX.b $0C
    
    LDX.b $92 : STX.b $0E
    
    .next_oam_entry
    
    LDX.b $0E
    
    LDA.b $0B : BPL .override_size_and_upper_x_bit
    
    ; Otherwise, just preserve the size but but zero out the most sig X bit.
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
    
    JSR Sprite_CheckIfOnScreenX : BCC .on_screen_x
    
    LDX.b $0E
    
    ; Restore the X bit, as it's been show to be in exceess of 0x100...
    ; This whole routine is kind of wonky and I have to wonder if it's
    ; buggy as well? (Compared to other oam handler code I've seen.)
    INC.b $00, X
    
    .on_screen_x
    
    LDY.w #$0000
    
    LDX.b $0C : INX
    
    LDA.b $00, X : SEC : SBC.b $06 : BPL .sign_extension_y
    
    DEY
    
    .sign_extension_y
    
          CLC : ADC.b $00 : STA.b $09
    TYA : ADC.b $01 : STA.b $0A
    
    JSR Sprite_CheckIfOnScreenY : BCC .on_screen_y
    
    LDA.b #$F0 : STA.b $00, X
    
    .on_screen_y
    
    INX #3 : STX.b $0C
    
    INC.b $0E
    
    DEC.b $08 : BPL .next_oam_entry
    
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
    
    LDA.w $0D00, X : STA.b $00
    SEC : SBC.b $E8      : STA.b $06
    LDA.w $0D20, X : STA.b $01
    
    LDA.w $0D10, X : STA.b $02
    SEC : SBC.b $E2      : STA.b $07
    LDA.w $0D30, X : STA.b $03
    
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
    
    LDA.b $09 : PHA : CLC : ADC.w #$0010 : STA.b $09
    
    SEC : SBC.b $E8 : CMP.w #$0100 : PLA : STA.b $09
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $037F6D-$037F71 UNUSED
Pool_Unused:
{
    JSL Sprite_SelfTerminate
    
    RTS
}

; ==============================================================================

; $037F72-$037F77 DATA
Pool_Sprite_CheckIfRecoiling:
{
    .frame_counter_masks
    db $03, $01, $00, $00, $0C, $03
}

; ==============================================================================

; $037F78-$037FF7 LOCAL JUMP LOCATION
Sprite_CheckIfRecoiling:
{
    LDA.w $0EA0, X : BEQ .return
    AND.b #$7F   : BEQ .recoil_finished
    
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
    
    LSR #2 : TAY
    
    LDA.b $1A : AND .frame_counter_masks, Y : BNE .halted
    
    LDA.w $0F30, X : STA.w $0D40, X
    LDA.w $0F40, X : STA.w $0D50, X
    
    LDA.w $0CD2, X : BMI .no_wall_collision
    
    JSL Sprite_CheckTileCollisionLong
    
    LDA.w $0E70, X
    
    AND.b #$0F : BEQ .no_wall_collision
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
    
    JSR Sprite_Move
    
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

; $037FF8-$037FFF NULL
Pool_Null:
{
    pad $FF
    
    pad $078000
}

; ==============================================================================

warnpc $078000
