; ==============================================================================

; $0F603C-$0F6043 DATA
pool_HylianPlaque:
{
    ; $0F603C
    .sword_messages_low
    db $B6, $B7
    
    ; $0F603E
    .sword_messages_high
    db $00, $00
    
    ; $0F6040
    .desert_messages_low
    db $BC, $BD
    
    ; $0F6042
    .desert_messages_high
    db $00, $00        
}

; ==============================================================================

; $0F6044-$0F609E JUMP LOCATION
Sprite_HylianPlaque:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $02E4 : BNE .player_paused
        JSL.l Sprite_CheckIfPlayerPreoccupied : BCC .player_available
        
    .player_paused
    
    RTS
    
    .player_available
    
    ; Get rid of whatever pose the player was in...
    LDA.w $037A : AND.b #$DF : STA.w $037A
    
    LDA.b $8A : CMP.b #$30 : BEQ HylianPlaque_Desert
        LDA.b $2F : BNE .not_facing_up
            JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_show_message
                LDA.w $0202 : CMP.b #$0F : BNE .book_of_mudora_not_equipped
                    LDY.b #$01
                    
                    BIT.b $F4 : BVS .y_button_pressed
                    
                .book_of_mudora_not_equipped
                
                LDA.b $F6 : BPL .dont_show_message
                    LDY.b #$00
                    
                    .y_button_pressed
                    
                    CPY.b #$01 : BNE .no_pose_needed
                        STZ.w $0300
                        
                        LDA.b #$20 : STA.w $037A
                        
                        STZ.w $012E
                    
                    .no_pose_needed
                    
                    LDA HylianPlaque_sword_messages_low, Y        : XBA
                    LDA HylianPlaque_sword_messages_high, Y : TAY : XBA
                    JSL.l Sprite_ShowMessageUnconditional
                
            .dont_show_message
        .not_facing_up
        
        RTS
}
    
; ==============================================================================

; $0F609F-$0F60DC JUMP LOCATION
HylianPlaque_Desert:
{
    LDA.b $2F : BNE .not_facing_up
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_show_message
            LDA.w $0202 : CMP.b #$0F : BNE .book_of_mudora_not_equipped
                LDY.b #$01
                
                BIT.b $F4 : BVS .y_button_pressed

            .book_of_mudora_not_equipped

            LDA.b $F6 : BPL .dont_show_message
                LDY.b #$00
                
                .y_button_pressed
                
                CPY.b #$01 : BNE .no_pose_needed
                    STZ.w $0300
                    
                    LDA.b #$20 : STA.w $037A
                    
                    STZ.w $012E
                    
                    ; Call the routine that causes us to enter the desert
                    ; palace opening submode of the player...
                    JSL.l InitiateDesertCutscene
                
                .no_pose_needed
                
                LDA HylianPlaque_desert_messages_low, Y        : XBA
                LDA HylianPlaque_desert_messages_high, Y : TAY : XBA
                JSL.l Sprite_ShowMessageUnconditional
        
        .dont_show_message
    .not_facing_up
    
    RTS
}

; ==============================================================================
