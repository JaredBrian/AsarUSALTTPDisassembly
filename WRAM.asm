; ==============================================================================

; WRAM Map
; WIP will eventually replace the WRAM.log

; ==============================================================================

; Shorthand legend:
; Addr = Address
; APU = Audio Processing Unit
; AUX = Auxiliary
; BG = BackGround
; Calc = Calculate/Calculation
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
; Manip = Manipulate
; MULT = Multiply/Multiplication
; OAM = Object Attribute Memory
; OBJ = Object
; OW = Overworld
; Poly = Polyhedral
; Pos = Position
; PPU = Picture Processing Unit
; Ptr = Pointer
; SFX = Sound Effects
; Src = Source
; TM = Tile Map
; V = Vertical
; Val = Value
; VRAM = Video RAM

struct WRAM $7E0000
{
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
        ; When nonzero, will trigger a transfer from $7FXXXX to vram
        ; address $YY00
        ; XXXX is specified by variable $0118
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
        ; Main Screen Designation (TM / $212C)
        ; To be written to SNES.BGAndOBJEnableMainScreen during NMI.
        ; uuuo 4321
        ; u - Unused enabled
        ; o - OAM layer enabled
        ; 1 - BG1 enabled
        ; 2 - BG2 enabled
        ; 3 - BG3 enabled
        ; 4 - BG4 enabled

    ; $1D[0x01] - (Main, NMI)
    .SubScreenDes: skip $01
        ; Sub Screen Designation (TS / $212D)
        ; To be written to SNES.BGAndOBJEnableSubScreen during NMI.
        ; uuuo 4321
        ; u - Unused
        ; o - OAM layer enabled
        ; 1 - BG4 enabled
        ; 2 - BG3 enabled
        ; 3 - BG2 enabled
        ; 4 - BG1 enabled

    ; $1E[0x01] - (Main, NMI)
    .MainWindowMaskDes: skip $01
        ; Window Mask Activation (TMW / $212E)
        ; To be written to SNES.WindowMaskDesMainScreen during NMI.

    ; $1F[0x01] - (Main, NMI)
    .SubWindowMaskDes: skip $01
        ; Subscreen Window Mask Activation (TSW / $212F)
        ; To be written to SNES.WindowMaskDesSubScreen during NMI.

    ; $20[0x02] - (Player)
    .LinkYCoord: skip $02
        ; Link's Y-Coordinate (mirrored at $0FC4)

    ; $22[0x02] - (Player)
    .LinkXCoord:
        ; Link's X-Coordinate (mirrored at $0FC2)

    ; $22[0x01] - (Attract)
    .AttractModule: skip $01
        ; Used as a step counter for the attract mode.

    ; $23[0x01] - (Attract)
    .AttractSubModule: skip $01
        ; Indicates the current sequence being run, such as the mode 7 zoom in,
        ; or the maiden being teleported to the Dark World.

    ; $24[0x02] - (Dungeon, Overworld)
    .LinkZCoord:
        ; 0xFFFF usually, but if Link is elevated off the ground it is
        ; considered to be his Z coordinate. That is, it's his height off of
        ; the ground.

    ; $25[0x01] - (Attract)
    .AttractZoomControl: skip $01
        ; 1. During the mode 7 zoom in on Hyrule Castle, this acts as a barrier
        ; for another counter ($0637) that toggles between 0 and 1 every other
        ; frame. When 0, $0637 is decremented and the zoom is increased
        ; slightly. In effect, this is to control the rate of the zooming.

    ; $26[0x01] - (Player)
    .LinkPushDir:
        ; The direction(s) that Link is pushing against.
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
    .LinkYCollisionRecoil:
        ; Link's Recoil for vertical collisions

    ; $27[0x01] - (Attract)
    .AttractNextLegendFlag: skip $01
        ; Flag indicating whether to display a new 2bpp graphic.

    ; $28[0x01] - (Player)
    .LinkXCollisionRecoil:
        ; Link's Recoil for horizontal collisions

    ; $28[0x01] - (Attract)
    .AttractAgahXCoord: skip $01
        ; Agahnim's base X coordinate relative to the screen.

    ; $29[0x01] - (Player)
    .LinkYResistance:
        ; Vertical resistance
        ; TODO: Figure out exactly what this is.

    ; $29[0x01] - (Attract)
    .AttractAgahYCoord: skip $01
        ; Agahnim's base Y coordinate relative to the screen.

    ; $2A[0x01] - (Player)
    .LinkYSubCoord: skip $01
        ; Player's subpixel Y coordinate
        ; TODO: Also has a use in the attract mode like most of this early WRAM.

    ; $2B[0x01] - (Player)
    .LinkXSubCoord: skip $01
        ; Player's subpixel X coordinate

    ; $2C[0x01] - (Player)
    .LinkWorthlessZero:
        ; Only written to in one place, and it's always a zero.
        ; Given the limited scope of this use compared to the one below, it
        ; could be considered Free RAM, so long as there's an understanding
        ; that its use is shared with attract mode (see AttractTimer).

    ; $2C[0x01] - (Attract)
    .AttractTimer: skip $01
        ; Used as a countdown timer on the throne room screen. When it reaches
        ; 0x1e, it is used to begin the fade to the next scene by decreasing the
        ; brightness by one on frames where this variable has an even value.

    ; $2D[0x01] - (Player)
    .LinkAnimationTimer:
        ; Acts as a timer for certain animations to advance LinkAnimationStep.

    ; $2D[0x02] - (Attract)
    .AttractUnknownPtr: skip $01
        ; Appears to serve as a pointer to sprite data of some sort. Exact scope
        ; of usage during this mode not known at this time.

    ; $2E[0x01] - (Player, OAM)
    .LinkAnimationStep: skip $01
        ; Animation steps: seems to cycle from 0 to 5 then repeats. Seems that
        ; other submodes of the player logic use a different number of steps
        ; (spin attack maybe?)

    ; $2F[0x01] - (Player)
    .LinkHeading: skip $01
        ; 0 - up
        ; 2 - down
        ; 4 - left
        ; 6 - right.
        ; The direction the player is currently facing. Other values should be
        ; considered invalid.

    ; $30[0x01] - (Player)
    .LinkYVelocity: skip $01
        ; When Link is moving down or up, this is the signed number of pixels
        ; that his Y coordinate will change by.

    ; $31[0x01] - (Player)
    .LinkXVelocity: skip $01
        ; Same as $30 except it's for X coordinates

    ; $32[0x01] - (Player)
    .LinkCliffHoppingY: skip $02
        ; Seems to be used in some subsection of Bank 07 that handles hopping
        ; off cliffs in relation to link's Y coordinate. TODO: Also has a use
        ; in the Attract Module. TODO: Figure out exact use.

