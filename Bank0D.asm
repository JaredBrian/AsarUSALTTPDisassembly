; ==============================================================================

; Bank 0D
; $068000-$06FFFF
org $0D8000

; ==============================================================================

incsrc "player_oam.asm"

; ==============================================================================

; $06AFDD-$06B07F NULL
NULL_0DAFDD:
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
    db $FF, $FF, $FF
}

; ==============================================================================

incsrc "sprite_properties.asm"

; ==============================================================================

; $06BA71-$06BA7F LONG JUMP LOCATION
GetRandomInt:
{
    ; Interesting to note two consecutive reads from differing locations.
    ; What this first read does is latch a hardware register
    ; (v or hcount, I can't remember)
    ; Reading this "latch" places a value in $213C. 
    
    LDA.w $2137
    
    ; The purpose of this routine is to generate a random
    ; Number, of course. Number = counter + frame counter + $0FA1 which is
    ; apparently an accumulator.
    
    ; Contributing to the chaos is that all adds are done without regard to
    ; the state of the carry. It's probably not a well distributed random
    ; number generator but I'm sure it gets the job done most of the time.
    LDA.w $213C : ADC.b $1A : ADC.w $0FA1 : STA.w $0FA1
    
    RTL
}

; ==============================================================================

incsrc "sprite_oam_allocation.asm"
incsrc "sound_sfx.asm"

; ==============================================================================

; $06BBE0-$06BD1F DATA
pool_Babusu_Draw:
{
    .oam_groups
    dw  0,  4 : db $80, $43, $00, $00
    dw  0,  4 : db $80, $43, $00, $00
    
    dw  0,  4 : db $B6, $43, $00, $00
    dw  0,  4 : db $B6, $43, $00, $00
    
    dw  0,  4 : db $B7, $43, $00, $00
    dw  8,  4 : db $80, $03, $00, $00
    
    dw  0,  4 : db $80, $43, $00, $00
    dw  8,  4 : db $B6, $03, $00, $00
    
    dw  8,  4 : db $B7, $03, $00, $00
    dw  8,  4 : db $B7, $03, $00, $00
    
    dw  8,  4 : db $80, $03, $00, $00
    dw  8,  4 : db $80, $03, $00, $00
    
    dw  4,  0 : db $80, $83, $00, $00
    dw  4,  0 : db $80, $83, $00, $00
    
    dw  4,  0 : db $B6, $83, $00, $00
    dw  4,  0 : db $B6, $83, $00, $00
    
    dw  4,  0 : db $B7, $83, $00, $00
    dw  4,  8 : db $80, $03, $00, $00
    
    dw  4,  0 : db $80, $83, $00, $00
    dw  4,  8 : db $B6, $03, $00, $00
    
    dw  4,  8 : db $B7, $03, $00, $00
    dw  4,  8 : db $B7, $03, $00, $00
    
    dw  4,  8 : db $80, $03, $00, $00
    dw  4,  8 : db $80, $03, $00, $00
    
    dw  0, -8 : db $4E, $0A, $00, $02
    dw  0,  0 : db $5E, $0A, $00, $02
    
    dw  0, -8 : db $4E, $4A, $00, $02
    dw  0,  0 : db $5E, $4A, $00, $02
    
    dw  8,  0 : db $6C, $0A, $00, $02
    dw  0,  0 : db $6B, $0A, $00, $02
    
    dw  8,  0 : db $6C, $8A, $00, $02
    dw  0,  0 : db $6B, $8A, $00, $02
    
    dw  0,  8 : db $4E, $8A, $00, $02
    dw  0,  0 : db $5E, $8A, $00, $02
    
    dw  0,  8 : db $4E, $CA, $00, $02
    dw  0,  0 : db $5E, $CA, $00, $02
    
    dw -8,  0 : db $6C, $4A, $00, $02
    dw  0,  0 : db $6B, $4A, $00, $02
    
    dw -8,  0 : db $6C, $CA, $00, $02
    dw  0,  0 : db $6B, $CA, $00, $02   
}

; ==============================================================================

; $06BD20-$06BD45 LONG JUMP LOCATION
Babusu_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : BMI .invalid_animation_state
        REP #$20
        
        ASL #4 : ADC.w #(.oam_groups) : STA.b $08
        
        SEP #$20
        
        LDA.b #$02 : JSL Sprite_DrawMultiple
            PLB
            
            RTL
    
    .invalid_animation_state
    
    JSL Sprite_PrepOamCoordLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BD46-$06BE05 DATA
pool_Wizzrobe_Draw:
{
    .oam_groups
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $88, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $86, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8C, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8A, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8C, $40, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8A, $40, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $A4, $00, $00, $02
    
    dw 0, -8 : db $B2, $00, $00, $00
    dw 8, -8 : db $B3, $00, $00, $00
    dw 0,  0 : db $8E, $00, $00, $02
}

; ==============================================================================

; $06BE06-$06BE27 LONG JUMP LOCATION
Wizzrobe_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00
    
    ASL A : ADC.b $00 : ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BE28-$06BE67 DATA
Pool_Wizzbeam_Draw:
{
    .oam_groups
    dw  0, -4 : db $C5, $00, $00, $00
    dw  0,  4 : db $C5, $80, $00, $00
    
    dw  0, -4 : db $C5, $40, $00, $00
    dw  0,  4 : db $C5, $C0, $00, $00
    
    dw -4,  0 : db $D2, $40, $00, $00
    dw  4,  0 : db $D2, $00, $00, $00
    
    dw -4,  0 : db $D2, $C0, $00, $00
    dw  4,  0 : db $D2, $80, $00, $00
}

; ==============================================================================

; $06BE68-$06BE85 LONG JUMP LOCATION
Wizzbeam_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    
    LDA.w $0DE0, X : REP #$20 : ASL #4 : ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06BE86-$06BFA5 DATA
Pool_Freezor_Draw:
{
    .death_oam_groups
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    
    dw -8,  0 : db $A6, $00, $00, $02
    dw  8,  0 : db $A6, $40, $00, $02
    dw  0, 11 : db $AB, $00, $00, $00
    dw  8, 11 : db $AB, $40, $00, $00
    
    dw -8,  0 : db $AC, $00, $00, $02
    dw  8,  0 : db $A8, $40, $00, $02
    dw  0, 11 : db $BA, $00, $00, $00
    dw  8, 11 : db $BB, $00, $00, $00
    
    dw -8,  0 : db $A8, $00, $00, $02
    dw  8,  0 : db $AC, $40, $00, $02
    dw  0, 11 : db $BB, $40, $00, $00
    dw  8, 11 : db $BA, $40, $00, $00
    
    dw  0,  2 : db $AE, $00, $00, $00
    dw  8,  2 : db $AE, $40, $00, $00
    dw  0, 10 : db $BE, $00, $00, $00
    dw  8, 10 : db $BE, $40, $00, $00
    
    dw  0,  4 : db $AF, $00, $00, $00
    dw  8,  4 : db $AF, $40, $00, $00
    dw  0, 12 : db $BF, $00, $00, $00
    dw  8, 12 : db $BF, $40, $00, $00
    
    dw  0,  8 : db $AA, $00, $00, $00
    dw  8,  8 : db $AA, $40, $00, $00
    dw  0,  8 : db $AA, $00, $00, $00
    dw  8,  8 : db $AA, $40, $00, $00
    
    ; $06BF66
    .normal_oam_group
    dw  0, 0 : db $AE, $00, $00, $00
    dw  8, 0 : db $AE, $40, $00, $00
    dw  0, 8 : db $BE, $00, $00, $00
    dw  8, 8 : db $BE, $40, $00, $00
    dw -2, 0 : db $AE, $00, $00, $00
    dw 10, 0 : db $AE, $40, $00, $00
    dw -2, 8 : db $BE, $00, $00, $00
    dw 10, 8 : db $BE, $40, $00, $00
}

; ==============================================================================

; $06BFA6-$06BFD5 LONG JUMP LOCATION
Freezor_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : CMP.b #$07 : BEQ .use_normal_oam_groups
        REP #$20 : ASL #5 : ADC.w #(.death_oam_groups) : STA.b $08
        
        SEP #$20
        
        LDA.b #$04
        
        .now_draw
        
        JSL Sprite_DrawMultiple
        
        PLB
        
        RTL
    
    .use_normal_oam_groups
    
    REP #$20
    
    LDA.w #(.normal_oam_group) : STA.b $08
    
    SEP #$20
    
    LDA.b #$08
    
    BRA .now_draw
}

