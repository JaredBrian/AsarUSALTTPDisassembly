#-------------------------------------------------------------------------------
# Name:        zelda_rom_map
# Purpose:
#
# Author:      Dave
#
# Created:     1/09/2014
# Copyright:   (c) Dave 2012
# Licence:     <your licence>
# ==============================================================================

from collections import Counter

import os
import re
import time

# ==============================================================================

def hex_to_int(string):

    return int(string, 16)

# ==============================================================================

def get_file_text(path):

    f = open(path)

    text = f.read()

    f.close()

    return text

# ==============================================================================

def dump_ranges_to_file(path, ranges):

    out_file = open(path, "wt")

    for i in ranges:
        out_file.write("\n0x%06x-0x%06x [0x%x]" % (i[0], i[1], i[1] - i[0] + 1))

    out_file.close()

# ==============================================================================

def dump_calls_to_file(path, calls):

    out_file = open(path, "wt")

    for d in calls:

        counted = Counter(calls[d])

        for i in sorted(counted.items(), reverse=True, key=lambda t: t[1]):

            out_file.write("\n%s %s : count: %3i" % (d, i[0], i[1] ) )

    out_file.close()

# ==============================================================================

def find_gaps(ranges):

    lower_limit = 0x000000
    upper_limit = 0x0fffff

    address = 0

    gaps = []

    # ----------------------------------

    for r in ranges:

        left = r[0]
        right = r[1]

        if (left > upper_limit) or (right > upper_limit):

            raise Exception

        if address < left:
            gaps.append( (address, left - 1) )

        address = right + 1

    return gaps

# ==============================================================================

def merge_addresses(ranges):

    i = 0

    while True:

        if not i < len(ranges) - 1:

            break

        # Now... time to merge any address available.
        range_a = ranges[i]
        range_b = ranges[i + 1]

        if (range_a[1]) == (range_b[0] - 1):

            # Combine their ranges because they are directly adjacent.
            new_range = ( range_a[0], range_b[1] )

            ranges.pop(i)
            ranges.pop(i)

            ranges.insert(i, new_range)

        else:

            # Move on to next index because no more merging can be done.
            i += 1

    return

# ==============================================================================

def search_file_for_ranges(text, address_ranges):

    pos = 0

    # Pattern for locating a comment with two hexadecimal numbers separated
    # by a dash.
    pattern = r"(\;\s*\*?\s*\$)([0-9a-fA-F]+)(\s*\-\s*\$)([0-9a-fA-F]+)"

    range_re = re.compile(pattern)

    temp_text = text[pos:]

    while True:

        m = range_re.search(temp_text)

        if not m:
            break

        # print m.start() + pos

        pos += m.end()

        temp_text = text[pos:]

        left  = hex_to_int( m.group(2) )
        right = hex_to_int( m.group(4) )

        # print m.group()

        if left > right:

            print "Ordering problem in range:"
            print "Left:  0x%06X" % (left)
            print "Right: 0x%06X" % (right)

            raise Exception

        address_ranges.append( (left, right) )

    return

# ==============================================================================

def search_file_for_calls(text, calls):

    pos = 0

    # Pattern for locating a call or jump
    pattern = r"(jsr|jsl|jmp|jml)( )(\$[0-9a-fA-F]+)"

    range_re = re.compile(pattern, re.IGNORECASE)

    temp_text = text[pos:]

    while True:

        m = range_re.search(temp_text)

        if not m:
            break

        # print m.start() + pos

        pos += m.end()

        temp_text = text[pos:]

        call_type = m.group(1).lower()

        call_targ = m.group(3)[:]

        calls[call_type].append(call_targ)

    return

# ==============================================================================

address_ranges = []

calls = { "jsr" : [], "jsl" : [], "jmp" : [], "jml" : [] }

def main():

    # -----------------------------

    start_time = time.time()

    directory = ".."

    for f in os.listdir(directory):

        if re.search(".+\.asm", f):

            print f

            path = os.path.join(directory, f)

            text = get_file_text(path)

            search_file_for_ranges(text, address_ranges)

            search_file_for_calls(text, calls)

    address_ranges.sort()

    merge_addresses(address_ranges)

    gap_ranges = find_gaps(address_ranges)

    dump_ranges_to_file("./ranges.txt", address_ranges)

    dump_ranges_to_file("./gaps.txt", gap_ranges)

    dump_calls_to_file("./calls.txt", calls)

    end_time = time.time()

    print "Took %f seconds" % (end_time - start_time)

    return

# ==============================================================================

if __name__ == '__main__':
    main()
