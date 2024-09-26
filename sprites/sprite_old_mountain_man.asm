; ==============================================================================

; $0F68F1-$0F68F8 LONG JUMP LOCATION
SpritePrep_OldMountainManLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_OldMountainMan
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F68F9-$0F6937 LOCAL JUMP LOCATION
SpritePrep_OldMountainMan:
{
    INC.w $0BA0, X
    
    LDA.b $A0 : CMP.b #$E4 : BNE .not_at_home
        LDA.b #$02 : STA.w $0E80, X
        
        RTS
        
    .not_at_home
    
    LDA.l $7EF3CC : CMP.b #$00 : BNE .already_have_tagalong
        LDA.l $7EF353 : CMP.b #$02 : BNE .dont_have_magic_mirror
            STZ.w $0DD0, X
            
        .dont_have_magic_mirror
        
        ; Temporarily set Link's tagalong status to that of the Old Man for
        ; the purpose of loading the tagalong graphics.
        LDA.b #$04 : STA.l $7EF3CC
        
        PHX
        
        JSL.l Tagalong_LoadGfx
        
        PLX
        
        LDA.b #$00 : STA.l $7EF3CC
        
        RTS
    
    .already_have_tagalong
    
    STZ.w $0DD0, X
    
    PHX
    
    JSL.l Tagalong_LoadGfx
    
    PLX
    
    RTS
}

; ==============================================================================

; $0F6938-$0F6988 LONG JUMP LOCATION
OldMountainMan_TransitionFromTagalong:
{
    PHA
    
    LDA.b #$AD : JSL.l Sprite_SpawnDynamically
    
    PLA : PHX : TAX
    
    LDA.w $1A64, X : AND.b #$03 : STA.w $0EB0, Y
                                  STA.w $0DE0, Y
    
    LDA.w $1A00, X : CLC : ADC.b #$02 : STA.w $0D00, Y
    LDA.w $1A14, X       : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.w $1A28, X : CLC : ADC.b #$02 : STA.w $0D10, Y
    LDA.w $1A3C, X       : ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $EE : STA.w $0F20, Y
    
    LDA.b #$01 : STA.w $0BA0, Y
                 STA.w $0E80, Y
    
    JSR.w OldMountainMan_FreezePlayer
    
    PLX
    
    LDA.b #$00 : STA.l $7EF3CC
    
    STZ.b $5E
    
    RTL
}

; ==============================================================================

; $0F6989-$0F6991 LOCAL JUMP LOCATION
OldMountainMan_FreezePlayer:
{
    LDA.b #$01 : STA.w $02E4
                 STA.w $037B
    
    RTS
}

; ==============================================================================

; $0F6992-$0F69A5 JUMP LOCATION
Sprite_OldMountainMan:
{
    JSL.l OldMountainMan_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw OldMountainMan_Lost             ; 0x00 - $E9A6
    dw OldMountainMan_EnteringDomicile ; 0x01 - $E9EA
    dw OldMountainMan_SittingAtHome    ; 0x02 - $EAB3
}

; ==============================================================================

; $0F69A6-$0F69B0 JUMP LOCATION
OldMountainMan_Lost:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw OldMountainMan_Supplicate       ; 0x00 - $E9B1
    dw OldMountainMan_SwitchToTagalong ; 0x01 - $E9D2
}

; ==============================================================================