; ==============================================================================

; $06BFD6-$06C0A5 DATA
Pool_Zazak_Draw:
{
    .oam_groups
    dw  0, -8 : db $08, $00, $00, $02
    dw -4,  0 : db $A0, $00, $00, $02
    dw  4,  0 : db $A1, $00, $00, $02
    
    dw  0, -7 : db $08, $00, $00, $02
    dw -4,  1 : db $A1, $40, $00, $02
    dw  4,  1 : db $A0, $40, $00, $02
    
    dw  0, -8 : db $0E, $00, $00, $02
    dw -4,  0 : db $A3, $00, $00, $02
    dw  4,  0 : db $A4, $00, $00, $02
    
    dw  0, -7 : db $0E, $00, $00, $02
    dw -4,  1 : db $A4, $40, $00, $02
    dw  4,  1 : db $A3, $40, $00, $02
    
    dw  0, -9 : db $0C, $00, $00, $02
    dw  0,  0 : db $A6, $00, $00, $02
    dw  0,  0 : db $A6, $00, $00, $02
    
    dw  0, -8 : db $0C, $00, $00, $02
    dw  0,  0 : db $A8, $00, $00, $02
    dw  0,  0 : db $A8, $00, $00, $02
    
    dw  0, -9 : db $0C, $40, $00, $02
    dw  0,  0 : db $A6, $40, $00, $02
    dw  0,  0 : db $A6, $40, $00, $02
    
    dw  0, -8 : db $0C, $40, $00, $02
    dw  0,  0 : db $A8, $40, $00, $02
    dw  0,  0 : db $A8, $40, $00, $02
    
    .chr_overrides
    db $82, $82, $80, $84, $88, $88, $86, $84
    
    .vh_flip_overrides
    db $40, $00, $00, $00, $40, $00, $00, $00
}

; ==============================================================================

