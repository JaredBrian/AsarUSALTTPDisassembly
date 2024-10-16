; ==============================================================================

; Bank 08
; $040000-$047FFF
org $088000

; Ancilla generic code
; Misc ancilla
; Quake spell draw

; ==============================================================================

; TODO: Confrim this.
; Unused: 1. Don't think ambient sound effects do panning, and 2. This is
; probably unused because ... probably no ancillae cause ambient sound effects
; to play.
; $040000-$040006 LOCAL 
Ancilla_DoSfx1_NearPlayer:
{
    JSR.w Ancilla_SetSfxPan_NearPlayer : STA.w $012D
    
    RTS
}

; ==============================================================================

; $040007-$04000D LOCAL JUMP LOCATION
Ancilla_DoSfx2_NearPlayer:
{
    JSR.w Ancilla_SetSfxPan_NearPlayer : STA.w $012E
    
    RTS
}

; ==============================================================================

; $04000E-$040014 LOCAL JUMP LOCATION
Ancilla_DoSfx3_NearPlayer:
{
    JSR.w Ancilla_SetSfxPan_NearPlayer : STA.w $012F
    
    RTS
}

; ==============================================================================

; $040015-$04001F LOCAL JUMP LOCATION
Ancilla_SetSfxPan_NearPlayer:
{
    STA.w $0CF8
    
    JSL.l Sound_SetSfxPanWithPlayerCoords : ORA.w $0CF8
    
    RTS
}

; ==============================================================================

; TODO: Confirm this.
; Unused:
; $040020-$040026 LOCAL JUMP LOCATION
Ancilla_DoSfx1:
{
    JSR.w Ancilla_SetSfxPan : STA.w $012D
    
    RTS
}

; ==============================================================================

; $040027-$04002D LOCAL JUMP LOCATION
Ancilla_DoSfx2:
{
    JSR.w Ancilla_SetSfxPan : STA.w $012E
    
    RTS
}

; ==============================================================================

; $04002E-$040034 LOCAL JUMP LOCATION
Ancilla_DoSfx3:
{
    JSR.w Ancilla_SetSfxPan : STA.w $012F
    
    RTS
}

; ==============================================================================

; $040035-$04003F LOCAL JUMP LOCATION
Ancilla_SetSfxPan:
{
    STA.w $0CF8
    
    JSL.l Sound_SfxPanObjectCoords : ORA.w $0CF8
    
    RTS
}

; ==============================================================================

; $040040-$04006E DATA
Pool_AncillaAdd_FireRodShot:
{
    ; $040040
    .init_check_offset_x_low
    db  0,  0, -8, 16
    
    ; $040044
    .init_check_offset_x_high
    db  0,  0, -1,  0
    
    ; $040048
    .init_check_offset_y_low
    db -8, 16,  3,  3
    
    ; $04004C
    .init_check_offset_y_high
    db -1,  0,  0,  0
}
    
; $040050-$040067 DATA
SomariaBulletSpeed:
{
    ; $040050
    .X
    db   0,   0, -40,  40
    db   0,   0, -48,  48
    db   0,   0, -64,  64

    ; $04005C
    .Y
    db -40,  40,   0,   0
    db -48,  48,   0,   0
    db -64,  64,   0,   0
}

; $040068-$04006E DATA
Flame_Speed:
{
    ; $040068
    .x
    db   0,   0, -64,  64

    ; I think this row is supposed to have one more 0 but they made it shared
    ; with the next 00 in the AncillaObjectAllocation table.
    ; $04006C
    .y
    db -64,  64,   0
}

; ==============================================================================

; $04006F-$0400B2 DATA
AncillaObjectAllocation:
{
    db $00 ; 0x00 - NOTHING
    db $08 ; 0x01 - SOMARIA BULLET
    db $0C ; 0x02 - FIRE ROD SHOT
    db $10 ; 0x03 - UNUSED
    db $10 ; 0x04 - BEAM HIT
    db $04 ; 0x05 - BOOMERANG
    db $10 ; 0x06 - WALL HIT
    db $18 ; 0x07 - BOMB
    db $08 ; 0x08 - DOOR DEBRIS
    db $08 ; 0x09 - ARROW
    db $08 ; 0x0A - ARROW IN THE WALL
    db $00 ; 0x0B - ICE ROD SHOT
    db $14 ; 0x0C - SWORD BEAM_BOUNCE
    db $00 ; 0x0D - SPIN ATTACK FULL CHARGE SPARK
    db $10 ; 0x0E - BLAST WALL EXPLOSION
    db $28 ; 0x0F - BLAST WALL EXPLOSION
    db $18 ; 0x10 - BLAST WALL EXPLOSION
    db $10 ; 0x11 - ICE ROD WALL HIT
    db $10 ; 0x12 - BLAST WALL EXPLOSION
    db $10 ; 0x13 - ICE ROD SPARKLE
    db $10 ; 0x14 - BAD POINTER
    db $0C ; 0x15 - SPLASH
    db $08 ; 0x16 - HIT STARS
    db $08 ; 0x17 - SHOVEL DIRT
    db $50 ; 0x18 - ETHER SPELL
    db $00 ; 0x19 - BOMBOS SPELL
    db $10 ; 0x1A - POWDER DUST
    db $08 ; 0x1B - SWORD WALL HIT
    db $40 ; 0x1C - QUAKE SPELL
    db $00 ; 0x1D - SCREEN SHAKE
    db $0C ; 0x1E - DASH DUST
    db $24 ; 0x1F - HOOKSHOT
    db $10 ; 0x20 - BLANKET
    db $0C ; 0x21 - SNORE
    db $08 ; 0x22 - ITEM GET
    db $10 ; 0x23 - LINK POOF
    db $10 ; 0x24 - GRAVESTONE
    db $04 ; 0x25 - BAD POINTER
    db $0C ; 0x26 - SWORD SWING SPARKLE
    db $1C ; 0x27 - DUCK
    db $00 ; 0x28 - WISH POND ITEM
    db $10 ; 0x29 - MILESTONE ITEM GET
    db $14 ; 0x2A - SPIN ATTACK SPARKLE A
    db $14 ; 0x2B - SPIN ATTACK SPARKLE B
    db $10 ; 0x2C - SOMARIA BLOCK
    db $08 ; 0x2D - SOMARIA BLOCK FIZZ
    db $20 ; 0x2E - SOMARIA BLOCK FISSION
    db $10 ; 0x2F - LAMP FLAME
    db $10 ; 0x30 - BYRNA WINDUP SPARK
    db $10 ; 0x31 - BYRNA SPARK
    db $04 ; 0x32 - BLAST WALL FIREBALL
    db $00 ; 0x33 - BLAST WALL EXPLOSION
    db $80 ; 0x34 - SKULL WOODS FIRE
    db $10 ; 0x35 - MASTER SWORD GET
    db $04 ; 0x36 - FLUTE
    db $30 ; 0x37 - WEATHERVANE EXPLOSION
    db $14 ; 0x38 - CUTSCENE DUCK
    db $10 ; 0x39 - SOMARIA PLATFORM POOF
    db $00 ; 0x3A - BIG BOMB EXPLOSION
    db $10 ; 0x3B - SWORD UP SPARKLE
    db $00 ; 0x3C - SPIN ATTACK CHARGE SPARKLE
    db $00 ; 0x3D - ITEM SPLASH
    db $08 ; 0x3E - RISING CRYSTAL
    db $00 ; 0x3F - BUSH POOF
    db $10 ; 0x40 - DWARF POOF
    db $08 ; 0x41 - WATERFALL SPLASH
    db $78 ; 0x42 - HAPPINESS POND RUPEES
    db $80 ; 0x43 - GANONS TOWER CUTSCENE
}

; ==============================================================================

; $0400B3-$04019E LONG JUMP LOCATION
AddFireRodShot:
{
    LDY.b #$01
    
    STA.b $00
    
    JSL.l Ancilla_CheckForAvailableSlot : BPL .slot_available
        ; \tcrf Astounding! While it's not that silly when you think about it,
        ; it would appear that at some point they were considering using the
        ; Somarian blasts as the projectile for the fire rod. Why else put
        ; special logic in here for it? This function is only called when
        ; creating a Fire Rod shot.
        LDA.b $00 : CMP.b #$01 : BEQ .no_mp_add_back
            ; Add back the mp cost for this class of item (rod)
            ; Oddly enough it avoids this for the Somarian blasts, for whatever
            ; reason. But, this is only in the event that there are no open slots
            ; for the object.... eh. whatever.
            LDX.b #$00 : JSL.l LinkItem_ReturnUnusedMagic
        
        .no_mp_add_back
        
        BRL .return
    
    .slot_available
    
    PHB : PHK : PLB
    
    PHX
    
    ; Again, the bizarro fire rod shot gets sore treatment. It's like it
    ; doesn't even exist! (which it doesn't, kind of).
    LDA.b $00 : CMP.b #$01 : BEQ .dont_play_sound_effect
        PHY
        
        LDA.b #$0E : JSR.w Ancilla_DoSfx2_NearPlayer
        
        PLY
    
    .dont_play_sound_effect
    
    LDA.b $00 : STA.w $0C4A, Y : TAX
    
    LDA.w AncillaObjectAllocation, X : STA.w $0C90, Y
    
    LDA.b #$03 : STA.w $0C68, Y
    
    LDA.b #$00
    STA.w $0C54, Y : STA.w $0C5E, Y : STA.w $0280, Y : STA.w $028A, Y
    
    LDA.b $2F : LSR A : STA.w $0C72, Y : TAX
    
    PHY : PHX : TYX
    
    ; Appears to check multiple spots around Link to see if the item can
    ; spawn there. If it can't spawn in any of those locations, I guess
    ; we have a problem? Not sure yet.
    JSL.l Ancilla_CheckInitialTileCollision_Class_1
    
    PLX : PLY
    
    BCS .initialize_in_spread_state
        LDA.w $0022
        CLC : ADC.w Pool_AncillaAdd_FireRodShot_init_check_offset_x_low, X
        STA.w $0C04, Y

        LDA.w $0023
              ADC.w Pool_AncillaAdd_FireRodShot_init_check_offset_x_high, X
        STA.w $0C18, Y
        
        LDA.w $0020
        CLC : ADC.w Pool_AncillaAdd_FireRodShot_init_check_offset_y_low, X
        STA.w $0BFA, Y

        LDA.w $0021
              ADC.w Pool_AncillaAdd_FireRodShot_init_check_offset_y_high, X
        STA.w $0C0E, Y
        
        LDA.w $0C4A, Y : CMP.b #$01 : BEQ .sword_determines_speed
            LDA.w Flame_Speed_x, X : STA.w $0C2C, Y
            LDA.w Flame_Speed_y, X
            
            BRA .speed_has_been_determined
            
        .sword_determines_speed
        
        ; Does this mean we should only be here if we have the Master Sword
        ; or better? This makes somaria shots move at different speeds depending
        ; on which sword we have. But it seems unused for some reason?
        LDA.l $7EF359 : DEC #2 : ASL #2 : STA.b $0F
        
        TXA : CLC : ADC.b $0F : TAX
        
        LDA.w SomariaBulletSpeed_X, X : STA.w $0C2C, Y
        
        LDA.w SomariaBulletSpeed_Y, X
        
        .speed_has_been_determined
        
        STA.w $0C22, Y
        
        ; Floor matches that of the player.
        LDA.w $00EE : STA.w $0C7C, Y
        
        ; Pseudo floor matches that of the player.
        LDA.w $0476 : STA.w $03CA, Y
        
        PLX
        
        PLB
        
        .return
        
        RTL
    
    .initialize_in_spread_state
    
    LDA.w $0C4A, Y : CMP.b #$01 : BNE .not_somarian_blast
        ; Again, the somarian blast gets shafted in the sound effect department.
        LDA.b #$04 : STA.w $0C4A, Y
        LDA.b #$07 : STA.w $0C68, Y
        LDA.b #$10 : STA.w $0C90, Y
        
        BRA .return_2
    
    .not_somarian_blast
    
    LDA.b #$01 : STA.w $0C54, Y
    LDA.b #$1F : STA.w $0C68, Y
    LDA.b #$08 : STA.w $0C90, Y
    
    LDA.b #$2A : JSR.w Ancilla_DoSfx2
    
    .return_2
    
    PLX
    
    PLB
    
    RTL
}

; ==============================================================================

; $04019F-$0401A6 DATA
Pool_SomarianBlast_SpawnCentrifugalQuad:
{
    .x_offsets
    db  -8, -8, -9, -4
    
    .y_offsets
    db -15, -4, -8, -8
}

; ==============================================================================

