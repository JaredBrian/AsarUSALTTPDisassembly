
; ==============================================================================

    ; \note First block of dialogue data.
    ; $E0000-$E7F29 DATA
    {
        
    }
    
; ==============================================================================

    ; $E7F2A-$E7FFF NULL
    ; ZScream uses this space as an extention of the dialog data block above.
    pool Null:
    {
        padbyte $FF
        
        pad $1D8000
    }

; ==============================================================================