    ; $34[0x01] - (Attract)
    .AttractAgahCueFlag: skip $01
        ; Nonzero when the two soldiers during the 'Zelda in
        ; Prison' sequence are on the screen still. Zero when they leave,
        ; causing advancement to the next subsequence of this sequence
        ; (Agahnim walking towards Zelda's cell and the text appearing.)

    ; $35[0x01] - (Free)
    .Free_35: skip $01
        ; Free RAM

    ; $36[0x01] - (Free)
    .Free_36: skip $01
        ; Free RAM

    ; $37[0x01] - (Free)
    .Free_37: skip $01
        ; Free RAM

    ; $38[0x02] - (Player)
    .LinkDWallCalc: skip $02
        ; Seems to be set some of the time when going up diagonal walls.
        ; It's a bitfield for tiles type 0x10 through 0x13. TODO: Confirm
        ; this name.
        ; SEE TILE ACT NOTES

    ; TILE ACT NOTES

    ; For tile act bitfields, each property is flagged with 4 bits.
    ; These bits indicate which tile relative Link the tile was found.
    ;  a b
    ;   L
    ;  c d
    ;
    ; abcd
    ;   a - Found to the north west
    ;   b - Found to the north east
    ;   c - Found to the south west
    ;   d - Found to the south east
    ;
    ;   L - Link

    ; $3A[0x01] - (Input)
    .BAndYInputField: skip $01
        ; Bitfield for the B and Y buttons
        ; hymuunub
        ; b - B button was pressed this frame, and not held down during the
        ; previous frame.
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
    .LinkAnimationTimer: skip $01
        ; A delay timer for the spin attack. Used between shifts to make the
        ; animation flow with the flash effect. Also used for delays between
        ; different graphics when swinging the sword.

    ; $3E[0x01] - (Player)
    .LinkCalcYLow: skip $01
        ; Y coordinate related variable (low byte)

    ; $3F[0x01] - (Player)
    .LinkCalcXLow: skip $01
        ; X coordinate related variable (low byte)

    ; $40[0x01] - (Player)
    .LinkCalcYHigh: skip $01
        ; Y coordinate related variable (high byte)

    ; $41[0x01] - (Player)
    .LinkCalcXHigh: skip $01
        ; X coordinate related variable (high byte)

    ; $42[0x01] - (Player)
    .LinkObstructV: skip $01
        ; Appears to flag directions for freedom for vertical. Flags are set
        ; when there's no obstruction. TODO: Of movement? or for freedom of what?
        ; (0: obstructed | 1: unobstructed)
        ; .... udlr
        ;   u - upwards
        ;   d - downwards
        ;   l - leftwards
        ;   r - rightwards

    ; $43[0x01] - (Player)
    .LinkObstructD: skip $01
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
        ; Set to 0x80 during preoverworld. Seems to be an offset for player oam
        ; y offset. TODO: Not fully confirmed.

    ; $45[0x01] - (Player)
    .AttackOAMOffsetX: skip $01
        ; Set to 0x80 during preoverworld. Seems to be an offset for player oam
        ; x offset. TODO: Not fully confirmed.

    ; $46[0x01] - (Player)
    .LinkRecoilTimer: skip $01
        ; A countdown timer that incapacitates Link when damaged or in recoil
        ; state. If nonzero, no movement input is recorded for Link.

    ; $47[0x01] - (Player)
    .WeapponTinkTimer: skip $01
        ; Weapon tink spark timer.

    ; $48[0x01] - (Player, OAM)
    .LinkPushAction: skip $01
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
    .LinkForceMove: skip $01
        ; This address is written to make Link move in any given direction. When 
        ; indoors, it is cleared every frame. When outdoors, it is not cleared
        ; every frame so watch out. Also any value besides 0 it overwrites
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

    ; $4A[0x01] - (Free)
    .NotFree_4A: skip $01
        ; Was marked as free RAM but appears to be cleared by tile detection
        ; routines.

    ; $4B[0x01] - (Player)
    .LinkVisible: skip $01
        ; Link's visibility status. If set to 0x0C, Link will disappear.

    ; $4C[0x01] - (Item)
    .CapeDrainTimer: skip $01
        ; Counter that decreases every frame when the Cape is in use. Starts at
        ; 4 and counts down to 0. When it reaches 0, your magic meter is
        ; decremented based on whether you have full or 1/2 magic. There's a
        ; table in Bank 07 that determines this.

    ; $4D[0x01] - (Player)
    .LinkAuxState: skip $01
        ; An Auxiliary Link handler.
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
        ; 0     | 0x00, 0x09
        ;   |
        ; 1     | 0x80, 0x81, 0x90, 0x91, ..., 0xE0, 0xE1, 0xF0, 0xF1
        ;   |
        ; 2     | 0x82, 0x83, 0x92, 0x93, ..., 0xE2, 0xE3, 0xF2, 0xF3, and
        ;   | any values not covered by the other tile attribute numbers.
        ;   | 
        ; 3     | 0x84, 0x85, 0x88, 0x89, ..., 0xF4, 0xF5, 0xF8, 0xF9
        ;   |
        ; 4     | 0x86, 0x87, 0x96, 0x97, ..., 0xE6, 0xE7, 0xF6, 0xF7

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
    .LinkStrafeFlag: skip $01
        ; A flag indicating whether a change of the direction Link is facing is
        ; possible. For example, when the B button is held down with a sword.
        ; When non 0, strafe.
        ; .... .bps
        ;   s - the bit generally flagged
        ;   p - flagged during rupee pull and perpendicular door movement
        ;   b - flagged during push blocks

    ; $51[0x01] - (Attract)
    .AttractUnknownFlag_51:
        ; TODO: Has some use in attract mode.

    ; $51[0x02] - (Player)
    .LinkTargetY: skip $01
        ; Used as a buffer to store the Y position where link is supposed to
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
    .LinkTargetX: skip $02
        ; Used as a buffer to store the X position where link is supposed to
        ; land to when falling in a hole.

    ; $55[0x01] - (Player)
    .LinkCapeOn: skip $01
        ; Cape flag, when set, makes you invisible and invincible. You can
        ; also go through objects, such as bungies.

    ; $56[0x01] - (Player, OAM)
    .LinkIsBunny: skip $01
        ; Link's graphic status.
        ; 0 - real link.
        ; 1 - bunny link

    ; $57[0x01] - (Player)
    .LinkSpeedModifier: skip $01
        ; Modifier for Link's movement speed. Counts up to 0x10 to
        ; induce slower speed on stairs. Famously uncleared after spiral stairs.
        ; 0            - normal
        ; 0x01 to 0x0F - slow
        ; 0x10 and up  - fast.
        ; Negative values actually reverse your direction.

    ; $58[0x01] - (Player)
    .LinkStairTile: skip $01
        ; Bitfield describing insteractions with stairs tiles.
        ; uuuussss
        ; s - Stair tiles
        ; u - Free RAM
        ; If this masked with 0x07 equals 0x07, Link moves slowly, like he's on
        ; a small staircase. $02C0 also needs this variable to be nonzero to
        ; trigger.
        ; SEE TILE ACT NOTES

    ; $59[0x01] - (Player)
    .LinkPitTile: skip $01
        ; Bitfield for pit tile interaction.
        ; uuuupppp
        ; u - Free RAM
        ; p - pit tile detected
        ; SEE TILE ACT NOTES

    ; $5A[0x01] - (Player)
    .LinkFallPose: skip $01
        ; Pose when landing from a pit fall in underworld.

    ; $5B[0x01] - (Player)
    .LinkPitSlipping: skip $01
        ; 0 - Indicates nothing
        ; 1 - Player is dangerously near the edge of a pit
        ; 2 - Player is falling
        ; 3 - Player is falling into a hole, part 2?

    ; $5C[0x01] - (Player)
    .LinkFallTimer: skip $01
       ; Timer for the falling animation.

    ; $5D[0x01] - (Player)
    .LinkState: skip $01
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
        ;    directions.
        ; 0x10 - Same or similar to 0x0F?
        ; 0x11 - Falling off a ledge
        ; 0x12 - Used when coming out of a dash by pressing a direction other 
        ;    than the dash direction.
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
    .LinkSpeed: skip $01
        ; Speed setting for Link. The different values this can be set to index
        ; into a table that sets his real speed. Some common values:
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

    ; $64[0x02] - 
    .LinkOAMPriority: skip $01
        ; Used to ORA in OAM priority, but only high byte seems used for that.
        ; 0x1000 if $EE = 1, 0x2000 if $EE = 0.

    ; $64[0x02] - (Attract)
    .AttractTimer2: skip $02
        ; Used as a timer for Agahnim text display in attract mode.

    ; $66[0x01] - (Player)
    .LinkLastDir: skip $01
        ; Indicates the last direction Link moved towards.
        ; Value-wise:
        ; 0 - Up
        ; 1 - Down
        ; 2 - Left
        ; 3 - Right

    ; $67[0x01] - (Player)
    .LinkDir: skip $01
        ; Indicates which direction Link is walking (even if not going anywhere).
        ; ----udlr.
        ; u - Up
        ; d - Down
        ; l - Left
        ; r - Right

    ; $68[0x01] - (Player)
    .LinkYDiff: skip $01
        ; When the player moves in room, this is the difference between their
        ; new Y coordinate and their old one (Y_new - Y_old).
        ; For example, a value of 1 would indicate that the player has moved
        ; down by one pixel, whereas a value of 0 would indicate no
        ; movement in the Y axis.

    ; $69[0x01] - (Player)
    .LinkXDiff: skip $01
        ; When the player moves in room, this is the difference between their
        ; new and old X coordinates (X_new - X_old).
        ; For example, a value of -2 would indicates that the player has
        ; moved left by two pixels, whereas a value of 0 would indicate no
        ; movement in the X axis.

    ; $6A[0x01] - (Player)
    .LinkOrthogonalDir: skip $01
        ; Indicates the number of orthogonal directions the player is moving
        ; in simultaneously. This does not include the rarely used Z axis
        ; (altitude).
        ; 0 - not moving
        ; 1 - moving either horizontally or vertically, but not both
        ; 2 - moving both horizontally and vertically

    ; $6B[0x01] - (Player)
    .LinkDWallDir: skip $01
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
    .LinkInDoor: skip $01
        ; Indicates whether you are standing in a doorway
        ; 0 - not standing in a doorway. 
        ; 1 - standing in a vertical doorway 
        ; 2 - standing in a horizontal door way

    ; $6D[0x01] - (Player)
    .LinkDWallFail: skip $01
        ; When you are moving against a diagonal wall and you are deadlocked.
        ; I.e. you are pressing against it directly, but aren't going anywhere,
        ; this will contain the value that $6B would have.

    ; $6E[0x02] - (Player, TileAttr)
    .LinkDWallTile: skip $01
        ; Tile act bitfield used by slopes.
        ; High byte has an explicit STZ as well, but never used.
        ; .... ssss
        ; Moving against a \ wall from below: 0 
        ; Moving against a \ wall from above: 2
        ; Moving against a / wall from below: 4
        ; Moving against a / wall from above: 6
        ; SEE TILE ACT NOTES

    ; $6F[0x02] - (Free)
    .NotFree_6F: skip $01
        ; Was marked as free, see note for LinkDWallTile.

    ; $70[0x01] - (Free)
    .Free_70: skip $01
        ; Free RAM

    ; $71[0x01] - (Free)
    .Free_71: skip $01
        ; Free RAM

    ; $72[0x04] - (Main)
    .Work2: skip $04
        ; Used as general scratch space in a variety of different routines.

    ; $76[0x02] - (Player, TileAttr)
    .LinkInteractTile: skip $02
        ; When object, such as the player, interact with certain tile types, 
        ; the index of that tile gets stored here.

    ; $78[0x01] - (Player)
    .LinkJumpScroll: skip $01
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

    ; $7C[0x01] - (Free)
    .Free_7C: skip $01
        ; Free RAM

    ; $7D[0x01] - (Free)
    .Free_7D: skip $01
        ; Free RAM

    ; $7E[0x01] - (Free)
    .Free_7E: skip $01
        ; Free RAM

    ; $7F[0x01] - (Free)
    .Free_7F: skip $01
        ; Free RAM

    ; $80[0x01] - (Free)
    .Free_80: skip $01
        ; Free RAM

    ; $81[0x01] - (Free)
    .Free_81: skip $01
        ; Free RAM

    ; $82[0x01] - (Free)
    .Free_82: skip $01
        ; Free RAM

    ; $83[0x01] - (Free)
    .Free_83: skip $01
        ; Free RAM

    ; $84[0x02] - (Overworld)
    .OWTMIndex:
        ; Index for overworld map16 buffer to load new graphics when scrolling.

    ; $86[0x02] - (Overworld)
    .OWTMHScroll: skip $02
        ; Overworld horizontal scroll position. Used to index $0500 and tilemap.

    ; $88[0x02] - (Overworld)
    .OWTMVScroll: skip $02
        ; Overworld vertical scroll position. Used to index $0500 and tilemap.

    ; $8A[0x02] - (Overworld)
    .OWAreaIndex: skip $02
        ; Overworld Area Index. Occasionally $8A is used to read underworld
        ; screens. In practice bit 6 indicates a Dark World area, and bit 7
        ; indicates special overworld. As the highest screen ID is 0x81, $8B
        ; is essentially unused in the overworld. However, reads and writes for
        ; screen ID are often 16-bit.

    ; $8C[0x01] - (Overworld)
    .OverlayIndex: skip $01
        ; Subscreen Overlay index. TODO: Add the corrsiponding overlays here.

    ; $8D[0x01] - 
    .StepAnimationTimer: skip $01
        ; Seems to be some kind of step counter for drawing ripples and thick
        ; grass around the player sprite (see Bank 0x0D).

    ; $8E[0x01] - (Free)
    .Free_8E: skip $01
        ; Free RAM

    ; $8F[0x01] - (Free)
    .Free_8F: skip $01
        ; Free RAM

    ; OAM consists of 0x220 bytes of data, split unevenly into 2 tables. The
    ; first table is 0x200 bytes long, ranging from $0000-$01FF. The 2nd table
    ; is just 0x20 bytes long, and ranges from $0100-011F. Here is what is
    ; contained in this tables:

    ; $90[0x02] - (OAM)
    .OAMLowPtr: skip $02
        ; Points to current position in the low OAM buffer (the first 0x200
        ; bytes). Each entry is 4-bytes per OAM tile. This will be written to
        ; SNES.OMADataWrite during NMI.   
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
        ; Points to current position in the high OAM table buffer (latter 0x20
        ; bytes). Each entry is 2 bits per OAM tile. This will be written to
        ; SNES.OMADataWrite during NMI.
        ; sx sx sx sx
        ; x - The X coordinate's 9th bit.
        ; s - OAM size: 0 - small size, 1 - large size)

        ; NOTE: The OAM size CAN change depending on the setting put into
        ; SNES.OAMSizeAndDataDes. Only the first 6 options were intended to be
        ; used. Tthe last 2 are rectangular shaped and behave oddly with
        ; vertical flipping. However ALTTP never changes this and only uses the
        ; first option of 8x8 and 16x16
        ; The sizes are as follows:
        ;  | Small | Large |
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
        ; Screen Mode Register (BGModeAndTileSize / $2105).
        ; To be written to SNES.BGModeAndTileSize during NMI. Also written
        ; to when entering and exiting the overworld map mode.

    ; $95[0x01] - (NMI)
    .MosaicSetting: skip $01
        ; Mosaic Settings (MosaicAndBGEnable / $2106).
        ; To be written to SNES.MosaicAndBGEnable during NMI.

    ; $96[0x01] - (NMI)
    .BG12WindowMask: skip $01
        ; Window Masks for Backgrounds 1 and 2 (BG1And2WindowMask / $2123).
        ; To be written to SNES.BG1And2WindowMask during NMI.

    ; $97[0x01] - (NMI)
    .BG34WindowMask: skip $01
        ; Window Masks for Backgrounds 3 and 4 (BG3And4WindowMask / $2124).
        ; To be written to SNES.BG3And4WindowMask during NMI.

    ; $98[0x01] - (NMI)
    .OBJAndColor: skip $01
        ; Window Masks for Obj and Color Add/Subtraction Layers
        ; (OBJAndColorWindow / $2125). To be written to SNES.OBJAndColorWindow
        ; during NMI.

    ; $99[0x01] - (NMI)
    .EnableFixedColor: skip $01
        ; Enable Fixed Color +/- (InitColorAddition / $2130).
        ; To be written to SNES.InitColorAddition during NMI.

    ; $9A[0x01] - (NMI)
    .AddSubSelect: skip $01
        ; Enable +/- per layer (AddSubtractSelectAndEnable / $2131).
        ; To be written to SNES.AddSubtractSelectAndEnable during NMI.

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
        ; Indicates the current floor Link is on in a dungeon.
        ;   0x00 - Floor 1
        ;   Negative values indicate basement floors.

    ; $A6[0x01] - (Dungeon)
    .CameraBoundsX: skip $01
        ; Set to 0 or 2, but it depends upon the dungeon room's layout
        ; and the quadrant it was entered from. Further investigation seems
        ; to indicate that its purpose is to control the camera / scrolling
        ; boundaries in dungeons.

    ; $A7[0x01] - (Dungeon)
    .CameraBoundsY: skip $01
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
    .LinkQuadrantH: skip $01
        ; 0 if you are on the left half of the room.
        ; 1 if you are on the right half.

    ; $AA[0x01] - (Dungeon, Player)
    .LinkQuadrantV: skip $01
        ; 2 if you are the lower half of the room.
        ; 0 if you are on the upper half.

    ; $AB[0x01] - (Free)
    .Free_AB: skip $01
        ; Free RAM

    ; $AC[0x01] - (Free)
    .Free_AC: skip $01
        ; Free RAM

    ; $AD[0x01] - (Dungeon)
    .LayerFloorEffect: skip $01
        ; Original MoN comment: ??? collision?
        ; Kan: Holds layer floor effect index

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

    ; $B1[0x01] - (Free)
    .Free_B1: skip $01
        ; Free RAM?
        ; TODO: Confirm is unused.

    ; $B2[0x02] - (Dungeon)
    .DunDrawOBJWidth: skip $02
        ; Width indicator for drawing dungeon objects.

    ; $B4[0x02] - (Dungeon)
    .DunDrawOBJHeight: skip $02
        ; Height indicator for drawing dungeon objects.

    ; $B6[0x01] - (Free)
    .Free_B6: skip $01
        ; Free RAM

    ; $B7[0x03] - (Dungeon)
    .DunOBJPtr: skip $01
        ; Used as a 3 byte pointer to be indirectly accessed during dungeon
        ; room loading.
        ; TODO: Also something with palettes?

    ; $BA[0x02] - (Dungeon)
    .DunOBJPtrOff: skip $01
        ; Often used as a position into a buffer of data during dungeon room
        ; loading. Used as an offset for DunOBJPtr.

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
    .DunDrawOBJAddLow: 
        ; (Bank 0x01) 10 entries of 3 bytes each. Used as a series of long
        ; pointers to tilemap buffer offsets. Generally, they point to locations
        ; in the range $7E2000 - $7E5FFF. Used to draw objects on different BGs 
        ; than where they were placed or on multiple BGs. See DunDrawOBJAddHigh.

    ; $BF[0x01] - (Polyhedral)
    .PolyUnknown_BF: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C0[0x1E] - (Dungeon)
    .DunDrawOBJAddHigh: 
        ; (Bank 0x01) 10 entries of 3 bytes each. Used as a series of long
        ; pointers to tilemap buffer offsets. Generally, they point to locations
        ; in the range $7E2000 - $7E5FFF. Used to draw objects on different BGs 
        ; than where they were placed or on multiple BGs. See DunDrawOBJAddLow.

    ; $C0[0x01] - (Polyhedral)
    .PolyUnknown_C0: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C1[0x02] - (File Select)
    .ValidFileArray2:
        ; (Bank 0x0C) The second entry in an array of 1 word each, one for each
        ; save file.
        ; 0 if there is no save file in that slot.
        ; 1 if there is a save file in that slot.
        ; See ValidFileArray1 and ValidFileArray3.

    ; $C1[0x01] - (Polyhedral)
    .PolyUnknown_C1: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C2[0x01] - (Polyhedral)
    .PolyUnknown_C2: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C3[0x01] - (Polyhedral)
    .PolyUnknown_C3:
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C3[0x02] - (File Select)
    .ValidFileArray3: skip $01
        ; (Bank 0x0C) The third entry in an array of 1 word each, one for each
        ; save file.
        ; 0 if there is no save file in that slot.
        ; 1 if there is a save file in that slot.
        ; See ValidFileArray1 and ValidFileArray2.

    ; $C4[0x01] - (Polyhedral)
    .PolyUnknown_C4: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C5[0x01] - (Polyhedral)
    .PolyUnknown_C5: skip $01
        ; (Bank 0x09) Used in the Polyhedral code. TODO: Figure out exact use.

    ; $C6[0x01] - (Polyhedral)
    .PolyUnknown_C6: skip $01
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
    .LogoSwordUnknown_D0:
        ; (Bank 0x0C) Used in the title screen logo sword. TODO: Purpose unknown.

