; ==============================================================================

; NOTE: These are fireball spitting faces. Their graphics are background
; based, so the only visible sprite manifestation they have are the
; fireballs they generate.
; $0EC7EB-$0EC844 JUMP LOCATION
Sprite_Medusa:
{
    JSL.l Sprite_PrepOamCoordLong
    
    LDA.b $1B : BNE .indoors
        ; NOTE: These are apparently triggers for Poes on the overworld. When
        ; a gravestone is pushed into them, they appear as if from inside the
        ; gravestone.
        LDA.b #$FF : STA.w $0D50, X : STA.w $0E30, X
        
        JSR.w Sprite4_CheckTileCollision : BEQ .didnt_collide
            JSR.w Sprite4_CheckIfActive
            
            LDA.b #$19 : STA.w $0E20, X
            
            JSL.l Sprite_LoadProperties
            
            INC.w $0E90, X
            
            LDA.w $0D10, X : ADC.b #$08 : STA.w $0D10, X
            
            LDA.w $0D00, X : SBC.b #$07 : STA.w $0D00, X
            
            LDA.b #$19 : JSL.l Sound_SetSfx3PanLong
            
            LDA.b #$80 : STA.w $0CAA, X
        
        .didnt_collide
        
        RTS
        
    .indoors
    
    JSR.w Sprite4_CheckIfActive
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$7F : BNE Medusa_ConfigFireballProperties_dont_spawn
        LDA.w $0F20, X : CMP $EE : BNE Medusa_ConfigFireballProperties_dont_spawn
            JSL.l Sprite_SpawnFireball : BMI Medusa_ConfigFireballProperties_dont_spawn
                ; Bleeds into the next function.
}

; $0EC845-$0EC852 JUMP LOCATION
Medusa_ConfigFireballProperties:
{ 
    LDA.w $0CAA, Y : ORA.b #$08 : STA.w $0CAA, Y
                
    LDA.b #$04 : STA.w $0CD2, Y
            
    .dont_spawn
    
    RTS
}

; ==============================================================================
