; ==============================================================================

; Bank 07
; $038000-$03FFFF
org $078000

; Player code
; Inventory item usage code
; Tile interaction
; Desert circle HDMA code
; Push block code
; Overworld sign text table
; Dungeon telepathic tile text table

; ==============================================================================

; $038000-$038020 LONG JUMP LOCATION
Player_Main:
{
    PHB : PHK : PLB
    
    REP #$20
    
    ; Mirror Link's coordinate variables.
    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4
    
    SEP #$20
    
    STZ.w $0FC1
    
    ; By frozen we generally mean he's not being allowed to move due to some
    ; kind of cinema scene or something similar.
    LDA.w $02E4 : BNE .linkFrozen
        JSR.w Link_ControlHandler
    
    .linkFrozen
    
    JSR.w HandleSomariaAndGraves
    
    PLB
    
    RTL
}

; ==============================================================================

; UNUSED: Much like the Ancilla version of this routine, seems like ambient sfx
; gets no love.
; $038021-$038027 LOCAL JUMP LOCATION
Player_DoSfx1:
{
    JSR.w Player_SetSfxPan : STA.w $012D
    
    RTS
}

; ==============================================================================

; $038028-$03802E LOCAL JUMP LOCATION
Player_DoSfx2:
{
    JSR.w Player_SetSfxPan : STA.w $012E
    
    RTS
}

; ==============================================================================

; $03802F-$038035 LOCAL JUMP LOCATION
Player_DoSfx3:
{
    JSR.w Player_SetSfxPan : STA.w $012F
    
    RTS
}

; ==============================================================================

; $038036-$038040 LOCAL JUMP LOCATION
Player_SetSfxPan:
{
    STA.w $0CF8
    
    ; A will be 0x0, 0x80, or 0x40. (ORed with this address, too.).
    JSL.l Sound_SetSfxPanWithPlayerCoords : ORA.w $0CF8
    
    RTS
}

; ==============================================================================

; $038041-$03807E JUMP TABLE
Pool_Link_ControlHandler:
{
    ; Indexed by $5D.
    
    dw LinkState_Default        ; 0x00 - $8109 Ground state (normal mode)
    dw LinkState_Pits           ; 0x01 - $92D3 Falling into a hole or getting close to edge of hole

    dw LinkState_Recoil         ; 0x02 - $86B5 Recoil from hitting a wall (other such movement)
    dw LinkState_SpinAttack     ; 0x03 - $A804 Spin Attack Mode
    dw LinkState_Swimming       ; 0x04 - $963B Swimming Mode
    dw LinkState_OnIce          ; 0x05 - $8872 Turtle Rock Platforms
    dw LinkState_Recoil         ; 0x06 - $86B5 recoil mode 2
    dw Player_Electrocution     ; 0x07 - $996C Electrocution Mode
    
    dw LinkState_UsingEther     ; 0x08 - $A50F Ether Medallion Mode
    dw LinkState_UsingBombos    ; 0x09 - $A5F7 Bombos Medallion Mode
    dw LinkState_UsingQuake     ; 0x0A - $A6D6 Quake Medallion Mode
    dw LinkState_HoppingSouthOW ; 0x0B - $894E Falling into hole by jumping off a ledge
    dw LinkState_HoppingHorizontallyOW   ; 0x0C - $8B74 Falling to the left/right off a ledge
    dw LinkState_HoppingDiagonallyUpOW   ; 0x0D - $8DC6 Jumping off a ledge diagonally up and left/right
    dw LinkState_HoppingDiagonallyDownOW ; 0x0E - $8E15 Jumping off a ledge diagonally down and left/right
    dw LinkState_0F                      ; 0x0F - $8C69 More jumping off a ledge but with dashing maybe + some directions
    
    dw LinkState_0F                  ; 0x10 - $8C69 Same as 0x0F?
    dw LinkState_Dashing             ; 0x11 - $8F86 Falling off a ledge / Dashing
    dw LinkState_ExitingDash         ; 0x12 - $915E Coming out of dash due to button press in the direction we're not going

    dw LinkState_Hookshotting        ; 0x13 - $AB7C Hookshot
    dw LinkState_CrossingWorlds      ; 0x14 - $A9B1 Magic Mirror
    dw LinkState_ShowingOffItem      ; 0x15 - $99AC Holding up an item (RTS)
    dw LinkState_Sleeping            ; 0x16 - $9A5A Asleep in bed
    dw LinkState_Bunny               ; 0x17 - $83A1 Permabunny mode
    
    dw LinkState_HoldingBigRock      ; 0x18 - $8481 stuck under heavy lifted object
    dw Player_EtherSpell             ; 0x19 - $8570 Receiving Ether Medallion Mode
    dw Player_BombosSpell            ; 0x1A - $85FB Receiving Bombos Medallion Mode
    dw LinkState_ReadingDesertTablet ; 0x1B - $867B Opening Desert Palace Mode
    dw LinkState_TemporaryBunny      ; 0x1C - $8365 Temp bunny mode
    dw LinkState_TreePull            ; 0x1D - $B416 Rolling back from Gargoyle gate or PullForRupees
    dw LinkState_SpinAttack          ; 0x1E - $A804 Spin attack mode 2
}

; $03807F-$038108 LOCAL JUMP LOCATION
Link_ControlHandler:
{
    ; Is Link being damaged?
    LDA.w $0373 : BEQ .linkNotDamaged
        ; Is Link in cape mode?
        LDA.b $55 : BEQ .capeNotActivated
            ; Nullify any Damage Link will receive, since he's in cape mode.
            STZ.w $0373

            STZ.b $4D 

            ; Link can receive movement input.
            STZ.b $46
            
            BRA .linkNotDamaged
            
        .capeNotActivated
        
        ; Can Link interact with sprites (no, if the Cane of Byrna is being
        ; used.)
        LDA.w $037B : BNE .linkNotDamaged
            ; Otherwise, tell me how much damage it will be.
            LDA.w $0373 : STA.b $00
            
            STZ.w $0373
            
            ; Is the boomerang effect going on?
            LDA.w $0C4A : CMP.b #$05 : BEQ .delta
                ; Are we being electrocuted?
                LDA.w $0300 : BEQ .delta
                    ; Is there any delay left in the electrocution step?
                    LDA.b $3D : BEQ .delta
                        ; Kill that boomerang effect.
                        STZ.w $0C4A
                        
                        ; No idea...
                        STZ.w $035F
            
            .delta
            
            LDA.w $031F : BNE .blinkingFromDamage
                LDA.b #$3A : STA.w $031F
            
            .blinkingFromDamage
            
            ; Selects the "Link has been hurt" sound.
            LDA.b #$26 : JSR.w Player_DoSfx2
            
            INC.w $0CFC
            
            ; Link's health variable. Each full heart = #$08.
            LDA.l $7EF36D
            
            ; This is damage from enemies/ weapons. Not falls.
            ; Subtract however much damage from Link.
            ; If Link's health drops to zero, then he dies.
            SEC : SBC.b $00 : CMP.b #$00 : BEQ .linkIsDead
                ; The equivalent of (A * 2 * 8) + 8 => 168 life points => 20
                ; hearts plus another heart. If health is >= 21 hearts, Link
                ; dies. Wonderful.
                CMP.b #$A8 : BCC .linkNotDead
            
            .linkIsDead
            
            LDA.b $1C : STA.l $7EC211
            LDA.b $1D : STA.l $7EC212
            
            ; Save the current mode so that the game knows what mode to go to
            ; after you've died.
            LDA.b $10 : STA.w $010C
            
            ; Enter death mode.
            LDA.b #$12 : STA.b $10
            
            ; And in death mode, go to the second submodule.
            LDA.b #$01 : STA.b $11
            
            ; Disable heart filling.
            LDA.b #$00 : STA.w $031F : STA.l $7EF372
            
            .linkNotDead
            
            ; Change Link's health accordingly.
            STA.l $7EF36D
    
    .linkNotDamaged
    
    ; Is Link in the ground state?
    LDA.b $5D : BEQ .inGroundState
        JSR.w Link_HandleCape_passive
    
    .inGroundState
    
    ; Link's main handling variable. This determines his actions.
    LDA.b $5D : ASL A : TAX
    
    JMP ($8041, X)
}

; $038109-$0382D9 JUMP LOCATION
LinkState_Default:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    
    LDA.b $F5 : AND.b #$80 : BEQ .notDebugWallWalk
        ; \tcrf(confirmed, submitted) Debug feature where if you pressed the 
        ; second control pad's B button It lets you walk through all walls.
        LDA.w $037F : EOR.b #$01 : STA.w $037F

    .notDebugWallWalk

    ; Checks whether Link can move.
    ; C clear = Link can move. C set = opposite.
    JSR.w Link_HandleBunnyTransformation : BCC .linkCanMove
        ; Link can't move... is Link in the Temp Bunny mode?
        ; No... so do nothing extra.
        LDA.b $5D : CMP.b #$17 : BNE .notTempBunnyCantMove
            ; How to handle a permabunny.
            BRL LinkState_Bunny

        .notTempBunnyCantMove

        RTS

    .linkCanMove

    STZ.w $02CA
    
    ; Is Link in a ground state? Yes...
    LDA.b $4D : BEQ .BRANCH_DELTA
        ; $038130 ALTERNATE ENTRY POINT
        .HandleLink_From1D

        STZ.w $0301 ; Link is in some other submode.
        STZ.w $037A
        STZ.w $020B
        STZ.w $0350
        STZ.w $030D
        STZ.w $030E
        STZ.w $030A
        
        STZ.b $3B
        
        ; Ignore calls to the Y button in these submodes.
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        
        STZ.b $48
        
        JSL.l Player_ResetSwimState
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        STZ.b $25
        
        LDA.w $0360 : BEQ .BRANCH_EPSILON
            ; Is Link in cape mode?
            LDA.b $55 : BEQ .BRANCH_ZETA
                JSR.w Link_ForceUnequipCape_quietly ; Link's in cape mode.

            .BRANCH_ZETA

            JSR.w Link_ResetSwordAndItemUsage
            
            LDA.b #$01 : STA.w $037B
            
            STZ.w $0300
            
            LDA.b #$02 : STA.b $3D
            
            STZ.b $2E
            
            LDA.b $67 : AND.b #$F0 : STA.b $67
            
            LDA.b #$2B : JSR.w Player_DoSfx3
            
            ; Link got hit with the Agahnim bug zapper.
            LDA.b #$07 : STA.b $5D
            
            ; GO TO ELECTROCUTION MODE.
            BRL Player_Electrocution

        .BRANCH_EPSILON

        ; Checking for indoors.
        ; OPTIMIZE: Useless branch.
        LDA.b $1B : BNE .zero_length_branch
            ; It is a secret to everybody.

        .zero_length_branch

        STZ.b $6B
        
        LDA.b #$02 : STA.b $5D
        
        BRL LinkState_Recoil ; Go to recoil mode.

    ; Pretty much normal mode. Link standing there, ready to do stuff.
    .BRANCH_DELTA

    LDA.b #$FF : STA.b $24
             STA.b $25
             STA.b $29
    
    STZ.w $02C6
    
    ; If Carry is set on Return, don't read the buttons.
    JSR.w Link_HandleToss : BCS .BRANCH_IOTA
        JSR.w Link_HandleAPress
        
        LDA.w $0308 : ORA.w $0376 : BNE .BRANCH_IOTA
            LDA.w $0377 : BNE .BRANCH_IOTA
                ; Is Link falling off of a ledge?    ; Yes...
                LDA.b $5D : CMP.b #$11 : BEQ .BRANCH_IOTA
                    JSR.w Link_HandleYItem ; Handle Y button items?
                    
                    ; HARDCODED: This is pretty unfair.
                    ; \item Relates to ability to use the sword if you have one.
                    LDA.l $7EF3C5 : BEQ .cant_use_sword
                        JSR.w Player_Sword
                        
                        ; Is Link in spin attack mode?  No...
                        LDA.b $5D : CMP.b #$03 : BNE .BRANCH_IOTA
                            STZ.b $30
                            STZ.b $31
                            
                            BRL .dont_halt_link

                    .cant_use_sword
    .BRANCH_IOTA

    JSR.w Link_HandleCape_passive_LiftCheck
    
    LDA.b $46 : BEQ .BRANCH_KAPPA
        LDA.b $6B : BEQ .BRANCH_LAMBDA
            STZ.b $6B

        .BRANCH_LAMBDA

        STZ.w $030D
        STZ.w $030E
        STZ.w $030A
        STZ.b $3B
        STZ.w $0309
        STZ.w $0308
        STZ.w $0376
        
        LDA.b $3A : AND.b #$80 : BNE .BRANCH_MU
            LDA.b $50 : AND.b #$FE : STA.b $50

        .BRANCH_MU

        BRL .BRANCH_$38711

    .BRANCH_KAPPA

    LDA.w $0377 : BEQ .BRANCH_NU
        STZ.b $67
        
        BRA .BRANCH_OMICRON

    .BRANCH_NU

    LDA.w $02E1 : BNE .BRANCH_OMICRON
        LDA.w $0376 : AND.b #$FD : BNE .BRANCH_OMICRON
            LDA.w $0308 : AND.b #$7F : BNE .BRANCH_OMICRON
                LDA.w $0308 : AND.b #$80 : BEQ .BRANCH_PI
                    LDA.w $0309 : AND.b #$01 : BNE .BRANCH_OMICRON

                .BRANCH_PI

                LDA.w $0301 : BNE .BRANCH_OMICRON
                    LDA.w $037A : BNE .BRANCH_OMICRON
                        LDA.b $3C : CMP.b #$09 : BCC .BRANCH_RHO
                            LDA.b $3A : AND.b #$20 : BNE .BRANCH_RHO
                                LDA.b $3A : AND.b #$80 : BEQ .BRANCH_RHO

    .BRANCH_OMICRON

    BRA .BRANCH_PHI

    .BRANCH_RHO

    LDA.w $034A : BEQ .BRANCH_TAU
        LDA.b #$01 : STA.w $0335 : STA.w $0337
        LDA.b #$80 : STA.w $0334 : STA.w $0336
        
        BRL Link_HandleSwimMovements

    .BRANCH_TAU

    JSR.w Player_ResetSwimCollision
    
    LDA.b $49 : AND.b #$0F : BNE .BRANCH_UPSILON
        LDA.w $0376 : AND.b #$02 : BNE .BRANCH_PHI
            ; Branch if there are any directional buttons down.
            LDA.b $F0 : AND.b #$0F : BNE .BRANCH_UPSILON
                STA.b $30 : STA.b $31 : STA.b $67 : STA.b $26
                
                STZ.b $2E
                
                LDA.b $48 : AND.b #$F0 : STA.b $48
                
                LDX.b #$20 : STX.w $0371
                
                ; Ledge countdown timer resets here because of lack of
                ; directional input...
                LDX.b #$13 : STX.w $0375
                
                BRA .BRANCH_PHI

    .BRANCH_UPSILON

    ; Store the directional data at $67. Is it equal to the previous reading?
    ; Yes, so branch.
    STA.b $67 : CMP.b $26 : BEQ .BRANCH_CHI
        ; If the reading changed, we have to do all this.
        STZ.b $2A
        STZ.b $2B
        STZ.b $6B
        STZ.b $48
        
        LDX.b #$20 : STX.w $0371
        
        ; Reset ledge timer here because direction of ... (automated?) player
        ; changed?
        LDX.b #$13 : STX.w $0375

    .BRANCH_CHI

    STA.b $26

    .BRANCH_PHI

    JSR.w Link_HandleDiagonalCollision
    JSL.l Link_HandleVelocity
    JSR.w Link_HandleCardinalCollision ; Has to do with opening chests.
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    LDA.w $0377 : BEQ .dont_halt_link
        STZ.b $30
        STZ.b $31

    ; $0382D2 LONG BRANCH LOCATION
    .dont_halt_link

    STZ.w $0302
    
    JSR.w HandleIndoorCameraAndDoors

    .return

    CLC
    
    RTS
}

; $0382DA-$038364 LOCAL JUMP LOCATION
Link_HandleBunnyTransformation:
{
    ; Has the tempbunny timer counted down yet?
    LDA.w $03F5 : ORA.w $03F6 : BEQ LinkState_Default_return
        ; Check if Link first needs to be transformed.
        LDA.w $03F7 : BNE .doTransformation
            ; Is Link a permabunny or tempbunny?
            LDA.b $5D
            
            CMP.b #$17 : BEQ .inBunnyForm
            CMP.b #$1C : BEQ .inBunnyForm
                LDA.w $0309 : AND.b #$02 : BEQ .notLiftingAnything
                    STZ.w $0308
                
                .notLiftingAnything
                
                LDA.w $0308 : AND.b #$80 : PHA
                
                JSL.l Player_ResetState
                
                PLA : STA.w $0308
                
                LDX.b #$04
                
                .nextObjectSlot
                
                    LDA.w $0C4A, X
                    
                    CMP.b #$30 : BEQ .killByrnaObject
                        CMP.b #$31 : BNE .notByrnaObject
                            .killByrnaObject
                            
                            STZ.w $0C4A, X
                        
                        .notByrnaObject
                DEX : BPL .nextObjectSlot
                
                JSR.w Player_HaltDashAttack
                
                LDY.b #$04
                LDA.b #$23
                
                ; $04912C IN ROM
                JSL.l AddTransformationCloud
                
                LDA.b #$14 : JSR.w Player_DoSfx2
                
                ; It will take 20 frames for the transformation to finish.
                LDA.b #$14 : STA.w $02E2
                
                ; Indicate that a transformation is in progress by way of flags.
                LDA.b #$01 : STA.w $037B : STA.w $03F7
                
                ; Make Link invisible during the transformation.
                LDA.b #$0C : STA.b $4B
        
        .doTransformation
        
        ; $02E2 is a timer that counts down when Link changes shape.
        DEC.w $02E2 : BPL .return
            ; Turn Link into a temporary bunny.
            LDA.b #$1C : STA.b $5D
            
            ; Change Link's graphics to the bunny set.
            LDA.b #$01 : STA.w $02E0 : STA.b $56
            
            JSL.l LoadGearPalettes_bunny
            
            STZ.b $4B
            STZ.w $037B
            
            ; Link no longer has to be changed into a bunny.
            STZ.w $03F7

            BRA .return
            
            .inBunnyForm
            
            ; Set the bunny timer to zero.
            STZ.w $03F5
            STZ.w $03F6
            
            ; Link can move.
            CLC
            
            RTS
        
        .return
        
        ; Link can't move.
        SEC
        
        RTS
}

; This is the tempbunny submodule.
; $038365-$0383A0 JUMP LOCATION
LinkState_TemporaryBunny:
{
    ; Check the bunny timer.
    LDA.w $03F5 : ORA.w $03F6 : BNE .BRANCH_ALPHA ; If it is not zero, branch.
        LDY.b #$04 ; If time is up, then...
        LDA.b #$23
        
        JSL.l AddTransformationCloud
        
        LDA.b #$15 : JSR.w Player_DoSfx2
        
        LDA.b #$20 : STA.w $02E2
        
        LDA.b #$00 : STA.b $5D
        
        JSL.l $07F1FA ; $03F1FA IN ROM. Reinstates your abilities.
        
        STZ.w $03F7
        STZ.b $56
        STZ.w $02E0
        
        JSL.l LoadActualGearPalettes
        
        STZ.w $03F7
        
        BRL LinkState_Default ; Return to normal mode.
            RTS
    
    .BRANCH_ALPHA
    
    REP #$20
    
    DEC.w $03F5 ; To access the 16-bit timer, we 16-bit registers.
    
    SEP #$20

    ; Bleeds into the next function.
}
    
; Jump here directly to handle a permabunny.
; $0383A1-$038480 LONG BRANCH LOCATION.
LinkState_Bunny:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    
    LDA.b $F5 : AND.b #$80 : BEQ .BRANCH_BETA
        ; If the number is odd, change it to the closest lower even number.
        LDA.w $037F : EOR.b #$01 : STA.w $037F
    
    .BRANCH_BETA
    
    STZ.w $02CA
    
    LDA.w $0345 : BNE .BRANCH_GAMMA
        LDA.b $4D : BEQ .BRANCH_DELTA
            LDA.l $7EF357 : BEQ .BRANCH_GAMMA
                STZ.w $02E0
    
    ; $0383C7 LONG BRANCH LOCATION
    .BRANCH_GAMMA
    
    STZ.w $03F7
    STZ.w $03F5
    STZ.w $03F6
    
    LDA.l $7EF357 : BEQ .BRANCH_EPSILON
        STZ.b $56
        STZ.b $4D
    
    .BRANCH_EPSILON
    
    STZ.b $2E
    STZ.w $02E1
    STZ.b $50
    
    JSL.l Player_ResetSwimState
    
    ; Link hit a wall or an enemy hit him, making him go backwards.
    LDA.b #$02 : STA.b $5D
    
    LDA.l $7EF357 : BEQ .BRANCH_ZETA
        LDA.b #$00 : STA.b $5D
        
        JSL.l LoadActualGearPalettes
    
    .BRANCH_ZETA
    
    BRL .BRANCH_NU
        .BRANCH_DELTA
        
        LDA.b $46 : BEQ .BRANCH_THETA
            BRL LinkState_Bunny ; Permabunny mode.
        
        .BRANCH_THETA
        
        LDA.b #$FF : STA.b $24 : STA.b $25 : STA.b $29
        
        STZ.w $02C6
        
        LDA.w $034A : BEQ .BRANCH_IOTA
            LDA.b #$01 : STA.w $0335 : STA.w $0337
            
            LDA.b #$80 : STA.w $0334 : STA.w $0336
            
            BRL Link_HandleSwimMovements
        
        .BRANCH_IOTA
        
        JSR.w Player_ResetSwimCollision
        JSR.w Link_HandleYItem
        
        LDA.b $49 : AND.b #$0F : BNE .BRANCH_KAPPA
            LDA.b $F0 : AND.b #$0F : BNE .BRANCH_KAPPA
                STA.b $30 : STA.b $31 : STA.b $67 : STA.b $26
                
                STZ.b $2E
                
                LDA.b $48 : AND.b #$F6 : STA.b $48
                
                LDX.b #$20 : STX.w $0371
                
                ; Ledge timer is reset here the same way as for normal link
                ; (unbunny).
                LDX.b #$13 : STX.w $0375
                
                BRA .BRANCH_LAMBDA
        
        .BRANCH_KAPPA
        
        STA.b $67 : CMP.b $26 : BEQ .BRANCH_MU
            STZ.b $2A
            STZ.b $2B
            STZ.b $6B
            STZ.b $4B
            
            LDX.b #$20 : STX.w $0371
            
            ; Ledge timer is reset here the same way as for normal link
            ; (unbunny).
            LDX.b #$13 : STX.w $0375
        
        .BRANCH_MU
        
        STA.b $26
        
        .BRANCH_LAMBDA
        
        JSR.w Link_HandleDiagonalCollision
        JSL.l Link_HandleVelocity
        JSR.w Link_HandleCardinalCollision
        JSL.l Link_HandleMovingAnimation_FullLongEntry
        
        STZ.w $0302
        
        JSR.w HandleIndoorCameraAndDoors
    
    .BRANCH_NU
    
    RTS
}

; Mode 0x18 - stuck under heavy lifted object
; $038481-$038559 JUMP LOCATION
LinkState_HoldingBigRock:
{
    LDA.b $4D : BEQ .BRANCH_ALPHA
        STZ.w $0301
        STZ.w $037A
        STZ.w $020B
        STZ.w $0350
        STZ.w $030D
        STZ.w $030E
        STZ.w $030A
        STZ.b $3B
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        STZ.b $48
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        STZ.b $25
        
        LDA.w $0360 : BEQ .BRANCH_BETA
            JSR.w Link_ResetSwordAndItemUsage
            
            LDA.b #$01 : STA.w $037B
            
            STZ.w $0300
            
            LDA.b #$02 : STA.b $3D
            
            STZ.b $2E
            
            LDA.b $67 : AND.b #$F0 : STA.b $67
            
            LDA.b #$2B : JSR.w Player_DoSfx3
            
            LDA.b #$07 : STA.b $5D
            
            BRL Player_Electrocution
        
        .BRANCH_BETA
        
        LDA.b #$02 : STA.b $5D
        
        BRL LinkState_Recoil ; GO TO RECOIL MODE.
    
    .BRANCH_ALPHA
    
    LDA.b #$FF : STA.b $24
                 STA.b $25
                 STA.b $29
    
    STZ.w $02C6
    
    LDA.b $46 : BEQ .BRANCH_GAMMA
        STZ.w $030D
        STZ.w $030E
        STZ.w $030A
        STZ.b $3B
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        
        LDA.b $3A : AND.b #$80 : BNE .BRANCH_DELTA
            LDA.b $50 : AND.b #$FE : STA.b $50
        
        .BRANCH_DELTA
        
        BRL .BRANCH_$38711
    
    .BRANCH_GAMMA
    
    JSR.w Link_HandleAPress
    
    LDA.b $50 : AND.b #$0F : BNE .BRANCH_EPSILON
        STA.b $30 : STA.b $31 : STA.b $67 : STA.b $26
        
        STZ.b $2E
        
        LDA.b $48 : AND.b #$F6 : STA.b $48
        
        LDX.b #$20 : STX.w $0371
        LDX.b #$13 : STX.w $0375
        
        BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    STA.b $67 : CMP.b $26 : BEQ .BRANCH_THETA
        STZ.b $2A
        STZ.b $2B
        STZ.b $6B
        STZ.b $48
        
        LDX.b #$20 : STX.w $0371
        
        LDX.b #$13 : STX.w $0375
        
    .BRANCH_THETA
    
    STA.b $26
    
    .BRANCH_ZETA
    
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    STZ.w $0302
    
    JSR.w HandleIndoorCameraAndDoors
    
    RTS
}

; ==============================================================================

; $03855A-$03856F LONG JUMP LOCATION
Player_InitiateFirstEtherSpell:
{
    REP #$20
    
    LDA.w #$00C0 : STA.b $3C
    
    SEP #$20
    
    LDA.b #$19 : STA.b $5D
    
    LDA.b #$01 : STA.w $037B : STA.w $0FFC
    
    RTL
}

; ==============================================================================

; $038570-$03858D JUMP LOCATION
Player_EtherSpell:
{
    STZ.b $4D
    STZ.b $46
    STZ.w $0373
    
    REP #$20
    
    DEC.b $3C : LDA.b $3C : BMI .BRANCH_ALPHA
        BEQ .BRANCH_BETA
            CMP.w #$00A0 : BEQ .BRANCH_GAMMA
                CMP.w #$00BF : BEQ .BRANCH_DELTA
                
                SEP #$20
                
                RTS
    
    .BRANCH_ALPHA
    
    SEP #$20
    STZ.b $3C
    STZ.b $3D
    
    RTS
    
    .BRANCH_DELTA
    
    SEP #$20
    
    LDA.b #$01 : STA.w $03EF
    
    RTS
    
    .BRANCH_BETA
    
    SEP #$20
    
    LDX.b #$00
    LDY.b #$04
    LDA.b #$29
    
    JSL.l AddPendantOrCrystal
    
    LDA.b #$01 : STA.w $02E4
    
    STZ.w $0FFC
    
    RTS
    
    .BRANCH_GAMMA
    
    SEP #$20
    
    LDA.b $20 : PHA
    LDA.b $21 : PHA
    LDA.b $22 : PHA
    LDA.b $23 : PHA
    
    LDA.b #$37 : STA.b $20
    LDA.b #$00 : STA.b $21
    LDA.b #$B0 : STA.b $22
    LDA.b #$06 : STA.b $23
    
    LDY.b #$00
    LDA.b #$18
    
    JSL.l AddEtherSpell
    
    PLA : STA.b $23
    PLA : STA.b $22
    PLA : STA.b $21
    PLA : STA.b $20
    
    RTS
}

; ==============================================================================

; $0385E5-$0385FA LONG JUMP LOCATION
Player_InitiateFirstBombosSpell:
{
    REP #$20
    
    LDA.w #$00E0 : STA.b $3C
    
    SEP #$20
    
    ; Link is receiving Bombos medallion.
    LDA.b #$1A : STA.b $5D
    
    LDA.b #$01 : STA.w $037B : STA.w $0112
    
    RTL
}

; ==============================================================================

; $0385FB-$03866C JUMP LOCATION
Player_BombosSpell:
{
    STZ.b $4D
    STZ.b $46
    STZ.w $0373
    
    REP #$20
    
    DEC.b $3C : LDA.b $3C : BMI .BRANCH_ALPHA  BEQ .BRANCH_BETA
        CMP.w #$00A0 : BEQ .BRANCH_GAMMA
            CMP.w #$00DF : BEQ .BRANCH_DELTA
                SEP #$20
                
                RTS
            
            .BRANCH_DELTA
            
            SEP #$20
            
            LDA.b #$01 : STA.w $03EF
            
            RTS
            
            .BRANCH_ALPHA
            
            SEP #$20
            
            STZ.b $3C
            STZ.b $3D
            
            RTS
    
    .BRANCH_BETA
    
    SEP #$20
    
    LDY.b #$04
    LDX.b #$05
    LDA.b #$29
    
    JSL.l AddPendantOrCrystal
    
    LDA.b #$01 : STA.w $02E4
    
    RTS
    
    .BRANCH_GAMMA
    
    SEP #$20
    
    LDA.b $20 : PHA
    LDA.b $21 : PHA
    LDA.b $22 : PHA
    LDA.b $23 : PHA
    
    LDA.b #$B0 : STA.b $20
    LDA.b #$0E : STA.b $21
    LDA.b #$78 : STA.b $22
    LDA.b #$03 : STA.b $23
    
    LDY.b #$00
    LDA.b #$19
    
    JSL.l AddBombosSpell
    
    PLA : STA.b $23
    PLA : STA.b $22
    PLA : STA.b $21
    PLA : STA.b $20
    
    RTS
}

; $03866D-$03867A LONG JUMP LOCATION
InitiateDesertCutscene:
{
    ; Enters the desert palace opening mode.
    REP #$20
    
    LDA.w #$0001 : STA.b $3C
    
    SEP #$20
    
    LDA.b #$1B : STA.b $5D
    
    RTL
}

; $03867B-$038688 JUMP LOCATION
LinkState_ReadingDesertTablet:
{
    DEC.b $3C : LDA.b $3C : BNE .waitForSpinAttack
        LDA.b #$00 : STA.b $5D
        
        JSR.w Link_PerformDesertPrayer
    
    .waitForSpinAttack
    
    RTS
}

; $038689-$0386B4 LOCAL JUMP LOCATION
HandleSomariaAndGraves:
{
    ; Are we in a dungeon?
    LDA.b $1B : BNE .indoors
        LDA.w $03E9 : BEQ .no_gravestones_active
            LDX.b #$04
            
            .next_ancilla
            
                LDA.w $0C4A, X : CMP.b #$24 : BNE .not_gravestone
                    JSL.l Gravestone_Move
                
                .not_gravestone
            DEX : BPL .next_ancilla

        .no_gravestones_active
    .indoors
    
    LDX.b #$04
    
    .next_ancilla_2
    
        LDA.w $0C4A, X : CMP.b #$2C : BNE .not_somarian_block
            JSL.l SomarianBlock_PlayerInteraction
            
            BRA .return
        
        .not_somarian_block
    DEX : BPL .next_ancilla_2
    
    .return
    
    RTS
}

; RECOIL MODE (2 and 6 are both recoil mode).
; $0386B5-$038710 LONG BRANCH LOCATION
LinkState_Recoil:
{
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40

    LDA.b $22 : STA.b $3F
    LDA.b $23 : STA.b $41
    
    JSR.w Link_HandleChangeInZVelocity
    
    STZ.b $50
    STZ.w $0351
    
    LDA.b $24 : BPL .BRANCH_ALPHA
        LDA.b $29 : BPL .BRANCH_ALPHA
            LDY.b #$05
            
            JSR.w TileDetect_MainHandler
            
            LDA.w $0341 : AND.b #$01 : BEQ .BRANCH_BETA
                ; Put Link into Swimming mode.
                LDA.b #$04 : STA.b $5D
                
                JSR.w Link_SetToDeepWater
                JSR.w Link_ResetSwordAndItemUsage
                
                LDA.b #$15
                LDY.b #$00
                
                JSL.l AddTransitionSplash ; $0498FC IN ROM
                
                BRL .BRANCH_BETA ; Lol what?

            .BRANCH_BETA

            INC.w $02C6 : LDA.w $02C6 : CMP.b #$04 : BEQ .BRANCH_GAMMA
                TAX
                
                LDA.w $02C7

                .BRANCH_DELTA

                    LSR A
                DEX : BEQ .BRANCH_DELTA
                
                STA.b $29 : BNE .BRANCH_ALPHA
                    .BRANCH_GAMMA

                    LDA.b #$03 : STA.w $02C6

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $038711-$038871 LOCAL JUMP LOCATION
Link_HandleRecoilAndTimer:
{
    STZ.b $68
    STZ.b $69
    STZ.b $6A
    
    JSR.w Link_HandleRecoiling
    
    DEC.b $46 : LDA.b $46 : BEQ .BRANCH_EPSILON
        .BRANCH_IOTA

        BRL .BRANCH_ZETA

    .BRANCH_EPSILON

    INC A : STA.b $46
    
    LDA.b $24 : AND.b #$FE : BEQ .BRANCH_THETA
        BPL .BRANCH_IOTA

    .BRANCH_THETA

    LDA.b $29 : BPL .BRANCH_IOTA
        LDA.b $4D : BNE .BRANCH_KAPPA
            BRL .BRANCH_LAMBDA

        .BRANCH_KAPPA

        STZ.w $037B
        
        LDA.b $5D : STA.b $72
        
        LDA.b $5D : CMP.b #$06 : BEQ .BRANCH_MU
            STZ.b $3C
            STZ.b $3A
            STZ.b $3D
            STZ.b $79

        .BRANCH_MU

        JSR.w Link_SplashUponLanding
        
        LDA.w $02E0 : BEQ .BRANCH_NU
            LDA.w $0345 : BEQ .BRANCH_NU
                BRL .BRANCH_XI

        .BRANCH_NU

        LDA.w $02F8 : BEQ .BRANCH_OMICRON
            STZ.w $02F8
            
            BRA .BRANCH_PI

        .BRANCH_OMICRON

        LDA.b $72 : CMP.b #$02 : BEQ .BRANCH_RHO
            LDA.b $5D : CMP.b #$04 : BEQ .BRANCH_RHO
                .BRANCH_PI

                LDA.b #$21 : JSR.w Player_DoSfx2

        .BRANCH_RHO

        LDY.b $5D : CPY.b #$04 : BNE .BRANCH_SIGMA
            JSR.w Link_ForceUnequipCape_quietly
            
            LDA.b $1B : BEQ .BRANCH_TAU
                LDA.b $72 : CMP.b #$02 : BEQ .BRANCH_TAU
                    LDA.l $7EF356 : BEQ .BRANCH_TAU
                        LDA.b #$01 : STA.b $EE

            .BRANCH_TAU
            
            LDA.b #$15
            LDY.b #$00
            
            JSL.l AddTransitionSplash ; $0498FC IN ROM

        .BRANCH_SIGMA

        LDY.b #$00
        
        JSR.w TileDetect_MainHandler
        
        LDA.w $0357 : AND.b #$01 : BEQ .BRANCH_UPSILON
            ; Make grass swishy sound effect.
            LDA.b #$1A : JSR.w Player_DoSfx2

        .BRANCH_UPSILON

        LDA.w $0359 : AND.b #$01 : BEQ .BRANCH_PHI
            LDA.w $012E : CMP.b #$24 : BEQ .BRANCH_PHI
                LDA.b #$1C : JSR.w Player_DoSfx2

        .BRANCH_PHI

        LDA.w $0341 : AND.b #$01 : BEQ .BRANCH_BETA
            LDA.b #$04 : STA.b $5D
            
            JSR.w Link_SetToDeepWater
            JSR.w Link_ResetSwordAndItemUsage
            
            LDA.b #$15
            LDY.b #$00
            
            JSL.l AddTransitionSplash

        .BRANCH_BETA

        LDA.b $EE : CMP.b #$02 : BNE .BRANCH_CHI
            STZ.b $EE

        .BRANCH_CHI

        LDA.w $047A : BEQ .BRANCH_XI
            JSL.l Player_LedgeJumpInducedLayerChange

        .BRANCH_XI

        STZ.b $24
        STZ.b $25
        STZ.b $4D
        STZ.b $5E
        STZ.b $50
        STZ.w $0301
        STZ.w $037A
        STZ.w $0300
        STZ.w $037B
        STZ.w $0360
        STZ.b $27
        STZ.b $28

        .BRANCH_LAMBDA

        STZ.b $2E
        STZ.b $46

    .BRANCH_ZETA

    LDA.b $5D : CMP.b #$05 : BEQ .BRANCH_PSI
        LDA.b $46 : CMP.b #$21 : BCC .BRANCH_PSI
            DEC.w $02C5 : BPL .BRANCH_OMEGA
                LSR #4 : STA.w $02C5

    .BRANCH_PSI

    JSR.w Flag67WithDirections
    
    LDA.b $5D : CMP.b #$06 : BEQ .BRANCH_DIALPHA
        JSR.w Link_HandleDiagonalCollision
        
        LDA.b $67 : AND.b #$03 : BNE .BRANCH_DIBETA
            STZ.b $28

        .BRANCH_DIBETA
            ; Loop.
        LDA.b $67 : AND.b #$0C : BNE .BRANCH_DIBETA
        
        STZ.b $27

    .BRANCH_DIALPHA

    JSL.l LinkHop_FindArbitraryLandingSpot

    .BRANCH_OMEGA

    LDA.b $5D : CMP.b #$06 : BEQ .BRANCH_DIGAMMA
        JSR.w Link_HandleCardinalCollision
        
        STZ.w $0302

    .BRANCH_DIGAMMA

    JSR.w HandleIndoorCameraAndDoors
    
    LDA.b $24 : BEQ .BRANCH_DIDELTA
        CMP.b #$E0 : BCC .BRANCH_DIEPSILON

    .BRANCH_DIDELTA

    JSR.w Player_TileDetectNearby
    
    LDA.b $59 : AND.b #$0F : CMP.b #$0F : BNE .BRANCH_DIEPSILON
        LDA.b #$01 : STA.b $5D
        LDA.b #$04 : STA.b $5E

    .BRANCH_DIEPSILON

    STZ.b $25
    
    RTS
}

; MODE 5 TURTLE ROCK PLATFORMS
; $038872-$038925 JUMP LOCATION
LinkState_OnIce:
{
    LDA.b $1B : BNE .BRANCH_ALPHA
        BRL .BRANCH_NU

    .BRANCH_ALPHA

    LDX.b #$00
    
    LDA.b $EE : BEQ .BRANCH_BETA
        STZ.b $EE
        
        JSR.w TileDetect_UnusedIce
        
        LDX.b #$00
        
        LDA.b #$01 : STA.b $EE
        
        LDA.w $034C : AND.b #$03 : CMP.b #$03 : BEQ .BRANCH_BETA
            LDX.b #$01

    .BRANCH_BETA

    STX.w $034E

    .BRANCH_PI

        DEC.b $3D : BPL .BRANCH_GAMMA
            LDA.b #$03 : STA.b $3D
            
            LDA.w $0300 : EOR.b #$01 : STA.w $0300

        .BRANCH_GAMMA

        LDA.b $F0 : AND.b #$0F : BNE .BRANCH_DELTA
            ; Isn't this equivalent to STZ?
            STA.b $30 : STA.b $31 : STA.b $67 : STA.b $26
            
            STZ.b $2E
            
            BRA .BRANCH_EPSILON

        .BRANCH_DELTA

        STA.b $67 : CMP.b $26 : BEQ .BRANCH_ZETA
            STZ.b $2A
            STZ.b $2B
            STZ.b $6B

        .BRANCH_ZETA

        STA.b $26

        .BRANCH_EPSILON

        LDX.b #$10
        
        LDA.b $67
        
        AND.b #$0F : BEQ .BRANCH_THETA
            AND.b #$0C : BEQ .BRANCH_IOTA
            LDA.b $67 : AND.b #$03 : BEQ .BRANCH_IOTA
                LDX.b #$0A

            .BRANCH_IOTA

            STX.b $00
            
            LDA.b $67
            
            AND.b #$0C : BEQ .BRANCH_KAPPA
                AND.b #$08 : BEQ .BRANCH_LAMBDA
                    TXA : EOR.b #$FF : INC A : TAX

                .BRANCH_LAMBDA

                STX.b $27

            .BRANCH_KAPPA

            LDX.b $00
            
            LDA.b $67 : AND.b #$03 : BEQ .BRANCH_THETA
                AND.b #$02 : BEQ .BRANCH_MU
                    TXA : EOR.b #$FF : INC A : TAX

                .BRANCH_MU

                STX.b $28

        .BRANCH_THETA

        JSL.l Link_HandleMovingAnimation_FullLongEntry
        
        ; GO TO RECOIL MODE (Revision really recoil mode or just jumping?).
        BRL LinkState_Recoil
        
        LDY.b #$00

        .BRANCH_NU

        JSR.w TileDetect_MainHandler
        
        LDA.w $035B : AND.b #$01 : BEQ .BRANCH_XI
            LDA.b #$02 : STA.b $EE
            
            BRA .BRANCH_OMICRON

        .BRANCH_XI

        STZ.w $00EE

        .BRANCH_OMICRON

        LDA.b #$01 : STA.w $034E
    BRL .BRANCH_PI
}

; $038926-$03894D LOCAL JUMP LOCATION
Link_HandleChangeInZVelocity:
{
    LDX.b #$02
    
    ; What mode is Link in ?; Is he on a Turtle Rock platform?
    LDA.b $5D : CMP.b #$05 : BNE .BRANCH_ALPHA
        LDX.b #$01
    
    .BRANCH_ALPHA
    
    STX.b $00
    
    ; $038932 ALTERNATE ETNRY POINT
    .preset

    LDA.b $29 : BPL .apply_z_speed_change
        LDA.b $24 : BEQ .BRANCH_GAMMA  BPL .apply_z_speed_change
            LDA.b #$FF : STA.b $24 : STA.b $25 : STA.b $29
            
            BRA .BRANCH_GAMMA
    
    ; $038946 ALTERNATE ENTRY POINT
    .apply_z_speed_change
    
    LDA.b $29 : SEC : SBC.b $00 : STA.b $29
    
    .BRANCH_GAMMA
    
    RTS
}

; Link mode 0x0B - falling down ledge to water or a hole? (Is that it?)
; $03894E-$038A04 LOCAL JUMP LOCATION
LinkState_HoppingSouthOW:
{
    ; Last direction Link moved in was down?
    LDA.b #$01 : STA.b $66
    
    STZ.b $50
    STZ.b $27
    STZ.b $28
    STZ.w $0351
    
    LDA.b $46 : BNE .BRANCH_ALPHA
        LDA.w $0362 : BNE .BRANCH_ALPHA
            ; Play the "something's falling" sound effect.
            LDA.b #$20 : JSR.w Player_DoSfx2
            
            JSR.w LinkHop_FindTileToLandOnSouth
            
            LDA.b $1B : BNE .indoors
                LDA.b #$02 : STA.b $EE

            .indoors
    
    .BRANCH_ALPHA
    
    LDA.w $0362 : STA.b $29
    
    LDA.w $0363 : STA.w $02C7
    
    LDA.w $0364 : STA.b $24
    LDA.w $0365 : STA.b $25
    
    LDA.b #$02 : STA.b $00
    
    JSR.w Link_HandleChangeInZVelocity_apply_z_speed_change
    JSL.l LinkHop_FindArbitraryLandingSpot
    
    LDA.b $29 : BPL .BRANCH_BETA
        CMP.b #$A0 : BCS .BRANCH_GAMMA
            LDA.b #$A0 : STA.b $29
        
        .BRANCH_GAMMA
        
        REP #$20
        
        LDA.b $24 : CMP.w #$FFF0 : BCC .BRANCH_BETA
            STZ.b $24
            
            SEP #$20
            
            JSR.w Link_SplashUponLanding
            
            LDA.b $5B : BEQ .BRANCH_DELTA
                LDA.b #$01 : STA.b $5D
            
            .BRANCH_DELTA
            
            LDA.b $5D
            
            CMP.b #$04 : BEQ .BRANCH_EPSILON
            CMP.b #$01 : BEQ .BRANCH_EPSILON
                LDA.w $0345 : BNE .BRANCH_EPSILON
                    ; The sound of something hitting the ground?
                    LDA.b #$21 : JSR.w Player_DoSfx2
            
            .BRANCH_EPSILON
            
            STZ.w $037B
            STZ.b $78
            STZ.b $4D
            
            LDA.b #$FF : STA.b $29 : STA.b $24 : STA.b $25
            
            STZ.b $46
            
            LDA.b $1B : BNE .BRANCH_ZETA
                STZ.b $EE
            
            .BRANCH_ZETA
            
            BRA .BRANCH_THETA
    
    .BRANCH_BETA
    
    SEP #$20
    
    LDA.w $0364 : SEC : SBC.b $24 : STA.b $30
    
    LDA.b $29   : STA.w $0362
    LDA.w $02C7 : STA.w $0363
    LDA.b $24   : STA.w $0364
    LDA.b $25   : STA.w $0365
    
    RTS
}

; $038A05-$038AC8 LOCAL JUMP LOCATION
LinkState_HandlingJump:
{
    LDA.w $0362 : STA.b $29
    LDA.w $0362 : STA.w $02C7
    LDA.w $0364 : STA.b $24
    
    LDA.b #$02 : STA.b $00
    
    JSR.w Link_HandleChangeInZVelocity_apply_z_speed_change
    
    JSL.l LinkHop_FindArbitraryLandingSpot
    
    LDA.b $29 : BMI .alpha
        BRL .beta
    
    .alpha
    
    CMP.b #$A0 : BCS .gamma
        LDA.b #$A0 : STA.b $A9
    
    .gamma
    
    LDA.b $24 : CMP.b #$F0 : BCC .beta
        STZ.b $24
        STZ.b $25
        
        LDA.b $5D
        
        CMP.b #$0C : BEQ .delta
            CMP.b #$0E : BNE .epsilon
        
        .delta
        
        LDY.b #$00
        
        JSR.w TileDetect_MainHandler
        
        LDA.w $0341 : AND.b #$01 : BEQ .zeta
            LDA.b #$04 : STA.b $5D
            
            JSR.w Link_SetToDeepWater
            JSR.w Link_ResetSwordAndItemUsage
            
            ; Add transition splash.
            LDA.b #$15
            LDY.b #$00
            
            JSL.l AddTransitionSplash
            
            BRA .epsilon
        
        .zeta
        
        LDA.b $59 : AND.b #$01 : BEQ .epsilon
            LDA.b #$09 : STA.b $5C
            
            STZ.b $5A
            
            LDA.b #$01 : STA.b $5B
            
            LDA.b #$01 : STA.b $5D
            
            BRA .theta
        
        .epsilon
        
        JSR.w Link_SplashUponLanding
        
        LDA.b $5D : CMP.b #$04 : BEQ .theta
            LDA.w $0345 : BNE .theta
                LDA.b #$21 : JSR.w Player_DoSfx2
        
        .theta
        
        LDA.b $5D : CMP.b #$04 : BNE .iota
            LDA.w $02E0 : BNE .kappa
        
        .iota
        
        STZ.w $037B
        
        .kappa
        
        STZ.b $78
        STZ.b $4D
        
        LDA.b #$FF : STA.b $29 : STA.b $24 : STA.b $25
        
        STZ.b $46
        
        LDA.b $1B : BNE .lambda
            STZ.b $EE
        
        .lambda
        
        BRA .mu
    
    .beta
    
    LDA.w $0364 : SEC : SBC.b $24 : STA.b $30
    
    .mu
    
    LDA.b $29 : STA.w $0362
    
    LDA.w $02C7 : STA.w $0363
    
    LDA.b $24 : STA.w $0364
    
    RTS
}

; $038AC9-$038AD0 DATA
Pool_LinkHop_FindTileToLandOnSouth:
Pool_Link_HoppingHorizontally_FindTile_Vertical:
{
    ; $038AC9
    .offset_x
    db -8, -1, 8, 0
    
    ; $038ACD
    .offset_y
    db -16, -1, 16, 0
}

; $038AD1-$038B73 LOCAL JUMP LOCATION
LinkHop_FindTileToLandOnSouth:
{
    LDA.b $21 : STA.b $33
    LDA.b $20 : STA.b $32
    
    SEC : SBC.b $3E : STA.b $30
    
    .BRANCH_ALPHA
    
        LDA.b $66 : ASL A : TAY
        
        REP #$20
        
        LDA.w Pool_LinkHop_FindTileToLandOnSouth_offset_x, Y
        CLC : ADC.b $20 : STA.b $20
        
        SEP #$20
        
        JSR.w TileDetect_Movement_Vertical
        
        LDA.w $0343 : ORA.b $59 : ORA.w $035B : ORA.w $0357 : ORA.w $0341
    AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ALPHA
    
    LDA.w $0341 : AND.b #$07 : BEQ .BRANCH_BETA
        LDA.b #$01 : STA.w $0345
        
        LDA.b $4D : CMP.b #$04 : BEQ .BRANCH_GAMMA
            LDA.b #$02 : STA.b $4D
        
        .BRANCH_GAMMA
        
        LDA.w $0026 : STA.w $0340
        
        JSL.l Player_ResetSwimState
        
        STZ.w $0376
        STZ.b $5E
    
    .BRANCH_BETA
    
    LDA.b $59 : AND.b #$07 : BEQ .BRANCH_DELTA
        LDA.b #$09 : STA.b $5C
        
        STZ.b $5A
        
        LDA.b #$01 : STA.b $5B
    
    .BRANCH_DELTA
    
    LDA.b $66 : ASL A : TAY
    
    REP #$20
    
    LDA.w Pool_LinkHop_FindTileToLandOnSouth_offset_y, Y
    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40
    
    LDA.b #$01 : STA.b $46
    
    LDA.b $24 : CMP.b #$F0 : BCC .BRANCH_DELTA
        LDA.b #$00
    
    .BRANCH_DELTA
    
    STA.b $00
    STZ.b $01
    
    REP #$20
    
    LDA.b $20 : SEC : SBC.b $32 : CLC : ADC.b $00 : STA.w $0364 : STA.b $24
    
    SEP #$20
    
    RTS
}

; $038B74-$038B8A JUMP LOCATION
LinkState_HoppingHorizontallyOW:
{
    ; Link mode 0x0C - ????
    LDX.b #$01
    
    LDA.b $28 : BPL .alpha
        LDX.b #$02
    
    .alpha
    
    TXA : ORA.b #$04 : STA.b $67
    
    STZ.b $50
    STZ.b $27
    STZ.w $0351
    
    BRL LinkState_HandlingJump ; (RTS)
}

; $038B8B-$038B9A DATA
Pool_Link_HoppingHorizontally_FindTile_Vertical:
{
    ; $038B8B
    .speed_z
    db $20, $20, $20, $28
    db $30, $38, $40, $48

    ; $038B93
    .speed_x
    db $10, $1C, $1C, $1C
    db $1C, $1C, $1C, $1C
}

; $038B9B-$038C43 LOCAL JUMP LOCATION
Link_HoppingHorizontally_FindTile_Vertical:
{
    LDA.b $21 : STA.b $33
    LDA.b $20 : STA.b $32
    
    SEC : SBC.b $3E : STA.b $30
    
    LDA.b $66 : ASL A : TAY
    
    REP #$20
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Vertical_offset_x, Y
    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    JSR.w TileDetect_Movement_Vertical
    
    LDA.w $0343 : ORA.w $035B : ORA.w $0357 : ORA.w $0341
    
    AND.b #$07 : CMP.b #$07 : BEQ .BRANCH_ALPHA
        LDA.b $33 : STA.b $21
        LDA.b $32 : STA.b $20
        
        LDY.b #$00
        
        LDA.b #$01 : STA.b $46
        
        LDA.b $28 : BPL .BRANCH_BETA
            LDY.b #$FF
            
            EOR.b #$FF : INC A
        
        .BRANCH_BETA
        
        LSR #4 : TAX
        
        LDA.w Pool_Link_HoppingHorizontally_FindTile_Vertical_speed_z, X
        STA.w $0362 : STA.w $0363
        
        LDA.w Pool_Link_HoppingHorizontally_FindTile_Vertical_speed_x, X
        
        CPY.b #$FF : BNE .BRANCH_GAMMA
            EOR.b #$FF : INC A
        
        .BRANCH_GAMMA
        
        STA.b $28
        
        BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA

    LDA.b $66 : ASL A : TAY
    
    REP #$20
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Vertical_offset_y, X
    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40
    
    LDA.b #$01 : STA.b $46
    
    LDA.b $24 : CMP.b #$FF : BNE .BRANCH_EPSILON
        LDA.b #$00
    
    .BRANCH_EPSILON
    
    STA.b $00
    STZ.b $01
    
    REP #$20
    
    LDA.b $20 : SEC : SBC.b $32 : CLC : ADC.b $00 : STA.w $0364 : STA.b $24
    
    SEP #$20
    
    .BRANCH_DELTA
    
    LDA.w $0341 : AND.b #$07 : BEQ Link_SetToDeepWater_return
        LDA.b #$02 : STA.b $4D

    ; Bleeds into the next function.
}
        
; $038C44-$038C58 LOCAL JUMP LOCATION
Link_SetToDeepWater:
{
    LDA.b #$01 : STA.w $0345
        
    LDA.w $0026 : STA.w $0340
        
    JSL.l Player_ResetSwimState
        
    STZ.w $0376
    STZ.b $5E
    
    .return
    
    RTS
}

; $038C59-$038C68 DATA
Pool_LinkState_0F:
{
    ; $038C59
    .offset_x
    dw $FFE8
    dw $0018
    dw $FFE8
    dw $0018

    ; $038C61
    .offset_y
    dw $0020
    dw $0050

    ; $038C65
    .speed_x
    db $10
    db $18

    ; $038C67
    .offset_z
    db $20
    db $50
}

; Link modes 0x0F and 0x10 - ????
; $038C69-$038CEE JUMP LOCATION
LinkState_0F:
{
    LDY.b #$03
    
    LDA.b $28 : BPL .BRANCH_ALPHA
        LDY.b #$02

    .BRANCH_ALPHA

    STY.b $66
    
    STZ.b $50
    STZ.b $27
    STZ.w $0351
    
    LDA.b $46 : BNE .BRANCH_BETA
        LDA.w $0362 : BNE .BRANCH_BETA
            LDA.b $5D : SEC : SBC.b #$0F : ASL #2 : STA.b $00
            
            TYA : AND.b #$FD : ASL A : CLC : ADC.b $00 : TAX
            
            LDA.b $22 : PHA
            LDA.b $23 : PHA
            
            REP #$20
            
            LDA.b $22 : CLC : ADC.w Pool_LinkState_0F_offset_x, X : STA.b $22
            
            SEP #$20
            
            TXA : LSR #2 : TAX
            LDA.w Pool_LinkState_0F_speed_x, X
            
            CPY.b #$02 : BNE .BRANCH_GAMMA
                EOR.b #$FF : INC A

            .BRANCH_GAMMA

            STA.b $28
            
            LDA.b $24 : CMP.b #$FF : BNE .BRANCH_DELTA
                LDA.b #$00

            .BRANCH_DELTA

            CLC : ADC.w Pool_LinkState_0F_offset_z, X : STA.w $0364 : STA.b $24
            
            TXA : ASL A : TAX
            
            REP #$20
            
            LDA.w Pool_LinkState_0F_offset_y, X : CLC : ADC.b $20 : STA.b $20
            
            SEP #$20
            
            LDA.b $20 : STA.b $3E
            LDA.b $21 : STA.b $40
            
            PLA : STA.b $23
            PLA : STA.b $22
            
            LDA.b $1B : BNE .BRANCH_BETA
                LDA.b #$02 : STA.b $EE

    .BRANCH_BETA

    BRL LinkState_HandlingJump
}

; $038CEF-$038D2A DATA
Pool_Link_HoppingHorizontally_FindTile_Horizontal:
{
    ; $038CEF
    .offset_x_a
    dw  -8
    dw   8

    ; $038CF3
    .offset_x_b
    dw -32
    dw  32

    ; $038CF7
    .offset_x_c
    dw -16
    dw  16

    ; $038CFB
    .speed_x
    db $14, $14, $14, $18, $18, $18, $18, $1C
    db $1C, $24, $24, $24, $24, $24, $24, $26
    db $26, $26, $26, $26, $26, $26, $28, $28

    ; $038D13
    .speed_z
    db $14, $14, $14, $14, $14, $14, $14, $18
    db $18, $20, $20, $20, $24, $24, $24, $26
    db $26, $26, $26, $26, $26, $26, $28, $28
}

; $038D2B-$038DC5 LOCAL JUMP LOCATION
Link_HoppingHorizontally_FindTile_Horizontal:
{
    LDA.b $23 : STA.b $33
    LDA.b $22 : STA.b $32
    
    LDX.b #$07

    .BRANCH_GAMMA

        PHX
        PHY
        
        REP #$20
        
        LDA.w Pool_Link_HoppingHorizontally_FindTile_Horizontal_offset_x_a, Y
        CLC : ADC.b $22 : STA.b $22
        
        SEP #$20
        
        LDA.b $66 : ASL A : TAY
        
        JSR.w TileDetect_Movement_Horizontal
        
        PLY
        PLX
        
        LDA.w $0343 : ORA.w $035B : ORA.w $0357 : ORA.w $0341 : ORA.b $59
        
        AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ALPHA
            LDA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_BETA
                LDA.b #$01 : STA.w $0345 : INC A : STA.b $4D
                
                LDA.w $0026 : STA.w $0340
                
                STZ.w $02CB
                STZ.b $5E
                STZ.w $0376
                
                JSR.w Player_ResetSwimCollision
                
                BRA .BRANCH_BETA

        .BRANCH_ALPHA
    DEX : BPL .BRANCH_GAMMA
    
    REP #$20
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Horizontal_offset_x_b, Y : CLC : ADC.b $32 : STA.b $22
    
    SEP #$20

    .BRANCH_BETA

    PHX
    
    REP #$20
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Horizontal_offset_x_c, Y
    CLC : ADC.b $22 : STA.b $22
    
    LDA.b $32 : SEC : SBC.b $22 : BPL .BRANCH_DELTAs
        EOR.w #$FFFF : INC A

    .BRANCH_DELTA

    LSR #3 : TAX
    
    SEP #$20
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Horizontal_speed_x, X
    CPY.b #$02 : BEQ .BRANCH_EPSILON
        EOR.b #$FF : INC A

    .BRANCH_EPSILON

    STA.b $28
    
    LDA.w Pool_Link_HoppingHorizontally_FindTile_Horizontal_speed_z, X
    STA.w $0362 : STA.w $0363
    
    PLX
    
    RTS
}

; Link mode 0x0D - ????
; $038DC6-$038DFC JUMP LOCATION
LinkState_HoppingDiagonallyUpOW:
{
    STZ.w $0315
    
    LDA.b #$02 : STA.b $00
    
    JSR.w Link_HandleChangeInZVelocity_preset
    JSL.l LinkHop_FindArbitraryLandingSpot
    
    LDA.b $24 : BPL .exit
        JSR.w Link_SplashUponLanding
        
        LDA.b $5D : CMP.b #$04 : BEQ .swimming
            LDA.w $0345 : BNE .BRANCH_BETA
                LDA.b #$21 : JSR.w Player_DoSfx2

            .BRANCH_BETA
        .swimming

        STZ.w $037B
        STZ.b $4D

        LDA.b #$FF : STA.b $29 : STA.b $24 : STA.b $25 : STA.b $46 : STA.b $50

    .exit

    RTS
}

; $038DFD-$038E14 DATA
LinkState_HoppingDiagonallyDownOW_speed_x:
{
    db $04, $04, $04, $0A, $0A, $0A, $0B, $12
    db $12, $12, $14, $14, $14, $14, $16, $16
    db $1A, $1A, $1A, $1A, $1C, $1C, $1C, $1C
}

; Link Submode 0x0E
; $038E15-$038E6C JUMP LOCATION
LinkState_HoppingDiagonallyDownOW:
{
    LDY.b #$03
    
    LDA.b $28 : BPL .horizontalRecoilPresent
        LDY.b #$02

    .horizontalRecoilPresent

    STY.b $66
    
    STZ.b $50
    STZ.b $27
    STZ.w $0351
    
    LDA.b $46 : BNE .cantMove
        LDA.w $0362 : BNE .BRANCH_BETA
            LDA.b #$01 : STA.b $66
            
            PHY
            
            LDA.b $22 : PHA
            LDA.b $23 : PHA
            
            LDA.b #$20 : JSR.w Player_DoSfx2
            
            JSR.w LinkHop_FindLandingSpotDiagonallyDown
            
            PLA : STA.b $23
            PLA : STA.b $22
            
            PLX
            
            REP #$20
            
            LDA.b $20 : SEC : SBC.b $32 : LSR #3 : TAY
            
            SEP #$20
            
            LDA.w .speed_x, Y
            
            CPX.b #$02 : BNE .BRANCH_GAMMA
                EOR.b #$FF : INC A

            .BRANCH_GAMMA

            STA.b $28
            
            LDA.b $1B : BNE .indoors
                LDA.b #$02 : STA.b $EE

            .indoors
        .BRANCH_BETA
    .cantMove

    BRL LinkState_HandlingJump
}

; $038E6D
Pool_LinkHop_FindLandingSpotDiagonallyDown:
{
    ; $038E6D
    .offset_x
    db $F8, $FF, $08, $00

    ; $038E71
    .offset_y
    db $F7, $FF, $09, $00

    ; $038E75
    .offset_y_2
    db $E8, $FF, $18, $00

    ; $038E79
    .detection_masks
    db $06, $03
}

; $038E7B-$038F1C LOCAL JUMP LOCATION
LinkHop_FindLandingSpotDiagonallyDown:
{
    LDA.b $21 : STA.b $33
    LDA.b $20 : STA.b $32
    
    SEC : SBC.b $3E : STA.b $30

    .check_next

        LDY.b #$00
        
        LDA.b $28
        
        BMI 
        
        LDY.b #$02

        .BRANCH_ALPHA

        PHY
        
        REP #$20
        
        LDA.w Pool_LinkHop_FindLandingSpotDiagonallyDown_offset_x, Y
        CLC : ADC.b $22 : STA.b $22
        
        LDA.b $66 : AND.w #$00FF : ASL A : TAY
        
        LDA.w Pool_LinkHop_FindLandingSpotDiagonallyDown_offset_y, Y
        CLC : ADC.b $20 : STA.b $20
        
        SEP #$20
        
        JSR.w TileDetect_Movement_Vertical
        
        PLY : TYA : LSR A : TAY
        
        LDA.w Pool_LinkHop_FindLandingSpotDiagonallyDown_detection_masks, Y
        STA.b $72
        
        LDA.w $0343 : ORA.w $035B : ORA.w $0357 : ORA.w $0341
    AND.b $72 : CMP.b $72 : BNE .check_next
    
    LDA.w $0341 : AND.b $72 : BEQ .BRANCH_GAMMA
        LDA.b #$01 : STA.w $0345
        
        LDA.b #$02 : STA.b $45
        
        LDA.w $0026 : STA.w $0340
        
        JSL.l Player_ResetSwimState
        
        STZ.b $5E
        STZ.w $0376

    .BRANCH_GAMMA

    LDA.b $66 : ASL A : TAY
    
    REP #$20
    
    LDA.w Pool_LinkHop_FindLandingSpotDiagonallyDown_offset_y_2, Y
    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40
    
    LDA.b #$01 : STA.b $46
    
    LDA.b $24 : STA.b $00
    
    STZ.b $01
    
    REP #$20
    
    LDA.b $20 : SEC : SBC.b $32 : CLC : ADC.b $00 : STA.w $0364 : STA.b $24
    
    SEP #$20
    
    RTS
}

; $038F1D-$038F60 LOCAL JUMP LOCATION
Link_SplashUponLanding:
{
    PHX : PHY
    
    LDA.w $02E0 : BEQ .notBunny
        LDA.w $0345 : BEQ .notSwimming
            LDA.b #$15
            LDY.b #$00
            
            JSL.l AddTransitionSplash  ; $0498FC IN ROM
            
            PLY : PLX
            
            BRL LinkState_Bunny_BRANCH_GAMMA
        
        .notSwimming
        
        LDX.b #$17
        
        ; Change to permabunny because we don't have a moon pearl.
        LDA.l $7EF357 : BEQ .changeLinkMode
            LDX.b #$1C
            
            ; Otherwise assume that he's a temp bunny.
            BRA .changeLinkMode
    
    .notBunny
    
    LDX.b #$00
    
    ; Not a bunny and not swimming, must be in normal mode.
    LDA.w $0345 : BEQ .changeLinkMode
        ; Check if Link is recoiling from something that hit him.
        LDA.b $5D : CMP.b #$06 : BEQ .notRecoiling
            LDA.b #$15
            LDY.b #$00
            
            JSL.l AddTransitionSplash ; $0498FC IN ROM
        
        .notRecoiling
        
        JSR.w Link_ForceUnequipCape_quietly
        
        LDX.b #$04
    
    .changeLinkMode
    
    STX.b $5D
    
    PLY
    PLX
    
    RTS
}

; ==============================================================================

; $038F61-$038F64 DATA
LinkDirections26:
{
    db $08
    db $04
    db $02
    db $01
}

; $038F65-$038F67 DATA
LinkDashSFXMasks:
{
    db $07, $0F, $0F
}

; $038F68-$038F76 DATA
FollowerReactionToDashing:
{
    db $FF ; 0x00 - No follower
    db $00 ; 0x01 - Zelda
    db $02 ; 0x02 - Old man that stops following you
    db $00 ; 0x03 - Unused old man
    db $00 ; 0x04 - Normal old man
    db $00 ; 0x05 - Zelda rescue telepathy
    db $00 ; 0x06 - Blind maiden
    db $00 ; 0x07 - Frogsmith
    db $00 ; 0x08 - Smithy
    db $00 ; 0x09 - Locksmith
    db $00 ; 0x0A - Kiki
    db $00 ; 0x0B - Unused old man
    db $00 ; 0x0C - Purple chest
    db $00 ; 0x0D - Super bomb
    db $00 ; 0x0E - Master Sword telepathy
}

; $038F77-$038F85 DATA
FollowerDashReplacement:
{
    db $FF ; 0x00 - No follower
    db $00 ; 0x01 - Zelda
    db $03 ; 0x02 - Old man that stops following you ⇒ FOLLOWER 03
    db $00 ; 0x03 - Unused old man
    db $00 ; 0x04 - Normal old man
    db $00 ; 0x05 - Zelda rescue telepathy
    db $00 ; 0x06 - Blind maiden
    db $00 ; 0x07 - Frogsmith
    db $00 ; 0x08 - Smithy
    db $00 ; 0x09 - Locksmith
    db $00 ; 0x0A - Kiki
    db $00 ; 0x0B - Unused old man
    db $00 ; 0x0C - Purple chest
    db $00 ; 0x0D - Super bomb
    db $00 ; 0x0E - Master Sword telepathy
}

; ==============================================================================

; MODE 0x11 FALLING OFF A LEDGE / Dashing
; $038F86-$03915D LONG BRANCH LOCATION
LinkState_Dashing:
{
    ; Buffers a number of important variables.
    JSR.w CacheCameraPropertiesIfOutdoors
    JSR.w Link_HandleBunnyTransformation : BCC .BRANCH_ALPHA
        LDA.b $5D : CMP.b #$17 : BNE .BRANCH_BETA
            BRL LinkState_Bunny ; PERMABUNNY MODE
        
        .BRANCH_BETA
        
        RTS
    
    .BRANCH_ALPHA
    
    ; Is Link dashing?
    LDA.w $0372 : BNE .BRANCH_GAMMA
        STZ.w $037B
        STZ.w $0374
        STZ.b $5E
        
        LDA.b #$00 : STA.b $5D
        
        STZ.b $50
        
        BRL .BRANCH_ULTIMA
    
    .BRANCH_GAMMA
    
    BIT.b $3A : BPL .BRANCH_DELTA
        LDA.b $3C : CMP.b #$09 : BCC .BRANCH_DELTA
            LDA.b #$09 : STA.b $3C

    .BRANCH_DELTA

    STZ.w $02CA
    
    ; Branch if link has no special status.
    LDA.b $4D : BEQ .BRANCH_EPSILON
        STZ.w $037B
        STZ.w $0374
        STZ.b $5E
        STZ.b $50
        STZ.w $0372
        STZ.b $48
        
        LDA.w $0360 : BEQ .BRANCH_ZETA
            LDA.b $55 : BEQ .BRANCH_THETA
                JSR.w Link_ForceUnequipCape_quietly
            
            .BRANCH_THETA
            
            JSR.w Link_ResetSwordAndItemUsage
            
            LDA.b #$01 : STA.w $037B
            
            STZ.w $0300
            
            LDA.b #$02 : STA.b $3D
            
            STZ.b $2E
            
            LDA.b $67 : AND.b #$F0 : STA.b $67
            
            LDA.b #$2B : JSR.w Player_DoSfx3
            
            LDA.b #$07 : STA.b $5D
            
            BRL Player_Electrocution
        
        .BRANCH_ZETA
        
        ; Go to recoil mode.
        LDA.b #$02 : STA.b $5D
        
        BRL LinkState_Recoil ; GO TO RECOIL MODE.
    
    .BRANCH_EPSILON
    
    ; Check the dash countdown timer.
    LDA.w $0374 : LSR #4 : TAX
    
    LDA.w $0374 : BNE .BRANCH_IOTA
        LDA.b $4F : DEC.b $4F
    
    .BRANCH_IOTA
    
    AND.w LinkDashSFXMasks, X : BNE .BRANCH_KAPPA
        LDA.b #$23 : JSR.w Player_DoSfx2
    
    .BRANCH_KAPPA
    
    DEC.w $0374 : BPL .BRANCH_LAMBDA
        STZ.w $0374
        
        ; If the current tagalong is the (not used) alternate old man, change
        ; it to a Tagalong that is waiting for the player to come back (0x03).
        LDA.l $7EF3CC : TAX : CMP.w FollowerReactionToDashing, X : BNE .BRANCH_MU
            LDA.w FollowerDashReplacement, X : STA.l $7EF3CC
        
        .BRANCH_MU
        
        BRL .BRANCH_SIGMA
    
    .BRANCH_LAMBDA
    
    LDA.b #$00 : STA.b $4F
    
    BIT.b $F2 : BMI .BRANCH_NU
        STZ.b $2E
        STZ.w $0374
        STZ.b $5E
        
        LDA.b #$00 : STA.b $5D
        
        STZ.w $0372
        
        BIT.b $3A : BMI .BRANCH_XI
            STZ.b $50
        
        .BRANCH_XI
        
        BRL .BRANCH_ULTIMA
    
    .BRANCH_NU
    
    LDY.b #$00
    LDA.b #$1E
    
    JSL.l AddDashingDust_notYetMoving
    
    STZ.b $30
    STZ.b $31
    
    LDA.b #$40 : STA.w $02F1
    
    LDA.b #$10 : STA.b $5E
    
    LDA.b $3A : AND.b #$80 : BNE .BRANCH_OMICRON
        LDA.b $6C : BNE .BRANCH_OMICRON
            LDA.b $F0 : AND.b #$0F : BNE .BRANCH_PI
    
    .BRANCH_OMICRON
    
    LDA.b $2F : LSR A : TAX
    
    LDA.w LinkDirections26, X
    
    .BRANCH_PI
    
    STA.b $26 : STA.b $67 : STA.w $0340
    
    STZ.b $6B
    
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    LDA.b $20 : STA.b $00 : STA.b $3E
    LDA.b $22 : STA.b $01 : STA.b $3F
    LDA.b $21 : STA.b $02 : STA.b $40
    LDA.b $23 : STA.b $03 : STA.b $41
    
    JSR.w Link_HandleMovingFloor
    JSR.w Link_ApplyConveyor
    
    LDA.w $02F5 : BEQ .BRANCH_RHO
        JSL.l Link_HandleVelocityAndSandDrag_long
    
    .BRANCH_RHO
    
    LDA.b $20 : SEC : SBC.b $3E : STA.b $30
    LDA.b $22 : SEC : SBC.b $3F : STA.b $31
    
    JSR.w Link_HandleCardinalCollision
    JSR.w HandleIndoorCameraAndDoors
    
    BRL .BRANCH_ULTIMA
    
    .BRANCH_SIGMA
    
    LDA.b $2E : CMP.b #$06 : BCC .BRANCH_TAU
        STZ.b $2E
    
    .BRANCH_TAU
    
    DEC.w $02F1 : LDA.w $02F1 : CMP.b #$20 : BCS .BRANCH_UPSILON
        LDA.b #$20 : STA.w $02F1
    
    .BRANCH_UPSILON
    
    LDY.b #$00
    LDA.b #$1E
    
    JSL.l AddDashingDust
    
    STZ.b $79
    
    ; LINK'S SWORD VALUE
    LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .BRANCH_PHI
        LDY.b #$07
        
        JSR.w TileDetect_MainHandler
    
    .BRANCH_PHI
    
    LDA.l $7EF3C5 : BEQ .BRANCH_CHI
        LDA.b #$80 : TSB.b $3A
        LDA.b #$09 : STA.b $3C

    .BRANCH_CHI

    STZ.b $46
    
    LDA.b $2F : LSR A : TAX
    
    LDA.w LinkDirections26, X : STA.b $00
    
    LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_PSI
    CMP.b $00              : BEQ .BRANCH_PSI
        ; Come out of the dashing submode.
        LDA.b #$12 : STA.b $5D
        
        LDA.b $3A : AND.b #$7F : STA.b $3A
        
        STZ.b $3C
        STZ.b $3D
        
        BRL LinkState_ExitingDash
    
    .BRANCH_PSI
    
    LDA.b $49 : AND.b #$0F : BNE .BRANCH_OMEGA
        LDA.b $2F : LSR A : TAX
        
        LDA.w LinkDirections26, X
    
    .BRANCH_OMEGA
    
    STA.b $67 : STA.b $26
    
    JSR.w Link_HandleDiagonalCollision
    JSL.l Link_HandleVelocity
    JSR.w Link_HandleCardinalCollision
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    STZ.w $0302
    
    JSR.w HandleIndoorCameraAndDoors
    
    .BRANCH_ULTIMA
    
    RTS
}
    
; $03915E-$039194 LOCAL JUMP LOCATION
LinkState_ExitingDash:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    
    LDA.b $F0 : AND.b #$0F : BNE .BRANCH_ALPHA2
        LDA.w $0374 : CMP.b #$10 : BCC .BRANCH_BETA2
    
    .BRANCH_ALPHA2
    
    STZ.w $0374
    STZ.b $5E
    
    LDA.b #$00 : STA.b $5D
    
    STZ.w $0372
    STZ.w $032B
    
    LDA.b $3C : CMP.b #$09 : BCS .BRANCH_GAMMA2
        STZ.b $50
        
        BRA .BRANCH_GAMMA2
        
        .BRANCH_BETA2
        
        LDA.w $0374 : CLC : ADC.b #$01 : STA.w $0374
    
    .BRANCH_GAMMA2
    
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    RTS
}

; ==============================================================================

; $039195-$0391B8 LOCAL JUMP LOCATION
Player_HaltDashAttack:
{
    ; Routine essentially stops all dashing activities, usually due to some
    ; specific cause, like getting too near to water or a sprite.
    
    ; Is Link going to collide?
    LDA.w $0372 : BEQ .notDashing
        PHX
        
        LDX.b #$04
        
        .nextObjectSlot
        
            ; Is Link using the pegasus boots?
            LDA.w $0C4A, X : CMP.b #$1E : BNE .notPegasusBootDust
                STZ.w $0C4A, X
            
            .notPegasusBootDust
        DEX : BPL .nextObjectSlot
        
        PLX
        
        STZ.w $0374 ; Reset dash timer.
        STZ.b $5E   ; Reset speed to zero.
        STZ.w $0372 ; Reset dash collision variable (means Link will bounce if
                    ; he hits a wall).
        STZ.b $50   ; Allow Link to change direction again.
        STZ.w $032B ; ....?
    
    .notDashing
    
    RTS
}

; ==============================================================================

; $0391B9-$0391BC LONG JUMP LOCATION
Player_HaltDashAttackLong:
{
    JSR.w Player_HaltDashAttack
    
    RTL
}

; ==============================================================================

; $0391BD-$0391CC DATA
RepelBonkSpeedY:
{
    ; $0391BD
    .y_recoil
    db $18, $E8, $00, $00
    
    ; $0391C1
    .x_recoil
    db $00, $00, $18, $E8
    
    ; $0391C5
    .TileReboundAFlaggingY
    db 1, 0, 0, 0
    
    ; $0391C9
    .TileReboundAFlaggingX
    db 0, 0, 1, 0
}

; $0391CD-$0391EC DATA
IceRepelAccel:
{
    ; $0391CD
    .Y
    dw $0180, $0180, $0000, $0000
    dw $0100, $0100, $0000, $0000

    ; $0391DD
    .X
    dw $0000, $0000, $0180, $0180
    dw $0000, $0000, $0100, $0100
}

; $0391ED-$0391F0 DATA
RepelDirectionMasks:
{
    db $08, $04, $02, $01
}
    
; $0391F1-$039221 LOCAL JUMP LOCATION
RepelDash:
{
    LDA.w $0372 : BEQ .no_dash_bounce
        LDA.w $02F1 : CMP.b #$40 : BNE .dash_hasnt_just_begun
    
    .no_dash_bounce
    
    BRL .return
    
    .dash_hasnt_just_begun
    
    JSL.l Player_ResetSwimState
    
    LDY.b #$01
    LDA.b #$1D
    
    JSL.l AddDashTremor
    JSL.l Player_ApplyRumbleToSprites
    
    LDA.w $012F : AND.b #$3F
    
    CMP.b #$1B : BEQ .BRANCH_GAMMA
    CMP.b #$32 : BEQ .BRANCH_GAMMA
        LDA.b #$03 : JSR.w Player_DoSfx3
    
    .BRANCH_GAMMA
}

; $039222-$039290 LONG BRANCH LOCATION
LinkApplyTileRebound:
{
    LDX.b $66
    
    ; Recoil in the opposite direction from the dash.
    LDA.w RepelBonkSpeedY_y_recoil, X : STA.b $27
    
    LDA.w RepelBonkSpeedY_x_recoil, X : STA.b $28
    
    LDA.b #$18 : STA.b $46
    
    LDA.b #$24 : STA.b $29 : STA.w $02C7
    
    LDA.w $034A : BEQ .BRANCH_DELTA
        LDA.w RepelDirectionMasks, X : STA.w $0340 : STA.b $67
        
        LDA.w RepelBonkSpeedY_TileReboundAFlaggingY, X : STA.w $0338
        LDA.w RepelBonkSpeedY_TileReboundAFlaggingX, X : STA.w $033A
        
        PHX
        
        LDA.w $034A : DEC A : ASL #3 : STA.b $08
        
        TXA : ASL A : CLC : ADC.b $08 : TAX
        
        REP #$20
        
        LDA.w IceRepelAccel_Y, X : STA.w $033C
        LDA.w IceRepelAccel_X, X : STA.w $033E
        
        SEP #$20
        
        PLX
    
    .BRANCH_DELTA
    
    LDA.b #$01 : STA.b $4D : STA.w $02F8
    
    STZ.b $74
    STZ.w $0360
    STZ.b $5E
    STZ.b $50
    STZ.b $6B
    
    TXA : AND.b #$02 : BNE .left_or_right_recoil
        STZ.b $31
        
        BRA .return
    
    .left_or_right_recoil
    
    STZ.b $30
    
    .return
    
    RTS
}

; ==============================================================================

; $039291-$03929F LONG JUMP LOCATION
Sprite_RepelDashAttackLong:
{
    PHB : PHK : PLB
    
    PHX
    
    ; Update the last direction the player moved in.
    LDA.b $2F : LSR A : STA.b $66
    
    JSR.w RepelDash
    
    PLX : PLB
    
    RTL
}

; ==============================================================================

; $0392A0-$0392B8 LOCAL JUMP LOCATION
Flag67WithDirections:
{
    STZ.b $67
    
    LDY.b #$00
    
    LDA.b $27 : BEQ .BRANCH_ALPHA  BMI .BRANCH_BETA
        LDY.b #$01
    
    .BRANCH_BETA
    
    JSR.w Flag67WithDirections_flag_one
    
    .BRANCH_ALPHA
    
    LDY.b #$02
    
    LDA.b $28 : BEQ Flag67WithDirections_flag_one_return  BMI .flag_one
        LDY.b #$03
    
    .flag_one

    ; Bleeds into the next function.
}

; $0392B9-$0392BE LOCAL JUMP LOCATION
Flag67WithDirections_flag_one:
{
    LDA.w RepelDirectionMasks, Y : TSB.b $67
    
    ; $0392BE ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $0392BF-$0392D2 DATA
PitFall_Flags:
{
    ; $0392BF
    .ForAnimation
    db $0A, $09, $06, $05, $08, $04, $02, $01

    ; $0392C7
    .ForDirection
    db $05, $06, $09, $0A, $04, $08, $01, $02

    ; $0392CF
    .ForDetection
    db $0C, $03, $0A, $05
}

; Link mode 0x01 - Link falling into a hole
; $0392D3-$03935A JUMP LOCATION
LinkState_Pits:
{
    STZ.b $67
    
    LDA.w $0302 : BEQ .BRANCH_ALPHA
        INC.w $02CA : LDA.w $02CA : CMP.b #$20 : BNE .BRANCH_ALPHA
            ; Ensures the next time around that this .
            LDA.b #$1F : STA.w $02CA
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.w $0372 : BEQ .BRANCH_GAMMA
        LDA.w $0374 : BEQ .BRANCH_DELTA
            BRL LinkState_Dashing
        
        .BRANCH_DELTA
        
                ; Check if any directional buttons are being pressed on the
                ; Joypad.
                LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_BETA
                    AND.b $67 : BNE .BRANCH_BETA
                        JSR.w Player_HaltDashAttack
            
            .BRANCH_GAMMA
            
            LDA.b $4D : CMP.b #$01 : BEQ .BRANCH_BETA
                LDA.b $F0 : AND.b #$0F : STA.b $67
            
            .BRANCH_BETA
            
            LDY.b #$04
            
            JSR.w TileDetect_MainHandler
    LDA.b $59 : AND.b #$01 : BNE .BRANCH_DELTA
    
    LDA.w $0372 : BEQ .BRANCH_EPSILON
        BRL LinkState_Dashing
    
    .BRANCH_EPSILON
    
    STZ.b $5E
    
    JSR.w Player_HaltDashAttack
    
    LDA.b $3A : AND.b #$80 : BNE .BRANCH_ZETA
        LDA.b $50 : AND.b #$FE : STA.b $50
    
    .BRANCH_ZETA
    
    STZ.b $5B
    
    LDY.b #$00
    
    LDA.w $02E0 : BEQ .BRANCH_THETA
        LDY.b #$17
        
        LDA.l $7EF357 : BEQ .BRANCH_THETA
            LDY.b #$1C
    
    .BRANCH_THETA
    
    STY.b $5D
    
    CPY.b #$17 : BEQ .BRANCH_IOTA
    CPY.b #$1C : BEQ .BRANCH_KAPPA
        BRL LinkState_Default ; NORMAL MODE
    
    .BRANCH_IOTA
    
    BRL LinkState_Bunny ; PERMABUNNY MODE
    
    .BRANCH_KAPPA ; TEMP BUNNY MODE
    
    BRL LinkState_TemporaryBunny ; TEMPBUNNY MODE
    
    .BRANCH_DELTA

    ; Bleeds into the next function.
}

; $03935B-$0394F0 LOCAL JUMP LOCATION
Link_HandleFallingInPit:
{
    JSR.w Player_TileDetectNearby
    
    LDA.b #$04 : STA.b $5E
    
    LDA.b $59 : AND.b #$0F : BNE .BRANCH_LAMBDA
        STZ.b $5B
        STZ.b $5E
        
        LDY.b #$00
        
        LDA.w $02E0 : BEQ .BRANCH_MU
            LDY.b #$17
            
            LDA.l $7EF357 : BEQ .BRANCH_MU
                LDY.b #$1C
        
        .BRANCH_MU
        
        STY.b $5D
        
        JSR.w Player_HaltDashAttack
        
        LDA.b $3A : AND.b #$80 : BNE .BRANCH_NU
            LDA.b $50 : AND.b #$FE : STA.b $50
        
        .BRANCH_NU
        
        BRL .BRANCH_ALTIMA
    
    .BRANCH_LAMBDA
    
    CMP.b #$0F : BNE .BRANCH_XI
        LDA.b $5B : CMP.b #$02 : BEQ .BRANCH_OMICRON
            LDA.l $7EF357 : BEQ .BRANCH_PI
                STZ.w $03F7
                STZ.b $56
                STZ.w $02E0
                STZ.w $03F5
                STZ.w $03F6
            
            .BRANCH_PI
            
            STZ.b $67
            STZ.b $00
            
            LDA.b #$02 : STA.b $5B
            
            LDA.b #$01 : STA.w $037B
            
            STZ.b $3A
            STZ.b $3C
            STZ.w $0301
            STZ.w $037A
            STZ.b $46
            STZ.b $4D
            
            LDA.b #$1F : JSR.w Player_DoSfx3
        
        .BRANCH_OMICRON
        
        BRA .BRANCH_RHO
    
    .BRANCH_XI
    
    LDX.b #$03
    
    .BRANCH_UPSILON
    
        LDA.b $59 : AND.b #$0F : CMP.w PitFall_Flags_ForDetection, X : BNE .BRANCH_SIGMA
            TXA : CLC : ADC.b #$04 : TAX
            
            BRA .BRANCH_TAU
        
        .BRANCH_SIGMA
    DEX : BPL .BRANCH_UPSILON
    
    LDX.b #$03
    
    LDA.b $59
    
    .BRANCH_PHI
    
        LSR A : BCS .BRANCH_TAU
    DEX : BPL .BRANCH_PHI
    
    .BRANCH_TAU
    
    STX.w $02C9
    
    LDA.b $67 : AND.w PitFall_Flags_ForDirection, X : BEQ .BRANCH_CHI
        LDA.b $67 : STA.b $26
        
        LDA.b #$06 : STA.b $5E
        
        BRA .BRANCH_PSI
    
    .BRANCH_CHI
    
    LDA.b $67 : STA.b $00
    
    LDX.w $02C9
    
    LDA.w PitFall_Flags_ForAnimation, X : TSB.b $67
    
    LDA.b $00 : BEQ .BRANCH_OMEGA
        .BRANCH_PSI
        
        JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    .BRANCH_OMEGA
    
    JSR.w Link_HandleDiagonalCollision
    JSL.l Link_HandleVelocity
    JSR.w Link_HandleCardinalCollision
    JSL.l ApplyLinksMovementToCamera
    
    .BRANCH_ALTIMA
    
            RTS
            
            .BRANCH_RHO
            
            STZ.b $50
            STZ.b $46
            STZ.b $24
            STZ.b $25
            STZ.b $29
            STZ.b $4D
            STZ.w $0373
            STZ.w $02E1
            
            JSR.w Link_ForceUnequipCape_quietly
            
            INC.w $037B
        DEC.b $5C : BPL .BRANCH_ALTIMA
        
        INC.b $5A : LDX.b $5A
        
        LDA.b #$09 : STA.b $5C
        
        LDA.l $7EF3CC : CMP.b #$0D : BEQ .BRANCH_ULTIMA
            CPX.b #$01 : BNE .BRANCH_ULTIMA
                STX.w $02F9
        
        .BRANCH_ULTIMA
    CPX.b #$06 : BNE .BRANCH_ALTIMA
    
    JSR.w Player_HaltDashAttack
    
    LDY.b #$07 : STY.b $11
    
    LDA.b #$06 : STA.b $5A
    LDA.b #$03 : STA.b $5B
    LDA.b #$0C : STA.b $4B
    LDA.b #$10 : STA.b $57
    
    LDA.b $20 : SEC : SBC.b $E8 : STA.b $00
    
    STZ.b $01
    STZ.w $0308
    STZ.w $0309
    STZ.w $0376
    STZ.w $030B
    
    REP #$30
    
    LDA.b $1B : AND.w #$00FF : BEQ .BRANCH_LATIMUS
        LDA.b $00 : PHA
        
        SEP #$30
        
        LDA.b $A0 : STA.b $A2
        
        JSL.l Dungeon_SaveRoomQuadrantData
        
        REP #$30
        
        PLA : STA.b $00
        
        LDX.w #$0070
        
        LDA.b $A0
        
        .BRANCH_BETA2
        
            CMP.l $00990C, X : BEQ HandleLayerOfDestination_BRANCH_ALPHA2
        DEX #2 : BPL .BRANCH_BETA2
    
    .BRANCH_LATIMUS
    
    SEP #$20
    
    LDA.b $A0 : STA.b $A2
    
    LDA.l $7EC000 : STA.b $A0
    
    REP #$20
    
    LDA.w #$0010 : CLC : ADC.b $00 : STA.b $00
    
    LDA.b $20 : STA.b $51 : SEC : SBC.b $00 : STA.b $20
    
    SEP #$30
    
    LDA.b $1B : BNE .BRANCH_GAMMA2
        LDA.b $8A : CMP.b #$05 : BNE .delta2
            JSL.l Overworld_PitDamage
            
            RTS
        
        .delta2
        
        JSL.l Overworld_Hole
        
        LDA.b #$11 : STA.b $10
        
        STZ.b $11
        STZ.b $B0
        
        RTS
    
    .BRANCH_GAMMA2

    ; Bleeds into the next funtion.
}

; Hole / teleporter plane
; $0394F1-$03951D LOCAL JUMP LOCATION
HandleLayerOfDestination:
{
    LDX.w $063C
    
    LDA.l $01C31F, X : STA.w $0476
    
    LDA.l $01C322, X : STA.b $EE
    
    RTS
    
    .BRANCH_ALPHA2
    
    SEP #$30
    
    ; Return Link from the damaging pit.
    LDA.b #$14 : STA.b $11
    
    ; Subtract one heart from Link's HP. Could replace this with a BPL... maybe.
    LDA.l $7EF36D : SEC : SBC.b #$08 : STA.l $7EF36D : CMP.b #$A8 : BCC .notDead
        ; Instakill if Link's HP is >= 0xA8. Kinda counter intuitive, but
        ; whatever.
        LDA.b #$00 : STA.l $7EF36D
    
    .notDead
    
    RTS
}

; ==============================================================================

; UNUSED: Can't seem to find any reference to it.
; $03951E-$03951F DATA
UNREACHABLE_07951E:
{
    db $21, $24
}

; ==============================================================================

; $039520-$039634 LONG JUMP LOCATION
HandleUnderworldLandingFromPit:
{
    PHB : PHK : PLB
    
    JSL.l PlayerOam_Main
    
    REP #$20
    
    LDA.b $22 : STA.w $0FC2
    
    LDA.b $20 : STA.w $0FC4
    
    SEP #$20
    
    LDA.b $11 : CMP.b #$07 : BNE .BRANCH_ALPHA
        STZ.b $4B
    
    .BRANCH_ALPHA
    
    LDA.b $1A : AND.b #$03 : BNE .BRANCH_BETA
        INC.b $5A : LDA.b $5A : CMP.b #$0A : BNE .BRANCH_BETA
            LDA.b #$06 : STA.b $5A
    
    .BRANCH_BETA
    
    LDA.b #$04 : STA.b $67
    
    JSL.l Link_HandleVelocity
    
    REP #$20
    
    LDA.b $20 : BPL .BRANCH_GAMMA
        LDA.b $51 : BMI .BRANCH_GAMMA
            LDA.b $20 : EOR.w #-1 : INC A : CLC : ADC.b $51 : BMI .BRANCH_DELTA
                BRL .BRANCH_EPSILON
    
    .BRANCH_GAMMA
    
    LDA.b $51 : CMP.b $20 : BCC .BRANCH_DELTA
        BRL .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    LDA.b $51 : STA.b $20
    
    SEP #$20
    
    STZ.b $2E
    STZ.b $57
    STZ.b $5A
    STZ.b $5B
    STZ.b $5E
    STZ.b $B0
    STZ.b $11
    STZ.w $037B
    
    LDA.l $7EF3CC : BEQ .BRANCH_ZETA
    CMP.b #$03 : BEQ .BRANCH_ZETA
        STZ.w $02F9
        
        CMP.b #$0D : BNE .BRANCH_THETA
            LDA.b #$00
            STA.l $7EF3CC : STA.w $04B4 : STA.w $04B5 : STA.l $7EF3D3
            
            BRA .BRANCH_ZETA
        
        .BRANCH_THETA
        
        JSL.l Tagalong_Init
    
    .BRANCH_ZETA
    
    LDY.b #$00
    
    JSR.w TileDetect_MainHandler
    
    LDA.w $0359 : AND.b #$01 : BEQ .BRANCH_IOTA
        LDA.b #$24 : JSR.w Player_DoSfx2
    
    .BRANCH_IOTA
    
    JSR.w Player_TileDetectNearby
    
    LDA.w $012E : AND.b #$3F : CMP.b #$24 : BEQ .BRANCH_KAPPA
        LDA.b #$21 : JSR.w Player_DoSfx2
    
    .BRANCH_KAPPA
    
    LDA.b $AD : CMP.b #$02 : BNE .BRANCH_LAMBDA
        LDA.w $034C : AND.b #$0F : BEQ .BRANCH_LAMBDA
            LDA.b #$03 : STA.w $0322
    
    .BRANCH_LAMBDA
    
    LDA.w $0341 : AND.b #$0F : CMP.b #$0F : BNE .BRANCH_MU
        LDA.b #$01 : STA.w $0345
        
        LDA.b $26 : STA.w $0340
        
        JSL.l Player_ResetSwimState
        
        LDA.b #$01 : STA.b $EE
        
        LDA.b #$15
        LDY.b #$00
        
        JSL.l AddTransitionSplash ; $0498FC IN ROM
        
        LDA.b #$04 : STA.b $5D
        
        JSR.w Link_ForceUnequipCape_quietly
        
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        STZ.b $5E
        
        BRA .BRANCH_EPSILON
    
    .BRANCH_MU
    
    LDA.b $59 : AND.b #$0F : BNE .BRANCH_NU
        LDA.b #$00 : STA.b $5D
        
        BRA .BRANCH_EPSILON
    
    .BRANCH_NU
    
    ; Ahhhhhhh fallllllling into a hoooooole.
    LDA.b #$01 : STA.b $5D
    
    .BRANCH_EPSILON
    
    SEP #$20
    
    PLB
    
    RTL
}

; $039635-$039638 DATA
LinkSwimming_anim_offset:
{
    dw $0002
    dw $0001
}

; $039639-$03963A DATA
MaxSwimAcceleration:
{
    dw $00F0
}

; MODE 4 SWIMMING
; $03963B-$039714 JUMP LOCATION
LinkState_Swimming:
{
    LDA.b $4D : BEQ .BRANCH_ALPHA
        LDA.b #$02 : STA.b $5D
        
        STZ.b $25
        
        JSR.w Player_ResetSwimCollision
        
        STZ.w $032A
        STZ.w $034F
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        BRL LinkState_Recoil ; GO TO RECOIL MODE
    
    .BRANCH_ALPHA
    
    STZ.b $3A
    STZ.b $3C
    STZ.b $3D
    STZ.b $79
    STZ.w $0308
    STZ.w $0309
    
    LDA.l $7EF356 : BNE .hasFlippers
        RTS
    
    .hasFlippers
    
    LDA.w $033C : ORA.w $033D : ORA.w $033E : ORA.w $033F : BNE .BRANCH_GAMMA
        LDA.w $032B : CMP.b #$02 : BEQ .BRANCH_DELTA
            LDA.w $032D : CMP.b #$02 : BEQ .BRANCH_DELTA
                JSR.w Player_ResetSwimCollision
        
        .BRANCH_DELTA
        
        LDA.b $2E : AND.b #$01 : STA.b $2E
        
        INC.b $2D : LDA.b $2D : CMP.b #$10 : BCC .BRANCH_EPSILON
            STZ.b $2D
            STZ.w $02CC
            
            LDA.b $2E : AND.b #$01 : EOR.b #$01 : STA.b $2E
            
            BRA .BRANCH_EPSILON
    
    .BRANCH_GAMMA
    
    INC.b $2D
    
    LDA.b $2D : CMP.b #$08 : BCC .BRANCH_EPSILON
        STZ.b $2D
        
        LDA.b $2E : INC A : AND.b #$03 : STA.b $2E : TAX
        
        LDA.w LinkSwimming_anim_offset, X : STA.w $02CC
    
    .BRANCH_EPSILON
    
    LDA.w $034F : BNE .BRANCH_ZETA
        LDA.w $033C : ORA.w $033D : ORA.w $033E : ORA.w $033F : BEQ .BRANCH_THETA
            LDA.b $F6 : AND.b #$80 : STA.b $00
            
            LDA.b $F4 : ORA.b $00 : AND.b #$C0 : BEQ .BRANCH_THETA
                STA.w $034F
                
                LDA.b $25 : JSR.w Player_DoSfx2
                
                LDA.b #$01 : STA.w $032A
                LDA.b #$07 : STA.w $02CB
                
                JSR.w Link_HandleSwimAccels
    
    .BRANCH_ZETA
    
    DEC.w $02CB : BPL .BRANCH_THETA
        LDA.b #$07 : STA.w $02CB
        
        INC.w $032A : LDA.w $032A : CMP.b #$05 : BNE .BRANCH_THETA
            STZ.w $032A
            
            LDA.w $034F : AND.b #$3F
            
            STA.w $034F

    .BRANCH_THETA

    ; Bleeds into the next function.
}
    
; $039715-$039784 LONG BRANCH LOCATION
Link_HandleSwimMovements:
{
    LDA.b $49 : AND.b #$0F : BNE .BRANCH_IOTA
        LDA.b $F0 : AND.b #$0F : BNE .BRANCH_IOTA
            STZ.b $30
            STZ.b $31
            
            JSR.w Link_FlagMaxAccels
            
            LDA.w $034A : BEQ .BRANCH_KAPPA
                LDA.w $0372 : BEQ .BRANCH_LAMBDA
                    LDA.w $0340
                    
                    BRA .BRANCH_IOTA
                
                .BRANCH_LAMBDA
                
                LDA.w $033C : ORA.w $033D : ORA.w $033E : ORA.w $033F : BNE .BRANCH_MU
                    STZ.b $48
                    
                    JSL.l Player_ResetSwimState
                    
                    BRA .BRANCH_MU
            
            .BRANCH_KAPPA
            
            LDA.b $5D : CMP.b #$04 : BEQ .BRANCH_MU
                STZ.b $2E
            
                BRA .BRANCH_MU
    
    .BRANCH_IOTA
    
    CMP.w $0340 : BEQ .BRANCH_NU
        STZ.b $2A
        STZ.b $2B
        STZ.b $6B
        STZ.b $48
    
    .BRANCH_NU
    
    STA.w $0340
    
    JSR.w Link_SetIceMaxAccel
    JSR.w Link_SetMomentum
    JSR.w Link_SetTheMaxAccel
    
    .BRANCH_MU
    
    JSR.w Link_HandleDiagonalCollision
    JSL.l Link_HandleVelocity
    JSR.w Link_HandleCardinalCollision
    JSL.l Link_HandleMovingAnimation_FullLongEntry
    
    STZ.w $0302
    
    JSR.w HandleIndoorCameraAndDoors
    
    RTS
}

; $039785-$0397A5 LOCAL JUMP LOCATION
Link_FlagMaxAccels:
{
    REP #$20
    
    LDA.w $034A : AND.w #$00FF : BEQ .linkNotMoving
        LDX.b #$02
        
        .BRANCH_GAMMA
        
            LDA.w $033C, X : BEQ .BRANCH_BETA
                STA.w $0334, X
                
                LDA.w #$0001 : STA.w $032B
            
            .BRANCH_BETA
        DEX #2 : BPL .BRANCH_GAMMA
    
    .linkNotMoving
    
    SEP #$20
    
    RTS
}

; $0397A6-$0397BE LOCAL JUMP LOCATION
Link_SetIceMaxAccel:
{
    REP #$20
    
    LDA.w $034A : AND.w #$00FF : BEQ .BRANCH_ALPHA
        LDX.b #$02
        
        .BRANCH_BETA
        
            LDA.w #$0180 : STA.w $0334, X
        DEX #2 : BPL .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0397BF-$0397C6 DATA
Pool_Link_SetMomentum:
{
    ; UNUSED:
    ; $0397BF
    .direction 
    db $08, $04, $02, $01

    ; $0397C3
    .momentum
    dw $0020
    dw $0008
}

; $0397C7-$039839 LOCAL JUMP LOCATION
Link_SetMomentum:
{
    SEP #$20
    
    LDA.b $F0 : AND.b #$0F : STA.b $00
    
    STZ.b $01
    
    REP #$30
    
    LDA.w #$0003 : STA.b $02
    
    LDX.w #$0002 : STX.b $04
    
    .BRANCH_ZETA
    
        LDY.w #$0000
        
        LDA.b $00
        
        AND.b $02 : BEQ .BRANCH_ALPHA
            AND.b #$04 : BNE .BRANCH_BETA
                LDY.w #$0001
            
            .BRANCH_BETA
            
            LDA.w #$0020 : STA.w $0326, X
            
            LDA.w $034A : AND.w #$00FF : BEQ .BRANCH_GAMMA
                PHY
                
                DEC A : ASL A : TAY
                
                LDA.w Pool_Link_SetMomentum_momentum, Y : STA.w $0326, X
                
                PLY
            
            .BRANCH_GAMMA
            
            LDA.w $0340 : ORA.b $67 : AND.b $02 : CMP.b $02 : BNE .BRANCH_DELTA
                LDA.w #$0002 : STA.w $032B, X
                
                BRA .BRANCH_EPSILON
            
            .BRANCH_DELTA
            
            TYA : STA.w $0338, X
            
            STZ.w $032B, X
            
            .BRANCH_EPSILON
            
            LDA.w $0334, X : BNE .BRANCH_ALPHA
                LDA.w MaxSwimAcceleration : STA.w $0334, X
        
        .BRANCH_ALPHA
        
        ASL.b $02 : ASL.b $02
        
        ASL.b $04 : ASL.b $04
    DEX #2 : BPL .BRANCH_ZETA
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03983A-$03984A LONG JUMP LOCATION
Player_ResetSwimState:
{
    PHB : PHK : PLB
    
    STZ.w $02CB
    STZ.w $034F
    STZ.w $032A
    
    JSR.w Player_ResetSwimCollision
    
    PLB
    
    RTL
}

; ==============================================================================

; $03984B-$039872 LONG JUMP LOCATION
Link_ResetStateAfterDamagingPit:
{
    PHB : PHK : PLB
    
    JSL.l Player_ResetSwimState
    
    LDY.b #$00
    
    LDA.b $56 : BEQ .alpha
        LDA.l $7EF357 : BNE .alpha
            LDY.b #$17
    
    .alpha
    
    STY.b $5D
    
    LDA.w $0340 : STA.b $26
    
    STZ.w $0345
    STZ.w $037B
    
    STZ.b $5A
    STZ.b $5B
    
    PLB
    
    RTL
}

; ==============================================================================

; $039873-$039895 LOCAL JUMP LOCATION
Player_ResetSwimCollision:
{
    REP #$20
    
    STZ.w $032F
    STZ.w $0331
    STZ.w $0326
    STZ.w $0328
    STZ.w $032B
    STZ.w $032D
    STZ.w $033C
    STZ.w $033E
    STZ.w $0334
    STZ.w $0336
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $079896-$0398A7 DATA
Link_HandleSwimAccels_max_speeds:
{
    dw $0080, $00A0, $00C0, $00E0
    dw $0100, $0120, $0140, $0160
    dw $0180
}

; $0398A8-$039902 LOCAL JUMP LOCATION
Link_HandleSwimAccels:
{
    REP #$30
    
    LDX.w #$0002
    
    LDA.w #$0003 : STA.b $02
    
    .BRANCH_ZETA
    
        LDA.b $F0 : AND.b $02 : BEQ .BRANCH_ALPHA
            LDA.w $033C, X : BEQ .BRANCH_BETA
                LDA.w $0334, X : CMP.w #$0180 : BCC .BRANCH_BETA
                    LDY.w #$0000
                    
                    .BRANCH_DELTA
                    
                        LDA.w .max_speeds, Y : CMP.w $033C, X : BCS .BRANCH_GAMMA
                    INY #2 : CPY.w #$0012 : BNE .BRANCH_DELTA
                    
                    BRA .BRANCH_GAMMA
                
            .BRANCH_BETA
            
            LDA.w $0334, X : BEQ .BRANCH_EPSILON
                CLC : ADC.w #$00A0 : CMP.w #$0180 : BCC .BRANCH_GAMMA
                    LDA.w #$0180
                    
                    BRA .BRANCH_GAMMA
            
            .BRANCH_EPSILON
            
            LDA.w #$0001 : STA.w $033C, X
            
            LDA.w MaxSwimAcceleration
            
            .BRANCH_GAMMA
            
            STA.w $0334, X
        
        .BRANCH_ALPHA
        
        ASL.b $02 : ASL.b $02
    DEX #2 : BPL .BRANCH_ZETA
    
    SEP #$30
    
    RTS
}

; $039903-$03996B LOCAL JUMP LOCATION
Link_SetTheMaxAccel:
{
    REP #$30
    
    LDA.w $034A : AND.w #$00FF : BNE .BRANCH_ALPHA
        LDA.w $034F : AND.w #$00FF : BNE .BRANCH_ALPHA
            LDX.w #$0002
            
            LDA.w #$0003 : STA.b $02
            
            .BRANCH_EPSILON
            
                LDA.b $F0 : AND.b $02 : BEQ .BRANCH_BETA
                    LDA.w $032B, X : CMP.w #$0002 : BEQ .BRANCH_BETA
                        LDA.w $032F, X : BNE .BRANCH_GAMMA
                            STZ.w $032F, X
                            
                            LDA.w $033C, X : CMP.w MaxSwimAcceleration : BCC .BRANCH_DELTA
                                CMP.w $0334, X : BEQ .BRANCH_GAMMA  BCC .BRANCH_DELTA
                        
                        .BRANCH_GAMMA
                        
                        STZ.w $032B, X
                        
                        LDA.w $033C, X : CMP.w MaxSwimAcceleration : BCC .BRANCH_BETA
                            LDA.w #$0001 : STA.w $032B, X : STA.w $032F, X
                            
                            BRA .BRANCH_DELTA
                
                .BRANCH_BETA
                
                LDA.w MaxSwimAcceleration : STA.w $0334, X
                
                STZ.w $032F, X
                
                .BRANCH_DELTA
                
                ASL.b $02 : ASL.b $02
            DEX #2 : BPL .BRANCH_EPSILON
    
    .BRANCH_ALPHA
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03996C-$0399AB LONG BRANCH POINT
Player_Electrocution:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    JSL.l Player_SetElectrocutionMosaicLevel
    
    ; Decrease the delay counter.
    DEC.b $3D : BPL .return
        ; Set up a three frame delay for this next step.
        LDA.b #$02 : STA.b $3D
        
        ; $0300 is the cycle counter for the electrocution animation.
        LDA.w $0300 : INC A : STA.w $0300 : AND.b #$01 : BEQ .use_normal_palettes
            JSL.l Palette_ElectroThemedGear
            
            BRA .palette_logic_complete
        
        .use_normal_palettes
        
        JSL.l LoadActualGearPalettes
        
        .palette_logic_complete
        
        ; On the eighth step release player (fling them back).
        LDA.w $0300 : CMP.b #$08 : BNE .return
            ; Reset the steps of the electrocution.
            STZ.w $0300
            
            ; Reset player to ground state.
            LDA.b #$00 : STA.b $5D
            
            STZ.w $037B
            STZ.w $0360
            STZ.b $4D
            
            LDA.b #$00
            
            JSL.l Player_SetCustomMosaicLevel
    
    .return

    ; Bleeds into the next function.
}
    
; $0399AC-$0399AC LOCAL JUMP LOCATION
LinkState_ShowingOffItem:
{
    RTS
}

; ==============================================================================

; Grant link the item he earned, if possible.
; $0399AD-$039A28 LONG JUMP LOCATION
Link_ReceiveItem:
{
    PHB : PHK : PLB
    
    ; Is Link in another type of mode besides ground state?
    LDA.b $4D : BEQ .groundState
        ; If not, bring him back to normal so he can get this item.
        STZ.b $4D : STZ.b $46
        
        STZ.w $031F : STZ.w $0308
    
    .groundState
    
    ; The index of the item we're going to give to Link.
    ; Did Link receive a heart container?
    STY.w $02D8 : CPY.b #$3E : BNE .notHeartContainer
        ; Link received a heart container.. handle it.
        LDA.b #$2E : JSR.w Player_DoSfx3
    
    .notHeartContainer
    
    LDA.b #$60 : STA.w $02D9
    
    LDA.w $02E9 : BEQ .fromTextOrObject
        ; 0x03 = grabbed an item off the floor (from an ancillary object).
        ; Such as a pendant or crystal.
        CMP.b #$03 : BNE .fromChestOrSprite
            .fromTextOrObject
        
            STZ.w $0308
            
            ; Zero out player input.
            STZ.b $3A : STZ.b $3B : STZ.b $3C
            
            STZ.b $5E : STZ.b $50
            
            STZ.w $0301 : STZ.w $037A : STZ.w $0300
            
            ; Put Link in a position looking up at his item.
            LDA.b #$15 : STA.b $5D
            
            LDA.b #$01 : STA.w $02DA : STA.w $037B
            
            ; Is the item a crystal?
            CPY.b #$20 : BNE .notCrystal
                ; Up the ante or whatever >_> (Puts Link in a different pose
                ; holding the item up with two hands).
                INC A : STA.w $02DA
        
            .notCrystal
    .fromChestOrSprite
    
    PHX
    
    LDY.b #$04
    LDA.b #$22
    
    JSL.l AddReceivedItem
    
    ; Is it a crystal?
    LDA.w $02D8
    CMP.b #$20 : BEQ .noHudRefresh
    CMP.b #$37 : BEQ .noHudRefresh
    CMP.b #$38 : BEQ .noHudRefresh
    CMP.b #$39 : BEQ .noHudRefresh
        JSL.l HUD.RefreshIconLong
    
    .noHudRefresh
    
    JSR.w Player_HaltDashAttack
    
    PLX
    
    CLC
    
    PLB
    
    RTL
}
    
; $039A29-$039A2B LOCAL JUMP LOCATION
UNREACHABLE_079A29:
{
    SEC
    
    PLB
    
    RTL
}

; ==============================================================================

; Puts link in bed asleep.
; $039A2C-$039A53 LONG JUMP LOCATION
Link_TuckIntoBed:
{
    PHB : PHK : PLB
    
    REP #$20
    
    ; Link's Y coordinate is #$215A; Link's X coordinate is #$0940.
    LDA.w #$215A : STA.b $20
    LDA.w #$0940 : STA.b $22
    
    SEP #$20
    
    ; Link's mode is the "asleep in bed" one.
    LDA.b #$16 : STA.b $5D
    
    STZ.w $037C : STZ.w $037D
    
    LDA.b #$03 : STA.w $0374
    
    ; Spawn the "Link's bedspread" ancilla.
    LDA.b #$20
    
    JSL.l AddLinksBedSpread
    
    PLB
    
    RTL
}

; ==============================================================================

; $039A54-$039A59 JUMP TABLE
Pool_LinkState_Sleeping:
{
    dw Link_SnoringInBed
    dw Link_SittingUpInBed
    dw Link_JumpingOutOfBed
}

; Link mode 0x16 (asleep in bed)
; $039A5A-$039A61 JUMP LOCATION
LinkState_Sleeping:
{
    LDA.w $037C : ASL A : TAX
    
    JMP ($9A54, X)
}

; $039A62-$039A70 JUMP LOCATION
Link_SnoringInBed:
{
    LDA.b $1A : AND.b #$1F : BNE .noZzzz
        ; Generate Z sprites from Link sleeping.
        LDY.b #$01
        LDA.b #$21
        
        JSL.l AddLinksSleepZs
    
    .noZzzz
    
    RTS
}

; $039A71-$039AA0 LOCAL JUMP LOCATION
Link_SittingUpInBed:
{
    LDA.b $11 : BNE .BRANCH_ALPHA
        DEC.w $0374 : BPL .BRANCH_ALPHA
            STZ.w $0374
            
            LDA.b $F4 : AND.b #$E0 : STA.b $00
            
            LDA.b $F4 : ASL #4 : ORA.b $00 : ORA.b $F6 : AND.b #$F0 : BEQ .BRANCH_ALPHA
                INC.w $037D
                
                LDA.b #$06 : STA.b $2F
                
                INC.w $037C
                
                LDA.b #$04 : STA.w $0374
    
    .BRANCH_ALPHA
    
    RTS
}

; $039AA1-$039AC1 LOCAL JUMP LOCATION
Link_JumpingOutOfBed:
{
    DEC.w $0374 : BPL .countingDown
        LDA.b #$04 : STA.b $27
        LDA.b #$15 : STA.b $28
        
        LDA.b #$18 : STA.b $29 : STA.w $02C7
        
        LDA.b #$10 : STA.b $46
        
        LDA.b #$02 : STA.b $4D
        
        LDA.b #$06 : STA.b $5D
    
    .countingDown
    
    RTS
}

; ==============================================================================

; $039AC2-$039AE5 LOCAL JUMP LOCATION
Player_Sword:
{
    DEC.w $02E3 : BPL .exit
        STZ.w $02E3
        
        LDA.w $0301 : ORA.w $037A : BNE .exit
            LDA.b $3C : CMP.b #$09 : BCS .spin_attack_jerks
                LDA.w $0372 : BNE .exit
                    JSR.w Link_CheckForSwordSwing
                    
                    BRA .exit
            
            .spin_attack_jerks
            
            JSR.w Link_CheckForSwordSwing_maybeDoSpinAttack
    
    ; $039AE5 ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; ==============================================================================

; Subprograms that handle the Y button weapons.
; $039AE6-$039B0D JUMP TABLE
Pool_Link_HandleYItem:
{
    dw $A138 ; $03A138 Bombs
    dw LinkItem_Boomerang
    dw LinkItem_Bow
    dw LinkItem_Hammer
    dw LinkItem_Rod
    dw LinkItem_Rod
    dw $AFF8 ; $03AFF8 Bug Catching Net
    dw LinkItem_ShovelAndFlute
    
    dw LinkItem_Lamp
    dw LinkItem_MagicPowder
    dw $A15B ; $03A15B Bottle(s)
    dw $A471 ; $03A471 Book of Mudora
    dw PlayerItem_CaneOfByrna
    dw $AB25 ; $03AB25 Hookshot
    dw $A569 ; $03A569 Bombos Medallion
    dw LinkItem_EtherMedallion
    
    dw LinkItem_Quake
    dw LinkItem_CaneOfSomaria
    dw LinkItem_Cape
    dw LinkItem_Mirror
}

; $039B0E-$039B91 LOCAL JUMP LOCATION
Link_HandleYItem:
{
    LDA.b $3C : BEQ .BRANCH_ALPHA
        CMP.b #$09 : BCC .Player_Sword_exit
    
    .BRANCH_ALPHA
    
    LDA.w $02E0 : BEQ .BRANCH_BETA
        LDA.w $0303
        
        CMP.b #$0B : BEQ .BRANCH_BETA
        CMP.b #$14 : BEQ .BRANCH_BETA
            RTS
    
    .BRANCH_BETA
    
    LDY.w $03FC : BEQ .BRANCH_GAMMA
        LDA.w $02E0 : BNE .BRANCH_GAMMA
            CPY.b #$02 : BEQ .BRANCH_DELTA
                BRL LinkItem_Shovel
            
            .BRANCH_DELTA
            
            BRL LinkItem_Bow
    
    .BRANCH_GAMMA
    
    LDY.w $0304 : CMP.w $0303 : BEQ .BRANCH_EPSILON
        LDA.w $0304 : CMP.b #$08 : BNE .BRANCH_ZETA
            ; Does Link have the flute?
            LDA.l $7EF34C : AND.b #$02 : BEQ .BRANCH_ZETA
                LDA.b $3A : AND.b #$BF : STA.b $3A
        
        .BRANCH_ZETA
        
        LDA.w $0304 : CMP.b #$13 : BNE .BRANCH_EPSILON
            LDA.b $55 : BEQ .BRANCH_EPSILON
                JSR.w Link_ForceUnequipCape
    
    .BRANCH_EPSILON
    
    LDA.w $0301 : ORA.w $037A : BNE .BRANCH_THETA
        LDY.w $0303 : STY.w $0304
    
    .BRANCH_THETA
    
    BEQ .BRANCH_IOTA
        CPY.b #$05 : BEQ .BRANCH_KAPPA
            CPY.b #$06 : BNE .BRANCH_LAMBDA
                .BRANCH_KAPPA
                
                ; Only gets triggered if the previous item was one of the rods.
                LDA.w $0304 : SEC : SBC.b #$05 : INC A : STA.w $0307
                
            .BRANCH_LAMBDA
                
            DEY : BMI .BRANCH_IOTA
                TYA : ASL A : TAX
                
                JMP (Pool_Link_HandleYItem, X)
    
    .BRANCH_IOTA
    
    RTS
}

; $039B92-$039BA1 JUMP TABLE
Link_APress_vectors:
{
    dw Link_APress_NothingA       ; $AAA1 RTS, basically
    dw Link_APress_LiftCarryThrow ; $B1CA Pick up a pot / bush / bomb / etc
    dw Link_APress_NothingB       ; $B2ED
    dw Link_APress_PullObject     ; $B322 Grabbing wall... prep?
    dw Link_Read_return           ; $B527 Reading.... prep?
    dw Link_Chest                 ; $B574 The chest is already open, we're done.
    dw Link_APress_StatueDrag     ; $B389
    dw Link_APress_RupeePull      ; $B40C
}

; $039BA2-$039BA9 DATA
Link_AbilityChecks:
{
    db $E0 ; 11100000 - Lift, read, talk
    db $40 ; 01000000 - Read
    db $04 ; 00000100 - Run
    db $E0 ; 11100000 - Lift, read, talk
    db $E0 ; 11100000 - Lift, read, talk
    db $E0 ; 11100000 - Lift, read, talk
    db $E0 ; 11100000 - Lift, read, talk | used by statue drag
    db $E0 ; 11100000 - Lift, read, talk | used by rupee pull
}

; $039BAA-$039C4E LOCAL JUMP LOCATION
Link_HandleAPress:
{
    STZ.w $02F4
    
    ; Is Link using a special item already?
    LDA.w $0301 : BNE .cantDoAnyAction
        ; Is Link in some sort of special pose? (praying, shoveling, etc.)?
        LDA.w $037A : AND.b #$1F : BNE .cantDoAnyAction
            ; If the flag is set, don't read the A button.
            LDA.w $0379 : BNE .cantDoAnyAction
                ; How long has the B - button been pressed? (Less than 9
                ; frames?).
                LDA.b $3C : CMP.b #$09 : BCC .swordWontInterfere
                    ; Is the B button been released this frame?
                    LDA.b $3A : AND.b #$80 : BEQ .swordWontInterfere
    
    .cantDoAnyAction
    
    RTS
    
    .swordWontInterfere
    
    LDX.w $036C
    
    ; Is link Holding a pot? Is he holding a wall?
    LDA.w $0308 : ORA.w $0376 : BNE .handsAreOccupied
        ; If the A button was down, then continue. If not, branch.
        JSR.w Link_CheckNewAPress : BCC .cantDoAction
            ; Pull for rupees flag (if near one).
            LDA.w $03F8 : BEQ .notPullForRupeesAction
                ; What direction is Link facing? If he's not facing up, then...
                LDA.b $2F : BNE .notPullForRupeesAction
                    ; The PullForRupees action.
                    LDX.b #$07
                    
                    BRL .attemptAction
            
            .notPullForRupeesAction
            
            LDA.w $02FA : BEQ .notMovingStatueAction
                ; Near a moveable statue (so pressing A will grab it).
                LDX.b #$06
                
                BRL .attemptAction
            
            .notMovingStatueAction
            
            ; Detection of a bomb or cane of somaria block?
            LDA.w $02EC : BNE .spriteLiftAction
                ; Detection of a sprite object.
                LDA.w $0314 : BEQ .checkOtherActions
                    LDA.w $0314 : STA.w $02F4
            
            .spriteLiftAction
            
            LDA.b $3C : BEQ .nu
                JSR.w Link_ResetSwordAndItemUsage
            
            .nu
            
            LDA.w $0301 : ORA.w $037A : BEQ .notBoomerang
                STZ.w $0301
                STZ.w $037A
                
                JSR.w LinkItem_Boomerang_reset
                
                STZ.w $035F
                
                LDA.w $0C4A : CMP.b #$05 : BNE .notBoomerang
                    STZ.w $0C4A
            
            .notBoomerang
            
            LDX.b #$01
            
            BRA .attemptAction
            
            .checkOtherActions
            
            ; Determines what type of action you desire to complete. Eg.
            ; Opening a chest, dashing, etc. Returns X as the index of that
            ; action.
            JSR.w Link_HandleLiftables
            
            .attemptAction
            
            ; Check to see if we have the capability for this action.
            LDA.w Link_AbilityChecks, X : AND.l $7EF379 : BEQ .cantDoAction
                ; Buffer $036C with the current action index.
                STX.w $036C
                
                TXA : ASL A : TAX
                
                JSR.w Link_APress_PerformBasic ; Do the action.
    
    .handsAreOccupied
    
    ; Remind me what action we just did, and mirror it to $0306.
    LDA.w $036C : STA.w $0306 : ASL A : TAX
    
    JMP (Link_APress_vectors, X)
    
    .cantDoAction
    
    STZ.b $3B
    
    RTS
}

; $039C4F-$039C5E JUMP TABLE
Pool_Link_APress_PerformBasic:
{
    ; Parameter: $036C
    
    ; Using the A button, Link:
    
    dw Link_PerformDesertPrayer ; $AA6C
    dw Link_Lift ; Picks up a pot or bush.
    dw $B281 ; $03B281 Starts dashing
    dw $B2EE ; $03B2EE Grabs a wall
    dw Link_Read ; B527 Reads a sign.
    dw Link_Chest ; Opens a chest.
    dw Link_MovableStatue ; Grabs a Moveable Statue
    dw $B3E5 ; $03B3E5 Pull For Rupees / DW Dungeon 4 entrance
}

; $039C5F-$039C61 LOCAL JUMP LOCATION
Link_APress_PerformBasic:
{
    JMP (Pool_Link_APress_PerformBasic, X)
}

; $039C62-$039C62 LOCAL JUMP LOCATION
UNREACHABLE_079C62:
{
    RTS
}

; ==============================================================================

; $039C63-$039C65 DATA
UNREACHABLE_079C63:
{
    db $00, $01, $01
}

; ==============================================================================

; $039C66-$039CBE LOCAL JUMP LOCATION
HandleSwordSFXAndBeam:
{
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    STZ.b $3C ; Initialize the the next spin attack counter.
    STZ.b $79 ; Stop the spin attack.
    
    ; Checks if we need to fire a sword beam.
    ; If(actual health >= (goal health - 4))
    LDA.l $7EF36C : SEC : SBC.b #$04 : CMP.l $7EF36D : BCS .cantShootBeam
        ; Check if we have a sword that can shoot the beam.
        LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .cantShootBeam
            LDA.l $7EF359 : CMP.b #$02 : BCC .cantShootBeam
                .nextSlot
                
                    ; Master Sword or better.
                    LDX.b #$04
                    
                    ; Is the cane of byrna being used?
                    LDA.w $0C4A, X : CMP.b #$31 : BEQ .cantShootBeam
                DEX : BPL .nextSlot
                    
                LDY.b #$00
                    
                JSL.l AddSwordBeam
    
    .cantShootBeam
    
    ; Normal sword
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    PHA
    
    LDA.l $7EF359 : DEC A : TAX
    
    PLA
    
    CPX.b #$FE : BEQ .noSwordSound
    CPX.b #$FF : BEQ .noSwordSound
        ORA.w SwordSwingSFX, X : STA.w $012E
    
    .noSwordSound
    
    ; Start the spin attack delay counter / timer.
    LDX.b #$01 : STX.b $3D
    
    .easy_out
    
    RTS
}

; ==============================================================================

; $039CBF-$039CD0 DATA
SwordSwingTimers:
{
    db $01, $00, $00, $00, $00, $03, $00, $00
    db $01, $00, $03, $03, $03, $03, $04, $04
    db $01, $05
}

; $039CD1-$039CD8 DATA
SwordSwingSFX:
{
    db $01 ; SFX2.01
    db $02 ; SFX2.02
    db $03 ; SFX2.03
    db $04 ; SFX2.04
    db $00 ; SFX2.00
    db $09 ; SFX2.09
    db $12 ; SFX2.12
    db $1B ; SFX2.1B
}

; $039CD9-$039D83 LOCAL JUMP LOCATION
Link_CheckForSwordSwing:
{
    LDA.b $3B : AND.b #$10 : BNE HandleSwordSFXAndBeam_easy_out
        ; Is the B button being held down?
        BIT.b $3A : BMI .b_button_held_previous_frames
            ; Did the player just press B this frame?
            BIT.b $F4 : BPL HandleSwordSFXAndBeam_easy_out
                LDX.b $6C : BEQ .not_in_doorway
                    ; Seems like this checks the types of tiles in front of the
                    ; player to see if we can bring the sword out.
                    JSR.w TileDetect_SwordSwingDeepInDoor
                    
                    LDA.b $0E : AND.b #$30 : EOR.b #$30 : BEQ HandleSwordSFXAndBeam_easy_out
                
                .not_in_doorway
                
                ; Indicate that the B button is now being held down.
                LDA.b #$80 : TSB.b $3A
                
                ; Reinitialize spin attack variables and shoot a sword beam, if
                ; applicable.
                JSR.w HandleSwordSFXAndBeam
                
                ; Link can no longer change direction.
                LDA.b #$01 : TSB.b $50
                
                STZ.b $2E
        
        .b_button_held_previous_frames
        
        BIT.b $F0 : BMI .b_button_wasnt_released
            LDA.b #$01 : TSB.b $3A
        
        .b_button_wasnt_released
        
        ; Does something more related to how Link's standing / collision with
        ; the floor.
        JSR.w HaltLinkWhenUsingItems
        
        ; Stop any motion Link may have had.
        LDA.b $67 : AND.b #$F0 : STA.b $67
        
        ; Count down the spin attack delay timer.
        DEC.b $3D : BPL .BRANCH_DELTA
            ; Count up the "frames B Button has been held" timer.
            INC.b $3C
            
            LDA.b $3C : CMP.b #$09 : BCS .maybeDoSpinAttack
                TAX
                
                LDA.w SwordSwingTimers, X : STA.b $3D
                
                CPX.b #$05 : BNE .no_swing_sparkle
                    LDA.l $7EF359 : BEQ .BRANCH_THETA
                       CMP.b #$01 : BEQ .BRANCH_THETA
                       CMP.b #$FF : BEQ .BRANCH_THETA
                        LDY.b #$04
                        LDA.b #$26
                        
                        JSL.l AddLinksSleepZs
                    
                    .BRANCH_THETA
                    
                    LDY.b #$01
                    
                    LDA.l $7EF359 : BEQ .BRANCH_DELTA
                        CMP.b #$FF : BEQ .BRANCH_DELTA
                        CMP.b #$01 : BEQ .BRANCH_IOTA
                            LDY.b #$06
                        
                        .BRANCH_IOTA
                        
                        JSR.w TileDetect_MainHandler
                        
                        BRA .BRANCH_DELTA

                .no_swing_sparkle
                
                CPX.b #$04 : BCC .BRANCH_DELTA
                    LDA.b $3A : AND.b #$01 : BEQ .BRANCH_DELTA
                        BIT.b $F0 : BPL .BRANCH_DELTA
                            LDA.b $3A : AND.b #$FE : STA.b $3A
                            
                            BRL HandleSwordSFXAndBeam
        
        .BRANCH_DELTA
        
        JSR.w CalculateSwordHitbox
        
        RTS
        
        ; $039D72 ALTERNATE ENTRY POINT
        .maybeDoSpinAttack
        
        ; B Button is still being held?
        BIT.b $F0 : BMI Link_ResetSwordAndItemUsage_holding_b
            LDA.b $79 : CMP.b #$30 : BCC Link_ResetSwordAndItemUsage
                JSR.w Link_ResetSwordAndItemUsage
                
                STZ.b $79
                
                BRL Link_ActivateSpinAttack
}

; $039D84-$039E62 LOCAL JUMP LOCATION
Link_ResetSwordAndItemUsage:
{
    .BRANCH_EPSILON

        ; Bring Link to stop.
        STZ.b $5E
        
        LDA.b $48 : AND.b #$F6 : STA.b $48
        
        ; Stop any animations Link is doing.
        STZ.b $3D
        STZ.b $3C
        
        ; Nullify button input on the B button.
        LDA.b $3A : AND.b #$7E : STA.b $3A
        
        ; Make it so Link can change direction if need be.
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        BRL .return

        ; $039D9F ALTERNATE ENTRY POINT
        .holding_b

        BIT.b $48 : BNE .BRANCH_BETA
            LDA.b $48 : AND.b #$09 : BNE .BRANCH_GAMMA

        .BRANCH_BETA

        LDA.b $47 : BEQ .BRANCH_DELTA
    CMP.b #$01 : BEQ .BRANCH_EPSILON

    .BRANCH_GAMMA

    LDA.b $3C : CMP.b #$09 : BNE .BRANCH_ZETA
        LDX.b #$0A : STX.b $3C
        
        LDA.w SwordSwingTimers, X : STA.b $3D

    .BRANCH_ZETA

    DEC.b $3D : BPL .BRANCH_THETA
        LDA.b $3C : INC A : CMP.b #$0D : BNE .BRANCH_KAPPA
            LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .BRANCH_LAMBDA
                LDA.b $48 : AND.b #$09 : BEQ .BRANCH_LAMBDA
                
                LDY.b #$01
                LDA.b #$1B
                
                JSL.l AddWallTapSpark ; $049395 IN ROM
                
                LDA.b $48 : AND.b #$08 : BNE .BRANCH_MUNU
                    LDA.b $05 : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_XI

                .BRANCH_MUNU

                LDA.b #$06 : JSR.w Player_DoSfx2

                .BRANCH_XI

                ; Do sword interaction with tiles.
                LDY.b #$01
                
                JSR.w TileDetect_MainHandler
            
            .BRANCH_LAMBDA

            LDA.b #$0A

        .BRANCH_KAPPA

        STA.b $3C : TAX
        
        LDA.w SwordSwingTimers, X : STA.b $3D
    
    .BRANCH_THETA

    BRA .BRANCH_RHO

    .BRANCH_DELTA

    LDA.b #$09 : STA.b $3C
    
    LDA.b #$01 : TSB.b $50
    
    STZ.b $3D
    
    LDA.b $5E
    
    CMP.b #$04 : BEQ .BRANCH_RHO
    CMP.b #$10 : BEQ .BRANCH_RHO
        LDA.b #$0C : STA.b $5E
        
        LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .return
            LDX.b #$04

            .BRANCH_PHI

                LDA.w $0C4A, X
                
                CMP.b #$30 : BEQ .return
                CMP.b #$31 : BEQ .return
            DEX : BPL .BRANCH_PHI
            
            LDA.b $79 : CMP.b #$06 : BCC .BRANCH_CHI
                LDA.b $1A : AND.b #$03 : BNE .BRANCH_CHI
                    JSL.l AncillaSpawn_SwordChargeSparkle

            .BRANCH_CHI

            LDA.b $79 : CMP.b #$40 : BCS .return
                INC.b $79 : LDA.b $79 : CMP.b #$30 : BNE .return
                    LDA.b #$37 : JSR.w Player_DoSfx2
                    
                    JSL.l AddChargedSpinAttackSparkle
                    
                    BRA .return

    .BRANCH_RHO

    JSR.w CalculateSwordHitbox

    ; $039E62 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; $039E63-$039EEB LOCAL JUMP LOCATION
CalculateSwordHitbox:
{
    ; Sword
    LDA.l $7EF359 : BEQ Link_ResetSwordAndItemUsage_return
       CMP.b #$FF : BEQ Link_ResetSwordAndItemUsage_return
        CMP.b #$02 : BCS .BRANCH_ALPHA
            .BRANCH_GAMMA

            LDY.b #$27
            
            LDA.b $3C : STA.b $02 : STZ.b $03
            
            CMP.b #$09 : BEQ Link_ResetSwordAndItemUsage_return
                BCC .BRANCH_BETA
                    LDA.b $02 : SEC : SBC.b #$0A : STA.b $02
                
                    LDY.b #$03

                .BRANCH_BETA

                REP #$30
                
                LDA.b $2F : AND.w #$00FF : TAX
                
                LDA.l $0DA030, X : STA.b $04
                
                TYA : AND.w #$00FF : ASL A : CLC : ADC.b $04 : TAX
                
                LDA.l $0D9EF0, X : CLC : ADC.b $02 : TAX
                
                SEP #$20
                
                LDA.l $0D98F3, X : STA.b $44
                LDA.l $0D9AF2, X : STA.b $45
                
                SEP #$10
                
                RTS

    .BRANCH_ALPHA

    LDA.b $3C : CMP.b #$09 : BCS .BRANCH_GAMMA
        ASL A : STA.b $04
        
        LDA.b $2F : LSR A : STA.b $0E
        
        ASL #3 : CLC : ADC.b $0E : ASL A : CLC : ADC.b $04 : TAX
        
        LDA.l $0DAC45, X : CMP.b #$FF : BEQ .no_hitbox
            TXA : LSR A : TAX
            
            LDA.l $0DAC8D, X : STA.b $44
            LDA.l $0DACB1, X : STA.b $45

            .return

            RTS

        .no_hitbox

        BRL .BRANCH_GAMMA
}

; ==============================================================================

; $039EEC-$039EEE DATA
RodAndCaneAnimationTimer:
{
    db $03, $03, $05
}

; ==============================================================================

; Called when the fire rod or ice rod is invoked.
; $039EEF-$039F58 LOCAL JUMP LOCATION
LinkItem_Rod:
{
    BIT.b $3A : BVS .y_button_held
        ; Can't use while standing in doorway.
        LDA.b $6C : BNE CalculateSwordHitbox_quick_return
            JSR.w Link_CheckNewY_ButtonPress : BCC CalculateSwordHitbox_quick_return
                LDX.b #$00
                
                JSR.w LinkItem_EvaluateMagicCost : BCC .insufficient_mp
                    ; This is a debug variable, but apparently in addition to
                    ; moving the HUD up 8 pixels, it also prevents you from
                    ; firing the rod weapons... or?.... maybe it prevents you
                    ; from doing it without holding the button.
                    LDA.w $020B : BNE .insufficient_mp
                        LDA.b #$01 : STA.w $0350
                        
                        JSR.w LinkItem_RodDiscriminator
                        
                        ; Delay the spin attack for some amount of time?
                        LDA.w RodAndCaneAnimationTimer : STA.b $3D
                        
                        STZ.b $2E
                        STZ.w $0300
                        STZ.w $0301
                        
                        LDA.b #$01 : TSB.w $0301
    
    .y_button_held
    
    JSR.w HaltLinkWhenUsingItems
    
    ; What's the point of this?
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    DEC.b $3D : BPL .return
        LDA.w $0300 : INC A : STA.w $0300 : TAX
        
        LDA.w RodAndCaneAnimationTimer, X : STA.b $3D
        
        CPX.b #$03 : BNE .return
            STZ.b $5E
            STZ.w $0300
            STZ.b $3D
            STZ.w $0350
            
            LDA.w $0301 : AND.b #$FE : STA.w $0301
            
            .insufficient_mp
            
            LDA.b $3A : AND.b #$BF : STA.b $3A
    
    .return
    
    RTS
}

; ==============================================================================

; $039F59-$039F5C JUMP TABLE
Pool_LinkItem_RodDiscriminator:
{
    .rods
    dw LinkItem_FireRod
    dw LinkItem_IceRod
}

; ==============================================================================

; $039F5D-$039F65 LOCAL JUMP LOCATION
LinkItem_RodDiscriminator:
{
    LDA.w $0307 : DEC A : ASL A : TAX
    
    JMP (Pool_LinkItem_RodDiscriminator_rods, X)
}

; ==============================================================================

; $039F66-$039F6E JUMP LOCATION
LinkItem_IceRod:
{
    LDA.b #$0B
    LDY.b #$01
    
    JSL.l AddIceRodShot
    
    RTS
}

; ==============================================================================

; $039F6F-$039F77 LOCAL JUMP LOCATION
LinkItem_FireRod:
{
    LDA.b #$02
    LDY.b #$01
    
    JSL.l AddFireRodShot
    
    RTS
}

; ==============================================================================

; $039F78-$039F7A DATA
LinkItem_Hammer_timers:
{
    db  3,  3, 16
}

; Hammer item code
; $039F7B-$03A002 BRANCH LOCATION
LinkItem_Hammer:
{
    LDA.w $0301 : AND.b #$10 : BNE .BRANCH_ALPHA
        BIT.b $3A : BVS .BRANCH_BETA
            LDA.b $6C : BNE .BRANCH_ALPHA
                JSR.w Link_CheckNewY_ButtonPress : BCS .BRANCH_GAMMA
    
    .BRANCH_ALPHA
    
    BRL LinkItem_Rod_return
    
    .BRANCH_GAMMA
    
    LDA.w .timers : STA.b $3D
    
    LDA.b #$01 : TSB.b $50
    
    STZ.b $2E
    
    LDA.w $0301 : AND.b #$00 : ORA.b #$02 : STA.w $0301
    
    STZ.w $0300

    .BRANCH_BETA

    JSR.w HaltLinkWhenUsingItems
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    DEC.b $3D : BPL .return
        LDA.w $0300 : INC A : STA.w $0300 : TAX
        
        LDA.w .timers, X : STA.b $3D
        
        CPX.b #$01 : BNE .BRANCH_EPSILON
            PHX
            
            LDY.b #$03
            
            JSR.w TileDetect_MainHandler
            
            LDY.b #$00
            LDA.b #$16
            
            JSR.w AddHitStars
            
            PLX
            
            LDA.w $012E : BNE .BRANCH_EPSILON
                LDA.b #$10 : JSR.w Player_DoSfx2
                
                JSL.l Player_SpawnSmallWaterSplashFromHammer

        .BRANCH_EPSILON

        CPX.b #$03 : BNE .return
            STZ.w $0300
            STZ.b $3D
            
            LDA.b $3A : AND.b #$BF : STA.b $3A
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            LDA.w $0301 : AND.b #$FD : STA.w $0301
        
    ; $03A002 ALTERNATE ENTRY POINT
    .return

    RTS
}

; ==============================================================================

; $03A003-$03A005
LinkItem_Bow_timer:
{
    db $03, $03, $08
}

; Box and Arrow use code
; $03A006-$03A0BA LONG BRANCH LOCATION
LinkItem_Bow:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE LinkItem_Hammer_return
            JSR.w Link_CheckNewY_ButtonPress : BCC LinkItem_Hammer_return
                LDA.b #$01 : TSB.b $50
                
                LDA.w .timer : STA.b $3D
                
                STZ.b $2E
                STZ.w $0300
                
                LDA.w $0301 : AND.b #$00 : ORA.b #$10 : STA.w $0301
    
    .BRANCH_ALPHA
    
    JSR.w HaltLinkWhenUsingItems
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    DEC.b $3D : BPL LinkItem_Hammer_return
        LDA.w $0300 : INC A : STA.w $0300 : TAX
        
        LDA.w .timer, X : STA.b $3D
        
        CPX.b #$03 : BNE .return
            LDA.b $20 : STA.b $72
            LDA.b $21 : STA.b $73
            LDA.b $22 : STA.b $74
            LDA.b $23 : STA.b $75
            
            LDX.b $2F
            
            ; Spawn arrow.
            LDY.b #$02
            LDA.b #$09
            
            JSL.l AddArrow : BCC .BRANCH_GAMMA
                LDA.w $0B99 : BEQ .BRANCH_DELTA
                    DEC.w $0B99
                    
                    LDA.l $7EF377 : INC #2 : STA.l $7EF377
                
                .BRANCH_DELTA
                
                LDA.w $0B9A : BNE .BRANCH_EPSILON
                    LDA.l $7EF377 : BEQ .BRANCH_EPSILON
                        DEC A : STA.l $7EF377 : BNE .BRANCH_GAMMA
                            JSL.l HUD.RefreshIconLong
                            
                            BRA .BRANCH_GAMMA
                
                .BRANCH_EPSILON
                
                STZ.w $0C4A, X
                
                LDA.b #$3C : JSR.w Player_DoSfx2
            
            .BRANCH_GAMMA
            
            STZ.w $0300
            STZ.b $3D
            
            LDA.b $3A : AND.b #$BF : STA.b $3A
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            LDA.w $0301 : AND.b #$EF : STA.w $0301
            
            LDA.b $3C : CMP.b #$09 : BCC .return
                LDA.b #$09 : STA.b $3C
            
        ; $03A0BA ALTERNATE ENTRY POINT
        .return
        
        RTS
}

; Boomerang item use code
; $03A0BB-$03A137 JUMP LOCATION
LinkItem_Boomerang:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE LinkItem_Bow_return
            JSR.w Link_CheckNewY_ButtonPress : BCC .BRANCH_BETA
                LDA.w $035F : BNE .BRANCH_BETA
                    STZ.b $2E
                    
                    LDA.w $0301 : AND.b #$00 : ORA.b #$80 : STA.w $0301
                    
                    STZ.w $0300
                    
                    LDA.b #$07 : STA.b $3D
                    
                    LDY.b #$00
                    LDA.b #$05
                    
                    JSL.l AddBoomerang
                    
                    LDA.b $3C : CMP.b #$09 : BCS .reset
                        LDA.b $72 : BNE .BRANCH_ALPHA
                            LDA.b $F0 : AND.b #$0F : STA.b $26
                            
                            BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA
    
    LDA.b #$01 : TSB.b $50
    
    .BRANCH_DELTA
    
    LDA.w $0301 : BEQ .reset
        JSR.w HaltLinkWhenUsingItems
        
        LDA.b $67 : AND.b #$F0 : STA.b $67
        
        DEC.b $3D : BPL .BRANCH_BETA
            LDA.b #$05 : STA.b $3D
                LDA.w $0300 : INC A : STA.w $0300
                CMP.b #$02 : BNE .BRANCH_BETA
    
    ; $03A11F ALTERNATE ENTRY POINT
    .reset
    
    STZ.w $0301
    STZ.w $0300
    STZ.b $3D
    
    LDA.b $3A : AND.b #$BF : STA.b $3A : AND.b #$80 : BNE .BRANCH_BETA
        LDA.b $50 : AND.b #$FE : STA.b $50
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; Code for laying a bomb
; $03A138-$03A15A JUMP LOCATION
LinkItem_Bombs:
{
    LDA.b $6C : BNE .cantLayBomb
        LDA.l $7EF3CC : CMP.b #$0D : BEQ .cantLayBomb
            JSR.w Link_CheckNewY_ButtonPress : BCC .cantLayBomb
                LDA.b $3A : AND.b #$BF : STA.b $3A
                
                LDY.b #$01
                LDA.b #$07
                
                JSL.l AddBlueBomb
                
                STZ.w $0301
    
    .cantLayBomb

    ; $03A15A ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; Executes when we use a bottle
; $03A15B-$03A249 JUMP LOCATION
LinkItem_Bottle:
{
    JSR.w Link_CheckNewY_ButtonPress : BCC LinkItem_Bombs_return
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        ; Check if we have a bottle or not.
        LDA.l $7EF34F : DEC A : TAX
        
        LDA.l $7EF35C, X : BEQ LinkItem_Bombs_return
            CMP.b #$03 : BCC .BRANCH_ALPHA
                CMP.b #$03 : BEQ .BRANCH_BETA
                    CMP.b #$04 : BEQ .BRANCH_GAMMA
                        CMP.b #$05 : BEQ .BRANCH_DELTA
                            CMP.b #$06 : BEQ .BRANCH_EPSILON
                                BRL .BRANCH_XI
                    
                    .BRANCH_EPSILON
                    
                    BRL .BRANCH_LAMBDA
                    
                .BRANCH_BETA
                
                LDA.l $7EF36C : CMP.l $7EF36D : BNE .BRANCH_ZETA
            
            .BRANCH_ALPHA
            
            BRL LinkGoBeep
            
            .BRANCH_ZETA
            
            LDA.b #$02 : STA.l $7EF35C, X
            
            STZ.w $0301
            
            LDA.b #$04 : STA.b $11
            
            LDA.b $10 : STA.w $010C
            
            LDA.b #$0E : STA.b $10
            
            LDA.b #$07 : STA.w $0208
            
            JSL.l HUD.RebuildLong
            
            RTS
            
            .BRANCH_GAMMA
            
            LDA.l $7EF36E : CMP.b #$80 : BNE .BRANCH_THETA
                BRL LinkGoBeep
            
            .BRANCH_THETA
            
            LDA.b $02 : STA.l $7EF35C, X
            
            STZ.w $0301
            
            ; Submodule ????
            LDA.b #$08 : STA.b $11
            
            LDA.b $10 : STA.w $010C
            
            ; Go to text mode.
            LDA.b #$0E : STA.b $10
            
            LDA.b #$07 : STA.w $0208
            
            JSL.l HUD.RebuildLong
            
            BRA .BRANCH_IOTA
            
            .BRANCH_DELTA
            
            LDA.l $7EF36C : CMP.l $7EF36D : BNE .useBluePotion
                LDA.l $7EF36E : CMP.b #$80 : BNE .useBluePotion
                    BRL LinkGoBeep
            
            .useBluePotion
            
            LDA.b #$02 : STA.l $7EF35C, X
            
            STZ.w $0301
            
            LDA.b #$09 : STA.b $11
            
            LDA.b $10 : STA.w $010C
            
            LDA.b #$0E : STA.b $10
            
            LDA.b #$07 : STA.w $0208
            
            JSL.l HUD_RebuildLong
            
            BRA .BRANCH_IOTA
            
            .BRANCH_LAMBDA
            
            STZ.w $0301
            
            JSL.l PlayerItem_SpawnFairy : BPL .BRANCH_NU
                BRL LinkGoBeep
            
            .BRANCH_NU
            
            LDA.b #$02 : STA.l $7EF35C, X
            
            JSL.l HUD_RebuildLong
            
            BRA .BRANCH_IOTA
            
            .BRANCH_XI
            
            STZ.w $0301
            
            JSL.l PlayerItem_ReleaseBee : BPL .bee_spawn_success
                BRL LinkGoBeep
            
            .bee_spawn_success
            
            LDA.b #$02 : STA.l $7EF35C, X
            
            JSL.l HUD.RebuildLong
            
            .BRANCH_IOTA
            
            RTS
}

; ==============================================================================

; $03A24A-$03A24C DATA
UNREACHABLE_07A24A:
{
    db $18, $10, $00
}

; ==============================================================================

; $03A24D-$03A288 LOCAL JUMP LOCATION
LinkItem_Lamp:
{
    LDA.b $6C : BNE .no_input
        JSR.w Link_CheckNewY_ButtonPress : BCC .no_input
            ; Lamp
            LDA.l $7EF34A : BEQ .cant_use_lamp
                LDX.b #$06 : JSR.w LinkItem_EvaluateMagicCost : BCC .cant_use_lamp
                    LDY.b #$00
                    LDA.b #$1A
                    
                    JSL.l AddMagicPowder
                    
                    JSL.l Dungeon_LightTorch
                    
                    LDY.b #$02
                    LDA.b #$2F
                    
                    JSL.l AddLampFlame
            
            .cant_use_lamp
            
            STZ.w $0301
            STZ.b $3A
            STZ.b $3C
            STZ.b $50
            
            LDA.b $3C : CMP.b #$09 : BNE .dont_reset_player_speed
                STZ.b $5E
            
            .dont_reset_player_speed
    .no_input

    ; $03A288 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $03A289-$03A292 DATA
LinkItem_MagicPowder_timer:
{
    db $02, $01, $01, $03
    db $02, $02, $02, $02
    db $06, $00
}

; $03A293-$03A312 JUMP LOCATION
LinkItem_Mushroom:
LinkItem_MagicPowder:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE LinkItem_Lamp_return
            JSR.w Link_CheckNewY_ButtonPress : BCC .return
                LDA.l $7EF344 : CMP.b #$02 : BEQ .isMagicPowder
                    LDA.b #$3C : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_DELTA
                
                .isMagicPowder
                
                LDX.b #$02
                
                JSR.w LinkItem_EvaluateMagicCost : BCC .BRANCH_DELTA
                    LDA.w .timer : STA.b $3D
                    
                    STZ.w $0300
                    STZ.b $2E
                    
                    LDA.b $67 : AND.b #$F0 : STA.b $67
                    
                    STZ.w $0301
                    
                    LDA.b #$40 : TSB.w $0301
    
    .BRANCH_ALPHA
    
    STZ.b $30
    STZ.b $31
    STZ.b $67
    STZ.b $2A
    STZ.b $2B
    STZ.b $6B
    
    DEC.b $3D : BPL .return
        LDA.w $0300 : INC A : STA.w $0300 : TAX
        
        LDA.w .timer, X : STA.b $3D
        
        CPX.b #$04 : BNE .BRANCH_EPSILON
            LDY.b #$00
            LDA.b #$1A
            
            JSL.l AddMagicPowder
        
        .BRANCH_EPSILON
        
        CPX.b #$09 : BNE .return
        
        LDA.b $11 : BNE .BRANCH_DELTA
            LDY.b #$01
            
            JSR.w TileDetect_MainHandler
            
            BRA .BRANCH_DELTA ; OPTIMIZE: Lol what?
        
        .BRANCH_DELTA
        
        STZ.w $0301
        STZ.w $0300
        
        LDA.b $3A : AND.b #$BF : STA.b $3A
    
    ; $03A312 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; Play flute or use the shovel
; $03A313-$03A31F LOCAL JUMP LOCATION
LinkItem_ShovelAndFlute:
{
    ; What is the state of the flute?
    LDA.l $7EF34C : BEQ LinkItem_MagicPowder_return
        CMP.b #$01 : BEQ LinkItem_Shovel
            BRL LinkItem_Flute
}

; ==============================================================================

; $03A320-$03A32B DATA
Pool_LinkItem_Shovel:
{
    ; $03A320
    .timer
    db   7,  18,  16
    db   7,  18,  16

    ; $03A326
    .pose
    db $00, $01, $02
    db $00, $01, $02
}

; Shovel item code
; $03A32C-$03A3DA LONG BRANCH LOCATION
LinkItem_Shovel:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE LinkItem_MagicPowder_return
            JSR.w Link_CheckNewY_ButtonPress : BCC LinkItem_MagicPowder_return
                LDA.w Pool_LinkItem_Shovel_timer : STA.b $3D
                
                STZ.w $030D
                STZ.w $0300
                
                LDA.b #$01 : STA.w $037A
                
                LDA.b #$01 : TSB.b $50
                
                STZ.b $2E
        
    .BRANCH_ALPHA
    
    JSR.w HaltLinkWhenUsingItems
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    DEC.b $3D : BMI .BRANCH_BETA
        RTS
    
    .BRANCH_BETA
    
    LDX.w $030D : INX : STX.w $030D
    
    LDA.w Pool_LinkItem_Shovel_timer, X : STA.b $3D
    
    LDA.w Pool_LinkItem_Shovel_pose, X : STA.w $0300 : CMP.b #$01 : BNE .BRANCH_GAMMA
        LDY.b #$02
        
        PHX
        
        JSR.w TileDetect_MainHandler
        
        PLX
        
        LDA.w $04B2 : BEQ .BRANCH_DELTA
            LDA.b #$1B : JSR.w Player_DoSfx3
            
            PHX
            
            ; Add recovered flute (from digging). Interesting...
            LDY.b #$00
            LDA.b #$36
            
            JSL.l AddRecoveredFlute
            
            PLX
        
        .BRANCH_DELTA
        
        LDA.w $0357 : ORA.w $035B : AND.b #$01 : BNE .BRANCH_EPSILON
            PHX
            
            LDY.b #$00
            LDA.b #$16
            
            JSL.l AddHitStars
            
            PLX
            
            LDA.b #$05 : JSR.w Player_DoSfx2
            
            BRA .BRANCH_GAMMA
        
        .BRANCH_EPSILON
        
        PHX
        
        ; Add shovel dirt? what? I thought these were aftermath tiles.
        LDY.b #$00
        LDA.b #$17
        
        JSL.l AddShovelDirt
        
        LDA.w $03FC : BEQ .digging_game_inactive
            JSL.l DiggingGameGuy_AttemptPrizeSpawn
        
        .digging_game_inactive
        
        PLX
        
        LDA.b #$12 : JSR.w Player_DoSfx2
    
    .BRANCH_GAMMA
    
    CPX.b #$03 : BNE .return
        STZ.w $030D
        STZ.w $0300
        
        LDA.b $3A : AND.b #$80 : STA.b $3A
        
        STZ.w $037A
        
        LDA.b $50 : AND.b #$FE : STA.b $50
    
    ; $03A3DA ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; Code for the flute item (with or without the bird activated)
; $03A3DB-$03A45E LONG BRANCH LOCATION
LinkItem_Flute:
{
    BIT.b $3A : BVC .y_button_not_held
        DEC.w $03F0 : LDA.w $03F0 : BNE LinkItem_Shovel_return
            LDA.b $3A : AND.b #$BF : STA.b $3A
    
    .y_button_not_held
    
    JSR.w Link_CheckNewY_ButtonPress : BCC LinkItem_Shovel_return
        ; Success... play the flute.
        LDA.b #$80 : STA.w $03F0
        
        LDA.b #$13 : JSR.w Player_DoSfx2
        
        ; Are we indoors?
        LDA.b $1B : BNE LinkItem_Shovel_return
            ; Are we in the dark world? The flute doesn't work there.
            LDA.b $8A : AND.b #$40 : BNE LinkItem_Shovel_return
                ; Also doesn't work in special areas like Master Sword area.
                LDA.b $10 : CMP.b #$0B : BEQ LinkItem_Shovel_return
                    LDX.b #$04
                    
                    .next_ancillary_slot
                    
                        ; Is there already a travel bird effect in this slot?
                        LDA.w $0C4A, X : CMP.b #$27 : BEQ LinkItem_Shovel_return
                    ; If there isn't one, keep checking.
                    DEX : BPL .next_ancillary_slot
                    
                    ; Paul's weathervane stuff Do we have a normal flute
                    ; (without bird)?
                    LDA.l $7EF34C : CMP.b #$02 : BNE .travel_bird_already_released
                        REP #$20
                        
                        ; Check the area, is it #$18 = 30?
                        LDA.b $8A : CMP.w #$0018 : BNE .not_weathervane_trigger
                            ; Y coordinate boundaries for setting it off.
                            LDA.b $20
                            
                            CMP.w #$0760 : BCC .not_weathervane_trigger
                            CMP.w #$07E0 : BCS .not_weathervane_trigger
                                ; If( (Ycoord >= 0x0760) && (Ycoord < 0x07e0)
                                LDA.b $22
                                
                                CMP.w #$01CF : BCC .not_weathervane_trigger
                                CMP.w #$0230 : BCS .not_weathervane_trigger
                                    ; If( (Xcoord >= 0x1cf) && (Xcoord < 0x0230)
                                    SEP #$20
                                    
                                    ; Apparently a special Overworld mode for
                                    ; doing this?
                                    LDA.b #$2D : STA.b $11
                                    
                                    ; Trigger the sequence to start the
                                    ; weathervane explosion.
                                    LDY.b #$00
                                    LDA.b #$37
                                    
                                    JSL.l AddWeathervaneExplosion
                        
                        .not_weathervane_trigger
                        
                        SEP #$20
                        
                        BRA .return
                    
                    .travel_bird_already_released
                    
                    LDY.b #$04
                    LDA.b #$27
                    
                    JSL.l AddTravelBird_pick_up
                    
                    STZ.w $03F8
                    
                    .return
                    
                    RTS
}

; ==============================================================================

; $03A45F-$03A470 LONG JUMP LOCATION
GanonEmerges_SpawnTravelBird:
{
    PHB : PHK : PLB
    
    LDA.b #$13 : JSR.w Player_DoSfx2
    
    ; Add travel bird.
    LDY.b #$04
    LDA.b #$27
    
    JSL.l AddTravelBird_pick_up
    
    PLB
    
    RTL
}

; ==============================================================================

; Book of Mudora (0x0B)
; $03A471-$03A493 LOCAL JUMP LOCATION
LinkItem_Book:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE LinkItem_Flute_return
            JSR.w Link_CheckNewY_ButtonPress : BCC .BRANCH_ALPHA
                LDA.b $3A : AND.b #$BF : STA.b $3A
                
                LDA.w $02ED : BNE .BRANCH_BETA
                    LDA.b #$3C : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_ALPHA
                
                .BRANCH_BETA
                
                BRL Link_PerformDesertPrayer
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $03A494-$03A50E JUMP LOCATION
LinkItem_EtherMedallion:
{
    JSR.w Link_CheckNewY_ButtonPress : BCC .cant_cast_no_sound
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        LDA.b $6C : BNE .cant_cast_play_sound
            LDA.w $0FFC : BNE .cant_cast_play_sound
                LDA.w $0403 : AND.b #$80 : BNE .cant_cast_play_sound
                    LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .cant_cast_play_sound
                        LDA.l $7EF3D3 : BEQ .attempt_cast
                            LDA.l $7EF3CC : CMP.b #$0D : BNE .attempt_cast
        
        .cant_cast_play_sound
        
        BRL LinkGoBeep
        
        .attempt_cast
        
        LDA.w $0C4A : ORA.w $0C4B : ORA.w $0C4C : BNE .cant_cast_no_sound
            LDX.b #$01
            JSR.w LinkItem_EvaluateMagicCost : BCC .cant_cast_no_sound
                LDA.b #$08 : STA.b $5D
                
                LDA.b #$01 : TSB.b $50
                
                LDA.w .anim_timer : STA.b $3D
                
                STZ.w $031C
                STZ.w $031D
                STZ.w $0324
                
                LDA.b #$23 : JSR.w Player_DoSfx3
    
    .cant_cast_no_sound
    
    RTS

    ; $03A4F7
    .anim_step
    db $00, $01, $02, $03
    db $00, $01, $02, $03
    db $04, $05, $06, $07

    ; $03A503
    .anim_timer
    db $05, $05, $05, $05
    db $05, $05, $05, $05
    db $07, $07, $03, $03
}

; ETHER MEDALLION MODE
; $03A50F-$03A568 JUMP LOCATION
LinkState_UsingEther:
{
    INC.w $0FC1
    
    DEC.b $3D : BPL .return
        INC.w $031D : LDX.w $031D : CPX.b #$0B : BNE .BRANCH_BETA
            LDX.b #$0B
            
            BRA .BRANCH_GAMMA
        
        .BRANCH_BETA
        
        CPX.b #$04 : BNE .BRANCH_DELTA
            PHX
            
            LDA.b #$23 : JSR.w Player_DoSfx3
            
            PLX
        
        .BRANCH_DELTA
        
        CPX.b #$09 : BNE .BRANCH_EPSILON
            LDA.b #$2C : JSR.w Player_DoSfx2
        
        .BRANCH_EPSILON
        
        CPX.b #$0C : BNE .BRANCH_GAMMA
            LDA.b #$0A : STA.w $031D : TAX
        
        .BRANCH_GAMMA
        
        LDA.w LinkItem_EtherMedallion_anim_timer, X : STA.b $3D
        
        LDA.w LinkItem_EtherMedallion_anim_step, X : STA.w $031C
        
        LDA.w $0324 : BNE .return
        CPX.b #$0A  : BNE .return
            LDA.b #$01 : STA.w $0324
                
            LDY.b #$00
            LDA.b #$18
                
            JSL.l AddEtherSpell
                
            STZ.b $4D
            STZ.w $0046
    
    .return
    
    RTS
}

; ==============================================================================

; Bombos medallion (0x0E)
; $03A569-$03A5F6 LOCAL JUMP LOCATION
LinkItem_Bombos:
{
    JSR.w Link_CheckNewY_ButtonPress : BCC .return
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        LDA.b $6C : BNE .BRANCH_BETA
            LDA.w $0FFC : BNE .BRANCH_BETA
                LDA.w $0403 : AND.b #$80 : BNE .BRANCH_BETA
                    LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .BRANCH_BETA
                        LDA.l $7EF3D3 : BEQ .BRANCH_GAMMA
                            LDA.l $7EF3CC : CMP.b #$0D : BNE .BRANCH_GAMMA

        .BRANCH_BETA

        BRL LinkGoBeep

        .BRANCH_GAMMA

        LDA.w $0C4A : ORA.w $0C4B : ORA.w $0C4C : BNE .return
            LDX.b #$01
            
            JSR.w LinkItem_EvaluateMagicCost : BCC .return
                LDA.b #$09 : STA.b $5D
                
                LDA.b #$01 : TSB.b $50
                
                LDA.w .anim_timer : STA.b $3D
                
                LDA.w .anim_step : STA.w $031C
                
                STZ.w $031D
                STZ.w $0324
                
                LDA.b #$23 : JSR.w Player_DoSfx3

    .return

    RTS

    ; $03A5CF
    .anim_step
    db $00, $01, $02, $03
    db $00, $01, $02, $03
    db $08, $09, $0A, $0B
    db $0C, $0A, $08, $0D
    db $0E, $0F, $10, $11

    ; $03A5E3
    .anim_timer
    db   5,   5,   5,   5
    db   5,   5,   5,   5
    db   3,   3,   3,   3
    db   3,   7,   1,   1
    db   1,   1,   1,  13
}

; BOMBOS MEDALLION MODE
; $03A5F7-$03A64A JUMP LOCATION
LinkState_UsingBombos:
{
    INC.w $0FC1
    
    DEC.b $3D : BPL .return
        INC.w $031D : LDX.w $031D : CPX.b #$04 : BNE .BRANCH_BETA
            PHX
            
            LDA.b #$23 : JSR.w Player_DoSfx3
            
            PLX
        
        .BRANCH_BETA
        
        CPX.b #$0A : BNE .BRANCH_GAMMA
            PHX
            
            LDA.b #$2C : JSR.w Player_DoSfx2
            
            PLX
        
        .BRANCH_GAMMA
        
        CPX.b #$14 : BNE .BRANCH_DELTA
            LDA.b #$13 : STA.w $031D : TAX
        
        .BRANCH_DELTA
        
        LDA.w LinkItem_Bombos_anim_timer, X : STA.b $3D
        
        LDA.w LinkItem_Bombos_anim_step, X : STA.w $031C
        
        LDA.w $0324 : BNE .return
        CPX.b #$13  : BNE .return
            LDA.b #$01 : STA.w $0324
            
            LDY.b #$00
            LDA.b #$19
            
            JSR.w AddBombosSpell
            
            STZ.b $4D
            STZ.w $0046
    
    .return
    
    RTS
}

; ==============================================================================

; $03A64B-$03A6D5 JUMP LOCATION
LinkItem_Quake:
{
    JSR.w Link_CheckNewY_ButtonPress : BCC .return
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        LDA.b $6C : BNE .BRANCH_BETA
            LDA.w $0FFC : BNE .BRANCH_BETA
                LDA.w $0403 : AND.b #$80 : BNE .BRANCH_BETA
                    LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .BRANCH_BETA
                        LDA.l $7EF3D3 : BEQ .BRANCH_GAMMA
                            LDA.l $7EF3CC : CMP.b #$0D : BNE .BRANCH_GAMMA
            
        .BRANCH_BETA
        
        BRL LinkGoBeep
        
        .BRANCH_GAMMA
        
        LDA.w $0C4A : ORA.w $0C4B : ORA.w $0C4C : BNE .return
            LDX.b #$01
            
            JSR.w LinkItem_EvaluateMagicCost : BCC .return
                LDA.b #$0A : STA.b $5D
                
                LDA.b #$01 : TSB.b $50
                
                LDA.w .anim_timer : STA.b $3D
                
                LDA.w .anim_step : STA.w $031C
                
                STZ.w $031D
                STZ.w $0324
                STZ.b $46
                
                LDA.b #$28 : STA.w $0362 : STA.w $0363
                
                STZ.w $0364
                
                LDA.b #$23 : JSR.w Player_DoSfx3
    
    .return
    
    RTS

    ; $03A6BE
    .anim_step
    db $00, $01, $02, $03
    db $00, $01, $02, $03
    db $12, $13, $14, $16

    ; $03A6CA
    .anim_timer
    db   5,   5,   5,   5
    db   5,   5,   5,   5
    db   5,   5,   5,  19
}

; QUAKE MEDALLION CODE
; $03A6D6-$03A779 JUMP LOCATION
LinkState_UsingQuake:
{
    INC.w $0FC1
    
    STZ.b $27
    STZ.b $28
    
    LDA.w $031D : CMP.b #$0A : BNE .BRANCH_ALPHA
        LDA.w $0362 : STA.b $29
        
        LDA.w $0363 : STA.w $02C7
        
        LDA.w $0364 : STA.b $24
        
        LDA.b #$02 : STA.b $00 : STA.b $4D
        
        JSR.w Link_HandleChangeInZVelocity_preset
        JSL.l LinkHop_FindArbitraryLandingSpot
        
        LDA.b $29 : STA.w $0362
        
        LDA.w $02C7 : STA.w $0363
        
        LDA.b $24 : STA.w $0364 : BMI .BRANCH_BETA
            LDY.b #$14
            
            LDA.b $29 : BPL .BRANCH_GAMMA
                LDY.b #$15
            
            .BRANCH_GAMMA
            
            STY.w $031C
            
            BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA
    
    DEC.b $3D : BPL .BRANCH_DELTA
        .BRANCH_BETA
        
        INC.w $031D
        
        LDX.w $031D : CPX.b #$04 : BNE .BRANCH_EPSILON
            PHX
            
            LDA.b #$23 : JSR.w Player_DoSfx3
            
            PLX
        
        .BRANCH_EPSILON
        
        CPX.b #$0A : BNE .BRANCH_ZETA
            PHX
            
            LDA.b #$2C : JSR.w Player_DoSfx2
            
            PLX
            
        .BRANCH_ZETA
        
        CPX.b #$0B : BNE .BRANCH_THETA
            LDA.b #$0C : JSR.w Player_DoSfx2
        
        .BRANCH_THETA
        
        CPX.b #$0C : BNE .BRANCH_IOTA
            LDA.b #$0B : STA.w $031D : TAX
        
        .BRANCH_IOTA
        
        LDA.w Pool_LinkState_UsingQuake_anim_timer, X : STA.b $3D
        
        LDA.w Pool_LinkState_UsingQuake_anim_step, X : STA.w $031C
        
        LDA.w $0324 : BNE .BRANCH_DELTA
        CPX.b #$0B  : BNE .BRANCH_DELTA
            ; "Thank you, [Name], I had a feeling you were getting close"
            ; Message.
            LDA.b #$01 : STA.w $0324
            
            LDY.b #$00
            LDA.b #$1C
            
            JSL.l AddQuakeSpell
            
            STZ.b $4D
            STZ.w $0046
        
    .BRANCH_DELTA
    
    RTS
}

; $03A77A-$03A7AF LOCAL BRANCH LOCATION
Link_ActivateSpinAttack:
{
    LDY.b #$00 : TYX
    
    LDA.b $2A
    
    JSL.l AddSpinAttackStartSparkle

    ; Bleeds into the next function.
}
    
; $03A783-$03A7AE LOCAL JUMP LOCATION
Link_AnimateVictorySpin:
{
    ; Enter spin attack mode.
    LDA.b #$03 : STA.b $5D
    
    LDA.b $2F : LSR A : TAX
    
    LDA.w Pool_SpinAttack_data_offset, X : STA.w $031E : TAX
    
    LDA.w Pool_SpinAttack_anim_timer_a : STA.b $3D
    
    LDA.w Pool_SpinAttack_anim_step, X : STA.w $031C : STA.w $031D, X
    
    ; Trigger the spin attack motion.
    LDA.b #$90 : STA.b $3C
    
    LDA.b #$01 : TSB.b $50
    
    LDA.b #$80 : STA.b $3A
    
    BRL LinkState_SpinAttack ; GO TO SPIN ATTACK MODE.
}   

; $03A7AF-$03A7AF LOCAL JUMP LOCATION
UNREACHABLE_07A7AF:
{
    RTS
}

; $03A7B0-$03A7B7 LONG JUMP LOCATION
Link_AnimateVictorySpin_long:
{
    PHB : PHK : PLB
    
    JSR.w Link_AnimateVictorySpin
    
    PLB
    
    RTL
}

; $03A7B8-$03A803 DATA
Pool_SpinAttack:
{
    ; $03A7B8
    .anim_step
    db $0A, $0B, $0A, $06, $07, $08, $09, $02, $03, $04, $05, $0A ; up
    db $00, $01, $00, $02, $03, $04, $05, $06, $07, $08, $09, $00 ; down
    db $0C, $0D, $0C, $04, $05, $06, $07, $08, $09, $02, $03, $0C ; left
    db $0E, $0F, $0E, $08, $09, $02, $03, $04, $05, $06, $07, $0E ; right

    ; $03A7E8
    .anim_timer_a
    db $03, $09, $03 ; up
    db $01, $01, $01 ; down
    db $01, $01, $01 ; left
    db $01, $01, $05 ; right

    ; $03A7F4
    .anim_timer_b
    db $01, $05, $01 ; up
    db $01, $01, $01 ; down
    db $01, $01, $01 ; left
    db $01, $01, $05 ; right

    ; $03A800
    .data_offset
    db $00 ; up
    db $0C ; down
    db $18 ; left
    db $24 ; right
}

; Link mode 0x03 - Spin Attack Mode
; $03A804-$03A8EB JUMP LOCATION
LinkState_SpinAttack:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    
    ; Check to see if Link is in a ground state.
    LDA.b $4D : BEQ .BRANCH_ALPHA
        LDX.b #$04
        ; He isn't.
        
        .BRANCH_DELTA
        
            LDA.w $0C4A, X
            
            CMP.b #$2A : BEQ .BRANCH_BETA
                CMP.b #$2B : BNE .BRANCH_GAMMA
            
            .BRANCH_BETA
            
            STZ.w $0C4A, X
            
            .BRANCH_GAMMA
        DEX : BPL .BRANCH_DELTA
        
        STZ.b $25
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        STZ.b $3D
        STZ.b $3C
        STZ.b $3A
        STZ.b $3B
        STZ.w $031C
        STZ.w $031D
        STZ.b $5E
        
        ; OPTIMIZE: Lol what?
        LDA.b $1B : BNE .BRANCH_EPSILON
        
        .BRANCH_EPSILON
        
        LDA.w $0360 : BEQ .BRANCH_ZETA
            LDA.b $55 : BEQ .BRANCH_THETA
                JSR.w Link_ForceUnequipCape_quietly
            
            .BRANCH_THETA
            
            JSR.w Link_ResetSwordAndItemUsage
            
            LDA.b #$01 : STA.w $037B
            
            STZ.w $0300
            
            LDA.b #$02 : STA.b $3D
            
            STZ.b $2E
            
            LDA.b $67 : AND.b #$F0 : STA.b $67
            
            LDA.b #$2B : JSR.w Player_DoSfx3
            
            LDA.b #$07 : STA.b $5D
            
            BRL Player_Electrocution
        
        .BRANCH_ZETA
        
        LDA.b #$02 : STA.b $5D
        
        BRL LinkState_Recoil ; GO TO RECOIL MODE
    
    .BRANCH_ALPHA
    
    LDA.b $46 : BEQ .BRANCH_IOTA ; Link's movement data is being taken in.
        JSR.w Link_HandleRecoilAndTimer ; Link Can't move, do some other stuff.
        
        BRA .BRANCH_KAPPA
    
    .BRANCH_IOTA
    
    STZ.b $67 ; Not sure...
    
    JSL.l Link_HandleVelocity
    JSR.w Link_HandleCardinalCollision
    
    LDA.b #$03 : STA.b $5D
    
    STZ.w $0302
    
    JSR.w HandleIndoorCameraAndDoors
    
    .BRANCH_KAPPA
    
    ; Do we have to wait?
    DEC.b $3D : BPL .return ; You need to wait to spin attack still...
        ; Step Link through the animation.
        ; On the second motion begin the spinning sound.
        LDA.w $031D : INC A : STA.w $031D : CMP.b #$02 : BNE .BRANCH_MU
            LDA.b #$23 : JSR.w Player_DoSfx3
        
        .BRANCH_MU
        
        LDA.w $031D : CMP.b #$0C : BNE .BRANCH_NU
            ; Do this if on the 12th step.
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            STZ.b $3D
            STZ.b $3C
            STZ.w $031C
            STZ.w $031D
            
            LDA.b $5D : CMP.b #$1E : BEQ .BRANCH_XI
                LDX.b #$00
                
                LDA.b $3C : BEQ .BRANCH_OMICRON
                    LDA.b $F0 : AND.b #$80 : TAX
                
                .BRANCH_OMICRON
                
                STX.b $3A
            
            .BRANCH_XI
            
            LDA.b #$00 : STA.b $5D
            
            BRA .return
            
        .BRANCH_NU
        
        ; $031E IS TYPICALLY 12, I.E. #$C.
        LDA.w $031D : CLC : ADC.w $031E : TAX
        
        ; Determine which graphic to display while spinning.
        LDA.w Pool_SpinAttack_anim_step, X : STA.w $031C
        
        LDX.w $031D
        
        ; Determine the frame delay between changing the sprites.
        LDY.w Pool_SpinAttack_anim_timer_b, X : STY.b $3D
        
        LDY.b #$08
        
        JSR.w TileDetect_MainHandler
    
    .return
    
    RTS
}

; $03A8EC-$03A919 LOCAL JUMP LOCATION
UNREACHABLE_07A8EC:
{
    LDY.b #$00
    LDX.b #$01
    LDA.b #$2A
    
    JSL.l AddSpinAttackStartSparkle
    
    LDA.b #$1E : STA.b $5D
    
    LDA.b $2F : LSR A : TAX
    
    LDA.w Pool_SpinAttack_data_offset, X : STA.w $031E : TAX
    
    LDA.w Pool_SpinAttack_anim_timer_a : STA.b $3D
    
    LDA.w Pool_SpinAttack_anim_step, X : STA.w $031C
    
    STZ.w $031D
    
    LDA.b #$01 : TSB.b $50
    
    BRL LinkState_SpinAttack ; GO TO SPIN ATTACK MODE.
}

; Magic Mirror routine
; $03A91A-$03A954 LOCAL JUMP LOCATION
LinkItem_Mirror:
{
    ; Check for a press of the Y button.
    BIT.b $3A : BVS .BRANCH_ALPHA
        JSR.w Link_CheckNewY_ButtonPress : BCC LinkState_SpinAttack_return
            ; Seems the Kiki tagalong prevents you from warping?
            LDA.l $7EF3CC : CMP.b #$0A : BNE .BRANCH_ALPHA
                REP #$20
                
                ; Probably Kiki yelling at you not to warp.
                LDA.w #$0121 : STA.w $1CF0
                
                SEP #$20
                
                JSL.l Main_ShowTextMessage
                
                BRL Mirror_TryToWarp_cantWarp
    
    .BRANCH_ALPHA ; Y Button pressed.
    
    ; Erase all input except for the Y button.
    LDA.b $3A : AND.b #$BF : STA.b $3A
    
    ; If Link's standing in a doorway he can't warp.
    LDA.b $6C : BNE .BRANCH_BETA
        LDA.w $037F : BNE Mirror_TryToWarp
            ; Am I indoors?
            LDA.b $1B : BNE Mirror_TryToWarp
                ; Check if we're in the dark world.
                LDA.b $8A : AND.b #$40 : BNE Mirror_TryToWarp

    .BRANCH_BETA

    ; Bleeds into the next function.
}
    
; $03A955-$03A95B LOCAL JUMP LOCATION
LinkGoBeep:
{
    ; Play the "you can't do that" sound.
    LDA.b #$3C : JSR.w Player_DoSfx2
    
    BRA Mirror_TryToWarp_cantWarp
}
    
; $03A95C-$03A9B0 LOCAL JUMP LOCATION
Mirror_TryToWarp:
{
    LDA.b $1B : BEQ .outdoors
        LDA.w $0FFC : BNE .cantWarp
            JSL.l Dungeon_SaveRoomData
            
            LDA.w $012E : CMP.b #$3C : BEQ .cantWarp
                STZ.w $05FC
                STZ.w $05FD
                
                BRA .cantWarp
    
    .outdoors
    
    LDA.b $10 : CMP.b #$0B : BEQ .inSpecialOverworld
        LDA.b $8A : AND.b #$40 : STA.b $7B : BEQ .inLightWorld
            ; If we're warping from the dark world to the light world
            ; we generate new coordinates for the warp vortex.
            LDA.b $20 : STA.w $1ADF
            LDA.b $21 : STA.w $1AEF
            
            LDA.b $22 : STA.w $1ABF
            LDA.b $23 : STA.w $1ACF
        
        .inLightWorld
        
        LDA.b #$23
        
        ; $03A99C ALTERNATE ENTRY POINT
        .SetGameModeLikeMirror
        
        STA.b $11
        
        STZ.w $03F8
        
        LDA.b #$01 : STA.w $02DB
        
        STZ.b $B0
        STZ.b $27
        STZ.b $28
        
        ; Go into magic mirror mode.
        LDA.b #$14 : STA.b $5D
        
        .cantWarp
    .inSpecialOverworld
    
    RTS
}

; ==============================================================================

; Link Mode 0x14 MAGIC MIRROR (And / or Whirpool warping?)
; $03A9B1-$03AA6B JUMP LOCATION
LinkState_CrossingWorlds:
{
    JSL.l Link_ResetProperties_B
    JSR.w TileCheckForMirrorBonk
    
    LDA.b $8A : AND.b #$40 : CMP.b $7B : BNE .BRANCH_ALPHA
        BRL .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b $0C : ORA.b $0E : STA.b $00 : AND.b #$0C : BEQ .BRANCH_BETA
        ; Could have just used BIT, ya know.
        LDA.b $00 : AND.b #$03 : BNE .BRANCH_GAMMA
            LDA.b $00 : AND.b #$0F : BEQ .BRANCH_BETA
                LDX.b #$03
                LDY.b #$00
                
                .BRANCH_EPSILON
                
                    LSR A : BCC .BRANCH_DELTA
                        INY
                    
                    .BRANCH_DELTA
                DEX : BPL .BRANCH_EPSILON
                
                CPY.b #$02 : BCC .BRANCH_BETA
        
        .BRANCH_GAMMA
        
        ; Signal a warp failure and send Link back to the world he came from.
        LDA.b #$2C
        
        BRA Mirror_TryToWarp_SetGameModeLikeMirror
    
    .BRANCH_BETA
    
    LDY.b #$00
    LDX.b #$03
    
    LDA.w $0341
    
    .checkNextDeepWaterBit
    
        LSR A : BCC .deepWaterBitNotSet
            INY
        
        .deepWaterBitNotSet
    DEX : BPL .checkNextDeepWaterBit
    
    CPY.b #$02 : BCC .BRANCH_KAPPA
    
    LDA.l $7EF356 : BNE .haveFlippers
        LDA.b $8A : AND.b #$40 : CMP.b $7B : BNE .BRANCH_GAMMA
            JSL.l Link_CheckSwimCapability
            
            BRA .BRANCH_KAPPA
    
    .haveFlippers
    
    LDA.b #$01 : STA.w $0345
    
    LDA.b $26 : STA.w $0340
    
    JSL.l Player_ResetSwimState
    
    LDA.b #$04 : STA.b $5D
    
    JSR.w Link_ForceUnequipCape_quietly
    
    STZ.b $5E
    
    BRA .BRANCH_MU
    
    .BRANCH_KAPPA
    
    LDA.w $0345 : BEQ .BRANCH_NU
        STZ.w $0345
        
        LDA.w $0340 : STA.b $26
    
    .BRANCH_NU
    
    STZ.w $0374
    STZ.w $0372
    STZ.b $5E
    STZ.b $3A
    STZ.b $3C
    STZ.b $50
    STZ.w $032B
    STZ.b $27
    
    LDA.b $8A : AND.b #$40 : CMP.b $7B : BEQ .BRANCH_XI
        STZ.w $04AC
        STZ.w $04AD
    
    .BRANCH_XI
    
    LDY.b #$00
    
    LDA.l $7EF357 : BNE .playerHasMoonPearl
        LDA.b $8A : AND.b #$40 : BEQ .inLightWorld
            LDY.b #$17

        .inLightWorld
    .playerHasMoonPearl
    
    STY.b $5D
    
    .BRANCH_MU
    
    RTS
}

; ==============================================================================

; $03AA6C-$03AAA1 LOCAL JUMP LOCATION
Link_PerformDesertPrayer:
{
    ; Begin moving the Desert Palace barricades
    ; Put us in submodule 5 of text mode.
    LDA.b #$05 : STA.b $11
    
    LDA.b $10 : STA.w $010C
    
    ; Go to text mode.
    LDA.b #$0E : STA.b $10
    
    LDA.b #$01 : STA.w $0FC1
    LDA.b #$16 : STA.w $030B
    
    STZ.w $030A
    
    LDA.b #$02 : STA.w $0308
    
    ; Lock Link's direction.
    LDA.b #$01 : TSB.b $50
    
    STZ.b $2E
    
    ; Make it so Link is considered to not be walking at all.
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    ; Play that sad sanctuary-esque tune while the bubble comes up.
    LDA.b #$11 : STA.w $012D
    
    LDA.b #$F2 : STA.w $012C ; Halve the normal music's volume.
    
    RTS
}

; $03AAA2-$03AB24 LONG JUMP LOCATION
HandleFollowersAfterMirroring:
{
    PHB : PHK : PLB
    
    LDY.b #$00
    
    JSR.w TileDetect_MainHandler
    
    STZ.b $2E
    
    LDA.l $7EF3CC : CMP.b #$0C : BEQ .thiefChest
        CMP.b #$0D : BNE .notSuperBomb
            LDA.b #$FE : STA.w $04B4
            
            STZ.w $04B5
        
    .thiefChest
    
    ; Super bomb related
    LDA.l $7EF3D3 : BEQ .checkPlayerPoofPotential
        LDA.b #$00 : STA.l $7EF3D3
        
        BRA .terminateTagalong
        
        .notSuperBomb
        
        LDA.l $7EF3CC : CMP.b #$09 : BEQ .terminateTagalong
            CMP.b #$0A : BNE .preserveTagalong
        
        .terminateTagalong
        
        LDA.b #$00 : STA.l $7EF3CC
        
        BRA .checkPlayerPoofPotential
        
        .preserveTagalong
        
        LDY.b #$07 : LDA.l $7EF3CC : CMP.b #$08 : BEQ .isDwarf
            LDY.b #$08 : CMP.b #$07 : BNE .checkPlayerPoofPotential
        
        .isDwarf
        
        TYA : STA.l $7EF3CC
        
        JSL.l Tagalong_LoadGfx
        
        LDY.b #$04
        LDA.b #$40
        
        JSL.l AddDwarfTransformationCloud
    
    .checkPlayerPoofPotential
    
    ; Moon pearl
    LDA.l $7EF357 : BNE .hasMoonPearl
        LDY.b #$04
        LDA.b #$23
        
        JSL.l AddWarpTransformationCloud
        JSR.w Link_ForceUnequipCape_quietly
        
        STZ.w $02E2
        
        BRA .return
    
    .hasMoonPearl
    
    LDA.b $55 : BEQ .return
        JSR.w Link_ForceUnequipCape
        
        STZ.w $02E2
    
    .return
    
    PLB
    
    RTL
}

; $03AB25-$03AB6B JUMP LOCATION
LinkItem_Hookshot:
{
    LDA.b $3A : AND.b #$40 : BNE .return
        LDA.b $6C : BNE .return
            LDA.b $48 : AND.b #$02 : BNE .return
                JSR.w Link_CheckNewY_ButtonPress : BCC .return
                    JSR.w Player_ResetSwimCollision
                    
                    STZ.w $0300
                    
                    LDA.b #$01 : TSB.b $50
                    
                    LDA.b #$07 : STA.b $3D
                    
                    STZ.b $2E
                    
                    LDA.b $67 : AND.b #$F0 : STA.b $67
                    
                    LDA.w $037A : AND.b #$00 : ORA.b #$04 : STA.w $037A
                    
                    ; Hookshot
                    LDA.b #$13 : STA.b $5D
                    
                    LDA.b #$01 : STA.w $037B
                    
                    LDY.b #$03
                    LDA.b #$1F
                    
                    JSL.l AddHookshot
    
    ; $03AB6B ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $03AB6C-$03AB73 DATA
Hookdrag_Offset:
{
    ; $03AB6C
    .Y
    db $F8 ; up
    db $F0 ; down
    db $00 ; left
    db $00 ; right

    ; $03AB70
    .X
    db $00 ; up
    db $00 ; down
    db $04 ; left
    db $F4 ; right
}

; $03AB74-$03AB7B DATA
HookdragSpeeds:
{
    ; $03AB74
    .Vertical
    db $C0 ; up
    db $40 ; down
    db $00 ; left
    db $00 ; right

    ; $03AB78
    .Horizontal
    db $00 ; up
    db $00 ; down
    db $C0 ; left
    db $40 ; right
}

; Link mode 0x13 - Hookshot
; $03AB7C-$03ADBD JUMP LOCATION
LinkState_Hookshotting:
{
    STZ.w $0373
    STZ.b $4D
    STZ.b $46
    
    LDX.b #$04

    .BRANCH_BETA

        LDA.w $0C4A, X : CMP.b #$1F : BEQ .BRANCH_ALPHA
    DEX : BPL .BRANCH_BETA
    
    DEC.b $3D : LDA.b $3D : BPL LinkItem_Hookshot_return
        STZ.w $0300
        STZ.w $037B
        
        LDA.b $3A : AND.b #$BF : STA.b $3A
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        LDA.w $037A : AND.b #$FB : STA.w $037A
        
        LDA.b #$00 : STA.b $5D
        
        LDA.b $3C : CMP.b #$09 : BCC .BRANCH_GAMMA
            LDA.b #$09 : STA.b $3C

        .BRANCH_GAMMA

        RTS

        .BRANCH_ALPHA

        DEC.b $3D : BPL .BRANCH_DELTA
            STZ.b $3D

        .BRANCH_DELTA

        LDA.w $037E : BNE .BRANCH_EPSILON
            LDA.b $20 : STA.b $3E
            LDA.b $22 : STA.b $3F
            
            STZ.b $30
            STZ.b $31
            
            BRL Link_HandleCardinalCollision

        .BRANCH_EPSILON

        STZ.w $02F5
        
        LDX.w $039D
        
        DEC.w $0C5E, X : BPL .BRANCH_ZETA
            STZ.w $0C5E, X
            
            BRL .BRANCH_XI

        .BRANCH_ZETA

        LDA.w $0BFA, X : STA.b $00
        LDA.w $0C0E, X : STA.b $01
        
        LDA.w $0C04, X : STA.b $02
        LDA.w $0C18, X : STA.b $03
        
        LDY.w $0C72, X
        
        STZ.b $05
        
        LDA.w Hookdrag_Offset_Y, Y : STA.b $04 : BPL .BRANCH_THETA
            LDA.b #$FF : STA.b $05

        .BRANCH_THETA

        STZ.b $07
        
        LDA.w Hookdrag_Offset_X, Y : STA.b $06 : BPL .BRANCH_IOTA
            LDA.b #$FF : STA.b $07

        .BRANCH_IOTA

        STZ.b $27
        STZ.b $28
        
        LDA.w HookdragSpeeds_Vertical, Y : STA.b $08 : STZ.b $09
        LDA.w HookdragSpeeds_Horizontal, Y : STA.b $0A : STZ.b $0B
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.b $04 : SEC : SBC.b $20 : BPL .BRANCH_KAPPA
            EOR.w #$FFFF : INC A

        .BRANCH_KAPPA

        CMP.w #$0002 : BCC .BRANCH_LAMBDA
            LDA.b $27 : AND.w #$FF00 : ORA.b $08 : STA.b $27

        .BRANCH_LAMBDA

        LDA.b $02 : CLC : ADC.b $06 : SEC : SBC.b $22 : BPL .BRANCH_MU
            EOR.w #$FFFF : INC A

        .BRANCH_MU

        CMP.w #$0002 : BCC .BRANCH_NU
            LDA.b $28 : AND.w #$FF00 : ORA.b $0A : STA.b $28

        .BRANCH_NU

        SEP #$20
        
        LDA.b $27 : ORA.b $28 : BEQ .BRANCH_XI
            BRL .BRANCH_PSI

        .BRANCH_XI

        ; Terminate the hookshot object if we have reached our destination.
        LDX.w $039D
        
        STZ.w $0C4A, X
        
        LDA.w $02D3 : STA.w $02D1
        
        LDA.b #$00 : STA.b $5D
        
        STZ.w $0300
        STZ.b $3D
        STZ.w $037E
        
        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
        LDA.w $037A : AND.b #$FB : STA.w $037A
        
        STZ.w $037B
        
        LDA.w $03A4, X : BEQ .BRANCH_OMICRON
            LDA.w $0476 : EOR.b #$01 : STA.w $0476
            
            DEC.b $A4
            
            LDA.w $044A : BNE .BRANCH_PI
                LDA.b $A0 : STA.w $048E
                
                CLC : ADC.b #$10 : STA.b $A0

            .BRANCH_PI

            LDA.w $044A : CMP.b #$02 : BEQ .BRANCH_RHO
                LDA.b $EE : EOR.b #$01 : STA.b $EE

            .BRANCH_RHO

            JSL.l Dungeon_SaveRoomQuadrantData

        .BRANCH_OMICRON

        JSR.w Player_TileDetectNearby
        
        LDA.w $0341 : AND.b #$0F : BEQ .BRANCH_SIGMA
            LDA.w $0345 : BNE .BRANCH_SIGMA
                LDA.b #$01 : STA.w $0345
                
                LDA.b $26 : STA.w $0340
                
                JSL.l Player_ResetSwimState
                
                LDA.b #$15
                LDY.b #$00
                
                JSL.l AddTransitionSplash ; $0498FC IN ROM
                
                LDA.b #$04 : STA.b $5D
                
                JSR.w Link_ForceUnequipCape_quietly
                
                STZ.w $0308
                STZ.w $0309
                STZ.w $0376
                STZ.b $5E
                
                LDA.b $1B : BEQ .BRANCH_TAU
                    LDA.b #$01 : STA.b $EE

                .BRANCH_TAU

                BRA .BRANCH_UPSILON

        .BRANCH_SIGMA

        LDA.b $59 : AND.b #$0F : BEQ .BRANCH_PHI
            LDA.b #$09 : STA.b $5C
            
            STZ.b $5A
            
            LDA.b #$01 : STA.b $5B
            LDA.b #$01 : STA.b $5D
            
            BRA .BRANCH_UPSILON

        .BRANCH_PHI

        LDA.b $20 : STA.b $3E
        LDA.b $22 : STA.b $3F
        LDA.b $21 : STA.b $40
        LDA.b $23 : STA.b $41
        
        JSR.w Link_HandleCardinalCollision
        
        BRL .BRANCH_ALIF

        .BRANCH_UPSILON

        LDA.b $3C : CMP.b #$09 : BCC .BRANCH_CHI
            LDA.b #$09 : STA.b $3C

        .BRANCH_CHI

        BRL .return

        .BRANCH_PSI

        JSL.l LinkHop_FindArbitraryLandingSpot
        
        LDY.b #$05
        
        JSR.w TileDetect_MainHandler
        
        LDA.b $1B : BEQ .BRANCH_OMEGA
            LDA.w $036D : LSR #4 : ORA.w $036D : ORA.w $036E : AND.b #$01 : BEQ .BRANCH_OMEGA
                DEC.w $03F9 : BPL .BRANCH_OMEGA
                    LDA.b #$03 : STA.w $03F9
                    
                    LDA.w $037E : EOR.b #$02 : STA.w $037E

        .BRANCH_OMEGA

        STZ.w $0351
        
        LDA.w $037E : AND.b #$02 : BNE .BRANCH_ALIF
            LDA.w $0357 : AND.b #$01 : BEQ .BRANCH_BET
                LDA.b #$02 : STA.w $0351
                
                JSR.w Link_PermissionForSloshSounds : BCS .BRANCH_ALIF
                    LDA.b #$1A : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_ALIF

            .BRANCH_BET

            LDA.w $0359 : ORA.w $0341 : AND.b #$01 : BEQ .BRANCH_ALIF
                INC.w $0351
                
                LDA.b $8A : CMP.b #$70 : BNE .BRANCH_DEL
                    LDA.b #$1B : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_ALIF

                .BRANCH_DEL

                LDA.b #$1C : JSR.w Player_DoSfx2

        .BRANCH_ALIF

        JSR.w HandleIndoorCameraAndDoors
        
        ; $03ADBD ALTERNATE ENTRY POINT
        .return

        RTS
}

; ==============================================================================

; Note: Higher timers mean it takes longer for a point of magic power
; to be consumed by the cape. Also note that the 1/4th magic consumption
; status isn't any better than 1/2 in this case.
; $03ADBE-$03ADC0 DATA
LinkItem_Cape_mp_depletion_timers:
{
    db 4, 8, 8
}

; Magic Cape routine
; $03ADC1-$03AE46 JUMP LOCATION
LinkItem_Cape:
{
    ; Is the magic cape already activated?
    LDA.b $55 : BNE .BRANCH_ALPHA
        DEC.w $02E2 : BMI .BRANCH_BETA
            LDA.b $67 : AND.b #$F0 : STA.b $67
            
            BRL HaltLinkWhenUsingItems
        
        .BRANCH_BETA
        
        STZ.w $02E2
        
        LDA.b $6C : BNE LinkState_Hookshotting_return
            JSR.w Link_CheckNewY_ButtonPress : BCC LinkState_Hookshotting_return
                LDA.b $3A : AND.b #$BF : STA.b $3A
                
                LDA.l $7EF36E : BEQ .BRANCH_$3AE62
                
                STZ.w $0300
                
                LDA.b #$01 : STA.b $55
                
                LDA.l $7EF37B : TAY
                
                LDA.w .mp_depletion_timers, Y : STA.b $4C
                
                LDA.b #$14 : STA.w $02E2
                
                LDY.b #$04
                LDA.b #$23
                
                JSL.l AddTransformationCloud
                
                LDA.b #$14 : JSR.w Player_DoSfx2
                
                BRA Link_ForceUnequipCape_return
    
    .BRANCH_ALPHA
    
    ; Make Link invincible this frame.
    LDA.b #$01 : STA.w $037B
    
    JSR.w HaltLinkWhenUsingItems
    
    LDA.b $67 : AND.b #$F0 : STA.b $67 : DEC.b $4C
    
    ; Wait this many frames to deplete magic.
    LDA.b $4C : BNE .BRANCH_GAMMA
        ; Load Link's magic power reserves.
        LDA.l $7EF37B : TAY
        
        ; Load the next delay timer.
        LDA.w .mp_depletion_timers, Y : STA.b $4C
        
        ; If the magic counter has totally depleted, branch.
        LDA.l $7EF36E : DEC A : STA.l $7EF36E : BEQ .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    DEC.w $02E2 : BPL Link_ForceUnequipCape_return
        STZ.w $02E2
        
        ; Check the Y button.
        LDA.b $F4 : AND.b #$40 : BEQ Link_ForceUnequipCape_return

        .BRANCH_DELTA

    ; Bleeds into the next function.
}

; $03AE47-$03AE61 LOCAL JUMP LOCATION
Link_ForceUnequipCape:
{     
    LDY.b #$04
    LDA.b #$23
            
    JSL.l AddTransformationCloud
            
    LDA.b #$15 : JSR.w Player_DoSfx2
            
    ; $03AE54 ALTERNATE ENTRY POINT
    .quietly
            
    LDA.b #$20 : STA.w $02E2
            
    STZ.w $037B
    STZ.b $55
    STZ.w $0360
    
    ; $03AE61 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $03AE62-$03AE64 BRANCH LOCATION
CannotEquipCape:
{
    BRL Link_DisplayNoMagicMessage
}

; ==============================================================================

; $03AE65-$03AE87 LOCAL JUMP LOCATION
HaltLinkWhenUsingItems:
{
    LDA.b $AD : CMP.b #$02 : BNE .BRANCH_ALPHA
        LDA.w $0322 : AND.b #$03 : CMP.b #$03 : BNE .BRANCH_ALPHA
            STZ.b $30
            STZ.b $31
            STZ.b $67
            STZ.b $2A
            STZ.b $2B
            STZ.b $6B
    
    .BRANCH_ALPHA
    
    ; Cane of Somaria transit lines?
    LDA.w $02F5 : BEQ .return
        STZ.b $67
    
    ; $03AE87 ALTERNATE ENTRY POINT
    .return
    
    RTS
}
    
; ==============================================================================

; $03AE88-$03AE8E LOCAL JUMP LOCATION
Link_HandleCape_passive_LiftCheck:
{
    LDA.w $0308 : AND.b #$80 : BEQ HaltLinkWhenUsingItems_return
        ; Bleeds into the next function.
}

; $03AE8F-$03AEBF LOCAL JUMP LOCATION
Link_HandleCape_passive:
{
    ; Check Link's invincibility status.
    ; He's not in the cape form..
    LDA.b $55 : BEQ HaltLinkWhenUsingItems_return
        ; He is in cape form (invisible and invincible).
        ; Does Link need to transform into the cape form?
        LDA.w $0304 : CMP.b #$13 : BNE HaltLinkWhenUsingItems_return
            ; Link might need to transform, but if he's already transformed,
            ; then not.
            CMP.w $0303 : BNE .BRANCH_GAMMA
                ; It seems to me that the load is unnecessary... correct me if
                ; I'm wrong.
                DEC.b $4C : LDA.b $4C : BNE .BRANCH_DELTA
                    LDA.l $7EF37B : TAY
                    
                    LDA LinkItem_Cape_mp_depletion_timers, Y : STA.b $4C
                    
                    LDA.l $7EF36E : BEQ .BRANCH_DELTA
                        DEC A : STA.l $7EF36E : BNE .BRANCH_DELTA
            
            .BRANCH_GAMMA
            
            JSR.w Link_ForceUnequipCape
            
            .BRANCH_DELTA
            
            RTS
}

; ==============================================================================

; $03AEC0-$03AF3A JUMP LOCATION
LinkItem_CaneOfSomaria:
{
    BIT.b $3A : BVS .y_button_held
        LDA.w $02F5 : BNE HaltLinkWhenUsingItems_return
            LDA.b $6C : BNE HaltLinkWhenUsingItems_return
                JSR.w Link_CheckNewY_ButtonPress : BCC HaltLinkWhenUsingItems_return
                    LDX.b #$04
                    
                    .next_obj_slot
                    
                        LDA.w $0C4A, X : CMP.b #$2C : BEQ .is_somaria_block
                    DEX : BPL .next_obj_slot
                    
                    LDX.b #$04
                    
                    JSR.w LinkItem_EvaluateMagicCost : BCC HaltLinkWhenUsingItems_return
                        .is_somaria_block
                        
                        LDA.b #$01 : STA.w $0350
                        
                        LDY.b #$01
                        LDA.b #$2C
                        
                        JSL.l AddSomarianBlock
                        
                        LDA.w RodAndCaneAnimationTimer : STA.b $3D
                        
                        STZ.b $2E
                        STZ.w $0300
                        STZ.w $0301
                        
                        LDA.b #$08 : TSB.w $037A
                    
    .y_button_held
                    
    JSR.w HaltLinkWhenUsingItems

    LDA.b $67 : AND.b #$F0 : STA.b $67
                    
    DEC.b $3D : BPL .return           
        LDA.w $0300 : INC A : STA.w $0300 : TAX
                    
        LDA.w RodAndCaneAnimationTimer, X : STA.b $3D
                    
        CPX.b #$03 : BNE .return
                    
            STZ.b $5E
            STZ.w $0300
            STZ.b $3D
            STZ.w $0350
                        
            LDA.b $3A : AND.b #$BF : STA.b $3A
                        
            LDA.w $037A : AND.b #$F7 : STA.w $037A

    ; $03AF3A ALTERNATE ENTRY POINT  
    .return
                    
    RTS
}

; ==============================================================================

; $03AF3B-$03AF3D DATA
Pool_PlayerItem_CaneOfByrna:
{
    .animation_delays
    db 19, 7, 13
}

; Cane of Byrna
; $03AF3E-$03AFB4 JUMP LOCATION
PlayerItem_CaneOfByrna:
{
    ; Check to see if it's okay to do.
    JSR.w SearchForByrnaSpark : BCS LinkItem_CaneOfSomaria_return
        ; Check to see if the Y button is down.
        BIT.b $3A : BVS .BRANCH_ALPHA
            ; Yes it's down.
            LDA.b $6C : BNE LinkItem_CaneOfSomaria_return
                JSR.w Link_CheckNewY_ButtonPress : BCC LinkItem_CaneOfSomaria_return
                    LDX.b #$08
                    
                    JSR.w LinkItem_EvaluateMagicCost : BCC .BRANCH_BETA
                        LDY.b #$00
                        LDA.b #$30
                        
                        JSL.l AddCaneOfByrnaStart
                        
                        STZ.b $79
                        
                        ; TODO: Is this supposed to have a , X or , Y?
                        LDA Pool_PlayerItem_CaneOfByrna_animation_delays : STA.b $3D
                        
                        STZ.w $030D
                        STZ.w $0300
                        
                        LDA.b #$08 : STA.w $037A
                        
                        LDA.b #$01 : TSB.b $50
                        
                        STZ.b $2E
        
        .BRANCH_ALPHA
        
        JSR.w HaltLinkWhenUsingItems
        
        LDA.b $67 : AND.b #$F0 : STA.b $67
        
        DEC.b $3D : BPL .return
            LDX.w $0300 : INX : STX.w $0300
            
            ; BUG: (unconfirmed) It seems to me that you could run one past the
            ; end  of the designated data for this... Though the resulting
            ; value is probably not used anyway. Still... unsafe!
            ; TODO: Check the status of this in a debugger.
            LDA.w .animation_delays, X : STA.b $3D
            
            CPX.b #$01 : BNE .BRANCH_DELTA
                PHX
                
                LDA.b #$2A : JSR.w Player_DoSfx3
                
                PLX
            
            .BRANCH_DELTA
            
            CPX.b #$03 : BNE .return
                .BRANCH_BETA
                
                STZ.w $030D
                STZ.w $0300
                
                LDA.b $3A : AND.b #$80 : STA.b $3A
                
                STZ.w $037A
                
                LDA.b $50 : AND.b #$FE : STA.b $50
        
        ; $03AFB4 ALTERNATE ENTRY POINT
        .return
        
        RTS
}

; ==============================================================================

; $03AFB5-$03AFCB LOCAL JUMP LOCATION
SearchForByrnaSpark:
{
    ; Is link trying to cast the byrna spell?
    LDA.w $037A : AND.b #$08 : BNE .cane_not_equipped
        LDX.b #$04
        
        .nextSlot
        
            LDA.w $0C4A, X : CMP.b #$31 : BEQ .found_spark
        DEX : BPL .nextSlot

    ; Yeah, so he's not done yet.
    .cane_not_equipped
    
    ; This indicates to the caller that the Byrna spell is being started but is
    ; not yet fully operational.
    CLC
    
    RTS
    
    .found_spark
    
    SEC
    
    RTS
}

; ==============================================================================

; $03AFCC-$03AFF7 DATA
Pool_LinkItem_Net:
{
    ; $03AFCC
    .pose_id
    db $0B, $06, $07, $08, $01, $02, $03, $04, $05, $06 ; Up
    db $01, $02, $03, $04, $05, $06, $07, $08, $01, $02 ; Down
    db $09, $04, $05, $06, $07, $08, $01, $02, $03, $04 ; Left
    db $0A, $08, $01, $02, $03, $04, $05, $06, $07, $08 ; Right

    ; $03AFF4
    .pose_offset
    db $00 ; Up
    db $0A ; Down
    db $14 ; Left
    db $1E ; Right
}

; $03AFF8-$03B072 LOCAL JUMP LOCATION
LinkItem_Net:
{
    BIT.b $3A : BVS .BRANCH_ALPHA
        LDA.b $6C : BNE PlayerItem_CaneOfByrna_return
            JSR.w Link_CheckNewY_ButtonPress : BCC PlayerItem_CaneOfByrna_return
                LDA.b $2F : LSR A : TAY
                
                LDX.w Pool_LinkItem_Net_pose_offset, Y
                
                LDA.w Pool_LinkItem_Net_pose_id, X : STA.w $0300
                
                LDA.b #$03 : STA.b $3D
                
                STZ.w $030D, X
                
                LDA.b #$10 : STA.w $037A
                
                LDA.b #$01 : TSB.b $50
                
                STZ.b $2E
                
                LDA.b #$32 : JSR.w Player_DoSfx2
    
    .BRANCH_ALPHA
    
    JSR.w HaltLinkWhenUsingItems
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    DEC.b $3D : BPL .BRANCH_BETA
        LDX.w $030D : INX : STX.w $030D
        
        LDA.b #$03 : STA.b $3D
        
        LDA.b $2F : LSR A : TAY
        
        LDA.w Pool_LinkItem_Net_pose_offset, Y : CLC : ADC.w $030D : TAY
        
        LDA.w Pool_LinkItem_Net_pose_id, Y : STA.w $0300
        
        CPX.b #$0A : BNE .BRANCH_BETA
            STZ.w $030D
            STZ.w $0300
            
            LDA.b $3A : AND.b #$80 : STA.b $3A
            
            STZ.w $037A
            
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            LDA.b #$80 : STA.b $44
                         STA.b $45
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $03B073-$03B086 LOCAL JUMP LOCATION
Link_CheckNewY_ButtonPress:
{
    ; Check if the Y button is already down.
    BIT.b $3A : BVS .noNewInput
        ; Flag to see if Link is recoiling from damage or other stuff.
        LDA.b $46 : BNE .noNewInput
            ; Check joypad readings for new input during this frame.
            LDA.b $F4 : AND.b #$40 : BEQ .noNewInput
                TSB.b $3A
                
                SEC
                
                RTS
    
    .noNewInput
    
    ; I'm guessing this is like a cancel indicator.
    CLC
    
    RTS
}

; ==============================================================================

; Magic costs for various items.
; $03B087-$03B0AA DATA
LinkItem_MagicCosts:
{
    ; Fire rod and ice rod
    ; $03B087
    .cost
    db $10, $08, $04
    
    ; Medallion spells
    ; $03B08A
    db $20, $10, $08
    
    ; Magic powder
    ; $03B08D
    db $08, $04, $02
    
    ; Unused?
    ; $03B090
    db $08, $04, $02
    
    ; Cane of Somaria
    ; $03B093
    db $08, $04, $02
    db $10, $08, $04
    
    ; Lamp
    ; $03B099
    db $04, $02, $02
    
    ; Unused?
    ; $03B08C
    db $08, $04, $02
    
    ; Cane of Byrna
    ; $03B09F
    db $10, $08, $04

    ; $03B0A2
    .cost_offset
    db $00 ; Rods
    db $03 ; Medallion
    db $06 ; Powder
    db $09
    db $0C ; Somaria
    db $0F
    db $12 ; Lamp
    db $15
    db $18 ; Byrna
}

; ==============================================================================

; $03B0AB-$03B0D3 LOCAL JUMP LOCATION
LinkItem_EvaluateMagicCost:
{
    STX.b $02
    
    ; Load an index into the table below.
    LDA LinkItem_MagicCostBaseIndices, X : CLC : ADC.l $7EF37B : TAX
    
    ; This tells us how much magic to deplete.
    LDA LinkItem_MagicCosts, X : STA.b $00
    
    LDA.l $7EF36E : BEQ .notEnoughMagicPoints
        ; Subtract the amount off of the magic meter.
        ; Check to see if the amount is negative.
        SEC : SBC.b $00 : CMP.b #$80 : BCS .notEnoughMagicPoints
            ; Otherwise just take it like a man.
            STA.l $7EF36E
            
            ; Indicates success.
            SEC
            
            RTS
        
    .notEnoughMagicPoints
    
    ; Load the item index.
    LDA.b $02 : CMP.b #$03 : BEQ Link_DisplayNoMagicMessage_return
        ; Bleeds into the next function.
}

; $03B0D4-$03B0E8 LOCAL JUMP LOCATION
Link_DisplayNoMagicMessage:
{
    ; You naughty boy you have no magic power!
    LDA.b #$3C : JSR.w Player_DoSfx2
    
    REP #$20
    
    ; Prints that annoying message saying you're out of magic power.
    LDA.w #$007B : STA.w $1CF0
    
    SEP #$20
    
    JSL.l Main_ShowTextMessage
    
    ; $03B0E7 ALTERNATE ENTRY POINT
    .return
    
    CLC
    
    RTS
}

; ==============================================================================

; $03B0E9-$03B106 LONG JUMP LOCATION
LinkItem_ReturnUnusedMagic:
{
    PHB : PHK : PLB
    
    LDA LinkItem_MagicCostBaseIndices, X : CLC : ADC.l $7EF37B : TAX
    
    LDA LinkItem_MagicCosts, X : STA.b $00
    
    LDA.l $7EF36E : CLC : ADC.b $00 : STA.l $7EF36E
    
    PLB
    
    RTL
}

; ==============================================================================

; $03B107-$03B11B LONG JUMP LOCATION
Link_ItemReset_FromOverworldThings:
{
    STZ.w $030A
    STZ.b $3B
    STZ.w $0308
    STZ.w $0309
    STZ.w $0376
    
    LDA.b $50 : AND.b #$FE : STA.b $50
    
    RTL
}

; ==============================================================================

; Code for picking things up
; $03B11C-$03B198 LOCAL JUMP LOCATION
Link_Lift:
{
    ; The flag for if there's a sprite to pick up or the lag for if there's an
    ; ancilla to pick up.
    LDA.w $0314  : ORA.w $02EC : BNE .BRANCH_ALPHA
        ; Prep Link for picking things up.
        JSR.w Link_ResetSwordAndItemUsage
        
        STZ.b $3B
        
        LDX.b #$0F
        
        .nextSpriteSlot
        
            LDA.w $0DD0, X : BEQ .openSpriteSlot
        DEX : BPL .nextSpriteSlot
        
        BRA .noOpenSpriteSlots
        
        .openSpriteSlot
        
        LDA.w $0368
        
        CMP.b #$05 : BEQ .isLargeRock
            CMP.b #$06 : BNE .notLargeRock
        
        .isLargeRock
        
        LDA.b #$01 : STA.w $0300
        
        BRA .BRANCH_THETA
        
        .notLargeRock
        
        LDA.b $1B : BEQ .outdoor_lifted_tile_replace_logic
            JSL.l Dungeon_RevealCoveredTiles
            
            BRA .determine_sprite_to_spawn
        
        .outdoor_lifted_tile_replace_logic
        
        JSL.l Overworld_LiftableTiles
        
        .determine_sprite_to_spawn
        
        LDX.b #$08
        
        .find_matching_tile_attrribute
        
            CMP.w Pool_LinkToss_liftable_tiles, X : BEQ .tile_attribute_match
        DEX : BPL .find_matching_tile_attrribute
        
        .noOpenSpriteSlots
        
        BRL Link_APress_LiftCarryThrow
        
        .tile_attribute_match
        
        LDA.b #$01 : STA.w $0314
        
        TXA
        
        JSL.l Sprite_SpawnThrowableTerrain
        
        ; Negate further A button presses.
        ASL.b $F6 : LSR.b $F6
    
    .BRANCH_ALPHA
    
    STZ.w $0300
    
    .BRANCH_THETA
    
    STZ.b $3A
    
    ; Set an animation timer.
    LDA.w Pool_LinkToss_timer_a : STA.w $030B
    
    ; Set it so Link is kneeling down to pick up the item.
    LDA.b #$01 : STA.w $0309
    
    LDA.b #$80 : STA.w $0308
    
    STZ.w $030A
    
    LDA.b #$0C : STA.b $5E
    
    STZ.b $2E
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    LDA.b #$01 : TSB.b $50
    
    ; $03B198 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $03B199-$03B1C9 DATA
Pool_LinkToss:
{
    ; $03B199
    .timer_a
    db $06, $07, $07

    ; Tile attributes to compare with... replacement tiles resulting from
    ; picking stuff up?
    ; $03B19C
    .timer_b
    db $05, $0A, $00, $17, $00, $12, $00, $12
    db $00, $08, $00, $08, $00, $FE, $FF, $11
    db $00
        
    ; $03B1AD
    .liftable_tiles
    db $54, $52, $50, $FF
    db $51, $53, $55, $56
    db $57
    
    ; $03B1B6
    .heavy_lift_animation_timers
    db   8,  24,   8,  24
    db   8,  32,   6,   8
    db  13,  13

    ; $03B1C0
    .heavy_lift_animation_steps
    db $00, $01, $00, $01
    db $00, $01, $00, $01
    db $02, $03
}

; $03B1CA-$03B280 LOCAL JUMP LOCATION
Link_APress_LiftCarryThrow:
{
    LDA.w $0308 : BEQ Link_Lift_return
    
        ; Is Link throwing an item?
        LDA.w $0309 : AND.b #$02 : BEQ .alpha
            LDA.w $030B : CMP.b #$05 : BCC .alpha
                LDA.w Pool_LinkToss_timer_b : STA.w $030B
        
        .alpha
        
        ; Is Link picking up an item?
        ; No...
        LDA.w $0309 : BEQ .notPickingSomethingUp
            ; Link is picking up an item, handle it.
            JSR.w HaltLinkWhenUsingItems
        
        .notPickingSomethingUp
        
        ; Is Link still picking up something?
        LDA.w $0309 : AND.b #$01 : BEQ .notPickingUpInProgress
            STZ.b $2E
            STZ.b $2D
            
            ; Make it so Link does not appear to be walking.
            LDA.b $67 : AND.b #$F0 : STA.b $67
        
        .notPickingUpInProgress
        
        ; Timer used for picking up the item and throwing it.
        DEC.w $030B : LDA.w $030B : BNE Link_Lift_return
            LDA.w $0309 : AND.b #$02 : BEQ .delta
                STZ.w $0308
                STZ.b $48
                STZ.b $5E
                
                LDA.b $5D : CMP.b #$18 : BNE .BRANCH_EPSILON
                    LDA.b #$00 : STA.b $5D
                    
                    BRL .BRANCH_EPSILON
            
            .delta
            
            LDA.w $0300 : BEQ .BRANCH_ZETA
                INC A : CMP.b #$09 : BEQ .BRANCH_EPSILON
                    STA.w $0300 : TAX
                    
                    LDA.w Pool_LinkToss_heavy_lift_animation_timers, X : STA.w $030B
                    
                    LDA.w Pool_LinkToss_heavy_lift_animation_steps, X : STA.w $030A
                    
                    CPX.b #$06 : BNE .return
                        STZ.w $0B9C
                        
                        LDA.b $1B : BEQ .outdoors
                            JSL.l Dungeon_RevealCoveredTiles
                            
                            BRA .BRANCH_KAPPA
                        
                        .outdoors
                        
                        JSL.l Overworld_LiftableTiles
                        
                        .BRANCH_KAPPA
                        
                        AND.b #$0F : INC A : PHA
                        
                        ; Put Link into the "under a heavy rock" mode.
                        LDA.b #$18 : STA.b $5D
                        
                        LDA.b #$01 : STA.w $0314
                        
                        PLA
                        
                        JSL.l Sprite_SpawnThrowableTerrain
                        
                        ASL.b $F6 : LSR.b $F6
                        
                        BRA .return
            
            .BRANCH_ZETA
            
            LDX.w $030A : INX
            
            LDA.w Pool_LinkToss_timer_a, X : STA.w $030B
            
            STX.w $030A : CPX.b #$03 : BNE .return
                .BRANCH_EPSILON
                
                STZ.w $0309
                
                LDA.b $50 : AND.b #$FE : STA.b $50
            
            ; $03B280 ALTERNATE ENTRY POINT
            .return
            
            RTS
}

; ==============================================================================

; Commented by Zarby89
; $03B281-$03B2ED LOCAL JUMP LOCATION
Link_PerformDash:
{
    ; Are we on a somaria platform?
    LDA.w $02F5 : BNE Link_APress_LiftCarryThrow_return
        ; Touching a sprite?
        LDA.w $0314 : ORA.w $02EC : BNE Link_APress_LiftCarryThrow_return
            ; Holding an object?
            BIT.w $0308 : BMI Link_APress_LiftCarryThrow_return
            
                ; Are we inside?
                LDA.b $1B : BNE .BRANCH_ALPHA 
                    ; OPTIMIZE: Useless branch.

                .BRANCH_ALPHA
                
                STZ.b $3B ; Reset A button.
                    
                LDA.b #$1D : STA.w $0374 ; Dash timer
                    
                LDA.b #$40 : STA.w $02F1 ; Dash timer related
                    
                LDA.b #$11 : STA.b $5D ; Set player in falling state...
                    
                LDA.b #$01 : STA.w $0372 ; Will bounce if touch (bonk)
                    
                ; B button has been held for more than 1 frame.
                LDA.b $3A : AND.b #$80 : STA.b $3A

                ; Clear a bunch of variables related to player.
                STZ.w $0308
                STZ.w $0301
                STZ.b $48
                STZ.b $6B
                    
                LDA.l $7EF3CC : TAX ; Get the follower ID in X.

                ; N  Z  OM OM OM IZ BM FR DW TH KI ?? TC SB MS
                ; FF 00 02 00 00 00 00 00 00 00 00 00 00 00 00
                CMP.w FollowerReactionToDashing, X : BNE .tagalong_not_enabled_for_this
                    ; Basically, only the old man makes it through here
                    ; (tagalong  0x02).

                    ; Set walking speed to normal.
                    STZ.b $5E
                        
                    ; Tagalong state.
                    LDX.w $02CF
                    
                    ; BUG: This is not cool, bro. Writing to bank 0x07?
                    ; Perhaps mentionable enough that maybe they wanted the
                    ; player  to lose the old man here? This is a mistake and
                    ; was ment to write to SRM. ex: STA.l $7EF3CD. See the
                    ; latter half of thefunction Tagalong_NoTimedMessage in
                    ; tagalong.asm.

                    ; Grabbing Y Position (position to grab it back).
                    LDA.w $1A00, X : STA.w $F3CD
                    LDA.w $1A14, X : STA.w $F3CE
                        
                    ; Grabbing X Position (position to grab it back).
                    LDA.w $1A28, X : STA.w $F3CF
                    LDA.w $1A3C, X : STA.w $F3D0
                        
                    LDA.b $EE : STA.w $F3D2 ; Dungeon Layer
                        
                    LDA.b #$40 : STA.w $02D2 ; Timer to reaquire big bomb

                .tagalong_not_enabled_for_this

                ; $03B2ED ALTERNATE ENTRY POINT
                .return
                
                RTS
}

; ==============================================================================

; Link grabs a wall action
; $03B2EE-$03B30F JUMP LOCATION
Link_PerformGrab:
{
    LDA.b $3A : AND.b #$80 : BEQ .noCurrentAction
        LDA.b $3C : CMP.b #$09 : BCS Link_PerformDash_return
    
    .noCurrentAction
    
    LDA.b #$01 : STA.w $0376 : TSB.b $50
    
    STZ.b $2E
    STZ.w $030A
    
    LDA.w LinkStrain_timer : STA.w $030B
    
    STZ.w $030D
    
    RTS
}

; ==============================================================================

; $03B310-$03B313 DATA
LinkPull_Directions:
{
    db $04
    db $08
    db $01
    db $02
}

; $03B314-$03B321 DATA
LinkStrain:
{
    ; $03B314
    .timer
    db   0,   5,   5,  12,   5,   5,  12

    ; $03B31B
    .char
    db $00, $01, $02, $03, $01, $02, $03
}

; Pre grabbing a wall?
; $03B322-$03B372 JUMP LOCATION
Link_APress_PullObject:
{
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    LDA.b $2F : LSR A : TAX
    
    LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_ALPHA
        AND.w LinkPull_Directions, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDX.b #$00
    
    BRA .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    DEC.w $030B : BPL .BRANCH_DELTA
        LDA.w $030D
        
        INX : CPX.b #$07 : BNE .BRANCH_GAMMA
            LDX.b #$01
        
        .BRANCH_GAMMA
        
        STX.w $030D
        
        LDA.w LinkStrain_char, X : STA.w $030A
        LDA.w LinkStrain_timer, X : STA.w $030B
    
    .BRANCH_DELTA
    
    LDA.b $F2 : AND.b #$80 : BNE .BRANCH_EPSILON
        STZ.w $030D
        STZ.w $030A
        STZ.w $0376
        STZ.b $3B
        
        LDA.b $50 : AND.b #$FE : STA.b $50
    
    .BRANCH_EPSILON
    
    RTS
}

; ==============================================================================

; $03B373-$03B388 JUMP LOCATION
Link_MovableStatue:
{
    LDA.b #$02 : STA.w $0376
    
    LDA.b #$01 : TSB.b $50
    
    STZ.b $2E
    STZ.w $030A
    
    LDA.w LinkStrain_timer : STA.w $030B
    
    STZ.w $030D
    
    RTS
}

; ==============================================================================

; $03B389-$03B3E4 JUMP LOCATION
Link_APress_StatueDrag:
{
    LDA.b #$14 : STA.b $5E
    
    LDA.b $2F : LSR A : TAX
    
    LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_ALPHA
        AND.w LinkPull_Directions, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    STZ.b $67
    STZ.b $30
    STZ.b $31
    STZ.b $2E
    
    LDX.b #$00
    
    BRA .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    STA.b $67
    
    DEC.w $030B : BPL .BRANCH_DELTA
        LDX.w $030D : INX : CPX.b #$07 : BNE .BRANCH_GAMMA
            LDX.b #$01
        
        .BRANCH_GAMMA
        
        STX.w $030D
        
        LDA.w LinkStrain_char, X  : STA.w $030A
        LDA.w LinkStrain_timer, X : STA.w $030B
    
    .BRANCH_DELTA
    
    LDA.b $F2 : AND.b #$80 : BNE .BRANCH_EPSILON
        STZ.b $5E
        STZ.w $02FA
        STZ.w $030D
        STZ.w $030A
        STZ.w $0376
        STZ.b $3B
        
        LDA.b $50 : AND.b #$FE : STA.b $50
    
    .BRANCH_EPSILON
    
    RTS
}

; ==============================================================================

; $03B3E5-$03B40C JUMP LOCATION
Link_PerformRupeePull:
{
    ; Must be facing in the up direction in order to go rolling backwards.
    LDA.b $2F : BNE .notFacingUp
        JSL.l Player_ResetState
        
        LDA.b #$02 : STA.w $0376 : TSB.b $50
        
        STZ.b $2E
        STZ.w $030A
        
        LDA.w LinkStrain_timer : STA.w $030B
        
        STZ.w $030D
        
        ; Rolling backwards mode for Link.
        LDA.b #$1D : STA.b $5D
        
        STZ.b $27
        STZ.b $28
        STZ.b $3A
    
    ; $03B40C ALTERNATE ENTRY POINT
    .notFacingUp
    
    RTS
}

; ==============================================================================

; $03B40D-$03B416 DATA
LinkState_TreePull_step:
{
    db $00, $01, $02, $03
    db $04, $00, $01, $02
    db $03
}

; $03B416-$03B4F1 JUMP LOCATION
LinkState_TreePull:
{
    JSR.w CacheCameraPropertiesIfOutdoors
    
    LDA.b $4D : BEQ .durp
        BRL LinkState_Default_HandleLink_From1D
    
    .durp
    
    LDA.w $0376 : BEQ .BRANCH_ALPHA
        LDA.b $3A : BNE .BRANCH_BETA
            BIT.b $F2 : BPL .BRANCH_GAMMA
                LDA.b $F0 : AND.b #$04 : BEQ .BRANCH_DELTA
                    STA.b $3A
                    
                    LDA.b #$22 : JSR.w Player_DoSfx2
                    
                    BRA .BRANCH_BETA
            
            .BRANCH_GAMMA
            
            STZ.w $0376
            STZ.w $030D
            
            LDA.b #$02 : STA.w $030B : STZ.w $030A
            
            STZ.b $50
            
            LDA.b #$00 : STA.b $5D
            
            BRA .BRANCH_EPSILON
        
        .BRANCH_BETA
        
        DEC.w $030B : BPL .BRANCH_DELTA
            INC.w $030D : LDX.w $030D
            
            LDA.w LinkStrain_char, X : STA.w $030A
            LDA.w LinkStrain_timer, X : STA.w $030B
            
            CPX.b #$07 : BNE .BRANCH_DELTA
                STZ.w $0376
                STZ.w $030D
                
                LDA.b #$02 : STA.w $030B : STZ.w $030A
                
                LDA.b #$01 : STA.w $0308 : STZ.w $0309
                
                BRA .BRANCH_ALPHA
        
        .BRANCH_DELTA
        
        BRA .BRANCH_ZETA
    
    .BRANCH_ALPHA
    
    LDA.b $48 : AND.b #$09 : BNE .BRANCH_THETA
        LDA.w $030D : CMP.b #$09 : BNE .BRANCH_IOTA
            LDA.b $F4 : AND.b #$0F : BEQ .BRANCH_KAPPA
                .BRANCH_EPSILON
                
                LDA.b #$00 : STA.b $5D
                
                BRL LinkState_Default ; GO TO NORMAL MODE.
        
        .BRANCH_IOTA
        
        LDY.b #$00
        LDA.b #$1E
        
        JSL.l AddDashingDust_notYetMoving
        
        DEC.w $030B : BPL .BRANCH_LAMBDA
            INC.w $030D : LDX.w $030D
            
            LDA.b #$02 : STA.w $030B
            
            LDA.w .step, X : STA.w $030A
            
            LDA.b #$30 : STA.b $27
            
            CPX.b #$09 : BNE .BRANCH_LAMBDA
    
    .BRANCH_THETA
    
    STZ.b $2F
    STZ.w $0308
    STZ.b $50
    
    LDA.b #$00 : STA.b $5D
    
    BRA .BRANCH_MU
    
    .BRANCH_LAMBDA
    
    JSR.w Flag67WithDirections
    
    LDA.b $67 : AND.b #$03 : BNE .BRANCH_NU
        STZ.b $28
    
    .BRANCH_NU
    
    LDA.b $67 : AND.b #$0C : BNE .BRANCH_ZETA
        STZ.b $27
    
    .BRANCH_ZETA
    
    JSL.l LinkHop_FindArbitraryLandingSpot
    
    .BRANCH_KAPPA
    
    JSR.w Link_HandleCardinalCollision
    JSR.w HandleIndoorCameraAndDoors
    
    .BRANCH_MU
    
    RTS
}

; ==============================================================================

; $03B4F2-$03B527 LOCAL JUMP LOCATION
Link_Read:
{
    REP #$30
    
    LDA.b $1B : AND.w #$00FF : BEQ .outdoors
        LDA.b $A0 : ASL A : TAY
        
        LDA Dungeon_SignText, Y
        
        BRA .showMessage
    
    .outdoors
    
    LDA.l $7EF3C5 : AND.w #$00FF : CMP.w #$0002 : BCS .savedZeldaOnce
        ; Only use one message for all "beginning" signs.
        ; That is, "The King will give 100 Rupees to..." message.
        LDA.w #$003A
        
        BRA .showMessage
    
    .savedZeldaOnce
    
    LDA.b $8A : ASL A : TAY
    
    LDA Overworld_SignText, Y
    
    .showMessage
    
    STA.w $1CF0
    
    SEP #$30
    
    JSL.l Main_ShowTextMessage
    
    STZ.b $3B
    
    ; $03B527 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $03B528-$03B573 DATA
Link_ReceiveItemAlternates:
{
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db -1,  -1,  -1,  -1, $44,  -1,  -1,  -1
    
    db -1,  -1, $35,  -1,  -1,  -1,  -1,  -1
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db -1,  -1, $46,  -1,  -1,  -1,  -1,  -1
    
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    
    db -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1
    db -1,  -1,  -1,  -1
}

; ==============================================================================

; Checks if we can open the chest, and sets up the transfer of the item to
; link's inventory.
; $03B574-$03B5BF JUMP LOCATION
Link_Chest:
{
    ; Not facing up... (can't open the chest).
    LDA.b $2F : BNE .cantAttempt
        ; Is Link already opening the chest?
        LDA.w $02E9 : BNE .cantAttempt
            ; Is Link in the auxiliary ground state?
            LDA.b $4D : BNE .cantAttempt
                ; Clear the A button location.
                STZ.b $3B
                
                LDA.b $76
                
                ; Carry clear means failure. So branch if it failed.
                JSL.l Dungeon_OpenKeyedObject : BCC .cantOpen
                    ; Set indicate that the Receive Item method is from a chest.
                    LDA.b #$01 : STA.w $02E9
                    
                    ; Okay... so what item did we get?
                    ; Items don't run into the negatives, so we messed up.
                    LDY.b $0C : BMI .cantOpen
                        ; Load an alternate item to use. If it's 0xFF it seems
                        ; obvious it isn't an alternate because items can't be
                        ; negative.
                        LDA Link_ReceiveItemAlternates, Y : STA.b $03
                        
                        CMP.b #$FF : BEQ .dontUseAlternate
                            TYA : ASL A : TAX
                            
                            ; Determine what memory location to give this item
                            ; over to. Effective address at [$00] is $7E:????
                            ; as determined above.
                            LDA ItemTargetAddr+0, X : STA.b $00
                            LDA ItemTargetAddr+1, X : STA.b $01
                            LDA.b #$7E              : STA.b $02
                            
                            ; Check what's at that location. Is it empty? (i.e.
                            ; zero?).
                            LDA [$00] : BEQ .dontUseAlternate
                                ; If we do have it, load the alternate.
                                LDY.b $03

                            ; We don't have it yet.
                        
                        .dontUseAlternate
                        
                        ; Link is opening a chest.
                        JSL.l Link_ReceiveItem
                        
                        BRA .return
                
                .cantOpen
                
                ; Set item method to... from text?
                STZ.w $02E9
    
    .cantAttempt
    .return
    
    RTS
}

; ==============================================================================

; $03B5C0-$03B5D5 LOCAL JUMP LOCATION
Link_CheckNewAPress:
{
    ; Is the A button already down?
    LDA.b $3B : AND.b #$80 : BNE .failure
        ; Can Link move?
        LDA.b $46 : BNE .failure
            ; Did the A button just go down this frame?
            LDA.b $F6 : AND.b #$80 : BEQ .failure
                ; Well, it was pushed this frame, so communicate that to $3B.
                TSB.b $3B
                
                SEC
                
                RTS

            ; No it was not pushed this frame.
        
    .failure
    
    ; Yep, it's down already.
    CLC
    
    RTS
}

; $03B5D6-$03B608 LOCAL JUMP LOCATION
Link_HandleToss:
{
    LDA.b $3B : AND.b #$80 : BEQ .aButtonNotDown
        ; axlr----, bystudlr's distant cousin.
        LDA.b $F6 : AND.b #$80 : BEQ .aButtonNotDown
            LDA.w $0309 : AND.b #$01 : BNE .aButtonNotDown
                STZ.w $030D
                STZ.w $030E
                STZ.w $030A
                
                STZ.b $3B
                
                LDA.b $50 : AND.b #$FE : STA.b $50
                
                ; Appears to be a debug variable, so it should always be zero.
                LDA.w $0305 : CMP.b #$01 : BNE .dontDisableMasks
                    STZ.b $1E
                    STZ.b $1F
                    
                .dontDisableMasks
                
                SEC
                
                RTS
    
    .aButtonNotDown
    
    CLC
    
    RTS
}

; $03B64B-$03B64E
StoppedFlags:
{
    db $07
    db $0B
    db $0D
    db $0E
}

; $03B64F-$03B65F LOCAL JUMP LOCATION
Link_HandleDiagonalCollision:
{
    JSR.w CheckIfRoomNeedsDoubleLayerCheck : BCC .onlyOneBg
        JSR.w FlagObstructions
        JSR.w CreateVelocityFromMovingBackground

    .onlyOneBg

    LDA.b $67 : AND.b #$0F : STA.b $67

    ; Bleeds into the next function.
}

; $03B660-$03B7C2 LOCAL JUMP LOCATION
FlagObstructions:
{
    LDA.b #$0F : STA.b $42 : STA.b $43
    
    STZ.b $6A
    
    ; Checking to see if either up or down was pressed.
    ; Yeah, one of them was.
    LDA.b $67 : AND.b #$0C : BNE .verticalWalking
        ; Neither up nor down was pressed.
        BRL .BRANCH_ULTIMA

    .verticalWalking

    INC.b $6A
    
    LDY.b #$00
    
    ; Walking in the up direction?
    AND.b #$08 : BNE .walkingUp
        ; Walking in the down direction.
        LDY.b #$02

    .walkingUp

    ; $66 = #$0 or #$1. #$1 if the down button, #$0 if the up button was pushed.
    TYA : LSR A : STA.b $66
    
    JSR.w TileDetect_Movement_VerticalSlopes
    
    LDA.b $0E : AND.b #$30 : BEQ .BRANCH_DELTA
        LDA.b $62 : AND.b #$02 : BNE .BRANCH_DELTA
            LDA.b $0E : AND.b #$30 : LSR #4 : AND.b $67 : BNE .BRANCH_DELTA
                LDY.b #$02
                
                LDA.b $67
                
                AND.b #$03 : BEQ .BRANCH_DELTA
                    AND.b #$02 : BNE .BRANCH_EPSILON
                        LDY.b #$03
                        
                        BRA .BRANCH_EPSILON

    .BRANCH_DELTA

    LDA.w $046C : BEQ .BRANCH_ZETA
        LDA.b $0E : AND.b #$03 : BNE .BRANCH_THETA
            BRA .BRANCH_IOTA

    .BRANCH_ZETA

    ; If Link is in the ground state, then branch.
    LDA.b $4D : BEQ .BRANCH_THETA
        LDA.b $0C : AND.b #$03 : BEQ .BRANCH_THETA
            BRA .BRANCH_MU

    .BRANCH_THETA

    LDA.b $0E : AND.b #$03 : BEQ .BRANCH_IOTA
        STZ.b $6B
        
        LDA.w $034A : BEQ .BRANCH_MU
            LDA.w $02E8 : AND.b #$03 : BNE .BRANCH_MU
                LDA.b $67 : AND.b #$03 : BEQ .BRANCH_MU
                    STZ.w $033C
                    STZ.w $033D
                    STZ.w $032F
                    STZ.w $0330
                    STZ.w $032B
                    STZ.w $032C
                    STZ.w $0334
                    STZ.w $0335

        .BRANCH_MU

        LDA.b #$01 : STA.w $0302
        
        LDY.b $66

        .BRANCH_EPSILON

        LDA.w StoppedFlags, Y : STA.b $42

    .BRANCH_IOTA

    LDA.b $67 : AND.b #$03 : BNE .BRANCH_LAMBDA
        BRL .BRANCH_ULTIMA

    .BRANCH_LAMBDA

    INC.b $6A
    
    LDY.b #$04
    
    AND.b #$02 : BNE .BRANCH_NU
        LDY.b #$06

    .BRANCH_NU

    TYA : LSR A : STA.b $66
    
    JSR.w TileDetect_Movement_HorizontalSlopes
    
    LDA.b $0E : AND.b #$30 : BEQ .BRANCH_XI
        LDA.b $62 : AND.b #$02 : BEQ .BRANCH_XI
            LDA.b $0E : AND.b #$30 : LSR #2 : AND.b $67 : BNE .BRANCH_XI
                LDY.b #$00
                
                LDA.b $67
                
                AND.b #$0C : BEQ .BRANCH_XI
                    AND.b #$08 : BNE .BRANCH_OMICRON
                        LDY.b #$01
                        
                        BRA .BRANCH_OMICRON

    .BRANCH_XI

    ; One BG collision
    LDA.w $046C : BEQ .BRANCH_PI
        LDA.b $0E : AND.b #$03 : BNE .BRANCH_RHO
            BRA .BRANCH_SIGMA

    .BRANCH_PI

    LDA.b $4D : BEQ .BRANCH_RHO
        LDA.b $0C : AND.b #$03 : BEQ .BRANCH_RHO
            BRA .BRANCH_UPSILON

    .BRANCH_RHO

    LDA.b $0E : AND.b #$03 : BEQ .BRANCH_SIGMA
        STZ.b $6B
        
        LDA.w $034A : BEQ .BRANCH_UPSILON
            LDA.w $02E8 : AND.b #$03 : BNE .BRANCH_UPSILON
                ; Check if Link is walking in an vertical direction.
                LDA.b $67 : AND.b #$0C : BEQ .BRANCH_UPSILON
                    STZ.w $033E
                    STZ.w $033F
                    STZ.w $0331
                    STZ.w $0332
                    STZ.w $032D
                    STZ.w $032E
                    STZ.w $0336
                    STZ.w $0337

        .BRANCH_UPSILON

        LDA.b #$01 : STA.w $0302
        
        LDY.b $66

        .BRANCH_OMICRON

        LDA.w StoppedFlags, Y : STA.b $43

    .BRANCH_SIGMA

    LDA.b $67 : AND.b $42 : AND.b $43 : STA.b $67

    .BRANCH_ULTIMA

    LDA.b $67 : AND.b #$0F : BEQ .BRANCH_PHI
        LDA.b $6B : AND.b #$0F : BEQ .BRANCH_PHI
            STA.b $67

    .BRANCH_PHI

    ; Is this checking if Link is moving diagonally?
    LDA.b $6A : STZ.b $6A : CMP.b #$02 : BNE .BRANCH_OMEGA
        LDY.b #$01
        
        LDA.b $2F : AND.b #$04 : BEQ .BRANCH_ALIF
            LDY.b #$02

        .BRANCH_ALIF

        STY.b $6A

    .BRANCH_OMEGA

    RTS
}

; ==============================================================================

; $03B7C3-$03B7C6 DATA
AutoMove49Directions:
{
    db 8, 4, 2, 1
}

; ==============================================================================

; $03B7C7-$03B955 LOCAL JUMP LOCATION
Link_HandleCardinalCollision:
{
    ; Initialize the diagonal wall state.
    STZ.b $6E
    
    ; ????
    STZ.b $38
    
    ; Detects forced diagonal movement, as when walking against a diagonal wall.
    ; Branch if there is [forced] diagonal movement.
    LDA.b $6B : AND.b #$30 : BNE .BRANCH_ALPHA
        ; Handles left/right tiles and maybe up/down too.
        JSR.w Link_HandleDiagonalKickback
        
        LDA.b $6D : BEQ .BRANCH_ALPHA
            BRL .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    JSR.w CheckIfRoomNeedsDoubleLayerCheck : BCC .BRANCH_BETA
        ; "Check collision" as named in Hyrule Magic
        ; Keep in mind that outdoors, collisions are always 0, i.e. "normal"
        ; Why load it twice, homes?
        LDA.w $046C : CMP.b #$02 : BCC .BRANCH_GAMMA
            LDA.w $046C : CMP.b #$03 : BEQ .BRANCH_GAMMA
                LDA.b #$02 : STA.w $0315
                
                REP #$20
                
                JSR.w Player_TileDetectNearby
                
                SEP #$20
                
                LDA.b $0E : STA.w $0316 : BEQ .BRANCH_GAMMA
                    LDA.b $30 : STA.b $00
                    
                    ADC.w $0310 : STA.b $30
                    
                    LDA.b $31 : STA.b $01
                    
                    CLC : ADC.w $0312 : STA.b $31
                    
                    LDA.b $0E
                    
                    CMP.b #$0C : BEQ .BRANCH_GAMMA
                    CMP.b #$03 : BEQ .BRANCH_GAMMA
                        CMP.b #$0A : BEQ .BRANCH_DELTA
                        CMP.b #$05 : BEQ .BRANCH_DELTA
                        AND.b #$0C : BNE .BRANCH_EPSILON
                            LDA.b $0E : AND.b #$03 : BNE .BRANCH_EPSILON
                                BRA .BRANCH_GAMMA
                        
                        .BRANCH_EPSILON
                        
                        LDA.b $00 : BNE .BRANCH_DELTA
                            LDA.b $01 : BEQ .BRANCH_GAMMA
                                LDA.w $0301 : BPL .BRANCH_DELTA
        
        .BRANCH_GAMMA
        
        JSR.w RunSlopeCollisionChecks_VerticalFirst
        
        BRA .BRANCH_ZETA
        
        .BRANCH_DELTA
        
        JSR.w RunSlopeCollisionChecks_HorizontalFirst
        
        .BRANCH_ZETA
        
        JSR.w CreateVelocityFromMovingBackground
    
    .BRANCH_BETA
    
    ; Check the "collision" value (as in Hyrule Magic).
    LDA.w $046C
    
    CMP.b #$02 : BEQ .BRANCH_THETA
        CMP.b #$03 : BEQ .BRANCH_IOTA
            CMP.b #$04 : BEQ .BRANCH_KAPPA
                ; Is there horizontal or vertical scrolling happening?
                LDA.b $30 : ORA.b $31 : BNE .BRANCH_KAPPA
                    LDA.b $5D
                    
                    CMP.b #$13 : BEQ .BRANCH_LAMBDA
                    CMP.b #$08 : BEQ .BRANCH_LAMBDA
                    CMP.b #$09 : BEQ .BRANCH_LAMBDA
                    CMP.b #$0A : BEQ .BRANCH_LAMBDA
                    CMP.b #$03 : BEQ .BRANCH_LAMBDA
                        JSR.w Player_TileDetectNearby
                        
                        LDA.b $59 : AND.b #$0F : BEQ .BRANCH_LAMBDA
                            LDA.b #$01 : STA.b $5D
                            
                            LDA.w $0372 : BNE .BRANCH_LAMBDA
                                LDA.b #$04 : STA.b $5E
                    
                    .BRANCH_LAMBDA
                    
                    BRL .BRANCH_XI
    
    .BRANCH_THETA
    
    JSR.w Player_TileDetectNearby
    
    LDA.b $0E : ORA.w $0316 : CMP.b #$0F : BNE .BRANCH_KAPPA
        LDA.w $031F : BNE .BRANCH_MU
            LDA.b #$3A : STA.w $031F
        
        .BRANCH_MU
        
        LDA.b $67 : BNE .BRANCH_KAPPA
            LDA.w $0310 : BEQ .BRANCH_NU
                LDA.b $30 : EOR.b #$FF : INC A : STA.b $30
            
            .BRANCH_NU
            
            LDA.w $0312 : BEQ .BRANCH_KAPPA
                LDA.b $31 : EOR.b #$FF : INC A : STA.b $31
    
    .BRANCH_KAPPA
    
    LDA.b #$01 : STA.w $0315
    
    JSR.w RunSlopeCollisionChecks_VerticalFirst
    
    BRA .BRANCH_XI
    
    .BRANCH_IOTA
    
    LDA.b #$01 : STA.w $0315
    
    JSR.w RunSlopeCollisionChecks_HorizontalFirst
    
    .BRANCH_XI
    
    LDY.b #$00
    
    JSR.w TileDetect_MainHandler
    
    LDA.b $6A : BEQ .BRANCH_OMICRON
        STZ.b $6B
    
    .BRANCH_OMICRON
    
    LDA.b $5D : CMP.b #$0B : BEQ .BRANCH_PI
        LDY.b #$08
        
        LDA.b $20 : SEC : SBC.b $3E : STA.b $30 : BEQ .BRANCH_PI
            BMI .BRANCH_RHO
                LDY.b #$04
            
            .BRANCH_RHO
            
            LDA.b $67 : AND.b #$03 : STA.b $67
            
            TYA : TSB.b $67
        
    .BRANCH_PI
    
    ; Two LDA's in a row?
    LDA.b #$02
    
    LDA.b $22 : SEC : SBC.b $3F : STA.b $31 : BEQ .BRANCH_SIGMA
        BMI .BRANCH_TAU
            LDY.b #$01
        
        .BRANCH_TAU
        
        LDA.b $67 : AND.b #$0C : STA.b $67
        
        TYA : TSB.b $67
        
    .BRANCH_SIGMA
    
    LDA.b $1B : BEQ .BRANCH_UPSILON
        LDA.w $046C : CMP.b #$04 : BNE .BRANCH_UPSILON
            LDA.b $5D : CMP.b #$04 : BNE .BRANCH_UPSILON
                LDY.b #$F7
                
                LDA.w $0310 : BEQ .BRANCH_PHI  BMI .BRANCH_CHI
                    LDY.b #$FB
                
                .BRANCH_CHI
                
                EOR.b #$FF : INC A : CLC : ADC.b $30 : BNE .BRANCH_PHI
                    TYA : AND.b $67 : STA.b $67
                
                .BRANCH_PHI
                
                LDY.b #$FD
                
                LDA.w $0312 : BEQ .BRANCH_UPSILON
                    BMI .BRANCH_PSI
                        LDY.b #$FE
                        
                    .BRANCH_PSI
                        
                    EOR.b #$FF : INC A : CLC : ADC.b $31 : BNE .BRANCH_UPSILON
                        TYA : AND.b $67 : STA.b $67
    
    .BRANCH_UPSILON
    
    RTS
}

; $03B956-$03B968 LOCAL JUMP LOCATION
RunSlopeCollisionChecks_VerticalFirst:
{
    LDA.b $6B : AND.b #$20 : BNE .BRANCH_ALPHA
        JSR.w StartMovementCollisionChecks_Vertical
    
    .BRANCH_ALPHA
    
    LDA.b $6B : AND.b #$10 : BNE .BRANCH_BETA
        JSR.w StartMovementCollisionChecks_Horizontal
    
    .BRANCH_BETA
    
    RTS
}

; $03B969-$03B97B LOCAL JUMP LOCATION
RunSlopeCollisionChecks_HorizontalFirst:
{
    LDA.b $6B : AND.b #$10 : BNE .BRANCH_ALPHA
        JSR.w StartMovementCollisionChecks_Horizontal
    
    .BRANCH_ALPHA
    
    LDA.b $6B : AND.b #$20 : BNE .BRANCH_BETA
        JSR.w StartMovementCollisionChecks_Vertical
    
    .BRANCH_BETA
    
    RTS
}

; $03B97C-$03B9B2 LOCAL JUMP LOCATION
CheckIfRoomNeedsDoubleLayerCheck:
{
    ; Collision settings
    LDA.w $046C : BEQ .oneBg
    CMP.b #$04 : BEQ .oneBg ; Moving water collision setting
        CMP.b #$02 : BCC .twoBgs
            CMP.b #$03 : BNE .uselessBranch
                ; OPTIMIZE: Useless branch.
            
            .uselessBranch
            
            REP #$20
            
            LDA.b $E6 : SEC : SBC.b $E8 : CLC : ADC.b $20
            STA.b $20 : STA.w $0318

            LDA.b $E0 : SEC : SBC.b $E2 : CLC : ADC.b $22
            STA.b $22 : STA.w $031A
            
            SEP #$20
        
        .twoBgs
        
        LDA.b #$01 : STA.b $EE
        
        SEC
        
        RTS
    
    .oneBg
    
    CLC
    
    RTS
}

; $03B9B3-$03B9F6 LOCAL JUMP LOCATION
CreateVelocityFromMovingBackground:
{
    LDA.w $046C : CMP.b #$01 : BEQ .BRANCH_ALPHA
        REP #$20
        
        LDA.b $20 : SEC : SBC.w $0318 : STA.b $00
        LDA.b $22 : SEC : SBC.w $031A : STA.b $02
        
        LDA.b $E8 : SEC : SBC.b $E6 : CLC : ADC.b $20 : STA.b $20
        LDA.b $E2 : SEC : SBC.b $E0 : CLC : ADC.b $22 : STA.b $22
        
        SEP #$20
        
        LDA.b $67 : BEQ .BRANCH_ALPHA
            LDA.b $30 : CLC : ADC.b $00 : STA.b $30
            LDA.b $31 : CLC : ADC.b $02 : STA.b $31
        
    .BRANCH_ALPHA
    
    STZ.b $EE
    
    RTS
}

; ==============================================================================

; $03B9F7-$03B9FE DATA
RupeeTileOffset_y:
{
    dw $0008, $0018, $0010, $0010
}

; $03B9FF-$03BA06 DATA
RupeeTileOffset_x:
{
    dw $0008, $0008, $0000, $000F
}

; $03BA07-$03BA09 DATA
SpikeDamageValues:
{
    db $08 ; green
    db $08 ; blue
    db $08 ; red
}

; ==============================================================================

; $03BA0A-$03BEAE LOCAL JUMP LOCATION
StartMovementCollisionChecks_Vertical:
{
    LDA.b $30 : BNE .changeInYCoord
        RTS

    .changeInYCoord

    LDA.b $6C : CMP.b #$01 : BNE .notInDoorway
        LDY.b #$00
        
        ; Basically branch if it's a north facing door.
        LDA.b $20 : CMP.b #$80 : BCC .setLastDirection
            BRA .lowerDoor

    .notInDoorway

    ; Will indicate that the last movement was in the up direction.
    LDY.b #$00
    
    LDA.b $30 : BMI .setLastDirection
        .lowerDoor

        ; Since the change in Y coord was positive, it means we moved down.
        LDY.b #$02

    .setLastDirection

    TYA : LSR A : STA.b $66
    
    JSR.w TileDetect_Movement_Vertical
    
    LDA.b $1B : BNE .indoors
        BRL StartMovementCollisionChecks_Vertical_HandleOutdoors

    .indoors

    LDA.w $0308 : BMI .carryingSomething
        LDA.b $46 : BEQ .notInRecoilState

    .carryingSomething

    LDA.b $0E : LSR #4 : TSB.b $0E
    
    BRL .BRANCH_NU

    .notInRecoilState

    LDA.b $6C : CMP.b #$02 : BNE .BRANCH_IOTA
        LDA.b $6A : BNE .BRANCH_KAPPA
            LDA.w $046C : CMP.b #$03 : BNE .BRANCH_LAMBDA
                LDA.b $EE : BEQ .BRANCH_LAMBDA
                    BRL .BRANCH_TAU

            .BRANCH_LAMBDA

            JSR.w Link_AddInVelocityY
            
            BRL ChangeAxisOfPerpendicularDoorMovement_Vertical

        .BRANCH_KAPPA

        LDA.b $62 : BEQ .BRANCH_IOTA
            JSR.w Link_AddInVelocityY
            
            BRA .BRANCH_MU

    .BRANCH_IOTA

    LDA.b $0E : AND.b #$70 : BEQ .BRANCH_NU
        STZ.b $05
        
        LDA.b $0F : AND.b #$07 : BEQ .BRANCH_XI
            LDY.b #$00
            
            LDA.b $30 : BMI .BRANCH_OMICRON
                LDY.b #$01

            .BRANCH_OMICRON

            LDA.w AutoMove49Directions, Y : STA.b $49

        .BRANCH_XI

        LDA.b #$01 : STA.b $6C
        
        STZ.w $03F3
        
        LDA.b $0E : AND.b #$70 : CMP.b #$70 : BEQ .BRANCH_PI
            LDA.b $0E : AND.b #$05 : BNE .BRANCH_RHO
                LDA.b $0E : AND.b #$20 : BNE .BRANCH_PI
                    BRA .BRANCH_NU

            .BRANCH_RHO

            STZ.b $6B
            
            JSR.w Link_AddInVelocityYFalling
            JSR.w CalculateSnapScratch_Vertical
            
            STZ.b $6C
            
            LDA.b $0E : AND.b #$20 : BEQ .BRANCH_PI
            
                LDA.b $0E : AND.b #$01 : BNE .BRANCH_PI
                    LDA.b $22 : AND.b #$07 : CMP.b #$01 : BNE .BRANCH_PI
                        LDA.b $22 : AND.b #$F8 : STA.b $22

        .BRANCH_PI

        LDA.w $0315 : AND.b #$02 : BNE .BRANCH_SIGMA
            LDA.b $50 : AND.b #$FD : STA.b $50

        .BRANCH_SIGMA

        RTS

    .BRANCH_NU

    LDA.w $0315 : AND.b #$02 : BNE .BRANCH_MU
        STZ.b $6C

    .BRANCH_MU

    LDA.w $0315 : AND.b #$02 : BNE .BRANCH_TAU
        LDA.b $50 : AND.b #$FD : STA.b $50
        
        STZ.b $49
        STZ.b $EF

    .BRANCH_TAU

    LDA.b $0E : AND.b #$07 : BNE .BRANCH_UPSILON
        LDA.b $0C : AND.b #$05 : BEQ .BRANCH_UPSILON
            STZ.w $03F3
            
            JSR.w FlagMovingIntoSlopes_Vertical
            
            LDA.b $6B : AND.b #$0F : BEQ .BRANCH_UPSILON
                RTS

    .BRANCH_UPSILON

    STZ.b $6B
    
    LDA.w $02E7 : AND.b #$20 : BEQ .dontOpenBigKeyLock
        LDA.b $0E : PHA
        LDA.b $0F : PHA
        
        LDA.w $02EA
        
        JSL.l Dungeon_OpenKeyedObject
        
        STZ.w $02EA
        
        PLA : STA.b $0F
        PLA : STA.b $0E

    .dontOpenBigKeyLock

    LDA.b $EE : BNE .BRANCH_CHI
        LDA.w $034C : AND.b #$07 : BEQ .BRANCH_PSI
            LDA.b #$01 : TSB.w $0322
            
            BRA .BRANCH_OMEGA

        .BRANCH_PSI

        LDA.w $02E8 : AND.b #$07 : BNE .BRANCH_OMEGA
            LDA.b $0E : AND.b #$02 : BNE .BRANCH_OMEGA
                LDA.w $0322 : AND.b #$FE : STA.w $0322
                
                BRA .BRANCH_OMEGA

    .BRANCH_CHI

    LDA.w $0320 : AND.b #$07 : BEQ .BRANCH_ULTIMA
        LDA.b #$02 : TSB.w $0322
            
        BRA .BRANCH_OMEGA

    .BRANCH_ULTIMA

    LDA.w $0322 : AND.b #$FD : STA.w $0322

    .BRANCH_OMEGA

    LDA.w $02F7 : AND.b #$22 : BEQ .no_blue_rupee_touch
        LDX.b #$00
        
        AND.b #$20 : BEQ .touched_upper_rupee_half
            LDX.b #$08

        .touched_upper_rupee_half

        STX.b $00
        STZ.b $01
        
        LDA.b $66 : ASL A : TAY
        
        REP #$20
        
        ; Link gets 5 rupees... probably from rupee tiles in special rooms.
        LDA.l $7EF360 : CLC : ADC.w #$0005 : STA.l $7EF360
        
        ; This is intended to help calculate where to do the clearing update.
        LDA.b $20
        CLC : ADC.w RupeeTileOffset_y, Y : SEC : SBC.b $00 : STA.b $00
        
        LDA.b $22
        CLC : ADC.w RupeeTileOffset_x, Y                   : STA.b $02
        
        SEP #$20
        
        JSL.l Dungeon_ClearRupeeTile
        
        LDA.b #$0A : JSR.w Player_DoSfx3

    .no_blue_rupee_touch

    LDY.b #$01
    
    LDA.w $03F1
    
    AND.b #$22 : BEQ .BRANCH_BETA2
        AND.b #$20 : BEQ .BRANCH_GAMMA2
            LDY.b #$02

        .BRANCH_GAMMA2

        STY.w $03F3
        
        BRA .BRANCH_DELTA2

    .BRANCH_BETA2

    LDY.b #$03
    
    LDA.w $03F2
    
    AND.b #$22 : BEQ .BRANCH_EPSILON2
        AND.b #$20 : BEQ .BRANCH_ZETA2
            LDY.b #$04

        .BRANCH_ZETA2

        STY.w $03F3
        
        BRA .BRANCH_DELTA2

    .BRANCH_EPSILON2

    LDA.w $02E8 : AND.b #$07 : BNE .BRANCH_DELTA2
        LDA.b $0E : AND.b #$02 : BNE .BRANCH_DELTA2
            STZ.w $03F3

    .BRANCH_DELTA2

    LDA.w $036D : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_THETA2
        JSR.w RunLedgeHopTimer : BCC .BRANCH_THETA2
            JSR.w Player_HaltDashAttack
            
            ; This increments when Link is ready to jump down from a ledge.
            INC.w $047A
            
            LDA.b #$01 : STA.w $037B
            
            LDA.b #$02 : STA.b $4D
            
            LDA.b #$20 : JSR.w Player_DoSfx2
            
            BRA .BRANCH_IOTA2

    .BRANCH_THETA2

    LDA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_KAPPA2
        LDA.w $0345 : BNE .BRANCH_KAPPA2
            JSR.w Player_HaltDashAttack
            
            LDA.b $1D : BNE .BRANCH_LAMBDA2
                JSL.l Player_LedgeJumpInducedLayerChange
                
                BRA .BRANCH_IOTA2

            .BRANCH_LAMBDA2

            LDA.b $01 : STA.w $0345
            
            LDA.b $26 : STA.w $0340
            
            STZ.w $0308
            STZ.w $0309
            STZ.w $0376
            STZ.b $5E
            
            JSL.l Player_ResetSwimState
            
            LDA.b #$20 : JSR.w Player_DoSfx2

            .BRANCH_IOTA2

            LDA.b #$01 : STA.w $037B
            
            JSR.w Link_HopInOrOutOfWater_Vertical
            
            BRA .BRANCH_MU2

    .BRANCH_KAPPA2

    LDA.w $0343 : AND.b #$02 : BEQ .BRANCH_MU2
        LDA.w $0345 : BEQ .BRANCH_MU2
            LDA.b $4D : BEQ .BRANCH_NU2
                LDA.b #$06 : STA.b $0E
        
    BRA .BRANCH_MU2

    .BRANCH_NU2

    JSR.w Player_HaltDashAttack
    
    STZ.w $0345
    
    LDA.w $0340 : STA.b $26
    
    LDA.b #$15
    LDY.b #$00
    
    ; $0498FC IN ROM
    JSL.l AddTransitionSplash : BCC .BRANCH_XI2
        LDA.b #$01 : STA.w $0345
        
        LDA.b #$07 : STA.b $0E
        
        BRA .BRANCH_MU2

    .BRANCH_XI2

    LDA.b #$01 : STA.w $037B

    .BRANCH_MU2

    JSR.w Link_HopInOrOutOfWater_Vertical
    
    LDA.b $58 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_OMICRON2
        LDA.b $46 : BEQ .BRANCH_PI2
            LDA.b $58 : AND.b #$07 : STA.b $0E
            
            BRL .BRANCH_THEL

        .BRANCH_PI2

        LDA.w $02C0 : AND.b #$77 : BEQ .BRANCH_RHO2
            ; Link is going up a inter-floor staircase so far.
            LDY.b #$08
            
            AND.b #$70 : BEQ .BRANCH_SIGMA2
                ; Bits in the upper nybble were set, link is going down an
                ; inter-floor staircase.
                LDY.b #$10

            .BRANCH_SIGMA2

            STY.b $11
            
            LDA.b #$07 : STA.b $10
            
            JSR.w Player_HaltDashAttack

        .BRANCH_RHO2

        LDA.b $66 : AND.b #$02 : BNE .BRANCH_OMICRON2
            LDA.b #$02 : STA.b $5E
            
            LDA.b #$01 : STA.b $57
            
            RTS

    .BRANCH_OMICRON2

    LDA.b $5E : CMP.b #$02 : BNE .BRANCH_TAU2
        LDX.b #$10
        
        LDA.w $0372 : BNE .BRANCH_UPSILON2
            LDX.b #$00

        .BRANCH_UPSILON2

        STX.b $5E

    .BRANCH_TAU2

    LDA.b $57 : CMP.b #$01 : BNE .BRANCH_PHI2
        LDX.b #$02 : STX.b $57

    .BRANCH_PHI2

    LDA.b $59 : AND.b #$05 : BEQ .BRANCH_CHI2
        LDA.b $0E : AND.b #$02 : BNE .BRANCH_CHI2
            LDA.b $5D
            
            CMP.b #$05 : BEQ .BRANCH_PSI2
            CMP.b #$02 : BEQ .BRANCH_PSI2
                LDA.b #$09 : STA.b $5C
                
                STZ.b $5A
                
                LDA.b #$01 : STA.b $5B
                
                LDA.b #$01 : STA.b $5D

            .BRANCH_PSI2

            RTS

    .BRANCH_CHI2

    STZ.b $5A
    
    LDA.w $02E8 : AND.b #$07 : BEQ .BRANCH_OMEGA2
        LDA.b $46 : ORA.w $031F : ORA.b $55 : BNE .BRANCH_ALIF
            LDA.b $20
            
            LDY.b $66 : BNE .BRANCH_BET
                AND.b #$04 : BEQ .BRANCH_KAF
                    BRA .BRANCH_OMEGA2

            .BRANCH_BET

            AND.b #$04 : BEQ .BRANCH_OMEGA2
                .BRANCH_KAF

                LDA.w $031F : BNE .BRANCH_OMEGA2
                    LDA.l $7EF35B : TAY
                    
                    LDA.w SpikeDamageValues, Y : STA.w $0373
                    
                    JSR.w Player_HaltDashAttack
                    JSR.w Link_ForceUnequipCape_quietly
                    
                    BRL LinkApplyTileRebound

        .BRANCH_ALIF

        LDA.w $02E8 : AND.b #$07 : STA.b $0E

    .BRANCH_OMEGA2

    LDA.w $046C : BEQ .BRANCH_DEL
    CMP.b #$04 : BEQ .BRANCH_DEL
        LDA.b $EE : BNE .BRANCH_THEL

    .BRANCH_DEL

    LDA.b $5F : ORA.b $60 : BEQ .BRANCH_SOD
        LDA.b $6A : BNE .BRANCH_SOD
            LDA.b $5F : STA.w $02C2
            
            DEC.b $61 : BPL .BRANCH_THEL
                REP #$20
                
                LDY.b #$0F
                
                LDA.b $5F

                .BRANCH_SIN

                    ASL A : BCC .BRANCH_DOD
                        PHA : PHY
                        
                        SEP #$20
                        
                        JSR.w FindFreeMovingBlockSlot : BCS .BRANCH_TOD
                            STX.b $0E
                            
                            TYA : ASL A : TAX
                            
                            JSR.w InitializePushBlock : BCS .BRANCH_TOD
                                LDA.b $0E : ASL A : TAY
                                
                                JSR.w Underworld_DrawSinglePushBlock
                                
                                TYX
                                
                                LDY.b $66
                                
                                TYA : ASL A : STA.w $05F8, X : STA.w $0478
                                
                                LDA.w $05F0, X
                                
                                CPY.b #$01 : BNE .BRANCH_ZOD
                                    DEC A

                                .BRANCH_ZOD

                                AND.b #$0F : STA.w $05E8, X

                        .BRANCH_TOD

                        REP #$20

                    .BRANCH_DOD

                    PLY : PLA
                DEY : BPL .BRANCH_SIN
                
                SEP #$20

    .BRANCH_SOD

    LDA.b #$15 : STA.b $61

    ; $03BDB1 LONG BRANCH LOCATION
    .BRANCH_THEL

    LDA.b $0E : AND.b #$07 : BNE .BRANCH_RHA
        BRL .BRANCH_NU3

    .BRANCH_RHA

    LDA.b $5D : CMP.b #$04 : BNE .BRANCH_ZHA
        LDA.w $0310 : BNE .BRANCH_SHIN
            JSR.w Player_ResetSwimCollision

        .BRANCH_SHIN

        LDA.b $6A : BEQ .BRANCH_ZHA
            JSR.w Link_AddInVelocityYFalling
            
            BRA .BRANCH_FATHA

    .BRANCH_ZHA

    LDA.b $0E : AND.b #$02 : BNE .BRANCH_KESRA
        LDA.b $0E : AND.b #$05 : CMP.b #$05 : BNE .BRANCH_DUMMA

    .BRANCH_KESRA

    LDA.b $0E : PHA
    
    JSR.w Link_BonkAndSmash
    JSR.w RepelDash
    
    PLA : STA.b $0E
    
    LDA.b #$01 : STA.w $0302
    
    LDA.b $0E : AND.b #$02 : CMP.b #$02 : BNE .BRANCH_YEH
        JSR.w Link_AddInVelocityYFalling
        
        BRA .BRANCH_FATHA

    .BRANCH_YEH

    LDA.b $6A : CMP.b #$01 : BNE .BRANCH_EIN
        .BRANCH_GHEIN

        BRL .BRANCH_IOTA3

    .BRANCH_EIN

    JSR.w Link_AddInVelocityYFalling
    
    LDA.b $6A : CMP.b #$02 : BEQ .BRANCH_GHEIN
        .BRANCH_FATHA

        LDA.b $0E : AND.b #$05 : CMP.b #$05 : BEQ .BRANCH_JIIM
            AND.b #$04 : BEQ .BRANCH_ALPHA3
                LDY.b #$01
                
                LDA.b $30 : BMI .BRANCH_BETA3
                    EOR.b #$FF : INC A

                .BRANCH_BETA3

                BPL .BRANCH_GAMMA3
                    LDY.b #$FF

                .BRANCH_GAMMA3

                STY.b $00 : STZ.b $01
                
                LDA.b $0E : AND.b #$02 : BNE .BRANCH_DELTA3
                    LDA.b $22 : AND.b #$07 : BNE .BRANCH_EPSILON3
                        JSR.w Link_BonkAndSmash
                        JSR.w RepelDash
                        
                        BRA .BRANCH_DELTA3

            .BRANCH_ALPHA3

            LDY.b #$01
            
            LDA.b $30 : BPL .BRANCH_ZETA3
                EOR.b #$FF : INC A

            .BRANCH_ZETA3

            BPL .BRANCH_THETA3
                LDY.b #$FF

            .BRANCH_THETA3

            STY.b $00 : STZ.b $01
            
            LDA.b $0E : AND.b #$02 : BNE .BRANCH_DELTA3
                LDA.b $22 : AND.b #$07
                
                BNE .BRANCH_EPSILON3

        .BRANCH_JIIM

        JSR.w Link_BonkAndSmash
        JSR.w RepelDash
        
        BRA .BRANCH_DELTA3

        .BRANCH_EPSILON3

        JSR.w AddAbsoluteScratchToXCoord
        JMP.w HandleNudging

        .BRANCH_DELTA3

        LDA.b $66 : ASL A : CMP.b $2F : BNE .BRANCH_IOTA3
            LDA.w $0315 : AND.b #$01 : ASL A : TSB.b $48
            
            LDA.b $3C : BNE .BRANCH_KAPPA3
                DEC.w $0371 : BPL .BRANCH_LAMBDA3

            .BRANCH_KAPPA3

            LDY.w $0315
            
            LDA.w $02F6 : AND.b #$20 : BEQ .BRANCH_MU3
                LDA.w $0315 : ASL #3 : TAY

            .BRANCH_MU3

            TYA : TSB.b $48
            
            BRA .BRANCH_IOTA3

            .BRANCH_NU3

            LDA.b $EE : BNE .BRANCH_LAMBDA3
                LDA.b $48 : AND.b #$F6 : STA.b $48

    .BRANCH_IOTA3

    LDA.b #$20 : STA.w $0371
    
    LDA.b $48 : AND.b #$FD : STA.b $48

    .BRANCH_LAMBDA3

    RTS
}

; This routine seems to occur whenever Link moves up or down one pixel.
; $03BEAF-$03C16C LONG BRANCH LOCATION
StartMovementCollisionChecks_Vertical_HandleOutdoors:
{
    LDA.b $5E : CMP.b #$02 : BNE .notOnStairs
        LDX.b #$10
        
        LDA.w $0372 : BNE .dashing
            LDX.b #$00

        .dashing

        ; Set speed to either walking or dashing speed (probably in
        ; anticipation of us being off those stairs).
        STX.b $5E

    .notOnStairs

    LDA.b $59 : AND.b #$05 : BEQ .safeFromHoles
        LDA.b $0E : AND.b #$02 : BNE .safeFromHoles
            ; Is Link on a turtle rock platform?
            LDA.b $5D : CMP.b #$05 : BEQ .return
                ; Is Link in a recoil state?
                CMP.b #$02 : BEQ .return
                    LDA.b #$09 : STA.b $5C
                    
                    STZ.b $5A
                    
                    LDA.b #$01 : STA.b $5B
                    
                    ; Put Link into the near a hole / falling into a hole state.
                    LDA.b #$01 : STA.b $5D

            .return

            RTS

    .safeFromHoles

    LDA.w $0366 : AND.b #$02 : BEQ .notNearReadableTile
        LDA.w $036A : LSR A : STA.w $0368
        
        BRA .nearReadableTile

    .notNearReadableTile

    STZ.w $0368

    .nearReadableTile

    ; See if Link is touching deep water tiles:
    LDA.w $0341 : AND.b #$02 : BEQ .notTouchingWater
        ; OPTIMIZE: Unnecessary branch and block of code.
        BRA .BRANCH_IOTA
        
        ; This location is unreachable. It seems this bit skipped temporarily
        ; and was forgotten.
        .UNREACHABLE_07BF01
        LDA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_THETA

        .BRANCH_IOTA

        LDA.w $0345 : BNE .BRANCH_THETA
            LDA.b $4D : BNE .BRANCH_THETA
                JSR.w Link_ResetSwordAndItemUsage
                JSR.w Player_HaltDashAttack
                
                LDA.b #$01 : STA.w $0345
                
                LDA.b $26 : STA.w $0340
                
                STZ.w $0376
                STZ.b $5E
                
                JSL.l Player_ResetSwimState
                
                LDA.w $0351 : CMP.b #$01 : BNE .BRANCH_KAPPA
                    JSR.w Link_ForceUnequipCape_quietly
                    
                    ; Do we have the flippers?
                    LDA.l $7EF356 : BEQ .BRANCH_KAPPA
                        LDA.w $02E0 : BNE .BRANCH_THETA
                            LDA.b #$04 : STA.b $5D
                            
                            BRA .BRANCH_THETA

                .BRANCH_KAPPA

                LDA.b #$20 : JSR.w Player_DoSfx2
                
                LDA.b $3E : STA.b $20
                LDA.b $40 : STA.b $21
                LDA.b $3F : STA.b $22
                LDA.b $41 : STA.b $23
                
                LDA.b #$01 : STA.w $037B
                
                JSR.w Link_HopInOrOutOfWater_Vertical

        .BRANCH_THETA
    .notTouchingWater

    ; Bleeds into the next function.
}

; $03BF64- LOCAL JUMP LOCATION
Link_HandleEnteringWater_Vertical:
{
    LDA.w $0345 : BEQ .BRANCH_LAMBDA
        LDA.w $036D : AND.b #$07 : BEQ .BRANCH_MU
            STA.b $0E
            
            BRL StartMovementCollisionChecks_Vertical_BRANCH_THEL

        .BRANCH_MU

        LDA.b $58 : AND.b #$07 : CMP.b #$07 : BEQ .BRANCH_NU
            LDA.w $0343 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_LAMBDA

        .BRANCH_NU

        JSR.w Player_HaltDashAttack
        
        STZ.w $0345
        
        LDA.b $4D : BNE .BRANCH_LAMBDA
            ; This section of code is what causes us to jump out of the water
            ; at a dock.
            LDA.w $0340 : STA.b $26
            
            LDA.b #$01 : STA.w $037B
            
            LDA.b #$15
            LDY.b #$00
            
            ; Jump out of the water onto a docking area.
            JSL.l AddTransitionSplash ; $0498FC IN ROM
            
            BRL Link_HopInOrOutOfWater_Vertical

    .BRANCH_LAMBDA

    LDA.w $036E : AND.b #$02 : BNE .BRANCH_XI
        LDA.w $0370 : AND.b #$22 : BEQ .BRANCH_OMICRON

    .BRANCH_XI

    LDA.b #$07 : STA.b $0E
    
    BRL StartMovementCollisionChecks_Vertical_BRANCH_THEL
        .BRANCH_OMICRON

        LDA.w $036D : AND.b #$70 : BEQ .BRANCH_PI
            JSR.w RunLedgeHopTimer : BCC .BRANCH_PI
                JSR.w Player_HaltDashAttack
                
                LDA.b #$01 : STA.w $037B : STA.b $78
                
                LDA.b #$0B : STA.b $5D
                
                STZ.b $46
                
                LDA.b #$FF : STA.w $0364 : STA.w $0365
                
                STZ.b $48
                STZ.b $5E
                
                LDY.b #$02
                LDX.b #$14
                
                LDA.w $0345 : BEQ .BRANCH_RHO
                    LDY.b #$04
                    LDX.b #$0E

                .BRANCH_RHO

                STX.w $0362
                STX.w $0363
                STY.b $4D
                
                RTS

        .BRANCH_PI

        LDA.w $036D : AND.b #$07 : BEQ .BRANCH_SIGMA
            JSR.w RunLedgeHopTimer : BCC .BRANCH_SIGMA
                LDA.b #$20 : JSR.w Player_DoSfx2
                
                LDA.b #$01 : STA.w $037B
                
                JSR.w Player_HaltDashAttack
                
                STZ.b $48
                STZ.b $4E
                
                BRL Link_FindValidLandingTile_North

        .BRANCH_SIGMA

        LDA.w $0345 : BEQ .BRANCH_TAU
            BRL .BRANCH_PSI

        .BRANCH_TAU

        LDA.w $036F : AND.b #$07 : BEQ .BRANCH_UPSILON
            LDA.w $036D : AND.b #$77 : BNE .BRANCH_UPSILON
                LDX.b #$04
                
                LDA.b $76 : CMP.b #$2F : BEQ .BRANCH_PHI
                    LDX.b #$01

                .BRANCH_PHI

                TXA : AND.w $036F : BEQ .BRANCH_UPSILON
                    JSR.w RunLedgeHopTimer : BCC .BRANCH_UPSILON
                        JSR.w Player_HaltDashAttack
                        
                        LDX.b #$10
                        
                        LDA.w $036F : AND.b #$04 : BNE .BRANCH_CHI
                            TXA : EOR.b #$FF : INC A : TAX

                        .BRANCH_CHI

                        LDA.b #$01 : STA.w $037B
                        
                        STX.b $28
                        
                        STZ.b $48
                        STZ.b $5E

                        LDA.b #$01 : STA.w $037B : STA.b $78
                        
                        LDA.b #$02 : STA.b $4D
                        
                        LDA.b #$14 : STA.w $0362 : STA.w $0363
                        
                        LDA.b #$FF : STA.w $0364
                        
                        STZ.b $46
                        
                        LDA.b #$0E : STA.b $5D
                        
                        RTS

        .BRANCH_UPSILON

        LDA.w $036E : AND.b #$70 : BEQ .BRANCH_PSI
            LDA.w $036D : AND.b #$77 : BNE .BRANCH_PSI
                JSR.w RunLedgeHopTimer : BCC .BRANCH_PSI
                    JSR.w Player_HaltDashAttack
                    
                    LDA.b #$20 : JSR.w Player_DoSfx2
                    
                    LDY.b #$03
                    
                    LDA.w $036E : AND.b #$40 : BNE .BRANCH_OMEGA
                        LDY.b #$02

                    .BRANCH_OMEGA

                    STY.b $66
                    
                    LDA.b #$01 : STA.w $037B
                    
                    STZ.b $48
                    STZ.b $5E
                    
                    BRL Link_FindValidLandingTile_DiagonalNorth

        .BRANCH_PSI

        LDA.b $58 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ALIF
            LDA.b $46 : BEQ .BRANCH_BET
                LDA.b $58 : AND.b #$07
                
                STA.b $0E
                
                BRL StartMovementCollisionChecks_Vertical_BRANCH_THEL

            .BRANCH_BET

            LDA.b $66 : AND.b #$02 : BNE .BRANCH_ALIF
                LDA.b #$02 : STA.b $5E
                
                ; Walking on basic stairs (near Eastern Palace).
                LDA.b #$01 : STA.b $57
                
                RTS

        .BRANCH_ALIF

        LDA.b $5E : CMP.b #$02 : BNE .BRANCH_DEL
            LDX.b #$10
            
            LDA.w $0372 : BNE .dashing
                LDX.b #$00

            .dashing

            STX.b $5E

        .BRANCH_DEL

        LDA.b $57 : CMP.b #$01 : BNE .BRANCH_SIN
            LDX.b #$02 : STX.b $57

        .BRANCH_SIN

        LDA.b $0C : AND.b #$05 : BEQ .BRANCH_SHIN
            LDA.b $0E : AND.b #$07 : BNE .BRANCH_SHIN
                JSR.w FlagMovingIntoSlopes_Vertical
                
                LDA.b $6B : AND.b #$0F : BEQ .BRANCH_SHIN
                    RTS

        .BRANCH_SHIN

        STZ.b $6B
        
        ; The AND with 0x02 ensures that it's a centered push against the
        ; gravestone.
        LDA.w $02E7 : AND.b #$02 : BEQ .resetGravestoneCounter
            ; If the last direction Link moved was any direction other than up,
            ; we reset the counter.
            LDA.b $66 : BNE .resetGravestoneCounter
                ; Dashing?
                LDA.w $0372 : BNE .moveGravestone
                    DEC.b $61 : BPL .dontMoveGravestone

                .moveGravestone

                LDA.b $0E : PHA
                
                LDY.b #$04
                LDA.b #$24
                
                JSL.l AddGravestone
                
                PLA : STA.b $0E

        .resetGravestoneCounter

        LDA.b #$34 : STA.b $61

        .dontMoveGravestone

        LDA.w $02E8 : AND.b #$07 : BEQ .BRANCH_ZOD
            LDA.b $46 : ORA.w $031F : ORA.b $55 : BNE .BRANCH_HEH
                LDA.b $20
                
                LDY.b $66 : BNE .BRANCH_JIIM
                    AND.b #$04 : BEQ .BRANCH_EIN
                        BRA .BRANCH_ZOD

                .BRANCH_JIIM

                AND.b #$04 : BEQ .BRANCH_ZOD
                    .BRANCH_EIN

                    LDA.l $7EF35B : TAY
                    
                    LDA.w SpikeDamageValues, Y : STA.w $0373
                    
                    JSR.w Player_HaltDashAttack
                    JSR.w Link_ForceUnequipCape_quietly
                    
                    BRL LinkApplyTileRebound

            .BRANCH_HEH

            LDA.w $02E8 : AND.b #$07 : STA.b $0E

        .BRANCH_ZOD

        BRL StartMovementCollisionChecks_Vertical_BRANCH_THEL
}

; ==============================================================================

; $03C16D-$03C1A0 LOCAL
RunLedgeHopTimer:
{
    ; Check the sub sub mode we're in.
    ; $03C171 Change from F0 to 80 to stop players from jumping off ledges all
    ; together.
    LDA.b $4D : CMP.b #$01 : BEQ .restore_coordinates
        ; Is Link running? Bypass waiting to jump off of a ledge. I think...
        LDA.w $0372 : BNE .BRANCH_BETA
            ; $03C17B Change from 10 to 80 to stop players from jumping off
            ; ledges unless dashing.
            
            DEC.w $0375 : BPL .restore_coordinates
                LDA.b #$13 : STA.w $0375
                
                BRA .BRANCH_GAMMA
        
        .BRANCH_BETA
        
        JSR.w .restore_coordinates
        
        .BRANCH_GAMMA
        
        SEC
        
        RTS
    
    ; $03C189 ALTERNATE ENTRY POINT
    .restore_coordinates
    
    REP #$20
    
    ; Restore previous coordinates? (So as to not prematurely jump off
    ; of the ledge)?
    LDA.w $0FC4 : STA.b $20
    LDA.w $0FC2 : STA.b $22
    
    SEP #$20
    
    STZ.b $2A
    STZ.b $2B
    
    ; OPTIMIZE: Zero length banch.
    LDA.b $1B : BNE .indoors
        ; What was here? Hrm.
    
    .indoors
    
    ; $03C19F ALTERNATE ENTRY POINT
    .EXIT_AND_CLC
    
    CLC
    
    RTS
}

; ==============================================================================

; $03C1A1-$03C1E3 LOCAL JUMP LOCATION
Link_BonkAndSmash:
{
    ; Dashing?
    LDA.w $0372 : BEQ RunLedgeHopTimer_EXIT_AND_CLC
        ; Check if we just started dashing:
        LDA.w $02F1 : CMP.b #$40 : BEQ RunLedgeHopTimer_EXIT_AND_CLC
            ; Presumably this checks collision with rock piles?
            LDA.w $02EF : AND.b #$70 : BEQ RunLedgeHopTimer_EXIT_AND_CLC
                JSL.l Overworld_SmashRockPile_normalCoords : BCC .BRANCH_ALPHA
                    JSR.w Link_BonkAndSmash_break_pile
                
                .BRANCH_ALPHA
                
                JSL.l Overworld_SmashRockPile_downOneTile : BCC .BRANCH_BETA
                    ; $03C1C3 ALTERNATE ENTRY POINT
                    .break_pile
                    
                    LDX.b #$08
                    
                    .BRANCH_DELTA
                    
                        CMP.w Pool_LinkToss_liftable_tiles, X : BEQ .BRANCH_GAMMA
                    DEX : BPL .BRANCH_DELTA
                    
                    BRA .BRANCH_BETA
                    
                    .BRANCH_GAMMA
                    
                    CPX.b #$02 : BEQ .BRANCH_EPSILON
                        CPX.b #$04 : BNE .BRANCH_ZETA
                    
                    .BRANCH_EPSILON
                    
                    PHX
                    
                    LDA.b #$32 : JSR.w Player_DoSfx3
                    
                    PLX

                    .BRANCH_ZETA

                    TXA
                    
                    JSL.l Sprite_SpawnImmediatelySmashedTerrain

                .BRANCH_BETA

                RTS
}

; $03C1E4-$03C1FE LOCAL JUMP LOCATION
Link_AddInVelocityYFalling:
{
    REP #$20
    
    LDA.b $51 : AND.w #$0007
    
    LDY.b $30 : BPL .BRANCH_ALPHA
        SEC : SBC.w #$0008

    .BRANCH_ALPHA

    EOR.w #$FFFF : INC A : CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    RTS
}

; $03C1FF-$03C228 LOCAL JUMP LOCATION
CalculateSnapScratch_Vertical:
{
    LDA.b $0E : AND.b #$04 : BEQ .BRANCH_ALPHA
        LDY.b #$01
        
        LDA.b $30 : BMI .BRANCH_BETA
            EOR.b #$FF : INC A
        
        .BRANCH_BETA
        
        BPL .BRANCH_GAMMA
            LDY.b #$FF
        
        .BRANCH_GAMMA
        
        STY.b $00
        STZ.b $01
        
        BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA
    
    LDY.b #$01
    
    LDA.b $30 : BPL .BRANCH_EPSILON
        EOR.b #$FF : INC A
    
    .BRANCH_EPSILON
    
    BPL .BRANCH_ZETA
        LDY.b #$FF
    
    .BRANCH_ZETA
    
    STY.b $00
    STZ.b $01
    
    .BRANCH_DELTA

    ; Bleeds into the next function.
}

; $03C229-$03C23C LOCAL JUMP LOCATION
AddAbsoluteScratchToXCoord:
{
    REP #$20
    
    LDA.b $00 : CMP.w #$0080 : BCC .BRANCH_THETA
        ORA.w #$FF00
    
    .BRANCH_THETA
    
    CLC : ADC.b $22 : STA.b $22
    
    SEP #$20
    
    RTS
}

; $03C23D-$03C29E LONG BRANCH LOCATION
ChangeAxisOfPerpendicularDoorMovement_Vertical:
{
    LDA.b #$02 : TSB.b $50
    
    LDA.b $0E : LSR #4 : ORA.b $0E : AND.b #$0F : STA.b $00
    
    AND.b #$07 : BNE .BRANCH_ALPHA
        STZ.b $6C
        
        BRA .BRANCH_BETA

    .BRANCH_ALPHA

    LDA.b $22 : CMP.b #$80 : BCC .BRANCH_GAMMA
        LDY.b #$01
        
        LDA.b $30 : BMI .BRANCH_DELTA
            EOR.b #$FF : INC A

        .BRANCH_DELTA

        BPL .BRANCH_EPSILON
            LDY.b #$FF

        .BRANCH_EPSILON

        STY.b $00
        STZ.b $01
        
        LDY.b #$04
        
        BRA .BRANCH_ZETA

    .BRANCH_GAMMA

    LDY.b #$01
    
    LDA.b $30 : BPL .BRANCH_THETA
        EOR.b #$FF : INC A

    .BRANCH_THETA

    BPL .BRANCH_IOTA
        LDY.b #$FF

    .BRANCH_IOTA

    STY.b $00
    STZ.b $01
    
    LDY.b #$06

    .BRANCH_ZETA

    LDA.b $50 : AND.b #$01 : BNE .BRANCH_KAPPA
        STY.b $2F

    .BRANCH_KAPPA

    REP #$20
    
    LDA.b $00 : CMP.w #$0080 : BCC .BRANCH_LAMBDA
        ORA.w #$FF00

    .BRANCH_LAMBDA

    CLC : ADC.b $22 : STA.b $22
    
    SEP #$20

    .BRANCH_BETA

    RTS
}

; $03C29F-$03C2B9 LOCAL JUMP LOCATION
Link_AddInVelocityY:
{
    REP #$20
    
    LDA.b $30 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_ALPHA
        ORA.w #$FF00
    
    .BRANCH_ALPHA
    
    EOR.w #$FFFF : INC A : CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    RTS
}

; $03C2BA-$03C2C2 DATA
Pool_Link_HopInOrOutOfWater_Vertical:
{
    ; $03C2BA
    .speed_y
    db 24, 16, 16

    ; $03C2BD
    .speed_z
    db 36, 24, 24

    ; $03C2C0
    .timer
    db 16, 16, 16
}

; $03C2C3-$03C30B LOCAL JUMP LOCATION
Link_HopInOrOutOfWater_Vertical:
{
    LDA.b $1B : BNE .BRANCH_ALPHA
        LDX.b #$02
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDX.b $1D
    
    LDA.w $047A : BEQ .BRANCH_BETA
        LDY.b #$00
    
    .BRANCH_BETA
    
    STX.b $00
    
    LDA.w Pool_Link_HopInOrOutOfWater_Vertical_speed_y, X : TAX
    
    LDA.b $66 : BNE .BRANCH_GAMMA
        TXA : EOR.b #$FF : INC A : TAX
    
    .BRANCH_GAMMA
    
    STX.b $27
    
    STZ.b $28
    
    LDX.b $00
    
    LDA.w Pool_Link_HopInOrOutOfWater_Vertical_speed_z, X
    STA.b $29 : STA.w $02C7
    
    STZ.b $24
    STZ.b $25
    
    LDA.w Pool_Link_HopInOrOutOfWater_Vertical_timer, X : STA.b $46
    
    LDA.b $4D : CMP.b #$02 : BEQ .BRANCH_DELTA
        LDA.b #$01 : STA.b $4D
        
        STZ.w $0360
    
    .BRANCH_DELTA
    
    LDA.b #$06 : STA.b $5D
    
    RTS
}

; $03C30C- DATA
Pool_Link_FindValidLandingTile_North:
{
    ; $03C30C
    .recoil_y
    db $10, $10, $14, $14, $18, $18, $1C, $1C
    db $20, $20, $24, $24, $28, $28, $2C, $2C
    db $30, $30, $30, $30, $30, $30, $30, $30
    db $30, $30, $30, $30, $30, $30, $30, $30

    ; $03C32C
    .recoil_z
    db $18, $18, $18, $18, $1C, $1C, $1C, $1C
    db $20, $20, $20, $20, $24, $24, $24, $24
    db $28, $28, $28, $28, $2C, $2C, $2C, $2C
    db $30, $30, $30, $30, $34, $34, $34, $34

    ; $03C34C
    .timer
    db $10, $10, $14, $14, $18, $18, $1C, $1C
    db $20, $20, $24, $24, $28, $28, $2C, $2C
    db $30, $30, $30, $30, $30, $30, $30, $30
    db $30, $30, $30, $30, $30, $30, $30, $30
}

; $03C36C-$03C408 LONG BRANCH LOCATION
Link_FindValidLandingTile_North:
{
    LDA.b $20 : STA.b $32 : PHA
    LDA.b $21 : STA.b $33 : PHA
    
    .BRANCH_ALPHA
    
        REP #$20
        
        LDA.b $20 : SEC : SBC.w #$0010 : STA.b $20
        
        SEP #$20
        
        LDA.b $66 : ASL A : TAY
        
        JSR.w TileDetect_Movement_Vertical
    LDA.w $0343 : ORA.w $035B : ORA.w $0357 : ORA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ALPHA
    
    LDA.w $0341 : AND.b #$07 : BEQ .BRANCH_BETA
        LDA.b #$01 : STA.b $4D
        
        STZ.w $0360
        
        LDA.b #$01 : STA.w $0345
        
        LDA.b $26 : STA.w $0340
        
        JSL.l Player_ResetSwimState
        
        STZ.w $0376
        STZ.b $5E
    
    .BRANCH_BETA
    
    REP #$20
    
    LDA.b $20 : SEC : SBC.w #$0010 : STA.b $20
    
    LDA.b $32 : SEC : SBC.b $20 : STA.b $32
    
    SEP #$20
    
    PLA : STA.b $21
    PLA : STA.b $20
    
    LDA.b $32 : LSR #3 : TAY
    
    LDA.w Pool_Link_FindValidLandingTile_North_recoil_y, Y : TAX
    
    LDA.b $66 : BNE .BRANCH_GAMMA
        TXA : EOR.b #$FF : INC A : TAX
    
    .BRANCH_GAMMA
    
    STX.b $27
    STZ.b $28
    
    LDA.w Pool_Link_FindValidLandingTile_North_recoil_z, Y
    STA.b $29 : STA.w $02C7
    
    STZ.b $24 : STZ.b $25
    
    LDA.w Pool_Link_FindValidLandingTile_North_timer, Y : STA.b $46
    
    LDA.b #$02 : STA.b $4D
    
    STZ.w $0360
    
    LDA.b #$06 : STA.b $5D
    
    RTS
}

; $03C409-$03C46C DATA
Pool_Link_FindValidLandingTile_DiagonalNorth:
{
    ; $03C409
    .recoil_y
    db $08, $08, $08, $08, $10, $10, $14, $14
    db $18, $18, $18, $18, $20, $20, $20, $20
    db $08, $14, $14, $14, $18, $18, $18, $18
    db $1C, $1C, $1C, $1C, $20, $20, $20, $20

    ; $03C429
    .recoil_x
    db $08, $08, $08, $08, $10, $10, $10, $10
    db $18, $18, $18, $18, $10, $10, $10, $10
    db $08, $14, $14, $14, $18, $18, $18, $18
    db $1C, $1C, $1C, $1C, $20, $20, $20, $20

    ; $03C449
    .recoil_z
    db $20, $20, $20, $20, $20, $20, $20, $20
    db $24, $24, $24, $24, $28, $28, $28, $28
    db $20, $28, $28, $28, $2C, $2C, $2C, $2C
    db $30, $30, $30, $30, $34, $34, $34, $34
    db $E0, $FF, $20, $00
}

; $03C46D-$03C4D3 LOCAL JUMP LOCATION
Link_FindValidLandingTile_DiagonalNorth:
{
    LDA.b $3E : PHA
    LDA.b $22 : PHA
    LDA.b $23 : PHA
    
    LDX.b $66 : PHX
    
    LDY.b #$01
    
    CPX.b #$02 : BNE .BRANCH_ALPHA
        LDY.b #$FF

    .BRANCH_ALPHA

    STY.b $28
    
    LDA.b #$00 : STA.b $66
    
    JSR.w LinkHop_FindLandingSpotDiagonallyDown
    
    PLX
    
    PLA : STA.b $23
    PLA : STA.b $22
    PLA : STA.b $3E
    
    REP #$20
    
    LDA.b $32 : SEC : SBC.b $20 : LSR #3 : TAY
    
    LDA.b $32 : STA.b $20
    
    SEP #$20
    
    LDA.w Pool_Link_FindValidLandingTile_DiagonalNorth_recoil_y, Y
    EOR.b #$FF : INC A : STA.b $27
    
    LDA.w Pool_Link_FindValidLandingTile_DiagonalNorth_recoil_x, Y
    
    CPX.b #$02 : BNE .BRANCH_BETA
        EOR.b #$FF : INC A

    .BRANCH_BETA

    STA.b $28
    
    LDA.w Pool_Link_FindValidLandingTile_DiagonalNorth_recoil_z, Y
    STA.b $29 : STA.w $02C7
    
    STZ.b $24
    STZ.b $25
    STZ.w $0364
    
    LDA.b #$02 : STA.b $4D
    
    STZ.w $0360
    
    LDA.b #$0D : STA.b $5D
    
    RTS
}

; $03C4D4-$03C7FB LOCAL JUMP LOCATION
StartMovementCollisionChecks_Horizontal:
{
    LDA.b $31 : BNE .BRANCH_ALPHA
        RTS

    .BRANCH_ALPHA

    LDA.b $6C : CMP.b #$02 : BNE .BRANCH_BETA
        LDY.b #$04
        
        LDA.b $22 : CMP.b #$80 : BCC .BRANCH_GAMMA
            BRA .BRANCH_DELTA

    .BRANCH_BETA

    LDY.b #$04
    
    LDA.b $31 : BMI .BRANCH_GAMMA
        .BRANCH_DELTA

        LDY.b #$06

    .BRANCH_GAMMA

    TYA : LSR A : STA.b $66
    
    ; Has to do with detecting areas around chests.
    JSR.w TileDetect_Movement_Horizontal
    
    LDA.b $1B : BNE .BRANCH_EPSILON
        BRL StartMovementCollisionChecks_Horizontal_HandleOutdoors

    .BRANCH_EPSILON

    LDA.w $0308 : BMI .BRANCH_ZETA
        LDA.b $46 : BEQ .BRANCH_THETA

    .BRANCH_ZETA

    LDA.b $0E : LSR #4 : TSB.b $0E : BRL .BRANCH_RHO
        .BRANCH_THETA

        LDA.b $6A : BNE .BRANCH_IOTA
            STZ.b $57

        .BRANCH_IOTA

        LDA.b $6C : CMP.b #$01 : BNE .BRANCH_KAPPA
            LDA.b $6A : BNE .BRANCH_KAPPA
                LDA.w $046C : CMP.b #$03 : BNE .BRANCH_LAMBDA
                    LDA.b $EE : BEQ .BRANCH_LAMBDA
                        BRL .BRANCH_TAU

                .BRANCH_LAMBDA

                JSR.w SnapOnX
                JSR.w ChangeAxisOfPerpendicularDoorMovement_Horizontal
                
                BRL HandleNudgingInADoor

        .BRANCH_KAPPA

        LDA.b $0E : AND.b #$70 : BEQ .BRANCH_RHO
            STZ.b $05
            
            LDA.b $0F : AND.b #$07 : BEQ .BRANCH_NU
                LDY.b #$02
                
                LDA.b $31 : BCC .BRANCH_XI
                    LDY.b #$03

                .BRANCH_XI

                LDA.w AutoMove49Directions, Y : STA.b $49

            .BRANCH_NU

            LDA.b #$02 : STA.b $6C
            
            STZ.w $03F3
            
            LDA.b $0E : AND.b #$70 : CMP.b #$70 : BEQ .BRANCH_OMICRON
                LDA.b $0E : AND.b #$07 : BNE .BRANCH_PI
                    LDA.b $0E : AND.b #$70 : BNE .BRANCH_OMICRON
                        BRA .BRANCH_RHO

                .BRANCH_PI

                STZ.b $6B
                STZ.b $6C
                
                JSR.w SnapOnX
                JML.l $07CB9F ; $03CB9F IN ROM

            .BRANCH_OMICRON

            LDA.w $0315 : AND.b #$02 : BNE .BRANCH_SIGMA
                LDA.b $50 : AND.b #$FD : STA.b $50

            .BRANCH_SIGMA

            RTS

    .BRANCH_RHO

    LDA.w $0315 : AND.b #$02 : BNE .BRANCH_TAU
        LDA.b $50 : AND.b #$FD : STA.b $50
        
        STZ.b $6C
        STZ.b $EF
        STZ.b $49

    .BRANCH_TAU

    LDA.b $0E : AND.b #$02 : BNE .BRANCH_UPSILON
        LDA.b $0C : AND.b #$05 : BEQ .BRANCH_UPSILON
            STZ.w $03F3
            
            JSR.w FlagMovingIntoSlopes_Horizontal
            
            LDA.b $6B : AND.b #$0F : BEQ .BRANCH_UPSILON
                RTS

    .BRANCH_UPSILON

    STZ.b $6B
    
    LDA.b $EE : BNE .BRANCH_PHI
        LDA.w $034C : AND.b #$07 : BEQ .BRANCH_CHI
            LDA.b #$01 : TSB.w $0322
            
            BRA .BRANCH_PSI

        .BRANCH_CHI

        LDA.w $02E8 : AND.b #$07 : BNE .BRANCH_PSI
            LDA.b $0E : AND.b #$02 : BNE .BRANCH_PSI
                LDA.w $0322 : AND.b #$FE : STA.w $0322
                
                BRA .BRANCH_PSI

    .BRANCH_PHI

    LDA.w $0320 : AND.b #$07 : BEQ .BRANCH_OMEGA
        LDA.b #$02 : TSB.w $0322
        
        BRA .BRANCH_PSI

    .BRANCH_OMEGA

    ; Apparently they knew how to use TSB but now how to use TRB.
    ; LDA.b #$02 : TRB $0322 would have worked here.
    LDA.w $0322 : AND.b #$FD : STA.w $0322

    .BRANCH_PSI

    LDA.w $02F7 : AND.b #$22 : BEQ .no_blue_rupee_touch
        LDX.b #$00
        
        AND.b #$20 : BEQ .touched_upper_rupee_half
            LDX.b #$08

        .touched_upper_rupee_half

        STX.b $00
        STZ.b $01
        
        LDA.b $66 : ASL A : TAY
        
        REP #$20
        
        LDA.l $7EF360 : CLC : ADC.w #$0005 : STA.l $7EF360
        
        ; Configure the address where the clearing of the rupee tile will occur.
        LDA.b $20
        CLC : ADC.w RupeeTileOffset_y, Y : SEC : SBC.b $00 : STA.b $00

        LDA.b $22
        CLC : ADC.w RupeeTileOffset_x, Y                   : STA.b $02
        
        SEP #$20
        
        JSL.l Dungeon_ClearRupeeTile
        
        LDA.b #$0A : JSR.w Player_DoSfx3

    .no_blue_rupee_touch

    LDY.b #$01
    
    LDA.w $03F1
    
    AND.b #$22 : BEQ .BRANCH_DEL
        AND.b #$20 : BEQ .BRANCH_THEL
            LDY.b #$02

        .BRANCH_THEL

        STY.w $03F3

        ; $03C64D LONG BRANCH LOCATION
        ; TODO: Confirm this.

        BRA .BRANCH_SIN

    .BRANCH_DEL

    LDY.b #$03
    
    LDA.w $03F2
    
    AND.b #$22 : BEQ .BRANCH_SHIN
        AND.b #$20 : BEQ .BRANCH_SOD
            LDY.b #$04

        .BRANCH_SOD

        STY.w $03F3
        
        BRA .BRANCH_SIN

    .BRANCH_SHIN

    LDA.w $02E8 : AND.b #$07 : BNE .BRANCH_SIN
        LDA.b $0E : AND.b #$02 : BNE .BRANCH_SIN
            STZ.w $03F3

    .BRANCH_SIN

    LDA.w $036E : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_DOD
        JSR.w RunLedgeHopTimer : BCC .BRANCH_DOD
            JSR.w Player_HaltDashAttack
            
            INC.w $047A
            
            LDA.b #$02 : STA.b $4D
            
            BRA .BRANCH_TOD

    .BRANCH_DOD

    LDA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ZOD
        LDA.w $0345 : BNE .BRANCH_ZOD
            LDA.b $5D : CMP.b #$06 : BEQ .BRANCH_ZOD
                LDA.b $3E : STA.b $20
                LDA.b $40 : STA.b $21
                LDA.b $3F : STA.b $22
                LDA.b $41 : STA.b $23
                
                JSR.w Player_HaltDashAttack
                
                LDA.b $1D : BNE .BRANCH_HEH
                    JSL.l Player_LedgeJumpInducedLayerChange
                    
                    BRA .BRANCH_TOD

                .BRANCH_HEH

                LDA.b #$01 : STA.w $0345
                
                LDA.b $26 : STA.w $0340
                
                STZ.w $0308
                STZ.w $0309
                STZ.w $0376
                STZ.b $5E
                
                JSL.l Player_ResetSwimState

                .BRANCH_TOD

                LDA.b #$01 : STA.w $037B
                
                JSR.w Link_HopInOrOutOfWater_Horizontal
                
                LDA.b #$20 : JSR.w Player_DoSfx2
                
                BRA .BRANCH_JIIM

    .BRANCH_ZOD

    LDA.w $0343 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_JIIM
        LDA.w $0345 : BEQ .BRANCH_JIIM
            LDA.b $4D : BEQ .BRANCH_EIN
                LDA.b #$07 : STA.b $0E
                
                BRA .BRANCH_JIIM

            .BRANCH_EIN

            JSR.w Player_HaltDashAttack
            
            LDA.b $4D : BNE .BRANCH_JIIM
                LDA.w $0340 : STA.b $26
                
                STZ.w $0345
                
                LDA.b #$15
                LDY.b #$00
                
                JSL.l AddTransitionSplash ; $0498FC IN ROM
                
                LDA.b #$01 : STA.w $037B
                
                JSR.w Link_HopInOrOutOfWater_Horizontal

    .BRANCH_JIIM

    LDA.b $59 : AND.b #$05 : BEQ .BRANCH_GHEIN
        LDA.b $0E : AND.b #$02 : BNE .BRANCH_GHEIN
            LDA.b $5D
            
            CMP.b #$05 : BEQ .BRANCH_FATHA
            CMP.b #$02 : BEQ .BRANCH_FATHA
                LDA.b #$09 : STA.b $5C
                
                STZ.b $5A
                
                LDA.b #$01 : STA.b $5B
                LDA.b #$01 : STA.b $5D

            .BRANCH_FATHA

            RTS

    .BRANCH_GHEIN

    STZ.b $5B
    
    LDA.w $02E8 : AND.b #$07 : BEQ .BRANCH_KESRA
        LDA.b $46 : ORA.w $031F : ORA.b $55 : BNE .BRANCH_DUMMA
            LDA.b $22
            
            LDY.b $66 : CPY.b #$02 : BNE .BRANCH_YEH
                AND.b #$04 : BEQ .BRANCH_WAW
                    BRA .BRANCH_KESRA

            .BRANCH_YEH

            AND.b #$04 : BEQ .BRANCH_KESRA
                .BRANCH_WAW

                LDA.w $031F : BNE .BRANCH_KESRA
                    LDA.l $7EF35B : TAY
                    
                    LDA.w SpikeDamageValues, Y : STA.w $0373
                    
                    JSR.w Player_HaltDashAttack
                    JSR.w Link_ForceUnequipCape_quietly
                    
                    BRL LinkApplyTileRebound

        .BRANCH_DUMMA

        LDA.w $02E8 : AND.b #$07 : STA.b $0E

    .BRANCH_KESRA

    LDA.w $046C : BEQ .BRANCH_ALPHA2
    CMP.b #$04 : BEQ .BRANCH_ALPHA2
        LDA.b $EE : BNE .BRANCH_BETA2

    .BRANCH_ALPHA2

    LDA.b $5F : ORA.b $60 : BEQ .BRANCH_GAMMA2
        LDA.b $6A : BNE .BRANCH_GAMMA2
            LDA.b $5F : STA.w $02C2
            
            DEC.b $61 : BPL .BRANCH_BETA2
                REP #$20
                
                LDY.b #$0F
                
                LDA.b $5F

                .BRANCH_THETA2

                    ASL A : BCC .BRANCH_DELTA2
                        PHA : PHY
                        
                        SEP #$20
                        
                        JSR.w FindFreeMovingBlockSlot : BCS .BRANCH_EPSILON2
                            STX.b $0E
                            
                            TYA : ASL A : TAX
                            
                            JSR.w InitializePushBlock : BCS .BRANCH_EPSILON2
                                LDA.b $0E : ASL A : TAY
                                
                                JSR.w Underworld_DrawSinglePushBlock
                                
                                TYX
                                
                                LDY.b $66
                                
                                TYA : ASL A : STA.w $05F8, X : STA.w $0474
                                
                                LDA.w $05E4, X : CPY.b #$02 : BEQ .BRANCH_ZETA2
                                    DEC A

                                .BRANCH_ZETA2

                                AND.b #$0F : STA.w $05E8, X

                        .BRANCH_EPSILON2

                        REP #$20
                        
                        PLY : PLA

                    .BRANCH_DELTA2
                DEY : BPL .BRANCH_THETA2
                
                SEP #$20

    .BRANCH_GAMMA2

    LDA.b #$15 : STA.b $61

    .BRANCH_BETA2

    LDA.b $6A : BNE .BRANCH_IOTA2
        STZ.b $57
        
        LDA.b $5E : CMP.b #$02 : BNE .BRANCH_IOTA2
            STZ.b $5E

    
    .BRANCH_IOTA2

    ; Bleeds into the next function.
}

; $03C7FC-$03C8E8 LONG BRANCH LOCATION
HandlePushingBonkingSnaps_Horizontal:
{
    LDA.b $0E : AND.b #$07 : BNE .BRANCH_KAPPA2
        BRL .BRANCH_PI2

    .BRANCH_KAPPA2

    LDA.b $5D : CMP.b #$04 : BNE .BRANCH_LAMBDA2
        LDA.w $0312 : BNE .BRANCH_LAMBDA2
            JSR.w Player_ResetSwimCollision

    .BRANCH_LAMBDA2

    LDA.b $0E : AND.b #$02 : BEQ .BRANCH_MU2
        LDA.b $0E : PHA
        
        JSR.w Link_BonkAndSmash
        JSR.w RepelDash
        
        PLA : STA.b $0E

    .BRANCH_MU2

    LDA.b #$01 : STA.w $0302
    
    LDA.b $0E : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_NU2
        JSR.w SnapOnX
        
        BRA .BRANCH_XI2

    .BRANCH_NU2

    LDA.b $6A : CMP.b #$02 : BNE .BRANCH_OMICRON2
        .BRANCH_PI2

        BRL .BRANCH_ALPHA3

    .BRANCH_OMICRON2

    JSR.w SnapOnX
    
    LDA.b $6A : CMP.b #$01 : BEQ .BRANCH_PI2
        .BRANCH_XI2

        LDA.b $0E : AND.b #$05 : CMP.b #$05 : BEQ .BRANCH_RHO2
            AND.b #$04 : BEQ .BRANCH_SIGMA2
                LDY.b #$01
                
                LDA.b $31 : BCC .BRANCH_TAU2
                    EOR.b #$FF : INC A

                .BRANCH_TAU2

                BPL .BRANCH_UPSILON2
                    LDY.b #$FF

                .BRANCH_UPSILON2

                STY.b $00 : STZ.b $01
                
                LDA.b $0E : AND.b #$02 : BNE .BRANCH_PHI2
                    LDA.b $20 : AND.b #$07 : BNE .BRANCH_CHI2
                        JSR.w Link_BonkAndSmash
                        JSR.w RepelDash
                        
                        BRA .BRANCH_PHI2

            .BRANCH_SIGMA2

            LDY.b #$01
            
            LDA.b $31 : BPL .BRANCH_PSI2
                EOR.b #$FF : INC A

            .BRANCH_PSI2

            BPL .BRANCH_OMEGA2
                LDY.b #$FF

            .BRANCH_OMEGA2

            STY.b $00 : STZ.b $01
            
            LDA.b $0E : AND.b #$02 : BNE .BRANCH_PHI2
                LDA.b $20 : AND.b #$07 : BNE .BRANCH_CHI2

        .BRANCH_RHO2

        JSR.w Link_BonkAndSmash
        JSR.w RepelDash
        
        BRA .BRANCH_PHI2

        .BRANCH_CHI2

        JSR.w AddAbsoluteScratchToYCoord
        JMP.w HandleNudging

        .BRANCH_PHI2

        LDA.b $66 : ASL A : CMP.b $2F : BNE .BRANCH_ALPHA3
            LDA.w $0315 : AND.b #$01 : ASL A : TSB.b $48
            
            LDA.b $3C : BNE .BRANCH_BETA3
                DEC.w $0371 : BPL .BRANCH_GAMMA3

            .BRANCH_BETA3

            LDY.w $0315
            
            LDA.w $02F6 : AND.b #$20 : BEQ .BRANCH_DELTA3
                LDA.w $0315 : ASL #3 : TAY

            .BRANCH_DELTA3

            TYA : TSB.b $48
            
            BRA .BRANCH_ALPHA3
            
            LDA.b $EE : BNE .BRANCH_GAMMA3
                LDA.b $48 : AND.b #$F6 : STA.b $48

    .BRANCH_ALPHA3

    LDA.b #$20 : STA.w $0371
    
    LDA.b $48 : AND.b #$FD : STA.b $48

    .BRANCH_GAMMA3

    RTS
}

; $03C8E9-$03CB83 LONG BRANCH LOCATION
StartMovementCollisionChecks_Horizontal_HandleOutdoors:
{
    LDA.b $6A : BNE .BRANCH_ALPHA
        STZ.b $57
        
        LDA.b $5E : CMP.b #$02 : BNE .BRANCH_ALPHA
            STZ.b $5E

    .BRANCH_ALPHA

    LDA.b $59 : AND.b #$05 : BEQ .BRANCH_BETA
        LDA.b $0E : AND.b #$02 : BNE .BRANCH_BETA
            LDA.b $5D
            
            CMP.b #$05 : BEQ .BRANCH_GAMMA
            CMP.b #$02 : BEQ .BRANCH_GAMMA
                LDA.b #$09 : STA.b $5C
                
                STZ.b $5A
                
                LDA.b #$01 : STA.b $5B
                
                LDA.b #$01 : STA.b $5D

            .BRANCH_GAMMA

            RTS

    .BRANCH_BETA

    LDA.w $0366 : AND.b #$02 : BEQ .BRANCH_DELTA
        LDA.w $036A : ASL A : STA.w $0369
        
        BRA .BRANCH_EPSILON

    .BRANCH_DELTA

    STZ.w $0369

    .BRANCH_EPSILON

    LDA.w $0341 : AND.b #$04 : BEQ .BRANCH_ZETA
        ; OPTIMIZE: Unnecessary branch and block of code.
        BRA .BRANCH_THETA
        
        ; This location is unreachable. It seems this bit skipped temporarily
        ; and was forgotten.
        .UNREACHABLE_07C938
        LDA.w $0341 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_ZETA

        .BRANCH_THETA

        LDA.w $0345 : BNE .BRANCH_ZETA
            LDA.b $4D : BNE .BRANCH_ZETA
                JSR.w Player_HaltDashAttack
                JSR.w Link_ResetSwordAndItemUsage
                
                LDA.b #$01 : STA.w $0345
                
                LDA.b $26 : STA.w $0340
                
                JSL.l Player_ResetSwimState
                
                STZ.w $0376
                STZ.b $5E
                
                LDA.w $0351 : CMP.b #$01 : BNE .BRANCH_IOTA
                    JSR.w Link_ForceUnequipCape_quietly
                    
                    LDA.l $7EF356 : BEQ .BRANCH_IOTA
                        LDA.w $02E0 : BNE .BRANCH_ZETA
                            LDA.b #$04 : STA.b $5D
                            
                            BRA .BRANCH_ZETA

                .BRANCH_IOTA

                LDA.b $3E : STA.b $20
                LDA.b $40 : STA.b $21
                
                LDA.b $3F : STA.b $22
                LDA.b $41 : STA.b $23
                
                LDA.b #$01 : STA.w $037B
                
                JSR.w Link_HopInOrOutOfWater_Horizontal
                
                LDA.b #$20 : JSR.w Player_DoSfx2

    .BRANCH_ZETA
    
    LDA.w $0345 : BEQ .BRANCH_KAPPA
        LDA.w $036E : AND.b #$07 : CMP.b #$07 : BEQ .BRANCH_LAMBDA
            BRA .BRANCH_MU

    .BRANCH_KAPPA

    LDA.w $036D : AND.b #$42 : BEQ .BRANCH_MU
        .BRANCH_LAMBDA

        LDA.b #$07 : STA.b $0E
        
        BRL HandlePushingBonkingSnaps_Horizontal

    .BRANCH_MU

    LDA.w $0343 : AND.b #$07 : CMP.b #$07 : BNE .BRANCH_NU
        LDA.w $0345 : BEQ .BRANCH_NU
            JSR.w Player_HaltDashAttack
            
            LDA.b $4D : BNE .BRANCH_NU
                LDA.w $0340 : STA.b $26
                
                STZ.w $0345
                
                LDA.b #$15
                LDY.b #$00
                
                JSL.l AddTransitionSplash ; $0498FC IN ROM
                
                LDA.b #$01 : STA.w $037B
                
                BRL Link_HopInOrOutOfWater_Horizontal

    .BRANCH_NU

    LDA.w $036E : AND.b #$07 : BEQ .BRANCH_XI
        JSR.w RunLedgeHopTimer : BCC .BRANCH_XI
            LDA.b #$20 : JSR.w Player_DoSfx2
            
            LDX.b #$10
            
            LDA.b $66 : AND.b #$01 : BNE .BRANCH_OMICRON
                TXA : EOR.b #$FF : INC A : TAX

            .BRANCH_OMICRON

            STX.b $28
            
            JSR.w Player_HaltDashAttack
            
            LDA.b #$02 : STA.b $4D
            
            LDA.b #$14 : STA.w $0362 : STA.w $0363
            
            LDA.b #$FF : STA.w $0364
            
            LDA.b #$0C : STA.b $5D ; $03CA1B
            
            LDA.b #$01 : STA.w $037B : STA.b $78
            
            STZ.b $48
            STZ.b $5E
            
            LDA.b $1B : BNE .BRANCH_PI
                LDA.b #$02 : STA.b $EE

            .BRANCH_PI

            LDA.b $66 : AND.b #$FD : ASL A : TAY
            
            LDA.b $22 : PHA
            LDA.b $23 : PHA
            
            JSR.w Link_HoppingHorizontally_FindTile_Horizontal
            
            LDA.b #$01 : STA.b $66
            
            CPX.b #$FF : BEQ .BRANCH_RHO
                JSR.w Link_HoppingHorizontally_FindTile_Vertical
                
                BRL .BRANCH_SIGMA

            .BRANCH_RHO

            JSR.w LinkHop_FindTileToLandOnSouth

            .BRANCH_SIGMA

            PLA : STA.b $23
            PLA : STA.b $22
            
            RTS

    .BRANCH_XI

    LDA.w $0370 : AND.b #$77 : BEQ .BRANCH_TAU
        JSR.w RunLedgeHopTimer : BCC .BRANCH_TAU
            LDA.b #$20 : JSR.w Player_DoSfx2
            
            LDX.b #$0F
            
            AND.b #$07 : BNE .BRANCH_UPSILON
                LDX.b #$10

            .BRANCH_UPSILON

            STX.b $5D
            
            LDX.b #$10
            
            LDA.b $66 : AND.b #$01 : BNE .BRANCH_PHI
                LDX.b #$F0

            .BRANCH_PHI

            STX.b $28
            
            JSR.w Player_HaltDashAttack
            
            LDA.b #$02 : STA.b $4D
            
            LDA.b #$14 : STA.w $0362 : STA.w $0363
            
            LDA.b #$FF : STA.w $0364
            
            STZ.b $46
            
            LDA.b #$01 : STA.w $037B : STA.b $78
            
            STZ.b $48
            STZ.b $5E
            
            RTS

    .BRANCH_TAU

    LDA.w $036E : AND.b #$70 : BEQ .BRANCH_CHI
        LDA.w $036E : AND.b #$07 : BNE .BRANCH_CHI
            LDA.w $0370 : AND.b #$77 : BNE .BRANCH_CHI
                LDA.b $5D : CMP.b #$0D : BEQ .BRANCH_CHI
                
                JSR.w RunLedgeHopTimer : BCC .BRANCH_CHI
                    LDA.b #$20 : JSR.w Player_DoSfx2
                    
                    JSR.w Player_HaltDashAttack
                    
                    LDA.b #$01 : STA.w $037B
                    
                    STZ.b $48
                    STZ.b $5E
                    
                    BRL Link_FindValidLandingTile_DiagonalNorth

    .BRANCH_CHI

    LDA.w $036F : AND.b #$07 : BEQ .BRANCH_PSI
        LDA.w $036E : AND.b #$07 : BNE .BRANCH_PSI
            LDA.w $0370 : AND.b #$77 : BNE .BRANCH_PSI
                JSR.w RunLedgeHopTimer : BCC .BRANCH_PSI
                    LDX.b #$10
                    
                    LDA.b $66 : AND.b #$01 : BNE .BRANCH_OMEGA
                        TXA : EOR.b #$FF : INC A : TAX

                    .BRANCH_OMEGA

                    STX.b $28
                    
                    JSR.w Player_HaltDashAttack
                    
                    LDA.b #$02 : STA.b $4D
                    
                    LDA.b #$14 : STA.w $0362 : STA.w $0363
                    
                    LDA.b #$FF : STA.w $0364
                    
                    LDA.b #$0E : STA.b $5D
                    
                    STZ.b $46
                    
                    LDA.b #$01 : STA.w $037B : STA.b $78
                    
                    STZ.b $48
                    STZ.b $5E
                    
                    RTS

    .BRANCH_PSI

    LDA.b $0E : AND.b #$02 : BNE .BRANCH_ALIF
        LDA.b $0C : AND.b #$05 : BEQ .BRANCH_ALIF
            LDA.w $0372 : BEQ .BRANCH_BET
                LDA.b $2F : AND.b #$04 : BEQ .BRANCH_ALIF

            .BRANCH_BET

            JSR.w FlagMovingIntoSlopes_Horizontal
            
            LDA.b $6B : AND.b #$0F : BEQ .BRANCH_ALIF
                RTS

    .BRANCH_ALIF

    STZ.b $6B
    
    ; Check for spike block interactions.
    LDA.w $02E8 : AND.b #$07 : BEQ .noSpikeBlockInteraction
        ; Link is flashing or otherwise invincible.
        LDA.b $46 : ORA.w $031F : ORA.b $55 : BNE .ignoreSpikeBlocks
            LDA.b $22
            
            LDY.b $66 : CPY.b #$02 : BNE .didntMoveLeft
                ; This is a tad strange, seems like more of a tweak than
                ; anything else.
                AND.b #$04 : BEQ .notOn4PixelGrid
                    BRA .noSpikeBlockInteraction

            .didntMoveLeft

            AND.b #$04 : BEQ .noSpikeBlockInteraction
                .notOn4PixelGrid

                ; Use armor value to determine damage to be doled out.
                LDA.l $7EF35B : TAY
                
                LDA.w SpikeDamageValues, Y : STA.w $0373
                
                JSR.w Player_HaltDashAttack
                
                BRL LinkApplyTileRebound

        .ignoreSpikeBlocks

        LDA.w $02E8 : AND.b #$07 : STA.b $0E

    .noSpikeBlockInteraction

    BRL HandlePushingBonkingSnaps_Horizontal
}

; $03CB84-$03CB9E LOCAL JUMP LOCATION
SnapOnX:
{
    REP #$20
    
    LDA.b $22 : AND.w #$0007
    
    LDY.b $31 : BPL .BRANCH_ALPHA
        SEC : SBC.w #$0008
    
    .BRANCH_ALPHA
    
    EOR.w #$FFFF : INC A : CLC : ADC.b $22 : STA.b $22
    
    SEP #$20
    
    RTS
}

; $03CB9F-$03CBC8 JUMP LOCATION
CalculateSnapScratch_Horizontal:
{
    LDA.b $0E : AND.b #$04 : BEQ .BRANCH_ALPHA
        LDY.b #$01
        
        LDA.b $31 : BMI .BRANCH_BETA
            EOR.b #$FF : INC A
        
        .BRANCH_BETA
        
        BPL .BRANCH_GAMMA
            LDY.b #$FF
        
        .BRANCH_GAMMA
        
        STY.b $00 : STZ.b $01
        
        BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA
    
    LDY.b #$01
    
    LDA.b $31 : BPL .positive_x
        EOR.b #$FF : INC A
    
    .positive_x
    
    BPL .was_positive_b
        LDY.b #$FF
    
    .was_positive_b
    
    STY.b $00 : STZ.b $01
    
    .BRANCH_DELTA

    ; Bleeds into the next function.
}

; $03CBC9-$03CBDC LOCAL JUMP LOCATION
AddAbsoluteScratchToYCoord:
{
    REP #$20
    
    LDA.b $00 : CMP.w #$0080 : BCC .BRANCH_THETA
        ORA.w #$FF00
    
    .BRANCH_THETA
    
    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20
    
    RTS
}

; $03CBDD-$03CC32 LOCAL JUMP LOCATION
ChangeAxisOfPerpendicularDoorMovement_Horizontal:
{
    LDA.b #$02 : TSB.b $50
    
    LDA.b $0E : LSR #4 : ORA.b $0E : AND.b #$0F : STA.b $00
    AND.b #$07 : BNE .BRANCH_ALPHA
        STZ.b $6C
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b $20 : CMP.b #$80 : BCC .BRANCH_GAMMA
        LDA.b $31 : BMI .BRANCH_DELTA
            EOR.b #$FF : INC A

        .BRANCH_DELTA

        STA.b $00 : STZ.b $01
        
        LDY.b #$00
        
        BRA .BRANCH_EPSILON

    .BRANCH_GAMMA

    LDA.b $31 : BPL .BRANCH_ZETA
        EOR.b #$FF : INC A

    .BRANCH_ZETA

    STA.b $00 : STZ.b $01
    
    LDY.b #$02

    .BRANCH_EPSILON

    LDA.b $50 : AND.b #$01 : BNE .BRANCH_THETA
        STY.b $2F

    .BRANCH_THETA

    REP #$20
    
    LDA.b $00 : CMP.w #$0080 : BCC .BRANCH_IOTA
        ORA.w #$FF00

    .BRANCH_IOTA

    CLC : ADC.b $20 : STA.b $20
    
    SEP #$20

    .BRANCH_BETA

    RTS
}

; $03CC33-$03CC3B DATA
Pool_Link_HopInOrOutOfWater_Horizontal:
{
    ; $03CC33
    .speed_x
    db 28, 24, 16

    ; $03CC36
    .speed_z
    db 32, 24, 24

    ; $03CC39
    .timer
    db 16, 16, 16
}

; $03CC3C-$03CC82 LOCAL JUMP LOCATION
Link_HopInOrOutOfWater_Horizontal:
{
    LDA.b $1B : BNE .BRANCH_ALPHA
        LDX.b #$02
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDX.b $1D
    
    LDA.w $047A : BEQ .BRANCH_BETA
        LDX.b #$00
    
    .BRANCH_BETA
    
    STX.b $00
    
    LDA.w Pool_Link_HopInOrOutOfWater_Horizontal_speed_x, X : TAX
    
    LDA.b $66 : AND.b #$01 : BNE .BRANCH_GAMMA
        TXA : EOR.b #$FF : INC A : TAX
    
    .BRANCH_GAMMA
    
    STX.b $28
    STZ.b $27
    
    LDX.b $00
    
    LDA.w Pool_Link_HopInOrOutOfWater_Horizontal_speed_z, X : STA.b $29 : STA.w $02C7
    
    LDA.w Pool_Link_HopInOrOutOfWater_Horizontal_timer, X : STA.b $46
    
    LDA.b $4D : CMP.b #$02 : BEQ .BRANCH_DELTA
        LDA.b #$01 : STA.b $4D
        
        STZ.w $0360
    
    .BRANCH_DELTA
    
    LDA.b #$06 : STA.b $5D
    
    RTS
}

; $03CC83-$03CCAA DATA
DiagonalKickback:
{
    ; $03CC83
    .right
    db   0,   1,   1,   1
    db   2,   2,   2,   3
    db   3,   3

    ; $03CC8D
    .left
    db   0,  -1,  -1,  -1
    db  -2,  -2,  -2,  -3
    db  -3,  -3

    ; $03CC97
    .down
    db   0,   0,   0,   1
    db   1,   1,   2,   2
    db   2,   3

    ; $03CCA1
    .up
    db   0,   1,   1,   2
    db   2,   2,   3,   3
    db   3,   3
}

; $03CCAB-$03CD7A LOCAL JUMP LOCATION
Link_HandleDiagonalKickback:
{
    ; Denotes how much Link will move during the frame in a vertical direction
    ; (signed).
    LDA.b $30 : BEQ .BRANCH_ALPHA
        ; This is reached if there is vertical movement.
        LDA.b $31 : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    ; This is executed if there is no horizontal movement (vertical doesn't
    ; matter).
    
    BRL .BRANCH_THETA
        .BRANCH_BETA
        
        ; Basically this code executes only if Link is moving diagonally.
        
        ; $02DE[2] = mirror of Link's Y coordinate
        LDA.b $20 : STA.w $02DE
        LDA.b $21 : STA.w $02DF
        
        ; $02DC[2] = mirror of Link's X coordinate
        LDA.b $22 : STA.w $02DC
        LDA.b $23 : STA.w $02DD
        
        LDY.b #$04
        
        ; Is Link moving to the left? If so, branch.
        LDA.b $31 : BMI .BRANCH_GAMMA
            ; This probably sets up a different hit detection box because he's
            ; looking in a different direction.
            LDY.b #$06
        
        .BRANCH_GAMMA
        
        JSR.w TileDetect_Movement_Horizontal
        
        LDA.b $0C : AND.b #$05 : BEQ .BRANCH_DELTA
            JSR.w FlagMovingIntoSlopes_Horizontal
            
            LDA.b $6B : AND.b #$0F : BNE .BRANCH_EPSILON
        
        .BRANCH_DELTA
        
        BRL .BRANCH_THETA
            .BRANCH_EPSILON
            
            REP #$20
            
            LDA.b $22 : SEC : SBC.w $02DC : STA.b $00
            
            LDA.w $02DC : STA.b $22
            
            SEP #$20
            
            LDA.b $00 : STA.b $31
            
            LDY.b #$00
            
            LDA.b $30 : BMI .BRANCH_ZETA
                LDY.b #$02
            
            .BRANCH_ZETA
            
            JSR.w TileDetect_Movement_Vertical
            
            LDA.b $0C : AND.b #$05 : BEQ .BRANCH_THETA
                JSR.w FlagMovingIntoSlopes_Vertical

                LDA.b $6B : AND.b #$0F : BEQ .BRANCH_THETA
                    
                    ; Store the diagonal movement characteristics to $6D (but
                    ; why?).
                    LDA.b $6B : STA.b $6D
                    
                    REP #$20
                    
                    LDA.b $20 : SEC : SBC.w $02DE : STA.b $00
                    
                    SEP #$20
                    
                    LDA.b $00 : STA.b $30
                    
                    LDY.b $31 : BMI .BRANCH_IOTA
                        LDA.w DiagonalKickback_right, Y
                        
                        BRA .BRANCH_KAPPA
                    
                    .BRANCH_IOTA
                    
                    TYA : EOR.b #$FF : INC A : TAY
                    
                    LDA.w DiagonalKickback_left, Y
                    
                    .BRANCH_KAPPA
                    
                    REP #$20
                    
                    AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_LAMBDA
                        ORA.w #$FF00
                    
                    .BRANCH_LAMBDA
                    
                    CLC : ADC.b $22 : STA.b $22
                    
                    SEP #$20
                    
                    LDY.b $30 : BMI .BRANCH_MU
                        LDA.w DiagonalKickback_down, Y
                        
                        BRA .BRANCH_NU
                    
                    .BRANCH_MU
                    
                    TYA : EOR.b #$FF : INC A : TAY
                    
                    LDA.w DiagonalKickback_up, Y
                    
                    .BRANCH_NU
                    
                    REP #$20
                    
                    AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_XI
                        ORA.w #$FF00
                    
                    .BRANCH_XI
                    
                    CLC : ADC.b $20 : STA.b $20
                    
                    SEP #$20
                    
                    BRA .BRANCH_OMICRON
    
    .BRANCH_THETA
    
    STZ.b $6D
    
    .BRANCH_OMICRON
    
    STZ.b $6B
    
    RTS
}

; $03CD7B-$03CDCA
TileDetect_Movement:
{
    ; $03CD7B
    .offset_same_axis
    dw $0008, $0018, $0000, $000F

    ; $03CD83
    .offset_perpendicular_axis_1
    dw $0000, $0000

    ; $03CD87
    .offset_pit_y
    dw $0008

    ; $03CD89
    .unused_a
    dw $0008

    ; $03CD8B
    .offset_perpendicular_axis_2
    dw $0008, $0008, $0010, $0010

    ; $03CD93
    .offset_perpendicular_axis_3
    dw $000F, $000F

    ; $03CD97
    .offset_pit_x
    dw $0017

    ; $03CD99
    .unused_b
    dw $0017, $0000, $0000, $001F, $001F

    ; $03CDA3
    .offset_slope_same_axis
    dw $0007, $0018, $FFFF, $0010

    ; $03CDAB
    .offset_slope_perpendicular_axis_1
    dw $0000, $0000, $0008, $0008

    ; $03CDB3
    .offset_slope_perpendicular_axis_2
    dw $000F, $000F, $0017, $0017
    dw $0000, $0000, $0000, $000F
    dw $0000, $0000, $0012, $0012
}

; This probably the up/down movement handler analagous to $03CE2A below
; $03CDCB-$03CE29 LOCAL JUMP LOCATION
TileDetect_Movement_Vertical:
{
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    STZ.b $59
    
    LDA.b $20 : CLC : ADC.w TileDetect_Movement_offset_same_axis, Y : STA.b $51
    AND.b $EC : STA.b $00

    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_1, Y
    AND.b $EC : LSR #3 : STA.b $02

    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_2, Y
    AND.b $EC : LSR #3 : STA.b $04

    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_3, Y
    AND.b $EC : LSR #3 : STA.b $74
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $74 : STA.b $02
    
    LDA.w #$0004 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; Note, this routine only execute when Link is moving horizontally (Yes, it
; will execute if he's moving in a diagonal direction since that includes
; horizontal).
; $03CE2A-$03CE84 LOCAL JUMP LOCATION
TileDetect_Movement_Horizontal:
{
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    STZ.b $59
    
    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_same_axis, Y
    AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $20 : CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_1, Y
    AND.b $EC : STA.b $00
    
    LDA.b $20
    CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_2, Y : STA.b $51
    AND.b $EC : STA.b $04
    
    LDA.b $20
    CLC : ADC.w TileDetect_Movement_offset_perpendicular_axis_3, Y : STA.b $53
    AND.b $EC : STA.b $08
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $00
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $08 : STA.b $00
    
    LDA.w #$0004 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; $03CE85-$03CEC8 LOCAL JUMP LOCATION
TileDetect_Movement_VerticalSlopes:
{
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    STZ.b $59
    
    LDA.b $20 : CLC : ADC.w TileDetect_Movement_offset_slope_same_axis, Y
    AND.b $EC : STA.b $00
    
    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_slope_perpendicular_axis_1, Y
    AND.b $EC : LSR #3 : STA.b $02

    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_slope_perpendicular_axis_2, Y
    AND.b $EC : LSR #3 : STA.b $04
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; $03CEC9-$03CF09 LOCAL JUMP LOCATION
TileDetect_Movement_HorizontalSlopes:
{
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    STZ.b $59
    
    LDA.b $22 : CLC : ADC.w TileDetect_Movement_offset_slope_same_axis, Y
    AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $20 : CLC : ADC.w TileDetect_Movement_offset_slope_perpendicular_axis_1, Y
    AND.b $EC : STA.b $00
    
    LDA.b $20 : CLC : ADC.w TileDetect_Movement_offset_slope_perpendicular_axis_2, Y
    AND.b $EC : STA.b $04
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $00
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03CF0A-$03CF11 LONG JUMP LOCATION
Player_TileDetectNearbyLong:
{
    PHB : PHK : PLB
    
    JSR.w Player_TileDetectNearby
    
    PLB
    
    RTL
}

; ==============================================================================

; $03CF12-$03CF48 LOCAL JUMP LOCATION
Player_TileDetectNearby:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    LDA.b $22 : CLC : ADC.w $CD83offset_perpendicular_axis_1 : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $22 : CLC : ADC.w $CD93offset_perpendicular_axis_3 : AND.b $EC : LSR #3 : STA.b $04
    
    LDA.b $20 : CLC : ADC.w $CD87offset_pit_y : AND.b $EC : STA.b $00 : STA.b $74
    
    LDA.b $20 : CLC : ADC.w $CD97offset_pit_x : AND.b $EC : STA.b $08
    
    ; Bleeds into the next function.
}

; $03CF49-$03CF7D LOCAL JUMP LOCATION
TileDetect_FromMirrorBonk:
{
    REP #$10
    
    LDA.w #$0008 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $08 : STA.b $00
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $74 : STA.b $00
    
    LDA.b $04 : STA.b $02
    
    LDA.w #$0004 : STA.b $02
    
    JSR.w TileDetect_Execute
    
    LDA.b $08 : STA.b $00
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03CF7E-$03CFCB LOCAL JUMP LOCATION
TileDetect_UnusedIce:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    LDA.b $22 : CLC : ADC.w #$0000 : AND.b $EC : LSR #3 : STA.b $02
    LDA.b $22 : CLC : ADC.w #$0008 : AND.b $EC : LSR #3 : STA.b $04
    
    LDA.b $24 : AND.w #$00FF : CMP.w #$00FF : BNE .BRANCH_ALPHA
        LDA.w #$0000
    
    .BRANCH_ALPHA
    
    CLC : ADC.b $20 : AND.b $EC : STA.b $00
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03CFCC-$03D076 DATA
Pool_TileDetect_MainHandler:
{
    ; $03CFCC
    .offset_y
    dw  20,  20,  20,  20
    dw   4,  28,  16,  16
    dw  22,  22,  22,  22
    dw   4,  24,  16,  16
    dw  16,  16,  16,  16
    dw  20,  20,  23,  23
    dw  -4,  36,  16,  16
    dw   4,  28,  16,  16
    dw   4,  28,  16,  16
    dw   4,   4,  28,  28

    ; $03D01C
    .offset_x
    dw   8,   8,   8,   8
    dw   6,   8,  -1,  22
    dw  19,  19,   0,  19
    dw   6,   8,  -1,  22
    dw   8,   8,   8,   8
    dw   8,   8,   0,  15
    dw   6,   8, -10,  29
    dw   6,   8,  -6,  22
    dw   6,   8,  -4,  22
    dw  -4,  22,  -4,  22

    ; $03D06C
    .spike_floor_damage
    db $08 ; Green
    db $08 ; Blue
    db $08 ; Red

    ; $03D06F
    .index_offset
    db $0A, $06, $0E, $02
    db $0C, $04, $08, $00
}

; Takes Y as an input ranging from 0x00 to 0x08.
; The different behaviors with each has not been figured out yet.
; $03D077-$03D2C5 LOCAL JUMP LOCATION
TileDetect_MainHandler:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    STY.b $00 : CPY.b #$08 : BNE .alpha
        ; Checking to see if a spin attack is still executing.
        LDA.w $031C : AND.w #$00FF : DEC #2 : BMI .stillSpinAttacking
            CMP.w #$0008 : BCS .stillSpinAttacking
                PHY
                
                TAY
                
                LDA.w $D06F, Y : AND.w #$00FF : CLC : ADC.w #$0040 : TAY
                
                BRA .delta
    
    .alpha
    
    PHY
    
    ; Use the direction link is facing and the action in question to form an
    ; index.
    LDA.b $00 : AND.w #$00FF : ASL #3 : CLC : ADC.b $2F : TAY
    
    .delta
    
    ; Find some coordinates relative to Link, but depending on.
    LDA.b $22 : CLC : ADC.w $D01C, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $20 : CLC : ADC.w $CFCC, Y : AND.b $EC : STA.b $00
    
    LDA.w #$0001 : STA.b $0A
    
    PLY
    
    REP #$10
    
    ; 0 - nothing, just standing there, 1 - sword, others - ????
    TYA
    
    CMP.w #$0001 : BEQ .BRANCH_EPSILON
    CMP.w #$0002 : BEQ .BRANCH_EPSILON
    CMP.w #$0003 : BEQ .BRANCH_EPSILON
    CMP.w #$0006 : BEQ .BRANCH_EPSILON
    CMP.w #$0007 : BEQ .BRANCH_EPSILON
    CMP.w #$0008 : BEQ .BRANCH_EPSILON
        ; Action types 0x00, 0x05, and 0x04 end up here.
        PHY
        
        JSR.w TileDetect_Execute
        
        PLY
        
        BRA .BRANCH_MU
    
    .BRANCH_EPSILON
    
    SEP #$30
    
    JSR.w $DC4A ; $03DC4A IN ROM
    
    .stillSpinAttacking
    
    SEP #$30
    
    .BRANCH_XI
    
        BRL .return
        
        .BRANCH_MU
        
        SEP #$30
    CPY.b #$05 : BEQ .BRANCH_XI
    
    LDA.w $0357 : AND.b #$10 : BEQ .BRANCH_OMICRON
        LDA.b $20 : CLC : ADC.b #$08 : AND.b #$0F
        
        CMP.b #$04 : BCC .BRANCH_PI
            CMP.b #$0B : BCC .BRANCH_RHO
        
        .BRANCH_PI
        
        LDA.b $22 : AND.b #$0F
        
        CMP.b #$04 : BCC .BRANCH_SIGMA
            CMP.b #$0C : BCC .BRANCH_RHO
        
        .BRANCH_SIGMA
        
        LDA.w $031F : BNE .BRANCH_RHO
            LDA.b $4D : BNE .BRANCH_RHO
                LDA.b $1B : BEQ .BRANCH_CHI
                    JSL.l Dungeon_SaveRoomQuadrantData
                    
                    LDA.b #$33 : JSR.w Player_DoSfx2
                    
                    STZ.b $5E
                    
                    LDA.b #$15 : STA.b $11
                    
                    LDA.b $A0 : STA.b $A2
                    
                    LDA.l $7EC000 : STA.b $A0
                    
                    JSR.w HandleLayerOfDestination
                    
                    BRA .BRANCH_RHO
                
                .BRANCH_CHI
                
                LDA.w $02DB : BNE .BRANCH_RHO
                    JSR.w Mirror_TryToWarp
        
        .BRANCH_RHO
        
        BRL .BRANCH_GAMMA
    
    .BRANCH_OMICRON
    
    STZ.w $02DB
    
    LDA.w $0357 : AND.b #$01 : BEQ .BRANCH_ZETA
        LDA.b #$02 : STA.w $0351
        
        JSR.w Link_PermissionForSloshSounds : BCS .BRANCH_THETA
            LDA.b $4D : BNE .BRANCH_THETA
                LDA.b #$1A : JSR.w Player_DoSfx2
        
        .BRANCH_THETA
        
        BRL .BRANCH_KAPPA
    
    .BRANCH_ZETA
    
    LDA.w $0359 : AND.b #$01 : BEQ .BRANCH_LAMBDA
        LDA.b #$01 : STA.w $0351
        
        LDA.b $1B : BNE .BRANCH_IOTA
            LDA.w $0345 : BEQ .BRANCH_IOTA
                LDA.w $02E0 : BNE .BRANCH_IOTA
                    LDA.l $7EF356 : BEQ .BRANCH_THETA
                        STZ.w $0345
                        
                        LDA.w $0340 : STA.b $26
                        
                        LDA.b #$00 : STA.b $5D
                    
                    BRL .BRANCH_KAPPA
        
        .BRANCH_IOTA
        
        JSR.w Link_PermissionForSloshSounds : BCS .BRANCH_TAU
            LDA.b $8A : CMP.b #$70 : BNE .notEvilSwamp
    
    .BRANCH_LAMBDA
    
    LDA.b #$1B : JSR.w Player_DoSfx2
    
    BRA .BRANCH_TAU
    
    .notEvilSwamp
    
    LDA.b $4D : BNE .BRANCH_TAU
        LDA.b #$1C : JSR.w Player_DoSfx2
    
    .BRANCH_TAU
    
    BRL .BRANCH_KAPPA
    
    LDA.b $1B : BNE .BRANCH_ALEPH
        LDA.w $0345 : BNE .BRANCH_ALEPH
            LDA.w $0341 : AND.b #$01 : BEQ .BRANCH_ALEPH
                LDA.b #$01 : STA.w $0351
                
                JSR.w Link_PermissionForSloshSounds : BCS .BRANCH_BET
                    ; Dat be sum swamp o' evil.
                    LDA.b $8A : CMP.b #$70 : BNE .BRANCH_DALET
                        LDA.b #$1B : JSR.w Player_DoSfx2
                        
                        BRA .BRANCH_BET
                    
                    .BRANCH_DALET
                    
                    LDA.b $4D : BNE .BRANCH_BET
                        LDA.b #$1C : JSR.w Player_DoSfx2
                
                .BRANCH_BET
                
                BRL .return
    
    .BRANCH_ALEPH
    
    STZ.w $0351
    
    LDA.w $02EE : AND.b #$01 : BEQ .chet
        ; Only current documentation on this relates to the Desert Palace
        ; opening.
        LDA.b #$01 : STA.w $02ED
        
        ; Our work is done here I guess?
        BRL .return
    
    .chet
    
    STZ.w $02ED
    
    LDA.w $02EE : AND.b #$10 : BEQ .noSpikeFloorDamage
        STZ.w $0373
        
        LDA.b $55 : BNE .noSpikeFloorDamage
            JSR.w SearchForByrnaSpark : BCS .noSpikeFloorDamage
                ; Did Link just get damaged and is still flashing?
                LDA.w $031F : BNE .noSpikeFloorDamage
                    STZ.w $03F7
                    STZ.w $03F5
                    STZ.w $03F6
                    
                    ; Moon pearl
                    LDA.l $7EF357 : BEQ .doesntHaveMoonPearl
                        STZ.b $56
                        STZ.w $02E0
                    
                    .doesntHaveMoonPearl
                    
                    ; Armor level
                    LDA.l $7EF35B : TAY
                    
                    ; Determine how much damage the spike floor will do to Link.
                    LDA.w $D06C, Y : STA.w $0373
                    
                    BRL Player_HaltDashAttack
        
    .noSpikeFloorDamage
    
    LDA.w $0348 : AND.b #$11 : BEQ .notWalkingOnIce
        LDA.w $034A : BEQ .BRANCH_AYIN
            LDA.b $6A : BEQ .BRANCH_PEY
                LDA.w $0340 : STA.b $26
                
                BRL .BRANCH_PEY
        
        .BRANCH_AYIN
        
        LDA.b $67 : AND.b #$0C : BEQ .BRANCH_TSADIE
            LDA.b #$01 : STA.w $033D
            LDA.b #$80 : STA.w $033C
        
        .BRANCH_TSADIE
        
        LDA.b $67 : AND.b #$03 : BEQ .BRANCH_QOF
            LDA.b #$01 : STA.w $033D
            LDA.b #$80 : STA.w $033C
        
        .BRANCH_QOF
        
        LDY.b #$01
        
        LDA.w $0348 : AND.b #$01 : BNE .BRANCH_RESH
            LDY.b #$02
        
        .BRANCH_RESH
        
        STY.w $034A
        
        LDA.b $26 : STA.w $0340
        
        JSL.l Player_ResetSwimState
        
        BRL .BRANCH_PEY
    
    .notWalkingOnIce
    
    LDA.b $5D : CMP.b #$04 : BEQ .BRANCH_SIN
        LDA.w $034A : BEQ .BRANCH_TAV
            LDA.w $0340 : STA.b $26
        
        .BRANCH_TAV
        
        JSL.l Player_ResetSwimState
    
    .BRANCH_SIN
    
    STZ.w $034A
    
    .BRANCH_PEY
    
    LDA.w $02E8 : AND.b #$10 : BEQ .BRANCH_KAPPA
        LDA.w $031F : BNE .BRANCH_KAPPA
            LDA.b #$3A : STA.w $031F
    
    .BRANCH_KAPPA
    .return
    
    RTS
}

; $03D2C6-$03D2E3 LOCAL JUMP LOCATION
Link_PermissionForSloshSounds:
{
    LDA.b $67 : AND.b #$0F : BEQ .BRANCH_ALPHA
        LDA.b $5D : CMP.b #$11 : BEQ .BRANCH_BETA
            LDA.b $1A : AND.b #$0F : BEQ .BRANCH_GAMMA
                BRA .BRANCH_ALPHA
        
        .BRANCH_BETA
        
        LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
            .BRANCH_GAMMA
            
            CLC
            
            RTS
        
    .BRANCH_ALPHA
    
    SEC
    
    RTS
}

; ==============================================================================

; $03D2E4-$03D303 DATA
Pool_PushBlock_AttemptToPushTheBlock:
{
    ; $03D2E4
    .target_offset_y_a
    dw $FFFC ; Up
    dw $0014 ; Down
    dw $0004 ; Left
    dw $0004 ; Right

    ; $03D2EC
    .target_offset_y_b
    dw $FFFC ; Up
    dw $0014 ; Down
    dw $000C ; Left
    dw $000C ; Right

    ; $03D2F4
    .target_offset_x_a
    dw $0004 ; Up
    dw $0004 ; Down
    dw $FFFC ; Left
    dw $0014 ; Right

    ; $03D2FC
    .target_offset_x_b
    dw $000C ; Up
    dw $000C ; Down
    dw $FFFC ; Left
    dw $0014 ; Right
}

; $03D304-$03D364 LOCAL JUMP LOCATION
PushBlock_AttemptToPushTheBlock:
{
    REP #$20
    
    TYA : ASL #3 : STA.b $0A
    
    LDA.b $66 : ASL A : CLC : ADC.b $0A : TAY
    
    LDA.b $00 : STA.b $08
    LDA.b $02 : STA.b $04
    
    LDA.b $08 : CLC : ADC.w $D2F4, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $04 : CLC : ADC.w $D2E4, Y : AND.b $EC : STA.b $00
    
    ; $03E026 IN ROM
    JSR.w $E026 : BEQ .BRANCH_ALPHA
        CPX.w #$0009 : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b $08 : CLC : ADC.w $D2FC, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $04 : CLC : ADC.w $D2EC, Y : AND.b $EC          : STA.b $00
    
    ; $03E026 IN ROM
    JSR.w $E026 : BEQ .BRANCH_GAMMA
        CPX.w #$0009 : BNE .BRANCH_BETA
    
    .BRANCH_GAMMA
    
    SEP #$30
    
    CLC
    
    RTS
    
    .BRANCH_BETA
    
    SEP #$30
    
    SEC
    
    RTS
}

; ==============================================================================

; $03D365-$03D382 DATA
Liftable:
{
    ; $03D365
    .CheckOffset_Y
    dw  6
    dw 24
    dw 12
    dw 12

    ; $03D36D
    .CheckOffset_X
    dw  7
    dw  7
    dw -3
    dw 16

    ; $03D375
    .GloveLevels
    db $00 ; Sign
    db $01 ; Small gray rock
    db $00 ; Bush
    db $00 ; Dark bush
    db $02 ; Small black rock
    db $01 ; Big gray rock
    db $02 ; Big black rock

    ; $03D37C
    .0368ID
    db $02 ; Sign
    db $03 ; Small gray rock
    db $01 ; Bush
    db $04 ; Dark bush
    db $00 ; Small black rock
    db $05 ; Big gray rock
    db $06 ; Big black rock
}

; $03D383-$03D444 LOCAL JUMP LOCATION
Link_HandleLiftables:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    ; Tell me what direction Link is facing and utilize it as an index.
    LDA.b $2F : TAY
    
    ; We're going to form a box based on which to detect a tile type we can
    ; interact with.
    LDA.b $20 : CLC : ADC.w $D365, Y : AND.b $EC : STA.b $00
    
    LDA.b $20 : CLC : ADC.w #$0014 : AND.b $EC : STA.b $04
    
    LDA.b $22 : CLC : ADC.w $D36D, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $22 : CLC : ADC.w #$0008 : AND.b $EC : LSR #3 : STA.b $08
    
    ; The basic idea is that we have a RECT structure with corners $00, $04,
    ; and corners sort of defined by using offsets at $02, $08.
    
    LDA.w #$0001 : STA.b $0A
    
    REP #$10
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $00
    LDA.b $08 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    ; By default, the assumption is that the action button is going to cause us
    ; to dash (There are other actions that have priority above this elsewhere
    ; though).
    LDX.b #$02
    
    LDA.b $0E : ORA.w $036D : AND.b #$01 : BEQ .notNearWall
        ; The action will be grabbing a wall since we're close to one and
        ; hitting the action button.
        LDX.b #$03
    
    .notNearWall
    
    ; Are we indoors?
    LDA.b $1B : BEQ .outdoors
        ; We're indoors, save whatever action we anticipate doing.
        PHX
        
        JSL.l Dungeon_QueryIfTileLiftable : BCC .not_liftable
            PLX
            
            AND.b #$0F : TAY
            
            LDA.w $D37C, Y : STA.w $0368 : TAY
            
            BRA .check_lift_strength
        
        .not_liftable
        
        ; Remind me of the kind of action I was going to take.
        PLX
        
        ; Is a readable tile in our path?
        LDA.w $0366 : AND.b #$01 : BEQ .indoorDontRead
            ; Is link facing north?
            LDA.b $2F : BNE .indoorDontRead
                LDA.w $036A : BNE .indoorDontRead
                    ; Current action is reading something.
                    LDX.b #$04
        
            ; No, so don't read anything.
        .indoorDontRead
        
        BRA .checkIfOpeningChest
    
    .outdoors
    
    ; Is a readable tile in our path?
    LDA.w $0366 : AND.b #$01 : BEQ .checkIfOpeningChest
        LDA.b $2F : BNE .checkIfLiftingObject
            LDA.w $036A : BNE .checkIfLiftingObject
                ; Current action is reading something.
                LDX.b #$04
                
                BRA .checkIfOpeningChest
        
        .checkIfLiftingObject
        
        LDA.w $036A : LSR A : STA.w $0368 : TAY
        
        .check_lift_strength
        
        ; Subtract glove strength.
        LDA.w $D375, Y : SEC : SBC.l $7EF354 : BEQ .strongEnough 
            BPL .checkIfOpeningChest
        
        .strongEnough
        
        ; Current action is picking something up.
        LDX.b #$01
    
    .checkIfOpeningChest
    
    ; Check to see if we're opening a chest.
    LDA.w $02E5 : AND.b #$01 : BEQ .notOpeningChest
        ; Current action is opening a chest.
        LDX.b #$05
    
    .notOpeningChest
    
    RTS
}

; ==============================================================================

; $03D485-$03D555 LOCAL JUMP LOCATION
HandleNudging:
{
    LDA.b $00 : PHA
    
    LDA.b $66 : AND.b #$02 : BNE .BRANCH_ALPHA
        LDX.b #$00
        
        LDA.b $66 : AND.b #$01 : BEQ .BRANCH_BETA
            LDX.b #$04
        
        .BRANCH_BETA
        
        LDY.b #$00
        
        LDA.b $0E : AND.b #$04 : BNE .BRANCH_GAMMA
            LDY.b #$02
        
        .BRANCH_GAMMA
        
        STY.b $00
        
        BRA .BRANCH_DELTA
    
    .BRANCH_ALPHA
    
    LDX.b #$08
    
    LDA.b $66 : AND.b #$01 : BEQ .BRANCH_EPSILON
        LDX.b #$0C
    
    .BRANCH_EPSILON
    
    LDY.b #$00
    
    LDA.b $0E : AND.b #$04 : BNE .BRANCH_ZETA
        LDY.b #$02
    
    .BRANCH_ZETA
    
    STY.b $00
    
    .BRANCH_DELTA
    
    TXA : CLC : ADC.b $00 : TAY
    
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    LDA.b $20 : CLC : ADC.w $D445, Y : AND.b $EC :          STA.b $00
    LDA.b $22 : CLC : ADC.w $D455, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.b $20 : CLC : ADC.w $D465, Y : AND.b $EC :          STA.b $04
    LDA.b $22 : CLC : ADC.w $D475, Y : AND.b $EC : LSR #3 : STA.b $08
    
    LDA.w #$0001 : STA.b $0A
    
    REP #$10
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $00
    LDA.b $08 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$10
    
    PLA : STA.b $00
    
    LDA.b $0E : ORA.w $036E : AND.b #$03 : BNE .BRANCH_THETA
        LDA.w $036D : ORA.w $0370 : AND.b #$33 : BEQ .BRANCH_IOTA
    
    .BRANCH_THETA
    
    LDY.b #$00
    
    LDA.b $00 : EOR.b #$FF : INC A : STA.b $00 : CMP.b #$80 : BCC .BRANCH_KAPPA
        LDY.b #$FF
    
    .BRANCH_KAPPA
    
    STY.b $01
    
    LDA.b $66 : AND.b #$02 : BEQ .BRANCH_LAMBDA
        REP #$20
        
        LDA.b $00 : CLC : ADC.b $20 : STA.b $20
        
        BRA .BRANCH_IOTA
    
    .BRANCH_LAMBDA
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.b $22 : STA.b $22
    
    .BRANCH_IOTA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $03D556-$03D575 DATA
Pool_Hookshot_CheckTileCollision:
{
    .xy_offsets_first
    dw 0, 0
    dw 7, 7
    dw 0, 15
    dw 0, 15
    
    .xy_offsets_second
    dw 0, 15
    dw 0, 15
    dw 0, 0
    dw 8, 8        
}

; ==============================================================================

; $03D576-$03D606 LONG JUMP LOCATION
Hookshot_CheckTileCollison:
{
    PHB : PHK : PLB
    
    LDA.b $A0 : PHA
    LDA.b $EE : PHA
    
    LDA.w $03A4, X : BEQ .BRANCH_ALPHA
        LDA.w $044A : BNE .BRANCH_BETA
            LDA.b $A0 : CLC : ADC.b #$10 : STA.b $A0
        
        .BRANCH_BETA
        
        LDA.b $EE : EOR.b #$01 : STA.b $EE
    
    .BRANCH_ALPHA
    
    LDA.w $0BFA, X : STA.b $04
    LDA.w $0C0E, X : STA.b $05
    
    LDA.w $0C04, X : STA.b $08
    LDA.w $0C18, X : STA.b $09
    
    LDA.w $0C72, X : ASL #2 : STA.b $73
    
    PHX
    
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    SEP #$20
    
    LDA.w $046C : CMP.b #$02 : BNE .single_bg_collision
        LDA.b $04 : PHA
        LDA.b $05 : PHA
        
        LDA.b $08 : PHA
        LDA.b $09 : PHA
        
        LDA.b #$01 : STA.b $EE
        
        REP #$20
        
        LDA.b $E6 : SEC : SBC.b $E8 : CLC : ADC.b $04 : STA.b $04
        LDA.b $E0 : SEC : SBC.b $E2 : CLC : ADC.b $08 : STA.b $08
        
        SEP #$20
        
        JSR.w Hookshot_CheckSingleLayerTileCollision
        
        PLA : STA.b $09
        PLA : STA.b $08
        PLA : STA.b $05
        PLA : STA.b $04
        
        STZ.b $EE
    
    .single_bg_collision
    
    JSR.w Hookshot_CheckSingleLayerTileCollision
    
    PLX
    
    PLA : STA.b $EE
    PLA : STA.b $A0
    
    PLB
    
    RTL
}

; ==============================================================================

; $03D607-$03D656 LOCAL JUMP LOCATION
Hookshot_CheckSingleLayerTileCollision:
{
    REP #$20
    
    LDA.b $73 : TAY
    
    LDA.b $04 : CLC : ADC .xy_offsets_first+0, Y : AND.b $EC : STA.b $00
    LDA.b $04 : CLC : ADC .xy_offsets_first+2, Y : AND.b $EC : STA.b $04
    
    LDA.b $08 : CLC : ADC .xy_offsets_second+0, Y : AND.b $EC : LSR #3 : STA.b $02
    LDA.b $08 : CLC : ADC .xy_offsets_second+2, Y : AND.b $EC : LSR #3 : STA.b $08
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    ; Use the other x, y coordinate pair.
    LDA.b $04 : STA.b $00
    LDA.b $08 : STA.b $02
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03D657-$03D666 DATA
Pool_HandleNudgingInADoor:
{
    ; $03D657
    .offset_y
    dw $0008, $0017, $0010, $0010

    ; $03D65F
    .offset_x
    dw $0008, $0008, $0000, $000F
}

; ==============================================================================

; $03D667-$03D6F3 LONG BRANCH LOCATION
HandleNudgingInADoor:
{
    LDA.b $00 : PHA
    
    LDA.b $66 : AND.b #$02 : BEQ .BRANCH_ALPHA
        LDY.b #$02
        
        LDA.b $20 : CMP.b #$80 : BCC .BRANCH_BETA
            LDY.b #$00
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDY.b #$06
    
    LDA.b $22 : CMP.b #$80 : BCC .BRANCH_BETA
        LDY.b #$04
    
    .BRANCH_BETA
    
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    LDA.b $20 : CLC : ADC.w $D657, Y : AND.b $EC :          STA.b $00
    
    LDA.b $22 : CLC : ADC.w $D65F, Y : AND.b $EC : LSR #3 : STA.b $02
    
    LDA.w #$0001 : STA.b $0A
    
    REP #$10
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    PLA : STA.b $00
    
    LDA.b $0E : ORA.w $036E : AND.b #$03 : BNE .BRANCH_GAMMA
        LDA.w $036D : ORA.w $0370 : AND.b #$33 : BEQ .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    LDY.b #$00
    
    LDA.b $00 : EOR.b #$FF : INC A : STA.b $00
    CMP.b #$80 : BCC .BRANCH_EPSILON
        LDY.b #$FF
    
    .BRANCH_EPSILON
    
    STY.b $01
    
    LDA.b $66 : AND.b #$02 : BEQ .BRANCH_ZETA
        REP #$20
        
        LDA.b $00 : CLC : ADC.b $20 : STA.b $20
        
        BRA .BRANCH_DELTA
    
    .BRANCH_ZETA
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.b $22 : STA.b $22
    
    .BRANCH_DELTA
    
    SEP #$20
    
    RTS
}

; $03D6F4-$03D72D LOCAL JUMP LOCATION
TileCheckForMirrorBonk:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    LDA.b $22 : CLC : ADC.w #$0002 : AND.b $EC : LSR #3 : STA.b $02
    LDA.b $22 : CLC : ADC.w #$000D : AND.b $EC : LSR #3 : STA.b $04
    
    LDA.b $20 : CLC : ADC.w #$000A : AND.b $EC : STA.b $00 : STA.b $74
    LDA.b $20 : CLC : ADC.w #$0015 : AND.b $EC : STA.b $08
    
    BRL TileDetect_FromMirrorBonk
}

; ==============================================================================

; $03D72E-$03D73D DATA
Pool_TileDetect_SwordSwingDeepInDoor:
{
    ; $03D72E
    .offset_y
    dw $FFFF, $0018, $0010, $0010

    ; $03D736
    .offset_x
    dw $0008, $0008, $FFFF, $0010
}

; $03D73E-$03D797 LOCAL JUMP LOCATION
TileDetect_SwordSwingDeepInDoor:
{
    STZ.b $59
    
    REP #$20
    
    JSR.w TileDetect_ResetState
    
    TXA : AND.w #$00FF : DEC A : ASL #2 : TAY
    
    LDA.b $22 : CLC : ADC.w Pool_TileDetect_SwordSwingDeepInDoor_offset_x+0, Y
    AND.b $EC : LSR #3 : STA.b $02

    LDA.b $22 : CLC : ADC.w Pool_TileDetect_SwordSwingDeepInDoor_offset_x+2, Y
    AND.b $EC : LSR #3 : STA.b $04
    
    LDA.b $20 : CLC : ADC.w Pool_TileDetect_SwordSwingDeepInDoor_offset_y+0, Y
    AND.b $EC : STA.b $00

    LDA.b $20 : CLC : ADC.w Pool_TileDetect_SwordSwingDeepInDoor_offset_y+2, Y
    AND.b $EC : STA.b $08
    
    REP #$10
    
    LDA.w #$0001 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    LDA.b $04 : STA.b $02
    LDA.b $08 : STA.b $00
    
    LDA.w #$0002 : STA.b $0A
    
    JSR.w TileDetect_Execute
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $03D798-$03D7D7 LOCAL JUMP LOCATION
TileDetect_ResetState:
{
    STZ.b $0C
    STZ.b $0E
    STZ.b $38
    STZ.b $58
    
    STZ.w $02C0
    
    STZ.b $5F
    STZ.b $62
    
    STZ.w $0320
    STZ.w $0341
    STZ.w $0343
    STZ.w $0348
    STZ.w $034C
    STZ.w $0357
    STZ.w $0359
    STZ.w $035B
    STZ.w $0366
    STZ.w $036D
    STZ.w $036F
    STZ.w $03E5
    STZ.w $03E7
    STZ.w $02EE
    STZ.w $02F6
    STZ.w $03F1
    
    RTS
}

; ==============================================================================

; Dungeon tile attribute handlers
; Parameter: The tile type Link is interacting with. Stored at $06
; $03D7D8-$03D9D7 JUMP TABLE
Pool_TileDetection_Execute_underworld:
{
    dw $DC54 ; $03DC54 0x00 - Do nothing. Normal tile.
    dw $DC50 ; $03DC50 0x01 - Tests and sets bits from $0A into $0E
    dw $DC50 ; $03DC50 0x02 - Tests and sets bits from $0A into $0E
    dw $DC50 ; $03DC50 0x03 - Tests and sets bits from $0A into $0E
    dw $DC50 ; $03DC50 0x04 - Tests and sets bits from $0A into $0E
    dw $DC54 ; $03DC54 0x05 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x06 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x07 - Do nothing. Normal tile.
    
    dw $DC86 ; $03DC86 0x08 - Tests and sets bits from $0A into $58
    dw $DD1B ; $03DD1B 0x09 - Shallow water
    dw $DCBC ; $03DCBC 0x0A - Tests and sets bits from $0A into $0343
    dw $DC50 ; $03DC50 0x0B - Tests and sets bits from $0A into $0E
    dw $DC98 ; $03DC98 0x0C - Tests and sets bits from $0A into $0320
    dw $DDCA ; $03DDCA 0x0D - Tests and sets bits from $0A into $02EE (Spike
             ;                floor)

    dw $DC9E ; $03DC9E 0x0E - Tests and sets bits from $0A into $0348
    dw $DCA4 ; $03DCA4 0x0F - Tests and sets bits from $0A into $0348
    
    dw $DC61 ; $3DC61 0x10 - Tests and sets bits from $0A into $0C
    dw $DC61 ; $3DC61 0x11 - Tests and sets bits from $0A into $0C
    dw $DC61 ; $3DC61 0x12 - Tests and sets bits from $0A into $0C
    dw $DC61 ; $3DC61 0x13 - Tests and sets bits from $0A into $0C
    dw $DC54 ; $3DC54 0x14 - Do nothing. Normal tile.
    dw $DC54 ; $3DC54 0x15 - Do nothing. Normal tile.
    dw $DC54 ; $3DC54 0x16 - Do nothing. Normal tile.
    dw $DC54 ; $3DC54 0x17 - Do nothing. Normal tile.
    
    dw $DC5D ; $03DC5D 0x18 - These are the slanted wall tiles that make you
             ;                move diagonally when you move against them

    dw $DC5D ; $03DC5D 0x19 - Also a slanted wall
    dw $DC5D ; $03DC5D 0x1A - Also a slanted wall
    dw $DC5D ; $03DC5D 0x1B - Also a slanted wall
    dw $DCC2 ; $03DCC2 0x1C - Top of water staircase
    dw $DC72 ; $03DC72 0x1D - These three are related
    dw $DC7D ; $03DC7D 0x1E - Staircases (ladders really)
    dw $DC7D ; $03DC7D 0x1F - 
    
    dw $DC8B ; $03DC8B 0x20 - Hole
    dw $DC54 ; $03DC54 0x21 - Do nothing. Normal tile.
    dw $DC86 ; $03DC86 0x22 - Steps that slow Link down
    dw $DC54 ; $03DC54 0x23 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x24 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x25 - Do nothing. Normal tile.
    dw $DC50 ; $03DC50 0x26 - 
    dw $DDE1 ; $03DDE1 0x27 - Empty chest
    
    dw $DEBB ; $03DEBB 0x28 - Ledge leading up
    dw $DEAD ; $03DEAD 0x29 - Ledge leading down
    dw $DEC5 ; $03DEC5 0x2A - Ledge leading left
    dw $DEC5 ; $03DEC5 0x2B - Ledge leading right
    dw $DECF ; $03DECF 0x2C - Ledge leading up + left
    dw $DEDD ; $03DEDD 0x2D - Ledge leading down + left
    dw $DECF ; $03DECF 0x2E - Ledge leading up + right
    dw $DEDD ; $03DEDD 0x2F - Ledge leading down + right
    
    dw $DC86 ; $03DC86 0x30 - Up Staircase 0
    dw $DC86 ; $03DC86 0x31 - Up Staircase 1
    dw $DC86 ; $03DC86 0x32 - Up Staircase 2
    dw $DC86 ; $03DC86 0x33 - Up Staircase 3
    dw $DC86 ; $03DC86 0x34 - Down Staircase 0
    dw $DC86 ; $03DC86 0x35 - Down Staircase 1
    dw $DC86 ; $03DC86 0x36 - Down Staircase 2
    dw $DC86 ; $03DC86 0x37 - Down Staircase 3
    
    dw $DC54 ; $03DC54 0x38 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x39 - Do nothing. Normal tile. (Straight up south
             ;                staircase)

    dw $DC54 ; $03DC54 0x3A - Do nothing. Normal tile. (Star tile behavior
             ;                handled elsewhere)

    dw $DC54 ; $03DC54 0x3B - Do nothing. Normal tile. (Star tile behavior
             ;                handled elsewhere)

    dw $DC54 ; $03DC54 0x3C - Do nothing. Normal tile. (Unknown if this has
             ;                other behavior)

    dw $DD9D ; $03DD9D 0x3D - (inter floor staircase?)
    dw $DDA1 ; $03DDA1 0x3E - (inter floor staircase?)
    dw $DDA1 ; $03DDA1 0x3F - (inter floor staircase?)
    
    dw $DE61 ; $03DE61 0x40 - Grass tile
    dw $DC54 ; $03DC54 0x41 - 
    dw $DC54 ; $03DC54 0x42 - 
    dw $DC50 ; $03DC50 0x43 - 
    dw $DDB1 ; $03DDB1 0x44 - spike block tile
    dw $DC54 ; $03DC54 0x45 - Do nothing. Normal tile.
    dw $DF11 ; $03DF11 0x46 - ????
    dw $DC54 ; $03DC54 Do nothing. Normal tile.
    
    dw $DE67 ; $03DE67 0x48 - Aftermath tiles?
    dw $DC54 ; $03DC54 0x49 - Do nothing. Normal tile.
    dw $DE67 ; $03DE67 0x4A - Same as 0x48 but this tile type doesn't seem to
             ;                be used in the game anywhere

    dw $DEFF ; $03DEFF 0x4B -  Warp Tile
    dw $DC54 ; $03DC54 0x4C - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x4D - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x4E - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x4F - Do nothing. Normal tile.
    
    dw $DE7E ; $03DE7E 0x50 -
    dw $DE7E ; $03DE7E 0x51 - 
    dw $DE7E ; $03DE7E 0x52 - 
    dw $DE7E ; $03DE7E 0x53 -
    dw $DE7E ; $03DE7E 0x54 -
    dw $DE7E ; $03DE7E 0x55 -
    dw $DE7E ; $03DE7E 0x56 -
    dw $DF19 ; $03DF19 0x57 -
    
    dw $DD6A ; $03DD6A 0x58 - Chest attribute 0
    dw $DD6A ; $03DD6A 0x59 - Chest attribute 1
    dw $DD6A ; $03DD6A 0x5A - Chest attribute 2
    dw $DD6A ; $03DD6A 0x5B - Chest attribute 3
    dw $DD6A ; $03DD6A 0x5C - Chest attribute 4
    dw $DD6A ; $03DD6A 0x5D - Chest attribute 5
    dw $DC54 ; $03DC54 0x5E - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x5F - Do nothing. Normal tile.
    
    dw $DDF7 ; $03DDF7 0x60 - Blue rupees on ground tile
    dw $DC54 ; $03DC54 0x61 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x62 - Do nothing. Normal tile.
    dw $DE45 ; $03DE45 0x63 - Minigame chest
    dw $DC54 ; $03DC54 0x64 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x65 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0x66 - Do nothing. Normal tile.
    dw $DE17 ; $03DE17 0x67 -
    
    dw $DE29 ; $03DE29 0x68 -
    dw $DE2D ; $03DE2D 0x69 -
    dw $DE35 ; $03DE35 0x6A -
    dw $DE3A ; $03DE3A 0x6B -
    dw $DC50 ; $03DC50 0x6C -
    dw $DC50 ; $03DC50 0x6D -
    dw $DC50 ; $03DC50 0x6E -
    dw $DC50 ; $03DC50 0x6F -
    
    dw $DD41 ; $03DD41 0x70 - Pot attribute 0
    dw $DD41 ; $03DD41 0x71 - Pot attribute 1
    dw $DD41 ; $03DD41 0x72 - Pot attribute 2
    dw $DD41 ; $03DD41 0x73 - Pot attribute 3
    dw $DD41 ; $03DD41 0x74 - Pot attribute 4
    dw $DD41 ; $03DD41 0x75 - Pot attribute 5
    dw $DD41 ; $03DD41 0x76 - Pot attribute 6
    dw $DD41 ; $03DD41 0x77 - Pot attribute 7
    
    dw $DD41 ; $03DD41 0x78 - Pot attribute 8
    dw $DD41 ; $03DD41 0x79 - Pot attribute 9
    dw $DD41 ; $03DD41 0x7A - Pot attribute A
    dw $DD41 ; $03DD41 0x7B - Pot attribute B
    dw $DD41 ; $03DD41 0x7C - Pot attribute C
    dw $DD41 ; $03DD41 0x7D - Pot attribute D
    dw $DD41 ; $03DD41 0x7E - Pot attribute E
    dw $DD41 ; $03DD41 0x7F - Pot attribute F
    
    dw $DD0A ; $03DD0A 0x80 -
    dw $DD0A ; $03DD0A 0x81 -
    dw $DCEA ; $03DCEA 0x82 -
    dw $DCEA ; $03DCEA 0x83 -
    dw $DD0A ; $03DD0A 0x84 -
    dw $DD0A ; $03DD0A 0x85 -
    dw $DD0A ; $03DD0A 0x86 -
    dw $DD0A ; $03DD0A 0x87 -
    
    dw $DD0A ; $03DD0A 0x88 -
    dw $DD0A ; $03DD0A 0x89 - Room link door
    dw $DD0A ; $03DD0A 0x8A -
    dw $DD0A ; $03DD0A 0x8B -
    dw $DD0A ; $03DD0A 0x8C -
    dw $DD0A ; $03DD0A 0x8D -
    dw $DE4F ; $03DE4F 0x8E - Overworld link door
    dw $DE4F ; $03DE4F 0x8F -
    
    dw $DCC8 ; $03DCC8 0x90 -
    dw $DCC8 ; $03DCC8 0x91 -
    dw $DCC8 ; $03DCC8 0x92 -
    dw $DCC8 ; $03DCC8 0x93 -
    dw $DCC8 ; $03DCC8 0x94 -
    dw $DCC8 ; $03DCC8 0x95 -
    dw $DCC8 ; $03DCC8 0x96 -
    dw $DCC8 ; $03DCC8 0x97 -
    
    dw $DCD4 ; $03DCD4 0x98 -
    dw $DCD4 ; $03DCD4 0x99 -
    dw $DCD4 ; $03DCD4 0x9A -
    dw $DCD4 ; $03DCD4 0x9B -
    dw $DCD4 ; $03DCD4 0x9C -
    dw $DCD4 ; $03DCD4 0x9D -
    dw $DCD4 ; $03DCD4 0x9E -
    dw $DCD4 ; $03DCD4 0x9F -
    
    dw $DD00 ; $03DD00 0xA0 - Used in the sewer / HC transition
    dw $DD00 ; $03DD00 0xA1 -
    dw $DCE0 ; $03DCE0 0xA2 -
    dw $DCE0 ; $03DCE0 0xA3 -
    dw $DD00 ; $03DD00 0xA4 -
    dw $DD00 ; $03DD00 0xA5 -
    dw $DC54 ; $03DC54 0xA6 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xA7 - Do nothing. Normal tile.
    
    dw $DCD4 ; $03DCD4 0xA8 - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xA9 - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAA - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAB - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAC - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAD - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAE - Do nothing. Normal tile.
    dw $DCD4 ; $03DCD4 0xAF - Do nothing. Normal tile.
    
    dw $DC8B ; $03DC8B 0xB0 - Hole tile (same as 0x20 but not sure of other
             ;                differences)

    dw $DC8B ; $03DC8B 0xB1 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB2 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB3 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB4 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB5 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB6 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB7 - Hole AI ''
    
    dw $DC8B ; $03DC8B 0xB8 - Hole AI ''
    dw $DC8B ; $03DC8B 0xB9 - Hole AI ''
    dw $DC8B ; $03DC8B 0xBA - Hole AI ''
    dw $DC8B ; $03DC8B 0xBB - Hole AI ''
    dw $DC8B ; $03DC8B 0xBC - Hole AI ''
    dw $DC8B ; $03DC8B 0xBD - Hole AI ''
    dw $DC54 ; $03DC54 0xBE - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xBF - Do nothing. Normal tile.
    
    dw $DCAE ; $03DCAE 0xC0 - Torch
    dw $DCAE ; $03DCAE 0xC1 - Torch
    dw $DCAE ; $03DCAE 0xC2 - Torch
    dw $DCAE ; $03DCAE 0xC3 - Torch
    dw $DCAE ; $03DCAE 0xC4 - Torch
    dw $DCAE ; $03DCAE 0xC5 - Torch
    dw $DCAE ; $03DCAE 0xC6 - Torch
    dw $DCAE ; $03DCAE 0xC7 - Torch
    
    dw $DCAE ; $03DCAE 0xC8 - Torch
    dw $DCAE ; $03DCAE 0xC9 - Torch
    dw $DCAE ; $03DCAE 0xCA - Torch
    dw $DCAE ; $03DCAE 0xCB - Torch
    dw $DCAE ; $03DCAE 0xCC - Torch
    dw $DCAE ; $03DCAE 0xCD - Torch
    dw $DCAE ; $03DCAE 0xCE - Torch
    dw $DCAE ; $03DCAE 0xCF - Torch
    
    dw $DC54 ; $03DC54 0xD0 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD1 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD2 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD3 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD4 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD5 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD6 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD7 - Do nothing. Normal tile.
    
    dw $DC54 ; $03DC54 0xD8 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xD9 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDA - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDB - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDC - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDD - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDE - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xDF - Do nothing. Normal tile.
    
    dw $DC54 ; $03DC54 0xE0 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE1 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE2 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE3 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE4 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE5 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE6 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE7 - Do nothing. Normal tile.
    
    dw $DC54 ; $03DC54 0xE8 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xE9 - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xEA - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xEB - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xEC - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xED - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xEE - Do nothing. Normal tile.
    dw $DC54 ; $03DC54 0xEF - Do nothing. Normal tile.
    
    dw $DDEB ; $03DDEB 0xF0 - Key Door 1
    dw $DDEB ; $03DDEB 0xF1 - Key Door 2
    dw $DDEB ; $03DDEB 0xF2 - ....
    dw $DDEB ; $03DDEB 0xF3 - 
    dw $DDEB ; $03DDEB 0xF4 - 
    dw $DDEB ; $03DDEB 0xF5 - 
    dw $DDEB ; $03DDEB 0xF6 - 
    dw $DDEB ; $03DDEB 0xF7 - 
    
    dw $DDEB ; $03DDEB 0xF8 -
    dw $DDEB ; $03DDEB 0xF9 -
    dw $DDEB ; $03DDEB 0xFA -
    dw $DDEB ; $03DDEB 0xFB -
    dw $DDEB ; $03DDEB 0xFC -
    dw $DDEB ; $03DDEB 0xFD -
    dw $DDEB ; $03DDEB 0xFE -
    dw $DDEB ; $03DDEB 0xFF -
}

; ==============================================================================

; Tile attribute handler
; Has $0A as a hidden argument.
; $03D9D8-$03DA29 LOCAL JUMP LOCATION
TileDetect_Execute:
{
    SEP #$30
    
    ; Are we indoors?
    LDA.b $1B : BNE .indoors
        ; Jump to routine that handles outdoor tile behaviors.
        BRL TileDetection_Execute_overworld
    
    .indoors
    
    ; Handle dungeon tile attributes.
    ; Some quick notes:
    ; $06[1] Is the tile type (no, not the tile type multiplied by two)
    ; $0A[2] Seems to be either 1, 2, 4, or 8. This is basically the tile's
    ;        position relative to Link.
    
    REP #$20
    
    ; It's Link's movement impetus (it makes him move in a given direction each
    ; frame).
    LDA.b $49 : AND.w #$00FF : STA.b $49
    
    LDA.b $00 : AND.w #$FFF8 : ASL #3 : STA.b $06
    
    LDA.b $02 : AND.w #$003F : CLC : ADC.b $06
    
    ; Which part of a two level room is Link on.
    LDX.b $EE : BEQ .lowerFloor
        ; He's on the upper floor then.
        ; Add this offset in because BG0's tile attributes start at $7F3000.
        CLC : ADC.w #$1000
    
    .lowerFloor
    
    REP #$10
    
    TAX
    
    ; Are we figuring out what sort of tile this is.
    LDA.l $7F2000, X : PHA
    
    LDA.w $037F : AND.w #$00FF : BEQ .playinByTheRules
        ; $037F being nonzero is a sort of a hidden cheat code.
        PLA
        
        LDA.w #$0000
        
        BRA .walkThroughWallsCode
    
    .playinByTheRules
    
    ; Okay back to what kind of tile it was...
    PLA
    
    .walkThroughWallsCode
    
    ; Store the tile type at $06 and mirror it at $0114.
    AND.w #$00FF : STA.b $06 : STA.w $0114
    
    ; Save the offset for the tile (i.e. its position in $7F2000).
    STX.b $BD
    
    ; Multiply this tile index by two and use it to run a service routine for.
    ; that kind of tile.
    ASL A : TAX
    
    JMP ($D7D8, X) ; ($3D7D8, X) THAT IS
}

; ==============================================================================

; Overworld Tile Attribute Jump Table
; $03DA2A-$03DC29 JUMP TABLE
Pool_TileDetection_Execute_overworld:
{
    dw $DE5B ; $03DE5B 0x00 - Normal tile (no interaction)
    dw $DC50 ; $03DC50 0x01 - Blocked
    dw $DC50 ; $03DC50 0x02 - Blocked
    dw $DC50 ; $03DC50 0x03 - Blocked
    dw $DC61 ; $03DC61 0x04 - ????
    dw $DE5B ; $03DE5B 0x05 - Normal tile (no interaction)
    dw $DE5B ; $03DE5B 0x06 - Normal tile
    dw $DE5B ; $03DE5B 0x07 - 
    
    dw $DCB6 ; $03DCB6 0x08 - Deep water
    dw $DD1B ; $03DD1B 0x09 - Shallow water
    dw $DCBC ; $03DCBC 0x0A -
    dw $DD5C ; $03DD5C 0x0B - ????
    dw $DC98 ; $03DC98 0x0C - Moving floor (e.g. Mothula's room and the one in
             ;                the Ice Palace)

    dw $DDCA ; $03DDCA 0x0D - Spike floors, not sure if any exist in Overworld
             ;                (Didn't Parallel Worlds do this with Lava?)

    dw $DC9E ; $03DC9E 0x0E - 
    dw $DCA4 ; $03DCA4 0x0F - 
    
    dw $DC61 ; $03DC61 0x10 - 
    dw $DC61 ; $03DC61 0x11 - 
    dw $DC61 ; $03DC61 0x12 - 
    dw $DC61 ; $03DC61 0x13 - 
    dw $DE5B ; $03DE5B 0x14 - 
    dw $DE5B ; $03DE5B 0x15 - 
    dw $DE5B ; $03DE5B 0x16 - 
    dw $DE5B ; $03DE5B 0x17 - 
    
    dw $DC5D ; $03DC5D 0x18 - 
    dw $DC5D ; $03DC5D 0x19 - 
    dw $DC5D ; $03DC5D 0x1A - 
    dw $DC5D ; $03DC5D 0x1B - 
    dw $DCC2 ; $03DCC2 0x1C - Top of in room staircase
    dw $DC72 ; $03DC72 0x1D -
    dw $DC7D ; $03DC7D 0x1E -
    dw $DC7D ; $03DC7D 0x1F -
    
    dw $DC8B ; $03DC8B 0x20 - Hole tile
    dw $DE5B ; $03DE5B 0x21 -
    dw $DC86 ; $03DC86 0x22 - Wooden steps (slow you down)
    dw $DE5B ; $03DE5B 0x23 -
    dw $DE5B ; $03DE5B 0x24 -
    dw $DE5B ; $03DE5B 0x25 -
    dw $DC50 ; $03DC50 0x26 -
    dw $DDE1 ; $03DDE1 0x27 - (empty chest and maybe others)

    dw $DEBB ; $03DEBB 0x28 - Ledge leading up
    dw $DEAD ; $03DEAD 0x29 - Ledge leading down
    dw $DEC5 ; $03DEC5 0x2A - Ledge leading left
    dw $DEC5 ; $03DEC5 0x2B - Ledge leading right
    dw $DECF ; $03DECF 0x2C - Ledge leading up + left
    dw $DEDD ; $03DEDD 0x2D - Ledge leading down + left
    dw $DECF ; $03DECF 0x2E - Ledge leading up + right
    dw $DEDD ; $03DEDD 0x2F - Ledge leading down + right
                          
    dw $DC86 ; $03DC86 0x30 -
    dw $DC86 ; $03DC86 0x31 -
    dw $DC86 ; $03DC86 0x32 -
    dw $DC86 ; $03DC86 0x33 -
    dw $DC86 ; $03DC86 0x34 -
    dw $DC86 ; $03DC86 0x35 -
    dw $DC86 ; $03DC86 0x36 -
    dw $DC86 ; $03DC86 0x37 -
    
    dw $DE5B ; $03DE5B 0x38 - 
    dw $DE5B ; $03DE5B 0x39 -
    dw $DE5B ; $03DE5B 0x3A -
    dw $DE5B ; $03DE5B 0x3B -
    dw $DE5B ; $03DE5B 0x3C -
    dw $DD9D ; $03DD9D 0x3D -
    dw $DDA1 ; $03DDA1 0x3E -
    dw $DDA1 ; $03DDA1 0x3F -
    
    dw $DE61 ; $03DE61 0x40 - Grass tile
    dw $DE5B ; $03DE5B 0x41 -
    dw $DF09 ; $03DF09 0x42 - ????
    dw $DC50 ; $03DC50 0x43 -
    dw $DDB1 ; $03DDB1 0x44 - Cactus tile
    dw $DE5B ; $03DE5B 0x45 -
    dw $DF11 ; $03DF11 0x46 - ????
    dw $DE5B ; $03DE5B 0x47 -
    
    dw $DE67 ; $03DE67 0x48 - aftermath tiles of picking things up?
    dw $DE5B ; $03DE5B 0x49 -
    dw $DE67 ; $03DE67 0x4A - Same as 0x48 but this tile type doesn't seem to
             ;                be used in the game anywhere

    dw $DEFF ; $03DEFF 0x4B - Warp tile
    dw $DEE7 ; $03DEE7 0x4C - Unused, but would probably be for special
             ;                mountain tiles too

    dw $DEE7 ; $03DEE7 0x4D - Unused, but would probably be for special
             ;                mountain tiles too

    dw $DEF1 ; $03DEF1 0x4E - Certain mountain tiles
    dw $DEF1 ; $03DEF1 0x4F - Certain mountain tiles
    
    dw $DE7E ; $03DE7E 0x50 - bush
    dw $DE7E ; $03DE7E 0x51 - off color bush
    dw $DE7E ; $03DE7E 0x52 - small light rock
    dw $DE7E ; $03DE7E 0x53 - small heavy rock
    dw $DE7E ; $03DE7E 0x54 - sign
    dw $DE7E ; $03DE7E 0x55 - large light rock
    dw $DE7E ; $03DE7E 0x56 - large heavy rock
    dw $DF19 ; $03DF19 0x57 -
    
    dw $DD6A ; $03DD6A 0x58 - Chest block
    dw $DD6A ; $03DD6A 0x59 - Chest block
    dw $DD6A ; $03DD6A 0x5A - Chest block
    dw $DD6A ; $03DD6A 0x5B - Chest block
    dw $DD6A ; $03DD6A 0x5C - Chest block
    dw $DD6A ; $03DD6A 0x5D - Chest block
    dw $DE5B ; $03DE5B 0x5E -
    dw $DE5B ; $03DE5B 0x5F -
    
    dw $DE5B ; $03DE5B 0x60 -
    dw $DE5B ; $03DE5B 0x61 -
    dw $DE5B ; $03DE5B 0x62 -
    dw $DE45 ; $03DE45 0x63 - Minigame chest tile
    dw $DE5B ; $03DE5B 0x64
    dw $DE5B ; $03DE5B 0x65
    dw $DE5B ; $03DE5B 0x66
    dw $DE17 ; $03DE17 0x67
    
    dw $DE29 ; $03DE29 0x68 -
    dw $DE2D ; $03DE2D 0x69 -
    dw $DE35 ; $03DE35 0x6A -
    dw $DE3A ; $03DE3A 0x6B -
    dw $DE5B ; $03DE5B 0x6C -
    dw $DE5B ; $03DE5B 0x6D -
    dw $DE5B ; $03DE5B 0x6E -
    dw $DE5B ; $03DE5B 0x6F -
    
    dw $DD41 ; $03DD41 0x70 -
    dw $DD41 ; $03DD41 0x71 -
    dw $DD41 ; $03DD41 0x72 -
    dw $DD41 ; $03DD41 0x73 -
    dw $DD41 ; $03DD41 0x74 -
    dw $DD41 ; $03DD41 0x75 -
    dw $DD41 ; $03DD41 0x76 -
    dw $DD41 ; $03DD41 0x77 -
    
    dw $DD41 ; $03DD41 0x78 -
    dw $DD41 ; $03DD41 0x79 -
    dw $DD41 ; $03DD41 0x7A -
    dw $DD41 ; $03DD41 0x7B -
    dw $DD41 ; $03DD41 0x7C -
    dw $DD41 ; $03DD41 0x7D -
    dw $DD41 ; $03DD41 0x7E -
    dw $DD41 ; $03DD41 0x7F -
    
    dw $DD0A ; $03DD0A 0x80 -
    dw $DD0A ; $03DD0A 0x81 -
    dw $DCEA ; $03DCEA 0x82 -
    dw $DCEA ; $03DCEA 0x83 -
    dw $DD0A ; $03DD0A 0x84 -
    dw $DD0A ; $03DD0A 0x85 -
    dw $DD0A ; $03DD0A 0x86 -
    dw $DD0A ; $03DD0A 0x87 -
    
    dw $DD0A ; $03DD0A 0x88 -
    dw $DD0A ; $03DD0A 0x89 -
    dw $DD0A ; $03DD0A 0x8A -
    dw $DD0A ; $03DD0A 0x8B -
    dw $DD0A ; $03DD0A 0x8C -
    dw $DD0A ; $03DD0A 0x8D -
    dw $DE4F ; $03DE4F 0x8E -
    dw $DE4F ; $03DE4F 0x8F -

    dw $DCC8 ; $03DCC8 0x90 -
    dw $DCC8 ; $03DCC8 0x91 -
    dw $DCC8 ; $03DCC8 0x92 -
    dw $DCC8 ; $03DCC8 0x93 -
    dw $DCC8 ; $03DCC8 0x94 -
    dw $DCC8 ; $03DCC8 0x95 -
    dw $DCC8 ; $03DCC8 0x96 -
    dw $DCC8 ; $03DCC8 0x97 -
    
    dw $DCD4 ; $03DCD4 0x98 -
    dw $DCD4 ; $03DCD4 0x99 -
    dw $DCD4 ; $03DCD4 0x9A -
    dw $DCD4 ; $03DCD4 0x9B -
    dw $DCD4 ; $03DCD4 0x9C -
    dw $DCD4 ; $03DCD4 0x9D -
    dw $DCD4 ; $03DCD4 0x9E -
    dw $DCD4 ; $03DCD4 0x9F -
    
    dw $DD00 ; $03DD00 0xA0 -
    dw $DD00 ; $03DD00 0xA1 -
    dw $DCE0 ; $03DCE0 0xA2 -
    dw $DCE0 ; $03DCE0 0xA3 -
    dw $DD00 ; $03DD00 0xA4 -
    dw $DD00 ; $03DD00 0xA5 -
    dw $DE5B ; $03DE5B 0xA6 -
    dw $DE5B ; $03DE5B 0xA7 -
    
    dw $DCD4 ; $03DCD4 0xA8 -
    dw $DCD4 ; $03DCD4 0xA9 -
    dw $DCD4 ; $03DCD4 0xAA -
    dw $DCD4 ; $03DCD4 0xAB -
    dw $DCD4 ; $03DCD4 0xAC -
    dw $DCD4 ; $03DCD4 0xAD -
    dw $DCD4 ; $03DCD4 0xAE -
    dw $DCD4 ; $03DCD4 0xAF -
    
    dw $DC8B ; $03DC8B 0xB0 - hole tile (somaria transit line, more likely
             ;                though)

    dw $DC8B ; $03DC8B 0xB1 - 
    dw $DC8B ; $03DC8B 0xB2 - 
    dw $DC8B ; $03DC8B 0xB3 - 
    dw $DC8B ; $03DC8B 0xB4 - 
    dw $DC8B ; $03DC8B 0xB5 - 
    dw $DC8B ; $03DC8B 0xB6 - 
    dw $DC8B ; $03DC8B 0xB7 - 
    
    dw $DC8B ; $03DC8B 0xB8 -
    dw $DC8B ; $03DC8B 0xB9 -
    dw $DC8B ; $03DC8B 0xBA -
    dw $DC8B ; $03DC8B 0xBB -
    dw $DC8B ; $03DC8B 0xBC -
    dw $DC8B ; $03DC8B 0xBD -
    dw $DE5B ; $03DE5B 0xBE -
    dw $DE5B ; $03DE5B 0xBF -
    
    dw $DCAE ; $03DCAE 0xC0 - Torch
    dw $DCAE ; $03DCAE 0xC1 - Torch
    dw $DCAE ; $03DCAE 0xC2 - Torch
    dw $DCAE ; $03DCAE 0xC3 - Torch
    dw $DCAE ; $03DCAE 0xC4 - Torch
    dw $DCAE ; $03DCAE 0xC5 - Torch
    dw $DCAE ; $03DCAE 0xC6 - Torch
    dw $DCAE ; $03DCAE 0xC7 - Torch
    
    dw $DCAE ; $03DCAE 0xC8 - Torch
    dw $DCAE ; $03DCAE 0xC9 - Torch
    dw $DCAE ; $03DCAE 0xCA - Torch
    dw $DCAE ; $03DCAE 0xCB - Torch
    dw $DCAE ; $03DCAE 0xCC - Torch
    dw $DCAE ; $03DCAE 0xCD - Torch
    dw $DCAE ; $03DCAE 0xCE - Torch
    dw $DCAE ; $03DCAE 0xCF - Torch
    
    dw $DE5B ; $03DE5B 0xD0 -
    dw $DE5B ; $03DE5B 0xD1 -
    dw $DE5B ; $03DE5B 0xD2 -
    dw $DE5B ; $03DE5B 0xD3 -
    dw $DE5B ; $03DE5B 0xD4 -
    dw $DE5B ; $03DE5B 0xD5 -
    dw $DE5B ; $03DE5B 0xD6 -
    dw $DE5B ; $03DE5B 0xD7 -
    
    dw $DE5B ; $03DE5B 0xD8 -
    dw $DE5B ; $03DE5B 0xD9 -
    dw $DE5B ; $03DE5B 0xDA -
    dw $DE5B ; $03DE5B 0xDB -
    dw $DE5B ; $03DE5B 0xDC -
    dw $DE5B ; $03DE5B 0xDD -
    dw $DE5B ; $03DE5B 0xDE -
    dw $DE5B ; $03DE5B 0xDF -
    
    dw $DE5B ; $03DE5B 0xE0 -
    dw $DE5B ; $03DE5B 0xE1 -
    dw $DE5B ; $03DE5B 0xE2 -
    dw $DE5B ; $03DE5B 0xE3 -
    dw $DE5B ; $03DE5B 0xE4 -
    dw $DE5B ; $03DE5B 0xE5 -
    dw $DE5B ; $03DE5B 0xE6 -
    dw $DE5B ; $03DE5B 0xE7 -
    
    dw $DE5B ; $03DE5B 0xE8 -
    dw $DE5B ; $03DE5B 0xE9 -
    dw $DE5B ; $03DE5B 0xEA -
    dw $DE5B ; $03DE5B 0xEB -
    dw $DE5B ; $03DE5B 0xEC -
    dw $DE5B ; $03DE5B 0xED -
    dw $DE5B ; $03DE5B 0xEE -
    dw $DE5B ; $03DE5B 0xEF -
    
    dw $DDEB ; $03DDEB 0xF0 - Key door 1
    dw $DDEB ; $03DDEB 0xF1 - Key door 2
    dw $DDEB ; $03DDEB 0xF2 -
    dw $DDEB ; $03DDEB 0xF3 -
    dw $DDEB ; $03DDEB 0xF4 -
    dw $DDEB ; $03DDEB 0xF5 -
    dw $DDEB ; $03DDEB 0xF6 -
    dw $DDEB ; $03DDEB 0xF7 -
    
    dw $DDEB ; $03DDEB 0xF8 -
    dw $DDEB ; $03DDEB 0xF9 -
    dw $DDEB ; $03DDEB 0xFA -
    dw $DDEB ; $03DDEB 0xFB -
    dw $DDEB ; $03DDEB 0xFC -
    dw $DDEB ; $03DDEB 0xFD -
    dw $DDEB ; $03DDEB 0xFE -
    dw $DDEB ; $03DDEB 0xFF -
}

; $03DC2A-$03DC49 LONG BRANCH LOCATION
TileDetection_Execute_overworld:
{
    JSL.l Overworld_GetTileAttrAtLocation
    
    .do8x8TileInteraction
    
    REP #$30
    
    PHA
    
    LDA.w $037F : AND.w #$00FF : BEQ .playinByTheRules
    
        PLA : LDA.w #$0000
        
        BRA .walkThroughWallsCode
    
    .playinByTheRules
    
    PLA
    
    .walkThroughWallsCode
    
    AND.w #$00FF : STA.b $06 : ASL A : TAX
    
    JMP ($DA2A, X) ; ($3DA2A, X) THAT IS
}

; $03DC4A-$03DC4F LOCAL JUMP LOCATION
TileBehavior_HandleItemAndExecute:
{
    JSL.l Overworld_Map16_ToolInteraction
    
    BRA TileDetection_Execute_overworld_do8x8TileInteraction
}

; $03DC50-$03DC53 LOCAL JUMP LOCATION
TileBehavior_StandardCollision:
{
    ; $0E is the collision bitfield.
    LDA.b $0A : TSB.b $0E

    ; Bleed into the next function.
}

; $03DC54-$03DC54 LOCAL JUMP LOCATION
TileBehavior_Nothing:
{
    RTS
}

; $03DC55-$03DC5C DATA
TileBehavior_Slope_masks:
{
    dw $0004 ; 00000100
    dw $0000 ; 00000000
    dw $0006 ; 00000110
    dw $0002 ; 00000010
}

; $03DC5D-$03DC60 LOCAL JUMP LOCATION
TileBehavior_SlopeOuter:
{
    LDA.b $0A : TSB.b $38

    ; Bleeds into the next function.
}

; $03DC61-$03DC71 ALTERNATE ENTRY POINT
TileBehavior_Slope:
{
    LDA.b $0A : TSB.b $0C
    
    LDA.b $06 : AND.w #$0003 : ASL A : TAY
    
    LDA.w $DC55, Y : STA.b $6E
    
    RTS
}

; $03DC72-$03DC7C LOCAL JUMP LOCATION
TileBehavior_NorthSingleLayerStairs:
{
    ; Notice how in actuality this routine is identical to the following one.
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $02C0
    
    BRA TileBehavior_ManualStairs
}

; $03DC7D-$03DC85 LOCAL JUMP LOCATION
TileBehavior_NorthSwapLayerStairs:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $02C0

    ; Bleeds into the next function.
}

; $03DC86-$03DC8A LOCAL JUMP LOCATION
TileBehavior_ManualStairs:
{
    LDA.b $0A : TSB.b $58
    
    RTS
}

; Hole tile or Somaria platform transit line tile
; $03DC8B-$03DC97 JUMP LOCATION
TileBehavior_Pit:
{
    ; I think this is saying that if Link's on a Somaria platform, we won't
    ; treat it as something he can fall into.
    LDA.w $02F5 : AND.w #$00FF : BNE .cant_fall_into_pits
        LDA.b $04 : TSB.b $59
    
    .cant_fall_into_pits
    
    RTS
}

; $03DC98-$03DC9D JUMP LOCATION
TileBehavior_OverlayMask_0C:
{
    LDA.b $0A : TSB.w $0320
    
    RTS
}

; $03DC9E-$03DCA3 JUMP LOCATION
TileBehavior_GanonIce:
{
    LDA.b $0A : TSB.w $0348
    
    RTS
}

; $03DCA4-$03DCAD JUMP LOCATION
TileBehavior_PalaceIce:
{
    LDA.b $0A : ASL #4 : TSB.w $0348
    
    RTS
}

; Torch tiles
; $03DCAE-$03DCB5 JUMP LOCATION
TileBehavior_LightableTorch:
{
    LDA.b $0A : TSB.b $0E : TSB.w $02F6
    
    RTS
}

; $03DCB6-$03DCBB JUMP LOCATION
TileBehavior_DeepWater:
{
    LDA.b $0A : TSB.w $0341
    
    RTS
}

; $03DCBC-$03DCC1 JUMP LOCATION
TileBehavior_ShortWaterLadder:
{
    LDA.b $0A : TSB.w $0343
    
    RTS
}

; Water staircase tile
; $03DCC2-$03DCC7 JUMP LOCATION
TileBehavior_OverlayMask_1C:
{
    LDA.b $0A : TSB.w $034C
    
    RTS
}

; BG change
; $03DCC8-$03DCD3 LOCAL JUMP LOCATION
TileBehavior_LayerToggleShutterDoor:
{
    LDA.b $EF : AND.w #$FF00 : ORA.w #$0001 : STA.b $EF
    
    BRA TileBehavior_ShutterDoor
}    

; BG change and dungeon change (sewer/Hyrule Castle)
; $03DCD4-$03DCDF LOCAL JUMP LOCATION
TileBehavior_LayerAndDungeonToggleShutterDoor:
{
    LDA.b $EF : AND.w #$FF00 : ORA #$0003 : STA.b $EF
    
    BRA TileBehavior_ShutterDoor
}

; Dungeon change
; $03DCE0-$03DCE9 LOCAL JUMP LOCATION
TileBehavior_DungeonToggleShutterDoor:
{
    LDA.b $EF : AND.w #$FF00 : ORA.w #$0002 : STA.b $EF

    ; Bleeds into the next function.
}

; $03DCEA-$03DCFF LOCAL JUMP LOCATION
TileBehavior_ShutterDoor:
{
    LDA.b $0A : ASL #4 : TSB.b $0E
    
    LDA.b $0A : XBA : TSB.b $0E
    
    LDA.b $06 : AND.w #$0001 : ASL A : STA.b $62
    
    RTS
}

; $03DD00-$03DD1A JUMP LOCATION
TileBehavior_DungeonToggleManualDoor:
{
    LDA.b $EF : AND.w #$FF00 : ORA.w #$0002 : STA.b $EF

    ; Bleeds into the next function.
}
    
; $03DD0A ALTERNATE ENTRY POINT
TileBehavior_Door:
{
    LDA.b $0A : ASL #4 : TSB.b $0E
    
    LDA.b $06 : AND.w #$0001 : ASL A : STA.b $62
    
    RTS
}

; Shallow water tile
; $03DD1B-$03DD20 JUMP LOCATION
TileBehavior_ShallowWater:
{
    LDA.b $0A : TSB.w $0359
    
    RTS
}

; ==============================================================================

; $03DD21-$03DD40 DATA
Pool_TileBehavior_ManipulablyReplaced:
{
    .bitmask
    dw $0001 ; 0000000000000001
    dw $0002 ; 0000000000000010
    dw $0004 ; 0000000000000100
    dw $0008 ; 0000000000001000
    dw $0010 ; 0000000000010000
    dw $0020 ; 0000000000100000
    dw $0040 ; 0000000001000000
    dw $0080 ; 0000000010000000
    dw $0100 ; 0000000100000000
    dw $0200 ; 0000001000000000
    dw $0400 ; 0000010000000000
    dw $0800 ; 0000100000000000
    dw $1000 ; 0001000000000000
    dw $2000 ; 0010000000000000
    dw $4000 ; 0100000000000000
    dw $8000 ; 1000000000000000
}

; ==============================================================================

; $03DD41-$03DD5B JUMP LOCATION
TileBehavior_ManipulablyReplaced:
{
    LDA.b $0A : AND.w #$0002 : BEQ .BRANCH_ALPHA
        LDA.b $06 : AND.w #$000F : ASL A : TAY
        
        LDA.w $DD21, Y : TSB.b $5F
    
    .BRANCH_ALPHA
    
    LDA.b $0A : TSB.b $0E
    
    JSR.w $DDE5 ; $03DDE5 IN ROM
    
    RTS
}

; ==============================================================================

; $03DD5C-$03DD69 JUMP LOCATION
TileBehavior_UnusedDeepWater:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : ASL #4 : TSB.w $0341
    
    RTS
}

; ==============================================================================

; Handler for chest tiles
; $03DD6A-$03DD9C JUMP LOCATION
TileBehavior_Chest:
{
    JSR.w $DDE5 ; $03DDE5 IN ROM; TSB to $02F6
    
    ; Store the tile type we're handling to $76.
    LDA.b $06 : STA.b $76
    
    ; Chest tile values range from 0x58 - 0x5D, so tell me which chest in the
    ; room it is.
    SEC : SBC.w #$0058 : ASL A : TAX
    
    ; Load from a listing of in room chest addresses.
    ; If top bit not set, then branch.
    LDA.w $06E0, X : CMP.w #$8000 : BCC .notBigKeyLock
        LDA.b $0A : TSB.b $0E
        
        ASL #4 : TSB.w $02E7
        
        AND.w #$0020 : BEQ .notCenteredTouch
            ; Store the tile type here
            LDA.b $06 : STA.w $02EA
        
        .notCenteredTouch
        
        RTS
        
    ; $03DD95 ALTERNATE ENTRY POINT
    .notBigKeyLock
    
    ; Since it's not a big key lock, it must be a chest or big chest.
    LDA.b $0A : TSB.w $02E5 : TSB.b $0E
    
    RTS
}

; $03DD9D-$03DDA0 LOCAL JUMP LOCATION
TileBehavior_SouthSingleLayerStairs:
{
    LDA.b $06
    
    BRA TileBehavior_SouthAutoStairs
}
    
; $03DDA1-$03DDA2 LOCAL JUMP LOCATION
TileBehavior_SouthSwapLayerStairs:
{
    LDA.b $06

    ; Bleeds into the next function.
}

; $03DDA3-$03DDB0 LOCAL JUMP LOCATION
TileBehavior_SouthAutoStairs:
{
    STA.b $76
    
    LDA.b $0A : TSB.b $58
    
    ASL #4 : TSB.w $02C0
    
    RTS
}

; Spike / cactus tile handler
; $03DDB1-$03DDC9 LOCAL JUMP LOCATION
TileBehavior_Spike:
{
    ; (invincible because he just beat a boss):
    LDA.w $0FFC : BNE .linkInvincible
        LDA.w $0403 : AND.w #$0080 : BEQ .didntGrabHeartContainer
    
    .linkInvincible
    
    LDA.b $0A : TSB.b $0E
    
    RTS
    
    .didntGrabHeartContainer
    
    LDA.b $0A : XBA : TSB.w $02E7
    
    RTS
}

; $03DDCA-$03DDE0 LOCAL JUMP LOCATION
TileBehavior_SpikeFloor:
{
    ; The invincibility mentioned in this routine occurs after beating a boss
    ; fight, not by using some item or anything like that.
    
    LDA.w $0FFC : BNE .Invincible
        LDA.w $0403 : AND.w #$0080 : BNE .invincible
            LDA.b $0A : ASL #4 : TSB.w $02EE
    
    .invincible
    
    RTS
}

; $03DDE1-$03DDE4 LOCAL JUMP LOCATION
TileBehavior_Hookshottables:
{
    LDA.b $0A : TSB.b $0E

    ; Bleeds into the next function.
}

; $03DDE5-$03DDEA LOCAL JUMP LOCATION
TileBehavior_FlagManipulable:
{
    LDA.b $0A : TSB.w $02F6
    
    RTS
}

; Key door, and maybe other types of tiles...
; $03DDEB-$03DDF6 LOCAL JUMP LOCATION
TileBehavior_FlaggableDoor:
{
    LDA.b $0A : TSB.b $0E
    
    ASL #4 : TSB.w $02F6
    
    RTS
}

; Blue Rupee tile
; $03DDF7-$03DE16 JUMP LOCATION
TileBehavior_RupeeTile:
{
    LDX.b $BD
    
    ; We need this distinction to know how to update the tilemap.
    LDA.l $7F2040, X : AND.w #$00FF : CMP.w #$0060 : BNE .touched_lower_half
        ; Touched upper tile of the 16x8 rupee.
        LDA.b $0A : XBA : TSB.w $02F6
        
        RTS
    
    .touched_lower_half
    
    ; Touched lower half of the 16x8 rupee.
    LDA.b $0A : XBA : ASL #4 : TSB.w $02F6
    
    RTS
}

; Tile attribute 0x67 handler.... (orange / blue barrier tiles)
; $03DE17-$03DE28 JUMP LOCATION
TileBehavior_CrystalPeg_Up:
{
    LDA.b $0A : TSB.b $0E : TSB.w $02F6
    
    LDA.b $0A : XBA : ASL #4 : TSB.w $02E7
    
    RTS
}

; $03DE29-$03DE2C LOCAL JUMP LOCATION
TileBehavior_Conveyor_Upwards:
{
    LDA.b $0A
    
    BRA TileBehavior_Conveyor
}
    
; $03DE2D-$03DE34 LOCAL JUMP LOCATION
TileBehavior_Conveyor_Downwards:
{
    LDA.b $0A : ASL #4
    
    BRA TileBehavior_Conveyor
}
    
; $03DE35-$03DE39 LOCAL JUMP LOCATION
TileBehavior_Conveyor_Leftwards:
{
    LDA.b $0A : XBA
    
    BRA TileBehavior_Conveyor
}
    
; $03DE3A-$03DE40 LOCAL JUMP LOCATION
TileBehavior_Conveyor_Rightwards:
{
    LDA.b $0A : XBA : ASL #4

    ; Bleeds into the next function.
}
    
; $03DE41-$03DE44 LOCAL JUMP LOCATION
TileBehavior_Conveyor:
{
    TSB.w $03F1
    
    RTS
}

; $03DE45-$03DE4E LOCAL JUMP LOCATION
TileBehavior_MinigameChest:
{
    JSR.w $DDE5 ; $03DDE5 IN ROM
    
    LDA.b $06 : STA.b $76
    
    BRL.l TileBehavior_Chest_notBigKeyLock
}

; $03DE4F-$03DE5A LOCAL JUMP LOCATION
TileBehavior_Entrance:
{
    JSR.w $DD0A ; $03DD0A IN ROM
    
    LDA.b $0A : XBA : TSB.w $02EE
    
    STZ.b $62
    
    RTS
}

; $03DE5B-$03DE60 LOCAL JUMP LOCATION
TileBehavior_NothingOW:
{
    LDA.b $0A : TSB.w $0343
    
    RTS
}

; $03DE61-$03DE66 LOCAL JUMP LOCATION
TileBehavior_ThickGrass:
{
    LDA.b $0A : TSB.w $0357
    
    RTS
}

; $03DE67-$03DE6F LOCAL JUMP LOCATION
TileBehavior_DiggableGround:
{
    ; Aftermath tiles from destroying / picking things up?
    LDA.b $0A : TSB.w $035B : TSB.w $0343
    
    RTS
}

; $03DE70-$03DE7D DATA
pool TileBehavior_Liftable:
{
    .id_matcher
    dw $0054 ; Hint tile/Sign
    dw $0052 ; Gray rock
    dw $0050 ; Green bush
    dw $0051 ; Dark bush
    dw $0053 ; Black rock
    dw $0055 ; Big gray rock
    dw $0056 ; Big black rock
}

; $03DE7E-$03DEAC LOCAL JUMP LOCATION
TileBehavior_Liftable:
{
    LDX.w #$000C
    
    .nextTileType
    
        ; Load this tile's attribute value.
        LDA.b $06 
        
        CMP.w $DE70, X : BNE .noMatch
            CMP.w #$0050 : BEQ .specialCase
                CMP.w #$0051 : BNE .notSpecialCase
            
            .specialCase
            
            ; The special cases are the two colors of bushes, btw.
            ; The other things that set these particular bits are rockpiles.
            LDA.b $0A : XBA : ASL #4 : TSB.w $02EE
            
            .notSpecialCase
            
            LDA.b $0A : TSB.w $0366
            
            STX.w $036A
            
            JSR.w $DDE1 ; $03DDE1 IN ROM
            
            RTS
        
        .noMatch
    DEX #2 : BPL .nextTileType
    
    RTS
}

; $03DEAD-$03DEBA LOCAL JUMP LOCATION
TileBehavior_Ledge_South:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : ASL #4 : TSB.w $036D
    
    RTS
}

; $03DEBB-$03DEC4 LOCAL JUMP LOCATION
TileBehavior_Ledge_North:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $036D
    
    RTS
}

; $03DEC5-$03DECE LOCAL JUMP LOCATION
TileBehavior_Ledge_EastWest:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $036E
    
    RTS
}

; $03DECF-$03DEDC LOCAL JUMP LOCATION
TileBehavior_Ledge_NorthDiagonal:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : ASL #4 : TSB.w $036E
    
    RTS
}

; $03DEDD-$03DEE6 LOCAL JUMP LOCATION
TileBehavior_Ledge_SouthDiagonal:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $036F
    
    RTS
}

; $03DEE7-$03DEF0 LOCAL JUMP LOCATION
TileBehavior_UnusedCornerType:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : TSB.w $0370
    
    RTS
}

; $03DEF1-$03DFFE LOCAL JUMP LOCATION
TileBehavior_EasternRuinsCorner:
{
    LDA.b $06 : STA.b $76
    
    LDA.b $0A : ASL #4 : TSB.w $0370
    
    RTS
}

; $03DEFF-$03DF08 LOCAL JUMP LOCATION
TileBehavior_Warp:
{
    LDA.b $0A : ASL #4 : TSB.w $0357
    
    RTS
}

; $03DF09-$03DF10 LOCAL JUMP LOCATION
TileBehavior_GraveStone:
{
    LDA.b $0A : TSB.w $02E7 : TSB.b $0E
    
    RTS
}

; $03DF11-$03DF18 LOCAL JUMP LOCATION
TileBehavior_HylianPlaque:
{
    ; Desert palace trigger tile? (Book o' mudora inscription?).
    LDA.b $0A : TSB.w $02EE : TSB.b $0E
    
    RTS
}

; $03DF19-$03DF25 JUMP LOCATION
TileBehavior_BonkRocks:
{
    ; Rock pile tile.
    LDA.b $0A : TSB.b $0E
    
    XBA : ASL #4 : TSB.w $02EE
    
    RTS
}

; $03DF26-$03E025 DATA
Pool_PushBlock_GetGeneralizedTileInteractionOfTarget:
{
    .generic_type
    db $00, $01, $02, $03, $02, $00, $00, $00
    db $00, $01, $00, $01, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $00, $01, $01, $01
    db $00, $01, $01, $00, $00, $00, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $00, $01, $01, $01, $01
    db $00, $01, $01, $01, $01, $01, $01, $01
    db $00, $01, $00, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $00, $01, $00, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
}

; $03E026-$03E051 LOCAL JUMP LOCATION
PushBlock_GetGeneralizedTileInteractionOfTarget:
{
    LDA.b $00 : AND.w #$FFF8 : ASL #3 : STA.b $06
    
    LDA.b $02 : AND.w #$003F : CLC : ADC.b $06
    
    LDX.b $EE : BEQ .onBg2
        CLC : ADC.w #$1000
    
    .onBg2
    
    REP #$10
    
    TAX
    
    LDA.l $7F2000, X : AND.w #$00FF : TAX
    
    LDA.w $DF26, X : AND.w #$00FF
    
    RTS
}

; $03E052-$03E074 DATA
DifferenceFor6BLowNibble:
{
    db $00, $01, $02, $03, $04, $05, $06, $07 ; ◥
    db $07, $06, $05, $04, $03, $02, $01, $00 ; ◤
    db $07, $06, $05, $04, $03, $02, $01, $00 ; ◢
    db $00, $01, $02, $03, $04, $05, $06, $07 ; ◣
}

; $03E072-$03E075 DATA
FlagFor6BLowNibble:
{
    db $08 ; ◥
    db $04 ; ◤
    db $02 ; ◢
    db $01 ; ◣
}

; $03E076-$03E111 LOCAL JUMP LOCATION
FlagMovingIntoSlopes_Vertical:
{
    LDA.b $51 : AND.b #$07 : STA.b $00
    
    LDY.b $22
    
    LDA.b $0C : AND.b #$04 : BEQ .BRANCH_ALPHA
        DEY

    .BRANCH_ALPHA

    LDA.b $6E : ASL #2 : STA.b $01
    
    TYA : AND.b #$07 : CLC : ADC.b $01 : TAX
    
    ; Check if we've hit one of those diagonal walls... (not really the
    ; diagonal ones but before them).
    LDA.b $38 : AND.b #$05 : BEQ .BRANCH_BETA
        LDA.b $51 : AND.b #$07 : STA.b $02
        
        LDA.b $6E : AND.b #$02 : BNE .BRANCH_GAMMA
            LDA.b #$08 : SEC : SBC.b $02
            
            BRA .BRANCH_DELTA

        .BRANCH_GAMMA

        LDA.b $02 : CLC : ADC.b #$08

        .BRANCH_DELTA

        STA.b $02
        
        LDA.w $E052, X : SEC : SBC.b $02
        
        LDY.b $30 : BEQ .BRANCH_EPSILON
            BPL .BRANCH_ZETA
                EOR.b #$FF

            .BRANCH_ZETA

            INC A : STA.b $00
            
            BRA .BRANCH_THETA

    .BRANCH_BETA

    LDA.w $E052, X : SEC : SBC.b $00 : STA.b $00

    .BRANCH_THETA

    LDA.b $30 : BEQ .BRANCH_EPSILON 
        BPL .BRANCH_IOTA
            LDA.b $00 : BEQ .BRANCH_EPSILON 
                BMI .BRANCH_EPSILON
                    REP #$20
                    
                    AND.w #$00FF : CLC : ADC.b $20 : STA.b $20
                    
                    SEP #$20
                    
                    LDA.b #$08
                    
                    BRA .BRANCH_KAPPA

        .BRANCH_IOTA

        LDA.b $00 : BPL .BRANCH_EPSILON
            REP #$20
            
            AND.w #$00FF : ORA.w #$FF00 : CLC : ADC.b $20 : STA.b $20
            
            SEP #$20
            
            LDA.b #$04

            .BRANCH_KAPPA

            STA.b $6B
            
            LDY.b #$02
            
            LDA.b $0C : AND.b #$04 : BNE .BRANCH_LAMBDA
                LDY.b #$03

            .BRANCH_LAMBDA

            LDA.w $E072, Y : ORA.w #$0410
            
            RTL

    .BRANCH_EPSILON

    RTS
}

; $03E112-$03E1BD LOCAL/LONG SWITCHABLE
FlagMovingIntoSlopes_Horizontal:
{
    LDA.b $22
    
    LDY.b $6E : CPY.b #$06 : BNE .BRANCH_ALPHA
        DEC A

    .BRANCH_ALPHA

    AND.b #$07 : STA.b $00
    
    LDX.b #$00
    
    LDA.b $0C : AND.b #$04 : BEQ .BRANCH_BETA
        LDX.b #$02

    .BRANCH_BETA

    LDA.b $6E : ASL #2 : STA.b $01
    
    LDA.b $51, X : AND.b #$07 : CLC : ADC.b $01 : TAX
    
    LDA.b $38 : AND.b #$05 : BEQ .BRANCH_GAMMA
        LDA.b $22 : AND.b #$07
        
        LDY.b $6E : CPY.b #$04 : BEQ .BRANCH_DELTA
            CPY.b #$06 : BEQ .BRANCH_DELTA
                XBA
                
                TXA : EOR.b #$07 : TAX
                
                XBA : EOR.b #$FF : INC A
                
                BRA .BRANCH_EPSILON

        .BRANCH_DELTA

        SEC : SBC.b #$08 : EOR.b #$FF : INC A : STA.b $02
        
        LDA.w $E052, X : SEC : SBC.b $02

        .BRANCH_EPSILON

        LDY.b $31 : BEQ .BRANCH_ZETA
            BPL .BRANCH_THETA
                EOR.b #$FF : INC A

            .BRANCH_THETA

            STA.b $00
        
            BRA .BRANCH_IOTA

    .BRANCH_GAMMA

    LDA.w $E052, X : SEC : SBC.b $00 : STA.b $00

    .BRANCH_IOTA

    LDA.b $31 : BEQ .BRANCH_ZETA
        BPL .BRANCH_KAPPA
            LDA.b $00 : BEQ .BRANCH_ZETA 
                BMI .BRANCH_ZETA
                    REP #$20
                    
                    AND.w #$00FF : CLC : ADC.b $22 : STA.b $22
                    
                    SEP #$20
                    
                    LDA.b #$02
                    
                    BRA .BRANCH_LAMBDA

        .BRANCH_KAPPA

        LDA.b $00 : BPL .BRANCH_ZETA
            REP #$20
            
            AND.w #$00FF : ORA.w #$FF00 : CLC : ADC.b $22 : STA.b $22
            
            SEP #$20
            
            LDA.b #$01

            .BRANCH_LAMBDA

            STA.b $6B
            
            LDY.b #$00
            
            LDA.b $6E : AND.b #$02 : BNE .BRANCH_MU
                LDY.b #$01

            .BRANCH_MU

            LDA.w $E072, Y : ORA.w #$0420
            
            RTL

    .BRANCH_ZETA

    RTS
}

; $03E1BE-$03E226 LOCAL JUMP LOCATION
Link_HandleRecoiling:
{
    STZ.b $67
    
    LDY.b #$08
    
    LDA.b $27 : BEQ .BRANCH_ALPHA 
        BMI .BRANCH_BETA
            LDY.b #$04

        .BRANCH_BETA

        JSR.w Link_HandleRecoiling_handle_axis

    .BRANCH_ALPHA

    LDY.b #$02
    
    LDA.b $28 : BEQ .BRANCH_GAMMA 
        BMI .handle_axis
            LDY.b #$01

        ; $03E1D7 ALTERNATE ENTRY POINT
        .handle_axis

        TYA : ORA.b $67 : STA.b $67
        
        STA.b $26

    .BRANCH_GAMMA

    LDA.b $6B : AND.b #$0C : BEQ .BRANCH_EPSILON
        LDA.b $6B : AND.b #$03 : BEQ .BRANCH_EPSILON
            LDA.b $5D : CMP.b #$02 : BNE .BRANCH_EPSILON
                LDA.b $28 : EOR.b #$FF : INC A : STA.b $28
                
                LDA.b $27 : EOR.b #$FF : INC A : STA.b $27

    .BRANCH_EPSILON

    LDA.b $6C : CMP.b #$01 : BNE .BRANCH_ZETA
        LDA.b $26 : AND.b #$0C : STA.b $26
        
        LDA.b $67 : AND.b #$0C : STA.b $67
        
        STZ.b $28

    .BRANCH_ZETA

    LDA.b $6C : CMP.b #$02 : BNE .BRANCH_THETA
        LDA.b $26 : AND.b #$03 : STA.b $26
        
        LDA.b $67 : AND.b #$03 : STA.b $67
        
        STZ.b $27

    .BRANCH_THETA

    RTS
}

; ==============================================================================

; $03E227-$03E244 DATA
SubVelocityValues:
{
    db $18 ; 0x00 - walking on ground
    db $10 ; 0x01 - walking diagonally
    db $0A ; 0x02 - walking on stairs
    db $18 ; 0x03 - walking on stairs diagonally, but it's impossible to reach
    db $10 ; 0x04 - soft slipping
    db $08 ; 0x05 - soft slipping diagonally
    db $08 ; 0x06 - entering underworld/hard slipping
    db $04 ; 0x07 - hard slipping diagonally
    db $0C ; 0x08 - pushing statue
    db $10 ; 0x09 - pushing statue diagonally
    db $09 ; 0x0A - intraroom stairs
    db $19 ; 0x0B - 
    db $14 ; 0x0C - walking with sword out/carrying/sloshing
    db $0D ; 0x0D - walking with sword out/carrying/sloshing diagonally
    db $10 ; 0x0E - sword out/carry sloshing
    db $08 ; 0x0F - sword out/carry sloshing diagonally
    db $40 ; 0x10 - dashing
    db $2A ; 0x11 - dashing diagonally
    db $10 ; 0x12 - pushing block
    db $08 ; 0x13 - pushing block diagonally
    db $04 ; 0x14 - pulling statue/walking to triforce
    db $02 ; 0x15 - pulling statue diagonally
    db $30 ; 0x16 - slosh dashing
    db $18 ; 0x17 - slosh dashing diagonally
    db $20 ; 0x18 - dashing on ice
    db $15 ; 0x19 - dashing on ice diagonally
    db $F0 ; 0x1A - 
    db $00 ; 0x1B - 
    db $F0 ; 0x1C - 
    db $01 ; 0x1D - 
}

; ==============================================================================

; $03E245-$03E36F LONG JUMP LOCATION
Link_HandleVelocity:
{
    PHB : PHK : PLB
    
    ; Branch if we're not in the text submodule.
    LDA.b $11 : CMP.b #$02 : BNE .BRANCH_ALPHA
        ; Are we in message mode?
        LDA.b $10 : CMP.b #$0E : BEQ .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    ; Flag indicating that Link can move.
    LDA.w $0B7B : BEQ .playerCanMove
        .BRANCH_BETA
        
        ; Otherwise, Link can't move and has to stay in place.
        LDA.b $20 : STA.b $00 : STA.b $3E
        LDA.b $22 : STA.b $01 : STA.b $3F
        
        LDA.b $21 : STA.b $02 : STA.b $40
        LDA.b $23 : STA.b $03 : STA.b $41
        
        BRL .BRANCH_ALIF
    
    .playerCanMove
    
    ; Is Link swimming?
    LDA.b $5D : CMP.b #$04 : BEQ .isSwimming
        ; Is Link moving already?
        LDA.w $034A : BEQ .BRANCH_EPSILON
            ; Called if Link is on a collision course and hits a wall.
            LDA.w $0372 : BEQ .notDashVolatile
                ; Here, Link is moving, but has not hit a wall yet.
                LDA.b #$18 : STA.b $00
                
                BRA .BRANCH_ZETA
    
    .isSwimming
    .notDashVolatile
    
    BRL HandleSwimStrokeAndSubpixels
    
    .BRANCH_EPSILON
    
    ; The collision indicator.
    LDA.w $0372 : BEQ .BRANCH_THETA
        STZ.b $57
        
        LDA.w $02F1 : CMP.b #$10 : BCS .BRANCH_THETA
            BRL Link_DashInPlace
    
    .BRANCH_THETA
    
    LDA.w $0316 : ORA.w $0317 : CMP.b #$0F : BNE .BRANCH_IOTA
        BRL Link_HandleVelocityAndSandDrag_return
    
    .BRANCH_IOTA
    
    LDA.b $5E : STA.b $00
    
    LDA.w $0351 : BEQ .BRANCH_ZETA
        ; Pegasus dashing speed.
        LDA.b $5E : CMP.b #$10 : BNE .BRANCH_LAMBDA
            ; Link is going fast.
            LDX.b #$16
            
            BRA .BRANCH_MU
        
        .BRANCH_LAMBDA
        
        LDX.b #$0C
        
        LDA.b $5E : CMP.b #$0C : BNE .BRANCH_MU
            LDX.b #$0E
        
        .BRANCH_MU
        
        STX.b $00
    
    .BRANCH_ZETA
    
    STZ.b $27
    STZ.b $28
    
    STZ.b $68
    STZ.b $69
    
    LDX.b #$00
    
    ; Filter out Up and down data.
    ; I.e. one of the left or right directions is down.
    LDA.b $67 : TAY : AND.b #$0C : BEQ .BRANCH_NU
        TYA : AND.b #$03 : BEQ .BRANCH_NU
            LDX.b #$01
        
    .BRANCH_NU
    
    TXA : CLC : ADC.b $00 : TAX
    
    LDA.b $5B : BEQ .BRANCH_XI
        ; Is Link not in a falling state?
        CMP.b #$03 : BNE .load_subvel
            ; Oh my, Link is in a falling state.
            LDA.b $57 : CMP.b #$30 : BCS .BRANCH_PI
                ADC.b #$08 : STA.b $57
                
                BRA .load_subvel
            
            .BRANCH_PI
            
            ; Reset it back to 0x20.
            LDA.b #$20 : STA.b $57
            
            BRA .load_subvel
        
    .BRANCH_XI
    
    LDA.b $57 : BEQ .load_subvel
        LDX.b #$0A
        
        LDA.b $11 : CMP.b #$08 : BEQ .BRANCH_RHO
            CMP.b #$10 : BEQ .BRANCH_RHO
                LDX.b #$02
        
        .BRANCH_RHO
        
        LDA.b $67 : AND.b #$00 : BEQ .BRANCH_SIGMA
            INX
        
        .BRANCH_SIGMA
        
        LDA.b $57
        
        CMP.b #$01 : BEQ .load_subvel
            CMP.b #$10 : BCS .BRANCH_TAU
                ADC.b #$01 : STA.b $57
                
                LDA.b #$00
                
                BRA .BRANCH_UPSILON
            
            .BRANCH_TAU
            
            STZ.b $57
            STZ.b $5E
    
    .load_subvel
    
    ; $3E227, X in rom. Link's speed table.
    LDA.w $E227, X
    
    .BRANCH_UPSILON
    
    CLC : ADC.b $57 : STA.b $0A
                      STA.b $0B
    
    LDA.b #$03 : STA.b $0C
    LDA.b #$02 : STA.b $0D
    
    LDX.b #$01
    
    .BRANCH_PSI
    
        LDA.b $67
        
        AND.b $0C : BEQ .BRANCH_PHI
            AND.b #$0D : BEQ .BRANCH_CHI
                LDA.b $0A, X : EOR.b #$FF : INC A : STA.b $0A, X
            
            .BRANCH_CHI
            
            ; Set Link's velocity in this direction (Y = 0 - up/down, 1 -
            ; left/right).
            LDA.b $0A, X : STA.b $27, X
        
        .BRANCH_PHI
        
        ASL.b $0C : ASL.b $0C
        ASL.b $0D : ASL.b $0D
    DEX : BPL .BRANCH_PSI
    
    LDA.b #$FF : STA.b $29
                 STA.b $24
                 STA.b $25
    
    STZ.b $2C
    
    BRA LinkHop_FindArbitraryLandingSpot_cache_full_coords
}
    
; $03E370-$03E3DC LOCAL JUMP LOCATION
LinkHop_FindArbitraryLandingSpot:
{
    PHB : PHK : PLB
    
    .cache_full_coords
    
    LDA.b $20 : STA.b $00 : STA.b $3E
    
    LDA.b $22 : STA.b $01 : STA.b $3F
    
    LDA.b $21 : STA.b $02 : STA.b $40
    
    LDA.b $23 : STA.b $03 : STA.b $41
    
    ; Is Link using the quake medallion?
    LDA.b $5D : CMP.b #$0A : BEQ .BRANCH_KAPPA
        ; If it's 2, you can't move. Hold Link in place.
        LDA.w $02F5 : CMP.b #$02 : BEQ .BRANCH_ALIF
    
    .BRANCH_KAPPA
    
    LDY.b #$02
    LDX.b #$04
    
    LDA.b $4D : BNE .BRANCH_KESRA
        LDY.b #$01
        LDX.b #$02
        
    .BRANCH_KESRA
    
        ; Check velocities for different directions ($27 is horizontal, $28 is
        ; vertical, so Y is 0 or 1).
        LDA.w $0027, Y : ASL #4
        
        CLC : ADC.w $002A, Y : STA.w $002A, Y
        
        PHY : PHP
        
        LDA.w $0027, Y : LSR #4 : CMP.b #$08
        
        LDY.b #$00
        
        BCC .BRANCH_FATHA
            ; If the velocity is negative, sign extend to 16 bit.
            ORA.b #$F0 : LDY.b #$FF
        
        .BRANCH_FATHA
        
        PLP
        
            ADC.b $20, X : STA.b $20, X
        TYA : ADC.b $21, X : STA.b $21, X
        
        PLY : DEY
    
        ; Check next direction's recoil / impulse setting.
    DEX #2 : BPL .BRANCH_KESRA
    
    JSR.w Link_HandleMovingFloor
    JSR.w Link_ApplyConveyor
    
    BRA Link_HandleVelocityAndSandDrag
}
    
; $03E3DD-$03E3DF LOCAL JUMP LOCATION
Link_HandleVelocityAndSandDrag_long:
{
    PHB : PHK : PLB

    ; Bleeds into the next function.
}
    
; $03E3E0-$03E405 LOCAL JUMP LOCATION
Link_HandleVelocityAndSandDrag::
{
    REP #$20
    
    LDA.b $20 : CLC : ADC.w $0B7E : STA.b $20
    
    LDA.b $22 : CLC : ADC.w $0B7C : STA.b $22
    
    SEP #$20
    
    ; This is bounds checking, to keep Link from advancing past a wall.
    ; Otherwise, Link and/or the camera will shake as he alternates between
    ; Getting through the wall and getting pushed back.
    LDA.b $20 : SEC : SBC.b $00 : STA.b $30
    
    LDA.b $22 : SEC : SBC.b $01 : STA.b $22
    
    ; $03E402 ALTERNATE ENTRY POINT
    .return
    
    SEP #$20
    
    PLB
    
    RTL
}

; $03E42A-$03E540 LONG BRANCH LOCATION
HandleSwimStrokeAndSubpixels:
{
    STZ.b $27
    STZ.b $28
    
    SEP #$20
    
    LDX.b #$02
    
    .BRANCH_LAMBDA
    
        STZ.b $08, X
        
        DEC.w $0326, X : BPL .BRANCH_ALPHA
            LDA.w #$0001 : STA.w $032B, X
            
            STZ.w $0326, X
        
        .BRANCH_ALPHA
        
        LDA.w $032B, X : ASL A : TAY
        
        LDA.w $034A : AND.w #$00FF : BEQ .BRANCH_BETA
            ASL #3 : STA.b $00
            
            TYA : CLC : ADC.b $00 : TAY
        
        .BRANCH_BETA
        
        LDA.w $E406, Y : CLC : ADC.w $033C, X : BEQ .BRANCH_GAMMA
            BPL .BRANCH_DELTA

        .BRANCH_GAMMA
            
        LDA.w $E41E, X : AND.b $67 : STA.b $67 : STA.b $26
            
         LDA.w $032B, X : CMP.w #$0002 : BNE .BRANCH_EPSILON
            STZ.w $032B, X
                
            LDA.w $9639 : STA.w $0334, X
                
            LDA.w #$0002
                
            BRA .BRANCH_ZETA
            
        .BRANCH_EPSILON
            
        LDA.w #$0000 : STA.w $0334, X : STA.w $033B, X
            
        BRA .BRANCH_ZETA
        
        .BRANCH_DELTA
        
        PHA
        
        TXA : CLC : ADC.w $0338, X : ASL A : TAY
        
        LDA.w $E422, Y : ORA.b $67 : STA.b $67
        
        PLA : CMP.w $0334, X : BCC .BRANCH_ZETA
            LDA.w $0334, X
        
        .BRANCH_ZETA
        
        STZ.w $033C, X
        
        STA.b $08, X
        
        LDA.b $6A : BEQ .BRANCH_THETA
            STA.b $08
            
            LSR #2 : STA.b $00
            
            LDA.b $08, X : SEC : SBC.b $00 : STA.b $08, X
        
        .BRANCH_THETA
        
        LDA.w $0338, X : AND.w #$00FF : BNE .BRANCH_IOTA
            LDA.b $08, X : EOR.w #$FFFF : INC A : STA.b $08, X
        
        .BRANCH_IOTA
        
        DEX #2
        
        BMI .continue
    BRL .BRANCH_LAMBDA
    
    ; $03E4D3 ALTERNATE ENTRY POINT
    .continue
    
    SEP #$20
    
    LDA.b $20 : STA.b $00 : STA.b $3E
    LDA.b $22 : STA.b $01 : STA.b $3F
    LDA.b $21 : STA.b $02 : STA.b $40
    LDA.b $23 : STA.b $03 : STA.b $41
    
    LDY.b #$01
    LDX.b #$02
    
    .BRANCH_XI
    
        LDA.b $08, X : ADC.w $002A, Y : STA.w $002A, Y
        
        PHY : PHP
        
        LDA.b $09, X : CMP.b #$08
        
        LDY.b #$00
        
        BCC .BRANCH_MU
            ORA.b #$F0
            
            LDY.b #$FF
        
        .BRANCH_MU
        
        PLP
        
        ADC.b $20, X : STA.b $20, X
        
        TYA : ADC.b $21, X : STA.b $21, X
        
        PLY
        
        LDA.b $08, X : LSR #4 : STA.b $08, X
        
        LDA.b $09, X : BPL .BRANCH_NU
            EOR.b #$FF : INC A
        
        .BRANCH_NU
        
        ASL #4 : ORA.b $08, X : STA.w $0027, X
        
        DEY
    DEX #2 : BPL .BRANCH_XI
    
    LDA.w $046C : CMP.b #$04 : BNE .BRANCH_OMICRON
        JSR.w $E5CD ; $03E5CD IN ROM
    
    .BRANCH_OMICRON
    
    STZ.b $68
    STZ.b $69
    
    BRL Link_HandleVelocityAndSandDrag
}

; ==============================================================================

; $03E541-$03E544 DATA
UNREACHABLE_07E541:
{
    db $40, $00, $10, $00
}

; ==============================================================================

; $03E545-$03E594 LONG BRANCH LOCATION
Link_DashInPlace:
{
    STZ.b $00
    STZ.b $01
    
    LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_ALPHA
        LDX.b #$80
        
        LDA.w $0351 : BEQ .BRANCH_BETA
            LDX.b #$50
        
        .BRANCH_BETA
        
        STX.b $00
        
        LDA.b #$01 : STA.b $01
    
    .BRANCH_ALPHA
    
    STZ.b $27
    STZ.b $28
    STZ.b $08
    STZ.b $09
    STZ.b $0A
    STZ.b $0B
    
    LDX.b #$03
    
    LDA.b $67
    
    .BRANCH_DELTA
    
        LSR A : BCS .BRANCH_GAMMA
    DEX : BPL .BRANCH_DELTA
    
    PLB
    
    RTL
    
    .BRANCH_GAMMA
    
    TXY
    
    REP #$20
    
    LDA.b $00
    
    CPY.b #$00 : BEQ .BRANCH_EPSILON
        CPY.b #$02 : BNE .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    EOR.w #$FFFF : INC A
    
    .BRANCH_ZETA
    
    PHA
    
    TYA : AND.w #$0002 : TAX
    
    PLA : STA.b $08, X
    
    SEP #$20
    
    BRL HandleSwimStrokeAndSubpixels_continue
}

; ==============================================================================

; $03E595-$03E5CC LOCAL JUMP LOCATION
Link_HandleMovingFloor:
{
    LDA.w $046C : BEQ Link_ApplyMovingFloorVelocity_return
        LDA.b $24 : BEQ .BRANCH_BETA
            CMP.b #$FF : BNE Link_ApplyMovingFloorVelocity_return
        
        .BRANCH_BETA
        
        LDA.w $0322 : AND.b #$03 : CMP.b #$03 : BNE Link_ApplyMovingFloorVelocity_return
            LDA.b $5D : CMP.b #$13 : BEQ Link_ApplyMovingFloorVelocity_return
                LDY.b #$08
                
                LDA.w $0310 : BEQ .BRANCH_GAMMA 
                    BMI .BRANCH_DELTA
                        LDY.b #$04
                    
                    .BRANCH_DELTA
                    
                    TYA : TSB.b $67
                
                .BRANCH_GAMMA
                
                LDY.b #$02
                
                ; TODO: Confirm this branch location. Kan's says it just goes to
                ; Link_ApplyMovingFloorVelocity.
                LDA.w $0312 : BEQ Link_ApplyMovingFloorVelocity_BRANCH_EPSILON
                    BMI .BRANCH_ZETA
                        LDY.b #$01
                    
                    .BRANCH_ZETA
                    
                    TYA : TSB.b $67

    ; Bleeds into the next function.
}
                    
; $03E5CD-$03E5E3 LOCAL JUMP LOCATION
Link_ApplyMovingFloorVelocity:
{
    STZ.b $6A
            
    ; $03E5CF ALTERNATE ENTRY POINT
    .BRANCH_EPSILON
                
    REP #$20
                
    LDA.b $20 : CLC : ADC.w $0310 : STA.b $20
    LDA.b $22 : CLC : ADC.w $0312 : STA.b $22
                
    SEP #$20
    
    .return
    
    RTS
}

; ==============================================================================

; $03E5E4-$03E5EF DATA
Pool_Link_ApplyConveyor:
{
    ; $03E5E4
    .walking_direction_flags
    db $08 ; Up
    db $04 ; Down
    db $02 ; Left
    db $01 ; Right
    
    ; $03E5E8
    .y_speeds
    db  -8 ; Up
    db   8 ; Down
    db   0 ; Left
    db   0 ; Right

    ; $03E5EC
    .x_speeds
    db   0 ; Up
    db   0 ; Down
    db  -8 ; Left
    db   8 ; Right
}

; $03E5F0-$03E670 LOCAL JUMP LOCATION
Link_ApplyConveyor:
{
    LDA.w $03F3 : BEQ Link_ApplyMovingFloorVelocity_return
        LDA.b $24 : BEQ .BRANCH_ALPHA
            CMP.b #$FF : BEQ Link_ApplyMovingFloorVelocity_return
        
        .BRANCH_ALPHA
        
        LDA.w $0376 : AND.b #$01 : BEQ Link_ApplyMovingFloorVelocity_return
            LDA.b $5D : CMP.b #$13 : BEQ Link_ApplyMovingFloorVelocity_return
                LDA.b $4D : BEQ Link_ApplyMovingFloorVelocity_return
                    LDA.w $0372 : BEQ .BRANCH_BETA
                        LDA.w $02F1 : CMP.b #$20 : BNE .BRANCH_BETA
                            LDY.w $03F3 : DEY
                        
                            LDA.w $E5E4, Y : AND.b $67 : BEQ Link_ApplyMovingFloorVelocity_return
                    
                    .BRANCH_BETA
                    
                    STZ.b $6A
                    
                    LDY.w $03F3 : DEY
                    
                    LDA.w $E5E4, Y : TSB.b $67
                    
                    LDA.w $E5E8, Y : STA.b $72
                    
                    LDA.w $E5EC, Y : STA.b $73
                    
                    LDX.b #$01
                    LDY.b #$02
                    
                    .BRANCH_DELTA
                    
                        PHX
                        
                        LDA.b $72, X : ASL #4 : CLC : ADC.w $041C, X : STA.w $041C, X
                        
                        LDA.b $72, X
                        
                        PHP
                        
                        LDX.b #$00
                        
                        LSR #4
                        
                        PLP : BPL .BRANCH_GAMMA
                            ORA.b #$F0
                            
                            DEX
                            
                        .BRANCH_GAMMA
                        
                        ADC.w $0020, Y : STA.w $0020, Y
                        
                        TXA : ADC.w $0021, Y : STA.w $0021, Y
                        
                        PLX
                        
                        DEY #2
                    DEX : BPL .BRANCH_DELTA
                    
                    SEP #$20
                    
                    RTS
}

; $03E69D-$03E6A5 LONG JUMP LOCATION
Link_HandleMovingAnimation_SetFacingDown:
{
    PHB : PHK : PLB
    
    LDA.b #$04 : STA.b $26
    
    BRA Link_HandleMovingAnimation_MainEntry
}
    
; $03E6A6-$03E6A8 LOCAL JUMP LOCATION
Link_HandleMovingAnimation_FullLongEntry:
{
    PHB : PHK : PLB

    ; Bleeds into the next function.
}
    
; $03E6A9-$03E703 LOCAL JUMP LOCATION
Link_HandleMovingAnimation_MainEntry:
{
    ; Is Link swimming?
    LDA.b $5D : CMP.b #$04 : BNE .notSwimming
        BRL Link_HandleMovingAnimationSwimming
    
    .notSwimming
    
    ; Is Link moving / pushing?
    LDA.b $26 : BNE .isPushing
        BRL .BRANCH_PSI
    
    .isPushing
    
    ; Store that push state.
    STA.b $00
    
    ; Check the movement flag.
    LDA.w $034A : BEQ .notMoving
        LDA.w $0340 : STA.b $00
    
    .notMoving
    
    ; Check if Link can change direction:
    LDA.b $50 : BNE Link_HandleMovingAnimation_StartWithDash_check_dashing
        LDA.b $6A : BEQ .BRANCH_EPSILON
            LDA.b $6C : BEQ .BRANCH_ZETA
                ASL A : AND.b #$FC : TAY
                
                BRA .BRANCH_THETA
                
            .BRANCH_ZETA
            
            LDA.b $2F : LSR A : TAX
            
            LDA.b $00 : AND.w $E671, X : BNE Link_HandleMovingAnimation_StartWithDash_check_dashing
        
        .BRANCH_EPSILON
        
        LDY.b #$04
        
        LDA.b $00 : AND.b #$0C : BEQ .BRANCH_THETA
            LDY.b #$00
        
        .BRANCH_THETA
        
        ; Check if moving in horizontal direction:
        CPY.b #$04 : BEQ .BRANCH_IOTA
            LDA.b $00 : AND.b #$04 : BNE .BRANCH_KAPPA
                BRA .BRANCH_LAMBDA
        
        .BRANCH_IOTA
        
        LDA.b $00 : AND.b #$01 : BEQ .BRANCH_LAMBDA
            .BRANCH_KAPPA
            
            INY #2
        
        .BRANCH_LAMBDA
        
        ; All this really comes down to is setting Link's direction but $26 and
        ; $2F have somewhat incompatible layouts, *sigh*.
        STY.b $2F
        
        BRA Link_HandleMovingAnimation_StartWithDash_check_dashing
}
    
; $03E704-$03E7CD LOCAL JUMP LOCATION
Link_HandleMovingAnimation_StartWithDash:
{
    PHB : PHK : PLB
    
    ; $03E707 ALTERNATE ENTRY POINT
    .check_dashing
    
    LDA.w $0372 : BEQ .BRANCH_MU
        BRL Link_HandleMovingAnimation_Dash
    
    .BRANCH_MU
    
    LDA.b $2F : LSR A : TAX
    
    LDA.b $5E : CMP.b #$06 : BNE .BRANCH_NU
        TXA : CLC : ADC.b #$04 : TAX
        
        BRA .BRANCH_XI
    
    .BRANCH_NU
    
    LDA.w $034A : BEQ .BRANCH_XI
        ; Branch if no direction buttons are held down.
        LDA.b $F0 : AND.b #$0F : BEQ .BRANCH_PI
            TXA : CLC : ADC.b #$04 : TAX
    
    .BRANCH_XI
    
    LDA.b $5D : CMP.b #$17 : BNE .BRANCH_RHO
        BRL Link_HandleMovingAnimation_Bunny
    
    .BRANCH_RHO
    
    LDA.b $11
    
    CMP.b #$0E : BEQ .BRANCH_SIGMA
        CMP.b #$12 : BEQ .BRANCH_TAU
            CMP.b #$13 : BNE .BRANCH_UPSILON
        
        .BRANCH_TAU
        
        LDX.b #$0C
        
        BRA .BRANCH_SIGMA
        
        .BRANCH_UPSILON
        
        LDA.w $0308 : AND.b #$80 : BNE .BRANCH_SIGMA
            LDA.b $48 : AND.b #$8D : BEQ .BRANCH_PHI
                LDX.b #$0C
                
                BRA .BRANCH_SIGMA
            
            .BRANCH_PHI
            
            LDA.w $0351 : BNE .BRANCH_SIGMA
                LDA.b $3C : BEQ .BRANCH_CHI
    
    .BRANCH_SIGMA
    
    LDA.b $2E : CMP.b #$06 : BCS .BRANCH_PI
        LDA.w $02F5 : CMP.b #$02 : BEQ .BRANCH_PI
            LDA.w $E675, X : STA.b $00
            
            LDA.b $2D : CLC : ADC.b #$01 : STA.b $2D : CMP.b $00 : BCC .BRANCH_PSI
                STZ.b $2D
                
                LDA.b $2E : INC A : CMP.b #$06 : BNE .BRANCH_OMEGA
    
    .BRANCH_PI
    
    LDA.b #$00
    
    .BRANCH_OMEGA
    
    STA.b $2E
    
    .BRANCH_PSI
    
    PLB
    
    RTL
    
    .BRANCH_CHI
    
    LDX.b $2E
    
    LDA.b $5E : CMP.b #$06 : BNE .BRANCH_ALIF
        TXA : CLC : ADC.b #$08 : TAX
    
    .BRANCH_ALIF
    
    LDA.w $034A : BEQ .BRANCH_BET
        TXA : CLC : ADC.b #$08 : TAX
    
    .BRANCH_BET
    
    LDA.w $02F5 : CMP.b #$02 : BEQ Link_HandleMovingAnimation_Bunny_return
        LDA.w $E685, X : STA.b $00
        
        LDA.b $2D : CLC : ADC.b #$01 : STA.b $2D : CMP.b $00 : BCC .BRANCH_THEL
            STZ.b $2D
            
            LDA.b $2E : INC A : CMP.b #$09 : BNE .BRANCH_RAH
                LDA.b #$01
            
            .BRANCH_RAH
            
            STA.b $2E
        
        .BRANCH_THEL
        
        PLB
        
        RTL
}

; $03E7CE-$03E7F9 LONG JUMP LOCATION
Link_HandleMovingAnimation_Bunny:
{
    LDA.b $2E : CMP.b #$04 : BCS .BRANCH_ZAH
        LDA.w $02F5 : CMP.b #$02 : BEQ .BRANCH_ZAH
            LDA.w $E675, X : STA.b $00
            
            LDA.b $2D : CLC : ADC.b #$01 : STA.b $2D : CMP.b $00 : BCC .return
                STZ.b $2D
                
                LDA.b $2E : INC A : CMP.b #$04 : BNE .BRANCH_SIN
    
    .BRANCH_ZAH
    
    LDA.b #$00
    
    .BRANCH_SIN
    
    STA.b $2E
    
    .return
    
    PLB
    
    RTL
}

; $03E7FA-$03E841 LONG BRANCH LOCATION
Link_HandleMovingAnimationSwimming:
{
    LDA.w $0340 : BEQ .BRANCH_ALPHA
        LDA.b $50 : BNE .BRANCH_ALPHA
            LDA.b $6A : BEQ .BRANCH_BETA
                LDA.b $6C : BEQ .BRANCH_GAMMA
                    ASL A : AND.b #$FC : TAY
                    
                    BRA .BRANCH_DELTA
                
                .BRANCH_GAMMA
                
                LDA.b $2F : LSR A : TAX
                
                LDA.w $0340 : AND.w $E671, X : BNE .BRANCH_ALPHA
            
            .BRANCH_BETA
            
            LDY.b #$04
            
            LDA.w $0340 : AND.b #$0C : BEQ .BRANCH_DELTA
                LDY.b #$00
            
            .BRANCH_DELTA
            
            CPY.b #$04 : BEQ .BRANCH_EPSILON
                LDA.w $0340 : AND.b #$04 : BNE .BRANCH_ZETA
                    BRA .BRANCH_THETA
            
            .BRANCH_EPSILON
            
            LDA.w $0340 : AND.b #$01 : BEQ .BRANCH_THETA
                .BRANCH_ZETA
                
                INY #2
            
            .BRANCH_THETA
            
            STY.b $2F
        
    .BRANCH_ALPHA
    
    PLB
    
    RTL
}

; $03E88F-$03E8EF LONG BRANCH LOCATION
Link_HandleMovingAnimation_Dash:
{
    LDX.b #$06
    
    LDA.w $0374 : BEQ .BRANCH_ALPHA
        .BRANCH_BETA
        
            LDA.w $0374 : CMP.w $E881, X : BCC .BRANCH_ALPHA
        DEX : BPL .BRANCH_BETA
        
        INX
    
    .BRANCH_ALPHA
    
    LDA.b $3C : CMP.b #$09 : BCS .BRANCH_GAMMA
        LDA.w $0351 : BNE .BRANCH_GAMMA
            TXA : ASL #3 : TAX
            
            LDA.w $E842, X : STA.b $00
            
            LDA.b $2D : CLC : ADC.b #$01 : STA.b $2D
            CMP.b $00 : BCC .BRANCH_DELTA
                STZ.b $2D
                
                LDA.b $2E : INC A : CMP.b #$09 : BNE .BRANCH_EPSILON
                    LDA.b #$01
                
                .BRANCH_EPSILON
                
                BRA .BRANCH_ZETA
            
            .BRANCH_DELTA
            
            BRA .BRANCH_THETA
    
    .BRANCH_GAMMA
    
    LDA.w $E87A, X : STA.b $00
    
    LDA.b $2D : CLC : ADC.b #$01 : STA.b $2D : CMP.b $00 : BCC .BRANCH_THETA
        STZ.b $2D
        
        LDA.b $2E : INC A : CMP.b #$06 : BCC .BRANCH_ZETA
            LDA.b #$00
        
        .BRANCH_ZETA
        
        STA.b $2E
    
    .BRANCH_THETA
    
    PLB
    
    RTL
}

; $03E8F0-$03E900 LOCAL JUMP LOCATION
HandleIndoorCameraAndDoors:
{
    ; If outdoors, ignore.
    LDA.b $1B : BEQ .return
        ; I'll deal with this routine later.
        LDA.b $6C : BEQ .notInDoorway
            JML.l $07E901 ; $03E901 IN ROM
        
        .notInDoorway
        
        JSL.l $07E9D3 ; $03E9D3 IN ROM
    
    .return
    
    RTS
}

; $03E901-$03E9D2 LOCAL JUMP LOCATION
HandleDoorTransitions:
{
    STZ.b $68
    STZ.b $69
    
    ; Check Link's push state for down/up presses:
    LDA.b $26 : AND.b #$0C : BEQ .BRANCH_ALPHA
        ; See if Link's in a vertical doorway:
        LDX.b $6C : CPX.b #$01 : BNE .BRANCH_ALPHA
            ; Check for down presses:
            AND.b #$04 : BEQ .BRANCH_BETA
                REP #$20
                
                LDA.b $20 : CLC : ADC.w #$001C : STA.b $00
                AND.w #$00FC : BNE .BRANCH_ALPHA
                    SEP #$20
                    
                    LDA.b $01 : SEC : SBC.b $40 : STA.b $68
                    
                    BRA .BRANCH_ALPHA
            
            .BRANCH_BETA

            ; Not a down press.
            
            REP #$20
            
            LDA.b $20 : SEC : SBC.w #$0012 : STA.b $00
            
            SEP #$20
            
            LDA.b $01 : SEC : SBC.b $40 : STA.b $68
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    ; Check Link's push state for left/right presses:
    LDA.b $26 : AND.b #$03 : BEQ .BRANCH_GAMMA
        LDX.b $6C : CPX.b #$02 : BNE .BRANCH_GAMMA
            AND.b #$01 : BEQ .BRANCH_DELTA
                REP #$20
                
                LDA.b $22 : CLC : ADC.w #$0015 : STA.b $00
                AND.w #$00FC : BNE .BRANCH_GAMMA
                    SEP #$20
                    
                    LDA.b $01 : SEC : SBC.b $41 : STA.b $69
                    
                    BRA .BRANCH_GAMMA
    
    .BRANCH_DELTA
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w #$0008 : STA.b $00
    
    SEP #$20
    
    LDA.b $01 : SEC : SBC.b $41 : STA.b $69
    
    .BRANCH_GAMMA
    
    SEP #$20
    
    ; ????
    LDA.b $69 : BEQ .noHorizontalMovement
        BMI .movedLeft
            ; NOTE! These are all intra-room transitions.
            STZ.w $030B
            STZ.w $0308
            STZ.w $0309
            STZ.w $0376
            
            ; Transition right.
            JSL.l $02B62E ; $01362E IN ROM
            
            RTS
    
        .movedLeft
        
        STZ.w $030B
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        
        ; Transition left.
        JSL.l $02B6CD ; $0136CD IN ROM
        
        RTS
    
    .noHorizontalMovement
    
    LDA.b $68 : BEQ .noVerticalMovement
        BPL .movedDown
            STZ.w $030B
            STZ.w $0308
            STZ.w $0309
            STZ.w $0376
            
            JSL.l HandleEdgeTransitionMovementNorth
            
            RTS
        
        .movedDown
        
        STZ.w $030B
        STZ.w $0308
        STZ.w $0309
        STZ.w $0376
        
        JSL.l $02B76E ; $01376E IN ROM
    
    .noVerticalMovement
    
    RTS
}

; ==============================================================================

; $03E9D3-$03EA05 LONG JUMP LOCATION
ApplyLinksMovementToCamera:
{
    PHB : PHK : PLB
    
    LDA.b $21 : SEC : SBC.b $40 : STA.b $68
    LDA.b $23 : SEC : SBC.b $41 : STA.b $69
    
    LDA.b $69 : BEQ .noHorizontalMovement
        BMI .movedLeft
            JSL.l $02B8BD ; $0138BD IN ROM
            
            BRA .noHorizontalMovement
            
        .movedLeft
            
        JSL.l $02B8F9 ; $0138F9 IN ROM
    
    .noHorizontalMovement
    
    LDA.b $68 : BEQ .noVerticalMovement
        BPL .movedDown
            JSL.l $02B919 ; $013919 IN ROM
            
            PLB
            
            RTL
        
        .movedDown
        
        JSL.l $02B909 ; $013909 IN ROM
    
    .noVerticalMovement
    
    PLB
    
    RTL
}

; ==============================================================================

; $03EA06-$03EA21 LONG JUMP LOCATION
Player_InitPrayingScene_HDMA:
{
    ; This routine initializes the hdma table for Link praying to open
    ; the desert barrier. This code is not the same as that used to create
    ; the spotlight effects of entering or leaving a dungeon. That can
    ; be found in bank 0x00.
    
    JSL.l $02C7B8 ; $0147B8 IN ROM
    
    PHB : PHK : PLB
    
    REP #$20
    
    LDA.w #$0026 : STA.w $067C
    
    SEP #$20
    
    STZ.w $067E
    
    JSL.l DesertPrayer_BuildIrisHDMATable
    
    INC.b $B0
    
    PLB
    
    RTL
}

; ==============================================================================

; $03EA22-$03EA26 DATA
DesertPrayerAnimationTimer:
{
    .timers
    db 22, 22, 22, 64, 1
}

; ==============================================================================

; $03EA27-$03EBD9 LONG JUMP LOCATION
DesertPrayer_BuildIrisHDMATable:
{
    ; This routine seems to construct the hdma table that zeroes in or out
    ; on the player's position (e.g. when leaving a dungeon or entering
    ; one).
    
    PHB : PHK : PLB
    
    REP #$30
    
    STZ.b $04
    
    LDA.b $20 : SEC : SBC.b $E8 : CLC : ADC.w #$000C : STA.b $0E
    
    SEC : SBC.w $067C : STA.w $0674 : BPL .BRANCH_ALPHA
        STA.b $04
    
    .BRANCH_ALPHA
    
    CLC : ADC.w $067C : CLC : ADC.w $067C : STA.w $0676
    
    LDA.b $22 : SEC : SBC.b $E2 : CLC : ADC.w #$0008 : STA.w $0670
    
    LDA.w #$0001 : STA.w $067A
    
    .BRANCH_PHI
    
        LDA.w #$0100 : STA.b $00 : STA.b $02
        
        LDA.w $0674 : BMI .BRANCH_BETA
            LDA.b $04
            
            CMP.w $0674 : BCC .BRANCH_GAMMA
            CMP.w $0676 : BCS .BRANCH_GAMMA
        
        .BRANCH_BETA

        LDA.w $067C : CMP.w $067A : BCS .BRANCH_DELTA
            LDA.w #$0001 : STA.w $067A
            
            STZ.w $0674
            
            LDA.w $0676 : STA.b $04 : CMP.w #$00E1 : BCC .BRANCH_GAMMA
                BRL .BRANCH_EPSILON
        
        .BRANCH_DELTA
        
        JSR.w $ECDC ; $03ECDC IN ROM
        
        LDA.b $06 : BNE .BRANCH_ZETA
            STZ.w $0674
            
            BRA .BRANCH_THETA
        
        .BRANCH_ZETA
        
        LDA.b $08 : CLC : ADC.w $0670 : STA.b $02
        
        LDA.w $0670 : SEC : SBC.b $08 : STA.b $00
        
        .BRANCH_THETA
        
        LDA.w $067A : AND.w #$00FF : STA.b $0A
        
        LDA.b $0E : SEC : SBC.b $0A : DEC A : ASL A : TAX
        
        BRA .BRANCH_IOTA
        
        .BRANCH_GAMMA
        
        LDA.b $04 : DEC A : ASL A : TAX
        
        .BRANCH_IOTA
        
        LDA.b $00 : TAY : BMI .BRANCH_KAPPA
            AND.w #$FF00 : BEQ .BRANCH_LAMBDA
                CMP.w #$0100 : BNE .BRANCH_KAPPA
                    LDY.w #$00FF
                    
                    BRA .BRANCH_LAMBDA
        
        .BRANCH_KAPPA
        
        LDY.w #$0000
        
        .BRANCH_LAMBDA
        
        TYA : AND.w #$00FF : STA.b $06
        
        LDA.b $02 : TAY
        
        AND.w #$FF00 : BEQ .BRANCH_MU
            AND.w #$FF00 : BEQ .BRANCH_NU ; WTF: what...?
                LDY.w #$00FF
                
                BRA .BRANCH_MU
                
            .BRANCH_NU
                
            LDY.w #$0000
        
        .BRANCH_MU
        
        TYA : AND.w #$00FF : XBA : ORA.b $06 : STA.b $06
        
        CPX.w #$01C0 : BCS .BRANCH_XI
            CMP.w #$FFFF : BNE .BRANCH_OMICRON
                LDA.w #$00FF
            
            .BRANCH_OMICRON
            
            STA.w $1B00, X
        
        .BRANCH_XI
        
        LDA.w $0674 : BMI .BRANCH_PI
            LDA.b $04
            
            CMP.w $0674 : BCC .BRANCH_RHO
            CMP.w $0676 : BCS .BRANCH_RHO
        
        .BRANCH_PI
        
        LDA.w $067A : AND.w #$00FF : DEC A : CLC : ADC.b $0E : TAX
        
        DEC A : ASL A : CMP.w #$01C0 : BCS .BRANCH_SIGMA
            TAX
            
            LDA.b $06 : CMP.w #$FFFF : BNE .BRANCH_TAU
                LDA.w #$00FF
            
            .BRANCH_TAU
            
            STA.w $1B00, X
        
        .BRANCH_SIGMA
        
        INC.w $067A
        
        .BRANCH_RHO
        
        INC.b $04 : LDA.b $04 : BMI .BRANCH_UPSILON
            CMP.w #$00E1 : BCS .BRANCH_EPSILON
        
        .BRANCH_UPSILON
    
    BRL .BRANCH_PHI
    
    .BRANCH_EPSILON
    
    SEP #$30
    
    LDA.b $B0 : CMP.b #$04 : BNE .BRANCH_CHI
        LDA.w $067E : CMP.b #$01 : BEQ .dont_check_button_input
            ; If the player hits any of the main buttons, praying time is over.
            LDA.b $F4 : ORA.b $F6 : AND.b #$C0 : BEQ .no_button_input
                LDA.b #$01 : STA.w $067E
                
                LSR.w $067C
            
            .no_button_input
        .dont_check_button_input
        
        LDA.w $067E : BEQ .dont_expand_spotlight
            LDA.w $067C : CLC : ADC.b #$08 : STA.w $067C
            CMP.b #$C0 : BCC .dont_open_barrier
                LDA.w $02F0 : EOR.b #$01 : STA.w $02F0
                
                ; Return music volume to full.
                LDA.b #$F3 : STA.w $012C
                
                ; Reset ambient sfx.
                LDA.b #$00 : STA.w $012D
                
                STZ.w $0FC1
                STZ.w $030A
                STZ.b $3A
                STZ.w $0308
                
                LDA.b $50 : AND.b #$FE : STA.b $50
                
                STZ.b $B0
                STZ.b $11
                
                LDA.w $010C : STA.b $10
                
                STZ.b $1E
                
                STZ.b $1F
                
                STZ.b $96
                STZ.b $97
                STZ.b $98
                
                JSL.l ResetSpotlightTable
                
                BRA .BRANCH_CHI
            
            .dont_open_barrier
        .dont_expand_spotlight
        
        DEC.b $3D : BPL .BRANCH_CHI
        
        LDX.w $030A : INX : CPX.b #$04 : BEQ .BRANCH_ALTIMA
            STX.w $030A
        
        .BRANCH_ALTIMA
        
        LDA.w $EA22, X : STA.b $3D
    
    .BRANCH_CHI
    
    PLB
    
    RTL
}

; ==============================================================================

; $03EBDA-$03ECDB DATA
Pool_DesertHDMA_CalculateIrisShapeLine:
{
    ; $03EBDA
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FE, $FE, $FE, $FE
    db $FD, $FD, $FD, $FD, $FC, $FC, $FC, $FB
    db $FB, $FB, $FA, $FA, $F9, $F9, $F8, $F8
    db $F7, $F7, $F6, $F6, $F5, $F5, $F4, $F3
    db $F3, $F2, $F1, $F1, $F0, $EF, $EE, $EE
    db $ED, $EC, $EB, $EA, $E9, $E9, $E8, $E7
    db $E6, $E5, $E4, $E3, $E2, $E1, $DF, $DE
    db $DD, $DC, $DB, $DA, $D8, $D7, $D6, $D5
    db $D3, $D2, $D0, $CF, $CD, $CC, $CA, $C9
    db $C7, $C6, $C4, $C2, $C1, $BF, $BD, $BB
    db $B9, $B7, $B6, $B4, $B1, $AF, $AD, $AB
    db $A9, $A7, $A4, $A2, $9F, $9D, $9A, $97
    db $95, $92, $8F, $8C, $89, $86, $82, $7F
    db $7B, $78, $74, $70, $6C, $67, $63, $5E
    db $59, $53, $4D, $46, $3F, $37, $2D, $1F
    db $00
    
    ; $03EC5B
    .multiplier_closed
    db $FF, $FF, $FF, $FF, $FF, $FF, $FE, $FE
    db $FD, $FD, $FC, $FC, $FB, $FA, $F9, $F8
    db $F7, $F6, $F5, $F4, $F3, $F1, $F0, $EE
    db $ED, $EB, $E9, $E8, $E6, $E4, $E2, $DF
    db $DD, $DB, $D8, $D6, $D3, $D0, $CD, $CA
    db $C7, $C4, $C1, $BD, $B9, $B6, $B1, $AD
    db $A9, $A4, $9F, $9A, $95, $8F, $89, $82
    db $7B, $74, $6C, $63, $59, $4D, $3F, $2D
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00
}

; ==============================================================================

; $03ECDC-$03ED2B LOCAL JUMP LOCATION
DesertHDMA_CalculateIrisShapeLine:
{
    ; ( table[ ( (A / B) / 2) ] * B) >> 8
    
    SEP #$30
    
    LDA.w $067A : STA.w SNES.DividendHigh
                  STZ.w SNES.DividendLow
    
    LDA.w $067C : STA.w SNES.DivisorB : NOP #6
    
    REP #$20
    
    LDA.w SNES.DivideResultQuotientLow : LSR A
    
    SEP #$20
    
    TAX
    
    LDY.w $EC5B, X
    
    LDA.w $067E : BEQ .contracting
        ; Use a different table if dilating.
        LDY.w $EBDA, X
    
    .contracting
    
    STY.b $06 : STY.w SNES.MultiplicandA
    
    LDA.w $067C : STA.w SNES.MultiplierB : NOP #4
    
    LDA.w SNES.RemainderResultHigh : STA.b $08
    
    STZ.b $09
    STZ.b $07
    
    REP #$30
    
    LDA.w $067E : AND.w #$00FF : BEQ .dont_double_result
        ; Double the result if dilating.
        ASL.b $08
    
    .dont_double_result
    
    RTS
}

; ==============================================================================

; $03ED2C-$03ED3E LOCAL JUMP LOCATION
FindFreeMovingBlockSlot:
{
    LDX.b #$01
    
    .prev_slot
    
        LDA.w $05FC, X : BNE .nonempty_slot
            TYA : INC A : STA.w $05FC, X
            
            CLC
            
            RTS
        
        .nonempty_slot
    DEX : BPL .prev_slot
    
    SEC
    
    RTS
}

; ==============================================================================

; $03ED3F-$03EDB4 LOCAL JUMP LOCATION
InitializePushBlock:
{
    PHX : STX.b $72
    
    LDA.b $0E : PHA
    
    REP #$20
    
    LDA.w $0540, X : AND.w #$007E : ASL #2 : STA.b $00
    LDA.w $0540, X : AND.w #$1F80 : LSR #4 : STA.b $02
    
    SEP #$20
    
    LDA.b $0E : ASL A : TAX
    
    LDA.b $00 : STA.w $05E4, X
    
    LDA.b $01 : CLC : ADC.w $062D : STA.w $05E0, X : STA.b $01
    
    LDA.b $02 : STA.w $05F0, X
    
    LDA.b $03 : CLC : ADC.w $062F : STA.w $05EC, X : STA.b $03
    
    STZ.w $05E8, X
    STZ.w $05F4, X
    
    LDA.b $AE : CMP.b #$26 : BEQ .BRANCH_ALPHA
        LDX.b $72
        
        LDA.w $0500, X : BNE .BRANCH_ALPHA
            LDY.b #$00
            
            ; $03D304 IN ROM
            JSR.w $D304 : BCC .BRANCH_BETA
        
    .BRANCH_ALPHA
    
    PLA : TAX
    
    STZ.w $05FC, X
    
    PLX
    
    SEC
    
    RTS
    
    .BRANCH_BETA
    
    ; Dragging noise? (Block moving?)
    LDA.b #$22 : JSR.w Player_DoSfx2
    
    PLA : STA.b $0E
    
    PLX
    
    LDA.b #$01 : STA.w $0500, X
    
    CLC
    
    RTS
}

; ==============================================================================

; Input parameters: Y
; $03EDB5-$03EDF3 LONG JUMP LOCATION
PushBlock_Slide:
{
    SEP #$30
    
    PHB : PHK : PLB
    
    LDA.b $11 : BNE .return
        STY.b $00
        
        LDX.b #$01
        
        LDA.w $05FC, X : DEC A : ASL A : CMP.b $00 : BEQ .correct_index
            ; Otherwise, assume the slot indicates the object we're interested
            ; in.
            LDX.b #$00
        
        .correct_index
        
        TXA : ASL A : TAY
        
        LDA.b #$09 : STA.w $02C4 : STZ.w $02C3
        
        JSR.w $EE35 ; $03EE35 IN ROM
        
        LDA.w $05F0, Y : STA.b $72
        LDA.w $05EC, Y : STA.b $73
        
        LDA.w $05E4, Y : STA.b $74
        LDA.w $05E0, Y : STA.b $75
        
        JSR.w $EFB9 ; $03EFB9 IN ROM
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $03EDF4-$03EDF8
Pool_PushBlock_HandleFalling:
{
    .fall_timer
    db $09, $09, $09, $09, $09
}

; Appears to be involved with push blocks or falling push blocks.
; $03EDF9-$03EE2F LONG JUMP LOCATION
PushBlock_HandleFalling:
{
    SEP #$30
    
    PHB : PHK : PLB : PHY
    
    STY.b $0E
    
    DEC.w $02C4 : BPL .not_finished
        INC.w $02C3 : LDX.w $02C3
        
        LDA.w $EDF4, X : STA.w $02C4
        
        CPX.b #$04 : BNE .not_finished
            TYX
            
            STZ.w $0500, X
            STZ.w $02C3
            
            LDX.b #$01
            
            LDA.w $05FC, X : DEC A : ASL A : CMP.b $0E : BEQ .correct_index
                LDX.b #$00
            
            .correct_index
            
            STZ.w $05FC, X
    
    .not_finished
    
    PLY : PLB
    
    RTL
}

; ==============================================================================

; $03EE30-$03EE34 DATA
Pool_PushBlock_ApplyVelocity:
{
    ; $03EE30
    .block_speed
    db $0C

    ; $03EE31
    .direction_mask
    db $08, $04, $02, $01
}

; ==============================================================================

; $03EE35-$03EF60 LOCAL JUMP LOCATION
PushBlock_ApplyVelocity:
{
    STZ.b $27
    STZ.b $28
    
    LDA.w $EE30 : STA.b $0A : STA.b $0B
    
    LDA.b #$03 : STA.b $0C
    LDA.b #$02 : STA.b $0D
    
    LDA.w $05F8, Y : LSR A : TAX
    
    LDA.w $EE31, X : STA.b $00
    
    LDX.b #$01
    
    .BRANCH_LAMBDA
    
        LDA.b $00
        
        AND.b $0C : BEQ .BRANCH_ALPHA
            AND.b $0D : BEQ .BRANCH_BETA
                LDA.b $0A, X : EOR.b #$FF : INC A : STA.b $0A, X
            
            .BRANCH_BETA
            
            LDA.b $0A, X : STA.b $27, X
            
            BRA .BRANCH_GAMMA
        
        .BRANCH_ALPHA
        
        ASL.b $0C : ASL.b $0C
        ASL.b $0D : ASL.b $0D
    DEX : BPL .BRANCH_LAMBDA
    
    .BRANCH_GAMMA
    
    LDA.b $27, X : ASL #4 : CLC : ADC.w $05F4, Y : STA.w $05F4, Y
    
    PHP
    
    CPX.b #$01 : BEQ .BRANCH_DELTA
        LDX.b #$00
        
        LDA.b $27 : LSR #4 : CMP.b #$08 : BCC .BRANCH_EPSILON
            ORA.b #$F0
            
            LDX.b #$FF
        
        .BRANCH_EPSILON
        
        PLP
        
              ADC.w $05F0, Y : STA.w $05F0, Y
        TXA : ADC.w $05EC, Y : STA.w $05EC, Y
        
        LDA.w $05F0, Y : AND.b #$0F
        
        BRA .BRANCH_ZETA
    
    .BRANCH_DELTA
    
    LDX.b #$00
    
    LDA.b $28 : LSR #4 : CMP.b #$08 : BCC .BRANCH_MU
        ORA.b #$F0
        
        LDX.b #$FF
    
    .BRANCH_MU
    
    PLP
    
          ADC.w $05E4, Y : STA.w $05E4, Y
    TXA : ADC.w $05E0, Y : STA.w $05E0, Y
    
    LDA.w $05E4, Y : AND.b #$0F
    
    .BRANCH_ZETA
    
    TYX
    
    CMP.w $05E8, X : BNE .BRANCH_THETA
        TXA : LSR A : TAX
        
        LDA.w $05FC, X : DEC A : ASL A : TAX
        
        INC.w $0500, X
        
        LDA.b $50 : AND.b #$FB : STA.b $50
        LDA.b $48 : AND.b #$FB : STA.b $48
    
    .BRANCH_THETA
    
    SEP #$20
    
    LDA.w $05E4, Y : STA.b $00
    LDA.w $05E0, Y : STA.b $01
    
    LDA.w $05F0, Y : STA.b $02
    LDA.w $05EC, Y : STA.b $03
    
    PHX
    
    LDX.b #$0F
    
    .BRANCH_KAPPA
    
        LDA.w $0DD0, X : CMP.b #$09 : BCC .BRANCH_IOTA
            LDA.w $0D10, X : STA.b $04
            LDA.w $0D30, X : STA.b $05
            
            LDA.w $0D00, X : STA.b $06
            LDA.w $0D20, X : STA.b $07
            
            REP #$20
            
            LDA.b $00 : SEC : SBC.b $04 : CLC : ADC.w #$0010 : CMP.w #$0020 : BCS .BRANCH_IOTA
                LDA.b $02 : SEC : SBC.b $06 : CLC : ADC.w #$0010 : CMP.w #$0020 : BCS .BRANCH_IOTA
                    SEP #$20
                    
                    LDA.b #$08 : STA.w $0EA0, X
                    
                    PHY
                    
                    LDA.w $05F8, Y : LSR A : TAY
                    
                    ; Push the sprite because a pushable block is colliding
                    ; with it?
                    LDA.w Pool_PushBlock_ApplyVelocity_recoil_x, Y : STA.w $0F40, X
                    LDA.w Pool_PushBlock_ApplyVelocity_recoil_y, Y : STA.w $0F30, X
                    
                    PLY
            
        .BRANCH_IOTA
        
        SEP #$20
    DEX : BPL .BRANCH_KAPPA
    
    PLX
    
    RTS
}


; $03EF61-$03EFB8 DATA
Pool_PushBlock_ApplyVelocity:
{
    ; $03EF61
    .recoil_x
    db   0 ; Up
    db   0 ; Down
    db -32 ; Left
    db  32 ; Right

    ; $03EF65
    .recoil_y
    db -32 ; Up
    db  32 ; Down
    db   0 ; Left
    db   0 ; Right
}

; ==============================================================================

; $03EF69-$03EFB9 DATA
Pool_PushBlock_HandleCollision:
{
    ; $03EF69
    .link_offset_on_axis
    dw $0008 ; Up
    dw $0018 ; Down
    dw $0000 ; Left
    dw $0010 ; Right

    ; $03EF71
    .link_offset_perpendicular_bottom
    dw $0000 ; Up
    dw $0000 ; Down
    dw $0008 ; Left
    dw $0008 ; Right

    ; $03EF79
    .link_offset_perpendicular_top
    dw $000F ; Up
    dw $000F ; Down
    dw $0017 ; Left
    dw $0017 ; Right

    ; $03EF81
    .block_offset_on_axis
    dw $000F ; Up
    dw $0000 ; Down
    dw $000F ; Left
    dw $0000 ; Right

    ; $03EF89
    .block_offset_perpendicular_bottom
    dw $0000 ; Up
    dw $0000 ; Down
    dw $0000 ; Left
    dw $0000 ; Right

    ; $03EF91
    .block_offset_perpendicular_top
    dw $000F ; Up
    dw $000F ; Down
    dw $000F ; Left
    dw $000F ; Right

    ; $03EF99
    .link_coord_address_on_axis
    dw $0020 ; Up
    dw $0020 ; Down
    dw $0022 ; Left
    dw $0022 ; Right

    ; $03EFA1
    .link_coord_address_perpendicular
    dw $0022 ; Up
    dw $0022 ; Down
    dw $0020 ; Left
    dw $0020 ; Right

    ; $03EFA9
    .block_coords_address_on_axis
    dw $0072 ; Up
    dw $0072 ; Down
    dw $0074 ; Left
    dw $0074 ; Right

    ; $03EFB1
    .block_coords_address_perpendicular
    dw $0074 ; Up
    dw $0074 ; Down
    dw $0072 ; Left
    dw $0072 ; Right
}

; $03EFB9-$03F0AB LOCAL JUMP LOCATION
PushBlock_HandleCollision:
{
    PHY
    
    STY.b $0E
    
    STZ.b $0F
    
    LDA.b $21 : STA.b $40
    LDA.b $23 : STA.b $41
    
    REP #$20
    
    LDA.b $67 : AND.b #$000F
    
    LDY.b #$06
    
    .BRANCH_BETA
    
        LSR A : BCS .BRANCH_ALPHA
    DEY #2 : BPL .BRANCH_BETA
    
    BRL .BRANCH_GAMMA
    
    .BRANCH_ALPHA
    
    LDA.b $0E : PHA
    
    LDA.w $EFA1, Y : STA.b $0C
    LDA.w $EFB1, Y : STA.b $0E
    
    LDA ($0C) : CLC : ADC.w $EF71, Y : STA.b $00
    LDA ($0C) : CLC : ADC.w $EF79, Y : STA.b $02
    LDA ($0E) : CLC : ADC.w $EF89, Y : STA.b $04
    LDA ($0E) : CLC : ADC.w $EF91, Y : STA.b $06
    
    LDA.w $EF99, Y : STA.b $0C
    LDA.w $EFA9, Y : STA.b $0E
    
    LDA ($0C) : CLC : ADC.w $EF69, Y : STA.b $08
    LDA ($0E) : CLC : ADC.w $EF81, Y : STA.b $0A
    
    LDA.b $48 : AND.w #$FFFB : STA.b $48
    
    PLA : STA.b $0E
    
    LDA.b $00
    
    CMP.b $04 : BCC .BRANCH_DELTA
        CMP.b $06 : BCC .BRANCH_EPSILON

    .BRANCH_DELTA

    LDA.b $02
    
    CMP.b $04 : BCC .BRANCH_GAMMA
    CMP.b $06 : BCS .BRANCH_GAMMA
        .BRANCH_EPSILON

        PHY : PHX
        
        LDX.b $0E
        
        LDA.b $2F : AND.w #$00FF : CMP.w $05F8, X : BNE .BRANCH_ZETA
            LDY.b #$01
            
            TXA : LSR A : TAX
            
            LDA.w $05FC, X : BEQ .BRANCH_THETA
                LDY.b #$04
            
            .BRANCH_THETA
            
            TYA : AND.w #$00FF : TSB.b $48
        
        .BRANCH_ZETA
        
        PLX : PLY
        
        TYA : AND.w #$0002 : BEQ .BRANCH_IOTA
            LDA.b $08
            
            SEC : SBC.b $0A : BCC .BRANCH_GAMMA
            CMP.w #$0008 : BCS .BRANCH_GAMMA
                EOR.w #$FFFF : INC A : STA.b $00
                
                CLC : ADC ($0C) : STA ($0C)
                
                BRA .BRANCH_KAPPA

        .BRANCH_IOTA

        LDA.b $08 : SEC : SBC.b $0A : CMP.w #$FFF8 : BCC .BRANCH_GAMMA
            EOR.w #$FFFF : INC A : STA.b $00
            
            CLC : ADC ($0C) : STA ($0C)
            
            .BRANCH_KAPPA
            
            SEP #$20
            
            LDX.b #$00
            
            TYA : AND.b #$04 : BEQ .BRANCH_LAMBDA
                INX
            
            .BRANCH_LAMBDA
            
            LDA.b $30, X : CLC : ADC.b $00 : STA.b $30, X
    
    .BRANCH_GAMMA
    
    SEP #$20
    
    JSR.w HandleIndoorCameraAndDoors
    
    PLY
    
    RTS
}

; ==============================================================================

; Handles animation of moveable blocks and such.
; $03F0AC-$03F0CA LONG JUMP LOCATION
Underworld_DrawAllPushBlocks:
{
    PHB : PHK : PLB
    
    LDA.w $05FC : ORA.w $05FD : BEQ .return
        LDX.b #$01
        
        .next_slot
        
            LDA.w $05FC, X : BEQ .empty_slot
                TXA : ASL A : TAY
                
                PHX
                
                JSR.w Underworld_DrawSinglePushBlock
                
                PLX
            
            .empty_slot
        DEX : BPL .next_slot
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F0CB-$03F0D8
Pool_Underworld_DrawSinglePushBlock:
{
    ; $03F0CB
    .unreachable
    db $0C

    ; $03F0CC
    .step
    db  12,  12,  12, $FF

    ; $03F0D0
    .index
    db   0,   1,   2,   3
    db   4,   0,   0,   0
    db   0
}

; Appears to draw moving blocks or falling moving blocks or both.
; $03F0D9-$03F13B LOCAL JUMP LOCATION
Underworld_DrawSinglePushBlock:
{
    PHY
    
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionB
    
    PLY
    
    LDA.w $05F0, Y : STA.b $00
    LDA.w $05EC, Y : STA.b $01
    
    LDA.w $05E4, Y : STA.b $02
    LDA.w $05E0, Y : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $E8 : DEC A : STA.b $00
    
    LDA.b $02 : SEC : SBC.b $E2 : STA.b $02
    
    SEP #$20
    
    PHY
    
    LDY.w $02C3
    
    LDA.w $F0D0, Y : TAX
    
    LDY.b #$00
    
    LDA.w $F0CC, X : CMP.b #$FF : BNE .alpha
        BRA .beta
    
    .alpha
    
    ; The upper accumulator holds the sprite chr.
    XBA
    
    ; Write sprite's X coordinate.
    LDA.b $02 : STA ($90), Y : INY
    
    ; Write sprite's Y coordinate.
    LDA.b $00 : STA ($90), Y : INY
    
    ; Swap in the upper accumulator, write sprite's chr.
    XBA : STA ($90), Y : INY
    
    ; Write sprite's properties.
    LDA.b #$20 : STA ($90), Y : INY
    
    TYA : SEC : SBC.b $04 : LSR #2 : TAY
    
    ; Write data to extended OAM portion.
    LDA.b #$02 : STA ($92), Y
    
    .beta
    
    PLY
    
    RTS
}

; ==============================================================================

; $03F13C-$03F1A2 LONG JUMP LOCATION
Init_Player:
{
    PHB : PHK : PLB
    
    ; This routine basically initializes Link.
    ; Make Link face down initially.
    LDA.b #$02 : STA.b $2F
    
    STZ.b $26   ; Link has no push state.
    STZ.w $0301
    STZ.w $037A
    STZ.w $020B
    STZ.w $0350
    STZ.w $030D
    STZ.w $030E
    STZ.w $030A
    STZ.w $02E1
    STZ.b $3B   ; No A button.
    
    ; Zero out all except for the B button.
    LDA.b $3A : AND.b #$BF : STA.b $3A
    
    STZ.w $0308
    STZ.w $0309
    STZ.w $0376
    
    JSL.l Player_ResetSwimState

    LDA.b $50 : AND.b #$FE : STA.b $50
    
    STZ.b $25
    STZ.b $4D
    STZ.b $46
    STZ.w $031F
    STZ.w $0360
    STZ.w $02DA
    STZ.b $55
    
    JSR.w Link_ForceUnequipCape_quietly ; More init...
    JSR.w Link_ResetSwordAndItemUsage
    
    STZ.w $037B
    STZ.w $0300
    
    LDA.b $67 : AND.b #$F0 : STA.b $67
    
    STZ.w $02F2
    STZ.w $0079
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F1A3-$03F1E5 LONG JUMP LOCATION
Player_ResetState:
{
    STZ.b $26
    STZ.b $67
    STZ.w $031F
    STZ.w $034A
    
    JSL.l Player_ResetSwimState
    
    STZ.w $02E1
    STZ.w $031F
    STZ.w $03DB
    STZ.w $02E0
    STZ.b $56
    STZ.w $03F5
    STZ.w $03F7
    STZ.w $03FC
    STZ.w $03F8
    STZ.w $03FA
    STZ.w $03E9
    STZ.w $0373
    STZ.w $031E
    STZ.w $02F2
    STZ.w $02F8
    STZ.w $02FA
    STZ.w $02E9
    STZ.w $02DB

    ; Bleeds into the next function.
}

; Called by mirror warping.
; $03F1E6-$03F1F9 LONG JUMP LOCATION
Link_ResetProperties_B:
{
    STZ.w $02F5
    STZ.w $0079
    STZ.w $0302
    STZ.w $02F4
    STZ.b $48
    STZ.b $5A
    STZ.b $5B
    
    ; WTF: Why zeroed twice? probably a typo on the programmer's end.
    ; Or maybe it was aliased to two different names...
    STZ.b $5B

    ; Bleeds into the next function.
}

; Called by some odd balls.
; $03F1FA-$03F259 LONG JUMP LOCATION
Link_ResetProperties_C:
{
    STZ.w $036C
    STZ.w $031C
    STZ.w $031D
    STZ.w $0315
    STZ.w $03EF
    STZ.w $02E3
    STZ.w $02F6
    STZ.w $0301
    STZ.w $037A
    STZ.w $020B
    STZ.w $0350
    STZ.w $030D
    STZ.w $030E
    STZ.w $030A
    STZ.b $3B
    STZ.b $3A
    STZ.b $3C
    STZ.w $0308
    STZ.w $0309
    STZ.w $0376
    STZ.b $50
    STZ.b $4D
    STZ.b $46
    STZ.w $0360
    STZ.w $02DA
    STZ.b $55
    
    JSR.w Link_ResetSwordAndItemUsage
    
    STZ.w $037B
    STZ.w $0300
    STZ.w $037E
    STZ.w $02EC
    STZ.w $0314
    STZ.w $03F8
    STZ.w $02FA
    
    RTL
}

; ==============================================================================

; $03F25A-$03F2C0 LONG JUMP LOCATION
Link_AnimateIntraStairClimbAndSFX:
{ 
    PHB : PHK : PLB
    
    LDX.b #$09
    
    .next_slot
    
        ; Search for Master sword charged sparkle?
        LDA.w $0C4A, X : CMP.b #$0D : BNE .not_fully_charged_sword_spark
            STZ.w $0C4A, X
        
        .not_fully_charged_sword_spark
    DEX : BPL .next_slot
    
    LDA.b $2E : CMP.b #$05 : BCC .dont_reset_counter
        STZ.b $2E
    
    .dont_reset_counter
    
    STZ.b $2A
    
    STZ.b $2B
    
    STZ.w $030A
    
    LDA.b #$1C : STA.w $0371
    
    LDA.b #$20 : STA.w $0378
    
    LDA.b #$01 : STA.w $037B
    
    LDA.w $0462 : AND.b #$04 : BEQ .delta
        LDA.b #$18 : JSR.w Player_DoSfx2
        
        BRA .epsilon
    
    .delta
    
    LDA.b #$16 : JSR.w Player_DoSfx2
    
    .epsilon
    
    STZ.b $01
    
    LDX.b #16
    
    LDA.w $0462 : AND.b #$04 : BEQ .zeta
        LDX.b #$F1
        LDA.b #$FF : STA.b $01
    
    .zeta
    
    STX.b $00
    
    REP #$20
    
    ; Adjust X coordinate.... what?
    LDA.b $22 : CLC : ADC.b $00 : STA.b $53
    
    LDA.b $20 : STA.b $51
    
    SEP #$20
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F2C1-$03F390 LONG JUMP LOCATION
HandleLinkOnSpiralStairs:
{
    REP #$20
    
    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4
    
    SEP #$20
    
    LDA.w $030A : BEQ .BRANCH_ALPHA
        RTL
    
    .BRANCH_ALPHA
    
    STZ.w $0373
    STZ.b $46
    STZ.b $4D
    
    PHB : PHK : PLB
    
    LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_GAMMA
        LDA.b #$FE : STA.b $27
        
        DEC.w $0371 : BPL .BRANCH_BETA
            STZ.w $0371
            
            LDA.b #0 : STA.b $27
            
            LDA.b #-2 : STA.b $28
        
        .BRANCH_BETA
        
        BRA .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    LDA.b #-2 : STA.b $27
    
    DEC.w $0371 : BPL .BRANCH_DELTA
        STZ.w $0371
        
        LDA.b #-2 : STA.b $27
        
        LDA.b #2 : STA.b $28
    
    .BRANCH_DELTA
    
    JSL.l LinkHop_FindArbitraryLandingSpot
    JSL.l Link_HandleMovingAnimation_StartWithDash
    
    LDA.w $0371 : BNE .BRANCH_ZETA
        DEC.w $0378 : BPL .BRANCH_ZETA
            STZ.w $0378
            
            LDX.b #$04
            
            LDA.w $0462 : AND.b #$04 : BNE .BRANCH_EPSILON
                LDX.b #$06
            
            .BRANCH_EPSILON
            
            STX.b $2F
    
    .BRANCH_ZETA
    
    LDA.b $22 : SEC : SBC.b $53 : BPL .BRANCH_THETA
        EOR.b #$FF : INC A
    
    .BRANCH_THETA
    
    BNE .BRANCH_MU
    
    REP #$20
    
    JSL.l $02921A ; $01121A IN ROM
    
    SEP #$20
    
    LDA.l $7EF3CC : BEQ .BRANCH_IOTA
        JSL.l Tagalong_Init
    
    .BRANCH_IOTA
    
    LDA.b #-8 : STA.b $00
    LDA.b #-1 : STA.b $01
    
    LDA.w $0462 : AND.b #$04 : BNE .BRANCH_KAPPA
        LDA.b #$0C : STA.b $00
                     STZ.b $01
    
    .BRANCH_KAPPA
    
    REP #$20
    
    LDA.b $22 : CLC : ADC.b $00 : STA.b $53
    
    SEP #$20
    
    LDA.b #$01 : STA.w $030A
    
    LDA.b #$06 : STA.w $0378
    
    ; See if this is a downward staircase.
    LDA.w $0462 : AND.b #$04 : BNE .BRANCH_LAMBDA
        ; Yes...
        
        LDA.b #$17 ; Play the up staircase sound.
        
        JSR.w $8028 ; Play a sound (maybe the staircase steps sound?)
        
        BRA .BRANCH_MU
    
    .BRANCH_LAMBDA ; Yep, downward staircase.
    
    LDA.b #$19
    
    JSR.w $8028 ; Play a sound (also a staircase step sound presumably).
    
    .BRANCH_MU
    
    SEP #$20
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F391-$03F3F2 LONG JUMP LOCATION
SpiralStairs_FindLandingSpot:
{
    PHB : PHK : PLB
    
    STZ.w $0373
    STZ.b $46
    STZ.b $4D
    STZ.w $037B
    
    REP #$20
    
    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4
    
    SEP #$20
    
    DEC.w $0378 : BPL .BRANCH_ALPHA
        STZ.w $0378
        
        ; Force player to look down after an amount of time?
        LDA.b #$02 : STA.b $2F
    
    .BRANCH_ALPHA
    
    LDA.b #0 : STA.b $27
    
    LDA.b #4 : STA.b $28
    
    LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_BETA
        LDA.b #2 : STA.b $27
        
        LDA.b #-4 : STA.b $28
    
    .BRANCH_BETA
    
    LDA.w $030A : CMP.b #$02 : BNE .BRANCH_GAMMA
        LDA.b #16 : STA.b $27
        
        STZ.b $28
        
    .BRANCH_GAMMA
    
    JSL.l LinkHop_FindArbitraryLandingSpot
    JSL.l Link_HandleMovingAnimation_StartWithDash
    
    LDA.b $22 : CMP.b $53 : BNE .BRANCH_DELTA
        LDA.b #$02 : STA.w $030A
    
    .BRANCH_DELTA
    
    SEP #$20
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F3F3-$03F3FC LONG JUMP LOCATION
LinkResetPushTimer:
{
    ; It apparently has something to do with staircases, possibly spiral
    ; staircases in particular.
    
    ; OPTIMIZE: Setting B register unnecessary. In fact, this whole call
    ; could probably just be inlined at the call site, unless they can't
    ; spare an extra byte at the site.
    PHB : PHK : PLB
    
    LDA.b #$07 : STA.w $0371
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F3FD-$03F42E LONG JUMP LOCATION
UNREACHABLE_07F3FD:
{
    ; TODO: What would it be for, though? Looks like staircases. Hard to say
    ; if it's just unfinished / broken or if uninteresting...
    
    PHB : PHK : PLB
    
    REP #$20
    
    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4
    
    SEP #$20
    
    STZ.b $28
    
    LDY.b #$08
    
    LDA.b $11 : CMP.b #$12 : BNE .alpha
        LDY.b #$FE
        
        LDA.w $0462 : AND.b #$04 : BEQ .alpha
            LDY.b #$FA
    
    .alpha
    
    STY.b $27
    
    JSL.l LinkHop_FindArbitraryLandingSpot
    JSL.l Link_HandleMovingAnimation_StartWithDash
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F42F-$03F438 LONG JUMP LOCATION
HandleIndoorCameraAndDoors_long:
{
    PHB : PHK : PLB
    
    PHX
    
    JSR.w HandleIndoorCameraAndDoors
    
    PLX : PLB
    
    RTL
}

; ==============================================================================

; $03F439-$03F46E LONG JUMP LOCATION
Player_IsScreenTransitionPermitted:
{
    PHB : PHK : PLB
    
    LDA.b $5D
    
    CMP.b #$03 : BEQ .takeNoAction
    CMP.b #$08 : BEQ .takeNoAction
    CMP.b #$09 : BEQ .takeNoAction
    CMP.b #$0A : BEQ .takeNoAction
        ; Is Link recovering from being damaged / bounced back?
        LDA.b $46 : BEQ .actionIsPermitted
    
    .takeNoAction
    
    STZ.b $27
    STZ.b $28
    
    LDA.b #$03 : STA.w $02C6
    
    REP #$20
    
    LDA.w $0FC2 : STA.b $22
    LDA.w $0FC4 : STA.b $20
    
    SEP #$20
    
    SEC
    
    PLB
    
    RTL
    
    .actionIsPermitted
    
    CLC
    
    PLB
    
    RTL
}

; ==============================================================================

; $03F46F-$03F49B LONG JUMP LOCATION
Tagalong_CanWeDisplayMessage:
{
    ; Is link in his basic game state?
    LDA.b $5D
    
    CMP.b #$00 : BEQ .affirmative
    CMP.b #$04 : BEQ .affirmative
        CMP.b #$11 : BNE .negative
    
    .affirmative
    
    ; If the player has a sword and holds B.
    LDA.b $3A : AND.b #$80
    
    ORA.w $0377 ; Don't know.
    ORA.w $0301 ; Player is using Ice/Fire Rod, Hammer 
    ORA.w $037A ; Link is an odd position. (praying, etc)
    ORA.w $02EC ; Don't know.
    ORA.w $0314 ; Don't know.
    ORA.w $0308 ; Player is holding a pot.
    ORA.w $0376 ; Bit 0: Holding a wall. Bit 1: ????
    
    BNE .negative
        SEC ; Indicates TRUE
        
        RTL
    
    .negative
    
    CLC ; Indicates FALSE.
    
    RTL
}

; ==============================================================================

; $03F49C-$03F4CF LONG JUMP LOCATION
Player_ApproachTriforce:
{
    ; OPTIMIZE: No local data is used, so we don't have to do this.
    PHB : PHK : PLB
    
    LDA.b $20 : CMP.b #$98 : BCC .at_triforce_position
        CMP.b #$A9 : BCS .not_on_stairs
            ; Use slower movement for player because they're moving on stairs.
            ; Or rather, this simulates moving on stairs.
            LDA.b #$14 : STA.b $5E
        
        .not_on_stairs
        
        LDA.b #$08 : STA.b $67
                    STA.b $26
        
        STZ.b $2F
        
        LDA.b #$40 : STA.b $3D
        
        BRA .return
    
    .at_triforce_position
    
    STZ.b $2E
    STZ.b $67
    STZ.b $26
    
    DEC.b $3D
    
    ; OPTIMIZE: The decrement instruction above already sets flags, so
    ; no need to load this var here.
    LDA.b $3D : BNE .delay_triforce_hold
        LDA.b #$02 : STA.w $02DA
        
        INC.b $B0
    
    .delay_triforce_hold
    .return

    PLB
    
    RTL
}

; ==============================================================================

; $03F4D0-$03F4F0 LONG JUMP LOCATION
Sprite_CheckIfPlayerPreoccupied:
{
    PHX
    
    LDA.b $4D : ORA.w $02DA : BNE .fail
        LDA.w $0308 : AND.b #$80 : BNE .fail
            LDX.b #$04
            
            .next_object
            
                ; Check to see if a the flute bird is in play. If it is, return
                ; failure.
                LDA.w $0C4A, X : CMP.b #$27 : BEQ .fail
            DEX : BPL .next_object
            
            ; Success.
            PLX
            
            CLC
            
            RTL
    
    .fail
    
    ; Failure.
    PLX
    
    SEC
    
    RTL
}

; ==============================================================================

; $03F4F1-$03F513 LONG JUMP LOCATION
Player_IsPipeEnterable:
{
    LDX.b #$04
    
    .next_slot
    
        LDA.w $0C4A, X : CMP.b #$31 : BNE .not_byrna_ancilla
            STZ.w $037A
            STZ.b $50
            STZ.w $0C4A, X
            
            BRA .byrna_ancilla_terminated
        
        .not_byrna_ancilla
    DEX : BPL .next_slot
    
    .byrna_ancilla_terminated
    
    LDA.w $0308 : AND.b #$80 : ORA.b $4D : BNE .in_special_state
        CLC
        
        RTL
    
    .in_special_state
    
    SEC
    
    RTL
}

; ==============================================================================

; $03F514-$03F51C LOCAL JUMP LOCATION
CacheCameraPropertiesIfOutdoors:
{
    LDA.b $1B : BNE .indoors
        ; TODO: Find out why you'd only do this when outdoors...
        
        ; Caches a bunch of gameplay vars. I don't know why this is necessary
        ; during gameplay because this routine is surely time consuming.
        JSL.l Player_CacheStatePriorToHandler
    
    .indoors
    
    RTS
}
   
; ==============================================================================

; $03F51D-$03F61C
Overworld_SignText:
{
    dw $00A7, $00A7, $0048, $0040, $0040, $00A7, $00A7, $00A7
    dw $00A7, $00A7, $003C, $0040, $0040, $00A7, $00A7, $003E
    dw $003D, $0049, $0042, $0042, $00A7, $00A7, $003F, $00B0
    dw $003B, $003B, $00A7, $003B, $003B, $0044, $00A7, $00A7
    dw $003B, $003B, $00A7, $003B, $003B, $0045, $00A7, $00A7
    dw $00A7, $00A7, $00A7, $00A7, $00A7, $0041, $00A7, $00A7
    dw $00A7, $00A7, $00A7, $0042, $00A7, $0046, $0046, $00A7
    dw $00A7, $00A7, $0047, $0043, $00A7, $0046, $0046, $00A7

    dw $00A7, $00A7, $00A7, $00A7, $00A7, $00A7, $00A7, $00A7
    dw $00A7, $00A7, $00A8, $00A7, $00A7, $00A7, $00A7, $00A9
    dw $00A7, $00AA, $00AB, $00A7, $00A7, $00A7, $00A7, $00B1
    dw $00AF, $00AF, $00A7, $00A7, $00A7, $00A7, $00A7, $00A7
    dw $00AF, $00AF, $00A7, $00A7, $00A7, $00AC, $00A7, $00A7
    dw $00A7, $00A7, $00A7, $00A7, $00A7, $00AD, $00A7, $00A7
    dw $00A7, $00A7, $00A7, $00A7, $00A7, $00A7, $00A7, $00A7
    dw $00A7, $00A7, $00A7, $00AE, $00A7, $00A7, $00A7, $00A7
}

; ==============================================================================

; $03F61D-$03F89C
Dungeon_SignText:
{
    dw $00B4, $00B4, $00B4, $00C7, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00C4, $00B4
    dw $00BE, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B5
    dw $00B9, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00C5, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00BF, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B9, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00BA, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00BF, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00C0, $00B4, $00B4, $00B4, $00C6
    dw $00B4, $00B4, $00B4, $00B4, $00C0, $00B4, $00C2, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00BB
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00C1, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00C3, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00C3, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B8, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B5, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $0179, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
    dw $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4, $00B4
}

; ==============================================================================

; $03F89D-$03FFFF NULL (Can be used for expansion)
NULL_07F89D:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF
}
    
; ==============================================================================

warnpc $088000
