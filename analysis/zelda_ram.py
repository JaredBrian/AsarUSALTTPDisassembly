#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:     
#
# Author:      Dave
#
# Created:     22/07/2012
# Copyright:   (c) Dave 2012
# Licence:     <your licence>
# ==============================================================================

import re
import time

# ==============================================================================

def get_actual_addr(string):
    
    value = int(string, 16)
    
    # handle direct page locations and those that are usually specified with
    # 2 bytes rather than 3. (Locations $7e0100 to $7e1fff are usually
    # specified this way.)
    if value < 0x7e0000:
        value += 0x7e0000
    
    return value
    
# ==============================================================================

def get_length(string):
    
    return int(string, 16)

# ==============================================================================

def set_flags(flags, addr, length):
    
    index = (addr - 0x7e0000)
    
    # ------------------------------
    
    for i in range(index, index + length):
        
        flags[i] = True

# ==============================================================================

def get_file_text(path):
    
    f = open(path)
    
    text = f.read()
    
    f.close()
    
    return text

# ==============================================================================

def get_unlisted_ranges(flags):
    
    length       = 0
    total_length = 0
    
    # ------------------------------
    
    for i in range(0, len(flags)):
        
        if flags[i] == False:
            
            if (length == 0):
                
                address = 0x7e0000 + i
            
            length += 1
            
        else:
            
            if (length > 0):
                
                print "Unmapped: $%x[0x%x]" % (address, length)
                
                total_length += length
                
                length = 0
    
    print "Total Unmapped Length: 0x%x" % (total_length)

# ==============================================================================

def main():
    
    flags = [ False ] * 0x20000
    
    text = get_file_text(r"../Zelda_3_RAM.log")
    
    # -----------------------------
    
    entries = re.findall(r"\$([0-9a-fA-F]{2,})\[0x([0-9a-fA-F]+)\]",
                        text)
    
    for e in entries:
        
        time.sleep(0.001)
        
        addr = get_actual_addr(e[0])
        
        length = get_length(e[1])
        
        set_flags(flags, addr, length)
    
    get_unlisted_ranges(flags)

    
    return

# ==============================================================================

if __name__ == '__main__':
    main()
