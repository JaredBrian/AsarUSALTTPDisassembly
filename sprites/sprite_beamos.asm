; ==============================================================================

; Code for handling a statue sentry (beamos).
; $028F54-$028FC1 LOCAL JUMP LOCATION
Sprite_Beamos:
{
    ; Usually/always zero? Can't tell.
    LDA.w $0DB0, X : BEQ .is_beamos_station
        CMP.b #$01 : BNE .is_collided_laser_sprite
            JMP Sprite_BeamosLaser
        
        .is_collided_laser_sprite
        
        JMP Sprite_BeamosLaserHit
    
    .is_beamos_station
    
    JSR.w Beamos_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckTileCollision
    JSL.l Sprite_CheckDamageToPlayerLong
    
    ; Is the eyeball revolving?
    ; (I.e. the sentry is in the ground state.)
    LDA.w $0D80, X : BEQ .search_state
        ; Is the statue sentry in fire mode?
        CMP.b #$03 : BNE .delta ; Nope, either in mode 1,2, or 4.
            ; Load the inactivity timer, has it expired?
            ; (We're in firing mode btw).
            LDA.w $0DF0, X : BNE .epsilon ; No, the timer is still going.
                INC.w $0D80, X ; Go to mode 4.
                
                ; Wait #$50 frames or so to start up again.
                LDA.b #$50 : STA.w $0DF0, X
                
                JSL.l Sprite_LoadPalette
                
                RTS
            
            .epsilon ; Timer is still going, and we're in firing mode.
            
            CMP.b #$0F : BNE .dont_fire_beam
                PHA
                
                ; Fire za laser!
                JSR.w Beamos_FireBeam
                
                PLA
            
            .dont_fire_beam
            
            ; Change the palette to the next in the cycle.
            LSR : AND.b #$0E : EOR.w $0F50, X : STA.w $0F50, X
            
            RTS
            
        ; Waiting for the timer to reset after a shot was fired.
        .delta
        
        ; Has the timer for the blaster counted down yet?
        LDA.w $0DF0, X : BNE .theta ; No the timer is still going.
            ; If so, put the Statue Sentry back in ground state so it can start
            ; moving again. (moving its eyeball anyways).
            STZ.w $0D80, X
        
        .theta
        
        RTS
    
    .search_state
    
    ; The ground state where the Sentry is still searching for you.
    
    ; X denotes which enemy in the list it is. Generally 0x0 - 0xF
    ; This code helps us decide whether or not to make the eyeball rotate this
    ; frame.
    TXA : EOR.b $1A : AND.b #$03 : BNE .no_rotation_this_frame
        ; What angular state are we rotated to (0x00 - 0x3F)?
        LDA.w $0DE0, X : STA.b $0F
        
        JSR.w Sprite_SpawnProbeAlways
        
        INC.w $0DE0, X ; Increment the Statue sentry's rotation.
    
    .no_rotation_this_frame
    
    ; If the rotation exceeds step 0x3F, set it back to zero.
    LDA.w $0DE0, X : AND.b #$3F : STA.w $0DE0, X
    
    ; $028FC1 ALTERNATE ENTRY POINT
    .easy_out
    
    RTS
}

; ==============================================================================

; $028FC2-$029061 LOCAL JUMP LOCATION
Beamos_FireBeam:
{
    LDA.w $0B6A : CMP.b #$04 : BCS Sprite_Beamos_easy_out
        LDA.b #$61 : JSL.l Sprite_SpawnDynamically : BMI Sprite_Beamos_easy_out
            LDA.b #$19 : JSL.l Sound_SetSfx3PanLong
            
            PHX
            
            LDX.b #$00
            
            LDA.w $0FA8 : BPL .positive_x
                DEX
            
            .positive_x
            
                CLC : ADC.b $00 : STA.w $0D10, Y
            TXA : ADC.b $01 : STA.w $0D30, Y
            
            LDX.b #$00
            
            LDA.w $0FA9 : BPL .positive_y
                DEX
            
            .positive_y
            
                CLC : ADC.b $02 : STA.w $0D00, Y
            TXA : ADC.b $03 : STA.w $0D20, Y
            
            TYX
            
            LDA.b #$20
            
            JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
            LDA.b #$3F : STA.w $0E40, Y
            LDA.b #$54 : STA.w $0F60, Y
            LDA.b #$01 : STA.w $0DB0, Y
            LDA.b #$48 : STA.w $0CAA, Y
            
            ; The palette for the laser beam.
            LDA.b #$03 : STA.w $0F50, Y
            LDA.b #$04 : STA.w $0CD2, Y
            LDA.b #$0C : STA.w $0E00, Y
            
            LDA.w $0B6A : STA.w $0DC0, Y
            
            INC.w $0B6A
            
            LDA.b #$1F : STA.b $00
            LDX.w $0DC0, Y : CLC : ADC Sprite_BeamosLaser_slots, X : TAX
            
            .init_subsprite_positions
            
                LDA.w $0D10, Y : STA.l $7FFD80, X
                LDA.w $0D30, Y : STA.l $7FFE00, X
                
                LDA.w $0D00, Y : STA.l $7FFE80, X
                LDA.w $0D20, Y : STA.l $7FFF00, X
                
                DEX
            DEC.b $00 : BPL .init_subsprite_positions
            
            PLX
            
            RTS
}

; ==============================================================================

; $029062-$029067 DATA
Pool_Beamos_Draw:
{
    ; $029062
    .y_offsets
    dw -16,  0
    
    ; $029064
    .chr
    db $48, $68
}

; $029068-$0290D0 LOCAL JUMP LOCATION
Beamos_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$00
    
    ; The step for the Statue Sentry's eyeball (rotation state thereof)
    ; Is it at the far right? (rotation ranges from 0x00 to 0x3F)
    ; Nope, it's farther around (counter clockwise).
    LDA.w $0DE0, X : CMP.b #$20 : BCS .in_upper_quadrants
        ; In this case the eyeball appears on top of the statue.
        LDA.b #$0C : JSL.l OAM_AllocateFromRegionB
        
        LDY.b #$04 : BRA .OAM_has_been_allocated
    
    ; Since the eyeball is further around, you have to flip the sprite display
    ; priorities.
    .in_upper_quadrants 
    
    LDA.b #$0C : JSL.l OAM_AllocateFromRegionC
    
    LDY.b #$00
    
    .OAM_has_been_allocated
    
    PHX
    
    ; Here x is the loop counter. Gonna draw the basic green portion of
    ; the Beamos.
    LDX.b #$01
    
    .next_subsprite
    
        ; Save the loop counter.
        PHX : TXA : ASL : TAX
        
        REP #$20
        
        ; (X = 0 OR 2), hence A = -16 OR 0.
        LDA.b $00 : STA ($90), Y
        AND.w #$0100 : STA.b $0E

        LDA.b $02 : CLC : ADC Pool_Beamos_Draw_y_offsets, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA Pool_Beamos_Draw_chr, X : INY : STA ($90), Y
        LDA.b $05                   : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    JSR.w Beamos_DrawEyeball
    
    RTS
}

