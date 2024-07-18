; ==============================================================================

; Bank 1D
; $0E8000-$0EFFFF
org $1D8000

; Sprite 4 Main
; Misc NPC Sprites
; Misc Enemy Sprites
; Boss Sprites

; ==============================================================================

; $0E8000-$0E800F DATA
Pool_Sprite_ApplyConveyorAdjustment:
{
    .x_shake_values
    db  1, -1
    
    .y_shake_values
    db 0, -1
    
    .y_speeds_high length 4
    db -1,  0
    
    .x_speeds_low length 4
    db  0,  0
    
    .y_speeds_low
    db -1,  1,  0,  0
    
    .x_high
    db  0,  0, -1,  0
}

; ==============================================================================

; $0E8010-$0E803F LONG JUMP LOCATION
Sprite_ApplyConveyorAdjustment:
{
    ; Seems like this handles the velocity adjustment that a conveyor
    ; belt provides. The input for Y only allows for tile types 0x68 to
    ; 0x6B.
    
    LDA.b $1A : LSR A : BCC .return
        PHB : PHK : PLB
        
        ; I think it is perhaps possible that the low byte offset is an
        ; incorrectly calculated address. It overlaps with that of the Y
        ; coordinate's adjustment.
        LDA.w $0D10, X : CLC : ADC .x_speeds_low       , Y : STA.w $0D10, X
        LDA.w $0D30, X :       ADC .x_speeds_high - $68, Y : STA.w $0D30, X
        
        LDA.w $0D00, X : CLC : ADC .y_speeds_low  - $68, Y : STA.w $0D00, X
        LDA.w $0D20, X :       ADC .y_speeds_high - $68, Y : STA.w $0D20, X
        
        PLB
    
    .return
    
    RTL
}

; ==============================================================================

