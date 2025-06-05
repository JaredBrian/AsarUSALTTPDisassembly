; ==============================================================================

; $0406D2-$040758 JUMP LOCATION
Ancilla_FireShot:
{
    LDA.w $0C54, X : BEQ .traveling_shot
        JMP Ancilla_ConsumingFire
    
    .traveling_shot
    
    LDA $11 : BNE .just_draw
        STZ.w $0385, X
        
        JSR.w Ancilla_MoveHoriz
        JSR.w Ancilla_MoveVert
        
        JSR.w Ancilla_CheckSpriteCollision : BCS .collided
            LDA.w $0C72, X : ORA.b #$08 : STA.w $0C72, X
            
            JSR.w Ancilla_CheckTileCollision
            
            PHP
            
            LDA.w $03E4, X : STA.w $0385, X
            
            PLP : BCS .collided
                LDA.w $0C72, X : ORA.b #$0C : STA.w $0C72, X
                
                LDA.w $028A, X : STA $74
                
                JSR.w Ancilla_CheckTileCollision
                
                PHP
                
                LDA $74 : STA.w $028A, X
                
                PLP : BCC .no_collision
        
        .collided
        
        INC.w $0C54, X
        
        LDA.b #$1F : STA.w $0C68, X
        
        LDA.b #$08 : STA.w $0C90, X
        
        LDA.b #$2A : JSR.w Ancilla_DoSfx2
        
        .no_collision
        
        INC.w $0C5E, X
        
        LDA.w $0C72, X : AND.b #$F3 : STA.w $0C72, X
        
        LDA.w $0385, X : STA.w $0333
        
        AND.b #$F0 : CMP.b #$C0 : BEQ .try_to_light_torch
            LDA.w $03E4, X : STA.w $0333
            
            AND.b #$F0 : CMP.b #$C0 : BNE .ignore_torch
            
        .try_to_light_torch
        
        PHX
        
        JSL.l Dungeon_LightTorch
        
        PLX
        
        .ignore_torch
    .just_draw
    
    JSR.w FireShot_Draw
    
    RTS
}

; ==============================================================================

; $040759-$04077B DATA
Pool_FireShot_Draw:
{
    ; $040759
    .x_offsets
    db 7, 0, 8, 0, 8, 4, 0, 0
    db 2, 8, 0, 0, 1, 4, 9, 0
    
    ; $040769
    .y_offsets
    db 1, 4, 9, 0, 7, 0, 8, 0
    db 8, 4, 0, 0, 2, 8, 0, 0
    
    ; $040779
    .chr
    db $8D, $9D, $9C
}

; $04077C-$0407C9 LOCAL JUMP LOCATION
FireShot_Draw:
{
    JSR.w Ancilla_BoundsCheck
    
    LDA.w $0280, X : BEQ .default_priority
        LDA.b #$30 : TSB $04
        
    .default_priority
    
    LDA.w $0C5E, X : AND.b #$0C : STA $02
    
    PHX
    
    LDX.b #$02
    LDY.b #$00
    
    .next_OAM_entry
    
        STX $03
        
        TXA : ORA $02 : TAX
        
        LDA $00 : CLC : ADC Pool_FireShot_Draw_x_offsets, X       : STA ($90), Y
        LDA $01 : CLC : ADC Pool_FireShot_Draw_y_offsets, X : INY : STA ($90), Y
        
        LDX $03
        
        LDA.w Pool_FireShot_Draw_chr, X : INY : STA ($90), Y

        LDA $04 : ORA.b #$02 : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; UNUSED:
; $0407CA-$0407CA LOCAL JUMP LOCATION
UNUSED_0887CA:
{
    RTS
}

; ==============================================================================

; $0407CB-$0407E8 BRANCH LOCATION
Ancilla_ConsumingFire_self_terminate:
{
    ; Check if it was a torch flame (not fire rod).
    LDA.w $0C4A, X : STZ.w $0C4A, X : CMP.b #$2F : BEQ .dont_burn_skull
        ; Check if it's Skull Woods area (0x40).
        LDA $8A : CMP.b #$40 : BNE .dont_burn_skull
            ; Check if it's the right tile type (0x43).
            LDA.w $03E4, X : CMP.b #$43 : BNE .dont_burn_skull
                PHX
                
                ; Initiate the sequence for burning open the final portion of the
                ; Skull Woods dungeon.
                JSL.l ConsumingFire_TransmuteToSkullWoodsFire
                
                PLX
    
    .dont_burn_skull
    
    RTS
}
    
; $0407E9-$0407EB DATA
Ancilla_ConsumingFire_chr:
{
    db $A2, $A0, $8E
}

; $0407EC-$040851 LOCAL JUMP LOCATION
Ancilla_ConsumingFire:
{
    JSR.w Ancilla_CheckBasicSpriteCollision
    JSR.w Ancilla_BoundsCheck
    
    LDY.b #$00
    
    LDA.w $0C68, X : BEQ .self_terminate
        LSR #3 : BEQ .flaming_out
            TAX
            
            LDA $00                    : STA ($90), Y
            LDA $01              : INY : STA ($90), Y
            LDA.w .chr-1, X      : INY : STA ($90), Y
            LDA.b #$02 : ORA $04 : INY : STA ($90), Y
            
            LDA.b #$02 : STA ($92)
            
            ; Exit and reload the special object's index from $0FA0.
            BRL Ancilla_RestoreIndex
        
        .flaming_out
        
        TYA : STA ($92), Y
        INY : STA ($92), Y
        DEY
        
        LDA $00                                 : STA ($90), Y
        CLC : ADC.b #$08           : LDY.b #$04 : STA ($90), Y
        LDA $01 : CLC : ADC.b #$FD : LDY.b #$01 : STA ($90), Y
                                     LDY.b #$05 : STA ($90), Y
        LDA.b #$A4                 : LDY.b #$02 : STA ($90), Y
        INC                      : LDY.b #$06 : STA ($90), Y
        LDA.b #$02 : ORA $04       : LDY.b #$03 : STA ($90), Y
                                     LDY.b #$07 : STA ($90), Y
        
        ; Bleeds into the next function.
}

; $040852-$040852 LOCAL JUMP LOCATION
Ancilla_Unused_03:
{ 
    RTS
}

; ==============================================================================