; $06C0A6-$06C0F2 LONG JUMP LOCATION
Zazak_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00 : ASL A : ADC.b $00
    
    ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL Sprite_DrawMultiple
        LDA.w $0F00, X : BNE .paused
        
        LDA.w $0E00, X : CMP.b #$01 : PHX : LDA.w $0EB0, X : TAX : BCC .mouth_closed
            INX #4
        
        .mouth_closed
        
        LDA .chr_overrides, X : LDY.b #$02 : STA ($90), Y
        
        INY
        
        LDA ($90), Y : AND.b #$BF : ORA .vh_flip_overrides, X : STA ($90), Y
        
        PLX
        
        JSL Sprite_DrawShadowLong
    
    .paused
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C0F3-$06C21B MIXED
Pool_Stalfos_Draw:
{
    .oam_groups
    dw  0, -10 : db $00, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    
    dw  0,  -9 : db $00, $00, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    
    dw  0, -10 : db $04, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    dw  0,   0 : db $06, $00, $00, $02
    
    dw  0,  -9 : db $04, $00, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    dw  0,   1 : db $06, $40, $00, $02
    
    dw  0, -10 : db $02, $00, $00, $02
    dw  5,   5 : db $2E, $00, $00, $00
    dw  0,   0 : db $24, $00, $00, $02
    
    dw  0, -10 : db $02, $00, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    
    dw  0, -10 : db $02, $40, $00, $02
    dw  3,   5 : db $2E, $40, $00, $00
    dw  0,   0 : db $24, $40, $00, $02
    
    dw  0, -10 : db $02, $40, $00, $02
    dw  0,   0 : db $0E, $40, $00, $02
    dw  0,   0 : db $0E, $00, $00, $02
    
    dw  2,  -8 : db $02, $40, $00, $02
    dw  0,   0 : db $08, $40, $00, $02
    dw  0,   0 : db $08, $40, $00, $02
    
    dw -2,  -8 : db $02, $00, $00, $02
    dw  0,   0 : db $08, $00, $00, $02
    dw  0,   0 : db $08, $00, $00, $02
    
    dw  0, -10 : db $00, $00, $00, $02
    dw  0,   0 : db $0A, $00, $00, $02
    dw  0,   0 : db $0A, $00, $00, $02
    
    dw  0,   0 : db $0A, $00, $00, $02
    dw  0,  -6 : db $04, $00, $00, $02
    dw  0,  -6 : db $04, $00, $00, $02
    
    .head_chr
    db $02, $02, $00, $04
    
    .easy_out
    
    JSL Sprite_PrepOamCoordLong
    
    RTL
}

; ==============================================================================

; $06C21C-$06C26D LONG JUMP LOCATION
Stalfos_Draw:
{
    LDA.w $0E10, X : BNE .easy_out
    PHB : PHK : PLB
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00 : ASL A : ADC.b $00
    
    ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL Sprite_DrawMultiple
    
    LDA.w $0DC0, X : CMP.b #$08 : BCS .no_head_override
        LDA.w $0F00, X : BNE .no_head_override
            PHX
            
            LDA.w $0EB0, X : TAX
            
            LDA .head_chr, X : LDY.b #$02 : STA ($90), Y
            
            INY
            
            LDA ($90), Y : AND.b #$8F : ORA .head_properties, X : STA ($90), Y
            
            PLX
    
    .no_head_override
    
    JSL Sprite_DrawShadowLong
        
    PLB
        
    RTL
    
    .head_properties
    db $70, $30, $30, $30
}

; ==============================================================================

; $06C26E-$06C2D0 LONG JUMP LOCATION
Probe_CheckTileSolidity:
{
    LDA.w $0F20, X : CMP.b #$01 : REP #$30 : STZ.b $05 : BCC .on_bg2
        LDA.w #$1000 : STA.b $05
    
    .on_bg2
    
    SEP #$20
    
    LDA.b $1B : REP #$20 : BEQ .outdoors
        LDA.w $0FD8 : AND.w #$01FF : LSR #3 : STA.b $04
        
        LDA.w $0FDA : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $05
        
        PHX
        
        TAX
        
        ; Detect the tile type the soldier interacts with
        LDA.l $7F2000, X
        
        PLX
        
        BRA .finished
    
    .outdoors
    
    PHX : PHY
    
    LDA.w $0FD8 : LSR #3 : STA.b $02
    
    LDA.w $0FDA : STA.b $00
    
    SEP #$30
    
    JSL Overworld_ReadTileAttr
    
    ; (It will later be translated into something dungeon oriented)
    REP #$10
    
    PLY : PLX
    
    .finished
    
    SEP #$30
    
    PHX
    
    STA.w $0FA5 : TAX
    
    LDA Sprite_SimplifiedTileAttr, X : PLX : CMP.b #$01
    
    RTL
}

; ==============================================================================

incsrc "sprite_human_multi_1.asm"
incsrc "sprite_sweeping_lady.asm"
incsrc "sprite_lumberjacks.asm"
incsrc "sprite_unused_telepath.asm"
incsrc "sprite_fortune_teller.asm"
incsrc "sprite_maze_game_lady.asm"
incsrc "sprite_maze_game_guy.asm"

; ==============================================================================

; $06CDCF-$06CE5E DATA
Pool_CrystalMaiden_Draw:
{
    .oam_groups
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $01, $00, $02
    dw 1,  3 : db $22, $01, $00, $02
    
    dw 1, -7 : db $20, $41, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    dw 1, -7 : db $20, $41, $00, $02
    dw 1,  3 : db $22, $41, $00, $02
    
    .vram_source_indices
    db $20, $C0
    db $20, $C0
    db $00, $A0
    db $00, $A0
    db $40, $80
    db $40, $60
    db $40, $80
    db $40, $60
}

; ==============================================================================