; $0401A7-$040241 LOCAL JUMP LOCATION
SomarianBlast_SpawnCentrifugalQuad:
{
    LDA.b #$03 : STA.w $0FB5
    
    LDA.w $029E, X : CMP.b #$FF : BNE .altitude_okay
        LDA.b #$00
    
    .altitude_okay
    
    STA.b $05
    
    LDA.w $0C04, X : STA.b $00
    LDA.w $0C18, X : STA.b $01
    
    LDA.w $0BFA, X : SEC : SBC.b $05    : STA.b $02
    LDA.w $0C0E, X : SBC.b #$00 : STA.b $03
    
    ; Attempt to spawn four somarian blasts all moving in directions
    ; away from a central point (the location of the former somarian block).
    LDA.w $0C7C, X : STA.b $04
    
    .attempt_next_spawn
    
        LDY.b #$04
        LDA.b #$01
        
        JSL.l Ancilla_CheckForAvailableSlot : BMI .spawn_failed
            PHX
            
            LDA.b #$01 : STA.w $0C4A, Y : TAX
            
            LDA.w AncillaObjectAllocation, X : STA.w $0C90, Y
            
            LDA.b #$04 : STA.w $0C54, Y
            LDA.b #$00 : STA.w $0C5E, Y : STA.w $0280, Y
            
            LDX.w $0FB5 : TXA : STA.w $0C72, Y
            
            LDA.b $00 : CLC : ADC .x_offsets, X : STA.w $0C04, Y
            LDA.b $01 :       ADC.b #$FF :        STA.w $0C18, Y
            
            LDA.b $02 : CLC : ADC .y_offsets, X : STA.w $0BFA, Y
            LDA.b $03 :       ADC.b #$FF :        STA.w $0C0E, Y
            
            JSL.l Ancilla_TerminateIfOffscreen
            
            LDA.w SomariaBulletSpeed_X, X : STA.w $0C2C, Y
            LDA.w SomariaBulletSpeed_Y, X : STA.w $0C22, Y
            
            LDA.b $04 : STA.w $0C7C, Y
            
            LDA.w $0476 : STA.w $03CA, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .attempt_next_spawn
    
    RTS
}

; ==============================================================================

; $040242-$04024C LONG JUMP LOCATION
Ancilla_Main:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_RepulseSpark
    JSR.w Ancilla_ExecuteObjects
    
    PLB
    
    RTL
}

; ==============================================================================

; $04024D-$040286 LOCAL JUMP LOCATION
Bomb_ProjectReflexiveSpeedOntoSprite:
{
    ; This routine subs in an object's coordinates for the
    ; player's and uses a player routine to calculate a collision or some
    ; such.
    LDA.w $0022 : PHA
    LDA.w $0023 : PHA
    
    LDA.w $0020 : PHA
    LDA.w $0021 : PHA
    
    LDA.b $04 : STA.w $0022
    LDA.b $05 : STA.w $0023
    
    LDA.b $06 : STA.w $0020
    LDA.b $07 : STA.w $0021
    
    TYA
    
    JSL.l Bomb_ProjectReflexiveSpeedOntoSpriteLong
    
    PLA : STA.w $0021
    PLA : STA.w $0020
    
    PLA : STA.w $0023
    PLA : STA.w $0022
    
    RTS
}

; ==============================================================================

; Collision detection used for telling if sprites need some beatings (i.e. if
; they are damaged by the bomb).
; $040287-$04032A LOCAL JUMP LOCATION
Bomb_CheckSpriteDamage:
{
    LDY.b #$0F
    
    .check_sprite_damage_loop
    
        TYA : EOR.b $1A : AND.b #$03
        
        ORA.w $0EF0, Y : ORA.w $0BA0, Y : BEQ .proceed_with_damage_check
            .different_floors
            
            JMP .sprite_undamaged
            
        .proceed_with_damage_check
        
        LDA.w $0F20, Y : CMP.w $0C7C, X : BNE .different_floors
            ; Won't work if the sprite is not "alive".
            LDA.w $0DD0, Y : CMP.b #$09 : BCC .sprite_undamaged
                ; Setting up variables for use with collision detection.
                
                LDA.w $0C04, X : SEC : SBC.b #$18 : STA.b $00
                LDA.w $0C18, X : SBC.b #$00 : STA.b $08
                
                LDA.w $0BFA, X : SEC : SBC.b #$18
                
                PHP
                
                SEC : SBC.w $029E, X : STA.b $01
                
                LDA.w $0C0E, X : SBC.b #$00
                
                PLP
                
                SBC.b #$00 : STA.b $09
                
                LDA.b #$30 : STA.b $02 : STA.b $03
                
                PHX : TYX
                
                JSL.l Sprite_SetupHitBoxLong
                
                PLX
                
                JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .sprite_undamaged
                    LDA.w $0E20, Y : CMP.b #$92 : BNE .not_helmasaur_king
                        ; Only certain parts of the HK are vulnerable.
                        ; Only the stage where he still has his mask.
                        LDA.w $0DB0, Y : CMP.b #$03 : BCS .sprite_undamaged
                    
                    .not_helmasaur_king
                    
                    LDA.w $0C04, X : STA.b $04
                    LDA.w $0C18, X : STA.b $05
                    
                    LDA.w $0BFA, X : STA.b $06
                    LDA.w $0C0E, X : STA.b $07
                    
                    PHX : PHY
                    
                    LDA.w $0C4A, X
                    
                    TYX
                    
                    JSL.l Ancilla_CheckSpriteDamage
                    
                    ; How far the sprite gets pushed back.
                    LDY.b #$40 : JSR.w Bomb_ProjectReflexiveSpeedOntoSprite
                    
                    PLY : PLX
                    
                    ; Reverse those speeds so that we are projecting the speed
                    ; away from the Ancilla. In other words, we are causing the
                    ; sprite to recoil from some damage.
                    LDA.b $00 : EOR.b #$FF : INC A : STA.w $0F30, Y
                    LDA.b $01 : EOR.b #$FF : INC A : STA.w $0F40, Y
            
            .sprite_undamaged
            
            DEY : BMI .checked_all_sprites
    JMP .check_sprite_damage_loop
    
    .checked_all_sprites
    
    RTS
}

; ==============================================================================

; $04032B-$04033B LOCAL JUMP LOCATION
Ancilla_ExecuteObjects:
{
    LDX.b #$09
    
    .next_object
    
        STX.w $0FA0
        
        ; The type of effect in play. 0 designates no effect.
        LDA.w $0C4A, X : BEQ .inactive_object
            JSR.w Ancilla_ExecuteObject
        
        .inactive_object
    DEX : BPL .next_object
    
    RTS
}

; ==============================================================================

; $04033C-$040404 LOCAL JUMP LOCATION
Ancilla_ExecuteObject:
{
    ; Push the ancilla's number to the stack.
    PHA
    
    ; If X >= 6, then...
    CPX.b #$06 : BCS .ignore_oam_allocation
        ; This is the number of sprites allocated for the s.o. at init.
        LDA.w $0C90, X
        
        ; If "sort sprites" is in effect, things are slightly different.
        LDY.w $0FB3 : BEQ .sort_sprites
            ; If the special effect is on a different floor use a different
            ; section of the OAM buffer (probably also changes priority).
            LDY.w $0C7C, X : BNE .on_bg1
                ; Floor 1 sprites...
                JSL.l OAM_AllocateFromRegionD
                
                BRA .record_starting_oam_position
            
            .on_bg1
            
            ; Floor 2 sprites...
            JSL.l OAM_AllocateFromRegionF
            
            BRA .record_starting_oam_position
            
            .sortSprites
            
            JSL.l OAM_AllocateFromRegionA
            
            .record_starting_oam_position
            
            ; The starting place in the OAM Buffer for the special effect.
            TYA : STA.w $0C86, X
    
    .ignore_oam_allocation
    
    ; We're not in the standard submodule.
    LDY.b $11 : BNE .dont_tick_timer
        ; I'm not seeing this as terribly useful.
        LDY.w $0C68, X : BEQ .timer_at_rest
            DEC.w $0C68, X
        
        .timer_at_rest
    .dont_tick_timer
    
    ; Note the subtraction before ASL.
    ; Load a subroutine based on the anillary object's index.
    PLA : DEC A : ASL A : TAY
    
    LDA.w .object_routines+0, Y : STA.b $00
    LDA.w .object_routines+1, Y : STA.b $01
    
    JMP ($0000)
    
    .object_routines
    
    ; NOTE: PARAMETER A IS ACTUALLY object type - 1, SINCE 0 WOULD INDICATE
    ; NO EFFECT ; SOURCE : $0C4A, X
    dw Ancilla_SomarianBlast        ; 0x01 - Both the pieces of somarian block
                                    ;        splitting and the fireballs).

    dw Ancilla_FireShot             ; 0x02 - Fire Rod flame (both flying and
                                    ;        after hitting something).

    dw Ancilla_Unused_03            ; 0x03 - Unimplemented object type. Won't
                                    ;        crash the game but won't ever self
                                    ;        terminate.

    dw Ancilla_BeamHit              ; 0x04 - Effect that represents a beam
                                    ;        splitting up after it hits
                                    ;        something.

    dw Ancilla_Boomerang            ; 0x05 - Boomerang
    dw Ancilla_WallHit              ; 0x06 - Spark-like effect that occurs when
                                    ;        you hit a wall with a boomerang or
                                    ;        hookshot.

    dw Ancilla_Bomb                 ; 0x07 - Blue player bomb
    dw Ancilla_DoorDebris           ; 0x08 - Rock fall effect (from bombing a
                                    ;        cave).

    dw Ancilla_Arrow                ; 0x09 - Flying arrow
    dw Ancilla_HaltedArrow          ; 0x0A - Arrow stuck in something (wall or
                                    ;        sprite).

    dw Ancilla_IceShot              ; 0x0B - Ice Rod shot
    dw Ancilla_SwordBeam            ; 0x0C - Master sword beam
    dw Ancilla_SwordFullChargeSpark ; 0x0D - The sparkle at the tip of your
                                    ;        sword when you power up the spin
                                    ;        attack.

    dw Ancilla_Unused_0E            ; 0x0E - Unimplemented object type that
                                    ;        points to the same location as the
                                    ;        blast wall.

    dw Ancilla_Unused_0F            ; 0x0F - Unimplemented object type that
                                    ;        points to the same location as the
                                    ;        blast wall.
    
    dw Ancilla_Unused_0E            ; 0x10 - Unimplemented object type that
                                    ;        points to the same location as the
                                    ;        blast wall.

    dw Ancilla_IceShotSpread        ; 0x11 - Ice rod shot dissipating after
                                    ;        hitting a nontransitive tile.

    dw Ancilla_Unused_0E            ; 0x12 - Unimplemented object type that
                                    ;        points to the same location as the
                                    ;        blast wall.

    dw Ancilla_IceShotSparkle       ; 0x13 - Ice Shot Sparkles (the only actual
                                    ;        visible parts of the ice shot).

    dw Ancilla_Unused_14            ; 0x14 - Unimplemented object type. Don't
                                    ;        use as it will crash the game.

    dw Ancilla_JumpSplash           ; 0x15 - Splash from jumping into or out of
                                    ;        deep water.

    dw Ancilla_HitStars             ; 0x16 - The Hammer's Stars / Stars from
                                    ;        hitting hard ground with the shovel.

    dw Ancilla_ShovelDirt           ; 0x17 - Dirt from digging a hole with the
                                    ;        shovel.
    
    dw Ancilla_EtherSpell           ; 0x18 - The Ether Effect
    dw Ancilla_BombosSpell          ; 0x19 - The Bombos Effect
    dw Ancilla_MagicPowder          ; 0x1A - Magic powder
    dw Ancilla_SwordWallHit         ; 0x1B - Sparks from tapping a wall with
                                    ;        your sword.

    dw Ancilla_QuakeSpell           ; 0x1C - The Quake Effect
    dw Ancilla_DashTremor           ; 0x1D - Jarring effect from hitting a wall
                                    ;        while dashing.

    dw Ancilla_DashDust             ; 0x1E - Pegasus boots dust flying
    dw Ancilla_Hookshot             ; 0x1F - Hookshot
    
    dw Ancilla_BedSpread            ; 0x20 - Player's Bed Spread
    dw Ancilla_SleepIcon            ; 0x21 - Link's Zzzz's from sleeping
    dw Ancilla_ReceiveItem          ; 0x22 - Received Item Sprite
    dw Ancilla_MorphPoof            ; 0x23 - Bunny / Cape transformation poof
    dw Ancilla_Gravestone           ; 0x24 - Gravestone sprite when in motion
    dw Ancilla_Unused_25            ; 0x25 - Unimplemented object type. Don't
                                    ;        use as it will crash the game.

    dw Ancilla_SwordSwingSparkle    ; 0x26 - Sparkles when swinging lvl 2 or
                                    ;        higher sword.

    dw Ancilla_TravelBird           ; 0x27 - the bird (when called by flute)
    dw Ancilla_WishPondItem         ; 0x28 - item sprite that you throw into
                                    ;        magic fairy ponds.

    dw Ancilla_MilestoneItem        ; 0x29 - Pendants, crystals, medallions
    dw Ancilla_InitialSpinSpark     ; 0x2A - Start of spin attack sparkle
    dw Ancilla_SpinSpark            ; 0x2B - During Spin attack sparkles
    dw Ancilla_SomarianBlock        ; 0x2C - Cane of Somaria blocks
    dw Ancilla_SomarianBlockFizzle  ; 0x2D - Suspected of being in cahoots with
                                    ;        the somaria objects.

    dw Ancilla_SomarianBlockDivide  ; 0x2E - Suspected of being in cahoots with
                                    ;        the somaria objects.

    dw Ancilla_LampFlame            ; 0x2F - Torch's flame
    
    dw Ancilla_InitialCaneSpark     ; 0x30 - Initial spark for the Cane of Byrna
                                    ;        activating.

    dw Ancilla_CaneSpark            ; 0x31 - Cane of Byrna spinning sparkle
    dw Ancilla_BlastWallFireball    ; 0x32 - Flame blob, which is an ancillary
                                    ;        effect from the blast wall.

    dw Ancilla_BlastWall            ; 0x33 - Series of explosions from blowing
                                    ;        up a wall (after pulling a switch).

    dw Ancilla_SkullWoodsFire       ; 0x34 - Burning effect used to open up the
                                    ;        entrance to skull woods.

    dw Ancilla_SwordCeremony        ; 0x35 - Master Sword ceremony.... not sure
                                    ;        if it's the whole thing or a part
                                    ;        of it.

    dw Ancilla_Flute                ; 0x36 - Flute that pops out of the ground
                                    ;        in the haunted grove.

    dw Ancilla_WeathervaneExplosion ; 0x37 - Appears to trigger the weathervane
                                    ;        explosion.
    
    dw Ancilla_TravelBirdIntro      ; 0x38 - Appears to give Link the bird
                                    ;        enabled flute.

    dw Ancilla_SomarianPlatformPoof ; 0x39 - Cane of Somaria blast which creates
                                    ;        platforms (sprite 0xED).

    dw Ancilla_SuperBombExplosion   ; 0x3A - super bomb explosion (also does
                                    ;        things normal bombs can).

    dw Ancilla_VictorySparkle       ; 0x3B - Victory sparkle on sword
    dw Ancilla_SwordChargeSpark     ; 0x3C - Sparkles from holding the sword out
                                    ;        charging for a spin attack.

    dw Ancilla_ObjectSplash         ; 0x3D - splash effect when things fall into
                                    ;        the water.

    dw Ancilla_RisingCrystal        ; 0x3E - 3D crystal effect (or transition
                                    ;        into 3D crystal?).

    dw Ancilla_BushPoof             ; 0x3F - Disintegrating bush poof (due to
                                    ;        magic powder).
    
    dw Ancilla_DwarfPoof            ; 0x40 - Dwarf transformation cloud
    dw Ancilla_WaterfallSplash      ; 0x41 - Water splash from player standing
                                    ;        under waterfalls (doorways,
                                    ;        basically).

    dw Ancilla_HappinessPondRupees  ; 0x42 - Rupees that you throw in to the
                                    ;        Pond of Wishing.

    dw Ancilla_BreakTowerSeal       ; 0x43 - Ganon's Tower seal being broken
                                    ;        (not opened up though!).
}

