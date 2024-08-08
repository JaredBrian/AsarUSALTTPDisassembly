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
                STZ.b $48 : STZ.b $5E
        
        .checkIfCarryingObject
        
        LDA.w $0308 : BPL .notCarryingAnything
            TXA : INC A : CMP.w $02EC : BEQ .spareObject
                BRA .terminateObject
                    
        .notCarryingAnything
        
        TXA : INC A : CMP.w $02EC : BNE .terminateObject
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
    LDA.l $7EF3CC
    
    CMP.b #$0A : BEQ .kiki
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
    
    TAX : LDA.l $08806F, X
    
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
Pool_GiveRupeeGift:
{
    .gift_amounts
    db 1, 5, 20, 100, 50
}

; This routine handles rupee gift.
; $04AD6C-$04ADC6 LONG JUMP LOCATION
GiveRupeeGift:
{
    PHB : PHK : PLB
    
    LDA.w $0C5E, X
    
    CMP.b #$34 : BEQ .lowSize
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
    
    LDA Pool_GiveRupeeGift_gift_amounts, Y : STA.b $00 : STZ.b $01
    
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
    
        LDA.w $0C4A, X
        
        CMP.b #$2A : BEQ .terminate_object
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
        
        LDA #$03 : STA.w $0DB0, Y : STA.w $0E40, Y
        
        INC A : STA.w $0F50, Y
        
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
    
    .spawn_failed
    
    RTL
}

; ==============================================================================

