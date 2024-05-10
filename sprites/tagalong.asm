
; ==============================================================================
    
; $049E90-$049EF7 LONG JUMP LOCATION
Tagalong_CheckBlindTriggerRegion:
{
    PHB : PHK : PLB
    
    LDX $02CF
    
    LDA $1A00, X : STA $00
    LDA $1A14, X : STA $01
    
    LDA $1A28, X : STA $02
    LDA $1A3C, X : STA $03
    
    STZ $0B
    
    LDA $1A50, X : STA $0A : BPL .non_negative_altitude
      LDA.b #$FF : STA $0B
  .non_negative_altitude
    
    REP #$20
    
    LDA $00 : CLC : ADC $0A : CLC : ADC.w #$000C : STA $00
    LDA $02 : CLC : ADC.w #$0008 : STA $02
    
    LDA.w #$1568 : SEC : SBC $00 : BPL .non_negative_delta_x
      EOR.w #$FFFF : INC A
  .non_negative_delta_x
    
    CMP.w #$0018 : BCS .out_of_range
    
    LDA.w #$1980 : SEC : SBC $02 : BPL .non_negative_delta_y
      EOR.w #$FFFF : INC A
  .non_negative_delta_y
    
    CMP.w #$0018 : BCS .out_of_range
    SEP   #$20
    PLB
    SEC
    RTL
    
  .out_of_range
    SEP #$20
    PLB
    CLC
    RTL
}

; ==============================================================================

; $049EF8-$049EFB DATA
Tagalong_Priorities:
{
    db $20, $10, $30, $20
}

; ==============================================================================

; $049EFC-$049F38 LONG JUMP LOCATION
Tagalong_Init:
{
    PHB : PHK : PLB
    
    ; Load Link's x and y coordinates byte by byte
    LDA $20 : STA $1A00 ; FOLLOWERYL
    LDA $21 : STA $1A14 ; FOLLOWERYH
    LDA $22 : STA $1A28 ; FOLLOWERXL
    LDA $23 : STA $1A3C ; FOLLOWERXH
    
    ; $00 = Link's direction
    LDA $2F : LSR A : STA $00
    
    LDY $EE
    
    ; Link's sprite priority?
    LDA Tagalong_Priorities, Y : LSR #2 : ORA $00 : STA $1A64
    
    LDA.b #$40 : STA $02D2
    
    STZ $02CF ; Follower animation read 0x00-0x13
    STZ $02D3 ; Follower animation write 0x00-0x13
    STZ $02D0 ; Follower hookshot flag 
    STZ $02D6 ; Free follower ram
    
    STZ $5E
    
    PLB
    
    RTL
}

; ==============================================================================

; $049F39-$049F90 LONG JUMP LOCATION
Tagalong_SpawnFromSprite:
{
    PHB : PHK : PLB : PHX
    
    STZ $02F9
    
    LDA $0D00, X : CLC : ADC.b #$FA : STA $1A00
    LDA $0D20, X : ADC.b #$FF : STA $1A14
    
    LDA $0D10, X : CLC : ADC.b #$01 : STA $1A28
    LDA $0D30, X : ADC.b #$00 : STA $1A3C
    
    LDY $EE
    
    LDA Tagalong_Priorities, Y : LSR #2 : ORA.b #$01 : STA $1A64
    
    LDA #$40 : STA $02D2
    
    STZ $02D3
    STZ $02CF
    STZ $02D0
    STZ $02D6
    
    STZ $5E
    STZ $02F9
    
    ; Super bomb is no longer going off?
    LDA.b #$00 : STA $7EF3D3
    
    JSL Tagalong_GetCloseToPlayer
    
    PLX : PLB
    
    RTL
}

; ==============================================================================