; ==============================================================================

; $040405-$040514
incsrc "ancilla_ice_shot_sparkle.asm"

; $040515-$0406D1
incsrc "ancilla_somarian_blast.asm"

; $0406D2-$040852
incsrc "ancilla_fire_shot.asm"

; ==============================================================================

; $040853-$04097A DATA
Pool_Ancilla_CheckTileCollisionStaggered:
{
    .collision_table
    db 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 0, 0, 0, 0, 2, 2, 2, 2, 0, 3, 3, 3
    db 0, 0, 0, 0, 0, 0, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
    db 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 3, 3, 3
    db 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4
    db 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0
    db 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    db 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
    .y_offsets
    db  0, 16,  5,  5,  0, 16,  4,  4,  4, 12
    db  5,  5,  4, 12, 12, 12,  0,  0,  0,  0
    
    .x_offsets
    db  8,  8,  0, 16,  4,  4,  0, 16,  4,  4
    db  4, 12, 12, 12,  4, 12,  0,  0,  0,  0
}

; ==============================================================================

; $04097B-$040980 LOCAL JUMP LOCATION
Ancilla_CheckTileCollisionStaggered:
{
    TXA : EOR.b $1A : LSR A : BCC Ancilla_CheckTileCollision_skip_even_frames

    ; Bleeds into the next function.
}

; $040981-$040A25 LOCAL JUMP LOCATION
Ancilla_CheckTileCollision:
{
    ; If indoors branch here.
    LDA.b $1B : BNE .indoors
        LDA.w $0280, X : BEQ .base_priority
            STZ.w $03E4, X
            
            .skip_even_frames
            
            ; Indicate failure.
            CLC
            
            RTS

        .base_priority
    .indoors
    
    ; Check collision properties of the room.
    ; Default collision with one BG ("one" in HM).
    LDA.w $046C : BEQ .check_basic_collision
        CMP.b #$03 : REP #$20 : BCC .difference_between_bg_scrolls
            STZ.b $00
            STZ.b $02
            
            BRA .two_bg_collision_detection
        
        .difference_between_bg_scrolls
        
        LDA.b $E0 : SEC : SBC.b $E2 : STA.b $00
        LDA.b $E6 : SEC : SBC.b $E8 : STA.b $02
        
        .two_bg_collision_detection
        
        SEP #$20
        
        LDA.w $0C04, X : PHA : CLC : ADC.b $00 : STA.w $0C04, X
        LDA.w $0C18, X : PHA : ADC.b $01 : STA.w $0C18, X
        
        LDA.w $0BFA, X : PHA : CLC : ADC.b $02 : STA.w $0BFA, X
        LDA.w $0C0E, X : PHA : ADC.b $03 : STA.w $0C0E, X
        
        LDA.b #$01 : STA.w $0C7C, X
        
        JSR.w .check_basic_collision
        
        STZ.w $0C7C, X
        
        PLA : STA.w $0C0E, X
        PLA : STA.w $0BFA, X
        
        PLA : STA.w $0C18, X
        PLA : STA.w $0C04, X
        
        LDY.b #$01
        
        BCC .no_bg1_collision
            INY
        
        .no_bg1_collision
        
        PHY
        
        ; Store the state of the carry flag (if set it means there was a
        ; collision on BG0).
        PHP
        
        JSR.w .check_basic_collision
        
        ; Takes the previous carry flag state, rolls in the current carry flag
        ; state (Has to detect on BG0 for the carry to be set).
        PLA : AND.b #$01 : ROL A : CMP.b #$01
        
        PLY
        
        RTS
    
    .check_basic_collision
    
    ; Normal Collision checking for just one BG.
    
    LDY.w $0C72, X
    
    LDA.w $0BFA, X : CLC : ADC .y_offsets, Y : STA.b $00
    LDA.w $0C0E, X :       ADC.b #$00        : STA.b $01
    
    LDA.w $0C04, X : CLC : ADC .x_offsets, Y : STA.b $02
    LDA.w $0C18, X :       ADC.b #$00        : STA.b $03

    ; Bleeds into the next function.
}

; $040A26-$040AB8 LOCAL JUMP LOCATION
Ancilla_CheckTargetedTileCollision:
{
    REP #$20 : LDA.b $00 : SEC : SBC.b $E8
    
    CMP.w #$00E0 : SEP #$20 : BCS .ignore_off_screen_collision_y
        REP #$20 : LDA.b $02 : SEC : SBC.b $E2
        
        ; This one is also due to ignoring off screen collision, but in the
        ; x coordinate.
        CMP.w #$0100 : SEP #$20 : BCS .no_collision
            LDA.b $1B : BNE .check_indoor_collision
                REP #$20
                
                LSR.b $02 : LSR.b $02 : LSR.b $02
                
                PHX
                
                JSL.l Overworld_GetTileAttrAtLocation
                
                PLX
                
                BRA .store_tile_interaction_result
            
            .check_indoor_collision
            
            ; Floor selector for special effects apparently.
            LDA.w $0C7C, X
            
            ; Retrieves tile type that the bomb is sitting on.
            JSL.l Entity_GetTileAttr
            
            .store_tile_interaction_result
            
            STA.w $03E4, X : TAY
            
            LDA.w .collision_table, Y : STA.b $0F
            
            ; Checks the special effect type.
            LDA.w $0C4A, X : CMP #$02 : BNE .not_fire_rod_shot
                ; Perhaps looking for a door type tile?
                TYA : AND.b #$F0 : CMP.b #$C0 : BNE .not_torch_collision
                    ; Make a note of which torch it touched.
                    STA.b $0F
                
                .not_torch_collision
            .not_fire_rod_shot
            
            LDA.w $0280, X : BNE .forced_high_priority
                LDA.b $0F : BEQ .tile_type_not_collision_candidate
                    CMP.b #$01 : BEQ .collided
                        CMP.b #$02 : BNE .not_sloped_tile
                            JSL.l Entity_CheckSlopedTileCollisionLong
                            
                            RTS
                        
                        .not_sloped_tile
                        
                        CMP.b #$03 : BNE .not_attr_3
                            LDY.w $03CA, X : BNE .collided
    
    .ignore_off_screen_collision_y
    
    BRA .no_collision
    
    .not_attr_3
    .forced_high_priority
    
    ; Educated guess: This looks like an attempt to get the object out
    ; of high priority status that resulted from hitting certain tiles
    ; in earlier frames, like ledges.
    DEC.w $028A, X : BPL .no_collision
        STZ.w $028A, X
        
        LDA.b $0F : CMP.b #$04 : BNE .no_collision
            LDA.b #$06 : STA.w $028A, X
            
            LDA.w $0280, X : EOR.b #$01 : STA.w $0280, X
            
            BRA .no_collision
        
    .no_collision
    .tile_type_not_collision_candidate
    
    CLC
    
    RTS
    
    .collided
    
    LDY.b #$00
    
    SEC

    ; Bleeds into the next function.
}
    
; $040AB9-$040ABE LOCAL JUMP LOCATION
Ancilla_AlertSprites:
{
    ; This seems to activate enemies that "listen" for sounds.
    LDA.b #$03 : STA.w $0FDC
    
    RTS
}

; ==============================================================================

; $040ABF-$040BCE DATA
Pool_Ancilla_CheckTileCollision_Class2:
{
    ; Similar to the other collision routine's behavior table, this one
    ; opts to not interact with torches or chests, but interacts more
    ; generally with doors and screen transition tiles. This may have
    ; something to do with.
    .collision_table
    db 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 0, 0, 0, 0, 2, 2, 2, 2, 0, 3, 3, 3
    db 0, 0, 0, 0, 0, 0, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
    db 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 3, 3, 3
    db 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
    .y_offsets_low
    db -8, 8, 0, 0
    
    .y_offsets_high
    db -1, 0, 0, 0
    
    .x_offsets_low
    db 0, 0, -8, 8
    
    .x_offsets_high
    db 0, 0, -1, 0
}

; ==============================================================================

; $040BCF-$040CD8 LOCAL JUMP LOCATION
Ancilla_CheckTileCollision_Class2:
{
    ; Does collision detection for a number of entities, bombs being one of them.
    
    ; "Collision" in Hyrule Magic. Do only collision on BG2.
    LDA.w $046C : BEQ .check_basic_collision
        ; Is it the "moving floor" collision type?
        ; if it's collision with 2 BGs then branch.
        CMP.b #$03 : REP #$20 : BCC .difference_between_bg_scrolls
            STZ.b $00
            STZ.b $02
            
            BRA .two_bg_collision_detection
        
        .difference_between_bg_scrolls
        
        ; Calculate the differences in the scroll values between the two main BGs
        ; This is for rooms that have a hidden wall (there's only like 3 of them
        ; in the original).
        
        ; $00 = BG1HOFS - BG0HOFS
        LDA.b $E0 : SEC : SBC.b $E2 : STA.b $00
        
        ; $02 = BG1VOFS - BG0VOFS
        LDA.b $E6 : SEC : SBC.b $E8 : STA.b $02
        
        .two_bg_collision_detection
        
        SEP #$20
        
        LDA.w $0C04, X : PHA : CLC : ADC.b $00 : STA.w $0C04, X
        LDA.w $0C18, X : PHA : ADC.b $01 : STA.w $0C18, X
        
        LDA.w $0BFA, X : PHA : CLC : ADC.b $02 : STA.w $0BFA, X
        LDA.w $0C0E, X : PHA : ADC.b $03 : STA.w $0C0E, X
        
        LDA.b #$01 : STA.w $0C7C, X
        
        JSR.w .check_basic_collision
        
        STZ.w $0C7C, X
        
        PLA : STA.w $0C0E, X
        PLA : STA.w $0BFA, X
        
        PLA : STA.w $0C18, X
        PLA : STA.w $0C04, X
        
        LDY.b #$00
        
        BCC .no_bg1_collision
            INY
        
        .no_bg1_collision
        
        PHY : PHP
        
        JSR.w .check_basic_collision
        
        PLA : AND.b #$01 : ROL A : CMP.b #$01
        
        PLY
        
        RTS
    
    .check_basic_collision
    
    ; Normal collision detect (for just one BG).
    ; Next set of operations compute Ycoord + direction dependent value, as well
    ; as for the Xcoord of the object.
    
    ; Direction of the bomb.... I guess... kind of a dumb way to handle this if
    ; you ask me.
    LDY.w $0C72, X
    
    ; $00 = Ycoord + directionValue
    LDA.w $0BFA, X : CLC : ADC .y_offsets_low,  Y : STA.b $00
    LDA.w $0C0E, X :       ADC .y_offsets_high, Y : STA.b $01
    
    ; $02 = Xcoord + directionValue
    LDA.w $0C04, X : CLC : ADC .x_offsets_low,  Y : STA.b $02
    LDA.w $0C18, X :       ADC .x_offsets_high, Y : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $E8
    
    CMP.w #$00E0 : SEP #$20 : BCS .ignore_off_screen_collision
        REP #$20
        
        LDA.b $02 : SEC : SBC.b $E2
        
        CMP.w #$0100 : SEP #$20 : BCS .ignore_off_screen_collision
            ; Are we in a dungeon?
            LDA.b $1B : BNE .check_indoor_collision
                REP #$20
                
                LSR.b $02 : LSR.b $02 : LSR.b $02
                
                PHX
                
                JSL.l Overworld_GetTileAttrAtLocation
                
                PLX
                
                BRA .store_queried_tile_attr
            
            .check_indoor_collision
            
            ; Tells us what floor the bomb is on and is an input to the next
            ; function.
            LDA.w $0C7C, X
            
            JSL.l Entity_GetTileAttr
            
            .store_queried_tile_attr
            
            ; Store the retrieved tile value for further reference.
            ; TODO: Figure out when and where attribute 3 tile are actually used.
            STA.w $03E4, X : CMP.b #$03 : BNE .not_attr_3
                LDY.w $03CA, X : BNE .ignore_collision_on_pseudo_bg
            
            .not_attr_3
            
            TAY
            
            ; Collision detection table:
            LDA.w .collision_table, Y : BEQ .no_collision
                CMP.b #$02 : BNE .not_sloped_collision
                    ; Should be noted that like the other return points for this
                    ; routine, the above routine returns a boolean result via
                    ; the carry flag.
                    JSL.l Entity_CheckSlopedTileCollisionLong
                    
                    RTS
                
                .not_sloped_collision
                
                ; Seems like ledges kind of guarantee no collision unless the
                ; object is on a pseudo-bg?
                CMP.b #$04 : BNE .not_ledge_tile
                    LDA.w $03CA, X : BNE .collided
                        LDA.b #$01 : STA.w $0280, X
                        
                        BRA .no_collision
                
                .not_ledge_tile
                
                CMP.b #$03 : BNE .collided
                    LDY.w $03CA, X : BNE .collided

            .no_collision
            .ignore_collision_on_pseudo_bg
    .ignore_off_screen_collision
    
    CLC ; Failure, no tile can be detected.
    
    RTS
    
    .collided
    
    LDY.b #$00
    
    SEC
    
    RTS
}