; ==============================================================================

; $0290D1-$029150 DATA
Pool_Beamos_DrawEyeBall:
{
    ; $0290D1
    .x_offsets
    db -1,  0,  1,  2,  3,  4,  5,  7
    db  8, 10, 11, 12, 13, 14, 15, 16
    db 17, 15, 14, 13, 12, 11, 10,  8
    db  7,  5,  4,  3,  2,  1,  0, -2
    
    ; $0290F1
    .y_offsets
    db 11, 12, 13, 14, 14, 15, 15, 15
    db 15, 15, 15, 14, 14, 13, 12, 11
    db 10,  9,  8,  7,  7,  6,  6,  6
    db  6,  6,  6,  7,  7,  8,  9, 10
    
    ; $029111
    .chr
    db $5B, $5B, $5A, $5A, $4B, $4B, $4A, $4A
    db $4A, $4A, $4B, $4B, $5A, $5A, $5B, $5B
    db $5B, $5B, $4C, $4C, $4C, $4C, $4C, $4C
    db $5B, $5B, $4C, $4C, $4C, $4C, $4C, $4C
    
    ; $029131
    .hflip
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $40, $40, $40, $40, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $40
    db $00, $00, $00, $00, $00, $00, $00, $00
}

; $029151-$0291B0 LOCAL JUMP LOCATION
Beamos_DrawEyeball:
{
    LDY.b #$08
    
    ; What part of the sentry's rotation are we in?
    ; Is is >= 0x20?
    LDA.w $0DE0, X : CMP.b #$20 : BCS .in_upper_quadrants
        ; If not, zero out y.
        LDY.b #$00
    
    .in_upper_quadrants
    
    ; Store the sprite's index at $0E.
    STX.b $0E : STZ.b $0F
    
    ; Divide the rotation counter in half store it at $06.
    LSR : STA.b $06
    
    PHX
    
    TAX
    
    ; Load the eyeball's relative x position.
    LDA Pool_Beamos_DrawEyeBall_x_offsets, X : SEC : SBC.b #$03 : STA.w $0FA8
    
    CLC : ADC.b $00 : STA ($90), Y
    
    ; Load the eyeball's relative y position.
    LDA Pool_Beamos_DrawEyeBall_y_offsets, X : SEC : SBC.b #$12 : STA.w $0FA9
    CLC : ADC.b $02                                       : INY : STA ($90), Y
    LDA Pool_Beamos_DrawEyeBall_chr, X                    : INY : STA ($90), Y
    LDA.b $05 : AND.b #$31 : ORA .hflip, X : ORA.b #$0A   : INY : STA ($90), Y
    
    PLX
    
    REP #$20
    
    LDA.b $0E : CLC : ADC.b $90 : STA.b $90
    
    LDA.b $0E : LSR #2 : CLC : ADC.b $92 : STA.b $92
    
    SEP #$20
    
    ; Indicates we'll be drawing 1 sprite and force it to be a small sprite.
    LDY.b #$00 : TYA
    
    JSL.l Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; This segregates the space we're using for subsprites into 4 different
; regions in case we have more than one Beamos in play at a time.
; This also limits us to four beamos, though.
; $0291B1-$0291B4 DATA
Sprite_BeamosLaser_slots:
{
    db $00, $20, $40, $60
}
    
; $0291B5-$029256 LOCAL JUMP LOCATION
Sprite_BeamosLaser:
{
    LDA.w $0E00, X : BNE .wait
        JSR.w BeamosLaser_Draw
        
        LDA.w $0DD0, X : BNE .still_active
            DEC.w $0B6A
            
            RTS
        
        .still_active
        
        JSR.w Sprite2_CheckIfActive
        
        LDY.b #$03
        
        .move_next_subsprite
            
            PHY : PHX
            
            LDA.w $0D10, X : PHA
            LDA.w $0D30, X : PHA
            
            LDA.w $0D00, X : PHA
            LDA.w $0D20, X : PHA
            
            LDA.w $0E80, X : AND.b #$1F : LDY.w $0DC0, X : CLC : ADC .slots, Y : TAX
            
            ; Essentially, all this is to transfer the sprite's current
            ; coordinates to each subsprite's coordinates.
            PLA : STA.l $7FFF00, X
            PLA : STA.l $7FFE80, X
            
            PLA : STA.l $7FFE00, X
            PLA : STA.l $7FFD80, X
            
            PLX
            
            INC.w $0E80, X
            
            ; Since we are moving the main sprite 4 times per frame, this is
            ; what gives the laser its staggered look, as the updated coordinate
            ; is then used for each of the subsprites in sequence, in effect
            ; acting much like the vapor trail of an airplane, being the exhaust
            ; left behind.
            JSR.w Sprite2_Move
        PLY : DEY : BPL .move_next_subsprite
        
        LDA.w $0DF0, X : BEQ .capable_of_damage
            DEC : BNE .wait
                STZ.w $0DD0, X
                
                ; Make a slot available since the beam has been destroyed.
                INC.w $0B6A
    
    .wait
    
    RTS
    
    .capable_of_damage
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCS .player_collision
        JSR.w Sprite2_CheckTileCollision : BEQ .no_collision
    
    .player_collision
    
    LDA.b #$26 : JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$10 : STA.w $0DF0, X
    
    JSR.w Sprite2_ZeroVelocity
    
    LDA.b #$61
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        ; Set the timer at #$10.
        LDA.b #$10 : STA.w $0DF0, Y
        LDA.b #$03 : STA.w $0E40, Y
        LDA.b #$02 : STA.w $0DB0, Y
        LDA.b #$40 : STA.w $0E60, Y
    
    .spawn_failed
    
    LDA.b #$80 : STA.w $0D20, Y
    
    .no_collision
    
    RTS
}

; ==============================================================================

; This routine is a waste... Why not just call the routine directly?
; Maybe some code got commented out of here in development.
; $029257-$02925A LOCAL JUMP LOCATION
BeamosLaser_PrepOamCoord:
{
    JSR.w Sprite2_PrepOamCoord
    
    RTS
}

; ==============================================================================

; $02925B-$0292C5 LOCAL JUMP LOCATION
BeamosLaser_Draw:
{
    JSR.w BeamosLaser_PrepOamCoord
    
    PHX
    
    LDA.b #$1F : STA.b $0D
    LDY.w $0DC0, X : CLC : ADC Sprite_BeamosLaser_slots, Y : TAX
    
    LDY.b #$00
    
    .next_subsprite
    
        LDA.l $7FFD80, X : STA.b $00
        LDA.l $7FFE00, X : STA.b $01
        LDA.l $7FFE80, X : STA.b $02
        LDA.l $7FFF00, X : STA.b $03
        
        REP #$20
        
        LDA.b $00 : SEC : SBC.b $E2       : STA ($90), Y
                    AND.w #$0100          : STA.b $0E
        LDA.b $02 : SEC : SBC.b $E8 : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen
        
        LDA.b #$5C : INY : STA ($90), Y
        LDA.b $05  : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
        
        DEX
    DEC.b $0D : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================

; $0292C6-$0292D9 DATA
Pool_Sprite_BeamosLaserHit:
{
    ; $0292C6
    .x_offsets
    db -4, -1,  4,  0
    db -4, -1,  4,  0
    
    ; $0292CE
    .y_offsets
    db -4, -1, -4, -1
    db  4,  0,  4,  0
    
    ; $0292D6
    .properties
    db $06, $46, $86, $C6
}

; $0292DA-$029332 LOCAL JUMP LOCATION
Sprite_BeamosLaserHit:
{
    ; Load the inactivity timer.
    ; The timer is still counting down.
    LDA.w $0DF0, X : BNE .countingDown
        ; Terminate the hit sprite, as its time has expired.
        STZ.w $0DD0, X
        
    .countingDown
    
    JSR.w Sprite2_PrepOamCoord
    
    PHX
    
    LDX.b #$03
    
    .next_subsprite
    
        PHX : TXA : ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
        AND.w #$0100 : STA.b $0E

        LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen
        
        PLX
        
        LDA.b #$D6                                   : INY : STA ($90), Y
        LDA.b $05  : AND.b #$30 : ORA .properties, X : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================
