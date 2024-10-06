; ==============================================================================

; WRAM Map
; WIP will eventually replace the RAM.log

; ==============================================================================

struct WRAM $7E0000
{
    ; $00-$0F
    .Work: = $00
        ; Generic work RAM. Should not be used for anything that needs to be used
        ; accross multiple frames.
}

; ==============================================================================