    ; $E0[0x02] - (NMI)
        ; BG1 horizontal scroll register (SNES.BG2HScrollOffset / $210F)

    ; $E2[0x02] - (NMI)
        ; BG2 horizontal scroll register (SNES.BG1HScrollOffset / $210D)

    ; $E4[0x02] - (NMI)
        ; BG3 horizontal scroll register (SNES.BG3HScrollOffset / $2111)

    ; $E6[0x02] - (NMI)
        ; BG1 vertical scroll register (SNES.BG2VScrollOffset / $2110)

    ; $E8[0x02] - (NMI)
        ; BG2 vertical scroll register (SNES.BG1VScrollOffset / $210E)

    ; $EA[0x02] - (NMI)
        ; BG3 vertical Scroll Register (SNES.BG3VScrollOffset / $2112)

    ; $EC[0x02] - (Overworld, Dungeon)
        ; Tilemap location calculation mask. Is only ever set to 0xFFF8 or 0x01F8

    ; $EE[0x01] - 
        ; In dungeons, 0 Means you're on the upper level. 
        ; 1 Means you're on a lower level.
        ; Important for interaction with different tile types.

    ; $EF[0x01] - 
        ; Room Transitioning Value (bitwise)
        ; bit 0 - Toggles between BG1 and BG2. One example: Sanctuary and Hyrule
        ; Castle. (see door type up-11)
        ; bit 1 - Transition between Sewer and Hyrule Castle. Xors the dungeon
        ; index by 0x02. 

    ; $F0[0x01] - 
        ; Unfiltered Joypad 1 Register: Same as $F4, except it preserves buttons
        ; that were being pressed in the previous frame.

    ; $F1[0x01] - 
        ; Unfiltered Joypad 2 Register: Same as $F5, except it preserves buttons
        ; that were being pressed in the previous frame. Note: Input from joypad
        ; 2 is not read unless you do some ASM hacking.

    ; $F2[0x01] - 
        ; Unfiltered Joypad 1 Register: Same as $F6, except it preserves button
        ; that were being pressed in the previous frame.

    ; $F3[0x01] - 
        ; Unfiltered Joypad 2 Register: Same as $F7, except it preserves buttons
        ; that were being pressed in the previous frame. Note: Input from joypad
        ; 2 is not read unless you do some asm hacking

    ; $F4[0x01] - 
        ; Filtered Joypad 1 Register: [BYST | udlr].
        ; Lower case represents the cardinal directions, T = start. S = select.

    ; $F5[0x01] - 
        ; Filtered Joypad 2 Register: [BYST | udlr].
        ; Lower case represents the cardinal directions, T = start. S = select.
        ; Note: Input from joypad 2 is not read unless you do some asm hacking

    ; $F6[0x01] - 
        ; Filtered Joypad Register [AXLR | ????]
        ; LR: The shoulder buttons. ? = unknown inputs

    ; $F7[0x01] - 
        ; Filtered Joypad Register [AXLR | ????]
        ; LR: The shoulder buttons. ? = unknown inputs.
        ; Note: input from joypad 2 is not read unless you do some asm hacking.

    ; $F8[0x01] - 
        ; Unfiltered Joypad 1 Input from previous frame [BYSTudlr].

    ; $F9[0x01] - 
        ; Unfiltered Joypad 2 Input from previous frame [BYSTudlr].

    ; $FA[0x01] - 
        ; Unfiltered Joypad 1 Input from previous frame [AXLR----].

    ; $FB[0x01] - 
        ; Unfiltered Joypad 2 Input from previous frame [AXLR----].

    ; $FC[0x02] - 
        ; .... Overrides for dungeon room transitions? (Seen used with blast
        ; walls)

    ; $FE[0x01] - 
        ; Free RAM

    ; $FF[0x01] - 
        ; Vertical IRQ Trigger (this is the vertical scanline that will
        ; trigger the IRQ).

    ; ===========================================================================
    ; End of direct page memory and start of mirrored bank 0x7E memory locations
    ; ===========================================================================
    ; Page 0x01
    ; ===========================================================================
    
    ; This is beyond direct page and you can assume that all addresses here are
    ; $7EXXXX until you reach bank $7F.

    ; $0100[0x02] - 
        ; Numerical index that controls the graphics that are blitted for Link
        ; during VRAM. See DMA Variables for additional info.

    ; $0102[0x02] - 
        ; See DMA Variables

    ; $0104[0x02] - 
        ; See DMA Variables

    ; $0106[0x01] - 
        ; Free RAM?

    ; $0107[0x02] - 
        ; See DMA Variables

    ; $0109[0x01] - 
        ; See DMA Variables

    ; $010A[0x01] - 
        ; Set to nonzero when Link incurs death. Used if the player saved and
        ; continued (or just continued) after dying, indicating that the
        ; loading process will be slightly different.

    ; $010B[0x01] - 
        ; Free RAM?

    ; $010C[0x02] - 
        ; Temporary storage for a module number. Example: If we're in Overworld
        ; mode (0x9) and have to display a textbox (module 0xE), 0x9 gets saved
        ; to this location on a temporary basis. Once the textbox disappears
        ; this module will be resumed.

    ; $010E[0x02] - (Dungeon)
        ; gives the entrance index of the current dungeon

    ; $0110[0x02] - 
        ; In the context of loading dungeon rooms, contains the index of the
        ; room (see $A0) multiplied by 3. Allows for indexing into 24bit pointer
        ; address tables.

    ; $0112[0x02] - 
        ; Apparently a flag indicating the bombos medallion is falling.
        ; Stops the Menu from being dropped down too. It seems to work as
        ; a flag for any general extended animation that is currently in
        ; progress.

    ; $0114[0x02] - 
        ; Value of the type of tile Link is currently standing on. Only the
        ; lower byte is used.

    ; $0116[0x02] - 
        ; Used with routine $008CB0 to transfer 0x800 bytes from $7E1000
        ; to a variable location (determined by this memory location)

    ; $0118[0x02] - 
        ; Local portion of an address used to transfer data from $7FXXXX to
        ; VRAM whenever variable $19 is nonzero.

    ; $011A[0x02] - 
        ; BG1 Y Offset. Gets applied to $0124. Can be used in quakes/shaking

    ; $011C[0x02] - 
        ; BG1 X Offset. Gets applied to $0120

    ; These are extra buffers for the scroll variables in addition to the
    ; $E0,...,$EA registers earlier
    ; $011E[0x02] - 
        ; BG2 Horizontal Scroll Register ($210F)

    ; $0120[0x02] - 
        ; BG1 Horizontal Scroll Register ($210D)

    ; $0122[0x02] - 
        ; BG2 Vertical Scroll Register ($2110)

    ; $0124[0x02] - 
        ; BG1 Vertical Scroll Register ($210E)

    ; $0126[0x01] - 
        ; Seems to be used during dungeon screen transitions as some sort
        ; of counter.

    ; $0127[0x01] - 
        ; Free RAM

    ; $0128[0x01] - 
        ; ???? Seen as 0xFF during the history sequence. When set to 0xFF,
        ; the IRQ routine will disable the IRQ routine the next time it
        ; executes by writing 0x81 to $4200.

    ; $0129[0x01] - 
        ; Free RAM

    ; $012A[0x01] - 
        ; Seems to be a flag for the crystal sequence scripting. As long as
        ; this flag is set, the sequence progresses. Also used for the Triforce
        ; sequences. Triggers a subsection of the NMI routine.

    ; $012B[0x01] - 
        ; Free RAM

    ; $012C[0x01] - (SFX)
        ; Music control
        ; 0x01 - Triforce opening
        ; 0x02 - light world
        ; 0x03 - legend theme
        ; 0x04 - bunny link
        ; 0x05 - lost woods
        ; 0x06 - legend theme
        ; 0x07 - kakkariko village
        ; 0x08 - mirror warp
        ; 0x09 - dark world
        ; 0x0A - restoring the master sword
        ; 0x0B - fairy theme
        ; 0x0C - chase theme
        ; 0x0D - dark world (skull woods)
        ; 0x0E - game theme (Overworld only?)
        ; 0x10 - hyrule castle
        ; 0x11 - Light World Dungeon
        ; 0x13 - fanfare
        ; 0x15 - boss theme
        ; 0x16 - dark world dungeon
        ; 0x17 - fortune teller
        ; 0x18 - caves
        ; 0x19 - sentiment of hope
        ; 0x1A - crystal theme
        ; 0x1B - fairy theme w/ arpeggio
        ; 0x1C - fear & anxiety
        ; 0x1D - Agahnim unleashed
        ; 0x1E - surprise!
        ; 0x1F - Ganondorf the Thief
        ; 0x20 - nothing
        ; 0x21 - Agahnim unleashed
        ; 0x22 - surprise!
        ; 0x23 - Ganondorf the Thief
        ; 0xF1 - fade out
        ; 0xF2 - half volume
        ; 0xF3 - full volume
        ; 0xFF - Load a new set of music.

    ; $012D[0x01] - (SFX)
        ; Ambient Sound effects
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
        ; Sound Effects 1
        ; 0x00 - none (no change)
        ; 0x01 - small sword swing 1 (Fighter Sword)
        ; 0x02 - small sword swing 2 (Fighter Sword)
        ; 0x03 - medium sword swing 1 (Master Sword and up)
        ; 0x04 - fierce sword swing 2 (Master Sword and up)
        ; 0x05 - object clinking against the wall
        ; 0x06 - object clinking Link's shield or a hollow door when poked
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
        ; 0x14 - Link picking something small up?
        ; 0x15 - Weird zapping noise   ; bunny link turning back into a bunny
        ; 0x16 - Link walking up staircase 1        ;  
        ; 0x17 - Link walking up staircase 2 (finishing on next floor)
        ; 0x18 - Link walking down staircase 1
        ; 0x19 - Link walking down staircase 2 (finishing on next floor)
        ; 0x1A - Link walking through grass?
        ; 0x1B - sounds like a faint splash or thud
        ; 0x1C - Link walking in shallow water
        ; 0x1D - picking an object up
        ; 0x1E - some sort of hissing (walking through grass maybe?)
        ; 0x1F - object smashing to bits
        ; 0x20 - item falling into a pit
        ; 0x21 - link landing sound/ boss stepping sound
        ; 0x22 - loud thunderous noise
        ; 0x23 - pegasus boots slippy sound
        ; 0x24 - Link making a splash in deep water (but having to come back out)
        ; 0x25 - Link walking through swampy water
        ; 0x26 - Link taking damage
        ; 0x27 - Link passing out
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
        ; Sound Effects 2
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
        ; 0x2B - Link getting electromucuted
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

    ; $0130[0x01] - 
        ; Something to do with SPC, exact usage is not clear.

    ; $0131[0x01] - 
        ; Something to do with SPC, exact usage is not clear.

    ; $0132[0x01] - 
        ; Buffer for playing songs. Put a value here to try to play a song.
        ; (Will try to write to $012C)

    ; $0133[0x01] - 
        ; Something to do with SPC, exact usage is not clear.

    ; $0134[0x02] - 
        ; VRAM target address for animated tiles. Usually $3B00 or $3C00. 
        ; Remember that if you were to look this stuff up in Geiger's debugger
        ; the byte addresses would actually be $7600 and $7800. SNES VRAM
        ; addresses are expressed as words addresses internally, you just have
        ; to deal with it unfortunately.

    ; $0136[0x01] - 
        ; Flag that toggles when different sets of musical tracks are loaded.
        ; I think the two track sets are normal outdoor and the ending tracks.

    ; $0137[0xC9] - 
        ; Normal (Non-IRQ) Stack

    ; ===========================================================================
    ; Page 0x02
    ; ===========================================================================

    ; $0200[0x01] - 
        ; Sub-submodule index for mode E.

    ; $0201[0x01] - 
        ; Seems to be never referenced (Free RAM?)

    ; $0202[0x01] - 
        ; currently selected item

    ; $0203[0x01] - 
        ; Module 0x0E.0x01 references it but never seems to use it

    ; $0204[0x01] - 
        ; Module 0x0E.0x01 references it but never seems to use it

    ; $0205[0x01] - 
        ; Module 0x0E.0x01 uses it in the creation and destruction of the bottle
        ; submenu as a progress indicator

    ; $0206[0x01] - 
        ; Module 0x0E.0x01 increments it as a frame counter similar to $1A, but
        ; it never seems to get used (debug probably)

    ; $0207[0x01] - 
        ; Module 0x0E.0x01 uses it as a timer for the flashing item selector
        ; circle

    ; $0208[0x01] - 
        ; Countdown timer that controls when the next animation of hearts being
        ; filled in occurs. (The rotating animation)

    ; $0209[0x01] - 
        ; Index related to $0208. When $0208 counts down to zero, $0209 is
        ; incremented, then reassigned modulo 4 (logical and by 0x03)
        ; Determines the graphics used in each step of the heart refil
        ; animation. (4 steps) Once $0209 reaches 4 (which is 0 modulo 4), $020A
        ; is set to zero to indicate that the animation for this particular
        ; heart is finished.

    ; $020A[0x01] - (HUD)
        ; Flag that indicates whether a heart refill animation is taking place.
        ; Nonzero if that is the case.

    ; $020B[0x01] - 
        ; Seems to be a debug value for Module 0x0E.0x01

    ; $020C[0x01] - 
        ; oh naw

    ; $020D[0x01] - 
        ; Used in some submodule of module 0x0E in Bank 0A

    ; $020E[0x01] - 
        ; Floor index for the dungeon map. Floor 1F is the basic floor with
        ; 0x00. 1B is 0xFF. 2F is 0x01. You get the idea.

    ; $020F[0x01] - 
        ; Referenced in Module 0x0E in Bank 0A but doesn't seem to be used.

    ; $0210[0x01] - 
        ; Mostly referenced in Module 0x0E in Bank 0x0A with various specific
        ; usages I've yet to document

    ; $0211[0x02] - 
        ; ???? Shows up in bank 0x0A only. Indexes $0217...

    ; $0213[0x02] - 
        ; Shows up in Bank 0x0A only.

