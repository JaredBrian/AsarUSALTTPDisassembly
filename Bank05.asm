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
        
        JSL GetRandomInt : AND.b #$03 : TAX
        
        LDA.l Pool_Sprite_SpawnSparkleGarnish_low_offset, X  : STA.b $00
        LDA.l Pool_Sprite_SpawnSparkleGarnish_high_offset, X : STA.b $01
        
        JSL GetRandomInt : AND.b #$03 : TAX
        
        LDA.l Pool_Sprite_SpawnSparkleGarnish_low_offset, X  : STA.b $02
        LDA.l Pool_Sprite_SpawnSparkleGarnish_high_offset, X : STA.b $0303
        
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
        
        LDA.w $0D00, Y : CLC : ADC.b $0202 : STA.l $7FF81E, X
        LDA.w $0D20, Y :       ADC.b $0303 : STA.l $7FF85A, X
        
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
    JSL Sprite_HelmasaurFireballLong
    
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

; 
incsrc "sprite_spark.asm"

; 
incsrc "sprite_lost_woods_bird.asm"

; 
incsrc "sprite_lost_woods_squirrel.asm"

; 
incsrc "sprite_crab.asm"

; 
incsrc "sprite_desert_barrier.asm"

; 
incsrc "sprite_zora_and_fireball.asm"

; 
incsrc "sprite_zora_king.asm"

; 
incsrc "sprite_walking_zora.asm"

; 
incsrc "sprite_armos_knight.asm"

; 
incsrc "sprite_lanmola.asm"

; 
incsrc "sprite_rat.asm"

; 
incsrc "sprite_rope.asm"

; 
incsrc "sprite_cannon_trooper.asm"

; 
incsrc "sprite_warp_vortex.asm"

; 
incsrc "sprite_flail_trooper.asm"

; ==============================================================================

