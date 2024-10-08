; ==============================================================================

; EFFECT 0x37. WEATHER VANE EXPLOSION
; $04503D-$045185 JUMP LOCATION
Ancilla_WeathervaneExplosion:
{
    REP #$20
    
    ; An initial timer. starts at 0x0280, counts down to zero.
    LDA.l $7F58B6 : DEC A : STA.l $7F58B6 : BNE .return
        SEP #$20
        
        INC A : STA.l $7F58B6
        
        LDA.l $7F58B8 : BNE .music_at_full_volume
            ; This code is executed once. after that, $7F58B8 is set.
            INC A : STA.l $7F58B8
            
            ; Put the music back to full volume.
            LDA.b #$F3 : STA.w $012C
            
            BRA .music_at_full_volume
        
    .return
    
    SEP #$20
    
    BRA Ancilla_Flute_return
    
    .music_at_full_volume
    
    ; Start ticking down the timer for the explosion to occur.
    ; How much time left on the timer?
    ; Still time left, quit the routine.
    DEC.w $0394, X : LDA.w $0394, X : BNE .return
        ; Otherwise, put one frame back on the timer.
        INC A : STA.w $0394, X
        
        LDA.w $039F, X : BNE .explosion_sfx_already_played
            ; This code should only get executed once?
            INC A : STA.w $039F, X
            
            LDA.b #$0C : JSR.w Ancilla_DoSfx2_NearPlayer
            
        .explosion_sfx_already_played
        
        ; Which step of the effect are we in?
        LDA.w $0C54, X : BNE .past_first_step
                DEC.w $03B1, X : BPL .past_first_step
                ; Switch to the second step of the effect.
                LDA.b #$01 : STA.w $0C54, X
                
                PHX
                
                JSL.l Overworld_AlterWeathervane
                
                ; Trigger the sprite animations, such as the particles and
                ; the bird.
                LDY.b #$00
                LDA.b #$38
                
                JSL.l AddTravelBirdIntro
                
                PLX
            
        .past_first_step
        
        TXA : STA.l $7F5878
        
        LDA.b #$00 : STA.l $7F5879
        
        LDX.b #$0B
        
        .next_chunk
        
        LDA.l $7F586C, X : CMP.b #$FF : BNE .active_chunk
            BRL .finished_this_chunk
        
        .active_chunk
        
        LDA.l $7F5860, X : DEC A : STA.l $7F5860, X : BPL .chr_toggle_delay
            LDA.b #$01 : STA.l $7F5860, X
            
            ; Alternate their appearance.
            LDA.l $7F586C, X : EOR.b #$01 : STA.l $7F586C, X
            
        .chr_toggle_delay
        
        PHX
        
        LDA.l $7F5878 : TAY
        
        LDA.l $7F586C, X : STA.w $0C5E, Y
        LDA.l $7F5824, X : STA.w $0BFA, Y
        LDA.l $7F5830, X : STA.w $0C0E, Y
        LDA.l $7F583C, X : STA.w $0C04, Y
        LDA.l $7F5848, X : STA.w $0C18, Y
        LDA.l $7F5854, X : STA.w $029E, Y
        LDA.l $7F5800, X : STA.w $0C22, Y
        LDA.l $7F580C, X : STA.w $0C2C, Y
        
        LDA.l $7F5818, X : SEC : SBC.b #$01 : STA.l $7F5818, X : STA.w $0294, Y
        
        TYX
        
        JSR.w Ancilla_MoveVert
        JSR.w Ancilla_MoveHoriz
        JSR.w Ancilla_MoveAltitude
        
        STZ.b $74
        
        LDA.w $029E, X : CMP.b #$F0 : BCC .not_below_ground_enough
            LDA.b #$FF : STA.b $74
        
        .not_below_ground_enough
        
        JSR.w WeathervaneExplosion_DrawWoodChunk
        
        PLX
        
        LDA.b $74 : BPL .dont_deactivate_yet
            STA.l $7F586C, X
        
        .dont_deactivate_yet
        
        LDA.l $7F5878 : TAY
        
        LDA.w $0BFA, Y : STA.l $7F5824, X
        LDA.w $0C0E, Y : STA.l $7F5830, X
        LDA.w $0C04, Y : STA.l $7F583C, X
        LDA.w $0C18, Y : STA.l $7F5848, X
        LDA.w $029E, Y : STA.l $7F5854, X
        
        .finished_this_chunk
        
        ; Examine the next weather vane piece.
        DEX : BMI .executed_all_chunks
            BRL .next_chunk
        
        .executed_all_chunks
        
        LDA.l $7F5878 : TAY
        
        LDX.b #$0B
        
        .find_active_wood_chunk
        
            LDA.l $7F586C, X : CMP.b #$FF : BNE .at_least_one_active_chunk
        DEX : BPL .find_active_wood_chunk
        
        TYX
        
        ; Self terminate, naturally, if there are no chunks left.
        STZ.w $0C4A, X
        
        .at_least_one_active_chunk
        
        TYX
        
        RTS
}

; ==============================================================================

; $045186-$045187 DATA
WeathervaneExplosion_DrawWoodChunk_chr:
{
    db $4E, $4F
}

; $045188-$0451D3 LOCAL JUMP LOCATION
WeathervaneExplosion_DrawWoodChunk:
{
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ORA.w #$FF00
    
    .sign_ext_z_coord
    
    EOR.w #$FFFF : INC A : CLC : ADC.b $00 : STA.b $00
    
    SEP #$20
    
    LDA.w $0C5E, X : STA.b $72 : BMI .inactive_component
        PHX
        
        LDA.l $7F5879 : TAY
        
        JSR.w Ancilla_SetOam_XY
        
        LDX.b $72
        
        LDA.w .chr, X  : STA ($90), Y : INY
        LDA.b #$3C     : STA ($90), Y : INY
        
        TYA : STA.l $7F5879
        
        SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLX
        
    .inactive_component
    
    RTS
}

; ==============================================================================
