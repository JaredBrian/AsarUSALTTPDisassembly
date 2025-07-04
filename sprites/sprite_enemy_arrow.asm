; ==============================================================================

; $03374A-$033753 DATA
Pool_Sprite_EnemyArrow:
{
    .x_speeds ; Length 8, bleeds into the next block.
    db 0, 0
    
    .y_speeds
    db 16, 16, 0, 0, -16, -16, 0, 0
}

; $033754-$0337C2 JUMP LOCATION
Sprite_EnemyArrow:
{
    JSR.w EnemyArrow_Draw
    JSR.w Sprite_CheckIfActive_permissive
    
    LDA.w $0DD0, X : CMP.b #$09 : BNE SpriteArrow_KnockedAway
        LDA.w $0DF0, X : BEQ .BRANCH_ALPHA
            DEC : BNE .BRANCH_BETA
                STZ.w $0DD0, X
                
                RTS
                
            .BRANCH_BETA
            
            CMP.b #$20 : BCC .BRANCH_GAMMA
            AND.b #$01 : BNE .BRANCH_GAMMA
                LDA.b $1A : ASL : AND.b #$04 : ORA.w $0DE0, X : TAY
                
                LDA Pool_Sprite_EnemyArrow_x_speeds, Y : STA.w $0D50, X
                
                LDA Pool_Sprite_EnemyArrow_y_speeds, Y : STA.w $0D40, X
                
                JSR.w Sprite_Move
                
            .BRANCH_GAMMA
            
            RTS
        
        .BRANCH_ALPHA
        
        JSR.w Sprite_CheckDamageToPlayer_same_layer
        
        LDA.w $0E90, X : BNE .BRANCH_DELTA
            JSR.w Sprite_CheckTileCollision
            
            LDA.w $0E70, X : BEQ .BRANCH_DELTA
                LDY.w $0D90, X : BEQ .BRANCH_EPSILON
                    JSL.l Sprite_ApplyCalculatedDamage_SpriteArrow_Break
                    
                    RTS
                    
                .BRANCH_EPSILON
                
                LDA.b #$30 : STA.w $0DF0, X
                
                LDA.b #$02 : STA.w $0D90, X
                
                LDA.b #$08 : JSL.l Sound_SetSfx2PanLong
                
                RTS
                
                .UNREACHABLE_06B7B9
                
                STZ.w $0DD0, X
                
                JSL.l Sprite_PlaceRupulseSpark
        
        .BRANCH_DELTA
        
        JMP Sprite_Move
}

; ==============================================================================

; $0337C3-$0337C6 DATA
SpriteArrow_KnockedAway_directions:
{
    db 0, 2, 1, 3
}

; $0337C7-$033805 BRANCH LOCATION
SpriteArrow_KnockedAway:
{
    LDA.w $0D80, X : BNE .prepped_for_fall_already
        JSR.w Sprite_ApplyRicochet
        
        LDA.b #$18 : STA.w $0F80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        STZ.w $0EF0, X
    
    .prepped_for_fall_already
    
    LDA.w $0DF0, X : LSR #3 : AND.b #$03 : TAY
    
    LDA.w .directions, Y : STA.w $0DE0, X
    
    JSR.w Sprite_MoveAltitude
    JSR.w Sprite_Move
    
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .hasnt_hit_ground
        STZ.w $0DD0, X
    
    .hasnt_hit_ground
    
    RTS
}

; ==============================================================================

; $033807-$033866 DATA
Pool_SpriteDraw_Arrow:
{
    ; TODO: Fill in data.
    ; $033807
    .x_offsets
    dw $FFF8, $0000, $0000, $0008, $0000, $0000, $0000, $0000
    
    ; $033817
    .y_offsets
    dw $0000, $0000, $0000, $0000, $FFF8, $0000, $0000, $0008

    ; $033837
    .chr
    db $3A, $3D
    db $3D, $3A
    db $2A, $2B
    db $2B, $2A

    db $7C, $6C
    db $6C, $7C
    db $7B, $6B
    db $6B, $7B

    db $3A, $3B
    db $3B, $3A
    db $2A, $3C
    db $3C, $2A

    db $81, $80
    db $80, $81
    db $91, $90
    db $90, $91
    
    ; $033847
    .properties
    db $08, $08
    db $48, $48
    db $08, $08
    db $88, $88

    db $09, $49
    db $09, $49
    db $09, $89
    db $09, $89

    db $08, $88
    db $C8, $48
    db $08, $08
    db $88, $88
    
    db $49, $49
    db $09, $09
    db $89, $89
    db $09, $09
}

; $033867-$0338CD LOCAL JUMP LOCATION
EnemyArrow_Draw:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0DE0, X : ASL : STA.b $06
    
    LDA.w $0D90, X : ASL #3 : STA.b $07
    
    PHX
    
    LDX.b #$01
    
    .next
    
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_SpriteDraw_Arrow_x_offsets, X
        STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC Pool_SpriteDraw_Arrow_y_offsets, X
        INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .inRangeY
            LDA.b #$F0 : STA ($90), Y
        
        .inRangeY
        
        PLA : CLC : ADC.b $07 : TAX
        
        LDA Pool_SpriteDraw_Arrow_chr, X                    : INY : STA ($90), Y
        LDA Pool_SpriteDraw_Arrow_properties, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next
    
    PLX
    
    RTS
}

; ==============================================================================
