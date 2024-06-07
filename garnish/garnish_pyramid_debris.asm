
; ==============================================================================

; $04B1BD-$04B20E LONG JUMP LOCATION
Garnish_SpawnPyramidDebris:
{
    LDA.b #$03 : STA.w $012F
    LDA.b #$1F : STA.w $012E
    
    LDA.b #$05 : STA.w $012D ; play a sound effect
    
    PHX
    
    TXY
    
    LDX.b #$1D
    
    .next_slot
    
    LDA.l $7FF800, X : BEQ .empty_slot
    
    DEX : BPL .next_slot
    
    INX
    
    .empty_slot
    
    LDA.b #$13 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.b #$E8 : CLC : ADC $00 : STA.l $7FF83C, X
    LDA.b #$60 : CLC : ADC $01 : STA.l $7FF81E, X
    
    LDA $02 : STA.l $7FF8B4, X
    LDA $03 : STA.l $7FF896, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$30 : STA.l $7FF90E, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $04B20F-$04B215 BRANCH LOCATION
Pool_Garnish_PyramidDebris:
{
    .self_terminate
    
    LDA.b #$00 : STA.l $7FF800, X
    
    RTS
}

; ==============================================================================

; $04B216-$04B251 JUMP LOCATION
Garnish_PyramidDebris:
{
    ; special animation 0x13
    
    JSR Garnish_Move_XY
    
    LDA.l $7FF896, X : CLC : ADC.b #$03 : STA.l $7FF896, X
    
    LDY.b #$00
    
    ; Check if off screen (X)
    LDA.l $7FF83C, X : SEC : SBC $E2 : CMP.b #$F8 : BCS .self_terminate
    
    STA ($90), Y
    
    ; Check if off screen (Y)
    LDA.l $7FF81E, X : SEC : SBC $E8 : CMP.b #$F0 : BCS .self_terminate
    
                 INY : STA ($90), Y
    LDA.b #$5C : INY : STA ($90), Y
    
    LDA $1A : ASL #3 : AND.b #$C0 : ORA.b #$34
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
