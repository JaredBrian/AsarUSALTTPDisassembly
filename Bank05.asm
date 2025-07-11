; ==============================================================================

; Bank 05
; $028000-$02FFFF
org $058000

; Misc Garnish code
; Misc Sprites

; ==============================================================================

; $028000-$028007 DATA
Pool_Sprite_SpawnSparkleGarnish:
{
    .low_offset
    db $FC, $00, $04, $08
    
    .high_offset
    db $FF, $00, $00, $00
}

; $028008-$02807E LONG JUMP LOCATION
Sprite_SpawnSparkleGarnish:
{
    ; Check if the frame counter is a multiple of 4:
    LDA.b $1A : AND.b #$03 : BNE .skip_frame
        PHX
        
        TXY
        JSL.l GetRandomInt : AND.b #$03 : TAX
        LDA.l Pool_Sprite_SpawnSparkleGarnish_low_offset, X  : STA.b $00
        LDA.l Pool_Sprite_SpawnSparkleGarnish_high_offset, X : STA.b $01
        
        JSL.l GetRandomInt : AND.b #$03 : TAX
        LDA.l Pool_Sprite_SpawnSparkleGarnish_low_offset, X  : STA.b $02
        LDA.l Pool_Sprite_SpawnSparkleGarnish_high_offset, X : STA.b $03
        
        LDX.b #$1D
        
        .next_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .next_slot
        
        ; Even if we don't find an empty slot, we're still going to use slot 0
        ; anyway.
        INX
        
        .empty_slot
        
        ; Sprite falling into a hole animation?
        ; (update: more likely to be setting up a sparkle animation, as this
        ; has so far only been linked to good bees and something that also seems
        ; to be a good bee).
        LDA.b #$12 : STA.l $7FF800, X
                     STA.w $0FB4
        
        LDA.w $0D10, Y : CLC : ADC.b $00 : STA.l $7FF83C, X
        LDA.w $0D30, Y :       ADC.b $01 : STA.l $7FF878, X
        
        LDA.w $0D00, Y : CLC : ADC.b $02 : STA.l $7FF81E, X
        LDA.w $0D20, Y :       ADC.b $03 : STA.l $7FF85A, X
        
        ; Set the associated sprite index for the garnish sprite?
        TYA : STA.l $7FF92C, X
        
        LDA.b #$0F : STA.l $7FF90E, X
        
        TXY
        
        PLX
    
    .skip_frame
    
    RTL
}

; ==============================================================================

; $02807F-$028083 JUMP LOCATION
Sprite_HelmasaurFireballTrampoline:
{
    JSL.l Sprite_HelmasaurFireballLong
    
    RTS
}

; ==============================================================================

; $028084-$028175
incsrc "sprite_wall_cannon.asm"

; $028176-$02852C
incsrc "sprite_archery_game_guy.asm"

; $02852D-$02874C
incsrc "sprite_debirando_pit.asm"

; $02874D-$0288C4
incsrc "sprite_debirando.asm"

; $0288C5-$028DD7
incsrc "sprite_master_sword.asm"

; $028DD8-$028F53
incsrc "sprite_spike_roller.asm"

; $028F54-$029332
incsrc "sprite_beamos.asm"

; $029333-$02940D
incsrc "sprite_spark.asm"

; $02940E-$029467
incsrc "sprite_lost_woods_bird.asm"

; $029468-$0294AE
incsrc "sprite_lost_woods_squirrel.asm"

; $0294AF-$02956C
incsrc "sprite_crab.asm"

; $02956D-$029669
incsrc "sprite_desert_barrier.asm"

; $02966A-$02995A
incsrc "sprite_zora_and_fireball.asm"

; $02995B-$029D49
incsrc "sprite_zora_king.asm"

; $029D4A-$02A030
incsrc "sprite_walking_zora.asm"

; $02A031-$02A376
incsrc "sprite_armos_knight.asm"

; $02A377-$02A87F
incsrc "sprite_lanmola.asm"

; $02A880-$02A95A
incsrc "sprite_rat.asm"

; $02A95B-$02AA86
incsrc "sprite_rope.asm"

; $02AA87-$02AB53
incsrc "sprite_keese.asm"

; $02AB54-$02AF70
incsrc "sprite_cannon_trooper.asm"

; $02AF71-$02B018
incsrc "sprite_warp_vortex.asm"

; $02B019-$02B5C2
incsrc "sprite_flail_trooper.asm"

; ==============================================================================

