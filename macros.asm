macro fill addr
    if $addr > .
        org $addr
    elif $addr < .
        warning "Overflow detected at", .
    endif
endmacro

macro data_end
    nop ; A nop opcode (EA) marks the end of most data sections
endmacro

macro asset type, name
$name:
incbin "$OUT/$type/$name.bin"
endmacro

macro asset_j type, name
$name:
incbin "$OUT/$type/$name" + "_j.bin"
endmacro

macro pos reg, x, y
LD$reg #(($y) * 0x20 + ($x)) * 2
endmacro
