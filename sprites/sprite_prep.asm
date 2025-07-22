; ==============================================================================

; SPRITE PREP ROUTINES 1
; $03064D-$030840 JUMP LOCATION
SpritePrep_Main:
{
    JSL.l Sprite_LoadProperties
    
    INC.w $0DD0, X
    
    LDA.w $0E20, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw SpritePrep_Raven                    ; 0x00 - $8969 Raven
    dw SpritePrep_Vulture                  ; 0x01 - $897E Vulture
    dw SpritePrep_DoNothing                ; 0x02 - $8873 Flying Stalfos Head
    dw $0000                               ; 0x03 - $0000 Null sprite
    dw SpritePrep_GoodSwitch               ; 0x04 - $8859 Good Switch
    dw SpritePrep_DoNothing                ; 0x05 - $8873 Switch?
    dw SpritePrep_GoodSwitch               ; 0x06 - $8859 Bad Switch
    dw SpritePrep_SwitchFacingUp           ; 0x07 - $886D Switch again, facing up
    dw SpritePrep_Octorock                 ; 0x08 - $8F71 Octorock
    dw SpritePrep_GiantMoldorm             ; 0x09 - $8F8A Giant Moldorm
    dw SpritePrep_Octorock                 ; 0x0A - $8F71 Four Shooter Octorock
    dw SpritePrep_DoNothing                ; 0x0B - $8873 Chicken / Chicken Lady
    dw SpritePrep_DoNothing                ; 0x0C - $8873 Octorock projectile
    dw SpritePrep_DoNothing                ; 0x0D - $8873 Buzzblob
    dw SpritePrep_DoNothing                ; 0x0E - $8873 Plants with big mouths
    dw SpritePrep_Octoballoon              ; 0x0F - $8910 Octoballoon
    dw SpritePrep_DoNothing                ; 0x10 - $8873 Octospawn
    dw SpritePrep_DoNothing                ; 0x11 - $8873 Hinox
    dw SpritePrep_DoNothing                ; 0x12 - $8873 Moblin
    dw SpritePrep_Helmasaur                ; 0x13 - $9151 Helmasaur
    dw SpritePrep_GargoyleGrate            ; 0x14 - $8BC4 Gargoyle Grate
    dw SpritePrep_Bubble                   ; 0x15 - $8EF2 Bubble
    dw SpritePrep_Elder                    ; 0x16 - $8CDE Sahasralah / Aginah
    dw SpritePrep_DoNothing                ; 0x17 - $8873 Rupee Crab under bush
    dw SpritePrep_Moldorm                  ; 0x18 - $89D3 Moldorm
    dw SpritePrep_Poe                      ; 0x19 - $8991 Poe
    dw SpritePrep_Dwarf                    ; 0x1A - $8A79 Dwarves and helper sprites
    dw SpritePrep_DoNothing                ; 0x1B - $8873 Arrow in Wall?
    dw SpritePrep_MovableStatue            ; 0x1C - $8B12 Movable Statue
    dw SpritePrep_IgnoresProjectiles       ; 0x1D - $8BA7 Weathervane
    dw SpritePrep_CrystalSwitch            ; 0x1E - $9064 Crystal Switch
    dw SpritePrep_BugNetKid                ; 0x1F - $8D7F Bug Net Kid
    dw SpritePrep_DoNothing                ; 0x20 - $8873 Sluggula
    dw SpritePrep_PushSwitch               ; 0x21 - $8B34 Push Switch
    dw SpritePrep_DoNothing                ; 0x22 - $8873 Ropa
    dw SpritePrep_Bari                     ; 0x23 - $8B1C Bari (Blue)
    dw SpritePrep_Bari                     ; 0x24 - $8B1C Bari (Red)
    dw SpritePrep_TalkingTree              ; 0x25 - $9043 Conversational Tree
    dw SpritePrep_HardHatBeetle            ; 0x26 - $9122 Hardhat Beetle
    dw SpritePrep_DoNothing                ; 0x27 - $8873 Deadrock
    dw SpritePrep_StoryTeller_1            ; 0x28 - $8C9E Story Teller Set 1
    dw SpritePrep_HumanMulti_1             ; 0x29 - $8CC1 Human NPC Set 1
    dw SpritePrep_IgnoresProjectiles       ; 0x2A - $8BA7 Sweeping lady
    dw SpritePrep_HoboEntities             ; 0x2B - $8DFD Hobo under bridge
    dw SpritePrep_Lumberjacks              ; 0x2C - $8DDA Lumberjack Bros.
    dw SpritePrep_IgnoresProjectiles       ; 0x2D - $8BA7 ???? Telepathic Stones
    dw SpritePrep_FluteBoy                 ; 0x2E - $9075 Flute Boy's Notes
    dw SpritePrep_IgnoresProjectiles       ; 0x2F - $8BA7 Race Game Couple
    dw SpritePrep_IgnoresProjectiles       ; 0x30 - $8BA7 Person? (HM Name)
    dw SpritePrep_FortuneTeller            ; 0x31 - $8DE0 Fortune Teller / Smithy, etc.
    dw SpritePrep_IgnoresProjectiles       ; 0x32 - $8BA7 Quarrel Bros.
    dw SpritePrep_PullForRupees            ; 0x33 - $8BCF Pull For Rupees
    dw SpritePrep_YoungSnitchGirl          ; 0x34 - $C026 Young Snitch Girl
    dw SpritePrep_InnKeeper                ; 0x35 - $C030 Inn Keeper
    dw SpritePrep_IgnoresProjectiles       ; 0x36 - $8BA7 Witch
    dw SpritePrep_IgnoresProjectiles       ; 0x37 - $8BA7 Waterfall
    dw SpritePrep_DoNothing                ; 0x38 - $8873 Arrow Target
    dw SpritePrep_MiddleAgedMan            ; 0x39 - $8D59 Middle-aged desert guy
    dw SpritePrep_MadBatter                ; 0x3A - $8DDA Mad Batter
    dw SpritePrep_DashItem                 ; 0x3B - $8CF2 Dash item
    dw SpritePrep_IgnoresProjectiles       ; 0x3C - $8BA7 Kid in village near trough
    dw SpritePrep_OldSnitchLady            ; 0x3D - $886E Old Snitch Lady
    dw SpritePrep_DoNothing                ; 0x3E - $8873 Rupee Crab under rock
    dw SpritePrep_DoNothing                ; 0x3F - $8873 Tutorial Soldier
    dw SpritePrep_EvilBarrier              ; 0x40 - $891B Evil barrier to Hyrule tower
    dw SpritePrep_Soldier                  ; 0x41 - $8FD6 Green Soldier
    dw SpritePrep_Soldier                  ; 0x42 - $8FD6 Blue Soldier
    dw SpritePrep_Soldier                  ; 0x43 - $8FD6 Red Spear Soldier
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x44 - $9001 Psycho Trooper
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x45 - $9001 Psycho Spear Soldier
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x46 - $9001 Blue Archer Soldier
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x47 - $9001 Green Archer Bush Soldier
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x48 - $9001 Red Javelin Trooper
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x49 - $9001 Red Javelin Bush Soldier
    dw SpritePrep_TrooperAndArcherSoldier  ; 0x4A - $9001 Green Enemy Bombs
    dw SpritePrep_Recruit                  ; 0x4B - $9001 Green Soldier (weak version)
    dw SpritePrep_GerudoMan                ; 0x4C - $8FA7 Gerudo Man
    dw SpritePrep_Toppo                    ; 0x4D - $8FB0 Toppo
    dw SpritePrep_Popo                     ; 0x4E - $8B08 Popo
    dw SpritePrep_Bot                      ; 0x4F - $8B0C Bot
    dw SpritePrep_DoNothing                ; 0x50 - $8873 Metal Ball
    dw SpritePrep_Armos                    ; 0x51 - $8F6C Armos
    dw SpritePrep_ZoraKing                 ; 0x52 - $8F0F Zora King
    dw SpritePrep_ArmosKnight              ; 0x53 - $8F3F Armos Knight
    dw SpritePrep_Lanmola                  ; 0x54 - $8F95 Lanmola
    dw SpritePrep_ZoraAndFireball          ; 0x55 - $8FA2 Zora and Fireball
    dw SpritePrep_WalkingZora              ; 0x56 - $ Walking Zora
    dw SpritePrep_DesertBarrier            ; 0x57 - $ Desert Palace barriers
    dw SpritePrep_DoNothing                ; 0x58 - $8873 Crab
    dw SpritePrep_LostWoodsBird            ; 0x59 - $ Lost Woods Bird
    dw SpritePrep_LostWoodsSquirrel        ; 0x5A - $ Lost Woods Squirrel
    dw SpritePrep_Spark                    ; 0x5B - $ Spark (clockwise)
    dw SpritePrep_Spark                    ; 0x5C - $ Spark (counter-clockwise)
    dw SpritePrep_RollerDownUp             ; 0x5D - $ Roller (down then up)
    dw SpritePrep_RollerUpDown             ; 0x5E - $ Roller (up then down)
    dw SpritePrep_RollerRightLeft          ; 0x5F - $ Roller (????)
    dw SpritePrep_RollerLeftRight          ; 0x60 - $ Roller (????)
    dw SpritePrep_DoNothing                ; 0x61 - $8873 Beamos
    dw SpritePrep_MasterSword              ; 0x62 - $ Master Sword and light beams
    dw SpritePrep_Debirando                ; 0x63 - $ Debirando Pit
    dw SpritePrep_FireDebirando            ; 0x64 - $ Debirando
    dw SpritePrep_ArcheryGameGuyTrampoline ; 0x65 - $ Archery Game Guy
    dw SpritePrep_WallCannon               ; 0x66 - $ Wall Cannon
    dw SpritePrep_WallCannon               ; 0x67 - $ Wall Cannon
    dw SpritePrep_WallCannon               ; 0x68 - $ Wall Cannon
    dw SpritePrep_WallCannon               ; 0x69 - $ Wall Cannon
    dw SpritePrep_DoNothing                ; 0x6A - $8873 Ball And Chain Trooper
    dw SpritePrep_DoNothing                ; 0x6B - $8873 Cannon Trooper
    dw SpritePrep_DoNothing                ; 0x6C - $8873 Warp Vortex
    dw SpritePrep_Rat                      ; 0x6D - $ Rat
    dw SpritePrep_Rope                     ; 0x6E - $ Rope
    dw SpritePrep_Keese                    ; 0x6F - $ Keese
    dw SpritePrep_DoNothing_2              ; 0x70 - $ Helmasaur King Fireball
    dw SpritePrep_Leever                   ; 0x71 - $ Leever
    dw SpritePrep_IgnoresProjectiles       ; 0x72 - $8BA7 Pond Activator / Script
    dw SpritePrep_UncleAndSageTrampoline   ; 0x73 - $BFE5 Link's Uncle / Sage /
                                           ; Watergate Barrier (weird I know)
                                           ; TODO: Verify this.

    dw SpritePrep_RunningManTrampoline     ; 0x74 - $ Red Hat Wussy
    dw SpritePrep_IgnoresProjectiles       ; 0x75 - $8BA7 Bottle Vendor
    dw SpritePrep_ZeldaTrampoline          ; 0x76 - $ Princess Zelda
    dw SpritePrep_Bubble                   ; 0x77 - $8EF2 Alternate Bubble
    dw SpritePrep_ElderWife                ; 0x78 - $ Elder's Wife
    dw SpritePrep_DashTriggeredSprite      ; 0x79 - $ Good Bee stuck in Ice Cavern
    dw SpritePrep_Agahnim                  ; 0x7A - $ Agahnim
    dw SpritePrep_DoNothing_2              ; 0x7B - $ Agahnim energy balls
    dw SpritePrep_GreenStalfos             ; 0x7C - $ Green Stalfos
    dw SpritePrep_SpikeTrap                ; 0x7D - $ Spike Trap
    dw SpritePrep_GuruguruBar              ; 0x7E - $ Guruguru Bar
    dw SpritePrep_GuruguruBar              ; 0x7F - $ Guruguru Bar
    dw SpritePrep_DoNothing_2              ; 0x80 - $ Wandering Fireball Chains
    dw SpritePrep_DoNothing_2              ; 0x81 - $ Hover
    dw SpritePrep_BubbleGroupTrampoline    ; 0x82 - $ Bubble Group
    dw SpritePrep_EyegoreTrampoline        ; 0x83 - $ Eyegore
    dw SpritePrep_EyegoreTrampoline        ; 0x84 - $ Eyegore 2
    dw SpritePrep_DoNothing_2              ; 0x85 - $ Yellow Stalfos
    dw SpritePrep_Kodondo                  ; 0x86 - $ Kodondo
    dw SpritePrep_DoNothing_2              ; 0x87 - $ Flames (what?)
    dw SpritePrep_Mothula                  ; 0x88 - $ Mothula
    dw SpritePrep_DoNothing_2              ; 0x89 - $ Mothula Beam
    dw SpritePrep_SpikeBlock               ; 0x8A - $ Spike Block
    dw SpritePrep_DoNothing_2              ; 0x8B - $ Gibdo
    dw SpritePrep_Arghus                   ; 0x8C - $ Arrghus
    dw SpritePrep_Arrgi                    ; 0x8D - $ Arrgi
    dw SpritePrep_DoNothing_2              ; 0x8E - $ Chair Turtles (kill with hammer)
    dw SpritePrep_Terrorpin                ; 0x8F - $ Terrorpin
    dw SpritePrep_DoNothing_2              ; 0x90 - $ Grabber Things (Floor master?) 
    dw SpritePrep_DoNothing_2              ; 0x91 - $ Stalfos Knight
    dw SpritePrep_HelmasaurKing            ; 0x92 - $ Helmasaur King
    dw SpritePrep_Bumper                   ; 0x93 - $ Bumper
    dw SpritePrep_DoNothing                ; 0x94 - $ Pirogusu
    dw SpritePrep_LaserEyeTrampoline       ; 0x95 - $ Laser Eye (right)
    dw SpritePrep_LaserEyeTrampoline       ; 0x96 - $ Laser Eye (left)
    dw SpritePrep_LaserEyeTrampoline       ; 0x97 - $ Laser Eye (down)
    dw SpritePrep_LaserEyeTrampoline       ; 0x98 - $ Laser Eye (up)
    dw SpritePrep_DoNothing                ; 0x99 - $ $8873 Attack Penguin?
    dw SpritePrep_Kyameron                 ; 0x9A - $ Kyameron
    dw SpritePrep_DoNothing                ; 0x9B - $8873 Wizzrobe
    dw SpritePrep_Zoro                     ; 0x9C - $ Zoro
    dw SpritePrep_Babusu                   ; 0x9D - $ Babusu
    dw SpritePrep_FluteBoyOstrich          ; 0x9E - $ Ostrich seen with Flute Boy
    dw SpritePrep_FluteBoyAnimals          ; 0x9F - $ Rabbit seen with Flute Boy
    dw SpritePrep_FluteBoyAnimals          ; 0xA0 - $ Bird seen with Flute Boy
    dw SpritePrep_MoveDownOneTile          ; 0xA1 - $ Freezor
    dw SpritePrep_Kholdstare               ; 0xA2 - $ Kholdstare
    dw SpritePrep_KholdstareShell          ; 0xA3 - $ Kholdstare part 2?
    dw SpritePrep_IceBallGenerator         ; 0xA4 - $ Kholdstare Ice balls
    dw SpritePrep_Zazakku                  ; 0xA5 - $ Blue Zazak
    dw SpritePrep_Zazakku                  ; 0xA6 - $ Red Zazak
    dw SpritePrep_Stalfos                  ; 0xA7 - $ Stalfos
    dw SpritePrep_Bomber                   ; 0xA8 - $ Green Bomber (Zirro?)
    dw SpritePrep_Bomber                   ; 0xA9 - $ Blue Bomber (Zirro?)
    dw SpritePrep_Pikit                    ; 0xAA - $ Pikit
    dw SpritePrep_CrystalMaiden            ; 0xAB - $ Crystal Maiden
    dw SpritePrep_DashTriggeredSprite      ; 0xAC - $ Apple(s) in tree
    dw SpritePrep_OldMountainManTrampoline ; 0xAD - $ Old Mountain Man
    dw SpritePrep_DoNothing                ; 0xAE - $8873 Down Pipe
    dw SpritePrep_DoNothing                ; 0xAF - $8873 Up Pipe
    dw SpritePrep_DoNothing                ; 0xB0 - $8873 Right Pipe
    dw SpritePrep_DoNothing                ; 0xB1 - $8873 Left Pipe
    dw SpritePrep_GoodBee                  ; 0xB2 - $ Good Bee
    dw SpritePrep_HylianPlaque             ; 0xB3 - $ Hylian Inscription? 
    dw SpritePrep_ThiefChest               ; 0xB4 - $ Thief Chest
    dw SpritePrep_BombShopEntity           ; 0xB5 - $ Bomb Shop Guy and company
    dw SrpritePrep_Kiki                    ; 0xB6 - $ Kiki the monkey
    dw SpritePrep_BlindMaiden              ; 0xB7 - $ Blind disguised as a Maiden
    dw SpritePrep_DoNothing                ; 0xB8 - $ $8873 Dialogue Testing Sprite
    dw SpritePrep_BullyAndBallGuy          ; 0xB9 - $ Bully and Ball Guy
    dw SpritePrep_WhirlPool_               ; 0xBA - $ Whirlpool
    dw SpritePrep_ShopKeeper               ; 0xBB - $ Shopkeeper / Chest game guys
    dw SpritePrep_IgnoresProjectiles       ; 0xBC - $8BA7 Drunk in the Inn
    dw SpritePrep_Vitreous                 ; 0xBD - $ Vitreous
    dw SpritePrep_Vitreolus                ; 0xBE - $ Smaller Vitreous Eyeballs
    dw SpritePrep_DoNothing                ; 0xBF - $8873 Vitreous Lightning Blast
    dw SpritePrep_GreatCatfish             ; 0xC0 - $ Giant Cranky Catfish
    dw SpritePrep_ChattyAgahnim            ; 0xC1 - $ Agahnim Teleporting Zelda
    dw SpritePrep_DoNothing                ; 0xC2 - $ $8873 Boulder
    dw SpritePrep_Gibo                     ; 0xC3 - $ Gibo
    dw SpritePrep_DoNothing                ; 0xC4 - $8873 Thief
    dw SpritePrep_IgnoresProjectiles       ; 0xC5 - $8BA7 Evil Fireball Spitters
    dw SpritePrep_IgnoresProjectiles       ; 0xC6 - $8BA7 Fourway Fireball Spitters
    dw SpritePrep_Hokbok                   ; 0xC7 - $ Hokbok
    dw SpritePrep_BigFairy                 ; 0xC8 - $ Big Fairy 
    dw SpritePrep_GanonHelpers             ; 0xC9 - $ Ganon Helpers + Tektite
    dw SpritePrep_ChainChompTrampoline     ; 0xCA - $ Chain Chomp
    dw SpritePrep_TrinexxComponents        ; 0xCB - $ Trinexx Part 1
    dw SpritePrep_TrinexxComponents        ; 0xCC - $ Trinexx Part 2
    dw SpritePrep_TrinexxComponents        ; 0xCD - $ Trinexx Part 3
    dw SpritePrep_Blind                    ; 0xCE - $ Blind
    dw SpritePrep_Swamola                  ; 0xCF - $ Swamola
    dw SpritePrep_DoNothing                ; 0xD0 - $ $8873 Lynel
    dw SpritePrep_DoNothing                ; 0xD1 - $ $8873 Yellow Transform
    dw SpritePrep_IgnoresProjectiles       ; 0xD2 - $8BA7 Flopping Fish
    dw SpritePrep_Stal                     ; 0xD3 - $ Stal
    dw SpritePrep_IgnoresProjectiles       ; 0xD4 - $8BA7 Landmine
    dw SpritePrep_DiggingGameGuyTrampoline ; 0xD5 - $ Digging Game Guy 
    dw SpritePrep_Ganon                    ; 0xD6 - $ Ganon
    dw SpritePrep_Ganon                    ; 0xD7 - $ InvinceoGanon
    dw SpritePrep_HeartRefill              ; 0xD8 - $ Heart Refill 
    dw SpritePrep_GreenRupee               ; 0xD9 - $ Green Rupee
    dw SpritePrep_BlueRupee                ; 0xDA - $ Blue Rupee
    dw SpritePrep_RedRupee                 ; 0xDB - $ Red Rupee
    dw SpritePrep_OneBombRefill            ; 0xDC - $ 1 Bomb Refill
    dw SpritePrep_OneBombRefill            ; 0xDD - $ 4 Bomb Refill
    dw SpritePrep_EightBombRefill          ; 0xDE - $ 8 Bomb Refill
    dw SpritePrep_SmallMagicRefill         ; 0xDF - $ Small Magic Refill
    dw SpritePrep_FullMagicRefill          ; 0xE0 - $ Full Magic Refill
    dw SpritePrep_FiveArrowRefill          ; 0xE1 - $ 5 Arrow Refill
    dw SpritePrep_TenArrowRefill           ; 0xE2 - $ 10 Arrow Refill
    dw SpritePrep_Fairy                    ; 0xE3 - $ Fairy
    dw SpritePrep_Key                      ; 0xE4 - $ Key
    dw SpritePrep_BigKey                   ; 0xE5 - $ Big Key
    dw SpritePrep_ShieldPickup             ; 0xE6 - $ Shield Pickup
    dw SpritePrep_MushroomTrampoline       ; 0xE7 - $ Mushroom
    dw SpritePrep_FakeSwordTrampolnie      ; 0xE8 - $ Fake Master Sword
    dw SpritePrep_PotionShopTrampoline     ; 0xE9 - $ Magic Shop Dude and his items
    dw SpritePrep_HeartContainerTrampoline ; 0xEA - $ Heart Container
    dw SpritePrep_HeartPieceTrampoline     ; 0xEB - $ Heart Piece
    dw SpritePrep_ThrowableScenery         ; 0xEC - $ Bush / Rock
    dw SpritePrep_DoNothing                ; 0xED - $8873 Cane of Somaria Platform
    dw SpritePrep_MovableMantle            ; 0xEE - $ Movable Mantle
    dw SpritePrep_DoNothing                ; 0xEF - $8873 Cane of Somaria Platform (unused?)
    dw SpritePrep_DoNothing                ; 0xF0 - $8873 Cane of Somaria Platform (unused?)
    dw SpritePrep_DoNothing                ; 0xF1 - $8873 Cane of Somaria Platform (unused?)
    dw SpritePrep_MedallionTableTrampoline ; 0xF2 - $ Medallion Tablet
}

