
; ==============================================================================

; $0338CE-$0338CF DATA
Pool_Sprite_CrystalSwitch:
{
    .palettes
    db $02, $04
}

; ==============================================================================

; $0338D0-$03394B JUMP LOCATION
Sprite_CrystalSwitch:
{
    ; And the palette value with 0xF1
    LDA.w $0F50, X : AND.b #$F1 : STA.w $0F50, X
    
    ; Blue / Orange barrier state
    LDA.l $7EC172 : AND.b #$01 : TAY
    
    ; Select the palette for the peg switch based on that state.
    LDA.w .palettes, Y : ORA.w $0F50, X : STA.w $0F50, X
    
    JSR.w OAM_AllocateDeferToPlayer
    JSR.w Sprite_PrepAndDrawSingleLarge
    JSR.w Sprite_CheckIfActive
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .no_player_collision
    
    JSL.l Sprite_NullifyHookshotDrag
    
    STZ.b $5E
    
    JSL.l Sprite_RepelDashAttackLong
    
    .no_player_collision
    
    LDA.w $0DF0, X : BNE .skipSparkleGeneration
    
    LDA.b $1A : AND.b #$07 : STA.b $00
                           STZ.b $01
    
    JSL.l GetRandomInt : AND.b #$07 : STA.b $02
                                    STZ.b $03
    
    ; Attempt to add a sparkle effect
    JSL.l Sprite_SpawnSimpleSparkleGarnish
    
    ; Restart sparkle countdown timer.
    LDA.b #$1F : STA.w $0DF0, X
    
    .skipSparkleGeneration
    
    LDA.w $0EA0, X : BNE .switching_already_scheduled
    
    LDA.b $3C : DEC A : CMP.b #$08 : BPL .ignore_player_poke_attack
    
    JSR.w Sprite_CheckDamageFromPlayer
    
    .ignore_player_poke_attack
    
    RTS
    
    .switching_already_scheduled
    
    DEC.w $0EA0, X : CMP.b #$0B : BNE .dont_switch_state
    
    ; Change the orange/blue barrier state
    LDA.l $7EC172 : EOR.b #$01 : STA.l $7EC172
    
    LDA.b #$16 : STA.b $11
    
    LDA.b #$25 : JSL.l Sound_SetSfx3PanLong
    
    .dont_switch_state
    
    RTS
}

; ==============================================================================