; $02B5C3-$02B5CA LONG JUMP LOCATION
SpriteActive2_MainLong:
{
    PHB : PHK : PLB
    
    JSR.w SpriteActive2_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $02B5CB-$02B5D2 DATA
Soldier_DirectionLockSettings:
{
    ; $02B5CB
    .directions
    db $03, $02, $00, $01
    
    ; $02B5CF
    .animation_states
    db $08, $00, $0C, $05
}

; ==============================================================================

; This routine is meant to handle sprites with IDs 0x41 to 0x70.
; $02B5D3-$02B647 LOCAL JUMP LOCATION
SpriteActive2_Main:
{
    LDA.w $0E20, X : SEC : SBC.b #$41

    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w .sprite_routines, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    ; Sprite routines 3*
    .sprite_routines
    
    ; Please note that the numbers in the comments to the right are the actual
    ; sprite numbers and have nothing to do with the orientation of the table,
    ; though they are in order.
    
    dw Sprite_Soldier                     ; 0x41 - $C155 Green Soldier
    dw Sprite_Soldier                     ; 0x42 - $C155 Blue Soldier
    dw Sprite_Soldier                     ; 0x43 - $C155 Red Spear Soldier
    dw Sprite_PsychoTrooper               ; 0x44 - $CC65 Crazy Blue Killer Soldiers
    dw Sprite_PsychoSpearSoldier          ; 0x45 - $CBE0 Crazed Spear Soldiers
                                          ;        (Green or Red)
    dw Sprite_ArcherSoldier               ; 0x46 - $CDFF Blue Archers
    dw Sprite_BushArcherSoldier           ; 0x47 - $D1BF Green Archers (in bushes)
                                          
    dw Sprite_JavelinTrooper              ; 0x48 - $CDE1 Red Javelin Soldiers
                                          ;        (in special armor)
    dw Sprite_BushJavelinSoldier          ; 0x49 - $D1AC Red Javelin Soldiers
                                          ;        (in bushes)
    dw Sprite_BombTrooper                 ; 0x4A - $BE0A Bomb Trooper / Enemy Bombs
    dw Sprite_Recruit                     ; 0x4B - $BC8A Recruit
    dw Sprite_GerudoMan                   ; 0x4C - $B8B3 Gerudo Man
    dw Sprite_Toppo                       ; 0x4D - $BA85 Enemy bunnies (Toppo)
    dw Sprite_Popo                        ; 0x4E - $B80A Snakebasket (Popo?)
    dw Sprite_Bot                         ; 0x4F - $B80A Bot / Bit?
    dw Sprite_MetalBall                   ; 0x50 - $B648 Metal Balls in Eastern
                                          ;        Palace
    dw Sprite_Armos                       ; 0x51 - $B703 Armos
    dw Sprite_ZoraKing                    ; 0x52 - $995B Giant Zora
    dw Sprite_ArmosKnight                 ; 0x53 - $A036 Armos Knight Code
    dw Sprite_Lanmola                     ; 0x54 - $A3A2 Lanmola
    dw Sprite_ZoraAndFireball             ; 0x55 - $967B Zora (or Agahnim) fireball
                                          ;        code
    dw Sprite_WalkingZora                 ; 0x56 - $9D4A Walking Zora
    dw Sprite_DesertBarrier               ; 0x57 - $956D Desert Palace Barrier
    dw Sprite_Crab                        ; 0x58 - $94B5 Crab
    dw Sprite_LostWoodsBird               ; 0x59 - $940E Birds (master sword grove)
    dw Sprite_LostWoodsSquirrel           ; 0x5A - $9468 Squirrel (master sword
                                          ;        grove?)
    dw Sprite_Spark                       ; 0x5B - $933F Spark (clockwise on convex,
                                          ;        counterclockwise on concave)
    dw Sprite_Spark                       ; 0x5C - $933F Spark (counterclockwise on
                                          ;        convex, clockwise on concave)
    dw Sprite_SpikeRoller                 ; 0x5D - $8DDE Roller (????)
    dw Sprite_SpikeRoller                 ; 0x5E - $8DDE Roller (????)
    dw Sprite_SpikeRoller                 ; 0x5F - $8DDE Roller (????)
    dw Sprite_SpikeRoller                 ; 0x60 - $8DDE Roller (????)
    dw Sprite_Beamos                      ; 0x61 - $8F54 Beamos (aka Statue Sentry)
    dw Sprite_MasterSword                 ; 0x62 - $88C5 Master Sword (in the grove)
    dw Sprite_DebirandoPit                ; 0x63 - $8531 Sand lion pit
    dw Sprite_Debirando                   ; 0x64 - $874D Sand lion
    dw Sprite_ArcheryGameGuy              ; 0x65 - $81FF Shooting gallery guy
    dw Sprite_WallCannon                  ; 0x66 - $8090 Moving cannon ball shooters
    dw Sprite_WallCannon                  ; 0x67 - $8090 Moving cannon ball shooters
    dw Sprite_WallCannon                  ; 0x68 - $8090 Moving cannon ball shooters
    dw Sprite_WallCannon                  ; 0x69 - $8090 Moving cannon ball shooters
    dw Sprite_ChainBallTrooper            ; 0x6A - $B01B Ball n' Chain Trooper
    dw Sprite_CannonTrooper               ; 0x6B - $ABE4 Cannon Ball Shooting
                                          ;        Trooper (unused in game)
    dw Sprite_WarpVortex                  ; 0x6C - $AF75 Warp Vortex (from Magic
                                          ;        mirror in light world)
    dw Sprite_Rat                         ; 0x6D - $A8B0 Rat / Bazu
    dw Sprite_Rope                        ; 0x6E - $A973 Rope / Skullrope
    dw Sprite_Keese                       ; 0x6F - $AA8B Keese
    dw Sprite_HelmasaurFireballTrampoline ; 0x70 - $807F Helmasaur King fireballs
}

; ==============================================================================

; $02B648-$02B702
incsrc "sprite_metal_ball.asm"

; $02B703-$02B809
incsrc "sprite_armos.asm"

; $02B80A-$02B8B2
incsrc "sprite_bot.asm"

; $02B8B3-$02BA84
incsrc "sprite_gerudo_man.asm"

; $02BA85-$02BC89
incsrc "sprite_toppo.asm"

; $02BC8A-$02BE09
incsrc "sprite_recruit.asm"

; $02BE0A-$02C154
incsrc "sprite_bomb_trooper.asm"

; ==============================================================================

; $02C155-$02C15C LOCAL JUMP LOCATION
Sprite_Soldier:
{
    LDA.w $0DB0, X : BNE .is_probe
        JMP.w Soldier_Main
    
    .is_probe
    
    ; Bleeds into the next funtion.
}

; $02C15D-$02C226 LOCAL JUMP LOCATION
Sprite_Probe:
{
    LDY.b #$00
    
    ; Is the sprite moving right? Yes, so skip the decrement of Y.
    LDA.w $0D50, X : BPL .moving_right
        ; Sprite is moving left, so we have to make sure subtraction is done
        ; smoothly.
        DEY
    
    .moving_right
    
    ; This code moves the soldier left or right, depending on $0D50, X.
    CLC : ADC.w $0D10, X : STA.w $0D10, X
    TYA : ADC.w $0D30, X : STA.w $0D30, X
    
    LDY.b #$00
    
    ; Same as above but for Y coordinate of the soldier.
    LDA.w $0D40, X : BPL .moving_down
        DEY
    
    .moving_down
    
          CLC : ADC.w $0D00, X : STA.w $0D00, X
    TYA : ADC.w $0D00, X : STA.w $0D20, X
    
    ; Usually 0. Otherwise the soldier's invisible.
    LDY.w $0DB0, X
    
    ; Is this soldier (Link locator) belonging to Blind?
    LDA.w $0E1F, Y : CMP.b #$CE : BNE .parent_not_blind_the_thief
        REP #$20
        
        LDA.w $0FD8 : SEC : SBC.b $22 : CLC : ADC.w #$0010
        CMP.w #$0020 : SEP #$20 : BCS .player_not_close
            REP #$20
            
            LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0018
            CMP.w #$0020 : SEP #$20 : BCS .player_not_close
                JMP.w .made_contact
        
        .player_not_close
        
        JMP.w .no_contact
    
    .parent_not_blind_the_thief
    
    ; Check the tile attr that the sprite is interacting with.
    JSL.l Probe_CheckTileSolidity : BCC .zeta
        LDA.w $0FA5 : CMP.b #$09 : BNE .theta
    
    .zeta
    
    ; Is Link invisible and invincible? (magic cape).
    LDA.w $0055 : BNE .theta 
        REP #$20
        
        LDA.w $0FD8 : SEC : SBC.b $22 : CMP.w #$0010 : SEP #$20 : BCS .no_contact
            REP #$20
            
            LDA.w $0FDA : SEC : SBC.b $20 : CMP.w #$0010 : SEP #$20 : BCS .no_contact
                ; Are Link and the soldier on the same floor?
                LDA.w $0F20, X : CMP $EE : BNE .no_contact
                    ; $02C1F6 ALTERNATE ENTRY POINT
                    .made_contact
                    
                    LDA.w $0DB0, X : DEC
                    
                    PHX
                    
                    TAX
                    LDA.w $0D80, X : CMP.b #$03 : BEQ .kappa
                        LDA.b #$03 : STA.w $0D80, X
                        
                        ; Is the sprite Blind the Thief?
                        LDA.w $0E20, X : CMP.b #$CE : BEQ .kappa ; Yes...
                            LDA.b #$10 : STA.w $0DF0, X
                        
                            STZ.w $0E80, X
                    
                    .kappa
                    
                    PLX
    
    BRA .theta
    
    ; $02C21A ALTERNATE ENTRY POINT
    .no_contact
    
    JSR.w Sprite2_PrepOamCoord
    
    LDA.b $01 : ORA.b $03 : BEQ .return
        .theta
        
        STZ.w $0DD0, X
    
    ; $02C226 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $02C227-$02C2CF JUMP LOCATION
Soldier_Main:
{
    LDA.w $0DC0, X : PHA
    
    LDY.w $0DE0, X : PHY
    
    ; This is actually used.
    LDA.w $0E00, X : BEQ .direction_lock_inactive
        LDA.w Soldier_DirectionLockSettings_directions, Y : STA.w $0DE0, X
        
        LDA.w Soldier_DirectionLockSettings_animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    ; Looks like a "draw soldier" function...
    JSR.w Guard_HandleAllAnimation
    
    PLA : STA.w $0DE0, X
    PLA : STA.w $0DC0, X
    
    LDA.w $0DD0, X : CMP.b #$05 : BNE .not_falling_in_hole
        LDA.b $11 : BNE Sprite_Soldier_return
            ; Ticking animation clock and state...
            JSR.w Guard_TickTwiceAndUpdateBody
            JMP.w Guard_TickTwiceAndUpdateBody
    
    .not_falling_in_hole
    
    JSR.w Sprite2_CheckIfActive

    ; Push sprite back from sword hit?
    JSL.l Guard_ParrySwordAttacks
    
    JSL.l Sprite_CheckDamageToPlayerLong : BCS .gamma
        LDA.w $0FDC : BEQ .delta
    
    .gamma
    
    LDA.w $0D80, X : CMP.b #$03 : BCS .delta
        LDA.b #$03 : STA.w $0D80, X
        
        LDA.b #$20
        
        BRA .epsilon
    
    .delta
    
    LDA.w $0EA0, X : BEQ .zeta
        CMP.b #$04 : BCC .zeta
            LDA.b #$04 : STA.w $0D80, X
            
            LDA.b #$80
            
            .epsilon
            
            JSR.w Guard_SetTimerAndAssertTileHitbox
    
    .zeta
    
    JSR.w Sprite2_CheckIfRecoiling
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .theta
        LDA.w $0E70, X : BNE .iota
            JSR.w Sprite2_Move
        
        .iota
        
        JSR.w Sprite2_CheckTileCollision
        
        BRA .kappa
    
    .theta
    
    JSR.w Sprite2_Move
    
    .kappa
    
    LDA.w $0D80, X : CMP.b #$04 : BEQ .nu
        STZ.w $0ED0, X
    
    .nu
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w .states, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    .states
    
    dw Guard_Idle         ; 0x00 - $C2D4
    dw Guard_OnPatrol     ; 0x01 - $C403
    dw Guard_Surveying    ; 0x02 - $C490
    dw Guard_NoticeKouhai ; 0x03 - $C4C1
    dw Guard_InPursuit    ; 0x04 - $C4E8
}

; ==============================================================================

; $02C2D0-$02C2D3 DATA
Pool_Guard_Idle:
{
    db $60, $C0, $FF, $40
}

; $02C2D4-$02C330 JUMP LOCATION
Guard_Idle:
{
    JSR.w Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.w $0E30, X : BEQ .beta
            AND.b #$07 : CMP.b #$05 : BCS .beta
                LDA.w $0E30, X : LSR #3 : AND.b #$03 : TAY
                LDA.w Pool_Guard_Idle, Y : STA.w $0DF0, X
                
                LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
                
                STZ.w $0E80, X
                
                BRA .gamma
            
        .beta
        
        JSL.l GetRandomInt : AND.b #$3F : ADC.b #$28 : STA.w $0DF0, X
        
        LDA.w $0DE0, X : PHA
        
        JSL.l GetRandomInt : AND.b #$03 : STA.w $0DE0, X
        
        PLA : CMP.w $0DE0, X : BEQ .alpha
            EOR.w $0DE0, X : AND.b #$02 : BNE .alpha
                ; $02C32B ALTERNATE ENTRY POINT
                .Soldier_EnableDirectionLock
                
                .gamma
                
                LDA.b #$0C : STA.w $0E00, X
        
        .alpha
    .delay
    
    RTS
}

; $02C331-$02C3A0 DATA
Pool_Probe:
Pool_Soldier:
{
    ; $02C331
    .x_speeds
    db $08, $F8, $00, $00
    
    ; $02C335
    .y_speeds
    db $00, $00, $08, $F8
    
    ; $02C339
    .animation_states
    db $0B, $0C, $0D, $0C, $04, $05, $06, $05
    db $00, $01, $02, $03, $07, $08, $09, $0A
    db $11, $12, $11, $12, $07, $08, $07, $08
    db $03, $04, $03, $04, $0D, $0E, $0D, $0E
    
    ; $02C359
    .x_checked_directions
    db  1,  1, -1, -1
    db -1, -1,  1,  1
    
    ; $02C361
    .y_checked_directions
    db -1,  1,  1, -1
    db -1,  1,  1, -1
    
    ; $02C369
    .chase_x_speeds
    db $08, $00, $F8, $00
    db $F8, $00, $08, $00
    
    ; $02C371
    .chase_y_speeds
    db $00, $08, $00, $F8
    db $00, $08, $00, $F8
    
    ; $02C379
    .ProbeType
    db  0,  2,  1,  3
    db  1,  2,  0,  3
    
    ; $02C381
    .collinear_directions
    db $01, $04, $02, $08
    db $02, $04, $01, $08
    
    ; $02C389
    .orthogonal_directions
    db $08, $01, $04, $02
    db $08, $02, $04, $01
    
    ; $02C391
    .collinear_next_direction
    db  1,  2,  3,  0
    db  5,  6,  7,  4
    
    ; $02C399
    .orthogonal_next_direction
    db  3,  0,  1,  2
    db  7,  4,  5,  6
}

; $02C3A1-$02C402 JUMP LOCATION
Guard_ShootProbeAndStuff:
{
    LDY.w $0DA0, X
    LDA.w Pool_Soldier_x_checked_directions, Y : STA.w $0D50, X
    LDA.w Pool_Soldier_y_checked_directions, Y : STA.w $0D40, X
    
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0E10, X : BEQ .alpha
        CMP.b #$2C : BNE .beta
            LDY.w $0DA0, X
            LDA.w Pool_Soldier_orthogonal_next_direction, Y : STA.w $0DA0, X
            
            BRA .beta
    
    .alpha
    
    LDY.w $0DA0, X
    LDA.w $0E70, Y : AND.w Pool_Soldier_orthogonal_directions, Y : BNE .beta
        LDA.b #$58 : STA.w $0E10, X
    
    .beta
    
    LDY.w $0DA0, X
    LDA.w $0E70, Y : AND.w Pool_Soldier_collinear_directions, Y : BEQ .gamma
        LDA.w Pool_Soldier_collinear_next_direction, Y : STA.w $0DA0, X
    
    .gamma
    
    LDY.w $0DA0, X
    LDA.w Pool_Soldier_chase_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Soldier_chase_y_speeds, Y : STA.w $0D40, X
    LDA.w Pool_Soldier_ProbeType, Y      : STA.w $0DE0, X 
                                           STA.w $0EB0, X
    
    JMP.w Guard_TickAndUpdateBody
}

; $02C403-$02C46F JUMP LOCATION
Guard_OnPatrol:
{
    JSR.w Sprite_SpawnProbeStaggered
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCC .alpha
        JMP.w Guard_ShootProbeAndStuff
    
    .alpha
    
    LDA.w $0DF0, X : BNE Guard_OnPatrol_delay
        ; Bleeds into the next function.
}
    
; $02C417-$02C424 JUMP LOCATION
Guard_StopAndLookAround:
{
    JSR.w Sprite2_ZeroVelocity
    
    LDA.b #$02 : STA.w $0D80, X
    LDA.b #$A0 : STA.w $0DF0, X
    
    RTS
}

; $02C425-$02C453 JUMP LOCATION
Guard_OnPatrol_delay:
{
    LDA.w $0E80, X : AND.b #$01 : BNE .gamma
        INC.w $0DF0, X

    .gamma

    LDA.w $0E70, X : AND.b #$0F : BEQ .delta
        LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
        
        JSR.w Soldier_EnableDirectionLock

    .delta

    LDY.w $0DE0, X
    LDA.w Soldier_x_speeds, Y : STA.w $0D50, X
    LDA.w Soldier_y_speeds, Y : STA.w $0D40, X
    
    TYA : STA.w $0EB0, X
    
    INC.w $0E80, X

    ; Bleeds into the next function.
}

; $02C454-$02C46F LOCAL JUMP LOCATION
Guard_TickAndUpdateBody:
{
    INC.w $0E80, X
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : STA.b $00
    
    LDA.w $0DE0, X : ASL : ASL : ADC.b $00 : TAY
    LDA.w Soldier_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02C470-$02C48F DATA
Soldier_head_looking_states:
{
    db $00, $02, $02, $02, $00, $03, $03, $03 ; Up
    db $01, $03, $03, $03, $01, $02, $02, $02 ; Down
    db $02, $00, $00, $00, $02, $01, $01, $01 ; Left
    db $03, $01, $01, $01, $03, $00, $00, $00 ; Right
}

; $02C490-$02C4C0 JUMP LOCATION
Guard_Surveying:
{
    JSR.w Sprite2_ZeroVelocity
    JSR.w Sprite_SpawnProbeStaggered
    
    LDA.w $0DF0, X : BNE .alpha
        LDA.b #$20 : STA.w $0DF0, X
        
        LDA.b #$00 : STA.w $0D80, X
        
        RTS
        
    .alpha
    
    CMP.b #$80 : BCS .beta
        LSR #3 : AND.b #$07 : STA.b $00
        
        LDA.w $0DE0, X : ASL #3 : ORA.b $0000 : TAY
        LDA.w Soldier_head_looking_states, Y : STA.w $0EB0, X
    
    .beta	
    
    RTS
}

; Green soldier submode 3
; $02C4C1-$02C4D6 JUMP LOCATION
Guard_NoticeKouhai:
{
    JSR.w Sprite2_ZeroVelocity
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X
    
    LDA.w $0DF0, X : BNE Guard_SetTimerAndAssertTileHitbox_exit
        LDA.b #$04 : STA.w $0D80, X
        
        LDA.b #$FF

        ; Bleeds into the next function.
}
        
; $02C4D7-$02C4E7 JUMP LOCATION
Guard_SetTimerAndAssertTileHitbox:
{
    STA.w $0DF0, X
        
    STZ.w $0E30, X
        
    LDA.w $0B6B, X : AND.b #$0F : ORA.b #$60 : STA.w $0B6B, X
    
    ; $02C4E7 ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; $02C4E8-$02C4F8 JUMP LOCATION
Guard_InPursuit:
{
    LDA.w $0DF0, X : BNE .delay
        LDY.w $0DE0, X
        
        LDA JavelinTrooper_Attack_scan_anbles, X : STA.w $0EC0, X
        
        BRL Guard_StopAndLookAround
}

; ==============================================================================

; $02C4F9-$02C4FF LOCAL JUMP LOCATION
Sprite2_ZeroVelocity:
{
    ; Stop horizontal and vertical velocities.
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    RTS
}

; ==============================================================================

; $02C500-$02C534 LOCAL JUMP LOCATION
Guard_InPursuit_delay:
{
    TYA : EOR.b $1A1A : AND.b #$1F : BNE .alpha
        LDA.w $0ED0, X : BNE .beta
            LDA.b #$04 : JSL.l Sound_SetSfx3PanLong
            
            INC.w $0ED0, X
        
        .beta
        
        TXA : AND.b #$03 : TAY
        
        LDA.w $0E20, X : CMP.b #$42 : BEQ .gamma
            ; OPTIMIZE: Useless branch.
        .gamma
        
        LDA.w AppliedSpeed16, X
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        JSR.w Sprite2_DirectionToFacePlayer
        TYA : STA.w $0DE0, X
              STA.w $0EB0, X
    
    .alpha
    
    JSL.l Probe_SetDirectionTowardsPlayer

    ; Bleeds into the next function.
}

; $02C535-$02C53B LOCAL JUMP LOCATION
Guard_TickTwiceAndUpdateBody:
{
    INC.w $0E80, X
    
    JSR.w Guard_TickAndUpdateBody
    
    RTS
}

; ==============================================================================

; $02C53C-$02C541 DATA
Pool_Probe_SetDirectionTowardsPlayer:
Pool_Sprite_PsychoSpearSoldier:
Pool_Sprite_PsychoTrooper:
{
    ; $02C53C
    .x_speeds ; Length 4
    db $0E, $F2
    
    ; ; $02C53E
    .y_speeds
    db $00, $00, $0E, $F2
}

; $02C542-$02C565 LONG JUMP LOCATION
Probe_SetDirectionTowardsPlayer:
{
    PHB : PHK : PLB
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        AND.b #$03 : BEQ .no_horiz_collision
            JSR.w Sprite2_IsBelowPlayer : INY #2 : BRA .moving_on
        
        .no_horiz_collision
        
        JSR.w Sprite2_IsToRightOfPlayer
        
        .moving_on
        
        LDA.w Pool_Probe_SetDirectionTowardsPlayer_x_speeds, Y : STA.w $0D50, X
        LDA.w Pool_Probe_SetDirectionTowardsPlayer_y_speeds, Y : STA.w $0D40, X
    
    .no_tile_collision
    
    PLB
    
    RTL
}

; ==============================================================================

; $02C566-$02C569 DATA
AppliedSpeed16:
{
    db $10, $10, $10, $10
}

; $02C56A-$02C56D DATA
AppliedSpeed18:
{
    db $12, $12, $12, $12
}
    
; $02C56E-$02C5F1 DATA
Pool_Guard_SendOutProbe:
{
    ; $02C56E
    .speed_x
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    db $F0, $F2, $F4, $F6, $F8, $FA, $FC, $FE
    
    db $00, $02, $04, $06, $08, $0A, $0C, $0E
    db $10, $10, $10, $10, $10, $10, $10, $10
    
    db $10, $10, $10, $10, $10, $10, $10, $10
    db $0E, $0C, $0A, $08, $06, $04, $02, $00
    
    db $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    
    ; $02C5AE
    .speed_y
    db $00, $02, $04, $06, $08, $0A, $0C, $0E
    db $10, $10, $10, $10, $10, $10, $10, $10
    
    db $10, $10, $10, $10, $10, $10, $10, $10
    db $0E, $0C, $0A, $08, $06, $04, $02, $00
    
    db $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    db $F2, $F4, $F6, $F8, $FA, $FC, $FE, $00
    
    ; $02C5EE
    .index_offset
    db $10, $30, $00, $20
}

; Soldiers and Archers seem to be the only two types that call this.
; Beamos and Blind call the alternate entry point...
; $02C5F2-$02C611 LOCAL JUMP LOCATION
Sprite_SpawnProbeStaggered:
{
    ; TODO: Investigate this:
    ; Is there some point to this store that I'm not seeing? It's
    ; overwritten later before even being used.
    TXA : CLC : ADC.b $1A1A : STA.b $0F
    
    AND.b #$03 : ORA.w $0F00, X : BNE Sprite_SpawnProbeAlways_spawn_failed
        LDA.w $0EC0, X
        INC.w $0EC0, X
        
        LDY.w $0DE0, X
        CLC : AND.b #$1F : ADC.w Pool_Guard_SendOutProbe_index_offset, Y
        AND.b #$3F : STA.b $0F

        ; Bleeds into the next function.
}
    
; $02C612-$02C66D LOCAL JUMP LOCATION
Sprite_SpawnProbeAlways:
{
    LDA.b #$41  ; If any of our sprites are dead, change it to a soldier.
    LDY.b #$0A  ; We'll be checking sprites in slots 0x00 through 0x0A.
    
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$08 : STA.w $0D10, Y
        LDA.b $01 :       ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $0202 : CLC : ADC.b #$04 : STA.w $0D00, Y
        LDA.b $03 :         ADC.b #$00 : STA.w $0D20, Y
        
        PHX
        
        ; The direction the statue sentry eye is facing determines the direction
        ; that the feeler will travel in.
        LDX.b $0F : TXA
                    STA.w $0DE0, Y
        LDA.w Pool_Guard_SendOutProbe_speed_x, X : STA.w $0D50, Y
        LDA.w Pool_Guard_SendOutProbe_speed_y, X : STA.w $0D40, Y
        
        LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$A0 : STA.w $0E40, Y
        
        PLX
        
        TXA : INC : STA.w $0DB0, Y
                    STA.w $0BA0, Y
        
        LDA.b #$40 : STA.w $0F60, Y
                     STA.w $0E60, Y
        
        LDA.b #$02 : STA.w $0CAA, Y
        
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $02C66E-$02C675 LONG JUMP LOCATION
Sprite_SpawnProbeAlwaysLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SpawnProbeAlways
    
    PLB
    
    RTL
} 

; ==============================================================================

; $02C676-$02C67F LONG JUMP LOCATION
Soldier_AnimateMarionetteTempLong:
{
    PHB : PHK : PLB
    
    PHX
    
    JSR.w Guard_HandleAllAnimation
    
    PLX
    
    PLB
    
    RTL
}

; $02C680-$002C68B LOCAL JUMP LOCATION
Guard_HandleAllAnimation:
{
    JSR.w Sprite2_PrepOamCoord
    JSR.w Guard_AnimateHead
    JSR.w Guard_AnimateBody
    JSR.w Guard_AnimateWeapon

    ; Bleeds into the next function.
}

; $02C68C-$02C6A1 LOCAL JUMP LOCATION
Guard_DrawShadow:
{
    LDA.w $0E60, X : AND.b #$10 : BEQ .alpha
        LDY.w $0DE0, X
        LDA.w .shadow_types, Y
        JSL.l Sprite_DrawShadowLong_variable
    
    .alpha
    
    RTS
    
    .shadow_types
    db $0C, $0C, $0A, $0A
}

; $02C6A2-$02C6DD LOCAL JUMP LOCATION
Pool_Guard:
{
    ; $02C6A2
    .headChar
    db $42, $42, $40, $44

    ; $02C6A6
    .headProperties
    db $40, $00, $00, $00
    
    ; $02C6AA
    .headYOffset
    dw 0007, 0008, 0007, 0008
    dw 0008, 0007, 0008, 0007
    dw 0008, 0007, 0008, 0008
    dw 0007, 0008, 0008, 0008
    dw 0008, 0008, 0008, 0008
    dw 0008, 0008, 0008, 0008
    dw 0008, 0008
}

; $02C6DE-$02C72C LOCAL JUMP LOCATION
Guard_AnimateHead:
{
    LDY.b #$00
    
    ; $02C6E0 ALTERNATE ENTRY POINT
    .PreserveOAMOffset
    
    PHX
    
    LDA.w $0DC0, X : ASL : STA.b $0D
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00    : STA.b ($90), Y
    AND.w #$0100 : STA.b $0E
    
    PHY
    
    LDA.b $02
    
    SEC
    
    LDY.b $0D
    SBC.w Pool_Guard_headYOffset, Y
    
    PLY : INY
    STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
        LDA.w #$00F0 : STA.b ($90), Y
    
    .alpha
    
    SEP #$20
    
    LDA.w Pool_Guard_headChar, X       : INY             : STA ($90), Y
    LDA.w Pool_Guard_headProperties, X : INY : ORA.b $05 : STA ($90), Y
    
    TYA : LSR #2 : TAY
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    RTS
}

; ==============================================================================

; $02C72D-$02CA08 DATA
Pool_GuardBody:
{
    ; $02C72D
    .ObjectOffsetX
    dw  -4,   4,  10,  10
    dw  -4,   4,  10,  10
    dw  -4,   4,  10,  10
    dw  -4,   4,  10,  10
    dw  -4,  -4,   0,   0
    dw  -4,  -4,   0,   0
    dw  -3,  -3,   0,   0
    dw  -3,  -3,  -4,   4
    dw  -3,  -3,  -4,   4
    dw  -3,  -3,  -4,   4
    dw  -3,  -3,  -4,   4
    dw  12,  12,   0,   0
    dw  12,  12,   0,   0
    dw  11,  11,   0,   0
    dw  -4,   4,   0,   0
    dw  -4,   4,   0,   0
    dw  -4,   4,   0,   0
    dw   0,   0,   0,   0
    dw   0,   0,   0,   0
    dw   0,   0,   0,   0
    dw  -4,   4,   0,   0
    dw  -4,   4,   0,   0
    dw  -4,   4,   0,   0
    dw   0,   0,   0,   0
    dw   0,   0,   0,   0
    dw   0,   0,   0,   0

    ; $02C7FD
    .ObjectOffsetY
    dw   0,   0,   2,  10
    dw   0,   0,   2,  10
    dw   0,   0,   1,   9
    dw   0,   0,   2,  10
    dw  -2,   6,   1,   1
    dw  -2,   6,   2,   2
    dw  -2,   6,   1,   1
    dw  -5,   3,   0,   0
    dw  -4,   4,   0,   0
    dw  -4,   4,   0,   0
    dw  -5,   3,   0,   0
    dw  -2,   6,   1,   1
    dw  -2,   6,   2,   2
    dw  -2,   6,   1,   1
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8
    dw   0,   0,   8,   8

    ; $02C8CD
    .ObjectChar
    db $48, $49, $6D, $7D
    db $49, $48, $6D, $7D
    db $46, $46, $6D, $7D
    db $4B, $46, $6D, $7D
    db $4D, $5D, $4E, $4E
    db $4D, $5D, $60, $60
    db $4D, $5D, $62, $62
    db $6D, $7D, $64, $64
    db $6D, $7D, $66, $67
    db $6D, $7D, $67, $66
    db $6D, $7D, $64, $69
    db $4D, $5D, $4E, $4E
    db $4D, $5D, $60, $60
    db $4D, $5D, $62, $62
    db $02, $03, $20, $20
    db $02, $0C, $20, $20
    db $02, $0C, $20, $20
    db $08, $08, $20, $20
    db $0E, $0E, $20, $20
    db $0E, $0E, $20, $20
    db $05, $06, $20, $20
    db $22, $06, $20, $20
    db $22, $06, $20, $20
    db $08, $08, $20, $20
    db $0E, $0E, $20, $20
    db $0E, $0E, $20, $20

    ; $02C935
    .ObjectFlip
    db $00, $00, $00, $00
    db $40, $40, $00, $00
    db $00, $40, $00, $00
    db $00, $40, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $40
    db $00, $00, $00, $00
    db $00, $00, $40, $40
    db $00, $00, $00, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40

    ; $02C99D
    .ObjectSize
    db $02, $02, $00, $00
    db $02, $02, $00, $00
    db $02, $02, $00, $00
    db $02, $02, $00, $00
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $00, $00, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02

    ; $02CA05
    .OAMOffsets
    db $0C
    db $0C
    db $0C
    db $04
}

; $02CA09-$02CAB7 LOCAL JUMP LOCATION
Guard_AnimateBody:
{
    LDY.w $0DE0, X
    LDA.w Pool_GuardBody_OAMOffsets, Y : TAY
    
    ; $02CA10
    .PreserveOAMOffset

    LDA.w $0DC0, X : ASL #2 : STA.b $07
    LDA.w $0E20, X          : STA.b $08
    
    PHX
    
    LDX.b #$03
    
    ; $02CA1F ALTERNATE ENTRY POINT
    .next_object
    
    PHX
    
    TXA : CLC : ADC.b $07 : TAX : STX.b $06
    
    LDA.b $08 : CMP.b #$46 : BCC .alpha
        LDA.w Pool_GuardBody_ObjectSize, X : BEQ .beta
            LDA.w Pool_GuardBody_ObjectChar, X
            
            PLX : PHX
            CPX.b #$03 : BNE .alpha
                CMP.b #$20 : BEQ .beta
    
    .alpha
    
    LDA.b $06 : ASL : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w Pool_GuardBody_ObjectOffsetX, X : STA.b ($90), Y
    AND.w #$0100                                            : STA.b $0E
    
    LDA.b $02 : CLC : ADC.w Pool_GuardBody_ObjectOffsetY, X : INY : STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .gamma
        LDA.w #$00F0 : STA.b ($90), Y
    
    .gamma
    
    SEP #$20
    
    LDA.w #$08 : STA.b $0D
    
    LDX.b $06
    LDA.w Pool_GuardBody_ObjectChar, X : INY : STA.b ($90), Y
    CMP.b #$20 : BNE .delta
        LDA.b #$02 : STA.b $0D
        
        LDA.b $0808 : CMP.b #$46 : CLC : BNE .epsilon
            DEY
            LDA.b #$F0 : STA.b ($90), Y
            
            INY
            
            BRA .epsilon
    
    .delta
    
    ; WTF: OPTIMIZE: what is this for? Is this half a check that was supposed to
    ; be removed?
    LDA.w Pool_GuardBody_ObjectSize, X : CMP.b #$01
    
    .epsilon
    
    LDA.w Pool_GuardBody_ObjectFlip, X : ORA.b $05 : BCS .zeta
        AND.b #$F1 : ORA.b $0D
    
    .zeta
    
    INY
    STA.b ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    LDA.w Pool_GuardBody_ObjectSize, X : ORA.b $0F0F : STA ($92), Y
    
    PLY : INY
    
    .beta
    
    PLX : DEX : BMI .theta
        JMP.w Guard_AnimateBody_next_object
    
    .theta
    
    PLX
    
    RTS
}

; $02CAB8-$02CB63 DATA
GuardWeaponObject:
{
    ; $02CAB8
    .OffsetX
    dw  -3,  -3
    dw  -4,  -4
    dw  -4,  -4
    dw  -4,  -4
    dw -11,  -3
    dw -11,  -3
    dw -16,  -8
    dw  12,  12
    dw  12,  12
    dw  12,  12
    dw  12,  12
    dw  21,  13
    dw  21,  13
    dw  24,  16

    ; $02CAF0
    .OffsetY
    dw  11,  19
    dw  11,  19
    dw  10,  18
    dw  14,  22
    dw   8,   8
    dw   8,   8
    dw   6,   6
    dw -10,  -2
    dw  -9,  -1
    dw  -9,  -1
    dw -16,  -8
    dw   8,   8
    dw   8,   8
    dw   6,   6

    ; $02CB28
    .Char
    db $7B, $6B
    db $7B, $6B
    db $7B, $6B
    db $7B, $6B
    db $6C, $7C
    db $6C, $7C
    db $6C, $7C
    db $6B, $7B
    db $6B, $7B
    db $6B, $7B
    db $6B, $7B
    db $6C, $7C
    db $6C, $7C
    db $6C, $7C

    ; $02CB44
    .Flip
    db $80, $80
    db $80, $80
    db $80, $80
    db $80, $80
    db $00, $00
    db $00, $00
    db $00, $00
    db $00, $00
    db $00, $00
    db $00, $00
    db $00, $00
    db $40, $40
    db $40, $40
    db $40, $40

    ; $02CB60
    .OAMOffset
    db $04
    db $04
    db $04
    db $14
}

; $02CB64-$02CBDF LOCAL JUMP LOCATION
Guard_AnimateWeapon:
{
    LDA.w $0DC0, X : ASL : STA.b $06
    
    LDA.w $0E20, X : SEC : SBC.b #$41 : STA.b $08
    
    LDY.w $0DE0, X
    LDA.w GuardWeaponObject_OAMOffset, Y : TAY
    
    PHX
    
    LDX.b #$01
    
    .gamma
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.w GuardWeaponObject_OffsetX, X : CLC : ADC.b $0000 : STA ($90), Y
        AND.w #$0100                                           : STA.b $0E
        
        LDA.w GuardWeaponObject_OffsetY, X : CLC : ADC.b $02 : INY : STA ($90), Y
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
            LDA.w #$00F0 : STA ($90), Y
        
        .alpha
        
        SEP #$20
        
        LDA.w GuardWeaponObject_OffsetX, X : STA.w $0FAB
        LDA.w GuardWeaponObject_OffsetY, X : STA.w $0FAA
        
        PLX
        
        ; WTF: OPTIMIZE: what is this for? Is this half a check that was supposed
        ; to be removed?
        LDA.b $08 : CMP.b #$02
        
        LDA.w GuardWeaponObject_Char, X : BCS .beta
            ADC.b #$03
        
        .beta
        
        INY
        STA ($90), Y
        
        LDA.w GuardWeaponObject_Flip, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================

; $02CBE0-$02CC3B JUMP LOCATION
Sprite_PsychoSpearSoldier:
{
    JSR.w Guard_HandleAllAnimation
    JSR.w Sprite2_CheckIfActive
    JSR.w PsychoSpearSoldier_PlayChaseMusic
    JSL.l Guard_ParrySwordAttacks
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_MoveIfNotTouchingWall
    JSR.w Sprite2_CheckTileCollision
    JSL.l Sprite_CheckDamageToPlayerLong
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .no_direction_change
        JSR.w Sprite2_DirectionToFacePlayer
        TYA : STA.w $0EB0, X
              STA.w $0DE0, X
        
        TXA : AND.b #$03 : TAY
        LDA.w AppliedSpeed18, Y
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.w $0E70, X : BEQ .no_direction_change
            AND.b #$03 : BEQ .horizontal_tile_collision
                JSR.w Sprite2_IsBelowPlayer
                
                INY #2
                
                BRA .gamma
            
            .horizontal_tile_collision
            
            JSR.w Sprite2_IsToRightOfPlayer
            
            .gamma
            
            LDA.w .x_speeds, Y : STA.w $0D50, X
            LDA.w .y_speeds, Y : STA.w $0D40, X
    
    .no_direction_change
    
    INC.w $0E80, X
    
    JSR.w Guard_TickAndUpdateBody
    
    RTS
}

; ==============================================================================

; $02CC3C-$02CC64 LOCAL JUMP LOCATION
PsychoSpearSoldier_PlayChaseMusic:
{
    LDA.w $0ED0, X : CMP.b #$10 : BEQ .no_change
        INC.w $0ED0, X : CMP.b #$0F : BNE .no_change
            LDA.b #$04
            JSL.l Sound_SetSfx3PanLong
            
            LDA.l $7EF3C5 : CMP.b #$02 : BNE .no_change
                LDA.w $040A : CMP.b #$18 : BNE .no_change
                    LDA.b #$0C : STA.w $012C

    .no_change
    .alpha
    
    RTS
}

; ==============================================================================

; $02CC65-$02CCD4 JUMP LOCATION
Sprite_PsychoTrooper:
{
    JSR.w SpriteDraw_BluesainBolt
    JSR.w Sprite2_CheckIfActive
    JSR.w PsychoSpearSoldier_PlayChaseMusic
    JSL.l Guard_ParrySwordAttacks
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_MoveIfNotTouchingWall
    JSR.w Sprite2_CheckTileCollision
    JSL.l Sprite_CheckDamageToPlayerLong
    
    TXA : EOR.b $1A : AND.v #$0F : BNE .alpha
        JSR.w Sprite2_DirectionToFacePlayer
        TYA : STA.w $0EB0, X
              STA.w $0DE0, X
        
        TXA : AND.b #$03 : TAY
        LDA.w AppliedSpeed18, Y
        
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.w $0E70, X : BEQ .alpha
            AND.b #$03 : BEQ .beta
                JSR.w Sprite2_IsBelowPlayer
                
                INY #2
                
                BRA .gamma
                
            .beta
            
            JSR.w Sprite2_IsToRightOfPlayer
            
            .gamma
            
            LDA.w .x_speeds, Y : STA.w $0D50, X
            LDA.w .y_speeds, Y : STA.w $0D40, X
    
    .alpha
    
    LDA.w $0DE0, X : ASL #3 : STA.b $00
    
    INC.w $0E80, X
    LDA.w $0E80, X : LSR : AND.b #$07 : ORA.b $00 : TAY
    LDA.w Pool_Sprite_PsychoTrooper_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02CCD5-$02CCE7 LOCAL JUMP LOCATION
SpriteDraw_BluesainBolt:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$0C
    JSR.w SpriteDraw_GuardHead
    
    LDY.b #$08
    JSR.w SpriteDraw_GuardBody
    
    JSR.w SpriteDraw_GuardSpear_Bolt

    JMP.w Guard_DrawShadow
}

; ==============================================================================

; $02CCE8-$02CD47 DATA
Pool_SpriteDraw_GuardSpear:
{
    ; $02CCE8
    .offset_x
    dw  15,   7
    dw  17,   9
    dw  -8,   0
    dw -10,  -2
    dw  13,  13
    dw  13,  13
    dw  -4,  -4
    dw  -4,  -4

    ; $02CD08
    .offset_y
    dw  -2,  -2
    dw  -2,  -2
    dw  -2,  -2
    dw  -2,  -2
    dw   8,   0
    dw  10,   2
    dw -14,  -6
    dw -16,  -8

    ; $02CD28
    .char
    db $6F, $7F
    db $6F, $7F
    db $6F, $7F
    db $6F, $7F
    db $6E, $7E
    db $6E, $7E
    db $6E, $7E
    db $6E, $7E

    ; $02CD38
    .flip
    db $40, $40
    db $40, $40
    db $00, $00
    db $00, $00
    db $80, $80
    db $80, $80
    db $00, $00
    db $00, $00
}

; $02CD48-$02CDD3 LOCAL JUMP LOCATION
SpriteDraw_GuardSpear:
{
    .Fresh

    LDY.b #$00
    
    ; $02CD4A ALTERNATE ENTRY POINT
    .PreserveOAMOffset
    
    LDA.w $0D90, X
    
    BRA .alpha
    
    ; $02CD4F ALTERNATE ENTRY POINT
    .Bolt
    
    LDA.w $0D90, X
    
    LDY.b #$00
    
    .alpha
    
    EOR.b #$01 : ASL : AND.b #$02 : STA.b $06
    
    LDA.w $0E20, X : STA.b $08
    
    LDA.w $0DE0, X : ASL #2 : ORA.b $06 : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .delta
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        ASL                   : TAX
        
        REP #$20
        
        LDA.w Pool_SpriteDraw_GuardSpear_offset_x, X
        CLC : ADC.b $00 : STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.w Pool_SpriteDraw_GuardSpear_offset_y, X
        CLC : ADC.b $0202 : INY : STA.b ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .beta
            LDA.w #$00F0 : STA.b ($90), Y
        
        .beta
        
        SEP #$20
        
        LDA.w Pool_SpriteDraw_GuardSpear_offset_x, X : STA.w $0FAB
        LDA.w Pool_SpriteDraw_GuardSpear_offset_y, X : STA.w $0FAA
        
        PLX
        
        LDA.b $0808 : CMP.b #$48 : LDA.w Pool_SpriteDraw_GuardSpear_char, X : BCC .gamma
            SBC.b #$03
        
        .gamma
        
                                              INY : STA ($90), Y

        LDA.w Pool_SpriteDraw_GuardSpear_flip, X
        ORA.b $05 : AND.b #$F1 : ORA.b #$08 : INY : STA ($90), Y
        
        PLX
        
        PHY : TYA : LSR #2 : TAY
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
    DEX : BPL .delta
    
    PLX
    
    RTS
}

; ==============================================================================

; $02CDD4-$02CDDC LOCAL JUMP LOCATION
Sprite2_MoveIfNotTouchingWall:
{
    LDA.w $0E70, X : BNE .alpha
        JMP.w Sprite2_Move
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02CDDD-$02CDE0 DATA
Sprite_JavelinTrooper_animation_states:
{
    db $0C, $00, $12, $08
}

; $02CDE1-$02CDFE JUMP LOCATION
Sprite_JavelinTrooper:
{
    LDA.w $0DC0, X : PHA
    LDY.w $0DE0, X : PHY
    
    LDA.w $0E00, X : BEQ .direction_lock_inactive
        LDA.w Soldier_DirectionLockSettings_directions, Y : STA.w $0DE0, X
        
        LDA.w .animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    JSR.w JavelinTrooper_Draw
    
    BRA ArcherAndJavelinGuardMain
}
    
; $02CDFF-$02CE73 JUMP LOCATION
Sprite_ArcherSoldier:
{
    LDA.w $0DC0, X : PHA
    LDY.w $0DE0, X : PHY
    
    LDA.w $0E00, X : BEQ .direction_lock_inactive_2
        LDA.w Soldier_DirectionLockSettings_directions, Y : STA.w $0DE0, X
        
        LDA.w Soldier_DirectionLockSettings_animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive_2
    
    JSR.w ArcherSoldier_Draw

    ; Bleeds into the next function.
}

; $02CE1B-$02CE73 JUMP LOCATION
ArcherAndJavelinGuardMain:
{
    PLA : STA.w $0DE0, X
    PLA : STA.w $0DC0, X
    
    JSR.w Sprite2_CheckIfActive
    
    JSR.w Sprite2_CheckDamage : BCS .gamma
        LDA.w $0FDC : BEQ .delta
    
    .gamma
    
    LDA.w $0D80, X : CMP.b #$03 : BCS .delta
        LDA.b #$03 : STA.w $0D80, X
        LDA.b #$20 : STA.w $0DF0, X
    
    .delta
    
    LDA.w $0EA0, X : BEQ .not_recoiling
    CMP.b #$04     : BCC .not_recoiling
    
        JSR.w JavelinTrooper_NoticedPlayer_no_delay
    
    .not_recoiling
    
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_MoveIfNotTouchingWall
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w .states, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    .states
    dw JavelinTrooper_Resting
    dw JavelinTrooper_WalkingAround
    dw JavelinTrooper_LookingAround
    dw JavelinTrooper_NoticedPlayer
    dw JavelinTrooper_Agitated
    dw JavelinTrooper_Attack
}

; ==============================================================================

; $02CE74-$02CEA9 LOCAL JUMP LOCATION
JavelinTrooper_Resting:
{
    JSR.w Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$7F : ADC.b #$50 : STA.w $0DF0, X
        
        LDA.w $0DE0, X : PHA
        
        JSL.l GetRandomInt : AND.b #$03 : STA.w $0DE0, X
        
        PLA : CMP.w $0DE0, X : BEQ .no_direction_change
            EOR.w $0DE0, X : AND.b #$02 : BNE .no_direction_lock
                LDA.b #$0C : STA.w $0E00, X
            
            .no_direction_lock
        .no_direction_change
    .delay
    
    RTS
}

; ==============================================================================

; $02CEAA-$02CF12 LOCAL JUMP LOCATION
JavelinTrooper:
{
    .WalkingAround

    LDA.w $0DF0, X : BNE .delay
        LDA.b #$02 : STA.w $0D80, X
        
        LDA.b #$A0 : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    JSR.w Sprite_SpawnProbeStaggered
    
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
        LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
        
        JSR.w Soldier_EnableDirectionLock
        
    .no_tile_collision
    
    LDY.w $0DE0, X
    LDA Soldier_x_speeds, Y : STA.w $0D50, X
    LDA Soldier_y_speeds, Y : STA.w $0D40, X
    
    TYA : STA.w $0EB0, X
    
    ; $02CEE2 ALTERNATE ENTRY POINT
    .Animate:
    
    INC.w $0E80, X
    LDA.w $0E80, X : AND.b #$0F : BNE .gamma
        INC.w $0D90, X
        LDA.w $0D90, X : CMP.b #$02 : BNE .gamma
            STZ.w $0D90, X
    
    .gamma
    
    LDA.w $0DE0, X : ASL #2 : ADC.w $0D90, X
    
    LDY.w $0E20, X : CPY.b #$48 : BNE .is_archer
        CLC : ADC.b #$10
    
    .is_archer
    
    TAY
    LDA.w Soldier_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02CF13-$02CF43 LOCAL JUMP LOCATION
JavelinTrooper_LookingAround:
{
    JSR.w Sprite2_ZeroVelocity
    JSR.w Sprite_SpawnProbeStaggered
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$20 : STA.w $0DF0, X
        LDA.b #$00 : STA.w $0D80, X
        
        RTS
    
    .delay
    
    CMP.b #$80 : BCS .mucho_time_left
        LSR #3 : AND.b #$07 : STA.b $00
        
        LDA.w $0DE0, X : ASL #3 : ORA.b $0000 : TAY
        LDA.w Soldier_head_looking_states, Y : STA.w $0EB0, X
    
    .mucho_time_left
    
    RTS
}

; ==============================================================================

; $02CF44-$02CF60 LOCAL JUMP LOCATION
JavelinTrooper_NoticedPlayer:
{
    JSR.w Sprite2_ZeroVelocity
    
    JSR.w Sprite2_DirectionToFacePlayer
    
    TYA : STA.w $0EB0, X
    
    LDA.w $0DF0, X : BNE .delay
        ; $02CF53 ALTERNATE ENTRY POINT
        .no_delay
        
        LDA.b #$04 : STA.w $0D80, X
        LDA.b #$3C : STA.w $0DF0, X
        
        STZ.w $0E80, X
    
    .delay:
    
    RTS
}

; ==============================================================================

; $02CF61-$02CF84 DATA
Pool_JavelinTrooper_Agitated:
{
    ; $02CF61
    .x_offsets_low
    db $B0, $50, $00, $F8
    db $B0, $50, $F8, $08
    
    ; $02CF69
    .x_offsets_high
    db $FF, $00, $00, $FF
    db $FF, $00, $FF, $00
    
    ; $02CF71
    .y_offsets_low
    db $08, $08, $B0, $50
    db $08, $08, $B0, $50
    
    ; $02CF79
    .y_offsets_high
    db $00, $00, $FF, $00
    db $00, $00, $FF, $00
    
    ; $02CF81
    .tile_collision_masks
    db $03, $03, $0C, $0C
}

; $02CF85-$02D000 LOCAL JUMP LOCATION
JavelinTrooper_Agitated:
{
    LDY.w $0DE0, X
    
    LDA.w $0E70, X : AND .tile_collision_masks, Y : BNE .collided
        LDA.w $0DF0, X : BNE .delay
    
    .collided
    
    INC.w $0D80, X
    
    LDA.b #$18 : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    TXA : EOR.b $1A1A : AND.b #$07 : BNE .delay_facing_player
        JSR.w Sprite2_DirectionToFacePlayer
        TYA : STA.w $0DE0, X
              STA.w $0EB0, X
        
        LDA.w $0E20, X : CMP.b #$48 : BNE .is_archer
            INY #4
        
        .is_archer
        
        LDA.b $2222 : CLC : ADC.w .x_offsets_low, Y  : STA.b $04
        LDA.b $23         : ADC.w .x_offsets_high, Y : STA.b $05
        
        LDA.b $20 : CLC : ADC.w .y_offsets_low, Y  : STA.b $06
        LDA.b $21       : ADC.w .y_offsets_high, Y : STA.b $07
        
        LDA.b #$18
        
        JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        
        LDA.b $01 : STA.w $0D50, X
        
        LDA.b $0E : CLC : ADC.b #$06 : CMP.b #$0C : BCS .delay_facing_player
            LDA.b $0F : CLC : ADC.b #$06 : CMP.b #$0C : BCC .collided
    
    .delay_facing_player
    
    INC.w $0E80, X
    
    JSR.w JavelinTrooper_Animate
    
    RTS
}

; ==============================================================================

; $02D001-$02D044 DATA
Pool_JavelinTrooper_Attack:
{
    ; Archer Soldier's states
    ; $02D001
    .animation_states
    db $19, $19, $18, $18, $17, $17, $17, $17
    db $13, $13, $12, $12, $11, $11, $11, $11
    
    db $10, $10, $0F, $0F, $0E, $0E, $0E, $0E
    db $16, $16, $15, $15, $14, $14, $14, $14
    
    ; Javelin trooper's states
    ; $02D021
    db $14, $14, $12, $12, $12, $10, $10, $10
    db $15, $15, $08, $08, $08, $06, $06, $06
    
    db $16, $16, $04, $04, $04, $03, $03, $03
    db $17, $17, $0F, $0F, $0F, $0B, $0B, $0B
}

; $02D041-$02D044 DATA
Guard_GlanceTimers:
{ 
    db $0D, $0D, $0C, $0C
}

; ==============================================================================

; $02D045-$02D08A LOCAL JUMP LOCATION
JavelinTrooper_Attack:
{
    LDY.w $0DE0, X
    LDA Guard_GlanceTimers, Y : STA.w $0EC0, X
    
    JSR.w Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
        JMP.w Guard_StopAndLookAround
    
    .delay
    
    STZ.w $0E80, X
    
    CMP.b #$28 : BCC .beta
        DEC.w $0E80, X
    
    .beta
    
    CMP.b #$0C : BNE .gamma
        PHA
        
        JSR.w JavelinTrooper_SpawnProjectile
        
        PLA
        
    .gamma
    
    LSR #3 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $00
    
    LDY.w $0E20, X : CPY.b #$48 : BNE .is_archer
        CLC : ADC.b #$20
    
    .is_archer
    
    TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02D08B-$02D0C4 DATA
Pool_JavelinTrooper_SpawnProjectile:
{
    ; $02D08B
    .x_offsets_low
    db $10, $F8, $03, $0B
    db $0C, $FC, $0C, $FC
    
    ; $02D093
    .x_offsets_high
    db $00, $FF, $00, $00
    db $00, $FF, $00, $FF
    
    ; $02D09B
    .y_offsets_low
    db $02, $02, $10, $F8
    db $FE, $FE, $02, $F8
    
    ; $02D0A3
    .y_offsets_high
    db $00, $00, $00, $FF
    db $FF, $FF, $00, $FF
    
    ; $02D0AB
    .x_speeds ; Length 8
    db $30, $D0, $00, $00
    db $20, $E0
    
    ; $02D0B1
    .y_speeds
    db $00, $00, $30, $D0, $00, $00, $20, $E0
    db $03, $02, $01, $00, $03, $02, $01, $00
    
    ; $02D0C1
    .hit_boxes
    db $05, $05, $06, $06
}

; ==============================================================================

; $02D0C5-$02D140 LOCAL JUMP LOCATION
JavelinTrooper_SpawnProjectile:
{
    LDA.b #$1B : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$05 : JSL.l Sound_SetSfx3PanLong
        
        PHX
        
        LDA.w $0E20, X : CMP.b #$48
        LDA.w $0DE0, X : BCC .is_archer
            CLC : ADC.b #$04
        
        .is_archer
        
        TAX
        
        LDA.b $00 : CLC : ADC.w .x_offsets_low, X  : STA.w $0D10, Y
        LDA.b $0101     : ADC.w .x_offsets_high, X : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.w .y_offsets_low, X  : STA.w $0D00, Y
        LDA.b $03       : ADC.w .y_offsets_high, X : STA.w $0D20, Y
        
        LDA.w .x_speeds, X : STA.w $0D50, Y
        LDA.w .y_speeds, X : STA.w $0D40, Y
        
        TXA : AND.b #$03 : STA.w $0DE0, Y
                         : TAX
        
        LDA.w .hit_boxes, X : STA.w $0F60, Y
        
        LDA.b #$00 : STA.w $0F70, Y
        
        PLX
        
        LDA.w $0E20, X : CMP.b #$48
        LDA.b #$00 : BCC .is_archer_2
            INC

        .is_archer_2

        STA.w $0D90, Y : BEQ .dont_disable_blockability
            LDA.l $7EF35A : BNE .player_has_shield
                ; Make the arrow unblockable by shield (which is dumb, because we
                ; alraedy verified that the player doesn't have a shield).
                LDA.w $0BE0, Y : AND.b #$DF : STA.w $0BE0, Y

            .player_has_shield
        .dont_disable_blockability
    .spawn_failed

    RTS
}

; ==============================================================================

; $02D141-$02D191 LOCAL JUMP LOCATION
BushJavelinSoldier_Draw:
{
    LDA.w $0DC0, X : PHA
    
    STZ.w $0DC0, X
    
    LDA.w $0F50, X          : PHA
    AND.b #$F1 : ORA.b #$02 : STA.w $0F50, X
    
    REP #$20
    
    LDA.w $0FDA        : PHA
    CLC : ADC.w #$0008 : STA.w $0FDA
    
    SEP #$20
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    REP #$20
    
    PLA : STA.w $0FDA
    
    SEP #$20
    
    PLA : STA.w $0F50, X
    PLA : STA.w $0DC0, X
    
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$10
    JSR.w Guard_AnimateHead_PreserveOAMOffset
    
    LDY.b #$0C
    JSR.w SpriteDraw_GuardBody
    
    LDA.w $0DC0, X : CMP.b #$14 : BCS .alpha
        LDY.b #$04
        JSR.w SpriteDraw_GuardSpear_PreserveOAMOffset

    .alpha

    JMP.w Guard_DrawShadow
}

; ==============================================================================

; $02D192-$02D1AB LOCAL JUMP LOCATION
JavelinTrooper_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$0C
    JSR.w SpriteDraw_GuardHead
    
    LDY.b #$08
    JSR.w SpriteDraw_GuardBody
    
    LDA.w $0DC0, X : CMP.b #$14 : BCS .alpha
        JSR.w SpriteDraw_GuardSpear_Fresh

    .alpha

    JMP.w Guard_DrawShadow
}

; ==============================================================================

; $02D1AC-$02D1BE JUMP LOCATION
Sprite_BushJavelinSoldier:
{
    LDA.w $0D80, X : BEQ .alpha
        CMP.b #$02 : BNE .beta
            JSR.w BushJavelinSoldier_Draw
            
            BRA .alpha
        
        .beta
        
        JSR.w SpriteDraw_BushGuardBush
    
    .alpha
    
    BRA BushGuard_Main
}

; $02D1BF-$02D1D2 JUMP LOCATION
Sprite_BushArcherSoldier:
{
    LDA.w $0D80, X : BEQ BushGuard_Main
        LDA.w $0DC0, X : CMP.b #$0E : BCC .delta
            JSR.w ArcherSoldier_Draw
            
            BRA BushGuard_Main
        
        .delta
        
        JSR.w SpriteDraw_BushGuardBush

        ; Bleeds into the next function.
}

; $02D1D3-$02D1F4 JUMP LOCATION
BushGuard_Main:
{
    JSR.w Sprite2_CheckIfActive
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w .states, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    .states
    dw $D1F5 ; $2D1F5
    dw $D223 ; $2D223
    dw $D277 ; $2D277
    dw $D2CE ; $2D2CE
}

; $02D1F5-$02D202 JUMP LOCATION
BushGuard_Hiding:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$40 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02D203-$02D222 DATA
BushGuard_Emerging_animation_states:
{
    db 4, 4, 4, 4, 4, 4, 4, 4
    db 0, 1, 0, 1, 0, 1, 0, 1
    db 0, 1, 0, 1, 0, 1, 0, 1
    db 0, 1, 0, 1, 0, 1, 0, 1
}

; ==============================================================================

; $02D223-$02D251 JUMP LOCATION
BushGuard_Emerging:
{
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
        JSR.w Sprite2_DirectionToFacePlayer
        
        TYA : STA.w $0DE0, X
              STA.w $0EB0, X
        
        RTS
    
    .delay
    
    CMP.b #$20 : BNE .alpha
        PHA
        
        JSR.w BushGuard_SpawnFoliage
        
        PLA
        
    .alpha 
        
    LSR #2 : TAY    
    LDA.w BushGuard_Emerging_animation_states, Y : STA.w $0DC0, X
        
    RTS
}

; $02D252-$02D276 LOCAL JUMP LOCATION
BushGuard_SpawnFoliage:
{
    LDA.b #$EC
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$06 : STA.w $0DD0, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
        
        LDA.w $0E40, Y : CLC : ADC.b #$03 : STA.w $0E40, Y
        
        LDA.b #$02 : STA.w $0DB0, Y
    
    .spawn_failed
    
    RTS
}

; $02D277-$02D2BD JUMP LOCATION
BushGuard_Shoot:
{
    STZ.w $0BA0, X
    
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
        BRA BushGuard_Retreating

    .BRANCH_ALPHA

    STZ.w $0D90, X
    
    CMP.b #$28 : BCS .BRANCH_BETA
        DEC.w $0D90, X

    .BRANCH_BETA

    CMP.b #$10 : BNE .BRANCH_GAMMA
        PHA
        
        JSR.w JavelinTrooper_SpawnProjectile
        
        PLA

    .BRANCH_GAMMA

    LSR #3 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $00
    
    LDY.w $0E20, X : CPY.b #$49 : BNE .BRANCH_DELTA
        CLC : ADC.b #$20

    .BRANCH_DELTA

    TAY
    
    LDA.W JavelinTrooper_Attack_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; $02D2BE-$02D2CE DATA
BushGuard_Retreating_anim_step:
{
    db $00, $01, $00, $01, $00, $01, $00, $01
    db $00, $02, $03, $04, $04, $04, $04, $04
}

; $02D2CE-$02D2E8 JUMP LOCATION
BushGuard_Retreating:
{
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        STZ.w $0D80, X
        
        LDA.b #$40 : STA.w $0DF0, X
        
        RTS
        
    .BRANCH_ALPHA
    
    LSR #2 : TAY
    LDA.w BushGuard_Retreating_anim_step, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02D2E9-$02D320 DATA
Pool_SpriteDraw_BushGuardBush:
{
    ; $02D2E9
    .offset_y
    dw   8,   8
    dw   8,   8
    dw   2,   8
    dw   0,   8
    dw  -3,   8
    dw  -3,   8
    dw  -3,   8

    ; $02D305
    .char
    db $20, $20
    db $20, $20
    db $40, $20
    db $40, $20
    db $40, $20
    db $42, $20
    db $42, $20

    ; $02D313
    .prop
    db $09, $03
    db $49, $43
    db $09, $03
    db $49, $43
    db $09, $03
    db $49, $43
    db $09, $03
}

; $02D321-$02D380 LOCAL JUMP LOCATION
SpriteDraw_BushGuardBush:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_subsprite
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        ASL                   : TAX
        
        REP #$20
        
        LDA.b $00 : STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $0202 : CLC : ADC.w Pool_SpriteDraw_BushGuardBush_offset_y, X
        INY : STA.b ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
            LDA.w #$00F0 : STA.b ($90), Y
        
        .alpha
        
        SEP #$20
        
        PLX
        
        LDA.w Pool_SpriteDraw_BushGuardBush_char, X : INY : STA.b ($90), Y
        
        LDA.w Pool_SpriteDraw_BushGuardBush_prop, X : ORA.b #$20 : PLX : BNE .beta
            AND.b #$F1 : ORA.b $05
        
        .beta
        
        INY : STA.b ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================

; $02D381-$02D38B DATA
Pool_ArcherSoldier_Draw:
{
    ; $02D381
    .weapon
    db $00 ; Right
    db $00 ; Left
    db $00 ; Down
           ; Up bleeds into below

    ; $02D384
    .head
    db $10 ; Right
    db $10 ; Left
    db $10 ; Down
    db $00 ; Up

    ; $02D388
    .body
    db $14 ; Right
    db $14 ; Left
    db $14 ; Down
    db $04 ; Up
}

; ==============================================================================

; $02D38C-$02D3AF LOCAL JUMP LOCATION
ArcherSoldier_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.w $0DE0, X
    LDA.w .head, Y : TAY
    JSR.w Guard_AnimateHead_PreserveOAMOffset
    
    LDY.w $0DE0, X
    LDA.w .body, Y : TAY
    JSR.w Guard_AnimateBody_PreserveOAMOffset
    
    LDY.w $0DE0, X
    LDA.w .weapon, Y : TAY
    JSR.w SpriteDraw_Archer_Weapon

    JMP.w Guard_DrawShadow
}

; ==============================================================================

; $02D3B0-$02D4D3 DATA
Pool_SpriteDraw_Archer_Weapon:
{
    ; $02D3B0
    .offset_x
    dw  -1,   7,   3,   3
    dw  -1,   7,   3,   3
    dw  -1,   7,   7,   7
    dw  -5,  -5, -10,  -2
    dw  -4,  -4,  -6,   2
    dw  -5,  -5,  -5,  -5
    dw   6,  14,  11,  11
    dw   6,  14,  11,  11
    dw   6,  14,  14,  14
    dw  11,  11,  18,  10
    dw  12,  12,  14,   6
    dw  11,  11,  11,  11

    ; $02D410
    .offset_y
    dw   7,   7,   3,  11
    dw   6,   6,   1,   9
    dw   7,   7,   7,   7
    dw  -2,   6,   2,   2
    dw  -2,   6,   2,   2
    dw  -2,   6,   6,   6
    dw  -6,  -6, -12,  -4
    dw  -6,  -6,  -9,  -1
    dw  -6,  -6,  -6,  -6
    dw  -2,   6,   2,   2
    dw  -2,   6,   2,   2
    dw  -2,   6,   6,   6

    ; $02D470
    .char
    db $0A, $0A, $2A, $2B
    db $1A, $1A, $2A, $2B
    db $0A, $0A, $0A, $0A
    db $0B, $0B, $3D, $3A
    db $1B, $1B, $3D, $3A
    db $0B, $0B, $0B, $0B
    db $0A, $0A, $2B, $2A
    db $0A, $0A, $2B, $2A
    db $0A, $0A, $0A, $0A
    db $0B, $0B, $3D, $3A
    db $1B, $1B, $3D, $3A
    db $0B, $0B, $0B, $0B

    ; $02D4A0
    .prop
    db $0D, $4D, $08, $08
    db $0D, $4D, $08, $08
    db $0D, $4D, $4D, $4D
    db $0D, $8D, $48, $48
    db $0D, $8D, $48, $48
    db $0D, $8D, $8D, $8D
    db $8D, $CD, $88, $88
    db $8D, $CD, $88, $88
    db $8D, $CD, $CD, $CD
    db $4D, $CD, $08, $08
    db $4D, $CD, $08, $08
    db $4D, $CD, $CD, $CD

    ; $02D4D0
    .OAM_offset
    db $09
    db $03
    db $00
    db $06
}

; $02D4D4-$02D53A LOCAL JUMP LOCATION
SpriteDraw_Archer_Weapon:
{
    LDA.w $0DC0, X : SEC : SBC.b #$0E : BCS .alpha
        PHY
        
        LDY.w $0DE0, X
        LDA.w Pool_SpriteDraw_Archer_Weapon_OAM_offset, Y
        
        PLY
        
    .alpha
    
    ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .gamma
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_SpriteDraw_Archer_Weapon_offset_x, X
        STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC.w Pool_SpriteDraw_Archer_Weapon_offset_y, X
        INY : STA.b ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .beta
            LDA.w #$00F0 : STA.b ($90), Y
        
        .beta
        
        SEP #$20
        
        PLX
        
        LDA.w Pool_SpriteDraw_Archer_Weapon_char, X
        INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_Archer_prop, X
        ORA.b #$20 : INY : STA.b ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        LDA.b $0F : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================

; $02D53B-$02D6BB
incsrc "sprite_tutorial_entities.asm"

; $02D6BC-$02DA28
incsrc "sprite_pull_switch.asm"

; $02DA29-$02DF6B
incsrc "sprite_uncle_and_priest.asm"

; ==============================================================================

; Widely called, seems to do with placing sprite graphics into OAM.
; $02DF6C-$02DFE4 LONG JUMP LOCATION
Sprite_DrawMultiple:
{
    STA.b $06
    STZ.b $07
    
    ; $02DF70 ALTERNATE ENTRY POINT
    .quantity_preset
    
    JSR.w SpriteDraw_Tabulated_prep_OAM
    
    BRA .moving_on
    
    ; $02DF75 ALTERNATE ENTRY POINT
    .player_deferred
    
    JSR.w SpriteDraw_Tabulated_prep_OAM_deferred
    
    .moving_on
    
    ; Branch will be taken if the sprite were disabled due to being off
    ; screen or something akin to that.
    BCS .return
    
    PHX
    
    ; Routine is definitely used in drawing maidens.
    REP #$30
    
    LDY.w #$0000
    
    LDX.w $0090
    
    .next_OAM_entry
    
        LDA.b ($08), Y : CLC : ADC.b $00 : STA.w $0000, X
        AND.w #$0100                     : STA.b $0C
        
        INY #2
        
        LDA.b ($08), Y : CLC : ADC.b $02 : STA.w $0001, X
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
            LDA.w #$00F0 : STA.w $0001, X
        
        .on_screen_y
        
        INY #2
        
        LDA.w $0CFE : CMP.w #$0001
        LDA.b ($08), Y : EOR.b $04 : BCC .dont_override_palette
            ; Force sprite to use palette 2.
            AND.w #$F1FF : ORA.w #$0400
        
        .dont_override_palette
        
        STA.w $0002, X
        
        PHX
        
        TXA : SEC : SBC.w #$0800 : LSR #2 : TAX
        
        SEP #$20
        
        INY #3
        LDA.b ($08), Y : ORA.b $0D : STA.w $0A20, X
        
        PLX
        
        REP #$20
        
        INY
        
        INX #4
    DEC.b $06 : BNE .next_OAM_entry
    
    SEP #$30
    
    PLX
    
    .return
    
    RTL
}

; ==============================================================================

; Has two return values (CLC and SEC)
; $02DFE5-$02DFE8 LOCAL JUMP LOCATION
SpriteDraw_Tabulated_prep_OAM_deferred:
{
    ; Optinally alter OAM allocation region.
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong

    ; Bleeds into the next function.
}
    
; $02DFE9-$02E00A LOCAL JUMP LOCATION
SpriteDraw_Tabulated_prep_OAM:
{
    ; Note: it is possible for this callee to abort the caller (namely, the
    ; routine we are in right now).
    JSR.w Sprite2_PrepOamCoord
    
    ; Preserves the CLC or SEC status.
    PHP
    
    STZ.w $0CFE
    STZ.w $0CFF
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .notCarriedSprite
        LDA.l $7FFA2C, X
    
    .notCarriedSprite
    
    CMP.b #$0B : BNE .notFrozenSprite
        LDA.l $7FFA3C, X : STA.w $0CFE
    
    .notFrozenSprite
    
    PLP
    
    RTS
}

; ==============================================================================

; $02E00B-$02E1A2
incsrc "sprite_quarrel_bros.asm"

; ==============================================================================

; $02E1A3-$02E1A6 DATA
Sprite_ShowSolicitedMessageIfPlayerFacing_facing_direction:
{
    db $04, $06, $00, $02
}

; Handles text messages
; $02E1A7-$02E1EF LONG JUMP LOCATION
Sprite_ShowSolicitedMessageIfPlayerFacing:
{
    STA.w $1CF0
    STY.w $1CF1
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
        JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .alpha
            LDA.b $F6 : BPL .alpha
                LDA.w $0F10, X : BNE .alpha
                    LDA.b $4D : CMP.b #$02 : BEQ .alpha
                        JSR.w Sprite2_DirectionToFacePlayer : PHX
                                                              TYX
                        
                        ; Make sure that the sprite is facing towards the
                        ; player, otherwise talking can't happen.
                        ; TODO: (What sprites actually use this???)
                        LDA.w .facing_direction, X : PLX : CMP $2F : BNE .not_facing_each_other
                            PHY
                            
                            LDA.w $1CF0
                            LDY.w $1CF1
                            JSL.l Sprite_ShowMessageUnconditional
                            
                            LDA.b #$40 : STA.w $0F10, X
                            
                            PLA : EOR.b #$03
                            
                            SEC
                            
                            RTL
                            
                        .not_facing_each_other
    .alpha
    
    LDA.w $0DE0, X
    
    CLC
    
    RTL
}

; ==============================================================================

; You might be wondering how this differs from the similarly named
; "Sprite_ShowMessageIfPlayerTouching", and the answer is there's really not
; much difference at all. Feel free to let me know if you discern any
; significant difference, other than that this one reports a direction as a
; return value in the accumulator.
; $02E1F0-$02E218 LONG JUMP LOCATION
Sprite_ShowMessageFromPlayerContact:
{
    STA.w $1CF0
    STY.w $1CF1
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_show
        LDA.b $4D : CMP.b #$02 : BEQ .dont_show
            LDA.w $1CF0
            LDY.w $1CF1
            JSL.l Sprite_ShowMessageUnconditional
            
            JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03
            
            SEC
            
            RTL
    
    .dont_show
    
    LDA.w $0DE0, X
    
    CLC
    
    RTL
}

; ==============================================================================

; Routine is used to display a text message with an ID that is inputted via A
; and Y registers.
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
; $02E219-$02E24C LONG JUMP LOCATION
Sprite_ShowMessageUnconditional:
{
    STA.w $1CF0
    STY.w $1CF1
    
    ; Unused: Only ever set to 0.
    STZ.w $0223
    
    STZ.w $1CD8
    
    LDA.b #$02 : STA.b $11
    
    ; Cache the current module.
    LDA.b $10 : STA.w $010C
    
    LDA.b #$0E : STA.b $10
    
    PHX
    
    JSL.l Sprite_NullifyHookshotDrag
    
    STZ.b $5E
    
    JSL.l Player_HaltDashAttackLong
    
    STZ.b $4D
    STZ.b $46
    
    LDA.b $5D : CMP.b #$02 : BNE .alpha
        LDA.b #$00 : STA.b $5D
    
    .alpha
    
    PLX
    
    RTL
}

; ==============================================================================

; $02E24D-$02E28B
incsrc "sprite_pull_for_rupees.asm"

; $02E28C-$02E2E9
incsrc "sprite_gargoyle_grate.asm"

; $02E2EA-$02E3A2
incsrc "sprite_young_snitch_lady.asm"

; $02E3A3-$02E3F2
incsrc "sprite_inn_keeper.asm"

; $02E3F3-$02E62A
incsrc "sprite_witch.asm"

; $02E62B-$02E656
incsrc "sprite_arrow_target.asm"

; ==============================================================================

; TODO: Investigate this.
; Appears to be unsued, or orphaned code for now...
; $02E657-$02E665 LONG UNUSED
Sprite2_TrendHorizSpeedToZero:
{
    LDA.w $0D50, X : BEQ .at_rest
        BPL .positive_velocity
            INC
            
            BRA .moving_on
        
        .positive_velocity
        
        DEC
        
        .moving_on
    .at_rest
    
    STA.w $0D50, X
    
    RTL
}

; ==============================================================================

; $02E666-$02E674 LONG UNUSED
Sprite2_TrendVertSpeedToZero:
{
    LDA.w $0D40, X : BEQ .at_rest
        BPL .positive_velocity
            INC
            
            BRA .moving_on
        
        .positive_velocity
        
        DEC
        
        .moving_on
    .at_rest
    
    STA.w $0D40, X
    
    RTL
}

; ==============================================================================

; $02E675-$02E88D
incsrc "sprite_old_snitch_lady.asm"

; $02E88E-$02EA70
incsrc "sprite_running_man.asm"

; $02EA71-$02EBC6
incsrc "sprite_bottle_vendor.asm"

; $02EBC7-$02EE4A
incsrc "sprite_zelda.asm"

; $02EE4B-$02EEA5
incsrc "sprite_mushroom.asm"

; $02EEA6-$02EEF8
incsrc "sprite_fake_sword.asm"

; $02EEF9-$02F0CC
incsrc "sprite_heart_upgrades.asm"

; $02F0CD-$02F259
incsrc "sprite_elder.asm"

; $02F25A-$02F468
incsrc "sprite_medallion_tablet.asm"

; $02F469-$02F520
incsrc "sprite_elder_wife.asm"

; $02F521-$02F93E
incsrc "sprite_potion_shop.asm"
    
; ==============================================================================

; $02F93F-$02F943 LOCAL JUMP LOCATION
Sprite2_DirectionToFacePlayer:
{
    JSL.l Sprite_DirectionToFacePlayerLong
    
    RTS
}

; ==============================================================================

; $02F944-$02F948 LOCAL JUMP LOCATION
Sprite2_IsToRightOfPlayer:
{
    JSL.l Sprite_IsToRightOfPlayerLong
    
    RTS
}

; ==============================================================================

; $02F949-$02F94D LOCAL JUMP LOCATION
Sprite2_IsBelowPlayer:
{
    JSL.l Sprite_IsBelowPlayerLong
    
    RTS
}

; ==============================================================================

; $02F94E-$02F96A LOCAL JUMP LOCATION
Sprite2_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        ; $02F955 ALTERNATE ENTRY POINT
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

; $02F96B-$02F970 DATA
Pool_Sprite2_CheckIfRecoiling:
{
    .frame_counter_masks
    db $03, $01, $00, $00, $0C, $03
}

; $02F971-$02F9EC LOCAL JUMP LOCATION
Sprite2_CheckIfRecoiling:
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
                LSR #2 : TAY
                LDA.b $1A : AND .frame_counter_masks, Y : BNE .halted
                    LDA.w $0F30, X : STA.w $0D40, X
                    LDA.w $0F40, X : STA.w $0D50, X
                    
                    LDA.w $0CD2, X : BMI .no_wall_collision
                        JSR.w Sprite2_CheckTileCollision
                        
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
                    
                    JSR.w Sprite2_Move
            
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

; $02F9ED-$02F9F3 LOCAL JUMP LOCATION
Sprite2_Move:
{
    JSR.w Sprite2_MoveHoriz
    JSR.w Sprite2_MoveVert
    
    RTS
}

; ==============================================================================

; $02F9F4-$02F9FF LOCAL JUMP LOCATION
Sprite2_MoveHoriz:
{
    TXA : CLC : ADC.b #$10 : TAX
    JSR.w Sprite2_MoveVert
    
    LDX.w $0FA0
    
    RTS
}

; ==============================================================================

; $02FA00-$02FA2D LOCAL JUMP LOCATION
Sprite2_MoveVert:
{
    LDA.w $0D40, X : BEQ .no_velocity
        ASL #4 : CLC : ADC.w $0D60, X : STA.w $0D60, X
        
        LDA.w $0D40, X : PHP
        LSR #4 : LDY.b #$00 : PLP : BPL .positive
            ORA.b #$F0
            
            DEY
        
        .positive
        
              ADC.w $0D00, X : STA.w $0D00, X
        TYA : ADC.w $0D20, X : STA.w $0D20, X
    
    .no_velocity
    
    RTS
}

; ==============================================================================

; $02FA2E-$02FA4F LOCAL JUMP LOCATION
Sprite2_MoveAltitude:
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

; TODO: Investigate this.
; Collision detecting function (at least it calls one in bank $06).
; $02FA50-$02FA58 LOCAL JUMP LOCATION
Sprite2_PrepOamCoord:
{
    JSL.l Sprite_PrepOamCoordLong : BCC .sprite_wasnt_disabled
        PLA : PLA
    
    .sprite_wasnt_disabled
    
    RTS
}

; ==============================================================================

; $02FA59-$02FA8D LONG JUMP LOCATION
Sprite_ShowMessageIfPlayerTouching:
{
    STA.w $1CF0
    STY.w $1CF1
    
    LDA.w $0E40, X : PHA
    
    LDA.b #$80 : STA.w $0E40, X
    
    LDA.w $0F60, X : PHA
    
    ; Alter the hit detection box for the purposes of seeing if the player
    ; wants to talk.
    LDA.b #$07 : STA.w $0F60, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong
    
    PLA : STA.w $0F60, X
    PLA : STA.w $0E40, X
    
    BCC Sprite_ShowMessageMinimal_exit
        PHP
        
        JSL.l Sprite_NullifyHookshotDrag
        
        PLP
        
        STZ.w $0372
        STZ.b $5E
        
        LDA.b $4D : BNE Sprite_ShowMessageMinimal_exit
            ; Bleeds into the next function.
}

; $02FA8E-$02FAA1 LONG JUMP LOCATION
Sprite_ShowMessageMinimal:
{
    ; Unused: Only ever set to 0.
    STZ.w $0223

    STZ.w $1CD8
            
    LDA.b #$02 : STA.b $11
    
    ; Cache the current module.
    LDA.b $10 : STA.w $010C
            
    LDA.b #$0E : STA.b $10
    
    ; $02FAA1 ALTERNATE ENTRY POINT
    .exit
    
    RTL
}

; ==============================================================================

; $02FAA2-$02FAC9 LONG JUMP LOCATION
Overworld_ReadTileAttr:
{
    ; TODO: (rather a bug in the way I named this routine...)
    ; Seems more like a map16 attr reader than a map8 reader.
    REP #$30
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
    LDA.b $02 : SEC : SBC.w $070C : AND.w $070E : ORA.b $06 : TAX
    
    LDA.l $7E2000, X : TAX
    LDA.l OverworldTileTypeTable, X
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $02FACA-$02FBEE
incsrc "sprite_mad_batter.asm"

; $02FBEF-$02FF5D
incsrc "sprite_dash_item.asm"

; $02FF5E-$02FFFE
incsrc "sprite_trough_boy.asm"

; ==============================================================================

; $02FFFF-$02FFFF NULL
NULL_05FFFF:
{
    db $FF
}

; ==============================================================================

warnpc $068000
