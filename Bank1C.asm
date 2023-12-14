
; ==============================================================================

; \note First block of dialogue data.
; $0E0000-$0E7F29 DATA
{
}
    
; ==============================================================================

; $0E7F2A-$0E7FFF NULL
; ZScream uses this space as an extention of the dialog data block above.
pool Null:
{
    padbyte $FF
    
    pad $1D8000
}

; ==============================================================================