; ==============================================================================

; $040CD9-$040D67
incsrc "ancilla_beam_hit.asm"

; ==============================================================================

; $040D68-$040DA1 LOCAL JUMP LOCATION
Ancilla_CheckSpriteCollision:
{
    LDY.b #$0F
    
    .next_sprite
    
        LDA.w $0C4A, X
        
        CMP.b #$09 : BEQ .arrow_or_hookshot
        CMP.b #$1F : BEQ .arrow_or_hookshot
            TYA : EOR.b $1A : AND.b #$03 : ORA.w $0F00, Y : BNE .ignore_sprite
        
        .arrow_or_hookshot
        
        LDA.w $0DD0, Y : CMP.b #$09 : BCC .ignore_sprite
            LDA.w $0CAA, Y : AND.b #$02 : BNE .ignore_priority_differences
                LDA.w $0280, X : BNE .ignore_sprite
            
            .ignore_priority_differences
            
            LDA.w $0C7C, X : CMP.w $0F20, Y : BNE .ignore_sprite
                JSR.w Ancilla_CheckIndividualSpriteCollision
        
        .ignore_sprite
    DEY : BPL .next_sprite
    
    CLC
    
    RTS
}

; ==============================================================================

; $040DA2-$040DA9 LONG JUMP LOCATION
Ancilla_CheckSpriteCollisionLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckSpriteCollision
    
    PLB
    
    RTL
}

; ==============================================================================

; $040DAA-$040DAD DATA
Pool_Ancilla_CheckIndividualSpriteCollision:
{
    .opposing_sprite_directions
    db 2, 3, 0, 1
}

; ==============================================================================

; $040DAE-$040E7C LOCAL JUMP LOCATION
Ancilla_CheckIndividualSpriteCollision:
{
    JSR.w Ancilla_SetupHitBox
    
    PHY : PHX
    
    TYX
    
    JSL.l Sprite_SetupHitBoxLong
    
    PLX : PLY
    
    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCS .hit_box_overlap
        JMP .no_collision
    
    .hit_box_overlap
    
    LDA.w $0B6B, Y : AND.b #$08 : BEQ .doesnt_deflect_arrows
        LDA.w $0C4A, X : CMP.b #$09 : BNE .not_arrow_ancilla
            LDA.w $0E20, Y : CMP.b #$1B : BEQ .not_arrow_vs_enemy_arrow
                .create_deflected_arrow
                
                JSL.l Sprite_CreateDeflectedArrow
                
                CLC
                
                RTS
            
            .not_arrow_vs_enemy_arrow
            
            ; Do we have Silver Arrows?
            LDA.l $7EF340 : CMP.b #$03 : BCC .not_silver_arrows
                JSR.w .undeflected_silver_arrow
                
                CLC
                
                RTS
            
            .not_silver_arrows
            
            JSR.w .create_deflected_arrow

        .not_arrow_ancilla
    .doesnt_deflect_arrows
    
    ; $040DEE ALTERNATE ENTRY POINT
    .undeflected_silver_arrow
    
    LDA.w $0CAA, Y : AND.b #$10 : BEQ .doesnt_absorb_ancilla
        ; Check if the ancilla hit the sprite from the 'front', meaning
        ; that they have opposing orientations.
        LDA.w $0C72, X : AND.b #$03 : STA.w $0C72, X
        
        PHY
        
        LDA.w $0DE0, Y : TAY
        
        LDA.w .opposing_sprite_directions, Y
        
        PLY
        
        CMP.w $0C72, X : BEQ .collision_immunity
    
    .doesnt_absorb_ancilla
    
    LDA.w $0C4A, X : CMP.b #$05 : BEQ .boomerang_ancilla
        CMP.b #$1F : BNE .not_hookshot_ancilla
            LDA.w $0E20, Y : CMP.b #$8D : BEQ .is_arrghus_spawn
    
    .boomerang_ancilla
    
    ; Can't collide because the sprite has begun dying.
    LDA.w $0EF0, Y : BNE .collision_immunity
        LDA.w $0CAA, Y : AND.b #$02 : BEQ .not_draggable_sprite
            .is_arrghus_spawn
            
            ; Initiate dragging the sprite with the hookshot or boomerang?
            TXA : INC A : STA.w $0DA0, Y
            
            BRA .indicate_dragging_ancilla
            
            .not_hookshot_ancilla
        .not_draggable_sprite
        
        LDA.w $0BA0, Y : BNE .no_collision
            LDA.w $0E20, Y : CMP.b #$92 : BNE .not_helmasaur_king_component
                LDA.w $0DB0, Y : CMP.b #$03 : BCC .collision_immunity
            
            .not_helmasaur_king_component
            
            PHX
            
            LDA.w $0C72, X : AND.b #$03 : TAX 
            
            LDA.w .sprite_recoil_x, X : STA.w $0F40, Y
            LDA.w .sprite_recoil_y, X : STA.w $0F30, Y
            
            PLX : PHX
            
            LDA.w $0C4A, X : STX.w $0FB6
            
            TYX : PHY
            
            JSL.l Ancilla_CheckSpriteDamage
            
            PLY : PLX
            
            .indicate_dragging_ancilla
            
            LDA.w $0C4A, X : STA.w $0BB0, Y
    
    .collision_immunity
    
    PLA : PLA
    
    JSR.w Ancilla_AlertSprites
    
    SEC
    
    RTS
    
    .no_collision
    
    CLC
    
    RTS
    
    .sprite_recoil_x
    db 0, 0, -64, 64
    
    .sprite_recoil_y
    db -64, 64, 0, 0
}

; ==============================================================================

; $040E7D-$040EAC DATA
Pool_Ancilla_SetupHitBox:
{
    ; $040E7D
    .offset_x
    db   4,   4,  4,  4
    db   3,   3,  2, 11
    db -16, -16, -1, -8
    
    ; $040E89
    .width
    db  8,  8, 8, 8
    db  1,  1, 1, 1
    db 32, 32, 8, 8
    
    ; $040E95
    .offset_y
    db  4,  4,   4,   4
    db  2, 11,   2,   2
    db -1, -8, -16, -16
    
    ; $040EA1
    .height
    db 8, 8,  8,  8
    db 1, 1,  1,  1
    db 8, 8, 32, 32
}

; ==============================================================================

; $040EAD-$040EEC LOCAL JUMP LOCATION
Ancilla_SetupHitBox:
{
    STZ.b $09
    
    PHY
    
    LDY.w $0C72, X
    
    LDA.w $0C4A, X : CMP.b #$0C : BNE .not_sword_beam
        DEC.b $09
        
        ; Use a different set of values for the sword beam. Apparently this is
        ; due to 1. The sword beam being incapable of diagonal motion? and / or
        ; 2. That the master sword beam uses a larger hit box (not the larger
        ; values overall).
        TYA : ORA.b #$08 : TAY
    
    .not_sword_beam
    
    LDA.w $0C04, X : CLC : ADC.w Pool_Ancilla_SetupHitBox_offset_x, Y : STA.b $00
    LDA.w $0C18, X :       ADC.b $09                                  : STA.b $08
    
    LDA.w $0BFA, X : CLC : ADC.w Pool_Ancilla_SetupHitBox_offset_y, Y : STA.b $01
    LDA.w $0C0E, X :       ADC.b $09                                  : STA.b $09
    
    LDA.w Pool_Ancilla_SetupHitBox_width, Y  : STA.b $02
    LDA.w Pool_Ancilla_SetupHitBox_height, Y : STA.b $03
    
    PLY
    
    RTS
    
    .unused
    
    RTS
}

; ==============================================================================