; $06CE5F-$06CE90 LONG JUMP LOCATION
CrystalMaiden_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL A : TAY
    
    LDA .vram_source_indices + 0, Y : STA.w $0AE8
    LDA .vram_source_indices + 1, Y : STA.w $0AEA
    
    ; Crystal maidens?
    TYA : ASL #3
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CE91-$06CF30 DATA
Pool_Priest_Draw:
{
    .oam_groups
    dw  0, -8 : db $20, $0E, $00, $02
    dw  0,  0 : db $26, $0E, $00, $02
    
    dw  0, -8 : db $20, $0E, $00, $02
    dw  0,  0 : db $26, $4E, $00, $02
    
    dw  0, -8 : db $0E, $0E, $00, $02
    dw  0,  0 : db $24, $0E, $00, $02
    
    dw  0, -8 : db $0E, $0E, $00, $02
    dw  0,  0 : db $24, $0E, $00, $02
    
    dw  0, -8 : db $22, $0E, $00, $02
    dw  0,  0 : db $28, $0E, $00, $02
    
    dw  0, -8 : db $22, $0E, $00, $02
    dw  0,  0 : db $2A, $0E, $00, $02
    
    dw  0, -8 : db $22, $4E, $00, $02
    dw  0,  0 : db $28, $4E, $00, $02
    
    dw  0, -8 : db $22, $4E, $00, $02
    dw  0,  0 : db $2A, $4E, $00, $02
    
    dw -7,  1 : db $0A, $0E, $00, $02
    dw  3,  3 : db $0C, $0E, $00, $02
    
    dw -7,  1 : db $0A, $0E, $00, $02
    dw  3,  3 : db $0C, $0E, $00, $02
}

; ==============================================================================

