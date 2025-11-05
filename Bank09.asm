; ==============================================================================

; Bank 09
; $040000-$047FFF
org $088000

; Ancilla code
; Tagalong code
; Sprite code
; Garnish code
; Overlord code

; ==============================================================================

; $048000-$049E8F
incsrc "ancilla_init.asm"

; $049E90-$04AC6A
incsrc "sprites/tagalong.asm"

; ==============================================================================

; $04AC6B-$04ACF2 LONG JUMP LOCATION
Ancilla_TerminateSelectInteractives:
{
    PHB : PHK : PLB
    
    LDX.b #$05
    
    .nextObject
    
        ; Check for 3D crystal.
        LDA.w $0C4A, X : CMP.b #$3E : BNE .not3DCrystal
            TXY
            
            BRA .checkIfCarryingObject
        
        .not3DCrystal
        
        ; Checks if any cane of somaria blocks are in play?
        LDA.w $0C4A, X : CMP.b #$2C : BNE .checkIfCarryingObject
            STZ.w $0646
            
            LDA.b $48 : AND.b #$80 : BEQ .checkIfCarryingObject
                ; Reset Link's grabby status.
                STZ.b $48
                STZ.b $5E
        
        .checkIfCarryingObject
        
        LDA.w $0308 : BPL .notCarryingAnything
            TXA : INC : CMP.w $02EC : BEQ .spareObject
                BRA .terminateObject
                    
        .notCarryingAnything
        
        TXA : INC : CMP.w $02EC : BNE .terminateObject
            STZ.w $02EC
        
        .terminateObject
        
        STZ.w $0C4A, X
        
        .spareObject
    DEX : BPL .nextObject
    
    LDA.w $037A : AND.b #$10 : BEQ .theta
        STZ.b $46
        STZ.w $037A
    
    .theta
    
    ; Reset flute playing interval timer.
    STZ.w $03F0
    
    ; Reset tagalong detatchment timer.
    STZ.w $02F2
    
    ; Only place this is written to. Never read.
    STZ.w $02F3
    STZ.w $035F
    STZ.w $03FC
    
    STZ.w $037B
    STZ.w $03FD
    STZ.w $0360
    
    LDA.b $5D : CMP.b #$13 : BNE .notUsingHookshot
        LDA.b #$00 : STA.b $5D
        
        LDA.b $3A   : AND.b #$BF : STA.b $3A
        LDA.b $50   : AND.b #$FE : STA.b $50
        LDA.w $037A : AND.b #$FB : STA.w $037A
        
        STZ.w $037E
    
    .notUsingHookshot
    
    PLB
    
    RTL
}

; ==============================================================================

; $04ACF3-$04AD05 LONG JUMP LOCATION
Tagalong_Disable:
{
    ; Get rid of the tagalong following Link if it's Kiki the Monkey or the
    ; creepy Middle Aged dude with the sign.
    LDA.l $7EF3CC : CMP.b #$0A : BEQ .kiki
        CMP.b #$09 : BNE .spare_tagalong
    
    .kiki
    
    LDA.b #$00 : STA.l $7EF3CC
    
    .spare_tagalong
    
    RTL
}

; ==============================================================================

; $04AD06-$04AD1A LOCAL JUMP LOCATION
Ancilla_SetCoords:
{
    LDA.b $00 : STA.w $0BFA, X
    LDA.b $01 : STA.w $0C0E, X
    
    LDA.b $02 : STA.w $0C04, X
    LDA.b $03 : STA.w $0C18, X
    
    RTS
}

; ==============================================================================

; $04AD1B-$04AD2F LOCAL JUMP LOCATION
Ancilla_GetCoords:
{
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    RTS
}

; ==============================================================================

; Note: Could this routine's placement indicate that dividing the blocks
; came later as a designed feature?
; $04AD30-$04AD66 LONG JUMP LOCATION
AddSomarianBlockDivide:
{
    PHB : PHK : PLB
    
    LDA.b #$2E : STA.w $0C4A, X
    
    PHX
    
    TAX
    LDA.l AncillaObjectAllocation, X
    
    PLX
    
    STA.w $0C90, X
    
    LDA.b #$03 : STA.w $03B1, X
    
    STZ.w $0C54, X
    STZ.w $0C5E, X
    STZ.w $039F, X
    STZ.w $03A4, X
    STZ.w $03EA, X
    STZ.w $0280, X
    
    STZ.w $0646
    
    JSL.l Sound_SfxPanObjectCoords : ORA.b #$01 : STA.w $012F
    
    PLB
    
    RTL
}

; ==============================================================================

; $04AD67-$04AD6B DATA
GiveRupeeGift_gift_amounts:
{
    db 1, 5, 20, 100, 50
}

; This routine handles rupee gift.
; $04AD6C-$04ADC6 LONG JUMP LOCATION
GiveRupeeGift:
{
    PHB : PHK : PLB
    
    LDA.w $0C5E, X : CMP.b #$34 : BEQ .lowSize
                     CMP.b #$35 : BEQ .lowSize
                     CMP.b #$36 : BEQ .lowSize
        CMP.b #$40 : BEQ .mediumSize
        CMP.b #$41 : BEQ .mediumSize
            CMP.b #$46 : BEQ .largeSize
                CMP.b #$47 : BNE .notRupeeGift
            
            .largeSize
            
            LDY.b #$02
            
            ; Give 20 rupees for this gift (redundant, I think). Perhaps it uses
            ; a different graphic.
            CMP.b #$47 : BEQ .setGiftIndex
                LDA.b #$2C : STA.b $00
                
                ; Gives me 300 rupees.
                LDA.b #$01 : STA.b $01
                
                BRA .giveRupees
            
        .mediumSize
        
        SEC : SBC.b #$40 : CLC : ADC.b #$03 : TAY
        
        BRA .setGiftIndex
    
    .lowSize
    
    ; Give 1, 5, or 20 rupees.
    SEC : SBC.b #$34 : TAY
    
    .setGiftIndex
    
    LDA .gift_amounts, Y : STA.b $00
                           STZ.b $01
    
    .giveRupees
    
    REP #$20
    
    ; Add this amount to my rupee collection.
    LDA.l $7EF360 : CLC : ADC.b $00 : STA.l $7EF360
    
    SEP #$20
    
    SEC
    
    PLB
    
    RTL
    
    .notRupeeGift
    
    CLC
    
    PLB
    
    RTL
}

; ==============================================================================

; $04ADC7-$04ADF0 LONG JUMP LOCATION
Ancilla_TerminateSparkleObjects:
{
    PHX
    
    LDX.b #$04
    
    .next_slot
    
        LDA.w $0C4A, X : CMP.b #$2A : BEQ .terminate_object
                         CMP.b #$2B : BEQ .terminate_object
                         CMP.b #$30 : BEQ .terminate_object
                         CMP.b #$31 : BEQ .terminate_object
                         CMP.b #$18 : BEQ .terminate_object
                         CMP.b #$19 : BEQ .terminate_object
            CMP.b #$0C : BNE .dont_terminate
        
        .terminate_object
        
        STZ.w $0C4A, X
        
        .dont_terminate
    DEX : BPL .next_slot
    
    PLX
    
    RTL
}

; ==============================================================================

; $04ADF1-04AE3D
incsrc "ancilla_motive_dash_dust.asm"

; ==============================================================================

; $04AE3E-$04AE3F DATA
NULL_09AE3E:
{
    db $FF, $FF
}

; ==============================================================================

; $04AE40-$04AE63 LONG JUMP LOCATION
Sprite_SpawnSuperficialBombBlast:
{
    ; Create a blast that looks like a green bomb going off? (Somaria
    ; platform uses during creation? Magic powder tossed on green altar?)
    LDA.b #$4A 
    JSL.l Sprite_SpawnDynamically : BMI Sprite_SetSpawnedCoords_spawn_failed
        LDA.b #$06 : STA.w $0DD0, Y
        
        LDA.b #$1F : STA.w $0E00, Y
        
        LDA.b #$03 : STA.w $0DB0, Y
                     STA.w $0E40, Y
        INC        : STA.w $0F50, Y
        
        LDA.b #$15 : JSL.l Sound_SetSfx2PanLong
}
        
; $04AE64-$04AE7D LONG JUMP LOCATION
Sprite_SetSpawnedCoords:
{
    LDA.b $00 : STA.w $0D10, Y
    LDA.b $01 : STA.w $0D30, Y
        
    LDA.b $02 : STA.w $0D00, Y
    LDA.b $03 : STA.w $0D20, Y
        
    LDA.b $04 : STA.w $0F70, Y
    
    ; $04AE7D ALTERNATE ENTRY POINT
    .spawn_failed
    
    RTL
}

; ==============================================================================

; Used for the chicken swarm (has to be, I'm sure of it)
; Update: This seems to be used by the contradiction bat.
; $04AE7E-$04AE9F LONG JUMP LOCATION
Sprite_SpawnDummyDeathAnimation:
{
    LDA.b #$0B
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$06 : STA.w $0DD0, Y
        
        LDA.b #$0F : STA.w $0DF0, Y
        
        LDA.b #$14
        JSL.l Sound_SetSfx2PanLong
        
        ; Ensure the spawned death sprite is visible by giving it high priority.
        LDA.b #$02 : STA.w $0F20, Y
    
    .spawn_failed
    
    RTL
}

; ==============================================================================

; $04AEA0-$04AEA7 DATA
Pool_Sprite_SpawnMadBatterBolts:
{
    ; $04AEA0
    .x_speeds
    db -8, -4,  4,  8
    
    ; $04AEA4
    .initial_cycling_states
    db 0, 17, 34, 51
}

; Note: Only used by the mad batter (naturally).
; $04AEA8-$04AEB3 LONG JUMP LOCATION
Sprite_SpawnMadBatterBolts:
{
    JSL.l .attempt_bold_spawn
    JSL.l .attempt_bold_spawn
    JSL.l .attempt_bold_spawn

    ; Bleeds into the next function.
}
    
; $04AEB4-$04AF31 LONG JUMP LOCATION
Sprite_SpawnMadBatterBolts_attempt_bold_spawn:
{
    LDA.b #$3A : JSL.l Sprite_SpawnDynamically : BMI .spawnFailed
        LDA.b #$01
        JSL.l Sound_SetSfx3PanLong
        
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01 :       ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$0C : PHP : SEC : SBC.w $0F70, X : STA.w $0D00, Y
        LDA.b $03 :       SBC.b #$00 : PLP :       ADC.b #$00     : STA.w $0D20, Y
        
        LDA.b #$00 : STA.w $0F70, Y
        
        LDA.b #$18 : STA.w $0D40, Y
                     STA.w $0EB0, Y
                     STA.w $0BA0, Y
        
        LDA.b #$80 : STA.w $0E40, Y
        
        LDA.b #$03 : STA.w $0E60, Y
        AND.b #$03 : STA.w $0F50, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
        
        LDA.b #$02 : STA.w $0DC0, Y
        
        PHX
        
        LDA.w $0ED0, X : TAX
        LDA.l Pool_Sprite_SpawnMadBatterBolt_x_speeds, X : STA.w $0D50, Y
        
        LDA.l Pool_Sprite_SpawnMadBatterBolt_initial_cycling_states, X
        STA.w $0E80, Y
        
        LDA.b #$02 : STA.w $0F20, Y
        
        PLX
        
        INC.w $0ED0, X
    
    .spawnFailed
    
    RTL
}

; ==============================================================================

; $04AF32-$04AF60 LONG JUMP LOCATION
Sprite_VerifyAllOnScreenDefeated:
{
    PHX
    
    LDX.b #$0F ; Going to cycle through all sprite entries.
    
    .next_sprite
    
        LDA.w $0DD0, X : BEQ .dead
            ; Check if the sprite is always considered dead for these purposes
            ; (some sprites have this property set at load and some
            ; dynamically).
            LDA.w $0F60, X : AND.b #$40 : BNE .dead
                ; In these cases Dead apparently means offscreen.
                LDA.w $0D10, X : CMP.b $E2
                LDA.w $0D30, X : SBC.b $E3 : BNE .dead
                    ; In these cases Dead apparently means offscreen.
                    LDA.w $0D00, X : CMP.b $E8
                    LDA.w $0D20, X : SBC.b $E9 : BNE .dead
                        PLX
                        
                        ; Not all enemies are dead, return false.
                        CLC
                        
                        RTL
        
        .dead
    DEX : BPL .next_sprite
    
    BRA Sprite_CheckIfAllDefeated_check_overlords
}
    
; $04AF61-$04AF88 LONG JUMP LOCATION
Sprite_CheckIfAllDefeated:
{
    PHX
    
    ; We're going to cycle through all the sprites in the room.
    LDX.b #$0F
    
    .next_sprite_2
    
        ; Is the sprite alive?
        LDA.w $0DD0, X : BEQ .dead_2
            ; It's alive, but not in this room... i.e. good as dead.
            LDA.w $0F60, X : AND.b #$40 : BNE .dead_2
                .failure
                
                PLX
                
                ; Not all the enemies are dead, it's a failure.
                CLC
                
                RTL
        
        .dead_2
    DEX : BPL .next_sprite_2
    
    .check_overlords
    
    LDX.b #$07
    
    .next_overlord
    
        ; Now check to see if there are any overlords "alive".
        LDA.w $0B00, X : CMP.b #$14 : BEQ .failure
                         CMP.b #$18 : BEQ .failure
    ; Move on to the next value.
    DEX : BPL .next_overlord
    
    PLX
    
    ; We've succeeded (so do something?).
    SEC
    
    RTL
}

; ==============================================================================

; $04AF89-$04AFD5 LONG JUMP LOCATION
Sprite_ReinitWarpVortex:
{
    PHB : PHK : PLB
    
    LDX.b #$0F
    
    .nextSprite
    
        LDA.w $0DD0, X : BEQ .dead
            ; Trying to kill the warp vortex.
            LDA.w $0E20, X : CMP.b #$6C : BNE .notWarpVortex
                ; Kill the warp vortex!
                STZ.w $0DD0, X
            
            .notWarpVortex
        .dead
    DEX : BPL .nextSprite
    
    LDA.b #$6C
    JSL.l Sprite_SpawnDynamically : BPL .spawnSucceeded
        LDY.b #$00
    
    .spawnSucceeded
    
    LDA.l $001ABF : STA.w $0D10, Y
    LDA.l $001ACF : STA.w $0D30, Y
    
    LDA.l $001ADF : CLC : ADC.b #$08 : STA.w $0D00, Y
    LDA.l $001AEF :       ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$00 : STA.w $0F20, Y
    INC        : STA.w $0BA0, Y
    
    PLB
    
    RTL
}

; ==============================================================================

; $04AFD6-$04B01F LONG JUMP LOCATION
InitSpriteSlots:
{
    PHB: PHK : PLB
    
    LDX.b #$0F
    
    .nextSprite
    
        LDA.w $0DD0, X : BEQ .deadSprite
            LDY.w $0E20, X
            
            ; Carrying something.
            CMP.b #$0A : BNE .notCarrying
                ; Carrying a bush or rock.
                CPY.b #$EC : BEQ .ignoreSprite
                    ; Or carrying a fish.
                    CPY.b #$D2 : BEQ .ignoreSprite
                        ; If it's not one of those two things you're carrying,
                        ; you lose it.
                        STZ.w $0309 : STZ.w $0308
                        
                        BRA .killSprite
            
            .notCarrying
            
            ; Is it a warp vortex?
            CPY.b #$6C : BEQ .ignoreSprite
                ; Ignore the sprite if the area that it was loaded in is the
                ; same as the area we're in.
                LDA.w $0C9A, X : CMP.w $040A : BEQ .ignoreSprite
                    .killSprite
                    
                    STZ.w $0DD0, X
            
            .ignoreSprite
        .deadSprite
    DEX : BPL .nextSprite
    
    LDX.b #$07
    
    .nextOverlord
    
        ; There's no overlord loaded in that slot to begin with.
        LDA.w $0B00, X : BEQ .noOverlord
            ; Ignore the overlord because it matches the area we're already in.
            LDA.w $0CCA, X : CMP.w $040A : BEQ .ignoreOverlord
                STZ.w $0B00, X

            .ignoreOverlord
        .noOverlord
        
    DEX : BPL .nextOverlord
    
    PLB
    
    RTL
}

; ==============================================================================

; $04B020-$04B713
incsrc "garnish.asm"

; $04B714-$04C022
incsrc "overlord.asm"

; ==============================================================================

; \tcrf (verified)
; The inn keeper's data is unused because he's not a snitch, naturally.
; Use Pro Action Replay Code 09C04834 to switch the young snitch girl's
; soldier spawn data with that of the innkeeper's.
; $04C023-$04C02E DATA
Pool_SpawnCrazyVillageSoldier:
{
    ; $04C023
    .x_offsets_low
    db $20, $40, $E0
    
    ; $04C026
    .x_offsets_high
    db $01, $03, $02
    
    ; $04C029
    .y_offsets_low
    db $00, $B0, $60
    
    ; $04C02C
    .y_offsets_high
    db $01, $03, $01
}

; Spawn the crazy nutjob that shows up when you run into the scared ladies
; outside their houses.
; $04C02F-$04C087 LONG JUMP LOCATION
SpawnCrazyVillageSoldier:
{
    PHB : PHK : PLB
    
    LDA.b #$45
    LDY.b #$00
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        PHX
        
        LDA.w $0E20, X

        LDX.b #$00
        
        ; Is it one of the ladies outside of their houses?
        CMP.b #$3D : BEQ .place_soldier
            INX
            
            ; Innkeeper sprite... he was originally planned as someone that
            ; snitches on you?
            CMP.b #$35 : BEQ .place_soldier
                INX
        
        .place_soldier
        
        LDA.w .x_offsets_low,  X :                     STA.w $0D10, Y
        LDA.w .x_offsets_high, X : CLC : ADC.w $0FBD : STA.w $0D30, Y
        
        LDA.w .y_offsets_low,  X :                     STA.w $0D00, Y
        LDA.w .y_offsets_high, X : CLC : ADC.w $0FBF : STA.w $0D20, Y
        
        PLX
        
        LDA.b #$00 : STA.w $0F20, Y
        
        LDA.b #$04 : STA.w $0E50, Y
        
        LDA.b #$80 : STA.w $0CAA, Y
        
        LDA.b #$90 : STA.w $0BE0, Y
        
        LDA.b #$0B : STA.w $0F50, Y
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $04C088-$04C08B DATA
Pool_Overlord_CheckInRangeStatus:
{
    ; $04C088
    .offsets_low
    db $30, $C0
    
    ; $04C08A
    .offsets_high
    db $01, $FF
}

; $04C08C-$04C08C LOCAL JUMP LOCATION
Overlord_CheckInRangeStatus_easy_out:
{
    RTS
}

; I think this... might terminate overlord sprites on the overworld.
; Such as the boulder spawner on the LW death mountain?
; $04C08D-$04C113 LOCAL JUMP LOCATION
Overlord_CheckInRangeStatus:
{
    LDA.b $1B : BNE .easy_out
        LDA.b $1A : AND.b #$01 : STA.b $01
                                 STA.b $02
                                 TAY
        
        ; OPTIMIZE: This would be so much faster in 16-bit code, even if
        ; this code isn't used very often, if at all.
        LDA.b $E2 : CLC : ADC .offsets_low, Y
        ROL.b $00 : CMP.w $0B08, X : PHP

        LDA.b $E3 : LSR.b $00 : ADC .offsets_high, Y 
        PLP : SBC.w $0B10, X : STA.b $00
        
        ; We want the upper byte of the absolute difference between the
        ; offset from the scroll value to the overlord. Since that offset
        ; is negative on odd frames, we only negate the result on those frames.
        LSR.b $01 : BCC .sign_normalize_dx
            EOR.b #$80 : STA.b $00
        
        .sign_normalize_dx
        
        LDA.b $00 : BMI .terminate
            LDA.b $E8 : CLC : ADC .offsets_low, Y
            ROL.b $00 : CMP.w $0B18, X : PHP

            LDA.b $E9 : LSR.b $00 : ADC .offsets_high, Y
            PLP : SBC.w $0B20, X : STA.b $00
            
            ; See previous comment regarding sign normalization.
            LSR.b $02 : BCC .sign_normalize_dy
                EOR.b #$80 : STA.b $00
            
            .sign_normalize_dy
            
            LDA.b $00 : BPL .in_range_xy
            
        .terminate
        
        ; Terminate the overlord.
        STZ.w $0B00, X
        
        TXA : ASL : TAY
        
        REP #$20
        
        LDA.w $0B48, Y : STA.b $00
        CMP.w #$FFFF : PHP
        
        LSR #3 : CLC : ADC.w #$EF80 : STA.b $01
        
        ; Why it wouldn't participate, I don't really know.
        PLP : SEP #$20 : BCS .not_participating_in_death_buffer
            LDA.b #$7F : STA.b $03
            
            LDA.b $00 : AND.b #$07 : TAY
            LDA.b [$01] : AND.w SpriteDeathMasks, Y : STA.b [$01]
        
        .not_participating_in_death_buffer
        .in_range_xy
        
        RTS
}

; ==============================================================================

; Moves current room's data into reserve (gets ready for transition)
; $04C114-$04C174 LONG JUMP LOCATION
Dungeon_ResetSprites:
{
    PHB : PHK : PLB
    
    ; Transfer a lot of sprite data to other places.
    JSR.w Dungeon_CacheTransSprites
    
    ; Make Link drop whatever he's carrying.
    STZ.w $0309
    STZ.w $0308
    
    ; Zeroes out and disables a number of memory locations.
    JSL.l Sprite_DisableAll
    
    REP #$20
    
    LDA.w #$FFFF : STA.w $0FBA
                   STA.w $0FB8
    
    LDX.b #$00
    
    LDA.w $048E
    
    .updateRecentRoomsList
    
        CMP.w $0B80, X : BEQ .alreadyInList
    INX : INX : CPX.b #$07 : BCC .updateRecentRoomsList
    
    LDA.w $0B86 : STA.b $00
    LDA.w $0B84 : STA.w $0B86
    LDA.w $0B82 : STA.w $0B84
    LDA.w $0B80 : STA.w $0B82
    LDA.w $048E : STA.w $0B80
    
    REP #$10
    
    LDA.b $00 : CMP.w #$FFFF : BEQ .nullEntry
        ; TODO: Complete refresh?
        ; Tells the game that next time we enter that room the sprites need
        ; a complete fresh (e.g. if any have gotten killed).
        ASL : TAX
        LDA.w #$0000 : STA.l $7FDF80, X
    
    .nullEntry
    .alreadyInList
    
    SEP #$30
    
    JSR.w Dungeon_LoadSprites
    
    PLB
    
    RTL
}

; ==============================================================================

; $04C175-$04C175 BRANCH LOCATION
Dungeon_CacheTransSprites_easy_out:
{
    RTS
}
    
; $04C176-$04C22E LOCAL JUMP LOCATION
Dungeon_CacheTransSprites:
{
    ; Don't do this routine if we're outside.
    LDA.b $1B : BEQ .easy_out
    
        ; Use $0FFA as a place holder.
        STA.w $0FFA
        
        ; We're going to cycle through all 16 sprites.
        LDX.b #$0F
        
        .nextSprite
        
            ; Transfer sprite data to an extended region.
            STZ.w $1D00, X
            
            LDA.w $0E20, X : STA.w $1D10, X
            LDA.w $0D10, X : STA.w $1D20, X
            LDA.w $0DC0, X : STA.w $1D60, X
            LDA.w $0D30, X : STA.w $1D30, X
            LDA.w $0D00, X : STA.w $1D40, X
            LDA.w $0D20, X : STA.w $1D50, X
            
            LDA.w $0F00, X : BNE .inactiveSprite
                LDA.w $0DD0, X : CMP.b #$04 : BEQ .inactiveSprite
                    ; Frozen:
                    CMP.b #$0A : BEQ .inactiveSprite
                        STA.w $1D00, X
                        
                        LDA.w $0D90, X : STA.w $1D70, X
                        LDA.w $0EB0, X : STA.w $1D80, X
                        LDA.w $0F50, X : STA.w $1D90, X
                        LDA.w $0B89, X : STA.w $1DA0, X
                        LDA.w $0DE0, X : STA.w $1DB0, X
                        LDA.w $0E40, X : STA.w $1DC0, X
                        LDA.w $0F20, X : STA.w $1DD0, X
                        LDA.w $0D80, X : STA.w $1DE0, X
                        LDA.w $0E60, X : STA.w $1DF0, X
                        
                        LDA.w $0DA0, X : STA.l $7FFA5C, X
                        LDA.w $0DB0, X : STA.l $7FFA6C, X
                        LDA.w $0E90, X : STA.l $7FFA7C, X
                        LDA.w $0E80, X : STA.l $7FFA8C, X
                        LDA.w $0F70, X : STA.l $7FFA9C, X
                        LDA.w $0DF0, X : STA.l $7FFAAC, X
                        
                        LDA.l $7FF9C2, X : STA.l $7FFACC, X
                        LDA.w $0BA0, X   : STA.l $7FFADC, X
            
            .inactiveSprite
            
            DEX : BMI .return
        JMP.w .nextSprite
        
        .return
        
        RTS
}

; =============================================================

; $04C22F-$04C28F LONG JUMP LOCATION
Sprite_DisableAll:
{
    LDX.b #$0F
    
    .nextSprite
    
        ; Sprite is deactivated already, ignore it.
        LDA.w $0DD0, X : BEQ .ignoreSprite
            ; Are we indoors?
            LDA.b $1B : BNE .indoors
                ; Is it a warp vortex? (created my mirror).
                LDA.w $0E20, X : CMP.b #$6C : BEQ .ignoreSprite

            .indoors

            ; Kill the sprite momentarily.
            STZ.w $0DD0, X

        .ignoreSprite
    DEX : BPL .nextSprite
    
    ; Going to cycle through the special effects.
    LDX.b #$09

    .deactivateEffects

        ; Deactivate all special effects.
        STZ.w $0C4A, X
    DEX : BPL .deactivateEffects
    
    STZ.w $02EC
    
    STZ.w $0B6A : STZ.w $0B9B : STZ.w $0B88 : STZ.w $0B99
    
    STZ.w $0FB4
    
    STZ.w $0B9E : STZ.w $0CF4
    
    STZ.w $0FF9 : STZ.w $0FF8 : STZ.w $0FFB
    STZ.w $0FFC : STZ.w $0FFD : STZ.w $0FC6
    
    STZ.w $03FC
    
    LDX.b #$07

    .deactivateOverlords

        STZ.w $0B00, X
    DEX : BPL .deactivateOverlords
    
    LDX.b #$1D

    .disableSpecialAnimations

        ; Disable all the special animations currently ongoing.
        LDA.b #$00 : STA.l $7FF800, X
    DEX : BPL .disableSpecialAnimations
    
    RTL
}

; ==============================================================================

; Dungeon sprite loader
; $04C290-$04C2D4 LOCAL JUMP LOCATION
Dungeon_LoadSprites:
{
    ; Vars
    !dataPtr      = $00
    !spriteSlot   = $02
    !spriteSlotHi = $03 ; (high byte)
    !dataOffset   = $04
    
    REP #$30
    
    ; (update: Black Magic ended up hooking $04C16E)
    ; RoomData_SpritePointers is the pointer table for the sprite data in
    ; each room.
    LDA.w $048E : ASL : TAY
    LDA.w RoomData_SpritePointers, Y : STA.b !dataPtr
    
    ; Load the room index again. Divide by 8. why... I'm not sure.
    LDA.w $048E : LSR #3
    
    SEP #$30
    
    ; Used to offset the high byte of pixel addresses in rooms. (X coord).
    AND.b #$FE : STA.w $0FB1
    
    ; Load the room index yet again.
    ; Used to offset the high byte of pixel addresses in rooms. (Y coord).
    LDA.w $048E : AND.b #$0F : ASL : STA.w $0FB0
    
    ; Not sure what this does yet...
    LDA.b (!dataPtr) : STA.w $0FB3
    
    LDA.b #$01 : STA.b !dataOffset
    
    STZ.b !spriteSlot
    STZ.b !spriteSlotHi
    
    .nextSprite
    
        LDY.b !dataOffset
        LDA.b (!dataPtr), Y : CMP.b #$FF : BEQ .endOfSpriteList
            JSR.w Dungeon_LoadSprite
            
            ; Increment the slot we're saving to. ($0E20, $0E21, ...).
            INC.b !spriteSlot
            
            INC.b !dataOffset
            INC.b !dataOffset
            INC.b !dataOffset
    
    BRA .nextSprite
    
    .endOfSpriteList
    
    RTS
} 

; ==============================================================================

; $04C2D5-$04C2F4 DATA
Dungeon_ManuallySetSpriteDeathFlag_flags:
{
    dw $0001, $0002, $0004, $0008, $0010, $0020, $0040, $0080
    dw $0100, $0200, $0400, $0800, $1000, $2000, $4000, $8000
}

; $04C2F5-$04C326 LONG JUMP LOCATION
Dungeon_ManuallySetSpriteDeathFlag:
{
    PHB : PHK : PLB
    
    LDA.b $1B : BEQ .return
        LDA.w $0CAA, X : LSR : BCS .return
            LDA.w $0BC0, X : BMI .return
                STA.b $02
                STZ.b $03
                
                REP #$30
                
                PHX
                
                LDA.w $048E : ASL : TAX
                
                LDA.b $02 : ASL : TAY
                
                ; Keep this guy from respawning.
                LDA.l $7FDF80, X : ORA.w .flags, Y : STA.l $7FDF80, X
                
                PLX
                
                SEP #$30
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; Loads sprite and overloard types and info into room's memory.
; $04C327-$04C3E7 LOCAL JUMP LOCATION
Dungeon_LoadSprite:
{
    ; Vars
    !dataPtr    = $00
    !spriteSlot = $02

    INY : INY
    
    ; Examine the sprite type first... Is it a key?
    LDA.b (!dataPtr), Y : TAX
    CPX.b #$E4 : BNE .notKey
        DEY : DEY
        
        ; Check the key's Y coordinate.
        LDA.b (!dataPtr), Y : INY : INY : CMP.b #$FE : BEQ .isKey
            ; If it's 16 pixels higher than that, drop a big key.
            CMP.b #$FD : BNE .notOverlord
                JSR.w Dungeon_LoadSprite_isKey
                
                ; Set $0CBA to 0x02 (means it's a big key).
                INC.w $0CBA, X 
                
                RTS
        
        ; $04C345 ALTERNATE ENTRY POINT
        .isKey
        
        DEC.b !spriteSlot
        LDX.b !spriteSlot
        LDA.b #$01 : STA.w $0CBA, X
        
        RTS
    
    .notKey
    
    DEY
    
    ; Examine its X coordinate, and go back to the sprite type position.
    ; If X coord < 0xE0, Load the overlord's information into memory.
    LDA.b (!dataPtr), Y : INY : CMP.b #$E0 : BCC .notOverlord
        JSR.w Dungeon_LoadOverlord
        
        ; Since this isn't a normal sprite, we don't want to throw off their
        ; loading mechanism, because the normal sprites are loaded in a linear
        ; order into $0E20, X, while these overlords go to $0B00, X.
        DEC.b !spriteSlot
        
        RTS
        
    ; Normal sprite, not an overlord.
    .notOverlord
    
    ; Checking for sprites with a special specific property.
    LDA.l SpriteData_Deflection, X : AND.b #$01 : BNE .notSpawnedYet
        REP #$30
        
        PHY
        PHX
        
        ; Load the room index, multiply by 2.
        LDA.w $048E : ASL : TAX
        
        ; !spriteSlot is the current slot in $0E20, X to load into.
        LDA.b !spriteSlot : ASL : TAY
        
        ; Apparently information on whether stuff has been loaded is stored for
        ; each room?
        LDA.l $7FDF80, X : AND.w Dungeon_ManuallySetSpriteDeathFlag_flags, Y
        
        PLX
        PLY
        
        CMP.w #$0000 : SEP #$30 : BEQ .notSpawnedYet
            ; It spawned, we're done, genius.
            RTS

    .notSpawnedYet

    ; Give X the loading slot number.
    LDX.b !spriteSlot

    DEY : DEY
    
    ; Send the sprite an initialization message.
    LDA #$08 : STA.w $0DD0, X
    
    ; Examine the Y coordinate for the sprite. (Buffer at $0FB5).
    LDA.b (!dataPtr), Y : STA.w $0FB5 
    
    ; Use the MSB of the Y coordinate to determine the floor the sprite is on.
    AND.b #$80 : ASL : ROL : STA.w $0F20, X
    
    ; Load the sprite's Y coordinate, multiply by 16 to give it's in-game Y
    ; coordinate. (In terms of pixels).
    LDA.b ($00), Y : ASL #4 : STA.w $0D00, X
    
    LDA.w $0FB1 : ADC.b #$00 : STA.w $0D20, X
    
    ; Next load the X coordinate, and convert to Pixel coordinates.
    INY
    LDA.b (!dataPtr), Y : STA.w $0FB6
    ASL #4              : STA.w $0D10, X
    
    ; And set the upper byte of the X coordinate, of course.
    LDA.w $0FB0 : ADC.b #$00 : STA.w $0D30, X
    
    ; Looking at the sprite type now.
    INY
    
    ; Set the sprite type.
    LDA.b (!dataPtr), Y : STA.w $0E20, X
    
    ; Set the subtype to zero.
    STZ.w $0E30, X
    
    ; Examine bits 5 and 6 of the Y (block) coordinate.
    LDA.w $0FB5 : AND.b #$60 : LSR : LSR : STA.w $0FB5
    
    ; Provides the lower three bits of the subtype. But since all three bits
    ; cannot be set for us to be here, it follows only certain subtypes will
    ; arise.
    LDA.w $0FB6 : LSR #5
    
    ; Determine a subtype, if necessary.
    ORA.w $0FB5 : STA.w $0E30, X
    
    ; Store slot information into this array.
    LDA.b !spriteSlot : STA.w $0BC0, X
    
    ; Zero out the sprite drop variable (what it drops when killed).
    STZ.w $0CBA, X
    
    RTS
}

; ==============================================================================

; Loads overlord information into a room's memory.
; $04C3E8-$04C44D LOCAL JUMP LOCATION
Dungeon_LoadOverlord:
{
    ; Vars:
    !dataPtr = $00

    LDX.b #$07 ; We're going to cycle through the 8 overlord slots.
    
    .nextSlot
    
        ; Are there any overlords in this slot?
        LDA.w $0B00, X : BEQ .emptySlot
    DEX : BPL .nextSlot
    
    RTS
    
    .emptySlot
    
    ; Fill the overlord slot into $0B00, X
    LDA.b (!dataPtr), Y : NOP : STA.w $0B00, X
    
    ; Now examine the Y coordinate.
    ; Store it's floor status here.
    DEY : DEY
    LDA.b (!dataPtr), Y : AND.b #$80 : ASL : ROL : STA.w $0B40, X
    
    ; Convert the Y coordinate to a pixel address, and store it here.
    LDA.b (!dataPtr), Y : ASL #4 : STA.w $0B18, X
    
    LDA.w $0FB1 : ADC.b #$00 : STA.w $0B20, X
    
    INY
    
    ; Now convert the X coordinates to pixels.
    LDA.b (!dataPtr), Y : ASL #4 : STA.w $0B08, X
    
    LDA.w $0FB0 : ADC.b #$00 : STA.w $0B10, X
    
    JSR.w Overworld_LoadOverlord_misc
    
    ; Load the overlord type and check for various special cases.
    LDA.w $0B00, X : CMP.b #$0A : BEQ .needsTimer
                     CMP.b #$0B : BEQ .needsTimer
        CMP.b #$03 : BNE .noAdjustment
            LDA.b #$FF : STA.w $0B30, X
            
            LDA.w $0B08, X : SEC : SBC.b #$08 : STA.w $0B08, X
        
        .noAdjustment
        
        RTS
    
    .needsTimer
    
    ; Set up a timer.
    LDA.b #$A0 : STA.w $0B30, X
    
    RTS
}

; ==============================================================================

; $04C44E-$04C451 LONG JUMP LOCATION
Sprite_ResetAll:
{
    JSL.l Sprite_DisableAll

    ; Bleeds into the next function.
}
    
; $04C452-$04C498 LONG JUMP LOCATION
Sprite_ResetBuffers:
{
    STZ.w $0FDD : STZ.w $0FDC
    STZ.w $0FFD : STZ.w $02F0
    STZ.w $0FC6 : STZ.w $0B6A
    STZ.w $0FB3
    
    ; Branch if Link has the super bomb tagalong following him.
    LDA.l $7EF3CC : CMP.b #$0D : BEQ .superBomb
        LDA.b #$FE : STA.w $04B4
    
    .superBomb
    
    REP #$10
    
    LDX.w #$0FFF
    LDA.b #$00
    
    .clearLocationBuffer
    
        STA.l $7FDF80, X : DEX
    BPL .clearLocationBuffer
    
    LDX.w #$01FF
    
    .clearDeathBuffer
    
        STA.l $7FEF80, X : DEX
    BPL .clearDeathBuffer
    
    SEP #$10
    
    LDY.b #$07
    LDA.b #$FF
    
    .clearRecentRoomsList
    
        STA.w $0B80, Y : DEY
    BPL .clearRecentRoomsList
    
    RTL
}

; ==============================================================================

; $04C499-$04C49C LONG JUMP LOCATION
Sprite_OverworldReloadAll:
{
    JSL.l Sprite_DisableAll
    JSL.l Sprite_ResetBuffers

    ; Bleeds into the next function.
}

; $04C49D-$04C4AB LONG JUMP LOCATION
Sprite_LoadAll_Overworld:
{
    PHB : PHK : PLB
    
    JSR.w LoadOverworldSprites
    JSR.w Sprite_ActivateAllProxima
    
    PLB
    
    RTL
}

; ==============================================================================

; ZSCREAM: ZS modifies part of this function.
; Loads overworld sprite information into memory ($7FDF80, X is one such array).
; $04C4AC-$04C55D LOCAL JUMP LOCATION
LoadOverworldSprites:
{
    ; Calculate lower bounds for X coordinates in this map.
    LDA.w $040A : AND.b #$07 : ASL : STZ.w $0FBC
                                     STA.w $0FBD
    
    ; Calculate lower bounds for Y coordinates in this map.
    LDA.w $040A : AND.b #$3F : LSR : LSR : AND.b #$0E : STA.w $0FBF
    
    STZ.w $0FBE
    
    ; OPTIMIZE: Why not just LDY.w $040A? or later skip loading the $040A again?
    ; ZSCREAM: ZS makes some code changes here.
    ; $04C4C7
    LDA.w $040A : TAY
    LDX.w OverworldScreenSizeForLoading, Y : STX.w $0FB9
                                             STZ.w $0FB8 
                                             STX.w $0FBB
                                             STZ.w $0FBA
    
    REP #$30
    
    ; What Overworld area are we in?
    LDA.w $040A : ASL : TAY
    
    SEP #$20
    
    ; Load the game state variable.
    LDA.l $7EF3C5 : CMP.b #$03 : BEQ .secondPart
        CMP.b #$02 : BEQ .firstPart
            ; Load the "Beginning" sprites for the Overworld.
            LDA.w Overworld_SpritePointers_state_0+0, Y : STA.b $00
            LDA.w Overworld_SpritePointers_state_0+1, Y
            
            BRA .loadData
        
    .secondPart
    
    ; Load the "Second part" sprites for the Overworld.
    LDA.w Overworld_SpritePointers_state_2+0, Y : STA.b $00
    LDA.w Overworld_SpritePointers_state_2+1, Y
    
    BRA .loadData
    
    .firstPart
    
    ; Load the "First Part" sprites for the Overworld.
    LDA.w Overworld_SpritePointers_state_1+0, Y : STA.b $00
    LDA.w Overworld_SpritePointers_state_1+1, Y
    
    .loadData
    
    STA.b $01
    
    LDY.w #$0000
    
    .nextSprite
    
            ; Read off the sprite information until we reach a #$FF byte.
            LDA.b ($00), Y : CMP.b #$FF : BEQ .stopLoading
                ; Is this a Falling Rocks sprite?
                INY : INY
                LDA.b ($00), Y : DEY : DEY : CMP.b #$F4 : BNE .notFallingRocks
                    ; Set a "falling rocks" flag for the area and skip past this
                    ; sprite.
                    INC.w $0FFD
                    
                    INY #3
        BRA .nextSprite
        
        .notFallingRocks ; Anything other than falling rocks.
        
        LDA.b ($00), Y : PHA : LSR #4 : ASL : ASL : STA.b $02
        
        INY
        LDA.b ($00), Y : LSR #4 : CLC : ADC.b $02 : STA.b $06
        
        PLA : ASL #4 : STA.b $07
        
        ; All this is to tell us where to put the sprite in the sprite map.
        LDA.b ($00), Y : AND.b #$0F : ORA.b $07 : STA.b $05
        
        ; The sprite / overlord index as stored as one plus it's normal index.
        ; Don't ask me why yet. Load them into what I guess you might call a
        ; sprite map.
        INY
        LDA.b ($00), Y
        
        LDX.b $05
        INC : STA.l $7FDF80, X
        
        ; Move on to the next sprite / overlord.
        INY
        
        BRA .nextSprite
    .stopLoading
    
    SEP #$10
    
    RTS
}

; ==============================================================================
    
; $04C55E-$04C58E LOCAL JUMP LOCATION
Sprite_ActivateAllProxima:
{
    LDA.b $E2 : PHA
    LDA.b $E3 : PHA
    
    LDA.w $069F : PHA
    
    LDA.b #$FF : STA.w $069F
    
    LDY.b #$15
    
    .loop
    
        PHY
        
        JSR.w Sprite_ActivateWhenProximal_Horizontal
        
        PLY
        
        ; Move the scanning location right by 16 pixels each loop.
        LDA.b $E2 : CLC : ADC.b #$10 : STA.b $E2
        LDA.b $E3       : ADC.b #$00 : STA.b $E3
    DEY : BPL .loop
    
    PLA : STA.w $069F
    
    PLA : STA.b $E3
    PLA : STA.b $E2
    
    RTS
}

; ==============================================================================
    
; $04C58F-$04C5B6 LONG JUMP LOCATION
Sprite_RangeBasedActivation:
{
    PHB : PHK : PLB
    
    LDA.b $11 : BEQ .alpha
        JSR.w Sprite_ActivateWhenProximal_Horizontal
        JSR.w Sprite_ActivateWhenProximal_Vertical
        
        PLB
        
        RTL
    
    .alpha
    
    LDA.w $0FB7 : AND.b #$01 : BNE .beta
        JSR.w Sprite_ActivateWhenProximal_Horizontal
    
    .beta
    
    LDA.w $0FB7 : AND.b #$01 : BEQ .gamma
        JSR.w Sprite_ActivateWhenProximal_Vertical
    
    .gamma
    
    INC.w $0FB7
    
    PLB
    
    RTL
}

; ==============================================================================

; $04C5B7-$04C5BA DATA
Pool_Sprite_ActivateWhenProximal_Horizontal:
{
    ; $04C5B7
    .offset_low
    db $10, $F0
    
    ; $04C5B9
    .offset_high
    db $01, $FF
}
   
; $04C5BB-$04C5F5 LOCAL JUMP LOCATION
Sprite_ActivateWhenProximal_Horizontal:
{
    LDY.b #$00
    
    ; Related to bombs? (i.e. no clue).
    LDA.w $069F : BEQ .return
        BPL .beta
            INY
    
        .beta
    
        ; If $069F is negative, this subtracts 0x0010, otherwise it adds 0x0110.
        LDA.b $E2
        CLC : ADC.w Pool_Sprite_ActivateWhenProximal_Horizontal_offset_low, Y
        STA.b $0E

        LDA.b $E3
        ADC.w Pool_Sprite_ActivateWhenProximal_Horizontal_offset_high, Y
        STA.b $0F
        
        ; $0C[0x2] = BG2VOFS - 0x30
        LDA.b $E8 : SEC : SBC.b #$30 : STA.b $0C
        LDA.b $E9 :       SBC.b #$00 : STA.b $0D
        
        LDX.b #$15
        
        .vertical_loop
        
            JSR.w Overworld_ProximityMotivatedLoad
            
            REP #$20
            
            ; Each loop, move 16 pixels down on the map.
            LDA.b $0C : CLC : ADC.w #$0010 : STA.b $0C
            
            SEP #$20
        DEX : BPL .vertical_loop
    
    .return
    
    RTS
}

; ==============================================================================

; $04C5F6-$04C5F9 DATA
Pool_Sprite_ActivateWhenProximal_Vertical:
{
    ; $04C5F6
    .offset_low
    db $10, $F0
    
    ; $04C5F8
    .offset_high
    db $01, $FF
}

; $04C5FA-$04C634 LOCAL JUMP LOCATION
Sprite_ActivateWhenProximal_Vertical:
{
    LDY.b #$00
    
    LDA.w $069E : BEQ .return
        BPL .beta
            INY
    
        .beta
    
        LDA.b $E8
        CLC : ADC.w Pool_Sprite_ActivateWhenProximal_Vertical_offset_low, Y
        STA.b $0C

        LDA.b $E9
        ADC.w Pool_Sprite_ActivateWhenProximal_Vertical_offset_high, Y
        STA.b $0D
        
        LDA.b $E2 : SEC : SBC.b #$30 : STA.b $0E
        LDA.b $E3 :       SBC.b #$00 : STA.b $0F
        
        LDX.b #$15
        
        .horizontalLoop
        
            JSR.w Overworld_ProximityMotivatedLoad
            
            REP #$20
            
            ; Each loop, move 16 pixels to the right on the map.
            LDA.b $0E : CLC : ADC.w #$0010 : STA.b $0E
            
            SEP #$20
        DEX : BPL .horizontalLoop
    
    .return
    
    RTS
}

; ==============================================================================

; ZSCREAM: This table was made obsolete by ZS and this space is used for other
; ZS ASM functions.
; These are map sizes. This is for controlling the boundaries used by sprites
; to check if they should be loaded.
; NOTE: Area 0x0A and 0x0F are incorrect. This does not appear to break
; anything in game and changing them to the correct value of 0x02 does not
; break anything either.
; $04 = Large area
; $02 = Small area
; $04C635-$04C6F4 DATA
OverworldScreenSizeForLoading:
{
    ; LW
    db $04, $04, $02, $04, $04, $04, $04, $02
    db $04, $04, $04, $04, $04, $04, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $02, $02, $04, $04, $02
    db $04, $04, $02, $02, $02, $04, $04, $02

    ; DW
    db $04, $04, $02, $04, $04, $04, $04, $02
    db $04, $04, $04, $04, $04, $04, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $02, $02, $04, $04, $02
    db $04, $04, $02, $02, $02, $04, $04, $02

    ; SW
    db $04, $04, $02, $04, $04, $04, $04, $02
    db $04, $04, $04, $04, $04, $04, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $04, $04, $02, $04, $04, $02, $04, $04
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $04, $04, $02, $02, $02, $04, $04, $02
    db $04, $04, $02, $02, $02, $04, $04, $02
}

; $04C6F5-$04C730 LOCAL JUMP LOCATION
Overworld_ProximityMotivatedLoad:
{
    REP #$20
    
    LDA.b $0E : SEC : SBC.w $0FBC : CMP.w $0FB8 : BCS .outOfRange
        XBA : STA.b $00
        
        LDA.b $0C : SEC : SBC.w $0FBE : CMP.w $0FBA : BCS .outOfRange
            SEP #$20
            
            XBA : ASL : ASL : ORA.b $00 : STA.b $01
            
            ; $00 = $0C & 0xF0
            LDA.b $0C : AND.b #$F0 : STA.b $00
            
            ; $00 |= ($0E >> 4)
            LDA.b $0E : LSR #4 : ORA.b $00 : STA.b $00
            
            PHX
            
            JSR.w Overworld_LoadProximaSpriteIfAlive
            
            PLX
            
    .outOfRange
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $04C731-$04C738 DATA
Overworld_AliveStatusBits:
{
    db $80, $40, $20, $10, $08, $04, $02, $01
}

; $04C739-$04C76F LOCAL JUMP LOCATION
Overworld_LoadProximaSpriteIfAlive:
{
    REP #$20
    LDA.b $00 : CLC : ADC.w #$DF80 : STA.b $05
    SEP #$20
    
    ; $05 = $7FDF80 + offset.
    LDA.b #$7F : STA.b $07
    
    LDA.b [$05] : BEQ .alpha
        REP #$20
        LDA.b $00 : LSR #3 : CLC : ADC.w #$EF80 : STA.b $02
        SEP #$20
        
        LDA.b #$7F : STA.b $04 ; $07 = $7FEF80 + offset.
        
        LDA.b $00 : AND.b #$07 : TAY
        LDA.b [$02] : AND.w Overworld_AliveStatusBits, Y : BNE .alpha
            JSR.w Overworld_LoadSprite
    
    .alpha
    
    RTS
}

; ==============================================================================

; $04C770-$04C80A LOCAL JUMP LOCATION
Overworld_LoadSprite:
{
    ; For some reason, sprite indices loaded from here are one less than
    ; what is loaded. Here, we're really referring to $F3 sprites, not a
    ; $F4 limit.
    LDA.b [$05] : CMP.b #$F4 : BCC .normalSprite
        JSR.w Overworld_LoadOverlord
        
        RTS
    
    .normalSprite
    
    LDX.b #$04
    
    CMP.b #$58 : BEQ .slotLimited
        LDX.b #$05
        
        CMP.b #$D0 : BEQ .slotLimited
            LDX.b #$0D
            
            CMP.b #$58 : BEQ .slotLimited
            CMP.b #$EB : BEQ .slotLimited
            CMP.b #$53 : BEQ .slotLimited
            CMP.b #$F3 : BNE .slotLimited
                ; By default sprites can go in slots 0 through 0x0E.
                LDX.b #$0E
        
    .slotLimited

    .nextSlot
    
        LDA.w $0DD0, X : BEQ .emptySlot
            LDA.w $0E20, X : CMP.b #$41 : BNE .notSoldier
                LDA.w $0DB0, X : BNE .emptySlot
        
            .notSoldier
    DEX : BPL .nextSlot
    
    RTS
    
    .emptySlot
    
    LDA.b [$02] : ORA.w Overworld_AliveStatusBits, Y : STA.b [$02]
    
    PHX
    
    TXA : ASL : TAX
    
    REP #$20
    LDA.b $00 : STA.w $0BC0, X
    SEP #$20
    
    PLX
    
    LDA.b [$05] : DEC : STA.w $0E20, X ; Load up a sprite here.
    
    LDA.b #$08 : STA.w $0DD0, X
    
    LDA.b $00 : ASL #4 : STA.w $0D10, X
    
    LDA.b $00 : AND.b #$F0 : STA.w $0D00, X
    LDA.b $01 : AND.b #$03 : STA.w $0D30, X
    
    LDA.b $01 : LSR : LSR : STA.w $0D20, X
    
    LDA.w $0D30, X : CLC : ADC.w $0FBD : STA.w $0D30, X
    LDA.w $0D20, X : CLC : ADC.w $0FBF : STA.w $0D20, X
    
    STZ.w $0F20, X : STZ.w $0E30, X : STZ.w $0CBA, X
    
    RTS
}

; ==============================================================================

; Appears to be the method of loading overlords on the overworld.
; $04C80B-$04C880 LOCAL JUMP LOCATION
Overworld_LoadOverlord:
{
    ; We're going to cycle through the 8 Overlord positions.
    LDX.b #$07
    
    .nextSlot
    
        LDA.w $0B00, X : BEQ .openSlot
    DEX : BPL .nextSlot
    
    RTS
    
    .openSlot
    
    ; Make the overlord appear alive in the "death" buffer. aka alive buffer.
    LDA.b [$02] : ORA.w Overworld_AliveStatusBits, Y : STA.b [$02]
    
    PHX
    
    TXA : ASL : TAX
    
    ; Store the offset into $7FDF80 that this overlord uses.
    REP #$20
    LDA.b $00 : STA.w $0B48, X
    SEP #$20
    
    PLX
    
    ; Overlord's type number = the original data value - 0xF3.
    LDA.b [$05] : SEC : SBC.b #$F3 : STA.w $0B00, X
                                     PHA
    
    LDA.b $00 : ASL #4
    
    PLY : CPY.b #$01 : BNE .gamma
        CLC : ADC.b #$08
    
    .gamma
    
    STA.w $0B08, X
    
    LDA.b $00 : AND.b #$F0 : STA.w $0B18, X
    LDA.b $01 : AND.b #$03 : STA.w $0B10, X
    
    LDA.b $01 : LSR : LSR : STA.w $0B20, X
    
    LDA.w $0B10, X : CLC : ADC.w $0FBD : STA.w $0B10, X
    LDA.w $0B20, X : CLC : ADC.w $0FBF : STA.w $0B20, X

    STZ.w $0B40, X
    
    ; $04C871 ALTERNATE ENTRY POINT
    .misc
    
    ; The area the overlord is residing in.
    LDA.w $040A : STA.w $0CCA, X
    
    STZ.w $0B30, X
    STZ.w $0B28, X
    STZ.w $0B38, X
    
    RTS
}

; ==============================================================================

; Overworld and dungeon sprite data is here.
; $04C881-$04EC9E DATA
Overworld_SpritePointers:
{
    ; $04C881
    .state_0
    dw Overworld_Sprites_EMPTY      ; 0x00 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x01 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x02 - $CB41 Lumberjacks
    dw Overworld_Sprites_EMPTY      ; 0x03 - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x04 - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x05 - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x06 - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x07 - $CB41 Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 0x08 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x09 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x0A - $CB41 Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0x0B - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0C - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0D - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0E - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0F - $CB41 Waterfall of Wishing
    dw Overworld_Sprites_EMPTY      ; 0x10 - $CB41 Lost Woods Alcove
    dw Overworld_Sprites_EMPTY      ; 0x11 - $CB41 North of Kakariko
    dw Overworld_Sprites_EMPTY      ; 0x12 - $CB41 Northwest Pond
    dw Overworld_Sprites_EMPTY      ; 0x13 - $CB41 Sanctuary
    dw Overworld_Sprites_EMPTY      ; 0x14 - $CB41 Graveyard
    dw Overworld_Sprites_EMPTY      ; 0x15 - $CB41 Hylia River Bend
    dw Overworld_Sprites_EMPTY      ; 0x16 - $CB41 Potion Shop
    dw Overworld_Sprites_EMPTY      ; 0x17 - $CB41 Octorok Pit
    dw Overworld_Sprites_EMPTY      ; 0x18 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x19 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x1A - $CB41 Kakariko Orchard
    dw Overworld_Sprites_Screen1B_0 ; 0x1B - $CB42 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x1C - $CB41 Hyrule Castle
    dw Overworld_Sprites_Screen1D_0 ; 0x1D - $CB5B Hylia River Peninsula
    dw Overworld_Sprites_EMPTY      ; 0x1E - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x1F - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x20 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x21 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x22 - $CB41 Smith's House
    dw Overworld_Sprites_EMPTY      ; 0x23 - $CB41 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x24 - $CB41 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x25 - $CB41 Boulder Field
    dw Overworld_Sprites_EMPTY      ; 0x26 - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x27 - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x28 - $CB41 Racing Game
    dw Overworld_Sprites_EMPTY      ; 0x29 - $CB41 South of Kakariko
    dw Overworld_Sprites_EMPTY      ; 0x2A - $CB41 Haunted Grove
    dw Overworld_Sprites_Screen2B_0 ; 0x2B - $CB5F West of Link's House
    dw Overworld_Sprites_Screen2C_0 ; 0x2C - $CB66 Link's House
    dw Overworld_Sprites_EMPTY      ; 0x2D - $CB41 Eastern Bridge
    dw Overworld_Sprites_EMPTY      ; 0x2E - $CB41 Lake Hylia River Bend
    dw Overworld_Sprites_EMPTY      ; 0x2F - $CB41 Eastern Portalway
    dw Overworld_Sprites_EMPTY      ; 0x30 - $CB41 Desert
    dw Overworld_Sprites_EMPTY      ; 0x31 - $CB41 Desert
    dw Overworld_Sprites_Screen32_0 ; 0x32 - $CB73 Haunted Grove Entrance
    dw Overworld_Sprites_EMPTY      ; 0x33 - $CB41 Marshlands Portalway
    dw Overworld_Sprites_EMPTY      ; 0x34 - $CB41 Marshlands Totems
    dw Overworld_Sprites_EMPTY      ; 0x35 - $CB41 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x36 - $CB41 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x37 - $CB41 Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 0x38 - $CB41 Desert
    dw Overworld_Sprites_EMPTY      ; 0x39 - $CB41 Desert
    dw Overworld_Sprites_EMPTY      ; 0x3A - $CB41 Desert Pass
    dw Overworld_Sprites_EMPTY      ; 0x3B - $CB41 Marshlands Dam Entrance
    dw Overworld_Sprites_EMPTY      ; 0x3C - $CB41 Marshlands Ravine
    dw Overworld_Sprites_EMPTY      ; 0x3D - $CB41 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x3E - $CB41 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x3F - $CB41 Lake Hylia Waterfall

    ; $04C901
    .state_1
    dw Overworld_Sprites_Screen00_1 ; 0x00 - $CF4C Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x01 - $CB41 Lost Woods
    dw Overworld_Sprites_Screen02_1 ; 0x02 - $CF7A Lumberjacks
    dw Overworld_Sprites_Screen03_1 ; 0x03 - $CF84 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x04 - $CB41 West Death Mountain
    dw Overworld_Sprites_Screen05_1 ; 0x05 - $CFA6 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x06 - $CB41 East Death Mountain
    dw Overworld_Sprites_Screen07_1 ; 0x07 - $CFCE Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 0x08 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x09 - $CB41 Lost Woods
    dw Overworld_Sprites_Screen0A_1 ; 0x0A - $CFDE Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0x0B - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0C - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0D - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0E - $CB41 East Death Mountain
    dw Overworld_Sprites_Screen0F_1 ; 0x0F - $CFFD Waterfall of Wishing
    dw Overworld_Sprites_Screen10_1 ; 0x10 - $D013 Lost Woods Alcove
    dw Overworld_Sprites_Screen11_1 ; 0x11 - $D020 North of Kakariko
    dw Overworld_Sprites_Screen12_1 ; 0x12 - $D02D Northwest Pond
    dw Overworld_Sprites_Screen13_1 ; 0x13 - $D03A Sanctuary
    dw Overworld_Sprites_Screen14_1 ; 0x14 - $D041 Graveyard
    dw Overworld_Sprites_Screen15_1 ; 0x15 - $D051 Hylia River Bend
    dw Overworld_Sprites_Screen16_1 ; 0x16 - $D05E Potion Shop
    dw Overworld_Sprites_Screen17_1 ; 0x17 - $D068 Octorok Pit
    dw Overworld_Sprites_Screen18_1 ; 0x18 - $D078 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x19 - $CB41 Kakariko Village
    dw Overworld_Sprites_Screen1A_1 ; 0x1A - $D0A0 Kakariko Orchard
    dw Overworld_Sprites_Screen1B_1 ; 0x1B - $D0B3 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x1C - $CB41 Hyrule Castle
    dw Overworld_Sprites_Screen1D_1 ; 0x1D - $D0DB Hylia River Peninsula
    dw Overworld_Sprites_Screen1E_1 ; 0x1E - $D0EB Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x1F - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x20 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x21 - $CB41 Kakariko Village
    dw Overworld_Sprites_Screen22_1 ; 0x22 - $D125 Smith's House
    dw Overworld_Sprites_EMPTY      ; 0x23 - $CB41 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x24 - $CB41 Hyrule Castle
    dw Overworld_Sprites_Screen25_1 ; 0x25 - $D12F Boulder Field
    dw Overworld_Sprites_EMPTY      ; 0x26 - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x27 - $CB41 Eastern Ruins
    dw Overworld_Sprites_Screen28_1 ; 0x28 - $D148 Racing Game
    dw Overworld_Sprites_EMPTY      ; 0x29 - $CB41 South of Kakariko
    dw Overworld_Sprites_Screen2A_1 ; 0x2A - $D152 Haunted Grove
    dw Overworld_Sprites_Screen2B_1 ; 0x2B - $D168 West of Link's House
    dw Overworld_Sprites_Screen2C_1 ; 0x2C - $D175 Link's House
    dw Overworld_Sprites_Screen2D_1 ; 0x2D - $D17C Eastern Bridge
    dw Overworld_Sprites_Screen2E_1 ; 0x2E - $D186 Lake Hylia River Bend
    dw Overworld_Sprites_Screen2F_1 ; 0x2F - $D193 Eastern Portalway
    dw Overworld_Sprites_Screen30_1 ; 0x30 - $D19D Desert
    dw Overworld_Sprites_EMPTY      ; 0x31 - $CB41 Desert
    dw Overworld_Sprites_Screen32_1 ; 0x32 - $D1E3 Haunted Grove Entrance
    dw Overworld_Sprites_Screen33_1 ; 0x33 - $D1F0 Marshlands Portalway
    dw Overworld_Sprites_Screen34_1 ; 0x34 - $D1FD Marshlands Totems
    dw Overworld_Sprites_Screen35_1 ; 0x35 - $D213 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x36 - $CB41 Lake Hylia
    dw Overworld_Sprites_Screen37_1 ; 0x37 - $D259 Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 0x38 - $CB41 Desert
    dw Overworld_Sprites_EMPTY      ; 0x39 - $CB41 Desert
    dw Overworld_Sprites_Screen3A_1 ; 0x3A - $D26C Desert Pass
    dw Overworld_Sprites_Screen3B_1 ; 0x3B - $D279 Marshlands Dam Entrance
    dw Overworld_Sprites_Screen3C_1 ; 0x3C - $D292 Marshlands Ravine
    dw Overworld_Sprites_EMPTY      ; 0x3D - $CB41 Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x3E - $CB41 Lake Hylia
    dw Overworld_Sprites_Screen3F_1 ; 0x3F - $D2A8 Lake Hylia Waterfall
    dw Overworld_Sprites_Screen40   ; 0x40 - $CB7A Skull Woods
    dw Overworld_Sprites_Screen42   ; 0x41 - $CBB7 Skull Woods
    dw Overworld_Sprites_Screen42   ; 0x42 - $CBB7 Dark Lumberjacks
    dw Overworld_Sprites_Screen43   ; 0x43 - $CBC4 West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 0x44 - $CBCB West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 0x45 - $CBCB East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x46 - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_Screen47   ; 0x47 - $CBD5 Turtle Rock
    dw Overworld_Sprites_EMPTY      ; 0x48 - $CB41 Skull Woods
    dw Overworld_Sprites_EMPTY      ; 0x49 - $CB41 Skull Woods
    dw Overworld_Sprites_Screen4A   ; 0x4A - $CBD9 Bumper Ledge
    dw Overworld_Sprites_EMPTY      ; 0x4B - $CB41 West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4C - $CB41 West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4D - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4E - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_Screen4F   ; 0x4F - $CBF5 Lake of Bad Omens
    dw Overworld_Sprites_Screen50   ; 0x50 - $CC02 Skull Woods Alcove
    dw Overworld_Sprites_Screen51   ; 0x51 - $CC12 North of Outcasts
    dw Overworld_Sprites_Screen52   ; 0x52 - $CC25 Dark Northwest Pond
    dw Overworld_Sprites_Screen53   ; 0x53 - $CC35 Dark Sanctuary
    dw Overworld_Sprites_Screen54   ; 0x54 - $CC45 Dark Graveyard
    dw Overworld_Sprites_Screen55   ; 0x55 - $CC5E Dark Hylia River Bend
    dw Overworld_Sprites_Screen56   ; 0x56 - $CC74 Dark Northeast Shop
    dw Overworld_Sprites_Screen57   ; 0x57 - $CC84 Dark Octorok Pit
    dw Overworld_Sprites_Screen58   ; 0x58 - $CC9A Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 0x59 - $CB41 Village of Outcasts
    dw Overworld_Sprites_Screen5A   ; 0x5A - $CCCE Outcasts Orchard
    dw Overworld_Sprites_Screen5B   ; 0x5B - $CCE1 Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 0x5C - $CB41 Pyramid of Power
    dw Overworld_Sprites_Screen5D   ; 0x5D - $CD03 Dark Hylia River Peninsula
    dw Overworld_Sprites_Screen5E   ; 0x5E - $CD19 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x5F - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x60 - $CB41 Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 0x61 - $CB41 Village of Outcasts
    dw Overworld_Sprites_Screen62   ; 0x62 - $CD59 Stake Puzzle
    dw Overworld_Sprites_EMPTY      ; 0x63 - $CB41 Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 0x64 - $CB41 Pyramid of Power
    dw Overworld_Sprites_Screen65   ; 0x65 - $CD6C Boulder Field
    dw Overworld_Sprites_EMPTY      ; 0x66 - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x67 - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_Screen68   ; 0x68 - $CD7F Digging Game
    dw Overworld_Sprites_Screen69   ; 0x69 - $CD83 South of Outcasts
    dw Overworld_Sprites_Screen6A   ; 0x6A - $CD87 Stumpy Grove
    dw Overworld_Sprites_Screen6B   ; 0x6B - $CD8B West of Bomb Shoppe
    dw Overworld_Sprites_Screen6C   ; 0x6C - $CD9B Bomb Shoppe
    dw Overworld_Sprites_Screen6D   ; 0x6D - $CDAB Hammer Bridge
    dw Overworld_Sprites_Screen6E   ; 0x6E - $CDBE Dark Lake Hylia River Bend
    dw Overworld_Sprites_Screen6F   ; 0x6F - $CDD1 East Dark World Portalway
    dw Overworld_Sprites_Screen70   ; 0x70 - $CDE1 Misery Mire
    dw Overworld_Sprites_Screen72   ; 0x71 - $CE06 Misery Mire
    dw Overworld_Sprites_Screen72   ; 0x72 - $CE06 Stumpy Grove Entrance
    dw Overworld_Sprites_Screen73   ; 0x73 - $CE16 Swamplands Portalway
    dw Overworld_Sprites_Screen74   ; 0x74 - $CE26 Swamplands Totems
    dw Overworld_Sprites_Screen75   ; 0x75 - $CE3C Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 0x76 - $CE7F Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 0x77 - $CE7F Dark Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 0x78 - $CB41 Misery Mire
    dw Overworld_Sprites_EMPTY      ; 0x79 - $CB41 Misery Mire
    dw Overworld_Sprites_Screen7A   ; 0x7A - $CE92 West of Swamplands
    dw Overworld_Sprites_Screen7B   ; 0x7B - $CE9F Swamplands Palace Entrance
    dw Overworld_Sprites_Screen7C   ; 0x7C - $CEB2 Swamplands Ravine
    dw Overworld_Sprites_EMPTY      ; 0x7D - $CB41 Dark Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x7E - $CB41 Dark Lake Hylia
    dw Overworld_Sprites_Screen7F   ; 0x7F - $CEC5 Dark Lake Hylia Waterfall
    dw Overworld_Sprites_Screen80   ; 0x80 - $CEDB Master Sword Pedestal
    dw Overworld_Sprites_Screen81   ; 0x81 - $CEF4 Zora's Domain
    dw Overworld_Sprites_EMPTY      ; 0x82 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x83 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x84 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x85 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x86 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x87 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x88 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x89 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8A - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8B - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8C - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8D - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8E - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8F - $CB41 Unused SW Area
   
   ; $04CA21
   .state_2
    dw Overworld_Sprites_Screen00_2 ; 0x00 - $D2B8 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x01 - $CB41 Lost Woods
    dw Overworld_Sprites_Screen02_2 ; 0x02 - $D2E3 Lumberjacks
    dw Overworld_Sprites_Screen03_2 ; 0x03 - $D2E7 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x04 - $CB41 West Death Mountain
    dw Overworld_Sprites_Screen05_2 ; 0x05 - $D315 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x06 - $CB41 East Death Mountain
    dw Overworld_Sprites_Screen07_2 ; 0x07 - $D343 Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 0x08 - $CB41 Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0x09 - $CB41 Lost Woods
    dw Overworld_Sprites_Screen0A_2 ; 0x0A - $D353 Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0x0B - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0C - $CB41 West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0D - $CB41 East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x0E - $CB41 East Death Mountain
    dw Overworld_Sprites_Screen0F_2 ; 0x0F - $D369 Waterfall of Wishing
    dw Overworld_Sprites_Screen10_2 ; 0x10 - $D37F Lost Woods Alcove
    dw Overworld_Sprites_Screen11_2 ; 0x11 - $D38F North of Kakariko
    dw Overworld_Sprites_Screen12_2 ; 0x12 - $D39C Northwest Pond
    dw Overworld_Sprites_Screen13_2 ; 0x13 - $D3A9 Sanctuary
    dw Overworld_Sprites_Screen14_2 ; 0x14 - $D3B6 Graveyard
    dw Overworld_Sprites_Screen15_2 ; 0x15 - $D3C9 Hylia River Bend
    dw Overworld_Sprites_Screen16_2 ; 0x16 - $D3D9 Potion Shop
    dw Overworld_Sprites_Screen17_2 ; 0x17 - $D3E3 Octorok Pit
    dw Overworld_Sprites_Screen18_2 ; 0x18 - $D3F3 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x19 - $CB41 Kakariko Village
    dw Overworld_Sprites_Screen1A_2 ; 0x1A - $D418 Kakariko Orchard
    dw Overworld_Sprites_Screen1B_2 ; 0x1B - $D428 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x1C - $CB41 Hyrule Castle
    dw Overworld_Sprites_Screen1D_2 ; 0x1D - $D447 Hylia River Peninsula
    dw Overworld_Sprites_Screen1E_2 ; 0x1E - $D454 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x1F - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x20 - $CB41 Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 0x21 - $CB41 Kakariko Village
    dw Overworld_Sprites_Screen22_2 ; 0x22 - $D491 Smith's House
    dw Overworld_Sprites_EMPTY      ; 0x23 - $CB41 Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 0x24 - $CB41 Hyrule Castle
    dw Overworld_Sprites_Screen25_2 ; 0x25 - $D49B Boulder Field
    dw Overworld_Sprites_EMPTY      ; 0x26 - $CB41 Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 0x27 - $CB41 Eastern Ruins
    dw Overworld_Sprites_Screen28_2 ; 0x28 - $D4A8 Racing Game
    dw Overworld_Sprites_Screen29_2 ; 0x29 - D4B8 South of Kakariko
    dw Overworld_Sprites_Screen2A_2 ; 0x2A - $D4C2 Haunted Grove
    dw Overworld_Sprites_Screen2B_2 ; 0x2B - $D4DE West of Link's House
    dw Overworld_Sprites_Screen2C_2 ; 0x2C - $D4EE Link's House
    dw Overworld_Sprites_Screen2D_2 ; 0x2D - $D4F5 Eastern Bridge
    dw Overworld_Sprites_Screen2E_2 ; 0x2E - $D502 Lake Hylia River Bend
    dw Overworld_Sprites_Screen2F_2 ; 0x2F - $D515 Eastern Portalway
    dw Overworld_Sprites_Screen30_2 ; 0x30 - $D51F Desert
    dw Overworld_Sprites_EMPTY      ; 0x31 - $CB41 Desert
    dw Overworld_Sprites_Screen32_2 ; 0x32 - $D55C Haunted Grove Entrance
    dw Overworld_Sprites_Screen33_2 ; 0x33 - $D56F Marshlands Portalway
    dw Overworld_Sprites_Screen34_2 ; 0x34 - $D57F Marshlands Totems
    dw Overworld_Sprites_Screen35_2 ; 0x35 - $D58F Lake Hylia
    dw Overworld_Sprites_Screen37_2 ; 0x36 - $D5D5 Lake Hylia
    dw Overworld_Sprites_Screen37_2 ; 0x37 - $D5D5 Lake Hylia River End
    dw Overworld_Sprites_Screen3A_2 ; 0x38 - $D5E5 Desert
    dw Overworld_Sprites_Screen3A_2 ; 0x39 - $D5E5 Desert
    dw Overworld_Sprites_Screen3A_2 ; 0x3A - $D5E5 Desert Pass
    dw Overworld_Sprites_Screen3B_2 ; 0x3B - $D5FE Marshlands Dam Entrance
    dw Overworld_Sprites_Screen3C_2 ; 0x3C - $D611 Marshlands Ravine
    dw Overworld_Sprites_Screen3F_2 ; 0x3D - $D621 Lake Hylia
    dw Overworld_Sprites_Screen3F_2 ; 0x3E - $D621 Lake Hylia
    dw Overworld_Sprites_Screen3F_2 ; 0x3F - $D621 Lake Hylia Waterfall
    dw Overworld_Sprites_Screen40   ; 0x40 - $CB7A Skull Woods
    dw Overworld_Sprites_Screen42   ; 0x41 - $CBB7 Skull Woods
    dw Overworld_Sprites_Screen42   ; 0x42 - $CBB7 Dark Lumberjacks
    dw Overworld_Sprites_Screen43   ; 0x43 - $CBC4 West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 0x44 - $CBCB West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 0x45 - $CBCB East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x46 - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_Screen47   ; 0x47 - $CBD5 Turtle Rock
    dw Overworld_Sprites_EMPTY      ; 0x48 - $CB41 Skull Woods
    dw Overworld_Sprites_EMPTY      ; 0x49 - $CB41 Skull Woods
    dw Overworld_Sprites_Screen4A   ; 0x4A - $CBD9 Bumper Ledge
    dw Overworld_Sprites_EMPTY      ; 0x4B - $CB41 West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4C - $CB41 West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4D - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0x4E - $CB41 East Dark Death Mountain
    dw Overworld_Sprites_Screen4F   ; 0x4F - $CBF5 Lake of Bad Omens
    dw Overworld_Sprites_Screen50   ; 0x50 - $CC02 Skull Woods Alcove
    dw Overworld_Sprites_Screen51   ; 0x51 - $CC12 North of Outcasts
    dw Overworld_Sprites_Screen52   ; 0x52 - $CC25 Dark Northwest Pond
    dw Overworld_Sprites_Screen53   ; 0x53 - $CC35 Dark Sanctuary
    dw Overworld_Sprites_Screen54   ; 0x54 - $CC45 Dark Graveyard
    dw Overworld_Sprites_Screen55   ; 0x55 - $CC5E Dark Hylia River Bend
    dw Overworld_Sprites_Screen56   ; 0x56 - $CC74 Dark Northeast Shop
    dw Overworld_Sprites_Screen57   ; 0x57 - $CC84 Dark Octorok Pit
    dw Overworld_Sprites_Screen58   ; 0x58 - $CC9A Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 0x59 - $CB41 Village of Outcasts
    dw Overworld_Sprites_Screen5A   ; 0x5A - $CCCE Outcasts Orchard
    dw Overworld_Sprites_Screen5B   ; 0x5B - $CCE1 Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 0x5C - $CB41 Pyramid of Power
    dw Overworld_Sprites_Screen5D   ; 0x5D - $CD03 Dark Hylia River Peninsula
    dw Overworld_Sprites_Screen5E   ; 0x5E - $CD19 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x5F - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x60 - $CB41 Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 0x61 - $CB41 Village of Outcasts
    dw Overworld_Sprites_Screen62   ; 0x62 - $CD59 Stake Puzzle
    dw Overworld_Sprites_EMPTY      ; 0x63 - $CB41 Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 0x64 - $CB41 Pyramid of Power
    dw Overworld_Sprites_Screen65   ; 0x65 - $CD6C Boulder Field
    dw Overworld_Sprites_EMPTY      ; 0x66 - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 0x67 - $CB41 Palace of Darkness Maze
    dw Overworld_Sprites_Screen68   ; 0x68 - $CD7F Digging Game
    dw Overworld_Sprites_Screen69   ; 0x69 - $CD83 South of Outcasts
    dw Overworld_Sprites_Screen6A   ; 0x6A - $CD87 Stumpy Grove
    dw Overworld_Sprites_Screen6B   ; 0x6B - $CD8B West of Bomb Shoppe
    dw Overworld_Sprites_Screen6C   ; 0x6C - $CD9B Bomb Shoppe
    dw Overworld_Sprites_Screen6D   ; 0x6D - $CDAB Hammer Bridge
    dw Overworld_Sprites_Screen6E   ; 0x6E - $CDBE Dark Lake Hylia River Bend
    dw Overworld_Sprites_Screen6F   ; 0x6F - $CDD1 East Dark World Portalway
    dw Overworld_Sprites_Screen70   ; 0x70 - $CDE1 Misery Mire
    dw Overworld_Sprites_Screen72   ; 0x71 - $CE06 Misery Mire
    dw Overworld_Sprites_Screen72   ; 0x72 - $CE06 Stumpy Grove Entrance
    dw Overworld_Sprites_Screen73   ; 0x73 - $CE16 Swamplands Portalway
    dw Overworld_Sprites_Screen74   ; 0x74 - $CE26 Swamplands Totems
    dw Overworld_Sprites_Screen75   ; 0x75 - $CE3C Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 0x76 - $CE7F Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 0x77 - $CE7F Dark Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 0x78 - $CB41 Misery Mire
    dw Overworld_Sprites_EMPTY      ; 0x79 - $CB41 Misery Mire
    dw Overworld_Sprites_Screen7A   ; 0x7A - $CE92 West of Swamplands
    dw Overworld_Sprites_Screen7B   ; 0x7B - $CE9F Swamplands Palace Entrance
    dw Overworld_Sprites_Screen7C   ; 0x7C - $CEB2 Swamplands Ravine
    dw Overworld_Sprites_EMPTY      ; 0x7D - $CB41 Dark Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 0x7E - $CB41 Dark Lake Hylia
    dw Overworld_Sprites_Screen7F   ; 0x7F - $CEC5 Dark Lake Hylia Waterfall
    dw Overworld_Sprites_Screen80   ; 0x80 - $CEDB Master Sword Pedestal
    dw Overworld_Sprites_Screen81   ; 0x81 - $CEF4 Zora's Domain
    dw Overworld_Sprites_EMPTY      ; 0x82 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x83 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x84 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x85 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x86 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x87 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x88 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x89 - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8A - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8B - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8C - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8D - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8E - $CB41 Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 0x8F - $CB41 Unused SW Area
}

; ==============================================================================

; $04CB41-$04CB41 DATA
Overworld_Sprites_EMPTY:
{
    db $FF ; END
}

; ==============================================================================

; $04CB42-$04CB5A DATA
Overworld_Sprites_Screen1B_0:
{
    db $06, $1F, $40 ; SPRITE 40   | xy: { 0x1F0, 0x060 }
    db $12, $01, $3F ; SPRITE 3F   | xy: { 0x010, 0x120 }
    db $14, $01, $3F ; SPRITE 3F   | xy: { 0x010, 0x140 }
    db $13, $1F, $42 ; SPRITE 42   | xy: { 0x1F0, 0x130 }
    db $1A, $1F, $4B ; SPRITE 4B   | xy: { 0x1F0, 0x1A0 }
    db $1A, $20, $4B ; SPRITE 4B   | xy: { 0x200, 0x1A0 }
    db $25, $2D, $3F ; SPRITE 3F   | xy: { 0x2D0, 0x250 }
    db $29, $20, $3F ; SPRITE 3F   | xy: { 0x200, 0x290 }
    db $FF ; END
}

; ==============================================================================

; $04CB5B-$04CB5E DATA
Overworld_Sprites_Screen1D_0:
{
    db $06, $0B, $AC ; SPRITE AC   | xy: { 0x0B0, 0x060 }
    db $FF ; END
}

; ==============================================================================

; $04CB5F-$04CB65 DATA
Overworld_Sprites_Screen2B_0:
{
    db $1E, $09, $3F ; SPRITE 3F   | xy: { 0x090, 0x1E0 }
    db $1E, $0B, $3F ; SPRITE 3F   | xy: { 0x0B0, 0x1E0 }
    db $FF ; END
}

; ==============================================================================

; $04CB66-$04CB72 DATA
Overworld_Sprites_Screen2C_0:
{
    db $18, $1E, $3F ; SPRITE 3F   | xy: { 0x1E0, 0x180 }
    db $1A, $1E, $3F ; SPRITE 3F   | xy: { 0x1E0, 0x1A0 }
    db $1E, $0D, $3F ; SPRITE 3F   | xy: { 0x0D0, 0x1E0 }
    db $1E, $0F, $3F ; SPRITE 3F   | xy: { 0x0F0, 0x1E0 }
    db $FF ; END
}

; ==============================================================================

; $04CB73-$04CB79 DATA
Overworld_Sprites_Screen32_0:
{
    db $09, $1A, $DC ; SPRITE DC   | xy: { 0x1A0, 0x090 }
    db $12, $18, $D8 ; SPRITE D8   | xy: { 0x180, 0x120 }
    db $FF ; END
}

; ==============================================================================

; $04CB7A-$04CBB6 DATA
Overworld_Sprites_Screen40:
{
    db $07, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x070 }
    db $11, $12, $22 ; SPRITE 22   | xy: { 0x120, 0x110 }
    db $1E, $0A, $22 ; SPRITE 22   | xy: { 0x0A0, 0x1E0 }
    db $09, $2F, $22 ; SPRITE 22   | xy: { 0x2F0, 0x090 }
    db $0A, $31, $0E ; SPRITE 0E   | xy: { 0x310, 0x0A0 }
    db $0B, $33, $22 ; SPRITE 22   | xy: { 0x330, 0x0B0 }
    db $14, $29, $22 ; SPRITE 22   | xy: { 0x290, 0x140 }
    db $16, $23, $22 ; SPRITE 22   | xy: { 0x230, 0x160 }
    db $17, $39, $AA ; SPRITE AA   | xy: { 0x390, 0x170 }
    db $21, $0A, $22 ; SPRITE 22   | xy: { 0x0A0, 0x210 }
    db $25, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x250 }
    db $28, $0B, $AA ; SPRITE AA   | xy: { 0x0B0, 0x280 }
    db $30, $1E, $22 ; SPRITE 22   | xy: { 0x1E0, 0x300 }
    db $38, $0E, $22 ; SPRITE 22   | xy: { 0x0E0, 0x380 }
    db $38, $11, $22 ; SPRITE 22   | xy: { 0x110, 0x380 }
    db $39, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x390 }
    db $21, $2D, $22 ; SPRITE 22   | xy: { 0x2D0, 0x210 }
    db $28, $32, $22 ; SPRITE 22   | xy: { 0x320, 0x280 }
    db $32, $37, $22 ; SPRITE 22   | xy: { 0x370, 0x320 }
    db $37, $28, $AA ; SPRITE AA   | xy: { 0x280, 0x370 }
    db $FF ; END
}

; ==============================================================================

; $04CBB7-$04CBC3 DATA
Overworld_Sprites_Screen42:
{
    db $11, $0C, $0E ; SPRITE 0E   | xy: { 0x0C0, 0x110 }
    db $13, $0C, $0E ; SPRITE 0E   | xy: { 0x0C0, 0x130 }
    db $16, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x160 }
    db $19, $0E, $12 ; SPRITE 12   | xy: { 0x0E0, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CBC4-$04CBCA DATA
Overworld_Sprites_Screen43:
{
    db $0C, $2F, $37 ; SPRITE 37   | xy: { 0x2F0, 0x0C0 }
    db $18, $20, $B9 ; SPRITE B9   | xy: { 0x200, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CBCB-$04CBD4 DATA
Overworld_Sprites_Screen45:
{
    db $0C, $06, $D0 ; SPRITE D0   | xy: { 0x060, 0x0C0 }
    db $0E, $1D, $D0 ; SPRITE D0   | xy: { 0x1D0, 0x0E0 }
    db $0B, $20, $D0 ; SPRITE D0   | xy: { 0x200, 0x0B0 }
    db $FF ; END
}

; ==============================================================================

; $04CBD5-$04CBD8 DATA
Overworld_Sprites_Screen47:
{
    db $14, $16, $33 ; SPRITE 33   | xy: { 0x160, 0x140 }
    db $FF ; END
}

; ==============================================================================

; $04CBD9-$04CBF4 DATA
Overworld_Sprites_Screen4A:
{
    db $06, $0E, $33 ; SPRITE 33   | xy: { 0x0E0, 0x060 }
    db $08, $18, $EB ; SPRITE EB   | xy: { 0x180, 0x080 }
    db $0F, $0B, $12 ; SPRITE 12   | xy: { 0x0B0, 0x0F0 }
    db $10, $08, $12 ; SPRITE 12   | xy: { 0x080, 0x100 }
    db $13, $16, $12 ; SPRITE 12   | xy: { 0x160, 0x130 }
    db $13, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x130 }
    db $14, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x140 }
    db $18, $0E, $22 ; SPRITE 22   | xy: { 0x0E0, 0x180 }
    db $1A, $14, $D3 ; SPRITE D3   | xy: { 0x140, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04CBF5-$04CC01 DATA
Overworld_Sprites_Screen4F:
{
    db $08, $19, $55 ; SPRITE 55   | xy: { 0x190, 0x080 }
    db $0B, $04, $C0 ; SPRITE C0   | xy: { 0x040, 0x0B0 }
    db $0D, $18, $D3 ; SPRITE D3   | xy: { 0x180, 0x0D0 }
    db $11, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x110 }
    db $FF ; END
}

; ==============================================================================

; $04CC02-$04CC11 DATA
Overworld_Sprites_Screen50:
{
    db $0B, $16, $19 ; SPRITE 19   | xy: { 0x160, 0x0B0 }
    db $0C, $05, $12 ; SPRITE 12   | xy: { 0x050, 0x0C0 }
    db $0E, $08, $25 ; SPRITE 25   | xy: { 0x080, 0x0E0 }
    db $13, $19, $0B ; SPRITE 0B   | xy: { 0x190, 0x130 }
    db $18, $08, $12 ; SPRITE 12   | xy: { 0x080, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CC12-$04CC24 DATA
Overworld_Sprites_Screen51:
{
    db $0E, $17, $45 ; SPRITE 45   | xy: { 0x170, 0x0E0 }
    db $10, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x100 }
    db $10, $09, $E3 ; SPRITE E3   | xy: { 0x090, 0x100 }
    db $15, $1C, $D3 ; SPRITE D3   | xy: { 0x1C0, 0x150 }
    db $16, $14, $12 ; SPRITE 12   | xy: { 0x140, 0x160 }
    db $17, $0E, $12 ; SPRITE 12   | xy: { 0x0E0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CC25-$04CC34 DATA
Overworld_Sprites_Screen52:
{
    db $09, $12, $D3 ; SPRITE D3   | xy: { 0x120, 0x090 }
    db $0D, $15, $12 ; SPRITE 12   | xy: { 0x150, 0x0D0 }
    db $10, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x100 }
    db $17, $14, $41 ; SPRITE 41   | xy: { 0x140, 0x170 }
    db $18, $0E, $12 ; SPRITE 12   | xy: { 0x0E0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CC35-$04CC44 DATA
Overworld_Sprites_Screen53:
{
    db $0B, $06, $D3 ; SPRITE D3   | xy: { 0x060, 0x0B0 }
    db $0C, $15, $11 ; SPRITE 11   | xy: { 0x150, 0x0C0 }
    db $0D, $08, $22 ; SPRITE 22   | xy: { 0x080, 0x0D0 }
    db $15, $0D, $12 ; SPRITE 12   | xy: { 0x0D0, 0x150 }
    db $18, $16, $0E ; SPRITE 0E   | xy: { 0x160, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CC45-$04CC5D DATA
Overworld_Sprites_Screen54:
{
    db $0D, $14, $22 ; SPRITE 22   | xy: { 0x140, 0x0D0 }
    db $0B, $05, $DC ; SPRITE DC   | xy: { 0x050, 0x0B0 }
    db $0B, $19, $DB ; SPRITE DB   | xy: { 0x190, 0x0B0 }
    db $0F, $07, $22 ; SPRITE 22   | xy: { 0x070, 0x0F0 }
    db $0E, $0F, $E3 ; SPRITE E3   | xy: { 0x0F0, 0x0E0 }
    db $10, $19, $22 ; SPRITE 22   | xy: { 0x190, 0x100 }
    db $14, $0D, $22 ; SPRITE 22   | xy: { 0x0D0, 0x140 }
    db $19, $11, $11 ; SPRITE 11   | xy: { 0x110, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CC5E-$04CC73 DATA
Overworld_Sprites_Screen55:
{
    db $09, $11, $BA ; SPRITE BA   | xy: { 0x110, 0x090 }
    db $0E, $16, $11 ; SPRITE 11   | xy: { 0x160, 0x0E0 }
    db $0E, $18, $D3 ; SPRITE D3   | xy: { 0x180, 0x0E0 }
    db $0F, $1B, $DA ; SPRITE DA   | xy: { 0x1B0, 0x0F0 }
    db $17, $07, $11 ; SPRITE 11   | xy: { 0x070, 0x170 }
    db $1A, $0A, $79 ; SPRITE 79   | xy: { 0x0A0, 0x1A0 }
    db $1B, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04CC74-$04CC83 DATA
Overworld_Sprites_Screen56:
{
    db $06, $0A, $55 ; SPRITE 55   | xy: { 0x0A0, 0x060 }
    db $0A, $13, $55 ; SPRITE 55   | xy: { 0x130, 0x0A0 }
    db $0E, $04, $79 ; SPRITE 79   | xy: { 0x040, 0x0E0 }
    db $17, $11, $22 ; SPRITE 22   | xy: { 0x110, 0x170 }
    db $1A, $05, $22 ; SPRITE 22   | xy: { 0x050, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04CC84-$04CC99 DATA
Overworld_Sprites_Screen57:
{
    db $04, $0C, $55 ; SPRITE 55   | xy: { 0x0C0, 0x040 }
    db $08, $16, $08 ; SPRITE 08   | xy: { 0x160, 0x080 }
    db $0A, $18, $08 ; SPRITE 08   | xy: { 0x180, 0x0A0 }
    db $0E, $0E, $08 ; SPRITE 08   | xy: { 0x0E0, 0x0E0 }
    db $10, $0E, $D3 ; SPRITE D3   | xy: { 0x0E0, 0x100 }
    db $1A, $0E, $08 ; SPRITE 08   | xy: { 0x0E0, 0x1A0 }
    db $1B, $0D, $08 ; SPRITE 08   | xy: { 0x0D0, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04CC9A-$04CCCD DATA
Overworld_Sprites_Screen58:
{
    db $06, $13, $12 ; SPRITE 12   | xy: { 0x130, 0x060 }
    db $0C, $18, $25 ; SPRITE 25   | xy: { 0x180, 0x0C0 }
    db $1C, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x1C0 }
    db $0A, $35, $12 ; SPRITE 12   | xy: { 0x350, 0x0A0 }
    db $0C, $2B, $19 ; SPRITE 19   | xy: { 0x2B0, 0x0C0 }
    db $17, $2E, $C4 ; SPRITE C4   | xy: { 0x2E0, 0x170 }
    db $1C, $20, $14 ; SPRITE 14   | xy: { 0x200, 0x1C0 }
    db $25, $18, $19 ; SPRITE 19   | xy: { 0x180, 0x250 }
    db $27, $0D, $C4 ; SPRITE C4   | xy: { 0x0D0, 0x270 }
    db $28, $1D, $19 ; SPRITE 19   | xy: { 0x1D0, 0x280 }
    db $2E, $12, $12 ; SPRITE 12   | xy: { 0x120, 0x2E0 }
    db $34, $16, $0B ; SPRITE 0B   | xy: { 0x160, 0x340 }
    db $37, $15, $0B ; SPRITE 0B   | xy: { 0x150, 0x370 }
    db $27, $28, $0B ; SPRITE 0B   | xy: { 0x280, 0x270 }
    db $2F, $33, $41 ; SPRITE 41   | xy: { 0x330, 0x2F0 }
    db $34, $2C, $19 ; SPRITE 19   | xy: { 0x2C0, 0x340 }
    db $35, $37, $25 ; SPRITE 25   | xy: { 0x370, 0x350 }
    db $FF ; END
}

; ==============================================================================

; $04CCCE-$04CCE0 DATA
Overworld_Sprites_Screen5A:
{
    db $08, $0F, $12 ; SPRITE 12   | xy: { 0x0F0, 0x080 }
    db $08, $12, $25 ; SPRITE 25   | xy: { 0x120, 0x080 }
    db $0D, $12, $D3 ; SPRITE D3   | xy: { 0x120, 0x0D0 }
    db $0C, $15, $12 ; SPRITE 12   | xy: { 0x150, 0x0C0 }
    db $0F, $0B, $11 ; SPRITE 11   | xy: { 0x0B0, 0x0F0 }
    db $19, $0E, $12 ; SPRITE 12   | xy: { 0x0E0, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CCE1-$04CD02 DATA
Overworld_Sprites_Screen5B:
{
    db $17, $15, $22 ; SPRITE 22   | xy: { 0x150, 0x170 }
    db $12, $34, $EB ; SPRITE EB   | xy: { 0x340, 0x120 }
    db $24, $13, $33 ; SPRITE 33   | xy: { 0x130, 0x240 }
    db $27, $0F, $12 ; SPRITE 12   | xy: { 0x0F0, 0x270 }
    db $2A, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x2A0 }
    db $2A, $0C, $12 ; SPRITE 12   | xy: { 0x0C0, 0x2A0 }
    db $2C, $1E, $11 ; SPRITE 11   | xy: { 0x1E0, 0x2C0 }
    db $25, $34, $0E ; SPRITE 0E   | xy: { 0x340, 0x250 }
    db $27, $32, $12 ; SPRITE 12   | xy: { 0x320, 0x270 }
    db $29, $30, $12 ; SPRITE 12   | xy: { 0x300, 0x290 }
    db $2C, $21, $11 ; SPRITE 11   | xy: { 0x210, 0x2C0 }
    db $FF ; END
}

; ==============================================================================

; $04CD03-$04CD18 DATA
Overworld_Sprites_Screen5D:
{
    db $08, $0B, $25 ; SPRITE 25   | xy: { 0x0B0, 0x080 }
    db $09, $07, $11 ; SPRITE 11   | xy: { 0x070, 0x090 }
    db $0B, $06, $0E ; SPRITE 0E   | xy: { 0x060, 0x0B0 }
    db $0B, $18, $12 ; SPRITE 12   | xy: { 0x180, 0x0B0 }
    db $0E, $17, $D3 ; SPRITE D3   | xy: { 0x170, 0x0E0 }
    db $10, $1A, $12 ; SPRITE 12   | xy: { 0x1A0, 0x100 }
    db $11, $08, $41 ; SPRITE 41   | xy: { 0x080, 0x110 }
    db $FF ; END
}

; ==============================================================================

; $04CD19-$04CD58 DATA
Overworld_Sprites_Screen5E:
{
    db $04, $0D, $22 ; SPRITE 22   | xy: { 0x0D0, 0x040 }
    db $11, $03, $22 ; SPRITE 22   | xy: { 0x030, 0x110 }
    db $11, $15, $B6 ; SPRITE B6   | xy: { 0x150, 0x110 }
    db $1A, $12, $22 ; SPRITE 22   | xy: { 0x120, 0x1A0 }
    db $09, $27, $22 ; SPRITE 22   | xy: { 0x270, 0x090 }
    db $10, $2F, $22 ; SPRITE 22   | xy: { 0x2F0, 0x100 }
    db $15, $25, $12 ; SPRITE 12   | xy: { 0x250, 0x150 }
    db $17, $26, $11 ; SPRITE 11   | xy: { 0x260, 0x170 }
    db $18, $35, $22 ; SPRITE 22   | xy: { 0x350, 0x180 }
    db $1E, $2A, $22 ; SPRITE 22   | xy: { 0x2A0, 0x1E0 }
    db $26, $0A, $12 ; SPRITE 12   | xy: { 0x0A0, 0x260 }
    db $2B, $0C, $12 ; SPRITE 12   | xy: { 0x0C0, 0x2B0 }
    db $35, $07, $22 ; SPRITE 22   | xy: { 0x070, 0x350 }
    db $37, $16, $11 ; SPRITE 11   | xy: { 0x160, 0x370 }
    db $38, $09, $0E ; SPRITE 0E   | xy: { 0x090, 0x380 }
    db $24, $32, $12 ; SPRITE 12   | xy: { 0x320, 0x240 }
    db $28, $35, $0E ; SPRITE 0E   | xy: { 0x350, 0x280 }
    db $30, $24, $22 ; SPRITE 22   | xy: { 0x240, 0x300 }
    db $30, $30, $E3 ; SPRITE E3   | xy: { 0x300, 0x300 }
    db $36, $35, $11 ; SPRITE 11   | xy: { 0x350, 0x360 }
    db $37, $29, $00 ; SPRITE 00   | xy: { 0x290, 0x370 }
    db $FF ; END
}

; ==============================================================================

; $04CD59-$04CD6B DATA
Overworld_Sprites_Screen62:
{
    db $05, $0D, $B4 ; SPRITE B4   | xy: { 0x0D0, 0x050 }
    db $11, $13, $0B ; SPRITE 0B   | xy: { 0x130, 0x110 }
    db $13, $11, $0B ; SPRITE 0B   | xy: { 0x110, 0x130 }
    db $15, $15, $0B ; SPRITE 0B   | xy: { 0x150, 0x150 }
    db $16, $09, $0B ; SPRITE 0B   | xy: { 0x090, 0x160 }
    db $17, $11, $0B ; SPRITE 0B   | xy: { 0x110, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CD6C-$04CD7E DATA
Overworld_Sprites_Screen65:
{
    db $07, $13, $12 ; SPRITE 12   | xy: { 0x130, 0x070 }
    db $0A, $0F, $D3 ; SPRITE D3   | xy: { 0x0F0, 0x0A0 }
    db $0C, $0E, $12 ; SPRITE 12   | xy: { 0x0E0, 0x0C0 }
    db $11, $05, $11 ; SPRITE 11   | xy: { 0x050, 0x110 }
    db $16, $0A, $12 ; SPRITE 12   | xy: { 0x0A0, 0x160 }
    db $16, $13, $12 ; SPRITE 12   | xy: { 0x130, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04CD7F-$04CD82 DATA
Overworld_Sprites_Screen68:
{
    db $11, $0E, $D5 ; SPRITE D5   | xy: { 0x0E0, 0x110 }
    db $FF ; END
}

; ==============================================================================

; $04CD83-$04CD86 DATA
Overworld_Sprites_Screen69:
{
    db $09, $06, $1A ; SPRITE 1A   | xy: { 0x060, 0x090 }
    db $FF ; END
}

; ==============================================================================

; $04CD87-$04CD8A DATA
Overworld_Sprites_Screen6A:
{
    db $0F, $0E, $2E ; SPRITE 2E   | xy: { 0x0E0, 0x0F0 }
    db $FF ; END
}

; ==============================================================================

; $04CD8B-$04CD9A DATA
Overworld_Sprites_Screen6B:
{
    db $08, $16, $25 ; SPRITE 25   | xy: { 0x160, 0x080 }
    db $09, $08, $22 ; SPRITE 22   | xy: { 0x080, 0x090 }
    db $0F, $17, $25 ; SPRITE 25   | xy: { 0x170, 0x0F0 }
    db $16, $13, $12 ; SPRITE 12   | xy: { 0x130, 0x160 }
    db $19, $0F, $12 ; SPRITE 12   | xy: { 0x0F0, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CD9B-$04CDAA DATA
Overworld_Sprites_Screen6C:
{
    db $06, $15, $0E ; SPRITE 0E   | xy: { 0x150, 0x060 }
    db $0A, $15, $12 ; SPRITE 12   | xy: { 0x150, 0x0A0 }
    db $0D, $14, $12 ; SPRITE 12   | xy: { 0x140, 0x0D0 }
    db $16, $14, $11 ; SPRITE 11   | xy: { 0x140, 0x160 }
    db $19, $09, $22 ; SPRITE 22   | xy: { 0x090, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CDAB-$04CDBD DATA
Overworld_Sprites_Screen6D:
{
    db $05, $0F, $22 ; SPRITE 22   | xy: { 0x0F0, 0x050 }
    db $07, $0D, $11 ; SPRITE 11   | xy: { 0x0D0, 0x070 }
    db $08, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x080 }
    db $0A, $10, $41 ; SPRITE 41   | xy: { 0x100, 0x0A0 }
    db $1A, $10, $D3 ; SPRITE D3   | xy: { 0x100, 0x1A0 }
    db $1B, $13, $D3 ; SPRITE D3   | xy: { 0x130, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04CDBE-$04CDD0 DATA
Overworld_Sprites_Screen6E:
{
    db $08, $0C, $DA ; SPRITE DA   | xy: { 0x0C0, 0x080 }
    db $09, $10, $79 ; SPRITE 79   | xy: { 0x100, 0x090 }
    db $0A, $14, $AC ; SPRITE AC   | xy: { 0x140, 0x0A0 }
    db $0B, $08, $41 ; SPRITE 41   | xy: { 0x080, 0x0B0 }
    db $0E, $10, $41 ; SPRITE 41   | xy: { 0x100, 0x0E0 }
    db $18, $1A, $22 ; SPRITE 22   | xy: { 0x1A0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CDD1-$04CDE0 DATA
Overworld_Sprites_Screen6F:
{
    db $08, $0D, $0E ; SPRITE 0E   | xy: { 0x0D0, 0x080 }
    db $08, $0F, $0E ; SPRITE 0E   | xy: { 0x0F0, 0x080 }
    db $0B, $0E, $0E ; SPRITE 0E   | xy: { 0x0E0, 0x0B0 }
    db $0C, $17, $00 ; SPRITE 00   | xy: { 0x170, 0x0C0 }
    db $17, $09, $D3 ; SPRITE D3   | xy: { 0x090, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CDE1-$04CE05 DATA
Overworld_Sprites_Screen70:
{
    db $1B, $21, $00 ; SPRITE 00   | xy: { 0x210, 0x1B0 }
    db $1C, $2B, $55 ; SPRITE 55   | xy: { 0x2B0, 0x1C0 }
    db $21, $12, $55 ; SPRITE 55   | xy: { 0x120, 0x210 }
    db $24, $1B, $CF ; SPRITE CF   | xy: { 0x1B0, 0x240 }
    db $27, $10, $CF ; SPRITE CF   | xy: { 0x100, 0x270 }
    db $28, $07, $00 ; SPRITE 00   | xy: { 0x070, 0x280 }
    db $2B, $16, $55 ; SPRITE 55   | xy: { 0x160, 0x2B0 }
    db $2E, $1E, $55 ; SPRITE 55   | xy: { 0x1E0, 0x2E0 }
    db $33, $17, $CF ; SPRITE CF   | xy: { 0x170, 0x330 }
    db $38, $11, $55 ; SPRITE 55   | xy: { 0x110, 0x380 }
    db $2B, $23, $55 ; SPRITE 55   | xy: { 0x230, 0x2B0 }
    db $2C, $27, $CF ; SPRITE CF   | xy: { 0x270, 0x2C0 }
    db $FF ; END
}

; ==============================================================================

; $04CE06-$04CE15 DATA
Overworld_Sprites_Screen72:
{
    db $0B, $1B, $25 ; SPRITE 25   | xy: { 0x1B0, 0x0B0 }
    db $0D, $10, $41 ; SPRITE 41   | xy: { 0x100, 0x0D0 }
    db $0E, $13, $41 ; SPRITE 41   | xy: { 0x130, 0x0E0 }
    db $14, $1A, $25 ; SPRITE 25   | xy: { 0x1A0, 0x140 }
    db $17, $0B, $22 ; SPRITE 22   | xy: { 0x0B0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CE16-$04CE25 DATA
Overworld_Sprites_Screen73:
{
    db $0C, $17, $AA ; SPRITE AA   | xy: { 0x170, 0x0C0 }
    db $0D, $09, $12 ; SPRITE 12   | xy: { 0x090, 0x0D0 }
    db $0E, $14, $A8 ; SPRITE A8   | xy: { 0x140, 0x0E0 }
    db $1A, $15, $A8 ; SPRITE A8   | xy: { 0x150, 0x1A0 }
    db $1B, $1B, $A9 ; SPRITE A9   | xy: { 0x1B0, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04CE26-$04CE3B DATA
Overworld_Sprites_Screen74:
{
    db $0D, $0B, $12 ; SPRITE 12   | xy: { 0x0B0, 0x0D0 }
    db $0E, $17, $33 ; SPRITE 33   | xy: { 0x170, 0x0E0 }
    db $11, $10, $A8 ; SPRITE A8   | xy: { 0x100, 0x110 }
    db $11, $15, $12 ; SPRITE 12   | xy: { 0x150, 0x110 }
    db $12, $0A, $AA ; SPRITE AA   | xy: { 0x0A0, 0x120 }
    db $14, $0E, $AC ; SPRITE AC   | xy: { 0x0E0, 0x140 }
    db $17, $11, $12 ; SPRITE 12   | xy: { 0x110, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CE3C-$04CE7E DATA
Overworld_Sprites_Screen75:
{
    db $05, $0A, $D3 ; SPRITE D3   | xy: { 0x0A0, 0x050 }
    db $07, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x070 }
    db $09, $0B, $41 ; SPRITE 41   | xy: { 0x0B0, 0x090 }
    db $13, $07, $08 ; SPRITE 08   | xy: { 0x070, 0x130 }
    db $16, $18, $A8 ; SPRITE A8   | xy: { 0x180, 0x160 }
    db $17, $09, $AA ; SPRITE AA   | xy: { 0x090, 0x170 }
    db $0C, $30, $55 ; SPRITE 55   | xy: { 0x300, 0x0C0 }
    db $11, $29, $A9 ; SPRITE A9   | xy: { 0x290, 0x110 }
    db $15, $36, $A8 ; SPRITE A8   | xy: { 0x360, 0x150 }
    db $1F, $31, $AA ; SPRITE AA   | xy: { 0x310, 0x1F0 }
    db $22, $1B, $55 ; SPRITE 55   | xy: { 0x1B0, 0x220 }
    db $28, $14, $A8 ; SPRITE A8   | xy: { 0x140, 0x280 }
    db $2E, $16, $AA ; SPRITE AA   | xy: { 0x160, 0x2E0 }
    db $32, $19, $A8 ; SPRITE A8   | xy: { 0x190, 0x320 }
    db $35, $0A, $A9 ; SPRITE A9   | xy: { 0x0A0, 0x350 }
    db $39, $08, $22 ; SPRITE 22   | xy: { 0x080, 0x390 }
    db $39, $1B, $55 ; SPRITE 55   | xy: { 0x1B0, 0x390 }
    db $26, $2A, $AA ; SPRITE AA   | xy: { 0x2A0, 0x260 }
    db $28, $32, $A8 ; SPRITE A8   | xy: { 0x320, 0x280 }
    db $2C, $2A, $55 ; SPRITE 55   | xy: { 0x2A0, 0x2C0 }
    db $35, $32, $55 ; SPRITE 55   | xy: { 0x320, 0x350 }
    db $39, $37, $08 ; SPRITE 08   | xy: { 0x370, 0x390 }
    db $FF ; END
}

; ==============================================================================

; $04CE7F-$04CE91 DATA
Overworld_Sprites_Screen77:
{
    db $08, $11, $08 ; SPRITE 08   | xy: { 0x110, 0x080 }
    db $0A, $09, $D3 ; SPRITE D3   | xy: { 0x090, 0x0A0 }
    db $0B, $0D, $A9 ; SPRITE A9   | xy: { 0x0D0, 0x0B0 }
    db $11, $18, $08 ; SPRITE 08   | xy: { 0x180, 0x110 }
    db $12, $07, $55 ; SPRITE 55   | xy: { 0x070, 0x120 }
    db $19, $12, $55 ; SPRITE 55   | xy: { 0x120, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CE92-$04CE9E DATA
Overworld_Sprites_Screen7A:
{
    db $07, $06, $11 ; SPRITE 11   | xy: { 0x060, 0x070 }
    db $09, $16, $22 ; SPRITE 22   | xy: { 0x160, 0x090 }
    db $0B, $14, $22 ; SPRITE 22   | xy: { 0x140, 0x0B0 }
    db $0B, $16, $22 ; SPRITE 22   | xy: { 0x160, 0x0B0 }
    db $FF ; END
}

; ==============================================================================

; $04CE9F-$04CEB1 DATA
Overworld_Sprites_Screen7B:
{
    db $06, $12, $A9 ; SPRITE A9   | xy: { 0x120, 0x060 }
    db $0A, $16, $AA ; SPRITE AA   | xy: { 0x160, 0x0A0 }
    db $0F, $0D, $12 ; SPRITE 12   | xy: { 0x0D0, 0x0F0 }
    db $10, $0A, $D3 ; SPRITE D3   | xy: { 0x0A0, 0x100 }
    db $14, $13, $12 ; SPRITE 12   | xy: { 0x130, 0x140 }
    db $18, $16, $22 ; SPRITE 22   | xy: { 0x160, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04CEB2-$04CEC4 DATA
Overworld_Sprites_Screen7C:
{
    db $05, $03, $D3 ; SPRITE D3   | xy: { 0x030, 0x050 }
    db $06, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x060 }
    db $06, $0F, $33 ; SPRITE 33   | xy: { 0x0F0, 0x060 }
    db $11, $11, $11 ; SPRITE 11   | xy: { 0x110, 0x110 }
    db $15, $18, $22 ; SPRITE 22   | xy: { 0x180, 0x150 }
    db $19, $16, $22 ; SPRITE 22   | xy: { 0x160, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04CEC5-$04CEDA DATA
Overworld_Sprites_Screen7F:
{
    db $06, $10, $A8 ; SPRITE A8   | xy: { 0x100, 0x060 }
    db $06, $16, $08 ; SPRITE 08   | xy: { 0x160, 0x060 }
    db $0C, $07, $BA ; SPRITE BA   | xy: { 0x070, 0x0C0 }
    db $0E, $07, $55 ; SPRITE 55   | xy: { 0x070, 0x0E0 }
    db $13, $0D, $A8 ; SPRITE A8   | xy: { 0x0D0, 0x130 }
    db $14, $16, $AA ; SPRITE AA   | xy: { 0x160, 0x140 }
    db $17, $0F, $08 ; SPRITE 08   | xy: { 0x0F0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04CEDB-$04CEF3 DATA
Overworld_Sprites_Screen80:
{
    db $08, $07, $62 ; SPRITE 62   | xy: { 0x070, 0x080 }
    db $0A, $07, $B3 ; SPRITE B3   | xy: { 0x070, 0x0A0 }
    db $14, $0F, $5A ; SPRITE 5A   | xy: { 0x0F0, 0x140 }
    db $16, $00, $59 ; SPRITE 59   | xy: { 0x000, 0x160 }
    db $18, $02, $5A ; SPRITE 5A   | xy: { 0x020, 0x180 }
    db $1A, $0E, $59 ; SPRITE 59   | xy: { 0x0E0, 0x1A0 }
    db $1B, $0F, $5A ; SPRITE 5A   | xy: { 0x0F0, 0x1B0 }
    db $04, $16, $2B ; SPRITE 2B   | xy: { 0x160, 0x040 }
    db $FF ; END
}

; ==============================================================================

; $04CEF4-$04CF4B DATA
Overworld_Sprites_Screen81:
{
    db $26, $1B, $EB ; SPRITE EB   | xy: { 0x1B0, 0x260 }
    db $06, $0A, $56 ; SPRITE 56   | xy: { 0x0A0, 0x060 }
    db $06, $1C, $56 ; SPRITE 56   | xy: { 0x1C0, 0x060 }
    db $07, $11, $55 ; SPRITE 55   | xy: { 0x110, 0x070 }
    db $0A, $16, $56 ; SPRITE 56   | xy: { 0x160, 0x0A0 }
    db $0A, $1A, $55 ; SPRITE 55   | xy: { 0x1A0, 0x0A0 }
    db $0C, $09, $55 ; SPRITE 55   | xy: { 0x090, 0x0C0 }
    db $0D, $12, $55 ; SPRITE 55   | xy: { 0x120, 0x0D0 }
    db $12, $1A, $56 ; SPRITE 56   | xy: { 0x1A0, 0x120 }
    db $13, $07, $56 ; SPRITE 56   | xy: { 0x070, 0x130 }
    db $13, $14, $56 ; SPRITE 56   | xy: { 0x140, 0x130 }
    db $18, $08, $56 ; SPRITE 56   | xy: { 0x080, 0x180 }
    db $1C, $04, $56 ; SPRITE 56   | xy: { 0x040, 0x1C0 }
    db $04, $3B, $52 ; SPRITE 52   | xy: { 0x3B0, 0x040 }
    db $08, $27, $55 ; SPRITE 55   | xy: { 0x270, 0x080 }
    db $08, $2D, $55 ; SPRITE 55   | xy: { 0x2D0, 0x080 }
    db $0E, $22, $56 ; SPRITE 56   | xy: { 0x220, 0x0E0 }
    db $0E, $2D, $55 ; SPRITE 55   | xy: { 0x2D0, 0x0E0 }
    db $14, $21, $55 ; SPRITE 55   | xy: { 0x210, 0x140 }
    db $20, $0D, $56 ; SPRITE 56   | xy: { 0x0D0, 0x200 }
    db $31, $08, $56 ; SPRITE 56   | xy: { 0x080, 0x310 }
    db $31, $14, $55 ; SPRITE 55   | xy: { 0x140, 0x310 }
    db $33, $0C, $56 ; SPRITE 56   | xy: { 0x0C0, 0x330 }
    db $35, $0E, $55 ; SPRITE 55   | xy: { 0x0E0, 0x350 }
    db $38, $08, $56 ; SPRITE 56   | xy: { 0x080, 0x380 }
    db $28, $3B, $56 ; SPRITE 56   | xy: { 0x3B0, 0x280 }
    db $2B, $3A, $56 ; SPRITE 56   | xy: { 0x3A0, 0x2B0 }
    db $35, $2D, $56 ; SPRITE 56   | xy: { 0x2D0, 0x350 }
    db $36, $37, $56 ; SPRITE 56   | xy: { 0x370, 0x360 }
    db $FF ; END
}

; ==============================================================================

; $04CF4C-$04CF79 DATA
Overworld_Sprites_Screen00_1:
{
    db $12, $07, $E8 ; SPRITE E8   | xy: { 0x070, 0x120 }
    db $0B, $12, $00 ; SPRITE 00   | xy: { 0x120, 0x0B0 }
    db $15, $1E, $E7 ; SPRITE E7   | xy: { 0x1E0, 0x150 }
    db $06, $28, $E8 ; SPRITE E8   | xy: { 0x280, 0x060 }
    db $0A, $31, $0D ; SPRITE 0D   | xy: { 0x310, 0x0A0 }
    db $0A, $2D, $00 ; SPRITE 00   | xy: { 0x2D0, 0x0A0 }
    db $10, $2A, $17 ; SPRITE 17   | xy: { 0x2A0, 0x100 }
    db $15, $39, $E8 ; SPRITE E8   | xy: { 0x390, 0x150 }
    db $22, $0E, $C4 ; SPRITE C4   | xy: { 0x0E0, 0x220 }
    db $2D, $1E, $17 ; SPRITE 17   | xy: { 0x1E0, 0x2D0 }
    db $25, $29, $79 ; SPRITE 79   | xy: { 0x290, 0x250 }
    db $27, $2A, $33 ; SPRITE 33   | xy: { 0x2A0, 0x270 }
    db $2D, $36, $00 ; SPRITE 00   | xy: { 0x360, 0x2D0 }
    db $35, $25, $E8 ; SPRITE E8   | xy: { 0x250, 0x350 }
    db $35, $29, $C4 ; SPRITE C4   | xy: { 0x290, 0x350 }
    db $FF ; END
}

; ==============================================================================

; $04CF7A-$04CF83 DATA
Overworld_Sprites_Screen02_1:
{
    db $13, $04, $0D ; SPRITE 0D   | xy: { 0x040, 0x130 }
    db $13, $0C, $2C ; SPRITE 2C   | xy: { 0x0C0, 0x130 }
    db $1A, $0D, $17 ; SPRITE 17   | xy: { 0x0D0, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04CF84-$04CFA5 DATA
Overworld_Sprites_Screen03_1:
{
    db $00, $00, $F4 ; OVERLORD 02 | xy: { 0x000, 0x000 }
    db $04, $0B, $F2 ; SPRITE F2   | xy: { 0x0B0, 0x040 }
    db $0C, $27, $27 ; SPRITE 27   | xy: { 0x270, 0x0C0 }
    db $16, $22, $EB ; SPRITE EB   | xy: { 0x220, 0x160 }
    db $35, $0A, $27 ; SPRITE 27   | xy: { 0x0A0, 0x350 }
    db $36, $06, $27 ; SPRITE 27   | xy: { 0x060, 0x360 }
    db $3B, $0D, $27 ; SPRITE 27   | xy: { 0x0D0, 0x3B0 }
    db $3B, $12, $F3 ; OVERLORD 01 | xy: { 0x120, 0x3B0 }
    db $2D, $2C, $27 ; SPRITE 27   | xy: { 0x2C0, 0x2D0 }
    db $33, $34, $27 ; SPRITE 27   | xy: { 0x340, 0x330 }
    db $34, $2F, $27 ; SPRITE 27   | xy: { 0x2F0, 0x340 }
    db $FF ; END
}

; ==============================================================================

; $04CFA6-$04CFCD DATA
Overworld_Sprites_Screen05_1:
{
    db $0E, $1E, $27 ; SPRITE 27   | xy: { 0x1E0, 0x0E0 }
    db $0F, $1F, $C9 ; SPRITE C9   | xy: { 0x1F0, 0x0F0 }
    db $03, $2F, $EB ; SPRITE EB   | xy: { 0x2F0, 0x030 }
    db $0D, $35, $27 ; SPRITE 27   | xy: { 0x350, 0x0D0 }
    db $0F, $29, $C9 ; SPRITE C9   | xy: { 0x290, 0x0F0 }
    db $0F, $35, $27 ; SPRITE 27   | xy: { 0x350, 0x0F0 }
    db $10, $34, $E3 ; SPRITE E3   | xy: { 0x340, 0x100 }
    db $31, $1E, $C9 ; SPRITE C9   | xy: { 0x1E0, 0x310 }
    db $2A, $35, $C9 ; SPRITE C9   | xy: { 0x350, 0x2A0 }
    db $2F, $2A, $27 ; SPRITE 27   | xy: { 0x2A0, 0x2F0 }
    db $2F, $2F, $C9 ; SPRITE C9   | xy: { 0x2F0, 0x2F0 }
    db $36, $29, $27 ; SPRITE 27   | xy: { 0x290, 0x360 }
    db $36, $36, $27 ; SPRITE 27   | xy: { 0x360, 0x360 }
    db $FF ; END
}

; ==============================================================================

; $04CFCE-$04CFDD DATA
Overworld_Sprites_Screen07_1:
{
    db $07, $0E, $27 ; SPRITE 27   | xy: { 0x0E0, 0x070 }
    db $0D, $0A, $27 ; SPRITE 27   | xy: { 0x0A0, 0x0D0 }
    db $15, $17, $27 ; SPRITE 27   | xy: { 0x170, 0x150 }
    db $16, $0F, $27 ; SPRITE 27   | xy: { 0x0F0, 0x160 }
    db $16, $12, $27 ; SPRITE 27   | xy: { 0x120, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04CFDE-$04CFFC DATA
Overworld_Sprites_Screen0A_1:
{
    db $04, $0E, $79 ; SPRITE 79   | xy: { 0x0E0, 0x040 }
    db $06, $0E, $33 ; SPRITE 33   | xy: { 0x0E0, 0x060 }
    db $09, $05, $00 ; SPRITE 00   | xy: { 0x050, 0x090 }
    db $0D, $10, $0D ; SPRITE 0D   | xy: { 0x100, 0x0D0 }
    db $0E, $0B, $0D ; SPRITE 0D   | xy: { 0x0B0, 0x0E0 }
    db $16, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x160 }
    db $16, $0E, $17 ; SPRITE 17   | xy: { 0x0E0, 0x160 }
    db $16, $16, $0D ; SPRITE 0D   | xy: { 0x160, 0x160 }
    db $17, $11, $00 ; SPRITE 00   | xy: { 0x110, 0x170 }
    db $1A, $19, $AC ; SPRITE AC   | xy: { 0x190, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04CFFD-$04D012 DATA
Overworld_Sprites_Screen0F_1:
{
    db $02, $06, $37 ; SPRITE 37   | xy: { 0x060, 0x020 }
    db $0D, $0D, $58 ; SPRITE 58   | xy: { 0x0D0, 0x0D0 }
    db $10, $05, $55 ; SPRITE 55   | xy: { 0x050, 0x100 }
    db $12, $11, $58 ; SPRITE 58   | xy: { 0x110, 0x120 }
    db $13, $08, $BA ; SPRITE BA   | xy: { 0x080, 0x130 }
    db $15, $1C, $00 ; SPRITE 00   | xy: { 0x1C0, 0x150 }
    db $17, $0E, $0A ; SPRITE 0A   | xy: { 0x0E0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D013-$04D01F DATA
Overworld_Sprites_Screen10_1:
{
    db $0C, $05, $42 ; SPRITE 42   | xy: { 0x050, 0x0C0 }
    db $0C, $07, $AC ; SPRITE AC   | xy: { 0x070, 0x0C0 }
    db $0F, $17, $E0 ; SPRITE E0   | xy: { 0x170, 0x0F0 }
    db $18, $08, $42 ; SPRITE 42   | xy: { 0x080, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D020-$04D02C DATA
Overworld_Sprites_Screen11_1:
{
    db $0C, $17, $42 ; SPRITE 42   | xy: { 0x170, 0x0C0 }
    db $0D, $1A, $42 ; SPRITE 42   | xy: { 0x1A0, 0x0D0 }
    db $10, $08, $DC ; SPRITE DC   | xy: { 0x080, 0x100 }
    db $17, $08, $0B ; SPRITE 0B   | xy: { 0x080, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D02D-$04D039 DATA
Overworld_Sprites_Screen12_1:
{
    db $0E, $15, $42 ; SPRITE 42   | xy: { 0x150, 0x0E0 }
    db $10, $07, $42 ; SPRITE 42   | xy: { 0x070, 0x100 }
    db $10, $0F, $BA ; SPRITE BA   | xy: { 0x0F0, 0x100 }
    db $15, $15, $42 ; SPRITE 42   | xy: { 0x150, 0x150 }
    db $FF ; END
}

; ==============================================================================

; $04D03A-$04D040 DATA
Overworld_Sprites_Screen13_1:
{
    db $09, $18, $AC ; SPRITE AC   | xy: { 0x180, 0x090 }
    db $17, $11, $42 ; SPRITE 42   | xy: { 0x110, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D041-$04D050 DATA
Overworld_Sprites_Screen14_1:
{
    db $11, $15, $48 ; SPRITE 48   | xy: { 0x150, 0x110 }
    db $19, $11, $42 ; SPRITE 42   | xy: { 0x110, 0x190 }
    db $0C, $08, $C5 ; SPRITE C5   | xy: { 0x080, 0x0C0 }
    db $11, $17, $C5 ; SPRITE C5   | xy: { 0x170, 0x110 }
    db $0E, $12, $C5 ; SPRITE C5   | xy: { 0x120, 0x0E0 }
    db $FF ; END
}

; ==============================================================================

; $04D051-$04D05D DATA
Overworld_Sprites_Screen15_1:
{
    db $09, $11, $BA ; SPRITE BA   | xy: { 0x110, 0x090 }
    db $0E, $16, $41 ; SPRITE 41   | xy: { 0x160, 0x0E0 }
    db $0F, $1B, $E3 ; SPRITE E3   | xy: { 0x1B0, 0x0F0 }
    db $17, $0B, $41 ; SPRITE 41   | xy: { 0x0B0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D05E-$04D067 DATA
Overworld_Sprites_Screen16_1:
{
    db $0A, $0D, $0D ; SPRITE 0D   | xy: { 0x0D0, 0x0A0 }
    db $15, $0F, $36 ; SPRITE 36   | xy: { 0x0F0, 0x150 }
    db $18, $06, $0D ; SPRITE 0D   | xy: { 0x060, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D068-$04D077 DATA
Overworld_Sprites_Screen17_1:
{
    db $08, $18, $0D ; SPRITE 0D   | xy: { 0x180, 0x080 }
    db $0A, $17, $0D ; SPRITE 0D   | xy: { 0x170, 0x0A0 }
    db $0B, $0D, $0D ; SPRITE 0D   | xy: { 0x0D0, 0x0B0 }
    db $0C, $16, $0D ; SPRITE 0D   | xy: { 0x160, 0x0C0 }
    db $16, $08, $0D ; SPRITE 0D   | xy: { 0x080, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D078-$04D09F DATA
Overworld_Sprites_Screen18_1:
{
    db $0A, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x0A0 }
    db $17, $0C, $F3 ; OVERLORD 01 | xy: { 0x0C0, 0x170 }
    db $16, $18, $75 ; SPRITE 75   | xy: { 0x180, 0x160 }
    db $1C, $0E, $3D ; SPRITE 3D   | xy: { 0x0E0, 0x1C0 }
    db $18, $20, $1D ; SPRITE 1D   | xy: { 0x200, 0x180 }
    db $1B, $34, $F3 ; OVERLORD 01 | xy: { 0x340, 0x1B0 }
    db $2E, $1D, $74 ; SPRITE 74   | xy: { 0x1D0, 0x2E0 }
    db $2C, $19, $2A ; SPRITE 2A   | xy: { 0x190, 0x2C0 }
    db $31, $18, $3C ; SPRITE 3C   | xy: { 0x180, 0x310 }
    db $35, $16, $0B ; SPRITE 0B   | xy: { 0x160, 0x350 }
    db $36, $18, $0B ; SPRITE 0B   | xy: { 0x180, 0x360 }
    db $20, $33, $34 ; SPRITE 34   | xy: { 0x330, 0x200 }
    db $33, $36, $DA ; SPRITE DA   | xy: { 0x360, 0x330 }
    db $FF ; END
}

; ==============================================================================

; $04D0A0-$04D0B2 DATA
Overworld_Sprites_Screen1A_1:
{
    db $0C, $14, $41 ; SPRITE 41   | xy: { 0x140, 0x0C0 }
    db $0E, $0C, $42 ; SPRITE 42   | xy: { 0x0C0, 0x0E0 }
    db $11, $0D, $E3 ; SPRITE E3   | xy: { 0x0D0, 0x110 }
    db $17, $17, $DA ; SPRITE DA   | xy: { 0x170, 0x170 }
    db $18, $0A, $D8 ; SPRITE D8   | xy: { 0x0A0, 0x180 }
    db $18, $0F, $43 ; SPRITE 43   | xy: { 0x0F0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D0B3-$04D0DA DATA
Overworld_Sprites_Screen1B_1:
{
    db $06, $1F, $40 ; SPRITE 40   | xy: { 0x1F0, 0x060 }
    db $11, $09, $49 ; SPRITE 49   | xy: { 0x090, 0x110 }
    db $13, $0A, $49 ; SPRITE 49   | xy: { 0x0A0, 0x130 }
    db $14, $16, $AC ; SPRITE AC   | xy: { 0x160, 0x140 }
    db $19, $0E, $4A ; SPRITE 4A   | xy: { 0x0E0, 0x190 }
    db $1A, $1F, $41 ; SPRITE 41   | xy: { 0x1F0, 0x1A0 }
    db $17, $29, $33 ; SPRITE 33   | xy: { 0x290, 0x170 }
    db $19, $31, $4A ; SPRITE 4A   | xy: { 0x310, 0x190 }
    db $1A, $20, $41 ; SPRITE 41   | xy: { 0x200, 0x1A0 }
    db $25, $0E, $4A ; SPRITE 4A   | xy: { 0x0E0, 0x250 }
    db $2D, $14, $42 ; SPRITE 42   | xy: { 0x140, 0x2D0 }
    db $2D, $26, $48 ; SPRITE 48   | xy: { 0x260, 0x2D0 }
    db $32, $21, $48 ; SPRITE 48   | xy: { 0x210, 0x320 }
    db $FF ; END
}

; ==============================================================================

; $04D0DB-$04D0EA DATA
Overworld_Sprites_Screen1D_1:
{
    db $06, $0B, $AC ; SPRITE AC   | xy: { 0x0B0, 0x060 }
    db $0C, $1B, $46 ; SPRITE 46   | xy: { 0x1B0, 0x0C0 }
    db $0D, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x0D0 }
    db $0F, $1B, $46 ; SPRITE 46   | xy: { 0x1B0, 0x0F0 }
    db $12, $07, $58 ; SPRITE 58   | xy: { 0x070, 0x120 }
    db $FF ; END
}

; ==============================================================================

; $04D0EB-$04D124 DATA
Overworld_Sprites_Screen1E_1:
{
    db $08, $13, $51 ; SPRITE 51   | xy: { 0x130, 0x080 }
    db $0E, $0E, $51 ; SPRITE 51   | xy: { 0x0E0, 0x0E0 }
    db $1A, $11, $08 ; SPRITE 08   | xy: { 0x110, 0x1A0 }
    db $1A, $19, $51 ; SPRITE 51   | xy: { 0x190, 0x1A0 }
    db $09, $33, $51 ; SPRITE 51   | xy: { 0x330, 0x090 }
    db $09, $37, $51 ; SPRITE 51   | xy: { 0x370, 0x090 }
    db $10, $31, $41 ; SPRITE 41   | xy: { 0x310, 0x100 }
    db $17, $2F, $51 ; SPRITE 51   | xy: { 0x2F0, 0x170 }
    db $1D, $35, $0A ; SPRITE 0A   | xy: { 0x350, 0x1D0 }
    db $25, $0F, $0A ; SPRITE 0A   | xy: { 0x0F0, 0x250 }
    db $28, $09, $08 ; SPRITE 08   | xy: { 0x090, 0x280 }
    db $2C, $15, $08 ; SPRITE 08   | xy: { 0x150, 0x2C0 }
    db $33, $14, $51 ; SPRITE 51   | xy: { 0x140, 0x330 }
    db $33, $17, $51 ; SPRITE 51   | xy: { 0x170, 0x330 }
    db $36, $09, $08 ; SPRITE 08   | xy: { 0x090, 0x360 }
    db $25, $24, $51 ; SPRITE 51   | xy: { 0x240, 0x250 }
    db $29, $28, $51 ; SPRITE 51   | xy: { 0x280, 0x290 }
    db $29, $3D, $51 ; SPRITE 51   | xy: { 0x3D0, 0x290 }
    db $3B, $2E, $08 ; SPRITE 08   | xy: { 0x2E0, 0x3B0 }
    db $FF ; END
}

; ==============================================================================

; $04D125-$04D12E DATA
Overworld_Sprites_Screen22_1:
{
    db $04, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x040 }
    db $12, $17, $42 ; SPRITE 42   | xy: { 0x170, 0x120 }
    db $14, $12, $0B ; SPRITE 0B   | xy: { 0x120, 0x140 }
    db $FF ; END
}

; ==============================================================================

; $04D12F-$04D147 DATA
Overworld_Sprites_Screen25_1:
{
    db $08, $0F, $08 ; SPRITE 08   | xy: { 0x0F0, 0x080 }
    db $0C, $05, $08 ; SPRITE 08   | xy: { 0x050, 0x0C0 }
    db $0C, $14, $08 ; SPRITE 08   | xy: { 0x140, 0x0C0 }
    db $0D, $10, $08 ; SPRITE 08   | xy: { 0x100, 0x0D0 }
    db $11, $0C, $08 ; SPRITE 08   | xy: { 0x0C0, 0x110 }
    db $16, $18, $08 ; SPRITE 08   | xy: { 0x180, 0x160 }
    db $17, $08, $08 ; SPRITE 08   | xy: { 0x080, 0x170 }
    db $17, $10, $08 ; SPRITE 08   | xy: { 0x100, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D148-$04D151 DATA
Overworld_Sprites_Screen28_1:
{
    db $13, $07, $EB ; SPRITE EB   | xy: { 0x070, 0x130 }
    db $12, $08, $30 ; SPRITE 30   | xy: { 0x080, 0x120 }
    db $18, $19, $2F ; SPRITE 2F   | xy: { 0x190, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D152-$04D167 DATA
Overworld_Sprites_Screen2A_1:
{
    db $09, $09, $1D ; SPRITE 1D   | xy: { 0x090, 0x090 }
    db $0C, $0E, $9E ; SPRITE 9E   | xy: { 0x0E0, 0x0C0 }
    db $0E, $0D, $A0 ; SPRITE A0   | xy: { 0x0D0, 0x0E0 }
    db $0E, $0E, $2E ; SPRITE 2E   | xy: { 0x0E0, 0x0E0 }
    db $0E, $11, $A0 ; SPRITE A0   | xy: { 0x110, 0x0E0 }
    db $0F, $0C, $9F ; SPRITE 9F   | xy: { 0x0C0, 0x0F0 }
    db $10, $11, $9F ; SPRITE 9F   | xy: { 0x110, 0x100 }
    db $FF ; END
}

; ==============================================================================

; $04D168-$04D174 DATA
Overworld_Sprites_Screen2B_1:
{
    db $0D, $16, $E3 ; SPRITE E3   | xy: { 0x160, 0x0D0 }
    db $11, $14, $42 ; SPRITE 42   | xy: { 0x140, 0x110 }
    db $15, $14, $42 ; SPRITE 42   | xy: { 0x140, 0x150 }
    db $17, $10, $42 ; SPRITE 42   | xy: { 0x100, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D175-$04D17B DATA
Overworld_Sprites_Screen2C_1:
{
    db $14, $18, $42 ; SPRITE 42   | xy: { 0x180, 0x140 }
    db $19, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D17C-$04D185 DATA
Overworld_Sprites_Screen2D_1:
{
    db $0B, $13, $42 ; SPRITE 42   | xy: { 0x130, 0x0B0 }
    db $10, $10, $46 ; SPRITE 46   | xy: { 0x100, 0x100 }
    db $16, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D186-$04D192 DATA
Overworld_Sprites_Screen2E_1:
{
    db $0C, $0E, $41 ; SPRITE 41   | xy: { 0x0E0, 0x0C0 }
    db $0E, $17, $41 ; SPRITE 41   | xy: { 0x170, 0x0E0 }
    db $12, $05, $55 ; SPRITE 55   | xy: { 0x050, 0x120 }
    db $17, $19, $08 ; SPRITE 08   | xy: { 0x190, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D193-$04D19C DATA
Overworld_Sprites_Screen2F_1:
{
    db $0C, $0F, $41 ; SPRITE 41   | xy: { 0x0F0, 0x0C0 }
    db $17, $07, $51 ; SPRITE 51   | xy: { 0x070, 0x170 }
    db $17, $0C, $51 ; SPRITE 51   | xy: { 0x0C0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D19D-$04D1E2 DATA
Overworld_Sprites_Screen30_1:
{
    db $14, $12, $57 ; SPRITE 57   | xy: { 0x120, 0x140 }
    db $19, $12, $B3 ; SPRITE B3   | xy: { 0x120, 0x190 }
    db $1C, $0E, $57 ; SPRITE 57   | xy: { 0x0E0, 0x1C0 }
    db $1C, $16, $57 ; SPRITE 57   | xy: { 0x160, 0x1C0 }
    db $19, $27, $4C ; SPRITE 4C   | xy: { 0x270, 0x190 }
    db $1C, $22, $01 ; SPRITE 01   | xy: { 0x220, 0x1C0 }
    db $1F, $2A, $4C ; SPRITE 4C   | xy: { 0x2A0, 0x1F0 }
    db $26, $1D, $4C ; SPRITE 4C   | xy: { 0x1D0, 0x260 }
    db $29, $07, $01 ; SPRITE 01   | xy: { 0x070, 0x290 }
    db $29, $0F, $4C ; SPRITE 4C   | xy: { 0x0F0, 0x290 }
    db $2A, $06, $EB ; SPRITE EB   | xy: { 0x060, 0x2A0 }
    db $2C, $1B, $4C ; SPRITE 4C   | xy: { 0x1B0, 0x2C0 }
    db $30, $0A, $4C ; SPRITE 4C   | xy: { 0x0A0, 0x300 }
    db $35, $14, $4C ; SPRITE 4C   | xy: { 0x140, 0x350 }
    db $2B, $37, $F2 ; SPRITE F2   | xy: { 0x370, 0x2B0 }
    db $21, $36, $D4 ; SPRITE D4   | xy: { 0x360, 0x210 }
    db $24, $22, $4C ; SPRITE 4C   | xy: { 0x220, 0x240 }
    db $25, $29, $D4 ; SPRITE D4   | xy: { 0x290, 0x250 }
    db $2C, $20, $4C ; SPRITE 4C   | xy: { 0x200, 0x2C0 }
    db $32, $23, $4C ; SPRITE 4C   | xy: { 0x230, 0x320 }
    db $32, $30, $D4 ; SPRITE D4   | xy: { 0x300, 0x320 }
    db $33, $34, $01 ; SPRITE 01   | xy: { 0x340, 0x330 }
    db $3B, $2D, $D4 ; SPRITE D4   | xy: { 0x2D0, 0x3B0 }
    db $FF ; END
}

; ==============================================================================

; $04D1E3-$04D1EF DATA
Overworld_Sprites_Screen32_1:
{
    db $09, $1A, $D8 ; SPRITE D8   | xy: { 0x1A0, 0x090 }
    db $0B, $0B, $41 ; SPRITE 41   | xy: { 0x0B0, 0x0B0 }
    db $0B, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x0B0 }
    db $12, $19, $E3 ; SPRITE E3   | xy: { 0x190, 0x120 }
    db $FF ; END
}

; ==============================================================================

; $04D1F0-$04D1FC DATA
Overworld_Sprites_Screen33_1:
{
    db $0B, $15, $47 ; SPRITE 47   | xy: { 0x150, 0x0B0 }
    db $0E, $09, $46 ; SPRITE 46   | xy: { 0x090, 0x0E0 }
    db $12, $17, $BA ; SPRITE BA   | xy: { 0x170, 0x120 }
    db $1B, $1A, $08 ; SPRITE 08   | xy: { 0x1A0, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04D1FD-$04D212 DATA
Overworld_Sprites_Screen34_1:
{
    db $0D, $0B, $46 ; SPRITE 46   | xy: { 0x0B0, 0x0D0 }
    db $11, $15, $4D ; SPRITE 4D   | xy: { 0x150, 0x110 }
    db $12, $11, $47 ; SPRITE 47   | xy: { 0x110, 0x120 }
    db $13, $08, $00 ; SPRITE 00   | xy: { 0x080, 0x130 }
    db $13, $0E, $E3 ; SPRITE E3   | xy: { 0x0E0, 0x130 }
    db $17, $15, $47 ; SPRITE 47   | xy: { 0x150, 0x170 }
    db $18, $0C, $46 ; SPRITE 46   | xy: { 0x0C0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D213-$04D258 DATA
Overworld_Sprites_Screen35_1:
{
    db $07, $0E, $00 ; SPRITE 00   | xy: { 0x0E0, 0x070 }
    db $09, $0D, $08 ; SPRITE 08   | xy: { 0x0D0, 0x090 }
    db $0C, $0A, $46 ; SPRITE 46   | xy: { 0x0A0, 0x0C0 }
    db $13, $19, $EB ; SPRITE EB   | xy: { 0x190, 0x130 }
    db $14, $19, $0D ; SPRITE 0D   | xy: { 0x190, 0x140 }
    db $17, $07, $58 ; SPRITE 58   | xy: { 0x070, 0x170 }
    db $17, $11, $55 ; SPRITE 55   | xy: { 0x110, 0x170 }
    db $0D, $25, $55 ; SPRITE 55   | xy: { 0x250, 0x0D0 }
    db $1F, $27, $0D ; SPRITE 0D   | xy: { 0x270, 0x1F0 }
    db $1F, $2F, $0D ; SPRITE 0D   | xy: { 0x2F0, 0x1F0 }
    db $35, $0A, $08 ; SPRITE 08   | xy: { 0x0A0, 0x350 }
    db $35, $14, $55 ; SPRITE 55   | xy: { 0x140, 0x350 }
    db $35, $0F, $00 ; SPRITE 00   | xy: { 0x0F0, 0x350 }
    db $39, $0B, $08 ; SPRITE 08   | xy: { 0x0B0, 0x390 }
    db $3A, $19, $0D ; SPRITE 0D   | xy: { 0x190, 0x3A0 }
    db $3B, $11, $58 ; SPRITE 58   | xy: { 0x110, 0x3B0 }
    db $2B, $24, $55 ; SPRITE 55   | xy: { 0x240, 0x2B0 }
    db $2B, $29, $BA ; SPRITE BA   | xy: { 0x290, 0x2B0 }
    db $31, $39, $55 ; SPRITE 55   | xy: { 0x390, 0x310 }
    db $36, $21, $55 ; SPRITE 55   | xy: { 0x210, 0x360 }
    db $37, $32, $0D ; SPRITE 0D   | xy: { 0x320, 0x370 }
    db $39, $34, $0D ; SPRITE 0D   | xy: { 0x340, 0x390 }
    db $3A, $2E, $58 ; SPRITE 58   | xy: { 0x2E0, 0x3A0 }
    db $FF ; END
}

; ==============================================================================

; $04D259-$04D26B DATA
Overworld_Sprites_Screen37_1:
{
    db $08, $08, $58 ; SPRITE 58   | xy: { 0x080, 0x080 }
    db $08, $10, $58 ; SPRITE 58   | xy: { 0x100, 0x080 }
    db $0B, $0F, $58 ; SPRITE 58   | xy: { 0x0F0, 0x0B0 }
    db $11, $16, $58 ; SPRITE 58   | xy: { 0x160, 0x110 }
    db $15, $0C, $00 ; SPRITE 00   | xy: { 0x0C0, 0x150 }
    db $19, $12, $55 ; SPRITE 55   | xy: { 0x120, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D26C-$04D278 DATA
Overworld_Sprites_Screen3A_1:
{
    db $05, $17, $39 ; SPRITE 39   | xy: { 0x170, 0x050 }
    db $09, $0E, $00 ; SPRITE 00   | xy: { 0x0E0, 0x090 }
    db $0A, $0B, $3E ; SPRITE 3E   | xy: { 0x0B0, 0x0A0 }
    db $0E, $18, $3E ; SPRITE 3E   | xy: { 0x180, 0x0E0 }
    db $FF ; END
}

; ==============================================================================

; $04D279-$04D291 DATA
Overworld_Sprites_Screen3B_1:
{
    db $06, $13, $47 ; SPRITE 47   | xy: { 0x130, 0x060 }
    db $0A, $0C, $46 ; SPRITE 46   | xy: { 0x0C0, 0x0A0 }
    db $0D, $13, $D2 ; SPRITE D2   | xy: { 0x130, 0x0D0 }
    db $0B, $08, $00 ; SPRITE 00   | xy: { 0x080, 0x0B0 }
    db $0E, $14, $EB ; SPRITE EB   | xy: { 0x140, 0x0E0 }
    db $10, $1B, $D2 ; SPRITE D2   | xy: { 0x1B0, 0x100 }
    db $14, $0F, $4D ; SPRITE 4D   | xy: { 0x0F0, 0x140 }
    db $1B, $14, $00 ; SPRITE 00   | xy: { 0x140, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04D292-$04D2A7 DATA
Overworld_Sprites_Screen3C_1:
{
    db $0C, $08, $47 ; SPRITE 47   | xy: { 0x080, 0x0C0 }
    db $0F, $14, $08 ; SPRITE 08   | xy: { 0x140, 0x0F0 }
    db $0F, $0E, $00 ; SPRITE 00   | xy: { 0x0E0, 0x0F0 }
    db $11, $09, $17 ; SPRITE 17   | xy: { 0x090, 0x110 }
    db $15, $14, $0A ; SPRITE 0A   | xy: { 0x140, 0x150 }
    db $17, $16, $58 ; SPRITE 58   | xy: { 0x160, 0x170 }
    db $18, $0B, $08 ; SPRITE 08   | xy: { 0x0B0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D2A8-$04D2B7 DATA
Overworld_Sprites_Screen3F_1:
{
    db $04, $11, $08 ; SPRITE 08   | xy: { 0x110, 0x040 }
    db $05, $16, $08 ; SPRITE 08   | xy: { 0x160, 0x050 }
    db $0B, $08, $55 ; SPRITE 55   | xy: { 0x080, 0x0B0 }
    db $0C, $07, $BA ; SPRITE BA   | xy: { 0x070, 0x0C0 }
    db $16, $10, $0F ; SPRITE 0F   | xy: { 0x100, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D2B8-$04D2E2 DATA
Overworld_Sprites_Screen00_2:
{
    db $11, $0F, $41 ; SPRITE 41   | xy: { 0x0F0, 0x110 }
    db $12, $07, $E8 ; SPRITE E8   | xy: { 0x070, 0x120 }
    db $15, $1E, $E7 ; SPRITE E7   | xy: { 0x1E0, 0x150 }
    db $1F, $0D, $C4 ; SPRITE C4   | xy: { 0x0D0, 0x1F0 }
    db $06, $28, $E8 ; SPRITE E8   | xy: { 0x280, 0x060 }
    db $08, $2B, $33 ; SPRITE 33   | xy: { 0x2B0, 0x080 }
    db $08, $33, $41 ; SPRITE 41   | xy: { 0x330, 0x080 }
    db $0A, $2B, $C4 ; SPRITE C4   | xy: { 0x2B0, 0x0A0 }
    db $0A, $31, $0D ; SPRITE 0D   | xy: { 0x310, 0x0A0 }
    db $10, $2A, $17 ; SPRITE 17   | xy: { 0x2A0, 0x100 }
    db $2C, $0D, $17 ; SPRITE 17   | xy: { 0x0D0, 0x2C0 }
    db $33, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x330 }
    db $25, $29, $79 ; SPRITE 79   | xy: { 0x290, 0x250 }
    db $2F, $28, $17 ; SPRITE 17   | xy: { 0x280, 0x2F0 }
    db $FF ; END
}

; ==============================================================================

; $04D2E3-$04D2E6 DATA
Overworld_Sprites_Screen02_2:
{
    db $12, $0D, $3B ; SPRITE 3B   | xy: { 0x0D0, 0x120 }
    db $FF ; END
}

; ==============================================================================

; $04D2E7-$04D314 DATA
Overworld_Sprites_Screen03_2:
{
    db $00, $00, $F4 ; OVERLORD 02 | xy: { 0x000, 0x000 }
    db $04, $0B, $F2 ; SPRITE F2   | xy: { 0x0B0, 0x040 }
    db $1A, $10, $C9 ; SPRITE C9   | xy: { 0x100, 0x1A0 }
    db $1E, $1A, $C9 ; SPRITE C9   | xy: { 0x1A0, 0x1E0 }
    db $0C, $27, $27 ; SPRITE 27   | xy: { 0x270, 0x0C0 }
    db $15, $2C, $C9 ; SPRITE C9   | xy: { 0x2C0, 0x150 }
    db $16, $22, $EB ; SPRITE EB   | xy: { 0x220, 0x160 }
    db $19, $28, $C9 ; SPRITE C9   | xy: { 0x280, 0x190 }
    db $35, $0A, $27 ; SPRITE 27   | xy: { 0x0A0, 0x350 }
    db $36, $06, $27 ; SPRITE 27   | xy: { 0x060, 0x360 }
    db $3B, $0D, $27 ; SPRITE 27   | xy: { 0x0D0, 0x3B0 }
    db $3B, $12, $F3 ; OVERLORD 01 | xy: { 0x120, 0x3B0 }
    db $2D, $2C, $27 ; SPRITE 27   | xy: { 0x2C0, 0x2D0 }
    db $33, $34, $27 ; SPRITE 27   | xy: { 0x340, 0x330 }
    db $34, $2F, $27 ; SPRITE 27   | xy: { 0x2F0, 0x340 }
    db $FF ; END
}

; ==============================================================================

; $04D315-$04D342 DATA
Overworld_Sprites_Screen05_2:
{
    db $0B, $07, $27 ; SPRITE 27   | xy: { 0x070, 0x0B0 }
    db $0D, $08, $C9 ; SPRITE C9   | xy: { 0x080, 0x0D0 }
    db $0E, $1E, $27 ; SPRITE 27   | xy: { 0x1E0, 0x0E0 }
    db $0F, $1F, $C9 ; SPRITE C9   | xy: { 0x1F0, 0x0F0 }
    db $03, $2F, $EB ; SPRITE EB   | xy: { 0x2F0, 0x030 }
    db $0D, $35, $27 ; SPRITE 27   | xy: { 0x350, 0x0D0 }
    db $0F, $29, $C9 ; SPRITE C9   | xy: { 0x290, 0x0F0 }
    db $0F, $35, $27 ; SPRITE 27   | xy: { 0x350, 0x0F0 }
    db $10, $34, $E3 ; SPRITE E3   | xy: { 0x340, 0x100 }
    db $31, $1E, $C9 ; SPRITE C9   | xy: { 0x1E0, 0x310 }
    db $2A, $35, $C9 ; SPRITE C9   | xy: { 0x350, 0x2A0 }
    db $2F, $2A, $27 ; SPRITE 27   | xy: { 0x2A0, 0x2F0 }
    db $2F, $2F, $C9 ; SPRITE C9   | xy: { 0x2F0, 0x2F0 }
    db $36, $29, $27 ; SPRITE 27   | xy: { 0x290, 0x360 }
    db $36, $36, $27 ; SPRITE 27   | xy: { 0x360, 0x360 }
    db $FF ; END
}

; ==============================================================================

; $04D343-$04D352 DATA
Overworld_Sprites_Screen07_2:
{
    db $07, $0E, $27 ; SPRITE 27   | xy: { 0x0E0, 0x070 }
    db $0D, $0A, $27 ; SPRITE 27   | xy: { 0x0A0, 0x0D0 }
    db $15, $17, $27 ; SPRITE 27   | xy: { 0x170, 0x150 }
    db $16, $0F, $27 ; SPRITE 27   | xy: { 0x0F0, 0x160 }
    db $16, $12, $27 ; SPRITE 27   | xy: { 0x120, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D353-$04D368 DATA
Overworld_Sprites_Screen0A_2:
{
    db $04, $0E, $79 ; SPRITE 79   | xy: { 0x0E0, 0x040 }
    db $0D, $10, $41 ; SPRITE 41   | xy: { 0x100, 0x0D0 }
    db $16, $11, $00 ; SPRITE 00   | xy: { 0x110, 0x160 }
    db $16, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x160 }
    db $16, $0E, $17 ; SPRITE 17   | xy: { 0x0E0, 0x160 }
    db $17, $11, $00 ; SPRITE 00   | xy: { 0x110, 0x170 }
    db $1A, $19, $AC ; SPRITE AC   | xy: { 0x190, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04D369-$04D37E DATA
Overworld_Sprites_Screen0F_2:
{
    db $02, $06, $37 ; SPRITE 37   | xy: { 0x060, 0x020 }
    db $0D, $0D, $58 ; SPRITE 58   | xy: { 0x0D0, 0x0D0 }
    db $10, $05, $55 ; SPRITE 55   | xy: { 0x050, 0x100 }
    db $11, $0A, $55 ; SPRITE 55   | xy: { 0x0A0, 0x110 }
    db $12, $11, $58 ; SPRITE 58   | xy: { 0x110, 0x120 }
    db $13, $08, $BA ; SPRITE BA   | xy: { 0x080, 0x130 }
    db $17, $0E, $0A ; SPRITE 0A   | xy: { 0x0E0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D37F-$04D38E DATA
Overworld_Sprites_Screen10_2:
{
    db $0C, $05, $41 ; SPRITE 41   | xy: { 0x050, 0x0C0 }
    db $0C, $07, $AC ; SPRITE AC   | xy: { 0x070, 0x0C0 }
    db $0F, $17, $E0 ; SPRITE E0   | xy: { 0x170, 0x0F0 }
    db $12, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x120 }
    db $18, $08, $41 ; SPRITE 41   | xy: { 0x080, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D38F-$04D39B DATA
Overworld_Sprites_Screen11_2:
{
    db $0C, $17, $41 ; SPRITE 41   | xy: { 0x170, 0x0C0 }
    db $0D, $1A, $41 ; SPRITE 41   | xy: { 0x1A0, 0x0D0 }
    db $10, $08, $DC ; SPRITE DC   | xy: { 0x080, 0x100 }
    db $17, $08, $0B ; SPRITE 0B   | xy: { 0x080, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D39C-$04D3A8 DATA
Overworld_Sprites_Screen12_2:
{
    db $0A, $14, $E3 ; SPRITE E3   | xy: { 0x140, 0x0A0 }
    db $0E, $15, $41 ; SPRITE 41   | xy: { 0x150, 0x0E0 }
    db $10, $0F, $BA ; SPRITE BA   | xy: { 0x0F0, 0x100 }
    db $15, $15, $42 ; SPRITE 42   | xy: { 0x150, 0x150 }
    db $FF ; END
}

; ==============================================================================

; $04D3A9-$04D3B5 DATA
Overworld_Sprites_Screen13_2:
{
    db $09, $18, $79 ; SPRITE 79   | xy: { 0x180, 0x090 }
    db $0C, $07, $DE ; SPRITE DE   | xy: { 0x070, 0x0C0 }
    db $17, $0D, $41 ; SPRITE 41   | xy: { 0x0D0, 0x170 }
    db $1A, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04D3B6-$04D3C8 DATA
Overworld_Sprites_Screen14_2:
{
    db $0D, $0D, $19 ; SPRITE 19   | xy: { 0x0D0, 0x0D0 }
    db $0F, $19, $19 ; SPRITE 19   | xy: { 0x190, 0x0F0 }
    db $10, $08, $19 ; SPRITE 19   | xy: { 0x080, 0x100 }
    db $11, $14, $19 ; SPRITE 19   | xy: { 0x140, 0x110 }
    db $14, $13, $19 ; SPRITE 19   | xy: { 0x130, 0x140 }
    db $19, $11, $41 ; SPRITE 41   | xy: { 0x110, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D3C9-$04D3D8 DATA
Overworld_Sprites_Screen15_2:
{
    db $09, $11, $BA ; SPRITE BA   | xy: { 0x110, 0x090 }
    db $0E, $16, $45 ; SPRITE 45   | xy: { 0x160, 0x0E0 }
    db $0F, $1B, $E3 ; SPRITE E3   | xy: { 0x1B0, 0x0F0 }
    db $17, $0B, $43 ; SPRITE 43   | xy: { 0x0B0, 0x170 }
    db $1A, $04, $AC ; SPRITE AC   | xy: { 0x040, 0x1A0 }
    db $FF ; END
}

; ==============================================================================

; $04D3D9-$04D3E2 DATA
Overworld_Sprites_Screen16_2:
{
    db $0A, $0D, $0D ; SPRITE 0D   | xy: { 0x0D0, 0x0A0 }
    db $15, $0F, $36 ; SPRITE 36   | xy: { 0x0F0, 0x150 }
    db $18, $06, $0D ; SPRITE 0D   | xy: { 0x060, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D3E3-$04D3F2 DATA
Overworld_Sprites_Screen17_2:
{
    db $08, $18, $0D ; SPRITE 0D   | xy: { 0x180, 0x080 }
    db $0A, $17, $0D ; SPRITE 0D   | xy: { 0x170, 0x0A0 }
    db $0B, $0D, $45 ; SPRITE 45   | xy: { 0x0D0, 0x0B0 }
    db $0C, $16, $0D ; SPRITE 0D   | xy: { 0x160, 0x0C0 }
    db $16, $08, $0D ; SPRITE 0D   | xy: { 0x080, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D3F3-$04D417 DATA
Overworld_Sprites_Screen18_2:
{
    db $08, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x080 }
    db $0A, $18, $DB ; SPRITE DB   | xy: { 0x180, 0x0A0 }
    db $16, $18, $75 ; SPRITE 75   | xy: { 0x180, 0x160 }
    db $1C, $07, $41 ; SPRITE 41   | xy: { 0x070, 0x1C0 }
    db $0B, $35, $41 ; SPRITE 41   | xy: { 0x350, 0x0B0 }
    db $18, $20, $1D ; SPRITE 1D   | xy: { 0x200, 0x180 }
    db $2E, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x2E0 }
    db $34, $14, $0B ; SPRITE 0B   | xy: { 0x140, 0x340 }
    db $35, $16, $0B ; SPRITE 0B   | xy: { 0x160, 0x350 }
    db $22, $39, $43 ; SPRITE 43   | xy: { 0x390, 0x220 }
    db $2E, $20, $41 ; SPRITE 41   | xy: { 0x200, 0x2E0 }
    db $33, $36, $79 ; SPRITE 79   | xy: { 0x360, 0x330 }
    db $FF ; END
}

; ==============================================================================

; $04D418-$04D427 DATA
Overworld_Sprites_Screen1A_2:
{
    db $08, $0F, $41 ; SPRITE 41   | xy: { 0x0F0, 0x080 }
    db $0E, $0C, $41 ; SPRITE 41   | xy: { 0x0C0, 0x0E0 }
    db $11, $0D, $E3 ; SPRITE E3   | xy: { 0x0D0, 0x110 }
    db $18, $0A, $D8 ; SPRITE D8   | xy: { 0x0A0, 0x180 }
    db $18, $0F, $45 ; SPRITE 45   | xy: { 0x0F0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D428-$04D446 DATA
Overworld_Sprites_Screen1B_2:
{
    db $0D, $06, $45 ; SPRITE 45   | xy: { 0x060, 0x0D0 }
    db $14, $16, $AC ; SPRITE AC   | xy: { 0x160, 0x140 }
    db $1A, $1F, $45 ; SPRITE 45   | xy: { 0x1F0, 0x1A0 }
    db $13, $37, $41 ; SPRITE 41   | xy: { 0x370, 0x130 }
    db $25, $1E, $BA ; SPRITE BA   | xy: { 0x1E0, 0x250 }
    db $28, $08, $43 ; SPRITE 43   | xy: { 0x080, 0x280 }
    db $2B, $1F, $42 ; SPRITE 42   | xy: { 0x1F0, 0x2B0 }
    db $29, $38, $41 ; SPRITE 41   | xy: { 0x380, 0x290 }
    db $2D, $21, $41 ; SPRITE 41   | xy: { 0x210, 0x2D0 }
    db $32, $21, $45 ; SPRITE 45   | xy: { 0x210, 0x320 }
    db $FF ; END
}

; ==============================================================================

; $04D447-$04D453 DATA
Overworld_Sprites_Screen1D_2:
{
    db $06, $0B, $79 ; SPRITE 79   | xy: { 0x0B0, 0x060 }
    db $0C, $1B, $46 ; SPRITE 46   | xy: { 0x1B0, 0x0C0 }
    db $0D, $07, $45 ; SPRITE 45   | xy: { 0x070, 0x0D0 }
    db $0F, $1B, $46 ; SPRITE 46   | xy: { 0x1B0, 0x0F0 }
    db $FF ; END
}

; ==============================================================================

; $04D454-$04D490 DATA
Overworld_Sprites_Screen1E_2:
{
    db $0E, $0E, $51 ; SPRITE 51   | xy: { 0x0E0, 0x0E0 }
    db $1A, $11, $45 ; SPRITE 45   | xy: { 0x110, 0x1A0 }
    db $1A, $19, $51 ; SPRITE 51   | xy: { 0x190, 0x1A0 }
    db $04, $33, $33 ; SPRITE 33   | xy: { 0x330, 0x040 }
    db $09, $33, $51 ; SPRITE 51   | xy: { 0x330, 0x090 }
    db $09, $37, $51 ; SPRITE 51   | xy: { 0x370, 0x090 }
    db $10, $31, $45 ; SPRITE 45   | xy: { 0x310, 0x100 }
    db $17, $2F, $51 ; SPRITE 51   | xy: { 0x2F0, 0x170 }
    db $25, $0F, $41 ; SPRITE 41   | xy: { 0x0F0, 0x250 }
    db $28, $09, $45 ; SPRITE 45   | xy: { 0x090, 0x280 }
    db $2C, $15, $43 ; SPRITE 43   | xy: { 0x150, 0x2C0 }
    db $33, $14, $51 ; SPRITE 51   | xy: { 0x140, 0x330 }
    db $33, $17, $51 ; SPRITE 51   | xy: { 0x170, 0x330 }
    db $25, $24, $51 ; SPRITE 51   | xy: { 0x240, 0x250 }
    db $28, $31, $51 ; SPRITE 51   | xy: { 0x310, 0x280 }
    db $29, $28, $51 ; SPRITE 51   | xy: { 0x280, 0x290 }
    db $29, $3A, $51 ; SPRITE 51   | xy: { 0x3A0, 0x290 }
    db $29, $3D, $51 ; SPRITE 51   | xy: { 0x3D0, 0x290 }
    db $37, $22, $E3 ; SPRITE E3   | xy: { 0x220, 0x370 }
    db $3A, $2D, $45 ; SPRITE 45   | xy: { 0x2D0, 0x3A0 }
    db $FF ; END
}

; ==============================================================================

; $04D491-$04D49A DATA
Overworld_Sprites_Screen22_2:
{
    db $04, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x040 }
    db $14, $0C, $0B ; SPRITE 0B   | xy: { 0x0C0, 0x140 }
    db $14, $12, $0B ; SPRITE 0B   | xy: { 0x120, 0x140 }
    db $FF ; END
}

; ==============================================================================

; $04D49B-$04D4A7 DATA
Overworld_Sprites_Screen25_2:
{
    db $08, $0E, $41 ; SPRITE 41   | xy: { 0x0E0, 0x080 }
    db $0C, $05, $41 ; SPRITE 41   | xy: { 0x050, 0x0C0 }
    db $11, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x110 }
    db $16, $19, $45 ; SPRITE 45   | xy: { 0x190, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D4A8-$04D4B7 DATA
Overworld_Sprites_Screen28_2:
{
    db $0C, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x0C0 }
    db $13, $07, $EB ; SPRITE EB   | xy: { 0x070, 0x130 }
    db $12, $08, $30 ; SPRITE 30   | xy: { 0x080, 0x120 }
    db $18, $19, $2F ; SPRITE 2F   | xy: { 0x190, 0x180 }
    db $19, $0C, $41 ; SPRITE 41   | xy: { 0x0C0, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D4B8-$04D4C1 DATA
Overworld_Sprites_Screen29_2:
{
    db $05, $0E, $41 ; SPRITE 41   | xy: { 0x0E0, 0x050 }
    db $0C, $0C, $45 ; SPRITE 45   | xy: { 0x0C0, 0x0C0 }
    db $14, $0B, $41 ; SPRITE 41   | xy: { 0x0B0, 0x140 }
    db $FF ; END
}

; ==============================================================================

; $04D4C2-$04D4DD DATA
Overworld_Sprites_Screen2A_2:
{
    db $09, $09, $1D ; SPRITE 1D   | xy: { 0x090, 0x090 }
    db $0C, $0E, $9E ; SPRITE 9E   | xy: { 0x0E0, 0x0C0 }
    db $0E, $0D, $A0 ; SPRITE A0   | xy: { 0x0D0, 0x0E0 }
    db $0E, $0E, $2E ; SPRITE 2E   | xy: { 0x0E0, 0x0E0 }
    db $0E, $11, $A0 ; SPRITE A0   | xy: { 0x110, 0x0E0 }
    db $0F, $0C, $9F ; SPRITE 9F   | xy: { 0x0C0, 0x0F0 }
    db $10, $11, $9F ; SPRITE 9F   | xy: { 0x110, 0x100 }
    db $14, $15, $DB ; SPRITE DB   | xy: { 0x150, 0x140 }
    db $18, $0F, $DB ; SPRITE DB   | xy: { 0x0F0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D4DE-$04D4ED DATA
Overworld_Sprites_Screen2B_2:
{
    db $06, $08, $41 ; SPRITE 41   | xy: { 0x080, 0x060 }
    db $0D, $16, $E3 ; SPRITE E3   | xy: { 0x160, 0x0D0 }
    db $11, $14, $41 ; SPRITE 41   | xy: { 0x140, 0x110 }
    db $15, $14, $41 ; SPRITE 41   | xy: { 0x140, 0x150 }
    db $17, $10, $41 ; SPRITE 41   | xy: { 0x100, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D4EE-$04D4F4 DATA
Overworld_Sprites_Screen2C_2:
{
    db $14, $18, $41 ; SPRITE 41   | xy: { 0x180, 0x140 }
    db $19, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D4F5-$04D501 DATA
Overworld_Sprites_Screen2D_2:
{
    db $08, $0F, $0A ; SPRITE 0A   | xy: { 0x0F0, 0x080 }
    db $0B, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x0B0 }
    db $16, $12, $45 ; SPRITE 45   | xy: { 0x120, 0x160 }
    db $17, $1C, $55 ; SPRITE 55   | xy: { 0x1C0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D502-$04D514 DATA
Overworld_Sprites_Screen2E_2:
{
    db $09, $0C, $E3 ; SPRITE E3   | xy: { 0x0C0, 0x090 }
    db $0B, $14, $79 ; SPRITE 79   | xy: { 0x140, 0x0B0 }
    db $0C, $0E, $45 ; SPRITE 45   | xy: { 0x0E0, 0x0C0 }
    db $0E, $17, $41 ; SPRITE 41   | xy: { 0x170, 0x0E0 }
    db $12, $05, $55 ; SPRITE 55   | xy: { 0x050, 0x120 }
    db $17, $19, $08 ; SPRITE 08   | xy: { 0x190, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D515-$04D51E DATA
Overworld_Sprites_Screen2F_2:
{
    db $0C, $0F, $45 ; SPRITE 45   | xy: { 0x0F0, 0x0C0 }
    db $17, $07, $51 ; SPRITE 51   | xy: { 0x070, 0x170 }
    db $17, $0C, $51 ; SPRITE 51   | xy: { 0x0C0, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D51F-$04D55B DATA
Overworld_Sprites_Screen30_2:
{
    db $14, $12, $57 ; SPRITE 57   | xy: { 0x120, 0x140 }
    db $19, $12, $B3 ; SPRITE B3   | xy: { 0x120, 0x190 }
    db $1C, $0E, $57 ; SPRITE 57   | xy: { 0x0E0, 0x1C0 }
    db $1C, $16, $57 ; SPRITE 57   | xy: { 0x160, 0x1C0 }
    db $19, $27, $4C ; SPRITE 4C   | xy: { 0x270, 0x190 }
    db $1C, $22, $01 ; SPRITE 01   | xy: { 0x220, 0x1C0 }
    db $1F, $2A, $4C ; SPRITE 4C   | xy: { 0x2A0, 0x1F0 }
    db $23, $0C, $D4 ; SPRITE D4   | xy: { 0x0C0, 0x230 }
    db $26, $1D, $4C ; SPRITE 4C   | xy: { 0x1D0, 0x260 }
    db $29, $07, $01 ; SPRITE 01   | xy: { 0x070, 0x290 }
    db $29, $0F, $4C ; SPRITE 4C   | xy: { 0x0F0, 0x290 }
    db $2A, $06, $EB ; SPRITE EB   | xy: { 0x060, 0x2A0 }
    db $2C, $1B, $4C ; SPRITE 4C   | xy: { 0x1B0, 0x2C0 }
    db $30, $0A, $4C ; SPRITE 4C   | xy: { 0x0A0, 0x300 }
    db $35, $14, $4C ; SPRITE 4C   | xy: { 0x140, 0x350 }
    db $2B, $37, $F2 ; SPRITE F2   | xy: { 0x370, 0x2B0 }
    db $24, $22, $4C ; SPRITE 4C   | xy: { 0x220, 0x240 }
    db $2A, $28, $4C ; SPRITE 4C   | xy: { 0x280, 0x2A0 }
    db $32, $23, $4C ; SPRITE 4C   | xy: { 0x230, 0x320 }
    db $33, $34, $01 ; SPRITE 01   | xy: { 0x340, 0x330 }
    db $FF ; END
}

; ==============================================================================

; $04D55C-$04D56F DATA
Overworld_Sprites_Screen32_2:
{
    db $09, $1A, $D8 ; SPRITE D8   | xy: { 0x1A0, 0x090 }
    db $0C, $0B, $42 ; SPRITE 42   | xy: { 0x0B0, 0x0C0 }
    db $0C, $12, $41 ; SPRITE 41   | xy: { 0x120, 0x0C0 }
    db $10, $13, $42 ; SPRITE 42   | xy: { 0x130, 0x100 }
    db $12, $19, $DD ; SPRITE DD   | xy: { 0x190, 0x120 }
    db $15, $08, $D4 ; SPRITE D4   | xy: { 0x080, 0x150 }
    db $FF ; END
}

; ==============================================================================

; $04D56F-$04D57E DATA
Overworld_Sprites_Screen33_2:
{
    db $06, $13, $08 ; SPRITE 08   | xy: { 0x130, 0x060 }
    db $0B, $14, $0A ; SPRITE 0A   | xy: { 0x140, 0x0B0 }
    db $12, $17, $BA ; SPRITE BA   | xy: { 0x170, 0x120 }
    db $16, $12, $08 ; SPRITE 08   | xy: { 0x120, 0x160 }
    db $1B, $1A, $08 ; SPRITE 08   | xy: { 0x1A0, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04D57F-$04D58E DATA
Overworld_Sprites_Screen34_2:
{
    db $0E, $17, $33 ; SPRITE 33   | xy: { 0x170, 0x0E0 }
    db $13, $08, $00 ; SPRITE 00   | xy: { 0x080, 0x130 }
    db $12, $11, $41 ; SPRITE 41   | xy: { 0x110, 0x120 }
    db $13, $06, $08 ; SPRITE 08   | xy: { 0x060, 0x130 }
    db $18, $0C, $08 ; SPRITE 08   | xy: { 0x0C0, 0x180 }
    db $FF ; END
}

; ==============================================================================

; $04D58F-$04D5D4 DATA
Overworld_Sprites_Screen35_2:
{
    db $07, $0E, $00 ; SPRITE 00   | xy: { 0x0E0, 0x070 }
    db $09, $0D, $08 ; SPRITE 08   | xy: { 0x0D0, 0x090 }
    db $0C, $0A, $45 ; SPRITE 45   | xy: { 0x0A0, 0x0C0 }
    db $13, $19, $EB ; SPRITE EB   | xy: { 0x190, 0x130 }
    db $14, $19, $0D ; SPRITE 0D   | xy: { 0x190, 0x140 }
    db $17, $11, $55 ; SPRITE 55   | xy: { 0x110, 0x170 }
    db $0A, $38, $0A ; SPRITE 0A   | xy: { 0x380, 0x0A0 }
    db $0D, $25, $55 ; SPRITE 55   | xy: { 0x250, 0x0D0 }
    db $19, $37, $55 ; SPRITE 55   | xy: { 0x370, 0x190 }
    db $1F, $27, $0D ; SPRITE 0D   | xy: { 0x270, 0x1F0 }
    db $1F, $2F, $0D ; SPRITE 0D   | xy: { 0x2F0, 0x1F0 }
    db $26, $1B, $55 ; SPRITE 55   | xy: { 0x1B0, 0x260 }
    db $2F, $0D, $00 ; SPRITE 00   | xy: { 0x0D0, 0x2F0 }
    db $34, $06, $08 ; SPRITE 08   | xy: { 0x060, 0x340 }
    db $35, $0A, $08 ; SPRITE 08   | xy: { 0x0A0, 0x350 }
    db $35, $14, $55 ; SPRITE 55   | xy: { 0x140, 0x350 }
    db $39, $0B, $08 ; SPRITE 08   | xy: { 0x0B0, 0x390 }
    db $3A, $19, $0D ; SPRITE 0D   | xy: { 0x190, 0x3A0 }
    db $2B, $29, $BA ; SPRITE BA   | xy: { 0x290, 0x2B0 }
    db $31, $39, $55 ; SPRITE 55   | xy: { 0x390, 0x310 }
    db $36, $21, $55 ; SPRITE 55   | xy: { 0x210, 0x360 }
    db $37, $32, $0D ; SPRITE 0D   | xy: { 0x320, 0x370 }
    db $39, $34, $0D ; SPRITE 0D   | xy: { 0x340, 0x390 }
    db $FF ; END
}

; ==============================================================================

; $04D5D5-$04D5E4 DATA
Overworld_Sprites_Screen37_2:
{
    db $08, $08, $58 ; SPRITE 58   | xy: { 0x080, 0x080 }
    db $08, $10, $58 ; SPRITE 58   | xy: { 0x100, 0x080 }
    db $0B, $0F, $58 ; SPRITE 58   | xy: { 0x0F0, 0x0B0 }
    db $11, $16, $58 ; SPRITE 58   | xy: { 0x160, 0x110 }
    db $19, $12, $55 ; SPRITE 55   | xy: { 0x120, 0x190 }
    db $FF ; END
}

; ==============================================================================

; $04D5E5-$04D5FD DATA
Overworld_Sprites_Screen3A_2:
{
    db $05, $17, $39 ; SPRITE 39   | xy: { 0x170, 0x050 }
    db $0A, $0B, $3E ; SPRITE 3E   | xy: { 0x0B0, 0x0A0 }
    db $0D, $14, $00 ; SPRITE 00   | xy: { 0x140, 0x0D0 }
    db $0E, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x0E0 }
    db $0F, $14, $00 ; SPRITE 00   | xy: { 0x140, 0x0F0 }
    db $10, $13, $00 ; SPRITE 00   | xy: { 0x130, 0x100 }
    db $0F, $11, $45 ; SPRITE 45   | xy: { 0x110, 0x0F0 }
    db $17, $17, $3E ; SPRITE 3E   | xy: { 0x170, 0x170 }
    db $FF ; END
}

; ==============================================================================

; $04D5FE-$04D610 DATA
Overworld_Sprites_Screen3B_2:
{
    db $0D, $13, $D2 ; SPRITE D2   | xy: { 0x130, 0x0D0 }
    db $0F, $0C, $08 ; SPRITE 08   | xy: { 0x0C0, 0x0F0 }
    db $0E, $14, $EB ; SPRITE EB   | xy: { 0x140, 0x0E0 }
    db $14, $0F, $0A ; SPRITE 0A   | xy: { 0x0F0, 0x140 }
    db $18, $17, $41 ; SPRITE 41   | xy: { 0x170, 0x180 }
    db $1B, $14, $00 ; SPRITE 00   | xy: { 0x140, 0x1B0 }
    db $FF ; END
}

; ==============================================================================

; $04D611-$04D620 DATA
Overworld_Sprites_Screen3C_2:
{
    db $09, $0B, $00 ; SPRITE 00   | xy: { 0x0B0, 0x090 }
    db $0A, $08, $41 ; SPRITE 41   | xy: { 0x080, 0x0A0 }
    db $0F, $14, $08 ; SPRITE 08   | xy: { 0x140, 0x0F0 }
    db $11, $09, $45 ; SPRITE 45   | xy: { 0x090, 0x110 }
    db $15, $14, $0A ; SPRITE 0A   | xy: { 0x140, 0x150 }
    db $FF ; END
}

; ==============================================================================

; $04D621-$04D62D DATA
Overworld_Sprites_Screen3F_2:
{
    db $05, $16, $0A ; SPRITE 0A   | xy: { 0x160, 0x050 }
    db $0C, $07, $BA ; SPRITE BA   | xy: { 0x070, 0x0C0 }
    db $13, $06, $55 ; SPRITE 55   | xy: { 0x060, 0x130 }
    db $16, $11, $0F ; SPRITE 0F   | xy: { 0x110, 0x160 }
    db $FF ; END
}

; ==============================================================================

; $04D62E-$04D92D DATA
RoomData_SpritePointers:
{
    dw RoomData_Sprites_Room0000 ; 0x0000 - $D92E
    dw RoomData_Sprites_Empty    ; 0x0001 - $EC9D
    dw RoomData_Sprites_Room0002 ; 0x0002 - $D933
    dw RoomData_Sprites_Empty    ; 0x0003 - $EC9D
    dw RoomData_Sprites_Room0004 ; 0x0004 - $D965
    dw RoomData_Sprites_Empty    ; 0x0005 - $EC9D
    dw RoomData_Sprites_Room0006 ; 0x0006 - $D997
    dw RoomData_Sprites_Room0007 ; 0x0007 - $D9C3
    dw RoomData_Sprites_Room0008 ; 0x0008 - $D9C8
    dw RoomData_Sprites_Room0009 ; 0x0009 - $D9CD
    dw RoomData_Sprites_Room000A ; 0x000A - $D9D8
    dw RoomData_Sprites_Room000B ; 0x000B - $D9EF
    dw RoomData_Sprites_Empty    ; 0x000C - $EC9D
    dw RoomData_Sprites_Room000D ; 0x000D - $DA0F
    dw RoomData_Sprites_Room000E ; 0x000E - $DA14
    dw RoomData_Sprites_Empty    ; 0x000F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0010 - $EC9D
    dw RoomData_Sprites_Room0011 ; 0x0011 - $DA25
    dw RoomData_Sprites_Room0012 ; 0x0012 - $DA3F
    dw RoomData_Sprites_Room0013 ; 0x0013 - $DA47
    dw RoomData_Sprites_Room0014 ; 0x0014 - $DA6A
    dw RoomData_Sprites_Room0015 ; 0x0015 - $DA8A
    dw RoomData_Sprites_Room0016 ; 0x0016 - $DAAA
    dw RoomData_Sprites_Room0017 ; 0x0017 - $DAC1
    dw RoomData_Sprites_Empty    ; 0x0018 - $EC9D
    dw RoomData_Sprites_Room0019 ; 0x0019 - $DADE
    dw RoomData_Sprites_Room001A ; 0x001A - $DAEC
    dw RoomData_Sprites_Room001B ; 0x001B - $DB0F
    dw RoomData_Sprites_Room001C ; 0x001C - $DB23
    dw RoomData_Sprites_Empty    ; 0x001D - $EC9D
    dw RoomData_Sprites_Room001E ; 0x001E - $DB46
    dw RoomData_Sprites_Room001F ; 0x001F - $DB5D
    dw RoomData_Sprites_Room0020 ; 0x0020 - $DB77
    dw RoomData_Sprites_Room0021 ; 0x0021 - $DB7C
    dw RoomData_Sprites_Room0022 ; 0x0022 - $DBA2
    dw RoomData_Sprites_Room0023 ; 0x0023 - $DBB9
    dw RoomData_Sprites_Room0024 ; 0x0024 - $DBCA
    dw RoomData_Sprites_Room0025 ; 0x0025 - $DBE1
    dw RoomData_Sprites_Room0026 ; 0x0026 - $DBE3
    dw RoomData_Sprites_Room0027 ; 0x0027 - $DC09
    dw RoomData_Sprites_Room0028 ; 0x0028 - $DC20
    dw RoomData_Sprites_Room0029 ; 0x0029 - $DC31
    dw RoomData_Sprites_Room002A ; 0x002A - $DC39
    dw RoomData_Sprites_Room002B ; 0x002B - $DC53
    dw RoomData_Sprites_Room002C ; 0x002C - $DC6D
    dw RoomData_Sprites_Empty    ; 0x002D - $EC9D
    dw RoomData_Sprites_Room002E ; 0x002E - $DC7B
    dw RoomData_Sprites_Empty    ; 0x002F - $EC9D
    dw RoomData_Sprites_Room0030 ; 0x0030 - $DC8F
    dw RoomData_Sprites_Room0031 ; 0x0031 - $DC94
    dw RoomData_Sprites_Room0032 ; 0x0032 - $DCBA
    dw RoomData_Sprites_Room0033 ; 0x0033 - $DCCB
    dw RoomData_Sprites_Room0034 ; 0x0034 - $DCD6
    dw RoomData_Sprites_Room0035 ; 0x0035 - $DCED
    dw RoomData_Sprites_Room0036 ; 0x0036 - $DD10
    dw RoomData_Sprites_Room0037 ; 0x0037 - $DD33
    dw RoomData_Sprites_Room0038 ; 0x0038 - $DD53
    dw RoomData_Sprites_Room0039 ; 0x0039 - $DD6A
    dw RoomData_Sprites_Room003A ; 0x003A - $DD84
    dw RoomData_Sprites_Room003B ; 0x003B - $DD98
    dw RoomData_Sprites_Room003C ; 0x003C - $DDAF
    dw RoomData_Sprites_Room003D ; 0x003D - $DDBA
    dw RoomData_Sprites_Room003E ; 0x003E - $DDE9
    dw RoomData_Sprites_Room003F ; 0x003F - $DE12
    dw RoomData_Sprites_Room0040 ; 0x0040 - $DE23
    dw RoomData_Sprites_Room0041 ; 0x0041 - $DEE9
    dw RoomData_Sprites_Room0042 ; 0x0042 - $DE47
    dw RoomData_Sprites_Room0043 ; 0x0043 - $DE5B
    dw RoomData_Sprites_Room0044 ; 0x0044 - $DE63
    dw RoomData_Sprites_Room0045 ; 0x0045 - $DE80
    dw RoomData_Sprites_Room0046 ; 0x0046 - $DEA3
    dw RoomData_Sprites_Room0047 ; 0x0047 - $DEB4
    dw RoomData_Sprites_Empty    ; 0x0048 - $EC9D
    dw RoomData_Sprites_Room0049 ; 0x0049 - $DEB6
    dw RoomData_Sprites_Room004A ; 0x004A - $DEDF
    dw RoomData_Sprites_Room004B ; 0x004B - $DEEA
    dw RoomData_Sprites_Room004C ; 0x004C - $DF04
    dw RoomData_Sprites_Room004D ; 0x004D - $DF1E
    dw RoomData_Sprites_Room004E ; 0x004E - $DF23
    dw RoomData_Sprites_Room004F ; 0x004F - $DF31
    dw RoomData_Sprites_Room0050 ; 0x0050 - $DF3C
    dw RoomData_Sprites_Room0051 ; 0x0051 - $DF47
    dw RoomData_Sprites_Room0052 ; 0x0052 - $DF52
    dw RoomData_Sprites_Room0053 ; 0x0053 - $DF5D
    dw RoomData_Sprites_Room0054 ; 0x0054 - $DF86
    dw RoomData_Sprites_Room0055 ; 0x0055 - $DFA0
    dw RoomData_Sprites_Room0056 ; 0x0056 - $DFAB
    dw RoomData_Sprites_Room0057 ; 0x0057 - $DFD4
    dw RoomData_Sprites_Room0058 ; 0x0058 - $E006
    dw RoomData_Sprites_Room0059 ; 0x0059 - $E023
    dw RoomData_Sprites_Room005A ; 0x005A - $E049
    dw RoomData_Sprites_Room005B ; 0x005B - $E04E
    dw RoomData_Sprites_Room005C ; 0x005C - $E06B
    dw RoomData_Sprites_Room005D ; 0x005D - $E07C
    dw RoomData_Sprites_Room005E ; 0x005E - $E0A5
    dw RoomData_Sprites_Room005F ; 0x005F - $E0B6
    dw RoomData_Sprites_Room0060 ; 0x0060 - $E0C1
    dw RoomData_Sprites_Room0061 ; 0x0061 - $E0C6
    dw RoomData_Sprites_Room0062 ; 0x0062 - $E0D1
    dw RoomData_Sprites_Room0063 ; 0x0063 - $E0DC
    dw RoomData_Sprites_Room0064 ; 0x0064 - $E0E4
    dw RoomData_Sprites_Room0065 ; 0x0065 - $E10D
    dw RoomData_Sprites_Room0066 ; 0x0066 - $E11E
    dw RoomData_Sprites_Room0067 ; 0x0067 - $E144
    dw RoomData_Sprites_Room0068 ; 0x0068 - $E164
    dw RoomData_Sprites_Empty    ; 0x0069 - $EC9D
    dw RoomData_Sprites_Room006A ; 0x006A - $E17E
    dw RoomData_Sprites_Room006B ; 0x006B - $E192
    dw RoomData_Sprites_Room006C ; 0x006C - $E1BE
    dw RoomData_Sprites_Room006D ; 0x006D - $E1CF
    dw RoomData_Sprites_Room006E ; 0x006E - $E1EC
    dw RoomData_Sprites_Empty    ; 0x006F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0070 - $EC9D
    dw RoomData_Sprites_Room0071 ; 0x0071 - $E1FD
    dw RoomData_Sprites_Room0072 ; 0x0072 - $E208
    dw RoomData_Sprites_Room0073 ; 0x0073 - $E213
    dw RoomData_Sprites_Room0074 ; 0x0074 - $E22A
    dw RoomData_Sprites_Room0075 ; 0x0075 - $E244
    dw RoomData_Sprites_Room0076 ; 0x0076 - $E264
    dw RoomData_Sprites_Room0077 ; 0x0077 - $E27B
    dw RoomData_Sprites_Empty    ; 0x0078 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0079 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x007A - $EC9D
    dw RoomData_Sprites_Room007B ; 0x007B - $E28F
    dw RoomData_Sprites_Room007C ; 0x007C - $E2B2
    dw RoomData_Sprites_Room007D ; 0x007D - $E2C9
    dw RoomData_Sprites_Room007E ; 0x007E - $E2EC
    dw RoomData_Sprites_Room007F ; 0x007F - $E303
    dw RoomData_Sprites_Room0080 ; 0x0080 - $E31D
    dw RoomData_Sprites_Room0081 ; 0x0081 - $E32B
    dw RoomData_Sprites_Room0082 ; 0x0082 - $E333
    dw RoomData_Sprites_Room0083 ; 0x0083 - $E33E
    dw RoomData_Sprites_Room0084 ; 0x0084 - $E35E
    dw RoomData_Sprites_Room0085 ; 0x0085 - $E375
    dw RoomData_Sprites_Room0086 ; 0x0086 - $E395
    dw RoomData_Sprites_Room0087 ; 0x0087 - $E397
    dw RoomData_Sprites_Empty    ; 0x0088 - $EC9D
    dw RoomData_Sprites_Room0089 ; 0x0089 - $E3C0
    dw RoomData_Sprites_Empty    ; 0x008A - $EC9D
    dw RoomData_Sprites_Room008B ; 0x008B - $E3C8
    dw RoomData_Sprites_Room008C ; 0x008C - $E3E2
    dw RoomData_Sprites_Room008D ; 0x008D - $E414
    dw RoomData_Sprites_Room008E ; 0x008E - $E43D
    dw RoomData_Sprites_Empty    ; 0x008F - $EC9D
    dw RoomData_Sprites_Room0090 ; 0x0090 - $E457
    dw RoomData_Sprites_Room0091 ; 0x0091 - $E45C
    dw RoomData_Sprites_Room0092 ; 0x0092 - $E473
    dw RoomData_Sprites_Room0093 ; 0x0093 - $E499
    dw RoomData_Sprites_Empty    ; 0x0094 - $EC9D
    dw RoomData_Sprites_Room0095 ; 0x0095 - $E4B3
    dw RoomData_Sprites_Room0096 ; 0x0096 - $E4C4
    dw RoomData_Sprites_Room0097 ; 0x0097 - $E4D5
    dw RoomData_Sprites_Room0098 ; 0x0098 - $E4DA
    dw RoomData_Sprites_Room0099 ; 0x0099 - $E4EB
    dw RoomData_Sprites_Empty    ; 0x009A - $EC9D
    dw RoomData_Sprites_Room009B ; 0x009B - $E50E
    dw RoomData_Sprites_Room009C ; 0x009C - $E537
    dw RoomData_Sprites_Room009D ; 0x009D - $E54E
    dw RoomData_Sprites_Room009E ; 0x009E - $E56B
    dw RoomData_Sprites_Room009F ; 0x009F - $E57C
    dw RoomData_Sprites_Room00A0 ; 0x00A0 - $E590
    dw RoomData_Sprites_Room00A1 ; 0x00A1 - $E59B
    dw RoomData_Sprites_Empty    ; 0x00A2 - $EC9D
    dw RoomData_Sprites_Room00A3 ; 0x00A3 - $E5B8
    dw RoomData_Sprites_Room00A4 ; 0x00A4 - $E5BA
    dw RoomData_Sprites_Room00A5 ; 0x00A5 - $E5C5
    dw RoomData_Sprites_Room00A6 ; 0x00A6 - $E5EB
    dw RoomData_Sprites_Room00A7 ; 0x00A7 - $E5F3
    dw RoomData_Sprites_Room00A8 ; 0x00A8 - $E5FB
    dw RoomData_Sprites_Room00A9 ; 0x00A9 - $E60C
    dw RoomData_Sprites_Room00AA ; 0x00AA - $E626
    dw RoomData_Sprites_Room00AB ; 0x00AB - $E63A
    dw RoomData_Sprites_Room00AC ; 0x00AC - $E654
    dw RoomData_Sprites_Empty    ; 0x00AD - $EC9D
    dw RoomData_Sprites_Room00AE ; 0x00AE - $E659
    dw RoomData_Sprites_Room00AF ; 0x00AF - $E661
    dw RoomData_Sprites_Room00B0 ; 0x00B0 - $E666
    dw RoomData_Sprites_Room00B1 ; 0x00B1 - $E692
    dw RoomData_Sprites_Room00B2 ; 0x00B2 - $E6B2
    dw RoomData_Sprites_Room00B3 ; 0x00B3 - $E6DE
    dw RoomData_Sprites_Empty    ; 0x00B4 - $EC9D
    dw RoomData_Sprites_Room00B5 ; 0x00B5 - $E6EF
    dw RoomData_Sprites_Room00B6 ; 0x00B6 - $E6FA
    dw RoomData_Sprites_Room00B7 ; 0x00B7 - $E71A
    dw RoomData_Sprites_Room00B8 ; 0x00B8 - $E722
    dw RoomData_Sprites_Room00B9 ; 0x00B9 - $E736
    dw RoomData_Sprites_Room00BA ; 0x00BA - $E73B
    dw RoomData_Sprites_Room00BB ; 0x00BB - $E752
    dw RoomData_Sprites_Room00BC ; 0x00BC - $E775
    dw RoomData_Sprites_Room00BD ; 0x00BD - $E79B
    dw RoomData_Sprites_Room00BE ; 0x00BE - $E79D
    dw RoomData_Sprites_Room00BF ; 0x00BF - $E7B4
    dw RoomData_Sprites_Room00C0 ; 0x00C0 - $E7BC
    dw RoomData_Sprites_Room00C1 ; 0x00C1 - $E7D9
    dw RoomData_Sprites_Room00C2 ; 0x00C2 - $E802
    dw RoomData_Sprites_Room00C3 ; 0x00C3 - $E81C
    dw RoomData_Sprites_Room00C4 ; 0x00C4 - $E836
    dw RoomData_Sprites_Room00C5 ; 0x00C5 - $E856
    dw RoomData_Sprites_Room00C6 ; 0x00C6 - $E870
    dw RoomData_Sprites_Empty    ; 0x00C7 - $EC9D
    dw RoomData_Sprites_Room00C8 ; 0x00C8 - $E887
    dw RoomData_Sprites_Room00C9 ; 0x00C9 - $E89E
    dw RoomData_Sprites_Empty    ; 0x00CA - $EC9D
    dw RoomData_Sprites_Room00CB ; 0x00CB - $E8A9
    dw RoomData_Sprites_Room00CC ; 0x00CC - $E8CF
    dw RoomData_Sprites_Empty    ; 0x00CD - $EC9D
    dw RoomData_Sprites_Room00CE ; 0x00CE - $E8FB
    dw RoomData_Sprites_Empty    ; 0x00CF - $EC9D
    dw RoomData_Sprites_Room00D0 ; 0x00D0 - $E915
    dw RoomData_Sprites_Room00D1 ; 0x00D1 - $E938
    dw RoomData_Sprites_Room00D2 ; 0x00D2 - $E952
    dw RoomData_Sprites_Empty    ; 0x00D3 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x00D4 - $EC9D
    dw RoomData_Sprites_Room00D5 ; 0x00D5 - $E972
    dw RoomData_Sprites_Room00D6 ; 0x00D6 - $E983
    dw RoomData_Sprites_Empty    ; 0x00D7 - $EC9D
    dw RoomData_Sprites_Room00D8 ; 0x00D8 - $E98E
    dw RoomData_Sprites_Room00D9 ; 0x00D9 - $E9B1
    dw RoomData_Sprites_Room00DA ; 0x00DA - $E9BF
    dw RoomData_Sprites_Room00DB ; 0x00DB - $E9C7
    dw RoomData_Sprites_Room00DC ; 0x00DC - $E9DE
    dw RoomData_Sprites_Empty    ; 0x00DD - $EC9D
    dw RoomData_Sprites_Room00DE ; 0x00DE - $EA01
    dw RoomData_Sprites_Room00DF ; 0x00DF - $EA0C
    dw RoomData_Sprites_Room00E0 ; 0x00E0 - $EA14
    dw RoomData_Sprites_Room00E1 ; 0x00E1 - $EA22
    dw RoomData_Sprites_Room00E2 ; 0x00E2 - $EA2A
    dw RoomData_Sprites_Room00E3 ; 0x00E3 - $EA3B
    dw RoomData_Sprites_Room00E4 ; 0x00E4 - $EA40
    dw RoomData_Sprites_Room00E5 ; 0x00E5 - $EA4E
    dw RoomData_Sprites_Room00E6 ; 0x00E6 - $EA62
    dw RoomData_Sprites_Room00E7 ; 0x00E7 - $EA73
    dw RoomData_Sprites_Room00E8 ; 0x00E8 - $EA8A
    dw RoomData_Sprites_Empty    ; 0x00E9 - $EC9D
    dw RoomData_Sprites_Room00EA ; 0x00EA - $EA98
    dw RoomData_Sprites_Room00EB ; 0x00EB - $EA9D
    dw RoomData_Sprites_Empty    ; 0x00EC - $EC9D
    dw RoomData_Sprites_Empty    ; 0x00ED - $EC9D
    dw RoomData_Sprites_Room00EE ; 0x00EE - $EAA2
    dw RoomData_Sprites_Room00EF ; 0x00EF - $EAB3
    dw RoomData_Sprites_Room00F0 ; 0x00F0 - $EAC1
    dw RoomData_Sprites_Room00F1 ; 0x00F1 - $EAE1
    dw RoomData_Sprites_Empty    ; 0x00F2 - $EC9D
    dw RoomData_Sprites_Room00F3 ; 0x00F3 - $EB01
    dw RoomData_Sprites_Room00F4 ; 0x00F4 - $EB06
    dw RoomData_Sprites_Room00F5 ; 0x00F5 - $EB0B
    dw RoomData_Sprites_Empty    ; 0x00F6 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x00F7 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x00F8 - $EC9D
    dw RoomData_Sprites_Room00F9 ; 0x00F9 - $EB10
    dw RoomData_Sprites_Room00FA ; 0x00FA - $EB1E
    dw RoomData_Sprites_Room00FB ; 0x00FB - $EB29
    dw RoomData_Sprites_Room00FC ; 0x00FC - $EB34
    dw RoomData_Sprites_Room00FD ; 0x00FD - $EB36
    dw RoomData_Sprites_Room00FE ; 0x00FE - $EB47
    dw RoomData_Sprites_Room00FF ; 0x00FF - $EB58
    dw RoomData_Sprites_Room0100 ; 0x0100 - $EB5D
    dw RoomData_Sprites_Room0101 ; 0x0101 - $EB62
    dw RoomData_Sprites_Room0102 ; 0x0102 - $EB67
    dw RoomData_Sprites_Room0103 ; 0x0103 - $EB6C
    dw RoomData_Sprites_Room0104 ; 0x0104 - $EB77
    dw RoomData_Sprites_Room0105 ; 0x0105 - $EB7C
    dw RoomData_Sprites_Room0106 ; 0x0106 - $EB81
    dw RoomData_Sprites_Room0107 ; 0x0107 - $EB86
    dw RoomData_Sprites_Room0108 ; 0x0108 - $EB91
    dw RoomData_Sprites_Room0109 ; 0x0109 - $EB9F
    dw RoomData_Sprites_Room010A ; 0x010A - $EBA4
    dw RoomData_Sprites_Room010B ; 0x010B - $EBA9
    dw RoomData_Sprites_Room010C ; 0x010C - $EBC0
    dw RoomData_Sprites_Room010D ; 0x010D - $EBDA
    dw RoomData_Sprites_Room010E ; 0x010E - $EBE2
    dw RoomData_Sprites_Room010F ; 0x010F - $EBEA
    dw RoomData_Sprites_Room0110 ; 0x0110 - $EBEF
    dw RoomData_Sprites_Room0111 ; 0x0111 - $EBF4
    dw RoomData_Sprites_Room0112 ; 0x0112 - $EBF9
    dw RoomData_Sprites_Empty    ; 0x0113 - $EC9D
    dw RoomData_Sprites_Room0114 ; 0x0114 - $EC01
    dw RoomData_Sprites_Room0115 ; 0x0115 - $EC09
    dw RoomData_Sprites_Room0116 ; 0x0116 - $EC1D
    dw RoomData_Sprites_Empty    ; 0x0117 - $EC9D
    dw RoomData_Sprites_Room0118 ; 0x0118 - $EC22
    dw RoomData_Sprites_Room0119 ; 0x0119 - $EC27
    dw RoomData_Sprites_Room011A ; 0x011A - $EC2C
    dw RoomData_Sprites_Room011B ; 0x011B - $EC31
    dw RoomData_Sprites_Room011C ; 0x011C - $EC39
    dw RoomData_Sprites_Empty    ; 0x011D - $EC9D
    dw RoomData_Sprites_Room011E ; 0x011E - $EC3E
    dw RoomData_Sprites_Room011F ; 0x011F - $EC4F
    dw RoomData_Sprites_Room0120 ; 0x0120 - $EC54
    dw RoomData_Sprites_Room0121 ; 0x0121 - $EC5F
    dw RoomData_Sprites_Room0122 ; 0x0122 - $EC64
    dw RoomData_Sprites_Room0123 ; 0x0123 - $EC6C
    dw RoomData_Sprites_Room0124 ; 0x0124 - $EC7D
    dw RoomData_Sprites_Room0125 ; 0x0125 - $EC82
    dw RoomData_Sprites_Room0126 ; 0x0126 - $EC87
    dw RoomData_Sprites_Room0127 ; 0x0127 - $EC98
    dw RoomData_Sprites_Empty    ; 0x0128 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0129 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x012F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0130 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0131 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0132 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0133 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0134 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0135 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0136 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0137 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0138 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0139 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x013F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0140 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0141 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0142 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0143 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0144 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0145 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0146 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0147 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0148 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0149 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x014F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0150 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0151 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0152 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0153 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0154 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0155 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0156 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0157 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0158 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0159 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x015F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0160 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0161 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0162 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0163 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0164 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0165 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0166 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0167 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0168 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0169 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x016F - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0170 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0171 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0172 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0173 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0174 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0175 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0176 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0177 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0178 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x0179 - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017A - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017B - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017C - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017D - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017E - $EC9D
    dw RoomData_Sprites_Empty    ; 0x017F - $EC9D
}

; ==============================================================================

; Each room begins with 1 byte to designate the layering of OAM allocation.
; Following that, each sprite has 3 bytes of data
; The list is terminated when byte 1 is 0xFF
;
; lssyyyyy
; tttxxxxx
; iiiiiiii
;   x - x coordinate of sprite, in multiples of 16
;   y - y coordinate of sprite, in multiples of 16
;   l - sprite layer (0: upper | 1: lower)
;   i - sprite ID
;   s - aux part 1
;   t - aux part 2
;       if every bit of t is set, then the entry corresponds to an overlord
;       or a key
;
;   s and t form a 5 bit auxiliary value written to $0E30,X
;     ...ssttt
;
; For entries with ID 0xE4, byte 1 doubles as a flag
;   0xFE - previous sprite entry is given a small key
;   0xFD - previous sprite entry is given a big key
;   All other values correspond to a regular key placed as a sprite
;
; This data is parsed and formatted as a comment for each entry as:
; xy: { X, Y, Z } | s: S
; where:
;   X and Y are pixel coordinates relative to the room's top-left corner
;   Z is the layer (U: upper layer | L: lower layer)
;   S is the auxiliary value
; ==============================================================================

; $04D92E-$04D932 DATA
RoomData_Sprites_Room0000:
{
    db $00 ; Unlayered OAM
    db $05, $17, $D6 ; SPRITE D6   | xy: { 0x170, 0x050, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D933-$04D964 DATA
RoomData_Sprites_Room0002:
{
    db $00 ; Unlayered OAM
    db $85, $12, $6D ; SPRITE 6D   | xy: { 0x120, 0x050, L } | s: 0x00
    db $86, $15, $6D ; SPRITE 6D   | xy: { 0x150, 0x060, L } | s: 0x00
    db $88, $0F, $6D ; SPRITE 6D   | xy: { 0x0F0, 0x080, L } | s: 0x00
    db $88, $10, $6D ; SPRITE 6D   | xy: { 0x100, 0x080, L } | s: 0x00
    db $89, $18, $6D ; SPRITE 6D   | xy: { 0x180, 0x090, L } | s: 0x00
    db $97, $EF, $06 ; OVERLORD 06 | xy: { 0x0F0, 0x170, L }
    db $98, $E9, $06 ; OVERLORD 06 | xy: { 0x090, 0x180, L }
    db $98, $EB, $06 ; OVERLORD 06 | xy: { 0x0B0, 0x180, L }
    db $99, $EA, $06 ; OVERLORD 06 | xy: { 0x0A0, 0x190, L }
    db $99, $EC, $06 ; OVERLORD 06 | xy: { 0x0C0, 0x190, L }
    db $9A, $E9, $06 ; OVERLORD 06 | xy: { 0x090, 0x1A0, L }
    db $9B, $EB, $06 ; OVERLORD 06 | xy: { 0x0B0, 0x1B0, L }
    db $97, $0A, $06 ; SPRITE 06   | xy: { 0x0A0, 0x170, L } | s: 0x00
    db $97, $15, $04 ; SPRITE 04   | xy: { 0x150, 0x170, L } | s: 0x00
    db $9A, $0D, $6D ; SPRITE 6D   | xy: { 0x0D0, 0x1A0, L } | s: 0x00
    db $9A, $12, $6D ; SPRITE 6D   | xy: { 0x120, 0x1A0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D965-$04D996 DATA
RoomData_Sprites_Room0004:
{
    db $00 ; Unlayered OAM
    db $04, $09, $1E ; SPRITE 1E   | xy: { 0x090, 0x040, U } | s: 0x00
    db $04, $14, $5D ; SPRITE 5D   | xy: { 0x140, 0x040, U } | s: 0x00
    db $04, $1B, $60 ; SPRITE 60   | xy: { 0x1B0, 0x040, U } | s: 0x00
    db $07, $05, $5F ; SPRITE 5F   | xy: { 0x050, 0x070, U } | s: 0x00
    db $09, $15, $5F ; SPRITE 5F   | xy: { 0x150, 0x090, U } | s: 0x00
    db $12, $E7, $16 ; OVERLORD 16 | xy: { 0x070, 0x120, U }
    db $15, $15, $04 ; SPRITE 04   | xy: { 0x150, 0x150, U } | s: 0x00
    db $15, $1A, $06 ; SPRITE 06   | xy: { 0x1A0, 0x150, U } | s: 0x00
    db $15, $F8, $1A ; OVERLORD 1A | xy: { 0x180, 0x150, U }
    db $15, $1C, $8F ; SPRITE 8F   | xy: { 0x1C0, 0x150, U } | s: 0x00
    db $17, $F6, $1A ; OVERLORD 1A | xy: { 0x160, 0x170, U }
    db $17, $FA, $1A ; OVERLORD 1A | xy: { 0x1A0, 0x170, U }
    db $18, $F8, $1A ; OVERLORD 1A | xy: { 0x180, 0x180, U }
    db $1A, $1A, $8F ; SPRITE 8F   | xy: { 0x1A0, 0x1A0, U } | s: 0x00
    db $1B, $15, $8F ; SPRITE 8F   | xy: { 0x150, 0x1B0, U } | s: 0x00
    db $18, $07, $C7 ; SPRITE C7   | xy: { 0x070, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D997-$04D9C2 DATA
RoomData_Sprites_Room0006:
{
    db $00 ; Unlayered OAM
    db $17, $07, $8C ; SPRITE 8C   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $07, $8D ; SPRITE 8D   | xy: { 0x070, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D9C3-$04D9C7 DATA
RoomData_Sprites_Room0007:
{
    db $00 ; Unlayered OAM
    db $0E, $12, $09 ; SPRITE 09   | xy: { 0x120, 0x0E0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D9C8-$04D9CC DATA
RoomData_Sprites_Room0008:
{
    db $00 ; Unlayered OAM
    db $16, $07, $C8 ; SPRITE C8   | xy: { 0x070, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D9CD-$04D9D7 DATA
RoomData_Sprites_Room0009:
{
    db $00 ; Unlayered OAM
    db $08, $07, $C5 ; SPRITE C5   | xy: { 0x070, 0x080, U } | s: 0x00
    db $08, $08, $C5 ; SPRITE C5   | xy: { 0x080, 0x080, U } | s: 0x00
    db $0B, $17, $15 ; SPRITE 15   | xy: { 0x170, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04D9D8-$04D9EE DATA
RoomData_Sprites_Room000A:
{
    db $00 ; Unlayered OAM
    db $08, $17, $8E ; SPRITE 8E   | xy: { 0x170, 0x080, U } | s: 0x00
    db $09, $17, $8E ; SPRITE 8E   | xy: { 0x170, 0x090, U } | s: 0x00
    db $09, $ED, $05 ; OVERLORD 05 | xy: { 0x0D0, 0x090, U }
    db $09, $F1, $05 ; OVERLORD 05 | xy: { 0x110, 0x090, U }
    db $0B, $F3, $17 ; OVERLORD 17 | xy: { 0x130, 0x0B0, U }
    db $0E, $ED, $05 ; OVERLORD 05 | xy: { 0x0D0, 0x0E0, U }
    db $0E, $F1, $05 ; OVERLORD 05 | xy: { 0x110, 0x0E0, U }
    db $FF ; END
}

; ==============================================================================

; $04D9EF-$04DA0E DATA
RoomData_Sprites_Room000B:
{
    db $00 ; Unlayered OAM
    db $04, $1C, $1E ; SPRITE 1E   | xy: { 0x1C0, 0x040, U } | s: 0x00
    db $08, $07, $8E ; SPRITE 8E   | xy: { 0x070, 0x080, U } | s: 0x00
    db $0B, $16, $8E ; SPRITE 8E   | xy: { 0x160, 0x0B0, U } | s: 0x00
    db $0B, $1B, $8E ; SPRITE 8E   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $16, $05, $8E ; SPRITE 8E   | xy: { 0x050, 0x160, U } | s: 0x00
    db $16, $0A, $8E ; SPRITE 8E   | xy: { 0x0A0, 0x160, U } | s: 0x00
    db $19, $07, $8E ; SPRITE 8E   | xy: { 0x070, 0x190, U } | s: 0x00
    db $19, $08, $8E ; SPRITE 8E   | xy: { 0x080, 0x190, U } | s: 0x00
    db $1B, $06, $8E ; SPRITE 8E   | xy: { 0x060, 0x1B0, U } | s: 0x00
    db $1B, $09, $8E ; SPRITE 8E   | xy: { 0x090, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA0F-$04DA13 DATA
RoomData_Sprites_Room000D:
{
    db $00 ; Unlayered OAM
    db $15, $07, $7A ; SPRITE 7A   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA14-$04DA24 DATA
RoomData_Sprites_Room000E:
{
    db $00 ; Unlayered OAM
    db $12, $16, $A1 ; SPRITE A1   | xy: { 0x160, 0x120, U } | s: 0x00
    db $16, $05, $24 ; SPRITE 24   | xy: { 0x050, 0x160, U } | s: 0x00
    db $18, $05, $24 ; SPRITE 24   | xy: { 0x050, 0x180, U } | s: 0x00
    db $1A, $05, $24 ; SPRITE 24   | xy: { 0x050, 0x1A0, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $FF ; END
}

; ==============================================================================

; $04DA25-$04DA3E DATA
RoomData_Sprites_Room0011:
{
    db $00 ; Unlayered OAM
    db $0A, $17, $6D ; SPRITE 6D   | xy: { 0x170, 0x0A0, U } | s: 0x00
    db $0A, $18, $6D ; SPRITE 6D   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $0C, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x0C0, U } | s: 0x00
    db $0C, $18, $6F ; SPRITE 6F   | xy: { 0x180, 0x0C0, U } | s: 0x00
    db $11, $1C, $6D ; SPRITE 6D   | xy: { 0x1C0, 0x110, U } | s: 0x00
    db $12, $1C, $6D ; SPRITE 6D   | xy: { 0x1C0, 0x120, U } | s: 0x00
    db $16, $1A, $6D ; SPRITE 6D   | xy: { 0x1A0, 0x160, U } | s: 0x00
    db $16, $1B, $6D ; SPRITE 6D   | xy: { 0x1B0, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA3F-$04DA46 DATA
RoomData_Sprites_Room0012:
{
    db $00 ; Unlayered OAM
    db $07, $0F, $73 ; SPRITE 73   | xy: { 0x0F0, 0x070, U } | s: 0x00
    db $06, $10, $76 ; SPRITE 76   | xy: { 0x100, 0x060, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA47-$04DA69 DATA
RoomData_Sprites_Room0013:
{
    db $00 ; Unlayered OAM
    db $11, $14, $1E ; SPRITE 1E   | xy: { 0x140, 0x110, U } | s: 0x00
    db $04, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x040, U } | s: 0x00
    db $04, $1A, $15 ; SPRITE 15   | xy: { 0x1A0, 0x040, U } | s: 0x00
    db $05, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x050, U } | s: 0x00
    db $05, $1A, $15 ; SPRITE 15   | xy: { 0x1A0, 0x050, U } | s: 0x00
    db $16, $1B, $7C ; SPRITE 7C   | xy: { 0x1B0, 0x160, U } | s: 0x00
    db $18, $16, $C7 ; SPRITE C7   | xy: { 0x160, 0x180, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $18, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x180, U } | s: 0x00
    db $1A, $14, $7C ; SPRITE 7C   | xy: { 0x140, 0x1A0, U } | s: 0x00
    db $1B, $1B, $D1 ; SPRITE D1   | xy: { 0x1B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA6A-$04DA89 DATA
RoomData_Sprites_Room0014:
{
    db $01 ; Layered OAM
    db $84, $0C, $B0 ; SPRITE B0   | xy: { 0x0C0, 0x040, L } | s: 0x00
    db $8A, $0F, $AF ; SPRITE AF   | xy: { 0x0F0, 0x0A0, L } | s: 0x00
    db $8A, $19, $AE ; SPRITE AE   | xy: { 0x190, 0x0A0, L } | s: 0x00
    db $8D, $03, $AE ; SPRITE AE   | xy: { 0x030, 0x0D0, L } | s: 0x00
    db $8D, $1B, $AE ; SPRITE AE   | xy: { 0x1B0, 0x0D0, L } | s: 0x00
    db $93, $0F, $AE ; SPRITE AE   | xy: { 0x0F0, 0x130, L } | s: 0x00
    db $98, $08, $B0 ; SPRITE B0   | xy: { 0x080, 0x180, L } | s: 0x00
    db $98, $17, $B1 ; SPRITE B1   | xy: { 0x170, 0x180, L } | s: 0x00
    db $9B, $0C, $B0 ; SPRITE B0   | xy: { 0x0C0, 0x1B0, L } | s: 0x00
    db $9B, $13, $B1 ; SPRITE B1   | xy: { 0x130, 0x1B0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DA8A-$04DAA9 DATA
RoomData_Sprites_Room0015:
{
    db $01 ; Layered OAM
    db $8C, $04, $AE ; SPRITE AE   | xy: { 0x040, 0x0C0, L } | s: 0x00
    db $91, $11, $AE ; SPRITE AE   | xy: { 0x110, 0x110, L } | s: 0x00
    db $97, $04, $AF ; SPRITE AF   | xy: { 0x040, 0x170, L } | s: 0x00
    db $9B, $16, $B1 ; SPRITE B1   | xy: { 0x160, 0x1B0, L } | s: 0x00
    db $89, $0A, $8F ; SPRITE 8F   | xy: { 0x0A0, 0x090, L } | s: 0x00
    db $89, $15, $8F ; SPRITE 8F   | xy: { 0x150, 0x090, L } | s: 0x00
    db $8A, $09, $15 ; SPRITE 15   | xy: { 0x090, 0x0A0, L } | s: 0x00
    db $96, $18, $C7 ; SPRITE C7   | xy: { 0x180, 0x160, L } | s: 0x00
    db $97, $08, $15 ; SPRITE 15   | xy: { 0x080, 0x170, L } | s: 0x00
    db $97, $17, $15 ; SPRITE 15   | xy: { 0x170, 0x170, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DAAA-$04DAC0 DATA
RoomData_Sprites_Room0016:
{
    db $00 ; Unlayered OAM
    db $07, $15, $8F ; SPRITE 8F   | xy: { 0x150, 0x070, U } | s: 0x00
    db $08, $15, $8F ; SPRITE 8F   | xy: { 0x150, 0x080, U } | s: 0x00
    db $09, $15, $24 ; SPRITE 24   | xy: { 0x150, 0x090, U } | s: 0x00
    db $0A, $10, $8F ; SPRITE 8F   | xy: { 0x100, 0x0A0, U } | s: 0x00
    db $98, $0C, $81 ; SPRITE 81   | xy: { 0x0C0, 0x180, L } | s: 0x00
    db $9B, $07, $81 ; SPRITE 81   | xy: { 0x070, 0x1B0, L } | s: 0x00
    db $9B, $14, $81 ; SPRITE 81   | xy: { 0x140, 0x1B0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DAC1-$04DADD DATA
RoomData_Sprites_Room0017:
{
    db $00 ; Unlayered OAM
    db $0B, $07, $93 ; SPRITE 93   | xy: { 0x070, 0x0B0, U } | s: 0x00
    db $0E, $10, $93 ; SPRITE 93   | xy: { 0x100, 0x0E0, U } | s: 0x00
    db $16, $07, $93 ; SPRITE 93   | xy: { 0x070, 0x160, U } | s: 0x00
    db $07, $15, $26 ; SPRITE 26   | xy: { 0x150, 0x070, U } | s: 0x00
    db $09, $0B, $26 ; SPRITE 26   | xy: { 0x0B0, 0x090, U } | s: 0x00
    db $11, $06, $7E ; SPRITE 7E   | xy: { 0x060, 0x110, U } | s: 0x00
    db $11, $12, $26 ; SPRITE 26   | xy: { 0x120, 0x110, U } | s: 0x00
    db $17, $0B, $26 ; SPRITE 26   | xy: { 0x0B0, 0x170, U } | s: 0x00
    db $17, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DADE-$04DAEB DATA
RoomData_Sprites_Room0019:
{
    db $00 ; Unlayered OAM
    db $0A, $16, $86 ; SPRITE 86   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0E, $1A, $86 ; SPRITE 86   | xy: { 0x1A0, 0x0E0, U } | s: 0x00
    db $10, $16, $86 ; SPRITE 86   | xy: { 0x160, 0x100, U } | s: 0x00
    db $16, $18, $86 ; SPRITE 86   | xy: { 0x180, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DAEC-$04DB0E DATA
RoomData_Sprites_Room001A:
{
    db $00 ; Unlayered OAM
    db $06, $08, $13 ; SPRITE 13   | xy: { 0x080, 0x060, U } | s: 0x00
    db $06, $16, $8E ; SPRITE 8E   | xy: { 0x160, 0x060, U } | s: 0x00
    db $06, $19, $8E ; SPRITE 8E   | xy: { 0x190, 0x060, U } | s: 0x00
    db $0A, $16, $8E ; SPRITE 8E   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0A, $19, $8E ; SPRITE 8E   | xy: { 0x190, 0x0A0, U } | s: 0x00
    db $10, $07, $13 ; SPRITE 13   | xy: { 0x070, 0x100, U } | s: 0x00
    db $15, $16, $8A ; SPRITE 8A   | xy: { 0x160, 0x150, U } | s: 0x00
    db $17, $16, $8A ; SPRITE 8A   | xy: { 0x160, 0x170, U } | s: 0x00
    db $19, $15, $1C ; SPRITE 1C   | xy: { 0x150, 0x190, U } | s: 0x00
    db $19, $16, $8A ; SPRITE 8A   | xy: { 0x160, 0x190, U } | s: 0x00
    db $1A, $E7, $0B ; OVERLORD 0B | xy: { 0x070, 0x1A0, U }
    db $FF ; END
}

; ==============================================================================

; $04DB0F-$04DB22 DATA
RoomData_Sprites_Room001B:
{
    db $00 ; Unlayered OAM
    db $04, $07, $1E ; SPRITE 1E   | xy: { 0x070, 0x040, U } | s: 0x00
    db $04, $10, $38 ; SPRITE 38   | xy: { 0x100, 0x040, U } | s: 0x00
    db $0C, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x0C0, U } | s: 0x00
    db $14, $07, $84 ; SPRITE 84   | xy: { 0x070, 0x140, U } | s: 0x00
    db $1C, $03, $83 ; SPRITE 83   | xy: { 0x030, 0x1C0, U } | s: 0x00
    db $1C, $0C, $83 ; SPRITE 83   | xy: { 0x0C0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DB23-$04DB45 DATA
RoomData_Sprites_Room001C:
{
    db $00 ; Unlayered OAM
    db $15, $14, $53 ; SPRITE 53   | xy: { 0x140, 0x150, U } | s: 0x00
    db $15, $17, $53 ; SPRITE 53   | xy: { 0x170, 0x150, U } | s: 0x00
    db $15, $1A, $53 ; SPRITE 53   | xy: { 0x1A0, 0x150, U } | s: 0x00
    db $18, $1A, $53 ; SPRITE 53   | xy: { 0x1A0, 0x180, U } | s: 0x00
    db $18, $17, $53 ; SPRITE 53   | xy: { 0x170, 0x180, U } | s: 0x00
    db $18, $14, $53 ; SPRITE 53   | xy: { 0x140, 0x180, U } | s: 0x00
    db $18, $F7, $19 ; OVERLORD 19 | xy: { 0x170, 0x180, U }
    db $07, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x070, U } | s: 0x00
    db $07, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x070, U } | s: 0x00
    db $08, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x080, U } | s: 0x00
    db $08, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x080, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DB46-$04DB5C DATA
RoomData_Sprites_Room001E:
{
    db $00 ; Unlayered OAM
    db $09, $1A, $1E ; SPRITE 1E   | xy: { 0x1A0, 0x090, U } | s: 0x00
    db $05, $16, $23 ; SPRITE 23   | xy: { 0x160, 0x050, U } | s: 0x00
    db $05, $19, $23 ; SPRITE 23   | xy: { 0x190, 0x050, U } | s: 0x00
    db $0A, $16, $23 ; SPRITE 23   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0A, $19, $23 ; SPRITE 23   | xy: { 0x190, 0x0A0, U } | s: 0x00
    db $18, $08, $8F ; SPRITE 8F   | xy: { 0x080, 0x180, U } | s: 0x00
    db $1C, $05, $8F ; SPRITE 8F   | xy: { 0x050, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DB5D-$04DB76 DATA
RoomData_Sprites_Room001F:
{
    db $00 ; Unlayered OAM
    db $15, $04, $99 ; SPRITE 99   | xy: { 0x040, 0x150, U } | s: 0x00
    db $15, $09, $99 ; SPRITE 99   | xy: { 0x090, 0x150, U } | s: 0x00
    db $16, $06, $15 ; SPRITE 15   | xy: { 0x060, 0x160, U } | s: 0x00
    db $17, $07, $D1 ; SPRITE D1   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $0A, $99 ; SPRITE 99   | xy: { 0x0A0, 0x170, U } | s: 0x00
    db $19, $0A, $99 ; SPRITE 99   | xy: { 0x0A0, 0x190, U } | s: 0x00
    db $1B, $04, $99 ; SPRITE 99   | xy: { 0x040, 0x1B0, U } | s: 0x00
    db $1B, $09, $99 ; SPRITE 99   | xy: { 0x090, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DB77-$04DB7B DATA
RoomData_Sprites_Room0020:
{
    db $00 ; Unlayered OAM
    db $15, $07, $7A ; SPRITE 7A   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DB7C-$04DBA1 DATA
RoomData_Sprites_Room0021:
{
    db $00 ; Unlayered OAM
    db $06, $05, $6D ; SPRITE 6D   | xy: { 0x050, 0x060, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $06, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x060, U } | s: 0x00
    db $06, $18, $6F ; SPRITE 6F   | xy: { 0x180, 0x060, U } | s: 0x00
    db $09, $11, $6D ; SPRITE 6D   | xy: { 0x110, 0x090, U } | s: 0x00
    db $0A, $0D, $6D ; SPRITE 6D   | xy: { 0x0D0, 0x0A0, U } | s: 0x00
    db $14, $07, $6D ; SPRITE 6D   | xy: { 0x070, 0x140, U } | s: 0x00
    db $14, $0D, $6F ; SPRITE 6F   | xy: { 0x0D0, 0x140, U } | s: 0x00
    db $14, $12, $6F ; SPRITE 6F   | xy: { 0x120, 0x140, U } | s: 0x00
    db $18, $0D, $6D ; SPRITE 6D   | xy: { 0x0D0, 0x180, U } | s: 0x00
    db $1C, $0A, $6D ; SPRITE 6D   | xy: { 0x0A0, 0x1C0, U } | s: 0x00
    db $1C, $13, $6D ; SPRITE 6D   | xy: { 0x130, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DBA2-$04DBB8 DATA
RoomData_Sprites_Room0022:
{
    db $00 ; Unlayered OAM
    db $14, $06, $6D ; SPRITE 6D   | xy: { 0x060, 0x140, U } | s: 0x00
    db $14, $08, $6D ; SPRITE 6D   | xy: { 0x080, 0x140, U } | s: 0x00
    db $14, $11, $6D ; SPRITE 6D   | xy: { 0x110, 0x140, U } | s: 0x00
    db $14, $12, $6D ; SPRITE 6D   | xy: { 0x120, 0x140, U } | s: 0x00
    db $15, $11, $6D ; SPRITE 6D   | xy: { 0x110, 0x150, U } | s: 0x00
    db $15, $12, $6D ; SPRITE 6D   | xy: { 0x120, 0x150, U } | s: 0x00
    db $18, $09, $6D ; SPRITE 6D   | xy: { 0x090, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DBB9-$04DBC9 DATA
RoomData_Sprites_Room0023:
{
    db $00 ; Unlayered OAM
    db $14, $15, $97 ; SPRITE 97   | xy: { 0x150, 0x140, U } | s: 0x00
    db $14, $16, $97 ; SPRITE 97   | xy: { 0x160, 0x140, U } | s: 0x00
    db $14, $17, $97 ; SPRITE 97   | xy: { 0x170, 0x140, U } | s: 0x00
    db $14, $18, $97 ; SPRITE 97   | xy: { 0x180, 0x140, U } | s: 0x00
    db $14, $19, $97 ; SPRITE 97   | xy: { 0x190, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DBCA-$04DBE0 DATA
RoomData_Sprites_Room0024:
{
    db $00 ; Unlayered OAM
    db $04, $13, $C5 ; SPRITE C5   | xy: { 0x130, 0x040, U } | s: 0x00
    db $04, $1C, $C5 ; SPRITE C5   | xy: { 0x1C0, 0x040, U } | s: 0x00
    db $06, $1B, $60 ; SPRITE 60   | xy: { 0x1B0, 0x060, U } | s: 0x00
    db $08, $05, $C7 ; SPRITE C7   | xy: { 0x050, 0x080, U } | s: 0x00
    db $08, $07, $C5 ; SPRITE C5   | xy: { 0x070, 0x080, U } | s: 0x00
    db $08, $0A, $C7 ; SPRITE C7   | xy: { 0x0A0, 0x080, U } | s: 0x00
    db $0C, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DBE1-$04DBE2 DATA
RoomData_Sprites_Room0025:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04DBE3-$04DC08 DATA
RoomData_Sprites_Room0026:
{
    db $00 ; Unlayered OAM
    db $04, $03, $C5 ; SPRITE C5   | xy: { 0x030, 0x040, U } | s: 0x00
    db $05, $1A, $23 ; SPRITE 23   | xy: { 0x1A0, 0x050, U } | s: 0x00
    db $06, $05, $23 ; SPRITE 23   | xy: { 0x050, 0x060, U } | s: 0x00
    db $06, $09, $A7 ; SPRITE A7   | xy: { 0x090, 0x060, U } | s: 0x00
    db $09, $04, $A7 ; SPRITE A7   | xy: { 0x040, 0x090, U } | s: 0x00
    db $0C, $0C, $C5 ; SPRITE C5   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $17, $06, $1C ; SPRITE 1C   | xy: { 0x060, 0x170, U } | s: 0x00
    db $17, $19, $C6 ; SPRITE C6   | xy: { 0x190, 0x170, U } | s: 0x00
    db $18, $07, $23 ; SPRITE 23   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $15, $9A ; SPRITE 9A   | xy: { 0x150, 0x180, U } | s: 0x00
    db $19, $18, $24 ; SPRITE 24   | xy: { 0x180, 0x190, U } | s: 0x00
    db $1A, $1C, $80 ; SPRITE 80   | xy: { 0x1C0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC09-$04DC1F DATA
RoomData_Sprites_Room0027:
{
    db $00 ; Unlayered OAM
    db $09, $17, $18 ; SPRITE 18   | xy: { 0x170, 0x090, U } | s: 0x00
    db $13, $18, $18 ; SPRITE 18   | xy: { 0x180, 0x130, U } | s: 0x00
    db $13, $1B, $18 ; SPRITE 18   | xy: { 0x1B0, 0x130, U } | s: 0x00
    db $1A, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x1A0, U } | s: 0x00
    db $06, $0F, $5B ; SPRITE 5B   | xy: { 0x0F0, 0x060, U } | s: 0x00
    db $0E, $05, $86 ; SPRITE 86   | xy: { 0x050, 0x0E0, U } | s: 0x00
    db $16, $04, $86 ; SPRITE 86   | xy: { 0x040, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC20-$04DC30 DATA
RoomData_Sprites_Room0028:
{
    db $00 ; Unlayered OAM
    db $06, $0A, $9A ; SPRITE 9A   | xy: { 0x0A0, 0x060, U } | s: 0x00
    db $08, $08, $81 ; SPRITE 81   | xy: { 0x080, 0x080, U } | s: 0x00
    db $0A, $0B, $81 ; SPRITE 81   | xy: { 0x0B0, 0x0A0, U } | s: 0x00
    db $0D, $07, $81 ; SPRITE 81   | xy: { 0x070, 0x0D0, U } | s: 0x00
    db $10, $08, $8A ; SPRITE 8A   | xy: { 0x080, 0x100, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC31-$04DC38 DATA
RoomData_Sprites_Room0029:
{
    db $00 ; Unlayered OAM
    db $16, $18, $88 ; SPRITE 88   | xy: { 0x180, 0x160, U } | s: 0x00
    db $16, $E7, $07 ; OVERLORD 07 | xy: { 0x070, 0x160, U }
    db $FF ; END
}

; ==============================================================================

; $04DC39-$04DC52 DATA
RoomData_Sprites_Room002A:
{
    db $00 ; Unlayered OAM
    db $17, $10, $1E ; SPRITE 1E   | xy: { 0x100, 0x170, U } | s: 0x00
    db $0F, $0F, $93 ; SPRITE 93   | xy: { 0x0F0, 0x0F0, U } | s: 0x00
    db $08, $0D, $26 ; SPRITE 26   | xy: { 0x0D0, 0x080, U } | s: 0x00
    db $0C, $07, $26 ; SPRITE 26   | xy: { 0x070, 0x0C0, U } | s: 0x00
    db $0C, $10, $26 ; SPRITE 26   | xy: { 0x100, 0x0C0, U } | s: 0x00
    db $0F, $0D, $26 ; SPRITE 26   | xy: { 0x0D0, 0x0F0, U } | s: 0x00
    db $11, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x110, U } | s: 0x00
    db $13, $0F, $26 ; SPRITE 26   | xy: { 0x0F0, 0x130, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC53-$04DC6C DATA
RoomData_Sprites_Room002B:
{
    db $00 ; Unlayered OAM
    db $11, $0A, $1E ; SPRITE 1E   | xy: { 0x0A0, 0x110, U } | s: 0x00
    db $0A, $0A, $1C ; SPRITE 1C   | xy: { 0x0A0, 0x0A0, U } | s: 0x00
    db $17, $07, $23 ; SPRITE 23   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $16, $E3 ; SPRITE E3   | xy: { 0x160, 0x170, U } | s: 0x00
    db $18, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x180, U } | s: 0x00
    db $1A, $05, $23 ; SPRITE 23   | xy: { 0x050, 0x1A0, U } | s: 0x00
    db $1A, $0A, $23 ; SPRITE 23   | xy: { 0x0A0, 0x1A0, U } | s: 0x00
    db $1A, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC6D-$04DC7A DATA
RoomData_Sprites_Room002C:
{
    db $00 ; Unlayered OAM
    db $05, $17, $C8 ; SPRITE C8   | xy: { 0x170, 0x050, U } | s: 0x00
    db $04, $09, $E3 ; SPRITE E3   | xy: { 0x090, 0x040, U } | s: 0x00
    db $05, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x050, U } | s: 0x00
    db $07, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC7B-$04DC8E DATA
RoomData_Sprites_Room002E:
{
    db $00 ; Unlayered OAM
    db $06, $14, $99 ; SPRITE 99   | xy: { 0x140, 0x060, U } | s: 0x00
    db $06, $1C, $99 ; SPRITE 99   | xy: { 0x1C0, 0x060, U } | s: 0x00
    db $08, $16, $99 ; SPRITE 99   | xy: { 0x160, 0x080, U } | s: 0x00
    db $08, $19, $99 ; SPRITE 99   | xy: { 0x190, 0x080, U } | s: 0x00
    db $0B, $14, $99 ; SPRITE 99   | xy: { 0x140, 0x0B0, U } | s: 0x00
    db $0B, $1B, $99 ; SPRITE 99   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC8F-$04DC93 DATA
RoomData_Sprites_Room0030:
{
    db $00 ; Unlayered OAM
    db $05, $07, $C1 ; SPRITE C1   | xy: { 0x070, 0x050, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DC94-$04DCB9 DATA
RoomData_Sprites_Room0031:
{
    db $00 ; Unlayered OAM
    db $1A, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x1A0, U } | s: 0x00
    db $0B, $16, $1E ; SPRITE 1E   | xy: { 0x160, 0x0B0, U } | s: 0x00
    db $05, $15, $26 ; SPRITE 26   | xy: { 0x150, 0x050, U } | s: 0x00
    db $06, $05, $26 ; SPRITE 26   | xy: { 0x050, 0x060, U } | s: 0x00
    db $09, $03, $26 ; SPRITE 26   | xy: { 0x030, 0x090, U } | s: 0x00
    db $0C, $0B, $26 ; SPRITE 26   | xy: { 0x0B0, 0x0C0, U } | s: 0x00
    db $15, $03, $26 ; SPRITE 26   | xy: { 0x030, 0x150, U } | s: 0x00
    db $15, $1B, $26 ; SPRITE 26   | xy: { 0x1B0, 0x150, U } | s: 0x00
    db $16, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x160, U } | s: 0x00
    db $18, $03, $26 ; SPRITE 26   | xy: { 0x030, 0x180, U } | s: 0x00
    db $19, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x190, U } | s: 0x00
    db $1C, $09, $26 ; SPRITE 26   | xy: { 0x090, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DCBA-$04DCCA DATA
RoomData_Sprites_Room0032:
{
    db $00 ; Unlayered OAM
    db $0D, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x0D0, U } | s: 0x00
    db $0D, $0F, $6E ; SPRITE 6E   | xy: { 0x0F0, 0x0D0, U } | s: 0x00
    db $0D, $13, $6F ; SPRITE 6F   | xy: { 0x130, 0x0D0, U } | s: 0x00
    db $0E, $10, $6E ; SPRITE 6E   | xy: { 0x100, 0x0E0, U } | s: 0x00
    db $0F, $12, $6E ; SPRITE 6E   | xy: { 0x120, 0x0F0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DCCB-$04DCD5 DATA
RoomData_Sprites_Room0033:
{
    db $00 ; Unlayered OAM
    db $17, $06, $54 ; SPRITE 54   | xy: { 0x060, 0x170, U } | s: 0x00
    db $17, $09, $54 ; SPRITE 54   | xy: { 0x090, 0x170, U } | s: 0x00
    db $19, $07, $54 ; SPRITE 54   | xy: { 0x070, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DCD6-$04DCEC DATA
RoomData_Sprites_Room0034:
{
    db $00 ; Unlayered OAM
    db $0B, $0F, $81 ; SPRITE 81   | xy: { 0x0F0, 0x0B0, U } | s: 0x00
    db $12, $10, $81 ; SPRITE 81   | xy: { 0x100, 0x120, U } | s: 0x00
    db $15, $0F, $9A ; SPRITE 9A   | xy: { 0x0F0, 0x150, U } | s: 0x00
    db $17, $19, $80 ; SPRITE 80   | xy: { 0x190, 0x170, U } | s: 0x00
    db $18, $03, $8F ; SPRITE 8F   | xy: { 0x030, 0x180, U } | s: 0x00
    db $18, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x180, U } | s: 0x00
    db $1A, $16, $A7 ; SPRITE A7   | xy: { 0x160, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DCED-$04DD0F DATA
RoomData_Sprites_Room0035:
{
    db $00 ; Unlayered OAM
    db $06, $16, $1E ; SPRITE 1E   | xy: { 0x160, 0x060, U } | s: 0x00
    db $05, $14, $21 ; SPRITE 21   | xy: { 0x140, 0x050, U } | s: 0x00
    db $05, $18, $23 ; SPRITE 23   | xy: { 0x180, 0x050, U } | s: 0x00
    db $09, $13, $8A ; SPRITE 8A   | xy: { 0x130, 0x090, U } | s: 0x00
    db $0B, $14, $A7 ; SPRITE A7   | xy: { 0x140, 0x0B0, U } | s: 0x00
    db $14, $07, $8F ; SPRITE 8F   | xy: { 0x070, 0x140, U } | s: 0x00
    db $18, $14, $A7 ; SPRITE A7   | xy: { 0x140, 0x180, U } | s: 0x00
    db $19, $16, $80 ; SPRITE 80   | xy: { 0x160, 0x190, U } | s: 0x00
    db $1A, $17, $C6 ; SPRITE C6   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $1B, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $1C, $1B, $A7 ; SPRITE A7   | xy: { 0x1B0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DD10-$04DD32 DATA
RoomData_Sprites_Room0036:
{
    db $00 ; Unlayered OAM
    db $02, $F7, $12 ; OVERLORD 12 | xy: { 0x170, 0x020, U }
    db $0A, $0B, $81 ; SPRITE 81   | xy: { 0x0B0, 0x0A0, U } | s: 0x00
    db $0A, $14, $81 ; SPRITE 81   | xy: { 0x140, 0x0A0, U } | s: 0x00
    db $0B, $15, $C5 ; SPRITE C5   | xy: { 0x150, 0x0B0, U } | s: 0x00
    db $0D, $E1, $10 ; OVERLORD 10 | xy: { 0x010, 0x0D0, U }
    db $13, $14, $9A ; SPRITE 9A   | xy: { 0x140, 0x130, U } | s: 0x00
    db $13, $FE, $11 ; OVERLORD 11 | xy: { 0x1E0, 0x130, U }
    db $14, $09, $81 ; SPRITE 81   | xy: { 0x090, 0x140, U } | s: 0x00
    db $17, $12, $81 ; SPRITE 81   | xy: { 0x120, 0x170, U } | s: 0x00
    db $1E, $EA, $13 ; OVERLORD 13 | xy: { 0x0A0, 0x1E0, U }
    db $1E, $F4, $13 ; OVERLORD 13 | xy: { 0x140, 0x1E0, U }
    db $FF ; END
}

; ==============================================================================

; $04DD33-$04DD52 DATA
RoomData_Sprites_Room0037:
{
    db $00 ; Unlayered OAM
    db $04, $0B, $21 ; SPRITE 21   | xy: { 0x0B0, 0x040, U } | s: 0x00
    db $06, $05, $A7 ; SPRITE A7   | xy: { 0x050, 0x060, U } | s: 0x00
    db $08, $17, $8F ; SPRITE 8F   | xy: { 0x170, 0x080, U } | s: 0x00
    db $08, $1A, $8F ; SPRITE 8F   | xy: { 0x1A0, 0x080, U } | s: 0x00
    db $09, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x090, U } | s: 0x00
    db $14, $15, $80 ; SPRITE 80   | xy: { 0x150, 0x140, U } | s: 0x00
    db $17, $17, $A7 ; SPRITE A7   | xy: { 0x170, 0x170, U } | s: 0x00
    db $19, $13, $24 ; SPRITE 24   | xy: { 0x130, 0x190, U } | s: 0x00
    db $1A, $17, $C6 ; SPRITE C6   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $1C, $15, $23 ; SPRITE 23   | xy: { 0x150, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DD53-$04DD69 DATA
RoomData_Sprites_Room0038:
{
    db $00 ; Unlayered OAM
    db $06, $0C, $81 ; SPRITE 81   | xy: { 0x0C0, 0x060, U } | s: 0x00
    db $0A, $07, $81 ; SPRITE 81   | xy: { 0x070, 0x0A0, U } | s: 0x00
    db $0C, $0C, $9A ; SPRITE 9A   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $10, $0C, $C5 ; SPRITE C5   | xy: { 0x0C0, 0x100, U } | s: 0x00
    db $14, $06, $9A ; SPRITE 9A   | xy: { 0x060, 0x140, U } | s: 0x00
    db $18, $0C, $9A ; SPRITE 9A   | xy: { 0x0C0, 0x180, U } | s: 0x00
    db $1A, $07, $81 ; SPRITE 81   | xy: { 0x070, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DD6A-$04DD83 DATA
RoomData_Sprites_Room0039:
{
    db $00 ; Unlayered OAM
    db $18, $04, $18 ; SPRITE 18   | xy: { 0x040, 0x180, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $15, $05, $8B ; SPRITE 8B   | xy: { 0x050, 0x150, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $15, $09, $13 ; SPRITE 13   | xy: { 0x090, 0x150, U } | s: 0x00
    db $16, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x160, U } | s: 0x00
    db $18, $0B, $26 ; SPRITE 26   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $1A, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DD84-$04DD97 DATA
RoomData_Sprites_Room003A:
{
    db $00 ; Unlayered OAM
    db $11, $0E, $8E ; SPRITE 8E   | xy: { 0x0E0, 0x110, U } | s: 0x00
    db $11, $11, $8E ; SPRITE 8E   | xy: { 0x110, 0x110, U } | s: 0x00
    db $14, $04, $C5 ; SPRITE C5   | xy: { 0x040, 0x140, U } | s: 0x00
    db $14, $0A, $24 ; SPRITE 24   | xy: { 0x0A0, 0x140, U } | s: 0x00
    db $14, $15, $24 ; SPRITE 24   | xy: { 0x150, 0x140, U } | s: 0x00
    db $14, $1B, $C5 ; SPRITE C5   | xy: { 0x1B0, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DD98-$04DDAE DATA
RoomData_Sprites_Room003B:
{
    db $00 ; Unlayered OAM
    db $06, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x060, U } | s: 0x00
    db $09, $07, $23 ; SPRITE 23   | xy: { 0x070, 0x090, U } | s: 0x00
    db $0D, $0C, $8A ; SPRITE 8A   | xy: { 0x0C0, 0x0D0, U } | s: 0x00
    db $0F, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x0F0, U } | s: 0x00
    db $13, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x130, U } | s: 0x00
    db $16, $07, $24 ; SPRITE 24   | xy: { 0x070, 0x160, U } | s: 0x00
    db $1A, $0C, $8A ; SPRITE 8A   | xy: { 0x0C0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DDAF-$04DDB9 DATA
RoomData_Sprites_Room003C:
{
    db $00 ; Unlayered OAM
    db $08, $09, $26 ; SPRITE 26   | xy: { 0x090, 0x080, U } | s: 0x00
    db $14, $0A, $24 ; SPRITE 24   | xy: { 0x0A0, 0x140, U } | s: 0x00
    db $14, $12, $24 ; SPRITE 24   | xy: { 0x120, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DDBA-$04DDE8 DATA
RoomData_Sprites_Room003D:
{
    db $00 ; Unlayered OAM
    db $17, $05, $1E ; SPRITE 1E   | xy: { 0x050, 0x170, U } | s: 0x00
    db $19, $0A, $1E ; SPRITE 1E   | xy: { 0x0A0, 0x190, U } | s: 0x00
    db $07, $17, $13 ; SPRITE 13   | xy: { 0x170, 0x070, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $07, $18, $13 ; SPRITE 13   | xy: { 0x180, 0x070, U } | s: 0x00
    db $08, $15, $C5 ; SPRITE C5   | xy: { 0x150, 0x080, U } | s: 0x00
    db $08, $1A, $C5 ; SPRITE C5   | xy: { 0x1A0, 0x080, U } | s: 0x00
    db $0A, $04, $8A ; SPRITE 8A   | xy: { 0x040, 0x0A0, U } | s: 0x00
    db $0B, $03, $7D ; SPRITE 7D   | xy: { 0x030, 0x0B0, U } | s: 0x00
    db $15, $FB, $0A ; OVERLORD 0A | xy: { 0x1B0, 0x150, U }
    db $16, $13, $5C ; SPRITE 5C   | xy: { 0x130, 0x160, U } | s: 0x00
    db $16, $1C, $5B ; SPRITE 5B   | xy: { 0x1C0, 0x160, U } | s: 0x00
    db $16, $09, $5B ; SPRITE 5B   | xy: { 0x090, 0x160, U } | s: 0x00
    db $17, $07, $D1 ; SPRITE D1   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $08, $15 ; SPRITE 15   | xy: { 0x080, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DDE9-$04DE11 DATA
RoomData_Sprites_Room003E:
{
    db $00 ; Unlayered OAM
    db $15, $06, $1E ; SPRITE 1E   | xy: { 0x060, 0x150, U } | s: 0x00
    db $04, $19, $91 ; SPRITE 91   | xy: { 0x190, 0x040, U } | s: 0x00
    db $0B, $16, $91 ; SPRITE 91   | xy: { 0x160, 0x0B0, U } | s: 0x00
    db $12, $05, $9D ; SPRITE 9D   | xy: { 0x050, 0x120, U } | s: 0x00
    db $12, $0E, $9D ; SPRITE 9D   | xy: { 0x0E0, 0x120, U } | s: 0x00
    db $12, $F0, $07 ; OVERLORD 07 | xy: { 0x100, 0x120, U }
    db $12, $12, $9D ; SPRITE 9D   | xy: { 0x120, 0x120, U } | s: 0x00
    db $12, $15, $9D ; SPRITE 9D   | xy: { 0x150, 0x120, U } | s: 0x00
    db $16, $07, $24 ; SPRITE 24   | xy: { 0x070, 0x160, U } | s: 0x00
    db $18, $11, $24 ; SPRITE 24   | xy: { 0x110, 0x180, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $19, $15, $24 ; SPRITE 24   | xy: { 0x150, 0x190, U } | s: 0x00
    db $1A, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE12-$04DE22 DATA
RoomData_Sprites_Room003F:
{
    db $00 ; Unlayered OAM
    db $15, $04, $04 ; SPRITE 04   | xy: { 0x040, 0x150, U } | s: 0x00
    db $16, $0C, $91 ; SPRITE 91   | xy: { 0x0C0, 0x160, U } | s: 0x00
    db $15, $13, $04 ; SPRITE 04   | xy: { 0x130, 0x150, U } | s: 0x00
    db $17, $04, $91 ; SPRITE 91   | xy: { 0x040, 0x170, U } | s: 0x00
    db $18, $08, $D1 ; SPRITE D1   | xy: { 0x080, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE23-$04DE36 DATA
RoomData_Sprites_Room0040:
{
    db $00 ; Unlayered OAM
    db $88, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x080, L } | s: 0x00
    db $EF, $69, $41 ; SPRITE 41   | xy: { 0x090, 0x0F0, L } | s: 0x1B
    db $95, $18, $1C ; SPRITE 1C   | xy: { 0x180, 0x150, L } | s: 0x00
    db $98, $1B, $43 ; SPRITE 43   | xy: { 0x1B0, 0x180, L } | s: 0x00
    db $9A, $17, $46 ; SPRITE 46   | xy: { 0x170, 0x1A0, L } | s: 0x00
    db $9A, $19, $46 ; SPRITE 46   | xy: { 0x190, 0x1A0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE37-$04DE38 DATA
UNREACHABLE_09DE37:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04DEE9-$04DE46 DATA
RoomData_Sprites_Room0041:
{
    db $00 ; Unlayered OAM
    db $0A, $11, $6D ; SPRITE 6D   | xy: { 0x110, 0x0A0, U } | s: 0x00
    db $0B, $1B, $6D ; SPRITE 6D   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $0D, $0F, $6D ; SPRITE 6D   | xy: { 0x0F0, 0x0D0, U } | s: 0x00
    db $15, $06, $6D ; SPRITE 6D   | xy: { 0x060, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE47-$04DE5A DATA
RoomData_Sprites_Room0042:
{
    db $00 ; Unlayered OAM
    db $06, $12, $6E ; SPRITE 6E   | xy: { 0x120, 0x060, U } | s: 0x00
    db $06, $13, $6E ; SPRITE 6E   | xy: { 0x130, 0x060, U } | s: 0x00
    db $06, $14, $6E ; SPRITE 6E   | xy: { 0x140, 0x060, U } | s: 0x00
    db $07, $12, $6E ; SPRITE 6E   | xy: { 0x120, 0x070, U } | s: 0x00
    db $07, $13, $6E ; SPRITE 6E   | xy: { 0x130, 0x070, U } | s: 0x00
    db $07, $14, $6E ; SPRITE 6E   | xy: { 0x140, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE5B-$04DE62 DATA
RoomData_Sprites_Room0043:
{
    db $00 ; Unlayered OAM
    db $06, $0C, $84 ; SPRITE 84   | xy: { 0x0C0, 0x060, U } | s: 0x00
    db $18, $F7, $14 ; OVERLORD 14 | xy: { 0x170, 0x180, U }
    db $FF ; END
}

; ==============================================================================

; $04DE63-$04DE7F DATA
RoomData_Sprites_Room0044:
{
    db $00 ; Unlayered OAM
    db $06, $09, $93 ; SPRITE 93   | xy: { 0x090, 0x060, U } | s: 0x00
    db $08, $05, $93 ; SPRITE 93   | xy: { 0x050, 0x080, U } | s: 0x00
    db $04, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x040, U } | s: 0x00
    db $08, $03, $24 ; SPRITE 24   | xy: { 0x030, 0x080, U } | s: 0x00
    db $08, $17, $8F ; SPRITE 8F   | xy: { 0x170, 0x080, U } | s: 0x00
    db $0C, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x0C0, U } | s: 0x00
    db $0F, $17, $23 ; SPRITE 23   | xy: { 0x170, 0x0F0, U } | s: 0x00
    db $15, $EB, $0A ; OVERLORD 0A | xy: { 0x0B0, 0x150, U }
    db $16, $18, $24 ; SPRITE 24   | xy: { 0x180, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DE80-$04DEA2 DATA
RoomData_Sprites_Room0045:
{
    db $00 ; Unlayered OAM
    db $06, $19, $B7 ; SPRITE B7   | xy: { 0x190, 0x060, U } | s: 0x00
    db $06, $06, $A6 ; SPRITE A6   | xy: { 0x060, 0x060, U } | s: 0x00
    db $0B, $04, $A5 ; SPRITE A5   | xy: { 0x040, 0x0B0, U } | s: 0x00
    db $0B, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x0B0, U } | s: 0x00
    db $0B, $17, $D1 ; SPRITE D1   | xy: { 0x170, 0x0B0, U } | s: 0x00
    db $0C, $18, $A5 ; SPRITE A5   | xy: { 0x180, 0x0C0, U } | s: 0x00
    db $0C, $1A, $A5 ; SPRITE A5   | xy: { 0x1A0, 0x0C0, U } | s: 0x00
    db $11, $18, $A5 ; SPRITE A5   | xy: { 0x180, 0x110, U } | s: 0x00
    db $18, $16, $8F ; SPRITE 8F   | xy: { 0x160, 0x180, U } | s: 0x00
    db $1B, $19, $A6 ; SPRITE A6   | xy: { 0x190, 0x1B0, U } | s: 0x00
    db $1C, $07, $A6 ; SPRITE A6   | xy: { 0x070, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DEA3-$04DEB3 DATA
RoomData_Sprites_Room0046:
{
    db $00 ; Unlayered OAM
    db $05, $16, $81 ; SPRITE 81   | xy: { 0x160, 0x050, U } | s: 0x00
    db $06, $FB, $11 ; OVERLORD 11 | xy: { 0x1B0, 0x060, U }
    db $1A, $09, $81 ; SPRITE 81   | xy: { 0x090, 0x1A0, U } | s: 0x00
    db $1A, $FB, $11 ; OVERLORD 11 | xy: { 0x1B0, 0x1A0, U }
    db $1B, $11, $81 ; SPRITE 81   | xy: { 0x110, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DEB4-$04DE1B5 DATA
RoomData_Sprites_Room0047:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04DEB6-$04DEDE DATA
RoomData_Sprites_Room0049:
{
    db $00 ; Unlayered OAM
    db $05, $0B, $18 ; SPRITE 18   | xy: { 0x0B0, 0x050, U } | s: 0x00
    db $0B, $04, $18 ; SPRITE 18   | xy: { 0x040, 0x0B0, U } | s: 0x00
    db $0C, $09, $18 ; SPRITE 18   | xy: { 0x090, 0x0C0, U } | s: 0x00
    db $06, $08, $D1 ; SPRITE D1   | xy: { 0x080, 0x060, U } | s: 0x00
    db $08, $07, $8B ; SPRITE 8B   | xy: { 0x070, 0x080, U } | s: 0x00
    db $0B, $17, $8B ; SPRITE 8B   | xy: { 0x170, 0x0B0, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $10, $17, $8B ; SPRITE 8B   | xy: { 0x170, 0x100, U } | s: 0x00
    db $14, $16, $8B ; SPRITE 8B   | xy: { 0x160, 0x140, U } | s: 0x00
    db $16, $09, $24 ; SPRITE 24   | xy: { 0x090, 0x160, U } | s: 0x00
    db $17, $0A, $23 ; SPRITE 23   | xy: { 0x0A0, 0x170, U } | s: 0x00
    db $18, $07, $24 ; SPRITE 24   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $1A, $8B ; SPRITE 8B   | xy: { 0x1A0, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DEDF-$04DEE9 DATA
RoomData_Sprites_Room004A:
{
    db $00 ; Unlayered OAM
    db $07, $14, $1C ; SPRITE 1C   | xy: { 0x140, 0x070, U } | s: 0x00
    db $08, $08, $13 ; SPRITE 13   | xy: { 0x080, 0x080, U } | s: 0x00
    db $08, $18, $13 ; SPRITE 13   | xy: { 0x180, 0x080, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DEEA-$04DF03 DATA
RoomData_Sprites_Room004B:
{
    db $00 ; Unlayered OAM
    db $04, $07, $84 ; SPRITE 84   | xy: { 0x070, 0x040, U } | s: 0x00
    db $05, $17, $15 ; SPRITE 15   | xy: { 0x170, 0x050, U } | s: 0x00
    db $06, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x060, U } | s: 0x00
    db $08, $04, $83 ; SPRITE 83   | xy: { 0x040, 0x080, U } | s: 0x00
    db $08, $0B, $83 ; SPRITE 83   | xy: { 0x0B0, 0x080, U } | s: 0x00
    db $18, $0F, $24 ; SPRITE 24   | xy: { 0x0F0, 0x180, U } | s: 0x00
    db $19, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x190, U } | s: 0x00
    db $19, $12, $24 ; SPRITE 24   | xy: { 0x120, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF04-$04DF1D DATA
RoomData_Sprites_Room004C:
{
    db $00 ; Unlayered OAM
    db $11, $15, $93 ; SPRITE 93   | xy: { 0x150, 0x110, U } | s: 0x00
    db $12, $19, $93 ; SPRITE 93   | xy: { 0x190, 0x120, U } | s: 0x00
    db $05, $15, $13 ; SPRITE 13   | xy: { 0x150, 0x050, U } | s: 0x00
    db $05, $1A, $13 ; SPRITE 13   | xy: { 0x1A0, 0x050, U } | s: 0x00
    db $06, $17, $13 ; SPRITE 13   | xy: { 0x170, 0x060, U } | s: 0x00
    db $0A, $18, $13 ; SPRITE 13   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $15, $14, $13 ; SPRITE 13   | xy: { 0x140, 0x150, U } | s: 0x00
    db $18, $13, $8A ; SPRITE 8A   | xy: { 0x130, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF1E-$04DF22 DATA
RoomData_Sprites_Room004D:
{
    db $00 ; Unlayered OAM
    db $0E, $0E, $09 ; SPRITE 09   | xy: { 0x0E0, 0x0E0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF23-$04DF30 DATA
RoomData_Sprites_Room004E:
{
    db $00 ; Unlayered OAM
    db $08, $14, $8F ; SPRITE 8F   | xy: { 0x140, 0x080, U } | s: 0x00
    db $08, $16, $8F ; SPRITE 8F   | xy: { 0x160, 0x080, U } | s: 0x00
    db $08, $18, $8F ; SPRITE 8F   | xy: { 0x180, 0x080, U } | s: 0x00
    db $09, $07, $7E ; SPRITE 7E   | xy: { 0x070, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF31-$04DF3B DATA
RoomData_Sprites_Room004F:
{
    db $00 ; Unlayered OAM
    db $06, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x060, U } | s: 0x00
    db $08, $14, $E3 ; SPRITE E3   | xy: { 0x140, 0x080, U } | s: 0x00
    db $08, $1A, $E3 ; SPRITE E3   | xy: { 0x1A0, 0x080, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF3C-$04DF46 DATA
RoomData_Sprites_Room0050:
{
    db $00 ; Unlayered OAM
    db $8E, $17, $42 ; SPRITE 42   | xy: { 0x170, 0x0E0, L } | s: 0x00
    db $90, $18, $4B ; SPRITE 4B   | xy: { 0x180, 0x100, L } | s: 0x00
    db $92, $17, $4B ; SPRITE 4B   | xy: { 0x170, 0x120, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF47-$04DF51 DATA
RoomData_Sprites_Room0051:
{
    db $01 ; Layered OAM
    db $02, $0E, $EE ; SPRITE EE   | xy: { 0x0E0, 0x020, U } | s: 0x00
    db $97, $29, $41 ; SPRITE 41   | xy: { 0x090, 0x170, L } | s: 0x01
    db $97, $56, $41 ; SPRITE 41   | xy: { 0x160, 0x170, L } | s: 0x02
    db $FF ; END
}

; ==============================================================================

; $04DF52-$04DF5C DATA
RoomData_Sprites_Room0052:
{
    db $00 ; Unlayered OAM
    db $8D, $07, $42 ; SPRITE 42   | xy: { 0x070, 0x0D0, L } | s: 0x00
    db $8F, $08, $4B ; SPRITE 4B   | xy: { 0x080, 0x0F0, L } | s: 0x00
    db $92, $07, $4B ; SPRITE 4B   | xy: { 0x070, 0x120, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF5D-$04DF85 DATA
RoomData_Sprites_Room0053:
{
    db $00 ; Unlayered OAM
    db $07, $17, $4E ; SPRITE 4E   | xy: { 0x170, 0x070, U } | s: 0x00
    db $09, $1C, $61 ; SPRITE 61   | xy: { 0x1C0, 0x090, U } | s: 0x00
    db $0C, $17, $4F ; SPRITE 4F   | xy: { 0x170, 0x0C0, U } | s: 0x00
    db $0C, $1A, $4F ; SPRITE 4F   | xy: { 0x1A0, 0x0C0, U } | s: 0x00
    db $0E, $13, $61 ; SPRITE 61   | xy: { 0x130, 0x0E0, U } | s: 0x00
    db $15, $05, $4E ; SPRITE 4E   | xy: { 0x050, 0x150, U } | s: 0x00
    db $16, $0B, $4E ; SPRITE 4E   | xy: { 0x0B0, 0x160, U } | s: 0x00
    db $17, $1A, $4E ; SPRITE 4E   | xy: { 0x1A0, 0x170, U } | s: 0x00
    db $19, $07, $61 ; SPRITE 61   | xy: { 0x070, 0x190, U } | s: 0x00
    db $1A, $04, $4E ; SPRITE 4E   | xy: { 0x040, 0x1A0, U } | s: 0x00
    db $1A, $0B, $4E ; SPRITE 4E   | xy: { 0x0B0, 0x1A0, U } | s: 0x00
    db $1A, $1B, $61 ; SPRITE 61   | xy: { 0x1B0, 0x1A0, U } | s: 0x00
    db $1B, $1A, $4E ; SPRITE 4E   | xy: { 0x1A0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DF86-$04DF9F DATA
RoomData_Sprites_Room0054:
{
    db $00 ; Unlayered OAM
    db $05, $0E, $9A ; SPRITE 9A   | xy: { 0x0E0, 0x050, U } | s: 0x00
    db $0B, $0C, $81 ; SPRITE 81   | xy: { 0x0C0, 0x0B0, U } | s: 0x00
    db $0E, $0B, $C5 ; SPRITE C5   | xy: { 0x0B0, 0x0E0, U } | s: 0x00
    db $0E, $0F, $7E ; SPRITE 7E   | xy: { 0x0F0, 0x0E0, U } | s: 0x00
    db $0F, $10, $81 ; SPRITE 81   | xy: { 0x100, 0x0F0, U } | s: 0x00
    db $14, $12, $9A ; SPRITE 9A   | xy: { 0x120, 0x140, U } | s: 0x00
    db $15, $0F, $81 ; SPRITE 81   | xy: { 0x0F0, 0x150, U } | s: 0x00
    db $17, $0C, $9A ; SPRITE 9A   | xy: { 0x0C0, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DFA0-$04DFAA DATA
RoomData_Sprites_Room0055:
{
    db $00 ; Unlayered OAM
    db $08, $0E, $73 ; SPRITE 73   | xy: { 0x0E0, 0x080, U } | s: 0x00
    db $15, $14, $4B ; SPRITE 4B   | xy: { 0x140, 0x150, U } | s: 0x00
    db $16, $0D, $4B ; SPRITE 4B   | xy: { 0x0D0, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DFAB-$04DFD3 DATA
RoomData_Sprites_Room0056:
{
    db $00 ; Unlayered OAM
    db $05, $EB, $0A ; OVERLORD 0A | xy: { 0x0B0, 0x050, U }
    db $19, $07, $93 ; SPRITE 93   | xy: { 0x070, 0x190, U } | s: 0x00
    db $19, $17, $93 ; SPRITE 93   | xy: { 0x170, 0x190, U } | s: 0x00
    db $04, $07, $13 ; SPRITE 13   | xy: { 0x070, 0x040, U } | s: 0x00
    db $05, $1B, $26 ; SPRITE 26   | xy: { 0x1B0, 0x050, U } | s: 0x00
    db $06, $03, $13 ; SPRITE 13   | xy: { 0x030, 0x060, U } | s: 0x00
    db $06, $0C, $13 ; SPRITE 13   | xy: { 0x0C0, 0x060, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $11, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x110, U } | s: 0x00
    db $12, $18, $8A ; SPRITE 8A   | xy: { 0x180, 0x120, U } | s: 0x00
    db $1B, $03, $26 ; SPRITE 26   | xy: { 0x030, 0x1B0, U } | s: 0x00
    db $1C, $13, $80 ; SPRITE 80   | xy: { 0x130, 0x1C0, U } | s: 0x00
    db $1C, $19, $26 ; SPRITE 26   | xy: { 0x190, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04DFD4-$04E005 DATA
RoomData_Sprites_Room0057:
{
    db $00 ; Unlayered OAM
    db $04, $08, $D1 ; SPRITE D1   | xy: { 0x080, 0x040, U } | s: 0x00
    db $04, $0C, $23 ; SPRITE 23   | xy: { 0x0C0, 0x040, U } | s: 0x00
    db $05, $08, $8A ; SPRITE 8A   | xy: { 0x080, 0x050, U } | s: 0x00
    db $07, $04, $A7 ; SPRITE A7   | xy: { 0x040, 0x070, U } | s: 0x00
    db $0C, $03, $A7 ; SPRITE A7   | xy: { 0x030, 0x0C0, U } | s: 0x00
    db $0C, $0C, $8B ; SPRITE 8B   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $14, $05, $8B ; SPRITE 8B   | xy: { 0x050, 0x140, U } | s: 0x00
    db $14, $0A, $8B ; SPRITE 8B   | xy: { 0x0A0, 0x140, U } | s: 0x00
    db $14, $17, $8B ; SPRITE 8B   | xy: { 0x170, 0x140, U } | s: 0x00
    db $14, $19, $8B ; SPRITE 8B   | xy: { 0x190, 0x140, U } | s: 0x00
    db $15, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x150, U } | s: 0x00
    db $17, $13, $8B ; SPRITE 8B   | xy: { 0x130, 0x170, U } | s: 0x00
    db $18, $07, $24 ; SPRITE 24   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x180, U } | s: 0x00
    db $18, $0B, $1C ; SPRITE 1C   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E006-$04E022 DATA
RoomData_Sprites_Room0058:
{
    db $00 ; Unlayered OAM
    db $14, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x140, U } | s: 0x00
    db $16, $06, $18 ; SPRITE 18   | xy: { 0x060, 0x160, U } | s: 0x00
    db $16, $16, $93 ; SPRITE 93   | xy: { 0x160, 0x160, U } | s: 0x00
    db $04, $14, $13 ; SPRITE 13   | xy: { 0x140, 0x040, U } | s: 0x00
    db $06, $16, $5B ; SPRITE 5B   | xy: { 0x160, 0x060, U } | s: 0x00
    db $0A, $08, $04 ; SPRITE 04   | xy: { 0x080, 0x0A0, U } | s: 0x00
    db $0B, $1B, $26 ; SPRITE 26   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $19, $16, $26 ; SPRITE 26   | xy: { 0x160, 0x190, U } | s: 0x00
    db $1A, $0A, $23 ; SPRITE 23   | xy: { 0x0A0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E023-$04E048 DATA
RoomData_Sprites_Room0059:
{
    db $01 ; Layered OAM
    db $10, $07, $18 ; SPRITE 18   | xy: { 0x070, 0x100, U } | s: 0x00
    db $16, $08, $18 ; SPRITE 18   | xy: { 0x080, 0x160, U } | s: 0x00
    db $8F, $14, $93 ; SPRITE 93   | xy: { 0x140, 0x0F0, L } | s: 0x00
    db $8F, $1A, $93 ; SPRITE 93   | xy: { 0x1A0, 0x0F0, L } | s: 0x00
    db $8A, $1A, $8A ; SPRITE 8A   | xy: { 0x1A0, 0x0A0, L } | s: 0x00
    db $0B, $08, $80 ; SPRITE 80   | xy: { 0x080, 0x0B0, U } | s: 0x00
    db $8D, $15, $8A ; SPRITE 8A   | xy: { 0x150, 0x0D0, L } | s: 0x00
    db $8E, $05, $5B ; SPRITE 5B   | xy: { 0x050, 0x0E0, L } | s: 0x00
    db $93, $1A, $D1 ; SPRITE D1   | xy: { 0x1A0, 0x130, L } | s: 0x00
    db $14, $17, $8B ; SPRITE 8B   | xy: { 0x170, 0x140, U } | s: 0x00
    db $95, $15, $8B ; SPRITE 8B   | xy: { 0x150, 0x150, L } | s: 0x00
    db $95, $1A, $8B ; SPRITE 8B   | xy: { 0x1A0, 0x150, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E049-$04E04D DATA
RoomData_Sprites_Room005A:
{
    db $00 ; Unlayered OAM
    db $16, $17, $92 ; SPRITE 92   | xy: { 0x170, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E04E-$04E06A DATA
RoomData_Sprites_Room005B:
{
    db $01 ; Layered OAM
    db $8C, $17, $1E ; SPRITE 1E   | xy: { 0x170, 0x0C0, L } | s: 0x00
    db $93, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x130, L } | s: 0x00
    db $95, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x150, L } | s: 0x00
    db $88, $16, $83 ; SPRITE 83   | xy: { 0x160, 0x080, L } | s: 0x00
    db $88, $19, $84 ; SPRITE 84   | xy: { 0x190, 0x080, L } | s: 0x00
    db $8E, $14, $8A ; SPRITE 8A   | xy: { 0x140, 0x0E0, L } | s: 0x00
    db $90, $1B, $8A ; SPRITE 8A   | xy: { 0x1B0, 0x100, L } | s: 0x00
    db $91, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x110, L } | s: 0x00
    db $92, $14, $8A ; SPRITE 8A   | xy: { 0x140, 0x120, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E06B-$04E07B DATA
RoomData_Sprites_Room005C:
{
    db $00 ; Unlayered OAM
    db $02, $0B, $68 ; SPRITE 68   | xy: { 0x0B0, 0x020, U } | s: 0x00
    db $0E, $05, $69 ; SPRITE 69   | xy: { 0x050, 0x0E0, U } | s: 0x00
    db $0E, $0E, $69 ; SPRITE 69   | xy: { 0x0E0, 0x0E0, U } | s: 0x00
    db $18, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x180, U } | s: 0x00
    db $18, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E07C-$04E0A4 DATA
RoomData_Sprites_Room005D:
{
    db $00 ; Unlayered OAM
    db $05, $07, $A7 ; SPRITE A7   | xy: { 0x070, 0x050, U } | s: 0x00
    db $06, $08, $61 ; SPRITE 61   | xy: { 0x080, 0x060, U } | s: 0x00
    db $08, $03, $A7 ; SPRITE A7   | xy: { 0x030, 0x080, U } | s: 0x00
    db $08, $15, $A6 ; SPRITE A6   | xy: { 0x150, 0x080, U } | s: 0x00
    db $08, $17, $A7 ; SPRITE A7   | xy: { 0x170, 0x080, U } | s: 0x00
    db $08, $19, $A5 ; SPRITE A5   | xy: { 0x190, 0x080, U } | s: 0x00
    db $08, $1B, $A7 ; SPRITE A7   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $0B, $07, $A7 ; SPRITE A7   | xy: { 0x070, 0x0B0, U } | s: 0x00
    db $15, $04, $61 ; SPRITE 61   | xy: { 0x040, 0x150, U } | s: 0x00
    db $15, $0B, $A5 ; SPRITE A5   | xy: { 0x0B0, 0x150, U } | s: 0x00
    db $1A, $04, $A5 ; SPRITE A5   | xy: { 0x040, 0x1A0, U } | s: 0x00
    db $1A, $08, $A5 ; SPRITE A5   | xy: { 0x080, 0x1A0, U } | s: 0x00
    db $1A, $0B, $61 ; SPRITE 61   | xy: { 0x0B0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0A5-$04E0B5 DATA
RoomData_Sprites_Room005E:
{
    db $00 ; Unlayered OAM
    db $05, $FB, $0A ; OVERLORD 0A | xy: { 0x1B0, 0x050, U }
    db $05, $1C, $C5 ; SPRITE C5   | xy: { 0x1C0, 0x050, U } | s: 0x00
    db $0B, $13, $C5 ; SPRITE C5   | xy: { 0x130, 0x0B0, U } | s: 0x00
    db $14, $17, $7D ; SPRITE 7D   | xy: { 0x170, 0x140, U } | s: 0x00
    db $18, $08, $7E ; SPRITE 7E   | xy: { 0x080, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0B6-$04E0C0 DATA
RoomData_Sprites_Room005F:
{
    db $00 ; Unlayered OAM
    db $18, $04, $24 ; SPRITE 24   | xy: { 0x040, 0x180, U } | s: 0x00
    db $18, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $1B, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0C1-$04E0C5 DATA
RoomData_Sprites_Room0060:
{
    db $01 ; Layered OAM
    db $48, $73, $41 ; SPRITE 41   | xy: { 0x130, 0x080, U } | s: 0x13
    db $FF ; END
}

; ==============================================================================

; $04E0C6-$04E0D0 DATA
RoomData_Sprites_Room0061:
{
    db $00 ; Unlayered OAM
    db $0E, $2C, $42 ; SPRITE 42   | xy: { 0x0C0, 0x0E0, U } | s: 0x01
    db $12, $0D, $4B ; SPRITE 4B   | xy: { 0x0D0, 0x120, U } | s: 0x00
    db $12, $12, $4B ; SPRITE 4B   | xy: { 0x120, 0x120, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0D1-$04E0DB DATA
RoomData_Sprites_Room0062:
{
    db $01 ; Layered OAM
    db $48, $6C, $41 ; SPRITE 41   | xy: { 0x0C0, 0x080, U } | s: 0x13
    db $8D, $0A, $42 ; SPRITE 42   | xy: { 0x0A0, 0x0D0, L } | s: 0x00
    db $8E, $11, $42 ; SPRITE 42   | xy: { 0x110, 0x0E0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0DC-$04E0E3 DATA
RoomData_Sprites_Room0063:
{
    db $00 ; Unlayered OAM
    db $08, $E7, $14 ; OVERLORD 14 | xy: { 0x070, 0x080, U }
    db $18, $07, $61 ; SPRITE 61   | xy: { 0x070, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E0E4-$04E10C DATA
RoomData_Sprites_Room0064:
{
    db $00 ; Unlayered OAM
    db $12, $05, $6F ; SPRITE 6F   | xy: { 0x050, 0x120, U } | s: 0x00
    db $13, $0B, $06 ; SPRITE 06   | xy: { 0x0B0, 0x130, U } | s: 0x00
    db $13, $05, $6F ; SPRITE 6F   | xy: { 0x050, 0x130, U } | s: 0x00
    db $16, $03, $D1 ; SPRITE D1   | xy: { 0x030, 0x160, U } | s: 0x00
    db $17, $17, $6D ; SPRITE 6D   | xy: { 0x170, 0x170, U } | s: 0x00
    db $19, $19, $6D ; SPRITE 6D   | xy: { 0x190, 0x190, U } | s: 0x00
    db $1A, $05, $6D ; SPRITE 6D   | xy: { 0x050, 0x1A0, U } | s: 0x00
    db $15, $E9, $06 ; OVERLORD 06 | xy: { 0x090, 0x150, U }
    db $17, $E7, $06 ; OVERLORD 06 | xy: { 0x070, 0x170, U }
    db $17, $E9, $06 ; OVERLORD 06 | xy: { 0x090, 0x170, U }
    db $17, $EB, $06 ; OVERLORD 06 | xy: { 0x0B0, 0x170, U }
    db $19, $E9, $06 ; OVERLORD 06 | xy: { 0x090, 0x190, U }
    db $1B, $EC, $06 ; OVERLORD 06 | xy: { 0x0C0, 0x1B0, U }
    db $FF ; END
}

; ==============================================================================

; $04E10D-$04E11D DATA
RoomData_Sprites_Room0065:
{
    db $00 ; Unlayered OAM
    db $15, $13, $6D ; SPRITE 6D   | xy: { 0x130, 0x150, U } | s: 0x00
    db $17, $09, $6D ; SPRITE 6D   | xy: { 0x090, 0x170, U } | s: 0x00
    db $18, $06, $6D ; SPRITE 6D   | xy: { 0x060, 0x180, U } | s: 0x00
    db $19, $16, $6D ; SPRITE 6D   | xy: { 0x160, 0x190, U } | s: 0x00
    db $1C, $16, $6D ; SPRITE 6D   | xy: { 0x160, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E11E-$04E143 DATA
RoomData_Sprites_Room0066:
{
    db $00 ; Unlayered OAM
    db $85, $0B, $81 ; SPRITE 81   | xy: { 0x0B0, 0x050, L } | s: 0x00
    db $86, $E4, $10 ; OVERLORD 10 | xy: { 0x040, 0x060, L }
    db $06, $16, $24 ; SPRITE 24   | xy: { 0x160, 0x060, U } | s: 0x00
    db $07, $1A, $24 ; SPRITE 24   | xy: { 0x1A0, 0x070, U } | s: 0x00
    db $94, $17, $37 ; SPRITE 37   | xy: { 0x170, 0x140, L } | s: 0x00
    db $96, $E1, $10 ; OVERLORD 10 | xy: { 0x010, 0x160, L }
    db $96, $0F, $9A ; SPRITE 9A   | xy: { 0x0F0, 0x160, L } | s: 0x00
    db $96, $13, $81 ; SPRITE 81   | xy: { 0x130, 0x160, L } | s: 0x00
    db $98, $0B, $81 ; SPRITE 81   | xy: { 0x0B0, 0x180, L } | s: 0x00
    db $99, $0D, $81 ; SPRITE 81   | xy: { 0x0D0, 0x190, L } | s: 0x00
    db $99, $FE, $11 ; OVERLORD 11 | xy: { 0x1E0, 0x190, L }
    db $9B, $17, $81 ; SPRITE 81   | xy: { 0x170, 0x1B0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E144-$04E163 DATA
RoomData_Sprites_Room0067:
{
    db $00 ; Unlayered OAM
    db $0C, $07, $93 ; SPRITE 93   | xy: { 0x070, 0x0C0, U } | s: 0x00
    db $06, $04, $24 ; SPRITE 24   | xy: { 0x040, 0x060, U } | s: 0x00
    db $06, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x060, U } | s: 0x00
    db $0C, $05, $26 ; SPRITE 26   | xy: { 0x050, 0x0C0, U } | s: 0x00
    db $0F, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x0F0, U } | s: 0x00
    db $13, $05, $26 ; SPRITE 26   | xy: { 0x050, 0x130, U } | s: 0x00
    db $13, $09, $26 ; SPRITE 26   | xy: { 0x090, 0x130, U } | s: 0x00
    db $14, $18, $7E ; SPRITE 7E   | xy: { 0x180, 0x140, U } | s: 0x00
    db $17, $07, $7F ; SPRITE 7F   | xy: { 0x070, 0x170, U } | s: 0x00
    db $1A, $18, $26 ; SPRITE 26   | xy: { 0x180, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E164-$04E17D DATA
RoomData_Sprites_Room0068:
{
    db $00 ; Unlayered OAM
    db $07, $0E, $93 ; SPRITE 93   | xy: { 0x0E0, 0x070, U } | s: 0x00
    db $07, $11, $93 ; SPRITE 93   | xy: { 0x110, 0x070, U } | s: 0x00
    db $0B, $0C, $93 ; SPRITE 93   | xy: { 0x0C0, 0x0B0, U } | s: 0x00
    db $0B, $13, $93 ; SPRITE 93   | xy: { 0x130, 0x0B0, U } | s: 0x00
    db $08, $14, $8B ; SPRITE 8B   | xy: { 0x140, 0x080, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $12, $0E, $8B ; SPRITE 8B   | xy: { 0x0E0, 0x120, U } | s: 0x00
    db $12, $12, $8B ; SPRITE 8B   | xy: { 0x120, 0x120, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E17E-$04E191 DATA
RoomData_Sprites_Room006A:
{
    db $00 ; Unlayered OAM
    db $0A, $17, $8E ; SPRITE 8E   | xy: { 0x170, 0x0A0, U } | s: 0x00
    db $0A, $18, $8E ; SPRITE 8E   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $0B, $14, $15 ; SPRITE 15   | xy: { 0x140, 0x0B0, U } | s: 0x00
    db $0B, $1C, $15 ; SPRITE 15   | xy: { 0x1C0, 0x0B0, U } | s: 0x00
    db $0E, $17, $8E ; SPRITE 8E   | xy: { 0x170, 0x0E0, U } | s: 0x00
    db $0E, $18, $8E ; SPRITE 8E   | xy: { 0x180, 0x0E0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E192-$04E1CD DATA
RoomData_Sprites_Room006B:
{
    db $00 ; Unlayered OAM
    db $04, $07, $1E ; SPRITE 1E   | xy: { 0x070, 0x040, U } | s: 0x00
    db $04, $0B, $1E ; SPRITE 1E   | xy: { 0x0B0, 0x040, U } | s: 0x00
    db $06, $0A, $83 ; SPRITE 83   | xy: { 0x0A0, 0x060, U } | s: 0x00
    db $09, $06, $84 ; SPRITE 84   | xy: { 0x060, 0x090, U } | s: 0x00
    db $0A, $0C, $15 ; SPRITE 15   | xy: { 0x0C0, 0x0A0, U } | s: 0x00
    db $15, $06, $1C ; SPRITE 1C   | xy: { 0x060, 0x150, U } | s: 0x00
    db $18, $03, $84 ; SPRITE 84   | xy: { 0x030, 0x180, U } | s: 0x00
    db $18, $04, $8A ; SPRITE 8A   | xy: { 0x040, 0x180, U } | s: 0x00
    db $1B, $04, $8A ; SPRITE 8A   | xy: { 0x040, 0x1B0, U } | s: 0x00
    db $1B, $0C, $84 ; SPRITE 84   | xy: { 0x0C0, 0x1B0, U } | s: 0x00
    db $15, $17, $84 ; SPRITE 84   | xy: { 0x170, 0x150, U } | s: 0x00
    db $15, $1B, $61 ; SPRITE 61   | xy: { 0x1B0, 0x150, U } | s: 0x00
    db $1B, $14, $61 ; SPRITE 61   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $1B, $18, $84 ; SPRITE 84   | xy: { 0x180, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E1BE-$04E1CE DATA
RoomData_Sprites_Room006C:
{
    db $00 ; Unlayered OAM
    db $17, $06, $54 ; SPRITE 54   | xy: { 0x060, 0x170, U } | s: 0x00
    db $17, $09, $54 ; SPRITE 54   | xy: { 0x090, 0x170, U } | s: 0x00
    db $19, $07, $54 ; SPRITE 54   | xy: { 0x070, 0x190, U } | s: 0x00
    db $18, $17, $D1 ; SPRITE D1   | xy: { 0x170, 0x180, U } | s: 0x00
    db $1C, $03, $C5 ; SPRITE C5   | xy: { 0x030, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E1CF-$04E1EB DATA
RoomData_Sprites_Room006D:
{
    db $00 ; Unlayered OAM
    db $06, $05, $A6 ; SPRITE A6   | xy: { 0x050, 0x060, U } | s: 0x00
    db $06, $0B, $61 ; SPRITE 61   | xy: { 0x0B0, 0x060, U } | s: 0x00
    db $09, $04, $61 ; SPRITE 61   | xy: { 0x040, 0x090, U } | s: 0x00
    db $0B, $0A, $A6 ; SPRITE A6   | xy: { 0x0A0, 0x0B0, U } | s: 0x00
    db $15, $04, $C5 ; SPRITE C5   | xy: { 0x040, 0x150, U } | s: 0x00
    db $15, $0B, $61 ; SPRITE 61   | xy: { 0x0B0, 0x150, U } | s: 0x00
    db $18, $05, $A7 ; SPRITE A7   | xy: { 0x050, 0x180, U } | s: 0x00
    db $18, $0A, $A6 ; SPRITE A6   | xy: { 0x0A0, 0x180, U } | s: 0x00
    db $1A, $06, $5C ; SPRITE 5C   | xy: { 0x060, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E1EC-$04E1FC DATA
RoomData_Sprites_Room006E:
{
    db $00 ; Unlayered OAM
    db $08, $13, $99 ; SPRITE 99   | xy: { 0x130, 0x080, U } | s: 0x00
    db $09, $13, $99 ; SPRITE 99   | xy: { 0x130, 0x090, U } | s: 0x00
    db $0A, $13, $99 ; SPRITE 99   | xy: { 0x130, 0x0A0, U } | s: 0x00
    db $0B, $13, $99 ; SPRITE 99   | xy: { 0x130, 0x0B0, U } | s: 0x00
    db $0C, $13, $99 ; SPRITE 99   | xy: { 0x130, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E1FD-$04E207 DATA
RoomData_Sprites_Room0071:
{
    db $00 ; Unlayered OAM
    db $98, $06, $42 ; SPRITE 42   | xy: { 0x060, 0x180, L } | s: 0x00
    db $D8, $BA, $41 ; SPRITE 41   | xy: { 0x1A0, 0x180, L } | s: 0x15
    db $FE, $00, $E4 ; Small key on above sprite
    db $FF ; END
}

; ==============================================================================

; $04E208-$04E212 DATA
RoomData_Sprites_Room0072:
{
    db $00 ; Unlayered OAM
    db $06, $B1, $41 ; SPRITE 41   | xy: { 0x110, 0x060, U } | s: 0x05
    db $FE, $00, $E4 ; Small key on above sprite
    db $99, $2A, $41 ; SPRITE 41   | xy: { 0x0A0, 0x190, L } | s: 0x01
    db $FF ; END
}

; ==============================================================================

; $04E213-$04E229 DATA
RoomData_Sprites_Room0073:
{
    db $00 ; Unlayered OAM
    db $18, $18, $64 ; SPRITE 64   | xy: { 0x180, 0x180, U } | s: 0x00
    db $09, $17, $61 ; SPRITE 61   | xy: { 0x170, 0x090, U } | s: 0x00
    db $15, $15, $71 ; SPRITE 71   | xy: { 0x150, 0x150, U } | s: 0x00
    db $18, $1B, $71 ; SPRITE 71   | xy: { 0x1B0, 0x180, U } | s: 0x00
    db $19, $07, $61 ; SPRITE 61   | xy: { 0x070, 0x190, U } | s: 0x00
    db $1B, $16, $71 ; SPRITE 71   | xy: { 0x160, 0x1B0, U } | s: 0x00
    db $06, $14, $3B ; SPRITE 3B   | xy: { 0x140, 0x060, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E22A-$04E243 DATA
RoomData_Sprites_Room0074:
{
    db $00 ; Unlayered OAM
    db $18, $08, $64 ; SPRITE 64   | xy: { 0x080, 0x180, U } | s: 0x00
    db $18, $17, $64 ; SPRITE 64   | xy: { 0x170, 0x180, U } | s: 0x00
    db $05, $0C, $83 ; SPRITE 83   | xy: { 0x0C0, 0x050, U } | s: 0x00
    db $05, $13, $83 ; SPRITE 83   | xy: { 0x130, 0x050, U } | s: 0x00
    db $0A, $0C, $71 ; SPRITE 71   | xy: { 0x0C0, 0x0A0, U } | s: 0x00
    db $0A, $13, $71 ; SPRITE 71   | xy: { 0x130, 0x0A0, U } | s: 0x00
    db $1B, $0E, $71 ; SPRITE 71   | xy: { 0x0E0, 0x1B0, U } | s: 0x00
    db $1B, $12, $71 ; SPRITE 71   | xy: { 0x120, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E244-$04E263 DATA
RoomData_Sprites_Room0075:
{
    db $00 ; Unlayered OAM
    db $07, $08, $64 ; SPRITE 64   | xy: { 0x080, 0x070, U } | s: 0x00
    db $1B, $04, $64 ; SPRITE 64   | xy: { 0x040, 0x1B0, U } | s: 0x00
    db $05, $06, $71 ; SPRITE 71   | xy: { 0x060, 0x050, U } | s: 0x00
    db $05, $0A, $71 ; SPRITE 71   | xy: { 0x0A0, 0x050, U } | s: 0x00
    db $0A, $06, $71 ; SPRITE 71   | xy: { 0x060, 0x0A0, U } | s: 0x00
    db $0A, $0A, $71 ; SPRITE 71   | xy: { 0x0A0, 0x0A0, U } | s: 0x00
    db $0B, $11, $66 ; SPRITE 66   | xy: { 0x110, 0x0B0, U } | s: 0x00
    db $0B, $1E, $67 ; SPRITE 67   | xy: { 0x1E0, 0x0B0, U } | s: 0x00
    db $19, $07, $71 ; SPRITE 71   | xy: { 0x070, 0x190, U } | s: 0x00
    db $19, $09, $71 ; SPRITE 71   | xy: { 0x090, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E264-$04E27A DATA
RoomData_Sprites_Room0076:
{
    db $00 ; Unlayered OAM
    db $03, $19, $21 ; SPRITE 21   | xy: { 0x190, 0x030, U } | s: 0x00
    db $0A, $07, $81 ; SPRITE 81   | xy: { 0x070, 0x0A0, U } | s: 0x00
    db $0F, $07, $9A ; SPRITE 9A   | xy: { 0x070, 0x0F0, U } | s: 0x00
    db $11, $08, $81 ; SPRITE 81   | xy: { 0x080, 0x110, U } | s: 0x00
    db $19, $1B, $8F ; SPRITE 8F   | xy: { 0x1B0, 0x190, U } | s: 0x00
    db $1C, $E8, $13 ; OVERLORD 13 | xy: { 0x080, 0x1C0, U }
    db $1C, $1B, $24 ; SPRITE 24   | xy: { 0x1B0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E27B-$04E28E DATA
RoomData_Sprites_Room0077:
{
    db $00 ; Unlayered OAM
    db $89, $0B, $18 ; SPRITE 18   | xy: { 0x0B0, 0x090, L } | s: 0x00
    db $98, $10, $1E ; SPRITE 1E   | xy: { 0x100, 0x180, L } | s: 0x00
    db $9A, $09, $1E ; SPRITE 1E   | xy: { 0x090, 0x1A0, L } | s: 0x00
    db $9A, $16, $1E ; SPRITE 1E   | xy: { 0x160, 0x1A0, L } | s: 0x00
    db $8A, $07, $86 ; SPRITE 86   | xy: { 0x070, 0x0A0, L } | s: 0x00
    db $8A, $17, $86 ; SPRITE 86   | xy: { 0x170, 0x0A0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E28F-$04E2B1 DATA
RoomData_Sprites_Room007B:
{
    db $00 ; Unlayered OAM
    db $07, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x070, U } | s: 0x00
    db $09, $16, $24 ; SPRITE 24   | xy: { 0x160, 0x090, U } | s: 0x00
    db $15, $04, $C6 ; SPRITE C6   | xy: { 0x040, 0x150, U } | s: 0x00
    db $15, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x150, U } | s: 0x00
    db $17, $07, $A7 ; SPRITE A7   | xy: { 0x070, 0x170, U } | s: 0x00
    db $17, $09, $C6 ; SPRITE C6   | xy: { 0x090, 0x170, U } | s: 0x00
    db $18, $13, $1C ; SPRITE 1C   | xy: { 0x130, 0x180, U } | s: 0x00
    db $18, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x180, U } | s: 0x00
    db $19, $09, $A7 ; SPRITE A7   | xy: { 0x090, 0x190, U } | s: 0x00
    db $1A, $05, $C6 ; SPRITE C6   | xy: { 0x050, 0x1A0, U } | s: 0x00
    db $1B, $0B, $C6 ; SPRITE C6   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E2B2-$04E2C8 DATA
RoomData_Sprites_Room007C:
{
    db $00 ; Unlayered OAM
    db $1C, $19, $18 ; SPRITE 18   | xy: { 0x190, 0x1C0, U } | s: 0x00
    db $0C, $06, $7F ; SPRITE 7F   | xy: { 0x060, 0x0C0, U } | s: 0x00
    db $10, $07, $8A ; SPRITE 8A   | xy: { 0x070, 0x100, U } | s: 0x00
    db $14, $09, $7E ; SPRITE 7E   | xy: { 0x090, 0x140, U } | s: 0x00
    db $18, $0B, $26 ; SPRITE 26   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $18, $17, $24 ; SPRITE 24   | xy: { 0x170, 0x180, U } | s: 0x00
    db $1A, $E7, $0B ; OVERLORD 0B | xy: { 0x070, 0x1A0, U }
    db $FF ; END
}

; ==============================================================================

; $04E2C9-$04E2EB DATA
RoomData_Sprites_Room007D:
{
    db $00 ; Unlayered OAM
    db $06, $11, $80 ; SPRITE 80   | xy: { 0x110, 0x060, U } | s: 0x00
    db $08, $11, $80 ; SPRITE 80   | xy: { 0x110, 0x080, U } | s: 0x00
    db $0A, $11, $80 ; SPRITE 80   | xy: { 0x110, 0x0A0, U } | s: 0x00
    db $0C, $11, $80 ; SPRITE 80   | xy: { 0x110, 0x0C0, U } | s: 0x00
    db $16, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x160, U } | s: 0x00
    db $17, $18, $C6 ; SPRITE C6   | xy: { 0x180, 0x170, U } | s: 0x00
    db $19, $1C, $80 ; SPRITE 80   | xy: { 0x1C0, 0x190, U } | s: 0x00
    db $1A, $14, $13 ; SPRITE 13   | xy: { 0x140, 0x1A0, U } | s: 0x00
    db $1A, $17, $23 ; SPRITE 23   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $1C, $0A, $80 ; SPRITE 80   | xy: { 0x0A0, 0x1C0, U } | s: 0x00
    db $1C, $1B, $26 ; SPRITE 26   | xy: { 0x1B0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E2EC-$04E302 DATA
RoomData_Sprites_Room007E:
{
    db $00 ; Unlayered OAM
    db $11, $17, $93 ; SPRITE 93   | xy: { 0x170, 0x110, U } | s: 0x00
    db $0E, $18, $7F ; SPRITE 7F   | xy: { 0x180, 0x0E0, U } | s: 0x00
    db $0F, $14, $99 ; SPRITE 99   | xy: { 0x140, 0x0F0, U } | s: 0x00
    db $12, $07, $A1 ; SPRITE A1   | xy: { 0x070, 0x120, U } | s: 0x00
    db $12, $0A, $A1 ; SPRITE A1   | xy: { 0x0A0, 0x120, U } | s: 0x00
    db $16, $1B, $99 ; SPRITE 99   | xy: { 0x1B0, 0x160, U } | s: 0x00
    db $17, $17, $7F ; SPRITE 7F   | xy: { 0x170, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E303-$04E31C DATA
RoomData_Sprites_Room007F:
{
    db $00 ; Unlayered OAM
    db $07, $06, $23 ; SPRITE 23   | xy: { 0x060, 0x070, U } | s: 0x00
    db $07, $08, $23 ; SPRITE 23   | xy: { 0x080, 0x070, U } | s: 0x00
    db $08, $0A, $23 ; SPRITE 23   | xy: { 0x0A0, 0x080, U } | s: 0x00
    db $09, $07, $23 ; SPRITE 23   | xy: { 0x070, 0x090, U } | s: 0x00
    db $14, $0B, $7D ; SPRITE 7D   | xy: { 0x0B0, 0x140, U } | s: 0x00
    db $17, $03, $7D ; SPRITE 7D   | xy: { 0x030, 0x170, U } | s: 0x00
    db $19, $0B, $7D ; SPRITE 7D   | xy: { 0x0B0, 0x190, U } | s: 0x00
    db $1B, $03, $7D ; SPRITE 7D   | xy: { 0x030, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E31D-$04E32A DATA
RoomData_Sprites_Room0080:
{
    db $00 ; Unlayered OAM
    db $03, $16, $76 ; SPRITE 76   | xy: { 0x160, 0x030, U } | s: 0x00
    db $09, $07, $42 ; SPRITE 42   | xy: { 0x070, 0x090, U } | s: 0x00
    db $09, $1A, $6A ; SPRITE 6A   | xy: { 0x1A0, 0x090, U } | s: 0x00
    db $FD, $00, $E4 ; Big key on above sprite
    db $FF ; END
}

; ==============================================================================

; $04E32B-$04E332 DATA
RoomData_Sprites_Room0081:
{
    db $01 ; Layered OAM
    db $EB, $6B, $42 ; SPRITE 42   | xy: { 0x0B0, 0x0B0, L } | s: 0x1B
    db $8B, $6E, $42 ; SPRITE 42   | xy: { 0x0E0, 0x0B0, L } | s: 0x03
    db $FF ; END
}

; ==============================================================================

; $04E333-$04E33D DATA
RoomData_Sprites_Room0082:
{
    db $00 ; Unlayered OAM
    db $E5, $69, $41 ; SPRITE 41   | xy: { 0x090, 0x050, L } | s: 0x1B
    db $86, $70, $41 ; SPRITE 41   | xy: { 0x100, 0x060, L } | s: 0x03
    db $91, $75, $41 ; SPRITE 41   | xy: { 0x150, 0x110, L } | s: 0x03
    db $FF ; END
}

; ==============================================================================

; $04E33E-$04E35D DATA
RoomData_Sprites_Room0083:
{
    db $00 ; Unlayered OAM
    db $08, $1B, $63 ; SPRITE 63   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $10, $14, $63 ; SPRITE 63   | xy: { 0x140, 0x100, U } | s: 0x00
    db $05, $14, $71 ; SPRITE 71   | xy: { 0x140, 0x050, U } | s: 0x00
    db $06, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x060, U } | s: 0x00
    db $08, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x080, U } | s: 0x00
    db $0B, $1B, $71 ; SPRITE 71   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $10, $17, $71 ; SPRITE 71   | xy: { 0x170, 0x100, U } | s: 0x00
    db $17, $08, $61 ; SPRITE 61   | xy: { 0x080, 0x170, U } | s: 0x00
    db $18, $18, $71 ; SPRITE 71   | xy: { 0x180, 0x180, U } | s: 0x00
    db $1B, $14, $71 ; SPRITE 71   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E35E-$04E374 DATA
RoomData_Sprites_Room0084:
{
    db $00 ; Unlayered OAM
    db $05, $03, $71 ; SPRITE 71   | xy: { 0x030, 0x050, U } | s: 0x00
    db $05, $1B, $71 ; SPRITE 71   | xy: { 0x1B0, 0x050, U } | s: 0x00
    db $07, $0F, $61 ; SPRITE 61   | xy: { 0x0F0, 0x070, U } | s: 0x00
    db $12, $09, $71 ; SPRITE 71   | xy: { 0x090, 0x120, U } | s: 0x00
    db $12, $15, $71 ; SPRITE 71   | xy: { 0x150, 0x120, U } | s: 0x00
    db $1B, $09, $71 ; SPRITE 71   | xy: { 0x090, 0x1B0, U } | s: 0x00
    db $1B, $15, $71 ; SPRITE 71   | xy: { 0x150, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E375-$04E394 DATA
RoomData_Sprites_Room0085:
{
    db $00 ; Unlayered OAM
    db $0E, $07, $63 ; SPRITE 63   | xy: { 0x070, 0x0E0, U } | s: 0x00
    db $1B, $09, $64 ; SPRITE 64   | xy: { 0x090, 0x1B0, U } | s: 0x00
    db $05, $14, $4F ; SPRITE 4F   | xy: { 0x140, 0x050, U } | s: 0x00
    db $05, $1B, $4F ; SPRITE 4F   | xy: { 0x1B0, 0x050, U } | s: 0x00
    db $08, $16, $4F ; SPRITE 4F   | xy: { 0x160, 0x080, U } | s: 0x00
    db $0A, $18, $61 ; SPRITE 61   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $0E, $03, $71 ; SPRITE 71   | xy: { 0x030, 0x0E0, U } | s: 0x00
    db $15, $0C, $71 ; SPRITE 71   | xy: { 0x0C0, 0x150, U } | s: 0x00
    db $18, $18, $61 ; SPRITE 61   | xy: { 0x180, 0x180, U } | s: 0x00
    db $1C, $07, $71 ; SPRITE 71   | xy: { 0x070, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E395-$04E396 DATA
RoomData_Sprites_Room0086:
{
    db $01 ; Layered OAM
    db $FF ; END
}

; ==============================================================================

; $04E397-$04E3BF DATA
RoomData_Sprites_Room0087:
{
    db $00 ; Unlayered OAM
    db $05, $14, $18 ; SPRITE 18   | xy: { 0x140, 0x050, U } | s: 0x00
    db $07, $1A, $18 ; SPRITE 18   | xy: { 0x1A0, 0x070, U } | s: 0x00
    db $0B, $13, $18 ; SPRITE 18   | xy: { 0x130, 0x0B0, U } | s: 0x00
    db $19, $06, $18 ; SPRITE 18   | xy: { 0x060, 0x190, U } | s: 0x00
    db $08, $E7, $14 ; OVERLORD 14 | xy: { 0x070, 0x080, U }
    db $04, $17, $1E ; SPRITE 1E   | xy: { 0x170, 0x040, U } | s: 0x00
    db $0C, $03, $1E ; SPRITE 1E   | xy: { 0x030, 0x0C0, U } | s: 0x00
    db $15, $04, $1E ; SPRITE 1E   | xy: { 0x040, 0x150, U } | s: 0x00
    db $17, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x170, U } | s: 0x00
    db $18, $19, $A7 ; SPRITE A7   | xy: { 0x190, 0x180, U } | s: 0x00
    db $19, $04, $A7 ; SPRITE A7   | xy: { 0x040, 0x190, U } | s: 0x00
    db $1A, $08, $E4 ; SPRITE E4   | xy: { 0x080, 0x1A0, U } | s: 0x00
    db $1C, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E3C0-$04E3C7 DATA
RoomData_Sprites_Room0089:
{
    db $00 ; Unlayered OAM
    db $0A, $10, $E3 ; SPRITE E3   | xy: { 0x100, 0x0A0, U } | s: 0x00
    db $0B, $0F, $E3 ; SPRITE E3   | xy: { 0x0F0, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E3C8-$04E3E1 DATA
RoomData_Sprites_Room008B:
{
    db $00 ; Unlayered OAM
    db $07, $15, $93 ; SPRITE 93   | xy: { 0x150, 0x070, U } | s: 0x00
    db $18, $04, $1E ; SPRITE 1E   | xy: { 0x040, 0x180, U } | s: 0x00
    db $18, $0B, $1E ; SPRITE 1E   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $04, $1A, $24 ; SPRITE 24   | xy: { 0x1A0, 0x040, U } | s: 0x00
    db $12, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x120, U } | s: 0x00
    db $18, $07, $A7 ; SPRITE A7   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $18, $7E ; SPRITE 7E   | xy: { 0x180, 0x180, U } | s: 0x00
    db $18, $18, $7F ; SPRITE 7F   | xy: { 0x180, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E3E2-$04E413 DATA
RoomData_Sprites_Room008C:
{
    db $00 ; Unlayered OAM
    db $03, $1A, $06 ; SPRITE 06   | xy: { 0x1A0, 0x030, U } | s: 0x00
    db $05, $F8, $1A ; OVERLORD 1A | xy: { 0x180, 0x050, U }
    db $06, $F5, $1A ; OVERLORD 1A | xy: { 0x150, 0x060, U }
    db $06, $FA, $1A ; OVERLORD 1A | xy: { 0x1A0, 0x060, U }
    db $0A, $F5, $1A ; OVERLORD 1A | xy: { 0x150, 0x0A0, U }
    db $0A, $FA, $1A ; OVERLORD 1A | xy: { 0x1A0, 0x0A0, U }
    db $08, $08, $5B ; SPRITE 5B   | xy: { 0x080, 0x080, U } | s: 0x00
    db $08, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x080, U } | s: 0x00
    db $09, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x090, U } | s: 0x00
    db $0B, $03, $A7 ; SPRITE A7   | xy: { 0x030, 0x0B0, U } | s: 0x00
    db $17, $05, $80 ; SPRITE 80   | xy: { 0x050, 0x170, U } | s: 0x00
    db $17, $16, $5B ; SPRITE 5B   | xy: { 0x160, 0x170, U } | s: 0x00
    db $18, $14, $15 ; SPRITE 15   | xy: { 0x140, 0x180, U } | s: 0x00
    db $1B, $0B, $80 ; SPRITE 80   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $1C, $1A, $15 ; SPRITE 15   | xy: { 0x1A0, 0x1C0, U } | s: 0x00
    db $07, $09, $3B ; SPRITE 3B   | xy: { 0x090, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E414-$04E43C DATA
RoomData_Sprites_Room008D:
{
    db $00 ; Unlayered OAM
    db $08, $E7, $14 ; OVERLORD 14 | xy: { 0x070, 0x080, U }
    db $04, $07, $C6 ; SPRITE C6   | xy: { 0x070, 0x040, U } | s: 0x00
    db $08, $09, $15 ; SPRITE 15   | xy: { 0x090, 0x080, U } | s: 0x00
    db $09, $08, $D1 ; SPRITE D1   | xy: { 0x080, 0x090, U } | s: 0x00
    db $0C, $09, $C6 ; SPRITE C6   | xy: { 0x090, 0x0C0, U } | s: 0x00
    db $0D, $13, $8B ; SPRITE 8B   | xy: { 0x130, 0x0D0, U } | s: 0x00
    db $0F, $EF, $09 ; OVERLORD 09 | xy: { 0x0F0, 0x0F0, U }
    db $10, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x100, U } | s: 0x00
    db $14, $17, $A7 ; SPRITE A7   | xy: { 0x170, 0x140, U } | s: 0x00
    db $18, $07, $7E ; SPRITE 7E   | xy: { 0x070, 0x180, U } | s: 0x00
    db $1B, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $1C, $13, $C5 ; SPRITE C5   | xy: { 0x130, 0x1C0, U } | s: 0x00
    db $1C, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E43D-$04E456 DATA
RoomData_Sprites_Room008E:
{
    db $00 ; Unlayered OAM
    db $02, $1B, $A1 ; SPRITE A1   | xy: { 0x1B0, 0x020, U } | s: 0x00
    db $05, $18, $8F ; SPRITE 8F   | xy: { 0x180, 0x050, U } | s: 0x00
    db $06, $14, $D1 ; SPRITE D1   | xy: { 0x140, 0x060, U } | s: 0x00
    db $08, $1B, $8F ; SPRITE 8F   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $09, $14, $8F ; SPRITE 8F   | xy: { 0x140, 0x090, U } | s: 0x00
    db $0A, $16, $8F ; SPRITE 8F   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0B, $14, $8F ; SPRITE 8F   | xy: { 0x140, 0x0B0, U } | s: 0x00
    db $0B, $18, $8F ; SPRITE 8F   | xy: { 0x180, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E457-$04E45B DATA
RoomData_Sprites_Room0090:
{
    db $00 ; Unlayered OAM
    db $15, $07, $BD ; SPRITE BD   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E45C-$04E472 DATA
RoomData_Sprites_Room0091:
{
    db $00 ; Unlayered OAM
    db $04, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x040, U } | s: 0x00
    db $0E, $1B, $8A ; SPRITE 8A   | xy: { 0x1B0, 0x0E0, U } | s: 0x00
    db $0F, $F7, $08 ; OVERLORD 08 | xy: { 0x170, 0x0F0, U }
    db $12, $17, $C5 ; SPRITE C5   | xy: { 0x170, 0x120, U } | s: 0x00
    db $12, $18, $D1 ; SPRITE D1   | xy: { 0x180, 0x120, U } | s: 0x00
    db $12, $19, $15 ; SPRITE 15   | xy: { 0x190, 0x120, U } | s: 0x00
    db $18, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E473-$04E498 DATA
RoomData_Sprites_Room0092:
{
    db $00 ; Unlayered OAM
    db $09, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x090, U } | s: 0x00
    db $0C, $03, $1E ; SPRITE 1E   | xy: { 0x030, 0x0C0, U } | s: 0x00
    db $04, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x040, U } | s: 0x00
    db $05, $0B, $C5 ; SPRITE C5   | xy: { 0x0B0, 0x050, U } | s: 0x00
    db $08, $09, $15 ; SPRITE 15   | xy: { 0x090, 0x080, U } | s: 0x00
    db $09, $17, $C5 ; SPRITE C5   | xy: { 0x170, 0x090, U } | s: 0x00
    db $0F, $15, $C6 ; SPRITE C6   | xy: { 0x150, 0x0F0, U } | s: 0x00
    db $12, $E7, $16 ; OVERLORD 16 | xy: { 0x070, 0x120, U }
    db $12, $19, $8A ; SPRITE 8A   | xy: { 0x190, 0x120, U } | s: 0x00
    db $14, $03, $15 ; SPRITE 15   | xy: { 0x030, 0x140, U } | s: 0x00
    db $16, $0A, $A7 ; SPRITE A7   | xy: { 0x0A0, 0x160, U } | s: 0x00
    db $1B, $03, $15 ; SPRITE 15   | xy: { 0x030, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E499-$04E4B2 DATA
RoomData_Sprites_Room0093:
{
    db $00 ; Unlayered OAM
    db $09, $09, $C5 ; SPRITE C5   | xy: { 0x090, 0x090, U } | s: 0x00
    db $09, $16, $C5 ; SPRITE C5   | xy: { 0x160, 0x090, U } | s: 0x00
    db $0C, $0C, $C5 ; SPRITE C5   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $0C, $13, $C5 ; SPRITE C5   | xy: { 0x130, 0x0C0, U } | s: 0x00
    db $0C, $17, $8F ; SPRITE 8F   | xy: { 0x170, 0x0C0, U } | s: 0x00
    db $15, $04, $A7 ; SPRITE A7   | xy: { 0x040, 0x150, U } | s: 0x00
    db $1C, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x1C0, U } | s: 0x00
    db $1C, $04, $15 ; SPRITE 15   | xy: { 0x040, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E4B3-$04E4C3 DATA
RoomData_Sprites_Room0095:
{
    db $00 ; Unlayered OAM
    db $0C, $16, $43 ; SPRITE 43   | xy: { 0x160, 0x0C0, U } | s: 0x00
    db $0C, $17, $43 ; SPRITE 43   | xy: { 0x170, 0x0C0, U } | s: 0x00
    db $0C, $18, $43 ; SPRITE 43   | xy: { 0x180, 0x0C0, U } | s: 0x00
    db $0C, $19, $43 ; SPRITE 43   | xy: { 0x190, 0x0C0, U } | s: 0x00
    db $1A, $F7, $0B ; OVERLORD 0B | xy: { 0x170, 0x1A0, U }
    db $FF ; END
}

; ==============================================================================

; $04E4C4-$04E4D4 DATA
RoomData_Sprites_Room0096:
{
    db $00 ; Unlayered OAM
    db $0B, $08, $7E ; SPRITE 7E   | xy: { 0x080, 0x0B0, U } | s: 0x00
    db $15, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x150, U } | s: 0x00
    db $17, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x170, U } | s: 0x00
    db $19, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x190, U } | s: 0x00
    db $1B, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E4D5-$04E4D9 DATA
RoomData_Sprites_Room0097:
{
    db $00 ; Unlayered OAM
    db $0F, $EF, $15 ; OVERLORD 15 | xy: { 0x0F0, 0x0F0, U }
    db $FF ; END
}

; ==============================================================================

; $04E4DA-$04E4EA DATA
RoomData_Sprites_Room0098:
{
    db $00 ; Unlayered OAM
    db $13, $10, $8F ; SPRITE 8F   | xy: { 0x100, 0x130, U } | s: 0x00
    db $14, $09, $8F ; SPRITE 8F   | xy: { 0x090, 0x140, U } | s: 0x00
    db $14, $0C, $8F ; SPRITE 8F   | xy: { 0x0C0, 0x140, U } | s: 0x00
    db $14, $0F, $8F ; SPRITE 8F   | xy: { 0x0F0, 0x140, U } | s: 0x00
    db $17, $08, $8F ; SPRITE 8F   | xy: { 0x080, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E4EB-$04E50D DATA
RoomData_Sprites_Room0099:
{
    db $00 ; Unlayered OAM
    db $06, $15, $15 ; SPRITE 15   | xy: { 0x150, 0x060, U } | s: 0x00
    db $08, $1A, $15 ; SPRITE 15   | xy: { 0x1A0, 0x080, U } | s: 0x00
    db $17, $0E, $83 ; SPRITE 83   | xy: { 0x0E0, 0x170, U } | s: 0x00
    db $17, $11, $83 ; SPRITE 83   | xy: { 0x110, 0x170, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $18, $0D, $4E ; SPRITE 4E   | xy: { 0x0D0, 0x180, U } | s: 0x00
    db $18, $12, $4E ; SPRITE 4E   | xy: { 0x120, 0x180, U } | s: 0x00
    db $19, $0E, $4F ; SPRITE 4F   | xy: { 0x0E0, 0x190, U } | s: 0x00
    db $19, $0F, $4F ; SPRITE 4F   | xy: { 0x0F0, 0x190, U } | s: 0x00
    db $19, $10, $4F ; SPRITE 4F   | xy: { 0x100, 0x190, U } | s: 0x00
    db $19, $11, $4F ; SPRITE 4F   | xy: { 0x110, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E50E-$04E536 DATA
RoomData_Sprites_Room009B:
{
    db $00 ; Unlayered OAM
    db $08, $06, $1E ; SPRITE 1E   | xy: { 0x060, 0x080, U } | s: 0x00
    db $08, $07, $1E ; SPRITE 1E   | xy: { 0x070, 0x080, U } | s: 0x00
    db $08, $14, $1E ; SPRITE 1E   | xy: { 0x140, 0x080, U } | s: 0x00
    db $05, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x050, U } | s: 0x00
    db $06, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x060, U } | s: 0x00
    db $07, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x070, U } | s: 0x00
    db $08, $03, $C6 ; SPRITE C6   | xy: { 0x030, 0x080, U } | s: 0x00
    db $08, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x080, U } | s: 0x00
    db $09, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x090, U } | s: 0x00
    db $0A, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x0A0, U } | s: 0x00
    db $0B, $1C, $8A ; SPRITE 8A   | xy: { 0x1C0, 0x0B0, U } | s: 0x00
    db $1A, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $1B, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E537-$04E54D DATA
RoomData_Sprites_Room009C:
{
    db $00 ; Unlayered OAM
    db $09, $13, $26 ; SPRITE 26   | xy: { 0x130, 0x090, U } | s: 0x00
    db $0A, $0B, $13 ; SPRITE 13   | xy: { 0x0B0, 0x0A0, U } | s: 0x00
    db $0F, $11, $26 ; SPRITE 26   | xy: { 0x110, 0x0F0, U } | s: 0x00
    db $0E, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x0E0, U } | s: 0x00
    db $12, $0D, $26 ; SPRITE 26   | xy: { 0x0D0, 0x120, U } | s: 0x00
    db $13, $09, $26 ; SPRITE 26   | xy: { 0x090, 0x130, U } | s: 0x00
    db $1C, $0F, $80 ; SPRITE 80   | xy: { 0x0F0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E54E-$04E56A DATA
RoomData_Sprites_Room009D:
{
    db $00 ; Unlayered OAM
    db $06, $1C, $1E ; SPRITE 1E   | xy: { 0x1C0, 0x060, U } | s: 0x00
    db $04, $06, $26 ; SPRITE 26   | xy: { 0x060, 0x040, U } | s: 0x00
    db $04, $14, $8B ; SPRITE 8B   | xy: { 0x140, 0x040, U } | s: 0x00
    db $09, $18, $8B ; SPRITE 8B   | xy: { 0x180, 0x090, U } | s: 0x00
    db $0C, $05, $26 ; SPRITE 26   | xy: { 0x050, 0x0C0, U } | s: 0x00
    db $0C, $13, $8B ; SPRITE 8B   | xy: { 0x130, 0x0C0, U } | s: 0x00
    db $14, $10, $24 ; SPRITE 24   | xy: { 0x100, 0x140, U } | s: 0x00
    db $18, $0B, $24 ; SPRITE 24   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $1C, $11, $24 ; SPRITE 24   | xy: { 0x110, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E56B-$04E57B DATA
RoomData_Sprites_Room009E:
{
    db $00 ; Unlayered OAM
    db $05, $18, $23 ; SPRITE 23   | xy: { 0x180, 0x050, U } | s: 0x00
    db $08, $16, $23 ; SPRITE 23   | xy: { 0x160, 0x080, U } | s: 0x00
    db $08, $18, $91 ; SPRITE 91   | xy: { 0x180, 0x080, U } | s: 0x00
    db $08, $19, $23 ; SPRITE 23   | xy: { 0x190, 0x080, U } | s: 0x00
    db $12, $14, $A1 ; SPRITE A1   | xy: { 0x140, 0x120, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E57C-$04E58F DATA
RoomData_Sprites_Room009F:
{
    db $00 ; Unlayered OAM
    db $12, $04, $9D ; SPRITE 9D   | xy: { 0x040, 0x120, U } | s: 0x00
    db $12, $06, $9D ; SPRITE 9D   | xy: { 0x060, 0x120, U } | s: 0x00
    db $12, $09, $9D ; SPRITE 9D   | xy: { 0x090, 0x120, U } | s: 0x00
    db $12, $0B, $9D ; SPRITE 9D   | xy: { 0x0B0, 0x120, U } | s: 0x00
    db $17, $07, $15 ; SPRITE 15   | xy: { 0x070, 0x170, U } | s: 0x00
    db $18, $08, $7E ; SPRITE 7E   | xy: { 0x080, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E590-$04E59A DATA
RoomData_Sprites_Room00A0:
{
    db $00 ; Unlayered OAM
    db $08, $03, $C5 ; SPRITE C5   | xy: { 0x030, 0x080, U } | s: 0x00
    db $08, $0E, $15 ; SPRITE 15   | xy: { 0x0E0, 0x080, U } | s: 0x00
    db $0C, $14, $80 ; SPRITE 80   | xy: { 0x140, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E59B-$04E5B7 DATA
RoomData_Sprites_Room00A1:
{
    db $00 ; Unlayered OAM
    db $08, $0A, $1E ; SPRITE 1E   | xy: { 0x0A0, 0x080, U } | s: 0x00
    db $07, $18, $5B ; SPRITE 5B   | xy: { 0x180, 0x070, U } | s: 0x00
    db $0B, $16, $5B ; SPRITE 5B   | xy: { 0x160, 0x0B0, U } | s: 0x00
    db $10, $19, $9B ; SPRITE 9B   | xy: { 0x190, 0x100, U } | s: 0x00
    db $15, $15, $C5 ; SPRITE C5   | xy: { 0x150, 0x150, U } | s: 0x00
    db $15, $1A, $C5 ; SPRITE C5   | xy: { 0x1A0, 0x150, U } | s: 0x00
    db $19, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x190, U } | s: 0x00
    db $19, $17, $D1 ; SPRITE D1   | xy: { 0x170, 0x190, U } | s: 0x00
    db $19, $1B, $A7 ; SPRITE A7   | xy: { 0x1B0, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E5B8-$04E5B9 DATA
RoomData_Sprites_Room00A3:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04E5BA-$04E5C4 DATA
RoomData_Sprites_Room00A4:
{
    db $00 ; Unlayered OAM
    db $15, $07, $CB ; SPRITE CB   | xy: { 0x070, 0x150, U } | s: 0x00
    db $15, $07, $CC ; SPRITE CC   | xy: { 0x070, 0x150, U } | s: 0x00
    db $15, $07, $CD ; SPRITE CD   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E5C5-$04E5EA DATA
RoomData_Sprites_Room00A5:
{
    db $00 ; Unlayered OAM
    db $05, $16, $9B ; SPRITE 9B   | xy: { 0x160, 0x050, U } | s: 0x00
    db $05, $19, $9B ; SPRITE 9B   | xy: { 0x190, 0x050, U } | s: 0x00
    db $07, $04, $9B ; SPRITE 9B   | xy: { 0x040, 0x070, U } | s: 0x00
    db $07, $0B, $9B ; SPRITE 9B   | xy: { 0x0B0, 0x070, U } | s: 0x00
    db $08, $17, $8A ; SPRITE 8A   | xy: { 0x170, 0x080, U } | s: 0x00
    db $09, $15, $9B ; SPRITE 9B   | xy: { 0x150, 0x090, U } | s: 0x00
    db $09, $1A, $9B ; SPRITE 9B   | xy: { 0x1A0, 0x090, U } | s: 0x00
    db $0A, $08, $9B ; SPRITE 9B   | xy: { 0x080, 0x0A0, U } | s: 0x00
    db $12, $0C, $97 ; SPRITE 97   | xy: { 0x0C0, 0x120, U } | s: 0x00
    db $12, $12, $97 ; SPRITE 97   | xy: { 0x120, 0x120, U } | s: 0x00
    db $17, $12, $43 ; SPRITE 43   | xy: { 0x120, 0x170, U } | s: 0x00
    db $18, $13, $41 ; SPRITE 41   | xy: { 0x130, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E5EB-$04E5F2 DATA
RoomData_Sprites_Room00A6:
{
    db $00 ; Unlayered OAM
    db $0F, $EF, $15 ; OVERLORD 15 | xy: { 0x0F0, 0x0F0, U }
    db $0E, $0C, $15 ; SPRITE 15   | xy: { 0x0C0, 0x0E0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E5F3-$04E5FA DATA
RoomData_Sprites_Room00A7:
{
    db $00 ; Unlayered OAM
    db $08, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x080, U } | s: 0x00
    db $09, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E5FB-$04E60B DATA
RoomData_Sprites_Room00A8:
{
    db $01 ; Layered OAM
    db $0E, $16, $A7 ; SPRITE A7   | xy: { 0x160, 0x0E0, U } | s: 0x00
    db $0E, $1A, $A7 ; SPRITE A7   | xy: { 0x1A0, 0x0E0, U } | s: 0x00
    db $12, $16, $A7 ; SPRITE A7   | xy: { 0x160, 0x120, U } | s: 0x00
    db $12, $1A, $A7 ; SPRITE A7   | xy: { 0x1A0, 0x120, U } | s: 0x00
    db $16, $E8, $18 ; OVERLORD 18 | xy: { 0x080, 0x160, U }
    db $FF ; END
}

; ==============================================================================

; $04E60C-$04E625 DATA
RoomData_Sprites_Room00A9:
{
    db $00 ; Unlayered OAM
    db $85, $09, $83 ; SPRITE 83   | xy: { 0x090, 0x050, L } | s: 0x00
    db $85, $16, $83 ; SPRITE 83   | xy: { 0x160, 0x050, L } | s: 0x00
    db $8C, $ED, $05 ; OVERLORD 05 | xy: { 0x0D0, 0x0C0, L }
    db $8C, $F2, $05 ; OVERLORD 05 | xy: { 0x120, 0x0C0, L }
    db $92, $ED, $05 ; OVERLORD 05 | xy: { 0x0D0, 0x120, L }
    db $92, $F2, $05 ; OVERLORD 05 | xy: { 0x120, 0x120, L }
    db $90, $0A, $A7 ; SPRITE A7   | xy: { 0x0A0, 0x100, L } | s: 0x00
    db $90, $14, $A7 ; SPRITE A7   | xy: { 0x140, 0x100, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E626-$04E639 DATA
RoomData_Sprites_Room00AA:
{
    db $01 ; Layered OAM
    db $06, $18, $15 ; SPRITE 15   | xy: { 0x180, 0x060, U } | s: 0x00
    db $07, $0A, $4F ; SPRITE 4F   | xy: { 0x0A0, 0x070, U } | s: 0x00
    db $0B, $06, $A7 ; SPRITE A7   | xy: { 0x060, 0x0B0, U } | s: 0x00
    db $0C, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x0C0, U } | s: 0x00
    db $13, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x130, U } | s: 0x00
    db $14, $0A, $4F ; SPRITE 4F   | xy: { 0x0A0, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E63A-$04E653 DATA
RoomData_Sprites_Room00AB:
{
    db $00 ; Unlayered OAM
    db $18, $04, $1E ; SPRITE 1E   | xy: { 0x040, 0x180, U } | s: 0x00
    db $15, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x150, U } | s: 0x00
    db $16, $0C, $8A ; SPRITE 8A   | xy: { 0x0C0, 0x160, U } | s: 0x00
    db $17, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x170, U } | s: 0x00
    db $18, $06, $8F ; SPRITE 8F   | xy: { 0x060, 0x180, U } | s: 0x00
    db $19, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x190, U } | s: 0x00
    db $1A, $0C, $8A ; SPRITE 8A   | xy: { 0x0C0, 0x1A0, U } | s: 0x00
    db $1B, $03, $8A ; SPRITE 8A   | xy: { 0x030, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E654-$04E658 DATA
RoomData_Sprites_Room00AC:
{
    db $00 ; Unlayered OAM
    db $15, $19, $CE ; SPRITE CE   | xy: { 0x190, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E659-$04E660 DATA
RoomData_Sprites_Room00AE:
{
    db $00 ; Unlayered OAM
    db $07, $13, $24 ; SPRITE 24   | xy: { 0x130, 0x070, U } | s: 0x00
    db $07, $15, $24 ; SPRITE 24   | xy: { 0x150, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E661-$04E665 DATA
RoomData_Sprites_Room00AF:
{
    db $00 ; Unlayered OAM
    db $08, $0A, $7E ; SPRITE 7E   | xy: { 0x0A0, 0x080, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E666-$04E691 DATA
RoomData_Sprites_Room00B0:
{
    db $00 ; Unlayered OAM
    db $07, $07, $43 ; SPRITE 43   | xy: { 0x070, 0x070, U } | s: 0x00
    db $07, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x070, U } | s: 0x00
    db $07, $18, $6F ; SPRITE 6F   | xy: { 0x180, 0x070, U } | s: 0x00
    db $08, $14, $48 ; SPRITE 48   | xy: { 0x140, 0x080, U } | s: 0x00
    db $08, $1B, $48 ; SPRITE 48   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $0B, $05, $43 ; SPRITE 43   | xy: { 0x050, 0x0B0, U } | s: 0x00
    db $14, $16, $6A ; SPRITE 6A   | xy: { 0x160, 0x140, U } | s: 0x00
    db $16, $04, $6F ; SPRITE 6F   | xy: { 0x040, 0x160, U } | s: 0x00
    db $16, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x160, U } | s: 0x00
    db $16, $0A, $43 ; SPRITE 43   | xy: { 0x0A0, 0x160, U } | s: 0x00
    db $18, $08, $43 ; SPRITE 43   | xy: { 0x080, 0x180, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $1A, $1B, $44 ; SPRITE 44   | xy: { 0x1B0, 0x1A0, U } | s: 0x00
    db $1C, $17, $48 ; SPRITE 48   | xy: { 0x170, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E692-$04E6B1 DATA
RoomData_Sprites_Room00B1:
{
    db $00 ; Unlayered OAM
    db $07, $15, $C5 ; SPRITE C5   | xy: { 0x150, 0x070, U } | s: 0x00
    db $07, $1A, $C5 ; SPRITE C5   | xy: { 0x1A0, 0x070, U } | s: 0x00
    db $0E, $16, $8A ; SPRITE 8A   | xy: { 0x160, 0x0E0, U } | s: 0x00
    db $11, $19, $8A ; SPRITE 8A   | xy: { 0x190, 0x110, U } | s: 0x00
    db $17, $0C, $9B ; SPRITE 9B   | xy: { 0x0C0, 0x170, U } | s: 0x00
    db $17, $1A, $7D ; SPRITE 7D   | xy: { 0x1A0, 0x170, U } | s: 0x00
    db $18, $07, $C6 ; SPRITE C6   | xy: { 0x070, 0x180, U } | s: 0x00
    db $1A, $03, $9B ; SPRITE 9B   | xy: { 0x030, 0x1A0, U } | s: 0x00
    db $1A, $15, $15 ; SPRITE 15   | xy: { 0x150, 0x1A0, U } | s: 0x00
    db $1C, $08, $9B ; SPRITE 9B   | xy: { 0x080, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E6B2-$04E6DD DATA
RoomData_Sprites_Room00B2:
{
    db $01 ; Layered OAM
    db $88, $14, $9B ; SPRITE 9B   | xy: { 0x140, 0x080, L } | s: 0x00
    db $8A, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x0A0, L } | s: 0x00
    db $8A, $12, $15 ; SPRITE 15   | xy: { 0x120, 0x0A0, L } | s: 0x00
    db $8A, $13, $D1 ; SPRITE D1   | xy: { 0x130, 0x0A0, L } | s: 0x00
    db $8B, $07, $15 ; SPRITE 15   | xy: { 0x070, 0x0B0, L } | s: 0x00
    db $15, $04, $20 ; SPRITE 20   | xy: { 0x040, 0x150, U } | s: 0x00
    db $15, $0B, $20 ; SPRITE 20   | xy: { 0x0B0, 0x150, U } | s: 0x00
    db $16, $03, $15 ; SPRITE 15   | xy: { 0x030, 0x160, U } | s: 0x00
    db $18, $15, $C5 ; SPRITE C5   | xy: { 0x150, 0x180, U } | s: 0x00
    db $18, $1A, $C5 ; SPRITE C5   | xy: { 0x1A0, 0x180, U } | s: 0x00
    db $1B, $04, $20 ; SPRITE 20   | xy: { 0x040, 0x1B0, U } | s: 0x00
    db $1B, $0B, $20 ; SPRITE 20   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $1B, $14, $4E ; SPRITE 4E   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $1B, $1B, $4E ; SPRITE 4E   | xy: { 0x1B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E6DE-$04E6EE DATA
RoomData_Sprites_Room00B3:
{
    db $00 ; Unlayered OAM
    db $15, $03, $A7 ; SPRITE A7   | xy: { 0x030, 0x150, U } | s: 0x00
    db $15, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x150, U } | s: 0x00
    db $18, $06, $61 ; SPRITE 61   | xy: { 0x060, 0x180, U } | s: 0x00
    db $1A, $0A, $C6 ; SPRITE C6   | xy: { 0x0A0, 0x1A0, U } | s: 0x00
    db $1C, $07, $A7 ; SPRITE A7   | xy: { 0x070, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E6EF-$04E6F9 DATA
RoomData_Sprites_Room00B5:
{
    db $00 ; Unlayered OAM
    db $0A, $16, $7E ; SPRITE 7E   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0F, $09, $7E ; SPRITE 7E   | xy: { 0x090, 0x0F0, U } | s: 0x00
    db $16, $16, $7E ; SPRITE 7E   | xy: { 0x160, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E6FA-$04E719 DATA
RoomData_Sprites_Room00B6:
{
    db $00 ; Unlayered OAM
    db $07, $06, $CA ; SPRITE CA   | xy: { 0x060, 0x070, U } | s: 0x00
    db $07, $0A, $CA ; SPRITE CA   | xy: { 0x0A0, 0x070, U } | s: 0x00
    db $04, $03, $1E ; SPRITE 1E   | xy: { 0x030, 0x040, U } | s: 0x00
    db $04, $0C, $1E ; SPRITE 1E   | xy: { 0x0C0, 0x040, U } | s: 0x00
    db $07, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x070, U } | s: 0x00
    db $15, $07, $C7 ; SPRITE C7   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $18, $F7, $14 ; OVERLORD 14 | xy: { 0x170, 0x180, U }
    db $1B, $07, $8F ; SPRITE 8F   | xy: { 0x070, 0x1B0, U } | s: 0x00
    db $1B, $08, $8F ; SPRITE 8F   | xy: { 0x080, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E71A-$04E721 DATA
RoomData_Sprites_Room00B7:
{
    db $00 ; Unlayered OAM
    db $09, $04, $5F ; SPRITE 5F   | xy: { 0x040, 0x090, U } | s: 0x00
    db $11, $04, $5D ; SPRITE 5D   | xy: { 0x040, 0x110, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E722-$04E735 DATA
RoomData_Sprites_Room00B8:
{
    db $00 ; Unlayered OAM
    db $0B, $15, $4E ; SPRITE 4E   | xy: { 0x150, 0x0B0, U } | s: 0x00
    db $0B, $1B, $4E ; SPRITE 4E   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $0D, $18, $82 ; SPRITE 82   | xy: { 0x180, 0x0D0, U } | s: 0x00
    db $13, $18, $83 ; SPRITE 83   | xy: { 0x180, 0x130, U } | s: 0x00
    db $16, $14, $A7 ; SPRITE A7   | xy: { 0x140, 0x160, U } | s: 0x00
    db $16, $1C, $A7 ; SPRITE A7   | xy: { 0x1C0, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E736-$04E73A DATA
RoomData_Sprites_Room00B9:
{
    db $01 ; Layered OAM
    db $85, $F1, $03 ; OVERLORD 03 | xy: { 0x110, 0x050, L }
    db $FF ; END
}

; ==============================================================================

; $04E73B-$04E751 DATA
RoomData_Sprites_Room00BA:
{
    db $00 ; Unlayered OAM
    db $04, $14, $A7 ; SPRITE A7   | xy: { 0x140, 0x040, U } | s: 0x00
    db $06, $03, $15 ; SPRITE 15   | xy: { 0x030, 0x060, U } | s: 0x00
    db $06, $18, $A7 ; SPRITE A7   | xy: { 0x180, 0x060, U } | s: 0x00
    db $09, $03, $15 ; SPRITE 15   | xy: { 0x030, 0x090, U } | s: 0x00
    db $09, $0C, $4F ; SPRITE 4F   | xy: { 0x0C0, 0x090, U } | s: 0x00
    db $0A, $18, $A7 ; SPRITE A7   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $0C, $08, $4F ; SPRITE 4F   | xy: { 0x080, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E752-$04E774 DATA
RoomData_Sprites_Room00BB:
{
    db $00 ; Unlayered OAM
    db $04, $1B, $A6 ; SPRITE A6   | xy: { 0x1B0, 0x040, U } | s: 0x00
    db $0A, $06, $C3 ; SPRITE C3   | xy: { 0x060, 0x0A0, U } | s: 0x00
    db $0A, $16, $A6 ; SPRITE A6   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0A, $19, $C3 ; SPRITE C3   | xy: { 0x190, 0x0A0, U } | s: 0x00
    db $0C, $08, $15 ; SPRITE 15   | xy: { 0x080, 0x0C0, U } | s: 0x00
    db $0E, $09, $C3 ; SPRITE C3   | xy: { 0x090, 0x0E0, U } | s: 0x00
    db $10, $07, $80 ; SPRITE 80   | xy: { 0x070, 0x100, U } | s: 0x00
    db $14, $08, $C3 ; SPRITE C3   | xy: { 0x080, 0x140, U } | s: 0x00
    db $15, $19, $C3 ; SPRITE C3   | xy: { 0x190, 0x150, U } | s: 0x00
    db $16, $15, $15 ; SPRITE 15   | xy: { 0x150, 0x160, U } | s: 0x00
    db $1A, $17, $C3 ; SPRITE C3   | xy: { 0x170, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E775-$04E79A DATA
RoomData_Sprites_Room00BC:
{
    db $00 ; Unlayered OAM
    db $05, $06, $A5 ; SPRITE A5   | xy: { 0x060, 0x050, U } | s: 0x00
    db $05, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x050, U } | s: 0x00
    db $06, $08, $8A ; SPRITE 8A   | xy: { 0x080, 0x060, U } | s: 0x00
    db $09, $0A, $A6 ; SPRITE A6   | xy: { 0x0A0, 0x090, U } | s: 0x00
    db $0A, $09, $8A ; SPRITE 8A   | xy: { 0x090, 0x0A0, U } | s: 0x00
    db $0B, $05, $A5 ; SPRITE A5   | xy: { 0x050, 0x0B0, U } | s: 0x00
    db $0A, $17, $A7 ; SPRITE A7   | xy: { 0x170, 0x0A0, U } | s: 0x00
    db $11, $18, $A7 ; SPRITE A7   | xy: { 0x180, 0x110, U } | s: 0x00
    db $16, $16, $A7 ; SPRITE A7   | xy: { 0x160, 0x160, U } | s: 0x00
    db $17, $08, $A5 ; SPRITE A5   | xy: { 0x080, 0x170, U } | s: 0x00
    db $18, $07, $80 ; SPRITE 80   | xy: { 0x070, 0x180, U } | s: 0x00
    db $19, $08, $A6 ; SPRITE A6   | xy: { 0x080, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E79B-$04E79C DATA
RoomData_Sprites_Room00BD:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04E79D-$04E7B3 DATA
RoomData_Sprites_Room00BE:
{
    db $00 ; Unlayered OAM
    db $08, $17, $15 ; SPRITE 15   | xy: { 0x170, 0x080, U } | s: 0x00
    db $12, $14, $A1 ; SPRITE A1   | xy: { 0x140, 0x120, U } | s: 0x00
    db $15, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x150, U } | s: 0x00
    db $15, $1B, $24 ; SPRITE 24   | xy: { 0x1B0, 0x150, U } | s: 0x00
    db $16, $18, $91 ; SPRITE 91   | xy: { 0x180, 0x160, U } | s: 0x00
    db $1A, $14, $24 ; SPRITE 24   | xy: { 0x140, 0x1A0, U } | s: 0x00
    db $1A, $1B, $24 ; SPRITE 24   | xy: { 0x1B0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E7B4-$04E7BB DATA
RoomData_Sprites_Room00BF:
{
    db $00 ; Unlayered OAM
    db $18, $0B, $1E ; SPRITE 1E   | xy: { 0x0B0, 0x180, U } | s: 0x00
    db $15, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E7BC-$04E7D8 DATA
RoomData_Sprites_Room00C0:
{
    db $00 ; Unlayered OAM
    db $05, $17, $41 ; SPRITE 41   | xy: { 0x170, 0x050, U } | s: 0x00
    db $07, $1A, $46 ; SPRITE 46   | xy: { 0x1A0, 0x070, U } | s: 0x00
    db $09, $0B, $41 ; SPRITE 41   | xy: { 0x0B0, 0x090, U } | s: 0x00
    db $0B, $14, $46 ; SPRITE 46   | xy: { 0x140, 0x0B0, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $0E, $06, $41 ; SPRITE 41   | xy: { 0x060, 0x0E0, U } | s: 0x00
    db $18, $04, $41 ; SPRITE 41   | xy: { 0x040, 0x180, U } | s: 0x00
    db $1B, $14, $46 ; SPRITE 46   | xy: { 0x140, 0x1B0, U } | s: 0x00
    db $1B, $1B, $41 ; SPRITE 41   | xy: { 0x1B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E7D9-$04E801 DATA
RoomData_Sprites_Room00C1:
{
    db $00 ; Unlayered OAM
    db $17, $15, $1E ; SPRITE 1E   | xy: { 0x150, 0x170, U } | s: 0x00
    db $05, $14, $C5 ; SPRITE C5   | xy: { 0x140, 0x050, U } | s: 0x00
    db $05, $1B, $C5 ; SPRITE C5   | xy: { 0x1B0, 0x050, U } | s: 0x00
    db $0B, $06, $A7 ; SPRITE A7   | xy: { 0x060, 0x0B0, U } | s: 0x00
    db $0B, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x0B0, U } | s: 0x00
    db $15, $17, $7C ; SPRITE 7C   | xy: { 0x170, 0x150, U } | s: 0x00
    db $16, $09, $C5 ; SPRITE C5   | xy: { 0x090, 0x160, U } | s: 0x00
    db $18, $E7, $14 ; OVERLORD 14 | xy: { 0x070, 0x180, U }
    db $19, $14, $15 ; SPRITE 15   | xy: { 0x140, 0x190, U } | s: 0x00
    db $1A, $18, $C6 ; SPRITE C6   | xy: { 0x180, 0x1A0, U } | s: 0x00
    db $1B, $13, $24 ; SPRITE 24   | xy: { 0x130, 0x1B0, U } | s: 0x00
    db $FE, $00, $E4 ; Small key on above sprite
    db $1B, $1B, $7C ; SPRITE 7C   | xy: { 0x1B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E802-$04E81B DATA
RoomData_Sprites_Room00C2:
{
    db $01 ; Layered OAM
    db $8B, $15, $80 ; SPRITE 80   | xy: { 0x150, 0x0B0, L } | s: 0x00
    db $0C, $0B, $80 ; SPRITE 80   | xy: { 0x0B0, 0x0C0, U } | s: 0x00
    db $10, $08, $C5 ; SPRITE C5   | xy: { 0x080, 0x100, U } | s: 0x00
    db $92, $10, $5B ; SPRITE 5B   | xy: { 0x100, 0x120, L } | s: 0x00
    db $92, $19, $5B ; SPRITE 5B   | xy: { 0x190, 0x120, L } | s: 0x00
    db $94, $10, $D1 ; SPRITE D1   | xy: { 0x100, 0x140, L } | s: 0x00
    db $96, $08, $80 ; SPRITE 80   | xy: { 0x080, 0x160, L } | s: 0x00
    db $96, $16, $5B ; SPRITE 5B   | xy: { 0x160, 0x160, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E81C-$04E835 DATA
RoomData_Sprites_Room00C3:
{
    db $00 ; Unlayered OAM
    db $06, $05, $C5 ; SPRITE C5   | xy: { 0x050, 0x060, U } | s: 0x00
    db $09, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x090, U } | s: 0x00
    db $0D, $11, $95 ; SPRITE 95   | xy: { 0x110, 0x0D0, U } | s: 0x00
    db $11, $1E, $96 ; SPRITE 96   | xy: { 0x1E0, 0x110, U } | s: 0x00
    db $15, $11, $95 ; SPRITE 95   | xy: { 0x110, 0x150, U } | s: 0x00
    db $1A, $F7, $0B ; OVERLORD 0B | xy: { 0x170, 0x1A0, U }
    db $1B, $0A, $15 ; SPRITE 15   | xy: { 0x0A0, 0x1B0, U } | s: 0x00
    db $1C, $07, $C5 ; SPRITE C5   | xy: { 0x070, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E836-$04E855 DATA
RoomData_Sprites_Room00C4:
{
    db $00 ; Unlayered OAM
    db $0A, $0B, $1E ; SPRITE 1E   | xy: { 0x0B0, 0x0A0, U } | s: 0x00
    db $0F, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x0F0, U } | s: 0x00
    db $1B, $1C, $1E ; SPRITE 1E   | xy: { 0x1C0, 0x1B0, U } | s: 0x00
    db $15, $0F, $1E ; SPRITE 1E   | xy: { 0x0F0, 0x150, U } | s: 0x00
    db $0E, $0F, $C7 ; SPRITE C7   | xy: { 0x0F0, 0x0E0, U } | s: 0x00
    db $0F, $0B, $15 ; SPRITE 15   | xy: { 0x0B0, 0x0F0, U } | s: 0x00
    db $14, $07, $13 ; SPRITE 13   | xy: { 0x070, 0x140, U } | s: 0x00
    db $14, $18, $13 ; SPRITE 13   | xy: { 0x180, 0x140, U } | s: 0x00
    db $1A, $0B, $15 ; SPRITE 15   | xy: { 0x0B0, 0x1A0, U } | s: 0x00
    db $1A, $14, $15 ; SPRITE 15   | xy: { 0x140, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E856-$04E86F DATA
RoomData_Sprites_Room00C5:
{
    db $00 ; Unlayered OAM
    db $09, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x090, U } | s: 0x00
    db $0B, $01, $95 ; SPRITE 95   | xy: { 0x010, 0x0B0, U } | s: 0x00
    db $0D, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x0D0, U } | s: 0x00
    db $0F, $01, $95 ; SPRITE 95   | xy: { 0x010, 0x0F0, U } | s: 0x00
    db $11, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x110, U } | s: 0x00
    db $13, $01, $95 ; SPRITE 95   | xy: { 0x010, 0x130, U } | s: 0x00
    db $15, $07, $13 ; SPRITE 13   | xy: { 0x070, 0x150, U } | s: 0x00
    db $15, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E870-$04E886 DATA
RoomData_Sprites_Room00C6:
{
    db $00 ; Unlayered OAM
    db $04, $0B, $A7 ; SPRITE A7   | xy: { 0x0B0, 0x040, U } | s: 0x00
    db $04, $15, $A7 ; SPRITE A7   | xy: { 0x150, 0x040, U } | s: 0x00
    db $09, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x090, U } | s: 0x00
    db $09, $17, $24 ; SPRITE 24   | xy: { 0x170, 0x090, U } | s: 0x00
    db $0E, $10, $7C ; SPRITE 7C   | xy: { 0x100, 0x0E0, U } | s: 0x00
    db $14, $18, $24 ; SPRITE 24   | xy: { 0x180, 0x140, U } | s: 0x00
    db $17, $08, $24 ; SPRITE 24   | xy: { 0x080, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E887-$04E89D DATA
RoomData_Sprites_Room00C8:
{
    db $00 ; Unlayered OAM
    db $15, $14, $53 ; SPRITE 53   | xy: { 0x140, 0x150, U } | s: 0x00
    db $15, $17, $53 ; SPRITE 53   | xy: { 0x170, 0x150, U } | s: 0x00
    db $15, $1A, $53 ; SPRITE 53   | xy: { 0x1A0, 0x150, U } | s: 0x00
    db $18, $1A, $53 ; SPRITE 53   | xy: { 0x1A0, 0x180, U } | s: 0x00
    db $18, $17, $53 ; SPRITE 53   | xy: { 0x170, 0x180, U } | s: 0x00
    db $18, $14, $53 ; SPRITE 53   | xy: { 0x140, 0x180, U } | s: 0x00
    db $18, $F7, $19 ; OVERLORD 19 | xy: { 0x170, 0x180, U }
    db $FF ; END
}

; ==============================================================================

; $04E89E-$04E8A8 DATA
RoomData_Sprites_Room00C9:
{
    db $00 ; Unlayered OAM
    db $05, $10, $4F ; SPRITE 4F   | xy: { 0x100, 0x050, U } | s: 0x00
    db $06, $0F, $4F ; SPRITE 4F   | xy: { 0x0F0, 0x060, U } | s: 0x00
    db $07, $10, $4F ; SPRITE 4F   | xy: { 0x100, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E8A9-$04E8CE DATA
RoomData_Sprites_Room00CB:
{
    db $01 ; Layered OAM
    db $04, $14, $D1 ; SPRITE D1   | xy: { 0x140, 0x040, U } | s: 0x00
    db $89, $08, $80 ; SPRITE 80   | xy: { 0x080, 0x090, L } | s: 0x00
    db $8A, $10, $A5 ; SPRITE A5   | xy: { 0x100, 0x0A0, L } | s: 0x00
    db $0A, $13, $8F ; SPRITE 8F   | xy: { 0x130, 0x0A0, U } | s: 0x00
    db $8A, $16, $5B ; SPRITE 5B   | xy: { 0x160, 0x0A0, L } | s: 0x00
    db $0A, $1C, $8F ; SPRITE 8F   | xy: { 0x1C0, 0x0A0, U } | s: 0x00
    db $10, $0C, $A7 ; SPRITE A7   | xy: { 0x0C0, 0x100, U } | s: 0x00
    db $95, $18, $A6 ; SPRITE A6   | xy: { 0x180, 0x150, L } | s: 0x00
    db $97, $08, $A6 ; SPRITE A6   | xy: { 0x080, 0x170, L } | s: 0x00
    db $17, $0B, $8F ; SPRITE 8F   | xy: { 0x0B0, 0x170, U } | s: 0x00
    db $18, $0C, $8F ; SPRITE 8F   | xy: { 0x0C0, 0x180, U } | s: 0x00
    db $1C, $14, $D1 ; SPRITE D1   | xy: { 0x140, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E8CF-$04E8FA DATA
RoomData_Sprites_Room00CC:
{
    db $01 ; Layered OAM
    db $04, $13, $80 ; SPRITE 80   | xy: { 0x130, 0x040, U } | s: 0x00
    db $89, $0B, $D1 ; SPRITE D1   | xy: { 0x0B0, 0x090, L } | s: 0x00
    db $8A, $08, $A5 ; SPRITE A5   | xy: { 0x080, 0x0A0, L } | s: 0x00
    db $8A, $0E, $5B ; SPRITE 5B   | xy: { 0x0E0, 0x0A0, L } | s: 0x00
    db $0B, $0C, $8F ; SPRITE 8F   | xy: { 0x0C0, 0x0B0, U } | s: 0x00
    db $8C, $10, $A6 ; SPRITE A6   | xy: { 0x100, 0x0C0, L } | s: 0x00
    db $8C, $18, $A5 ; SPRITE A5   | xy: { 0x180, 0x0C0, L } | s: 0x00
    db $94, $0E, $80 ; SPRITE 80   | xy: { 0x0E0, 0x140, L } | s: 0x00
    db $15, $1C, $8F ; SPRITE 8F   | xy: { 0x1C0, 0x150, U } | s: 0x00
    db $96, $06, $5B ; SPRITE 5B   | xy: { 0x060, 0x160, L } | s: 0x00
    db $96, $09, $5B ; SPRITE 5B   | xy: { 0x090, 0x160, L } | s: 0x00
    db $98, $09, $A6 ; SPRITE A6   | xy: { 0x090, 0x180, L } | s: 0x00
    db $16, $1C, $8F ; SPRITE 8F   | xy: { 0x1C0, 0x160, U } | s: 0x00
    db $9C, $07, $D1 ; SPRITE D1   | xy: { 0x070, 0x1C0, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E8FB-$04E914 DATA
RoomData_Sprites_Room00CE:
{
    db $00 ; Unlayered OAM
    db $05, $16, $23 ; SPRITE 23   | xy: { 0x160, 0x050, U } | s: 0x00
    db $05, $19, $23 ; SPRITE 23   | xy: { 0x190, 0x050, U } | s: 0x00
    db $05, $1C, $04 ; SPRITE 04   | xy: { 0x1C0, 0x050, U } | s: 0x00
    db $09, $14, $1C ; SPRITE 1C   | xy: { 0x140, 0x090, U } | s: 0x00
    db $08, $1B, $24 ; SPRITE 24   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $08, $1C, $24 ; SPRITE 24   | xy: { 0x1C0, 0x080, U } | s: 0x00
    db $09, $1B, $24 ; SPRITE 24   | xy: { 0x1B0, 0x090, U } | s: 0x00
    db $09, $1C, $24 ; SPRITE 24   | xy: { 0x1C0, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E915-$04E937 DATA
RoomData_Sprites_Room00D0:
{
    db $00 ; Unlayered OAM
    db $05, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x050, U } | s: 0x00
    db $07, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x070, U } | s: 0x00
    db $07, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x070, U } | s: 0x00
    db $0B, $15, $44 ; SPRITE 44   | xy: { 0x150, 0x0B0, U } | s: 0x00
    db $0C, $09, $6F ; SPRITE 6F   | xy: { 0x090, 0x0C0, U } | s: 0x00
    db $0F, $08, $6F ; SPRITE 6F   | xy: { 0x080, 0x0F0, U } | s: 0x00
    db $10, $63, $41 ; SPRITE 41   | xy: { 0x030, 0x100, U } | s: 0x03
    db $14, $09, $41 ; SPRITE 41   | xy: { 0x090, 0x140, U } | s: 0x00
    db $16, $1B, $44 ; SPRITE 44   | xy: { 0x1B0, 0x160, U } | s: 0x00
    db $19, $06, $6F ; SPRITE 6F   | xy: { 0x060, 0x190, U } | s: 0x00
    db $19, $1A, $44 ; SPRITE 44   | xy: { 0x1A0, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E938-$04E951 DATA
RoomData_Sprites_Room00D1:
{
    db $00 ; Unlayered OAM
    db $06, $14, $61 ; SPRITE 61   | xy: { 0x140, 0x060, U } | s: 0x00
    db $06, $1B, $61 ; SPRITE 61   | xy: { 0x1B0, 0x060, U } | s: 0x00
    db $07, $04, $9B ; SPRITE 9B   | xy: { 0x040, 0x070, U } | s: 0x00
    db $08, $0C, $23 ; SPRITE 23   | xy: { 0x0C0, 0x080, U } | s: 0x00
    db $09, $05, $C6 ; SPRITE C6   | xy: { 0x050, 0x090, U } | s: 0x00
    db $0B, $04, $20 ; SPRITE 20   | xy: { 0x040, 0x0B0, U } | s: 0x00
    db $0B, $0B, $20 ; SPRITE 20   | xy: { 0x0B0, 0x0B0, U } | s: 0x00
    db $0B, $1B, $20 ; SPRITE 20   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E952-$04E971 DATA
RoomData_Sprites_Room00D2:
{
    db $00 ; Unlayered OAM
    db $06, $18, $9B ; SPRITE 9B   | xy: { 0x180, 0x060, U } | s: 0x00
    db $07, $1A, $4E ; SPRITE 4E   | xy: { 0x1A0, 0x070, U } | s: 0x00
    db $08, $13, $9B ; SPRITE 9B   | xy: { 0x130, 0x080, U } | s: 0x00
    db $08, $1C, $9B ; SPRITE 9B   | xy: { 0x1C0, 0x080, U } | s: 0x00
    db $0A, $18, $61 ; SPRITE 61   | xy: { 0x180, 0x0A0, U } | s: 0x00
    db $0C, $16, $4E ; SPRITE 4E   | xy: { 0x160, 0x0C0, U } | s: 0x00
    db $0D, $13, $4E ; SPRITE 4E   | xy: { 0x130, 0x0D0, U } | s: 0x00
    db $10, $13, $9B ; SPRITE 9B   | xy: { 0x130, 0x100, U } | s: 0x00
    db $14, $14, $4E ; SPRITE 4E   | xy: { 0x140, 0x140, U } | s: 0x00
    db $14, $1C, $4E ; SPRITE 4E   | xy: { 0x1C0, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E972-$04E982 DATA
RoomData_Sprites_Room00D5:
{
    db $00 ; Unlayered OAM
    db $09, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x090, U } | s: 0x00
    db $0D, $01, $95 ; SPRITE 95   | xy: { 0x010, 0x0D0, U } | s: 0x00
    db $11, $0E, $96 ; SPRITE 96   | xy: { 0x0E0, 0x110, U } | s: 0x00
    db $15, $01, $95 ; SPRITE 95   | xy: { 0x010, 0x150, U } | s: 0x00
    db $15, $04, $26 ; SPRITE 26   | xy: { 0x040, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E983-$04E98D DATA
RoomData_Sprites_Room00D6:
{
    db $00 ; Unlayered OAM
    db $02, $07, $97 ; SPRITE 97   | xy: { 0x070, 0x020, U } | s: 0x00
    db $16, $03, $C5 ; SPRITE C5   | xy: { 0x030, 0x160, U } | s: 0x00
    db $16, $0C, $C5 ; SPRITE C5   | xy: { 0x0C0, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E98E-$04E9B0 DATA
RoomData_Sprites_Room00D8:
{
    db $00 ; Unlayered OAM
    db $05, $17, $84 ; SPRITE 84   | xy: { 0x170, 0x050, U } | s: 0x00
    db $05, $18, $84 ; SPRITE 84   | xy: { 0x180, 0x050, U } | s: 0x00
    db $09, $17, $4F ; SPRITE 4F   | xy: { 0x170, 0x090, U } | s: 0x00
    db $09, $18, $4F ; SPRITE 4F   | xy: { 0x180, 0x090, U } | s: 0x00
    db $0A, $16, $4F ; SPRITE 4F   | xy: { 0x160, 0x0A0, U } | s: 0x00
    db $0A, $19, $4F ; SPRITE 4F   | xy: { 0x190, 0x0A0, U } | s: 0x00
    db $0B, $16, $4E ; SPRITE 4E   | xy: { 0x160, 0x0B0, U } | s: 0x00
    db $0B, $19, $4E ; SPRITE 4E   | xy: { 0x190, 0x0B0, U } | s: 0x00
    db $14, $17, $84 ; SPRITE 84   | xy: { 0x170, 0x140, U } | s: 0x00
    db $16, $18, $A7 ; SPRITE A7   | xy: { 0x180, 0x160, U } | s: 0x00
    db $1B, $18, $A7 ; SPRITE A7   | xy: { 0x180, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E9B1-$04E9BE DATA
RoomData_Sprites_Room00D9:
{
    db $00 ; Unlayered OAM
    db $14, $EC, $02 ; OVERLORD 02 | xy: { 0x0C0, 0x140, U }
    db $15, $18, $83 ; SPRITE 83   | xy: { 0x180, 0x150, U } | s: 0x00
    db $18, $18, $83 ; SPRITE 83   | xy: { 0x180, 0x180, U } | s: 0x00
    db $1B, $18, $83 ; SPRITE 83   | xy: { 0x180, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E9BF-$04E9C6 DATA
RoomData_Sprites_Room00DA:
{
    db $00 ; Unlayered OAM
    db $18, $07, $15 ; SPRITE 15   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $08, $15 ; SPRITE 15   | xy: { 0x080, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E9C7-$04E9DD DATA
RoomData_Sprites_Room00DB:
{
    db $01 ; Layered OAM
    db $04, $03, $D1 ; SPRITE D1   | xy: { 0x030, 0x040, U } | s: 0x00
    db $8A, $0E, $5B ; SPRITE 5B   | xy: { 0x0E0, 0x0A0, L } | s: 0x00
    db $8B, $17, $A6 ; SPRITE A6   | xy: { 0x170, 0x0B0, L } | s: 0x00
    db $8C, $0F, $A5 ; SPRITE A5   | xy: { 0x0F0, 0x0C0, L } | s: 0x00
    db $10, $0B, $8F ; SPRITE 8F   | xy: { 0x0B0, 0x100, U } | s: 0x00
    db $10, $14, $80 ; SPRITE 80   | xy: { 0x140, 0x100, U } | s: 0x00
    db $95, $0F, $A5 ; SPRITE A5   | xy: { 0x0F0, 0x150, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04E9DE-$04EA00 DATA
RoomData_Sprites_Room00DC:
{
    db $01 ; Layered OAM
    db $8A, $09, $A5 ; SPRITE A5   | xy: { 0x090, 0x0A0, L } | s: 0x00
    db $8A, $0E, $5C ; SPRITE 5C   | xy: { 0x0E0, 0x0A0, L } | s: 0x00
    db $8C, $0F, $A6 ; SPRITE A6   | xy: { 0x0F0, 0x0C0, L } | s: 0x00
    db $10, $0B, $8F ; SPRITE 8F   | xy: { 0x0B0, 0x100, U } | s: 0x00
    db $10, $16, $8F ; SPRITE 8F   | xy: { 0x160, 0x100, U } | s: 0x00
    db $96, $0C, $D1 ; SPRITE D1   | xy: { 0x0C0, 0x160, L } | s: 0x00
    db $96, $0F, $A6 ; SPRITE A6   | xy: { 0x0F0, 0x160, L } | s: 0x00
    db $97, $09, $A5 ; SPRITE A5   | xy: { 0x090, 0x170, L } | s: 0x00
    db $97, $16, $80 ; SPRITE 80   | xy: { 0x160, 0x170, L } | s: 0x00
    db $1C, $05, $80 ; SPRITE 80   | xy: { 0x050, 0x1C0, U } | s: 0x00
    db $1C, $0F, $8F ; SPRITE 8F   | xy: { 0x0F0, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA01-$04EA0B DATA
RoomData_Sprites_Room00DE:
{
    db $00 ; Unlayered OAM
    db $05, $17, $A3 ; SPRITE A3   | xy: { 0x170, 0x050, U } | s: 0x00
    db $05, $17, $A4 ; SPRITE A4   | xy: { 0x170, 0x050, U } | s: 0x00
    db $05, $17, $A2 ; SPRITE A2   | xy: { 0x170, 0x050, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA0C-$04EA13 DATA
RoomData_Sprites_Room00DF:
{
    db $00 ; Unlayered OAM
    db $95, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x150, L } | s: 0x00
    db $96, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x160, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA14-$04EA21 DATA
RoomData_Sprites_Room00E0:
{
    db $00 ; Unlayered OAM
    db $06, $04, $6A ; SPRITE 6A   | xy: { 0x040, 0x060, U } | s: 0x00
    db $06, $0B, $6A ; SPRITE 6A   | xy: { 0x0B0, 0x060, U } | s: 0x00
    db $06, $1A, $44 ; SPRITE 44   | xy: { 0x1A0, 0x060, U } | s: 0x00
    db $09, $1A, $44 ; SPRITE 44   | xy: { 0x1A0, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA22-$04EA29 DATA
RoomData_Sprites_Room00E1:
{
    db $00 ; Unlayered OAM
    db $0D, $17, $EB ; SPRITE EB   | xy: { 0x170, 0x0D0, U } | s: 0x00
    db $92, $07, $29 ; SPRITE 29   | xy: { 0x070, 0x120, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA2A-$04EA3A DATA
RoomData_Sprites_Room00E2:
{
    db $00 ; Unlayered OAM
    db $06, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x060, U } | s: 0x00
    db $06, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x060, U } | s: 0x00
    db $07, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x070, U } | s: 0x00
    db $07, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x070, U } | s: 0x00
    db $10, $13, $EB ; SPRITE EB   | xy: { 0x130, 0x100, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA3B-$04EA3F DATA
RoomData_Sprites_Room00E3:
{
    db $00 ; Unlayered OAM
    db $85, $17, $3A ; SPRITE 3A   | xy: { 0x170, 0x050, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA40-$04EA4D DATA
RoomData_Sprites_Room00E4:
{
    db $00 ; Unlayered OAM
    db $07, $19, $6F ; SPRITE 6F   | xy: { 0x190, 0x070, U } | s: 0x00
    db $08, $18, $6F ; SPRITE 6F   | xy: { 0x180, 0x080, U } | s: 0x00
    db $09, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x090, U } | s: 0x00
    db $16, $06, $AD ; SPRITE AD   | xy: { 0x060, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA4E-$04EA61 DATA
RoomData_Sprites_Room00E5:
{
    db $00 ; Unlayered OAM
    db $09, $0F, $6F ; SPRITE 6F   | xy: { 0x0F0, 0x090, U } | s: 0x00
    db $09, $10, $6F ; SPRITE 6F   | xy: { 0x100, 0x090, U } | s: 0x00
    db $09, $11, $6F ; SPRITE 6F   | xy: { 0x110, 0x090, U } | s: 0x00
    db $0E, $1B, $6F ; SPRITE 6F   | xy: { 0x1B0, 0x0E0, U } | s: 0x00
    db $12, $0F, $6F ; SPRITE 6F   | xy: { 0x0F0, 0x120, U } | s: 0x00
    db $12, $11, $6F ; SPRITE 6F   | xy: { 0x110, 0x120, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA62-$04EA72 DATA
RoomData_Sprites_Room00E6:
{
    db $00 ; Unlayered OAM
    db $0B, $1B, $6F ; SPRITE 6F   | xy: { 0x1B0, 0x0B0, U } | s: 0x00
    db $0F, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x0F0, U } | s: 0x00
    db $13, $13, $6F ; SPRITE 6F   | xy: { 0x130, 0x130, U } | s: 0x00
    db $17, $0F, $6F ; SPRITE 6F   | xy: { 0x0F0, 0x170, U } | s: 0x00
    db $1B, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA73-$04EA89 DATA
RoomData_Sprites_Room00E7:
{
    db $00 ; Unlayered OAM
    db $04, $10, $6F ; SPRITE 6F   | xy: { 0x100, 0x040, U } | s: 0x00
    db $04, $13, $6F ; SPRITE 6F   | xy: { 0x130, 0x040, U } | s: 0x00
    db $0B, $15, $6F ; SPRITE 6F   | xy: { 0x150, 0x0B0, U } | s: 0x00
    db $0C, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x0C0, U } | s: 0x00
    db $0D, $0B, $6F ; SPRITE 6F   | xy: { 0x0B0, 0x0D0, U } | s: 0x00
    db $0D, $15, $6F ; SPRITE 6F   | xy: { 0x150, 0x0D0, U } | s: 0x00
    db $0F, $15, $6F ; SPRITE 6F   | xy: { 0x150, 0x0F0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA8A-$04EA97 DATA
RoomData_Sprites_Room00E8:
{
    db $00 ; Unlayered OAM
    db $05, $07, $26 ; SPRITE 26   | xy: { 0x070, 0x050, U } | s: 0x00
    db $08, $17, $26 ; SPRITE 26   | xy: { 0x170, 0x080, U } | s: 0x00
    db $0C, $07, $26 ; SPRITE 26   | xy: { 0x070, 0x0C0, U } | s: 0x00
    db $0C, $19, $26 ; SPRITE 26   | xy: { 0x190, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA98-$04EA9C DATA
RoomData_Sprites_Room00EA:
{
    db $00 ; Unlayered OAM
    db $0B, $0B, $EB ; SPRITE EB   | xy: { 0x0B0, 0x0B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EA9D-$04EAA1 DATA
RoomData_Sprites_Room00EB:
{
    db $00 ; Unlayered OAM
    db $14, $17, $93 ; SPRITE 93   | xy: { 0x170, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EAA2-$04EAB2 DATA
RoomData_Sprites_Room00EE:
{
    db $00 ; Unlayered OAM
    db $04, $10, $18 ; SPRITE 18   | xy: { 0x100, 0x040, U } | s: 0x00
    db $0E, $0B, $18 ; SPRITE 18   | xy: { 0x0B0, 0x0E0, U } | s: 0x00
    db $1C, $09, $18 ; SPRITE 18   | xy: { 0x090, 0x1C0, U } | s: 0x00
    db $0B, $03, $24 ; SPRITE 24   | xy: { 0x030, 0x0B0, U } | s: 0x00
    db $0C, $1C, $24 ; SPRITE 24   | xy: { 0x1C0, 0x0C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EAB3-$04EAC0 DATA
RoomData_Sprites_Room00EF:
{
    db $00 ; Unlayered OAM
    db $09, $17, $18 ; SPRITE 18   | xy: { 0x170, 0x090, U } | s: 0x00
    db $0A, $14, $18 ; SPRITE 18   | xy: { 0x140, 0x0A0, U } | s: 0x00
    db $0A, $1B, $18 ; SPRITE 18   | xy: { 0x1B0, 0x0A0, U } | s: 0x00
    db $06, $18, $1E ; SPRITE 1E   | xy: { 0x180, 0x060, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EAC1-$04EAE0 DATA
RoomData_Sprites_Room00F0:
{
    db $00 ; Unlayered OAM
    db $03, $09, $6F ; SPRITE 6F   | xy: { 0x090, 0x030, U } | s: 0x00
    db $03, $10, $6F ; SPRITE 6F   | xy: { 0x100, 0x030, U } | s: 0x00
    db $04, $08, $6F ; SPRITE 6F   | xy: { 0x080, 0x040, U } | s: 0x00
    db $04, $0A, $6F ; SPRITE 6F   | xy: { 0x0A0, 0x040, U } | s: 0x00
    db $07, $09, $6F ; SPRITE 6F   | xy: { 0x090, 0x070, U } | s: 0x00
    db $0A, $03, $6F ; SPRITE 6F   | xy: { 0x030, 0x0A0, U } | s: 0x00
    db $0A, $05, $6F ; SPRITE 6F   | xy: { 0x050, 0x0A0, U } | s: 0x00
    db $0C, $0E, $6F ; SPRITE 6F   | xy: { 0x0E0, 0x0C0, U } | s: 0x00
    db $10, $1B, $AD ; SPRITE AD   | xy: { 0x1B0, 0x100, U } | s: 0x00
    db $13, $13, $6F ; SPRITE 6F   | xy: { 0x130, 0x130, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EAE1-$04EB00 DATA
RoomData_Sprites_Room00F1:
{
    db $00 ; Unlayered OAM
    db $10, $19, $6F ; SPRITE 6F   | xy: { 0x190, 0x100, U } | s: 0x00
    db $10, $1C, $6F ; SPRITE 6F   | xy: { 0x1C0, 0x100, U } | s: 0x00
    db $11, $18, $6F ; SPRITE 6F   | xy: { 0x180, 0x110, U } | s: 0x00
    db $11, $1D, $6F ; SPRITE 6F   | xy: { 0x1D0, 0x110, U } | s: 0x00
    db $12, $17, $6F ; SPRITE 6F   | xy: { 0x170, 0x120, U } | s: 0x00
    db $12, $1E, $6F ; SPRITE 6F   | xy: { 0x1E0, 0x120, U } | s: 0x00
    db $1B, $06, $6F ; SPRITE 6F   | xy: { 0x060, 0x1B0, U } | s: 0x00
    db $1B, $09, $6F ; SPRITE 6F   | xy: { 0x090, 0x1B0, U } | s: 0x00
    db $1C, $07, $6F ; SPRITE 6F   | xy: { 0x070, 0x1C0, U } | s: 0x00
    db $1C, $08, $6F ; SPRITE 6F   | xy: { 0x080, 0x1C0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB01-$04EB05 DATA
RoomData_Sprites_Room00F3:
{
    db $00 ; Unlayered OAM
    db $14, $06, $78 ; SPRITE 78   | xy: { 0x060, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB06-$04EB0A DATA
RoomData_Sprites_Room00F4:
{
    db $00 ; Unlayered OAM
    db $14, $17, $32 ; SPRITE 32   | xy: { 0x170, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB0B-$04EB0F DATA
RoomData_Sprites_Room00F5:
{
    db $00 ; Unlayered OAM
    db $14, $08, $32 ; SPRITE 32   | xy: { 0x080, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB10-$04EB1D DATA
RoomData_Sprites_Room00F9:
{
    db $00 ; Unlayered OAM
    db $05, $1A, $18 ; SPRITE 18   | xy: { 0x1A0, 0x050, U } | s: 0x00
    db $0F, $15, $18 ; SPRITE 18   | xy: { 0x150, 0x0F0, U } | s: 0x00
    db $13, $11, $18 ; SPRITE 18   | xy: { 0x110, 0x130, U } | s: 0x00
    db $17, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB1E-$04EB28 DATA
RoomData_Sprites_Room00FA:
{
    db $00 ; Unlayered OAM
    db $0E, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x0E0, U } | s: 0x00
    db $10, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x100, U } | s: 0x00
    db $11, $15, $E3 ; SPRITE E3   | xy: { 0x150, 0x110, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB29-$04EB33 DATA
RoomData_Sprites_Room00FB:
{
    db $00 ; Unlayered OAM
    db $0D, $17, $93 ; SPRITE 93   | xy: { 0x170, 0x0D0, U } | s: 0x00
    db $0A, $19, $26 ; SPRITE 26   | xy: { 0x190, 0x0A0, U } | s: 0x00
    db $12, $15, $26 ; SPRITE 26   | xy: { 0x150, 0x120, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB34-$04EB35 DATA
RoomData_Sprites_Room00FC:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04EB36-$04EB46 DATA
RoomData_Sprites_Room00FD:
{
    db $00 ; Unlayered OAM
    db $0E, $09, $18 ; SPRITE 18   | xy: { 0x090, 0x0E0, U } | s: 0x00
    db $08, $05, $24 ; SPRITE 24   | xy: { 0x050, 0x080, U } | s: 0x00
    db $08, $16, $E3 ; SPRITE E3   | xy: { 0x160, 0x080, U } | s: 0x00
    db $08, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x080, U } | s: 0x00
    db $11, $0F, $24 ; SPRITE 24   | xy: { 0x0F0, 0x110, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB47-$04EB57 DATA
RoomData_Sprites_Room00FE:
{
    db $00 ; Unlayered OAM
    db $12, $16, $18 ; SPRITE 18   | xy: { 0x160, 0x120, U } | s: 0x00
    db $16, $14, $18 ; SPRITE 18   | xy: { 0x140, 0x160, U } | s: 0x00
    db $16, $1A, $18 ; SPRITE 18   | xy: { 0x1A0, 0x160, U } | s: 0x00
    db $12, $18, $24 ; SPRITE 24   | xy: { 0x180, 0x120, U } | s: 0x00
    db $18, $18, $24 ; SPRITE 24   | xy: { 0x180, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB58-$04EB5C DATA
RoomData_Sprites_Room00FF:
{
    db $00 ; Unlayered OAM
    db $04, $07, $BB ; SPRITE BB   | xy: { 0x070, 0x040, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB5D-$04EB61 DATA
RoomData_Sprites_Room0100:
{
    db $00 ; Unlayered OAM
    db $1B, $0B, $BB ; SPRITE BB   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB62-$04EB66 DATA
RoomData_Sprites_Room0101:
{
    db $00 ; Unlayered OAM
    db $13, $08, $33 ; SPRITE 33   | xy: { 0x080, 0x130, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB67-$04EB6B DATA
RoomData_Sprites_Room0102:
{
    db $00 ; Unlayered OAM
    db $18, $03, $1F ; SPRITE 1F   | xy: { 0x030, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB6C-$04EB76 DATA
RoomData_Sprites_Room0103:
{
    db $00 ; Unlayered OAM
    db $15, $06, $BC ; SPRITE BC   | xy: { 0x060, 0x150, U } | s: 0x00
    db $1B, $0A, $29 ; SPRITE 29   | xy: { 0x0A0, 0x1B0, U } | s: 0x00
    db $17, $17, $35 ; SPRITE 35   | xy: { 0x170, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB77-$04EB7B DATA
RoomData_Sprites_Room0104:
{
    db $00 ; Unlayered OAM
    db $17, $1A, $73 ; SPRITE 73   | xy: { 0x1A0, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB7C-$04EB80 DATA
RoomData_Sprites_Room0105:
{
    db $00 ; Unlayered OAM
    db $18, $07, $16 ; SPRITE 16   | xy: { 0x070, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB81-$04EB85 DATA
RoomData_Sprites_Room0106:
{
    db $00 ; Unlayered OAM
    db $1B, $08, $BB ; SPRITE BB   | xy: { 0x080, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB86-$04EB90 DATA
RoomData_Sprites_Room0107:
{
    db $00 ; Unlayered OAM
    db $15, $03, $3B ; SPRITE 3B   | xy: { 0x030, 0x150, U } | s: 0x00
    db $1B, $17, $6D ; SPRITE 6D   | xy: { 0x170, 0x1B0, U } | s: 0x00
    db $1B, $18, $6D ; SPRITE 6D   | xy: { 0x180, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB91-$04EB9E DATA
RoomData_Sprites_Room0108:
{
    db $00 ; Unlayered OAM
    db $16, $09, $0B ; SPRITE 0B   | xy: { 0x090, 0x160, U } | s: 0x00
    db $16, $0C, $0B ; SPRITE 0B   | xy: { 0x0C0, 0x160, U } | s: 0x00
    db $19, $09, $0B ; SPRITE 0B   | xy: { 0x090, 0x190, U } | s: 0x00
    db $1A, $06, $0B ; SPRITE 0B   | xy: { 0x060, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EB9F-$04EBA3 DATA
RoomData_Sprites_Room0109:
{
    db $00 ; Unlayered OAM
    db $1B, $0A, $E9 ; SPRITE E9   | xy: { 0x0A0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBA4-$04EBA8 DATA
RoomData_Sprites_Room010A:
{
    db $00 ; Unlayered OAM
    db $04, $19, $16 ; SPRITE 16   | xy: { 0x190, 0x040, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBA9-$04EBBF DATA
RoomData_Sprites_Room010B:
{
    db $00 ; Unlayered OAM
    db $03, $0F, $06 ; SPRITE 06   | xy: { 0x0F0, 0x030, U } | s: 0x00
    db $06, $ED, $1A ; OVERLORD 1A | xy: { 0x0D0, 0x060, U }
    db $06, $F0, $1A ; OVERLORD 1A | xy: { 0x100, 0x060, U }
    db $07, $F2, $1A ; OVERLORD 1A | xy: { 0x120, 0x070, U }
    db $09, $EF, $1A ; OVERLORD 1A | xy: { 0x0F0, 0x090, U }
    db $03, $12, $04 ; SPRITE 04   | xy: { 0x120, 0x030, U } | s: 0x00
    db $07, $0D, $15 ; SPRITE 15   | xy: { 0x0D0, 0x070, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBC0-$04EBD9 DATA
RoomData_Sprites_Room010C:
{
    db $00 ; Unlayered OAM
    db $07, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x070, U } | s: 0x00
    db $07, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x070, U } | s: 0x00
    db $08, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x080, U } | s: 0x00
    db $08, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x080, U } | s: 0x00
    db $14, $07, $83 ; SPRITE 83   | xy: { 0x070, 0x140, U } | s: 0x00
    db $14, $08, $83 ; SPRITE 83   | xy: { 0x080, 0x140, U } | s: 0x00
    db $14, $0C, $83 ; SPRITE 83   | xy: { 0x0C0, 0x140, U } | s: 0x00
    db $1A, $0C, $83 ; SPRITE 83   | xy: { 0x0C0, 0x1A0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBDA-$04EBE1 DATA
RoomData_Sprites_Room010D:
{
    db $00 ; Unlayered OAM
    db $16, $05, $5B ; SPRITE 5B   | xy: { 0x050, 0x160, U } | s: 0x00
    db $16, $0A, $5C ; SPRITE 5C   | xy: { 0x0A0, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBE2-$04EBE9 DATA
RoomData_Sprites_Room010E:
{
    db $00 ; Unlayered OAM
    db $06, $06, $28 ; SPRITE 28   | xy: { 0x060, 0x060, U } | s: 0x00
    db $06, $18, $28 ; SPRITE 28   | xy: { 0x180, 0x060, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBEA-$04EBEE DATA
RoomData_Sprites_Room010F:
{
    db $00 ; Unlayered OAM
    db $15, $07, $BB ; SPRITE BB   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBEF-$04EBF3 DATA
RoomData_Sprites_Room0110:
{
    db $00 ; Unlayered OAM
    db $15, $07, $BB ; SPRITE BB   | xy: { 0x070, 0x150, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBF4-$04EBF8 DATA
RoomData_Sprites_Room0111:
{
    db $00 ; Unlayered OAM
    db $1B, $0B, $65 ; SPRITE 65   | xy: { 0x0B0, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EBF9-$04EC00 DATA
RoomData_Sprites_Room0112:
{
    db $00 ; Unlayered OAM
    db $0A, $07, $28 ; SPRITE 28   | xy: { 0x070, 0x0A0, U } | s: 0x00
    db $14, $17, $BB ; SPRITE BB   | xy: { 0x170, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC01-$04EC08 DATA
RoomData_Sprites_Room0114:
{
    db $00 ; Unlayered OAM
    db $18, $07, $72 ; SPRITE 72   | xy: { 0x070, 0x180, U } | s: 0x00
    db $14, $19, $28 ; SPRITE 28   | xy: { 0x190, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC09-$04EC1C DATA
RoomData_Sprites_Room0115:
{
    db $00 ; Unlayered OAM
    db $16, $17, $C8 ; SPRITE C8   | xy: { 0x170, 0x160, U } | s: 0x00
    db $07, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x070, U } | s: 0x00
    db $07, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x070, U } | s: 0x00
    db $08, $17, $E3 ; SPRITE E3   | xy: { 0x170, 0x080, U } | s: 0x00
    db $08, $18, $E3 ; SPRITE E3   | xy: { 0x180, 0x080, U } | s: 0x00
    db $09, $07, $72 ; SPRITE 72   | xy: { 0x070, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC1D-$04EC21 DATA
RoomData_Sprites_Room0116:
{
    db $00 ; Unlayered OAM
    db $18, $17, $72 ; SPRITE 72   | xy: { 0x170, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC22-$04EC26 DATA
RoomData_Sprites_Room0118:
{
    db $00 ; Unlayered OAM
    db $1B, $19, $BB ; SPRITE BB   | xy: { 0x190, 0x1B0, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC27-$04EC2B DATA
RoomData_Sprites_Room0119:
{
    db $00 ; Unlayered OAM
    db $18, $0E, $29 ; SPRITE 29   | xy: { 0x0E0, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC2C-$04EC30 DATA
RoomData_Sprites_Room011A:
{
    db $00 ; Unlayered OAM
    db $17, $18, $28 ; SPRITE 28   | xy: { 0x180, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC31-$04EC38 DATA
RoomData_Sprites_Room011B:
{
    db $00 ; Unlayered OAM
    db $09, $18, $EB ; SPRITE EB   | xy: { 0x180, 0x090, U } | s: 0x00
    db $96, $05, $EB ; SPRITE EB   | xy: { 0x050, 0x160, L } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC39-$04EC3D DATA
RoomData_Sprites_Room011C:
{
    db $00 ; Unlayered OAM
    db $19, $09, $B5 ; SPRITE B5   | xy: { 0x090, 0x190, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC3E-$04EC4E DATA
RoomData_Sprites_Room011E:
{
    db $00 ; Unlayered OAM
    db $07, $05, $E3 ; SPRITE E3   | xy: { 0x050, 0x070, U } | s: 0x00
    db $07, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x070, U } | s: 0x00
    db $08, $05, $E3 ; SPRITE E3   | xy: { 0x050, 0x080, U } | s: 0x00
    db $08, $06, $E3 ; SPRITE E3   | xy: { 0x060, 0x080, U } | s: 0x00
    db $16, $18, $BB ; SPRITE BB   | xy: { 0x180, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC4F-$04EC53 DATA
RoomData_Sprites_Room011F:
{
    db $00 ; Unlayered OAM
    db $16, $17, $BB ; SPRITE BB   | xy: { 0x170, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC54-$04EC5E DATA
RoomData_Sprites_Room0120:
{
    db $00 ; Unlayered OAM
    db $07, $17, $B2 ; SPRITE B2   | xy: { 0x170, 0x070, U } | s: 0x00
    db $08, $1B, $E3 ; SPRITE E3   | xy: { 0x1B0, 0x080, U } | s: 0x00
    db $09, $1A, $E3 ; SPRITE E3   | xy: { 0x1A0, 0x090, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC5F-$04EC63 DATA
RoomData_Sprites_Room0121:
{
    db $00 ; Unlayered OAM
    db $17, $04, $1A ; SPRITE 1A   | xy: { 0x040, 0x170, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC64-$04EC6B DATA
RoomData_Sprites_Room0122:
{
    db $00 ; Unlayered OAM
    db $18, $07, $31 ; SPRITE 31   | xy: { 0x070, 0x180, U } | s: 0x00
    db $18, $17, $31 ; SPRITE 31   | xy: { 0x170, 0x180, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC6C-$04EC7C DATA
RoomData_Sprites_Room0123:
{
    db $00 ; Unlayered OAM
    db $16, $03, $18 ; SPRITE 18   | xy: { 0x030, 0x160, U } | s: 0x00
    db $16, $0C, $18 ; SPRITE 18   | xy: { 0x0C0, 0x160, U } | s: 0x00
    db $17, $08, $18 ; SPRITE 18   | xy: { 0x080, 0x170, U } | s: 0x00
    db $1A, $03, $18 ; SPRITE 18   | xy: { 0x030, 0x1A0, U } | s: 0x00
    db $05, $08, $BB ; SPRITE BB   | xy: { 0x080, 0x050, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC7D-$04EC81 DATA
RoomData_Sprites_Room0124:
{
    db $00 ; Unlayered OAM
    db $16, $08, $BB ; SPRITE BB   | xy: { 0x080, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC82-$04EC86 DATA
RoomData_Sprites_Room0125:
{
    db $00 ; Unlayered OAM
    db $16, $08, $BB ; SPRITE BB   | xy: { 0x080, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC87-$04EC97 DATA
RoomData_Sprites_Room0126:
{
    db $00 ; Unlayered OAM
    db $15, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x150, U } | s: 0x00
    db $15, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x150, U } | s: 0x00
    db $16, $07, $E3 ; SPRITE E3   | xy: { 0x070, 0x160, U } | s: 0x00
    db $16, $08, $E3 ; SPRITE E3   | xy: { 0x080, 0x160, U } | s: 0x00
    db $14, $1C, $EB ; SPRITE EB   | xy: { 0x1C0, 0x140, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC98-$04EC9C DATA
RoomData_Sprites_Room0127:
{
    db $00 ; Unlayered OAM
    db $16, $07, $EB ; SPRITE EB   | xy: { 0x070, 0x160, U } | s: 0x00
    db $FF ; END
}

; ==============================================================================

; $04EC9D-$04EC9E DATA
RoomData_Sprites_Empty:
{
    db $00 ; Unlayered OAM
    db $FF ; END
}

; ==============================================================================

; $04EC9F-$04ED9E DATA
SpriteExplode_Execute_OAM_groups:
{
    dw  0,  0 : db $60, $00, $00, $02
    dw  0,  0 : db $60, $00, $00, $02
    dw  0,  0 : db $60, $00, $00, $02
    dw  0,  0 : db $60, $00, $00, $02
    
    dw -5, -5 : db $62, $00, $00, $02
    dw  5, -5 : db $62, $40, $00, $02
    dw -5,  5 : db $62, $80, $00, $02
    dw  5,  5 : db $62, $C0, $00, $02
    
    dw -8, -8 : db $62, $00, $00, $02
    dw  8, -8 : db $62, $40, $00, $02
    dw -8,  8 : db $62, $80, $00, $02
    dw  8,  8 : db $62, $C0, $00, $02
    
    dw -8, -8 : db $64, $00, $00, $02
    dw  8, -8 : db $64, $40, $00, $02
    dw -8,  8 : db $64, $80, $00, $02
    dw  8,  8 : db $64, $C0, $00, $02
    
    dw -8, -8 : db $66, $00, $00, $02
    dw  8, -8 : db $66, $40, $00, $02
    dw -8,  8 : db $66, $80, $00, $02
    dw  8,  8 : db $66, $C0, $00, $02
    
    dw -8, -8 : db $68, $00, $00, $02
    dw  8, -8 : db $68, $00, $00, $02
    dw -8,  8 : db $68, $00, $00, $02
    dw  8,  8 : db $68, $00, $00, $02
    
    dw -8, -8 : db $6A, $00, $00, $02
    dw  8, -8 : db $6A, $40, $00, $02
    dw -8,  8 : db $6A, $80, $00, $02
    dw  8,  8 : db $6A, $C0, $00, $02
    
    dw -8, -8 : db $4E, $00, $00, $02
    dw  8, -8 : db $4E, $40, $00, $02
    dw -8,  8 : db $4E, $80, $00, $02
    dw  8,  8 : db $4E, $C0, $00, $02        
}

; Exploderatin' mode for bosses?
; $04ED9F-$04EDA6 LONG JUMP LOCATION
SpriteExplode_ExecuteLong:
{
    PHB : PHK : PLB
    
    JSR.w SpriteExplode_Execute
    
    PLB
    
    RTL
}

; $04EDA7-$04EDEE LOCAL JUMP LOCATION
SpriteExplode_Execute:
{
    ; 0 = explodes. > 0 = doesn't explode.
    LDA.w $0D90, X : BEQ Explode_VerifyPrizing
        LDA.w $0DF0, X : BNE .draw
            STZ.w $0DD0, X
            
            LDY.b #$0F
            
            .find_other_exploding_sprites_loop
            
                LDA.w $0DD0, Y : CMP.b #$04 : BEQ .found_one
            DEY : BPL .find_other_exploding_sprites_loop
            
            LDY.b #$01 : STY.w $0AAA
            
            JSL.l Sprite_VerifyAllOnScreenDefeated : BCS .found_one
                ; Restore menu functionality. Bit of a \hack, imo.
                STZ.w $0FFC
            
            .found_one
            
            RTS
        
        .draw
        
        LSR : LSR : EOR.b #$07 : STA.b $00
        
        LDA.b #$00 : XBA
        
        LDA.b $00
        
        REP #$20
        
        ASL #5 : ADC.w #Pool_SpriteExplode_Execute_OAM_groups : STA.b $08
        
        SEP #$20
        
        LDA.b #$04
        JSL.l Sprite_DrawMultiple
        
        RTS
}

; ==============================================================================

; $04EDEF-$04EE0E DATA
Pool_Explode_SpawnExplosion:
{
    ; $04EDEF
    .x_offsets_low
    db 0,   4,   8,  12,  -4,  -8, -12,   0
    db 0,   8,  16,  24, -24, -16,  -8,   0
    
    ; $04EDFF
    .x_offsets_high
    db 0,   0,   0,   0,  -1,  -1,  -1,   0
    db 0,   0,   0,   0,  -1,  -1,  -1,   0
}

; ==============================================================================

; $04EE0F-$04EEAC LOCAL JUMP LOCATION
Explode_VerifyPrizing:
{
    ; Force sprite to high priority (to make sure it's visible).
    LDA.b #$02 : STA.w $0F20, X
    
    LDA.w $0DF0, X : CMP.b #$20 : BEQ .check_heart_container_spawn
        JMP.w Explode_SpawnExplosion
    
    .check_heart_container_spawn
    
    ; Kill the sprite.
    STZ.w $0DD0, X
    
    STZ.w $02E4
    
    LDA.b $5B : CMP.b #$02 : BEQ .cant_spawn_heart_container
        JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .cant_spawn_heart_container
            ; Is this sprite Ganon?
            LDY.w $0E20, X : CPY.b #$D6 : BCS .victory_over_ganon
                ; Is it Agahnim?
                CPY.b #$7A : BNE .not_victory_over_agahnim
                    ; So it's Agahnim... what do we do.
                    PHX
                    
                    JSL.l PrepDungeonExit
                    
                    PLX
            
    .cant_spawn_heart_container
    
    JMP.w Explode_SpawnExplosion
    
    .victory_over_ganon
    
    ; Play the victory song (yay you killed Ganon).
    LDA.b #$13 : STA.w $012C
    
    JMP.w Explode_SpawnExplosion
    
    .not_victory_over_agahnim
    
    STY.w $0FB5
    
    LDA.b #$EA
    LDY.b #$0E
    JSL.l Sprite_SpawnDynamically_arbitrary

    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b #$20 : STA.w $0F80, Y
    
    LDA.b $EE : STA.w $0F20, Y
    
    LDA.b #$02
    
    CPY.b #$09 : BEQ .was_giant_moldorm
        LDA.b #$06
    
    .was_giant_moldorm
    
    STA.w $0D90, Y
    
    LDA.b $02 : CLC : ADC.b #$03 : STA.w $0D00, Y
    LDA.b $03 :       ADC.b #$00 : STA.w $0D20, Y
    
    LDA.w $0FB5 : CMP.b #$CE : BNE .wasnt_blind_the_thief
        LDA.b $02 : CLC : ADC.b #$10 : STA.w $0D00, Y
        LDA.b $03 :       ADC.b #$00 : STA.w $0D20, Y
        
        RTS
        
    .wasnt_blind_the_thief
    
    CMP.b #$CB : BNE .wasnt_trinexx
        ; Put the heart container in the middle of the room. Probably done
        ; because Trinexx can go wildly off screen.
        LDA.b #$78 : STA.w $0D10, Y
                     STA.w $0D00, Y
        
        LDA.b $23 : STA.w $0D30, Y
        LDA.b $21 : STA.w $0D20, Y
        
    .wasnt_trinexx
    
    RTS
}
    
; $04EEAD-$04EF55 LOCAL JUMP LOCATION
Explode_SpawnExplosion:
{
    ; BUG: Probably nothing major, but these comparisons seem to assume that
    ; a value from the sprite's main timer has been loaded into A, and that
    ; is clearly not guaranteed if you look at the jump sites.
    CMP.b #$40 : BCC .skip_standard_sprite_proccessing
        CMP.b #$70 : BCS .do_standard_sprite_proccessing
            AND.b #$01 : BNE .skip_standard_sprite_proccessing

        .do_standard_sprite_proccessing
                
        JSL.l SpriteActive_MainLong
        
    .skip_standard_sprite_proccessing
    
    LDA.b #$07 : STA.b $0E
    
    LDA.w $0E20, X : STA.b $0F
    CMP.b #$92 : BNE .not_helmasaur_king
        LSR.b $0E
    
    .not_helmasaur_king
    
    LDA.w $0DF0, X : CMP.b #$C0 : BCC .generate_explosion_SFX_and_sprites
        RTS
    
    .generate_explosion_SFX_and_sprites
    
    PHA
    
    AND.b #$03 : BNE .explosion_SFX_delay
        LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
    
    .explosion_SFX_delay
    
    PLA : AND.b $0E : BNE .anospawn_explosion_sprite
        ; Spawn a moveable statue.
        LDA.b #$1C
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            LDA.b #$0B : STA.w $0AAA
            
            ; And then make it instantly explode.
            LDA.b #$04 : STA.w $0DD0, Y
            
            LDA.b #$03 : STA.w $0E40, Y
            
            LDA.b #$0C : STA.w $0F50, Y
            
            PHX
            
            JSL.l GetRandomInt : AND.b #$07 : TAX
            
            LDA.b $0F : CMP.b #$92 : BNE .use_normal_x_offsets
                TXA : ORA.b #$08 : TAX
            
            .use_normal_x_offsets
            
            LDA.b $00
            CLC : ADC.w Pool_Explode_SpawnExplosion_x_offsets_low, X
            STA.w $0D10, Y

            LDA.b $01
            ADC.w Pool_Explode_SpawnExplosion_x_offsets_high, X
            STA.w $0D30, Y
            
            JSL.l GetRandomInt : AND.b #$07 : TAX
            
            LDA.b $0F : CMP.b #$92 : BNE .use_normal_y_offsets
                TXA : ORA.b #$08 : TAX
            
            .use_normal_y_offsets
            
            LDA.b $02 : CLC : ADC.w Pool_Explode_SpawnExplosion_x_offsets_low, X
            
            PHP
            
            SEC : SBC.b $04 : STA.w $0D00, Y
            
            LDA.b $03 : SBC.b #$00
            
            PLP
            
            ADC.w Pool_Explode_SpawnExplosion_x_offsets_high, X : STA.w $0D20, Y
            
            PLX
            
            LDA.b #$1F : STA.w $0DF0, Y
                         STA.w $0D90, Y
        
        .spawn_failed
    .anospawn_explosion_sprite
    
    RTS
}

; ==============================================================================

; This is what kills sprites other than the boss when a boss is dying.
; $04EF56-$04EF8A LONG JUMP LOCATION
Sprite_SchedulePeersForDeath:
{
    LDY.b #$0F
    
    .next_sprite
    
        ; Ignore comparison with self.
        CPY.w $0FA0 : BEQ .ignore_sprite
            LDA.w $0DD0, Y : BEQ .ignore_sprite
                LDA.w $0CAA, Y : AND.b #$02 : BNE .ignore_sprite
                    ; Check if sprite is Agahnim.
                    LDA.w $0E20, Y : CMP.b #$7A : BEQ .ignore_sprite
                        LDA.b #$06 : STA.w $0DD0, Y
                        LDA.b #$0F : STA.w $0DF0, Y
                        LDA.b #$00 : STA.w $0E60, Y
                                     STA.w $0BE0, Y
                        
                        LDA.b #$03 : STA.w $0E40, Y
        
        .ignore_sprite
    DEY : BPL .next_sprite
    
    RTL
}

; ==============================================================================

; $04EF8B-$04F0CA DATA
Pool_Garnish_ScatterDebris:
{
    ; $04EF8B
    .x_offsets
    dw  0,  8,  0,  8, -2,  9, -1,  9
    dw -4,  9, -1, 10, -6,  9, -1, 12
    dw -7,  9, -2, 13, -9,  9, -3, 14
    dw -4, -4,  9, 15, -3, -3, -3,  9
    dw -4,  4,  6, 10, -1,  4,  6,  7
    dw  0,  2,  4,  7,  1,  1,  5,  7
    dw  0, -2,  8,  9, -1, -6,  9, 10
    dw -2, -7, 12, 11, -3, -9,  4,  6
    
    ; $04F00B
    .y_offsets
    db   0,  0,  8,  8,   0, -1, 10, 10
    db   0, -3, 11,  7,   1, -4, 12,  8
    db   1, -4, 13,  9,   2, -4, 16, 10
    db  14, 14, -4, 11,  16, 16, 16, -1
    db   2, -5,  5,  1,   3, -7,  8,  2
    db   4, -8,  4, 10,  -9,  4,  4, 12
    db -10,  4,  8, 14, -12,  4,  8, 15
    db -15,  3,  8, 17, -17,  1, 18, 15
    
    ; $04F04B
    .chr
    db $58, $58, $58, $58, $58, $58, $58, $58
    db $58, $58, $58, $58, $58, $58, $58, $58
    db $48, $58, $58, $58, $48, $58, $58, $48
    db $48, $48, $58, $48, $48, $48, $48, $48
    db $59, $59, $59, $59, $59, $59, $59, $59
    db $59, $59, $59, $59, $59, $59, $59, $59
    db $59, $59, $59, $59, $59, $59, $59, $59
    db $59, $59, $59, $59, $59, $59, $59, $59
    
    ; $04F08B
    .properties
    db $80, $00, $80, $40, $80, $40, $80, $00
    db $00, $C0, $00, $80, $80, $40, $80, $00
    db $80, $C0, $00, $80, $00, $00, $80, $00
    db $80, $80, $80, $80, $00, $00, $00, $00
    db $40, $40, $40, $00, $40, $40, $40, $00
    db $40, $40, $00, $00, $80, $00, $40, $40
    db $40, $00, $40, $40, $40, $40, $40, $40
    db $40, $40, $00, $00, $40, $00, $00, $00
}

; Special animation 0x16
; $04F0CB-$04F15B JUMP LOCATION
Garnish_ScatterDebris:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.l $7FF9FE, X : STA.b $05
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .BRANCH_ALPHA
        LDA.l $7FF92C, X : CMP.b #$03 : BNE .BRANCH_BETA
            JSR.w ScatterDebris_Draw
        
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    STA.w $0FB5
    
    TAY
    
    LDA.l $7FF90E, X : LSR : LSR : EOR.b #$07 : ASL : ASL
    
    CPY.b #$04 : BEQ .BRANCH_GAMMA
        CPY.b #$02 : BNE .BRANCH_DELTA
            LDY.b $1B : BNE .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    CLC : ADC.b #$20
    
    .BRANCH_DELTA
    
    STA.b $06
    
    LDY.b #$00
    
    PHX
    
    LDX.b #$03
    
    .BRANCH_THETA
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00
        CLC : ADC.w Pool_Garnish_ScatterDebris_x_offsets, X : STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        SEP #$20
        
        PLX
        
        LDA.b $02 : CLC : ADC.w Pool_Garnish_ScatterDebris_y_offsets, X

        INY
        STA.b ($90), Y
        
        LDA.w $0FB5 : BNE .BRANCH_EPSILON
            LDA.b #$4E
            
            BRA .BRANCH_ZETA
            
        .BRANCH_EPSILON
        
        ; Feel I should leave a comment here because of this unusual sequence
        ; of instructions.
        CMP.b #$80 : LDA.w Pool_Garnish_ScatterDebris_chr, X : BCC .BRANCH_ZETA
            LDA.b #$F2
        
        .BRANCH_ZETA
        
        INY
        STA.b ($90), Y

        LDA.w Pool_Garnish_ScatterDebris_properties, X
        INY : ORA.b $05 : STA.b ($90), Y
        
        PHY

        TYA : LSR : LSR : TAY
        LDA.b $0F : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .BRANCH_THETA
    
    PLX
    
    RTS
}

; ==============================================================================

; $04F15C-$04F197 DATA
Pool_ScatterDebris_Draw:
{
    ; $04F15C
    .x_offsets
    dw -8,  8, 16, -5,  8, 15, -1,  7
    dw 11,  1,  3,  8
    
    ; $04F174
    .y_offsets
    db  7,  2, 12,  9,  2, 10, 11,  2
    db 11,  7,  3,  8
    
    ; $04F180
    .chr
    db $E2, $E2, $E2, $E2, $F2, $F2, $F2, $E2
    db $E2, $F2, $E2, $E2
    
    ; $04F18C
    .properties
    db $00, $00, $00, $00, $80, $40, $00, $80
    db $40, $00, $00, $00
}

; Note: Also part of scatter debris.
; $04F198-$04F1F7 LOCAL JUMP LOCATION
ScatterDebris_Draw:
{
    LDA.l $7FF90E, X : CMP.b #$10 : BNE .termination_delay
        LDA.b #$00 : STA.l $7FF800, X
    
    .termination_delay
    
    AND.b #$0F : LSR : LSR : STA.b $06
    
    ASL : ADC.b $06 : STA.b $06
    
    LDY.b #$00
    
    PHX
    
    LDX.b #$02
    
    .next_OAM_entry
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        ASL                   : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_ScatterDebris_Draw_x_offsets, X : STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        SEP #$20
        
        PLX
        
        LDA.b $02 : CLC : ADC Pool_ScatterDebris_Draw_y_offsets, X
        INY
        STA.b ($90), Y

        LDA Pool_ScatterDebris_Draw_chr, X
        INY
        STA.b ($90), Y

        LDA Pool_ScatterDebris_Draw_properties, X
        INY
        ORA.b #$22 : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        
        LDA.b $0F : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================

; $04F1F8-$04F24A LONG JUMP LOCATION
Sprite_SelfTerminate:
{
    ; Erase the sprite if this bit is set.
    LDA.w $0CAA, X : AND.b #$40 : BNE .erase_sprite
        ; Are we in a dungeon? sprites leaving the screen are handled
        ; differently.
        LDA.b $1B : BNE .indoors
    
    .erase_sprite
    
    ; If this flag is set, just kill the sprite?
    STZ.w $0DD0, X
    
    TXA : ASL : TAY
    
    REP #$20
    
    ; Basically the BCS later on is a BEQ in effect, checks if($0BC0, Y ==
    ; 0xFFFF).
    LDA.w $0BC0, Y : STA.b $00
    CMP.w #$FFFF
    
    PHP
    
    LSR #3 : CLC : ADC.w #$EF80 : STA.b $01
    
    PLP
    
    ; Just realized after a second visit to this routine that... invalid
    ; address really means that it has already been killed.
    SEP #$20 : BCS .invalid_address
        ; Use $7F as the bank of the address.
        LDA.b #$7F : STA.b $03
        
        PHX
        
        LDA.b $00 : AND.b #$07 : TAX
        LDA.b [$01] : AND.l SpriteDeathMasks, X : STA.b [$01]
        
        PLX
        
    .invalid_address
    
    LDA.b $1B : BNE .indoors_2
        TXA : ASL : TAY
        LDA.b #$FF : STA.w $0BC0, Y
                     STA.w $0BC1, Y
        
        RTL
    
    .indoors_2
    
    LDA.b #$FF : STA.w $0BC0, X
    
    .indoors
    
    RTL
}

; ==============================================================================

; $04F24B-$04F252 DATA
SpriteDeathMasks:
{
    db $7F, $BF, $DF, $EF, $F7, $FB, $FD, $FE
}

; ==============================================================================

; $04F253-$04F26F NULL
NULL_09F253:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $04F270-$04F28F Jump Table
Module_Death_JumpTable:
{
    dw GameOver_AdvanceImmediately     ; 0x00 - $F2A2
    dw GameOver_InitializeAndFadeMusic ; 0x01 - $F2A4
    dw GameOver_DelayBeforeIris        ; 0x02 - $F33B
    dw GameOver_IrisWipe               ; 0x03 - $F350
    dw Link_SpinAndDie_bounce          ; 0x04 - $F47E
    dw GameOver_SplatAndFade           ; 0x05 - $F3DE
    dw GameOver_LoadGAMEOVR            ; 0x06 - $F458
    dw Animate_GAMEOVER_Letters_bounce ; 0x07 - $F483
    dw Death_ShowSaveOptionsMenu       ; 0x08 - $F488
    dw GameOver_SaveAndOrContinue      ; 0x09 - $F4C1
    dw GameOver_InitializeRevivalFairy ; 0x0A - $F6A4
    dw RevivalFairy_Main_bounce        ; 0x0B - $F6B4
    dw GameOver_RiseALittle            ; 0x0C - $F6B9
    dw GameOver_Restore0D              ; 0x0D - $F71D
    dw GameOver_Restore0E              ; 0x0E - $F735
    dw Death_RestoreScreenPostRevival  ; 0x0F - $F742
}

; Beginning of Module 0x12 - Death Mode
; $04F290-$04F2A1 LONG JUMP LOCATION
Module_Death:
{
    ; $11 index for death module.
    LDA.b $11 : ASL : TAX
    JSR.w (Module_Death_JumpTable, X)
    
    LDA.b $11 : CMP.b #$09 : BEQ .dont_show_player
        JSL.l PlayerOam_Main
    
    .dont_show_player
    
    RTL
}

; ==============================================================================

; $04F2A2-$04F2A3 LOCAL JUMP LOCATION
GameOver_AdvanceImmediately:
{
    INC.b $11
    
    ; Bleeds into the next function.
}
    
; $04F2A4-$04F33A LOCAL JUMP LOCATION
GameOver_InitializeAndFadeMusic:
{
    ; ????
    LDA.w $0130 : STA.l $7EC227
    LDA.w $0131 : STA.l $7EC228
    
    ; FADE VOLUME TO NOTHING
    LDA.b #$F1 : STA.w $012C
    
    ; TURN OFF AMBIENT SOUND EFFECT (RUMBLING, ETC)
    LDA.b #$05 : STA.w $012D
    
    ; NOT SURE OF THE INTERPRETATION OF THIS, THOUGH
    STA.w $0200
    
    ; TURN OFF CAPE ($55), AND TWO OTHER THINGS THAT I DON'T UNDERSTAND
    STZ.w $03F3 : STZ.w $0322 : STZ.b $55
    
    REP #$20
    
    ; CACHE MOSAIC LEVEL SETTINGS IN TEMPORARY VARIABLES
    LDA.l $7EC007 : STA.l $7EC221
    LDA.l $7EC009 : STA.l $7EC223
    
    LDX.b #$00
    
    ; Sets all entries in the auxiliary palette to black. This is presumably
    ; used later for the fade from red to black after Link falls down.
    .blackenAuxiliary
    
        LDA.l $7EC300, X : STA.l $7FDD80, X
        LDA.l $7EC340, X : STA.l $7FDDC0, X
        LDA.l $7EC380, X : STA.l $7FDE00, X
        LDA.l $7EC3C0, X : STA.l $7FDE40, X
        
        LDA.w #$0000 : STA.l $7EC340, X
                       STA.l $7EC380, X
                       STA.l $7EC3C0, X
    INX : INX : CPX.b #$40 : BNE .blackenAuxiliary
    
    STA.l $7EC007
    STA.l $7EC009
    
    STZ.w $011A : STZ.w $011C
    
    LDA.b $99 : STA.l $7EC225
    
    SEP #$20
    
    ; Set a timer for 32 frames.
    LDA.b #$20 : STA.b $C8
    
    STZ.w $04A0
    
    ; Setting $04A0 to 0 turns off the display of the floor level indicator
    ; on bg3.
    JSL.l FloorIndicator
    
    INC.b $16
    
    ; Silences the sound effect on first channel.
    LDA #$05 : STA.w $012D
    
    INC.b $11
    
    RTS
} 

; $04F33B-$04F34F LOCAL JUMP LOCATION
GameOver_DelayBeforeIris:
{
    DEC.b $C8 : BNE .alpha
        ; Initializes "death ancillae" for death mode.
        JSL.l Death_InitializeGameOverLetters
        JSL.l Spotlight_close
        
        LDA.b #$30 : STA.b $98
                     STZ.b $97
        
        INC.b $11
    
    .alpha
    
    RTS
}

; ==============================================================================

; Screen spotlight starts caving in
; $04F350-$04F3DD LOCAL JUMP LOCATION
GameOver_IrisWipe:
{
    JSL.l PaletteFilter_Restore_Strictly_Bg_Subtractive
    
    LDA.l $7EC540 : STA.l $7EC500
    LDA.l $7EC541 : STA.l $7EC501
    
    LDA.b $10 : PHA
    
    JSL.l ConfigureSpotlightTable
    
    PLA : STA.b $10
    
    ; WTF: Shouldn't $11 always be nonzero here? Or does that subroutine
    ; call set it to zero?
    LDA.b $11 : BNE .return
        REP #$20
        
        LDA.w #$0018
        LDX.b #$00
        
        .fill_main_bg_palettes_with_red
        
            STA.l $7EC540, X : STA.l $7EC560, X
            STA.l $7EC580, X : STA.l $7EC5A0, X
            STA.l $7EC5C0, X : STA.l $7EC5E0, X
        INX : INX : CPX.b #$20 : BNE .fill_main_bg_palettes_with_red
        
        STA.l $7EC500 : STA.l $7EC540
        
        SEP #$20
        
        JSL.l ResetSpotlightTable
        
        LDA.b #$20 : STA.b $9C
        LDA.b #$40 : STA.b $9D
        LDA.b #$80 : STA.b $9E
        
        STZ.b $96
        STZ.b $97
        STZ.b $98
        
        LDA.b #$04 : STA.b $11
        
        INC.b $15
        
        LDA.b #$0F : STA.b $13
        
        LDA.b #$14 : STA.b $1C
        
        STZ.b $1D
        
        LDA.b #$20 : STA.b $9A
        LDA.b #$40 : STA.b $C8
        
        LDA.b #$00 : STA.l $7EC007
                     STA.l $7EC009
        
        JSL.l Death_PrepFaint
    
    .return
    
    RTS
}

; ==============================================================================

; Screen fades from red to black
; $04F3DE-$04F457 LOCAL JUMP LOCATION
GameOver_SplatAndFade:
{
    LDA.b $C8 : BNE .delay
        JSL.l PaletteFilter_Restore_Strictly_Bg_Subtractive
        
        LDA.l $7EC540 : STA.l $7EC500
        LDA.l $7EC541 : STA.l $7EC501
        
        LDA.l $7EC009 : CMP.b #$FF : BNE .BRANCH_BETA
            LDA.b #$00 : STA.l $7EC011
                         STA.w $0647
            
            LDA.b #$03 : STA.b $95
            
            LDX.b #$00
            
            LDA.b #$06 : CMP.l $7EF35C : BEQ .hasBottledFairy
                INX
                
                CMP.l $7EF35D : BEQ .hasBottledFairy
                    INX
                    
                    CMP.l $7EF35E : BEQ .hasBottledFairy
                        INX
                        
                        CMP.l $7EF35F : BEQ .hasBottledFairy
                            ; Has no bottled fairy.
                            STZ.w $05FC : STZ.w $05FD
                            
                            LDA.b #$16 : STA.b $17
                                         STA.w $0710
                            
                            INC.b $11
        
        .BRANCH_BETA
        
        RTS
    
    .delay
    
    DEC.b $C8
    
    RTS
    
    .hasBottledFairy
    
    ; Empty that bottle.
    LDA.b #$02 : STA.l $7EF35C, X
    
    ; Switch to a different fricken submode of this module?
    LDA.b #$0C : STA.b $C8
    
    ; Grab a half pack of graphics and expand to 4bpp.
    LDA.b #$0F : STA.w $0AAA
    JSL.l Graphics_LoadChrHalfSlot
    
    STZ.w $0AAA
    
    LDA.b #$0A : STA.b $11
    
    RTS
}

; $04F458-$04F47D LOCAL JUMP LOCATION
GameOver_LoadGAMEOVR:
{
    LDA.b #$0C : STA.b $C8

    LDA.b #$0F : STA.w $0AAA
    JSL.l Graphics_LoadChrHalfSlot
    
    STZ.w $0AAA
    
    LDA.b #$05 : STA.w $0AB1
    LDA.b #$02 : STA.w $0AA9
    
    JSL.l Palette_MiscSpr_justSP6
    JSL.l Palette_MainSpr
    
    INC.b $15
    INC.b $11

    ; Bleeds into the next function.
}
    
; Screen turns red, link spins around and falls down.
; $04F47E-$04F482 LOCAL JUMP LOCATION
Link_SpinAndDie_bounce:
{
    JSL.l Death_PlayerSwoon
    
    RTS
}

; $04F483-$04F487 LOCAL JUMP LOCATION
Animate_GAMEOVER_Letters_bounce:
{
    JSL.l Ancilla_GameOverTextLong
    
    RTS
}

; $04F488-$04F4AB LOCAL JUMP LOCATION
Death_ShowSaveOptionsMenu:
{
    JSL.l Ancilla_GameOverTextLong
    
    LDA.b $10 : PHA
    LDA.b $11 : PHA
    
    LDA.b #$02 : STA.w $1CD8
    
    JSL.l Messaging_Text
    
    PLA : INC : STA.b $11
    
    PLA : STA.b $10
    
    LDA.b #$02 : STA.b $C8
    
    ; Play the fountain music?
    LDA.b #$0B : STA.w $012C

    ; $04F4AB ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $04F4AC-$04F4C0 DATA
MaxHealthBasedSpawnHP:
{
    db $18, $18, $18, $18, $18, $20, $20, $28
    db $28, $30, $30, $38, $38, $38, $40, $40
    db $40, $48, $48, $48, $50
}

; ==============================================================================

; Showing the save/quit options
; $04F4C1-$04F50E LOCAL JUMP LOCATION
GameOver_SaveAndOrContinue:
{
    JSR.w GameOver_AnimateChoiceFairy
    
    LDA.w $0C4A : BEQ .alpha
        JSL.l Ancilla_GameOverTextLong
    
    .alpha
    
    LDA.b $F4 : AND.b #$20 : BNE .selectButtonPressed
        DEC.b $C8 : BNE .BRANCH_GAMMA
            INC.b $C8
            
            LDA.b $F0 : AND.b #$0C : BEQ .BRANCH_GAMMA
                AND.b #$04 : BEQ .BRANCH_DELTA
    
    .selectButtonPressed
    
    INC.b $B0
    LDA.b $B0 : CMP.b #$03 : BMI .BRANCH_EPSILON
        STZ.b $B0
        
        BRA .BRANCH_EPSILON
        
    .BRANCH_DELTA
        
    DEC.b $B0 : BPL .BRANCH_EPSILON
        LDA.b #$02 : STA.b $B0
    
    .BRANCH_EPSILON
    
    LDA.b #$0C : STA.b $C8
    
    LDA.b #$20 : STA.w $012F
    
    .BRANCH_GAMMA
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ Death_ShowSaveOptionsMenu_return
    
        LDA.b #$2C : STA.w $012E

        ; Bleeds into the next function.
}

; $04F50F-$04F674 LOCAL JUMP LOCATION
GameOver_FadeAndRevive:
{
    LDA.b #$F1 : STA.w $012C
        
    LDA.b $1B : BEQ .BRANCH_ZETA
        JSL.l Dungeon_SaveRoomQuadrantData
        
    .BRANCH_ZETA
        
    JSL.l AdjustBunnyLinkStatus
        
    LDA.l $7EF3C5 : CMP.b #$03 : BCS .BRANCH_THETA
        LDA.b #$00 : STA.l $7EF3CA
        
        LDA.l $7EF357 : BNE .BRANCH_THETA
            JSL.l ForceNonBunnyStatus
        
    .BRANCH_THETA
        
    LDA.b $A0 : ORA.b $A1 : BNE .BRANCH_IOTA
        STZ.b $1B
        
    .BRANCH_IOTA
        
    JSL.l ResetSomeThingsAfterDeath
        
    LDA.l $7EF3CC : CMP.b #$06 : BEQ .BRANCH_KAPPA
                    CMP.b #$0D : BEQ .BRANCH_KAPPA
                    CMP.b #$0A : BEQ .BRANCH_KAPPA
        CMP.b #$09 : BNE .BRANCH_LAMBDA

    .BRANCH_KAPPA
        
    LDA.b #$00 : STA.l $7EF3CC
        
    .BRANCH_LAMBDA

    LDA.l $7EF36C : LSR #3 : TAX
    LDA.l MaxHealthBasedSpawnHP, X : STA.l $7EF36D
                                     STA.w $04AA
        
    LDA.w $040C : CMP.b #$FF : BEQ .BRANCH_MU
        CMP.b #$02 : BNE .BRANCH_NU
            LDA.b #$00
        
        .BRANCH_NU
        
        LSR : TAX
        LDA.l $7EF36F : STA.l $7EF37C, X
        
    .BRANCH_MU
        
    JSL.l Sprite_ResetAll
        
    REP #$20
        
    LDA.l $7EF405 : CMP.w #$FFFF : BNE .playerHasDeaths
        LDA.l $7EF403 : INC : STA.l $7EF403
        
    .playerHasDeaths
        
    SEP #$20
        
    INC.w $010A
        
    LDA.b $B0 : CMP.b #$01 : BEQ .handleSram
        LDA.b $1B : BEQ .BRANCH_PI
            LDA.l $7EF3CC : CMP.b #$01 : BEQ .BRANCH_RHO
                LDA.w $040C : CMP.b #$FF : BEQ .BRANCH_SIGMA
                    STZ.w $04AA
                    
                    BRA .BRANCH_RHO
                
                .BRANCH_SIGMA
                
                STZ.w $0132
                STZ.b $1B
        
        .BRANCH_PI
        
        ; Are we in the Dark World?
        LDA.l $7EF3CA : BEQ .BRANCH_RHO
            ; Otherwise, make it so the dungeon room we were last in was
            ; Agahnim's first room.
            LDA.b #$20 : STA.b $A0
                         STZ.b $A1
        
        .BRANCH_RHO
        
        LDA.l $7EF3C5 : BEQ .BRANCH_TAU
            LDA.b $B0 : BNE .BRANCH_UPSILON
                JSL.l Main_SaveGameFile
            
            .BRANCH_UPSILON
            
            LDA #$05 : STA.b $10
            
            STZ.b $11 : STZ.b $14
            
            RTS
            
        .BRANCH_TAU
        
        REP #$20
        
        LDA.l $701FFE : TAX : DEX : DEX
        LDA.l SaveFileCopyOffsets, X : STA.b $00
        
        SEP #$20
        
        STZ.w $010A
        
        JSL.l CopySaveToWRAM
        
        RTS
        
    .handleSram
        
    LDA.l $7EF3C5 : BEQ .dontSave
        JSL.l Main_SaveGameFile
        
    .dontSave
        
    LDA.b #$10 : STA.b $1C
        
    STZ.b $1B
        
    JSL.l InitializeTriforceIntro
        
    STZ.w $04AA : STZ.w $010A : STZ.w $0132
        
    SEI
        
    STZ.w SNES.NMIVHCountJoypadEnable
    STZ.w SNES.HDMAChannelEnable
        
    REP #$30
        
    STZ.b $E0 : STZ.b $E2
    STZ.b $E4 : STZ.b $E6
    STZ.b $E8 : STZ.b $EA
        
    STZ.w $0120 : STZ.w $011E
    STZ.w $0124 : STZ.w $0122
        
    LDX.w #$0000 : TXA
        
    .eraseSramBuffer
        
        STA.l $7EF000, X : STA.l $7EF100, X
        STA.l $7EF200, X : STA.l $7EF300, X
        STA.l $7EF400, X    
    INX : INX : CPX.w #$0100 : BNE .eraseSramBuffer
        
    SEP #$30
        
    STZ.w $0136
        
    LDA.b #$FF : STA.w SNES.APUIOPort0
    JSL.l Sound_LoadOverworldWorldSongBank
        
    LDA #$81 : STA.w SNES.NMIVHCountJoypadEnable
        
    RTS
}

; ==============================================================================

; $04F675-$04F679 DATA
Pool_GameOver_AnimateChoiceFairy:
{
    ; $04F675
    .fairy_char
    db $EA
    db $EC

    ; $04F677
    .fairy_height
    db $7F
    db $8F
    db $9F
}

; $04F67A-$04F6A3 LOCAL JUMP LOCATION
GameOver_AnimateChoiceFairy:
{
    PHB : PHK : PLB
    
    LDX.b $B0
    
    LDA.b #$34 : STA.w $0850
    
    LDA.w Pool_GameOver_AnimateChoiceFairy_fairy_height, X : STA.w $0851
    
    LDA.b $1A : AND.b #$08 : LSR #3 : TAX
    LDA.w Pool_GameOver_AnimateChoiceFairy_fairy_char, X : STA.w $0852
    
    LDA.b #$78 : STA.w $0853
    LDA.b #$02 : STA.w $0A34
    
    PLB
    
    RTS
}

; ==============================================================================

; Fairy Revival stuff
; $04F6A4-$04F6B3 LOCAL
GameOver_InitializeRevivalFairy:
{
    ; Configure some ancillary objects for reviving the player, such
    ; as a fairy and... other stuff?
    JSL.l Ancilla_ConfigureRevivalObjects
    
    ; Restore the player's health by 7 hearts.
    LDA.b #$38 : STA.l $7EF372
    
    INC.b $11
    
    STZ.w $0200
    
    RTS
}

; $04F6B4-$04F6B8 LOCAL JUMP LOCATION
RevivalFairy_Main_bounce:
{
    JSL.l Ancilla_RevivalFairy
    
    RTS
}

; Fairy revival part 2
; $04F6B9-$04F711 LOCAL JUMP LOCATION
GameOver_RiseALittle:
{
    LDA.l $7EF372 : BNE GameOver_RunFairyRefill
        REP #$20
        
        LDX.b #$00
        
        .restore_cached_palettes_loop
        
            ; Mess with the palette.
            LDA.l $7FDD80, X : STA.l $7EC300, X
            LDA.l $7FDDC0, X : STA.l $7EC340, X
            LDA.l $7FDE00, X : STA.l $7EC380, X
            LDA.l $7FDE40, X : STA.l $7EC3C0, X
            
            LDA.w #$0000 : STA.l $7EC540, X
                           STA.l $7EC580, X
                           STA.l $7EC5C0, X
        INX : INX : CPX.b #$40 : BNE .restore_cached_palettes_loop
        
        STA.l $7EC500
        
        LDA.w #$0000 : STA.l $7EC007
        LDA.w #$0002 : STA.l $7EC009
        
        LDA.l $7EC225 : STA.b $99
        
        SEP #$20

        ; Bleeds into the next function.
}
        
; $04F712-$04F713 LOCAL JUMP LOCATION
GameOver_AriseAdvancement:
{  
    INC.b $11

    ; Bleeds into the next function.
}

; $04F714-$04F71C LOCAL JUMP LOCATION
GameOver_RunFairyRefill:
{
    JSL.l Ancilla_RevivalFairy
    JSL.l HUD_RefillLogicLong
    
    RTS
}

; $04F71D-$04F734 LOCAL JUMP LOCATION
GameOver_Restore0D:
{
    LDA.w $020A : BNE GameOver_RunFairyRefill
        LDA #$01 : STA.w $0AAA
        JSL.l Graphics_LoadChrHalfSlot
        
        LDA.l $7EC017
        JSL.l Dungeon_ApproachFixedColor_variable
        
        BRA GameOver_RunFairyRefill
}

; $04F735-$04F741 LOCAL JUMP LOCATION
GameOver_Restore0E:
{
    JSL.l Graphics_LoadChrHalfSlot
    
    LDA.l $7EC212 : STA.b $1D
    
    INC.b $11
    
    RTS
}

; ==============================================================================

; $04F742-$04F79A LOCAL JUMP LOCATION
Death_RestoreScreenPostRevival:
{
    JSL.l PaletteFilter_Restore_Strictly_Bg_Additive
    
    LDA.l $7EC540 : STA.l $7EC500
    LDA.l $7EC541 : STA.l $7EC501
    
    LDA.l $7EC007 : CMP.b #$20 : BNE .not_done
        LDA.b $1B : BNE .indoors
            JSL.l Overworld_SetFixedColorAndScroll
        
        .indoors
        
        LDA.l $7EC212 : STA.b $1D
        
        ; Restore the current module.
        LDA.w $010C : STA.b $10
        
        STZ.b $11
        
        LDA.b #$90 : STA.w $031F
        
        LDA.l $7EC227 : STA.w $012C
        LDA.l $7EC228 : STA.w $012D
        
        REP #$20
        
        LDA.l $7EC221 : STA.l $7EC007
        LDA.l $7EC223 : STA.l $7EC009
        
        SEP #$20
        
    .not_done

    ; $04F79A ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $04F79B-$04F79E Jump Table
Module_Quit_submodules:
{
    dw Quit_IndicateHaltedState
    dw Quit_FadeOut
}

; Beginning of Module 0x17 - Quitting mode (save and quit)
; $04F79F-$04F7AE LONG JUMP LOCATION
Module_Quit:
{
    LDA.b $11 : ASL : TAX
    JSR.w (.submodules, X)
    
    JSL.l Sprite_Main
    JSL.l PlayerOam_Main
    
    RTL
}

; ==============================================================================

; $04F7AF-$04F7B0 LOCAL JUMP LOCATION
Quit_IndicateHaltedState:
{
    INC.b $11

    ; Bleeds into the next function.
}
    
; $04F7B1-$04F7BF LOCAL JUMP LOCATION
Quit_FadeOut:
{
    DEC.b $13 : BNE Death_RestoreScreenPostRevival_return
        ; Once the screen fades out it's time to save game state and restart,
        ; essentially.
        LDA.b #$0F : STA.b $95
        
        LDA.b #$01 : STA.b $B0
        
        JMP.w GameOver_FadeAndRevive
}

; ==============================================================================

; $04F7C0-$04F7DD NULL
NULL_09F7C0:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $04F7DE-$04F81C LONG JUMP LOCATION
Polyhedral_InitThread:
{
    PHP : PHB
    
    REP #$30
    
    PHA : PHX : PHY
    
    LDA.w #$0000 : STA.l $001F00
    LDX.w #$1F00
    LDY.w #$1F02
    
    ; Initialization.
    LDA.w #$00FD
    
    MVN $00, $00
    
    LDA.w #$1F31 : STA.w $1F0A
    
    LDA.w #$000C
    LDX.w #.thread_init_state
    LDY.w #$1F32
    
    MVN $09, $00
    
    PLY : PLX : PLA 
    
    PLB : PLP
    
    RTL
    
    .thread_init_state
    db $09     ; For B register
    dw $1F00   ; For D register
    dw $0000   ; For Y register
    dw $0000   ; For X register
    dw $0000   ; For A register
    db $30     ; Status register at return addres location.
    dl $09F81D ; Return address in helper thread
}
    
; ==============================================================================

; Polyhedral thread entry point.
; $04F81D-$04F83C
Polyhedral_RunThread:
{
    .wait
            ; Loop.
        LDA.b $00 : BEQ .wait
    LDA.b $0C : BNE .wait
    
    JSL.l Polyhedral_EmptyBitMapBuffer
    
    JSR.w Polyhedral_SetShapePointer
    JSR.w Polyhedral_SetRotationMatrix
    JSR.w Polyhedral_OperateRotation
    JSR.w Polyhedral_DrawPolyhedron
    
    STZ.b $00
    
    LDA.b #$FF : STA.b $0C
    
    BRA .wait
}

; $04F83D-$04F863 LOCAL JUMP LOCATION
Polyhedral_SetShapePointer:
{
    REP #$30
    
    LDA.b $02 : AND.w #$00FF : ASL : ADC.w #$0080 : STA.b $08
    
    LDA.w $1F03 : AND.w #$00FF : ASL : STA.b $B0
    
    ; X = ( 0xFF8C + ($1F03 * 6) ).
    ; Note that $1F03 seems to always be 0 or 1.
    ASL : ADC.b $B0 : ADC.w #$FF8C : TAX
    
    LDY.w #$1F3F
    LDA.w #$0005
    
    MVN $09, $09
    
    RTS
}

; $04F864-$04F8FA LOCAL JUMP LOCATION
Polyhedral_SetRotationMatrix:
{
    SEP #$30
    
    LDY.b $04
    LDA.w Polyhedral_SineFunction, Y : STA.b $50
    CMP.b #$80 : SBC.b $50 : EOR.b #$FF : STA.b $51
    
    LDA.w Polyhedral_CosineFunction, Y : STA.b $52
    CMP.b #$80 : SBC.b $52 : EOR.b #$FF : STA.b $53
    
    LDY.b $05
    LDA.w Polyhedral_SineFunction, Y : STA.b $54
    CMP.b #$80 : SBC.b $54 : EOR.b #$FF : STA.b $55
    
    LDA.w Polyhedral_CosineFunction, Y : STA.b $56
    CMP.b #$80 : SBC.b $56 : EOR.b #$FF : STA.b $57
    
    REP #$20
    
    SEI
    
    LDX.b $54 : STX.w SNES.Mode7MatrixA
    LDX.b $55 : STX.w SNES.Mode7MatrixA
    LDX.b $50 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL : ASL : STA.b $58
    
    LDX.b $56 : STX.w SNES.Mode7MatrixA
    LDX.b $57 : STX.w SNES.Mode7MatrixA
    LDX.b $52 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL : ASL : STA.b $5E
    
    LDX.b $56 : STX.w SNES.Mode7MatrixA
    LDX.b $57 : STX.w SNES.Mode7MatrixA
    LDX.b $50 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL : ASL : STA.b $5A
    
    LDX.b $54 : STX.w SNES.Mode7MatrixA
    LDX.b $55 : STX.w SNES.Mode7MatrixA
    LDX.b $52 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL : ASL : STA.b $5C
    
    CLI
    
    RTS
}

; $04F8FB-$04F930
Polyhedral_OperateRotation:
{
    SEP #$30
    
    LDA.b $3F : TAX
    
    ; Y = 3 * $3F.
    ASL : ADC.b $3F : TAY
    
    .alpha
    
        DEX
        
        DEY
        LDA.b ($41), Y : STA.b $47
        
        DEY
        LDA.b ($41), Y : STA.b $46
        
        DEY
        LDA.b ($41), Y : STA.b $45
        
        PHY
        
        REP #$20
        
        JSR.w Polyhedral_RotatePoint
        JSR.w Polyhedral_ProjectPoint
        
        SEP #$20
        
        CLC : LDA.b $06 : ADC.b $48 : STA.b $60, X
        SEC : LDA.b $07 : SBC.b $4A : STA.b $88, X
    PLY : BNE .alpha
    
    RTS
}
    
; $04F931-$04F9D5
Polyhedral_RotatePoint:
{
    LDY.b $56
    
    SEI
    
                STY.w SNES.Mode7MatrixA
    LDY.b $57 : STY.w SNES.Mode7MatrixA
    LDY.b $45 : STY.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultLow
    
    LDY.b $54 : STY.w SNES.Mode7MatrixA
    LDY.b $55 : STY.w SNES.Mode7MatrixA
    LDY.b $47 : STY.w SNES.Mode7MatrixB
    
    SEC : SBC.w SNES.MultResultLow
    
    CLI
    
    STA.b $48
    
    LDY.b $58
    
    SEI
    
                STY.w SNES.Mode7MatrixA
    LDY.b $59 : STY.w SNES.Mode7MatrixA
    LDY.b $45 : STY.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultLow
    
    LDY.b $52 : STY.w SNES.Mode7MatrixA
    LDY.b $53 : STY.w SNES.Mode7MatrixA
    LDY.b $46 : STY.w SNES.Mode7MatrixB
    
    CLC : ADC.w SNES.MultResultLow
    
    LDY.b $5A : STY.w SNES.Mode7MatrixA
    LDY.b $5B : STY.w SNES.Mode7MatrixA
    LDY.b $47 : STY.w SNES.Mode7MatrixB
    
    CLC : ADC.w SNES.MultResultLow
    
    CLI
    
    STA.b $4A
    
    LDY.b $5C
    
    SEI
    
                STY.w SNES.Mode7MatrixA
    LDY.b $5D : STY.w SNES.Mode7MatrixA
    LDY.b $45 : STY.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid
    
    LDY.b $50 : STY.w SNES.Mode7MatrixA
    LDY.b $51 : STY.w SNES.Mode7MatrixA
    LDY.b $46 : STY.w SNES.Mode7MatrixB
    
    SEC : SBC.w SNES.MultResultMid
    
    LDY.b $5E : STY.w SNES.Mode7MatrixA
    LDY.b $5F : STY.w SNES.Mode7MatrixA
    LDY.b $47 : STY.w SNES.Mode7MatrixB
    
    CLC : ADC.w SNES.MultResultMid
    
    ; Note that this combines a CLC with a CLI.
    REP #$05
    
    ADC.b $08 : STA.b $4C
    
    RTS
}

; $04F9D6-$04FA4E
Polyhedral_ProjectPoint:
{
    LDA.b $48 : BPL .alpha
        EOR.w #$FFFF : INC
    
    .alpha
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .gamma
        .beta
        
            LSR.b $B2
            LSR.b $B0
        LSR : BNE .beta
    
    .gamma
    
    SEI
    
    LDA.b $B2 : STA.w SNES.DividendLow
    LDY.b $B0 : STY.w SNES.DivisorB
    
    NOP : NOP
    
    LDA.w #$0000
    
    LDY.b $49
    
    SEC
    
    BMI .delta
        NOP
        
        LDA.w SNES.DivideResultQuotientLow
        
        BRA .epsilon
    
    .delta
    
    SBC.w SNES.DivideResultQuotientLow
    
    .epsilon
    
    CLI
    
    STA.b $48
    
    LDA.b $4A : BPL .zeta
        EOR.w #$FFFF : INC
    
    .zeta
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .iota
        .theta
        
            LSR.b $B2
            LSR.b $B0
        LSR : BNE .theta
    
    .iota
    
    SEI
    
    LDA.b $B2 : STA.w SNES.DividendLow
    LDY.b $B0 : STY.w SNES.DivisorB
    
    NOP : NOP
    
    LDA.w #$0000
    
    LDY.b $4B
    
    SEC
    
    BMI .kappa
        NOP
        
        LDA.w SNES.DivideResultQuotientLow
        
        BRA .lamba
    
    .kappa
    
    SBC.w SNES.DivideResultQuotientLow
    
    .lambda
    
    CLI
    
    STA.b $4A
    
    RTS
}

; $04FA4F-$04FAC9
Polyhedral_DrawPolyhedron:
{
    SEP #$30
    
    LDY.b #$00
    
    .delta
    
        LDA.b ($43), Y : STA.b $4E
        AND.b #$7F     : STA.b $B0
        ASL            : STA.b $C0
        
        INY
        
        LDX.b #$01
        
        .alpha
        
            PHY
            
            LDA.b ($43), Y : TAY
            LDA.w $1F60, Y : STA.b $C0, X
            
            INX
            
            LDA.w $1F88, Y : STA.b $C0, X
            
            INX
            
            PLY : INY
        DEC.b $B0 : BNE .alpha
        
        LDA.b ($43), Y
        
        INY
        
        STA.b $4F
        
        PHY
        
        LDA.b $C0 : CMP.b #$06 : BCC .beta
            JSR.w Polyhedral_CalculateCrossProduct : BMI .gamma
                BEQ .beta
                    JSR.w Polyhedral_SetForegroundColor
                    JSL.l Polyhedral_DrawFace
        
        .beta
        
        PLY
    DEC.b $40 : BNE .delta
    
    RTS
    
    .gamma
    
    LDA.b $4E : BPL .beta
        REP #$20
        
        LDA.b $C0 : AND.w #$00FF : TAY
        
        DEY
        
        LDX.b #$01
        
        LSR : LSR : STA.b $B0
        
        .epsilon
        
            LDA.b $C0, X : PHA
            LDA.w $1FC0, Y : STA.b $C0, X
            PLA : STA.w $1FC0, Y
            
            INX : INX
            
            DEY : DEY
        DEC.b $B0 : BNE .epsilon
        
        SEP #$20
        
        JSR.w Polyhedral_SetBackgroundColor
        JSL.l Polyhedral_DrawFace
        
        JMP.w .beta
}

; $04FACA-$04FAD6 LOCAL JUMP LOCATION
Polyhedral_SetForegroundColor:
{
    LDA.b $01 : BNE Polyhedral_SetFGShadeColor
        LDA.b $4F : AND.b #$07
        JSL.l Polyhedral_SetColorMask
        
        RTS
}

; $04FAD7-$04FAE7
Polyhedral_SetBackgroundColor:
{
    LDA.b $01 : BNE Polyhedral_SetBGShadeColor
        LDA.b $4F : LSR #4 : AND.b #$07
        JSL.l Polyhedral_SetColorMask
        
        RTS
}

; $04FAE8-$04FAF1
Polyhedral_SetBGShadeColor:
{
    REP #$20
    
    LDA.b $B0 : EOR.w #$FFFF : INC
    
    BRA Polyhedral_SetShadeColor
}

; $04FAF2-$04FAF5
Polyhedral_SetFGShadeColor:
{   
    REP #$20
    
    LDA.b $B0
    
    ; Bleeds into the next function.
}

; $04FAF6-$04FB23
Polyhedral_SetShadeColor:
{
    PHA
    
    LDA.w $1F03 : AND.w #$00FF : BEQ .gamma
        LDA.w $1F02 : AND.w #$00FF : LSR #5
    
    .gamma
    
    TAX
    
    PLA
    
    .shift
    
        ASL
    DEX : BPL .shift
    
    SEP #$20
    
    XBA : BNE .delta
        LDA.b #$01
        
        BRA .epsilon
    
    .delta
    
    CMP.b #$08 : BCC .epsilon
        LDA.b #$07
    
    .epsilon
    
    JSL.l Polyhedral_SetColorMask
    
    RTS
}

; $04FB24-$04FB6C
Polyhedral_CalculateCrossProduct:
{
    ; (Set I and C flags)
    SEP #$05
    
    LDA.b $C3 : SBC.b $C1 : STA.w SNES.Mode7MatrixA
    
    LDA.b #$00 : SBC.b #$00 : STA.w SNES.Mode7MatrixA
    
    SEC
    LDA.b $C6 : SBC.b $C4 : STA.w SNES.Mode7MatrixB
    
    ; Apparently it's super important to keep the I flag low
    ; for as little time as possible.
    LDA.w SNES.MultResultLow       : STA.b $B0
    LDA.w SNES.MultResultMid : CLI : STA.b $B1
    
    SEP #$05
    
    LDA.b $C5  : SBC.b $C3  : STA.w SNES.Mode7MatrixA
    LDA.b #$00 : SBC.b #$00 : STA.w SNES.Mode7MatrixA
    
    SEC
    LDA.b $C4 : SBC.b $C2 : STA.w SNES.Mode7MatrixB
    
    REP #$20
    
    SEC
    LDA.b $B0 : SBC.w SNES.MultResultLow : STA.b $B0
    
    SEP #$20
    CLI
    
    RTS
}

; $04FB6D-$04FBAC DATA
Polyhedral_SineFunction:
{
    db $00, $02, $03, $05, $06, $08, $09, $0B
    db $0C, $0E, $10, $11, $13, $14, $16, $17
    db $18, $1A, $1B, $1D, $1E, $20, $21, $22
    db $24, $25, $26, $27, $29, $2A, $2B, $2C
    db $2D, $2E, $2F, $30, $31, $32, $33, $34
    db $35, $36, $37, $38, $38, $39, $3A, $3B
    db $3B, $3C, $3C, $3D, $3D, $3E, $3E, $3E
    db $3F, $3F, $3F, $40, $40, $40, $40, $40
}

; $04FBAD-04FCAC DATA
Polyhedral_CosineFunction:
{
    db $40, $40, $40, $40, $40, $40, $3F, $3F
    db $3F, $3E, $3E, $3E, $3D, $3D, $3C, $3C
    db $3B, $3B, $3A, $39, $38, $38, $37, $36
    db $35, $34, $33, $32, $31, $30, $2F, $2E
    db $2D, $2C, $2B, $2A, $29, $27, $26, $25
    db $24, $22, $21, $20, $1E, $1D, $1B, $1A
    db $18, $17, $16, $14, $13, $11, $10, $0E
    db $0C, $0B, $09, $08, $06, $05, $03, $02
    db $00, $FE, $FD, $FB, $FA, $F8, $F7, $F5
    db $F4, $F2, $F0, $EF, $ED, $EC, $EA, $E9
    db $E8, $E6, $E5, $E3, $E2, $E0, $DF, $DE
    db $DC, $DB, $DA, $D9, $D7, $D6, $D5, $D4
    db $D3, $D2, $D1, $D0, $CF, $CE, $CD, $CC
    db $CB, $CA, $C9, $C8, $C8, $C7, $C6, $C5
    db $C5, $C4, $C4, $C3, $C3, $C2, $C2, $C2
    db $C1, $C1, $C1, $C0, $C0, $C0, $C0, $C0
    db $C0, $C0, $C0, $C0, $C0, $C0, $C1, $C1
    db $C1, $C2, $C2, $C2, $C3, $C3, $C4, $C4
    db $C5, $C5, $C6, $C7, $C8, $C8, $C9, $CA
    db $CB, $CC, $CD, $CE, $CF, $D0, $D1, $D2
    db $D3, $D4, $D5, $D6, $D7, $D9, $DA, $DB
    db $DC, $DE, $DF, $E0, $E2, $E3, $E5, $E6
    db $E8, $E9, $EA, $EC, $ED, $EF, $F0, $F2
    db $F4, $F5, $F7, $F8, $FA, $FB, $FD, $FE
    db $00, $02, $03, $05, $06, $08, $09, $0B
    db $0C, $0E, $10, $11, $13, $14, $16, $17
    db $18, $1A, $1B, $1D, $1E, $20, $21, $22
    db $24, $25, $26, $27, $29, $2A, $2B, $2C
    db $2D, $2E, $2F, $30, $31, $32, $33, $34
    db $35, $36, $37, $38, $38, $39, $3A, $3B
    db $3B, $3C, $3C, $3D, $3D, $3E, $3E, $3E
    db $3F, $3F, $3F, $40, $40, $40, $40, $40
}

; $04FCAD-$04FCAD DATA
NULL_09FCAD:
{
    db $FF
}

; $04FCAE-$04FCC3 LONG JUMP LOCATION
Polyhedral_SetColorMask:
{
    PHP
    
    SEP #$30
    
    ASL : ASL : TAX
    
    REP #$20
    
    LDA.l .mask+0, X : STA.b $B5
    LDA.l .mask+2, X : STA.b $B7
    
    PLP
    
    RTL

    ; Masks for different bitplanes (0 - 3)?
    ; $04FCC4
    .mask
    dd $00000000
    dd $000000FF
    dd $0000FF00
    dd $0000FFFF
    dd $00FF0000
    dd $00FF00FF
    dd $00FFFF00
    dd $00FFFFFF
    dd $FF000000
    dd $FF0000FF
    dd $FF00FF00
    dd $FF00FFFF
    dd $FFFF0000
    dd $FFFF00FF
    dd $FFFFFF00
    dd $FFFFFFFF
}

; $04FD04-$04FD1D LONG JUMP LOCATION
Polyhedral_EmptyBitMapBuffer:
{
    PHP : PHB
    
    REP #$30
    
    LDA.w #$0000 : STA.l $7EE800
    
    LDX.w #$E800
    LDY.w #$E802
    LDA.w #$07FD
    
    MVN $7E, $7E
    
    PLB : PLP
    
    RTL
}

; $04FD1E-$04FDCB LONG JUMP LOCATION
Polyhedral_DrawFace:
{
    PHP : PHB
    
    SEP #$30
    
    LDA.b #$7E : PHA
    
    PLB
    
    LDY.b $C0 : TYX
    LDA.b $C0, X
    
    .alpha
    
            DEX : DEX : BEQ .beta
                ; (<= comparison)
        CMP.b $C0, X : BCC .alpha
    BEQ .alpha
    
    TXY
    
    LDA.b $C0, X
    
    BRA .alpha
    
    .beta
    
    AND.b #$07 : ASL : STA.b $B9
    
    LDA.w $1FC0, Y : AND.b #$38 : BIT.b #$20 : BEQ .gamma
        EOR.b #$24
    
    .gamma
    
    LSR : LSR : ADC.b #$E8 : STA.b $BA
    
    STY.b $E9 : STY.b $F2
    
    LDA.b $C0 : LSR : STA.b $E0
    
    LDA.w $1FC0, Y : STA.b $E2
                     STA.b $EB

    LDA.w $1FBF, Y : STA.b $E1
                     STA.b $EA
    
    JSR.w Polyhedral_SetLeft : BCS .delta
        JSR.w Polyhedral_SetRight : BCC .epsilon
    
    .delta
    
    PLB : PLP
    
    RTL
    
    .epsilon
    
    JSR.w Polyhedral_FillLine
    
    LDA.b $B9 : INC : INC : CMP.b #$10 : BEQ .zeta
        STA.b $B9
        
        BRA .iota
        
    .zeta
    
    LDA.b $BA : INC : INC : BIT.b #$08 : BNE .theta
        EOR.b #$19
    
    .theta
    
    STA.b $BA
    STZ.b $B9
    
    .iota
    
    LDX.b $E2 : CPX.b $E4 : BNE .kappa
        LDX.b $E3 : STX.b $E1
        
        JSR.w Polyhedral_SetLeft : BCS .delta
            LDX.b $E2
    
    .kappa
    
    INX : STX.b $E2
    
    LDX.b $EB : CPX.b $ED : BNE .lambda
        LDX.b $EC : STX.b $EA
        
        JSR.w Polyhedral_SetRight : BCS .delta
            LDX.b $EB
    
    .lambda
    
    INX : STX.b $EB
    
    REP #$21
    
          LDA.b $E5 : ADC.b $E7 : STA.b $E5
    CLC : LDA.b $EE : ADC.b $F0 : STA.b $EE
    
    SEP #$20
    
    BRA .epsilon
}

; $04FDCC-$04FDCE LONG JUMP LOCATION
UNREACHABLE_09FDCC:
{
    PLB : PLP
    
    RTL
}

; $04FDCF-$04FEB3 LOCAL JUMP LOCATION
Polyhedral_FillLine:
{
    LDA.b $E6 : AND.b #$07 : ASL : TAY
    
    LDA.b $EF : AND.b #$07 : ASL : TAX
    
    LDA.b $E6 : AND.b #$38 : STA.b $BC
    
    LDA.b $EF : AND.b #$38 : SEC : SBC.b $BC : BNE .alpha
        REP #$30
        
        LDA.l .Mask_right, X : TYX : AND.l .Mask_left, X : STA.b $B2
        
        LDA.b $EF : AND.w #$0038 : ASL : ASL : ORA.b $B9 : TAY
        LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
        LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
        
        .return
        
        SEP #$30
        
        RTS
    
    .alpha
    
    BCC .return
        LSR #3 : STA.b $FA
                 STZ.b $FB
        
        REP #$30
        
        LDA.l .Mask_right, X : STA.b $B2
        
        TYX
        
        LDA.b $EF : AND.w #$0038 : ASL : ASL : ORA.b $B9 : TAY
        LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
        LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
        
        SEC : TYA : SBC.w #$0020 : TAY
        
        DEC.b $FA : BEQ .beta
            .gamma
            
                LDA.b $B5 : STA.w $0000, Y
                LDA.b $B7 : STA.w $0010, Y
                
                TYA : SBC.w #$0020 : TAY
            DEC.b $FA : BNE .gamma
        
        .beta
        
        LDA.l .Mask_left, X : STA.b $B2
        
        LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
        LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
        
        SEP #$30
        
        RTS

    ; $04FE94
    .Mask_left
    dw $FFFF, $7F7F, $3F3F, $1F1F, $0F0F, $0707, $0303, $0101
    
    ; $04FEA4
    .Mask_right
    dw $8080, $C0C0, $E0E0, $F0F0, $F8F8, $FCFC, $FEFE, $FFFF
}

; $04FEB4-$04FF1D LOCAL JUMP LOCATION
Polyhedral_SetLeft:
{
    .loop
    
        DEC.b $E0 : BPL .alpha
            .gamma
            
            SEC
            
            RTS
            
        .alpha
        
        LDX.b $E9 : DEX : DEX : BNE .beta
            LDX.b $C0
        
        .beta
        
        STA.b $C0, X : CMP.b $E2 : BCC .gamma
            BNE .delta
                LDA.b $BF, X : STA.b $E1
                
                STX.b $E9
    BRA .loop
    
    .delta
    
    STA.b $E4
    
    LDA.b $BF, X : STA.b $E3
    
    STX.b $E9
    
    LDX.b #$00
    
    SBC.b $E1 : BCS .epsilon
        DEX
        
        EOR.b #$FF : INC
    
    .epsilon
    
    SEI
    
                 STA.l SNES.DividendHigh
    LDA.b #$00 : STA.l SNES.DividendLow
    
    SEC : LDA.b $E4 : SBC.b $E2 : STA.l SNES.DivisorB
    
    REP #$20
    
    LDA.b $E0 : AND.w #$FF00 : ORA.w #$0080 : STA.b $E5
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .zeta
        LDA.l SNES.DivideResultQuotientLow
        
        BRA .theta
        
    .zeta
    
    SEC : SBC.l SNES.DivideResultQuotientLow
    
    .theta
    
    CLI
    
    STA.b $E7
    
    SEP #$20
    
    CLC
    
    RTS
}

; $04FF1E-$04FF8B LOCAL JUMP LOCATION
Polyhedral_SetRight:
{
    .loop
    
        DEC.b $E0 : BPL .alpha
            .delta
            
            SEC
            
            RTS
        
        .alpha
        
        LDX.b $F2 : CPX.b $C0 : BNE .beta
            LDX.b #$02
            
            BRA .gamma
        
        .beta
        
        INX : INX
        
        .gamma
        
        LDA.b $C0, X : CMP.b $EB : BCC .delta : BNE .epsilon
            LDA.b $BF, X : STA.b $EA
            
            STX.b $F2
    BRA .loop
    
    .epsilon
    
    STA.b $ED
    
    LDA.b $BF, X : STA.b $EC
    
    STX.b $F2
    
    LDX.b #$00
    
    SEC : SBC.b $EA : BCS .zeta
        DEX
        
        EOR.b #$FF : INC
    
    .zeta
    
    SEI
    
                 STA.l SNES.DividendHigh
    LDA.b #$00 : STA.l SNES.DividendLow
    
    SEC : LDA.b $ED : SBC.b $EB : STA.l SNES.DivisorB
    
    REP #$20
    
    LDA.b $E9 : AND.w #$FF00 : ORA #$0080 : STA.b $EE
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .theta
        LDA.l SNES.DivideResultQuotientLow
        
        BRA .iota
    
    .theta
    
    SEC : SBC.l SNES.DivideResultQuotientLow
    
    .iota
    
    CLI
    
    STA.b $F0
    
    SEP #$20
    
    CLC
    
    RTS
}

; ==============================================================================

; $04FF8C-$04FF97 DATA
PolyhedralPropertyTable:
{
    ; $04FF8C
    .crystal
    db $06 ; Vertices
    db $08 ; Faces
    dw CrystalVertices
    dw CrystalFaces

    ; $04FF92
    .triforce
    db $06 ; Vertices
    db $05 ; Faces
    dw TriforceVertices
    dw TriforceFaces
}

; $04FF98-$04FFA9 DATA
CrystalVertices:
{
    db   0,  65,   0
    db   0, -65,   0
    db   0,   0, -40
    db -40,   0,   0
    db   0,   0,  40
    db  40,   0,   0
}

; $04FFAA-$04FFD1 DATA
CrystalFaces:
{
    db   3,   0,   5,   2,   4
    db   3,   0,   2,   3,   1
    db   3,   0,   3,   4,   2
    db   3,   0,   4,   5,   3

    db   3,   1,   2,   5,   4
    db   3,   1,   3,   2,   1
    db   3,   1,   4,   3,   2
    db   3,   1,   5,   4,   3
}

; $04FFD2-$04FFE3 DATA
TriforceVertices:
{
    db   0,  40,  10
    db  40, -40,  10
    db -40, -40,  10
    db   0,  40, -10
    db -40, -40, -10
    db  40, -40, -10
}

; $04FFE4-04FFFF DATA
TriforceFaces:
{
    db   3,   0,   1,   2,   7
    db   3,   3,   4,   5,   6

    db   4,   0,   3,   5,   1,   5
    db   4,   1,   5,   4,   2,   4
    db   4,   3,   0,   2,   4,   3
}

; ==============================================================================

warnpc $0A8000