; ==============================================================================

; $030841-$030849 LOCAL JUMP LOCATION
SpritePrep_MovableMantle:
{
    LDA.w $0D00, X : CLC : ADC.b #$03 : STA.w $0D00, X

    ; Bleeds into the next function.
}
    
; $03084A-$030853 LOCAL JUMP LOCATION
SpritePrep_MoveRightOneTile:
{
    LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
    
    RTS
}

; ==============================================================================

; $030854-$030858 JUMP LOCATION
SpritePrep_MedallionTableTrampoline:
{
    JSL.l SpritePrep_MedallionTabletLong
    
    RTS
}

; ==============================================================================

; $030859-$03086C LOCAL JUMP LOCATION
SpritePrep_GoodSwitch:
{
    LDA.w $048E
    
    ; Are there only three rooms where these switches work?
    CMP.b #$CE : BEQ .BRANCH_ALPHA
    CMP.b #$04 : BEQ .BRANCH_ALPHA
        CMP.b #$3F : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b #$0D : STA.w $0F50, X

    .BRANCH_BETA
    
    ; Bleeds into the next function.
}

; $03086D-$03086D LOCAL JUMP LOCATION
SpritePrep_SwitchFacingUp:
{
    RTS
}

; ==============================================================================

; $03086E-$030872 LOCAL JUMP LOCATION
SpritePrep_OldSnitchLady:
{
    JSL.l SpritePrep_SnitchesLong
    
    RTS
}