; $049F91-$049F98 LONG JUMP LOCATION
Tagalong_MainLong:
{
    PHB : PHK : PLB
    
    JSR Tagalong_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $049F99-$049FB4 LOCAL JUMP TABLE
Tagalong_MainHandlers:
{
    ; Tagalong Routines 1 (and only so far)
    ; Index into table is the value of $7EF3CC
    
    .handlers
    
    dw Tagalong_BasicMover     ; 0x01 - Princess Zelda 
    dw Tagalong_OldMountainMan ; 0x02 - Old man (unused alternate) 
    ; Dashing or jumping off a ledge will disconnect the Tagalong from moving with the player.
    dw Tagalong_UnusedOldMan         ; 0x03 - Old man (unused alternate) 
    ; waiting around for player to pick them up.
    dw Tagalong_OldMountainMan ; 0x04 - Normal old man
    dw Tagalong_Telepathy      ; 0x05 - Zelda Rescue Telepathy
    dw Tagalong_BasicMover     ; 0x06 - Blind Maiden
    dw Tagalong_BasicMover     ; 0x07 - Frogsmith
    dw Tagalong_BasicMover     ; 0x08 - Smithy
    dw Tagalong_BasicMover     ; 0x09 - Locksmith
    dw Tagalong_BasicMover     ; 0x0A - Kiki
    dw Tagalong_UnusedOldMan         ; 0x0B - Unused old man
    dw Tagalong_BasicMover     ; 0x0C - Thief's chest
    dw Tagalong_BasicMover     ; 0x0D - Super Bomb
    dw Tagalong_Telepathy      ; 0x0E - Master Sword Telepathy
}

; ==============================================================================

; $049FB5-$049FC3 DATA
Tagalong_MessageTagalongs:
    db $05 ; Zelda's rescue telepathy 
    db $09 ; Locksmith 
    db $0A ; Kiki
    
Tagalong_MessageTimers:
    dw $0DF3, $06F9, $0DF3
  
Tagalong_MessageIds:
    dw $0020, $0180, $011D


; ==============================================================================

; $049FC4-$04A196 LOCAL JUMP LOCATION
Tagalong_Main:
{
    LDA $7EF3CC : BNE .player_has_tagalong
      RTS
    .player_has_tagalong
    
    CMP.b #$0E : BNE .not_boss_victory
      BRL Tagalong_HandleTrigger
    .not_boss_victory
    
    LDY.b #$02
    
    .next_tagalong
    LDA $7EF3CC : CMP Tagalong_MessageTagalongs, Y : BEQ .tagalong_with_timer
      DEY : BPL .next_tagalong
    BRL Tagalong_NoTimedMessage
    .tagalong_with_timer
    
    ; Check if not in the default standard submodule
    LDA $11 : BNE Tagalong_Telepathy
    
    ; Special case for kiki
    CPY.b #$02 : BNE .not_kiki
      LDA $8A : AND.b #$40 : BNE Tagalong_Telepathy
    .not_kiki
    
    REP #$20
    
    ; Tick down the timer until Zelda bitches at you again.
    DEC $02CD : BPL Tagalong_Telepathy
    
      SEP #$20
      JSL Tagalong_CanWeDisplayMessage : BCS .can_display
        STZ $02CD : STZ $02CE
        BRA Tagalong_Telepathy
      .can_display
      REP #$20
      
      PHY
      
      TYA : AND.w #$00FF : ASL A : TAY
      
      LDA Tagalong_MessageTimers, Y : STA $02CD
      LDA Tagalong_MessageIds,    Y : STA $1CF0
      
      SEP #$20
      
      JSL Main_ShowTextMessage
      
      PLY
    
; $04A024 ALTERNATE ENTRY POINT
Tagalong_Telepathy:
    SEP   #$20
    CPY.b #$00 : BNE Tagalong_NoTimedMessage
      RTS

Tagalong_NoTimedMessage:
    
    SEP #$20
    
    ; Check if the super bomb is going off
    LDA $7EF3D3 : BEQ .super_bomb_not_going_off
      BRL .not_following_bounce
    .super_bomb_not_going_off
    
    ; Is if the thief's chest tagalong?
    LDA $7EF3CC : CMP.b #$0C : BNE .not_thief_chest
      LDA $4D : BNE .not_default_game_mode
      BRA .continue_a
    .not_thief_chest
    
    LDA $7EF3CC : CMP.b #$0D : BEQ .not_super_bomb_a
      .not_default_game_mode
      BRL Tagalong_CheckGameMode
    .not_super_bomb_a
    
    LDA $4D : CMP.b #$02 : BEQ .recoiling_or_falling
    LDA $5B : CMP.b #$02 : BEQ .recoiling_or_falling
  .continue_a
    
    LDA $11 : BNE .not_default_game_mode
    
    LDA $4D : CMP.b #$01 : BEQ Tagalong_CheckGameMode
               BIT $0308 : BMI Tagalong_CheckGameMode
               LDA $02F9 : BNE Tagalong_CheckGameMode
               LDA $02D0 : BNE Tagalong_CheckGameMode
    
    LDX $02CF
    
    LDA $1A50, X : BEQ .zero_altitude
                   BPL Tagalong_CheckGameMode
    
    .zero_altitude
    
    LDA $F6 : AND.b #$80 : BEQ Tagalong_CheckGameMode
    
    .recoiling_or_falling
    
    LDA $7EF3CC : CMP.b #$0D : BNE .not_superbomb_outdoors
    
    LDA $1B : BNE .not_superbomb_outdoors
    
    LDA $5D
    
    CMP.b #$08 : BEQ Tagalong_CheckGameMode
    CMP.b #$09 : BEQ Tagalong_CheckGameMode
    CMP.b #$0A : BEQ Tagalong_CheckGameMode
    
    LDA.b #$03 : STA $04B4
    LDA.b #$BB : STA $04B5
    
    .not_superbomb_outdoors
    
    ; This occurs when the bomb is set to trigger by Link
    LDA.b #$80 : STA $7EF3D3
    
    LDA.b #$40 : STA $02D2
    
    LDX $02CF
    
    LDA $1A00, X : STA $7EF3CD
    LDA $1A14, X : STA $7EF3CE
    
    LDA $1A28, X : STA $7EF3CF
    LDA $1A3C, X : STA $7EF3D0
    
    LDA $EE : STA $7EF3D2
    
    LDA $1B : STA $7EF3D1
    
    .not_following_bounce
    
    BRL Tagalong_NotFollowing
    
Tagalong_CheckGameMode:
    
    SEP #$20
    
    LDA $02E4 : BNE .dont_do_anything
    
    LDX $10
    
    LDY $11 : CPY.b #$0A : BEQ .dont_do_anything
    
    CPX.b #$09 : BNE .not_overworld
    
    CPY.b #$23 : BEQ .dont_do_anything
    
    .not_overworld
    
    CPX.b #$0E : BNE .not_text_mode
    
    CPY.b #$01 : BEQ .dont_do_anything
    CPY.b #$02 : BNE .not_text_mode
    
    .dont_do_anything
    
    BRL Tagalong_ExecuteAI
    
    .not_text_mode
    
    LDA $30 : ORA $31 : BEQ Tagalong_ExecuteAI
    
    LDX $02D3 : INX : CPX.b #$14 : BNE .dont_reset_movement_index
    
    LDX.b #$00
    
    .dont_reset_movement_index
    
    STX $02D3
    
    LDA $24 : CMP.b #$F0 : BCC .use_links_altitude
    
    LDA.b #$00
    
    .use_links_altitude
    
    STA $00
    STZ $01
    
    LDA $00 : STA $1A50, X
    
    REP #$20
    
    LDA $20 : SEC : SBC $00 : STA $00
    
    SEP #$20
    
    LDA $00 : STA $1A00, X
    LDA $01 : STA $1A14, X
    LDA $22 : STA $1A28, X
    LDA $23 : STA $1A3C, X
    
    LDA $2F : LSR A : STA $1A64, X
    
    LDY $EE
    
    LDA Tagalong_Priorities, Y : LSR #2 : ORA $1A64, X : STA $1A64, X
    
    LDA $5D : CMP.b #$04 : BNE .not_swimming
    
    LDY.b #$20
    
    BRA .set_priority
    
    .not_swimming
    
    CMP.b #$13 : BNE .not_hookshot_drag
    
    LDA $037E : BEQ .not_hookshot_drag
    
    LDA.b #$10 : ORA $1A64, X : STA $1A64, X
    
    .not_hookshot_drag
    
    LDY.b #$80
    
    LDA   $0351  : BEQ Tagalong_ExecuteAI
    CMP.b #$01 : BEQ .set_priority
    
    LDY.b #$40
    
    .set_priority
    
    TYA : ORA $1A64, X : STA $1A64, X
    
Tagalong_ExecuteAI:
    
    LDA $7EF3CC : DEC A : ASL A : TAX
    
    JMP (Tagalong_MainHandlers, X)
    
    .unused
    
    RTS
}

; $04A197-$04A2B0 JUMP LOCATION
Tagalong_BasicMover:
{
    LDA $02E4 : BNE .not_in_cutscene
      LDX $10
      LDY $11 : CPY.b #$0A : BEQ .not_in_cutscene
        CPX.b #$09 : BNE .not_overworld
          CPY.b #$23 : BEQ .not_in_cutscene
        .not_overworld
        
        CPX.b #$0E : BNE .not_text_mode
          CPY.b #$01 : BEQ .not_in_cutscene
            CPY.b #$02 : BNE .not_text_mode
    .not_in_cutscene
    BRL .proceed_to_draw
    
    .not_text_mode
    JSR Tagalong_HandleTrigger ; $04A59E IN ROM
    
    LDA $7EF3CC : CMP.b #$0A : BNE .dont_scare_kiki
      LDA $4D : BEQ .dont_scare_kiki
        LDA $031F : BEQ .dont_scare_kiki
          
          LDA $02CF : INC A : CMP.b #$14 : BNE .no_index_wrap
            LDA.b #$00
          .no_index_wrap
          
          JSL   Kiki_AbandonDamagedPlayer
          LDA.b #$00 : STA $7EF3CC
          RTS
    .dont_scare_kiki
    
    ; Check if tagalong == Blind in disguise as maiden.
    LDA $7EF3CC : CMP.b #$06 : BNE .blind_not_triggered
    
    REP #$20
    
    ; Check if it's Blind's boss room.
    LDA $A0 : CMP.w #$00AC : BNE .blind_not_triggered
    
    ; Check if the hole in the floor in the room above has been bombed out
    ; in order to let light in from the window.
    LDA $7EF0CA : AND.w #$0100 : BEQ .blind_not_triggered
    
    SEP #$20
    
    JSL Tagalong_CheckBlindTriggerRegion : BCC .blind_not_triggered
    
  .blind_transform
    LDX $02CF
    
    LDA $1A28, X : STA $00
    LDA $1A3C, X : STA $01
    
    LDA $1A00, X : STA $02
    LDA $1A14, X : STA $03
    
    LDA.b #$00 : STA $7EF3CC
    
    JSL Blind_SpawnFromMaidenTagalong
    
    INC $0468
    
    STZ $068E
    STZ $0690
    
    LDA.b #$05 : STA $11
    
    LDA.b #$15 : STA $012C ; SONG 15
    
    RTS
    
    .blind_not_triggered
    
    SEP #$20
    
    LDY $5D
    
    LDA $02D0 : BNE .ignore_hook
    
    CPY.b #$13 : BNE .no_hookshot_dragging
    
    LDA $037E : BEQ .no_hookshot_dragging
    
    LDA.b #$01 : STA $02D0
    
    BRA .continue_from_hook
    
    .ignore_hook
    
    CPY.b #$13 : BEQ .continue_from_hook
    
    LDA $02D1 : CMP $02CF : BNE .advance_movement_index
    
    STZ $02D0
    
    .no_hookshot_dragging
    
    LDX $02CF
    
    LDA $1A50, X : BEQ .not_default_game_mode  BMI .not_default_game_mode
    
    LDA $02D3 : CMP $02CF : BNE .advance_movement_index
    
    STZ $1A50, X
    
    LDA $20 : STA $1A00, X
    LDA $21 : STA $1A14, X
    LDA $22 : STA $1A28, X
    LDA $23 : STA $1A3C, X
    
    .not_default_game_mode

    LDA $30 : ORA $31 : BEQ .proceed_to_draw
    
    .continue_from_hook
    
    LDA $02D3 : SEC : SBC.b #$0F : BPL .dont_wrap_index_a
      CLC : ADC.b #$14
    .dont_wrap_index_a
    
    CMP $02CF : BNE .proceed_to_draw
    
    .advance_movement_index
    
    LDX $02CF : INX : CPX.b #$14 : BNE .dont_wrap_index_b
      LDX.b #$00
    .dont_wrap_index_b
    
    STX $02CF
    
    .proceed_to_draw
    
    BRL Tagalong_Draw
}

; $04A2B1-$04A2B1 BRANCH LOCATION
Tagalong_LocalExit:
{
    RTS
}
    
; $04A2B2-$04A308 JUMP LOCATION
Tagalong_NotFollowing:
{
    LDA $7EF3D1 : CMP $1B : BNE Tagalong_LocalExit ; if indoors, don't branch
    
    ; Is Link dashing?
    LDA $0372 : BNE .dont_reset_self ; Yes... branch to alpha
    
    JSR Tagalong_CheckPlayerProximity : BCS .dont_reset_self
    
    JSL Tagalong_Init
    
    LDA $1B : STA $7EF3D1
    
    LDA $7EF3CC : CMP.b #$0D : BNE .not_superbomb
      LDA.b #$FE : STA $04B4
      STZ $04B5
    .not_superbomb
    
    LDA.b #$00 : STA $7EF3D3
    BRL Tagalong_Draw
    
    .dont_reset_self
    
    ; Is it a super bomb?
    LDA $7EF3CC : CMP.b #$0D : BNE .not_superbomb_exploding ; no, get out of here
      ; Are we indoors?
      LDA $1B : BNE .not_superbomb_exploding ; yes, get out of here >(
      LDA $04B4 : BNE .not_superbomb_exploding
        LDY.b #$00
        LDA.b #$3A
        JSL AddSuperBombExplosion
        LDA.b #$00 : STA $7EF3D3
    .not_superbomb_exploding
    
    BRL Tagalong_DoLayers
}

; ==============================================================================

; $04A309-$04A317 DATA
pool Tagalong_OldMountainMan:
{
    .replacement_tagalong
    db 0, 0, 3, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
}

; ==============================================================================

; $04A318-$04A40F JUMP LOCATION
Tagalong_OldMountainMan:
{
    ; Old Man on the Mountain tagalong routine
    
    ; Can Link move?
    LDA $02E4 : BNE .proceed_to_just_draw
    
    ; Is Link coming out of a door into the overworld?
    LDX $10
    
    LDY $11 : CPY.b #$0A : BEQ .proceed_to_just_draw
    
    CPX.b #$09 : BNE .not_overworld
      ; Is the magic mirror being used?
      CPY.b #$23 : BEQ .proceed_to_just_draw
    .not_overworld
    
    ; Are we in text mode?
    CPX.b #$0E : BNE .not_textbox
    
    CPY.b #$01 : BEQ .proceed_to_just_draw
    CPY.b #$02 : BNE .not_textbox ; Text message mode
    
    .proceed_to_just_draw
    
    BRL .just_draw
    
    .not_textbox
    
    ; Make an exception for movement speeds. It's not dashing speed, so
    ; I'm not sure what speed type this is.
    LDA $5E : CMP.b #$04 : BEQ .dont_reset_link_speed
      LDA.b #$0C : STA $5E
    .dont_reset_link_speed
    
    JSR Tagalong_HandleTrigger ; $04A59E IN ROM
    
    SEP #$30
    
    LDA $7EF3CC : BNE .have_old_man_indeed
      RTS
    .have_old_man_indeed
    
    CMP.b #$04 : BNE .not_normal_old_man
      LDX $02CF
      LDA $1A50, X : BEQ .proceed_to_check_velocity 
                     BMI .proceed_to_check_velocity
      
      LDA $02CF : CMP $02D3 : BEQ .proceed_to_check_velocity
        BRL .advance_movement_index
      .proceed_to_check_velocity
      
      BRL .check_link_velocity
    
    .not_normal_old_man
    
    LDA $4D : AND.b #$01 : BEQ .check_for_recoiling
    
    ; Is Link in a recoil state?
    LDA $5D : CMP.b #$06 : BNE .check_for_recoiling ; if not, then branch away
    
    LDA $02D3 : CMP $02CF : BNE .replace_that_follower
    
    DEX : STX $02CF : BPL .replace_that_follower
    
    LDA.b #$13 : STA $02CF
    
    .check_for_recoiling
    
    LDA $4D : AND.b #$02 : BEQ .check_link_velocity
    
    .replace_that_follower
    
    LDA $7EF3CC : TAX
    
    LDA .replacement_tagalong, X : STA $7EF3CC
    
    LDA.b #$40 : STA $02D2
    
    LDX $02CF
    
    LDA $1A00, X : STA $7EF3CD
    LDA $1A14, X : STA $7EF3CE
    
    LDA $1A28, X : STA $7EF3CF
    LDA $1A3C, X : STA $7EF3D0
    
    LDA $EE : STA $7EF3D2
    
    BRA Tagalong_UnusedOldMan
    
    .check_link_velocity
    
    LDA $30 : ORA $31 : BNE .link_moving
    
    LDA $1A : AND.b #$03 : BNE .just_draw
    
    LDA $02D3 : CMP $02CF : BEQ .just_draw
    
    SEC : SBC.b #$09 : BPL .no_back_wrap_a
      CLC : ADC.b #$14
    .no_back_wrap_a
    
    CMP $02CF : BNE .advance_movement_index
    
    BRL .just_draw
    
    .link_moving
    
    LDA $02D3 : SEC : SBC.b #$14 : BPL .no_back_wrap_b
      CLC : ADC.b #$14
    .no_back_wrap_b
    
    CMP $02CF : BNE .just_draw
    
    .advance_movement_index
    
    LDX $02CF : INX : CPX.b #$14 : BCC .no_wrap
      LDX.b #$00
    .no_wrap
    
    STX $02CF
    
    .just_draw
    
    BRL Tagalong_Draw
    
    RTS ; Unreachable
}

; ==============================================================================

; \scawful: Potential expansion point for the Tagalong system.
; $04A410-$04A41E DATA
Tagalong_ReplacementTagalongIds:
{
    db $00 ; 0x00 - No tagalong
    db $00 ; 0x01 - Zelda
    db $00 ; 0x02 - Old man (unused alternate)
    db $02 ; 0x03 - Unused old man
    db $00 
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
    db $00
}

; ==============================================================================

; $04A41F-$04A48D JUMP LOCATION
Tagalong_UnusedOldMan:
{
    ; Slow down the player...
    LDA.b #$10 : STA $5E
    
    ; Is Link dashing?
    LDA $0372 : BNE Tagalong_DoLayers
    LDA $4D : BNE Tagalong_DoLayers
    
    ; Is player swimming?
    LDA $5D : CMP.b #$04 : BEQ Tagalong_DoLayers
      STZ $5E

    ; Is player in hookshot mode?
    LDA $5D : CMP.b #$13 : BEQ Tagalong_DoLayers
    JSR Tagalong_CheckPlayerProximity : BCS Tagalong_DoLayers
      JSL Tagalong_Init
      LDA $7EF3CC : TAX
      LDA Tagalong_ReplacementTagalongIds, X : STA $7EF3CC
      RTS
    
; $04A450 ALTERNATE ENTRY POINT
Tagalong_DoLayers:
    
    LDA $7EF3D2 : TAX : CPX $EE : BNE .layer_mismatch
      LDX $EE
    .layer_mismatch
    
    LDA Tagalong_Priorities, X 
    STA $65 : STZ $64
    
    LDA $7EF3CD : STA $00
    LDA $7EF3CE : STA $01
    
    LDA $7EF3CF : STA $02
    LDA $7EF3D0 : STA $03
    
    LDX.b #$02
    
    LDA $7EF3CC : CMP.b #$0D : BEQ .bomb_or_chest
                  CMP.b #$0C : BEQ .bomb_or_chest
      LDX.b #$01
    .bomb_or_chest
    
    TXA
    
    BRL Tagalong_AnimateMovement_Preserved
}

; ==============================================================================

; $04A48E-$04A4C7 LOCAL JUMP LOCATION
Tagalong_CheckPlayerProximity:
{
    DEC $02D2 : BPL .delay
    
    STZ $02D2
    
    REP #$20
    
    LDA $7EF3CD : SEC : SBC.w #$0001 : CMP $20 : BCS .not_in_range
                  CLC : ADC.w #$0014 : CMP $20 : BCC .not_in_range
    
    LDA $7EF3CF : SEC : SBC.w #$0001 : CMP $22 : BCS .not_in_range
                  CLC : ADC.w #$0014 : CMP $22 : BCC .not_in_range
    
    SEP #$20
    
    CLC
    
    RTS
    
    .delay
    .not_in_range
    
    SEP #$20
    
    SEC
    
    RTS
}

; ==============================================================================

; $04A4C8-$04A59D DATA
pool Tagalong_HandleTrigger:
{
    .rooms_with_special_text_1
    dw $00F1
    dw $0061
    dw $0051
    dw $0002
    dw $00DB
    dw $00AB
    dw $0022
    
    ; $04A4D6 to $4A54D
    .room_data_1
    ; ?
    ; ?
    ; ?
    ; text message number,
    ; tagalong number
    dw $1EF0, $0288, $0001, $0099, $0004
    dw $1E58, $02F0, $0002, $009A, $0004
    dw $1EA8, $03B8, $0004, $009B, $0004
    dw $0CF8, $025B, $0001, $0021, $0001
    dw $0CF8, $039D, $0002, $0021, $0001
    dw $0C78, $0238, $0004, $0021, $0001
    dw $0A30, $02F8, $0001, $0022, $0001
    dw $0178, $0550, $0001, $0023, $0001
    dw $0168, $04F8, $0002, $002A, $0001
    dw $1BD8, $16FC, $0001, $0124, $0006
    dw $1520, $167C, $0001, $0124, $0006
    dw $05AC, $04FC, $0001, $0029, $0001
    
    ; $4A54E
    .areas_with_special_text_1
    dw $0003
    dw $005E
    dw $0000
    
    ; $04A554 to $4A585
    .area_data_1
    dw $03C0, $0730, $0001, $009D, $0004
    dw $0648, $0F50, $0000, $FFFF, $000A
    dw $06C8, $0D78, $0001, $FFFF, $000A
    dw $0688, $0C78, $0002, $FFFF, $000A
    dw $00E8, $0090, $0000, $0028, $000E
    
    ; $04A586 ($4A588 too, in a way)
    .room_data_boundaries_1
    dw 0, 30, 60, 70, 90, 100, 110, 120,
    
    ; $4A596
    .area_data_boundaries_1
    dw 0, 10, 40, 50
}

; ==============================================================================

; $04A59E-$04A6CC LOCAL JUMP LOCATION
Tagalong_HandleTrigger:
{
    LDA $11 : BNE .no_text_message
    
    REP #$30
    
    LDY #$0000
    
    LDA $1B : AND.w #$00FF : BEQ .check_areas
    
    INY
    
    LDX.w #$000C
    
    LDA $A0
    
    .check_next_room
    
    CMP $A4C8, X : BEQ .room_match
    
    DEX #2 : BPL .check_next_room
    
    BRA .no_text_message
    
    .check_areas
    
    LDX.w #$0004
    
    LDA $8A
    
    .check_next_area
    
    ; Select graphics based on certain areas maybe?
    ; the areas mentioned in this array are the mountain, the forest,
    ; and the maze in the dark world (i.e. ???, old man, and kiki)
    CMP $A54E, X : BEQ .area_match
    
    DEX #2 : BPL .check_next_area
    
    .no_text_message
    
    BRL .return
    
    .room_match
    
    LDA.w $A588, X : STA $08
    
    LDA.w $A586, X : TAX
    
    .next_room_data_block
    
    STX $0C
    
    STZ $0A
    
    LDA $7EF3CC : AND.w #$00FF : CMP $A4DE, X : BNE .not_room_data_match
    
    LDA.w $A4D6, X : STA $00
    LDA.w $A4D8, X : STA $02
    LDA.w $A4DA, X : STA $06
    LDA.w $A4DC, X : STA $04
    
    SEP #$30
    
    JSR Tagalong_CheckTextTriggerProximity : BCS .check_flags_and_proximity
    
    REP #$30
    
    .not_room_data_match
    
    LDA $0C : CLC : ADC.w #$000A : TAX
    
    CPX $08 : BNE .next_room_data_block
    
    BRL .return
    
    .area_match
    
    LDA.w $A598, X : STA $08
    LDA.w $A596, X : TAX
    
    .next_area_data_block
    
    STX $0C
    STZ $0A
    
    LDA $7EF3CC : AND.w #$00FF : CMP $A55C, X : BNE .not_area_data_match
    
    LDA.w $A554, X : STA $00
    LDA.w $A556, X : STA $02
    LDA.w $A558, X : STA $06
    LDA.w $A55A, X : STA $04
    
    SEP #$30
    
    JSR Tagalong_CheckTextTriggerProximity : BCS .check_flags_and_proximity
    
    REP #$30
    
    .not_area_data_match
    
    LDA $0C : CLC : ADC.w #$000A : TAX
    
    CPX $08 : BNE .next_area_data_block
    
    BRA .return
    
    .check_flags_and_proximity
    
    SEP #$10
    REP #$20
    
    ; Message has already triggered once during this instance of being
    ; in this room or area.
    LDA $02F2 : AND $06 : BNE .return
    
    LDA $06 : TSB $02F2
    
    ; Configure the text message index.
    LDA $04 : STA $1CF0
    
    CMP.w #$FFFF : BEQ .no_text_message
    CMP.w #$009D : BEQ .certain_kiki_message
    CMP.w #$0028 : BNE .show_text_message
    
    SEP #$20
    
    LDA #$00 : STA $7EF3CC
    
    BRA .show_text_message
    
    .certain_kiki_message
    
    SEP #$20
    
    LDA $02CF : INC A : CMP.b #$14 : BNE .tagalong_state_index_not_maxed
    
    LDA.b #$00
    
    .tagalong_state_index_not_maxed
    
    JSL OldMountainMan_TransitionFromTagalong
    
    .show_text_message
    
    SEP #$20
    
    JSL Main_ShowTextMessage
    
    BRA .return
    
    .no_text_message
    
    SEP #$30
    
    LDA $02CF : INC A : CMP.b #$14 : BNE .tagalong_state_index_not_maxed_2
    
    LDA.b #$00
    
    .tagalong_state_index_not_maxed_2
    
    PHA
    
    LDA $06 : AND.b #$03 : BNE .kiki_first_begging_sequence
    
    PLA
    
    JSL Kiki_InitiatePalaceOpeningProposal
    
    BRA .return
    
    .kiki_first_begging_sequence
    
    PLA : STA $00
    
    LDX $8A
    
    LDA $7EF280, X : AND.b #$01 : BNE .return
    
    LDA $00
    
    JSL Kiki_InitiateFirstBeggingSequence
    
    .return
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $04A6CD-$04A906 DATA
TagalongDraw_Drawing:
{
    ; \task Fill in data later and name these routines.
    
}

; ==============================================================================

; $04A907-$04ABF8 LOCAL JUMP LOCATION
Tagalong_Draw:
{
    ; best guess so far: zero if your tagalong is transforming, nonzero
    ; otherwise
    LDA $02F9 : BEQ .begin_draw
      RTS
    .begin_draw

    PHX : PHY
    
    LDX $02CF
    
    LDA $1A50, X : BEQ .not_floating_outdoors
      LDA $1B : BNE .not_floating_outdoors
        LDA.b #$20
        BRA   .continue
    .not_floating_outdoors

    LDA $11 : CMP.b #$0E : BNE .dont_copy_priority
      LDY $EE : LDA Tagalong_Priorities, Y
      BRA .continue
    .dont_copy_priority

    LDA $1A64, X : AND.b #$0C : ASL #2

    .continue
    STA $65 : STZ $64
    LDX $02CF : BPL .no_back_wrap
      LDX.b #$00
    .no_back_wrap

    LDA $1A00, X : STA $00
    LDA $1A14, X : STA $01
    
    LDA $1A28, X : STA $02
    LDA $1A3C, X : STA $03
    
    LDA $1A64, X
    
    BRA .Tagalong_AnimateMovement

; $04A957 ALTERNATE ENTRY POINT
Tagalong_AnimateMovement_Preserved:
    PHX : PHY

.Tagalong_AnimateMovement

    STA $05 : AND.b #$20 : LSR #2 : TAY
    
    LDA $05 : AND.b #$03 : STA $04
    
    STZ $72
    
    CPY.b #$08 : BNE .low_priority
    LDY.b #$00
    LDA   $7EF3CC
    
    CMP.b #$06 : BEQ .not_blind_maiden
      CMP.b #$01 : BNE .low_priority
    .not_blind_maiden

    LDY.b #$08
    
    LDA $033C : ORA $033D : ORA $033E : ORA $033F : BEQ .no_collision
    
    LDA $1A : AND.b #$08 : LSR A
    
    BRA .TagalongDraw_Drawing

.no_collision

    LDA $1A : AND.b #$10 : LSR #2
    BRA .TagalongDraw_Drawing

.low_priority

    LDA $11
    
    CMP.b #$0E : BEQ .check_dashing
    CMP.b #$08 : BEQ .check_dashing
    CMP.b #$10 : BEQ .check_dashing
    
    LDA $7EF3CC
    
    CMP.b #$0B : BEQ .not_dashing
    CMP.b #$0D : BEQ .super_bomb
    CMP.b #$0C : BNE .not_purple_chest

.super_bomb

    LDA $7EF3D3 : BNE .immobile

.not_purple_chest

    LDA $02E4 : BNE .immobile
    
    LDA $11 : CMP.b #$0A : BEQ .immobile
    
    LDA $10 : CMP.b #$09 : BNE .not_overworld
    
    LDA $11 : CMP.b #$23 : BEQ .immobile

.not_overworld

    LDA $10 : CMP.b #$0E : BNE .not_interface
    
    LDA $11
    
    CMP.b #$01 : BEQ .BRANCH_PI
    CMP.b #$02 : BEQ .BRANCH_PI

.not_interface

    LDA $30 : ORA $31 : BNE .BRANCH_MU

.immobile

    LDA.b #$04 : STA $72
    
    BRA .TagalongDraw_Drawing

.check_dashing

    LDA $0372 : BEQ .not_dashing
    
    LDA $1A : AND.b #$04
    
    BRA .TagalongDraw_Drawing

.not_dashing

    LDA $1A : AND.b #$08 : LSR A

.TagalongDraw_Drawing

    CLC : ADC $04 : STA $04
    
    TYA : CLC : ADC $04 : STA $04
    
    REP #$20
    
    LDA $0FB3 : AND.w #$00FF : ASL A : TAY
    
    LDA $20 : CMP $00 : BEQ .check_priority_for_region
    
    BCS .use_region_b
    
    BRA .use_region_a

.check_priority_for_region

    LDA $05 : AND.w #$0003 : BNE .use_region_b
  .use_region_a
    LDA.w $A8F1, Y
    BRA   .set_region

.use_region_b

    LDA.w $A8F5, Y

.set_region

    PHA
    
    LSR #2 : CLC : ADC.w #$0A20 : STA $92
    
    PLA : CLC : ADC.w #$0800 : STA $90
    
    LDA $00 : SEC : SBC $E8 : STA $06
    
    LDA $02 : SEC : SBC $E2 : STA $08
    
    SEP #$20
    
    LDY.b #$00
    LDX.b #$00
    
    LDA $7EF3CC
    
    CMP.b #$01 : BEQ .girly_follower
    CMP.b #$06 : BEQ .girly_follower
    
    LDA $05 : AND.b #$20 : BEQ .girly_follower
    
    BRA .not_girly_follower

.girly_follower

    LDA $05 : AND.b #$C0 : BNE .some_flip
    
    BRL .do_chars

.some_flip

    LDA $05 : AND.b #$80 : BNE .not_girly_follower
    
    LDX.b #$0C
    
    LDA $72 : BEQ .not_girly_follower
    
    LDA.b #$00
    
    BRA .set_repri

.not_girly_follower

    LDA $1A : AND.b #$07 : BNE .dont_shimmy
    
    LDA $02D7 : INC A : CMP.b #$03 : BNE .set_repri
    
    LDA.b #$00

.set_repri

    STA $02D7

.dont_shimmy

    LDA $02D7 : ASL #2 : STA $05
    
    TXA : CLC : ADC $05 : TAX
    
    REP #$20
    
    LDA $06 : CLC : ADC.w #$0010 : STA $00
    
    LDA $08 : STA $02
    
    STZ $74
    
    SEP #$20
    
    JSR Tagalong_SetOam_XY
    
    LDA.w $A8D9, X : STA ($90), Y : INY
    LDA.w $A8DA, X : STA ($90), Y : INY
    
    PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : ORA $75 : STA ($92), Y
    
    PLY
    
    REP #$20
    
    LDA $02 : CLC : ADC.w #$0008 : STA $02
    
    STZ $74
    
    SEP #$20
    
    JSR Tagalong_SetOam_XY
    
    LDA.w $A8DB, X : STA ($90), Y : INY
    LDA.w $A8DC, X : STA ($90), Y : INY
    
    PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : ORA $75 : STA ($92), Y
    
    PLY

.do_chars

    LDA $7EF3CC : TAX
    
    LDA.w $A8F9, X : CMP.b #$07 : BNE .not_link_palette_a
    
    TAX
    
    LDA $0ABD : BEQ .no_trans_a
    
    LDX.b #$00

.no_trans_a

    TXA

.not_link_palette_a

    ASL A : STA $72
    
    LDA $7EF3CC : CMP.b #$0D : BNE .not_exploding_superbomb
    
    LDA $04B4 : CMP.b #$01 : BNE .not_exploding_superbomb
    
    LDA $1A : AND.b #$07 : ASL A : STA $72

.not_exploding_superbomb

    LDA $7EF3CC
    
    CMP.b #$0D : BEQ .bomb_or_chest
    CMP.b #$0C : BEQ .bomb_or_chest
    
    REP #$30
    
    PHY
    
    LDA $04 : AND.w #$00FF : ASL #3 : TAY
    
    LDA $7EF3CC : AND.w #$00FF : ASL A : TAX
    
    TYA : CLC : ADC $A8BD, X : TAX
    
    LDA.w $A6FD, X : CLC : ADC $06 : STA $00
    LDA.w $A6FF, X : CLC : ADC $08 : STA $02
    
    PLY
    
    SEP #$30
    
    JSR Tagalong_SetOam_XY
    
    LDA.b #$20 : STA ($90), Y
    
    INY
    
    LDA $04 : ASL A : CLC : ADC $04 : TAX
    
    LDA.w $A6CD, X : STA $0AE8
    
    LDA.w $A6CF, X : AND.b #$F0 : ORA $72 : ORA $65 : STA ($90), Y
    
    INY : PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA #$02 : ORA $75 : STA ($92), Y
    
    PLY

.bomb_or_chest

    REP #$30
    
    PHY
    
    LDA $04 : AND.w #$00FF : ASL #3 : TAY
    
    LDA $7EF3CC : AND.w #$00FF : ASL A : TAX
    
    TYA : CLC : ADC $A8BD, X : TAX
    
    LDA.w $A701, X : CLC : ADC $06 : CLC : ADC.w #$0008 : STA $00
    
    LDA.w $A703, X : CLC : ADC $08 : STA $02
    
    PLY
    
    SEP #$30
    
    JSR Tagalong_SetOam_XY
    
    LDA.b #$22 : STA ($90), Y
    
    INY
    
    LDA $04 : ASL A : CLC : ADC $04 : TAX
    
    LDA.w $A6CE, X : STA $0AEA
    
    LDA.w $A6CF, X : AND.b #$0F : ASL #4 : ORA $72 : ORA $65 : STA ($90), Y
    
    INY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : ORA $75 : STA ($92), Y
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $04ABF9-$04AC25 LOCAL JUMP LOCATION
Tagalong_SetOam_XY:
{
    REP #$20
    
    LDA $02 : STA ($90), Y
    
    INY
    
    CLC : ADC.w #$0080 : CMP.w #$0180 : BCS .off_screen_x
    
    LDA $02 : AND.w #$0100 : STA $74
    
    LDA $00 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen
    
    .off_screen_x
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen
    
    SEP #$20
    
    INY
    
    RTS
}

; ==============================================================================

; $04AC26-$04AC6A LOCAL JUMP LOCATION
Tagalong_CheckTextTriggerProximity:
{
    REP #$20
    
    LDA $00 : CLC : ADC $0A : CLC : ADC.w #$0008 : STA $00
    LDA $02 : CLC : ADC.w #$0008 : STA $02
    
    LDA $20 : CLC : ADC.w #$000C : SEC : SBC $00 : BPL .positive_delta_y
      EOR.w #$FFFF : INC A
    .positive_delta_y
    
    CMP.w #$001C : BCS .not_in_trigger
    
      LDA $22 : CLC : ADC.w #$000C : SEC : SBC $02 : BPL .positive_delta_x
        EOR.w #$FFFF : INC A
      .positive_delta_x
      
      CMP.w #$0018 : BCS .not_in_trigger
        SEP #$20
        SEC
        RTS
    
    .not_in_trigger
      SEP #$20
      CLC
      RTS
}

; ==============================================================================