; $0F69B1-$0F69D1 JUMP LOCATION
OldMountainMan_Supplicate:
{
    JSL.l Sprite_MakeBodyTrackHeadDirection
    JSR.w Sprite3_DirectionToFacePlayer
    
    TYA : EOR.b #$03 : STA.w $0EB0, X
    
    ; "I lost my lamp, blah blah blah"
    LDA.b #$9C
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
        STA.w $0DE0, X
        STA.w $0EB0, X
        
        INC.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $0F69D2-$0F69E9 JUMP LOCATION
OldMountainMan_SwitchToTagalong:
{
    ; Set up the old man on the mountain as the tagalong.
    LDA.b #$04 : STA.l $7EF3CC
    
    JSL.l Tagalong_SpawnFromSprite
    
    LDA.b #$05 : STA.l $7EF3C8
    
    STZ.w $0DD0, X
    
    ; caches some dungeon values. Not sure if this is really necessary,
    ; but it might be ancitipating that you suck at this game and will
    ; die while the old man is with you?
    JSL.l CacheRoomEntryProperties_long
    
    RTS
}

; ==============================================================================

; $0F69EA-$0F69FB JUMP LOCATION
OldMountainMan_EnteringDomicile:
{
    JSR.w Sprite3_Move
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw OldMountainMan_GrantMagicMirror ; 0x00 - $E9FC
    dw OldMountainMan_ShuffleAway      ; 0x01 - $EA28
    dw OldMountainMan_ApproachDoor     ; 0x02 - $EA3F
    dw OldMountainMan_MadeItInside     ; 0x03 - $EAA3
}

; ==============================================================================

; $0F69FC-$0F6A27 JUMP LOCATION
OldMountainMan_GrantMagicMirror:
{
    INC.w $0D80, X
    
    ; Grant the magic mirror...
    LDY.b #$1A
    
    STZ.w $02E9
    
    JSL.l Link_ReceiveItem
    
    LDA.b #$01 : STA.l $7EF3C8
    
    JSR.w OldMountainMan_FreezePlayer
    
    LDA.b #$30 : STA.w $0DF0, X
    
    LDA.b #$08 : STA.w $0D50, X
    
    LSR A : STA.w $0D40, X
    
    LDA.b #$03 : STA.w $0EB0, X : STA.w $0DE0, X
    
    RTS
}

; ==============================================================================

; $0F6A28-$0F6A3E JUMP LOCATION
OldMountainMan_ShuffleAway:
{
    JSR.w OldMountainMan_FreezePlayer
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
    
    .delay
    
    TXA : EOR.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F6A3F-$0F6AA2 JUMP LOCATION
OldMountainMan_ApproachDoor:
{
    STZ.w $0EB0, X
    STZ.w $0DE0, X
    
    LDY.w $0FDE
    
    LDA.w $0B18, Y : STA.b $00
    LDA.w $0B20, Y : STA.b $01
    
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : CMP $02 : SEP #$30 : BCC .not_north_enough_yet
        INC.w $0D80, X
        
        STZ.w $0D50, X
        STZ.w $0D40, X
        
        RTS
        
    .not_north_enough_yet
    
    LDA.w $0B08, Y : STA.b $04
    LDA.w $0B10, Y : STA.b $05
    
    LDA.w $0B18, Y : STA.b $06
    LDA.w $0B20, Y : STA.b $07
    
    LDA.b #$08 : JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    TXA : EOR.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    JSR.w OldMountainMan_FreezePlayer
    
    RTS
}

; ==============================================================================

; $0F6AA3-$0F6AAC JUMP LOCATION
OldMountainMan_MadeItInside:
{
    STZ.w $0DD0, X
    
    STZ.w $02E4
    STZ.w $037B
    
    RTS
}

; ==============================================================================

; $0F6AAD-$0F6AB2 DATA
Pool_OldMountainMan_SittingAtHome:
{
    ; $0F6AAD
    .messages_low
    db $9E, $9F, $A0
    
    ; $0F6AB0
    .messages_high
    db $00, $00, $00
}

; $0F6AB3-$0F6AE6 JUMP LOCATION
OldMountainMan_SittingAtHome:
{
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X : BEQ .dont_activate_health_refill
        LDA.b #$A0 : STA.l $7EF372
        
        STZ.w $0D80, X
    
    .dont_activate_health_refill
    
    LDY.b #$02
    
    LDA.l $7EF3C5 : CMP.b #$03 : BCS .player_beat_agahnim
        LDA.l $7EF357 : TAY
    
    .player_beat_agahnim
    
    LDA.w Pool_OldMountainMan_SittingAtHome_messages_low, Y        : XBA
    LDA.w Pool_OldMountainMan_SittingAtHome_messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        INC.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================