    ; $0215[0x02] - 
        ; Relevant to dungeon map mode sprites...

    ; $0217[0x02] - 
        ; Dungeon map related too?

    ; $0219[0x02] - 
        ; Specifically used as the target address in VRAM for the HUD portion of
        ; the BG3 tilemap. For the entirety of the game this is supposed to stay
        ; as 0x6040 (0xE080 in byte addressing)

    ; $021B[0x02] - 
        ; Free RAM

    ; $021D[0x04] - 
        ; Assigned the value 0x007F4841... doesn't seem to be referenced
        ; anywhere else though Is this meant to reference the address $7F4841

    ; $0221[0x02] - 
        ; Assigned a value of 0xFFFF (-1) in Bank 0x0C, never seems to be
        ; referenced though.

    ; $0223[0x01] - (????)
        ; There's a few STZ.w $0223's that pop up in the rom but other than that
        ; it's not clear if it was ever intended to be used for anything.

    ; $0224[0x0C] - 
        ; Free RAM? - Nope! causes some funky faded effects and a lack of an
        ; overworld.

    ; $0230[0x50] - 
        ; Tentatively considered to be Free RAM at this time

    ; $0280[0x0A] - (Ancilla)
        ; Special object OAM priority (full byte boolean) If nonzero, use highest
        ; priority, otherwise use default priority.

    ; $028A[0x0A] - (Ancilla)
        ; ????

    ; $0294[0x0A] - (Ancilla)
        ; Altitude velocity (Z-coordinate velocity).

    ; $029E[0x0A] - (Ancilla)
        ; Pixel portion of Altitude.

    ; $02A8[0x0A] - (Ancilla)
        ; Subpixel portion of altitude.

    ; $02B2[0x0E] - 
        ; Free RAM

    ; $02C0 - 
        ; bitfield possibly related to inroom staircases. If this variable
        ; masked with 0x0070 is nonzero, Link moves as though he's on an
        ; in-room south staircase If this variable masked with 0x0007 is
        ; nonzero, Link moves as though he's on an in-room north staircase

    ; $02C2 - 
        ; The value of $5F gets cached here sometimes, unclear what $5F is for though right now.

    ; $02C3 - 
        ; ????

    ; $02C4 - 
        ; ????

    ; $02C5 - 
        ; Related to $46 (damage countdown timer)

    ; $02C6[0x01] - 
        ; ????

    ; $02C7[0x01] - 
        ; Probably countdown timer associated with $29

    ; $02C8 - 
        ; ????

    ; $02C9 - 
        ; Very limited usage only in Bank 0x07.

    ; $02CA - 
        ; ????

    ; $02CB[0x01] - (Player)
        ; Very limited usage only in Bank 0x07.

    ; $02CC[0x01] - (Player)
        ; Limited usage in Bank 0x07 and 0x0D.

    ; $02CD[0x02] - (Tagalong)
        ; Counter for the beginning of the game where Zelda telepathically
        ; contacts you over and over again. 

    ; $02CF[0x01] - (Tagalong)
        ; It would appear that this is the index of the current tagalong state
        ; (out of 20 / 0x14 states) Exact usage is not clear, though.

    ; $02D0 - 
        ; ????

    ; $02D1 - 
        ; Cache location for $02D3

    ; $02D2[0x01] - (Tagalong, Player)
        ; When the player loses a Tagalong object, such as the Super Bomb or the
        ; old man, this seems to be a timer before they can be reacquired.

    ; $02D3[0x01] - (Tagalong) ?
        ; ????

    ; $02D4 - 
        ; Apparently a debug variable, doesn't appear to be used in the real game

    ; $02D5 - 
        ; Free RAM

    ; $02D6 - 
        ; ???? relates to tagalongs

    ; $02D7 - 
        ; ????

    ; $02D8[0x01] - (ReceiveItem)
        ; The index of the item you receive when you open a chest or pick up
        ; an item off the ground, or otherwise obtain the item (like the player
        ; getting the sword from the Uncle)

    ; $02D9[0x01] - 
        ; Related to $02D8, haven't worked out the details because it wasn't
        ; necessary yet.

    ; $02DA[0x01] - (Player)
        ; Flag indicating whether Link is in the pose used to hold an item
        ; or not.
        ; 0 - no extra pose.
        ; 1 - (and other value besides 2) holding up item with one hand pose
        ; 2 - holding up item with two hands pose (e.g. triforce)

    ; $02DB[0x01] - (Player)
        ; Triggered by the Whirlpool sprite (but only when touched in Area 0x1B).
        ; The Whirlpool sprite used is not visible to the player, and is placed
        ; in the open perimeter gate to Hyrule Castle after beating Agahnim. I
        ; guess they needed some mechanism to make that happen, and that sprite
        ; was specialized in order to do so. Apparently this is set when warping
        ; to the Dark World?

    ; $02DC - 
        ; Mirror of Link's X coordinate which is used in Bank 07's movement
        ; routines.

    ; $02DE - 
        ; Mirror of Link's Y coordinate which is used in Bank 07's movement
        ; routines.

    ; $02E0[0x01] - (Player)
        ; Flag for Link's graphics set.
        ; 0 - Normal Link
        ; 1 - Bunny Link (Mirrored at $56)
        ; All other values are invalid.

    ; $02E1[0x01] - (Player)
        ; Link is transforming? (Poofing in a cloud to transform into something
        ; else.)

    ; $02E2 - 
        ; Timer for when Link transforms between Link and Bunny modes.

    ; $02E3[0x01] - (Player)
        ; (Slightly uncertain about this) Delay timer between attacks involving
        ; the sword. In essence, the repeat rate at which you are able to swing
        ; your sword. May have an impact on other types of sword attacks like
        ; stabbing and dash attacks.

    ; $02E4[0x01] - (Player)
        ; Flag that, if nonzero, will not allow Link to move. Requires further
        ; research as to its generalized usage. Also... Link cannot bring down
        ; the menu if this is nonzero. Additionally.

    ; $02E5[0x01] - (Player)
        ; Bitfield for chest interaction
        ; uuuucccc
        ; c - touching chest
        ; u - Free RAM

    ; $02E6 - 
        ; Free RAM, but could be used as a bitfield for expanded tile types

    ; $02E7 - 
        ; Bitfield for big key locks and gravestone interactions.
        ; bbbbgggg
        ; b - big key lock
        ; g - gravestone

    ; $02E8 - 
        ; Bitfield for spike / cactus and barrier tile interactions?
        ; bbbbssss
        ; s - spike blocks / cactus tiles
        ; b - orange / blue barrier tiles that are up

    ; $02E9 - 
        ; Item Receipt Method
        ; 0 - Receiving item from an NPC or message
        ; 1 - Receiving item from a chest
        ; 2 - Receiving item that was spawned in the game by a sprite
        ; 3 - Receiving item that was spawned by a special object.

    ; $02EA - 
        ; Set to the tile type