; ==============================================================================

; $030873-$030873 LOCAL JUMP LOCATION
SpritePrep_DoNothing:
{
    RTS
}
    
; ==============================================================================

; $030874-$030877 DATA
Pool_SpritePrep_Rat:
{
    ; $030874
    .1
    db $00, $05
    
    ; $030876
    .2
    db $02, $08
}

; $030878-$030887 JUMP LOCATION
SpritePrep_Rat:
{
    LDY.w $0FFF
    LDA.w Pool_SpritePrep_Rat_1, Y : STA.w $0CD2, X
    LDA.w Pool_SpritePrep_Rat_2, Y : STA.w $0E50, X
    
    RTS
}

; ==============================================================================

; $030888-$03088D DATA
Pool_SpritePrep_Keese:
{
    ; $030888
    .damage_class
    db $80, $85
    
    ; $03088A
    .hp
    db 1, 4
    
    ; $03088C
    .prize_pack
    db 0, 7
}

; $03088E-$0308A3 JUMP LOCATION
SpritePrep_Keese:
{
    LDY.w $0FFF
    LDA.w Pool_SpritePrep_Keese_damage_class, Y : STA.w $0CD2, X
    LDA.w Pool_SpritePrep_Keese_hp, Y           : STA.w $0E50, X
    LDA.w Pool_SpritePrep_Keese_prize_pack, Y   : STA.w $0BE0, X
    
    RTS
}

; ==============================================================================

; $0308A4-$0308A9 DATA
Pool_SpritePrep_Rope:
{
    ; $0308A4
    .damage_class
    db 1, 5
    
    ; $0308A6
    .hp
    db 4, 8
    
    ; $0308A8
    .prize_pack
    db 1, 7
}

; $0308AA-$0308BF JUMP LOCATION
SpritePrep_Rope:
{
    LDY.w $0FFF
    LDA.w Pool_SpritePrep_Rope_damage_class, Y : STA.w $0CD2, X
    LDA.w Pool_SpritePrep_Rope_hp, Y           : STA.w $0E50, X
    LDA.w Pool_SpritePrep_Rope_prize_pack, Y   : STA.w $0BE0, X
    
    RTS
}

; ==============================================================================

; $0308C0-$0308C6 JUMP LOCATION
SpritePrep_Swamola:
{
    JSL.l Swamola_InitSegments
    JMP SpritePrep_CacheInitialCoords
}

; ==============================================================================

; $0308C7-$0308CE JUMP LOCATION
SpritePrep_Blind:
{
    JSR.w SpritePrep_Bosses
    JSL.l Blind_Initialize
    
    RTS
}

; ==============================================================================

; $0308CF-$0308D6 JUMP LOCATION
SpritePrep_Ganon:
{
    JSR.w SpritePrep_Bosses
    JSL.l Ganon_Initialize
    
    RTS
}

; ==============================================================================

; $0308D7-$0308DE DATA
Pool_SpritePep_HokBok:
{
    ; $0308D7
    .x_speeds
    db 16, -16,  16, -16
    
    ; $0308DB
    .y_speeds
    db 16,  16, -16, -16
}