; $02B5C3-$02B5CA LONG JUMP LOCATION
SpriteActive2_MainLong:
{
    PHB : PHK : PLB
    
    JSR SpriteActive2_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $02B5CB-$02B5D2 DATA
Soldier_DirectionLockSettings:
{
    .directions
    db $03, $02, $00, $01
    
    .animation_states
    db $08, $00, $0C, $05
}

; ==============================================================================

; $02B5D3-$02B647 LOCAL JUMP LOCATION
SpriteActive2_Main:
{
    ; This routine is meant to handle sprites with IDs 0x41 to 0x70.
    
    LDA.w $0E20, X : SEC : SBC.b #$41 : REP #$30 : AND.w #$00FF : ASL A : TAY
    
    LDA .sprite_routines, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    .sprite_routines
    
    ; Sprite routines 3*
    
    ; Please note that the numbers in the comments to the right are the actual sprite numbers
    ; and have nothing to do with the orientation of the table, though they ; are in order.
    
    dw Sprite_Soldier                     ; 0x41 - Green Soldier
    dw Sprite_Soldier                     ; 0x42 - Blue Soldier
    dw Sprite_Soldier                     ; 0x43 - Red Spear Soldier
    dw Sprite_PsychoTrooper               ; 0x44 - Crazy Blue Killer Soldiers
    dw Sprite_PsychoSpearSoldier          ; 0x45 - Crazed Spear Soldiers (Green or Red)
    dw Sprite_ArcherSoldier               ; 0x46 - Blue Archers
    dw Sprite_BushArcherSoldier           ; 0x47 - Green Archers (in bushes)
                                          
    dw Sprite_JavelinTrooper              ; 0x48 - Red Javelin Soldiers (in special armor)
    dw Sprite_BushJavelinSoldier          ; 0x49 - Red Javelin Soldiers (in bushes)
    dw Sprite_BombTrooper                 ; 0x4A - Bomb Trooper / Enemy Bombs
    dw Sprite_Recruit                     ; 0x4B - Recruit
    dw Sprite_GerudoMan                   ; 0x4C - Gerudo Man
    dw Sprite_Toppo                       ; 0x4D - Asshole bunnies (Toppo)
    dw Sprite_Popo                        ; 0x4E - Snakebasket (Popo?)
    dw Sprite_Bot                         ; 0x4F - Bot / Bit?
    
    dw Sprite_MetalBall                   ; 0x50 - Metal Balls in Eastern Palace
    dw Sprite_Armos                       ; 0x51 - Armos
    dw Sprite_ZoraKing                    ; 0x52 - Giant Zora
    dw Sprite_ArmosKnight                 ; 0x53 - Armos Knight Code
    dw Sprite_Lanmola                     ; 0x54 - Lanmola
    dw Sprite_ZoraAndFireball             ; 0x55 - Zora (or Agahnim) fireball code.
    dw Sprite_WalkingZora                 ; 0x56 - Walking Zora
    dw Sprite_DesertBarrier               ; 0x57 - Desert Palace Barrier
    
    dw Sprite_Crab                        ; 0x58 - Crab
    dw Sprite_LostWoodsBird               ; 0x59 - Birds (master sword grove)
    dw Sprite_LostWoodsSquirrel           ; 0x5A - Squirrel (master sword grove?)
    dw Sprite_Spark                       ; 0x5B - Spark (clockwise on convex, counterclockwise on concave)
    dw Sprite_Spark                       ; 0x5C - Spark (counterclockwise on convex, clockwise on concave)
    dw Sprite_SpikeRoller                 ; 0x5D - Roller (????)
    dw Sprite_SpikeRoller                 ; 0x5E - Roller (????)
    dw Sprite_SpikeRoller                 ; 0x5F - Roller (????)
    
    dw Sprite_SpikeRoller                 ; 0x60 - Roller (????)
    dw Sprite_Beamos                      ; 0x61 - Beamos (aka Statue Sentry)
    dw Sprite_MasterSword                 ; 0x62 - Master Sword (in the grove)
    dw Sprite_DebirandoPit                ; 0x63 - Sand lion pit
    dw Sprite_Debirando                   ; 0x64 - Sand lion
    dw Sprite_ArcheryGameGuy              ; 0x65 - Shooting gallery guy
    dw Sprite_WallCannon                  ; 0x66 - Moving cannon ball shooters
    dw Sprite_WallCannon                  ; 0x67 - Moving cannon ball shooters
    
    dw Sprite_WallCannon                  ; 0x68 - Moving cannon ball shooters
    dw Sprite_WallCannon                  ; 0x69 - Moving cannon ball shooters
    dw Sprite_ChainBallTrooper            ; 0x6A - Ball n' Chain Trooper
    dw Sprite_CannonTrooper               ; 0x6B - Cannon Ball Shooting Trooper (unused in game)
    dw Sprite_WarpVortex                  ; 0x6C - Warp Vortex (from Magic mirror in light world)
    dw Sprite_Rat                         ; 0x6D - Rat / Bazu
    dw Sprite_Rope                        ; 0x6E - Rope / Skullrope
    dw Sprite_Keese                       ; 0x6F - Keese
    
    dw Sprite_HelmasaurFireballTrampoline ; 0x70 - Helmasaur King fireballs
}

; ==============================================================================

incsrc "sprite_metal_ball.asm"
incsrc "sprite_armos.asm"
incsrc "sprite_bot.asm"
incsrc "sprite_gerudo_man.asm"
incsrc "sprite_toppo.asm"
incsrc "sprite_recruit.asm"

; ==============================================================================

; $02C155-$02C226 LOCAL JUMP LOCATION
Sprite_Soldier:
{
    LDA.w $0DB0, X : BNE .is_probe
    
    JMP Soldier_Main
    
    .is_probe
    
    ; \note Label here for informational purposes.
    shared Sprite_Probe:
    
    LDY.b #$00
    
    ; Is the sprite moving right? Yes, so skip the decrement of Y
    LDA.w $0D50, X : BPL .moving_right
    
    ; Sprite is moving left, so we have to make sure subtraction is done smoothly
    DEY
    
    .moving_right
    
    ; This code moves the soldier left or right, depending on $0D50, X
          CLC : ADC.w $0D10, X : STA.w $0D10, X
    TYA : ADC.w $0D30, X : STA.w $0D30, X
    
    LDY.b #$00
    
    ; Same as above but for Y coordinate of the soldier
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
    
    JMP.w $C1F6 ; $02C1F6 IN ROM
    
    .player_not_close
    
    JMP.w $C21A       ; $02C21A IN ROM
    
    .parent_not_blind_the_thief
    
    ; Check the tile attr that the sprite is interacting with
    JSL Probe_CheckTileSolidity : BCC .zeta
    
    LDA.w $0FA5 : CMP.b #$09 : BNE .theta
    
    .zeta
    
    ; Is Link invisible and invincible? (magic cape)
    LDA.w $0055 : BNE .theta
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $22 : CMP.w #$0010 : SEP #$20 : BCS .iota
    
    REP #$20
    
    LDA.w $0FDA : SEC : SBC.b $20 : CMP.w #$0010 : SEP #$20 : BCS .iota
    
    ; Are Link and the soldier on the same floor?
    LDA.w $0F20, X : CMP $EE : BNE .iota
    
    ; $02C1F6 ALTERNATE ENTRY POINT
    
    LDA.w $0DB0, X : DEC A
    
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
    .iota
    
    JSR Sprite2_PrepOamCoord
    
    LDA.b $01 : ORA.b $0303 : BEQ .return
    
    .theta
    
    STZ.w $0DD0, X
    
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
    
    LDA Soldier_DirectionLockSettings.directions, Y : STA.w $0DE0, X
    
    LDA Soldier_DirectionLockSettings.animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    ; Looks like a "draw soldier" function...
    JSR.w $C680 ; $02C680 IN ROM
    
    PLA : STA.w $0DE0, X
    PLA : STA.w $0DC0, X
    
    LDA.w $0DD0, X : CMP.b #$05 : BNE .not_falling_in_hole
    
    LDA.b $1111 : BNE Sprite_Soldier.return
    
    ; ticking animation clock and state...
    JSR.w $C535 ; $02C535 IN ROM
    JMP.w $C535 ; $02C535 IN ROM
    
    .not_falling_in_hole
    
    JSR Sprite2_CheckIfActive
    JSL.l $06EB5E ; $036B5E IN ROM ; push sprite back from sword hit?
    
    JSL Sprite_CheckDamageToPlayerLong : BCS .gamma
    
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
    
    JSR.w $C4D7 ; $02C4D7 IN ROM
    
    .zeta
    
    JSR Sprite2_CheckIfRecoiling
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCS .theta
    
    LDA.w $0E70, X : BNE .iota
    
    JSR.w $F9EB ; $02F9EB IN ROM
    
    .iota
    
    JSR Sprite2_CheckTileCollision
    
    BRA .kappa
    
    .theta
    
    JSR Sprite2_Move
    
    .kappa
    
    LDA.w $0D80, X : CMP.b #$04 : BEQ .nu
    
    STZ.w $0ED0, X
    
    .nu
    
    REP #$30 : AND.w #$00FF : ASL A : TAY
    
    ; Hidden table! gah!!!
    LDA .states, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    .states
    
    dw $C2D4 ; = $2C2D4*
    dw $C403 ; = $2C403*
    dw $C490 ; = $2C490*
    dw $C4C1 ; = $2C4C1*
    dw $C4E8 ; = $2C4E8*
}

; ==============================================================================

; $02C2D0-$02C2D3 DATA
{
    db $60, $C0, $FF, $40
}

; ==============================================================================

; $02C2D4-$02C330 JUMP LOCATION
{
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.w $0E30, X : BEQ .beta
    
    AND.b #$07 : CMP.b #$05 : BCS .beta
    
    LDA.w $0E30, X : LSR #3 : AND.b #$03 : TAY
    
    LDA.w $C2D0, Y : STA.w $0DF0, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    STZ.w $0E80, X
    
    BRA .gamma
    
    .beta
    
    JSL GetRandomInt : AND.b #$3F : ADC.b #$28 : STA.w $0DF0, X
    
    LDA.w $0DE0, X : PHA
    
    JSL GetRandomInt : AND.b #$03 : STA.w $0DE0, X
    
    PLA : CMP.w $0DE0, X : BEQ .alpha
    
    EOR.w $0DE0, X : AND.b #$02 : BNE .alpha
    
    ; $02C32B ALTERNATE ENTRY POINT
    shared Soldier_EnableDirectionLock:
    
    .gamma
    
    LDA.b #$0C : STA.w $0E00, X
    
    .alpha
    .delay
    
    RTS
}

; $02C331-$02C3A0 DATA
Pool_Probe:
    parallel Pool_Soldier:
{
    .x_speeds
    db $08, $F8, $00, $00
    
    .y_speeds
    db $00, $00, $08, $F8
    
    ; $2C339
    .animation_states
    db $0B, $0C, $0D, $0C, $04, $05, $06, $05
    db $00, $01, $02, $03, $07, $08, $09, $0A
    db $11, $12, $11, $12, $07, $08, $07, $08
    db $03, $04, $03, $04, $0D, $0E, $0D, $0E
    
    ; $2C359
    .x_checked_directions
    db  1,  1, -1, -1
    db -1, -1,  1,  1
    
    ; $2C361
    .y_checked_directions
    db -1,  1,  1, -1
    db -1,  1,  1, -1
    
    ; $2C369
    .chase_x_speeds
    db $08, $00, $F8, $00
    db $F8, $00, $08, $00
    
    .chase_y_speeds
    db $00, $08, $00, $F8
    db $00, $08, $00, $F8
    
    ; $2C379
    db  0,  2,  1,  3
    db  1,  2,  0,  3
    
    .collinear_directions
    db $01, $04, $02, $08
    db $02, $04, $01, $08
    
    ; $2C389
    .orthogonal_directions
    db $08, $01, $04, $02
    db $08, $02, $04, $01
    
    .collinear_next_direction
    db  1,  2,  3,  0
    db  5,  6,  7,  4
    
    ; $2C399
    .orthogonal_next_direction
    db  3,  0,  1,  2
    db  7,  4,  5,  6
}

; $02C3A1-$02C402 JUMP LOCATION
{
    LDY.w $0DA0, X
    
    LDA.w $C359, Y : STA.w $0D50, X
    
    LDA.w $C361, Y : STA.w $0D40, X
    
    JSR Sprite2_CheckTileCollision
    
    LDA.w $0E10, X : BEQ .alpha
    CMP.b #$2C   : BNE .beta
    
    LDY.w $0DA0, X
    
    LDA.w $C399, Y : STA.w $0DA0, X
    
    BRA .beta
    
    .alpha
    
    LDY.w $0DA0, X
    
    LDA.w $0E70, Y : AND.w $C389, Y : BNE .beta
    
    LDA.b #$58 : STA.w $0E10, X
    
    .beta
    
    LDY.w $0DA0, X
    
    LDA.w $0E70, Y : AND.w $C381, Y : BEQ .gamma
    
    LDA.w $C391, Y : STA.w $0DA0, X
    
    .gamma
    
    LDY.w $0DA0, X
    
    LDA Soldier.chase_x_speeds, Y : STA.w $0D50, X
    
    LDA Soldier.chase_y_speeds, Y : STA.w $0D40, X
    
    LDA.w $C379, Y : STA.w $0DE0, X : STA.w $0EB0, X
    
    JMP.w $C454 ; $02C454 IN ROM
}

; $02C403-$02C46F JUMP LOCATION
{
    JSR Sprite_SpawnProbeStaggered
    
    LDA.w $0E30, X : AND.b #$07 : CMP.b #$05 : BCC .alpha
    
    JMP.w $C3A1 ; $02C3A1 IN ROM
    
    .alpha
    
    LDA.w $0DF0, X : BNE .beta
    
    ; $02C417 ALTERNATE ENTRY POINT
    
    JSR Sprite2_ZeroVelocity
    
    LDA.b #$02 : STA.w $0D80, X
    
    LDA.b #$A0 : STA.w $0DF0, X
    
    RTS

    .beta

    LDA.w $0E80, X : AND.b #$01 : BNE .gamma
    
    INC.w $0DF0, X

    .gamma

    LDA.w $0E70, X : AND.b #$0F : BEQ .delta
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    JSR Soldier_EnableDirectionLock

    .delta

    LDY.w $0DE0, X
    
    LDA Soldier.x_speeds, Y : STA.w $0D50, X
    
    LDA Soldier.y_speeds, Y : STA.w $0D40, X
    
    TYA : STA.w $0EB0, X
    
    INC.w $0E80, X

; $02C454-$02C46F ALTERNATE ENTRY POINT

    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : STA.b $00
    
    LDA.w $0DE0, X : ASL #2 : ADC.b $00 : TAY
    
    LDA Soldier.animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02C470-$02C48F DATA
Pool_Soldier:
{
    .head_looking_states
    db $00, $02, $02, $02, $00, $03, $03, $03
    db $01, $03, $03, $03, $01, $02, $02, $02
    db $02, $00, $00, $00, $02, $01, $01, $01
    db $03, $01, $01, $01, $03, $00, $00, $00
}

; ==============================================================================

; $02C490-$02C4C0 JUMP LOCATION
{
    JSR Sprite2_ZeroVelocity
    JSR Sprite_SpawnProbeStaggered
    
    LDA.w $0DF0, X : BNE .alpha
    
    LDA.b #$20 : STA.w $0DF0, X
    
    LDA.b #$00 : STA.w $0D80, X
    
    RTS
    
    .alpha
    
    CMP.b #$80 : BCS .beta
    
    LSR #3 : AND.b #$07 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $0000 : TAY
    
    LDA Soldier.head_looking_states, Y : STA.w $0EB0, X
    
    .beta	
    
    RTS
}

; $02C4C1-$02C4E7 JUMP LOCATION
{
    ; Green soldier submode 3
    
    JSR Sprite2_ZeroVelocity
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X
    
    LDA.w $0DF0, X : BNE .alpha
    
    LDA.b #$04 : STA.w $0D80, X
    
    LDA.b #$FF
    
    ; $02C4D7 ALTERNATE ENTRY POINT
    
    STA.w $0DF0, X
    
    STZ.w $0E30, X
    
    LDA.w $0B6B, X : AND.b #$0F : ORA.b #$60 : STA.w $0B6B, X
    
    .alpha
    
    RTS
}

; $02C4E8-$02C4F8 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_$2C500
    
    LDY.w $0DE0, X
    
    LDA JavelinTrooper_Attack.scan_anbles, X : STA.w $0EC0, X
    
    BRL .BRANCH_2C417
}

; ==============================================================================

; $02C4F9-$02C4FF LOCAL JUMP LOCATION
Sprite2_ZeroVelocity:
{
    ; Stop horizontal and vertical velocities
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    RTS
}

; ==============================================================================

; $02C500-$02C53B LOCAL JUMP LOCATION
{
    TYA : EOR.b $1A1A : AND.b #$1F : BNE .alpha
    
    LDA.w $0ED0, X : BNE .beta
    
    LDA.b #$04 : JSL Sound_SetSfx3PanLong
    
    INC.w $0ED0, X
    
    .beta
    
    TXA : AND.b #$03 : TAY
    
    LDA.w $0E20, X : CMP.b #$42 : BEQ .gamma
    
    .gamma
    
    LDA.w $C566, X : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0DE0, X : STA.w $0EB0, X
    
    .alpha
    
    JSL Probe_SetDirectionTowardsPlayer
    
    ; $02C535 ALTERNATE ENTRY POINT
    
    INC.w $0E80, X
    
    JSR.w $C454 ; $02C454 IN ROM
    
    RTS
}

; ==============================================================================

; $02C53C-$02C541 DATA
Pool_Probe_SetDirectionTowardsPlayer:
    parallel Pool_Sprite_PsychoSpearSoldier:
    parallel Pool_Sprite_PsychoTrooper:
{
    .x_speeds length 4
    db $0E, $F2
    
    .y_speeds
    db $00, $00, $0E, $F2
}

; ==============================================================================

; $02C542-$02C565 LONG JUMP LOCATION
Probe_SetDirectionTowardsPlayer:
{
    PHB : PHK : PLB
    
    LDA.w $0E70, X : BEQ .no_tile_collision
    AND.b #$03   : BEQ .no_horiz_collision
    
    JSR Sprite2_IsBelowPlayer : INY #2 : BRA .moving_on
    
    .no_horiz_collision
    
    JSR Sprite2_IsToRightOfPlayer
    
    .moving_on
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    .no_tile_collision
    
    PLB
    
    RTL
}

; ==============================================================================

; $02C566-$02C5F1 DATA
{
    db $10, $10, $10, $10
    
    ; $2C56A
    db $12, $12, $12, $12
    
    ; $2C56E
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    db $F0, $F2, $F4, $F6, $F8, $FA, $FC, $FE
    
    db $00, $02, $04, $06, $08, $0A, $0C, $0E
    db $10, $10, $10, $10, $10, $10, $10, $10
    
    db $10, $10, $10, $10, $10, $10, $10, $10
    db $0E, $0C, $0A, $08, $06, $04, $02, $00
    
    db $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    
    ; $2C5AE
    db $00, $02, $04, $06, $08, $0A, $0C, $0E
    db $10, $10, $10, $10, $10, $10, $10, $10
    
    db $10, $10, $10, $10, $10, $10, $10, $10
    db $0E, $0C, $0A, $08, $06, $04, $02, $00
    
    db $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    
    db $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    db $F2, $F4, $F6, $F8, $FA, $FC, $FE, $00
    
    ; $2C5EE
    db $10, $30, $00, $20
}

; ==============================================================================

; $02C5F2-$02C66D LOCAL JUMP LOCATION
Sprite_SpawnProbeStaggered:
{
    ; Soldiers and Archers seem to be the only two types that call this.
    ; Beamos and Blind call the alternate entry point...
    
    ; Is there some point to this store that I'm not seeing? It's
    ; overwritten later before even being used.
    TXA : CLC : ADC.b $1A1A : STA.b $0F
    
    AND.b #$03 : ORA.w $0F00, X : BNE .spawn_failed
    
    LDA.w $0EC0, X : INC.w $0EC0, X
    
    LDY.w $0DE0, X
    
    CLC : AND.b #$1F : ADC.w $C5EE, Y : AND.b #$3F : STA.b $0F
    
    ; $02C612 ALTERNATIVE ENTRY POINT
    shared Sprite_SpawnProbeAlways:
    
    LDA.b #$41  ; If any of our sprites are dead, change it to a soldier
    LDY.b #$0A  ; We'll be checking sprites in slots 0x00 through 0x0A
    
    JSL Sprite_SpawnDynamically.arbitrary : BMI .spawn_failed
    
    LDA.b $00 : CLC : ADC.b #$08 : STA.w $0D10, Y
    LDA.b $01 : ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $0202 : CLC : ADC.b #$04 : STA.w $0D00, Y
    LDA.b $03 : ADC.b #$00 : STA.w $0D20, Y
    
    PHX
    
    ; The direction the statue sentry eye is facing determines the direction
    ; that the feeler will travel in.
    LDX.b $0F
    
    TXA : STA.w $0DE0, Y
    
    LDA.w $C56E, X : STA.w $0D50, Y
    
    LDA.w $C5AE, X : STA.w $0D40, Y
    
    LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$A0 : STA.w $0E40, Y
    
    PLX
    
    TXA : INC A : STA.w $0DB0, Y
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
    
    JSR Sprite_SpawnProbeAlways
    
    PLB
    
    RTL
} 

; ==============================================================================

; $02C676-$02C67F LONG JUMP LOCATION
Soldier_AnimateMarionetteTempLong:
{
    PHB : PHK : PLB
    
    PHX
    
    JSR.w $C680 ; $02C680 IN ROM
    
    PLX
    
    PLB
    
    RTL
}

; $02C680-$02C6A2 LOCAL JUMP LOCATION
{
    JSR Sprite2_PrepOamCoord
    JSR.w $C6DE ; $02C6DE IN ROM
    JSR.w $CA09 ; $02CA09 IN ROM
    JSR.w $CB64 ; $02CB64 IN ROM
    
    ; $02C68C ALTERNATE ENTRY POINT
    
    LDA.w $0E60, X : AND.b #$10 : BEQ .alpha
    
    LDY.w $0DE0, X
    
    LDA .shadow_types, Y
    
    JSL Sprite_DrawShadowLong.variable
    
    .alpha
    
    RTS
    
    .shadow_types
    db $0C, $0C, $0A, $0A
}

; $02C6A2-$2C6DD LOCAL JUMP LOCATION
    ; TODO: Data found accidentally by letterbomb. Is used for the soldier recruit draw but may have other uses as well.
{
    ; $02C6A2
    .headChar
    db $42, $42, $40, $44

    ; $02C6A6
    .headProperties
    db $40, $00, $00, $00
    
    ; $02C6AA
    .headYOffset ; TODO: Confirm this.
    db $07, $00, $08, $00
    
    ; $02C6AE
    ; TODO: Undoccumented data.
    db $07, $00, $08, $00, $08, $00, $07, $00
    db $08, $00, $07, $00, $08, $00, $07, $00
    db $08, $00, $08, $00, $07, $00, $08, $00
    db $08, $00, $08, $00, $08, $00, $08, $00
    db $08, $00, $08, $00, $08, $00, $08, $00
    db $08, $00, $08, $00, $08, $00, $08, $00
}

; $02C6DE-$02C72C LOCAL JUMP LOCATION
{
    LDY.b #$00
    
    ; $02C6E0 ALTERNATE ENTRY POINT
    
    PHX
    
    LDA.w $0DC0, X : ASL A : STA.b $0D
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00 : STA ($90), Y : AND.w #$0100 : STA.b $0E
    
    PHY
    
    LDA.b $02
    
    SEC
    
    LDY.b $0D
    SBC.w $C6AA, Y
    
    PLY : INY
    
    STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
    
    LDA.w #$00F0 : STA ($90), Y
    
    .alpha
    
    SEP #$20
    
    LDA.w $C6A2, X : INY           : STA ($90), Y
    LDA.w $C6A6, X : INY : ORA.b $05 : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    RTS
}

; $02CA09-$02CAB7 LOCAL JUMP LOCATION
{
    LDY.w $0DE0, X
    
    LDA.w $CA05, Y : TAY
    
    ; $02CA10 ALTERNATE ENTRY POINT
    
    LDA.w $0DC0, X : ASL #2 : STA.b $07
    LDA.w $0E20, X          : STA.b $08
    
    PHX
    
    LDX.b #$03
    
    ; $02CA1F ALTERNATE ENTRY POINT
    
    PHX
    
    TXA : CLC : ADC.b $07 : TAX : STX.b $06
    
    LDA.b $08 : CMP.b #$46 : BCC .alpha
    
    LDA.w $C99D, X : BEQ .beta
    
    LDA.w $C8CD, X
    
    PLX : PHX
    
    CPX.b #$03 : BNE .alpha
    
    CMP.b #$20 : BEQ .beta
    
    .alpha
    
    LDA.b $06 : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w $C72D, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC.w $C7FD, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .gamma
    
    LDA.w #$00F0 : STA ($90), Y
    
    .gamma
    
    SEP #$20
    
    LDA.w #$08 : STA.b $0D
    
    LDX.b $06
    
    LDA.w $C8CD, X : INY : STA ($90), Y : CMP.b #$20 : BNE .delta
    
    LDA.b #$02 : STA.b $0D
    
    LDA.b $0808 : CMP.b #$46 : CLC : BNE .epsilon
    
    DEY : LDA.b #$F0 : STA ($90), Y : INY
    
    BRA .epsilon
    
    .delta
    
    LDA.w $C99D, X : CMP.b #$01
    
    .epsilon
    
    LDA.w $C935, X : ORA.b $0505
    
    BCS .zeta
    
    AND.b #$F1 : ORA.b $0D0D
    
    .zeta
    
    INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.w $C99D, X : ORA.b $0F0F : STA ($92), Y
    
    PLY : INY
    
    .beta
    
    PLX : DEX : BMI .theta
    
    JMP.w $CA1F ; $02CA1F IN ROM
    
    .theta
    
    PLX
    
    RTS
}

; $02CB64-$02CBDF LOCAL JUMP LOCATION
{
    LDA.w $0DC0, X : ASL A : STA.b $06
    
    LDA.w $0E20, X : SEC : SBC.b #$41 : STA.b $08
    
    LDY.w $0DE0, X
    
    LDA.w $CB60, Y : TAY
    
    PHX
    
    LDX.b #$01
    
    .gamma
    
    PHX
    
    TXA : CLC : ADC.b $060606 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA.w $CAB8, X : CLC : ADC.b $0000 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.w $CAF0, X : CLC : ADC.b $02 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
    
    LDA.w #$00F0 : STA ($90), Y
    
    .alpha
    
    SEP #$20
    
    LDA.w $CAB8, X : STA.w $0FAB
    LDA.w $CAF0, X : STA.w $0FAA
    
    PLX
    
    LDA.b $08 : CMP.b #$02
    
    LDA.w $CB28, X : BCS .beta
    
    ADC.b #$03
    
    .beta
    
    INY : STA ($90), Y
    
    LDA.w $CB44, X : ORA.b $05 : INY : STA ($90), Y
    
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
    JSR.w $C680   ; $02C680 IN ROM
    JSR Sprite2_CheckIfActive
    JSR PsychoSpearSoldier_PlayChaseMusic
    JSL.l $06EB5E ; $036B5E IN ROM
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_MoveIfNotTouchingWall
    JSR Sprite2_CheckTileCollision
    JSL Sprite_CheckDamageToPlayerLong
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .no_direction_change
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X : STA.w $0DE0, X
    
    TXA : AND.b #$03 : TAY
    
    LDA.w $C56A, Y
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.w $0E70, X : BEQ .no_direction_change
    AND.b #$03   : BEQ .horizontal_tile_collision
    
    JSR Sprite2_IsBelowPlayer
    
    INY #2
    
    BRA .gamma
    
    .horizontal_tile_collision
    
    JSR Sprite2_IsToRightOfPlayer
    
    .gamma
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    .no_direction_change
    
    INC.w $0E80, X
    
    JSR.w $C454 ; $02C454 IN ROM
    
    RTS
}

; ==============================================================================

; $02CC3C-$02CC64 LOCAL JUMP LOCATION
PsychoSpearSoldier_PlayChaseMusic:
{
    LDA.w $0ED0, X : CMP.b #$10 : BEQ .no_change
    INC.w $0ED0, X : CMP.b #$0F : BNE .no_change
    
    LDA.b #$04 : JSL Sound_SetSfx3PanLong
    
    LDA.l $7EF3C5 : CMP.b #$02 : BNE .no_change
    
    LDA.w $040A : CMP.b #$18 : BNE .no_change
    
    LDA.b #$0C : STA.w $012C
    
    .alpha
    .no_change
    
    RTS
}

; ==============================================================================

; $02CC65-$02CCD4 JUMP LOCATION
Sprite_PsychoTrooper:
{
    JSR.w $CCD5   ; $02CCD5 IN ROM
    JSR Sprite2_CheckIfActive
    JSR.w $CC3C   ; $02CC3C IN ROM
    JSL.l $06EB5E ; $036B5E IN ROM
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_MoveIfNotTouchingWall
    JSR Sprite2_CheckTileCollision
    JSL Sprite_CheckDamageToPlayerLong
    
    TXA : EOR.b $1A : AND.v #$0F : BNE .alpha
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X : STA.w $0DE0, X
    
    TXA : AND.b #$03 : TAY
    
    LDA.w $C56A, Y
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.w $0E70, X : BEQ .alpha
    AND.b #$03   : BEQ .beta
    
    JSR Sprite2_IsBelowPlayer
    
    INY #2
    
    BRA .gamma
    
    .beta
    
    JSR Sprite2_IsToRightOfPlayer
    
    .gamma
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    .alpha
    
    LDA.w $0DE0, X : ASL #3 : STA.b $00
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR A : AND.b #$07 : ORA.b $00 : TAY
    
    LDA.w $B0C7, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02CCD5-$02CCE7 LOCAL JUMP LOCATION
{
    JSR Sprite2_PrepOamCoord
    
    LDY.b #$0C : JSR.w $B160 ; $02B160 IN ROM
    
    LDY.b #$08 : JSR.w $B3CD  ; $02B3CD IN ROM
    
    JSR.w $CD4F  ; $02CD4F IN ROM
    JMP.w $C68C ; $02C68C IN ROM
}

; $02CD48-$02CDD3 LOCAL JUMP LOCATION
{
    LDY.b #$00
    
    ; $02CD4A ALTERNATE ENTRY POINT
    
    LDA.w $0D90, X
    
    BRA .alpha
    
    ; $02CD4F ALTERNATE ENTRY POINT
    
    LDA.w $0D90, X
    
    LDY.b #$00
    
    .alpha
    
    EOR.b #$01 : ASL A : AND.b #$02 : STA.b $06
    
    LDA.w $0E20, X : STA.b $08
    
    LDA.w $0DE0, X : ASL #2 : ORA.b $06 : STA.b $0606
    
    PHX
    
    LDX.b #$01
    
    .delta
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.w $CCE8, X : CLC : ADC.b $00 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.w $CD08, X : CLC : ADC.b $0202 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .beta
    
    LDA.w #$00F0 : STA ($90), Y
    
    .beta
    
    SEP #$20
    
    LDA.w $CCE8, X : STA.w $0FAB
    LDA.w $CD08, X : STA.w $0FAA
    
    PLX
    
    LDA.b $0808 : CMP.b #$48 : LDA.w $CD28, X : BCC .gamma
    
    SBC.b #$03
    
    .gamma
    
                                                       INY : STA ($90), Y
    LDA.w $CD38, X : ORA.b $05 : AND.b #$F1 : ORA.b #$08 : INY : STA ($90), Y
    
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
    
    JMP Sprite2_Move
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02CDDD-$02CDE0 DATA
Pool_Sprite_JavelinTrooper:
{
    .animation_states
    db $0C, $00, $12, $08
}

; ==============================================================================

; $02CDE1-$02CE73 JUMP LOCATION
Sprite_JavelinTrooper:
{
    LDA.w $0DC0, X : PHA
    LDY.w $0DE0, X : PHY
    
    LDA.w $0E00, X : BEQ .direction_lock_inactive
    
    LDA Soldier_DirectionLockSettings.directions, Y : STA.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    JSR JavelinTrooper_Draw
    
    BRA .beta
    
    ; $02CDFF ALTERNATE ENTRY POINT
    shared Sprite_ArcherSoldier:
    
    LDA.w $0DC0, X : PHA
    LDY.w $0DE0, X : PHY
    
    LDA.w $0E00, X : BEQ .direction_lock_inactive_2
    
    LDA Soldier_DirectionLockSettings.directions, Y : STA.w $0DE0, X
    
    LDA Soldier_DirectionLockSettings.animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive_2
    
    JSR ArcherSoldier_Draw
    
    .beta
    
    PLA : STA.w $0DE0, X
    PLA : STA.w $0DC0, X
    
    JSR Sprite2_CheckIfActive
    
    JSR Sprite2_CheckDamage : BCS .gamma
    
    LDA.w $0FDC : BEQ .delta
    
    .gamma
    
    LDA.w $0D80, X : CMP.b #$03 : BCS .delta
    
    LDA.b #$03 : STA.w $0D80, X
    LDA.b #$20 : STA.w $0DF0, X
    
    .delta
    
    LDA.w $0EA0, X : BEQ .not_recoiling
    CMP.b #$04   : BCC .not_recoiling ; questionable label name
    
    JSR JavelinTrooper_NoticedPlayer.no_delay
    
    .not_recoiling
    
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_MoveIfNotTouchingWall
    JSR Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : REP #$30 : AND.w #$00FF : ASL A : TAY
    
    ; Hidden table! gah!!!
    LDA .states, Y : DEC A : PHA
    
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
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    JSL GetRandomInt : AND.b #$7F : ADC.b #$50 : STA.w $0DF0, X
    
    LDA.w $0DE0, X : PHA
    
    JSL GetRandomInt : AND.b #$03 : STA.w $0DE0, X
    
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
JavelinTrooper_WalkingAround:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$02 : STA.w $0D80, X
    
    LDA.b #$A0 : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    JSR Sprite_SpawnProbeStaggered
    
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    JSR Soldier_EnableDirectionLock
    
    .no_tile_collision
    
    LDY.w $0DE0, X
    
    LDA Soldier.x_speeds, Y : STA.w $0D50, X
    
    LDA Soldier.y_speeds, Y : STA.w $0D40, X
    
    TYA : STA.w $0EB0, X
    
    ; $02CEE2 ALTERNATE ENTRY POINT
    shared JavelinTrooper_Animate:
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$0F : BNE .gamma
    
    INC.w $0D90, X : LDA.w $0D90, X : CMP.b #$02 : BNE .gamma
    
    STZ.w $0D90, X
    
    .gamma
    
    LDA.w $0DE0, X : ASL #2 : ADC.w $0D90, X
    
    LDY.w $0E20, X : CPY.b #$48 : BNE .is_archer
    
    CLC : ADC.b #$10
    
    .is_archer
    
    TAY
    
    LDA Soldier.animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02CF13-$02CF43 LOCAL JUMP LOCATION
JavelinTrooper_LookingAround:
{
    JSR Sprite2_ZeroVelocity
    JSR Sprite_SpawnProbeStaggered
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$20 : STA.w $0DF0, X
    
    LDA.b #$00 : STA.w $0D80, X
    
    RTS
    
    .delay
    
    CMP.b #$80 : BCS .mucho_time_left
    
    LSR #3 : AND.b #$07 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $0000 : TAY
    
    LDA Soldier.head_looking_states, Y : STA.w $0EB0, X
    
    .mucho_time_left
    
    RTS
}

; ==============================================================================

; $02CF44-$02CF60 LOCAL JUMP LOCATION
JavelinTrooper_NoticedPlayer:
{
    JSR Sprite2_ZeroVelocity
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X
    
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
    .x_offsets_low
    db $B0, $50, $00, $F8
    db $B0, $50, $F8, $08
    
    .x_offsets_high
    db $FF, $00, $00, $FF
    db $FF, $00, $FF, $00
    
    .y_offsets_low
    db $08, $08, $B0, $50
    db $08, $08, $B0, $50
    
    .y_offsets_high
    db $00, $00, $FF, $00
    db $00, $00, $FF, $00
    
    .tile_collision_masks
    db $03, $03, $0C, $0C
}

; ==============================================================================

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
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0DE0, X : STA.w $0EB0, X
    
    LDA.w $0E20, X : CMP.b #$48 : BNE .is_archer
    
    INY #4
    
    .is_archer
    
    LDA.b $2222 : CLC : ADC .x_offsets_low, Y  : STA.b $0404
    LDA.b $23 : ADC .x_offsets_high, Y : STA.b $05
    
    LDA.b $20 : CLC : ADC .y_offsets_low, Y  : STA.b $06
    LDA.b $21 : ADC .y_offsets_high, Y : STA.b $0707
    
    LDA.b #$18
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    LDA.b $0E : CLC : ADC.b #$06 : CMP.b #$0C : BCS .delay_facing_player
    
    LDA.b $0F : CLC : ADC.b #$06 : CMP.b #$0C : BCC .collided
    
    .delay_facing_player
    
    INC.w $0E80, X
    
    JSR JavelinTrooper_Animate
    
    RTS
}

; ==============================================================================

; $02D001-$02D044 DATA
Pool_JavelinTrooper_Attack:
{
    .animation_states
    
    ; Archer Soldier's states
    db $19, $19, $18, $18, $17, $17, $17, $17
    db $13, $13, $12, $12, $11, $11, $11, $11
    
    db $10, $10, $0F, $0F, $0E, $0E, $0E, $0E
    db $16, $16, $15, $15, $14, $14, $14, $14
    
    ; Javelin trooper's states
    db $14, $14, $12, $12, $12, $10, $10, $10
    db $15, $15, $08, $08, $08, $06, $06, $06
    
    db $16, $16, $04, $04, $04, $03, $03, $03
    db $17, $17, $0F, $0F, $0F, $0B, $0B, $0B
    
    .scan_angles
    
    ; Not totally sold on this name (I came up with it).
    db $0D, $0D, $0C, $0C
}

; ==============================================================================

; $02D045-$02D08A LOCAL JUMP LOCATION
JavelinTrooper_Attack:
{
    LDY.w $0DE0, X
    
    LDA .scan_angles, Y : STA.w $0EC0, X
    
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
    
    JMP.w $C417 ; $02C417 IN ROM
    
    .delay
    
    STZ.w $0E80, X
    
    CMP.b #$28 : BCC .beta
    
    DEC.w $0E80, X
    
    .beta
    
    CMP.b #$0C : BNE .gamma
    
    PHA
    
    JSR JavelinTrooper_SpawnProjectile
    
    PLA
    
    .gamma
    
    LSR #3 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $00
    
    LDY.w $0E20, X : CPY.b #$48 : BNE .is_archer
    
    CLC : ADC.b #$20
    
    .is_archer
    
    TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02D08B-$02D0C4 DATA
    Pool_JavelinTrooper_SpawnProjectile
{
    .x_offsets_low
    db $10, $F8, $03, $0B
    db $0C, $FC, $0C, $FC
    
    .x_offsets_high
    db $00, $FF, $00, $00
    db $00, $FF, $00, $FF
    
    .y_offsets_low
    db $02, $02, $10, $F8
    db $FE, $FE, $02, $F8
    
    .y_offsets_high
    db $00, $00, $00, $FF
    db $FF, $FF, $00, $FF
    
    ; $2D0AB
    .x_speeds length 8
    db $30, $D0, $00, $00
    db $20, $E0
    
    ; $2D0B1
    .y_speeds
    db $00, $00, $30, $D0
    db $00, $00, $20, $E0
    
    ; $2D0B9
    .unknown
    ; While it is 'unknown', it seems like these were probably
    ; meant to be the direction of the arrow / javelin sprites?
    db $03, $02, $01, $00
    db $03, $02, $01, $00
    
    ; $2D0C1
    .hit_boxes
    db $05, $05, $06, $06
}

; ==============================================================================

; $02D0C5-$02D140 LOCAL JUMP LOCATION
JavelinTrooper_SpawnProjectile:
{
    LDA.b #$1B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$05 : JSL Sound_SetSfx3PanLong
    
    PHX
    
    LDA.w $0E20, X : CMP.b #$48 : LDA.w $0DE0, X : BCC .is_archer
    
    CLC : ADC.b #$04
    
    .is_archer
    
    TAX
    
    LDA.b $00 : CLC : ADC .x_offsets_low, X  : STA.w $0D10, Y
    LDA.b $0101 : ADC .x_offsets_high, X : STA.w $0D30, Y
    
    LDA.b $0202 : CLC : ADC .y_offsets_low, X  : STA.w $0D00, Y
    LDA.b $0303 : ADC .y_offsets_high, X : STA.w $0D20, Y
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    TXA : AND.b #$03 : STA.w $0DE0, Y : TAX
    
    LDA .hit_boxes, X : STA.w $0F60, Y
    
    LDA.b #$00 : STA.w $0F70, Y
    
    PLX
    
    LDA.w $0E20, X : CMP.b #$48 : LDA.b #$00 : BCC .is_archer_2
    
    INC A

    .is_archer_2

    STA.w $0D90, Y : BEQ .dont_disable_blockability
    
    LDA.l $7EF35A : BNE .player_has_shield
    
    ; Make the arrow unblockable by shield (which is dumb, because we
    ; alraedy verified that the player doesn't have a shield <___<.)
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
    
    LDA.w $0F50, X : PHA : AND.b #$F1 : ORA.b #$02 : STA.w $0F50, X
    
    REP #$20
    
    LDA.w $0FDA : PHA : CLC : ADC.w #$0008 : STA.w $0FDA
    
    SEP #$20
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    REP #$20
    
    PLA : STA.w $0FDA
    
    SEP #$20
    
    PLA : STA.w $0F50, X
    PLA : STA.w $0DC0, X
    
    JSR Sprite2_PrepOamCoord
    
    LDY.b #$10
    
    JSR.w $C6E0 ; $02C6E0 IN ROM
    
    LDY.b #$0C
    
    JSR.w $B3CD ; $02B3CD IN ROM
    
    LDA.w $0DC0, X : CMP.b #$14 : BCS .alpha
    
    LDY.b #$04
    
    JSR.w $CD4A ; $02CD4A IN ROM

    .alpha

    JMP.w $C68C ; $02C68C IN ROM
}

; ==============================================================================

; $02D192-$02D1AB LOCAL JUMP LOCATION
JavelinTrooper_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDY.b #$0C
    
    JSR.w $B160 ; $02B160 IN ROM
    
    LDY.b #$08
    
    JSR.w $B3CD ; $02B3CD IN ROM
    
    LDA.w $0DC0, X : CMP.b #$14 : BCS .alpha
    
    JSR.w $CD48 ; $02CD48 IN ROM

    .alpha

    JMP.w $C68C ; $02C68C IN ROM
}

; ==============================================================================

; $02D1AC-$02D1F4 JUMP LOCATION
Sprite_BushJavelinSoldier:
{
    LDA.w $0D80, X : BEQ .alpha
    CMP.b #$02   : BNE .beta
    
    JSR BushJavelinSoldier_Draw
    
    BRA .alpha
    
    .beta
    
    JSR.w $D321 ; $02D321 IN ROM
    
    .alpha
    
    BRA .gamma
    
    ; $02D1BF ALTERNATE ENTRY POINT
    shared Sprite_BushArcherSoldier:
    
    LDA.w $0D80, X : BEQ .gamma
    
    LDA.w $0DC0, X : CMP.b #$0E : BCC .delta
    
    JSR ArcherSoldier_Draw
    
    BRA .gamma
    
    .delta
    
    JSR.w $D321 ; $02D321 IN ROM
    
    .gamma
    
    JSR Sprite2_CheckIfActive
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL A : TAY
    
    ; Hidden table! gah!!!
    LDA .states, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    .states
    
    dw $D1F5 ; $2D1F5
    dw $D223 ; $2D223
    dw $D277 ; $2D277
    dw $D2CE ; $2D2CE
}

; $02D1F5-$02D202 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02D203-$02D222 DATA
{
    .animation_states
    db 4, 4, 4, 4, 4, 4, 4, 4
    db 0, 1, 0, 1, 0, 1, 0, 1
    db 0, 1, 0, 1, 0, 1, 0, 1
    db 0, 1, 0, 1, 0, 1, 0, 1
}

; ==============================================================================

; $02D223-$02D251 JUMP LOCATION
{
    JSL.l $06F2AA ; $0372AA IN ROM
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    JSR.w $F93F ; $02F93F IN ROM
    
    TYA : STA.w $0DE0, X : STA.w $0EB0, X
    
    RTS
    
    .delay
    
    CMP.b #$20 : BNE .alpha
    
    PHA
    
    JSR.w $D252 ; $02D252 IN ROM
    
    PLA : LSR #2 : TAY
    
    LDA.w $D203, Y : STA.w $0DC0, X
    
    RTS
    
    .alpha
    
}

; $02D252-$02D276 LOCAL JUMP LOCATION
{
    LDA.b #$EC : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$06 : STA.w $0DD0, Y
    
    LDA.b #$20 : STA.w $0DF0, Y
    
    LDA.w $0E40, Y : CLC : ADC.b #$03 : STA.w $0E40, Y
    
    LDA.b #$02 : STA.w $0DB0, Y
    
    .spawn_failed
    
    RTS
}

; $02D277-$02D2BD JUMP LOCATION
{
    STZ.w $0BA0, X
    
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    BRA .BRANCH_$2D2CE

    .BRANCH_ALPHA

    STZ.w $0D90, X
    
    CMP.b #$28 : BCS .BRANCH_BETA
    
    DEC.w $0D90, X

    .BRANCH_BETA

    CMP.b #$10 : BNE .BRANCH_GAMMA
    
    PHA
    
    JSR JavelinTrooper_SpawnProjectile
    
    PLA

    .BRANCH_GAMMA

    LSR #3 : STA.b $0000
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $0000
    
    LDY.w $0E20, X : CPY.b #$49 : BNE .BRANCH_DELTA
    
    CLC : ADC.b #$20

    .BRANCH_DELTA

    TAY
    
    LDA JavelinTrooper_Attack.animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; $02D2CE-$02D2E8 JUMP LOCATION
{
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    STZ.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LSR #2 : TAY
    
    LDA.w $D2BE, Y : STA.w $0DC0, X
    
    RTS
}

; $02D321-$02D380 LOCAL JUMP LOCATION
{
    JSR Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL A : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $0202 : CLC : ADC.w $D2E9, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
    
    LDA.w #$00F0 : STA ($90), Y
    
    .alpha
    
    SEP #$20
    
    PLX
    
    LDA.w $D305, X : INY : STA ($90), Y
    
    LDA.w $D313, X : ORA.b #$20 : PLX : BNE .beta
    
    AND.b #$F1 : ORA.b $050505
    
    .beta
    
    INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================

; $02D381-$02D38B DATA
Pool_ArcherSoldier_Draw:
{
    ; \task come up with better names for these
    .oam_indices_0 length 4
    db 0, 0, 0
    
    .oam_indices_1
    db $10, $10, $10, $00
    
    .oam_indices_2
    db $14, $14, $14, $04
}

; ==============================================================================

; $02D38C-$02D3AF LOCAL JUMP LOCATION
ArcherSoldier_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDY.w $0DE0, X
    
    LDA .oam_indices_1, Y : TAY
    
    JSR.w $C6E0   ; $02C6E0 IN ROM
    
    LDY.w $0DE0, X
    
    LDA .oam_indices_2, Y : TAY
    
    JSR.w $CA10   ; $02CA10 IN ROM
    
    LDY.w $0DE0, X
    
    LDA .oam_indices_0, Y : TAY
    
    JSR.w $D4D4   ; $02D4D4 IN ROM
    JMP.w $C68C   ; $02C68C IN ROM
}

; ==============================================================================

; $02D4D4-$02D53A LOCAL JUMP LOCATION
{
    LDA.w $0DC0, X : SEC : SBC.b #$0E : BCS .alpha
    
    PHY
    
    LDY.w $0DE0, X
    
    LDA.w $D4D0, Y
    
    PLY
    
    .alpha
    
    ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .gamma
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w $D3B0, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC.w $D410, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .beta
    
    LDA.w #$00F0 : STA ($90), Y
    
    .beta
    
    SEP #$20
    
    PLX
    
    LDA.w $D470, X              : INY : STA ($90), Y
    LDA.w $D4A0, X : ORA.b #$20 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================

incsrc "sprite_tutorial_entities.asm"
incsrc "sprite_pull_switch.asm"
incsrc "sprite_uncle_and_priest.asm"

; ==============================================================================

; $02DF6C-$02DFE4 LONG JUMP LOCATION
Sprite_DrawMultiple:
{
    ; Widely called, seems to do with placing sprite graphics
    ; into OAM
    
    STA.b $06
    STZ.b $07
    
    ; $02DF70 ALTERNATE ENTRY POINT
    .quantity_preset
    
    JSR.w $DFE9 ; $02DFE9 IN ROM
    
    BRA .moving_on
    
    ; $02DF75 ALTERNATE ENTRY POINT
    .player_deferred
    
    JSR.w $DFE5 ; $02DFE5 IN ROM
    
    .moving_on
    
    ; Branch will be taken if the sprite were disabled due to being off
    ; screen or something akin to that.
    BCS .return
    
    PHX
    
    ; Routine is definitely used in drawing maidens.
    REP #$30
    
    LDY.w #$0000
    
    LDX.w $0090
    
    .next_oam_entry
    
    LDA ($08), Y : CLC : ADC.b $00 : STA.w $0000, X : AND.w #$0100 : STA.b $0C
    
    INY #2
    
    LDA ($08), Y : CLC : ADC.b $02 : STA.w $0001, X
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
    
    LDA.w #$00F0 : STA.w $0001, X
    
    .on_screen_y
    
    INY #2
    
    LDA.w $0CFE : CMP.w #$0001
    
    LDA ($08), Y : EOR.b $04 : BCC .dont_override_palette
    
    ; Force sprite to use palette 2.
    AND.w #$F1FF : ORA.w #$0400
    
    .dont_override_palette
    
    STA.w $0002, X
    
    PHX
    
    TXA : SEC : SBC.w #$0800 : LSR #2 : TAX
    
    SEP #$20
    
    INY #3
    
    LDA ($08), Y : ORA.b $0D : STA.w $0A20, X
    
    PLX
    
    REP #$20
    
    INY
    
    INX #4
    
    DEC.b $06 : BNE .next_oam_entry
    
    SEP #$30
    
    PLX
    
    .return
    
    RTL
}

; ==============================================================================

; $02DFE5-$02E00A LOCAL JUMP LOCATION
{
    ; Has two return values (CLC and SEC)
    
    ; Optinally alter OAM allocation region.
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    
    ; $02DFE9 ALTERNATE ENTRY POINT
    
    ; Note: it is possible for this callee to abort the caller (namely, the
    ; routine we are in right now).
    JSR Sprite2_PrepOamCoord
    
    ; Preserves the CLC or SEC status
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

incsrc "sprite_quarrel_bros.asm"

; ==============================================================================

; $02E1A3-$02E1A6 DATA
Pool_Sprite_ShowSolicitedMessageIfPlayerFacing:
{
    .facing_direction
    db $04, $06, $00, $02
}

; ==============================================================================

; $02E1A7-$02E1EF LONG JUMP LOCATION
Sprite_ShowSolicitedMessageIfPlayerFacing:
{
    ; Handles text messages
    
    STA.w $1CF0
    STY.w $1CF1
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .alpha
    
    LDA.b $F6 : BPL .alpha
    
    LDA.w $0F10, X : BNE .alpha
    
    LDA.b $4D : CMP.b #$02 : BEQ .alpha
    
    JSR Sprite2_DirectionToFacePlayer : PHX : TYX
    
    ; Make sure that the sprite is facing towards the player, otherwise
    ; talking can't happen. (What sprites actually use this???)
    LDA .facing_direction, X : PLX : CMP $2F : BNE .not_facing_each_other
    
    PHY
    
    LDA.w $1CF0
    LDY.w $1CF1
    
    JSL Sprite_ShowMessageUnconditional
    
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

; $02E1F0-$02E218 LONG JUMP LOCATION
Sprite_ShowMessageFromPlayerContact:
{
    ; You might be wondering how this differs from the similarly named
    ; "Sprite_ShowMessageIfPlayerTouching", and the answer is there's
    ; really not much difference at all. Feel free to let me know if you
    ; discern any significant difference, other than that this one
    ; reports a direction as a return value in the accumulator.
    
    STA.w $1CF0
    STY.w $1CF1
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_show
    
    LDA.b $4D : CMP.b #$02 : BEQ .dont_show
    
    LDA.w $1CF0
    LDY.w $1CF1
    
    JSL Sprite_ShowMessageUnconditional
    
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03
    
    SEC
    
    RTL
    
    .dont_show
    
    LDA.w $0DE0, X
    
    CLC
    
    RTL
}

; ==============================================================================

; $02E219-$02E24C LONG JUMP LOCATION
Sprite_ShowMessageUnconditional:
{
    ; Routine is used to display a text message with
    ; an ID that is inputted via A and Y registers.
    ; A = low byte of message ID to use.
    ; Y = high byte of message ID to use.
    
    STA.w $1CF0
    STY.w $1CF1
    
    STZ.w $0223
    STZ.w $1CD8
    
    LDA.b #$02 : STA.b $11
    
    LDA.b $10 : STA.w $010C
    
    LDA.b #$0E : STA.b $10
    
    PHX
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ.b $5E
    
    JSL Player_HaltDashAttackLong
    
    STZ.b $4D
    STZ.b $46
    
    LDA.b $5D : CMP.b #$02 : BNE .alpha
    
    LDA.b #$00 : STA.b $5D
    
    .alpha
    
    PLX
    
    RTL
}

; ==============================================================================

incsrc "sprite_pull_for_rupees.asm"
incsrc "sprite_gargoyle_grate.asm"
incsrc "sprite_young_snitch_lady.asm"
incsrc "sprite_inn_keeper.asm"
incsrc "sprite_witch.asm"
incsrc "sprite_arrow_target.asm"

; ==============================================================================

; $02E657-$02E665 LONG UNUSED
Sprite2_TrendHorizSpeedToZero:
{
    ; Appears to be unsued, or orphaned code for now...
    
    LDA.w $0D50, X : BEQ .at_rest : BPL .positive_velocity
    
    INC A
    
    BRA .moving_on
    
    .positive_velocity
    
    DEC A
    
    .moving_on
    .at_rest
    
    STA.w $0D50, X
    
    RTL
}

; ==============================================================================

; $02E666-$02E674 LONG UNUSED
Sprite2_TrendVertSpeedToZero:
{
    LDA.w $0D40, X : BEQ .at_rest : BPL .positive_velocity
    
    INC A
    
    BRA .moving_on
    
    .positive_velocity
    
    DEC A
    
    .moving_on
    .at_rest
    
    STA.w $0D40, X
    
    RTL
}

; ==============================================================================

incsrc "sprite_old_snitch_lady.asm"
incsrc "sprite_running_man.asm"
incsrc "sprite_bottle_vendor.asm"
incsrc "sprite_zelda.asm"
incsrc "sprite_mushroom.asm"
incsrc "sprite_fake_sword.asm"
incsrc "sprite_heart_upgrades.asm"
incsrc "sprite_elder.asm"
incsrc "sprite_medallion_tablet.asm"
incsrc "sprite_elder_wife.asm"
incsrc "sprite_potion_shop.asm"
    
; ==============================================================================

; $02F93F-$02F943 LOCAL JUMP LOCATION
Sprite2_DirectionToFacePlayer:
{
    JSL Sprite_DirectionToFacePlayerLong
    
    RTS
}

; ==============================================================================

; $02F944-$02F948 LOCAL JUMP LOCATION
Sprite2_IsToRightOfPlayer:
{
    JSL Sprite_IsToRightOfPlayerLong
    
    RTS
}

; ==============================================================================

; $02F949-$02F94D LOCAL JUMP LOCATION
Sprite2_IsBelowPlayer:
{
    JSL Sprite_IsBelowPlayerLong
    
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

; ==============================================================================

; $02F971-$02F9EC LOCAL JUMP LOCATION
Sprite2_CheckIfRecoiling:
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
    
    JSR Sprite2_CheckTileCollision
    
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
    
    JSR Sprite2_Move
    
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
    JSR Sprite2_MoveHoriz
    JSR Sprite2_MoveVert
    
    RTS
}

; ==============================================================================

; $02F9F4-$02F9FF LOCAL JUMP LOCATION
Sprite2_MoveHoriz:
{
    TXA : CLC : ADC.b #$10 : TAX
    
    JSR Sprite2_MoveVert
    
    LDX.w $0FA0
    
    RTS
}

; ==============================================================================

; $02FA00-$02FA2D LOCAL JUMP LOCATION
Sprite2_MoveVert:
{
    LDA.w $0D40, X : BEQ .no_velocity
    
    ASL #4 : CLC : ADC.w $0D60, X : STA.w $0D60, X
    
    LDA.w $0D40, X : PHP : LSR #4 : LDY.b #$00 : PLP : BPL .positive
    
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
    
    LDA.w $0F80, X : PHP : LSR #4 : PLP : BPL .positive
    
    ORA.b #$F0
    
    .positive
    
    ADC.w $0F70, X : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $02FA50-$02FA58 LOCAL JUMP LOCATION
Sprite2_PrepOamCoord:
{
    ; Collision detecting function (at least it calls one in bank $06)
    
    JSL Sprite_PrepOamCoordLong : BCC .sprite_wasnt_disabled
    
    PLA : PLA
    
    .sprite_wasnt_disabled
    
    RTS
}

; ==============================================================================

; $02FA59-$02FAA1 LONG JUMP LOCATION
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
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong
    
    PLA : STA.w $0F60, X
    PLA : STA.w $0E40, X
    
    BCC .dontShowDialogue
    
    PHP
    
    JSL Sprite_NullifyHookshotDrag
    
    PLP
    
    STZ.w $0372
    STZ.b $5E
    
    LDA.b $4D : BNE .dontShowDialogue
    
    ; $02FA8E ALTERNATE ENTRY POINT
    shared Sprite_ShowMessageMinimal:
    
    STZ.w $0223
    STZ.w $1CD8
    
    LDA.b #$02 : STA.b $11
    
    LDA.b $10 : STA.w $010C
    
    LDA.b #$0E : STA.b $10
    
    .dontShowDialogue
    
    RTL
}

; ==============================================================================

; $02FAA2-$02FAC9 LONG JUMP LOCATION
Overworld_ReadTileAttr:
{
    ; \task (rather a bug in the way I named this routine...
    ; seems more like a map16 attr reader than a map8 reader. Fixme!
    REP #$30
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
    LDA.b $02 : SEC : SBC.w $070C : AND.w $070E : ORA.b $06 : TAX
    
    LDA.l $7E2000, X : TAX
    
    LDA.l $1BF110, X ; $DF110, X THAT IS
    
    SEP #$30
    
    RTL
}

; ==============================================================================

incsrc "sprite_mad_batter.asm"
incsrc "sprite_dash_item.asm"
incsrc "sprite_trough_boy.asm"

; ==============================================================================

warnpc $068000