; $06CF31-$06CF58 LONG JUMP LOCATION
Priest_Draw:
{
    ; called by two routines
    
    PHB : PHK : PLB
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
                 ADC.b #(.oam_groups >. 0) : STA.b $08
    LDA.b #$00 : ADC.b #(.oam_groups >> 8) : STA.b $09
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    JSL Sprite_DrawMultiple.player_deferred
    JSL Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06CF59-$06CFD8 DATA
Pool_FluteBoy_Draw:
{
    .oam_groups
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   0 : db $AA, $0A, $00, $02
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   8 : db $BF, $0A, $00, $00
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   0 : db $AA, $0A, $00, $02
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
    
    dw -1,  -1 : db $BE, $0A, $00, $00
    dw  0,   8 : db $BF, $0A, $00, $00
    dw  0, -10 : db $A8, $0A, $00, $02
    dw  0,   0 : db $AA, $0A, $00, $02
}

; ==============================================================================

; $06CFD9-$06CFFF LONG JUMP LOCATION
FluteBoy_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$10 : JSL OAM_AllocateFromRegionB
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL #5
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam-groups >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : JSL Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D000-$06D03F DATA
Pool_FluteAardvark_Draw:
{
    db 0, -10, $E6, $06, $00, $02
    db 0,  -8, $C8, $06, $00, $02
    
    db 0, -10, $E6, $06, $00, $02
    db 0,  -8, $CA, $06, $00, $02
    
    db 0, -10, $E8, $06, $00, $02
    db 0,  -8, $CA, $06, $00, $02
    
    db 0, -10, $CC, $00, $00, $02
    db 0,  -8, $DC, $00, $00, $02
}

; ==============================================================================

; $06D040-$06D05F LONG JUMP LOCATION
FluteAardvark_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    
    ADC.b #$00              : STA.b $08
    LDA.b #$D0 : ADC.b #$00 : STA.b $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D060-$06D11F DATA
Pool_DustCloud_Draw:
{
    .oam_groups
    db  0, -3 : db $8B, $00, $00, $00
    db  3,  0 : db $9B, $00, $00, $00
    db -3,  0 : db $8B, $C0, $00, $00
    db  0,  3 : db $9B, $C0, $00, $00
    
    db  0, -5 : db $8A, $00, $00, $02
    db  5,  0 : db $8A, $00, $00, $02
    db -5,  0 : db $8A, $00, $00, $02
    db  0,  5 : db $8A, $00, $00, $02
    
    db  0, -7 : db $86, $00, $00, $02
    db  7,  0 : db $86, $00, $00, $02
    db -7,  0 : db $86, $00, $00, $02
    db  0,  7 : db $86, $00, $00, $02
    
    db  0, -9 : db $86, $80, $00, $02
    db  9,  0 : db $86, $80, $00, $02
    db -9,  0 : db $86, $80, $00, $02
    db  0,  9 : db $86, $80, $00, $02
    
    db  0, -9 : db $86, $C0, $00, $02
    db  9,  0 : db $86, $C0, $00, $02
    db -9,  0 : db $86, $C0, $00, $02
    db  0,  9 : db $86, $C0, $00, $02
    
    db  0, -7 : db $86, $40, $00, $02
    db  7,  0 : db $86, $40, $00, $02
    db -7,  0 : db $86, $40, $00, $02
    db  0,  7 : db $86, $40, $00, $02
}

; ==============================================================================

; $06D120-$06D141 LONG JUMP LOCATION
DustCloud_Draw:
{
    ; Part of medallion tablet code...
    PHB : PHK : PLB
    
    LDA.b #$14 : STA.w $0F50, X
    
    LDA.w $0DC0, X : ASL #5
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : JSL Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D142-$06D1E1 DATA
Pool_MedallionTablet_Draw:
{
    .oam_groups
    dw -8, -16 : $8C, $00, $00, $02
    dw  8, -16 : $8C, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8, -13 : $8A, $00, $00, $02
    dw  8, -13 : $8A, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8,  -8 : $8A, $00, $00, $02
    dw  8,  -8 : $8A, $40, $00, $02
    dw -8,   0 : $AC, $00, $00, $02
    dw  8,   0 : $AC, $40, $00, $02
    
    dw -8,  -4 : $8A, $00, $00, $02
    dw  8,  -4 : $8A, $40, $00, $02
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
    
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
    dw -8,   0 : $AA, $00, $00, $02
    dw  8,   0 : $AA, $40, $00, $02
}

; ==============================================================================

; $06D1E2-$06D202 LONG JUMP LOCATION
MedallionTablet_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0DC0, X : ASL #5
    
    ; $6D142
    ADC.b #$42              : STA.b $08
    LDA.b #$D1 : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : STA.b $06
                 STZ.b $07
    
    JSL Sprite_DrawMultiple.player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D203-$06D390 DATA
Pool_Uncle_Draw:
{
    .oam_groups
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw   0, -10 : db $02, $0E, $00, $02
    dw   0,   0 : db $06, $0C, $00, $02
    dw  -7,   2 : db $07, $0D, $00, $02
    dw  -7,   2 : db $07, $0D, $00, $02
    dw  10,  12 : db $05, $8D, $00, $00
    dw  10,   4 : db $15, $8D, $00, $00
    dw   0, -10 : db $00, $0E, $00, $02
    dw   0,   0 : db $04, $0C, $00, $02
    dw  -7,   1 : db $07, $0D, $00, $02
    dw  -7,   1 : db $07, $0D, $00, $02
    dw  10,  13 : db $05, $8D, $00, $00
    dw  10,   5 : db $15, $8D, $00, $00
    dw   0,  -9 : db $00, $0E, $00, $02
    dw   0,   1 : db $04, $4C, $00, $02
    dw  -7,   8 : db $05, $8D, $00, $00
    dw   1,   8 : db $06, $8D, $00, $00
    dw   0, -10 : db $02, $0E, $00, $02
    dw  -6,  -1 : db $07, $4D, $00, $02
    dw   0,   0 : db $23, $0C, $00, $02
    dw   0,   0 : db $23, $0C, $00, $02
    dw  -9,   7 : db $05, $8D, $00, $00
    dw  -1,   7 : db $06, $8D, $00, $00
    dw   0,  -9 : db $02, $0E, $00, $02
    dw  -6,   0 : db $07, $4D, $00, $02
    dw   0,   1 : db $25, $0C, $00, $02
    dw   0,   1 : db $25, $0C, $00, $02
    dw -10, -17 : db $07, $0D, $00, $02
    dw  15, -12 : db $15, $8D, $00, $00
    dw  15,  -4 : db $05, $8D, $00, $00
    dw   0, -28 : db $08, $0E, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    dw   0, -28 : db $08, $0E, $00, $02
    dw   0, -28 : db $08, $0E, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    dw  -8, -19 : db $20, $0C, $00, $02
    dw   8, -19 : db $20, $4C, $00, $02
    
    .source_for_vram_1
    db $08, $08, $00, $00, $06, $06, $00
    
    .source_for_vram_2
    db $00, $00, $00, $00, $04, $04, $00
}

; ==============================================================================

; $06D391-$06D3EA LONG JUMP LOCATION
Uncle_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$18 : JSL OAM_AllocateFromRegionB
    
    REP #$20
    
    LDA.w $0DC0, X : AND.w #$00FF : STA.b $00
    
    LDA.w $0DE0, X : AND.w #$00FF : STA.b $02
    
    ; This calculation is... ( ( ( ( (v2 * 2) + v2 + v0) * 2) + v0) * 16 )
    ; or... 96v2 + 48v0. wtf is this for?
    ASL A : ADC.b $02 : ADC.b $00 : ASL A : ADC.b $00 : ASL #4
    
    ADC.w #(.oam_groups) : STA.b $08
    
    LDA.w #$0006 : STA.b $06
    
    SEP #$30
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : TAY
    
    ; \bug Don't have proof yet, but something tells me that if Link's uncle
    ; were ever facing to the right, it would not look correct. These tables
    ; are only 7 elements long and should be 8 elements long...
    LDA .source_for_vram_1, Y : STA.w $0107
    
    LDA .source_for_vram_2, Y : STA.w $0108
    
    JSL Sprite_DrawMultiple.quantity_preset
    
    LDA.w $0DE0, X : BEQ .skip_shadow
    CMP.b #$03   : BEQ .skip_shadow
        JSL Sprite_DrawShadowLong
    
    .skip_shadow
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D3EB-$06D47A DATA
Pool_BugKidNet_Draw:
{
    .oam_groups
    dw  4,  0 : db $27, $00, $00, $00
    dw  0, -5 : db $0E, $00, $00, $02
    dw -8,  6 : db $0A, $04, $00, $02
    dw  8,  6 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
    
    dw  0, -5 : db $0E, $00, $00, $02
    dw  0, -5 : db $0E, $00, $00, $02
    dw -8,  6 : db $0A, $04, $00, $02
    dw  8,  6 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
    
    dw  0, -5 : db $2E, $00, $00, $02
    dw  0, -5 : db $2E, $00, $00, $02
    dw -8,  7 : db $0A, $04, $00, $02
    dw  8,  7 : db $0A, $44, $00, $02
    dw -8, 14 : db $0A, $84, $00, $02
    dw  8, 14 : db $0A, $C4, $00, $02
}

; ==============================================================================

; $06D47B-$06D49E LONG JUMP LOCATION
BugNetKid_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$06 : STA.b $06
                 STZ.b $07
    
    ; Multiples of 0x30
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
    ; $2D3EB
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D49F-$06D4BB LOCAL JUMP LOCATION
Sprite5_CheckIfActive:
{
    ; Deactivates the sprite in certain situations

    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        LDA.w $0FC1 : BNE .inactive
            LDA.b $11 : BNE .inactive
                LDA.w $0CAA, X : BMI .active
                    LDA.w $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .active
    
    RTS
}

; ==============================================================================

; $06D4BC-$06D56B DATA
Pool_Bomber_Draw:
{
    .oam_groups
    dw  0, 0 : db $C6, $40, $00, $02
    dw  0, 0 : db $C6, $40, $00, $02
    
    dw  0, 0 : db $C4, $40, $00, $02
    dw  0, 0 : db $C4, $40, $00, $02
    
    dw  0, 0 : db $C6, $00, $00, $02
    dw  0, 0 : db $C6, $00, $00, $02
    
    dw  0, 0 : db $C4, $00, $00, $02
    dw  0, 0 : db $C4, $00, $00, $02
    
    dw -8, 0 : db $C0, $00, $00, $02
    dw  8, 0 : db $C0, $40, $00, $02
    
    dw -8, 0 : db $C2, $00, $00, $02
    dw  8, 0 : db $C2, $40, $00, $02
    
    dw -8, 0 : db $E0, $00, $00, $02
    dw  8, 0 : db $E0, $40, $00, $02
    
    dw -8, 0 : db $E2, $00, $00, $02
    dw  8, 0 : db $E2, $40, $00, $02
    
    dw -8, 0 : db $E4, $00, $00, $02
    dw  8, 0 : db $E4, $40, $00, $02
    
    dw  0, 0 : db $E6, $40, $00, $02
    dw  0, 0 : db $E6, $40, $00, $02
    
    dw  0, 0 : db $E6, $00, $00, $02
    dw  0, 0 : db $E6, $00, $00, $02
}

; ==============================================================================

; $06D56C-$06D58D LONG JUMP LOCATION
Bomber_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA : LDA.w $0DC0, X : REP #$20 : ASL #4
    
    ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    JSL Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D58E-$06D605 DATA
Pool_BomberPellet_DrawExplosion:
{
    .oam_groups
    dw -11,   0 : db $9B, $01, $00, $00
    dw   0,  -8 : db $9B, $C1, $00, $00
    dw   6,   6 : db $9B, $41, $00, $00
    
    dw -15,  -6 : db $8A, $01, $00, $02
    dw  -4, -14 : db $8A, $01, $00, $02
    dw   2,   0 : db $8A, $01, $00, $02
    
    dw -15,  -6 : db $86, $01, $00, $02
    dw  -4, -14 : db $86, $01, $00, $02
    dw   2,   0 : db $86, $01, $00, $02
    
    dw  -4,  -4 : db $86, $01, $00, $02
    dw  -4,  -4 : db $86, $01, $00, $02
    dw  -4,  -4 : db $86, $01, $00, $02
    
    dw  -4,  -4 : db $AA, $01, $00, $02
    dw  -4,  -4 : db $AA, $01, $00, $02
    dw  -4,  -4 : db $AA, $01, $00, $02
   }

; ==============================================================================

; $06D606-$06D630 LONG JUMP LOCATION
BomberPellet_DrawExplosion:
{
    PHB : PHK : PLB
    
    LDA.w $0DF0, X : BNE .still_exploding
        STZ.w $0DD0, X
    
    .still_exploding
    
    ; multiply by 24 and add 0xD58E...
    LSR #2 : PHA : LDA.b #$00 : XBA : PLA : REP #$20 : ASL #3 : STA.b $00
    
    ASL A : ADC.b $00 : ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL Sprite_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D631-$06D6A5 LONG JUMP LOCATION
GoodBee_AttackOtherSprite:
{
    ; Good bee can't attack any bosses except mothula, apparently.
    LDA.w $0E20, Y : CMP.b #$88 : BEQ .is_mothula
        LDA.w $0B6B, Y : AND.b #$02 : BNE .is_a_boss
    
    .is_mothula
    
    LDA.w $0D10, Y : STA.b $00
    LDA.w $0D30, Y : STA.b $01
    
    LDA.w $0D00, Y : STA.b $02
    LDA.w $0D20, Y : STA.b $03
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $00 : CLC : ADC.w #$0010
    
    CMP.w #$0018 : BCS .sprite_not_close
        LDA.w $0FDA : SEC : SBC.b $02 : CLC : ADC.w #$FFF8
        
        CMP.w #$0018 : BCS .sprite_not_close
        
        SEP #$20
        
        LDA.w $0E20, Y : CMP.b #$75 : BNE .not_bottle_vendor
            TXA : INC A : STA.w $0E90, Y
            
            RTL
        
        .not_bottle_vendor
        
        ; Damage class of the attack is same as that of the level 1 sword.
        LDA.b #$01
        
        PHY : PHX
        
        TYX
        
        JSL Ancilla_CheckSpriteDamage.preset_class
        
        PLX : PLY
        
        LDA.b #$0F : STA.w $0EA0, Y
        
        LDA.w $0D50, X : ASL A : STA.w $0F40, Y
        
        LDA.w $0D40, X : ASL A : STA.w $0F30, Y
        
        INC.w $0DA0, X
    
    .sprite_not_close
    .is_a_boss
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $06D6A6-$06D6E5 DATA
Pool_Pikit_Draw:
{
    .oam_groups
    dw  0, 0 : db $C8, $00, $00, $02
    dw  0, 0 : db $C8, $00, $00, $02
    
    dw  0, 0 : db $CA, $00, $00, $02
    dw  0, 0 : db $CA, $00, $00, $02
    
    dw -8, 0 : db $CC, $00, $00, $02
    dw  8, 0 : db $CC, $40, $00, $02
    
    dw -8, 0 : db $CE, $00, $00, $02
    dw  8, 0 : db $CE, $40, $00, $02
}

; ==============================================================================

; $06D6E6-$06D738 LONG JUMP LOCATION
Pikit_Draw:
{
    PHB : PHK : PLB
    
    JSR Pikit_DrawTongue
    
    LDY.b #$00
    
    LDA ($90), Y : STA.w $0FB5 : INY
    LDA ($90), Y : STA.w $0FB6
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #(.oam_groups) : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0018 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0006 : STA.b $92
    
    SEP #$20
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    LDA.w $0E40, X : PHA : SEC : SBC.b #$06 : STA.w $0E40, X
    
    JSL Sprite_DrawShadowLong
    
    PLA : STA.w $0E40, X
    
    JSR Pikit_DrawGrabbedItem
    
    PLB
    
    RTL
}

; ==============================================================================

; $06D739-$06D749 BRANCH LOCATION
Pool_Pikit_DrawTongue:
{
    .easy_out
    RTS
    
    .chr
    db $EE, $FD, $ED, $FD, $EE, $FD, $ED, $FD
    
    .vh_flip
    db $00, $00, $00, $40, $40, $C0, $80, $80
}

; ==============================================================================

; $06D74A-$06D812 LOCAL JUMP LOCATION
Pikit_DrawTongue:
{
    LDA.w $0D80, X : CMP.b #$02 : BNE .easy_out
        LDA.w $0F00, X : BNE .easy_out
            LDA.b $00 : CLC : ADC.b #$04 : STA.b $00
            
            LDY.b #$14                        : STA ($90), Y
            CLC : ADC.w $0D90, X : LDY.b #$00 : STA ($90), Y
            
            LDA.b $02 : CLC : ADC.b #$03 : STA.b $02
            
                                   LDY.b #$15 : STA ($90), Y
            CLC : ADC.w $0DA0, X : LDY.b #$01 : STA ($90), Y
            LDA.b #$FE           : LDY.b #$16 : STA ($90), Y
                                   LDY.b #$02 : STA ($90), Y
            LDA.b $05            : LDY.b #$17 : STA ($90), Y
                                   LDY.b #$03 : STA ($90), Y
            
            LDA.w $0DE0, X : STA.b $0B
            
            LDA.w $0D90, X : STA.b $0E : BPL .BRANCH_ALPHA
                EOR.b #$FF : INC A
            
            .BRANCH_ALPHA
            
            STA.b $0C
            
            LDA.w $0DA0, X : STA.b $0F : BPL .BRANCH_BETA
                EOR.b #$FF : INC A
            
            .BRANCH_BETA
            
            STA.b $0D
            
            LDY.b #$04
            
            PHX
            
            LDX.b #$03
            
            .next_subsprite
            
                LDA.b $0C           : STA.w $4202
                LDA .multipliers, X : STA.w $4203
                
                ; burn a few cycles...
                JSR Pikit_MultiplicationDelay
                
                LDA.b $0E : ASL A
                
                LDA.w $4217 : BCC .BRANCH_GAMMA
                    EOR.b #$FF : INC A
                
                .BRANCH_GAMMA
                
                CLC : ADC.b $00 : STA ($90), Y
                
                LDA.b $0D           : STA.w $4202
                LDA .multipliers, X : STA.w $4203
                
                JSR Pikit_MultiplicationDelay
                
                LDA.b $0F : ASL A : LDA.w $4217 : BCC .BRANCH_DELTA
                    EOR.b #$FF : INC A
                
                .BRANCH_DELTA
                
                CLC : ADC.b $02
                
                INY
                
                STA ($90), Y
                
                PHX
                
                LDX.b $0B
                
                LDA .chr, X : INY : STA ($90), Y
                
                INY
                
                LDA .vh_flip, X : ORA.b $05 : STA ($90), Y
                
                PLX
                
                INY
            DEX : BPL .next_subsprite
            
            PLX
            
            LDY.b #$00
            LDA.b #$05
            
            JSL Sprite_CorrectOamEntriesLong
            
            RTS
    
    .multipliers
    
    ; multiples of 51.... okay then... 51 = 1/5 of 255, mind you.
    ; Don't yet know the significance, however.
    db $33, $66, $99, $CC        
}

; ==============================================================================

; $06D813-$06D816 LOCAL JUMP LOCATION
Pikit_MultiplicationDelay:
{
    ; delay for multiplication
    NOP #3
    
    RTS
} 

; ==============================================================================

; $06D817-$06D857 DATA
Pool_Pikit_DrawGrabbedItem:
{
    .x_offsets
    db -4,  4, -4,  4,  0,  8,  0,  8
    db  0,  8,  0,  8,  0,  8,  0,  8
    db -4,  4, -4,  4
    
    .y_offsets
    db -4, -4,  4,  4, -4, -4,  4,  4
    db -4, -4,  4,  4, -4, -4,  4,  4
    db -4, -4,  4,  4    
    
    .chr
    db $6E, $6F, $7E, $7F, $63, $7C, $73, $7C
    db $0B, $7C, $1B, $7C, $EC, $F9, $FC, $F9
    db $EA, $EB, $FA, $FB
    
    .properties
    db $24, $24, $28, $29, $2F
}

; ==============================================================================

; $06D858-$06D8AE LOCAL JUMP LOCATION
Pikit_DrawGrabbedItem:
{
    LDA.w $0ED0, X       : BEQ .return
        DEC A : CMP.b #$03 : BNE .not_shield
            ; Indicates the shield level, which should be 1 or 2, resulting in
            ; a final value here of 3 or 4.
            LDA.w $0E30, X : CLC : ADC.b #$02
        
        .not_shield
        
        STA.b $02
        
        LDA.b #$10 : JSL OAM_AllocateFromRegionC
        
        LDY.b #$00
        
        PHX
        
        LDX.b #$03
        
        .next_subsprite
        
            STX.b $03
            
            LDA.b $02 : ASL #2 : ORA.b $03 : TAX
            
            LDA.w $0FB5 : CLC : ADC .x_offsets, X       : STA ($90), Y
            LDA.w $0FB6 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
            LDA .chr, X                           : INY : STA ($90), Y
            LDX.b $02 : LDA .properties, X        : INY : STA ($90), Y
            
            INY
        LDX.b $03 : DEX : BPL .next_subsprite
        
        PLX
        
        LDY.b #$00
        LDA.b #$03
        
        JSL Sprite_CorrectOamEntriesLong
    
    .return
    
    RTS
}

; ==============================================================================

; $06D8AF-$06D98E DATA
Pool_Kholdstare_Draw:
{
    .oam_groups
    dw -8, -8 : db $80, $00, $00, $02
    dw  8, -8 : db $82, $00, $00, $02
    dw -8,  8 : db $A0, $00, $00, $02
    dw  8,  8 : db $A2, $00, $00, $02
    
    dw -7, -7 : db $80, $00, $00, $02
    dw  7, -7 : db $82, $00, $00, $02
    dw -7,  7 : db $A0, $00, $00, $02
    dw  7,  7 : db $A2, $00, $00, $02
    
    dw -7, -7 : db $84, $00, $00, $02
    dw  7, -7 : db $86, $00, $00, $02
    dw -7,  7 : db $A4, $00, $00, $02
    dw  7,  7 : db $A6, $00, $00, $02
    
    dw -8, -8 : db $84, $00, $00, $02
    dw  8, -8 : db $86, $00, $00, $02
    dw -8,  8 : db $A4, $00, $00, $02
    dw  8,  8 : db $A6, $00, $00, $02
    
    .x_offsets
    dw  8,  7,  4,  2,  0, -2, -4, -7
    dw -8, -7, -4, -2,  0,  2,  4,  7
    
    .y_offsets
    dw  0,  2,  4,  7,  8,  7,  4,  2
    dw  0, -2, -4, -7, -8, -7, -4, -2
    
    .chr
    db $AC, $AC, $AA, $8C, $8C, $8C, $AA, $AC
    db $AC, $AA, $AA, $8C, $8C, $8C, $AA, $AC
    
    .vh_flip
    db $40, $40, $40, $00, $00, $00, $00, $00
    db $80, $80, $80, $80, $80, $80, $C0, $C0
}

; ==============================================================================

; $06D98F-$06DA05 LONG JUMP LOCATION
Kholdstare_Draw:
{
    PHB : PHK : PLB
    
    JSL Sprite_PrepOamCoordLong : BCS .offscreen
        PHX
        
        LDA.w $0D90, X : PHA : ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA .chr, X                 : INY : STA ($90), Y
        LDA .vh_flip, X : ORA.b $05 : INY : STA ($90), Y
        
        TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLX
        
        LDA.b #$00 : XBA
        
        LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #(.oam_groups) : STA.b $08
        
        LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
        
        INC.b $92
        
        SEP #$20
        
        LDA.b #$04 : JSL Sprite_DrawMultiple
    
    .offscreen
    
    PLB
    
    RTL
}

; ==============================================================================

; $06DA06-$06DA78 LONG JUMP LOCATION
Sprite_SpawnFireball:
{
    PHB : PHK : PLB
    
    LDA.b #$19 : JSL Sound_SetSfx3PanLong
    
    LDY.b #$0D
    LDA.b #$55
    
    JSL Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01       : ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$04 : PHP : SEC : SBC.b $04  : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00 : PLP       : ADC.b #$00 : STA.w $0D20, Y
        
        LDA.w $0E60, Y : AND.b #$FE : ORA.b #$40 : STA.w $0E60, Y
        
        LDA.b #$06 : STA.w $0F50, Y
        
        LDA.b #$54 : STA.w $0F60, Y
                     STA.w $0E90, Y
        
        LDA.b #$20 : STA.w $0E40, Y
        
        PHX : TYX
        
        LDA.b #$20
        
        JSL Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$14 : STA.w $0DF0, X
        
        LDA.b #$10 : STA.w $0E00, X
        
        STZ.w $0BE0, X
        
        LDA.b #$48 : STA.w $0CAA, X
        
        TXY
        
        PLX
    
    .spawn_failed
    
    PLB
    
    TYA
    
    RTL
}

; ==============================================================================

; $06DA79-$06DAC3 DATA
Pool_ArcheryGameGuy_Draw:
{
    .x_offsets
    db $00, $00, $00
    db $00, $00, $FB
    db $00, $FF, $FF
    db $00, $00, $00
    db $00, $01, $01
    
    .y_offsets
    db $00, $F6, $F6
    db $00, $F6, $FD
    db $00, $F6, $F6
    db $00, $F6, $F6
    db $00, $F6, $F6
    
    .chr
    db $26, $06, $06
    db $08, $06, $3A
    db $26, $06, $06
    db $26, $06, $06
    db $26, $06, $06
    
    .properties
    db $08, $06, $06
    db $08, $06, $08
    db $08, $06, $06
    db $08, $06, $06
    db $08, $06, $06
    
    .size_bits
    db $02, $02, $02
    db $02, $02, $00
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
}

; ==============================================================================

; $06DAC4-$06DB16 LONG JUMP LOCATION
ArcheryGameGuy_Draw:
{
    PHB : PHK : PLB
    
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    JSL Sprite_PrepOamCoordLong
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : STA.b $06
    
    PHX
    
    LDX.b #$02
    
    .next_subsprite
    
        PHX : TXA : CLC : ADC.b $06 : TAX
        
        LDA.b $00 : CLC : ADC .x_offsets, X        : STA ($90), Y
        LDA.b $02 : CLC : ADC .y_offsets, X  : INY : STA ($90), Y
        LDA .chr, X                          : INY : STA ($90), Y
        LDA.b $05       : ORA .properties, X : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA .size_bits, X : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    JSL Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $06DB17-$06DB3F NULL
NULL_0DDB17:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF
}

; ==============================================================================

incsrc "headsup_display.asm"

; ==============================================================================

warnpc $0E8000