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
    
    # get rid of the colon in the middle
    string = string[0:2] + string[3:]
    
    value = int(string, 16)
    
    if value < 0x7e0000 or value > 0x7fffff:
        raise StandardError
    
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
    
    unused_range = ( 0x7e0000, 0x7fffff )
    
    flags = [ False ] * 0x20000
    
    text = get_file_text(r"./temp_sm_ram_map.log")
    
    start = 0
    end   = len(text)
    
    # -----------------------------
    
    while True:
        
        m = re.search("""
                      (7[efEF]\:[0-9a-fA-F]{4})
                      (
                        (\s*-\s*)
                        (7[efEF]\:[0-9a-fA-F]{4})
                      )?""",
                      text[start:end],
                      re.X)
        
        if not m:
            break
        
        """
        print m.group()
        print "Start: %d, End: %d" % (start, end )
        """
        
        start += m.end()
        
        time.sleep(0.001)
        
        try:
            
            if m.group(4) == None:
                
                # Not a range, but a single byte
                
                addr   = get_actual_addr( m.group(1) )
                
                length = 1
                
            else:
                
                # Range of addresses, inclusive
                
                addr = get_actual_addr( m.group(1) )
                
                end_addr = get_actual_addr( m.group(4) )
                
                if end_addr < addr:
                    raise StandardError
                
                length = (end_addr - addr) + 1
        except:
            
            # Improper address or range
            continue
        
        set_flags(flags, addr, length)
    
    get_unlisted_ranges(flags)
    
    return

# ==============================================================================

if __name__ == '__main__':
    main()