; $0308DF-$0308FC JUMP LOCATION
SpritePrep_Hokbok:
{
    LDA.b #$03 : STA.w $0D90, X
    
    LDA.b #$08 : STA.w $0DA0, X
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA Pool_SpritePep_HokBok_x_speeds, Y : STA.w $0D50, X
    
    LDA Pool_SpritePep_HokBok_y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0308FD-$030900 JUMP LOCATION
SpritePrep_Vitreolus:
{
    JSR.w SpritePrep_Bosses
    
    RTS
}

; ==============================================================================

; $030901-$03090B JUMP LOCATION
SpritePrep_Gibo:
{
    LDA.b #$10 : STA.w $0F70, X
    
    LDA.b #$08 : STA.w $0ED0, X
    
    RTS
}

; ==============================================================================

; \tcrf(unconfirmed) Even though the octoballoon is only used once as a 
; single enemy throughout the whole game, this suggests that differentiated
; behavior was available for when multiples were used in the same screen.
; $03090C-$03090F DATA
SpritePrep_Octoballoon_timers:
{
    db $C0, $D0, $E0, $F0
}

; $030910-$03091A LOCAL JUMP LOCATION
SpritePrep_Octoballoon:
{
    TXA : AND.b #$03 : TAY
    
    LDA.w .timers, Y : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $03091B-$03092C LOCAL JUMP LOCATION
SpritePrep_EvilBarrier:
{
    PHX
    
    LDX.b $8A
    
    LDA.l $7EF280, X : PLX : AND.b #$40 : BEQ .not_dead
        LDA.b #$04 : STA.w $0DC0, X

    .not_dead

    ; Bleeds into the next function.
}
    
; $03092C-$03093A ALTERNATE ENTRY POINT
SpritePrep_GreatCatfish:
{
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    LDA.w $0D00, X : SEC : SBC.b #$0C : STA.w $0D00, X
    
    JMP SpritePrep_IgnoresProjectiles
}
    
; ==============================================================================

; $03093B-$03094C JUMP LOCATION
SpritePrep_ChattyAgahnim:
{
    LDA.w $0403 : AND.b #$40 : BEQ .not_triggered
        STZ.w $0DD0, X
        
        RTS
    
    .not_triggered
    
    JSL.l ChattyAgahnim_SpawnZeldaOnAltar
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $03094D-$030962 JUMP LOCATION
SpritePrep_Vitreous:
{
    JSR.w SpritePrep_Bosses
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    LDA.w $0D00, X : SEC : SBC.b #$10 : STA.w $0D00, X
    
    JSL.l Vitreous_SpawnSmallerEyesLong
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $030963-$030968 DATA
Pool_SpritePrep_Raven:
{
    ; $030963
    .bump_damage
    db $81, $88
    
    ; $030965
    .hp
    db 4, 8
    
    ; $030967
    .prize_pack
    db 6, 2
}

; $030969-$03097D LOCAL JUMP LOCATION
SpritePrep_Raven:
{
    LDY.w $0FFF
    LDA.w Pool_SpritePrep_Raven_bump_damage, Y : STA.w $0CD2, X
    LDA.w Pool_SpritePrep_Raven_hp, Y          : STA.w $0E50, X
    LDA.w Pool_SpritePrep_Raven_prize_pack, Y  : STA.w $0BE0, X

    ; Bleeds into the next function.
}
    
; $03097E-$030990 LOCAL JUMP LOCATION
SpritePrep_Vulture:
{
    LDA.b #$00 : STA.w $0F70, X
    
    LDA.w $0D10, X : AND.b #$10 : LSR #4 : STA.w $0D90, X
    
    BRA SpritePrep_Poe_setSubtype
}
    
; $030991-$03099A LOCAL JUMP LOCATION
SpritePrep_Poe:
{
    LDA.b #$0C : STA.w $0F70, X

    ; $030996 ALTERNATE ENTRY POINT
    .setSubtype

    LDA.b #$FE : STA.w $0E30, X

    ; Bleeds into the next funciton.
}
    
; $03099B-$03099B LOCAL JUMP LOCATION
SpritePrep_Pikit:
{
    RTS
}

; ==============================================================================

; $03099C-$0309D2 JUMP LOCATION
SpritePrep_BlindMaiden:
{
    LDA.l $7EF159 : AND.b #$08 : BNE .killSprite
        INC.w $0BA0, X
        
        LDA.l $7EF3CC : CMP.b #$06 : BEQ .killSprite
            LDA.b #$06 : STA.l $7EF3CC
            LDA.b #$00 : STA.l $7EF3D3
            
            PHX
            
            STZ.w $02F9
            
            JSL.l Tagalong_LoadGfx
            JSL.l Tagalong_Init
            
            PLX
            
            LDA.b #$00 : STA.l $7EF3CC
            
            RTS
        
    .killSprite
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0309D3-$0309D7 JUMP LOCATION
SpritePrep_Moldorm:
{
    JSL.l Moldorm_Initialize
    
    RTS
}

; ==============================================================================

; $0309D8-$0309DE JUMP LOCATION
SpritePrep_Bomber:
{
    LDA.b #$10 : STA.w $0F70, X
    
    BRA SpritePrep_Poe_setSubtype
}

; ==============================================================================

; $0309DF-$030A50 JUMP LOCATION
SpritePrep_BombShopEntity:
{
    INC.w $0BA0, X
    
    ; Spawn a normal set of bombs for sale
    LDA.b #$B5 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b $00 : SEC : SBC.b #$18 : STA.w $0D10, Y
        LDA.b $01       : SBC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : SEC : SBC.b #$18 : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00 : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0E80, Y : STA.w $0BA0, Y
        
    .spawn_failed
    
    ; Make sure the Misery Mire and Ice Palace dungeons have been completed.
    LDA.l $7EF37A : AND.b #$05 : CMP #$05 : BNE .dont_spawn_super_bomb
        ; Make sure smithy partner has been saved.
        LDA.l $7EF3C9 : AND.b #$20 : BEQ .dont_spawn_super_bomb
        
        ; Spawn the super bomb.
        LDA.b #$B5 : JSL.l Sprite_SpawnDynamically : BMI .super_bomb_spawn_failed
            LDA.b $00 : SEC : SBC.b #$38 : STA.w $0D10, Y
            LDA.b $01 : SBC.b #$00 : STA.w $0D30, Y
            
            LDA.b $02 : SEC : SBC.b #$18 : STA.w $0D00, Y
            LDA.b $03 : SBC.b #$00 : STA.w $0D20, Y
            
            LDA.b #$02 : STA.w $0E80, Y : STA.w $0BA0, Y
        
        .super_bomb_spawn_failed
    .dont_spawn_super_bomb
    
    RTS
}

; ==============================================================================

; $030A51-$030A58 JUMP LOCATION
SpritePrep_BullyAndBallGuy:
{
    JSL.l BullyAndBallGuy_SpawnBully
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; Purple Treasure chest initializer
; $030A59-$030A74 JUMP LOCATION
SpritePrep_ThiefChest:
{
    ; If Link already has the chest following him no reason to spawn another.
    LDA.l $7EF3CC : CMP.b #$0C : BEQ .self_terminate
        ; If chest has been opened already just kill next time it spawns.
        LDA.l $7EF3C9 : AND.b #$10 : BNE .self_terminate
            ; Chest hasn't been opened but Smithy also hasn't been saved...
            ; In other words, saving the smithy partner allows us to start on
            ; this side quest in the first place.
            LDA.l $7EF3C9 : AND.b #$20 : BEQ .self_terminate
                INC.w $0BA0, X
                
                RTS

    .self_terminate

    ; Bleeds into the next function.
}

; $030A75-$030A78 JUMP LOCATION
SpritePrep_Dwarf_self_terminate:
{
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $030A79-$030AEF JUMP LOCATION
SpritePrep_Dwarf:
{
    INC.w $0BA0, X
    
    LDA.l $7EF3CA : AND.w #$40 : BEQ .light_world
        ; In Darkworld he's a smithy frog :D
        
        LDA.l $7EF3C9 : AND.b #$20 : BNE .self_terminate
            LDA.l $7EF3CC : CMP.b #$00 : BNE .self_terminate
                LDA.b #$02 : STA.w $0E80, X
                
                RTS
    
    .light_world
    
    ; NOTE: The dwarves need this in order to not be passed through by
    ; the player. Questionable technique, but I guess they did what they
    ; had to do to ship the game, right?
    JSL.l Dwarf_SpawnDwarfSolidity
    
    ; in light world he can either be one or two dwarves?
    LDA.l $7EF3C9 : AND.b #$20 : BNE .partner_has_been_saved
        LDA.w $0D10, X : CLC : ADC.b #$02 : STA.w $0D10, X
        LDA.w $0D00, X : SEC : SBC.b #$03 : STA.w $0D00, X
        
        RTS
        
    .partner_has_been_saved
    
    LDA.w $0D10, X : CLC : ADC.b #$02 : STA.w $0D10, X
    LDA.w $0D00, X : SEC : SBC.b #$03 : STA.w $0D00, X
    
    JSR.w Smithy_SpawnOtherSmithy
    
    PHX : PHY : TYX
    
    JSL.l Dwarf_SpawnDwarfSolidity
    
    PLY : PLX 
    
    TYA : STA.w $0E90, X
    TXA : STA.w $0E90, Y
    
    LDA.l $7EF3C9 : AND.b #$80 : BEQ .they_dont_have_player_sword
        LDA.b #$05 : STA.w $0D80, X : STA.w $0D80, Y
    
    .they_dont_have_player_sword
    
    RTS
}

; ==============================================================================

; $030AF0-$030AF2 LOCAL JUMP LOCATION
SpritePrep_Babusu:
{
    JSR.w SpritePrep_MoveDownOneTile

    ; Bleeds into the next function.
}
    
; $030AF3-$030B00 LOCAL JUMP LOCATION
SpritePrep_Zoro:
{
    LDA.w $0E20, X : SEC : SBC.b #$9C : ASL : STA.w $0DE0, X
    
    DEC.w $0DC0, X
    
    RTS
}

; ==============================================================================

; UNUSED: Was it at one point intended that the speed of the laser beam
; be variable or configured here?
; $030B01-$030B02 DATA
SpritePrep_LaserEyeTrampoline_speeds:
{
    db $F8, $08
}

; ==============================================================================

; $030B03-$030B07 JUMP LOCATION
SpritePrep_LaserEyeTrampoline:
{
    JSL.l SpritePrep_LaserEyeLong
    
    RTS
}

; ==============================================================================

; $030B08-$030B0B JUMP LOCATION
SpritePrep_Popo:
{
    LDA.b #$07
    
    BRA SpritePrep_Bot_set_var
}
    
; $030B0C-$030B11 LOCAL JUMP LOCATION
SpritePrep_Bot:
{
    LDA.b #$0F
    
    .set_var
    
    STA.w $0DA0, X
    
    RTS
}

; ==============================================================================

; $030B12-$030B1B JUMP LOCATION
SpritePrep_MovableStatue:
{
    LDA.w $0D00, X : CLC : ADC.b #$07 : STA.w $0D00, X
    
    RTS
}

; ==============================================================================

; $030B1C-$030B2D JUMP LOCATION
SpritePrep_Bari:
{
    ; Height starts out at 6.
    LDA.b #$06 : STA.w $0F70, X
    
    ; HARDCODED: In this room the bari are confined until a large block
    ; is lifted.
    LDA.w $048E : CMP.b #$CE : BNE .not_that_one_ice_palace_room
        DEC.w $0DB0, X
    
    .not_that_one_ice_palace_room
    
    JMP.w Sprite_RedBari_set_new_electrication_delay
}
    
; ==============================================================================

; $030B2E-$030B33  LOCAL JUMP LOCATIONAN
SpritePrep_GreenStalfos:
{
    LDA.b #$09 : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $030B34-$030B3D JUMP LOCATION
SpritePrep_PushSwitch:
{
    LDA.w $0D00, X : CLC : ADC.b #$05 : STA.w $0D00, X
    
    RTS
}

; ==============================================================================

; $030B3E-$030B49 LOCAL JUMP LOCATION
SpritePrep_FireDebirando:
{
    LDA.b #$63 : STA.w $0E20, X
    
    JSL.l Sprite_LoadProperties
    
    DEC.w $0ED0, X
    
    ; NOTE: Hyrule magic was telling the truth. 0x63 is blue, 0x64 is red.
    ; 0x63 is really the pit, but both of end up with a 0x63 (pit) and a 0x64
    ; (debirando) and $0ED0, X decides whether the debirando itself is a red
    ; (fire) debirando or a normal one that doesn't shoot fireballs.

    ; Bleeds into the next function.
}

; $030B4A-$030B80 LOCAL JUMP LOCATION
SpritePrep_Debirando:
{
    INC.w $0ED0, X
    
    LDA.b #$00 : STA.w $0DF0, X
    
    LDA.b #$06 : STA.w $0DC0, X
    
    JSR.w SpritePrep_IgnoresProjectiles
    
    LDA.b #$64 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$60 : STA.w $0DF0, Y
        
        ; Give the pit the index of the actual debirando that was spawned.
        TYA : STA.w $0EB0, X
        
        ; Presumably discriminates between red and blue debirando.
        LDA.w $0ED0, X : STA.w $0ED0, Y
        
        PHX
        
        TAX
        
        ; Well that just confirms the above.
        LDA.w .palettes, X : STA.w $0F50, Y
        
        PLX
    
    .spawn_failed
    
    RTS
    
    ; $030B7E
    .palettes
    db $06, $08
}

; ==============================================================================

; Green Soldier (weak version) startup routine
; $030B81-$030B92 JUMP LOCATION
SpritePrep_Recruit:
{
    ; Pick a starting body direction and match it up with the starting head
    ; direction.
    JSL.l GetRandomInt : AND.b #$03 : STA.w $0DE0, X : STA.w $0EB0, X
    
    ; Start it on a 16 second timer.
    LDA.b #$10 : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $030B93-$030BA1 JUMP LOCATION
SpritePrep_WallCannon:
{
    LDA.w $0E20, X : SEC : SBC.b #$66 : STA.w $0DE0, X
    
    AND.b #$02 : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $030BA2-$030BA6 JUMP LOCATION
SpritePrep_ArcheryGameGuyTrampoline:
{
    JSL.l SpritePrep_ArcheryGameGuy
    
    RTS
}

; ==============================================================================

; Many nonhostile sprites use this as their initialization routine
; e.g. the sweeping lady
; $030BA7-$030BAA JUMP LOCATION
SpritePrep_IgnoresProjectiles:
{
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $030BAB-$030BB1 JUMP LOCATION
SpritePrep_FluteBoyAnimals:
{
    JSR.w Sprite_IsToRightOfPlayer
    
    TYA : STA.w $0DE0, X

    ; Bleeds into the next function.
}
    
; $030BB2-$030BBE LOCAL JUMP LOCATION
SpritePrep_FluteBoyOstrich:
{
    LDA.l $7EF34C : CMP.b #$02 : BCC .dont_have_flute
        STZ.w $0DD0, X
    
    .dont_have_flute
    
    BRA SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $030BBF-$030BC3 JUMP LOCATION
SpritePrep_DiggingGameGuyTrampoline:
{
    JSL.l SpritePrep_DiggingGameGuy
    
    RTS
}

; ==============================================================================

; $030BC4-$030BCE JUMP LOCATION
SpritePrep_GargoyleGrate:
{
    LDA.l $7EF2D8 : AND.b #$20 : BEQ .gateNotOpened
        STZ.w $0DD0, X

    .gateNotOpened

    ; Bleeds into the next function.
}

; $030BCF-$030BE3 JUMP LOCATION
SpritePrep_PullForRupees:
{
    INC.w $0BA0, X
    
    LDA.w $0D10, X : SEC : SBC.b #$08 : STA.w $0D10, X
    LDA.w $0D30, X       : SBC.b #$00 : STA.w $0D30, X
    
    RTS
}

; ==============================================================================

; $030BE4-$030BF0 DATA
Pool_SpritePrep_ShopKeeper_rooms:
{
    db $0F, $10, $00, $06, $18, $12, $1E, $FF
    db $1F, $23, $24, $25, $27
}

; $030BF1-$030C36 JUMP LOCATION
SpritePrep_ShopKeeper:
{
    INC.w $0BA0, X
    
    LDA.w $0E40, X : ORA.b #$02 : STA.w $0E40, X
    
    LDA.w $0F50, X : ORA.b #$0C : STA.w $0F50, X
    
    LDA.w $0E60, X : ORA.b #$10 : STA.w $0E60, X
    
    LDA.b $A0 
    
    LDY.b #$00
    
    .next_room
    
        CMP .rooms, Y : BEQ .room_match
            ; Wow... that could cause a bug real easily
    INY : BNE .next_room
    
    .room_match
    
    TYA
    
    JSL.l UseImplicitRegIndexedLocalJumpTable 
    dw $8C37 ; $030C37
    dw $8C43 ; $030C43
    dw $8C5C ; $030C5C
    dw $8C60 ; $030C60
    dw $8C67 ; $030C67 ; Chest game guy in Kakkariko
    dw $8C72 ; $030C72
    dw $8C8B ; $030C8B
    dw $8C72 ; $030C72
    dw $8C72 ; $030C72
    dw $8C8B ; $030C8B
    dw $8C91 ; $030C91
    dw $8C95 ; $030C95
    dw $8C8B ; $030C8B
}

; $030C37-$030C98 LOCAL JUMP LOCATION
SpritePrep_Shopkeeper_DarkWorldStock:
{
    LDA.b #$00
    LDY.b #$07
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    LDY.b #$08
    
    BRA .BRANCH_ALPHA
    
    ; $030C43 ALTERNATE ENTRY POINT
    SpritePrep_Shopkeeper_EastOfOutcasts:

    LDA.b #$00
    LDY.b #$09
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    LDA.b #$01
    LDY.b #$0D
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    LDA.b #$02
    LDY.b #$0B
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    RTS
    
    ; $030C5C ALTERNATE ENTRY POINT
    SpritePrep_LostWoodsChestGame:
    
    LDA.b #$04
    
    BRA .BRANCH_BETA
    
    ; $030C60 ALTERNATE ENTRY POINT
    SpritePrep_ChestGameGuy:
    
    LDA.b #$01 : STA.w $0DC0, X
    
    BRA .BRANCH_BETA

    ; $030C67 ALTERNATE ENTRY POINT
    SpritePrep_KakChestGame:

    LDA.b #$03

    .BRANCH_BETA

    STA.w $0E80, X
    
    LDA.b #$FF : STA.w $04C4
    
    RTS
    
    ; $030C72 ALTERNATE ENTRY POINT
    SpritePrep_Shopkeeper_StandardStock:
    
    LDA.b #$00
    LDY.b #$07
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    LDY.b #$0A
    
    .BRANCH_ALPHA
    
    LDA.b #$01
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    LDA.b #$02
    LDY.b #$0C
    
    JSL.l ShopKeeper_SpawnInventoryItem
    
    RTS
    
    ; $030C8B ALTERNATE ENTRY POINT
    SpritePrep_NiceThief_WithGift:
    
    LDA.b #$02
    
    .BRANCH_GAMMA
    
    STA.w $0E80, X
    
    RTS

    ; $030C91 ALTERNATE ENTRY POINT
    SpritePrep_NiceThief_Desert:

    LDA.b #$05
    
    BRA .BRANCH_GAMMA

    ; $030C95 ALTERNATE ENTRY POINT
    SpritePrep_NiceThief_Ice:

    LDA.b #$06
    
    BRA .BRANCH_GAMMA
}

; ==============================================================================

; $030C99-$030C9D DATA
SpritePrep_StoryTeller_1_rooms:
{
    db $0E, $0E, $12, $1A, $14
}

; $030C9E-$030CBD JUMP LOCATION
SpritePrep_StoryTeller_1:
{
    INC.w $0BA0, X
    
    LDA.b $A0
    
    LDY.b #$00
    
    .next_room
    
    CMP .rooms, Y : BEQ .room_match
        INY : BNE .next_room
    
    .room_match
    
    TYA : STA.w $0E80, X : BNE .not_first_room
        LDA.w $0D30, X : AND.b #$01 : BEQ .left_half_of_room
            INC.w $0E80, X
        
        .left_half_of_room
    .not_first_room
    
    RTS
}

; ==============================================================================

; $030CBE-$030CC0 DATA
SpritePrep_HumanMulti_1_rooms:
{
    db $03, $E1, $19
}

; $030CC1-$030CD4 JUMP LOCATION
SpritePrep_HumanMulti_1:
{
    INC.w $0BA0, X
    
    LDA.b $A0
    
    LDY.b #$00
    
    .next_room
    
        CMP .rooms, Y : BEQ .room_match
    INY : BNE .next_room
    
    .room_match
    
    TYA : STA.w $0E80, X
    
    RTS
}

; ==============================================================================

; $030CD5-$030CDD JUMP LOCATION
SpritePrep_Whirlpool:
{
    INC.w $0BA0, X
    
    LDA.b #$01 : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $030CDE-$030CEF JUMP LOCATION
SpritePrep_Elder:
{
    INC.w $0BA0, X
    
    LDA.b $A0 : CMP.b #$0A : BNE .notAginah
        INC.w $0E80, X
        
        ; Basically changes him to Aginah rather than Sahasralah.
        LDA.b #$0B : STA.w $0F50, X
    
    .notAginah
    
    RTS
}

; ==============================================================================

; $030CF0-$030CF1 DATA
SpritePrep_DashItem_event_masks:
{
    db $40, $20
}

; Dash Item set up function
; E.g. book of mudora and keys (also the fake tree on the OW)
; $030CF2-$030D45 JUMP LOCATION
SpritePrep_DashItem:
{
    ; If no, make it a dashable treetop.
    LDA.b $1B : BEQ .fake_tree_top
        LDA.b #$02 : STA.w $0F20, X
        
        LDA.b $A0 : CMP.b #$07 : BNE .key
            ; Hardcoded check to see if this is the library
            ; If not, probably a key?
            LDA.b $A1 : CMP.b #$01 : BNE .key
                ; If in the library, do we already have the BoM?
                LDA.l $7EF34E : BEQ .book_of_mudora
                    ; Otherwise, kill the sprite
                    STZ.w $0DD0, X 
                    
                    RTS
                    
                .book_of_mudora
                
                PHX
                
                LDA.b #$0E
                JSL.l GetAnimatedSpriteTile_variable
                
                PLX
                
                RTS
        
        .key
        
        LDA.w $0B9B : STA.w $0CBA, X : TAY
        
        INC.w $0B9B
        
        LDA.w $0403 : AND .event_masks, Y : BEQ .key_not_grabbed
            STZ.w $0DD0, X
        
        .key_not_grabbed
        
        ; Make this into a key item.
        INC.w $0DC0, X
        
        LDA.b #$08 : STA.w $0F50, X
        
        LDA.w $0E60, X : ORA.b #$20 : STA.w $0E60, X
        
        RTS
    
    .fake_tree_top
    
    LDA.b #$02 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; Kiki initialization routine
; $030D46-$030D58 JUMP LOCATION
SpritePrep_Kiki:
{
    INC.w $0BA0, X
    
    PHX
    
    LDX.b $8A : LDA.l $7EF280, X : PLX : AND.b #$20 : BEQ .entranceNotOpen
        ; Suicide if the entrance to the Dark Palace is opened.
        STZ.w $0DD0, X
    
    .entranceNotOpen
    
    RTS
}

; ==============================================================================

; Middle-aged Desert Guy initializer
; $030D59-$030D7E JUMP LOCATION
SpritePrep_MiddleAgedMan:
{
    INC.w $0BA0, X
    
    LDA.l $7EF3CC : CMP.b #$09 : BNE .not_already_followed
        STZ.w $0DD0, X
        
        RTS
        
    .not_already_followed
    
    CMP.b #$0C : BNE .thief_chest_not_following
        ; Put him into a mode where he'll open the chest.
        LDA.b #$02 : STA.w $0D80, X
    
    .thief_chest_not_following
    
    LDA.l $7EF3C9 : AND.b #$10 : BEQ .hasnt_opened_chest_yet
        LDA.b #$04 : STA.w $0D80, X
    
    .hasnt_opened_chest_yet
    
    RTS
}

; ==============================================================================

; $030D7F-$030D8D JUMP LOCATION
SpritePrep_BugNetKid:
{
    LDA.l $7EF34D : BEQ .dont_have_net
        LDA.b #$03 : STA.w $0D80, X
    
    .dont_have_net
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $030D8E-$030D93 DATA
Pool_SpritePrep_GanonHelpers:
{
    ; $030D8E
    .palette
    db 9, 7
    
    ; $030D90
    .hp
    db 8, 12
    
    ; $030D92
    .bump_damage
    db 3, 5
}

; $030D94-$030DC0 JUMP LOCATION
SpritePrep_GanonHelpers:
{
    LDA.w $0D10, X : LSR #4 : AND.b #$01 : STA.w $0D90, X : TAY
    
    LDA.w Pool_SpritePrep_GanonHelpers_palette, Y     : STA.w $0F50, X
    LDA.w Pool_SpritePrep_GanonHelpers_hp, Y          : STA.w $0E50, X
    LDA.w Pool_SpritePrep_GanonHelpers_bump_damage, Y : STA.w $0CD2, X
    
    LDA.b #$10
    JSR.w Sprite_ApplySpeedTowardsPlayer
    
    LDA.b #$20 : STA.w $0F80, X
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $030DC1-$030DC5 JUMP LOCATION
SpritePrep_ChainChompTrampoline:
{
    JSL.l SpritePrep_ChainChomp
    
    RTS
}

; ==============================================================================

; $030DC6-$030DD0 JUMP LOCATION
SpritePrep_BigFairy:
{
    LDA.b #$18 : STA.w $0F70, X
    
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $030DD1-$030DD9 JUMP LOCATION
SpritePrep_ElderWife:
{
    LDA.w $0D00, X : CLC : ADC.b #$08 : STA.w $0D00, X

    ; Bleeds into the next function.
}

; $030DDA-$030DDF JUMP LOCATION
SpritePrep_Lumberjacks:
SpritePrep_MadBatter:
{
    JSR.w SpritePrep_MoveRightOneTile
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $030DE0-$030DE6 JUMP LOCATION
SpritePrep_FortuneTeller:
{
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $030DE7-$030DE8 DATA
Pool_SpritePrep_Leever_palettes:
{
    db $0A, $02
}

; $030DE9-$030DFC JUMP LOCATION
SpritePrep_Leever:
{
    LDA.w $0D10, X : LSR #4 : AND.b #$01 : STA.w $0D90, X : TAY
    
    LDA.w .palettes, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $030DFD-$030E2F JUMP LOCATION
SpritePrep_HoboEntities:
{
    ; WTF: Is this test code? It spawns a bunch of normal bums...
    LDY.b #$0F
    
    .spawn_next_hobo
    
        PHY
        
        JSR.w Hobo_SpawnHobo
    PLY : DEY : BNE .spawn_next_hobo
    
    ; WTF: Then does another loop to kill them all?
    LDY #$0F
    
    .terminate_next_hobo
        
        LDA.w $0E20, Y : CMP.b #$2B : BNE .not_a_hobo
            LDA.b #$00 : STA.w $0DD0, Y
        
        .not_a_hobo
    DEY : BNE .terminate_next_hobo
    
    JSR.w Hobo_SpawnCampfire
    
    TXY
    
    LDA.l $7EF3C9 : AND.b #$01 : BEQ .dont_have_hobo_bottle
        LDA.b #$03 : STA.w $0D80
    
    .dont_have_hobo_bottle
    
    TYX
    
    LDA.b #$01 : STA.w $0BA0
    
    RTS
}

; ==============================================================================

; $030E30-$030E41 JUMP LOCATION
SpritePrep_MasterSword:
{
    LDA.w $0D10, X : CLC : ADC.b #$06 : STA.w $0D10, X
    LDA.w $0D00, X : ADC.b #$06 : STA.w $0D00, X
    
    RTS
}

; ==============================================================================

; $030E42-$030E45 LOCAL JUMP LOCATION
SpritePrep_RollerRightLeft:
{
    LDY.b #$00 : BRA SpritePrep_RollerLeftRight_moving_on_horiz
}

; $030E46-$030E4E LOCAL JUMP LOCATION
SpritePrep_RollerLeftRight:
{
    LDY.b #$01
    
    .moving_on_horiz
    
    LDA.w $0D10, X : EOR.b #$10 : BRA SpritePrep_RollerUpDown_set_length
}
    
; $030E4F-$030E52 LOCAL JUMP LOCATION
SpritePrep_RollerDownUp:
{
    LDY.b #$02 : BRA SpritePrep_RollerUpDown_moving_on_vert
}

; $030E53-$030E6A LOCAL JUMP LOCATION
SpritePrep_RollerUpDown:
{
    LDY.b #$03
    
    .moving_on_vert
    
    LDA.w $0D00, X
    
    .set_length
    
    AND.b #$10 : LSR #4 : STA.w $0D80, X : BEQ .short
        INC.w $0F60, X
    
    .short
    
    TYA : STA.w $0DE0, X
    
    RTS
}

; ==============================================================================

; $030E6B-$030E84 JUMP LOCATION
SpritePrep_Kodondo:
{
    LDA.w $0D10, X : CLC : ADC.b #$04 : STA.w $0D10, X
    
    LDA.w $0D00, X : SEC : SBC.b #$05 : STA.w $0D00, X
    LDA.w $0D20, X       : SBC.b #$00 : STA.w $0D20, X

    ; Bleeds into the next function.
}
    
; $030E85-$030E88 JUMP LOCATION
SpritePrep_Spark:
{
    DEC.w $0E30, X
    
    RTS
}

; ==============================================================================

; TODO:
; \tcrf(unverified, but only in the sense that we don't know its
; purpose.) Seems pretty clear that it's unused. Are these speeds?
; Graphics? Really hard to say for now.
; $030E89-$030EC0 DATA
Pool_Unused:
{
    db $00, $E0, $F8, $18
    db $E8, $18, $D0, $30
    db $E8, $18, $E0, $F8
    db $18, $00, $00, $FF
    
    db $FF, $00, $FF, $00
    db $FF, $00, $FF, $00
    db $FF, $FF, $00, $00
    db $C0, $D0, $D8, $D0
    
    db $F0, $F0, $00, $00
    db $10, $10, $28, $30
    db $30, $40, $FF, $FF
    db $FF, $FF, $FF, $FF
    
    db $00, $00, $00, $00
    db $00, $00, $00, $00
}

; ==============================================================================

; $030EC1-$030ED1 JUMP LOCATION
SpritePrep_LostWoodsBird:
{
    JSL.l GetRandomInt : AND.b #$1F : SEC : SBC.b #$10 : STA.w $0F80, X
    
    LDA.b #$40 : STA.w $0F70, X

    ; Bleeds into the next function.
}
    
; $030ED2-$030EEF JUMP LOCATION
SpritePrep_LostWoodsSquirrel:
{
    JSR.w Sprite_IsToRightOfPlayer
    
    LDA.b #$10
    
    CPY.b #$00 : BEQ .BRANCH_ALPHA
        LDA.b #$F0
    
    .BRANCH_ALPHA
    
    STA.w $0D50, X
    
    LDA.b #$FC
    
    LDY.w $069E : BPL .BRANCH_BETA
        LDA.b #$04
    
    .BRANCH_BETA
    
    STA.w $0D40, X
    STA.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $030EF0-$030EF1 DATA
Pool_SpritePrep_Bubble_x_speeds:
{
    db $10, $F0
}

; $030EF2-$030F07 JUMP LOCATION
SpritePrep_Bubble:
{
    LDA.w $0D10, X : LSR #4 : AND.b #$01 : TAY
    
    LDA.w .x_speeds, Y : STA.w $0D50, X
    
    LDA.b #$F0 : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $030F08-$030F0E JUMP LOCATION
SpritePrep_IceBallGenerator:
{
    JSR.w SpritePrep_Bosses
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $030F0F-$030F1B JUMP LOCATION
SpritePrep_ZoraKing:
{
    LDA.l $7EF356 : BEQ .noFlippers
        STZ.w $0DD0, X
        
        RTS
        
    .noFlippers
    
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $030F1C-$030F3E LOCAL JUMP LOCATION
SpritePrep_Bosses:
{
    LDA.w $0403 : BPL .bossNotDeadInHere
        ; If a heart piece has been obtained in this room do not spawn.
        
        PLA : PLA
        
        STZ.w $0DD0, X
        
        RTS
        
    .bossNotDeadInHere
    
    LDY.b #$0F
    
    ; Kill certain other sprites in the room based on SpriteData_Bump
    ; in sprite_properties.asm.
    .nextSprite
        
        PHX
        
        LDX.w $0E20, Y
        
        LDA.l SpriteData_Bump, X
        
        PLX
        
        AND.b #$10 : BNE .dontKillSprite
            LDA.b #$00 : STA.w $0DD0, Y
        
        .dontKillSprite
    DEY : BPL .nextSprite
    
    RTS
}

; ==============================================================================

; $030F3F-$030F4C JUMP LOCATION
SpritePrep_ArmosKnight:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$FF : STA.w $0DF0, X
    
    INC.w $0FF8
    
    JMP SpritePrep_MoveDownOneRightTwoTiles
}

; ==============================================================================

; Desert Palace barriers
; $030F4D-$030F6B JUMP LOCATION
SpritePrep_DesertBarrier:
{
    LDA.w $0B6A : STA.w $0D90, X
    
    INC.w $0B6A
    
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    LDA.w $0D10, X : LDY.b #$01 : CMP.b #$30 : BCC .set_direction
        ; Y = 0x02
        INY
        
        CMP.b #$E0 : BCS .set_direction
            ; Y = 0x03
            INY
        
    .set_direction
    
    TYA : STA.w $0DE0, X

    ; Bleeds into the next function.
}
    
; $030F6C-$030F6C JUMP LOCATION
SpritePrep_Armos:
{
    RTS
}

; ==============================================================================

; $030F6D-$030F70 DATA
Pool_SpritePrep_Octorock:
{
    ; $030F6D
    .bump_damage
    db 3, 5
    
    ; $030F6F
    .hp
    db 2, 4
}

; $030F71-$030F89 JUMP LOCATION
SpritePrep_Octorock:
{
    LDY.w $0FFF
    LDA.w Pool_SpritePrep_Octorock_hp, Y          : STA.w $0E50, X
    LDA.w Pool_SpritePrep_Octorock_bump_damage, Y : STA.w $0CD2, X
    
    JSL.l GetRandomInt : AND.b #$7F : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $030F8A-$030F94 JUMP LOCATION
SpritePrep_GiantMoldorm:
{
    JSR.w SpritePrep_Bosses
    
    INC.w $0BA0, X
    
    JSL.l Sprite_InitializedSegmented
    
    RTS
}

; ==============================================================================

; $030F95-$030F9C JUMP LOCATION
SpritePrep_Lanmola:
{
    JSR.w SpritePrep_Bosses
    JSL.l Lanmola_FinishInitialization
    
    RTS
}

; ==============================================================================

; $030F9D-$030FA1 LOCAL JUMP LOCATION
SpritePrep_SpikeTrap:
{
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    BRA SpritePrep_CacheInitialCoords
}
    
; $030FA2-$030FA6 LOCAL JUMP LOCATION
SpritePrep_ZoraAndFireball:
{
    LDA.b #$40 : STA.w $0DF0, X

    ; Bleeds into the next function.
}
    
; $030FA7-$030FBAF LOCAL JUMP LOCATION
SpritePrep_GerudoMan:
{
    LDA.b #$08 : CLC : ADC.w $0D10, X : STA.w $0D10, X

    ; Bleeds into the next function.
}
    
; $030FB0-$030FC8 LOCAL JUMP LOCATION
SpritePrep_Toppo:
SpritePrep_Kyameron:
SpritePrep_CacheInitialCoords:
{
    ; Cache the starting coordinates so we can use them for reference.
    LDA.w $0D10, X : STA.w $0D90, X
    LDA.w $0D30, X : STA.w $0DA0, X
    
    LDA.w $0D00, X : STA.w $0DB0, X
    LDA.w $0D20, X : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $030FC9-$030FCE JUMP LOCATION
SpritePrep_WalkingZora:
{
    LDA.b #$60 : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $030FCF-$030FD5 BRANCH LOCATION
SpritePrep_StandardGuard_indoors:
{
    ASL.w $0BE0, X : LSR.w $0BE0, X
    
    RTS
}

; ==============================================================================

; $030FD6-$031000 JUMP LOCATION
SpritePrep_Soldier:
{
    LDA.w $0E30, X : BEQ .BRANCH_ALPHA
        LDY.b #$00
        
        AND.b #$07 : CMP.b #$05 : BCS SpritePrep_TrooperAndArcherSoldier_special_turn
            DEC : EOR.b #$01 : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    LDA.b $1B : BNE SpritePrep_StandardGuard_indoors
        LDA.b #$01 : STA.w $0D80, X
        
        LDA.b #$70 : STA.w $0DF0, X
        
        JSR.w Sprite_DirectionToFacePlayer
        
        TYA : STA.w $0DE0, X : STA.w $0EB0, X

        ; Bleeds into the next function.
}

; $031001-$03103A JUMP LOCATION
SpritePrep_TrooperAndArcherSoldier:
{
    ; OPTIMIZE: Wtf is this branch.
    BRA .BRANCH_GAMMA

    .special_turn
    
    BEQ .BRANCH_DELTA
        LDY.b #$04
    
    .BRANCH_DELTA
    
    LDA.w $0E30, X : LSR #3 : AND.b #$03 : STA.b $00
    
    TYA : ORA.b $00 : TAY
    
    LDA.w .unknown, Y : STA.w $0DA0, X
    
    LDA.w $0B6B, X : AND.b #$0F : ORA #$50 : STA.w $0B6B, X
    
    .BRANCH_GAMMA
    
    LDA.b $11 : PHA
    
    STZ.b $11
    
    SEC : ROR.w $0CAA, X
    
    JSR.w SpriteActive_Main
    JSR.w SpriteActive_Main
    
    ASL.w $0CAA, X
    
    PLA : STA.b $11
    
    RTS
    
    .unknown
    db $00, $02, $01, $03, $06, $04, $05, $07
}

; ==============================================================================

; TODO:
; UNUSED: Not confirmed yet, but strongly suspected.
; $03103B-$031042 DATA
Pool_SpritePrep_TalkingTree_unknown_0:
{
    db 0, 2, 1, 3, 6, 4, 5, 7
}

; ==============================================================================

; $031043-$031063 JUMP LOCATION
SpritePrep_TalkingTree:
{
    INC.w $0BA0, X
    
    LDA.w $0D10, X : SEC : SBC.b #$08 : STA.w $0D10, X
    LDA.w $0D30, X       : SBC.b #$00 : STA.w $0D30, X
    
    LDA.b #$00 : JSL.l TalkingTree_SpawnEyes
    LDA.b #$01 : JSL.l TalkingTree_SpawnEyes
    
    RTS
}

; ==============================================================================

; $031064-$031074 JUMP LOCATION
SpritePrep_CrystalSwitch:
{
    LDA.l $7EC172 : AND.b #$01 : TAY
    
    LDA.w Sprite_CrystalSwitch_palettes, Y : ORA.w $0F50, X : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $031075-$0310C1 JUMP LOCATION
SpritePrep_FluteBoy:
{
    INC.w $0BA0, X
    
    LDA.l $7EF3CA : ASL : ROL : ROL
    
    AND.b #$01 : STA.w $0E80, X : BEQ .in_light_world
        ; See if the dark world flute boy has been arborated.
        LDA.l $7EF3C9 : AND.b #$08 : BNE .already_arborated
            LDA.l $7EF34C : CMP.b #$02 : BCC .BRANCH_GAMMA
                BEQ .BRANCH_DELTA
        
        .already_arborated
        
        LDA.b #$03 : STA.w $0DC0, X ; Put him in his tree form initially
        
        LDA.b #$05 : STA.w $0D80, X; Set his AI pointer to do nothing?
        
        BRA .BRANCH_GAMMA
        
        .BRANCH_DELTA
        
        LDA.b #$01 : STA.w $0DC0, X
        
        .BRANCH_GAMMA
        
        JSR.w SpritePrep_MoveRightOneTile
        
        LDA.w $0D00, X : SEC : SBC.b #$08 : STA.w $0D00, X
        
        RTS
    
    .in_light_world
    
    LDA.l $7EF34C : CMP.b #$02 : BCC .BRANCH_EPSILON
        STZ.w $0DD0, X ; Kill the sprite if we already have the flute.
        
        RTS
    
    .BRANCH_EPSILON

    ; Bleeds into the next function.
}

; $0310C2-$0310CB JUMP LOCATION
SpritePrep_MoveRightSevenPixels:
{
    LDA.w $0D10, X : CLC : ADC.b #$07 : STA.w $0D10, X
    
    RTS
}

; ==============================================================================

; $0310CC-$0310D4 JUMP LOCATION
SpritePrep_MoveDownOneTile:
{
    LDA.w $0D00, X : CLC : ADC.b #$08 : STA.w $0D00, X

    ; Bleeds into the next function.
}
    
; $0310D5-$0310D5 JUMP LOCATION
SpritePrep_Zazakku:
{
    RTS
}

; ==============================================================================

; $0310D6-$0310DF JUMP LOCATION
SpritePrep_HylianPlaque:
{
    INC.w $0BA0, X
    
    LDA.b $8A : CMP.b #$30 : BEQ SpritePrep_MoveRightSevenPixels
        RTS
}

; ==============================================================================

; $0310E0-$0310EF JUMP LOCATION
SpritePrep_Stalfos:
{
    LDA.w $0D10, X : AND.b #$10 : STA.w $0E30, X : BEQ .is_red_stalfos
        LDA.b #$07 : STA.w $0F50, X
    
    .is_red_stalfos
    
    RTS
}

; ==============================================================================

; $0310F0-$0310F9 LOCAL JUMP LOCATION
SpritePrep_KholdstareShell:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$C0 : STA.w $0E00, X
    
    BRA SpritePrep_down_one_right_two_tiles
}
    
; $0310FA-$031106 LOCAL JUMP LOCATION
SpritePrep_Kholdstare:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$03 : STA.w $0D80, X
    
    JSR.w SpritePrep_IgnoresProjectiles
    
    BRA SpritePrep_down_one_right_two_tiles
}
    
; $031107-$031109 LOCAL JUMP LOCATION
SpritePrep_Bumper:
{
    JSR.w SpritePrep_IgnoresProjectiles

    ; Bleeds into the next function.
}
    
; $03110A-$031115 LOCAL JUMP LOCATION
SpritePrep_MoveDownOneRightTwoTiles:
SpritePrep_down_one_right_two_tiles:
{
    PHX : TXA : CLC : ADC.b #$10 : TAX
    
    JSR.w SpritePrep_MoveDownOneTile
    
    PLX
    
    BRA SpritePrep_MoveDownOneTile
}

; ==============================================================================

; $031116-$031121 DATA
Pool_SpritePrep_HardHatBeetle:
{
    ; $031116
    .palette
    db 6, 8
    
    ; $031118
    .hp
    db 32, 6
    
    ; $03111A
    .unknown_0
    db $10, $0C
    
    ; $03111C
    .ai_state
    db $01, $03
    
    ; $03111E
    .unknown_1
    db $02, $06
    
    ; $031120
    .bump_damage
    db 5, 3
}

; Charging octopi prep routine
; $031122-$031150 JUMP LOCATION
SpritePrep_HardHatBeetle:
{
    LDY.b #$00
    
    ; Depending on whether the X coordinate is odd or even (in multiples
    ; of 16 pixels), configure it as a red or a blue hardhat beetle.
    LDA.w $0D10, X : AND.b #$10 : BEQ .BRANCH_ALPHA
        INY
    
    .BRANCH_ALPHA
    
    LDA.w Pool_SpritePrep_HardHatBeetle_palette, Y     : STA.w $0F50, X
    LDA.w Pool_SpritePrep_HardHatBeetle_hp, Y          : STA.w $0E50, X
    LDA.w Pool_SpritePrep_HardHatBeetle_unknown_0, Y   : STA.w $0D90, X
    LDA.w Pool_SpritePrep_HardHatBeetle_ai_state, Y    : STA.w $0D80, X
    LDA.w Pool_SpritePrep_HardHatBeetle_unknown_1, Y   : STA.w $0BE0, X
    LDA.w Pool_SpritePrep_HardHatBeetle_bump_damage, Y : STA.w $0CD2, X
    
    RTS
}

; ==============================================================================

; $031151-$03115B JUMP LOCATION
SpritePrep_Helmasaur:
{
    ; Effectively is the speed of the sprite.
    LDA.b #$10 : STA.w $0D90, X
    
    LDA.b #$01 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $03115C-$031169 LOCAL JUMP LOCATION
SpritePrep_Fairy:
{
    JSL.l GetRandomInt : AND.b #$01
    
    STA.w $0D90, X
    
    EOR.b #$01 : STA.w $0DE0, X

    ; Bleeds into the next function.
}
    
; $03116A-$03116D LOCAL JUMP LOCATION
SpritePrep_HeartRefill:
SpritePrep_GreenRupee:
SpritePrep_BlueRupee:
SpritePrep_RedRupee:
SpritePrep_OneBombRefill:
SpritePrep_FourBombRefill:
SpritePrep_EightBombRefill:
SpritePrep_SmallMagicRefill:
SpritePrep_FullMagicRefill:
SpritePrep_FiveArrowRefill:
SpritePrep_TenArrowRefill:
{
    LDA.b $1B : BNE SpritePrep_ShieldPickup
        ; Bleeds into the next function.
}
    
; $03116E-$031173 LOCAL JUMP LOCATION
SpritePrep_DashTriggeredSprite:
{
    INC.w $0E90, X
    
    INC.w $0BA0, X

    ; Bleeds into the next function.
}
    
; $031174-$031174 LOCAL JUMP LOCATION
SpritePrep_ShieldPickup:
{
    RTS
}

; ==============================================================================

; $031175-$031192 LOCAL JUMP LOCATION
SpritePrep_GoodBee:
{
    LDA.l $7EF35C : ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F
    AND.b #$08 : BEQ .dont_have_good_bee
        STZ.w $0DD0, X
    
    .dont_have_good_bee
    
    INC.w $0E90, X
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $031193-$031194 DATA
SpritePrep_Agahnim_palettes:
{
    db $0B, $07
}

; $031195-$0311AD JUMP LOCATION
SpritePrep_Agahnim:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$00 : STA.w $0DC0, X
    
    LDA.b #$03 : STA.w $0DE0, X
    
    JSR.w SpritePrep_MoveDownOneRightTwoTiles
    
    LDY.w $0FFF
    
    LDA.w .palettes, Y : STA.w $0F50, X

    ; Bleeds into the next function.
}

; $0311AE-$0311AE JUMP LOCATION
SpritePrep_DoNothing_2:
{
    RTS
}

; ==============================================================================

; $0311AF-$0311B3 JUMP LOCATION
SpritePrep_EyegoreTrampoline:
{
    JSL.l SpritePrep_Eyegore
    
    RTS
}

; ==============================================================================

; $0311B4-$0311B9 JUMP LOCATION
SpritePrep_GuruGuruBar:
{
    INC.w $0DA0, X
    
    JMP SpritePrep_IgnoresProjectiles
}

; ==============================================================================

; $0311BA-$0311C4 JUMP LOCATION
SpritePrep_TrinexxComponents:
{
    JSR.w SpritePrep_Bosses
    JSL.l TrinexxComponents_InitializeLong
    JSR.w SpritePrep_TerminateCachedSprites
    
    RTS
}

; ==============================================================================

; $0311C5-$0311CB LOCAL JUMP LOCATION
SpritePrep_HelmasaurKing:
{
    JSR.w SpritePrep_Bosses
    JSL.l HelmasaurKing_Initialize

    ; Bleeds into the next function.
}

; $0311CC-$0311D6 LOCAL JUMP LOCATION
SpritePrep_TerminateCachedSprites:
{
    LDY.b #$0F
    LDA.b #$00
    
    .termination_loop
    
        STA.w $1D00, Y
    DEY : BPL .termination_loop
    
    RTS
}

; ==============================================================================

; $0311D7-$0311DB LOCAL JUMP LOCATION
SpritePrep_SpikeBlock:
{
    LDA.b #$20 : STA.w $0D50, X

    ; Bleeds into the next function.
}

; $0311DC-$0311E7 LOCAL JUMP LOCATION
SpritePrep_Stal:
{
    LDA.b #-16 : STA.w $0D40, X
    
    JSR.w Sprite_MoveVert
    
    STZ.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0311E8-$0311F0 LOCAL JUMP LOCATION
SpritePrep_Terrorpin:
{
    LDA.b #$04 : STA.w $0DC0, X
    
    JSR.w SpritePrep_IgnoresProjectiles
    
    RTS
}

; ==============================================================================

; $0311F1-$0311F9 JUMP LOCATION
SpritePrep_Arghus:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$18 : STA.w $0F70, X
    
    RTS
}

; ==============================================================================

; $0311FA-$03122E JUMP LOCATION
SpritePrep_Arrgi:
{
    JSR.w SpritePrep_Bosses
    
    JSL.l GetRandomInt : STA.w $0E80, X
    
    CPX.b #$0D : BNE .BRANCH_ALPHA
        STZ.w $0B0A
        STZ.w $0B0B
        
        PHX
        
        LDX.b #$00
        
        JSL.l Arrghus_HandlePuffs_long
        
        PLX
    
    .BRANCH_ALPHA
    
    LDA.w $0B0F, X : STA.w $0D10, X
    LDA.w $0B1F, X : STA.w $0D30, X
    
    LDA.w $0B2F, X : STA.w $0D00, X
    LDA.w $0B3F, X : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $03122F-$031247 JUMP LOCATION
SpritePrep_Mothula:
{
    JSR.w SpritePrep_Bosses
    
    LDA.b #$50 : STA.w $0DF0, X
    
    INC.w $0BA0, X
    
    LDA.b #$02 : STA.w $0DC0, X
    
    INC.w $041A
    
    LDA.b #$70 : STA.w $0DB0, X
    
    RTS
}

; ==============================================================================

; $031248-$03124C JUMP LOCATION
SpritePrep_BubbleGroupTrampoline:
{
    JSL.l SpritePrep_BubbleGroup
    
    RTS
}

; ==============================================================================

; $03124D-$03124D JUMP LOCATION
SpritePrep_CrystalMaiden:
{
    RTS
}

; ==============================================================================

; $03124E-$031255 JUMP LOCATION
SpritePrep_BigKey:
{
    JSR.w SpritePrep_MoveRightOneTile
    
    LDA.b #$FF : STA.w $0E30, X

    ; Bleeds into the next function.
}

; $031256-$031261 JUMP LOCATION
SpritePrep_LoadBigKeyGfx:
{
    PHX : PHY
    
    LDA.b #$22
    
    JSL.l GetAnimatedSpriteTile_variable
    
    PLY : PLX
    
    BRA SpritePrep_Key_set_item_drop
}

; $031262-$031270 JUMP LOCATION
SpritePrep_Key:
{
    LDA.b #$FF : STA.w $0E30, X
    
    ; $031267 ALTERNATE ENTRY POINT
    .set_item_drop
    
    ; WTF: Why is this necessary? Big keys and keys shouldn't drop anything
    ; after they die. Maybe we'll know some day.
    LDA.w $0B9B : STA.w $0CBA, X
    
    INC.w $0B9B
    
    RTS
}

; ==============================================================================

; $031271-$031282 LOCAL JUMP LOCATION
SpriteActive_Main:
{
    LDA.w $0E20, X
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    
    ; Sets up a stack jump table (Weird isn't it?).
    LDA SpriteActive_Table, Y : DEC : PHA
    
    SEP #$30
    
    RTS
}

; ==============================================================================
