; ==============================================================================

; Bank 1E
; $0F0000-$0F7FFF
org $1E8000

; Misc sprite code

; ==============================================================================

; $0F0000-$0F0A84
incsrc "sprite_helmasaur_king.asm"
    
; ==============================================================================

; OPTIMIZE: I think this is actual overkill. Probably only need NOP #4 or NOP #3
; really.
; Used for division or multiplication delay with helmasaur king.
; $0F0A85-$0F0A8D
Sprite3_DivisionDelay:
{
    NOP #8
    
    RTS
}

; ==============================================================================

; $0F0A8E-$0F0B10
incsrc "sprite_mad_batter_bolt.asm"

; ==============================================================================

; $0F0B11-$0F0B18 LONG JUMP LOCATION
SpriteActive3_MainLong:
{
    PHB : PHK : PLB
    
    JSR.w SpriteActive3_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F0B19-$0F0B2D LOCAL JUMP LOCATION
SpriteActive3_Main:
{
    LDA.w $0E20, X : SEC : SBC.b #$79 : REP #$30 : AND.w #$00FF : ASL : TAY
    
    ; Sets up a clever little jump table
    LDA SpriteActive3_Table, Y : DEC : PHA
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0F0B2E-$0F0B32 LOCAL JUMP LOCATION
Sprite3_CheckTileCollision:
{
    JSL.l Sprite_CheckTileCollisionLong
    
    RTS
}

; ==============================================================================

; SPRITE ROUTINES 3
; $0F0B33-$0F0BBA Jump Table
SpriteActive3_Table:
{
    ; Note that the indices in the margin are the sprite indices, not the
    ; indices into the table.
    
    dw Sprite_DashBeeHive      ; 0x79 - $DC5B Good bee / Normal bee
    dw Sprite_Agahnim          ; 0x7A - $D330 Agahnim.
    dw Sprite_EnergyBall       ; 0x7B - $DA42 Agahnim energy blasts
    dw Sprite_GreenStalfos     ; 0x7C - $D299 Green Stalfos
    dw Sprite_SpikeTrap        ; 0x7D - $D01A Spike Traps
    dw Sprite_GuruguruBar      ; 0x7E - $CF47 Swinging Fireball Chains
    dw Sprite_GuruguruBar      ; 0x7F - $D01A Swinging Fireball Chains
    dw Sprite_Winder           ; 0x80 - $D1D1 Winder (wandering fireball chain0
    dw Sprite_Hover            ; 0x81 - $CC02 Hover
    dw Sprite_BubbleGroup      ; 0x82 - $CB97 Swirling Fire Fairys
    dw Sprite_Eyegore          ; 0x83 - $C79B Green Eyegore
    dw Sprite_Eyegore          ; 0x84 - $C79B Red Eyegore
    dw Sprite_YellowStalfos    ; 0x85 - $C37F Yellow Stalfos
    dw Sprite_Kodondo          ; 0x86 - $C103 Kodondo
    dw Sprite_Flame            ; 0x87 - $C274 Flame (from Kodondo and Fire Rod)
    dw Sprite_Mothula          ; 0x88 - $42BE Mothula
    dw Sprite_MothulaBeam      ; 0x89 - $BB42 Mothula beam
    dw Sprite_SpikeBlock       ; 0x8A - $BCE8 Moving spike blocks
    dw Sprite_Gibdo            ; 0x8B - $A9B9 Gibdo
    dw Sprite_Arrghus          ; 0x8C - $B433 Arrghus
    dw Sprite_Arrghi           ; 0x8D - $B8C4 Arrgi
    dw Sprite_Terrorpin        ; 0x8E - $B26F Chair Turtles
    dw Sprite_Zol              ; 0x8F - $B002 Zol / Blobs
    dw Sprite_WallMaster       ; 0x90 - $AEA4 Wall Masters
    dw Sprite_StalfosKnight    ; 0x91 - $AAA7 Stalfos Knight
    dw Sprite_HelmasaurKing    ; 0x92 - $8039 Helmasaur King
    dw Sprite_Bumper           ; 0x93 - $A982 Bumper
    dw Sprite_Pirogusu         ; 0x94 - $A742 Pirogusu
    dw Sprite_LaserEye         ; 0x95 - $A541 Laser Eye
    dw Sprite_LaserEye         ; 0x96 - $A541 Laser Eye
    dw Sprite_LaserEye         ; 0x97 - $A541 Laser Eye
    dw Sprite_LaserEye         ; 0x98 - $A541 Laser Eye
    dw Sprite_Pengator         ; 0x99 - $A196 Pengator
    dw Sprite_Kyameron         ; 0x9A - $9E7B Kyameron
    dw Sprite_WizzrobeAndBeam  ; 0x9B - $9D1B Wizzrobe
    dw Sprite_Zoro             ; 0x9C - $9BC8 Zoro
    dw Sprite_Babusu           ; 0x9D - $9BC8 Babusu
    dw Sprite_FluteBoyOstrich  ; 0x9E - $995B Ostrich seen with Flute Boy
    dw Sprite_FluteBoyRabbit   ; 0x9F - $9A6D Flute
    dw Sprite_FluteBoyBird     ; 0xA0 - $9AEC Birds with flute boy?
    dw Sprite_Freezor          ; 0xA1 - $981D Freezor
    dw Sprite_Kholdstare       ; 0xA2 - $9518 Kholdstare
    dw Sprite_KholdstareShell  ; 0xA3 - $9460 Kholdstare Shell
    dw Sprite_IceBallGenerator ; 0xA4 - $9710 Ice Balls From Above
    dw Sprite_Zazak            ; 0xA5 - $919F Blue Zazak
    dw Sprite_Zazak            ; 0xA6 - $919F Red Zazak
    dw Sprite_Stalfos          ; 0xA7 - $906C Red Stalfos
    dw Sprite_Bomber           ; 0xA8 - $8DD2 Green Bomber (Zirro?)
    dw Sprite_Bomber           ; 0xA9 - $8DD2 Blue Bomber (Zirro?)
    dw Sprite_Pikit            ; 0xAA - $8BBF Pikit
    dw Sprite_CrystalMaiden    ; 0xAB - $CE03 Crystal maiden
    dw Sprite_DashApple        ; 0xAC - $F515 Apple
    dw Sprite_OldMountainMan   ; 0xAD - $E992 Old Man on the Mountain
    dw Sprite_Pipe             ; 0xAE - $E992 Pipe sprite (down)
    dw Sprite_Pipe             ; 0xAF - $FB7E Pipe sprite (up)
    dw Sprite_Pipe             ; 0xB0 - $FB7E Pipe sprite (right)
    dw Sprite_Pipe             ; 0xB1 - $FB7E Pipe sprite (left)
    dw Sprite_GoodBee          ; 0xB2 - $DE63 Good bee again?
    dw Sprite_HylianPlaque     ; 0xB3 - $E044 Hylian Plaque
    dw Sprite_ThiefChest       ; 0xB4 - $E0DD Thief's chest
    dw Sprite_BombShopEntity   ; 0xB5 - $E111 Bomb Salesman / others maybe?
    dw Sprite_Kiki             ; 0xB6 - $E2EF Kiki the monkey
    dw Sprite_BlindMaiden      ; 0xB7 - $E8B6 Maiden following you in Gargoyle's Domain
    dw Sprite_DialogueTester   ; 0xB8 - $E7EA debug artifact, dialogue tester
    dw Sprite_BullyAndBallGuy  ; 0xB9 - $EB33 Feuding friends on DW Death Mountain
    dw Sprite_Whirlpool        ; 0xBA - $EE5A Whirlpool
    dw Sprite_ShopKeeper       ; 0xBB - $EEEF Shopkeeper / Chest game guy
    dw Sprite_DrinkingGuy      ; 0xBC - $F603 Drunk in the Inn
}

; ==============================================================================

; $0F0BBB-$0F0BBE DATA
Pool_Unused:
{
    db $00, $00, $00, $00
}

; ==============================================================================

; $0F0BBF-$0F0DD1
incsrc "sprite_pikit.asm"
    
; $0F0DD2-$0F0FDE
incsrc "sprite_bomber.asm"

; $0F0FDF-$0F145F
incsrc "sprite_stalfos_and_zazak.asm"

; $0F1460-$0F181C
incsrc "sprite_kholdstare.asm"

; $0F181D-$0F195A
incsrc "sprite_freezor.asm"

; $0F195B-$0F1A6A
incsrc "sprite_flute_boy_ostrich.asm"

; $0F1A6B-$0F1AEB
incsrc "sprite_flute_boy_rabbit.asm"

; $0F1AEC-$0F1BC7
incsrc "sprite_flute_boy_bird.asm"

; $0F1BC8-$0F1D16
incsrc "sprite_zoro_and_babusu.asm"

; $0F1D17-$0F1E7A
incsrc "sprite_wizzrobe.asm"

; $0F1E7B-$0F2191
incsrc "sprite_kyameron.asm"

; $0F2192-$0F2461
incsrc "sprite_pengator.asm"

; $0F2462-$0F273E
incsrc "sprite_laser_eye.asm"

; $0F273F-$0F297E
incsrc "sprite_pirogusu.asm"

; $0F297F-$0F2AA6
incsrc "sprite_bumper.asm"

; $0F2AA7-$0F2EA3
incsrc "sprite_stalfos_knight.asm"

; $0F2EA4-$0F3001
incsrc "sprite_wall_master.asm"

; $0F3002-$0F326E
incsrc "sprite_zol.asm"

; $0F326F-$0F3429
incsrc "sprite_terrorpin.asm"

; $0F38B4-$0F39A8
incsrc "sprite_arrgi.asm"

; $0F39A9-$0F3B41
incsrc "sprite_gibdo.asm"

; $0F3B42-$0F3BB8
incsrc "sprite_mothula_beam.asm"

; $0F3BB9-$0F3CE7
incsrc "sprite_flying_tile.asm"

; $0F3CE8-$0F3E7D
incsrc "sprite_spike_block.asm"

; $0F3E7E-$0F4102
incsrc "sprite_mothula.asm"

; $0F4103-$0F4266
incsrc "sprite_kodondo.asm"

; ==============================================================================

; $0F4267-$0F426A LOCAL JUMP LOCATION
Sprite3_CheckDamage:
{
    JSL.l Sprite_CheckDamageFromPlayerLong

    ; Bleeds into the next function.
}
    
; $0F426B-$0F426F LOCAL JUMP LOCATION
Sprite3_CheckDamageToPlayer:
{
    JSL.l Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; $0F4270-$0F4378
incsrc "sprite_flame.asm"

; $0F4379-$0F46FF
incsrc "sprite_yellow_stalfos.asm"

; $0F4700-$0F4AF3
incsrc "sprite_eyegore_and_goriya.asm"

; $0F4AF4-$0F4C01
incsrc "sprite_bubble_group.asm"

; $0F4C02-$0F4CD2
incsrc "sprite_hover.asm"

; $0F4CD3-$0F4F46
incsrc "sprite_crystal_maiden.asm"

; $0F4F47-$0F5011
incsrc "sprite_spike_trap.asm"

; $0F5012-$0F51CC
incsrc "sprite_guruguru_bar.asm"

; $0F51CD-$0F528C
incsrc "sprite_winder.asm"

; $0F528D-$0F530F
incsrc "sprite_green_stalfos.asm"

; $0F5310-$0F5A41
incsrc "sprite_agahnim.asm"

; $0F5A42-$0F5C5A
incsrc "sprite_energy_ball.asm"

; $0F5C5B-$0F603B
incsrc "sprite_bees.asm"
    
; $0F603C-$0F60DC
incsrc "sprite_hylian_plaque.asm"

; $0F60DD-$0F6110
incsrc "sprite_thief_chest.asm"

; $0F6111-$0F62E8
incsrc "sprite_bomb_shop_entity.asm"

; $0F62E9-$0F6859
incsrc "sprite_kiki.asm"

; $0F68B6-$0F68F0
incsrc "sprite_blind_maiden.asm"

; $0F68F1-$0F6AE6
incsrc "sprite_old_mountain_man.asm"

; $0F6AE7-$0F6B32
incsrc "sprite_dialogue_tester.asm"

; $0F6B33-$0F6E55
incsrc "sprite_bully_and_ball_guy.asm"

; $0F6E56-$0F6EEE 
incsrc "sprite_whirlpool.asm"

; $0F6EEF-$0F74F2
incsrc "sprite_shopkeeper.asm"

; ==============================================================================

; $0F74F3-$0F7507 LONG JUMP LOCATION
Sprite_PlayerCantPassThrough:
{
    LDA.w $0F60, X : PHA
    
    STZ.w $0F60, X
    
    ; Also, if bit 7 of $0E40, X is not set, it will hurt Link.
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_contact
        JSR.w Sprite_HaltSpecialPlayerMovement
    
    .no_contact
    
    PLA : STA.w $0F60, X
    
    RTL
}

; ==============================================================================

; $0F7508-$0F7514 LOCAL JUMP LOCATION
Sprite_HaltSpecialPlayerMovement:
{
    PHX
    
    JSL.l Sprite_NullifyHookshotDrag
    
    STZ.b $5E ; Set Link's speed to zero...
    
    JSL.l Player_HaltDashAttackLong
    
    PLX
    
    RTS
}

; ==============================================================================

; $0F7515-$0F7602
incsrc "sprite_apple.asm"

; $0F7603-$0F7631
incsrc "sprite_drinking_guy.asm"

; $0F7632-$0F7D11
incsrc "sprite_transit_entities.asm"

; $0F7D12-$0F7E68
incsrc "sprite_fairy_handle_movement.asm"

; ==============================================================================

; $0F7E69-$0F7E6D LOCAL JUMP LOCATION
Sprite3_DirectionToFacePlayer:
{
    JSL.l Sprite_DirectionToFacePlayerLong
    
    RTS
}

; ==============================================================================

; $0F7E6E-$0F7E72 LOCAL JUMP LOCATION
Sprite3_IsToRightOfPlayer:
{
    JSL.l Sprite_IsToRightOfPlayerLong
    
    RTS
}

; ==============================================================================

; $0F7E73-$0F7E77 LOCAL JUMP LOCATION
Sprite3_IsBelowPlayer:
{
    JSL.l Sprite_IsBelowPlayerLong
    
    RTS
}

; ==============================================================================

; $0F7E78-$0F7E94 LOCAL JUMP LOCATION
Sprite3_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        ; $0F7E7F ALTERNATE ENTRY POINT
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

; $0F7E95-$0F7E9A DATA
Sprite3_CheckIfRecoiling_frame_counter_masks:
{
    db $03, $01, $00, $00, $0C, $03
}

; ==============================================================================

; $0F7E9B-$0F7F1D LOCAL JUMP LOCATION
Sprite3_CheckIfRecoiling:
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
                
                LDA.b $1A : AND Sprite3_CheckIfRecoiling_frame_counter_masks, Y : BNE .halted
                    LDA.w $0F30, X : STA.w $0D40, X
                    LDA.w $0F40, X : STA.w $0D50, X
                    
                    LDA.w $0CD2, X : BMI .no_wall_collision
                        JSR.w Sprite3_CheckTileCollision
                        
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
                    
                    JSR.w Sprite3_Move
            
            .halted
            
            PLA : STA.w $0D50, X
            PLA : STA.w $0D40, X
            
            ; Explicit check for Agahnim.
            LDA.w $0E20, X : CMP.b #$7A : BEQ .return
                PLA : PLA
        
        .return
        
        RTS
    
    .recoil_finished
    
    STZ.w $0EA0, X
    
    RTS
}

; ==============================================================================

; $0F7F1E-$0F7F20 LOCAL JUMP LOCATION
Sprite3_MoveXyz:
{
    JSR.w Sprite3_MoveAltitude
    
    ; Bleeds into the next function.
}

; $0F7F21-$0F7F27 LOCAL JUMP LOCATION
Sprite3_Move:
{  
    JSR.w Sprite3_MoveHoriz
    JSR.w Sprite3_MoveVert
    
    RTS
}

; ==============================================================================

; $0F7F28-$0F7F33 LOCAL JUMP LOCATION
Sprite3_MoveHoriz:
{
    TXA : CLC : ADC.b #$10 : TAX
    
    JSR.w Sprite3_MoveVert
    
    LDX.w $0FA0
    
    RTS
}

; ==============================================================================

; $0F7F34-$0F7F61 LOCAL JUMP LOCATION
Sprite3_MoveVert:
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

; $0F7F62-$0F7F83 LOCAL JUMP LOCATION
Sprite3_MoveAltitude:
{
    LDA.w $0F80, X : ASL #4 : CLC : ADC.w $0F90, X : STA.w $0F90, X
    
    LDA.w $0F80, X : PHP : LSR #4 : PLP : BPL .positive
        ORA.b #$F0
    
    .positive
    
    ADC.w $0F70, X : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $0F7F84-$0F7F8C LOCAL JUMP LOCATION
Sprite3_PrepOamCoord:
{
    JSL.l Sprite_PrepOamCoordLong : BCC .renderable
        PLA : PLA
    
    .renderable
    
    RTS
}

; ==============================================================================

; $0F7F8D-$0F7FDD LONG JUMP LOCATION
Sprite_DrawRippleIfInWater:
{
    LDA.l $7FF9C2, X
    
    CMP.b #$08 : BEQ .waterTile
        CMP.b #$09 : BNE .notWaterTile
    
    .waterTile
    
    LDA.w $0E60, X : AND.b #$20 : BEQ .dontAdjustX
        LDA.w $0FD8 : SEC : SBC.b #$04 : STA.w $0FD8
        LDA.w $0FD9 : SBC.b #$00 : STA.w $0FD9
        
        ; Is it a small magic refill?
        LDA.w $0E20, X : CMP.b #$DF : BNE .dontAdjustY
            LDA.w $0FDA : SEC : SBC.b #$07 : STA.w $0FDA
            LDA.w $0FDB : SBC.b #$00 : STA.w $0FDB

        .dontAdjustY
    
    .dontAdjustX
    
    JSL.l Sprite_DrawWaterRipple
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    LDA.w $0E40, X : AND.b #$1F : INC : ASL : ASL
    JSL.l OAM_AllocateFromRegionA
    
    .notWaterTile
    
    RTL
}

; ==============================================================================

; $0F7FDE-$0F7FFF NULL
NULL_1EFFDE:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF
}

; ==============================================================================

warnpc $1F8000
