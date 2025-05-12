; ===============================================================================

; WRAM Map
; WIP will eventually replace the WRAM.log

; https://github.com/spannerisms/jpdasm/blob/master/symbols_wram.asm
; Other sources to look at:
; https://www.p4plus2.com/Zelda%20Dissasembly.txt
; https://www.p4plus2.com/zelda/ram.php

; ===============================================================================

; Shorthand legend:
; Addr = Address
; Anc = Ancilla
; APU = Audio Processing Unit
; AUX = Auxiliary
; BG = Background
; BL = Bottom Left
; BR = Bottom Right
; Calc = Calculate/Calculation
; Cam = Camera
; CGRAM = Color Generator RAM
; Coord = Coordinate
; Decomp = Decompress/Decompression
; Des = Designation
; Diff = Difference
; Dir = Direction
; DMA = Direct Memory Access
; Dun = Dungeon
; DWall = Diagonal Wall
; GFX = Graphics
; H = Horizontal
; HDMA = Horizontal Direct Memory Access
; HV = H/V or Horizontal/Vertical
; Init = Initial
; IO = I/O or Input/Output
; IRQ = Interupt ReQuest
; NMI = Non-Maskable Interupt
; Num = Number
; Manip = Manipulate/Manipuable
; MULT = Multiply/Multiplication
; OAM = Object Attribute Memory
; Obj = Object
; OW = Overworld
; Poly = Polyhedral
; Pos = Position
; PPU = Picture Processing Unit
; Ptr = Pointer
; SFX = Sound Effects
; Src = Source
; TL = Top Left
; TM = Tile Map
; TR = Top Right
; V = Vertical
; Val = Value
; VRAM = Video RAM

; ===============================================================================
; Start of bank 0x7E and direct page memory
; ===============================================================================
struct WRAM $7E0000
{
    
    ; ===========================================================================
    ; Page 0x00
    ; ===========================================================================

    ; Note that these addresses are only one byte and you can assume that they
    ; are $7E00XX where XX is the byte address you see below. These can
    ; technically change to a different direct page however ALTTP never makes
    ; use of changing the direct page feature and leaves it at #$0000 the
    ; entire game.

    ; TODO: Go back and check for word and long calls for each of these for
    ; other uses.

    ; $00[0x10] (Main)
    .Work: skip $10
        ; Generic work WRAM. Used for temporary calculations. Should not be used
        ; for anything that needs to be used accross multiple frames.

    ; $10[0x01] (Main)
    .Module: skip $01
        ; Main Module index. This controls which top level subprogram
        ; we're currently in.
        ; 0x00 - Triforce / Zelda startup screens
        ; 0x01 - Game Select screen
        ; 0x02 - Copy Player Mode
        ; 0x03 - Erase Player Mode
        ; 0x04 - Name Player Mode
        ; 0x05 - Loading Game Mode
        ; 0x06 - Pre Dungeon Mode
        ; 0x07 - Dungeon Mode
        ; 0x08 - Pre Overworld Mode
        ; 0x09 - Overworld Mode
        ; 0x0A - Pre Overworld Mode (special overworld)
        ; 0x0B - Overworld Mode (special overworld)
        ; 0x0C - I think we can declare this one unused. TODO: Confirm this.
        ; 0x0D - Blank Screen
        ; 0x0E - Text Mode/Item Screen/Map
        ; 0x0F - Closing Spotlight
        ; 0x10 - Opening Spotlight
        ; 0x11 - Happens when you fall into a hole from the OW.
        ; 0x12 - Death Mode
        ; 0x13 - Boss Victory Mode (refills stats)
        ; 0x14 - History Mode
        ; 0x15 - Module for Magic Mirror
        ; 0x16 - Module for refilling stats after boss.
        ; 0x17 - Restart mode (save and quit)
        ; 0x18 - Ganon exits from Agahnim's body. Chase Mode.
        ; 0x19 - Triforce Room scene
        ; 0x1A - End sequence
        ; 0x1B - Screen to select where to start from (House, sanctuary, etc.)

    ; $11[0x01] (Main)
    .Submodule: skip $01
        ; Submodule Index (See $B0)

    ; $12[0x01] - (NMI)
    .NMIWaitFlag: skip $01
        ; NMI Boolean. If set to zero, the game will wait at a certain loop until
        ; NMI executes. The NMI interrupt generally sets it to one after it's
        ; done so that the game can continue doing things other than updating
        ; the screen. This prevents the NMI updates from running more than once
        ; per frame, preventing lag and preventing lost player input.

    ; $13[0x01] - (Main, NMI)
    .Brightness: skip $01
        ; Mirror of INIDISP, which controls the screen brightness and force blank
        ; status.

    ; $14[0x01] - (Main, NMI, Tilemap)
    .BGTileMapUpdateFlag: skip $01
        ; Value based flag, that if nonzero, causes the tilemap to update from
        ; one of several source addresses. Some are in WRAM, but most are in rom.
        ; However, the WRAM address $001000 is most commonly used as the source
        ; address buffer. The others are used for highly specific parts of the
        ; game code, such as the intro.

    ; $15[0x01] - (CGRAM, Main, NMI)
    .CGRAMUpdateFlag: skip $01
        ; Flag indicating to update CGRAM (0x200 bytes)

    ; $16[0x01] - (Main, NMI, Tilemap)
    .BG3TileMapUpdateFlag: skip $01
        ; Flag indicating to update the HUD portion of the BG3 tilemap with
        ; source address $7EC700 (0x14A bytes).

    ; $17[0x01] - (GFX, Main, NMI)
    .DMAMask: skip $01
        ; Value based flag that, if nonzero, indexes one of a set of specialized
        ; subroutines to execute. Examples of these are updating portions of the
        ; sprite chr region in VRAM.

    ; $18[0x01] - (GFX, Main, NMI)
    .GFXUpdateFlag: skip $01
        ; If nonzero, will read from a buffer starting at $001100, which will
        ; indicate a series of 1 or more packets of data to transfer of VRAM.
        ; Each packet is limited to at most 0xff bytes. The usage of this
        ; flag and buffer interface is known to be limited to the dungeon
        ; module. Note that the buffer $001100 can also be used differently
        ; with some of the specialized routines that $17 can utilize.

    ; $19[0x01] - (GFX, Main, NMI)
    .VRAMIncramentalUpload: skip $01
        ; When nonzero, will trigger a transfer from $7FXXXX to VRAM
        ; address $YY00
        ; XXXX is specified by variable IncramentalUploadBufferLow
        ; YY   is specified by this variable
        ; Seems to be used primarily for updating a strip of tilemap
        ; data, as it can only trigger a transfer of 0x200 bytes. That would
        ; suggest that it's designed to upload tilemap changes piecemeal over
        ; several consecutive frames.

    ; $1A[0x01] - (Main)
    .FrameCounter: skip $01
        ; Frame Counter that, given its 8-bit size, wraps after 255 back to 0.
        ; It is often used for calculating timing delays.
        ; Example: Generate a sparkle effect if the value of $1A & 0x07 is zero.
        ; This would produce a sparkle effect once every eight frames.

    ; $1B[0x01] - (Dungeon, Overworld)
    .IsIndoors: skip $01
        ; Flag that is set to 1 if the player is in indoors and 0 otherwise.

    ; $1C[0x01] - (Main, NMI)
    .MainScreenDes: skip $01
        ; Main Screen Designation. To be written to SNES.BGAndOBJEnableMainScreen
        ; during NMI.
        ; ...o 4321
        ; o - OAM layer enabled
        ; 1 - BG1 enabled
        ; 2 - BG2 enabled
        ; 3 - BG3 enabled
        ; 4 - BG4 enabled

    ; $1D[0x01] - (Main, NMI)
    .SubScreenDes: skip $01
        ; Sub Screen Designation. To be written to SNES.BGAndOBJEnableSubScreen
        ; during NMI.
        ; ...o 4321
        ; o - OAM layer enabled
        ; 1 - BG1 enabled
        ; 2 - BG2 enabled
        ; 3 - BG3 enabled
        ; 4 - BG4 enabled

    ; $1E[0x01] - (Main, NMI)
    .MainWindowMaskDes: skip $01
        ; Window Mask Activation. To be written to SNES.WindowMaskDesMainScreen
        ; during NMI.

    ; $1F[0x01] - (Main, NMI)
    .SubWindowMaskDes: skip $01
        ; Subscreen Window Mask Activation. To be written to
        ; SNES.WindowMaskDesSubScreen during NMI.

    ; $20[0x02] - (Player)
    .PlayerYCoord: skip $02
        ; Player's Y-Coordinate (mirrored at $0FC4).

    ; $22[0x02] - (Player)
    .PlayerXCoord:
        ; Player's X-Coordinate (mirrored at $0FC2).

    ; $22[0x01] - (Attract)
    .AttractModule: skip $01
        ; Used as a step counter for the attract mode.

    ; $23[0x01] - (Attract)
    .AttractSubModule: skip $01
        ; Indicates the current sequence being run, such as the mode 7 zoom in,
        ; or the maiden being teleported to the Dark World.

    ; $24[0x02] - (Dungeon, Overworld)
    .PlayerZCoord:
        ; 0xFFFF usually, but if the Player is elevated off the ground it is
        ; considered to be his Z coordinate. That is, it's his height off of
        ; the ground.

    ; $25[0x01] - (Attract)
    .AttractZoomControl: skip $01
        ; During the mode 7 zoom in on Hyrule Castle, this acts as a barrier
        ; for another counter ($0637) that toggles between 0 and 1 every other
        ; frame. When 0, $0637 is decremented and the zoom is increased
        ; slightly. In effect, this is to control the rate of the zooming.

    ; $26[0x01] - (Player)
    .PlayerPushDir:
        ; The direction(s) that Player is pushing against.
        ; ----udlr
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $26[0x01] - (Attract)
    .Attract2bppGFXIndex: skip $01
        ; Indicates the current 2bpp graphic. Always a multiple of 2, because it
        ; indexes an array of words.

    ; $27[0x01] - (Player)
    .PlayerYCollisionRecoil:
        ; The player's Y Recoil. This will be reset every frame Player is not
        ; in recoil state.

    ; $27[0x01] - (Attract)
    .AttractNextLegendFlag: skip $01
        ; Flag indicating whether to display a new 2bpp graphic.

    ; $28[0x01] - (Player)
    .PlayerXCollisionRecoil:
        ; The player's X Recoil. This will be reset every frame Player is not
        ; in recoil state.

    ; $28[0x01] - (Attract)
    .AttractAgahXCoord: skip $01
        ; Agahnim's base X coordinate relative to the screen.

    ; $29[0x01] - (Player)
    .PlayerZRecoil:
        ; The player's Z Recoil. This will be reset every frame Player is not
        ; in recoil state.

    ; $29[0x01] - (Attract)
    .AttractAgahYCoord: skip $01
        ; Agahnim's base Y coordinate relative to the screen.

    ; $2A[0x01] - (Player)
    .PlayerYSubCoord: skip $01
        ; The player's subpixel Y coordinate
        ; TODO: Also has a use in the attract mode like most of this early WRAM.

    ; $2B[0x01] - (Player)
    .PlayerXSubCoord: skip $01
        ; The player's subpixel X coordinate

    ; $2C[0x01] - (Player, Junk)
    .Junk_2C:
        ; Only written to in one place in player code, and it's always a zero.
        ; Given the limited scope of this use compared to the one below, it
        ; could be considered Free RAM, so long as there's an understanding
        ; that its use is shared with attract mode (see AttractTimer).

    ; $2C[0x01] - (Attract)
    .AttractTimer: skip $01
        ; Used as a countdown timer on the throne room screen. When it reaches
        ; 0x1e, it is used to begin the fade to the next scene by decreasing the
        ; brightness by one on frames where this variable has an even value.

    ; $2D[0x01] - (Player)
    .PlayerAnimationTimer:
        ; Acts as a timer for certain animations to advance PlayerAnimationStep.

    ; $2D[0x02] - (Attract)
    .AttractUnknownPtr: skip $01
        ; Appears to serve as a pointer to sprite data of some sort. Exact scope
        ; of usage during this mode not known at this time.

    ; $2E[0x01] - (Player, OAM)
    .PlayerAnimationStep: skip $01
        ; Animation steps: seems to cycle from 0 to 5 then repeats. Seems that
        ; other submodes of the player logic use a different number of steps
        ; (spin attack maybe?)

    ; $2F[0x01] - (Player)
    .PlayerHeading: skip $01
        ; 0 - up
        ; 2 - down
        ; 4 - left
        ; 6 - right.
        ; The direction the player is currently facing. Other values should be
        ; considered invalid.

    ; $30[0x01] - (Player)
    .PlayerYVelocity: skip $01
        ; When the player is moving down or up, this is the signed number of
        ; pixels that his Y coordinate will change by.

    ; $31[0x01] - (Player)
    .PlayerXVelocity: skip $01
        ; Same as $30 except it's for X coordinates

    ; $32[0x01] - (Player)
    .PlayerCliffHoppingY: skip $02
        ; Seems to be used in some subsection of Bank 07 that handles hopping
        ; off cliffs in relation to the player's Y coordinate. TODO: Also has
        ; a use in the Attract Module. TODO: Figure out exact use.

    ; $34[0x01] - (Attract)
    .AttractAgahCueFlag: skip $01
        ; Nonzero when the two soldiers during the 'Zelda in
        ; Prison' sequence are on the screen still. Zero when they leave,
        ; causing advancement to the next subsequence of this sequence
        ; (Agahnim walking towards Zelda's cell and the text appearing.)

    ; $35[0x03] - (Free)
    .Free_35: skip $03
        ; Free RAM

    ; $38[0x02] - (Player)
    .PlayerDWallCalc: skip $02
        ; Seems to be set some of the time when going up diagonal walls.
        ; It's a bitfield for tiles type 0x10 through 0x13. TODO: Confirm
        ; this name.
        ; SEE TILE ACT NOTES

    ; TILE ACT NOTES

    ; For tile act bitfields, each property is flagged with 4 bits.
    ; These bits indicate which tile relative the player the tile was found.
    ;  a b
    ;   P
    ;  c d
    ;
    ; abcd
    ;   a - Found to the north west
    ;   b - Found to the north east
    ;   c - Found to the south west
    ;   d - Found to the south east
    ;
    ;   P - Player

    ; $3A[0x01] - (Input)
    .BAndYInputField: skip $01
        ; Bitfield for the B and Y buttons.
        ; hymuunub
        ; b - B button was pressed this frame, and not held down during the
        ;     previous frame.
        ; m - Checked in one place, but not sure if it's ever set.
        ; n - Possible to be set, but not sure what it does
        ; h - The B button has been held down for one or more frames.
        ; u - Unused.
        ; y - The Y button has been held down for one or more frames.

    ; $3B[0x01] - (Input)
    .AInputField: skip $01
        ; Bitfield for the A button
        ; auuduuuu
        ; a - The A button is down.
        ; u - Unused.
        ; d - Debug flag. Checked in one place, but never set.

    ; $3C[0x01] - (Input)
    .BFlag: skip $01
        ; ssss tttt
        ;   s - Set to 9 on spin attack release.
        ;   t - How many frames the B button has been held, approximately.

    ; $3D[0x01] - (Player, OAM)
    .PlayerAnimationTimer: skip $01
        ; A delay timer for the spin attack. Used between shifts to make the
        ; animation flow with the flash effect. Also used for delays between
        ; different graphics when swinging the sword.

    ; $3E[0x01] - (Player)
    .PlayerCalcYLow: skip $01
        ; Y coordinate related variable (low byte).

    ; $3F[0x01] - (Player)
    .PlayerCalcXLow: skip $01
        ; X coordinate related variable (low byte).

    ; $40[0x01] - (Player)
    .PlayerCalcYHigh: skip $01
        ; Y coordinate related variable (high byte).

    ; $41[0x01] - (Player)
    .PlayerCalcXHigh: skip $01
        ; X coordinate related variable (high byte).

    ; $42[0x01] - (Player)
    .PlayerObstructV: skip $01
        ; Appears to flag directions for freedom for vertical. Flags are set
        ; when there's no obstruction. TODO: Of movement? or for freedom of what?
        ; (0: obstructed | 1: unobstructed)
        ; .... udlr
        ;   u - upwards
        ;   d - downwards
        ;   l - leftwards
        ;   r - rightwards

    ; $43[0x01] - (Player)
    .PlayerObstructD: skip $01
        ; Appears to flag directions for freedom for diagonal. Flags are set
        ; when there's no obstruction. TODO: Of movement? or for freedom of what?
        ; (0: obstructed | 1: unobstructed)
        ; .... udlr
        ;   u - upwards
        ;   d - downwards
        ;   l - leftwards
        ;   r - rightwards

    ; $44[0x01] - (Player)
    .AttackOAMOffsetY: skip $01
        ; Set to 0x80 during preoverworld. Seems to be an offset for player OAM
        ; y offset. TODO: Not fully confirmed.

    ; $45[0x01] - (Player)
    .AttackOAMOffsetX: skip $01
        ; Set to 0x80 during preoverworld. Seems to be an offset for player OAM
        ; x offset. TODO: Not fully confirmed.

    ; $46[0x01] - (Player)
    .PlayerRecoilTimer: skip $01
        ; A countdown timer that incapacitates the player when damaged or in
        ; recoil state. If nonzero, no movement input is recorded for the player.

    ; $47[0x01] - (Player)
    .WeapponTinkTimer: skip $01
        ; Weapon tink spark timer.

    ; $48[0x01] - (Player, OAM)
    .PlayerPushAction: skip $01
        ; If set, when the A button is pressed, the player sprite will enter the
        ; "grabbing at something" state.
        ; Bitfield for push actions
        ; s... dbpt
        ;   s - statue/somaria
        ;   d - pushing door
        ;   b - push block
        ;   p - pushing
        ;   t - harder push

    ; $49[0x02] - (Player)
    .PlayerForceMove: skip $01
        ; This address is written to make the player move in any given direction.
        ; When indoors, it is cleared every frame. When outdoors, it is not
        ; cleared every frame so watch out. Also any value besides 0 it overwrites
        ; player directional input.

        ; 0x00 - Nothing
        ; 0x01 - East
        ; 0x02 - West
        ; 0x03 - West (facing East)
        ; 0x04 - South
        ; 0x05 - South East
        ; 0x06 - South West
        ; 0x07 - South West too?
        ; 0x08 - North
        ; 0x09 - North East
        ; 0x0A - North West
        ; 0x0B - North West too?
        ; 0x0C - North (facing south)
        ; 0x0D - North East (facing south)
        ; 0x0E - North West (facing south)
        ; 0x0F - North West (facing south) too?

    ; $EF[0x01] - (Polyhedral)
    .Poly_Unknown_4A: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $4B[0x01] - (Player)
    .PlayerVisible: skip $01
        ; The player's visibility status. If set to 0x0C, the player will
        ; disappear.

    ; $4C[0x01] - (Item)
    .CapeDrainTimer: skip $01
        ; Counter that decreases every frame when the Cape is in use. Starts at
        ; 4 and counts down to 0. When it reaches 0, your magic meter is
        ; decremented based on whether you have full or 1/2 magic. There's a
        ; table in Bank 07 that determines this.

    ; $4D[0x01] - (Player)
    .PlayerAuxState: skip $01
        ; An Auxiliary player handler.
        ; As far as I know:
        ; 0x00 - ground state (normal)
        ; 0x01 - the recoil status
        ; 0x02 - jumping in and out of water?
        ; 0x04 - swimming state.
        ; All other values never seem to be written to this location, so in some
        ; sense it is treated more like a bitfield than a holder of discriminated
        ; values indicating states. That is, each bit indicates a state, but the
        ; states are assumedly mutually exclusive.

    ; $4E[0x01] - (Dungeon)
    .DunTransitionLand: skip $01
        ; It indicates broadly the tile attribute of the location that the
        ; player lands on after the transition. It can only take on a value
        ; between 0 and 4, inclusive.
        ; ------+-------------------------------------------------------------
        ; 0 | 0x00, 0x09
        ;   |
        ; 1 | 0x80, 0x81, 0x90, 0x91, ..., 0xE0, 0xE1, 0xF0, 0xF1
        ;   |
        ; 2 | 0x82, 0x83, 0x92, 0x93, ..., 0xE2, 0xE3, 0xF2, 0xF3, and
        ;   | any values not covered by the other tile attribute numbers.
        ;   | 
        ; 3 | 0x84, 0x85, 0x88, 0x89, ..., 0xF4, 0xF5, 0xF8, 0xF9
        ;   |
        ; 4 | 0x86, 0x87, 0x96, 0x97, ..., 0xE6, 0xE7, 0xF6, 0xF7
        ; According to Kan:
        ;   0x00 - Shallow water/Nothing
        ;   0x01 - Normal door
        ;   0x02 - Shutter doors/All others - zeros DOORWAY
        ;   0x03 - Layer doors? TODO
        ;   0x04 - Lower layer shutters - zeros DOORWAY

    ; $4F[0x01] - (Player, SFX)
    .DashSFXTimer: skip $01
        ; Index for creating the dashing sound effect. If frozen to a single
        ; value, no sound occurs.

    ; $50[0x01] - (Player)
    .PlayerStrafeFlag: skip $01
        ; A flag indicating whether a change of the direction the player is
        ; facing is possible. For example, when the B button is held down with a
        ; sword. When non 0, strafe.
        ; .... .bps
        ;   s - the bit generally flagged
        ;   p - flagged during rupee pull and perpendicular door movement
        ;   b - flagged during push blocks

    ; $51[0x01] - (Attract)
    .AttractUnknownFlag_51:
        ; TODO: Has some use in attract mode.

    ; $51[0x02] - (Player)
    .PlayerTargetY: skip $01
        ; Used as a buffer to store the Y position where the player is supposed to
        ; land to when falling in a hole.

    ; $52[0x01] - (Attract)
    .AttractUnknownFlag_52:
        ; TODO: Has a function identical to $5F in some cases, though
        ; sometimes it used for something else.

    ; $52[0x01] - (Polyhedral)
    .PolyCosCalc: skip $01
        ; Has some sort of use in the Polyhedral code. Appears to store a
        ; cosine value.

    ; $53[0x02] - (Player)
    .PlayerTargetX: skip $02
        ; Used as a buffer to store the X position where the player is supposed to
        ; land to when falling in a hole.

    ; $55[0x01] - (Player)
    .PlayerCapeOn: skip $01
        ; Cape flag, when set, makes you invisible and invincible. You can
        ; also go through objects, such as bungies.

    ; $56[0x01] - (Player, OAM)
    .PlayerIsBunny: skip $01
        ; The player's graphic status.
        ; 0 - real Link.
        ; 1 - bunny Link

    ; $57[0x01] - (Player)
    .PlayerSpeedModifier: skip $01
        ; Modifier for the player's movement speed. Counts up to 0x10 to
        ; induce slower speed on stairs. Famously uncleared after spiral stairs.
        ; 0            - normal
        ; 0x01 to 0x0F - slow
        ; 0x10 and up  - fast.
        ; Negative values actually reverse your direction.

    ; $58[0x01] - (Player)
    .PlayerStairTile: skip $01
        ; Bitfield describing insteractions with stairs tiles.
        ; ....ssss
        ; s - Stair tiles
        ; If this masked with 0x07 equals 0x07, the player moves slowly, like
        ; he's on a small staircase. $02C0 also needs this variable to be nonzero
        ; to trigger.
        ; SEE TILE ACT NOTES

    ; $59[0x01] - (Player)
    .PlayerPitTile: skip $01
        ; Bitfield for pit tile interaction.
        ; ....pppp
        ; p - pit tile detected
        ; SEE TILE ACT NOTES

    ; $5A[0x01] - (Player)
    .PlayerFallPose: skip $01
        ; Pose when landing from a pit fall in underworld.

    ; $5B[0x01] - (Player)
    .PlayerPitSlipping: skip $01
        ; 0 - Indicates nothing
        ; 1 - Player is dangerously near the edge of a pit
        ; 2 - Player is falling
        ; 3 - Player is falling into a hole, part 2?

    ; $5C[0x01] - (Player)
    .PlayerFallTimer: skip $01
       ; Timer for the falling animation.

    ; $5D[0x01] - (Player)
    .PlayerState: skip $01
        ; Player Handler or "State"
        ; 0x00 - ground state
        ; 0x01 - falling into a hole
        ; 0x02 - recoil from hitting wall / enemies 
        ; 0x03 - spin attacking
        ; 0x04 - swimming
        ; 0x05 - Turtle Rock platforms
        ; 0x06 - recoil again (other movement)
        ; 0x07 - Being electrocuted
        ; 0x08 - using ether medallion
        ; 0x09 - using bombos medallion
        ; 0x0A - using quake medallion
        ; 0x0B - Falling into a hold by jumping off of a ledge.
        ; 0x0C - Falling to the left / right off of a ledge.
        ; 0x0D - Jumping off of a ledge diagonally up and left / right.
        ; 0x0E - Jumping off of a ledge diagonally down and left / right.
        ; 0x0F - More jumping off of a ledge but with dashing maybe + some
        ;        directions.
        ; 0x10 - Same or similar to 0x0F?
        ; 0x11 - Falling off a ledge
        ; 0x12 - Used when coming out of a dash by pressing a direction other 
        ;        than the dash direction.
        ; 0x13 - hookshot
        ; 0x14 - magic mirror
        ; 0x15 - holding up an item
        ; 0x16 - asleep in his bed
        ; 0x17 - permabunny
        ; 0x18 - stuck under a heavy rock
        ; 0x19 - Receiving Ether Medallion
        ; 0x1A - Receiving Bombos Medallion
        ; 0x1B - Opening Desert Palace
        ; 0x1C - temporary bunny
        ; 0x1D - Rolling back from Gargoyle gate or PullForRupees object
        ; 0x1E - The actual spin attack motion.

    ; $5E[0x01] - (Player)
    .PlayerSpeed: skip $01
        ; Speed setting for the player. The different values this can be set
        ; to index into a table that sets his real speed. Some common values:
        ; 0x00 - Normal walking speed
        ; 0x02 - Walking (or dashing) on stairs
        ; 0x10 - Dashing

    ; $5F[0x02] - (Dungeon, Overworld)
    .TileManip:
        ; Bitfield used by manipulable tiles.

    ; $5F[0x01] - (Attract)
    .AttractBrightnessFlag: skip $01
        ; Used as a flag during fade in from darkness in between sequences.
        ; Once the screen is fully bright, this variable is set to 1.

    ; $60[0x01] - (Attract)
    .AttractSubModule2: skip $01
        ; Indicates the current subsequence index of a sequence.
        ; Only used in 'Zelda in Prison' and 'Maiden Warp'.

    ; $61[0x01] - (Dungeon, Overworld)
    .PushFriction:
        ; Push timer for blocks, graves, etc.

    ; $61[0x01] - (Attract)
    .AttractMaidenWarpFlag: skip $01
        ; After a sufficient amount of time has counted down during the 'Maiden
        ; Warp' sequence, this will transition from 0 to 1, and this tells the
        ; sequence to move from the first subsequence to the second. Yeah,
        ; narrow usage.

    ; $62[0x02] - (Dungeon)
    .DoorHFlag: skip $01
        ; Seems like it's used in conjunction with doors. I think this causes
        ; the behavior where walking in a doorway path causes the player's
        ; orthogonal movement to translate to movement along the path
        ; of the doorway. Example: Player walks up a door, but doesn't hit
        ; the scroll point yet. They hit left or right, and they continue to
        ; move, but not in the left or right directions. Rather, the movement
        ; is reinterpreted in either the up or down direction, probably
        ; depending upon the direction the player was already traveling in.

        ; According to Kan:
        ; Seems to only act as a flag for horizontal doors.
        ; .... ..h.
        ;   h - on horizontal door tile

    ; $63[0x01] - (Attract)
    .AttractAgahSpell: skip $01
        ; Used for spell timer for Agahnim in attract mode.
        ; Zeroed by DoorHFlag during normal gameplay.

    ; $64[0x02] - (Player, OAM)
    .PlayerOAMPriority: skip $01
        ; Used to ORA in OAM priority, but only high byte seems used for that.
        ; 0x1000 if PlayerDunLayer = 1, 0x2000 if PlayerDunLayer = 0.

    ; $64[0x02] - (Attract)
    .AttractTimer2: skip $02
        ; Used as a timer for Agahnim text display in attract mode.

    ; $66[0x01] - (Player)
    .PlayerLastDir: skip $01
        ; Indicates the last direction the player moved towards.
        ; Value-wise:
        ; 0 - Up
        ; 1 - Down
        ; 2 - Left
        ; 3 - Right

    ; $67[0x01] - (Player)
    .PlayerDir: skip $01
        ; Indicates which direction the player is walking (even if not going
        ; anywhere).
        ; ----udlr.
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $68[0x01] - (Player)
    .PlayerYDiff: skip $01
        ; When the player moves in room, this is the difference between their
        ; new Y coordinate and their old one (Y_new - Y_old).
        ; For example, a value of 1 would indicate that the player has moved
        ; down by one pixel, whereas a value of 0 would indicate no
        ; movement in the Y axis.

    ; $69[0x01] - (Player)
    .PlayerXDiff: skip $01
        ; When the player moves in room, this is the difference between their
        ; new and old X coordinates (X_new - X_old).
        ; For example, a value of -2 would indicates that the player has
        ; moved left by two pixels, whereas a value of 0 would indicate no
        ; movement in the X axis.

    ; $6A[0x01] - (Player)
    .PlayerOrthogonalDir: skip $01
        ; Indicates the number of orthogonal directions the player is moving
        ; in simultaneously. This does not include the rarely used Z axis
        ; (altitude).
        ; 0 - not moving
        ; 1 - moving either horizontally or vertically, but not both
        ; 2 - moving both horizontally and vertically

    ; $6B[0x01] - (Player)
    .PlayerDWallDir: skip $01
        ;         ..hv udlr
        ;   0x15  ...1 .1.1  ◣ down
        ;   0x16  ...1 .11.  ◢ down
        ;   0x19  ...1 1..1  ◤ up
        ;   0x1A  ...1 1.1.  ◥ up
        ;   0x25  ..1. .1.1  ◥ right
        ;   0x26  ..1. .11.  ◤ left
        ;   0x29  ..1. 1..1  ◢ right
        ;   0x2A  ..1. 1.1.  ◣ left
        ; h - Moving horizontally
        ; v - Moving vertically
        ; u - Change of direction into the slope has an up vector
        ; d - Change of direction into the slope has a down vector
        ; l - Change of direction into the slope has a left vector
        ; r - Change of direction into the slope has a right vector

    ; $6C[0x01] - (Dungeon, Player)
    .PlayerInDoor: skip $01
        ; Indicates whether you are standing in a doorway
        ; 0 - not standing in a doorway. 
        ; 1 - standing in a vertical doorway 
        ; 2 - standing in a horizontal door way

    ; $6D[0x01] - (Player)
    .PlayerDWallFail: skip $01
        ; When you are moving against a diagonal wall and you are deadlocked.
        ; I.e. you are pressing against it directly, but aren't going anywhere,
        ; this will contain the value that $6B would have.

    ; $6E[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerDWallTile: skip $01
        ; Tile act bitfield used by slopes.
        ; High byte has an explicit STZ as well, but it is never used.
        ; .... ssss
        ; Moving against a \ wall from below: 0 
        ; Moving against a \ wall from above: 2
        ; Moving against a / wall from below: 4
        ; Moving against a / wall from above: 6
        ; SEE TILE ACT NOTES

    ; $70[0x02] - (Free)
    .Free_70: skip $02
        ; Free RAM

    ; $72[0x04] - (Main)
    .Work2: skip $04
        ; Used as general scratch space in a variety of different routines.

    ; $76[0x02] - (Player, Tile Attribute)
    .PlayerInteractTile: skip $02
        ; When object, such as the player, interact with certain tile types, 
        ; the index of that tile gets stored here.

    ; $78[0x01] - (Player)
    .PlayerJumpScroll: skip $01
        ; Seems to flag non-north hops in the overworld. Messes with camera
        ; scroll. Kept in sync with NOHURT.
        ; From MoN but I can find no evidence of:
        ; Possibly used in the context of chests.

    ; $79[0x01] - (Player)
    .SpinAttackTimer: skip $01s
        ; Spin attack timer
        ; Fully charged at 48 (0x30)
        ; Hardcapped at 64 (0x40)

    ; $7A[0x01] - (Free)
    .Free_7A: skip $01
        ; Free RAM

    ; $7B[0x01] - (Dungeon, Overworld)
    .InDarkWorld: skip $01
        ; Set to 0x00 when in the Light World, and 0x40 when in the Dark World.
        ; Often used for temporary calculations, so don't expect it to be
        ; reflective of the current status of the player at all times.

    ; $7C[0x08] - (Free)
    .Free_7C: skip $08
        ; Free RAM

    ; $84[0x02] - (Overworld)
    .OWTMIndex: skip $02
        ; Index for overworld map16 buffer to load new graphics when scrolling.

    ; $86[0x02] - (Overworld)
    .OWTMHScroll: skip $02
        ; Overworld horizontal scroll position. Used to index $0500 and tilemap.

    ; $88[0x02] - (Overworld)
    .OWTMVScroll: skip $02
        ; Overworld vertical scroll position. Used to index $0500 and tilemap.

    ; $8A[0x02] - (Overworld, High Junk)
    .OWAreaIndex: skip $02
        ; Overworld Area Index. The high byte is unused but written to.
        ; In practice the only 2 special areas that can be accessed are 0x80
        ; and 0x81 however higher values occasionally appear when loading sub
        ; screen overlays.
        ; 0x00-0x3F - Light world areas
        ; 0x40-0x7F - Dark world areas
        ; 0x80-0x9F - Special areas
        ; 0xA0 and above are unused

    ; $8C[0x01] - (Overworld)
    .OverlayIndex: skip $01
        ; Subscreen Overlay index. TODO: Add the corrsiponding overlays here.

    ; $8D[0x01] - 
    .StepAnimationTimer: skip $01
        ; Seems to be some kind of step counter for drawing ripples and thick
        ; grass around the player sprite (see Bank 0x0D).

    ; $8E[0x02] - (Free)
    .Free_8E: skip $02
        ; Free RAM

    ; OAM consists of 0x220 bytes of data, split unevenly into 2 tables. The
    ; first table is 0x200 bytes long, ranging from $0000-$01FF. The 2nd table
    ; is just 0x20 bytes long, and ranges from $0100-011F. Here is what is
    ; contained in this tables:

    ; $90[0x02] - (OAM)
    .OAMLowPtr: skip $02
        ; Points to current position in the low OAM buffer ($0800).
        ; Each entry is 4-bytes per OAM tile.  
        ; Byte 0: xxxxxxxx
        ; Byte 1: yyyyyyyy
        ; Byte 2: cccccccc
        ; Byte 3: vhoopppc
        ; x - X coordinate
        ; y - Y coordinate
        ; c - Character in VRAM
        ; v - Vertical flip
        ; h - Horizontal flip
        ; o - Priority
        ; p - Palette

        ; NOTE: There is a 9th X bit found in the 2nd OAM table. 
        ; With all 9 bits, the X coordinate can range from -256 to 255
        ; ($100-$FF). $100 = -256, -1 = $1FF, etc.

    ; $92[0x02] - (OAM)
    .OAMHighPtr: skip $02
        ; Points to current position in the uncompressed high OAM buffer ($0A20).
        ; Normally, Each entry is 2 bits per OAM tile, however the array this is
        ; written to uses a whole byte per OAM tile. The array is then compressed
        ; down to 4 tiles per byte and stored into $0A00 which is the true OAM
        ; high buffer. This is done to save time during draw functions.
        ; .... ..sx
        ; x - The X coordinate's 9th bit.
        ; s - OAM size: 0 - small size, 1 - large size)

        ; NOTE: The OAM size CAN change depending on the setting put into
        ; SNES.OAMSizeAndDataDes. Only the first 6 options were intended to be
        ; used. Tthe last 2 are rectangular shaped and behave oddly with
        ; vertical flipping. However ALTTP never changes this and only uses the
        ; first option of 8x8 and 16x16.
        ; The sizes are as follows:
        ;      | Small | Large |
        ; 0x00 |  8x8  | 16x16 |
        ; 0x01 |  8x8  | 32x32 |
        ; 0x02 |  8x8  | 64x64 |
        ; 0x03 | 16x16 | 32x32 |
        ; 0x04 | 16x16 | 64x64 |
        ; 0x05 | 32x32 | 64x64 |
        ; 0x06 | 16x32 | 32x64 |
        ; 0x07 | 16x32 | 32x32 |

    ; $94[0x01] - (NMI, Overworld)
    .BGMode: skip $01
        ; Screen Mode Register. To be written to SNES.BGModeAndTileSize during
        ; NMI. Also written to when entering and exiting the overworld map mode.

    ; $95[0x01] - (NMI)
    .MosaicSetting: skip $01
        ; Mosaic Settings. To be written to SNES.MosaicAndBGEnable during NMI.

    ; $96[0x01] - (NMI)
    .BG12WindowMask: skip $01
        ; Window Masks for Backgrounds 1 and 2. To be written to
        ; SNES.BG1And2WindowMask during NMI.

    ; $97[0x01] - (NMI)
    .BG34WindowMask: skip $01
        ; Window Masks for Backgrounds 3 and 4. To be written to
        ; SNES.BG3And4WindowMask during NMI.

    ; $98[0x01] - (NMI)
    .ObjAndColor: skip $01
        ; Window Masks for Obj and Color Add/Subtraction Layers.
        ; To be written to SNES.OBJAndColorWindow during NMI.

    ; $99[0x01] - (NMI)
    .EnableFixedColor: skip $01
        ; Enable Fixed Color +/-. To be written to SNES.InitColorAddition
        ; during NMI.

    ; $9A[0x01] - (NMI)
    .AddSubSelect: skip $01
        ; Enable +/- per layer. To be written to SNES.AddSubtractSelectAndEnable
        ; during NMI.

    ; $9B[0x01] - (NMI)
    .HDMAEnable: skip $01
        ; HDMA channels to write to $420C / HDMAChannelEnable.

    ; $9C[0x01] - (NMI)
    .FixedColorRed: skip $01
        ; Writes to $2132 / FixedColorData. Red fixed color component.

    ; $9D[0x01] - (NMI)
    .FixedColorGreen: skip $01
        ; Writes to $2132 / FixedColorData. Green fixed color component.

    ; $9E[0x01] - (NMI)
    .FixedColorBlue: skip $01
        ; Writes to $2132 / FixedColorData. Blue fixed color component.

    ; $9F[0x01] - (Free)
    .Free_9F: skip $01
        ; Free RAM

    ; $A0[0x02] - (Dungeon)
    .DunRoomIndex: skip $02
        ; Dungeon Room Index. There are 296 rooms total. The high byte will
        ; always be either 0 or 1 as there are only 2 different blocks of rooms.
        ; Mirrored in $0483.

    ; $A2[0x02] - (Dungeon)
    .PreviousDunRoomIndex: skip $02
        ; The last room we were in. If we move from room 0x69 to 0x6A, the last
        ; room would be 0x69.

    ; $A4[0x02] - 
    .DunFloor: skip $02
        ; Indicates the current floor the player is on in a dungeon.
        ;   0x00 - Floor 1
        ;   Positive values indingating floors above the ground floor.
        ;   Negative values indicate basement floors.

    ; $A6[0x01] - (Dungeon)
    .DunCameraBoundsX: skip $01
        ; Set to 0 or 2, but it depends upon the dungeon room's layout
        ; and the quadrant it was entered from. Further investigation seems
        ; to indicate that its purpose is to control the camera / scrolling
        ; boundaries in dungeons. Also used during certain overworld scenarios,
        ; possibly in special areas. TODO: Confirm this.

    ; $A7[0x01] - (Dungeon)
    .DunCameraBoundsY: skip $01
        ; Same as CameraBoundsX, but for vertical camera scrolling.

    ; $A8[0x01] - (Dungeon)
    .DunRoomLayout: skip $01
        ; Composite of dungeon room layout info and quadrant info that gets
        ; updated periodically.
        ; uuucccba 
        ; ccc - layout that the room uses (0 to 7)
        ; b - ORed in value of $AA
        ; a - ORed in value of $A9
        ; u - Unused

    ; $A9[0x01] - (Dungeon, Player)
    .PlayerQuadrantH: skip $01
        ; 0 if you are on the left half of the room.
        ; 1 if you are on the right half.

    ; $AA[0x01] - (Dungeon, Player)
    .PlayerQuadrantV: skip $01
        ; 2 if you are the lower half of the room.
        ; 0 if you are on the upper half.

    ; $AB[0x02] - (Free)
    .Free_AB: skip $02
        ; Free RAM

    ; $AD[0x01] - (Dungeon)
    .LayerFloorEffect: skip $01
        ; Holds layer floor effect index. TODO: Insert what that is called in ZS.
        ; 0x00 - Nothing           
        ; 0x01 - Nothing            
        ; 0x02 - Moving Floor       
        ; 0x03 - Moving Water       
        ; 0x04 - Moving Floor 2 (Not sure if this is used anywhere)
        ; 0x05 - Red Flashes (Agahnim's room in Ganon's tower)
        ; 0x06 - Torch Hidden Tiles 
        ; 0x07 - Torch Ganon Room   

    ; $AE[0x01] - (Dungeon)
    .DunTag1: skip $01
        ; In dungeons, holds the Tag1 Value. Kill all enemies to open door,
        ; push button to open door, bush block for chest, etc. (See ZScream)
        ; TODO: Add all the indexed tags here.

    ; $AF[0x01] - (Dungeon)
    .DunTag2: skip $01
        ; In dungeons, holds the Tag2 Value. Kill all enemies to open door,
        ; push button to open door, bush block for chest, etc. (See ZScream)
        ; TODO: Add all the indexed tags here.

    ; $B0[0x01] - (Main)
    .SunSubmodule: skip $01
        ; Sub-submodule index. (Submodules of the $11 submodule index.)

    ; $B1[0x01] - (Junk)
    .Junk_B1: skip $01
        ; Is written to once in Poly code but does not seem to be used anywhere.
        ; TODO: Confirm this.

    ; $B2[0x02] - (Dungeon)
    .DunDrawObjWidth: skip $02
        ; Width indicator for drawing dungeon objects.

    ; $B4[0x02] - (Dungeon)
    .DunDrawObjHeight: skip $02
        ; Height indicator for drawing dungeon objects.

    ; $B6[0x01] - (Free)
    .Free_B6: skip $01
        ; Free RAM

    ; $B7[0x03] - (Dungeon)
    .DunObjPtr: skip $01
        ; Used as a 3 byte pointer to be indirectly accessed during dungeon
        ; room loading.
        ; TODO: Also something with palettes?

    ; $BA[0x02] - (Dungeon)
    .DunObjPtrOff: skip $01
        ; Often used as a position into a buffer of data during dungeon room
        ; loading. Used as an offset for DunObjPtr.

    ; $BC[0x01] - (Free)
    .Free_BC: skip $01
        ; Free RAM

    ; $BD[0x02] - (GFX)
    .GFX3BPPTemp1:
        ; (Bank 0x00) Temporary used in expanding 3bpp to 4bpp (high)
        ; graphics.

    ; $BD[0x02] - (Dungeon, Overworld)
    .TileInteractionOff: 
        ; (Bank 0x07) The address of the current tile interaction in the tile buffer ($7F2000). Rupee floor, warp tile, ledges, grass, etc.

    ; $BD[0x01] - (Item)
    .SomariaPlatformPoofTemp:
        ; (Bank 0x08) Used as a temporary for the Cane of Somaria creation
        ; poof, or something like that.

    ; $BD[0x01] - (Equipment)
    .EquipmentInputWait: skip $02
        ; (Bank 0x0D) Temporary buffer for player input while selecting an item.
        ; Prevents the cursor from moving over more than one slot per button
        ; press.

    ; $BF[0x02] - (GFX)
    .GFX3BPPTemp2:
        ; (Bank 0x00) Temporary used in expanding 3bpp to 4bpp (high)
        ; graphics.

    ; $BF[0x06] - (File Select)
    .ValidFileArray1:
        ; (Bank 0x0C) The first entry in an array of 1 word each, one for each
        ; save file.
        ; 0 if there is no save file in that slot.
        ; 1 if there is a save file in that slot.
        ; See ValidFileArray2 and ValidFileArray3.

    ; $BF[0x1E] - (Dungeon)
    .DunDrawObjAddLow: 
        ; (Bank 0x01) 10 entries of 3 bytes each. Used as a series of long
        ; pointers to tilemap buffer offsets. Generally, they point to locations
        ; in the range $7E2000 - $7E5FFF. Used to draw objects on different BGs 
        ; than where they were placed or on multiple BGs. See DunDrawObjAddHigh.

    ; $BF[0x01] - (Polyhedral)
    .Poly_Unknown_BF: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C0[0x1E] - (Dungeon)
    .DunDrawObjAddHigh: 
        ; (Bank 0x01) 10 entries of 3 bytes each. Used as a series of long
        ; pointers to tilemap buffer offsets. Generally, they point to locations
        ; in the range $7E2000 - $7E5FFF. Used to draw objects on different BGs 
        ; than where they were placed or on multiple BGs. See DunDrawObjAddLow.

    ; $C0[0x01] - (Polyhedral)
    .Poly_Unknown_C0: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C1[0x02] - (File Select)
    .ValidFileArray2:
        ; (Bank 0x0C) The second entry in an array of 1 word each, one for each
        ; save file.
        ; 0 if there is no save file in that slot.
        ; 1 if there is a save file in that slot.
        ; See ValidFileArray1 and ValidFileArray3.

    ; $C1[0x01] - (Polyhedral)
    .Poly_Unknown_C1: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C2[0x01] - (Polyhedral)
    .Poly_Unknown_C2: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C3[0x01] - (Polyhedral)
    .Poly_Unknown_C3:
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C3[0x02] - (File Select)
    .ValidFileArray3: skip $01
        ; (Bank 0x0C) The third entry in an array of 1 word each, one for each
        ; save file.
        ; 0 if there is no save file in that slot.
        ; 1 if there is a save file in that slot.
        ; See ValidFileArray1 and ValidFileArray2.

    ; $C4[0x01] - (Polyhedral)
    .Poly_Unknown_C4: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C5[0x01] - (Polyhedral)
    .Poly_Unknown_C5: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C6[0x01] - (Polyhedral)
    .Poly_Unknown_C6: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C7[0x01] - (Polyhedral)
    .PlayerRecoilUnknown: skip $01
        ; Written to in bank 02 and 06. Something to do with recoil. Possibly
        ; unused as its seems to be only written to. TODO: Confirm this.

    ; TODO: $C8-$CA Realistically could be considered work ram instead of
    ; having all these different labels but I'll leave them here for now so
    ; they can be doccumented where they are used later.

    ; $C8[0x03] - (GFX)
    .GFXDecompPtrLow:
        ; (Bank 0x00) Used to store a pointer from GFXSheetPointers_sprite
        ; during GFX decompression. See GFXDecompPtrMid and
        ; GFXDecompPtrHigh.

    ; $C8[0x02] - (Dungeon)
    .GanonDoorTimerLow:
        ; (Bank 0x01) Acts as a misc timer for the Ganon room door tag.
        ; See GanonDoorTimerHigh.

    ; $C8[0x01] - (Dungeon, Minigame)
    .ChestMinigameLastItem:
        ; (Bank 0x01) Saves the index of the last item recieved from the chest
        ; minigame. This is checked to prevent giving the same item twice in a
        ; row.

    ; $C8[0x01] - (Triforce)
    .TriforceRoomTimer:
        ; (Bank 0x02) Acts as a misc timer for the Triforce room sequence.

    ; $C8[0x03] - (Triforce)
    .OWDecompSrcAddrLow:
        ; (Bank 0x02) Stores the sorce address for overworld decompression.
        ; See OWDecompSrcAddrMid and OWDecompSrcAddrHigh.

    ; $C8[0x01] - (Game Over)
    .GameOverTimer:
        ; (Bank 0x09) Acts as a misc timer for the Game Over sequence.

    ; $C8[0x01] - (Bird)
    .BirdTravelTimer:
        ; (Bank 0x0A) Acts as a misc timer for the bird travel sequence.

    ; $C8[0x01] - (Dungeon)
    .DunMapLayoutIndex:
        ; (Bank 0x0A) Temporarily stores the index of the layout for the
        ; dungeon map rooms.

    ; $C8[0x01] - (File Select)
    .FileFairyCursorIndex:
        ; (Bank 0x0C) Keeps track of what part of a menu you are in. For
        ; example, on the select game screen this will take on values 0 - 4.
        ; 0 - 2 for each save game, 3 & 4 are copy and erase game. You could
        ; also say this is where the fairy cursor is.

    ; $C8[0x02] - (Credits)
    .CreditsTimerLow:
        ; (Bank 0x0E) Used as a 16 bit timer used for stepping through the
        ; credits sequence. See CreditsTimerHigh.

    ; $C8[0x01] - (Overworld)
    .EntranceAnimationTimer: skip $01
        ; (Bank 0x1B) Acts as a misc timer for special entrance animations.
        ; Palace of Darkness, Skull Woods, Misery Mire, Gannon's Tower, etc.

    ; $C9[0x03] - (GFX)
    .GFXDecompPtrMid:
        ; (Bank 0x00) Used to store a pointer from GFXSheetPointers_sprite
        ; during GFX decompression. See GFXDecompPtrLow and
        ; GFXDecompPtrHigh.

    ; $C9[0x01] - (Triforce)
    .OWDecompSrcAddrMid:
        ; (Bank 0x02) Stores the sorce address for overworld decompression.
        ; See OWDecompSrcAddrLow and OWDecompSrcAddrHigh.

    ; $C9[0x01] - (Dungeon)
    .GanonDoorTimerHigh:
        ; (Bank 0x01) Acts as a misc timer for the Ganon room door tag.
        ; See GanonDoorTimerLow.

    ; $C9[0x01] - (Credits)
    .CreditsTimerHigh: skip $01
        ; (Bank 0x0E) Used as a 16 bit timer used for stepping through the
        ; credits sequence. See CreditsTimerLow.

    ; $CA[0x03] - (GFX)
    .GFXDecompPtrHigh:
        ; (Bank 0x00) Used to store a pointer from GFXSheetPointers_sprite
        ; during GFX decompression. See GFXDecompPtrLow and
        ; GFXDecompPtrMid.

    ; $CA[0x01] - (Overworld)
    .OWDecompSrcAddrHigh:
        ; (Bank 0x02) Stores the sorce address for overworld decompression.
        ; See OWDecompSrcAddrLow and OWDecompSrcAddrMid.

    ; $CA[0x02] - (Dungeon)
    .DunMapRoomPtr:
        ; (Bank 0x0A) Temporarily stores the pointer for the dungeon map rooms.

    ; $CA[0x02] - (Title Screen)
    .LogoSwordTimerLow:
        ; (Bank 0x0C) Used as a misc timer for the logo sword in the
        ; title screen sequence. See LogoSwordTimerHigh.

    ; $CA[0x02] - (File Select)
    .FileCopyToOffsetLow:
        ; (Bank 0x0C) Stores the offset of the secondary save slot to overwrite
        ; when in copy save mode. See FileCopyToOffsetHigh.

    ; $CA[0x02] - (Credits)
    .CreditsLineCount:
        ; (Bank 0x0E) This stores the current vertical line for the scrolling
        ; credits. There are 0x0314 lines that can have text on them, most
        ; of which are blank.

    ; $CA[0x01] - (Main)
    .Work_CA: skip $01
        ; (Bank 0x0C, 0x01, 0x1B) This RAM has other smaller uses that are still
        ; unclear. TODO: Make them clear.

    ; $CB[0x02] - (GFX)
    .DecompWriteCount
        ; (Bank 0x00) A temporary count of bytes to write during GFX
        ; decompression.

    ; $CB[0x02] - (Overworld)
    .OWDecompMiscWork_CB:
        ; (Bank 0x02) Used during overworld decompression. Appears to have 
        ; multiple uses. TODO: Needs more investigation.

    ; $CB[0x01] - (Title Screen)
    .LogoSwordTimerHigh:
        ; (Bank 0x0C) Used as a misc timer for the logo sword in the
        ; title screen sequence. See LogoSwordTimerLow.

    ; $CB[0x01] - (File Select)
    .FileCopyToOffsetHigh: skip $01
        ; (Bank 0x0C) Stores the offset of the save slot to overwrite when in
        ; copy save mode. See FileCopyToOffsetLow.

    ; $CC[0x02] - (Overworld)
    .OWTile16DecompWriteOff:
        ; (Bank 0x02) Stores and offset of either 0x1000 or 0x0000.
        ; 0x0000 - Tile16 Decompression will write to $7F4000 BG2 (Normal BG).
        ; 0x1000 - Tile16 Decompression will write to $7F5000 BG1 (SubScreen BG).

    ; $CC[0x02] - (File Select)
    .FileCopyFromOffsetLow:
        ; (Bank 0x0C) Stores the offset of the secondary save slot to overwrite
        ; when in copy save mode. See FileCopyFromOffsetHigh.

    ; $CC[0x02] - (Title Screen)
    .LogoSwordState:
        ; (Bank 0x0C) Stores the current state of the logo sword on the title
        ; screen. 
        ; 0x00 - Sword is idle
        ; 0x01 - The eye in the hilt of the sword will twinkle
        ; 0x02 - The blade of the sword will shimmer

    ; $CC[0x02] - (Credits)
    .CreditsNextDeathCountIndex: skip $01
        ; (Bank 0x0E) Keeps track of what death count line to look for next
        ; during the credits.

    ; $CD[0x01] - (GFX)
    .GFXDecompMiscWork:
        ; (Bank 0x00) Used as a temp var for GFX Decompression. TODO: Unsure of
        ; exact use.

    ; $CD[0x01] - (Overworld)
    .OWDecompMiscWork_CD:
        ; (Bank 0x02) Used as a temp var for Overworld Decompression.
        ; TODO: Unsure of exact use.

    ; $CD[0x01] - (File Select)
    .FileCopyFromOffsetHigh:
        ; (Bank 0x0C) Stores the offset of the secondary save slot to overwrite
        ; when in copy save mode. See FileCopyFromOffsetLow.

    ; $CD[0x01] - (Title Screen)
    .LogoSwordShimmerTimer:
        ; (Bank 0x0C) Used as a timer for the logo sword shimmer.

    ; $CE[0x02] - (Credits)
    .CreditsDeathDigitPos: skip $02
        ; (Bank 0x0E) A temp var used to store where horizontally to draw the
        ; current digit of the current death count.

    ; $D0[0x01] - (Title Screen)
    .LogoSword_Unknown_D0:
        ; (Bank 0x0C) Used in the title screen logo sword. TODO: Purpose unknown.

    ; BG positions/scroll registers.
    ; BG1:
    ;     Dungeon: Lower level objects
    ;     Overworld: Subscreen overlays
    ;     Title: Title text
    ;     File: Border box
    ;     Attract: The moving bubble BG that goes North West
    ;     Dungeon Map: Levels background, and layout grid
    ;     Overworld Map: Mode 7 map
    ; BG2:
    ;     Dungeon: Upper level objects
    ;     Overworld: Main tile map
    ;     Title: Castle, lake, forrest, and mountain Background
    ;     Attract: The moving bubble BG that goes North East
    ;     Dungeon Map: Map layout and level box
    ;     Credits: Mountain background
    ; BG3:
    ;     Everywhere: Text
    ;     Dungeon and Overworld: Item menu
    ;     Attract: History depictions
    ;     Dungeon Map: Outer box + "Map" label on the top left
    ;     Save file naming and erasing: TODO: Find out.

    ; BG scroll registers / positions

    ; $E0[0x02] - (Main)
    .BG1HPos: skip $02
        ; The BG1 horizontal position. This is almost the BG1 horizontal scroll
        ; register SNES.BG1HScrollOffset. $E0 is written to as if it were the
        ; scroll register most of the time. However, its value is occasionally
        ; changed and then written to $0120 which is the true BG1 horizontal
        ; scroll register. Functionally this means this is the X position of
        ; BG1 relative to the camera.

    ; $E2[0x02] - (Main)
    .BG2HPos: skip $02
        ; The BG2 horizontal position. This is almost the BG1 horizontal scroll
        ; register SNES.BG2HScrollOffset. $E2 is written to as if it were the
        ; scroll register most of the time. However, its value is occasionally
        ; changed and then written to $011E which is the true BG2 horizontal
        ; scroll register. Functionally this means this is the X position of
        ; BG2 relative to the camera.

    ; $E4[0x02] - (Main, NMI)
    .BG3HScroll: skip $02
        ; The BG3 horizontal scroll register SNES.BG3HScrollOffset. Functionally
        ; this means this is the X position of BG3 relative to the camera.

    ; $E6[0x02] - (Main)
    .BG1VPos: skip $02
        ; The BG1 vertical position. This is almost the BG1 vertical scroll
        ; register SNES.BG1VScrollOffset. $E6 is written to as if it were the
        ; scroll register most of the time. However, its value is occasionally
        ; changed and then written to $0124 which is the true BG1 vertical scroll
        ; register. Functionally this means this is the Y position of BG1 relative
        ; to the camera.

    ; $E8[0x02] - (Main)
    .BG2VPos: skip $02
        ; The BG2 vertical position. This is almost the BG2 vertical scroll
        ; register SNES.BG2VScrollOffset. $E8 is written to as if it were the
        ; scroll register most of the time. However, its value is occasionally
        ; changed and then written to $0124 which is the true BG2 vertical scroll
        ; register. Functionally this means this is the Y position of BG2 relative
        ; to the camera.

    ; $EA[0x02] - (Main, NMI)
    .BG3VScroll: skip $02
        ; The BG3 vertical scroll register SNES.BG3VScrollOffset. Functionally
        ; this means this is the Y position of BG3 relative to the camera.

    ; $EC[0x02] - (Overworld, Dungeon)
    .CollisionType: skip $01
        ; Tilemap location calculation mask.
        ; UW: 0x01F8
        ; OW: 0xFFF8

    ; $ED[0x02] - (Overworld, Dungeon)
    .CollisionTypeHigh: skip $01
        ; The high byte of CollisionType.

    ; $EE[0x01] - (Dungeon, Player)
    .PlayerDunLayer:
        ; What layer in dungeons the player is currently on. Used to determine
        ; draw, tile interactions, and collision calculations mostly.
        ; 0 Means you're on the upper level (BG2). 
        ; 1 Means you're on a lower level (BG1).

    ; $EE[0x01] - (Polyhedral)
    .Poly_Unknown_EE: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $EF[0x01] - (Dungeon)
    .DunTransitionProp: skip $01
        ; Room transitioning properties
        ; .... ..sl
        ; l - If set, will trigger a layer swap. going from layer 1 to layer 2
        ;     and vis versa One example: Sanctuary and Hyrule Castle.
        ;     TODO: Find the exact rooms for this example.
        ; s - Transition between Sewer and Hyrule Castle. Xors the dungeon
        ;     index by 0x02 so this could be used for other dungeons that are
        ;     only different by their 2nd bit but its only vanilla use is going
        ;     between the castle and the sewers.
        ; This address is cleared every movement frame in the underworld but
        ; it's also set by certain door tiles. The effects of the address don't
        ; occur until an dungeon to dungeon transition.

    ; $EF[0x01] - (Polyhedral)
    .Poly_Unknown_EF: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; Joypad input:
    ; Joypad is the current state of the input.
    ; JoypadLast is the state of the input last frame.
    ; JoypadPressed is a rising edge trigger for the current state of the input.
    ; Meaning when a button is held down it will only appear for one frame here.
    ; So if you press A for 3 frames:
    ; +=======+========+============+===============+
    ; | Frame | Joypad | JoypadLast | JoypadPressed |
    ; +=======+========+============+===============+
    ; | 0     | 0      | 0          | 0             |
    ; +-------+--------+------------+---------------+
    ; | 1     | 1      | 0          | 1             |
    ; +-------+--------+------------+---------------+
    ; | 2     | 1      | 1          | 0             |
    ; +-------+--------+------------+---------------+
    ; | 3     | 1      | 1          | 0             |
    ; +-------+--------+------------+---------------+
    ; | 4     | 0      | 1          | 0             |
    ; +-------+--------+------------+---------------+
    ; | 5     | 0      | 0          | 0             |
    ; +-------+--------+------------+---------------+

    ; $F0[0x01] - (Input, NMI)
    .Joypad1High:
        ; Unfiltered Joypad 1 high Register SNES.JoyPad1DataHigh.
        ; Updated once per frame during NMI.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $F0[0x02] - (Polyhedral)
    .Poly_Unknown_F0: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $F1[0x01] - (Input, NMI)
    .Joypad2High: skip $01
        ; Unfiltered Joypad 2 high Register SNES.JoyPad2DataHigh.
        ; Input from joypad 2 is not read unless you do some ASM hacking.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $F2[0x01] - (Input, NMI)
    .Joypad1Low:
        ; Unfiltered Joypad 1 low Register SNES.JoyPad1DataLow.
        ; Updated once per frame during NMI.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $F2[0x01] - (Polyhedral)
    .Poly_Unknown_F2: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $F3[0x01] - (Input, NMI)
    .Joypad2Low: skip $01
        ; Unfiltered Joypad 2 low Register SNES.JoyPad2DataLow.
        ; Input from joypad 2 is not read unless you do some ASM hacking.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $F4[0x01] - (Input, NMI)
    .Joypad1PressedHigh: skip $01
        ; Pressed Joypad 1 high Register SNES.JoyPad1DataHigh.
        ; This is a rising edge trigger for the current state of the input.
        ; Meaning when a button is held down it will only appear for one frame
        ; here. Updated once per frame during NMI.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $F5[0x01] - (Input, NMI)
    .Joypad2PressedHigh: skip $01
        ; Pressed Joypad 2 high Register SNES.JoyPad2DataHigh.
        ; This is a rising edge trigger for the current state of the input.
        ; Meaning when a button is held down it will only appear for one frame
        ; here. Input from joypad 2 is not read unless you do some ASM hacking.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $F6[0x01] - (Input, NMI)
    .Joypad1PressedLow: skip $01
        ; Pressed Joypad 1 low Register SNES.JoyPad1DataLow.
        ; This is a rising edge trigger for the current state of the input.
        ; Meaning when a button is held down it will only appear for one frame
        ; here. Updated once per frame during NMI.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $F7[0x01] - (Input, NMI)
    .Joypad2PressedLow: skip $01
        ; Pressed Joypad 2 low Register SNES.JoyPad2DataLow.
        ; This is a rising edge trigger for the current state of the input.
        ; Meaning when a button is held down it will only appear for one frame
        ; here. Input from joypad 2 is not read unless you do some ASM hacking.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $F8[0x01] - (Input, NMI)
    .Joypad1LastHigh: skip $01
        ; Unfiltered Joypad 1 high Register SNES.JoyPad1DataHigh from the previous
        ; frame. Updated once per frame during NMI.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $F9[0x01] - (Input, NMI)
    .Joypad2LastHigh: skip $01
        ; Unfiltered Joypad 2 high Register SNES.JoyPad2DataHigh from the previous
        ; frame. Input from joypad 2 is not read unless you do some ASM hacking.
        ; BYsS udlr
        ; B - B button
        ; Y - Y button
        ; s - Select button
        ; S - Start button
        ; u - Up d-pad
        ; d - Down d-pad
        ; l - Left d-pad
        ; r - Right d-pad

    ; $FA[0x01] - (Input, NMI)
    .Joypad1LastLow: skip $01
        ; Unfiltered Joypad 1 low Register SNES.JoyPad1DataLow from the previous
        ; frame. Updated once per frame during NMI.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $FA[0x02] - (Polyhedral)
    .Poly_Unknown_FA: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $FB[0x01] - (Input, NMI)
    .Joypad2LastLow:
        ; Unfiltered Joypad 2 low Register SNES.JoyPad2DataLow from the previous
        ; frame. Input from joypad 2 is not read unless you do some ASM hacking.
        ; AXLR iiii
        ; A - A button
        ; X - X button
        ; L - Left shoulder button
        ; R - Right shoulder button
        ; i - ID for the controller type.

    ; $FC[0x01] - (Dungeon)
    .DunCameraBoundsXOverride: skip $01
        ; Overrides DunCameraBoundsX if non 0. This is only set when a blast wall
        ; is triggered.

    ; $FD[0x01] - (Dungeon)
    .DunCameraBoundsYOverride: skip $01
        ; Overrides DunCameraBoundsY if non 0. This is only set when a blast wall
        ; is triggered.

    ; $FE[0x01] - (Free)
    .Free_FE: skip $01
        ; Free RAM

    ; $FF[0x01] - (NMI)
    .VCountTarget: skip $01
        ; Vertical IRQ Trigger register SNES.VCountTImer. If the vertical scan
        ; line equals SNES.VCountTImer then it will trigger the IRQ. Is only set
        ; to 0x90 or 0x30 but SNES.VCountTImer is also set manually during NMI
        ; to 0x80.
        ; 0x90 - Set during the 3D triforce setup.
        ; 0x30 - When loading a save file (and it probably stays that way for
        ;        most of the game)

    ; ===========================================================================
    ; End of direct page memory and start of mirrored bank 0x7E memory locations
    ; ===========================================================================
    ; Page 0x01
    ; ===========================================================================
    
    ; This is beyond direct page and you can assume that all addresses here are
    ; $7EXXXX until you reach bank $7F.

    ; $0100[0x02] - (Player, GFX)
    .PlayerPoseChrIndex: skip $02
        ; An index that controls the graphics that need to be loaded for the
        ; player's head and body during NMI. The Chr is stored into $0ACC.

    ; $0102[0x02] - (Player, GFX)
    .PlayerAuxAChrIndex: skip $02
        ; The first index that controls the graphics that need to be loaded for
        ; the player's auxiliary during NMI. The Chr is stored into $0AD4.

    ; $0104[0x02] - (Player, GFX)
    .PlayerAuxBChrIndex: skip $02
        ; The second index that controls the graphics that need to be loaded
        ; for the player's auxiliary during NMI. The Chr is stored into $0AD6.

    ; $0106[0x01] - (Free)
    .Free_0106: skip $01
        ; Free RAM

    ; $0107[0x01] - (Player, GFX)
    .SwordChrIndex: skip $01
        ; An index that controls the graphics that need to be loaded for the
        ; player's sword during NMI. The Chr is stored into $0AC0.

    ; $0108[0x01] - (Player, GFX)
    .SheildChrIndex: skip $01
        ; An index that controls the graphics that need to be loaded for the
        ; player's shield during NMI. The Chr is stored into $0AC4.

    ; $0109[0x01] - (Player, GFX)
    .ItemChrIndex: skip $01
        ; An index that controls the graphics that need to be loaded for the
        ; player's shield during NMI. The Chr is stored into $0AC8.

    ; $010A[0x01] - (Dungeon)
    .DeathLoad: skip $01
        ; Set to nonzero whenthe player incurs death. Used if the player saved
        ; and continued (or just continued) after dying, indicating that the
        ; dungeon loading process will be slightly different.

    ; $010B[0x01] - (Free)
    .Free_010B: skip $01
        ; Free RAM

    ; $010C[0x01] - (Main)
    .ModuleCache: skip $01
        ; Temporary storage for the module number. Example: If we're in Overworld
        ; mode (0x09) and have to display a textbox (module 0x0E), 0x09 gets
        ; saved to this location on a temporary basis. Once the textbox
        ; disappears this module will be resumed.

    ; $010D[0x01] - (Free)
    .Free_010D: skip $01
        ; Free RAM. This was marked as the high byte for the ModuleCache in the
        ; original MoN dissassembly and as a SubmoduleCache in Kan's however I
        ; have confirmed that this byte is never written to outside of its
        ; initial zero-ing out and there are not other explicit references to it.

    ; $010E[0x02] - (Dungeon)
    .EntranceID: skip $02
        ; The index of the current entrance. TODO: Add a list of all the
        ; entrances here.

    ; $0110[0x02] - (Dungeon)
    .DunRoomIndexX3
        ; In the context of loading dungeon rooms, contains the index of the
        ; room (see DunRoomIndex) multiplied by 3. Allows for indexing into
        ; 24bit pointer address tables. Is only used while loading dungeon
        ; objects.

    ; $0112[0x01] - (Dungeon, Item)
    .MedallionScene: skip $01
        ; Apparently a flag indicating medallions  are falling.
        ; Stops the Menu from being dropped down too. It seems to work as
        ; a flag for any general extended animation that is currently in
        ; progress. Is also set during a blast wall opening scene.

    ; $0113[0x01] - (Free)
    .Free_0113: skip $01
        ; Free RAM.

    ; $0114[0x02] - (Dungeon)
    .DunCurrentTileType: skip $02
        ; Value of the type of tile the player is currently standing on. Only the
        ; lower byte contains the actual tile, the high byte is always 00.
        ; The high byte could almost be free RAM (Junk) but 00 is written to it
        ; constantly in dungeons.

    ; $0116[0x02] - (NMI, Tilemap)
    .ArbitraryTileMapAddress: skip $02
        ; The index for high bytes of VRAM tile map uploads. Also used as the
        ; high byte for VRAM addresses for various other uploads.

    ; $0118[0x01] - (NMI)
    .IncramentalUploadBufferLow: skip $01
        ; Local portion of an address used to transfer data from $7FXXXX to
        ; VRAM whenever variable VRAMIncramentalUpload is nonzero. This is
        ; always set to 0x00.

    ; $0119[0x01] - (NMI)
    .IncramentalUploadBufferHigh: skip $01
        ; Local portion of an address used to transfer data from $7FXXXX to
        ; VRAM whenever variable VRAMIncramentalUpload is nonzero.

    ; $011A[0x02] - (Main)
    .BGHShake: skip $02
        ; BG1 and BG2 X Offsets. Gets added to BG1HPosLow and BG2HPosLow and
        ; then stored into BG1HScroll and BG2HScroll respectively. Used in
        ; dungeon opening animations, the quake medallion effect, and in the
        ; dash bonk shake.

    ; $011C[0x02] - (Main)
    .BGVShake: skip $02 
        ; BG1 and BG2 Y Offsets. Gets added to BG1VPosLow and BG2VPosLow and
        ; then stored into BG1VScroll and BG2VScroll respectively. Used in
        ; dungeon opening animations, the quake medallion effect, and in the
        ; dash bonk shake.

    ; These are the true scroll registers for BG1 and BG2. Practically speaking,
    ; the regesters at $E0-$EA should be used instead of these.
    ; $011E[0x02] - (Main)
    .BG2HScrollLow: skip $01
        ; BG2 Horizontal Scroll Register SNES.BG2HScrollOffset.
        ; See BG2HPosLow and BGHShake for more details.

    ; $011F[0x01] - (Main)
    .BG2HScrollHigh: skip $01
        ; The high byte for BG2HScrollLow.

    ; $0120[0x02] - (Main)
    .BG1HScrollLow: skip $01
        ; BG1 Horizontal Scroll Register SNES.BG1HScrollOffset.
        ; See BG1HPosLow and BGHShake for more details.

    ; $0121[0x01] - (Main)
    .BG1HScrollHigh: skip $01
        ; The high byte for BG1HScrollLow.

    ; $0122[0x02] - (Main)
    .BG2VScrollLow: skip $01
        ; BG2 Vertical Scroll Register SNES.BG2VScrollOffset.
        ; See BG2VPosLow and BGVShake for more details.

    ; $0123[0x01] - (Main)
    .BG2VScrollHigh: skip $01
        ; The high byte for BG2VScrollLow.

    ; $0124[0x02] - (Main)
    .BG1VScrollLow: skip $01
        ; BG1 Vertical Scroll Register SNES.BG1VScrollOffset.
        ; See BG1VPosLow and BGVShake for more details.

    ; $0125[0x01] - (Main)
    .BG1VScrollHigh: skip $01
        ; The high byte for BG1VScrollLow.

    ; $0126[0x01] - (Dungeon, Overworld, Camera)
    .TransitionStepCounter: skip $01
        ; Used as a counter during dungeon and overworld transitions to count how
        ; many steps or how many times we've moved the camera over to the target
        ; area or room.

    ; $0127[0x01] - (Free)
    .Free_0127: skip $01
        ; Free RAM

    ; $0128[0x01] - (NMI)
    .IRQSet: skip $01
        ; Flags IRQ enabling during NMI.
        ; 0x00      - Don't update BG3 scroll
        ; 0x01–0x7F - Enable IRQ
        ; 0x80–0xFF - Disable IRQ

    ; $0129[0x01] - (Free)
    .Free_0129: skip $01
        ; Free RAM

    ; $012A[0x01] - (NMI)
    .PolyIRQ: skip $01
        ; Used during the crystal sequence and any time the triforce is used.
        ; When non-0, a different version of NMI will be used that also runs the
        ; polyhedral thread. Also causes a part of Vector_IRQ to be skipped.

    ; $012B[0x01] - (Free)
    .Free_012B: skip $01
        ; Free RAM

    ; $012C[0x01] - (SFX)
    .MusicControl: skip $01
        ; Music control. Written to SNES.APUIOPort0 when non-0.
        ; TODO: Find the official track names for each of these.
        ; 0x00 - No effect
        ; 0x01 - Triforce opening
        ; 0x02 - Light world
        ; 0x03 - Legend theme
        ; 0x04 - Bunny Link
        ; 0x05 - Lost woods
        ; 0x06 - Legend theme
        ; 0x07 - Kakkariko village
        ; 0x08 - Mirror warp
        ; 0x09 - Dark world
        ; 0x0A - Restoring the master sword
        ; 0x0B - Fairy theme
        ; 0x0C - Chase theme
        ; 0x0D - Dark world (skull woods)
        ; 0x0E - Game theme (Overworld only?)
        ; 0x10 - Hyrule castle
        ; 0x11 - Light World Dungeon
        ; 0x13 - Fanfare
        ; 0x15 - Boss theme
        ; 0x16 - Dark world dungeon
        ; 0x17 - Fortune teller
        ; 0x18 - Caves
        ; 0x19 - Sentiment of hope
        ; 0x1A - Crystal theme
        ; 0x1B - Fairy theme w/ arpeggio
        ; 0x1C - Fear & anxiety
        ; 0x1D - Agahnim unleashed
        ; 0x1E - Surprise!
        ; 0x1F - Ganondorf the Thief
        ; 0x20 - Nothing (as in it turns off any music)
        ; 0x21 - Agahnim unleashed
        ; 0x22 - Surprise!
        ; 0x23 - Ganondorf the Thief
        ; 0xF1 - Fade out
        ; 0xF2 - Half volume
        ; 0xF3 - Full volume
        ; 0xFF - Load a new set of music.

    ; $012D[0x01] - (SFX)
    .AmbientSFX: skip $01
        ; Ambient Sound effects. Written to SNES.APUIOPort1 when non-0.
        ; TODO: Verify all the names.
        ; 0x00 - Silence
        ; 0x01 - Outdoor rain
        ; 0x02 - Outdoor rain broken
        ; 0x03 - Indoor rain
        ; 0x04 - Indoor rain broken
        ; 0x05 - Silence
        ; 0x06 - Silence
        ; 0x07 - Rumbling Sound? (Seems fairly certain) (more echoey)
        ; 0x08 - Rumbling Sound? (Seems fairly certain)
        ; 0x09 - Wind 1
        ; 0x0A - Wind 2
        ; 0x0B - Activate Bird jingle Repeats 
        ; 0x0C - Activate Bird jingle Repeast broken
        ; 0x0D - Quest updated sound?
        ; 0x0E - Quest updated sound broken
        ; 0x0F - Save/Quit jingle
        ; 0x10 - Save/Quit jingle broken
        ; 0x11 - Prayer in the Desert (Sounds a bit like Sanctuary theme)
        ; 0x12 - Alternate "Prayer in the desert", or maybe one part of the harmony.
        ; 0x13 - Whoosh sound (bat ganon/ maybe agah?)
        ; 0x14 - Whoosh sound (bat ganon/ maybe agah?) broken
        ; 0x15 - Door to Triforce room opens
        ; 0x16 - Door to Triforce room opens broken
        ; 0x17 - Activate Bird jingle Single
        ; 0x80 - Fade out sound?

    ; $012E[0x01] - (SFX)
    .SFX1: skip $01
        ; Sound Effects 1. Written to SNES.APUIOPort2.
        ; 0x00 - none (no change)
        ; 0x01 - small sword swing 1 (Fighter Sword)
        ; 0x02 - small sword swing 2 (Fighter Sword)
        ; 0x03 - medium sword swing 1 (Master Sword and up)
        ; 0x04 - fierce sword swing 2 (Master Sword and up)
        ; 0x05 - object clinking against the wall
        ; 0x06 - object clinking the player's shield or a hollow door when poked
        ; 0x07 - shooting arrow (or red Goriyas shooting fireballs)
        ; 0x08 - arrow hitting wall
        ; 0x09 - really quiet sound
        ; 0x0A - hookshot cranking
        ; 0x0B - door shutting
        ; 0x0C - loud thud / heavy door shutting
        ; 0x0D - magic powder noise
        ; 0x0E - fire rod being fired
        ; 0x0F - ice rod being fired
        ; 0x10 - hammer being used?
        ; 0x11 - hammer pounding down stake
        ; 0x12 - really familiar but can't place it exactly  ; Shovel digging noise
        ; 0x13 - playing the flute
        ; 0x14 - the player picking something small up?
        ; 0x15 - Weird zapping noise   ; bunny link turning back into a bunny
        ; 0x16 - The player walking up staircase 1        ;  
        ; 0x17 - The player walking up staircase 2 (finishing on next floor)
        ; 0x18 - The player walking down staircase 1
        ; 0x19 - The player walking down staircase 2 (finishing on next floor)
        ; 0x1A - The player walking through grass?
        ; 0x1B - sounds like a faint splash or thud
        ; 0x1C - The player walking in shallow water
        ; 0x1D - picking an object up
        ; 0x1E - some sort of hissing (walking through grass maybe?)
        ; 0x1F - object smashing to bits
        ; 0x20 - item falling into a pit
        ; 0x21 - The player landing sound/ boss stepping sound
        ; 0x22 - loud thunderous noise
        ; 0x23 - pegasus boots slippy sound
        ; 0x24 - The player making a splash in deep water (but having to come back out)
        ; 0x25 - The player walking through swampy water
        ; 0x26 - The player taking damage
        ; 0x27 - The player passing out
        ; 0x28 - item falling onto shallow water
        ; 0x29 - rupees refill sound
        ; 0x2A - whiffy sound    ; aslo fire rod sound?
        ; 0x2B - low life warning beep
        ; 0x2C - pulling master sword out
        ; 0x2D - taking magic power damage from enemy
        ; 0x2E - Seems like a sound related to Ganon's Tower opening
        ; 0x2F - Seems like a sound related to Ganon's Tower opening
        ; 0x30 - chicken getting owned
        ; 0x31 - big fairy healing your wounds
        ; 0x32 - Whooshing noise, bug net swing
        ; 0x33 - cheesy noise that happens when Agahnim makes chicks disappear
        ; 0x34 - cheesy noise that happens when Agahnim makes chicks disappear
        ; 0x35 - faint rumbling noise
        ; 0x36 - faint rumbling noise
        ; 0x37 - spin attack has powered up
        ; 0x38 - swimming noise
        ; 0x39 - thunderous noise while Ganon's tower opens
        ; 0x3A - some kind of clinky hit
        ; 0x3B - sounds like magic powder but unfamiliar
        ; 0x3C - Error noise
        ; 0x3D - something big falling into water? (Argghus?)
        ; 0x3E - playing the flute (quieter)
        ; 0x3F - magic powder

    ; $012F[0x01] - (SFX)
    .SFX2: skip $01
        ; Sound Effects 2. Written to SNES.APUIOPort3.
        ; 0x00 - none (no change)
        ; 0x01 - master sword beam
        ; 0x02 - unintelligble switch noise
        ; 0x03 - ????? yet another loud thud  ; loud stomp /door?
        ; 0x04 - Nutcase soldier getting pissed off
        ; 0x05 - shooting a fireball (Lynel)
        ; 0x06 - ?????    ; low whoosh sound
        ; 0x07 - giant metal balls coming out of nodes
        ; 0x08 - normal enemy taking a big hit
        ; 0x09 - normal enemy dying
        ; 0x0A - collecting rupee
        ; 0x0B - collecting single heart
        ; 0x0C - text scrolling flute noise
        ; 0x0D - single heart filling in on HUD
        ; 0x0E - sound of a chest being opened
        ; 0x0F - you got an item sound 1 ; key item out of chest
        ; 0x10 - switching to map sound effect
        ; 0x11 - menu screen going down
        ; 0x12 - menu screen going up
        ; 0x13 - throwing an item
        ; 0x14 - clink (not sure what it's used for)
        ; 0x15 - loud thud 1   ; armous bounce?
        ; 0x16 - loud thud 2   ; armous bounce?
        ; 0x17 - rats
        ; 0x18 - dragging something
        ; 0x19 - zora shooting fireball
        ; 0x1A - minor puzzle solved   ; secret revealed
        ; 0x1B - major puzzle solved   ; secret revealed
        ; 0x1C - doing minor damage to enemy
        ; 0x1D - taking magic power damage from enemy
        ; 0x1E - keese flitting around
        ; 0x1F - Link screaming when he falls into a hole
        ; 0x20 - switch menu item
        ; 0x21 - boss taking damage
        ; 0x22 - boss dying
        ; 0x23 - spin attack sound
        ; 0x24 - switching between different mode 7 map perspectives
        ; 0x25 - triggering a switch
        ; 0x26 - Agahnim's lightning
        ; 0x27 - Agahnim powering up an attack
        ; 0x28 - Agahnim / Ganon teleporting
        ; 0x29 - Agahnim shooting a beam
        ; 0x2A - tougher enemy taking damage.
        ; 0x2B - The player getting electrocuted
        ; 0x2C - bees buzzing
        ; 0x2D - Major achievement completed (e.g. getting a piece of heart)
        ; 0x2E - Major item obtained (e.g. Pendant or Heart Container)
        ; 0x2F - obtained small key
        ; 0x30 - blob popping out of ground
        ; 0x31 - Moldorm's weird track like noise
        ; 0x32 - bouncing off a bungie
        ; 0x33 - short unknown jingle
        ; 0x34 - Sounds like defunct version of sound 0x35 below. Seems to be unused.
        ; 0x35 - Sound that plays in response to picking up a heart container during
        ; a bo - ight.
        ; 0x36 - Sound of a beam being fired (Mothula, Wizzrobes, etc).
        ; 0x37 - Neat sound... consider using as a confirmation (though make sure it's not buggy)
        ; 0x38 - ...
        ; 0x39 - ...
        ; 0x3C - Obtained mid level item (e.g. bombs from a chest)
        ; 0x3D - ...
        ; 0x3E - Unused drum roll thing? need to be confirmed
        ; 0x3F - More minor fanfares

    ; $0130[0x01] - (SFX)
    .LastMusic: skip $01
        ; Stores the last non-0 value that was stored in MusicControl. Mostly
        ; used to check when we need to set the volume back to full after setting
        ; it to half.

    ; $0131[0x01] - (SFX)
    .LastSFX1: skip $01
        ; Stores the last non-0 SFX value that was stored into SFX1. Used to
        ; prevent the same sound effect from being spammed over and over.

    ; $0132[0x01] - (SFX)
    .MusicQueue: skip $01
        ; Buffer for playing songs. Put a value here to try to play a song.
        ; Will try to write to MusicControl under certain conditions.

    ; $0133[0x01] - (SFX)
    .LastAPU0: skip $01
        ; Stores the last value that was written to APU0 or LastMusic. Used to
        ; prevent spamming the same music over and over.

    ; $0134[0x02] - (Dungeon, NMI, Overworld)
    .AnimatedTargetVRAM: skip $02
        ; VRAM target address for animated tiles. The animated tiles are uploaded
        ; via DMA during NMI every frame (reguardless if the animation frame has
        ; changed or not) and this is the VRAM address where they will end up.
        ; $3B00 - For dungeon animated tiles.
        ; $3C00 - For overworld animated tiles.

    ; $0136[0x01] - (SFX)
    .MusicBank: skip $01
        ; Flags which song bank was last loaded to APU.
        ; 0x00 - Overworld
        ; 0x01 - Underworld

    ; $0137[0xC6] - 
    .StackEnd: skip $C6
        ; The end of the normal (Non-IRQ) stack.

    ; $01FF[0x01] - 
    .Stack: skip $01
        ; The start of the Normal (Non-IRQ) stack. Every time you run a PHA/PLA
        ; or make a jump with a JSR/JSL those values are written here starting at
        ; $01FF and moving up to $0137. It is technically possible to go past
        ; $0137 but I guess the devs decided that the game would never use that
        ; much space in the stack.

    ; ===========================================================================
    ; Page 0x02
    ; ===========================================================================

    ; $0200[0x02] - (Main)
    .Subsubmodule:
        ; Sub-submodule index for various submodules.

    ; $0200[0x02] - (File)
    .FileCurrentSaveOffset:
        ; (Bank 0x00 and 0x0C) Used to temporarily store the save file offset.

    ; $0200[0x02] - (Main)
    .AttractTimer3: skip $02
        ; (Bank 0x0C) Used as a timer to keep track of how long to show each BG3
        ; "legend" image.

    ; $0202[0x02] - (Equipment, High Junk)
    .SelectedYItem: skip $02
        ; The currently selected Y button item. The High byte is written to but unused.
        ; TODO: Put in all of the valid items here.

    ; $0204[0x01] - (File, Equipment, Junk)
    .Junk_0204: skip $01
        ; Written to once in the eqipment code and once while loading a save
        ; file but is never read from.

    ; $0205[0x01] - (Equipment)
    .BottleMenuTimer: skip $01
        ; Used to time the opening and closing of the bottle sub menu.
        ; Also referenced in unused dungeon map module.

    ; $0206[0x01] - (Equipment, Junk)
    .EquipmentFrame: skip $01
        ; The equipment module increments it as a frame counter similar to $1A,
        ; but it is never read.

    ; $0207[0x01] - (Equipment)
    .EquipmentCursorBlink: skip $01
        ; Incremented every frame and masked with 0x10 to blink the equipment
        ; menu cursor. If bit 4 is set, the cursor is visible. Otherwise, it is
        ; not. Reset to 0x10 when moving the cursor.

    ; $0208[0x01] - (HUD)
    .HeartFlipTimer: skip $01
        ; Countdown timer that controls when the next animation of hearts being
        ; filled in occurs (the rotating animation).

    ; $0209[0x01] - (HUD)
    .HeartFlipFrame: skip $01
        ; Index related to HeartFlipTimer. This determines the chr used in each
        ; step of the heart refil animation. When HeartFlipTimer counts down to
        ; zero, $0209 is incremented, then once $0209 reaches 4 it is reset and
        ; CurrentlyHealing is set to zero to indicate that the animation for\
        ; this particular heart is finished.
        ; TODO: Add what each frame is.
        ; 0x00 - 
        ; 0x01 - 
        ; 0x02 - 
        ; 0x03 - 

    ; $020A[0x01] - (HUD)
    .CurrentlyHealing: skip $01
        ; Flag that indicates whether a heart refill animation is taking place.
        ; 0 - Not healing
        ; Non-0 - healing

    ; $020B[0x01] - (Equipment, Junk)
    .EquipmentRodDebug: skip $01
        ; Appears to be a flag related to the menu and rod items. Zeroed in
        ; several places, but never set to any other value.

    ; $020C[0x01] - (Free)
    .Free_020C: skip $01
        ; Free RAM

    ; $020D[0x01] - (Dungeon Map)
    .DunMapInitSubmodule: skip $01
        ; Used as a submodule for the dungeon map function: DungeonMap_Init.

    ; $020E[0x01] - (Dungeon Map)
    .DunMapFloor: skip $01
        ; Floor index for the selected floor in the dungeon map. Starts off
        ; being equal to DunFloor and is then changed by the player pressing up
        ; or down on the dpad to see different floors.
        ;   0x00 - Floor 1
        ;   Positive values indingating floors above the ground floor.
        ;   Negative values indicate basement floors.

    ; $020F[0x01] - (Junk)
    .Junk_020F: skip $01
        ; Set to 00 once in the dungeon map code in Bank 0x0A but is never read.

    ; $0210[0x01] - (Dungeon Map)
    .DunMapInputFlag: skip $01
        ; Used to prevent reading input while scrolling between floors in the
        ; dungeon map.
        ; 0 - Will read input
        ; 1 - Will not read input

    ; $0211[0x02] - (Dungeon Map, High Junk)
    .DunMapCurrentFloor: skip $02
        ; Of the two floors shown on a dungeon map, this indicates which one is
        ; of the floor the player is currently on. High byte isn't relevant and is
        ; zeroed during drawing.
        ;   0x00 - top map
        ;   0x02 - bottom map

    ; $0213[0x02] - (Dungeon Map)
    .DunMapScrollTarget: skip $02
        ; Acts as the Y target for dungeon map scrolling. Appears to have been
        ; used as a Y velocity for the scrolling in an unused function as well.

    ; $0215[0x02] - (Dungeon Map)
    .DunMapPlayerXPos: skip $02
        ; The X position to draw the flashing red/yellow/white dot showing where
        ; the player is on the map grid. This also controls the X position of the
        ; blinking red/white room cross hair box also showing what room the
        ; player is.

    ; $0217[0x02] - (Dungeon Map)
    .DunMapPlayerYPos: skip $01
        ; The Y position to draw the flashing red/yellow/white dot showing where
        ; the player is on the map grid. Unlike the X position, this does NOT
        ; control the Y position of the blinking red/white room cross hair box.
        ; That is instead controlled by $0CF5.

    ; $0218[0x01] - (Dungeon Map)
    .DunMapPlayerYPosHigh: skip $01
        ; The high byte of DunMapPlayerYPos.

    ; $0219[0x02] - (HUD, Tilemap)
    .HUDTileMapLocation: skip $02
        ; Specifically used as the target address in VRAM for the HUD portion of
        ; the BG3 tilemap. $6040 is written to this once during save file
        ; loading and then stays that way for the rest of the game.

    ; $021B[0x02] - (Free)
    .Free_021B: skip $02
        ; Free RAM
        ; According to Kan: Unused but referenced in an unused table entry
        ; indicating this address would have been used for stripes data of
        ; some sort...?

    ; $021D[0x02] - (Free, Junk)
    .Free_021D: skip $02
        ; The value 0x4841 is written to this and Free_021E once during file
        ; loading and then never used again. Can be reasonably used as free RAM.

    ; $021F[0x02] - (Free)
    .Free_021F: skip $02
        ; The value 0x007F is written to this and Free_0220 once during file
        ; loading and then never used again. Can be reasonably used as free RAM.

    ; $0221[0x02] - (Free)
    .Free_0221: skip $02
        ; The value 0xFFFF is written to this and Free_0222 once during file
        ; loading and then never used again. Can be reasonably used as free RAM.

    ; $0223[0x01] - (Junk)
    .Junk_0223: skip $01
        ; Zeroed during message routines, but never used.

    ; $0224[0x0C] - (Free)
    .Free_224: skip $0C
        ; Free RAM. MoN did give this a note saying it wasn't but I tested it
        ; any was unable to recreate the effects he mentioned and these adresses
        ; are not referenced anywhere in ROM. Kan's also agrees that these are
        ; indeed free.
        ; Original MoN note:
        ; Free RAM? - Nope! causes some funky faded effects and a lack of an
        ; overworld.

    ; $0230[0x50] - (Free)
    .Free_0230: skip $50
        ; Free RAM.

    ; $0280[0x0A] - (Ancilla)
    .AncPriority: skip $0A
        ; Ancilla OAM priority If nonzero, use highest priority, otherwise use
        ; default priority.

    ; $028A[0x0A] - (Ancilla)
    .AncCollisionTimer: skip $0A
        ; Timer to rate limit tile collision calculations. Set to 0x06 after a
        ; collision.

    ; $0294[0x0A] - (Ancilla)
    .AncZVelocity: skip $0A
        ; Ancilla Z velocity.

    ; $029E[0x0A] - (Ancilla)
    .AncZPos: skip $0A
        ; Ancilaa Z cooridnate.

    ; $02A8[0x0A] - (Ancilla)
    .AncSubZVelocity: skip $0A
        ; Ancilla subpixel Z velocity.

    ; $02B2[0x0E] - (Free)
    .Free_02B2: skip $0E
        ; Free RAM.

    ; $02C0[0x02] - (Dungeon, High Junk)
    .TileActAutoStairs: skip $02
        ; Tile act bitfield used by intraroom stairs. If this variable masked
        ; with s is nonzero, the player moves as though he's on an in-room south
        ; staircase If this variable masked with n is nonzero, the player moves
        ; as though he's on an in-room north staircase. High byte unused but
        ; written.
        ; .... .... sss. nnn.
        ;   s - south
        ;   n - north
        ; SEE TILE ACT NOTES

    ; $02C2[0x01] - (Junk)
    .Junk_02C2: skip $01
        ; The value of AttractBrightnessFlag gets cached here in a couple places
        ; but it is never read from.

    ; $02C3[0x01] - (Push Block, Dungeon)
    .PushBlockStep: skip $01
        ; The step counter for push blocks.

    ; $02C4[0x01] - (Push Block, Dungeon)
    .PushBlockTimer: skip $01
        ; A timer used to control push blocks.

    ; $02C5[0x01] - (Player)
    .PlayerJumpDelay: skip $01
        ; Related to PlayerRecoilTimer. Some weird timer/flag when doing very long
        ; jumps or recoils. Seems to cause the player to hesitate briefly before
        ; actually jumping.

    ; $02C6[0x01] - (Player)
    .BounceShift: skip $01
        ; Seems to be a counter for the player's bouncing and how many shifts
        ; right to perform.

    ; $02C7[0x01] - (Player)
    .PlayerRecoilTimerTemp: skip $01
        ; A value to be eventually manipulated and stored into PlayerRecoilTimer.

    ; $02C8[0x01] - (Free)
    .Free_02C8: skip $01
        ; Free RAM.

    ; $02C9 - (Player, Junk)
    .PlayerPitFallAnimation: skip $01
        ; Used to temporarily store the index of the pit fall animation. Only
        ; written to once and read from very shortly after. Could be used as
        ; free RAM (Junk) as long as its not in a room or area with pits. You
        ; could also just use a PHX and PLX instead.

    ; $02CA - (Player)
    .PushFallTimer: skip $01
        ; Timer that counts up to 0x1F when pushing a wall into falling.
        ; TODO: Unsure of what it accomplishes. Could be used to handle and edge
        ; case where the player goes straight from pushing a block into falling.

    ; $02CB[0x01] - (Player)
    .PlayerSwimStrokeTimer: skip $01
        ; A timer that controls the length of the player's swim stroke.
        ; TODO: Confirm this.

    ; $02CC[0x01] - (Player)
    .PlayerSwimAnimationOffset: skip $01
        ; Acts as a step offset for swimming.
        ; 0 - 
        ; 1 - 
        ; 2 - 
        ; TODO: Fill these out.

    ; $02CD[0x02] - (Tagalong)
    .TagalongMessageTimer: skip $01
        ; A timer to control how long until a tagalong can display a message.
        ; Used for the beginning of the game where Zelda telepathically
        ; contacts you over and over again and a few other smaller cases.

    ; $02CE[0x02] - (Tagalong)
    .TagalongMessageTimerHigh: skip $01
        ; The high byte for TagalongMessageTime.

    ; $02CF[0x01] - (Tagalong)
    .TagalongAnimationRead: skip $01
        ; The tagalong animation step index. Used for reading data.
        ; 0x00-0x13
        ; TODO: Add each animation step.

    ; $02D0[0x01] - (Tagalong, Hookshot)
    .TagalongHookshot: skip $01
        ; Flag set when using hookshot with a tagalong. Forces game mode check.

    ; $02D1[0x01] - (Tagalong, Hookshot)
    .TagalongAnimationWriteChache: skip $01
        ; Temprary cache location for TagalongAnimationWrite after the hookshot
        ; is finished.

    ; $02D2[0x01] - (Tagalong, Player)
    .TagalongGrabTimer: skip $01
        ; When the player loses a Tagalong object, such as the Super Bomb or the
        ; old man, this seems to be a timer before they can be reacquired.

    ; $02D3[0x01] - (Tagalong)
    .TagalongAnimationWrite: skip $01
        ; The tagalong animation step index. Used for writing data.
        ; 0x00-0x13
        ; TODO: Add each animation step.

    ; $02D4[0x01] - (Junk)
    .Junk_02D4: skip $01
        ; Zeroed in one location, never read.

    ; $02D5[0x01] - (Free)
    .Free_02D5: skip $01
        ; Free RAM

    ; $02D6[0x01] - (Junk)
    .Junk_02D6: skip $01
        ; Zeroed twice in tagalong code, never read.

    ; $02D7[0x01] - (Tagalong)
    .TagalongDrawChange
        ; TODO: Seems to be something with overriding properties by changing the
        ; chr read. Needs further investigation.

    ; $02D8[0x01] - (Item)
    .RecieveItem: skip $01
        ; The index of the item you receive when you open a chest or pick up
        ; an item off the ground, or otherwise obtain the item (like the player
        ; getting the sword from the Uncle)
        ; TODO: Add all of the available items.

    ; $02D9[0x01] - (Junk)
    Junk_02D9: skip $01
        ; Written to with a value of 0x60 when receiving an item, but never read.

    ; $02DA[0x01] - (Player)
    .PlayerItemPose: skip $01
        ; Flag indicating whether the player is in the pose used to hold an item
        ; or not.
        ; 0x00            - No extra pose.
        ; 0x01, 0x03-0xFF - Holding up item with one hand pose
        ; 0x02            - Holding up item with two hands pose (e.g. triforce)

    ; $02DB[0x01] - (Player)
    .PreventWarp: skip $01
        ; Flag that prevents warp tiles from activating. Set during world
        ; changes, but always seems cleared before it can be read. Triggered by
        ; the Whirlpool sprite (but only when touched in Area 0x1B). The
        ; Whirlpool sprite used is not visible to the player, and is placed in
        ; the open perimeter gate to Hyrule Castle after beating Agahnim. I
        ; guess they needed some mechanism to make that happen, and that sprite
        ; was specialized in order to do so.

    ; $02DC[0x02] - (Player)
    .PlayerXCoordCache: skip $01
        ; Mirror of the player's X coordinate which is used in a Bank 07 function
        ; Link_HandleDiagonalKickback.

    ; $02DD[0x01] - (Player)
    .PlayerXCoordCacheHigh: skip $01
        ; The high byte of PlayerXCoordCache.

    ; $02DE[0x02] - (Player)
    .PlayerYCoordCache: skip $02
        ; Mirror of the player's Y coordinate which is used in a Bank 07 function
        ; Link_HandleDiagonalKickback.

    ; $02DF[0x01] - (Player)
    .PlayerYCoordCache: skip $01
        ; The high byte of PlayerYCoordCache.

    ; $02E0[0x01] - (Player)
    .PlayerIsBunny2: skip $01
        ; Flag for Player's graphics set. Mirrored at PlayerIsBunny, One of the 2
        ; could just be removed as they appear to always be eqaul.
        ; 0 - Normal Link.
        ; 1 - Bunny Link.
        ; All other values are invalid.

    ; $02E1[0x01] - (Player)
    .IsPoofing: skip $01
        ; The player is transforming? Poofing in a cloud to transform into the
        ; bunny or when using the cape.

    ; $02E2[0x01] - (Player)
    .PoofTimer: skip $01
        ; Timer for when the player is poofing.

    ; $02E3[0x01] - (Player)
    .SwordCoolDown: skip $01
        ; Cooldown timer for the sword after dashing through an enemy. Is set on
        ; hits in general, but often irrelevant.

    ; $02E4[0x01] - (Player, Tagalong, Equipment)
    .CutsceneFlag: skip $01
        ; Flag that, if nonzero, will not allow the player to move, tagalongs to
        ; move, will not allow entering the equipment menu, etc. Generally used
        ; during cutscenes such as talking to any npc with an event (zelda, kiki,
        ; priest, etc.)

    ; $02E5[0x02] - (Player, Tile Attribute, High Junk)
    .TileActChest: skip $02
        ; Bitfield for chest interaction. High byte unused but written. SEE TILE
        ; ACT NOTES.
        ; .... cccc
        ; c - touching chest

    ; $02E7[0x01] - (Playe, Tile Attribute)
    .TileActChestGrave: skip $01
        ; Tile act bitfield for big key locks and gravestone interactions.
        ; bbbb gggg
        ; b - big key lock
        ; g - gravestone

    ; $02E8[0x01] - (Player, Tile Attribute)
    .TileActSpikePegs: skip $01
        ; Tile act bitfield for spike / cactus and barrier tile interactions?
        ; bbbb ssss
        ; s - spike blocks / cactus tiles
        ; b - orange / blue barrier tiles that are up

    ; $02E9[0x01] - (Item)
    .RecieveItemMethod: 
        ; The method by which the player is recieving an item.
        ; 0 - Receiving item from an NPC or message
        ; 1 - Receiving item from a chest
        ; 2 - Receiving item that was spawned in the game by a sprite
        ; 3 - Receiving item that was spawned by a ancilla.

    ; $02EA[0x02] - (Player, Tile Attribute, High Junk)
    .ChestTileType: skip $02
        ; Tile type of chests referenced when opening a chest. High byte unused
        ; but written.

    ; $02EC[0x01] - (Player, Ancilla) 
    .LiftableID: skip $01
        ; When the player is near a liftable ancilla, this holds its slot+1. Often
        ; just used as a non zero check to see if the player can lift something.

    ; $02ED[0x01] - (Player, Tile Attribute, DesertBarrier) 
    .NearPlaque: skip $01
        ; If nonzero, it indicates that the player is near the plaque tile that
        ; triggers the Desert Palace opening with the Book of Mudora. TODO:
        ; Check if this is only the desert palace plaque or if its all plaques.

    ; $02EE[0x01] - (Player, Tile Attribute, DesertBarrier)
    .TileActSpikePlaque: skip $01
        ; Tile act bitfield for spike floor and hylian plaques tile interactions
        ; ssss pppp
        ; p - plaques
        ; s - spike floor tiles

    ; $02EF[0x01] - (Player, Tile Attribute)
    .TileActBreakEntrance: skip $01
        ; Tile act bitfield for dashable (breakable with dash) and entrances
        ; tile interactions.
        ; bbbb dddd
        ;   d - entrance
        ;   b - breakables

    ; $02F0[0x01] - (DesertBarrier)
    .DesertBarrierFlag: skip $01
        ; When nonzero, the Desert Barrier activates and allows the player to
        ; progress into the Desert Palace.

    ; $02F1[0x01] - (Player)
    .DashStop: skip $01
        ; Related to dashing. Set to 0x40 at start, counts down to 0x20. If it
        ; could reach 0x0F (which it can't), the player would stop moving. TODO:
        ; Figure out exact use.

    ; $02F2[0x01] - (Tagalong)
    .TagalongMessageSent: skip $01
        ; Used as a bitfield of event flags of a temporary nature relating to
        ; Tagalongs. Specifically these are usually used to indicate if a text
        ; message triggered by a Tagalong has already fired once while being
        ; in a room or an overworld area.
        ; TODO: Map the bitfield.

    ; $02F3[0x01] - (Junk)
    .Junk_02F3: skip $01
        ; Zeroed in one place in bank 0x09, but otherwise unused.

    ; $02F4[0x01] - (Player)
    .LiftCache: skip $01
        ; Only use is for caching the current value of $0314 while handling the
        ; A button press.

    ; $02F5[0x01] - (Player, Somaria)
    .PlayerOnSomaria: skip $01
        ; 0 - Not on a Somaria platform.
        ; 1 - On a Somaria platform.
        ; 2 - On a Somaria platform and moving.

    ; $02F6[0x01] - (Player, Tile Attribute, Hookshot)
    .TileActHookshotDoor: skip $01
        ; Bitfield for interaction with hookshot grabbable and key/flagable door
        ; tiles.
        ; kkkk gggg
        ; k - Key Door tiles/ flagable door tiles
        ; g - Tiles grabbable by Hookshot

    ; $02F7[0x01] - (Player, Tile Attribute)
    .TileActRupee: skip $01
        ; Tile act bitfield used by rupees.
        ; bbbb rrrr
        ;   b - rupee tiles (low)
        ;   r - rupee tiles (high)
        ; SEE TILE ACT NOTES

    ; $02F8[0x01] - (Player)
    .PlayerThud: skip $01
        ; Flag used to make the player make a noise when he gets done bouncing
        ; after a wall he's dashed into. Thus, it only has any use in relation to
        ; dashing.

    ; $02F9[0x01] - (Tagalong)
    .TagalongDraw: skip $01
        ; When set, prevents follower from drawing and forces a game mode check.

    ; $02FA[0x01] - (Player, Statue)
    .PlayerDrag: skip $01
        ; Flag that is set if you are near a moveable statue (close enough to
        ; grab it) causes the player to drag.

    ; $02FB[0x05] - (Free)
    .Free_02FB: skip $05
        ; Free RAM

    ; ===========================================================================
    ; Page 0x03
    ; ===========================================================================

    ; $0300[0x01] - (Player)
    .ElectrocutionTimer:
        ; Timer for player electrocution.

    ; $0300[0x01] - (Player, Item)
    .ItemStep: skip $01
        ; Step counter for item animations.

    ; $0301[0x01] - (Player, Item)
    .ItemUseFlag1: skip $01
        ; When non zero, the player has something in his hand, poised to strike.
        ; It's intended that only one bit in this flag be set at any time.
        ; Also see ItemUseFlag2
        ; bp.a ethr
        ; b - Boomerang
        ; p - Magic Powder
        ; a - Bow and Arrow
        ; e - Tested for simultaneously with the hammer in many locations. Perhaps
        ;     this suggests another hammer-like item was cut from the game during
        ;     development.
        ; t - Tested for exclusively with the rods bit, but no code seems to set
        ;     this particular bit. Perhaps at one point the bits for the two rods
        ;     were separate at some point.
        ; h - Hammer
        ; r - Ice Rod or Fire Rod

    ; $0302[0x01] - (Player)
    .PlayerCollision: skip $01
        ; Seems to be a flag for intraframe wall collisions, indicating pushback.

    ; $0303[0x01] - (Player, Item)
    .CurrentItem: skip $01
        ; This indicates which secondary item is equipped (aka Y-button item).
        ; See: MenuID_to_EquipID in bank 0x0D.
        ; 0x00 - Nothing
        ; 0x01 - Bombs
        ; 0x02 - Boomerang
        ; 0x03 - Arrows
        ; 0x04 - Hammer
        ; 0x05 - Fire Rod
        ; 0x06 - Ice Rod
        ; 0x07 - Bug catching net
        ; 0x08 - Flute
        ; 0x09 - Lamp
        ; 0x0A - Magic Powder
        ; 0x0B - Bottle
        ; 0x0C - Book of Mudora
        ; 0x0D - Cane of Byrna
        ; 0x0E - Hookshot
        ; 0x0F - Bombos Medallion
        ; 0x10 - Ether Medallion
        ; 0x11 - Quake Medallion
        ; 0x12 - Cane of Somaria
        ; 0x13 - Cape
        ; 0x14 - Magic Mirror

    ; $0304[0x01] - (Player, Item)
    .ActiveItem: skip $01
        ; The actively being used item, copied from CurrentItem.

    ; $0305[0x01] - (Junk)
    .Junk_0305: skip $01
        ; Debug variable only seen in Bank 07. If not equal to 0x01,
        ; it will cause $1E and $1F to not be zeroed out every frame,
        ; which could cause some graphical oddities.

    ; $0306[0x01] - (Junk)
    .Junk_0306: skip $01
        ; Apparently only written to as a temporary cache for the
        ; A button action $036C but never read from.

    ; $0307[0x01] - (Item)
    .RodType: skip $01
        ; Contains ActiveItem minus 4 to get rod type. This is used to change the
        ; palette of the rod during player OAM and to control which ice or fire
        ; ancilla to spawn from it.
        ;   0x01 - Fire rod
        ;   0x02 - Ice rod
        ; Any other value would crash the game on use.

    ; $0308[0x01] - (Player)
    .AAction: skip $01
        ; Bitfield for certain A button presses.
        ; h... ..dt
        ;   h - carrying/tossing item (including wishing wells)
        ;   d - Desert prayer
        ;   t - tree pull

    ; $0309[0x01] - (Player)
    .PlayerCarryFlag: skip $01
        ; Bitfield for carry-related actions.
        ; .... ..tl
        ;   t - tossing object
        ;   l - lifting object

    ; $030A[0x01] - (Player, OAM)
    .PlayerStrainAnimation: skip $01
        ; Indexes the player's grab animation, but all nonzero values seem to
        ; behave the same way. Used with $030B.
        
        ; TODO: Investigate this.
        ; Also, $030A-B seem to be used for the opening of the desert palace.

    ; $030B[0x01] - (Player, OAM)
    .PlayerStrainTimer: skip $01
        ; Animation timer for throwing and picking up items like rocks or signs.

    ; $030C[0x01] - (Free)
    .Free_030C: skip $01
        ; Free RAM.

    ; $030D[0x01] - (Player, OAM)
    .PlayerSweat: skip $01
        ; Player sweat drop animation.

    ; $030E[0x01] - (Junk)
    .Junk_030E: skip $01
        ; Always seems to be set to 0, and only read during OAM handling
        ; of the player sprite.

    ; $030F[0x01] - (Free)
    .Free_030F: skip $01
        ; Free RAM.

    ; $0310[0x02] - (Dungeon)
    .FloorVelocityY: skip $02
        ; The Y velocity of a moving floor (For example: Mothula's room).

    ; $0312[0x02] - (Dungeon)
    .FloorVelocityX: skip $02
        ; The X velocity of a moving floor (For example: Mothula's room).

    ; $0314[0x01] - (Player, Sprite)
    .SpriteLift: skip $01
        ; The index (the X in $0DD0 for example) of a liftable sprite that the
        ; player is near, +1.

    ; $0315[0x01] - (Player)
    .UnknownCollisionFlag: skip $01
        ; Seems to be a flag that is set to 0 if the player is not moving, 
        ; and 1 if he is moving. However it doesn't seem to get reset to zero.
        ; Set to 2 in certain scenarios, appears to be used in collision checks.
        ; TODO: Confirm uses.

    ; $0316[0x02] - (Dungeon)
    .Unknown_0316: skip $02
        ; TODO: Figure out wtf this actually does.
        ; ???? bunny stuffs?
        ; Flags which axes moving walls should push or something.

    ; $0318[0x02] - (Player, Dungeon)
    .FloorY: skip $02
        ; Scratch spaced used for caching the player's Y coordinate during moving
        ; floor routines.

    ; $031A[0x02] - (Player, Dungeon)
    .FloorX: skip $02
        ; Scratch spaced used for caching the player's X coordinate during moving
        ; floor routines.

    ; $031C[0x01] - (Player, OAM)
    .PlayerSpinGFX: skip $01
        ; Animation GFX for spin attack animations, including medallions.

    ; $031D[0x01] - (Player, OAM)
    .PlayerSpinStep: skip $01
        ; Animation step for spin attack animations, including medallions.

    ; $031E[0x01] - (Player, OAM)
    .PlayerSpinStepOff: skip $01
        ; Used as an offset for a table to retrieve values for $031C. The offset
        ; comes in increments of four, depending on which direction the player is
        ; facing when he begins to spin. This makes sense, given that he always
        ; spins the same direction, and allows for reusability between the
        ; different directions, each one being a sub set of the full sequence.

    ; $031F[0x01] - (Player, OAM)
    .IFrameTimer: skip $01
        ; Countdown timer for invulnerability frames. Causes the player's sprite to
        ; flash on and off.

    ; $0320[0x02] - (Tile Attribute, High Junk)
    .MovingFloorTileAct:
        ; Bitfield for interaction with moving floor tiles
        ; ........ ....mmmm
        ; m - Moving floor
        ; High byte unused but written.

    ; $0322[0x01] - (Player)
    .Unknown_0322: skip $01
        ; TODO: Some player related bitfield flagging interaction with
        ; MovingFloorTileAct?

    ; $0323[0x01] - (Player, OAM)
    .PlayerHeadingMirror: skip $01
        ; A sudo mirror of PlayerHeading, which is an indicator for which
        ; direction you are facing. Only used in the rendering of the player's OAM
        ; data in Bank 0x0D. Has one case where it is not a 1 for 1 match with
        ; PlayerHeading in PlayerOam_Main in bank 0x0D. Explicitly set to down
        ; (0x02) for Desert prayer.

    ; $0324[0x01] - (Player, Item)
    .AddSpell: skip $01
        ; A flag telling a medallion spell it's okay to proceed with the effect.
        ; If set to 1, the effect will wait until it is set to 0 to activate.
        ; Kan: When nonzero, prevents medallion spell ancillae from being added.
        ; Flagged by medallion use routines to prevent multiple from being added.

    ; $0325[0x01] - (Junk)
    .Junk_0325: skip $01
        ; Almost free RAM but cleared by the medallion spells.

    ; $0326[0x02] - (Player)
    .PlayerMomentumY: skip $02
        ; Y momentum for ice/swimming. When a direction is released, these count
        ; down to 0.

    ; $0328[0x02] - (Player)
    .PlayerMomentumX: skip $02
        ; X momentum for ice/swimming. When a direction is released, these count
        ; down to 0.

    ; $032A[0x01] - (Player)
    .SwimStrokeTimerCount: skip $01
        ; Number of times the swim stroke timer has counted down (stops at 4).

    ; $032B[0x02] - (Player)
    .PlayerSwimY: skip $02
        ; Used to index Y accelaration for swim thrust changes. Max expected
        ; value is 0x0002.

    ; $032D[0x02] - (Player)
    .PlayerSwimX: skip $02
        ; Used to index X accelaration for swim thrust changes. Max expected
        ; value is 0x0002.

    ; $032F[0x02] - (Player)
    .PlayerSwimYAccReset: skip $02
        ; Flag checking swim Y accleration resets.

    ; $0331[0x02] - (Player)
    .PlayerSwimXAccReset: skip $02
        ; Flag checking swim Y accleration resets.

    ; $0333[0x01] - (Torch)
    .TorchTileType: skip $01
        ; Stores the tile type that the lantern fire or fire rod shot is
        ; currently interacting with.

    ; $0334[0x02] - (Player)
    .PlayerMaxSwimYAcc: skip $01
        ; The max Y accelaration when swimming.

    ; $0336[0x02] - (Player)
    .PlayerMaxSwimXAcc: skip $01
        ; The max X accelaration when swimming.

    ; $0338[0x02] - (Player, High Junk)
    .PlayerSwimYAccFlag: skip $02
        ; Seems to flag acceleration to have on the Y axis while swimming.
        ; The high byte is always written to as 00 and never read.

    ; $033A[0x02] - (Player, High Junk)
    .PlayerSwimXAccFlag: skip $02
        ; Seems to flag acceleration to have on the X axis while swimming.
        ; The high byte is always written to as 00 and never read.

    ; $033C[0x02] - (Player)
    .PlayerSwimYAcc: skip $02
        ; Y swim acceleration.

    ; $033E[0x02] - (Player)
    .PlayerSwimXAcc: skip $02
        ; X swim acceleration.

    ; $0340[0x01] - (Player)
    .PlayerSwimDir: skip $01
        ; Bitfield for swim direction:
        ; .... udlr
        ;   u - up
        ;   d - down
        ;   l - left
        ;   r - right

    ; $0341[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerSwimTileAct: skip $02
        ; Tile act bitfield used by water. The high byte is written to but never used.
        ; bbbb dddd
        ;   b - tile 0B Waterfall? TODO: Verify this.
        ;   d - deep water
        ; SEE TILE ACT NOTES.

    ; $0343[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerDiveTileAct: skip $02
        ; Tile act bitfield used by tile 0A and another nothing. Used to detect
        ; whether the player should jump in or out of water. The high byte is
        ; written to but never used.
        ; .... nnnn
        ; n - normal tile
        ; SEE TILE ACT NOTES.

    ; $0345[0x01] - (Player)
    .InDeepWater: skip $01
        ; Set to 1 when we are in deep water. 0 otherwise.

    ; $0346[0x02] - (Player, Palette)
    .PlayerPalette: skip $02
        ; Exclusively used in Bank 0x0D for the purposes of drawing Link. This
        ; value gets bitwise OR-ed in to supply the palette bits of Link's
        ; sprite. It's only intended to take on one of two values - 0x0E00, or
        ; 0x0000. 0x0E00 indicates that palette 7 is being used, and 0x0000
        ; indicates that palette 0 is being used. Sometimes Link's palette swaps
        ; so that Link won't turn translucent when color addition is active. An
        ; example of this would be in the Flute Boy's meadow when he disappears.
        ; See $0ABD for more info.

    ; $0348[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerIceTileAct: skip $02
        ; Bitfield for interaction with icy floor tiles. The high byte is
        ; written to but never used.
        ; jjjj iiii
        ; i - Ice palace icy tile 1
        ; j - Ganon's Tower icy tile 2
        ; SEE TILE ACT NOTES.

    ; $034A[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerIceWalking: skip $02
        ; Flag indicating whether Link is moving or not. (I think)
        ; Kan Appears to flag what type of ice floor Link is walking on.
        ; TODO: Confirm this. The high byte is written to but never used.

    ; $034C[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerWaterStairTileAct: skip $02
        ; Tile act bitfield for the top of water staircase tile interactions
        ; (overlay mask 1C). The high byte is written to but never used.
        ; ....ssss
        ; s - Water staircase
        ; SEE TILE ACT NOTES.

    ; $034E[0x01] - (Player)
    .PlayerSomariaDraw: skip $01
        ; TODO: Definitely related to Somaria platforms and how the player is
        ; displayed when on a Somaria platform.

    ; $034F[0x01] - (Player)
    .PlayerStroke: skip $01
        ; If nonzero, the player does the harder stroke while swimming. This is
        ; triggered by pressing the A, B, or Y buttons while swimming, but ends
        ; shortly. It has no bearing on his swimming speed, though.

    ; $0350[0x01] - (Junk)
    .Junk_0350: skip $01
        ; A possible debug variable that is written to in several places but
        ; never read from.

    ; $0351[0x01] - (Player, OAM)
    .PlayerShadowGFX: skip $01
        ; Controls the graphical effect around Link's feet:
        ;   0x00 - Regular shadow
        ;   0x01 - Water ripple
        ;   0x02 - Tall grass
        ;   Everything after 0x02 is also the water ripple.

    ; $0352[0x02] - (Player, OAM)
    .PlayerOAMOffset: skip $02
        ; Used exclusively during writing the player's OAM data (bank 0x0D) as an
        ; offset into the low OAM buffer ($0800).

    ; $0354[0x01] - (Player, OAM)
    .PlayerAuxAnimationIndex: skip $01
        ; Index of animation for the Player's auxiliary sprite objects.

    ; $0355[0x01] - (Player, OAM)
    .PlayerShadowAnimationStep: skip $01
        ; Secondary water / grass timer. Increments when $0356 reaches 9. Values
        ; range from 0 to 2, and gets set back to 0 when it reaches 3.

    ; $0356[0x01] - (Player, OAM)
    .PlayerShadowAnimationTimer: skip $01
        ; Primary water / grass timer. Valuess range from 0 to 8, and gets set
        ; back to 0 when it reaches 9.

    ; $0357[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerGrassWarpTileAct: skip $02
        ; Bitfield for interaction with thick grass / warp tiles. The high byte
        ; is written to but never used.
        ; wwww gggg
        ; g - bits are for thick grass tiles
        ; w - bits are for warp tiles (blue on OW, orange in dungeons)
        ; SEE TILE ACT NOTES.

    ; $0359[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerShallowWaterTileAct: skip $02
        ; Bitfield for interaction with shallow water tiles. The high byte is
        ; written to but never used.
        ; .... wwww
        ; w - Shallow water tiles
        ; SEE TILE ACT NOTES.

    ; $035B[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerDiggableTileAct: skip $02
        ; Bitfield for interaction with destruction aftermath tiles (bushes,
        ; rockpiles, etc). Kan: Tile act bitfield used by diggable ground.
        ; TODO: Confirm which is true. The high byte is written to but never used.
        ; .... aaaa
        ; a - aftermath tiles
        ; SEE TILE ACT NOTES.

    ; $035D[0x02] - (Player, OAM)
    .PlayerShadowProp: skip $02
        ; OAM properties of the player's shadow / water ripples / tall grass.

    ; $035F[0x01] - (Item)
    .BoomerangActive:
        ; A flag indicating the boomerang is active.

    ; $035F[0x01] - (Game Over)
    .GameOverText: skip $01
        ; Used by GAME OVER text for indexing.

    ; $0360[0x01] - (Player)
    .PlayerZapRecoil: skip $01
        ; A flag that, when nonzero, causes Link to be electrocuted when
        ; touching an enemy.

    ; $0361[0x01] - (Free RAM)
    .Free_0361: skip $01
        ; Free RAM.

    ; $0362[0x01] - (Player)
    .PlayerHopZSpeed1: skip $01
        ; Something to do with the player's Z speed while hopping off cliffs.
        ; TODO: Confirm this.

    ; $0363[0x01] - (Player)
    .PlayerHopZSpeed2: skip $01
        ; Something to do with the player's Z speed while hopping off cliffs.
        ; Often appears as the same value as PlayerHopZSpeed1 a lot but not
        ; always.
        ; TODO: Confirm this.

    ; $0364[0x02] - (Player)
    .PlayerHopZ: skip $02
        ; Acts as a Z-coordinate sort of when jumping ledges.

    ; $0366[0x02] - (Player, Tile Attribute, High Junk)
    .PlayerReadableTileAct: skip $02
        ; Flag stating that the player is about to read something (assuming
        ; they're facing north) Used with telepath tiles and signs. The high byte
        ; is written to but never used.
        ; Kan: Tile act bitfield used by liftables in some weird way??
        ; .... llll
        ; SEE TILE ACT NOTES
        ; TODO: Confirm which is correct.

    ; $0368[0x01] - (Player, Tile)
    .LiftedTypeRight: skip $01
        ; The value of $036A shifted right once (divided by two).
        ; Used in the context of lifting tiles like bushes, rocks, etc.
        ; 0x00 - sign
        ; 0x01 - small light rock
        ; 0x02 - green bush
        ; 0x03 - off-color bush
        ; 0x04 - small heavy rock
        ; 0x05 - large light rock
        ; 0x06 - large heavy rock
        ; TODO: Verify these values. See $03D37C

    ; $0369[0x01] - (Player, Tile)
    .Junk_0369: skip $01
        ; The value of $036A shifted left once (multiplied by two).
        ; Would be considered the "LiftedTypeLeft" but this is never actually
        ; read from.

    ; $036A[0x01] - (Player, Tile, High Junk)
    .LiftedType: skip $01
        ; When interacting with liftable tiles, this is an index that which type.
        ; Note: This value is always even, for whatever reason.
        ; 0x00 - sign
        ; 0x02 - small light rock
        ; 0x04 - green bush
        ; 0x06 - off-color bush
        ; 0x08 - small heavy rock
        ; 0x0A - large light rock
        ; 0x0C - large heavy rock

    ; $036B[0x01] - (Player, Death)
    .DeathSpin: skip $01
        ; Flags that the player is in the death spin animation.
        ; This is also set to 00 as the high byte of LiftedType. But this is
        ; never read as the high byte.

    ; $036C[0x01] - (Player)
    AActionIndex: skip $01
        ; Index for which action to perform when A is pressed. See $039C4F
        ; in Bank 0x07.
        ;   0x00 - Prayer (unused)
        ;   0x01 - Lift/Carry/Throw
        ;   0x02 - Dash
        ;   0x03 - Grab
        ;   0x04 - Read
        ;   0x05 - Open chest
        ;   0x06 - Drag statue
        ;   0x07 - Rupee pull (not actually set)

    ; $036D[0x01] - (Tile Attribute)
    .LedgeTileAct: skip $01
        ; Detection bitfield for vertical ledge tiles.
        ; dddd uuuu 
        ; d - bits are for ledge tiles facing down
        ; u - bits are for ledge tiles facing up
        ; SEE TILE ACT NOTES

    ; $036E[0x01] - (Tile Attribute)
    .DiagonalTileAct1: skip $01
        ; Detection bitfield for horizontal ledge tiles and up + horizontal
        ; ledge tiles.
        ; dddd hhhh
        ; h - Ledge tiles facing left or right
        ; d - Ledge tiles facing up + left or up + right
        ; SEE TILE ACT NOTES

    ; $036F[0x01] - (Tile Attribute)
    .DiagonalTileAct2: skip $01
        ; Detection bitfield for down + horizontal ledge tiles.
        ; .... dddd
        ; d - Ledge tiles facing down + left or down + right
        ; SEE TILE ACT NOTES

    ; $0370[0x01] - (Tile Attribute)
    .EPTileAct: skip $01
        ; Bitfield for interaction with unknown tile types. Kan: Tile act
        ; bitfield used by weird things in EP (Eastern Palace?).
        ; TODO: Confirm this.
        ; bbbb aaaa
        ; a - type 0x4C and 0x4D tiles (Overworld only)
        ; b - type 0x4E and 0x4F tiles (Overworld only)
        ; SEE TILE ACT NOTES

    ; $0371[0x01] - (Player)
    .PushAnimationTimer: skip $01
        ; Timer used to start and restart Link's pushing animation.

    ; $0372[0x01] - (Player)
    .IsDashing: skip $01
        ; A flag indicating whether the player is dashing.

    ; $0373[0x01] - (Player)
    .PlayerDamage: skip $01
        ; Putting a non zero value here indicates how much life to subtract from
        ; the player.
        ; 0x08 = one heart

    ; $0374[0x01] - (Player)
    .DashChargeTimer: skip $01
        ; Countdown timer for when the player is charging up for a dash.
        ; Starts as 0x1D, when this reaches 0, start the dash. 

    ; $0375[0x01] - (Player)
    .LedgeHopTimer: skip $01
        ; This is the timer that is used to count down how long it takes before
        ; the player can jump off a ledge. Starts at 0x13, though it doesn't
        ; appear to decrement every frame.

    ; $0376[0x01] - (Player)
    .PlayerGrabbing: skip $01
        ; .... ..sw
        ; s - grabbing statue
        ; w - grabbing wall

    ; $0377[0x01] - (Player)
    .PlayerGrabbingAnimation: skip $01
        ; The animation state of the player while grabbing. Used in the
        ; Master Sword ceremony.

    ; $0378[0x01] - (Player)
    .StairFaceTimer: skip $01
        ; A timer that runs while going on spiral staircases that controls
        ; when to change the player's facing direction.

    ; $0379[0x01] - (Player)
    .PreventAAction: skip $01
        ; If non-zero, this will prevent A button actions.

    ; $037A[0x01] - (Player, Item)
    .ItemUseFlag2: skip $01
        ; Bitfield for Y-item usage.
        ; See also: ItemUseFlag1
        ; ..bn ch.s
        ;   b - book
        ;   n - net
        ;   c - canes
        ;   h - hookshot
        ;   s - shovel

    ; $037B[0x01] - (Player)
    .PlayerInvulnerable: skip $01
        ; If nonzero, disables Link's ability to receive hits from
        ; sprites. (But not pits)

    ; $037C[0x01] - (Player, Free, Junk)
    .PlayerSleepModule: skip $01
        ; Submodule index for the player asleep in bed state at the beginning of
        ; the game (State 0x16). See LinkState_Sleeping for more details. This
        ; Could be used as Free RAM under the condition its not used while Link
        ; is asleep.

    ; $037D[0x01] - (Player)
    .PlayerSleepPose: skip $01
        ; Used to determine the player sprite's pose during the opening
        ; sequence. This value also affects the player's bedspread (unfurls the
        ; covers after hitting state 1).
        ; 0 - Player is in bed with eyes shut.
        ; 1 - Player is in bed with eyes open.
        ; 2 - Player is jumping out of bed.

    ; $037E[0x01] - (Player, Item, Hookshot)
    .HookshotDrag: skip $01
        ; Bitfield for hookshot drag stuff.
        ; .... ..ld
        ;   d - Hookshot drag in effect
        ;   l - Set when crossing a hop tile. Seems to flag which layer to read
        ;       from.

    ; $037F[0x01] - (Player, Cheat)
    .CheatWallsWarp: skip $01
        ; When nonzero, allow walk through walls and 2-way overworld warping.

    ; $0380[0x05] - (Ancilla)
    .AncillaMiscA: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots.

    ; $0385[0x0A] - (Ancilla)
    .AncillaMiscB: skip $0A
        ; A misc variable used by ancillas.

    ; $038F[0x05] - (Ancilla)
    .AncillaMiscC: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots. Only used by hammer hit stars and gravestones.

    ; $0394[0x05] - (Ancilla)
    .AncillaMiscD: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots. Often used as a timer.

    ; $0399[0x02] - (Item, Boomerang, Junk)
    .BoomerangWallSparkY: skip $02
        ; Used as a temporary copy of the boomerang's Y coordinate when
        ; calculating where to place the wall hit object that results from the
        ; boomerang hitting a wall. This could easily be moved to some temp work
        ; RAM rather than reserving a whole address for this.

    ; $039B[0x02] - (Item, Boomerang, Junk)
    .BoomerangWallSparkY: skip $02
        ; Used as a temporary copy of the boomerang's X coordinate when
        ; calculating where to place the wall hit object that results from the
        ; boomerang hitting a wall. This could easily be moved to some temp work
        ; RAM rather than reserving a whole address for this.

    ; $039D[0x01] - (Item, Hookshot)
    .HookshotIndex:
        ; The slot index of the hookshot ancilla in the ancilla table.

    ; $039D[0x01] - (Item, Boomerang)
    .BoomerangInitDirection:
        ; Stores the direction of the boomerang when it is initially thrown.
        ; TODO: Verify these directions
        ; .... uplr
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $039D[0x01] - (Game Over)
    .GameOverLetterFollowers: skip $01
        ; This is how many letters will be following the "leader" letter as the
        ; GAME OVER text slides across the screen. This is the G when moving left
        ; and then the R when moving right.

    ; $039E[0x01] - (Free)
    .Free_039E: skip $01
        ; Free RAM

    ; $039F[0x05] - (Ancilla)
    .AncillaMiscE: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots. Often used as a timer.

    ; $03A4[0x05] - (Ancilla)
    .AncillaMiscF: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots.

    ; $03A9[0x05] - (Ancilla)
    .AncillaMiscG: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots.

    ; $03AE[0x03] - (Free)
    .Free_03AE: skip $03
        ; Free RAM

    ; $03B1[0x05] - (Ancilla)
    .AncillaMiscH: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots. Often used as a timer.

    ; $03B6[0x04] - (Grave)
    .GraveOpenTargetHigh:
        ; The high byte of where the grave tile should be placed after its open.
        ; TODO: Total of 4 slots? Unsure.

    ; $03B6[0x04] - (Door, Ancilla)
    .BombDoorDebrisTargetX: skip $04
        ; 16-bit X value storing where the debris should draw. Total of 2 slots.

    ; $03BA[0x04] - (Grave)
    .GraveOpenTargetLow:
        ; The low byte of where the grave tile should be placed after its open.
        ; TODO: Total of 4 slots? Unsure.
        
    ; $03BA[0x04] - (Door, Ancilla)
    .BombDoorDebrisTargetY: skip $04
        ; 16-bit Y value storing where the debris should draw. Total of 2 slots.

    ; $03BE[0x02] - (Door, Ancilla)
    .BombDoorDebrisDir: skip $02
        ; Bomb door direction value, used to determine which was the debris
        ; should draw. Total of 2 slots.
        ; 0 - Up
        ; 1 - Down
        ; 2 - Left
        ; 3 - Right

    ; $03C0[0x02] - (Door, Ancilla)
    .BombDoorDebrisTimer: skip $02
        ; A timer used to keep track of how long bomb door rock debris
        ; ancillas draw.

    ; $03C2[0x0?] - (Ancilla)
    .AncillaMiscI:
        ; A misc variable used by ancillas.
        ; TODO: Verify the size of this var. Has several uses with X although its
        ; exact use is unclear. If it is more than 2, then it overlaps with some
        ; of the later vars.

    ; $03C2[0x02] - (Door, Ancilla)
    .BombDoorDebrisCounter: : skip $02
        ; A step counter used by the bomb door debris.

    ; $03C4[0x01] - (Ancilla)
    .AncillaSearch: skip $01
        ; Used to search through ancilla when every front slot is occupied.

    ; $03C5[0x05] - (Ancilla)
    .AncillaMiscJ: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots.

    ; $03CA[0x05] - (Ancilla)
    .AncillaMiscK: skip $05
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 5 slots. Mostly used as a pseudo bg selector.

    ; $03CF[0x06] - (Ancilla)
    .AncillaMiscL: skip $03
        ; A misc variable used by ancillas. Only intended to be used by the
        ; first 6 slots.

    ; $03D2[0x0?] - (Ancilla, Bomb)
    .BombWaterRippleAnimationStep:
        ; Used as an animation step counter for water ripples under bombs
        ; that are sitting in shallow water. Probably only intended to be
        ; used by the first 5 slots, but this overlaps with the next vars.
        ; TODO: Confirm.

    ; $03D5[0x06] - (Ancilla, Bomb, Somaria)
    .AncillaThrownOffEdge: skip $05
        ; A flag when nonzero causes liftable ancillas such as bombs and somaria
        ; blocks to transition to BG1 (meaning they were thrown off an edge).
        ; Only intended to be used by the first 6 slots.

    ; $03DB[0x06] - (Ancilla, Somaria, Junk)
    .SomariaOnButtonTiles: skip $06
        ; A count of how many button tiles a Somaria block is covering on
        ; the floor. This could easily be replaced by a temporary RAM value.

    ; $03E1[0x0?] - (Ancilla, Bomb)
    .BombWaterRippleAnimationTimer: skip $03
        ; Used as an animation timer for water riplles under bombs that
        ; ast sitting in shallow water. Probably only intended to be
        ; used by the first 5 slots, but this overlaps with the next vars.
        ; TODO: Confirm.

    ; $03E4[0x05] - (Ancilla)
    .AncillaTileInteraction: skip $05
        ; Used by the ancilla check tile collision function to store what
        ; tile the ancilla has interacted with. Only intended to be used by
        ; the first 5 slots.

    ; $03E9[0x01] - (Ancilla, Grave)
    .GraveActive: skip $01
        ; A flag when nonzero indicates that a gravestone is active.

    ; $03EA[0x05] - (Ancilla)
    .AncillaPreventLift: skip $05
        ; A flag when nonzero prevents ancillas from being picked up. This
        ; only really applies to ancillas that could be picked up in the
        ; first place like bombs and somaria blocks. Only intended to be
        ; used by the first 5 slots.

    ; $03EF[0x01] - (Player, OAM)
    .PlayerSwordUp: skip $01
        ; A flag when nonzero, forces Link to the pose where he is holding
        ; his sword up. One example of where this is used is right after
        ; Ganon is defeated.

    ; $03F0[0x01] - (Flute)
    .FluteTimer: skip $01
        ; Countdown timer for playing the flute. Prevents it from being played
        ; less than 0x80 frames apart.

    ; $03F1[0x01] - (Tile Attribute)
    .ConveyorTileActUpDown: skip $01
        ; Tile act bitfield used by up and down conveyor belts.
        ; dddd uuuu
        ;   u - upwards
        ;   d - downwards
        ; SEE TILE ACT NOTES

    ; $03F2[0x01] - (Conveyor, Tile Attribute)
    .ConveyorTileActRightLeft: skip $01
        ; Tile act bitfield used by left and right conveyor belts.
        ; rrrr llll
        ;   l - leftwards
        ;   r - rightwards
        ; SEE TILE ACT NOTES

    ; $03F3[0x01] - (Conveyor, Tile Attribute)
    .ConveyorType: skip $01
        ; The conveyor type the player is standing on if any.
        ;   0x00 - none
        ;   0x01 - up
        ;   0x02 - down
        ;   0x03 - left
        ;   0x04 - right

    ; $03F4[0x01] - (Item, Somaria)
    .SomariaLineCount: skip $01
        ; A count of all Somaria lines in the current room. This is used as
        ; a way to skip some logic while using the cane of Somaria in rooms
        ; with no lines to place a platform on.

    ; $03F5[0x02] - (Player)
    .PlayerBunnyTimer: skip $02
        ; The timer for the player's tempbunny state. When it reaches zero you
        ; returns to the normal Player state. When the player is hit, this timer
        ; is always reset to zero. This is always set to 0x100 when a yellow
        ; hunter (transformer) hits him. If the player is not in a normal mode,
        ; however, it will have no effect on him.

    ; $03F7[0x01] - (Player)
    .PlayerBunnyFlag: skip $01
        ; Flag when nonzero indicating the "poof" needs to occur for the player
        ; to transform to or from the tempbunny.

    ; $03F8[0x01] - (Player)
    .PlayerPullAndRoll:
        ; A flag when nonzero means you are near a PullForRupees or gargoyle
        ; grate sprite and can perform the pulling and rolling backwards action.

    ; $03F9[0x01] - (Player, Hookshot)
    .HookshotDragTimer: skip $01
        ; A timer that counts down from 4 to prevent toggling bit 1 of
        ; HookshotDrag. Used to preven the hookshot drag from triggering
        ; every frame.

    ; $03FA[0x02] - (Player, OAM)
    .SwordShiledExtraOAMX: skip $02
        ; The 9th bit of OAM X coordinate for drawing Link's sword and shield.
        ; Used to put the player's sword and sheild off-screen when you don't
        ; have the sheild or are not currently using your sword.

    ; $03FC[0x01] - (Item, Minigame)
    .SelectedYItemOverride: skip $01
        ; If nonzero, this value will override the player's currently selected
        ; Y-item for use in minigames such as the digging game or the arrow
        ; shooting game.
        ; 0x00 - Selected item
        ; 0x01 - Shovel
        ; 0x02 - Bow
        ; Everything else after 0x02 will be the shovel.

    ; $03FD[0x01] - (Travel Bird, Dungeon)
    .UsingTravelBirdInside: skip $01
        ; A flag when nonzero indicates that the travel bird is in use indoors,
        ; which under vanilla circumstances is only in Agahnim's second boss
        ; fight room.

    ; $03FE[0x02] - (Free)
    .Free_03FE: skip $02
        ; Free RAM.

    ; ===========================================================================
    ; Page 0x04
    ; ===========================================================================

    ; $0400[0x02] - (Dungeon, Low Junk)
    .UnlockedDoors: skip $02
        ; In the current room, each bit corresponds to a door being opened. If
        ; set, it has been opened by some means (bomb, key, etc.) The low byte
        ; is written to but unused.
        ; dddd .... .... ....
        ; d - Door

    ; $0402[0x01] - (Dungeon)
    .OpenDoors
        ; Doors opened (not necessarily unlocked) in a given room
        ; Not a very consistent reference.
        ; Definitely flags the TR eye door and some shutters

    ; $0403[0x01] - (Dungeon, Objects)
    .DunRoomInfo: skip $01
        ; Contains room information, such as whether the boss in this room
        ; has been defeated. Loaded on every room load according to map
        ; information that is stored as you play the game.
        ; bk54 3210
        ;   b - Boss kill / heart container / prevent damage
        ;   k - Key / heart piece / crystal
        ;       (unused for crystals, but prevents them from dropping)
        ;   5 - Chest 5 / 2nd key / heart piece
        ;   4 - Chest 4 / rupee floor / swamp drains / bombable floor / mire wall
        ;   3 - Chest 3 / pod or desert wall
        ;   2 - Chest 2
        ;   1 - Chest 1
        ;   0 - Chest 0

    ; $0404[0x01] - (Free)
    .Free_0404: skip $01
        ; Free RAM.

    ; $0405[0x01] - (Junk)
    .Junk_0405: skip $01
        ; Would be Free RAM becuase its never written to, but it is read
        ; once in bank 0x00.

    ; $0406[0x02] - (Free)
    .Free_0406: skip $02
        ; Free RAM.

    ; $0408[0x02] - (Dungeon)
    .VisitedQuad: skip $02
        ; Only low byte is used. This is a record of the quadrants that
        ; the player has visited in the current room.
        ; This is written back to SRAM when the player leaves the current
        ; room. Specifically, the lowest 4 bits are bitwise ORed back
        ; into the SRAM location for the room ($7EF000[0x280]).
        ; .... .... .... abcd
        ;   a - north west
        ;   b - north east
        ;   c - south west
        ;   d - south east

    ; $040A[0x02] - (Overworld)
    .OWAreaIndex2: skip $02
        ; Most of the time is a mirror of OWAreaIndex, however there are cases
        ; where they are not equal. Such as when exiting a special area and when
        ; exiting certain simple dungeon exits.

    ; $040C[0x02] - (Dungeon, High Junk)
    .DungeonIndex: skip $02
        ; Dungeon ID / Dungeon index multiplied by 2. If it's equal to 0xFF,
        ; that means there is no map, keys, boss, etc. for that section of the
        ; underworld. There is a data table of values that depend on the
        ; entrance you go in how this gets selected. The high byte is unused
        ; technically but is zeroed out and is read from.
        ; 0x00 - Sewer Passage
        ; 0x02 - Hyrule Castle
        ; 0x04 - Eastern Palace
        ; 0x06 - Desert Palace
        ; 0x08 - Hyrule Castle Tower (Agahnim 1)
        ; 0x0A - Swamp Palace
        ; 0x0C - Dark Palace
        ; 0x0E - Misery Mire
        ; 0x10 - Skull Woods
        ; 0x12 - Ice Palace
        ; 0x14 - Tower of Hera
        ; 0x16 - Gargoyle's Domain
        ; 0x18 - Turtle Rock
        ; 0x1A - Ganon's Tower
        ; 0xFF - Caves, Houses, and other inside areas that don't have an
        ;        assigned dungeon.

    ; $040E[0x01] - (Dungeon)
    .DungeonQuadrant: skip $01
        ; Contains the layout and starting quadrant info from dungeon header.

    ; $040F[0x01] - (Junk)
    .Junk_040F: skip $01
        ; Zeroed by a 16-bit write to DungeonQuadrant in one location.
        ; Otherwise, it could technically be considered Free RAM.

    ; $0410[0x02] - (Overworld, High Junk)
    .OWTransitionDir: skip $02
        ; Screen transition direction bitfield. When the overworld is
        ; transitioning, only one of the "udlr" bits will be set. The high byte
        ; is unused but written to.
        ; .... udlr
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $0412[0x01] - (GFX, Main, NMI)
    .VRAMIncramentalUploadStep: skip $01
        ; Index used during screen transitions to gradually, over the
        ; course of several frames, transmit data to VRAM.
        ; See variables VRAMIncramentalUpload and IncramentalUploadBufferLow

    ; $0413[0x01] - (Free)
    .Free_0413: skip $01
        ; Free RAM.

    ; $0414[0x02] - (Dungeon, High Junk)
    .DunBG2Properties: skip $02
        ; BG2 properties in Hyrule Magic. TODO: Make ZS. The high byte is unused but written to.
        ; Detailed description of MainScreenDes and SubScreenDes properties per type:
        ; Note that both parallax modes are the same from the register standpoint.
        ; 0 - "Off"           - Main:      BG2, BG3, Obj | Sub:     None | +/-: background
        ; 1 - "Parallaxing"   - Main:      BG2, BG3, Obj | Sub:      BG1 | +/-: background
        ; 2 - "Dark Room"     - Main:      BG2, BG3, Obj | Sub: BG1, BG1 | +/-: background
        ; 3 - "On top"        - Main: BG1, BG2, BG2, Obj | Sub:     None | +/-: background
        ; 4 - "Translucent"   - Main:      BG2, BG3, Obj | Sub:      BG1 | +/-: (1/2 +) back. BG1
        ; 5 - "Parallaxing 2" - Main:      BG2, BG3, Obj | Sub:      BG1 | +/-: background
        ; 6 - "Normal"        - Main:      BG2, BG3, Obj | Sub:      BG1 | +/-: background
        ; 7 - "Addition"      - Main:      BG2, BG3, Obj | Sub:      BG1 | +/-: (full +) back. BG1

    ; $0416[0x02] - (Overworld, High Junk)
    .OWTransitionDir2: skip $02
        ; Screen transition direction bitfield 2. When the overworld is
        ; transitioning screens, only one of the "udlr" bits will be set.
        ; TODO: The difference between this and OWTransitionDir appears
        ; to be that this one appears to be used while moving within a large
        ; area as well to update the tile map? Unsure. The high byte is
        ; unused but written to.
        ; .... udlr
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $0418[0x02] - (Dungeon, Overworld, High Junk)
    .TransitionDir: skip $02
        ; The direction of the current dungeon or overworld transition.
        ; For some reason, parity is flipped between overworld and underworld.
        ; The high byte is zeroed but not read.
        ;          Overworld   Underworld
        ;   0x00 - North       South
        ;   0x01 - South       North
        ;   0x02 - West        East
        ;   0x03 - East        West

    ; $041A[0x02] - (Dungeon)
    .MovingWallFlag: 
        ; When nonzero, idicates that a wall needs to move or is currently
        ; moving. The high byte is written to but unused.

    ; $041A[0x02] - (Dungeon, High Junk)
    .MovingFloor: skip $02
        ; The direction and state of a moving floor. The high byte is unused
        ; but written to.
        ; vvvvvvvv vvvvvvid
        ; v - If any of these bits are set, the floor movement will be vertical.
        ; i - Inverts the direction of the floor movement, specified by
        ;     FloorVelocityY and FloorVelocityX.
        ; d - Disable all movement.
        
    ; $041C[0x02] - (Dungeon)
    .SubPixelMovement: skip $02
        ; Sub-pixel movement for moving walls, moving floors, and moving
        ; water in dungeons.

    ; $041E[0x02] - (Dungeon)
    .MovingWallIndex: skip $02
        ; Used to saved an index value for moving walls.

    ; $0420[0x02] - (Junk)
    .Junk_0420: skip $02
        ; Zeroed on dungeon room load but never read.

    ; $0422[0x02] - (Dungeon)
    .FloorOffsetX: skip $02
        ; X offset of the moving floor, see FloorVelocityX. Also used to
        ; position the crystal maidens during the 3D sequence and to move
        ; Kholdstare's shell.

    ; $0424[0x02] - (Dungeon)
    .FloorOffsetY: skip $02
        ; Y offset of the moving floor, see FloorVelocityY. Also used to
        ; position the crystal maidens during the 3D sequence and to move
        ; Kholdstare's shell.

    ; $0426[0x02] - (Free)
    .Free_0426: skip $02
        ; Free RAM.

    ; $0428[0x02] - (Dungeon, High Junk)
    .FloorOffsetFlag: skip $02
        ; Equal to $AD most of the time but is manually changed by moving
        ; walls, Kholdstare, Trinexx, and the crystal maidens. When nonzero,
        ; this tells the game that the FloorOffsetX and FloorOffsetY should be
        ; applied. The high byte is written to but usused.

    ; $042A[0x02] - (Dungeon)
    .MovingWallTilemapAddr: skip $02
        ; Tilemap address of moving walls. Adjusted and written to
        ; ArbitraryTileMapAddress eventually.

    ; $042C[0x02] - (Dungeon, Objects)
    .ManipulableIndex: skip $02
        ; The manipulable objects index. This is for objects such as: moveable
        ; blocks, pots, other liftable objects, breakable floors, and moles.
        ; Collectively the limit for these types of objects is 16 per room.
        
        ; Another note from MoN that is interesting but should maybe be moved
        ; somewhere else:
        ; Notes about cracked floors: The breakable floor that is first in
        ; the object list is the the one that will open up. (Do ctrl-B on a
        ; cracked floor among others in hyrule magic if you don't believe me).
        ; Okay... so why does only one cracked floor open up? It doesn't make
        ; any sense right? The tile type is 62 for all cracked floors post load.

    ; $042E[0x02] - (Dungeon, Torch)
    .TorchLoadIndex: skip $01
        ; Used to index torches when building rooms (since blocks are
        ; loaded first this value gets updated after the fact.)

    ; $0430[0x02] - (Dungeon, Tag, High Junk)
    .PlayerOnToggleSwitch: skip $02
        ; A flag that is nonzero when the player is standing on a toggle
        ; floor switch. This is used to prevent the button from toggling
        ; repeatedly while the player is still standing on the button.
        ; The high byte is written to but usused.

    ; $0432[0x02] - (Dungeon, Object)
    .StarTileCount: skip $02
        ; The amount of start tiles in a room. Used to index star tile
        ; arrays when building rooms.

    ; $0434[0x02] - (Free)
    .Free_0436: skip $02
        ; Free RAM.

    ; $0436[0x02] - (Dungeon, Door)
    .EyeDoorFlag: skip $02
        ; Works as a flag for the eye door in turtle rock blocking your exit
        ; from the compass room. When non 0xFFFF, this indicates that there
        ; is an eye door present. The high byte is the index of the door in
        ; the room and the low byte is the direction the door is facing.

    ; TODO: There are some duplicate stair count names here, verify what
    ; they actually are with ZS.
    ; $0438[0x02] - (Dungeon, Stairs)
    .Stair2DCount: skip $02
        ; The number of in-floor inter-room up-north staircases (1.2.0x2D).

    ; $043A[0x02] - (Dungeon, Stairs)
    .Stair2E2FCount: skip $02
        ; The number of in-floor inter-room down-south staircases
        ; (1.2.0x2E, 1.2.0x2F).

    ; $043C[0x02] - (Dungeon, Stairs)
    .Stair30Count: skip $02
        ; The number of in-room up-north staircases (1.2.0x30).

    ; $043E[0x02] - (Dungeon, Stairs)
    .Stair31Count: skip $02
        ; The number of in-room up-north staircases (1.2.0x31).

    ; $0440[0x02] - (Dungeon, Stairs)
    .Stair32Count: skip $02
        ; The number of inter-pseudo-bg up-north staircases (1.2.0x32).

    ; $0442[0x02] - (Dungeon, Stairs)
    .Stair33Count: skip $02
        ; The number of in-room up-north staircases (1_2.0x33) (for use in water
        ; rooms).

    ; $0444[0x02] - (Dungeon, Stairs)
    .Stair35Count: skip $02
        ; The number of activated water ladders (1.2.0x35).

    ; $0446[0x02] - (Dungeon, Stairs)
    .Stair36Count: skip $02
        ; The number of water ladders (1.2.0x36).

    ; $0448[0x02] - (Dungeon, Stairs)
    .WaterStairCount: skip $02
        ; TODO: Investigate this further, here is my best guess for now:
        ; A combination of several of the stair counts above, used in the
        ; Swamp Palace when changing stairs from normal stairs to water ledge
        ; stairs.

        ; Here is the orignila MoN comment:
        ; This is tracking variable for dungeon objects with the catch that
        ; it is only used in rooms that have water objects (not 100% sure of
        ; this.) But it seems to be the activator that converts normal inter-bg
        ; type staircases to ones that let you jump into water, like in the
        ; Swamp Palace.

    ; $044A[0x02] - (Dungeon, High Junk)
    .LayerInteraction: skip $02
        ; Identifies the layer interaction behavior of a room. Such as 2 layers
        ; are considered "merged" or separate. TODO: High byte apears unused.
        ; 0x00 - TODO: These are the values I can see in the ROM but I need
        ; 0x01 - to see what they actually mean while testing.
        ; 0x02 - 

    ; $044C[0x02] - (Free)
    .Free_044C: skip $02
        ; Free RAM.

    ; $044E[0x02] - (Dungeon, Door)
    .ToggleDoorCount: skip $02
        ; The number of toggle doors times 2 that are in the current room.
        ; Also in array $06C0. This number shouldn't exceed 8. This is used to
        ; toggle all doors when a toggle switch is pressed.
        ; TODO: Verify what this door actually is with ZS.

    ; $0450[0x02] - (Dungeon, Door)
    .ToggleDungeonDoorCount: skip $02
        ; The number of "toggle dungeon" door properties times 2 that are in the
        ; current room. Also in array $06D0. This number shouldn't exceed 8.
        ; TODO: Verify what this door actually is with ZS.

    ; $0452[0x02] - (Dungeon, Door)
    .BlastWallLayoutChange: skip $02
        ; Flags that DunRoomLayout needs to change after activating a blast
        ; wall. Comments in bank 0x01 seem to imply that the low byte is for
        ; vertical blast walls and the high byte is for horizontal ones even
        ; though there are no horizontal walls in the game. However I'm not
        ; convinced as this byte is actually set within the ROM as well.
        ; TODO: Investigate further.

    ; $0454[0x02] - (Dungeon, Door)
    .BlastWallStep: skip $02
        ; Both a flag to indicate an exploding wall is active or should start
        ; exploding and a step counter to control which section of the wall
        ; needs to be exploded next.
        ; 0x00 - No exploding wall is active.
        ; 0x01 - Wall needs to start exploding.
        ; 0x03-0x13 - Increased by 2 every step, indicates a new section of the
        ;             wall needs to be removed.
        ; 0x15 - Wall is done exploding.

    ; $0456[0x02] - (Dungeon, Door, High Junk)
    .BlastWallIndex: skip $02
        ; The index of an exploding door in a room. Only set after it has
        ; started exploding. TODO: I'm pretty sure the high byte is junk
        ; as there can only be 0x10 doors in one room.

    ; $0458[0x02] - (Dungeon, High Junk)
    .HaveLampInDarkRoom: skip $02
        ; A flag when non-zero indicates you are both in a dark room and have
        ; the lantern. Used to tell the game when to orient the lamp outline
        ; on BG2 (TODO: BG2? BG1?) The high byte is always 0x00 but is read
        ; from in 16bit operations.
        ; 0 - You're in a dark room
        ; 1 - You're in a dark room and have the lantern

    ; $045A[0x02] - (Dungeon)
    .LitTorchCount: skip $02
        ; The number of torches that are lit in a room. Torch objects during
        ; load can be set to be permanently lit so this can affect how the
        ; room's lighting behaves. This is used to determine the light level
        ; in dark rooms. See RoomEffectFixedColors for the light levels. The
        ; high byte is set to 0 and always expected to be 0.
        ; 0x00 - 0 torches lit / fully dark.
        ; 0x01 - 1 torch lit.
        ; 0x02 - 2 torches lit
        ; 0x03 - 3 torches lit / fully bright.
        ; Every other value is fully bright.

    ; $045C[0x02] - (Dungeon)
    .DunQuadBuild: skip $01
        ; Used in increments of 0x04 to build quadrants. The high byte is
        ; set to 0 and always expected to be 0.

    ; $045E[0x02] - (Junk, Unused)
    .Junk_045E: skip $02
        ; This indexes a room object with an unreachable routine making
        ; it unused. It is set to 0 in a bunch of places.

    ; $0460[0x02] - (Dungeon, Door)
    .DoorIndex: skip $02
        ; Indexes doors while building rooms. TODO: Possibly not just while
        ; building.

    ; $0462[0x02] - (Dungeon, Stairs, High Junk)
    .DunStairType: skip $02
        ; Stores which staircase it is (0x30 to 0x37). This variable is
        ; usually only tested for the 3rd bit for whether the stairs are
        ; going up or down. The high byte is written to 0 but is never
        ; meaningfully read.
        ; .... .u..
        ; u - Stairs are going up.

    ; $0464[0x01] - (Dungeon, Stairs)
    .StairStepCounter: skip $01
        ; A step counter for climbing up or down stairs. This is used to control
        ; how long to ignore player input and what the light level of the room
        ; should be when going between rooms. Different starting values are
        ; used when using different stair types. TODO: Find these values.
        ; TODO: Confirm: The high byte appears to be unused.

    ; $0465[0x01] - (Free)
    .Free_0465: skip $01
        ; Free RAM.

    ; $0466[0x02] - (Dungeon, Door, Push Block, High Junk)
    .BlockCoveringSwitch: skip $02
        ; Used to indicate when a push block is on top of a switch. Flips the
        ; 0th bit of TrapDoorsDown as its value while on a switch.
        ; TODO: Confirm: But this is only set when on a switch? so will this
        ; value always be set?

    ; $0468[0x02] - (Dungeon, Door, High Junk)
    .TrapDoorsDown: skip $02
        ; A flag that when non zero means that the trap doors are down.

    ; $046A[0x02] - (Dungeon)
    .Floor1Draw: skip $02
        ; This is Floor 1 in Hyrule Magic. TODO: Change for ZS. The
        ; high byte is always 0 and is expected to be 0.

    ; $046[0x01]C - (Dungeon)
    .DubBG1Collision: skip $01
        ; "Collision" in Hyrule Magic. TODO: ZS-ify.
        ; TODO: Add all the valid types of collision here.

    ; $046D[0x03] - (Free)
    .Free_046D: skip $03
        ; Free RAM.

    ; $0470[0x02] - (Dungeon)
    .FloodStepCounter: skip $01
        ; Used for indexing the dam flood. Counts up from 0x0F to 0x40.

    ; $0472[0x02] - (Dungeon)
    .WaterGateTileMapAdd: skip $02
        ; This is the tilemap address of the watergate barrier, and it is
        ; only written to if the watergate is unopened. This is used to
        ; know where to place the gate opening animation tiles.

    ; $0474[0x02] - (Dungeon, Push Block, High Junk)
    .PushBlockDirection: skip $02
        ; The direction a push block has been pushed. The high byte is never
        ; written to and is expected to always be 0.

    ; $0476[0x01] - (Dungeon, Player)
    .SudoPlayerDunLayer: skip $01
        ; TODO: A different version of the player BG level. This is sometimes
        ; the same as PlayerDunLayer but not always. Appears in a lot of
        ; ancilla, stairs, and edge transition code. The exact use of this
        ; however needs to be investigated.
        ; After looking at StairsTargetLayer, this might actually be used as
        ; the target layer for where the player should end up when leaving
        ; stairs.

        ; MoN comment:
        ; Pseudo bg level. Indicates which "level" you are on, either BG1 or
        ; BG2. BG1 is considered 1 in many cases. However, there is no need for
        ; BG1 necessarily. When Link can interact with BG1, this value should
        ; match PlayerDunLayer, I think. This mostly applies to staircases in
        ; rooms that only use one BG to interact with.

    ; $0477[0x01] - (Free)
    .Free_0477: skip $01
        ; Free RAM.

    ; $0478[0x02] - (Dungeon, Object)
    .ManipulableCount: skip $02
        ; The number of manipulable objects in a room, x2. ManipulableIndex
        ; is copied here during dungeon room load and then not changed again.

    ; $047A[0x01] - (Overworld, Dungeon, Player)
    .LayerChangeNeeded: skip $01
        ; A flag that when non zero, indicates that a layer adjustment may
        ; be necessary for the player. This is induced by the player jumping
        ; off ledges. TODO: Check whether this is set even for ledges that
        ; do not need a layer change.

    ; $047B[0x01] - (Free)
    .Free_047B: skip $01
        ; Free RAM.

    ; $047C[0x02] - (Dungeon, Object)
    .WaterFaceTileAddr: skip $02
        ; Stores the tilemap address of an empty water face object so that
        ; it can be draw vomiting water later when a lever is flipped. Used
        ; in the Swamp Palace. TODO: Confirm this.

    ; TODO: There are some duplicate stair count names here, verify what
    ; they actually are with ZS.
    ; $047E[0x02] - (Dungeon, Stairs)
    .Stair38Count: skip $02
        ; The number of wall up-north spiral staircases (1.2.0x38).

    ; $0480[0x02] - (Dungeon, Stairs)
    .Stair39Count: skip $02
        ; The number of wall down-north spiral staircases (1.2.0x39).

    ; $0482[0x02] - (Dungeon, Stairs)
    .Stair3ACount: skip $02
        ; The number of wall up-north spiral staircases (1.2.0x3A).

    ; $0484[0x02] - (Dungeon, Stairs)
    .Stair3BCount: skip $02
        ; The number of wall down-north spiral staircases (1.2.0x3B).

    ; $0486[0x02] - (Overworld, Junk)
    .OWBombWallX: skip $02
        ; The X tilemap coordinate of bomb walls on the overworld. This is
        ; set by the bomb ancillas when cheching for a bomb wall which is
        ; then used to place the "opened" tiles. This is only used across
        ; one frame and could be easily switched to use work RAM.

    ; $0488[0x02] - (Overworld, Junk)
    .OWBombWallY: skip $02
        ; The Y tilemap coordinate of bomb walls on the overworld. This is
        ; set by the bomb ancillas when cheching for a bomb wall which is
        ; then used to place the "opened" tiles. This is only used across
        ; one frame and could be easily switched to use work RAM.

    ; $048A[0x01] - (Dungeon, Stairs)
    .TargetStairRoom: skip $01
        ; Gets the target room value from one of the staircase settings
        ; stored in $063D-$0640 based on the bottom 2 bits of DunStairType.

    ; $048B[0x01] - (Free)
    .Free_048B: skip $01
        ; Free RAM.

    ; $048C[0x02] - (Dungeon, Stairs)
    .StairTilemapAddr: skip $02 
        ; A tilemap position taken from $06B0 and shifted down by 0x08.
        ; TODO: The comment on $06B0 in kan's dissasm suggests that this
        ; is only for interroom stairs but this needs to be confirmed.

    ; $048E[0x02] - (Dungeon, Mirror)
    .DunRoomIndexMirror: skip $02
        ; This is a mirror of DunRoomIndex. TODO: This may not always
        ; match it though, double check.

    ; $0490[0x02] - (Dungeon)
    .Floor2Draw: skip $02
        ; This is Floor 2 in Hyrule Magic. TODO: Change for ZS. The
        ; high byte is always 0 and is expected to be 0.

    ; $0492[0x01] - (Dungeon, Stairs)
    .StairsTargetLayer: skip $01
        ; This is the layer target where the player should land after leaving
        ; certain stairs. TODO: SudoPlayerDunLayer Also affects this.
        ; 0x00 - The player will land on the higher level. 
        ; 0x02 - The player will land on the lower level.
        ; All other values are invalid.

    ; $0493[0x01] - (Free)
    .Free_0493: skip $01
        ; Free RAM.

    ; $0494[0x01] - (Overworld, Overlay)
    .RainAnimationTimer: skip $01
        ; A timer used to animate the overworld rain overlay. Counts up
        ; from 0x00 to 0x03.

    ; $0495[0x01] - (Free)
    .Free_0495: skip $01
        ; Free RAM.

    ; $0496[0x02] - (Dungeon, Object)
    .ChestCount: skip $02
        ; Used to track the number of chests in the current room x2. Because
        ; it indexes into an array of 16-bit values ($06E0), it is always
        ; twice the actual number of chests present.

    ; $0498[0x02] - (Dungeon, Object)
    .BigKeyLockCount: skip $02
        ; Used to track the number of big key lock blocks in the current room
        ; x2. It is equal to twice the number of chests plus twice the number
        ; of big key locks. This is due to the fact that it indexes into an
        ; array of 16-bit tilemap addresses ($06E0), and that this array of
        ; addresses is shared between chests and the big key locks.

    ; TODO: There are some duplicate stair count names here, verify what
    ; they actually are with ZS.
    ; $049A[0x02] - (Dungeon, Object)
    .Stair1BCount: skip $02
        ; The number of 1.3.0x1B inter room stairs objects.

    ; $049C[0x02] - (Dungeon, Object)
    .Stair1CCount: skip $02
        ; The number of 1.3.0x1C inter room stairs objects.

    ; $049E[0x02] - (Dungeon, Object)
    .Stair1DCount: skip $02
        ; The number of 1.3.0x1D inter room stairs objects.

    ; $04A0 - (Dungeon, HUD, High Junk)
    .FloorIndicatorTimer: skip $01
        ; A timer that when non zero, causes the floor indicator in dungeons
        ; to appear on the HUD. Is set to 0x01 and then counts up to 0xC0
        ; at which point is reset back to 0x00. The high byte is set to zero
        ; but never actually used.

    ; TODO: There are some duplicate stair count names here, verify what
    ; they actually are with ZS.
    ; $04A2[0x02] - (Dungeon, Object)
    .Stair26Count: skip $02
        ; number of in-wall inter-room up-north straight staircases
        ; (1.3.0x1E, 0x26).

    ; $04A4[0x02] - (Dungeon, Object)
    .Stair28Count: skip $02
        ; number of in-wall inter-room up-south straight staircases
        ; (1.3.0x20, 0x28).

    ; $04A6[0x02] - (Dungeon, Object)
    .Stair27Count: skip $02
        ; number of in-wall inter-room down-north straight staircases
        ; (1.3.0x1F, 0x27).

    ; $04A8[0x02] - (Dungeon, Object)
    .Stair29Count: skip $02
        ; number of in-wall inter-room down-south straight staircases
        ; (1.3.0x21, 0x29).

    ; $04AA[0x02] - (Dungeon, Game Over, High Junk)
    .LoadStartingPoint: skip $01
        ; Flag, that if nonzero, tells the game to load using a starting point
        ; entrance value rather than a normal entrance value. This is used when
        ; first loading up a save for example when you can spawn in link's
        ; house, the sanctuary, or the old man's cave. The high byte is never
        ; written to but is always expected to be 0.

    ; $04AC[0x02] - (Overworld, Tilemap)
    .OWModifiedTile16Count: skip $02
        ; When most tile16 are changed in a particular overworld screen
        ; this value is incremented by 2. Then $7EF800 and $7EFA00 are
        ; updated to contain the address of the modification and the tile16
        ; used to replace it. This only comes into play when a warp between
        ; the DW or the LW fails and you have to warp back. This prevents
        ; and infinite loop where you pick up a rock and try to warp where
        ; it was. If the warp failed, and the game sends you back to the
        ; LW you would spawn on top of the rock again and get stuck. See
        ; Overworld_RestoreFailedWarpMap16 in bank 0x02 for more details.

    ; TODO: There are some duplicate stair count names here, verify what
    ; they actually are with ZS.
    ; $04AE[0x02] - (Dungeon, Object)
    .Stair33Count: skip $02
        ; number of in-room up-south staircases (1.3.0x33) (for use in
        ; water rooms)

    ; $04B0[0x02] - (Dungeon, Object)
    .Stair35Count: skip $02
        ; Relates to object type 1.1.0x35. Which seem to be unused and buggy.
        ; If it were used, this would appear to be a tilemap address, with
        ; an extra bit at the top for unknown reasons. TODO: Find the reasons
        ; and what this object actually is in game.

    ; $04B2[0x02] - (Item, High Junk)
    .ShovelSpawnFlute: skip $02
        ; When non zero, makes using the shovel spawn the flute. This is only
        ; ever set to 0x0492 which is the tilemap position of where the flute
        ; is hidden. The high byte is written to but never read.

    ; $04B4[0x01] - (HUD)
    .HUDTimer: skip $01
        ; The super bomb and minigame HUD timer. When non zero, displays
        ; the timer on the HUD. Since 00 needs to be displayed on the timer
        ; as well, 0xFE and 0xFF are sometimes used as inactive instead.
        ; This depends on the use case but 0x00 is also written sometimes
        ; when there is an area reset or if a tagalong that is not the super
        ; bomb is present. See HUD_SuperBombIndicator for more details.
        ; 0x00 - Timer inactive: other tagalongs.
        ; 0x03 - Super bomb count down - 3 seconds.
        ; 0x1E - Digging guy minigame - 30 seconds.
        ; 0xFE - Timer inactive: super bomb.
        ; 0xFF - Timer inactive: super bomb, digging game.

    ; $04B5[0x01] - (HUD)
    .HUDTimerFrameCount: skip $01
        ; This is the amount of frames per one second of HUDTimer time. This
        ; is usually set to 0x3E which is 62 frames or to 0xBB during the first
        ; second of the super bomb timer. Meaning that the first "second" of
        ; the super bomb timer is actually pretty clsoe to 3 seconds of real
        ; time. TODO: Investigate: Does the SNES or alttp run at 62 FPS?
        ; 0xBB - Super bomb first second.
        ; 0x3E - Regular second.

    ; $04B6[0x02] - (Dungeon, Tilemap) 
    .ButtonTilemapPos: skip $02
        ; The tilemap position where a floor button/preassure plate tile
        ; was hit. 
        ; TODO: MoN comment but I see no evidence for: Also used with star tiles.

    ; $04B8[0x02] - (Door, Message, Tagalong, High Junk)
    .DoorMessageFlag: skip $01
        ; Flag that when non zero, indicates you are close to a big key door
        ; and the text message saying you don't have a key has already
        ; triggered. It resets when you move away from the door. Also used
        ; outdoors when a door tells you you can't enter with a tagalong
        ; following you. The high byte is written and read but it doesn't
        ; need to be.

    ; $04BA[0x02] - (Dungeon, Overlay, High Junk)
    .DunOverlayIndex: skip $02
        ; Index of the overlay (star tile holes, chest holes, etc.) to load
        ; in a dungeon room. See OverlayDataPointers for the possible overlays.
        ; Set by trapped chests and star tiles mostly. The high byte is set to
        ; zero and is always expected to be zero.

    ; $04BC[0x02] - (Dungeon, Overlay, High Junk)
    .StarTileState: skip $01
        ; This is the state of the star tile switch overlay. Toggles back and
        ; forth between 0x01 and 0x00. The high byte is set to zero but never
        ; read.

    ; $04BE[0x01] - (Sprite, Boss)
    .TrinexxFireHeadTimer: skip $01
        ; Countdown timer for the trinexx fire head palette transitioning.

    ; $04BF[0x01] - (Sprite, Boss)
    .TrinexxIceHeadTimer: skip $01
        ; Countdown timer for the trinexx ice head palette transitioning.

    ; $04C0[0x01] - (Sprite, Boss)
    .TrinexxFireHeadStep: skip $01
        ; The step counter for the trinexx fire head palette transitioning.

    ; $04C1[0x01] - (Sprite, Boss)
    .TrinexxIceHeadStep: skip $01
        ; The step counter for the trinexx ice head palette transitioning.

    ; $04C2[0x01] - (Dungeon, Item)
    .FallingItemTimer: skip $01
        ; Its only use is as a delay timer for falling crystals and pendants
        ; after a boss fight.
        
    ; $04C3[0x01] - (Free)
    .Free_04C3: skip $01
        ; Free RAM.

    ; $04C4[0x01] - (Minigame)
    .MinigameCredits: skip $01
        ; The number of credits left for opening minigame chests. 0xFF if
        ; entirely disabled.

    ; $04C5[0x01] - (Sprite, Boss)
    .GanonIntangibleState: skip $01
        ; State dealing with Ganon's fight. This reflects the number of
        ; torches are lit and is used to control ganon's transparency and
        ; whether or he can take damage.
        ; 0x02 - You can hit ganon, he is fuly opaque, both torches are lit.
        ; 0x01 - You cannot hit ganon, he's translucent, one torch is lit.
        ; 0x00 - You cannot hit ganon, he's invisible, no torches are lit.

    ; $04C6[0x01] - (Overworld, Entrance, Event)
    .OWSpecialAnimation: skip $01
        ; Trigger for special overworld animations.
        ; See Overworld_EntranceSequencefor more details.
        ; 0x00 - Nothing
        ; 0x01 - Dark Palace entrance opening
        ; 0x02 - Skull Woods entrance opening
        ; 0x03 - Misery Mire entrance opening
        ; 0x04 - Turtle Rock entrance opening
        ; 0x05 - Ganon's Tower entrance opening

    ; $04C7[0x01] - (Dungeon, Tag)
    .DunPreventTagAndStairs: skip $01
        ; When nonzero, prevents dungeon tags and stair checks from executing.
        ; This is immediately reset to zero after checking whether to run
        ; the tags and stair checks. Meaning this will only be set for one
        ; frame. This is set when entering dungeons to prevent the tag and
        ; stair code from running before the player has actually entered
        ; the room.

    ; $04C8[0x02] - (Dungeon, Event)
    .PegPuzzleCount: skip $02
        ; Only used in peg puzzles as an index of which or how many peg
        ; tiles have been hammered down.
        ; 
        ; In the case of the Light World Death Mountain peg puzzle,
        ; it's an index of how many successful steps have been complated,
        ; and is actually twice the number of pegs that have been
        ; hammered.
        ; 
        ; In the case of the Dark World peg puzzle near the ruined Smithy
        ; house, it's just the number of pegs hammered so far.

    ; $04CA[0x01] - (Player, HUD, SFX)
    .LifeBeepTimer: skip $01
        ; This timer controlls how long to wait between low life beeps.
        ; Counts down from 0x1F to 0x00. When it reaches zero, the beep happens.

    ; $04CB[0x25] - (Free)
    .Free_04CB: skip $25
        ; Free RAM.

    ; $04F0[0x10] - (Dungeon)
    .TorchTimer: skip $10
        ; Timers for torches. When lit, starts with a value of 0xC0 except
        ; in ganon's room where it starts at 0x80.

    ; ===========================================================================
    ; Page 0x05
    ; ===========================================================================

    ; $0500[0x40] - (Overworld, Tilemap)
    .OWTile16Buffer:
        ; Used in the overworld as a buffer for tile16 while drawing horizontal
        ; and vertical strips. Used in bank 0x02. Indexed by OWTMHScroll and
        ; OWTMVScroll. TODO: Confirm if is actually [0x40], I'm seeing
        ; confilicting info.

    ; $0500[0x20] - (Dungeon, Objects)
    .DunManipObjProp: skip $20
        ; Properties for manipulable objects. 2 bytes allotted for each. Used
        ; in banks 0x01 and 0x07. TODO: Confirm big gray rock quadrants. Also
        ; investigate the use case a bit more.
        ; 0x0000 - Nothing / stationary push block
        ; 0x0001 - Triggered push block
        ; 0x0002 - Moving push block
        ; 0x0003 - Done moving push block
        ; 0x0004 - Falling push block
        ; 0x0005 - Push block on switch
        ; 0x1010 - Pot requiring lift 2
        ; 0x1111 - Normal pot
        ; 0x1212 - Ugly pot
        ; 0x2020 - Big gray rock top left?
        ; 0x2121 - Big gray rock top right?
        ; 0x2222 - Big gray rock bottom left?
        ; 0x2323 - Big gray rock bottom right?
        ; 0x3030 - Bombable floor
        ; 0x3131 - Bombable floor
        ; 0x3232 - Bombable floor
        ; 0x3333 - Bombable floor
        ; 0x4040 - Hammer peg

    ; $0520[0x20] - (Dungeon, Objects)
    .DunManipObjROMOffset: skip $20
        ; Stores an object's offset in ROM data for certain manipulable objects.
        ; Stores the positions of pots, bombable floors, single moles, push
        ; blocks, and torches. However the positions are only ever read for
        ; push blocks and torches. These values are always taken from DunObjPtrOff
        ; in some form and then used to parse $7EF940 for push blocks and $7EFB40
        ; for torches. TODO: Determine if the game actually doesn't use the offsets
        ; stored for post, bombable floors, and single moles. I'm pretty sure it
        ; doesn't.

    ; $0540[0x20] - (Dungeon, Objects)
    .DunManipObjTMPos: skip $20
        ; Manipuable object's tilemap positions.

    ; $0560[0x20] - (Dungeon, Objects)
    .DunManipObjTLTile: skip $20
        ; Replacement top left 8x8 tile value for manipuable objects.

    ; $0580[0x20] - (Dungeon, Objects)
    .DunManipObjBLTile: skip $20
        ; Replacement bottom left 8x8 tile value manipuable objects.

    ; $05A0[0x20] - (Dungeon, Objects)
    .DunManipObjTRTile: skip $20
        ; Replacement top right 8x8 tile value manipuable objects.

    ; $05C0[0x20] - (Dungeon, Objects)
    .DunManipObjBRTile: skip $20
        ; Replacement bottom right 8x8 tile value manipuable objects. 

    ; TODO: Investigate. Each of these arrays appear to only use every other slot
    ; maybe as an old way to have high bytes in the same array but they are
    ; currently unused.
    ; $05E0[0x04] - (Push Blocks, Junk)
    .PushBlockXHigh: skip $04
        ; The high x coordinate of push blocks. 

    ; $05E4[0x04] - (Push Blocks, Junk)
    .PushBlockXLow: skip $04
        ; The low x coordinate of push blocks. 

    ; $05E8[0x04] - (Push Blocks, Junk)
    .PushBlockTargetDir: skip $04
        ; The target coordinate in direction of push blocks masked with 0x0F.

    ; $05EC[0x04] - (Push Blocks, Junk)
    .PushBlockYHigh: skip $04
        ; The high y coordinate of push blocks. 

    ; $05F0[0x04] - (Push Blocks, Junk)
    .PushBlockYLow: skip $04
        ; The low y coordinate of push blocks. 

    ; $05F4[0x04] - (Push Blocks, Junk)
    .Junk_05F4: skip $04
        ; Possibly a pushblock vestigial subpixel value? Written to but never read.

    ; $05F8[0x04] - (Push Blocks, Junk)
    .PushBlockDir: skip $04
        ; The direction a push block is moving.

    ; $05FC[0x02] - (Push Blocks)
    .PushBlockIndex: skip $02
        ; A two byte array. Each one contains the index of a push block. The
        ; value stored is the index of the object plus one, because a value of
        ; 0 means that a slot is empty. When comparisons are done, the value
        ; is read out and decremented by one before comparison.

    ; $05FE[0x02] - (Free)
    .Free_05FE: skip $02
        ; Free RAM.

    ; ===========================================================================
    ; Page 0x06
    ; ===========================================================================

    ; $0600[0x02] - (Overworld, Camera)
    .OWCamScrollBoundN:
        ; The northern camera scroll boundary for overworld areas.

    ; $0600[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundNSmall: skip $02
        ; The northern camera scroll boundary for small dungeon rooms.

    ; $0602[0x02] - (Overworld, Camera)
    .OWCamScrollVSize:
        ; The vertical boundary size of overworld areas. Instead of just
        ; storing the "south" boundary like in dungeons, this is an offset 
        ; from the north boundary.  

    ; $0602[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundNBig: skip $02
        ; The northern camera scroll boundary for big dungeon rooms.

    ; $0604[0x02] - (Overworld, Camera)
    .OWCamScrollBoundW:
        ; The western camera scroll boundary for overworld areas.

    ; $0604[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundSSmall: skip $02
        ; The southern camera scroll boundary for small dungeon rooms.

    ; $0606[0x02] - (Overworld, Camera)
    .OWCamScrollHSize:
        ; The horizontal boundary size of overworld areas. Instead of just
        ; storing the "east" boundary like in dungeons, this is an offset
        ; from the north boundary.  

    ; $0606[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundSBig: skip $02
        ; The southern camera scroll boundary for big dungeon rooms.

    ; $0608[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundWSmall: skip $02
        ; The western camera scroll boundary for small dungeon rooms.

    ; $060A[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundWBig: skip $02
        ; The western camera scroll boundary for big dungeon rooms.
        ; TODO: The low byte is never read?

    ; $060C[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundESmall: skip $02
        ; The eastern camera scroll boundary for small dungeon rooms.
        ; TODO: The low byte is never read?

    ; $060E[0x02] - (Dungeon, Camera)
    .DunCamScrollBoundEBig: skip $02
        ; The eastern camera scroll boundary for big dungeon rooms.
        ; TODO: The low byte is never read?

    ; $0610[0x02] - (Dungeon, Overworld, Camera)
    .CamTargetNorth: skip $02
        ; The position that the camera will move to when transitioning north
        ; both on the overworld and in dungeons.

    ; $0612[0x02] - (Dungeon, Overworld, Camera)
    .CamTargetSouth: skip $02
        ; The position that the camera will move to when transitioning south
        ; both on the overworld and in dungeons.

    ; $0614[0x02] - (Dungeon, Overworld, Camera)
    .CamTargetWest: skip $02
        ; The position that the camera will move to when transitioning west
        ; both on the overworld and in dungeons.

    ; $0616[0x02] - (Dungeon, Overworld, Camera)
    .CamTargetEast: skip $02
        ; The position that the camera will move to when transitioning east
        ; both on the overworld and in dungeons.

    ; $0618[0x02] - (Dungeon, Overworld, Camera)
    .CamScrollTriggerN: skip $02
        ; The north boundary trigger for camera scrolling. This value is
        ; compared with the player's coordinates to determine whether to
        ; trigger a northern scroll transition both on the overworld and
        ; in dungeons.

    ; $061A[0x02] - (Dungeon, Overworld, Camera)
    .CamScrollTriggerS: skip $02
        ; The south boundary trigger for camera scrolling. This value is
        ; compared with the player's coordinates to determine whether to
        ; trigger a southern scroll transition both on the overworld and
        ; in dungeons.

    ; $061C[0x02] - (Dungeon, Overworld, Camera)
    .CamScrollTriggerW: skip $02
        ; The west boundary trigger for camera scrolling. This value is
        ; compared with the player's coordinates to determine whether to
        ; trigger a western scroll transition both on the overworld and
        ; in dungeons.

    ; $061E[0x02] - (Dungeon, Overworld, Camera)
    .CamScrollTriggerE: skip $02
        ; The east boundary trigger for camera scrolling. This value is
        ; compared with the player's coordinates to determine whether to
        ; trigger an eastern scroll transition both on the overworld and
        ; in dungeons.

    ; TODO: A note from Kan in relation to the 4 variables above that I don't
    ; understand:
    ; "The higher boundary should always be +2 from the lower in underworld
    ; and -2 in overworld."

    ; Ending Sequence Variables:

    ; $0620[0x02] - (Dungeon, Overworld, Camera)
    .OverlaySubPixelX: skip $02
        ; According to Kan "[This] behaves as a subpixel for background 1 overlay
        ; scroll on overworld". However, after looking at its use this doesn't to
        ; ever actually be read in a meaningful way. It is read so that values
        ; can be added to it but then is never compared or stored to any other
        ; value. TODO: Confirm that this is never actually meaningfully used.

    ; $0622[0x02] - (Dungeon, Overworld, Camera)
    .OverlaySubPixelY: skip $02
        ; According to Kan "[This] behaves as a subpixel for background 1 overlay
        ; scroll on overworld". However, after looking at its use this doesn't to
        ; ever actually be read in a meaningful way. It is read so that values
        ; can be added to it but then is never compared or stored to any other
        ; value. TODO: Confirm that this is never actually meaningfully used.

    ; $0624[0x02] - (Overworld, Camrea, Credits)
    .OWCamOffsetY: skip $02
        ; UnderworldExitData_scroll_mod_y,
        ; Pool_BirdTravel_LoadTargetAreaData_scroll_mod_y, OWTransitionDir2
        ; TODO: Look at what ZS saves to the bird and exit data listed above.
        ; My current guess is that this is an offset applied to the camera when
        ; exiting or using bird travel. This is used to determine where to update
        ; the tilemap while moving around on the OW. Also has a credits use in
        ; bank 0x0E but it could be the same function.

    ; $0626[0x02] - (Overworld, Camrea)
    .OWCamOffsetYInverse: skip $02
        ; The the additive inverse of OWCamOffsetY.

    ; $0628[0x02] - (Overworld, Camrea)
    .OWCamOffsetX: skip $02
        ; UnderworldExitData_scroll_mod_x,
        ; Pool_BirdTravel_LoadTargetAreaData_scroll_mod_x, OWTransitionDir2
        ; TODO: Look at what ZS saves to the bird and exit data listed above.
        ; My current guess is that this is an offset applied to the camera when
        ; exiting or using bird travel. This is used to determine where to update
        ; the tilemap while moving around on the OW.

    ; $062A[0x02] - (Overworld, Camrea)
    .OWCamOffsetXInverse: skip $02
        ; The the additive inverse of OWCamOffsetX.

    ; $062C[0x02] - (Dungeon, Objects)
    .DunBG2HHighPos: skip $02
        ; In loading dungeons, sometimes contains the upper even byte of BG2HPos.
        ; This is used for some sort of effect relating to water object, bomb
        ; doors, explosion doors, and the water gate. TODO: Figure out exact uses.

    ; $062E[0x02] - (Dungeon, Objects)
    .DunBG2VHighPos: skip $02
        ; In loading dungeons, contains the upper even byte of BG2VPos. 
        ; This is used for some sort of effect relating to water object, bomb
        ; doors, explosion doors, and the water gate. TODO: Figure out exact uses.
        ; Note: The upper even byte refers to the operation (argument & 0xFE00).

    ; $0630[0x02] - (IRQ)
    .BG3HScrollIRQ: skip $02
        ; Writes to SNES.BG3HScrollOffset or the BG3 Hscroll Register during 
        ; V-IRQ. Used exclusivly during the save file naming/erasing routines.
        ; Kan's dissasembly claims this is used during the credits routine but
        ; I don't see any evidence of this.

    ; $0632[0x03] - (Free)
    .Free_0632: skip $03
        ; Free RAM.

    ; $0635[0x01] - (Overworld Map, Junk)
    .Junk_0635: skip $01
        ; Written to twice in bank 0x0A, but seems to never be read or used
        ; for anything. Perhaps this was part of an unimplemented additional
        ; feature of the overworld map.

    ; $0636[0x01] - (Overworld Map)
    .OWMapZoomToggle: skip $01
        ; Bit layout:
        ; t... ...s
        ; s - Selects between HDMA table low byte A bus addresses for the
        ;     HDMA table responsible for mode 7 manipulation.
        ; t - Set in order to indicate that the zoom mode needs to be
        ;     toggled. It will be unset once the toggling is completed.

    ; $0637[0x01] - (Overworld Map)
    .OWMapZoomModifier:
        ; While it appears to be set in a manner that is consistent with the
        ; Attract Mode usage of this same variable, it is not actually used at
        ; all in this submodule of the messaging module.

    ; $0637[0x01] - (Attract)
    .AttractZoomTimer: skip $01
        ; Timer for the Mode 7 zoom in sequence. Affects the zoom level
        ; indirectly by serving as the value that a table of values gets
        ; multiplied by to produce an HDMA table.

    ; $0638[0x02] - (Overworld Map, Attract)
    .Mode7CenterPosX: skip $02
        ; Mode 7 Center X Position register. Writes to SNES.Mode7CenterPosX
        ; during NMI.

    ; $063A[0x02] - (Overworld Map, Attract)
    .Mode7CenterPosY: skip $02
        ; Mode 7 Center Y Position register. Writes to SNES.Mode7CenterPosY
        ; during NMI.

    ; $063C[0x01] - (Dungeon)
    .DunHoleTargetLayer: skip $01
        ; Hole / Teleporter target layer.

    ; $063D[0x01] - (Dungeon)
    .DunStair1TargetLayer: skip $01
        ; Staircase 1 target layer.

    ; $063E[0x01] - (Dungeon)
    .DunStair2TargetLayer: skip $01
        ; Staircase 2 target layer.

    ; $063F[0x01] - (Dungeon)
    .DunStair3TargetLayer: skip $01
        ; Staircase 3 / door target layer.

    ; $0640[0x01] - (Dungeon)
    .DunStair4TargetLayer: skip $01
        ; Staircase 4 / door target layer.

    ; $0641[0x01] - (Dungeon, Push Block, Tag)
    .PushBlockPushed: skip $01
        ; A flag that when nonzero indicates a block has been pushed. Used to check
        ; if we need to open some doors or make a chest appear based on the room
        ; tags.

    ; $0642[0x01] - (Dungeon, Tag)
    .SpriteActivateTag: skip $01
        ; A flag that when nonzero indicates that one of several sprites has been
        ; triggered and a tag needs to activate. Used by push and pull switches,
        ; arrow targets, and moveable statues.

    ; $0643[0x03] -  (Free)
    .Free_0643: skip $03
        ; Free RAM.

    ; $0646[0x01] - (Dungeon, Tag, Item)
    .SomariaPressingSwitch: skip $01
        ; A flag that when nonzero indicates that a cane of Somaria block is
        ; on top of a switch that needs to be weighed down.

    ; $0647[0x01] - (Player) 
    .ElectrocutionMosaic: skip $01
        ; Used as a flag exclusively with electrocution mosaic logic.
        ; 0x00    - Mosaic increases each frame.
        ; Nonzero - Mosaic decreases each frame.

    ; $0648[0x28] - (Free)
    .Free_0648: skip $28
        ; Free RAM.

    ; $0670[0x02] - (HDMA)
    .HDMALeftBase:
        ; Used as the left base for the spotlight HDMA effect used when
        ; entering/exiting a dungeon and praying at the Desert Palace. This
        ; is also used during the dungeon water flowing HDMA effect.
        
    ; $0672[0x02] - (Free)
    .Free_0672: skip $02
        ; Free RAM.

    ; $0674[0x02] - (HDMA)
    .HDMATopBase: skip $02
        ; Used as the top base for the spotlight HDMA effect used when
        ; entering/exiting a dungeon and praying at the Desert Palace. This
        ; is also used during the dungeon water flowing HDMA effect.
        ; TODO: Confirm use.
    
    ; $0676[0x02] - (HDMA)
    .HDMABottomBase: skip $02
        ; Used as the bottom base for the spotlight HDMA effect used when
        ; entering/exiting a dungeon and praying at the Desert Palace. This
        ; is also used as the starting positions of the water gate.
        ; TODO: Confirm use.
    
    ; $0678[0x02] - (HDMA)
    .HDMATimerV: skip $02
        ; Starts at the Y position of the water gate and is then decremented down
        ; until it hits 0x0000 after the gate opens. It is then stored into
        ; HDMABottomBase to control where the HDMA stops on the bottom.
    
    ; $067A[0x02] - (HDMA)
    .IrisDividend: skip $02
        ; A dividend of some sort. Used to determine how wide/tall the spotlight
        ; is while opening/closing. TODO: Confirm.
    
    ; $067C[0x02] - (HDMA)
    .IrisDivisor: skip $02
        ; A divisor of some sort. Used to determine how wide/tall the spotlight
        ; is while opening/closing. TODO: Confirm.
    
    ; $067E[0x02] - (HDMA)
    .IrisType: skip $02
        ; A flag that indicates whether the spotlight HDMA is opening or closing.
        ; 0x00    - The spotlight is closing.
        ; nonzero - The spotlight is opening.

    ; $0680[0x02] - (Dungeon, HDMA)
    .WaterGateLeftHDMA: skip $02
        ; The water gate HDMA left boundary. TODO: Confirm use.

    ; $0682[0x02] - (Dungeon, HDMA)
    .WaterGateTopHDMA: skip $02
        ; The water gate HDMA top boundary. TODO: Confirm use.

    ; $0684[0x02] - (Dungeon, HDMA)
    .WaterGateVSizeHDMA: : skip $02
        ; The vertical size for the water gate HDMA. TODO: Confirm use.

    ; $0686[0x02] - (Dungeon, HDMA)
    .WaterGateHSizeHDMA: : skip $02
        ; The horizontal size for the water gate HDMA. TODO: Confirm use.

    ; $0688[0x02] - (Dungeon, HDMA)
    .WaterGateMaxHSizeHDMA: : skip $02
        ; The max horizontal size for the water gate HDMA. TODO: Confirm use.

    ; $068A[0x02] - (Dungeon, HDMA)
    .WaterGateMaxVSizeHDMA: : skip $02
        ; The max vertical size for the water gate HDMA. TODO: Confirm use.

    ; $068C[0x02] - (Dungeon, Door)
    .DoorsOpen: skip $02
        ; Stores which doors are open during transitions. Probably used to draw
        ; doors in the correct state while transitioning. Interacts with
        ; DungeonMask a lot and I'm not sure why. TODO: Confirm this is the 
        ; correct use. MoN comment:
        ; Top 4 bits hold information about which doors have been opened.
        ; Update: Or are currently open? Man, what a miserable system!

    ; $068E[0x02] - (Dungeon, Door)
    .DunDoorTileMapPos: skip $02
        ; The tilemap position of the current door.

    ; $0690[0x02] - (Overworld, Door)
    .OWDoorTimer:
        ; Generally is used as an animation step indicator, only for doors that
        ; animate when they open, such as the Santuary and Hyrule Castle doors
        ; This variable is incremented up to a value of 3, at which point a logic
        ; check kicks in and stops animating the opening of a door.

    ; $0690[0x02] - (Dungeon, Door)
    .DunDoorTimer: skip $02
        ; Similarly to the overworld version of this variable, it's used in the
        ; animation of doors opening. However, it's also used for doors closing,
        ; and in particular the types of doors we're talking about are the trap
        ; doors that look like nasty skull faces. Values range from 0 (closed) to
        ; 7 (open).

    ; $0692[0x02] - (Overworld, Tile32)
    .OWNewTile32:
        ; Contains the index of a new tile32 to place on the map. This is used
        ; by things like graves when they are moved, and the DW smithy house
        ; peg puzzle.

    ; $0692[0x02] - (Dungeon, Door)
    .DunDoorAni: skip $02
        ; The animation state of a door opening or closing.
        ; 0x00 - Fully open
        ; 0x02 - Half open
        ; 0x04 - Fully shut

    ; $0694[0x02] - (Dungeon, Door)
    .DoorTypeCache: skip $02
        ; A temporary cache of the current door type.

    ; $0696[0x02] - (Overworld, Door, Tilemap)
    .OWDoorTileMapPos: skip $02
        ; When using an entrance or exit on the overworld, this is the tilemap
        ; location of where the opening animation tiles need to be placed i.e. a
        ; wooden door opening or the sanctuary and hyrule castle doors opening.
        ; This has a secondary use of dertimining certain aspects of the entrance =
        ; for example 0xFFFF indicates the north facing entrance in kakariko
        ; village. Values < 0x8000 indicate tilemap coordinates for a wooden
        ; doorway and values >= 0x8000 indicate a bombable wall hole.
        ; 0x0000           - No doorway
        ; 0x0001 to 0x7FFF - Wooden doorway
        ; 0x8000 to 0xFFFE - Bombable doorway
        ; 0xFFFF           - North facing doorway

    ; $0698[0x02] - (Overworld, Tilemap)
    .OWPlaceTile32TileMapPos: skip $02
        ; Tilemap location of new tile32 that are being placed such as from
        ; graves, dash rock piles, weathervane and sometimes entrances.
        ; TODO: Investigate when it is used by entrances. It appears to have one
        ; special case and then when exiting/entering but that is different from
        ; OWDoorTileMapPos.

    ; $069A[0x01] - (Overworld)
    .PlayerExitTimer: skip $01
        ; Countdown timer for certain overworld transitions, during which the
        ; player sprite will continue to move. These transitions include coming
        ; out of doors from the indoor areas, as well as transitions between the
        ; normal overworld and special overworld areas.
        ; 0x10 - When exiting a dungeon.
        ; 0x0C - When leaving a special overworld.
        ; 0x24 - When exiting a dungeon with a big door.
        ; TODO: 0x0C also possibly includes when coming from an area with a mosaic.

    ; $069B[0x01] - (Free)
    .Free_069B: skip $01
        ; Free RAM.

    ; $069C[0x02] - (Overworld, High Junk)
    .SpecialTransitionDir: skip $02
        ; Appears to be an Overworld specific version of TransitionDir but
        ; this one is not changed while loading and is only used when coming out
        ; of special areas TODO: and possibly when leaving mosaic areas. It is
        ; possible that you could just replace this with TransitionDir. The
        ; high byte is written to but never read.

    ; $069E[0x01] - (Overworld, Tilemap, Sprite)
    .BG1VScrollRelativeBG2Off: 
        ; TODO: This needs to be confirmed, but my best guess right now is that
        ; this is an offset used to change the vertical position of BG1 relative
        ; to the BG2 position. This is used by subscreen overlays, credits and
        ; certain sprites.

    ; $069F[0x01] - (Overworld, Tilemap, Sprite)
    .BG1HScrollRelativeBG2Off: 
        ; TODO: This needs to be confirmed, but my best guess right now is that
        ; this is an offset used to change the horizontal position of BG1 relative
        ; to the BG2 position. This is used by subscreen overlays, credits and
        ; certain sprites.

    ; $06A0[0x0?] - (Dungeon, Object)
    .StarTileTilemapAddr: 
        ; This array stores the tilemap addresses of star tiles. The size of this
        ; array is whatever StarTileCount is, which appears to not have a limit.
        ; TODO: Does this mean if we kept adding star tiles that we would
        ; eventually write into space we aren't supposed to? TODO: Test if there
        ; is a max array size.

    ; TODO: I'll have to open an emulator and watch what these HDMA vars actually
    ; do to document them further.

    ; $06A0[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06A2: skip $02
        ; Magic mirror module variable that toggles between 0x00 and 0x02. Used
        ; to index $06A2 and $06A6. TODO: Update name.

    ; $06A2[0x04] - (Overworld, Warp, HDMA)
    .WarpIndex06A4: skip $02
        ; Mirror warp HDMA related. Can be stored into $06AC under certain
        ; conditions. TODO: Update name.
        ; $06A2: Init: 0xFE00 Wave: 0xFF00
        ; $06A4: Init: 0x0200 Wave: 0x0100

    ; $06A6[0x04] - (Overworld, Warp, HDMA)
    .WarpIndex06A6: skip $02
        ; Mirror HDMA related. Can be stored into $06AC under certain conditions.
        ; Only set once during mirror init. Could be a ROM table instead.
        ; TODO: Update name.
        ; $06A6: Init: 0xFFC0
        ; $06A8: Init: 0x0040

    ; $06AA[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06AA: skip $02
        ; Mirror warp HDMA related. After some math, stored into $1B00, $1B04,
        ; $1B08, and $1B0C. This appears to be the only meaningful var. The rest
        ; are only keeping track of steps and sizes of the HDMA? TODO: Update name.
        ; $06AA: Init: 0x0000

    ; $06AC[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06AC: skip $02
        ; Mirror warp HDMA related. Either has $06A6 added to it or takes the
        ; value from $06A2 based on certain conditions. TODO: Update name.
        ; Init: 0x0000

    ; $06AE[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06AE: skip $02
        ; Mirror warp HDMA related. Adds $06AC to itself and then cuts out the high
        ; byte. TODO: Update name.
        ; Init: 0x0000

    ; $06B0[0x0?] - (Stair, Tilemap, Dungeon)
    .InterStairSlots: skip $02
        ; Tilemap positions of interroom stairs. The size of the array depends
        ; on Stair2E2FCount. TODO: Test if there is a max array size.
        ; 1.2.0x2D, 1.2.0x2E, 1.2.0x2F, 1.2.0x38, 1.2.0x39, 1.2.0x3A, 1.2.0x3B
        ; 1.3.0x1E, 1.3.0x1F, 1.3.0x20, 1.3.0x21, 1.3.0x26, 1.3.0x27, 1.3.0x28
        ; 1.3.0x29 TODO: Find the actual name for these.

    ; $06B2[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06B2: skip $02
        ; Mirror warp HDMA related. May just be junk, its initialized to 0x0015 but
        ; then doesn't appear to be used.

    ; $06B4[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06B4: skip $02
        ; Mirror warp HDMA related. May just be junk, its initialized to 0x0008 but
        ; then doesn't appear to be used.

    ; $06B6[0x02] - (Overworld, Warp, HDMA)
    .WarpIndex06B6: skip $02
        ; Mirror warp HDMA related. May just be junk, its initialized to 0x0008 but
        ; then doesn't appear to be used.

    ; $06B8[0x0?] - (Stair, Tilemap, Dungeon)
    .IntraStairSlots: skip $02
        ; Tilemap positions of intraroom stairs: The size of the array depends
        ; on Stair36Count. TODO: Test if there is a max array size.
        ; Ancilla slots for type 1.2.0x30, 1.2.0x31, 1.2.0x32, 1.2.0x33, 1.2.0x35,
        ; 1.2.0x36, 1.3.0x1B TODO: Find the actual name for these.

    ; $06BA[0x01] - (Warp)
    .WarpTimer1: skip $01
        ; A timer that is used to load overworld data when being warped away from
        ; Agahnim 1. It starts at 0x00 and is incremented to 0x20.

    ; $06BB[0x01] - (Warp)
    .WarpTimer2: skip $03
        ; A timer that is used to control some warp animations. It can start at
        ; 0x08, 0x02, and 0x20 and is decremented to 0x20.

    ; $06BE[0x02] - (Junk)
    .Junk_06BE: skip $02
        ; Zeroed out once in bank 0x0E, seems to be junk but this overlaps with
        ; IntraStairSlots. So this should not be used for hacking.

    ; $06C0[0x0?] - (Dungeon)
    .FoorToggleTilemapPos: skip $0E
        ; Slots for floor toggle door properties (type 0x16 "doors").
        ; These are not actually doors, but rather the coordinates where
        ; the floor toggle property should be applied to actual doors.
        ; The size of this array is determined by $044E. TODO: Find the actual
        ; name for this door. TODO: Test if there is a max array size.

    ; $06CE[0x02] - (Junk)
    .Junk_06CE: skip $02
        ; Zeroed out once in bank 0x0E, seems to be junk but this overlaps with
        ; FoorToggleTilemapPos. So this should not be used for hacking.

    ; $06D0[0x0?] - (Door, Dungeon)
    .DunToggleTilemapPos: skip $0E
        ; Slots for dungeon toggle door properties (type 0x14 "doors").
        ; These are not actually doors, but rather the coordinates where
        ; the dungeon toggle property should be applied to actual doors.
        ; The number of populated slots in this array is determined by
        ; $0450. TODO: Test if there is a max array size. TODO: Find the actual
        ; name for this door.

    ; $06DE[0x02] - (Junk)
    .Junk_06DE: skip $02
        ; Zeroed out once in bank 0x0E, seems to be junk but this overlaps with
        ; DunToggleTilemapPos. So this should not be used for hacking.

    ; $06E0[0x0C] - (Dungeon)
    .ChestTilemapPost: skip $0C
        ; Stores tilemap positions of chests, big key chests, and big key cell
        ; locks. If the top bit is set, it's a Big Key lock, otherwise it's one
        ; of the chest types. The size of the array depends on $0496 and $0498
        ; but will typically only be 12 bytes long since you can only have 6
        ; chests in one room (because of the layout of save game WRAM and
        ; associated code).

    ; $06EC[0x0?] - (Stair, Tilemap, Dungeon)
    .MergedLayerStairSlots: skip $02
        ; Tilemap positions for 1.3.0x1C, 1.3.0x1D, 1.3.0x33. The size of the
        ; array depends on $049C. TODO: Test if there is a max array size.

    ; $06EE[0x02] - (Junk)
    .Junk_06EE: skip $02
        ; Zeroed out once in bank 0x0E, seems to be junk but this overlaps with
        ; MergedLayerStairSlots. So this should not be used for hacking.

    ; $06F8[0x06] - (Free)
    .Free_06F8: skip $06
        ; Marked as free RAM but this needs to be double checked just in case
        ; MergedLayerStairSlots can bleed into this space.

    ; $06FE[0x02] - (Junk)
    .Junk_06FE: skip $02
        ; Zeroed out once in bank 0x0E, seems to be junk but this may overlap with
        ; MergedLayerStairSlots. So this should not be used for hacking.

    ; ===========================================================================
    ; Page 0x07
    ; ===========================================================================

    ; $0700[0x02] - (Overworld)
    .PlayerOWPos: skip $02
        ; Generally is equal to the area number you are in currently in 
        ; times two. This is calculated from the player's coords.
        ; yyyzxxx.
        ; y - Obtained by masking Link's Y coordinate ($20) with 0x1E00,
        ;     shifting left three times.
        ; x - Obaained by masking Link's X coordinate ($22) with 0x1E00,
        ;     and bitwise ORing it with the the y bits.
        ; z - This is the overlap of the x and y bits described above.

    ; $0702[0x06] - (Free)
    .Free_0702: skip $06
        ; Free RAM.

    ; $0708[0x02] - (Overworld, Camera)
    .OWCameraBoundsY: skip $02
        ; Overworld camera northern Y boundary.
        
    ; $070A[0x02] - (Overworld, Camera)
    .OWCameraYBoundsSize: skip $02
        ; Overworld camera Y boundary size.
        ; 0x01F0 - Small screens
        ; 0x03F0 - Big screens

    ; $070C[0x02] - (Overworld, Camera)
    .OWCameraBoundsX: skip $02
        ; Overworld camera western X boundary.

    ; $070E[0x02] - (Overworld, Camera)
    .OWCameraXBoundsSize: skip $02
        ; Overworld camera X boundary size.
        ; 0x003E on small screens
        ; 0x007E on big screens

    ; $0710[0x01] - (NMI, OAM)
    .OAMChrUpdateSkip: skip $01
        ; A flag that when nonzero, prevents certain OAM chr updates from
        ; occuring during NMI. This is done because the NMI interrupt service
        ; routine, even using DMA, can only transfer so many bytes during the
        ; vertical blanking period (roughly 0x1800 bytes at an absolute
        ; maximum), so we can elect to disable many of the low priority sprite
        ; chr updates if we need to move a lot of bytes during NMI with some
        ; specialized routines. If we run past the blanking period while trying
        ; to transfer everything to VRAM, OAM, CGRAM, etc. you will see black lines
        ; or bars flicker on the screen. In the vanilla game this can be seen
        ; after stepping on a star tile in certain rooms. Some of these routines
        ; are indexed or indicated by DMAMask, $1100, and BG3TileMapUpdateFlag 
        ; but there may be more.

    ; $0711[0x01] - (Junk)
    .Junk_0711: skip $01
        ; Set to $FF by exploding walls for some reason but never read.

    ; $0712[0x02] - (Overworld, High Junk)
    .OWIsLargeArea: skip $02
        ; If nonzero, indicates that the current area is a large area. The
        ; high byte is set to 0 and is expected to always be 0.
        ; 0x00 - Small map
        ; 0x20 - Large map

    ; $0714[0x01] - (Overworld, Junk)
    .Junk_0714: skip $01
        ; The low byte of OWIsLargeArea from the previous area. Only written to
        ; once and is never read.

    ; $0715[0x01] - (Free)
    .Free_0715: skip $01
        ; Free RAM.

    ; $0716[0x02] - (Overworld, Camera)
    .OWCameraBoundsSE: skip $02
        ; Forms east and south bounding value for where scroll transition
        ; activates for the  player. The low byte is only ever 0xE4.

    ; $0718[0x02] - (Free)
    .Free_0718: skip $02
        ; Free RAM.

    ; $071E[0x02] - (Junk)
    .Junk_071E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0720[0x02] - (Text)
    .TextMoveLine: skip $02
        ; A flag that if nonzero tells the game to move to the next line of text.

    ; $0722[0x02] - (Text)
    .TextCurrentLine: skip $02
        ; Used to indicate which line the VWF is generating text on.
        ; 0x0000 - First line
        ; 0x0002 - Second line
        ; 0x0004 - Third line
        ; TODO: Verify the line values.

    ; $0724[0x02] - (Text)
    .TextLineStartHPost: skip $02
        ; The starting H position of lines in text. Used to step through $7EC230
        ; in VWF text generation. $7EC230 is only referenced once so its hard to
        ; say just looking at the code. My guess is that this is some sort of H
        ; tilemap position buffer. TODO: Its exact use needs to be investigated.
        ; 0x0000 - First line
        ; 0x0040 - Second line
        ; 0x0080 - Third line

    ; $0726[0x02] - (Text)
    .TextCurrentTilemapPos: skip $02
        ; The actual tilemap position the game is generating text on. Base
        ; position in $7F0000[0x7E0]. It is held constant while an individual
        ; line is rendering. TODO: Verify the values.
        ; 0x0000 - First line
        ; 0x02A0 - Second line
        ; 0x0540 - Third line

    ; $0728[0x06] - (Free)
    .Free_0728: skip $06
        ; Free RAM.

    ; $072E[0x02] - (Junk)
    .Junk_072E: skip $02
        ; Zeroed out once in bank 0x0E. As you can see there is a pattern here.
        ; For some reason every "E" address from $069E to $07DE is zeroed out in
        ; the same spot. This is probably just left over from some unused feature.

    ; $0730[0x0E] - (Free)
    .Free_0730: skip $0E
        ; Free RAM.

    ; $073E[0x02] - (Junk)
    .Junk_073E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0740[0x0E] - (Free)
    .Free_0740: skip $0E
        ; Free RAM.

    ; $074E[0x02] - (Junk)
    .Junk_074E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0750[0x0E] - (Free)
    .Free_0750: skip $0E
        ; Free RAM.

    ; $075E[0x02] - (Junk)
    .Junk_075E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0760[0x0E] - (Free)
    .Free_0760: skip $0E
        ; Free RAM.

    ; $076E[0x02] - (Junk)
    .Junk_076E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0770[0x0E] - (Free)
    .Free_0770: skip $0E
        ; Free RAM.

    ; $077E[0x02] - (Junk)
    .Junk_077E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0780[0x0E] - (Free)
    .Free_0780: skip $0E
        ; Free RAM.

    ; $078E[0x02] - (Junk)
    .Junk_078E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $0790[0x0E] - (Free)
    .Free_0790: skip $0E
        ; Free RAM.

    ; $079E[0x02] - (Junk)
    .Junk_079E: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $07A0[0x0E] - (Free)
    .Free_07A0: skip $0E
        ; Free RAM.

    ; $07AE[0x02] - (Junk)
    .Junk_07AE: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $07B0[0x0E] - (Free)
    .Free_07B0: skip $0E
        ; Free RAM.
        
    ; $07BE[0x02] - (Junk)
    .Junk_07BE: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $07C0[0x0E] - (Free)
    .Free_07C0: skip $0E
        ; Free RAM.

    ; $07CE[0x02] - (Junk)
    .Junk_07CE: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $07D0[0x0E] - (Free)
    .Free_07D0: skip $0E
        ; Free RAM.

    ; $07DE[0x02] - (Junk)
    .Junk_07CE: skip $02
        ; Zeroed out once in bank 0x0E.

    ; $07F0[0x30] - (Free)
    .Free_07D0: skip $30
        ; Free RAM.

    ; ===========================================================================
    ; Pages 0x08, 0x09 and 0x0A
    ; ===========================================================================

    ; OAM Basic 512 byte table:

    ; $0800[0x0200] - (OAM)
    .OAMLowBuffer: skip $0200
        ; The low OAM buffer. This is written to SNES.OMADataWrite via DMA during
        ; NMI. This isn't written to directly most of the time and is instead
        ; written to via OAMLowPtr. Each OAM entry is 4 bytes.
        ; Byte 0: xxxxxxxx
        ; Byte 1: yyyyyyyy
        ; Byte 2: cccccccc
        ; Byte 3: vhoopppc
        ; x - X coordinate
        ; y - Y coordinate
        ; c - Character in VRAM
        ; v - Vertical flip
        ; h - Horizontal flip
        ; o - Priority
        ; p - Palette

        ; Some examples of OAM tiles that are written here directly are the 
        ; file select Link head/death count, the file select indicatior fairy,
        ; dungeon map icons/indicators, the overworld blinking icons, the
        ; intro Nintendo logo, and some smaller player OAM tiles. There are more
        ; that use later addresses such as $0802, $0804, ect. 

    ; $0A00[0x20] - (OAM)
    .OAMHighBuffer: skip $20
        ; The high OAM buffer. Each entry is 2 bits per OAM tile. This will be
        ; written to SNES.OMADataWrite during NMI.
        ; sx sx sx sx
        ; x - The X coordinate's 9th bit.
        ; s - OAM size: 0 - small size, 1 - large size)

    ; $0A20[0x80] - (OAM)
    .OAMHighBufferUncompressed: skip $80
        ; The uncompressed high OAM buffer. Each entry is 1 OAM tile per byte.
        ; This will be compressed down to 4 tiles per byte and then stored down
        ; into OAMHighBuffer during NMI.
        ; .... ..sx
        ; x - The X coordinate's 9th bit.
        ; s - OAM size: 0 - small size, 1 - large size)

        ; Some OAM tiles are written here directly just as they are to the low
        ; buffer. See OAMLowBuffer for more details.

    ; $0AA0[0x01] - (GFX, Junk)
    .Junk_0AA0: skip $01
        ; Appears to have been a GFX sheet index at some point like $0AA1 as it
        ; is cached in the same spots as $0AA1 to $7EC164 and $7EC124. However it 
        ; is never actually written other than from $7EC164 and $7EC124 so it is
        ; always zero.

    ; $0AA1[0x01] - (GFX)
    .GFXTileSheetIndexMain: skip $01
        ; The main tile set index. This corrisponds to the "Main" blockset in the
        ; ZS GFX Manager or sheets 0-7 of the dungeon and overworld BG tiles.
        ; Sheets 3-6 can be overwritten by the value set in $0AA2 room to room or
        ; area to area but 0, 1, 2, and the first half of 7 will stay the same.
        ; The second half of sheet 7 will be overwritten by the "animated" sheet.
        ; See SheetsTable_0AA1 in Bank 0x00 for more details.
        ; There are 0x25 main BG tile sets:
        ; TODO: Document the tile sets here.

    ; $0AA2[0x01] - (GFX)
    .GFXTileSheetIndexAux: skip $01
        ; The auxiliary tile set index. This is the "Rooms" blockset in the ZS
        ; Graphics Manager. Also the overworld GFX number. This controls sheets
        ; 3, 4, 5, and 6 which are the "variable" dungeon and overworld tile
        ; sheets which These sheets can change from room to room or OW area to OW
        ; area.
        ; There are 0x52 auxiliary BG tile themes:
        ; TODO: Document the tile sets here.

    ; $0AA3[0x01] - (GFX)
    .GFXSpriteSheetIndexAux: skip $01
        ; The aux sprite tile set index. This is the "Sprites" tile set in the ZS
        ; Graphics Manager. This controls sheets C, D, E, and F which are the
        ; "variable" sprite sheets. These sheets can change from room to room
        ; or OW area to OW area. Note that when in a dungeon, this value is the
        ; number found in the dungeon header, plus $40. Overworlds do not have
        ; this complication.
        ; TODO: Document the tile sets here.

    ; $0AA4[0x01] - (GFX)
    .GFXSpriteSheetIndexMain: skip $01
        ; The main sprite tile set index. TODO: Find out if this has a ZS
        ; equivilant. This controls sheets 8, 9, A, and B which are the "global"
        ; sprites sheets. These sheets are the same for the whole LW, whole DW, or
        ; all dungeons. This sheet is also used to load some polyhedral sheets.
        ; 0x01 - Light world Overworld
        ; 0x08 - Polyhedral
        ; 0x0A - Dungeons
        ; 0x0B - Dark World Overworld

    ; $0AA5[0x01] - (Free)
    .Free_0AA5: skip $01
        ; Free RAM.

    ; $0AA6[0x02] - (Junk)
    .Junk_0AA6: skip $02
        ; It's location would indicate that at one point it would have been a 
        ; variable used to configure graphics. Zeroed but never read.

    ; $0AA8[0x02] - (Palettes)
    .PalLoadBuffer: skip $02
        ; It's used during palette loading to select between the auxiliary palette
        ; buffer ($7EC300) and the main palette buffer ($7EC500) as targets to
        ; write colors to. Typically only the high byte of this variable is
        ; modified.
        ; 0x0000 - Load into $7EC300
        ; 0x0200 - Load into $7EC500

    ; $0AAA[0x01] - (GFX)
    .GFXSpriteSheetIndexTemp: skip $01
        ; Used in conjuction with Graphics_LoadChrHalfSlot to load half sheets on
        ; demand. Typically used for sprite tiles that don't need to be use all
        ; the time like the medallion effects and the nintendo logo at the
        ; beginning. See Graphics_LoadChrHalfSlot for more details.
        ; 0x00 - Overworld common
        ; 0x01 - Overworld common
        ; 0x02 - Intro
        ; 0x03 - Intro
        ; 0x04 - Unused
        ; 0x05 - Unused
        ; 0x06 - Ether
        ; 0x07 - Ether
        ; 0x08 - Ether
        ; 0x09 - Ether
        ; 0x0A - Bombos
        ; 0x0B - Bombos
        ; 0x0C - Quake
        ; 0x0D - Quake
        ; 0x0E - Game over
        ; 0x0F - Game over
        ; 0x10 - Intro
        ; 0x11 - Intro
        ; 0x12 - Intro
        ; 0x13 - Intro

    ; $0AAB[0x01] - (Free)
    .Free_0AAB: skip $01
        ; Free RAM.

    ; $0AAC[0x01] - (Palette)
    .SprAux3Pal: skip $01
        ; Used to load a 7 color palette to the first half of SP-0 if $0ABD is
        ; zero or the first half of SP-7 if $0ABD is non zero. See the definition
        ; of $7EC500 for palette descriptions. See Palette_SpriteAux3 for more
        ; details. TODO: Find the ZS reference.
        ; The valid values are: TODO: Document these values.
        ; 0x00 - 
        ; 0x01 - LW default
        ; 0x02 - 
        ; 0x03 - DW default
        ; 0x04 - 
        ; 0x05 - 
        ; 0x06 - 
        ; 0x07 - 
        ; 0x08 - 
        ; 0x09 - 
        ; 0x0A - 
        ; 0x0B - Intro sword palette

    ; $0AAD[0x01] - (Palette)
    .SprAux1Pal: skip $01
        ; Used to load a 7 color palette to the first half of SP-5. Usually for
        ; sprites specific to an area / room. See the definition of $7EC500 for
        ; palette descriptions. See Palette_SpriteAux1 for more details. TODO:
        ; Find the ZS reference.
        ; Valid values are: TODO: Document these values.
        ; 0x00 - 
        ; 0x01 - 
        ; 0x02 - 
        ; 0x03 - 
        ; 0x04 - 
        ; 0x05 - 
        ; 0x06 - 
        ; 0x07 - 
        ; 0x08 - 
        ; 0x09 - 
        ; 0x0A - 
        ; 0x0B - 
        ; 0x0C - 
        ; 0x0D - 
        ; 0x0E - 
        ; 0x0F - 
        ; 0x10 - 
        ; 0x11 - 
        ; 0x12 - 
        ; 0x13 - 
        ; 0x14 - 
        ; 0x15 - 
        ; 0x16 - 
        ; 0x17 - 

    ; $0AAE[0x01] - (Palette)
    .SprAux2Pal: skip $01
        ; Used to load a 7 color palette to the first half of SP-6. Usually for
        ; sprites specific to an area / room. See the definition of $7EC500 for
        ; palette descriptions. See Palette_SpriteAux2 for more details. TODO:
        ; Find the ZS reference.
        ; Valid values are: TODO: Document these values, are they the same as AUX1?
        ; 0x00 - 
        ; 0x01 - 
        ; 0x02 - 
        ; 0x03 - 
        ; 0x04 - 
        ; 0x05 - 
        ; 0x06 - 
        ; 0x07 - 
        ; 0x08 - 
        ; 0x09 - 
        ; 0x0A - 
        ; 0x0B - 
        ; 0x0C - 
        ; 0x0D - 
        ; 0x0E - 
        ; 0x0F - 
        ; 0x10 - 
        ; 0x11 - 
        ; 0x12 - 
        ; 0x13 - 
        ; 0x14 - 
        ; 0x15 - 
        ; 0x16 - 
        ; 0x17 - 

    ; $0AAF[0x01] - (Free)
    .Free_0AAF: skip $01
        ; Free RAM.

    ; $0AB0[0x01] - (Free, Palette)
    .Free_0AB0: skip $01
        ; Only seen once in an unreferenced routine: Palette_Unused. This function
        ; would have been used to load a 7 color palette to the first half SP-6.

    ; $0AB1[0x01] - (Palette)
        ; Used to load a 7 color palette to the second half of SP-6. Used for the
        ; palette for throwable objects. See the definition of $7EC500 for palette
        ; descriptions. See Palette_MiscSpr_justSP6 for more details. TODO: Find
        ; the ZS reference.
        ; Valid values are: TODO: Document these values.
        ; 0x00 - 
        ; 0x01 - 
        ; 0x02 - 
        ; 0x03 - 
        ; 0x04 - 
        ; 0x05 - 
        ; 0x06 - 
        ; 0x07 - 
        ; 0x08 - 
        ; 0x09 - 
        ; 0x0A - 
        ; 0x0B - 
        ; 0x0C - 
        ; 0x0D - 
        ; 0x0E - 
        ; 0x0F - 

    ; $0AB2 - 
        ; Used to select the first palette in CGRAM (the screen's background is its first color)
        ; As far as I know, this value is only 0 or 1. 1 seems to be for special modes like the ending sequence.
        ; The first palette is by default in LTTP used for the HUD.

    ; $0AB3 - 
        ; Selects BP-2 through BP-6 (first halves)
        ; 0 - Light World
        ; 1 - Dark World
        ; 2 - Light World Death Mountain
        ; 3 - Dark World Death Mountain
        ; 4 - Used during history mode
        ; 5 - Seems to be used during initialization

    ; $0AB4 - 
        ; Selects BP-2 through BP-4 (second halves). Values 0x00 to 0x13 are valid. Only used during loading the overworld and the title screen.
    ; $0AB5 - 
        ; Selects BP-5 through BP-7 (second halves). Values 0x00 to 0x13 are valid. Only used during loading the overworld and the title screen.

    ; $0AB6[0x01] - (Dungeon) Controls all 6 of the 4bpp background palettes (BP-2
        ; through BP-7)
        ; 
        ; Note: The 2bpp background palette controller is $0AB2.

    ; $0AB7 - 
        ; While only referenced as being cached to $7EC20C,
        ; it is seemingly unused in practice

    ; $0AB8 - 
        ; Selects BP-7 (first half). Only valid for values 0x00 to 0x0D

    ; $0AB9 - 
        ; Free RAM

    ; $0ABD[0x01] - (Palette)
        ; Used in order to swap palettes under certain special circumstances.
        ; Apparently related almost entirely to the flute boy ghost and the ponds of wishing.
        ; When zero, doesn't induce any behavior change, but when nonzero, it will cause
        ; SP-0 and SP-7 (full) to swap and SP-5 and SP-3 (second halves) to swap.

    ; $0ABE - 
        ; Free RAM

    ; $0ABF[0x01] -

        ; Set to zero when an event is initialized, and will be set to 1 the next
        ; time a change of overworld area occurs. This is used to trigger the magic
        ; powder showing up in the Witch's hut, as well as the finishing of your
        ; sword being tempered.
        ; It's also used to make sure you didn't cheat during the
        ; heart piece maze game in Kakkariko.

    ; DMA Variables: To see these in action, look up routine $9E0 in the banks files. These are all Word values.

    ; $0AC0 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored here is grabbed from a table indexed by address $0107.
    ; $0AC2 - 
        ; Also a ROM Address for DMA transfers, usually is 0x180 higher than $0AC0

    ; $0AC4 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored here is grabbed from a table indexed by address $0108.
    ; $0AC6 - 
        ; Also a ROM Address for DMA transfers, usually is 0xC0 higher than $0AC4

    ; $0AC8 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored here is grabbed from a table indexed by address $0109.
    ; $0ACA - 
        ; Also a ROM Address for DMA transfers, is a fixed distance from $0AC8 which is also determined using a table indexed by $0109.

    ; $0ACC - 
        ; ROM Address for certain DMA transfers from bank $10. The value stored here is grabbed from a table indexed by address $0100
    ; $0ACE - 
        ; Also a ROM Address for DMA transfers, usually is 0x200 higher than $0ACC

    ; $0AD0 - 
        ; ROM Address for certain DMA transfers from bank $10. The value stored here is grabbed from a table indexed by address $0100
    ; $0AD2 - 
        ; Also a ROM Address for DMA transfers, usually is 0x200 higher than $0AD0

    ; $0AD4 - 
        ; ROM Address for certain DMA transfers from bank $10.
        ; The value stored here is grabbed from a table indexed by
        ; address $0102.

    ; $0AD6 - 
        ; ROM Address for certain DMA transfers from bank $10.
        ; The value stored here is grabbed from a table indexed by
        ; address $0104.

    ; $0AD8 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored here is grabbed from a table indexed by address $02C3
    ; $0ADA - 
        ; Also a ROM Address for DMA transfers, usually is 0x100 higher than $0AD0

    ; $0ADC - 
        ; ROM Address for certain DMA transfers from bank $7E.
        ; The value stored here is determined like this: the value at
        ; ; $7EC00F + the fixed value 0xA680.
        ; Used in transfering the animated OW tiles.

    ; $0ADE - 
        ; Free RAM

    ; $0AE0 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored here is determined like this: the value in the table at $0085DE indexed by $7EC015 + the fixed value 0xB280.
    ; $0AE2 - 
        ; Also a ROM Address for DMA transfers, usually is 0x100 higher than $0AE0

    ; $0AE4 - 
        ; Free RAM

    ; $0AE8 - 
        ; Used as an offset for $0AEC.
    ; $0AEA - 
        ; Used as an offset for $0AF0.
    ; $0AEC - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored is determined like this: the value at $0AE8 + the fixed value 0xB940
    ; $0AEE - 
        ; Also a ROM Address for DMA transfers, usually is 0x200 higher than $0AEC

    ; $0AF0 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored is determined like this: the value at $0AEA + the fixed value 0xB940
    ; $0AF2 - 
        ; Also a ROM Address for DMA transfers, usually is 0x200 higher than $0AF0

    ; $0AF4[0x02] - (NMI, TravelBird)
        ; Used as a VRAM selector for the travel bird. Since that VRAM region
        ; is updated during every screen update (usually every frame), this
        ; effectively controls the animation state of the bird. Its 
        ; Note: While this is read as a 16-bit value usually, it's only written as
        ; an 8-bit value, with the top byte being assumed as zero.

    ; $0AF6 - 
        ; ROM Address for certain DMA transfers from bank $7E. The value stored is determined like this: the value at $0AF4 + the fixed value 0xB540
    ; $0AF8 - 
        ; Also a ROM Address for DMA transfers, usually is 0x200 higher than $0AF6

    ; $0AFA - 
        ; Free RAM

    ; ===========================================================================
    ; Pages 0x0B and 0x0C
    ; ===========================================================================

    ; Overlord Model (Most if not all arrays are 8 bytes in length)

    ; $0B00 - 
        ; Overlord types for this room.

        ; List of overlord types:

        ; 0x00 - Inactive
        ; 0x01 - Metal Ball Generator?
        ; 0x02 - Cannon Room
        ; 0x03 - Cannon Balls?
        ; 0x04 - Snake Trap
        ; 0x05 - Stalfos Trap
        ; 0x06 - ???
        ; 0x07 - Moving Floor
        ; 0x08 - Transformer (HM name) but I think it's the blobs that fall from the ceiling in the room right before the boss of Misery Mire.
        ; 0x09 - Wallmaster Overlord
        ; 0x0A - Falling tiles Overlord
        ; 0x0B - Falling tiles Overlord 2
        ; 0x0C - Falling tiles Overlord 3
        ; 0x0D - Falling tiles Overlord 4
        ; 0x0E - Falling tiles Overlord 5
        ; 0x0F - Falling tiles Overlord 6
        ; 0x10 - Pirogusu factory (facing right) used in Swamp Palace
        ; 0x11 - Pirogusu factory (facing left) used in Swamp Palace
        ; 0x12 - Pirogusu factory (facing down) used in Swamp Palace
        ; 0x13 - Pirogusu factory (facing up) used in Swamp Palace
        ; 0x14 - Tiles that rise out of floor overlord
        ; 0x15 - Wizzrobe Spawner
        ; 0x16 - Zoro Spawner
        ; 0x17 - Pot Trap
        ; 0x18 - Stalfos that Materialize (a la Eastern Palace)
        ; 0x19 - Armos Knights Handler
        ; 0x1A - ???

    ; $0B08[0x08] - (Overlord)
        ; X coordinate low byte.

    ; $0B10[0x08] - (Overlord)
        ; X coordinate high byte.
    ; $0B18[0x08] - (Overlord)
        ; Y coordinate low byte.

    ; $0B20[0x08] - (Overlord)
        ; Y coordinate high byte.

    ; $0B28[0x08] - (Overlord)
        ; Timer / General.

    ; $0B30[0x08] - (Overlord)
        ; Timer / General.

    ; $0B38[0x08] - (Overlord)
        ; Timer / General.

    ; $0B40[0x08] - (Overlord)

        ; Floor selector.

    ; $0B48[0x10] - (Overlord)
        ; Offset in the overworld sprite position buffer (see $7FDF80)

    ; $0B58[0x10] - (Sprite)
        ; Timers for stunned enemies. Counts down from 0xFF.

    ; $0B68[0x01] - (RepulseSpark)

        ; Location to cache Link's or sprite's floor status. It seems it later gets
        ; used with ancillas in Bank 0x08.

    ; $0B69[0x01] - 
        ; Variable that tutorial soldiers and Blind use. Since it's not reinitialized when you save and quit,
        ; it can trigger a glitch where the Tutorial Soldiers will start saying things that belong to other
        ; characters or entities in the game. Notable in that it spawned a game Gamefaqs thread puzzling over
        ; this behavior.

    ; $0B6A[0x01] - (Sprite)
        ; A variety of sprites use this, including Blind, Statue Sentries, and the
        ; sprites that block the way into the Desert Palace. It's designed to limit
        ; the number of these sprites that can appear at any one time. Typically this
        ; is because they can potentially have a large number of subsprites, which
        ; can require additional WRAM to keep track of, which is limited.

    ; $0B6B[0x10] - (Sprite)
        ; ttttacbp
        ; t - 'Tile Interaction Hit Box'. Selects from one of several hitbox limits
        ; for use when detecting the tile types that the sprite is interacting
        ; with.
        ; a - ; if set the sprite will deflect arrow? bank 08 in Ancilla_CheckIndividualSpriteCollision
        ; c - Override Slash Imminuty (according to Zarby.)
        ; b - "Dies like a boss'. Meaning it has that rather explosive death animation
        ; and makes a different noise.
        ; p - Sprite ignores falling into a pit when frozen? (Not really sure yet)

    ; $0B7B - 
        ; Flag indicating whether Link can move or not. Set to 1 to prevent him from moving.

    ; $0B7C[0x02] - (Player)
        ; Used for dragging the player, like with the Debirando? (X component)
        ; Update: Also used by the Somaria Platform sprite.

    ; $0B7E[0x02] - (Player)
        ; Used for dragging the player, like with the Debirando? (Y component)
        ; Update: Also used by the Somaria Platform sprite.

    ; $0B80 - 
        ; Seems to be a memory of the past 4 rooms you've visited (dungeon mode only)

    ; $0B88[0x01] - (ArcheryGameGuy)

        ; ???? Seems to have some relation to the shooting gallery guy,
        ; though it may have other uses.
        ; 
        ; (cheat code: disable bounds checking on this to perhaps get
        ; extended prizes like 100 rupees??)
        ; 
        ; Appears to index prizes for the archery game.

    ; $0B89[0x10] - (Sprite)
        ; Object priority stuff for sprites?

    ; $0B96[0x01] - 
        ; Note: A bug can arise relating to this variable if you defeat Blind or even
        ; just save the game while fighting him and then start a new game. Since the
        ; tutorial soldiers don't initialize this variable.
        ; Used by tutorial soldiers to cycle through messages (0x00 through 0x06, but has 0x0F added to it).
        ; Also used by Blind the Thief when he's hit.
        ; If after beating Blind, one saves and continues and starts a new game,
        ; there's a strong likelihood that the tutorial soldiers will say the wrong messages,
        ; if the value of this variable was more than 0x07 after beating Blind.

    ; $0B99[0x01] - (ArcheryGameGuy)
        ; Number of arrows left in the archery game.

    ; $0B9A[0x01] - (ArcheryGameGuy)
        ; If set to a nonzero value, you cannot fire arrows. This is reset to 0 every
        ; frame that sprite code is run, so it's only used during the archery game,
        ; which sets this flag to 1 if you are out of "minigame" arrows.

    ; $0B9B - 
        ; ??? used with "dash item"?

    ; $0B9C[0x02] - 
        ; ??? Relates to dungeon secrets

    ; $0B9E[0x01] - (StalfosTrap)
        ; When set to a nonzero value, a stalfos trap overlord in a room will
        ; begin the process of spawning a stalfos.

    ; $0B9F - 
        ; Free RAM

    ; $0BA0 - 
        ; undocumented sprite variable (shows up a lot, though)

        ; Update: Seems to indicate that it ignores all projectile interactions if set. ; causes arrows to not hit

    ; $0BB0 - 
        ; For sprites that interact with speical objects (arrows in particular), the ancilla
        ; will identify its type to the sprite via this location.

    ; $0BC0[0x20] - (Sprite / Dungeon?)
        ; contains the index of the sprite (i.e. its position in the $0E20[0x10] array
        ; only seems to be modified in the initial dungeon loading routine (room transitions 
        ; don't appear to write here.)

    ; $0BE0[0x10] - (Sprite)
        ; iwbspppp
        ; i - If set, disable certain types of tile interactions for the sprite, such
        ; as falling into holes, moving floors, and conveyor belts, among others.
        ; w - Seems like it has something to do with sprites that are found in water,
        ; whether that's deep water or shallow water. Either way, still needs
        ; to be reverse engineered a bit more.
        ; b - If set, the sprite can be blocked by a shield, provided the player has
        ; any level shield at all. The sprite will die if this is set and a
        ; collision with the player occurs while they have a shield, regardless
        ; of whether it 'hits' the shield. However, it must be traveling towards
        ; the face of the shield to be blocked. Otherwise, the player will be
        ; harmed.
        ; s - If set, play the 'enemy taking damage' sound effect. Otherwise,
        ; play the basic 'sprite getting hit' sound effect (which will play for
        ; some enemies in spite of the fact that they are still taking damage.)
        ; p - Prize pack to grant (assassin17 has this somewhat figured out, I just
        ; need to make sure my doc jives with his, and if not, find out why.)
        ; prize pack for a sprite in the sprite object model (see below)

    ; $0BF0[0x0A] - (Ancilla)
        ; Usage varies among ancillae.

    ; $0BFA[0x0A] - (Ancilla)
        ; Y coordinate low byte.

    ; $0C04[0x0A] - (Ancilla)
        ; X coordinate low byte.

    ; $0C0E[0x0A] - (Ancilla)
        ; Y coordinate high byte.

    ; $0C18[0x0A] - (Ancilla)
        ; X coordinate high bytes.

    ; $0C22[0x0A] - (Ancilla)
        ; Y velocity.
    ; $0C2C[0x0A] - (Ancilla)
        ; X velocity.
    ; $0C36[0x0A] - (Ancilla)
        ; Subpixel portion of Y coordinate.
    ; $0C40[0x0A] - (Ancilla)
        ; Subpixel portion of X coordinate.

    ; $0C4A[0x0A] - (Ancilla)
        ; Type index for Ancillary objects. Valid values are as follows:
        ; 0x00 - Nothing, and actually an indicator that no ancilla is currently active in this slot.
        ; 0x01 - Somarian Blast; Results from splitting a Somarian Block
        ; 0x02 - Fire Rod Shot
        ; 0x03 - Unused; Instantiating one of these creates an object that does nothing.
        ; 0x04 - Beam Hit; Master sword beam or Somarian Blast dispersing after hitting something
        ; 0x05 - Boomerang
        ; 0x06 - Wall Hit; Spark-like effect that occurs when you hit a wall with a boomerang or hookshot
        ; 0x07 - Bomb; Normal bombs laid by the player
        ; 0x08 - Door Debris; Rock fall effect from bombing a cracked cave or dungeon wall
        ; 0x09 - Arrow; Fired from the player's bow
        ; 0x0A - Halted Arrow; Player's arrow that is stuck in something (wall or sprite)
        ; 0x0B - Ice Rod Shot
        ; 0x0C - Sword Beam
        ; 0x0D - Sword Full Charge Spark; The sparkle that briefly appears at the tip of the player's sword when their spin attack fully charges up.
        ; 0x0E - Unused; Duplicate of the Blast Wall
        ; 0x0F - Unused; Duplicate of the Blast Wall
        ; 0x10 - Unused; Duplicate of the Blast Wall
        ; 0x11 - Ice Shot Spread; Ice shot dispersing after hitting something.
        ; 0x12 - Unused; Duplicate of the Blast Wall
        ; 0x13 - Ice Shot Sparkle; The only actually visible parts of the ice shot.
        ; 0x14 - Unused; Don't use as it will crash the game.
        ; 0x15 - Jump Splash; Splash from the player jumping into or out of deep water
        ; 0x16 - The Hammer's Stars / Stars from hitting hard ground with the shovel
        ; 0x17 - Dirt from digging a hole with the shovel
        ; 0x18 - The Ether Effect
        ; 0x19 - The Bombos Effect
        ; 0x1A - Precursor to torch flame / Magic powder
        ; 0x1B - Sparks from tapping a wall with your sword
        ; 0x1C - The Quake Effect
        ; 0x1D - Jarring effect from hitting a wall while dashing
        ; 0x1E - Pegasus boots dust flying
        ; 0x1F - Hookshot
        ; 0x20 - Link's Bed Spread
        ; 0x21 - Link's Zzzz's from sleeping
        ; 0x22 - Received Item Sprite
        ; 0x23 - Bunny / Cape transformation poof
        ; 0x24 - Gravestone sprite when in motion
        ; 0x25
        ; 0x26 - Sparkles when swinging lvl 2 or higher sword
        ; 0x27 - the bird (when called by flute)
        ; 0x28 - item sprite that you throw into magic fairy ponds.
        ; 0x29 - Pendants and crystals
        ; 0x2A - Start of spin attack sparkle
        ; 0x2B - During Spin attack sparkles
        ; 0x2C - Cane of Somaria blocks
        ; 0x2D
        ; 0x2E - ????
        ; 0x2F - Torch's flame
        ; 0x30 - Initial spark for the Cane of Byrna activating
        ; 0x31 - Cane of Byrna spinning sparkle
        ; 0x32 - Flame blob, possibly from wall explosion
        ; 0x33 - Series of explosions from blowing up a wall (after pulling a switch)
        ; 0x34 - Burning effect used to open up the entrance to skull woods.
        ; 0x35 - Master Sword ceremony.... not sure if it's the whole thing or a part of it
        ; 0x36 - Flute that pops out of the ground in the haunted grove.
        ; 0x37 - Appears to trigger the weathervane explosion.
        ; 0x38 - Appears to give Link the bird enabled flute.
        ; 0x39 - Cane of Somaria blast which creates platforms (sprite 0xED)
        ; 0x3A - super bomb explosion (also does things normal bombs can)
        ; 0x3B - Unused hit effect. Looks similar to Somaria block being nulled out.
        ; 0x3C - Sparkles from holding the sword out charging for a spin attack.
        ; 0x3D - splash effect when things fall into the water
        ; 0x3E - 3D crystal effect (or transition into 3D crystal?)
        ; 0x3F - Disintegrating bush poof (due to magic powder)
        ; 0x40 - Dwarf transformation cloud
        ; 0x41 - Water splash in the waterfall of wishing entrance (and swamp palace)
        ; 0x42 - Rupees that you throw in to the Pond of Wishing
        ; 0x43 - Ganon's Tower seal being broken. (not opened up though!)
    ; $0C54[0x0A] - (Ancilla)
        ; Array that might contain info about steps for effects indicated in 

    ; $0C5E[0x0A] - (Ancilla)
        ; Array that contains an item index to give to Link. e.g. 0x38 for the pendant of power.

    ; $0C68[0x0A] - (Ancilla)

        ; Autodecrementing timer that any ancilla can make use of. Its value
        ; decrements by one each frame. It halts at the value zero, but will resume
        ; decrementing if a nonzero value is written to it on subsequent frames. 

    ; $0C72[0x0A] - (Ancilla)

        ; special effect (only known application so far is bomb's direction when laid)

    ; $0C7C[0x0A] - (Ancilla)

        ; Ancilla floor selector (BG2 or BG1). Analogue for sprite objects 
        ; would be $0F20[0x10].

    ; $0C86 - 
        ; Free RAM?
        ; Starting offset into OAM buffer on any particular frame.

    ; $0C90[0x0A] - (Ancilla)
        ; Number of sprites the special effects uses * 4

    ; ===========================================================================
    ; The Sprite Object Model. All arrays are 16 bytes long since there are 16 
    ; sprites per room.
    ;
    ; Note: also see $0BE0
    ; ===========================================================================

    ; $0C9A - 
        ; Room or Area number that the sprite has been loaded to. (If in a dungeon, only contains the lower byte)

    ; $0CAA[0x10] - (Sprite)
        ; Deflection properties bitfield
        ; abcdefgh
        ; a - If set... creates some condition where it may or may not die
        ; (Active off screen according to Zarby)
        ; b - Same as bit 'a' in some contexts (Zora in particular)
        ; (Die off screen according to Zarby)
        ; c - While this is set and unset in a lot of places for various sprites, its
        ; status doesn't appear to ever be queried. Based on the pattern of its
        ; usage, however, the best deduction I can make is that this was a flag
        ; intended to signal that a sprite is an interactive object that Link can
        ; push against, pull on, or otherwise exerts a physical presence.
        ; 
        ; In general, it might have indicated some kind of A button (action
        ; button) affinity for the sprite, but I think this is merely informative
        ; rather than something relevant to gameplay.
        ; d - If hit from front, deflect Ice Rod, Somarian missile,
        ; boomerang, hookshot, and sword beam, and arrows stick in
        ; it harmlessly.  If bit 1 is also set, frontal arrows will
        ; instead disappear harmlessly.  No monsters have bit 4 set
        ; in the ROM data, but it was functional and interesting
        ; enough to include.
        ; e - If set, makes the sprite collide with less tiles than usual.
        ; (Projectile like collision according to Zarby)
        ; f - If set, makes sprite impervious to sword and hammer type attacks.
        ; g - Seems to make sprite impervious to arrows, but may have other
        ; additional meanings. Makes the sprite be able to be picked up by the boomerang.
        ; (Bonk item according to Zarby)
        ; h - disabled???
        ; (No perma-death in dungeons according to Zarby)

    ; $0CBA[0x10] - (Sprite)
        ; If this is the following when the sprite dies, then:
        ; 0x00: nothing happens.
        ; 0x01: leaves a normal key.
        ; 0x03: single green rupee.
        ; anything else: Big Key

    ; $0CCA - 
        ; Area that an overlord was loaded during

    ; $0CD2[0x10] - (Sprite)

        ; rbiadddd

        ; r - Recoil without collision.
        ; b - Bee target
        ; i - Immune to powder
        ; a - Allowed in boss fights
        ; d - Bump damage the sprite can inflict on the player.

    ; $0CE2[0x10] - (Sprite)
        ; When the sprite is hit, this is written to with the amount of damage to
        ; subtract from the sprite's HP. Certain values also have other effects, such as inserting #$FF stuns the sprite like the hookshot or boomerang

        ; Special Effects:
        ; 0xFF - Target is stunned for 0xFF frames (Hookshot/boomerang).
        ; 0xFE - Target becomes frozen (Ice Rod effect).
        ; 0xFD - Target is incinerated (Fire Rod effect).
        ; 0xFC - Target is stunned for 0x80 frames (Hookshot/boomerang).
        ; 0xFB - Target is stunned for 0x20 frames (Hookshot/boomerang).
        ; 0xFA - Target becomes a blob (Magic Powder).
        ; 0xF9 - Target becomes a fairy (Magic Powder).

        ; These are the rest of the values that appear in vanilla but all just do that amount of damage to the sprite.
        ; 0x64
        ; 0x40
        ; 0x20
        ; 0x18
        ; 0x10
        ; 0x08
        ; 0x04
        ; 0x02
        ; 0x01
        ; 0x00 

    ; $0CF2[0x01] - (Sprite)
        ; Damage type determiner

    ; $0CF3 - 
        ; Free RAM TODO: actually not? A comment in bank 06 seems to
        ; suggest otherwise.

    ; $0CF4[0x01] - 
        ; Activates bomb or snake trap overlords when set to a nonzero value.

    ; $0CF5 - 
        ; Related to palace map submodule, but otherwise I dunno.

    ; $0CF7 - 
        ; Sometimes incremented whenever a secret is revealed on the
        ; overworld. The circumstances under which this happens are a tad
        ; convoluted. First, the secret sprite that is to be revealed
        ; must have a certain configuration, and on top of that, there's
        ; a 50% chance that the incrementing won't occur at all.
        ; 
        ; When it is in fact incremented, it's used to select an
        ; different secret that will be substituted for the one
        ; originally picked. Since secrets can be revealed at random on
        ; the overworld - that is, not only at designated tiles, this
        ; introduces yet another layer of randomness into secrets on the
        ; overworld. The set of sustituted secrets is different for the
        ; Light World and the Dark World. This variable is never
        ; explicitly initialized, and never explicitly reset. The actual
        ; value used as an index based on this variable is the value of
        ; variable mod 8 (value % 8 in C language parlance.)

    ; $0CF8 - 
        ; Used in bank 07 as a temporary variable for picking a sound
        ; effect with appropriate panning

    ; $0CF9 - 
        ; Item drop luck. This is exactly the luck that is determined by
        ; the Pond of Wishing in the Light World.
        ; 
        ; Luckily (hah!), bad and good item drop luck status only lasts
        ; for 10 kills before being reset to normal luck.
        ; 
        ; 0 - Normal luck; item drops are random.
        ; 1 - Good luck; item drops are guaranteed.
        ; 2 - Bad luck; items drops are disabled completely.

    ; $0CFA - 
        ; Luck Kill Counter. When this reaches 10 luck will revert to
        ; normal. That goes for bad and good types of luck.

    ; $0CFB[0x01] - (PullForRupees)
        ; Number of sprites that the player has killed. Overflows back to
        ; 0 when 256 kills are reached. The only other way that this can
        ; be reset is by the PullForRupees sprite when you pull on it.
        ; Also, that sprite is the only entity in the game that even
        ; looks at this variable.

    ; $0CFC - 
        ; Number of times the player has been hurt by sprites (pits don't
        ; count.) This is only reset to zero by the PullForRupees sprite
        ; when you pull on it.
        ; 
        ; Also, that sprite is the only entity in the game that even
        ; looks at this variable.

    ; $0CFD - 
        ; Counter used to cause delay between rupee refill sound effects

    ; $0CFE - 
        ; Used to override the palette of a sprite that is frozen. When
        ; nonzero, this sets the forces the sprite's palette index to 2.

    ; ===========================================================================
    ; Page 0x0D
    ; ===========================================================================

    ; $0D00 - 
        ; The lower byte of a sprite's Y - coordinate. ; functions
    ; $0D10 - 
        ; The lower byte of a sprite's X - coordinate. ; functions
    ; $0D20 - 
        ; The high byte of a sprite's Y - coordinate. ; functions
    ; $0D30 - 
        ; The high byte of a sprite's X - coordinate. ; functions

    ; $0D40[0x10] - (Sprite) ; sprite
        ; Y velocity.

    ; $0D50[0x10] - (Sprite) ; sprite
        ; X velocity.

    ; $0D60 - 
        ; Y "second derivative" to give a path a more rounded shape when needed. ; sprite
    ; $0D70 - 
        ; X "second derivative" to give a path a more rounded shape when needed. ; sprite

    ; $0D80 - 
        ; Controls whether the sprite has been spawned yet. 0 - no. Not 0 - yes. Also used as an AI pointer ; functions

    ; $0D90[0x10] - (Sprite) ; sprite ; i use it to control which draw frame we are on
        ; In some creatures, used as an index for determining $0DC0

    ; $0DA0[0x10] - (Sprite) ; sprite ; i use to to determine the palette we are on
        ; usage varies considerably for each sprite type

    ; $0DB0[0x10] - (Sprite) ; sprite ; beamos laser subsprite control ; stage index for helmasaur king
        ; hard to say at this point. Various usages?

    ; $0DC0[0x10] - (Sprite) ; sprite ; i use it to control the animation frame we are on
        ; Designates which graphics to use.

    ; $0DD0[0x10] - (Sprite) ; setting
        ; General state of the sprite. Usage of values other than those listed will
        ; almost certainly crash the game, so do not attempt to use them.
        ; 0x00 - Sprite is dead, totally inactive
        ; 0x01 - Sprite falling into a pit with generic animation.
        ; 0x02 - Sprite transforms into a puff of smoke, often producing an item
        ; 0x03 - Sprite falling into deep water (optionally making a fish jump up?)
        ; 0x04 - Death Mode for Bosses (lots of explosions).
        ; 0x05 - Sprite falling into a pit that has a special animation (e.g. Soldier)
        ; 0x06 - Death Mode for normal creatures.

        ; 0x07 - Spite in burning mode (when hit by the fire rod).
        ; 0x08 - Sprite is being spawned at load time. An initialization routine will
        ; be run for one frame, and then move on to the active state (0x09) the
        ; very next frame.
        ; 0x09 - Sprite is in the normal, active mode.
        ; 0x0A - Sprite is being carried by the player.
        ; 0x0B - Sprite is frozen and / or stunned.
    ; $0DE0[0x10] - (Sprite) ; functions
        ; A position counter for the statue sentry? May have other uses
        ; Seems that some sprites use this as an indicator for cardinal direction?
        ; (Octorocks, for example).
        ; udlr ?
        ; 0 - up
        ; 1 - down
        ; 2 - left
        ; 3 - right
        ; Some sprites, like the Desert Barrier, have this reversed:
        ; 0 - right
        ; 1 - left
        ; 2 - down
        ; 3 - up
        ; The Giant Moldorm uses this one somewhat more like the expanded cardinal
        ; directions. Each state corresponds to an angular step of 22.5 degrees.
        ; 0  - East
        ; 1  - East-Southeast
        ; 2  - South East
        ; 3  - South-Southeast
        ; 4  - South
        ; 5  - South-Southwest
        ; 6  - South West
        ; 7  - West-Southwest
        ; 8  - West
        ; 9  - West-Northwest
        ; 10 - North West
        ; 11 - North-Northwest
        ; 12 - North
        ; 13 - North-Northeast
        ; 14 - Northeast
        ; 15 - East-Northeast
        ; Or diagramatically:
        ;                 12               
        ;          11     |     13         
        ;    10           |          14    
        ;                 |                
        ;  9              |             15 
        ;                 |                
        ;                 |                
        ; 8 --------------+-------------- 0
        ;                 |                
        ;                 |                
        ;  7              |             1  
        ;                 |                
        ;       6         |         2      
        ;            5    |    3           
        ;                 4    
        ; Distances are of course rough, and relative, as this is text, and the
        ; relative distances may appear differently on various displays and editors.
        ; The Statue Sentry sprite has an even more finely grained direction system
        ; that uses this same variable as its indicator. It has 0x40 states, where
        ; each states corresponds to an angular step of 5.625 degrees. However, its
        ; orientation is different in that the step values increase as the eye rotates
        ; counter-clockwise, unlike the Giant Moldorm's rotation scheme. The starting
        ; position of 0 is located directly to the left, with 0x10 being south, 0x20
        ; east, and 0x30 north.
        ; The Spark sprite has two sets of 4 cardinal direction states. The first set
        ; is for clockwise oriented adhesion to wall surfaces as is travels, and the
        ; other set (0x04 to 0x07) indicates adhesion but in the counterclockwise
        ; attitude.
        ; As always, more exceptional uses of this variable may exist.

    ; $0DF0[0x10] - (Sprite) ; timer
        ; Main delay timer for sprites. Usually used to time intervals between state
        ; transitions, and also for certain time sensitive events, like playing a
        ; sound effect on a specific frame.

    ; $0E00[0x10] - (Sprite) ; timer
        ; Auxiliary Delay Timer 1

    ; $0E10[0x10] - (Sprite) ; timer
        ; Auxiliary Delay Timer 2

    ; $0E20[0x10] - (Sprite)
        ; sprite index
        ; The type of the sprite. The following is a list of all the sprite types
        ; available. For sprite overlords, see $0B00[0x08]

        ; 0x00 = Raven
        ; 0x01 = Vulture
        ; 0x02 = Flying Stalfos Head
        ; 0x03 = Unused (Don't use it, the sprite's ASM pointer is invalid. It will certainly crash the game.)
        ; 0x04 = Good Switch being pulled
        ; 0x05 = Some other sort of switch being pulled, but from above?
        ; 0x06 = Bad Switch
        ; 0x07 = switch again (facing up)
        ; 0x08 = Octorock
        ; 0x09 = Giant Moldorm (boss)
        ; 0x0A = Four Shooter Octorock
        ; 0x0B = Chicken / Chicken Transformed into Lady
        ; 0x0C = Octorock
        ; 0x0D = Normal Buzzblob / Morphed Buzzblob (tra la la... look for Sahashrala)
        ; 0x0E = Plants with big mouths
        ; 0x0F = Octoballoon (The thing that explodes into 10 others)
        ; 0x10 = Octobaby (Baby Octorocks from the Otobaloon)
        ; 0x11 = Hinox (Bomb-chucking one-eyed giant)
        ; 0x12 = Moblin
        ; 0x13 = Helmasaur (small variety)
        ; 0x14 = Thieves' Town (AKA Gargoyle's Domain) Grate
        ; 0x15 = Bubble (AKA Fire Fairy)
        ; 0x16 = Sahashrala / Aginah, sage of the desert
        ; 0x17 = Rupee Crab under bush / rock
        ; 0x18 = Moldorm
        ; 0x19 = Poe
        ; 0x1A = Dwarf, Mallet, and the shrapnel from it hitting
        ; 0x1B = Arrow shot by solder / stuck in wall? Spear thrown by Moblin?
        ; 0x1C = Moveable Statue
        ; 0x1D = Weathervane
        ; 0x1E = Crystal Switch
        ; 0x1F = Sick Kid with Bug Catching Net
        ; 0x20 = Sluggula
        ; 0x21 = Push Switch (like in Swamp Palace)
        ; 0x22 = Darkworld Snakebasket
        ; 0x23 = Red Bari / Small Red Bari
        ; 0x24 = Blue Bari
        ; 0x25 = Tree you can talk to?
        ; 0x26 = Hardhat Beetle (Charging Octopus looking thing)
        ; 0x27 = Dead Rock (Some might see them as Gorons, but bleh)
        ; 0x28 = Shrub Guy who talks about Triforce / Other storytellers
        ; 0x29 = Blind Hideout Guy / Thief Hideout Guy / Flute Boy's Father
        ; 0x2A = Sweeping Lady
        ; 0x2B = Bum under the bridge + smoke and other effects like the fire
        ; 0x2C = Lumberjack Bros.
        ; 0x2D = Telepathic stones? Looks like a prototype for a telepathic interface using sprites instead of tiles. However, this one only says one thing.
        ; 0x2E = Flute Boy and his musical notes
        ; 0x2F = Maze Game Lady
        ; 0x30 = Maze Game Guy
        ; 0x31 = Fortune Teller / Dwarf swordsmith
        ; 0x32 = Quarreling brothers 
        ; 0x33 = Pull For Rupees
        ; 0x34 = Young Snitch Lady
        ; 0x35 = Innkeeper
        ; 0x36 = Witch
        ; 0x37 = Waterfall
        ; 0x38 = Arrow Target (e.g. Statue with big eye in Dark Palace)
        ; 0x39 = Middle Aged Guy in the desert
        ; 0x3A = Magic Powder Bat /The Lightning Bolt the bat hurls at you.
        ; 0x3B = Dash Item / such as Book of Mudora, keys
        ; 0x3C = Kid in village near the trough
        ; 0x3D = Older Snitch Lady (Signs?) (Chicken lady also showed up)
        ; 0x3E = Rock Rupee Crabs
        ; 0x3F = Tutorial Soldiers from beginning of game
        ; 0x40 = Hyrule Castle Barrier to Agahnim's Tower
        ; 0x41 = Soldier
        ; 0x42 = Blue Soldier
        ; 0x43 = Red Spear Soldier
        ; 0x44 = Crazy Blue Killer Soldiers
        ; 0x45 = Crazy Red Spear Soldiers (And green ones in the village)
        ; 0x46 = Blue Archer Soldiers
        ; 0x47 = Green Archer Soldiers (in the bushes)
        ; 0x48 = Red Javelin Trooper
        ; 0x49 = Red Javelin Soldiers (in the bushes)
        ; 0x4A = Red Bomb Soldiers
        ; 0x4B = Recruit (Weak Green Soldier) (Note: Name was invented for lack of an official name)
        ; 0x4C = Sand Monsters
        ; 0x4D = Flailing Bunnies on the ground
        ; 0x4E = Snakebasket
        ; 0x4F = Blobs?
        ; 0x50 = Metal Balls (in Eastern Palace)
        ; 0x51 = Armos
        ; 0x52 = Zora King
        ; 0x53 = Armos Knight
        ; 0x54 = Lanmolas boss
        ; 0x55 = Zora / Fireballs (including the blue Agahnim fireballs)
        ; 0x56 = Walking Zora
        ; 0x57 = Desert Palace Barriers
        ; 0x58 = Crab
        ; 0x59 = Lost Woods Bird
        ; 0x5A = Lost Woods Squirrel
        ; 0x5B = Spark (clockwise on convex)
        ; 0x5C = Spark (counterclockwise on convex)
        ; 0x5D = Roller (vertical moving)
        ; 0x5E = Roller (vertical moving)
        ; 0x5F = Roller (???)
        ; 0x60 = Roller (horizontal moving)
        ; 0x61 = Statue Sentry      ; beamos
        ; 0x62 = Master Sword plus pendants and beams of light
        ; 0x63 = Sand Lion Pit
        ; 0x64 = Sand Lion
        ; 0x65 = Shooting Gallery guy
        ; 0x66 = Moving cannon ball shooters
        ; 0x67 = Moving cannon ball shooters
        ; 0x68 = Moving cannon ball shooters
        ; 0x69 = Moving cannon ball shooters 
        ; 0x6A = Ball N' Chain Trooper
        ; 0x6B = Cannon Ball Shooting Soldier (unused in original = WTF?)
        ; 0x6C = Warp Vortex created by Magic Mirror
        ; 0x6D = Rat / Bazu
        ; 0x6E = Rope / Skullrope (aka Sukarurope?)
        ; 0x6F = Bats / Also one eyed bats
        ; 0x70 = Splitting Fireballs from Helmasaur King
        ; 0x71 = Leever
        ; 0x72 = Activator for the ponds (where you throw in items)
        ; 0x73 = Link's Uncle / Sage / Barrier that opens in the sanctuary
        ; 0x74 = Red Hat Boy who runs from you
        ; 0x75 = Bottle Vendor
        ; 0x76 = Princess Zelda
        ; 0x77 = Also Fire Fairys (seems like a different variety)
        ; 0x78 = Elder's Wife (Sahasrahlah's Wife, supposedly)
        ; 0x79 = Good bee / normal bee
        ; 0x7A = Agahnim
        ; 0x7B = Agahnim energy blasts (not the duds)
        ; 0x7C = Green Stalfos
        ; 0x7D = 32*32 Pixel Yellow Spike Traps
        ; 0x7E = Swinging Fireball Chains
        ; 0x7F = Swinging Fireball Chains
        ; 0x80 = Wandering Fireball Chains
        ; 0x81 = Waterhoppers
        ; 0x82 = Swirling Fire Fairys (Eastern Palace)
        ; 0x83 = Greene Eyegore
        ; 0x84 = Red Eyegore
        ; 0x85 = Yellow Stalfos (drops to the ground, dislodges head)
        ; 0x86 = Kodondo
        ; 0x87 = Flames
        ; 0x88 = Mothula
        ; 0x89 = Mothula's beam
        ; 0x8A = Moving Spike Block (Key holes? <-- why would I think this had anything to do with keys?)
        ; 0x8B = Gibdo
        ; 0x8C = Arghuss
        ; 0x8D = Arghuss spawn
        ; 0x8E = Chair Turtles you kill with hammers
        ; 0x8F = Blobs / Crazy Blobs via Magic powder or Quake Medallion
        ; 0x90 = Grabber things?
        ; 0x91 = Stalfos Knight
        ; 0x92 = Helmasaur King
        ; 0x93 = Bungie / Red Orb? (according to HM)
        ; 0x94 = Pirogusu (aka Swimmer) / Flying Tiles
        ; 0x95 = Eye laser
        ; 0x96 = Eye laser
        ; 0x97 = Eye laser
        ; 0x98 = Eye laser
        ; 0x99 = Pengator
        ; 0x9A = Kyameron
        ; 0x9B = Wizzrobes
        ; 0x9C = Black sperm looking things
        ; 0x9D = Black sperm looking things
        ; 0x9E = Ostrich seen with Flute Boy
        ; 0x9F = Rabbit seen with Flute Boy
        ; 0xA0 = Birds seen with Flute Boy
        ; 0xA1 = Freezor
        ; 0xA2 = Kholdstare
        ; 0xA3 = Another part of Kholdstare
        ; 0xA4 = Ice balls from above
        ; 0xA5 = Blue Zazak / Fire Phlegm (Fireballs of Red Zazaks and other sprites)
        ; 0xA6 = Red Zazak
        ; 0xA7 = Red Stalfos Skeleton
        ; 0xA8 = Bomber Flying Creatures from Darkworld
        ; 0xA9 = Bomber Flying Creatures from Darkworld
        ; 0xAA = Like Like (O_o yikes)
        ; 0xAB = Maiden (as in, the maidens in the crystals after you beat a boss)
        ; 0xAC = Apples
        ; 0xAD = Old Man on the Mountain
        ; 0xAE = Down Pipe
        ; 0xAF = Up Pipe
        ; 0xB0 = Right Pipe
        ; 0xB1 = Left Pipe
        ; 0xB2 = Good bee again? (Perhaps the good bee is different after being released.... It would make sense, actually)
        ; 0xB3 = Hylian Inscription (near Desert Palace). Also near Master Sword
        ; 0xB4 = Thief's chest (not the one that follows you, the one that you grab from the DW smithy house)
        ; 0xB5 = Bomb Salesman (elephant looking guy)
        ; 0xB6 = Kiki the monkey?
        ; 0xB7 = Maiden that ends up following you in Thieves Town
        ; 0xB8 = Monologue Testing Sprite (Debug Artifact)
        ; 0xB9 = Feuding Friends on Death Mountain
        ; 0xBA = Whirlpool
        ; 0xBB = Salesman / chestgame guy / 300 rupee giver guy / Chest game thief
        ; 0xBC = Drunk in the inn
        ; 0xBD = Vitreous (the large eyeball)
        ; 0xBE = Vitreous' smaller eyeballs
        ; 0xBF = Aghanim / Vitreous' lightning blast
        ; 0xC0 = Monster in Lake of Ill Omen / Quake Medallion
        ; 0xC1 = Agahnim teleporting Zelda to dark world
        ; 0xC2 = Boulders / Rocks from Lanmolas erupting from the ground
        ; 0xC3 = Gibo (vulnerable part)
        ; 0xC4 = Thief
        ; 0xC5 = Evil Fireball Spitters (THE FACES!!!)
        ; 0xC6 = Four Way Fireball Spitters (spit when you use your sword)
        ; 0xC7 = Hokbok (HM calls it Fuzzy Stack, I think?)
        ; 0xC8 = Big Healing Fairys / Fairy Dust
        ; 0xC9 = Ganon's Firebat (HM also says Tektite?)
        ; 0xCA = Chain Chomp
        ; 0xCB = Trinexx
        ; 0xCC = Another Part of Trinexx
        ; 0xCD = Another Part of Trinexx (again)
        ; 0xCE = Blind the Thief
        ; 0xCF = Swamola (swamp worms from Swamp of Evil)
        ; 0xD0 = Lynel (centaur like creature)
        ; 0xD1 = Rabbit Beam aka Transform aka Yellow Hunter
        ; 0xD2 = Flopping fish
        ; 0xD3 = Stal (Hopping Skull Creatures)
        ; 0xD4 = Landmines
        ; 0xD5 = Digging Game Proprietor
        ; 0xD6 = Ganon! OMG
        ; 0xD7 = Copy of Ganon, except invincible?
        ; 0xD8 = Heart refill
        ; 0xD9 = Green Rupee
        ; 0xDA = Blue Rupee
        ; 0xDB = Red Rupee
        ; 0xDC = Bomb Refill (1)
        ; 0xDD = Bomb Refill (4)
        ; 0xDE = Bomb Refill (8)
        ; 0xDF = Small Magic Refill
        ; 0xE0 = Full Magic Refill
        ; 0xE1 = Arrow Refill (5)
        ; 0xE2 = Arrow Refill (10)
        ; 0xE3 = Fairy
        ; 0xE4 = Key
        ; 0xE5 = Big Key
        ; 0xE6 = Shield Pickup (Fighter or Red Shield after being dropped by a Pikit)
        ; 0xE7 = Mushroom
        ; 0xE8 = Fake Master Sword
        ; 0xE9 = Magic Shop dude / His items, including the magic powder
        ; 0xEA = Full Heart Container
        ; 0xEB = Quarter Heart Container
        ; 0xEC = Bushes
        ; 0xED = Cane of Somaria Platform
        ; 0xEE = Movable Mantle (in Hyrule Castle)
        ; 0xEF = Cane of Somaria Platform (same as 0xED but this index is not used)
        ; 0xF0 = Cane of Somaria Platform (same as 0xED but this index is not used)
        ; 0xF1 = Cane of Somaria Platform (same as 0xED but this index is not used)
        ; 0xF2 = Medallion Tablet

    ; $0E30[0x10] - (Sprite)        ; ; xxxyysss
        ; Subtype designation 1
        ; Is formed as follows: Take bits 5 and 6 from the sprite's Y coordinate byte and shift right twice.
        ; Then take bits 5, 6, and 7 from the X coordinate byte and shift right 5 times. This produces 000yyxxx.
        ; The bottom three bits cannot all be set at the same time or else we'll have an overlord instead.
        ; So if that wasn't the case we'd have 32 possible subtypes, but in lieu of the extra rule,
        ; 7, 15, 23, and 31 cannot be used. 
        ; A safe way to use this would be to just not use the bottom bit. (allows 16 subtypes)

    ; $0E40[0x10] - (Sprite)

        ; abcooooo

        ; o - If zero, the sprite is invisible. Otherwise, visible.
        ; (actually, it seems like this is the number of OAM sprite slots allocated to this sprite object)
        ; c - Causes enemies to go towards the walls? strange...
        ; b - No idea but the master sword ceremony sprites seem to use them....?
        ; a - If set, enemy is harmless. Otherwise you take damage from contact.

    ; $0E50[0x10] - (Sprite)
        ; Health / Hit Points of the sprite.

    ; $0E60[0x10] - (Sprite)
        ; niospppu
        ; n - If set, don't draw extra death animation sprites over the sprite as it
        ; is expiring.
        ; i - if set, sprite is impervious to all attacks (also collisions?)
        ; o - If set, adjust coordinates of sprites spawned off of this one, such
        ; as water splashes. In general this would roughly approximate the
        ; concept of 'width' of the sprite, and for this reason usually absorbable
        ; items like arrows, rupees, and heart refills utilize this.
        ; s - If set, draw a shadow for the sprite when doing OAM handling
        ; p - (Note: 3-bit) Palette into that actually is not used by this variable,
        ; but ends up getting copied to the array $0F50 (bitwise and with 0x0F).
        ; u - unused?
    ; $0E70[0x10] - 
        ; When a sprite is moving and has hit a wall, this gets set to the direction
        ; in which the collision occurred.
        ; ----udlr
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right
        ; These can be combined, but generally only orthogonal directions should be
        ; expected to appear simultaneously. Having a velocity that cause you to run
        ; into a wall on both your left and left and right at the same time would
        ; be considered strange at best, right? Maybe if you were Shroedinger's cat
        ; it would be plausible...
        ; The other bits are probably not used, but if they are it's probably due to
        ; some customized behavior.

    ; $0E80[0x10] - 
        ; Subtype designation 2 (varies from sprite to sprite though)

    ; $0E90[0x10] - 
        ; When a Pikit grabs something from you it gets stored here. 
        ; Used wildly differently between sprite types.
        ; Uncle - Used as main AI pointer?

    ; $0EA0[0x10] - (Sprite)
        ; Definitely closely tied to the process of a sprite taking damage. Seems to
        ; perhaps serve as a palette cycling index, or something like a state variable.
        ; When this value is positive
        ; 0x80 - Signal that the recoil process has finished and will terminate
        ; during this frame.

    ; $0EB0[0x10] - (Sprite) ; functions
        ; For sprites that are intuitively considered to have a head, this indicates
        ; the direction that the head is facing. It would seem that every humanoid
        ; sprite encountered so far uses this variable for that purpose, but I
        ; cannot guarantee that some sprites may use it for a different purpose.
        ; 0x00 - up
        ; 0x01 - down
        ; 0x02 - left
        ; 0x03 - right?    
    ; $0EC0[0x10] - (Sprite)
        ; Animation clock?

    ; $0ED0[0x10] - (Sprite)
        ; ???? (Used with sprite 0xBE)
        ; Giant Moldorm uses it too...
        ; Lanmolas use it too

    ; $0EE0[0x10] - (Sprite)
        ; Auxiliary delay timer 3

    ; $0EF0[0x10] - (Sprite)

        ; abbb bbbb:
        ; a        ; - start death timer?
        ; b*bb bbbb - death timer?       ; the amount of time that the sprite will have the flicker effect after taking damage.
        ; ; needs to be set for sprite to actually take damage or have other effect applied.
        ; ; the first bit * may also have another effect. seems to delay when the sprite starts flickering
    ; $0F00[0x10] - (Sprite)
        ; Pause button for sprites apparently. If nonzero they don't do anything.

    ; $0F10[0x10] - (Sprite)
        ; hhhh
        ; Auxiliary delay timer 4 (may be more proprietary than the others)

    ; $0F20[0x10] - (Sprite)
        ; Floor selector. Tells us which floor each sprite is on (in multilevel rooms)

    ; $0F30[0x10] - (Sprite)
        ; Seems to be the Y velocity of the sprite when recoiling from being hit.

    ; $0F40[0x10] - (Sprite)
        ; Seems to be the X velocity of the sprite when recoiling from being hit.

    ; $0F50[0x10] - (Sprite)
        ; The layout of this variable is the same as the 4th byte of each OAM entry.
        ; That is,
        ; vhoopppN
        ; v - vflip
        ; h - hflip
        ; o - priority
        ; p - palette
        ; N - name table
        ; The 'N' bit operates as the the top bit of the CHR index in our case,
        ; because the game has the two name tables placed consecutively in VRAM.

    ; $0F60[0x10] - (Sprite)
        ; isphhhhh
        ; i - Ignore collision settings and always check tile interaction on the same
        ; layer that the sprite is on.
        ; s - 'Statis'. If set, indicates that the sprite should not be considered as
        ; "alive" in routines that try to check that property. Functionally, the
        ; sprites might not actually be considered to be in statis though.
        ; 
        ; Example: Bubbles (aka Fire Fairys) are not considered alive for the
        ; purposes of puzzles, because it's not expected that you always have
        ; the resources to kill them. Thus, they always have this bit set.
        ; p - 'Persist' If set, keeps the sprite from being deactivated from being
        ; too far offscreen from the camera. The sprite will continue to move and
        ; interact with the game map and other sprites that are also active.
        ; h - 5-bit value selecting the sprite's hitbox dimensions and perhaps other
        ; related parameters.

    ; $0F70[0x10] - (Sprite)
        ; Height value (how far the enemy is from its shadow)

    ; $0F80[0x10] - (Sprite)
        ; Auxiliary Timer 4
        ; ^ Why was it labeled this? Haven't seen an instance of it being used.
        ; What I have seen is a lot of usage as it being the altitude velocity,
        ; and in fact I think that this is a more correct interpretation. Some sprites
        ; may use this for something else, but they're probably in the minority.

    ; $0F90[0x10] - (Sprite)
        ; Subpixel portion of altitude.

    ; $0FA0[0x01] - (Sprite)
        ; When a special effect is executing, its index is stored here (0 to 0x0D)
        ; Also applies to sprites and perhaps other similar types of objects.
        ; Would require more research to verify.

    ; $0FA1[0x01] - 

        ; Accumulator for generating random numbers. Each time a ranom number is generated,
        ; the current low byte of the h count (ppu) plus the frame index ($1a) is added to this variable
        ; and then stored back to this variable. The resultant value of this variable is the
        ; random number that ultimately gets returned.

    ; $0FA2 - 
        ; Free RAM

    ; $0FA5[0x01] - 
        ; Tile type for sprite / tile interactions
        ; (Used on a temporary basis for ancillary objects)

    ; $0FA6 - 
        ; Free RAM

    ; $0FA8 - 
        ; Screen relative X coordinate of a sprite (only lowest 8 bits)
    ; $0FA9 - 
        ; Screen relative Y coordinate of a sprite (only lowest 8 bits)

    ; $0FAA - 
        ; ????

    ; $0FAB[0x01] - 
        ; ????

    ; $0FAC[0x01] - (RepulseSpark)
        ; Controls the animation state of the repulse spark ancillary object.
        ; This is always set to 0x05 and then gradually counts down and then the
        ; repulse spark becomes deactivated at value 0. Also, There is only WRAM 
        ; allocated for one repulse spark at any given time.
        ; Technically, this can be set to higher values, but all it does is induce
        ; higher waiting time before the repulse spark resolves and disappears.

    ; $0FAD[0x01] - (RepulseSpark)
        ; Low byte of repulse spark X coordainte. There is no corresponding high
        ; byte variable.

    ; $0FAE[0x01] - (RepulseSpark)
        ; Low byte of repulse spark Y coordainte. There is no corresponding high
        ; byte variable.

    ; $0FAF[0x01] - (RepulseSpark)
        ; Delay timer between animation states of the repulse spark. When it expires,
        ; it is reset to 0x01 if the repulse spark still has animation frames to
        ; cycle through.

    ; $0FB0 - 
        ; Used to offset the high byte of pixel addresses in rooms. (X coord)
    ; $0FB1 - 
        ; Used to offset the high byte of pixel addresses in rooms. (Y coord)

    ; $0FB2[0x01] - (Player)
        ; Seems to be a debug read location, as it is never read, other than when
        ; being pushed to the stack along side its brother, $7E0314. (Their values
        ; always are the same).

    ; $0FB3 - 
        ; Corresponds to sort sprites in Hyrule Magic

    ; $0FB4[0x01] - (Garnish)
        ; Acts as a flag to indicate that there may be Garnish objects active on
        ; screen. This is not set low until the load of the next room or area, or
        ; similar circumstance like warping. Its numerical value is not important,
        ; so as long as it's nonzero, Garnish objects will be handled.
        ; Hence, they could be "paused", technically, by setting this to zero
        ; temporarily.

    ; $0FB5[0x01] - 
        ; used in constructing special designation $0E30[]. Two most significant bits
        ; of the value. also used in calculating sprite damage.
        ; ; $0DD0[] is stored here on a temporary basis.

    ; $0FB6 - 
        ; used in construction of special designation $0E30[]. Three least significant bits of the value. 

    ; $0FB7[0x01] - 
        ; Seems to have something to do with sprite behavior that
        ; alternates between two options every otehr frame.

    ; $0FB8 - 
        ; ????

    ; $0FBA - 
        ; ????

    ; $0FBC - 
        ; Sprite collisions? (????)

    ; $0FBE - 
        ; ????

    ; $0FBF - 
        ; Holds base upper byte of current overworld area's coordinates
        ; (Warning: I think this is gravely mistaken, perhaps
        ; documentation that is correct, but for the wrong address)
        ; 
    ; $0FC0 - 
        ; Free RAM - RESERVED BY ZS used to keep track of which animated tile GFX set is currently being used.

    ; $0FC1[0x01] - 
        ; Set to one during Desert Palace / Book of Mudora sequence. Maybe has uses
        ; in other sequences. Seems to freeze sprites. Could have uses in making a
        ; scripting system.

    ; $0FC2[0x02] - (Player)
        ; Link's X-Coordinate (See $22)

    ; $0FC4[0x02] - (Player)
        ; Link's Y-Coordinate (See $20)

    ; $0FC6[0x01] - 
        ; Only time this ever gets written with a nontrivial value is from $0AAA,
        ; which is also a poorly understood variable. It seems that certain sprites
        ; depend upon this variable in order to be drawn properly. In other words,
        ; it seems to indicate which graphics half slot has been loaded.

    ; $0FC7[0x10] - 
        ; ???? Affects something to do with prizes... is this length
        ; correct? I'm not sure, but it seems logical given that it
        ; interacts with sprite slots, of which there are also 0x10.
        ; \task Find out what the index affects. Perhaps some of this is Free RAM.
        ; 

    ; $0FD7 - 
        ; The code that writes and reads this variable is not enabled.
        ; For this reason it is considered a debug or "cheat" variable.
        ; When the value is odd, the game is frozen. The sprites that are
        ; on screen will stay on screen. Technically you could consider
        ; this Free RAM, unless you reenable the frame skipping debug
        ; functionality.

    ; $0FD8[0x02] - (Sprite)
        ; Cached 16-bit version of the current sprite's X coordinate.

    ; $0FDA[0x02] - (Sprite)
        ; Cached 16-bit version of the current sprite's Y coordinate.

    ; $0FDC[0x01] - (Sprite)
        ; Alert flag that activates "searching" enemies like soldiers.
        ; usually in response to a sound effect.
        ; 0 or 3, when 3 counts down to zero. This is nonzero when a projectile hits
        ; a wall.

    ; $0FDD - 
        ; ????

    ; $0FDE[0x02] - (Overlord)
        ; When using an Overlord of type 0x00, it advertises its index by writing
        ; it to this location. Sprites that need a reference point to go towards,
        ; such as the Old Snitch Lady and the Old Man on the Mountain, will use this
        ; index to look up the coordinates of the Overlord, and travel towards it.
    ; $0FE0[0x0C] - (Oam)
        ; Current position in each of the 6 different reserved areas of the OAM table.
    ; $0FE2 - occurs specifically in module 1A. (Maybe a hardcoded usage of the preceding variable.)

    ; $0FEC[0x0C] - (Oam)
        ; Also has something to do with the OAM table allocation mechanism. Needs more
        ; research!!!!

    ; $0FF8[0x01] - 
        ; Number of boss components left in a room? (e.g. Armos Knights)

    ; $0FF9[0x01] - (Sprite)
        ; When set to a nonzero value, the sprite subsystem will rapidly do palette
        ; filtering on the BGs to make a flashing affect that alternates between
        ; normal palettes and a much brighter, white set of palettes.
        ; This is a countdown timer, so the filtering effect will cease when it
        ; expires.

    ; $0FFA[0x01] - 
        ; When a screen transition occurs in the overworld or indoors,
        ; this is set to the value of the variable $1B
        ; Sprites are cached and reloaded from adjacent rooms only indoors,
        ; so this serves the purpose of letting the game know to not reload
        ; cached sprites during a screen transition.

    ; $0FFB - 
        ; Zeroed in one location, but doesn't seem to be used otherwise.
        ; Thus, Free RAM, technically.

    ; $0FFC[0x01] - (Player)
        ; If set, Link can't bring up his menu.

    ; $0FFD - 
        ; ????
    ; $0FFF - 
        ; Indicates whether you are in the light world or dark world (0,1 respectively)

    ; ===========================================================================
    ; Pages 0x10 to 0x17
    ; ===========================================================================

    ; $1000[0x0980] - Placeholder just to indicate the overall buffer size for now.

    ; $1000 - 
        ; For transfers that use variable $14, this indicates the current
        ; length written into the buffer starting at $1002. Seems to be
        ; addresses used for blitting graphics onto the screen after a
        ; room or area has already loaded.

    ; $1002 - 
        ; Big endian representation of the (word addressed) VRAM target
        ; address.

    ; $1004 - 
        ; DMA configuration

        ; ssssssss wftttttt
        ; 
        ; f - If set, DMA source address is fixed. Otherwise it auto increments.
        ; 
        ; s, t - One less(!) the 14-bit size of the DMA transfer, as expressed in bytes.
        ; This value is composed of the 's' and 't' bits thusly:
        ; 
        ; 00ttttttssssssss
        ; 
        ; w - If not set, VRAM target address increments on writes to $2118.
        ; Otherwise, it increments on writes to $2119.
        ; ^ This documention is not 100% correct. I'll fix it when I have time.
        ; Basically it determines whether or not to increment VRAM address by 1 or 32 words
        ; after each adjustment (write to $2118 or $2119)

    ; $1006 - 
        ; First word of data for the transfer. Many more may follow.



    ; Setup for making overlaid tiles appear (word addresses):

    ; Notes on converting in game tile positions into VRAM positions:

    ; In game layout: (u = unused?)       uuddaaaa abcccccc
    ; Translated into VRAM base address:  uuuddbaa aaaccccc

    ; $1100 - 
        ; Target VRAM address for the transfer

    ; $1102 - 
        ; The value that will be written to VMAINC ($2115) before the
        ; transfer. Typically this controls whether the DMA transfer is
        ; intended to write words or alternating bytes to VRAM.

    ; $1103 - 
        ; Number of bytes to transfer to VRAM. Note that putting 0 here would transfer 0x10000
        ; bytes, which could be really crazy.

    ; $1104 - 
        ; Local portion of the source address for the DMA transfer. The source bank is
        ; forced to zero by the code.

    ; $1100 - Contains two chunks of data for blitting an extra tile to the screen.
        ; The hex values indicate where each portion lies in the memory address.

        ; 0x8000 - indicates whether to use 2 byte or 64 byte increment when doing the DMA
        ; 0x4000 - ? not used?
        ; 0x3FFF - Contains the number of bytes to transfer


    ; $1102 - 
        ; VRAM target address for the tile setup.
    ; $1104 - 
        ; $1183 - The bytes that get blitted to VRAM

    ; $1980[0x20] - (Dungeon)
        ; Low Byte:  Door type (Take HM type number, convert to hex, and multiply by 2)
        ; High Byte: Door direction (0 = up, 2 = down, 4 = right, 6 = left)
        ; 
    ; $19A0 - 
        ; Door tilemap address

    ; $19B0 - 
        ; For doors that have two halves, this is the tilemap address for the other half

    ; $19C0 - 
        ; Door direction. 0 - up, 1 - down, 2 - left, 3 - right

    ; $19E0 - 
        ; current door index when loading doors
    ; $19E2 - 
        ; Seems to store the addresses of up to 4 different exit doors.

    ; $19EA - 
        ; Free RAM

    ; $1A00[0x14] - (Tagalong)
        ; Low bytes of tagalong states' Y coordinates.

    ; $1A14[0x14] - (Tagalong)
        ; High bytes of tagalong states' Y coordinates.

    ; $1A28[0x14] - (Tagalong)
        ; Low bytes of tagalong states' X coordinates.

    ; $1A3C[0x14] - (Tagalong)
        ; High bytes of tagalong states' X coordinates.

    ; $1A50[0x14] - (Tagalong)
        ; Altitudes of tagalong states.

    ; $1A64[0x14] - (Tagalong)
        ; Priority bits (layer, really), and direction in the lowest 2 bits.

    ; $1A78 - 
        ; Free RAM (tentative, but pretty sure)

    ; $1AB0 - 
        ; ???? Bird travel related?

    ; $1AC0 - 
        ; ???? Bird travel related?

    ; $1AD0 - 
        ; ???? Bird travel related?

    ; $1AE0[0x10] - 
        ; ???? Bird travel related?

    ; $1AF0[0x10] - 
        ; ???? Bird travel related? ; Index of the selected location. 0-7

    ; $1B00[0x1C0] - (HDMA)
        ; Indirect HDMA pointers for the spotlights that open and close
        ; when leaving / entering doors and for the mirror warp wavyness.

    ; $1CC0 - 
        ; Free RAM

    ; Text related variables ($1CD0[0x20])

    ; $1CD0 - 
        ; When drawing the message box border, the value of $1CD2 gets
        ; stored here during initialization. It is subsequently used a
        ; an index for forming DMA transfers that will copy the tilemap
        ; entries of the message box border during the NMI interrupt.

    ; $1CD2 - 
        ; The VRAM position of upper left corner of the message box.
        ; This only has one of two values, and they are designed to not
        ; obscure Link's sprite.

    ; $1CD4 - 
        ; Second Level controller for Module 0x0E.0x02
    ; $1CD5 - 
        ; Maybe the current position the message is outputting to?

    ; $1CD5 - 
        ; Mirror of speed below... but... not sure why this is different
    ; $1CD6 - 
        ; Speed XX
    ; $1CD7 - 
        ; ???? related to [window 01] (not used in game)

    ; $1CD8 - 
        ; First Level controller for Module 0x0E.0x02 (i.e. it controls
        ; the sub-submodule)

    ; $1CD9 - 
        ; Number of bytes into the $7F1200 buffer for the processed
        ; characters of the dialogue.

    ; $1CDB - 
        ; Free RAM

    ; $1CDC - 
        ; This is supposedly some kind of color variable according to Hyrule Magic
        ; but I can't find any affect to using it. It's modified by the [Color XX] command in the monologue editor.
        ; This was included presumably before they implemented a VWF, and used single or double spaced characters?
        ; The reasoning being, with such a font you can set the colors for individual characters much more easily.
        ; With 2bpp font characters you don't have a lot of available variety for colors in a single tile anyways.

    ; $1CDD - 
        ; Number of bytes into the source buffer for the dialogue message.
    ; $1CDD[0x02] - (alternate) - once the text begins being processed, this is instead the tile position for the output
        ; 0x00 is the first line, 0x28 is the second line, 0x50 is the third line

    ; $1CDF - 
        ; Used in [Scroll] command, not sure what else

    ; $1CE0 - 
        ; ???? referenced in [Wait XX]

    ; $1CE2 - 
        ; Is the template for the text message's tilemap. Each character has a tilemap value that differs only in CHR
        ; [Color XX] can change the palette (out of 8) obviously.
        ; Changing this value can also alter the h-flip and v-flip, as 
        ; well as priority settings. Generally speaking you wouldn't want to do that unless you had a good reason.

    ; $1CE4 - 
        ; Free RAM

    ; $1CE6 - 
        ; Perhaps this is the graphical position of where the next character goes?

    ; $1CE8 - 
        ; For a multi selection box with two choices, this is either 0 (the top choice) or 1 (the bottom choice)

    ; $1CE9 - 
        ; This is a delay timer for the [WaitKey] command. Starts at 0x1C, when it counts down to zero
        ; it starts looking for player input. (basically this is 1/3 of a second and is probably there to
        ; give the game more time to draw its text

    ; $1CEA - 
        ; Determines how many times to scroll the text up by one pixel per frame
        ; Only applies during the [Scroll] command and is set by the [ScrollSpd XX] 
        ; command. However, some other commands may inadvertently affect this address.
        ; E.g. [Name], [Position XX]. As there is no logical connection I can only guess 
        ; that this was a coding oversight.

    ; $1CF0 - 
        ; Dialogue Message Index. e.g. 0005 = "you can't enter with something following you"
        ; This is the same numerical value that can be viewed in Hyrule Magic 
        ; (except there they're in decimal.)

    ; $1CF2 - 
        ; Numeric parameter that can be passed to text messages. It goes as follows.
        ; first byte: low nybble corresponds to [Number 00], high nybble to [Number 01]
        ; second byte: low nybble is [Number 02], high nybble is [Number 03]
        ; If you're confused see message number 004 in Hyrule Magic's dialogue editor.

    ; $1CF4 - 
        ; Used to save the value of $1CE8 when the save and continue box comes up

    ; $1CF5 - 
        ; Free RAM

    ; $1D00 - 
        ; Cache for $0DD0

    ; $1D10 - 
        ; Cache for $0E20

    ; $1D20 - 
        ; Cache for $0D10
    ; $1D30 - 
        ; Cache for $0D30
    ; $1D40 - 
        ; Cache for $0D00
    ; $1D50 - 
        ; Cache for $0D20

    ; $1D60 - 
        ; Cache for $0DC0

    ; $1D70 - 
        ; Cache for $0D90
    ; $1D80 - 
        ; Cache for $0EB0
    ; $1D90 - 
        ; Cache for $0F50
    ; $1DA0 - 
        ; Cache for $0B89
    ; $1DB0 - 
        ; Cache for $0DE0
    ; $1DC0 - 
        ; Cache for $0E40
    ; $1DD0 - 
        ; Cache for $0F20
    ; $1DE0 - 
        ; Cache for $0D80
    ; $1DF0 - 
        ; Cache for $0E60


    ; $1E00 - 
        ; Step counter during the Triforce sequence at the beginning.

    ; $1E01 - 
        ; ????

    ; $1E02 - 
        ; ????

    ; $1E03 - 
        ; Free RAM

    ; $1E08 - 
        ; see module 0x14
    ; $1E09 - 
        ; see module 0x14

    ; $1E0A - 
        ; Seems to be a frame counter (loops at 0xFF) used for various delays and timing 
        ; of events during the Triforce or Crystal sequences

    ; $1E0B - 
        ; Free RAM

    ; $1E0C - 
        ; ????

    ; $1E0E - 
        ; Free RAM

    ; $1E10[0x08] - (Intro)

    ; $1E18[0x08] - (Intro)

    ; $1E20[0x08] - (Intro) ????

    ; $1E28[0x08] - (Intro) ????

    ; $1E30[0x08] - (Intro) ????

    ; $1E38[0x08] - (Intro) ????

    ; $1E40[0x08] - (Intro) ????

    ; $1E48[0x08] - (Intro) ????

    ; $1E50[0x08] - (Intro) ????

    ; $1E58[0x08] - (Intro) ????

    ; $1E60[0x08] - (Intro) ????

    ; $1E68 - 
        ; Free RAM???

    ; $1F00[0x01] - (Polyhedral) 

        ; Flag that, when set, tells IRQ to activate.

    ; $1F01[0x01] - 

    ; $1F08[0x02] - (Polyhedral)

        ; ????

    ; $1F0A[0x02] - (IRQ / Main)

        ; Stores the stack pointer of the thread that is currently
        ; inactive (main thread or polyhedral graphics helper thread).

    ; $1F0C[0x01] - (Polyhedral)

        ; Flag that, when set, tells NMI to update the sprite region used
        ; for the IRQ's polygonal graphics. That is, the triforce
        ; triangle or the maiden crystals.

    ; $1F32-$1F3E - 
        ; Contains data to use when coming out of the IRQ. Including a return address,
        ; the Data Bank Register, the Direct Page register (gets set to $1F00), and
        ; various other data. It took a while to figure this out, believe me.

    ; $1F3F[0x0?] -	Unknown usage.

    ; $1F58[0x02] - (Polyhedral)
        ; ????

    ; $1F5A[0x02] - (Polyhedral)
        ; ????
    ; $1F5C[0x02] - (Polyhedral)
        ; ????
    ; $1F5E[0x02] - (Polyhedral)
        ; ????

    ; $2115: Video Port Control (1b/W)

        ; i---ffrr  i: 0=increment when $2118 or $2139 is accessed
        ; 1=increment when $2119 or $213A is accessed
        ; f: full graphic (?)
        ; r: increment rate:  00=Increment by 2 bytes   (1x1)
        ; 01=Increment by 64 bytes  (32x32)
        ; 10=Increment by 128 bytes (64x64)
        ; 11=Increment by 256 bytes (128x128)

        ; This register controls the way data is uploaded to VRAM.  The bits in here are a bit weird, but can be useful.  When you want to change only the high byte of a series of VRAM locations (register $2116 * 2 + 1), you should set i to 1.  When you want to change just the low byte, set i to 0.  When you want to write a whole word, you should set i to 0; otherwise, if i=1, writing a word will cause the high byte of the first location to be changed, followed by the low byte of the next location.

        ; The r bits control the number of bytes by which the VRAM address pointer gets incremented upon a read or write (see table.) 

    ; $2118/$2119: VRAM data write (2b/W)

        ; dddddddd dddddddd  d: data to write to VRAM

        ; When written, this register writes a byte or word to VRAM.  The address is incremented (or not, as the case may be) according to register $2115. 

    ; ===========================================================================
    ; Start of unmirrored WRAM
    ; ===========================================================================

    ; Tile Tilemap Format: Vhopppcc cccccccc

    ; Overworld:
    ; $7E2000[0x2000] - Map16 tile data for the overworld. Supports up to 1024x1024 pixels of tiles
    ; Note that this is handled somewhat differently than the Map8 data in the dungeons which supports up to 512x512

    ; Dungeons:
    ; $7E2000[0x2000] - when loading dungeon graphics, contains the (map8) tilemap for BG2.

    ; $7E4000[0x2000] - when loading dungeon graphics, contains the (map8) tilemap for BG1.

        ; A note about these tilemap representations:
        ; These are the tilemaps but not exactly as they would linearly appear in VRAM.
        ; These maps are stored as the whole 512x512 pixel screen, line by line. The first
        ; ; $80 bytes contains the top line of the picture as it appears to us. The second $80 bytes 
        ; represents the second line of the picture as it appears to us, etc. In VRAM, however,
        ; The tile indices are stored by quadrant of the screen. Thus, the algorithm to convert the
        ; address of a tile in this map to one in VRAM is:
        ; int B = tilemap_address;
        ; int Y = 0; // Y will be the resulting VRAM offset
        ; if(B & 0x1000) // Is this tile in the lower two quadrants?
        ; {
        ; // YES!
        ; 
        ; Y += 0x1000;
        ; B ^= 0x1000; // Tells us to ignore this bit in the proceeding calculations.
        ; }
        ; if(B & 0x40) // Is this tile in a right hand quadrant?
        ; {
        ; // YES!
        ; 
        ; Y += 0x800;
        ; B ^= 0x040; // The ^ symbol is XOR, in case you didn't know.
        ; }
        ; Y += (B - ((B & 0xFF80) >> 1));
        ; Keep in mind these aren't real addresses, just offsets into respective arrays in
        ; WRAM and VRAM. e.g. X or Y registers would be the offset in WRAM and your DMA 
        ; controls registers would handle the problem for DMA.
        ; WRAM  -> VRAM
        ; $0    -> $0 
        ; $40   -> $800
        ; $80   -> $40
        ; $C0   -> $840
        ; $100  -> $80
        ; $140  -> $880
        ; $180  -> $C0
        ; $1C0  -> $8C0
        ; $280-$2BF -> $140-$17F
        ; ...       -> ...
        ; $1000 -> $1000
        ; $1040 -> $1800
        ; $1080 -> $1040
        ; $10C0 -> $1840
        ; etc.  -> etc.

    ; $7E6000[0x3000] - Scratch space where decompressed data is stored temporarily

    ; $7E9000[0x2E00] - Buffer for an assortment of tiles that need to change appearance

        ; ; $7E9000[0x300] - 24 Sword tiles
        ; ; $7E9300[0x180] - 12 Shield tiles
        ; ; $7E9480[0x1C0] - 14 Ice / Fire Rod tiles
        ; ; $7E9640[0x1C0] - 14 Hammer tiles
        ; ; $7E9800[0xC0]  - 6 Bow tiles
        ; ; $7E98C0[0x100] - 8 Shovel tiles
        ; ; $7E99C0[0x100] - 8 Tiles (Sleep 'Z's, Musical notes, two unknown tiles)
        ; ; $7E9AC0[0x100] - 8 Hookshot tiles
        ; ; $7E9BC0[0x380] - 28 Bug Net tiles
        ; ; $7E9F40[0x1C0] - 14 Cane tiles (Byrna and Somaria)
        ; ; $7EA100[0x80]  - 4 Book of Mudora tiles
        ; ; $7EA180[0x300] - 24 unused tiles (Free RAM)
        ; ; $7EA480[0x200] - 16 Push Block tiles
        ; ; $7EA680[0x400] - Animated BG tiles for step 0
        ; ; $7EAA80[0x400] - Animated BG tiles for step 1
        ; ; $7EAE80[0x400] - Animated BG tiles for step 2
        ; ; $7EB280[0xC0]  - Sprite tiles for rupee animation (3 steps)
        ; ; $7EB340[0x200] - Tiles for the steps that animate the barrier tiles going up and down
        ; ; $7EB540[0x400] - Sprite tiles for bird and thief's chest
        ; ; $7EB940[0x400] - Tagalong graphics, room for 8 16x16 sprites (32 8x8 tiles)
        ; ; $7EBD40[0x80]  - Sprite tiles for receive item (4 8x8 tiles)
        ; ; $7EBDC0[0x40]  - Star tiles (part of animated tiles, consists of 2 8x8 tiles)

    ; $7EBE00[0x200] - possibly Free RAM

    ; Values related to Dungeon Headers:

    ; $7EC000 - 
        ; The dungeon header can have up to five destinations for you to travel to 
    ; $7EC001 - 
        ; These five addresses ($7EC000-$7EC004) hold the room numbers of these
    ; $7EC002 - 
        ; destinations. Note that you can only use this for rooms with numbers
    ; $7EC003 - 
        ; Less than 256.
    ; $7EC004[0x01] - 

    ; $7EC005 - 
        ; Tells us whether to do a "lights out" before room transitioning.

    ; $7EC006 - 
        ; Mirror for $7EC005. Chains things along really. If the last room
        ; had the "lights out" property, then when I return to it it
        ; should also, right?

    ; $7EC007[0x02] - 
        ; Related to $7EC011 in that it helps control the mosaic level as
        ; well as the stages of color filtering during
        ; a mosaic transition (forest to normal ow, etc)

    ; $7EC009[0x02] - 
        ; 0 when darkening the screen, 2 when lightening the screen (during color filtering)

    ; $7EC00B - 
        ; The target level of color filtering and mosaic for $7EC007 during mosaic screen transitions

    ; $7EC00D - 
        ; Countdown timer that, when it reaches zero, changes the set of tiles used in BG tile animation.
        ; Normally starts at 9 and changes at 0, but according to the code can start at 0x17 if certain overlays
        ; are used. It haven't been verified that those overlay numbers actually are used in the game, though.

    ; $7EC00F - 
        ; Determines which frame of animation to use for animated tiles. Range: $0 - $800, 
        ; ($400 increment)

    ; $7EC011 - 
        ; Mosaic "level" in screen transitions transitions.

    ; $7EC012 - 
        ; Only zeroed at one location, could be considered Free RAM if
        ; that is disabled. (The zeroing is done with $7EC011 in 16-bit
        ; mode.)

    ; $7EC013 - 
        ; Rupee sprite tile animation timer? (countdown)

    ; $7EC015 - 
        ; ????

    ; $7EC017 - 
        ; ???? Linked to $045A seems to determine fixed color +/-

    ; $7EC018 - 
        ; Free RAM

    ; $7EC019[0x06] - 
        ; Array of palette filter settings that get temporarily stored to $7EC007 for Agahnim's sprite.
    ; $7EC01F[0x06] - 
        ; Array of palette filter settings that get temporarily stored to $7EC007 for Agahnim's sprite.

    ; $7EC025 - 
        ; Free RAM

    ; $7EC100 - 
        ; Mirror of $040A

    ; $7EC102 - 
        ; Mirror of $1C

    ; $7EC104 - 
        ; Mirror of $E8
    ; $7EC106 - 
        ; Mirror of $E2

    ; $7EC108 - 
        ; Mirror of $20
    ; $7EC10A - 
        ; Mirror of $22

    ; $7EC10C - 
        ; Mirror of $8A ; is this wrong? I don't ever see it changing.
    ; $7EC10E - 
        ; Mirror of $84

    ; $7EC110 - 
        ; Mirror of $0618
    ; $7EC112 - 
        ; Mirror of $061C
    ; $7EC114 - 
        ; Mirror of $0600
    ; $7EC116 - 
        ; Mirror of $0602
    ; $7EC118 - 
        ; Mirror of $0604
    ; $7EC11A - 
        ; Mirror of $0606
    ; $7EC11C - 
        ; Mirror of $0610
    ; $7EC11E - 
        ; Mirror of $0612
    ; $7EC120 - 
        ; Mirror of $0614
    ; $7EC122 - 
        ; Mirror of $0616

    ; $7EC124 - 
        ; Mirror of $0AA0
    ; $7EC125 - 
        ; Mirror of $0AA1
    ; $7EC126 - 
        ; Mirror of $0AA2
    ; $7EC127 - 
        ; Mirror of $0AA3

    ; $7EC128 - 
        ; Free RAM?

    ; $7EC12A - 
        ; Mirror of $0624
    ; $7EC12C - 
        ; Mirror of $0626
    ; $7EC12E - 
        ; Mirror of $0628
    ; $7EC130 - 
        ; Mirror of $062A

    ; $7EC132 - 
        ; Free RAM?

    ; $7EC140 - 
        ; Mirror of $040A, alternate overworld area number

    ; $7EC142 - 
        ; Mirror of $1C
    ; $7EC143 - 
        ; Mirror of $1D

    ; $7EC144 - 
        ; Mirror of $00E8, BG1 V scroll value
    ; $7EC146 - 
        ; Mirror of $00E2, BG1 H scroll value

    ; $7EC148 - 
        ; Mirror of $0020, Link's Y coordinate
    ; $7EC14A - 
        ; Mirror of $0022, Link's X coordinate

    ; $7EC14C - 
        ; Mirror of $008A, overworld area number 
    ; $7EC14E - 
        ; Mirror of $0084, ????

    ; $7EC150 - 
        ; Mirror of $0618, Camera's Y coordinate lower bound
    ; $7EC152 - 
        ; Mirror of $061C, Camera's X coordinate lower bound
    ; $7EC154 - 
        ; Mirror of $0600
    ; $7EC156 - 
        ; Mirror of $0602
    ; $7EC158 - 
        ; Mirror of $0604
    ; $7EC15A - 
        ; Mirror of $0606
    ; $7EC15C - 
        ; Mirror of $0610
    ; $7EC15E - 
        ; Mirror of $0612
    ; $7EC160 - 
        ; Mirror of $0614
    ; $7EC162 - 
        ; Mirror of $0616

    ; $7EC164 - 
        ; Mirror of $0AA0
    ; $7EC165 - 
        ; Mirror of $0AA1, (blockset for dungeon entrance)
    ; $7EC166 - 
        ; Mirror of $0AA2
    ; $7EC167 - 
        ; Mirror of $0AA3

    ; $7EC168 - 
        ; ???? See pre dungeon mode
    ; $7EC16A - 
        ; Mirror of $0624
    ; $7EC16C - 
        ; Mirror of $0626
    ; $7EC16E - 
        ; Mirror of $0628
    ; $7EC170 - 
        ; Mirror of $062A
    ; $7EC172 - 
        ; Orange/blue barrier state
    ; $7EC174 - 
        ; Mirror of $86
    ; $7EC176 - 
        ; Mirror of $88
    ; $7EC178 - 
        ; Free RAM?

    ; $7EC180 - 
        ; Mirror of $E2
    ; $7EC182 - 
        ; Mirror of $E8
    ; $7EC184 - 
        ; Mirror of $20
    ; $7EC186 - 
        ; Mirror of $22

    ; $7EC188 - 
        ; Mirror of $0600
    ; $7EC18A - 
        ; Mirror of $0604
    ; $7EC18C - 
        ; Mirror of $0608
    ; $7EC18E - 
        ; Mirror of $060C
    ; $7EC190 - 
        ; Mirror of $0610
    ; $7EC192 - 
        ; Mirror of $0612
    ; $7EC194 - 
        ; Mirror of $0614
    ; $7EC196 - 
        ; Mirror of $0616
    ; $7EC198 - 
        ; Mirror of $0618
    ; $7EC19A - 
        ; Mirror of $061C

    ; $7EC19C - 
        ; Mirror of $A6
    ; $7EC19E - 
        ; Mirror of $A9

    ; $7EC1A0 - 
        ; Free RAM?

    ; $7EC1A6 - 
        ; Mirror of $2F
    ; $7EC1A8 - 
        ; Mirror of $0476
    ; $7EC1AA - 
        ; Mirror of $A4

    ; $7EC1AC - 
        ; Free RAM?

    ; $7EC200 - 
        ; Mirror of $E0
    ; $7EC202 - 
        ; Mirror of $E2
    ; $7EC204 - 
        ; Mirror of $E6
    ; $7EC206 - 
        ; Mirror of $E8

    ; $7EC208 - 
        ; Mirror of $0414

    ; $7EC209 - 
        ; Free RAM

    ; $7EC20A - 
        ; Mirror of $0AB6
    ; $7EC20B - 
        ; Mirror of $0AB8
    ; $7EC20C - 
        ; Mirror of $0AB7
    ; $7EC20D - 
        ; Free RAM?
    ; $7EC20E - 
        ; Mirror of $0AA1
    ; $7EC20F - 
        ; Mirror of $0AA3
    ; $7EC210 - 
        ; Mirror of $0AA2
    ; $7EC211 - 
        ; Mirror of $1C
    ; $7EC212 - 
        ; Mirror of $1D

    ; $7EC213 - 
        ; Mirror of $8A ; Only written to when exiting a dungeon ; This is incorrect
        ; it is also written to on warp.
    ; $7EC215 - 
        ; Mirror of $84
    ; $7EC217 - 
        ; Mirror of $88
    ; $7EC219 - 
        ; Mirror of $86

    ; $7EC21B - 
        ; Mirror of $0418
    ; $7EC21D - 
        ; Mirror of $0410
    ; $7EC21F - 
        ; Mirror of $0416

    ; $7EC221 - 
        ; Mirror of $011A or $7EC007
    ; $7EC223 - 
        ; Mirror of $011C or $7EC009

    ; $7EC225 - 
        ; Mirror of $99
    ; $7EC226 - 
        ; Mirror of $9A

    ; $7EC227 - 
        ; Mirror of $0130
    ; $7EC228 - 
        ; Mirror of $0131

    ; $7EC229 - 
        ; Mirror of $9B

    ; $7EC22A - 
        ; Free RAM

    ; $7EC230 - 
        ; related to the VWF? $7EC22F might be part of this too...

    ; $7EC2F0 - 
        ; ???? Free RAM?

    ; These are set when new graphics are loaded using $0AA2
    ; $7EC2F8 - 
        ; Cached value for subset 0 of secondary bg graphics
    ; $7EC2F9 - 
        ; Cached value for subset 1 of secondary bg graphics
    ; $7EC2FA - 
        ; Cached value for subset 2 of secondary bg graphics
    ; $7EC2FB - 
        ; Cached value for subset 3 of secondary bg graphics

    ; These are set when new graphics are loaded using $0AA3
    ; $7EC2FC - 
        ; Sprite Graphics Subset 0
    ; $7EC2FD - 
        ; Sprite Graphics Subset 1
    ; $7EC2FE - 
        ; Sprite Graphics Subset 2
    ; $7EC2FF - 
        ; Sprite Graphics Subset 3

    ; $7EC300[0x200] - Auxiliary palette buffer. Probably used for manipulations of the palette that would be cause graphical glitches if applied every frame.

    ; $7EC500[0x200] - Main palette buffer (512 bytes) 
        ; Palette Data that will get written to CGRAM (512 bytes) whenever $7E0015 is nonzero.
        ; The following is a list of tile types found in each palette slot.
        ; Extra Info:
        ; (BP-<number> means background palette <number> and SP-<number> means sprite palette <number>.
        ; "first half" indicates the first 8 colors of a 4bpp palete, and "second half" indicates the latter 8 colors.
        ; Note, however, that the first color of the "first half" palettes are never actually displayed because the hardware treats them as transparent.
        ; HUD-<number> indicates a 4 color palette used with the 2bpp heads up display graphics. <number> ranges from 0 to 7.
        ; Again, only the last 3 colors are displayed as the first color in each HUD palette is considered transparent.
        ; Palettes are listed in order of appearance.)
        ; HUD-0        ;    - Arrow icon and blank item box.
        ; HUD-1        ;    - Numbers, hearts, the "Life" icon, and the Floor Indicator.
        ; HUD-2        ;    - Key icon, outline of magic bar and item box, and the two dashes on either side of the "Life" icon.
        ; Also the border of the dialogue window
        ; HUD-3        ;    - Bomb icon
        ; HUD-4        ;    - ????
        ; HUD-5        ;    - Pegasus boots on menu window
        ; HUD-6        ;    - Dialogue text,
        ; HUD-7        ;    - Magic meter (green) and rupee icon
        ; BP-2 (first half)   - Overworld:  Green / Tan ground, most of the rock and related colors on Death Mountain
        ; Dungeons:   Misc things in dungeons, like edges of pits, parts of doors, boundaries for doors, boundaries of torches
        ; BP-2 (second half)  - Overworld:  Houses, urns, tops of wooden gates, 
        ; Dungeons:   Walls / doors in dungeons, houses on overworld
        ; BP-3 (first half)   - Overworld:  Secondary ground color, borders of certain paths, like in desert.
        ; Dungeons:   Torches in dungeons, pots, statues, orange switch blocks
        ; BP-3 (second half)  - Overworld:  Statues, particular parts of rocks, paths and outlines of stone paths
        ; Dungeons:   Primary floor colors
        ; BP-4 (first half)   - Overworld:  particular parts of rocks
        ; Dungeons:   doorway statue in dungeons
        ; BP-4 (second half)  - Overworld:  Green trees, cacti
        ; Dungeons:   parallax floor below in dungeons, dungeon wall border, woods seen from high above on Death Mountain
        ; BP-5 (first half)   - Animated tiles in overworld, beds, chairs tables in indoors
        ; BP-5 (second half)  - Overworld:  Pathway in Kakkariko and shrub hedges, overlays using color addition (fog in forest, lava in dark world)
        ; Dungeons:   Dungeon entrance floor
        ; BP-6 (first half)   - Overworld:  Bushes, fences, grass, and the ground bushes and grass leave behind, signs
        ; Dungeons:   Chests, candles in fortune teller huts, blue switch blocks
        ; BP-6 (second half)  - Overworld:  Tower of Hera, some parts above doors, master sword platform, small trees, red trees, Sahasralah's house.
        ; Dungeons:   Rug in smithy house, BG1 floor
        ; BP-7 (first half)   - Pyramid of Power, Dark Palace, Blue House roofs, warp tiles / cloud tiles. Seems to be an important palette.
        ; Dungeon: and tiles related to chests tiles in dungeons
        ; BP-7 (second half)  - Overworld:  cloud tiles (some), rope bridges
        ; Dungeons:   Ceilings
        ; SP-0 (first half)   - Sanctuary and Hyrule Castle Mantle, old guy at the bar in Kakkariko's body,
        ; weird head looking things at the entrance to the Desert Palace, bombos and ether tablets, intro sword
        ; SP-0 (second half)  - heavy rocks
        ; SP-1 (first half)   - apples from trees, part of master sword beam, grass around your legs, off color bushes
        ; SP-1 (second half)  - red rupees, small hearts, red potion in shops, some shadows, link's bow
        ; SP-2 (first half)   - numerous ancillas (dash dush from boots, sparkles, death / transformation poof), warp whirlpool
        ; SP-2 (second half)  - blue rupees
        ; SP-3 (first half)   - red soldiers, bees, 
        ; SP-3 (second half)  - usually set to all dark grey colors, but can be swapped with SP-5 (second half)
        ; SP-4 (first half)   - fairys, blue soldiers, chickens, green soldier shields, crows, lumberjack saw
        ; SP-4 (second half)  - green rupees, green enemy bombs, some shadows, magic decanters
        ; SP-5 (first half)   - palette determined by $0AAD, so varies by area / room
        ; SP-5 (second half)  - Link's Sword (first three colors) and Shield (last four colors)
        ; SP-6 (first half)   - palette determined by $0AAE, so varies by area / room
        ; SP-6 (second half)  - throwable items like bushes, pots, rocks, signs, and the pieces all of those shatter into
        ; skulls that lurk in the ground under bushes
        ; SP-7 (full)        ;  - Link's body palette, including his glove color

    ; $7EC700[0x14A]  - The HUD tile indices buffer. (330 bytes)
        ; ; $7EC7F2 - 
        ; floor indicator (top two tiles)
        ; ; $7EC782 - 
        ; floor indicator (bottom two tiles)

    ; $7EC880[0x80]   - 
    ; $7EC900[0x1F00] - seemingly Free RAM (nearly 8K!)

    ; $7EE800[0x800]  - (Polyhedral)
        ; Buffer for 3D Triforce or crystal sprite graphics. The graphics are
        ; generated on the fly by the polyhedral thread when active.

    ; $7EF000[0x500] - Save Game Memory, which gets mapped to a slot in SRAM when
        ; you save your game. SRAM slots are at $70:0000, $70:0500,
        ; and $70:0A00. They are also mirrored in the next three
        ; slots. See the SRAM documentation for more details.

    ; $7EF500 - 
        ; Possibly Free RAM

    ; $7EF580[0x280] - (Dungeon) For items under pots, this keeps track of which ones have been revealed in a given room
        ; (array probably resets on reentrance to the dungeon or mirror usage)

    ; $7EF800[0x100] - 
        ; Stores the overworld tilemap address for a tile that has been modified.
        ; Seems to support up to 0x80 different tiles.
        ; At first I thought this was for knowing what to reinstate when the screen
        ; scrolls on larger overworld areas, but that doesn't seem to be the case.
        ; The index into this table is $04AC

    ; $7EF900 - 
        ; Free RAM?

    ; $7EF940[0x200] - (dungeon) moveable block data (persistent across rooms and only regenerates upon dungeon reentry or mirror)
        ; In the original game, only 0x18C of these bytes are filled with actual block data.
        ; Each block entry consists of 2 16-bit values:
        ; The first is the room that the block exists in.
        ; The second is the tilemap address of the block.
        ; If the tilemap address is from 0x0000 to 0x1FFF, then it's on BG2
        ; If it's from 0x2000 to 0x3FFF, the block is on BG1.
        ; This value is always anded with 0x3FFF, forcing the block to one BG or the other.

    ; $7EFA00[0x200] - (Overworld)
        ; Note that this clashes with the block data

    ; $7EFB40[0x180] - (dungeon) torch data (persistent across rooms)
        ; Each torch entry consists of 2 16-bit values:        ; 
        ; The first word is the room that the torch exists in.
        ; The second

    ; $7EFCC0 - 
        ;  Each byte is the sprite graphics set to use for each overworld area. 

    ; $7EFD40 - 
        ;  (Overworld)
        ; Each byte is the sprite palette set to use for each overworld area.

    ; $7EFDC0 - 
        ;  Free RAM?

    ; $7EFE00[0x200] - CHR to Tile Attribute table. Each byte tells the game how Link interacts with the each CHR type.
        ; After the tilemaps are created from loading objects,
        ; the game then uses this table to translate CHR values into behavior types, and creates behavior tables for BG1 and BG2.
        ; As an example, let's say the CHR value for a particular tile in the tilemap was 0x04.
        ; In this lookup table, that would be the 5th byte (since it starts at 0), and you'd find the behavior type for that CHR to be 0x02.
        ; CHR values 0x140 through 0x1BF are loaded with behaviors that vary depending on the current value of $0AA2, the secondary graphics index.
        ; See $7F2000 and $7F3000 for details on tile attributes in dungeons.
        ; Also see routine $0717D9 in the Banks files (if you have them) and $71659 in Zelda3_ROM.log.
}
endstruct

; ===============================================================================

struct WRAM $7F0000
{
    ; ===========================================================================
    ; Start of bank 0x7F
    ; ===========================================================================

    ; $7F0000[0x2000] -   (NMI)

        ; Decompression buffer for CHR updates.

    ; $7F0000[0x7E0] -    tile index buffer for text

    ; $7F0000[0x850] - no idea

    ; $7F07E0[???] - ????

    ; $7F1200[0x800] -    (Messaging) Text buffer for character data, using pointers
                        ; loaded from the table at $7F71C0


    ; $7F2000[0x2000] -   at some point carries the tile map data for the rain overlay.

    ; $7F2000[0x1000] -   (Dungeon)
        ; BG2 tile attribute/collision table - (after the level/room has loaded), tile information for the room/map.
        ; In particular tells the game how to handle each 8x8 tile.
        ; For example, a chest will have the value 0x58 (or something similar) in 4 different locations, interlaced of course.
        
        ; List of Tile types:
        
        ; 0x00 - normal?
        ; 0x01 - collide
        ; 0x02 - ???
        ; 0x03 - ???? what is this?
        
        ; 0x08 - swim / deep water
        ; 0x09 - shallow water (not swimmable)
        
        ; 0x0A - ????
        
        ; 0x0B - ???? 
        
        ; 0x0C - moving floor (Mothula's room)
        ; 0x0D - spike floor (hurts)
        ; 0x0E - ice floor
        ; 0x0F - more ice floor?
        
        ; 0x1C - top of water staircase
        ; 0x1D - in room staircase
        ; 0x1E - in room staircase
        ; 0x1F - in room staircase
        
        ; 0x20 - Pit / Hole tiles
        
        ; 0x21 - ????
        
        ; 0x22 - stairs that slow you down
        
        ; 0x23 - Lower half of trigger tile (Object 1.1.0x35 also uses it, but it seems like a broken mess)
        ; 0x24 - Upper half of trigger tile
        
        ; 0x26 - Boundary tile for In-floor inter-room staircases
        ; 0x27 - white statues (dungeons) / fences (overworld)
        
        ; 0x28 - Ledge leading up
        ; 0x29 - Ledge leading down
        ; 0x2A - Ledge leading left
        ; 0x2B - Ledge leading right
        ; 0x2C - Ledge leading up + left
        ; 0x2D - Ledge leading down + left
        ; 0x2E - Ledge leading up + right
        ; 0x2F - Ledge leading down + right
        
        ; 0x30 - Up Staircase to room 1  of 5
        ; 0x31 - Up Staircase to room 2 ( " )
        ; 0x32 - Up Staircase to room 3 ( " )
        ; 0x33 - Up Staircase to room 4 ( " )
        
        ; 0x34 - Down Staircase to room 1  of 5
        ; 0x35 - Down Staircase to room 2 ( " )
        ; 0x36 - Down Staircase to room 3 ( " )
        ; 0x37 - Down Staircase to room 4 ( " )
        
        ; 0x38 - Boundary tile for straight up inter-room staircases
        ; 0x39 - Boundary tile for sraightt up inter-room staircases
        
        ; 0x3A - Star switch tile
            ; (At load time, the inactive star tiles have this
            ; attribute, but once the state has swapped these tiles
            ; become active.)
            
        ; 0x3B - Star switch tile
            ; (Active star tiles have this attribute at load time.)
        
        ; 0x3C - ????
        
        ; 0x3D - inter-floor staircases?
        ; 0x3E - inter-floor staircases?
        ; 0x3F - inter-floor staircases?
        
        ; 0x40 - Thick Grass (and smashed in moles?)
        
        ; 0x42 - Gravestone
        
        ; 0x44 - Spike Block (dungeon) / Cactus (overworld)
        
        ; 0x48 - (overworld) Normal blank ground
        ; 0x4A - ????
        
        ; 0x4B - Orange Warp Tile (Dungeons) / Blue Warp Tile (Overworld)
        
        ; 0x4C - ????
        ; 0x4D - ????
        ; 0x4E - Mountain rock tile found in only a few select areas
        ; 0x4F - Mountaon rock tile found in only a few select areas
        
        ; 0x50 - (overworld) bush
        ; 0x51 - (overworld) off color bush
        ; 0x52 - (overworld) small light rock
        ; 0x53 - (overworld) small heavy rock
        ; 0x54 - (overworld) sign
        ; 0x55 - (overworld) large light rock
        ; 0x56 - (overworld) large heavy rock
        ; 0x57 - (overworld) rock pile
        
        ; 0x58 - chest 0
        ; 0x59 - chest 1
        ; 0x5A - chest 2
        ; 0x5B - chest 3
        ; 0x5C - chest 4
        ; 0x5D - chest 5
        
        ; 0x5E - upward staircase tile
        
        ; 0x61 - 
        
        ; 0x60 - Blue Rupee Tile (n.b. Not a sprite tile in this case!)
        
        ; 0x62 - bombable cracked floor
        
        ; 0x63 - minigame chests?
        
        ; 0x66 - blue / orange block that is down
        ; 0x67 - blue / orange block that is up
        
        ; 0x68 - conveyor belt
        ; 0x69 - conveyor belt
        ; 0x6A - conveyor belt
        ; 0x6B - conveyor belt
        
        ; 0x70 - pot or bush (or mole?)
        ; 0x71 - pot or bush
        ; 0x72 - pot or bush
        ; 0x73 - pot or bush
        ; 0x74 - pot or bush
        ; 0x75 - pot or bush
        ; 0x76 - pot or bush
        ; 0x77 - pot or bush
        ; 0x78 - pot or bush
        ; 0x79 - pot or bush
        ; 0x7A - pot or bush
        ; 0x7B - pot or bush
        ; 0x7C - pot or bush
        ; 0x7D - pot or bush
        ; 0x7E - pot or bush
        ; 0x7F - pot or bush
        
        ; 0x80 - open door?
        
        ; 0x89 - (dungeon) Room Link door
        
        ; 0x8E - (dungeon) Overworld Link door (exit to Overworld)
        ; 0x8E - (overworld) unused?
        
        ; 0x90 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x91 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x92 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x93 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x94 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x95 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x96 - screen transition with BG toggle (BG1 <-> BG2)
        ; 0x97 - screen transition with BG toggle (BG1 <-> BG2)
        
        ; 0xA0 - screen transition with dungeon toggle
        ; 0xA1 - screen transition with dungeon toggle
        ; 0xA2 - screen transition with dungeon toggle
        ; 0xA3 - screen transition with dungeon toggle
        ; 0xA4 - screen transition with dungeon toggle
        ; 0xA5 - screen transition with dungeon toggle
        
        ; 0xB0 - Cane of Somaria line (up/down)
        ; 0xB1 - Cane of Somaria line (left/right)
        ; 0xB2 - ???
        ; 0xB6 - Cane of Somaria line node (question mark shaped)
        
        ; 0xBE - Pipe tile?
        
        ; 0xC0 - Torch 0x00
        ; 0xC1 - Torch 0x01
        ; 0xC2 - Torch 0x02
        ; 0xC3 - Torch 0x03
        ; 0xC4 - Torch 0x04
        ; 0xC5 - Torch 0x05
        ; 0xC6 - Torch 0x06
        ; 0xC7 - Torch 0x07
        ; 0xC8 - Torch 0x08
        ; 0xC9 - Torch 0x09
        ; 0xCA - Torch 0x0A
        ; 0xCB - Torch 0x0B
        ; 0xCC - Torch 0x0C
        ; 0xCD - Torch 0x0D
        ; 0xCE - Torch 0x0E
        ; 0xCF - Torch 0x0F
        
        ; 0x0D0 - ????

        ; 0xF0 - Key door 1
        ; 0xF1 - Key door 2
        ; 0xF2 - Key door 3
        ; 0xF3 - Key door 4
        ; 0xF4 - ????

    ; $7F3000[0x1000] -   Tile attribute/collision table for BG1. Same as $7F2000 but for a different background.

    ; $7F4000[0x800] -    Decompression buffer for.... sprite stats and perhaps other
                        ; crap too.
    ; $7F5000[0x800] -    free ram

    ; $7F5800[0x0C] - (HappinessPondRupees)
        
        ; Y speed of rupee.

    ; $7F580A[0x0C] - (HappinessPondRupees)
        
        ; X speed of rupee.

    ; $7F5818[0x0C] - (HappinessPondRupees)
        
        ; Z speed of rupee.

    ; $7F5824[0x0C] - (HappinessPondRupees)
        
        ; Low byte of rupee's Y coordinate.

    ; $7F5830[0x0C] - (HappinessPondRupees)
        
        ; High byte of rupee's Y coordinate.

    ; $7F583C[0x0C] - (HappinessPondRupees)
        
        ; Low byte of rupee's X coordinate.

    ; $7F5848[0x0C] - (HappinessPondRupees)
        
        ; High byte of rupee's X coordinate.

    ; $7F5860[0x0C] - (HappinessPondRupees)
        
        ; Countdown autotimer.
        
    ; $7F586C[0x0C] - (HappinessPondRupees)
        
        ; Indicates whether this rupee is active or not.

    ; $7F586E[0x02] - (HappinessPondRupees)
        
        ; Mysteriously unallocated... there's a gap

    ; $7F587A[0x0C] - (HappinessPondRupees)
        
        ; Animation index for splash state of the rupee.

    ; $7F5886[0x0C] - (HappinessPondRupees)
        
        ; Subpixel portion of rupee's Y coordinate.

    ; $7F5892[0x0C] - (HappinessPondRupees)
        
        ; Subpixel portion of rupee's X coordinate.

    ; $7F589E[0x0C] - (HappinessPondRupees)
    
        ; Subpixel portion of rupee's Z coordinate.

    ; $7F58AA[0x0C] - (HappinessPondRupees)
        
        ; 0 - In item state.
        ; 1 - In splash state.
        ; 2 - Scheduled for deactivation.

    ; $7F5817[0x08] - (BreakTowerSeal)
        
        ; Low byte of Y coordinate of the crystals. Note that this has 8 entries,
        ; though only 7 crystals are in the game both plot-wise and in general.

    ; $7F581F[0x08] - (BreakTowerSeal)
        
        ; High byte of Y coordinate of the crystals. Note that this has 8 entries,
        ; though only 7 crystals are in the game both plot-wise and in general.

    ; $7F5827[0x08] - (BreakTowerSeal)
        
        ; Low byte of X coordinate of the crystals. Note that this has 8 entries,
        ; though only 7 crystals are in the game both plot-wise and in general.

    ; $7F582F[0x08] - (BreakTowerSeal)
        
        ; High byte of X coordinate of the crystals. Note that this has 8 entries,
        ; though only 7 crystals are in the game both plot-wise and in general.

    ; $7F5837[0x18] - (BreakTowerSeal)

        ; Animation index for the sparkles that are generated near the swirling
        ; crystals.

    ; $7F584F[0x18] - (BreakTowerSeal)
        
        ; Low byte of Y coordinate for the sparkles that are generated near the
        ; swirling crystals.

    ; $7F5867[0x18] - (BreakTowerSeal)
        
        ; High byte of Y coordinate for the sparkles that are generated near the
        ; swirling crystals.

    ; $7F587F[0x18] - (BreakTowerSeal)
        
        ; Low byte of X coordinate for the sparkles that are generated near the
        ; swirling crystals.

    ; $7F5897[0x18] - (BreakTowerSeal)
        
        ; High byte of X coordinate for the sparkles that are generated near the
        ; swirling crystals.

    ; $7F58AF[0x18] - (BreakTowerSeal)
        
        ; Countdown timer for the sparkles generated near the swirling crystals.
        ; It's exact purpose is to provide the delay between changes of chr
        ; and property states for the crystals (See $7F5837)

    ; $7F5934[0x01] - (BombosSpell)
        
        ; Overall state indicator for the Bombos Spell.
        ; Only takes on values 0 through 2, but needs more research to find out what
        ; they mean.
        
        ; 0 - Spawning of flame columns as they expand out.
        ; 1 - Wrap up flame column animation then transition to the blast phase.
        ; 2 - Blast phase

    ; $7F5935[0x10] - (BombosSpell)
        
        ; Animation index of Bombos blasts (explosions). Ranges from 0 to 8.
        ; 8 indicates an inactive state waiting to be reset.
        
    ; $7F5B00[0xA0] -

        ; Array of sound settings for overworld areas. Each entry (byte) has the
        ; following format:
        
        ; aaaammmm
        
            ; aaaa - ambient sound effect number to play in that area ($012D).
            ; mmmm - song number to play in that area ($012C).
        
        ; This array is preloaded with differing values depending on which stage of
        ; the game you're in. The stages are determined by $7EF3C5.
        ; (See $3C5 in Zelda_3_SRM.log) 

    ; $7F5BA0[0x60] -    free ram

    ; $7F6000[0x1000] -  enemy damage related

    ; $7F7000[0x1C0] -    Used to generate the HDMA table that the intro and outro spotlight effect uses

    ; $7F71C0[0x4A7] -    text / dialogue pointers (all of them!). Each one is a 3 byte long pointer.

    ; $7F7667[0x6719] -   free ram

    ; $7FDD80[0x200] -    

        ; Serves as a temporary buffer for storing a copy of the current palette buffer.
        ; Sometimes the contents of $7EC500 gets stored here, and other times it's $7EC300
        ; being preserved. The general idea here is that the game hopes to eventually
        ; (optionally) restore the palette to this set of colors later.

    ; $7FDE00[0x180?] -   ???

    ; $7FDF80[0x0280] -   (indoors) I think this is used to describe which rooms have had their sprites loaded (while in a dungeon)
    ; $7FDF80[0x1000] -   (outdoors) Memory region that indicates where sprites are in the currently loaded overworld map (which map16 tile they're on)

    ; $7FE200 - 

    ; $7FEF80[0x200] -    
        
        ; death status for the overworld sprites?

    ; $7FF180[0x680] -    
        
        ; free ram? Can't be 100% certain yet.

    ; $7FF800[0x1E] - (Garnish)
        
        ; Mostly superficial graphical entities (hence, "Garnish"). The only one that
        ; is known to damage the player are the Ganon Bat Flames.
        
        ; 0x00 - Garnish is considered inactive if it has this value.
        
        ; 0x01 - Winder fireball trails (which is why only the front fireball of the
            ; Winder is harmful to the player).
        
        ; 0x02 - Mothula Beam Trail.
        
        ; 0x03 - Falling tile? Or the effect after the tile has falling of it disappearing?
        
        ; 0x04 - Seems to be the trailing portions of the laser beams that laser eyes
            ; shoot.
        
        ; 0x05 - one sparkling point produced when you freeze an enemy and as while 
            ; it's frozen periodically
        
        ; 0x06 - Zoro Dander. (Dust that trails behind them.)
        
        ; 0x07 - Kholdstare nebule trails.
        
        ; 0x08 - Fireball sprite from zora or evil face things. Maybe the trails of those instead?
        
        ; 0x09 - Something to do with Vitreous... maybe his lightning
        
        ; 0x0A - bush clippings scattering (also used for grass
            ; Update: trying to figure out how I ever thought this was the case...
        
        ; 0x0B - Pirogusu splashes.
        
        ; 0x0C - Trinexx related...?
        
        ; 0x0D - Invalid, don't use this animation as it will certainly crash the game. (It's a null pointer)
        
        ; 0x0E - Trinexx related... ?
        
        ; 0x0F - Blind related... maybe has to do with his laser eye shot.
        
        ; 0x10 - Something to do with Trinexx... perhaps fire or ice blasts.
            ; Also related to Ganon's firebats that spawn fireballs.
            ; I think it's pretty clear it's those fireballs
        
        ; 0x11 - Spawned from special animation 0x0E...
        
        ; 0x12 - A faster sparkle
        
        ; 0x13 - The Ganon bat smashing into the pyramid of power
        
        ; 0x14 - Running Man dash poofs
        
        ; 0x15 - Arghus splashes?
        
        ; 0x16 - Scattering pieces of a pot, bush, grass, sign, rock, or related
            ; tile objects being broken.

    ; $7FF81E[0x1E] - (Garnish)
        
        ; Low byte of Y coordinate.

    ; $7FF83C[0x1E] - (Garnish)
        
        ; Low byte of X coordinate.
        
    ; $7FF85A[0x1E] - (Garnish)
        
        ; High byte of Y coordinate.

    ; $7FF878[0x1E] - (Garnish)
        
        ; High byte of X coordinate.

    ; $7FF896[0x1E] - (Garnish)
        
        ; Y velocity of object.
        
    ; $7FF8B4[0x1E] - (Garnish)
        
        ; X velocity of object.

    ; $7FF8D2[0x1E] - special animation unknown 3
    ; $7FF8F0[0x1E] - special animation unknown 4

    ; $7FF90E[0x1E] - (Garnish)
        
        ; Countdown timer. Most Garnish objects just self terminate once this
        ; counts down.

    ; $7FF92C[0x1E] - (Garnish)
        
        ; The index of the object's parent sprite object, if applicable.
        
        ; Some garnish objects use this as the floor designator, but they are far
        ; in the minority. Most use $7FF968 instead.
        
    ; $7FF94A[0x1E] - special animation unknown 5

    ; $7FF968[0x1E] - (Garnish)
        
        ; Floor selector for garnish objects. Analogous to the the kinds of config
        ; data that Ancilla ( $0C7C, X ) and Sprite ( $0F20, X ) have.
        
        ; 0 - BG2
        ; 1 - BG1
        
    ; $7FF986[0x1E] - special animation unknown 7
    ; $7FF9A4[0x1E] - special animation unknown 8

    ; $7FF9C2[0x10] - (Sprite, Garnish?)
        
        ; Sprite tile interaction value. Acquires its value from $0FA5.

    ; $7FF9D2[0x2C] - Free ram?

    ; $7FF9FE[0x1E] - (Garnish)
        
        ; special animation unknown B

    ; Holdable objects

    ; $7FFA1C[0x10] - Array that seems to handle the objects you hold above your head?
    ; $7FFA2C[0x10] - 
    ; $7FFA3C[0x10] - Indicates stunned and frozen sprite?
    ; $7FFA4C[0x10] -
    ; $7FFA5C[0x10] -
    ; $7FFA6C[0x10] -
    ; $7FFA7C[0x10] -
    ; $7FFA8C[0x10] -
    ; $7FFA9C[0x10] -
    ; $7FFAAC[0x10] -
    ; $7FFABC[0x10] - 

        ; ????

    ; $7FFACC[0x10] -
    ; $7FFADC[0x10] -
    ; $7FFAEC[0x10] - free ram?
    ; $7FFAFC[0x10] - free ram?
    ; $7FFB0C[0x10] - free ram?
    ; $7FFB1C[0x10] - used, but unknown
    ; $7FFBDC[0x10] - used, but unknown
    ; 
    ; most of these seem to be referenced for Helmasaur King's tail (maybe other bosses too)

    ; $7FFC00[??] - unknown
    ; $7FFC80[??] - unknown

    ; $7FFC9C[0x10?] - used, but unknown

    ; $7FFD00[??] - unknown

    ; $7FFD5C[0x01] - apparently Ganon related 
    ; $7FFD68[0x01] - apparently Ganon related

    ; $7FFC00[0x0080] - (Unknown)

        ; ????

    ; $7FFC80[0x0080] - (Unknown)

        ; ????

    ; $7FFD00[0x0080] - (Unknown)

        ; ????

    ; $7FFD80[0x0080] - unknown

        ; X coordinate low byte for laser sprites.

    ; $7FFE00[0x0080] -   (Statue Sentry)

        ; X coordinate high byte for laser sprites.

    ; $7FFE80[0x0080] -   (Statue Sentry)

        ; Y coordinate low byte for laser sprites.

    ; $7FFF00[0x0080] -   (Statue Sentry)

        ; Y coordinate high byte for laser sprites.

    ; $7FFE00[0x0100] -   (Lanmolas)

        ; Display of rock sprites, I think

    ; $7FFF00[0x0100] -   (Lanmolas)

        ; Lanmolas use it for display of its rock sprites, I think.

    ; -------------End of variables------------------------
    ; Routines:

    ; $333
    ; While this routine appears to be complicated and technical, it really serves two purposes.
    ; Depending upon the entry point to the routine, two 16 bit values will be written to VRAM. The value at $00 goes to $0000-$1FFF and the one in $02 goes to $6000-$67FF. That's it. The values are written non-incrementally, so it's just those two values getting written over and over again.

    ; $07C0
    ; Zeroes out the first $2000 bytes of WRAM.
    ; Checks the checksums on your save files to see if they are valid. Erases them if not.

    ; $00082E


    ; $0888
    ; Loads SPC with data at specified address

    ; $0901
    ; Sets up address for $8888
    ; Address = $198000 => $0C8000

    ; $093D
    ; Initializes the Screen

    ; $094A
    ; Saves your game.

    ; $07C0
    ; Sets up address for $8888
    ; Address = $1A9EF5 => $D1EF5

    ; $12A1
    ; Upon starting this routine, inspect the 8-bit value at the long address [$00], Y
    ; If it is positive, that value is stored at $04, Y is incremented, and the next value is stored at $03. Y increments.
    ; If the next value at [$00], Y is negative (AND 0x80 tells us this) then A will end up as 0x1, and 0x0 is the value was positive.
    ; This is stored at $07.
    ; The very same value is read in but this time we AND with 0x40, STA.b $05, and LSR A three times.
    ; The AND left a nonzero result, we will have A = 0x80, and if not, A = 0x00.
    ; Ultimately either are ORed with 0x01 so we have A = 0x81 or 0x01.
    ; The 0x01 tells us data will be being transferred in Mode 2 (a la register $4310).
    ; Data from the source is written to $2118. 

    ; Summary:    1st Value read: XXXX XXXX (If negative, the SR exits) -> $04
                ; 2nd Value read: XXXX XXXX -> $03
                ; 3rd Value read: AXXX XXXX (A = 0: 


    ; $D81B
    ; If NOPed, you will not be able to pick up some types of pots in dungeons.

    ; $10054
    ; The subroutine is used to verify that all the save files are uncorrupted. Each save file has one mirrored slot 0xF00 bytes offset from the original. If the first file is corrupt and the mirror is fine, it will copy the mirror to the original and use it. Basically it checks if the 0x500 bytes in the slot add up to 0x5A5A. When save files are saved a checksum is calculated to make sure this constraint is met.

    ; $17EBB
    ; I'm going to generalize this subroutine because the data extraction method is cumbersome to figure out at a moment's glance. Sub $175F5 is used to get a sequence of codes, and after each code follows data to be put in memory at $7F4000, Y. Update: After some serious thought, I've begun to think of this as a decompression routine, possibly for OAM data.

    ; The way the data is handled depends on the three most significant bits of the code. The number of bytes to write is determined by the five least significant bits of the code plus one. Let this number be called R.

    ; [XXX | XXXXX]
    ; (Code), (R - 1)

    ; Example:
    ; [010 | 10001]
    ; Code = 010
    ; R = 10001 + 1 = 10010 = 18d (d for decimal)

    ; Codes:
    ; [000] : Write R bytes after the code. For instance, 03 11 12 13 14 would have you write 11, 12, 13, and 14 in succession into memory.

    ; [001] : Write the one byte after the code R times. 23 15 would make you write 15 four times into memory.

    ; [100], [110], [101] : After the code is a 16-bit index. This means copy memory from $7F4000 + (the Index). You will copy R bytes of course

    ; [010] : This code is used for repeatedly storing a 16-bit number, rather than the [001] case. Over all R bytes will still be written.

    ; [011] : Whatever value is picked after the code will be incremented (R - 1) times and written R times. 34 01 for example would write 01 02 03 04 05

    ; $6FE77-$6FFC0 Template for the status bar. That is, set of tile indices. When the game begins these are mapped to $7EC700-$7EC849

    ; $3E245 Controls Link's movement, i.e. his speeds and different movement events, such as swimming and dashing.

    ; ===========================================================================

    ; Credits / Citations / Helped With:

    ; Euclid: 

    ; - Figuring out what $1B[0x01] ($7E001B[0x01]) was for.
        
    ; - Finding the Overlay index $8C[0x01] ($7E008C[0x01]).
        
    ; - Purpose of $0202[0x01] ($7E0202[0x01])
        
    ; - Extra information regarding $02E4[0x01] ($7E02E4[0x01])
        ; Specifically, that it is set to 0x1A after you kill Ganon.
        
    ; - Documentation of $0CD2[x10] ($7E0CD2[0x10])

    ; assassin17:
        
    ; - Bits 'p' of $0BE0[0x10] ($7E0BE0[0x10]), prize pack from killing an enemy.
        
    ; - Bit 'd' of sprite varaible $0CAA[0x10] ($7E0CAA[0x10])
        ; Documentation is copied verbatim, for now.
    
    ; - Documentation of $0CF9[0x01] ($7E0CF9[0x01])

    ; PARCCC (of gshi, a PAR code community):

    ; - Documentation of $79 ($7E0079[0x01])


        ; link's starting position from zarby
    ; 0x039A37 ; Link LOW X Position
    ; 0x039A32 ; Link LOW Y Position
    ; 0x039A38 ; Link HIGH X Position reset(used to change quadrant) -1 to move left portion
    ; 0x039A33 ; Link HIGH Y Position reset(used to change quadrant) -1 to move top portion

    ; 0x02DE53 ; Link LOW X Position reset
    ; 0x02DE5D ; Link LOW Y Position reset
    ; 0x02DE58 ; Link HIGH X Position reset(used to change quadrant) -1 to move left portion
    ; 0x02DE62 ; Link HIGH Y Position reset(used to change quadrant) -1 to move top portion

    ; 0x0480BD ; Bed Sheet LOW X
    ; 0x0480B8 ; Bed Sheet LOW Y
    ; 0x0480BE ; High X(used to change quadrant) -1 to move left portion
    ; 0x0480B9 ; High Y(used to change quadrant) -1 to move top portion
}

; ===============================================================================