; $0E8040-$0E808B LONG JUMP LOCATION
Sprite_CreateDeflectedArrow:
{
    ; Creates a ... arrow that has been deflected (as in, now it's falling)
    ; This is the opposite of the arrow ending up stuck in an enemy or wall.
    
    PHB : PHK : PLB
    
    PHY
    
    STZ.w $0C4A, X
    
    LDA.b #$1B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.w $0C04, X : STA.w $0D10, Y
        LDA.w $0C18, X : STA.w $0D30, Y
        
        LDA.w $0BFA, X : STA.w $0D00, Y
        LDA.w $0C0E, X : STA.w $0D20, Y
        
        LDA.b #$06 : STA.w $0DD0, Y
        
        LDA.b #$1F : STA.w $0DF0, Y
        
        LDA.w $0C2C, X : STA.w $0D50, Y
        
        LDA.w $0C22, X : STA.w $0D40, Y
        
        LDA.b $EE : STA.w $0F20, Y
        
        PHX
        
        TYX
        
        JSL Sprite_PlaceRupulseSpark
        
        PLX
    
    .spawn_failed
    
    PLY
    
    PLB
    
    RTL
}

; ==============================================================================

; $0E808C-$0E8093 LONG JUMP LOCATION
Sprite_MoveLong:
{
    ; Invoked from ending mode usually...?
    PHB : PHK : PLB
    
    JSR Sprite4_Move
    
    PLB
    
    RTL
}

; ==============================================================================

; $0E8094-$0E8098 LOCAL JUMP LOCATION
Sprite4_CheckTileCollision:
{
    JSL Sprite_CheckTileCollisionLong
    
    RTS
}

; ==============================================================================

; $0E8099-$0E8128
incsrc "sprite_landmine.asm"

; $0E8129-$0E8234
incsrc "sprite_stal.asm"

; $0E8235-$0E84F0
incsrc "sprite_fish.asm"

; $0E84F1-$0E8669
incsrc "sprite_rabbit_beam.asm"

; $0E866A-$0E88A0
incsrc "sprite_lynel.asm"

; $0E88A1-$0E8AB5
incsrc "sprite_phantom_ganon.asm"

; $0E8AB6-$0E8B48
incsrc "sprite_trident.asm"

; $0E8B49-$0E8B51
incsrc "sprite_flame_trail_bat.asm"

; $0E8B52-$0E8BD0
incsrc "sprite_spiral_fire_bat.asm"

; $0E8BD1-$0E8D05
incsrc "sprite_fire_bat.asm"

; $0E8D06-$0E9C79
incsrc "sprite_ganon.asm"

; $0E9C7A-$0EA03B
incsrc "sprite_swamola.asm"

; $0EA03C-$0EAD0D
incsrc "sprite_blind_entities.asm"

; $0EAD0E-$0EB772
incsrc "sprite_trinexx.asm"

; $0EB897-$0EBE3B
incsrc "sprite_sidenexx.asm"

; $0EBE3C-$0EC210
incsrc "sprite_chain_chomp.asm"

; ==============================================================================

; $0EC211-$0EC219 LOCAL JUMP LOCATION
Sprite4_CheckDamage:
{
    JSL Sprite_CheckDamageFromPlayerLong
    JSL Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; $0EC21A-$0EC221 LONG JUMP LOCATION
SpriteActive4_MainLong:
{
    PHB : PHK : PLB
    
    JSR SpriteActive4_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EC222-$0EC26C LOCAL JUMP LOCATION
SpriteActive4_Main:
{
    ; Ranges from 0 to 0x1A (since highest pointer is 0xD7).
    LDA.w $0E20, X : SEC : SBC.b #$BD : REP #$30 : AND.w #$00FF : ASL A : TAY
    
    ; Again, we have a subtle jump table by means of stack manipulation.
    LDA .handlers, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    .handlers
    ; Sprite routines 4
    ; 
    ; Numbers in the index are actual sprite values, not the indexed values
    ; for the table itself in rom.
    
    dw Sprite_Vitreous             ; 0xBD Vitreous
    dw Sprite_Vitreolus            ; 0xBE "???" in hyrule magic 
    dw Sprite_Lightning            ; 0xBF Vitreous' Lightning (also Agahnim)
    dw Sprite_GreatCatfish         ; 0xC0 Lake of Ill Omen Monster
    dw Sprite_ChattyAgahnim        ; 0xC1 Agahnim teleporting Zelda to darkworld
    dw Sprite_Boulder              ; 0xC2 Boulders / Lanmola Shrapnel
    dw Sprite_Gibo                 ; 0xC3 Symbion 2
    dw Sprite_Thief                ; 0xC4 Thief
    dw Sprite_Medusa               ; 0xC5 Evil fireball spitting faces!
    dw Sprite_FireballJunction     ; 0xC6 Four way fireball spitters
    dw Sprite_Hokbok               ; 0xC7 Hokbok and its segments (I call them Ricochet)
    dw Sprite_BigFairy             ; 0xC8 Big Fairy / Fairy Dust Cloud
    dw Sprite_GanonHelpers         ; 0xC9 Ganon's Firebat, Tektite and friends
    dw Sprite_ChainChomp           ; 0xCA Chain Chomp
    dw Sprite_Trinexx              ; 0xCB Trinexx 1
    dw $B897 ; = $0EB897           ; 0xCC Trinexx 2
    dw $B89F ; = $0EB89F           ; 0xCD Trinexx 3
    dw Sprite_BlindEntities        ; 0xCE Blind the Thief
    dw Sprite_Swamola              ; 0xCF Swamola
    dw Sprite_Lynel                ; 0xD0 Lynel
    dw Sprite_ChimneyAndRabbitBeam ; 0xD1 Yellow Hunter pointer
    dw Sprite_Fish                 ; 0xD2 flopping fish
    dw Sprite_Stal                 ; 0xD3 Stal
    dw Sprite_Landmine             ; 0xD4 Landmine
    dw Sprite_DiggingGameGuy       ; 0xD5 Digging game guy
    dw Sprite_Ganon                ; 0xD6 Pointer for Ganon.
    dw Sprite_Ganon                ; 0xD7 Pointer for Ganon when he's invincible (blue mode)
}

; ==============================================================================

; $0EC26D-$0EC411
incsrc "sprite_tektite.asm"

; $0EC412-$0EC64E
incsrc "sprite_big_fairy.asm"

; $0EC64F-$0EC7EA
incsrc "sprite_hokbok.asm"

; $0EC7EB-$0EC852
incsrc "sprite_medusa.asm"

; $0EC853-$0EC8CB
incsrc "sprite_fireball_junction.asm"

; $0EC8CC-$0ECCDA
incsrc "sprite_thief.asm"

; $0ECCDB-$0ECFC2
incsrc "sprite_gibo.asm"

; $0ECFC3-$0ED1FC
incsrc "sprite_boulder.asm"

; $0ED1FD-$0ED6D0
incsrc "sprite_chatty_agahnim.asm"

; $0ED6D1-$0EDC71
incsrc "sprite_giant_moldorm.asm"

; $0EDC72-$0EDD7A
incsrc "sprite_vulture.asm"

; $0EDD7B-$0EDE81
incsrc "sprite_raven.asm"

; ==============================================================================

; $0EDE82-$0EDE89 LONG JUMP LOCATION
Vitreous_SpawnSmallerEyesLong:
{
    PHB : PHK : PLB
    
    JSR Vitreous_SpawnSmallerEyes
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EDE8A-$0EDECA DATA
Pool_Vitreous_SpawnSmallerEyes:
{
    ; $0EDE8A
    .offset_x_low
    db   8,   22,   -8,  -22,    0,   14,   19,   33
    db  26,  -14,  -19,  -33,  -26

    ; $0EDE97
    .offset_x_high
    db   0,    0,   -1,   -1,    0,    0,    0,    0
    db   0,   -1,   -1,   -1,   -1

    ; $0EDEA4
    .offset_y_low
    db  -8,  -12,   -8,  -12,    0,  -20,   -1,  -12
    db -24,  -20,   -1,  -12,  -24

    ; $0EDEB1
    .offset_y_high
    db  -1,   -1,   -1,   -1,    0,   -1,   -1,   -1
    db  -1,   -1,   -1,   -1,   -1

    ; $0EDEBE
    .anim_state
    db $01,  $01,  $01,  $01,  $00,  $00,  $00,  $00
    db $00,  $00,  $00,  $00,  $00
}

; $0EDECB-$0EDF44 LOCAL JUMP LOCATION
Vitreous_SpawnSmallerEyes:
{
    LDA.b #$09 : STA.w $0ED0, X
    
    LDA.b #$04 : STA.w $0DC0, X
    
    LDY.b #$0D
    
    JSL Sprite_SpawnDynamically_arbitrary
    
    LDY.b #$0C
    
    .next_eyeball
    
        LDA.b #$09 : STA.w $0DD1, Y
        
        LDA.b #$BE : STA.w $0E21, Y
        
        PHX : TYX : INX
        
        JSL Sprite_LoadProperties
        
        PLX
        
        LDA.b #$00 : STA.w $0F21, Y
        
        LDA.b $00 : CLC : ADC.w $DE8A, Y : STA.w $0D11, Y
                                           STA.w $0D91, Y
        
        LDA.b $01 : ADC.w $DE97, Y : STA.w $0D31, Y
                                     STA.w $0DA1, Y
        
        LDA.b $02 : CLC : ADC.w $DEA4, Y : PHP
                    CLC : ADC.b #$20     : STA.w $0D01, Y
                                           STA.w $0DB1, Y
        
        LDA.b $03 : ADC.b #$00     : PLP
                    ADC.w $DEB1, Y : STA.w $0D21, Y
                                     STA.w $0DE1, Y
        
        LDA.w $DEBE, Y : STA.w $0DC1, Y : STA.w $0BA1, Y
        
        TYA : ASL #3 : STA.b $0F
        
        JSL GetRandomInt : ADC.b $0F : STA.w $0E81, Y
    DEY : BPL .next_eyeball
    
    RTS
}

; ==============================================================================

; $0EDF45-$0EE39C
incsrc "sprite_great_catfish.asm"

; $0EE3ED-$0EE4C7
incsrc "sprite_lightning.asm"

; $0EE4C8-$0EE762
incsrc "sprite_vitreous.asm"

; $0EE763-$0EE892
incsrc "sprite_vitreolus.asm"

; ==============================================================================

; $0EE893-$0EE897 LOCAL JUMP LOCATION
Sprite4_DirectionToFacePlayer:
{
    JSL Sprite_DirectionToFacePlayerLong
    
    RTS
}

; ==============================================================================

; $0EE898-$0EE89C LOCAL JUMP LOCATION
Sprite4_IsToRightOfPlayer:
{
    JSL Sprite_IsToRightOfPlayerLong
    
    RTS
}

; ==============================================================================

; $0EE89D-$0EE8A1 LOCAL JUMP LOCATION
Sprite4_IsBelowPlayer:
{
    JSL Sprite_IsBelowPlayerLong
    
    RTS
}

; ==============================================================================

; $0EE8A2-$0EE8BE LOCAL JUMP LOCATION
Sprite4_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
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

; $0EE8C5-$0EE947 LOCAL JUMP LOCATION
Sprite4_CheckIfRecoiling:
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
                
                LDA.b $1A : AND.w $E8BF, Y : BNE .halted
                    LDA.w $0F30, X : STA.w $0D40, X
                    LDA.w $0F40, X : STA.w $0D50, X
                    
                    LDA.w $0CD2, X : BMI .no_wall_collision
                        JSR Sprite4_CheckTileCollision
                        
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
                    
                    JSR Sprite4_Move
            
            .halted
            
            PLA : STA.w $0D50, X
            PLA : STA.w $0D40, X
            
            ; Blind the thief. \task Apply enumerated value here when it becomes
            ; available.
            LDA.w $0E20, X : CMP.b #$CE : BEQ .return
                PLA : PLA
    
    .return
    
    RTS
    
    .recoil_finished
    
    STZ.w $0EA0, X
    
    RTS
}

; ==============================================================================

; $0EE948-$0EE94A LOCAL JUMP LOCATION
Sprite4_MoveXyz:
{
    JSR Sprite4_MoveAltitude

    ; Bleeds into the next function.
}
    
; $0EE94B-$0EE951 LOCAL JUMP LOCATION
Sprite4_Move:
{
    JSR Sprite4_MoveHoriz
    JSR Sprite4_MoveVert
    
    RTS
}

; ==============================================================================

; $0EE952-$0EE95C LOCAL JUMP LOCATION
Sprite4_MoveHoriz:
{
    PHX : TXA : CLC : ADC.b #$10 : TAX
    
    JSR Sprite4_MoveVert
    
    PLX
    
    RTS
}

; ==============================================================================

; $0EE95D-$0EE98A LOCAL JUMP LOCATION
Sprite4_MoveVert:
{
    LDA.w $0D40, X : BEQ .no_velocity
        ASL #4 : CLC : ADC.w $0D60, X : STA.w $0D60, X
        
        LDA.w $0D40, X : PHP : LSR #4 : LDY.b #$00 : PLP : BPL .positive
            ORA.b #$F0
            
            DEY
        
        .positive
        
        ADC.w $0D00, X : STA.w $0D00, X
        TYA
        ADC.w $0D20, X : STA.w $0D20, X
    
    .no_velocity
    
    RTS
}

; ==============================================================================

; $0EE98B-$0EE9AC LOCAL JUMP LOCATION
Sprite4_MoveAltitude:
{
    LDA.w $0F80, X : ASL #4 : CLC : ADC.w $0F90, X : STA.w $0F90, X
    
    ; Sign extend the difference from 4 bits to 8.
    LDA.w $0F80, X : PHP : LSR #4 : PLP : BPL .sign_extend
        ORA.b #$F0
    
    .sign_extend
    
    ADC.w $0F70, X : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $0EE9AD-$0EE9B5 LOCAL JUMP LOCATION
Sprite4_PrepOamCoord:
{
    JSL Sprite_PrepOamCoordLong : BCC .sprite_wasnt_disabled
        PLA : PLA
    
    .sprite_wasnt_disabled
    
    RTS
}

; ==============================================================================

; $0EE9B6-$0EE9D9 LONG JUMP LOCATION
Filter_MajorWhitenMain:
{
    LDA.w $0FF9 : BEQ .major_white_filter_inactive
        LDY.b $11 : BNE .major_white_filter_inactive
            DEC.w $0FF9 : BNE .filter_still_active
                ; Restore the whole set of BG palettes, even the HUD ones? I
                ; don't quite understand why this is necessary though, as the
                ; HUD palettes weren't (intentionally) modified by this
                ; particular subset of the game logic.
                JSL Palette_Restore_BG_And_HUD
                
                RTL
            
            .filter_still_active
            
            AND.b #$01 : BEQ .restore_palette
                JSL Filter_Majorly_Whiten_Bg
                
                BRA .set_palette_update_flag
            
            .restore_palette
            
            JSL Palette_Restore_BG_From_Flash
            
            .set_palette_update_flag
            
            INC.b $15
    
    .major_white_filter_inactive
    
    RTL
}

; ==============================================================================

; $0EE9DA-$0EE9FF LONG JUMP LOCATION
CacheSprite_ExecuteAll:
{
    ; Some kind of special enemy "switch out".
    ; It's used on certain room transitions where the enemies from both rooms
    ; are supposed to remain visible (excludes spiral staircases).
    
    ; Don't do this outdoors.
    LDA.b $1B : BEQ .return
        ; Don't use if in "normal" submode.
        ; Don't use if going on a spiral staircase.
        LDA.b $11  : BEQ .return
        CMP.b #$0E : BEQ .return
            ; The last screen transition occurred on the overworld, and no 
            ; sprites were cached anyways.
            LDA.w $0FFA : BEQ .return
                LDX.b #$0F
                
                .next_cached_sprite
                
                    STX.w $0FA0
                    
                    LDA.w $1D00, X : BEQ .inactive_cached_sprite
                        JSR CacheSprite_ExecuteSingle
                    
                    .inactive_cached_sprite
                DEX : BPL .next_cached_sprite
                
                RTL
    
    .return
    
    STZ.w $0FFA
    
    RTL
}

; ==============================================================================

; $0EEA00-$0EEB67 LOCAL JUMP LOCATION
CacheSprite_ExecuteSingle:
{
    ; Save the relevant data of this non-cached sprite before
    ; swapping in the cached sprite data.
    LDA.w $0DD0, X : PHA
    LDA.w $0E20, X : PHA
    LDA.w $0D10, X : PHA
    LDA.w $0D30, X : PHA
    LDA.w $0D00, X : PHA
    LDA.w $0D20, X : PHA
    LDA.w $0DC0, X : PHA
    LDA.w $0D90, X : PHA
    LDA.w $0EB0, X : PHA
    LDA.w $0F50, X : PHA
    LDA.w $0B89, X : PHA
    LDA.w $0DE0, X : PHA
    LDA.w $0E40, X : PHA
    LDA.w $0F20, X : PHA
    LDA.w $0D80, X : PHA
    LDA.w $0E60, X : PHA
    LDA.w $0DA0, X : PHA
    LDA.w $0DB0, X : PHA
    LDA.w $0E90, X : PHA
    LDA.w $0E80, X : PHA
    LDA.w $0F70, X : PHA
    LDA.w $0DF0, X : PHA
    
    LDA.l $7FF9C2, X : PHA
    
    LDA.w $0BA0, X : PHA
    
    ; Temporarily swap the cached sprite data in.
    LDA.w $1D00, X : STA.w $0DD0, X
    LDA.w $1D10, X : STA.w $0E20, X
    LDA.w $1D20, X : STA.w $0D10, X
    LDA.w $1D30, X : STA.w $0D30, X
    LDA.w $1D40, X : STA.w $0D00, X
    LDA.w $1D50, X : STA.w $0D20, X
    LDA.w $1D60, X : STA.w $0DC0, X
    LDA.w $1D70, X : STA.w $0D90, X
    LDA.w $1D80, X : STA.w $0EB0, X
    LDA.w $1D90, X : STA.w $0F50, X
    LDA.w $1DA0, X : STA.w $0B89, X
    LDA.w $1DB0, X : STA.w $0DE0, X
    LDA.w $1DC0, X : STA.w $0E40, X
    LDA.w $1DD0, X : STA.w $0F20, X
    LDA.w $1DE0, X : STA.w $0D80, X
    LDA.w $1DF0, X : STA.w $0E60, X
    
    LDA.l $7FFA5C, X : STA.w $0DA0, X
    LDA.l $7FFA6C, X : STA.w $0DB0, X
    LDA.l $7FFA7C, X : STA.w $0E90, X
    LDA.l $7FFA8C, X : STA.w $0E80, X
    LDA.l $7FFA9C, X : STA.w $0F70, X
    LDA.l $7FFAAC, X : STA.w $0DF0, X
    LDA.l $7FFACC, X : STA.l $7FF9C2, X
    LDA.l $7FFADC, X : STA.w $0BA0, X
    
    JSL Sprite_ExecuteSingleLong
    
    LDA.w $0F00, X : BEQ .active_sprite
        STZ.w $1D00, X
    
    .active_sprite
    
    ; Restore the data of the non-cached sprite from the stack.
    PLA : STA.w $0BA0, X
    
    PLA : STA.l $7FF9C2, X
    
    PLA : STA.w $0DF0, X
    PLA : STA.w $0F70, X
    PLA : STA.w $0E80, X
    PLA : STA.w $0E90, X
    PLA : STA.w $0DB0, X
    PLA : STA.w $0DA0, X
    PLA : STA.w $0E60, X
    PLA : STA.w $0D80, X
    PLA : STA.w $0F20, X
    PLA : STA.w $0E40, X
    PLA : STA.w $0DE0, X
    PLA : STA.w $0B89, X
    PLA : STA.w $0F50, X
    PLA : STA.w $0EB0, X
    PLA : STA.w $0D90, X
    PLA : STA.w $0DC0, X
    PLA : STA.w $0D20, X
    PLA : STA.w $0D00, X
    PLA : STA.w $0D30, X
    PLA : STA.w $0D10, X
    PLA : STA.w $0E20, X
    PLA : STA.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0EEB68-$0EEB83 DATA
Pool_Sprite_SimulateSoldier:
{
    ; $0EEB68
    .step
    db $0B, $04, $00, $07

    ; $0EEB6C
    .oam_a
    dw $0800, $0820, $0840, $0860, $0880, $08A0

    ; $0EEB78
    .oam_b
    dw $0A20, $0A28, $0A30, $0A38, $0A40, $0A48
}

; ==============================================================================

; $0EEB84-$0EEBEA LONG JUMP LOCATION
Sprite_SimulateSoldier:
{
    PHB : PHK : PLB
    
    LDA.b $00 : STA.w $0D10, X
    LDA.b $01 : STA.w $0D30, X
    
    LDA.b $02 : STA.w $0D00, X
    LDA.b $03 : STA.w $0D20, X
    
    STZ.w $0F70, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    LDA.b $04 : STA.w $0DE0, X : STA.w $0EB0, X : TAY
    
    LDA.w $EB68, Y : CLC : ADC.b $06 : STA.w $0DC0, X
    
    LDA.b #$10 : STA.w $0E60, X
    
    STZ.w $0B89, X
    
    LDA.b $05 : ORA.b #$30 : STA.w $0F50, X
    
    LDY.b #$41
    
    CMP.b #$39 : BEQ .normalSoldier
        ; Red spear soldier.
        LDY.b #$43
    
    .normalSoldier
    
    TYA : STA.w $0E20, X
    
    LDA.b #$07 : STA.w $0E40, X
    
    TXA : ASL A : TAY
    
    REP #$20
    
    LDA.w $EB6C, Y : STA.b $90
    LDA.w $EB78, Y : STA.b $92
    
    SEP #$20
    
    JSL Soldier_AnimateMarionetteTempLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EEBEB-$0EEDD5
incsrc "overlord_armos_coordinator.asm"

; $0EEDD6-$0EEF75
incsrc "sprite_helmasaur_fireball.asm"

; $0EEF76-$0EF062
incsrc "sprite_armos_crusher.asm"

; $0EF063-$0EF276
incsrc "sprite_evil_barrier.asm"

; ==============================================================================

; $0EF277-$0EF2A4 LONG JUMP LOCATION
Moldorm_Initialize:
{
    PHX
    
    TXY
    
    LDA.l $1DF7CF, X : TAX
    
    LDA.b #$1F : STA.b $00
    
    .next_subsprite
    
        LDA.w $0D10, Y : STA.l $7FFC00, X
        LDA.w $0D30, Y : STA.l $7FFC80, X
        
        LDA.w $0D00, Y : STA.l $7FFD00, X
        LDA.w $0D20, Y : STA.l $7FFD80, X
        
        INX
    DEC.b $00 : BPL .next_subsprite
    
    PLX
    
    RTL
}

; ==============================================================================

; $0EF2A5-$0EF394 DATA
Pool_Sprite_DrawFourAroundOne:
{
    ; $0EF2A5
    .oam_groups
    dw   4,   2 : db $E1, $02, $00, $00
    dw   4,  -3 : db $E3, $02, $00, $00
    dw  -1,   2 : db $E3, $02, $00, $00
    dw   9,   2 : db $E3, $02, $00, $00
    dw   4,   7 : db $E3, $02, $00, $00

    ; $0EF2CD
    dw   4,   2 : db $E1, $02, $00, $00
    dw   3,  -3 : db $E3, $02, $00, $00
    dw   9,   1 : db $E3, $02, $00, $00
    dw  -1,   3 : db $E3, $02, $00, $00
    dw   5,   7 : db $E3, $02, $00, $00

    ; $0EF2F5
    dw   4,   2 : db $E1, $02, $00, $00
    dw   1,  -3 : db $E3, $02, $00, $00
    dw   9,  -1 : db $E3, $02, $00, $00
    dw  -1,   5 : db $E3, $02, $00, $00
    dw   7,   7 : db $E3, $02, $00, $00

    ; $0EF31D
    dw   4,   2 : db $E1, $02, $00, $00
    dw   0,  -2 : db $E3, $02, $00, $00
    dw   8,  -2 : db $E3, $02, $00, $00
    dw   0,   6 : db $E3, $02, $00, $00
    dw   8,   6 : db $E3, $02, $00, $00

    ; $0EF345
    dw   4,   2 : db $E1, $02, $00, $00
    dw   7,  -3 : db $E3, $02, $00, $00
    dw  -1,  -1 : db $E3, $02, $00, $00
    dw   9,   5 : db $E3, $02, $00, $00
    dw   1,   7 : db $E3, $02, $00, $00

    ; $0EF36D
    dw   4,   2 : db $E1, $02, $00, $00
    dw   5,  -3 : db $E3, $02, $00, $00
    dw  -1,   1 : db $E3, $02, $00, $00
    dw   9,   3 : db $E3, $02, $00, $00
    dw   3,   7 : db $E3, $02, $00, $00
}

; ==============================================================================

; $0EF395-$0EF3D3 LONG JUMP LOCATION
Sprite_DrawFourAroundOne:
{
    PHB : PHK : PLB
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$01 : ORA.w $0011 : ORA.w $0FC1 : BNE .dont_reset
        INC.w $0DC0, X : LDA.w $0DC0, X : CMP.b #$06 : BNE .dont_reset
            STZ.w $0DC0, X
    
    .dont_reset
    
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00
    
    ASL #2 : ADC.b $00 : ADC.w #$F2A5 : STA.b $08
    
    SEP #$20
    
    LDA.b #$05 : JSR Sprite4_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF3D4-$0EF44C LONG JUMP LOCATION
Toppo_Flustered:
{
    PHB : PHK : PLB
    
    LDA.b #$82 : STA.w $0E40, X : STA.w $0BA0, X
    
    LDA.b #$49 : STA.w $0E60, X
    
    LDA.w $0E30, X : BNE .caught_by_player
        JSL Sprite_CheckDamageToPlayerLong : BCC .just_animate
            INC.w $0E30, X
            
            ; "All right! Take it Thief!"
            LDA.b #$74 : STA.w $1CF0
            LDA.b #$01 : STA.w $1CF1
            
            JSL Sprite_ShowMessageMinimal
            
            BRA .just_animate
    
    .caught_by_player
    
    CMP.b #$10 : BCC .prize_delay
        BNE .just_animate
            STZ.w $0BE0, X
            
            LDA.b #$06 : STA.w $0DD0, X
            
            LDA.b #$0F : STA.w $0DF0, X
            
            LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
            
            LDA.b #$15 : JSL Sound_SetSfx2PanLong
            
            LDA.b #$4D : JSL Sprite_SpawnDynamically : BMI .prize_delay
                JSL Sprite_SetSpawnedCoords
                
                PHX : TYX : LDY.b #$06
                
                ; Transmute this thing to a prize?
                JSL.l $06FA54 ; $37A54 IN ROM
                
                PLX
    
    .prize_delay
    
    INC.w $0E30, X
    
    .just_animate
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$04 : LSR #2 : ADC.b #$03 : STA.w $0DC0, X
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF44D-$0EF588 DATA
Pool_Goriya_Draw:
{
    ; $0EF44D
    .oam_groups
    .group00
    dw  -4,  -8 : db $44, $00, $00, $02
    dw  12,  -8 : db $44, $40, $00, $00
    dw  -4,   8 : db $64, $00, $00, $00
    dw   4,   0 : db $54, $40, $00, $02

    ; $0EF46D
    .group01
    dw  -4,  -8 : db $44, $00, $00, $02
    dw  12,  -8 : db $44, $40, $00, $00
    dw  -4,   8 : db $74, $40, $00, $00
    dw   4,   0 : db $62, $40, $00, $02

    ; $0EF48D
    .group02
    dw  -4,  -8 : db $44, $00, $00, $00
    dw   4,  -8 : db $44, $40, $00, $02
    dw  -4,   0 : db $62, $00, $00, $02
    dw  12,   8 : db $64, $40, $00, $00

    ; $0EF4AD
    .group03
    dw  -4,  -8 : db $46, $00, $00, $02
    dw  12,  -8 : db $46, $40, $00, $00
    dw  -4,   8 : db $66, $00, $00, $00
    dw   4,   0 : db $56, $40, $00, $02

    ; $0EF4CD
    .group04
    dw  -4,  -8 : db $46, $00, $00, $02
    dw  12,  -8 : db $46, $40, $00, $00
    dw  -4,   8 : db $75, $40, $00, $00
    dw   4,   0 : db $6A, $40, $00, $02

    ; $0EF4ED
    .group05
    dw  -4,  -8 : db $46, $00, $00, $00
    dw   4,  -8 : db $46, $40, $00, $02
    dw  -4,   0 : db $6A, $00, $00, $02
    dw  12,   8 : db $75, $00, $00, $00

    ; $0EF50D
    .group06
    dw  -2,  -8 : db $4E, $00, $00, $02
    dw   0,   0 : db $6C, $00, $00, $02

    ; $0EF51D
    .group07
    dw  -2,  -7 : db $4E, $00, $00, $02
    dw   0,   0 : db $6E, $00, $00, $02

    ; $0EF52D
    .group08
    dw   2,  -8 : db $4E, $40, $00, $02
    dw   0,   0 : db $6C, $40, $00, $02

    ; $0EF53D
    .group09
    dw   2,  -7 : db $4E, $40, $00, $02
    dw   0,   0 : db $6E, $40, $00, $02


    ; $0EF5$D
    .mouthgroup00
    dw  10,   4 : db $77, $40, $00, $00

    ; $0EF555
    .mouthgroup01
    dw  -2,   4 : db $77, $00, $00, $00

    ; $0EF55D
    .mouthgroup02
    dw   4,   4 : db $76, $00, $00, $00


    ; $0EF565
    .mouth_group_pointer
    dw .mouthgroup00
    dw .mouthgroup01
    dw .mouthgroup02


    ; $0EF56B
    .group_pointer
    dw .group00
    dw .group01
    dw .group02
    dw .group03
    dw .group04
    dw .group05
    dw .group06
    dw .group07
    dw .group08
    dw .group09


    ; $0EF57F
    .group_size
    db $04 ; group00
    db $04 ; group01
    db $04 ; group02
    db $04 ; group03
    db $04 ; group04
    db $04 ; group05
    db $02 ; group06
    db $02 ; group07
    db $02 ; group08
    db $02 ; group09
}

; $0EF589-$0EF5D3 LONG JUMP LOCATION
Goriya_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0E00, X : BEQ .not_firing_fire_pleghm
        LDA.w $0DE0, X : CMP.b #$03 : BEQ .facing_right
            ASL A : TAY
            
            REP #$20
            
            LDA.w $F565, Y : STA.b $08
            
            SEP #$20
            
            LDA.b #$01 : JSR Sprite4_DrawMultiple
        
        .facing_right
    .not_firing_fire_pleghm
    
    LDA.w $0DC0, X : PHA : ASL A : TAY
    
    REP #$20
    
    LDA.w $F56B, Y : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    PLY
    
    LDA.w $F57F, Y : JSR Sprite4_DrawMultiple
    
    DEC.w $0E40, X
    
    JSL Sprite_DrawShadowLong
    
    INC.w $0E40, X
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF5D4-$0EF613 DATA
Pool_Sprite_ConvertVelocityToAngle:
{
    .x_angles
    db  0,  0,  1,  1,  1,  2,  2,  2
    db  0,  0, 15, 15, 15, 14, 14, 14
    db  8,  8,  7,  7,  7,  6,  6,  6
    db  8,  8,  9,  9,  9, 10, 10, 10
    
    .y_angles
    db  4,  4,  3,  3,  3,  2,  2,  2
    db 12, 12, 13, 13, 13, 14, 14, 14
    db  4,  4,  5,  5,  5,  6,  6,  6
    db 12, 12, 11, 11, 11, 10, 10, 10
}

; ==============================================================================

; $0EF614-$0EF65C LONG JUMP LOCATION
Sprite_ConvertVelocityToAngle:
{
    !x_magnitude = $08
    !y_magnitude = $09
    !sign_bits   = $0A
    
    ; ------------------------------
    
    ; This routine's purpose is unknown, but its clients are generally
    ; "segmented" enemies and bosses like the Giant Moldorm and Trinexx.
    
    PHB : PHK : PLB
    
    ; Take Y speed and extract its sign to $08.
    LDA.b $00 : ASL A : ROL A : STA.b $08
    
    ; Extract the X speed's sign bit too, shift it left once, OR in the
    ; Y speed's sign bit and then isolate them to $0A. So $0A looks like
    ; 000st000, where s and y indicate the respective sign bits of x and y.
    LDA.b $01 : ASL A : ROL A : ASL A : ORA.b $08
    AND.b #$03 : ASL #3 : STA !sign_bits
    
    LDA.b $01 : BPL .positive_x_speed
        EOR.b #$FF : INC A
    
    .positive_x_speed
    
    STA !x_magnitude
    
    LDA.b $00 : BPL .positive_y_speed
        EOR.b #$FF : INC A
    
    .positive_y_speed
    
    STA !y_magnitude
    
    LDA !x_magnitude : CMP !y_magnitude : BCC .y_speed_magnitude_larger
    
    LDA !y_magnitude : LSR #2 : CLC : ADC !sign_bits : TAY
        ; I don't think these tables are large enough (do we have a verified
        ; \bug on our hands?) for all possible combinations of velocities.
        LDA .x_angles, Y
        
        BRA .return
    
    .y_speed_magnitude_larger
    
    LDA !x_magnitude : LSR #2 : CLC : ADC !sign_bits : TAY
    
    LDA .y_angles, Y
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF65D-$0EF6CE LONG JUMP LOCATION
Sprite_SpawnDynamically:
{
    LDY.b #$0F
    
    ; $0EF65F ALTERNATE ENTRY POINT
    .arbitrary
    
    PHA
    
    .next_sprite_slot
    
        LDA.w $0DD0, Y : BEQ .empty_slot
    DEY : BPL .next_sprite_slot
    
    PLA : TYA
    
    RTL
    
    .empty_slot
    
    ; Change to the designated sprite type (set in the calling function.)
    PLA : STA.w $0E20, Y
    
    ; Bring the sprite to life.
    LDA.b #$09 : STA.w $0DD0, Y
    
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    LDA.w $0F70, X : STA.b $04
    
    LDA.w $0B08, X : STA.b $05
    LDA.w $0B10, X : STA.b $06
    LDA.w $0B18, X : STA.b $07
    LDA.w $0B20, X : STA.b $08
    
    ; Save our sprite's index, for now.
    PHX
    
    ; Refresh the sprite index using Y -> X.
    TYX
    
    JSL Sprite_LoadProperties
    
    LDA.b $1B : BNE .indoors
        TXA : ASL A : TAX
        
        LDA.b #$FF : STA.w $0BC1, X
    
    .indoors
    
    LDA.b #$FF : STA.w $0BC0, X
    
    PLX
    
    LDA.w $0F20, X : STA.w $0F20, Y
    LDA.w $0DE0, X : STA.w $0DE0, Y
    
    LDA.b #$00 : STA.w $0CBA, Y : STA.w $0E30, Y
    
    TYA
    
    RTL
}

; ==============================================================================

; $0EF6CF-$0EF7CE DATA
GeneralizedSpriteTileInteraction:
{
    ; Used from bank 0x06. Though, it seems that the values here aren't really
    ; checked for anything other than being zero.
    db $00 ; 0x00
    db $01 ; 0x01
    db $02 ; 0x02
    db $03 ; 0x03
    db $02 ; 0x04
    db $00 ; 0x05
    db $00 ; 0x06
    db $00 ; 0x07
    db $00 ; 0x08
    db $01 ; 0x09
    db $00 ; 0x0A
    db $01 ; 0x0B
    db $00 ; 0x0C
    db $00 ; 0x0D
    db $00 ; 0x0E
    db $00 ; 0x0F
    db $01 ; 0x10
    db $01 ; 0x11
    db $01 ; 0x12
    db $01 ; 0x13
    db $01 ; 0x14
    db $01 ; 0x15
    db $01 ; 0x16
    db $01 ; 0x17
    db $01 ; 0x18
    db $01 ; 0x19
    db $01 ; 0x1A
    db $01 ; 0x1B
    db $00 ; 0x1C
    db $01 ; 0x1D
    db $01 ; 0x1E
    db $01 ; 0x1F
    db $01 ; 0x20
    db $01 ; 0x21
    db $01 ; 0x22
    db $00 ; 0x23
    db $00 ; 0x24
    db $00 ; 0x25
    db $01 ; 0x26
    db $02 ; 0x27
    db $FF ; 0x28
    db $FF ; 0x29
    db $FF ; 0x2A
    db $FF ; 0x2B
    db $FF ; 0x2C
    db $FF ; 0x2D
    db $FF ; 0x2E
    db $FF ; 0x2F
    db $01 ; 0x30
    db $01 ; 0x31
    db $01 ; 0x32
    db $01 ; 0x33
    db $01 ; 0x34
    db $01 ; 0x35
    db $01 ; 0x36
    db $01 ; 0x37
    db $01 ; 0x38
    db $01 ; 0x39
    db $00 ; 0x3A
    db $00 ; 0x3B
    db $01 ; 0x3C
    db $01 ; 0x3D
    db $01 ; 0x3E
    db $01 ; 0x3F
    db $00 ; 0x40
    db $01 ; 0x41
    db $01 ; 0x42
    db $01 ; 0x43
    db $01 ; 0x44
    db $01 ; 0x45
    db $00 ; 0x46
    db $01 ; 0x47
    db $00 ; 0x48
    db $01 ; 0x49
    db $00 ; 0x4A
    db $00 ; 0x4B
    db $FF ; 0x4C
    db $FF ; 0x4D
    db $FF ; 0x4E
    db $FF ; 0x4F
    db $01 ; 0x50
    db $01 ; 0x51
    db $01 ; 0x52
    db $01 ; 0x53
    db $01 ; 0x54
    db $01 ; 0x55
    db $01 ; 0x56
    db $01 ; 0x57
    db $01 ; 0x58
    db $01 ; 0x59
    db $01 ; 0x5A
    db $01 ; 0x5B
    db $01 ; 0x5C
    db $01 ; 0x5D
    db $01 ; 0x5E
    db $01 ; 0x5F
    db $00 ; 0x60
    db $00 ; 0x61
    db $00 ; 0x62
    db $00 ; 0x63
    db $00 ; 0x64
    db $01 ; 0x65
    db $00 ; 0x66
    db $02 ; 0x67
    db $00 ; 0x68
    db $00 ; 0x69
    db $00 ; 0x6A
    db $00 ; 0x6B
    db $01 ; 0x6C
    db $01 ; 0x6D
    db $01 ; 0x6E
    db $01 ; 0x6F
    db $01 ; 0x70
    db $01 ; 0x71
    db $01 ; 0x72
    db $01 ; 0x73
    db $01 ; 0x74
    db $01 ; 0x75
    db $01 ; 0x76
    db $01 ; 0x77
    db $01 ; 0x78
    db $01 ; 0x79
    db $01 ; 0x7A
    db $01 ; 0x7B
    db $01 ; 0x7C
    db $01 ; 0x7D
    db $01 ; 0x7E
    db $01 ; 0x7F
    db $01 ; 0x80
    db $01 ; 0x81
    db $01 ; 0x82
    db $01 ; 0x83
    db $01 ; 0x84
    db $01 ; 0x85
    db $01 ; 0x86
    db $01 ; 0x87
    db $01 ; 0x88
    db $01 ; 0x89
    db $01 ; 0x8A
    db $01 ; 0x8B
    db $01 ; 0x8C
    db $01 ; 0x8D
    db $01 ; 0x8E
    db $01 ; 0x8F
    db $01 ; 0x90
    db $01 ; 0x91
    db $01 ; 0x92
    db $01 ; 0x93
    db $01 ; 0x94
    db $01 ; 0x95
    db $01 ; 0x96
    db $01 ; 0x97
    db $01 ; 0x98
    db $01 ; 0x99
    db $01 ; 0x9A
    db $01 ; 0x9B
    db $01 ; 0x9C
    db $01 ; 0x9D
    db $01 ; 0x9E
    db $01 ; 0x9F
    db $01 ; 0xA0
    db $01 ; 0xA1
    db $01 ; 0xA2
    db $01 ; 0xA3
    db $01 ; 0xA4
    db $01 ; 0xA5
    db $01 ; 0xA6
    db $01 ; 0xA7
    db $01 ; 0xA8
    db $01 ; 0xA9
    db $01 ; 0xAA
    db $01 ; 0xAB
    db $01 ; 0xAC
    db $01 ; 0xAD
    db $01 ; 0xAE
    db $01 ; 0xAF
    db $01 ; 0xB0
    db $01 ; 0xB1
    db $01 ; 0xB2
    db $01 ; 0xB3
    db $01 ; 0xB4
    db $01 ; 0xB5
    db $01 ; 0xB6
    db $01 ; 0xB7
    db $01 ; 0xB8
    db $01 ; 0xB9
    db $01 ; 0xBA
    db $01 ; 0xBB
    db $01 ; 0xBC
    db $01 ; 0xBD
    db $01 ; 0xBE
    db $01 ; 0xBF
    db $01 ; 0xC0
    db $01 ; 0xC1
    db $01 ; 0xC2
    db $01 ; 0xC3
    db $01 ; 0xC4
    db $01 ; 0xC5
    db $01 ; 0xC6
    db $01 ; 0xC7
    db $01 ; 0xC8
    db $01 ; 0xC9
    db $01 ; 0xCA
    db $01 ; 0xCB
    db $01 ; 0xCC
    db $01 ; 0xCD
    db $01 ; 0xCE
    db $01 ; 0xCF
    db $01 ; 0xD0
    db $01 ; 0xD1
    db $01 ; 0xD2
    db $01 ; 0xD3
    db $01 ; 0xD4
    db $01 ; 0xD5
    db $01 ; 0xD6
    db $01 ; 0xD7
    db $01 ; 0xD8
    db $01 ; 0xD9
    db $01 ; 0xDA
    db $01 ; 0xDB
    db $01 ; 0xDC
    db $01 ; 0xDD
    db $01 ; 0xDE
    db $01 ; 0xDF
    db $01 ; 0xE0
    db $01 ; 0xE1
    db $01 ; 0xE2
    db $01 ; 0xE3
    db $01 ; 0xE4
    db $01 ; 0xE5
    db $01 ; 0xE6
    db $01 ; 0xE7
    db $01 ; 0xE8
    db $01 ; 0xE9
    db $01 ; 0xEA
    db $01 ; 0xEB
    db $01 ; 0xEC
    db $01 ; 0xED
    db $01 ; 0xEE
    db $01 ; 0xEF
    db $01 ; 0xF0
    db $01 ; 0xF1
    db $01 ; 0xF2
    db $01 ; 0xF3
    db $01 ; 0xF4
    db $01 ; 0xF5
    db $01 ; 0xF6
    db $01 ; 0xF7
    db $01 ; 0xF8
    db $01 ; 0xF9
    db $01 ; 0xFA
    db $01 ; 0xFB
    db $01 ; 0xFC
    db $01 ; 0xFD
    db $01 ; 0xFE
    db $01 ; 0xFF
}

; ==============================================================================

; $0EF7CF-$0EF7D2 DATA
SpriteSlotToSegmentOffset:
{
    db $00, $20, $40, $60
}

; ==============================================================================
    
; $0EF7D3-$0EF821 DATA
Pool_Moldorm_Draw
{
    ; $0EF7D3
    .char
    db $5D, $62, $60
    
    ; $0EF7D6
    .offset_segment
    db $04, $00, $00, $00, $00, $00
    
    ; $0EF7DC
    .prop
    db $00, $02, $02
    
    ; $0EF7DF
    .segment_index
    db $15, $1A, $00
    
    
    ; $0EF7E2
    .offset_main_x
    db 11,  0, 10,  0,  9,  0,  6,  0
    db  3,  0,  0,  0, -2, -1, -3, -1
    db -4, -1, -3, -1, -2, -1,  1,  0
    db  4,  0,  7,  0,  9,  0, 10,  0
    
    ; $0EF802
    .offset_main_y
    db  4,  0,  6,  0,  9,  0, 10,  0
    db 11,  0, 10,  0,  9,  0,  6,  0
    db  3,  0,  0,  0, -2, -1, -3, -1
    db -4, -1, -3, -1, -2, -1,  1,  0
}

; $0EF822-$0EF942 LONG JUMP LOCATION
Moldorm_Draw:
{
    JSL Sprite_PrepOamCoordLong : BCC .can_draw
        RTL
    
    .can_draw
    
    PHB : PHK : PLB
    
    LDA.w $0DE0, X : CLC : ADC.b #$FF : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_oam_entry
    
        LDA.b $06 : AND.b #$0F : ASL A
        
        PHX
        
        TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w $F7E2, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC.w $F802, X : INY : STA ($90), Y
        
        ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        LDA.b #$4D : INY : STA ($90), Y
        LDA.b $05  : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        LDA.b $06 : CLC : ADC.b #$02 : STA.b $06
        
        PLY : INY
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    TXY
    
    LDA.w $0E80, X : AND.b #$1F : CLC : ADC.w $F7CF, X : TAX
    
    LDA.w $0D10, Y : STA.l $7FFC00, X
    LDA.w $0D30, Y : STA.l $7FFC80, X
    
    LDA.w $0D00, Y : STA.l $7FFD00, X
    LDA.w $0D20, Y : STA.l $7FFD80, X
    
    LDA.b #$02 : STA.b $06
    
    LDY.b #$00
    
    .next_oam_entry_2
    
        PHY
        
        LDY.b $06
        
        LDX.w $0FA0
        
        LDA.w $0E80, X : CLC : ADC.w $F7DF, Y : AND.b #$1F : CLC : ADC.w $F7CF, X : TAX
        
        LDA.l $7FFC00, X : STA.b $00
        LDA.l $7FFC80, X : STA.b $01
        
        LDA.l $7FFD00, X : STA.b $02
        LDA.l $7FFD80, X : STA.b $03
        
        TYA
        
        PLY
        
        PHA
        
        ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : SEC : SBC.b $E2 : CLC : ADC.w $F7D6, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : SEC : SBC.b $E8 : CLC : ADC.w $F7D6, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y_2
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y_2
        
        PLX
        
        LDA.w $F7D3, X : INY : STA ($90), Y
        LDA.b $05      : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.w $F7DC, X : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    DEC.b $06 : BPL .next_oam_entry_2
    
    LDX.w $0FA0
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF943-$0EFBCB
incsrc "sprite_talking_tree.asm"

; ==============================================================================

; $0EFBCC-$0EFBD6 DATA
Pool_PullForRupees_SpawnRupees:
{
    .x_speeds
    db -18, -12,  12,  18
    
    .y_speeds
    db  16,  24,  24,  16
    
    .rupee_types
    db $D9, $DA, $DB
}

; ==============================================================================

; $0EFBD7-$0EFC37 LONG JUMP LOCATION
PullForRupees_SpawnRupees:
{
    PHB : PHK : PLB
    
    ; Number of kills.
    LDA.w $0CFB : BEQ .no_kills
        LDY.b #$00
        
        CMP.b #$04 : BCC .less_than_four_kills
            INY
            
            ; Number of times you've taken damage (even if you're at full health
            ; right now).
            LDA.w $0CFC : BNE .players_hit_counter_nonzero
                INY
            
            .players_hit_counter_nonzero
        .less_than_four_kills
        
        LDA.b #$03 : STA.w $0FB5
        
        STY.w $0FB6
        
        .rupee_spawn_loop
        
            LDY.w $0FB6
            
            ; Select which kind of rupee to use with the "pull for rupees"
            ; thing.
            LDA .rupee_types, Y
            
            JSL Sprite_SpawnDynamically : BMI .spawn_failed
                LDA.b #$30 : JSL Sound_SetSfx3PanLong
                
                JSL Sprite_SetSpawnedCoords
                
                PHX
                
                LDX.w $0FB5
                
                LDA .x_speeds, X : STA.w $0D50, Y
                
                LDA .y_speeds, X : STA.w $0D40, Y
                
                PLX
                
                LDA.b #$FF : STA.w $0B58, Y
                
                LDA.b #$20 : STA.w $0F10, Y : STA.w $0EE0, Y : STA.w $0F80, Y
        DEC.w $0FB5 : BPL .rupee_spawn_loop
        
        .spawn_failed
    .no_kills
    
    ; Reset hit and kill counts.
    STZ.w $0CFB
    STZ.w $0CFC
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EFC38-$0EFE6D
incsrc "sprite_digging_game_guy.asm"

; ==============================================================================

; $0EFE6E-$0EFF0D DATA
Pool_OldMountainMan_Draw:
{
    .static_pose
    dw  0, 0 : db $AC, $00, $00, $02
    dw  0, 8 : db $AE, $00, $00, $02
    
    .dynamic_poses
    dw  0, 0 : db $20, $01, $00, $02
    dw  0, 8 : db $22, $01, $00, $02
    
    dw  0, 1 : db $20, $01, $00, $02
    dw  0, 9 : db $22, $41, $00, $02
    
    dw  0, 0 : db $20, $01, $00, $02
    dw  0, 8 : db $22, $01, $00, $02
    
    dw  0, 1 : db $20, $01, $00, $02
    dw  0, 9 : db $22, $41, $00, $02
    
    dw -2, 0 : db $20, $01, $00, $02
    dw  0, 8 : db $22, $01, $00, $02
    
    dw -2, 1 : db $20, $01, $00, $02
    dw  0, 9 : db $22, $01, $00, $02
    
    dw  2, 0 : db $20, $41, $00, $02
    dw  0, 8 : db $22, $41, $00, $02
    
    dw  2, 1 : db $20, $41, $00, $02
    dw  0, 9 : db $22, $41, $00, $02        
    
    .dma_config
    dw $20, $C0, $20, $C0, $00, $A0, $00, $A0
    db $40, $80, $40, $60, $40, $80, $40, $60

}

; ==============================================================================

; $0EFF0E-$0EFF5A LONG JUMP LOCATION
OldMountainMan_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0E80, X : CMP.b #$02 : BEQ .unchanging_pose
        LDA.b #$02 : STA.b $06
                    STZ.b $07
        
        LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL A : TAY
        
        ; Wait... so the Old Man's graphics are updated dynamically? Why?
        LDA .dma_config, Y     : STA.w $0AE8
        
        LDA .dma_config + 1, Y : STA.w $0AEA
        
        TYA : ASL #3
        
        ADC.b #(.dynamic_poses >> 0)              : STA.b $08
        LDA.b #(.dynamic_poses >> 8) : ADC.b #$00 : STA.b $09
        
        JSL Sprite_DrawMultiple.player_deferred
        
        PLB
        
        RTL
    
    .unchanging_pose
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.static_pose >> 0) : STA.b $08
    LDA.b #(.static_pose >> 8) : STA.b $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    PLB
    
    RTL
}

; $0EFF5B-$0EFFBC LONG JUMP LOCATION
SpriteBurn_Execute:
{
    PHB : PHK : PLB
    
    STZ.w $0EF0, X
    
    LDA.w $0DF0, X : DEC A : BNE .delay
        ; Do this when the timer is at 0x01.
        JSL.l $06F917 ; $037917 IN ROM
        
        PLB
        
        RTL
    
    .delay
    
    LDY.w $0DC0, X : PHY
    
    LSR #3
    
    PHX : TAX
    
    LDA.l $1EC2B4, X : PLX : STA.w $0DC0, X
    
    LDA.w $0F50, X : PHA
    
    LDA.b #$03 : STA.w $0F50, X
    
    JSL Flame_Draw
    
    PLA : STA.w $0F50, X
    PLA : STA.w $0DC0, X
    
    REP #$20
    
    ; Flame sprite took up 2 oam entries.
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    ; Once the sprite has been burning long enough, stop animating it,
    ; drawing it, letting it do any particular logic, etc.
    LDA.w $0DF0, X : CMP.b #$10 : BCC .normal_handling_inhibited
        LDA.w $0E40, X : PHA
        
        DEC #2 : STA.w $0E40, X
        
        JSL SpriteActive_MainLong
        
        PLA : STA.w $0E40, X
    
    .normal_handling_inhibited
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EFFBD-$0EFFC4 DATA
Pool_SpriteFall_Draw:
{
    .chr
    db $83, $83, $83, $80, $80, $80, $B7, $B7
}

; ==============================================================================

; $0EFFC5-$0EFFF7 LONG JUMP LOCATION
SpriteFall_Draw:
{
    PHB : PHK : PLB
    
    LDA.b $00 : CLC : ADC.b #$04       : STA ($90), Y
    LDA.b $02 : CLC : ADC.b #$04 : INY : STA ($90), Y
    
    LDA.w $0DF0, X : LSR #2
    
    PHX
    
    TAX
    
    LDA .chr, X                         : INY : STA ($90), Y
    LDA.b $05 : AND.b #$30 : ORA.b #$04 : INY : STA ($90), Y
    
    PLX
    
    LDY.b #$00
    LDA.b #$00
    
    JSL Sprite_CorrectOamEntriesLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EFFF8-$0EFFFF NULL
NULL_1DFFF8:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $1E8000