    ; $02EC - 
        ; seems to be a flag for (Link's) collision with bombs. Maybe other uses

    ; $02ED - 
        ; If nonzero, it indicates that Link is near the tile that triggers the
        ; Desert Palace opening with the Book of Mudora

    ; $02EE - 
        ; Bitfield for spike floor and ????? tile interactions
        ; ssssuuud
        ; d - desert palace entrance trigger
        ; s - spike floor tiles
        ; u - not tested

        ; $02EF - 
        ; Bitfield for dashable (breakable with dash) and ????? tile interactions
        ; dddduuuu
        ; d - dashable
        ; u - not tested

    ; $02F0[0x01] - (DesertBarrier)
        ; When nonzero, the Desert Barrier activates and allows link to progress
        ; into the Desert Palace.

    ; $02F1[0x01] - (Player)
        ; ??? related to dashing. Set to 0x40 at start, counts down to 0x20

    ; $02F2[0x01] - (Tagalong)
        ; Used as a bitfield of event flags of a temporary nature relating to
        ; Tagalongs. Specifically these are usually used to indicate if a text
        ; message triggered by a Tagalong has already fired once while being
        ; in a room or an overworld area.

    ; $02F3[0x01] - 
        ; There is one place where the value of zero is written to it,
        ; but otherwise it could be considered Free RAM.

    ; $02F4[0x01] - 
        ; Only use is for caching the current value of $0314 in some instances

    ; $02F5[0x01] - (Player)
        ; 0 - Not on a Somaria Platform.
        ; 2 - On a Somaria Platform.

    ; $02F6[0x02] - (Player)
        ; Bitfield for interaction with Blue Rupee, Grabbable, and Key Door tiles
        ; ssssrrrr kkkkgggg
        ; k - Key Door tiles
        ; g - Tiles grabbable by Hookshot
        ; r - Blue Rupee tile (upper half)
        ; s - Blue Rupee tile (lower half)

    ; $02F8 - 
        ; Flag used to make Link make a noise when he gets done bouncing after
        ; a wall he's dashed into. Thus, it only has any use in relation to
        ; dashing.

    ; $02F9[0x01] - 
        ; Best guess so far: zero if your tagalong is transforming,
        ; nonzero otherwise.

    ; $02FA - 
        ; Flag that is set if you are near a moveable statue (close enough to
        ; grab it)

    ; $02FB - 
        ; Free RAM

    ; ===========================================================================
    ; Page 0x03
    ; ===========================================================================

    ; $0300[0x01] - 
        ; Link's state changes? Happens when using boomerang.
        ; Also related to electrocution maybe?
        ; Also related to recieving an item.

    ; $0301[0x01] - (Player)
        ; bmuaethr
        ; When non zero, Link has something in his hand, poised to strike. It's
        ; intended that only one bit in this flag be set at any time, though.
        ; b - Boomerang
        ; m - Magic Powder
        ; u - Unused
        ; a - Bow and Arrow
        ; e - Tested for, but doesn't seem to correspond to any actual item or
        ; action. Possibly could indicate an item that was cut from the game
        ; during development. It is, in fact, tested for simultaneously with
        ; the hammer in many locations. Perhaps this suggests another
        ; hammer-like item was in the works.
        ; t - Tested for exclusively with the 'r' bit, but no code seems to set
        ; this particular bit. Perhaps at one point the bits for the two rods
        ; were separate at some point?
        ; h - Hammer
        ; r - Ice Rod or Fire Rod

    ; $0302[0x01] - (Player)
        ; ????

    ; $0303[0x01] - (Player)
        ; In conjunction with the above variable when set to 0x13, matching the
        ; above variable, the cape transformation is complete. This indicates
        ; which secondary item is equipped (aka Y-button item).
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

    ; $0304 - 
        ; Related to the magic cape transformation (a flag probably).

    ; $0305 - 
        ; Debug variable only seen in Bank 07. If not equal to 0x01,
        ; it will cause $1E and $1F to not be zeroed out every frame,
        ; which could cause some graphical oddities.

    ; $0306 - 
        ; Apparently only written to as a temporary cache for the
        ; A button action. Never read, so could be considered Free RAM,
        ; though the write to it would have to be disabled.

    ; $0307 - 
        ; Something to do with rods during player sprite OAM handling.
        ; (????)

    ; $0308[0x01] -
        ; Bit 7 - is set when Link is carrying something.
        ; Bit 1 - set when Link is praying?

    ; $0309[0x01] -
        ; 0 - nothing.
        ; 1 - picking up something.
        ; 2 - throwing something or halfway done picking up something.

    ; $030A[0x01] - (PlayerOam)
        ; Step counter used with $030B. Also, $030A-B seem to be used for the
        ; opening of the desert palace

    ; $030B[0x01] -
        ; Animation timer for throwing and picking up items like rocks or signs

    ; $030C - 
        ; ??? Free RAM?

    ; $030D - 
        ; ????

    ; $030E - 
        ; Always seems to be set to 0, and only read during OAM handling
        ; of the player sprite.

    ; $030F - 
        ; Free RAM

    ; $0310 - 
        ; The Y velocity of a moving floor (Mothula's room)

    ; $0312 - 
        ; The X velocity of a moving floor (Mothula's room)

    ; $0314[0x01] - (Player)
        ; The index (the X in $0DD0 for example) of the sprite that Link is
        ; "touching"

    ; $0315[0x01] - 
        ; Seems to be a flag that is set to 0 if Link is not moving, 
        ; and 1 if he is moving. However it doesn't seem to get reset to zero.

    ; $0316 - 
        ; ???? bunny stuffs? 

    ; $0318 - 
        ; related to moving floor

    ; $031A - 
        ; related to moving floor

    ; $031C[0x01] - (Player)
        ; tells us the actual graphic/state to use on the given step of a
        ; spin attack

    ; $031D[0x01] - (Player)
        ; step counter for the spin attack

    ; $031E - 
        ; used as an offset for a table to retrieve values for $031C. The offset
        ; comes in increments of four, depending on which direction Link is
        ; facing when he begins to spin. This makes sense, given that he always
        ; spins the same direction, and allows for reusability between the
        ; different directions, each one being a sub set of the full sequence.

    ; $031F[0x01] - 
        ; Countdown timer that, when it's set, causes Link's sprite to
        ; blink, i.e. flash on and off

    ; $0320 - 
        ; Bitfield for interaction with moving floor tiles
        ; uuuuuuuu uuuummmm
        ; m - Moving floor
        ; u - Free RAM

    ; $0322 - 
        ; ????

    ; $0323[0x01] - (Player, Oam)
        ; Mirror of $2F, which is an indicator for which direction you are
        ; facing. Only used in the rendering of Link's OAM data in Bank 0x0D

    ; $0324[0x01] - (Player)
        ; A flag telling a medallion spell it's okay to proceed with the effect.
        ; If set to 1, the effect will wait until it is set to 0 to activate.

    ; $0325[0x01] - (Free)
        ; Free RAM, with the caveat that it is cleared in some locations in Bank
        ; 0x08.

    ; $0326 - 
        ; ???? collision related?

    ; $0328 - 
        ; ???? collision related?

    ; $032A[0x01] - (Player)
        ; Seems to be nonzero when you hit a button to swim faster. zero
        ; otherwise 

    ; $032B - 
        ; ???? collision related?

    ; $032D - 
        ; ???? collision related?

    ; $032F - 
        ; ???? collision related?

    ; $0331 - 
        ; ???? collision related?

    ; $0333 - 
        ; Stores the tile type that the lantern fire or fire rod shot is
        ; currently interacting with.

    ; $0334 - 
        ; ???? collision related?

    ; $0336 - 
        ; ???? collision related?

    ; $0338 - 
        ; ???? collision related?

    ; $033A - 
        ; ???? collision related?

    ; $033C[0x02] - 
        ; ???? collision related?

    ; $033E[0x02] - 
        ; ???? collision related?

    ; $0340[0x01] - (Player)
        ; Seems to be very closely related to $26 and $67, though the exact
        ; connection is not yet clear. Perhaps it is a scratch variable for
        ; internal calculations during the player logic?

    ; $0341 - 
        ; Bitfield for interaction with deep water and ??? tiles
        ; uuuuuuuu ffffwwww
        ; f - ??? (waterfall maybe?)
        ; u - Free RAM
        ; w - deep water

    ; $0343 - 
        ; Bitfield for interaction with normal tiles
        ; 
        ; uuuuuuuu uuuunnnn
        ; 
        ; n - normal tile
        ; u - Free RAM

    ; $0345[0x01] - (Player)

        ; Set to 1 when we are in deep water. 0 otherwise.

    ; $0346[0x02] -

        ; Exclusively used in Bank 0x0D for the purposes of drawing Link. This
        ; value gets bitwise ORed in to supply the palette bits of Link's
        ; sprite. It's only intended to take on one of two values - 0x000E, or
        ; 0x0000. 0x0E00 indicates that palette 7 is being used, and 0x0000
        ; indicates that palette 0 is being used. Sometimes Link's palette swaps
        ; so that Link won't turn translucent when color addition is active. An
        ; example of this would be in the Flute Boy's meadow when he disappears.
        ; See $0ABD for more info.

    ; $0348[0x02] - (Player)
        ; Bitfield for interaction with icy floor tiles
        ; uuuuuuuu jjjjiiii
        ; u - Free RAM
        ; i - icy tile 1
        ; j - icy tile 2 (distinction is not quite understood right now)
        ; Update: It appears that the 'i' tiles aren't actually .... ice? If
        ; they are used for something else, or at all, we'll have to find that
        ; out eventually.

    ; $034A[0x01] - (Player)
        ; Flag indicating whether Link is moving or not. (I think)

    ; $034B - 
        ; Debug variable, as it is never read, and only written to in the
        ; equipment screen code.

    ; $034C - 
        ; Bitfield for the top of water staircase tile interactions
        ; uuuuuuuu uuuussss
        ; s - water staircase
        ; u - Free RAM

    ; $034E[0x01] -

        ; Definitely related to Cane of Somaria and how Link is displayed when
        ; on a Somaria platform

    ; $034F[0x01] - (Player)
        ; If nonzero, Link does the harder stroke while swimming. This is
        ; triggered by pressing the A, B, or Y buttons while swimming, but ends
        ; shortly. It has no bearing on his swimming speed, though.

    ; $0350[0x01] - (WriteOnly)
        ; Free RAM, though it would need to be reclaimed from the game engine
        ; as it's currently used in several places as an apparent debug variable.
        ; Specifically, it always written to, but never read.

    ; $0351[0x01] - (PlayerOam)
        ; Value that, if set to 1, draws the water ripples around the player
        ; sprite while standing in water. The drawing, of course, uses sprites.
        ; If the value is 2, then a patch of tall grass is instead. Any value
        ; other than 2 (besides 0) produces the water effect.

    ; $0352[0x02] - (PlayerOam)
        ; Used exclusively during writing Link's OAM data (bank 0x0D) as an
        ; offset into the OAM buffer ($0800)

    ; $0354[0x01] - (PlayerOam)
        ; Used exclusively during writing Link's OAM data for currently unknown
        ; purposes.

    ; $0355[0x01] - (PlayerOam)
        ; Secondary water / grass timer. Increments when $0356 reaches 9. Values
        ; range from 0 to 2, and gets set back to 0 when it reaches 3.

    ; $0356[0x01] - (PlayerOam)
        ; Primary water / grass timer. Valuess range from 0 to 8, and gets set
        ; back to 0 when it reaches 9.

    ; $0357 - 
        ; Bitfield for interaction with thick Grass / warp tiles
        ; uuuuuuuu wwwwgggg
        ; g - bits are for thick grass tiles
        ; w - bits are for warp tiles (blue on OW, orange in dungeons)
        ; u - Free RAM

    ; $0359 - 
        ; Bitfield for interaction with shallow water tiles
        ; uuuuuuuu uuuuwwww
        ; w - water tiles
        ; u - Free RAM

    ; $035B - 
        ; Bitfield for interaction with destruction aftermath tiles
        ; (bushes, rockpiles, etc).
        ; uuuuuuuu uuuuaaaa
        ; a - aftermath tiles
        ; u - Free RAM

    ; $035D - 
        ; Used exclusively during writing Link's OAM data (bank 0x0D).
        ; Bitwise ORed in for some of the OAM data.

    ; $035F[0x01] - (Boomerang)
        ; Seems to be a flag indicating that the boomerang is in play. It shows
        ; up in many places so far. Not even sure why it needs this flag...
        ; maybe hackish coding by Nintendo?

    ; $0360[0x01] - 
        ; A flag that, when nonzero, causes Link to be electrocuted when
        ; touching an enemy. This seems counterintuitive to me, but
        ; whatever.

    ; $0361 - 
        ; Free RAM

    ; $0362 - 
        ; ????

    ; $0363 - 
        ; ????

    ; $0364 - 
        ; ???? (relates to Link's sprites's object priority somehow?)
        ; Hard to say if $0365 is coupled or separate from this variable
        ; at this point.

    ; $0366 - 
        ; Flag stating that Link is about to read something (assuming he's
        ; facing north) Used with telepath tiles (dungeon), and signs (overworld)

    ; $0368 - 
        ; The value of $036A shifted right once (divided by two).
        ; Used in the context of lifting tiles like bushes, rocks, etc.
        ; 0x00 - sign
        ; 0x01 - small light rock
        ; 0x02 - green bush
        ; 0x03 - off-color bush
        ; 0x04 - small heavy rock
        ; 0x05 - large light rock
        ; 0x06 - large heavy rock

    ; $0369 - 
        ; The value of $036A shifted left once (multiplied by two).
        ; While this variable may at first glance appear to be used, its
        ; value is never meaningfully inspected or put to good use.
        ; Thus we'll categorize it as "Free RAM" with the caveat that the
        ; modder would have to remove the current (useless) references to
        ; the variable, which number all of 2 times.

    ; $036A - 
        ; When interacting with liftable tiles, this is an index that which type.
        ; Note: This value is always even, for whatever reason.
        ; 0x00 - sign
        ; 0x02 - small light rock
        ; 0x04 - green bush
        ; 0x06 - off-color bush
        ; 0x08 - small heavy rock
        ; 0x0A - large light rock
        ; 0x0C - large heavy rock

    ; $036B - 
        ; ????

    ; $036C[0x01] - 
        ; Action index when interacting with tiles, like pots, rocks, or chests.
        ; 0 - ???
        ; 1 - Picks up a pot or bush.
        ; 2 - Starts dashing
        ; 3 - Grabs a wall
        ; 4 - Reads a sign.
        ; 5 - Opens a chest.
        ; 6 - ???
        ; 7 - ???

    ; $036D[0x01] - (TileDetect)
        ; Detection bitfield for vertical ledge tiles
        ; dddduuuu 
        ; - d bits are for ledge tiles facing down
        ; - u bits are for ledge tiles facing up

    ; $036E[0x01] - (TileDetect)
        ; Detection bitfield for horizontal ledge tiles and up + horizontal
        ; ledge tiles.
        ; ddddhhhh
        ; h - Ledge tiles facing left or right
        ; d - Ledge tiles facing up + left or up + right

    ; $036F[0x01] - (TileDetect)
        ; Detection bitfield for down + horizontal ledge tiles
        ; uuuudddd
        ; d - Ledge tiles facing down + left or down + right
        ; u - Free RAM

    ; $0370[0x01] - (TileDetect)
        ; Bitfield for interaction with unknown tile types
        ; bbbbaaaa
        ; a - type 0x4C and 0x4D tiles (Overworld only)
        ; b - type 0x4E and 0x4F tiles (Overworld only)

    ; $0371[0x01] - (Player)
        ; Countdown timer for frames it will take Link to become tired pushing
        ; against something solid. Once counted down, his appearance will look
        ; flushed and like he's dragging ass. Resets once you stop pushing or
        ; moving.

    ; $0372 - 
        ; Flag indicating whether Link will bounce off if he touches a wall.

    ; $0373[0x01] - (Player)
        ; Putting a non zero value here indicates how much life to subtract from
        ; Link. (quick reference: 0x08 = one heart)

    ; $0374 - 
        ; Countdown timer for when Link is about to dash. When it reaches
        ; 0 he starts dashing. starts as 0x1D

    ; $0375[0x01] - 
        ; This is the timer the is used to count down how long it takes before
        ; Link can jump off a ledge. It is typically set to 19 (0x13) frames,
        ; though I don't believe it decrements every frame.

    ; $0376 - 
        ; bit 0: Link is grabbing a wall.

    ; $0377[0x01] - (Player)
        ; Related to the Master Sword ceremony somehow. Maybe other uses.

    ; $0378[0x01] - 
        ; Apparently a countdown timer of some sort. Only seen in Bank
        ; 0x07. Two domains of usage seem to be climing staircases and
        ; pushing walls.

    ; $0379 - 
        ; Flag that, if set, A button isn't read.

    ; $037A[0x01] - (Player)
        ; Puts Link in various positions, 1 - shovel, 2 - praying, etc...
        ; cane of somaria. May also have something to do with bombs?

    ; $037B[0x01] - (Player)
        ; If nonzero, disables Link's ability to receive hits from
        ; sprites. (But not pits)

    ; $037C - 
        ; Determines the player's behavior during "player behavior" mode
        ; 0x16 (see variable $5D). Somewhat parallels $037D as it only
        ; is intended to have 3 states (0 through 2, inclusive).

    ; $037D[0x01] - (Player)
        ; Used to determine the player sprite's pose during the opening
        ; sequence. It only takes on 3 values:
        ; 0 - Player is in bed with eyes shut.
        ; 1 - Player is in bed with eyes open.
        ; 2 - Player is jumping out of bed.
        ; This value also affects the player's bedspread (unfurls the
        ; covers once hitting state 1).

    ; $037E[0x01] - (Player), (Hookshot)
        ; Bit 0 - Hookshot is dragging Link somewhere.
        ; Bit 1 - ???? seems like it gets toggled every 3 frames, or
        ; something like that.

    ; $037F[0x01] - 
        ; Walk through walls and anytime warping in outdoors.
        ; Apparently if nonzero, all tile attributes are $00 (nothing / passable)

    ; $0380[0x05] - (Ancilla)
        ; ???? Special effect related, of course.

    ; $0385 - 
        ; special effect ???

    ; $038F - 
        ; special effect ???

    ; $0394[0x05] - (Ancilla)
        ; special effect ???

    ; $0399[0x02] - (Boomerang), (Wtf)
        ; Used as a temporary copy of the boomerang's y coordinate when
        ; calculating where to place the wall hit object that results from the
        ; boomerang hitting a wall. No other uses.

    ; $039B[0x02] - (Boomerang), (Wtf)
        ; Used as a temporary copy of the boomerang's y coordinate when
        ; calculating where to place the wall hit object that results from the
        ; boomerang hitting a wall. No other uses.

    ; $039D[0x01] - (Hookshot), (Boomerang)
        ; Index of the hookshot effect so that the player module can use it to
        ; help move the player if

    ; $039E - 
        ; Free RAM

    ; $039F - 
        ; Special Effect Timers

    ; $03A4[0x0?] - 
        ; Referenced in receive item initializer  

    ; $03A9[0x05] - (Ancilla)
        ; Special effect ???

    ; $03AE - 
        ; Free RAM (Though I am not sure of this entirely)

    ; $03B1[0x05] - 
        ; countdown timer for special objects (note that there are only 5 of
        ; these whereas there's usually 10 slots for special objects)

    ; $03B6 - 
        ; 16-bit values relating to bomb doors
        
    ; $03BA - 
        ; 16-bit values relating to bomb doors

    ; $03BE - 
        ; 8-bit values relating to bomb doors

    ; $03C0 - 
        ; Reserved for rock debris special object (0x08)

    ; $03C2 - 
        ; Reserved for rock debris special object (0x08)

    ; $03C4[0x01] - (Ancilla)
        ; Reserved for rock debris special object (0x08) and maybe bombs too.

    ; $03C5[0x05] - (Ancilla)

        ; Special Object WRAM.

    ; $03CA[0x05] - (Ancilla)

        ; Used by some special objects as the pseudo bg selector.

    ; $03CF - 
        ; Special Object WRAM.

    ; $03D2 - 
        ; Special Object WRAM.

    ; $03D5 - 
        ; Special Object WRAM.

    ; $03DB[0x06] - (Ancilla)
        ; Special Object WRAM.

    ; $03E1 - 
        ; Special Object WRAM.

    ; $03E4 - 
        ; Special object WRAM for tile interactions. Bombs and ice rod
        ; shots in particular use this.

    ; $03E9[0x01] - 
        ; Flag that seems to set when moving gravestones are in play and puzzle
        ; sound is playing.

    ; $03EA - 
        ; special effect ???

    ; $03EF[0x01] - (Player, PlayerOam)
        ; Normally zero. If set to nonzero, it forces Link to the pose
        ; where he is holding his sword up. One example of where this is
        ; used is right after Ganon is defeated.

    ; $03F0[0x01] - (Flute)
        ; Countdown timer for playing the flute. Prevents it from being played
        ; less than 0x80 frames apart.

    ; $03F3 - 
        ; ????

    ; $03F4 - 
        ; Seems related to Cane of Somaria somehow

    ; $03F5[0x02] - (Player)
        ; The timer for Link's tempbunny state. 
        ; When it counts down he returns to his normal state. When Link is hit it
        ; always falls to zero. Is always set to 0x100 when a yellow hunter
        ; (transformer) hits him. If Link is not in a normal mode, however, it
        ; will have no effect on him. The value is given in frames, so if the
        ; value written is 0x80, you will be a bunny for 128 frames.

    ; $03F7[0x01] - (Player)
        ; Flag indicating whether the "poof" needs to occur for Link to transform
        ; into the tempbunny.

    ; $03F8[0x01] - 
        ; Flag set if you are near a PullForRupees sprite

    ; $03F9[0x01] - 
        ; ???? Something to do with the Hookshot.

    ; $03FA[0x02] - 

        ; Relates to Link's OAM routine in Bank 0D somehow. Appears to be the
        ; 9th bit of the X coordinate of some sprite(s).

    ; $03FC - 
        ; ????

    ; $03FD[0x01] - (TravelBird)
        ; This is a flag that is set when the travel bird shows up indoors, which
        ; under vanilla circumstances is only in Agahnim's second boss fight
        ; room.

    ; $03FE - 
        ; Free RAM.

    ; ===========================================================================
    ; Page 0x04
    ; ===========================================================================

    ; For a break down on how room data gets saved, see the SRAM Document.

    ; $0400 - 
        ; Tops four bits: In a given room, each bit corresponds to a
        ; door being opened. If set, it has been opened by some means
        ; (bomb, key, etc.)

    ; $0402 - 
        ; Certainly related to $0403, but contains other information I haven't
        ; looked at yet.

    ; $0403 - 
        ; Contains room information, such as whether the boss in this room
        ; has been defeated. Loaded on every room load according to map
        ; information that is stored as you play the game.
        ; Bit 0: Chest 1
        ; Bit 1: Chest 2
        ; Bit 2: Chest 3
        ; Bit 3: Chest 4
        ; Bit 4: Chest 5
        ; Bit 5: Chest 6 / A second Key. Having 2 keys and 6 chests will cause conflicts here.
        ; Bit 6: A key has been obtained in this room.
        ; Bit 7: Heart Piece has been obtained in this room.

    ; $0404 - 
        ; Free RAM

    ; $0405 - 
        ; Free RAM? Never written to, but read in one instance in bank
        ; 0x00.

    ; $0406 - 
        ; Free RAM

    ; $0408 - 
        ; Only lowest 4 bits are used. Record of the quadrants that Link
        ; has visited in the current room.
        ; This is written back to SRAM when the player leaves the current
        ; room. Specifically, the lowest 4 bits are bitwise ORed back
        ; into the SRAM location for the room ($7ef000[0x280]).

    ; $040A - 
        ; Area Index for the Overworld. Although there are 0xC0 different
        ; possible values, the larger maps seem to take up more of these
        ; values so that coordinate addresses can be more easily
        ; calculated, and scrolling eliminated at times.

    ; $040B - 
        ; Free RAM

    ; $040C[0x02] - (Dungeon)
        ; Dungeon ID / Dungeon index. If it's equal to 0xFF, that means there
        ; is no map for that area.
        ; There is a data table of values, probably depends on the
        ; entrance you go in how this gets selected. Notably used in
        ; Ganon's Tower for minibosses.  Note that the value held here is
        ; the dungeon's intuitive index multiplied by 2.
        ; Hence, this value is always even.
        ; 0x00 - Sewer Passage
        ; 0x02 - Hyrule Castle
        ; 0x04 - Eastern Palace
        ; 0x06 - Desert Palace
        ; 0x08 - Hyrule Castle 2
        ; 0x0A - Swamp Palace
        ; 0x0C - Dark Palace
        ; 0x0E - Misery Mire
        ; 0x10 - Skull Woods
        ; 0x12 - Ice Palace
        ; 0x14 - Tower of Hera
        ; 0x16 - Gargoyle's Domain
        ; 0x18 - Turtle Rock
        ; 0x1A - Ganon's Tower
        ; 0x1C - ??? possibly unused. (Were they planning two extra dungeons perhaps?)
        ; 0x1E - ??? possibly unused.

    ; $040E - 
        ; Contains the layout and starting quadrant info
        ; (from dungeon header)

    ; $040F - 
        ; Zeroed by a 16-bit write to $040E in only one location.
        ; Otherwise, it could technically be considered Free RAM.

    ; $0410 - 
        ; -------- ----udlr   Screen transition direction bitfield
        ; When the overworld is transitioning screens, only one of the "udlr"
        ; bits will be set.

    ; $0412 - 
        ; Index used during screen transitions to gradually, over the
        ; course of several frames, transmit data to VRAM.
        ; See variables $19 and $0118

    ; $0414 - 
        ; BG2 properties in Hyrule Magic
        ; Detailed description of CGADDSUB properties per type:
        ; Note that both parallax modes are the same from the register standpoint
        ; 0 - "Off"        ;    - Main: BG2, BG3, Obj;  Sub: None; +/-: background
        ; 1 - "Parallaxing"   - Main: BG2, BG3, Obj;  Sub: BG1; +/-: background
        ; 2 - "Dark Room"     - Main: BG2, BG3, Obj;  Sub: BG1, BG1; +/-: background
        ; 3 - "On top"        ; - Main: BG1, BG2, BG2, Obj; Sub: None; +/-: background
        ; 4 - "Translucent"   - Main: BG2, BG3, Obj;  Sub: BG1; +/-: (1/2 +) back. BG1
        ; 5 - "Parallaxing 2" - Main: BG2, BG3, Obj;  Sub: BG1; +/-: background
        ; 6 - "Normal"        ; - Main: BG2, BG3, Obj;  Sub: BG1; +/-: background
        ; 7 - "Addition"      - Main: BG2, BG3, Obj;  Sub: BG1; +/-: (full +) back. BG1

    ; $0416 - 
        ; -------- ----udlr   Screen transition direction bitfield 2
        ; When the overworld is transitioning screens, only one of the "udlr" bits
        ; will be set.
        ; 

    ; $0418 - 
        ; 0 - Overworld screen transition up
        ; 1 - Overworld screen transition down
        ; 2 - Overworld screen transition left
        ; 3 - Overworld screen transition right
        ; 
        ; Values greater than 3 should not show up

    ; $041A - 
        ; vvvvvvvv vvvvvvid

        ; d - disable horizontal and vertical 
        ; i - inverts the direction of the floor movement, specified by $0310 / $0312
        ; v - if any of these bits are set, the floor movement will be vertical. Otherwise it will be horizontal

    ; $041C - 
        ; ??? referenced in trick hidden walls
        ; The value of this is used by various "Effect" settings in the dungeons

    ; $041E - 
        ; ???

    ; $0420 - 
        ; Zeroed at one location, but could otherwise be considered
        ; Free RAM.

    ; $0422[0x02] - 
        ; X offset of the moving floor. (Also used to position the crystal
        ; maidens during the 3D sequence)

    ; $0424[0x02] - 
        ; Y offset of the moving floor. ""

    ; $0426 - 
        ; Free RAM

    ; $0428[0x01] - 
        ; Mirror of $AD, which is "Collision" in Hyrule Magic. This is an
        ; independent flag that determines how scrolling of the BGs occurs in
        ; the dungeon submodule.

    ; $0429 - 
        ; Free RAM?

    ; $042A - 
        ; Used with Hidden walls? Maybe other uses. See bank $01

    ; $042C - 
        ; Types that use this index: moveable blocks, pots and other liftable
        ; objects, breakable floors, and moles. Collectively the limit for these
        ; types of objects is 16 per room. Notes about cracked floors so I don't
        ; go insane: The breakable floor that is first in the object list is the
        ; the one that will open up. (Do ctrl-B on a cracked floor among others
        ; in hyrule magic if you don't believe me). Okay... so why does only one
        ; cracked floor open up? It doesn't make any sense right? The tile type
        ; is 62 for all cracked floors post load.

    ; $042E - 
        ; Index of torches in the room (since blocks are loaded first this value
        ; gets updated after the fact.)

    ; $0430 - 
        ; Flag that is nonzero when Link has triggered a floor switch and is
        ; still standing on it. When he walks away from it, this flag will
        ; reset to zero.

    ; $0432 - 
        ; number of star shaped switches in a room

    ; $0434 - 
        ; Free RAM?

    ; $0436[0x01] - 
        ; ????

    ; $0437[0x01] - 
        ; ????

    ; $0438 - 
        ; number of in-floor inter-room up-north staircases (1.2.0x2D)

    ; $043A - 
        ; number of in-floor inter-room down-south staircases
        ; (1.2.0x2E, 1.2.0x2F)

    ; $043C - 
        ; number of in-room up-north staircases (1.2.0x30)

    ; $043E - 
        ; number of in-room up-north staircases (1.2.0x31)

    ; $0440 - 
        ; number of inter-pseudo-bg up-north staircases (1.2.0x32)

    ; $0442 - 
        ; number of in-room up-north staircases (1_2.0x33) (for use in water
        ; rooms)

    ; $0444 - 
        ; number of activated water ladders (1.2.0x35)

    ; $0446 - 
        ; number of water ladders (1.2.0x36)

    ; $0448 - 
        ; This is tracking variable for dungeon objects with the catch that
        ; it is only used in rooms that have water objects (not 100% sure of
        ; this.) But it seems to be the activator that converts normal inter-bg
        ; type staircases to ones that let you jump into water, like in the
        ; Swamp Palace.

    ; $044A[0x02] - 
        ; Something to do with in-room staircases, but I'm otherwise clueless

    ; $044C - 
        ; Free RAM

    ; $044E - 
        ; Number of "toggle floor" door properties that are in the
        ; array $06C0. This number shouldn't exceed 8.

    ; $0450 - 
        ; Number of "toggle palace" door properties that are in the
        ; array $06D0. This number shouldn't exceed 8.

    ; $0452 - 
        ; ???? seen used with blast walls but otherwise, not sure

    ; $0454[0x02] - (Dungeon)
        ; Seems to indicate the state of a blast wall being opened. Ranges from
        ; 0x01 to 0x15. The numerical value probably is used to pick which
        ; section of the wall to blast open on a given frame.

    ; $0456 - 
        ; Used by doors system? Not sure how exactly.

    ; $0458[0x02] - (Dungeon)
        ; 0 - In a dark room
        ; 1 - you're in a dark room and have the lantern

    ; $045A[0x01] - 
        ; Seems to be the number of torches that are lit in a dark room.
        ; Torch objects during load can be set to be permanently lit,
        ; so this can affect how the room's lighting behaves.

    ; $045B - 
        ; ????

    ; $045C - 
        ; ????

    ; $045E - 
        ; Free RAM

    ; $0460 - 
        ; Number of Locked doors? (range 0 - 3?) Number of doors that have been
        ; loaded in the room?

    ; $0462[0x02] - 
        ; ??? related to submodule 12 of modules 7 and 9
        ; With staircases, indicates a value of 0 to 7 of which staircase it is.
        ; Specifically, a the straight up staircases will signal with a
        ; value ranging from 0 to 3. Straight down staircases use 4 to 7.

    ; $0464 - 
        ; ????

    ; $0466 - 
        ; Seems to be related to trap doors or switches somehow...

    ; $0468[0x02] - 
        ; Flag that is set when trap doors are down.

    ; $046A - 
        ; Similar to $0490, this is Floor 2 in Hyrule Magic

    ; $046C - 
        ; "Collision" in Hyrule Magic.

    ; $046D - 
        ; Free RAM

    ; $0470[0x02] - 

    ; $0472 - 
        ; This is the tilemap address of the watergate barrier, and it is
        ; only written to if the watergate is unopened. The submodule
        ; (0x0d) of the dungeon module (0x07) whose responsibility it is
        ; to open the watergate uses this.

    ; $0474 - 
        ; Limited use between Bank 0x01 and 0x07.

    ; $0476[0x02] - 
        ; Pseudo bg level. Indicates which "level" you are on, either BG1 or
        ; BG2. BG1 is considered 1 in many cases. However, there is no need for
        ; BG1 necessarily. When Link can interact with BG1, this value should
        ; match $00EE, I think. This mostly applies to staircases in rooms that
        ; only use one BG to interact with.

    ; $0478 - 
        ; ????

    ; $047A[0x02] - 
        ; Flag that goes high when the player is jumping off of a ledge. Used to
        ; signal that a layer adjustment is necessary for the player, and maybe
        ; other stuff too...

    ; $047C - 
        ; Used with doors.

    ; checked first?

    ; $047E - 
        ; number of wall up-north spiral staircases (1.2.0x38)

    ; $0480 - 
        ; number of wall down-north spiral staircases (1.2.0x39)

    ; $0482 - 
        ; number of wall up-north spiral staircases (1.2.0x3A)

    ; $0484 - 
        ; number of wall down-north spiral staircases (1.2.0x3B)

    ; $0486 - 
        ; ????
    ; $0488 - 
        ; ????

    ; $048A - 
        ; Relates to the plane variables ($063C-$0640)

    ; $048C - 
        ; ????

    ; $048E[0x02] - 
        ; Room index in dungeons?

    ; $0490 - 
        ; In a dungeon room, provides the type of filler tiles (Floor 1 in
        ; Hyrule Magic)

    ; $0492 - 
        ; ????
    ; $0494 - 
        ; ????

    ; $0496[0x02] - (Dungeon)
        ; Used to track the number of chests in the current room. Because it
        ; indexes into an array of 16-bit values, it is always twice the actual
        ; number of chests present.

    ; $0498[0x02] - (Dungeon)
        ; Used to track the number of big key lock blocks in the current room.
        ; It is equal to twice the number of chests plus twice the number of big
        ; key locks. This is due to the fact that it indexes into an array of
        ; 16-bit tilemap addresses, and that this array of addresses is shared
        ; between chests and the big key locks.

    ; $049A - 
        ; number of 1.3.0x1B objects

    ; $049C - 
        ; number of 1.3.0x1C objects

    ; $049E - 
        ; number of 1.3.0x1D objects

    ; $04A0 - 
        ; Countup timer that stops at 0xC0. While running, the floor that Link
        ; is on in a dungeon is displayed.

    ; $04A1 - 
        ; Free RAM, probably

    ; $04A2 - 
        ; number of in-wall inter-room up-north straight staircases
        ; (1.3.0x1E, 0x26)

    ; $04A4 - 
        ; number of in-wall inter-room up-south straight staircases
        ; (1.3.0x20, 0x28)

    ; $04A6 - 
        ; number of in-wall inter-room down-north straight staircases
        ; (1.3.0x1F, 0x27)

    ; $04A8 - 
        ; number of in-wall inter-room down-south straight staircases
        ; (1.3.0x21, 0x29)

    ; $04AA[0x02] - (conflict)
        ; Flag, that if nonzero, tells us to load using a starting point
        ; entrance value rather than a normal entrance value.

    ; $04AA - 
        ; This is used when you die and choose to save & continue
        ; It is the dungeon entrance to put Link into.
        ; This variable is only used if you die in a dungeon, and is set to the
        ; last dungeon entrance you went into.

    ; $04AB - 
        ; Free RAM (disputed, see $04AA[0x02])

    ; $04AC - 
        ; When most tiles are changed in a particular overworld screen
        ; this value is incremented by 2 and $7EF800 and $7EFA00 are
        ; updated to contain the address of the modification and the tile
        ; (map16) used to replace it.  This only comes into play when a
        ; warp between the DW or the LW fails and you have to warp back.

    ; $04AE - 
        ; number of in-room up-south staircases (1.3.0x33) (for use in
        ; water rooms)

    ; $04B0 - 
        ; ???? Relates to object type 1.1.0x35
        ; Which, by the way, seems to be unused... and buggy.
        ; If it were used, this would appear to be a tilemap address,
        ; with an extra bit at the top for... unknown reasons.

    ; $04B2 - 
        ; Related to shovel, but not entirely clear yet how. Sometimes
        ; this is handled as a 16-bit value, and others as an 8-bit
        ; value.

    ; $04B4 - 
        ; see overworld module submodule 0x00

    ; $04B5 - 
        ; ????

    ; $04B6 - 
        ; Position in tile attribute buffer where trigger tile was hit.
        ; Also used with star tiles.

    ; $04B8 - 
        ; Flag that indicates you are close to a big key door, and the
        ; text message saying you don't have a key has already triggered.
        ; It resets when you move away from the door.
        ; Also used outdoors when a door tells you you can't enter with
        ; stuff following you.

    ; $04BA - 
        ; Index of overlay to load in a dungeon room
        ; (in response to an event, typically).

    ; $04BC - 
        ; Seems to be a toggle between two different states of holes in a room.
        ; (For rooms that can switch back and forth?)

    ; $04BE - 
        ; Countdown timer for trinexx red dragon head palette transitioning
    ; $04BF - 
        ; Countdown timer for trinexx blue dragon head palette transitioning

    ; $04C0 - 
        ; Relates to trinexx red dragon head palette transition state
    ; $04C1 - 
        ; Relates to trinexx blue dragon head palette transition state

    ; $04C2[0x01] - (Dungeon)
        ; Its only use is as a delay timer for falling milestone objects after a
        ; boss fight. Specifically, crystals and pendants.
        ; Note: It's well known among glitchers that beating a boss from one
        ; palace when having entered a different palace can cause the ether
        ; medallion to fall instead of the proper item for that boss. This is
        ; due to the fact that the same object is used for granting the Bombos
        ; and Ether medallions (from the sky in that case.) The game just gets
        ; confused.

    ; $04C3 - 
        ; Free RAM

    ; $04C4[0x01] - (Undesignated)
        ; Number of credits left for opening minigame chests 0xFF if entirely
        ; disabled

    ; $04C5 - 
        ; State dealing with Ganon's fight:
        ; 2 - you can hit him,
        ; 1 - he's translucent
        ; 0 - invisible

    ; $04C6 - 
        ; Trigger for special animations
        ; 0 - nothing
        ; 1 - Dark Palace entrance
        ; 2 - Skull Woods entrance (when it burns)
        ; 3 - Misery Mire entrance
        ; 4 - Turtle Rock entrance
        ; 5 - Ganon's Tower entrance

    ; $04C7 - 
        ; Appears to serve as a barrier variable for tag related logic in
        ; Dungeon rooms when set.
        ; Also prevents traveling on staircases and other such things.

    ; $04C8 - 
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

    ; $04CA[0x01] - 
        ; When you are low on life, this is used as a timer. It loops between
        ; 0x1F down to 0x00. When it reaches zero, the low life beep happens.

    ; $04CB[0x25] - 
        ; Free RAM.

    ; $04F0[0x10] - (Dungeon)
        ; Timers for Torches (byte entries). When lit, starts with a value of
        ; 0xFF and counts down to 0. Setting it before the torch is lit is a bad
        ; idea - it will not cause a torch to light, nor will it brighten the
        ; room. Note that this range indicates we can have up to 16 torches in
        ; an area.

    =============================================================================
    = Page 0x05
    =============================================================================

    ; $0500[0x20] - 
        ; replacement tile attributes for moveable/liftable/poundable objects.

    ; $0520[0x20] - 
        ; Object's position in the object data itself (multiplied by 3)

    ; $0540[0x20] - 
        ; Object's tilemap position

    ; $0560[0x20] - 
        ; replacement tilemap value (upper left 8x8 tile)

    ; $0580[0x20] - 
        ; replacement tilemap value (lower left 8x8 tile)

    ; $05A0[0x20] - 
        ; replacement tilemap value (upper right 8x8 tile)

    ; $05C0[0x20] - 
        ; replacement tilemap value (lower right 8x8 tile)

    ; $05E0[0x04] - 
        ; see routine $3ED3F

    ; $05E4[0x04] - 
        ; see routine $3ED3F

    ; $05E8[0x04] - 
        ; see routine $3ED3F

    ; $05EC[0x04] - 
        ; see routine $3ED3F

    ; $05F0[0x04] - 
        ; see routine $3ED3F

    ; $05F4[0x04] - 
        ; see routine $3ED3F

    ; $05F8[0x04] - 
        ; see routine $3ED3F

    ; $05FC[0x02] - 
        ; Two byte array. Each one contains the index of a dungeon object that
        ; could potentially be changed. Examples include pots and moveable
        ; blocks. The value stored is the index of the object plus one, because
        ; a value of 0 means that a slot is empty. When comparisons are done,
        ; the value is read out and decremented by one before comparison.

    ; ===========================================================================
    ; Page 0x06
    ; ===========================================================================

    ; $0600 - 
        ; ??? These four are Y coordinate related

    ; $0602 - 
        ; ??? ''

    ; $0604 - 
        ; ??? ''

    ; $0606 - 
        ; ??? ''

    ; $0608 - 
        ; ???? These four are X coordinate related

    ; $060A - 
        ; ????

    ; $060C - 
        ; ????

    ; $060E - 
        ; ????

    ; $0610 - 
        ; ??? Up    room transition scroll target

    ; $0612 - 
        ; ??? Down  ""

    ; $0614 - 
        ; ??? Left  ""

    ; $0616 - 
        ; ??? Right ""

    ; Camera Variables:

    ; $0618 - 
        ; Y coordinate of the scrolling camera. Probably the lower bound
         ;for scrolling.

    ; $061A - 
        ; Y coordinate of the upper bounds of scrolling.

    ; $061C - 
        ; X coordinate of the lower bounds of scrolling.

    ; $061E - 
        ; X coordinate of the upper bounds of scrolling.

    ; Ending Sequence Variables:

    ; $0620 - 
        ; ????

    ; $0622 - 
        ; ????

    ; $0624 - 
        ; ????

    ; $0626 - 
        ; ????

    ; $0628 - 
        ; ????

    ; $062A - 
        ; ????

    ; $062C - 
        ; In loading dungeons, contains the upper even byte of the BG1 H 
        ; scroll reg.

    ; $062E - 
        ; In loading dungeons, contains the upper even byte of the BG1 V
        ; scroll reg. note: upper even byte refers to the operation
        ; (argument & 0xFE00)

    ; BG3 V-IRQ Values:

    ; $0630 - 
        ; During V-IRQ or H-IRQ (not sure if this game uses H-IRQ), these
        ; are the values of the BG3 Hscroll Register.

    ; $0631 - 
        ; This is the upper byte of the previous address.

    ; $0632 - 
        ; Free RAM

    ; $0635[0x01] - (Overworld_Map)
        ; Written to twice in bank 0x0A, but seems to never be read or used
        ; for anything. Perhaps this was part of an unimplemented additional
        ; feature of the overworld map.

    ; $0636[0x01] - (Overworld_Map)
        ; Bit layout:
        ; t-------s
        ; 
        ; s - Selects between hdma table low byte A bus addresses for the
        ; hdma table responsible for mode 7 manipulation.
        ; 
        ; t - Set in order to indicate that the zoom mode needs to be
        ; toggled. It will be unset once the toggling is completed.

    ; $0637[0x01] - (Overworld_Map)
        ; While it appears to be set in a manner that is consistent with the
        ; Attract Mode usage of this same variable, it is not actually used at
        ; all in this submodule of the messaging module.

    ; $0637[0x01] - (Attract)
        ; Timer for the Mode 7 zoom in sequence. Affects the zoom level
        ; indirectly by serving as the value that a table of values gets
        ; multiplied by to produce an hdma table.

    ; $0638[0x02] - (Overworld_Map, Attract)
        ; Mirror of $211F (M7X)

    ; $063A[0x02] - (Overworld_Map, Attract)
        ; Mirror of $2120 (M7Y)

    ; $063C - 
        ; Hole / Teleporter plane 

    ; $063D - 
        ; Staircase 1 plane

    ; $063E - 
        ; Staircase 2 plane

    ; $063F - 
        ; Staircase 3 / door plane

    ; $0640 - 
        ; Staircase 4 / door plane

    ; $0641 - 
        ; Flag that is nonzero when a moveable block that triggers something
        ; is pushed in a dungeon room.

    ; $0642 - 
        ; apparently a flag for indicating a state change in water puzzle rooms.
        ; (And hidden wall rooms?)

    ; $0643 - 
        ; Free RAM?

    ; $0646[0x01] - (Dungeon)
        ; Educated guess: this is a flag that is nonzero when a cane of Somaria
        ; block is on top of a switch that needs to be weighed down.

    ; $0647[0x01] - (Player) 
        ; Used exclusively with electrocution mosaic logic as a flag.
        ; 0       - Mosaic increases each frame.
        ; Nonzero - Mosaic decreases each frame.

    ; $0648[0x28] - 
        ; Free RAM

    ; $0670 - 
        ; presumably all related to spotlight hdma or the setup of it
        ; $0670[0x02] - 
        ; $0672 - 
        ; Free RAM
        ; $0674 - 
        ; Y lower range (around player)
        ; $0676 - 
        ; Y upper range (around player)
        ; $0678[0x02] - 
        ; $067A - 
        ; Dividend of some sort
        ; $067C - 
        ; Divisor of some sort
        ; $067E[0x02] - 

    ; $0680 - 
        ; Water hdma related...

    ; $0682 - 
        ; Water hdma related...

    ; $0684 - 
        ; Water hdma related...

    ; $0686 - 
        ; Water hdma related...

    ; $0688 - 
        ; Watergate hdma related...

    ; $068A - 
        ; Watergate hdma related...

    ; $068C[0x02] - 
        ; Top 4 bits hold information about which doors have been opened.
        ; Update: Or are currently open? Man, what a miserable system!

    ; $068E[0x02] - (Dungeon)
        ; ???? related to trap doors and if they are open ; possibly bomb doors
        ; too? Update: module 0x07.0x4 probably uses this to know whether it's
        ; a key door or big key door to open.

    ; $0690[0x02] - (Overworld)
        ; Generally is used as an animation step indicator, only for doors that
        ; animate when they open, such as the Santuary and Hyrule Castle doors.
        ; This variable is incremented up to a value of 3, at which point a
        ; logic check kicks in and stops animating the opening of a door.

    ; $0690[0x03] - (Dungeon)
        ; Similarly to the overworld version of this variable, it's used in the
        ; animation of doors opening. However, it's also used for doors closing,
        ; and in particular the types of doors we're talking about are the trap
        ; doors that look like nasty skull faces. Values range from 0 (closed) to
        ; 7 (open).

    ; $0692[0x02] - (Overworld)
        ; Contains the resultant map16 value of the most recently modified map16
        ; tile. (i.e. when picking up a bush/rock) 

    ; $0692[0x02] - (Dungeon)
        ; Relates to doors being opened or closed.

    ; $0694 - 
        ; ????

    ; $0696 - 
        ; Entrance value. If 0x0000 indicates no doorway on OW.
        ; Values < 0x8000 indicate tilemap coordinates for a wooden doorway.
        ; 0xFFFF indicates there is no doorway and you will come out facing the opposite direction (see north exit of bottle house in Kakkariko).
        ; Possibly also used for pits? Values >= 0x8000 indicate a special type of door + coordinates ranging from 0x0000 to 0x1FFF,
        ; found by bitwise AND with the value and 0x1FFF. (i.e. if( b >= 0x8000) { tilemapAddr = b & 0x1FFF ; type = special; }
        ; This is also the thing HM seems to have so much trouble editing.

    ; $0698[0x02] - (Overworld)
        ; When lifting a big rock, this is the starting address of where the hole
        ; graphic will get stored to.

    ; $069A[0x01] - (Overworld)
        ; Countdown timer for certain overworld transitions, during which the player
        ; sprite will continue to move. These transitions include coming out of doors
        ; from the indoor areas, as well as transitions between the normal overworld
        ; and special overworld areas.

    ; $069B - 
        ; Free RAM

    ; $069C - 
        ; ???? Seems to be sometimes used as 16-bit, others as 8-bit.

    ; $069E - 
        ; ???? 
        ; Overworld horizontal scroll related?

    ; $069F[0x01] - 
        ; ????

    ; $06A0[0x0?] - (Dungeon) Special object slots for stars type 1.2.0x1F.

    ; $06A0[0x02] - (Overworld) Magic mirror module variable that toggles between 0
        ; and 2 whenever accessed.

    ; $06A2 - 
        ; ????

    ; $06A4 - 
        ; ????

    ; $06A6 - 
        ; ????

    ; $06A8 - 
        ; ????

    ; $06AA - 
        ; ????

    ; $06AC - 
        ; ????

    ; $06AE - 
        ; ????

    ; $06B0 - 
        ; special object slots for type 1.3.0x1E,0x1F,0x20,0x21
        ; and 1.2.0x2D,0x2E,0x2F,0x38,0x39,0x3A,0x3B objects

    ; $06B8[0x08] - (Dungeon)
        ; 
        ; special object slots for type 1.3.0x1B and 1.2.0x30,0x31,0x32,0x33,0x35,0x36

    ; $06BA[0x01] - (MirrorWarp)
        ; 
        ; Seems to be a delay counter that waits for 0x20 frames before
        ; starting the mirror warp sequence in earnest.

    ; $06C0 - 
        ; Slots for floor toggle door properties (type 0x16 "doors").
        ; These are not actually doors, but rather the coordinates where
        ; the floor toggle property should be applied to actual doors.
        ; 
        ; The number of populated slots in this array is determined by
        ; ; $044E

    ; $06D0 - 
        ; Slots for palace toggle door properties (type 0x14 "doors").
        ; These are not actually doors, but rather the coordinates where
        ; the palace toggle property should be applied to actual doors.
        ; 
        ; The number of populated slots in this array is determined by
        ; ; $0450.

    ; $06E0 - 
        ; Stores tilemap positions of chests, big key chests,
        ; and big key locks. The array is 12 bytes long, and you can
        ; only have 6 chests in one room. 
        ; (because of the layout of save game WRAM and associated code)
        ; 
        ; Note: If the top bit is set, it's a Big Key lock, otherwise it's one of the chest types.

    ; $06EC - 
        ; special object slots for 1.3.0x1C,0x1D,0x33

    ; $06F8 - 
        ; Free RAM

    ============================================================================================================================
    = Page 0x07 ================================================================================================================
    ============================================================================================================================

    ; $0700 - 
        ; Generally is equal to the area number you are in currently in 
        ; times two.Only bottom byte is used, and consists of the
        ; following pattern:
        ; 
        ; yyyzxxx0
        ; 
        ; y - obtained by masking Link's Y coordinate ($20) with 0x1E00,
        ; shifting left three times
        ; x - obaained by masking Link's X coordinate ($22) with 0x1E00,
        ; and bitwise ORing it with the the y bits.
        ; z - this is the overlap of the x and y bits described above.

    ; $0702 - 
        ; Free RAM

    ; $0708 - 
        ; ???? I'm too lazy to document these 4 values, but essentially 
    ; $070A - 
        ; ???? they're masks that determinethe size of each overworld 
    ; $070C - 
        ; ???? "block"
    ; $070E - 
        ; ????

    ; $0710[0x01] - (NMI) Flag for disabling update of core sprite animation for
        ; the current frame, when set to a nonzero value.
        ; 
        ; The point of this is that the NMI interrupt service routine,
        ; even using DMA, can only transfer so many bytes during the
        ; vertical blanking period (roughly 0x1800 bytes at an absolute
        ; maximum), so we can elect to disable many of the low priority
        ; sprite chr updates if we need to move a lot of bytes during NMI
        ; with some specialized routine.
        ; 
        ; Generally speaking, $17 indexes some subroutines that require
        ; this flag to be set, or else we'd run past the blanking period
        ; trying to blit everything to VRAM / oam / CGRAM, etc. Other
        ; operations may also require setting this flag.

    ; $0711 - 
        ; Free RAM

    ; $0712 - 
        ; If nonzero, seems to indicate that it's a smaller overworld area
        ; (512x512 pixels instead of 1024x1024).

    ; $0714 - 
        ; Cache of previous dimension setting (from $0712)

    ; $0716 - 
        ; Forms right and bottom bounding value for where scroll
        ; activates for player?

    ; $0717 - 
        ; ???? Overworld related for sure...

    ; $0718 - 
        ; Free RAM

    ; $0720 - 
        ; flag that if raised means to move to the next line. When text scrolls, this flag also raises but text
        ; remains on the 3rd line unless some command forces it to another line (e.g. [0x01], [2] in the monologue editor.)

    ; $0722 - 
        ; used to indicate which line the VWF is generating text on. (values = 0, 2, or 4)

    ; $0724 - 
        ; used to step through $7EC230[0xC0?] in VWF text generation (start values are 0, 0x40, or 0x80)

    ; $0726 - 
        ; base position in $7F0000[0x7E0]. Only has 3 possible values (0, 0x02A0, and 0x0540) These correspond to
        ; the current line the game is generating text on. It is held constant while an individual line is rendering.

    ; $0728 - 
        ; Free RAM

    ============================================================================================================================
    = Pages 0x08, 0x09 and 0x0A ================================================================================================
    ============================================================================================================================

    OAM Basic 512 byte table:

    ; $0800[0x200] - OAM data. This is blitted to VRAM every frame via DMA.

    How OAM works:

        ; Byte1: X coordinate on screen in pixels. This is the lower 8 bits. See Extended OAM table below
        ; Byte2: Y coordinate on screen in pixels.
        ; Byte3: Character number to use. This is the lower 8 bits. See Byte 4
        ; Byte4: vhoopppc (source: Qwertie's guide)
        ; v - vertical flip
        ; h - horizontal flip
        ; p - priority bits
        ; c - the 9th (and most significant) bit of the character number for this sprite.

    Extended OAM 32 byte table:

    ; $0A00 - 
        ; Each byte contains information for 4 sprites (in the same order
        ; as the normal OAM table.) So, for each sprite:

        ; bit0 : size toggle bit. (this can mean 8x8 or 16x16, or 8x8 or 32x32, etc.
        ; bit1 : 9th (and most significant) bit of the X coordinate.

    ; $0A20 - 
        ; Apparently contains bits of data to combine and write to $0A00
        ; to $0A1F later.
        ; 
        ; Thus, the individual properties are stored in this array,
        ; and ORed in later to form the data that will get blitted to
        ; VRAM.

    Apparently Palette Related, but details lacking:

    ; $0AA0 - 
        ; Seesms as though this variable is cached at various points in
        ; the code, though it doesn't seem to be used for anything
        ; meaningful. Free RAM, perhaps, if the existing code is modified.

    ; $0AA1[0x01] - (Graphics)
        ; Main Tile Theme index.
        ; Altering this has far more effect than $0AA2.
        ; There are 0x25 (37) main BG tile themes.

    ; $0AA2 - 
        ; Auxiliary Tile Theme index.
        ; There are 0x52 (82) auxiliary BG tile themes.

    ; $0AA3 - 
        ; Sprite Graphics index. Note that when in a dungeon, this value is the number
        ; found in the dungeon header, plus $40. Overworlds do not have this complication.

    ; $0AA4[0x01] - (Graphics)
        ; Misc. Sprite Graphics index. Valid values are: 0x01, 0x0A, or 0x0B.
        ; 0x01 - Light world Overworld
        ; 0x0A - Dungeons
        ; 0x0B - Dark World Overworld
        ; All other values are so far assumed to decompress the wrong type of graphics.
        ; I.e., not all the graphics in the rom are de facto compressed. Some are just stored in a
        ; proprietary 3bpp format.

    ; $0AA5 - 
        ; Free RAM

    ; $0AA6 - 
        ; Unused? (but referenced in a few places). It's location would indicate that at one point it
        ; would have been a variable used to configure graphics.

    ; $0AA8 - 
        ; Note: typically only the high byte ($0AA9) of this variable is modified.
        ; By design this variable is only ever set to two values: 0x0000 and 0x0200.
        ; It's used during palette loading to select between the auxiliary palette buffer ($7EC300) and
        ; the main palette buffer ($7EC500) as targets to write colors to.
        ; Only really used in bank $1B

    ; $0AAA[0x01] - 
        ; Confusing variable, relates to $0FC6 somehow

    ; $0AAB - 
        ; Free RAM?

    ; $0AAC - 
        ; Used to load SP-0 (first half) Usually inanimate object sprites. Valid values are 0x00 to 0x0B
    ; $0AAD - 
        ; Used to load SP-5 (first half) Usually for sprites specific to an area / room. Valid values are 0x00 to 0x17
    ; $0AAE - 
        ; Used to load SP-6 (first half) Usually for sprites specific to an area / room. Valid values are 0x00 to 0x17

    ; $0AAF - 
        ; Free RAM

    ; $0AB0 - 
        ; So far only seen referenced in an unreferenced palette routine.
        ; Thus, can be considered Free RAM for now.

    ; $0AB1[0x01] - (Palette)
        ; Used to load SP-6 (second half) Used for the palette for throwable objects

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

    DMA Variables: To see these in action, look up routine $9E0 in the banks files. These are all Word values.

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

    ============================================================================================================================
    = Pages 0x0B and 0x0C ======================================================================================================
    ============================================================================================================================

    Overlord Model (Most if not all arrays are 8 bytes in length)

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
        ; used with special objects in Bank 0x08.

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
        ; For sprites that interact with speical objects (arrows in particular), the special object
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

        ; Autodecrementing timer that any special object can make use of. Its value
        ; decrements by one each frame. It halts at the value zero, but will resume
        ; decrementing if a nonzero value is written to it on subsequent frames. 

    ; $0C72[0x0A] - (Ancilla)

        ; special effect (only known application so far is bomb's direction when laid)

    ; $0C7C[0x0A] - (Ancilla)

        ; Special object floor selector (BG2 or BG1). Analogue for sprite objects 
        ; would be $0F20[0x10].

    ; $0C86 - 
        ; Free RAM?
        ; Starting offset into oam buffer on any particular frame.

    ; $0C90[0x0A] - (Ancilla)
        ; Number of sprites the special effects uses * 4

    # ==============================================================================
    # The Sprite Object Model. All arrays are 16 bytes long since there are 16 
    # sprites per room.
    #
    # Note: also see $0BE0
    # ==============================================================================

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
        ; ; 0xFF - Target is stunned for 0xFF frames (Hookshot/boomerang).
        ; ; 0xFE - Target becomes frozen (Ice Rod effect).
        ; ; 0xFD - Target is incinerated (Fire Rod effect).
        ; ; 0xFC - Target is stunned for 0x80 frames (Hookshot/boomerang).
        ; ; 0xFB - Target is stunned for 0x20 frames (Hookshot/boomerang).
        ; ; 0xFA - Target becomes a blob (Magic Powder).
        ; ; 0xF9 - Target becomes a fairy (Magic Powder).

        ; These are the rest of the values that appear in vanilla but all just do that amount of damage to the sprite.
        ; ; 0x64
        ; ; 0x40
        ; ; 0x20
        ; ; 0x18
        ; ; 0x10
        ; ; 0x08
        ; ; 0x04
        ; ; 0x02
        ; ; 0x01
        ; ; 0x00 

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

    ============================================================================================================================
    = Page 0x0D ================================================================================================================
    ============================================================================================================================

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
        ; 12        ;    
        ; 11     |     13        ;  
        ; 10        ;    |        ;   14    
        ; |        ; 9        ;   |        ;  15 
        ; |        ; |        ; 8 --------------+-------------- 0
        ; |        ; |        ; 7        ;   |        ;  1  
        ; |        ; 6        ;  |        ;  2      
        ; 5    |    3        ;    
        ; 4        ; Distances are of course rough, and relative, as this is text, and the
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

    ============================================================================================================================
    = Pages 0x10 to 0x17 =======================================================================================================
    ============================================================================================================================

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
        ; dma configuration

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



    Setup for making overlaid tiles appear (word addresses):

    Notes on converting in game tile positions into VRAM positions:

    In game layout: (u = unused?)       uuddaaaa abcccccc
    Translated into VRAM base address:  uuuddbaa aaaccccc

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
        ; when leaving / entering doors.

    ; $1CC0 - 
        ; Free RAM

    Text related variables ($1CD0[0x20])

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

    ============================================================================================================================
    = Start of unmirrored WRAM ================================================================================================
    ============================================================================================================================

    Tile Tilemap Format: Vhopppcc cccccccc

    Overworld:
    ; $7E2000[0x2000] - Map16 tile data for the overworld. Supports up to 1024x1024 pixels of tiles
    Note that this is handled somewhat differently than the Map8 data in the dungeons which supports up to 512x512

    Dungeons:
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
        ; ; $0    -> $0 
        ; ; $40   -> $800
        ; ; $80   -> $40
        ; ; $C0   -> $840
        ; ; $100  -> $80
        ; ; $140  -> $880
        ; ; $180  -> $C0
        ; ; $1C0  -> $8C0
        ; ; $280-$2BF -> $140-$17F
        ; ...       -> ...
        ; ; $1000 -> $1000
        ; ; $1040 -> $1800
        ; ; $1080 -> $1040
        ; ; $10C0 -> $1840
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

    Values related to Dungeon Headers:

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
        ; Mirror of $8A ; Only written to when exiting a dungeon
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
        ; weird head looking things at the entrance to the Desert Palace, bombos and ether tablets
        ; SP-0 (second half)  - heavy rocks
        ; SP-1 (first half)   - apples from trees, part of master sword beam, grass around your legs, off color bushes
        ; SP-1 (second half)  - red rupees, small hearts, red potion in shops, some shadows, link's bow
        ; SP-2 (first half)   - numerous special objects (dash dush from boots, sparkles, death / transformation poof), warp whirlpool
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

; ==============================================================================