; $040EED-$040F5B LOCAL JUMP LOCATION
Ancilla_ProjectSpeedTowardsPlayer:
{
    STA.b $01
    
    PHX : PHY
    
    JSR.w Ancilla_IsBelowPlayer
    
    STY.b $02
    
    LDA.b $0E : BPL .delta_y_already_positive
        EOR.b #$FF : INC A
    
    .delta_y_already_positive
    
    STA.b $0C
    
    JSR.w Ancilla_IsToRightOfPlayer
    
    STY.b $03
    
    LDA.b $0F : BPL .delta_x_already_positive
        EOR.b #$FF : INC A
    
    .delta_x_already_positive
    
    STA.b $0D
    
    LDY.b #$00
    
    LDA.b $0D : CMP $0C : BCS .dx_is_bigger
        ; y = 1 if y component is larger, 0 if x component is larger.
        INY
        
        ; Swap $0C and $0D if y component is larger.
        PHA : LDA.b $0C : STA.b $0D
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
            
            ; Apportion velocity to the direction that has less magnitude for
            ; once.
            INC.b $00
        
        .not_accumulated_yet
        
        STA.b $0B
    DEX : BNE .still_have_velocity_to_apply
    
    TYA : BEQ .dx_is_bigger_2
    
    ; Swap again.
    LDA.b $00 : PHA
    LDA.b $01 : STA.b $00
    PLA       : STA.b $01
    
    .dx_is_bigger_2
    
    LDA.b $00
    
    LDY.b $02 : BEQ .y_polarity_correct
        EOR.b #$FF : INC A : STA.b $00
    
    .y_polarity_correct
    
    LDA.b $01
    
    LDY.b $03 : BEQ .x_polarity_correct
        EOR.b #$FF : INC A : STA.b $01
    
    .x_polarity_correct
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $040F5C-$040F6E LOCAL JUMP LOCATION
Ancilla_IsToRightOfPlayer:
{
    LDY.b #$00
    
    LDA.b $22 : SEC : SBC.w $0C04, X : STA.b $0F
    LDA.b $23 : SBC.w $0C18, X : BPL .object_leftward_of_player
        ; Object is rightward of player.
        INY
    
    .object_leftward_of_player
    
    RTS
}

; ==============================================================================

; $040F6F-$040F81 LOCAL JUMP LOCATION
Ancilla_IsBelowPlayer:
{
    LDY.b #$00
    
    LDA.b $20 : SEC : SBC.w $0BFA, X : STA.b $0E
    LDA.b $21 : SBC.w $0C0E, X : BPL .object_upward_of_player
        ; Object is downward of player.
        INY
    
    .object_upward_of_player

    ; $040F81 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $040F82-$04107F
incsrc "ancilla_repulse_spark.asm"

; ==============================================================================

; $041080-$04108A LOCAL JUMP LOCATION
Ancilla_MoveHoriz:
{
    ; Increments X_reg by 0x0A so that X coordinates will be handled next.
    TXA : CLC : ADC.b #$0A : TAX
    
    JSR.w Ancilla_MoveVert
    
    ; Reload the special object's index to X.
    BRL Ancilla_RestoreIndex
}

; ==============================================================================

; $04108B-$0410B6 LOCAL JUMP LOCATION
Ancilla_MoveVert:
{
    LDA.w $0C22, X : ASL #4 : CLC : ADC.w $0C36, X : STA.w $0C36, X
    
    LDY.b #$00
    
    ; Upper 4 bits are pixels per frame. lower 4 bits are 1/16ths of a pixel per
    ; frame. store the carry result of adding to $0C36, X check if the y pixel
    ; change per frame is negative.
    LDA.w $0C22, X : PHP : LSR #4 : PLP : BPL .moving_down
        ; Sign extend from 4-bits to 8-bits.
        ORA.b #$F0
        
        DEY
    
    .moving_down
    
    ; Modifies the y coordinates of the special object.
          ADC.w $0BFA, X : STA.w $0BFA, X
    TYA : ADC.w $0C0E, X : STA.w $0C0E, X
    
    RTS
}

; ==============================================================================

; $0410B7-$0410DB LOCAL JUMP LOCATION
Ancilla_MoveAltitude:
{
    LDA.w $0294, X : ASL #4 : CLC : ADC.w $02A8, X : STA.w $02A8, X
    
    LDY.b #$00
    
    LDA.w $0294, X : PHP : LSR #4 : PLP : BPL .moving_higher
        ORA.b #$F0
    
    .moving_higher
    
    ADC.w $029E, X : STA.w $029E, X
    
    RTS
}

; ==============================================================================

; $0410DC-$0413E7
incsrc "ancilla_boomerang.asm"

; $0413E8-$041542
incsrc "ancilla_wall_hit.asm"

; $041543-$041FB5
incsrc "ancilla_bomb.asm"

; $041FB6-$042120
incsrc "ancilla_door_debris.asm"

; $042121-$04245A
incsrc "ancilla_arrow.asm"

; $04245B-$0424DC
incsrc "ancilla_halted_arrow.asm"

; $0424DD-$042535
incsrc "ancilla_ice_shot.asm"

; $042536-$04260D
incsrc "ancilla_ice_shot_spread.asm"

; $04260E-$04280C
incsrc "ancilla_blast_wall.asm"

; $04280D-$0428E2
incsrc "ancilla_jump_splash.asm"

; $0428E3-$042996
incsrc "ancilla_hit_stars.asm"

; $042997-$042A31
incsrc "ancilla_shovel_dirt.asm"

; $042A32-$042A9F
incsrc "ancilla_blast_wall_fireball.asm"

; $042AA0-$042F55
incsrc "ancilla_ether_spell.asm"

; $042F56-$043669
incsrc "ancilla_bombos_spell.asm"

; $04366A-$0438F3
incsrc "ancilla_quake_spell.asm"

; $0438F4-$043BBB
incsrc "ancilla_magic_powder.asm"

; $043BBC-$043BF3
incsrc "ancilla_dash_tremor.asm"

; $043BF4-$043D4B
incsrc "ancilla_dash_dust.asm"

; $043D4C-$044002
incsrc "ancilla_hookshot.asm"

; $044003-$044090
incsrc "ancilla_bedspread.asm"

; $044091-$044106
incsrc "ancilla_sleep_icon.asm"

; $044107-$0441E3
incsrc "ancilla_victory_sparkle.asm"

; $0441E4-$04422E
incsrc "ancilla_sword_charge_spark.asm"

; $04422F-$0442DC
incsrc "ancilla_sword_ceremony.asm"

; $0442DD-$0446F1
incsrc "ancilla_receive_item.asm"

; $0446F2-$0447DD
incsrc "ancilla_wish_pond_item.asm"

; $0447DE-$044986
incsrc "ancilla_happiness_pond_rupees.asm"

; $044987-$044A84
incsrc "ancilla_object_splash.asm"

; $044A85-$044BE3
incsrc "ancilla_milestone_item.asm"

; $044BE4-$044C92
incsrc "ancilla_rising_crystal.asm"

; ==============================================================================

; $044C93-$044C9F LOCAL JUMP LOCATION
Ancilla_AddSwordChargeSpark:
{
    ; Only on certain frames.
    LDA.b $1A : AND.b #$07 : BNE .sorry_ladies_no_sparkles_with_this_dress
        PHX
        
        JSL.l AddSwordChargeSpark
        
        PLX
    
    .sorry_ladies_no_sparkles_with_this_dress
    
    RTS
}

; ==============================================================================

; $044CA0-$044FA5
incsrc "ancilla_break_tower_seal.asm"

; $044FA6-$04503C
incsrc "ancilla_flute.asm"

; $04503D-$0451D3
incsrc "ancilla_weathervane_explosion.asm"

; $0451D4-$045379
incsrc "ancilla_travel_bird_intro.asm"

; $04537A-$045499
incsrc "ancilla_morph_poof.asm"

; $04549A-$0454B8
incsrc "ancilla_dwarf_poof.asm"

; $0454B9-$045595
incsrc "ancilla_bush_poof.asm"

; $045596-$045703
incsrc "ancilla_sword_swing_sparkle.asm"

; $045704-$0458F5
incsrc "ancilla_initial_spin_spark.asm"

; $0458F6-$045A83
incsrc "ancilla_spin_spark.asm"

; $045A84-$045DC4
incsrc "ancilla_cane_spark.asm"

; ==============================================================================

; $045DC5-$045DC9 JUMP LOCATION
Ancilla_SwordBeam:
{
    JSL.l SwordBeam
    
    RTS
}

; ==============================================================================

; $045DCA-$045DD7 JUMP LOCATION
Ancilla_SwordFullChargeSpark:
{
    LDA.b #$04
    
    JSR.w Ancilla_AllocateOam
    
    TYA : STA.w $0C86, X
    
    JSL.l SwordFullChargeSpark
    
    RTS
}

; ==============================================================================

; $045DD8-$046067
incsrc "ancilla_travel_bird.asm"

; $046068-$0461F8
incsrc "ancilla_init_somarian_block.asm"

; ==============================================================================

; $0461F9-$04623C LOCAL JUMP LOCATION
Ancilla_CheckBasicSpriteCollision:
{
    LDY.b #$0F
    
    .next_sprite
    
        ; This staggers out collision detection so only some fraction of the
        ; prites are being checked for collision with the object.
        TYA : EOR.b $1A : AND.b #$03

        ORA.w $0F00, Y : ORA.w $0EF0, Y : BNE .no_collision
            LDA.w $0DD0, Y : CMP.b #$09 : BCC .no_collision
                LDA.w $0CAA, Y : AND.b #$02 : BNE .sprite_ignores_priority
                    LDA.w $0280, X : BNE .no_collision
                
                .sprite_ignores_priority
                
                LDA.w $0C7C, X : CMP.w $0F20, Y : BNE .no_collision
                    LDA.w $0C4A, X : CMP.b #$2C : BNE .not_somarian_block
                        ; Crystal switches ignore interaction with somarian
                        ; blocks apparently. (But when they are transmuted to
                        ; blasts, this is no longer the case.)
                        LDA.w $0E20, Y : CMP.b #$1E : BEQ .no_collision
                            CMP.b #$90 : BEQ .no_collision
                    
                    .not_somarian_block
                    
                    JSR.w Ancilla_CheckSingleBasicSpriteCollision
        
        .no_collision
    DEY : BPL .next_sprite
    
    CLC
    
    RTS
}

; ==============================================================================

; $04623D-$0462C9 LOCAL JUMP LOCATION
Ancilla_CheckSingleBasicSpriteCollision:
{
    JSR.w Ancilla_SetupBasicHitBox
    
    PHY : PHX
    
    TYX
    
    JSL.l Sprite_SetupHitBoxLong
    
    PLX : PLY
    
    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .no_collision
        ; Helmasaur king check...
        LDA.w $0E20, Y : CMP.b #$92 : BNE .not_helmasaur_king_component
            LDA.w $0DB0, Y : CMP.b #$03 : BCC .not_helmasaur_king_mask
        
        .not_helmasaur_king_component
        
        ; Only make the sprite change direction if it's a Winder. At that,
        ; only somarian blocks and fire rod shots call here anyways, afaik.
        LDA.w $0E20, Y : CMP.b #$80 : BNE .dont_repulse_sprite
            LDA.w $0F10, Y : BNE .dont_repulse_sprite
                LDA.b #$18 : STA.w $0F10, Y
                
                LDA.w $0DE0, Y : EOR.b #$01 : STA.w $0DE0, Y
        
        .dont_repulse_sprite
        
        LDA.w $0BA0, Y : BNE .no_collision
            LDA.w $0C04, X : SEC : SBC.b #$08 : STA.b $04
            LDA.w $0C18, X : SBC.b #$00 : STA.b $05
            
            LDA.w $0BFA, X : SEC : SBC.b #$08
            PHP : SEC : SBC.w $029E, X : STA.b $06

            LDA.w $0C0E, X : SBC.b #$00 
            PLP : SBC.b #$00 : STA.b $07
            
            LDA.b #$50
            
            PHY : PHX
            
            TYX
            
            JSL.l Sprite_ProjectSpeedTowardsEntityLong
            
            PLX : PLY
            
            LDA.b $00 : EOR.b #$FF : STA.w $0F30, Y
            LDA.b $01 : EOR.b #$FF : STA.w $0F40, Y
            
            PHX
            
            LDA.w $0C4A, X
            
            TYX
            
            JSL.l Ancilla_CheckSpriteDamage
            
            PLX
            
            .not_helmasaur_king_mask
            
            PLA : PLA
            
            SEC
            
            RTS
    
    .no_collision
    
    CLC
    
    RTS
}

; ==============================================================================

; NOTE: By basic I mean that it is not specific to the special object's type,
; like the other routine does. This creates a 15x15 hit box that starts 8 pixels
; to the left and above the sprite. This routine, however, also takes altitude
; into account, whereas the more specific one doesn't, for whatever reason.
; $0462CA-$0462F8 LOCAL JUMP LOCATION
Ancilla_SetupBasicHitBox:
{
    LDA.w $0C04, X : SEC : SBC.b #$08 : STA.b $00
    LDA.w $0C18, X : SBC.b #$00 : STA.b $08
    
    LDA.w $0BFA, X : SEC : SBC.b #$08 : PHP : SEC : SBC.w $029E, X : STA.b $01
    LDA.w $0C0E, X :       SBC.b #$00 : PLP :       SBC.b #$00     : STA.b $09
    
    LDA.b #$0F : STA.b $02
    LDA.b #$0F : STA.b $03
    
    .return
    
    RTS
}

; ==============================================================================

; $0462F9-$04698D
incsrc "ancilla_somarian_block.asm"

; $04698E-$046A7E
incsrc "ancilla_somarian_block_fizzle.asm"

; $046A7F-$046B3D
incsrc "ancilla_somarian_platform_poof.asm"

; $046B3E-$046BE2
incsrc "ancilla_somarian_block_divide.asm"

; $046BE3-$046C76
incsrc "ancilla_lamp_flame.asm"

; $046C77-$046D88
incsrc "ancilla_waterfall_splash.asm"

; $046D89-$046EDD
incsrc "ancilla_gravestone.asm"

; $046EDE-$047168
incsrc "ancilla_skull_woods_fire.asm"

; $047169-$04727B
incsrc "ancilla_super_bomb_explosion.asm"

; $04727C-$0474C9
incsrc "ancilla_revival_fairy.asm"

; $0474CA-$047623
incsrc "ancilla_game_over_text.asm"

; ==============================================================================

; $047624-$047630 LOCAL JUMP LOCATION
Ancilla_SetSfxPan_NearEntity:
{
    PHX
    
    LSR #5 : TAX
    
    LDA.l AncillaPanValues, X
    
    PLX
    
    RTS
}

; ==============================================================================

; $047631-$04765E LOCAL JUMP LOCATION
Ancilla_Spawn:
{
    PHA
    
    JSL.l Ancilla_CheckForAvailableSlot
    
    PLA
    
    TYX : BMI .no_open_slots
        STA.w $0C4A, X : TAY
        
        LDA.w AncillaObjectAllocation, Y : STA.w $0C90, X
        LDA.b $EE                        : STA.w $0C7C, X
        LDA.w $0476                      : STA.w $03CA, X
        
        STZ.w $0C22, X
        STZ.w $0C2C, X
        STZ.w $0280, X
        STZ.w $028A, X
        
        CLC
        
        RTS
    
    .no_open_slots
    
    SEC
    
    RTS
}

; ==============================================================================

; $04765F-$04766C LOCAL JUMP LOCATION
UNREACHABLE_08F65F:
Ancilla_FindMatch:
{
    ; Looks through active effect slots to see if the one we want to
    ; put in is already there.

    LDX.b #$05
    
    .next_slot
    
        CMP.w $0C4A, X : BEQ .match
    DEX : BPL .next_slot
    
    CLC
    
    RTS
    
    .match
    
    SEC
    
    RTS
}

; ==============================================================================

; $04766D-$047670 DATA
Ancilla_PrepOamCoord_priority:
{
    db $20, $10, $30, $20
}

; $047671-$0476A3 LOCAL JUMP LOCATION
Ancilla_PrepOamCoord:
{
    LDY.w $0C7C, X
    
    LDA.w .priority, Y : STA.b $65
    STZ.b $64
    
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $E8 : STA.b $00
    LDA.b $02 : SEC : SBC.b $E2 : STA.b $02 : STA.b $04
    
    SEP #$20
    
    RTS
}

; Identical to the preceding routine, except that it measures against
; the adjusted screen coordinates ($0122 and $011e) which can be
; manipulated via effects and.... moving floors maybe.
; $0476A4-$0476D8 LOCAL JUMP LOCATION
Ancilla_PrepAdjustedOamCoord:
{
    LDY.w $0C7C, X
    
    LDA Pool_Ancilla_PrepOamCoord_priority, Y : STA.b $65
    STZ.b $64
    
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.w $0122 : STA.b $00
    
    LDA.b $02 : SEC : SBC.w $011E : STA.b $02 : STA.b $04
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0476D9-$0476E0 LONG JUMP LOCATION
Ancilla_PrepOamCoordLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_PrepOamCoord
    
    PLB
    
    RTL
}

; ==============================================================================

; Note: Performs a basic bounds check before deciding to write OAM x and y
; coordinates to the OAM buffer. While this routine is quite adequate for just
; displaying special effects that are expected to be fully within the framme of
; view, it is not quite correct for handling OAM sprites that are partially on
; screen and partially off screen.
; $0476E1-$0476FD LOCAL JUMP LOCATION
Ancilla_SetOam_XY:
{
    PHX
    
    ; Get set to push the sprite offscreen.
    LDX.b #$F0
    
    ; I'm guessing $01 and $03 indicate the sprite is offscreen.
    LDA.b $01 : BNE .off_screen
        LDA.b $03 : BNE .off_screen
            ; Store the X coordinate into OAM.
            LDA.b $02 : STA ($90), Y
            
            ; Indicates the sprite is already below the visible lines of the
            ; screen.
            LDA.b $00 : CMP.b #$F0 : BCS .off_screen
                TAX
    
    .off_screen
    
    INY
    
    ; Store the Y coordinate.
    TXA : STA ($90), Y : INY
    
    PLX
    
    RTS
}

; ==============================================================================

; $0476FE-$047701 LONG JUMP LOCATION
Ancilla_SetOam_XY_Long:
{
    JSR.w Ancilla_SetOam_XY
    
    RTL
}

; ==============================================================================

; Note: This routine sets the x and y OAM coordinates of an ancillary object in
; the correct way that most other logic in the game uses. The more basic
; Ancilla_SetOam_XY doesn't account for OAM entries being partially on screen
; and partially off screen.
; $047702-$04772E LOCAL JUMP LOCATION
Ancilla_SetSafeOam_XY:
{
    REP #$20
    
    ; Store the sprite's X coordinate.
    LDA.b $02 : STA ($90), Y : INY
    
    ; Is the sprite's X coordinate > 0x100?
    CLC : ADC.w #$0080 : CMP.w #$0180 : BCS .off_screen
        ; If the sprite's X coordinate exceeds 0x100.
        LDA.b $02 : AND.w #$0100 : STA.b $74
        
        LDA.b $00 : STA ($90), Y
        
        ; Same as CMP #$00F0... I don't get it.
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen
    
    .off_screen
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen
    
    SEP #$20
    
    INY
    
    RTS
}

; ==============================================================================

; $04772F-$04776A DATA
Pool_Ancilla_CheckPlayerCollision:
{
    .y_offsets
    db  0,  0,  8,  0,  8,  0,  8,  0,  0,  0
    
    .x_offsets
    db  0,  0,  8,  0,  8,  0,  8,  0,  0,  0
    
    .y_windows
    db 20,  0, 20,  0,  8,  0, 28,  0, 14,  0
    
    .x_windows
    db 20,  0,  3,  0,  8,  0, 24,  0, 14,  0
    
    .player_y_offsets
    db 12,  0, 12,  0, 12,  0, 12,  0, 12,  0
    
    .player_x_offsets
    db  8,  0,  8,  0,  8,  0, 12,  0,  8,  0
    
}

; Note: Checks ancilla collision or proximity with the player.
; $04776B-$0477DB LOCAL JUMP LOCATION
Ancilla_CheckPlayerCollision:
{
    ; Y is probably a selector for different hit box sizes.
    TYA : ASL A : TAY
    
    ; $00 = Y coordinate
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    ; $02 = X coordinate
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    STZ.b $0B
    
    ; $0A = "altitude"
    LDA.w $029E, X : STA.b $0A : BPL .sign_ext_z_coord
        LDA.b #$FF : STA.b $0B
    
    .sign_ext_z_coord
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.b $0A : CLC : ADC .y_offsets, Y : STA.b $00
    LDA.b $02                   : CLC : ADC .x_offsets, Y : STA.b $02
    
    LDA.b $20 : CLC : ADC .player_y_offsets, Y : SEC : SBC.b $00
    
    STA.b $04 : BPL .positive_delta_y
        EOR.w #$FFFF : INC A
    
    .positive_delta_y
    
    STA.b $08 : CMP .y_windows, Y : BCC .not_collision
        LDA.b $22 : CLC : ADC .player_x_offsets, Y : SEC : SBC.b $02
        
        STA.b $06 : BPL .positive_delta_x
            EOR.w #$FFFF : INC A
        
        .positive_delta_x
        
        STA.b $0A : CMP .x_windows, Y : BCS .not_collision
            SEP #$20
            
            SEC
            
            RTS

    .not_collision

    SEP #$20
    
    CLC
    
    RTS
}

; ==============================================================================

; $0477DC-$047823 LOCAL JUMP LOCATION
Hookshot_CheckChainLinkProximityToPlayer:
{
    REP #$20
    
    LDA.b $00 : CLC : ADC.w #$0004 : STA.b $72
    LDA.b $02 : CLC : ADC.w #$0004 : STA.b $74
    
    LDA.b $20 : SEC : SBC.b $E8 : CLC : ADC.w #$000C : SEC : SBC.b $72 : BPL .positive_delta_y
        EOR.w #$FFFF : INC A
    
    .positive_delta_y
    
    CMP.w #$000C : BCS .out_of_range
        LDA.b $22 : SEC : SBC.b $E2 : CLC : ADC.w #$0008 : SEC : SBC.b $74 : BPL .positive_delta_x
            EOR.w #$FFFF : INC A
        
        .positive_delta_x
        
        CMP.w #$000C : BCS .out_of_range
            SEP #$20
            
            SEC
            
            RTS
            
    .out_of_range
    
    SEP #$20
    
    CLC
    
    RTS
}

; ==============================================================================

; $047824-$047843 DATA
Pool_Ancilla_CheckIfEntranceTriggered:
{
    .trigger_coord_y
    dw $0D40, $0210, $0CFC, $0100
    
    .trigger_coord_x
    dw $0D80, $0E68, $0130, $0F10
    
    .trigger_window_y
    dw $000B, $0020, $0010, $000C
    
    .trigger_window_x
    dw $0010, $0010, $0010, $0010
}

; $047844-$04787A LOCAL JUMP LOCATION
Ancilla_CheckIfEntranceTriggered:
{
    ; Y is the index into the coordinates where the trigger blocks are.
    TYA : ASL A : TAY
    
    REP #$20
    
    ; Centers player's Y coordinate.
    LDA.b $20 : CLC : ADC.w #$000C : SEC : SBC .trigger_coord_y, Y : BPL .positive_delta_y
        EOR.w #$FFFF : INC A
    
    .positive_delta_y
    
    ; Is the distance less than or equal to this many pixels?
    CMP .trigger_window_y, Y : BCS .failure
        ; Centers player's X coordinate.
        LDA.b $22 : CLC : ADC.w #$0008 : SEC : SBC .trigger_coord_x, Y : BPL .positive_delta_x
            ; * -1
            EOR.w #$FFFF : INC A
        
        .positive_delta_x
        
        ; Is the distance less than or equal to this.
        CMP .trigger_window_x, Y : BCS .failure
            SEP #$20
            
            SEC
            
            RTS
    
    .failure
    
    SEP #$20
    
    CLC
    
    RTS
}

; ==============================================================================

; $04787B-$047896 DATA
Pool_Ancilla_DrawShadow:
{
    ; $04787B
    .chr
    db $6C, $6C
    db $28, $28
    db $38, $FF
    db $C8, $C8
    db $D8, $D8
    db $D9, $D9
    db $DA, $DA
    
    ; $047889
    .properties
    db $28, $68
    db $28, $68
    db $28, $FF
    db $22, $22
    db $24, $64
    db $24, $64
    db $24, $64
}

; $047897-$047909 LOCAL JUMP LOCATION
Ancilla_DrawShadow:
{
    CPX.b #$02 : BNE .not_small_shadow
        REP #$20
        
        LDA.b $02 : CLC : ADC.w #$0004 : STA.b $02
        
        SEP #$20
    
    .not_small_shadow
    
    TXA : ASL A : TAX
    
    STZ.b $74
    STZ.b $75
    
    JSR.w Ancilla_SetSafeOam_XY
    
    LDA.w Pool_Ancilla_DrawShadow_chr, X : STA ($90), Y
    INY

    LDA.w Pool_Ancilla_DrawShadow_properties, X
    AND.b #$CF : ORA.b $04 : STA ($90), Y
    INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : ORA.b $75 : STA ($92), Y
    
    PLY
    
    REP #$20
    
    LDA.b $02 : CLC : ADC.w #$0008 : STA.b $02
    
    SEP #$20
    
    LDA.w Pool_Ancilla_DrawShadow_chr+1, X : CMP.b #$FF : BEQ .only_one_oam_entry
        STZ.b $74
        STZ.b $75
        
        JSR.w Ancilla_SetSafeOam_XY
        
        LDA.w Pool_Ancilla_DrawShadow_chr+1, X : STA ($90), Y
        INY

        LDA.w Pool_Ancilla_DrawShadow_properties+1, X
        AND.b #$CF : ORA.b $04 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$03 : LSR #2 : TAY
        
        LDA.b #$00 : ORA.b $75 : STA ($92), Y
        
        PLY
    
    .only_one_oam_entry
    
    RTS
}

; ==============================================================================

; $04790A-$047919 LOCAL JUMP LOCATION
Ancilla_AllocateOam_B_or_E:
{
    LDY.w $0FB3 : BNE .sort_sprites
        JSL.l OAM_AllocateFromRegionB
        
        BRA .return
    
    .sort_sprites
    
    JSL.l OAM_AllocateFromRegionE
    
    .return
    
    RTS
}

; ==============================================================================

; $04791A-$0479B9 LONG JUMP LOCATION
Tagalong_GetCloseToPlayer:
{
    PHB : PHK : PLB
    
    .need_to_get_closer_to_player
    
        LDX.w $02D3
        
        LDA.w $1A00, X : STA.w $0C03
        LDA.w $1A14, X : STA.w $0C17
        
        LDA.w $1A28, X : STA.w $0C0D
        LDA.w $1A3C, X : STA.w $0C21
        
        LDX.b #$09
        LDA.b #$18
        
        JSR.w Ancilla_ProjectSpeedTowardsPlayer
        
        LDA.b $00 : STA.w $0C22, X
        LDA.b $01 : STA.w $0C2C, X
        
        JSR.w Ancilla_MoveVert
        
        PHX
        
        JSR.w Ancilla_MoveHoriz
        
        PLX
        
        LDA.w $0BFA, X : STA.b $00
        LDA.w $0C0E, X : STA.b $01
        
        LDA.w $0C04, X : STA.b $02
        LDA.w $0C18, X : STA.b $03
        
        REP #$20
        
        LDA.b $00 : SEC : SBC.b $20 : BPL .object_below_player
            EOR.w #$FFFF : INC A
        
        .object_below_player
        
        CMP.w #$0002 : BCS .too_far_away_from_player
            LDA.b $02 : SEC : SBC.b $22 : BPL .object_right_of_player
                EOR.w #$FFFF : INC A
            
            .object_right_of_player
            
            CMP.w #$0002 : BCC .close_enough_to_player
        
        .too_far_away_from_player
        
        SEP #$20
        
        ; Try up to 0x12 times to get closer to the player but give up after
        ; that.
        INC.w $02D3 : LDX.w $02D3 : CPX.b #$12 : BEQ .exhausted_attempts
            LDA.b $00 : STA.w $1A00, X
            LDA.b $01 : STA.w $1A14, X
            
            LDA.b $02 : STA.w $1A28, X
            LDA.b $03 : STA.w $1A3C, X
            
            LDY.b $EE
        
        LDA Ancilla_PrepOamCoord_priority, Y
        
        LSR #2 : ORA.b #$01 : STA.w $1A64, X
    BRL .need_to_get_closer_to_player
    
    .exhausted_attempts
    .close_enough_to_player
    
    SEP #$20
    
    PLB
    
    RTL
}

; ==============================================================================

; $0479BA-$0479FF LOCAL JUMP LOCATION
Ancilla_CustomAllocateOam:
{
    PHA : PHX
    
    REP #$20
    
    TYA : AND.w #$00FF : CLC : ADC.b $90
    
    LDX.w $0FB3 : BEQ .unsorted_sprites
        ; Is it in the second half of the oam buffer?
        CMP.w #$0900 : BCS .upper_region
            CMP.w #$08E0 : BCC .reset_unneeded
                LDA.w #$0820
                
                BRA .set_oam_pointer
                
        .upper_region
        
        CMP.w #$09D0 : BCC .reset_unneeded
            LDA.w #$0940
            
            BRA .set_oam_pointer
        
    .unsorted_sprites
    
    CMP.w #$0990 : BCC .reset_unneeded
        LDA.w #$0820
        
        .set_oam_pointer
        
        STA.b $90
        
        SEC : SBC.w #$0800 : LSR #2 : CLC : ADC.w #$0A20 : STA.b $92
        
        LDY.b #$00
    
    .reset_unneeded
    
    SEP #$20
    
    PLX : PLA
    
    RTS
}

; ==============================================================================

; $047A00-$047A2C LOCAL JUMP LOCATION
HitStars_UpdateOamBufferPosition:
{
    PHA : PHX
    
    REP #$20
    
    TYA : AND.w #$00FF : CLC : ADC.b $90
    
    LDX.w $0FB3 : BNE .sort_sprites
        CMP.w #$09D0 : BCC .dont_reset_oam_pointer
            LDA.w #$0820 : STA.b $90
            
            SEC : SBC.w #$0800 : LSR #2 : CLC : ADC.w #$0A20 : STA.b $92
            
            LDY.b #$00

        .dont_reset_oam_pointer
    .sort_sprites
    
    SEP #$20
    
    PLX : PLA
    
    RTS
}

; ==============================================================================

; $047A2D-$047ADC LOCAL JUMP LOCATION
Hookshot_IsCollisionCheckFutile:
{
    ; Only the Hookshot calls this.
    PHX : PHY
    
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    LDA.b $1B : BNE .indoors
        REP #$20
        
        LDA.w $0C72, X : AND.w #$0002 : BNE .moving_horizontally
            LDX.w $0700
            LDA.b $00 : SEC : SBC.l OverworldTransitionPositionY, X
            CMP.w #$0004 : BCC .off_screen
                CMP.w $0716 : BCS .off_screen
                    BRA .not_at_screen_edge
        
        .moving_horizontally
        
        LDX.w $0700
        LDA.b $02 : SEC : SBC.l OverworldTransitionPositionX, X
        CMP.w #$0006 : BCC .off_screen
            CMP.w $0716 : BCC .not_at_screen_edge
        
        .off_screen
        
        SEP #$20
        
        PLY : PLX
        
        SEC
        
        RTS
        
        .not_at_screen_edge
        
        SEP #$20
        
        PLY : PLX
        
        CLC
        
        RTS
    
    .indoors
    
    REP #$20
    
    LDA.w $0C72, X : AND.w #$0002 : BNE .moving_indoors_horizontally
        LDA.b $00 : AND.w #$01FF : CMP.w #$0004 : BCC .off_screen
            CMP.w #$01E8 : BCS .off_screen
                BRA .check_indoor_same_screen_y
    
    .moving_indoors_horizontally
    
    LDA.b $02 : AND.w #$01FF : CMP.w #$0004 : BCC .off_screen
        CMP.w #$01F0 : BCS .off_screen
            BRA .check_indoor_same_screen_x
            
    .check_indoor_same_screen_y
            
    SEP #$20
            
    PLY : PLX
            
    LDA.b $01 : AND.b #$02 : STA.b $01
    LDA.b $21 : AND.b #$02 : CMP $01 : BEQ .same_screen_as_player
        SEC
            
        RTS
            
        .check_indoor_same_screen_x
                
        SEP #$20
                
        PLY : PLX
                
        LDA.b $03 : AND.b #$02 : STA.b $03
        LDA.b $23 : AND.b #$02 : CMP $03 : BEQ .same_screen_as_player
            SEC
                    
            RTS
            
    .same_screen_as_player
            
    CLC
            
    RTS
}

; ==============================================================================

; $047ADD-$047B22 LOCAL JUMP LOCATION
Ancilla_GetRadialProjection:
{
    PHX
    
    TAX
    
    LDA.l Pool_Ancilla_GetRadialProjection_multiplier_y, X
    STA.w SNES.MultiplicandA

    LDA.b $08 : STA.w SNES.MultiplierB
    
    ; Sign of the projected distance.
    LDA.l Pool_Ancilla_GetRadialProjection_meta_sign_y, X
    STA.b $02
    STZ.b $03
    
    ; Get Y projected distance?
    LDA.w SNES.RemainderResultLow : ASL A
    LDA.w SNES.RemainderResultHigh : ADC.b #$00 : STA.b $00
                                                  STZ.b $01
    
    LDA.l Pool_Ancilla_GetRadialProjection_multiplier_x, X
    STA.w SNES.MultiplicandA

    LDA.b $08 : STA.w SNES.MultiplierB
    
    ; Sign of the projected distance.
    LDA.l Pool_Ancilla_GetRadialProjection_meta_sign_x, X : STA.b $06
                                                            STZ.b $07
    
    ; Get X projected distance?
    LDA.w SNES.RemainderResultLow : ASL A
    LDA.w SNES.RemainderResultHigh : ADC.b #$00 : STA.b $04
                                                  STZ.b $05
    
    PLX
    
    RTS
}

; ==============================================================================

; $047B23-$047B2A LONG JUMP LOCATION
Ancilla_GetRadialProjectionLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_GetRadialProjection
    
    PLB
    
    RTL
}

; ==============================================================================

; $047B2B-$047B43 LOCAL JUMP LOCATION
Ancilla_AllocateOam:
{
    LDY.w $0FB3 : BNE .sorted_sprites
        JSL.l OAM_AllocateFromRegionA
        
        RTS
        
    .sorted_sprites
    
    LDY.w $0C7C, X : BNE .on_bg1
        JSL.l OAM_AllocateFromRegionD
        
        RTS
    
    .on_bg1
    
    JSL.l OAM_AllocateFromRegionF
    
    RTS
}

; ==============================================================================

; $047B44-$047BA5 LONG BRANCH LOCATION
BeamHit_Unknown:
{
    JSR.w BeamHit_GetCoords
    
    LDY.b #$00
    
    .next_oam_entry
    
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b $0B : BPL .override_size
            LDA ($92), Y : AND.b #$02
        
        .override_size
        
        STA ($92), Y
        
        PLY
        
        LDX.b #$00
        
        LDA ($90), Y : SEC : SBC.b $07 : BPL .positive_x
            DEX
        
        .positive_x
        
        CLC : ADC.b $02 : STA.b $04
        TXA : ADC.b $03 : STA.b $05
        
        JSR.w BeamHit_Get_Top_X_Bit : BCC .no_x_adjustment_needed
            PHY
            
            TYA : LSR #2 : TAY
            
            LDA ($92), Y : ORA.b #$01 : STA ($92), Y
            
            PLY
        
        .no_x_adjustment_needed
        
        LDX.b #$00
        INY
        
        LDA ($90), Y : SEC : SBC.b $06 : BPL .positive_y
            DEX
        
        .positive_y
        
        CLC : ADC.b $00 : STA.b $09
        
        TXA : ADC.b $01 : STA.b $0A
        
        JSR.w BeamHit_CheckOffscreen_Y : BCC .onscreen_y
            LDA.b #$F0 : STA ($90), Y
        
        .onscreen_y
        
        INY #3
    DEC.b $08 : BPL .next_oam_entry
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================

; $047BA6-$047BC8 LOCAL JUMP LOCATION
BeamHit_GetCoords:
{
    STY.b $0B
    STA.b $08
    
    LDA.w $0BFA, X : STA.b $00 : SEC : SBC.b $E8 : STA.b $06
    LDA.w $0C0E, X : STA.b $01
    LDA.w $0C04, X : STA.b $02 : SEC : SBC.b $E2 : STA.b $07
    LDA.w $0C18, X : STA.b $03
    
    RTS
}

; ==============================================================================

; $047BC9-$047BD5 LOCAL JUMP LOCATION
BeamHit_Get_Top_X_Bit:
{
    REP #$20
    
    LDA.b $04 : SEC : SBC.b $E2 : CMP.w #$0100
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $047BD6-$047BEC LOCAL JUMP LOCATION
BeamHit_CheckOffscreen_Y:
{
    REP #$20
    
    LDA.b $09 : PHA : CLC : ADC.w #$0010 : STA.b $09
    SEC : SBC.b $E8 : CMP.w #$0100
    
    PLA : STA.b $09
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $047BED-$047EE9
Pool_QuakeSpell_DrawFirstGroundBolts:
{
    ; $047BED 0x03
    .group00_a
    db $00, $F0, $00
    
    ; $047BF0 0x03
    .group00_b
    db $00, $F0, $01
    
    ; $047BF3 0x03
    .group01_a
    db $00, $F0, $02
    
    ; $047BF6 0x03
    .group01_b
    db $00, $F0, $03
    
    ; $047BF9 0x03
    .group02_a
    db $00, $F0, $43
    
    ; $047BFC 0x03
    .group02_b
    db $00, $F0, $42
    
    ; $047BFF 0x03
    .group03_a
    db $00, $F0, $41
    
    ; $047C02 0x03
    .group03_b
    db $00, $F0, $40
    
    ; $047C05 0x06
    .group04_a
    db $00, $F0, $40
    db $0E, $F8, $84
    
    ; $047C0B 0x06
    .group04_b
    db $1D, $F8, $44
    db $0D, $F9, $84
    
    ; $047C11 0x06
    .group05_a
    db $1F, $F9, $44
    db $2F, $FC, $84
    
    ; $047C17 0x09
    .group05_b
    db $31, $F5, $06
    db $3F, $FB, $44
    db $2F, $FC, $84
    
    ; $047C20 0x12
    .group06_a
    db $24, $EF, $08
    db $31, $F5, $06
    db $3F, $FB, $44
    db $4E, $04, $08
    
    ; $047C2C 0x12
    .group06_b
    db $16, $E1, $08
    db $24, $EF, $08
    db $4E, $04, $08
    db $5D, $14, $08
    
    ; $047C38 0x15
    .group07_a
    db $07, $D2, $08
    db $17, $D3, $48
    db $16, $E1, $08
    db $5D, $14, $08
    db $5D, $24, $48
     
    ; $047C47 0x18
    .group07_b
    db $F9, $C3, $08
    db $25, $C5, $48
    db $07, $D2, $08
    db $17, $D3, $48
    db $5D, $24, $48
    db $5D, $34, $08
    
    ; $047C59 0x18
    .group08_a
    db $EA, $B5, $08
    db $2F, $B6, $01
    db $F8, $C3, $08
    db $24, $C4, $48
    db $5D, $34, $08
    db $6C, $43, $08
    
    ; $047C6B 0x18
    .group08_b
    db $DB, $A6, $08
    db $EA, $B5, $08
    db $2F, $B6, $01
    db $3B, $C2, $81
    db $6C, $43, $08
    db $79, $50, $08
    
    ; $047C7D 0x15
    .group09_a
    db $D4, $98, $C9
    db $DB, $A6, $08
    db $49, $B6, $48
    db $3B, $C2, $81
    db $79, $50, $08
    
    ; $047C8C 0x12
    .group09_b
    db $D4, $88, $09
    db $D4, $98, $C9
    db $57, $A7, $48
    db $49, $B6, $48
    
    ; $047C98 0x09
    .group0A_a
    db $D4, $88, $09
    db $66, $98, $48
    db $57, $A7, $48
    
    ; $047CA1 0x06
    .group0A_b
    db $66, $98, $48
    db $57, $A7, $48
    
    ; $047CA7 0x06
    .group0B_a
    db $70, $8C, $48
    db $66, $98, $48
    
    ; $047CAD 0x03
    .group0B_b
    db $70, $8C, $48
    
    ; $047CB0 0x03
    .group0C_a
    db $F3, $F0, $00
    
    ; $047CB3 0x03
    .group0C_b
    db $F3, $F0, $01
    
    ; $047CB6 0x03
    .group0D_a
    db $F3, $F0, $02
    
    ; $047CB9 0x03
    .group0D_b
    db $F3, $F0, $03
    
    ; $047CBC 0x03
    .group0E_a
    db $F5, $F0, $43
    
    ; $047CBF 0x03
    .group0E_b
    db $F5, $F0, $42
    
    ; $047CC2 0x03
    .group0F_a
    db $F5, $F0, $41
    
    ; $047CC5 0x06
    .group0F_b
    db $F5, $F0, $40
    db $E8, $F6, $04

    ; $047CCB 0x09
    .group10_a
    db $DA, $EE, $08
    db $E8, $F6, $04
    db $D8, $F9, $C4

    ; $047CD4 0x12
    .group10_b
    db $D3, $DF, $C9
    db $DA, $EE, $08
    db $C7, $F9, $04
    db $D8, $F9, $C4

    ; $047CE0 0x12
    .group11_a
    db $D0, $D3, $07
    db $D3, $DF, $C9
    db $C7, $F9, $04
    db $B9, $02, $48

    ; $047CEC 0x09
    .group11_b
    db $D0, $D3, $06
    db $B9, $02, $48
    db $BA, $12, $08

    ; $047CF5 0x09
    .group12_a
    db $D0, $D3, $05
    db $BA, $12, $08
    db $C8, $21, $08

    ; $047CFE 0x09
    .group12_b
    db $D0, $D3, $07
    db $CA, $22, $08
    db $CA, $31, $88

    ; $047D07 0x09
    .group13_a
    db $D0, $D3, $06
    db $CA, $31, $88
    db $BB, $40, $88

    ; $047D10 0x09
    .group13_b
    db $D0, $D3, $07
    db $BB, $40, $88
    db $AB, $49, $C4

    ; $047D19 0x09
    .group14_a
    db $D0, $D3, $05
    db $9B, $49, $04
    db $AB, $49, $C4

    ; $047D22 0x12
    .group14_b
    db $C4, $CB, $08
    db $D0, $D3, $06
    db $9B, $49, $04
    db $8C, $4D, $C4

    ; $047D2E 0x12
    .group15_a
    db $B5, $BD, $08
    db $C4, $CB, $08
    db $80, $4C, $04
    db $8C, $4D, $C4

    ; $047D3A 0x09
    .group15_b
    db $A6, $AE, $08
    db $B5, $BD, $08
    db $80, $4C, $04

    ; $047D43 0x06
    .group16_a
    db $97, $9F, $08
    db $A6, $AE, $08

    ; $047D49 0x06
    .group16_b
    db $88, $91, $08
    db $97, $9F, $08

    ; $047D4F 0x03
    .group17_a    
    db $88, $91, $08

    ; $047D52 0x03
    .group17_b
    db $00, $FB, $0A

    ; $047D55 0x03
    .group18_a
    db $00, $FB, $0B

    ; $047D58 0x03
    .group18_b
    db $02, $FD, $0C

    ; $047D5B 0x03
    .group19_a
    db $01, $FD, $0D

    ; $047D5E 0x3 
    .group19_b
    db $00, $FD, $8D

    ; $047D61 0x03
    .group1A_a
    db $01, $FD, $8C

    ; $047D64 0x03
    .group1A_b
    db $01, $FD, $8B

    ; $04D67 0x06
    .group1B_a
    db $01, $FD, $8A
    db $FA, $0C, $89

    ; $047D6D 0x06
    .group1B_b
    db $FA, $0C, $89
    db $F6, $1C, $C9

    ; $047D73 0x06
    .group1C_a
    db $F6, $1C, $49
    db $F8, $2C, $89

    ; $047D79 0x06
    .group1C_a
    db $F8, $2C, $89
    db $F6, $38, $02

    ; $047D7F 0x09
    .group1D_a
    db $F6, $38, $02
    db $E9, $46, $48
    db $05, $46, $08

    ; $047D88 0x12
    .group1D_b
    db $E9, $46, $48
    db $05, $46, $08
    db $DA, $55, $48
    db $13, $55, $08

    ; $047D94 0x12
    .group1E_a
    db $DA, $55, $48
    db $13, $55, $08
    db $CC, $63, $48
    db $21, $65, $08

    ; $047DA0 0x12
    .group1E_b
    db $CC, $63, $48
    db $21, $65, $08
    db $BE, $71, $48
    db $2F, $73, $08

    ; $047DAC 0x06
    .group1F_a
    db $BE, $71, $48
    db $2F, $73, $08

    ; $047DB2 0x03
    .group1F_b
    .group20_a
    db $A0, $70, $20

    ; $047DB5 0x03
    .group20_b
    db $A0, $70, $21

    ; $047DB8 0x03
    .group21_a
    db $A0, $70, $66

    ; $047DBB 0x03
    .group21_b
    db $A0, $70, $22

    ; $047DBE 0x03
    .group22_a
    db $A0, $70, $23

    ; $047DC1 0x03
    .group22_b
    db $A0, $70, $63

    ; $047DC4 0x03
    .group23_a
    db $A0, $70, $62

    ; $047DC7 0x03
    .group23_b
    db $A0, $70, $26

    ; $047DCA 0x06
    .group24_a
    db $A0, $70, $27
    db $AA, $7C, $28

    ; $047DD0 0x06
    .group24_b
    db $AA, $7C, $28
    db $B8, $8B, $28

    ; $047DD6 0x06
    .group25_a
    db $B8, $8B, $28
    db $C5, $9A, $A1

    ; $047DDC 0x06
    .group25_b
    db $C5, $9A, $A1
    db $D4, $8C, $68

    ; $047DE2 0x06
    .group26_a
    db $D4, $8C, $68
    db $E3, $7E, $68

    ; $047DE8 0x03
    .group26_b
    db $E3, $7E, $68

    ; $047DEB 0x03
    .group27_a
    db $ED, $7D, $C5

    ; $047DEE 0x03
    .group27_b
    db $90, $60, $2A

    ; $047DF1 0x03 
    .group28_a
    db $90, $60, $2B

    ; $047DF4 0x03
    .group28_b
    db $90, $60, $2C

    ; $047DF7 0x03
    .group29_a
    db $90, $60, $2D

    ; $047DFA 0x06
    .group29_b
    db $89, $52, $29
    db $90, $60, $2A

    ; $047E00 0x06
    .group2A_a
    db $85, $42, $E9
    db $89, $52, $29

    ; $047E06 0x06
    .group2A_b
    db $87, $32, $29
    db $85, $42, $E9

    ; $047E0C 0x09
    .group2B_a
    db $7E, $22, $28
    db $8D, $22, $68
    db $87, $32, $29

    ; $047E15 0x12
    .group2B_b
    db $96, $12, $A9
    db $6F, $13, $28
    db $7E, $22, $28
    db $8D, $22, $68

    ; $047E21 0x12
    .group2C_a
    db $9C, $02, $68
    db $66, $04, $E9
    db $96, $12, $A9
    db $6F, $13, $28

    ; $047E2D 0x12
    .group2C_b
    db $A5, $F2, $A9
    db $5F, $F5, $28
    db $9C, $02, $68
    db $66, $04, $E9

    ; $047E39 0x03
    .group2D_a
    db $60, $70, $60

    ; $047E3C 0x03
    .group2D_b
    db $60, $70, $61

    ; $047E3F 0x03
    .group2E_a
    db $60, $70, $26

    ; $047E42 0x03
    .group2E_b
    db $60, $70, $62

    ; $047E45 0x03
    .group2F_a
    db $60, $70, $63

    ; $047E48 0x03
    .group2F_b
    db $60, $70, $23

    ; $047E4B 0x03
    .group30_a
    db $60, $70, $22

    ; $047E4E 0x03
    .group30_b
    db $60, $70, $66

    ; $047E51 0x06
    .group31_a
    db $55, $6F, $E8
    db $60, $70, $67

    ; $047E57 0x06
    .group31_b
    db $46, $68, $24
    db $55, $6F, $E8

    ; $047E5D 0x06
    .group32_a
    db $46, $68, $24
    db $36, $6C, $E4

    ; $04E637 0x09
    .group32_b
    db $28, $64, $28
    db $26, $6B, $24
    db $36, $6C, $E4

    ; $047E6C 0x12
    .group33_a
    db $19, $55, $28
    db $28, $64, $28
    db $26, $6B, $24
    db $16, $6E, $E4

    ; $047E78 0x12
    .group33_b
    db $0B, $46, $28
    db $19, $55, $28
    db $07, $6C, $24
    db $16, $6E, $E4

    ; $047E84 0x06
    .group34_a
    db $0B, $46, $28
    db $07, $6C, $24

    ; $047E8A 0x03
    .group34_b
    db $70, $70, $2A

    ; $047E8D 0x03
    .group35_a
    db $70, $70, $2B

    ; $047E90 0x03
    .group35_b
    db $70, $70, $2C

    ; $047E93 0x03
    .group36_a
    db $70, $70, $2D

    ; $047E96 0x06
    .group36_b
    db $70, $70, $2A
    db $6C, $7D, $29

    ; $047E9C 0x06
    .group37_a
    db $6C, $7D, $29
    db $72, $8C, $28

    ; $047EA2 0x06
    .group37_b
    db $72, $8C, $28
    db $7C, $9C, $29

    ; $047EA8 0x06
    .group38_a
    db $7C, $9C, $29
    db $7B, $AC, $E9

    ; $047EAE 0x09
    .group38_b
    db $7B, $AC, $E9
    db $75, $B6, $E4
    db $84, $BB, $28

    ; $047EB7 0x12
    .group39_a
    db $75, $B6, $E4
    db $84, $BB, $28
    db $67, $BD, $68
    db $92, $CA, $28

    ; $047EC3 0x12
    .group39_a
    db $67, $BD, $68
    db $92, $CA, $28
    db $5F, $CC, $69
    db $9A, $D9, $29

    ; $047ECF 0x12
    .group3A_a
    db $5F, $CC, $69
    db $9A, $D9, $29
    db $60, $DC, $E9
    db $9A, $E8, $E9

    ; $047EDB 0x06
    .group3A_b
    db $60, $DC, $E9
    db $9A, $E8, $E9

    ; $047EE1 0x09
    .group3B_a
    db $85, $F2, $29
    db $8D, $F2, $2E
    db $31, $F4, $28

    ; TODO: Figure out the size of this one or see if it is actually used.
    ; $047EEA 0x??
    .group3B_b
}

; $047EEA-$047F69 DATA
QuakeSpell_DrawFirstGroundBolts_pointers:
{
    dw QuakeDrawGFX_group00_a, QuakeDrawGFX_group00_b
    dw QuakeDrawGFX_group01_a, QuakeDrawGFX_group01_b
    dw QuakeDrawGFX_group02_a, QuakeDrawGFX_group02_b
    dw QuakeDrawGFX_group03_a, QuakeDrawGFX_group03_b
    dw QuakeDrawGFX_group04_a, QuakeDrawGFX_group04_b
    dw QuakeDrawGFX_group05_a, QuakeDrawGFX_group05_b
    dw QuakeDrawGFX_group06_a, QuakeDrawGFX_group06_b
    dw QuakeDrawGFX_group07_a, QuakeDrawGFX_group07_b
    dw QuakeDrawGFX_group08_a, QuakeDrawGFX_group08_b
    dw QuakeDrawGFX_group09_a, QuakeDrawGFX_group09_b
    dw QuakeDrawGFX_group0A_a, QuakeDrawGFX_group0A_b
    dw QuakeDrawGFX_group0B_a, QuakeDrawGFX_group0B_b
    dw QuakeDrawGFX_group0C_a, QuakeDrawGFX_group0C_b
    dw QuakeDrawGFX_group0D_a, QuakeDrawGFX_group0D_b
    dw QuakeDrawGFX_group0E_a, QuakeDrawGFX_group0E_b
    dw QuakeDrawGFX_group0F_a, QuakeDrawGFX_group0F_b
    dw QuakeDrawGFX_group10_a, QuakeDrawGFX_group10_b
    dw QuakeDrawGFX_group11_a, QuakeDrawGFX_group11_b
    dw QuakeDrawGFX_group12_a, QuakeDrawGFX_group12_b
    dw QuakeDrawGFX_group13_a, QuakeDrawGFX_group13_b
    dw QuakeDrawGFX_group14_a, QuakeDrawGFX_group14_b
    dw QuakeDrawGFX_group15_a, QuakeDrawGFX_group15_b
    dw QuakeDrawGFX_group16_a, QuakeDrawGFX_group16_b
    dw QuakeDrawGFX_group17_a, QuakeDrawGFX_group17_b
    dw QuakeDrawGFX_group18_a, QuakeDrawGFX_group18_b
    dw QuakeDrawGFX_group19_a, QuakeDrawGFX_group19_b
    dw QuakeDrawGFX_group1A_a, QuakeDrawGFX_group1A_b
    dw QuakeDrawGFX_group1B_a, QuakeDrawGFX_group1B_b
    dw QuakeDrawGFX_group1C_a, QuakeDrawGFX_group1C_b
    dw QuakeDrawGFX_group1D_a, QuakeDrawGFX_group1D_b
    dw QuakeDrawGFX_group1E_a, QuakeDrawGFX_group1E_b
    dw QuakeDrawGFX_group1F_a, QuakeDrawGFX_group1F_b
}
    
; $047F6A-$047FD9 DATA
Pool_QuakeSpell_DrawGroundBolts:
{
    .pointers
    dw QuakeDrawGFX_group20_a, QuakeDrawGFX_group20_b
    dw QuakeDrawGFX_group21_a, QuakeDrawGFX_group21_b
    dw QuakeDrawGFX_group22_a, QuakeDrawGFX_group22_b
    dw QuakeDrawGFX_group23_a, QuakeDrawGFX_group23_b
    dw QuakeDrawGFX_group24_a, QuakeDrawGFX_group24_b
    dw QuakeDrawGFX_group25_a, QuakeDrawGFX_group25_b
    dw QuakeDrawGFX_group26_a, QuakeDrawGFX_group26_b
    dw QuakeDrawGFX_group27_a, QuakeDrawGFX_group27_b
    dw QuakeDrawGFX_group28_a, QuakeDrawGFX_group28_b
    dw QuakeDrawGFX_group29_a, QuakeDrawGFX_group29_b
    dw QuakeDrawGFX_group2A_a, QuakeDrawGFX_group2A_b
    dw QuakeDrawGFX_group2B_a, QuakeDrawGFX_group2B_b
    dw QuakeDrawGFX_group2C_a, QuakeDrawGFX_group2C_b
    dw QuakeDrawGFX_group2D_a, QuakeDrawGFX_group2D_b
    dw QuakeDrawGFX_group2E_a, QuakeDrawGFX_group2E_b
    dw QuakeDrawGFX_group2F_a, QuakeDrawGFX_group2F_b
    dw QuakeDrawGFX_group30_a, QuakeDrawGFX_group30_b
    dw QuakeDrawGFX_group31_a, QuakeDrawGFX_group31_b
    dw QuakeDrawGFX_group32_a, QuakeDrawGFX_group32_b
    dw QuakeDrawGFX_group33_a, QuakeDrawGFX_group33_b
    dw QuakeDrawGFX_group34_a, QuakeDrawGFX_group34_b
    dw QuakeDrawGFX_group35_a, QuakeDrawGFX_group35_b
    dw QuakeDrawGFX_group36_a, QuakeDrawGFX_group36_b
    dw QuakeDrawGFX_group37_a, QuakeDrawGFX_group37_b
    dw QuakeDrawGFX_group38_a, QuakeDrawGFX_group38_b
    dw QuakeDrawGFX_group39_a, QuakeDrawGFX_group39_b
    dw QuakeDrawGFX_group3A_a, QuakeDrawGFX_group3A_b
    dw QuakeDrawGFX_group3B_a, QuakeDrawGFX_group3B_b
}

; ==============================================================================

; $047FDA-$047FFF NULL
NULL_08FFDA:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $098000