; $04AE7E-$04AE9F LONG JUMP LOCATION
Sprite_SpawnDummyDeathAnimation:
{
    ; Used for the chicken swarm (has to be, I'm sure of it)
    ; Update: This seems to be used by the contradiction bat.
    
    LDA.b #$0B : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$06 : STA.w $0DD0, Y
        
        LDA.b #$0F : STA.w $0DF0, Y
        
        LDA.b #$14 : JSL.l Sound_SetSfx2PanLong
        
        ; Ensure the spawned death sprite is visible by giving it high priority.
        LDA.b #$02 : STA.w $0F20, Y
    
    .spawn_failed
    
    RTL
}

; ==============================================================================

; $04AEA0-$04AEA7 DATA
Pool_Sprite_SpawnMadBatterBolts:
{
    .x_speeds
    -8, -4,  4,  8
    
    .initial_cycling_states
    0, 17, 34, 51
}

; Note: Only used by the mad batter (naturally).
; $04AEA8-$04AF31 LONG JUMP LOCATION
Sprite_SpawnMadBatterBolts:
{
    JSL.l .attempt_bold_spawn
    JSL.l .attempt_bold_spawn
    JSL.l .attempt_bold_spawn
    
    ; $04AEB4 ALTERNATE ENTRY POINT
    .attempt_bold_spawn
    
    LDA.b #$3A : JSL.l Sprite_SpawnDynamically : BMI .spawnFailed
        LDA.b #$01 : JSL.l Sound_SetSfx3PanLong
        
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01 :       ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$0C : PHP : SEC : SBC.w $0F70, X : STA.w $0D00, Y
        LDA.b $03 :       SBC.b #$00 : PLP :       ADC.b #$00     : STA.w $0D20, Y
        
        LDA.b #$00 : STA.w $0F70, Y
        
        LDA.b #$18 : STA.w $0D40, Y : STA.w $0EB0, Y : STA.w $0BA0, Y
        
        LDA.b #$80 : STA.w $0E40, Y
        
        LDA.b #$03 : STA.w $0E60, Y
        AND.b #$03 : STA.w $0F50, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
        
        LDA.b #$02 : STA.w $0DC0, Y
        
        PHX
        
        LDA.w $0ED0, X : TAX
        
        LDA.l Pool_Sprite_SpawnMadBatterBolt_x_speeds, X : STA.w $0D50, Y
        
        LDA.l Pool_Sprite_SpawnMadBatterBolt_initial_cycling_states, X : STA.w $0E80, Y
        
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
            ; (some sprites have this property set at load and some dynamically).
            LDA.w $0F60, X : AND.b #$40 : BNE .dead
                ; In these cases Dead apparently means offscreen.
                LDA.w $0D10, X : CMP $E2
                LDA.w $0D30, X : SBC.b $E3 : BNE .dead
                    ; In these cases Dead apparently means offscreen.
                    LDA.w $0D00, X : CMP $E8
                    LDA.w $0D20, X : SBC.b $E9 : BNE .dead
                        PLX
                        
                        CLC ; Not all enemies are dead, return false.
                        
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
                
                CLC ; Not all the enemies are dead, it's a failure.
                
                RTL
        
        .dead_2
    DEX : BPL .next_sprite_2
    
    .check_overlords
    
    LDX.b #$07
    
    .next_overlord
    
        ; Now check to see if there are any overlords "alive".
        LDA.w $0B00, X
        
        CMP.b #$14 : BEQ .failure
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
    
    LDA.b #$00 : STA.w $0F20, Y : INC A : STA.w $0BA0, Y
    
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

; $04C023-$04C02E DATA
Pool_SpawnCrazyVillageSoldier:
{
    ; \tcrf (verified)
    ; The inn keeper's data is unused because he's not a snitch, naturally.
    ; Use Pro Action Replay Code 09C04834 to switch the young snitch girl's
    ; soldier spawn data with that of the innkeeper's.
    
    .x_offsets_low
    db $20, $40, $E0
    
    .x_offsets_high
    db $01, $03, $02
    
    .y_offsets_low
    db $00, $B0, $60
    
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

; $04C088-$04C08C DATA
Pool_Overlord_CheckInRangeStatus:
{
    .offsets_low
    db $30, $C0
    
    .offsets_high
    db $01, $FF
    
    .easy_out
    
    RTS
}

; I think this... might terminate overlord sprites on the overworld.
; But we don't realy use them there anyways...
; $04C08D-$04C113 LOCAL JUMP LOCATION
Overlord_CheckInRangeStatus:
{
    LDA.b $1B : BNE Pool_Overlord_CheckInRangeStatus_easy_out
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
        
        TXA : ASL A : TAY
        
        REP #$20
        
        LDA.w $0B48, Y : STA.b $00 : CMP.w #$FFFF : PHP
        
        LSR #3 : CLC : ADC.w #$EF80 : STA.b $01
        
        ; Why it wouldn't participate, I don't really know.
        PLP : SEP #$20 : BCS .not_participating_in_death_buffer
            LDA.b #$7F : STA.b $03
            
            LDA.b $00 : AND.b #$07 : TAY
            
            LDA [$01] : AND.w SpriteDeathMasks, Y : STA [$01]
        
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
    
    ; $04C176 IN ROM; Transfer a lot of sprite data to other places.
    JSR.w Dungeon_CacheTransSprites
    
    ; Make Link drop whatever he's carrying.
    STZ.w $0309 : STZ.w $0308
    
    ; $04C22F IN ROM; Zeroes out and disables a number of memory locations.
    JSL.l Sprite_DisableAll
    
    REP #$20
    
    LDA.w #$FFFF : STA.w $0FBA : STA.w $0FB8
    
    LDX.b #$00
    
    LDA.w $048E
    
    .updateRecentRoomsList
    
        CMP.w $0B80, X : BEQ .alreadyInList
    INX #2 : CPX.b #$07 : BCC .updateRecentRoomsList
    
    LDA.w $0B86 : STA.b $00
    LDA.w $0B84 : STA.w $0B86
    LDA.w $0B82 : STA.w $0B84
    LDA.w $0B80 : STA.w $0B82
    LDA.w $048E : STA.w $0B80
    
    REP #$10
    
    LDA.b $00 : CMP.w #$FFFF : BEQ .nullEntry
        ASL A : TAX
        
        ; Tells the game that next time we enter that room the sprites need
        ; a complete fresh (e.g. if any have gotten killed).
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
Pool_Dungeon_CacheTransSprites:
{
    .easy_out
    RTS
}
    
; $04C176-$04C22E LOCAL JUMP LOCATION
Dungeon_CacheTransSprites:
{
    ; Don't do this routine if we're outside.
    LDA.b $1B : BEQ Pool_Dungeon_CacheTransSprites_easy_out
    
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
                ; Frozen
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
    JMP .nextSprite
    
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
    
    LDA.w $048E : ASL A : TAY
    
    ; (update: Black Magic ended up hooking $04C16E)
    ; $04D62E is the pointer table for the sprite data in each room.
    LDA.w $D62E, Y : STA !dataPtr
    
    ; Load the room index again. Divide by 8. why... I'm not sure.
    LDA.w $048E : LSR #3
    
    SEP #$30
    
    ; Used to offset the high byte of pixel addresses in rooms. (X coord).
    AND.b #$FE : STA.w $0FB1
    
    ; Load the room index yet again.
    ; Used to offset the high byte of pixel addresses in rooms. (Y coord).
    LDA.w $048E : AND.b #$0F : ASL A : STA.w $0FB0
    
    ; Not sure what this does yet...
    LDA (!dataPtr) : STA.w $0FB3
    
    LDA.b #$01 : STA !dataOffset
    
    STZ !spriteSlot
    STZ !spriteSlotHi
    
    .nextSprite
    
        LDY !dataOffset
        
        LDA (!dataPtr), Y : CMP.b #$FF : BEQ .endOfSpriteList
            JSR.w Dungeon_LoadSprite ; $04C327 IN ROM
            
            ; Increment the slot we're saving to. ($0E20, $0E21, ...).
            INC !spriteSlot
            
            INC !dataOffset
            INC !dataOffset
            INC !dataOffset
    
    BRA .nextSprite
    
    .endOfSpriteList
    
    RTS
} 

; ==============================================================================

; $04C2D5-$04C2F4 DATA
Pool_Dungeon_ManuallySetSpriteDeathFlag:
{
    .flags
    dw $0001, $0002, $0004, $0008, $0010, $0020, $0040, $0080
    dw $0100, $0200, $0400, $0800, $1000, $2000, $4000, $8000
}

; $04C2F5-$04C326 LONG JUMP LOCATION
Dungeon_ManuallySetSpriteDeathFlag:
{
    PHB : PHK : PLB
    
    LDA.b $1B : BEQ .return
        LDA.w $0CAA, X : LSR A : BCS .return
            LDA.w $0BC0, X : BMI .return
                STA.b $02
                STZ.b $03
                
                REP #$30
                
                PHX
                
                LDA.w $048E : ASL A : TAX
                
                LDA.b $02 : ASL A : TAY
                
                ; Keep this guy from respawning.
                LDA.l $7FDF80, X
                ORA Pool_Dungeon_ManuallySetSpriteDeathFlag_flags, Y
                STA.l $7FDF80, X
                
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
    !dataPtr      = $00
    !spriteSlot   = $02

    INY #2
    
    ; Examine the sprite type first... Is it a key?
    LDA (!dataPtr), Y : TAX : CPX.b #$E4 : BNE .notKey
        DEY #2
        
        ; Check the key's Y coordinate.
        LDA (!dataPtr), Y : INY #2 : CMP.b #$FE : BEQ .isKey
            ; If it's 16 pixels higher than that, drop a big key.
            CMP.b #$FD : BNE .notOverlord
            
            JSR.w Dungeon_LoadSprite_isKey
            
            ; Set $0CBA to 0x02 (means it's a big key).
            INC.w $0CBA, X 
            
            RTS
        
        ; $04C345 ALTERNATE ENTRY POINT
        .isKey
        
        DEC !spriteSlot
        
        LDX !spriteSlot : LDA.b #$01 : STA.w $0CBA, X
        
        RTS
    
    .notKey
    
    DEY
    
    ; Examine its X coordinate, and go back to the sprite type position.
    ; If X coord < 0xE0, Load the overlord's information into memory.
    LDA (!dataPtr), Y : INY : CMP.b #$E0 : BCC .notOverlord
        JSR.w Dungeon_LoadOverlord ; $04C3E8 IN ROM
        
        ; Since this isn't a normal sprite, we don't want to throw off their
        ; loading mechanism, because the normal sprites are loaded in a linear
        ; order into $0E20, X, while these overlords go to $0B00, X.
        DEC !spriteSlot
        
        RTS
        
    ; Normal sprite, not an overlord.
    .notOverlord
    
    ; Checking for sprites with a special specific property.
    LDA.l $0DB725, X : AND.b #$01 : BNE .notSpawnedYet
        REP #$30
        
        PHY : PHX
        
        ; Load the room index, multiply by 2.
        LDA.w $048E : ASL A : TAX
        
        ; $02 is the current slot in $0E20, X to load into.
        LDA !spriteSlot : ASL A : TAY
        
        ; Apparently information on whether stuff has been loaded is stored for
        ; each room?
        LDA.l $7FDF80, X : AND.w $C2D5, Y
        
        PLX : PLY
        
        CMP.w #$0000 : SEP #$30 : BEQ .notSpawnedYet
            ; It spawned, we're done, genius.
            RTS

    .notSpawnedYet

    ; Give X the loading slot number.
    LDX !spriteSlot
    DEY #2
    
    ; Send the sprite an initialization message.
    LDA #$08 : STA.w $0DD0, X
    
    ; Examine the Y coordinate for the sprite. (Buffer at $0FB5).
    LDA (!dataPtr), Y : STA.w $0FB5 
    
    ; Use the MSB of the Y coordinate to determine the floor the sprite is on.
    AND.b #$80 : ASL A : ROL A : STA.w $0F20, X
    
    ; Load the sprite's Y coordinate, multiply by 16 to give it's in-game Y
    ; coordinate. (In terms of pixels).
    LDA ($00), Y : ASL #4 : STA.w $0D00, X
    
    LDA.w $0FB1 : ADC.b #$00 : STA.w $0D20, X
    
    ; Next load the X coordinate, and convert to Pixel coordinates.
    INY
    
    LDA (!dataPtr), Y : STA.w $0FB6 : ASL #4 : STA.w $0D10, X
    
    ; And set the upper byte of the X coordinate, of course.
    LDA.w $0FB0 : ADC.b #$00 : STA.w $0D30, X
    
    ; Looking at the sprite type now.
    INY
    
    ; Set the sprite type.
    LDA (!dataPtr), Y : STA.w $0E20, X
    
    ; Set the subtype to zero.
    STZ.w $0E30, X
    
    ; Examine bits 5 and 6 of the Y (block) coordinate.
    LDA.w $0FB5 : AND.b #$60 : LSR #2 : STA.w $0FB5
    
    ; Provides the lower three bits of the subtype. But since all three bits
    ; cannot be set for us to be here, it follows only certain subtypes will
    ; arise.
    LDA.w $0FB6 : LSR #5
    
    ; Determine a subtype, if necessary.
    ORA.w $0FB5 : STA.w $0E30, X
    
    ; Store slot information into this array.
    LDA.b $02 : STA.w $0BC0, X
    
    ; Zero out the sprite drop variable (what it drops when killed).
    STZ.w $0CBA, X
    
    RTS
}

; ==============================================================================

; Loads overlord information into a room's memory.
; $04C3E8-$04C44D LOCAL JUMP LOCATION
Dungeon_LoadOverlord:
{
    ; Vars
    !dataPtr      = $00

    LDX.b #$07 ; We're going to cycle through the 8 overlord slots.
    
    .nextSlot
    
        ; Are there any overlords in this slot?
        LDA.w $0B00, X : BEQ .emptySlot
    DEX : BPL .nextSlot
    
    RTS
    
    .emptySlot
    
    ; Fill the overlord slot into $0B00, X
    LDA (!dataPtr), Y : NOP : STA.w $0B00, X
    
    DEY #2
    
    ; Now examine the Y coordinate.
    ; Store it's floor status here.
    LDA (!dataPtr), Y : AND.b #$80 : ASL A : ROL A : STA.w $0B40, X
    
    ; Convert the Y coordinate to a pixel address, and store it here.
    LDA (!dataPtr), Y : ASL #4 : STA.w $0B18, X
    
    LDA.w $0FB1 : ADC.b #$00 : STA.w $0B20, X
    
    INY
    
    ; Now convert the X coordinates to pixels.
    LDA (!dataPtr), Y : ASL #4 : STA.w $0B08, X
    
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

    ; TODO: Check for other references to this entry point and change it to
    ; Sprite_ResetBuffers instead.
    .justBuffers

    ; Bleeds into the next function.
}
    
; $04C452-$04C498 LONG JUMP LOCATION
Sprite_ResetBuffers:
{
    STZ.w $0FDD : STZ.w $0FDC : STZ.w $0FFD
    STZ.w $02F0 : STZ.w $0FC6 : STZ.w $0B6A
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
    
    ; TODO: Check for other references to this entry point and change it to
    ; Sprite_LoadAll_Overworld instead.
    .justLoad

    ; Bleeds into the next function.
}

; $04C49D-$04C4AB LONG JUMP LOCATION
Sprite_LoadAll_Overworld:
{
    PHB : PHK : PLB
    
    JSR.w LoadOverworldSprites
    JSR.w $C55E ; $04C55E IN ROM
    
    PLB
    
    RTL
}

; ==============================================================================

; Loads overworld sprite information into memory ($7FDF80, X is one such array).
; $04C4AC-$04C55D LOCAL JUMP LOCATION
LoadOverworldSprites:
{
    ; Calculate lower bounds for X coordinates in this map.
    LDA.w $040A : AND.b #$07 : ASL A : STZ.w $0FBC : STA.w $0FBD
    
    ; Calculate lower bounds for Y coordinates in this map.
    LDA.w $040A : AND.b #$3F : LSR #2 : AND.b #$0E : STA.w $0FBF : STZ.w $0FBE
    
    LDA.w $040A : TAY
    
    LDX.w OverworldScreenSizeForLoading, Y : STX.w $0FB9 : STZ.w $0FB8 
                                             STX.w $0FBB : STZ.w $0FBA
    
    REP #$30
    
    ; What Overworld area are we in?
    LDA.w $040A : ASL A : TAY
    
    SEP #$20
    
    ; Load the game state variable.
    LDA.l $7EF3C5
    
    CMP.b #$03 : BEQ .secondPart
        CMP.b #$02 : BEQ .firstPart
            ; Load the "Beginning" sprites for the Overworld.
            LDA.w $C881, Y : STA.b $00
            LDA.w $C882, Y
            
            BRA .loadData
        
    .secondPart
    
    ; Load the "Second part" sprites for the Overworld.
    LDA.w $CA21, Y : STA.b $00
    LDA.w $CA22, Y
    
    BRA .loadData
    
    .firstPart
    
    ; Load the "First Part" sprites for the Overworld.
    LDA.w $C901, Y : STA.b $00
    LDA.w $C902, Y
    
    .loadData
    
    STA.b $01
    
    LDY.w #$0000
    
    .nextSprite
    
            ; Read off the sprite information until we reach a #$FF byte.
            LDA ($00), Y : CMP.b #$FF : BEQ .stopLoading
                INY #2
                
                ; Is this a Falling Rocks sprite?
                LDA ($00), Y : DEY #2 : CMP.b #$F4 : BNE .notFallingRocks
                    ; Set a "falling rocks" flag for the area and skip past this
                    ; sprite.
                    INC.w $0FFD
                    
                    INY #3
        BRA .nextSprite
        
        .notFallingRocks ; Anything other than falling rocks.
        
        LDA ($00), Y : PHA : LSR #4 : ASL #2 : STA.b $02 : INY
        
        LDA ($00), Y : LSR #4 : CLC : ADC.b $02 : STA.b $06
        
        PLA : ASL #4 : STA.b $07
        
        ; All this is to tell us where to put the sprite in the sprite map.
        LDA ($00), Y : AND.b #$0F : ORA.b $07 : STA.b $05
        
        ; The sprite / overlord index as stored as one plus it's normal index.
        ; Don't ask me why yet. Load them into what I guess you might call a
        ; sprite map.
        INY : LDA ($00), Y : LDX.b $05 : INC A : STA.l $7FDF80, X
        
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
        
        JSR.w $C5BB ; $04C5BB IN ROM
        
        PLY
        
        ; Move the scanning location right by 16 pixels each loop.
        LDA.b $E2 : CLC : ADC.b #$10 : STA.b $E2
        LDA.b $E3 : ADC.b #$00 : STA.b $E3
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
        JSR.w $C5BB ; $04C5BB IN ROM
        JSR.w $C5FA ; $04C5FA IN ROM
        
        PLB
        
        RTL
    
    .alpha
    
    LDA.w $0FB7 : AND.b #$01 : BNE .beta
        JSR.w $C5BB ; $04C5BB IN ROM
    
    .beta
    
    LDA.w $0FB7 : AND.b #$01 : BEQ .gamma
        JSR.w $C5FA ; $04C5FA IN ROM
    
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
        
            JSR.w $C6F5 ; $04C6F5 IN ROM
            
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
        
            JSR.w $C6F5 ; $04C6F5 IN ROM
            
            REP #$20
            
            ; Each loop, move 16 pixels to the right on the map.
            LDA.b $0E : CLC : ADC.w #$0010 : STA.b $0E
            
            SEP #$20
        DEX : BPL .horizontalLoop
    
    .return
    
    RTS
}

; ==============================================================================

; $04C635-$04C6F4 DATA
OverworldScreenSizeForLoading:
{
    ; $04 = Large area
    ; $02 = Small area
    ; These are mostly known to be map sizes. I think some of these values are
    ; wrong as they do not seem to line up with the areas in the game.

    ; Later note: Area 0x0A and 0x0F are incorrect. ZS overwrites this table as
    ; part of its ability to change which areas are large and when these 2
    ; values are correct it does not break anything in game.

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
            
            XBA : ASL #2 : ORA.b $00 : STA.b $01
            
            ; $00 = $0C & 0xF0
            LDA.b $0C : AND.b #$F0 : STA.b $00
            
            ; $00 |= ($0E >> 4)
            LDA.b $0E : LSR #4 : ORA.b $00 : STA.b $00
            
            PHX
            
            JSR.w $C739 ; $04C739 IN ROM
            
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
    
    LDA [$05] : BEQ .alpha
        REP #$20
        
        LDA.b $00 : LSR #3 : CLC : ADC.w #$EF80 : STA.b $02
        
        SEP #$20
        
        LDA.b #$7F : STA.b $04 ; $07 = $7FEF80 + offset
        
        LDA.b $00 : AND.b #$07 : TAY
        
        LDA [$02] : AND.w Overworld_AliveStatusBits, Y : BNE .alpha
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
    LDA [$05] : CMP.b #$F4 : BCC .normalSprite
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
    
    LDA [$02] : ORA.w Overworld_AliveStatusBits, Y : STA [$02]
    
    PHX
    
    TXA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : STA.w $0BC0, X
    
    SEP #$20
    
    PLX : LDA [$05] : DEC A : STA.w $0E20, X ; Load up a sprite here.
    
    LDA.b #$08 : STA.w $0DD0, X
    
    LDA.b $00 : ASL #4 : STA.w $0D10, X
    
    LDA.b $00 : AND.b #$F0 : STA.w $0D00, X
    LDA.b $01 : AND.b #$03 : STA.w $0D30, X
    
    LDA.b $01 : LSR #2 : STA.w $0D20, X
    
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
    LDA [$02] : ORA.w Overworld_AliveStatusBits, Y : STA [$02]
    
    PHX
    
    TXA : ASL A : TAX
    
    REP #$20
    
    ; Store the offset into $7FDF80 that this overlord uses.
    LDA.b $00 : STA.w $0B48, X
    
    SEP #$20
    
    PLX
    
    ; Overlord's type number = the original data value - 0xF3.
    LDA [$05] : SEC : SBC.b #$F3 : STA.w $0B00, X : PHA
    
    LDA.b $00 : ASL #4
    
    PLY : CPY.b #$01 : BNE .gamma
        CLC : ADC.b #$08
    
    .gamma
    
    STA.w $0B08, X
    
    LDA.b $00 : AND.b #$F0 : STA.w $0B18, X
    LDA.b $01 : AND.b #$03 : STA.w $0B10, X
    
    LDA.b $01 : LSR #2 : STA.w $0B20, X
    
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
    dw Overworld_Sprites_EMPTY      ; 00 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 01 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 02 - Lumberjacks
    dw Overworld_Sprites_EMPTY      ; 03 - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 04 - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 05 - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 06 - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 07 - Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 08 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 09 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 0A - Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0B - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0C - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0D - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0E - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0F - Waterfall of Wishing
    dw Overworld_Sprites_EMPTY      ; 10 - Lost Woods Alcove
    dw Overworld_Sprites_EMPTY      ; 11 - North of Kakariko
    dw Overworld_Sprites_EMPTY      ; 12 - Northwest Pond
    dw Overworld_Sprites_EMPTY      ; 13 - Sanctuary
    dw Overworld_Sprites_EMPTY      ; 14 - Graveyard
    dw Overworld_Sprites_EMPTY      ; 15 - Hylia River Bend
    dw Overworld_Sprites_EMPTY      ; 16 - Potion Shop
    dw Overworld_Sprites_EMPTY      ; 17 - Octorok Pit
    dw Overworld_Sprites_EMPTY      ; 18 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 19 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 1A - Kakariko Orchard
    dw Overworld_Sprites_Screen1B_0 ; 1B - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 1C - Hyrule Castle
    dw Overworld_Sprites_Screen1D_0 ; 1D - Hylia River Peninsula
    dw Overworld_Sprites_EMPTY      ; 1E - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 1F - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 20 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 21 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 22 - Smith's House
    dw Overworld_Sprites_EMPTY      ; 23 - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 24 - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 25 - Boulder Field
    dw Overworld_Sprites_EMPTY      ; 26 - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 27 - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 28 - Racing Game
    dw Overworld_Sprites_EMPTY      ; 29 - South of Kakariko
    dw Overworld_Sprites_EMPTY      ; 2A - Haunted Grove
    dw Overworld_Sprites_Screen2B_0 ; 2B - West of Link's House
    dw Overworld_Sprites_Screen2C_0 ; 2C - Link's House
    dw Overworld_Sprites_EMPTY      ; 2D - Eastern Bridge
    dw Overworld_Sprites_EMPTY      ; 2E - Lake Hylia River Bend
    dw Overworld_Sprites_EMPTY      ; 2F - Eastern Portalway
    dw Overworld_Sprites_EMPTY      ; 30 - Desert
    dw Overworld_Sprites_EMPTY      ; 31 - Desert
    dw Overworld_Sprites_Screen32_0 ; 32 - Haunted Grove Entrance
    dw Overworld_Sprites_EMPTY      ; 33 - Marshlands Portalway
    dw Overworld_Sprites_EMPTY      ; 34 - Marshlands Totems
    dw Overworld_Sprites_EMPTY      ; 35 - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 36 - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 37 - Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 38 - Desert
    dw Overworld_Sprites_EMPTY      ; 39 - Desert
    dw Overworld_Sprites_EMPTY      ; 3A - Desert Pass
    dw Overworld_Sprites_EMPTY      ; 3B - Marshlands Dam Entrance
    dw Overworld_Sprites_EMPTY      ; 3C - Marshlands Ravine
    dw Overworld_Sprites_EMPTY      ; 3D - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 3E - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 3F - Lake Hylia Waterfall

    ; $04C901
    .state_1
    dw Overworld_Sprites_Screen00_1 ; 00 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 01 - Lost Woods
    dw Overworld_Sprites_Screen02_1 ; 02 - Lumberjacks
    dw Overworld_Sprites_Screen03_1 ; 03 - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 04 - West Death Mountain
    dw Overworld_Sprites_Screen05_1 ; 05 - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 06 - East Death Mountain
    dw Overworld_Sprites_Screen07_1 ; 07 - Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 08 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 09 - Lost Woods
    dw Overworld_Sprites_Screen0A_1 ; 0A - Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0B - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0C - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0D - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0E - East Death Mountain
    dw Overworld_Sprites_Screen0F_1 ; 0F - Waterfall of Wishing
    dw Overworld_Sprites_Screen10_1 ; 10 - Lost Woods Alcove
    dw Overworld_Sprites_Screen11_1 ; 11 - North of Kakariko
    dw Overworld_Sprites_Screen12_1 ; 12 - Northwest Pond
    dw Overworld_Sprites_Screen13_1 ; 13 - Sanctuary
    dw Overworld_Sprites_Screen14_1 ; 14 - Graveyard
    dw Overworld_Sprites_Screen15_1 ; 15 - Hylia River Bend
    dw Overworld_Sprites_Screen16_1 ; 16 - Potion Shop
    dw Overworld_Sprites_Screen17_1 ; 17 - Octorok Pit
    dw Overworld_Sprites_Screen18_1 ; 18 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 19 - Kakariko Village
    dw Overworld_Sprites_Screen1A_1 ; 1A - Kakariko Orchard
    dw Overworld_Sprites_Screen1B_1 ; 1B - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 1C - Hyrule Castle
    dw Overworld_Sprites_Screen1D_1 ; 1D - Hylia River Peninsula
    dw Overworld_Sprites_Screen1E_1 ; 1E - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 1F - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 20 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 21 - Kakariko Village
    dw Overworld_Sprites_Screen22_1 ; 22 - Smith's House
    dw Overworld_Sprites_EMPTY      ; 23 - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 24 - Hyrule Castle
    dw Overworld_Sprites_Screen25_1 ; 25 - Boulder Field
    dw Overworld_Sprites_EMPTY      ; 26 - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 27 - Eastern Ruins
    dw Overworld_Sprites_Screen28_1 ; 28 - Racing Game
    dw Overworld_Sprites_EMPTY      ; 29 - South of Kakariko
    dw Overworld_Sprites_Screen2A_1 ; 2A - Haunted Grove
    dw Overworld_Sprites_Screen2B_1 ; 2B - West of Link's House
    dw Overworld_Sprites_Screen2C_1 ; 2C - Link's House
    dw Overworld_Sprites_Screen2D_1 ; 2D - Eastern Bridge
    dw Overworld_Sprites_Screen2E_1 ; 2E - Lake Hylia River Bend
    dw Overworld_Sprites_Screen2F_1 ; 2F - Eastern Portalway
    dw Overworld_Sprites_Screen30_1 ; 30 - Desert
    dw Overworld_Sprites_EMPTY      ; 31 - Desert
    dw Overworld_Sprites_Screen32_1 ; 32 - Haunted Grove Entrance
    dw Overworld_Sprites_Screen33_1 ; 33 - Marshlands Portalway
    dw Overworld_Sprites_Screen34_1 ; 34 - Marshlands Totems
    dw Overworld_Sprites_Screen35_1 ; 35 - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 36 - Lake Hylia
    dw Overworld_Sprites_Screen37_1 ; 37 - Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 38 - Desert
    dw Overworld_Sprites_EMPTY      ; 39 - Desert
    dw Overworld_Sprites_Screen3A_1 ; 3A - Desert Pass
    dw Overworld_Sprites_Screen3B_1 ; 3B - Marshlands Dam Entrance
    dw Overworld_Sprites_Screen3C_1 ; 3C - Marshlands Ravine
    dw Overworld_Sprites_EMPTY      ; 3D - Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 3E - Lake Hylia
    dw Overworld_Sprites_Screen3F_1 ; 3F - Lake Hylia Waterfall
    dw Overworld_Sprites_Screen40   ; 40 - Skull Woods
    dw Overworld_Sprites_Screen42   ; 41 - Skull Woods
    dw Overworld_Sprites_Screen42   ; 42 - Dark Lumberjacks
    dw Overworld_Sprites_Screen43   ; 43 - West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 44 - West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 45 - East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 46 - East Dark Death Mountain
    dw Overworld_Sprites_Screen47   ; 47 - Turtle Rock
    dw Overworld_Sprites_EMPTY      ; 48 - Skull Woods
    dw Overworld_Sprites_EMPTY      ; 49 - Skull Woods
    dw Overworld_Sprites_Screen4A   ; 4A - Bumper Ledge
    dw Overworld_Sprites_EMPTY      ; 4B - West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4C - West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4D - East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4E - East Dark Death Mountain
    dw Overworld_Sprites_Screen4F   ; 4F - Lake of Bad Omens
    dw Overworld_Sprites_Screen50   ; 50 - Skull Woods Alcove
    dw Overworld_Sprites_Screen51   ; 51 - North of Outcasts
    dw Overworld_Sprites_Screen52   ; 52 - Dark Northwest Pond
    dw Overworld_Sprites_Screen53   ; 53 - Dark Sanctuary
    dw Overworld_Sprites_Screen54   ; 54 - Dark Graveyard
    dw Overworld_Sprites_Screen55   ; 55 - Dark Hylia River Bend
    dw Overworld_Sprites_Screen56   ; 56 - Dark Northeast Shop
    dw Overworld_Sprites_Screen57   ; 57 - Dark Octorok Pit
    dw Overworld_Sprites_Screen58   ; 58 - Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 59 - Village of Outcasts
    dw Overworld_Sprites_Screen5A   ; 5A - Outcasts Orchard
    dw Overworld_Sprites_Screen5B   ; 5B - Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 5C - Pyramid of Power
    dw Overworld_Sprites_Screen5D   ; 5D - Dark Hylia River Peninsula
    dw Overworld_Sprites_Screen5E   ; 5E - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 5F - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 60 - Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 61 - Village of Outcasts
    dw Overworld_Sprites_Screen62   ; 62 - Stake Puzzle
    dw Overworld_Sprites_EMPTY      ; 63 - Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 64 - Pyramid of Power
    dw Overworld_Sprites_Screen65   ; 65 - Boulder Field
    dw Overworld_Sprites_EMPTY      ; 66 - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 67 - Palace of Darkness Maze
    dw Overworld_Sprites_Screen68   ; 68 - Digging Game
    dw Overworld_Sprites_Screen69   ; 69 - South of Outcasts
    dw Overworld_Sprites_Screen6A   ; 6A - Stumpy Grove
    dw Overworld_Sprites_Screen6B   ; 6B - West of Bomb Shoppe
    dw Overworld_Sprites_Screen6C   ; 6C - Bomb Shoppe
    dw Overworld_Sprites_Screen6D   ; 6D - Hammer Bridge
    dw Overworld_Sprites_Screen6E   ; 6E - Dark Lake Hylia River Bend
    dw Overworld_Sprites_Screen6F   ; 6F - East Dark World Portalway
    dw Overworld_Sprites_Screen70   ; 70 - Misery Mire
    dw Overworld_Sprites_Screen72   ; 71 - Misery Mire
    dw Overworld_Sprites_Screen72   ; 72 - Stumpy Grove Entrance
    dw Overworld_Sprites_Screen73   ; 73 - Swamplands Portalway
    dw Overworld_Sprites_Screen74   ; 74 - Swamplands Totems
    dw Overworld_Sprites_Screen75   ; 75 - Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 76 - Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 77 - Dark Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 78 - Misery Mire
    dw Overworld_Sprites_EMPTY      ; 79 - Misery Mire
    dw Overworld_Sprites_Screen7A   ; 7A - West of Swamplands
    dw Overworld_Sprites_Screen7B   ; 7B - Swamplands Palace Entrance
    dw Overworld_Sprites_Screen7C   ; 7C - Swamplands Ravine
    dw Overworld_Sprites_EMPTY      ; 7D - Dark Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 7E - Dark Lake Hylia
    dw Overworld_Sprites_Screen7F   ; 7F - Dark Lake Hylia Waterfall
    dw Overworld_Sprites_Screen80   ; 80 - Master Sword Pedestal
    dw Overworld_Sprites_Screen81   ; 81 - Zora's Domain
    dw Overworld_Sprites_EMPTY      ; 82 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 83 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 84 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 85 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 86 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 87 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 88 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 89 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8A - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8B - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8C - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8D - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8E - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8F - Unused SW Area
   
   ; $04CA21
   .state_2
    dw Overworld_Sprites_Screen00_2 ; 00 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 01 - Lost Woods
    dw Overworld_Sprites_Screen02_2 ; 02 - Lumberjacks
    dw Overworld_Sprites_Screen03_2 ; 03 - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 04 - West Death Mountain
    dw Overworld_Sprites_Screen05_2 ; 05 - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 06 - East Death Mountain
    dw Overworld_Sprites_Screen07_2 ; 07 - Turtle Rock Portalway
    dw Overworld_Sprites_EMPTY      ; 08 - Lost Woods
    dw Overworld_Sprites_EMPTY      ; 09 - Lost Woods
    dw Overworld_Sprites_Screen0A_2 ; 0A - Death Mountain Foot
    dw Overworld_Sprites_EMPTY      ; 0B - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0C - West Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0D - East Death Mountain
    dw Overworld_Sprites_EMPTY      ; 0E - East Death Mountain
    dw Overworld_Sprites_Screen0F_2 ; 0F - Waterfall of Wishing
    dw Overworld_Sprites_Screen10_2 ; 10 - Lost Woods Alcove
    dw Overworld_Sprites_Screen11_2 ; 11 - North of Kakariko
    dw Overworld_Sprites_Screen12_2 ; 12 - Northwest Pond
    dw Overworld_Sprites_Screen13_2 ; 13 - Sanctuary
    dw Overworld_Sprites_Screen14_2 ; 14 - Graveyard
    dw Overworld_Sprites_Screen15_2 ; 15 - Hylia River Bend
    dw Overworld_Sprites_Screen16_2 ; 16 - Potion Shop
    dw Overworld_Sprites_Screen17_2 ; 17 - Octorok Pit
    dw Overworld_Sprites_Screen18_2 ; 18 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 19 - Kakariko Village
    dw Overworld_Sprites_Screen1A_2 ; 1A - Kakariko Orchard
    dw Overworld_Sprites_Screen1B_2 ; 1B - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 1C - Hyrule Castle
    dw Overworld_Sprites_Screen1D_2 ; 1D - Hylia River Peninsula
    dw Overworld_Sprites_Screen1E_2 ; 1E - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 1F - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 20 - Kakariko Village
    dw Overworld_Sprites_EMPTY      ; 21 - Kakariko Village
    dw Overworld_Sprites_Screen22_2 ; 22 - Smith's House
    dw Overworld_Sprites_EMPTY      ; 23 - Hyrule Castle
    dw Overworld_Sprites_EMPTY      ; 24 - Hyrule Castle
    dw Overworld_Sprites_Screen25_2 ; 25 - Boulder Field
    dw Overworld_Sprites_EMPTY      ; 26 - Eastern Ruins
    dw Overworld_Sprites_EMPTY      ; 27 - Eastern Ruins
    dw Overworld_Sprites_Screen28_2 ; 28 - Racing Game
    dw Overworld_Sprites_Screen29_2 ; 29 - South of Kakariko
    dw Overworld_Sprites_Screen2A_2 ; 2A - Haunted Grove
    dw Overworld_Sprites_Screen2B_2 ; 2B - West of Link's House
    dw Overworld_Sprites_Screen2C_2 ; 2C - Link's House
    dw Overworld_Sprites_Screen2D_2 ; 2D - Eastern Bridge
    dw Overworld_Sprites_Screen2E_2 ; 2E - Lake Hylia River Bend
    dw Overworld_Sprites_Screen2F_2 ; 2F - Eastern Portalway
    dw Overworld_Sprites_Screen30_2 ; 30 - Desert
    dw Overworld_Sprites_EMPTY      ; 31 - Desert
    dw Overworld_Sprites_Screen32_2 ; 32 - Haunted Grove Entrance
    dw Overworld_Sprites_Screen33_2 ; 33 - Marshlands Portalway
    dw Overworld_Sprites_Screen34_2 ; 34 - Marshlands Totems
    dw Overworld_Sprites_Screen35_2 ; 35 - Lake Hylia
    dw Overworld_Sprites_Screen37_2 ; 36 - Lake Hylia
    dw Overworld_Sprites_Screen37_2 ; 37 - Lake Hylia River End
    dw Overworld_Sprites_Screen3A_2 ; 38 - Desert
    dw Overworld_Sprites_Screen3A_2 ; 39 - Desert
    dw Overworld_Sprites_Screen3A_2 ; 3A - Desert Pass
    dw Overworld_Sprites_Screen3B_2 ; 3B - Marshlands Dam Entrance
    dw Overworld_Sprites_Screen3C_2 ; 3C - Marshlands Ravine
    dw Overworld_Sprites_Screen3F_2 ; 3D - Lake Hylia
    dw Overworld_Sprites_Screen3F_2 ; 3E - Lake Hylia
    dw Overworld_Sprites_Screen3F_2 ; 3F - Lake Hylia Waterfall
    dw Overworld_Sprites_Screen40   ; 40 - Skull Woods
    dw Overworld_Sprites_Screen42   ; 41 - Skull Woods
    dw Overworld_Sprites_Screen42   ; 42 - Dark Lumberjacks
    dw Overworld_Sprites_Screen43   ; 43 - West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 44 - West Dark Death Mountain
    dw Overworld_Sprites_Screen45   ; 45 - East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 46 - East Dark Death Mountain
    dw Overworld_Sprites_Screen47   ; 47 - Turtle Rock
    dw Overworld_Sprites_EMPTY      ; 48 - Skull Woods
    dw Overworld_Sprites_EMPTY      ; 49 - Skull Woods
    dw Overworld_Sprites_Screen4A   ; 4A - Bumper Ledge
    dw Overworld_Sprites_EMPTY      ; 4B - West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4C - West Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4D - East Dark Death Mountain
    dw Overworld_Sprites_EMPTY      ; 4E - East Dark Death Mountain
    dw Overworld_Sprites_Screen4F   ; 4F - Lake of Bad Omens
    dw Overworld_Sprites_Screen50   ; 50 - Skull Woods Alcove
    dw Overworld_Sprites_Screen51   ; 51 - North of Outcasts
    dw Overworld_Sprites_Screen52   ; 52 - Dark Northwest Pond
    dw Overworld_Sprites_Screen53   ; 53 - Dark Sanctuary
    dw Overworld_Sprites_Screen54   ; 54 - Dark Graveyard
    dw Overworld_Sprites_Screen55   ; 55 - Dark Hylia River Bend
    dw Overworld_Sprites_Screen56   ; 56 - Dark Northeast Shop
    dw Overworld_Sprites_Screen57   ; 57 - Dark Octorok Pit
    dw Overworld_Sprites_Screen58   ; 58 - Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 59 - Village of Outcasts
    dw Overworld_Sprites_Screen5A   ; 5A - Outcasts Orchard
    dw Overworld_Sprites_Screen5B   ; 5B - Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 5C - Pyramid of Power
    dw Overworld_Sprites_Screen5D   ; 5D - Dark Hylia River Peninsula
    dw Overworld_Sprites_Screen5E   ; 5E - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 5F - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 60 - Village of Outcasts
    dw Overworld_Sprites_EMPTY      ; 61 - Village of Outcasts
    dw Overworld_Sprites_Screen62   ; 62 - Stake Puzzle
    dw Overworld_Sprites_EMPTY      ; 63 - Pyramid of Power
    dw Overworld_Sprites_EMPTY      ; 64 - Pyramid of Power
    dw Overworld_Sprites_Screen65   ; 65 - Boulder Field
    dw Overworld_Sprites_EMPTY      ; 66 - Palace of Darkness Maze
    dw Overworld_Sprites_EMPTY      ; 67 - Palace of Darkness Maze
    dw Overworld_Sprites_Screen68   ; 68 - Digging Game
    dw Overworld_Sprites_Screen69   ; 69 - South of Outcasts
    dw Overworld_Sprites_Screen6A   ; 6A - Stumpy Grove
    dw Overworld_Sprites_Screen6B   ; 6B - West of Bomb Shoppe
    dw Overworld_Sprites_Screen6C   ; 6C - Bomb Shoppe
    dw Overworld_Sprites_Screen6D   ; 6D - Hammer Bridge
    dw Overworld_Sprites_Screen6E   ; 6E - Dark Lake Hylia River Bend
    dw Overworld_Sprites_Screen6F   ; 6F - East Dark World Portalway
    dw Overworld_Sprites_Screen70   ; 70 - Misery Mire
    dw Overworld_Sprites_Screen72   ; 71 - Misery Mire
    dw Overworld_Sprites_Screen72   ; 72 - Stumpy Grove Entrance
    dw Overworld_Sprites_Screen73   ; 73 - Swamplands Portalway
    dw Overworld_Sprites_Screen74   ; 74 - Swamplands Totems
    dw Overworld_Sprites_Screen75   ; 75 - Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 76 - Dark Lake Hylia
    dw Overworld_Sprites_Screen77   ; 77 - Dark Lake Hylia River End
    dw Overworld_Sprites_EMPTY      ; 78 - Misery Mire
    dw Overworld_Sprites_EMPTY      ; 79 - Misery Mire
    dw Overworld_Sprites_Screen7A   ; 7A - West of Swamplands
    dw Overworld_Sprites_Screen7B   ; 7B - Swamplands Palace Entrance
    dw Overworld_Sprites_Screen7C   ; 7C - Swamplands Ravine
    dw Overworld_Sprites_EMPTY      ; 7D - Dark Lake Hylia
    dw Overworld_Sprites_EMPTY      ; 7E - Dark Lake Hylia
    dw Overworld_Sprites_Screen7F   ; 7F - Dark Lake Hylia Waterfall
    dw Overworld_Sprites_Screen80   ; 80 - Master Sword Pedestal
    dw Overworld_Sprites_Screen81   ; 81 - Zora's Domain
    dw Overworld_Sprites_EMPTY      ; 82 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 83 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 84 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 85 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 86 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 87 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 88 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 89 - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8A - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8B - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8C - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8D - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8E - Unused SW Area
    dw Overworld_Sprites_EMPTY      ; 8F - Unused SW Area
}

; ==============================================================================

; $04EC9F-$04ED9E DATA
Pool_SpriteExplode_Execute:
{
    .oam_groups
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
        
        JSL.l Sprite_VerifyAllOnScreenDefeated : BCS .found_one ; BRANCH_BETA
            ; Restore menu functionality. Bit of a \hack, imo.
            STZ.w $0FFC
        
        .found_one
        
        RTS
        
        .draw
        
        LSR #2 : EOR.b #$07 : STA.b $00
        
        LDA.b #$00 : XBA
        
        LDA.b $00
        
        REP #$20
        
        ASL #5 : ADC.w #Pool_SpriteExplode_Execute_oam_groups : STA.b $08
        
        SEP #$20
        
        LDA.b #$04 : JSL.l Sprite_DrawMultiple
        
        RTS
}

; ==============================================================================

; $04EDEF-$04EE0E DATA
Pool_Explode_SpawnExplosion:
{
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
        JMP.w $EEAD ; $04EEAD IN ROM
    
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
    
    JMP.w $EEAD ; $04EEAD IN ROM
    
    .victory_over_ganon
    
    ; Play the victory song (yay you killed Ganon).
    LDA.b #$13 : STA.w $012C
    
    JMP.w $EEAD ; $04EEAD IN ROM
    
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
    
    LDA.w $0E20, X : STA.b $0F : CMP.b #$92 : BNE .not_helmasaur_king
        LSR.b $0E
    
    .not_helmasaur_king
    
    LDA.w $0DF0, X : CMP.b #$C0 : BCC .generate_explosion_sfx_and_sprites
        RTS
    
    .generate_explosion_sfx_and_sprites
    
    PHA
    
    AND.b #$03 : BNE .explosion_sfx_delay
        LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
    
    .explosion_sfx_delay
    
    PLA : AND.b $0E : BNE .anospawn_explosion_sprite
        LDA.b #$1C
        
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            LDA.b #$0B : STA.w $0AAA
            
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
            
            LDA.b #$1F : STA.w $0DF0, Y : STA.w $0D90, Y
        
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
    
    LDA.l $7FF90E, X : LSR #2 : EOR.b #$07 : ASL #2
    
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
        
        ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w $EF8B, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        SEP #$20
        
        PLX
        
        LDA.b $02 : CLC : ADC.w $F00B, X : INY : STA ($90), Y
        
        LDA.w $0FB5 : BNE .BRANCH_EPSILON
            LDA.b #$4E
            
            BRA .BRANCH_ZETA
            
        .BRANCH_EPSILON
        
        ; Feel I should leave a comment here because of this unusual sequence
        ; of instructions.
        CMP.b #$80 : LDA.w $F04B, X : BCC .BRANCH_ZETA
            LDA.b #$F2
        
        .BRANCH_ZETA
        
                         INY             : STA ($90), Y
        LDA.w $F08B, X : INY : ORA.b $05 : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
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
    
    AND.b #$0F : LSR #2 : STA.b $06
    
    ASL A : ADC.b $06 : STA.b $06
    
    LDY.b #$00
    
    PHX
    
    LDX.b #$02
    
    .next_oam_entry
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_ScatterDebris_Draw_x_offsets, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        SEP #$20
        
        PLX
        
        LDA.b $02 : CLC : ADC Pool_ScatterDebris_Draw_y_offsets, X
        INY : STA ($90), Y

        LDA Pool_ScatterDebris_Draw_chr, X
        INY : STA ($90), Y

        LDA Pool_ScatterDebris_Draw_properties, X
        INY : ORA.b #$22 : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_oam_entry
    
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
    
    TXA : ASL A : TAY
    
    REP #$20
    
    ; Basically the BCS later on is a BEQ in effect, checks if($0BC0, Y ==
    ; 0xFFFF) .
    LDA.w $0BC0, Y : STA.b $00 : CMP.w #$FFFF
    
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
        
        LDA [$01] : AND.l $09F24B, X : STA [$01]
        
        PLX
        
    .invalid_address
    
    LDA.b $1B : BNE .indoors_2
        TXA : ASL A : TAY
        
        LDA.b #$FF : STA.w $0BC0, Y : STA.w $0BC1, Y
        
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
    LDA.b $11 : ASL A : TAX
    
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
    
    ; Fade volume to nothing
    LDA.b #$F1 : STA.w $012C2C
    
    ; turn off ambient sound effect (rumbling, etc)
    LDA.b #$05 : STA.w $012D
    
    ; not sure of the interpretation of this, though
    STA.w $0200
    
    ; turn off cape ($55), and two other things that I don't understand
    STZ.w $03F3 : STZ.w $0322 : STZ.b $55
    
    REP #$20
    
    ; cache mosaic level settings in temporary variables
    LDA.l $7EC007 : STA.l $7EC221
    LDA.l $7EC009 : STA.l $7EC223
    
    LDX.b #$00
    
    ; sets all entries in the auxiliary palette to black. This is presumably used
    ; later for the fade from red to black after Link falls down.
    .blackenAuxiliary
    
        LDA.l $7EC300, X : STA.l $7FDD80, X
        LDA.l $7EC340, X : STA.l $7FDDC0, X
        LDA.l $7EC380, X : STA.l $7FDE00, X
        LDA.l $7EC3C0, X : STA.l $7FDE40, X
        
        LDA.w #$0000 : STA.l $7EC340, X : STA.l $7EC380, X : STA.l $7EC3C0, X
    INX #2 : CPX.b #$40 : BNE .blackenAuxiliary
    
    STA.l $7EC007 : STA.l $7EC009
    
    STZ.w $011A : STZ.w $011C
    
    LDA.b $99 : STA.l $7EC225
    
    SEP #$20
    
    ; Set a timer for 32 frames
    LDA.b #$20 : STA.b $C8
    
    STZ.w $04A0
    
    ; Setting $04A0 to 0 turns off the display of the floor level indicator on bg3
    JSL.l $0AFD0C ; $57D0C
    
    INC.b $16
    
    ; Silences the sound effect on first channel    
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
        
            STA.l $7EC540, X : STA.l $7EC560, X : STA.l $7EC580, X
            STA.l $7EC5A0, X : STA.l $7EC5C0, X : STA.l $7EC5E0, X
        INX #2 : CPX.b #$20 : BNE .fill_main_bg_palettes_with_red
        
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
        
        LDA.b #$00 : STA.l $7EC007 : STA.l $7EC009
        
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
                            
                            LDA.b #$16 : STA.b $17 : STA.w $0710
                            
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
    
    LDA.b #$0F : STA.w $0AAA
    
    ; Grab a half pack of graphics and expand to 4bpp.
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
    
    INC.b $15 : INC.b $11

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
    
    PLA : INC A : STA.b $11
    
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
; $04F4C1-$04F674 LOCAL JUMP LOCATION
GameOver_SaveAndOrContinue:
{
    JSR.w $F67A ; $04F67A IN ROM
    
    LDA.w $0C4A : BEQ .alpha
        JSL.l Ancilla_GameOverTextLong
    
    .alpha
    
    LDA.b $F4 : AND.b #$20 : BNE .selectButtonPressed
        DEC.b $C8 : BNE .BRANCH_GAMMA
            INC.b $C8
            
            LDA.b $F0
            
            AND.b #$0C : BEQ .BRANCH_GAMMA
                AND.b #$04 : BEQ .BRANCH_DELTA
    
    .selectButtonPressed
    
    INC.b $B0 : LDA.b $B0 : CMP.b #$03 : BMI .BRANCH_EPSILON
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

; $04F50F ALTERNATE ENTRY POINT
GameOver_FadeAndRevive:
{
    LDA.b #$F1 : STA.w $012C
        
    LDA.b $1B : BEQ .BRANCH_ZETA
        JSL.l Dungeon_SaveRoomQuadrantData
        
    .BRANCH_ZETA
        
    JSL.l $02856A ; $01056A IN ROM
        
    LDA.l $7EF3C5 : CMP.b #$03 : BCS .BRANCH_THETA
        LDA.b #$00 : STA.l $7EF3CA
        
        LDA.l $7EF357 : BNE .BRANCH_THETA
            JSL.l $028570 ; $010570 IN ROM
        
    .BRANCH_THETA
        
    LDA.b $A0 : ORA.b $A1 : BNE .BRANCH_IOTA
        STZ.b $1B
        
    .BRANCH_IOTA
        
    JSL.l $0BFFBF ; $05FFBF IN ROM
        
    LDA.l $7EF3CC
        
    CMP.b #$06 : BEQ .BRANCH_KAPPA
    CMP.b #$0D : BEQ .BRANCH_KAPPA
    CMP.b #$0A : BEQ .BRANCH_KAPPA
        CMP.b #$09 : BNE .BRANCH_LAMBDA

    .BRANCH_KAPPA
        
    LDA.b #$00 : STA.l $7EF3CC
        
    .BRANCH_LAMBDA

    LDA.l $7EF36C : LSR #3 : TAX
        
    LDA.l $09F4AC, X : STA.l $7EF36D : STA.w $04AA
        
    LDA.w $040C
        
    CMP.b #$FF : BEQ .BRANCH_MU
        CMP.b #$02 : BNE .BRANCH_NU
            LDA.b #$00
        
        .BRANCH_NU
        
        LSR A : TAX

        LDA.l $7EF36F : STA.l $7EF37C, X
        
    .BRANCH_MU
        
    JSL.l Sprite_ResetAll
        
    REP #$20
        
    LDA.l $7EF405 : CMP.w #$FFFF : BNE .playerHasDeaths
        LDA.l $7EF403 : INC A : STA.l $7EF403
        
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
            LDA.b #$20 : STA.b $A0 : STZ.b $A1
        
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
        
        LDA.l $701FFE : TAX : DEX #2
        
        LDA.l $00848C, X : STA.b $00
        
        SEP #$20
        
        STZ.w $010A
        
        JSL.l $0CCFBB ; $064FBB IN ROM
        
        RTS
        
    .handleSram
        
    LDA.l $7EF3C5 : BEQ .dontSave
        JSL.l Main_SaveGameFile
        
    .dontSave
        
    LDA.b #$10 : STA.b $1C
        
    STZ.b $1B
        
    JSL.l $0CF0E2 ; $0670E2 IN ROM
        
    STZ.w $04AA : STZ.w $010A : STZ.w $0132
        
    SEI
        
    STZ.w SNES.NMIVHCountJoypadEnable : STZ.w SNES.HDMAChannelEnable
        
    REP #$30
        
    STZ.b $E0 : STZ.b $E2 : STZ.b $E4 : STZ.b $E6 : STZ.b $E8 : STZ.b $EA
        
    STZ.w $0120 : STZ.w $011E : STZ.w $0124 : STZ.w $0122
        
    LDX.w #$0000 : TXA
        
    .eraseSramBuffer
        
        STA.l $7EF000, X
        STA.l $7EF100, X
        STA.l $7EF200, X
        STA.l $7EF300, X
        STA.l $7EF400, X    
    INX #2 : CPX.w #$0100 : BNE .eraseSramBuffer
        
    SEP #$30
        
    STZ.w $0136
        
    LDA.b #$FF : STA.w SNES.APUIOPort0
        
    JSL.l Sound_LoadLightWorldSongBank
        
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
    
    LDA.w $F677, X : STA.w $0851
    
    LDA.b $1A : AND.b #$08 : LSR #3 : TAX
    
    LDA.w $F675, X : STA.w $0852
    
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
        
            ; Mess with the palette
            LDA.l $7FDD80, X : STA.l $7EC300, X
            LDA.l $7FDDC0, X : STA.l $7EC340, X
            LDA.l $7FDE00, X : STA.l $7EC380, X
            LDA.l $7FDE40, X : STA.l $7EC3C0, X
            
            LDA.w #$0000
            STA.l $7EC540, X : STA.l $7EC580, X : STA.l $7EC5C0, X
        INX #2 : CPX.b #$40 : BNE .restore_cached_palettes_loop
        
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
Pool_Module_Quit:
{
    .submodules
    dw Quit_IndicateHaltedState
    dw Quit_FadeOut
}

; Beginning of Module 0x17 - Quitting mode (save and quit)
; $04F79F-$04F7AE LONG JUMP LOCATION
Module_Quit:
{
    LDA.b $11 : ASL A : TAX
    
    JSR.w (Pool_Module_Quit_submodules, X)
    
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
    
    JMP.w $F50F ; $04F50F IN ROM
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
    
    LDA.b $02 : AND.w #$00FF : ASL A : ADC.w #$0080 : STA.b $08
    
    LDA.w $1F03 : AND.w #$00FF : ASL A : STA.b $B0
    
    ; X = ( 0xFF8C + ($1F03 * 6) ).
    ; Note that $1F03 seems to always be 0 or 1.
    ASL A : ADC.b $B0 : ADC.w #$FF8C : TAX
    
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
    
    LDA.w SNES.MultResultMid : ASL #2 : STA.b $58
    
    LDX.b $56 : STX.w SNES.Mode7MatrixA
    LDX.b $57 : STX.w SNES.Mode7MatrixA
    LDX.b $52 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL #2 : STA.b $5E
    
    LDX.b $56 : STX.w SNES.Mode7MatrixA
    LDX.b $57 : STX.w SNES.Mode7MatrixA
    LDX.b $50 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL #2 : STA.b $5A
    
    LDX.b $54 : STX.w SNES.Mode7MatrixA
    LDX.b $55 : STX.w SNES.Mode7MatrixA
    LDX.b $52 : STX.w SNES.Mode7MatrixB
    
    LDA.w SNES.MultResultMid : ASL #2 : STA.b $5C
    
    CLI
    
    RTS
}

; $04F8FB-$04F930
Polyhedral_OperateRotation:
{
    SEP #$30
    
    LDA.b $3F : TAX
    
    ; Y = 3 * $3F.
    ASL A : ADC.b $3F : TAY
    
    .alpha
    
        DEX
        
        DEY
        LDA ($41), Y : STA.b $47
        
        DEY
        LDA ($41), Y : STA.b $46
        
        DEY
        LDA ($41), Y : STA.b $45
        
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
        EOR.w #$FFFF : INC A
    
    .alpha
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .gamma
        .beta
        
            LSR.b $B2
            LSR.b $B0
        LSR A : BNE .beta
    
    .gamma
    
    SEI
    
    LDA.b $B2 : STA.w SNES.DividendLow
    LDY.b $B0 : STY.w SNES.DivisorB
    
    NOP #2
    
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
    
    ; $04FA12
    
    LDA.b $4A : BPL .zeta
        EOR.w #$FFFF : INC A
    
    .zeta
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .iota
        .theta
        
            LSR.b $B2
            LSR.b $B0
        LSR A : BNE .theta
    
    .iota
    
    SEI
    
    LDA.b $B2 : STA.w SNES.DividendLow
    LDY.b $B0 : STY.w SNES.DivisorB
    
    NOP #2
    
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
    
        LDA ($43), Y : STA.b $4E
        
        AND.b #$7F : STA.b $B0
        
        ASL A : STA.b $C0
        
        INY
        
        LDX.b #$01
        
        .alpha
        
            PHY
            
            LDA ($43), Y : TAY
            
            LDA.w $1F60, Y : STA.b $C0, X
            
            INX
            
            LDA.w $1F88, Y : STA.b $C0, X
            
            INX
            
            PLY : INY
        DEC.b $B0 : BNE .alpha
        
        LDA ($43), Y
        
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
        
        LSR #2 : STA.b $B0
        
        .epsilon
        
            LDA.b $C0, X : PHA
            
            LDA.w $1FC0, Y : STA.b $C0, X
            
            PLA
            
            STA.w $1FC0, Y
            
            INX #2
            
            DEY #2
        DEC.b $B0 : BNE .epsilon
        
        SEP #$20
        
        JSR.w Polyhedral_SetBackgroundColor
        JSL.l Polyhedral_DrawFace
        
        JMP .beta
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
    
    LDA.b $B0 : EOR.w #$FFFF : INC A
    
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
    
        ASL A
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
    
    SEC : LDA.b $C6 : SBC.b $C4 : STA.w SNES.Mode7MatrixB
    
    ; Apparently it's super important to keep the I flag low
    ; for as little time as possible.
    LDA.w SNES.MultResultLow       : STA.b $B0
    LDA.w SNES.MultResultMid : CLI : STA.b $B1
    
    SEP #$05
    
    LDA.b $C5  : SBC.b $C3  : STA.w SNES.Mode7MatrixA
    LDA.b #$00 : SBC.b #$00 : STA.w SNES.Mode7MatrixA
    
    SEC : LDA.b $C4 : SBC.b $C2 : STA.w SNES.Mode7MatrixB
    
    REP #$20
    
    SEC : LDA.b $B0 : SBC.w SNES.MultResultLow : STA.b $B0
    
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
    
    ASL #2 : TAX
    
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
    
    MVN $7E7E
    
    PLB : PLP
    
    RTL
}

; $04FD1E-$04FDCB LONG JUMP LOCATION
Polyhedral_DrawFace:
{
    PHP : PHB
    
    SEP #$30
    
    LDA.b #$7E : PHA : PLB
    
    LDY.b $C0 : TYX
    
    LDA.b $C0, X
    
    .alpha
    
            DEX #2 : BEQ .beta
                ; (<= comparison)
        CMP $C0, X : BCC .alpha
    BEQ .alpha
    
    TXY
    
    LDA.b $C0, X
    
    BRA .alpha
    
    .beta
    
    AND.b #$07 : ASL A : STA.b $B9
    
    LDA.w $1FC0, Y : AND.b #$38 : BIT.b #$20 : BEQ .gamma
        EOR.b #$24
    
    .gamma
    
    LSR #2 : ADC.b #$E8 : STA.b $BA
    
    STY.b $E9 : STY.b $F2
    
    LDA.b $C0 : LSR A : STA.b $E0
    
    LDA.w $1FC0, Y : STA.b $E2 : STA.b $EB
    LDA.w $1FBF, Y : STA.b $E1 : STA.b $EA
    
    JSR.w Polyhedral_SetLeft : BCS .delta
        JSR.w Polyhedral_SetRight : BCC .epsilon
    
    .delta
    
    PLB : PLP
    
    RTL
    
    .epsilon
    
    JSR.w Polyhedral_FillLine
    
    LDA.b $B9 : INC #2 : CMP.b #$10 : BEQ .zeta
        STA.b $B9
        
        BRA .iota
        
    .zeta
    
    LDA.b $BA : INC #2 : BIT.b #$08 : BNE .theta
        EOR.b #$19
    
    .theta
    
    STA.b $BA : STZ.b $B9
    
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

; $04FDCF-$04FE93 LOCAL JUMP LOCATION
Polyhedral_FillLine:
{
    LDA.b $E6 : AND.b #$07 : ASL A : TAY
    
    LDA.b $EF : AND.b #$07 : ASL A : TAX
    
    LDA.b $E6 : AND.b #$38 : STA.b $BC
    
    LDA.b $EF : AND.b #$38 : SEC : SBC.b $BC : BNE .alpha
        REP #$30
        
        LDA.l $09FEA4, X : TYX : AND.l $09FE94, X : STA.b $B2
        
        LDA.b $EF : AND.w #$0038 : ASL #2 : ORA.b $B9 : TAY
        
        LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
        LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
        
        .return
        
        SEP #$30
        
        RTS
    
    .alpha
    
    BCC .return
        LSR #3 : STA.b $FA : STZ.b $FB
        
        REP #$30
        
        LDA.l $09FEA4, X : STA.b $B2
        
        TYX
        
        LDA.b $EF : AND.w #$0038 : ASL #2 : ORA.b $B9 : TAY
        
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
        
        LDA.l $09FE94, X : STA.b $B2
        
        LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
        LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
        
        SEP #$30
        
        RTS
}

; $04FE94-$04FEB3 DATA
Polyhedral_LineFillMask:
{
    ; $04FE94
    .left
    dw $FFFF, $7F7F, $3F3F, $1F1F, $0F0F, $0707, $0303, $0101
    
    ; $04FEA4
    .right
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
        
        LDX.b $E9 : DEX #2 : BNE .beta
            LDX.b $C0
        
        .beta
        
        STA.b $C0, X : CMP $E2 : BCC .gamma
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
        
        EOR.b #$FF : INC A
    
    .epsilon
    
    SEI
    
                 STA.l $004205
    LDA.b #$00 : STA.l $004204
    
    SEC : LDA.b $E4 : SBC.b $E2 : STA.l $004206
    
    REP #$20
    
    LDA.b $E0 : AND.w #$FF00 : ORA.w #$0080 : STA.b $E5
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .zeta
        LDA.l $004214
        
        BRA .theta
        
    .zeta
    
    SEC : SBC.l $004214
    
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
        
        INX #2
        
        .gamma
        
        LDA.b $C0, X : CMP $EB : BCC .delta : BNE .epsilon
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
        
        EOR.b #$FF : INC A
    
    .zeta
    
    SEI
    
                 STA.l $004205
    LDA.b #$00 : STA.l $004204
    
    SEC : LDA.b $ED : SBC.b $EB : STA.l $004206
    
    REP #$20
    
    LDA.b $E9 : AND.w #$FF00 : ORA #$0080 : STA.b $EE
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .theta
        LDA.l $004214
        
        BRA .iota
    
    .theta
    
    SEC : SBC.l $004214
    
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
    .crystal
    db $06 ; vertices
    db $08 ; faces
    dw CrystalVertices
    dw CrystalFaces

    .triforce
    db $06 ; vertices
    db $05 ; faces
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
